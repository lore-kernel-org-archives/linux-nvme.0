Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331C0C5AD7B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 02:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	In-Reply-To:From:To:Message-Id:Content-Type:References:Mime-Version:Subject:
	Cc:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ouwZUqR+deFGVMalSFY6t9lp8fDo2G13gktF7uJp5CM=; b=sFjrA7Ae6cgwmYZZsqdjRoka3d
	tfKJs5H2+KxFZ/pIIbNSQNghkjCldebLUPw5/mHidA+pyw3Pn+btRSQ25qaJUBFxYj8Pwu8i3XA5T
	anbx+nj6oG9jq9IX+0y1m3E6izIjwf68jjVWpDwxHczqIFpeZ6zJyCfys5J0j7b4qey7/cKzJROYN
	zLDqS4wDpJNO5UJ3+ZfpoKNYusOKY8HWFM+ivKFZiQKLaDcOhBhsdCU9rr8iOxQjaL6PxbzB9KK/4
	j2odMc5ZhfoMO1QgtctIjj90IYXU2CLDp4zn5WOliY7B5zblZdx96JVNJNaDvASAliphZKtTM83JH
	NYDwhSDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtcIP-0000000DAj1-0zdU;
	Tue, 11 Aug 2026 02:32:53 +0000
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtcIL-0000000DAhU-1Ew9
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 02:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786415559; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ouwZUqR+deFGVMalSFY6t9lp8fDo2G13gktF7uJp5CM=;
 b=QC+sEzOegvxV3kDyXnr+BdjonlzIawyTXuooQuU0lLpCRnIw8S68/J2AftHTqpROn0WEXd
 JSHVdALwuAcbOrmFte7MFPQ+Vil//ogVRN+HNZ2VbENd3vEte82Yhppz+HcSMcFlytzOvC
 mLTyJ6Fmv7BFV+3lUsaBAuq3pDgLqnN00s+wpVBGHKNYjRqN6UQNKUDNOiKnRtJiClQfGD
 9SdH+vC7RlVdB+aHbKFVMbfnA6FBoiaxqoCIF89p/iQu+iqNBWvOHc85/h+KiiEML92sEr
 Ax9rNMxvYmzb12N1KcZAlijxZmGcm7fNmk5eLjZmZrT6BYBogSzcPKMFJafuBw==
Date: Tue, 11 Aug 2026 10:32:35 +0800
Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Guzebing" <guzebing@bytedance.com>
Subject: Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt polling
Mime-Version: 1.0
References: <20260806031058.40176-1-changfengnan@bytedance.com>
	<ano6o6i4Yr2JfMgu@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.9f189e7a.e65a.4eb9.b86b.c83b70bebfb9@bytedance.com>
To: "Keith Busch" <kbusch@kernel.org>
From: "changfengnan" <changfengnan@bytedance.com>
X-Lms-Return-Path: <lba+16a7a89c6+847c19+lists.infradead.org+changfengnan@bytedance.com>
In-Reply-To: <ano6o6i4Yr2JfMgu@kbusch-mbp>
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_193249_610812_FC00ABE8 
X-CRM114-Status: GOOD (  34.27  )
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


> From: "Keith Busch"<kbusch@kernel.org>
> Date:=C2=A0 Tue, Aug 11, 2026, 04:55
> Subject:=C2=A0 Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt=
 polling
