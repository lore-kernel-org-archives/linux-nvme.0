Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE8C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:32:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA4320791
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="THMbDf1Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu3+CH2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA4320791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kQe08RuojLus89Mj/isBKz+CJsFACj2BoYMJ+FetE2g=; b=THMbDf1Q1j2+whWb3W0vj5+O2
	TrcVSwbuGsgwgZ490uaw8muD1E6JhNBMmmw+aMs+KKnh9E4Ofrwkf9UVtRzhOjAimEJYwJ08M+7ea
	B6dWP4ESM9SK78BtA462/QibwxZVahbS1Lf174C1qa+nWq3kEBSY8DCe0Z3bm8OLN34/e1UyyhelR
	ezwIXjonDfJ8QKzny04rblj837toBoAm65F7vlezyzIw6UWQDyUyAZn8TKkwKAPoXLhuLWYujlNOl
	5Tk46qtCqrvkzcx58NY6mtNA6aW/oHhPIJvEksJJB3lBlOoWSY9ueOutjver1F8MwLtwjGizpBOXg
	Dkk015fUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL7h4-0005jb-RS; Wed, 23 Sep 2020 16:32:34 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL7gz-0005gt-IR
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 16:32:32 +0000
Received: by mail-io1-xd42.google.com with SMTP id u6so72980iow.9
 for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2020 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P4lqhoUkOS59NYhfqRhwFab5bPQZ1v53iwU3OmTlSnk=;
 b=Hu3+CH2YxgVVQiEg3vMgVSjLOcq/iR8MjkEFcgkEHd7P76b6UWDvCbKNZmYgCZvRGL
 BuWSAsGLo6uJF4Ugqdd7kwSWNsssewtbELdnFGUn3eFMq4HATJGNUY7OqRzG0wqNoqLW
 Cmgxneh5OFo+cdw6nwki4etioGRW2x6fN9QQ2qwfI2uhuwQL/s8xkH5Pb8MzkfpP7AB8
 Xt7phU4X/LHQm4LzKIF7jdylhPvVQi4FdDwIzGU195UShz0qwboxcsqmkVY1WZWPdBZ+
 DE3abTQruqEm4/7sJYS2Sjn2zLgHkXgWqTU9N56pfCG5rQoGNEw2aiucSC/C9Ksc0aaf
 OrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P4lqhoUkOS59NYhfqRhwFab5bPQZ1v53iwU3OmTlSnk=;
 b=EojqEG0XvCOQXbes+uiOIs3jsGmj6RehIEZrCng+Gr/LwU6Idye6kE764iqUeM1Ew8
 UNhRduNEP9iJ/9h/AupGvy9E0HWh3VqKkYrbrkhm8MkqH/kV3HHZzuj0TzdJP2oIrCJs
 zeghinf2lK3RvktH39mPI8WaqWuIrMg2VniVihF6rxS96vmx6Lwnf52udk/06/89aAy/
 uKul5l50nXOquMocXNYTi9/kKsMTzgJhBXtJWdov106jPbQwv3PpzWncMbcSv63uldLI
 s2vYT4OzFOb77vsdjyKEuS7QbScvnUnFW8535IgyMj1xEw3x380DuiiOFw19IuJ4ogmb
 CtkQ==
X-Gm-Message-State: AOAM530/53tQyIseorn0SlWNFzl9buweRjjvo7iF9zcoXxyl4YVRtbeu
 l3V9lvI6BZjWtek0Z6I5CvKo/FyRUVLDu1V5PBo=
X-Google-Smtp-Source: ABdhPJzXbzlq/PesSeH1J0cQPjKXMG19t2h7SihViL9wxwJFuvducZMy9stuNJRXeBp6ChCJoFJWDdmF7c1cmdG0XRA=
X-Received: by 2002:a02:76d5:: with SMTP id z204mr169035jab.93.1600878745375; 
 Wed, 23 Sep 2020 09:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153605.5253-1-ztong0001@gmail.com>
 <20200922135956.GA23437@lst.de>
 <CAA5qM4BPKZaqH0SHS3zCO7oz=f3Ow_zB2fqtJYUrbbFBNbWsNQ@mail.gmail.com>
 <20200922164154.GA1894@lst.de>
 <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
 <20200923055725.GA15442@lst.de>
