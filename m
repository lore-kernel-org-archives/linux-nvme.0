Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C6AC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 12:32:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B976108B
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 12:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B976108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JgOGyMGzPN6fL1Pdf4tg1NH5BefRDXFhsJrW4500F5g=; b=kJA0VVL3Vpdcu0O4afNkz6Sry
	7pILNvNt16xknmNEybiDtKGWd00eX5Hd5sI9I6GaHiHe3UsrZZKIf4zYIiRBWFV47ghuZiySMvcB2
	oHqpB/d00DrzXjSGl18/dv99EenYEGqt9WJElIZzBMC8MtjXzRpThDGNlaWEAd2gb8lqE+szxsUXv
	5D+tKkbEX8Pr+OMnCtdc5mTCfL+Vu6nlpMKnS5vzDqgGmscUtMercrxt5vh/5KyWLg0R1QJiO7Lev
	w7xpH2F4sA5e2MX0ceZrhlkZ8sYA6pwJw/HjSCZt0FGv5gS13Az1cZ5PLOiE6VRKzJDc9bAaMJh7n
	DONtcSPKw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljLMs-003uZO-MZ; Wed, 19 May 2021 12:32:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljLMb-003uUq-DL
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 12:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YH+jGIPtyJ+xvLV0tAMzJECCCU/0AhYmyMa2M87nB34=; b=1c41ozsodCemIy03hLODD7Umzh
 6hjx/+hg+59IhYnwj0dpjzBnyIELqM1+qY9qRpWkdH6KMPrA/bHoj7o9MjmnP6Azr4i2qJ3aiUM8k
 9LaLWzOaA8QFBdhJHvT0hCElkbA5b0lYO/5uTG1PVLE9SX3f/FU23tnF9EW5yOMJHAh9JRvb0YLLr
 Mti67ATjBLtercUiiadgBL0JnqYOSD77ouXM+RkIOUydkmTSPAT8RQupKoXeyMlrwcWc9nKp6zoSF
 O1rO1p7zWrfzOipktbxnYLuRcS/i3IlT5e7OY18v4bfMr8KlluxcLi1UBu5ylCGW1q4kXOa6LtyPv
 yHmrhM/Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljLMY-00FSBS-0s
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 12:31:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1B22611AE;
 Wed, 19 May 2021 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621427505;
 bh=3cBi6fz+/eFP9LuW39RB4wx6VaBTUibEBtExViotDuw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MGM0vZrGMOv8kXu2F6kBqWXB8Id2PBrm/vHvZqGg1pTm9t4a6xu5LMyct7Fn0GB/V
 cT9Hopw3g/y7NqlLfXTuIFWyTGsv8UWAQ6BFq+Wa/ymi94ros3bc/90jiZgYHE7RZp
 M+M2hXFnEv8pqEvXjvM737cNe9BkCavdQGnCqfzXawC2S0QGuZcqaFyyAVwWuMD5QF
 tiJgVz46W2ESJyBAjNNX6d+3Wr5zkWa4GAqb14pe3QBh+/XJBCT9wFZGRm7mgwPrNw
 ezKn/6veXJ8XurmDrUZnkixLOrjemUpUnOwHxLsWH0Eval1l7HShCW5dcf67UvfYVZ
 oMZmpCSjR0wSg==
Date: Wed, 19 May 2021 15:31:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Shai Malin <smalin@marvell.com>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 davem@davemloft.net, kuba@kernel.org, sagi@grimberg.me, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, aelior@marvell.com,
 mkalderon@marvell.com, okulkarni@marvell.com, pkushwaha@marvell.com,
 malin1024@gmail.com, Dean Balandin <dbalandin@marvell.com>
Subject: Re: [RFC PATCH v5 17/27] qedn: Add qedn probe
Message-ID: <YKUFLVHrUdzEsUeq@unreal>
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-18-smalin@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210519111340.20613-18-smalin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_053146_127092_8D31A777 
X-CRM114-Status: GOOD (  21.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 19, 2021 at 02:13:30PM +0300, Shai Malin wrote:
> This patch introduces the functionality of loading and unloading
> physical function.
> qedn_probe() loads the offload device PF(physical function), and
> initialize the HW and the FW with the PF parameters using the
> HW ops->qed_nvmetcp_ops, which are similar to other "qed_*_ops" which
> are used by the qede, qedr, qedf and qedi device drivers.
> qedn_remove() unloads the offload device PF, re-initialize the HW and
> the FW with the PF parameters.
> 
> The struct qedn_ctx is per PF container for PF-specific attributes and
> resources.
> 
> Acked-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/hw/Kconfig          |   1 +
>  drivers/nvme/hw/qedn/qedn.h      |  35 +++++++
>  drivers/nvme/hw/qedn/qedn_main.c | 159 ++++++++++++++++++++++++++++++-
>  3 files changed, 190 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/hw/Kconfig b/drivers/nvme/hw/Kconfig
> index 374f1f9dbd3d..91b1bd6f07d8 100644
> --- a/drivers/nvme/hw/Kconfig
> +++ b/drivers/nvme/hw/Kconfig
> @@ -2,6 +2,7 @@
>  config NVME_QEDN
>  	tristate "Marvell NVM Express over Fabrics TCP offload"
>  	depends on NVME_TCP_OFFLOAD
> +	select QED_NVMETCP
>  	help
>  	  This enables the Marvell NVMe TCP offload support (qedn).
>  
> diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
> index bcd0748a10fd..f13073afbced 100644
> --- a/drivers/nvme/hw/qedn/qedn.h
> +++ b/drivers/nvme/hw/qedn/qedn.h
> @@ -6,14 +6,49 @@
>  #ifndef _QEDN_H_
>  #define _QEDN_H_
>  
> +#include <linux/qed/qed_if.h>
> +#include <linux/qed/qed_nvmetcp_if.h>
> +
>  /* Driver includes */
>  #include "../../host/tcp-offload.h"
>  
> +#define QEDN_MAJOR_VERSION		8
> +#define QEDN_MINOR_VERSION		62
> +#define QEDN_REVISION_VERSION		10
> +#define QEDN_ENGINEERING_VERSION	0
> +#define DRV_MODULE_VERSION __stringify(QEDE_MAJOR_VERSION) "."	\
> +		__stringify(QEDE_MINOR_VERSION) "."		\
> +		__stringify(QEDE_REVISION_VERSION) "."		\
> +		__stringify(QEDE_ENGINEERING_VERSION)
> +

This driver module version is not used in this series and more
important the module version have no meaning in upstream at all
and the community strongly against addition of new such code.

>  #define QEDN_MODULE_NAME "qedn"

And the general note, it will be great if you convert your probe/remove
flows to use auxiliary bus like other drivers that cross subsystems.

Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
