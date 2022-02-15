Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80EDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4j6YcMQ+/aGLTz1M18kZKsEcPuNovrJW30rItZ8Q2Fc=; b=lUxFGhqkrs4km9QFtXnb4ETsJL
	b+93HgM1bAkXj2fBIJtTp12RdhycOe6wtSKTks9ld+FUbceQ9AlCVDmKQnRYa52ahIeo1xyn3pAgV
	bGEr1fb2dUmWg3MhVTPbttEmQysXYK29oGtV8F/2AW+iQIRGSNbhXVUOCYMA+iGUijd3fmAhp5vE/
	6q66fqm+VEW5qjnh9Blv7D/5hXES7yFQjIPFNt4g5mWIpEFGo67/VttheXD0f5aUycy/mdNqWwDj7
	7Vwu8C0AXhG7iVZFRCTWUT2IVKT6NjJQRwqr2mldXc+BnJRBl6OE0NZIqKVUzqm9wvxzA0XHgSA9g
	Ev0eadkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK3I1-004FoR-IC; Tue, 15 Feb 2022 19:15:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK3Hy-004Fmc-P8
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 19:15:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8E429B8124E;
 Tue, 15 Feb 2022 19:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36CBC340EB;
 Tue, 15 Feb 2022 19:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644952499;
 bh=AjJtRhsxaMSmw5bCKP9unHA02aPAd54DWxZLx21Wz6M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o/Oe5c/72fDzB3xtvF/HWUtrR4/Pl3HqbbE/VMGjrs07aQhZNPWjF2EkhDhCfzRtO
 EHueLKYLA4M7CQLQKG0cOmXYT72Dscuo7STaTpYQpuL5kOb/JJxHjZlU76eXQfWFB+
 LQl3V/C9dIX/Pi+erkqAyJVSZjYk/FrvbQZQnRyNNRmjHYkBu9pqHZUjeE0MWbCt8i
 Koc01uXydjUxaYFXkGYxldhM212ffpI6zgD7wy/ogAkltZtpodQmM0zY4x9TKiH1rP
 bntDyx4HJ+DhwmexzG/asgjqAEf51Izas/3RtVToyGQR5aJKgrqyV3N7niQE4Z35aB
 JSgPRFsQiTlJQ==
Date: Tue, 15 Feb 2022 11:14:56 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215191456.GB1934598@dhcp-10-100-145-180.wdc.com>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
 <20220215152240.GB1663897@dhcp-10-100-145-180.wdc.com>
 <20220215184704.GB24543@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215184704.GB24543@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_111502_982488_E5C5E881 
X-CRM114-Status: GOOD (  21.93  )
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

On Tue, Feb 15, 2022 at 07:47:04PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 15, 2022 at 07:22:40AM -0800, Keith Busch wrote:
> > I can't actually tell if not checking the DYING flag check was
> > intentional or not, since the comments in blk_queue_start_drain() say
> > otherwise.
> > 
> > Christoph, do you know the intention here? Should __bio_queue_enter()
> > check the queue DYING flag, or do you prefer drivers explicity set the
> > disk state like this? It looks to me the queue flags should be checked
> > since that's already tied to the freeze wait_queue_head_t.
> 
> It was intentional but maybe not fully thought out.  Do you remember why
> we're doing the manual setting of the dying flag instead of just calling
> del_gendisk early on in nvme?  Because calling del_gendisk is supposed
> to be all that a tree needs to do.

When the driver concludes new requests can't ever succeed, we had been
setting the queue to DYING first so new requests can't enter, which can
prevent forward progress.

AFAICT, just calling del_gendisk() is fine for a graceful removal. It
calls fsync_bdev() to flush out pending writes before setting the disk
state to "DEAD".

Setting the queue to dying first will "freeze" the queue, which is why
fsync_bdev() is blocked. We were relying on the queue DYING flag to
prevent that from blocking.

Perhaps another way to do this might be to remove the queue DYING
setting, and let the driver internally fail new requests instead? There
may be some issues with doing it that way IIRC, but blk-mq is a bit
evolved from where we started, so I'd need to test it out to confirm.

