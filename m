Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1318ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PNTOrmRDRF155i/3HptbPkESuCfztx5NVzQx381N1zo=; b=ZmnrCRbYQ7PE6xuuiTrZ+y1YiH
	YTNVm+bE+Elc3FMiKDOQdP4WKiuouiWo2M5V7kIjfPfLcf0/XhmdLZJkRvyLqrUdCPtWKAxAg2ru7
	C/lkuYa9mw6UnXG64DfYiIbXZpWAGoqnVCLrIxWiff0dG+WhZgJcn6QILde73BoutIMLs5fgQ2PQm
	MF6dwKM6aVr6xgj5L5i0cCtvTqrdOECFhxEHFH0SKWOBk88wMbf771skt7J6q9oGZkubq5AiThQCT
	y1v+qkms/E0+s8I+23fP6z5sb45E4uWspy3gev04le9Hr3LAMezHsa8FG8mncvAFCDH8h48GLvXc0
	ee8s6oVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0G1-00GnaB-40; Tue, 30 Aug 2022 12:22:17 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0Fs-00GnTU-LR
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 12:22:12 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH5wC70ZjznTrQ;
	Tue, 30 Aug 2022 20:19:39 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 20:22:05 +0800
Subject: Re: [PATCH v3 3/3] nvme-rdma: Handle number of queue changes
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-4-dwagner@suse.de>
 <5cc0b557-7e56-36c9-cfe4-05ca76f5e83e@huawei.com>
 <20220829093219.6ii76hne6pjzxjws@carbon.lan>
 <8df0c325-0215-4019-d4cf-c7516863dbe4@huawei.com>
 <301f2b4e-9c7f-875f-e066-e9c3f4bfc9e7@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c046d4c6-49c9-afa4-1740-656517413941@huawei.com>
Date: Tue, 30 Aug 2022 20:22:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <301f2b4e-9c7f-875f-e066-e9c3f4bfc9e7@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_052210_359285_A8DAF61D 
X-CRM114-Status: GOOD (  11.60  )
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



On 2022/8/30 16:21, Sagi Grimberg wrote:
> 
>>> On Mon, Aug 29, 2022 at 05:22:50PM +0800, Chao Leng wrote:
>>>>> +    ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
>>>>> +                    ctrl->tag_set.nr_hw_queues + 1);
>>>>> +    if (ret)
>>>>> +        goto out_wait_freeze_timed_out;
>>>> nvme_rdma_start_io_queues(ctrl, 1, nr_queues) need to clean.
>>>
>>> the teardown path in nvme_rdma_stop_io_queus() is using
>>>
>>>     test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags)
>>>
>>> when iterating over all nr_hw_queues.
>> I mean that we need realloc the ctrl->queues for
>> nvme_rdma_start_io_queues(ctrl, 1, nr_queues).
>> Otherwise, unallocated memory will be accessed when
>> the new queue_count is bigger than the old one.
> 
> That can't happen. ctrl->queues is allocated at the start
> of the controller lifetime and will never exceed this queue
> count.
I don't understand why it can't happen.
nvme_rdma_start_io_queues(ctrl, nr_queues, ctrl->tag_set.nr_hw_queues + 1)
is designed for dealing with the scenario that the new queue_count is
bigger than the old one. it will access the unallocated memory.
ctrl->queues is just allocated the first queue count buffers at the start
of the controller lifetime, if the new queue count is bigger than the
first queue count, ctrl-queues will be insufficient.
> .

