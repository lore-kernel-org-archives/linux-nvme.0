Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3906EC982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3MJR+9B05XkGSZVsnTWPOt9y1Fup8Pf5AVkP65nsWhM=; b=sYDlY3iqduIHIsl8oH8WE8/E0G
	cOUoSe6rciBEJO4/iRro1HdijbDiMMWw+FaQrR24WXO8jq1iDXwwBRFEnxyxlqMTPwAu9XsIOHl8y
	oDtTSg5q3/HDR7Oc8mcuO9bpRPggirbzSB/Cqz21KlKC8kFJn57bEJuB/oo7bwU4+Ei+TKJG6PFPD
	iw15K2iGg5suezO2iUMI0GB8T3BYBmo6+WjYcGqgeXUp0gdYnk8qTYPQTJKan/NtIzXGRrM7bnCWj
	peKtpeF66QqWImRa/N+UlJOuMjlc6Sj3bHz84pUbDA2zqMiotvhDH5sg/CjsSd61cPjzVTOPmCA48
	JaGyejTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96aO-00000006StA-2GdC;
	Tue, 22 Sep 2026 19:55:28 +0000
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96aJ-00000006Sr9-0wd5
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 19:55:27 +0000
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-52fb767cc71so2426821cf.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 12:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790106921; cv=none;
        d=google.com; s=arc-20260327;
        b=FEzJGxC0Q3iMULn1NbuxZauKiX0onRex+cKJrG91L7M1A+6M5c9JDbYXm0QlFPBp88
         AuN2EhXHXF1I/KuztfngqSkw+N3fip+vTuiY9D6n+7NAB0uZohaNU11/e+3y9aDUGhz1
         /gPCRLYjOlCu+GBcracyMP8djNmMPZWCXw+2KlP2oh/TVLYVYVHsA9YIwoOjrJP2D/E6
         3pJZpWlXUBJue8Xijz7MJTDJg0A8wm3vQoVwNbZgExRnw1eg+Xkmcvd5QLjDqbCmZF+G
         Smd96g60B3q8PVgNfhjOXXkfosSMJzCagbeRyQyPaEiEIPZU2qQc7VMqN43ZolmMQpOy
         SkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3MJR+9B05XkGSZVsnTWPOt9y1Fup8Pf5AVkP65nsWhM=;
        fh=mm03VsZUh7Fo5cDPSGnuc3SoQJUA0XA/upmN9lxrGDw=;
        b=aRZBrx6+SxhE3POCxxQZC4OY2TZ9TMAJid3tr5mtx+z4WL0s5rGocSRs8J975nlzPg
         tpMfh3iVgtunGHlb1dNSCaIy3G7VCi4n5B+8aZhn932XOLBhT6hDr5ReUBU0xzesS0qj
         bFhkY9ItqJXjjR6CZehuESRF4Cs9EEtdRYWVLHhIOsxqhT1q7IqKikHa3SrivbFgKDaC
         tqfbtpsJuvNHlMix8UKI82Mx2iCCDiKxAQIVrrtu5p/JBqQEoGOjPt0mdde6Mo+OFaZ1
         POaFi2IrQf5kM8utjus3mFp0/YOZdF34RNdkSqbtJ1w9Ie29fTnOvY3pawzjw1VltTsy
         XKeg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790106921; x=1790711721; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3MJR+9B05XkGSZVsnTWPOt9y1Fup8Pf5AVkP65nsWhM=;
        b=em4FV3MlzBisUyD1Qb2ba3vfipcKe+1gmABG0L8wodo6Am+VKHDpLPVQH/nE37YW2w
         9ww6eiSwpgW6y0yAH/CaL71HA2zQYoSFhbSg/ZjCsd+fw9dgTTusco9mq/WLqcNR1hCK
         ftCCBWhmy6HIIwNF7zB6NSQkBFhPaVZQ4lz5FR14g7FAEacaudYYvafIj6QGoN5FNeGb
         NTpxOQMQGldBqaHq2FWa5fVeFNtsV/v+eCX5Bieik5t7xtaAfH6K561AGMjS8N3UspGF
         EqO+Fh0LMd1fSXAVMexgi3dCnaUrRxSfnPv3J+pXgYRcxmqGEoKFJRsK22TyFqXqCN5c
         2U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106921; x=1790711721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MJR+9B05XkGSZVsnTWPOt9y1Fup8Pf5AVkP65nsWhM=;
        b=KJp6xlAZe1XIcxlvYJvR5sUfGaZlf4mDr5ruPgoVnQsx73GWE/cO9SJYdPoH0qx73W
         r5i2qQHxlWH5HXQ/kGGXpWULFO5Tv02BAaRUid5hYReYF8Yy3ypAgQ9d6PLGQMlwnLEN
         xyZcUHKi9/L6ImvzybzpcfRyuGRjh3GluUy/TfS0Y6QaqeHyfnrpiDgq23H4/S/zp07i
         vdzdi1V1mcbLat33grpj1BGjuTfYjFVDCTAv7dPfcuWGZLSdOU0b95Te+3R4Jt0YrPLR
         dZROo9E+Mwu02Zlryp980CoSi1tvIkEAJvQvj83wvcOd8R5B4KC2HDTIgx+50TaukWyf
         oO/g==