> To: "Fengnan Chang"<changfengnan@bytedance.com>
> Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@list=
s.infradead.org>, <linux-kernel@vger.kernel.org>, "Guzebing"<guzebing@byted=
ance.com>
> On Thu, Aug 06, 2026 at 11:10:58AM +0800, Fengnan Chang wrote:
> > The idea behind this approach is: Let each I/O queue switch itself betw=
een
> > interrupt and poll mode based on its own recent completion rate.
> >=C2=A0
> > This version is still in the testing phase, and there are still some is=
sues
> > with the code implementation. =C2=A0I releasing it now to see if the ap=
proach
> > is generally acceptable. =C2=A0If the approach looks good, I=C2=B4ll co=
ntinue to
> > refine it and conduct more extensive testing. =C2=A0The main implementa=
tion
> > logic is in `nvme_adaptive_sample` and `nvme_adaptive_irq_poll`; you sh=
ould
> > focus on reviewing the implementation of these two functions.
>=C2=A0
> Can we subscribe to the dynamic interrupt moderation (dim) library? I
> know it's generally used in conjuction with a hardware interrupt
> coalescing feature, but we can just do pure software with it too. The
> library provides a hill climb to adapt the policy at run time.
>=C2=A0
> This is a quick PoC I put together. I haven't tested on fast devices, so
> I'm not sure if I've dialed in the profiles, but it's start of what I
> had in mind.

The code looks much cleaner when using dim, I'll see if I can replace the
sample-and-poll logic I wrote myself with the dim library.=C2=A0
I ran a quick test on the POC patch and didn't see any performance
improvements; in fact, there were quite a few regressions. Maybe some
parameters need to be adjusted.


