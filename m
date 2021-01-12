Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEBEC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 07:48:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4615222DD3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 07:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4615222DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kBphZu2LTDePVb/l3vuRvNQjhGt5mlYn7tWYsxd1ZFk=; b=pFrUKt92RuEZbuMxC+EfTINYu
	UTrxixhsFJ7sr/acpkhKABFkfY0rJZt9T0pAxl6z52rLG+5ejE2aPwsZU0m7dHL5AYuhympYQ14OB
	dZN5ptzJCBpgBEdipVmZkngtiqBYkk+ooVwrgjycfNvlDk/SxxfqqSS+S++DwqjQDAK9aZsrBFCZm
	ldpQiJuZOcRt0i3XRvFrylg9y29JDyYihQy/9y1a8dvdfnnhQZHl5nuRnv4rz9xL4v+5klzwok/Tp
	CfhNjEX4bQfCeEBx/TjTD4EWfb0fNylXY8f5DuxmCcs62EsDflbFvx1zt8Izje3gI3RGKdNC9hGE1
	rWC8Y/h3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzEPS-0006gC-It; Tue, 12 Jan 2021 07:48:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzEPP-0006eo-UQ
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 07:48:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 932E367373; Tue, 12 Jan 2021 08:48:05 +0100 (CET)
Date: Tue, 12 Jan 2021 08:48:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Message-ID: <20210112074805.GA24443@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_024808_218053_F9A0984D 
X-CRM114-Status: GOOD (  20.66  )
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
Cc: linux-block@vger.kernel.org, damien.lemoal@wdc.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index a50b7bcac67a..bdf09d8faa48 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -191,6 +191,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
>  		log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
>  		log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
>  		break;
> +	case NVME_CSI_ZNS:
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			u32 *iocs = log->iocs;
> +
> +			iocs[nvme_cmd_zone_append]	= cpu_to_le32(1 << 0);
> +			iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
> +			iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
> +		}
> +		break;

We need to return errors if the command set is not actually supported.
I also think splitting this into one helper per command set would
be nice.

> @@ -644,6 +653,17 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
>  	if (status)
>  		goto out;
>  
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +		u16 nvme_cis_zns = NVME_CSI_ZNS;
> +
> +		if (req->ns->csi == NVME_CSI_ZNS)
> +			status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
> +							  NVME_NIDT_CSI_LEN,
> +							  &nvme_cis_zns, &off);
> +		if (status)
> +			goto out;
> +	}

We need to add the CSI for every namespace, i.e. something like:

	status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
					  &req->ns->csi);		
	if (status)
		goto out;

and this hunk needs to go into the CSI patch.

>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
>  			off) != NVME_IDENTIFY_DATA_SIZE - off)
>  		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> @@ -660,8 +680,16 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>  	switch (req->cmd->identify.cns) {
>  	case NVME_ID_CNS_NS:
>  		return nvmet_execute_identify_ns(req);
> +	case NVME_ID_CNS_CS_NS:
> +		if (req->cmd->identify.csi == NVME_CSI_ZNS)
> +			return nvmet_execute_identify_cns_cs_ns(req);
> +		break;
>  	case NVME_ID_CNS_CTRL:
>  		return nvmet_execute_identify_ctrl(req);
> +	case NVME_ID_CNS_CS_CTRL:
> +		if (req->cmd->identify.csi == NVME_CSI_ZNS)
> +			return nvmet_execute_identify_cns_cs_ctrl(req);
> +		break;

How does the CSI get mirrored into the cns field?

> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 672e4009f8d6..17d5da062a5a 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1107,6 +1107,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
>  static inline bool nvmet_cc_css_check(u8 cc_css)
>  {
>  	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
> +	case NVME_CC_CSS_CSI:
>  	case NVME_CC_CSS_NVM:
>  		return true;
>  	default:
> @@ -1173,6 +1174,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>  {
>  	/* command sets supported: NVMe command set: */
>  	ctrl->cap = (1ULL << 37);
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		ctrl->cap |= (1ULL << 43);
>  	/* CC.EN timeout in 500msec units: */
>  	ctrl->cap |= (15ULL << 24);
>  	/* maximum queue entries supported: */

This needs to go into a separate patch for multiple command set support.
We can probably merge the CAP and CC bits with the CSI support, though.

> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {

bdev_is_zoned should be probably stubbed out for !CONFIG_BLK_DEV_ZONED
these days.

> +/*
> + *  ZNS related command implementation and helpers.
> + */

Well, that is the description of the whole file, isn't it?  I don't think
this comment adds much value.

> +	/*
> +	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
> +	 * to the device physical block size. So use this value as the logical
> +	 * block size to avoid errors.
> +	 */

I do not understand the logic here, given that NVMe does not have
conventional zones.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
