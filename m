Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C581C25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 06:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xu5tfRpUITd2ECuxK10ylFwqpBplwyIlxFNOlyfKtm8=; b=lJZC4yKi4MoJSzuRkxj/UtYy+b
	T/72Dwuh00pxbce2o2U3mkc2MGTa5qWcMPdWx1ycTdUrd6A+NjwBqaSiJYeog9J25dP6i7vBS7uBH
	6keh8KKU3lT5B39AxOQoNz0sNFW+KSqBTWHjJutz/tEN4DDrMpLMnQslXQLwI9KrwKG6Ox5OdlU3c
	6ZblSzd1KIh8Et8zP5SU05/hyhlnKD4H0VqPwAYV1dIrFTfJVlcYBZHeeLkQ9ThRVC35K1Cc+BQjj
	5BRieRLJtACprVJ/68yK6XPnIa5lV/s2G5SRlxO0nvy04PO1rzwRmPc78tt55hSmmn5ZkdqfSZ2NT
	Csb5UB3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCZl3-00000006SmT-1xVg;
	Thu, 30 May 2024 06:59:29 +0000
Received: from mail-lf1-f44.google.com ([209.85.167.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCZl0-00000006Sm6-3L6x
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 06:59:28 +0000
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-525c00843f6so39059e87.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 May 2024 23:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717052364; x=1717657164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xu5tfRpUITd2ECuxK10ylFwqpBplwyIlxFNOlyfKtm8=;
        b=Z9OJef06QkQZJTuVJ9bqEbWz97qGmA4/qm9mR4eI0nP0eO1zp4CFVllXVREtuVtMGI
         R9XDXj2rLGlwHIMNkg1kNtNSgUrbmggOzBw2NPCjBkdbV3hh5vn23EQ9vfwPQ1lLuLlh
         lKvPbrRzEpexyth6tRMgAaC6bsSxC+hPALAPLm8QUGTCO+PIBPX3CuRFAQ9+I6O/0sLU
         HbHqLfoN9ZmBqdhI8WRiOehZmnU7RBUosOMdnHaQNFPJD8uomGllNPS6EzGFs9cGx6iJ
         Dm1LwEcMpOuR16RsoXeeXn1XXy/u7NKRTtf99pzQOpPdNaiNPKpNTpYqwfG+cYMpQCyd
         E2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXCCoRdN2WEUvMnyZAGHZ7WNdjCsSUxXd9JfKWyqdAlPRu6Sk40GNUy51DMlGGAPgUDFMyXsT5wOXs7+vPVtCbFnj/SI659hiJPyVTZzgQ=
X-Gm-Message-State: AOJu0YzArK1VRXWfqz8B8cOeSGYe1pajX+ZIu9oNzpv/nyYf+9mJiYrH
	GU6bF8IuPWT4GuGhIjGktHdip4CaIqqFMqAkc6XnH6I+Xdfk8zGq
X-Google-Smtp-Source: AGHT+IHiXjWo0tZx8h2GKhqk9ptGA1iYfA9AzbCwMP1bYjcDzxxkSyXUAmr2oq9Yk6Ez1cCQ4Qf+lw==
X-Received: by 2002:a05:6512:3b7:b0:51e:e6f4:2ef1 with SMTP id 2adb3069b0e04-52b7d4ab269mr896650e87.4.1717052363915;
        Wed, 29 May 2024 23:59:23 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270691b1sm15043515e9.21.2024.05.29.23.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 23:59:23 -0700 (PDT)
Message-ID: <93883147-490d-4065-a741-3e49288ea3af@grimberg.me>
Date: Thu, 30 May 2024 09:59:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests nvme 041,042 leak memory
To: Keith Busch <kbusch@kernel.org>
Cc: Maurizio Lombardi <mlombard@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
 <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_235926_955803_A8BE275B 
X-CRM114-Status: GOOD (  20.45  )
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



On 29/05/2024 19:25, Keith Busch wrote:
> On Wed, May 29, 2024 at 03:51:09PM +0300, Sagi Grimberg wrote:
>> But this is ugly...
> I agree. Could we not work around the device model instead? Once we call
> device_add successfully, we really need to pair that with a device_del.
>
> I see two ways we might be able to do this.
>
> First suggestion: move the device_add to the end so we don't have to
> worry about cleaning up if subsequence actions fail. And auth_init_ctrl
> doesn't appear to have any dependency on the ctrl->device anyway.
>
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5d150c62955d..d86db6a193fcb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4675,12 +4675,16 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	if (ret)
>   		goto out_release_instance;
>   
> +	ret = nvme_auth_init_ctrl(ctrl);
> +	if (ret)
> +		goto out_free_name;
> +
>   	nvme_get_ctrl(ctrl);
>   	cdev_init(&ctrl->cdev, &nvme_dev_fops);
>   	ctrl->cdev.owner = ops->module;
>   	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
>   	if (ret)
> -		goto out_free_name;
> +		goto auth_free;
>   
>   	/*
>   	 * Initialize latency tolerance controls.  The sysfs files won't
> @@ -4692,15 +4696,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   
>   	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
>   	nvme_mpath_init_ctrl(ctrl);
> -	ret = nvme_auth_init_ctrl(ctrl);
> -	if (ret)
> -		goto out_free_cdev;
>   
>   	return 0;
> -out_free_cdev:
> -	nvme_fault_inject_fini(&ctrl->fault_inject);
> -	dev_pm_qos_hide_latency_tolerance(ctrl->device);
> -	cdev_device_del(&ctrl->cdev, ctrl->device);
> +auth_free:
> +	nvme_auth_free(ctrl);
>   out_free_name:
>   	nvme_put_ctrl(ctrl);
>   	kfree_const(ctrl->device->kobj.name);
> --

Lets just do that... and add a comment that we don't want to add
function calls that can fail post cdev_device_add() because we have a
cleanup problem (with a short explanation), so this is less likely to 
come back...

