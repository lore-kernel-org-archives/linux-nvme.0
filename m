Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643D0E7AD44
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Xua9hOavOYUb8TN2m61oLEdLKwfrx2F+tesXEcTW3A=; b=l/6KyGUbqzeLNMWUBAMsMNtTGe
	llhjXRZx7WwIVp80TBHpu/sC8g0DFsHQzViHcQZFPEHzfTYS9vBx8CTWd7Oq4nRt2PRkMRVyeVYC3
	yEeuxRzcq5NoiXy1/ryFhX5vq3P9T1grTRAg5PFjTOLThT/mlcS+ROOfPxXcAG6NYpEYjGl3NORGK
	KOTO0a5Xtuf7P4fYltVAqrWaZsNqdPy2TESi/HdjwgOoSpkD1B9c7ScW58Z13x0ZtB6yI2FZG2e6e
	4NjE0hRfm15d99PC8FtNdDAwrYRT45pINSNz6JpiJZCHD3q4XLjjyLKBXTq+AS3r1FKzI9pEocuTO
	bDRsvXRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYkx6-00000000QSp-1v1q;
	Thu, 25 Dec 2025 13:00:24 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYkx0-00000000QSN-3GeQ
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 13:00:21 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47a8195e515so42661415e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 05:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766667617; x=1767272417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Xua9hOavOYUb8TN2m61oLEdLKwfrx2F+tesXEcTW3A=;
        b=MQ7VtJbYPWnZthEM4L7hpXmHHLuGjXY1gh6hL9U959qckQ/Xyz2USFytIwjagJHyft
         rZbr3693dmS6B60FjpoyoUK6rgOhY0HPu+ybsElCaU0rO637E0EwQ7kJBiUaOnAAHVP6
         Z56ca3xWzSSrZ3dJJ7y4alttoYwnCZ2xu5GxCuokkCgBxJbFj946jIaXY0yul7iXI2O8
         OPOm3+U5DaczEvcaxLBox7p7c4fb4m5oqWVqSUCp6/jf3WUOOxlYPeobp9eg25VsrhIV
         GTHsn7BtQaDmJZsJTNnrckpWLaGHNexgKMTx0kB6J2dRPmuFYmMuLUTkXVo/DVTnGEW0
         2TEQ==
X-Gm-Message-State: AOJu0Yxqb28+3KTyBvo6SwhGs8B7tBeVYAwaNlWyrfTT/wJzZukpLhWY
	61rmMokkE285isOW1scQuZ4/Vge7xQvgXQ5Cfq0519y0AY3wmAekATAFpVf1oR5W
X-Gm-Gg: AY/fxX7P5s9r7fRs4rusUnJrDjbu3qQk+ylE4LDk1+2DsGxKXj+QqENt/xkaxN11f1L
	tbT0yypUZT38a6BMZ8yS/0r98hejnyJkWmTBEgxJNhCsI4xrlYq1HXCIGoodcTMOol4DQoDzUpg
	L4ouxjiwMfqm7VUQSHsDuCENMBCUGTziWfCGxuM7huRDijJlevROx4rzI3PgRg/V53qw76Is09j
	Ci9D2mfS7Z1S24qOe2DpZXy0p9CbRoDr39XqqV3rQzn2VAXr/0NiWjnptoFo6d1cuzpiPrT+52A
	9HcezZ1kERF64yA0qqBmtBpY1cxKg0nYxKsy7CZxaUsRak9ZMpg/rppNXVXgfq8j1h0wlPDYmiE
	Ibm73TVKKJt8ylFj9hi1FzlrZV+4uFotg/j+2rzhXf6itYSJOCIfyvH9unT0PsIoerWFb03cNHt
	l59HBo14W5P9PIPq70XV+OcQJ4HBy0kYvgAxus2LsDPLDaHw==
