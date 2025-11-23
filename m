Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E01CFD316
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKJ3Ki80LpfNfoODAHioJMPRhlPCzuiQDXTG6g2MQu8=; b=AQ/qAeZc6CnTKS5VXO+Wdv1S0M
	DAXj34MNDFW/wvIvxwj0+01ue9ks/Km6zVTY8fi/e/Jfu6uUqomztp0XU5Jk4i5LKQpSMlOLGOCST
	FpXQfxjooyKhdlEcy2OV9zUM3OMGXDNfqxKEXauWH8p5oLFZViC66CvTb7k8YuukdarX6MPvPVSrh
	2uS83/BGsoyKrZ0I3kHr0peGUuGafYSxJSSeUkjjAmGvaGKRJ2pvPaShijb45RLNtpWY9QC8ZL1ki
	/ea27G+z88C22hl6UGt1u7BHNq1lU/9grFFD/PhSkX8Am9ut912p6tmZYsYLyxldL9T7T0yOaac4v
	bO5gI/jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNFc6-0000000Adyo-1zsT;
	Sun, 23 Nov 2025 19:19:10 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNFc3-0000000Adx7-41bG
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 19:19:09 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3202488a12.3
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 11:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763925547; x=1764530347; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKJ3Ki80LpfNfoODAHioJMPRhlPCzuiQDXTG6g2MQu8=;
        b=TWLSGs/tuXIkYXJYvT6hjs6jzDKkeZZtf4Uf4RbH8wGpdsmfGWyzweAAbnxPe14LQI
         bDa4/IEr0tNNMQsTjrSnipfrDW5zziNE5buDfEqEKln8Lkg474v/DZf9IRj7dn05R19g
         25PmpyuGSuo/ZAyvTjN+J2X+neUuCfNe9CpE7j16g6hckqZY50Ds2xL6Ocm4oYTHsmCr
         /pd75Ir6YyNjXrEkh9mMK2l2ORHnoOlLpUpPB5qc+Tc5SS5w1fvbd152EpCq4RKWuv82
         LFK8cPUCdeor5Jc5mWs300R0Ulm5aKmlXtvm/YWJ0Ngmso5bME/tbGKL4MPghPcNFEue
         UcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763925547; x=1764530347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JKJ3Ki80LpfNfoODAHioJMPRhlPCzuiQDXTG6g2MQu8=;
        b=eNboRiwq73gQ7JGdFC4NpJiU2oY/PlTBphhTrRThqUqAOCx7kiAftjGNuNequJ+wyB
         rwfSjjMK4VaLIhaxHWN9zJwzIwtb9nQ1mvMBD1J/TrbcawclVpsCjvEJ1DqKzEW0dfKg
         4tm7GNYvJCgXoJKBnzM77VWO3ncOYlnOZPbotZQu+VsCVUV0FkegrgkEHkQLHmbgjcHs
         txlv8lKQ7a9A9WtUqHdeoMmp+Kl2k2iDYyhrChRKx1pvQvXMkCMt8j3UTklGQCuJ2dA1
         RxdapU48Vck4qbWmjctK4x/xQ14E7tcdrlGHw7LUh0Lc3AXUq5SO/t9TEPHTFF4UHwQa
         oNQA==
X-Gm-Message-State: AOJu0YyD5U1z+7eUp4KqX8kUe3oKrwZSYQ2V62IjbMaKlK8MtFaFr2G+
	dPeihDePWW7TLA5xWkR2wdM3BQ91GOjc9IuPQD2+JUbkeNJxTBoJ/H/W
X-Gm-Gg: ASbGncsXf3bqAW8lLtFANgtxjpeG92+X9lc/k72qRYsj9sg+i/7hTi8kctk+ExAQcB5
	C+/kvRQKNLgqdjDC5oQW/KV0xbC9JHbqmYNewrY1unU5aYAAA/g8S6eFJ7O6P9hE9NmxHXqY027
	9NT1/wiBax6jUTD3Cvf3e56tnVbkFyNPXY08qBp6u3maQH+bDMh/ilG8iZgI9W19JNtFj5U+sSV
	VNcPxKjMhbPTW7SwTmOzyxPx7UEtv87rTpyB9LvojTSZ1ZlnopyeeR9/ZkWgzT8seAfg5SmukiW
	t8MhyHLBIMrd8xO6m7IhO2u3cBxY9MKwQAun/2cIJYcUsZAy7TBia1HW9TSTSf4xPNDsppJoYSP
	Ejz8HE53pdJEDYAG3dEdXW/7GCrfa330fqKgXHnXSzMvWOiRDwiro+7ZTbYKUTsQHAqYl0djN+X
	vLZ1uZkAsi5pCX40hT19QouVTcZCZMAqb2nXtxs/lm4eh/f74=
