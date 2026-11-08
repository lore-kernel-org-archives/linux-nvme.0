Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF5606D836
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FevNqhoe;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cIGgOEoy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=D+bQhpD+WSSIraJnCjz2Iq12MaRnWIXb3SJNp+9C77c=; b=FevNqhoe6yccPd
	uy0eDSc3ofZTKpBbmQxWZpR0578FQJlMiQ1kaXHo2wxAWE2mHEIQpzj7cE8Gu5RuZVCjX6bhGJC0t
	Hp2bsgxWjEexy1ngjFJyL/ykQHimEP4i1vO3508WyvX7V34EqWVkcHboC7wm8vUk5pUaDSwiDOoNi
	FU0EYfc/KUMgOUnN+omG3/YqijoU2/J4RLUsXKQA1jwPlZuQwWuuhEz9YdbVU6tzYob9o3hymJNBZ
	r8YCaWF+pIylStfjeD4/rIJVZ6wDgAgJwuFspEkUbfCIiiQBrZL6DR8S3EE3aK3OZgBSuvAFqBAKP
	yyCucmJRb73SZUyT7+hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oQ-0000000GcQe-1EaE;
	Sun, 08 Nov 2026 20:48:26 +0000
Received: from out-189.mta0.migadu.com ([2001:41d0:1004:224b::bd] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oH-0000000Gc0l-1JoM
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:25 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=YyW1RuL9yvQgmJEET/4NGirmk+hqjG05wn7wJajP8N4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170895; v=1; x=1794775695;
 b=cIGgOEoy1ufqEv1YU0oMqMHdURHor9uWsg9yfLGSzxb1+8wuZOxyQYjl/+mJ0byfLzgqnYqf
 9X17K191+HjMh8TgVMs9vUdICWj2hBWxZSkyQWW0HAyLPBKOvNyhzJQHsUJIPseeG9zHJs/2R6X
 nb8Ql9bf69JXzocE4vsbkBA4=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id c1e933660bf6bd0f;
	Sun, 08 Nov 2026 20:48:15 +0000
X-Mizu-Trace-ID: c1e933660bf6bd0f
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: james.bottomley@hansenpartnership.com,
	mkp@kernel.org
Cc: hare@suse.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	snitzer@kernel.org,
	jmeneghi@redhat.com,
	bmarzins@redhat.com,
	dm-devel@lists.linux.dev,
	hch@lst.de,
	michael.christie@oracle.com,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v9 17/29] scsi-multipath: clear path when device is blocked
Date: Sun,  8 Nov 2026 20:47:21 +0000
Message-ID: <20261108204733.557995-18-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124817_505597_D9C88369 
X-CRM114-Status: GOOD (  12.72  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add scsi_mpath_dev_clear_path() to clear a device path when it becomes
blocked.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_lib.c       |  3 +++
 drivers/scsi/scsi_multipath.c | 10 ++++++++++
 include/scsi/scsi_multipath.h |  5 +++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 36bc995e4e25..1950034f580f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -35,6 +35,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport.h> /* scsi_init_limits() */
 #include <scsi/scsi_dh.h>
+#include <scsi/scsi_multipath.h>
 
 #include <trace/events/scsi.h>
 
@@ -3037,6 +3038,8 @@ static void scsi_device_block(struct scsi_device *sdev, void *data)
 		scsi_stop_queue(sdev);
 
 	mutex_unlock(&sdev->state_mutex);
+	if ((err == 0) && sdev->scsi_mpath_dev)
+		scsi_mpath_dev_clear_path(sdev->scsi_mpath_dev);
 
 	WARN_ONCE(err, "%s: failed to block %s in state %d\n",
 		  __func__, dev_name(&sdev->sdev_gendev), state);
diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 8e229357e62c..67e9010d5478 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -240,6 +240,16 @@ static int scsi_multipath_sdev_init(struct scsi_device *sdev)
 	return 0;
 }
 
+void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev)
+{
+       struct mpath_device *mpath_device = &scsi_mpath_dev->mpath_device;
+       struct scsi_mpath_head *scsi_mpath_head = scsi_mpath_dev->scsi_mpath_head;
+       struct mpath_head *mpath_head = &scsi_mpath_head->mpath_head;
+
+       if (mpath_clear_current_path(mpath_device))
+               mpath_synchronize(mpath_head);
+}
+
 static void scsi_mpath_clone_end_io(struct bio *clone)
 {
 	struct bio *master_bio = clone->bi_private;
diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
index d2ef94ebd29a..2064a3e92274 100644
--- a/include/scsi/scsi_multipath.h
+++ b/include/scsi/scsi_multipath.h
@@ -55,6 +55,7 @@ int scsi_mpath_try_get_head(struct scsi_mpath_head *scsi_mpath_head);
 void scsi_mpath_put_head(struct scsi_mpath_head *scsi_mpath_head);
 void scsi_mpath_add_sysfs_link(struct scsi_device *sdev);
 void scsi_mpath_remove_sysfs_link(struct scsi_device *sdev);
+void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev);
 #else /* CONFIG_SCSI_MULTIPATH */
 
 struct scsi_mpath_head {
@@ -99,5 +100,9 @@ static inline void scsi_mpath_add_sysfs_link(struct scsi_device *sdev)
 static inline void scsi_mpath_remove_sysfs_link(struct scsi_device *sdev)
 {
 }
+static inline
+void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev)
+{
+}
 #endif /* CONFIG_SCSI_MULTIPATH */
 #endif /* _SCSI_SCSI_MULTIPATH_H */
-- 
2.43.0


