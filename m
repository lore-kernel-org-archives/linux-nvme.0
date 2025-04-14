Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2B0C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/kGU6A6Jr1/mVprmOIpSU0J1mrESNNr0cDnyTghWIYo=; b=vD7bpdHq1Y76WnWWjsdcQ6r0vQ
	xJGaHmAdTq/1mNqeIoV+DJ0dInwUHUBehjOHifJBkEOKr5xPW3nT9mNzUNs4hORivR8D/QnzyIfc+
	HbE4qy1muZjBeogLT8m7DOLbqSpOjvxA1J/5xdOCWkZ1LwH+/+SM1QNTeqIiEFDWk/Jh5U1im6G1O
	XXur5C96yEiYKteXLy95VHbm3XSR5rtfmrow0yy8VPtnGS+RnZG0qcWWOtVkFbYkHiVHHgWiT9XQs
	pL/auNmZD5qkR1GDpeI7Z5eDI+pHm+jFK96MmalAi6TvxtZfXujgeuwX2nrdl11AZpQAtfFyB+uN1
	B4I3NXBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4SIp-00000003jND-1XK8;
	Mon, 14 Apr 2025 22:29:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4SIo-00000003jK9-1ryH
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Apr 2025 22:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/kGU6A6Jr1/mVprmOIpSU0J1mrESNNr0cDnyTghWIYo=; b=megoEZRCzeb+WhFpYlwgxEzAOk
	/LpE/GueDHr3xJ+TLFPpEbFJSMpj7iFkAiEH1SFyYSQUtrHTzU01RNytkWS5RGK0STpfTpKahhXhA
	7RzSPZPJjyTt5ymvnrYtgmIqmkjX+ImXhIQwcPDwwpwQynNaLSODOL0ZIElb85bTyQ8T59xD0/a/s
	I+Fo7EH+Aj9C+/g6eXvhoKTTLHD6KSHjHlnfuIuVeqBpmFuh2CN24DwUPrt4PksBSfDtMg+Ll0aSk
	TIXRUE6k/tAcR8mYtVBCVPTkLeExSu/bFzpJd+Z9NF3f6RzhtS8p/9BVWJmhsaqUT5V2FuxGxFjlK
	ZFLXw76Q==;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4SI8-00000009n00-2fD4
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 22:28:47 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39ac9aea656so4789081f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 15:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744669697; x=1745274497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kGU6A6Jr1/mVprmOIpSU0J1mrESNNr0cDnyTghWIYo=;
        b=dPfAhVn4Ix4LBB84cqcwbA7NzM+8EBkpY0nR41zrXpUDUH8iVGbs3kZpoDGNhUn49c
         IS2rC8c0wVofr4i9j+g7okPIK/K5icVZF2I/gaouAG3Z6AbJaj4RHsoXdZ9KY8je3cS1
         wFnKUi676pHsSziyMsXNVrLdtRm/4oMmqNHW8XHROw6baK8Bvr1QrHtqrFVeWSwhhpfn
         5NCKO0z3Qpd3IqX+wXsseh88Luz6SbEAUXkHye7dpBrrjkkg6JUW8yXNJEV+RNi/2gwu
         ll5IMxTZ3SWR3qFgvL9+1NXRvQI+iVYm/IKZju2f4vAZ/RvPxMR69zzyrMYMLn33fEwI
         HWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOEsxKnSmBoIgfvytQrBHt25noYIloFqJzWELLm8v+L1saSUaSCc2Eso7l+mDGfRyMjOfskw3vwSpz@lists.infradead.org
X-Gm-Message-State: AOJu0YzWb13UPo7lonPbhDKxGfboUJZZKO6DKdnuy9rHnS88LVX1PwgE
	f4zktNSWrTn2vPHUEOKFx/lkPMDHjXIqamQ4ZqwgD4JbNNRdQSEP
