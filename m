Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C6FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 21:20:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9D720658
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 21:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dym1xT0c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPkAFIa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9D720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uvt3CnA9ugg85mDQaNDKuAbJmRAIpDc7cfgO3iAscDw=; b=dym1xT0c4h8GVe83ODvhbN8u4
	MXzu7h4FiYNGlvo0imRCVMzwfltWKB6XmeHMeYyt/30roOx9+1MbmvQRUQZ4E7ncyWEwR4SrmE5BJ
	zhH5m/coh5MedWRntNUDu6acByFLmR3hnDkdgZMU6KeE0LdecdlmIhz7cKO4ak8J3fy+RmOaCCVaU
	dPNqdsUXd4/nYVxNXcnW53IuChuFqo8IVbF/Y7vLvvkqIO8/Ss8QAQScZTJe5um7qcLSWhsANRV7J
	GhgjH5kMJqjr8nxKPf0mp1G+pLE8ikFD0an57jQxExUyXwhnumg6/kag6kd/z/2j6WLVvR4GXqzhr
	zW4+MbtGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5yAH-0002li-Sh; Wed, 12 Aug 2020 21:20:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5yAF-0002l6-F3
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 21:20:04 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2180A20658;
 Wed, 12 Aug 2020 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597267201;
 bh=AmjQ5uYR6oxVViDZLWc62fXzkb7VPbyJWVNTNVh5UDk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZPkAFIa+yTSlYrEFmY/Jh8cQ2yc0sgRkTHVvo9m7vi6vkUYbg7PAtOfIXoOaGgvYh
 Vxdg+cbXLcLCBR/MUujLpReYrtpvw/X+pU+PNDr9ZdldrSsbDt+TrAP7r0Y0rqdEz0
 +W2EqGaWz2NGUno3aEG0bGsWpB73jPB/cLB8jsfE=
Date: Wed, 12 Aug 2020 14:19:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RESEND PATCH] nvme: Use spin_lock_irqsave() when taking the
 ctrl->lock
Message-ID: <20200812211959.GA1238450@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200812210119.7155-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812210119.7155-1-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_172003_579486_D3794CFC 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 12, 2020 at 03:01:19PM -0600, Logan Gunthorpe wrote:
> @@ -2971,15 +2971,16 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
>  static struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
>  {
>  	struct nvme_cel *cel, *ret = NULL;
> +	unsigned long flags;
> 
> -	spin_lock(&ctrl->lock);
> +	spin_lock_irqsave(&ctrl->lock, flags);
>  	list_for_each_entry(cel, &ctrl->cels, entry) {
>  		if (cel->csi == csi) {
>  			ret = cel;
>  			break;
>  		}
>  	}
> -	spin_unlock(&ctrl->lock);
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> 
>  	return ret;
>  }
> @@ -2988,6 +2989,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
>  				struct nvme_effects_log **log)
>  {
>  	struct nvme_cel *cel = nvme_find_cel(ctrl, csi);
> +	unsigned long flags;
>  	int ret;
> 
>  	if (cel)
> @@ -3006,9 +3008,9 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
> 
>  	cel->csi = csi;
> 
> -	spin_lock(&ctrl->lock);
> +	spin_lock_irqsave(&ctrl->lock, flags);
>  	list_add_tail(&cel->entry, &ctrl->cels);
> -	spin_unlock(&ctrl->lock);
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
>  out:
>  	*log = &cel->log;
>  	return 0;
> 

Neither of these are ever called from an interrupt disabled context,
correct? If so, you can just use spin_lock_irq() without saving the
current irq state.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
