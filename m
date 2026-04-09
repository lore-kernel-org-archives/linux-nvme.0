Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7F3F31E22
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qNZu/WXUPhNb82Jv7JYsBguVQyhls8pb4s+wSnq+HH0=; b=a7MivvPcH+GmEs0q4xXi5cVzwf
	vs5tUZ23tKFe4bvR5pN7izVFOS6oNv0+pFrm7junvNUTWHPU8HuPZNs4x6UM8cFALdxp5ob+YTKIJ
	8/oCm1tQ+VAtt8T3x9H8aGdAiOBDAO7l6Mn1CHgmMK4kKwIqj+KTYNtu3WuTBwg9PJeg2CTQG+LnT
	qKb+dGsNa93Jji0wEjnDniakwPqbRrIGvyWaJkuG5ls8OJfOwbASCtRhIbPy9z35p3ylxRHL6Ip7a
	5x7jNNx94lNE2qAfxxu5cpIcO1SS2c2/sN4TA6NKMwzUyvpFr0I9MNd9X9p2XAuEqvv9INo3FDx6Y
	wOK7bG7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqkH-0000000Ak05-2M33;
	Thu, 09 Apr 2026 14:52:37 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqkE-0000000AjzU-3C0A
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 14:52:35 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso999490f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 09 Apr 2026 07:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775746352; cv=none;
        d=google.com; s=arc-20240605;
        b=RJMGNk44tyVV5x8ud0Unhd8FQvBYtqaYkgpBNGeQAfZw3Md14UYSXKBXg4WEzj0V2X
         T6VaBgcZEXwHk44IJvqCtltKO2ySLJGgTWDYtoKicopqHBMdYhI5CFpHiCwHhde9bAWQ
         lnIQBrfRIlbhfaCa6qPqdNGVOucwXuZTLngmpBggzrZZZyNjIGrHqDxU1Xg5KA82FtS6
         WIdlDfhbP0vfYkX/KIjACm0qGuDRKR1eUXthlavCgywXIySpR7RSKicsJJLMwjcyXXJe
         ZoEqfbJgY0a830pqTd5Q01tiTXmtyy8lFKu2dgmpbQle529HmgfnMcNGaac+jPr26NbU
         h4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qNZu/WXUPhNb82Jv7JYsBguVQyhls8pb4s+wSnq+HH0=;
        fh=6XFRCu8PjF51yZj6wPxSy4w94tjdPN62AMmNAmG4LnM=;
        b=KiKQ4RKtmNXep15IK53aNv7bUfTnNuxZIsSeAGpyU15KfgMKi6dGqAoW56/95D69qI
         CWxFFYwJdkzn6OTeyT7tr2aE2CusTWP5zxXv9Y8LSw0DDCfRdx6U5st/ssbmlVIXrB+Q
         mqSJpJV15kXczsxr3gty4ZTfCWvPbB1R3uPGfI0Kg44c1gl5xDfMh6MmeQv8iFouKkOn
         VXET3UxXU1uBS1EhOM/MqmiYihC8vbPXMLc6IvGr5sBDfNIkwOLguOLt5rAfdMEDhAUW
         Qcy8hkeY9LZ0x+E+HIg450EDnYSrrM6mloZcBOQRyx6x81DQfVDroLRp04jP208dcHCK
         j/QA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775746352; x=1776351152; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qNZu/WXUPhNb82Jv7JYsBguVQyhls8pb4s+wSnq+HH0=;
        b=G07FaCrngsAXEbZ144Jb7ohaAMsIibqvuv7t+26I1/ThLClSS8WAFjzXJxqpj/NhtE
         SbN1Dh+YVfkIzMNi7TX0nsCR69RdvqVJHfYh+cFG8OOtt3pw/CBbA9fUNwSrdGLpMDUm
         G9N1ivwNTSQrAeXvkLtYALWieUT1I3JNA6dqdrpyavhOqFsLA58ZV8sTVSCT8KBNVGgq
         Ma2Unt5umGg7cmzdyElyfvKtmvYvkWzdJ342xjzEDWxZ5zJCNqJnFxNvjLhogEoMrQ9w
         EZDrOlaOpI6zpKt/AD6cC/5eIU4Q//Wn6l1E/obP65tn+RJ+3LtF0txZLvmmf1nGHXcd
         mOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746352; x=1776351152;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNZu/WXUPhNb82Jv7JYsBguVQyhls8pb4s+wSnq+HH0=;
        b=kzYn08rWH4wm7bl3b+HPdYRyKyz2J7SqU+jkJEQEbmOoNdpru57jvPfQaUwJxVjqbC
         J37iAcTP1r5VDpbdV5sSni2UuM+wYNHJdiav2hhXGy5kXOSsmLO5wJfP7fj9Y6sLCOtu
         laXhoV1+FtmPqLU6TqiZviKy7FLFUOQxbd7wtgmvw9NEhzaNwpdtTJ0ltO5gioDaVSKD
         QQ0H494FwIsksmhpueqWKQi9N7NgKsLGvY4++XxzQdJmnI8Iu0hVH+UO/aGqjkWvyDYy
         8utyD1KDf++uO6B+2EjXHBkJHh2GGnjULuWSpAazMqkPRQUXC7J3hGkWaaQtQEk9W0WI
         jYZw==
