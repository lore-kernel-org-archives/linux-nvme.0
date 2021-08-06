Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A8BC4338F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:42:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E83B61052
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E83B61052
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v8K+5foC2+eaX4ulv8G67bNQWhjgtsbNVhW3fr32T0s=; b=i2ZHDTf18tUgRWkm110RYhqpTp
	3z2+8HjQUUz2IbaVbukCqiuzuNbtHvFFiNZxGvjuz3TRFcgqM/d6QvPvbx+yh6IYNaPV0iAGNtatM
	wv0+YvgcfWuJSgn8q4hSACNlaUFCNvv4VVAt66ytH5lhoFhWhnZF50bBD5H7SScOy2WrrKQGXPAGU
	6Ez0oW9UG9z1hmpujbjZNXmXtyDc7Dh34Nq37eq80jPx83sRVPvpVcd+bASPpX3khp7+4NzWYuSye
	kSsZlP6wyBMx0k3Bi1cyFZmY7PyXlvn2pTHmYKoe5XHzTKFbF0V0BittRKE5x/Dv8Viu9prjNnmHZ
	6Ul3Ct+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC5jJ-00DL9x-PG; Fri, 06 Aug 2021 19:42:05 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC5jH-00DL8z-2M
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 19:42:04 +0000
Received: by mail-pl1-f182.google.com with SMTP id c16so8449053plh.7
 for <linux-nvme@lists.infradead.org>; Fri, 06 Aug 2021 12:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TpLObiiQLd5hw3nNKqOroEB/FSEufNd2Kqe0wsHzpa4=;
 b=ehuopXIVJlTHJDIp2aYg26X5mdjGuDg9WgVG4myhAdKt9rCyza/uAGFOdWSeldUov5
 iEMuSBBHLXusEqybX6OUVTJ7xXvrXwYiebDYGO7lRF8DZ5ALQyqPe7Edtx5iektbZplA
 yb9G3Pj/VulNPmxeU1rTpCx3s+VdTTlZgwqq1SG1Io4C10/Kurg4+nF3PJzgj0f5CmWe
 QKgPNrrz0SFyl0M8cuysthKUrwqjit+nx9H0hg+tcPJXIXC9V+PXqK2xC06eG90Sj6IX
 0AMzZr5KlL46DgfW2Lwb/BBEYo8rbsRr0gAEO9qGHGQW+FN8VlpoI7gvpG/CnlV0pgLr
 rhGA==
X-Gm-Message-State: AOAM531c3GkDoFf/YDiA+jh37A6HTlazTK5Ef6GESdpJREsRtS9zKh42
 H4VGyGGG5oYYirLwzFhkWUQ=
X-Google-Smtp-Source: ABdhPJyEJ03tBxCW8K04znwjFoXvo/hL/lg+XnsGBoy0m5j8M/NpYf/BBkwhicKTfFjDqcs/xTm5uA==
X-Received: by 2002:a17:90a:ce05:: with SMTP id
 f5mr22649696pju.93.1628278922237; 
 Fri, 06 Aug 2021 12:42:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7?
 ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
 by smtp.gmail.com with ESMTPSA id f10sm11636313pfa.17.2021.08.06.12.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 12:42:01 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>, yi.he@emc.com
References: <20210805121541.77613-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
Date: Fri, 6 Aug 2021 12:42:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805121541.77613-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_124203_166901_1710ADF1 
X-CRM114-Status: GOOD (  30.84  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The spec says
> 
>    7.4.6.1 Digest Error handling
> 
>    When a host detects a data digest error in a C2HData PDU, that host
>    shall continue processing C2HData PDUs associated with the command and
>    when the command processing has completed, if a successful status was
>    returned by the controller, the host shall fail the command with a
>    non-fatal transport error.
> 
> Currently the transport is reseted when a data digest error is
> detected. To fix this, keep track of the final status in the queue
> object and use it when completing the request.
> 
> The new member can be placed adjacent to the receive related members and
> fits in the cacheline as there is a 4 byte hole.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> Hi,
> 
> I've tested this by modifying the receive path. Via the fault_inject
> interface I injecting wrong hash values. The request would then be
> completed with status != 0 and nvme_decide_disposition decices to
> retry the request. So this seems be in more sync with what the spec
> says on this topic.
> 
> Daniel
> 
>   drivers/nvme/host/tcp.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 097f7dd10ed3..5253147df4c7 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -89,6 +89,7 @@ struct nvme_tcp_queue {
>   	size_t			data_remaining;
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
> +	u16			status;

Why is this a queue member and not a request member?

>   
>   	/* send state */
>   	struct nvme_tcp_request *request;
> @@ -496,7 +497,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +	if (!nvme_try_complete_req(rq, queue->status ?
> +			queue->status : cqe->status, cqe->result))
>   		nvme_complete_rq(rq);
>   	queue->nr_cqe++;
>   
> @@ -676,6 +678,7 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   
>   	switch (hdr->type) {
>   	case nvme_tcp_c2h_data:
> +		queue->status = NVME_SC_SUCCESS;
>   		return nvme_tcp_handle_c2h_data(queue, (void *)queue->pdu);
>   	case nvme_tcp_rsp:
>   		nvme_tcp_init_recv_ctx(queue);
> @@ -758,7 +761,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>   		} else {
>   			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> -				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
> +				nvme_tcp_end_request(rq, queue->status);
>   				queue->nr_cqe++;
>   			}
>   			nvme_tcp_init_recv_ctx(queue);
> @@ -792,14 +795,14 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   			"data digest error: recv %#x expected %#x\n",
>   			le32_to_cpu(queue->recv_ddgst),
>   			le32_to_cpu(queue->exp_ddgst));
> -		return -EIO;
> +		queue->status = NVME_SC_DATA_XFER_ERROR;
>   	}
>   
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
>   		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
>   					pdu->command_id);
>   
> -		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
> +		nvme_tcp_end_request(rq, queue->status);
>   		queue->nr_cqe++;
>   	}
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
