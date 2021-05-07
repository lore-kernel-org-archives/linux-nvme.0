Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE6BC433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 17:46:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA5061415
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 17:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA5061415
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jpvUqeBsfA//q8Rgu7nQuLqxPYiDk/IwMVUUrouVSjM=; b=ZhBHAnxP9K1NmtdIYPQPWCdWB
	BRL4lRUI8KUKcb9PW5GWtEiB1IaQaYUKGIUwkIEjQN1dLfjSYwwK2kDSh6/jDZQWKYOUh6WSGr6Ct
	XSpvHeiWOjaYqVxI65NOgjMKLn9Cs0V+dDa0kPoNO2UJYLjvJfcb2xzsfUVA5BbUUe/cEfwxOQkJm
	xWlTg/7mJNtIB+AWD4EdTrWEix4dVxOJ7oX3fVHXraO52uw4YHY1tTLmGL7+pyl25xKL2Q88RY/vW
	uDaBs+ntMBX58TmlBgh+RrJ+8H+hkIYk1UNhKMmMEb7aR/7ujZj7r19iknBhivvJRvBSysSdTjpfT
	DAaVM3wzg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf4Yk-007iBx-HP; Fri, 07 May 2021 17:46:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf4Yh-007iBp-AF
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 17:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
 Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=zD7Bdq9dUY+SmTtwMnbcHhYWkJRgSjitCMf0WPxakU4=; b=ZsPZ2fupScELwqS6kGUpn+uk7B
 ZMD7/RZDajwumo6RFl/Q3da2NjFjOJcydIFYE/8W1VA/vLATYHVnqJuHaCZcBaBlV/wYL8RihpjKx
 Zuhp+cUpMRDzNAdTknj7/h2UBLqOXOqG0hoCbbJjNfn3UjxCSd6qs1OtuGmTDbcZU5kpjOC9mzDV6
 xGGVkQofRX61MADcvoLg8Z4sZA0Kt0rVkFjxdfIm36+5kDdGzPU4zQni+IvcaYJZf5rywTFjRMZfU
 KptojWBIrZzSQZ2+8gELQZQsuC/DggwLH4YuTVevvJY9Up0t0eba3d8La2C+4jhQGZNG7C5FXPhlY
 lWkx7KcA==;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf4Yd-00739f-J7
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 17:46:38 +0000
Received: by mail-wm1-f43.google.com with SMTP id s82so5695981wmf.3
 for <linux-nvme@lists.infradead.org>; Fri, 07 May 2021 10:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zD7Bdq9dUY+SmTtwMnbcHhYWkJRgSjitCMf0WPxakU4=;
 b=fAnOGuMmOCGTNJMHDbWP0zX/ijGsJ9IlpwjfVZB+boXxvsP6Jtow+yW7bSz6bMic2k
 Agjj7bYoi5WKd5uzLyRx/+iuUN/t/xYPMLmgpjaGKRzfUp8rk5sN+hez8Vc8iGREck/N
 xqs+pXMim3T0zvxGNkWhug8KkqPYINY4w9PL4dQGn/4ghtsdtxVGDrZ7/eS5x8hZwGOW
 1mdwlWWkVlXcfZM6FVWQpdNKn68I5GYXHNFm1ovOd+RzpZRiz3jETo0Ur/tXtGj3wcZR
 jSMPTWuxoom4+nBX9szd1uX+FpYvhQ9vjnxNzNmRkL5AIOHUHDQf10cLwAeoSQWSpla+
 Hs1w==
X-Gm-Message-State: AOAM530YFtYF8yImQSJ2Ztj0D1emeiVkeZJOSxhtFBK/M67oT8GPJQBE
 H33cYcLr2IImj1gN6/iJXHo=
X-Google-Smtp-Source: ABdhPJw6QMAnkDzfedcUhCuo+dyf9ZrlG2VUCCE2ru/22lUaFb/CH/bBYZW2BDJKEUTqryD+EePBOg==
X-Received: by 2002:a05:600c:4eca:: with SMTP id
 g10mr15458549wmq.180.1620409593956; 
 Fri, 07 May 2021 10:46:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7945:4a4a:9424:5a3f?
 ([2601:647:4802:9070:7945:4a4a:9424:5a3f])
 by smtp.gmail.com with ESMTPSA id u9sm7746233wmc.38.2021.05.07.10.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 May 2021 10:46:33 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: add command tracking trace events
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20210507151150.1278374-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e6c2c484-3429-b1bd-1fae-77c720fcacc5@grimberg.me>
Date: Fri, 7 May 2021 10:46:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210507151150.1278374-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_104635_676366_31BF3F9E 
X-CRM114-Status: GOOD (  30.04  )
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


