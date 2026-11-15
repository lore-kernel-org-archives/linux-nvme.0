Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973F606A323
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y/iFoNTu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYdy6oX6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+cJpKZaKJYIoa7D/gp2rh2l3AKqTggTbPHMS342yxYM=; b=y/iFoNTukwadokiHwDTQcoSkr9
	2P0xQzXPItxh7ctLzcQvfNEXYV29gck5ykVHRe7+lmvGcLM7UKrOdBd452s5hwo5S2iJ7uuorhN/D
	489jdSCdc340V45RBs1LtYqAzfRA7LQyVKAf6pQosFUlSM35hmCLw6RrPHqFDKoa9RDAWGfzHlJu/
	wVJrrVUEXBLQXHMYBGtjzWiymnOV691WKKL6oTYIpSsqi6avA9/vHxmC4F+wYf6Ka11ePKNBDqZKG
	6RQtb+sbIsMmnbvQulXwy3HqGdwruimN+n4GF1OLXGGoXk0ASEAOtP2JpdaKILZeLgXOGPMobeSWy
	/O5dIqyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSQ9a-0000000H0ra-14rC;
	Sun, 15 Nov 2026 02:39:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSQ9Z-0000000H0rT-0D4Y
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 02:39:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 73D6240799;
	Sun, 15 Nov 2026 02:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6261F000C4;
	Sun, 15 Nov 2026 02:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794710376;
	bh=+cJpKZaKJYIoa7D/gp2rh2l3AKqTggTbPHMS342yxYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYdy6oX6PqWVbxhttTC5rzGo4UWHvFLSglLMSaiKB4sQ/W9huyKDY+BVnn7Q81R11
	 Ns6Y6YzFsZIIcS695GBdK5U1L/F9caFM3o8U+qLxEf41GckiKy0ugjg0ZiNv8I4PyU
	 g2q3SmxlO47rIBSJ74UCfVl6QYWDW5eBwMDCIEQG91j+sWHZI4US+jBVeItPPB+Q9H
	 wUyeEScIwEsiMR0L/Yg5lwC68OdinGQBjjdQEJ8O6qchMA5nO7XiIlqyu1X0aV4+P5
	 qnw93lJ7wm8Y6up+r2I7cEpYQMjz44MkoMqCQHWUSWR3IotjlcrV+lQ1BAtBPz/PSN
	 gWeAPGtvIsXVA==
Message-ID: <sashiko-outbox-215190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [bug report] nvme-pci: NVMe lost after S3 resume, CSTS reads
 all-ones for a few 100 ms
To: "Moritz Hiller" <m.hiller@pc-heini.de>
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
References: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 02:39:35 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] nvme-pci: missing Signed-off-by trailer and RFC email commit
  message
--

commit ba0016eb2b4fe54e7c1345a47b1af60d7461f91e
Author: Moritz Hiller <m.hiller@pc-heini.de>

> nvme-pci: NVMe lost after S3 resume, CSTS reads all-ones for a few 100 ms
>
> Hi,
>
> on my desktop the root NVMe drive sporadically does not come back after
> S3 resume (roughly 5-10% of resumes in automated runs):
>
>   nvme nvme0: Disabling device after reset failure: -19
>
> The single readl(CSTS) in nvme_pci_enable() returns all-ones about
> 200 ms after resume. The controller is not dead, it just needs a few
> hundred ms more. A small wait loop (diff below) fixes it here, tested
> on CachyOS kernels and on vanilla v7.4-rc2. I am not asking for the
> diff to be merged as is, I would like to know where this should be
> fixed properly.
>
> System:
> - ASUS ROG STRIX X570-F GAMING (BIOS 5044), Ryzen 7 5800X, S3 (deep)
> - Samsung 9100 PRO 2TB [144d:a810], FW 0B2QNXH7, at 0000:01:00.0,
>   directly behind root port 0000:00:01.1 [1022:1483]
>
> Observations:
> - pci_pm_resume_noirq takes ~0.3 ms for the SSD, config space answers.
> - At the failing CSTS read config space is intact, the link is up
>   (16 GT/s x4), the device is in D0, no AER errors:
>
>   vendor=3D144d cmd=3D0006 (saved 0002) bar0=3Dfcf00004 (saved fcf00004)
>   pmcsr=3D0008 lnksta=3D1044 rp_lnksta=3D3044
>
> - sysfs remove + rescan brings the drive back after ~3 s.
> - ASPM is off on this link, pcie_aspm=3Doff and
>   nvme_core.default_ps_max_latency_us=3D0 make no difference.
> - Unpatched, 2 of 15 and 2 of 24 cycles failed in automated runs
>   (90 s sleep, RTC wake). With the wait, no cycle failed (30/30 on
>   CachyOS, 15/15 on v7.4-rc2); the controller answered after
>   200-400 ms whenever the wait triggered.
>
> My reading: pci_power_up() finds PMCSR already in D0 and does not
> wait, and pci_bridge_wait_for_secondary_bus() only runs after D3cold
> and only checks config space. So nothing waits for MMIO to come back,
> and nvme_pci_enable() gives up on the first all-ones read.
>
> The diff polls CSTS every 100 ms for up to 10 s, only if
> NVME_CC_SHN_NORMAL is still set (the was_suspend test in
> nvme_reset_work()) and while pci_device_is_present(). Probe and
> runtime resets are unchanged. Known downsides:
> - The 10 s bound is arbitrary.
> - It also triggers on thaw/restore after hibernation (same bit set).
> - The wait sleeps with shutdown_lock held, as nvme_wait_ready() already
>   does in the same call chain.
> - A controller that answers config space but is really dead after
>   resume is declared dead 10 s later than today.
> - A wait that times out is not logged.
>
> Should this go into nvme-pci, the PCI core, or a quirk for this board
> or drive? I can provide lspci -vvv, full dmesg or test patches.
>
> The problem has existed on this machine for about a year, possibly
> also with the previous SSD in this slot. It was hard to pin down: when
> it happens the root filesystem is gone, so nothing gets written to
> disk. I only got the first log of a failure in August 2026 via
> netconsole, and every failure captured since then looks the same.
>
> Disclosure: I am not a kernel developer. Log analysis, code reading
> and the diff were done with an LLM assistant (Claude); I ran all tests
> on my hardware. I can send patch with Signed-off-by if useful.
>
> Thanks,
> Moritz Hiller
>
> ---8<--- proof of concept, against v7.3.4 ---8<---

[Severity: High]
This commit is missing a Signed-off-by trailer certifying the Developer
Certificate of Origin.  The commit message is also formatted as a mailing
list bug report and inquiry rather than a standard kernel commit changelog,
with conversational notes that should be moved below the "---" separator if
submitted as a patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/598ee2b4-32aa-4ad3-=
99c7-db7f9a7e7736@pc-heini.de?part=3D1

