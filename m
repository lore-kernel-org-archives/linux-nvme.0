Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57AEE77188
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2025 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gt8OXPPuddA1H17xFc6d0SWz9y6Zvt3VIXojKtzxoyM=; b=hi88wZnOjaVU2xoenNacOhmsn6
	QofzKPnNOHb/XFHNDMADfB+MbwaYhR+kV6uQf57jhQkZ33mPWahcDD/55p/90N9cGzMkop6se+XF4
	5GqvAbk9jSCY1DdS2cLJtxTBqqE+alk7LI7xyq14cUz05mFgSI/nkw2mGA+Rhs3HjDB8U5m6HePB0
	N5RC39ogq98FqqilnooayzSNyOhgUi01RrN1qvvF9NATHwJFDzYOAzVMKIVhb91YT2wfOGdV4FvL7
	ZspEMProETxzgw66mj9FVMIReuTsEu8AzDypLKplgC+iZL6lTbLZHjgsGqNYs3IfHL9NLwucxhJkv
	9aTBoIIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTHqs-0000000A5td-0ld6;
	Thu, 02 Jan 2025 09:50:50 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTHps-0000000A5jq-1obX
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jan 2025 09:49:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1A82AA40A4E;
	Thu,  2 Jan 2025 09:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2992C4CED6;
	Thu,  2 Jan 2025 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735811387;
	bh=tXfAAU26K170fcnqh0owN8PXAjsnMTBCFumiGjaOeBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jymOAf3D7m3mfa7J4H+4AdQp8u9ITBFukQZjQSGCcf1jCIi+tFh8LUPsn93CKUekn
	 ZV+A3NPZPdfCraH+d/Df8654DTUCWxocnkDuxolncQhl6spIpsAgKyCU6S0/vd+FPo
	 fM+UTBqmZag9Re3Wm509djGWaeGHZGqbHDI/1lMV9dUloHcwcZM5hZ/2pBOCyoPbXD
	 a2QgPtWadwW1B1HFWk37zRFS8bWsstfnpydiYRy7k+2ZSi/vyfWAqp/uu7C3tJlkfG
	 djL+YkI4j1sLsY3lz31p9rzKQ8EhaRP45bHWa57AUvECyfDSI0mBWdfkYR4gBscK2p
	 i06VwGFRO/JNg==
Date: Thu, 2 Jan 2025 10:49:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z3ZhNYHKZPMpv8Cz@ryzen>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217065614.GA19113@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_014948_535171_1C4D6857 
X-CRM114-Status: GOOD (  14.13  )
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

Hello Oliver, Christoph,

On Tue, Dec 17, 2024 at 07:56:14AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 17, 2024 at 02:55:23PM +0800, Oliver Sang wrote:
> > from below information, it seems an 'ahci' to me. but since I have limited
> > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > please let us know. thanks a lot!
> 
> Yes, this looks like ahci.  Thanks a lot!

Did this ever get resolved?

I haven't seen a patch that seems to address this.

AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
reordering when issuing a batch of commands, my guess is that the problem
also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
or block layer.


Kind regards,
Niklas

