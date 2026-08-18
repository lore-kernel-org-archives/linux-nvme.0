Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D17BC5DF74
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 03:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-Id:Subject:Cc:To:Date:In-Reply-To:References:
	Mime-Version:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iufgh6plOsVpgrPVYeoiXd930x64h8lKrF8Nj0pdkwU=; b=Pj5vxb3U3vQM6gfD68T/nKY+oP
	jq7A2oYYdJ3YQBSPTaFW/fwt3Jy7IQajpv/6PuIQmvYS0yL+uxAWwzIGnFlnublGrX7m1Y+P0lyry
	vPQx/RSgAKqxdwVMLP5ScuByX6WsJWXhfCAsBHpKrzCY0AoCVaz4yBbw8f1DHaKVQ0RtvAQ0aESRw
	+th3ind6Ec3LVwPzlNIvBEqQXaoyvt8Kb7dSm88QIG7oXSJsskoOFR+EGNhhdKA3I5qWBHg+zv6Ls
	ZYQHy1TvPSQl4hXbaGaf4yF2cmrhbhAVPMz3tSaKu0irROgscYxkC65epL9s+ULpwNja+mTBKDPOC
	jJkznecQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwAtu-00000007DYS-2qhd;
	Tue, 18 Aug 2026 03:54:10 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwAtq-00000007DXo-2PlY
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 03:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787025240; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=iufgh6plOsVpgrPVYeoiXd930x64h8lKrF8Nj0pdkwU=;
 b=fXSJ4+Aco2TiG5gdnN3cOlRfAvQqqQvpaOh34gBiflB/SJJQQsxpxDcy0XRGoeO6qCJ83F
 GL4a6Yw6nhzMMDZlz2RZ1SWeDiLzLKvt7Cp4X0ofUhhF6NCu8VjxLxtV8lmwlJPWhcyncJ
 Cx0s2+tBHyzw+eeF9qX+kzmG3fDPhIbF4vcu+nfP3y7vIIK2ZdBE0OXNL1NL3/k5n1wZfN
 MYA9ZR8k5W6Pd9xMhqHnLA/eMUUGb3QAFvGSjZuqtcCkMRLvUo88iU730RJaoCgi+m+cic
 +SoJey6aFzuOeUMrJiahlFjWNnI030xinNbX+Ozhh06lq9Om/aOOrYPquzLOOg==
From: "changfengnan" <changfengnan@bytedance.com>
Mime-Version: 1.0
References: <20260818033846.53790-1-changfengnan@bytedance.com>
In-Reply-To: <20260818033846.53790-1-changfengnan@bytedance.com>
Date: Tue, 18 Aug 2026 11:53:55 +0800
To: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<jun1.zeng@intel.com>, "Guzebing" <guzebing@bytedance.com>
Subject: Re: [PATCH] nvme-pci: add adaptive interrupt polling
X-Lms-Return-Path: <lba+16a83d756+8df29c+lists.infradead.org+changfengnan@bytedance.com>
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.c71e295f.cf49.450b.ad13.ed0e27cd481a@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_205406_836176_9C142F6B 
X-CRM114-Status: GOOD (  28.83  )
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

Here are my current test results.=C2=A0 https://docs.google.com/spreadsheet=
s/d/1kbPfcJ3pv6QsYPoq7F2A0AWHyGhA6tXQ4dfJsipK8pA/edit?gid=3D163427801#gid=
=3D163427801
Tests were performed on 13 different drive models; due to time constraints =
and testing environment limitations, only the 4K cases were tested on 8 of =
the drives.
Overall, there are fewer regressions and more improvements compared to the =
previous version.=C2=A0 The regressions at QD=3D31-34 have been resolved, s=
ome unstable regressions were observed only in scenarios involving sequenti=
al read/write operations at 128k, I believe this was caused by changes in t=
he disk's state during testing.

There are a few points to discuss:=C2=A0
1. Regarding the NVME_ADAPTIVE_POLL_PERIOD_NS parameter, is it necessary to=
 make it a configurable setting? Perhaps Gen6 SSDs require a smaller value?=
 I currently do not have a testing environment for this, but the default va=
lue of 10 us appears to be sufficient for Gen4 and Gen5.=C2=A0
2. Should MSI be supported? I do not have a similar environment, so I am un=
sure how it would perform in such scenarios.=C2=A0
3. Should it be enabled by default? Although current tests show only a mino=
r performance hit, I still lean toward disabling it by default and waiting =
to gather more test feedback.


