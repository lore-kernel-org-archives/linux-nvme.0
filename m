Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3099C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 07:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:From:Subject:To:Message-Id:
	In-Reply-To:References:Content-Type:Mime-Version:Cc:Date:
	Content-Transfer-Encoding:Reply-To:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YRyQKi605leyy85/DSKEu6mXDwlF2FKIXhJW+VfeOBc=; b=Uhsxm9mtkP84eYXzItcuP+cuZZ
	yLXN7mbrjbOTnstorLq1HxbWvYXcASsdNgtaW1RRKPO5sbXb1OeWP7Dw5XSWg0Jzd2LeOW1cvPuEn
	pehngxwr9306Id6EjmWxlv/uPgWoA6UDbzbR47ZlLud0gXpu+mDxyNPOyLMQFwL6y2f0PwF1hPRaE
	8OPNVvA5lqb8Nq5TpWY8zidHswKYPAPjs/H9fxNKvEpYnbVD0dHOoXFrMX1o4wnuAECJDOmgwMQNG
	5DT5U7Y9rLmAIG4upKqYctAZ6CVF/c89grgXm6EX0Atp0CeFe0S1ErzRZ+wl8fsVjI1JMPMOOk5KU
	xmj3PTVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwaK8-000000099UC-0nZU;
	Wed, 19 Aug 2026 07:02:56 +0000
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwaK3-000000099TP-3QFX
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 07:02:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787122965; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YRyQKi605leyy85/DSKEu6mXDwlF2FKIXhJW+VfeOBc=;
 b=aXZEEFsbzB45YRfwOgWQxe3rIkk435ZCikyVePvAOSXbHfwSPr10O4nMqKO5yCa3UxpIQi
 8v7rO/T24fwOJEFumbnyZ02YyHHSUOtc2sxDYgPFX2rgd1mnQHHugyyBAwfaJ3Bvukbh61
 PX6Of19ZvM/7SdYDMPAldYVnfjWbBaNFbHlTC+HHg35U3znLmPfoAEmg+7mJz4hZ0HezCN
 QVLKFOQ/0cDn7NuCDhTpN7vB/IXai+tDa5VbpqoNu6vd0dVUIsPauUMQVwVT7t2+WQQ2fQ
 BjjKvedGuMiL1KIgyHJ+FBvNiAf6+mUof0YRKo6U//pEXAz0wMUKuHon5ejB4w==
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 15:02:41 +0800
Cc: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<jun1.zeng@intel.com>, "Guzebing" <guzebing@bytedance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <20260818033846.53790-1-changfengnan@bytedance.com>
	<20260819053541.GC32364@lst.de>
In-Reply-To: <20260819053541.GC32364@lst.de>
X-Lms-Return-Path: <lba+16a855513+826413+lists.infradead.org+changfengnan@bytedance.com>
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.99d43a8b.dfff.41d1.b07d.0592a12473d2@bytedance.com>
To: "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: add adaptive interrupt polling
From: "changfengnan" <changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_000252_051942_60E8AB21 
X-CRM114-Status: GOOD (  21.83  )
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


> From: "Christoph Hellwig"<hch@lst.de>
> Date:=C2=A0 Wed, Aug 19, 2026, 13:35
> Subject:=C2=A0 Re: [PATCH] nvme-pci: add adaptive interrupt polling
> To: "Fengnan Chang"<changfengnan@bytedance.com>
> Cc: "Keith Busch"<kbusch@kernel.org>, "Jens Axboe"<axboe@kernel.dk>, "Chr=
istoph Hellwig"<hch@lst.de>, "Sagi Grimberg"<sagi@grimberg.me>, <linux-nvme=
@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <jun1.zeng@intel.com=
>, "Guzebing"<guzebing@bytedance.com>
> On Tue, Aug 18, 2026 at 11:38:46AM +0800, Fengnan Chang wrote:
> > +#define NVME_ADAPTIVE_POLL_PERIOD_NS =C2=A0 =C2=A0 =C2=A0 =C2=A0(10U *=
 NSEC_PER_USEC)
> > +#define NVME_ADAPTIVE_EPISODE_CQES =C2=A0 =C2=A0 =C2=A0 =C2=A08192U
> > +#define NVME_ADAPTIVE_REEVAL_CQES =C2=A0 =C2=A0 =C2=A0 =C2=A0(64U * NV=
ME_ADAPTIVE_EPISODE_CQES)
> > +#define NVME_ADAPTIVE_POLL_RETRIES =C2=A0 =C2=A0 =C2=A0 =C2=A02U
>=C2=A0
> It would be good to describe these paramters and how we picked the
> constants here.

Most of these are figures based on experience; I'll explain them in the nex=
t patch.

