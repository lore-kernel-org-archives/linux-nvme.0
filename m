Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED42C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 22:29:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD24E22243
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 22:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iGU4nqAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD24E22243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3gLPVjMsl7ZcIeKncvRFZqntvukbXJsXFX5j/aojzos=; b=iGU4nqAvG6cQmSXZkQxr6St7I
	yES58xAmD9EQtGuvnTOK+4ZZ8Ws5LLGLhGToXV6zJlREvgS2kJpVXBTxGPsDBb8iSnyEYGnw8NZdu
	ZnedxAvLQDb4tWOGLiSbOpACBkxRtEuKh0gDBis10SFt7MdV7ujDcTdZi7Hd3xqYQ0CKlEE+T+KMO
	dS2Sz6XjJAGV3Mf1ejK4kfoiWHrtvZTfhENFnhPE3emwDYX8+3M35P9TD9+mvD4TAwBJ+gRjYAUEz
	uYgB2/pnCJHosVwLszd1Fy2goA5+pRahHsNqDki7ZsXE6Nb0uj1sm5wmlFcv/qeeDxMEI1j4FfdbJ
	DVWGcTpxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQePV-0003Kd-Ss; Thu, 08 Oct 2020 22:29:17 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQePT-0003KC-Jc
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 22:29:16 +0000
Received: by mail-wr1-f66.google.com with SMTP id t9so8232923wrq.11
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 15:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ox+SLdn5ABEvjXy4FNIvlB0HuPx9UawCsH/gISwf+Sw=;
 b=InOfnNmG3Q5IpDNYwa7Pf8xOGZ1KM4c/2chb+12+pwax7eCQbKOawQJOztxV5+lGf7
 7TilJFWDYUQaGY7KA3HtvRKHacktnppRKTAFdHc5GM6pXuBWGMCoMk+SATWlkpKGjapm
 3bJckuyTADvObKbwcb0Ehl5yE44UFgt1xwDmfguWdhqhsUiyOC/bcyWt9bOEj9PykXfv
 M8IQ5tz2q1HTgi6StiQ7a2NTwDU4Qu3Yj2EoWyfmUQ3jsAsOAqm6uuaUGP8ZXEhsJYZO
 3ApuKR/0r0ZNMeFbKMft6GmdKBHCdsdtriwUBCdqRtgt6Kp4Xmimuck02U1R3+f0g7lX
 TRkA==
X-Gm-Message-State: AOAM530l3B7DOlxgnWdLZDam0dfB/umjtxGrTdbaMfq9oM3yU01mwBoc
 txbZc2BwblplkqlH+QcgiUg=
X-Google-Smtp-Source: ABdhPJyjtl4th6cFE65od/0j5xVs8hY/DF2C3jwkNEocZeRSMsDoE3kMhSGPzGskIfro6pC2Urcf2Q==
X-Received: by 2002:adf:9043:: with SMTP id h61mr11995933wrh.237.1602196154497; 
 Thu, 08 Oct 2020 15:29:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id l3sm8532148wmh.27.2020.10.08.15.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 15:29:14 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 06/10] nvme-tcp: Add DDP data-path
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-7-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5a23d221-fd3e-5802-ce68-7edec55068bb@grimberg.me>
Date: Thu, 8 Oct 2020 15:29:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930162010.21610-7-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_182915_715419_06BBD678 
X-CRM114-Status: GOOD (  18.41  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>   bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   const struct tcp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops __read_mostly = {
> +
>   	.resync_request		= nvme_tcp_resync_request,
> +	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
>   };
>   
> +static
> +int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +			  uint16_t command_id,
> +			  struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	int ret;
> +
> +	if (unlikely(!netdev)) {
> +		pr_info_ratelimited("%s: netdev not found\n", __func__);

dev_info_ratelimited

> +		return -EINVAL;
> +	}
> +
> +	ret = netdev->tcp_ddp_ops->tcp_ddp_teardown(netdev, queue->sock->sk,
> +						    &req->ddp, rq);
> +	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +	req->offloaded = false;
> +	return ret;
> +}
> +
> +void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> +{
> +	struct request *rq = ddp_ctx;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!nvme_try_complete_req(rq, cpu_to_le16(req->status << 1), req->result))
> +		nvme_complete_rq(rq);
> +}
> +
> +static
> +int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> +		       uint16_t command_id,
> +		       struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	int ret;
> +
> +	req->offloaded = false;
> +
> +	if (unlikely(!netdev)) {
> +		pr_info_ratelimited("%s: netdev not found\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	req->ddp.command_id = command_id;
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;
> +	ret = sg_alloc_table_chained(&req->ddp.sg_table,
> +		blk_rq_nr_phys_segments(rq), req->ddp.sg_table.sgl,
> +		SG_CHUNK_SIZE);
> +	if (ret)
> +		return -ENOMEM;

newline here

> +	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
> +
> +	ret = netdev->tcp_ddp_ops->tcp_ddp_setup(netdev,
> +						 queue->sock->sk,
> +						 &req->ddp);
> +	if (!ret)
> +		req->offloaded = true;
> +	return ret;
> +}
> +
>   static
>   int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue,
>   			    struct nvme_tcp_config *config)
> @@ -351,6 +422,25 @@ bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
>   
>   #else
>   
> +static
> +int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> +		       uint16_t command_id,
> +		       struct request *rq)
> +{
> +	return -EINVAL;
> +}
> +
> +static
> +int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +			  uint16_t command_id,
> +			  struct request *rq)
> +{
> +	return -EINVAL;
> +}
> +
> +void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> +{}
> +
>   static
>   int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue,
>   			    struct nvme_tcp_config *config)
> @@ -630,6 +720,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> +	struct nvme_tcp_request *req;
>   	struct request *rq;
>   
>   	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
> @@ -641,8 +732,15 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> -		nvme_complete_rq(rq);
> +	req = blk_mq_rq_to_pdu(rq);
> +	if (req->offloaded) {
> +		req->status = cqe->status;
> +		req->result = cqe->result;
> +		nvme_tcp_teardown_ddp(queue, cqe->command_id, rq);
> +	} else {
> +		if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +			nvme_complete_rq(rq);
> +	}
>   	queue->nr_cqe++;
>   
>   	return 0;
> @@ -836,9 +934,18 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   {
>   	union nvme_result res = {};
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> -		nvme_complete_rq(rq);
> +	if (req->offloaded) {
> +		req->status = cpu_to_le16(status << 1);
> +		req->result = res;
> +		nvme_tcp_teardown_ddp(queue, pdu->command_id, rq);
> +	} else {
> +		if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> +			nvme_complete_rq(rq);
> +	}
>   }
>   
>   static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> @@ -1115,6 +1222,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	bool inline_data = nvme_tcp_has_inline_data(req);
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	int len = sizeof(*pdu) + hdgst - req->offset;
> +	struct request *rq = blk_mq_rq_from_pdu(req);
>   	int flags = MSG_DONTWAIT;
>   	int ret;
>   
> @@ -1123,6 +1231,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	else
>   		flags |= MSG_EOR;
>   
> +	if (test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags) &&
> +	    blk_rq_nr_phys_segments(rq) && rq_data_dir(rq) == READ)
> +		nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);

I'd assume that this is something we want to setup in
nvme_tcp_setup_cmd_pdu. Why do it here?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
