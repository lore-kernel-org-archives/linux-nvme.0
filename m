Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA8C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:25:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95946503F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95946503F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IWVN5JMMiyyDBYPSYc12zx3uuy/MLGHAbx4zVsb2Kyc=; b=GHL96AtCllwwpt1c85n7cFhea
	Jj1CyITWmwa44yIvKYPt/rchATYXZix3QJYrExFDR6qKpZczRI1ueru+556Tyu0iRwET2C3lJ6MC9
	6mLvWnMOtlvdg4OwIwzspwsZ2XKLn7tJZLC3LTPiPnSHDVAZ7/OlUCBSWZoIlbQ8oLsErSRZSULJb
	Vk3bc6A2mGgyNLzurrwLjAKMpXzPyw/u7i6tIwb4wx5dnAy/L1cS2SRhW70XfPo6+60O8dm1Ob6U3
	rBGA+cfb197m0YNXmmLiJdb+bNyM2w4P2a6S5eJBDc0c05PjAdF9L7DAZDjevjGZ6ZGHljJDoSSjA
	MJIingXXw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM0K5-00HJP8-Gl; Tue, 16 Mar 2021 03:24:45 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM0K0-00HJOA-L1
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 03:24:43 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DzzBL0LwXzRQNc;
 Tue, 16 Mar 2021 11:22:50 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 16 Mar 2021 11:24:33 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 16
 Mar 2021 11:24:33 +0800
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, "Chaitanya
 Kulkarni" <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <7d552635-6f95-fca4-b0ca-709967465495@huawei.com>
Date: Tue, 16 Mar 2021 11:24:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210315222714.378417-1-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_032441_432798_598C4737 
X-CRM114-Status: GOOD (  24.62  )
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

Does the problem exist on the latest version?

We also found Similar deadlocks in the older version.
However, with the latest code, it do not block grabbing the nshead srcu
when ctrl is freezed.
related patches:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block/blk-core.c?id=fe2008640ae36e3920cf41507a84fb5d3227435a
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a6c35f9af416114588298aa7a90b15bbed15a41
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block/blk-core.c?id=ed00aabd5eb9fb44d6aff1173234a2e911b9fead
I am not sure they are the same problem.


On 2021/3/16 6:27, Sagi Grimberg wrote:
> The below patches caused a regression in a multipath setup:
> Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> 
> These patches on their own are correct because they fixed a controller reset
> regression.
> 
> When we reset/teardown a controller, we must freeze and quiesce the namespaces
> request queues to make sure that we safely stop inflight I/O submissions.
> Freeze is mandatory because if our hctx map changed between reconnects,
> blk_mq_update_nr_hw_queues will immediately attempt to freeze the queue, and
> if it still has pending submissions (that are still quiesced) it will hang.
> This is what the above patches fixed.
> 
> However, by freezing the namespaces request queues, and only unfreezing them
> when we successfully reconnect, inflight submissions that are running
> concurrently can now block grabbing the nshead srcu until either we successfully
> reconnect or ctrl_loss_tmo expired (or the user explicitly disconnected).
> 
> This caused a deadlock [1] when a different controller (different path on the
> same subsystem) became live (i.e. optimized/non-optimized). This is because
> nvme_mpath_set_live needs to synchronize the nshead srcu before requeueing I/O
> in order to make sure that current_path is visible to future (re)submisions.
> However the srcu lock is taken by a blocked submission on a frozen request
> queue, and we have a deadlock.
> 
> For multipath, we obviously cannot allow that as we want to failover I/O asap.
> However for non-mpath, we do not want to fail I/O (at least until controller
> FASTFAIL expires, and that is disabled by default btw).
> 
> This creates a non-symmetric behavior of how the driver should behave in the
> presence or absence of multipath.
> 
> [1]:
> Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
> Call Trace:
>   __schedule+0x293/0x730
>   schedule+0x33/0xa0
>   schedule_timeout+0x1d3/0x2f0
>   wait_for_completion+0xba/0x140
>   __synchronize_srcu.part.21+0x91/0xc0
>   synchronize_srcu_expedited+0x27/0x30
>   synchronize_srcu+0xce/0xe0
>   nvme_mpath_set_live+0x64/0x130 [nvme_core]
>   nvme_update_ns_ana_state+0x2c/0x30 [nvme_core]
>   nvme_update_ana_state+0xcd/0xe0 [nvme_core]
>   nvme_parse_ana_log+0xa1/0x180 [nvme_core]
>   nvme_read_ana_log+0x76/0x100 [nvme_core]
>   nvme_mpath_init+0x122/0x180 [nvme_core]
>   nvme_init_identify+0x80e/0xe20 [nvme_core]
>   nvme_tcp_setup_ctrl+0x359/0x660 [nvme_tcp]
>   nvme_tcp_reconnect_ctrl_work+0x24/0x70 [nvme_tcp]
> 
> 
> In order to fix this, we recognize the different behavior a driver needs to take
> in error recovery scenarios for mpath and non-mpath scenarios and expose this
> awareness with a new helper nvme_ctrl_is_mpath and use that to know what needs
> to be done.
> 
> Sagi Grimberg (3):
>    nvme: introduce nvme_ctrl_is_mpath helper
>    nvme-tcp: fix possible hang when trying to set a live path during I/O
>    nvme-rdma: fix possible hang when trying to set a live path during I/O
> 
>   drivers/nvme/host/multipath.c |  5 +++--
>   drivers/nvme/host/nvme.h      | 15 +++++++++++++++
>   drivers/nvme/host/rdma.c      | 29 +++++++++++++++++------------
>   drivers/nvme/host/tcp.c       | 30 +++++++++++++++++-------------
>   4 files changed, 52 insertions(+), 27 deletions(-)
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
