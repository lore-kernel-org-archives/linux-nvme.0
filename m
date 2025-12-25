Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D9AE7AD4F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6BLy1y+Nnd8HejAEuGrNJybNHg4mcI0uPSHEnvoSFJI=; b=mQ+a8vc2Ut6Icmp8XXHEWtx3N+
	GrsD/M4Q20Z+hP1ZRpmm/OR0/o8uIT/vyFBtE0017mg4Ee8l4J0i+nOxb881p/4T+s5fZqUJ85OEL
	sCXmWY9l2KmyWhkzoc7vFKBE0xtdqjClO+M/zj74Y8jC3vwX3wZvBo01+KvjYPBNJL89UpsGejISe
	Uszwld1MDDkY5aPF5IKe0vM152q9Ml888wT3BSua16m7BOlBhDDQO4dxNIAdjWL9gjrJ+1JwpJOJ5
	wohnuiwUyHqcn6d0ahoJ+E+h3Tmc/tcGjkM74Bm/ChU+CvayH/aXFIjMKwICBMvPJoNGBmEy1pbtI
	NrlReFzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYlJu-00000000RJg-0qGI;
	Thu, 25 Dec 2025 13:23:58 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYlJs-00000000RJJ-0VY4
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 13:23:57 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so48845755e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 05:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766669034; x=1767273834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BLy1y+Nnd8HejAEuGrNJybNHg4mcI0uPSHEnvoSFJI=;
        b=ZnS+Ldu0rqazIbspdK35W/7GByFXoxwccyHVDLhz0xQ8xgmPg2p9clDHAWezXuQMmr
         J7GuKm1iz/MBp5w8QkoftuL9Q1VPgsoQwuI5Ow4+sw92f2ovk0dexIbjmOB9DI8WiAs4
         UV6dcysYCruYvpQ7D68QI6HQfBKnC7YpR/TLinxOrBZwn3O1s3omnAU82GO1H/JdapOL
         kcqO/YiEvueoYy2cSdbkW/6jxbF36B4bhaM6LbEqYesCJ200Zz+UhtyNrzcUyE9oX2so
         oBznhNnR3NED6uFXqIshYiZ06bk0LqfjDVy6TUDCY6iMtumlB/G6r8AgoF1VteL0bd4F
         NaYA==
X-Forwarded-Encrypted: i=1; AJvYcCWWppaYyHXe36S2nCvUj5pGkUKlzdz8sOQvV+4oEub9uwTDU19zZDLA7xNDZ6Oa7Tx+yoZX10wlvAyT@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9mT5lKpnFTQ0sC6Qbpzn7xwRC3a1oBqpdOnYSjP+LjF2zzAWX
	H/XVhCAZ4aPw6EhrHMa5u7GbpYeq9k3MTR6GAJMT2pRIkYOPiywmCCmJ
X-Gm-Gg: AY/fxX6tARdbF/xA7MhQxrb82AZ+L66y1xW6KdTwXMa0+QhIyrSiQi78LN3TslkY8iS
	aj9Xni/TX6Q5mfaSgBCW/T8O6LyvuIAurw01RuMsCbYS3akutgHCVaXP3QhggNWtFKP7kKtw43p
	p9eJEzfNtSbVlARM5ONb1A70kAR5suLr/bMsj3U5lhPIN6sPyaCU8uZiqYxvur6iIglsxoQxUYn
	Ui5mwW9YCNgd+WlZhFBTPwmxhru0qZ/iYDGrubz5PRzHWSEqB6IFAqk4YBrCmZma3Agh2CpJp27
	dyDlDWN1V0dxG48nZMGsGtpmpZNnk+KJxtlw440k+a/R5OsjrI0xE4NM1mBA1afbm7cbRZFzBs3
	OeQ8rT/VKzs/EHXqi1FaabSQQiqecdM4iCapeAqTU7c7z94xU7G4oXqam2l6qfw99iRV5iOr2sx
	ta5ghEUH/mu8Qe6cjJT2ZI8yW3i9lF2yeKxdZr798K2fZ4/w==
X-Google-Smtp-Source: AGHT+IGJJG4xzrR/BvmC8H40fIqocVBQQ0JspOij6L3jUUnZYoH5cpmVOt2bZrYBBoq6YIO1MMBp/w==
X-Received: by 2002:a05:600c:8b11:b0:477:55ce:f3bc with SMTP id 5b1f17b1804b1-47d2d273515mr151140315e9.19.1766669033944;
        Thu, 25 Dec 2025 05:23:53 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d4e91sm335411545e9.13.2025.12.25.05.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 05:23:53 -0800 (PST)
Message-ID: <13c2bf9c-6eac-4c48-b12c-f76e86c8ef32@grimberg.me>
Date: Thu, 25 Dec 2025 15:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/14] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-6-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251126021250.2583630-6-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_052356_283183_6DDB63D4 
X-CRM114-Status: GOOD (  18.60  )
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



On 26/11/2025 4:11, Mohamed Khalfella wrote:
> Send an AEN to initiator when impacted controller exists. The
> notification points to CCR log page that initiator can read to check
> which CCR operation completed.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/core.c  | 27 +++++++++++++++++++++++----
>   drivers/nvme/target/nvmet.h |  3 ++-
>   include/linux/nvme.h        |  3 +++
>   3 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 7dbe9255ff42..60173833c3eb 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
>   	nvmet_async_events_process(ctrl);
>   }
>   
> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
>   		u8 event_info, u8 log_page)
>   {
>   	struct nvmet_async_event *aen;
> @@ -215,12 +215,17 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>   	aen->event_info = event_info;
>   	aen->log_page = log_page;
>   
> -	mutex_lock(&ctrl->lock);
>   	list_add_tail(&aen->entry, &ctrl->async_events);
> -	mutex_unlock(&ctrl->lock);
>   
>   	queue_work(nvmet_wq, &ctrl->async_event_work);
>   }
> +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +		u8 event_info, u8 log_page)
> +{
> +	mutex_lock(&ctrl->lock);
> +	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
> +	mutex_unlock(&ctrl->lock);
> +}
>   
>   static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
>   {
> @@ -1788,6 +1793,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
>   
> +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
> +{
> +	lockdep_assert_held(&ctrl->lock);
> +
> +	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
> +		return;
> +
> +	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
> +				     NVME_AER_NOTICE_CCR_COMPLETED,
> +				     NVME_LOG_CCR);
> +}
> +
>   static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
>   {
>   	struct nvmet_subsys *subsys = ctrl->subsys;
> @@ -1801,8 +1818,10 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
>   	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
>   		mutex_lock(&sctrl->lock);
>   		list_for_each_entry(ccr, &sctrl->ccrs, entry) {
> -			if (ccr->ctrl == ctrl)
> +			if (ccr->ctrl == ctrl) {
> +				nvmet_ctrl_notify_ccr(sctrl);
>   				ccr->ctrl = NULL;
> +			}

Is this double loop necessary? Would you have more than one controller 
cross resetting the same
controller? Won't it be better to install a callback+opaque that the 
controller removal will call?

