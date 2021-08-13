Return-Path: <SRS0=sV58=NE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E3FC4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Aug 2021 20:02:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96395610CF
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Aug 2021 20:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96395610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U9DoguWP27l3db8cEDbHgNvB9ICg6n/J4Q6bOVE08TA=; b=jid7zExz4v5BJR
	ACNCPsoU5Wr1DCHpEth/wPKWRwZ7xLtRzVoFpehSsDYCX1BPGp2epZ60mh5ZIqMcz1TVt+6WDBSBS
	YcUt3n+8k2lyxEJgNDp655CR37pl1v3MevgihAGJQIijoCDAVH2Zln47Yjop34bx5PwVCJ/Rqc9oT
	oBJ5EFT1/ftk0b+ShAfcl6iD+dCuROUGKJrrVslFaROQl2tMOp+PIIRTMTReAApfaLn+77cv49pWK
	gxACZzVTzgwd3PocxsR9KM9WjZCfMWsAmTRzGDPmpds1I3/kt+1kXASMjskQapIQSLOXHPOWJA1Sk
	k+gVrcPApv2IcSAwa6ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEdNr-00DWIk-5w; Fri, 13 Aug 2021 20:02:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEdNm-00DWIE-OK
 for linux-nvme@lists.infradead.org; Fri, 13 Aug 2021 20:02:24 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5CAB61042;
 Fri, 13 Aug 2021 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628884942;
 bh=2yn96sWlsC0fvsJxKsbolQbtW9+ykylHFid0uAISc2E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u7/IWKN1DEwikJKbq9mqOTrwd/C3dEhedRY75klcG7+Nigfqaz4rJvCkhmKNvQ08i
 cBo93HhB8pLWq3hV0U06xnMKFCIbel2dD8xaDGsnQ+9S7rMrzwWcbTdKjSkHGfMIj+
 rTUEvJRr+xvS4qIMWSwTCCuLI55wMMTcFjAHFaJs5bzcQdvAAXPfGsONwVDBeQ/LvA
 T70cymxe4FhgPmjRaZTaYCCSOuSnaKVMJMFpra8jiNjIgXER7AFH7hG9E2dfN0UfeR
 zMuDr/7c6ny+eg7XxPEzbZHqEd69bcX1k7uUKuOD1ptchwXJoCeWr9bJA1XJTS8AxV
 lRN8Q9/qv+00w==
Date: Fri, 13 Aug 2021 13:02:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ruozhu Li <liruozhu@huawei.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, lengchao@huawei.com
Subject: Re: [PATCH] nvme-tcp: Don't update queue count when failing to set
 io queues
