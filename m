Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5722FD116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 21:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tmEzslKSkhmC0gLB9i+o3Qufbcn1D02jCo9kyVUqdsk=; b=vCrz4e5/iqdCwmno7YTHoz01Jr
	zJyl44b0KMcGGQRGrWKkwcxzV2MXStYz3Gol3qpOzG/p35pSbZJbSOnX8RwvxW2VSbL9g9YgGWong
	LWt4GvrXuFGMrHS1KCNUc8nabrV4Ngf/EHKyTFs9lCteBAsc9JBzPeIJOGSnkwTTPDgSUcOgXwTg2
	kJw82WW0jrijB/jqBbsxiA4EyLDJ0jPcv4zDccrWPftFfNGVGBGcnKnyC4leLF3UiGaJKXCSNy3yt
	IJGiyH6je2G+hJLwmO/77lcR46wDkZvham4+NQR/0vgTi5uI/FM/3/1Ebge7Z8uGcYz93N7UU65RZ
	5AclrBUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQBgW-00000004Y3j-2o0H;
	Mon, 01 Dec 2025 21:43:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQBgQ-00000004Y2A-1SGF
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 21:43:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764625425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmEzslKSkhmC0gLB9i+o3Qufbcn1D02jCo9kyVUqdsk=;
	b=Uwaf86gPuYM42tuzBPXA7K+xYlLitW9R70AsnmvssM1z6uZJRyTFvQBPi5vNFHxOtDeF+O
	jOyWgOAiXP+EHY4HWtnmIVE3MicywvpWU+M5b8H3a6cGa3oyfbLobAf2AdlU3pwFGR+/zM
	1DxTaCSwQfmcs6pxp8qApoXYXd6iFRc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-pvHD_HxaPw-VDLFQazgHzw-1; Mon,
 01 Dec 2025 16:43:41 -0500
X-MC-Unique: pvHD_HxaPw-VDLFQazgHzw-1
X-Mimecast-MFC-AGG-ID: pvHD_HxaPw-VDLFQazgHzw_1764625419
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B9A719560A1;
	Mon,  1 Dec 2025 21:43:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BCA71956095;
	Mon,  1 Dec 2025 21:43:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Mike Christie <michael.christie@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-nvme@lists.infradead.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 3/4] block: add IOC_PR_READ_KEYS ioctl
Date: Mon,  1 Dec 2025 16:43:28 -0500
Message-ID: <20251201214329.933945-4-stefanha@redhat.com>
In-Reply-To: <20251201214329.933945-1-stefanha@redhat.com>
References: <20251201214329.933945-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_134346_459183_6A6E118F 
X-CRM114-Status: GOOD (  17.81  )
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
 block/ioctl.c           | 56 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

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
index d7489a56b33c3..95ce9aa90bba2 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -423,6 +423,60 @@ static int blkdev_pr_clear(struct block_device *bdev, blk_mode_t mode,
 	return ops->pr_clear(bdev, c.key);
 }
 
+static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
+		struct pr_read_keys __user *arg)
+{
+	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+	struct pr_keys *keys_info;
+	struct pr_read_keys read_keys;
+	u64 __user *keys_ptr;
+	size_t keys_info_len;
+	size_t keys_copy_len;
+	int ret;
+
+	if (!blkdev_pr_allowed(bdev, mode))
+		return -EPERM;
+	if (!ops || !ops->pr_read_keys)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&read_keys, arg, sizeof(read_keys)))
+		return -EFAULT;
+
+	keys_info_len = struct_size(keys_info, keys, read_keys.num_keys);
+	if (keys_info_len == SIZE_MAX)
+		return -EINVAL;
+
+	keys_info = kzalloc(keys_info_len, GFP_KERNEL);
+	if (!keys_info)
+		return -ENOMEM;
+
+	keys_info->num_keys = read_keys.num_keys;
+
+	ret = ops->pr_read_keys(bdev, keys_info);
+	if (ret)
+		goto out;
+
+	/* Copy out individual keys */
+	keys_ptr = u64_to_user_ptr(read_keys.keys_ptr);
+	keys_copy_len = min(read_keys.num_keys, keys_info->num_keys) *
+		        sizeof(keys_info->keys[0]);
+
+	if (copy_to_user(keys_ptr, keys_info->keys, keys_copy_len)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	/* Copy out the arg struct */
+	read_keys.generation = keys_info->generation;
+	read_keys.num_keys = keys_info->num_keys;
+
+	if (copy_to_user(arg, &read_keys, sizeof(read_keys)))
+		ret = -EFAULT;
+out:
+	kfree(keys_info);
+	return ret;
+}
+
 static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
 		unsigned long arg)
 {
@@ -644,6 +698,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
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


