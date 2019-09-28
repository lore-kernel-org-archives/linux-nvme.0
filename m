Return-Path: <SRS0=LLk8=XX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB40C4360C
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Sep 2019 02:15:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945F12086A
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Sep 2019 02:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oy1gf3nY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDZ2m4To"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945F12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=MJXFqFaz1lcRMjF+FqNQvByPLL48EPpMFMhg7HKCAOI=; b=oy1
	gf3nYioBypVxxMQ60fJQc3FLU4EzRq2dcmoxLtUJAHx/S38IvM9WFUkRfbrU74XwxUu9sJatzecXG
	rATz0SA1KBzRsH48fGqXj7CnnbMfvicVCHxPKuv0NFIQoDoT0PL5wavnLLfwN4o+J9XYZIQJl1MdI
	dOvl0B5uB30Yp6AYyBUuJ15fPJGtYlCkMj6wz/jKJYRL6IsmEIShVhzG3JqOZTLASwf+0U6QysmpM
	aYhGl8XbWi+HPnMY6Esh3YSrWJ0hTLfTpdqMidaSyKYkUQ4Z+tBDqZ07oNVCzDlacTdONLyqzS8vr
	IUgFUVAZ6iNXixVL7thOk91dcuh/MFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iE2GQ-0002ow-Js; Sat, 28 Sep 2019 02:15:14 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iE2GN-0002hL-91
 for linux-nvme@lists.infradead.org; Sat, 28 Sep 2019 02:15:13 +0000
Received: by mail-pl1-x642.google.com with SMTP id q24so1734471plr.13
 for <linux-nvme@lists.infradead.org>; Fri, 27 Sep 2019 19:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=NJlDoj9HP+rVXFpE4yt/EMeZR1QqlUqXvtLvwbZ7F+c=;
 b=DDZ2m4TotFmTSG2d8qRD9qwaoKvEcHOCVHy6yxsCxinHNtc6hjWHXijOSlXBguXCoJ
 /i8ohmOvLg4tNEJhA3rDB9W4sqiobLkjvsQHLMwfco6lvMmnmuRXmShoQovHDhkgHC5L
 DCbIhzYScLzei5em5lL4a00ubXMOYyv5dfksqoxmcZe+J4xftOygy7RkndW0u3GEFe5x
 6VZPgOn47g+NrgxBi06ycf1ICYnru0IwCSKbWYZiJ9hNtwfqNo+aAEDodZcgaHQFgG//
 3WVLTeVTOzNFe3u8XGr1RZXPe31aIuyDHpL5I7ygzph3cDlsBDwExp8BMsBnk1z8L0vR
 cHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NJlDoj9HP+rVXFpE4yt/EMeZR1QqlUqXvtLvwbZ7F+c=;
 b=Neyc4eKbZu9KDK9K3xOkmbUoWGVZEx957OTCplBeU6RuPqGHOWERuIL0NCYOC08MtL
 T6mTvlgOkFtDaKK/qaidxdIu2RBhfoxKkS3hWiJAS5IUCfMFAyu2SPKXAs4ZNxcu1W2I
 4DwM5qUyIEzAa/xRH8dDSW4fyPEz0iiBsqmndLV03zqZ0QYNhnpZ9WXu10JFxDjKV2ct
 OjSmUZC77mwux6KXlTiKyNw1/c4eGQ7S/OSCZmSPPdn1C1qe74oOv187ponJhhNpP9yj
 4xC25Cnpy9RAhoeto/lGRSQ5Y54+bUV08NSXTAqdl8elHpLXE0iT9MPk3nuV+xGSEcjR
 +uLQ==
X-Gm-Message-State: APjAAAVn11XyMD6f++b6J/24TPcSdJkM0QuyN/SFIXnqC59t+NsZxz07
 UEBbigCQEAhL4xQ5yy1UJa0=
X-Google-Smtp-Source: APXvYqx562l8wsVDSFFPqbIRe7tDc9JREdQ/Cek6onUdfPXE8AtEs3n5qIZv7OKS9v0wcpJ4DY84oQ==
X-Received: by 2002:a17:902:d681:: with SMTP id
 v1mr8293210ply.310.1569636907382; 
 Fri, 27 Sep 2019 19:15:07 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
 by smtp.gmail.com with ESMTPSA id u4sm4715125pfu.177.2019.09.27.19.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 19:15:06 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: look up proper namespace in NVME_IOCTL_IO_CMD
Date: Sat, 28 Sep 2019 11:15:00 +0900
Message-Id: <20190928021500.31382-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_191511_343131_B4E8A73B 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVME_IOCTL_IO_CMD is deprecated because IO request for a chardev is
unsafe.  But in case userspace gives nsid, kernel should at least look
up the proper namespace instance instead getting the first entry and
checking whether if it's the last one.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd7dea36c3b6..5bb29c932d31 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -93,6 +93,8 @@ static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
+static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl,
+					unsigned int nsid);
 
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
@@ -2888,33 +2890,18 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 {
 	struct nvme_ns *ns;
 	int ret;
+	struct nvme_passthru_cmd cmd;
 
-	down_read(&ctrl->namespaces_rwsem);
-	if (list_empty(&ctrl->namespaces)) {
-		ret = -ENOTTY;
-		goto out_unlock;
-	}
-
-	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
-		dev_warn(ctrl->device,
-			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+	if (copy_from_user(&cmd, argp, sizeof(cmd)))
+		return -EFAULT;
 
-	dev_warn(ctrl->device,
-		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
-	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
+	ns = nvme_find_get_ns(ctrl, cmd.nsid);
+	if (!ns)
+		return -ENOTTY;
 
 	ret = nvme_user_cmd(ctrl, ns, argp);
 	nvme_put_ns(ns);
 	return ret;
-
-out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
-	return ret;
 }
 
 static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
