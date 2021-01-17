Return-Path: <SRS0=VvGj=GU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF90C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Jan 2021 18:59:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679DA224BD
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Jan 2021 18:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679DA224BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject
	:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aBcoFIm8oCz2dP+6etRNG2caxvW0mrOPHZVYdnl+KwA=; b=hLU5Q6VXKBe9N0Pk54kqdxK1ZO
	giSb16ArJgm5dQT+hsU7vmWBT6d+JaYxgHHRNp9dyh0WuuKlw0L/kVSlm4IqrVYEqVSc1B2nzX03F
	wcQ3RkMx0SuP7vM7JIsPjjDnG8arHlbZXllopqQX/+CwMS7RQcfOa4xujQBdBCqPvaCwyqF0VWsRk
	Yxdpt/seovY16MD6gam/SSJLGny/A2QgeFL3iZq9KJM4TWtviyrYSviVfrFHRoyWye62SyiTa2fr1
	FtVb74xrI4EUOxpotKyipRcVXd6VsoDVYQLt7oYhE7R6M7rKGg1VoF86cMQ/BTg6UY3EToZjXcdV7
	ewCsSYww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1DGW-00078h-Dm; Sun, 17 Jan 2021 18:59:08 +0000
Received: from resqmta-po-05v.sys.comcast.net
 ([2001:558:fe16:19:96:114:154:164])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1DGS-00077f-GU
 for linux-nvme@lists.infradead.org; Sun, 17 Jan 2021 18:59:06 +0000
Received: from resomta-po-06v.sys.comcast.net ([96.114.154.230])
 by resqmta-po-05v.sys.comcast.net with ESMTP
 id 1Bh7lztFEoWle1DG9lSRxu; Sun, 17 Jan 2021 18:58:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1610909925;
 bh=BO7ZtFLHpZa1ItXLdekUBY2CbepGktIcRylz4HAsiok=;
 h=Received:Received:From:Subject:Reply-To:To:Message-ID:Date:
 MIME-Version:Content-Type;
 b=t5Lk2j3rTcD+YFYIcgZiPVl53R+sano1kEtybeqQj+WV5TptopdQf8qPp+8nJSaeS
 Kw6E/2OmY/D+QUjmF/rDnBfEzbEqm4rjhPR3yIdyOxke7bq7KzgvVKMZsHmQsqjDKm
 7/3IF0jtHX+9uaBcgDylCw2gBdOVQD48DC7pVk4o34CyGhmyoYcU7QhfcbLBe8eYek
 tFUgEr1fx7pkOMmqiV3PmCGttl24fHo3Mr6Klv7xWDNf8FMnbKa6IhwBFriIDoZxnR
 Cum7txK8WQX0RYrA/VvdylGz2L7bo/0AG9P+xwRdv5b09TutyvgoLAp4+QDNL09QND
 L8szl+SbC9tIA==
Received: from [IPv6:2601:147:c380:23e0:563f:596c:c2c1:5c73]
 ([IPv6:2601:147:c380:23e0:563f:596c:c2c1:5c73])
 by resomta-po-06v.sys.comcast.net with ESMTPSA
 id 1DFylRQuB1WFp1DFylDdRA; Sun, 17 Jan 2021 18:58:43 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
From: Bradley Chapman <chapman6235@comcast.net>
Subject: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
To: linux-nvme@lists.infradead.org
Message-ID: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
Date: Sun, 17 Jan 2021 13:58:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210117_135905_186790_0B4E8986 
X-CRM114-Status: GOOD (  14.77  )
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
Reply-To: chapman6235@comcast.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

All,

I recently plugged a 256GB SPCC NVMe 1.3 drive into the secondary slot 
on my Asus X570-P motherboard, running a Ryzen 5 3600 CPU. After 
partitioning and formatting the drive, it is detected thusly by the 
5.9.15 and 5.10.6 kernels:

[    1.653074] nvme nvme1: pci function 0000:04:00.0
[    1.657181] nvme nvme1: missing or invalid SUBNQN field.
[    1.662294] nvme nvme1: allocated 64 MiB host memory buffer.
[    1.663105] nvme nvme1: 15/0/0 default/read/poll queues
[    1.665815]  nvme1n1: p1

However, any I/O to the drive (including mounting its filesystem) causes 
the following errors to appear in the dmesg. These errors occur with 
both the 5.9.15 kernel and the 5.10.6 kernel, and with X570-P BIOS 
version 1406 and version 3001. I have modified the BIOS settings to 
specify that a GEN 3 device is plugged into the M.2_2 slot instead of 
allowing the BIOS to auto-detect the drive.

