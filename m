Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF21C2BA18
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jun 2024 07:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wv+nb63jc8RX+XM579eAzoR3ORtF5l0kMJ0jYedplWM=; b=EQA4ed+rRSBomzYDrFnKoBHnPs
	5SRxQsiCbbrtjVrWrtXpYBJ33XtwUCrT55sAopbCq7p3hRC3kRyBZtuKO6NAJpbFuTm1Ks10MgXo8
	q9FKEQqWijmguMlhJPJqSq29R+5N5CYqW6EfF7W+/6uKRKScTShDYboA6DkxZ+LWxk8pqT5KixM/S
	9LUOXRXJO3msKAA4i5JjlTTg01bQt7KQVdmkTXvUsWtbch60shmM1o+2iBvYTO4cvHTcE6ES/KD/2
	qwL17QZX92/DBHHqkhpX2/3B7MENtk1dN+OnieOVy001tHqbu6lxEKYKmQIuOqIBptNrPxV8+M+TQ
	gYzEaQSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLHGV-0000000DUg5-1U1n;
	Sun, 23 Jun 2024 07:03:55 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLHGS-0000000DUep-3MNq
	for linux-nvme@lists.infradead.org;
	Sun, 23 Jun 2024 07:03:54 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-366dd7b269cso47140f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 23 Jun 2024 00:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126230; x=1719731030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv+nb63jc8RX+XM579eAzoR3ORtF5l0kMJ0jYedplWM=;
        b=ooeEldyyivw1emLmcs1sN0jVci2CwOLsyJYiE6gWAVMuRwjIj0T9iQTFjvNZtLGv11
         cKfbZ6IxPOn/C8MdmurU7Xod6CD8/sVFqcZwj0cN568nTIEouaGqihqnqE0IkWAdDh87
         TsFqtzy+l1BDSVf38H03pNIk4AwwYrUebZUsfz29+vjPWY09Vp3LuK24TiO6I/OD/vuC
         h8WQXgh0gmiVFVGn3PnVxSKGpBU78SwKFDS5ZeYh67G1oGB8lIyZXvjNJvux9SHq6/Lh
         gjxMA9Ach6b+6BmCBL2TSCmaDGl+kwG+wZ1ZzxPgxgihZhjVjQC6X1+AONohQ/P7Eqky
         LwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv8ID6TWcwDrQRgI99CcbHJITfJS5ytwB5/A0T9i4k6B27LM3/UarbOUmta4TNfICgvzwr2Zu9fNS3Ey0bXgLKYk6jZ0MkhoSMbxT6VTc=
X-Gm-Message-State: AOJu0YyiOlJrbU3QB1zSXZ2TdVsbv5yX3grIZgbctCUu7AObM57bbzYF
	apbL2tHqfGn6T1VhcCbmDuYXjzR8yeK8f8c33vOHV5uolu/ou5lb
X-Google-Smtp-Source: AGHT+IEFnKUhu/I1x5TTgU8A64wWsdGchv2Vq9HTIBSF0tK7sTEaqtJeSsf2sJNzJFpypmhL2ozVZw==
X-Received: by 2002:a05:6000:2a7:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-366eb60beb4mr559833f8f.3.1719126229676;
        Sun, 23 Jun 2024 00:03:49 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm6575582f8f.96.2024.06.23.00.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 00:03:49 -0700 (PDT)
Message-ID: <e1e35796-2d9e-41ac-a515-a39dc1866070@grimberg.me>
Date: Sun, 23 Jun 2024 10:03:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-pci: limit queue count to housekeeping cpus
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Hannes Reinecke <hare@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-2-8b169bf41083@suse.de>
 <20240622051420.GC11303@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240622051420.GC11303@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240623_000352_870066_97D02FBB 
X-CRM114-Status: GOOD (  10.99  )
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



On 22/06/2024 8:14, Christoph Hellwig wrote:
>> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
>> index 9638b25fd521..43c039900ef6 100644
>> --- a/block/blk-mq-cpumap.c
>> +++ b/block/blk-mq-cpumap.c
>> @@ -11,10 +11,23 @@
>>   #include <linux/smp.h>
>>   #include <linux/cpu.h>
>>   #include <linux/group_cpus.h>
>> +#include <linux/sched/isolation.h>
>>   
>>   #include "blk.h"
>>   #include "blk-mq.h"
>>   
>> +unsigned int blk_mq_num_possible_queues(void)
>> +{
>> +	const struct cpumask *io_queue_mask;
>> +
>> +	io_queue_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
>> +	if (!cpumask_empty(io_queue_mask))
>> +		return cpumask_weight(io_queue_mask);
>> +
>> +	return num_possible_cpus();
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
> This should be split into a separate patch.  And it could really use
> a kerneldoc comment.

Agree.

Other than that, looks good.

