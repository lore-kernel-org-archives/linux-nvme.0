Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E77C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 07:08:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B496145A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 07:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B496145A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Uj1T07sQ5aJLw0z4FxmO03dvNSMf0TLmUnHrc64d490=; b=kbLP2x78aTeYAHVUorwCNz4LY
	XzoTAhXZsRuKbJars/+1ZOeCt++eLzdfRzLKgnGjDGPUqFNvo0JvYMbfDzhBq3dOAh4X1SpeEekhk
	XcoXtTkRvLpmj8ELnh+5pDSdItla73qvJVAtqAsjJ0A80t+8TEfNULM0uevXwVxX0+wCrpwyER1SU
	GVB8qpSzAweECq8V5p/hUiU8B/MZ5qZccxxNipI43AK4lAav0awYaq4WA1q8iVY3/S2qPzSU2M/uT
	GFwOf5BwrreIXWz1IOzVZeGRkUvBiXzAgEkxyznS5U40vbRXQm0E+aQFNTEd/HKlWJlylFBJlBk1Y
	tu1n5MRhw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZTRR-00G6Or-H3; Thu, 22 Apr 2021 07:08:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZTRE-00G6MR-0x
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 07:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=LlbTZOV5EtlntOlIhqLYYXDJH5qPZ0wxiHfU1CVeEFk=; b=PtMq+ME/VPmJi9PE2hmhsrRje3
 8nsA9bx/z/zran5XsMWDzGWmaXtiKVu4e01owBUrFuTFraB3qJb20HhTmRCXz4s5cJNxXOvNFAaIG
 C+MvH1+KibjVvHUxrbu7OurjznEz4qemt5TFzVeYlpsk5h5+HsdyxxUd/jwoYjh/92owIh0FIqT0d
 7Tfq45PnlUFve5uhE4q6zS94N75Xu+O6/SkhJRFvyStg7NhaRW20axj885saKrTAcpHHs+TS+RYwf
 kFbPWqAK9QGAtRVlx3dawYBIvhJrC2SwYUxxHfVzqLvJjKeC08cvzuOJfeUVWI/eWZchx0fYqSBFr
 wr2vWRrw==;
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZTRB-00DRBg-Gj
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 07:07:46 +0000
Received: by mail-pf1-x429.google.com with SMTP id h15so13346522pfv.2
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 00:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LlbTZOV5EtlntOlIhqLYYXDJH5qPZ0wxiHfU1CVeEFk=;
 b=t3cmWQCwzL4Ud/JKDtNNoGlCrZj1/iwPIwOQ1+5spPAD8VT1Xmn+h8wRqU9Xs8exRu
 rBdCsLVTq8odnd4WZnBh7045kTWP5nXkqA/pZSx1PG28YwJS2v8X73HXb2VEVJjHl+77
 TTujdR8WXRgBwS4ld4ueW3n0Jn7jwQbhh5i792mTsxOsoVgKA/psoQ4s7FM0quUzGxTa
 9k4Zbo2Q9e4rKKsGkNcg4UUVC0nsw7sGpwoiaTxTDMSYeHqVsmrxFK/idAeJUJFy47/E
 t7TH52A32sygcOzRo0Zk4XB4DNZLFVQ0nxwu0J+kxoIocEBLerK3s8b1Y4OJC/9/6lza
 FmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LlbTZOV5EtlntOlIhqLYYXDJH5qPZ0wxiHfU1CVeEFk=;
 b=lIIhf9PALUpweuPatU42G3KIcvBdYG/9pflaqEMR9h4kEuHqOH0Wf4ewJNbO7WXkB6
 hVdHequJCsulvbe7OBESokOqJBGjJTNo17zbWlZ6ODpdKopblOfxLsw0JsS8gl1nKGm1
 h36m/neyBBPjLQBnhwHztJ/YLHhBKJAaEJKNDJmuRXSH5E/0d5hBAYyAkz7Vh21iCd1t
 NFU42N/uurKvUEmMwxPsG37+wWGDCn5PaH4IVi2VsNa2rjEbkMkhCindzk79hSMkkqXE
 /QTc9aIaZVRSCgZWKFsotlnXDRi3nuA58V+ZGS5uREQQj78YrhMjAOyyPvaTFY58STCe
 0xyw==
