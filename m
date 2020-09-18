Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E8C43466
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 18:46:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F7521534
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 18:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JheeNLtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F7521534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TcHGVCEmrzbkLIhgv+eDrqp1ofWjFvig5Exroaz46L4=; b=JheeNLtfZzgYGN/Jp34aVYZdv
	NYn+4ckxzA+JYn65XQ+NqlX7yr8XTH+6A1n8gVQKZvjkP9o8lBx3/7yjJp3cdxG88FzB0dW8pjO+i
	ZuklX8KtP8l02Vr/DEFgY9G1DR9cobE0SdAwTecxcIzDHrYoaxl7jb4hAqpKhtDAl34Kg+G0eK9Up
	P9YpcEI5JMvlh/ka5oqm2ZvSyBfoDBJDgM4xpLxLHIdYHQLlYiMrqrHe7BdE/zl0E40vc/t+5Feo7
	24xGQ1+87upPwoZVRbkju1UlZHLXNiEoBT29/enFb0Kf2/uKqQDq2Himb6O/h/MjoOM1W/28tJvaa
	3b1M5jSFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJLOy-0006ql-4b; Fri, 18 Sep 2020 18:46:32 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJLOu-0006pc-7n
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 18:46:29 +0000
Received: by mail-pl1-f196.google.com with SMTP id k13so3452329plk.3
 for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2020 11:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZxDJV2fJCIDNTsf7R64Vg/QpDh1T7h9NcEj6xPqhZnM=;
 b=jVwjPgjBLLuttOMo2AZ+YUXH4f/FrTUKsiVx/VVAOLEjdjK347W4HK+P6fWbwmzlgv
 uIf4pcQIHvfUVv+faVKsa0Dsn8aWdwfxI3onSrvZ27nFk2Y1zDl/ERVaD4k8m7PdbgxM
 1KqBc+3JrsxrX1N+MO27+d+MK3h/iarHws01CuBB9y/8C7ZRqgcfybPsKg3hkVHjQOZ5
 qqNAMMTfxNSkUFrcaiF5TEUqEQsGBF7KiIh7qBm4SmcEDN8waT4s+1PFUO+gtx9N2IKB
 zUnqeRY/+MmkAMPuf7fEr7Mb1Xt1dBILsIiM9LKWfo/+LBJAF6oTMFYc4zt+L8qabAd2
 xkAw==
X-Gm-Message-State: AOAM530UUVl3MS2GlY1r76l20JoRArOT3kJ1JjkK7pd4s6p74orp9G5L
 u8DkmBipXp+PueqsZvHJFGlYJZyBV7c=
X-Google-Smtp-Source: ABdhPJxBg2A1FGDoSmleWQDmynLttpWsBXjCNrvlj6E6Zdj78d20Ir7/SLYdsxm5CRO3teA3ZbNS7A==
X-Received: by 2002:a17:90b:1487:: with SMTP id
 js7mr13919908pjb.187.1600454785353; 
 Fri, 18 Sep 2020 11:46:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c1f8:eff6:9706:30c?
 ([2601:647:4802:9070:c1f8:eff6:9706:30c])
 by smtp.gmail.com with ESMTPSA id gg19sm3424923pjb.49.2020.09.18.11.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 11:46:24 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 4.19 127/206] nvme: Fix controller creation races
 with teardown flow
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20200918020802.2065198-1-sashal@kernel.org>
 <20200918020802.2065198-127-sashal@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <47a9f0da-9fcd-ad17-d2bf-f79767745a39@grimberg.me>
Date: Fri, 18 Sep 2020 11:46:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918020802.2065198-127-sashal@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_144628_303976_924883DC 
X-CRM114-Status: GOOD (  25.35  )
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
Cc: Keith Busch <kbusch@kernel.org>, Israel Rukshin <israelr@mellanox.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This causes a regression and was reverted upstream, just FYI.

On 9/17/20 7:06 PM, Sasha Levin wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> [ Upstream commit ce1518139e6976cf19c133b555083354fdb629b8 ]
> 
> Calling nvme_sysfs_delete() when the controller is in the middle of
> creation may cause several bugs. If the controller is in NEW state we
> remove delete_controller file and don't delete the controller. The user
> will not be able to use nvme disconnect command on that controller again,
> although the controller may be active. Other bugs may happen if the
> controller is in the middle of create_ctrl callback and
> nvme_do_delete_ctrl() starts. For example, freeing I/O tagset at
> nvme_do_delete_ctrl() before it was allocated at create_ctrl callback.
> 
> To fix all those races don't allow the user to delete the controller
> before it was fully created.
> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/nvme/host/core.c | 5 +++++
>   drivers/nvme/host/nvme.h | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4b182ac15687e..faa7feebb6095 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2856,6 +2856,10 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
>   {
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>   
> +	/* Can't delete non-created controllers */
> +	if (!ctrl->created)
> +		return -EBUSY;
> +
>   	if (device_remove_file_self(dev, attr))
>   		nvme_delete_ctrl_sync(ctrl);
>   	return count;
> @@ -3576,6 +3580,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   		queue_work(nvme_wq, &ctrl->async_event_work);
>   		nvme_start_queues(ctrl);
>   	}
> +	ctrl->created = true;
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 31c1496f938fb..a70b997060e68 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -206,6 +206,7 @@ struct nvme_ctrl {
>   	struct nvme_command ka_cmd;
>   	struct work_struct fw_act_work;
>   	unsigned long events;
> +	bool created;
>   
>   #ifdef CONFIG_NVME_MULTIPATH
>   	/* asymmetric namespace access: */
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
