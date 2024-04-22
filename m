Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C8AC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFTLg1FWbQhUEReUEmSx616tImka9TKSXnRCMadk9Ng=; b=FeT4WcrZIWPjNZiKizPb2Ve/A+
	z3QzqzLKkrGYXd7v5Mxz4yUISCwoY9AGQiZpTllBnTxDY2lsQVfefdb116BirIK+LCiCjF2stwPPp
	llNEV1lOZvi9r9I3IIWOGN2TmPTgOiobA/YBwnvtAd9M1quZrmkSEfPmoXO8XckGQflalgs9dksxP
	bM5xycx/DyOFnLedSdzhg8XGEtL1yPP6joJo5d7KkKus+V+nBH4EnAGK1sSqsA5wZByx2GO4zCvP9
	YwvEoR/4ZB6AsWZv62XXgd/cSAvskq6UrSBk6i7cGmTQntxEuydswj3AOJLuy6i8zoBkxpHNsYx4w
	YxM+VdcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rywrC-0000000EN8B-2lHM;
	Mon, 22 Apr 2024 16:49:30 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rywr9-0000000EN7j-3G3y
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 16:49:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 90E0CCE0BD3;
	Mon, 22 Apr 2024 16:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D288C113CC;
	Mon, 22 Apr 2024 16:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713804564;
	bh=bE7FnNf0IfF6MoCHb9dCmSncIpBLHSLJiBoyZV9ggi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppG1k03i2NISyJrq0pt0EK2X7yPyJCIHkbhBuDL6UEkj8sTffH7g7HZDyMtHthVaP
	 vkHXwN2hNBJNBRe+K6mUxEL1kz7Nt2SbwVx1EoZfWaejolEsw+Adq2S9oee35kriz2
	 dsU+aET/4u3jOI0ZzXzdoJDRD+9GBBSKWV5LcCaKZVyXEHx7tCUe17JXTZftW/UP2v
	 HN9lWXtsexyH2jUQftjtPF/rSkvJh7X3Qujva6UQvsW793Rya+NN7FSLReZ+xvnhly
	 D8buqfFb1Ic7QI32HJeU0kW2EYLm2Sat4TWA0m3ZNozke/Th3C/W4ofG6WqWD0vN/7
	 gbSu/9F6cKdpw==
Date: Mon, 22 Apr 2024 10:49:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add quirk for broken MSIs
Message-ID: <ZiaVEfdUXO97eWzV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240422162822.3539156-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422162822.3539156-1-sean.anderson@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_094928_088824_E607EBE0 
X-CRM114-Status: GOOD (  14.58  )
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

On Mon, Apr 22, 2024 at 12:28:23PM -0400, Sean Anderson wrote:
> Sandisk SN530 NVMe drives have broken MSIs. On systems without MSI-X
> support, all commands time out resulting in the following message:
> 
> nvme nvme0: I/O tag 12 (100c) QID 0 timeout, completion polled
> 
> These timeouts cause the boot to take an excessively-long time (over 20
> minutes) while the initial command queue is flushed.
> 
> Address this by adding a quirk for drives with buggy MSIs. The lspci
> output for this device (recorded on a system with MSI-X support) is:

Based on your description, the patch looks good. This will fallback to
legacy emulated pin interrupts, and that's better than timeout polling,
but will still appear sluggish compared to MSI's. Is there an errata
from the vendor on this? I'm just curious if the bug is at the Device ID
level, and not something we could constrain to a particular model or
firmware revision. 
 
> 02:00.0 Non-Volatile memory controller: Sandisk Corp Device 5008 (rev 01) (prog-if 02 [NVM Express])
> 	Subsystem: Sandisk Corp Device 5008
> 	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
> 	Memory at f7e00000 (64-bit, non-prefetchable) [size=16K]
> 	Memory at f7e04000 (64-bit, non-prefetchable) [size=256]
> 	Capabilities: [80] Power Management version 3
> 	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
> 	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-

Interesting, the MSI capability does look weird here. I've never seen
MSI-x count smaller than the MSI's. As long as both work, though, I
think nvme would actually prefer whichever is bigger!

