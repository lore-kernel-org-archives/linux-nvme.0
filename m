Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB5DC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:12:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352B161964
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352B161964
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q4IlgzGviI/rHlheuJiIsSDMvNbZIktCaEV2SW5cSfY=; b=sCWHbvEQnwm8ua
	4b+v1y1Si1mOxaEXh4FGav/G4x+ZUWvKY6yG7iH5Nhx9uYYdgnD+lGcOxGee/1A8aiQp7eMkHZdNW
	EN5BsLDvZmSi5r0/CJ4J84KqbXu7Bh05LZZJ3PnwnW04SBtfvLOHXhxchTVAjB/DJi++scBcT3ecV
	IhL9IqJyUfirNTS9QDIpnzfU3iBvD8ZJLzN0pl+CI+HFFqk2uTL4/JSNpX6SVrMb1tsiJaJlnDUIc
	LhSirZmmAuR1bEUPum+JmYwJbDV7sVfQAOOA9sF2EIjCFMvNKVmfb864NwRovMxrFpMhf0jnQHQyj
	IDKnjgMIDxEOHsDeGj7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QGo-009IaH-AI; Mon, 05 Jul 2021 15:12:26 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QGl-009IZI-LQ
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:12:25 +0000
Received: by mail-pg1-x531.google.com with SMTP id v7so18587172pgl.2
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tKDRlO9YCKAdJbnp2BpOMpXRX1J4I2mq8OVB87MyDT8=;
 b=YgB1xjTwsBLCKEBwkiAngeA2qUDKav74Q89X4TpnFpdY8rnA2K7tUoNpfjNecvoTgJ
 Rf9oJAPvD3MUDMSdlORCWOSVDalvMwzLEpNqQmd+CNmJp8LwTwqdxASGAZR6HthUm1yE
 KPpM9Gqxn5b/i4+pxHlBo5pbSuJaQNSBQG+haWKyGKHOk4tab7DHRMXyA4xZxQte0/Ft
 FOe04kaxkJJpnT64THPJT4wwmKcd9DOZZzRoCh+Ts6y53u71uTrXjgLlEWMPzUaMS50b
 K/s44pUhq76xxY1b8GXI3ozGst/6m6mbAgsQnZzaeJhAdOIgehYYEv9AQAEPISuDXhvV
 J7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tKDRlO9YCKAdJbnp2BpOMpXRX1J4I2mq8OVB87MyDT8=;
 b=ECuUGRyW2C1q/kTSKszYteKzZgFCnyQoLT80RNCTaQyILGGnrYZ07kovFQFc6Q54wx
 lO4mmndNpJxKr2m1YzbcOkomIzpJleodAwH3+50OXewKwZrTFT3keNqaAijDNvATl5/+
 R2Onj8yPLP5Lg8P6DCQATqoN7AAT3EuHDBBnup/oFU96aBI2gJBf3lOlg7hsOLC5oJdF
 FgwnMQkQ57eUOUgpSabGcCbWfmbMw0xZfDJzda9nJhnckIu/AYJIPfXPtTDriky8gab2
 yVI1TKwqwjh1feAVcnJMDGrJ3708DYWvUQSYDiXEFJ65+L1ppJgfoXeUkZ/Hx9K5Ylyh
 H1oA==
X-Gm-Message-State: AOAM531cdhLeZxPx/ey00iQ6WIj6cg59QX5uAgm+yiz6Dnnlcju1oJ0j
 pXx2Yn+bZn1iEsM939K1yM1Avpu/tZjmCIeCE+U=
