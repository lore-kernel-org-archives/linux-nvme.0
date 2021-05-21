Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC0C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:22:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62427613AF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62427613AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ijK9aB+iC/1LYHbEKpCCzk+MgDk3pVcbtsZFZIQNXU=; b=QKg8cGDIN4l28uh3y5TEp7SzMh
	K6Vm11XK9/Xp6EPDW7/7AeA4HTusb3u+psTZUNtnvep65tpCglC0QMmnIpI9pcg4jDHgTKnCz5PVU
	aeIJeXx6l1mFguHsJdB3f1i/16p+8A9ueMbuNi1AoeOb9To3SDlR3Yx5r/WNEagfu9fJHESR6EF02
	augrZ+FTe7OOGlnGsoBz4Q/9nOT6jrThaFDJXiDsJAY0aVDL5sfzDxupwH4jaiOWOTRPKvvyb4nzp
	wOOxTwilpkFeywwxiobtAOaTafLO9nP3JEPVGzEuv6rcaxwRfGPjhLb8PcflChvVHdnfuA+luPQFW
	Bj/J3++g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDX5-001EL5-NX; Fri, 21 May 2021 22:22:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDWz-001EK3-K5
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:22:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=XDt95SaculVsp4vsoMBJK73v+t7PC6clJ8dXMDb8GZE=; b=uIJRxhs4/aHaH/ov13ubRbQCe/
 /hCisLvJt/FPlYvlq1Q5A9DfoTuu4nN1bFGNaiCPeUtfb6nVeeTkO5pmbDYDumwnym5PTeN0F4Dws
 nyn90IMZruzObaeZlctHYzbW7cvVflE9tXeZ648iKehjmkfCEMeq5III588I0kYENFpLZCWiQW3+K
 wSEzqcyTtg5zZ7pQlYM5Zs4eUOhw61li/0/PQi1bJNYwFafY0QRK5QGNUx5B8BI1YBXV2HqWcJTsn
 WAAlBIymjzXdp3QbLJvJN1r8S9Rks+pCP3SlgCgJ2jmiyvV8Vm20JA97kvxZIf+wbMhFeuWmmbmE1
 BQhk9IkQ==;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDWw-00HT7L-QN
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:22:08 +0000
Received: by mail-wm1-f52.google.com with SMTP id o127so11862779wmo.4
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 15:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XDt95SaculVsp4vsoMBJK73v+t7PC6clJ8dXMDb8GZE=;
 b=SfqxSVjNxP2p5LWlsbE95XvbA+BnYr5JR7HUPxBV7tcO/JRZ47bKwHD6sDHv76mftG
 qX3Ko8zZIt3OrAFDa3yhhGpwcLNNg0uc/gHlz1jiYa5BNtIRxLHYTj23/pB574RxNr4m
 11xEiUb5X0K5evLYuIq603u98KGKRNWfsgK7GHRZxL82LYIgfqYwTHHd2u+yKxMS0Jyo
 svaR2Dea/2QiTF+dN4gnGjR+5wL/ZB0ERLYiHsdk45TOutVNl4U1g/0lCN+gO/736uy5
 Kn9sAUU+egU60V0sTO7j3FBRtsbzkEw/QhKNjBvBbLv94ki6aprijzsZQnoEAa8UXBoP
 3BLQ==
X-Gm-Message-State: AOAM530npXyp6S46L2z3KE1MyiaW8cVHeuv8FfHt38bmB+gx83up85Yc
 SGKmj/8xdw/KTWz6iDoPu1Q=
X-Google-Smtp-Source: ABdhPJwKPPI94ijzomJLiw/z0WvZWW4cX9Vs4h6CzSTXuSIpUb7Rpgj42vphbyv4ZCDxgKEYHXWfOw==
X-Received: by 2002:a1c:3184:: with SMTP id x126mr10845737wmx.52.1621635724975; 
 Fri, 21 May 2021 15:22:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id i1sm3430737wrp.51.2021.05.21.15.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 15:22:04 -0700 (PDT)