X-Google-Smtp-Source: AGHT+IElS5lM1wQgTuHHXkg7XUfZm2fMUzhEa+dMv3LcySWjKS4NEDq1uMo3ggIhZgzBhaKxCAq2Qw==
X-Received: by 2002:a05:7300:bc0b:b0:2a4:3593:6472 with SMTP id 5a478bee46e88-2a7192e5cb2mr6226671eec.34.1763925546957;
        Sun, 23 Nov 2025 11:19:06 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc5e3750sm40258337eec.6.2025.11.23.11.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 11:19:06 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH BUG FIX 2/2] nvme-multipath: clear BIO_QOS flags on requeue
Date: Sun, 23 Nov 2025 11:18:58 -0800
Message-Id: <20251123191858.69957-3-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251123191858.69957-1-ckulkarnilinux@gmail.com>
References: <20251123191858.69957-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_111908_016970_FA8C82C6 
X-CRM114-Status: GOOD (  17.84  )
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

When a bio goes through the rq_qos infrastructure on a path's request
queue, it gets BIO_QOS_THROTTLED or BIO_QOS_MERGED flags set. These
flags indicate that rq_qos_done_bio() should be called on completion
to update rq_qos accounting.

During path failover in nvme_failover_req(), the bio's bi_bdev is
redirected from the failed path's disk to the multipath head's disk
via bio_set_dev(). However, the BIO_QOS flags are not cleared.

When the bio eventually completes (either successfully via a new path
or with an error via bio_io_error()), rq_qos_done_bio() checks for
these flags and calls __rq_qos_done_bio(q->rq_qos, bio) where q is
obtained from the bio's current bi_bdev - which is now the multipath
head's queue, not the original path's queue.

The multipath head's queue does not have rq_qos enabled (q->rq_qos is
NULL), but the code assumes that if BIO_QOS_* flags are set, q->rq_qos
must be valid. This assumption is documented in block/blk-rq-qos.h:

  "If a bio has BIO_QOS_xxx set, it implicitly implies that
   q->rq_qos is present."

This breaks when a bio is moved between queues during NVMe multipath
failover, leading to a NULL pointer dereference.

Execution Context timeline :-

   * =====> dd process context
   [USER] dd process                                
     [SYSCALL] write() - dd process context           
       submit_bio()                              
       nvme_ns_head_submit_bio() - path selection
       blk_mq_submit_bio()  #### QOS FLAGS SET HERE
                                                  
        [USER] dd waits or returns                       
                                                  
          ==== I/O in flight on NVMe hardware =====

   ===== End of submission path ====
   ------------------------------------------------------
   
   * dd ====> Interrupt context;
   [IRQ] NVMe completion interrupt              
       nvme_irq()                                
        nvme_complete_rq()                        
         nvme_failover_req() ### BIO MOVED TO HEAD 
            spin_lock_irqsave (atomic section)    
            bio_set_dev() changes bi_bdev         
            ### BUG: QOS flags NOT cleared          
            kblockd_schedule_work()                   
                                                   
   * Interrupt context =====> kblockd workqueue
   [WQ] kblockd workqueue - kworker process         
       nvme_requeue_work()                       
        submit_bio_noacct()                       
         nvme_ns_head_submit_bio()                 
          nvme_find_path() returns NULL             
           bio_io_error()                            
            bio_endio()                               
             rq_qos_done_bio()  ### CRASH ###
                                                   
   KERNEL PANIC / OOPS       

Crash from blktests nvme/058 (rapid namespace remapping):

