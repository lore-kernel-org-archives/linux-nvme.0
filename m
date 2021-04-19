Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E5C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:09:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF6561027
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF6561027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o3O0mEm74ulC6gB4INMWP19lNIONnYyBdN9YBRf4tpg=; b=e5vUN2KScJhGbXvJ4YmibzJWy
	7xI3QCwu1D8BCh30nCXuoXkY0aStlcHg3/K6ohlmPBIjBe2oTKHEI3MHjwhAlywqSEO5/5GO9brLy
	3xI1kZforlUWFPR2ZNpoJrMctu8k2fRMtojbHEzAGBirFMZbq8dxSA0IZu2sc5ExtgDiRk24JLjvX
	aDt8qClWwFPVpv3EWjHi6bMQ3ZDqu4iajZwm8PjSq+cOz9JngEUOBl8nUg2mlIWAKL3m8my293Ryb
	+i7HPLmJVWkxh/8bsbUgmong40xpIQW6qMrWmHMLt8pCM+MznY9/SyO78yvWI+MIzAM3MXDn7yg04
	q5vhpPthw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYO2M-009IKJ-VA; Mon, 19 Apr 2021 07:09:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO2K-009IK5-DC
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 07:09:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rmUj6LdyoCdYgX27otR9dnht8wkNjQh7uYiqoAj6KAo=; b=U73I45yh4qVuqd11qLEEdOzca1
 FhIgOyClrRQOGBKtM456GYr2STatvj0aTcpaY6f4UB5GDSy2xT63ddexfX5T82fcDpVfIDTc/HMfB
 O+odU1XN8o6mjG2xIWplJXaprxpDyE2rjfiR/wQuHpGx/Zq72eGToFT7mfV0e/3ycau9YGggrwo+Y
 yV+d5Hfb38PGuX+mP9CwteEvDsezHgZUdggsHW5Bh6d3omolRQSJqHa+1uY7gjFg6NNSgzCZwHlZH
 q1CDS0htG+iVV6h3cm8eH0u3g+59rmVJ+RXWA1CiJfsqksem9JKEqBHss7/Xl6iIIzMvjOoSiMCeX
 je/y66Tw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO2H-00B6gv-NC
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 07:09:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 407E867373; Mon, 19 Apr 2021 09:09:31 +0200 (CEST)
Date: Mon, 19 Apr 2021 09:09:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, Peng Liu <liupeng17@lenovo.com>
Subject: Re: [PATCH] nvme: do not try to reconfigure APST when the
 controller is not live
Message-ID: <20210419070931.GA19563@lst.de>
References: <20210409094905.1920747-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210409094905.1920747-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_000933_926701_D70A4012 
X-CRM114-Status: GOOD (  23.05  )
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

ping?

On Fri, Apr 09, 2021 at 11:49:05AM +0200, Christoph Hellwig wrote:
> Do not call nvme_configure_apst when the controller is not live, given
> that nvme_configure_apst will fail due the lack of an admin queue when
> the controller is being torn down and nvme_set_latency_tolerance is
> called from dev_pm_qos_hide_latency_tolerance.
> 
> Fixes: 510a405d945b("nvme: fix memory leak for power latency tolerance")
> Reported-by: Peng Liu <liupeng17@lenovo.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 63a1e6cc27acab..f3c7b1cb2c7c8c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2740,7 +2740,8 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
>  
>  	if (ctrl->ps_max_latency_us != latency) {
>  		ctrl->ps_max_latency_us = latency;
> -		nvme_configure_apst(ctrl);
> +		if (ctrl->state == NVME_CTRL_LIVE)
> +			nvme_configure_apst(ctrl);
>  	}
>  }
>  
> -- 
> 2.30.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
