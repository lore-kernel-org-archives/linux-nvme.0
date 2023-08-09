Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111F6EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MxD4Z8RJdkSf14Iq1u4v8rQRCJKMLijBlvwEtgiqg4A=; b=2MvVz76PV1aWJLVmtYXpPKqlfE
	jwRcGJLCikbzCVKDPYGTU/nvB88Slb6UK9J3AZePT0wmneRieCMeM/amJkPfAKertz5Rzwvdzjd7a
	GRHJQFt/qTlhdMHRJJQfLPs094xGhtxVaG585EhV5rkdh1YtqaLhah03Conwth1Xh7eG9vNuj5naP
	NqCjNGy8nLbGrx8N0JVa1b2TDkArzjIp7eTwei5G+mnh+xAp3uQecg5cD64Dh8HKJ1T7Y6deJ1dYk
	/qcgZ7sKGMWT0lLJek70Aj62COAT1F+0nMWfMCSx2vP8x4GASV0aNZuJKMe7rWByLgx2g+cJ14TQZ
	CIh+ihDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTdjE-004HHJ-3A;
	Wed, 09 Aug 2023 07:35:37 +0000
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTdjC-004HG4-2D
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 07:35:36 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe70332415so749521e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 00:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566532; x=1692171332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxD4Z8RJdkSf14Iq1u4v8rQRCJKMLijBlvwEtgiqg4A=;
        b=UTQ/I8zAgw9SiA506VaT6OoANqlvPBfh0bKH1uXNPklaZkNCq6QOS+7A4mzwU2xD/U
         nklTtmBu9UKpPFYqG2Yw8HQiQmxeBtyyRZFb+qIM/eGgcSgcWU+1bZU0LeoxQrskWlPu
         eIshWYqjJ6lUvit5EvRmTMgxZxSAZtZfX+4AiageWKMKn2k+ityvZDdX0T43BA6dyVjW
         gqX59vX1SkfCKKEcNZ+ykHkxTfzobm+Wb1KkesEgUq3GlDJxJmR7dL2zdxBvvxNjFlJO
         /n2AzAtDw5DySGpvZcrKjEtH0otBKzNa2SoughWAS/WfxLHQrtPlIcKdWmJKg5+fxB4v
         XEVA==
X-Gm-Message-State: AOJu0YzrIriNhtxQpJT2V335SsTnyiw/IK+b2CDKfsaqLn8dHXOab0Z8
	8kRCsmatF1t2vjZxwhEpd7M=
X-Google-Smtp-Source: AGHT+IGLZYj0+h+2w/xhdXAUxPcFSndm7fBE4FCEFa+o4aUYiHiWeMtk5t/nTMhUJUsgid7pYj8Igw==
X-Received: by 2002:a19:7401:0:b0:4fd:d47b:cff8 with SMTP id v1-20020a197401000000b004fdd47bcff8mr1055592lfe.6.1691566531530;
        Wed, 09 Aug 2023 00:35:31 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t15-20020a7bc3cf000000b003fe601a7d46sm1079435wmj.45.2023.08.09.00.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:35:30 -0700 (PDT)
Message-ID: <1d5adbe9-dcab-5eae-fff3-631b91c2da94@grimberg.me>
Date: Wed, 9 Aug 2023 10:35:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 08/26] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-9-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-9-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_003534_720421_6B07524D 
X-CRM114-Status: GOOD (  30.71  )
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



On 7/12/23 19:14, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
> 
> Introduce the NVMe-TCP DDP data-path offload.
> Using this interface, the NIC hardware will scatter TCP payload directly
> to the BIO pages according to the command_id in the PDU.
> To maintain the correctness of the network stack, the driver is expected
> to construct SKBs that point to the BIO pages.
> 
> The data-path interface contains two routines: setup/teardown.
> The setup provides the mapping from command_id to the request buffers,
> while the teardown removes this mapping.
> 
> For efficiency, we introduce an asynchronous nvme completion, which is
> split between NVMe-TCP and the NIC driver as follows:
> NVMe-TCP performs the specific completion, while NIC driver performs the
> generic mq_blk completion.
> 
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 121 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 116 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7d3b0ac65c03..6057cd424a19 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -116,6 +116,13 @@ struct nvme_tcp_request {
>   	size_t			offset;
>   	size_t			data_sent;
>   	enum nvme_tcp_send_state state;
> +
> +#ifdef CONFIG_ULP_DDP
> +	bool			offloaded;
> +	struct ulp_ddp_io	ddp;
> +	__le16			ddp_status;
> +	union nvme_result	result;
> +#endif
>   };
>   
>   enum nvme_tcp_queue_flags {
> @@ -354,11 +361,75 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   	return false;
>   }
>   
> +static int nvme_tcp_req_map_ddp_sg(struct nvme_tcp_request *req, struct request *rq)

