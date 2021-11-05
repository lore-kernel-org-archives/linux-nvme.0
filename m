Return-Path: <SRS0=yHGa=PY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0350DC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Nov 2021 01:55:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9CB603E7
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Nov 2021 01:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D9CB603E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aRiq6PlYuQAFSyP2emKFSXIbPMsx/PRmPBpzBIX84TM=; b=GEl2D+Efg/OUqSFObkvI+YIMh2
	iCMT1vYn+OODJAKsfr/iE7LS3Kosx0gJkWzNq/8uTAP5DyD+hMgxqse9DI1QVH/5M6/ARz/nGqeJ/
	JUx7M7rKc8QdHdx5OuNwDTD1FKlv/Esf0pmhyCohmu9RvW58X0YGVgB5cCLueDf/sRqKt8ALGwyxr
	AK2PEGhdWhCjdS7JXTo87m/m6BS3GSMwuxpwqtcJHCKqXtT5eFzIRdBVndwbnnL8wrSYdfQq0h05e
	sRDRYIcmQA++4mmFR2JwL/IyNlOGwC1bS6o1q29BLYfr/S0MngVTalJvdsMTdSwPOvXUDDN0vYwYs
	VUUeRehA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mioS2-00AMiL-NK; Fri, 05 Nov 2021 01:55:30 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mioRy-00AMhR-C8
 for linux-nvme@lists.infradead.org; Fri, 05 Nov 2021 01:55:28 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hlk3y1YkMzbhdN;
 Fri,  5 Nov 2021 09:50:38 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 09:55:23 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 09:55:23 +0800
Subject: Re: [PATCH 1/1] nvme: fix use after free when disconnect a
 reconnecting ctrl
To: James Smart <jsmart2021@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>
References: <20211104071332.28952-1-liruozhu@huawei.com>
 <20211104071332.28952-2-liruozhu@huawei.com>
 <8165ac91-3ed1-f0c4-16d3-7e6741a610fb@grimberg.me>
 <f6f05614-1070-1dc5-6adc-bd642f21d5e5@gmail.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <75677c2d-6c0f-bdcd-3feb-5d8c7644fc9c@huawei.com>
Date: Fri, 5 Nov 2021 09:55:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <f6f05614-1070-1dc5-6adc-bd642f21d5e5@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_185527_561995_D443ABF5 
X-CRM114-Status: GOOD (  25.12  )
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

On 2021/11/5 7:23, James Smart wrote:

> On 11/4/2021 5:26 AM, Sagi Grimberg wrote:
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
> Before the change below (if fabrics and DELETING, return queue_live), 
> when DELETING, fabrics always would have returned true and never 
> called the nvme_fail_nonready_command() routine.
>
> But with the change, we now have DELETING cases where qlive is false 
> calling this routine. Its possible some of those may have returned 
> BLK_STS_RESOURCE and gotten into the endless loop. The !DELETING check 
> keeps the same behavior as prior while forcing the new DELETING 
> requests to return host_path_error.
>
> I think the change is ok.
>
>
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
>>
>
> this new test was added when when nvmf_check_ready() moved to 
> nvme_check_ready, as fabrics need to do GET/SET_PROPERTIES for 
> register access on shutdown (CC, CSTS) whereas PCI doesn't.  So it was 
> keeping the fabrics unconditional return true to let them through.
>
> It's ok to qualify it as to whether the transport has the queue live.
>
> -- james
> .

Thanks for your reviewing.

-- ruozhu

.