[ 2745.659502] refcount_t: underflow; use-after-free.
[ 2745.659510] WARNING: CPU: 2 PID: 0 at lib/refcount.c:28 
refcount_warn_saturate+0xab/0xf0
[ 2745.659510] Modules linked in: rfcomm(E) cmac(E) bnep(E) 
binfmt_misc(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) uas(E) 
usb_storage(E) btusb(E) btrtl(E) crct10dif_pclmul(E) btbcm(E) 
crc32_pclmul(E) btintel(E) ghash_clmulni_intel(E) bluetooth(E) rfkill(E) 
aesni_intel(E) crypto_simd(E) cryptd(E) glue_helper(E) efi_pstore(E) 
jitterentropy_rng(E) drbg(E) ccp(E) ansi_cprng(E) ecdh_generic(E) ecc(E) 
acpi_cpufreq(E) nft_counter(E) efivarfs(E) crc32c_intel(E)
[ 2745.659527] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G            E 
5.10.6-BET #1
[ 2745.659528] Hardware name: System manufacturer System Product 
Name/PRIME X570-P, BIOS 3001 12/04/2020
[ 2745.659529] RIP: 0010:refcount_warn_saturate+0xab/0xf0
[ 2745.659530] Code: 05 af d2 72 01 01 e8 7a 06 87 00 0f 0b c3 80 3d 9d 
d2 72 01 00 75 90 48 c7 c7 78 60 44 af c6 05 8d d2 72 01 01 e8 5b 06 87 
00 <0f> 0b c3 80 3d 7c d2 72 01 00 0f 85 6d ff ff ff 48 c7 c7 d0 60 44
[ 2745.659531] RSP: 0018:ffffaf1880298f30 EFLAGS: 00010086
[ 2745.659532] RAX: 0000000000000000 RBX: ffff9873cf3bc300 RCX: 
0000000000000027
[ 2745.659533] RDX: 0000000000000027 RSI: ffff987acea92e80 RDI: 
ffff987acea92e88
[ 2745.659533] RBP: ffff9873d0e661f0 R08: 0000000000000000 R09: 
c0000000ffffdfff
[ 2745.659534] R10: ffffaf1880298d50 R11: ffffaf1880298d48 R12: 
0000000000000001
[ 2745.659534] R13: ffff9873d0f98580 R14: ffff9873cdf8ac00 R15: 
0000000000000000
[ 2745.659535] FS:  0000000000000000(0000) GS:ffff987acea80000(0000) 
knlGS:0000000000000000
[ 2745.659536] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2745.659536] CR2: 00005588763902c8 CR3: 0000000107248000 CR4: 
0000000000350ee0
[ 2745.659537] Call Trace:
[ 2745.659538]  <IRQ>
[ 2745.659541]  nvme_irq+0x104/0x190
[ 2745.659543]  __handle_irq_event_percpu+0x2e/0xd0
[ 2745.659545]  handle_irq_event_percpu+0x33/0x80
[ 2745.659545]  handle_irq_event+0x39/0x70
[ 2745.659547]  handle_edge_irq+0x7c/0x1a0
[ 2745.659549]  asm_call_irq_on_stack+0x12/0x20
[ 2745.659549]  </IRQ>
[ 2745.659551]  common_interrupt+0xd7/0x160
[ 2745.659552]  asm_common_interrupt+0x1e/0x40
[ 2745.659554] RIP: 0010:cpuidle_enter_state+0xd2/0x2e0
[ 2745.659555] Code: e8 93 22 6a ff 31 ff 49 89 c5 e8 29 2c 6a ff 45 84 
ff 74 12 9c 58 f6 c4 02 0f 85 c4 01 00 00 31 ff e8 a2 d8 6f ff fb 45 85 
f6 <0f> 88 c9 00 00 00 49 63 ce be 68 00 00 00 4c 2b 2c 24 48 89 ca 48
[ 2745.659556] RSP: 0018:ffffaf188014fe80 EFLAGS: 00000202
[ 2745.659557] RAX: ffff987acea9ce00 RBX: 0000000000000002 RCX: 
000000000000001f
[ 2745.659557] RDX: 0000027f460f1f90 RSI: 00000000239f5229 RDI: 
0000000000000000
[ 2745.659558] RBP: ffff9873c1a4e800 R08: 0000000000000002 R09: 
000000000001c600
[ 2745.659558] R10: 0000090da145abf0 R11: ffff987acea9be24 R12: 
ffffffffaf6d38e0
[ 2745.659559] R13: 0000027f460f1f90 R14: 0000000000000002 R15: 
0000000000000000
[ 2745.659561]  cpuidle_enter+0x30/0x50
[ 2745.659562]  do_idle+0x24f/0x290
[ 2745.659564]  cpu_startup_entry+0x1b/0x20
[ 2745.659566]  start_secondary+0x10b/0x150
[ 2745.659567]  secondary_startup_64_no_verify+0xb0/0xbb
[ 2745.659569] ---[ end trace be84281f034198f3 ]---
[ 2776.138874] nvme nvme1: I/O 414 QID 3 timeout, aborting
[ 2776.138886] nvme nvme1: I/O 415 QID 3 timeout, aborting
[ 2776.138891] nvme nvme1: I/O 416 QID 3 timeout, aborting
[ 2776.138895] nvme nvme1: I/O 417 QID 3 timeout, aborting
[ 2776.138912] nvme nvme1: Abort status: 0x0
[ 2776.138921] nvme nvme1: I/O 428 QID 3 timeout, aborting
[ 2776.138922] nvme nvme1: Abort status: 0x0
[ 2776.138925] nvme nvme1: Abort status: 0x0
[ 2776.138974] nvme nvme1: Abort status: 0x0
[ 2776.138977] nvme nvme1: Abort status: 0x0
[ 2806.346792] nvme nvme1: I/O 414 QID 3 timeout, reset controller
[ 2806.363566] nvme nvme1: 15/0/0 default/read/poll queues
[ 2836.554298] nvme nvme1: I/O 415 QID 3 timeout, disable controller
[ 2836.672064] blk_update_request: I/O error, dev nvme1n1, sector 16350 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672072] blk_update_request: I/O error, dev nvme1n1, sector 16093 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672074] blk_update_request: I/O error, dev nvme1n1, sector 15836 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672076] blk_update_request: I/O error, dev nvme1n1, sector 15579 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672078] blk_update_request: I/O error, dev nvme1n1, sector 15322 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672080] blk_update_request: I/O error, dev nvme1n1, sector 15065 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672082] blk_update_request: I/O error, dev nvme1n1, sector 14808 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672083] blk_update_request: I/O error, dev nvme1n1, sector 14551 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672085] blk_update_request: I/O error, dev nvme1n1, sector 14294 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672087] blk_update_request: I/O error, dev nvme1n1, sector 14037 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672121] nvme nvme1: failed to mark controller live state
[ 2836.672123] nvme nvme1: Removing after probe failure status: -19
[ 2836.689016] Aborting journal on device dm-0-8.
[ 2836.689024] Buffer I/O error on dev dm-0, logical block 25198592, 
lost sync page write
[ 2836.689027] JBD2: Error -5 detected when updating journal superblock 
for dm-0-8.

