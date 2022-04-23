Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB91C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Apr 2022 05:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xu6jWmS2V1JMyV/pquK6LUZ5tejcC5V2x7EeK8T2eUQ=; b=cpb4PxMesRYuRpU6E7jrjiWalM
	MghMmOGWPOMMtNE4Sw0FMFiaA5jdYvXhA+VL2LJahcaSHJedfk5zXrZHbEe7A7+FoTTxCbAJjz6tb
	dj2p38YubBtN/hqVlPDSQkGJt8qDJPf8zUvGSTouj7ogW/wyo4g4jjO+lliWu2ZwPTwRSKu6plMXY
	nC6qkcxgi3fbxevcdD9Zz+qpwved+jMHO010QyyA7qpxwzhRpHu5/M4KtWdou9SjI+Y+ps/UcvANJ
	O3b2/GBbStuGsILM7KRq5Yj99QQdiIBAxoWDaaLmbt9DKuPLriVUX2l1CmGTj093v3Bt1wTiM7VaV
	I4JbYCMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ni8Yb-003Vk8-Tz; Sat, 23 Apr 2022 05:43:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ni8YX-003ViY-OB
 for linux-nvme@lists.infradead.org; Sat, 23 Apr 2022 05:43:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7331568AFE; Sat, 23 Apr 2022 07:43:32 +0200 (CEST)
Date: Sat, 23 Apr 2022 07:43:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, tglx@linutronix.de, frederic@kernel.org
Subject: Re: [RFC PATCH] nvme-pci: allowed to modify IRQ affinity in
 latency sensitive scenarios
Message-ID: <20220423054331.GA17823@lst.de>
References: <1650625106-30272-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650625106-30272-1-git-send-email-brookxu.cn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220422_224341_973430_82209547 
X-CRM114-Status: GOOD (  17.04  )
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

On Fri, Apr 22, 2022 at 06:58:26PM +0800, brookxu.cn wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> In most cases, setting the affinity through managed IRQ is a better
> choice. But in some scenarios that use isolcpus, such as DPDK, because
> managed IRQ does not distinguish between housekeeping CPU and isolated
> CPU when selecting CPU, this will cause IO interrupts triggered by
> housekeeping CPU to be routed to isolated CPU, which will affect the
> tasks running on isolated CPU. commit 11ea68f553e2 ("genirq,
> sched/isolation: Isolate from handling managed interrupts") tries to
> fix this in a best effort way. However, in a real production environment,
> latency-sensitive business needs more of a deterministic result. So,
> similar to the mpt3sas driver, we might can add a module parameter
> smp_affinity_enable to the Nvme driver.

This kind of boilerplate code in random drivers is not sustainable.

I really think we need to handle this whole housekeeping CPU case in
common code.  That is designed CPUs as housekeeping vs non-housekeeping
and let the generic affinity assignment code deal with it and solve
it for all drivers using the proper affinity masks instead of having
random slighty overrides in all drivers anyone ever wants to use in
such a system.