> From: "Fengnan Chang"<changfengnan@bytedance.com>
> Date:=C2=A0 Tue, Aug 18, 2026, 11:39
> Subject:=C2=A0 [PATCH] nvme-pci: add adaptive interrupt polling
> To: "Keith Busch"<kbusch@kernel.org>, "Jens Axboe"<axboe@kernel.dk>, "Chr=
istoph Hellwig"<hch@lst.de>, "Sagi Grimberg"<sagi@grimberg.me>
> Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <ju=
n1.zeng@intel.com>, "Fengnan Chang"<changfengnan@bytedance.com>, "Guzebing"=
<guzebing@bytedance.com>
> In high-IOPS scenarios, relying on interrupts to handle I/O operations
> can limit performance. This issue becomes particularly pronounced in
> multi-disk environments, where performance is constrained by the CPU's
> interrupt-handling capacity.
>=C2=A0
> Add an opt-in adaptive policy for eligible non-threaded MSI-X I/O
> queues. The idea behind this approach is: let each I/O queue switch
> itself between interrupt and poll mode based on its own recent
> completion rate.
>=C2=A0
> In IRQ mode, sample at least 8192 completions and start a
> polling attempt when the average completion interval is at most 10 us.
> During the trial, hrtimer-driven irq_poll drains the CQ. Progress may
> trail the IRQ baseline by 20 us within a window, but a full 8192-CQE
> poll window must be strictly faster.
>=C2=A0
> Keep successful polling for at most 64 windows before refreshing the
> IRQ baseline. Allow two retries; after the third failed trial, count
> 64 windows worth of IRQ completions before resampling.
>=C2=A0
> The default-off module parameter initializes new controllers. A
> per-controller sysfs attribute changes the policy after freezing
> namespace request queues and draining outstanding I/O. Threaded
> interrupts are not supported.
>=C2=A0
> Link: https://lore.kernel.org/linux-nvme/d9210bcdf73fbe1ac8b6ec132865609a=
3ed68688.ff265e95.1296.491e.89f9.8ae888a03346@bytedance.com/T/#mea881a7898c=
85b73992f568864001913cb456d59
> Link: https://lore.kernel.org/linux-nvme/20260806031058.40176-1-changfeng=
nan@bytedance.com/T/#u
> Signed-off-by: Guzebing <guzebing@bytedance.com>
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> ---
> =C2=A0Documentation/ABI/testing/sysfs-nvme | =C2=A015 +
> =C2=A0drivers/nvme/host/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 1 +
> =C2=A0drivers/nvme/host/pci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 507 +++++++++++++++++++++++++--
> =C2=A03 files changed, 497 insertions(+), 26 deletions(-)
>=C2=A0
> diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/tes=
ting/sysfs-nvme
> index 499d5f843cd43..695da343f65ef 100644
> --- a/Documentation/ABI/testing/sysfs-nvme
> +++ b/Documentation/ABI/testing/sysfs-nvme
> @@ -11,3 +11,18 @@ Description:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(REPLACETLS=
PSK) with the target. After a reauthentication
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the value r=
eturned by tls_configured_key will be the new
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial.
> +
> +What: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/class/=
nvme/nvmeX/adaptive_irq_polling
> +Date: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0August 2026
> +KernelVersion: =C2=A0 =C2=A0 =C2=A0 =C2=A07.2
> +Contact: =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux NVMe mailing list <linux-nvme@=
lists.infradead.org>
> +Description:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set the adaptive=
 IRQ polling policy (0 or 1) for eligible I/O queues of one
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI NVMe control=
ler. =C2=A0Reading returns the policy, not whether a queue
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is currently pol=
ling. =C2=A0Changing it freezes the namespace request
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queues and waits=
 for outstanding namespace I/O. =C2=A0Writes fail with
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EBUSY unless the=
 controller is live.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Eligible queues =
