Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3DAECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Sep 2022 15:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8Iy9Gm/jl/NxM9F48cwVHvF+X1h18O5qWNNBqHcUMw=; b=etHS/B+0pE+2cfroVzAzIs/i9e
	Y05SgIsIPWggWaLbH+Ow7Iu6q/F71E6COAn72hYPUkUnkoRKPFIYnXPtgW2nUTNMhOA9TcDoGpZwj
	DsMr8sPNUBLMBzkob62RUavJpxMYJu/MJ9wXCKuyHdGgtFG88ARk3ASNKv+bPL8Yln5KP5CV25EK6
	8+4shDYd06LHV+bQeThKVEzTDmdW8wr/dD9df6+qIXsY4YEdl4X4aLiEy9wiRd0Z9NUfL3+0GGSKw
	sy21+RjIY9YCf0cgbqajcUK0aWomm3/J0HZKLcKADjdzVsyG8DFGzI+svHr4lDDbsN5CitDlaBc5G
	df9bSyjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYTsS-003526-Rb; Wed, 14 Sep 2022 15:00:36 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYTsN-0034e4-HU
	for linux-nvme@lists.infradead.org; Wed, 14 Sep 2022 15:00:32 +0000
Received: by mail-pj1-x1035.google.com with SMTP id fs14so14843517pjb.5
        for <linux-nvme@lists.infradead.org>; Wed, 14 Sep 2022 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=M8Iy9Gm/jl/NxM9F48cwVHvF+X1h18O5qWNNBqHcUMw=;
        b=RHOf73rlNtY0roxjkXbcHt5DSY/MmQZK4TMQ9s5VjtRizHAT2cDA0Ch5VOh5vGj+o8
         Xcmwb258BKpMrlVkR+YCttwredWs2KHpa5binqZstuZcAzkuliLk9OB7VmI5O/UbRfRm
         jaTs0rgs9Tdl1dvZTZ5R3wteE+GyB6deqaiOgH7bacmE50POV6FlAb1BOQwcqY9mFFNL
         AHPWCHr9HZxEgSmmmuYsl3vzdFPDjEy3E5Kwwpa5+V8/sU3fJJKQ8SRPC1KttVGeIRUK
         2LErjhdxmuy9kzaPyfUDADYIVQNcen3zz0LPjzUZ8ZINvxPDqZSU2tjxYirF2Jhn45nB
         tQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=M8Iy9Gm/jl/NxM9F48cwVHvF+X1h18O5qWNNBqHcUMw=;
        b=5LLgzsBo6jvZvTLxFSW8iBg0wOys1skxeqEdg8j4jI20E3wuJlFdqVUyu9EE6jYJCi
         6yTAkgEwNSknKFEWdi+wRVdj0YofqV3Z7RdN7iMlKwvX26Hg2z4zzV3P/7zDY7mMpeg6
         eqalQKE3+wjkBzwmpd/k+Noc3p0L+dyuIzJeGYH6c+dsVcnpRmNJymzCh+zfx9gKHdZV
         cp0dRMBFAWWDUVMZrVkeAyF3iAlD2V3xmEDltPeFbcKcZaVpbnDVw9/+uDUavNb9bd8L
         2oxozxiIKfLrjgTsAu/ES/2bUuktprQaXzK/xaYCebD5bwEp7ptC5L2ukWkC75PK9WL+
         xvbQ==
X-Gm-Message-State: ACgBeo1+C7zHcsrpxNdn0xperFmfENGXo30b4qNMKfM9jh5MNdkol5vI
	PG3K1lmKPQBCKMItSmMFNUVfDaXubHA=
X-Google-Smtp-Source: AA6agR6xZyPpatuDyNd+er8jwGLhtNcSwBMa8O1GOqrGJOoABO0GQUKBMpzPUC/kf9lVbZOvzTZZ6A==
X-Received: by 2002:a17:902:f64d:b0:172:d004:8b2d with SMTP id m13-20020a170902f64d00b00172d0048b2dmr37355696plg.14.1663167627444;
        Wed, 14 Sep 2022 08:00:27 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id ik22-20020a170902ab1600b0016dc26c7d30sm5673102plb.164.2022.09.14.08.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 08:00:27 -0700 (PDT)
Message-ID: <73b6631a-1ec5-5a46-8f2a-f816acdeb97d@gmail.com>
Date: Wed, 14 Sep 2022 08:00:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH rfc 0/1] Fix missing AENs when discovery controllers are
 disconnected
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <9eb798de-149d-a56d-ac00-dd6b7ae79a81@gmail.com>
 <403e19c8-fec9-2d5c-157c-cdcb4fc2fbf0@grimberg.me>
 <27194422-3759-928e-c88e-c5d10feeba5b@gmail.com>
 <bf83b747-e6b5-57fb-0de7-e2fb646633aa@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <bf83b747-e6b5-57fb-0de7-e2fb646633aa@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_080031_623938_C1A06C96 
X-CRM114-Status: GOOD (  22.80  )
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

On 9/14/2022 3:29 AM, Sagi Grimberg wrote:
> 
>> I was thinking this rather than the new option... The bit would only 
>> be set *after* the first successful link-side connect, thus the 
>> initial nvme_start_ctrl would not send the reconnect event. Every 
>> reconnect thereafter would.
>>
>> -- james
>>
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 2429b11eb9a8..43c8b6590164 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4814,6 +4814,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>>
>>       nvme_enable_aen(ctrl);
>>
>> +    if (nvme_discovery_ctrl(ctrl) &&
>> +        test_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->flags))
>> +        nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
>> +
>>       if (ctrl->queue_count > 1) {
>>           nvme_queue_scan(ctrl);
>>           nvme_start_queues(ctrl);
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 127abaf9ba5d..ff1dd8f999b0 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -2947,6 +2947,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>>           goto out_delete_hw_queues;
>>
>>       ctrl->ioq_live = true;
>> +    set_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->ctrl.flags);
> 
> Isn't this set before calling nvme_start_ctrl()?

frick - sent the wrong tweak for fc:

this should be:
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 127abaf9ba5d..630d8e50f29c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3201,6 +3201,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
         if (changed)
                 nvme_start_ctrl(&ctrl->ctrl);

+       set_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->ctrl.flags);
+
         return 0;       /* Success */

  out_term_aen_ops:


So in all cases, it's now set immediately after calling nvme_start_ctrl. 
Won't be set on 1st call but will be all on all reamaing.


> 
> But this is orthogonal to the user argument, is there a specific
> reason to why not add an explicit argument requesting that?
> Because every userspace that will setup a persistent discovery
> controller will need this event?

Well my aversion is to remove relationships between user-space and 
kernel.  It seemed very odd to go to user-space to then set a custom 
option and this handshaking looked like a lot of work vs just generating 
a reconnect event on a discovery controller.

In my mind think we should be doing one of the following:
a) generate connect and reconnect events generically. If they are 
handled, great, if not that's fine. Handler is free to filter by device 
attributes as to what it does

I assume there's some issue here that you saw with the original attempt 
as reconnects may post while connects or reconnects are still being handled.

b) go down the path of the rediscover option - but the kernel routine 
should never require it to be a discovery controller. If the option is 
set, send the rediscover event. Removes events that won't be handled.
The filtering in the lib to only set the option on devices that the lib 
cares about can continue.

-- james

