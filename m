Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8637DC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 22:35:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F8720656
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 22:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L+5Pf0kc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=markus-regensburg.de header.i=@markus-regensburg.de header.b="QUH1dkQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F8720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=markus-regensburg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=udUN4P9F2+gsmax7usBgtjvnkNHuTkBFfoyioFqBC5k=; b=L+5Pf0kcbMEbLf/ow9Sn6Y0tRi
	cruhGV2osw7nYvlezKbqhu/rk8f11SDZPo+nnqtBaYUt8p2xfY9Cuha+rJNrgZAPMA3Us9Vn1vSfA
	1Mv0/frrlFZHrxkn+abukGqz0BKANtTukf/ZR7TkGSEMCf6o+wiJlw3Zb/73JtkiKWztO5acmF/WA
	8e8h44eb0+1AkUqrvt0A2T56uRSYFZoNWZywaRNT9wmvoGxWenF9Di0a+tFJ9Sa5eCnKDeP1CLBMq
	GuS8GW3m8PY4cTwkrbNIDIPm9cX/RGmFygxvNBAwZItmcWMPznd6dciudFKbQznHGRKeZ4ayRiUwy
	+RPsoXXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAL3l-0005ir-QO; Mon, 24 Aug 2020 22:35:25 +0000
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAL3i-0005hi-V8
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 22:35:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598308518;
 s=strato-dkim-0002; d=markus-regensburg.de;
 h=Date:Message-ID:Cc:To:Subject:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=xNEGHQnBauR/pTPbFUY7qm9aB0G8UiTAb3891zIgnyo=;
 b=QUH1dkQTRYsiN/CmgzJjqWrefJTZu6NKsOK54GxshepgzYfc8aIxlUDN53WzHtIefK
 Xg2FrJjh1mBepTg0AY64cakoJoiKdpyL7HmraL9Cd+SDlAtDGFgvLDVNcxoz4t5+Uz//
 pXcV55LNmPETH83AMplQMC5h96TnGaXb0MlKUrMCLEGBKonVLfh5eb2thGwfCNsdjgDi
 NCr+wyhNM/Vv0A4qareQVBmjqkNWLhjTn5X4Hv+Pi2won+4T6Up54PbJcSqnukPz/m50
 08GcfJJuvRfGDQfvVDvdbbRD1Ducwp6aTzbJYbwp6WqVHWCzy7baNsExJUmaMWBrC90f
 dsmA==
X-RZG-AUTH: ":OGMGfEG7W/Jia0H4RdpQ6UBM+orSOYYzpexsp56HbOixc6mZ0UouEGtpBP1knqcz2lODpgRBJBVD1isPSg=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.124.154] by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
 with ESMTPSA id e04bf5w7OMZGKOu
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 25 Aug 2020 00:35:16 +0200 (CEST)
From: Tobias Markus <tobias@markus-regensburg.de>
Subject: Null pointer dereference in nvme_ctrl_reconnect_delay_show
To: linux-nvme@lists.infradead.org
Message-ID: <59c468d3-b688-260e-b491-581c3ba96a21@markus-regensburg.de>
Date: Tue, 25 Aug 2020 00:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: de-DE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_183523_251252_843A6EA0 
X-CRM114-Status: GOOD (  13.55  )
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
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

I hope this is the right channel for bug reports regarding the NVMe subsystem.

Trying to read sysfs attributes of an NVMe drive resulted in a null pointer dereference on 5.9.0-rc2.

The precise command was:
    udevadm info --attribute-walk --path=/sys/block/nvme0n1

Using strace, I found out that the bug occurs reproducibly when reading
    /sys/block/nvme0n1/device/ctrl_loss_tmo

I could further determine that ctrl->opts is not set in the struct nvme_ctrl in nvme_ctrl_reconnect_delay_show.

I could reproduce this bug with the latest NVMe fixes (commit c41c3ec4) as well.

BUG: kernel NULL pointer dereference, address: 000000000000003c
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#2] PREEMPT SMP PTI
CPU: 2 PID: 1138 Comm: udevadm Tainted: G      D         T 5.9.0-rc2-custom #116
Hardware name: LENOVO 20HES01100/20HES01100, BIOS N1QET88W (1.63 ) 04/22/2020
RIP: 0010:nvme_ctrl_reconnect_delay_show+0x16/0x40
Code: f0 80 a2 e8 0a 00 00 fe c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 f8 48 89 d7 49 8b 40 78 48 8b >
RSP: 0018:ffffa77d81bf7e30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff9cf2ca20 RCX: 0000000000000000
RDX: ffff96ceadb84000 RSI: ffffffff9cf2ca20 RDI: ffff96ceadb84000
RBP: 0000000000001000 R08: ffff96ceafc432a8 R09: ffff96ceadb84000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff9c70a170
R13: ffff96ceafc432a8 R14: ffff96ce5c010000 R15: ffff96ceab012ce0
FS:  00007ffb8077c440(0000) GS:ffff96ceb2700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000003c CR3: 00000003f75ce006 CR4: 00000000003706e0
Call Trace:
 dev_attr_show+0x19/0x40
 sysfs_kf_seq_show+0x82/0x100
 seq_read+0xb1/0x460
 vfs_read+0xa5/0x190
 ksys_read+0x70/0xf0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ffb8151cec2
Code: c0 e9 b2 fe ff ff 50 48 8d 3d aa 36 0a 00 e8 65 eb 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 >
RSP: 002b:00007ffd82240858 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000001001 RCX: 00007ffb8151cec2
RDX: 0000000000001001 RSI: 0000562a6d612760 RDI: 0000000000000003
RBP: 0000562a6d612760 R08: 0000562a6d612760 R09: 00007ffb815eea60
R10: 0000000000000200 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000001000 R14: 0000000000000000 R15: 00007ffd82240880
Modules linked in:
CR2: 000000000000003c
---[ end trace 2027c17b64314629 ]---
RIP: 0010:nvme_ctrl_reconnect_delay_show+0x16/0x40
Code: f0 80 a2 e8 0a 00 00 fe c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 f8 48 89 d7 49 8b 40 78 48 8b >
RSP: 0018:ffffa77d81ca7e30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff9cf2ca20 RCX: 0000000000000000
RDX: ffff96cea39c2000 RSI: ffffffff9cf2ca20 RDI: ffff96cea39c2000
RBP: 0000000000001000 R08: ffff96ceafc432a8 R09: ffff96cea39c2000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff9c70a170
R13: ffff96ceafc432a8 R14: ffff96ceac5423c0 R15: ffff96ceab25a4e8
FS:  00007ffb8077c440(0000) GS:ffff96ceb2700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000003c CR3: 00000003f75ce006 CR4: 00000000003706e0


Please advise if you need any further information.

Tobias

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