Message-ID: <20210813200219.GA2661@dhcp-10-100-145-180.wdc.com>
References: <20210807035023.27368-1-liruozhu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210807035023.27368-1-liruozhu@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210813_130222_880075_03FDE5AE 
X-CRM114-Status: GOOD (  22.61  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Aug 07, 2021 at 11:50:23AM +0800, Ruozhu Li wrote:
> We update ctrl->queue_count and schedule another reconnect when io queue
> count is zero.But we will never try to create any io queue in next reco-
> nnection, because ctrl->queue_count already set to zero.We will end up
> having an admin-only session in Live state, which is exactly what we try
> to avoid in the original patch.
> Update ctrl->queue_count after queue_count zero checking to fix it.

I think this patch fixes more than just an admin-only session. We've observed
an issue where a subsequent reconnect has the wrong queue_count and tries to
use uninitialized sockets that leads to the below panic. We have not seen the
panic with this patch included since it reconfigures the IO queues, so I feel
this patch is good for either 5.14 or stable.

 [00:30:04 2021] nvme nvme3: queue 0: timeout request 0x16 type 4
 [00:30:04 2021] nvme nvme3: Could not set queue count (881)
 [00:30:04 2021] nvme nvme3: unable to set any I/O queues
 [00:30:04 2021] nvme nvme3: Failed reconnect attempt 4
 [00:30:04 2021] nvme nvme3: Reconnecting in 10 seconds...
 [00:30:15 2021] nvme nvme3: queue_size 128 > ctrl sqsize 16, clamping down
 [00:30:15 2021] BUG: kernel NULL pointer dereference, address: 00000000000000a0
 [00:30:15 2021] #PF: supervisor read access in kernel mode
 [00:30:15 2021] #PF: error_code(0x0000) - not-present page
 [00:30:15 2021] PGD 0 P4D 0
 [00:30:15 2021] Oops: 0000 [#1] SMP NOPTI
 [00:30:15 2021] CPU: 0 PID: 3776 Comm: kworker/0:2H Not tainted 5.12.9 #1
 [00:30:15 2021] Hardware name: Dell Inc. PowerEdge R7525/0YHMCJ, BIOS 2.0.3 01/15/2021
 [00:30:15 2021] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
 [00:30:15 2021] RIP: 0010:kernel_sendpage+0x16/0xc0
 [00:30:15 2021] Code: 5d c3 48 63 03 45 31 e4 48 89 1c c5 20 b1 55 a7 eb cc 66 90 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 fc 48 83 ec 18 48 8b 47 20 <4c> 8b 88 a0 00 00 00 4d 85 c9 74 3d 48 8b 7e 08 48 8d 47 ff 83 e7
 [00:30:15 2021] RSP: 0018:ffffa8e90aef3d60 EFLAGS: 00010286
 [00:30:15 2021] RAX: 0000000000000000 RBX: ffff98bd601ca130 RCX: 0000000000000048
 [00:30:15 2021] RDX: 0000000000000bc8 RSI: ffffd241a3c577c0 RDI: ffff98c4c64a3400
 [00:30:15 2021] RBP: ffffa8e90aef3d80 R08: 0000000000028040 R09: ffff98bd9892b998
 [00:30:15 2021] R10: ffff98bd9892b498 R11: 000000000000000c R12: ffff98c4c64a3400
 [00:30:15 2021] R13: 0000000000000048 R14: 0000000000000000 R15: ffff98bd9892b998
 [00:30:15 2021] FS:  0000000000000000(0000) GS:ffff98c49e800000(0000) knlGS:0000000000000000
 [00:30:15 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [00:30:15 2021] CR2: 00000000000000a0 CR3: 00000008901fc000 CR4: 0000000000350ef0
 [00:30:15 2021] Call Trace:
 [00:30:15 2021]  ? tcp_read_sock+0x199/0x270
 [00:30:15 2021]  nvme_tcp_try_send+0x160/0x7f0 [nvme_tcp]
 [00:30:15 2021]  ? _raw_spin_unlock_bh+0x1e/0x20
 [00:30:15 2021]  ? release_sock+0x8f/0xa0
 [00:30:15 2021]  ? nvme_tcp_try_recv+0x74/0xa0 [nvme_tcp]
 [00:30:15 2021]  nvme_tcp_io_work+0x81/0xd0 [nvme_tcp]
 [00:30:15 2021]  process_one_work+0x220/0x3c0
 [00:30:15 2021]  worker_thread+0x4d/0x3f0
 [00:30:15 2021]  kthread+0x114/0x150
 [00:30:15 2021]  ? process_one_work+0x3c0/0x3c0
 [00:30:15 2021]  ? kthread_park+0x90/0x90
 [00:30:15 2021]  ret_from_fork+0x22/0x30

> ---
>  drivers/nvme/host/tcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8cb15ee5b249..18bd68b82d78 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1769,13 +1769,13 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>  	if (ret)
>  		return ret;
>  
> -	ctrl->queue_count = nr_io_queues + 1;
> -	if (ctrl->queue_count < 2) {
> +	if (nr_io_queues == 0) {
>  		dev_err(ctrl->device,
>  			"unable to set any I/O queues\n");
>  		return -ENOMEM;
>  	}
>  
> +	ctrl->queue_count = nr_io_queues + 1;
>  	dev_info(ctrl->device,
>  		"creating %d I/O queues.\n", nr_io_queues);
>  
> -- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