[ 2836.723821] percpu ref (hd_struct_free) <= 0 (-28) after switching to 
atomic
[ 2836.723828] WARNING: CPU: 8 PID: 0 at lib/percpu-refcount.c:196 
percpu_ref_switch_to_atomic_rcu+0x139/0x140
[ 2836.723828] Modules linked in: rfcomm(E) cmac(E) bnep(E) 
binfmt_misc(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) uas(E) 
usb_storage(E) btusb(E) btrtl(E) crct10dif_pclmul(E) btbcm(E) 
crc32_pclmul(E) btintel(E) ghash_clmulni_intel(E) bluetooth(E) rfkill(E) 
aesni_intel(E) crypto_simd(E) cryptd(E) glue_helper(E) efi_pstore(E) 
jitterentropy_rng(E) drbg(E) ccp(E) ansi_cprng(E) ecdh_generic(E) ecc(E) 
acpi_cpufreq(E) nft_counter(E) efivarfs(E) crc32c_intel(E)
[ 2836.723844] CPU: 8 PID: 0 Comm: swapper/8 Tainted: G        W   E 
5.10.6-BET #1
[ 2836.723845] Hardware name: System manufacturer System Product 
Name/PRIME X570-P, BIOS 3001 12/04/2020
[ 2836.723847] RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x139/0x140
[ 2836.723848] Code: 80 3d f9 f0 72 01 00 0f 85 52 ff ff ff 49 8b 54 24 
e0 49 8b 74 24 e8 48 c7 c7 88 5f 44 af c6 05 db f0 72 01 01 e8 ad 24 87 
00 <0f> 0b e9 2e ff ff ff 41 55 49 89 f5 41 54 55 48 89 fd 53 48 83 ec
[ 2836.723849] RSP: 0018:ffffaf18803a0f20 EFLAGS: 00010282
[ 2836.723850] RAX: 0000000000000000 RBX: 7fffffffffffffe3 RCX: 
0000000000000027
[ 2836.723850] RDX: 0000000000000027 RSI: ffff987acec12e80 RDI: 
ffff987acec12e88
[ 2836.723851] RBP: 0000369db0c0e3c8 R08: 0000000000000000 R09: 
c0000000ffffdfff
[ 2836.723851] R10: ffffaf18803a0d40 R11: ffffaf18803a0d38 R12: 
ffff9873c0bbbda0
[ 2836.723852] R13: ffffffffaf765f10 R14: 0000000000000202 R15: 
ffffffffaf6060c0
[ 2836.723853] FS:  0000000000000000(0000) GS:ffff987acec00000(0000) 
knlGS:0000000000000000
[ 2836.723853] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2836.723854] CR2: 0000558899b414c0 CR3: 0000000101cd2000 CR4: 
0000000000350ee0
[ 2836.723854] Call Trace:
[ 2836.723855]  <IRQ>
[ 2836.723859]  rcu_core+0x196/0x420
[ 2836.723862]  __do_softirq+0xc9/0x214
[ 2836.723863]  asm_call_irq_on_stack+0x12/0x20
[ 2836.723864]  </IRQ>
[ 2836.723866]  do_softirq_own_stack+0x31/0x40
[ 2836.723867]  irq_exit_rcu+0x9a/0xa0
[ 2836.723869]  sysvec_apic_timer_interrupt+0x2c/0x80
[ 2836.723870]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[ 2836.723872] RIP: 0010:cpuidle_enter_state+0xd2/0x2e0
[ 2836.723873] Code: e8 93 22 6a ff 31 ff 49 89 c5 e8 29 2c 6a ff 45 84 
ff 74 12 9c 58 f6 c4 02 0f 85 c4 01 00 00 31 ff e8 a2 d8 6f ff fb 45 85 
f6 <0f> 88 c9 00 00 00 49 63 ce be 68 00 00 00 4c 2b 2c 24 48 89 ca 48
[ 2836.723874] RSP: 0018:ffffaf188017fe80 EFLAGS: 00000202
[ 2836.723874] RAX: ffff987acec1ce00 RBX: 0000000000000002 RCX: 
000000000000001f
[ 2836.723875] RDX: 0000029479ea3f98 RSI: 00000000239f5229 RDI: 
0000000000000000
[ 2836.723875] RBP: ffff9873c1a4ec00 R08: 0000000000000002 R09: 
000000000001c600
[ 2836.723876] R10: 00000959d0ea6498 R11: ffff987acec1be24 R12: 
ffffffffaf6d38e0
[ 2836.723876] R13: 0000029479ea3f98 R14: 0000000000000002 R15: 
0000000000000000
[ 2836.723878]  cpuidle_enter+0x30/0x50
[ 2836.723880]  do_idle+0x24f/0x290
[ 2836.723882]  cpu_startup_entry+0x1b/0x20
[ 2836.723884]  start_secondary+0x10b/0x150
[ 2836.723885]  secondary_startup_64_no_verify+0xb0/0xbb
[ 2836.723887] ---[ end trace be84281f034198f4 ]---

