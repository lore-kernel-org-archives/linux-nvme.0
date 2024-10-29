Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15A4D3A661
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TE70MYQ0B+lc0orw4kXvKuoEvWJaplrMd4o3fFl+Uw=; b=EjFYwulMzj+2irdNuxCqJPDvFU
	avj90mpRn4jArpskP6LxMDMuIEaV0ELfK52tossK36sbkYR7cP8EPgZGTxZipENR1ZKgA8lWe5WD7
	Ld/dmAIA2GnpOzDQcJXEl3kTvJ7siHBqHx21YYxeRwGDm70LoZ2b3NCgwlQ8d/DV1fCA7iNdyOk36
	b6bzBiABr2H03kiUmTZ7og/m9KVwMGyz8e6Iza7IP3uW4SNskXrNxRArZxDf1OCbJz6T0Be/JYpaP
	LTKsQA6bWdSHI7V0QhJF173mDqkFjmU8/L9lXCIaYnTRoX1E4UFnrECKtw/mS5alKxJgei0kycOzz
	xfpdtBxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oQj-0000000EzKg-4BLB;
	Tue, 29 Oct 2024 15:46:50 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oEV-0000000EwQG-1bKd
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:34:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 798D0A42A34;
	Tue, 29 Oct 2024 15:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A7DC4CECD;
	Tue, 29 Oct 2024 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730216050;
	bh=xGZIo//+rd5EBLgfh1sz1cn7TPzNY0b3vgJcMFqWpsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKMZcW8sQFWxRSd3qgVIcjnTz4uwpTSxTNx15MUBFfRZkSQJ8Rl9WuB7YBxEPmV40
	 WHC02F4hb3r9/hQhfVTHnuuxWYFhfurX+RuGsUi1At+rmEmjj3mgKy82m1969vV9+1
	 F2HIjcPy6SNENoihV2/ZDUCcjFokBmMnl6Lb+IrYd+TwT+xcBhwCDhxyQ5Pn/ciHcZ
	 4IKjJZlFT31bKKU9bnR9ik3sf4d6QePkswE6uyo20RAnJHBWVVRN2fuN9Clmdp2Ri6
	 y6TFOHJPXLPx8FIeSFwRBvmM9yH/7H+b8Vy9f+JDF/v4Q8K9G6vVethOi/xt9oDq/S
	 QVWr2m9MGX6Mg==
Date: Tue, 29 Oct 2024 09:34:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyEAb-zgvBlzZiaQ@kbusch-mbp>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-10-kbusch@meta.com>
 <20241029152654.GC26431@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029152654.GC26431@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_083411_507593_78687D29 
X-CRM114-Status: GOOD (  16.29  )
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

On Tue, Oct 29, 2024 at 04:26:54PM +0100, Christoph Hellwig wrote:
> On Tue, Oct 29, 2024 at 08:19:22AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The block limits exports the number of write hints, so set this limit if
> > the device reports support for the lifetime hints. Not only does this
> > inform the user of which hints are possible, it also allows scsi devices
> > supporting the feature to utilize the full range through raw block
> > device direct-io.
> > 
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> Despite the reviews this is still incorrect.  The permanent streams have
> a relative data temperature associated with them as pointed out last
> round and are not arbitrary write stream contexts despite (ab)using
> the SBC streams facilities.

So then don't use it that way? I still don't know what change you're
expecting to happen with this feedback. What do you want the kernel to
do differently here?

