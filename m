Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA78C369CF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQpGMZH7hJGwh2v6GVshecmqrSaurYZDcDpk2isZRkE=; b=QtsbTpV9SuyN7rMP6BGsjLVzs5
	KAWC2dPCB3U5xIgZGU1uvGYAXB7hqgmFZwu3nnsbKN9YhA966AZNfD76+I/mIP3PnUplmSc+fLB1K
	Yyt1OPee1F3IJB5/qDBNS0Evm2S067l+zk/9SFfW1VZVAjY05GdoXJv5Xc1mAMkFjWTioDimkQvPT
	ZPxsigUTp3iBHJWwnyfEoc6y7M62MLl1sgMSKrUV87/ggUNpDKRmc7WE5NpdxjbJwMdsDTmtQyqhZ
	uzSEi/iAPSXmeKWeSohZRcN278cIFqM87kUuSovpJ8mG6LQqdHILFtNdmoRVtkUJ9sVaH44Kqed7h
	4CeZHvGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hAF-0000000FdCA-01pd;
	Fri, 18 Apr 2025 08:33:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5giI-0000000FZLF-0Di2
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 08:04:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E8BE435A6;
	Fri, 18 Apr 2025 08:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F17C4CEE2;
	Fri, 18 Apr 2025 08:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744963481;
	bh=I87Hg6UBf9scIC+j+W1vdesHt/K1tAfOVb8LtxNUDrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qSCElAHNAAzgVOM704vcMUyZ18N4qEvZLGzC0Nkoub4O7KEoJ2nIXcf0ONraeM+yk
	 KMNCrZ3B7yni8HxCrI88AZqOyExX4T2YxIwxUMZDut7FiryTgevfJ3iWTV2bMCrj4u
	 iduR7tK8xSCO6iQBCBVcL1/3zTpRWkyR0OKcvV6Sf7ExtkiDWkHs0Lls6U1SK34OIf
	 R+EFoCjsno9mdsspcZunz1O1mh6mfzoHjvGe209OKkgFIrPok6PhHcfWbjBnlAZ+Yb
	 K80rCBo9HvbIGE0tHbAm0Wx6gevHxSAD8DoQEmjCMzQX6ywFKujtfYOxX2OCodw8/V
	 ThfTE77CxjWyQ==
Message-ID: <169955ba-63b3-4d25-b8f2-afcea36d3f95@kernel.org>
Date: Fri, 18 Apr 2025 17:04:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Fix out-of-bounds access in nvmet_enable_port
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, kch@nvidia.com,
 sagi@grimberg.me, hch@lst.de, upstream+nvme@sigma-star.at
References: <20250418080250.2736590-1-richard@nod.at>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250418080250.2736590-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_010442_114932_3CC6101D 
X-CRM114-Status: GOOD (  10.03  )
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

On 4/18/25 17:02, Richard Weinberger wrote:
> When trying to enable a port that has no transport configured yet,
> nvmet_enable_port() uses NVMF_TRTYPE_MAX (255) to query the transports
> array, causing an out-of-bounds access:
> 
> [  106.058694] BUG: KASAN: global-out-of-bounds in nvmet_enable_port+0x42/0x1da
> [  106.058719] Read of size 8 at addr ffffffff89dafa58 by task ln/632
> [...]
> [  106.076026] nvmet: transport type 255 not supported
> 
> Since commit 200adac75888, NVMF_TRTYPE_MAX is the default state as configured by
> nvmet_ports_make().
> Avoid this by checking for NVMF_TRTYPE_MAX before proceeding.
> 
> Fixes: 200adac75888 ("nvme: Add PCI transport type")
> Signed-off-by: Richard Weinberger <richard@nod.at>

My bad :) Thanks for the fix !

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

