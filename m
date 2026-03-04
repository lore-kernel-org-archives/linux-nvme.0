Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288FEEF9001
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/4Y/mgugOFcKKNxSVMEr3vI+i8NKRaR2c1wrGwr3hZs=; b=Ha18CkPidmti4vO/wBpBSqq/HT
	FxSshLYjsD8jNT44EyOGn3l+UgLPqy3R4ygPi9TAB/hPaNpuRyBlaUH/JC3P9cSi8MDwCZ5mKYPrr
	Pvh7Wy1sFFMZEGJaBGWbL6nRCSd2vWHZ0R7Lf4z0DGpgG1wuSBKXCsnFRgnE7ra6QtFb12r/TxO/H
	lWmWM6xahWtzjLqwgzQH7ZnldBEpf/tQspp89FXjsjnKpVrU880aCf2pU8pzLusbFV6J8qnUqFZ+r
	p02iI8jpAlJbjmMGR+9JYuZzLmiX/jy3ULufHysfJ9To1abfEl1BHHO2SDrGgwjqA0rKDMYjNqRi7
	jVHYtoDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxpHT-000000005zb-0Tb3;
	Wed, 04 Mar 2026 16:41:03 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxpHQ-000000005yl-0aAp
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 16:41:01 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82742aa5a3eso3560175b3a.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2026 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772642459; x=1773247259; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4Y/mgugOFcKKNxSVMEr3vI+i8NKRaR2c1wrGwr3hZs=;
        b=ISX3v3RNbfjxTDEvf2+23pblTnjPb/j5d2gDLQAXnikeWUXq9wpsy8Mg0+JbFeK1pQ
         seCtNYp8R9rcP/gwTJoWl/9/Xbvep8kzQMMOslcgiMxW1P04+86JXeUrryhRBzOjxJvd
         gUEjeJtST/oDXg3+dUYadZStQXtoQAJu8KamTNERevlM/xRicoIAmrPZTYImQgvXCpeG
         S7ORvN+i7q4JSO/X8UReAMQg8lYvECI6RbwLVRl1jdnyL9LJp9HlbXiSVsfxAqW+iW8/
         9nUVHgStLn2kX/7z9sAQI5GFvFAoBqRJ0tYmgX66pPJROFOtq4aVyMal/9kp7PYIPOVq
         9ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772642459; x=1773247259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4Y/mgugOFcKKNxSVMEr3vI+i8NKRaR2c1wrGwr3hZs=;
        b=ZwIhTiMGxO1M8swVNH3n44gS5chhXQnwuB6Joys9r6uZNCQz3Hv14GCTfR38IRcQvs
         XuX13E8BctOU5Z9y01D4x71BUSeQrM9Eymnbz3n/uJIKer/MMnOEipFhwLAJl0CfiapU
         /0P3mGKm9g+urZmBq8vK18qqA9mf4YoM8G/nJXTL5gj7eeMZC+kYVoC5UTxXEorTuwTF
         Rgpv0ZFJe+k6eyOs2Ou88zm0VtR0X7AU3HcOu6TWMvcCfy5OBXxjuTFpGCCctnOjE6Dx
         ft4rmkXGWVIcxh6sPp24zQZw+iqZ2/5Z3fFuDOMhq+tee4OUAypi0NuurykjxvzxFjwP
         gC9g==
X-Gm-Message-State: AOJu0Yz5oqrx9b4XUCx4e5PUH67o2p6187sO7hlHXHOGbYxRQ+dPhzKp
	KM6iIVVduRnmbU9n7iL2djxFvV4ktdno99IZofYR2JRi7TkaCM7fTcRprkgIFA==
X-Gm-Gg: ATEYQzxS2uXVqYO9eZsLex++c+T/aacNpsWC99f8QW0KDBRcTy47RJW6BOwTI8aUaEx
	vUpCLmtUqt3VLvRSmvljx0kVSJLvhJXrs+I+/MZ4gPlgB/KIoe57em8aEcTULYRyrZgptgyYH+Q
	3Dc1/BUkM0yfaNs9Cqcp+8kmLXgszhMtb8n/vkA6CAbJKlte1TxvttIQqbcQTpcpb1CSjxmGyhq
	0GZwcVrFCRgNTBp2sYU9emnvG//miAiFLij8z2Klfxi2NN/Z7O7uxIJNux3Nf1Z0j6OQc5APf7+
	DGsQwUPIpmhW0CvWym4esF+CYxYWYWjLwt3Tb+Dr2JzI1bRVAMFig5d1FfEcKK+RPO8mAsUP5fD
	OIJnVJoOukR/VoGmWBqKGzI/Oc5EwTn/o36MW1XaKHGrjanMyGAHs1joYBdnEx2oEGO0hDOdwQM
	7uCPVvkPG9+Jb/VS+768V/PZb1oZaqCWa8qWKA
