Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F84C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:20:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7564B64DF0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7564B64DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BGd7HTNFjqb47nhNgViW8MD/LfyNbyLLpCMrbc1/6uA=; b=ma2Nq84kGA6eoXOXQVzxyQ9sw
	PPnd/4RXQc7isyzKx0CCaytxgQR/sRruNIkyCxgShpAaVMHfu/nMcZSUJ/+1G5Yl8g62vp2M5ZFei
	+fv1JH2jD32D8zfmnwaL+480RLeji+51OyRCv2wO8dGvxO/q6f8bCSyMgAzG6C2QEU29u6NKmNHRq
	XnYPN9DFSCWFXf1MA4NjMr3WX2ow2FWLmVM6sesHEzzotQXRD1+PypQRt7UJK4aHm/RqMDxwO3W9f
	NP5Bt52dA9RX74Nyh/KsB1gzTtmHZQP9U7Kzp9AQm7sWIPKDV2x/OAxI8VjeyaViqziLFWHPoIWzU
	viAMD3Vrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7kBA-0007T2-O2; Thu, 04 Feb 2021 19:20:36 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7kB8-0007Sh-Me
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 19:20:35 +0000
Received: by mail-yb1-xb36.google.com with SMTP id i6so4311270ybq.5
 for <linux-nvme@lists.infradead.org>; Thu, 04 Feb 2021 11:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oAPvN9PvQ0aeegkq7czJXnWT6Ex32v8rIdvrvrQ0TK4=;
 b=bSCfIjwmVna6/En2QBXXGJdT4hSi1eZn7wg1Urn4e2JSe0ysn3ARxtJyLWHyL/CzNf
 2qjJ3BUL0eofbInj7Ia5p5ZVDw0EK5Rcjysjc/pMlK/ftS7zFuGEL62HGqDexen65wu3
 2yFFk/x1d+ykf5LKzytqwrkVWQps0tO40M+doKiWDoqbxVCUXd9P3hQhpBR2oBcjyZhR
 g6GdXNEVeb2eir/zPqcZ5y7RHgUbgFYxhYLPcWt1BlEVkBgH0lwnzM2V7IogdChyWvBB
 QULfqEK2+qYII6V0gbyDXHJ9ZKTnkuIbeyezUao4qxV76u3IgVRFQgYX2N+a/IDGVvpG
 CUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oAPvN9PvQ0aeegkq7czJXnWT6Ex32v8rIdvrvrQ0TK4=;
 b=Ndt02nfNoDg081+K51xXDx3K/I0F+IKQ+gJHilHBAfeGsPXFYxu02anINOXKYhGGTG
 HBY0lCsQzdZ/mzPctc82ExAYD5fil7+4x6mnkWXRWFTQJft7E07zBL1TF6mYnpmjzgXy
 BNyGi5F43wtU9wF31daKDrUxupp5tbdbbDvmp8PkCnOKa3O+e3WGZvcO83bY2bR2KC9O
 pW+7x5OgERs/H2TGYN+ALlahUwmMxhVyk8XyX8eG74Ba32BpdgKXeRdWVk94ipPQ7RTY
 sqTXcaLdy0W7DUK/XzHhmIGF6PZybX4eORdOHmojx8D1p1gibthMay7tEeqUU1nK/xLS
 KteA==
X-Gm-Message-State: AOAM533mNajE4lQY+ssxasVH+Jq3Ce976xpJSOUj/FsKv1zIH1l4jdlt
 i6q2MzE6A0JJCrW1k1bR57kbmWbIYtlgM7HJ1CI=
X-Google-Smtp-Source: ABdhPJzcjaMba+lk9vznshdtjf7avhXwZ3ue3+X8Y+1o3f8/F7oa/dcNU4gqkY1fMEd32vUXrbDiw6QEIPq6Arq6fmk=
X-Received: by 2002:a25:858e:: with SMTP id x14mr1080558ybk.257.1612466433019; 
 Thu, 04 Feb 2021 11:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-8-borisp@mellanox.com>
 <9a8041aa-513f-09b9-63f4-3d12db19231c@grimberg.me>
In-Reply-To: <9a8041aa-513f-09b9-63f4-3d12db19231c@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 4 Feb 2021 21:20:21 +0200
Message-ID: <CAJ3xEMh90F8LKn2CCW5pP83moVQ3+O8ON_7q0HmoD8YNyomKyA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 07/21] nvme-tcp: Add DDP data-path
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_142035_044924_AC435831 
X-CRM114-Status: GOOD (  22.50  )
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
Cc: smalin@marvell.com, linux-nvme@lists.infradead.org,
 Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, benishay@nvidia.com,
 David Miller <davem@davemloft.net>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Linux Netdev List <netdev@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Ahern <dsahern@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Or Gerlitz <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 3, 2021 at 10:54 AM Sagi Grimberg <sagi@grimberg.me> wrote:

> > +static
> > +int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> > +                       u16 command_id,
> > +                       struct request *rq)
> > +{
> > +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> > +     struct net_device *netdev = queue->ctrl->offloading_netdev;
> > +     int ret;
> > +
> > +     if (unlikely(!netdev)) {
> > +             pr_info_ratelimited("%s: netdev not found\n", __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = netdev->tcp_ddp_ops->tcp_ddp_teardown(netdev, queue->sock->sk,
> > +                                                 &req->ddp, rq);
> > +     sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> > +     req->offloaded = false;
>
> Why is the offloaded = false needed here? you also clear it when you setup.

yep, there two places where we needlessly falsified the offloaded flag
- will remove them

The lifetime rules are - set to false on cmd setup and set to true in
ddp setup if it succeeded

>
> > +     return ret;
> > +}
> > +
> > +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> > +{
> > +     struct request *rq = ddp_ctx;
> > +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> > +
> > +     if (!nvme_try_complete_req(rq, cpu_to_le16(req->status << 1), req->result))
> > +             nvme_complete_rq(rq);
>
> Why is the status shifted here? it was taken from the cqe as is..

there are two cases

1. the status is taken from the cqe as is
2. the status is taken from the req with shift left (the success bit
IO read flow)

for #2 we already do the shift left in nvme_tcp_end_request so no need to
repeat it here,  will fix

>
> > +}
> > +
> > +static
> > +int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> > +                    u16 command_id,
> > +                    struct request *rq)
> > +{
> > +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> > +     struct net_device *netdev = queue->ctrl->offloading_netdev;
> > +     int ret;
> > +
> > +     req->offloaded = false;
> > +
> > +     if (unlikely(!netdev)) {
> > +             pr_info_ratelimited("%s: netdev not found\n", __func__);
>
> dev_info_ratelimited please.

ok

> > +             return -EINVAL;
> > +     }
> > +
> > +     req->ddp.command_id = command_id;
> > +     req->ddp.sg_table.sgl = req->ddp.first_sgl;
> > +     ret = sg_alloc_table_chained(&req->ddp.sg_table, blk_rq_nr_phys_segments(rq),
> > +                                  req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
> > +     if (ret)
> > +             return -ENOMEM;
> > +     req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
> > +
> > +     ret = netdev->tcp_ddp_ops->tcp_ddp_setup(netdev,
> > +                                              queue->sock->sk,
> > +                                              &req->ddp);
> > +     if (!ret)
> > +             req->offloaded = true;
> > +     return ret;
> > +}
> > +
> >   static
> >   int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> >   {
> > @@ -377,6 +446,25 @@ bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
> >
> >   #else
> >
> > +static
> > +int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> > +                    u16 command_id,
> > +                    struct request *rq)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> > +static
> > +int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> > +                       u16 command_id,
> > +                       struct request *rq)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> > +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> > +{}
> > +
> >   static
> >   int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> >   {
> > @@ -665,6 +753,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> >   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
> >               struct nvme_completion *cqe)
> >   {
> > +     struct nvme_tcp_request *req;
> >       struct request *rq;
> >
> >       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
> > @@ -676,8 +765,15 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
> >               return -EINVAL;
> >       }
> >
> > -     if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> > -             nvme_complete_rq(rq);
> > +     req = blk_mq_rq_to_pdu(rq);
> > +     if (req->offloaded) {
> > +             req->status = cqe->status;
> > +             req->result = cqe->result;
> > +             nvme_tcp_teardown_ddp(queue, cqe->command_id, rq);
> > +     } else {
> > +             if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> > +                     nvme_complete_rq(rq);
> > +     }
>
> Maybe move this to nvme_tcp_complete_request as it is called from two
> code paths.

to make sure, add

void nvme_tcp_complete_request(struct request *rq, u16 status, union
nvme_result *res, u16 status)

and invoke it from the two calls sites?

> >       queue->nr_cqe++;
> >
> >       return 0;
> > @@ -871,9 +967,18 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> >   static inline void nvme_tcp_end_request(struct request *rq, u16 status)
> >   {
> >       union nvme_result res = {};
> > +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> > +     struct nvme_tcp_queue *queue = req->queue;
> > +     struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
> >
> > -     if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> > -             nvme_complete_rq(rq);
> > +     if (req->offloaded) {
> > +             req->status = cpu_to_le16(status << 1);
> > +             req->result = res;
> > +             nvme_tcp_teardown_ddp(queue, pdu->command_id, rq);
> > +     } else {
> > +             if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> > +                     nvme_complete_rq(rq);
> > +     }
> >   }
> >
> >   static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> > @@ -920,12 +1025,22 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> >               recv_len = min_t(size_t, recv_len,
> >                               iov_iter_count(&req->iter));
> >
> > -             if (queue->data_digest)
> > -                     ret = skb_copy_and_hash_datagram_iter(skb, *offset,
> > -                             &req->iter, recv_len, queue->rcv_hash);
> > -             else
> > -                     ret = skb_copy_datagram_iter(skb, *offset,
> > -                                     &req->iter, recv_len);
> > +             if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
> > +                     if (queue->data_digest)
> > +                             ret = skb_ddp_copy_and_hash_datagram_iter(skb, *offset,
> > +                                             &req->iter, recv_len, queue->rcv_hash);
> > +                     else
> > +                             ret = skb_ddp_copy_datagram_iter(skb, *offset,
> > +                                             &req->iter, recv_len);
> > +             } else {
> > +                     if (queue->data_digest)
> > +                             ret = skb_copy_and_hash_datagram_iter(skb, *offset,
> > +                                             &req->iter, recv_len, queue->rcv_hash);
> > +                     else
> > +                             ret = skb_copy_datagram_iter(skb, *offset,
> > +                                             &req->iter, recv_len);
> > +             }
> > +
>
> Maybe move this hunk to nvme_tcp_consume_skb or something?

ok, we can add

int nvme_tcp_consume_skb(queue, skb, offset, iter, recv_len)

and put this hunk there

> > @@ -2464,6 +2584,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
> >       req->data_len = blk_rq_nr_phys_segments(rq) ?
> >                               blk_rq_payload_bytes(rq) : 0;
> >       req->curr_bio = rq->bio;
> > +     req->offloaded = false;
>
> offloaded is being cleared lots of times, and I'm not clear what are
> the lifetime rules here.

replied above

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