Why do you pass both req and rq? You can derive each from the other.

> +{
> +	int ret;
> +
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;
> +	ret = sg_alloc_table_chained(&req->ddp.sg_table,
> +				     blk_rq_nr_phys_segments(rq),
> +				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
> +	if (ret)
> +		return -ENOMEM;
> +	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);

General question, I'm assuming that the hca knows how to deal with
a controller that sends c2hdata in parts?


> +	return 0;
> +}
> +
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
>   	.resync_request		= nvme_tcp_resync_request,
> +	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
>   };
>   
> +static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +				  struct request *rq)
> +{
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, queue->sock->sk,
> +						  &req->ddp, rq);
> +	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +}
> +
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> +{
> +	struct request *rq = ddp_ctx;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!nvme_try_complete_req(rq, req->ddp_status, req->result))
> +		nvme_complete_rq(rq);
> +}
> +
> +static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue, u16 command_id,
> +			      struct request *rq)

I think you can use nvme_cid(rq) instead of passing the command_id.

> +{
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	int ret;
> +
> +	if (rq_data_dir(rq) != READ ||
> +	    queue->ctrl->offload_io_threshold > blk_rq_payload_bytes(rq))
> +		return 0;
> +
> +	req->ddp.command_id = command_id;
> +	ret = nvme_tcp_req_map_ddp_sg(req, rq);

Don't see why map_ddp_sg is not open-coded here, its the only call-site,
and its pretty much does exactly what its called.

> +	if (ret)
> +		return -ENOMEM;
> +
> +	ret = netdev->netdev_ops->ulp_ddp_ops->setup(netdev, queue->sock->sk,
> +						     &req->ddp);
> +	if (ret) {
> +		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +		return ret;
> +	}
> +
> +	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
> +	req->offloaded = true;
> +	return 0;
> +}
> +
>   static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
>   	struct net_device *netdev = queue->ctrl->offloading_netdev;
> @@ -491,6 +562,12 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   	return false;
>   }
>   
> +static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue, u16 command_id,
> +			      struct request *rq)
> +{
> +	return 0;
> +}
> +
>   static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
>   	return -EOPNOTSUPP;
> @@ -778,6 +855,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
>   }
>   
> +static void nvme_tcp_complete_request(struct request *rq,
> +				      __le16 status,
> +				      union nvme_result result,
> +				      __u16 command_id)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (req->offloaded) {
> +		req->ddp_status = status;
> +		req->result = result;
> +		nvme_tcp_teardown_ddp(req->queue, rq);
> +		return;
> +	}
> +#endif
> +
> +	if (!nvme_try_complete_req(rq, status, result))
> +		nvme_complete_rq(rq);
> +}
> +
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> @@ -797,10 +894,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
>   		req->status = cqe->status;
>   
> -	if (!nvme_try_complete_req(rq, req->status, cqe->result))
> -		nvme_complete_rq(rq);
> +	nvme_tcp_complete_request(rq, req->status, cqe->result,
> +				  cqe->command_id);
>   	queue->nr_cqe++;
> -
>   	return 0;
>   }
>   
> @@ -998,10 +1094,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   
>   static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   {
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   	union nvme_result res = {};
>   
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> -		nvme_complete_rq(rq);
> +	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
> +				  pdu->command_id);
>   }
>   
>   static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> @@ -1308,6 +1407,15 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	else
>   		msg.msg_flags |= MSG_EOR;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
> +		ret = nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id,
> +					 blk_mq_rq_from_pdu(req));
> +		WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
> +			  nvme_tcp_queue_id(queue),
> +			  pdu->cmd.common.command_id,
> +			  ret);
> +	}

Any reason why this is done here when sending the command pdu and not
in setup time?

> +
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
> @@ -2739,6 +2847,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>   	if (ret)
>   		return ret;
>   
> +#ifdef CONFIG_ULP_DDP
> +	req->offloaded = false;
> +#endif
>   	req->state = NVME_TCP_SEND_CMD_PDU;
>   	req->status = cpu_to_le16(NVME_SC_SUCCESS);
>   	req->offset = 0;

