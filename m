Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E65C7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C4sY82IDbGXc0BqAkQVNqTH0SgWAx8QAM4C//A0lhNU=; b=ZEwwXXPWp0m3mj2MabzBcJMWnb
	3FRm8v/omfssqsJWs6ExU3JktqPusvdvi5vMLDLj59DJqqbfH3PzNK6O8mEMWnYXW8Hnaiwg8PtyI
	bSBDZvPqo/xSj48uF4d9PvcMqTPjtLbJPb04ZeDurMAwr5vHh+Ghv4nGMQB7Jsnx3lcFnbvmVeO6F
	ph4bLgkiqGgmepee8vKz5dtlXFhoFiGcP0M6NxKJTccMadyCxO2RpNBHoUt+3AiZJRACSaV5OVKlt
	6kACAa06jACrJmG5R623jRDs45uKG9r8WUljQB6MQzcOu6NBReZXjctOoAhEBasS1h1D/nlO/c1LU
	OGxmNUKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBdD-008fxy-2a;
	Wed, 17 May 2023 07:31:31 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBdB-008fwy-0l
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:31:30 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-30913073ec6so82057f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308685; x=1686900685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4sY82IDbGXc0BqAkQVNqTH0SgWAx8QAM4C//A0lhNU=;
        b=ESu0HevLK3NkAjFMMlzutB7z0RPU8EfpOd737KfvjvvqtozpGtmytPUJKjXqmFSfVL
         xUWmdbu0j8sq18JREicPhrjZsMzqolZqd0GUnGVTKZ5dreZoJRroNMrOLsbbbpSd4u3e
         PJjyjrrHYzg48GtNQbxe97A1tBCYUueBEeJj2fdZBk/Aahyrzcn5FXdC0VjLxcbBCurQ
         rZicoOGnthZlDDM1Tc1YXyFpNmWNKVR31aXGRkQRe1dNSWtWeSh87wmZ2/HIB/q/XtAf
         NGA/JI0v39JXJ7hUONHk40PkxnkqawheD6lzvCpgzUwZcLgxTJItAXNosV1j1QpjnG78
         +2ig==
X-Gm-Message-State: AC+VfDxyYEiN97nhSMbPHrtCKnOU2u0iZEPuYz00IT0vh7k4vTFMQwTq
	9va8DgOREqFlUPELu6RtWgg=
X-Google-Smtp-Source: ACHHUZ48Wk6RYHoKb0M1iUzMSI/5QKpH2d5teOsk9e632uUfiZBYxnJRelUV7njlhqLdwjCNj0/pyw==
X-Received: by 2002:a05:600c:1c82:b0:3f1:7518:e37f with SMTP id k2-20020a05600c1c8200b003f17518e37fmr1567279wms.1.1684308684572;
        Wed, 17 May 2023 00:31:24 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p7-20020a7bcc87000000b003f3e50eb606sm1264175wma.13.2023.05.17.00.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:31:24 -0700 (PDT)
Message-ID: <05c40aed-755a-bbdf-4e22-c529ea4d6e17@grimberg.me>
Date: Wed, 17 May 2023 10:31:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] nvme: add generic helper to store secret
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20230516100605.53712-1-kch@nvidia.com>
 <20230516100605.53712-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230516100605.53712-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_003129_294772_95C23B22 
X-CRM114-Status: GOOD (  23.62  )
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



On 5/16/23 13:06, Chaitanya Kulkarni wrote:
> Refactor code to avoid duplication and improve maintainability:
> 
> Consolidate the shared code between the functions
> nvme_ctrl_dhchap_secret_store() and
> nvme_ctrl_dhchap_ctrl_secret_store(). This duplication not only
> increases the likelihood of bugs but also requires additional effort for
> maintenance and testing.
> 
> Introduce a new generic helper function called
> nvme_dhchap_secret_store_common() to handle the storage of the
> dhchap secret. This helper function will be used by both
> nvme_ctrl_dhchap_secret_store() and
> nvme_ctrl_dhchap_ctrl_secret_store().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/sysfs.c | 59 ++++++++++++++++++++++++++-------------
>   1 file changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 796e1d373b7c..9ce3b16f06da 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -418,43 +418,53 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
>   }
>   
> -static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> +static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
> +		const char *buf, size_t count, bool ctrl_secret)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> -	char *dhchap_secret;
> +	struct nvme_dhchap_key **orig_key;
> +	char **dhchap_secret;
> +	char *new_dhchap_secret;
> +
> +	if (ctrl_secret) {
> +		if (!ctrl->opts->dhchap_ctrl_secret)
> +			return -EINVAL;
> +		dhchap_secret = &ctrl->opts->dhchap_ctrl_secret;
> +		orig_key = &ctrl->ctrl_key;
> +	} else {
> +		if (!ctrl->opts->dhchap_secret)
> +			return -EINVAL;
> +		dhchap_secret = &ctrl->opts->dhchap_secret;
> +		orig_key = &ctrl->host_key;
> +	}
>   
> -	if (!ctrl->opts->dhchap_secret)
> -		return -EINVAL;
>   	if (count < 7)
>   		return -EINVAL;
>   	if (memcmp(buf, "DHHC-1:", 7))
>   		return -EINVAL;
>   
> -	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
> -	if (!dhchap_secret)
> +	new_dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
> +	if (!new_dhchap_secret)
>   		return -ENOMEM;
> -	memcpy(dhchap_secret, buf, count);
> +	memcpy(new_dhchap_secret, buf, count);
>   	nvme_auth_stop(ctrl);
> -	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
> -		struct nvme_dhchap_key *key, *host_key;
> +	if (strcmp(new_dhchap_secret, *dhchap_secret)) {
> +		struct nvme_dhchap_key *new_key, *prev_host_key;

prev_host_key? or prev_key?

>   		int ret;
>   
> -		ret = nvme_auth_generate_key(dhchap_secret, &key);
> +		ret = nvme_auth_generate_key(new_dhchap_secret, &new_key);
>   		if (ret) {
> -			kfree(dhchap_secret);
> +			kfree(new_dhchap_secret);
>   			return ret;
>   		}
> -		kfree(opts->dhchap_secret);
> -		opts->dhchap_secret = dhchap_secret;
> -		host_key = ctrl->host_key;
> +		kfree(*dhchap_secret);
> +		*dhchap_secret = new_dhchap_secret;
> +		prev_host_key = *orig_key;
>   		mutex_lock(&ctrl->dhchap_auth_mutex);
> -		ctrl->host_key = key;
> +		*orig_key = new_key;
>   		mutex_unlock(&ctrl->dhchap_auth_mutex);
> -		nvme_auth_free_key(host_key);
> +		nvme_auth_free_key(prev_host_key);
>   	} else
> -		kfree(dhchap_secret);
> +		kfree(new_dhchap_secret);
>   	/* Start re-authentication */
>   	dev_info(ctrl->device, "re-authenticating controller\n");
>   	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
> @@ -462,6 +472,15 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>   	return count;
>   }
>   
> +
> +static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
> +}
> +
>   static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
>   	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
>   