use non-threaded MSI-X with a dedicated vector. =C2=A0The
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attribute is una=
vailable with threaded interrupts. =C2=A0The module
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parameter suppli=
es only the initial policy for new controllers.
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 31974c7dd20c9..22164b901da85 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -5,6 +5,7 @@ config NVME_CORE
> =C2=A0config BLK_DEV_NVME
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "NVM Express block device"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on PCI && BLOCK
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0select IRQ_POLL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0select NVME_CORE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The NVM Express driver is for so=
lid state drives directly
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 69932d640b537..b24c462d5aff2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -10,9 +10,12 @@
> =C2=A0#include <linux/blk-mq-dma.h>
> =C2=A0#include <linux/blk-integrity.h>
> =C2=A0#include <linux/dmi.h>
> +#include <linux/hrtimer.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/io.h>
> +#include <linux/irq_poll.h>
> +#include <linux/ktime.h>
> =C2=A0#include <linux/kstrtox.h>
> =C2=A0#include <linux/memremap.h>
> =C2=A0#include <linux/mm.h>
> @@ -82,6 +85,16 @@ struct quirk_entry {
> =C2=A0static int use_threaded_interrupts;
> =C2=A0module_param(use_threaded_interrupts, int, 0444);
> =C2=A0
> +static bool use_adaptive_irq_polling;
> +module_param(use_adaptive_irq_polling, bool, 0444);
> +MODULE_PARM_DESC(use_adaptive_irq_polling,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "default adapti=
ve polling policy for eligible I/O queues");
> +
> +#define NVME_ADAPTIVE_POLL_PERIOD_NS =C2=A0 =C2=A0 =C2=A0 =C2=A0(10U * N=
SEC_PER_USEC)
> +#define NVME_ADAPTIVE_EPISODE_CQES =C2=A0 =C2=A0 =C2=A0 =C2=A08192U
> +#define NVME_ADAPTIVE_REEVAL_CQES =C2=A0 =C2=A0 =C2=A0 =C2=A0(64U * NVME=
_ADAPTIVE_EPISODE_CQES)
> +#define NVME_ADAPTIVE_POLL_RETRIES =C2=A0 =C2=A0 =C2=A0 =C2=A02U
> +
> =C2=A0static bool use_cmb_sqes =3D true;
> =C2=A0module_param(use_cmb_sqes, bool, 0444);
> =C2=A0MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for =
I/O SQes");
> @@ -307,6 +320,7 @@ struct nvme_dev {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *bar;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long bar_mapped_size;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex shutdown_lock;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0bool adaptive_irq_polling;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool subsystem;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 cmb_size;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool cmb_use_sqes;
> @@ -358,6 +372,18 @@ static inline struct nvme_dev *to_nvme_dev(struct nv=
me_ctrl *ctrl)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return container_of(ctrl, struct nvme_d=
ev, ctrl);
> =C2=A0}
> =C2=A0
> +struct nvme_adaptive_poll {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hrtimer timer; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fires the next poll drain */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct irq_poll iopoll; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* softirq context for the drain */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 start_ns; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* when the current =
sample/episode started */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 retry_completions; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* completions until retry or IRQ rebasel=
ine */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 interval_ns; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* sampled average gap between completions */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 completions; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* completions seen so far this sample/episode =
*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 poll_failures; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* consecutive rejected polling trials */
> +};
> +
> =C2=A0/*
> =C2=A0 * An NVM Express queue. =C2=A0Each device has at least two (one fo=
r admin
> =C2=A0 * commands and one for I/O commands).
> @@ -367,7 +393,8 @@ struct nvme_queue {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_descriptor_pools descriptor=
_pools;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t sq_lock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *sq_cmds;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* only used for poll queues: */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Used for both poll queues and adaptive in=
terrupt polling. */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t cq_poll_lock ____cacheline_a=
ligned_in_smp;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_completion *cqes;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t sq_dma_addr;
> @@ -386,6 +413,9 @@ struct nvme_queue {
> =C2=A0#define NVMEQ_SQ_CMB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01
> =C2=A0#define NVMEQ_DELETE_ERROR =C2=A0 =C2=A0 =C2=A0 =C2=A02
> =C2=A0#define NVMEQ_POLLED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A03
> +#define NVMEQ_ADAPTIVE_POLLING =C2=A0 =C2=A0 =C2=A0 =C2=A04
> +#define NVMEQ_ADAPTIVE_ENABLED =C2=A0 =C2=A0 =C2=A0 =C2=A05
> +#define NVMEQ_ADAPTIVE_STALE_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A06
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 *dbbuf_sq_db;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 *dbbuf_cq_db;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 *dbbuf_sq_ei;
> @@ -1606,13 +1636,12 @@ static inline void nvme_update_cq_head(struct nvm=
e_queue *nvmeq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> =C2=A0
> -static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct io_comp_batch *iob)
> +static inline unsigned int nvme_poll_cq(struct nvme_queue *nvmeq,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 io_comp_batch *iob)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0bool found =3D false;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int found =3D 0;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (nvme_cqe_pending(nvmeq)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D true;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * load-loa=
d control dependency between phase and the rest of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the cqe =
requires a full read memory barrier
> @@ -1620,6 +1649,7 @@ static inline bool nvme_poll_cq(struct nvme_queue *=
nvmeq,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_rmb();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_handle=
_cqe(nvmeq, iob, nvmeq->cq_head);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_update=
_cq_head(nvmeq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (found)
> @@ -1627,17 +1657,22 @@ static inline bool nvme_poll_cq(struct nvme_queue=
 *nvmeq,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return found;
> =C2=A0}
> =C2=A0
> -static irqreturn_t nvme_irq(int irq, void *data)
> +/* Keep the normal completion loop branch-free. */
> +static unsigned int nvme_poll_cq_bounded(struct nvme_queue *nvmeq,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struc=
t io_comp_batch *iob,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsig=
ned int limit)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_IO_COMP_BATCH(iob);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int found =3D 0;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_poll_cq(nvmeq, &iob)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rq_list_emp=
ty(&iob.req_list))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvme_pci_complete_batch(&iob);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDL=
ED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0while (found < limit && nvme_cqe_pending(nvm=
eq)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_rmb();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_handle_cqe(=
nvmeq, iob, nvmeq->cq_head);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_update_cq_h=
ead(nvmeq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (found)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_ring_cq_doo=
rbell(nvmeq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return found;
> =C2=A0}
> =C2=A0
> =C2=A0static irqreturn_t nvme_irq_check(int irq, void *data)
> @@ -1649,6 +1684,235 @@ static irqreturn_t nvme_irq_check(int irq, void *=
data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
> =C2=A0}
> =C2=A0
> +/* Reset adaptive state to an uninitialised IRQ baseline. */
> +static void nvme_adaptive_state_reset(struct nvme_adaptive_poll *adaptiv=
e)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->start_ns =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->retry_completions =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->interval_ns =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->completions =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->poll_failures =3D 0;
> +}
> +
> +/*
> + * Restore IRQ mode. =C2=A0The first two failed trials rebaseline immedi=
ately;
> + * the third backs off for 64 windows.
> + */
> +static void nvme_adaptive_poll_end(struct nvme_queue *nvmeq, bool backof=
f)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D nvme=
q->adaptive;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 poll_failures =3D adaptive->poll_failures=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_state_reset(adaptive);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (backoff) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (poll_failure=
s < NVME_ADAPTIVE_POLL_RETRIES)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0adaptive->poll_failures =3D poll_failures + 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0adaptive->retry_completions =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_ADAPTIVE_REEVAL_CQES;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->fl=
ags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->fl=
ags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_irq(adaptive->irq);
> +}
> +
> +static void nvme_adaptive_poll_window_start(struct nvme_adaptive_poll *a=
daptive,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0u64 now)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->start_ns =3D now;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->completions =3D 0;
> +}
> +
> +static void nvme_adaptive_arm(struct nvme_adaptive_poll *adaptive, u64 n=
ow)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0hrtimer_start(&adaptive->timer,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ns_to_ktime(now + NVME_ADAPTIVE_POLL_PERIOD_NS),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0HRTIMER_MODE_ABS_PINNED_HARD);
> +}
> +
> +static enum hrtimer_restart nvme_adaptive_poll_timer(struct hrtimer *tim=
er)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D cont=
ainer_of(timer,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 nvme_adaptive_poll, timer);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D adaptive->nvmeq=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq-=
>flags))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_sched(&=
adaptive->iopoll);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return HRTIMER_NORESTART;
> +}
> +
> +/*
> + * Drain CQEs from IRQ_POLL_SOFTIRQ and compare completion progress with=
 the
> + * IRQ baseline. =C2=A0Re-arm while within the allowed lag; leave poll m=
ode on lag
> + * or teardown, and start another window only after a faster full window=
.
> + */
> +static int nvme_adaptive_irq_poll(struct irq_poll *iop, int budget)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D cont=
ainer_of(iop,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 nvme_adaptive_poll, iopoll);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D adaptive->nvmeq=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int completions, limit;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 deadline, elapsed, now;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_IO_COMP_BATCH(iob);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&nvmeq->cq_poll_lock, flag=
s);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(!test_bit(NVMEQ_ADAPTIVE_POLLIN=
G, &nvmeq->flags))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0completions =3D =
0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_complet=
e(iop);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags))=
 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0completions =3D =
