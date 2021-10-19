Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926BDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547146128B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 547146128B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hrAZGiil++6PgqtGzm9jtuFMR+uJSgpsIkF3CB6wOM0=; b=lcGY/Mkdjb9XqOh2oDvumIMPjO
	Pm6APt2SmOIs83TupGeRy0O3gXJk5zoQ/3IbJQ8u5rLv5dlYMDuDnOSoKBih8zoGp47KX49/PS/LM
	tKYdD8QcD4MmUfR3h/BzqMxmsPGznX7qI6i5JBI5D8xCaScRtozS9Sx/E8Gep+0lmU3QsDzwDlrLG
	RNER2ZzLKNFA4CUnEzcxXh3ULa08JpOsG7fxWHgTe74BKNDObHstVLPlIRuUeph22+1Cp3hiJQ6v1
	fd9OgRyu5HeYMyZAad64F2dF4DAAimusRjkJRw+hTjvHTivuUH4rqC0G2W13qsxsSpOKoS3Kbtl8u
	0m7DCN8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcoSt-001Gze-9Z; Tue, 19 Oct 2021 12:43:35 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoSo-001Gx1-BJ
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:43:34 +0000
Received: by mail-wr1-f49.google.com with SMTP id i12so47412659wrb.7
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 05:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hrAZGiil++6PgqtGzm9jtuFMR+uJSgpsIkF3CB6wOM0=;
 b=OTviaiMAvab9AkpcsR5i1GuJMstmWHkWUQMHwmbMZyAlGx7rkMePUOGA/BIfOmqDv/
 JbyojtpchB/UoFJINUSFCSjuKxxw9iNq7GQqmFML9jKveu4af77/C/j7gNK2C4f8QpRW
 H5tt0gdzDyz6WTRyzU+obRzpjqSkw+0ZmeMvD5dH5MHPEo8bfLPj2RJWlF3zILV2f5vM
 2lKlT+H+JtJOARnHwDQouoU54seh8N399Gekqh5n/wRDI4YEYVeQUg2kd5WeLkcuBWdJ
 8HqPik6DoO/3kg85J1v5U5L2QLHdfwyeyPerFTRdAZOpysj/ZB3ChtEFA8+00nE6pshv
 Qdbg==
X-Gm-Message-State: AOAM533rsz5ZmuJLS55pBpqdUmbdiDr12l6movuPyCATlB8NmAMU8IZp
 S/D2NFD9gQbxsAOSmsjDk4c=
X-Google-Smtp-Source: ABdhPJwCHRyhUwiFWaRLBKOPVgskASc3F3DJd5TWl9cxqAF3eU687g2yZ5V3JmlYYeiocG1wUgDMEg==
X-Received: by 2002:a5d:4b43:: with SMTP id w3mr45051469wrs.404.1634647408963; 
 Tue, 19 Oct 2021 05:43:28 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r27sm14858906wrr.70.2021.10.19.05.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 05:43:28 -0700 (PDT)
Subject: Re: [PATCH 5/7] nvme/nvme-fabrics: introduce nvmf_error_recovery_work
 API
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-6-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f170b07c-0307-eeb4-72d8-196a471b660b@grimberg.me>
Date: Tue, 19 Oct 2021 15:43:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-6-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_054330_486951_B08D20E4 
X-CRM114-Status: GOOD (  28.72  )
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



On 10/18/21 4:40 PM, Max Gurtovoy wrote:
> Error recovery work is duplicated in RDMA and TCP transports. Move this
> logic to common code. For that, introduce 2 new ctrl ops to teardown IO
> and admin queue.
> 
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 23 +++++++++++++++
>   drivers/nvme/host/fabrics.h |  1 +
>   drivers/nvme/host/nvme.h    |  4 +++
>   drivers/nvme/host/rdma.c    | 56 ++++++++++++++++---------------------
>   drivers/nvme/host/tcp.c     | 56 +++++++++++++++----------------------
>   5 files changed, 75 insertions(+), 65 deletions(-)

Diffstat dry stats are not in your favor...

> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 2edd086fa922..544195369c97 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -493,6 +493,29 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
>   
> +void nvmf_error_recovery_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(work,
> +				struct nvme_ctrl, err_work);
> +
> +	nvme_stop_keep_alive(ctrl);
> +	ctrl->ops->teardown_ctrl_io_queues(ctrl);
> +	/* unquiesce to fail fast pending requests */
> +	nvme_start_queues(ctrl);
> +	ctrl->ops->teardown_ctrl_admin_queue(ctrl);
> +	blk_mq_unquiesce_queue(ctrl->admin_q);
> +
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> +		/* state change failure is ok if we started ctrl delete */
> +		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
> +			     ctrl->state != NVME_CTRL_DELETING_NOIO);
> +		return;
> +	}
> +
> +	nvmf_reconnect_or_remove(ctrl);

