Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C06606D809
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=szI5aeNk;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vXzF4kKT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=oOyPSLk+GrgEBerLslrKlUTAOuWXuUUSVo0ysXdvyrQ=; b=szI5aeNkAQykFI
	KXXuunB3cn2rGKIKyP9BTyQukzGLMzzcrMhyhGgshqdZvcsscctm4zoBzLQDfrUgSPk19ms5P1dvO
	jV7uBCr2RG5Kdp+nXBWHxe4M9o5bH3mnV2XVlQAnzqOQMSQSs3lEBIFExcu/nezm81uUOjS9YmuHv
	KiqSpUZxeAolUOMoDX/mgEaosXiru7BY3jru3V6td+ulnXOTUoUsGzFhWLMTWDQDF2bhl30jUnxPA
	ASruBLG4AaPxYbZpq8vvlskqTtOwg+ma9POfSRcL7P/nKGLZLLh35CDP2X9TR3GZsuGnRzZNKp6pl
	UOVm1usbuL98ZAJiBtOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9o8-0000000GbsX-3KWP;
	Sun, 08 Nov 2026 20:48:08 +0000
Received: from out-60.mta1.migadu.com ([95.215.58.60] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9o5-0000000Gbm9-1aHr
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:07 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=A5vtG0AAOU2USuDE74SFeoHqv0A6nD9sPzQHbB7H7SM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170883; v=1; x=1794775683;
 b=vXzF4kKTZu6A+xwg7ZBmZAh4VXOvtgllgjDS/xRaEoIhGeXSZ3LZOb38RZGqoesxCH5alzU4
 +qmft+LSea2+e5dN8qS6YQWk7Ey0oyUxbpIQ1QZZUQ8+ADe6veapa4ymgYx6d41kgRqBv12ixup
 QCUidBtIM5xnGQThCCtfEmQk=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 229adb54fd34a1a5;
	Sun, 08 Nov 2026 20:48:03 +0000
X-Mizu-Trace-ID: 229adb54fd34a1a5
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
Subject: [PATCH v9 09/29] libmultipath: Add support for block device IOCTL
Date: Sun,  8 Nov 2026 20:47:13 +0000
Message-ID: <20261108204733.557995-10-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124805_559582_980FA7E3 
X-CRM114-Status: GOOD (  12.00  )
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

Add mpath_bdev_ioctl() as a multipath block device IOCTL handler. This
handler calls into the mpath_device bdev fops handler.

The .compat_ioctl handler is given the standard handler.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 lib/multipath.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lib/multipath.c b/lib/multipath.c
index ae5a73d570b3..d59d7ba81087 100644
--- a/lib/multipath.c
+++ b/lib/multipath.c
@@ -455,11 +455,53 @@ static void mpath_bdev_release(struct gendisk *disk)
 	mpath_put_head(mpath_head);
 }
 
+static int mpath_bdev_ioctl(struct block_device *bdev, blk_mode_t mode,
+		    unsigned int cmd, unsigned long arg)
+{
+	struct gendisk *disk = bdev->bd_disk;
+	struct mpath_head *mpath_head = mpath_gendisk_to_head(disk);
+	struct mpath_device *mpath_device;
+	int srcu_idx, err;
+
+	/*
+	 * This check is duplicated from sd_ioctl() as we don't pass the
+	 * partition bdev to fops->ioctl. That is not yet possible as the
+	 * per-path disk is hidden and, as such, does not have partitions
+	 * scanned.
+	 */
+	if (bdev_is_partition(bdev) && !capable(CAP_SYS_RAWIO))
+		return -ENOIOCTLCMD;
+
+	srcu_idx = srcu_read_lock(&mpath_head->srcu);
+	mpath_device = mpath_find_path(mpath_head);
+	if (!mpath_device) {
+		err = -EWOULDBLOCK;
+		goto out_unlock;
+	}
+
+	if (!mpath_device->disk->fops->ioctl) {
+		err = -ENOTTY;
+		goto out_unlock;
+	}
+
+	err = mpath_device->disk->fops->ioctl(
+			mpath_device->disk->part0, mode, cmd, arg);
+out_unlock:
+	srcu_read_unlock(&mpath_head->srcu, srcu_idx);
+	return err;
+}
+
 const struct block_device_operations mpath_ops = {
 	.owner          = THIS_MODULE,
 	.open		= mpath_bdev_open,
 	.release	= mpath_bdev_release,
 	.submit_bio	= mpath_bdev_submit_bio,
+	.ioctl		= mpath_bdev_ioctl,
+	/*
+	 * Both NVMe and SCSI use generic blkdev_compat_ptr_ioctl, so would
+	 * avoid their custom compat_ioctl implementation.
+	 */
+	.compat_ioctl	= blkdev_compat_ptr_ioctl,
 };
 EXPORT_SYMBOL_GPL(mpath_ops);
 
-- 
2.43.0