0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_complet=
e(iop);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_po=
ll_end(nvmeq, false);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0limit =3D min_t(unsigned int,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0budget,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0NVME_ADAPTIVE_EPISODE_CQES - adaptive->completions);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0completions =3D nvme_poll_cq_bounded(nvmeq, =
&iob, limit);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->completions +=3D completions;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (completions >=3D budget &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->completions < NVME_A=
DAPTIVE_EPISODE_CQES)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_complete(iop);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Before the window fills, allow progress t=
o trail the IRQ baseline by
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * two poll periods. =C2=A0At the boundary, =
require a strictly shorter time.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * interval_ns is rounded down, so equal or =
slower never passes.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0now =3D ktime_get_ns();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0elapsed =3D now - adaptive->start_ns;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0deadline =3D (u64)adaptive->completions * ad=
aptive->interval_ns;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adaptive->completions < NVME_ADAPTIVE_EP=
ISODE_CQES) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (elapsed > de=
adline +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02U=
 * NVME_ADAPTIVE_POLL_PERIOD_NS)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvme_adaptive_poll_end(nvmeq, true);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvme_adaptive_arm(adaptive, now);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (elapsed >=3D deadline) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_po=
ll_end(nvmeq, true);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->poll_failures =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Bound polling to 64 successful windows be=
fore an IRQ rebaseline. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->retry_completions -=3D NVME_ADAPTI=
VE_EPISODE_CQES;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adaptive->retry_completions) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_po=
ll_end(nvmeq, false);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_poll_window_start(adaptive, no=
w);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_arm(adaptive, now);
> +out:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&nvmeq->cq_poll_lock,=
 flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rq_list_empty(&iob.req_list))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_pci_complet=
