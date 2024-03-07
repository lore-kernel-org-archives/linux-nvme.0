Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405C0C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=81aidK6hysQvqu0dchs98TKsEElaUaObaJdSauwe65s=; b=Ro/ZPIVYGq/ZHBeyGhrxJ/l1C3
	WzoiInK3zL/NowkGYzpmXmxQFpAmkBJzfDdGutgGs9FrqlwTztJ3MOTM8L6afoc5CGGegM2oGnccq
	y8V4z18Hj/kWYa7x+3zgcMSMNwPupQY/hxrGZv+yEcTJ45hCQKDT/qUdsk0jGIROios46sNsK5Vg5
	2ObJ1Z1mkmz93GNm0W2lztzcGVO/Jk+SmGzCt4uAUpyReIVQVCHW9GqyHYOulEoWSLQ1cuv/cohN2
	xNz6yk4D3gxHW4czbwmAf7qMNcmMyotVFobPkMWKQdLmPyMJjrbbwbNaDOAp3gofePpx2boQtduhn
	ZRrVmgbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAiI-0000000422b-3ZvV;
	Thu, 07 Mar 2024 10:10:58 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAiF-0000000421M-492p
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:10:57 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412b30be60dso395575e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709806254; x=1710411054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81aidK6hysQvqu0dchs98TKsEElaUaObaJdSauwe65s=;
        b=r4zBAQj3cMUfNYgZXKW4nTw6fMtqS5jzpD121Jy43zEU1riNGzF638ySzTSSo9jKAv
         oNshUGF8BfeZUclNDs20K/3XkLO+WXKepnFUx+yCKEEXPMhe790l1grqhrEXW5JBJFaP
         3qXmZqwRbvnGJcjsuuNCMhGZhjynJBYPM5NSPwFPSyx4Cem58QeggGBvOJreJMZ53B7P
         BHkeFnDmZ9NcZ3do3QBFLWv0idD3Ej1PG5EDSRMI60uijhAgXWOAfSgDbCW78EIsXzGB
         Et9J7uoW6z3qULcI37UMuB2TtpMoaodNFZ/pu9Uj/7bRm1fXh5mnUDLCZYlxcotAgCQK
         MT6g==
X-Forwarded-Encrypted: i=1; AJvYcCVAcyAQ09p5VpVDa6DDtwEnV6GwEQis5pyPqHl+Ure3BjK3M8HE4Wo1v4WKYonQcBiO0KuqFgZn2RRoOdefrSw7izqY0PsS6bxC2Lnu+kg=
X-Gm-Message-State: AOJu0YwHWT6RiSRqUkyS32oSvPQ6AJ+cvRLj4rzOKcEFNB/jYOwQail8
	3OPuu9nwEEg6z7bpTFIWJSX61srxQJdxrm7W7b3N0JS3PZy7d/BEMeK3qC18
X-Google-Smtp-Source: AGHT+IEFb9oo0GJ3hnqovB8moUMD3Jfv+ZDlbrJ1kfAFHmniUNwZuk3ZKcYggtWbNnxiPmXnvZjnEw==
X-Received: by 2002:a05:600c:1d2a:b0:412:f887:644f with SMTP id l42-20020a05600c1d2a00b00412f887644fmr1064597wms.0.1709806253907;
        Thu, 07 Mar 2024 02:10:53 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bx5-20020a5d5b05000000b0033e103eaf5bsm20008463wrb.115.2024.03.07.02.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:10:53 -0800 (PST)
Message-ID: <1dfa9a4e-e4a2-4d48-b569-85e48ce4311c@grimberg.me>
Date: Thu, 7 Mar 2024 12:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-fc: FPIN link integrity handling
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
References: <20240219085929.31255-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240219085929.31255-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_021056_201838_B6078C5F 
X-CRM114-Status: GOOD (  34.62  )
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



On 19/02/2024 10:59, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> FPIN LI (link integrity) messages are received when the attached
> fabric detects hardware errors. In response to these messages the
> affected ports should not be used for I/O, and only put back into
> service once the ports had been reset as then the hardware might
> have been replaced.

Does this mean it cannot service any type of communication over
the wire?

> This patch adds a new controller flag 'NVME_CTRL_TRANSPORT_BLOCKED'
> which will be checked during multipath path selection, causing the
> path to be skipped.

While this looks sensible to me, it also looks like this introduces a 
ctrl state
outside of ctrl->state... Wouldn't it make sense to move the controller to
NVME_CTRL_DEAD ? or is it not a terminal state?

