Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2EBC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DN/sr86Ec1vO5OeciSRICyeM8rDMTcn83cUpCrmkxR0=; b=ibGCeqlGMS1Xwb+c7xpJRu8bOb
	YkzFk3pJ7HeDV3wxnqbpfFOHpgRKoOinCJ4Educ1H2ZVjAuerAvhJVtXEetnzJlbgO1ZImarmd47+
	mbfiSgyUA+BnU0/dA2e4L6wzdvUibfVKbySneVwHunAvNig3/zJmXuX8mH3EtwfByyQf6Pnyq9LP8
	A1vXKy6oc6gSTaIhw/bLyVEwnVIu0cgTW/d927+Cop2t9gCK2pklnaYKm7F5kmFoacEPvG3HRoVPH
	RcvivaO47WFUWM4azk1d13skVbMwtK8B4YSbLtVQB0mCXGDylbAtNHoRRAV+vqSid7c2Cz9ai2iXU
	GGs0QTRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4Qx-003HND-0B;
	Mon, 04 Dec 2023 08:36:07 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4Qt-003HLc-0D
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 08:36:04 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vxlvrv8_1701678954;
Received: from 30.178.83.103(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Vxlvrv8_1701678954)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 16:35:55 +0800
Message-ID: <45ebdf06-81f9-420c-9490-3d28fd514e68@linux.alibaba.com>
Date: Mon, 4 Dec 2023 16:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
To: Bitao Hu <yaoma@linux.alibaba.com>, sagi@grimberg.me, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
 <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
Content-Language: en-GB
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_003603_272092_435F3272 
X-CRM114-Status: GOOD (  22.50  )
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

Looks good to me.

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

My thanks for the advise Sagi given.

