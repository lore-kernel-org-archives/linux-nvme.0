Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AB3E77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7ql+OSqJfj84/r/VppX6gzv+9w1BxVrKvnHJw1qL3U=; b=eI+ZiA+CgOvNowd1Rb2TcJ0kj3
	uK+O6ohES/AyeKMcksm9OdkAassy+FHIF+61Je/Kb1sys+e7JfdEJlGwXV2H/3+CzDX7nnmDEVwMh
	RFN2mBSNBvAtg/rzI3N2e6erdyp1GxH130nUEJ6MVFnHNjyR2r+JJNaF1SKw0VuMVRRhj4puIq3OL
	bjm7oUGCjk11uw5Kd0Exb9X5pDNyfCAjZNXmNfZo25aMhSHKDurKaw+vlB8iusXsVAPyHClgxPtXi
	wrMLQtbgHq3k5SVKLwEHfnKmuREVhC5WQjnPCyzMvNt1qSOmxx9NwgWbw8dqnj8eLbtmm4TLgkP3r
	ORj1Jr8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVXxp-00000008xuA-0OVs;
	Wed, 08 Jan 2025 15:27:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVXxm-00000008xsF-3SIV
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 15:27:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A05568BFE; Wed,  8 Jan 2025 16:27:06 +0100 (CET)
Date: Wed, 8 Jan 2025 16:27:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 03/10] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <20250108152705.GA24792@lst.de>
References: <20250108092520.1325324-1-hch@lst.de> <20250108092520.1325324-4-hch@lst.de> <Z35T8xeLxhXe-zAS@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z35T8xeLxhXe-zAS@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_072718_995921_D5306934 
X-CRM114-Status: GOOD (  14.67  )
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

On Wed, Jan 08, 2025 at 06:31:15PM +0800, Ming Lei wrote:
> > -	if (!(q->limits.features & BLK_FEAT_POLL) &&
> > -			(bio->bi_opf & REQ_POLLED)) {
> > +	if ((bio->bi_opf & REQ_POLLED) && !bdev_can_poll(bdev)) {
> 
> submit_bio_noacct() is called without grabbing .q_usage_counter,
> so tagset may be freed now, then use-after-free on q->tag_set?

Indeed.  That also means the previous check wasn't reliable either.
I think we can simple move the check into
blk_mq_submit_bio/__submit_bio which means we'll do a bunch more
checks before we eventually fail, but otherwise it'll work the
same.


