Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F0DC636CD
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 06:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvQv6Gvrh93BfEGP4pGR6LDQtNde77dAGMLN49gb1bk=; b=cweDA07om2flo3ulm8WzM2w3+U
	tjsahL7GS60YqvUXxf9VEA18WlKmbp/tBdyyUWmNY7HcW7UxynXEepzvpsl9JNFWIMuq2OXVP1DJk
	U2xMrEn9mFIPYovVI/4EYpxg+4X9QHc1vgPPIXnLLWmhtXyoWir86rrWSPwEHKwsOnwp/MfqrIh22
	TuhZLyGOwJ52jv4vcI35VSRp1bwTDaBVMqcCXH3lsdcrX2Ks3o+RLlFzfJgBRxFE9s0YsY9Zg/pwS
	Aw21c0sXAs0KVsRKI4kPJOTLWhOAGhvXKaMLLrz/K17YOwyH++Za/qVOlA/aVKn6GhccDGOgoI/0p
	YbB1rH0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMjju-006NUM-Nh; Tue, 31 Jan 2023 06:03:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMYmK-004wFm-35; Mon, 30 Jan 2023 18:21:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DCD3968D07; Mon, 30 Jan 2023 11:36:19 +0100 (CET)
Date: Mon, 30 Jan 2023 11:36:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ilya Dryomov <idryomov@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <20230130103619.GA11874@lst.de>
References: <20230130092157.1759539-2-hch@lst.de> <20230130092157.1759539-1-hch@lst.de> <3347557.1675074816@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3347557.1675074816@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_102116_339000_7C709632 
X-CRM114-Status: GOOD (  13.99  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 22:03:19 -0800
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

On Mon, Jan 30, 2023 at 10:33:36AM +0000, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > +static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
> > +		unsigned int len, unsigned int offset)
> 
> Could you swap len and offset around?  It reads better offset first.  You move
> offset into the page and then do something with len bytes.

This matches bio_add_page and the order inside bio_vec itself.  willy
wanted to switch it around for bio_add_folio but Jens didn't like it,
so I'll stick to the current convention in this area as well.

