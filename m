Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17840C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:55:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC0A23888
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC0A23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jsAB8aFM3xLfRr+B7Pn/0zKHGk/jEDVE0G45xdkzMwc=; b=G/IcStDcqxWFob
	J3vzAnPRI1E6wlCJiXnYtkwqTdNhJ2Aqvz8jUS+uv2MX4xsYpMgdQYh6iZcR6b1ET9DJJRxDIIQ4R
	JzfZeejVNgR+Ef8pTxCcAKgI1brukT0U2faC11Eh1abN2Fv/H5xMruKKpCPOzSFi/4QfgXtedD9Ab
	4P9xo3giP/32ONiSsyE+k8a9V66M3gl6LNrtxBZGkLIuR9g8BpvMEWo9xg3Z0YaOuuk+sgjAb9qC8
	0Ii+iseTNtN5BH41ug1K2hSG/Bf5fVclUUpGlQzuXoWyCk98LJehaao3rPv9Cu8fRp0CpRp/mwhw1
	r0WuXsn3JyCP5ETagTMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2mbC-0007yc-FK; Fri, 22 Jan 2021 02:54:58 +0000
Received: from resqmta-po-11v.sys.comcast.net
 ([2001:558:fe16:19:96:114:154:170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2mb9-0007wQ-LQ
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 02:54:57 +0000
Received: from resomta-po-19v.sys.comcast.net ([96.114.154.243])
 by resqmta-po-11v.sys.comcast.net with ESMTP
 id 2mTglfXEnGk1l2maqlgzhH; Fri, 22 Jan 2021 02:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1611284076;
 bh=1AjhO/k+rI0vHFY/1y/ur1HSCSevGk5He4srO9jWDUA=;
 h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
 MIME-Version:Content-Type;
 b=CxQ/hFP6RcT7HDpMnZPIJqLPVUwz1DJ9L7U2DuRhcrD+Sr6CVjogEUzQ8YnPa2mwZ
 8MZZltdN2TDwPLbpQOTzE+6GynujkGXqoZ9x9vDS9O4mTluDtV/YAQlR1S6ifIWZaS
 r9z31dhAudM0e9l31vtssYu+jhv6w5Q8+EtApl2mFU6UVB1m9ludJCs0mPJG6UKCAW
 4YvuTBdTvb8AX7T131XyhL+YpeziuevBUP1bX0djm+JrdLa1KWwlCQYQV7I2CVTR3i
 LiSUeKh+8TDfeft2cKsKaJBRG3sHvxHBPVRRqVJvLzDzsLdd9czKSLLfl7szA2vTUz
 KYwuA5NSghSLg==
Received: from [IPv6:2601:147:c380:23e0:776d:ec36:7c95:99db]
 ([IPv6:2601:147:c380:23e0:776d:ec36:7c95:99db])
 by resomta-po-19v.sys.comcast.net with ESMTPSA
 id 2majlNJrN6FP12maoliJFT; Fri, 22 Jan 2021 02:54:35 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
To: Niklas Cassel <Niklas.Cassel@wdc.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
From: Bradley Chapman <chapman6235@comcast.net>
Message-ID: <c48abecf-8e4f-b76a-c751-1a0d239c99b3@comcast.net>
Date: Thu, 21 Jan 2021 21:54:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121124459.GA156577@localhost.localdomain>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_215455_919886_68CD36A6 
X-CRM114-Status: GOOD (  28.04  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Good evening!

On 1/21/21 7:45 AM, Niklas Cassel wrote:
> On Wed, Jan 20, 2021 at 09:33:08PM -0500, Bradley Chapman wrote:
>>>>> Also can you please also try the latest nvme tree branch nvme-5.11 ?
>>>>>
>>>> Where do I get that code from? Is it already in the 5.11-rc tree or do I
>>>> need to look somewhere else? I checked https://github.com/linux-nvme but
>>>> I did not see it there.
>>> Here is the link :-git://git.infradead.org/nvme.git
>>> Branch 5.12.
>>
>> I tried fetching the entire repo but it was huge and would have taken a long
>> time, so I tried to fetch a single branch instead and got this result:
>>
>> $ git clone --branch 5.12 --single-branch git://git.infradead.org/nvme.git
>> Cloning into 'nvme'...
>> warning: Could not find remote branch 5.12 to clone.
>> fatal: Remote branch 5.12 not found in upstream origin
>>
>> I haven't compiled any out-of-tree kernel code in a very long time - how
>> easy is it to add this code to a kernel tree and compile it into the kernel
>> once I've figured out how to get it?
> 
> Hello there,
> 
> You can see the available branches by replacing git:// with https:// i.e.:
> https://git.infradead.org/nvme.git
> 
> The branch is called nvme-5.12
> 
> It is not out-of-tree kernel code, it is a subsystem git tree,
> so you build the kernel like usual.
> 
> If you already have a kernel git tree somewhere,
> simply add an additional remote, and it should be quick:
> 
> $ git remote add nvme git://git.infradead.org/nvme.git && git fetch nvme
> 
> 
> Kind regards,
> Niklas
> 

I compiled the kernel from the above git tree, rebooted and attempted to 
mount the filesystem on the NVMe drive. This is what the kernel put into 
the dmesg when I attempted to list the contents of the filesystem root, 
create an inode for a zero-byte file and then unmount the filesystem.

Brad

<snip/>

[   52.795975] refcount_t: underflow; use-after-free.
[   52.795981] WARNING: CPU: 7 PID: 0 at lib/refcount.c:28 
refcount_warn_saturate+0xab/0xf0
[   52.795989] Modules linked in: rfcomm(E) cmac(E) bnep(E) 
binfmt_misc(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) btusb(E) 
btrtl(E) btbcm(E) btintel(E) intel_rapl_common(E) iosf_mbi(E) 
crct10dif_pclmul(E) crc32_pclmul(E) bluetooth(E) ghash_clmulni_intel(E) 
rfkill(E) jitterentropy_rng(E) aesni_intel(E) crypto_simd(E) 
efi_pstore(E) cryptd(E) glue_helper(E) drbg(E) ccp(E) ansi_cprng(E) 
ecdh_generic(E) ecc(E) acpi_cpufreq(E) nft_counter(E) efivarfs(E) 
crc32c_intel(E)
[   52.796018] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G            E 
  5.11.0-rc1-BET+ #1
[   52.796021] Hardware name: System manufacturer System Product 
Name/PRIME X570-P, BIOS 3001 12/04/2020
[   52.796023] RIP: 0010:refcount_warn_saturate+0xab/0xf0
[   52.796026] Code: 05 02 a0 72 01 01 e8 49 7d 8b 00 0f 0b c3 80 3d f0 
9f 72 01 00 75 90 48 c7 c7 88 4c c7 8a c6 05 e0 9f 72 01 01 e8 2a 7d 8b 
00 <0f> 0b c3 80 3d cf 9f 72 01 00 0f 85 6d ff ff ff 48 c7 c7 e0 4c c7
[   52.796028] RSP: 0018:ffffa95b80374f28 EFLAGS: 00010082
[   52.796031] RAX: 0000000000000000 RBX: ffff9ac74f014800 RCX: 
0000000000000027
[   52.796032] RDX: 0000000000000027 RSI: ffff9ace4ebd2ed0 RDI: 
ffff9ace4ebd2ed8
[   52.796034] RBP: ffff9ac753820080 R08: 0000000000000000 R09: 
c0000000ffffdfff
[   52.796035] R10: ffffa95b80374d48 R11: ffffa95b80374d40 R12: 
0000000000000001
[   52.796037] R13: ffff9ac7539e2100 R14: 0000000000000016 R15: 
0000000000000000
[   52.796038] FS:  0000000000000000(0000) GS:ffff9ace4ebc0000(0000) 
knlGS:0000000000000000
[   52.796040] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   52.796042] CR2: 00007f3eb6493000 CR3: 00000006afe12000 CR4: 
0000000000350ee0
[   52.796043] Call Trace:
[   52.796045]  <IRQ>
[   52.796046]  nvme_irq+0x10b/0x190
[   52.796052]  __handle_irq_event_percpu+0x2e/0xd0
[   52.796056]  handle_irq_event_percpu+0x33/0x80
[   52.796058]  handle_irq_event+0x39/0x70
[   52.796060]  handle_edge_irq+0x7c/0x1a0
[   52.796064]  asm_call_irq_on_stack+0x12/0x20
[   52.796068]  </IRQ>
[   52.796069]  common_interrupt+0xd7/0x160
[   52.796073]  asm_common_interrupt+0x1e/0x40
[   52.796076] RIP: 0010:cpuidle_enter_state+0xd2/0x2e0
[   52.796080] Code: e8 73 ca 65 ff 31 ff 49 89 c5 e8 09 d4 65 ff 45 84 
ff 74 12 9c 58 f6 c4 02 0f 85 c4 01 00 00 31 ff e8 d2 8a 6b ff fb 45 85 
f6 <0f> 88 c9 00 00 00 49 63 ce be 68 00 00 00 4c 2b 2c 24 48 89 ca 48
[   52.796082] RSP: 0018:ffffa95b80177e80 EFLAGS: 00000202
[   52.796084] RAX: ffff9ace4ebdce80 RBX: 0000000000000002 RCX: 
000000000000001f
[   52.796085] RDX: 0000000c4ae2908c RSI: 00000000239f5229 RDI: 
0000000000000000
[   52.796086] RBP: ffff9ac74e561400 R08: 0000000000000002 R09: 
000000000001c680
[   52.796088] R10: 0000003ae7504a4c R11: ffff9ace4ebdbe64 R12: 
ffffffff8aed3d20
[   52.796089] R13: 0000000c4ae2908c R14: 0000000000000002 R15: 
0000000000000000
[   52.796092]  cpuidle_enter+0x30/0x50
[   52.796095]  do_idle+0x24f/0x290
[   52.796098]  cpu_startup_entry+0x1b/0x20
[   52.796100]  start_secondary+0x11b/0x160
[   52.796103]  secondary_startup_64_no_verify+0xb0/0xbb
[   52.796107] ---[ end trace a0a237d707896b40 ]---
[   82.811599] nvme nvme1: I/O 7 QID 8 timeout, aborting
[   82.811613] nvme nvme1: I/O 8 QID 8 timeout, aborting
[   82.811617] nvme nvme1: I/O 9 QID 8 timeout, aborting
[   82.811622] nvme nvme1: I/O 10 QID 8 timeout, aborting
[   82.811650] nvme nvme1: Abort status: 0x0
[   82.811665] nvme nvme1: Abort status: 0x0
[   82.811668] nvme nvme1: Abort status: 0x0
[   82.811670] nvme nvme1: Abort status: 0x0
[  113.019489] nvme nvme1: I/O 7 QID 8 timeout, reset controller
[  113.037771] nvme nvme1: 15/0/0 default/read/poll queues
[  143.228062] nvme nvme1: I/O 8 QID 8 timeout, disable controller
[  143.346027] blk_update_request: I/O error, dev nvme1n1, sector 16350 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346039] blk_update_request: I/O error, dev nvme1n1, sector 16093 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346044] blk_update_request: I/O error, dev nvme1n1, sector 15836 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346047] blk_update_request: I/O error, dev nvme1n1, sector 15579 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346049] blk_update_request: I/O error, dev nvme1n1, sector 15322 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346052] blk_update_request: I/O error, dev nvme1n1, sector 15065 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346055] blk_update_request: I/O error, dev nvme1n1, sector 14808 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346057] blk_update_request: I/O error, dev nvme1n1, sector 14551 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346060] blk_update_request: I/O error, dev nvme1n1, sector 14294 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346063] blk_update_request: I/O error, dev nvme1n1, sector 14037 
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[  143.346116] nvme nvme1: failed to mark controller live state
[  143.346120] nvme nvme1: Removing after probe failure status: -19
[  143.351776] nvme1n1: detected capacity change from 0 to 500118192
[  143.351836] Aborting journal on device dm-0-8.
[  143.351842] Buffer I/O error on dev dm-0, logical block 25198592, 
lost sync page write
[  143.351846] JBD2: Error -5 detected when updating journal superblock 
for dm-0-8.
[  181.098750] EXT4-fs error (device dm-0): ext4_read_inode_bitmap:203: 
comm touch: Cannot read inode bitmap - block_group = 0, inode_bitmap = 1065
[  181.098792] Buffer I/O error on dev dm-0, logical block 0, lost sync 
page write
[  181.098800] EXT4-fs (dm-0): I/O error while writing superblock
[  181.098806] EXT4-fs error (device dm-0): ext4_journal_check_start:83: 
comm touch: Detected aborted journal
[  181.098811] Buffer I/O error on dev dm-0, logical block 0, lost sync 
page write
[  181.098817] EXT4-fs (dm-0): I/O error while writing superblock
[  181.098819] EXT4-fs (dm-0): Remounting filesystem read-only

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
