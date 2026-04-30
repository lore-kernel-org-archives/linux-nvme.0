Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5250AFF886F
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 23:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sZ3MYQyJmEClRhlGgD4QYVjEMWNNY52NKls5J6JSyuE=; b=gOZQgxIzhlwoTotHdLANQej3Dj
	jXLxkBBBb/RKK0M14CJMW3Oz15D3+o5j6dLK1p2isw1A8KMXtuCYxdRknNK/qNMWTs1aPr0kpxXFP
	+BrfbOdFMzb3IE/O9MVSxkg13CVqGW46E+Pzne4mBGqLWOiIM7vxU1VJuzZwMU/AovxzGGtPVt4Hn
	WXvhO/58xzQ6craAeUhyQu0CtI70FqNNEb28w0joc/u9VFx98rxQuvUrshSc13OhSCiBS6SgVpUgG
	XjGsuV0ev2ZzROO+FRhsPn9XOn3CUM+t2tikLu1otYkbcbHTU7eYDcktCmzS211mLGyNuzWGQJ+Wq
	nqZyMjXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapU-000000066ha-0O6R;
	Thu, 30 Apr 2026 23:30:00 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapQ-000000066en-200V
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 23:29:57 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so20921005e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 16:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777591794; x=1778196594; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ3MYQyJmEClRhlGgD4QYVjEMWNNY52NKls5J6JSyuE=;
        b=UyJppYU+fx2tNKi5o8DL/sVtmcjtzsVt7nVPmwGATAtG+rVYtGt/d+UinaJ/wDgcbX
         UwZeMRLEeaV/e+px3nX/NIlfA0ne2PxxH5S7Zg4Kjof8YGt3KN8mNycQlZ0LixlnJ5HB
         6Ksg7627Of027T81nCiEdhFnHdXbJyWuDdDoBoffSoE3tSeBWq7x/BHip3TPauXuqL4T
         wtz9VIQGJhI+z77q4Iu6pkCYwGO6OE5JiAF4f4PIWczqF3ggYXG1XUARZP7Uv+gieopC
         VwXwgDuuC7tFDHi/95r4bkKrKbZ6nI4NzFjXDuff6BIEQF6yteNW7afh7Z+ve4LYoMZj
         TOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591794; x=1778196594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZ3MYQyJmEClRhlGgD4QYVjEMWNNY52NKls5J6JSyuE=;
        b=jRf/m6VVOQdrbqxvDSp1CoxJjCBR3Mp2tk8tR0ZlDoIxpFCm/yVEb4NVM5oQwsmQsh
         jy7z4cHtgkQQRVrPFTZTWlIVmEvdVaXJdhBXxMG/kBRJ52xGbULB527F49vlERGRPIE8
         HqgICGEYddFqwVT5VCsty5GYc8sdMzW6Rfb1aZDR4E+lkDhBL25q339qd3XO6JNRnGdw
         Jfmpyxk/Lkz0DKt2vG46hCfIPX7Z8kz7NMQt8S/7RGmNpJ/rCQ/3WH/KwKE/lsCY4jGW
         ybeVb19qWMQsBpm90doVhZHcfXhrKwuQs6b1AYKlV3l8rpYolcSalXZOzpOom/xtVL7s
         jyFw==
X-Forwarded-Encrypted: i=1; AFNElJ9ky8G6SRIWl+p/fNV9v73huW6ZGroXCswjaiNCB272p6KFNXO+9Ov+Mup+NRd6sV2jLJrzDQvFwPDO@lists.infradead.org
X-Gm-Message-State: AOJu0YyCxcbP2LyYdcU++nqqVX1jvAkEO6WDL/rUPc1SKkNQ7zPn5Sa2
	WcbNWtTOOB6wJLE0c0ziSDQS0EWzbN6R/YaoyGPcSVToOUqeTR3ZtBtWY/8Hv245PJk=
X-Gm-Gg: AeBDiesXbP8YvzwDV2LpZGLdsxiLeGkuyKckvImLZIuAHpUhPrtpizPRUqjtfCRShfI
	TBNmSm8NHHtsSGa/V8p+VX42wPaJPTPY9gn04ggddbmM/RsC0cy6UpwSwf/ZwWPkkA/CLQKBvKb
	xj47h8BBXcSvMG2xMSkvLdQbYqpTGI1/eso+9Wv4OsMUs3RMlJ2JI+M97XJOdoASswZSlbix/3R
	yENKnIDQ1WrRGt75onzYxG8JZ8jmD+4gZVcWs8FMZWB0KJ8W+nUDFxGm4W+U1KXtSkhbpshIJ4n
	kFFt0ml7MbebyTpvanYkhfEfSXJOxydlgS268IUnVSZGEFz9IBXhxAPsWVBvtqRcVrzj9Y7rH3x
	3gvmBDppdfG5sOB/5OnnBgCJIxHC4P+/CeKfu5NQ01NxZ+rc0L0xJ2Zo2QULTLedUBWLWc/dcMD
	pxHmh5Op1afhH2mlmqPAy4uEdZj6wscDq3znQvAOiBFCJXHFu+n95GKR49HZZ32A5McV15gWofq
	BYGU70mtdnSr39LQObiKHvv6YrpTZnq1AJfyh5wvHEUoMOPt6w=