>=C2=A0
> > +struct nvme_adaptive_poll {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hrtimer timer; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fires the next poll drain */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct irq_poll iopoll; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* softirq context for the drain */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 start_ns; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* when the current =
sample/episode started */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 retry_completions; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* completions until retry or IRQ reb=
aseline */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 interval_ns; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* sampled average gap between completions *=
/
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 completions; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* completions seen so far this sample/episo=
de */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 poll_failures; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* consecutive rejected polling trials */
>=C2=A0
> Lots of overly long lines. =C2=A0Just move the comments above the fields.

Sorry, these formatting issues will be fixed in the next version.

>=C2=A0
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* only used for poll queues: */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Used for both poll queues and adaptive =
interrupt polling. */
>=C2=A0
> s/both //
>=C2=A0
> > +static inline unsigned int nvme_poll_cq(struct nvme_queue *nvmeq,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t io_comp_batch *iob)
>=C2=A0
> Two-tab indents please. =C2=A0Also for various other spots later on.
>=C2=A0
> > =C2=A0{
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0bool found =3D false;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int found =3D 0;
> > =C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (nvme_cqe_pending(nvmeq)) {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D true=
;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * load-l=
oad control dependency between phase and the rest of
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the cq=
e requires a full read memory barrier
> > @@ -1620,6 +1649,7 @@ static inline bool nvme_poll_cq(struct nvme_queue=
 *nvmeq,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_rmb()=
;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_hand=
le_cqe(nvmeq, iob, nvmeq->cq_head);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_upda=
te_cq_head(nvmeq);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found++;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (found)
> > @@ -1627,17 +1657,22 @@ static inline bool nvme_poll_cq(struct nvme_que=
ue *nvmeq,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return found;
> > =C2=A0}
>=C2=A0
> And maybe split this into a prep patch?
Get.

>=C2=A0
> > +/* Keep the normal completion loop branch-free. */
>=C2=A0
> That is a rather terse comment. =C2=A0I also don't really see what is
> branch free here.
>=C2=A0
> > +static enum hrtimer_restart nvme_adaptive_poll_timer(struct hrtimer *t=
imer)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D co=
ntainer_of(timer,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t nvme_adaptive_poll, timer);
>=C2=A0
> container_of statements tend to read a lot nicer like:
> (same for the next one)
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct nvme_adaptive_poll *adaptive =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container_of(time=
r, struct nvme_adaptive_poll, timer);
>=C2=A0
>=C2=A0
> > +
> > +static irqreturn_t nvme_irq(int irq, void *data);
>=C2=A0
> Please add the new interrupt handlers below nvme_irq to remove the need
> for this forward declaration.

Get.

>=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int completions;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_IO_COMP_BATCH(iob);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&nvmeq->cq_poll_lock, fl=
ags);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(test_bit(NVMEQ_ADAPTIVE_POLLI=
NG, &nvmeq->flags))) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_ir=
qrestore(&nvmeq->cq_poll_lock, flags);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HAN=
DLED;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0completions =3D nvme_poll_cq(nvmeq, &iob);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (completions)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_=
sample(nvmeq, completions);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&nvmeq->cq_poll_loc=
k, flags);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!completions)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return test_an=
d_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&nvmeq->flags) ? IRQ_HANDLED : IRQ_NONE;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rq_list_empty(&iob.req_list))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_pci_compl=
ete_batch(&iob);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
>=C2=A0
> This reads a bit weird, I'd reflow the end to:
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (completions) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!rq_list_empt=
y(&iob.req_list))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 nvme_pci_complete_batch(&iob);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!test_and_cle=
ar_bit(NVMEQ_ADAPTIVE_STALE_IRQ,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &nvmeq->flags))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return IRQ_NONE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;

Yes, it's better.

>=C2=A0
>=C2=A0
>=C2=A0
> > +}
> > +
> > +static irqreturn_t nvme_irq_adaptive(int irq, void *data)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0irqreturn_t ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_bit(NVMEQ_ADAPTIVE_ENABLED, &nvm=
eq->flags)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D nvme_i=
rq(irq, data);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D=
 IRQ_NONE &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
test_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return IRQ_HANDLED;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0return nvme_irq_adaptive_enabled(irq, data=
);
> > +}
> > +
> > +static irqreturn_t nvme_irq(int irq, void *data)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_IO_COMP_BATCH(iob);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_poll_cq(nvmeq, &iob)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rq_list_e=
mpty(&iob.req_list))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0nvme_pci_complete_batch(&iob);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HAN=
DLED;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
>=C2=A0
> A lot of this irq handler code is repetitive. =C2=A0Could there be a way
> to share the code to remove the duplication?
Get.

>=C2=A0

