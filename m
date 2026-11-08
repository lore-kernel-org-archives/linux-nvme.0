Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCEB606D822
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RhgTZrss;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=MjVvSmRa;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CENeaFWz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Hx91sDACoJ7abAEOBHgQJI8JsvMH0QoUw+b4k5ePTNA=; b=RhgTZrss3bXk6k
	0C55W8vUM/nv8uKK8aM542z2z0U2FO4pOuFSuUFu0W4u87BOS40lg1bz0ubSTlns8cGBXl/H2ib15
	I0Psc27oEuF/r10Yj9RiJ/uA02spNYFSF9Wv5N3z3KbPjtHS2JBKHSAzo1RPMASYgodPKaoJhv4Q7
	x3qcj91oiJjySbMPjlkiQTnoLYMUOv9bhbAY7rWtldnMSevMed9jFKQoFtGK+wyfRO3J4oT2Eb+Od
	wS04R2QamPw8Hs/i6eA27+iAP3taIZk4Vx6I027h97slsermiKUMrszuTbJ+dAoLYWZy69GlPE0Fx
	1EoxUD/T+bvcxW1JL9aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oN-0000000GcKB-2to2;
	Sun, 08 Nov 2026 20:48:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oM-0000000GcHd-45up
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Nov 2026 20:48:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Hx91sDACoJ7abAEOBHgQJI8JsvMH0QoUw+b4k5ePTNA=; b=MjVvSmRamAng7Yy7vyCNVxt0pq
	wtns+JogrXM6GzdW76Sv7N18ikgJnfG1GNsQL3MBDOWHqPotGKnlqrDRe1P2CLDOxmekBtDwWpETL
	PVplefra9c0030aubWUuJBVRLNzAD5dvn+cfUZrcPN8lusK+Du+4m9TFmjv5AJg557oEssfeCSUNn
	cS9pFEqWzeWfL7cJPNHED8RdwiRJHv7E3Y+Ue1w1sBMkxfKwfPLEwdK2bTUgDPPuYjTehzi2fwklg
	1r4H9SsZNXfG7yuAe7HkdJtpb6XObDigNc2AxjzAsGRPKc9qliHKfxXDlq8fIXhHrfM3qv6qqwsO8
	TorP2ZdQ==;
Received: from out-119.mta1.migadu.com ([95.215.58.119] helo=mta1.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oJ-000000060GX-1GWH
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:20 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=9d0oDkXwv97bvGSfI+N7Mhx767pQo6f0Hyy+dkcnP7c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170898; v=1; x=1794775698;
 b=CENeaFWz7VxpzbrU1DAKXWhTzDiaftiZeLA5RF7qqWvYfDUgJb5y0A4GgEp+eh2+k5P8eUO2
 TwGPy2L6zHGFn9FdJBw3WzNFFOzX0QSJyBwYO/Y8r3qAruL0mZ/cQvd2+k3kZslCE1418SlWCoR
 x5QyaghTmlSp0koGvoNZHDo4=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 83e0669b2846038b;
	Sun, 08 Nov 2026 20:48:18 +0000
X-Mizu-Trace-ID: 83e0669b2846038b
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
Subject: [PATCH v9 18/29] scsi-multipath: revalidate paths upon device unblock
Date: Sun,  8 Nov 2026 20:47:22 +0000
Message-ID: <20261108204733.557995-19-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_204819_471685_A5947D1F 
X-CRM114-Status: GOOD (  12.14  )
X-Spam-Score: -0.2 (/)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a scsi_device is unblocked, we need revalidate paths which means that
we clear paths and requeue any queued bios.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_lib.c       | 2 ++
 drivers/scsi/scsi_multipath.c | 8 ++++++++
 include/scsi/scsi_multipath.h | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1950034f580f..4dbd01484b4a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3121,6 +3121,8 @@ static int scsi_internal_device_unblock(struct scsi_device *sdev,
 	mutex_lock(&sdev->state_mutex);
 	ret = scsi_internal_device_unblock_nowait(sdev, new_state);
 	mutex_unlock(&sdev->state_mutex);
+	if ((ret == 0) && sdev->scsi_mpath_dev)
+		scsi_mpath_revalidate_paths(sdev->scsi_mpath_dev);
 
 	return ret;
 }
diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 67e9010d5478..008bcafe73ad 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -240,6 +240,14 @@ static int scsi_multipath_sdev_init(struct scsi_device *sdev)
 	return 0;
 }
 
+void scsi_mpath_revalidate_paths(struct scsi_mpath_device *scsi_mpath_dev)
+{
+       struct scsi_mpath_head *scsi_mpath_head = scsi_mpath_dev->scsi_mpath_head;
+       struct mpath_head *mpath_head = &scsi_mpath_head->mpath_head;
+
+       mpath_revalidate_paths(mpath_head);
+}
+
 void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev)
 {
        struct mpath_device *mpath_device = &scsi_mpath_dev->mpath_device;
diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
index 2064a3e92274..6e50da94fc5d 100644
--- a/include/scsi/scsi_multipath.h
+++ b/include/scsi/scsi_multipath.h
@@ -56,6 +56,7 @@ void scsi_mpath_put_head(struct scsi_mpath_head *scsi_mpath_head);
 void scsi_mpath_add_sysfs_link(struct scsi_device *sdev);
 void scsi_mpath_remove_sysfs_link(struct scsi_device *sdev);
 void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev);
+void scsi_mpath_revalidate_paths(struct scsi_mpath_device *scsi_mpath_dev);
 #else /* CONFIG_SCSI_MULTIPATH */
 
 struct scsi_mpath_head {
@@ -104,5 +105,9 @@ static inline
 void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev)
 {
 }
+static inline
+void scsi_mpath_revalidate_paths(struct scsi_mpath_device *scsi_mpath_dev)
+{
+}
 #endif /* CONFIG_SCSI_MULTIPATH */
 #endif /* _SCSI_SCSI_MULTIPATH_H */
-- 
2.43.0


