Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBCFC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LPJMDZJSQlS4738Pw3q4HMDv5tJ43wY99XsE6dNTxUI=; b=rBB+U8QkAydRNVq6xwBIAvRdVY
	pzfpEKWgkIJ6saBMyCdjE+pPUed9lD3LQn1j6Xh0efJ3OhHN/bqLvReldLWMoglXHpmD7YMqRtK6m
	J4vefHY5FMmkty+NDg9omnmf0/q9Dkrq+/ivX2ELZs/kbwPLE6s/Jy7OV+0+UeedGHnfBPkrEfKbR
	F4Rbw/4FsDCQp3heCZXmMQdeWU9e0Hpk0sx3v0HoAY0NR4nFcjhwCRiNjYZnefRf3UVbSwA87swHt
	0gmQukp9aiQqqmdD1NJaotJAWyZVXUFdat4di+cJfjuzSmWXKZEz0c3ADMuq7dXS283Vm7cmgX3Ui
	BiYyo9Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBdq-008g4r-1U;
	Wed, 17 May 2023 07:32:10 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBdn-008g3R-2x
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:32:09 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3063b921c7eso17629f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 00:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308725; x=1686900725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPJMDZJSQlS4738Pw3q4HMDv5tJ43wY99XsE6dNTxUI=;
        b=WbwuFrrxq8nJ6MfX1kJrswtwcUDIFnOnnP5nRNNK2KlR7Dyqb2S0HyFJ5KKF0yjhRH
         arkao7JX2tFUQKPOutMcPAtGfaR/s1USpEQa7gCcX5WballIzPRWTUCyKPw+ZCtENcmQ
         JdvYVkoY1vn4hBteCRITZGK24nCFV4mw7HZFbsOUApCVx4j3LNa3Mdpnl/lSQ5IPimAZ
         4GC9uz5qbeOy1+OfhWiTR73XzkVuG7PKXbKnrfculn/6E6lwOLe/nR2sVXTrsoZDbdkl
         muPvCYfcbzB8LfsV05q6vT3dJtgMUY29jjveKc8dnPeZx7Lyxuoiv5F2XFW5K5d8vJfI
         IrJg==
X-Gm-Message-State: AC+VfDzkECikLVtGpYTZb/h8if1teMejZ3RccUir25srn3ayM2FtEc/r
	0an8yQy3cq9rEDX7flJf8eg=
X-Google-Smtp-Source: ACHHUZ68JSIzWhvQqEnHvll9PBGi03tF90uJHtmelBJjz7CcP9hoE6I8pSP3v3jwlrsY8Akm/Iwwzw==
X-Received: by 2002:adf:e984:0:b0:2d2:9c19:f75 with SMTP id h4-20020adfe984000000b002d29c190f75mr1261939wrm.1.1684308724677;
        Wed, 17 May 2023 00:32:04 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b003047dc162f7sm1663569wrw.67.2023.05.17.00.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:32:04 -0700 (PDT)
Message-ID: <66fe1217-6bf8-0d82-ba77-8320cd52dcfe@grimberg.me>
Date: Wed, 17 May 2023 10:32:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] nvme: use generic helper to store ctrl secret
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20230516100605.53712-1-kch@nvidia.com>
 <20230516100605.53712-3-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230516100605.53712-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_003207_959520_B0F1927E 
X-CRM114-Status: GOOD (  15.28  )
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

Can be squashed to the former.

On 5/16/23 13:06, Chaitanya Kulkarni wrote:
> Use generic helper to store the dhchap ctrl secret.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/sysfs.c | 40 +--------------------------------------
>   1 file changed, 1 insertion(+), 39 deletions(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 9ce3b16f06da..515baf8d6402 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -498,45 +498,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
>   static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> -	char *dhchap_secret;
> -
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
>   }
>   
>   static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,