In-Reply-To: <20200923055725.GA15442@lst.de>
From: Tong Zhang <ztong0001@gmail.com>
Date: Wed, 23 Sep 2020 12:32:14 -0400
Message-ID: <CAA5qM4AA4dVJhOzjkbsYmTfyY9=dtBM47wRU_v5fZyVR3CHZSg@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_123229_659654_3328326A 
X-CRM114-Status: GOOD (  13.93  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

here you go

[    0.000000] Linux version 5.9.0-rc4+ (tong@tong-desktop) (gcc
(Ubuntu 9.3.0-10ubuntu2) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34)
#44 SMP Wed Sep 23 12:15:34 EDT 2020
[    0.000000] Command line: console=ttyS0 root=/dev/sda
earlyprintk=serial biosdevname=0 net.ifnames=0 loglevel=7
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffd6fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffd7000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3000.019 MHz processor
[    0.018848] last_pfn = 0x180000 max_arch_pfn = 0x400000000
[    0.020004] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.020455] last_pfn = 0x7ffd7 max_arch_pfn = 0x400000000
[    0.033611] found SMP MP-table at [mem 0x000f5a90-0x000f5a9f]
[    0.035100] check: Scanning 1 areas for low memory corruption
[    0.046212] ACPI: Early table checksum verification disabled
[    0.046681] ACPI: RSDP 0x00000000000F5850 000014 (v00 BOCHS )
[    0.047095] ACPI: RSDT 0x000000007FFE20C2 000038 (v01 BOCHS
BXPCRSDT 00000001 BXPC 00000001)
[    0.047953] ACPI: FACP 0x000000007FFE1EB2 0000F4 (v03 BOCHS
BXPCFACP 00000001 BXPC 00000001)
[    0.048792] ACPI: DSDT 0x000000007FFE0040 001E72 (v01 BOCHS
BXPCDSDT 00000001 BXPC 00000001)
[    0.049074] ACPI: FACS 0x000000007FFE0000 000040
[    0.049256] ACPI: APIC 0x000000007FFE1FA6 000080 (v01 BOCHS
BXPCAPIC 00000001 BXPC 00000001)
[    0.049501] ACPI: HPET 0x000000007FFE2026 000038 (v01 BOCHS
BXPCHPET 00000001 BXPC 00000001)
[    0.049724] ACPI: MCFG 0x000000007FFE205E 00003C (v01 BOCHS
BXPCMCFG 00000001 BXPC 00000001)
[    0.049892] ACPI: WAET 0x000000007FFE209A 000028 (v01 BOCHS
BXPCWAET 00000001 BXPC 00000001)
[    0.058109] No NUMA configuration found
[    0.058193] Faking a node at [mem 0x0000000000000000-0x000000017fffffff]
[    0.059024] NODE_DATA(0) allocated [mem 0x17fffa000-0x17fffdfff]
[    0.061178] Zone ranges:
[    0.061271]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.061393]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.061481]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
[    0.061571] Movable zone start for each node
[    0.061654] Early memory node ranges
[    0.061735]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.061939]   node   0: [mem 0x0000000000100000-0x000000007ffd6fff]
[    0.062056]   node   0: [mem 0x0000000100000000-0x000000017fffffff]
[    0.062963] Zeroed struct page in unavailable ranges: 139 pages
[    0.063146] Initmem setup node 0 [mem 0x0000000000001000-0x000000017fffffff]
[    0.701550] kasan: KernelAddressSanitizer initialized
[    0.702094] ACPI: PM-Timer IO Port: 0x608
[    0.702932] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.703636] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.704018] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.704487] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.704656] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.704900] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.705041] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.705464] Using ACPI (MADT) for SMP configuration information
[    0.705676] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.706244] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.707373] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.707547] PM: hibernation: Registered nosave memory: [mem
0x0009f000-0x0009ffff]
[    0.707729] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000effff]
[    0.707837] PM: hibernation: Registered nosave memory: [mem
0x000f0000-0x000fffff]
[    0.708039] PM: hibernation: Registered nosave memory: [mem
0x7ffd7000-0x7fffffff]
[    0.708162] PM: hibernation: Registered nosave memory: [mem
0x80000000-0xafffffff]
[    0.708345] PM: hibernation: Registered nosave memory: [mem
0xb0000000-0xbfffffff]
[    0.708439] PM: hibernation: Registered nosave memory: [mem
0xc0000000-0xfed1bfff]
[    0.708536] PM: hibernation: Registered nosave memory: [mem
0xfed1c000-0xfed1ffff]
[    0.708666] PM: hibernation: Registered nosave memory: [mem
0xfed20000-0xfffbffff]
[    0.708758] PM: hibernation: Registered nosave memory: [mem
0xfffc0000-0xffffffff]
[    0.708962] [mem 0xc0000000-0xfed1bfff] available for PCI devices
[    0.709470] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.803522] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64
nr_cpu_ids:2 nr_node_ids:1
[    0.805530] percpu: Embedded 60 pages/cpu s205720 r8192 d31848 u1048576
[    0.808361] Built 1 zonelists, mobility grouping on.  Total pages: 1032032
[    0.808462] Policy zone: Normal
[    0.808700] Kernel command line: console=ttyS0 root=/dev/sda
earlyprintk=serial biosdevname=0 net.ifnames=0 loglevel=7
[    0.812697] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.813462] Inode-cache hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.815216] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.271674] Memory: 3464648K/4193748K available (22532K kernel
code, 6139K rwdata, 6640K rodata, 1516K init, 10404K bss, 728844K
reserved, 0K cma-reserved)
[    1.279413] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    1.291083] rcu: Hierarchical RCU implementation.
[    1.291173] rcu: RCU event tracing is enabled.
[    1.291295] rcu: RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    1.291623] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    1.291799] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    1.327149] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    1.338865] random: get_random_bytes called from
start_kernel+0x1cf/0x37a with crng_init=0
[    1.344653] Console: colour VGA+ 80x25
[    1.346548] printk: console [ttyS0] enabled
[    1.346548] printk: console [ttyS0] enabled
[    1.347088] printk: bootconsole [earlyser0] disabled
[    1.347088] printk: bootconsole [earlyser0] disabled
[    1.348428] ACPI: Core revision 20200717
[    1.357694] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604467 ns
[    1.362207] APIC: Switch to symmetric I/O mode setup
[    1.371293] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.377155] tsc: Marking TSC unstable due to TSCs unsynchronized
[    1.377556] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6000.03 BogoMIPS (lpj=3000019)
[    1.378469] pid_max: default: 32768 minimum: 301
[    1.380491] LSM: Security Framework initializing
[    1.381841] SELinux:  Initializing.
[    1.384149] Mount-cache hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    1.384394] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
Poking KASLR using RDTSC...
[    1.419131] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    1.419247] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    1.419639] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    1.419916] Spectre V2 : Mitigation: Full AMD retpoline
[    1.420019] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    1.420241] Speculative Store Bypass: Vulnerable
[    1.425424] Freeing SMP alternatives memory: 40K
[    1.542125] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+
(family: 0x6, model: 0x6, stepping: 0x3)
[    1.551683] Performance Events: PMU not available due to
virtualization, using software events only.
[    1.554388] rcu: Hierarchical SRCU implementation.
[    1.562103] smp: Bringing up secondary CPUs ...
[    1.568823] x86: Booting SMP configuration:
[    1.568992] .... node  #0, CPUs:      #1
[    0.032775] smpboot: CPU 1 Converting physical 0 to logical die 1
[    1.651665] smp: Brought up 1 node, 2 CPUs
[    1.651809] smpboot: Max logical packages: 2
[    1.651991] smpboot: Total of 2 processors activated (12000.87 BogoMIPS)
[    1.674416] devtmpfs: initialized
[    1.711999] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.712326] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    1.719341] PM: RTC time: 16:16:07, date: 2020-09-23
[    1.728949] NET: Registered protocol family 16
[    1.742597] audit: initializing netlink subsys (disabled)
[    1.745132] audit: type=2000 audit(1600877767.378:1):
state=initialized audit_enabled=0 res=1
[    1.759312] thermal_sys: Registered thermal governor 'step_wise'
[    1.759394] thermal_sys: Registered thermal governor 'user_space'
[    1.763867] cpuidle: using governor menu
[    1.766834] ACPI: bus type PCI registered
[    1.773341] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xb0000000-0xbfffffff] (base 0xb0000000)
[    1.773756] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff] reserved in E820
[    1.774782] PCI: Using configuration type 1 for base access
[    1.782850] mtrr: your CPUs had inconsistent fixed MTRR settings
[    1.782958] mtrr: your CPUs had inconsistent variable MTRR settings
[    1.783074] mtrr: your CPUs had inconsistent MTRRdefType settings
[    1.783239] mtrr: probably your BIOS does not setup all CPUs.
[    1.783410] mtrr: corrected configuration.
[    2.176889] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.183579] cryptomgr_test (25) used greatest stack depth: 30520 bytes left
[    2.219797] ACPI: Added _OSI(Module Device)
[    2.219911] ACPI: Added _OSI(Processor Device)
[    2.220008] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.220088] ACPI: Added _OSI(Processor Aggregator Device)
[    2.220512] ACPI: Added _OSI(Linux-Dell-Video)
[    2.220837] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.221156] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    2.731984] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    2.836494] ACPI: Interpreter enabled
[    2.838956] ACPI: (supports S0 S3 S4 S5)
[    2.839080] ACPI: Using IOAPIC for interrupt routing
[    2.842794] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    2.867957] ACPI: Enabled 1 GPEs in block 00 to 3F
[    3.437031] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    3.438076] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    3.476399] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    3.512278] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
[    3.523269] PCI host bridge to bus 0000:00
[    3.523647] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    3.523959] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    3.524203] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    3.524586] pci_bus 0000:00: root bus resource [mem
0x80000000-0xafffffff window]
[    3.524959] pci_bus 0000:00: root bus resource [mem
0xc0000000-0xfebfffff window]
[    3.525429] pci_bus 0000:00: root bus resource [mem
0x180000000-0x97fffffff window]
[    3.525818] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.698109] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    3.717283] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    3.736258] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    3.754958] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    3.773476] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *10 11)
[    3.791995] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *10 11)
[    3.810534] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 10 *11)
[    3.829014] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10 *11)
[    3.833555] ACPI: PCI Interrupt Link [GSIA] (IRQs *16)
[    3.836669] ACPI: PCI Interrupt Link [GSIB] (IRQs *17)
[    3.839748] ACPI: PCI Interrupt Link [GSIC] (IRQs *18)
[    3.842872] ACPI: PCI Interrupt Link [GSID] (IRQs *19)
[    3.845839] ACPI: PCI Interrupt Link [GSIE] (IRQs *20)
[    3.848854] ACPI: PCI Interrupt Link [GSIF] (IRQs *21)
[    3.851898] ACPI: PCI Interrupt Link [GSIG] (IRQs *22)
[    3.854897] ACPI: PCI Interrupt Link [GSIH] (IRQs *23)
[    3.882897] iommu: Default domain type: Translated
[    3.888782] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    3.889047] pci 0000:00:01.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    3.889388] pci 0000:00:01.0: vgaarb: bridge control possible
[    3.889616] vgaarb: loaded
[    3.903519] SCSI subsystem initialized
[    3.909875] ACPI: bus type USB registered
[    3.912380] usbcore: registered new interface driver usbfs
[    3.913743] usbcore: registered new interface driver hub
[    3.914935] usbcore: registered new device driver usb
[    3.917480] pps_core: LinuxPPS API ver. 1 registered
[    3.917575] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    3.918217] PTP clock support registered
[    3.925205] Advanced Linux Sound Architecture Driver Initialized.
[    3.947695] NetLabel: Initializing
[    3.947781] NetLabel:  domain hash size = 128
[    3.947988] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    3.950552] NetLabel:  unlabeled traffic allowed by default
[    3.953389] PCI: Using ACPI for IRQ routing
[    3.960039] hpet: 3 channels of 0 reserved for per-cpu timers
[    3.960521] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    3.960716] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    3.966095] clocksource: Switched to clocksource hpet
[    7.088881] VFS: Disk quotas dquot_6.6.0
[    7.089663] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    7.096833] pnp: PnP ACPI init
[    7.181116] pnp: PnP ACPI: found 5 devices
[    7.378570] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    7.380592] NET: Registered protocol family 2
[    7.396198] tcp_listen_portaddr_hash hash table entries: 2048
(order: 3, 32768 bytes, linear)
[    7.397095] TCP established hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    7.399676] TCP bind hash table entries: 32768 (order: 7, 524288
bytes, linear)
[    7.401299] TCP: Hash tables configured (established 32768 bind 32768)
[    7.404132] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    7.404829] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    7.409931] NET: Registered protocol family 1
[    7.421356] RPC: Registered named UNIX socket transport module.
[    7.421593] RPC: Registered udp transport module.
[    7.421684] RPC: Registered tcp transport module.
[    7.421766] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    7.431009] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    7.431191] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    7.431324] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    7.431597] pci_bus 0000:00: resource 7 [mem 0x80000000-0xafffffff window]
[    7.431740] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff window]
[    7.431910] pci_bus 0000:00: resource 9 [mem 0x180000000-0x97fffffff window]
[    7.435141] pci 0000:00:01.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    7.435845] PCI: CLS 0 bytes, default 64
[    7.444128] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    7.444290] software IO TLB: mapped [mem 0x7bfd7000-0x7ffd7000] (64MB)
[    7.461798] check: Scanning for low memory corruption every 60 seconds
[    7.490019] Initialise system trusted keyrings
[    7.493165] workingset: timestamp_bits=56 max_order=20 bucket_order=0
[    7.866607] NFS: Registering the id_resolver key type
[    7.867330] Key type id_resolver registered
[    7.867656] Key type id_legacy registered
[    7.912645] Key type asymmetric registered
[    7.912865] Asymmetric key parser 'x509' registered
[    7.914010] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 251)
[    7.914396] io scheduler mq-deadline registered
[    7.914791] io scheduler kyber registered
[    7.938035] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    7.944873] ACPI: Power Button [PWRF]
[    7.959065] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.962682] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200)
is a 16550A
[    7.995795] Non-volatile memory driver v1.3
[    7.998278] Linux agpgart interface v0.103
[    8.216616] loop: module loaded
[    8.241363] nvme nvme0: pci function 0000:00:03.0
[    8.458066] PCI Interrupt Link [GSIH] enabled at IRQ 23
[    8.493743] PCI Interrupt Link [GSIA] enabled at IRQ 16
[    8.497349] nvme nvme0: 2/0/0 default/read/poll queues
[    8.504162] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5
Gbps 0x3f impl SATA mode
[    8.504417] ahci 0000:00:1f.2: flags: 64bit ncq only
[    8.576699] scsi host0: ahci
[    8.593871] scsi host1: ahci
[    8.606578] scsi host2: ahci
[    8.619111] scsi host3: ahci
[    8.631667] scsi host4: ahci
[    8.644451] scsi host5: ahci
[    8.652301] ata1: SATA max UDMA/133 abar m4096@0xfebd8000 port
0xfebd8100 irq 27
[    8.652628] ata2: SATA max UDMA/133 abar m4096@0xfebd8000 port
0xfebd8180 irq 27
[    8.652770] ata3: SATA max UDMA/133 abar m4096@0xfebd8000 port
0xfebd8200 irq 27
[    8.652903] ata4: SATA max UDMA/133 abar m4096@0xfebd8000 port
0xfebd8280 irq 27
[    8.653037] ata5: SATA max UDMA/133 abar m4096@0xfebd8000 port
0xfebd8300 irq 27
[    8.653199] ata6: SATA max UDMA/133 abar m4096@0xfebd8000 port
0xfebd8380 irq 27
[    8.672358] e100: Intel(R) PRO/100 Network Driver
[    8.672528] e100: Copyright(c) 1999-2006 Intel Corporation
[    8.673309] e1000: Intel(R) PRO/1000 Network Driver
[    8.673473] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    8.674784] e1000e: Intel(R) PRO/1000 Network Driver
[    8.674892] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    8.826920] PCI Interrupt Link [GSIG] enabled at IRQ 22
[    8.830832] e1000e 0000:00:02.0: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[    8.906026] e1000e 0000:00:02.0 0000:00:02.0 (uninitialized):
registered PHC clock
[    8.969184] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.978842] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.980179] e1000e 0000:00:02.0 eth0: (PCI Express:2.5GT/s:Width
x1) 52:54:00:12:34:56
[    8.980530] e1000e 0000:00:02.0 eth0: Intel(R) PRO/1000 Network Connection
[    8.980967] e1000e 0000:00:02.0 eth0: MAC: 3, PHY: 8, PBA No: 000000-000
[    8.981779] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    8.981996] ata1.00: 4194304 sectors, multi 16: LBA48 NCQ (depth 32)
[    8.982364] ata1.00: applying bridge limits
[    8.983792] sky2: driver version 1.30
[    8.984159] ata6: SATA link down (SStatus 0 SControl 300)
[    8.985481] ata2: SATA link down (SStatus 0 SControl 300)
[    8.985987] ata4: SATA link down (SStatus 0 SControl 300)
[    8.986325] ata5: SATA link down (SStatus 0 SControl 300)
[    8.987369] ata1.00: configured for UDMA/100
[    8.988066] ata3.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    8.988255] ata3.00: applying bridge limits
[    8.988748] ata3.00: configured for UDMA/100
[    8.994506] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    8.994677] ehci-pci: EHCI PCI platform driver
[    8.995685] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    8.995994] ohci-pci: OHCI PCI platform driver
[    8.996975] uhci_hcd: USB Universal Host Controller Interface driver
[    9.002390] usbcore: registered new interface driver usblp
[    9.003622] usbcore: registered new interface driver usb-storage
[    9.006195] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU]
at 0x60,0x64 irq 1,12
[    9.010743] serio: i8042 KBD port at 0x60,0x64 irq 1
[    9.011289] serio: i8042 AUX port at 0x60,0x64 irq 12
[    9.025246] rtc_cmos 00:04: RTC can wake from S4
[    9.028261] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
[    9.042597] rtc_cmos 00:04: registered as rtc0
[    9.046966] rtc_cmos 00:04: alarms up to one day, y3k, 242 bytes
nvram, hpet irqs
[    9.051147] random: fast init done
[    9.211116] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    9.216853] i2c i2c-0: 1/1 memory slots populated (from DMI)
[    9.217056] i2c i2c-0: Memory type 0x07 not supported yet, not
instantiating SPD
[    9.227115] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27)
initialised: dm-devel@redhat.com
[    9.229163] hid: raw HID events driver (C) Jiri Kosina
[    9.245742] usbcore: registered new interface driver usbhid
[    9.245876] usbhid: USB HID core driver
[    9.277372] Initializing XFRM netlink socket
[    9.293295] NET: Registered protocol family 10
[    9.318627] Segment Routing with IPv6
[    9.328766] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    9.343114] NET: Registered protocol family 17
[    9.344897] Key type dns_resolver registered
[    9.354149] IPI shorthand broadcast: enabled
[    9.359050] registered taskstats version 1
[    9.359145] Loading compiled-in X.509 certificates
[    9.419149] PM:   Magic number: 4:165:288
[    9.419587] tty tty21: hash matches
[    9.420116] printk: console [netcon0] enabled
[    9.420220] netconsole: network logging started
[    9.430080] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    9.448716] kworker/u4:8 (85) used greatest stack depth: 28816 bytes left
[    9.471279] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    9.475243] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    9.475614] input: ImExPS/2 Generic Explorer Mouse as
/devices/platform/i8042/serio1/input/input3
[    9.476017] cfg80211: failed to load regulatory.db
[    9.477338] Unstable clock detected, switching default tracing
clock to "global"
[    9.477338] If you want to keep using the local clock, then add:
[    9.477338]   "trace_clock=local"
[    9.477338] on the kernel command line
[    9.479940] ALSA device list:
[    9.480114]   No soundcards found.
[   38.716151] nvme nvme0: I/O 64 QID 2 timeout, aborting
[   68.919903] nvme nvme0: I/O 64 QID 2 timeout, reset controller
[   99.128324] nvme nvme0: I/O 14 QID 0 timeout, reset controller
[  129.475744] nvme nvme0: Abort status: 0x371
[  190.775780] nvme nvme0: I/O 13 QID 0 timeout, disable controller
[  190.916049] nvme nvme0: Identify Controller failed (-4)
[  190.916216] nvme nvme0: Removing after probe failure status: -5
[  190.922982] blk_update_request: I/O error, dev nvme0n1, sector 7 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  190.923335] Buffer I/O error on dev nvme0n1, logical block 7, async page read
[  190.923818] blk_update_request: I/O error, dev nvme0n1, sector 6 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  190.924027] Buffer I/O error on dev nvme0n1, logical block 6, async page read
[  190.924262] blk_update_request: I/O error, dev nvme0n1, sector 5 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  190.924817] Buffer I/O error on dev nvme0n1, logical block 5, async page read
[  190.925070] blk_update_request: I/O error, dev nvme0n1, sector 3 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  190.925243] Buffer I/O error on dev nvme0n1, logical block 3, async page read
[  190.925586] blk_update_request: I/O error, dev nvme0n1, sector 2 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  190.925776] Buffer I/O error on dev nvme0n1, logical block 2, async page read
[  190.926045] blk_update_request: I/O error, dev nvme0n1, sector 1 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  190.926261] Buffer I/O error on dev nvme0n1, logical block 1, async page read
[  190.926577] blk_update_request: I/O error, dev nvme0n1, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  190.926754] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  190.927963] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  190.928221] Buffer I/O error on dev nvme0n1, logical block 1, async page read
[  190.928584] Buffer I/O error on dev nvme0n1, logical block 2, async page read
[  190.929298]  nvme0n1: unable to read partition table
[  190.948008] ------------[ cut here ]------------
[  190.948178] WARNING: CPU: 1 PID: 56 at block/genhd.c:836
__device_add_disk+0x7d6/0x7f0
[  190.948325] Modules linked in:
[  190.948680] CPU: 1 PID: 56 Comm: kworker/u4:1 Not tainted 5.9.0-rc4+ #44
[  190.948808] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[  190.949150] Workqueue: nvme-wq nvme_scan_work
[  190.949312] RIP: 0010:__device_add_disk+0x7d6/0x7f0
[  190.949682] Code: 85 18 04 00 00 48 89 44 24 20 e9 07 fa ff ff 48
89 df e8 3d 82 cb ff 80 a5 cc 00 00 00 ef e9 4b fc ff ff 0f 0b e9 44
fc ff ff <0f> 0b e9 7c fc ff ff 0f 0b e9 7b fa ff ff 0f 0b e9 51 ff ff
ff e8
[  190.949968] RSP: 0018:ffff888158e779f0 EFLAGS: 00000202
[  190.950099] RAX: 00000000024640d2 RBX: ffff888158f2b598 RCX: ffffffffaaa4386d
[  190.950229] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff888158f2b5f0
[  190.950364] RBP: ffff88815880f000 R08: 0000000000000001 R09: ffffed102b1e56bf
[  190.950562] R10: ffff888158f2b5f7 R11: ffffed102b1e56be R12: ffff88815880f3d0
[  190.950694] R13: ffff88815880f090 R14: ffff88815880f3c0 R15: ffff888158f2b5f0
[  190.950872] FS:  0000000000000000(0000) GS:ffff88815b500000(0000)
knlGS:0000000000000000
[  190.951012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  190.951115] CR2: 0000000000000000 CR3: 000000006880e000 CR4: 00000000000006e0
[  190.951290] Call Trace:
[  190.951698]  ? blk_alloc_devt+0x140/0x140
[  190.951799]  ? __hrtimer_init+0x5f/0xf0
[  190.951889]  ? rwsem_down_read_slowpath+0x7d0/0x7d0
[  190.951990]  ? __nvme_revalidate_disk+0x244/0x480
[  190.952089]  nvme_validate_ns+0x771/0xe90
[  190.952210]  ? nvme_dev_ioctl+0x190/0x190
[  190.952297]  ? __blk_mq_free_request+0xe3/0x130
[  190.952377]  ? __nvme_submit_sync_cmd+0x153/0x300
[  190.952568]  ? kasan_unpoison_shadow+0x33/0x40
[  190.952662]  ? __kasan_kmalloc.constprop.0+0xc2/0xd0
[  190.952768]  nvme_scan_work+0x20f/0x35f
[  190.952863]  ? nvme_fw_act_work+0x210/0x210
[  190.952959]  ? sysvec_apic_timer_interrupt+0x2e/0x80
[  190.953059]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[  190.953168]  ? nvme_fw_act_work+0x210/0x210
[  190.953260]  ? process_one_work+0x461/0x7a0
[  190.953353]  process_one_work+0x46d/0x7a0
[  190.953543]  worker_thread+0x442/0x690
[  190.953709]  ? process_one_work+0x7a0/0x7a0
[  190.953799]  kthread+0x199/0x1f0
[  190.953883]  ? kthread_create_on_node+0xd0/0xd0
[  190.953979]  ret_from_fork+0x22/0x30
[  190.954106] ---[ end trace 5722e4830586b7ce ]---
[  190.994720] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK
  2.5+ PQ: 0 ANSI: 5
