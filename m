Return-Path: <SRS0=P1pc=HQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35265C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 18:27:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E058464E05
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 18:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E058464E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LDM+HprsKSNTmw5gf+pupOvPK/8xag9Z8B18oPGhbs0=; b=0BwH3kipAcyy7irszMVJ55Are
	diprFjrYlcEWupHHjEH53khadFhQfeZhL6j9zmmFB0Ga+oKEZOqvXoCU9eKhT0Dwe+wTRrxUkWjVt
	k+pauYiehGCJjeEtuKpGwUlSQMKQ1Xt78qeoA/dDAImqd9FHzBLl5TXK/6TpCjsQ8BS2SlNInEdAY
	XwRS1C2WNAwLCPW1KNRI8OXOWPblDXXhjgzW9r5NMHiWoVRjJRrWZ+7gNMMlSUg+DMobCra3susTc
	6iTDdE5faUjhjKbOCdbh5c4Mri1Rsy22/JXlnQNHGmYXL7RW5anQn8WiNBbOufi3hsufxkA6HZJ0Y
	rIUOtaVpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBM79-00009p-Am; Sun, 14 Feb 2021 18:27:23 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBM76-00009A-DD
 for linux-nvme@lists.infradead.org; Sun, 14 Feb 2021 18:27:21 +0000
Received: by mail-oi1-x230.google.com with SMTP id h17so1712272oih.5
 for <linux-nvme@lists.infradead.org>; Sun, 14 Feb 2021 10:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gyAEP57mzF2m5+A3pWOKhRp71TfOmK81NA6IB/liTnw=;
 b=BrPG4yoOVHbHMJc/QMpZknFh0q3k2v6usHR5HR8PzVE3VPNmY16i9lT3Ur0KV/P+7f
 1eqC9Pbki5O6eO9cdBy+rFKfctf7Mq+iQSQOakX2Ool2DyfGErLb6yKkPwcwC2ZKPJMx
 bLiq4XdDyf/We5WqNr3SVfneJhtyIMiDouq6yNid7cVzAm5rWK9DQwu6ZfIBjhFhDtKI
 zerS0En3YFShIUwkHBH6WK2L9ROXBxOmvhEp6DFlQZ8EoBw5l/WerRedUINzpf/jxqzy
 J5F+WqqtW5Ie1JX5U5a+fp+fpSQHdpzTEyQfliH0IJ9UX7bbCHIXeoa130B/gBjyMJwf
 vc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gyAEP57mzF2m5+A3pWOKhRp71TfOmK81NA6IB/liTnw=;
 b=LLibQndnsdL2eXKIq6U/jKNKxsIwr9rBbgKM68dLBSdpIPJ3+rt45zbiJnVj/FE5mj
 eg83Zmt7dVRoNOelbzt7zG2WlmKo+MmiQqxH7ekkpOQHsOuYfCp8Pq0aH2PYNq+OxX00
 zOJdPcKruLgtgA52o1dGbESVA5VsRKqgBG+EuIaus3KavDUExmpn8mLdNoxYePoIDtsH
 LI1gadavCTwKNeVmDhBcacWW+06kvvhUXG7bmjqjRxFXpXaV4lQ1tKt0/1FPv7rF3kl2
 oodXCSB6NibuLiuwIOpa1NVlCdveafi0HTEwUSNvyICNKmd3rwwDEs+8GFGyFOmRKdTp
 htuw==
X-Gm-Message-State: AOAM530+CW0RCNHXJ6dahr9syloDxiY2d+mgdiiu+5vXJ/Y+B5zuwvvi
 XyujugaoNv8+uI1UN2PL9SY=
X-Google-Smtp-Source: ABdhPJzq2KGbgVEMIR3ygGvmdhduOk9OfvWmPuRS7zo+Q+llSXzs+e6V5A3ifhGjpOPIw95HtOhXOw==
X-Received: by 2002:aca:3742:: with SMTP id e63mr6277228oia.158.1613327238813; 
 Sun, 14 Feb 2021 10:27:18 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.33])
 by smtp.googlemail.com with ESMTPSA id j25sm2772470otn.55.2021.02.14.10.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Feb 2021 10:27:18 -0800 (PST)
Subject: Re: [PATCH v4 net-next 07/21] nvme-tcp: Add DDP data-path
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210211211044.32701-1-borisp@mellanox.com>
 <20210211211044.32701-8-borisp@mellanox.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <cfd61c5a-c5fd-e0d9-fb60-be93f1c98735@gmail.com>