> Debugging nvme-tcp issues can be difficult due to lack of visibility
> into the driver's execution flow for any particular command. Add trace
> events that detail the command cycle. Also add details to existing error
> messages so they can more readily be matched up with those traces.
> 
> There is no functional change in this patch.

Thanks!

> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/tcp.c       |  46 +++++---
>   drivers/nvme/host/trace-tcp.h | 209 ++++++++++++++++++++++++++++++++++
>   2 files changed, 240 insertions(+), 15 deletions(-)
>   create mode 100644 drivers/nvme/host/trace-tcp.h
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0222e23f5936..bbcf48f6345e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -218,6 +218,9 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +#define CREATE_TRACE_POINTS
> +#include "trace-tcp.h"
> +
>   static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>   		unsigned int dir)
>   {
> @@ -525,6 +528,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
>   
>   	queue->data_remaining = le32_to_cpu(pdu->data_length);
>   
> +	trace_nvme_tcp_c2h(rq, pdu);
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS &&
>   	    unlikely(!(pdu->hdr.flags & NVME_TCP_F_DATA_LAST))) {
>   		dev_err(queue->ctrl->ctrl.device,
> @@ -567,10 +571,13 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>   	struct request *rq = blk_mq_rq_from_pdu(req);
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	u8 ddgst = nvme_tcp_ddgst_len(queue);
> +	unsigned r2t_offset = le32_to_cpu(pdu->r2t_offset);
>   
>   	req->pdu_len = le32_to_cpu(pdu->r2t_length);
>   	req->pdu_sent = 0;
>   
> +	trace_nvme_tcp_r2t(rq, req, r2t_offset);
> +
>   	if (unlikely(!req->pdu_len)) {
>   		dev_err(queue->ctrl->ctrl.device,
>   			"req %d r2t len is %u, probably a bug...\n",
> @@ -580,17 +587,16 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>   
>   	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
>   		dev_err(queue->ctrl->ctrl.device,
> -			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
> -			rq->tag, req->pdu_len, req->data_len,
> -			req->data_sent);
> +			"req %d op %d r2t len %u exceeded data len %u (%zu sent) pdu offset %u\n",

Better to log it "pdu r2t_offset".

> +			rq->tag, req_op(rq), req->pdu_len, req->data_len,
> +			req->data_sent, r2t_offset);
>   		return -EPROTO;
>   	}
>   
> -	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
> +	if (unlikely(r2t_offset < req->data_sent)) {
>   		dev_err(queue->ctrl->ctrl.device,
>   			"req %d unexpected r2t offset %u (expected %zu)\n",
> -			rq->tag, le32_to_cpu(pdu->r2t_offset),
> -			req->data_sent);
> +			rq->tag, r2t_offset, req->data_sent);
>   		return -EPROTO;
>   	}
>   
> @@ -714,6 +720,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	}
>   	req = blk_mq_rq_to_pdu(rq);
>   
> +	trace_nvme_tcp_recv_data(rq, queue, pdu, *offset, *len);

This is the skb offset,len is that what you wanted to log?

>   	while (true) {
>   		int recv_len, ret;
>   
> @@ -730,8 +737,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   			 */
>   			if (!req->curr_bio) {
>   				dev_err(queue->ctrl->ctrl.device,
> -					"queue %d no space in request %#x",
> -					nvme_tcp_queue_id(queue), rq->tag);
> +					"queue %d no space in request %#x data_remaining %lu",

Better to log it "queue data remaining" because its the queue recv state
machine and not the request.

> +					nvme_tcp_queue_id(queue), rq->tag,
> +					queue->data_remaining);
>   				nvme_tcp_init_recv_ctx(queue);
>   				return -EIO;
>   			}
> @@ -920,6 +928,7 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
>   static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
> +	struct request *rq = blk_mq_rq_from_pdu(req);
>   
>   	while (true) {
>   		struct page *page = nvme_tcp_req_cur_page(req);
> @@ -933,6 +942,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   		else
>   			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
>   
> +		trace_nvme_tcp_data(rq, req, offset, len, last);

Maybe call the trace nvme_tcp_send_data?

>   		if (sendpage_ok(page)) {
>   			ret = kernel_sendpage(queue->sock, page, offset, len,
>   					flags);
> @@ -972,7 +982,8 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	int len = sizeof(*pdu) + hdgst - req->offset;
>   	int flags = MSG_DONTWAIT;
> -	int ret;
> +	struct request *rq = blk_mq_rq_from_pdu(req);
> +	int offset, ret;
>   
>   	if (inline_data || nvme_tcp_queue_more(queue))
>   		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> @@ -982,8 +993,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -			offset_in_page(pdu) + req->offset, len,  flags);
> +	offset = offset_in_page(pdu) + req->offset;
> +	trace_nvme_tcp_cmd_pdu(rq, req, offset, len);
> +	ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset,
> +			len,  flags);
>   	if (unlikely(ret <= 0))
>   		return ret;
>   
> @@ -1009,14 +1022,16 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
>   	struct nvme_tcp_data_pdu *pdu = req->pdu;
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	int len = sizeof(*pdu) - req->offset + hdgst;
> -	int ret;
> +	struct request *rq = blk_mq_rq_from_pdu(req);
> +	int offset, ret;
>   
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));

