Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA12C3DA4B
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 19:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yH733/o+2f3QUCuzhnXRV1EV69bTXlDQSAnjpwL/swI=; b=GVNaSGKbehZgLp7YWoSNCjGy4/
	oWNDlmCTsuMbV/FJsCKLQuOOnjBCDwjqKdJ0nz32I1+fSW6pgbPtCwB16RSq6Ti/qLNAOT6FDmoUD
	5luAY3Fb26h1vwhyVBBNlGks7JvH71mgpbFA/MAM48TRBHjxuQ4YODs5aA5LTUpaAyyT/BqyAFArv
	Vbd5DAAVljPFFdw/7aJMfTisrUclpJM+RNLKnwkznfiyJJEzBK1kcOp21it5OQ65BMrxiDzQ0uRLM
	gfUVoAW6S//jpHFx+GrkRSnueES3vqILEyu8+jsBpk1RClaQ2MkDsodvjXMxJ2Gx5bYMjsFv68rA3
	VPSXNRJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRzEO-0000000FAMK-0U9B;
	Thu, 11 Jul 2024 19:13:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRzEL-0000000FALq-1qxi
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 19:13:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8BEE661DE5;
	Thu, 11 Jul 2024 19:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC44EC116B1;
	Thu, 11 Jul 2024 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720725204;
	bh=fb6F4ol47dP7+bz/+EvvUi/INvjK2iwBH+DWXuJtOqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ryo/hwyXnxbpRKX9TMrRpVu3L2R8DpgiSNUuYuSpfnjXyKDX5UJAaVZO+aD3AmcuU
	 zlwoFSP83ibLWySfzbFdCwt9usEIwttLOHcXE5/MUmn41ZFvf+ZSUyAYDIwTLswyIS
	 TZkPlhc7VZT7MvyDIi72+zi9+7uPsNBKT500xomTtZud8KkQJILqZ9wVaof+8Q3aQ1
	 JXPKxv8EkMaiuDeZ7elSVDcJzm5MXQbRGKKFlY/2dbAHTL+xYM/yqQIfT6OdHA5SYX
	 +Q0BQvSdPhZ9SUamfFKLBUl7fyi8rFY3bsUFjmE81xUiYvDPBpJNUURadIoIiYQIzl
	 8xpKT0K8CEYXQ==
Date: Thu, 11 Jul 2024 13:13:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvme-pci: Fix the instructions for disabling power
 management
Message-ID: <ZpAu0elweZP6wcFr@kbusch-mbp.dhcp.thefacebook.com>
References: <20240710231805.10481-1-bvanassche@acm.org>
 <ZpAr89uectd_fTzV@kbusch-mbp.dhcp.thefacebook.com>
 <76184984-3ca5-4df8-9c54-f803ea9d5499@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76184984-3ca5-4df8-9c54-f803ea9d5499@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_121325_568098_E46B5DE6 
X-CRM114-Status: GOOD (  19.82  )
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

On Thu, Jul 11, 2024 at 12:10:11PM -0700, Bart Van Assche wrote:
> On 7/11/24 12:01 PM, Keith Busch wrote:
> > On Wed, Jul 10, 2024 at 04:18:05PM -0700, Bart Van Assche wrote:
> > > pcie_aspm=off tells the kernel not to modify the ASPM configuration. This
> > > setting does not guarantee that ASPM (Active State Power Management) is
> > > disabled. pcie_port_pm=off disables power management for all PCIe ports.
> > > 
> > > This patch has been tested on a workstation with a Samsung SSD 970 EVO Plus
> > > NVMe SSD.
> > 
> > Interesting, didn't know about that parameter. Does this actually aspm
> > too, though? It looks like we want aspm policy to be performance for
> > that to happen.
> 
> Hi Keith,
> 
> I don't know the answer to your question. All I know is that the
> settings from this patch are required to make the SSD mentioned above
> work reliably.

Okay, do you think we could just append the new parameter to the
existing recommendation rather than replace the aspm one? I could swear
I recall some platform where pcie_aspm=off did fix something, but it's
been a while.

