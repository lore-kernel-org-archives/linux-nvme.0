Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5264FC4828D
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Feb 2024 01:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m7V2MvBTfuaM68n/gBvF06uYGJ5j826Bn7F4hYDQOQw=; b=13sQ/KBltbeuAfy3wvq9OU4v5L
	SPPmhbpRw67MDPDI1eXJd7s+t2BbJoGi+du1abm4xSUiVhl/4SxAoxlbzjWtUPB2gKy0ztS3hwRhN
	Dl0+vKdWzhiHJnXx0k4Dz8WkmUt/oCnFs/1jZaQ8Pok9ebMYGTmnVqKmAf1hlefAMdQ6Wt9TxKqGo
	/nEzVpTyCq3wgpjqCqeAjBJQDfzrTct/Nwv871fJPVk1xe7ib9dXYtSKMaQfpq9gXki/s+EZsZlYu
	Hpr9PXQec84z9Ov0CLRa2J74kJjvwGZRWS2Ev8IbJ5JEz+6Z19NcPgISoXQxfiuiiYXPHJ2XmJiEW
	hu0P03Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWR9b-0000000HUcX-3SBV;
	Sun, 04 Feb 2024 01:18:39 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWR9Y-0000000HUbX-3HVx
	for linux-nvme@lists.infradead.org;
	Sun, 04 Feb 2024 01:18:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 11F0BCE0966;
	Sun,  4 Feb 2024 01:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4B2C433C7;
	Sun,  4 Feb 2024 01:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707009510;
	bh=N0V4Ph8iNL+aL7gCMKVWDl8Sex1xOrhVgx1Z1xy74b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kq1/NHYUfcz+snIVRIRYDRkBwUHK76e83fS8Ms5BQU1YdoWeUfxgIjZhmGqKaXu14
	 79nxtgQp3jpkOHIKhaPyeFysGHvkrNg7YwTENIxYsgzS3rKyQpnBcraUazfpUKtUXH
	 lfOjxV2g8HJoxvkn/3u1ePH2xXOm3OoI41bxZVkmPYH4Gal9UovIcojNnMQKatBLfB
	 cnM9qC2F6IpKdl1b0232Kk45M0haPbUwl2ALXQMpPVDkmrP7qkdkNefY5B45d8qeFx
	 MA925nkn/L4W1dzujdZxA/2txP/PDEB50zPO363/DUMnwGBpuqlgcpN6tf5iHSX2E5
	 keVmT+snU5UoQ==
Date: Sat, 3 Feb 2024 18:18:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe suspend failure
Message-ID: <Zb7l5Lk814W4064a@kbusch-mbp.mynextlight.net>
References: <294cb317-22b1-4c03-9b12-b19c55ec3163@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <294cb317-22b1-4c03-9b12-b19c55ec3163@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240203_171837_017775_762762F1 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
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

On Sat, Feb 03, 2024 at 05:01:41PM -0800, Bart Van Assche wrote:
> Hi,
> 
> Even after having added nvme_core.default_ps_max_latency_us=0
> pcie_aspm=off to the kernel command line, the following still
> appears in dmesg -w output upon suspend of an x86_64 workstation:
> 
> [ 2451.640676] nvme nvme0: controller is down; will reset: CSTS=0xffffffff,
> PCI_STATUS=0x10
> [ 2451.640690] nvme nvme0: Does your device have a faulty power saving mode
> enabled?
> [ 2451.640694] nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0
> pcie_aspm=off" and report a bug
> 
> Hence this email. From the nvme id-ctrl output:
> 
> mn        : Samsung SSD 970 EVO Plus 500GB
> fr        : 2B2QEXM7
> 
> Please let me know if you need more information.

And this is happening during a suspend? What kind of suspend? Like an
S3/S4, or idle suspend?

