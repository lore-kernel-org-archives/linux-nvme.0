Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C960CE8FDD6
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ztrc7rvqCDz1+RF07MiG4SyIq7mNe9Y5gTsg7JzaAgg=; b=zMbdKaRyOItocVidQhxJnioBEZ
	kJjcqsXhIRoMAWeTjfRoj0Hgfiwovjzbf2n0oQNT23tX+dSOV1xzAAHEeTgIbB2IStvadJ0o497af
	hxqvFn3q1a3hlN0fI4JBvIYaVb4fEDaqLtQ1O3sdUBw1iXIcrvFVf+tYEqrnVUaoqJ3dRfkZzHrSM
	MrN8v7mu3LDvFttKWHR6Pn8StJIVYoOyrTM92SzPY/eS2SYx8jv6ERvvStoE9EsSVbQk3LWk6SP5m
	+1HqeIi0/s6clbU8wDxuq+387CWp6U/PQhL+0inQPnOpfERQdaBBholktz/yb7SEKN+xIoW7w54Fx
	+JvuaSxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZQus-00000001q1t-3zuA;
	Sat, 27 Dec 2025 09:48:54 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZQur-00000001q1X-0xPd
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 09:48:54 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so6103627f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 01:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766828931; x=1767433731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztrc7rvqCDz1+RF07MiG4SyIq7mNe9Y5gTsg7JzaAgg=;
        b=dVPGHm4x8Bx4fxK0NTR70gaEkzx2v7oCQQuD/kHIihzpvHw8Yw12prWYJth7ecOICI
         /zCi3lVbTqBFDxloYMZUI90pqQwWQsig985vjecbe8oYe/7LaVkB9qOrMtCyTC3+J/x0
         hZLQ2sSNMA01VAgPlk2ggnBAh8iKv0PUrZ2OUyi8rEeJ/VGo0BPKiGlXjIzttFCJP6Zr
         p1XOQW1L/XQ+BVA+ySQKBmKLSVVnMdV0Cz1c3T2SaexmewQ+vMtRj3odth6Iblj1Esza
         UUNbYWMITUr5P8lk5RicigQ8Llqt/Ty7BSr0WpTY6REDVH9wB7deuUpJnxxQL3Z7hXjw
         kIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Fh5cWEaEv/F3e6Ihd1mVgT43lRTUXKTqa4GGzzfoeOmRPQfX2JmMvPdYfQZ4nuVaUt0Hls5Wwmye@lists.infradead.org
X-Gm-Message-State: AOJu0Yzf7tVMVjc4APsLXM3u7qtL42+Ij4ri3QnOYITwPAX7nQ7t/yE0
	LAG4G2hqGNJSEuZH4u/D+XIcTMZWP9l6wlrsZfR+GV43yGO+AGn67FxxQt1nNQiw
X-Gm-Gg: AY/fxX6z68yDpUyxaTAq7Mt8HjXOBFgeWS6i9sPD8EnU6gD+64w36+kNdIT8oCXCATF
	ucqhmC3dtvOJmgHP0ZsTzlLCoGXzSvH9jybTM/ELVWsjFlF2I5W/WSmsHzobLupRlk42IzwHgQE
	niz+so1+vyYDHB+qOvZqdtfQh/f9pAtPjhGk0bkbj4fLGyYQ4wqrE1e5BCxC1fnz54PyEkhZZx/
	TOVmSrwqrKRT8fFsZFmuUJZysBTF48XlreHHI1gUfJRdLwrXZf8q6LQrjtH8FwrdAGegIa7qWJL
	kPoMEkvcL8DwMu8PNEUBIw3HaOfSeN47hhIMeWAfPnftlaiRCieoG7/sf4w+mb+xtSJIvzjfdau
	cNuPgFwcPW6G5JCcXjkHs37hbEWtP/IqfhUxNv1b5M5ddpDBIfetUkorpFSj1p8lU2ZZnpSw7oP
	EFSIrBSXsA0vSUgPXaiHLEmsoZ8Om806ZFoIh1TwG6/h0=
X-Google-Smtp-Source: AGHT+IHVmjH6fpcO2VVQjroVv1xu2GYgtksCzhbfZj40KUqqAgqOSsmlZopXRjp09EUyDUeBiXXZuA==
X-Received: by 2002:a5d:588c:0:b0:430:fd60:9411 with SMTP id ffacd0b85a97d-4324e4c9dd1mr30540168f8f.21.1766828930999;
        Sat, 27 Dec 2025 01:48:50 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325b6bfe88sm41925916f8f.19.2025.12.27.01.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 01:48:50 -0800 (PST)
