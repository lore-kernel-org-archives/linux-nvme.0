Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB33C5ACB3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 09:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XB/kzKXnf/yNI7qZKKTYdk4EutwHO/sinQoDAA0n5Lk=; b=pbG0ya3DNuMDOsdxNNICEOBP5o
	rjs1lFxqNypJIP2a6nfDDTFQJLqbCIgZq3H4hqaUK8cVEjbADLhKllPrfn3MEUUB1a1SINZA/BFxu
	P4I2BGmhBHHPERy6nZ9VdqbJZQO//VBZ1ZnwQ1nCkps9ZDRUVzYn7CEAKnk9zko47ce5CTUFmZEY5
	Vg+zAJmRuhS0AR73xVECgg+z8K+1mIohMwkMMGtIP79aIddcdWVoCv5CKs7cmr2zvgillbC3ezXc9
	s0yQPb8Fld4Wj1LzDCyZqqFDUXAZdhBaz9cgprSIBAj56FBPGuzz+HBq+/3ZrvGj53fDAmZJtxy3w
	GG3ZLCmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Mrv-00G6a2-2F;
	Tue, 21 Nov 2023 09:16:31 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Mrq-00G6Zi-1B
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 09:16:30 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40b2a85c99bso134925e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Nov 2023 01:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558184; x=1701162984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XB/kzKXnf/yNI7qZKKTYdk4EutwHO/sinQoDAA0n5Lk=;
        b=tMIYUq44WSKWvnG/lGDORWuhBhsiJ6C+VMnqYmLUrHJ03czp+q2qMw1Y1rFm1Nqb36
         3drr09f25vAOZvmA/1EH97jdBrWEIGEoCsQ+cFwOdmcnfgH2+j60HsQpnW2QvMK9BT+H
         Mepv3ESI2gjLoihU+EXFBwRd98k0D30FpJ9inwf/+6dqhdm8kJJmix+wZ8DGm187Sds/
         J2Lw4wGAN6iJwh/sKQzYE1pVdVvy54di6NVCYcgiQ3T2LhLJfPnw+5veA+lCVSmyngGT
         TDS9I/cWKVfpyffe+QPqQlN2qUa40WrC2D22gTt5TaM/E/bt60bst297v6cm11FC++fW
         EoIA==
X-Gm-Message-State: AOJu0YwIOuCWChxR9h2Fa3vcLtZnMsaFk3UtAnNJKVbHTerFlZ/MwRM0
	3P+UyJmOoX21ayHkyasT3peYkw5CPRI=
X-Google-Smtp-Source: AGHT+IEpt/DXcbENm2K/UaFajtt9RI3aVcfbeQOMXRceeWWsd4Izk7qdtTO1ScB4BOsDOo8EY42D+g==
X-Received: by 2002:a05:600c:3ca7:b0:405:358c:ba75 with SMTP id bg39-20020a05600c3ca700b00405358cba75mr8720521wmb.0.1700558183996;
        Tue, 21 Nov 2023 01:16:23 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b004090ca6d785sm16593352wmb.2.2023.11.21.01.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 01:16:23 -0800 (PST)
Message-ID: <749b4676-d065-4395-bad6-f585261a1d97@grimberg.me>
Date: Tue, 21 Nov 2023 11:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
 <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
 <337014e5-f564-4f0e-8c3c-298156aa82f3@suse.de>
 <7401e53a-59b8-41d5-8055-600725ecee06@grimberg.me>
 <c4539237-0740-4f92-a7d6-eebf825a66b0@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c4539237-0740-4f92-a7d6-eebf825a66b0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_011628_994227_22EE3773 
X-CRM114-Status: GOOD (  23.07  )
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



On 11/21/23 09:29, Hannes Reinecke wrote:
> On 11/20/23 20:05, Sagi Grimberg wrote:
>>
>>
>> On 11/20/23 18:01, Hannes Reinecke wrote:
>>> On 11/20/23 14:39, Sagi Grimberg wrote:
>>>>
>>>>> Setting up I/O queues might take quite some time on larger and/or
>>>>> busy setups, so KATO might expire before all I/O queues could be
>>>>> set up.
>>>>> Fix this by start keep alive from the ->init_ctrl_finish() callback,
>>>>> and stopping it when calling nvme_cancel_admin_tagset().
>>>>
>>>> If this is a fix, the title should describe the issue it is fixing, and
>>>> the body should say how it is fixing it.
>>>>
>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>> ---
>>>>>   drivers/nvme/host/core.c | 6 +++---
>>>>>   drivers/nvme/host/fc.c   | 6 ++++++
>>>>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index 62612f87aafa..f48b4f735d2d 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -483,6 +483,7 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
>>>>>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>>>>>   {
>>>>> +    nvme_stop_keep_alive(ctrl);
>>>>>       if (ctrl->admin_tagset) {
>>>>>           blk_mq_tagset_busy_iter(ctrl->admin_tagset,
>>>>>                   nvme_cancel_request, ctrl);
>>>>
>>>> There is a cross dependency here, now nvme_cancel_admin_tagset needs to
>>>> have the keep-alive stopped first, which may be waiting on I/O, which
>>>> needs to be cancelled...
>>>>
>>>> Keep in mind that kato can be arbitrarily long, and now this function
>>>> may be blocked on this kato period.
>>>>
>>>> I also think that now the function is doing something that is more
>>>> than simply cancelling the inflight admin tagset, as it is named.
>>>>
>>> I am having a hard time following this reasoning.
>>> While I do accept that nvme_stop_keep_alive() might trigger I/O
>>> (ie if the work queue has just been started when calling 
>>> cancel_delayed_work), nvme_tcp_error_recovery_work() has this:
>>>
>>>      nvme_stop_keep_alive(ctrl);
>>>      flush_work(&ctrl->async_event_work);
>>>      nvme_tcp_teardown_io_queues(ctrl, false);
>>>      /* unquiesce to fail fast pending requests */
>>>      nvme_unquiesce_io_queues(ctrl);
>>>      nvme_tcp_teardown_admin_queue(ctrl, false);
>>>
>>> and nvme_tcp_teardown_admin_queue() calls nvme_cancel_admin_tagset().
>>> So by your above reasoning this code should be wrong, too.
>>> What am I missing?
>>
>> Need to dig through the history, but it can most definitely move to
>> after the teardown. It could be from the earlier days where the
>> transport fencing was not as reliable particularly for admin requests.
> 
> Ah, no. We are both wrong. Colophon of cancel_delayed_work():
> 
>   * Note:
>   * The work callback function may still be running on return, unless
>   * it returns %true and the work doesn't re-arm itself.  Explicitly 
> flush or
>   * use cancel_delayed_work_sync() to wait on it.
> 
> Hence we won't be blocked by running I/O when calling 
> nvme_stop_keep_alive().
> So the correct syntax would indeed be calling nvme_stop_keep_alive()
> first, and then disable/cancel the admin tagset (which will terminate
> any outstanding keep-alive requests).

Yes, you're correct. because keep-alive is not a sync command it
won't block on io. However I still don't see why should we change
where it exist today (i.e. the choice to move it to the odd location
of nvme_cancel_admin_tagset).

I agree that we can move start_keep_alive earlier.

