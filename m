Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED50C531CA
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:From:Subject:Cc:To:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b3i9cmTeKgt+8AccDjj2JuDAlMA4u2G99Fe7LYubyl0=; b=BnJG2L62RHpDLpAxfdL345G/qo
	XfmS9dhZy49fjkcGRZyKkMFJJ2yOq+TSVb5zuKmcZmVUW/8ApO5sdA12JMq4+1+jKEFtImWaczl73
	Jyx2pDMkMJcEDVF6gVFux05pgl/pGkHPiG+aS6ebvfwC13pdxONTQQFOe/D1+fK6TIyh4S0xnsYYb
	PJ+bjG/f583xObwkeQzEhvH/K7Hmgh1dcOj9Go1AS6rQ6rk5a31JsO8YbDl40n5s2M6TyTmjMece2
	FQzp0Vcpp/z3XUniY+H5Ia7uOfEtDsuwOt1vb+uAs1oYw0XCH+NGHh/HEu7YSe7BGw9Olbjww1UXj
	aijiJTQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmsKU-0000000EDOH-146a;
	Thu, 23 Jul 2026 12:15:10 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmsKP-0000000EDN2-22E7
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 12:15:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784808899; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=b3i9cmTeKgt+8AccDjj2JuDAlMA4u2G99Fe7LYubyl0=;
 b=DIudd6TFJVa4dYUnbE8brBWM8KMoMoLbO5uQLElSheYtVTjcuos/D54tJVsVBv2spE6b7q
 6c4EpcfYql1TDwQ36jDjO0miNMcSxxS850M+Okq/E7XM4yIyBMc832l/BRBfKzlbzieFYQ
 xiq8ui4scbma/KENkGyDcW+eTKDWp9aT1XQd+zGQivRoLj/bxVARtfnS2e6Aejm4+p7yfo
 tNmjSAVWbIgmQEI6NsYzE4u+Lzg+nILHSnh1HI8nePUUV1aX5JdKddxPJEnExMBtzZRrUH
 ZD2QRzR8hDOAIrulbzIHvRZLXXEcbS/5zPFKcFqHi1QIKLWj9J+G/AkshmK/Zg==
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16a6205c1+5c1fcd+lists.infradead.org+changfengnan@bytedance.com>
To: <linux-nvme@lists.infradead.org>, "Keith Busch" <kbusch@kernel.org>, 
	"Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, 
	"Sagi Grimberg" <sagi@grimberg.me>, 
	"Bart Van Assche" <bvanassche@acm.org>, 
	"Andy Shevchenko" <andriy.shevchenko@intel.com>, 
	"Thomas Gleixner" <tglx@kernel.org>, "Jun Zeng" <jun1.zeng@intel.com>, 
	"Gang Cao" <gang.cao@intel.com>, "Jun I Jin" <jun.i.jin@intel.com>, 
	"Liang A Fang" <liang.a.fang@intel.com>, "Yong Hu" <yong.hu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "Guzebing" <guzebing@bytedance.com>
Subject: Re: [RFC PATCH] nvme-pci: adaptively poll completions on busy queues
From: "changfengnan" <changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 20:14:54 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.4d5fdf63.b276.49d7.bc79.f7bcddd26cbe@bytedance.com>
References: <20260723120556.58670-1-changfengnan@bytedance.com>
In-Reply-To: <20260723120556.58670-1-changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_051505_665947_A86C8F84 
X-CRM114-Status: GOOD (  28.89  )
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

Two additional points:=C2=A0
1. The current handling of `nvme_adaptive_mask_irq` is a bit complex.
=C2=A0I don=E2=80=99t think it=E2=80=99s necessary to add a separate logic =
path specifically for
MSI; using `disable_irq_nosync` directly should suffice.=C2=A0
Keith, what do you think?=C2=A0
2. More detailed testing is currently underway, covering a wider
range of workloads and different drives.=C2=A0
I=E2=80=99ll update the test data later.

