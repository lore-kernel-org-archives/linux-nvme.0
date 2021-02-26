Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485A6C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 03:51:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD4F64EE3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 03:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD4F64EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4jPM1szPi0ndby/TmoghsDuBhzEcQDaVUsBq4EOKfwE=; b=oPfcB6micWCJVXIBNNox+NlLb
	UVu5WQL1YTRx74TA7ZWPNTQOBBVnzSUZhUdyp/3bJGsKFTuII6BGz88kY5+IeyUJwwx4exfyTaEfA
	NmNgg3x1OsrK5ExvmQp9ufeCuY/Oe6499D91/CneMS/yvTSKdvd/4r7YrjSGMuf2eQoPztcr2JVa3
	FtIeZp5OvBV4ldvzh+v4G/K7Rsp+UfjaQVDE+ZRzQAKTWXO9oXROn2BlCcFj2zKas3GMUZXtANngW
	A7w6CaaUxPiD0zbGPRSPC/X+Ek9lwqqkqMGNxXdlcMowkavtbE9H/gOl89v6mUYRh5ofeogEH5CXr
	4+Va3T6XA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFUA8-0004kV-U3; Fri, 26 Feb 2021 03:51:32 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFUA6-0004jw-R0
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 03:51:32 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Dmwdk1CVgz5WVw;
 Fri, 26 Feb 2021 11:49:46 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 26 Feb 2021 11:51:22 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 26
 Feb 2021 11:51:17 +0800
Subject: Re: [PATCH V8 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, "Christoph
 Hellwig" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20201020085555.1554255-1-ming.lei@redhat.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com>
Date: Fri, 26 Feb 2021 11:51:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201020085555.1554255-1-ming.lei@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_225131_405887_B0FC576A 
X-CRM114-Status: GOOD (  20.75  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Bart
 Van Assche <bvanassche@acm.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

About nvme_stop_queues need long times for large number namespaces,
If work with multipath and one path fails, It cause wait long times
to fail over to retry, and the more namespaces the longer the time.
This has a great impact on delay-sensitive services.
there are two options to fix it:
1. Use percpu instead of SRCU. Ming's patchset.
2. Use tagset quiesce interface with SRCU. Sagi's patchset.
The two patchsets are still pending.

It is a serious bug, I expect that we can revisit the solution.
Maybe we don't have the best option, but we need to choose a relatively
acceptable option.

Can we fix the bug for non-blocking queues(which used by fc&rdma) first?

Sagi & Ming, what do you think?
Thank you.

On 2020/10/20 16:55, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> The 3rd patch adds tagset quiesce interface.
> 
> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> 
> V8:
> 	- rebase on latest linus tree, only there is small fuzz change on 2/4
> 
> V7:
> 	- base on latest for-5.10/block, only there is small change on 2/4
> 
> V6:
> 	- base on for-5.10/block directly, instead of being against on patchset of
> 	'percpu_ref & block: reduce memory footprint of percpu_ref in fast path',
> 	because these patches don't depend on that patchset.
> 
> V5:
> 	- warn once in case that driver unquiesces its queue being
> 	  quiesce and not done, only patch 2 is modified
> 
> V4:
> 	- remove .mq_quiesce_mutex, and switch to test_and_[set|clear] for
> 	avoiding duplicated quiesce action
> 	- pass blktests(block, nvme)
> 
> V3:
> 	- add tagset quiesce interface
> 	- apply tagset quiesce interface for NVMe
> 	- pass blktests(block, nvme)
> 
> V2:
> 	- add .mq_quiesce_lock
> 	- add comment on patch 2 wrt. handling hctx_lock() failure
> 	- trivial patch style change
> 
> 
> Ming Lei (3):
>    block: use test_and_{clear|test}_bit to set/clear QUEUE_FLAG_QUIESCED
>    blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
>    blk-mq: add tagset quiesce interface
> 
> Sagi Grimberg (1):
>    nvme: use blk_mq_[un]quiesce_tagset
> 
>   block/blk-core.c         |  13 +++
>   block/blk-mq-sysfs.c     |   2 -
>   block/blk-mq.c           | 182 +++++++++++++++++++++++++--------------
>   block/blk-sysfs.c        |   6 +-
>   block/blk.h              |   2 +
>   drivers/nvme/host/core.c |  19 ++--
>   include/linux/blk-mq.h   |  10 +--
>   include/linux/blkdev.h   |   4 +
>   8 files changed, 154 insertions(+), 84 deletions(-)
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Chao Leng <lengchao@huawei.com>
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
