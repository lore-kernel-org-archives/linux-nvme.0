Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77BEC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=szteg4QXcSq6cuZGCT9/As1whfNULyyzOc5D/CzarQs=; b=WuJEtMwSZG7Gw71iWkkM5p1L5Y
	p7tnBbKgBtaYsI6Gd9y4e5zqFGbC8TRV0js49wvxcQLKDIgysP34CcyxBShum4ldh0ASla9sI2RGz
	scDyjE5k8n+cTKDDFXNebxfpLx1qJst8L3LOixZWs1OXzPe3A4OZGtVGYFvaq+4pbjrfY3NHQbRDM
	Rqotjx03RcO+9N5p3SfaVi0+SIOEHr3HYJ5DZkeYq8VH8tNsJe8kBOIYyOwOWnhzd77Gsjo99OS+P
	ppoE3PdZDSqWb85Es2LnycTbLD5LWPFAn84s2BS46L5iFMDFEv51lNBVEKDQAwkfSo0mC6QT2nA8d
	MDsYPZVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiT2-00000001CtY-3jp5;
	Thu, 09 Jul 2026 06:42:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiT0-00000001CsK-2SLZ
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:42:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9734868BFE; Thu,  9 Jul 2026 08:42:34 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:42:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: guzebing <guzebing1612@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: Re: [PATCH] nvme: make firmware activation poll interval
 configurable
Message-ID: <20260709064233.GA18381@lst.de>
References: <20260627010610.47768-1-guzebing1612@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627010610.47768-1-guzebing1612@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_234238_777634_1D961BE1 
X-CRM114-Status: GOOD (  17.06  )
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

On Sat, Jun 27, 2026 at 09:06:10AM +0800, guzebing wrote:
> From: Guzebing <guzebing@bytedance.com>
> 
> nvme_fw_act_work() polls the controller processing-paused status every
> 100 ms while firmware activation is pending. Some devices can complete
> online activation in only a few hundred milliseconds, so the fixed
> interval can add noticeable latency before the driver observes
> completion.
> 
> Add an nvme_core.fw_act_poll_interval_ms module parameter to make the
> poll interval tunable. Keep the default at 100 ms to preserve existing
> behavior, and accept values from 10 ms to 100 ms so systems that need
> faster completion detection can opt in to a shorter interval.
> 
> Signed-off-by: Guzebing <guzebing@bytedance.com>
> ---
> We recently observed this issue while performing online firmware
> updates for Gen5 NVMe SSDs in a production environment.
> 
> During firmware activation, the kernel quiesces I/O. Detecting the end
> of firmware activation earlier lets the driver unquiesce I/O earlier,
> which is important for the long-tail I/O latency of production
> workloads.

What value does this device report in the Maximum Time for Firmware
Activation (MTFA) field?  It might make sense to scale the polling
time as a fraction of that instead of requiring a manual override.


