Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D0FC61DC2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Date:
	Mime-Version:From:Cc:To:Message-Id:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TmXm87OQBbGkUz+6YLozrl9zKyAMXSQ0sNJ4B8LqPUw=; b=nPq0rIWrlwqcbC
	uQZYXXIQmd9I2ZewxfJxFokeKWUIAOK1dt6frTBsX/Zlh1+o9ITQ7EJgl8GQFjiaNP7if0q3H23nh
	+Wid6mhLtFxsjD9ArJ7YSzqasHIjcbBneW+CNlWZuzrtdSN83EzZrA4M2nrzsX33254HNxMyzyqi9
	7X7GS/enDAN/fNJs9QedQM2DZAAg4SdjyJv+KPsYEYgTbHLhZ9Q2dnJv56AvT7oj+h0Hac7mrsMPt
	uylq1HTJ8Zj0TnoC6OJwYnAgSgq+I7lz5UR8ZoDUEFZSvY80H3xjJyOhCCav0OxisJHPSFD2C/Hyk
	/8tTxFhjT4C6TqNy3JAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz7T7-00000001yw4-3wHx;
	Wed, 26 Aug 2026 06:50:41 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz7T2-00000001yvU-2dPx
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 06:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787727027; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TmXm87OQBbGkUz+6YLozrl9zKyAMXSQ0sNJ4B8LqPUw=;
 b=WKTH5Q39wXiRQ11danMJRn4mTJoDV7DDYBvpCDsvnlfvX/jU/6I3fRAkRDe0g8Tlbz/02s
 mvrmPm5mKFRTrrRt05rL2VmiqDVp+gcE194SpBMfEy8QqaX2xtDfd14MXHXxv8Jf83f6eF
 fs00+P/Xev2NGLj9S67Z65txzNhwPRa1dtWslrf0k3gMhb76WEGunm4JQqGxMXsabPXhdD
 SB3CmSffKQ83Y9cF4/VGADFquz9NfeT6wvV2w3wFysKf7r6lXXSFZWSDcXBgCGrdPgkHMh
 G8R2idvx7x2JvWCB8S6z9I776W0dISjsX1ZmMxyHJI3JFhb3hcdFlcBvSPNInw==
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.a2ce1a72.aa19.493d.b705.fa725fca0a30@bytedance.com>
To: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<jun1.zeng@intel.com>, <anuj1072538@gmail.com>
Cc: <guzebing@bytedance.com>
From: "changfengnan" <changfengnan@bytedance.com>
Mime-Version: 1.0
Date: Wed, 26 Aug 2026 14:50:20 +0800
References: <20260826061546.56006-1-changfengnan@bytedance.com>
In-Reply-To: <20260826061546.56006-1-changfengnan@bytedance.com>
X-Lms-Return-Path: <lba+16a8e8caf+af213d+lists.infradead.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] nvme-pci: add adaptive interrupt polling
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_235037_088814_640679C0 
X-CRM114-Status: GOOD (  18.99  )
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

More test data is available here.
https://docs.google.com/spreadsheets/d/1rer4Nl5HHxSO-D3NrrHuHSfpR9s1kLhpLjz=
h7h7Mbmw/edit?gid=3D875909538#gid=3D875909538

We=E2=80=99ve added tests for some NVMe drives with very poor performance,=
=C2=A0
such as the HFS480GEJ8X176N (4k random write: 40k IOPS, 4k random
read: 700k IOPS) and the MZVL2480HBJD (4k random write: 20k IOPS,
4k random read: 130k IOPS).
We=E2=80=99ve also tested=C2=A0 performance on QLC.
There were a total of 3,280 test cases covering 13 different drive models.
Among these, 327 cases showed a steady improvement, with a maximum
improvement of 240% and a median of 29%.=C2=A0
Meanwhile, 15 cases showed a regression, with a maximum regression of
-11% and a median of -7.4%.
Almost none of the regressions can be reliably reproduced, but that
doesn=E2=80=99t mean they didn=E2=80=99t occur=E2=80=94when we ran the test=
s again, similar
regressions appeared in about 10 different cases.

