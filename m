Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B96C3ABC6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B7qh1emfkNX7g7rBwNkEmWKDwIfpMHYdPAjDHWaFkuQ=; b=o0I2gZEwRdkBIjLkTwaiFIKCpC
	OnHzevowiCnyFvLGGM8jqgwOO0Flt+6O1h/MCT5Tw1ZoDFSpGF/CNqPRNTlWFzMs749Kk9BHEubzC
	iW7LSM8Qrbi5Io9BnGDjbva8sfcYlen/+W5yfxeP/B31qLlgXYQeyQNPxRBRpn0jXaOoJRagYPlDE
	ufbo3lCBNY94xRin/jjs9zwQCQoxh9iHyEUp3g35AQB1j+9DPnto36rAm8KpRkIyL/v192ui1WZWG
	9Pwn3pgJVVJRsIP9OvSbvHSAlNtzjsWwacSFDDHrF6VdiAQYEht2tlPuUVS+nvT/0Hq5nLN8mbz0H
	fVsQOUnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZyq-0000000EhYV-17i6;
	Wed, 07 May 2025 08:18:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZ6K-0000000EVQe-2Cvb
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:21:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BFC8C43EFC;
	Wed,  7 May 2025 07:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D88FC4CEE7;
	Wed,  7 May 2025 07:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746602512;
	bh=FRkij4lu2E6cNVJfp1oRSY014gtSMwlzP+B6FbaI3fg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iVIRSXsfkfktzQfMJnYYMO+JGMcZgo3rLgtg4K3UFl/MRgFQofGIzeIcTAw4tEIGf
	 54Gt9CinfKgP/hEBk201SBX2rbpIcmhY7UFaPKdV8szPjbF7jdAbJEn2zQRwIsoM4t
	 Zjrt4QHMrvp/JaKxme3Vry6WiMFrKEylDUVPqnZgeEcvLS3QskbnlUrGXgoo8wcFmy
	 YgA7XwrI+/x0nyrYG302qGJSXXi7InJ09NzfSjhInb7Lz/XV2zaNUXLWndSkzI0z2C
	 DnAXCbRZKT6ZT4Uj0AKmwyspF5CeVrQhdsK1nbTX79SJHrQIVuGtbWzRSRALYVfAND
	 F6emegR+1BJcA==
Message-ID: <2c3e7cff-b29d-4616-8881-ecec5d712ce0@kernel.org>
Date: Wed, 7 May 2025 16:20:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvmet: add a helper function for cqid checking
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: alistair.francis@wdc.com, cassel@kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
 <20250424051352.7980-3-wilfred.opensource@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250424051352.7980-3-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002156_584062_A7750D18 
X-CRM114-Status: GOOD (  11.98  )
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

On 4/24/25 2:13 PM, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> This patch adds a new helper function nvmet_check_io_cqid(). It is to be
> used when parsing host commands for IO CQ creation/deletion and IO SQ
> creation to ensure that the specified IO completion queue identifier
> (CQID) is not 0 (Admin queue ID). This is a check that already occurs in
> the nvmet_execute_x() functions prior to nvmet_check_cqid.
> 
> With the addition of this helper function, the CQ ID checks in the
> nvmet_execute_x() function can be removed, and instead simply call
> nvmet_check_io_cqid() in place of nvmet_check_cqid().
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

