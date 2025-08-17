Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8A6CA0EE4
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Aug 2025 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HO3+/JfcyrHYkC5TMald0e33SxZCLsVF/iroNMXpPMA=; b=uoEpLOeBl8wawrD/g9PkCq4B6i
	1Hansj0ME4SELc4oeI+wNGePefDi/MbByCmhPZ3odOGdovaHbSAnWWYZHM6GSnFRH8cLvKhy1ugNR
	nF2fGA+mMdILTi1is8e4cH6HonW8deFcVJjtT56izOHcP4q3NuwX0YWWngnBvq3KUMBzEvTUkCHD7
	28kVrJS7G9Ro4K/gIRz5pXhR1N2O7mXFU/90D2FGdlr7py98XIVjoncnA0ntxL2IGnQLIAcK9fzss
	M5Kpq+B1JEzTnyHUwWHy3POpS5f+64xi1sM/kAG1SgFBF+L+oCLOOvP3kcgk+ibaQRfFXpcfy9dKa
	UxcTZFwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unahj-00000005YGF-3sex;
	Sun, 17 Aug 2025 10:33:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unaf9-00000005Y5W-0mRd;
	Sun, 17 Aug 2025 10:30:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 364C7601DA;
	Sun, 17 Aug 2025 10:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EF2C4CEF1;
	Sun, 17 Aug 2025 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755426647;
	bh=ZpdIfkm7dfyECGIXzoxLPteZqCTh3B/QC/zL/1RBl48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bLvlo2oGKvEOSOUm3rp7JoYFpmM0dsAfHAmxHFhv+Mor6QbLMtWl1ftRlbNlALbfh
	 gKtw2BATylljYZMjvGuKWxLP7xHQCJsOwQ50F7SgED8rZ8U9Ozajgo3j5szFA8s/BQ
	 HLQDn9Z6HMvVHB2jFTaqVxOSmE1NyHAiqJf+Y4FGhdtGZ5RQcou2k5L6hhaK+mjhGp
	 kPVXZcl6ZmioZ4rN2GEh+e+gHdzaBv/BWFlvOb3/J8W4COQB4RvFFQiA1slCKzfXMl
	 kCMLMfOw2uqFag7+piqh8iBbmAAhG+DMmh+leF6Ogmt+iAsYsCk9ecQW0uwe4XhZwQ
	 MaSAa/XPbSecg==
Message-ID: <3287eb4b-24fd-499f-b5f0-4af2b509a29c@kernel.org>
Date: Sun, 17 Aug 2025 12:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox
 support
To: Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Neal Gompa <neal@gompa.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Janne Grunau <j@jannau.net>, linux-arm-kernel@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Hector Martin <marcan@marcan.st>,
 Conor Dooley <conor+dt@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-2-ef9c200e74a7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250811-t8015-nvme-v1-2-ef9c200e74a7@gmail.com>
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

On 11.08.25 15:50, Nick Chan wrote:
> Add ASC mailbox support for Apple A11 and T2 SoCs, which is used for
> coprocessors in the system.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>



