Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2F606D819
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b0ifobON;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WC1AE5eT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kSNTv+aNJxonZ0HiJim69/NMT9ESSsTK9I4rjqvPbcw=; b=b0ifobONODNeKB
	rUYhOgbB4o9LV1gV35353G0FaqunULD5y9c+iN4/Hkm/JTpYRr7/eWxe5cprBKWDrW4l+3IORZUs7
	DSR/KAh1EC13gLTM8Hrm858rGkVG3hAA4pbB3Sr9ZQZJ9vLIhYuCH4b/pQ1wHRqwF9/PATHIKHFkC
	Dgdh5aOYxYIOPspdXF7h6d5fG77/6L5QN/LlymqS1fx8QO4OpiMgmwVLlL7W5LIbfaehEDTU+dRkz
	4VZZA2h6JsFig0utn72Q4pjepVXE23ONHE+Lw9I4ulYXdzxq+KcOfwae2PcQlrR/0ZDdeBJd8IPxH
	LOdmvAaItSk0Xb99uP0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oA-0000000Gbxh-4AgC;
	Sun, 08 Nov 2026 20:48:11 +0000
Received: from out-66.mta1.migadu.com ([95.215.58.66] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9o7-0000000GbpV-3uuu
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:09 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=exsDCEn091ZlDw2fBJ4TkGMv2ZuFWeVd9KO0T+qf7z0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170886; v=1; x=1794775686;
 b=WC1AE5eTmrbCY1/M5DpcsKmHp0iseageC296A/K9ry3kRSaxwNjxEmLLBSnhfRxezOwpKK9d
 Z8FdqKTTOEK5+OpQvOX3d9LpKXd3ZvB2EGvy1VyLc+WVbYvns/LcRhmByJkMozF7FYOLPqVROcQ
 Z5h4CbOchgiWHgRmB0/Rr0ZU=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 87f386aec11499aa;
	Sun, 08 Nov 2026 20:48:06 +0000
X-Mizu-Trace-ID: 87f386aec11499aa
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
Subject: [PATCH v9 10/29] libmultipath: Add mpath_bdev_getgeo()
Date: Sun,  8 Nov 2026 20:47:14 +0000
Message-ID: <20261108204733.557995-11-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124808_118649_BC6E280C 
X-CRM114-Status: GOOD (  10.43  )
X-Spam-Score: -2.8 (--)
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

Add mpath_bdev_getgeo() as a multipath block device .getgeo handler.

Here we just redirect into the selected mpath_device disk fops->getgeo
handler.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 lib/multipath.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/multipath.c b/lib/multipath.c
index d59d7ba81087..3e2dc7d8b2c2 100644
--- a/lib/multipath.c
+++ b/lib/multipath.c
@@ -491,6 +491,26 @@ static int mpath_bdev_ioctl(struct block_device *bdev, blk_mode_t mode,
 	return err;
 }
 
+static int mpath_bdev_getgeo(struct gendisk *disk, struct hd_geometry *geo)
+{
+	struct mpath_head *mpath_head = mpath_gendisk_to_head(disk);
+	int srcu_idx, ret = -EWOULDBLOCK;
+	struct mpath_device *mpath_device;
+
+	srcu_idx = srcu_read_lock(&mpath_head->srcu);
+	mpath_device = mpath_find_path(mpath_head);
+	if (mpath_device) {
+		if (mpath_device->disk->fops->getgeo)
+			ret = mpath_device->disk->fops->getgeo(
+					mpath_device->disk, geo);
+		else
+			ret = -ENOTTY; /* See blkdev_getgeo */
+	}
+	srcu_read_unlock(&mpath_head->srcu, srcu_idx);
+
+	return ret;
+}
+
 const struct block_device_operations mpath_ops = {
 	.owner          = THIS_MODULE,
 	.open		= mpath_bdev_open,
@@ -502,6 +522,7 @@ const struct block_device_operations mpath_ops = {
 	 * avoid their custom compat_ioctl implementation.
 	 */
 	.compat_ioctl	= blkdev_compat_ptr_ioctl,
+	.getgeo		= mpath_bdev_getgeo,
 };
 EXPORT_SYMBOL_GPL(mpath_ops);
 
-- 
2.43.0


