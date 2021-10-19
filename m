Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB17C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:13:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0362460FDA
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0362460FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=maK7Jqkyo72rFGF4c/a3CYVEdUM/Rekqjp5lLrmd//4=; b=iw45r+zNC1VVdvpJuE23pAujrt
	hR564oUB+OcvUhJq2dcabHMK9TdW6+xq0vkcdB4Spis+1TFLOw/UBtk3mHSA50+k1mXglFeg4q/pT
	tYze9ln+ntZs9k1xw10ShZMQuA/jokdfDGkEfbTTNOut4UDcijNsnnZ+MBlZU5tTkRQSAaoBTneAq
	A50RCh00iJ/b5buZzic6sSkeJ2yPG2QHddcOpvfpMxIGLm8hYcOFEZkzxW6q6TprxaeDiJ/UY0B14
	iYci90HFJhpUXztXBwmh19uOoAWeEiqZJslW87uHaJ4Bctg5+NNxWg4uo7DjndRckraT6kpDwXcDe
	VuZig+RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcqnt-001esT-Cw; Tue, 19 Oct 2021 15:13:25 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcqnq-001eqp-1U
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 15:13:23 +0000
Received: by mail-io1-xd36.google.com with SMTP id r134so20731799iod.11
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=maK7Jqkyo72rFGF4c/a3CYVEdUM/Rekqjp5lLrmd//4=;
 b=k+x/10nFJLwkqfoZNzL6IAGgVAGyDLHLjq/xyChRlbY1pma9fyq/5ztQuRhba/m9sZ
 xDba+3cDfCxOLS6TsVpwq6AkXMPN3B2nESMbVGUNXL0wK+SKPsZ+o0On60R5G1nAr9El
 wpxtkbigcgrg0W4A6pv1hvIUsU/PC6ROKQPDinVjZaXcRK7vSNlbz8o4RzaYBSmNzyQ9
 OQCutDEOeG1VMMy/CP7b9AFsX+rP1dAVf6lKutofNIpUNT4wEQeMaZF6OJGsCtbaE+G9
 0TMCM6WlzuE5TBWvhNEsut2lSAYiQK/Ng5gW3OD/ZAKIfn6KLeEM8xPSXT7Is86yAnPI
 ji2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=maK7Jqkyo72rFGF4c/a3CYVEdUM/Rekqjp5lLrmd//4=;
 b=5BYuV2qKHaEkTWNpu35QjaW2A+FKUi6XJZU+vwyAg2x5fPmcSAaDrFwenrBgf3hcfc
 9A0xW4i3zI6snkJwqktJWb6GeVMmOt09HW1gYBFZcAc1WM61LOM3+vMMXyXf3Rrj664D
 V0Egi6fnO8VnNqv0Dva80uGUGB6XdG03TK0L7OnsTc+M2l45r/l7CqF1LiMIiYphWh6h
 sTqgZwhxzFnTnyBD4MKVI8i1bZ/iSZi3+1skOerdhWgmtD5QgPxZ0K04kgij0Kn/NPE7
 VeN9v/VrJnAQrD22Vf7ybSQ6rfPVhtNkyxvs6YYW7LzRe4WpXFxmYp2GG1IkUb5AiisD
 NrfA==
X-Gm-Message-State: AOAM533rxW6QJBTqG+Sx6/QOGVgfYteKEq385V2E7wnVJxUrW9hRJUyx
 DzcbsGV1bJXCWNl8Ir3BHiI=
X-Google-Smtp-Source: ABdhPJzoZjV60neqDy/PIPlZ2vioWvd219tKPcUE92bs3W4SWY4zbliQ9P10wnCJqqt2ICMjQhuMIw==
X-Received: by 2002:a02:a391:: with SMTP id y17mr4584795jak.116.1634656398525; 
 Tue, 19 Oct 2021 08:13:18 -0700 (PDT)
Received: from anton-latitude (c-76-23-2-87.hsd1.ut.comcast.net. [76.23.2.87])
 by smtp.gmail.com with ESMTPSA id
 w11sm8308487ior.40.2021.10.19.08.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 08:13:17 -0700 (PDT)
Date: Tue, 19 Oct 2021 09:13:09 -0600
From: Anton Eidelman <anton.eidelman@gmail.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, axboe@fb.com
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
Message-ID: <20211019151309.GA51473@anton-latitude>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <20210920063534.GA26999@lst.de>
 <20210920145336.GA489494@anton-latitude>
 <20210921071527.GA24837@lst.de>
 <20211004164612.GA1475751@anton-latitude>
 <20211004165725.GB21511@lst.de>
 <6dcfff91-3973-3b2d-e289-38533463cfb6@grimberg.me>
 <368499da-c117-e8b7-7b1b-46894e1e0b48@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <368499da-c117-e8b7-7b1b-46894e1e0b48@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_081322_126327_C93EEE86 
