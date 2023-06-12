Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D5CC7EE2E
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 06:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8atXZoT1043zoF0AV+s/iPvTpj1b62bruyUjnsB0cvs=; b=BHG0sxYRIOJJu73Y2nfVBWQiLn
	hzDQ5+ROC2eMbz6abXeDRMDNvhnFfPbwqkcDfg9nQrhgMEdJgw/dZAwh/LliPywOiEiJ8Rts/h30E
	A0Bb2AP+QvhoSxBLFuiWJ/FqoQL1noaG3rerGMCX/3iCMYtUcZ0wFlTfpnfy+Y5MLZA1SK4lsdqJ6
	LziXJR8xC7rFCMvvgk9bfzna9yKTqGpWO2uVB72kMcnT43ZYhUq3sG8cYaGY28jfmXi4MklW4EP5W
	gnN9RV1sdwynIEGk+J7kytS2w5QK6bodwdGOhO31NJ+qGdrR76Nc1s7YY8XRVqgBVgaE54Ro2dOBI
	zhmFBolA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8bB0-002n1Q-2f;
	Mon, 12 Jun 2023 06:37:18 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8bAw-002my4-1u
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 06:37:17 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f7f67e8f1dso9957105e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 11 Jun 2023 23:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686551815; x=1689143815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8atXZoT1043zoF0AV+s/iPvTpj1b62bruyUjnsB0cvs=;
        b=dSxG7vtkOrI9RASiULElix5ygTb5MmXB1d1xNBe897+wbJXF+hIqySYYM8ps9gpseq
         5SB2OffiLPZfT8eBaMyoM7e9m7rgkm5rAY7KOJEfL1BIH0k8qHc4p11Y/Bc3XhK7rnXl
         fM3+LJS6gxUirNm/8pvrLDJdjeMQSeGQxTIUvCHx2QRlRK/cTzrcG2hX1Uf2cLgF6gEL
         maHtzTEKctIzpT+1z/mdrrReHGOQD82n9IhDpRd0a+HjOaP8g2pa7GOaPuF2NHwvO3KN
         773Nyq5ki5PDZ4ZaIpWI3Pimv7rhHFvNZKlOsqPGPbPPEOdlbqa451Ng7Q5v6A4WaMN8
         eHZw==
X-Gm-Message-State: AC+VfDyRZ+nz0VbK0ZLxT6qoYkBzVR1cuwXc0n4weP1zRzU8fjOd47qA
	/jKXQBmkEMdOmBZQAwernww=
X-Google-Smtp-Source: ACHHUZ7maAbmSth6MfGoaJGsA2c1PpprEyO0wMcPcFlkjZp1P6ViPI3nHS+BLQDEuXbQr9VIBU1b7Q==
X-Received: by 2002:a05:600c:3843:b0:3f7:1483:b229 with SMTP id s3-20020a05600c384300b003f71483b229mr6538633wmr.3.1686551814910;
        Sun, 11 Jun 2023 23:36:54 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003f735ba7736sm10268780wmq.46.2023.06.11.23.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 23:36:54 -0700 (PDT)
Message-ID: <7a17d0f9-c624-2b30-476e-1a039f978c4e@grimberg.me>
Date: Mon, 12 Jun 2023 09:36:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1685350577.git.chunguang.xu@shopee.com>
 <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
 <febff498-63e6-efe2-2f5a-9a9fa7e767c0@grimberg.me>
 <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230611_233714_631269_66064201 
X-CRM114-Status: GOOD (  25.83  )
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