After these errors are generated, the device becomes inaccessible and 
unmounting its filesystem (which does not hang in D state) generates 
additional errors:

[ 2868.181018] Buffer I/O error on dev dm-0, logical block 0, lost sync 
page write
[ 2868.181022] EXT4-fs (dm-0): I/O error while writing superblock

After the filesystem is unmounted the device no longer appears in the 
output of lsblk(8) and its device node(s) disappear after the kernel 
removes the device. Prior to the I/O failures, the nvme error-log 
command returns no error entries for any of the 64 log entries present.

nvme fw-log and nvme smart-log return the following output:

Firmware Log for device:nvme1
afi  : 0x20

Smart Log for NVME device:nvme1 namespace-id:ffffffff
critical_warning                    : 0
temperature                         : 48 C
available_spare                     : 100%
available_spare_threshold           : 10%
percentage_used                     : 0%
data_units_read                     : 234
data_units_written                  : 2,149
host_read_commands                  : 4,202
host_write_commands                 : 421,917
controller_busy_time                : 0
power_cycles                        : 7
power_on_hours                      : 11
unsafe_shutdowns                    : 0
media_errors                        : 0
num_err_log_entries                 : 0
Warning Temperature Time            : 0
Critical Composite Temperature Time : 0
Temperature Sensor 1                : 48 C
Thermal Management T1 Trans Count   : 0
Thermal Management T2 Trans Count   : 0
Thermal Management T1 Total Time    : 0
Thermal Management T2 Total Time    : 0

I've checked the kernel change logs and I know that the refcount_t error 
has been occurring in other kernel subsystems and was subsequently fixed 
in recent kernel point releases, so I will be trying to reproduce this 
error with the most recent 5.10 and 5.11-rc kernels.

Any suggestions on what else to try next?

Thanks!

Brad

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
