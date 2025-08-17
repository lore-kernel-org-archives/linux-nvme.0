Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF66CA0EDC
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Aug 2025 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8setlsk3Gi+UtRd7yCHGNrFFCcKu03l5lKx0sFx0mE=; b=2hDAgv1y5dWWYYUevjahMBo9O7
	4PzBxKzjVWWOzeQf2t/Q2w1yMJa+0/rAoaOWlRQbaqw9JiA0pq3+qdkNQd0AC+T77deKAPXj98LA/
	6mBIFkGupapjLPSJ5mwpuvUaWTRNrf+VuRw4E+4vMb1Iz2Bk3SVUxBkZpi/JO9x37enn8Sp9Vi5rL
	DCUHkoyim30cCPwQXbIMQ5jsUb5bNC5rmkMqAR37qTjA/vsLp0vKwrcCWUx8Gc0pA56W0x8Up/ao3
	YSSl3uughd04hdvzPWzFpW+YXSbtE9JU44TZgtaaNhNDNYp87cIcoNHfJtv2Tkf1+JR2l5oI/NxTi
	3a6oKHNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unamx-00000005YjS-1WTB;
	Sun, 17 Aug 2025 10:38:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unagc-00000005YAm-2BrJ;
	Sun, 17 Aug 2025 10:32:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DDC0D44EEB;
	Sun, 17 Aug 2025 10:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A25C4CEEB;
	Sun, 17 Aug 2025 10:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755426745;
	bh=+Vo2OnMyV3S44FBuzXLli41+EUkEtk3PGeDWSIzIeaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DfiolxKHZvFlGP/P4mTZrq12w4mu8/gEnqIQJjyd0QyFbviifGrfC6IM9lkJ+HWvT
	 WVZULhE3RBrN5QDYhFGOmlLv3KHFWq7nX666fVQw659HB21BjT+bGA+tSzJBalBATx
	 zxmBuRoXAozSIgyX7MlVMCsFXPrqs+l2ZXhNkNI4YhG3KS7N1DF8Ab2O4RKkKW7L86
	 UfiCyG0BZ+DzKhwjBATUcspeB/r3hJa9Bg59LIdLsBNqxXBmXgz+O31D3Bd/ym8WtH
	 hWxgUPmSzIBW7uHLKjuRisKy8HV9vKMUHiZ56Ho4I9+xIIAbGuj2eA9rOaLdsBiTWT
	 8LVNlpN/0qGMg==
Message-ID: <b9ef651e-3e37-4a3b-82da-04bd2b085ddd@kernel.org>
Date: Sun, 17 Aug 2025 12:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] soc: apple: sart: Add SARTv0 support
To: Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Hector Martin <marcan@marcan.st>,
 Jens Axboe <axboe@kernel.dk>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, Neal Gompa <neal@gompa.dev>,
 Christoph Hellwig <hch@lst.de>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-5-ef9c200e74a7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250811-t8015-nvme-v1-5-ef9c200e74a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250817_033226_583437_48A4B13B 
X-CRM114-Status: UNSURE (   5.50  )
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
> Add support for SARTv0 as found on Apple A11 SoC.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>


