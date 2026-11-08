Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95020606D81A
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=x9rsH6ez;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=STCqHCKo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2nnhEenE0/1GT2EDac2uSW/ypInHmlgcoWTshjS2obA=; b=x9rsH6ez5diXoo
	fbTVfJ+bStLPMAjeqixoCTBtGouaGUHWY2Jcy9EC78X7rUy3qe80Qvc8ZZRqOXVhGPV8qOfj6E8cV
	XB6sj0vQtWxmXKrSY7+xF8IOWMCUYt1ra9NwU4WHrvDu0jPq/DUauXEIO8KeGh8i80kBLi4cDirF0
	JFngsnEjpBEZ3sWhaZ5kkP/pxRnPqiIh27R6Z1bxofEOCHDnPXREuVHhS37wO6aJwF3gFl8DTowv7
	GqeIigtZhtbuU8ICcsgwOdE3aFNiDRbUFbQUxg2KxThiLwwfT+noogKvX7xfHTkLBa/E+3h5/Uv7X
	+EpgO/ryDQLlynV7tixw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oT-0000000GcZd-3UNQ;
	Sun, 08 Nov 2026 20:48:29 +0000
Received: from out-196.mta0.migadu.com ([2001:41d0:1004:224b::c4] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oL-0000000GcBv-2GfA
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:29 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=pPiJo5YvvZwz+FSuNCP5LV5980zfLh166gCKBgUb8TU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170899; v=1; x=1794775699;
 b=STCqHCKooXiP/JFm9tRgW3k2K0EZRgZUzYpfsWJ/nZhmOi1NZ+x+eFysdDpxd0X+TvipCHrv
 /gW4YuE/qvdJCueQetYDDEYzWfKaUaAP3QmXi/e15EnooO37axtULx7Bs0syB5feEUrZaibzjFn
 +62QjsWOhnbO4EDrHG2uAPaY=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 3d3bbd98ebe99174;
	Sun, 08 Nov 2026 20:48:19 +0000
X-Mizu-Trace-ID: 3d3bbd98ebe99174
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
Subject: [PATCH v9 20/29] scsi-multipath: provide callbacks for path state
Date: Sun,  8 Nov 2026 20:47:24 +0000
Message-ID: <20261108204733.557995-21-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124821_732245_510ADEBE 
X-CRM114-Status: UNSURE (   8.48  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Provide callbacks for .is_disabled, .is_optimized, and .available_path.

These all use scsi_device.sdev_state and scsi_device.access_state.

Member scsi_device.access_state will be driven by ALUA. Currently
only device handlers support this, and in future we will have core
SCSI support for implicit ALUA (not relying on device handlers).

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_multipath.c | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 4c965650c2bd..2f47c39d8293 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -298,7 +298,56 @@ static struct bio *scsi_mpath_clone_bio(struct bio *bio)
 	return clone;
 }
 
+static bool scsi_mpath_is_disabled(struct mpath_device *mpath_device)
+{
+	struct scsi_mpath_device *scsi_mpath_dev =
+				to_scsi_mpath_device(mpath_device);
+	struct scsi_device *sdev = scsi_mpath_dev->sdev;
+	unsigned char access_state = READ_ONCE(sdev->access_state) &
+					SCSI_ACCESS_STATE_MASK;
+
+	if (READ_ONCE(sdev->sdev_state) != SDEV_RUNNING)
+		return true;
+
+	if (access_state == SCSI_ACCESS_STATE_OPTIMAL ||
+	    access_state == SCSI_ACCESS_STATE_ACTIVE)
+		return false;
+
+	return true;
+}
+
+static bool scsi_mpath_is_optimized(struct mpath_device *mpath_device)
+{
+	struct scsi_mpath_device *scsi_mpath_dev =
+				to_scsi_mpath_device(mpath_device);
+	struct scsi_device *sdev = scsi_mpath_dev->sdev;
+	unsigned char access_state = READ_ONCE(sdev->access_state) &
+					SCSI_ACCESS_STATE_MASK;
+
+	if (READ_ONCE(sdev->sdev_state) != SDEV_RUNNING)
+		return false;
+
+	return access_state == SCSI_ACCESS_STATE_OPTIMAL;
+}
+
+static bool scsi_mpath_available_path(struct mpath_device *mpath_device)
+{
+	struct scsi_mpath_device *scsi_mpath_dev =
+				to_scsi_mpath_device(mpath_device);
+	struct scsi_device *sdev = scsi_mpath_dev->sdev;
+	enum scsi_device_state sdev_state = READ_ONCE(sdev->sdev_state);
+
+	if (sdev_state == SDEV_RUNNING || sdev_state == SDEV_QUIESCE ||
+	    sdev_state == SDEV_BLOCK || sdev_state == SDEV_CREATED_BLOCK)
+		return true;
+
+	return false;
+}
+
 static struct mpath_head_template smpdt = {
+	.is_disabled = scsi_mpath_is_disabled,
+	.is_optimized = scsi_mpath_is_optimized,
+	.available_path = scsi_mpath_available_path,
 	.clone_bio = scsi_mpath_clone_bio,
 };
 
-- 
2.43.0