X-Gm-Message-State: AOJu0Yy+6csg/XcMjA9Nq640uDX3zx+Yl+JRqF/7GQXhBBrRCXehHmsx
	CMTwXHfDnzWzTjtshoerLDCYYiEsIpZi4Utdq55AkD+x5U8/rtg0zYkmHfoJZy2FvHY7CC250PM
	R0crBT84dx0gWgS4tX1iWyZX6Sv3oyX1LqhGher0=
X-Gm-Gg: AeBDieuBca4DKjohVHeytvSfFJTsJwX5R4pu0iOjraP+Dxlg6qvf+ntfAo6cD7OBN1z
	C0kRcAvDP9VT76XhhzGs9nXFHrNKlv7LSFhV0tAyHyKNrUPSdEkJmafPupb6Eeyll3Fm9joGtHX
	RnVVNirvn81L5owVfP4pWpmFwnB7qkcL6WMkQRS8/sgzbtC1FttzpYInwsK0FXdcVtN2vWXvngX
	VOyckMkFPtVPif08Z+ng7txRx4k5H4xRExTEc5to0fFTkCj2UjLPkiojSRqAPWknvzhBmHfBPY7
	tr9eTJqU9VkEmPIrDVhQhxIOjEsCFMSXLi09mMIu4EZ+OcvYbQw0y1dUWaYWg/Rc2mnMM5MxcCI
	yo/H4FDk=
X-Received: by 2002:a05:6000:2886:b0:439:be67:a038 with SMTP id
 ffacd0b85a97d-43d5a17d094mr5680009f8f.41.1775746351772; Thu, 09 Apr 2026
 07:52:31 -0700 (PDT)
MIME-Version: 1.0
From: Jacopo Labardi <jacopolabardi@gmail.com>
Date: Thu, 9 Apr 2026 16:52:20 +0200
X-Gm-Features: AQROBzDpPEvaNlnVmlmhfvPxhs83kPXCAWpTOryoryMklVGb7FgCNhTSL7jhSmA
Message-ID: <CANrGBMBDftu58R71jvEcZ94D8vJB2Y_dHG=BbNSsNMOS=3k0+g@mail.gmail.com>
Subject: [BUG] Lenovo 83JL / WD SN7100S: intermittent loss of secondary NVMe
 after s2idle resume, root port 00:02.1 retraining fails
To: linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_075234_865778_04315535 
X-CRM114-Status: GOOD (  22.85  )
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

Hello,

I am reporting an intermittent suspend/resume failure on a Lenovo IdeaPad Pro 5
14AKP10 (machine type 83JL) where the secondary NVMe drive can become unusable
after s2idle resume on Linux.

I am CCing linux-nvme, linux-pci and linux-pm because the visible failure path
starts with PCIe root-port link retraining on 0000:00:02.1 during resume and
ends with nvme reset failure on the downstream device at 0000:bf:00.0.

Summary
- The problem is intermittent. It does not always happen on a fixed cycle.
- On this machine it may happen on the first resume or only after several
  suspend/resume cycles.
- The clean reproducer below failed on the third suspend/resume cycle, but that
  cycle count is not stable and should not be interpreted as deterministic.
- When it fails, the secondary/data NVMe is effectively lost until a full
  reboot.
- The system NVMe on 0000:c2:00.0 survives.

Hardware
- Laptop: Lenovo IdeaPad Pro 5 14AKP10 (83JL)
- BIOS: LENOVO QKCN29WW, release date 2025-12-23
- Platform: AMD Krackan / Ryzen AI 350
- Root port for failing device: 0000:00:02.1, AMD [1022:1126]
- System NVMe: Lexar NM790 2TB at 0000:c2:00.0
- Secondary/data NVMe: Sandisk/WD PC SN7100S M.2 2242 NVMe SSD (DRAM-less)
  [15b7:5044] at 0000:bf:00.0
- PCIe topology:
  0000:00:02.1 -> 0000:bf:00.0

Software
- Kernel for the clean reproducer: 6.19.11-arch1-1
- Kernel taint during reproducer: 0
- Sleep mode exposed by the platform on Linux: [s2idle]
- acpi_call-dkms is installed on disk, but the acpi_call module was not loaded
  during the reproducer and the kernel was not tainted
- Boot command line used for the clean reproducer:
  quiet nowatchdog rw rootflags=subvol=/@ rootfstype=btrfs
  root=UUID=<redacted> amd_pstate=active iommu=pt i8042.nopnp loglevel=3
  8250.nr_uarts=0 tpm_tis.interrupts=0 random.trust_cpu=on
  snd_hda_intel.power_save=10 snd_hda_intel.power_save_controller=Y

At boot on this kernel, both NVMe controllers log:
- nvme 0000:c2:00.0: platform quirk: setting simple suspend
- nvme 0000:bf:00.0: platform quirk: setting simple suspend

