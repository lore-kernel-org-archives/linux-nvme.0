Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358D2C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 06:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ZwPPUJ3apX9Tefc2Uy6Bj025NK7UZRizsQYevzvQe8=; b=GOhngUAA6tHlhSFUDVp7pXwHr0
	AweVI5WL06tPmE2Ff6CtewnJr50O0qEl+q/wEtGrjquN5ZByWBQUXAF5FLHp6S6bqYn1kuW3hGUzi
	B95TG7CScQ7sjkOH1wN0nZpSlgW+MxUt+UKpbctZhnzjwQm5e2e5i3t9yPqHK4z4QmGaWP9ceSr36
	zJ8zJbfrdFWPxesprBhOHdgczvy00+1Pqzimmoy/eRAi8rubR6HO9F5LSnonEtUjYn7IF7kflRXo4
	4fteFCpBdR1IAc2tRx2EkDHzskbQRt2/m//kTjVze3oHjzUrGo1UVUbkik9lGFg1iGMFJb22gkKPi
	/aV0VFuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6QPb-000PU9-0Z;
	Tue, 06 Jun 2023 06:43:23 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6QPY-000PTB-2l
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 06:43:22 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f6148e501dso10134555e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 23:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686033799; x=1688625799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZwPPUJ3apX9Tefc2Uy6Bj025NK7UZRizsQYevzvQe8=;
        b=FSW94g9yQTkLOdVCnbo1OvLePWboYBMndPt4f6dDIqBKQoE/IU0BaJNTZPFS9azWf5
         /N/dzdRBvrRyxD0pPH9zNgLbXya+3iB4ATgrbkSBg7i6vvKBKLZAAD4JjmWlu8tu9NWm
         6yzdWiCJurgImc7GMmDXmYc/l5lg3CkDQwj1lVxerATIjyEAx5CjCYd7G+kaugzhZA9U
         jHnVYMJK1WPXOLcLH/cMIhKly4hIu4lEy0UbJydrDZAyh87YsX17Ov63Cqchk6Ord6OU
         KmrhgeQXyMv6QFGGYRRxHhLktbeja9wayWKXO7/2YbNxQgXUek03lv5sntjKo9Fcx/n9
         waJw==
X-Gm-Message-State: AC+VfDxHdPIBj1wvy5OvXfLpQeLQsVWV8GHtKkblRhorbxSu4uOcBy77
	4L+M23vd8k4CEof01FH2Q0kqEq2ht8E=
X-Google-Smtp-Source: ACHHUZ6SHW9gdaNo8nehD6k7ImLVMq4sBTyX6kVYQRjnTOM0nJ13MwmjCnl5Eve9jzGJ/aBmsOPeDg==
X-Received: by 2002:a05:600c:3b19:b0:3f7:3105:5755 with SMTP id m25-20020a05600c3b1900b003f731055755mr1330021wms.0.1686033799079;
        Mon, 05 Jun 2023 23:43:19 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm11643158wrm.17.2023.06.05.23.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:43:18 -0700 (PDT)
Message-ID: <2ce728ac-54b7-f59d-a0c0-b585767a9428@grimberg.me>
Date: Tue, 6 Jun 2023 09:43:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/2] nvme: add generic helper to store secret
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hare@suse.de" <hare@suse.de>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20230605065125.47563-1-kch@nvidia.com>
 <20230605065125.47563-2-kch@nvidia.com>
 <ef1a8621-ae27-1b06-fbc2-b3cb1e137b1e@grimberg.me>
 <478ca846-cf68-c8db-d4e5-f862775d16c2@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <478ca846-cf68-c8db-d4e5-f862775d16c2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_234320_895307_BA55B5E2 
X-CRM114-Status: GOOD (  20.16  )
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


>       kfree(dhchap_secret);
>>> -    /* Start re-authentication */
>>> -    dev_info(ctrl->device, "re-authenticating controller\n");
>>> -    queue_work(nvme_wq, &ctrl->dhchap_auth_work);
>>> -
>>> -    return count;
>>> +    return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
>>
>> Both call with ctrl_secret=false?
>>
> 
> this is wrong ..
> 
> This is my mistake let me fix this and send V4.
> 
>> I think it conveys the point that this is confusing...
> 
> The reason I did this because original code had kfree() bug and that bug
> was replicated in both the functions, with fixing the mistake, I believe
> we can avoid such replication of code and potential bugs.

I understand, but at a point where the commonality becomes confusing
it can get counter productive.

BTW while we're at it, I think that the extra check that the new
secret matches the old secret is redundant, we already allocated
the new secret, we can simply swap them (or compare before we allocate
anything). Perhaps we are better off to fixing the reason we had a leak
in the first place (convoluted ordering).

Lets do something like:
--
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 796e1d373b7c..51d980cdbb80 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -423,7 +423,9 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct 
device *dev,
  {
         struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
         struct nvmf_ctrl_options *opts = ctrl->opts;
+       struct nvme_dhchap_key *key, *host_key;
         char *dhchap_secret;
+       int ret;

         if (!ctrl->opts->dhchap_secret)
                 return -EINVAL;
@@ -431,35 +433,35 @@ static ssize_t 
nvme_ctrl_dhchap_secret_store(struct device *dev,
                 return -EINVAL;
         if (memcmp(buf, "DHHC-1:", 7))
                 return -EINVAL;
+       if (!memcmp(buf, opts->dhchap_secret, count))
+               return 0;

-       dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+       dhchap_secret = kstrdup(buf, GFP_KERNEL);
         if (!dhchap_secret)
                 return -ENOMEM;
-       memcpy(dhchap_secret, buf, count);
+
+       ret = nvme_auth_generate_key(dhchap_secret, &key);
+       if (ret)
+               goto err_key;
+
         nvme_auth_stop(ctrl);
-       if (strcmp(dhchap_secret, opts->dhchap_secret)) {
-               struct nvme_dhchap_key *key, *host_key;
-               int ret;

-               ret = nvme_auth_generate_key(dhchap_secret, &key);
-               if (ret) {
-                       kfree(dhchap_secret);
-                       return ret;
-               }
-               kfree(opts->dhchap_secret);
-               opts->dhchap_secret = dhchap_secret;
-               host_key = ctrl->host_key;
-               mutex_lock(&ctrl->dhchap_auth_mutex);
-               ctrl->host_key = key;
-               mutex_unlock(&ctrl->dhchap_auth_mutex);
-               nvme_auth_free_key(host_key);
-       } else
-               kfree(dhchap_secret);
+       kfree(opts->dhchap_secret);
+       opts->dhchap_secret = dhchap_secret;
+       host_key = ctrl->host_key;
+       mutex_lock(&ctrl->dhchap_auth_mutex);
+       ctrl->host_key = key;
+       mutex_unlock(&ctrl->dhchap_auth_mutex);
+       nvme_auth_free_key(host_key);
+
         /* Start re-authentication */
         dev_info(ctrl->device, "re-authenticating controller\n");
         queue_work(nvme_wq, &ctrl->dhchap_auth_work);

         return count;
+err_key:
+       kfree(dhchap_secret);
+       return ret;
  }

  static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
--

