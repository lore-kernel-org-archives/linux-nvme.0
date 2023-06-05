Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCE5C7EE23
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xl8OEVFVK5WF+JZOnhdfnIe8f9yRddQVX0U2GyrHV1U=; b=dyG/vl6rqXuYVBvR1+XNAKaye7
	DwGvLi5mesXXp0VTTqx2jneyiEgCDT70na6AWqCt3P87WCzJ3r8f9ylX7URpZiUXWm+Jm9RwoEki3
	nZl9SAUADDviV+0Hq1iItPaO5JXPLltwzSro/GDzvhR3SEwgIMoL+pBx4Twm/xcPNzavcy1NXvPO3
	B05W2vuus6pJxV20j9xnbMlBcYYYbKfj+/PyRY1uab5Q26uGDKbzPxA4q3khI9yPeOCcQrfTHKGT9
	k1mI1OfsqSAKyCFHSUSHfyUOyS9EhaijckoYYu/qtxSLTAL/vU2GM/+0Cvslmr2364nj60uinFXLo
	gXFSe+cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Iic-00H0va-1t;
	Mon, 05 Jun 2023 22:30:30 +0000
Received: from mail-lf1-f50.google.com ([209.85.167.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6IiZ-00H0uM-25
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 22:30:29 +0000
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f61307827cso649153e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 15:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004224; x=1688596224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl8OEVFVK5WF+JZOnhdfnIe8f9yRddQVX0U2GyrHV1U=;
        b=VUfiGnaJqeP+qCh7f9z8YU++Fj9DDuCEzPoHQ+NaLPLryDmxWLsaMNwbrOqbvsdXHk
         e6rmgYATiM1Ep2Owoum66nJBS1/3CrJbzAQbTr2v7qtwlXvzTN5RN64WgnjzFumLg6vC
         uL7ffg4C+OXy1I7iRlUeocZxyt8AWSWDX7BdebzCLtgNByihvKzzMGqXo7BnB5WfWQ3v
         GWibhfDiVtsVNjrg8VuI7rtmARPYdhLprZ8hchLiNJ40htrfsYk2TRT+l7yKLyEvkaLy
         ZjJHm7CLkwSX87e38xY4Iq2GVXl6DRNIrR9WI+ahO7ruOCRzjx9z2ekb+YQp0rBgxUdK
         6TBA==
X-Gm-Message-State: AC+VfDw0EKAZX/2Oz85+528OkJG6hnrQOrTIf84Wts/5Jhj+O/TRwqID
	fLk8EaTEdftTuQza80n5mkf2GaGdljw=
X-Google-Smtp-Source: ACHHUZ4vyCgCr8t05CWu2COO0/1dJFfELFtgsZv/4CZL3f1Gg6WO1SlZtE3lTNXqiTBJyp378rJZQQ==
X-Received: by 2002:a05:6512:7b:b0:4f6:1c33:b9e3 with SMTP id i27-20020a056512007b00b004f61c33b9e3mr136538lfo.1.1686004223834;
        Mon, 05 Jun 2023 15:30:23 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24345000000b004f004c0498esm1249539lfl.71.2023.06.05.15.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:30:23 -0700 (PDT)
Message-ID: <ef1a8621-ae27-1b06-fbc2-b3cb1e137b1e@grimberg.me>
Date: Tue, 6 Jun 2023 01:30:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/2] nvme: add generic helper to store secret
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20230605065125.47563-1-kch@nvidia.com>
 <20230605065125.47563-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230605065125.47563-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_153027_688199_0EE95AFF 
X-CRM114-Status: GOOD (  23.65  )
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



On 6/5/23 09:51, Chaitanya Kulkarni wrote:
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
> dhchap secret. Update nvme_ctrl_dhchap_secret_store() and
> nvme_ctrl_dhchap_ctrl_secret_store() to use newly introduced helper.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/sysfs.c | 96 ++++++++++++++++-----------------------
>   1 file changed, 39 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 796e1d373b7c..98becb7a7453 100644
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
> +		struct nvme_dhchap_key *new_key, *prev_key;
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
> +		prev_key = *orig_key;
>   		mutex_lock(&ctrl->dhchap_auth_mutex);
> -		ctrl->host_key = key;
> +		*orig_key = new_key;
>   		mutex_unlock(&ctrl->dhchap_auth_mutex);
> -		nvme_auth_free_key(host_key);
> +		nvme_auth_free_key(prev_key);
>   	} else
> -		kfree(dhchap_secret);
> +		kfree(new_dhchap_secret);
>   	/* Start re-authentication */
>   	dev_info(ctrl->device, "re-authenticating controller\n");
>   	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
> @@ -462,6 +472,14 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>   	return count;
>   }
>   
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
> @@ -480,44 +498,8 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> -	char *dhchap_secret;
>   
> -	if (!ctrl->opts->dhchap_ctrl_secret)
> -		return -EINVAL;
> -	if (count < 7)
> -		return -EINVAL;
> -	if (memcmp(buf, "DHHC-1:", 7))
> -		return -EINVAL;
> -
> -	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
> -	if (!dhchap_secret)
> -		return -ENOMEM;
> -	memcpy(dhchap_secret, buf, count);
> -	nvme_auth_stop(ctrl);
> -	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
> -		struct nvme_dhchap_key *key, *ctrl_key;
> -		int ret;
> -
> -		ret = nvme_auth_generate_key(dhchap_secret, &key);
> -		if (ret) {
> -			kfree(dhchap_secret);
> -			return ret;
> -		}
> -		kfree(opts->dhchap_ctrl_secret);
> -		opts->dhchap_ctrl_secret = dhchap_secret;
> -		ctrl_key = ctrl->ctrl_key;
> -		mutex_lock(&ctrl->dhchap_auth_mutex);
> -		ctrl->ctrl_key = key;
> -		mutex_unlock(&ctrl->dhchap_auth_mutex);
> -		nvme_auth_free_key(ctrl_key);
> -	} else
> -		kfree(dhchap_secret);
> -	/* Start re-authentication */
> -	dev_info(ctrl->device, "re-authenticating controller\n");
> -	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
> -
> -	return count;
> +	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);

Both call with ctrl_secret=false?

I think it conveys the point that this is confusing...

