Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22DEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:41:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5344C60FDA
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5344C60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/L/xAO1kYFp1WkeQpj1KCPXhRLfKvok7Vc5xvNgb4co=; b=T6snhoD9cqoLoNFEFKa1jSoG1X
	f2x3uxZu97Pdzo5PqfpfuIATxAaeQTWQ2P0nPR0CyrdCZ2BZEqZiMkT9gMjkDhHAGwv4kB+CFcEP3
	0O7vibY98F9sqzNSLxLpaOgQmZNMvfqJIPaCvqndEvYSD6A0WrDqfXVzennxdNk0JJBAxOPQkxPqs
	OrmAXbb9VW8ch9nWfOAQeUSv4mrNFQcPzKs5Uifr/uUm7TGj6iHjXZlUVp1S7jYG6kuN6g3DflvwK
	+mHAv6EIsTItD5s04oP6at2fcSkqpchwjLpEIfJzgwVoPtZdvmrNnAxOW3homvuP7XWyILy6BokM6
	kqw3L9XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcpN4-001S1d-Qd; Tue, 19 Oct 2021 13:41:38 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcpN1-001S0i-KV
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 13:41:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 63A0E1FD2D;
 Tue, 19 Oct 2021 13:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634650893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/L/xAO1kYFp1WkeQpj1KCPXhRLfKvok7Vc5xvNgb4co=;
 b=aOJW4fkmRxfq350mVaC1KjZzYo2nPGZwjf+JtmUPpwR3g/xS0uOrLlx3PqQwzY1rjy+1cQ
 nLc1sfZEtAKpbDAViCbi3Xiiiru02lJoxfpRdezsLVVwm7CFJJYJDP0Mqsv39Pm9kNb0iL
 7IDgKfPhGCme9ayHALumRXn5h3mdoPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634650893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/L/xAO1kYFp1WkeQpj1KCPXhRLfKvok7Vc5xvNgb4co=;
 b=Vlh6s6eBbfG+MQhDPYYb29272ZU0FcN3SqD/HXLfw/5XuvGxEAV8bJDM7Bpv5Zd/jqKT3e
 3Y2pflgkL2IBuhDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A1B313E28;
 Tue, 19 Oct 2021 13:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tCfNBg3LbmFkOAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 19 Oct 2021 13:41:33 +0000
Subject: Re: [PATCH 6/7] nvme/nvme-fabrics: introduce nvmf_reconnect_ctrl_work
 API
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-7-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <bd5b02ac-befb-b75d-0e03-371cd2664bef@suse.de>
Date: Tue, 19 Oct 2021 15:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-7-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_064135_852545_F03D9373 
X-CRM114-Status: GOOD (  25.98  )
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

On 10/18/21 3:40 PM, Max Gurtovoy wrote:
> Reconnect work is duplicated in RDMA and TCP transports. Move this logic
> to common code. For that, introduce a new ctrl op to setup a ctrl.
> 
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 24 ++++++++++++++++++++++++
>   drivers/nvme/host/fabrics.h |  1 +
>   drivers/nvme/host/nvme.h    |  1 +
>   drivers/nvme/host/rdma.c    | 26 ++++----------------------
>   drivers/nvme/host/tcp.c     | 27 ++++-----------------------
>   5 files changed, 34 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 544195369c97..7f76b27ce1f2 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -526,6 +526,30 @@ void nvmf_error_recovery(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmf_error_recovery);
>   
> +void nvmf_reconnect_ctrl_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
> +			struct nvme_ctrl, connect_work);
> +
> +	++ctrl->nr_reconnects;
> +
> +	if (ctrl->ops->setup_ctrl(ctrl))
> +		goto requeue;
> +
> +	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
> +			ctrl->nr_reconnects);
> +
> +	ctrl->nr_reconnects = 0;
> +
> +	return;
> +
> +requeue:
> +	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
> +		 ctrl->nr_reconnects);
> +	nvmf_reconnect_or_remove(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvmf_reconnect_ctrl_work);
> +
>   /**
>    * nvmf_register_transport() - NVMe Fabrics Library registration function.
>    * @ops:	Transport ops instance to be registered to the
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 8655eff74ed0..49c98b69647f 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -191,6 +191,7 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>   void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
>   void nvmf_error_recovery(struct nvme_ctrl *ctrl);
>   void nvmf_error_recovery_work(struct work_struct *work);
> +void nvmf_reconnect_ctrl_work(struct work_struct *work);
>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		struct nvmf_ctrl_options *opts);
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1573edf6e97f..9ae9594998c3 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -497,6 +497,7 @@ struct nvme_ctrl_ops {
>   	/* Fabrics only */
>   	void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl);
>   	void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl);
> +	int (*setup_ctrl)(struct nvme_ctrl *ctrl);
>   };
>   
>   /*
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f4e4ebf673d2..7fb2f434fe0d 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1151,27 +1151,9 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>   	return ret;
>   }
>   
> -static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
> +static int _nvme_rdma_setup_ctrl(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
> -			struct nvme_rdma_ctrl, ctrl.connect_work);
> -
> -	++ctrl->ctrl.nr_reconnects;
> -
> -	if (nvme_rdma_setup_ctrl(ctrl, false))
> -		goto requeue;
> -
> -	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
> -			ctrl->ctrl.nr_reconnects);
> -
> -	ctrl->ctrl.nr_reconnects = 0;
> -
> -	return;
> -
> -requeue:
> -	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
> -			ctrl->ctrl.nr_reconnects);
> -	nvmf_reconnect_or_remove(&ctrl->ctrl);
> +	return nvme_rdma_setup_ctrl(to_rdma_ctrl(ctrl), false);
>   }
>   
>   static void nvme_rdma_end_request(struct nvme_rdma_request *req)

Really? Can't we separate nvme_rdma_setup_ctrl() such that we have two 
distinct functions (one for new == true, and one for new == false)?
Or, alternatively, setting up the tagset in nvme_rdma_init_ctrl() and 
kill the 'new' argument altogether?

> @@ -2242,6 +2224,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
>   	.get_address			= nvmf_get_address,
>   	.teardown_ctrl_io_queues	= _nvme_rdma_teardown_io_queues,
>   	.teardown_ctrl_admin_queue	= _nvme_rdma_teardown_admin_queue,
> +	.setup_ctrl			= _nvme_rdma_setup_ctrl,
>   };
>   
>   /*
> @@ -2319,8 +2302,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   		goto out_free_ctrl;
>   	}
>   
> -	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
> -			nvme_rdma_reconnect_ctrl_work);
> +	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvmf_reconnect_ctrl_work);
>   	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
>   
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 14bd16b8d99f..c0e5bb3949b3 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2042,28 +2042,9 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   	return ret;
>   }
>   
> -static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> +static int _nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
> -			struct nvme_tcp_ctrl, ctrl.connect_work);
> -	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> -
> -	++ctrl->nr_reconnects;
> -
> -	if (nvme_tcp_setup_ctrl(ctrl, false))
> -		goto requeue;
> -
> -	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
> -			ctrl->nr_reconnects);
> -
> -	ctrl->nr_reconnects = 0;
> -
> -	return;
> -
> -requeue:
> -	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
> -			ctrl->nr_reconnects);
> -	nvmf_reconnect_or_remove(ctrl);
> +	return nvme_tcp_setup_ctrl(ctrl, false);
>   }
>   Same argument here; I'd rather modify nvme_tcp_setup_ctrl() to drop the 
'new' argument and allowing it to be used as the callback directly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

