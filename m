Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1300C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+uOaW7/P2mRHgWTXaClBReuacX2fmrasr4/Dns+wyy0=; b=qcfMBo02mSOOWQqQgQiwXBS+Mo
	h1mgKIIJN6I3HkXyZrI7cP58jcgB2V/QEbLjAP3bdAPqv0/nyxSWWVU1mQDNEdhcp9TezW/BxyrFZ
	pmtr3AzS6F6O0Da+VeygNO80N6Yxit4U49LeuOzHMAJzJdXZ6VuRbHRqz2TSqSUihHGFG+B1JSabT
	/vkhisUSqOD1Uqb5BrkLhMZrQfL5KuRdclLhdXSVYY/qCEgcxIIuOMu7h8P7pPB2hCPdVMfbiHoZp
	+Y9ttko7LNkuyUSjfDxHRtcS0AayP8u9wcPBkwJRxvRY6AdFRVD8mSveXuCE09e9A6Tr3E16tepqm
	0y/I7DUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6XkB-00224N-0D;
	Tue, 06 Jun 2023 14:33:07 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Xk8-00222w-0a
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 14:33:05 +0000
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af2db78b38so76485061fa.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jun 2023 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686061979; x=1688653979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uOaW7/P2mRHgWTXaClBReuacX2fmrasr4/Dns+wyy0=;
        b=q7/qcxoVb752NHqDstK/BMZ0lbEhIO2jCI+gHaX5SCIFaltxtceJiS1BO88p0edwXl
         tK1qJOHvdEz4/xJM/3xILO0iC/DlpAtkOoilPN0lDpVHCZKOgXuDpV3/PkcFVVxLzbhf
         ycFpG/GDFL10Ha316icwTmyvZu87PdV+nh12oSVA+0YjvTZRKWqPK3Hvsc7El3VJXGDX
         KB4YWBVgBlM5UF8fbuPdN/GjS4Bz/NmYoDH69SZBDQRlWx3m9D19PlxSNJiCUd6hx9g0
         9yBuFd3NIvPOyxqO5L1reGb4Aw+mUrvDBoBAHQraPKsnTmIvLjeztcBmkWAbK+L5fXQZ
         8j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061979; x=1688653979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uOaW7/P2mRHgWTXaClBReuacX2fmrasr4/Dns+wyy0=;
        b=gri306/U2n3Hw7wToDrZwxSzkhxeRxDp/dLbdAml1aaUGFCr+YxOViIpyfe0nUeU/7
         7/sMp9/w3lAEB5TXud9h2F2dU3cr9d/DAWs5WGC4cRft/i3OrsN021eczaBolbxO7zNo
         9SRL3xVmdy3uabdZe1jqWA7+a7JTy29x9gPZMIyAXDYmDxAbnmbs3HPpfkXbo3uy8ih7
         0pmIIneczXYtSgNGcBeBc4S/LPlz33QPInV3dz+GKPIIa6cl29owPOm9LLDyqeR8NDYp
         1PCgoW7hOm7DMjhsy68oQl6QW9RAOjf9oIx62esFo9318YucIKq2dvyWJOLf2ZcWl6LF
         A4CQ==
X-Gm-Message-State: AC+VfDzGdjMLuDYgzfhZpZE8t4Re/nYTlVKy8DivCxdaAcGXcCYdG+oy
	nJBmwlIo0Wl7sMtwLiMPreXvDSLcnjWnyfUcidI=
X-Google-Smtp-Source: ACHHUZ70+/XvUEtR3WFR5fIkuXCom0YsIZ9WUDJVpWEOWVcA5mbOuxqILaLwZ8p6lpd8efMUIGLdPP0S6xGFkHyxxyc=
X-Received: by 2002:a2e:b012:0:b0:2ad:ac93:3c7d with SMTP id
 y18-20020a2eb012000000b002adac933c7dmr1234022ljk.38.1686061978530; Tue, 06
 Jun 2023 07:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
In-Reply-To: <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Tue, 6 Jun 2023 22:32:45 +0800
Message-ID: <CADtkEecM61WFyt6qEQnZvgiTdoixLvB-KtKABai83av3O0QuFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_073304_217651_70EFCA01 
X-CRM114-Status: GOOD (  18.77  )
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

Hi grimberg, I have read Ming's patch, it seems that MIng fix the case
my patchset missed, Ming mainly fixes the hang when reconnect fails,
my patchset fixes the issue that while processing error_recover or
reconnect(have not reach max retries), user actively remove ctrl(nvme
disconnect),  this will interrupt error_recovery or recoonect, but
ctrl freezed and th request queue quiescing, the new IO or timeouted
IOs cannot continue to process, as a result nvme_remove_namespaces
hang on flush scan_work or blk_mq_freeze_queue_wait, new IO hang or
__bio_queue_enter()=EF=BC=8Cit seems that if the first patch add the next
code, it may cover Ming's case:

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
        nvme_delete_ctrl(ctrl);
+      nvme_ctrl_reconnect_exit(ctrl);
    }
}

Thanls.


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
>
Hi grimberg, I have look MIng's patch, I think we may fix
> Looks the same to me.