X-Google-Smtp-Source: AGHT+IHIXcx10qChFU5FmVsyqyrCwzoH7C2OeaOopRCcSiiG7oXGEm+PH+5VxgOVI03k+nRQNPkrKQ==
X-Received: by 2002:a05:600c:348a:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-47d1958a755mr231404915e9.21.1766667616566;
        Thu, 25 Dec 2025 05:00:16 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3ac5409sm152916315e9.15.2025.12.25.05.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 05:00:16 -0800 (PST)
Message-ID: <88f1a3af-c6f4-42eb-bf63-504998028973@grimberg.me>
Date: Thu, 25 Dec 2025 15:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme/host: add delayed retries upon non-fatal error
 during ns validation
To: Alex Tran <alex.t.tran@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251221-nvme_ns_validation-v1-0-9f7a385707af@gmail.com>
 <20251221-nvme_ns_validation-v1-2-9f7a385707af@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251221-nvme_ns_validation-v1-2-9f7a385707af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_050019_808135_066116B1 
X-CRM114-Status: GOOD (  23.32  )
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



On 21/12/2025 23:26, Alex Tran wrote:
> If a non-fatal error is received during nvme namespace validation, it
> should not be ignored and the namespace should not be removed immediately.
> Rather, delayed retires should be performed on the namespace validation
> process.
>
> This handles non-fatal issues more robustly, by retrying a few times before
> giving up and removing the namespace. The number of retries is set
> to 3 and the interval between retries is set to 3 seconds.
>
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---
>   drivers/nvme/host/core.c | 43 +++++++++++++++++++++++++++++++++++++++----
>   drivers/nvme/host/nvme.h |  9 +++++++++
>   2 files changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fab321e79b7cdbb89d96d950c1cc8c1128906770..2e208d894b27f85f7f6358eb697be262ce45aed6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -139,6 +139,7 @@ static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
>   				   struct nvme_command *cmd);
>   static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page,
>   		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi);
> +static void nvme_validate_ns_work(struct work_struct *work);
>   
>   void nvme_queue_scan(struct nvme_ctrl *ctrl)
>   {
> @@ -4118,6 +4119,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   	ns->ctrl = ctrl;
>   	kref_init(&ns->kref);
>   
> +	INIT_DELAYED_WORK(&ns->validate_work, nvme_validate_ns_work);
> +
>   	if (nvme_init_ns_head(ns, info))
>   		goto out_cleanup_disk;
>   
> @@ -4215,6 +4218,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   {
>   	bool last_path = false;
>   
> +	cancel_delayed_work_sync(&ns->validate_work);
> +
>   	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>   		return;
>   
> @@ -4285,12 +4290,42 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   out:
>   	/*
>   	 * Only remove the namespace if we got a fatal error back from the
> -	 * device, otherwise ignore the error and just move on.
> -	 *
> -	 * TODO: we should probably schedule a delayed retry here.
> +	 * device, otherwise delayed retries are performed.
>   	 */
> -	if (ret > 0 && (ret & NVME_STATUS_DNR))
> +	if (ret > 0 && (ret & NVME_STATUS_DNR)) {
>   		nvme_ns_remove(ns);
> +	} else if (ret > 0) {
> +		if (ns->validate_retries < NVME_NS_VALIDATION_MAX_RETRIES) {
> +			ns->validate_retries++;
> +
> +			if (!nvme_get_ns(ns))
> +				return;
> +
> +			dev_warn(
> +				ns->ctrl->device,
> +				"validation failed for nsid %d, retry %d/%d in %ds\n",
> +				ns->head->ns_id, ns->validate_retries,
> +				NVME_NS_VALIDATION_MAX_RETRIES,
> +				NVME_NS_VALIDATION_RETRY_INTERVAL);
> +			memcpy(&ns->pending_info, info, sizeof(*info));
> +			schedule_delayed_work(
> +				&ns->validate_work,
> +				NVME_NS_VALIDATION_RETRY_INTERVAL * HZ);

Given that ns scanning is already async, wouldn't it be simpler to 
simply retry locally
in a loop?

