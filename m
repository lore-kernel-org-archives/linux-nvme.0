Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28CDC5AC7A
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2026 02:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:In-Reply-To:References:Mime-Version:Subject:Cc:From
	:To:Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujCjVQ+nPe0Ej/tTQNyGXHsmygvjx9xJqZt8YEAe5mI=; b=nMnpCxF/GsQsQ8NRaSEY6Uxqqa
	baj03z515RaaDcJKOBNLmWADLAy+91Qau07LH2JHx8nwYuZePxbg2r8gtQZwov1RXiUnqDQAEMTjK
	newm03NqKcdJbW64L53TII5MDT6UEZH3ldQAF1xH6HtI7tByRO/gMzEYOhtFuELOPkj35OzCX9e4p
	52bGSz3og6FTdySmIeegJl1s95Kp+c1EWZfv+NO/VlEOnFRGLzd1dL0TuVpUqzZ6eQzZCy85M1WyE
	COvR6Bz1gvXKWEEx1LneSLgM1xf52VTXTebjvGssQf8gQ5K6u1d/z+TWBLfwuUMc6BjbwUqQwOwJ6
	h176SDCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsAAt-00000006yPl-1GR8;
	Fri, 07 Aug 2026 02:19:07 +0000
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsAAp-00000006yPI-2efG
	for linux-nvme@lists.infradead.org;
	Fri, 07 Aug 2026 02:19:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786069132; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ujCjVQ+nPe0Ej/tTQNyGXHsmygvjx9xJqZt8YEAe5mI=;
 b=hIg9DhtSTROVSqGGn8bH/4aDWAmD6aMDa+QFCqxL5l+rNhww8EAxpMYsCrVHBawg9LNEsy
 GByWUO5VrYSXO8YDds35Denp3wRqtkg/zyh/13H57pjcfuvv6bIJh2Dn2pH7HuM28ssPB6
 j2pNGQnz3IOa7ixqtTFiRAu5TYhiDgz8aJ0uaK/SDC6a971+x/qDYDykZpinV1p0kISctF
 Gq6SB7RmX7RR8zsDfpKy2KyG6k3NbMVBTPqX0Mv6NdwtTPF3fT0/DbMKgzsC3nrwKcznts
 MeJFApJPPzeCRxLuJGdM9alblXMN6ukLt1pse3eqPCKDIpH6UoC/MgbpDISIMw==
X-Lms-Return-Path: <lba+16a75408a+62b8e0+lists.infradead.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
From: "changfengnan" <changfengnan@bytedance.com>
Cc: <linux-nvme@lists.infradead.org>, "Keith Busch" <kbusch@kernel.org>, 
	"Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, 
	"Sagi Grimberg" <sagi@grimberg.me>, 
	"Bart Van Assche" <bvanassche@acm.org>, 
	"Thomas Gleixner" <tglx@kernel.org>, "Jun Zeng" <jun1.zeng@intel.com>, 
	"Gang Cao" <gang.cao@intel.com>, "Jun I Jin" <jun.i.jin@intel.com>, 
	"Liang A Fang" <liang.a.fang@intel.com>, "Yong Hu" <yong.hu@intel.com>, 
	<linux-kernel@vger.kernel.org>, "Guzebing" <guzebing@bytedance.com>
Subject: Re: [RFC PATCH] nvme-pci: adaptively poll completions on busy queues
Mime-Version: 1.0
References: <20260723120556.58670-1-changfengnan@bytedance.com>
	<anT6GLUy_o12Fiz4@ashevche-desk.local>
In-Reply-To: <anT6GLUy_o12Fiz4@ashevche-desk.local>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:18:48 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.52232ae5.c88d.441c.9d7a.294537a77e7c@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_191904_000307_A11F8D8B 
X-CRM114-Status: GOOD (  23.35  )
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


