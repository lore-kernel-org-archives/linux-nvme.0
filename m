Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA43D11186
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y7acRfl4IkuQFx8mKPn8HoH4mgf78BRMNYKMfEK8ccQ=; b=Gc3fkr4mtUeNrgEjyGnIBrqYRK
	/R1sr/+Bg2GcZmHPMcROeSsZDfF/gwTRvSICQAgAVu3wEKhomkuXQ/oaZPaLK8GH9Gv9PMBRe6WlB
	XWZJXaTELAvFbroJmayZH28c6RnBf8x0eJrZQx61k7C4YxLZbQuWEGoaXnzK42H7ZK02bl/Xk/7YJ
	V4OYIhnLUCYS/pQ7RMZSbtXMGbStgMllmX0hz4A2ua+LSDciVGz/3No3Ja42jgCrtrk77u1Rcc40O
	0wsfNOovx5hBiSFqXXE0E+SW7G8BQUO+D/JL2QbPuqzbOjlZJQBQ/596ILEJ3DgEBQo89B36ld6+Y
	01RMZtzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOIWt-0000000FJnq-2KEe;
	Wed, 26 Nov 2025 16:38:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOIWq-0000000FJlq-0IS1
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 16:38:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764175083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7acRfl4IkuQFx8mKPn8HoH4mgf78BRMNYKMfEK8ccQ=;
	b=Ane11PdUbYXggBqyZHkvVi55kNVQ+tya+pgpngIwtjEu3qIVs+kRreni/PRJjgsm6oXc2e
	3cKsNASn7fQ7ztNEDfknb32YGGkwWfGW89Bi7Oc9+nJUENpgMjlFTYKiuioBWvdSZYUPS5
	lQIRjOLTGenuSaZHCQRxtIRTRMHxysI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-wVtkfr5wO-2CEH1AYylILQ-1; Wed,
 26 Nov 2025 11:36:14 -0500
X-MC-Unique: wVtkfr5wO-2CEH1AYylILQ-1
X-Mimecast-MFC-AGG-ID: wVtkfr5wO-2CEH1AYylILQ_1764174972
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37F20195606B;
	Wed, 26 Nov 2025 16:36:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB99118004A3;
	Wed, 26 Nov 2025 16:36:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-scsi@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/4] block: add IOC_PR_READ_KEYS ioctl
Date: Wed, 26 Nov 2025 11:35:59 -0500
Message-ID: <20251126163600.583036-4-stefanha@redhat.com>
In-Reply-To: <20251126163600.583036-1-stefanha@redhat.com>
References: <20251126163600.583036-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_083804_224388_4926A015 
X-CRM114-Status: GOOD (  17.56  )
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

Add a Persistent Reservations ioctl to read the list of currently
registered reservation keys. This calls the pr_ops->read_keys() function
that was previously added in commit c787f1baa503 ("block: Add PR
callouts for read keys and reservation") but was only used by the
in-kernel SCSI target so far.

The IOC_PR_READ_KEYS ioctl is necessary so that userspace applications
that rely on Persistent Reservations ioctls have a way of inspecting the
current state. Cluster managers and validation tests need this
functionality.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/uapi/linux/pr.h |  7 ++++++
 block/ioctl.c           | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/uapi/linux/pr.h b/include/uapi/linux/pr.h
index d8126415966f3..fcb74eab92c80 100644
--- a/include/uapi/linux/pr.h
+++ b/include/uapi/linux/pr.h
@@ -56,6 +56,12 @@ struct pr_clear {
 	__u32	__pad;
 };
 
+struct pr_read_keys {
+	__u32	generation;
+	__u32	num_keys;
+	__u64	keys_ptr;
+};
+
 #define PR_FL_IGNORE_KEY	(1 << 0)	/* ignore existing key */
 
 #define IOC_PR_REGISTER		_IOW('p', 200, struct pr_registration)
@@ -64,5 +70,6 @@ struct pr_clear {
 #define IOC_PR_PREEMPT		_IOW('p', 203, struct pr_preempt)
 #define IOC_PR_PREEMPT_ABORT	_IOW('p', 204, struct pr_preempt)
 #define IOC_PR_CLEAR		_IOW('p', 205, struct pr_clear)
+#define IOC_PR_READ_KEYS	_IOWR('p', 206, struct pr_read_keys)
 
 #endif /* _UAPI_PR_H */
diff --git a/block/ioctl.c b/block/ioctl.c
index d7489a56b33c3..e87c424c15ae9 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/capability.h>
+#include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/blkdev.h>
 #include <linux/export.h>
@@ -423,6 +424,54 @@ static int blkdev_pr_clear(struct block_device *bdev, blk_mode_t mode,
 	return ops->pr_clear(bdev, c.key);
 }
 
+static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
+		struct pr_read_keys __user *arg)
+{
+	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+	struct pr_keys *keys_info __free(kfree) = NULL;
+	struct pr_read_keys inout;
+	int ret;
+
+	if (!blkdev_pr_allowed(bdev, mode))
+		return -EPERM;
+	if (!ops || !ops->pr_read_keys)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&inout, arg, sizeof(inout)))
+		return -EFAULT;
+
+	if (inout.num_keys > -sizeof(*keys_info) / sizeof(keys_info->keys[0]))
+		return -EINVAL;
+
+	size_t keys_info_len = struct_size(keys_info, keys, inout.num_keys);
+
+	keys_info = kzalloc(keys_info_len, GFP_KERNEL);
+	if (!keys_info)
+		return -ENOMEM;
+
+	keys_info->num_keys = inout.num_keys;
+
+	ret = ops->pr_read_keys(bdev, keys_info);
+	if (ret)
+		return ret;
+
+	/* Copy out individual keys */
+	u64 __user *keys_ptr = u64_to_user_ptr(inout.keys_ptr);
+	u32 num_copy_keys = min(inout.num_keys, keys_info->num_keys);
+	size_t keys_copy_len = num_copy_keys * sizeof(keys_info->keys[0]);
+
+	if (copy_to_user(keys_ptr, keys_info->keys, keys_copy_len))
+		return -EFAULT;
+
+	/* Copy out the arg struct */
+	inout.generation = keys_info->generation;
+	inout.num_keys = keys_info->num_keys;
+
+	if (copy_to_user(arg, &inout, sizeof(inout)))
+		return -EFAULT;
+	return ret;
+}
+
 static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
 		unsigned long arg)
 {
@@ -644,6 +693,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return blkdev_pr_preempt(bdev, mode, argp, true);
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, mode, argp);
+	case IOC_PR_READ_KEYS:
+		return blkdev_pr_read_keys(bdev, mode, argp);
 	default:
 		return blk_get_meta_cap(bdev, cmd, argp);
 	}
-- 
2.52.0


