Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D70EC636CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vy++B9D2CSRhmYf/Pm24UD9zU5zS7MXfM4rqPs/UvOc=; b=20J0jqq27ImLhx0A/63gf2EUlA
	yQgxkcJM8ID+pIHmuE+XoBe/VOGKJw5XRxkrQLjlNknq+6WBoktVHY02TJp7zsjzO5vWpchHxJJdu
	p/m3IHHw6LGIcEA40fcBuEDcWCIe8DNzNtrvAd1bMmdGl1HxnQ6RcZqXo/NXYctwtDdt1JYILoWce
	+rx7XUSv9vRY1xdXavTiK1GB98By5c9ExeZSvaYFUqzyWI5gSisIzdKdL6R1ZnqkMvQRJIrmhsuVe
	uZg+rxmifqAzkDcJCCX6uVyKQHGuZo9VJ3Do20XvWe+X5L1W/F8nDCYB0U30QKGcFY0z1tnirvEzK
	VwoF9BdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMtAy-008cJ7-OI; Tue, 31 Jan 2023 16:08:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMqx4-008Auv-Pb; Tue, 31 Jan 2023 13:45:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7B4968B05; Tue, 31 Jan 2023 14:45:22 +0100 (CET)
Date: Tue, 31 Jan 2023 14:45:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ilya Dryomov <idryomov@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
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
Message-ID: <20230131134521.GA24165@lst.de>
References: <20230130092157.1759539-1-hch@lst.de> <20230130092157.1759539-2-hch@lst.de> <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_054534_992976_614A95E2 
X-CRM114-Status: GOOD (  12.27  )
X-Mailman-Approved-At: Tue, 31 Jan 2023 08:07:03 -0800
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

On Mon, Jan 30, 2023 at 09:09:23AM -0800, Bart Van Assche wrote:
> Has it been considered to use structure assignment instead of introducing 
> bvec_set_page(), e.g. as follows?
>
> bip->bip_vec[bip->bip_vcnt] = (struct bio_vec) {
>       .bv_page = page, .bv_len = len, .bv_offset = offset };

Unless it's hidden behind a macro it doesn't solve the problem of
abstraction away the layout.  I'm also find it less readable.