e_batch(&iob);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return completions;
> +}
> +
> +/*
> + * Count down an IRQ backoff or sample at least one completion window.
> + * A polling attempt is permitted when the average interval is no
> + * greater than the poll period.
> + */
> +static void nvme_adaptive_sample(struct nvme_queue *nvmeq,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int completions)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D nvme=
q->adaptive;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 delta, interval, now;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adaptive->retry_completions) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->retry_=
completions -=3D min(completions,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adaptive->retry_completions);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adaptive->start_ns) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->start_=
ns =3D ktime_get_ns();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->completions +=3D completions;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adaptive->completions < NVME_ADAPTIVE_EP=
ISODE_CQES)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0now =3D ktime_get_ns();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0delta =3D now - adaptive->start_ns;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Admission only; a full poll window decide=
s whether polling wins. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0interval =3D div64_u64(delta, adaptive->comp=
letions);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!interval || interval > NVME_ADAPTIVE_PO=
LL_PERIOD_NS ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!test_bit(NVMEQ_ENABLED, &nvme=
q->flags)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_po=
ll_window_start(adaptive, now);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->interval_ns =3D interval;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->retry_completions =3D NVME_ADAPTIV=
E_REEVAL_CQES;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_poll_window_start(adaptive, no=
w);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flag=
s);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0disable_irq_nosync(adaptive->irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_arm(adaptive, now);
> +}
> +
> +static irqreturn_t nvme_irq(int irq, void *data);
> +
> +static noinline irqreturn_t nvme_irq_adaptive_enabled(int irq, void *dat=
a)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int completions;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_IO_COMP_BATCH(iob);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&nvmeq->cq_poll_lock, flag=
s);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(test_bit(NVMEQ_ADAPTIVE_POLLING=
, &nvmeq->flags))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqr=
estore(&nvmeq->cq_poll_lock, flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDL=
ED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0completions =3D nvme_poll_cq(nvmeq, &iob);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (completions)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_sa=
mple(nvmeq, completions);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&nvmeq->cq_poll_lock,=
 flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!completions)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return test_and_=
clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&nvmeq->flags) ? IRQ_HANDLED : IRQ_NONE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rq_list_empty(&iob.req_list))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_pci_complet=
e_batch(&iob);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t nvme_irq_adaptive(int irq, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0irqreturn_t ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq=
->flags)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D nvme_irq=
(irq, data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D I=
RQ_NONE &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te=
st_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return IRQ_HANDLED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return nvme_irq_adaptive_enabled(irq, data);
> +}
> +
> +static irqreturn_t nvme_irq(int irq, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_IO_COMP_BATCH(iob);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_poll_cq(nvmeq, &iob)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rq_list_emp=
ty(&iob.req_list))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvme_pci_complete_batch(&iob);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDL=
ED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
> +}
> +
> =C2=A0/*
> =C2=A0 * Poll for completions for any interrupt driven queue
> =C2=A0 * Can be called from any context.
> @@ -1656,30 +1920,36 @@ static irqreturn_t nvme_irq_check(int irq, void *=
data)
> =C2=A0static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D to_pci_dev(nvm=
eq->dev->dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nv=
meq->flags));
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq =3D pci_irq_vector(pdev, nvmeq->cq_=
vector);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disable_irq(irq);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&nvmeq->cq_poll_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&nvmeq->cq_poll_lock, flag=
s);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_poll_cq(nvmeq, NULL);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&nvmeq->cq_poll_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&nvmeq->cq_poll_lock,=
 flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_irq(irq);
> =C2=A0}
> =C2=A0
> =C2=A0static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_bat=
ch *iob)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D hctx->driv=
er_data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool found;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_bit(NVMEQ_POLLED, &nvmeq->fla=
gs) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!nvme_cqe_pending(nvmeq))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&nvmeq->cq_poll_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * cq_poll_lock is also taken from hardirq b=
y the adaptive handler.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Disable IRQs here so lockdep sees a consi=
stent lock class.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&nvmeq->cq_poll_lock, flag=
s);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D nvme_poll_cq(nvmeq, iob);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&nvmeq->cq_poll_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&nvmeq->cq_poll_lock,=
 flags);
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return found;
> =C2=A0}
> @@ -2017,8 +2287,7 @@ static void nvme_free_queue(struct nvme_queue *nvme=
q)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_free_coherent(nvmeq->dev->dev, CQ_S=
IZE(nvmeq),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)nvmeq->cqes, nvmeq->cq=
_dma_addr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!nvmeq->sq_cmds)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> -
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_adapti=
ve;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_and_clear_bit(NVMEQ_SQ_CMB, &n=
vmeq->flags)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_free_p2=
pmem(to_pci_dev(nvmeq->dev->dev),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->sq_cmds, SQ_SIZE(nvmeq)=
);
> @@ -2026,6 +2295,9 @@ static void nvme_free_queue(struct nvme_queue *nvme=
q)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_free_co=
herent(nvmeq->dev->dev, SQ_SIZE(nvmeq),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->sq_cmds, nvmeq->sq_dma_=
addr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +free_adaptive:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(nvmeq->adaptive);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->adaptive =3D NULL;
> =C2=A0}
> =C2=A0
> =C2=A0static void nvme_free_queues(struct nvme_dev *dev, int lowest)
> @@ -2038,9 +2310,96 @@ static void nvme_free_queues(struct nvme_dev *dev,=
 int lowest)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> =C2=A0
> +static int nvme_adaptive_suspend(struct nvme_queue *nvmeq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D nvme=
q->adaptive;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adaptive || adaptive->irq < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0irq =3D adaptive->irq;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0synchronize_irq(irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_disable(&adaptive->iopoll);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* irq_poll_complete() can run before the po=
ll callback returns. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&nvmeq->cq_poll_lock, flag=
s);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_and_clear_bit(NVMEQ_ADAPTIVE_POLLIN=
G, &nvmeq->flags)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(NVMEQ_AD=
APTIVE_STALE_IRQ, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_irq(irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&nvmeq->cq_poll_lock,=
 flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0hrtimer_cancel(&adaptive->timer);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return irq;
> +}
> +
> +static void nvme_adaptive_set_queue(struct nvme_queue *nvmeq, bool enabl=
e)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D nvme=
q->adaptive;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_adaptive_suspend(nvmeq) < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_=
ADAPTIVE_ENABLED, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&nvmeq->cq_poll_lock, flag=
s);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_state_reset(adaptive);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(NVMEQ_AD=
APTIVE_ENABLED, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_=
ADAPTIVE_ENABLED, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&nvmeq->cq_poll_lock,=
 flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_enable(&adaptive->iopoll);
> +}
> +
> +/*
> + * Freeze namespace I/O before switching completion mode. =C2=A0scan_loc=
k keeps
> + * the namespace set stable; shutdown_lock prevents concurrent reset.
> + */
> +static int nvme_adaptive_switch(struct nvme_dev *dev, bool enable)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int qid, ret =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&dev->ctrl.scan_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_ctrl_state(&dev->ctrl) !=3D NVME_CT=
RL_LIVE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EBUSY;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable =3D=3D READ_ONCE(dev->adaptive_ir=
q_polling))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_start_freeze(&dev->ctrl);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_wait_freeze(&dev->ctrl);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&dev->shutdown_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_ctrl_state(&dev->ctrl) !=3D NVME_CT=
RL_LIVE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EBUSY;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (qid =3D 1; =
qid < dev->ctrl.queue_count; qid++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvme_adaptive_set_queue(&dev->queues[qid], enable);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(dev->=
adaptive_irq_polling, enable);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&dev->shutdown_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_unfreeze(&dev->ctrl);
> +out_unlock:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&dev->ctrl.scan_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +}
> +
> +static void nvme_adaptive_suspend_done(struct nvme_queue *nvmeq, int irq=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->adaptive->irq =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_enable(&nvmeq->adaptive->iopoll);
> +}
> +
> =C2=A0static void nvme_suspend_queue(struct nvme_dev *dev, unsigned int q=
id)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D &dev->queu=
es[qid];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D to_pci_dev(dev->dev=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_and_clear_bit(NVMEQ_ENABLED, =
&nvmeq->flags))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> @@ -2051,8 +2410,11 @@ static void nvme_suspend_queue(struct nvme_dev *de=
v, unsigned int qid)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dev->online_queues--;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!nvmeq->qid && nvmeq->dev->ctrl.adm=
in_q)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_quiesc=
e_admin_queue(&nvmeq->dev->ctrl);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq=
->flags))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_free_irq(to_=
pci_dev(dev->dev), nvmeq->cq_vector, nvmeq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq=
->flags)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq =3D nvme_ada=
ptive_suspend(nvmeq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_free_irq(pde=
v, nvmeq->cq_vector, nvmeq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_su=
spend_done(nvmeq, irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> =C2=A0
> =C2=A0static void nvme_suspend_io_queues(struct nvme_dev *dev)
> @@ -2071,12 +2433,13 @@ static void nvme_suspend_io_queues(struct nvme_de=
v *dev)
> =C2=A0 */
> =C2=A0static void nvme_reap_pending_cqes(struct nvme_dev *dev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D dev->ctrl.queue_count - 1; i=
 > 0; i--) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&dev->=
queues[i].cq_poll_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsav=
e(&dev->queues[i].cq_poll_lock, flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_poll_c=
q(&dev->queues[i], NULL);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&dev=
->queues[i].cq_poll_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqr=
estore(&dev->queues[i].cq_poll_lock, flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> =C2=A0
> @@ -2166,18 +2529,78 @@ static int nvme_alloc_queue(struct nvme_dev *dev,=
 int qid, int depth)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;
> =C2=A0}
> =C2=A0
> +/*
> + * Allocate or re-arm adaptive state after reset. =C2=A0The caller has e=
stablished
> + * MSI-X eligibility; return false if vector lookup or allocation fails.
> + */
> +static bool nvme_adaptive_init(struct nvme_queue *nvmeq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D nvme=
q->adaptive;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq =3D pci_irq_vector(to_pci_dev(nvmeq-=
>dev->dev),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvmeq->cq_vector);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adaptive) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive =3D kza=
lloc_node(sizeof(*adaptive), GFP_KERNEL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_to=
_node(nvmeq->dev->dev));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adaptive)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return false;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->nvmeq =
=3D nvmeq;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hrtimer_setup(&a=
daptive->timer, nvme_adaptive_poll_timer,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_=
HARD);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_poll_init(&a=
daptive->iopoll, 64, nvme_adaptive_irq_poll);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->irq =
=3D irq;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(nvmeq=
->adaptive, adaptive);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->irq =3D irq;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;
> +}
> +
> =C2=A0static int queue_request_irq(struct nvme_queue *nvmeq)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D to_pci_dev(nvm=
eq->dev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nr =3D nvmeq->dev->ctrl.instance;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0bool adaptive_queue;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (use_threaded_interrupts) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_=
ADAPTIVE_ENABLED, &nvmeq->flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pci_=
request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_irq, nvmeq, "nvme%dq%d", =
nr, nvmeq->qid);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pci_reque=
st_irq(pdev, nvmeq->cq_vector, nvme_irq,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, nvmeq, "nvme%dq%d", nr, nvme=
q->qid);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Install the adaptive-capable handler only=
 on eligible queues. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive_queue =3D nvmeq->qid && nvmeq->dev-=
>num_vecs > 1 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev->msix_enabl=
ed;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adaptive_queue)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive_queue =
=3D nvme_adaptive_init(nvmeq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adaptive_queue && READ_ONCE(nvmeq->dev->=
adaptive_irq_polling))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(NVMEQ_AD=
APTIVE_ENABLED, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_=
ADAPTIVE_ENABLED, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D pci_request_irq(pdev, nvmeq->cq_vect=
or,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive_queue ? nvme_irq_adaptive : nvme=
_irq,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adaptive_queue || ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_=
ADAPTIVE_ENABLED, &nvmeq->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret && nvmeq=
->adaptive)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvmeq->adaptive->irq =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +}
> +
> +static void nvme_adaptive_reset(struct nvme_queue *nvmeq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D nvme=
q->adaptive;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->fl=
ags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->fl=
ags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->=
flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adaptive)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_state_reset(adaptive);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->irq =3D -1;
> =C2=A0}
> =C2=A0
> =C2=A0static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
> @@ -2188,6 +2611,7 @@ static void nvme_init_queue(struct nvme_queue *nvme=
q, u16 qid)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->last_sq_tail =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->cq_head =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->cq_phase =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_reset(nvmeq);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->q_db =3D &dev->dbs[qid * 2 * dev=
->db_stride];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset((void *)nvmeq->cqes, 0, CQ_SIZE(=
nvmeq));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_dbbuf_init(dev, nvmeq, qid);
> @@ -2808,6 +3232,33 @@ static ssize_t hmb_store(struct device *dev, struc=
t device_attribute *attr,
> =C2=A0}
> =C2=A0static DEVICE_ATTR_RW(hmb);
> =C2=A0
> +static ssize_t adaptive_irq_polling_show(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struc=
t device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char =
*buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return sysfs_emit(buf, "%d\n", READ_ONCE(nde=
v->adaptive_irq_polling));
> +}
> +
> +static ssize_t adaptive_irq_polling_store(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const char *buf, size_t count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0bool enable;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kstrtobool(buf, &enable);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D nvme_adaptive_switch(ndev, enable);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return count;
> +}
> +static DEVICE_ATTR_RW(adaptive_irq_polling);
> +
> =C2=A0static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct attr=
ibute *a, int n)
> =C2=A0{
> @@ -2823,6 +3274,8 @@ static umode_t nvme_pci_attrs_are_visible(struct ko=
bject *kobj,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (a =3D=3D &dev_attr_hmb.attr && !ctr=
l->hmpre)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (a =3D=3D &dev_attr_adaptive_irq_polling.=
attr && use_threaded_interrupts)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return a->mode;
> =C2=A0}
> @@ -2832,6 +3285,7 @@ static struct attribute *nvme_pci_attrs[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_cmbloc.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_cmbsz.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_hmb.attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_adaptive_irq_polling.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,
> =C2=A0};
> =C2=A0
> @@ -3685,6 +4139,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct p=
ci_dev *pdev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_=
PTR(-ENOMEM);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_WORK(&dev->ctrl.reset_work, nvme_r=
eset_work);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&dev->shutdown_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->adaptive_irq_polling =3D use_adaptive_i=
rq_polling;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->nr_write_queues =3D write_queues;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->nr_poll_queues =3D poll_queues;
> --=C2=A0
> 2.39.5 (Apple Git-154)
>=C2=A0

