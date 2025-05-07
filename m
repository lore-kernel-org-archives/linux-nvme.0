Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAA2C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9wYJVQqVvTL6ieKBSkiLCwHzUIKKC2Egfdyq5UNVlVE=; b=hW/2fb7KBLKlep6IbLftavQz+z
	FkG7o4MzekLz8TTLX5Pir1cTeama9MwhrrgyTBLZhc+7I+GKxHsp0F2p0uKiwDdMqFDwYueDdsDYo
	kAyFew2U0yx1SDeyWau64MtLiQKpXUZiuZDWE2/8l7qC+jLNIwrJQfluYXMv1VsRlgvnm/ihmlG98
	z3Azs5TLCwW0d5pmiA1T1FtmoZ16Kjy9Ie6FBr2wNTBtisGO3rePXklNjjx7pPE3Mmlrpm3x4SA8d
	mtIi28GowleJFz30EFqJzdT+wc0dET6i6F6cyT1rxs8zDWKyfMyyXnFvVXHvz00eqR/lETxdVaRBF
	c613zrvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEH-0000000EkdW-3H6G;
	Wed, 07 May 2025 08:34:13 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZFE-0000000EXfy-38Ty
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:31:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BE0CDA4D4EF;
	Wed,  7 May 2025 07:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E12AC4CEEF;
	Wed,  7 May 2025 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746603067;
	bh=b5ojSOJ8CrDogHRs6uALAXx0Rg2jeKKvnbYab0lAUzs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t7kTdeLPuECuuZUvkpJ68HyOzBMnI0r8Ql1riEtxwYoTFQWewhmoo9ENxy82tT9Tr
	 2SUUPyhpDbmifG9oP0lAirzXRFRbfsPuWYbSjTMtoiMQb8XMvTR1vhSPzpvrkn3rTP
	 2tERGz0jNqfTE10VmyoqwdN/5miuZR+Hq7oYUfaODQq8q5SmYUrARsyhtZJ8qnutvc
	 6cF3ovQCYZ+JYPk7uKTMGdN70mz2n131vOb75ZBr3yz5nJjJwuT5ixXIT69BYK4wfs
	 olRp98s45Hd3bM2PjcEHNL16JffwbMDonc0hzaPf97/IlFCvrmQVZVM7Z7arz/DpCe
	 L9aasSyMbFV9g==
Message-ID: <0bf475de-4a0e-4c06-b0f4-a36306802b96@kernel.org>
Date: Wed, 7 May 2025 16:29:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvmet: Simplify nvmet_req_init() interface
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: alistair.francis@wdc.com, cassel@kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
 <20250424051352.7980-7-wilfred.opensource@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250424051352.7980-7-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_003108_855513_09FA8B56 
X-CRM114-Status: UNSURE (   7.19  )
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

On 4/24/25 2:13 PM, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Now that a submission queue holds a reference to its completion queue,
> there is no need to pass the cq argument to nvmet_req_init(), so remove it.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

