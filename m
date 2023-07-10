Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D705EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NaviOKLTn2blgU+6cUhgwatih1ZoAhlK7lv0WCQI7QA=; b=jkFrKLJ8dly6IJLID726Pcq/0T
	DC6Oh3c8y8gHHTji9hg92F2jeReN9nDmt9ObOKF7dYaQ6fXj6zWfnJNtusRhNPS+aYhuGyIWpstAS
	iPI3ouUhmaXT0j3Bu5rjQX5WP/XUBlIbI1L5lCrxF3sWgwXB1xc00xJcFCI0iC/nzWOOtOph5gxvV
	h3JdlBEK8BbPMldLF0AZ6TSKnpPpzeYIyuI4KLn3EXcBRdqZku6sqJtUEYvRnPPRfQEHP7gFj0GCv
	zyAuJdnD5uT5dnzoFQMMIlh3mQfnFEKQtFy3kpjuXHG5moWvSK/IdzRXykhyOv9KgrJSGRasOihfJ
	jQ9nI1jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIpV3-00BWxl-29;
	Mon, 10 Jul 2023 11:56:17 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIpUz-00BWx4-0k
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 11:56:15 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3159adb7cb5so231166f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 04:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688990170; x=1691582170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaviOKLTn2blgU+6cUhgwatih1ZoAhlK7lv0WCQI7QA=;
        b=QQXlYjqH3SIjPH1tHGeqNiBsaC68Wk79h/TBrqexWM+ocuA3kGDle3uAm50c4Ooi3e
         JBENSytvqk3ayiprEfOkCVoeMT4ZFUBXcxIcd6buZCCFSKpxTjNESNgbq5lmq121+c1p
         RSFVq0HFLKJi8stRwf33OaXzt9jJwUhP3WgrMzKwFL3AVc/NkENteMK3wWnBnSQ5/9sQ
         n4jNkcKoTbylY52PhXxtMjFprKi40m9aJ3htbK9zYNVkqBqOiQXtOHxV5Qp2Z9xImTEt
         sQjiqJcEkW+KRK1RRj0HJH2dk62Zg6aRMjlmy1j9chdJVQ8B4SFAVlvCnQL7qRCZobkN
         OFBg==
X-Gm-Message-State: ABy/qLZ5KHEpJQ8JwSgGNbtvcxi1HwFv8bXcRzCgEDQ9mEZfp2DXZwvb
	Wio7n49AwAyCGKBOPB024Vc=
X-Google-Smtp-Source: APBJJlH5SfqSvMBJaUirxoiGP2qklp/NKBwD6DOm8pZjnyRfcUqkzO1ifrpmukALoFFMU6IAhiCSuw==
X-Received: by 2002:adf:f952:0:b0:2c7:1c72:699f with SMTP id q18-20020adff952000000b002c71c72699fmr11001276wrr.4.1688990170071;
        Mon, 10 Jul 2023 04:56:10 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d6acf000000b00314326c91e2sm11546313wrw.28.2023.07.10.04.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 04:56:09 -0700 (PDT)
Message-ID: <725f5e57-7900-3836-6232-ce862ae9971e@grimberg.me>
Date: Mon, 10 Jul 2023 14:56:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
 Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
 <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
 <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
 <8dba03f7-2421-e86b-bc94-ff031c153110@grimberg.me>
 <ZKvUgDbdCdScx0e7@ovpn-8-33.pek2.redhat.com>
 <61fcbded-dbed-bd04-4b96-b3326265eb43@grimberg.me>
 <ZKvsGuYrf+tJTy41@ovpn-8-33.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKvsGuYrf+tJTy41@ovpn-8-33.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_045613_276711_6EF2CC20 
X-CRM114-Status: GOOD (  37.23  )
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