X-Forwarded-Encrypted: i=1; AKwUvBw4k5tnqcTpeXpadK6l9hyMBJxrQKBENle2NemdYL+Qj7umI3jO1rmm+zOLIfGviv9wFe2NmZXsyAxq@lists.infradead.org
X-Gm-Message-State: AFuF++kikcjsdijOSRx67kTyIwkt37dn8diLGrswtd5c3CjljV+LqUYt
	0CJN0ArQVOtolsDADYKou3dNJGA8jvODxxi6RUJVFk9ibdqJuw2B+w1ojvMRXs5s5kqrwepoZ8/
	qGaFIoZHtA7V0diw0HGvRZtlUwrwr1UQSGyslJOR27A==
X-Gm-Gg: AYBFou3GS2+iSikUY8LUrnMCG5EGU1BBcBje59GJcJt7F+ooHnW3Oj1PZAkxj42qRbb
	ACoDV1v/vvkSSzARNn0B4hhzuS0SsRyHn40sJyLPpg7SNrPSWr6s/cjOY4OaGIovEd6Z1Xcmg5n
	aKL9/8LADKu5szmHOThp69dkI7fwSXcfZ8slDd2+FQaKhRtv3R14pdn6ncm7cbCR/+1iZiZ/9G8
	YqQtOmlb5zgOfAelK20FxRuB1awcvi96cfY3zbppmMrkeb76w51sTBdiXdit1wDy31UgQvj65XA
	i6fVUHO61V00XKvmswYyfnBCqSMYkplSCKH7fWoQtCvcmi+ksmUvkc23
X-Received: by 2002:a05:622a:4807:b0:532:d0ab:f3cb with SMTP id
 d75a77b69052e-532eadbd4b5mr10656351cf.59.1790106921022; Tue, 22 Sep 2026
 12:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260910202812.1642832-1-sgogte@purestorage.com>
 <20260910202812.1642832-4-sgogte@purestorage.com> <bec91f99-4498-4be9-bf96-f3021c79f3f1@grimberg.me>
In-Reply-To: <bec91f99-4498-4be9-bf96-f3021c79f3f1@grimberg.me>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Tue, 22 Sep 2026 12:54:45 -0700
X-Gm-Features: AcwNN1Uz64RWiq9roHL-G4V9fQSjEC7rP5r0n-KWaGYq3XCS5Khgm1bpMuH2QRo
Message-ID: <CAMof9cWqVs89MVr0D8nsNBwvuQU25itf3SqCn=OZrrZKY_MkMA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] nvme-tcp: parallelize I/O queue allocation and startup
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Solganik Alexander <sashas@lightbitslabs.com>, Roy Shterman <roys@lightbitslabs.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_125523_492345_3E9263E6 
X-CRM114-Status: GOOD (  40.83  )
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

