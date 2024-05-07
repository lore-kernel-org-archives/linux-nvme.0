Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AF8C10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3A8S06nAzUVedTReMiHv6BNDSr5Rx0H64J+DEO0cK9w=; b=eY5AX4LbJmAl5HXkmAD3WH6uRL
	03vt6+bftO4U11IdAC29CgmtF+qZOFFbNQsRnIbL9Cm7X6+f7H/VU9okPBcqWVl07bzL9a9Uqw3rL
	JLy0GNjh8eznXmsvU75kxcdQS4XJPUK5Qqc4L4MSfJxXDzNnvNqkWP85pY+9v0cNHGKibfRyT+7Wv
	bjM51HXFTTF65huEjr9xwvsVfaSrBpeisv/Cgn+zDvVKuSkoPDBUgqBbg1whUoxjwS7z4UVMidVvJ
	pSneUmbliUmH+wPvMyURG7J0LQ5xPBjTeVfnVDzZWL79krn2shy1wXL+JbosphY46z6SYOH8Y9V+Q
	ZWtgez8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4MLJ-0000000Be10-3K5d;
	Tue, 07 May 2024 15:02:57 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4MLG-0000000BdzT-3Vsm
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 15:02:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 10236CE139C;
	Tue,  7 May 2024 15:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4497C2BBFC;
	Tue,  7 May 2024 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094172;
	bh=gn0W/1EWIXO6epjS/6/rnHSMUoGl5NRWDPejbySshu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAtEwbjkyVKi5gGkBXntmdl65SXUOd/ocHNPLfbZH0uu//BIdPEjMJl1iR9b8NFVv
	 jyvQdQlNKHj2CbJ6aj/uRY8Na6DGekQyuOM0r5SQF5F1wVJkROMqLCRhV6ARHgf3x4
	 CncsB1TaB8SHoh0VMpHC+nyO7ck63NvE1fF4YESYTeQGofHStWAGlRKTIjYXbgxYB2
	 znJXYXv8S2aPWemIfg21ELrI7Fd2+lQKay7PwSpF8C4wpNyqmrcsLZXw7oppq5DDhu
	 WS7+w9Q7SWyNmmJ+0Zp3O16EZcCnHss39qgzwLMNIC84zoXGgV6cHObNZ+V6j3L99A
	 +dDTpk8a2teWQ==
Date: Tue, 7 May 2024 09:02:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add quirk for broken MSIs
Message-ID: <ZjpCmj4sf68Wlck_@kbusch-mbp.dhcp.thefacebook.com>
References: <20240422162822.3539156-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422162822.3539156-1-sean.anderson@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_080255_088047_877960DE 
X-CRM114-Status: GOOD (  12.56  )
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
> 
> 02:00.0 Non-Volatile memory controller: Sandisk Corp Device 5008 (rev 01) (prog-if 02 [NVM Express])
> 	Subsystem: Sandisk Corp Device 5008
> 	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
> 	Memory at f7e00000 (64-bit, non-prefetchable) [size=16K]
> 	Memory at f7e04000 (64-bit, non-prefetchable) [size=256]
> 	Capabilities: [80] Power Management version 3
> 	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
> 	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
> 	Capabilities: [c0] Express Endpoint, MSI 00
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [150] Device Serial Number 00-00-00-00-00-00-00-00
> 	Capabilities: [1b8] Latency Tolerance Reporting
> 	Capabilities: [300] Secondary PCI Express
> 	Capabilities: [900] L1 PM Substates
> 	Kernel driver in use: nvme
> 	Kernel modules: nvme
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Thanks, applied to nvme-6.9.

