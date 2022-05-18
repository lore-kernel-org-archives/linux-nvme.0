Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B993C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 08:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lRWBUId3r4DmkmBcWAWKVD4n7ZBmHRxsqMPGc/IR8zs=; b=BqWccO2gL+lkvqikigXPhW8OjJ
	JFLQJbkVf6miGGr7FmV2acF1d6YfGW7wG1uAlG48HHVi3lXdyMRsbxqBvthkvb0T7bw+TVAPK83IR
	jmd3eLthIxLy5STTcDCJgvVrDp59UwrKyQeUfXr6QrudY+gmp3AivnUOyhvb9SEWhTbIu1R59sJhE
	8G8uERqegMV7d4YaOkyGHvuMTkrBhKjrNquFlJIl9SXH8sH9txyB0oUJh97YcKCSvSKpCPHPhcSyF
	xALnRMbvvJVD6NZtJmi2ZNXS6VOQIKaLl1HdXDrh+Myw55V8c4Ofth1FiCTUvTLY2haB4V2P/LxoN
	PEAkUJ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrFTW-000gsp-9A; Wed, 18 May 2022 08:56:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrFTT-000gri-CM
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 08:56:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 78DB168AFE; Wed, 18 May 2022 10:56:03 +0200 (CEST)
Date: Wed, 18 May 2022 10:56:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 james.smart@broadcom.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme: set non-mdts limits in nvme_scan_work
Message-ID: <20220518085602.GA8066@lst.de>
References: <20220518064944.4228-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518064944.4228-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_015607_757016_842BC9D5 
X-CRM114-Status: GOOD (  28.28  )
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

This re-reads the limits everytime a namespace is added or deleted,
is that really such a good idea?

On Tue, May 17, 2022 at 11:49:44PM -0700, Chaitanya Kulkarni wrote:
> In current implementation we set the non-mdts limits by calling
> nvme_init_non_mdts_limits() from nvme_init_ctrl_finish().
> This also tries to set the limits for the discovery controller which
> has no I/O queues resulting in the warning message reported by the
> nvme_log_error() when running blktest nvme/002: -
> 
> [ 2005.155946] run blktests nvme/002 at 2022-04-09 16:57:47
> [ 2005.192223] loop: module loaded
> [ 2005.196429] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
> [ 2005.200334] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> 
> <------------------------------SNIP---------------------------------->
> 
> [ 2008.958108] nvmet: adding nsid 1 to subsystem blktests-subsystem-997
> [ 2008.962082] nvmet: adding nsid 1 to subsystem blktests-subsystem-998
> [ 2008.966102] nvmet: adding nsid 1 to subsystem blktests-subsystem-999
> [ 2008.973132] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
> *[ 2008.973196] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR*
> [ 2008.974595] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
> [ 2009.103248] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> 
> Move the call of nvme_init_non_mdts_limits() to nvme_scan_work() after
> we verify that I/O queues are created since that is a converging point
> for each transport where these limits are actually used.
> 
> 1. FC :
> nvme_fc_create_association()
>  ...
>  nvme_fc_create_io_queues()
>  ...
>  nvme_start_ctrl()
>   nvme_scan_queue()
>    nvme_scan_work()
> 
> 2. PCIe:-
> nvme_reset_work()
>  ...
>  nvme_setup_io_queues()
>   nvme_create_io_queues()
>    nvme_alloc_queue()
>  ...
>  nvme_start_ctrl()
>   nvme_scan_queue()
>    nvme_scan_work()
> 
> 3. RDMA :-
> nvme_rdma_setup_ctrl()
>  ...
>  nvme_rdma_configure_io_queues()
>  ...
>  nvme_start_ctrl()
>   nvme_scan_queue()
>    nvme_scan_work()
> 
> 4. TCP :-
> nvme_tcp_setup_ctrl()
>  ...
>  nvme_tcp_configure_io_queues()
>  ...
>  nvme_start_ctrl()
>   nvme_scan_queue()
>    nvme_scan_work()
> 
> * nvme_scan_work()
> ...
> nvme_validate_or_alloc_ns()
>   nvme_alloc_ns()
>    nvme_update_ns_info()
>     nvme_update_disk_info()
>      nvme_config_discard() <---
>      blk_queue_max_write_zeroes_sectors() <---
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> * changes from V1:-
> 
> 1. Instead of duplicating the call for nvme_init_non_mdts_limits()
>    move it to the nvme_scan_work().
> 
> ---
>  drivers/nvme/host/core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 42f9772abc4d..8cbd70606f09 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3082,10 +3082,6 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>  	if (ret)
>  		return ret;
>  
> -	ret = nvme_init_non_mdts_limits(ctrl);
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = nvme_configure_apst(ctrl);
>  	if (ret < 0)
>  		return ret;
> @@ -4239,11 +4235,19 @@ static void nvme_scan_work(struct work_struct *work)
>  {
>  	struct nvme_ctrl *ctrl =
>  		container_of(work, struct nvme_ctrl, scan_work);
> +	int ret;
>  
>  	/* No tagset on a live ctrl means IO queues could not created */
>  	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
>  		return;
>  
> +	ret = nvme_init_non_mdts_limits(ctrl);
> +	if (ret < 0) {
> +		dev_warn(ctrl->device,
> +			"reading non-mdts-limits failed: %d\n", ret);
> +		return;
> +	}
> +
>  	if (test_and_clear_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
>  		dev_info(ctrl->device, "rescanning namespaces.\n");
>  		nvme_clear_changed_ns_log(ctrl);
> -- 
> 2.29.0
---end quoted text---

