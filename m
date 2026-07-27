Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD03DC53209
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 20:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tPyqnKihTlQFHdssVMVemAlIRLl39sgkift01DFBxTc=; b=og+xxpdYsAagztw/J6ODXh0wqI
	qFlHzUt4zW6xuc7UO8UzIBv4AtWq2YRCtQr35+tL6jA7O1/hAgixbPafZvI8ZcDEHJ4VXyi4PNIOD
	G6knarmQ37pLe4Dd/iSL1Y7+YfsYElgd4OxcfyPFX2Z+iXUGRa0dDG74LdLL/tO8ZvnqrKqQz/zsP
	JIAxdOvHsQNN3rs/PKuDxed2LJD5jhKK+gdmZOI7mD0dM3ThiZsuSo7oSDIhpBzfmQoGGR33Nh9KK
	Rz5tHsRCHusc2V1UkdJ2WxdGV62f3v5+NgbQ98W35FqJSukRSxhT8A84gOUjlDMSeso6etc8ach3C
	akeb8xxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRh8-00000003oU1-3JSe;
	Mon, 27 Jul 2026 20:13:02 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRh6-00000003oSw-1HPH
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 20:13:01 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-81dfdbd86d1so29205767b3.1
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2026 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785183179; x=1785787979; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tPyqnKihTlQFHdssVMVemAlIRLl39sgkift01DFBxTc=;
        b=HdYbJNtel31KPDyz+0rdWklc9Zjnc94RUhVAF9lql/VYY1xEWX2T7yI7lIBPoLTqj4
         xrG4Q1LGqbOYiNAC8R0irmXXiFTuHwjTkx0nGT1ht+6AcqWN4+AoLm8UIVNlSpXKOlRr
         UemjXkr83WJqAGr3nZSeZzXjM8FJbHg0mAK4XLHrVlLAuL43CrqQKN28tQCLOVojA9FF
         ckmozIwUQGBOrzFwqozBAGkVWM/LHR4d8zysuvnp6O8sIzPVtqW5Ut71TWiZx/MJjzJW
         Iu2PIA8CkHilFqYUy84NUvvvej6KFEzslKTqKS2DoDIb8ESM+9ubb0yHvmiqEuuf39qq
         iSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785183179; x=1785787979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tPyqnKihTlQFHdssVMVemAlIRLl39sgkift01DFBxTc=;
        b=NZrw7gFM3d0JNGG/trUVzSf3sY7l1q2+O3nQTyeQy96f0MOl7rbhWX7PwNnHdijVN5
         AvSxJO0e++xrrKEnAZp/+RwNOrGDYwSXIt0EK4AZCO/1GgKos2Xnro2i1pVyTQu0vAUG
         HSVKShC3L4yF/tMuvKpIoGgCM2O2+xv1poFI/rfpORiLTJKRkxTk3Rk1xt+wpaMLknzt
         qy+Y+M7qGOw1m8q35x59Xn+2m61S0Bpm+WJ88ZNyLLJHS7kO1kNhTuzqmAqQtRne8DPp
         BB9UIFC+fSJxEheNIsd6bOKwhALhkC3jYboxKALou61eP1QBX4Phtk+YvKDjw0H9fTJR
         C3AQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYnT8elluM/MpmgKj+lJFVNnFu3ieaJHvA76KZwwMsZ9MqmqF2xQ4cnnDaFxdhBIPZYVKYye3I8c/E@lists.infradead.org
X-Gm-Message-State: AOJu0Yzmb8P6jtaPnUwYdYHC+lYJko0PBOqrLyjdkobs+o/YRaO6h90c
	+5920GBTopoUdct2/WaigGvKfTXMRuNG9ZcQux2Cf1owJJdFUdtHApEr
X-Gm-Gg: AR+sD13CKvuqQm86tSpkqZubn6/E/Aad1ko2vSmrQGegyU/Stlsu3huOtX0BYAit3IL
	PUolXxQPs4x/KQbfreSmZLGQKqrpbC+4El3o4YkpUcBONM0fEJsbaHfYklzdOxa/X1Zo7n+p3YI
	8FfpbIhftgAtppCJcxwyZLASgXfJyBLLwC7SskMX6YyhYe/07Zb7oNf4H/gCZT9Tc8Q4tjM4Uhg
	t6tontu8GqpmljqWrZ/TOVpx83lJTzSJboLogjM7Jx9BxR9D1TRQqdXVuu/IwGJ7GhTPaeBIKLA
	sQ+1Lq+9U8cpzW9zU5FzmK/Jaidnf/wPkOiD4FCANKmnkzxWoUc1iX6nBVFAOWXlxSZoc82rgmh
	4Cd/V4fjC/V8yCW7FPoFQgBYpjBiSUqp5JTz5ZjqZhT7jk89aTnjAsOmjBarvs+jlWlabsb6R7F
	/M2g0hfYAeLLF8eNn9Rr20
