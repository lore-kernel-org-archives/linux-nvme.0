Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EADFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 01:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0fvWMycF3+2nDBaHw07ejBzYQZ2xfbtUVhv3nFSAL30=; b=OmWqFgU0xj4YTp6Rxj2Fqs6/wG
	Bl5mA4GHHcpieLs2g6bjbK4Uc6lFgi+0Cu4+FYHf581pRPe8rlmh/Wm28sIaoNeVhHVo2fYJmygy0
	motqucM8NZgBVxXw/wRx2w+LAKM48mqN5aMFhD8RUTzhrPWP0ikCjnRz+hOqCXxBuN9Ud2RnoSR5g
	BCb6qpaeFAn1EegIaASUMeLlB6PWjtX0/6EMmi2BD7Nn87EA12kf1M+hSul0U/gIcFD7Ja7G0+c84
	GtQszJqFZeUWJYLPqLknuQ20W5rBWLLtczColqW0dtqUzpAuOclOPR+0Y/LrdRPknfCPA+TSSooOI
	vtEF1r5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXByD-00FHdJ-VX; Thu, 24 Mar 2022 01:08:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXByA-00FHbt-Ge
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 01:08:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648084133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fvWMycF3+2nDBaHw07ejBzYQZ2xfbtUVhv3nFSAL30=;
 b=bHwAyy9stlG/0klih6nSiVuetM2xD0+rtf5iM0HT6h1fdu/57s67rxh5PFK7VQUOFM3XWn
 jX76h4vEDtVXVfTSbsC0pxcVqNfywxFW8WGN+IGirYnMpNsQL2qo2iRuNI2TlcyFQ0gqvL
 B8sJT78Lz1QrRDhhOTcpo+dl/Yq0CaY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-MAkKDPcqPNqku56DkQcivg-1; Wed, 23 Mar 2022 21:08:50 -0400
X-MC-Unique: MAkKDPcqPNqku56DkQcivg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E59FC1C05AC2;
 Thu, 24 Mar 2022 01:08:49 +0000 (UTC)
