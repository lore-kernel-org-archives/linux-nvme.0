Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95957C47096
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 21:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625306139A
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 21:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625306139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rSom5OgOjg2VM2HaZmPDNFMwH8JjM5cA1YOIxxfGQoI=; b=RrzyGVZa9OkSJg
	jdmtkXUCyVTIMZzc/PuBBVe2rPP8PlvjemNuYItf4yEBF988h2Vqr4TUHxaLURh1V8T7NclYfDKtf
	nHK9MJ8LU/J3OQSyU0HoWVG9eJ/ap4y/v9pb4eLkCthf35R1RIHv/FulJ5l3nwCB8TMr7823sE/Rf
	nexRInVjI8dX+0vphYODvrfvoNwbwl7FOfByWUqhyGW8CMuHZ2kRAKtv5oxsVhillO9E3AmAvG5kP
	bEVF7lyEiz8IEl2Xm+rOxrn4xvigsCf3ERqCFfnIK3BsP6Uq5Q99vlz7fF9VdySdo7bZsrH7v096U
	oJ3ya8/8MpMOZ9LtfX/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loul6-00AcIc-48; Thu, 03 Jun 2021 21:20:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loul3-00AcHx-B3
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 21:20:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id 0806961403;
 Thu,  3 Jun 2021 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622755205;
 bh=IfSq5Dd/Ab+O41ImRrQMvqTshXVTzVLzZsL1xJq/qtc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Phkd9DSV5zUozHMjfHwSYbWlmzgXhvipmhq7/6sTIzCAWB/mtuB+NKf1wu1bFoEwX
 femnmpCD+UE/u/FolMoWY6TCZibHXTVBkgE4qn+AZuA8FsvtjuxeLO1ZExr+GfgLmN
 vFfctzskAr5OEswYjH2KtfB06kRQQQ/MeENM+sylYZ+NB4ZDm4rmKUWZcgyEGLX2qd
 2Aqyx7xCyX82EWnjt14slPTs62RuVu3uNLX4kzZ4RCEMjKRcW64jVheJzUsmuqufh9
 RDRSDCxaWf9tqV1rz+ZPd1HFlf0tBWbv124ZrSazrppryEaYPwZkc1GR+fssBzDktv
 4uQuapRvq6r9Q==
MIME-Version: 1.0
Subject: Re: [PATCH 0/8] NVMeTCP Offload ULP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162275520500.10237.9696423451786528380.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jun 2021 21:20:05 +0000
References: <20210602184246.14184-1-smalin@marvell.com>
In-Reply-To: <20210602184246.14184-1-smalin@marvell.com>
To: Shai Malin <smalin@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
 kuba@kernel.org, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, prabhakar.pkin@gmail.com,
 malin1024@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_142005_420511_50F78DB0 
X-CRM114-Status: UNSURE (   9.16  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Wed, 2 Jun 2021 21:42:38 +0300 you wrote:
> With the goal of enabling a generic infrastructure that allows NVMe/TCP
> offload devices like NICs to seamlessly plug into the NVMe-oF stack, this
> patch series introduces the nvme-tcp-offload ULP host layer, which will
> be a new transport type called "tcp-offload" and will serve as an
> abstraction layer to work with vendor specific nvme-tcp offload drivers.
> 
> NVMeTCP offload is a full offload of the NVMeTCP protocol, this includes
> both the TCP level and the NVMeTCP level.
> 
> [...]

Here is the summary with links:
  - [1/8] nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW offload ULP
    https://git.kernel.org/netdev/net-next/c/f0e8cb6106da
  - [2/8] nvme-fabrics: Move NVMF_ALLOWED_OPTS and NVMF_REQUIRED_OPTS definitions
    https://git.kernel.org/netdev/net-next/c/98a5097d1e08
  - [3/8] nvme-fabrics: Expose nvmf_check_required_opts() globally
    https://git.kernel.org/netdev/net-next/c/af527935bd5a
  - [4/8] nvme-tcp-offload: Add device scan implementation
    https://git.kernel.org/netdev/net-next/c/4b8178ec5794
  - [5/8] nvme-tcp-offload: Add controller level implementation
    https://git.kernel.org/netdev/net-next/c/5aadd5f9311e
  - [6/8] nvme-tcp-offload: Add controller level error recovery implementation
    https://git.kernel.org/netdev/net-next/c/5faf6d685548
  - [7/8] nvme-tcp-offload: Add queue level implementation
    https://git.kernel.org/netdev/net-next/c/e4ba452ded39
  - [8/8] nvme-tcp-offload: Add IO level implementation
    https://git.kernel.org/netdev/net-next/c/35155e2626dc

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
