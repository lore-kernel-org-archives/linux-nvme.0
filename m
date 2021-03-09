Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF7FC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 11:38:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46565651D1
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 11:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46565651D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BIVxzVJ/cVIBuE9mX12tcjhl3n7pwGPjFz6iJvv0Dfs=; b=XwAeCSMGKPDeSJ67N0fcjiBWZ
	jhWbFflHdzWI1ANzVriedRIDR/wGuEylKM1JEsXE7RCZx+8x3VXpInnSIoWs9al/QoOHHzNODuSuY
	Blrt+NYhPVm8WNQVqh0qscmqLuNwOf/9q6ENNz/q9GoRfYHtMb2f0WVx4a1RPMnY1Fpixr9Sq8NOD
	+Ds1krl7KOrYWzXQPYcv809w7c/E4XBrsIzBeZ8KC9orY4n7vuLgkJG94hgMIahIbljrfR+4pgoLt
	ISHZzSauhscq2MS5ukUl+1XYLMswSEHcjL3QD0kyIrXK8MeuWASxF2oacXwDbK6GOQ9B9bvxrJhGL
	JBAVnlBgw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJagW-004LKT-Lm; Tue, 09 Mar 2021 11:37:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJagO-004LJb-Do
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 11:37:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8900B68B05; Tue,  9 Mar 2021 12:37:46 +0100 (CET)
Date: Tue, 9 Mar 2021 12:37:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V10 2/8] nvmet: add NVM Command Set Identifier support
Message-ID: <20210309113746.GB9520@lst.de>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309045823.18545-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_113748_611272_72D13725 
X-CRM114-Status: GOOD (  17.29  )
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

> +static void nvmet_set_csi_nvm_effects(struct nvme_effects_log *log)
>  {
>  	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
>  	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
>  	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
> @@ -184,8 +177,45 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
>  	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
>  	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
>  	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
> +}
>  
> +static u16 nvmet_set_csi_zns_effects(struct nvme_effects_log *log)
> +{
> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		return NVME_SC_INVALID_IO_CMD_SET;

I'd move this check into the caller.

> +	switch (req->cmd->get_log_page.csi) {
> +	case NVME_CSI_NVM:
> +		nvmet_set_csi_nvm_effects(log);
> +		break;
> +	case NVME_CSI_ZNS:
> +		status = nvmet_set_csi_zns_effects(log);
> +		break;

ZNS also needs a call to nvmet_set_csi_nvm_effects as it also supports
the the NVM commands.  But more importantly the ZNS case does not
belong into this patch at all, but into one that actually adds ZNS
support.  CSI support is just infrastructure not tied to a new command
set.  Same for all the other places referencing ZNS in this patch.


> +	default:
> +		status = NVME_SC_INVALID_LOG_PAGE;
> +		break;
> +	}
> +
> +	if (status == NVME_SC_SUCCESS)
> +		status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));

Also I'd use a goto for the failure case instead of the check here.
the 

> +	switch (req->ns->csi) {
> +	case NVME_CSI_NVM:
> +		status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, o);
> +		break;
> +	case NVME_CSI_ZNS:
> +		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +			return NVME_SC_INVALID_IO_CMD_SET;
> +
> +		status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, o);
> +		break;
> +	default:
> +		status = NVME_SC_INVALID_IO_CMD_SET;
> +	}
> +
> +	return status;

Just return directly from inside the switch statement to simplify this
a bit.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
