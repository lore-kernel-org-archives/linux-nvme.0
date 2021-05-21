Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A999FC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 02:58:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178E06121E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 02:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178E06121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZY9sTu/vh44jYQuseh5Pi7jyfxMPT6stRjKgSuizIA=; b=YrnibJyQouOU8oQ5T1KDdk5/0M
	/xwCqmH+myP+p8oNLxA99BTRFwx8Msy62mFL0zgjcVAVCZhrVu91pFLSV5u1+NmpPlJH6Z7unAfYv
	T0K+dlGNfQsu4WXZXCPNRhJMCoWaEydJnHFhMxqAJ+Ex8FMlll2vM269hdj2vQdUq9w9esbdpnMDQ
	Oa1MvstN5VgxhGiiAOTjOOqO+NUvEyF4X2Lz/02iYuUNbdRg/rXX5XTNJu381pD89/piT0HnZlvH7
	vxvTHH+CvcKv6taLi5Bn9Vl1F+3ZtFS0MsYhck0Cv2VwuVWEBqDVoctnJYTk42txffhbMq4jY2cYq
	IaT4bfbw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljvLw-003bGi-JX; Fri, 21 May 2021 02:57:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljvLt-003bGU-9z
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 02:57:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Lx6fARlDGMmhGbXsRXova3FHMABNkPYAdMXqS3U9Okc=; b=nHzq16ViYKIPAwVkI2UHh/ZV5T
 vmudekjhByxPvYYO8gTdeYPK3uDek9HUKrlee4LOvL3mSNKbXqO9K77PS+G+ofCLUBqw1+j3wbiNb
 saIVw/ie0oJNtQn5/MlvvAq841jJ5tie1MaQIU0EMMPMtA359BAquZVOMAphvyUH20c9pHgrjq/EO
 +R4OtsQEiU3GqnAXhTABv8LVKglUVikaEjqWbwZ75A+wzYMgzAfHxU4GoBexMHn1dzjAjarXngC09
 B8z54L/aUccMkp1YllWAqdFC0K1OzAwbUDA99pAZzqJEHqDFDO1XGn24HfbXsDyi+7tctnQrM6RLw
 ntO0LNtg==;
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljvLq-00GmjT-H1
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 02:57:27 +0000
Received: by mail-io1-xd2a.google.com with SMTP id k16so18698386ios.10
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 19:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lx6fARlDGMmhGbXsRXova3FHMABNkPYAdMXqS3U9Okc=;
 b=icEoPROA254unAeRAPiAaJU7QIfz1OZIsp0SHldxxG0x9u66LAc6lIvEN3aL/LVvlM
 837DaVq53YGGqSVvmFxpNYa03zXYv9glWNYT1MUkApy3W8lQUrztvbEWrRRRR9AGC7OC
 BikJBeCVBfGCvWlx16/nVyfLnXOd9HkIBkIvVEo1mRow1u77dK/lO67twKbJTv1e7wZw
 9Y5UbbCoBMQRktw1e7JBDWNQHgAJGEcLtJME84RwdQY71TeiBpKRIignMRLMLu5fWdf9
 yWLLmRKxuIrpdchhCAv6/2Au0Smxp9zpPee3T3Trkf58+3X+dMnwJglEVqWy6gcLmBT6
 syNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lx6fARlDGMmhGbXsRXova3FHMABNkPYAdMXqS3U9Okc=;
 b=HhDMdu7gsfyZI5H9LjFq1HU77kTeoIqsgVKjqein6ZS74Znln23rnrIpG/dIzycllH
 tNpBT2l1PvMn9SYPPqlVtvLNGAWZWcjBTthaVVPN5ZxGihLtAfGJTZr60ZGMNHTW3EOp
 dSQxV9scGUeqK/2UG3ww+NMFH9SkofoTeesrRElTiulYt3dCL/ntN/0kGSgKH/3kN7NU
 J3wPnjYdcKHgmLXTEhZf25/AIKKbNRFbhcrynLD9kUzLNZu817Z75N3rxpRa0kyTpPIq
 61hy2KCF6k/q2b/NU4BphDrtwV+22dmE6WCRkOdCQW/qjaOV63u08Rey8DuZ1RkfXcwI
 RaIg==
X-Gm-Message-State: AOAM533tUwyBLG9l6LCFHbKeATaJAHd98GvRJEM82X4vlBEIkqLrR1Mu
 xfIn7EFZQYfsENWLshnjHY/Qwql+saXyXB73d2M=