I can add in the digest pieces as well.

>   
> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -			offset_in_page(pdu) + req->offset, len,
> -			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
> +	offset = offset_in_page(pdu) + req->offset;
> +	trace_nvme_tcp_h2c_pdu(rq, req, offset, len);
> +	ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset,
> +			len, MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
>   	if (unlikely(ret <= 0))
>   		return ret;
>   
> @@ -2341,6 +2356,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
>   		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
>   
> +	trace_nvme_tcp_queue_rq(rq);
>   	ret = nvme_tcp_setup_cmd_pdu(ns, rq);
>   	if (unlikely(ret))
>   		return ret;
> diff --git a/drivers/nvme/host/trace-tcp.h b/drivers/nvme/host/trace-tcp.h
> new file mode 100644
> index 000000000000..4c720c8d32c3
> --- /dev/null
> +++ b/drivers/nvme/host/trace-tcp.h
> @@ -0,0 +1,209 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM nvme_tcp
> +
> +#if !defined(_TRACE_NVME_TCP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_NVME_TCP_H
> +
> +#include <linux/nvme.h>
> +#include <linux/tracepoint.h>
> +#include <linux/trace_seq.h>
> +
> +#include "nvme.h"
> +
> +TRACE_EVENT(nvme_tcp_queue_rq,
> +	TP_PROTO(struct request *rq),
> +	TP_ARGS(rq),
> +	TP_STRUCT__entry(
> +		__field(unsigned, ctrl_id)
> +		__field(unsigned, qid)
> +		__field(unsigned, op)
> +		__field(unsigned, tag)
> +		__field(unsigned, len)
> +	),
> +	TP_fast_assign(
> +		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
> +		__entry->qid = nvme_req_qid(rq);
> +		__entry->op = req_op(rq);
> +		__entry->tag = rq->tag;
> +		__entry->len = blk_rq_payload_bytes(rq);
> +	),
> +	TP_printk("nvme%u: qid=%u tag=%x op=%x data_len=%u",
> +		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
> +		__entry->len
> +	)
> +);
> +
> +TRACE_EVENT(nvme_tcp_cmd_pdu,
> +	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset, unsigned len),
> +	TP_ARGS(rq, req, offset, len),
> +	TP_STRUCT__entry(
> +		__field(unsigned, ctrl_id)
> +		__field(unsigned, qid)
> +		__field(unsigned, op)
> +		__field(unsigned, tag)
> +		__field(unsigned, page_offset)
> +		__field(unsigned, len)
> +	),
> +	TP_fast_assign(
> +		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
> +		__entry->qid = nvme_req_qid(rq);
> +		__entry->op = req_op(rq);
> +		__entry->tag = rq->tag;
> +		__entry->page_offset = offset;
> +		__entry->len = len;
> +	),
> +	TP_printk("nvme%u: qid=%u tag=%x op=%x page_offset=%u send_len=%u",
> +		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
> +		__entry->page_offset, __entry->len
> +	)
> +);
> +
> +TRACE_EVENT(nvme_tcp_h2c_pdu,
> +	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset, unsigned len),
> +	TP_ARGS(rq, req, offset, len),
> +	TP_STRUCT__entry(
> +		__field(unsigned, ctrl_id)
> +		__field(unsigned, qid)
> +		__field(unsigned, op)
> +		__field(unsigned, tag)
> +		__field(unsigned, page_offset)
> +		__field(unsigned, len)
> +	),
> +	TP_fast_assign(
> +		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
> +		__entry->qid = nvme_req_qid(rq);
> +		__entry->op = req_op(rq);
> +		__entry->tag = rq->tag;
> +		__entry->page_offset = offset;
> +		__entry->len = len;
> +	),
> +	TP_printk("nvme%u: qid=%u tag=%x op=%x page_offset=%u send_len=%u",
> +		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
> +		__entry->page_offset, __entry->len
> +	)
> +);
> +
> +TRACE_EVENT(nvme_tcp_data,
> +	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset, unsigned len, bool last),
> +	TP_ARGS(rq, req, offset, len, last),
> +	TP_STRUCT__entry(
> +		__field(unsigned, ctrl_id)
> +		__field(unsigned, qid)
> +		__field(unsigned, op)
> +		__field(unsigned, tag)
> +		__field(unsigned, page_offset)
> +		__field(unsigned, len)
> +		__field(unsigned, sent)
> +		__field(bool, last)
> +	),
> +	TP_fast_assign(
> +		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
> +		__entry->qid = nvme_req_qid(rq);
> +		__entry->op = req_op(rq);
> +		__entry->tag = rq->tag;
> +		__entry->page_offset = offset;
> +		__entry->len = len;
> +		__entry->sent = req->pdu_sent;
> +		__entry->last = last;
> +	),
> +	TP_printk("nvme%u: qid=%u tag=%x op=%x page_offset=%u send_len=%u pdu_sent=%u last=%u",
> +		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
> +		__entry->page_offset, __entry->len, __entry->sent, __entry->last
> +	)
> +);
> +
> +TRACE_EVENT(nvme_tcp_r2t,
> +	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset),
> +	TP_ARGS(rq, req, offset),
> +	TP_STRUCT__entry(
> +		__field(unsigned, ctrl_id)
> +		__field(unsigned, qid)
> +		__field(unsigned, op)
> +		__field(unsigned, tag)
> +		__field(unsigned, len)
> +		__field(unsigned, offset)
> +		__field(unsigned, sent)
> +		__field(unsigned, data_len)
> +	),
> +	TP_fast_assign(
> +		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
> +		__entry->qid = nvme_req_qid(rq);
> +		__entry->op = req_op(rq);
> +		__entry->tag = rq->tag;
> +		__entry->len = req->pdu_len;
> +		__entry->offset = offset;
> +		__entry->sent = req->data_sent;
> +		__entry->data_len = req->data_len;
> +	),
> +	TP_printk("nvme%u: qid=%u tag=%x op=%x r2t_len=%u r2t_offset=%u data_sent=%u data_len=%u",
> +		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
> +		__entry->len, __entry->offset, __entry->sent, __entry->data_len
> +	)

