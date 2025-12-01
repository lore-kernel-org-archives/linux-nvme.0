Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7B0D116F3
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fKTaK8YQ8JlnEYeloVBNBHe/TIb+9zuKgvDOA4diXFc=; b=UYSfHhz5fqlhFfQmvVxc77FDL8
	8/rjsL1uzOhwtD46gGqTHY+uB2bmg5syOLxHQYXLVEZM1/y5Li0dK+aPxPe9DzByRGh1SzX5mYEGC
	xNF9g++KwMl6qvnunBI6iX+N4eO8cfydC3H7OsdoVm7QOn5UnCMg7CAdM9vTOW8Fd19ntZeOPlrAE
	frT4K3wThn8WV69FqN6uEXg5AkYkGlhTs48AClooN2fku2krVQBh0UsFfVzS5d2zh+t+Xqkt7G1Nd
	d3JQvoTNSDSZ5EvcmH3DoFrBOe0mTtcgHNklRX0NDZBeMCNF4HbJAoyv2HbThFtUhW5h40ClAO/UR
	JX+uCe4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQBgX-00000004Y41-1vyM;
	Mon, 01 Dec 2025 21:43:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQBgS-00000004Y2m-1T7y
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 21:43:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764625427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKTaK8YQ8JlnEYeloVBNBHe/TIb+9zuKgvDOA4diXFc=;
	b=fy7Pkgkb3yz8ZKnSb8aBsIZKYbTM78cLEsFv4t6dhJOOxendT7Dk3rNIfJvrBkFs47WqQz
	cILJIU0PH0F6aKKHC0fGXuuVHSzYKXWdZ1rB7dHBjX9396nqu1Dd6oasdg/fcGMH9fdbs1
	KTJ1Rx1jk9GjkR4AV3EWNtgSmsb0ZSc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-2KT_SfgRPoq8WMSkKWvSyw-1; Mon,
 01 Dec 2025 16:43:43 -0500
X-MC-Unique: 2KT_SfgRPoq8WMSkKWvSyw-1
X-Mimecast-MFC-AGG-ID: 2KT_SfgRPoq8WMSkKWvSyw_1764625421
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54099195605F;
	Mon,  1 Dec 2025 21:43:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95B711800876;
	Mon,  1 Dec 2025 21:43:40 +0000 (UTC)
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
	Stefan Hajnoczi <stefanha@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 4/4] block: add IOC_PR_READ_RESERVATION ioctl
Date: Mon,  1 Dec 2025 16:43:29 -0500
Message-ID: <20251201214329.933945-5-stefanha@redhat.com>
In-Reply-To: <20251201214329.933945-1-stefanha@redhat.com>
References: <20251201214329.933945-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_134348_461688_B6DF6BE3 
X-CRM114-Status: GOOD (  17.34  )
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

Add a Persistent Reservations ioctl to read the current reservation.
This calls the pr_ops->read_reservation() function that was previously
added in commit c787f1baa503 ("block: Add PR callouts for read keys and
reservation") but was only used by the in-kernel SCSI target so far.

The IOC_PR_READ_RESERVATION ioctl is necessary so that userspace
applications that rely on Persistent Reservations ioctls have a way of
inspecting the current state. Cluster managers and validation tests need
this functionality.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/pr.h |  7 +++++++
 block/ioctl.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/uapi/linux/pr.h b/include/uapi/linux/pr.h
index fcb74eab92c80..847f3051057af 100644
--- a/include/uapi/linux/pr.h
+++ b/include/uapi/linux/pr.h
@@ -62,6 +62,12 @@ struct pr_read_keys {
 	__u64	keys_ptr;
 };
 
+struct pr_read_reservation {
+	__u64	key;
+	__u32	generation;
+	__u32	type;
+};
+
 #define PR_FL_IGNORE_KEY	(1 << 0)	/* ignore existing key */
 
 #define IOC_PR_REGISTER		_IOW('p', 200, struct pr_registration)
@@ -71,5 +77,6 @@ struct pr_read_keys {
 #define IOC_PR_PREEMPT_ABORT	_IOW('p', 204, struct pr_preempt)
 #define IOC_PR_CLEAR		_IOW('p', 205, struct pr_clear)
 #define IOC_PR_READ_KEYS	_IOWR('p', 206, struct pr_read_keys)
+#define IOC_PR_READ_RESERVATION	_IOR('p', 207, struct pr_read_reservation)
 
 #endif /* _UAPI_PR_H */
diff --git a/block/ioctl.c b/block/ioctl.c
index 95ce9aa90bba2..4a55d2e7602e5 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -477,6 +477,32 @@ static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
 	return ret;
 }
 
+static int blkdev_pr_read_reservation(struct block_device *bdev,
+		blk_mode_t mode, struct pr_read_reservation __user *arg)
+{
+	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+	struct pr_held_reservation rsv = {};
+	struct pr_read_reservation out = {};
+	int ret;
+
+	if (!blkdev_pr_allowed(bdev, mode))
+		return -EPERM;
+	if (!ops || !ops->pr_read_reservation)
+		return -EOPNOTSUPP;
+
+	ret = ops->pr_read_reservation(bdev, &rsv);
+	if (ret)
+		return ret;
+
+	out.key = rsv.key;
+	out.generation = rsv.generation;
+	out.type = rsv.type;
+
+	if (copy_to_user(arg, &out, sizeof(out)))
+		return -EFAULT;
+	return 0;
+}
+
 static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
 		unsigned long arg)
 {
@@ -700,6 +726,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return blkdev_pr_clear(bdev, mode, argp);
 	case IOC_PR_READ_KEYS:
 		return blkdev_pr_read_keys(bdev, mode, argp);
+	case IOC_PR_READ_RESERVATION:
+		return blkdev_pr_read_reservation(bdev, mode, argp);
 	default:
 		return blk_get_meta_cap(bdev, cmd, argp);
 	}
-- 
2.52.0


