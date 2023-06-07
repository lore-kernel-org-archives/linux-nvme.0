Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A3CC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 04:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cTLqOAtTyMXFuGGrm+2NknWfH2oQLCgaA0ayHism+pI=; b=Z/wrYrGEO5LQodOhPFv5pXr3to
	qfFJQ1cV06hK8ogZhwu+1JHDjkpGImqOFM+9hqbLnzo74GTO3vDJcY4ucr4YndPCtQrpdHIcTXF1p
	hCk1CTdPjc90wjn4kMZJy8oyyEejd+IUWeQfzlc8erHMxpnIxtYFkIQclE+Dz1zjWVzHh5OgrkxFc
	gu9PT53KrK3bc4uFcsaN2YH8jra1q5CfPiWFD1qH20mH7/rtuURz19/M2zu5+4Tm4t5Rg5weZL4+/
	OVTvH5rSoUAy5Wyv5AWBNdxozIla7tVpxdInZqZ2zgi0A0sN51k9J3EaRqzA2sl/f8ITQyT7zxNyy
	fIh9g/4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6kUS-004G2U-2q;
	Wed, 07 Jun 2023 04:09:44 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6kUP-004G00-2u
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 04:09:43 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9745baf7c13so870709466b.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jun 2023 21:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686110969; x=1688702969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTLqOAtTyMXFuGGrm+2NknWfH2oQLCgaA0ayHism+pI=;
        b=mzVP8+inwt5KjgNmamFzI+zx93ehVJtCgfO5vQrg3VpQUFHVpzWHUXn9b3s7yHaJVD
         Si44j26k57IC5MvopnD8eshr1seAITXYiE6e+25eHeEf5qHyPVIhmSkylWYPDIpZb7sl
         adv4rOS5l4kGo7B0Fr9hxxF+/eaV6wv6V5d/+S79W4S5/VkEIW793Yu6szEoW6jDK+4K
         VTL/cgkU5eILx8cHcl/INoFKdHroIx4QpFUL937SJr9/2B8IfP10vsAv2G+uN/YxBKAo
         dOvNpUUlptYF/cZwsc3I+V3TApq2B/IrnRj+qFLuVKvKow1wEYrSmAdHUzwUr5uZDFwB
         MAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686110969; x=1688702969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTLqOAtTyMXFuGGrm+2NknWfH2oQLCgaA0ayHism+pI=;
        b=I0Dlot6RwNND3NZJUa0ZHQLSt0+nM+8hJK/Zvsp61YlZmG6qbebITyf1rer6l1Rpr5
         H5igfzbpfPo4ZP2SNVbr2WDUXvYK6WnDjv0oR1PckEWgcz2bUjt5RHxFDRO0E4pLbJwN
         3t7PROVCE2ooxk3HxK71fBCVoeJT44+VObOV4o5qB2AjM+JToQYVAI+tjzzmCHez4e+8
         KHIdnSpOkGpA0tuBwt414ZYPoG80sLT0mQy+TvxfSyVXmnRgS+pN7KGLouYYiyX+jHNP
         mkttzqCheiBn3rR2pcPnpiypsQGXjMM7biJNhCy8G1jvmirQzzX+MEsB84Mxvc5OA9Zz
         V9gw==
X-Gm-Message-State: AC+VfDxccfsl1n/U5zFWPiXUCQmNo8AoP+Dq501jcQ6glE1jBgliErd4
	xk83d5O/bcgK7ASyN9C9tNumYW0xDDmr9TbbzE4=
X-Google-Smtp-Source: ACHHUZ4ckeQmi5O2OoWT3LP3pgwIjwZ/HCOtXPfkpP8BBHj1ayd1p3rwi7GC+cagHQ3Ua591PPiSFLYqTr7qNvgnsCE=
X-Received: by 2002:a17:907:7e84:b0:978:6489:f9f with SMTP id
 qb4-20020a1709077e8400b0097864890f9fmr4359074ejc.52.1686110969440; Tue, 06
 Jun 2023 21:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
In-Reply-To: <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Wed, 7 Jun 2023 12:09:17 +0800
Message-ID: <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To: Ming Lei <ming.lei@redhat.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_210941_962890_39DEE750 
X-CRM114-Status: GOOD (  23.70  )
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

Hi Ming:

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=BA=8C 23:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Chunguang,
>
> On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
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
>
> I didn't dig into ctrl state check in these error handler yet, but error
> handling is supposed to provide forward progress for any controller state=
.
>
> Can you explain a bit how switching to DELETING interrupts the above
> error handling and breaks the forward progress guarantee?

Here we freezed ctrl, if ctrl state has changed to DELETING or
DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
freeze, so nvme_remove_namespaces() hang.

static void nvme_tcp_error_recovery_work(struct work_struct *work)
{
        ...
        if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
                /* state change failure is ok if we started ctrl delete */
                WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &&
                             ctrl->state !=3D NVME_CTRL_DELETING_NOIO);
                return;
        }

        nvme_tcp_reconnect_or_remove(ctrl);
}


Another path, we will check ctrl state while reconnecting, if it changes to
DELETING or DELETING_NIO, we will break up and lease ctrl freeze and
queue quiescing (through reset path), as a result Hang occurs.

static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
{
        /* If we are resetting/deleting then do nothing */
        if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
                WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
                        ctrl->state =3D=3D NVME_CTRL_LIVE);
                return;
        }
        ...
}

> > freezed and queue is quiescing . Since scan_work may continue to issue =
IOs to
> > load partition table, make it blocked, and lead to nvme_tcp_error_recov=
ery_work()
> > hang in flush_work(&ctrl->scan_work).
> >
> > After analyzation, we found that there are mainly two case:
> > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it=
 issue
> >    new IO to load partition table.
>
> Yeah, nvme freeze usage is fragile, and I suggested to move
> nvme_start_freeze() from nvme_tcp_teardown_io_queues to
> nvme_tcp_configure_io_queues(), such as the posted change on rdma:
>
> https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61u=
OGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0

While drive reconnecting, I think we should freeze ctrl or quiescing queue,
otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
and the IOs may retry frequently. So I think we may better freeze ctrl
while entering
error_recovery/reconnect, but need to unfreeze it while exit.


> > 2. Since queus is quiescing, requeue timeouted IO may hang in hctx->dis=
patch
> >    queue, leading scan_work waiting for IO completion.
>
> That still looks one problem in related error handling code, which is
> supposed to recover and unquiesce queue finally.

If I have not misunderstood that is what this patchset does.

Thanks.
>
> Thanks,
> Ming
>