[ 1339.636033] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1339.641025] nvme nvme4: rescanning namespaces.
[ 1339.642064] #PF: supervisor read access in kernel mode
[ 1339.642067] #PF: error_code(0x0000) - not-present page
[ 1339.642070] PGD 0 P4D 0
[ 1339.642073] Oops: Oops: 0000 [#1] SMP NOPTI
[ 1339.642078] CPU: 35 UID: 0 PID: 4579 Comm: kworker/35:2H
               Tainted: G   O     N  6.17.0-rc3nvme+ #5 PREEMPT(voluntary)
[ 1339.642084] Tainted: [O]=OOT_MODULE, [N]=TEST
[ 1339.673446] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
	       BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[ 1339.682359] Workqueue: kblockd nvme_requeue_work [nvme_core]
[ 1339.686613] RIP: 0010:__rq_qos_done_bio+0xd/0x40
[ 1339.690161] Code: 75 dd 5b 5d 41 5c c3 cc cc cc cc 66 90 90 90 90 90 90 90
                     90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 f5
		     53 48 89 fb <48> 8b 03 48 8b 40 30 48 85 c0 74 0b 48 89 ee
		     48 89 df ff d0 0f 1f
[ 1339.703691] RSP: 0018:ffffc900066f3c90 EFLAGS: 00010202
[ 1339.706844] RAX: ffff888148b9ef00 RBX: 0000000000000000 RCX: 0000000000000000
[ 1339.711136] RDX: 00000000000001c0 RSI: ffff8882aaab8a80 RDI: 0000000000000000
[ 1339.715691] RBP: ffff8882aaab8a80 R08: 0000000000000000 R09: 0000000000000000
[ 1339.720472] R10: 0000000000000000 R11: fefefefefefefeff R12: ffff8882aa3b6010
[ 1339.724650] R13: 0000000000000000 R14: ffff8882338bcef0 R15: ffff8882aa3b6020
[ 1339.729029] FS:  0000000000000000(0000) GS:ffff88985c0cf000(0000) knlGS:0000000000000000
[ 1339.734525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1339.738563] CR2: 0000000000000000 CR3: 0000000111045000 CR4: 0000000000350ef0
[ 1339.742750] DR0: ffffffff845ccbec DR1: ffffffff845ccbed DR2: ffffffff845ccbee
[ 1339.745630] DR3: ffffffff845ccbef DR6: 00000000ffff0ff0 DR7: 0000000000000600
[ 1339.748488] Call Trace:
[ 1339.749512]  <TASK>
[ 1339.750449]  bio_endio+0x71/0x2e0
[ 1339.751833]  nvme_ns_head_submit_bio+0x290/0x320 [nvme_core]
[ 1339.754073]  __submit_bio+0x222/0x5e0
[ 1339.755623]  ? rcu_is_watching+0xd/0x40
[ 1339.757201]  ? submit_bio_noacct_nocheck+0x131/0x370
[ 1339.759210]  submit_bio_noacct_nocheck+0x131/0x370
[ 1339.761189]  ? submit_bio_noacct+0x20/0x620
[ 1339.762849]  nvme_requeue_work+0x4b/0x60 [nvme_core]
[ 1339.764828]  process_one_work+0x20e/0x630
[ 1339.766528]  worker_thread+0x184/0x330
[ 1339.768129]  ? __pfx_worker_thread+0x10/0x10
[ 1339.769942]  kthread+0x10a/0x250
[ 1339.771263]  ? __pfx_kthread+0x10/0x10
[ 1339.772776]  ? __pfx_kthread+0x10/0x10
[ 1339.774381]  ret_from_fork+0x273/0x2e0
[ 1339.775948]  ? __pfx_kthread+0x10/0x10
[ 1339.777504]  ret_from_fork_asm+0x1a/0x30
[ 1339.779163]  </TASK>

Fix this by clearing both BIO_QOS_THROTTLED and BIO_QOS_MERGED flags
when bios are redirected to the multipath head in nvme_failover_req().
This is consistent with the existing code that clears REQ_POLLED and
REQ_NOWAIT flags when the bio changes queues.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3da980dc60d9..2535dba8ce1e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -168,6 +168,16 @@ void nvme_failover_req(struct request *req)
 		 * the flag to avoid spurious EAGAIN I/O failures.
 		 */
 		bio->bi_opf &= ~REQ_NOWAIT;
+		/*
+		 * BIO_QOS_THROTTLED and BIO_QOS_MERGED were set when the bio
+		 * went through the path's request queue rq_qos infrastructure.
+		 * The bio is now being redirected to the multipath head's
+		 * queue which may not have rq_qos enabled, so these flags are
+		 * no longer valid and must be cleared to prevent
+		 * rq_qos_done_bio() from dereferencing a NULL q->rq_qos.
+		 */
+		bio_clear_flag(bio, BIO_QOS_THROTTLED);
+		bio_clear_flag(bio, BIO_QOS_MERGED);
 	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-- 
2.40.0


