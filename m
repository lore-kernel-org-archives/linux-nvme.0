Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BD8CFD352
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gdk3MXtKexJxO0LMeJ+wZOKbgQRan2+EJr5tl3E3N5A=; b=NBBbSxA/XsheqyiwCdcPu0zPZ0
	T9U8UsDrQUlYF00tZt2dmw8OjVxVL8kKCwg6dDQkY3wcvNjsNAARezvhdeCc4pGBTTfP3SvixZ2ZQ
	lVQeYtJ/68mynqeNfEmS/rXNJY0RBGzTV/Wa72ZH1I4BFvGjG7+zhumNOQuPMTka/dhr12HRTceRE
	WLZE+ivEOWZczKb2nki6BOA6N3nJaIIPulO9ncmfBVsD0vCFQal0fy8skBsF4t+epyMr1fRnTtIPj
	9kbvjv4gArmHxALnxcet+aucbDbqYICjl6kAfjTOtMwGCN8BJZ7MYsc1MiANOvaiFV6LQ8KdfQOZO
	GaofzWZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcbx-0000000CGXr-1K9H;
	Mon, 24 Nov 2025 19:52:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcbv-0000000CGXE-1xo4
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 19:52:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C71A043896;
	Mon, 24 Nov 2025 19:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D10C4CEF1;
	Mon, 24 Nov 2025 19:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764013950;
	bh=P+lPYqigJMSESrgqokiVFRgcZyffRySe7GZFd7iwdu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l29icPDFHOtS5Gwa6qfvrGFSyHPBR9J3v8UjT7XXqznC/lSD4U8nDJuT5S3EPS2AN
	 D+k0LjPlXXDRLxZCW6IaiQry00Tk8B1rAscYnxINenfI5Fy41moXp0IbccL4/gnQKW
	 ahMSloHywjUaenZ88Fb0zNMQwYnPURsxpIkFELuTNnr4I/eTTDFmTUPmni5EPsK6f4
	 OETNbSIwE+Owg0W9uD+ubn6nnhDA5lsZgZ980blG+iVSs6Ep8aTETd+Rp65Zg2CraW
	 +bKq6T39cf9Ex3y4LJR0kanDhPvu8EmU61OqqgaGNtagieA0TgTfyFBmDDgvUM7Sdj
	 WTnQG61o5KBCQ==
Date: Mon, 24 Nov 2025 12:52:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Thomas ten Cate <ttencate@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: "controller is down; will reset" on SK Hynix NVMe drive in
 Lenovo IdeaPad Pro 5
Message-ID: <aSS3fP1pnWvEHFLh@kbusch-mbp>
References: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
 <aRzb6U1se40SrQRM@kbusch-mbp>
 <CACbz5yE1RNmJkg-RSBe2u60Y5yd1zxkEZ=pVy_gTa2JLh9d5xQ@mail.gmail.com>
 <aR-CUUzWzQKIAfqx@kbusch-mbp>
 <CACbz5yE52zBkN_mhMhY_bA62z0Fajt3K+K65Fyf8bWBd13yC-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACbz5yE52zBkN_mhMhY_bA62z0Fajt3K+K65Fyf8bWBd13yC-Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_115231_528227_34BBD92B 
X-CRM114-Status: GOOD (  14.53  )
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

On Fri, Nov 21, 2025 at 02:06:23PM +0100, Thomas ten Cate wrote:
> On Thu, Nov 20, 2025 at 10:04 PM Keith Busch <kbusch@kernel.org> wrote:
> 
> I tried adding the following to linux/drivers/nvme/host/core.c, in the
> core_quirks[] array. It takes a model name, not a device id, which I
> took from /sys/class/nvme/nvme0/model.
> 
> {
>   .vid = 0x1c5c,
>   .mn = "SKHynix_HFS001TEJ4X112N",
>   .quirks = NVME_QUIRK_NO_APST,
> }
> 
> With NVME_QUIRK_NO_DEEPEST_PS, it still hung almost immediately. With
> NVME_QUIRK_NO_APST, it appears to be stable.
> 
> Would you like me to send a patch?

Sure, but I think it'd be more universal to apply the quirk to the
nvme-pci driver's pci device table than to make it based on the model.
It's common for a model name to be different for various capacities, but
I suspect the power behavior is more generic than that, which should be
common with the device ID.

