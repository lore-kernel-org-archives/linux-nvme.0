Return-Path: <SRS0=p+Z5=2Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A65DC2D0DA
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Dec 2019 17:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E586C20828
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Dec 2019 17:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/M8vRVf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSQmtUZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E586C20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hgNCWz4STE5uVl8He5U0HX16rKsFh36UZhyB6G+/8Ak=; b=Q/M8vRVfeLJACy
	0rmywQEc//ASwZ/MjtUQZW/gtH5YLAklRDZ9BHKGVsHCJqCKoAsuOBfyB7lvb2C30W4MT6GylL+9G
	ciF7oPKpHviehz+gFv3174V6+0caqHMIVg72/uBqNZWAwUGPH9uJjtGGhnHpe0sbtvvVb6KREtgtH
	yQqyIYuYvz/jfqM0tFi6z5Ii3bULsam0X2Jx+2NjKx+ST5DQ9YojBP/v/m/reDGH0doi2MZlPOQ9N
	DqBgZbEcvITM1u1bAkHfNG3D/c35LqkzlTtEk5KypecaXpmSU2lgAElgM4zVmVkDZehAiikdnpNov
	Y2oMqfngTrSnOtDPJ/kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ikXEb-000606-Rb; Thu, 26 Dec 2019 17:47:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ikXEW-0005zf-Vq
 for linux-nvme@lists.infradead.org; Thu, 26 Dec 2019 17:47:38 +0000
Received: from chuupie.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 51DAF206CB;
 Thu, 26 Dec 2019 17:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577382455;
 bh=ZmQ7gjXseHycXaZZuqGh9EBXeIPPGm4XBB29b6cUFuw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uSQmtUZ9cvV4CAFSAmU9l75gmVQmIv/iLT686/xxVCMKcJh7aDweMBoVpl237t8oh
 Atavft2VWgWdX6fA2TIU/UmCqc9z+SzlvybFK0cmhr+7GGjHdLBBxCGfB84EV85g1L
 sh6/FNXYq4O/N02Q9NdcsCfwpbd9xQTQ36TvdYXY=
Date: Thu, 26 Dec 2019 10:47:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>, sagi@grimberg.me
Subject: Re: null pointer dereference in nvme_tcp_io_work
Message-ID: <20191226174733.GA513665@chuupie.wdl.wdc.com>
References: <CADdPHGvjZdh41u4HsSBBFs9jHohQ0qT4UJ223vysKANYZfzKRg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADdPHGvjZdh41u4HsSBBFs9jHohQ0qT4UJ223vysKANYZfzKRg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191226_094737_067424_F3F2E400 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Adding Sagi.