[  191.011641] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  191.012958] sd 0:0:0:0: [sda] 4194304 512-byte logical blocks:
(2.15 GB/2.00 GiB)
[  191.014160] sd 0:0:0:0: [sda] Write Protect is off
[  191.015722] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  191.019777] scsi 2:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM
  2.5+ PQ: 0 ANSI: 5
[  191.043867] sr 2:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[  191.044341] cdrom: Uniform CD-ROM driver Revision: 3.20
[  191.057775] sd 0:0:0:0: [sda] Attached SCSI disk
[  191.093652] sr 2:0:0:0: Attached scsi generic sg1 type 5
[  191.097114] md: Waiting for all devices to be available before autodetect
[  191.097243] md: If you don't use raid, use raid=noautodetect
[  191.097478] md: Autodetecting RAID arrays.
[  191.097595] md: autorun ...
[  191.097662] md: ... autorun DONE.
[  191.147528] EXT4-fs (sda): INFO: recovery required on readonly filesystem
[  191.147696] EXT4-fs (sda): write access will be enabled during recovery
[  191.566898] EXT4-fs (sda): recovery complete
[  191.582429] EXT4-fs (sda): mounted filesystem with ordered data
mode. Opts: (null)
[  191.585126] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.
[  191.597594] devtmpfs: mounted
[  191.657264] Freeing unused kernel image (initmem) memory: 1516K
[  191.657740] Write protecting the kernel read-only data: 32768k
[  191.665180] Freeing unused kernel image (text/rodata gap) memory: 2040K
[  191.669028] Freeing unused kernel image (rodata/data gap) memory: 1552K
[  191.669671] Run /bin/bash as init process



On Wed, Sep 23, 2020 at 1:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I suspect the patch below might be better.  Can you send me a full dmesg
> with this one applied?  Preferably on top of Jens' for-next branch?
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
