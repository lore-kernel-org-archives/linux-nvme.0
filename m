Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2590C11F69
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 16:07:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A030C61420
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 16:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A030C61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NevJmM+2HydlvamwQyiIPTNvG9L43TuJvkg3WNX4Q1k=; b=UdH9cvDYbcI9Sk
	eQ16YExZAJ303wmL+r0dQXfdXSxjOnLE7QkGIpa8glcaS/jjFSjDwBxm7rmdbZpKvotvDXvdxjOBT
	unxniY7RCN+CAHSsrs6CIKIZ8pR/dljPzlYXQxBROYFVwCamUykTFNE0Nc47qtALMvX5xXDWUUk+c
	pmRg1lcUE8og1eGlBMxWq6gFbR9UWFeZx63H+/eV+8DuJv/1cYwNSJtC2fBPTWal9b4omkdGd+g3T
	vU1i21GvIs2xGLBY2c+sAjkq9HM+BPlFSBtPjeRuhaGy0vOKf5X0AK1QEc1Ag8aJSnQY7KBPdc4Rw
	oWS1NKJUJSpWOpRRgM3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyzDl-000M3P-Jh; Thu, 01 Jul 2021 16:07:21 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyzDj-000M33-Lc
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 16:07:20 +0000
Received: by mail-il1-x129.google.com with SMTP id g3so5609382ilq.10
 for <linux-nvme@lists.infradead.org>; Thu, 01 Jul 2021 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YsTBpuzof6y1q3AoJz5K31z+A85Xrghph1dUT4Gt1Cc=;
 b=Q9DqM6SiN1s90NQ3QfgnGKC0OsCSMsNbQlher184mXneYNI/mQrhCkcKh0cHxxAflZ
 TgGU97sE3lLvXXbrb1jPbLhuY+4NllHd+8t/ygq9HZEJteMCutevMx7G5YIfscVt1hop
 3gWcx1DvPrXY3QVR3eyFpQ9MZBkb3Eyb59/a2n1kgg2Uc611L+xeM6OqWui48UU3kcZ1
 NP147zNNN/kT8GDsQJsON6geF4n8sLA4MNn9cRHnTjiLW7Ogo27X0MvkWnQZ7v1Ih8m2
 XjxOZW1BfHl1c+zE6mWjbrNgxBMWzJb7EYWV37777g+vOVKakisiOo8L5cISxDX1hgk5
 IJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YsTBpuzof6y1q3AoJz5K31z+A85Xrghph1dUT4Gt1Cc=;
 b=pQH04x9nmBcAN13nfCZZcg6Dd3fXdls/t42vbykD778lHjUJrNDYRN6Pzho9M26uqc
 W54LSu6bmquFZ5BI2fHl+JSTPfwRoeMo33vqS617Zl0t1kHDmugSVxIEY0CJW5M3Ei3q
 +V4VKHq5p8GxiEWcf6mpRUkMjW2Xbl/dtGcCzyzQ7q9762JOMriunwU9neXufoVQsM1Q
 2QPuvLMFoTJ178Kbd6OASVnj0mQSFToCYsrA+PxKrczreEzlE2tO7SSHz033gM9U+PiF
 D5gkQkG3WqHO9qscn1q6QANSubuvn80uuUA+i8RIWsrcdssnjK5f0Lm6wZUYnJpoYDD7
 JekQ==
X-Gm-Message-State: AOAM532laDFcV3ghaDgB2cTBAFvMIqI74mUkoxIdToaHjr7ojGPaRLJ9
 QKRuwoiVzaLCH5UXFTIoVFyx0AVaobN+c9dIyDA=
X-Google-Smtp-Source: ABdhPJyVTPYOzdJwckXeDAgQsxdmS1VLWqi7axRok32kAUyy4a5AqsVNG4A1xLgRP6GIYA4IiwT6g4vqpQECSoiTck0=
X-Received: by 2002:a92:c045:: with SMTP id o5mr93363ilf.223.1625155637653;
 Thu, 01 Jul 2021 09:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210624172410.14225-1-smalin@marvell.com>
 <20210624172410.14225-9-smalin@marvell.com>
 <CAJ3xEMhtrEEMLbkWuna_fvH_oinaCZmj3xr4y7gzdRawA1gmNA@mail.gmail.com>
 <CAKKgK4wJDrNcSbaPERPg2EyrSNvi8KY9UHyM3=T9bL_d3WBSDQ@mail.gmail.com>
In-Reply-To: <CAKKgK4wJDrNcSbaPERPg2EyrSNvi8KY9UHyM3=T9bL_d3WBSDQ@mail.gmail.com>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 1 Jul 2021 19:07:06 +0300
Message-ID: <CAJ3xEMiH9uaVojuvcetaWmFf8+OveX-xyvf3_CBbGsCfNP6X4g@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] nvme-tcp-offload: Add IO level implementation
To: Shai Malin <malin1024@gmail.com>
Cc: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org, 
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, 
 prabhakar.pkin@gmail.com, Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_090719_748154_D6BBA4B5 
X-CRM114-Status: GOOD (  16.73  )
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

On Mon, Jun 28, 2021 at 1:42 PM Shai Malin <malin1024@gmail.com> wrote:
>
> On Mon, 28 Jun 2021 at 10:10, Or Gerlitz <gerlitz.or@gmail.com> wrote:
> > On Thu, Jun 24, 2021 at 8:41 PM Shai Malin <smalin@marvell.com> wrote:
> > >
> > > From: Dean Balandin <dbalandin@marvell.com>
> > > In this patch, we present the IO level functionality.
> > [..]
> >
> > > +static void nvme_tcp_ofld_set_sg_null(struct nvme_command *c)
> > > +{
> > > +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > > +       sg->addr = 0;
> >
> > ok
> >
> > > +       sg->length = 0;
> > > +       sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> > > +                       NVME_SGL_FMT_TRANSPORT_A;
> >
> > > +inline void nvme_tcp_ofld_set_sg_inline(struct nvme_tcp_ofld_queue *queue,
> > > +                                       struct nvme_command *c, u32 data_len)
> > > +{
> > > +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > > +       sg->addr = cpu_to_le64(queue->ctrl->nctrl.icdoff);
> >
> > ok, what about dma mapping of the address?
>
> The dma mapping is done by the offload device driver.
> patch 18 - "qedn: Add IO level fastpath functionality", in qedn_init_sgl().

The dma mapping can and should be done by the nvme/tcp driver. E.g in a similar
manner fow how it's done for nvme/rdma, you can take a look on the code there.

>
> >
> > > +       sg->length = cpu_to_le32(data_len);
> > > +       sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
> >
> > > +static void nvme_tcp_ofld_map_data(struct nvme_command *c, u32 data_len)
> > > +{
> > > +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > > +
> > > +       sg->addr = 0;
> >
> > ???
>
> We will rename the function: nvme_tcp_ofld_set_sg_host_data().
> The dma mapping is done by the offload device driver.

same comment as above

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
