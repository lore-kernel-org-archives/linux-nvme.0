Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648FDEE57C7
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 06:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W/BrosM6AoNDvIbkLXdfrb4stN4732TsQs4ivRrcmq8=; b=M3cAbS0f/p7FWt2kbW/4BlaHvl
	hzrnaLeTDRaEchrfpC/x6lstgtbu8wtx+J8RFkCXQs80Ys+y0npVCUYS0PEYEBYYyKbRPyD7crhF5
	XoROC1p55iwSZEbgWNf27T8nx4AhE53tpTJu/5mIssSxiDDOFRudNDlf+J+BdIre4nC9q2Upsh5bJ
	kHN+xD1AbCDHSwt4T9U5hjihbYLuY/0zPP9dn2KQ4bqR3lwZfAsyTXJSE3bFGcqtDIXDa4H8/eBkC
	CyJKxeFlOxSc0Bpabt5SD2fH16VxprkTkb8vsIfo/2g6xBAT8qYjpsy8KxWrXIvLhYzUd/jycA7c8
	hn1JqOWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodIW-0000000C14k-4C5F;
	Thu, 12 Sep 2024 06:27:21 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodIN-0000000C13Z-0LjP
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 06:27:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726122430; x=1757658430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t4jNuxWW7QZouXtvRgqDD8h2RSoCURhs9WS+xni5xaQ=;
  b=JBX88asG72h+z24+jJKgagJoWcrzuTDAi3owOmGSXOFozx6OiZvOX6nJ
   rWFQ79ySWdEuTlZhq3vaFLwmhcJXph69r8COYLJrC5hCZMsSxf31/KR82
   ek8clh9jd0FgqMmvS+41ELKNv1k+BoMpMTGYbrEExXGdZ6r/dQEvIkRTV
   CoqwxbLxI/twkOyeVQuE0X9yER56J/EYG/mOL2OX1pj3fQWlaOoUd65oz
   1KuDMxpdJm2H/XAAU7DqmI5QQ9lTV4Mig5f8vxAXb5k6mjL67v8io35cP
   OyR6NIdKoMSQ8ZbfkxBUUPCpMSyR30m/W9/6VY50xTzEXyCq0+0vvYtix
   g==;
X-CSE-ConnectionGUID: PZXQE+0mSx+0yI7+zY9jWg==
X-CSE-MsgGUID: J/AlmfSMSdihnYsEjqxXRw==
X-IronPort-AV: E=Sophos;i="6.10,222,1719849600"; 
   d="scan'208";a="26885228"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2024 14:27:09 +0800
IronPort-SDR: 66e27cdd_XsGUrkTX6dNqom0uJ0G1VsgMBBAdqgpqhcGflOfs98sQBJB
 Cx4j63tsRma9YHbF4Dz1XPWq1Uw5wVV1zCjlICQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 22:32:14 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2024 23:27:08 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Martin Belanger <martin.belanger@dell.com>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme: tcp: avoid race between lock and destroy of queue_lock