Received: from [10.22.19.101] (unknown [10.22.19.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C0482166B2D;
 Thu, 24 Mar 2022 01:08:49 +0000 (UTC)
Message-ID: <a2e49e16-6e4e-9a70-b7b2-82bebfc2bc08@redhat.com>
Date: Wed, 23 Mar 2022 21:08:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] Revert "nvme-multipath: fix hang when disk goes live over
 reconnect"
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
References: <20220324000620.4127-1-kch@nvidia.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220324000620.4127-1-kch@nvidia.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_180854_664288_29CA1C1C 
X-CRM114-Status: GOOD (  25.28  )
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

Yes, please revert.

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 3/23/22 20:06, Chaitanya Kulkarni wrote:
> This reverts commit d50c992edf10b95d2034097405c94fecfbe1ef7f which is
> causing following OOPs:
> <1>[    1.943642] BUG: kernel NULL pointer dereference, address: 0000000000000008
> <1>[    1.943645] #PF: supervisor read access in kernel mode
> <1>[    1.943646] #PF: error_code(0x0000) - not-present page
> <6>[    1.943648] PGD 0 P4D 0
> <4>[    1.943649] Oops: 0000 [#1] PREEMPT SMP NOPTI
> <4>[    1.943651] CPU: 0 PID: 7 Comm: kworker/u96:0 Not tainted 5.17.0-rc2nvme+ #58
> <4>[    1.943653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> <4>[    1.943654] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> <4>[    1.943662] RIP: 0010:nvme_parse_ana_log+0x1e/0x160 [nvme_core]
> 
> <4>[    1.943670] RSP: 0018:ffffc90000043e00 EFLAGS: 00010286
> <4>[    1.943672] RAX: 0000000000000000 RBX: ffff888103fd4210 RCX: 0000000000000000
> <4>[    1.943673] RDX: ffffffffc00b62c0 RSI: ffffc90000043e44 RDI: ffff888103fd4210
> <4>[    1.943673] RBP: ffff888103fd4210 R08: 0000000000000001 R09: ffff888100051828
> <4>[    1.943674] R10: 0000000000000000 R11: fffffffffff4a904 R12: 0000000000000000
> <4>[    1.943675] R13: ffff88817daa6500 R14: 0000000000000000 R15: ffff88817daa6505
> <4>[    1.943677] FS:  0000000000000000(0000) GS:ffff888fff200000(0000) knlGS:0000000000000000
> <4>[    1.943678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[    1.943678] CR2: 0000000000000008 CR3: 00000001788a4000 CR4: 0000000000350ef0
> <4>[    1.943680] Call Trace:
> <4>[    1.943683]  <TASK>
> <4>[    1.943684]  ? nvme_update_ns_ana_state+0x40/0x40 [nvme_core]
> <4>[    1.943690]  nvme_mpath_update+0x4a/0x70 [nvme_core]
> <4>[    1.943695]  nvme_start_ctrl+0x110/0x140 [nvme_core]
> <4>[    1.943700]  process_one_work+0x1af/0x380
> <4>[    1.943709]  worker_thread+0x50/0x3a0
> <4>[    1.943711]  ? rescuer_thread+0x370/0x370
> <4>[    1.943712]  kthread+0xe7/0x110
> <4>[    1.943714]  ? kthread_complete_and_exit+0x20/0x20
> <4>[    1.943716]  ret_from_fork+0x22/0x30
> <4>[    1.943719]  </TASK>
> 
> [0]kdb>
> 
> With this revert not testing can proceed forward.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c      |  1 -
>   drivers/nvme/host/multipath.c | 23 ++---------------------
>   drivers/nvme/host/nvme.h      |  4 ----
>   3 files changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8cb1197aac42..ccc5877d514b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4511,7 +4511,6 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   	if (ctrl->queue_count > 1) {
>   		nvme_queue_scan(ctrl);
>   		nvme_start_queues(ctrl);
> -		nvme_mpath_update(ctrl);
>   	}
>   
>   	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 12d4afde3662..c97d7f843977 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -612,18 +612,8 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>   	ns->ana_grpid = le32_to_cpu(desc->grpid);
>   	ns->ana_state = desc->state;
>   	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
> -	/*
> -	 * nvme_mpath_set_live() will trigger I/O to the mpath
> -	 * device node and in turn to this path device, however we
> -	 * cannot accept this I/O if the ctrl is not live.
> -	 * This may deadlock if called from the nvme_mpath_init_identify()
> -	 * and the ctrl will never complete initialization,
> -	 * preventing I/O from completing.
> -	 * For this case we will reprocess the ANA log page
> -	 * in nvme_mpath_update() once the ctrl ready.
> -	 */
> -	if (nvme_state_is_live(ns->ana_state) &&
> -	    ns->ctrl->state == NVME_CTRL_LIVE)
> +
> +	if (nvme_state_is_live(ns->ana_state))
>   		nvme_mpath_set_live(ns);
>   }
>   
> @@ -710,15 +700,6 @@ static void nvme_ana_work(struct work_struct *work)
>   	nvme_read_ana_log(ctrl);
>   }
>   
> -void nvme_mpath_update(struct nvme_ctrl *ctrl)
> -{
> -	u32 nr_change_groups = 0;
> -
> -	mutex_lock(&ctrl->ana_lock);
> -	nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
> -	mutex_unlock(&ctrl->ana_lock);
> -}
> -
>   static void nvme_anatt_timeout(struct timer_list *t)
>   {
>   	struct nvme_ctrl *ctrl = from_timer(ctrl, t, anatt_timer);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 76f7a5f37379..1ea908d43e17 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -781,7 +781,6 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
>   void nvme_mpath_remove_disk(struct nvme_ns_head *head);
>   int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
>   void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
> -void nvme_mpath_update(struct nvme_ctrl *ctrl);
>   void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
>   void nvme_mpath_stop(struct nvme_ctrl *ctrl);
>   bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
> @@ -853,9 +852,6 @@ static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
>   "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
>   	return 0;
>   }
> -void nvme_mpath_update(struct nvme_ctrl *ctrl)
> -{
> -}
>   static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>   {
>   }


