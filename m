Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAF3C982E6
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 14:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8yzJ/PKyn3nO+ZYEl64j2VwgYC+Vk7U0Xda7c30jz40=; b=vdFPclCRhvNB6Y8+e8VF7MqdcX
	snXd4e5K6x9x3h9Nu2ZioPpgSefqRHLrCtpWW0RHAbnyWD0I1XX6dS/omxvTiJJXd2szjzecoPtXh
	9MTznsSl/qEm0/MxlFhAB2xQHIy9R9a5VZG34B9N5fDyTVj5jMRDdJNC7cGy8//vnHsHvjje0nqgd
	4+woNiEwJq+H76ldWSbFfNA4oEc5wH+DMlCd+ryTZxKvP1vUGW3ygT0//Smy8GY6HG35xJ8VlA6sG
	R+Aue2SKMyfzMsXouyNJ23iSaJw95JOv8beWw0p1Z58OyBMwJa8D83OvK88NKnlG43UKBKiKAydsx
	CYocKl4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8f0x-00000002Oct-2DWk;
	Mon, 21 Sep 2026 14:29:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8f0w-00000002OcB-3gxr
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 14:29:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3942343C58;
	Mon, 21 Sep 2026 14:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28CC1F00893;
	Mon, 21 Sep 2026 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000942;
	bh=8yzJ/PKyn3nO+ZYEl64j2VwgYC+Vk7U0Xda7c30jz40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L9iRD0Iz3HLe3yjrwXJRPXJc4xv04URetHGoEL6DIWUX2sUchjRRvt3KEuXkm9Kl+
	 P9HnR+H1tRkNj6KdG3Qs87mWH9zZwlCOXHVO17A1ekMnaY/3m1u4zgJB5wRvpte4V0
	 Fw0gIkDFrmfL7BArVkVHqvAx0ULU4f7F88pDabvGbn++1LbgowExeqfhNs8AXVZ0i/
	 2PD9HXD1iE/1Ii8qBT8Slg+RabTKhfnQHiwGpLhL+0xRun1O7yZYcopA6EqYTZoV9R
	 PgutdDNA+Uo5nqe8+xzW6Utsnt6BiguXpvkQD6JKzShBT4GDXopqIPYezPOJbC9YYj
	 Vo+1XhcJn6oiA==
Date: Mon, 21 Sep 2026 08:29:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Haowen Bai <calvin.bai@ugreen.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: skip FLR after a failed controller reset
Message-ID: <arE_LD-uSB49gU0j@kbusch-mbp>
References: <20260921140732.2942207-1-calvin.bai@ugreen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921140732.2942207-1-calvin.bai@ugreen.com>
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

On Mon, Sep 21, 2026 at 10:07:32PM +0800, Haowen Bai wrote:
> nvme_disable_ctrl() already waits up to CAP.TO for CSTS.RDY to clear.
> If that times out, nvme_pci_configure_admin_queue() currently issues a
> PCIe Function Level Reset and retries.
> 
> FLR is performed with PCI config cycles. Those cycles take
> pci_config_lock, a raw spinlock, and wait for the endpoint to complete
> the transaction. A wedged NVMe function can stall that completion.

Shouldn't PCIe CTO have kicked in to fail the transaction? Do you know
which transaction is failing? Is the stall specific to FLR or could any
config access stall in your setup?

> Other CPUs then spin in pci_conf1_read() -- including ACPI PCI config
> from an unrelated device -- and the NMI watchdog reports a hard lockup.
> 
> This was observed on an x86_64 UGREEN DXP4800 (kernel 6.18.15) with two
> ZHITAI Ti600 NVMe devices used as bcache. Each disk independently:

Are you able to fix the device instead? Maybe add your device to the
"quirk_no_flr" list if you can't fix it. This sounds like a pretty nasty
bug on that side that forces driver to remove one of its recovery
options.
 
>   nvme: I/O timeout, reset controller
>   nvme: Device not ready; aborting reset, CSTS=0x1
>   nvme: Device not ready; aborting reset, CSTS=0x1
>   watchdog: Watchdog detected hard LOCKUP
>   RIP: native_queued_spin_lock_slowpath
>   pci_conf1_read -> acpi_pci_set_power_state -> mmc runtime resume
> 
> The two "aborting reset" messages are nvme_wait_ready() timeouts, 128s
> apart, matching (CAP.TO+1)/2. The lockup is ~11s after the second
> timeout, i.e. on the post-FLR cleanup path, not in the wait loop.
> Linux 6.12 has no FLR fallback here; 6.18 and 7.3 still do.
> 
> Skip FLR when the controller is already in NVME_CTRL_RESETTING (I/O
> timeout recovery). Keep the FLR hammer for initial probe, where the
> device may simply have been left enabled by firmware. Reset work then
> marks namespaces dead instead of hard-locking the host.

While I don't see this happen very often, I've seen FLR recover devices
both on first probe and IO timeout, so skipping for RESETTING will miss
recovering when it was possible for some conditions.

