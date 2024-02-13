Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFAAC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CFM8KGxeEHdg92aD4/Od1MJ4Y0od5H2HSPpGzC+dS+s=; b=p0uakXxr0vuw8qgCQI/olyHZjw
	7T7MzdW85VHpZhcuaLJrBYWUsNQOsHEJYLA+/fp1PBYD1kb5ztl2608BxEz6v9ypIX44uPKKjhqx8
	rMts+VsdxWv+vrvQJS/uWtACQ4J+1uZonrQG1u9HrXIJ6lfL2vOEzru6s/AJaEmlFnipMlehUufoW
	xiX1g4ApbsLNYJkED3xYHWLp92JCrGLGsl/r8MpTzngd1g7JMjJyiIwOfxsZ+RajemGepfHFJF9vb
	V6QWj48QKcwaLXz2gawyD2IqRWNXbe4s5HNTaqlYO+loSr0Ih524vf1C7ntfGEZHLc1jW+DV+2rPr
	nyYxvXDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZuwf-00000009o6O-0Dqt;
	Tue, 13 Feb 2024 15:43:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZuwZ-00000009o5O-2BLu
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 15:43:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8FA05612B7;
	Tue, 13 Feb 2024 15:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE6BC433C7;
	Tue, 13 Feb 2024 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839014;
	bh=TrDDlhQWpOQcvhO9N9Wb31TtJWa43+QoOGwahxLWKoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKXZUlL9kMSHqB4QCAfE1nZFnmqXXv8x4BmbB3BaX7AeSAz9TlLFQ2hpz3UhtoSns
	 iyZj5tu0LmKaRRsO6vaK7jL1DUT9L/WWUBeHC1PogmdL2jQJ17dD0QVzLCdWDtcY2k
	 By3zpBTQyUj8Q9HuR7X3XrpWdok3hKLvBldO0w2DOzmj73OmfFZPCzQDXk2K7y8rva
	 C4z8SmJkJTNYQALiGEKLso144i85EAvIpSKFdGb3Xt0+KgUEKF31e7w7qSRmRM0h6r
	 sZEs77d8x93lH7akcmbar0D+ZT+o0bsGPpyaL6ZabX9VTSxspzncLt9ph5A4sGPXxZ
	 C7hdhOpEh5F4w==
Date: Tue, 13 Feb 2024 08:43:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: sathya.m@samsung.com
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, d.palani@samsung.com,
	prakash.bv@samsung.com, anshul@samsung.com
Subject: Re: [PATCH 1/1] nvme-pci: Verify the CMB's Controller Base Address.
Message-ID: <ZcuOIgNWEssyfXZT@kbusch-mbp.mynextlight.net>
References: <CGME20240207103103epcas5p1b4f57f29cac1387546301ba279ea0f96@epcas5p1.samsung.com>
 <1707282098-28131-1-git-send-email-sathya.m@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707282098-28131-1-git-send-email-sathya.m@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_074335_634552_BD1623BF 
X-CRM114-Status: UNSURE (   9.91  )
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

On Wed, Feb 07, 2024 at 10:31:38AM +0530, sathya.m@samsung.com wrote:
> @@ -1856,6 +1856,9 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  		hi_lo_writeq(NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE |
>  			     (pci_bus_address(pdev, bar) + offset),
>  			     dev->bar + NVME_REG_CMBMSC);
> +		/* Check the status of Controller Memory Buffer */
> +		if (readl(dev->bar + NVME_REG_CMBSTS) & 0x1)
> +			return;

Let's define an enum, NVME_CMBSTS_CBAI = 1, which will make the code
clear enough that you don't even need the extra comment.

Otherwise looks fine. This field was introduced in 1.4, but defined to
be backwards compatible.

