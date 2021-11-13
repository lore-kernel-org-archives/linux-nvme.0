Return-Path: <SRS0=AmD0=QA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A733C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Nov 2021 10:05:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B3F6108E
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Nov 2021 10:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2B3F6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/gzp1mDscXR6HVoFh/0lplxRvuMcw5DL9gKOzLvEQV4=; b=aoHKX2PjIutloIrXAzAz1tsTwJ
	sruA7piB+E+g2Ou9Ohdz6LTmkmhF+eObuGxA6ei21NirzdA5kL4qvUd/9vCgajRnglI7jDkaoS7V+
	jGVN2NXD+PWC/YudIdlojpJyHSMVBycL9jg+EkkPtJLl6m4vj0X5Q5XxVbpbK3OQscS8Q1kgorxtO
	ARVYnhurdTKyKleVbVU0BFS0HJGLWna57HYYvALqFIwIDU8srJinOEUIxfPcJck1MhbOJOS9/Wz2n
	uyFyluht297lZVeST4DXXdsq+wLgyamx0CrxGKAOUegAQQtjH4r0Feus1cjI4mcjrTCGNLQsPmI19
	GKNPhbUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlpu2-00CT5z-Ad; Sat, 13 Nov 2021 10:04:54 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlpty-00CT54-Gu
 for linux-nvme@lists.infradead.org; Sat, 13 Nov 2021 10:04:52 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HrrcR0v4Rz8vHB;
 Sat, 13 Nov 2021 18:03:03 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 13 Nov 2021 18:04:42 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sat, 13 Nov
 2021 18:04:42 +0800
Subject: Re: [PATCH 1/1] nvme: fix use after free when disconnect a
 reconnecting ctrl
From: liruozhu <liruozhu@huawei.com>
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20211104071332.28952-1-liruozhu@huawei.com>
 <20211104071332.28952-2-liruozhu@huawei.com>
 <8165ac91-3ed1-f0c4-16d3-7e6741a610fb@grimberg.me>
 <88268d9e-92bf-83ee-13bd-8de2d975e669@huawei.com>
Message-ID: <910fd696-250b-b8a6-8b89-62a7fb16a402@huawei.com>
Date: Sat, 13 Nov 2021 18:04:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <88268d9e-92bf-83ee-13bd-8de2d975e669@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211113_020450_940914_1CEFCC3C 
X-CRM114-Status: GOOD (  20.05  )
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

Hi sagi,

On 2021/11/5 9:34, liruozhu wrote:
> On 2021/11/4 20:26, Sagi Grimberg wrote:
>>
>>> A crash happens when I try to disconnect a reconnecting ctrl:
>>>
>>> 1) The network was cut off when the connection was just established,
>>> scan work hang there waiting for some IOs complete.Those IOs were
>>> retrying because we return BLK_STS_RESOURCE to blk in reconnecting.
>>>
>>> 2) After a while, I tried to disconnect this connection.This procedure
>>> also hung because it tried to obtain ctrl->scan_lock.It should be noted
>>> that now we have switched the controller state to NVME_CTRL_DELETING.
>>>
>>> 3) In nvme_check_ready(), we always return true when ctrl->state is
>>> NVME_CTRL_DELETING, so those retrying IOs were issued to the bottom
>>> device which was already freed.
>>>
>>> To fix this, when ctrl->state is NVME_CTRL_DELETING, issue cmd to 
>>> bottom
>>> device only when queue state is live.If not, return host path error 
>>> to blk.
>>>
>>> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
>>> ---
>>>   drivers/nvme/host/core.c | 1 +
>>>   drivers/nvme/host/nvme.h | 2 +-
>>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 838b5e2058be..752203ad7639 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -666,6 +666,7 @@ blk_status_t nvme_fail_nonready_command(struct 
>>> nvme_ctrl *ctrl,
>>>           struct request *rq)
>>>   {
>>>       if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
>>> +        ctrl->state != NVME_CTRL_DELETING &&
>>
>> Please explain why you need this change? As suggested by the name
>> only DELETING_NOIO does not accept I/O, and if we return
>> BLK_STS_RESOURCE we can get into an endless loop of resubmission.
>
> I just added the handling of the DELETING state here, did not modify 
> the DELETING_NOIO case.
>
> Thanks,
> Ruozhu
>
I'm not sure if I explained it clearly, my English is not very good.

If you think there is still a problem with this patch, please tell me.

Thanks,
Ruozhu
>>
>>>           ctrl->state != NVME_CTRL_DEAD &&
>>>           !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>>>           !blk_noretry_request(rq) && !(rq->cmd_flags & 
>>> REQ_NVME_MPATH))
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index b334af8aa264..9b095ee01364 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -709,7 +709,7 @@ static inline bool nvme_check_ready(struct 
>>> nvme_ctrl *ctrl, struct request *rq,
>>>           return true;
>>>       if (ctrl->ops->flags & NVME_F_FABRICS &&
>>>           ctrl->state == NVME_CTRL_DELETING)
>>> -        return true;
>>> +        return queue_live;
>>
>> I agree with this change. I thought I've already seen this change from
>> James in the past.
>> .