X-CRM114-Status: GOOD (  33.30  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looking into making nvme_start_ctrl capable of returning an error.
This is a bit more complicated IMHO, because the in most transports
the ctrl is already in LIVE state when nvme_start_ctrl is invoked,
so we need to bail out carefully.

On Tue, Oct 19, 2021 at 05:37:30PM +0300, Sagi Grimberg wrote:
> 
> 
> On 10/5/21 3:38 PM, Sagi Grimberg wrote:
> > 
> > > > How do we proceed with this fix?
> > > 
> > > Please resend with the suggested updates.
> > > 
> > > > I believe error propagation here is not wanted because:
> > > > 1) A failure to fetch or parse the ANA log should not be considered
> > > >     an error in ctrl initialization.
> > > 
> > > We must handle error that are due to a controller failing to initialize.
> > > 
> > > > 2) Such error will not cause problems in teardown.
> > > > 3) The same failure is possible in ANA work and we do not take
> > > >     any action in such case.
> > > 
> > > Failing in a workqueue is different from failing in the initialization
> > > path.
> > > 
> > > > 4) Adding support for failure to nvme_start_ctrl() adds complexity
> > > >     and does not look useful due to the above 1-3.
> > 
> > The feedback here is that this patch is changing the functionality
> > as before we failed initialization and now we don't.
> > 
> > What is the issue in propagating the error and then modify
> > the call-sites? Shouldn't it be simple enough to do?
> > -- 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index aa14ad963d91..d86623b90eea 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -3158,8 +3158,11 @@ nvme_fc_create_association(struct nvme_fc_ctrl
> > *ctrl)
> > 
> >          ctrl->ctrl.nr_reconnects = 0;
> > 
> > -       if (changed)
> > -               nvme_start_ctrl(&ctrl->ctrl);
> > +       if (changed) {
> > +               ret = nvme_start_ctrl(&ctrl->ctrl);
> > +               if (ret)
> > +                       goto out_term_aen_ops;
> > +       }
> > 
> >          return 0;       /* Success */
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index b82492cd7503..59bfdd72a51a 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2827,7 +2827,10 @@ static void nvme_reset_work(struct work_struct
> > *work)
> >                          &nvme_pci_attr_group))
> >                  dev->attrs_added = true;
> > 
> > -       nvme_start_ctrl(&dev->ctrl);
> > +       ret = nvme_start_ctrl(&dev->ctrl);
> > +       if (ret)
> > +               goto out_unlock;
> > +
> >          return;
> > 
> >    out_unlock:
> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index 042c594bc57e..9e9e34a012e7 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -1141,7 +1141,10 @@ static int nvme_rdma_setup_ctrl(struct
> > nvme_rdma_ctrl *ctrl, bool new)
> >                  goto destroy_io;
> >          }
> > 
> > -       nvme_start_ctrl(&ctrl->ctrl);
> > +       ret = nvme_start_ctrl(&ctrl->ctrl);
> > +       if (ret)
> > +               goto destroy_io;
> > +
> >          return 0;
> > 
> >   destroy_io:
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 10b164f02b5d..22199281ad17 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -923,6 +923,11 @@ static void nvme_tcp_fail_request(struct
> > nvme_tcp_request *req)
> >          nvme_tcp_end_request(blk_mq_rq_from_pdu(req),
> > NVME_SC_HOST_PATH_ERROR);
> >   }
> > @@ -2045,7 +2052,10 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl
> > *ctrl, bool new)
> >                  goto destroy_io;
> >          }
> > 
> > -       nvme_start_ctrl(ctrl);
> > +       ret = nvme_start_ctrl(ctrl);
> > +       if (ret)
> > +               goto destroy_io;
> > +
> >          return 0;
> > 
> >   destroy_io:
> > diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> > index 0285ccc7541f..3fa89650c0d1 100644
> > --- a/drivers/nvme/target/loop.c
> > +++ b/drivers/nvme/target/loop.c
> > @@ -490,7 +490,9 @@ static void nvme_loop_reset_ctrl_work(struct
> > work_struct *work)
> >          if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE))
> >                  WARN_ON_ONCE(1);
> > 
> > -       nvme_start_ctrl(&ctrl->ctrl);
> > +       ret = nvme_start_ctrl(&ctrl->ctrl);
> > +       if (ret)
> > +               goto out_destroy_io;
> > 
> >          return;
> > -- 
> 
> So Anton, can this suggestion work? I think Hannes reported the same
> issue that this patch addresses.

