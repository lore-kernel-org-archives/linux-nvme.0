Return-Path: <SRS0=77Bv=24=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7195AC33C8C
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E3A208C4
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IaKCvYTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E3A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=chAlT0+V9mFPo3cRKUTUC/YcvJtw3kIqUGQNHxnQSMg=; b=IaKCvYTqa1QhRXdWlDGo1rFaU
	72IGlIWCWMi2i8hRX7XwLLviJSn87sJu/itRCBBJ/yo3g1xT/mOMWUcW/+0cg1yyZARM9/4odY9LP
	5olJ9mi8B7mUSEcoQDJiDI7aiQRyhVQy19W9AQ1rMXMA70MKDfGYcsPaP9IpC2aPQ8nCxagK0RRvg
	6usOLpZeySPo3LC1cRq4tahQSeJHX2NUSeOCjJ4bTuuDwY2zaR+bxxc1kDVrPe847TJSQJEhNH3F1
	voGakLbig/g/Twecl/KeLOLPYGqaR9MMgGiLIVpqPsyG2CyD7SrdDihLIBNcoLz4HETiacDNZ4q+/
	HNW2KFpcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ios2Q-0000Jk-MG; Tue, 07 Jan 2020 16:49:02 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ios2N-0000JH-Ve
 for linux-nvme@lists.infradead.org; Tue, 07 Jan 2020 16:49:02 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jan 2020 08:48:57 -0800
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; d="scan'208";a="215622396"
Received: from unknown (HELO [10.232.112.48]) ([10.232.112.48])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 07 Jan 2020 08:48:57 -0800
Subject: Re: null pointer dereference in nvme_tcp_io_work
To: Stefan Majer <stefan.majer@gmail.com>, sagi grimberg <sagi@grimberg.me>
References: <CADdPHGvjZdh41u4HsSBBFs9jHohQ0qT4UJ223vysKANYZfzKRg@mail.gmail.com>
 <20191226174733.GA513665@chuupie.wdl.wdc.com>
 <CADdPHGsGtqOiS3ZXxf-6rOPeXAtREc-Ag3EAbPaQybtLaKU4Og@mail.gmail.com>
 <CAB5Wxwco3KD1e_nRGQ_mWAMa_2d-wP2-1Aao4ZXtDeVgFQQM_w@mail.gmail.com>
 <CADdPHGuJjpY6WNBw5hGFUKbJdrwM-oQ9A3xCy3e2O6fY4yzEPQ@mail.gmail.com>
 <CADdPHGsT8JxqWN8KKnQgJvNFZXzq08pd5eR1RJeUN-cmhQYH_Q@mail.gmail.com>
 <CADdPHGt+vLDp6hx0u3nabW7s6Ut11Jzbb4gx2NRD95zu3H9mvQ@mail.gmail.com>
 <CADdPHGumJGQcuHtzFZKmezgec1Jx1fBjAJeQDf5_n-YWvowdeQ@mail.gmail.com>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <cb5caef9-097a-9e1d-f42d-7e6f6612bbb2@intel.com>
