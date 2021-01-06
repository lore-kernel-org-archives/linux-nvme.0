Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576A4C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 15:01:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA2B23110
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 15:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA2B23110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1QlChwGUi7/QxIAtY0LbIOXKx3o4SaY2muubqABaQNU=; b=mt67wlYI7Rd6LdWMPl5DXvcwL
	hgcqgu1OXeU7gPO5xcYT73nq/bwS7SNj2TstzXSG6uUjYRC+4MJYSE7aSPhGTPS+Djg+MUAhtCPdc
	acYk1EGcPt7u+Tq5M0qjADohW9PQMc3nsCis5fQBD+obnsoGuZ9lzETLlm+ePFfgQDhX5tttFjV5P
	Ns54Vpxnh4bvJsJtW1549N6tXxUn4sFAX9Y25LcxExAoWscoMqnOBGIQpvggg+Llea6Mp7e0lvm+b
	keM/8wBGBy7KBPIBs0rT07WJZ09XU/xjMOE12Jw1JvSBafz3Wxq7zQJe/fOBzGOeVNBdV0wzOapmr
	mspsvzqfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxAJU-0003Io-IM; Wed, 06 Jan 2021 15:01:28 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxAJR-0003Hq-3K
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 15:01:26 +0000
Received: by mail-wr1-x435.google.com with SMTP id d13so2656945wrc.13
 for <linux-nvme@lists.infradead.org>; Wed, 06 Jan 2021 07:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zF8U3vRP6p62kymj3hRR5f4wMPE8L444jOpR52+UrkI=;
 b=M48j+wQMihd06KaVI4I3PJioWTxazCV6viV2hVIgZ2tv528KCvusJdwKsrunHWcjE4
 T2pjdz2qLTP2kkXa6Y72OHUu7KC83KbGmJ+ijvx711rD5lomMh0kmKJ4N/THSlSbXn5L
 TmrphRH6m4BplzvrxC81Ys/n7r9JhxS0KhedNH6rZjXEBNSBzg4psmxc8G6hm9g6t1M3
 quYX/zKEyl0jwn9p9lxTd9AoFevi24dZaaeZTAoY/0GPyr0WXLxWOexzVtL7J/ZwcgsZ
 0iJh3B3dr+CTdYqIkHpsMIimB5z8Ezeztzq1zZkPbu9wNsazHbC5DaCbC8EX5i+ydBqF
 WAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zF8U3vRP6p62kymj3hRR5f4wMPE8L444jOpR52+UrkI=;
 b=Zr5TSF+vJvIVFax3J/txycwdYds5DmB5pRvs38B5UTQ+eS3n38FTGs6HQyzmyDdu7N
 G080QsJDqp1Zzn+UkcdTsMI0k4y/IeDHYGTDQshIrAsMkO+cHWCKq793XiRELcgze6uQ
 +0YYGa3+yPYcrHRfE21siLHhqI/HwA0EmJ9eFrzP/fW+ACqaYFpvNaDCfGh7OlImqQwj
 S9qeovtTC0QMbmpQJXyutV7NGq1ETOrowytsEDBxLidEXedZKjHpOZfrIOFAxn1awG59
 D7jt6IQwidla+9N3XYWLlDmCZ2TYr1MfL6YquzuJ6dycnDFb2WOwPbOo5cOdsDL7YyYD
 f3SQ==
X-Gm-Message-State: AOAM532AtQ8abYLLU24ka4bO573d0c+phW+S4ueL53mwFzxgXhCLKQ+W
 iJuplxpBSCQZeOieiSOVUn3q0mIjbqXBNO4Ok8Q=
X-Google-Smtp-Source: ABdhPJzZsuuwng5irPgrO0n9F/UgYmW6VrVuy+6SRV/zJqgXR+r8qjPep9uJYKyIGgfc22qQ3+GS2qFZDIpT41saPpk=
X-Received: by 2002:adf:fd42:: with SMTP id h2mr4652152wrs.142.1609945283390; 
 Wed, 06 Jan 2021 07:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20210105224939.1336-1-clay.mayers@kioxia.com>
 <20210105224939.1336-2-clay.mayers@kioxia.com>
 <fb7227df-6250-1198-57c3-d57bdcb60a79@broadcom.com>
