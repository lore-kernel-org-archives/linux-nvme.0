Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA48CA0EE4
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Aug 2025 10:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJ4XJmPsFhDWRFqXmSHTCNYpT8Iam/wpys8PsCFzydQ=; b=nVeToZLdFIhNxvhDSpRTCuf2IO
	f5Jhi3gpxq62V5eYuv15U7ATkookiWYc7bpt8gplnJGfibvsVsUToFRGe7SC2ShLllzHkoqoOVT3V
	HqjzvziccwN7er6PZ4NPmvSQideH7s0RXlKihAIY5CPKwbo/3BGr8Mwg4ongtDCY94oP1B9R7/pE4
	/EXYVFLJ79zYTJOEs0ZLBdNJGl79+dxkfs6x/bvDDFEl9uTjhOKB5u88OHmhBnjeCoFlzzYLeDno2
	PbZ9zGe1GxwvnVrLKkD/ACNyw8bOp/ulEa7QZh+0Vbw9YQ8DNDLLIQZDquIXN2mz2kJYFrgWPGHO6
	eR7kPXXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unakM-00000005YVZ-3Jk8;
	Sun, 17 Aug 2025 10:36:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unafl-00000005Y7i-3b4W;
	Sun, 17 Aug 2025 10:31:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C9E895C4A29;
	Sun, 17 Aug 2025 10:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A03C4CEEB;
	Sun, 17 Aug 2025 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755426691;
	bh=xBBiE5WdAUPpvLQbRAatiXL9xSljMYM/qDXrY7Yqptg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B0XMiPl6hsygWKcyNYXgNpr+hcuMosl2YoYW9o2Y1YUzbLZTabKWsKTR79aRncyU0
	 eQ3utSKm2JbvBVcC3/dSwH5RBb2xEk0mc8Ml2iKv+IdEKIcx9fqzCjgGdcfJN5hNxw
	 3xi0lauQV0sa2paZ5tUUEk/ZCeqSifwvIryqFTt9EzX1xTrT/G+YiCBS35X3bpiXrM
	 rk4CXXbXYcizCvUu0xIbddNgGPPNVVvvze6qUvzqs84bk2SAS4lGqgF8SxyVKjE/nO
	 xKWZV99ypLiIEUKrACtEsocwQX1Y6/mO2PUgNXZmxibHIs8adKSoxt5GiAEJzWiUfv
	 QGrgaoKkIXTAQ==
Message-ID: <1b7adb41-5002-41b4-9108-eeb6001424a7@kernel.org>
Date: Sun, 17 Aug 2025 12:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] soc: apple: sart: Make allow flags SART version
 dependent
To: Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, Janne Grunau <j@jannau.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Hector Martin <marcan@marcan.st>,
 Conor Dooley <conor+dt@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, Jassi Brar <jassisinghbrar@gmail.com>,
 Neal Gompa <neal@gompa.dev>, Jens Axboe <axboe@kernel.dk>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-4-ef9c200e74a7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250811-t8015-nvme-v1-4-ef9c200e74a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250817_033133_941912_18AEE460 
X-CRM114-Status: UNSURE (   5.58  )
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

On 11.08.25 15:50, Nick Chan wrote:
> SART versions that uses different allow flags will be added.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
Reviewed-by: Sven Peter <sven@kernel.org>


