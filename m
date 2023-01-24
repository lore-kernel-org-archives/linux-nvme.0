Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312DFC54E94
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l6f081h5KX0dH2iECAl0FsNTkxPBokEoWlTfiPgqpRI=; b=3f3VvEIhCP+sHoo40kI5NH3pHz
	W92u6+toI8NPkncS5v3W2izsP2zWQtPJTi9Xw6xqxS2eyU13dRZ+xkBIaHadGy/NyM1NvW9gRaxnn
	GG7CgsXnP5E85CembFfBx/okPg5SnA9uZ/v+X4I7cxl+G4pqSdeZF/75fGEEX8MJNFeHyO0sq3PDF
	TWpMHOK2OEQj8Q6dzJ7SSp+fMsPlPto5SatI/ZvQlgcKefK0pLax333xNVwlrsE+aDSxSBl4ISuit
	MXXZz1bye3xlvfxzetebAlEJHAXgpILsSU0akqz8h07foA/FMzoE/diEzacaiYFiatVHpou8PbXv4
	HzUw3KwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKLf5-004cce-Pm; Tue, 24 Jan 2023 15:56:39 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKLf3-004cbz-2a
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 15:56:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 88770B81269;
	Tue, 24 Jan 2023 15:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95830C433D2;
	Tue, 24 Jan 2023 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674575794;
	bh=QFLsB9JzqKvY6nPNDIwdmPSNhyi2EdnFP1HCsqJz3cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpRCFrDSqI5jNzzJ0XZ2qQigyajvL3okiqw1XRGNem00t+6zi4LleNjCjB8rkSk97
	 R9L+tm4cCLY1U4MENsk88mSr0yNXXiFdKmgXroHwLh8ObasYdLQl3E4s/t7MB58M37
	 6+TI8ZzMQ4QqGBT7zMlC6IFGCgzhKjLir2ViLI7N9xqteppht2xwmbZGhc+BpuZjhZ
	 L5XUWNBFaIcG3Ig40pCj8PJeGrRHNB3nOqF9mH0jw6KmCzS9h4/praNOEEndhz/gKE
	 GpPy1I7+Y6c7+3T0r3pSdAF9Z8SCtDMaQJysTEIreK6xgKQOHcRu4L0i9AmhlY85MC
	 R8+MhNOXjkJlQ==
Date: Tue, 24 Jan 2023 08:56:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs mount
 regression
Message-ID: <Y8//roUT5byp59UP@kbusch-mbp.dhcp.thefacebook.com>
References: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
 <20230124062140.GA29175@lst.de>
 <Y8+bP2Oqy3B2XyuJ@intel.com>
 <20230124134134.GC25796@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230124134134.GC25796@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_075637_296481_0313C70D 
X-CRM114-Status: GOOD (  17.04  )
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

On Tue, Jan 24, 2023 at 02:41:34PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 10:47:59AM +0200, Ville Syrjälä wrote:
> > On Tue, Jan 24, 2023 at 07:21:40AM +0100, Christoph Hellwig wrote:
> > > Err, no.  We're not going to randomly revert things.  If you want
> > > to be productive check the one liner Keith reported in reply to the
> > > last report.
> > 
> > No idea what that previous report is. Care to share a link?
> 
> https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#m759092f541ea29fcb41911890307e70868636a45
> 
> Patch to test:
> 
> https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#md13c22b29cd81bd0ce9167c271c582005ba30550

I'll post the official patch if someone can let me know if it's
successful. Or I can potentially setup a VM to verify myself, but I
probably won't be able to get to that till next week.

