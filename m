Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54D5ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 19:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYgwBLBYsogmAvUwyqojYMa2b+fW0hHsVPylUYUan7k=; b=kECm5I7OA7R0ruX5ebzCLE2b6b
	8+e/+Z4SabTKPd4UG1T0MCnXxGHILFKo3HRP1fWwy0rGYz/1OMa97skuqlZc36YT08DDCYYW3qp4U
	QZHzFY0J5eWbaJ2Tubf8k3LLmf7NgtIvCNTt0/2NT4ot/RfALb7DTocjqLF/AbxgoMMKOeuK1QxCt
	Lv1e1w/wYDs8YN2dewnwxrTuV2PKvOhPVQ9pS9Rm24QLkMvC0ZXIqkgjHHorM1FsHA8nbOz/u4CGB
	sBChZtrbjN58aiiVL4ub7iRnj4S8RiR5TqDDD8/3DyUssIkEkzT+qKzsG1aVrxDO37NsMsJSYw4/f
	IQ9q8bzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWjtk-0027RO-JE; Fri, 09 Sep 2022 19:42:44 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWjtg-0027Eu-TW
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 19:42:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 47133B82346;
	Fri,  9 Sep 2022 19:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE4DC433D6;
	Fri,  9 Sep 2022 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662752558;
	bh=J4h0e1eeHD+F345cJw7D5vWTYQ3cTiWfm7V+L/GXkrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPGhEzE0ic9kseOm2K6qxxz0hcm3QgU3PIGTsapTt3Gu6YUZuEMV7JcNfIe+lT+Jj
	 giFnL2k3y8frDA1x//9/UPSfAVNfq7/KPteflKfEKeGcNc3uQX/Lefq56eMVmJtJOG
	 HXKiGzA4ekzDFUW5102gMIwlvxz2U2UUCr0jD/3ltTpS0Rt+nn88I+o9pM6Sw9tjaB
	 58RQ7mjb7/ku5gfAdYxzf2OYfC4ecDPrRyPxkUMTHXGE8YVdq3mRu62R11cta9/Vo8
	 JHjg5RHBWSKGFBqcB2qpxkTevxEhwItTGUQ9V6HJ0kNmvQK7RXIWAWt6XFw5oPNrhT
	 0Zu4cU4jkz45A==
Date: Fri, 9 Sep 2022 13:42:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Guenter Roeck <linux@roeck-us.net>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <YxuXKrkVbGBJwxRS@kbusch-mbp.dhcp.thefacebook.com>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_124241_500001_FF8A1FCA 
X-CRM114-Status: GOOD (  21.23  )
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

On Fri, Sep 09, 2022 at 10:19:15PM +0300, Serge Semin wrote:
> Recent commit 52fde2c07da6 ("nvme: set dma alignment to dword") has caused
> 
> Folks, I've thoroughly studied the whole NVME subsystem looking for
> similar problems. Turned out there is one more place which may cause the
> same issue. It's connected with the opal_dev.{cmd,req} buffers passed to
> the nvme_sec_submit() method. The rest of the buffers involved in the NVME
> DMA are either allocated by kmalloc (must be cache-line-aligned by design)
> or bounced-buffered if allocated on the stack (see the blk_rq_map_kern()
> method implementation).

What about user space addresses? We can map those with cacheline offsets.

> ---
>  drivers/nvme/host/hwmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 0a586d712920..94192ab7a02d 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -10,9 +10,10 @@
>  
>  #include "nvme.h"
>  
> +/* DMA-noncoherent platforms require the cache-aligned buffers */
>  struct nvme_hwmon_data {
> +	struct nvme_smart_log log ____cacheline_aligned;
>  	struct nvme_ctrl *ctrl;
> -	struct nvme_smart_log log;

So this by chance happened to work before 52fde2c07da6 because the field
started at a 4-byte offset on your arch?

The change looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