> From: "Andy Shevchenko"<andriy.shevchenko@intel.com>
> Date:=C2=A0 Fri, Aug 7, 2026, 05:18
> Subject:=C2=A0 Re: [RFC PATCH] nvme-pci: adaptively poll completions on b=
usy queues
> To: "Fengnan Chang"<changfengnan@bytedance.com>
> Cc: <linux-nvme@lists.infradead.org>, "Keith Busch"<kbusch@kernel.org>, "=
Jens Axboe"<axboe@kernel.dk>, "Christoph Hellwig"<hch@lst.de>, "Sagi Grimbe=
rg"<sagi@grimberg.me>, "Bart Van Assche"<bvanassche@acm.org>, "Thomas Gleix=
ner"<tglx@kernel.org>, "Jun Zeng"<jun1.zeng@intel.com>, "Gang Cao"<gang.cao=
@intel.com>, "Jun I Jin"<jun.i.jin@intel.com>, "Liang A Fang"<liang.a.fang@=
intel.com>, "Yong Hu"<yong.hu@intel.com>, <linux-kernel@vger.kernel.org>, "=
Guzebing"<guzebing@bytedance.com>
> On Thu, Jul 23, 2026 at 08:05:56PM +0800, Fengnan Chang wrote:
> > In high-IOPS scenarios, relying on interrupts to handle I/O operations
> > can limit performance. This issue becomes particularly pronounced in
> > multi-disk environments, where performance is constrained by the CPU=E2=
=80=99s
> > interrupt-handling capacity.
> >=C2=A0
> > Each Solidigm SB5PH27X038T device used for testing can deliver about 3.=
2M
> > 4 KiB random-read IOPS. =C2=A0Four devices therefore have about 12.8M I=
OPS of
> > aggregate capability, but interrupt-driven completion topped out at 7.8=
1M
> > IOPS, or about 61% of that capability.
> >=C2=A0
> > Add optional adaptive polling for busy interrupt-driven I/O queues. =C2=
=A0After
> > an interrupt drains the CQ, use the ring distance between last_sq_tail =
and
> > cq_head as an approximate host-side inflight count. =C2=A0If the count =
reaches
> > a per-controller high watermark, let the threaded handler keep draining
> > completions instead of returning to interrupt-driven completion right a=
way.
> >=C2=A0
> > The thread always checks for pending CQEs first. =C2=A0When the CQ is e=
mpty, it
> > compares the inflight count with a per-controller low watermark and sle=
eps
> > for a configurable interval before checking again. =C2=A0It returns to
> > interrupt-driven completion after three consecutive empty-CQ checks bel=
ow
> > the low watermark or when the loop limit is reached.
> >=C2=A0
> > The mode is disabled by default. It can be enabled at module load time.
> > The high and low watermarks, empty-CQ interval, and loop limit are
> > available through sysfs. =C2=A0The defaults are 32 commands, 3 commands=
,
> > 30 us, and 1000 iterations.
> >=C2=A0
> > Tested with the default settings and 4 KiB random reads on four Solidig=
m
> > SB5PH27X038T devices. =C2=A0With adaptive polling off and on:
> >=C2=A0
> > =C2=A0 - t/io_uring, depth 1024 and four workers per device:
> > =C2=A0 =C2=A0 7.810M and 12.780M aggregate IOPS (+63.64%).
> > =C2=A0 - fio/libaio, iodepth 1024, numjobs 4 and completion batches of =
32:
> > =C2=A0 =C2=A0 7.699M and 12.785M aggregate IOPS (+66.05%).
> >=C2=A0
> > In a paired libaio and io_uring boundary sweep, QD8, QD16, QD32, and
> > QD16/numjobs=3D4 changed by -0.15% to +0.48%. =C2=A0QD64 improved by 28=
.61% to
> > 59.75%.
>=C2=A0
> ...
>=C2=A0
> > +What: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/clas=
s/nvme/nvmeX/adaptive_poll_inflight_high
> > +Date: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0July 2026
>=C2=A0
> Can't be July for v7.3. See crystal ball predictor for the dates (rc1 or =
release).

Thank you for taking the time to review this patch. I=E2=80=99ve decided to=
 abandon
the approach in this patch, as it has unavoidable regression issues.
The number of in-flight I/O operations does not guarantee that CQEs will be
completed at a high frequency, nor does it indicate that using poll would b=
e
more efficient. Therefore, I=E2=80=99ve proposed an alternative approach:
https://lore.kernel.org/linux-nvme/20260806031058.40176-1-changfengnan@byte=
dance.com/T/#u

I=E2=80=99d greatly appreciate it if you could review the new approach.

>=C2=A0
> > +KernelVersion: =C2=A0 =C2=A0 =C2=A0 =C2=A07.3
>=C2=A0
> ...
>=C2=A0
> > +static void nvme_adaptive_unmask_irq(struct nvme_queue *nvmeq, int irq=
)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *dev =3D nvmeq->dev;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D to_pci_dev(dev->d=
ev);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->=
flags);
>=C2=A0
>=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdev->msi_enabled) {
>=C2=A0
> Wondering if MSI-X also should be considered here.
> With that in mind, can we use pci_dev_msi_enabled()?
>=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BIT(nvm=
eq->cq_vector), dev->bar + NVME_REG_INTMC);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readl(dev->bar=
 + NVME_REG_INTMS);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_irq(irq=
);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > +}
>=C2=A0
> ...
>=C2=A0
> > +static ssize_t adaptive_poll_interval_us_store(struct device *dev,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct device_attribute *attr,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const char *buf, size_t count)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_=
get_drvdata(dev));
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int value;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kstrtouint(buf, 10, &value);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!value)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;
>=C2=A0
> ERANGE? EDOM?
>=C2=A0
> Ditto for other similar cases.
>=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(ndev->adaptive_poll_interval_us=
, value);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0return count;
> > +}
>=C2=A0
> --=C2=A0
> With Best Regards,
> Andy Shevchenko
>=C2=A0