X-Google-Smtp-Source: ABdhPJxEXUndJCBqYLqIyaahLF2AefyvzNLOSVRNf+HUNZ5mQsggdi9hFQlF135zXWmSR7LjBAq6elonJYp9Md4u6a8=
X-Received: by 2002:a05:6638:150d:: with SMTP id
 b13mr1017454jat.51.1621565845095; 
 Thu, 20 May 2021 19:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210520113046.27821-1-houpu.main@gmail.com>
 <20210520113046.27821-3-houpu.main@gmail.com>
 <417493d4-a78f-ea89-8536-0b391ef95f08@grimberg.me>
In-Reply-To: <417493d4-a78f-ea89-8536-0b391ef95f08@grimberg.me>
From: Hou Pu <houpu.main@gmail.com>
Date: Fri, 21 May 2021 10:57:14 +0800
Message-ID: <CAKHcvQgYDcS4sOZ9SBaZ_9gK2EHz5LwLHXo77UDqDTyjjNJzZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvmet-tcp: fix connect error when setting
 param_inline_data_size to zero.
To: Sagi Grimberg <sagi@grimberg.me>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, 
 larrystevenwise@gmail.com, maxg@mellanox.com, 
 "Grupi, Elad" <elad.grupi@dell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_195726_589561_8358E302 
X-CRM114-Status: GOOD (  31.35  )
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

On Fri, May 21, 2021 at 6:44 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > When setting inline_data_size to zero, connect failed. This could be
> > reproduced with following steps.
> >
> > Controller side:
> > mkdir /sys/kernel/config/nvmet/ports/1
> > cd /sys/kernel/config/nvmet/ports/1
> > echo 0.0.0.0 > addr_traddr
> > echo 4421 > addr_trsvcid
> > echo ipv4 > addr_adrfam
> > echo tcp > addr_trtype
> > echo 0 > param_inline_data_size
> > ln -s /sys/kernel/config/nvmet/subsystems/mysub /sys/kernel/config/nvmet/ports/1/subsystems/mysub
> >
> > Host side:
> > [  325.145323][  T203] nvme nvme1: Connect command failed, error wo/DNR bit: 22
> > [  325.159481][  T203] nvme nvme1: failed to connect queue: 0 ret=16406
> > Failed to write to /dev/nvme-fabrics: Input/output error
> >
> > Kernel log from controller side is:
> > [  114.567411][   T56] nvmet_tcp: queue 0: failed to map data
> > [  114.568093][   T56] nvmet_tcp: unexpected pdu type 201
> >
> > When admin-connect command comes with 1024 inline data size, in nvmet_tcp_map_data(),
> > this size is compared with cmd->req.port->inline_data_size (which is 0),
> > thus the command is responded with an error code. But admin-connect command
> > is always allowed to use no more than 8192 bytes according to the nvme over
> > fabrics specification.
> >
> > The host side decides the inline data size when allocating the queue
> > according the queue number, the size of queue 0 is 8k and others is ioccsz*16.
> > The target side should do like this.
> >
> > Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
> > Signed-off-by: Hou Pu <houpu.main@gmail.com>
> > ---
> >   drivers/nvme/target/tcp.c | 24 +++++++++++++++++++++---
> >   1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index d8aceef83284..83985ab8c3aa 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -167,6 +167,24 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops;
> >   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
> >   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> >
> > +static inline int nvmet_tcp_inline_data_size(struct nvmet_tcp_cmd *cmd)
> > +{
> > +     struct nvmet_tcp_queue *queue = cmd->queue;
> > +     struct nvme_command *nvme_cmd = cmd->req.cmd;
> > +     int inline_data_size = NVME_TCP_ADMIN_CCSZ;
> > +     u16 qid = 0;
> > +
> > +     if (likely(queue->nvme_sq.ctrl)) {
> > +             /* The connect admin/io queue has been executed. */
> > +             qid = queue->nvme_sq.qid;
> > +             if (qid)
> > +                     inline_data_size = cmd->req.port->inline_data_size;
> > +     } else if (nvme_cmd->connect.qid)
> > +             inline_data_size = cmd->req.port->inline_data_size;
>
> How can a connection to an I/O queue arrive without having the ctrl
> reference installed? Is this for the failure case?

Hi Sagi,
AFAIK after the host finishes setting up the admin queue,
it connects to the io queue and sends the io-connect command. At this
point the nvmet_tcp_queue is firstly allocated and does not have a valid
queue->nvme_sq.ctrl. It is assigned after io-connect in nvmet_install_queue().
So this function tries to find the correct queue number before or after a
fabrics connect command.

Thank,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
