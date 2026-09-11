Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8812BC88E45
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q+v1gtFzTVZ9q73cE4Nq8oqrnGDKcy3JKZg27z2WKH8=; b=eJqRlU88YxIQf7kkMsmAMSLYQn
	esVKQdY/3bxUJUA+JgLh6LpKz/PP6BO9kJsCH0Xm4ERmgQDle+OTBR/jv1Qo6D8qTyENRJzvpdzrt
	CaChsEhYXVONwc14Qc/Aons2aVG5isG7/BcbIWjMFkedTZrckN8Im34/FBe4WEumJqmS7Jwuogz/J
	7HGSupOUFwWcA4Et+5z4S3YHX2GPa3lQOVJTUDT68sJKs6oiQvkcIVVTGt/f9WmmAIPP8txoYpcMI
	5TXdSxp/bupLLI0qpoELHS038nfix6WLWSo2AP6DdaNnka+LWcCt6UfWgFhj0gdQsh0HwNBsW+YRF
	0/OJCN8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x535N-0000000H21F-3PkO;
	Fri, 11 Sep 2026 15:22:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x535M-0000000H20Q-2DhW;
	Fri, 11 Sep 2026 15:22:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 050D341883;
	Fri, 11 Sep 2026 15:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8EF1F000FF;
	Fri, 11 Sep 2026 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140159;
	bh=q+v1gtFzTVZ9q73cE4Nq8oqrnGDKcy3JKZg27z2WKH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DKZRuG22tMKiaV1cnpgF9/BNc3PHSh2tuhVG69RHesvJPA4iTQhpuyG1IqYuHAcTq
	 YoT2RrTEiZd2GD9q0OBK63mTsteCW/akfGzq3yI4Gv93AAeeSqspopySPQMb0txPXG
	 7BIWuQMcyigy/44YksoFS6d21BdEnZeOeVd3GsK+7O1bK3aGCOm5eXz/HihjZ6iDma
	 7qJtC8Z+L32JpDW3aiDV7ApiyzZAT85Y96Zu8cRCDgEiKP4MqUFz1qSOq+H70hmJgx
	 4NTbatYQyAM8cdYhDHa2ODijPAGY8z83k0frGa4UExCM/LMfz3XSd3J786uLF6UwgO
	 bHwpY3iIPBnjA==
Date: Fri, 11 Sep 2026 09:22:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/2] nvme: apple: add t8132 (M4) ANS2 NVMe support
Message-ID: <aqQcvdAl0FA4wslB@kbusch-mbp>
References: <20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev>
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

On Sun, Sep 06, 2026 at 10:15:28PM +0200, Yureka Lilian wrote:
> This patch series adds dt-bindings and driver support for ANS2 NVMe on
> the Apple t8132 (M4) SoC.
> 
> This variant requires the IO queues to be registered using additional
> MMIO writes. Otherwise it is largerly the same as the ANS2 NVMe variants
> present on Apple M1-M3 SoCs.

Thanks, applied to nvme-7.3.

