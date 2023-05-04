Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773F5C77B78
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yiKXyXVTtPXQ1xjdL6HOrWFym2o+EeKH5BZFS5mnGMo=; b=1apQldzVoasC/vq6/kyJd7tipV
	ECHD1bd2GQKjmloAR31bYboLFbhTEo5dpc+bz0UBRa8uU6mwGoexxJr9Td35XEALPhKT3PDoay1EQ
	RLVoTeQ/LrWtRl9skk1daTbrd98xACsDLqgIdcLFoX3Cf1rDsrPMWbxQrglrFHPXje8sdCc5KTfhL
	VbUVeZpl25nXYelBRpDN7d4bWCJFzHhLq6HlX+ROpMjzBfz8cq+TJGpvBnzQrIqKk5jXtBDwTqRdK
	ug/KmRyWULhts9V2l7WPZFmPnp3AXj6cZjwyTgfwdSTxBQJyR5XJESiZsy0Fllcng//2/1wQKyCU/
	zcNwXIsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puW7x-007P3F-1n;
	Thu, 04 May 2023 10:23:57 +0000
Received: from mail-lj1-f172.google.com ([209.85.208.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puW7t-007P2U-2g
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 10:23:55 +0000
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2a8a4cbe473so667211fa.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 03:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683195830; x=1685787830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yiKXyXVTtPXQ1xjdL6HOrWFym2o+EeKH5BZFS5mnGMo=;
        b=dMINrTlXvi78njRHf1rixioZ9Y/q3KXFTn6EEcH/ukqmJiuen0F3Cd2PZyOsD8+EAH
         ffXg2/Rbpv4G3XZEEmIMuNFyCgKVxzIKTF/wp7U6s0i1QudYEkQeo7Bo1FV+fNeLpbP9
         Anu1J6gfbq2u4okB7V9IOZ8+9lxX4LTU6xAJxcL+xVpHDUFDYkZaUVj5w8HI1nullVmh
         EVIVnoa9nNtnrcZ5jqicybtMyXSrk2u89UD7Mfxb1bfN7F6h7ODf2BN70OVosoI8ICkW
         xp3AuU1IkHUYixMw2lIo9dbYWbpJpOdEhsUsHJ1WbRor6CFNYvoT0c2VGUwErlPxy+F/
         C2pg==
X-Gm-Message-State: AC+VfDx5b6q3SjYM63QyJ3VY3LAt1iwGcHYlu9j2B2iMeIaHh/srKX6Z
	siu4UgJEyi5JAMv8bb0WnQQ=
X-Google-Smtp-Source: ACHHUZ6eT4z8w0yuyYILD5Z4R4bAwpn8DPIRfn5U6FQu0NEOC4b8mDUl3CnDFuo27k8w3LcI+wE2+w==
X-Received: by 2002:a2e:2ac1:0:b0:2ac:8220:5c4a with SMTP id q184-20020a2e2ac1000000b002ac82205c4amr16323ljq.5.1683195830070;
        Thu, 04 May 2023 03:23:50 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id w22-20020a2ea3d6000000b002aa39dd9ad3sm6230775lje.125.2023.05.04.03.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 03:23:49 -0700 (PDT)
Message-ID: <b2a296ca-1d48-3fa3-fddf-78abb0dbaffd@grimberg.me>
Date: Thu, 4 May 2023 13:23:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v3 9/9] nvme: introduce setup_transport()
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>
References: <20230504091259.29100-1-dwagner@suse.de>
 <20230504091259.29100-10-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230504091259.29100-10-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_032353_913146_9CD20A1B 
X-CRM114-Status: GOOD (  27.02  )
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


> Do the tag allocation in the new setup function.
> 
> Nope, this doesn't work because the tag allocation wants to map
> the but we haven't allocated them yet.

Don't think that the tag allocation is what something like
setup_transport should do.

This would be something that the driver would need to do in
the device/platform level perhaps.

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 26 ++++------------
>   drivers/nvme/host/fabrics.h |  5 ++--
>   drivers/nvme/host/rdma.c    | 60 +++++++++++++++++++++----------------
>   drivers/nvme/host/tcp.c     | 31 +++++++++++--------
>   4 files changed, 59 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 5f212cb9421a..06e9cf0c9e84 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1325,12 +1325,6 @@ static int nvmf_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   	if (ret)
>   		return ret;
>   
> -	if (new) {
> -		ret = ctrl->fabrics_ops->alloc_tag_set(ctrl);
> -		if (ret)
> -			goto out_free_io_queues;
> -	}
> -
>   	/*
>   	 * Only start IO queues for which we have allocated the tagset
>   	 * and limitted it to the available queues. On reconnects, the
> @@ -1374,9 +1368,6 @@ static int nvmf_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   	nvmf_stop_io_queues(ctrl);
>   out_cleanup_connect_q:
>   	nvme_cancel_tagset(ctrl);
> -	if (new)
> -		nvme_remove_io_tag_set(ctrl);
> -out_free_io_queues:
>   	nvmf_free_io_queues(ctrl);
>   	return ret;
>   }
> @@ -1389,16 +1380,9 @@ static int nvmf_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>   	if (ret)
>   		return ret;
>   
> -	if (new) {
> -		ret = ctrl->fabrics_ops->alloc_admin_tag_set(ctrl);
> -		if (ret)
> -			goto out_free_admin_queue;
> -
> -	}
> -
>   	ret = __nvmf_start_admin_queue(ctrl);
>   	if (ret)
> -		goto out_remove_admin_tag_set;
> +		goto out_remove_admin_queue;
>   
>   	ret = nvme_enable_ctrl(ctrl);
>   	if (ret)
> @@ -1418,10 +1402,7 @@ static int nvmf_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>   out_stop_queue:
>   	__nvmf_stop_admin_queue(ctrl);
>   	nvme_cancel_admin_tagset(ctrl);
> -out_remove_admin_tag_set:
> -	if (new)
> -		nvme_remove_admin_tag_set(ctrl);
> -out_free_admin_queue:
> +out_remove_admin_queue:
>   	__nvmf_free_admin_queue(ctrl);
>   	return ret;
>   }
> @@ -1489,6 +1470,9 @@ int nvmf_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   	struct nvmf_ctrl_options *opts = ctrl->opts;
>   	int ret;
>   
> +	if (new)
> +		ctrl->fabrics_ops->setup_transport(ctrl);
> +
>   	ret = nvmf_configure_admin_queue(ctrl, new);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 345d6de6bc86..ad4734df7342 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -173,6 +173,7 @@ struct nvmf_transport_ops {
>   };
>   
>   struct nvme_fabrics_ops {
> +	int	(*setup_transport)(struct nvme_ctrl *ctrl);
>   	int	(*alloc_admin_queue)(struct nvme_ctrl *ctrl);
>   	int	(*start_admin_queue)(struct nvme_ctrl *ctrl);
>   	void	(*stop_admin_queue)(struct nvme_ctrl *ctrl);
> @@ -182,9 +183,7 @@ struct nvme_fabrics_ops {
>   	void	(*stop_io_queue)(struct nvme_ctrl *ctrl, int qid);
>   	void	(*free_io_queue)(struct nvme_ctrl *ctrl, int qid);
>   
> -	/* these should be replaced with a single one setup_transport() */
> -	int	(*alloc_admin_tag_set)(struct nvme_ctrl *ctrl);
> -	int	(*alloc_tag_set)(struct nvme_ctrl *ctrl);
> +	/* there should move to setup_transport() as well */
>   	unsigned int	(*nr_io_queues)(struct nvme_ctrl *ctrl);
>   	void	(*set_io_queues)(struct nvme_ctrl *ctrl, unsigned int nr_io_queues);
>   };
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 023316fdc2c6..015a6bde732a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -743,6 +743,39 @@ static void nvme_rdma_stop_io_queue(struct nvme_ctrl *nctrl, int qid)
>   	__nvme_rdma_stop_queue(queue);
>   }
>   
> +static int nvme_rdma_setup_transport(struct nvme_ctrl *ctrl)
> +{
> +	unsigned int cmd_size;
> +	int ret;
> +
> +	ret =  nvme_alloc_admin_tag_set(ctrl, &to_rdma_ctrl(ctrl)->admin_tag_set,
> +					&nvme_rdma_admin_mq_ops,
> +					sizeof(struct nvme_rdma_request) +
> +					NVME_RDMA_DATA_SGL_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	cmd_size = sizeof(struct nvme_rdma_request) +
> +				NVME_RDMA_DATA_SGL_SIZE;
> +
> +	if (ctrl->max_integrity_segments)
> +		cmd_size += sizeof(struct nvme_rdma_sgl) +
> +			    NVME_RDMA_METADATA_SGL_SIZE;
> +
> +	ret = nvme_alloc_io_tag_set(ctrl, &to_rdma_ctrl(ctrl)->tag_set,
> +				    &nvme_rdma_mq_ops,
> +				    ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
> +				    cmd_size);
> +	if (ret)
> +		goto out_free_admin_tag_set;
> +
> +	return 0;
> +
> +out_free_admin_tag_set:
> +	nvme_remove_admin_tag_set(ctrl);
> +	return ret;
> +}
> +
>   static unsigned int nvme_rdma_nr_io_queues(struct nvme_ctrl *ctrl)
>   {
>   	struct ib_device *ibdev = to_rdma_ctrl(ctrl)->device->dev;
> @@ -802,21 +835,6 @@ static void nvme_rdma_set_io_queues(struct nvme_ctrl *nctrl,
>   	}
>   }
>   
> -static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *ctrl)
> -{
> -	unsigned int cmd_size = sizeof(struct nvme_rdma_request) +
> -				NVME_RDMA_DATA_SGL_SIZE;
> -
> -	if (ctrl->max_integrity_segments)
> -		cmd_size += sizeof(struct nvme_rdma_sgl) +
> -			    NVME_RDMA_METADATA_SGL_SIZE;
> -
> -	return nvme_alloc_io_tag_set(ctrl, &to_rdma_ctrl(ctrl)->tag_set,
> -			&nvme_rdma_mq_ops,
> -			ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
> -			cmd_size);
> -}
> -
>   static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
>   {
>   	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
> @@ -834,15 +852,6 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
>   	kfree(ctrl);
>   }
>   
> -static int nvme_rdma_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
> -{
> -
> -	return nvme_alloc_admin_tag_set(ctrl, &to_rdma_ctrl(ctrl)->admin_tag_set,
> -					&nvme_rdma_admin_mq_ops,
> -					sizeof(struct nvme_rdma_request) +
> -					   NVME_RDMA_DATA_SGL_SIZE);
> -}
> -
>   static void nvme_rdma_end_request(struct nvme_rdma_request *req)
>   {
>   	struct request *rq = blk_mq_rq_from_pdu(req);
> @@ -1915,6 +1924,7 @@ nvme_rdma_existing_controller(struct nvmf_ctrl_options *opts)
>   }
>   
>   static struct nvme_fabrics_ops nvme_rdma_fabrics_ops = {
> +	.setup_transport	= nvme_rdma_setup_transport,
>   	.alloc_admin_queue	= nvme_rdma_alloc_admin_queue,
>   	.free_admin_queue	= nvme_rdma_free_admin_queue,
>   	.start_admin_queue	= nvme_rdma_start_admin_queue,
> @@ -1923,8 +1933,6 @@ static struct nvme_fabrics_ops nvme_rdma_fabrics_ops = {
>   	.free_io_queue		= nvme_rdma_free_io_queue,
>   	.start_io_queue		= nvme_rdma_start_io_queue,
>   	.stop_io_queue		= nvme_rdma_stop_io_queue,
> -	.alloc_admin_tag_set	= nvme_rdma_alloc_admin_tag_set,
> -	.alloc_tag_set		= nvme_rdma_alloc_tag_set,
>   	.nr_io_queues		= nvme_rdma_nr_io_queues,
>   	.set_io_queues		= nvme_rdma_set_io_queues,
>   };
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index dfdf35b32adc..f91575b944a2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1720,20 +1720,26 @@ static void nvme_tcp_stop_io_queue(struct nvme_ctrl *nctrl, int qid)
>   	__nvme_tcp_stop_queue(queue);
>   }
>   
> -static int nvme_tcp_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
> +static int nvme_tcp_setup_transport(struct nvme_ctrl *ctrl)
>   {
> -	return nvme_alloc_admin_tag_set(ctrl, &to_tcp_ctrl(ctrl)->admin_tag_set,
> -					&nvme_tcp_admin_mq_ops,
> -					sizeof(struct nvme_tcp_request));
> -}
> +	int ret;
>   
> -static int nvme_tcp_alloc_tag_set(struct nvme_ctrl *ctrl)
> -{
> -	return nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
> -				     &nvme_tcp_mq_ops,
> -				     ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
> -				     sizeof(struct nvme_tcp_request));
> +	ret = nvme_alloc_admin_tag_set(ctrl, &to_tcp_ctrl(ctrl)->admin_tag_set,
> +				       &nvme_tcp_admin_mq_ops,
> +				       sizeof(struct nvme_tcp_request));
> +	if (ret)
> +		return ret;
> +
> +	ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
> +				    &nvme_tcp_mq_ops,
> +				    ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
> +				    sizeof(struct nvme_tcp_request));
> +	if (ret)
> +		goto out_free_admin_tag_set;
>   
> +out_free_admin_tag_set:
> +	nvme_remove_admin_tag_set(ctrl);
> +	return ret;
>   }
>   
>   static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
> @@ -2155,6 +2161,7 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
>   }
>   
>   static struct nvme_fabrics_ops nvme_tcp_fabrics_ops = {
> +	.setup_transport	= nvme_tcp_setup_transport,
>   	.alloc_admin_queue	= nvme_tcp_alloc_admin_queue,
>   	.free_admin_queue	= nvme_tcp_free_admin_queue,
>   	.start_admin_queue	= nvme_tcp_start_admin_queue,
> @@ -2163,8 +2170,6 @@ static struct nvme_fabrics_ops nvme_tcp_fabrics_ops = {
>   	.free_io_queue		= nvme_tcp_free_io_queue,
>   	.start_io_queue		= nvme_tcp_start_io_queue,
>   	.stop_io_queue		= nvme_tcp_stop_io_queue,
> -	.alloc_admin_tag_set	= nvme_tcp_alloc_admin_tag_set,
> -	.alloc_tag_set		= nvme_tcp_alloc_tag_set,
>   	.nr_io_queues		= nvme_tcp_nr_io_queues,
>   	.set_io_queues		= nvme_tcp_set_io_queues,
>   };

