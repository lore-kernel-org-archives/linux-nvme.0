Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C94C282EC
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Mar 2025 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ob7+sxPUDOPnlObP526BJRyR2+awiMGAKUAFT4olbng=; b=vqNL4N0Doq6ZFT7jNSNiWTy8EC
	VA56BNNF+NBH0zYPopp9mwENWs2LkKsnzAXNO6X+L00SSQdNfDbTH8eVijwocMQSOZe13pLxuRVZY
	SkGEAbSvallOY5MfeeJrE0aA9neAYzTOTzelQ7YO92NNSO8rlLll5xoN/cPCkbaBLE1nAPXSwSNFg
	PY9T6rUFuYCfLZK2MqsFHmHow/fCIeKO8tS/MjnALJcvS897qxYHQWBR/B2PTnft4zOl85UJxxpnR
	Q8Ul0RkE9t6wBUL+jbZeELAaBFZiJw3yqMD2FIoiiD+D16LU0OrQ61A1UmlQLs/p/5MZapi0Vgqu3
	RbiwAVDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt2wC-0000000DxWT-3g4Q;
	Fri, 14 Mar 2025 11:10:48 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt2ro-0000000Dwrs-0XVk
	for linux-nvme@lists.infradead.org;
	Fri, 14 Mar 2025 11:06:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6712EA45B7C;
	Fri, 14 Mar 2025 11:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203B4C4CEE9;
	Fri, 14 Mar 2025 11:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741950374;
	bh=2L+khe57pxKAZc0Vtww0DqSe5aHkGd5JDm7Nm8zsMoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R3gPZSsDec5shLwSgB6rPehWt+fvoZb2zKtC6DSdv1ZZ3cN25DIynAEe0T8mZvh+N
	 T+HnDQNk+yii0ogaoHo/EkqlUzoAqAIjyUN1Ju4HfF3W/KnKKW9JxWwss9Cn4c2Rz0
	 9XUIW2LGNRNvnkhAhbpXtG2BVfU99FcpiJEcZrH/BDmyQvpLb7HR+23eLH8/n1Sant
	 dCYkz8fChh/jnb7ps+knpoI4vpU9HW3IYP3jY7j5ugo4XsdrzstEkqovQ1eWcD59vW
	 wxddtgl/wExG/73x5yr3JLo+crrqhScgv/qLBinrFu9lE4MYWa6FvE8VUMtqbViMX0
	 vgUpFePfLbCyw==
Message-ID: <f7185d69-bd9a-4d61-b814-df98c596d2c1@kernel.org>
Date: Fri, 14 Mar 2025 20:06:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: Always configure BAR0 as 64-bit
To: Niklas Cassel <cassel@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20250314095858.1604764-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250314095858.1604764-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_040616_238706_40400B63 
X-CRM114-Status: GOOD (  10.66  )
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

On 3/14/25 18:58, Niklas Cassel wrote:
> NVMe PCIe Transport Specification 1.1, section 2.1.10, claims that the
> BAR0 type is Implementation Specific.
> 
> However, in NVMe 1.1, the type is required to be 64-bit.
> 
> Thus, to make our PCI EPF work on as many host systems as possible,
> always configure the BAR0 type to be 64-bit.
> 
> In the rare case that the underlying PCI EPC does not support configuring
> BAR0 as 64-bit, the call to pci_epc_set_bar() will fail, and we will
> return a failure back to the user.
> 
> This should not be a problem, as most PCI EPCs support configuring a BAR
> as 64-bit (and those EPCs with .only_64bit set to true in epc_features
> only support configuring the BAR as 64-bit).
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Tested-by: Damien Le Moal <dlemoal@kernel.org>

(please add the fixes tag I suggested)

-- 
Damien Le Moal
Western Digital Research

