Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0ADC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 23:23:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB52B6120D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 23:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB52B6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pk9kQcMjnNHsygE7dS0iDxkDYZo6TPo7cIooq3uHKr4=; b=umsxEF/rvylS7jech+h14CQhEL
	mZ4OEDPc/gN5WyHOHJSABTrNtoZhDbWJ0ewBTwHZi/RGA1R3YvSuVJox4yWncrTJDTMdPE+VqNjUu
	yHuZsQmTw2PBA361N6fjA2O/w+KnK1ZSSxcF6XMMlnMoZq+g/E2DbnjURDmCxv9zv+lfJSpNsboWW
	R5DtSWZwgF6E0Lb89VB29zcfO+FYV9UNGEK3usaFV0fxu61HhfnHnYz1zM4GDs91yxoI+msnDinEL
	oXsUIDgPrwfG7+fUMTZNCutHmKAIqH7Kh14chnXl+jyy+q4a4ZGj2GWc7/MwCbV1HiJFTooDZyg/M
	34nrt/+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mim4h-00A82i-L4; Thu, 04 Nov 2021 23:23:15 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mim4e-00A81i-Pu
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 23:23:14 +0000
Received: by mail-pl1-x634.google.com with SMTP id k4so9838785plx.8
 for <linux-nvme@lists.infradead.org>; Thu, 04 Nov 2021 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=pk9kQcMjnNHsygE7dS0iDxkDYZo6TPo7cIooq3uHKr4=;
 b=dr3yQ404I2zdL9LkHL9wgTiW9zBTs+fOm0vqoFQLOgBNNiP4QT8NrZrBQbPOGbU59s
 i5UCki8fw2KjJTOLJ9LHTvMbaBEErWwiHIupKzVofZs8uoG+WXXdmJcFCAdIhplDX/Q3
 2Mo0cjSQlPNjeYbn9HGPJoGTAUs23tODIO3aGFL35GJYB7d2MLD+0NGD/z4/tMhZy1Qh
 gDtUTn10/nQfw5OhnKCykYkYEQm0gMvdYiAUo4pIj7JiiuZ8c0bEPyGUPy1IskXmHb2V
 T0s0S3MpLA1TXq7AB6RX72i2MzZ2W/RUNOrj6PqKJ+Tmcn2EGswFZuEu/Bwydp6GCnF0
 XcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=pk9kQcMjnNHsygE7dS0iDxkDYZo6TPo7cIooq3uHKr4=;
 b=ZgSXaqq3ZjoNbOiRb+L8XnkECxU+ExrR6Vw9LIVVMipudAJ3YUJq1TtcmDO9+ojrBM
 +GNUr4QdoRYeztEdUCpSamHXQ600DeanA0KJwDPp8Trb1mtd1R8OfpkysGaEzcLrovn9
 WJNAUuDd3mkYnHbiQy+LDQ4iNdxzk0/qkESb8jhPpJzBWfQ+VQNPBXIZ4uv92d/VYXn2
 /icq7ZQxrEMIknhZECRDL3XdvVuhR/Q7Ph+zG6NO5Ert5qV0Jbp564kp+54ZrPuOnREh
 0ixfWQrgM/CBxEgvs/DZ3t7uNAwcuBx0D8A8vgmxP0sLGw2ng/OfW9oHKrfoUqno6h+a
 LEQA==
X-Gm-Message-State: AOAM530am6pCuJ/albJJ1XXc1UiVZYVzWg7BrGjXrShc4TbwEXVsviXn
 l/juD82WbUXFbxuzRpG/604=
X-Google-Smtp-Source: ABdhPJyNv4sE68RjKakbQ0DkV3F34RnkSte3KgR6MDVdqb8Kjd4/Qy725+vy/4360b9JJwXA3W3Xvg==
X-Received: by 2002:a17:90a:1950:: with SMTP id
 16mr25369574pjh.126.1636068190270; 
 Thu, 04 Nov 2021 16:23:10 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b15sm6013485pfm.203.2021.11.04.16.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Nov 2021 16:23:10 -0700 (PDT)
Message-ID: <f6f05614-1070-1dc5-6adc-bd642f21d5e5@gmail.com>
Date: Thu, 4 Nov 2021 16:23:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/1] nvme: fix use after free when disconnect a
 reconnecting ctrl
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Ruozhu Li <liruozhu@huawei.com>,
 linux-nvme@lists.infradead.org
References: <20211104071332.28952-1-liruozhu@huawei.com>
 <20211104071332.28952-2-liruozhu@huawei.com>
 <8165ac91-3ed1-f0c4-16d3-7e6741a610fb@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <8165ac91-3ed1-f0c4-16d3-7e6741a610fb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_162312_889727_AB488E4D 
X-CRM114-Status: GOOD (  24.59  )
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

On 11/4/2021 5:26 AM, Sagi Grimberg wrote:
> 
>> A crash happens when I try to disconnect a reconnecting ctrl:
>>
>> 1) The network was cut off when the connection was just established,
>> scan work hang there waiting for some IOs complete.Those IOs were
>> retrying because we return BLK_STS_RESOURCE to blk in reconnecting.
>>
>> 2) After a while, I tried to disconnect this connection.This procedure
>> also hung because it tried to obtain ctrl->scan_lock.It should be noted
>> that now we have switched the controller state to NVME_CTRL_DELETING.
>>
>> 3) In nvme_check_ready(), we always return true when ctrl->state is
>> NVME_CTRL_DELETING, so those retrying IOs were issued to the bottom
>> device which was already freed.
>>
>> To fix this, when ctrl->state is NVME_CTRL_DELETING, issue cmd to bottom
>> device only when queue state is live.If not, return host path error to 
>> blk.
>>
>> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
>> ---
>>   drivers/nvme/host/core.c | 1 +
>>   drivers/nvme/host/nvme.h | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 838b5e2058be..752203ad7639 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -666,6 +666,7 @@ blk_status_t nvme_fail_nonready_command(struct 
>> nvme_ctrl *ctrl,
>>           struct request *rq)
>>   {
>>       if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
>> +        ctrl->state != NVME_CTRL_DELETING &&
> 
> Please explain why you need this change? As suggested by the name
> only DELETING_NOIO does not accept I/O, and if we return
> BLK_STS_RESOURCE we can get into an endless loop of resubmission.

Before the change below (if fabrics and DELETING, return queue_live), 
when DELETING, fabrics always would have returned true and never called 
the nvme_fail_nonready_command() routine.

But with the change, we now have DELETING cases where qlive is false 
calling this routine. Its possible some of those may have returned 
BLK_STS_RESOURCE and gotten into the endless loop. The !DELETING check 
keeps the same behavior as prior while forcing the new DELETING requests 
to return host_path_error.

I think the change is ok.


> 
>>           ctrl->state != NVME_CTRL_DEAD &&
>>           !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>>           !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index b334af8aa264..9b095ee01364 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -709,7 +709,7 @@ static inline bool nvme_check_ready(struct 
>> nvme_ctrl *ctrl, struct request *rq,
>>           return true;
>>       if (ctrl->ops->flags & NVME_F_FABRICS &&
>>           ctrl->state == NVME_CTRL_DELETING)
>> -        return true;
>> +        return queue_live;
> 
> I agree with this change. I thought I've already seen this change from
> James in the past.
> 

this new test was added when when nvmf_check_ready() moved to 
nvme_check_ready, as fabrics need to do GET/SET_PROPERTIES for register 
access on shutdown (CC, CSTS) whereas PCI doesn't.  So it was keeping 
the fabrics unconditional return true to let them through.

It's ok to qualify it as to whether the transport has the queue live.

-- james

