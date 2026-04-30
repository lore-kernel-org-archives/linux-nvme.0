Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3E2FF886F
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bUxnK5Tlijf4zcNU977qodtjtr3FCtb2K0BBsjh4GJg=; b=ox9k4TUne7fKa7PNRC0JHaHopW
	ayLlsBIKt/Vxp5Y+ysCsiGhKinxB1I0dnkHVamVM98SI47jZsfSAr1oitkQ4FKa1oEqy19bV19Wox
	jYetJOH1trdHDB9CiE++I/SVUlj+gZ5QSm6neQbSC8HRcqTkOHt4fzZO4pxsRfHx0Wxg4TyTTiA8o
	fIawq5TxuXzERMtgU2L25mBB43vt+7Nq2hcOje5h1CtyLtodJbWxew8TZ6yoh9smg7ii0fkiiw+MC
	oHbiis3J90jibZDWrAi3SQEHjAjc8R3O02v8DRAGMgv3YiFXqQJqNpLgAnw6KfC6KfAlKzmCqDTVc
	klkfb23A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapX-000000066kN-2Z3E;
	Thu, 30 Apr 2026 23:30:03 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapV-000000066hT-0L10
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 23:30:02 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-483487335c2so16074985e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777591799; x=1778196599; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUxnK5Tlijf4zcNU977qodtjtr3FCtb2K0BBsjh4GJg=;
        b=GYAhYe0g1y3lJvixBbAmwCPaxv0I905+Sa2xjv7d1Uaqwj7LDyvWiVz6I+SSLWhslt
         1CHeqwK0TYWQoXTwBpPtwCxbfQuZdzMab9ZJjFYw4qiQCxR6K1lvYzV3/OZugaJTu6zb
         UVOPqud+d46LqHSQdASoBfj0IYvxPt78YuqoWIh/mfwo8ocK4mU7iAtkRCjNeJgzAVtz
         qRPmKWguuFYv9M2EeTRsn8p0qK6j9wtzZ1TU7oqNdxNaYMaXVUOHgy7zR0YANCMPq3qn
         dlBVF8MsnIzohd2blKiMH4uvq6k5uo4UeIIJyGvMih2K3ttxoRYDheklOUOJTGmj7C37
         BnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591799; x=1778196599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUxnK5Tlijf4zcNU977qodtjtr3FCtb2K0BBsjh4GJg=;
        b=EyLinCShDxVP+/O+M4oC3ojbMOMXYgqifjn0BMngpxRDXR5byXhklQWVlQ0ipZe+SD
         iIwsBJRt/1cv2p+AviQ6Bj6O0AOrKkf1Mt2TIFqLWrrkKQalCngW5CBAMDmcQNPZn8CB
         c+uos4WQ00JMS1Zbg1kz3orZXk6UBk+XbLoVD+zfUGikXYlgSCiSZ6VU4WpVg+Jjqo7s
         0taw8VkLI6uWwBQAQv5uEL5EochPT8XxenwgJ3iL0jNIFECY2NkBBnyziTpgcdhOOLrC
         uptlSYL7PKiLDUPl5UL7l2hWtORIaEn70FHV1taFZBcmm5ke/DlY5naXJnNO7U9+0v1n
         J79A==
X-Forwarded-Encrypted: i=1; AFNElJ8O41m0hlOqLOAHXSnXd1jKPScTtXm7L20afI/+1iLkbFOX8lKoqUGzBzyXeEmUXw6e7MYtoDVZVBTX@lists.infradead.org
X-Gm-Message-State: AOJu0YzrNiHOtUsQo6s5gqQJTUY85pPB6ijrWi/2T6jJ7LZrOanZL1Mp
	sZaHeeKROyTiHA+zyPDjpHWMuhMvM+e3S095Kswmt5/X0KuVTB9xT1NQl+4G1KtSzMU=
X-Gm-Gg: AeBDiesog4P3IKwltO7q4KIEqrr0GJwltr0nybgF7kZSULYOHwzkjkZcm8y8e3D6X4o
	tAAB7eLbiprtqkHxpeSp0xRxEbz0dmnnQf+EAyuU9Dsdc1fr9NrS0L+NTrz42UYpaTP9WHEZU8/
	EzSgw5vpnEiwC9iylzleQELztskZh0HXSWp9LoXJpRn7Qlo9VLB4YkO2ljeJ5d32m2cQKcU9M2F
	pBZE0LR3J8Tjvr6Iia5hAMLea3nQX+ujFtXkt5b931oESkJZwdkZDw93n9g32E39EQxv72VujFI
	GU/oUaGmHD98rDhAPkvaT6AGvowww3hnhPDr/TCwnNCGHoIO1s7/sQakJ9P5J1AF+KKCp4Z4tBW
	zaMz6aXtuUoW6JVqbQcBRnUcfOzI4DeWu2htx+c9CUmvPzolvoceDYx8bxmu/RHKddo089lsLu1
	o7eHj01jN7Zbs6tEchxuynNN/NpfQ1cHc4wByT8qd3PO1sw9bop8PH8j2OZlqb+lWEFfxHUoatt
	rXrNyTRiV/Mfnme8GYbMg8XJmmTuf+KtoipZ2da5YXR8pW28bE=
