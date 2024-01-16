Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7AEC3DA79
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 02:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=72zpsGXqszKsLlj+ZxRURo7mQNydz4iCbui6pRDA/GI=; b=L7IbPp9ju7cROOasm9xcHCqkTV
	2DuqZaPDoCEmEsCl4sURJM0VWHXQF2xVFK6jbJyTvT0j9CX3IwhfaoTADwzZLjgzeLEDDMb0nwcuK
	cMS5GkuMzWSjQ68ufbACbfgLmxeEVB4ekr/5higfCIyiF3r/hqigCnE7nXv/7lnAeLlB2y3i1Pywb
	nN9+iW8aecU7o0AFFNQZeHRKm9OLWyMHNVtmHr8MPDfiCXZ0cSeMEMz8PoTSrbGtoh5XVqFXkQhH4
	FOXARKMTiRAYkXiwvUqbnP/Bg6oHK92LV9MO5R2z9jLk4AvWsXMvEouXkivB4LObc7MYsUeQKTGEP
	7rf30ijQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPZCi-00AoEt-2r;
	Tue, 16 Jan 2024 02:29:28 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPZCf-00AoDb-1M
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 02:29:27 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-kK.n1_1705372156;
Received: from 30.178.82.220(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-kK.n1_1705372156)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 10:29:18 +0800
Message-ID: <321a1bdb-0539-4cf4-94e2-9be125c47257@linux.alibaba.com>
Date: Tue, 16 Jan 2024 10:29:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/3] *** Implement the NVMe reservation feature ***
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com,
 chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240114092314.63694-1-kanie@linux.alibaba.com>
 <6a120866-715d-4300-bf3d-4da5ce6a7d8c@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <6a120866-715d-4300-bf3d-4da5ce6a7d8c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_182925_640867_36E20FC2 
X-CRM114-Status: GOOD (  28.54  )
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


在 2024/1/15 17:51, Sagi Grimberg 写道:
>
>
> On 1/14/24 11:23, Guixin Liu wrote:
>> Hi guys,
>>      I've implemented the NVMe reservation feature. Please review it, 
>> all
>> comments are welcome as usual.
>>
>> Changes from v1 to v2:
>> - Implement the reservation notification report, includes registration
>> preempted, reservation released and reservation preempted.
>>    And also handle the reservation log page avaliable event and send get
>> reservation log page command to clear log page at host.
>>
>> - Put the reservation check access after validate opcode. And remove
>> opcodes which nvmet not implement yet check.
>>    Now there is no admin opcode nvmet implemented needs reservation 
>> check,
>> so I dont add reservation check to admin command path.
>>    Next we need to do reservation check includes the situation of 
>> nsid is
>> 0xffffffff at each admin command path, if it is needed.
>>
>> - Add reservation commands support in nvmet_get_cmd_effects_nvm().
>>
>> - From Chaitanya, change the local variable tree style to make it 
>> cleaner,
>> and add some comments about NVMe spec.
>>    And also change others advice from chaitanya.
>>
>> - Put the nvmet_pr_check_cmd_access and nvmet_parse_pr_cmd into 
>> reservation
>> enable check warp.
>>
>> - Remove kmem_cache instead to use kmalloc and kfree.
>>
>> - Change others advice from Sagi.
>>
>> - Add a blktest test case, this patch will be sent before these 
>> series of
>> pathes.
>>
>> Advice I dont adopt:
>> - From Sagi, use rcu instead of rwlock.
>>    I need protect registrant_list, holder, type and generation 
>> simutaneously,
>> the rcu can not protect multiple units.
>
> I don't see how the generation needs the same protection.
> As for the type and holder, perhaps we can find ordering that
> allows us to relax the dereference? Or make it a member of the holder?
>
> All I'm saying is that nvmet_pr_check_cmd_access() is dereferencing
> ns->pr->holder and ns->pr->holder->uuid, so the proposal is to update
> ns->pr->hostder with rcu synchronization such that the IO path will
> simply do:
>
>     rcu_read_lock();
>     if (!rcu_dereference(pr->holder))
>         goto unlock;
>     if (uuid_equal(&ctrl->hostid, &pr->holder->hostid)
>         goto unlock;
>     rtype = pr->rtype; // or pr->holder->rtype ?
>     rcu_read_unlock();
>
> Nothing prevents you from protecting anything else on top of that.
>
>>
>> - From Sagi, use blkdev's pr_ops if it is exist.
>>    The backend is unable to distinguish connections from the 
>> frontend, If we
>> use the pr_ops of the block device, the block device's target would only
>> recognize it as a reservation by the nvme target.
>>    Could you plz give me more information? Sagi?
>
> Umm, won't nvmet register the same key as transferred by the host? Not
> sure either how it should work.

I think the person who manages the nvmet configuration should make sure

that nvmet has exclusive access to the backend disk.

>
> In any event fwiw, if we can make the data path access cheap enough with
> rcu I don't think its a necessary optimization...

OK, I will do a deep thinking about rcu.

Thanks.

Guixin Liu

>
>>
>> - From Keith, use nvmet_get_cmd_effects_nvm to see if a command would 
>> violate
>> a reservation.
>>    The information is missing in effects, for example the flush 
>> command should
>> be checked, but there is onely a  NVME_CMD_EFFECTS_CSUPP flag in 
>> effects, no
>> LBCC.
>>
>> Guixin Liu (3):
>>    nvmet: support reservation feature
>>    nvmet: unify aer type enum
>>    nvme: introduce pr_work to handle resv event
>>
>>   drivers/nvme/host/core.c        |  47 +-
>>   drivers/nvme/host/nvme.h        |   1 +
>>   drivers/nvme/target/Makefile    |   2 +-
>>   drivers/nvme/target/admin-cmd.c |  14 +-
>>   drivers/nvme/target/configfs.c  |  27 +
>>   drivers/nvme/target/core.c      |  53 +-
>>   drivers/nvme/target/discovery.c |   2 +-
>>   drivers/nvme/target/nvmet.h     |  33 ++
>>   drivers/nvme/target/pr.c        | 887 ++++++++++++++++++++++++++++++++
>>   include/linux/nvme.h            |  54 +-
>>   10 files changed, 1103 insertions(+), 17 deletions(-)
>>   create mode 100644 drivers/nvme/target/pr.c
>>