Thanks.
Fengnan

> From: "Fengnan Chang"<changfengnan@bytedance.com>
> Date:=C2=A0 Thu, Jul 23, 2026, 20:06
> Subject:=C2=A0 [RFC PATCH] nvme-pci: adaptively poll completions on busy =
queues
> To: <linux-nvme@lists.infradead.org>, "Keith Busch"<kbusch@kernel.org>, "=
Jens Axboe"<axboe@kernel.dk>, "Christoph Hellwig"<hch@lst.de>, "Sagi Grimbe=
rg"<sagi@grimberg.me>, "Bart Van Assche"<bvanassche@acm.org>, "Andy Shevche=
nko"<andriy.shevchenko@intel.com>, "Thomas Gleixner"<tglx@kernel.org>, "Jun=
 Zeng"<jun1.zeng@intel.com>, "Gang Cao"<gang.cao@intel.com>, "Jun I Jin"<ju=
n.i.jin@intel.com>, "Liang A Fang"<liang.a.fang@intel.com>, "Yong Hu"<yong.=
hu@intel.com>
> Cc: <linux-kernel@vger.kernel.org>, "Fengnan Chang"<changfengnan@bytedanc=
e.com>, "Guzebing"<guzebing@bytedance.com>
> In high-IOPS scenarios, relying on interrupts to handle I/O operations
> can limit performance. This issue becomes particularly pronounced in
> multi-disk environments, where performance is constrained by the CPU=E2=
=80=99s
> interrupt-handling capacity.
>=C2=A0
> Each Solidigm SB5PH27X038T device used for testing can deliver about 3.2M
> 4 KiB random-read IOPS. =C2=A0Four devices therefore have about 12.8M IOP=
S of
> aggregate capability, but interrupt-driven completion topped out at 7.81M
> IOPS, or about 61% of that capability.
>=C2=A0
> Add optional adaptive polling for busy interrupt-driven I/O queues. =C2=
=A0After
> an interrupt drains the CQ, use the ring distance between last_sq_tail an=
d
> cq_head as an approximate host-side inflight count. =C2=A0If the count re=
aches
> a per-controller high watermark, let the threaded handler keep draining
> completions instead of returning to interrupt-driven completion right awa=
y.
>=C2=A0
> The thread always checks for pending CQEs first. =C2=A0When the CQ is emp=
ty, it
> compares the inflight count with a per-controller low watermark and sleep=
s
> for a configurable interval before checking again. =C2=A0It returns to
> interrupt-driven completion after three consecutive empty-CQ checks below
> the low watermark or when the loop limit is reached.
>=C2=A0
> The mode is disabled by default. It can be enabled at module load time.
> The high and low watermarks, empty-CQ interval, and loop limit are
> available through sysfs. =C2=A0The defaults are 32 commands, 3 commands,
> 30 us, and 1000 iterations.
>=C2=A0
> Tested with the default settings and 4 KiB random reads on four Solidigm
> SB5PH27X038T devices. =C2=A0With adaptive polling off and on:
>=C2=A0
> =C2=A0 - t/io_uring, depth 1024 and four workers per device:
> =C2=A0 =C2=A0 7.810M and 12.780M aggregate IOPS (+63.64%).
> =C2=A0 - fio/libaio, iodepth 1024, numjobs 4 and completion batches of 32=
:
> =C2=A0 =C2=A0 7.699M and 12.785M aggregate IOPS (+66.05%).
>=C2=A0
> In a paired libaio and io_uring boundary sweep, QD8, QD16, QD32, and
> QD16/numjobs=3D4 changed by -0.15% to +0.48%. =C2=A0QD64 improved by 28.6=
1% to
> 59.75%.
>=C2=A0
> Link: https://lore.kernel.org/linux-nvme/20260720145927.GA17986@lst.de/
> Signed-off-by: Guzebing <guzebing@bytedance.com>
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> ---
> =C2=A0Documentation/ABI/testing/sysfs-nvme | =C2=A063 +++++++
> =C2=A0drivers/nvme/host/pci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 266 +++++++++++++++++++++++++++
> =C2=A02 files changed, 329 insertions(+)
>=C2=A0
> diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/tes=
ting/sysfs-nvme
> index 499d5f843cd43..9e22a51a0f5bb 100644
> --- a/Documentation/ABI/testing/sysfs-nvme
> +++ b/Documentation/ABI/testing/sysfs-nvme
> @@ -11,3 +11,66 @@ Description:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(REPLACETLS=
PSK) with the target. After a reauthentication
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the value r=
eturned by tls_configured_key will be the new
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial.
> +
> +What: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/class/=
nvme/nvmeX/adaptive_poll_inflight_high
> +Date: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0July 2026
> +KernelVersion: =C2=A0 =C2=A0 =C2=A0 =C2=A07.3
> +Contact: =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux NVMe mailing list <linux-nvme@=
lists.infradead.org>
> +Description:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of ou=
tstanding commands at which an interrupt-driven
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI I/O queue wa=
kes its adaptive completion-drain thread. The value
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0must be greater =
than adaptive_poll_inflight_low and smaller than
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the queue depth.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The default valu=
e is 32.
> +
> +What: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/class/=
nvme/nvmeX/adaptive_poll_inflight_low
> +Date: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0July 2026
> +KernelVersion: =C2=A0 =C2=A0 =C2=A0 =C2=A07.3
> +Contact: =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux NVMe mailing list <linux-nvme@=
lists.infradead.org>
> +Description:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of ou=
tstanding commands below which an adaptive
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0completion-drain=
 thread starts counting empty-CQ checks. The
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thread returns t=
o interrupt-driven completion after three such
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checks in a row.=
 The counter is reset whenever the number of
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0outstanding comm=
ands reaches this value. The value must be nonzero
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and smaller than=
 adaptive_poll_inflight_high.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The default valu=
