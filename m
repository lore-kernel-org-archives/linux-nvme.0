Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8983C2B9F7
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 01:55:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0B86113B
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 01:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0B86113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xeWtfpf4oww3pIjYKWxBM4PhlCgWCiuoQm2g28p+A0w=; b=uBqlhKC7UFKnuo
	Soo8vuatJ98U2ACAwhwU7m60UZeHOios4paG4lp5RlVk3IfLwAcL9Iy7oSXdo/p9eO1jYrlI20hWb
	in33nKH71MlCfNYVrW2QEEkOJcZ4Sgu/Jpy4MSi+28O1mhCIoozdbBgYgjrOG7noBsjQ2P1p0LycA
	abYUdFomz5oq0n+K8BYlYpLZWuBxBlhTD1WEU7+AwwLsjjH4ValdXUrRYwjHKnNvUZMC4iVcAJt8w
	np6eZ788S4CRYCrrjhhBGQl95S6c86O7XpuOjPMDdYeDz/OUzIOeT6aN1C8HSJhDlaMPw97ipAzdX
	0tKfyQIsLKpRbZq+pm0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llMHu-002p91-CQ; Tue, 25 May 2021 01:55:18 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1llGyV-001nua-HL
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 20:14:58 +0000
Received: by mail-ej1-x631.google.com with SMTP id l1so43682341ejb.6
 for <linux-nvme@lists.infradead.org>; Mon, 24 May 2021 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qXqx8ZIQOHXl21JR2YMW/bREa48kiM+B1pCDqSAY+p8=;
 b=E9wdqG4zmQVjp5/f9XP1E3+Qx3Avb6nXRqeaqspvyZTNvSu5mN9pQnMYAmwmTvtk5Z
 XZhi9IU4iZ8Ay/3y6K0w4u7NOR/IWnr5nwtIAc6ajBoT30qeg5NRP60mK6dTmrPEZYTv
 RWpcWDX/CFpeh7QAxL9AnV2O/dy2q2A3iMKeXuVqE1HlkPO1rla+ZtTl4OJ/usrtxnxO
 WBeI0razjJA9cYLvaFODhnSbQNcSd7jwJzYSZSo1RO+YauQbtL+YHkUeRsbcxt915FeP
 CMwr/9z9xkK/GYZmHRunG+sT37LAnJJ/woDvzSkVjD//bHW8xqq9Owl2gRoLgOOdCmfY
 WM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qXqx8ZIQOHXl21JR2YMW/bREa48kiM+B1pCDqSAY+p8=;
 b=PbAUaTwwDzU/JHz8D2279IUg3tidfDWGhb6eEi0gcVukrpPcvMGk1ldM/S1Lhdo9NA
 OkxB8kBw5Dassz9rF+f+dqSfvPYuQGMAiX7OFQudFYoITkMcZv9nuYXSLcqvoCQl6ufH
 AOeJYI+gS1jgNLzgpeIixHUzLkigg5z/2CxjeHzELaMwWCzIukdFCZCAXgzhIFpfFPXG
 RVpmZ2hi7o2lT/TJyMNkhKPt0ZrakqR/tcV0hz5JH5DfH7+ju2Vgv5Baf9GQb0ZtlxVh
 63t/Hbr/KBpMabqSyIMNChkBrTyaW3LO7n32nMe1yKPAH87s+WReV6BMmNYPur4EC79B
 BfZQ==
X-Gm-Message-State: AOAM532AOL28FlBGijegO07ap554Qnl/IGwvm7lb2mk8ejcGyQxe+STU
 cyfUTaluqGaMDMpWanNGD97YR+HT3xdR8V6VS/k=
X-Google-Smtp-Source: ABdhPJzl1Y88BvW0MhmCGEtmNG5SBAP/C/lPJbzXZtBR+SBho1ZKraTzgwPm+uYATpE37TJN7YWKRPc6Jl4Xm612Ofs=
X-Received: by 2002:a17:907:76e8:: with SMTP id
 kg8mr23511321ejc.130.1621887293891; 
 Mon, 24 May 2021 13:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-4-smalin@marvell.com>
 <e986c505-b81a-36ab-6366-35d5fbc193e1@grimberg.me>
In-Reply-To: <e986c505-b81a-36ab-6366-35d5fbc193e1@grimberg.me>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 24 May 2021 23:14:41 +0300
Message-ID: <CAKKgK4y77NNN7N81GOdTm=btirDCv0uLGqESjuhccZs1CB5opg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 03/27] nvme-tcp-offload: Add device scan
 implementation
To: Sagi Grimberg <sagi@grimberg.me>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org, 
 davem@davemloft.net, kuba@kernel.org, hch@lst.de, axboe@fb.com, 
 kbusch@kernel.org, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, 
 Dean Balandin <dbalandin@marvell.com>, Shai Malin <smalin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_131455_798542_31A70A4C 
X-CRM114-Status: GOOD (  32.20  )
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

