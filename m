Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BD4C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=58KLzJX/StsWsXs7an8RsyZ6vgBwJwlkfTPSsD8OVAM=; b=0OKt+49AmytZ/c4lxHQJh1uwwe
	yPpgh8GHUMMTp07JiXMvRKtiCLNvwzs3g0DArY0YuI7kEOFQpcRQf3BFKVADIfiI5Fk1/a8dAxlUt
	uzqIwBSaZaozs0ROT8H2uF/lO4bUZdF7XfIo0MrDZIcIyhhKfRFVgqMCDJo6WpxtPGKobOpwRp8uq
	ij77Zg4Ty5sjvLu1DP/kMQmDDtFYVOzdkgpFTB/Uyw31G8Xtd8aqOCJvCX/ZaykKLHcOfttAke4t7
	y8V5Et0mgsf3n2Sux/Q7QygnvOKgFoPDDf3RvHREB1YsAYfr+W45hpXSjMv1hzS5pJwFkTswWzIPk
	Fk8rFqjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrLJB-002kes-Pk; Wed, 18 May 2022 15:09:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrLJ8-002kdk-L5
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 15:09:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 10EB061958;
 Wed, 18 May 2022 15:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A21C385A9;
 Wed, 18 May 2022 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652886589;
 bh=s+rinMQrErofXSUP8lK2h2lgzImUgAMIrF+JtLXc4bg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oJzOin2PIDO5P5y93O0i9e4I082/fAFqmPmdBTvWuD959Hu75nMbKtSnp2rSONyDp
 eyyHJkVdy5tLIZp0oRteEfLwqJfvM7Uw+C0T+TGNdYi/zUXaER9lhKm/qC3Iqb7eDG
 8gpoz6rOIwfmqRfVNKndxTws7GdnNwizRcnbgYEhE8ARkiWBGpXCnry0AOkPxk9Aeh
 hGv/gHakwm1fN/2ZhVtSmrd2henOd1I5T2+QDGTwXpUcX2XWzwItUdJBpUiEQ1Dzxr
 FPILwpaOtf+8UyoHRjm4CjBZuvXv0lyHDJWhhz0xh7vACI4PGOvypIpXxI3bHwTolF
 0ssOXPshenmdA==
Date: Wed, 18 May 2022 09:09:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: add support for TP4084 - Time-to-Ready Enhancements
Message-ID: <YoUMOvCiztZsE/04@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518064040.3223894-1-hch@lst.de>
 <YoUEf5nsyhVzeDH/@kbusch-mbp.dhcp.thefacebook.com>
 <20220518150044.GA1359@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518150044.GA1359@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_080950_811905_73179966 
X-CRM114-Status: GOOD (  39.99  )
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

On Wed, May 18, 2022 at 05:00:44PM +0200, Christoph Hellwig wrote:
> Yeah.  So we could do something like this instead, which even avoids
> the new member in struct nvme_ctrl:

Nice, the below patch looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> ---
> From 032b8a803bf5bec4c4f206d9cc5a4b1160e0dc69 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 16 May 2022 15:09:21 +0200
> Subject: nvme: add support for TP4084 - Time-to-Ready Enhancements
> 
> Add support for using longer timeouts during controller initialization
> and letting the controller come up with namespaces that are not ready
> for I/O yet.  We skip these not ready namespaces during scanning and
> only bring them online once anoter scan is kicked off by the AEN that
> is set when the NRDY bit gets set in the  I/O Command Set Independent
> Identify Namespace Data Structure.   This asynchronous probing avoids
> blocking the kernel boot when controllers take a very long time to
> recover after unclean shutdowns (up to minutes).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/constants.c |  1 +
>  drivers/nvme/host/core.c      | 76 ++++++++++++++++++++++++++++++++---
>  include/linux/nvme.h          | 31 ++++++++++++++
>  3 files changed, 102 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> index 1dd1d78de2956..4910543f00ff9 100644
> --- a/drivers/nvme/host/constants.c
> +++ b/drivers/nvme/host/constants.c
> @@ -91,6 +91,7 @@ static const char * const nvme_statuses[] = {
>  	[NVME_SC_NS_WRITE_PROTECTED] = "Namespace is Write Protected",
>  	[NVME_SC_CMD_INTERRUPTED] = "Command Interrupted",
>  	[NVME_SC_TRANSIENT_TR_ERR] = "Transient Transport Error",
> +	[NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY] = "Admin Command Media Not Ready",
>  	[NVME_SC_INVALID_IO_CMD_SET] = "Invalid IO Command Set",
>  	[NVME_SC_LBA_RANGE] = "LBA Out of Range",
>  	[NVME_SC_CAP_EXCEEDED] = "Capacity Exceeded",
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 42f9772abc4d0..faeb032719134 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1427,6 +1427,32 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  	return error;
>  }
>  
> +static int nvme_identify_ns_cs_indep(struct nvme_ctrl *ctrl, unsigned nsid,
> +			struct nvme_id_ns_cs_indep **id)
> +{
> +	struct nvme_command c = {
> +		.identify.opcode	= nvme_admin_identify,
> +		.identify.nsid		= cpu_to_le32(nsid),
> +		.identify.cns		= NVME_ID_CNS_NS_CS_INDEP,
> +	};
> +	int ret;
> +
> +	*id = kmalloc(sizeof(**id), GFP_KERNEL);
> +	if (!*id)
> +		return -ENOMEM;
> +
> +	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "Identify namespace (CS independent) failed (%d)\n",
> +			 ret);
> +		kfree(*id);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
>  		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
>  {
> @@ -2103,10 +2129,9 @@ static const struct block_device_operations nvme_bdev_ops = {
>  	.pr_ops		= &nvme_pr_ops,
>  };
>  
> -static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
> +static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 timeout, bool enabled)
>  {
> -	unsigned long timeout =
> -		((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
> +	unsigned long timeout_jiffies = ((timeout + 1) * HZ / 2) + jiffies;
>  	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
>  	int ret;
>  
> @@ -2119,7 +2144,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
>  		usleep_range(1000, 2000);
>  		if (fatal_signal_pending(current))
>  			return -EINTR;
> -		if (time_after(jiffies, timeout)) {
> +		if (time_after(jiffies, timeout_jiffies)) {
>  			dev_err(ctrl->device,
>  				"Device not ready; aborting %s, CSTS=0x%x\n",
>  				enabled ? "initialisation" : "reset", csts);
> @@ -2150,13 +2175,14 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
>  	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
>  		msleep(NVME_QUIRK_DELAY_AMOUNT);
>  
> -	return nvme_wait_ready(ctrl, ctrl->cap, false);
> +	return nvme_wait_ready(ctrl, NVME_CAP_TIMEOUT(ctrl->cap), false);
>  }
>  EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>  
>  int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	unsigned dev_page_min;
> +	u32 timeout;
>  	int ret;
>  
>  	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
> @@ -2177,6 +2203,27 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  		ctrl->ctrl_config = NVME_CC_CSS_CSI;
>  	else
>  		ctrl->ctrl_config = NVME_CC_CSS_NVM;
> +
> +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
> +		u32 crto;
> +
> +		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
> +		if (ret) {
> +			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
> +			ctrl->ctrl_config |= NVME_CC_CRIME;
> +			timeout = NVME_CRTO_CRIMT(crto);
> +		} else {
> +			timeout = NVME_CRTO_CRWMT(crto);
> +		}
> +	} else {
> +		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
> +	}
> +
>  	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
>  	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
>  	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
> @@ -2185,7 +2232,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
>  	if (ret)
>  		return ret;
> -	return nvme_wait_ready(ctrl, ctrl->cap, true);
> +	return nvme_wait_ready(ctrl, timeout, true);
>  }
>  EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
>  
> @@ -4092,11 +4139,26 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>  static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
>  	struct nvme_ns_ids ids = { };
> +	struct nvme_id_ns_cs_indep *id;
>  	struct nvme_ns *ns;
> +	bool ready = true;
>  
>  	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
>  		return;
>  
> +	/*
> +	 * Check if the namespace is ready.  If not ignore it, we will get an
> +	 * AEN once it becomes ready and restart the scan.
> +	 */
> +	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) &&
> +	    !nvme_identify_ns_cs_indep(ctrl, nsid, &id)) {
> +		ready = id->nstat & NVME_NSTAT_NRDY;
> +		kfree(id);
> +	}
> +
> +	if (!ready)
> +		return;
> +
>  	ns = nvme_find_get_ns(ctrl, nsid);
>  	if (ns) {
>  		nvme_validate_ns(ns, &ids);
> @@ -4841,6 +4903,8 @@ static inline void _nvme_check_size(void)
>  	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
> +	BUILD_BUG_ON(sizeof(struct nvme_id_ns_cs_indep) !=
> +			NVME_IDENTIFY_DATA_SIZE);
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ns_zns) != NVME_IDENTIFY_DATA_SIZE);
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ns_nvm) != NVME_IDENTIFY_DATA_SIZE);
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_zns) != NVME_IDENTIFY_DATA_SIZE);
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 5f6d432fa06a6..29ec3e3481ff6 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -137,6 +137,7 @@ enum {
>  	NVME_REG_CMBMSC = 0x0050,	/* Controller Memory Buffer Memory
>  					 * Space Control
>  					 */
> +	NVME_REG_CRTO	= 0x0068,	/* Controller Ready Timeouts */
>  	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
>  	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
>  	NVME_REG_PMRSTS	= 0x0e08,	/* Persistent Memory Region Status */
> @@ -161,6 +162,9 @@ enum {
>  #define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
>  #define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
>  
> +#define NVME_CRTO_CRIMT(crto)	((crto) >> 16)
> +#define NVME_CRTO_CRWMT(crto)	((crto) & 0xffff)
> +
>  enum {
>  	NVME_CMBSZ_SQS		= 1 << 0,
>  	NVME_CMBSZ_CQS		= 1 << 1,
> @@ -204,6 +208,7 @@ enum {
>  	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
>  	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
>  	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
> +	NVME_CC_CRIME		= 1 << 24,
>  };
>  
>  enum {
> @@ -227,6 +232,11 @@ enum {
>  	NVME_CAP_CSS_CSI	= 1 << 6,
>  };
>  
> +enum {
> +	NVME_CAP_CRMS_CRIMS	= 1ULL << 59,
> +	NVME_CAP_CRMS_CRWMS	= 1ULL << 60,
> +};
> +
>  struct nvme_id_power_state {
>  	__le16			max_power;	/* centiwatts */
>  	__u8			rsvd2;
> @@ -414,6 +424,21 @@ struct nvme_id_ns {
>  	__u8			vs[3712];
>  };
>  
> +/* I/O Command Set Independent Identify Namespace Data Structure */
> +struct nvme_id_ns_cs_indep {
> +	__u8			nsfeat;
> +	__u8			nmic;
> +	__u8			rescap;
> +	__u8			fpi;
> +	__le32			anagrpid;
> +	__u8			nsattr;
> +	__u8			rsvd9;
> +	__le16			nvmsetid;
> +	__le16			endgid;
> +	__u8			nstat;
> +	__u8			rsvd15[4081];
> +};
> +
>  struct nvme_zns_lbafe {
>  	__le64			zsze;
>  	__u8			zdes;
> @@ -478,6 +503,7 @@ enum {
>  	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
>  	NVME_ID_CNS_CS_NS		= 0x05,
>  	NVME_ID_CNS_CS_CTRL		= 0x06,
> +	NVME_ID_CNS_NS_CS_INDEP		= 0x08,
>  	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
>  	NVME_ID_CNS_NS_PRESENT		= 0x11,
>  	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
> @@ -531,6 +557,10 @@ enum {
>  	NVME_NS_DPS_PI_TYPE3	= 3,
>  };
>  
> +enum {
> +	NVME_NSTAT_NRDY		= 1 << 0,
> +};
> +
>  enum {
>  	NVME_NVM_NS_16B_GUARD	= 0,
>  	NVME_NVM_NS_32B_GUARD	= 1,
> @@ -1592,6 +1622,7 @@ enum {
>  	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
>  	NVME_SC_CMD_INTERRUPTED		= 0x21,
>  	NVME_SC_TRANSIENT_TR_ERR	= 0x22,
> +	NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY = 0x24,
>  	NVME_SC_INVALID_IO_CMD_SET	= 0x2C,
>  
>  	NVME_SC_LBA_RANGE		= 0x80,
> -- 
> 2.30.2
> 

