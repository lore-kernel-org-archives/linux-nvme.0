Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D393C4345F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89UW0LEiqOrRtm39YIC+hSBpSZaceU39QpUCZlMrywg=; b=N4a23Vrus5cMTna6Xxp9AnccTt
	XB7cPesJqwxkLtvhS/qPX2OZh1Pvcztj01zZa1ng1ryYmYRgL/oTgbQWCmpJX+FvbyOlhDhyZsLpN
	W/P5om3rVLW9ryxGU+60B06J6XU9kVBArz2SrthjZ+HVi3YJVNjQiZBHaTM7IVDyypiO/5vBrArkj
	MnVMm6HSNujvAYhMWwz/fykkRb1PGBqFpuxyr81sDaTdW8S2ZAFE/v2uwldsVVnc1gNJxAdCuN8TW
	nNz98D+lzwLENQxusRvfzwDVwQ3H0k8daismfgWMMXoeoNdStnhtyamAbkRhyPyH9oQ2KI+syryTv
	6qHtRFHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2qgA-0000000GAdZ-3YnR;
	Fri, 03 May 2024 11:02:14 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2qg7-0000000GAYY-2x5O
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 11:02:13 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34aa836b948so1525085f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 03 May 2024 04:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714734114; x=1715338914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89UW0LEiqOrRtm39YIC+hSBpSZaceU39QpUCZlMrywg=;
        b=ATwTVjDpnvRlPBtWeLV+O0MGhJTh2gePreNLwo5usT2d5QT9JrqJNGN2qyQkxtyJj+
         dBjaDP0z01557TPFLMMRY7uoGNmRGSinYvJsKkOmIV5+5Cbabc+YAjrefS5w6P/sMfDX
         RSjYiRsmbjv7Q/Wso5Gfx8ZO2qZmMyaZF7jCx7O4FLJ7dtuxZc6y+L5JcCdC+TYNx3JK
         RVyDP4ZiYOjIbdmV2zv2ODFfDf488SF0m3t9yLVasMLi6lAT0v4kWUYdf7L40YpfZD1l
         TW3wBwDLoCOG82swizhB+9JAxlVerg2Ycc8SIPQCOzrQ7gs5SnML8dnmrqG23yEwjiJx
         /4FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQsUX4M5iHLE5+UzzweKuMOpEFoY49AczzIWtri/nems/LqyCfOCsAomEmBJzkkqQE6kguW3VzSOKCEPtFRxcqnSxgd881+3ym/TkGwts=
X-Gm-Message-State: AOJu0YzIsgAFLenwGLignA7xsgnGvjTbfO4Q5T97rI2gur3nbiEws+oc
	ynn1C1rkWooJVsMrxAQmwCnaIHi2fOaKrQ+4ISNgjw5B06NpGrca03uzJA==
X-Google-Smtp-Source: AGHT+IEnzMVDTe/0XRR9EflEHNQL2TkOUF8lvtNAK29TgGWI7uy1QpzJY/8vxIQd8HIWp+j5T0TmMg==
X-Received: by 2002:a05:600c:510b:b0:418:2719:6b14 with SMTP id o11-20020a05600c510b00b0041827196b14mr1635941wms.3.1714734113874;
        Fri, 03 May 2024 04:01:53 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0041be9cb540esm5198403wmo.18.2024.05.03.04.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 04:01:53 -0700 (PDT)
Message-ID: <1ceb71ce-c4fb-419a-8800-8ebbbe1706fe@grimberg.me>
Date: Fri, 3 May 2024 14:01:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Yi Zhang <yi.zhang@redhat.com>, Damien Le Moal <dlemoal@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com>
 <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
 <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
 <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
 <e229f273-e3ec-489c-bf89-0f985212c415@grimberg.me>
 <76c17ab2-b3a2-491c-a6b3-7bd39d6d5229@wdc.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <76c17ab2-b3a2-491c-a6b3-7bd39d6d5229@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_040211_863478_41311E16 
X-CRM114-Status: GOOD (  22.38  )
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



