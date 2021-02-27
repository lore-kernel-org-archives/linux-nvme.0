Return-Path: <SRS0=5wgU=H5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E55C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Feb 2021 09:31:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5520F64E4E
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Feb 2021 09:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5520F64E4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rnZUH/Gw2ChFF3hPmwyHZ/+n6/zVMPKnsRDTe+VjiMI=; b=RkNVgdgEOl6lt8V1oCguWCzDi
	FI8o/fdBR3iyj8Px2tdhqTHw0ixjLJLq3bPopjhK4q24y0YKNuI7/Z5ecyK2UxsndJ3kRBjlcQNwC
	WmHkZeJyYM2f2l4prFnOCYAC/V7OFxpmNU1ArQvnm1scvxYhCipc4vVU44wMlH57oZrNuRFcmBo4s
	3qja2mzSosuvU2Ep1rY6eFf5Xfi2iuTiJW8cm6oAvjk/ibrwQ57JWqc3RFe97tsK8CmkcXVdh8trc
	w77EshIgAJInbzpUeBvh7bdY4KznQ6tzFYULQNXR3WIlc4xvUHSCf4KYncHhelUgJHNIAIhZmRVPE
	VVonU2kjw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFvwN-0002s3-4K; Sat, 27 Feb 2021 09:31:11 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFvwJ-0002qn-7Z
 for linux-nvme@lists.infradead.org; Sat, 27 Feb 2021 09:31:08 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Dnh6t0L9Vz5XDQ
 for <linux-nvme@lists.infradead.org>; Sat, 27 Feb 2021 17:29:10 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 27 Feb 2021 17:30:48 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Sat, 27
 Feb 2021 17:30:47 +0800
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
To: Hannes Reinecke <hare@suse.de>, <linux-nvme@lists.infradead.org>
References: <20210223072602.3196-1-lengchao@huawei.com>
 <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
 <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
 <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
Date: Sat, 27 Feb 2021 17:30:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210227_043107_933306_00A17C33 
X-CRM114-Status: GOOD (  17.11  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/2/27 17:12, Hannes Reinecke wrote:
> On 2/24/21 6:59 AM, Chao Leng wrote:
>>
>>
>> On 2021/2/24 7:21, Keith Busch wrote:
>>> On Tue, Feb 23, 2021 at 03:26:02PM +0800, Chao Leng wrote:
>>>> A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
>>>> over rdma(roce) reconnection, the reason is use the queue which is not
>>>> alloced.
>>>>
>>>> If it is not discovery and no io queues, the connection should fail.
>>>
>>> If you're getting a timeout, we need to quit initialization. Hannes
>>> attempted making that status visible for fabrics here:
>>>
>>> http://lists.infradead.org/pipermail/linux-nvme/2021-January/022353.html
>> I know the patch. It can not solve the scenario: target may be an
>> attacker or the target behavior is incorrect.
>> If target return 0 io queues or return other error code, the crash will
>> still happen. We should not allow this to happen.
> I'm fully with you that we shouldn't crash, but at the same time a value of '0' for the number of I/O queues is considered valid.
> So we should fix the code to handle this scenario, and not disallowing zero I/O queues.
'0' I/O queues doesn't make any sense to nvme over fabrics, it is
different with nvme over pci. If there is some bug with target, we can
debug it in target instead of use admin queue in host.
target may be an attacker or the target behavior is incorrect. So we
should avoid crash. Another option: prohibit  request delivery if
io queue do not created.
I think failed connection with '0' I/O queues is a better choice.
> 
> Cheers,
> 
> Hannes

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