>=C2=A0
> ---
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 31974c7dd20c9..9fad1c7b1f678 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -6,6 +6,7 @@ config BLK_DEV_NVME
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "NVM Express block device"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on PCI && BLOCK
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0select NVME_CORE
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0select DIMLIB
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The NVM Express driver is for so=
lid state drives directly
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0connected to the PCI or PCI Expr=
ess bus. =C2=A0If you know you
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8438c904ec496..ff0c8d74fae08 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -9,6 +9,8 @@
> =C2=A0#include <linux/blkdev.h>
> =C2=A0#include <linux/blk-mq-dma.h>
> =C2=A0#include <linux/blk-integrity.h>
> +#include <linux/delay.h>
> +#include <linux/dim.h>
> =C2=A0#include <linux/dmi.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/interrupt.h>
> @@ -82,6 +84,45 @@ struct quirk_entry {
> =C2=A0static int use_threaded_interrupts;
> =C2=A0module_param(use_threaded_interrupts, int, 0444);
> =C2=A0
> +static unsigned int irq_poll_thresh =3D 7;
> +module_param(irq_poll_thresh, uint, 0644);
> +MODULE_PARM_DESC(irq_poll_thresh,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0"outstanding depth after which a queue switc=
hes to threaded polling");
> +
> +static unsigned int irq_poll_spin =3D 7;
> +module_param(irq_poll_spin, uint, 0644);
> +MODULE_PARM_DESC(irq_poll_spin,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0"poll iterations to spin (cpu_relax) before =
sleeping in the poll loop (zero based)");
> +
> +static unsigned int irq_poll_sleep_us =3D 20;
> +static unsigned int irq_poll_idle_us =3D 80;
> +static unsigned int irq_poll_idle_rounds =3D DIV_ROUND_UP(80, 20);
> +
> +static int irq_poll_us_set(const char *val, const struct kernel_param *k=
p)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D param_set_uint(val, kp);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_idle_rounds =3D irq_poll_sleep_us ?
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DIV_ROUND_UP(irq=
_poll_idle_us, irq_poll_sleep_us) : 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> +}
> +
> +static const struct kernel_param_ops irq_poll_us_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.set =3D irq_poll_us_set,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.get =3D param_get_uint,
> +};
> +
> +module_param_cb(irq_poll_sleep_us, &irq_poll_us_ops, &irq_poll_sleep_us,=
 0644);
> +MODULE_PARM_DESC(irq_poll_sleep_us,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0"microseconds to sleep between poll bursts (=
<=3D10 busy-delays, does not yield)");
> +
> +module_param_cb(irq_poll_idle_us, &irq_poll_us_ops, &irq_poll_idle_us, 0=
644);
> +MODULE_PARM_DESC(irq_poll_idle_us,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0"microseconds to wait for stragglers before =
handing a queue back to the IRQ path");
> +
> =C2=A0static bool use_cmb_sqes =3D true;
> =C2=A0module_param(use_cmb_sqes, bool, 0444);
> =C2=A0MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for =
I/O SQes");
> @@ -381,11 +422,21 @@ struct nvme_queue {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 qid;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 cq_phase;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 sqes;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Adaptive polling knobs, seeded from the i=
rq_poll_* module params. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int poll_thresh;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int poll_sleep_us;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int poll_idle_rounds;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int poll_budget;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Adaptive interrupt moderation (DIM) sampl=
ing state. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dim dim;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 dim_events; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* cumulative interr=
upts (BIT_GAP-safe) */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dim_comps; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* cumulative comple=
tions */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> =C2=A0#define NVMEQ_ENABLED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00
> =C2=A0#define NVMEQ_SQ_CMB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01
> =C2=A0#define NVMEQ_DELETE_ERROR =C2=A0 =C2=A0 =C2=A0 =C2=A02
> =C2=A0#define NVMEQ_POLLED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A03
> +#define NVMEQ_POLLING =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A04
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 *dbbuf_sq_db;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 *dbbuf_cq_db;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 *dbbuf_sq_ei;
> @@ -1606,13 +1657,13 @@ static inline void nvme_update_cq_head(struct nvm=
e_queue *nvmeq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> =C2=A0
> -static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct io_comp_batch *iob)
> +static inline int __nvme_poll_cq(struct nvme_queue *nvmeq,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct io_comp_batch *iob, =
int budget)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0bool found =3D false;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int found =3D 0;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (nvme_cqe_pending(nvmeq)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D true;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * load-loa=
d control dependency between phase and the rest of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the cqe =
requires a full read memory barrier
> @@ -1620,6 +1671,8 @@ static inline bool nvme_poll_cq(struct nvme_queue *=
nvmeq,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_rmb();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_handle=
_cqe(nvmeq, iob, nvmeq->cq_head);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_update=
_cq_head(nvmeq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (budget && fo=
und =3D=3D budget)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (found)
> @@ -1627,26 +1680,253 @@ static inline bool nvme_poll_cq(struct nvme_queu=
e *nvmeq,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return found;
> =C2=A0}
> =C2=A0
> +/* budget =3D=3D 0 means reap the whole queue. */
> +static int nvme_poll_cq(struct nvme_queue *nvmeq, int budget)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_IO_COMP_BATCH(iob);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int found =3D __nvme_poll_cq(nvmeq, &iob, bu=
dget);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (found && !rq_list_empty(&iob.req_list))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_pci_complet=
e_batch(&iob);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return found;
> +}
> +
> +static inline unsigned int nvmeq_outstanding(struct nvme_queue *nvmeq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 sq_tail =3D READ_ONCE(nvmeq->last_sq_tai=
l);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 cq_head =3D nvmeq->cq_head;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sq_tail >=3D cq_head)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return sq_tail -=
 cq_head;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return nvmeq->q_depth - cq_head + sq_tail;
> +}
> +
> +static inline bool nvmeq_cq_continue(struct nvme_queue *nvmeq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return nvmeq_outstanding(nvmeq) > nvmeq->pol=
l_thresh;
> +}
> +
> +static inline bool nvmeq_cq_idle(struct nvme_queue *nvmeq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return nvmeq->cq_head =3D=3D READ_ONCE(nvmeq=
->last_sq_tail);
> +}
> +
> +/*
> + * Interrupt-moderation profiles, ordered from least moderation (index 0=
: enter
> + * polling late, short sleep, brief linger -> lowest latency, most inter=
rupts)
> + * to most moderation (enter early, long sleep, long linger -> fewest
> + * interrupts). =C2=A0The hill-climb walks this table to keep completion=
s-per-
> + * interrupt high, which is what bounds the interrupt rate.
> + */
> +static const struct nvme_poll_prof {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 thresh;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 sleep_us;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 idle_rounds;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 budget; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* hard-IRQ initial poll cap; 0 =3D=3D reap all */
> +} nvme_poll_prof[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 31, =C2=A00, =C2=A01, =C2=A00 }, =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* drain inline: lowest latency, most interrupts */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 15, 10, =C2=A02, 16 },
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ =C2=A07, 20, =C2=A04, =C2=A08 }, =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* start profile; matches irq_poll_* defaults */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ =C2=A03, 40, =C2=A08, =C2=A04 },
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ =C2=A01, 80, 16, =C2=A02 }, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* reap a little, hand the bulk to the thread */
> +};
> +
> +#define NVME_DIM_START_PROFILE 2
> +
> +static void nvme_apply_profile(struct nvme_queue *nvmeq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct nvme_poll_prof *p =3D &nvme_pol=
l_prof[nvmeq->dim.profile_ix];
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->poll_thresh =3D p->thresh;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->poll_sleep_us =3D p->sleep_us;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->poll_idle_rounds =3D p->idle_rounds;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->poll_budget =3D p->budget;
> +}
> +
> +/* Mirror of rdma_dim_step() bounded to our profile table. */
> +static int nvme_dim_step(struct dim *dim)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dim->tune_state =3D=3D DIM_GOING_RIGHT) =
{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dim->profile=
_ix =3D=3D ARRAY_SIZE(nvme_poll_prof) - 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return DIM_ON_EDGE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dim->profile_ix+=
+;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dim->steps_right=
++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dim->tune_state =3D=3D DIM_GOING_LEFT) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dim->profile=
_ix =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return DIM_ON_EDGE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dim->profile_ix-=
-;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dim->steps_left+=
+;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return DIM_STEPPED;
> +}
> +
> +/* Mirror of rdma_dim_stats_compare(): completion rate first, then batch=
ing. */
> +static int nvme_dim_stats_compare(struct dim_stats *curr, struct dim_sta=
ts *prev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!prev->cpms)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DIM_STATS=
_SAME;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_SIGNIFICANT_DIFF(curr->cpms, prev->cp=
ms))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return curr->cpm=
s > prev->cpms ? DIM_STATS_BETTER :
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 DIM_STATS_WORSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, pre=
v->cpe_ratio))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return curr->cpe=
_ratio > prev->cpe_ratio ? DIM_STATS_BETTER :
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DIM_STATS_WORSE=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return DIM_STATS_SAME;
> +}
> +
> +/* Mirror of rdma_dim_decision(); returns true if the profile changed. *=
/
> +static bool nvme_dim_decision(struct dim_stats *curr, struct dim *dim)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int prev_ix =3D dim->profile_ix;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int stats_res;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0stats_res =3D nvme_dim_stats_compare(curr, &=
dim->prev_stats);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (stats_res) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0case DIM_STATS_SAME:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (curr->cpe_ra=
tio <=3D 50 * prev_ix)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dim->profile_ix =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0case DIM_STATS_WORSE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dim_turn(dim);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fallthrough;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0case DIM_STATS_BETTER:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_dim_ste=
p(dim) =3D=3D DIM_ON_EDGE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dim_turn(dim);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dim->prev_stats =3D *curr;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return dim->profile_ix !=3D prev_ix;
> +}
> +
> +/*
> + * Sample the completion/interrupt counters and, once per DIM_NEVENTS
> + * interrupts, compute the load stats. =C2=A0Called only from the interr=
upt owner
> + * (never concurrently with the poll thread), so the counters have a sin=
gle
> + * writer. =C2=A0ktime_get() is taken only at a window boundary, not per=
 interrupt.
> + *
> + * On each completed window the hill-climb picks a profile and, if it ch=
anged,
> + * applies it to nvmeq->poll_*.
> + */
> +static void nvme_dim(struct nvme_queue *nvmeq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dim *dim =3D &nvmeq->dim;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dim_sample end;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dim_stats stats;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dim->state =3D=3D DIM_START_MEASURE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dim_update_sampl=
e_with_comps(nvmeq->dim_events, 0, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 nvmeq->dim_comps, &dim->start_sample);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dim->state =3D D=
IM_MEASURE_IN_PROGRESS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Cheap gate: only recompute once a full wi=
ndow of events accrues. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((u16)(nvmeq->dim_events - dim->start_sam=
ple.event_ctr) < DIM_NEVENTS)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dim_update_sample_with_comps(nvmeq->dim_even=
ts, 0, 0, nvmeq->dim_comps,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &end);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dim_calc_stats(&dim->start_sample, &end,=
 &stats)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_dim_dec=
ision(&stats, dim))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvme_apply_profile(nvmeq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_nvme_dim(n=
vmeq->qid, stats.cpms, stats.epms,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stats.cpe_ratio, dim->profile_ix);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dim->start_sample =3D end;
> +}
> +
> =C2=A0static irqreturn_t nvme_irq(int irq, void *data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_IO_COMP_BATCH(iob);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *dev =3D nvmeq->dev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D to_pci_dev(dev->dev=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0irqreturn_t ret =3D IRQ_NONE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int idle =3D 0;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_poll_cq(nvmeq, &iob)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rq_list_emp=
ty(&iob.req_list))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvme_pci_complete_batch(&iob);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDL=
ED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool worked =3D =
false;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i =
<=3D irq_poll_spin; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int n =3D nvme_poll_cq(nvmeq, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (n) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dim_comps +=3D n;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D IRQ_HANDLED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worked =3D true;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0idle =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (nvmeq_cq_idle(nvmeq))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0else if (need_resched())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cond_resched();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_relax();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (worked || ++=
idle < nvmeq->poll_idle_rounds) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fsleep(nvmeq->poll_sleep_us);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0continue;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +done:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_=
POLLING, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!nvme_cqe_pe=
nding(nvmeq) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te=
st_and_set_bit(NVMEQ_POLLING, &nvmeq->flags))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (need_resched=
())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cond_resched();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cpu_relax();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0idle =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdev->msi_enabled)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BIT(nvmeq=
->cq_vector), dev->bar + NVME_REG_INTMC);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static irqreturn_t nvme_irq_check(int irq, void *data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int found;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dim_events++;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_cqe_pending(nvmeq))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_and_set_bit(NVMEQ_POLLING, &nvmeq->=
flags))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDL=
ED;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D nvme_poll_cq(nvmeq, nvmeq->poll_bu=
dget);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dim_comps +=3D found;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_dim(nvmeq);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!found) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_=
POLLING, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Hand off to the poll thread when the queu=
e is still deep, or when the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * budgeted initial poll left CQEs behind: t=
heir interrupt is already
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * spent, so releasing here would strand the=
m.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_cqe_pending(nvmeq) || nvmeq_cq_cont=
inue(nvmeq)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev =
*dev =3D nvmeq->dev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *=
pdev =3D to_pci_dev(dev->dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdev->msi_en=
abled)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_=
WAKE_THREAD;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_POLLING, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1663,7 +1943,7 @@ static void nvme_poll_irqdisable(struct nvme_queue =
*nvmeq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq =3D pci_irq_vector(pdev, nvmeq->cq_=
vector);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disable_irq(irq);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&nvmeq->cq_poll_lock);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_poll_cq(nvmeq, NULL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0__nvme_poll_cq(nvmeq, NULL, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&nvmeq->cq_poll_lock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_irq(irq);
> =C2=A0}
> @@ -1671,14 +1951,14 @@ static void nvme_poll_irqdisable(struct nvme_queu=
e *nvmeq)
> =C2=A0static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_bat=
ch *iob)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D hctx->driv=
er_data;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0bool found;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int found;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_bit(NVMEQ_POLLED, &nvmeq->fla=
gs) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!nvme_cqe_pending(nvmeq))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&nvmeq->cq_poll_lock);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D nvme_poll_cq(nvmeq, iob);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D __nvme_poll_cq(nvmeq, iob, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&nvmeq->cq_poll_lock);
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return found;
> @@ -2075,7 +2355,7 @@ static void nvme_reap_pending_cqes(struct nvme_dev =
*dev)
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D dev->ctrl.queue_count - 1; i=
 > 0; i--) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&=
