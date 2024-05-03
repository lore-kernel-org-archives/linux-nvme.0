Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A14C4345F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzYmbhpRbl8QiRO48tGkM6UvfO30LUVMTm33iagZ46k=; b=uApyLfCPpBXZE5JUy8WeLQKs89
	7KWYQQTJKpuIhl1nvgbeTewievqJHaur6J9sJviZ7oF5Opv9EnEiZw7peS+E9WcfXawcqx5CBggHg
	FP9M7Lf6gQhezrijKvG4PUtJsVReJoPDpwJWL2rMWHaArqTpI7ZHVDi1IDsO4+RgRvkBhV3XZof/x
	gTyV3gnGc94wNFO1PH5EbWrbYCkrM4ThkPfC+/TTedbglIlkNmoEMgTAYsLuvay4UPE88oehayWVy
	6rZriO8aQOmUSKbLUMlCNCRq8jTkfQgnN4NQ2I6MbMBqMr9Ip28iBlNRdu4SJLD93MdBp687UL1yJ
	7lICZcNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2npl-0000000FYiG-3bx5;
	Fri, 03 May 2024 07:59:57 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2npi-0000000FYhZ-1x0J
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 07:59:56 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41c26dcc3ecso6030655e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 03 May 2024 00:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714723192; x=1715327992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzYmbhpRbl8QiRO48tGkM6UvfO30LUVMTm33iagZ46k=;
        b=lUSkALjbmX2mTgNbG4CfJ7LuNmFo5lXRFh4+HnPjFWgd7qKGHwQX+SnohHOR9dz+Ym
         IVD/1BHGYVMqnKZel26NdjY/PgZbvx5kZtfjR1dEojsG3tqvQJAv7r3ycj/mtOH3QzVo
         k1GHPMAtVLgPSkdlRmsYkosgvkiB3Z+htTruAlNCpILlYuXb5KNSg0Vj6FcO7IDIU+2E
         6vgKvtbW6XCMR+Z6ldOzyvIcz4cMXL4lOldujw4V6hxOTwKFW+NPbQVnY030huRF6d0t
         7Va2rvl9m2g1/aEcme67zu7f0hW4RfSZb7Xby8dN9/IfcDcm76RuEIhb/eoZDYIy+QN2
         hgGw==
X-Forwarded-Encrypted: i=1; AJvYcCXrWsYXYzm+YGZQW0DfC+JcO9iDayle4N0BZ9SyqySK9HZDALaq72vML1Kjxvw3EyMgG6S+b6evZbC/NJYn+jYbe907e9B/Be9OBr2x/ao=
X-Gm-Message-State: AOJu0YyE0gaeYAEz68lr5dHHOUlaBaBBDdnAsu18erzeMS50jTtNeEu/
	LDj8FUi+2Z+9YRwZjV8dBH0e2DzdU02Y7vC/uCuo+YBHcVFZr4eB
X-Google-Smtp-Source: AGHT+IEx8ztqNh3d+bvC/lJPjNz2UsSvUo822Jks9MB10ZCj9tUirEjrifZ1NC+7rP/e2rF1SUTyoQ==
X-Received: by 2002:a5d:6586:0:b0:346:7f4d:e80f with SMTP id q6-20020a5d6586000000b003467f4de80fmr1514381wru.1.1714723192514;
        Fri, 03 May 2024 00:59:52 -0700 (PDT)
Received: from [10.100.102.67] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d53ca000000b0034a710b6360sm3141726wrw.6.2024.05.03.00.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:59:52 -0700 (PDT)
Message-ID: <e229f273-e3ec-489c-bf89-0f985212c415@grimberg.me>
Date: Fri, 3 May 2024 10:59:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
To: Yi Zhang <yi.zhang@redhat.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com>
 <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
 <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
 <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_005954_711056_32D0EFC1 
X-CRM114-Status: GOOD (  17.33  )
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



On 4/30/24 17:17, Yi Zhang wrote:
> On Tue, Apr 30, 2024 at 2:17 PM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
>> On 30.04.24 00:18, Chaitanya Kulkarni wrote:
>>> On 4/29/24 07:35, Johannes Thumshirn wrote:
>>>> On 23.04.24 15:18, Yi Zhang wrote:
>>>>> Hi
>>>>> I found this issue on the latest linux-block/for-next by blktests
>>>>> nvme/tcp nvme/012, please help check it and let me know if you need
>>>>> any info/testing for it, thanks.
>>>>>
>>>>> [ 1873.394323] run blktests nvme/012 at 2024-04-23 04:13:47
>>>>> [ 1873.761900] loop0: detected capacity change from 0 to 2097152
>>>>> [ 1873.846926] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>>> [ 1873.987806] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>>>> [ 1874.208883] nvmet: creating nvm controller 1 for subsystem
>>>>> blktests-subsystem-1 for NQN
>>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>>>>> [ 1874.243423] nvme nvme0: creating 48 I/O queues.
>>>>> [ 1874.362383] nvme nvme0: mapped 48/0/0 default/read/poll queues.
>>>>> [ 1874.517677] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
>>>>> 127.0.0.1:4420, hostnqn:
>>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
>>> [...]
>>>
>>>>> [  326.827260] run blktests nvme/012 at 2024-04-29 16:28:31
>>>>> [  327.475957] loop0: detected capacity change from 0 to 2097152
>>>>> [  327.538987] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>>>
>>>>> [  327.603405] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>>>>
>>>>>
>>>>> [  327.872343] nvmet: creating nvm controller 1 for subsystem
>>>>> blktests-subsystem-1 for NQN
>>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>>>>>
>>>>> [  327.877120] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for full
>>>>> support of multi-port devices.
>>> seems like you don't have multipath enabled that is one difference
>>> I can see in above log posted by Yi, and your log.
>>
>> Yup, but even with multipath enabled I can't get the bug to trigger :(
> It's not one 100% reproduced issue, I tried on my another server and
> it cannot be reproduced.

Looking at the trace, I think I can see the issue here. In the test 
case, nvme-mpath fails
the request upon submission as the queue is not live, and because it is 
a mpath request, it
is failed over using nvme_failover_request, which steals the bios from 
the request to its private
requeue list.

The bisected patch, introduces req->bio dereference to a flush request 
that has no bios (stolen
by the failover sequence). The reproduction seems to be related to in 
where in the flush sequence
the request completion is called.

I am unsure if simply making the dereference is the correct fix or 
not... Damien?
--
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 2f58ae018464..c17cf8ed8113 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -130,7 +130,8 @@ static void blk_flush_restore_request(struct request 
*rq)
          * original @rq->bio.  Restore it.
          */
         rq->bio = rq->biotail;
-       rq->__sector = rq->bio->bi_iter.bi_sector;
+       if (rq->bio)
+               rq->__sector = rq->bio->bi_iter.bi_sector;

         /* make @rq a normal request */
         rq->rq_flags &= ~RQF_FLUSH_SEQ;
--

