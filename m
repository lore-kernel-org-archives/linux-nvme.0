Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827EBC5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 02:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yme7UR4qSigWFDAXdvOAuygAOgFSusvHUDdn0I+T76s=; b=4VkwzmLPhTRMSSPcjD36yXlv0/
	lD7omnUY+Xm4gzLzQOc66TN727TvdEAbe3nBAhv0eus6HMtrK9acIO8VgbxwiBDOYaYlq67W29VZR
	1X+CcC+b+Yt9sPfVkg4fNGsENicTdlV637u9f8JhQ77jvcD01RJv/AALPF8P0lAUFbp4TajAo8ub7
	IJud7oge2IuPsoE6nQwZ3cA7Uk4hir5Nsu0SmkC0w71QpdntXR5/3EEtOKIbbE3RtNv29iZR5A5WK
	NF52cS/18vyMaMPxDFhKLKmgGMcfynTHh9yIgH5arAIo19BrPtsyAMpfdG0mSgfH0XP6jEwFCW0W1
	I4izZOOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9bZ-00000007hZH-05TV;
	Wed, 28 Feb 2024 02:23:33 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9bV-00000007hWK-2Q8f
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 02:23:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709087006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yme7UR4qSigWFDAXdvOAuygAOgFSusvHUDdn0I+T76s=;
	b=S8o8bVziVXVCA7YlU4A/RrV3zkZ8L2LjSc/wyZCJdeGKfRvyTT6mKGg8lN7FsnW3G3r6N3Kg6wujATvfpsFMPRFZgD7PIKv/posABhf/s/qvbCVNmDCm86wXO+GYm+sD4MHxtvKdK5065iAdSjjLx27aA2ZHZRpsqJWkn/O7Lss=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1O7xbp_1709086919;
Received: from 30.178.83.72(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1O7xbp_1709086919)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 10:23:24 +0800
Message-ID: <89bcff20-e07c-4f62-9ef8-36cbbc3d6def@linux.alibaba.com>
Date: Wed, 28 Feb 2024 10:23:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fabrics: check max outstanding commands
Content-Language: en-GB
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20240223033004.55756-1-kanie@linux.alibaba.com>
 <Zd4f4PaoOM6WSF4u@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <Zd4f4PaoOM6WSF4u@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_182329_814835_50B0D856 
X-CRM114-Status: GOOD (  14.82  )
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


在 2024/2/28 01:46, Keith Busch 写道:
> On Fri, Feb 23, 2024 at 11:30:04AM +0800, Guixin Liu wrote:
>> Maxcmd is mandatory for fabrics, check it early to identify the root
>> cause instead of waiting for it to propagate to "sqsize" and "allocing
>> queue".
>>
>> By the way, change nvme_check_ctrl_fabric_info() to
>> nvmf_validate_identify_ctrl().
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/host/core.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0a96362912ce..5cdd22f591f9 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3084,7 +3084,8 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>   	return 0;
>>   }
>>   
>> -static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>> +static int nvmf_validate_identify_ctrl(struct nvme_ctrl *ctrl,
>> +				       struct nvme_id_ctrl *id)
>>   {
>>   	/*
>>   	 * In fabrics we need to verify the cntlid matches the
>> @@ -3117,6 +3118,11 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (!ctrl->maxcmd) {
>> +		dev_err(ctrl->device, "Maximum outstanding commands is 0\n");
>> +		return -EINVAL;
>> +	}
> This part seems fine, but I don't think you need to change the name of
> the function for this addition.

OK, this will be removed in v2.

Best Regards,

Guixin Liu


