Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10B606D823
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s7mpo6TY;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JjiJO6ka
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uqE0xY48+HsHwpb4Up8/gX/8HzxQ6Bp9ud6iT5itTcM=; b=s7mpo6TYq7JPYD
	YGEBmbwA4QW2bf5pyf4p1p9rMKWI0g8FroFNXpAex+2vNh1XDACe7GgekZZjAU2eTXZQrsVrL+wCk
	h3pjEXibXssep2WOuCToLCGZjfCA0+cz2ePox+HU4j1nV9AvBdfBSR/s2m0GQPQSkEBIon3y7ieUK
	En++VxIdgKZXX2Em7NY8zgvRYDzrvjb10QvH4UhJNL3IAXYf879Jf1FfbqcEmoC/Raqt43Ob4zgvr
	WVb3JoaumBYjOPfJiPGagVrJ5gTW2Efg94TlyOY03NVgWz7csjD39RzTOhgDhcAL6hHuRCJTL31NW
	D01fSOq+x0dk77mBG4Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oB-0000000Gbyt-2pB2;
	Sun, 08 Nov 2026 20:48:11 +0000
Received: from out-71.mta1.migadu.com ([95.215.58.71] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9o8-0000000GbqD-2Rgu
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:09 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=php3BuRcqSzcvJXynpfSwkuXZS0RYrDjb3XQI6eXRsI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170886; v=1; x=1794775686;
 b=JjiJO6kasC6K0F3iRyMHWzHqGS8ubgukvZFkg24iUpWnsgVKBItGMrgXtnWCSEK+ILQ1YLC3
 x67Wskq0VgGbATeo0eH+YnbXYWk2W+hc+HgfYh684KtkR7gKbfJ6kXyfGqL7hRC2bcMQL9XkcO9
 Cd2H8ppT8TqPs/wGnq+8hQuI=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id f0abbd2653e1c286;
	Sun, 08 Nov 2026 20:48:06 +0000
X-Mizu-Trace-ID: f0abbd2653e1c286
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
Subject: [PATCH v9 11/29] libmultipath: Add mpath_bdev_get_unique_id()
Date: Sun,  8 Nov 2026 20:47:15 +0000
Message-ID: <20261108204733.557995-12-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124808_785492_A5AA1B47 
X-CRM114-Status: GOOD (  10.82  )
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

Add mpath_bdev_get_unique_id() as a multipath block device .get_unique_id
handler.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 lib/multipath.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/multipath.c b/lib/multipath.c
index 3e2dc7d8b2c2..b03080afb259 100644
--- a/lib/multipath.c
+++ b/lib/multipath.c
@@ -455,6 +455,27 @@ static void mpath_bdev_release(struct gendisk *disk)
 	mpath_put_head(mpath_head);
 }
 
+static int mpath_bdev_get_unique_id(struct gendisk *disk, u8 id[16],
+    enum blk_unique_id type)
+{
+	struct mpath_head *mpath_head = mpath_gendisk_to_head(disk);
+	int srcu_idx, ret = -EWOULDBLOCK;
+	struct mpath_device *mpath_device;
+
+	srcu_idx = srcu_read_lock(&mpath_head->srcu);
+	mpath_device = mpath_find_path(mpath_head);
+	if (mpath_device) {
+		if (mpath_device->disk->fops->get_unique_id)
+			ret = mpath_device->disk->fops->get_unique_id(
+					mpath_device->disk, id, type);
+		else
+			ret = 0; /* referencing __dm_get_unique_id() */
+	}
+	srcu_read_unlock(&mpath_head->srcu, srcu_idx);
+
+	return ret;
+}
+
 static int mpath_bdev_ioctl(struct block_device *bdev, blk_mode_t mode,
 		    unsigned int cmd, unsigned long arg)
 {
@@ -522,6 +543,7 @@ const struct block_device_operations mpath_ops = {
 	 * avoid their custom compat_ioctl implementation.
 	 */
 	.compat_ioctl	= blkdev_compat_ptr_ioctl,
+	.get_unique_id	= mpath_bdev_get_unique_id,
 	.getgeo		= mpath_bdev_getgeo,
 };
 EXPORT_SYMBOL_GPL(mpath_ops);
-- 
2.43.0


