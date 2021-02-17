Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B084C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 14:02:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DEF64DBD
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 14:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DEF64DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Pne7ZrfdNteXQXYbESdb1R3tWKYhmCiXl/Nu8EjtBUQ=; b=K5mhnAsgF+1gf2ZmmSgpp/Bby
	k/hHY51PJ0JautpHM5rxdcJNAX9sJAdS4trYrkyg/aqzsdOrzOBn1QmHwtx2ir9fnmjWnZdbFK8hL
	S87+RcYadhSbcMelnwjCcReoDoAq/7HIGibrwBkTiPMcMoykUC5oWmYXH85Ah1x7JSf+91ihDpONA
	ipPyQ+GWpN+kSuJjfWfjxJD38Xp6nO3evNgkAv4PKEtIFeA9Nugr7jFSaUtVcK+zxioCdbXrwL/0A
	W/xm4BYvKFUkoFy/HYFbidzmBVNT9fgvqPM/8WV10XDj7kASErHibYqWTqsqm7ro64iBVSg/7zSYI
	reple5eOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCNOU-00088I-3w; Wed, 17 Feb 2021 14:01:30 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCNOR-00087R-HM
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 14:01:28 +0000
Received: by mail-yb1-xb34.google.com with SMTP id l8so13819183ybe.12
 for <linux-nvme@lists.infradead.org>; Wed, 17 Feb 2021 06:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cG0ZCrhxDmfLowBT67ycPSjzuXTsCVhbGgDwz/Q0RjI=;
 b=TSh77xs4RDgnUP8XsfODubsjshqjFNOeiV/VN3vrMvGag/iLsFh5tPO+qNgrN6ccEU
 ZTItNQyqYhpptWVCgMqmLVWYPc6kChK/OGxi5ta8grn0heCHbNSF4aDYBeNAJm4u98uR
 OtphwugFC0r9Hlj/+RpouuOO4rVTpN1S60OYpykaZhQfJ6HOa96i3wYNX+yg0MhlWihV
 E8+JS/NWI2sgmXd+7oYipZJ7RBxkq9j08Iw/Lr9IAwJ0vE/tcOU49IXUwopBzR+MZvKl
 OLqpWa3vNw3bf4GLYCJX/3O8zLh0wVsI2dXz0nlYlux9kcFjL0gsRXVcj8gQFaXFtx5h
 4qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cG0ZCrhxDmfLowBT67ycPSjzuXTsCVhbGgDwz/Q0RjI=;
 b=aRUk68OK8ZQ5E+f+nAJ4klA5Ut473X6KEJtOgQFKGxqq7GbcNBjHPH7JaB3pFQEj4y
 XTEKptw5uwCw28PgfC+KAA1akjEckOso5cj7sTD3NLq6hneV2J1UYUgpt43MzL0T1J19
 O0tQ0uKDMlChZiPZ7IZkASF8CHJUfKxoa9bPaaZGeZMy9AbqxpNTgVMCxZiGQPAFlRl6
 MAvr1BHrSUcPx5u+xdHBluYodlauqxJnSekk5FRo0xnfYXNZTi8CPMtmbZJ3F3biU/kI
 /yQf6sh/Jcud3LLRmVSH+JwM3V8engsveYX62QXB8P4iwiaKiao74bLQ6JVSDBRJ455/
 PP8w==
X-Gm-Message-State: AOAM533ef0tHKFAmEkpkA3uWCgSi8mIQLHkVm9c5Kb360E44aaOU4K0Z
 GCXcpk1tkU4q+uWF72PL923PaG3R7lZYtWDlzfE=
X-Google-Smtp-Source: ABdhPJy88s3nCoo7Mqqws77w2F2jGj/7sxyUUA+DN57SgF0O799UTH41qKGwtTptiiTzp5ApuJ9IJxzU+BL42/y/2GA=
X-Received: by 2002:a25:3417:: with SMTP id b23mr37471288yba.257.1613570485455; 
 Wed, 17 Feb 2021 06:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20210211211044.32701-1-borisp@mellanox.com>
 <20210211211044.32701-8-borisp@mellanox.com>
 <cfd61c5a-c5fd-e0d9-fb60-be93f1c98735@gmail.com>
In-Reply-To: <cfd61c5a-c5fd-e0d9-fb60-be93f1c98735@gmail.com>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Wed, 17 Feb 2021 16:01:14 +0200
Message-ID: <CAJ3xEMgZg9dFyc8cnbuPPAFT3jd2k27TdLOz-vtVmxy9k9zHcg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 07/21] nvme-tcp: Add DDP data-path
To: David Ahern <dsahern@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_090127_651851_0212BB2C 
X-CRM114-Status: GOOD (  22.99  )
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
Cc: smalin@marvell.com, Sagi Grimberg <sagi@grimberg.me>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, linux-nvme@lists.infradead.org,
 David Miller <davem@davemloft.net>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Or Gerlitz <ogerlitz@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Feb 14, 2021 at 8:30 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 2/11/21 2:10 PM, Boris Pismenny wrote:
> >
> > +static int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> > +                              u16 command_id,
> > +                              struct request *rq)
> > +{
> > +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> > +     struct net_device *netdev = queue->ctrl->offloading_netdev;
> > +     int ret;
> > +
> > +     if (unlikely(!netdev)) {
> > +             dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
>
> again, unnecessary. you only get here because the rquest is marked
> offloaded and that only happens if the netdev exists and supports DDP.
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = netdev->tcp_ddp_ops->tcp_ddp_teardown(netdev, queue->sock->sk,
> > +                                                 &req->ddp, rq);
> > +     sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> > +     return ret;
> > +}
> > +
> > +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> > +{
> > +     struct request *rq = ddp_ctx;
> > +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> > +
> > +     if (!nvme_try_complete_req(rq, req->status, req->result))
> > +             nvme_complete_rq(rq);
> > +}
> > +
> > +static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> > +                           u16 command_id,
> > +                           struct request *rq)
> > +{
> > +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> > +     struct net_device *netdev = queue->ctrl->offloading_netdev;
> > +     int ret;
> > +
> > +     if (unlikely(!netdev)) {
> > +             dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
>
> similarly here. you can't get here if netdev is null.
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     req->ddp.command_id = command_id;
> > +     ret = nvme_tcp_req_map_sg(req, rq);
> > +     if (ret)
> > +             return -ENOMEM;
> > +
> > +     ret = netdev->tcp_ddp_ops->tcp_ddp_setup(netdev,
> > +                                              queue->sock->sk,
> > +                                              &req->ddp);
> > +     if (!ret)
> > +             req->offloaded = true;
> > +     return ret;
> > +}
> > +
> >  static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> >  {
> >       struct net_device *netdev = queue->ctrl->offloading_netdev;
> > @@ -343,7 +417,7 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> >               return;
> >
> >       if (unlikely(!netdev)) {
> > -             pr_info_ratelimited("%s: netdev not found\n", __func__);
> > +             dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
>
> and per comment on the last patch, this is not needed.
>
> > @@ -849,10 +953,39 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> >
> >  static inline void nvme_tcp_end_request(struct request *rq, u16 status)
> >  {
> > +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> > +     struct nvme_tcp_queue *queue = req->queue;
> > +     struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
> >       union nvme_result res = {};
> >
> > -     if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> > -             nvme_complete_rq(rq);
> > +     nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res, pdu->command_id);
> > +}
> > +
> > +
> > +static int nvme_tcp_consume_skb(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> > +                             unsigned int *offset, struct iov_iter *iter, int recv_len)
> > +{
> > +     int ret;
> > +
> > +#ifdef CONFIG_TCP_DDP
> > +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
> > +             if (queue->data_digest)
> > +                     ret = skb_ddp_copy_and_hash_datagram_iter(skb, *offset, iter, recv_len,
> > +                                     queue->rcv_hash);
> > +             else
> > +                     ret = skb_ddp_copy_datagram_iter(skb, *offset, iter, recv_len);
> > +     } else {
> > +#endif
>
> why not make that a helper defined in the CONFIG_TCP_DDP section with an
> inline for the unset case. Keeps this code from being polluted with the
> ifdef checks.

will check that

>
> > +             if (queue->data_digest)
> > +                     ret = skb_copy_and_hash_datagram_iter(skb, *offset, iter, recv_len,
> > +                                     queue->rcv_hash);
> > +             else
> > +                     ret = skb_copy_datagram_iter(skb, *offset, iter, recv_len);
> > +#ifdef CONFIG_TCP_DDP
> > +     }
> > +#endif
> > +
> > +     return ret;
> >  }
> >
> >  static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> > @@ -899,12 +1032,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> >               recv_len = min_t(size_t, recv_len,
> >                               iov_iter_count(&req->iter));
> >
> > -             if (queue->data_digest)
> > -                     ret = skb_copy_and_hash_datagram_iter(skb, *offset,
> > -                             &req->iter, recv_len, queue->rcv_hash);
> > -             else
> > -                     ret = skb_copy_datagram_iter(skb, *offset,
> > -                                     &req->iter, recv_len);
> > +             ret = nvme_tcp_consume_skb(queue, skb, offset, &req->iter, recv_len);
> >               if (ret) {
> >                       dev_err(queue->ctrl->ctrl.device,
> >                               "queue %d failed to copy request %#x data",
> > @@ -1128,6 +1256,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
> >       bool inline_data = nvme_tcp_has_inline_data(req);
> >       u8 hdgst = nvme_tcp_hdgst_len(queue);
> >       int len = sizeof(*pdu) + hdgst - req->offset;
> > +     struct request *rq = blk_mq_rq_from_pdu(req);
> >       int flags = MSG_DONTWAIT;
> >       int ret;
> >
> > @@ -1136,6 +1265,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
> >       else
> >               flags |= MSG_EOR;
> >
> > +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) &&
> > +         blk_rq_nr_phys_segments(rq) && rq_data_dir(rq) == READ)
> > +             nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);
> > +
>
> For consistency, shouldn't this be wrapped in the CONFIG_TCP_DDP check too?

We tried to avoid the wrapping in some places where it was
possible to do without adding confusion, this one is a good
example IMOH.


> >       if (queue->hdr_digest && !req->offset)
> >               nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
> >

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