>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c       |  13 ++--
>   drivers/nvme/host/fc.c         | 108 +++++++++++++++++++++++++++++++++
>   drivers/nvme/host/multipath.c  |   2 +
>   drivers/nvme/host/nvme.h       |   1 +
>   drivers/scsi/lpfc/lpfc_els.c   |   6 +-
>   drivers/scsi/qla2xxx/qla_isr.c |   1 +
>   include/linux/nvme-fc-driver.h |   3 +
>   7 files changed, 129 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index eed3e22e24d9..5e9a0cf43636 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -750,10 +750,14 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
>   
>   	if (state != NVME_CTRL_DELETING_NOIO &&
>   	    state != NVME_CTRL_DELETING &&
> -	    state != NVME_CTRL_DEAD &&
> -	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
> -	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
> -		return BLK_STS_RESOURCE;
> +	    state != NVME_CTRL_DEAD) {
> +		if (!test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
> +		    !blk_noretry_request(rq) &&
> +		    !(rq->cmd_flags & REQ_NVME_MPATH))
> +			return BLK_STS_RESOURCE;
> +		if (test_bit(NVME_CTRL_TRANSPORT_BLOCKED, &ctrl->flags))
> +			return BLK_STS_TRANSPORT;
> +	}
>   	return nvme_host_path_error(rq);
>   }
>   EXPORT_SYMBOL_GPL(nvme_fail_nonready_command);
> @@ -4575,6 +4579,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
>   	ctrl->passthru_err_log_enabled = false;
>   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> +	clear_bit(NVME_CTRL_TRANSPORT_BLOCKED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 5e226728c822..fdf77f5cb944 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -787,6 +787,9 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
>   		"NVME-FC{%d}: controller connectivity lost. Awaiting "
>   		"Reconnect", ctrl->cnum);
>   
> +	/* clear 'transport blocked' flag as controller will be reset */
> +	clear_bit(NVME_CTRL_TRANSPORT_BLOCKED, &ctrl->flags);
> +
>   	switch (nvme_ctrl_state(&ctrl->ctrl)) {
>   	case NVME_CTRL_NEW:
>   	case NVME_CTRL_LIVE:
> @@ -3741,6 +3744,111 @@ static struct nvmf_transport_ops nvme_fc_transport = {
>   	.create_ctrl	= nvme_fc_create_ctrl,
>   };
>   
> +static struct nvme_fc_rport *nvme_fc_rport_from_wwpn(struct nvme_fc_lport *lport,
> +						     u64 rport_wwpn)
> +{
> +	struct nvme_fc_rport *rport;
> +
> +	list_for_each_entry(rport, &lport->endp_list, endp_list) {
> +		if (!nvme_fc_rport_get(rport))
> +			continue;
> +		if (rport->remoteport.port_name == rport_wwpn &&
> +		    rport->remoteport.port_role & FC_PORT_ROLE_NVME_TARGET)
> +			return rport;
> +		nvme_fc_rport_put(rport);
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * nvme_fc_fpin_li_lport_update - routine to update Link Integrity
> + * event statistics.
> + * @lport:		local port the FPIN was received on
> + * @tlv:		pointer to link integrity descriptor
> + *
> + */
> +static void
> +nvme_fc_fpin_li_lport_update(struct nvme_fc_lport *lport, struct fc_tlv_desc *tlv)
> +{
> +	unsigned int i, pname_count;
> +	struct nvme_fc_rport *attached_rport;
> +	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
> +	u64 wwpn;
> +
> +	wwpn = be64_to_cpu(li_desc->attached_wwpn);
> +	attached_rport = nvme_fc_rport_from_wwpn(lport, wwpn);
> +	pname_count = be32_to_cpu(li_desc->pname_count);
> +
> +	for (i = 0; pname_count; i++) {
> +		struct nvme_fc_rport *rport;
> +
> +		wwpn = be64_to_cpu(li_desc->pname_list[i]);
> +		rport = nvme_fc_rport_from_wwpn(lport, wwpn);
> +		if (!rport)
> +			continue;
> +		if (rport != attached_rport) {
> +			struct nvme_fc_ctrl *ctrl;
> +
> +			spin_lock_irq(&rport->lock);
> +			list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list)
> +				set_bit(NVME_CTRL_TRANSPORT_BLOCKED, &ctrl->ctrl.flags);
> +			spin_unlock_irq(&rport->lock);
> +		}
> +		nvme_fc_rport_put(rport);
> +	}
> +	if (attached_rport) {
> +		struct nvme_fc_ctrl *ctrl;
> +
> +		spin_lock_irq(&attached_rport->lock);
> +		list_for_each_entry(ctrl, &attached_rport->ctrl_list, ctrl_list)
> +			set_bit(NVME_CTRL_TRANSPORT_BLOCKED, &ctrl->ctrl.flags);
> +		spin_unlock_irq(&attached_rport->lock);
> +		nvme_fc_rport_put(attached_rport);
> +	}
> +}
> +
> +/**
> + * fc_host_fpin_rcv - routine to process a received FPIN.
> + * @localport:		local port the FPIN was received on
> + * @fpin_len:		length of FPIN payload, in bytes
> + * @fpin_buf:		pointer to FPIN payload
> + * Notes:
> + *	This routine assumes no locks are held on entry.
> + */
> +void
> +nvme_fc_fpin_rcv(struct nvme_fc_local_port *localport,
> +		 u32 fpin_len, char *fpin_buf)
> +{
> +	struct nvme_fc_lport *lport;
> +	struct fc_els_fpin *fpin = (struct fc_els_fpin *)fpin_buf;
> +	struct fc_tlv_desc *tlv;
> +	u32 bytes_remain;
> +	u32 dtag;
> +
> +	if (!localport)
> +		return;
> +	lport = localport_to_lport(localport);
> +	tlv = (struct fc_tlv_desc *)&fpin->fpin_desc[0];
> +	bytes_remain = fpin_len - offsetof(struct fc_els_fpin, fpin_desc);
> +	bytes_remain = min_t(u32, bytes_remain, be32_to_cpu(fpin->desc_len));
> +
> +	while (bytes_remain >= FC_TLV_DESC_HDR_SZ &&
> +	       bytes_remain >= FC_TLV_DESC_SZ_FROM_LENGTH(tlv)) {
> +		dtag = be32_to_cpu(tlv->desc_tag);
> +		switch (dtag) {
> +		case ELS_DTAG_LNK_INTEGRITY:
> +			nvme_fc_fpin_li_lport_update(lport, tlv);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		bytes_remain -= FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
> +		tlv = fc_tlv_next_desc(tlv);
> +	}
> +}
> +EXPORT_SYMBOL(nvme_fc_fpin_rcv);
> +
>   /* Arbitrary successive failures max. With lots of subsystems could be high */
>   #define DISCOVERY_MAX_FAIL	20
>   
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 4a90dad43303..e0dcfe9edb89 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -235,6 +235,8 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
>   	 */
>   	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
>   		return true;
> +	if (test_bit(NVME_CTRL_TRANSPORT_BLOCKED, &ns->ctrl->flags))
> +		return true;
>   	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
>   	    !test_bit(NVME_NS_READY, &ns->flags))
>   		return true;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ee30bb63e36b..6ed2ca6b35e4 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -258,6 +258,7 @@ enum nvme_ctrl_flags {
>   	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
>   	NVME_CTRL_DIRTY_CAPABILITY	= 5,
>   	NVME_CTRL_FROZEN		= 6,
> +	NVME_CTRL_TRANSPORT_BLOCKED	= 7,
>   };
>   
>   struct nvme_ctrl {
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index 4d723200690a..ecfe6bc8ab63 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -33,6 +33,7 @@
>   #include <scsi/scsi_transport_fc.h>
>   #include <uapi/scsi/fc/fc_fs.h>
>   #include <uapi/scsi/fc/fc_els.h>
> +#include <linux/nvme-fc-driver.h>
>   
>   #include "lpfc_hw4.h"
>   #include "lpfc_hw.h"
> @@ -10343,9 +10344,12 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
>   		fpin_length += sizeof(struct fc_els_fpin); /* the entire FPIN */
>   
>   		/* Send every descriptor individually to the upper layer */
> -		if (deliver)
> +		if (deliver) {
>   			fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
>   					 fpin_length, (char *)fpin, 0);
> +			nvme_fc_fpin_rcv(vport->localport,
> +					 fpin_length, (char *)fpin);
> +		}
>   		desc_cnt++;
>   	}
>   }
> diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
> index d48007e18288..b180e10053c5 100644
> --- a/drivers/scsi/qla2xxx/qla_isr.c
> +++ b/drivers/scsi/qla2xxx/qla_isr.c
> @@ -46,6 +46,7 @@ qla27xx_process_purex_fpin(struct scsi_qla_host *vha, struct purex_item *item)
>   		       pkt, pkt_size);
>   
>   	fc_host_fpin_rcv(vha->host, pkt_size, (char *)pkt, 0);
> +	nvme_fc_fpin_rcv(vha->nvme_local_port, pkt_size, (char *)pkt);
>   }
>   
>   const char *const port_state_str[] = {
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 4109f1bd6128..994bc459e6dd 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -536,6 +536,9 @@ void nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport);
>   int nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *remoteport,
>   			u32 dev_loss_tmo);
>   
> +void nvme_fc_fpin_rcv(struct nvme_fc_local_port *localport,
> +		      u32 fpin_len, char *fpin_buf);
> +
>   /*
>    * Routine called to pass a NVME-FC LS request, received by the lldd,
>    * to the nvme-fc transport.


