Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A80EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/j6txsL1LAa6TqQUQIjj+sTK0ZG/oC531uOufNfwD4=; b=dyuZrT2Yz8Z0PlkPw6HinRWLR1
	kD2tVJKEqiWFx6l5MvBMt++8gJ6Gw2Kd0JSRLMQfpgNwfsNL8/DACtF7L/6GLIEVRNQz21QEzj0JD
	yqGU98AMV1tC7Juk2dh8OYoxXUtBgxxwwQBQZMXGHa3pQbiFOWLmN3heXgnBZoiC2gL8BcLla5mbF
	4hWbfQffoCRd1xsLjTgTWzl22Y0X8efIeuXRIKa8ulMxp0/GYvgdiFRGbO9fRRcO7en7mA0r3j4Ta
	9L++9X87eAjfFHDWmpjSX0kYr5AXrtu5/nQ/5RUBMItYU70ooEuT//GFVf9dDVR5o9CgO/ICuEmCZ
	1SpEByDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJr3k-002HHq-1g;
	Thu, 13 Jul 2023 07:48:20 +0000
Received: from mail-lf1-f42.google.com ([209.85.167.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJr3h-002HH6-1m
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 07:48:19 +0000
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fb7bbbfa95so129984e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jul 2023 00:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689234494; x=1689839294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/j6txsL1LAa6TqQUQIjj+sTK0ZG/oC531uOufNfwD4=;
        b=AVgAJOyGyUAad3ZCcOndZ5tdmF6gMnd7FSvofIuMk8oE6T+KfW9rFn7BmU+8Fq/suD
         av7DI95hgsUyIVX0sIpeb+mvK+2TtkoOr0sLbO+2qcn5wa8+znsxenkUrjSR9AZSJtZF
         FPlvroyqApS3guuXrFChiHsdnMicxZyb+70bVYOJL5gMuHAUSOXnYQjLArQlZpOz74ld
         3pmRiF8oACnzy6cHDFA/AYEddxo5JZpt05f1Dbo2hFnl98Cgfn4mn5iluegOhy5hoqoA
         PwwBRybuG9FUzyuCfFPvKVHGPzHapNndLCG/HkQPBSNxWYQ7I4q+f4aLmKDT89gyxkH9
         VRnw==
X-Gm-Message-State: ABy/qLZD3MG4UkAj8SGWjxccFqJbD3c19ld4/IMHOCfdmQXRYf23T77+
	KyeS0Mc6JGiG3lMYnYF4hjk=
X-Google-Smtp-Source: APBJJlGH1XfNfN6Hk9YPZpTfnIc4LqK5nsPIdkMxQMMseZTRHRkODL5rjNptHgOb5BBKC0kZLzxyZQ==
X-Received: by 2002:a05:651c:1ce:b0:2b6:a662:b879 with SMTP id d14-20020a05651c01ce00b002b6a662b879mr649292ljn.3.1689234494025;
        Thu, 13 Jul 2023 00:48:14 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c281100b003fbca05faa9sm7019740wmb.24.2023.07.13.00.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:48:13 -0700 (PDT)
Message-ID: <152f0684-4bcd-699f-e0e3-40189be4b80a@grimberg.me>
Date: Thu, 13 Jul 2023 10:48:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: blktests failures with v6.4
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <lkmloyrqpebispffur5udxdiubmevvodtsvnap3jz7tv5ihstr@jg7ejye3bein>
 <165eceaa-55d4-f9c7-7e02-18115e6df6fe@grimberg.me>
 <v3n4k4gk5uhbuh6ijl2pwaysvxzidzhrmjejourfnmobebwbzi@hejuqcryp4nc>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <v3n4k4gk5uhbuh6ijl2pwaysvxzidzhrmjejourfnmobebwbzi@hejuqcryp4nc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_004817_592344_B71D0D99 
X-CRM114-Status: GOOD (  21.09  )
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


>>> #3: nvme/003 (fabrics transport)
>>>
>>>      When nvme test group is run with trtype=rdma or tcp, the test case fails
>>>      due to lockdep WARNING "possible circular locking dependency detected".
>>>      Reported in May/2023. Bart suggested a fix for trytpe=rdma [4] but it
>>>      needs more discussion.
>>>
>>>      [4] https://lore.kernel.org/linux-nvme/20230511150321.103172-1-bvanassche@acm.org/
>>
>> This patch is unfortunately incorrect and buggy.
>>
>> This will likely make the issue go away, but adds another
>> old issue where a client can DDOS a target by bombarding it
>> with connect/disconnect. When releases are async and we don't
>> have any back-pressure, it is likely to happen.
>> --
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 4597bca43a6d..8b4f4aa48206 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -1582,11 +1582,6 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id
>> *cm_id,
>>                  goto put_device;
>>          }
>>
>> -       if (queue->host_qid == 0) {
>> -               /* Let inflight controller teardown complete */
>> -               flush_workqueue(nvmet_wq);
>> -       }
>> -
>>          ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
>>          if (ret) {
>>                  /*
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 868aa4de2e4c..c8cfa19e11c7 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1844,11 +1844,6 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq
>> *sq)
>>          struct nvmet_tcp_queue *queue =
>>                  container_of(sq, struct nvmet_tcp_queue, nvme_sq);
>>
>> -       if (sq->qid == 0) {
>> -               /* Let inflight controller teardown complete */
>> -               flush_workqueue(nvmet_wq);
>> -       }
>> -
>>          queue->nr_cmds = sq->size * 2;
>>          if (nvmet_tcp_alloc_cmds(queue))
>>                  return NVME_SC_INTERNAL;
>> --
> 
> Thanks Sagi, I tried the patch above and confirmed the lockdep WARN disappears
> for both rdma and tcp. It indicates that the flush_workqueue(nvmet_wq)
> introduced the circular lock dependency.

Thanks for confirming. This was expected.

> I also found the two commits below
> record why the flush_workqueue(nvmet_wq) was introduced.
> 
>   777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
>   8832cf922151 ("nvmet: use a private workqueue instead of the system workqueue")

The second patch is unrelated, before we used a global workqueue and
fundamentally had the same issue.

> The left question is how to avoid both the connect/disconnect bombarding DDOS
> and the circular lock possibility related to the nvmet_wq completion.

I don't see any way to synchronize connects with releases without moving 
connect sequences to a dedicated thread. Which in my mind is undesirable.

The only solution I can think of is to fail a host connect expecting the
host to reconnect and throttle this way, but that would lead to spurious
connect failures (at least from the host PoV).

Maybe we can add a NOT_READY connect error code in nvme for that...


