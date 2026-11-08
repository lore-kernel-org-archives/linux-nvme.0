Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA9606D816
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ubwUkMzs;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=iZtn6Hpe;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bxX8Kb77
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hCwRFUq2iDoZLi7clY/PuGBmmvq7M0hE+90qPhgsKN4=; b=ubwUkMzsWbetwK
	ensmflKTZ6SgIfRm3R3q0hAu6GkghlMTpwRS8i0Z/omUHaSnp7w/QDU0eZ4M3y83efqqGsa7z2q8m
	X5jKDbGSWVdm3YmMTsfBb3zK6iPmYCBKO7Ym9MDBGOU25H2GuhLM5MAdwteAiXtEhSfZDusQp3Eb4
	jl2YsetL6AwhpSF5qtd4RRTJ+o6JxA+v82QId9xojf5mnprzjXoAFsjs6+e/QKbmB7L+0P2hph29I
	kMwZAXcIQPBF14AM0WA8TmirXNuQ95Y0DwcYXz5oHjhK0GVdT1aZpsv+0WbdVHfJFvJiuOsJkN0Qg
	TYGOC1tPXHVRqppwjZVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oW-0000000GcgZ-2o4A;
	Sun, 08 Nov 2026 20:48:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oV-0000000Gcar-0Jpu
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Nov 2026 20:48:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hCwRFUq2iDoZLi7clY/PuGBmmvq7M0hE+90qPhgsKN4=; b=iZtn6Hpe6hYXUK8n4rG1lmWs1F
	O/zNHojH0b2ZOCD6ZCM+LZgyQz1EBkVWrb1gX9ltteJmjaA0BGWtfylDgMjs/VJmD5eAJo9nrOkDv
	wED5t4LAwRRki+sSBd1EIeEFzK3IDhuWLkPV1I20St2E2fAH+lxxLKnyk1wEhDnIkiFXdyBQjrBN3
	0WPdoVQdBbVISB8gYL1A01ZOF+63WSDyyTSnfPPQ0rdTmZcyDZQ36AgWgu73Rtc/EEXH+DBk8wNJm
	QR+G5uCQTItJKoRh4JUTldeNnFTxQk2Wr9icMNEAEGAOcXGxEyGIzOTte0v4JIz4oUDqbwL6ZmYIu
	H5V5j+0Q==;
Received: from out-203.mta0.migadu.com ([2001:41d0:1004:224b::cb] helo=mta0.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oO-000000060Hd-2m8D
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:27 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=yrAIksUYEXTflpjgfac/bXgq6WaL9u4UCyIJD0wmCl0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170902; v=1; x=1794775702;
 b=bxX8Kb77ZDouS+L26RbpayQDxxmDsZkvPde/WUsTfOoG8SGWhRz5qS6FkGJl9nKmsKebbo5O
 y9Wh1LQZ5SvMN6+1kjU1L29H5QX7m4tk+bCHpqRJLUJ5spkRHR36evIR9nDlUIw/gvdg/sMhqYM
 1lnTF+VP4Mlu2VDTjOIuBr4Q=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 126689d4dbf56e8a;
	Sun, 08 Nov 2026 20:48:22 +0000
X-Mizu-Trace-ID: 126689d4dbf56e8a
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
Subject: [PATCH v9 23/29] scsi-multipath: add delayed disk removal support
Date: Sun,  8 Nov 2026 20:47:27 +0000
Message-ID: <20261108204733.557995-24-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_204824_962906_176E1BD9 
X-CRM114-Status: GOOD (  13.84  )
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

Add support in core code for delayed disk removal support. In this, the
callback calls into the scsi_driver to do the necessary removal work.

The scsi_disk driver (sd) must ensure that the scsi_mpath_device does not
go away while the delayed removal work is active, i.e. it must keep a
reference.

No reference to the scsi_disk multipath structures are kept outside that
driver, so that driver needs to provide a scsi_driver.mpath_remove_head
callback to do the necessary work.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_multipath.c | 27 +++++++++++++++++++++++++++
 include/scsi/scsi_driver.h    |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index bec6dd94f3be..58b0be88a952 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -344,7 +344,34 @@ static bool scsi_mpath_available_path(struct mpath_device *mpath_device)
 	return false;
 }
 
+static int scsi_mpath_remove_head_drv(struct device_driver *drv, void *data)
+{
+	struct scsi_mpath_head *scsi_mpath_head = data;
+	struct scsi_driver *scsi_driver = to_scsi_driver(drv);
+
+	if (scsi_driver->mpath_remove_head)
+		scsi_driver->mpath_remove_head(scsi_mpath_head);
+
+	return 0;
+}
+
+static void scsi_mpath_remove_head_work(struct mpath_head *mpath_head)
+{
+	struct scsi_mpath_head *scsi_mpath_head = to_scsi_mpath_head(mpath_head);
+
+	/*
+	 * scsi_mpath_remove_head_drv() could drop the final reference to
+	 * scsi_mpath_head, meaning that we pass a free'd pointer further
+	 * drivers - take a reference so that won't happen.
+	 */
+	scsi_mpath_get_head(scsi_mpath_head);
+	bus_for_each_drv(&scsi_bus_type, NULL, scsi_mpath_head,
+		scsi_mpath_remove_head_drv);
+	scsi_mpath_put_head(scsi_mpath_head);
+}
+
 static struct mpath_head_template smpdt = {
+	.remove_head = scsi_mpath_remove_head_work,
 	.is_disabled = scsi_mpath_is_disabled,
 	.is_optimized = scsi_mpath_is_optimized,
 	.available_path = scsi_mpath_available_path,
diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index 249cea724abd..d92b63d357f2 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -8,6 +8,7 @@
 
 struct module;
 struct request;
+struct scsi_mpath_head;
 
 struct scsi_driver {
 	struct device_driver	gendrv;
@@ -22,6 +23,9 @@ struct scsi_driver {
 	int (*done)(struct scsi_cmnd *);
 	int (*eh_action)(struct scsi_cmnd *, int);
 	void (*eh_reset)(struct scsi_cmnd *);
+	#ifdef CONFIG_SCSI_MULTIPATH
+	void (*mpath_remove_head)(struct scsi_mpath_head *);
+	#endif
 };
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)
-- 
2.43.0


