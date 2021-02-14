Return-Path: <SRS0=P1pc=HQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BCAC433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 11:02:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BFB64E12
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 11:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BFB64E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lI06GHDIEOlu59LU7FxMa7Jz+1raoRMyo+3zZYKCHnU=; b=CtXfMtHG84lAjiLOpISXUT1+uo
	uNXmxG5Nx0wJ3vlqt2tuClbhrkiI6CaLVo6j/kdV7gmjnlFvTbkCQoqQDz/6O6IF7jSQEg98Vveig
	kTdPdwy+61ClkY3WsTp4t8d7HO7zhLOSDe6lu0u5C0uszckb7BRrv5np2RPiKRvUZ6trO4Menr59G
	KmupIa7gP5tkGsDVrAv0wN0uRa2zR7QEiQ+T8pKYlJ18CEWoX7FcayMoM24VlMbpQh1dpC+Bipup+
	MyVJ+UyWEGFVygbaiUp5qr6+B6MhzGgtSObtyfP6E1s8OHvfBIE4e8/WohOx6h65j+ubHZjn2ibQh
	rFQSBPEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBFA8-0004hc-Fa; Sun, 14 Feb 2021 11:02:00 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBFA5-0004gv-KC
 for linux-nvme@lists.infradead.org; Sun, 14 Feb 2021 11:01:58 +0000
Received: by mail-pf1-x433.google.com with SMTP id x136so2473614pfc.2
 for <linux-nvme@lists.infradead.org>; Sun, 14 Feb 2021 03:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gSY8TzHJG8TmY74JEic0pewbd6JhRX1mMwRY5sl3SUg=;
 b=oidTW/+Ufs68E2jDIK6KYueoo/79RN61T3EA0oZRsjBCznubjLG8FUf10pj18p/AzB
 uT7fTa58gJ+11MePHDdA3qZRo9i8/oX9foa0oovP0vRgV8xdUbUImtrUqnZGXWH5amLJ
 S0oKoD4cFZYsDpZhDrW/CUESZDls2FhjNmWMhGaTonIyhCNzke/3I3lvCy6w6MW6jxK0
 JBvHJU+Zt+8MnUR9MVIyYtDsL6wyLoxbpBeRhL/+taT/9pjC5H6aHtkeax2m0jNs3OkF
 b2MJs1+Zso0tQe2EbtEvkOW2nm1DrFcgSTyX7S/Rp2QSDX+QSbcXb98bjdcF+NqNkAss
 Nmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gSY8TzHJG8TmY74JEic0pewbd6JhRX1mMwRY5sl3SUg=;
 b=GN3GTFo+cw/tKS/s9LXJl8hE2JJ4cG8n906BIh++b811T3m1r5fmYExOBzPYtOc6wi
 WGLZIV2CNZUkTq9y45oCglq0luUQm+pOSnLKS3rs1s7djPDUXsi8PKuA7c5m2Q2qqZTc
 jS1KtJkg8ZpFJVSHuDSuapJVzd/IdgrH1R8xLfKIT++DLuy2x6GyxrA5kuNHjNVAHd6E
 D76OZtZjh/58AvIJ+fI8/yJpNGePP5K4smvfn/bk0XozELA5P2SYfoFnOWrYlfgTOLOQ
 GpGrjGFWesLYm28W1NaKWmfXE1qRQb3OuTwPuVfsXsfG6IXZKMzfHijiQBQxyALjuJ7c
 DpZw==
X-Gm-Message-State: AOAM533t3TNCRqIR4F0OvsJ206wU2foajmVtaN8XtI1kfh3j5KnAdeNW
 ZFTPrCTRft4dnW+095ML8PhQyjjqrVfa6g==
X-Google-Smtp-Source: ABdhPJxmR3/D/qSOvaVbe8KlUY6muGDI4Iam30TGSuZcbm7PmU1LIpg4YjggBvo7+gI2mCuxYpV+fw==
X-Received: by 2002:a63:ee4e:: with SMTP id n14mr10961300pgk.422.1613300515401; 
 Sun, 14 Feb 2021 03:01:55 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id d5sm14223514pgd.86.2021.02.14.03.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Feb 2021 03:01:55 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: introduce passthrough ioctl for multipath
Date: Sun, 14 Feb 2021 20:01:25 +0900
Message-Id: <20210214110126.24023-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210214_060157_704942_EE485008 
X-CRM114-Status: GOOD (  18.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We don't allow NVME_IOCTL_IO_CMD ioctl in case that a controller has
multiple namespaces attached.  Also, I/O request to the controller
character device has not been recommended and deprecated because we have
block device to I/O with where the multipath consideration is taken.

Once kernel decided a path to I/O for a namespace based on the I/O
policy of a NVMe subsystem, userspace is not allowed to choose a path to
I/O.  If a path is broken(inaccessible state in ANA), then it will not
try to I/O to that path.

This patch introduced NVME_IOCTL_MPATH_IO command for controller
device(e.g., /dev/nvme0) to support multipath I/O passthrough for
userspace.  Regardless driver's path decision, userspace can target a
namespace to I/O.  In this case, `cmd.nsid` will be used to find out the
namespace instance target which is hidden(e.g., nvmeXcYnZ).

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c        | 31 +++++++++++++++++++++++++++++++
 include/uapi/linux/nvme_ioctl.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..fed9fc41b021 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1707,6 +1707,35 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
+#ifdef CONFIG_NVME_MULTIPATH
+static int nvme_dev_mpath_cmd(struct nvme_ctrl *ctrl,
+		struct nvme_passthru_cmd __user *ucmd)
+{
+	struct nvme_passthru_cmd cmd;
+	struct nvme_ns *ns;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
+		return -EFAULT;
+
+	ns = nvme_find_get_ns(ctrl, cmd.nsid);
+	if (unlikely(!ns))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!(ns->disk->flags & GENHD_FL_HIDDEN)))
+		return -EINVAL;
+
+	return nvme_user_cmd(ctrl, ns, ucmd);
+}
+#else
+static int nvme_dev_mpath_cmd(struct nvme_ctrl *ctrl,
+		struct nvme_passthru_cmd __user *ucmd)
+{
+	dev_warn(ctrl->device, "CONFIG_NVME_MULTIPATH should be enabled\n");
+	return -EINVAL;
+}
+#endif
+
 /*
  * Issue ioctl requests on the first available path.  Note that unlike normal
  * block layer requests we will not retry failed request on another controller.
@@ -3329,6 +3358,8 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		return nvme_user_cmd64(ctrl, NULL, argp);
 	case NVME_IOCTL_IO_CMD:
 		return nvme_dev_user_cmd(ctrl, argp);
+	case NVME_IOCTL_MPATH_IO:
+		return nvme_dev_mpath_cmd(ctrl, argp);
 	case NVME_IOCTL_RESET:
 		dev_warn(ctrl->device, "resetting controller\n");
 		return nvme_reset_ctrl_sync(ctrl);
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..38bd330e5416 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -78,5 +78,6 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_RESCAN	_IO('N', 0x46)
 #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_MPATH_IO	_IOWR('N', 0x49, struct nvme_passthru_cmd)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
