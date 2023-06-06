Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED47C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 14:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YRRXihsQZ7hXptz6zIQPKX5/ezfKwpTeMZXJF+R0lMc=; b=4S69ClBK5DRMKVnP+4W2p7z2nH
	Na4AJd1qwLudIisPRyApyHaGPMvR/45bhuU/1qIBRQVrjKfw3IDuHLO435mbdxT9ehiBWbuOrt8pp
	60htnfMTkhm8g28aWqw4hL9pdBMWWSrfl2N2aF5NQ+DVo9c8jWr8BIQLCm1LmbyEdcp1thbTDi8iK
	5RSigx1ba43BAS+EhK80a6Q2dex3+gTnecF852rsyQ+KtLLGzexqfeoP6c0hIqZDxVgSmfNv60Ncs
	NjR29Y5OuGlErWuNChZ7Pq/MPVAusWA7dk/IAEayFSU7kHAiIKayBXBtiT2nwLxNSlT/ZtqMm/jUc
	MdPQ7t1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Xso-0024No-2d;
	Tue, 06 Jun 2023 14:42:02 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Xsm-0024MX-2O
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 14:42:02 +0000
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so72986221fa.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jun 2023 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686062513; x=1688654513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRRXihsQZ7hXptz6zIQPKX5/ezfKwpTeMZXJF+R0lMc=;
        b=aLdrJUnQxYz54XJXHApzQL5HaXQRvjf3J/xoszv4xcWvU0XcxTVNLiBqTMXEZBKXP/
         z18k51ZDY2A2luOoTFPy0LYnU7pAxD28BwN4MT0tGksRNya5xgva0hALXPFNg//bezp1
         VA7J+7qlbh6e86w0xisVFSGVbfkCslHl44WCixh5iXPRx2tGhv5VFbOWVLwf5OXma6o5
         kLr5cIioKGFr5ZxXWL2n2gjgtoJ4n1k1ewxlIqj0LiN2fzZDti7pxJJZmi1oiMui4+oJ
         KDrzgMeXUpmhdT4Kt8HaDipwxlapNBP8V2wQ3F7HbznStlHbpwgA3Tl1b6O9uKKz3VgL
         +9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062513; x=1688654513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRRXihsQZ7hXptz6zIQPKX5/ezfKwpTeMZXJF+R0lMc=;
        b=PqXweMrx4jDkCgma7DGuq1nOEYZ0yxUCI9tYN/Vx2T3jzUbFEpZt9vR/N5lGxZuBld
         kLZ+/dDFte1Drs63XQZMSSEmaKf66+Xj6kC/Kep+BoRjvuqjLvBbuHJhX4KxHZTv86b+
         YpHr9bdAvQvSTE+2p2ApULpcuUxEYXsRsKKksn8KrB+/uxZ9UJYxv1BjykrpDbYUrpp4
         UavyzvPB+HI8V1fd9BO5GmB/O240uU/em+Q/Xc9yXk+ExxcXLad+kgFmud3gNchQP0F1
         c4yyAUYIjX8AF3Xkqpu89VdsONQs0NZ6s/z9TRkY3k2UTbpbok751Q3zsTRwyJ/MOgOE
         9a0g==
X-Gm-Message-State: AC+VfDydwpOSc4VnNK3Q+YTx7x1RHXhpD2z/d3GEuT04u+xz7AVgMIUe
	HyYKVrDPJvVNkX7COoPFTc1R50iK+XB96fZfBfBD6dI0XbdbOWvj
X-Google-Smtp-Source: ACHHUZ6X+cN8bK7pPRP6jsPHCEmTTkCTYspANqVovzkPC5fkUXHp9GIxkhTC0RMntjLBMC5dgfPZdO5YXxs3nWXNNxE=
X-Received: by 2002:a2e:2407:0:b0:2ac:8486:e318 with SMTP id
 k7-20020a2e2407000000b002ac8486e318mr1164755ljk.35.1686062513044; Tue, 06 Jun
 2023 07:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
In-Reply-To: <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Tue, 6 Jun 2023 22:41:42 +0800
Message-ID: <CADtkEefBGmNeO_zvXcbfJTP5TpEvowtAwx4=f_5tO=W56krW-w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_074200_785262_734DBC47 
X-CRM114-Status: GOOD (  17.25  )
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

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2023=E5=B9=B46=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=BA=8C 07:09=E5=86=99=E9=81=93=EF=BC=9A
>
>
> > From: Chunguang Xu <chunguang.xu@shopee.com>
> >
> > We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->sc=
an_work)
> > while removing ctrl. The root cause may due to the state of ctrl change=
d to
> > NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error=
_recovery_work()/
> > nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, c=
trl is
> > freezed and queue is quiescing . Since scan_work may continue to issue =
IOs to
> > load partition table, make it blocked, and lead to nvme_tcp_error_recov=
ery_work()
> > hang in flush_work(&ctrl->scan_work).
> >
> > After analyzation, we found that there are mainly two case:
> > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it=
 issue
> >     new IO to load partition table.
> > 2. Since queus is quiescing, requeue timeouted IO may hang in hctx->dis=
patch
> >     queue, leading scan_work waiting for IO completion.
>
> Hey, can you please look at the discussion with Mings' proposal in
> "nvme: add nvme_delete_dead_ctrl for avoiding io deadlock" ?

Hi grimberg:

I have read Ming's patch, it seems that MIng fixed the case my patchset mis=
sed,
Ming  fixes the hang occur while reconnect fails(reach max retries), my pat=
chset
fixes the issue that while driver processing error_recover or reconnect(hav=
e not
reach max retries), user actively remove ctrl(nvme disconnect),  this
will interrupt
error_recovery or reconnect, but ctrl is  freezed and request queue is
quiescing,
so the new IO or timeouted IOs(requeue to hctx->dispatch_list) cannot conti=
nue
to process, as a result, nvme_remove_namespaces hang on flush scan_work or
blk_mq_freeze_queue_wait, new IO hang on __bio_queue_enter(), it seems that
if the first patch of my patchset add the next code, it may cover Ming's ca=
se:

static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
{
    /* If we are resetting/deleting then do nothing */
    if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
        WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
        ctrl->state =3D=3D NVME_CTRL_LIVE);
        return;
    }

    if (nvmf_should_reconnect(ctrl)) {
        dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
            ctrl->opts->reconnect_delay);
        queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
            ctrl->opts->reconnect_delay * HZ);
    } else {
        dev_info(ctrl->device, "Removing controller...\n");
+      nvme_ctrl_reconnect_exit(ctrl);
        nvme_delete_ctrl(ctrl);
    }
}

Thanks.

> Looks the same to me.