On Fri, Sep 11, 2026 at 2:27=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 10/09/2026 23:28, Surabhi Gogte wrote:
> > Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
> > allocation and startup"), refactor nvme tcp I/O queue setup to use asyn=
c
> > API, combining allocation and startup into a single parallel operation
> > per queue. This reduces connection and reconnection setup time when
> > there are delays in establishing connections, which is especially
> > important for high-core-count hosts.
> >
> > Key changes:
> > - Use async API to facilitate parallel calls for io queue setup.
> > - Add nvme_tcp_queue_setup_ctx for propagating errors from async
> >    workers.
> > - Remove nvme_tcp_start_io_queues() and __nvme_tcp_alloc_io_queues();
> >    their logic is folded into nvme_tcp_setup_io_queues() and
> >    nvme_tcp_configure_io_queues().
> > - Allocate the io tag set before the queues so that the queue range is
> >    known, and only set up the reconnect grow case if the queue count
> >    actually increased.
> > - Serialize the cpu scan and claim in nvme_tcp_set_queue_io_cpu() with =
a
> >    spinlock, as concurrent callers would otherwise select the same cpu.
> >    The per-cpu counters no longer need to be atomics.
> >
> > Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
> > time reduced from 61ms to 11ms.
> >
> > Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
> > ---
> >   drivers/nvme/host/tcp.c | 124 +++++++++++++++++++++++++--------------=
-
> >   1 file changed, 79 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index fe0e581608b4..0fc244e676f9 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -7,6 +7,7 @@
> >   #include <linux/module.h>
> >   #include <linux/init.h>
> >   #include <linux/slab.h>
> > +#include <linux/async.h>
> >   #include <linux/err.h>
> >   #include <linux/crc32.h>
> >   #include <linux/nvme-tcp.h>
> > @@ -54,7 +55,8 @@ MODULE_PARM_DESC(tls_handshake_timeout,
> >                "nvme TLS handshake timeout in seconds (default 10)");
> >   #endif
> >
> > -static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
> > +static int nvme_tcp_cpu_queues[NR_CPUS];
> > +static DEFINE_SPINLOCK(nvme_tcp_cpu_queues_lock);
> >
> >   enum nvme_tcp_send_state {
> >       NVME_TCP_SEND_CMD_PDU =3D 0,
> > @@ -154,6 +156,12 @@ struct nvme_tcp_queue {
> >   static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
> >   static LIST_HEAD_GUARDED(nvme_tcp_ctrl_list, nvme_tcp_ctrl_mutex);
> >
> > +struct nvme_tcp_queue_setup_ctx {
> > +     struct nvme_ctrl        *ctrl;
> > +     int                     qid;
> > +     int                     *err;
> > +};
> > +
> >   struct nvme_tcp_ctrl {
> >       /* read only in the hot path */
> >       struct nvme_tcp_queue   *queues;
> > @@ -1719,9 +1727,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvm=
e_tcp_queue *queue)
> >               goto out;
> >
> >       /* Search for the least used cpu from the mq_map */
> > +     spin_lock(&nvme_tcp_cpu_queues_lock);
> >       io_cpu =3D WORK_CPU_UNBOUND;
> >       for_each_online_cpu(cpu) {
> > -             int num_queues =3D atomic_read(&nvme_tcp_cpu_queues[cpu])=
;
> > +             int num_queues =3D nvme_tcp_cpu_queues[cpu];
> >
> >               if (mq_map[cpu] !=3D qid)
> >                       continue;
> > @@ -1732,9 +1741,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvm=
e_tcp_queue *queue)
> >       }
> >       if (io_cpu !=3D WORK_CPU_UNBOUND) {
> >               queue->io_cpu =3D io_cpu;
> > -             atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
> > +             nvme_tcp_cpu_queues[io_cpu]++;
> >               set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
> >       }
> > +     spin_unlock(&nvme_tcp_cpu_queues_lock);
> >   out:
> >       dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
> >               qid, queue->io_cpu);
> > @@ -2011,8 +2021,11 @@ static void nvme_tcp_stop_queue_nowait(struct nv=
me_ctrl *nctrl, int qid)
> >       if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> >               return;
> >
> > -     if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
> > -             atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
> > +     if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags)) {
> > +             spin_lock(&nvme_tcp_cpu_queues_lock);
> > +             nvme_tcp_cpu_queues[queue->io_cpu]--;
> > +             spin_unlock(&nvme_tcp_cpu_queues_lock);
> > +     }
> >
> >       mutex_lock(&queue->queue_lock);
> >       if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
> > @@ -2119,25 +2132,6 @@ static void nvme_tcp_stop_io_queues(struct nvme_=
ctrl *ctrl)
> >               nvme_tcp_wait_queue(ctrl, i);
> >   }
> >
> > -static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
> > -                                 int first, int last)
> > -{
> > -     int i, ret;
> > -
> > -     for (i =3D first; i < last; i++) {
> > -             ret =3D nvme_tcp_start_queue(ctrl, i);
> > -             if (ret)
> > -                     goto out_stop_queues;
> > -     }
> > -
> > -     return 0;
> > -
> > -out_stop_queues:
> > -     for (i--; i >=3D first; i--)
> > -             nvme_tcp_stop_queue(ctrl, i);
> > -     return ret;
> > -}
> > -
> >   static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
> >   {
> >       int ret;
> > @@ -2198,22 +2192,64 @@ static int nvme_tcp_tls_check_psk(struct nvme_c=
trl *ctrl)
> >       return 0;
> >   }
> >
> > -static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
> > +static void nvme_tcp_setup_queue_async(void *data, async_cookie_t cook=
ie)
> >   {
> > -     int i, ret;
> > +     struct nvme_tcp_queue_setup_ctx *ctx =3D data;
> > +     struct nvme_ctrl *ctrl =3D ctx->ctrl;
> > +     int ret;
> >
> > -     for (i =3D 1; i < ctrl->queue_count; i++) {
> > -             ret =3D nvme_tcp_alloc_queue(ctrl, i,
> > -                             ctrl->tls_pskid);
> > -             if (ret)
> > -                     goto out_free_queues;
> > +     ret =3D nvme_tcp_alloc_queue(ctrl, ctx->qid, ctrl->tls_pskid);
> > +     if (ret)
> > +             goto out_err;
> > +
> > +     ret =3D nvme_tcp_start_queue(ctrl, ctx->qid);
> > +     if (ret)
> > +             goto out_err;
> > +
> > +     return;
> > +
> > +out_err:
> > +     WRITE_ONCE(*ctx->err, ret);
> > +}
> > +
> > +static int nvme_tcp_setup_io_queues(struct nvme_ctrl *ctrl, unsigned i=
nt first,
> > +             unsigned int last)
> > +{
> > +     ASYNC_DOMAIN_EXCLUSIVE(queue_domain);
> > +     struct nvme_tcp_queue_setup_ctx *ctxs;
> > +     int nr_queues =3D last - first;
> > +     int err =3D 0, i, ret;
> > +
> > +     ctxs =3D kmalloc_objs(*ctxs, nr_queues);
> > +     if (!ctxs)
> > +             return -ENOMEM;
> > +
> > +     for (i =3D 0; i < nr_queues; i++) {
> > +             ctxs[i].ctrl =3D ctrl;
> > +             ctxs[i].qid =3D first + i;
> > +             ctxs[i].err =3D &err;
> > +             async_schedule_domain(nvme_tcp_setup_queue_async, &ctxs[i=
],
> > +                             &queue_domain);
> >       }
> >
> > +     async_synchronize_full_domain(&queue_domain);
> > +     kfree(ctxs);
> > +
> > +     ret =3D READ_ONCE(err);
> > +     if (ret)
> > +             goto out_free_queues;
> > +
> >       return 0;
> >
> >   out_free_queues:
> > -     for (i--; i >=3D 1; i--)
> > -             nvme_tcp_free_queue(ctrl, i);
> > +     for (i =3D first; i < last; i++) {
> > +             struct nvme_tcp_queue *queue =3D &to_tcp_ctrl(ctrl)->queu=
es[i];
> > +
> > +             if (test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> > +                     nvme_tcp_stop_queue(ctrl, i);
> > +             if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> > +                     nvme_tcp_free_queue(ctrl, i);
> > +     }
> >
> >       return ret;
> >   }
> > @@ -2255,10 +2291,6 @@ static int nvme_tcp_configure_io_queues(struct n=
vme_ctrl *ctrl, bool new)
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D __nvme_tcp_alloc_io_queues(ctrl);
> > -     if (ret)
> > -             return ret;
> > -
> >       if (new) {
> >               ret =3D nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->t=
ag_set,
> >                               &nvme_tcp_mq_ops,
> > @@ -2269,12 +2301,12 @@ static int nvme_tcp_configure_io_queues(struct =
nvme_ctrl *ctrl, bool new)
> >       }
> >
> >       /*
> > -      * Only start IO queues for which we have allocated the tagset
> > +      * Only setup IO queues for which we have allocated the tagset
> >        * and limited it to the available queues. On reconnects, the
> >        * queue number might have changed.
> >        */
> >       nr_queues =3D min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_cou=
nt);
> > -     ret =3D nvme_tcp_start_io_queues(ctrl, 1, nr_queues);
> > +     ret =3D nvme_tcp_setup_io_queues(ctrl, 1, nr_queues);
> >       if (ret)
> >               goto out_cleanup_connect_q;
> >
> > @@ -2298,12 +2330,14 @@ static int nvme_tcp_configure_io_queues(struct =
nvme_ctrl *ctrl, bool new)
> >
> >       /*
> >        * If the number of queues has increased (reconnect case)
> > -      * start all new queues now.
> > +      * setup all new queues now.
> >        */
> > -     ret =3D nvme_tcp_start_io_queues(ctrl, nr_queues,
> > -                                    ctrl->tagset->nr_hw_queues + 1);
> > -     if (ret)
> > -             goto out_wait_freeze_timed_out;
> > +     if (ctrl->tagset->nr_hw_queues + 1 > nr_queues) {
> > +             ret =3D nvme_tcp_setup_io_queues(ctrl, nr_queues,
> > +                             ctrl->tagset->nr_hw_queues + 1);
> > +             if (ret)
> > +                     goto out_wait_freeze_timed_out;
> > +     }
>
> This if condition can probably move into nvme_tcp_setup_io_queues() and
> exit early if both are the same. Other than that, patch looks solid. Can
> you please also run blktests to see that nothing broke. There may be
> some tests that have subtle race conditions. rdma and tcp btw.

Thanks. Sending a v4 version with this change. Also, I ran blktests
for tcp and rdma. The blktests nvme/062 "Create TLS-encrypted
connections" and nvme/063 "Create authenticated TCP connections with
secure concatenation" related to tls need ktls-utils-1.4.0 (c63c04b)
(tlshd) linked against gnutls 3.8.5. rdma also passed fine.

