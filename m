Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891CFC48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HifY3HPuizvVsILt1D5m2MQwu9e87RR/mYzm06FQ6Mw=; b=xuKL4zzOopp2vCnBB91zTU08p3
	p6Omk5CRRsbufbzH077SXR/edwe3POzSmCI43xlfaNrirxNzZbA6sTrr2dCoXUC5I/ZLp7P9VDMKU
	PKitqePiybTa5Gz3CtqjaK4cVIvkPXyLrTgxpkjeyptMxklHTL0IC3jpMEn0DzEjH9jB+E5xmm90W
	UA+Q2IHwEOz/WEXpMAgpm8jEzHAuDr8pTQhcbGwIhcDIVD3oHUO3GGy4deYKHMdSblm4AFCF1dSKw
	eEScQWeqgGHdOB7OtM1FTwEUM4x5cuFvaVlA7ZaKneeidugFVyQX5vHKyfiq8LY4CBWnLWug+z6Yg
	J+h8DTQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBRF-00000005Vlq-0pFz;
	Thu, 22 Feb 2024 15:56:45 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBR9-00000005VlN-1gGT
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 15:56:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 58F48CE2834;
	Thu, 22 Feb 2024 15:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9B1C433F1;
	Thu, 22 Feb 2024 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708617396;
	bh=VDRtvAtR7aRn0VRcVjdM7qPVpmMRwpDdflg/rBTdVrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVJateAj0WLWsnDoUfg6TRO0yHOY9EVNPNL+o3dRWkIWBXLfvzxOhCbsVT7UZ2kwa
	 FXOd24v4ganzdI7N8mhTTgxQL1o+J4qMiMx7ylzJRPtw0Cpx0Ksd4ysBMObnOS61bg
	 wnlVbYA42UOqp/ekIVlD/HTsVzp84nCklpLPbJOlxhLBbhyj5vZkXIpU9U8t7pV/XY
	 7szPMzXRce9sWWdd648QVVokvLZcnwSIfsXnJ3R+VMtyenrxYQ2iLGriV5h6vcVKAL
	 lD1EGI2fYJoEV1+MIpoN0jWLWtMmtBKdoprIRTSHkij2/GbgY4UrIBINktL6LM/AtS
	 j9MiMwx2XYmRg==
Date: Thu, 22 Feb 2024 08:56:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jaehoon Shim <jmattshim@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Adding NVMeVirt to Kernel mainline
Message-ID: <ZddusYydcaBkY24T@kbusch-mbp>
References: <CABj8AyhLjBkQUhp4CFY+xV4_GwDAyzU251St+BMoYUKCjj7M9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABj8AyhLjBkQUhp4CFY+xV4_GwDAyzU251St+BMoYUKCjj7M9Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_075639_661044_21F5EA1A 
X-CRM114-Status: UNSURE (   9.20  )
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

On Thu, Feb 22, 2024 at 10:38:03AM +0900, Jaehoon Shim wrote:
> Hi all,
> 
> My research group has recently introduced NVMeVirt, a software-defined
> virtual NVMe device implemented as a Linux kernel module. Upon
> loading, NVMeVirt emulates an NVMe device that is recognized by the
> host as a native PCIe device.
> - https://github.com/snu-csl/nvmevirt
> - https://www.usenix.org/system/files/fast23-kim.pdf
> 
> Advantages of NVMeVirt are:
> - Deployable in real environments (not virtual)
> - PCI peer-to-peer DMA support

It looks like your module creates a single nvme device. How are you
testing P2P with just one device?