What may be useful here (and probably for all incoming pdu types) is to
also log the pdu header details.

Something like: "... ch: type=%x flags=%x hlen=%u plen=%u"

Thoughts?

> +);
> +
> +TRACE_EVENT(nvme_tcp_c2h,
> +	TP_PROTO(struct request *rq, struct nvme_tcp_data_pdu *pdu),
> +	TP_ARGS(rq, pdu),
> +	TP_STRUCT__entry(
> +		__field(unsigned, ctrl_id)
> +		__field(unsigned, qid)
> +		__field(unsigned, op)
> +		__field(unsigned, tag)
> +		__field(unsigned, flags)
> +		__field(unsigned, data_len)
> +	),
> +	TP_fast_assign(
> +		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
> +		__entry->qid = nvme_req_qid(rq);
> +		__entry->op = req_op(rq);
> +		__entry->tag = rq->tag;
> +		__entry->flags = pdu->hdr.flags;
> +		__entry->data_len = le32_to_cpu(pdu->data_length);
> +	),
> +	TP_printk("nvme%u: qid=%u tag=%x op=%x data_len=%u flags=%#x",
> +		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
> +		__entry->data_len, __entry->flags
> +	)

I see you did capture the flags here...

> +);
> +
> +TRACE_EVENT(nvme_tcp_recv_data,
> +	TP_PROTO(struct request *rq, struct nvme_tcp_queue *queue, struct nvme_tcp_data_pdu *pdu, unsigned offset, unsigned len),
> +	TP_ARGS(rq, queue, pdu, offset, len),
> +	TP_STRUCT__entry(
> +		__field(unsigned, ctrl_id)
> +		__field(unsigned, qid)
> +		__field(unsigned, op)
> +		__field(unsigned, tag)
> +		__field(unsigned, flags)
> +		__field(unsigned, data_len)
> +		__field(unsigned, offset)
> +		__field(unsigned, data_remaining)
> +	),
> +	TP_fast_assign(
> +		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
> +		__entry->qid = nvme_req_qid(rq);
> +		__entry->op = req_op(rq);
> +		__entry->tag = rq->tag;
> +		__entry->flags = pdu->hdr.flags;
> +		__entry->data_len = len;
> +		__entry->offset = offset;
> +		__entry->data_remaining = queue->data_remaining;
> +	),
> +	TP_printk("nvme%u: qid=%u tag=%x op=%x data_len=%u offset=%u flags=%#x data_remaining=%u",
> +		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
> +		__entry->data_len, __entry->offset, __entry->flags,
> +		__entry->data_remaining
> +	)
> +);
> +
> +#endif /* _TRACE_NVME_TCP_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE trace-tcp
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
