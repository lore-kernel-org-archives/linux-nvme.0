Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA22D17129
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=1WBD0S9OXIPlmdKmbeAxp+eZ6VfNOYF+FewuHVDh0gY=; b=rPoKbGE6O+xetj
	22xQ67e4+rtIh/ENK+7HM7mD7P4sSnT3/hCtEWFqaSc9xeze+9wHf7RPb1nsniQ3agUmWJfydUvb5
	3ymC8uYBHaHmX1afz0E+/9dunr1qbAszL8iqFuVtqMxYWErtxtFQINDdKdrMf0Kl9K4CzSZND4j0Y
	2Vrokds3eegZrN0lZRuzO2B8v/CK5qQeGl3mIX+zn4UcmpOh91U2IKsdKJMr6L5u8UR4kuDZZ0elk
	0KE7imoB9I+cqvkBfR2azASvXBesRgsbPB62tvBusoUyI1rtD2zs9X4OWMZtHSXxrTDrZD6J0eVId
	yNmCksrgs/dA/7XkCIGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2xto-00000008QCJ-1pm5;
	Mon, 21 Oct 2024 19:17:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2xrJ-00000008Psd-1Emy
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 19:14:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C79075C04BB;
	Mon, 21 Oct 2024 19:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05B2C4CEC7;
	Mon, 21 Oct 2024 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729538068;
	bh=Vp3VyPCEZtRWwIx4AQb+2QWWum+1wrgS2sZgatBVYI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IjSIeixhoW7LrHHtj3D38jNNHgcGJonJznArxuKKaj0syGR2VTke4/VV9Ys+zP4jT
	 d/Laq/3YCgme1Px0rjjUxULUUfiPD0tmvOAq6zhTPs7CpZeZmIegQbCraFvtVMZTaq
	 ooOvisJl2bN78AdIWi61Fqxn38ESfAE9rBjWvMGbFN4WKbuFNMYXuWyV5Q1DZ4doQw
	 5NwTtzW8JvrJE3z+qmgSmH83VrKr4ARei8LXHUlmNG2NclQR0p02CANeD1Xu0UukFJ
	 hTb4Wzud7w1WBbcoA/7BlrF95TuSJZe7IcsuUCH1o5Iq3buVX0BOIIJyiu8SWybhOa
	 yqOJPEtWCi3ew==
Date: Mon, 21 Oct 2024 14:14:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: 6.1.0-17: nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0xffff
Message-ID: <20241021191426.GA842491@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9zADza=73GsuzAcuyH-YfhS34qjkDtuJjGBReVGpfE6KN_ow@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_121429_399382_FFD329FF 
X-CRM114-Status: GOOD (  11.84  )
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

On Fri, Jan 05, 2024 at 09:49:58AM -0500, Justin Piszcz wrote:
> Hello,
> 
> Distribution: Debian Stable x86-64
> Kernel: 6.1.0-17
> 
> Reporting this as requested from the kernel message, I have now
> appended the recommended kernel boot parameters
> nvme_core.default_ps_max_latency_us=0 pcie_aspm=off and will see if
> this recurs.

Hi Justin, did anything ever come of this report?  Is it reproducible?
Did it seem to be related to suspend/resume?

> Jan  5 06:18:52 atom kernel: [295306.524933] pcieport 0000:00:06.0:
> AER: Corrected error received: 0000:00:06.0
> Jan  5 06:18:52 atom kernel: [295306.524979] pcieport 0000:00:06.0:
> PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> Jan  5 06:18:52 atom kernel: [295306.525004] pcieport 0000:00:06.0:
> device [8086:a74d] error status/mask=00000001/00002000
> Jan  5 06:18:52 atom kernel: [295306.525027] pcieport 0000:00:06.0:
> [ 0] RxErr                  (First)
> Jan  5 06:19:22 atom kernel: [295336.554420] nvme nvme0: controller is
> down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> Jan  5 06:19:22 atom kernel: [295336.554469] nvme nvme0: Does your
> device have a faulty power saving mode enabled?
> Jan  5 06:19:22 atom kernel: [295336.554489] nvme nvme0: Try
> "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
> Jan  5 06:19:22 atom kernel: [295336.614521] nvme 0000:03:00.0: Unable
> to change power state from D3cold to D0, device inaccessible
> Jan  5 06:19:22 atom kernel: [295336.614898] nvme nvme0: Removing
> after probe failure status: -19
> Jan  5 06:19:22 atom kernel: [295336.630497] nvme0n1: detected
> capacity change from 7814037168 to 0
> Jan  5 06:19:22 atom kernel: [295336.630502] BTRFS error (device
> nvme0n1p2): bdev /dev/nvme0n1p2 errs: wr 1, rd 0, flush 0, corrupt 0,
> gen 0
> Jan  5 06:19:22 atom kernel: [295336.630513] BTRFS error (device
> nvme0n1p2): bdev /dev/nvme0n1p2 errs: wr 2, rd 0, flush 0, corrupt 0,
> gen 0
> Jan  5 06:19:22 atom kernel: [295336.630542] BTRFS error (device
> nvme0n1p2): bdev /dev/nvme0n1p2 errs: wr 3, rd 0, flush 0, corrupt 0,
> gen 0
> 
> Regards,
> Justin