>>>> Hi Ming:
>>>>
>>>> Ming Lei <ming.lei@redhat.com> 于2023年6月6日周二 23:15写道：
>>>>>
>>>>> Hello Chunguang,
>>>>>
>>>>> On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
>>>>>> From: Chunguang Xu <chunguang.xu@shopee.com>
>>>>>>
>>>>>> We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->scan_work)
>>>>>> while removing ctrl. The root cause may due to the state of ctrl changed to
>>>>>> NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error_recovery_work()/
>>>>>> nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, ctrl is
>>>>>
>>>>> I didn't dig into ctrl state check in these error handler yet, but error
>>>>> handling is supposed to provide forward progress for any controller state.
>>>>>
>>>>> Can you explain a bit how switching to DELETING interrupts the above
>>>>> error handling and breaks the forward progress guarantee?
>>>>
>>>> Here we freezed ctrl, if ctrl state has changed to DELETING or
>>>> DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
>>>> freeze, so nvme_remove_namespaces() hang.
>>>>
>>>> static void nvme_tcp_error_recovery_work(struct work_struct *work)
>>>> {
>>>>           ...
>>>>           if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
>>>>                   /* state change failure is ok if we started ctrl delete */
>>>>                   WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
>>>>                                ctrl->state != NVME_CTRL_DELETING_NOIO);
>>>>                   return;
>>>>           }
>>>>
>>>>           nvme_tcp_reconnect_or_remove(ctrl);
>>>> }
>>>>
>>>>
>>>> Another path, we will check ctrl state while reconnecting, if it changes to
>>>> DELETING or DELETING_NIO, we will break up and lease ctrl freeze and
>>>> queue quiescing (through reset path), as a result Hang occurs.
>>>>
>>>> static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>>>> {
>>>>           /* If we are resetting/deleting then do nothing */
>>>>           if (ctrl->state != NVME_CTRL_CONNECTING) {
>>>>                   WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
>>>>                           ctrl->state == NVME_CTRL_LIVE);
>>>>                   return;
>>>>           }
>>>>           ...
>>>> }
>>>>
>>>>>> freezed and queue is quiescing . Since scan_work may continue to issue IOs to
>>>>>> load partition table, make it blocked, and lead to nvme_tcp_error_recovery_work()
>>>>>> hang in flush_work(&ctrl->scan_work).
>>>>>>
>>>>>> After analyzation, we found that there are mainly two case:
>>>>>> 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it issue
>>>>>>      new IO to load partition table.
>>>>>
>>>>> Yeah, nvme freeze usage is fragile, and I suggested to move
>>>>> nvme_start_freeze() from nvme_tcp_teardown_io_queues to
>>>>> nvme_tcp_configure_io_queues(), such as the posted change on rdma:
>>>>>
>>>>> https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0
>>>>
>>>> While drive reconnecting, I think we should freeze ctrl or quiescing queue,
>>>> otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
>>>> and the IOs may retry frequently. So I think we may better freeze ctrl
>>>> while entering
>>>> error_recovery/reconnect, but need to unfreeze it while exit.
>>>
>>> quiescing is always done in error handling, and freeze is actually
>>> not a must, and it is easier to cause race by calling freeze & unfreeze
>>> from different contexts.
>>>
>>> But yes, unquiesce should have been done after exiting error handling, or
>>> simply do it in nvme_unquiesce_io_queues().
>>>
>>> And the following patch should cover all these hangs:
>>>
>>
>> Ming, are you sending a formal patchset for this?
> 
> Not yet, will do it.

Would like it to get to the next pull request going out this week...

>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 3ec38e2b9173..83d3818fc60b 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -4692,6 +4692,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>>    	 */
>>>    	nvme_mpath_clear_ctrl_paths(ctrl);
>>> +	/* unquiesce io queues so scan work won't hang */
>>> +	nvme_unquiesce_io_queues(ctrl);
>>
>> What guarantees that the queues won't be quiesced right after this
>> by the transport?
> 
> Please see nvme_change_ctrl_state(), if controller state is in
> DELETING, new NVME_CTRL_RESETTING/NVME_CTRL_CONNECTING can be entered
> any more.

Yes, this relies on the fact that nvme_remove_namespaces is only called
after DELETING state was set. ok.

>> I'm still unclear why this affects the scan_work?
> 
> As Chunguang mentioned, if error recover is terminated by nvme deletion,
> the controller can be kept in quiesced state, then in-queue IOs can'tu
> move on, meantime new error recovery can't be started successfully because
> controller state is NVME_CTRL_DELETING, so any pending IOs(include those
> from scan context) can't be completed.

Yes. please separate to individual patches when submitting though.