dev->queues[i].cq_poll_lock);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_poll_cq(&de=
v->queues[i], NULL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__nvme_poll_cq(&=
dev->queues[i], NULL, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock=
(&dev->queues[i].cq_poll_lock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> @@ -2171,13 +2451,8 @@ static int queue_request_irq(struct nvme_queue *nv=
meq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D to_pci_dev(nvm=
eq->dev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nr =3D nvmeq->dev->ctrl.instance;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (use_threaded_interrupts) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pci_reque=
st_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_irq, nvmeq, "nvme%dq%d", nr, =
nvmeq->qid);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pci_reque=
st_irq(pdev, nvmeq->cq_vector, nvme_irq,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, nvmeq, "nvme%dq%d", nr, nvme=
q->qid);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return pci_request_irq(pdev, nvmeq->cq_vecto=
r, nvme_irq_check,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> =C2=A0}
> =C2=A0
> =C2=A0static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
> @@ -2188,6 +2463,17 @@ static void nvme_init_queue(struct nvme_queue *nvm=
eq, u16 qid)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->last_sq_tail =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->cq_head =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->cq_phase =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->poll_thresh =3D irq_poll_thresh;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->poll_sleep_us =3D irq_poll_sleep_us;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->poll_idle_rounds =3D irq_poll_idle_ro=
unds;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->poll_budget =3D nvme_poll_prof[NVME_D=
IM_START_PROFILE].budget;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&nvmeq->dim, 0, sizeof(nvmeq->dim));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dim.priv =3D nvmeq;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dim.profile_ix =3D NVME_DIM_START_PRO=
FILE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dim.tune_state =3D DIM_GOING_RIGHT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dim_events =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dim_comps =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_POLLING, &nvmeq->flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->q_db =3D &dev->dbs[qid * 2 * dev=
->db_stride];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset((void *)nvmeq->cqes, 0, CQ_SIZE(=
nvmeq));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_dbbuf_init(dev, nvmeq, qid);
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> index ad25ad1e40412..4bdd5abc60880 100644
> --- a/drivers/nvme/host/trace.c
> +++ b/drivers/nvme/host/trace.c
> @@ -498,3 +498,4 @@ const char *nvme_trace_disk_name(struct trace_seq *p,=
 char *name)
> =C2=A0}
> =C2=A0
> =C2=A0EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_dim);
> diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
> index 4fb5922ffdac5..b7099b3026079 100644
> --- a/drivers/nvme/host/trace.h
> +++ b/drivers/nvme/host/trace.h
> @@ -161,6 +161,29 @@ TRACE_EVENT(nvme_sq,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)
> =C2=A0);
> =C2=A0
> +TRACE_EVENT(nvme_dim,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_PROTO(u16 qid, int cpms, int epms, int cp=
e_ratio, u8 profile),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_ARGS(qid, cpms, epms, cpe_ratio, profile)=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_STRUCT__entry(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(u16, qid=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(int, cpm=
s)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(int, epm=
s)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(int, cpe=
_ratio)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(u8, prof=
ile)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_fast_assign(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__entry->qid =3D=
 qid;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__entry->cpms =
=3D cpms;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__entry->epms =
=3D epms;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__entry->cpe_rat=
io =3D cpe_ratio;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__entry->profile=
 =3D profile;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_printk("qid=3D%u cpms=3D%d epms=3D%d cpe_=
ratio=3D%d profile=3D%u",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__entry->qid, __=
entry->cpms, __entry->epms,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__entry->cpe_rat=
io, __entry->profile
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0)
> +);
> +
> =C2=A0#endif /* _TRACE_NVME_H */
> =C2=A0
> =C2=A0#undef TRACE_INCLUDE_PATH
> --
>=C2=A0

