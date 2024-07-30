Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390E8C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJcNw6/0bHa92roMK33TKwjogwz3WJxkK3dKj25YBA0=; b=ICYZNPL1INyn/JOiH44Rc77ll9
	8doQDJqdBg0VIXSI18Ya8GMZEwX/TNODdbuwz+8v0T/itArmJequIGHURwkwPusctGHO521bGB2ko
	Zez/xG1aICRJmWEUJA/B0zdSfxiqKzPVCzOyX8flMZ1/RlJoxMPjoHEzyInXjV8wMNHH4n0AibkgA
	glrstJsnN545P1ClcmFZ5vC0apeU/HKFUJhY2cXH9hGP3YrGvd4eGSqi3QfFetIZ2RRjkE3M4cq88
	Lv2J8HVer7q49ffm31c//ieVpqepb/2XQY61r0A3US0MrVov2IQtroms9c1fNSKsDBJjPUKiBinfj
	pUFeHZYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYqLw-0000000Fycg-16EH;
	Tue, 30 Jul 2024 17:09:36 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYqLX-0000000FySx-2n3F
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 17:09:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6AAA7CE1153;
	Tue, 30 Jul 2024 17:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BFEC32782;
	Tue, 30 Jul 2024 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722359348;
	bh=uVyHO6h84g5FxZT8rw+t8wAv43/VQkWOzj0sFQ8gdA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faK3gBo0EcDMZr7FE2ObHJueRyB0dG6B3AUV5FufylY9HWC4fEZLHjPpmGYXJbkEE
	 cYiC3buejVbK0VgDZO9m4QNyWk5k2QLkOS3saxdFqsKFOXKSGb2CH4ZSL2fiiJd+/b
	 af2TT7B0mSci19NfgecGaQCyOPMu+U8d349vW4zEV6OsQO2nkBzSCyX+nTSvMAIC9g
	 g4ZORZf4JtVedWNZ4UFhBnXIS4ddkMbi/OwUm1VkwBjgZqkU6Wb+74/gL/iHF4Axla
	 bOehkbdBNY4ScgYz72Kk9wKMY3HQYb8Fkwwex98OhWJXjTJwyRS1XWURKtaom5dLqg
	 IoQadgMIpvg2A==
Date: Tue, 30 Jul 2024 11:09:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <ZqkeMJ5PPETMb5d3@kbusch-mbp>
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_100911_923555_1052638F 
X-CRM114-Status: GOOD (  12.77  )
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

On Wed, Jul 24, 2024 at 01:31:14PM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 102a9fb0c65f..cdc0b25091e9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -863,7 +863,8 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
>  	nvme_start_request(req);
>  	return BLK_STS_OK;
>  out_unmap_data:
> -	nvme_unmap_data(dev, req);
> +	if (blk_rq_nr_phys_segments(req))
> +		nvme_unmap_data(dev, req);

This is already applied, but it is kind of strange. We get here only if
metadata mapping fails. Is there actually a command that has metadata
without data?

