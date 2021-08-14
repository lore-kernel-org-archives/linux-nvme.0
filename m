Return-Path: <SRS0=EXTw=NF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACD6C4338F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 03:20:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C23960F39
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 03:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C23960F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANdGx35Me9tBEofCVQF//IEJlzxpI6ZIYsjBeDmYHiA=; b=ByZ62muaAHuXqjEoX82QcCieeh
	YMHI0/JfRH4rMTMCg1N5r9L8o03JHyTD7s0we66dc4SYXQ5oRBiPd7S8DzKsOEUdBIMUmZcH4eB/2
	cyzgrqrv+KQtetfhUm2SBTEVJBu3lBCjsDNnslaRrDtPDloPKw0EsmawrkAC3pOqIgWnfYdt/Zfbs
	ofNigBPHfhEUCQydUuVEHWJNc/fC0jheNTQj8g0cklLzVpIMgOftrNI/p8c818rF63L4b9PCMiV9t
	VFceqCaDMBujuj0cQ3AEo+xE2poxZmpSJoW+Tk1lMEEjUAwTTkGLq80lqFm9GtZZvZpbJD4DPjxFQ
	GJW/G+kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEkDO-00DnC5-GV; Sat, 14 Aug 2021 03:20:06 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEkDK-00DnAw-Mw
 for linux-nvme@lists.infradead.org; Sat, 14 Aug 2021 03:20:05 +0000
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GmltZ5FY0z87BP;
 Sat, 14 Aug 2021 11:15:50 +0800 (CST)
