Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1180C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abWtfdNrRPghhgXXOy7oSEiQ9d/RLQHAGST6z2cZjjY=; b=us3XB7aDMQJBlw4DseANFL32n0
	zJi02gfnF/DYpPzGBpjn4PCgFzHQZladwI+oKXXUUlzjAyn7KQhwBiVgBGXECwGow23uZ1DMVgwY0
	vmJNd8iBQJHpkHFtAxbz7TaxWMzHCsZA2edGBkCej/LJrSlM+PA8B3kHeBk5+tf+a09At4hI7x6N3
	Cn7cE+BjTrqcar0H2QJ22n3iAhuhv4qMWLJ0I9kxZxKabTKJ9Fodsm/z2Q6f4lHUJudsHjauNi5EE
	KWYh4xD9th2zyctFvx9MqcSC/nh1/UXv9+qXyoxtY44mbW6BSf1RGIzeplm1Fuvcd1h/E39XfyYtM
	DUKwQnEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0C8m-00000007jl4-24rT;
	Thu, 03 Apr 2025 04:25:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0C8i-00000007jkT-3M7c
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:25:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 671CD68C7B; Thu,  3 Apr 2025 06:25:04 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:25:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yaxiong Tian <iambestgod@qq.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: Re: [PATCH v3 0/3] nvme: Add sysfs interface for APST
 configuration management
Message-ID: <20250403042504.GB22360@lst.de>
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_212516_982261_8FC26644 
X-CRM114-Status: GOOD (  12.32  )
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

On Tue, Apr 01, 2025 at 05:22:06PM +0800, Yaxiong Tian wrote:
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> 
> This series enhances NVMe APST (Autonomous Power State Transition) support by:
> 1. Adding warnings for PST table allocation failures

That looks fine.

> 2. Exposing APST tables via sysfs for runtime inspection
> 3. Providing per-controller sysfs interface for APST configuration

Who is going to use this and how?  We'll need proper tools for that,
and in general I'd prefer to have a common set of policies for APST
configurations and not random people coming up with lots of random
policies.


