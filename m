Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87904EB64D8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=maoLH1+iFdOHtUfb3uVlDmFpd4ojetev/CDoWNYqeqE=; b=XzcqYcNaSejCkjVH25QHKIjxBG
	wJwHWWJLw/4Wb4LljgosdN2Gy7f898ss0iidwktXEnQNEYCZaf8hG2YR4vq2zBydN+gqXHK52RVcM
	lQQczwt9ugMpMw4j4MakHvirdalNaiBuIeI0bQJsUXFPPcA6FhuHwTKzInTXKn57lNxQW39QHXxDh
	q4Glq4QSbg/UDYUUjZQsKf7rXSKlaDhtv2OYaLEVlpp0TOQ4B34o6dq9xAEUN5FZtMGGHCJ8sG3T/
	FuMw5pv4xqnPNbQrT1RCdr9+SHeADgxz2VspGrZrnsfJqlFS4U5mubl5dt5truNAbWd2E7No58j0+
	fwh2XBXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbSc-00BOnr-1Q;
	Tue, 20 Jun 2023 13:31:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qABNV-000xGk-0S
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jun 2023 15:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686929324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=maoLH1+iFdOHtUfb3uVlDmFpd4ojetev/CDoWNYqeqE=;
	b=RFg8mGr8mYM+4jG2RXF9FeDNQ3zQSMr7ShkAAtAvC/OzhsvfYemCLC8HKuNeittb9SfL1z
	DBlXOF8AhPvQqElCKAKCR2fDH7ocIqaxZf9MhY1QmDRg1y0V4FMQf8BsRSXb7vIOhsC4aq
	Q0Likkw+Ulvmx+08rQ/jDVkFNkY/jOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-VwVwMy6RNq2uvUCKs61D4w-1; Fri, 16 Jun 2023 11:28:36 -0400
X-MC-Unique: VwVwMy6RNq2uvUCKs61D4w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4AFF85A58A;
	Fri, 16 Jun 2023 15:28:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C62E748FB01;
	Fri, 16 Jun 2023 15:28:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <51161740e832334594960ed43430b868a6f892c3.camel@gmail.com>
References: <51161740e832334594960ed43430b868a6f892c3.camel@gmail.com> <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-4-dhowells@redhat.com>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: dhowells@redhat.com, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    David Ahern <dsahern@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Jeroen de Borst <jeroendb@google.com>,
    Catherine Sullivan <csully@google.com>,
    Shailend Chand <shailend@google.com>, Felix Fietkau <nbd@nbd.name>,
    John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
    Mark Lee <Mark-MC.Lee@mediatek.com>,
    Lorenzo Bianconi <lorenzo@kernel.org>,
    Matthias Brugger <matthias.bgg@gmail.com>,
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
    Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
    Chaitanya Kulkarni <kch@nvidia.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    linux-arm-kernel@lists.infradead.org,
    linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next 03/12] mm: Make the page_frag_cache allocator alignment param a pow-of-2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <617058.1686929309.1@warthog.procyon.org.uk>
Date: Fri, 16 Jun 2023 16:28:29 +0100
Message-ID: <617059.1686929309@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_082845_259553_BF12DEC9 
X-CRM114-Status: GOOD (  18.65  )
X-Mailman-Approved-At: Tue, 20 Jun 2023 06:31:53 -0700
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

Alexander H Duyck <alexander.duyck@gmail.com> wrote:

> The requirement should only be cache alignment, not power of 2
> alignment.

Sure, but, upstream, page_frag_alloc_align() allows the specification of an
alignment and applies that alignment by:

	offset &= align_mask;

which doesn't really make sense unless the alignment boils down to being a
power of two.  Now, it might make sense to kill off the align_mask parameter
and just go with SMP_CACHE_BYTES (which will be a power of two).

Note, though, that most users seem to use an align_mask of ~0u which feels a
bit dodgy (it's not an unsigned long), but is probably fine.

David


