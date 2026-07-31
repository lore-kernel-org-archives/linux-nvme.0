Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1462CC55167
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 02:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hXiolKONxAI7Y5+RM0tAKXtGXmCcz/ylTHfX32QCNZw=; b=q8xdR4uu2Tc0SXOHv/zgkImyKG
	1l+u4sUK6ZxsOzp7E1wih62S8auoJfsdj1PfqfBEMhkZtFuPvTIMsKKcBwnbykSV3hkZax3Gn0ytP
	MOI2+NXh/X86XnJT2TEtyU1Zae8kiQiWVXoCjztJrbblrjKqlYXRpvo9rDIpQfZnB64OfrKfm+rlB
	RCll0kKkGi/MjRxrruCJ4UFXo/gLylR8cIR9qGgxO/ySiQG6UDPJYtNjQXLJyTyQaUEacRyDZKCua
	uK2y3qz5+x9ewwYY2cu/cbV5vaCmNLVoudUfFSXmwZx4HmO2sgcdo0saMx3a7hiz5CF+XLjYNOk/4
	ynMa5pKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdIW-0000000Be4T-0Vvt;
	Fri, 31 Jul 2026 02:48:32 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdIS-0000000Be47-2TtT
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 02:48:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785466104; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hXiolKONxAI7Y5+RM0tAKXtGXmCcz/ylTHfX32QCNZw=;
	b=uEC3cogW16QcmMomx4Q9oJUOP7wdrhK0sdHUcYTZ3JdzoFFlLjLtQRHwVtCWpwQmMuuoeBUXwY4k2A/hiIcmPZ8HIokN/Vx26CGRmZM82YYXTejGtBJTdXF1HvNxt6chabDzdNQrJBE+ou9B0OYLlZiF5Nr8F/1546eMgzs8zKE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X86WD7h_1785466102;
Received: from 30.178.83.106(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86WD7h_1785466102 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 10:48:23 +0800
Message-ID: <879797f7-ce3e-494d-be11-fe96790fa03e@linux.alibaba.com>
Date: Fri, 31 Jul 2026 10:48:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-3-nilay@linux.ibm.com>
 <61fb25bf-3ee1-4400-8b65-ea6cfe27b9a2@linux.alibaba.com>
 <83701c38-ba9e-4134-85f0-e11e1129375d@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <83701c38-ba9e-4134-85f0-e11e1129375d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_194829_319411_029E465E 
X-CRM114-Status: GOOD (  10.43  )
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



在 2026/7/30 20:01, Nilay Shroff 写道:
> On 7/29/26 1:25 PM, Guixin Liu wrote:
>> Hi,
>>    Raise some comments to see if we can keep moving this
>> feature forward.
>>    Once this feature is merged, I'll be able to build the
>> service-time I/O policy on top of it.
>>
> Thanks for the review! BTW we alreday have patch revision v6
> upstream now. You may find it here (in case you missed it):
> https://lore.kernel.org/all/20260520182112.863076-1-nilay@linux.ibm.com/
>
Sorry, I miss that.
>>
>> +static bool nvme_mpath_enable_adaptive_path_policy(struct nvme_ns *ns)
>> +{
>> +    struct nvme_ns_head *head = ns->head;
>> +
>> +    if (!head->disk || head->subsys->iopolicy != 
>> NVME_IOPOLICY_ADAPTIVE)
>> +        return false;
>> +
>> +    if (test_and_set_bit(NVME_NS_PATH_STAT, &ns->flags))
>> +        return false;
>> +
>> +    blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, ns->queue);
>> +    blk_stat_enable_accounting(ns->queue);
>> +    return true;
>> +}
>> +
>> +static bool nvme_mpath_disable_adaptive_path_policy(struct nvme_ns *ns)
>> +{
>> +
>> +    if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
>> +        return false;
>> +
>> +    blk_stat_disable_accounting(ns->queue);
>> +    blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);
>> +    nvme_mpath_reset_adaptive_path_stat(ns);
>> The adp_path still hold the ns's pointer, should clear too,
>> otherwise, we will access a freed ns.
Is this correct?

Best Regards,
Guixin Liu
>>> +    return true;
>>> +} 