在 2023/11/30 10:13, Bitao Hu 写道:
> If controller reset occurs when allocating namespace, both
> nvme_reset_work and nvme_scan_work will hang, as shown below.
>
> Test Scripts:
>
>      for ((t=1;t<=128;t++))
>      do
>      nsid=`nvme create-ns /dev/nvme1 -s 14537724 -c 14537724 -f 0 -m 0 \
>      -d 0 | awk -F: '{print($NF);}'`
>      nvme attach-ns /dev/nvme1 -n $nsid -c 0
>      done
>      nvme reset /dev/nvme1
>
> We will find that both nvme_reset_work and nvme_scan_work hung:
>
>      INFO: task kworker/u249:4:17848 blocked for more than 120 seconds.
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>      message.
>      task:kworker/u249:4  state:D stack:    0 pid:17848 ppid:     2
>      flags:0x00000028
>      Workqueue: nvme-reset-wq nvme_reset_work [nvme]
>      Call trace:
>      __switch_to+0xb4/0xfc
>      __schedule+0x22c/0x670
>      schedule+0x4c/0xd0
>      blk_mq_freeze_queue_wait+0x84/0xc0
>      nvme_wait_freeze+0x40/0x64 [nvme_core]
>      nvme_reset_work+0x1c0/0x5cc [nvme]
>      process_one_work+0x1d8/0x4b0
>      worker_thread+0x230/0x440
>      kthread+0x114/0x120
>      INFO: task kworker/u249:3:22404 blocked for more than 120 seconds.
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>      message.
>      task:kworker/u249:3  state:D stack:    0 pid:22404 ppid:     2
>      flags:0x00000028
>      Workqueue: nvme-wq nvme_scan_work [nvme_core]
>      Call trace:
>      __switch_to+0xb4/0xfc
>      __schedule+0x22c/0x670
>      schedule+0x4c/0xd0
>      rwsem_down_write_slowpath+0x32c/0x98c
>      down_write+0x70/0x80
>      nvme_alloc_ns+0x1ac/0x38c [nvme_core]
>      nvme_validate_or_alloc_ns+0xbc/0x150 [nvme_core]
>      nvme_scan_ns_list+0xe8/0x2e4 [nvme_core]
>      nvme_scan_work+0x60/0x500 [nvme_core]
>      process_one_work+0x1d8/0x4b0
>      worker_thread+0x260/0x440
>      kthread+0x114/0x120
>      INFO: task nvme:28428 blocked for more than 120 seconds.
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>      message.
>      task:nvme            state:D stack:    0 pid:28428 ppid: 27119
>      flags:0x00000000
>      Call trace:
>      __switch_to+0xb4/0xfc
>      __schedule+0x22c/0x670
>      schedule+0x4c/0xd0
>      schedule_timeout+0x160/0x194
>      do_wait_for_common+0xac/0x1d0
>      __wait_for_common+0x78/0x100
>      wait_for_completion+0x24/0x30
>      __flush_work.isra.0+0x74/0x90
>      flush_work+0x14/0x20
>      nvme_reset_ctrl_sync+0x50/0x74 [nvme_core]
>      nvme_dev_ioctl+0x1b0/0x250 [nvme_core]
>      __arm64_sys_ioctl+0xa8/0xf0
>      el0_svc_common+0x88/0x234
>      do_el0_svc+0x7c/0x90
>      el0_svc+0x1c/0x30
>      el0_sync_handler+0xa8/0xb0
>      el0_sync+0x148/0x180
>
> The reason for the hang is that nvme_reset_work occurs while nvme_scan_work
> is still running. nvme_scan_work may add new ns into ctrl->namespaces
> list after nvme_reset_work frozen all ns->q in ctrl->namespaces list.
> The newly added ns is not frozen, so nvme_wait_freeze will wait forever.
> Unfortunately, ctrl->namespaces_rwsem is held by nvme_reset_work, so
> nvme_scan_work will also wait forever. Now we are deadlocked!
>
> PROCESS1                         PROCESS2
> ==============                   ==============
> nvme_scan_work
>    ...                            nvme_reset_work
>    nvme_validate_or_alloc_ns        nvme_dev_disable
>      nvme_alloc_ns                    nvme_start_freeze
>       down_write                      ...
>       nvme_ns_add_to_ctrl_list        ...
>       up_write                      nvme_wait_freeze
>      ...                              down_read
>      nvme_alloc_ns                    blk_mq_freeze_queue_wait
>       down_write
>
> Fix by marking the ctrl with say NVME_CTRL_FROZEN flag set in
> nvme_start_freeze and cleared in nvme_unfreeze. Then the scan can check
> it before adding the new namespace (under the namespaces_rwsem).
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
> v1 -> v2:
> As per the review comments given by Sagi Grimberg and Keith Busch,
> did below changes in v2,
> - Add NVME_CTRL_FROZEN nvme_ctrl_flags
> - Check ctrl->flags before adding the new namespace (under the namespaces_rwsem), rather than rely on ctrl->state
> ---
>   drivers/nvme/host/core.c | 10 ++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 11 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 62612f8..89181c7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3631,6 +3631,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   		goto out_unlink_ns;
>   
>   	down_write(&ctrl->namespaces_rwsem);
> +	/*
> +	 * Ensure that no namespaces are added to the ctrl list after the queues
> +	 * are frozen, thereby avoiding a deadlock between scan and reset.
> +	 */
> +	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
> +		up_write(&ctrl->namespaces_rwsem);
> +		goto out_unlink_ns;
> +	}
>   	nvme_ns_add_to_ctrl_list(ns);
>   	up_write(&ctrl->namespaces_rwsem);
>   	nvme_get_ctrl(ctrl);
> @@ -4540,6 +4548,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
>   		blk_mq_unfreeze_queue(ns->queue);
>   	up_read(&ctrl->namespaces_rwsem);
> +	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
>   }
>   EXPORT_SYMBOL_GPL(nvme_unfreeze);
>   
> @@ -4573,6 +4582,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
>   
> +	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
>   	down_read(&ctrl->namespaces_rwsem);
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
>   		blk_freeze_queue_start(ns->queue);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 39a90b7..07b57df 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -251,6 +251,7 @@ enum nvme_ctrl_flags {
>   	NVME_CTRL_STOPPED		= 3,
>   	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
>   	NVME_CTRL_DIRTY_CAPABILITY	= 5,
> +	NVME_CTRL_FROZEN		= 6,
>   };
>   
>   struct nvme_ctrl {

