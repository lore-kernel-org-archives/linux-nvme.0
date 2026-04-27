Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A245EFF8867
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3IMh9zc4XqQrfVWFOK5zzy46NlRww98MNLYe1Fx+BM=; b=J/9QA6qUau8/lxz/zLFNqMs1PP
	SvbSBGsLzZ+MyPRLPNZTKqo6M+BUZbBRQxlmO5Muc4A9IazkeWK3BnurrWl4L3vdzJA0cIG1sHq5I
	CnLY6iL0ELWTKETQKYHvTEbHUUGrnJULMopEKoEwC4IngO9AgAUHz03fpbJM5aNa3pfSjq5PvpHMD
	TXpcu62zNh+NJVIuLVn6kzGKWd4VJvVn8trMMiGq6ZxLeNYwO3DVdta9QilvUoaC1sgdJp7pxD8vD
	8UDMDOdCeBpsCJ2RT61spk/7DszwfQB96pNT4pmQX7DdJc7/pu2C6+ToYqWbzZ2s8zdQKERIyKURO
	2TOYHgyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHS80-0000000059K-2V2U;
	Mon, 27 Apr 2026 20:00:24 +0000
Received: from mta-64-226.siemens.flowmailer.net ([185.136.64.226])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHJce-0000000Gjlk-0Y7P
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 10:55:30 +0000
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026042710552172dd560c920002073a
        for <linux-nvme@lists.infradead.org>;
        Mon, 27 Apr 2026 12:55:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=P3IMh9zc4XqQrfVWFOK5zzy46NlRww98MNLYe1Fx+BM=;
 b=EUbVq5FNeThmPDQSfh8aKo91HZYE8p7RF4AdjrWartcxXiwJzqu/NIjalCA0+Rqsdawjc+
 aTYLS9cvzoSjt2zhTEZENSfHleFO1n5O/PBYA+jAhakrksykqURhoUDlei7lUTD6ZMlPEc+l
 VPBC3Gbf4V/4y7e8PttGnbhSmf6DHbzGmsjuqFx8J8DB8JqRytDpCUw8cfg93ZtAEwB3Pe5M
 4e7OeJ3gdMnAvzs+wXn7Veo9wXdjTkYCno7jME9wpzSomoGCs/Rebx2eTvLPuTO0Wa0vTfnC
 ZKnXlXn5chALN5siZht7ggRS0nBgpTzJK998EecC3RhiQ7E/tgRofaTA==;
Message-ID: <e350389a5a635660267a7a13f06529da102a95d8.camel@siemens.com>
Subject: Re: [PATCH v12 00/13] blk: honor isolcpus configuration
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, mst@redhat.com
Cc: aacraid@microsemi.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, liyihang9@h-partners.com,
 kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
 shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com,
 sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
 suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com,
 jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
 bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
 frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
 hare@suse.de, kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com,
 steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com,
 mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Date: Mon, 27 Apr 2026 12:55:20 +0200
In-Reply-To: <20260422185215.100929-1-atomlin@atomlin.com>
References: <20260422185215.100929-1-atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_035529_238597_1DDC46E6 
X-CRM114-Status: GOOD (  20.25  )
X-Mailman-Approved-At: Mon, 27 Apr 2026 13:00:22 -0700
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

Hi all,

On Wed, 2026-04-22 at 14:52 -0400, Aaron Tomlin wrote:
> Hi,
>=20
> I have decided to drive this series forward on behalf of Daniel Wagner, t=
he
> original author. The series has been rebased on v7.0-12635-g6596a02b2078.
>=20
> Building upon prior iterations, this series introduces critical
> architectural refinements to the mapping and affinity spreading algorithm=
s
> to guarantee thread safety and resilience against concurrent CPU-hotplug
> operations. Previously, the block layer relied on a shared global static
> mask (i.e., blk_hk_online_mask), which proved vulnerable to race conditio=
ns
> during rapid hotplug events. This vulnerability was highlighted by the
> kernel test robot, which encountered a NULL pointer dereference during
> rcutorture (cpuhotplug) stress testing due to concurrent mask modificatio=
n.
>=20
> To resolve this, the architecture has been fundamentally hardened. The
> global static state has been eradicated. Instead, the IRQ affinity core n=
ow
> employs a newly introduced irq_spread_hk_filter(), which safely intersect=
s
> the natively calculated affinity mask with the HK_TYPE_IO_QUEUE mask.
> Crucially, this is achieved using a local, hotplug-safe snapshot via
> data_race(cpu_online_mask). This approach circumvents the hotplug lock
> deadlocks previously identified by Thomas Gleixner, while explicitly
> avoiding CONFIG_CPUMASK_OFFSTACK stack bloat hazards on high-core-count
> systems. A robust fallback mechanism guarantees that should an interrupt
> vector be assigned exclusively to isolated cores, it is safely re-routed =
to
> the system's online housekeeping CPUs.
>=20
> Following rigorous testing of multiple queue maps (such as NVMe poll
> queues) alongside isolated CPUs, the tenth iteration resolved a critical
> page fault regression. The multi-queue mapping logic has been corrected t=
o
> strictly maintain absolute hardware queue indices, ensuring faultless que=
ue
> initialisation and preventing out-of-bounds memory access.
>=20
> Furthermore, following feedback from Ming Lei, the administrative
> documentation for isolcpus=3Dio_queue has undergone a comprehensive overh=
aul
> to reflect this architectural reality. Previous iterations lacked the
> required technical precision regarding subsystem impact. The expanded
> kernel-parameters.txt now explicitly details that this parameter applies
> strictly to managed IRQs. It thoroughly documents how the block layer
> intercepts multiqueue allocation to match the housekeeping mask, actively
> preventing MSI-X vector exhaustion on massive topologies and forcing queu=
e
> sharing. Most importantly, it cements the structural guarantee: while an
> application on an isolated CPU may freely submit I/O, the hardware
> completion interrupt is strictly and safely offloaded to a housekeeping
> core.
>=20
> Please let me know your thoughts.

This topic reminds me of a discussion started by Tobias [1] some time
ago about IRQ spreading of network drivers. The problem was (and still
is) that network drivers ignore any CPU isolation when spreading out
device IRQs.

In general we have two different CPU isolation mechanisms:
  - The static one, via isolcpus=3D cmdline parameter
  - The dynamic one, via cgroups(v2) cpuset controller

This series is only taking the static "world" into account, right? Are
there any plans to honor the CPU isolations configured the dynamic way?

It has been a while since the last investigations on my end. Last time I
went through the code, the IRQ core was completely decoupled from the
dynamic configuration via cgroups. Are there any plans to fix that gap?

Best regards,
Florian

[1] https://lore.kernel.org/all/a0cad8314124ca98d7c6763e3e08d7192598cf92.ca=
mel@siemens.com/