On Wed, Dec 25, 2019 at 11:06:17AM +0100, Stefan Majer wrote:
> Hi,
> 
> im trying to setup a nvme-over-tcp test environment with a qemu-kvm
> based nvmet-tcp target based on ubuntu-19.10 and a ubuntu-19.10 host
> with kernel 5.4.6 installed. Kernel was taken from
> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.6/ . Same Panic
> occurs with ubuntu 19.10 kernel 5.3.x
> 
> After setup the target i can discover and connect the exported nvme
> device on the host with:
> modprobe nvme
> modprobe nvme-tcp
> nvme discover -t tcp -a 192.168.22.1 -s 4420
> nvme connect -t tcp -n nvmet-test -a 192.168.22.1 -s 4420
> 
> No errors so far, but when i try to format the device with:
> 
> mkfs.ext4 /dev/nvme0n1
> 
> The kernel panics with:
> Writing inode tables:
> [  692.651243] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [  692.653158] #PF: supervisor read access in kernel mode
> [  692.653922] #PF: error_code(0x0000) - not-present page
> [  692.653922] PGD 0 P4D 0
> [  692.653922] Oops: 0000 [#1] SMP PTI
> [  692.653922] CPU: 0 PID: 224 Comm: kworker/0:1H Not tainted
> 5.4.6-050406-generic #201912211140
> [  692.653922] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 0.0.0 02/06/2015
> [  692.653922] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> [  692.653922] RIP: 0010:nvme_tcp_io_work+0x308/0x790 [nvme_tcp]
> [  692.653922] Code: 8b 86 98 00 00 00 83 f8 02 0f 85 6d fd ff ff 49
> 8b 46 28 4d 89 f7 48 89 45 a8 49 8b 47 78 49 8b 57 68 45 8b 67 34 45
> 2b 67 38 <8b> 58 08 8b 48 0c 4c 8b 28 48 29 d3 48 8d 34 11 4c 39 e3 48
> 89 75
> [  692.653922] RSP: 0018:ffffa49a00447dd8 EFLAGS: 00010206
> [  692.653922] RAX: 0000000000000000 RBX: 0000000077bd3601 RCX: 0000000000000000
> [  692.653922] RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffff9376781c0500
> [  692.653922] RBP: ffffa49a00447e60 R08: 0000000000001000 R09: 0000000005000809
> [  692.653922] R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000001000
> [  692.653922] R13: 0000000000000048 R14: ffff9376781c04a0 R15: ffff9376781c04a0
> [  692.653922] FS:  0000000000000000(0000) GS:ffff93767f600000(0000)
> knlGS:0000000000000000
> [  692.653922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  692.653922] CR2: 0000000000000008 CR3: 000000007b488003 CR4: 0000000000360ef0
> [  692.653922] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  692.653922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  692.653922] Call Trace:
> [  692.653922]  process_one_work+0x1ec/0x3a0
> [  692.653922]  worker_thread+0x4d/0x400
> [  692.653922]  kthread+0x104/0x140
> [  692.653922]  ? process_one_work+0x3a0/0x3a0
> [  692.653922]  ? kthread_park+0x90/0x90
> [  692.653922]  ret_from_fork+0x35/0x40
> [  692.653922] Modules linked in: binfmt_misc nvme_tcp nvme_fabrics
> nvme nvme_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink
> nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat
> nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter
> br_netfilter bridge stp llc overlay intel_rapl_msr intel_rapl_common
> kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel aesni_intel nls_iso8859_1 crypto_simd cryptd
> cirrus glue_helper drm_kms_helper drm input_leds fb_sys_fops joydev
> serio_raw syscopyarea sysfillrect sysimgblt mac_hid qemu_fw_cfg
> bonding sch_fq_codel ipmi_watchdog ipmi_devintf ipmi_msghandler
> virtio_rng ip_tables x_tables autofs4 ahci psmouse virtio_net
> net_failover failover libahci i2c_piix4 pata_acpi floppy
> [  692.653922] CR2: 0000000000000008
> [  692.653922] ---[ end trace d688c2c182feef87 ]---
> [  692.653922] RIP: 0010:nvme_tcp_io_work+0x308/0x790 [nvme_tcp]
> [  692.653922] Code: 8b 86 98 00 00 00 83 f8 02 0f 85 6d fd ff ff 49
> 8b 46 28 4d 89 f7 48 89 45 a8 49 8b 47 78 49 8b 57 68 45 8b 67 34 45
> 2b 67 38 <8b> 58 08 8b 48 0c 4c 8b 28 48 29 d3 48 8d 34 11 4c 39 e3 48
> 89 75
> [  692.653922] RSP: 0018:ffffa49a00447dd8 EFLAGS: 00010206
> [  692.653922] RAX: 0000000000000000 RBX: 0000000077bd3601 RCX: 0000000000000000
> [  692.653922] RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffff9376781c0500
> [  692.653922] RBP: ffffa49a00447e60 R08: 0000000000001000 R09: 0000000005000809
> [  692.653922] R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000001000
> [  692.653922] R13: 0000000000000048 R14: ffff9376781c04a0 R15: ffff9376781c04a0
> [  692.653922] FS:  0000000000000000(0000) GS:ffff93767f600000(0000)
> knlGS:0000000000000000
> [  692.653922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  692.653922] CR2: 0000000000000008 CR3: 000000007b488003 CR4: 0000000000360ef0
> [  692.653922] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  692.653922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> Any help appreciated.
> 
> Greetings
> 
> -- 
> Stefan Majer

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