X-Gm-Message-State: AOAM533XTi6Oc+f5QZSxQNxc9dho4+5QV7tsoa19CVsQd+SN8HZDUkp+
 jksvcWil7Yi+bOdDQxyZ1ThB4Kaj2lwMeQ==
X-Google-Smtp-Source: ABdhPJx9GmRsD20k9mGgBjCUNaTgVL2v//AMlVSucWGGv2HMXsZA7gQCV0jd4Ll8ZsFoeiKlzg3FJQ==
X-Received: by 2002:a63:e515:: with SMTP id r21mr2106038pgh.412.1619075264525; 
 Thu, 22 Apr 2021 00:07:44 -0700 (PDT)
Received: from localhost.localdomain ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id u17sm1174914pfm.113.2021.04.22.00.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 00:07:44 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 1/1] Revert "nvme: don't bother to look up a namespace for
 controller ioctls"
Date: Thu, 22 Apr 2021 16:07:35 +0900
Message-Id: <20210422070735.25855-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422070735.25855-1-minwoo.im.dev@gmail.com>
References: <20210422070735.25855-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_000745_573570_0FB4DBC6 
X-CRM114-Status: GOOD (  17.24  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This reverts commit 3557a4409701a132e8f86ad234ac8cf6e97b052e.

If we simply retrieve namespace from the given subsystem, controller to
be retrieved might not be the one which is really attached to the given
namespace.  We should consider the namespace attachment with controllers
in the subsystem, so this patch simply reverts the previous commit.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/ioctl.c | 47 +++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8e05d65c9e93..9494e3d11e89 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -358,40 +358,43 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 }
 
 #ifdef CONFIG_NVME_MULTIPATH
-static int nvme_ns_head_ctrl_ioctl(struct nvme_ns_head *head,
-		unsigned int cmd, void __user *argp)
+static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
 {
-	struct nvme_ctrl *ctrl = nvme_find_get_live_ctrl(head->subsys);
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
 
-	if (IS_ERR(ctrl))
-		return PTR_ERR(ctrl);
-	ret = nvme_ctrl_ioctl(ctrl, cmd, argp);
-	nvme_put_ctrl(ctrl);
-	return ret;
-}
+	nvme_get_ctrl(ns->ctrl);
+	nvme_put_ns_from_disk(head, srcu_idx);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
 
-static int nvme_ns_head_ns_ioctl(struct nvme_ns_head *head,
-		unsigned int cmd, void __user *argp)
-{
-	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
-	int ret = -EWOULDBLOCK;
-
-	if (ns)
-		ret = nvme_ns_ioctl(ns, cmd, argp);
-	srcu_read_unlock(&head->srcu, srcu_idx);
+	nvme_put_ctrl(ctrl);
 	return ret;
 }
 
 int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
-	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	struct nvme_ns_head *head = NULL;
+	void __user *argp = (void __user *)arg;
+	struct nvme_ns *ns;
+	int srcu_idx, ret;
+
+	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
+	if (unlikely(!ns))
+		return -EWOULDBLOCK;
 
+	/*
+	 * Handle ioctls that apply to the controller instead of the namespace
+	 * seperately and drop the ns SRCU reference early.  This avoids a
+	 * deadlock when deleting namespaces using the passthrough interface.
+	 */
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(head, cmd, (void __user *)arg);
-	return nvme_ns_head_ns_ioctl(head, cmd, (void __user *)arg);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+
+	ret = nvme_ns_ioctl(ns, cmd, argp);
+	nvme_put_ns_from_disk(head, srcu_idx);
+	return ret;
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