In-Reply-To: <fb7227df-6250-1198-57c3-d57bdcb60a79@broadcom.com>
From: Clay Mayers <klayph@gmail.com>
Date: Wed, 6 Jan 2021 07:01:09 -0800
Message-ID: <CACyZ+O6ACJr4fSsbZ=fQ8k0LS_3r+7O7bNDxNnQrRjzL9L_nQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: support fused nvme requests
To: James Smart <james.smart@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_100125_252112_C0158FA4 
X-CRM114-Status: GOOD (  28.08  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for the very fast feedback.  I will ensure this is pci only for now.

On Tue, Jan 5, 2021 at 4:35 PM James Smart <james.smart@broadcom.com> wrote:
>
>
>
> On 1/5/2021 2:49 PM, klayph@gmail.com wrote:
> > From
>
> >
> >   /*
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 3be352403839..c24729e100bc 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -491,6 +491,30 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
> >       nvmeq->last_sq_tail = nvmeq->sq_tail;
> >   }
> >
> > +/**
> > + * nvme_submit_cmd2() - Copy fused commands into a queue and ring the doorbell
> > + * @nvmeq: The queue to use
> > + * @cmd: The first command to send
> > + * @cmd2: the second command to send
> > + * @write_sq: whether to write to the SQ doorbell
> > + */
> > +static void nvme_submit_cmd2(struct nvme_queue *nvmeq, struct nvme_command *cmd,
> > +                          struct nvme_command *cmd2, bool write_sq)
> > +{
> > +     spin_lock(&nvmeq->sq_lock);
> > +     memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
> > +             cmd, sizeof(*cmd));
> > +     if (++nvmeq->sq_tail == nvmeq->q_depth)
> > +             nvmeq->sq_tail = 0;
> > +     memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
> > +             cmd2, sizeof(*cmd2));
> > +     if (++nvmeq->sq_tail == nvmeq->q_depth)
> > +             nvmeq->sq_tail = 0;
> > +     nvme_write_sq_db(nvmeq, write_sq);
> > +     spin_unlock(&nvmeq->sq_lock);
> > +}
> > +
> > +
> >   /**
> >    * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
> >    * @nvmeq: The queue to use
> > @@ -918,7 +942,13 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> >       }
> >
> >       blk_mq_start_request(req);
> > -     nvme_submit_cmd(nvmeq, &cmnd, bd->last);
> > +
> > +     if (cmnd.common.flags & NVME_CMD_FUSE_FIRST)
> > +             memcpy(&nvme_req(req)->nrq2->cmnd, &cmnd, sizeof(cmnd));
> > +     else if (cmnd.common.flags & NVME_CMD_FUSE_SECOND)
> > +             nvme_submit_cmd2(nvmeq, &nvme_req(req)->cmnd, &cmnd, bd->last);
> > +     else
> > +             nvme_submit_cmd(nvmeq, &cmnd, bd->last);
> >       return BLK_STS_OK;
> >   out_unmap_data:
> >       nvme_unmap_data(dev, req);
>
> I think Keith caught the most concerning issue. I've been thinking of
> others but they mostly seem to work.  I assume recopies of the first
> fused cmd to the data structure don't hurt.  I would expect there to be
> a couple of other odd issues if the two requests start working
> independently.
>
> This is the pci transport only. You should either put something in to
> not allow the ioctl on a non-pci transport, or add the support (or
> rejection) to the fabric transports as well.
>
> -- james
>
>
>
>
> --
> This electronic communication and the information and any files transmitted
> with it, or attached to it, are confidential and are intended solely for
> the use of the individual or entity to whom it is addressed and may contain
> information that is confidential, legally privileged, protected by privacy
> laws, or otherwise restricted from disclosure to anyone else. If you are
> not the intended recipient or the person responsible for delivering the
> e-mail to the intended recipient, you are hereby notified that any use,
> copying, distributing, dissemination, forwarding, printing, or copying of
> this e-mail is strictly prohibited. If you received this e-mail in error,
> please return the e-mail to the sender, delete it from your computer, and
> destroy any printed copy of it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