We need James to provide feedback how can this be useful for FC.

> +}
> +EXPORT_SYMBOL_GPL(nvmf_error_recovery_work);
> +
>   void nvmf_error_recovery(struct nvme_ctrl *ctrl)
>   {
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 3d8ec7133fc8..8655eff74ed0 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -190,6 +190,7 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>   void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
>   void nvmf_error_recovery(struct nvme_ctrl *ctrl);
> +void nvmf_error_recovery_work(struct work_struct *work);
>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		struct nvmf_ctrl_options *opts);
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f9e1ce93d61d..1573edf6e97f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -493,6 +493,10 @@ struct nvme_ctrl_ops {
>   	void (*submit_async_event)(struct nvme_ctrl *ctrl);
>   	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
>   	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> +
> +	/* Fabrics only */
> +	void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl);
> +	void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl);

This becomes strange that we have teardown without a setup callback...

>   };
>   
>   /*
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 1c57e371af61..f4e4ebf673d2 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1031,6 +1031,11 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   	nvme_rdma_destroy_admin_queue(ctrl, remove);
>   }
>   
> +static void _nvme_rdma_teardown_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	nvme_rdma_teardown_admin_queue(to_rdma_ctrl(ctrl), false);
> +}
> +
>   static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
>   		bool remove)
>   {
> @@ -1046,6 +1051,11 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
>   	}
>   }
>   
> +static void _nvme_rdma_teardown_io_queues(struct nvme_ctrl *ctrl)
> +{
> +	nvme_rdma_teardown_io_queues(to_rdma_ctrl(ctrl), false);
> +}
> +
>   static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
>   {
>   	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
> @@ -1164,27 +1174,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
>   	nvmf_reconnect_or_remove(&ctrl->ctrl);
>   }
>   
> -static void nvme_rdma_error_recovery_work(struct work_struct *work)
> -{
> -	struct nvme_rdma_ctrl *ctrl = container_of(work,
> -			struct nvme_rdma_ctrl, ctrl.err_work);
> -
> -	nvme_stop_keep_alive(&ctrl->ctrl);
> -	nvme_rdma_teardown_io_queues(ctrl, false);
> -	nvme_start_queues(&ctrl->ctrl);
> -	nvme_rdma_teardown_admin_queue(ctrl, false);
> -	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> -
> -	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
> -		/* state change failure is ok if we started ctrl delete */
> -		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
> -			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
> -		return;
> -	}
> -
> -	nvmf_reconnect_or_remove(&ctrl->ctrl);
> -}
> -
>   static void nvme_rdma_end_request(struct nvme_rdma_request *req)
>   {
>   	struct request *rq = blk_mq_rq_from_pdu(req);
> @@ -2240,16 +2229,19 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
>   }
>   
>   static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
> -	.name			= "rdma",
> -	.module			= THIS_MODULE,
> -	.flags			= NVME_F_FABRICS | NVME_F_METADATA_SUPPORTED,
> -	.reg_read32		= nvmf_reg_read32,
> -	.reg_read64		= nvmf_reg_read64,
> -	.reg_write32		= nvmf_reg_write32,
> -	.free_ctrl		= nvme_rdma_free_ctrl,
> -	.submit_async_event	= nvme_rdma_submit_async_event,
> -	.delete_ctrl		= nvme_rdma_delete_ctrl,
> -	.get_address		= nvmf_get_address,
> +	.name				= "rdma",
> +	.module				= THIS_MODULE,
> +	.flags				= NVME_F_FABRICS |
> +					  NVME_F_METADATA_SUPPORTED,
> +	.reg_read32			= nvmf_reg_read32,
> +	.reg_read64			= nvmf_reg_read64,
> +	.reg_write32			= nvmf_reg_write32,
> +	.free_ctrl			= nvme_rdma_free_ctrl,
> +	.submit_async_event		= nvme_rdma_submit_async_event,
> +	.delete_ctrl			= nvme_rdma_delete_ctrl,
> +	.get_address			= nvmf_get_address,
> +	.teardown_ctrl_io_queues	= _nvme_rdma_teardown_io_queues,
> +	.teardown_ctrl_admin_queue	= _nvme_rdma_teardown_admin_queue,
>   };
>   
>   /*
> @@ -2329,7 +2321,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   
>   	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
>   			nvme_rdma_reconnect_ctrl_work);
> -	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
> +	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);

This initialization needs to move to the core or fabrics lib.

