Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE86C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4W5QEJ4fboABgiuhxmI/3FxILGh8PSKCqNSvfqgQVTs=; b=IUpCOVVoJzCxOfv7bZYoSyb6jL
	Hc1r+Nx38o27pmqSeu8D/8wxhXnYil4HWumrhtCo7RcuACsuoXREh9TBus2TpiR9VQRghyIScn1E9
	6vxDfZG8N80W3QfBj0MelhNsPN+FBEGmhkOJZXpRgcOMjqr2/XjkbiGCSfO6CHa8A1fe0kydU2thz
	wdCPQzFkofsWeapvvc+onSJhxaoBBRfw8YpGdKr5gvnZ9NuwZY2AYuUew8bwfqDvHoN+EGluPezlY
	mKKq8V81zomHeDB/PjveeirrmTtLRUMMLfCnPdk/NOf1SMA2RLLWokGbpAo/GiPpMBRo7SPeR2E4u
	dzsZL/Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqgjS-009uHG-Ma; Mon, 16 May 2022 19:50:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqgjQ-009uGP-1q
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 19:50:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CB8BA60DDB;
 Mon, 16 May 2022 19:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8AAC385AA;
 Mon, 16 May 2022 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652730614;
 bh=S5RO+qXhsTPILXpl9x6KhmDbz3GVk3TxGDRajm2h1bg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n7kLTWALCLvXHncnoBhSJYFPcoLuu8qgaWkyCqV5aq4b/knPZOTRMMpjLvQvGpNBh
 fXF8YparewK3HV+l5/4L0wq2v3MIfWtO8eKpiYiv2HKX7Sd9kpNS3KJobfV30lQlVK
 o4z4IKYDwd/txq5gjA/5x7YJbVQs2rxxvmP6AxouM0FwjNHUF7QlD5YnaO5mPst0bA
 gsKGueeWg/JXAnBKNY/mpuQrYUfy3ZrLBWY3dxX1sFbwE7Kb9tB0+7fldcE5kMl38k
 M9EFpimGfhFiXlYUfgEXE8XJhg1qymKSV7jlnP+6YDUV2pb4Yb72297Dta7ZhpKcC/
 RfYSaPeiQrXzw==
Date: Mon, 16 May 2022 13:50:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: split the enum used for various register constants
Message-ID: <YoKq87eE1N44mWIj@kbusch-mbp.dhcp.thefacebook.com>
References: <20220516125258.2800718-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516125258.2800718-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_125016_166598_20DF3078 
X-CRM114-Status: GOOD (  11.08  )
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

On Mon, May 16, 2022 at 02:52:58PM +0200, Christoph Hellwig wrote:
> Instead of having one big enum add one for each register or field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

