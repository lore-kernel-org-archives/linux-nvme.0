Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF01CA1007
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 05:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d78W237Ov3pjj5zoTJnwNDCa3ucAFPN9vfLc4BERcDw=; b=xCS77BuMQB87nYTkmKcXnyrsPb
	3/vTMv2xICR03xffdpAhU4lMm5F4xO6K9pnsbbK+ela3bdg5dzrdKfXHdtLX31jAkSOpgg58m5n8Y
	C+bSc57m1szCnwT66TVz2cJ/hLNPEfYMbOq3KOq2yXZCiR0VjHGQMEDMLKHqziIjOlOX5ShrlYTyF
	DCFV4HAYK6ns+jsRAPZodkZV8EXIvENtwDHsAAu/GUQZCJRxvfZrCTmV7KQDRshjB8TusTpqfSJYw
	mVT03yer3ZgQElTpiqDg0w3/KWzUpre/iSYtxUP4IYugTH7PEH1LMDtGmXD25w27F5kd1kLzUA57K
	F6y0b1hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJaR-0000000FJ4F-2ZEA;
	Tue, 02 Sep 2025 05:29:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJXk-0000000FIqK-2Fhb;
	Tue, 02 Sep 2025 05:26:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1565E68AA6; Tue,  2 Sep 2025 07:26:47 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:26:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sven Peter <sven@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Nick Chan <towinchenmi@gmail.com>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
Message-ID: <20250902052646.GA11139@lst.de>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com> <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com> <20250825080710.GA23193@lst.de> <89251134-9685-439e-b220-92717663f038@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89251134-9685-439e-b220-92717663f038@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_222656_718438_B3182DB9 
X-CRM114-Status: GOOD (  16.03  )
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

On Wed, Aug 27, 2025 at 05:56:33PM +0200, Sven Peter wrote:
>> Do you want to merge this through the apple SOC tree?  If so:
>>
>> Acked-by: Christoph Hellwig <hch@lst.de>
>>
>>
>
> I don't think that's necessary since there are no build time dependencies 
> but if you want to I can take it through there.

Merging it through nvme sounds fine as well, I just through up
grabbing everything together would be easier.  I also noticed there's
another Apple hw enablement series that touches nvme, so I guess both
should go through the same tree?


