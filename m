Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B5EC07E98
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 09:29:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C545661369
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 09:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C545661369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uE8Op8HRxcxO1ESnf/MlKIJzOiNiSyVjs6eNlLUkZ3A=; b=ces+f5wRFwkByn
	/RHEtiH4t4S0G5VSlQTRJcDC4NyUp9thwvRi03qWIMTyONh/VyhOPbgvNd3lKLYHA3Mj6QJS4oqFi
	ESvTo565FERgDjJCLZi+ID5hhp4SdLL7Vq+bkwzOjS98d/zwzsQ1Jdi7WceOcU17uJsTR1qtfhRQ1
	PlU2R1ejyR7mcwybpBlYrN04MO1H02UAiK4g6ENwVXXN9K/CzT66er+mqsjjsfpms2sUM85ptHJr4
	Duv01ZFHD0BgOFIBbUi1MaVrOMPTydGodboxbZrPEhcup8hiBbko0R6AT4NdX6llH1Imtss63qRqG
	F/yhs9md50wjEojtJzvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0KuV-008QSI-G3; Mon, 05 Jul 2021 09:29:03 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0KuS-008QRT-PX
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 09:29:02 +0000
Received: by mail-io1-xd35.google.com with SMTP id b15so20250138iow.4
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2uairPZUl4R5ewvsI1rO2rWXwVHTQQy0NaLx5IeU/Yk=;
 b=mkkrK3ZK8B8pggLm5be/vjqH+q/BoY1vj0qoYdggZiCmKN78VX+MJOJ6hPFShqbT6q
 aQPdD4eduk/lvr/JHPF5HgHoiPIZV7JfIPmWaxhi0/FndtT3AorM7VhUZuIJW/Wp8xgV
 yQsx51DgR5ooRzL+/GdvLyh1UvcNb3arj/3ICLB6ionm3hATAmhQ6KJUGu+DkA6iuIAj
 Np0E7DLHPKYHNoqlh6K3ZR4kPv0kz8N3hhiRFJUyn29PdK9WGiqEHCYBERLgxvMbX+Oc
 8XwlKUsCGsMsxYgtOX4GcreNSqMoiTcemFrQoGDCL1fyh57+xSCdd4nyJdqPj6ikEouw
 oTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2uairPZUl4R5ewvsI1rO2rWXwVHTQQy0NaLx5IeU/Yk=;
 b=mY6Z5B35xvKY2xY4wE0F4yq1bhCGmeynuTurxLlRxpFTOxFLPo7Crbfbw6jjEhlRLc
 p/Ow24dKW/yUhaumis6KkoVzEHPJUfUk2BQ82klaw/ZX3oNHkhuNoBjuz/bKJRziFQ2d
 uBqIPlUBNzzXCpEedWmL7tqCBEac1tm1e4jLwXGqR4aZMOlOloUaqKf1KSO+dCPFq39l
 GEzQuiD31k+h527Zo4TwJzkoGjBodrVbpTOntz2cfwdgTWNTF0drVKXUSH2iYl05Xw/6
 LYR4fjCBtE0KaU7/2EltgsTtE9ZdUarSbfZHHrzcruUg75ZT48wJL/koB0ycHBV9M5qW
 0CsA==
X-Gm-Message-State: AOAM532OVO+X03BVChrGthNqsOUjXIVedLkxXkWj5R69rRQBsXs9yJ2/
 hkYYbcbyx6BI1vDa3Y3hc8oKf0GsPCRtVkoA4NU=
X-Google-Smtp-Source: ABdhPJz5bveXkGd++ffOcWYm1apjPRG47FcNFMTS60jQUQ5/xy+7NUyE6xDM+evavouIkUc/d2eO845izO2ZLFGyXmU=
X-Received: by 2002:a02:3506:: with SMTP id k6mr11803074jaa.39.1625477338998; 
 Mon, 05 Jul 2021 02:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210624172410.14225-1-smalin@marvell.com>
 <20210624172410.14225-9-smalin@marvell.com>
 <CAJ3xEMhtrEEMLbkWuna_fvH_oinaCZmj3xr4y7gzdRawA1gmNA@mail.gmail.com>
 <CAKKgK4wJDrNcSbaPERPg2EyrSNvi8KY9UHyM3=T9bL_d3WBSDQ@mail.gmail.com>
 <CAJ3xEMiH9uaVojuvcetaWmFf8+OveX-xyvf3_CBbGsCfNP6X4g@mail.gmail.com>
 <80c4ef0f-cbef-46c9-97c4-959d7a80c106@grimberg.me>
In-Reply-To: <80c4ef0f-cbef-46c9-97c4-959d7a80c106@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Mon, 5 Jul 2021 12:28:47 +0300
Message-ID: <CAJ3xEMjUnJYCk4azwn5rWGt+xgWmw9_T1JuMaj9rRt+2qWC1-w@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] nvme-tcp-offload: Add IO level implementation
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Shai Malin <malin1024@gmail.com>, Shai Malin <smalin@marvell.com>, 
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, axboe@fb.com, 
 Keith Busch <kbusch@kernel.org>, David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, 
 prabhakar.pkin@gmail.com, Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_022900_888590_7212426A 
X-CRM114-Status: GOOD (  19.24  )
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

On Sat, Jul 3, 2021 at 2:28 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >>>> From: Dean Balandin <dbalandin@marvell.com>
> >>>> In this patch, we present the IO level functionality.
> >>> [..]
> >>>
> >>>> +static void nvme_tcp_ofld_set_sg_null(struct nvme_command *c)
> >>>> +{
> >>>> +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> >>>> +       sg->addr = 0;
> >>>
> >>> ok
> >>>
> >>>> +       sg->length = 0;
> >>>> +       sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> >>>> +                       NVME_SGL_FMT_TRANSPORT_A;
> >>>
> >>>> +inline void nvme_tcp_ofld_set_sg_inline(struct nvme_tcp_ofld_queue *queue,
> >>>> +                                       struct nvme_command *c, u32 data_len)
> >>>> +{
> >>>> +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> >>>> +       sg->addr = cpu_to_le64(queue->ctrl->nctrl.icdoff);
> >>>
> >>> ok, what about dma mapping of the address?
> >>
> >> The dma mapping is done by the offload device driver.
> >> patch 18 - "qedn: Add IO level fastpath functionality", in qedn_init_sgl().
> >
> > The dma mapping can and should be done by the nvme/tcp driver. E.g in a similar
> > manner fow how it's done for nvme/rdma, you can take a look on the code there.
>
> I agree here, the fact that the lld calls blk_rq_map_sg is very much
> backwards... If the lld is peeking into a block layer request or bio,
> its a sign that the layering is wrong...

Making things more precise while looking in the patch set we were
running here over
the last year, blk_rq_map_sg indeed is called by the nvme driver, and then
dma_map_sg by the hw driver. This is slightly different from the rdma case.

overall, the sequence of calls is the following

sg_alloc_table_chained()
blk_rq_map_sg()
dma_map_sg()

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