X-Received: by 2002:a05:600c:8217:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-48a84444973mr87176755e9.14.1777591794459;
        Thu, 30 Apr 2026 16:29:54 -0700 (PDT)
Received: from dev-randyj3.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm11942715e9.10.2026.04.30.16.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:29:54 -0700 (PDT)
From: Randy Jennings <randyj@purestorage.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org
Cc: cleech@redhat.com,
	mkhalfella@purestorage.com
Subject: [PATCH 3/7] nvmet: add delay debugfs file to nvmet_ctrl
Date: Thu, 30 Apr 2026 17:29:09 -0600
Message-ID: <20260430232913.129271-4-randyj@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430232913.129271-1-randyj@purestorage.com>
References: <20260430232913.129271-1-randyj@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_162956_545700_97130207 
X-CRM114-Status: GOOD (  17.18  )
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

From: Chris Leech <cleech@redhat.com>

Creates an delay attribute file on the controler in debugfs
/sys/kernel/debug/nvmet/<subsystem>/ctrlN/delay

Reading this file returns two numbers, a reqeust delay count and a delay
time in ms.  Each delayed request will decrement the delay count until
it reaches 0.

Writing to this file can set both the delay and count at once, or just
the count to trigger more delays.

 # delay the next 5 request by 5 seconds each
 echo 5 5000 > delay

 # set the delay time to 3 seconds without starting a count
 echo 0 3000 > delay

 # delay to the next 5 requests by the current delay time
 echo 5 > delay

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/target/Kconfig   |  9 ++++++++
 drivers/nvme/target/debugfs.c | 40 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h   |  4 ++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 4904097dfd49..cfcc652c6f9f 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -127,3 +127,12 @@ config NVME_TARGET_PCI_EPF
 	  capable PCI controller.
 
 	  If unsure, say N.
+
+config NVME_TARGET_DELAY_REQUESTS
+	bool "NVMe over Fabrics target request delay"
+	depends on NVME_TARGET && NVME_TARGET_DEBUGFS
+	help
+	 This is a testing feature to allow delaying request completion in an
+	 NVMe over Fabrics target, which allows for support of the cancel command.
+
+	 If unsure, say N.
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 1300adf6c1fb..ae45aca728ea 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -170,6 +170,42 @@ static int nvmet_ctrl_instance_cirn_show(struct seq_file *m, void *p)
 }
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_cirn);
 
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+static int nvmet_ctrl_delay_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+	int delay_count = atomic_read(&ctrl->delay_count);
+
+	seq_printf(m, "%u %u\n", delay_count, ctrl->delay_msec);
+	return 0;
+}
+
+static ssize_t nvmet_ctrl_delay_write(struct file *file, const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct nvmet_ctrl *ctrl = m->private;
+	char delay_buf[22] = {};
+	int delay_count;
+	int delay_msec;
+	int n;
+
+	if (count >= sizeof(delay_buf))
+		return -EINVAL;
+	if (copy_from_user(delay_buf, buf, count))
+		return -EFAULT;
+
+	n = sscanf(delay_buf, "%u %u", &delay_count, &delay_msec);
+	if (n < 1 || n > 2)
+		return -EINVAL;
+	if (n == 2)
+		ctrl->delay_msec = delay_msec;
+	atomic_set(&ctrl->delay_count, delay_count);
+	return count;
+}
+NVMET_DEBUGFS_RW_ATTR(nvmet_ctrl_delay);
+#endif /* CONFIG_NVME_TARGET_DELAY_REQUESTS */
+
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
 	char name[32];
@@ -205,6 +241,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 			    &nvmet_ctrl_instance_ciu_fops);
 	debugfs_create_file("cirn", S_IRUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_instance_cirn_fops);
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+	debugfs_create_file("delay", S_IWUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_delay_fops);
+#endif
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index acb2f0f3cdc8..beade281164a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -313,6 +313,10 @@ struct nvmet_ctrl {
 #endif
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 	struct key		*tls_key;
+#endif
+#ifdef CONFIG_NVME_TARGET_DELAY_REQUESTS
+	atomic_t		delay_count;
+	u32			delay_msec;
 #endif
 	struct nvmet_pr_log_mgr pr_log_mgr;
 };
-- 
2.54.0


