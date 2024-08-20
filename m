Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2098EC531DC
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Aug 2024 19:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7ZtJU9v9clVPCGnO5BfMBz2XnTJWrdUcX69A78iwJbo=; b=JW2K7Da6R08ibTOckUhY8i/mNf
	SbqcFmWm5uvOEAAoPvjblnqMZOMxQTirL68i/RyagNgQkZFC5CDtS6VOdkMrjUHoag0aYxEQq7PS9
	EKRERBef3HOdKDR+7aMkbJJmkXs5/jkxXzQ/aZThYrhw7jbf5SWWrYSkO1oD/d+40IScDkvyTaBim
	8HRIP9JudQWpeLt1rl2uC/90g7N2rgqalvzExu6obcgEqu5rk5jGC48Na7E9djSQqaSjsk0WpVT3e
	iSxzY0rICKWegmKGsRrrO1HeVYyAszeZy9i3zGfusBpaYJY2WY/JAEZodQx20Zvq/MQExENUMAM5h
	23yY1Fug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgUyF-00000006WOg-0kz4;
	Tue, 20 Aug 2024 19:56:47 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgUyB-00000006WNW-4Bnw
	for linux-nvme@lists.infradead.org;
	Tue, 20 Aug 2024 19:56:45 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso1708820a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Aug 2024 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yawk.at; s=google; t=1724183801; x=1724788601; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZtJU9v9clVPCGnO5BfMBz2XnTJWrdUcX69A78iwJbo=;
        b=aOHImAk3DjHL0KjemHjcvOpsJ7Hr8Jwp8OfnXrdjNvrzDI1UaCWnHBcxosmUeSYPsw
         ZIlPdv3rSC1fMyZ7l8ljn7tAnlNy1NAUjUuAWtKzZY7HHUkkG/wWYpLuP9IXxVGFktK5
         2piMRk7XIunWw7n4fCZ/19XPPKeuoZ+5jdlVL1T/J7HG+NFINsXEXJOx9LlyhkgVIBH3
         cBjwqyqYmxqfE5Okf+Ek9TkCr+54ic9Nvy/XD2GCqw2E+T8M7rS591Ii0hUbWa+sEmnv
         V4f5NQK8ye5FskYoZhVPLP5UA/wah6c3+VdqVLQXGtAhxf1KMEo57edyCKgLIOIdxqm5
         SuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724183801; x=1724788601;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ZtJU9v9clVPCGnO5BfMBz2XnTJWrdUcX69A78iwJbo=;
        b=tHi+b3Ql3aHn3lvcKtDlXwIDJ23UU7huIvrXgYMGWjh27h6dVTD2v4yqAwsmVFc72X
         +a31lENl2wnguPUbw+jZxdXERBW9m2RDITB7eTj8MVOqqWxK9BiGeLfoDBpuV3IT3AD0
         6fLutRSCL0sHpLDN5Kw/ihMVzQuijItx9MZKSYKHgMAwoPHlIchVjnGRHlw8SmBWj5KF
         UpGrNZbaElGQCOQq82MAnrSXmw5EbZC8AnOLDeMaHmeLzj4D6OCPSFr19fOfneZEdoLL
         bYKrERjxxqOEjH6/hf9gjU1C9RuKkn/gLY3pcUqoLKyFOO/jfAqhjIwikKiYOF5Pbi8B
         h3pA==
X-Gm-Message-State: AOJu0YyAYvhQwpDYG+HnaL/r+hL7kTzt98z2kQQV6VyVe+z9uEBhbCOQ
	I9FGsbQP5tT+cyvcxZsmKxwGlJoaVuUT+KAaG0tH4mxMrAIjJVVoP+vaOsQjV1/MOddST6MnAa5
	e
X-Google-Smtp-Source: AGHT+IHFxXkllrjanau1sWD5XyPhTQmqK00H2CZ5aW/VytQEfHbArJWgPk9ETifS/n43JCki3oAx6A==
X-Received: by 2002:a50:c8cb:0:b0:5a0:e303:8f0f with SMTP id 4fb4d7f45d1cf-5beca528f1emr11956166a12.10.1724183801282;
        Tue, 20 Aug 2024 12:56:41 -0700 (PDT)
