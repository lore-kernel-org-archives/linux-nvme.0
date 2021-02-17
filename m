Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A647BC433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 13:56:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DB664E4D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 13:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DB664E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ICbsi7KPRe+Br+SUeqQ4wUGngW6ynkkZ7Gw79Qyjlio=; b=hfz+uqtRmPsA4sUGdEdmvmyYO
	VqY4nJxQ4RUBVJlDil1y4Ag0vmjklBF8ONbafalolZgQ7t6zFCE9WB6Yfp59Cg6e7zAwUJSj/aw4f
	d4aQaez0EDI4h/ASzVS2o6mYh5yQDIz755bCDn7Sn587e8aPYRFsv1qeK4pZH4z7NAFFHRhxLvj9x
	Lj8PHaR5ibFbWuzHDjEcxjH8d0sRW5+4vEKCCOeM7L1vGE6y/brk3R9RMVf3cAjYLU9UIzzgspuO8
	D+3QwFM00MXWIFFbAdYKYgW2gxTVUx3bpS3kbjQZZrz6SUbCb7jHdrvSLPQdVuu+t1UsbBAYFuwZx
	VaEawb6Lg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCNJM-0007Ze-Rg; Wed, 17 Feb 2021 13:56:12 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCNJJ-0007Z6-Nf
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 13:56:10 +0000
Received: by mail-yb1-xb36.google.com with SMTP id m188so13773998yba.13
 for <linux-nvme@lists.infradead.org>; Wed, 17 Feb 2021 05:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Euy9q3Dg8nZRt8Xk+Qc+Td8mtT5QMxbfMBj9zzJ8FgI=;
 b=GB0geiCsX4/8p1lbxdeBIZyP+NqRdSwmQVoe5rf4xJg94C6rATYDHSc9nvunUI1ERY
 Wn6kACKAj4cz97c5U2P6xeuI/ijqOLus/2zfQwuF7I5XszW/zELWeXuiYgPjfCavs9Be
 5QnsXBe2+I8MmDDVzS4DLm59D9ex2dPZnWC2hnljj1F737qnT/dcsNskWRsAjJLl71Ym
 BnCkhSWAqufDijB1P6qN2g6td4bbdu7YhlymBsxqREXLbzN5OK7hat+cMu+z44KOQeD4
 SA3OtJwtcZp0TTcVjS65zIkdCP2VT0SQS+zoXRreQcqOrv+hTKRdOyqBzvbBQ3wq/EVZ
 /sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Euy9q3Dg8nZRt8Xk+Qc+Td8mtT5QMxbfMBj9zzJ8FgI=;
 b=RClTwzAGMLbeDCelr7aFj+lzaqkXTck1Yx7nlulPo6RIL1UrGQ3iss/VX7VanPSvSQ
 9Q9VX9cPHkq70OD8VVzlFOMLw5margZPfdioqYEyN8tRPt/XOmwclQlBKseihqgYh2l8
 i8HWW/s9VNkQ0j3Pl97864C7PvzRVJ/cr7BizTp4iV6J8AA9Bh7pu2qIsZD4lLXkv2AH
 e5UcHIuf3Dk49/+l2TpbULX0lrPYA82eoqisDo4cuKhs9zPKN6eMJ2qxpT/r/xM7b316
 5Nk5kQpAsHDhneNOs7gcwnQ4ceM3munCv4WlGz7aK8YTw79E/EWnxUlZHyCQAnf+hcE3
 /xNQ==
X-Gm-Message-State: AOAM5327stA5KuQZZdU33aX9UEDjtejN3L4dnN559sKiX4awKReTlifg
 ucjQxnWzMFFWtCclA1dWHVGJf4K7AXPWTBDvpDs=
X-Google-Smtp-Source: ABdhPJyAnLjigLI3YtVxNWAkyYl7z3qY7zhky7UQIDvgZuepJepZNwDvMPc2RXKJp5XKF6t8rF9Yr24e7tJQ5l8O2gc=
X-Received: by 2002:a25:9383:: with SMTP id a3mr37060610ybm.215.1613570163089; 
 Wed, 17 Feb 2021 05:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20210211211044.32701-1-borisp@mellanox.com>
 <20210211211044.32701-7-borisp@mellanox.com>
 <2dd10b2f-df00-e21c-7886-93f41a987040@gmail.com>
In-Reply-To: <2dd10b2f-df00-e21c-7886-93f41a987040@gmail.com>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Wed, 17 Feb 2021 15:55:51 +0200
Message-ID: <CAJ3xEMjMqK81uNv21poD+DoZCRxYak0DYFZrjDbmWaSxw4R5ig@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 06/21] nvme-tcp: Add DDP offload control path
To: David Ahern <dsahern@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_085609_819710_FAAC3C13 
X-CRM114-Status: GOOD (  28.55  )
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
 Sagi Grimberg <sagi@grimberg.me>, yorayz@nvidia.com, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, Yoray Zack <yorayz@mellanox.com>,
 benishay@nvidia.com, David Miller <davem@davemloft.net>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 Or Gerlitz <ogerlitz@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Feb 14, 2021 at 8:20 PM David Ahern <dsahern@gmail.com> wrote:
> On 2/11/21 2:10 PM, Boris Pismenny wrote:
> > @@ -223,6 +229,164 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
> >       return nvme_tcp_pdu_data_left(req) <= len;
> >  }
> >
> > +#ifdef CONFIG_TCP_DDP
> > +
> > +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> > +static const struct tcp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> > +     .resync_request         = nvme_tcp_resync_request,
> > +};
> > +
> > +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> > +{
> > +     struct net_device *netdev = queue->ctrl->offloading_netdev;
> > +     struct nvme_tcp_ddp_config config = {};
> > +     int ret;
> > +
> > +     if (!(netdev->features & NETIF_F_HW_TCP_DDP))
>
> If nvme_tcp_offload_limits does not find a dst_entry on the socket then
> offloading_netdev may not NULL at this point.

correct :( will look on that

>
> > +             return -EOPNOTSUPP;
> > +
> > +     config.cfg.type         = TCP_DDP_NVME;
> > +     config.pfv              = NVME_TCP_PFV_1_0;
> > +     config.cpda             = 0;
> > +     config.dgst             = queue->hdr_digest ?
> > +             NVME_TCP_HDR_DIGEST_ENABLE : 0;
> > +     config.dgst             |= queue->data_digest ?
> > +             NVME_TCP_DATA_DIGEST_ENABLE : 0;
> > +     config.queue_size       = queue->queue_size;
> > +     config.queue_id         = nvme_tcp_queue_id(queue);
> > +     config.io_cpu           = queue->io_cpu;
> > +
> > +     dev_hold(netdev); /* put by unoffload_socket */
> > +     ret = netdev->tcp_ddp_ops->tcp_ddp_sk_add(netdev,
> > +                                               queue->sock->sk,
> > +                                               &config.cfg);
> > +     if (ret) {
> > +             dev_put(netdev);
> > +             return ret;
> > +     }
> > +
> > +     inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
> > +     if (netdev->features & NETIF_F_HW_TCP_DDP)
> > +             set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> > +
> > +     return ret;
> > +}
> > +
> > +static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> > +{
> > +     struct net_device *netdev = queue->ctrl->offloading_netdev;
> > +
> > +     if (!netdev) {
> > +             dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
>
> you are already logged in nvme_tcp_offload_limits that
> get_netdev_for_sock returned NULL; no need to do it again.

yeah, re this one and the few other places where you commented
on the same or similar thing, I tend to agree we need to go on the
kernel trusted programming paradigm and avoid over checking, will
discuss that with the team.


> > +             return;
> > +     }
> > +
> > +     netdev->tcp_ddp_ops->tcp_ddp_sk_del(netdev, queue->sock->sk);
> > +
> > +     inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;
> > +     dev_put(netdev); /* held by offload_socket */
> > +}
> > +
> > +static int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
> > +{
> > +     struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
> > +     struct tcp_ddp_limits limits;
> > +     int ret = 0;
> > +
> > +     if (!netdev) {
> > +             dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
>
> This should be more informative.

okk

> > +             queue->ctrl->offloading_netdev = NULL;
> > +             return -ENODEV;
> > +     }
> > +
> > +     if (netdev->features & NETIF_F_HW_TCP_DDP &&
> > +         netdev->tcp_ddp_ops &&
> > +         netdev->tcp_ddp_ops->tcp_ddp_limits)
> > +             ret = netdev->tcp_ddp_ops->tcp_ddp_limits(netdev, &limits);
> > +     else
> > +             ret = -EOPNOTSUPP;
> > +
> > +     if (!ret) {
> > +             queue->ctrl->offloading_netdev = netdev;
>
> you save a reference to the netdev here, but then release the refcnt
> below. That device could be deleted between this point in time and the
> initialization of all queues.

> > +             dev_dbg_ratelimited(queue->ctrl->ctrl.device,
> > +                                 "netdev %s offload limits: max_ddp_sgl_len %d\n",
> > +                                 netdev->name, limits.max_ddp_sgl_len);
> > +             queue->ctrl->ctrl.max_segments = limits.max_ddp_sgl_len;
> > +             queue->ctrl->ctrl.max_hw_sectors =
> > +                     limits.max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
> > +     } else {
> > +             queue->ctrl->offloading_netdev = NULL;
> > +     }
> > +
> > +     /* release the device as no offload context is established yet. */
> > +     dev_put(netdev);
> > +
> > +     return ret;
> > +}
> > +
> > +static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> > +                                  struct sk_buff *skb, unsigned int offset)
> > +{
> > +     u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
> > +     struct net_device *netdev = queue->ctrl->offloading_netdev;
> > +     u64 resync_val;
> > +     u32 resync_seq;
> > +
> > +     resync_val = atomic64_read(&queue->resync_req);
> > +     /* Lower 32 bit flags. Check validity of the request */
> > +     if ((resync_val & TCP_DDP_RESYNC_REQ) == 0)
> > +             return;
> > +
> > +     /* Obtain and check requested sequence number: is this PDU header before the request? */
> > +     resync_seq = resync_val >> 32;
> > +     if (before(pdu_seq, resync_seq))
> > +             return;
> > +
> > +     if (unlikely(!netdev)) {
> > +             pr_info_ratelimited("%s: netdev not found\n", __func__);
>
> can't happen right? you get here because NVME_TCP_Q_OFF_DDP is set and
> it is only set if offloading_netdev is set and the device supports offload.

as I wrote above, will discuss this general comment and likely
go the direction you are pointing on

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
