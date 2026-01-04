Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620DEC2A062
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 21:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EkCeWHeFxyyRVvjAUpgu22NteCuEXNRTDFw74UkD50k=; b=3vR+ppK8/ctqgvorR2qzvvc5cb
	Tj3nMj2cu2IMYd4ooDCCoaPTapDv+sY7chRQRylTVJxrr1QogGHKCyUaqPPyor7RfXWHS/RFvLYul
	yw6OSMF68G+3P0Xearkj2+pzygFvdB8J2WzsXk8D2Xv2efULKuPmxhK9COYzxSM5Bar+I45/p4+7p
	gp53oIG4+D35cW5GjGNuzfNHJ1w7I1LIN/tn7DgzhhR4SbW+EaxRF+Sz/sq8qy5jfY7gATeBjfaU6
	pmsfoAG5MbE6n3GjyOOlSVq2nSKkhhFOLXP05fAVh9cU1vSsJRIRTHHv8/uGfQqibEHXhhRcXFSqZ
	JGNBnfNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVp8-0000000AToT-458E;
	Sun, 04 Jan 2026 21:39:42 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVp6-0000000ATo6-1p60
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 21:39:41 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f57cd471so6270096f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 04 Jan 2026 13:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767562778; x=1768167578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkCeWHeFxyyRVvjAUpgu22NteCuEXNRTDFw74UkD50k=;
        b=BXA8eTLy8aW5K8XcBACClNkY10u4f2KFYugAqyjqlYxt5x/v9gUe32D0cMNbvlWF5D
         1r3gYAwfOoByoscX73DPcaqDbq0CxnDlV2GcZKzuHvoBQ1CkD+alMFf6f2vOqfa+INpY
         ahqOd0vb8ICH0YTkLmVXCfVuB/zmDpdyF+pFWgSuu38GpfEc4o04qXk3ENszljgZThOp
         MYE+wmwXjRbkQgbXasbePYnYCmbubAMloEUox9OwBTpmq01gYkT77M4c5hRZQhtiEZjF
         coDjwCTNFu/uaIQsIGyCbNB5nrmC6i26bXF2J+OwYRmNJ4TGvn+snAmptAXRJ9UxBNxE
         o6oA==
X-Forwarded-Encrypted: i=1; AJvYcCXsaq9FQ6pEmFo/WiMOeSnpcBc/wdIQ0j3EqHbhLEnjBAq36KokKvlwE/sdsKB3bTrh/nMxIeP8dQty@lists.infradead.org
X-Gm-Message-State: AOJu0YywN5PcRVrX7lu7ZEETdH+TpZrqNhuqaklipbUOVSatgV1wyLs5
	/F6KLWENtUQbHDA5GUktEWQnz77xMcoo18+JKZMUS2Xke/Nd7FAsAfYM
X-Gm-Gg: AY/fxX5RaeAKew+VkRa4nAeuC3Q+/kEBjpVgR80vbhiITOkxIDhBGUpEo0/dGXCMH8O
	ifjZIE86zaGIvfFOZEzcndlDVqoYmT6TeTi7dJ+DNVoW+2rL0rXjbPiywrmcsBbDPU6sqoiuf8H
	kCsLI3VceLXLjZj1p2UgXQYwHSpH8NfRVxPEzHsytIwuFFx1z3rI5QGKzvSEC8nwglzN31pk4DR
	o08uwc9BXKTW12Y1oMC14H3LXWCcd4fR73PcUc/CtakNvoyz28npHfqAL8kRxaRskXRFFAOHJO2
	nSrnrOxU/cl1m3NhxX8UBhJvnuHntpZTbDDKt55/Vqea0+fbe3BG8+IET/Qjy+1bX7hRfnL1iNh
	B9ViOLITyMN6We4FOwvotEizFZ7l3zBK4do9YyuEdFlPWmR/oA7PwwV2RXMDTzQFes7EPP7ZP6j
	zj3DrTs1FULHdkaWm6bUrV38rhZB0aETfZzwwLIp7T/jU=
X-Google-Smtp-Source: AGHT+IGlLsPoPsMRjs/QuLqTPJFCcvkyyx6uiSnJKdFVtpuE0vg98NJZDUPUOIz653OT0/nuVB2u2Q==
X-Received: by 2002:a05:6000:26c3:b0:430:f40f:61b9 with SMTP id ffacd0b85a97d-4324e4c68e1mr53280816f8f.4.1767562777311;
        Sun, 04 Jan 2026 13:39:37 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82fa1sm93181072f8f.23.2026.01.04.13.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 13:39:36 -0800 (PST)
Message-ID: <cdd44f55-cc5a-4ebe-aaba-6201674b9326@grimberg.me>
Date: Sun, 4 Jan 2026 23:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/14] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-9-mkhalfella@purestorage.com>
 <c698d201-0099-47a7-b5b0-d2322da63ea0@grimberg.me>
 <20251231234349.GP3864520-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251231234349.GP3864520-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260104_133940_513430_AA5FB61C 
X-CRM114-Status: GOOD (  47.44  )
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