Received: from ?IPV6:2a02:8109:833c:e300:f556:5d1c:aa18:d31a? ([2a02:8109:833c:e300:f556:5d1c:aa18:d31a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f17bsm7267927a12.59.2024.08.20.12.56.40
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 12:56:40 -0700 (PDT)
Message-ID: <364590b3-c3d1-49d6-be6f-d36c1a1412d8@yawk.at>
Date: Tue, 20 Aug 2024 21:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nvme@lists.infradead.org
From: Jonas Konrad <me@yawk.at>
Subject: Occasional kernel error with NVMe-oF TCP target
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_125644_087784_B49F0889 
X-CRM114-Status: GOOD (  17.62  )
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

Hi,

I am using the NVMe-oF between two arch linux machines. The host uses 
NVMe-oF both for the rootfs device and for some other block devices. 
(I've written up my setup here if it's relevant, but I assume it's 
fairly standard: https://wiki.archlinux.org/title/NVMe-oF )

Unfortunately, sometimes the controller kernel errors when the host 
tries to connect. I first saw this with a kernel I hadn't updated in a 
while (6.1.20-1-lts), so I upgraded the kernel, but I just saw the same 
error with 6.6.46-1-lts. The dmesg output is as follows:

```
[436736.010136] nvmet: creating nvm controller 1 for subsystem 
nqn.2024-08.at.yawk.local:goliath.disk.kittyhawk-root for NQN 
nqn.2024-08.at.yawk.local:kittyhawk with DH-HMAC-CHAP.
[436736.043084] kworker/5:2H: page allocation failure: order:6, 
mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), 
nodemask=(null),cpuset=/,mems_allowed=0
[436736.043110] CPU: 5 PID: 1839528 Comm: kworker/5:2H Tainted: P 
    OE      6.6.46-1-lts #1 180e79e37528e3108a25b78d18bc12bb7965e9b7
[436736.043119] Hardware name: Supermicro Super Server/H12SSL-i, BIOS 
2.9 05/28/2024
[436736.043123] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
[436736.043143] Call Trace:
[436736.043148]  <TASK>
[436736.043154]  dump_stack_lvl+0x4d/0x70
[436736.043166]  warn_alloc+0x165/0x1e0
[436736.043178]  ? __alloc_pages_direct_compact+0x163/0x360
[436736.043190]  __alloc_pages_slowpath.constprop.0+0xce9/0xde0
[436736.043209]  __alloc_pages+0x320/0x340
[436736.043220]  ? nvmet_tcp_install_queue+0x50/0x120 [nvmet_tcp 
91952f482d713b3fd129c99b9957d5793eadc314]
[436736.043233]  __kmalloc_large_node+0x71/0x130
[436736.043243]  __kmalloc+0xc4/0x130
[436736.043252]  nvmet_tcp_install_queue+0x50/0x120 [nvmet_tcp 
91952f482d713b3fd129c99b9957d5793eadc314]
[436736.043269]  nvmet_install_queue+0xa6/0x1f0 [nvmet 
5fe872c93c4026caefed7012fa67b73b163ad62e]
[436736.043299]  nvmet_execute_io_connect+0xd1/0x1a0 [nvmet 
5fe872c93c4026caefed7012fa67b73b163ad62e]
[436736.043325]  nvmet_tcp_io_work+0x811/0x880 [nvmet_tcp 
91952f482d713b3fd129c99b9957d5793eadc314]
[436736.043340]  ? blk_queue_exit+0x12/0x50
[436736.043347]  ? srso_return_thunk+0x5/0x5f
[436736.043355]  ? blk_mq_timeout_work+0xa9/0x1b0
[436736.043365]  process_one_work+0x180/0x350
[436736.043376]  worker_thread+0x315/0x450
[436736.043385]  ? __pfx_worker_thread+0x10/0x10
[436736.043390]  kthread+0xe8/0x120
[436736.043398]  ? __pfx_kthread+0x10/0x10
[436736.043406]  ret_from_fork+0x34/0x50
[436736.043414]  ? __pfx_kthread+0x10/0x10
[436736.043421]  ret_from_fork_asm+0x1b/0x30
[436736.043437]  </TASK>
[436736.043440] Mem-Info:
[436736.043445] active_anon:5366856 inactive_anon:18076410 isolated_anon:0
                  active_file:1798 inactive_file:179395 isolated_file:0
                  unevictable:768 dirty:16 writeback:0
                  slab_reclaimable:128622 slab_unreclaimable:1240236
                  mapped:1509476 shmem:11978878 pagetables:27825
                  sec_pagetables:23609 bounce:0
                  kernel_misc_reclaimable:0
                  free:8060489 free_pcp:174 free_cma:0
[436736.043459] Node 0 active_anon:21467424kB inactive_anon:72305640kB 
active_file:7192kB inactive_file:717580kB unevictable:3072kB 
isolated(anon):0kB isolated(file):0kB mapped:6037904kB dirty:64kB 
writeback:0kB shmem:47915512kB shmem_thp:0kB shmem_pmdmapped:0kB 
anon_thp:3645440kB writeback_tmp:0kB kernel_stack:11728kB 
pagetables:111300kB sec_pagetables:94436kB all_unreclaimable? no
[436736.043472] Node 0 DMA free:11264kB boost:0kB min:4kB low:16kB 
high:28kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB 
local_pcp:0kB free_cma:0kB
[436736.043486] lowmem_reserve[]: 0 2592 193056 193056 193056
[436736.043500] Node 0 DMA32 free:763568kB boost:0kB min:904kB 
low:3556kB high:6208kB reserved_highatomic:28672KB active_anon:235464kB 
inactive_anon:424256kB active_file:0kB inactive_file:0kB unevictable:0kB 
writepending:0kB present:2737240kB managed:2668584kB mlocked:0kB 
bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[436736.043513] lowmem_reserve[]: 0 0 190463 190463 190463
[436736.043527] Node 0 Normal free:31467124kB boost:0kB min:66668kB 
low:261700kB high:456732kB reserved_highatomic:2048KB 
active_anon:21231960kB inactive_anon:71881384kB active_file:7192kB 
inactive_file:717664kB unevictable:3072kB writepending:64kB 
present:198429696kB managed:195041640kB mlocked:0kB bounce:0kB 
free_pcp:696kB local_pcp:0kB free_cma:0kB
[436736.043541] lowmem_reserve[]: 0 0 0 0 0
[436736.043553] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 
0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB (M) = 11264kB
[436736.043593] Node 0 DMA32: 1984*4kB (UME) 3510*8kB (UME) 3480*16kB 
(UME) 1842*32kB (UME) 1233*64kB (UME) 84*128kB (UME) 388*256kB (UME) 
524*512kB (UME) 110*1024kB (UME) 17*2048kB (UME) 2*4096kB (ME) = 763568kB
[436736.043646] Node 0 Normal: 277849*4kB (UME) 599680*8kB (UME) 
861628*16kB (UME) 313346*32kB (UME) 27161*64kB (UME) 33*128kB (U) 
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 31464484kB
[436736.043691] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=1048576kB
[436736.043696] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=2048kB
[436736.043700] 12160071 total pagecache pages
[436736.043702] 0 pages in swap cache
[436736.043705] Free swap  = 0kB
[436736.043708] Total swap = 0kB
[436736.043711] 50295733 pages RAM
[436736.043713] 0 pages HighMem/MovableOnly
[436736.043715] 864337 pages reserved
[436736.043718] 0 pages cma reserved
[436736.043720] 0 pages hwpoisoned
[436736.043723] nvmet: failed to install queue 1 cntlid 1 ret 6
[436736.062353] BUG: kernel NULL pointer dereference, address: 
0000000000000008
[436736.063442] #PF: supervisor read access in kernel mode
[436736.064319] #PF: error_code(0x0000) - not-present page
[436736.065199] PGD 0 P4D 0
[436736.066042] Oops: 0000 [#1] PREEMPT SMP NOPTI
[436736.066877] CPU: 5 PID: 1896226 Comm: kworker/5:1 Tainted: P 
   OE      6.6.46-1-lts #1 180e79e37528e3108a25b78d18bc12bb7965e9b7
[436736.068542] Hardware name: Supermicro Super Server/H12SSL-i, BIOS 
2.9 05/28/2024
[436736.069378] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
[436736.070221] RIP: 0010:nvmet_tcp_release_queue_work+0x102/0x3d0 
[nvmet_tcp]
[436736.071075] Code: 89 f7 e8 c1 ee 2f d8 48 8b 85 f8 fd ff ff 8b 8d 00 
fe ff ff c7 85 48 fe ff ff 03 00 00 00 48 8d 58 08 85 c9 0f 84 08 02 00 
00 <48> 8b 13 0f b6 02 3c 7f 0f 84 f1 01 00 00 a8 01 74 22 8b 83 e0 01
[436736.072762] RSP: 0018:ffffc90036cafe40 EFLAGS: 00010206
[436736.073746] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 
0000000000000100
[436736.074755] RDX: 0000000000000000 RSI: ffff888100401240 RDI: 
ffff8881161f3480
[436736.075577] RBP: ffff88816fb2c330 R08: ffff8881004012c0 R09: 
ffffffff9b850b80
[436736.076388] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff88816fb2c000
[436736.077194] R13: 0000000000000000 R14: ffff88816fb2c010 R15: 
ffff88816fb2c338
[436736.077997] FS:  0000000000000000(0000) GS:ffff88af8ef40000(0000) 
knlGS:0000000000000000
[436736.078786] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[436736.079569] CR2: 0000000000000008 CR3: 0000000161f04000 CR4: 
0000000000350ee0
[436736.080345] Call Trace:
[436736.081126]  <TASK>
[436736.081792]  ? __die+0x23/0x70
[436736.082548]  ? page_fault_oops+0x174/0x530
[436736.083274]  ? srso_return_thunk+0x5/0x5f
[436736.084016]  ? update_load_avg+0x7e/0x760
[436736.084675]  ? exc_page_fault+0x7f/0x180
[436736.085402]  ? asm_exc_page_fault+0x26/0x30
[436736.086124]  ? nvmet_tcp_release_queue_work+0x102/0x3d0 [nvmet_tcp 
91952f482d713b3fd129c99b9957d5793eadc314]
[436736.086822]  process_one_work+0x180/0x350
[436736.087505]  worker_thread+0x315/0x450
[436736.088171]  ? __pfx_worker_thread+0x10/0x10
[436736.088827]  kthread+0xe8/0x120
[436736.089452]  ? __pfx_kthread+0x10/0x10
[436736.090063]  ret_from_fork+0x34/0x50
[436736.090704]  ? __pfx_kthread+0x10/0x10
[436736.091311]  ret_from_fork_asm+0x1b/0x30
[436736.091932]  </TASK>
[436736.092473] Modules linked in: crypto_null nvmet_tcp nvmet veth 
vhost_net vhost vhost_iotlb tap 8021q garp mrp wireguard 
curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64 
libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel tun bridge stp 
llc cfg80211 rfkill nft_masq nft_chain_nat nf_nat nft_limit 
nf_log_syslog nft_log nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
nf_tables libcrc32c crc32c_generic rpcrdma sunrpc rdma_ucm ib_iser 
libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm iw_cm ib_cm 
mlx4_ib ib_uverbs ib_core mlx4_en vfat fat intel_rapl_msr 
intel_rapl_common amd64_edac edac_mce_amd kvm_amd r820t kvm raid1 
irqbypass md_mod ipmi_ssif rtl2832 i2c_mux dvb_usb_rtl28xxu dvb_usb_v2 
crct10dif_pclmul crc32_pclmul dvb_core crc32c_intel videobuf2_vmalloc 
videobuf2_memops videobuf2_common polyval_clmulni mc polyval_generic 
gf128mul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 
aesni_intel tg3 crypto_simd ast cryptd rndis_host cdc_ether usbnet 
libphy mii mousedev acpi_ipmi ccp
[436736.092621]  acpi_cpufreq joydev ptdma rapl mlx4_core pcspkr cp210x 
i2c_algo_bit ipmi_si sp5100_tco ipmi_devintf ipmi_msghandler i2c_piix4 
k10temp mac_hid sg fuse dm_mod loop nfnetlink bpf_preload ip_tables 
x_tables uas usbhid usb_storage zfs(POE) spl(OE) mpt3sas nvme raid_class 
xhci_pci nvme_core scsi_transport_sas xhci_pci_renesas nvme_common
[436736.099873] CR2: 0000000000000008
[436736.100500] ---[ end trace 0000000000000000 ]---
[436736.200157] RIP: 0010:nvmet_tcp_release_queue_work+0x102/0x3d0 
[nvmet_tcp]
[436736.200895] Code: 89 f7 e8 c1 ee 2f d8 48 8b 85 f8 fd ff ff 8b 8d 00 
fe ff ff c7 85 48 fe ff ff 03 00 00 00 48 8d 58 08 85 c9 0f 84 08 02 00 
00 <48> 8b 13 0f b6 02 3c 7f 0f 84 f1 01 00 00 a8 01 74 22 8b 83 e0 01
[436736.202167] RSP: 0018:ffffc90036cafe40 EFLAGS: 00010206
[436736.202807] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 
0000000000000100
[436736.203440] RDX: 0000000000000000 RSI: ffff888100401240 RDI: 
ffff8881161f3480
[436736.204061] RBP: ffff88816fb2c330 R08: ffff8881004012c0 R09: 
ffffffff9b850b80
[436736.204669] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff88816fb2c000
[436736.205280] R13: 0000000000000000 R14: ffff88816fb2c010 R15: 
ffff88816fb2c338
[436736.205892] FS:  0000000000000000(0000) GS:ffff88af8ef40000(0000) 
knlGS:0000000000000000
[436736.206501] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[436736.207089] CR2: 0000000000000008 CR3: 0000000161f04000 CR4: 
0000000000350ee0
```

The effect of this error is that the nvme target becomes unresponsive 
until reboot, so this is quite severe.

Unfortunately I have some constraints in getting more info on this. I 
can't upgrade to a non-lts kernel on this controller. I could run a 
newer kernel in a VM if necessary and let that VM act as the controller, 
but I'd like to avoid that option if possible, especially since this 
error may take a few days to happen again. Since it's a memory error it 
may also be quite sensitive to the system memory layout.

Is the stack trace enough to go on? Is this already fixed in a newer 
kernel? Do you need me to gather more information?

Thanks,
- Jonas

