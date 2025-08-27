Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857B9CA0EFF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Aug 2025 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OGOnfkjO393/aA82rEie7x8SewnSxBd0bd342oBhvYk=; b=0wMdhmN0tp2FALktyawInpZk4P
	xBan0cPGmd3Kk3qlFJorJDl3ZxuYUyUmA+RDL3LU5bTZ9KD0WNn1emrMWUqGbS6oiE75Da3ClWVH3
	maZadJKij0BYBU6V0Goc2NEPBDxTAT1dbGwbjE6sWJZfoK2EZqL7nkeiHfQI5OsXfAVKNuKqE3Uvg
	bjS8ZWSyJKpfIGo36UEubsem81Q2UHPZj2sh+RqeMGdsDgU63D4IVW5f6EBi7jhR+/5vFJqDZ0hlO
	rED+ZyBvBkIVYL6/a1XFKe5FM0YBQIzV+FV+DUemQgEmYpwlc+5lba/bU6L3hecrc9V0x87PmSiTt
	56RI4WnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urKMe-0000000GNUI-0kR1;
	Wed, 27 Aug 2025 17:55:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urIVt-0000000G5y5-07xj;
	Wed, 27 Aug 2025 15:56:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 202C660008;
	Wed, 27 Aug 2025 15:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D2C4CEEB;
	Wed, 27 Aug 2025 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310199;
	bh=ziop8ByzeP3o/TkE8zYyoxz54jgtYl6UGalrslsR+Lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u7B4H2l1ccA+a6oBnVc0pqC9CMtUhz8m3wz7OB4PtcTdzBGzdGjBE/InkWWODNl7B
	 D6Q7dn8aiVnb7zNZbDh70IJObDZp9ggWwybDjVDB6AvKqQm+zkd5foCjrhUkKSG3IA
	 Ahf42c7zABg+lhaW1+TFpk+wJmGlUNpEPOUDtfdGkgzyUHbLoREUzxzlLOkIHwOZ7D
	 Rlys2izNtCTsyI9sAJPvRQAogj2N7t/WEJH6yXPFjx3Amqsm93rvRKLA1hJVj6/Ox8
	 qRDAzEQNquR1KXFAl3NsqVkvy4uMokYpIGYTnfe6lAiYK4qq6w7y8Bmc0kk8FKk2Ak
	 oHvO+Ha3Yabnw==
Message-ID: <89251134-9685-439e-b220-92717663f038@kernel.org>
Date: Wed, 27 Aug 2025 17:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
To: Christoph Hellwig <hch@lst.de>, Nick Chan <towinchenmi@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
 <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
 <20250825080710.GA23193@lst.de>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250825080710.GA23193@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 25.08.25 10:07, Christoph Hellwig wrote:
> On Thu, Aug 21, 2025 at 11:56:44PM +0800, Nick Chan wrote:
>> +		writel(anv->hw->max_queue_depth | (anv->hw->max_queue_depth << 16),
> 
> One long line left here.
> 
> Otherwise this looks fine to me.
> 
> Do you want to merge this through the apple SOC tree?  If so:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 
> 

I don't think that's necessary since there are no build time 
dependencies but if you want to I can take it through there.



Sven


