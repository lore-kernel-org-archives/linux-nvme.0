Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF84C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 10:43:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC5461954
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 10:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC5461954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kqXWvvkEg8DXuFMKvYLrjxwnKUfGvan1Lw4o4GYXPWE=; b=VMBKOBKEdMqv2B
	1BNNNjZ+gE3rUWasJmgCurwV5tic7b/mdtqkrIyFMOoJcHBd+kM113KJgt6Xq6ibRLr7Qg1p38CyW
	ihmy8G1A+mxfI4q0I+fWKCqJ9nvg96CjlrhC4RwQH4gfZe6LgMftiIBGLyS7KLUjwOcXzVw6yWKBU
	1flNwSNE9B019mhXbN1N01Edw8SCDJGEux3gFM2pDy2LZWkSTWNpaWq45Ppu7+C6dKuWIAZuXOtKD
	PqvsXlQ+eD8hYyYaiV2aDVr4MMIaP3glNWjbTi3+3/5adAbeRxLo+KjW2m8t10Hwy6CCI2SLF4cZW
	scL7tkgCKTmrnIl9Y6HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxois-007fgH-H3; Mon, 28 Jun 2021 10:42:38 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxoip-007ffH-UZ
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 10:42:37 +0000
Received: by mail-ej1-x631.google.com with SMTP id o5so4149858ejy.7
 for <linux-nvme@lists.infradead.org>; Mon, 28 Jun 2021 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xcuk8SFbzgwkBKeZfdai13urXrpXD95y5Uu6sQTYCqs=;
 b=gK7NSQCjkGHREpxyjHXJBK0Di4/9761uYn2uLjqSUuJkw+hF5Z8/xcfT/NhtQiKhNO
 +LhkKGW8A2pn+USz1o73GsjbC/v1jR5mlT30XVcxn0yumY3SRfHe11KL/ODJEBNUfrEZ
 2ts7nacmQc4t9wx+DirLsz/dQxD+94yj0VXtxRLV2C45NVAoHlP3791pm2MfR+cExLpQ
 EGjPaEC6M/KlN6GN1WvvhyugPLlBqoUfV2MqX2qt6IO3VdeFZ2x8A2Bn17FC5d8d8t1J
 ScuWgyQcEiAytHDtHHlHgDokCTr0XbaEiW4huoC5wuVnxhKhpUgYigMw4n7Vb+bk4oDy
 QNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xcuk8SFbzgwkBKeZfdai13urXrpXD95y5Uu6sQTYCqs=;
 b=pGinog984R1PVS6HDwIGHzt2ut3KNMXSs9oI8ekgUOeOo+IpJUA0+IVsbV9TZccMqx
 xreu1t9DQxqY3yFaoFcDCkUBZlUqMTP+VAVpRbfqltAXgVdkC50/Bu/Lzv0dcPQaoMMR
 8pycirEXwwi/pWG9FChXK75Prets274Y6foF4nIaRKD73WrYka/dcQL70p8+KbvNiuMo
 LG53/CLOi5nchnK+Oj/lwrLIRj9d/eCE2w3TZt1KROkFRngyWy/NiyNdPJzU/f+S4cgR
 iJR6xzbDJCn7qB2lCZeZpVoJ1MXB0caThM4VpKLjQ76XaYWP1ID5zmp+ffr3R8Z4lAOi
 sQRg==
X-Gm-Message-State: AOAM530giet93hNErys44lW5qPr6c2P2gmRkH3WXOwaRVZh+q5oayjk6
 W+SPFd4aNSlO2pgeeSeYJwoD+BLRX16OpvQwm1A=
X-Google-Smtp-Source: ABdhPJw3Pg9vQRl4RmQxwDYjIVFfGYKtGjLZMp9s4wIkRvRORVOcpwHZrxrCay7tBt0U7EwP20hAUlGtk1hhyeccumo=
X-Received: by 2002:a17:906:b7da:: with SMTP id
 fy26mr23684080ejb.168.1624876953510; 
 Mon, 28 Jun 2021 03:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210624172410.14225-1-smalin@marvell.com>
 <20210624172410.14225-9-smalin@marvell.com>
 <CAJ3xEMhtrEEMLbkWuna_fvH_oinaCZmj3xr4y7gzdRawA1gmNA@mail.gmail.com>
In-Reply-To: <CAJ3xEMhtrEEMLbkWuna_fvH_oinaCZmj3xr4y7gzdRawA1gmNA@mail.gmail.com>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 28 Jun 2021 13:42:22 +0300
Message-ID: <CAKKgK4wJDrNcSbaPERPg2EyrSNvi8KY9UHyM3=T9bL_d3WBSDQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] nvme-tcp-offload: Add IO level implementation
To: Or Gerlitz <gerlitz.or@gmail.com>
Cc: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org, 
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, 
 prabhakar.pkin@gmail.com, Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210628_034236_026858_3F616AF2 
X-CRM114-Status: GOOD (  14.23  )
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

On Mon, 28 Jun 2021 at 10:10, Or Gerlitz <gerlitz.or@gmail.com> wrote:
> On Thu, Jun 24, 2021 at 8:41 PM Shai Malin <smalin@marvell.com> wrote:
> >
> > From: Dean Balandin <dbalandin@marvell.com>
> > In this patch, we present the IO level functionality.
> [..]
>
> > +static void nvme_tcp_ofld_set_sg_null(struct nvme_command *c)
> > +{
> > +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > +       sg->addr = 0;
>
> ok
>
> > +       sg->length = 0;
> > +       sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> > +                       NVME_SGL_FMT_TRANSPORT_A;
>
> > +inline void nvme_tcp_ofld_set_sg_inline(struct nvme_tcp_ofld_queue *queue,
> > +                                       struct nvme_command *c, u32 data_len)
> > +{
> > +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > +       sg->addr = cpu_to_le64(queue->ctrl->nctrl.icdoff);
>
> ok, what about dma mapping of the address?

The dma mapping is done by the offload device driver.
patch 18 - "qedn: Add IO level fastpath functionality", in qedn_init_sgl().

>
> > +       sg->length = cpu_to_le32(data_len);
> > +       sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
>
> > +static void nvme_tcp_ofld_map_data(struct nvme_command *c, u32 data_len)
> > +{
> > +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > +
> > +       sg->addr = 0;
>
> ???

We will rename the function: nvme_tcp_ofld_set_sg_host_data().
The dma mapping is done by the offload device driver.

>
> > +       sg->length = cpu_to_le32(data_len);
> > +       sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> > +                       NVME_SGL_FMT_TRANSPORT_A;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
