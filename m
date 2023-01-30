Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423F1C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oT4/+Dsw5hQNhjDNcfeDL08lroMdeVaKhV4kansN0pA=; b=M3qtGY1G/V4bdd8bK897XsNM80
	Nh7OPekNnOl1fppE5VAANEA2OuImHQDKAZiM0GI5xxw6TlENo0P7EcGr2BiP0SwoBCEUoAvcDan32
	LHF2hwehRVFejCc8SWaccvxGVYt6N8wW3PaFFqmar8bGmoGjJzsCA2LhFwyPxqgGZb2XTzRPvO088
	7BGJ7xRwxNfpmQOY1FSZeXULNlGQmXOmtgjtQZEQjKmKX0yaontY5jEqp7VoRlry1rfrKtyAvwosr
	htn5rMryh9w8JPw6qqhFVlIXOJeMB4PyQS/pLGZcbLMN2C1SyWa8NhoDgEv5XxFM/MJnTPntin+k0
	XHvhSuYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMT6I-003TDR-5H; Mon, 30 Jan 2023 12:17:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMRTy-0038yP-FX
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 10:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675074829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oT4/+Dsw5hQNhjDNcfeDL08lroMdeVaKhV4kansN0pA=;
	b=YfHn7bHaxwhcZ/tpq1adMY0IC3kseQUAJJi45LGGyu6FZYayjR3e3p4kZDJs0G2AxZXA5W
	C0Ix9mNBh+uleOduoSJdRdcyOdQj4EfvMaIolstiCZ9wgW6RIivHQxLn2kntXW1znQ4pXY
	3WvvwqviJPUN0UW9LgugVmWc9WpHyT4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-2Q7zrrTIPmSvdtNBIoEfxQ-1; Mon, 30 Jan 2023 05:33:43 -0500
X-MC-Unique: 2Q7zrrTIPmSvdtNBIoEfxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23F6E85A5A3;
	Mon, 30 Jan 2023 10:33:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64AB01121314;
	Mon, 30 Jan 2023 10:33:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230130092157.1759539-2-hch@lst.de>
References: <20230130092157.1759539-2-hch@lst.de> <20230130092157.1759539-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Ilya Dryomov <idryomov@gmail.com>,
    "Michael S. Tsirkin" <mst@redhat.com>,
    Jason Wang <jasowang@redhat.com>, Minchan Kim <minchan@kernel.org>,
    Sergey Senozhatsky <senozhatsky@chromium.org>,
    Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
    Chaitanya Kulkarni <kch@nvidia.com>,
    "Martin K.
 Petersen" <martin.petersen@oracle.com>,
    Marc Dionne <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>,
    Steve French <sfrench@samba.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Anna Schumaker <anna@kernel.org>,
    Mike Marshall <hubcap@omnibond.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Chuck Lever <chuck.lever@oracle.com>, linux-block@vger.kernel.org,
    ceph-devel@vger.kernel.org,
    virtualization@lists.linux-foundation.org,
    linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
    target-devel@vger.kernel.org, kvm@vger.kernel.org,
    netdev@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
    linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
    devel@lists.orangefs.org, io-uring@vger.kernel.org,
    linux-mm@kvack.org
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3347556.1675074816.1@warthog.procyon.org.uk>
Date: Mon, 30 Jan 2023 10:33:36 +0000
Message-ID: <3347557.1675074816@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_023350_597590_2CECE29F 
X-CRM114-Status: GOOD (  16.31  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 04:16:45 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Christoph Hellwig <hch@lst.de> wrote:

> +static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
> +		unsigned int len, unsigned int offset)

Could you swap len and offset around?  It reads better offset first.  You move
offset into the page and then do something with len bytes.

David


