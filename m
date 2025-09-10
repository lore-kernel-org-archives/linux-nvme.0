Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB1BCA0FED
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Sep 2025 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YS8zsYKW7CSVyibQHPXV+iO5Akw1hruISRUve4UTjQ=; b=PIpclPlRWbvx0AyFAzLlGMa4L0
	icjHlLSeJyhFNaX6dEMIP5YVwJ02uxHRhGfSVoP+Aec6x+0t8aRDFCZEb6GaKIbK3uMyh4+J2NdsN
	Z/cfPMcazM2izMveOElCReHybxwBHz8OClE5fOy5ihBsNwV27leCNkL5JfPXxOFa7oETdISvneGMs
	3kzcScZmZ0Ae3L6dDx1vDmscWON+nnJrfWJ5K9CJSuitdDPZ6cSZq+JX9pzjZUrVBcNu3eKgTdzVj
	pbJtxB5xLLRU3yfAYQ2L5fizzlPptqySpRPTWo3tXyvLVGmOhrszkzrLkkWQhzA7HBM8ca2NC8pEj
	EGnl32OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw9Lc-0000000BK0a-0Wkf;
	Wed, 10 Sep 2025 01:10:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw9La-0000000BK04-1vsG
	for linux-nvme@lists.infradead.org;
	Wed, 10 Sep 2025 01:10:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 94D01438D3;
	Wed, 10 Sep 2025 01:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46590C4CEF4;
	Wed, 10 Sep 2025 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757466605;
	bh=C2k9MiDhguBj9/iGc24WyCBUOM1Yq/qbPPGVNZ1cbjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MU/wT21qyNV/bhIBvS6UUGsqUz7rYtzIgbTv/6/evmCJ5o8A793tbjUmmbK0hvJYR
	 7l2EQ0lsGZ/5N/mHSrIJDzAEj3/7XX/hbAFU6mBIZ9s9KffKaf1a0tY6aoKrZcxKMP
	 ky/s/Ws8OawTkXTkm5Ks9JgUY9l4Wwm+TcONmlVra00tshug0YDRXjsJFN9J/aF91o
	 4O7za00iaVTBF7U54Jau9WXxolpauRX0Z1WQra9YVsboRwoGDwL+z2HVnop2Ne9T33
	 9bWQW14gu/i4C8xai3uxa/AIwAuO5+APics6r/9W1GldbCy9YlVhG21h0F7dN4f15N
	 5K6suluVGSa5A==
Message-ID: <fcddf681-aa4f-4d62-a900-af96c1801fcf@kernel.org>
Date: Wed, 10 Sep 2025 10:07:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: Move DMA initialization to EPC init
 callback
To: Niklas Cassel <cassel@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 stable@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250909112121.682086-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250909112121.682086-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_181006_528020_51FA1B54 
X-CRM114-Status: GOOD (  12.38  )
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

On 9/9/25 8:21 PM, Niklas Cassel wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> For DMA initialization to work across all EPC drivers, the DMA
> initialization has to be done in the .init() callback.
> 
> This is because not all EPC drivers will have a refclock (which is often
> needed to access registers of a DMA controller embedded in a PCIe
> controller) at the time the .bind() callback is called.
> 
> However, all EPC drivers are guaranteed to have a refclock by the time
> the .init() callback is called.
> 
> Thus, move the DMA initialization to the .init() callback.
> 
> This change was already done for other EPF drivers in
> commit 60bd3e039aa2 ("PCI: endpoint: pci-epf-{mhi/test}: Move DMA
> initialization to EPC init callback").
> 
> Cc: stable@vger.kernel.org
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