X-Gm-Gg: ASbGnctYAUWnghw7NpWUlKsuT4wXAA3fBCwJDQlCsUNUzFpLiQjyqSsJRXzYRmL3Ki9
	ZOHzw8OMjPpYVdslc7ZKpnux19c93uTuAryvvEWyn+9jfrdQXuDm5kvi1a24azHjWoy+YWCNiEZ
	IPOFnpEq3ZBMxvFV5QVVr8nOwHZAJlrOjBqWmSa295V+LIM4seBtXsbqaLR0Sv4J6SKl0iS8m5V
	5n0ZJyb20ZoaRYZ2YIlu4YyUGVk/4o41mstiRrhqhJ8VhddG8lsunWYUFGIMx9EGV8LJuEL9PpU
	/3kLmJn1Qsx8azMd6aW1rhtbIUXMlL7ZOVgE3sHrVlhr43sS/yzuptSAYKnldMCM6o6Gc6fe
X-Google-Smtp-Source: AGHT+IGvEqNrRzk769p8HhSi/2Qv7EgWRPN9cVexNSBgMUaNihh0RLlvC98RK4ZriM82pD4bGWBV6g==
X-Received: by 2002:a05:6000:2586:b0:39c:e28:5f0d with SMTP id ffacd0b85a97d-39ea52171d4mr11476328f8f.25.1744669696641;
        Mon, 14 Apr 2025 15:28:16 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9640fdsm12098902f8f.7.2025.04.14.15.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 15:28:16 -0700 (PDT)
Message-ID: <738a41ca-3e4a-48df-9424-2950e6efc082@grimberg.me>
Date: Tue, 15 Apr 2025 01:28:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Daniel Wagner <wagi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>,
 randyj@purestorage.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250410085137.GE1868505-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_232836_861622_9C0154F0 
X-CRM114-Status: GOOD (  17.44  )
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



On 10/04/2025 11:51, Mohamed Khalfella wrote:
> On 2025-03-24 13:07:58 +0100, Daniel Wagner wrote:
>> The TP4129 mendates that the failover should be delayed by CQT.  Thus when
>> nvme_decide_disposition returns FAILOVER do not immediately re-queue it on
>> the namespace level instead queue it on the ctrl's request_list and
>> moved later to the namespace's requeue_list.
>>
>> Signed-off-by: Daniel Wagner <wagi@kernel.org>
>> ---
>>   drivers/nvme/host/core.c      | 19 ++++++++++++++++
>>   drivers/nvme/host/fc.c        |  4 ++++
>>   drivers/nvme/host/multipath.c | 52 ++++++++++++++++++++++++++++++++++++++++---
>>   drivers/nvme/host/nvme.h      | 15 +++++++++++++
>>   drivers/nvme/host/rdma.c      |  2 ++
>>   drivers/nvme/host/tcp.c       |  1 +
>>   6 files changed, 90 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 135045528ea1c79eac0d6d47d5f7f05a7c98acc4..f3155c7735e75e06c4359c26db8931142c067e1d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -239,6 +239,7 @@ static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
>>   
>>   	flush_work(&ctrl->reset_work);
>>   	nvme_stop_ctrl(ctrl);
>> +	nvme_flush_failover(ctrl);
>>   	nvme_remove_namespaces(ctrl);
>>   	ctrl->ops->delete_ctrl(ctrl);
>>   	nvme_uninit_ctrl(ctrl);
>> @@ -1310,6 +1311,19 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
>>   	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>>   }
>>   
>> +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
>> +{
>> +	unsigned long delay;
>> +
>> +	if (ctrl->cqt)
>> +		delay = msecs_to_jiffies(ctrl->cqt);
>> +	else
>> +		delay = ctrl->kato * HZ;
> I thought that delay = m * ctrl->kato + ctrl->cqt
> where m = ctrl->ctratt & NVME_CTRL_ATTR_TBKAS ? 3 : 2
> no?

This was said before, but if we are going to always start waiting for 
kato for failover purposes,
we first need a patch that prevent kato from being arbitrarily long.

Lets cap kato to something like 10 seconds (which is 2x the default 
which apparently no one is touching).

