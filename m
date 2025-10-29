Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73C1CCF9EA
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 01:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1HMXZUqi4p1m2cKuHDA5I6yW4PKU/pDq/KjjFVjh6gw=; b=fBmWOeCj3wt7ZaQHN4AO2i1cYm
	1sO59NyoADa/t/9NBxc8O58YX4P/bEN9d8HLuLNf037mjbFaAMHBNBk+JJInRwtRbr70XG/bVBwFN
	jiMgv0X1hnQp5csZWJ/cifMR9KuqWBwnMdXGG2UD2lgE85uxXlDLNzZpVq3jb9Dbyl1QqgT18lPJN
	BLd9pwrAOIpQ6WYFUroj5JvA0D7FbEPmZ7M6iElIE2HZ/gsBUWocC6AkQoBfFTBXDoKG74D2+INRc
	CfzVqu5OIgPZHMJDZh49shcSnlMzBA0J6r5U/4tk+8wtVCIGEcMPV7W0gTRG/7ZJGqUDDPeJoKxpI
	vT+I6Dcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDvCj-0000000Gvv1-3ykb;
	Wed, 29 Oct 2025 01:42:25 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDvCf-0000000GvuR-3OgE
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 01:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761702134; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1HMXZUqi4p1m2cKuHDA5I6yW4PKU/pDq/KjjFVjh6gw=;
	b=h37LTNpKpNcETjfbVLV6XAMe764w1FNq6PrVXlMGtN8n9DOz5MrYpF8p7ZwslBjF0egZb9Y3MpP35LEb+6PC438GYDRLX7E3HWH3jxs1viX4hxX7x+RKgX077vhuWrWop9lqLUB7c8tOneG1c92X7m24IDje5SZluQU1U+1S2ak=
Received: from 30.178.82.197(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WrDn1rc_1761702131 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 09:42:12 +0800
Message-ID: <36c2cec2-7d0b-4ee6-a79f-d5e318a8fee0@linux.alibaba.com>
Date: Wed, 29 Oct 2025 09:42:11 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvme: introduce panic_on_double_cqe param
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20251022135454.75767-1-kanie@linux.alibaba.com>
 <6dc4c33e-8183-481c-a101-8a2b6596d2b1@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <6dc4c33e-8183-481c-a101-8a2b6596d2b1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_184222_528689_D345D9FC 
X-CRM114-Status: GOOD (  13.72  )
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



在 2025/10/23 13:14, Chaitanya Kulkarni 写道:
> On 10/22/25 6:54 AM, Guixin Liu wrote:
>> Add a new debug switch to control whether to trigger a kernel crash
>> when duplicate CQEs are detected, in order to preserve the kernel
>> context, such as sq, cq, and so on, for subsequent debugging and
>> analysis.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>    drivers/nvme/host/core.c | 5 +++++
>>    drivers/nvme/host/nvme.h | 3 +++
>>    2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index fa4181d7de73..7a3f9129a39c 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -95,6 +95,11 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
>>    MODULE_PARM_DESC(apst_secondary_latency_tol_us,
>>    	"secondary APST latency tolerance in us");
>>    
>> +bool panic_on_double_cqe;
>> +EXPORT_SYMBOL_GPL(panic_on_double_cqe);
>> +module_param(panic_on_double_cqe, bool, 0644);
>> +MODULE_PARM_DESC(panic_on_double_cqe, "crash the kernel to save the scene");
>> +
>>    /*
>>     * Older kernels didn't enable protection information if it was at an offset.
>>     * Newer kernels do, so it breaks reads on the upgrade if such formats were
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 102fae6a231c..24010d5d15ce 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -595,6 +595,8 @@ static inline u16 nvme_cid(struct request *rq)
>>    	return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
>>    }
>>    
>> +extern bool panic_on_double_cqe;
>> +
>>    static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
>>    		u16 command_id)
>>    {
>> @@ -612,6 +614,7 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
>>    		dev_err(nvme_req(rq)->ctrl->device,
>>    			"request %#x genctr mismatch (got %#x expected %#x)\n",
>>    			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
>> +		BUG_ON(panic_on_double_cqe);
>>    		return NULL;
>>    	}
>>    	return rq;
>
> I'm really not sure this is a good idea, I'll leave to others.
>
>
> -ck
Yeah, I think so too, and I'd also like to find a more elegant solution.

Best Regards,
Guixin Liu


