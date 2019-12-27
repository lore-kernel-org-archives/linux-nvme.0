Return-Path: <SRS0=8Lqz=2R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA15EC2D0C6
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Dec 2019 07:54:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B2D206F4
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Dec 2019 07:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hxf/ZilZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vV4Y+6jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B2D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oBSiIS0sPkF2aQpvWP9h81ex+DBqIudKhqxLaF65+AA=; b=Hxf/ZilZ8THBMP
	0Iybc4mKdMdcIZsY3hTD5AzdjObeZklk5buB48Zy2Osoy7r7P/f9hElFJSvsyimZKumiiqr9zc88R
	TRVhFvYisNZcmpuF05ybCsVks/Kgzs3WZq6WostjvipIWMq3fu7w5426f2m/haTB0qCMGSRX0d9Xj
	6KA7/oSyUAjw1Z5lP8wPuBcFKXgmiKmNi8+OII51G2wlm0KA+ExDldIzLJdJP8T94K3CIdU+YI3QE
	g1xtOlMe1fgS65uu4PsgFuKt4KkMW9Afnms7N2QFJiMlK/3OH9OpnF+u9W4hIaw8xPa+GXIocMC7I
	ky6Fn1ihoX0YO/6pteDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ikkSG-0008LC-BX; Fri, 27 Dec 2019 07:54:40 +0000
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ikkSD-0008Kh-77
 for linux-nvme@lists.infradead.org; Fri, 27 Dec 2019 07:54:39 +0000
Received: by mail-yw1-xc42.google.com with SMTP id t141so11032344ywc.11
 for <linux-nvme@lists.infradead.org>; Thu, 26 Dec 2019 23:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xSAFzLTHHQZrchgr0tsaeX7PzprQg7Q4SNUKGokvUwg=;
 b=vV4Y+6jdEe2AgwLq0dw/Q6rWIl+XaJgpjnEibhxsM690rhLCTeTqjQrUNDqNMTq3ls
 b9EwSs4/ij4kULZDlgwCCO5H/Eh4hNyH9gsB+GMzILHRAaqWs4XE+hm9jkXl5kQSsknd
 7Yy8Jfbh+k3UBCbw/Kkes2e4Li+OaBe95+sC/WiSCeKFTUeXE1+p3AcbJ2ipai+d0Kqc
 oNyPtVu0ZrZNKIso5JZWnG97CEcu7KbtGY57IQdXBP68TEW0tRiSgilxGyZFfZVDVC66
 UKzAm32S3NrIM3Q7+xBcy+IvbdV+UsaPsGR21wgnBr1DUl+GxF0h1Xf4C14EaNj8AWCK
 4efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xSAFzLTHHQZrchgr0tsaeX7PzprQg7Q4SNUKGokvUwg=;
 b=WFQpD+aSfMOyfpu616Sc7zG3Q50zYCuNvZF1iSu+MQ/Sfy3pV9y4WQ6J93rABZ+KMb
 2ij4lidPmV+yO71TZ0u5gAzIwdgY1CpxJpJhrralePI81pmMAuYjsg9eEQzLvymNgqN5
 x0+MX85TOQas2Oqrvu5lEjkB0bQSuczOFHWv8MLRMUdFBtNxo72lgakB/ejglfw+gbOZ
 Nd/UPdO74e9EIEFzo5Rg9ggaHsm+k9pbG5p3iMygJundFBNHeneNm/yzHBiM3B6S28/t
 nesTGGZ3ook+TQ2DHeoaqWIY+7ogT3FzTK9Xgt+fzfndVjPLnAovfRHXXwe3DjP6huI1
 Kz1g==
X-Gm-Message-State: APjAAAXFCjH3Cc0ZUMVpHY9wWDqVhNsurShorkBpVres84A6DC48BS0J
 NJdoqM1cjEUqr0hUIiqMBcCukrbi6UpblZStjDwTiw==
X-Google-Smtp-Source: APXvYqw7Izfypk2mcqsNmQ2gVMbJj78FHV3s+ioJ9cNp9SyuJBPzbFmIAAoTvpKRXHJUy26DW4dmhGNR2M9GGbXSv5g=
X-Received: by 2002:a81:910e:: with SMTP id i14mr34588416ywg.84.1577433275039; 
 Thu, 26 Dec 2019 23:54:35 -0800 (PST)