Clean reproduction used for this report
- No NVMe-specific udev overrides were active
- No custom NVMe-related systemd sleep hooks or suspend services were active
- No NVMe-specific kernel parameters were active

Reproducer
1. Boot the machine into 6.19.11-arch1-1.
2. Confirm tainted=0 and that both NVMe devices are present.
3. Suspend to s2idle and resume.
4. Repeat suspend/resume until the failure occurs.

Observed behavior
- In one clean run used for this report:
  - first cycle resumed successfully
  - second cycle resumed successfully
  - third cycle resumed with the WD drive lost
- In prior testing on the same machine, the failure sometimes happened on the
  first cycle and sometimes only after several cycles.

Relevant kernel log excerpt from the failing run
  Apr 09 16:24:34 kernel: PM: suspend entry (s2idle)
  Apr 09 16:24:54 kernel: pcieport 0000:00:02.1: broken device,
retraining non-functional downstream link at 2.5GT/s
  Apr 09 16:24:54 kernel: pcieport 0000:00:02.1: retraining failed
  Apr 09 16:24:54 kernel: pcieport 0000:00:02.1: Data Link Layer Link
Active not set in 100 msec
  Apr 09 16:24:54 kernel: nvme nvme1: Disabling device after reset failure: -19
  Apr 09 16:24:54 kernel: PM: suspend exit
  Apr 09 16:25:04 kernel: ntfs3(nvme1n1p5): failed to read volume at
offset 0x10c000
  Apr 09 16:25:26 kernel: ntfs3: 107 callbacks suppressed
  Apr 09 16:25:40 kernel: nvme nvme1: Identify namespace failed (-5)

State after the failure
- nvme list shows only the system Lexar drive; the WD is no longer listed
- lspci -nnvv -s bf:00.0 still shows the device, but with:
  - !!! Unknown header type 7f
  - Kernel driver in use: nvme
- sysfs state at collection time:
  - /sys/bus/pci/devices/0000:bf:00.0/power_state = D3cold
  - /sys/bus/pci/devices/0000:bf:00.0/power/runtime_status = active
  - /sys/bus/pci/devices/0000:bf:00.0/d3cold_allowed = 1
  - /sys/bus/pci/devices/0000:bf:00.0/power/control = on
  - /sys/bus/pci/devices/0000:00:02.1/power_state = D0
  - /sys/bus/pci/devices/0000:00:02.1/power/runtime_status = active
  - /sys/bus/pci/devices/0000:00:02.1/d3cold_allowed = 1
  - /sys/bus/pci/devices/0000:00:02.1/power/control = auto
- smartctl -x /dev/nvme1 failed with "Resource temporarily unavailable"

Expected behavior
- The secondary WD NVMe should resume normally and remain usable after s2idle.

Previous mitigation/debug attempts on the same machine
These are not part of the clean reproducer above; they are prior experiments
done to narrow the failure mode.

- The issue also reproduced while the machine was configured with
  pcie_aspm.policy=performance; removing that option did not eliminate it
- nvme_core.default_ps_max_latency_us=2000
  - no fix; failure still reproduced
- Force power/control=on and d3cold_allowed=0 on both 0000:00:02.1 and
  0000:bf:00.0
  - no fix; in failing runs the WD could still end up inaccessible / in D3cold
- pm_async=off
  - same failure mode
- SuspendState=freeze via systemd sleep configuration
  - ineffective on this platform; kernel still reported s2idle behavior and the
    issue remained
- nvme.noacpi=1
  - removed the "platform quirk: setting simple suspend" message, but resume
    often degraded into a black screen / forced reboot instead of fixing the WD
- pcie_port_pm=off
  - no usable fix; often resulted in black-screen resume / forced reboot
- pcie_ports=compat
  - no usable fix; often resulted in black-screen resume / forced reboot
- User-space suspend/resume hooks that tried unbind/bind/remove/rescan around
  the WD path
  - no reliable recovery; they only lengthened resume and still ended in reset
    failure / missing device

Additional context
- Linux on this machine exposes only s2idle.
- The issue was reproduced on multiple Linux distributions, not only one
  userspace/kernel packaging combination.
- Windows on the same hardware resumes correctly.
- I do not currently have a known-good Linux kernel version on this machine, so
  I am not claiming this is a regression in a specific upstream release.

I am not sure whether the underlying bug belongs primarily in nvme/pci, PCIe
power-management, or a platform/firmware interaction. The first failing
messages in the clean repro are from the root-port retraining path, which is
why I am CCing PCI/PM in addition to NVMe.

I collected a local bundle containing:
- full kernel log from the reproducer boot
- systemd suspend log
- lspci -nnvv for 0000:00:02.1 and 0000:bf:00.0
- sysfs power-state snapshots
- dmidecode output

The raw bundle contains machine serial/UUID, so I am not attaching it publicly
as-is. I can provide redacted logs or specific files immediately if requested.

If useful, I can also test additional debug options or a current mainline/-rc
kernel.

Thanks.

