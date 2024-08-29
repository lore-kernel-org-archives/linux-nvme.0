Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2437BC7115E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 04:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vQBf6hUxODW2TQGaEOqg3arbqkkvB4gB3AOolX03Tdw=; b=btPtdtPIkww8u3Doeu88tJKvFp
	voBoO5VTDb1EBEPPQriJKzTFyG4eVngtQJf+NlQ3belxJy3k/pIs7yMHC0DTVEQSdRIjAoLtp06ln
	79A719E6SQf+rv4qh3rjYhrn19JMCmVHgez1M+gNod7rMh1IoR5cOaqeS4Zc89gLt5tdqXw97AwG2
	Zr/dvUu0VDKcw2Zmb9Mq5pmFyoZcxqVmiS7amh+bxC3ccJc+Y+/0O/xpsqWmnA0aZggq0XvS+cc9G
	M9BW+10uY3meCFmUO5oxAlrZXhjriivqOgrTuGNVARAKSBhFVBdpwwkB2u9+VrWOmxOx/28PvI8ft
	MBPEhWig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjWlh-00000000U20-323N;
	Thu, 29 Aug 2024 04:28:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjWle-00000000Tyu-3XAu
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 04:28:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0547768AFE; Thu, 29 Aug 2024 06:28:15 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:28:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Puranjay Mohan <pjy@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <20240829042814.GA4644@lst.de>
References: <20240827132327.1704-1-pjy@amazon.com> <Zs8360kRPGa1B5xy@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8360kRPGa1B5xy@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_212819_049155_D11D3389 
X-CRM114-Status: GOOD (  16.53  )
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

On Wed, Aug 28, 2024 at 08:44:59AM -0600, Keith Busch wrote:
> On Tue, Aug 27, 2024 at 01:23:27PM +0000, Puranjay Mohan wrote:
> > @@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
> >  	struct request_queue *q = req->q;
> >  	struct nvme_ns *ns = q->queuedata;
> >  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
> > +	bool has_metadata = bdev && meta_buffer && meta_len;
> 
> If this is an admin command, then bdev is NULL, so "has_metadata" is
> false.
> 
> Since has_metadata is false, we continue on to process this admin
> command, but ignore the user's metadata settings. Do we want to return
> error there too?

Ah yes.  I had my brain wrapped around this the wrong way the
entire time.

Maybe a 

	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
	bool has_metadata = meta_buffer && meta_len;

might help poor brains like mine.