Date: Thu, 12 Sep 2024 15:27:07 +0900
Message-ID: <20240912062707.1759715-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_232711_220502_8630FF7E 
X-CRM114-Status: GOOD (  20.58  )
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

Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
error recovery") added a mutex_lock() call for the queue->queue_lock
in nvme_tcp_get_address(). However, the mutex_lock() races with
mutex_destroy() in nvme_tcp_free_queue(), and causes the WARN below.

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 34077 at kernel/locking/mutex.c:587 __mutex_lock+0xcf0/0x1220
Modules linked in: nvmet_tcp nvmet nvme_tcp nvme_fabrics iw_cm ib_cm ib_core pktcdvd nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc ppdev 9pnet_virtio 9pnet pcspkr netfs parport_pc parport e1000 i2c_piix4 i2c_smbus loop fuse nfnetlink zram bochs drm_vram_helper drm_ttm_helper ttm drm_kms_helper xfs drm sym53c8xx floppy nvme scsi_transport_spi nvme_core nvme_auth serio_raw ata_generic pata_acpi dm_multipath qemu_fw_cfg [last unloaded: ib_uverbs]
CPU: 3 UID: 0 PID: 34077 Comm: udisksd Not tainted 6.11.0-rc7 #319
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
RIP: 0010:__mutex_lock+0xcf0/0x1220
Code: 08 84 d2 0f 85 c8 04 00 00 8b 15 ef b6 c8 01 85 d2 0f 85 78 f4 ff ff 48 c7 c6 20 93 ee af 48 c7 c7 60 91 ee af e8 f0 a7 6d fd <0f> 0b e9 5e f4 ff ff 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1
RSP: 0018:ffff88811305f760 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88812c652058 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff88811305f8b0 R08: 0000000000000001 R09: ffffed1075c36341
R10: ffff8883ae1b1a0b R11: 0000000000010498 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88812c652058
FS:  00007f9713ae4980(0000) GS:ffff8883ae180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd78483c7c CR3: 0000000122c38000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __warn.cold+0x5b/0x1af
 ? __mutex_lock+0xcf0/0x1220
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? __mutex_lock+0xcf0/0x1220
 ? nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
 ? __pfx___mutex_lock+0x10/0x10
 ? __lock_acquire+0xd6a/0x59e0
 ? nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
 nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
 ? __pfx_nvme_tcp_get_address+0x10/0x10 [nvme_tcp]
 nvme_sysfs_show_address+0x81/0xc0 [nvme_core]
 dev_attr_show+0x42/0x80
 ? __asan_memset+0x1f/0x40
 sysfs_kf_seq_show+0x1f0/0x370
 seq_read_iter+0x2cb/0x1130
 ? rw_verify_area+0x3b1/0x590
 ? __mutex_lock+0x433/0x1220
 vfs_read+0x6a6/0xa20
 ? lockdep_hardirqs_on+0x78/0x100
 ? __pfx_vfs_read+0x10/0x10
 ksys_read+0xf7/0x1d0
 ? __pfx_ksys_read+0x10/0x10
 ? __x64_sys_openat+0x105/0x1d0
 do_syscall_64+0x93/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? __pfx_ksys_read+0x10/0x10
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? do_syscall_64+0x9f/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f9713f55cfa
Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 e8 74 f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 48 89 45 f8 e8 42 75 f8 ff 48 8b
RSP: 002b:00007ffd7f512e70 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055c38f316859 RCX: 00007f9713f55cfa
RDX: 0000000000000fff RSI: 00007ffd7f512eb0 RDI: 0000000000000011
RBP: 00007ffd7f512e90 R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000055c38f317148
R13: 0000000000000000 R14: 00007f96f4004f30 R15: 000055c3b6b623c0
 </TASK>

The WARN is observed when the blktests test case nvme/014 is repeated
with tcp transport. It is rare, and 200 times repeat is required to
recreate in my test environment.

To avoid the WARN, serialize the two functions nvme_tcp_get_address()
and nvme_tcp_free_queue(). Add the flag NVME_TCP_Q_REFERRED and set it
when nvme_tcp_get_address() starts. Have nvme_tcp_free_queue() wait the
flag cleared so that it does not run until nvme_tcp_get_address() ends.
Also check the NVME_TCP_Q_ALLOCATED flag when nvme_tcp_get_address()
starts. This flag is cleared at the nvme_tcp_free_queue() start, then it
ensures that nvme_tcp_get_address() is not executed while
nvme_tcp_free_queue() runs.

Of note is that nvme_tcp_stop_queue() locks the queue->queue_lock in
same manner as nvme_tcp_get_address(). However, nvme_tcp_stop_queue() is
called in sequence before nvme_tcp_free_queue(), then it is safe to
assume that the queue->queue_lock is not yet destroyed at
nvme_tcp_stop_queue() call. Therefore this fix does not touch
nvme_tcp_stop_queue().

Fixes: 76d54bf20cdc ("nvme-tcp: don't access released socket during error recovery")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/tcp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a2a47d3ab99f..1457ffda207b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -127,6 +127,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_REFERRED	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -1365,6 +1366,9 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	wait_on_bit_io(&queue->flags, NVME_TCP_Q_REFERRED,
+		       TASK_UNINTERRUPTIBLE);
+
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 
@@ -2613,7 +2617,14 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 {
 	struct nvme_tcp_queue *queue = &to_tcp_ctrl(ctrl)->queues[0];
 	struct sockaddr_storage src_addr;
-	int ret, len;
+	int ret, len = 0;
+
+	/* Serialize this function and nvme_tcp_free_queue() */
+	if (test_and_set_bit(NVME_TCP_Q_REFERRED, &queue->flags))
+		return 0;
+
+	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		goto out;
 
 	len = nvmf_get_address(ctrl, buf, size);
 
@@ -2631,6 +2642,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 done:
 	mutex_unlock(&queue->queue_lock);
 
+out:
+	clear_and_wake_up_bit(NVME_TCP_Q_REFERRED, &queue->flags);
+
 	return len;
 }
 
-- 
2.45.2


