Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E84FC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zobQoMJQOgDPYr+MKSzRl6L5Jyg4cU9WZMtWqTxs5eU=; b=qlo11qfPsgUYTZdVX/zY6YImtm
	veZoCisjU5hnrax+0xsSGEyWwBv+y58VS/fMEZEywpjhRzkRqvUGE5U2/8Ng+8YvATrNH8k+Cwl7P
	V9mSVAbfIF33QPtTpuBw4zT91ZsJE0lUVG+BddZEiY1VePEUkjEKVfr88LnSTNhlP5qFhu6Hcw6L2
	1w86TnolX0QMoQyb2RG1kbVqoD/pR1LrQ0rkN1oWS3TvGihsctiPVUdZGlwfKYMS8+gBe+Jj44eqY
	5a3ZI8XvpD45ICOSBJT5UbUfGw8TneuujDXWGl6iUEWfByAyIFA1emm6vOp/KQcuGysHBb+k/eoba
	rkwPb7xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p03Sx-00A7HV-JV; Tue, 29 Nov 2022 16:28:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p03Sw-00A6y7-F8
	for linux-nvme@bombadil.infradead.org; Tue, 29 Nov 2022 16:28:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zobQoMJQOgDPYr+MKSzRl6L5Jyg4cU9WZMtWqTxs5eU=; b=opentWqUU8yu2r1t3G+DZ22urZ
	uugtcVPi+q6mPP6rGD9ArL2VpE1xV8xtfSWpVugUEeWtjk0zP8sGZ06q3PIOhDNo/YGhmxT70ItFz
	AwmljP5JYTHFG4C2J14+noksccSWx2Lz0UWMnYGJ+PzoaqCos/D7EGj9p6s8X0ESU4ZvGKeKaJoYQ
	3/12oD8UoPxCzxSpns743bd4QWf8LWeGc7prGFsnnIaeXnyKw/7RCl8yUzQWmR5/POC3vIjPD/HKj
	Ohs9rTnMYPopiv7Z14XZ56XUU7Jn83iP4ZUWBPC6o3jbPqxZFH4itNRrs/XvjfNjRpDas9WkaWopv
	tdieopiw==;
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p02z7-005qND-1s
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 15:57:27 +0000
Received: by mail-ed1-x531.google.com with SMTP id m19so19148941edj.8
        for <linux-nvme@lists.infradead.org>; Tue, 29 Nov 2022 07:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zobQoMJQOgDPYr+MKSzRl6L5Jyg4cU9WZMtWqTxs5eU=;
        b=q4sXHesc5/0QCp5Sys2Nanc1+4D1QI7+4OGz5l9v+t0Fbdti7jV60z7G5MA0jGhMmV
         IS/iALbQNO28wISjncpgHzl+dp+v29qS7II7ilHML6v/dCg0so2lgAiJJkUQT3p905hw
         OBxJsc87i9VONCalF3pYzAlJ7tmNR8nZ3h447qh83lT5ntsLLrx55QwwzCAgX9b/F5uM
         QcFmf5Wl+CRz/M5N6bG5wXm2M+gJzR9kY3cLiCsUDayN3gi6Y4JQTz66PDZgPsUbpjKq
         0HZYLOQMTip1gkSQzI/qgjp7pViZNJ2k+ExL5pTtvZoM6kHBjO3/3wMvTz5xYvNWIN2M
         XSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zobQoMJQOgDPYr+MKSzRl6L5Jyg4cU9WZMtWqTxs5eU=;
        b=GarUPdw4O8++tSLZfw3bEdwMS7Y+xJ9ydDwYmLYfsTHA/Q7N7bN6id9DwQX1zklG4c
         Uh+Re7+aNU3yz9F9VSa8WaMeDwgADryYBVfm4PQZmiP6pEcXK4MvTpTpyxYT8nhU6tMj
         SiVWe/SYgFfgK4Fxg3b+h4u/JWriZdrSFNsyhzkmUDCHVNRmU0pEOlUjVqJuyMBedHII
         8U878W7TO79aWh23Xf69KNxON7sV/MiX99gd801JT2aODScVgUzzsr4J37J33d3WKJMf
         jVtlOxZ/F0edO5Uc4BThSgtLXdIQBV4V/WNrSbjgjtkMlnjBopQs1w+bbXSdb0cglbS0
         QWww==
X-Gm-Message-State: ANoB5pm9CRKcI9nd1LOLdsbuhJFlkHEuLlkPh9xSlKteK+zXJOrGK8xV
	JjteEQr2sE3htR1fYp+lFWM=
X-Google-Smtp-Source: AA0mqf6vbFEl7o2ltRHI4KJ3SsULJ1+ui+hGCwIsaq2gVG0mY2jrS6JOLFxTqQ9mWnLsQH7TbcKGZg==
X-Received: by 2002:a50:fc0b:0:b0:46b:5812:a03a with SMTP id i11-20020a50fc0b000000b0046b5812a03amr6767477edr.91.1669737442779;
        Tue, 29 Nov 2022 07:57:22 -0800 (PST)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090778c700b007417041fb2bsm6306253ejc.116.2022.11.29.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:57:22 -0800 (PST)
Date: Tue, 29 Nov 2022 16:57:18 +0100
From: Pankaj Raghav <pankydev8@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev, linux-nvme@lists.infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 2/9] nvme: use nvme_wait_ready in nvme_shutdown_ctrl
Message-ID: <20221129155718.poqztp4zudt47zmq@quentin>
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129132208.4337-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_155725_315284_F9E485D6 
X-CRM114-Status: GOOD (  21.34  )
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

On Tue, Nov 29, 2022 at 02:22:01PM +0100, Christoph Hellwig wrote:
> Refactor the code to wait for CSTS state changes so that it can be reused
> by nvme_shutdown_ctrl.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 02cc8dfc9f0b59..9f20af2406dcc8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2260,16 +2260,17 @@ static const struct block_device_operations nvme_bdev_ops = {
>  	.pr_ops		= &nvme_pr_ops,
>  };
>  
> -static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 timeout, bool enabled)
> +static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
> +		u32 timeout, const char *op)
>  {
>  	unsigned long timeout_jiffies = ((timeout + 1) * HZ / 2) + jiffies;
The timeout_jiffies calculation in nvme_shutdown_ctrl is:
unsigned long timeout = jiffies + (ctrl->shutdown_timeout * HZ);

Aren't we changing the timeout with this change to something
different compared to what it was before for shutdown?

> -	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
> +	u32 csts;
>  	int ret;
>  
>  	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
>  		if (csts == ~0)
>  			return -ENODEV;
> -		if ((csts & NVME_CSTS_RDY) == bit)
> +		if ((csts & mask) == val)
>  			break;
>  
>  		usleep_range(1000, 2000);
> @@ -2278,7 +2279,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 timeout, bool enabled)
>  		if (time_after(jiffies, timeout_jiffies)) {
>  			dev_err(ctrl->device,
>  				"Device not ready; aborting %s, CSTS=0x%x\n",
> -				enabled ? "initialisation" : "reset", csts);
> +				op, csts);
>  			return -ENODEV;
>  		}
>  	}

