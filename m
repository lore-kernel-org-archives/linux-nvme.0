Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290ECC021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 05:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vSLec8ETTHERtaHFy4Xp9QgmnxKG422HkpMXjEIF64=; b=3jvw8vE5NLgTiTKVfmAwUxmqHS
	Ejn+0YyW/jHUCuIketi2FXIS3vy5hxHuGaMZv8VkbV7o4powkKbRsqlhiIeOzMNwwbeHEfuUI8OcQ
	Gy0M1A++TL9ErM3cd+0vZRSdY8KwmW8r0++pnfQ/haRlnZFlSjDJYtoYWtzQCervApRmI9m0cCEzx
	TQmedSeMSI5YD169WDwYPkby/sPglFQX9Vbw7js4mMjctfGwvQkZqQDqW3lFhLRTqRndAoJX62j0P
	yS/tAT9OXfjvT2zvQbtsTk8MemXP2E4s5ohcm+qeDuH4mTjaoCgGwOilSiHx2i1zVjP1fvoOy41IU
	1lewzhww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSCR-00000009quK-342J;
	Thu, 13 Feb 2025 05:55:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSBa-00000009qoW-2iEC
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 05:54:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ABF4E67373; Thu, 13 Feb 2025 06:54:49 +0100 (CET)
Date: Thu, 13 Feb 2025 06:54:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
Message-ID: <20250213055449.GB19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212170444.16138-1-uwu@icenowy.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_215454_824712_D42FBEF8 
X-CRM114-Status: GOOD (  11.72  )
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

On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> Here is a small patchset that is developed during my investigation of
> a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
> SSD), which is because of the SSD's too-small CMB block (512KB only).

Hah, that's certainly and odd CMB configuration.