Date: Sun, 14 Feb 2021 11:27:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211211044.32701-8-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210214_132720_508556_96101DD3 
X-CRM114-Status: GOOD (  21.79  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/11/21 2:10 PM, Boris Pismenny wrote:
>  
> +static int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +				 u16 command_id,
> +				 struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	int ret;
> +
> +	if (unlikely(!netdev)) {
> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");

again, unnecessary. you only get here because the rquest is marked
offloaded and that only happens if the netdev exists and supports DDP.

> +		return -EINVAL;
> +	}
> +
> +	ret = netdev->tcp_ddp_ops->tcp_ddp_teardown(netdev, queue->sock->sk,
> +						    &req->ddp, rq);
> +	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +	return ret;
> +}
> +
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> +{
> +	struct request *rq = ddp_ctx;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!nvme_try_complete_req(rq, req->status, req->result))
> +		nvme_complete_rq(rq);
> +}
> +
> +static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> +			      u16 command_id,
> +			      struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	int ret;
> +
> +	if (unlikely(!netdev)) {
> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");

similarly here. you can't get here if netdev is null.

> +		return -EINVAL;
> +	}
> +
> +	req->ddp.command_id = command_id;
> +	ret = nvme_tcp_req_map_sg(req, rq);
> +	if (ret)
> +		return -ENOMEM;
> +
> +	ret = netdev->tcp_ddp_ops->tcp_ddp_setup(netdev,
> +						 queue->sock->sk,
> +						 &req->ddp);
> +	if (!ret)
> +		req->offloaded = true;
> +	return ret;
> +}
> +
>  static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>  {
>  	struct net_device *netdev = queue->ctrl->offloading_netdev;
> @@ -343,7 +417,7 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
>  		return;
>  
>  	if (unlikely(!netdev)) {
> -		pr_info_ratelimited("%s: netdev not found\n", __func__);
> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");

and per comment on the last patch, this is not needed.

> @@ -849,10 +953,39 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>  
>  static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>  {
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>  	union nvme_result res = {};
>  
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> -		nvme_complete_rq(rq);
> +	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res, pdu->command_id);
> +}
> +
> +
> +static int nvme_tcp_consume_skb(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> +				unsigned int *offset, struct iov_iter *iter, int recv_len)
> +{
> +	int ret;
> +
> +#ifdef CONFIG_TCP_DDP
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
> +		if (queue->data_digest)
> +			ret = skb_ddp_copy_and_hash_datagram_iter(skb, *offset, iter, recv_len,
> +					queue->rcv_hash);
> +		else
> +			ret = skb_ddp_copy_datagram_iter(skb, *offset, iter, recv_len);
> +	} else {
> +#endif

why not make that a helper defined in the CONFIG_TCP_DDP section with an
inline for the unset case. Keeps this code from being polluted with the
ifdef checks.

> +		if (queue->data_digest)
> +			ret = skb_copy_and_hash_datagram_iter(skb, *offset, iter, recv_len,
> +					queue->rcv_hash);
> +		else
> +			ret = skb_copy_datagram_iter(skb, *offset, iter, recv_len);
> +#ifdef CONFIG_TCP_DDP
> +	}
> +#endif
> +
> +	return ret;
>  }
>  
>  static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> @@ -899,12 +1032,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>  		recv_len = min_t(size_t, recv_len,
>  				iov_iter_count(&req->iter));
>  
> -		if (queue->data_digest)
> -			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
> -				&req->iter, recv_len, queue->rcv_hash);
> -		else
> -			ret = skb_copy_datagram_iter(skb, *offset,
> -					&req->iter, recv_len);
> +		ret = nvme_tcp_consume_skb(queue, skb, offset, &req->iter, recv_len);
>  		if (ret) {
>  			dev_err(queue->ctrl->ctrl.device,
>  				"queue %d failed to copy request %#x data",
> @@ -1128,6 +1256,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>  	bool inline_data = nvme_tcp_has_inline_data(req);
>  	u8 hdgst = nvme_tcp_hdgst_len(queue);
>  	int len = sizeof(*pdu) + hdgst - req->offset;
> +	struct request *rq = blk_mq_rq_from_pdu(req);
>  	int flags = MSG_DONTWAIT;
>  	int ret;
>  
> @@ -1136,6 +1265,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>  	else
>  		flags |= MSG_EOR;
>  
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) &&
> +	    blk_rq_nr_phys_segments(rq) && rq_data_dir(rq) == READ)
> +		nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);
> +

For consistency, shouldn't this be wrapped in the CONFIG_TCP_DDP check too?

>  	if (queue->hdr_digest && !req->offset)
>  		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>  

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
