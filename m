Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DFDC61DB9
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Mime-Version:From
	:Cc:Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:To:Message-Id:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VOkRe+DKMqDIbmcqWSS8PPey78AMHMi/nTaNf07YYZ8=; b=CLFcisLiZfzf6wUFook99JP5gW
	YDyxv2ur16BLzk7QqiCWq9phwM+76yVTDQa5SoVcpJijAsp6YtNgHSX6F8kxR6lak7bB+OQA5CPe/
	zK0VBm8m3yMPhqRiAZNwBsS/OubFULmr5yZpMRrpvpFkOPUMwNE/3TmSBtYJ1jtA1cs6iC9gdYF8X
	PRRp2gcvLhwFt2h5DLAqPYCtG+MWbKaXVNromagPVF7l8HziNFBJ2pvgIja6qnz/oAiJ98U5n/t3C
	mjnWmZN5El0B7qSt6AD34rQ6KgTJwSDwvRcN6wT5CwCciC1Rj171PCtZX1cxTTrGVxTPGAwU4pX/q
	A8EzPWdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz3E3-00000001n26-0SeE;
	Wed, 26 Aug 2026 02:18:51 +0000
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz3Dz-00000001n1S-0bbb
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 02:18:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787710718; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=VOkRe+DKMqDIbmcqWSS8PPey78AMHMi/nTaNf07YYZ8=;
 b=eFHJe6WVANhgfemGtu/h1DSeZgi4oayvziH0ag7nNCsJjORRzKRZp56SJOCNGdx3pjXLfh
 guDUI7y9cJPwsCpE58axjSNmUlnntGFE3rat8BdGJ2pDlt9w7ROtbdxCT3GQDL6oIe0fPZ
 KN1ylp/ctcSYs8p0BDg1VQDi835SUAletspZJZ0pX4BUj5wprOnre/nawPwVGkz99p05EE
 eX4kQk7WeA0M1gu9FzpSMkqfUNudAQPzWqkLpXhct0kbXHKEtJI9sOmtpzLWWvv3dmQo+7
 XbNDWc4IX8w9J51yh3zIeWyC034oik6kzyXv06aRABiY61MCSpu69C0DiCMKSw==
X-Lms-Return-Path: <lba+16a8e4cfc+6568fc+lists.infradead.org+changfengnan@bytedance.com>
Date: Wed, 26 Aug 2026 10:18:33 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.f73839cb.7360.4530.9912.75608111828b@bytedance.com>
To: "Anuj Gupta" <anuj1072538@gmail.com>
Subject: Re: [PATCH] nvme-pci: add adaptive interrupt polling
In-Reply-To: <rf622zppbkxqcydbuwfifpyeyem3mjc6ris6zjutvzil2p3f5b@33tczg6j52ge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<jun1.zeng@intel.com>, "Guzebing" <guzebing@bytedance.com>, 
	<anuj20.g@samsung.com>
From: "changfengnan" <changfengnan@bytedance.com>
Mime-Version: 1.0
References: <20260818033846.53790-1-changfengnan@bytedance.com>
	<rf622zppbkxqcydbuwfifpyeyem3mjc6ris6zjutvzil2p3f5b@33tczg6j52ge>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_191847_260985_05060D7D 
X-CRM114-Status: GOOD (  11.20  )
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


> From: "Anuj Gupta"<anuj1072538@gmail.com>
> Date:=C2=A0 Tue, Aug 25, 2026, 10:59
> Subject:=C2=A0 Re: [PATCH] nvme-pci: add adaptive interrupt polling
> To: "Fengnan Chang"<changfengnan@bytedance.com>
> Cc: "Keith Busch"<kbusch@kernel.org>, "Jens Axboe"<axboe@kernel.dk>, "Chr=
istoph Hellwig"<hch@lst.de>, "Sagi Grimberg"<sagi@grimberg.me>, <linux-nvme=
@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <jun1.zeng@intel.com=
>, "Guzebing"<guzebing@bytedance.com>, <anuj20.g@samsung.com>
> > +/*
> > + * Drain CQEs from IRQ_POLL_SOFTIRQ and compare completion progress wi=
th the
> > + * IRQ baseline. =C2=A0Re-arm while within the allowed lag; leave poll=
 mode on lag
> > + * or teardown, and start another window only after a faster full wind=
ow.
> > + */
> > +static int nvme_adaptive_irq_poll(struct irq_poll *iop, int budget)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D co=
ntainer_of(iop,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t nvme_adaptive_poll, iopoll);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D adaptive->nvm=
eq;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int completions, limit;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 deadline, elapsed, now;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_IO_COMP_BATCH(iob);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&nvmeq->cq_poll_lock, fl=
ags);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(!test_bit(NVMEQ_ADAPTIVE_POLL=
ING, &nvmeq->flags))) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0completions =
=3D 0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_compl=
ete(iop);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags=
)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0completions =
=3D 0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_compl=
ete(iop);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_=
poll_end(nvmeq, false);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0limit =3D min_t(unsigned int,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0budget,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0NVME_ADAPTIVE_EPISODE_CQES - adaptive->completions);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0completions =3D nvme_poll_cq_bounded(nvmeq=
, &iob, limit);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->completions +=3D completions;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (completions >=3D budget &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->completions < NVME=
_ADAPTIVE_EPISODE_CQES)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_complete(iop);
>=C2=A0
> If the last drain reaches NVME_ADAPTIVE_EPISODE_CQES with
> completions =3D=3D budget, this calls irq_poll_complete() but still retur=
ns
> budget. irq_poll_softirq() will then call list_move_tail() on an entry
> that has already been removed.

Thanks, you are right, I also noticed this issue during testing.
In next version, irq_poll_complete() is called only when
completions < budget, so a full-budget return leaves the iopoll state untou=
ched.

> Should the full-budget case always goto out and let the next invocation
> complete and evaluate the episode?
>=C2=A0