On 01/01/2026 1:43, Mohamed Khalfella wrote:
> On Sat 2025-12-27 12:14:11 +0200, Sagi Grimberg wrote:
>>
>> On 26/11/2025 4:11, Mohamed Khalfella wrote:
>>> A host that has more than one path connecting to an nvme subsystem
>>> typically has an nvme controller associated with every path. This is
>>> mostly applicable to nvmeof. If one path goes down, inflight IOs on that
>>> path should not be retried immediately on another path because this
>>> could lead to data corruption as described in TP4129. TP8028 defines
>>> cross-controller reset mechanism that can be used by host to terminate
>>> IOs on the failed path using one of the remaining healthy paths. Only
>>> after IOs are terminated, or long enough time passes as defined by
>>> TP4129, inflight IOs should be retried on another path. Implement core
>>> cross-controller reset shared logic to be used by the transports.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/host/constants.c |   1 +
>>>    drivers/nvme/host/core.c      | 133 ++++++++++++++++++++++++++++++++++
>>>    drivers/nvme/host/nvme.h      |  10 +++
>>>    3 files changed, 144 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
>>> index dc90df9e13a2..f679efd5110e 100644
>>> --- a/drivers/nvme/host/constants.c
>>> +++ b/drivers/nvme/host/constants.c
>>> @@ -46,6 +46,7 @@ static const char * const nvme_admin_ops[] = {
>>>    	[nvme_admin_virtual_mgmt] = "Virtual Management",
>>>    	[nvme_admin_nvme_mi_send] = "NVMe Send MI",
>>>    	[nvme_admin_nvme_mi_recv] = "NVMe Receive MI",
>>> +	[nvme_admin_cross_ctrl_reset] = "Cross Controller Reset",
>>>    	[nvme_admin_dbbuf] = "Doorbell Buffer Config",
>>>    	[nvme_admin_format_nvm] = "Format NVM",
>>>    	[nvme_admin_security_send] = "Security Send",
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index f5b84bc327d3..f38b70ca9cee 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -554,6 +554,138 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>>>    }
>>>    EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
>>>    
>>> +static struct nvme_ctrl *nvme_find_ccr_ctrl(struct nvme_ctrl *ictrl,
>>> +					    u32 min_cntlid)
>>> +{
>>> +	struct nvme_subsystem *subsys = ictrl->subsys;
>>> +	struct nvme_ctrl *sctrl;
>>> +	unsigned long flags;
>>> +
>>> +	mutex_lock(&nvme_subsystems_lock);
>> This looks like the wrong lock to take here?
> This is similar to nvme_validate_cntlid()?
> What is the correct lock to use?

Not really, its only because it is called from nvme_init_subsystem which 
spans
subsystems.

>
>>> +	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
>>> +		if (sctrl->cntlid < min_cntlid)
>>> +			continue;
>> The use of min_cntlid is not clear to me.
>>
>>> +
>>> +		if (atomic_dec_if_positive(&sctrl->ccr_limit) < 0)
>>> +			continue;
>>> +
>>> +		spin_lock_irqsave(&sctrl->lock, flags);
>>> +		if (sctrl->state != NVME_CTRL_LIVE) {
>>> +			spin_unlock_irqrestore(&sctrl->lock, flags);
>>> +			atomic_inc(&sctrl->ccr_limit);
>>> +			continue;
>>> +		}
>>> +
>>> +		/*
>>> +		 * We got a good candidate source controller that is locked and
>>> +		 * LIVE. However, no guarantee sctrl will not be deleted after
>>> +		 * sctrl->lock is released. Get a ref of both sctrl and admin_q
>>> +		 * so they do not disappear until we are done with them.
>>> +		 */
>>> +		WARN_ON_ONCE(!blk_get_queue(sctrl->admin_q));
>>> +		nvme_get_ctrl(sctrl);
>>> +		spin_unlock_irqrestore(&sctrl->lock, flags);
>>> +		goto found;
>>> +	}
>>> +	sctrl = NULL;
>>> +found:
>>> +	mutex_unlock(&nvme_subsystems_lock);
>>> +	return sctrl;
>>> +}
>>> +
>>> +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
>>> +{
>>> +	unsigned long flags, tmo, remain;
>>> +	struct nvme_ccr_entry ccr = { };
>>> +	union nvme_result res = { 0 };
>>> +	struct nvme_command c = { };
>>> +	u32 result;
>>> +	int ret = 0;
>>> +
>>> +	init_completion(&ccr.complete);
>>> +	ccr.ictrl = ictrl;
>>> +
>>> +	spin_lock_irqsave(&sctrl->lock, flags);
>>> +	list_add_tail(&ccr.list, &sctrl->ccrs);
>>> +	spin_unlock_irqrestore(&sctrl->lock, flags);
>>> +
>>> +	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
>>> +	c.ccr.ciu = ictrl->ciu;
>>> +	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
>>> +	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
>>> +	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
>>> +				     NULL, 0, NVME_QID_ANY, 0);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	result = le32_to_cpu(res.u32);
>>> +	if (result & 0x01) /* Immediate Reset */
>>> +		goto out;
>>> +
>>> +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
>>> +	remain = wait_for_completion_timeout(&ccr.complete, tmo);
>>> +	if (!remain)
>> I think remain is redundant here.
> Deleted 'remain'.
>
>>> +		ret = -EAGAIN;
>>> +out:
>>> +	spin_lock_irqsave(&sctrl->lock, flags);
>>> +	list_del(&ccr.list);
>>> +	spin_unlock_irqrestore(&sctrl->lock, flags);
>>> +	return ccr.ccrs == 1 ? 0 : ret;
>> Why would you still return 0 and not EAGAIN? you expired on timeout but
>> still
>> return success if you have ccrs=1? btw you have ccrs in the ccr struct
>> and in the controller
>> as a list. Lets rename to distinguish the two.
> True, we did expire timeout here. However, after we removed the ccr
> entry we found that it was marked as completed. We return success in
> this case even though we hit timeout.

