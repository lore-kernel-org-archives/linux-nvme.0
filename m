Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B83C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:34:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A7C20899
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wYWFV/I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A7C20899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b744ZBrY/EO+HS3Wts/oI1AauDg7mbH3LUOP7t+66LQ=; b=wYWFV/I7XT8icOqtcujw8A9Qs
	fTZqDePDOKuuym0iaiWtDbyF/92EWkdNiEkNcrzHn85yvpahE6T1dZKUW7nZRKkABM4t8WyTxw7lF
	vdr0+8JkpRKtSd4GC7qePUog39IeZJs/yKWUfO8TCsTtJGKquzyUc89jwOg8LTvirDD4z2A4jSidO
	lnluxWqrB0iItgUhCRLl4qGvFxP+SapGf8T7Rkobr3k3AV++6RLOwlAZnTvnQcmVbypEQTE0rV8a5
	AfC55Hlo9RTDL5notts347jTG3nfG0QYlsGf7AGDOU4IH4ia7xFSdLfWiMsvMWz+RuGjzuWwzP7ex
	LQYKZhrag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnyzC-0007NS-F1; Wed, 24 Jun 2020 06:34:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnyzA-0007NA-H2
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:34:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 214FC68AEF; Wed, 24 Jun 2020 08:34:14 +0200 (CEST)
Date: Wed, 24 Jun 2020 08:34:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 for-5.8-rc 2/6] nvme-multipath: fix deadlock between
 ana_work and scan_work
Message-ID: <20200624063413.GB17594@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624001853.5408-3-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 05:18:49PM -0700, Sagi Grimberg wrote:
> From: Anton Eidelman <anton@lightbitslabs.com>
> 
> When scan_work calls nvme_mpath_add_disk() this holds ana_lock
> and invokes nvme_parse_ana_log(), which may issue IO
> in device_add_disk() and hang waiting for an accessible path.
> While nvme_mpath_set_live() only called when nvme_state_is_live(),
> a transition may cause NVME_SC_ANA_TRANSITION and requeue the IO.
> 
> In order to recover and complete the IO ana_work on the same ctrl
> should be able to update the path state and remove NVME_NS_ANA_PENDING.
> 
> The deadlock occurs because scan_work keeps holding ana_lock,
> so ana_work hangs [1].
> 
> Fix:
> Now nvme_mpath_add_disk() uses nvme_parse_ana_log() to obtain a copy
> of the ANA group desc, and then calls nvme_update_ns_ana_state() without
> holding ana_lock.
> 
> [1]:
> kernel: Workqueue: nvme-wq nvme_scan_work [nvme_core]
> kernel: Call Trace:
> kernel:  __schedule+0x2b9/0x6c0
> kernel:  schedule+0x42/0xb0
> kernel:  io_schedule+0x16/0x40
> kernel:  do_read_cache_page+0x438/0x830
> kernel:  read_cache_page+0x12/0x20
> kernel:  read_dev_sector+0x27/0xc0
> kernel:  read_lba+0xc1/0x220
> kernel:  efi_partition+0x1e6/0x708
> kernel:  check_partition+0x154/0x244
> kernel:  rescan_partitions+0xae/0x280
> kernel:  __blkdev_get+0x40f/0x560
> kernel:  blkdev_get+0x3d/0x140
> kernel:  __device_add_disk+0x388/0x480
> kernel:  device_add_disk+0x13/0x20
> kernel:  nvme_mpath_set_live+0x119/0x140 [nvme_core]
> kernel:  nvme_update_ns_ana_state+0x5c/0x60 [nvme_core]
> kernel:  nvme_set_ns_ana_state+0x1e/0x30 [nvme_core]
> kernel:  nvme_parse_ana_log+0xa1/0x180 [nvme_core]
> kernel:  nvme_mpath_add_disk+0x47/0x90 [nvme_core]
> kernel:  nvme_validate_ns+0x396/0x940 [nvme_core]
> kernel:  nvme_scan_work+0x24f/0x380 [nvme_core]
> kernel:  process_one_work+0x1db/0x380
> kernel:  worker_thread+0x249/0x400
> kernel:  kthread+0x104/0x140
> 
> kernel: Workqueue: nvme-wq nvme_ana_work [nvme_core]
> kernel: Call Trace:
> kernel:  __schedule+0x2b9/0x6c0
> kernel:  schedule+0x42/0xb0
> kernel:  schedule_preempt_disabled+0xe/0x10
> kernel:  __mutex_lock.isra.0+0x182/0x4f0
> kernel:  ? __switch_to_asm+0x34/0x70
> kernel:  ? select_task_rq_fair+0x1aa/0x5c0
> kernel:  ? kvm_sched_clock_read+0x11/0x20
> kernel:  ? sched_clock+0x9/0x10
> kernel:  __mutex_lock_slowpath+0x13/0x20
> kernel:  mutex_lock+0x2e/0x40
> kernel:  nvme_read_ana_log+0x3a/0x100 [nvme_core]
> kernel:  nvme_ana_work+0x15/0x20 [nvme_core]
> kernel:  process_one_work+0x1db/0x380
> kernel:  worker_thread+0x4d/0x400
> kernel:  kthread+0x104/0x140
> kernel:  ? process_one_work+0x380/0x380
> kernel:  ? kthread_park+0x80/0x80
> kernel:  ret_from_fork+0x35/0x40
> 
> Fixes: 0d0b660f214d ("nvme: add ANA support")
> Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/multipath.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index da78e499947a..a646f9eb2e73 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -640,13 +640,13 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
>  }
>  DEVICE_ATTR_RO(ana_state);
>  
> -static int nvme_set_ns_ana_state(struct nvme_ctrl *ctrl,
> +static int nvme_get_ns_ana_state(struct nvme_ctrl *ctrl,
>  		struct nvme_ana_group_desc *desc, void *data)

Maybe this should be called nvme_lookup_ana_group_desc or so given that
it doesn't actually do anything about the state?

>  {
> -	struct nvme_ns *ns = data;
> +	struct nvme_ana_group_desc *dst = data;
>  
> -	if (ns->ana_grpid == le32_to_cpu(desc->grpid)) {
> -		nvme_update_ns_ana_state(desc, ns);
> +	if (desc->grpid == dst->grpid) {
> +		*dst = *desc;
>  		return -ENXIO; /* just break out of the loop */
>  	}

Any maybe doing the early return here would also clarify things:

	if (desc->grpid != dst->grpid)
		return 0;
	*dst = *desc;
	return -ENXIO; /* just break out of the loop */

Otherwise this looks good.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