X-Google-Smtp-Source: ABdhPJzPiFghnpzpK9CCiOYXMFHJts7b5Mzj0wCtJvn+v0pzQAIXmQYvAXqx35xmG7BeQ5YMNnwf7IpxqfLGtoZ4x+U=
X-Received: by 2002:a62:c712:0:b029:319:4e34:5cfb with SMTP id
 w18-20020a62c7120000b02903194e345cfbmr13990006pfg.2.1625497941334; Mon, 05
 Jul 2021 08:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210624172410.14225-1-smalin@marvell.com>
 <20210624172410.14225-9-smalin@marvell.com>
 <CAJ3xEMhtrEEMLbkWuna_fvH_oinaCZmj3xr4y7gzdRawA1gmNA@mail.gmail.com>
 <CAKKgK4wJDrNcSbaPERPg2EyrSNvi8KY9UHyM3=T9bL_d3WBSDQ@mail.gmail.com>
 <CAJ3xEMiH9uaVojuvcetaWmFf8+OveX-xyvf3_CBbGsCfNP6X4g@mail.gmail.com>
 <80c4ef0f-cbef-46c9-97c4-959d7a80c106@grimberg.me>
 <CAJ3xEMjUnJYCk4azwn5rWGt+xgWmw9_T1JuMaj9rRt+2qWC1-w@mail.gmail.com>
In-Reply-To: <CAJ3xEMjUnJYCk4azwn5rWGt+xgWmw9_T1JuMaj9rRt+2qWC1-w@mail.gmail.com>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 5 Jul 2021 18:12:10 +0300
Message-ID: <CAKKgK4ydbE7rY4w+7QHfmMOjFJLwFrnuS_cMB-OMMwT81iMnCQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] nvme-tcp-offload: Add IO level implementation
To: Or Gerlitz <gerlitz.or@gmail.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org, 
 Christoph Hellwig <hch@lst.de>, axboe@fb.com, Keith Busch <kbusch@kernel.org>, 
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, 
 prabhakar.pkin@gmail.com, Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_081223_768892_A75FD0BD 
X-CRM114-Status: GOOD (  23.18  )
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

On Mon, 5 Jul 2021 at 12:28, Or Gerlitz <gerlitz.or@gmail.com> wrote:
> On Sat, Jul 3, 2021 at 2:28 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> > >>>> From: Dean Balandin <dbalandin@marvell.com>
> > >>>> In this patch, we present the IO level functionality.
> > >>> [..]
> > >>>
> > >>>> +static void nvme_tcp_ofld_set_sg_null(struct nvme_command *c)
> > >>>> +{
> > >>>> +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > >>>> +       sg->addr = 0;
> > >>>
> > >>> ok
> > >>>
> > >>>> +       sg->length = 0;
> > >>>> +       sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> > >>>> +                       NVME_SGL_FMT_TRANSPORT_A;
> > >>>
> > >>>> +inline void nvme_tcp_ofld_set_sg_inline(struct nvme_tcp_ofld_queue *queue,
> > >>>> +                                       struct nvme_command *c, u32 data_len)
> > >>>> +{
> > >>>> +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > >>>> +       sg->addr = cpu_to_le64(queue->ctrl->nctrl.icdoff);
> > >>>
> > >>> ok, what about dma mapping of the address?
> > >>
> > >> The dma mapping is done by the offload device driver.
> > >> patch 18 - "qedn: Add IO level fastpath functionality", in qedn_init_sgl().
> > >
> > > The dma mapping can and should be done by the nvme/tcp driver. E.g in a similar
> > > manner fow how it's done for nvme/rdma, you can take a look on the code there.
> >
> > I agree here, the fact that the lld calls blk_rq_map_sg is very much
> > backwards... If the lld is peeking into a block layer request or bio,
> > its a sign that the layering is wrong...
>
> Making things more precise while looking in the patch set we were
> running here over
> the last year, blk_rq_map_sg indeed is called by the nvme driver, and then
> dma_map_sg by the hw driver. This is slightly different from the rdma case.
>
> overall, the sequence of calls is the following
>
> sg_alloc_table_chained()
> blk_rq_map_sg()
> dma_map_sg()

We will follow the nvme_rdma_map_data() design.
It will also depend on the discussion of patch 1 - "nvme-tcp-offload: Add
nvme-tcp-offload - NVMeTCP HW offload ULP".

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