X-Received: by 2002:a05:600c:8b44:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48a845281acmr79502295e9.21.1777591799264;
        Thu, 30 Apr 2026 16:29:59 -0700 (PDT)
Received: from dev-randyj3.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm11942715e9.10.2026.04.30.16.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:29:58 -0700 (PDT)
From: Randy Jennings <randyj@purestorage.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org
Cc: cleech@redhat.com,
	mkhalfella@purestorage.com
Subject: [PATCH 5/7] nvmet: Added debugfs fatal opcode
Date: Thu, 30 Apr 2026 17:29:11 -0600
Message-ID: <20260430232913.129271-6-randyj@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430232913.129271-1-randyj@purestorage.com>
References: <20260430232913.129271-1-randyj@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_163001_151074_8FA7B44B 
X-CRM114-Status: GOOD (  12.91  )
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

From: Mohamed Khalfella <mkhalfella@purestorage.com>

---
 drivers/nvme/target/Kconfig   | 10 +++++++++
 drivers/nvme/target/debugfs.c | 38 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h   |  4 ++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index cfcc652c6f9f..8386ffedf645 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -136,3 +136,13 @@ config NVME_TARGET_DELAY_REQUESTS
 	 NVMe over Fabrics target, which allows for support of the cancel command.
 
 	 If unsure, say N.
+
+config NVME_TARGET_FATAL_OPCODE
+	bool "NVMe over Fabrics target fatal opcode"
+	depends on NVME_TARGET && NVME_TARGET_DEBUGFS
+	help
+	 This is a testing feature to allow specifying an nvme opcode as fatal
+	 opcode. When nvme controller receives fatal opcode it will execute
+	 the request with specified delay and drop the connections to initiator.
+
+	 If unsure, say N.
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index ae45aca728ea..28ab22ab3da8 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -206,6 +206,39 @@ static ssize_t nvmet_ctrl_delay_write(struct file *file, const char __user *buf,
 NVMET_DEBUGFS_RW_ATTR(nvmet_ctrl_delay);
 #endif /* CONFIG_NVME_TARGET_DELAY_REQUESTS */
 
+#if IS_ENABLED(CONFIG_NVME_TARGET_FATAL_OPCODE)
+static int nvmet_ctrl_fatal_opcode_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%02x %u\n", ctrl->fopcode, ctrl->fopcode_delay_ms);
+	return 0;
+}
+
+static ssize_t nvmet_ctrl_fatal_opcode_write(struct file *file, const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct nvmet_ctrl *ctrl = m->private;
+	char fopcode_buf[22] = {};
+	int fopcode_delay_ms, n;
+	uint8_t fopcode;
+
+	if (count >= sizeof(fopcode_buf))
+		return -EINVAL;
+	if (copy_from_user(fopcode_buf, buf, count))
+		return -EFAULT;
+
+	n = sscanf(fopcode_buf, "%hhx %u", &fopcode, &fopcode_delay_ms);
+	if (n != 2)
+		return -EINVAL;
+	ctrl->fopcode = fopcode;
+	ctrl->fopcode_delay_ms = fopcode_delay_ms;
+	return count;
+}
+NVMET_DEBUGFS_RW_ATTR(nvmet_ctrl_fatal_opcode);
+#endif /* CONFIG_NVME_TARGET_FATAL_OPCODE */
+
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
 	char name[32];
@@ -245,6 +278,11 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 	debugfs_create_file("delay", S_IWUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_delay_fops);
 #endif
+
+#if IS_ENABLED(CONFIG_NVME_TARGET_FATAL_OPCODE)
+	debugfs_create_file("fopcode", S_IWUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_fatal_opcode_fops);
+#endif
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 845072cf4fae..183f71bf27a4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -317,6 +317,10 @@ struct nvmet_ctrl {
 #ifdef CONFIG_NVME_TARGET_DELAY_REQUESTS
 	atomic_t		delay_count;
 	u32			delay_msec;
+#endif
+#ifdef CONFIG_NVME_TARGET_FATAL_OPCODE
+	uint8_t			fopcode;
+	u32			fopcode_delay_ms;
 #endif
 	struct nvmet_pr_log_mgr pr_log_mgr;
 };
-- 
2.54.0