X-Received: by 2002:a05:690c:6f13:b0:812:a680:e10d with SMTP id 00721157ae682-81f69cdcb6cmr36911227b3.12.1785183178724;
        Mon, 27 Jul 2026 13:12:58 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6592ec1asm36564237b3.45.2026.07.27.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:12:58 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Weidong Zhu <weizhu@fiu.edu>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: stop the timeout timer when releasing a never added disk
Date: Mon, 27 Jul 2026 16:12:57 -0400
Message-ID: <20260727201257.211635-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_131300_375541_2AB26AAD 
X-CRM114-Status: GOOD (  17.51  )
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

disk_release() undoes blk_mq_init_allocated_queue() for a disk whose
probe failed before add_disk(), but it only calls blk_mq_exit_queue().
Nothing there stops q->timeout, and that timer rolls forward: it stays
pending until it next expires, not until the last request completes.
So if the driver issued any I/O before adding the disk, the
request_queue is freed while still linked into a timer wheel bucket.

Commit 6f8191fdf41d ("block: simplify disk shutdown") dropped the
blk_cleanup_queue() call that used to stop it.  __del_gendisk() and
blk_mq_destroy_queue() still do; only the probe failure path lost it.

nvme gets there because nvme_update_ns_info() submits Report Zones or
FDP io-mgmt-recv on ns->queue before the disk is added, so a later
failure - a concurrent reset setting NVME_CTRL_FROZEN, or
device_add_disk() failing - lands in put_disk() with the timer armed:

  BUG: KASAN: slab-use-after-free in detach_if_pending+0x30c/0x340
  Write of size 8 at addr ffff888004d71310 by task kworker/u8:2/37
   __timer_delete_sync+0x156/0x240 kernel/time/timer.c:1621
   blk_sync_queue+0x22/0x40 block/blk-core.c:222
   nvme_sync_queues+0x100/0x150 drivers/nvme/host/core.c:5362
   nvme_reset_work+0x138/0x930 drivers/nvme/host/pci.c:3264

  Allocated by task 34:
   __blk_mq_alloc_disk+0x33/0x100 block/blk-mq.c:4462
   nvme_alloc_ns+0x290/0x3870 drivers/nvme/host/core.c:4146

  Freed by task 0:
   blk_free_queue_rcu+0x3a/0x50 block/blk-core.c:254
   rcu_core+0xc10/0x1730 kernel/rcu/tree.c:2857

The queue being synced there is ctrl->admin_q, only a victim sharing a
timer wheel bucket with the freed queue's dangling entry; other runs
tripped in enqueue_timer(), __run_timers() or blk_mq_timeout_work().
Failing nvme_alloc_ns() with a debug patch makes it deterministic: one
leaked timer trips KASAN within seconds, while 1987 patched releases
produced no splat.

Stop the timer and the queue work items before blk_mq_exit_queue(), like
blk_mq_destroy_queue() does.

Found by FuzzNvme.

Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 block/genhd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index df2c3c69b467..e8ce0cabf392 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1281,14 +1281,18 @@ static void disk_release(struct device *dev)
 	/*
 	 * To undo the all initialization from blk_mq_init_allocated_queue in
 	 * case of a probe failure where add_disk is never called we have to
-	 * call blk_mq_exit_queue here. We can't do this for the more common
-	 * teardown case (yet) as the tagset can be gone by the time the disk
-	 * is released once it was added.
+	 * call blk_mq_exit_queue here, after stopping the timer and work items
+	 * that I/O issued before add_disk may have left pending.  We can't do
+	 * this for the more common teardown case (yet) as the tagset can be
+	 * gone by the time the disk is released once it was added.
 	 */
 	if (queue_is_mq(disk->queue) &&
 	    test_bit(GD_OWNS_QUEUE, &disk->state) &&
-	    !test_bit(GD_ADDED, &disk->state))
+	    !test_bit(GD_ADDED, &disk->state)) {
+		blk_sync_queue(disk->queue);
+		blk_mq_cancel_work_sync(disk->queue);
 		blk_mq_exit_queue(disk->queue);
+	}
 
 	blkcg_exit_disk(disk);
 
-- 
2.43.0