When does this happen? Why is it worth having the code non-intuitive for
something that effectively never happens (unless I'm missing something?)

>
> Renamed ctrl->ccrs to ctrl->ccr_list.
>
>>> +}
>>> +
>>> +unsigned long nvme_recover_ctrl(struct nvme_ctrl *ictrl)
>>> +{
>> I'd call it nvme_fence_controller()
> Okay. I will do that. I will also rename the controller state FENCING.
>
>>> +	unsigned long deadline, now, timeout;
>>> +	struct nvme_ctrl *sctrl;
>>> +	u32 min_cntlid = 0;
>>> +	int ret;
>>> +
>>> +	timeout = nvme_recovery_timeout_ms(ictrl);
>>> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
>>> +
>>> +	now = jiffies;
>>> +	deadline = now + msecs_to_jiffies(timeout);
>>> +	while (time_before(now, deadline)) {
>>> +		sctrl = nvme_find_ccr_ctrl(ictrl, min_cntlid);
>>> +		if (!sctrl) {
>>> +			/* CCR failed, switch to time-based recovery */
>>> +			return deadline - now;
>> It is not clear what is the return code semantics of this function.
>> How about making it success/failure and have the caller choose what to do?
> The function returns 0 on success. On failure it returns the time in
> jiffies to hold requests for before they are canceled. On failure the
> returned time is essentially the hold time defined in TP4129 minus the
> time it took to attempt CCR.

I think it would be cleaner to simple have this function return status 
code and
have the caller worry about time spent.

>
>>> +		}
>>> +
>>> +		ret = nvme_issue_wait_ccr(sctrl, ictrl);
>>> +		atomic_inc(&sctrl->ccr_limit);
>> inc after you wait for the ccr? shouldn't this be before?
> I think it should be after we wait for CCR. sctrl->ccr_limit is the
> number of concurrent CCRs the controller supports. Only after we are
> done with CCR on this controller we increment it.

Maybe it should be folded into nvme_issue_wait_ccr for symmetry?

>
>>> +
>>> +		if (!ret) {
>>> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
>>> +				 dev_name(sctrl->device));
>>> +			blk_put_queue(sctrl->admin_q);
>>> +			nvme_put_ctrl(sctrl);
>>> +			return 0;
>>> +		}
>>> +
>>> +		/* Try another controller */
>>> +		min_cntlid = sctrl->cntlid + 1;
>> OK, I see why min_cntlid is used. That is very non-intuitive.
>>
>> I'm wandering if it will be simpler to take one-shot at ccr and
>> if it fails fallback to crt. I mean, if the sctrl is alive, and it was
>> unable
>> to reset the ictrl in time, how would another ctrl do a better job here?
> We need to attempt CCR from multiple controllers for reason explained in
> another response. As you figured out min_cntlid is needed in order to
> not loop controller list forever. Do you have a better idea?

No, just know that I don't like it very much :)

>
>>> +		blk_put_queue(sctrl->admin_q);
>>> +		nvme_put_ctrl(sctrl);
>>> +		now = jiffies;
>>> +	}
>>> +
>>> +	dev_info(ictrl->device, "CCR reached timeout, call it done\n");
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(nvme_recover_ctrl);
>>> +
>>> +void nvme_end_ctrl_recovery(struct nvme_ctrl *ctrl)
>>> +{
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&ctrl->lock, flags);
>>> +	WRITE_ONCE(ctrl->state, NVME_CTRL_RESETTING);
>> This needs to be a proper state transition.
> We do not want to have proper transition from RECOVERING to RESETTING.
> The reason is that we do not want the controller to be reset while it is
> being recovered/fenced because requests should not be canceled. One way
> to keep the transitions in nvme_change_ctrl_state() is to use two
> states. Say FENCING and FENCED.
>
> The allowed transitions are
>
> - LIVE -> FENCING
> - FENCING -> FENCED
> - FENCED -> (RESETTING, DELETING)
>
> This will also git rid of NVME_CTRL_RECOVERED
>
> Does this sound good?

We could do what failfast is doing, in case we get transition FENCING -> 
RESETTING/DELETING we flush
the fence_work...