On 7/10/23 14:31, Ming Lei wrote:
> On Mon, Jul 10, 2023 at 02:01:18PM +0300, Sagi Grimberg wrote:
>>
>>
>> On 7/10/23 12:50, Ming Lei wrote:
>>> On Mon, Jul 10, 2023 at 12:27:31PM +0300, Sagi Grimberg wrote:
>>>>
>>>>>>>>> I still want your patches for tcp/rdma that move the freeze.
>>>>>>>>> If you are not planning to send them, I swear I will :)
>>>>>>>>
>>>>>>>> Ming, can you please send the tcp/rdma patches that move the
>>>>>>>> freeze? As I said before, it addresses an existing issue with
>>>>>>>> requests unnecessarily blocked on a frozen queue instead of
>>>>>>>> failing over.
>>>>>>>
>>>>>>> Any chance to fix the current issue in one easy(backportable) way[1] first?
>>>>>>
>>>>>> There is, you suggested one. And I'm requesting you to send a patch for
>>>>>> it.
>>>>>
>>>>> The patch is the one pointed by link [1], and it still can be applied on current
>>>>> linus tree.
>>>>>
>>>>> https://lore.kernel.org/linux-nvme/20230629064818.2070586-1-ming.lei@redhat.com/
>>>>
>>>> This is separate from what I am talking about.
>>>>
>>>>>>> All previous discussions on delay freeze[2] are generic, which apply on all
>>>>>>> nvme drivers, not mention this error handling difference causes extra maintain
>>>>>>> burden. I still suggest to convert all drivers in same way, and will work
>>>>>>> along the approach[1] aiming for v6.6.
>>>>>>
>>>>>> But we obviously hit a difference in expectations from different
>>>>>> drivers. In tcp/rdma there is currently an _existing_ bug, where
>>>>>> we freeze the queue on error recovery, and unfreeze only after we
>>>>>> reconnect. In the meantime, requests can be blocked on the frozen
>>>>>> request queue and not failover like they should.
>>>>>>
>>>>>> In fabrics the delta between error recovery and reconnect can (and
>>>>>> often will be) minutes or more. Hence I request that we solve _this_
>>>>>> issue which is addressed by moving the freeze to the reconnect path.
>>>>>>
>>>>>> I personally think that pci should do this as well, and at least
>>>>>> dual-ported multipath pci devices would prefer instant failover
>>>>>> than after a full reset cycle. But Keith disagrees and I am not going to
>>>>>> push for it.
>>>>>>
>>>>>> Regardless of anything we do in pci, the tcp/rdma transport
>>>>>> freeze-blocking-failover _must_ be addressed.
>>>>>
>>>>> It is one generic issue, freeze/unfreeze has to be paired strictly
>>>>> for every driver.
>>>>>
>>>>> For any nvme driver, the inbalance can happen when error handling
>>>>> is involved, that is why I suggest to fix the issue in one generic
>>>>> way.
>>>>
>>>> Ming, you are ignoring what I'm saying. I don't care if the
>>>> freeze/unfreeze is 100% balanced or not (for the sake of this
>>>> discussion).
>>>>
>>>> I'm talking about a _separate_ issue where a queue
>>>> is frozen for potentially many minutes blocking requests that
>>>> could otherwise failover.
>>>>
>>>>>> So can you please submit a patch for each? Please phrase it as what
>>>>>> it is, a bug fix, so stable kernels can pick it up. And try to keep
>>>>>> it isolated to _only_ the freeze change so that it is easily
>>>>>> backportable.
>>>>>
>>>>> The patch of "[PATCH V2] nvme: mark ctrl as DEAD if removing from error
>>>>> recovery" can fix them all(include nvme tcp/fc's issue), and can be backported.
>>>>
>>>> Ming, this is completely separate from what I'm talking about. This one
>>>> is addressing when the controller is removed, while I'm talking about
>>>> the error-recovery and failover, which is ages before the controller is
>>>> removed.
>>>>
>>>>> But as we discussed, we still want to call freeze/unfreeze in pair, and
>>>>> I also suggest the following approach[2], which isn't good to backport:
>>>>>
>>>>> 	1) moving freeze into reset
>>>>> 	
>>>>> 	2) during resetting
>>>>> 	
>>>>> 	- freeze NS queues
>>>>> 	- unquiesce NS queues
>>>>> 	- nvme_wait_freeze()
>>>>> 	- update_nr_hw_queues
>>>>> 	- unfreeze NS queues
>>>>> 	
>>>>> 	3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,
>>>>> 	
>>>>> 	- if the request is FS IO with data, re-submit all bios of this request, and free the request
>>>>> 	
>>>>> 	- otherwise, fail the request
>>>>>
>>>>>
>>>>> [2] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc
>>>>
>>>> Ming, please read again what my concern is. I'm talking about error recovery
>>>> freezing a queue, and unfreezing only after we reconnect,
>>>> blocking requests that should failover.
>>>
>>>   From my understanding, nothing is special for tcp/rdma compared with
>>> nvme-pci.
>>
>> But there is... The expectations are different.
>>
>>> All take two stage error recovery: teardown & [reset(nvme-pci) | reconnect(tcp/rdma)]
>>>
>>> Queues are frozen during teardown, and unfreeze in reset or reconnect.
>>>
>>> If the 2nd stage is failed or bypassed, queues could be left as frozen
>>> & unquisced, and requests can't be handled, and io hang.
>>>
>>> When tcp reconnect failed, nvme_delete_ctrl() is called for failing
>>> requests & removing controller.
>>>
>>> Then the patch of "nvme: mark ctrl as DEAD if removing from error recovery"
>>> can avoid this issue by calling blk_mark_disk_dead() which can fail any
>>> request pending in bio_queue_enter().
>>>
>>> If that isn't tcp/rdma's issue, can you explain it in details?
>>
>> Yes I can. The expectation in pci is that a reset lifetime will be a few
>> seconds. By lifetime I mean it starts and either succeeds or fails.
>>
>> in fabrics the lifetime is many minutes. i.e. it starts when error
>> recovery kicks in, and either succeeds (reconnected) or fails (deleted
>> due to ctrl_loss_tmo). This can take a long period of time (if for
>> example the controller is down for maintenance/reboot).
>>
>> Hence, while it may be acceptable that requests are blocked on
>> a frozen queue for the duration of a reset in pci, it is _not_
>> acceptable in fabrics. I/O should failover far sooner than that
>> and must _not_ be dependent on the success/failure or the reset.
>>
>> Hence I requested that this is addressed specifically for fabrics
>> (tcp/rdma).
> 
> OK, I got your idea now, but which is basically not doable from current
> nvme error recovery approach.
> 
> Even though starting freeze is moved to reconnect stage, queue is still
> quiesced, then request is kept in block layer's internal queue, and can't
> enter nvme fabric .queue_rq().

See error-recovery in nvme_[tcp|rdma]_error_recovery(), the queue is
unquiesced for fast-failover.

> The patch you are pushing can't work for this requirement, also I don't
> think you need that, because FS IO is actually queued to nvme mpath queue,
> which won't be frozen at all.

But it will enter the ns request queue, and will block there. There is a
window where a *few* stray requests enter the ns request queue before
the current path is reset, those are the ones that will not failover
immediately (because they are blocked on a frozen queue).

> However, you can improve nvme_ns_head_submit_bio() by selecting new path
> if the underlying queue is in error recovery. Not dig into the current
> code yet, I think it should have been done in this way already.

That is fine, and it happens to new requests already. The nvme-mpath
failover is not broken obviously. I am only talking about the few
requests that entered the ns queue when it was frozen and before the
nshead current_path was changed.

For those requests, we should fast failover as well, and we don't today.