Date: Tue, 7 Jan 2020 09:48:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CADdPHGumJGQcuHtzFZKmezgec1Jx1fBjAJeQDf5_n-YWvowdeQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200107_084900_040050_B6CC1503 
X-CRM114-Status: GOOD (  27.85  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/7/2020 8:41 AM, Stefan Majer wrote:
> Hi,
> 
> is there anything i can help with to further nail down the problem ?
> 
> please let me know.
> Stefan

Is there any kind of reset in progress when this hits?

Thanks,
Ed

> On Sat, Dec 28, 2019 at 6:53 PM Stefan Majer <stefan.majer@gmail.com> wrote:
>>
>> I have to add:
>>
>> ./faddr2line  /var/lib/debug/lib/modules/5.3.0-24-generic/kernel/drivers/nvme/host/nvme-tcp.ko
>> nvme_tcp_io_work+0x341/0x7f0
>> nvme_tcp_io_work+0x341/0x7f0:
>> nvme_tcp_req_cur_length at
>> /build/linux-4AS01l/linux-5.3.0/drivers/nvme/host/tcp.c:189
>> (inlined by) nvme_tcp_try_send_data at
>> /build/linux-4AS01l/linux-5.3.0/drivers/nvme/host/tcp.c:854
>> (inlined by) nvme_tcp_try_send at
>> /build/linux-4AS01l/linux-5.3.0/drivers/nvme/host/tcp.c:1011
>> (inlined by) nvme_tcp_io_work at
>> /build/linux-4AS01l/linux-5.3.0/drivers/nvme/host/tcp.c:1048
>>
>> On Sat, Dec 28, 2019 at 6:49 PM Stefan Majer <stefan.majer@gmail.com> wrote:
>> >
>> > Hi,
>> >
>> > took a while, but now reproduced with ubuntu-19.10 kernel 5.3.x i
>> > installed the debug symbols and ran decodestacktrace.sh from kernel
>> > sources which gives me:
>> >
>> > [   29.266954] nvme nvme0: new ctrl: NQN
>> > "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.22.1:4420
>> > [   29.267477] nvme nvme0: Removing ctrl: NQN
>> > "nqn.2014-08.org.nvmexpress.discovery"
>> > [   29.285732] nvme nvme0: creating 1 I/O queues.
>> > [   29.286632] nvme nvme0: mapped 1/0 default/read queues.
>> > [   29.288565] nvme nvme0: new ctrl: NQN "nvmet-test", addr
>> > 192.168.22.1:4420
>> > [   29.293146] nvme0n1: detected capacity change from 0 to 1084227584
>> > [   39.196846] BUG: kernel NULL pointer dereference, address:
>> > 0000000000000008
>> > [   39.198524] #PF: supervisor read access in kernel mode
>> > [   39.199786] #PF: error_code(0x0000) - not-present page
>> > [   39.201198] PGD 0 P4D 0
>> > [   39.201849] Oops: 0000 [#1] SMP PTI
>> > [   39.202679] CPU: 0 PID: 223 Comm: kworker/0:1H Kdump: loaded Not
>> > tainted 5.3.0-24-generic #26-Ubuntu
>> > [   39.204830] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> > BIOS 0.0.0 02/06/2015
>> > [   39.207205] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>> > [   39.209005] RIP: 0010:nvme_tcp_io_work+0x341/0x7f0 nvme_tcp
>> > [ 39.210686] Code: 8b 87 98 00 00 00 83 f8 02 0f 85 34 fd ff ff 49 8b
>> > 47 28 4d 89 fe 48 89 45 a8 49 8b 46 78 49 8b 56 68 45 8b 66 34 45 2b
>> > 66 38 <8b> 58 08 8b 48 0c 4c 8b 28 48 29 d3 48 8d 34 11 4c 39 e3 48 89
>> > 75
>> > All code
>> > ========
>> >    0:   8b 87 98 00 00 00       mov    0x98(%rdi),%eax
>> >    6:   83 f8 02                cmp    $0x2,%eax
>> >    9:   0f 85 34 fd ff ff       jne    0xfffffffffffffd43
>> >    f:   49 8b 47 28             mov    0x28(%r15),%rax
>> >   13:   4d 89 fe                mov    %r15,%r14
>> >   16:   48 89 45 a8             mov    %rax,-0x58(%rbp)
>> >   1a:   49 8b 46 78             mov    0x78(%r14),%rax
>> >   1e:   49 8b 56 68             mov    0x68(%r14),%rdx
>> >   22:   45 8b 66 34             mov    0x34(%r14),%r12d
>> >   26:   45 2b 66 38             sub    0x38(%r14),%r12d
>> >   2a:*  8b 58 08                mov    0x8(%rax),%ebx           <--
>> > trapping instruction
>> >   2d:   8b 48 0c                mov    0xc(%rax),%ecx
>> >   30:   4c 8b 28                mov    (%rax),%r13
>> >   33:   48 29 d3                sub    %rdx,%rbx
>> >   36:   48 8d 34 11             lea    (%rcx,%rdx,1),%rsi
>> >   3a:   4c 39 e3                cmp    %r12,%rbx
>> >   3d:   48                      rex.W
>> >   3e:   89                      .byte 0x89
>> >   3f:   75                      .byte 0x75
>> >
>> > Code starting with the faulting instruction
>> > ===========================================
>> >    0:   8b 58 08                mov    0x8(%rax),%ebx
>> >    3:   8b 48 0c                mov    0xc(%rax),%ecx
>> >    6:   4c 8b 28                mov    (%rax),%r13
>> >    9:   48 29 d3                sub    %rdx,%rbx
>> >    c:   48 8d 34 11             lea    (%rcx,%rdx,1),%rsi
>> >   10:   4c 39 e3                cmp    %r12,%rbx
>> >   13:   48                      rex.W
>> >   14:   89                      .byte 0x89
>> >   15:   75                      .byte 0x75
>> > [   39.216464] RSP: 0018:ffffb0f8c0453dd8 EFLAGS: 00010206
>> > [   39.218053] RAX: 0000000000000000 RBX: 00000000b4e42801 RCX: 0000000000000000
>> > [   39.219803] RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffff9dd8e6e49478
>> > [   39.221766] RBP: ffffb0f8c0453e60 R08: 0000000000001000 R09: 0000000002800809
>> > [   39.223635] R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000001000
>> > [   39.226010] R13: 0000000000000048 R14: ffff9dd8e6e49418 R15: ffff9dd8e6e49418
>> > [   39.228992] FS:  0000000000000000(0000) GS:ffff9dd8ff600000(0000)
>> > knlGS:0000000000000000
>> > [   39.233660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [   39.237863] CR2: 0000000000000008 CR3: 0000000067c6a005 CR4: 0000000000360ef0
>> > [   39.241807] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > [   39.244496] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > [   39.246569] Call Trace:
>> > [   39.247272] process_one_work
>> > (/build/linux-4AS01l/linux-5.3.0/arch/x86/include/asm/jump_label.h:25
>> > /build/linux-4AS01l/linux-5.3.0/include/linux/jump_label.h:200
>> > /build/linux-4AS01l/linux-5.3.0/include/trace/events/workqueu
>> > e.h:114 /build/linux-4AS01l/linux-5.3.0/kernel/workqueue.c:2274)
>> > [   39.248361] worker_thread
>> > (/build/linux-4AS01l/linux-5.3.0/include/linux/compiler.h:199
>> > /build/linux-4AS01l/linux-5.3.0/include/linux/list.h:268
>> > /build/linux-4AS01l/linux-5.3.0/kernel/workqueue.c:2416)
>> > [   39.249364] kthread (/build/linux-4AS01l/linux-5.3.0/kernel/kthread.c:255)
>> > [   39.250243] ? process_one_work
>> > (/build/linux-4AS01l/linux-5.3.0/kernel/workqueue.c:2358)
>> > [   39.251485] ? kthread_park
>> > (/build/linux-4AS01l/linux-5.3.0/kernel/kthread.c:215)
>> > [   39.252474] ret_from_fork
>> > (/build/linux-4AS01l/linux-5.3.0/arch/x86/entry/entry_64.S:358)
>> > [   39.253476] Modules linked in: nvme_tcp nvme_fabrics nvme nvme_core
>> > xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user
>> > xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack
>> > nf_defrag_ipv6 nf_
>> > defrag_ipv4 libcrc32c bpfilter br_netfilter bridge stp llc aufs
>> > overlay intel_rapl_msr intel_rapl_common kvm_intel kvm irqbypass
>> > crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
>> > aes_x86_64 crypto_simd cirrus nls_i
>> > so8859_1 cryptd glue_helper drm_kms_helper drm input_leds joydev
>> > fb_sys_fops serio_raw syscopyarea sysfillrect sysimgblt mac_hid
>> > qemu_fw_cfg bonding sch_fq_codel ipmi_watchdog ipmi_devintf
>> > ipmi_msghandler virtio_rng ip_tables
>> > x_tables autofs4 psmouse virtio_net net_failover failover ahci libahci
>> > i2c_piix4 pata_acpi floppy
>> > [   39.269809] CR2: 0000000000000008
>> >
>> > greetings
>> > Stefan
>> >
>> > On Fri, Dec 27, 2019 at 8:54 AM Stefan Majer <stefan.majer@gmail.com> wrote:
>> > >
>> > > Hi,
>> > >
>> > > no problem, i am also on vacation.
>> > >
>> > > the issue is not reproducible in a pure bare metal environment, target
>> > > and host are physical machines.
>> > > The environment where it happens both machines are kvm based.
>> > >
>> > > I first have to figure out howto gdb on the kernel crash, thats not my
>> > > daily jobs, so please be patient.
>> > >
>> > > Greetings
>> > > Stefan
>> > >
>> > > On Fri, Dec 27, 2019 at 8:49 AM sagi grimberg <sagi@grimberg.me> wrote:
>> > > >
>> > > > Hey,
>> > > >
>> > > > On vacation so not able to take a look right now, but can you provide a line info from gdb on the RIP line?
>> > > >
>> > > > Also, did you say that the issue is not reproducible when the host is on bare metal but only on kvm? ( You said the target, but I'm asking about the host).
>> > > >
>> > > > On Thu, Dec 26, 2019, 23:18 Stefan Majer <stefan.majer@gmail.com> wrote:
>> > > >>
>> > > >> Hi,
>> > > >>
>> > > >> i have to add that doing the same on bare metal does work without any problems.
>> > > >> I suspect that this is probably caused by the fact that in the above
>> > > >> example my target is a qemu-kvm machine with a emulated nvme device.
>> > > >> Greetings
>> > > >> Stefan
>> > > >>
>> > > >> On Thu, Dec 26, 2019 at 6:47 PM Keith Busch <kbusch@kernel.org> wrote:
>> > > >> >
>> > > >> > Adding Sagi.
>> > > >> >
>> > > >> > On Wed, Dec 25, 2019 at 11:06:17AM +0100, Stefan Majer wrote:
>> > > >> > > Hi,
>> > > >> > >
>> > > >> > > im trying to setup a nvme-over-tcp test environment with a qemu-kvm
>> > > >> > > based nvmet-tcp target based on ubuntu-19.10 and a ubuntu-19.10 host
>> > > >> > > with kernel 5.4.6 installed. Kernel was taken from
>> > > >> > > https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.6/ . Same Panic
>> > > >> > > occurs with ubuntu 19.10 kernel 5.3.x
>> > > >> > >
>> > > >> > > After setup the target i can discover and connect the exported nvme
>> > > >> > > device on the host with:
>> > > >> > > modprobe nvme
>> > > >> > > modprobe nvme-tcp
>> > > >> > > nvme discover -t tcp -a 192.168.22.1 -s 4420
>> > > >> > > nvme connect -t tcp -n nvmet-test -a 192.168.22.1 -s 4420
>> > > >> > >
>> > > >> > > No errors so far, but when i try to format the device with:
>> > > >> > >
>> > > >> > > mkfs.ext4 /dev/nvme0n1
>> > > >> > >
>> > > >> > > The kernel panics with:
>> > > >> > > Writing inode tables:
>> > > >> > > [  692.651243] BUG: kernel NULL pointer dereference, address: 0000000000000008
>> > > >> > > [  692.653158] #PF: supervisor read access in kernel mode
>> > > >> > > [  692.653922] #PF: error_code(0x0000) - not-present page
>> > > >> > > [  692.653922] PGD 0 P4D 0
>> > > >> > > [  692.653922] Oops: 0000 [#1] SMP PTI
>> > > >> > > [  692.653922] CPU: 0 PID: 224 Comm: kworker/0:1H Not tainted
>> > > >> > > 5.4.6-050406-generic #201912211140
>> > > >> > > [  692.653922] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> > > >> > > BIOS 0.0.0 02/06/2015
>> > > >> > > [  692.653922] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>> > > >> > > [  692.653922] RIP: 0010:nvme_tcp_io_work+0x308/0x790 [nvme_tcp]
>> > > >> > > [  692.653922] Code: 8b 86 98 00 00 00 83 f8 02 0f 85 6d fd ff ff 49
>> > > >> > > 8b 46 28 4d 89 f7 48 89 45 a8 49 8b 47 78 49 8b 57 68 45 8b 67 34 45
>> > > >> > > 2b 67 38 <8b> 58 08 8b 48 0c 4c 8b 28 48 29 d3 48 8d 34 11 4c 39 e3 48
>> > > >> > > 89 75
>> > > >> > > [  692.653922] RSP: 0018:ffffa49a00447dd8 EFLAGS: 00010206
>> > > >> > > [  692.653922] RAX: 0000000000000000 RBX: 0000000077bd3601 RCX: 0000000000000000
>> > > >> > > [  692.653922] RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffff9376781c0500
>> > > >> > > [  692.653922] RBP: ffffa49a00447e60 R08: 0000000000001000 R09: 0000000005000809
>> > > >> > > [  692.653922] R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000001000
>> > > >> > > [  692.653922] R13: 0000000000000048 R14: ffff9376781c04a0 R15: ffff9376781c04a0
>> > > >> > > [  692.653922] FS:  0000000000000000(0000) GS:ffff93767f600000(0000)
>> > > >> > > knlGS:0000000000000000
>> > > >> > > [  692.653922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > >> > > [  692.653922] CR2: 0000000000000008 CR3: 000000007b488003 CR4: 0000000000360ef0
>> > > >> > > [  692.653922] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > > >> > > [  692.653922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > > >> > > [  692.653922] Call Trace:
>> > > >> > > [  692.653922]  process_one_work+0x1ec/0x3a0
>> > > >> > > [  692.653922]  worker_thread+0x4d/0x400
>> > > >> > > [  692.653922]  kthread+0x104/0x140
>> > > >> > > [  692.653922]  ? process_one_work+0x3a0/0x3a0
>> > > >> > > [  692.653922]  ? kthread_park+0x90/0x90
>> > > >> > > [  692.653922]  ret_from_fork+0x35/0x40
>> > > >> > > [  692.653922] Modules linked in: binfmt_misc nvme_tcp nvme_fabrics
>> > > >> > > nvme nvme_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink
>> > > >> > > nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat
>> > > >> > > nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter
>> > > >> > > br_netfilter bridge stp llc overlay intel_rapl_msr intel_rapl_common
>> > > >> > > kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
>> > > >> > > ghash_clmulni_intel aesni_intel nls_iso8859_1 crypto_simd cryptd
>> > > >> > > cirrus glue_helper drm_kms_helper drm input_leds fb_sys_fops joydev
>> > > >> > > serio_raw syscopyarea sysfillrect sysimgblt mac_hid qemu_fw_cfg
>> > > >> > > bonding sch_fq_codel ipmi_watchdog ipmi_devintf ipmi_msghandler
>> > > >> > > virtio_rng ip_tables x_tables autofs4 ahci psmouse virtio_net
>> > > >> > > net_failover failover libahci i2c_piix4 pata_acpi floppy
>> > > >> > > [  692.653922] CR2: 0000000000000008
>> > > >> > > [  692.653922] ---[ end trace d688c2c182feef87 ]---
>> > > >> > > [  692.653922] RIP: 0010:nvme_tcp_io_work+0x308/0x790 [nvme_tcp]
>> > > >> > > [  692.653922] Code: 8b 86 98 00 00 00 83 f8 02 0f 85 6d fd ff ff 49
>> > > >> > > 8b 46 28 4d 89 f7 48 89 45 a8 49 8b 47 78 49 8b 57 68 45 8b 67 34 45
>> > > >> > > 2b 67 38 <8b> 58 08 8b 48 0c 4c 8b 28 48 29 d3 48 8d 34 11 4c 39 e3 48
>> > > >> > > 89 75
>> > > >> > > [  692.653922] RSP: 0018:ffffa49a00447dd8 EFLAGS: 00010206
>> > > >> > > [  692.653922] RAX: 0000000000000000 RBX: 0000000077bd3601 RCX: 0000000000000000
>> > > >> > > [  692.653922] RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffff9376781c0500
>> > > >> > > [  692.653922] RBP: ffffa49a00447e60 R08: 0000000000001000 R09: 0000000005000809
>> > > >> > > [  692.653922] R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000001000
>> > > >> > > [  692.653922] R13: 0000000000000048 R14: ffff9376781c04a0 R15: ffff9376781c04a0
>> > > >> > > [  692.653922] FS:  0000000000000000(0000) GS:ffff93767f600000(0000)
>> > > >> > > knlGS:0000000000000000
>> > > >> > > [  692.653922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > >> > > [  692.653922] CR2: 0000000000000008 CR3: 000000007b488003 CR4: 0000000000360ef0
>> > > >> > > [  692.653922] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > > >> > > [  692.653922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > > >> > >
>> > > >> > >
>> > > >> > > Any help appreciated.
>> > > >> > >
>> > > >> > > Greetings
>> > > >> > >
>> > > >> > > --
>> > > >> > > Stefan Majer
>> > > >>
>> > > >>
>> > > >>
>> > > >> --
>> > > >> Stefan Majer
>> > >
>> > >
>> > >
>> > > --
>> > > Stefan Majer
>> >
>> >
>> >
>> > --
>> > Stefan Majer
>>
>>
>>
>> --
>> Stefan Majer
> 
> 
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