On 03/05/2024 13:32, Johannes Thumshirn wrote:
> On 03.05.24 09:59, Sagi Grimberg wrote:
>>
>> On 4/30/24 17:17, Yi Zhang wrote:
>>> On Tue, Apr 30, 2024 at 2:17 PM Johannes Thumshirn
>>> <Johannes.Thumshirn@wdc.com> wrote:
>>>> On 30.04.24 00:18, Chaitanya Kulkarni wrote:
>>>>> On 4/29/24 07:35, Johannes Thumshirn wrote:
>>>>>> On 23.04.24 15:18, Yi Zhang wrote:
>>>>>>> Hi
>>>>>>> I found this issue on the latest linux-block/for-next by blktests
>>>>>>> nvme/tcp nvme/012, please help check it and let me know if you need
>>>>>>> any info/testing for it, thanks.
>>>>>>>
>>>>>>> [ 1873.394323] run blktests nvme/012 at 2024-04-23 04:13:47
>>>>>>> [ 1873.761900] loop0: detected capacity change from 0 to 2097152
>>>>>>> [ 1873.846926] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>>>>> [ 1873.987806] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>>>>>> [ 1874.208883] nvmet: creating nvm controller 1 for subsystem
>>>>>>> blktests-subsystem-1 for NQN
>>>>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>>>>>>> [ 1874.243423] nvme nvme0: creating 48 I/O queues.
>>>>>>> [ 1874.362383] nvme nvme0: mapped 48/0/0 default/read/poll queues.
>>>>>>> [ 1874.517677] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
>>>>>>> 127.0.0.1:4420, hostnqn:
>>>>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
>>>>> [...]
>>>>>
>>>>>>> [  326.827260] run blktests nvme/012 at 2024-04-29 16:28:31
>>>>>>> [  327.475957] loop0: detected capacity change from 0 to 2097152
>>>>>>> [  327.538987] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>>>>>
>>>>>>> [  327.603405] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>>>>>>
>>>>>>>
>>>>>>> [  327.872343] nvmet: creating nvm controller 1 for subsystem
>>>>>>> blktests-subsystem-1 for NQN
>>>>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>>>>>>>
>>>>>>> [  327.877120] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for full
>>>>>>> support of multi-port devices.
>>>>> seems like you don't have multipath enabled that is one difference
>>>>> I can see in above log posted by Yi, and your log.
>>>> Yup, but even with multipath enabled I can't get the bug to trigger :(
>>> It's not one 100% reproduced issue, I tried on my another server and
>>> it cannot be reproduced.
>> Looking at the trace, I think I can see the issue here. In the test
>> case, nvme-mpath fails
>> the request upon submission as the queue is not live, and because it is
>> a mpath request, it
>> is failed over using nvme_failover_request, which steals the bios from
>> the request to its private
>> requeue list.
>>
>> The bisected patch, introduces req->bio dereference to a flush request
>> that has no bios (stolen
>> by the failover sequence). The reproduction seems to be related to in
>> where in the flush sequence
>> the request completion is called.
>>
>> I am unsure if simply making the dereference is the correct fix or
>> not... Damien?
>> --
>> diff --git a/block/blk-flush.c b/block/blk-flush.c
>> index 2f58ae018464..c17cf8ed8113 100644
>> --- a/block/blk-flush.c
>> +++ b/block/blk-flush.c
>> @@ -130,7 +130,8 @@ static void blk_flush_restore_request(struct request
>> *rq)
>>             * original @rq->bio.  Restore it.
>>             */
>>            rq->bio = rq->biotail;
>> -       rq->__sector = rq->bio->bi_iter.bi_sector;
>> +       if (rq->bio)
>> +               rq->__sector = rq->bio->bi_iter.bi_sector;
>>
>>            /* make @rq a normal request */
>>            rq->rq_flags &= ~RQF_FLUSH_SEQ;
>> --
>>
>
> This is something Damien added to his patch series. I just wonder, why I
> couldn't reproduce the failure, even with nvme-mpath enabled. I tried
> both nvme-tcp as well as nvme-loop without any problems.

Not exactly sure.

 From what I see blk_flush_complete_seq() will only call 
blk_flush_restore_request() and
panic is for error != 0. And if that is the case, any request with its 
bios stolen must panic.

However, nvme-mpath always ends a stolen request with error = 0.

Seems that there is code that may override the request error status in 
flush_end_io() but I cannot
see it in the trace...

