Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789BA606A32E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WeMcTsC1;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l5yL5YkG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=TUvmNpEjL2OGIfZWUlDmLtIp8EJ0dgC2oC8n5gcLikw=; b=WeMcTsC11NcALGEZVXXCzx+jA0
	xg1qBzJVqY4A+l1RiHnHJsqCz85vjlt3KeTl512zzOXQcZh5AoKl0pwS+bUiy10qWdCNrCIsGR9Uu
	GRHrUzbP9cNDBI2N7x1k0zA3U5a/joNkAYpGi82jUwEI7UHoBQ6GenGtRZ5n1b6iyyJO4NmIjBmqs
	g5m+Eo1eIGRLm2zooNN/fTFPxSEu0noExOR7gTHToEPowr2DwfG6O65MeyPyLEWThM6Q58A+iqOvk
	iuREUq5Igz3KG0whJB3k2TqyRco1a7brA9WE+MJyEqNMDPWiFKVh6CI9Q++a7XcPQ/ogo3or1ltsl
	BG47Gfrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWC3Y-00000009oo1-2dsr;
	Wed, 25 Nov 2026 12:25:00 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWC3V-00000009omF-2DNY
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 12:24:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795609493; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TUvmNpEjL2OGIfZWUlDmLtIp8EJ0dgC2oC8n5gcLikw=;
	b=l5yL5YkGAcEo27eTEPGpZQQC3ius4YLAimDqeGOo7HoiMTdeXqNS3K2HCdeGMdzJRSzSxpCoqSal0vl3evP6OC8Yoblr5ecXzdotSEHuWbUYMXEhocKwQAR+9EfZJTpol3Trp7lAfIkEHbcYQ7qgtS8TduSJCLEvnIfquu+y9Pg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFRi.-x_1795609492;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFRi.-x_1795609492 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 20:24:53 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme-multipath: serialize ana_log_buf lifecycle with ana_lock
Date: Wed, 25 Nov 2026 20:24:46 +0800
Message-ID: <20261125122446.1122253-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_042458_088167_94254AD3 
X-CRM114-Status: GOOD (  19.47  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_parse_ana_log() reads ctrl->ana_log_buf and ctrl->ana_log_size
under ctrl->ana_lock, but the buffer lifecycle is not fully serialized
against it:

 - nvme_mpath_uninit() frees the buffer without ana_lock, so a
   concurrent parser in nvme_mpath_add_disk() can use freed memory.
 - nvme_mpath_init_identify() reallocates the buffer and updates
   ana_log_size outside ana_lock. nvme_mpath_add_disk() tests
   nvme_ctrl_use_ana() before taking the lock, so it can pass the check
   and then dereference a NULL buffer after nvme_mpath_uninit() cleared
   it; and the freshly allocated buffer can be parsed before
   nvme_read_ana_log() populates it, reading uninitialized memory.

Take ana_lock around the buffer release in nvme_mpath_uninit() and
around the reallocation in nvme_mpath_init_identify(), updating
ana_log_buf and ana_log_size together so a parser never observes a
freed or NULL buffer or a stale size. Allocate the new buffer outside
the lock and zero it, so a parser running before nvme_read_ana_log()
populates it sees ngrps == 0. nvme_parse_ana_log() also bails out when
the buffer is NULL, covering the teardown paths. Keep the ana_work
drain outside the lock: ana_work itself takes ana_lock, so cancelling
it under the lock would deadlock.

Fixes: 0d0b660f214d ("nvme: add ANA support")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Reported by Sashiko AI review as a pre-existing issue. Confirmed by
source analysis and reproduced in a KASAN guest with nvmet-tcp loopback
and ANA enabled.

The race is in the reallocation path: nvme_mpath_init_identify() frees
the old buffer through nvme_mpath_uninit() before taking ana_lock in
nvme_read_ana_log(). The FROZEN guard does not close the window: a tcp
reset runs nvme_init_identify() (configure_admin_queue) before
nvme_start_freeze() (configure_io_queues), and reset does not flush
scan_work.

Reproduction (test-only delays + forced ANA-log growth):
 - use-after-free: buffer address tracking shows nvme_mpath_uninit()
   freeing the old ana_log_buf while nvme_parse_ana_log() still
   dereferences it (the new buffer lands at a different address).
 - NULL dereference: widening the window between nvme_mpath_uninit()
   and the reallocation makes nvme_mpath_add_disk() pass
   nvme_ctrl_use_ana() and then parse a NULL buffer; without the fix
   this faults in nvme_parse_ana_log() (buf register NULL).
 - uninitialized read: the new buffer is parsed before
   nvme_read_ana_log() populates it.
With the fix the buffer pointer and ana_log_size are swapped atomically
under ana_lock (a parser sees neither a freed nor a NULL buffer), the
new buffer is zeroed (ngrps == 0 before population), and
nvme_parse_ana_log() bails out on NULL; none of the three windows fault.
ANA change/optimized transitions and multipath I/O remain unaffected.

Changes since v1:
 - serialize the reallocation swap (buffer pointer and ana_log_size)
   under ana_lock, allocating the new buffer outside the lock, so a
   parser never observes a freed or NULL buffer; also bail out of
   nvme_parse_ana_log() when ana_log_buf is NULL and zero the
   reallocated buffer. v1 only serialized the free, leaving a NULL
   dereference window (nvme_mpath_add_disk() tests nvme_ctrl_use_ana()
   outside ana_lock) and an uninitialized-memory read before
   nvme_read_ana_log() populates the new buffer (Sashiko AI review)

v1: https://lore.kernel.org/all/20261125060153.206699-1-kanie@linux.alibaba.com/

 drivers/nvme/host/multipath.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3685c792181b..ee4500dbae5b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -889,6 +889,9 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 
 	lockdep_assert_held(&ctrl->ana_lock);
 
+	if (!ctrl->ana_log_buf)
+		return 0;
+
 	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
 		struct nvme_ana_group_desc *desc = base + offset;
 		u32 nr_nsids;
@@ -1622,13 +1625,22 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		goto out_uninit;
 	}
 	if (ana_log_size > ctrl->ana_log_size) {
+		void *buf;
+
 		nvme_mpath_stop(ctrl);
-		nvme_mpath_uninit(ctrl);
-		ctrl->ana_log_buf = kvmalloc(ana_log_size, GFP_KERNEL);
-		if (!ctrl->ana_log_buf)
+		buf = kvzalloc(ana_log_size, GFP_KERNEL);
+		if (!buf)
 			return -ENOMEM;
+		mutex_lock(&ctrl->ana_lock);
+		kvfree(ctrl->ana_log_buf);
+		ctrl->ana_log_buf = buf;
+		ctrl->ana_log_size = ana_log_size;
+		mutex_unlock(&ctrl->ana_lock);
+	} else {
+		mutex_lock(&ctrl->ana_lock);
+		ctrl->ana_log_size = ana_log_size;
+		mutex_unlock(&ctrl->ana_lock);
 	}
-	ctrl->ana_log_size = ana_log_size;
 	error = nvme_read_ana_log(ctrl);
 	if (error)
 		goto out_uninit;
@@ -1648,7 +1660,9 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 	 */
 	cancel_work_sync(&ctrl->ana_work);
 
+	mutex_lock(&ctrl->ana_lock);
 	kvfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = NULL;
 	ctrl->ana_log_size = 0;
+	mutex_unlock(&ctrl->ana_lock);
 }
-- 
2.43.7


