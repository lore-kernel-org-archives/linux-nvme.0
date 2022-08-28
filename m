Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCFEECAAD2
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 12:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4F4SlN2ubDUUfrP2jDYcHrqz3BYSEFszdPCIylJqtdc=; b=z65vyEFcCCuZ5XAu4/yYhyijy9
	8fs/MnbckJrQOh99XjXee++TmkEACJfbQxl4/TjLoBhyYfv2Yo99/2oJ/AKU+BCKs4k+NQg5IItr2
	bNaRvRjQom2OnU1AO0iwt6EXob1/06VgXayYcQyc5avw5VLwVOlAAaju3MoCLcOK0RjLrN6LAV209
	JLAKkYXRq6YstrfY7Qzd+nqdq9Y6iHyZKSoSfQkzTZEyUkXSts2MEbug3j60XYWYJI0wn1hvTtKt+
	nroSO5CgkAYP3kdfzs+LhybNT01vRY0WMs+XmGdaVPZIINGdN7i+pmcrR72lUeymAD8BZKkzCljyI
	5tqaiwgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSHIi-00GjgO-8i; Sun, 28 Aug 2022 12:22:04 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSHIg-00GjfI-5i
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 12:22:03 +0000
Received: by mail-wm1-f49.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so3092965wms.5
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 05:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4F4SlN2ubDUUfrP2jDYcHrqz3BYSEFszdPCIylJqtdc=;
        b=Ye1kCUQb8BZpJKr6GtympIL+qxe9Q50sFHwNCbYMXY9El/G6F2fWFHx4HwNxMROFJo
         bsMj1JDxqWMPrYxIDRxdErAH597yQz3/ETUa7WE4ROYQnl30+lNmDr3ODyNW0/q+TbSh
         rVniCyDduWAa4eN+ewFOlMJTQKmTCfo/geFY0ac33BSAr8Y3v4KBYRvAncXWicG4G8NW
         ICblp/wD12v0BCQ7wy2mqyWfworYKi8BljfdztiCP1PC2XSe8ESW0xtzFPX0e9+gCEEf
         ixDUN1G11RwZwCNL/MproKWPhQ9JYcy7kFDST5wjc0+0OCCI/WQnz/N9DeQPlA4FLYEa
         gpWQ==
X-Gm-Message-State: ACgBeo3jD1FpXUyPl6ndci9KTFe15Yzoh4bOQINu6iC74AUr/f2BSi+H
	lt3Hp6KBECboZqecXbjmIDjPhqorCyYA7Q==
X-Google-Smtp-Source: AA6agR5ojkjd4rNUi30s3Ac3xlB6/LyGe2TgbBR0BbE5d9aGOtwIgJFiD4PY4YKuo5KXcOBfdUKPjg==
X-Received: by 2002:a05:600c:22d2:b0:3a8:3e8c:d914 with SMTP id 18-20020a05600c22d200b003a83e8cd914mr2976267wmg.128.1661689318815;
        Sun, 28 Aug 2022 05:21:58 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f24-20020a1c6a18000000b003a541d893desm5637308wmc.38.2022.08.28.05.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 05:21:17 -0700 (PDT)
Message-ID: <15f9917a-2629-8bbf-501e-56378315a1ea@grimberg.me>
Date: Sun, 28 Aug 2022 15:20:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] nvme-rdma: Handle number of queue changes
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-4-dwagner@suse.de>
 <17886a4c-8443-19a1-c2fa-d7ea0f2e5a1f@huawei.com>
 <20220825105550.3hxjveuex4nmup54@carbon.lan>
 <a232a477-b2a3-af6e-58fd-265d8f10bb25@huawei.com>
 <20220826063024.tndzjp7j6xhx3234@carbon.lan>
 <e9caacd6-033a-3f93-e9d5-2ad80fa07cfe@huawei.com>
 <20220826113341.nac4rgu3goa4enfq@carbon.lan>
 <f7b6548b-8277-a52b-43c1-989b40b0a99b@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f7b6548b-8277-a52b-43c1-989b40b0a99b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_052202_235439_F806775C 
X-CRM114-Status: GOOD (  16.63  )
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


>> On Fri, Aug 26, 2022 at 03:31:15PM +0800, Chao Leng wrote:
>>>> After seeing both version I tend to do say the first one keeps the
>>>> 'wierd' stuff more closer together and doesn't make the callside of
>>>> nvme_rdma_start_io_queues() do the counting. So my personal preference
>>> I don't understand "do the counting".
>>
>> Sorry. I meant we fist start only queues for which have resources
>> allocated (nr_queues in my patch). And then we only need to start
>> potentially added queues.
>>
>>> Show the code:
>>> ---
>>>   drivers/nvme/host/rdma.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>> index 7d01fb770284..8dfb79726e13 100644
>>> --- a/drivers/nvme/host/rdma.c
>>> +++ b/drivers/nvme/host/rdma.c
>>> @@ -980,10 +980,6 @@ static int nvme_rdma_configure_io_queues(struct 
>>> nvme_rdma_ctrl *ctrl, bool new)
>>>                          goto out_free_tag_set;
>>>          }
>>>
>>> -       ret = nvme_rdma_start_io_queues(ctrl);
>>> -       if (ret)
>>> -               goto out_cleanup_connect_q;
>>
>> Again, these need to start so that...
>>
>>> -
>>>          if (!new) {
>>>                  nvme_start_queues(&ctrl->ctrl);
>>>                  if (!nvme_wait_freeze_timeout(&ctrl->ctrl,
>>
>> ... this here has a chance to work.
> Some request will be submited, and will failed, and then retry
> or failover. It is similar to nvme_cancel_tagset in 
> nvme_rdma_teardown_io_queues.
> I think it is acceptable.

Not really...

In order for the queue freeze to complete, all pending IOs need
to complete or error out, and that cannot be guaranteed without
restarting the queues as some may be waiting on tags and need to
be restarted in order to complete.

See 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")