Received: from [10.169.46.19] (10.169.46.19) by dggeme768-chm.china.huawei.com
 (10.3.19.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 14
 Aug 2021 11:19:49 +0800
Subject: Re: [PATCH] nvme-tcp: Don't update queue count when failing to set io
 queues
To: Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <lengchao@huawei.com>
References: <20210807035023.27368-1-liruozhu@huawei.com>
 <20210813200219.GA2661@dhcp-10-100-145-180.wdc.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <a1b4e977-7564-bf2c-b1cf-77a5048447c7@huawei.com>
Date: Sat, 14 Aug 2021 11:19:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20210813200219.GA2661@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210813_202003_164023_80B88248 
X-CRM114-Status: GOOD (  22.28  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/8/14 4:02, Keith Busch wrote:

> On Sat, Aug 07, 2021 at 11:50:23AM +0800, Ruozhu Li wrote:
>> We update ctrl->queue_count and schedule another reconnect when io queue
>> count is zero.But we will never try to create any io queue in next reco-
>> nnection, because ctrl->queue_count already set to zero.We will end up
>> having an admin-only session in Live state, which is exactly what we try
>> to avoid in the original patch.
>> Update ctrl->queue_count after queue_count zero checking to fix it.
> I think this patch fixes more than just an admin-only session. We've observed
> an issue where a subsequent reconnect has the wrong queue_count and tries to
> use uninitialized sockets that leads to the below panic. We have not seen the
> panic with this patch included since it reconfigures the IO queues, so I feel
> this patch is good for either 5.14 or stable.
Agree. Eventually this problem will cause nr_hw_queue and the real hardware
queue number to be inconsistent, and lead to the use of uninitialized 
resources.
I also found a crash using rdma, because driver detected that nr_hw_queue is
greater than ctrl.queue_count. This patch(rdma version) also solves that 
problem.
--
BUG_ON(hctx_idx >= ctrl->ctrl.queue_count); // nvme_rdma_init_hctx
--
Call trace:
nvme_rdma_init_hctx+0x58/0x60 [nvme_rdma]
blk_mq_realloc_hw_ctxs+0x140/0x4c0
blk_mq_init_allocated_queue+0x130/0x410
blk_mq_init_queue+0x40/0x88
nvme_validate_ns+0xb8/0x740
nvme_scan_work+0x29c/0x460
process_one_work+0x1f8/0x490
worker_thread+0x50/0x4b8
kthread+0x134/0x138
ret_from_fork+0x10/0x18
--

Thanks,
Ruozhu
>   [00:30:04 2021] nvme nvme3: queue 0: timeout request 0x16 type 4
>   [00:30:04 2021] nvme nvme3: Could not set queue count (881)
>   [00:30:04 2021] nvme nvme3: unable to set any I/O queues
>   [00:30:04 2021] nvme nvme3: Failed reconnect attempt 4
>   [00:30:04 2021] nvme nvme3: Reconnecting in 10 seconds...
>   [00:30:15 2021] nvme nvme3: queue_size 128 > ctrl sqsize 16, clamping down
>   [00:30:15 2021] BUG: kernel NULL pointer dereference, address: 00000000000000a0
>   [00:30:15 2021] #PF: supervisor read access in kernel mode
>   [00:30:15 2021] #PF: error_code(0x0000) - not-present page
>   [00:30:15 2021] PGD 0 P4D 0
>   [00:30:15 2021] Oops: 0000 [#1] SMP NOPTI
>   [00:30:15 2021] CPU: 0 PID: 3776 Comm: kworker/0:2H Not tainted 5.12.9 #1
>   [00:30:15 2021] Hardware name: Dell Inc. PowerEdge R7525/0YHMCJ, BIOS 2.0.3 01/15/2021
>   [00:30:15 2021] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>   [00:30:15 2021] RIP: 0010:kernel_sendpage+0x16/0xc0
>   [00:30:15 2021] Code: 5d c3 48 63 03 45 31 e4 48 89 1c c5 20 b1 55 a7 eb cc 66 90 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 fc 48 83 ec 18 48 8b 47 20 <4c> 8b 88 a0 00 00 00 4d 85 c9 74 3d 48 8b 7e 08 48 8d 47 ff 83 e7
>   [00:30:15 2021] RSP: 0018:ffffa8e90aef3d60 EFLAGS: 00010286
>   [00:30:15 2021] RAX: 0000000000000000 RBX: ffff98bd601ca130 RCX: 0000000000000048
>   [00:30:15 2021] RDX: 0000000000000bc8 RSI: ffffd241a3c577c0 RDI: ffff98c4c64a3400
>   [00:30:15 2021] RBP: ffffa8e90aef3d80 R08: 0000000000028040 R09: ffff98bd9892b998
>   [00:30:15 2021] R10: ffff98bd9892b498 R11: 000000000000000c R12: ffff98c4c64a3400
>   [00:30:15 2021] R13: 0000000000000048 R14: 0000000000000000 R15: ffff98bd9892b998
>   [00:30:15 2021] FS:  0000000000000000(0000) GS:ffff98c49e800000(0000) knlGS:0000000000000000
>   [00:30:15 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [00:30:15 2021] CR2: 00000000000000a0 CR3: 00000008901fc000 CR4: 0000000000350ef0
>   [00:30:15 2021] Call Trace:
>   [00:30:15 2021]  ? tcp_read_sock+0x199/0x270
>   [00:30:15 2021]  nvme_tcp_try_send+0x160/0x7f0 [nvme_tcp]
>   [00:30:15 2021]  ? _raw_spin_unlock_bh+0x1e/0x20
>   [00:30:15 2021]  ? release_sock+0x8f/0xa0
>   [00:30:15 2021]  ? nvme_tcp_try_recv+0x74/0xa0 [nvme_tcp]
>   [00:30:15 2021]  nvme_tcp_io_work+0x81/0xd0 [nvme_tcp]
>   [00:30:15 2021]  process_one_work+0x220/0x3c0
>   [00:30:15 2021]  worker_thread+0x4d/0x3f0
>   [00:30:15 2021]  kthread+0x114/0x150
>   [00:30:15 2021]  ? process_one_work+0x3c0/0x3c0
>   [00:30:15 2021]  ? kthread_park+0x90/0x90
>   [00:30:15 2021]  ret_from_fork+0x22/0x30
>
>> ---
>>   drivers/nvme/host/tcp.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 8cb15ee5b249..18bd68b82d78 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1769,13 +1769,13 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ctrl->queue_count = nr_io_queues + 1;
>> -	if (ctrl->queue_count < 2) {
>> +	if (nr_io_queues == 0) {
>>   		dev_err(ctrl->device,
>>   			"unable to set any I/O queues\n");
>>   		return -ENOMEM;
>>   	}
>>   
>> +	ctrl->queue_count = nr_io_queues + 1;
>>   	dev_info(ctrl->device,
>>   		"creating %d I/O queues.\n", nr_io_queues);
>>   
>> -- 
> .

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