On 5/22/21 1:22 AM, Sagi Grimberg wrote:
> On 5/19/21 4:13 AM, Shai Malin wrote:
> > From: Dean Balandin <dbalandin@marvell.com>
> >
> > As part of create_ctrl(), it scans the registered devices and calls
> > the claim_dev op on each of them, to find the first devices that matches
> > the connection params. Once the correct devices is found (claim_dev
> > returns true), we raise the refcnt of that device and return that device
> > as the device to be used for ctrl currently being created.
> >
> > Acked-by: Igor Russkikh <irusskikh@marvell.com>
> > Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> > Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> > Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> > Signed-off-by: Ariel Elior <aelior@marvell.com>
> > Signed-off-by: Shai Malin <smalin@marvell.com>
> > ---
> >   drivers/nvme/host/tcp-offload.c | 94 +++++++++++++++++++++++++++++++++
> >   1 file changed, 94 insertions(+)
> >
> > diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
> > index 711232eba339..aa7cc239abf2 100644
> > --- a/drivers/nvme/host/tcp-offload.c
> > +++ b/drivers/nvme/host/tcp-offload.c
> > @@ -13,6 +13,11 @@
> >   static LIST_HEAD(nvme_tcp_ofld_devices);
> >   static DECLARE_RWSEM(nvme_tcp_ofld_devices_rwsem);
> >
> > +static inline struct nvme_tcp_ofld_ctrl *to_tcp_ofld_ctrl(struct nvme_ctrl *nctrl)
> > +{
> > +     return container_of(nctrl, struct nvme_tcp_ofld_ctrl, nctrl);
> > +}
> > +
> >   /**
> >    * nvme_tcp_ofld_register_dev() - NVMeTCP Offload Library registration
> >    * function.
> > @@ -98,6 +103,94 @@ void nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
> >       /* Placeholder - complete request with/without error */
> >   }
> >
> > +struct nvme_tcp_ofld_dev *
> > +nvme_tcp_ofld_lookup_dev(struct nvme_tcp_ofld_ctrl *ctrl)
> > +{
> > +     struct nvme_tcp_ofld_dev *dev;
> > +
> > +     down_read(&nvme_tcp_ofld_devices_rwsem);
> > +     list_for_each_entry(dev, &nvme_tcp_ofld_devices, entry) {
> > +             if (dev->ops->claim_dev(dev, &ctrl->conn_params)) {
> > +                     /* Increase driver refcnt */
> > +                     if (!try_module_get(dev->ops->module)) {
>
> This means that every controller will take a long-lived reference on the
> module? Why?

This is in order to create a per controller dependency between the
nvme-tcp-offload and the vendor driver which is currently used.
We believe that the vendor driver which offloads a controller should exist
as long as the controller exists.

>
> > +                             pr_err("try_module_get failed\n");
> > +                             dev = NULL;
> > +                     }
> > +
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     dev = NULL;
> > +out:
> > +     up_read(&nvme_tcp_ofld_devices_rwsem);
> > +
> > +     return dev;
> > +}
> > +
> > +static int nvme_tcp_ofld_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
> > +{
> > +     /* Placeholder - validates inputs and creates admin and IO queues */
> > +
> > +     return 0;
> > +}
> > +
> > +static struct nvme_ctrl *
> > +nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
> > +{
> > +     struct nvme_tcp_ofld_ctrl *ctrl;
> > +     struct nvme_tcp_ofld_dev *dev;
> > +     struct nvme_ctrl *nctrl;
> > +     int rc = 0;
> > +
> > +     ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
> > +     if (!ctrl)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     nctrl = &ctrl->nctrl;
> > +
> > +     /* Init nvme_tcp_ofld_ctrl and nvme_ctrl params based on received opts */
> > +
> > +     /* Find device that can reach the dest addr */
> > +     dev = nvme_tcp_ofld_lookup_dev(ctrl);
> > +     if (!dev) {
> > +             pr_info("no device found for addr %s:%s.\n",
> > +                     opts->traddr, opts->trsvcid);
> > +             rc = -EINVAL;
> > +             goto out_free_ctrl;
> > +     }
> > +
> > +     ctrl->dev = dev;
> > +
> > +     if (ctrl->dev->ops->max_hw_sectors)
> > +             nctrl->max_hw_sectors = ctrl->dev->ops->max_hw_sectors;
> > +     if (ctrl->dev->ops->max_segments)
> > +             nctrl->max_segments = ctrl->dev->ops->max_segments;
> > +
> > +     /* Init queues */
> > +
> > +     /* Call nvme_init_ctrl */
> > +
> > +     rc = ctrl->dev->ops->setup_ctrl(ctrl, true);
> > +     if (rc)
> > +             goto out_module_put;
>
> goto module_put without an explicit module_get is confusing.

We will modify the function to use explicit module_get so it will be clear.

>
> > +
> > +     rc = nvme_tcp_ofld_setup_ctrl(nctrl, true);
> > +     if (rc)
> > +             goto out_uninit_ctrl;
>
> ops->setup_ctrl and then call to nvme_tcp_ofld_setup_ctrl?
> Looks weird, why are these separated?

We will move the vendor specific setup_ctrl() call into
nvme_tcp_ofld_setup_ctrl().

>
> > +
> > +     return nctrl;
> > +
> > +out_uninit_ctrl:
> > +     ctrl->dev->ops->release_ctrl(ctrl);
> > +out_module_put:
> > +     module_put(dev->ops->module);
> > +out_free_ctrl:
> > +     kfree(ctrl);
> > +
> > +     return ERR_PTR(rc);
> > +}
> > +
> >   static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
> >       .name           = "tcp_offload",
> >       .module         = THIS_MODULE,
> > @@ -107,6 +200,7 @@ static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
> >                         NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_HDR_DIGEST |
> >                         NVMF_OPT_DATA_DIGEST | NVMF_OPT_NR_POLL_QUEUES |
> >                         NVMF_OPT_TOS,
> > +     .create_ctrl    = nvme_tcp_ofld_create_ctrl,
> >   };
> >
> >   static int __init nvme_tcp_ofld_init_module(void)
> >

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
