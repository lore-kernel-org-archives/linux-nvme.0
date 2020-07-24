Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A92C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 22:01:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57D5206F0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 22:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EGliWlP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57D5206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3zIoJ4nf6YZaCvvjM7Iz3qxeeJ9UeM/N4H3H3EsqOBE=; b=EGliWlP/38hcLBGBUMZsWplsR
	JolCcSdxedRmzzuyUNNUJqSIB5fwzNKOZ0iM2+WOfjIumEH8eXRSMdhf/BP/Cycea8zJ0c7wmBhX8
	MuvVr/R0t1mSrAPuUsgVk/4MXnSGrF5GwH6WGHY7UhuvIrnSr+W4xoCbmZuW7Xvp5kDIOUetLMr+z
	NLeXEuOrLz0VbhreMLWBJy4aEGt2khPjC9ip5pdBpDBok1v0X65vhlKTZ4QqFsLovH5wzxxXl/F6F
	r0pPW/5DZCPVwgp8UW3OucN1hBkvypGnt8F9r9EX2Ew4WDrHmT37YkYOdNhbO/wgF89Tm720Q5XIZ
	c40//mYOw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz5lG-0005Dc-EM; Fri, 24 Jul 2020 22:01:50 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz5lE-00054w-7Y
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 22:01:48 +0000
Received: by mail-pl1-f193.google.com with SMTP id d1so5325639plr.8
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 15:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yK53+BLjmbYSvIoN9U+zH97wskr1cRMvxhD3SvcTdyQ=;
 b=oilMJG306YVbXe/10vN+GMiPmdGnY6sqqSpT+2rBDDmuff/p6ZggJA4Yj/gwppHS5p
 umY2b6EO3eABbAB5I2iHHOZDfIuRgz24RJPluGCTlny8LYcoOOOewPdBcy5lP9sszU0v
 +Dm8LjNWpDb9wJEKEca/Qi1udW3t+Od5gSc3gUzDe1yywVFWqeH0d4ZKX7KGJXflkeMc
 ZG+znuaeMIGtcN8tqYWLOWfBG/g3NpMohQo5SkdEo7geZUqbIfUFsL2pzoO0lqlZKgps
 vEuMONBGjmMiA29WMJQvPPgXX8SBHzjys0ao6gt+0+Ik2nYe9KKko3OF4LU1FDSaOlJE
 TCUQ==
X-Gm-Message-State: AOAM530PFsik4FMtYK3SxipmO9roD3atwODSBd6jBSsM3anOG8p8mKhh
 lMEzKizlogTg8L1JmX8946w=
X-Google-Smtp-Source: ABdhPJx9SkewAbKktnua41dFQuNJIDKuyJWO9BdVUgCdoyxfZ91YFk1kazk4AJn3Dhs//D0FNJzstg==
X-Received: by 2002:a17:90a:32cb:: with SMTP id
 l69mr6639116pjb.205.1595628106816; 
 Fri, 24 Jul 2020 15:01:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ac47:9fc4:b59:66fa?
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id 66sm7665134pfa.92.2020.07.24.15.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 15:01:45 -0700 (PDT)
Subject: Re: [PATCH] nvme-core: optimize process for error status
 NVME_SC_CMD_INTERRUPTED
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20200724081407.19346-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29618961-2596-7d75-40de-13af435d2d83@grimberg.me>
Date: Fri, 24 Jul 2020 15:01:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724081407.19346-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_180148_281761_F1A5FC81 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> @@ -243,7 +242,7 @@ static blk_status_t nvme_error_status(u16 status)
>   
>   static inline bool nvme_req_needs_retry(struct request *req)
>   {
> -	if (blk_noretry_request(req))
> +	if (!nvme_req_local_retry(req) && blk_noretry_request(req))

Why is this needed?

>   		return false;
>   	if (nvme_req(req)->status & NVME_SC_DNR)
>   		return false;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1de3f9b827aa..3213aae8985c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -725,4 +725,10 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl);
>   static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
>   #endif
>   
> +static inline bool nvme_req_local_retry(struct request *req)
> +{
> +	if (nvme_req(req)->status == NVME_SC_CMD_INTERRUPTED)
> +		return true;
> +	return false;
> +}
>   #endif /* _NVME_H */
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