Here is more data compare to GSIM:
https://docs.google.com/spreadsheets/d/14-_lLyPO_Uxm0ou7K-AcQ9qPCuWUZK0-n5J=
TgqvgZJc/edit?gid=3D875909538#gid=3D875909538


> From: "Fengnan Chang"<changfengnan@bytedance.com>
> Date:=C2=A0 Wed, Aug 26, 2026, 14:16
> Subject:=C2=A0 [PATCH v2 0/2] nvme-pci: add adaptive interrupt polling
> To: "Keith Busch"<kbusch@kernel.org>, "Jens Axboe"<axboe@kernel.dk>, "Chr=
istoph Hellwig"<hch@lst.de>, "Sagi Grimberg"<sagi@grimberg.me>, <linux-nvme=
@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <jun1.zeng@intel.com=
>, <anuj1072538@gmail.com>
> Cc: <guzebing@bytedance.com>, "Fengnan Chang"<changfengnan@bytedance.com>
> At high IOPS, interrupt handling can limit throughput, especially when
> multiple drives contend for CPU time.
>=C2=A0
> Add an opt-in adaptive policy for I/O queues that use a dedicated MSI-X
> vector and do not use threaded interrupts. Each queue independently
> switches between interrupt and poll mode based on its recent completion
> rate.
>=C2=A0
> In interrupt mode, wait for at least 8192 completions. If they arrive
> no more than 10 us apart on average, try polling. While polling, an
> hrtimer runs irq_poll to drain the completion queue. Before a window
> is full, polling may fall 20 us behind the interrupt-mode pace. After
> 8192 completions, polling must be strictly faster than interrupt mode.
>=C2=A0
> If a try fails, go back to interrupt mode and measure again. After
> three failures in a row, stay in interrupt mode for 64 windows of
> completions before measuring again. If polling works, keep it for at
> most 64 windows, then go back to interrupt mode and measure again.
>=C2=A0
> The module parameter is off by default and only sets the initial
> mode for new controllers. A per-controller sysfs file can change
> the mode later. The change freezes the namespace queues and waits
> for in-flight I/O to finish. Queues that use threaded, MSI, or
> legacy interrupts keep the regular interrupt handler.
>=C2=A0
> Measured with 4 KiB random reads on Solidigm SB5PH27X076T, adaptive
> polling on versus off:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QD32 =C2=A0 =C2=
=A0 =C2=A0QD64 =C2=A0 =C2=A0 =C2=A0QD128
> one device, one job =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -0.08% =C2=A0 =C2=A0+31.56% =C2=A0 +30.95%
> fifteen devices, eight jobs/device =C2=A0+188.03% =C2=A0+236.46% =C2=A0+2=
31.38%
>=C2=A0
> The fifteen-device aggregate with eight jobs per device increases
> from 13.48M / 13.47M / 13.47M IOPS to 38.83M / 45.31M / 44.64M IOPS.
>=C2=A0
> Changes since v1:
> - Split the nvme_poll_cq() return-count change into a separate prep patch
> =C2=A0 (patch 1/2) so the functional change stands on its own.
> - Factor out nvme_irq_complete_batch() so the regular and adaptive
> =C2=A0 interrupt handlers share one batch-completion path.
> - Only call irq_poll_complete() when completions < budget, matching the
> =C2=A0 irq_poll contract; the previous boundary case could return the pol=
l
> =C2=A0 object to the softirq list after it was already removed.
> - Clarify comments: document the NVMEQ_ADAPTIVE_* flags and the
> =C2=A0 dual-purpose retry_completions field, and reword the constant rati=
onale.
> - Minor style/indentation fixes per review.
>=C2=A0
>=C2=A0
> Fengnan Chang (2):
> =C2=A0 nvme-pci: return completion count from nvme_poll_cq
> =C2=A0 nvme-pci: add adaptive interrupt polling
>=C2=A0
> =C2=A0Documentation/ABI/testing/sysfs-nvme | =C2=A017 +
> =C2=A0drivers/nvme/host/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 1 +
> =C2=A0drivers/nvme/host/pci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 542 +++++++++++++++++++++++++--
> =C2=A03 files changed, 536 insertions(+), 24 deletions(-)
>=C2=A0
> --=C2=A0
> 2.39.5 (Apple Git-154)
>=C2=A0

