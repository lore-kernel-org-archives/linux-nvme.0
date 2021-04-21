Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB2FC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 14:29:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BF961452
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 14:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BF961452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+daDcWDseRgVH7JpeYig2n+9Qhh7g2hzEG4dyCJZWtE=; b=EoDxfpjns8my8edpw904Tqwfm
	cx6ym5SpB0StaMZukesi4ASINcmGxJZhjZMMNB/aLZ/OcecDIzk26WuRarrPnj1NJ/grJ4iQA8usA
	GsUDd6G8lKJLl7Xkdyd9vS1SJsY7go0yT0znY5UN6aUzuDJPzq5NpJy34LUI9MtmdzPVKKzth4wjR
	qKThnv+iNWYFDTRmmtDLokvIlUpBzN8yhx71Lt3CrSGk1Q37pur43fTPNyRULVYPuTqes87oy/m2s
	TrvPt/NuZeaf6HzW8nTxYpX4uhnmtASxscWzD0QbZ6JNGPMcSMJzlvyFPKfVD7ON/XLgzyadoJI+O
	A9Mqqez8w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZDqX-00EaYO-QW; Wed, 21 Apr 2021 14:28:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZDqR-00EaY1-TL
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 14:28:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1PwzneyURdDlxtTGcRmpo6TkrJaPAmvgylPDuk1HdYY=; b=Tp7cwTeECxeVZDWfNT1Pj/9dB8
 tzHOjcQh4psUiCd9Aa2QDnmtg6SQP/T6GOL+jLN+GyXbajoaYUQAnjbRbOhzVE3cyTAct0Uc2g/i0
 AK88iLdnNny68I61RA1n2B5VEJoF5t7a/25cXQH0amVxk4nUrhrBCT3SXjlkC6PJbsF3nAK2u5LsR
 poKOUYO/eJ9McmD4ZH9yd6GIdBNBQu97mrPR9wsCCKk+GgeUHcAmxY6f7h2G3wiz92gJUh/6ESP62
 5l80CAlHixXbaStUcdi4SeLWFQgUDLL/4QFnnRT1tXQT4rnopJ6mfCjKa0CoLlyuio+oq8NVMAL+o
 a/1FpoQA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZDqO-00CxQn-EU
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 14:28:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1CC86144B;
 Wed, 21 Apr 2021 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619015324;
 bh=i+NGHLy9KwlkwhupNx3P7XfqVjH1NwC3QYuPgp/qyCg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fXLpV918pKqlUU65a56CtEJVtgvTkokYdaVK4Us3d9sV3VIhfW9a0zVXZIHKbT0+T
 pvVYwo/139pxGukDitU+7uu3lDRYig8sOjh2Yn8ekdVhxd5D+lEUQvNx8SPBctnfVH
 8tgopOKCFpimxW+FOrXx+7I4fAob031EAwHj0N5MqEgT5nnzAIwjLzOHvbX5oOIuUm
 nD1oo3zpjRFxqhI6yet+CrEifkOC0hZ8c/Uf0+PnDjqUnrD6UvWxaVNxflHP6P9pPI
 4ssfwL2qGfRRg/6KRG8fF/eBTN6O5CGV9L5GyE3GxYhZn9zBa7JCuGPNJucOoQwyst
 OYNZYaTiuNGhQ==
Date: Wed, 21 Apr 2021 07:28:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210421142841.GA3575546@dhcp-10-100-145-180.wdc.com>
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_072844_559319_478BEA7D 
X-CRM114-Status: GOOD (  21.07  )
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

On Tue, Apr 20, 2021 at 10:33:30PM -0700, Sagi Grimberg wrote:
> Can you retry with the following applied on top of what I sent you?

Thanks, we'll give this a try. Just a quick question on the first patch:

> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index c60c1dcfb587..ff39d37e9793 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -63,6 +63,7 @@ struct nvme_tcp_request {
>         /* send state */
>         size_t                  offset;
>         size_t                  data_sent;
> +       size_t                  data_recvd;
>         enum nvme_tcp_send_state state;
>         enum nvme_tcp_cmd_state cmd_state;
>  };
> @@ -769,6 +770,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue
> *queue, struct sk_buff *skb,
>                 *len -= recv_len;
>                 *offset += recv_len;
>                 queue->data_remaining -= recv_len;
> +               req->data_recvd += recv_len;

Does this need to get reset to 0 during the initial setup? It looks like
a "req->data_recvd = 0" in nvme_tcp_setup_cmd_pdu() should happen, no?

>         }
> 
>         if (!queue->data_remaining) {
> @@ -776,6 +778,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue
> *queue, struct sk_buff *skb,
>                         nvme_tcp_ddgst_final(queue->rcv_hash,
> &queue->exp_ddgst);
>                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>                 } else {
> +                       BUG_ON(req->data_recvd != req->data_len);
>                         req->cmd_state = NVME_TCP_CMD_DATA_DONE;
>                         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
>                                 req->cmd_state = NVME_TCP_CMD_DONE;
> --
> 
> There might be a hidden assumption here that may cause this if multiple
> c2hdata pdus will come per request...
> 
> If that is the case, you can try the following (on top):
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ff39d37e9793..aabec8e6810a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -773,19 +773,20 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue
> *queue, struct sk_buff *skb,
>                 req->data_recvd += recv_len;
>         }
> 
> -       if (!queue->data_remaining) {
> +       if (!queue->data_remaining)
> +               nvme_tcp_init_recv_ctx(queue);
> +
> +       if (req->data_recvd == req->data_len) {
>                 if (queue->data_digest) {
>                         nvme_tcp_ddgst_final(queue->rcv_hash,
> &queue->exp_ddgst);
>                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>                 } else {
> -                       BUG_ON(req->data_recvd != req->data_len);
>                         req->cmd_state = NVME_TCP_CMD_DATA_DONE;
>                         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
>                                 req->cmd_state = NVME_TCP_CMD_DONE;
>                                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
>                                 queue->nr_cqe++;
>                         }
> -                       nvme_tcp_init_recv_ctx(queue);
>                 }
>         }
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
