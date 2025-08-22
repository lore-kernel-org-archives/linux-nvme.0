Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCDFCA0EEB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Aug 2025 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O2VUXKSXWdLNgAVBZljBG5lTZqfv7AYMc/Ilsy59qhI=; b=0fGx5IIJq1+bjPykuWz065ZuXg
	QLz83FLXPQMEVaf1ikYcsxZ9IeAACb7x1AXnPBUS8FfJWnDKJM4o4QoEMJcQne33GHmAFtOP3QF//
	MDHcsy3WLWkr6aH1hCfawFO6w1SlKSox7RblaLRQKLSwQM7hEcSbV2jop7AXFobdc/juSqTCW83mY
	zy57YwJqOoai9Qqtf1fMhjYUbRrE72xZeLPnNe6r96lFiQQnvQxbFcO/yIebS7VZnlqn5FChpPJoc
	6b+aUIO8b/cNdL7mg0kyuGlU9U6aT2P+Me+CN9yLIdCZwFv1rrxA2/z63sNvDAjN/p7NrK/2mkS/h
	6r8JQJDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upTmZ-000000032F7-0fJA;
	Fri, 22 Aug 2025 15:34:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upN02-00000001v6D-3kx2;
	Fri, 22 Aug 2025 08:19:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4288160263;
	Fri, 22 Aug 2025 08:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FF6C113D0;
	Fri, 22 Aug 2025 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755850790;
	bh=HkE8AZTiPlzHsol+TKib6yPCz1oDuxVyBqFtTZA3Btc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMpKRcVM2avITumqfYtpR1lJyNy1YGhcacH85UaXAzpSXOttsKoYASi0FKUaU3c3Z
	 LZHMKa+Bm/tK9LhnO2Le6hkD6TRDDCwIacrsKCKDXxIg3cHlGkfTmyiz4J+tX0OeAk
	 +y6hEJuRDwzIELlvKjoq1Z/cI3PB+gLj+leRv87IKdhqt2q0SAY8ZI6960dHWt5gUK
	 RySJvhreS+KKJ0IDElOiOI+xhgkPpvCHElNb4FFvdwk7IKHfAHFglep3zi7q1pPCd0
	 eL6wJM9h5zVy8CgVKdGsLd1BYeRPNfwPbu3NlXrHrHuE8IRVt4WpZOUTBL6jv9UGHx
	 PdKiNBgxIMILQ==
Date: Fri, 22 Aug 2025 10:19:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Message-ID: <20250822-singing-boobook-from-heaven-ef5cf8@kuoka>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
 <20250821-t8015-nvme-v3-6-14a4178adf68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-t8015-nvme-v3-6-14a4178adf68@gmail.com>
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

On Thu, Aug 21, 2025 at 11:56:43PM +0800, Nick Chan wrote:
> Add ANS2 NVMe bindings for Apple A11 SoC.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


