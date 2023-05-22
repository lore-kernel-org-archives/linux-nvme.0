Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F80DC77B73
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 06:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9bORhIPxlevSjW0lSGP0F+W/7JWHFgtBzxocvU+GB74=; b=ZziXeAP8IFRAj9CGVQYmK4i3Dw
	aO+0U8XTmMj807WxWI9lvYR4NlxGpbbBamrAOfFe2IOpOqP5+xbLIPH/fU8fb4QFY0x7RX+auaMAr
	idY7lXikaA7dVJ8r1j7LN6SJ0Qmw+AH+YnNyG67OUrm6OcGN1/9dP57eUlH/7PyI3p6fVTzFa3wkh
	bXBjgDmUQ3MHFa76HqDj+utDJ5A8wqtBCwifbAWJDIH+1iqiLphSjqZS+5WLIycYO4SrR8+X8WtsC
	xgcvsO+tcPvaAWavyH4/pZ0nwL57sKrOAgm41zqFLNgmyEyaOO0Kmyjq0hpTbizia+DL2d+lTsnAx
	K+UJkB3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0zEQ-005WmE-0T;
	Mon, 22 May 2023 06:41:22 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0zEN-005Wlh-32
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 06:41:21 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-30913073ec6so189613f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 May 2023 23:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737676; x=1687329676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bORhIPxlevSjW0lSGP0F+W/7JWHFgtBzxocvU+GB74=;
        b=BFyNktWDdk+OiuRpJDLWFMR2u5SdVcvsVJvAU+CXr7yN5hxTtG92ryVHWdNIeolU7+
         6ZTpHBCIoSO3rngBJ4NHfvTWCXdnM+ZBfllH/1Psoo14BGN2LD70nrt1OeCe3n8XOvr5
         7CVe7XZ7nDfy+o85XjJkctzRQtHIuWwS+x3tASp/gT18MHXIa8j+/Og0LoKwQXmKAvDk
         N0HPWNfDQx55LOg1sA/rRADvMnTFcs6tBNfzQm3gyGcCoiDbWoN85yoFMZ3Xzqm8fAex
         F5RLUIScU0gSCtBSBHxir2oUjc+AV+PM8e1z2EdUT2ooOc2zQfE6CGseJEN9y9wn+2Ns
         +Ufw==
X-Gm-Message-State: AC+VfDw+eH/67Kf3JJD8VY2d3N6vENrTkkjrCrTt8CeMbrIoqA3CzyVR
	dOzEZ5H5vQy/MyZqu5ypEl0=
X-Google-Smtp-Source: ACHHUZ7UJsfhY30fDow9q5BSBdtfy69t2vg4cJxSGfJIG3vBm9wG//hiq/6YNzNpQR/FxgYqq2ap1A==
X-Received: by 2002:adf:e70d:0:b0:307:cf5e:28a9 with SMTP id c13-20020adfe70d000000b00307cf5e28a9mr5468000wrm.5.1684737675735;
        Sun, 21 May 2023 23:41:15 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d4243000000b002cea9d931e6sm6583256wrr.78.2023.05.21.23.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 23:41:15 -0700 (PDT)
Message-ID: <11382811-caa7-c64c-5fe5-659fc5722c44@grimberg.me>
Date: Mon, 22 May 2023 09:41:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvmet-rdma: Release connections synchronously
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230511150321.103172-1-bvanassche@acm.org>
 <f2909fb6-26e4-f99f-c55b-1dcec577bb44@grimberg.me>
 <82c223c5-d6ba-d862-2d6e-31fbd3daa77d@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <82c223c5-d6ba-d862-2d6e-31fbd3daa77d@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230521_234119_999680_32CF986D 
X-CRM114-Status: GOOD (  15.05  )
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


>>> @@ -1582,11 +1566,6 @@ static int nvmet_rdma_queue_connect(struct 
>>> rdma_cm_id *cm_id,
>>>           goto put_device;
>>>       }
>>> -    if (queue->host_qid == 0) {
>>> -        /* Let inflight controller teardown complete */
>>> -        flush_workqueue(nvmet_wq);
>>> -    }
>>> -
>>>       ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
>>>       if (ret) {
>>>           /*
>>
>> You could have simply removed this hunk alone to make lockdep quiet on
>> this, without the need to rework the async queue removal.
>>
>> The flush here was added to prevent a reset/connect/disconnect storm
>> causing the target to run out of resources (which we have seen reports
>> about in the distant past). What prevents it now?
>>
>> And you both reworked the teardown, and still removed the flush, I don't
>> get why both are needed.
> 
> Hi Sagi,
> 
> My understanding is that the above flush_workqueue() call waits for 
> prior release_work to complete. If the release_work instance is removed, 
> I don't think that the above flush_workqueue() call is still necessary.

I'm wandering if making delete_ctrl synchronous may be a problem
in some cases, nvmet_fatal_error can be triggered from the
rdma completion path (rdma core workqueue context). Wondering if there
may be some inter-dependency there...

Also, nvmet-tcp has a similar lockdep complaint, where the teardown goes
via socket shutdown, which has to be async because we cannot release the
socket from the state_change callback.