MIME-Version: 1.0
References: <CADdPHGvjZdh41u4HsSBBFs9jHohQ0qT4UJ223vysKANYZfzKRg@mail.gmail.com>
 <20191226174733.GA513665@chuupie.wdl.wdc.com>
 <CADdPHGsGtqOiS3ZXxf-6rOPeXAtREc-Ag3EAbPaQybtLaKU4Og@mail.gmail.com>
 <CAB5Wxwco3KD1e_nRGQ_mWAMa_2d-wP2-1Aao4ZXtDeVgFQQM_w@mail.gmail.com>
In-Reply-To: <CAB5Wxwco3KD1e_nRGQ_mWAMa_2d-wP2-1Aao4ZXtDeVgFQQM_w@mail.gmail.com>
From: Stefan Majer <stefan.majer@gmail.com>
Date: Fri, 27 Dec 2019 08:54:23 +0100
Message-ID: <CADdPHGuJjpY6WNBw5hGFUKbJdrwM-oQ9A3xCy3e2O6fY4yzEPQ@mail.gmail.com>
Subject: Re: null pointer dereference in nvme_tcp_io_work
To: sagi grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191226_235437_282983_339DE852 
X-CRM114-Status: GOOD (  19.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

no problem, i am also on vacation.

the issue is not reproducible in a pure bare metal environment, target
and host are physical machines.
The environment where it happens both machines are kvm based.

I first have to figure out howto gdb on the kernel crash, thats not my
daily jobs, so please be patient.

Greetings
Stefan

On Fri, Dec 27, 2019 at 8:49 AM sagi grimberg <sagi@grimberg.me> wrote:
>
> Hey,
>
> On vacation so not able to take a look right now, but can you provide a line info from gdb on the RIP line?
>
> Also, did you say that the issue is not reproducible when the host is on bare metal but only on kvm? ( You said the target, but I'm asking about the host).
>
> On Thu, Dec 26, 2019, 23:18 Stefan Majer <stefan.majer@gmail.com> wrote:
>>
>> Hi,
>>
>> i have to add that doing the same on bare metal does work without any problems.
>> I suspect that this is probably caused by the fact that in the above
>> example my target is a qemu-kvm machine with a emulated nvme device.
>> Greetings
>> Stefan
>>
>> On Thu, Dec 26, 2019 at 6:47 PM Keith Busch <kbusch@kernel.org> wrote:
>> >
>> > Adding Sagi.
>> >
>> > On Wed, Dec 25, 2019 at 11:06:17AM +0100, Stefan Majer wrote:
>> > > Hi,
>> > >
>> > > im trying to setup a nvme-over-tcp test environment with a qemu-kvm
>> > > based nvmet-tcp target based on ubuntu-19.10 and a ubuntu-19.10 host
>> > > with kernel 5.4.6 installed. Kernel was taken from
>> > > https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.6/ . Same Panic
>> > > occurs with ubuntu 19.10 kernel 5.3.x
>> > >
>> > > After setup the target i can discover and connect the exported nvme
>> > > device on the host with:
>> > > modprobe nvme
>> > > modprobe nvme-tcp
>> > > nvme discover -t tcp -a 192.168.22.1 -s 4420
>> > > nvme connect -t tcp -n nvmet-test -a 192.168.22.1 -s 4420
>> > >
>> > > No errors so far, but when i try to format the device with:
>> > >
>> > > mkfs.ext4 /dev/nvme0n1
>> > >
>> > > The kernel panics with:
>> > > Writing inode tables:
>> > > [  692.651243] BUG: kernel NULL pointer dereference, address: 0000000000000008
>> > > [  692.653158] #PF: supervisor read access in kernel mode
>> > > [  692.653922] #PF: error_code(0x0000) - not-present page
>> > > [  692.653922] PGD 0 P4D 0
>> > > [  692.653922] Oops: 0000 [#1] SMP PTI
>> > > [  692.653922] CPU: 0 PID: 224 Comm: kworker/0:1H Not tainted
>> > > 5.4.6-050406-generic #201912211140
>> > > [  692.653922] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> > > BIOS 0.0.0 02/06/2015
>> > > [  692.653922] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>> > > [  692.653922] RIP: 0010:nvme_tcp_io_work+0x308/0x790 [nvme_tcp]
>> > > [  692.653922] Code: 8b 86 98 00 00 00 83 f8 02 0f 85 6d fd ff ff 49
>> > > 8b 46 28 4d 89 f7 48 89 45 a8 49 8b 47 78 49 8b 57 68 45 8b 67 34 45
>> > > 2b 67 38 <8b> 58 08 8b 48 0c 4c 8b 28 48 29 d3 48 8d 34 11 4c 39 e3 48
>> > > 89 75
>> > > [  692.653922] RSP: 0018:ffffa49a00447dd8 EFLAGS: 00010206
>> > > [  692.653922] RAX: 0000000000000000 RBX: 0000000077bd3601 RCX: 0000000000000000
>> > > [  692.653922] RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffff9376781c0500
>> > > [  692.653922] RBP: ffffa49a00447e60 R08: 0000000000001000 R09: 0000000005000809
>> > > [  692.653922] R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000001000
>> > > [  692.653922] R13: 0000000000000048 R14: ffff9376781c04a0 R15: ffff9376781c04a0
>> > > [  692.653922] FS:  0000000000000000(0000) GS:ffff93767f600000(0000)
>> > > knlGS:0000000000000000
>> > > [  692.653922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > [  692.653922] CR2: 0000000000000008 CR3: 000000007b488003 CR4: 0000000000360ef0
>> > > [  692.653922] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > > [  692.653922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > > [  692.653922] Call Trace:
>> > > [  692.653922]  process_one_work+0x1ec/0x3a0
>> > > [  692.653922]  worker_thread+0x4d/0x400
>> > > [  692.653922]  kthread+0x104/0x140
>> > > [  692.653922]  ? process_one_work+0x3a0/0x3a0
>> > > [  692.653922]  ? kthread_park+0x90/0x90
>> > > [  692.653922]  ret_from_fork+0x35/0x40
>> > > [  692.653922] Modules linked in: binfmt_misc nvme_tcp nvme_fabrics
>> > > nvme nvme_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink
>> > > nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat
>> > > nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter
>> > > br_netfilter bridge stp llc overlay intel_rapl_msr intel_rapl_common
>> > > kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
>> > > ghash_clmulni_intel aesni_intel nls_iso8859_1 crypto_simd cryptd
>> > > cirrus glue_helper drm_kms_helper drm input_leds fb_sys_fops joydev
>> > > serio_raw syscopyarea sysfillrect sysimgblt mac_hid qemu_fw_cfg
>> > > bonding sch_fq_codel ipmi_watchdog ipmi_devintf ipmi_msghandler
>> > > virtio_rng ip_tables x_tables autofs4 ahci psmouse virtio_net
>> > > net_failover failover libahci i2c_piix4 pata_acpi floppy
>> > > [  692.653922] CR2: 0000000000000008
>> > > [  692.653922] ---[ end trace d688c2c182feef87 ]---
>> > > [  692.653922] RIP: 0010:nvme_tcp_io_work+0x308/0x790 [nvme_tcp]
>> > > [  692.653922] Code: 8b 86 98 00 00 00 83 f8 02 0f 85 6d fd ff ff 49
>> > > 8b 46 28 4d 89 f7 48 89 45 a8 49 8b 47 78 49 8b 57 68 45 8b 67 34 45
>> > > 2b 67 38 <8b> 58 08 8b 48 0c 4c 8b 28 48 29 d3 48 8d 34 11 4c 39 e3 48
>> > > 89 75
>> > > [  692.653922] RSP: 0018:ffffa49a00447dd8 EFLAGS: 00010206
>> > > [  692.653922] RAX: 0000000000000000 RBX: 0000000077bd3601 RCX: 0000000000000000
>> > > [  692.653922] RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffff9376781c0500
>> > > [  692.653922] RBP: ffffa49a00447e60 R08: 0000000000001000 R09: 0000000005000809
>> > > [  692.653922] R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000001000
>> > > [  692.653922] R13: 0000000000000048 R14: ffff9376781c04a0 R15: ffff9376781c04a0
>> > > [  692.653922] FS:  0000000000000000(0000) GS:ffff93767f600000(0000)
>> > > knlGS:0000000000000000
>> > > [  692.653922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > [  692.653922] CR2: 0000000000000008 CR3: 000000007b488003 CR4: 0000000000360ef0
>> > > [  692.653922] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > > [  692.653922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > >
>> > >
>> > > Any help appreciated.
>> > >
>> > > Greetings
>> > >
>> > > --
>> > > Stefan Majer
>>
>>
>>
>> --
>> Stefan Majer



-- 
Stefan Majer

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