Subject: Re: [RFC PATCH v5 03/27] nvme-tcp-offload: Add device scan
 implementation
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-4-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e986c505-b81a-36ab-6366-35d5fbc193e1@grimberg.me>
Date: Fri, 21 May 2021 15:22:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519111340.20613-4-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_152206_892771_1BB9755A 
X-CRM114-Status: GOOD (  28.69  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/19/21 4:13 AM, Shai Malin wrote:
> From: Dean Balandin <dbalandin@marvell.com>
> 
> As part of create_ctrl(), it scans the registered devices and calls
> the claim_dev op on each of them, to find the first devices that matches
> the connection params. Once the correct devices is found (claim_dev
> returns true), we raise the refcnt of that device and return that device
> as the device to be used for ctrl currently being created.
> 
> Acked-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> ---
>   drivers/nvme/host/tcp-offload.c | 94 +++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
> index 711232eba339..aa7cc239abf2 100644
> --- a/drivers/nvme/host/tcp-offload.c
> +++ b/drivers/nvme/host/tcp-offload.c
> @@ -13,6 +13,11 @@
>   static LIST_HEAD(nvme_tcp_ofld_devices);
>   static DECLARE_RWSEM(nvme_tcp_ofld_devices_rwsem);
>   
> +static inline struct nvme_tcp_ofld_ctrl *to_tcp_ofld_ctrl(struct nvme_ctrl *nctrl)
> +{
> +	return container_of(nctrl, struct nvme_tcp_ofld_ctrl, nctrl);
> +}
> +
>   /**
>    * nvme_tcp_ofld_register_dev() - NVMeTCP Offload Library registration
>    * function.
> @@ -98,6 +103,94 @@ void nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
>   	/* Placeholder - complete request with/without error */
>   }
>   
> +struct nvme_tcp_ofld_dev *
> +nvme_tcp_ofld_lookup_dev(struct nvme_tcp_ofld_ctrl *ctrl)
> +{
> +	struct nvme_tcp_ofld_dev *dev;
> +
> +	down_read(&nvme_tcp_ofld_devices_rwsem);
> +	list_for_each_entry(dev, &nvme_tcp_ofld_devices, entry) {
> +		if (dev->ops->claim_dev(dev, &ctrl->conn_params)) {
> +			/* Increase driver refcnt */
> +			if (!try_module_get(dev->ops->module)) {

This means that every controller will take a long-lived reference on the
module? Why?

> +				pr_err("try_module_get failed\n");
> +				dev = NULL;
> +			}
> +
> +			goto out;
> +		}
> +	}
> +
> +	dev = NULL;
> +out:
> +	up_read(&nvme_tcp_ofld_devices_rwsem);
> +
> +	return dev;
> +}
> +
> +static int nvme_tcp_ofld_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
> +{
> +	/* Placeholder - validates inputs and creates admin and IO queues */
> +
> +	return 0;
> +}
> +
> +static struct nvme_ctrl *
> +nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
> +{
> +	struct nvme_tcp_ofld_ctrl *ctrl;
> +	struct nvme_tcp_ofld_dev *dev;
> +	struct nvme_ctrl *nctrl;
> +	int rc = 0;
> +
> +	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return ERR_PTR(-ENOMEM);
> +
> +	nctrl = &ctrl->nctrl;
> +
> +	/* Init nvme_tcp_ofld_ctrl and nvme_ctrl params based on received opts */
> +
> +	/* Find device that can reach the dest addr */
> +	dev = nvme_tcp_ofld_lookup_dev(ctrl);
> +	if (!dev) {
> +		pr_info("no device found for addr %s:%s.\n",
> +			opts->traddr, opts->trsvcid);
> +		rc = -EINVAL;
> +		goto out_free_ctrl;
> +	}
> +
> +	ctrl->dev = dev;
> +
> +	if (ctrl->dev->ops->max_hw_sectors)
> +		nctrl->max_hw_sectors = ctrl->dev->ops->max_hw_sectors;
> +	if (ctrl->dev->ops->max_segments)
> +		nctrl->max_segments = ctrl->dev->ops->max_segments;
> +
> +	/* Init queues */
> +
> +	/* Call nvme_init_ctrl */
> +
> +	rc = ctrl->dev->ops->setup_ctrl(ctrl, true);
> +	if (rc)
> +		goto out_module_put;

goto module_put without an explicit module_get is confusing.

> +
> +	rc = nvme_tcp_ofld_setup_ctrl(nctrl, true);
> +	if (rc)
> +		goto out_uninit_ctrl;

ops->setup_ctrl and then call to nvme_tcp_ofld_setup_ctrl?
Looks weird, why are these separated?

> +
> +	return nctrl;
> +
> +out_uninit_ctrl:
> +	ctrl->dev->ops->release_ctrl(ctrl);
> +out_module_put:
> +	module_put(dev->ops->module);
> +out_free_ctrl:
> +	kfree(ctrl);
> +
> +	return ERR_PTR(rc);
> +}
> +
>   static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
>   	.name		= "tcp_offload",
>   	.module		= THIS_MODULE,
> @@ -107,6 +200,7 @@ static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
>   			  NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_HDR_DIGEST |
>   			  NVMF_OPT_DATA_DIGEST | NVMF_OPT_NR_POLL_QUEUES |
>   			  NVMF_OPT_TOS,
> +	.create_ctrl	= nvme_tcp_ofld_create_ctrl,
>   };
>   
>   static int __init nvme_tcp_ofld_init_module(void)
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