Message-ID: <eaf73b5a-a438-4afe-a76e-148a7d9744ef@grimberg.me>
Date: Sat, 27 Dec 2025 11:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/14] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-6-mkhalfella@purestorage.com>
 <13c2bf9c-6eac-4c48-b12c-f76e86c8ef32@grimberg.me>
 <20251225181313.GC8129-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251225181313.GC8129-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_014853_299399_04FA557C 
X-CRM114-Status: GOOD (  24.73  )
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



On 25/12/2025 20:13, Mohamed Khalfella wrote:
> On Thu 2025-12-25 15:23:51 +0200, Sagi Grimberg wrote:
>>
>> On 26/11/2025 4:11, Mohamed Khalfella wrote:
>>> Send an AEN to initiator when impacted controller exists. The
>>> notification points to CCR log page that initiator can read to check
>>> which CCR operation completed.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/target/core.c  | 27 +++++++++++++++++++++++----
>>>    drivers/nvme/target/nvmet.h |  3 ++-
>>>    include/linux/nvme.h        |  3 +++
>>>    3 files changed, 28 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>> index 7dbe9255ff42..60173833c3eb 100644
>>> --- a/drivers/nvme/target/core.c
>>> +++ b/drivers/nvme/target/core.c
>>> @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
>>>    	nvmet_async_events_process(ctrl);
>>>    }
>>>    
>>> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>> +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
>>>    		u8 event_info, u8 log_page)
>>>    {
>>>    	struct nvmet_async_event *aen;
>>> @@ -215,12 +215,17 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>>    	aen->event_info = event_info;
>>>    	aen->log_page = log_page;
>>>    
>>> -	mutex_lock(&ctrl->lock);
>>>    	list_add_tail(&aen->entry, &ctrl->async_events);
>>> -	mutex_unlock(&ctrl->lock);
>>>    
>>>    	queue_work(nvmet_wq, &ctrl->async_event_work);
>>>    }
>>> +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>> +		u8 event_info, u8 log_page)
>>> +{
>>> +	mutex_lock(&ctrl->lock);
>>> +	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
>>> +	mutex_unlock(&ctrl->lock);
>>> +}
>>>    
>>>    static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
>>>    {
>>> @@ -1788,6 +1793,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>>>    }
>>>    EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
>>>    
>>> +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
>>> +{
>>> +	lockdep_assert_held(&ctrl->lock);
>>> +
>>> +	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
>>> +		return;
>>> +
>>> +	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
>>> +				     NVME_AER_NOTICE_CCR_COMPLETED,
>>> +				     NVME_LOG_CCR);
>>> +}
>>> +
>>>    static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
>>>    {
>>>    	struct nvmet_subsys *subsys = ctrl->subsys;
>>> @@ -1801,8 +1818,10 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
>>>    	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
>>>    		mutex_lock(&sctrl->lock);
>>>    		list_for_each_entry(ccr, &sctrl->ccrs, entry) {
>>> -			if (ccr->ctrl == ctrl)
>>> +			if (ccr->ctrl == ctrl) {
>>> +				nvmet_ctrl_notify_ccr(sctrl);
>>>    				ccr->ctrl = NULL;
>>> +			}
>> Is this double loop necessary? Would you have more than one controller
>> cross resetting the same
> As it is implemented now CCRs are linked to sctrl. This decision can be
> revisited if found suboptimal. At some point I had CCRs linked to
> ctrl->subsys but that led to lock ordering issues. Double loop is
> necessary to find all CCRs in all controllers and mark them done.
> Yes, it is possible to have more than one sctrl resetting the same
> ictrl.

I'm more interested in simplifying.

>
>> controller? Won't it be better to install a callback+opaque that the
>> controller removal will call?
> Can you elaborate more on that? Better in what terms?
>
> nvmet_ctrl_complete_pending_ccr() is called from nvmet_ctrl_free() when
> we know that ctrl->ref is zero and no new CCRs will be added to this
> controller because nvmet_ctrl_find_get_ccr() will not be able to get it.

In nvmet, the controller is serving a single host. Hence I am not sure I
understand how multiple source controllers will try to reset the impacted
controller. So, if there is a 1-1 relationship between source and impacted
controller, I'd perhaps suggest to simplify and install on the impacted 
controller
callback+opaque (e.g. void *data) instead of having it iterate and then 
actually send
the AEN from the impacted controller.

