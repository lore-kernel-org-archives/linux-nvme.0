Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE474D6406A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Dec 2025 01:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p2q4HJSq2v3HLkqniWFzRyMT3Q2w62wiNtIalIXUX1Q=; b=BdamZe5RyFHwoRK9yT6MbxNPjm
	lcsanQBl69L4VKIF57cBh8IGH7GCBZB09rhBuj7TJeV1z6wIi1cj9mIriblRaXEUcQCIkuYOueF4d
	/W1HxtRr4zXXhCtJYYJbimhO6YYglsys+n+d4LeXGEr/jtm727KvalhzjxVjcQix1DNBnSPCibZ96
	R9s8LSp+QTLKLA5mwx3E+Co/XDB0h1ArrR4FyhSYYCY7cMdZLT5KCqRRMvlsFfc/e2DLR9RkDaYbI
	VNdA1XKJR4+RC0Agpu+2T3X9B+kW6htrpRAOUrZU87uq0u4hBcO2iCAdGIdcA6hsIlkBghebCKwyc
	GhHsJcUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVgVU-000000061er-0JAa;
	Wed, 17 Dec 2025 01:39:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVgVS-000000061ei-05DT
	for linux-nvme@lists.infradead.org;
	Wed, 17 Dec 2025 01:39:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6CEDD60097;
	Wed, 17 Dec 2025 01:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2514FC4CEF1;
	Wed, 17 Dec 2025 01:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765935548;
	bh=NA4Vw2hq+9j3otplk6W2mS1RRspVAh6uDRfbVHIcm8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cfzkfsix8xADktgHfOhTOtrBdSf+tiSUsL6XiU3oECsG1/9IFejWD8h8woAlytV+b
	 JkVg9Ac4i7ys4D7hKRKUBLP4g5PZ6L1eh7CNb5T/oA2BZqhXmc5bcamJUv8nREjeVp
	 7haenS5nEWYU0KC4UMHaYUuvqZrRG6xEqlWXTelu2Jpa+Y3c6znTj1+27x7LMQogNN
	 57TbkOBCYUlcTjc80cO4rxjQAKKD/ux9yPxMcXGAQ7nRw3Mmu+QZEHDzHQzt41PXBd
	 AQXFYABTMatfiM2dAJuteRi65wYw9mXWvNLo5K+p4Zsz6cx6hyoNwGla0fGGonCQlk
	 hxU11UrRcwiVQ==
Message-ID: <4bd97775-ff9a-4deb-bcb1-37a11090943f@kernel.org>
Date: Wed, 17 Dec 2025 10:39:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmem/core: fixup minor typo
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251216032931.1305349-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251216032931.1305349-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 12/16/25 12:29, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This is not nvme :) So this should be a separate patch.
Empty commit messages is also not great. Even if trivial, write something.

Nevertheless,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

