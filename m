Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B4DCA0EE4
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Aug 2025 09:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SA/5TMjINZ6iwtJ3hPw4J9a3EXYX9q26wmhbkw6ZeMI=; b=X65evknF2hwPrrnjzQGwg76UEk
	BHZ+ue90EpB40FzWilhyxzYyfi9skpC/fvdWVXjJcrvfuQyhyLALXsfgAR/Crp+HsTt1qpVYP5wj1
	nwicCsz7ph5Oixyvd0TBk4eAHMU4vLcHUCaHQBvFB61uovnIK6OJR9UGmoDPZXIFqY3IC+fGi0Lft
	UYVRLcwkazItgYmv2R95zHjRH3yHYKYOzyi9PCNR8Pxf8Ec2dMgxtA1ufOwKPDOoS30YqfCYiZd1q
	ArJa+pn+AWN962y2wB52xAlCzzcokssgA0P8n4Hh0YmoEWCzDBlEC58py9sLXBIL/nlqohEYc/rYI
	HzliPX2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upkhM-00000004Y9P-00OT;
	Sat, 23 Aug 2025 09:38:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upigM-00000004IDF-2bEH;
	Sat, 23 Aug 2025 07:28:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 79655441DA;
	Sat, 23 Aug 2025 07:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7C1C4CEE7;
	Sat, 23 Aug 2025 07:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755934137;
	bh=o5ysTK5lUokkQlsJ4ZNuL632O1gJLfvxM3SuJVSpKKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApN3htTqKwvJMqTVr/MCNwfEyaqVeh/IlfKc5zg0JqC+1mN6hk4VcjlN8dA7tmtto
	 c7lHv/c8FqgXoysYwwm3jNdh0g7s9GYopBJSVUlub/NBD+FxAGl8FWC5vsFiDb9fBQ
	 WrZEhVcBHjveVLoRnK2yC2Sh0/+TNNJ0X4FlO7j5VXvOCFORVUUBE78m9dhPwYerab
	 KGAjaFKOweHoEKoic6MKZUO5pyUc2fVQOhpJ0S5JXt1DVOH0oUYFCjj7wMgNIKt+wR
	 BdW+7oaTBKfr/qk272qhgwc3E3cY3X762rKj0HlhqyLTpXm594vZ/lXy+IQPl9MTD7
	 7qhUcDWV+ItlQ==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: (subset) [PATCH v3 0/9] Add support ANS2 NVMe on Apple A11
Date: Sat, 23 Aug 2025 09:28:30 +0200
Message-Id: <175593408419.53541.12520438370584715457.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250823_002858_679261_47088AA2 
X-CRM114-Status: GOOD (  10.84  )
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

On Thu, 21 Aug 2025 23:56:37 +0800, Nick Chan wrote:
> Apple A11 SoC comes with an NVMe controller that is similar to the
> NVMe controller in M1, but less customized. Notably, it does not
> have NVMMU or Linear SQ.
> 
> The controller is wired to an older variant of the SART address filter,
> and uses an older variant of ASC mailbox, so add support for them too.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/drivers-6.18), thanks!

[1/9] dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      https://github.com/AsahiLinux/linux/commit/32299eb03414
[2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      https://github.com/AsahiLinux/linux/commit/fee2e558b488
[3/9] dt-bindings: iommu: apple,sart: Add Apple A11
      https://github.com/AsahiLinux/linux/commit/08d37b6bdfa7
[4/9] soc: apple: sart: Make allow flags SART version dependent
      https://github.com/AsahiLinux/linux/commit/240893c1f5b3
[5/9] soc: apple: sart: Add SARTv0 support
      https://github.com/AsahiLinux/linux/commit/58b28ca2e669

Best regards,
-- 
Sven Peter <sven@kernel.org>