X-Received: by 2002:a05:6a00:f0d:b0:7fb:f87d:a0aa with SMTP id d2e1a72fcca58-82972d6152dmr2527792b3a.52.1772642458601;
        Wed, 04 Mar 2026 08:40:58 -0800 (PST)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:8233:ca2e:21d7:331d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8296c9f83f3sm2397616b3a.0.2026.03.04.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:40:58 -0800 (PST)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme/ioctl: combine nvme_user_cmd and nvme_user_cmd64
Date: Thu,  5 Mar 2026 01:40:22 +0900
Message-ID: <20260304164053.307236-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_084100_185256_2AFB06B2 
X-CRM114-Status: GOOD (  14.79  )
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

The functions almost duplicated but only changed result value size.
So combine the functions by adding a "bool is64bit" parameter.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/ioctl.c | 83 +++++++++++----------------------------
 1 file changed, 23 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8844bbd39515..44340f5167f1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -280,8 +280,10 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		struct nvme_passthru_cmd __user *ucmd, unsigned int flags,
-		bool open_for_write)
+		bool open_for_write, bool is64bit)
 {
+	struct nvme_passthru_cmd64 __user *ucmd64 = (void __user *)ucmd;
+	unsigned int flags64 = is64bit ? flags : 0;
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
@@ -308,54 +310,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
-		return -EACCES;
-
-	if (cmd.timeout_ms)
-		timeout = msecs_to_jiffies(cmd.timeout_ms);
-
-	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, &result, timeout, 0);
-
-	if (status >= 0) {
-		if (put_user(result, &ucmd->result))
-			return -EFAULT;
-	}
-
-	return status;
-}
-
-static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		struct nvme_passthru_cmd64 __user *ucmd, unsigned int flags,
-		bool open_for_write)
-{
-	struct nvme_passthru_cmd64 cmd;
-	struct nvme_command c;
-	unsigned timeout = 0;
-	int status;
-
-	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
-		return -EFAULT;
-	if (cmd.flags)
-		return -EINVAL;
-	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
-		return -EINVAL;
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
-	c.common.nsid = cpu_to_le32(cmd.nsid);
-	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
-	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
-	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
-	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
-	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
-	c.common.cdw13 = cpu_to_le32(cmd.cdw13);
-	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
-	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
-
-	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
+	if (!nvme_cmd_allowed(ns, &c, flags64, open_for_write))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -363,11 +318,16 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, &cmd.result, timeout, flags);
+			cmd.metadata_len, &result, timeout, flags64);
 
 	if (status >= 0) {
-		if (put_user(cmd.result, &ucmd->result))
-			return -EFAULT;
+		if (is64bit) {
+			if (put_user(result, &ucmd64->result))
+				return -EFAULT;
+		} else {
+			if (put_user(result, &ucmd->result))
+				return -EFAULT;
+		}
 	}
 
 	return status;
@@ -552,9 +512,10 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 {
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write,
+				     false);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write, true);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -586,7 +547,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		force_successful_syscall_return();
 		return ns->head->ns_id;
 	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, argp, flags, open_for_write);
+		return nvme_user_cmd(ns->ctrl, ns, argp, flags, open_for_write,
+				     false);
 	/*
 	 * struct nvme_user_io can have different padding on some 32-bit ABIs.
 	 * Just accept the compat version as all fields that are used are the
@@ -601,8 +563,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		flags |= NVME_IOCTL_VEC;
 		fallthrough;
 	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, flags,
-				       open_for_write);
+		return nvme_user_cmd(ns->ctrl, ns, argp, flags, open_for_write,
+				     true);
 	default:
 		return -ENOTTY;
 	}
@@ -836,7 +798,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 	}
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 
-	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
+	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write, false);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -854,9 +816,10 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write,
+				     false);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write, true);
 	case NVME_IOCTL_IO_CMD:
 		return nvme_dev_user_cmd(ctrl, argp, open_for_write);
 	case NVME_IOCTL_RESET:
-- 
2.51.0


