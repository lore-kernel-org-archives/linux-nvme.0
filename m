Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35A3C433DB
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:40:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404B764E3A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404B764E3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/lwnVxgKg2ddYYmh8AUyKVLbEGrKOT9K0CLFrRS6hbo=; b=dhgscvytMWUJq6Q5ybRPBBq/9
	sxix/OL7+km6/yB2omzyrdF6dV3gNu6NpgmaqG2L1MvzXMYFfKPBXwClpLAxE1s7UKXcd+Gqc0/5f
	DGOiNWwSBjWWVSYLEQ3BfB+GUL6Wk5N8CBVd0j57m7UYQcGsVU6w3FkU+BnkSt6SgntnpBwgGb/oL
	LgX/jJoMCd7a1ttJswgyFUBQdgnZRLSjvDLoLtchKbZemnxmAjq3SWhSToY/I/SfE1lPdixuhG2Pw
	KXk7hJrnqxM7p86Ojf0g3XedK+wZfrKbeoqCXEF/rbX+Li8n3mkM+JzI52xFrBme67vxArA3ziWfx
	eMYRSoyTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8n6x-000075-Im; Sun, 07 Feb 2021 16:40:35 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8n6u-00006I-CX
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 16:40:33 +0000
Received: by mail-yb1-xb34.google.com with SMTP id s61so12208649ybi.4
 for <linux-nvme@lists.infradead.org>; Sun, 07 Feb 2021 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+af15nnN8Mn8kOsFGJ+l1sBVQPZaanqdoowobKS9Qxk=;
 b=GxmeiTvVodXKD4Oj++FV2fD0HnNlCRyoQDIkLrQPlXuwmcF8LP+S5sHuEDTLyQ2MP4
 tUn05ggz87AB285/kg3VPSvQvnEQRj0+BZk8+fIvjszHlnbLQf9OStlzUT+9gZBlHRf/
 aW3pY4gV40+GI7ugPnsCZ/qjK41Ii3vpp28uN0SNcB0D4880frKfdPbdrCg+NBxxovJE
 APtknchrVGRI1S5KqJVock0ZRR+khNRdlge+tRVktzD1NgPY+X/3q1czRiiYtaIkazTC
 C29BBhMV8sYalE4OXpHez4oJmsOH8KFYD3K34RkEBmJ4Q6zlYAj/lqc5iSntJYJP0rt/
 rEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+af15nnN8Mn8kOsFGJ+l1sBVQPZaanqdoowobKS9Qxk=;
 b=dMyxvxVpW36QXs82oy9s+tglcrUiQT0Zh7nY7LVrcpJSPOswvnl63ByrzMdD5xVYoT
 66GxtUyry5pdRU4ATF/KobRvc2CKM5ZVQelJIhnjFu4x/T9X6T5IL7Q8f5xxynuC8ejT
 aQjZqvXmKcSjdh+m6xvRlmfDU6OtJ587wGc1U/IzwnEqXAY7VlHjzvqlGT+cWpvWk8Ec
 BICIa0GrjR9ktoJrekT2oSX4VEYq7FXmRZmNjFyg+K9BeGDPUwBPo0j9boJi4VgblW/h
 7v2w8xEzFRLPFopTa+NE14ao3hvS4L7di0n4PJnCmqS2U5lzdyT0X6rn01R3Sv/kjx3Z
 i0Lw==
X-Gm-Message-State: AOAM532+m3TZWIlaxqtNWVvRzHpQd7InEl4pD4mbY95QYNvFBISbQDAi
 7+Bqw51O6BJeG9wIBJsnfV7suckOYRoBK6DcUwI=
X-Google-Smtp-Source: ABdhPJwyYXzZbHbMFDkYDfS3ULyfXLG63yzTIosMwgSvayHRyyqmfOyye4rMeqRM2LTTkg4X7qjY44TgDFfe4kl9xm8=
X-Received: by 2002:a25:1646:: with SMTP id 67mr20565556ybw.97.1612716028667; 
 Sun, 07 Feb 2021 08:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-9-borisp@mellanox.com>
 <a104a5d1-b4cb-4275-6ced-b80f911b6f47@grimberg.me>
In-Reply-To: <a104a5d1-b4cb-4275-6ced-b80f911b6f47@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Sun, 7 Feb 2021 18:40:17 +0200
Message-ID: <CAJ3xEMjnCzs7+6iusPdD666KodjdAfZCUn0rhUZa6wd_qL+kWQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 08/21] nvme-tcp : Recalculate crc in the end
 of the capsule
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_114032_484067_5D0400FE 
X-CRM114-Status: GOOD (  17.32  )
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

On Wed, Feb 3, 2021 at 11:12 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> On 2/1/21 2:04 AM, Boris Pismenny wrote:

> > @@ -290,12 +341,9 @@ int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> >       }
> >
> >       req->ddp.command_id = command_id;
> > -     req->ddp.sg_table.sgl = req->ddp.first_sgl;
> > -     ret = sg_alloc_table_chained(&req->ddp.sg_table, blk_rq_nr_phys_segments(rq),
> > -                                  req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
> > +     ret = nvme_tcp_req_map_sg(req, rq);
>
> Why didn't you introduce nvme_tcp_req_map_sg in the first place?

OK, will do

> >       if (ret)
> >               return -ENOMEM;
> > -     req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
> >
> >       ret = netdev->tcp_ddp_ops->tcp_ddp_setup(netdev,
> >                                                queue->sock->sk,

> > @@ -1088,17 +1148,29 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
> >       if (queue->ddgst_remaining)
> >               return 0;
> >
> > -     if (queue->recv_ddgst != queue->exp_ddgst) {
> > -             dev_err(queue->ctrl->ctrl.device,
> > -                     "data digest error: recv %#x expected %#x\n",
> > -                     le32_to_cpu(queue->recv_ddgst),
> > -                     le32_to_cpu(queue->exp_ddgst));
> > -             return -EIO;
> > +     offload_fail = !nvme_tcp_ddp_ddgst_ok(queue);
> > +     offload_en = test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
> > +     if (!offload_en || offload_fail) {
> > +             if (offload_en && offload_fail) { // software-fallback
> > +                     rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
> > +                                           pdu->command_id);
> > +                     nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq);
> > +             }
> > +
> > +             nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
> > +             if (queue->recv_ddgst != queue->exp_ddgst) {
> > +                     dev_err(queue->ctrl->ctrl.device,
> > +                             "data digest error: recv %#x expected %#x\n",
> > +                             le32_to_cpu(queue->recv_ddgst),
> > +                             le32_to_cpu(queue->exp_ddgst));
> > +                     return -EIO;
> > +             }
>
> I still dislike this hunk. Can you split the recalc login to its
> own ddp function at least? This is just a confusing piece of code.

mmm, we added two boolean predicates (offload_en and
offload_failed) plus a comment (software-fallback)
to clarify this piece... thought it can fly

> >       if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> > -             struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
> > -                                             pdu->command_id);
> > +             if (!rq)
> > +                     rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
> > +                                           pdu->command_id);
>
> Why is this change needed? Maybe just move this assignment up?

OK will move it up

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
