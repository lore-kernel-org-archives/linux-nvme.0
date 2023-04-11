Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD090C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2GrzSsW8cIumrTwfLkg3oW4T5zu+ClZjAkaVxqCv28k=; b=q9yFnUQTrcoG6FMt+FrNG4alxx
	l2Dqhtg1IiXPloQaVpD/hE1HOykyYHCgXbPo5Q+b0/XqYQTFv83OwyM74G5Qlcxas44yV3r9WIS7C
	kGymkvvioQtH+TdSZ9CvxqWJ5GQWX3CnwrP6MXm0ndXvJQHBV0dryC+m3+gfpHoDidOyybesHpEnn
	Ry7lNe7sZa7PIh8ih6LK677HVe8dHmvDWUcgwG9KEagw5BzlIdUEi++XeWLbiS4sWTjqhWfknfiAv
	6dlpXS7mwPG26/vOEp7hypqD6qItYmPSDqW0ah5+m2prDqXs3DRV1/p1zNO39zKBONYdakdwxZBZE
	U1FvnoRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7Cs-00GY51-0a;
	Tue, 11 Apr 2023 06:10:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7Cp-00GY3l-1u
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 06:10:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8A4968BFE; Tue, 11 Apr 2023 08:10:12 +0200 (CEST)
Date: Tue, 11 Apr 2023 08:10:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <20230411061012.GA18624@lst.de>
References: <20230407145845.79557-1-krzysztof.kozlowski@linaro.org> <20230411060900.GD18527@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411060900.GD18527@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_231015_772674_3AD1E874 
X-CRM114-Status: GOOD (  11.79  )
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

On Tue, Apr 11, 2023 at 08:09:00AM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-6.4 with a trivial whitespace fix.

Actually, I've dropped this again as it causes this warning:

drivers/nvme/host/hwmon.c:221:19: warning: initialization discards ‘const’
qualifier from pointer target type [-Wdiscarded-qualifiers]

This looks like we might need a core hwmon change first.