e is 3.
> +
> +What: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/class/=
nvme/nvmeX/adaptive_poll_interval_us
> +Date: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0July 2026
> +KernelVersion: =C2=A0 =C2=A0 =C2=A0 =C2=A07.3
> +Contact: =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux NVMe mailing list <linux-nvme@=
lists.infradead.org>
> +Description:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of mi=
croseconds that an adaptive completion-drain
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thread waits bef=
ore rechecking an empty CQ. The value must be
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nonzero.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The default valu=
e is 30.
> +
> +What: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/class/=
nvme/nvmeX/adaptive_poll_max_loops
> +Date: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0July 2026
> +KernelVersion: =C2=A0 =C2=A0 =C2=A0 =C2=A07.3
> +Contact: =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux NVMe mailing list <linux-nvme@=
lists.infradead.org>
> +Description:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The maximum numb=
er of iterations performed each time an adaptive
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0completion-drain=
 thread is woken. An iteration is counted whether
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0or not the CQ ha=
s pending completions. The value must be nonzero
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and is sampled w=
hen the thread starts, so a new value applies to
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subsequent threa=
d activations.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The thread may e=
xit earlier when the low-inflight condition is met.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The default valu=
e is 1000.
> +
> +What: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/module=
/nvme/parameters/use_adaptive_polling
> +Date: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0July 2026
> +KernelVersion: =C2=A0 =C2=A0 =C2=A0 =C2=A07.3
> +Contact: =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux NVMe mailing list <linux-nvme@=
lists.infradead.org>
> +Description:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Global module pa=
rameter for adaptive polling on PCI I/O queues.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set to Y when lo=
ading the module, or on the kernel command line when
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the driver is bu=
ilt in, to enable adaptive polling for all NVMe PCI
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0controllers. The=
 default is N and the value cannot be changed after
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the driver is lo=
aded.
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 69932d640b537..296eadaf43199 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/blkdev.h>
> =C2=A0#include <linux/blk-mq-dma.h>
> =C2=A0#include <linux/blk-integrity.h>
> +#include <linux/delay.h>
> =C2=A0#include <linux/dmi.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/interrupt.h>
> @@ -21,6 +22,7 @@
> =C2=A0#include <linux/nodemask.h>
> =C2=A0#include <linux/once.h>
> =C2=A0#include <linux/pci.h>
> +#include <linux/sched.h>
> =C2=A0#include <linux/suspend.h>
> =C2=A0#include <linux/t10-pi.h>
> =C2=A0#include <linux/types.h>
> @@ -82,6 +84,17 @@ struct quirk_entry {
> =C2=A0static int use_threaded_interrupts;
> =C2=A0module_param(use_threaded_interrupts, int, 0444);
> =C2=A0
> +static bool use_adaptive_polling;
> +module_param(use_adaptive_polling, bool, 0444);
> +MODULE_PARM_DESC(use_adaptive_polling,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "enable adaptiv=
e polling on busy interrupt-driven I/O queues");
> +
> +#define NVME_ADAPTIVE_POLL_INFLIGHT_HIGH_DEFAULT =C2=A0 =C2=A0 =C2=A0 =
=C2=A032
> +#define NVME_ADAPTIVE_POLL_INFLIGHT_LOW_DEFAULT =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03
> +#define NVME_ADAPTIVE_POLL_INTERVAL_US_DEFAULT =C2=A0 =C2=A0 =C2=A0 =C2=
=A030
> +#define NVME_ADAPTIVE_POLL_MAX_LOOPS_DEFAULT =C2=A0 =C2=A0 =C2=A0 =C2=A0=
1000
> +#define NVME_ADAPTIVE_POLL_LOW_INFLIGHT_CHECKS =C2=A0 =C2=A0 =C2=A0 =C2=
=A03
> +
> =C2=A0static bool use_cmb_sqes =3D true;
> =C2=A0module_param(use_cmb_sqes, bool, 0444);
> =C2=A0MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for =
I/O SQes");
> @@ -302,6 +315,11 @@ struct nvme_dev {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned io_queues[HCTX_MAX_TYPES];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int num_vecs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 q_depth;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int adaptive_poll_inflight_high;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int adaptive_poll_inflight_low;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int adaptive_poll_interval_us;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int adaptive_poll_max_loops;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex adaptive_poll_config_lock; /* s=
erializes watermark updates */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int io_sqes;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 db_stride;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *bar;
> @@ -386,6 +404,7 @@ struct nvme_queue {
> =C2=A0#define NVMEQ_SQ_CMB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01
> =C2=A0#define NVMEQ_DELETE_ERROR =C2=A0 =C2=A0 =C2=A0 =C2=A02
> =C2=A0#define NVMEQ_POLLED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A03
> +#define NVMEQ_ADAPTIVE_POLLING =C2=A0 =C2=A0 =C2=A0 =C2=A04
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 *dbbuf_sq_db;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 *dbbuf_cq_db;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 *dbbuf_sq_ei;
> @@ -1649,6 +1668,99 @@ static irqreturn_t nvme_irq_check(int irq, void *d=
ata)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
> =C2=A0}
> =C2=A0
> +/*
> + * PCI I/O queues have one SQ and one CQ of the same depth. =C2=A0last_s=
q_tail
> + * counts commands published to the controller while cq_head counts comm=
ands
> + * completed and consumed by the host, so their ring distance is the num=
ber
> + * of commands that can still produce completions.
> + */
> +static unsigned int nvme_adaptive_poll_inflight(struct nvme_queue *nvmeq=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int inflight =3D READ_ONCE(nvmeq->last_sq_ta=
il) -
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0READ_ONCE(nvmeq->cq_head);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (inflight < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inflight +=3D nv=
meq->q_depth;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return inflight;
> +}
> +
> +static void nvme_adaptive_mask_irq(struct nvme_queue *nvmeq, int irq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *dev =3D nvmeq->dev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D to_pci_dev(dev->dev=
);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdev->msi_enabled) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BIT(nvmeq=
->cq_vector), dev->bar + NVME_REG_INTMS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readl(dev->bar +=
 NVME_REG_INTMS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disable_irq_nosy=
nc(irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +}
> +
> +static void nvme_adaptive_unmask_irq(struct nvme_queue *nvmeq, int irq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *dev =3D nvmeq->dev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D to_pci_dev(dev->dev=
);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->fl=
ags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdev->msi_enabled) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BIT(nvmeq=
->cq_vector), dev->bar + NVME_REG_INTMC);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readl(dev->bar +=
 NVME_REG_INTMS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_irq(irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +}
> +
> +static irqreturn_t nvme_irq_adaptive_poll(int irq, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int max_loops =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0READ_ONCE(nvmeq-=
>dev->adaptive_poll_max_loops);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int low_inflight_checks =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0do {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_cqe_pen=
ding(nvmeq)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nvme_irq(irq, data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0low_inflight_checks =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cond_resched();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0continue;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_adaptiv=
e_poll_inflight(nvmeq) <
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RE=
AD_ONCE(nvmeq->dev->adaptive_poll_inflight_low)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (++low_inflight_checks >=3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_ADAPTIVE_POLL_LOW_INFLIGHT_CHECKS)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0low_inflight_checks =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsleep(READ_ONCE=
(nvmeq->dev->adaptive_poll_interval_us));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (--max_loops);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_unmask_irq(nvmeq, irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t nvme_irq_adaptive_check(int irq, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_queue *nvmeq =3D data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0irqreturn_t ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq-=
>flags))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDL=
ED;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D nvme_irq(irq, data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D IRQ_HANDLED)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvme_adaptive_poll_inflight(nvmeq) <
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0READ_ONCE(nvmeq->dev->adaptive=
_poll_inflight_high))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flag=
s);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_adaptive_mask_irq(nvmeq, irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_WAKE_THREAD;
> +}
> +
> =C2=A0/*
> =C2=A0 * Poll for completions for any interrupt driven queue
> =C2=A0 * Can be called from any context.
> @@ -2171,9 +2283,22 @@ static int queue_request_irq(struct nvme_queue *nv=
meq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D to_pci_dev(nvm=
eq->dev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nr =3D nvmeq->dev->ctrl.instance;
> =C2=A0
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * INTMS/INTMC mask MSI vectors and only cov=
er vectors 0-31. =C2=A0They must
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * not be accessed while MSI-X is enabled, s=
o mask MSI-X vectors through
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the PCI IRQ chip.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (use_threaded_interrupts) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pci_=
request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_irq, nvmeq, "nvme%dq%d", =
nr, nvmeq->qid);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (use_adaptive_polling && nvmeq->qi=
d &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq->dev->num_vecs > 1 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(pdev->msix_enabled ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdev->msi_enabled && nvmeq->=
cq_vector < 32))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pci_reque=
st_irq(pdev, nvmeq->cq_vector,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_irq_adaptive_check, nvme_irq_=
adaptive_poll,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmeq,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"nvme%dq%d", nr, nvmeq->qid);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pci_=
request_irq(pdev, nvmeq->cq_vector, nvme_irq,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, nvmeq, "nvme%dq%d", nr, =
nvmeq->qid);
> @@ -2808,6 +2933,134 @@ static ssize_t hmb_store(struct device *dev, stru=
ct device_attribute *attr,
> =C2=A0}
> =C2=A0static DEVICE_ATTR_RW(hmb);
> =C2=A0
> +static ssize_t adaptive_poll_inflight_high_show(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return sysfs_emit(buf, "%u\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0READ_ONCE(ndev->adaptive_poll_inflight_high));
> +}
> +
> +static ssize_t adaptive_poll_inflight_high_store(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, size_t count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int value;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kstrtouint(buf, 10, &value);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!value || value >=3D ndev->q_depth)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&ndev->adaptive_poll_config_lock)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value <=3D READ_ONCE(ndev->adaptive_poll=
_inflight_low)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&nd=
ev->adaptive_poll_config_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(ndev->adaptive_poll_inflight_high=
, value);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&ndev->adaptive_poll_config_loc=
k);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return count;
> +}
> +static DEVICE_ATTR_RW(adaptive_poll_inflight_high);
> +
> +static ssize_t adaptive_poll_inflight_low_show(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return sysfs_emit(buf, "%u\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0READ_ONCE(ndev->adaptive_poll_inflight_low));
> +}
> +
> +static ssize_t adaptive_poll_inflight_low_store(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const char *buf, size_t count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int value;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kstrtouint(buf, 10, &value);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!value || value >=3D ndev->q_depth)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&ndev->adaptive_poll_config_lock)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value >=3D READ_ONCE(ndev->adaptive_poll=
_inflight_high)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&nd=
ev->adaptive_poll_config_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(ndev->adaptive_poll_inflight_low,=
 value);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&ndev->adaptive_poll_config_loc=
k);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return count;
> +}
> +static DEVICE_ATTR_RW(adaptive_poll_inflight_low);
> +
> +static ssize_t adaptive_poll_interval_us_show(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return sysfs_emit(buf, "%u\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0READ_ONCE(ndev->adaptive_poll_interval_us));
> +}
> +
> +static ssize_t adaptive_poll_interval_us_store(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const char *buf, size_t count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int value;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kstrtouint(buf, 10, &value);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!value)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(ndev->adaptive_poll_interval_us, =
value);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return count;
> +}
> +static DEVICE_ATTR_RW(adaptive_poll_interval_us);
> +
> +static ssize_t adaptive_poll_max_loops_show(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return sysfs_emit(buf, "%u\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0READ_ONCE(ndev->adaptive_poll_max_loops));
> +}
> +
> +static ssize_t adaptive_poll_max_loops_store(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *buf, size_t count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_dev *ndev =3D to_nvme_dev(dev_ge=
t_drvdata(dev));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int value;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kstrtouint(buf, 10, &value);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!value)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(ndev->adaptive_poll_max_loops, va=
lue);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return count;
> +}
> +static DEVICE_ATTR_RW(adaptive_poll_max_loops);
> +
> =C2=A0static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct attr=
ibute *a, int n)
> =C2=A0{
> @@ -2832,6 +3085,10 @@ static struct attribute *nvme_pci_attrs[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_cmbloc.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_cmbsz.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_hmb.attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_adaptive_poll_inflight_high.attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_adaptive_poll_inflight_low.attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_adaptive_poll_interval_us.attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0&dev_attr_adaptive_poll_max_loops.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,
> =C2=A0};
> =C2=A0
> @@ -3685,6 +3942,15 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct =
pci_dev *pdev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_=
PTR(-ENOMEM);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_WORK(&dev->ctrl.reset_work, nvme_r=
eset_work);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&dev->shutdown_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&dev->adaptive_poll_config_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->adaptive_poll_inflight_high =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_ADAPTIVE_PO=
LL_INFLIGHT_HIGH_DEFAULT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->adaptive_poll_inflight_low =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_ADAPTIVE_PO=
LL_INFLIGHT_LOW_DEFAULT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->adaptive_poll_interval_us =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_ADAPTIVE_PO=
LL_INTERVAL_US_DEFAULT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->adaptive_poll_max_loops =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_ADAPTIVE_PO=
LL_MAX_LOOPS_DEFAULT;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->nr_write_queues =3D write_queues;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->nr_poll_queues =3D poll_queues;
> --=C2=A0
> 2.39.5 (Apple Git-154)
>=C2=A0

