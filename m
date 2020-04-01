Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D326FC43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 18:50:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA7C20784
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 18:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i4UOCgf1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu9TInj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA7C20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:
	To:Subject:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NexEqNPCQW2MweJvTEXYd4v90d0T0wayPYUHR8cowo8=; b=i4UOCgf1zUksPx
	Gj3Lhi60hyNQobhpGWPre4bpr2IjVpe9WPtG9aAp4yGS7MRITzRy+XuAxFAtWO+itDu9CAIEYtvvc
	TO+5dVnlq7BYvzHCoFpFtlaM3RjI1HpUzYcbBqTG25K11Rq5DCuSITqihDXzpQXv0R8Z6KH/7QT6W
	RWxO5pJSZNhrl6Hv29b4VjTjq2JMomLfJo5hfZVdz4dmX8ITZlIMVdRmGsMLM60fFCgWlIAvrtzko
	Y7bCzx96Y9X2xHldPd896gLbYYJ+dv1gor6mn46C2eVW7cVylkUDX4qy53eYE0DetQlwVZj4AXRUd
	gqTkbMREuZMFZVtz4Ljw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJiRB-0001bR-LL; Wed, 01 Apr 2020 18:50:05 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJiR8-0000sT-VN
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 18:50:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585766999;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=98F5DPaex77wO1IrDkHwiqhQq4DiaF+qwmjE9bmJ0MU=;
 b=Tu9TInj383woqmDT/4wMPTXXKFAdDC2VfC63ohv9Na0mFVg04dTr3HSradBPS1R32vQFmb
 6qjwSYSozUgBzOpEyh6mnhV7LiywrFVyc8USni1UvpvKb1caFlvcuvmHH0x/BbmGbI6VEy
 cGt5Lk1mXFTwZ9BGPorcMkse210rP68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-DWyO5PcLNw6Emg0JY0cUTQ-1; Wed, 01 Apr 2020 14:49:58 -0400
X-MC-Unique: DWyO5PcLNw6Emg0JY0cUTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0D67DBB2
 for <linux-nvme@lists.infradead.org>; Wed,  1 Apr 2020 18:49:56 +0000 (UTC)
Received: from [10.3.128.6] (unknown [10.3.128.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C378C10002BC
 for <linux-nvme@lists.infradead.org>; Wed,  1 Apr 2020 18:49:55 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
Subject: nvmet: Kernel oops during nvmetcli 'make test'
Organization: Red Hat
To: linux-nvme@lists.infradead.org
Message-ID: <bce98bfa-5740-d184-ac47-6ff1c1c97b30@redhat.com>
Date: Wed, 1 Apr 2020 13:49:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_115003_128637_E408D953 
X-CRM114-Status: UNSURE (   7.95  )
X-CRM114-Notice: Please train this message.
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Latest nvmetcli fd09200bba73011b4b7086c96e394ce875fdd38f running against
5.5 generic kernel with one commit added.

a099bf88824599a9104c69001e5f3a914fd5c374 nvme-tcp: fix possible crash in
write_zeroes processing


BUG: kernel NULL pointer dereference, address: 0000000000000030
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 20989 Comm: nose2 Not tainted 5.5.0tony+ #59
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox
12/01/2006
RIP: 0010:nvmet_referral_release+0x14/0x30 [nvmet]
Code: ff ff e8 df 7d c8 d1 49 c7 c4 f4 ff ff ff e9 4f ff ff ff 0f 1f 00
0f 1f 44 00 00 55 48 8b 47 30 48 8d af f0 fb ff ff 48 89 ee <48> 8b 78
30 48 81 ef 10 04 00 00 e8 7c 39 00 00 48 89 ef 5d e9 b3
RSP: 0018:ffffc0dd002c3e18 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: ffff9ce2c7e140c0 RSI: ffff9ce2c56e3800 RDI: ffff9ce2c56e3c10
RBP: ffff9ce2c56e3800 R08: ffff9ce2c56e0c30 R09: 0000000000000000
R10: 0000000000000200 R11: 0000000000000000 R12: ffffffffc0442620
R13: 0000000000000000 R14: 0000000000000000 R15: ffff9ce2c56e3c10
FS:  00007f1392d0c6c0(0000) GS:ffff9ce31bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000030 CR3: 00000000c7584002 CR4: 00000000000606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  config_item_put+0x85/0xd0
  configfs_rmdir+0x1eb/0x2e0
  vfs_rmdir+0x7c/0x170
  do_rmdir+0x140/0x1a0
  do_syscall_64+0x55/0x1a0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f13932c119b
 Code: 73 01 c3 48 8b 0d ed dc 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 54 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d bd dc 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffc1401aad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
 RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00007f13932c119b
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f13919adeb0
 RBP: 00007f139302fee0 R08: 0000000000000000 R09: 00007f139318eff0
 R10: 00007f1393093753 R11: 0000000000000246 R12: 00005582b43e71d0
 R13: 00007f1393165f6c R14: 00007f139299e230 R15: 00007f13919a1890
 Modules linked in: nvme_loop nvme_fabrics nvme_core nvmet_tcp nvmet
fuse sunrpc intel_rapl_msr intel_rapl_common iosf_mbi intel_powerclamp
crct10dif_pclmul crc32_pclmul dm_thin_pool dm_persistent_data
ghash_clmulni_intel dm_bio_prison joydev e1000 intel_rapl_perf pcspkr
vboxguest i2c_piix4 ip_tables xfs libcrc32c crc32c_intel serio_raw
ata_generic video pata_acpi
CR2: 0000000000000030
---[ end trace a6ec6a3c629ca1cd ]---


(gdb) l *(nvmet_referral_release+0x14)
0x32e4 is in nvmet_referral_release (drivers/nvme/target/configfs.c:978).

973 static void nvmet_referral_release(struct config_item *item)
974 {
975         struct nvmet_port *parent =
to_nvmet_port(item->ci_parent->ci_parent);
976         struct nvmet_port *port = to_nvmet_port(item);
977
978         nvmet_referral_disable(parent, port);
979         kfree(port);
980 }


Thanks!
-Tony


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
