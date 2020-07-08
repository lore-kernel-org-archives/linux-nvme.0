Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A220EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 22:23:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF3D20772
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 22:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J5b5TYNR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1UFw5zT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF3D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3pEySVPcU17U98wRjLM/IQEIscg7IlbycqdK03pWR74=; b=J5b5TYNRg1lihZu3Wu1dqeQE0
	gU98B2gbY6VCAfNLEowgTfjsmRJb08aE3XvK2aPIh7a4RX97JAsQUqrjkhj9lVArri4wQSkKCW2X6
	0rhUDuz4lPJBNW9y76uNSobf3pVMJM510Fl3Qnz6sMUh/z2npBhpqQChF2vroYpJzuEjeCKnyk/N0
	lSHI+htxA+1DZOht7oHhMqb/NLv3A8kb6SS7Wd0LGsOn6oUAaYMbNeVdcsbrzitEquN2qtDbk8btJ
	drH/afVElT9mRstOmEVue9iENUUcZFnFCVnIzKw1Xkjg0VaBKBxHfWABvjk9EXhpoQXHQT6405wt+
	50ubhlhFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtIT7-0002Ek-8j; Wed, 08 Jul 2020 22:23:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtIT4-0002Dw-If
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 22:23:07 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 020A420772;
 Wed,  8 Jul 2020 22:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594246985;
 bh=B/eb8pN52hrCRd5QdZj9ziw1lqfxZPxG/3R6n04LmnM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E1UFw5zTOGwc0fu0aaoLC/MXoHnbVZWcuRQkimhzjpQcH8tJ53RPyyEAYHxWLnWt0
 t1+mpTi7v27xobl7wsWeTqs2hd1FqULs9V6wDHyikad7RkKU+uySTIGzxQEZ1xrglS
 aaUEI4eF+WyO8TGmzn+vtfAXloqACgnIyId0ltMk=
Date: Wed, 8 Jul 2020 15:23:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/4] nvme-core: use macro for ctrl page size default value
Message-ID: <20200708222303.GA2288916@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
 <20200708005831.10013-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200708005831.10013-2-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_182306_754418_84130D8B 
X-CRM114-Status: GOOD (  22.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 07, 2020 at 05:58:28PM -0700, Chaitanya Kulkarni wrote:
> This is a preparation patch which is needed to centralize the page shift
> value for the have ctrl->page_size.

At this point I would recommend removing 'page_size' from 'struct ctrl'
and use a #define NVME_PAGE_SIZE in its place. There hasn't been any
attempt to work with different page sizes so I don't see much reason
for keeping the older code to support it. As an added bonus, a constant
simplifies several calculations in the io path.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 898885630ad8..e0b47e77cbca 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2344,12 +2344,7 @@ EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>  
>  int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  {
> -	/*
> -	 * Default to a 4K page size, with the intention to update this
> -	 * path in the future to accomodate architectures with differing
> -	 * kernel and IO page sizes.
> -	 */
> -	unsigned dev_page_min, page_shift = 12;
> +	unsigned dev_page_min;
>  	int ret;
>  
>  	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
> @@ -2359,20 +2354,20 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  	}
>  	dev_page_min = NVME_CAP_MPSMIN(ctrl->cap) + 12;
>  
> -	if (page_shift < dev_page_min) {
> +	if (NVME_CTRL_PAGE_SHIFT < dev_page_min) {
>  		dev_err(ctrl->device,
>  			"Minimum device page size %u too large for host (%u)\n",
> -			1 << dev_page_min, 1 << page_shift);
> +			1 << dev_page_min, 1 << NVME_CTRL_PAGE_SHIFT);
>  		return -ENODEV;
>  	}
>  
> -	ctrl->page_size = 1 << page_shift;
> +	ctrl->page_size = 1 << NVME_CTRL_PAGE_SHIFT;
>  
>  	if (NVME_CAP_CSS(ctrl->cap) & NVME_CAP_CSS_CSI)
>  		ctrl->ctrl_config = NVME_CC_CSS_CSI;
>  	else
>  		ctrl->ctrl_config = NVME_CC_CSS_NVM;
> -	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
> +	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
>  	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
>  	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>  	ctrl->ctrl_config |= NVME_CC_ENABLE;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 85d76981b66e..4a56897e9081 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -37,6 +37,13 @@ extern unsigned int admin_timeout;
>  #define  NVME_INLINE_METADATA_SG_CNT  1
>  #endif
>  
> +/*
> + * Default to a 4K page size, with the intention to update this
> + * path in the future to accomodate architectures with differing
> + * kernel and IO page sizes.
> + */
> +#define NVME_CTRL_PAGE_SHIFT	12
> +
>  extern struct workqueue_struct *nvme_wq;
>  extern struct workqueue_struct *nvme_reset_wq;
>  extern struct workqueue_struct *nvme_delete_wq;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
