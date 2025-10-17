Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04FBCCD19E
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 04:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29Lq2xnZtj+6Sy2WBmqrd6RHyzvurjh80XYGtTuJrGI=; b=Z5qyg7DipCgCr5HzkKv7onF3+s
	+am7c4fZiT+i7EKxBL4XqPj6pdEu78cR/T7arffllPWHh9xWvXzpcEhqviaexmRctr/Pb62rcwpQO
	eqy7fL9APi+zXVBHQBxaucwtxll+HIJdztJQzzcWmiJarPnX1uu+9d4mMdUT9mZpqJzBMItwYBydl
	Vw/LtT2ZVrgHHuBzdN6vCk88Z/3l9c7zjuxdSCEDEbgSJIRCIy5wvZeqFMNeq5BJLjssFGRU5macC
	AJdfUzqLc0jiA2niplV+lSD9GC5blUO3WBvW3/9ilJdmuEltR0A9NTkQJP9Cpy7+o6JHLM/2DD6yQ
	oUnlYX8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c1o-00000006WkX-0V0T;
	Fri, 17 Oct 2025 04:25:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c1m-00000006Wjd-3rQA
	for linux-nvme@bombadil.infradead.org;
	Fri, 17 Oct 2025 04:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=29Lq2xnZtj+6Sy2WBmqrd6RHyzvurjh80XYGtTuJrGI=; b=YTkN/KZkOeNvxcIEZX2ojJCjJf
	Td4h2ik4AzC/HxV8ZCsZOeHJDrpYvzEdCCxmMvG4T0D4q5dp7Fd2fV6GHr+op7MlqyRvXLvD/pzsz
	8CrRI2ntLuUBmmCW+z9LivXaXuFWDvnoidstQYFK2lslWpCMKIQ22fkTcxNh2Ya4ARWDbNKcRivXx
	x3EThmagAdaw36BKQqqD+bMRwoCebLp5tuHj034TlMclALF2SAlv3c9OG5oqfNkXhaVCqH7TPV+i6
	ntZc+Uom9fa9vBohS0PbVUchcODeNXjYDCXns3jUOpijLPYXvPz0Aa8NVgpTjP/zVO1FNDGyYvVeL
	xXEbt8gA==;
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c0h-00000007HcI-3j81
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 04:24:55 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so959817a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 16 Oct 2025 21:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675049; x=1761279849; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29Lq2xnZtj+6Sy2WBmqrd6RHyzvurjh80XYGtTuJrGI=;
        b=jeHljRSjVn+BODxkXdXSqSbTzqPf23BgvpAxF3hlg5YvyA6/iTem5SyBt+WaUB7puf
         2apHnU7ZB4KKIcygD+Dyc5WsY7z2yEvgh7sJe1zc42M7SeBYDlDLqbj10LT1tKSkS6iv
         L6vgoaJuiRLb+Jyj44+Ch+M12xks6+mW1SB0GqMhGPzee+f1xddqi27mXBVRkCtnFisv
         N8+7lKBM6EEhwpgvkasX0W2qG20aimznaUer+vwMOSwhye+T4qtjy2kmTlZ6m8JW9hW6
         9SnfHGC8ttKr0bmNFe+FXzWtXPiS3HbNRYbMy0zYQTi7bQWP3fOC2pg619ejlIVnjGv+
         1IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675049; x=1761279849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29Lq2xnZtj+6Sy2WBmqrd6RHyzvurjh80XYGtTuJrGI=;
        b=FiI5+7lDkdUyLdn1vFWiy3lx0RUFDiyyf8oUhgkQUsD1fQFhGTTfHBXr95TE7IJsM1
         WHYAbpcy2PIwdz02KNSlobv8Jn8InzOdNmg/HuttH27e1YC70xBtRXQ1MtOgv18M2Jxu
         PyQnRoVjz6OEwowwLWT0xQ5O/p5U6RPBzLB8LtTy2P5Y1pUV4FP+ARY5v4/HX1zabCtp
         1FGG7sedWTIBq5UjgEYUJwxpm72ILqNcuUfYb5AWs41TlxgBqg+v6QZDBRMpke6eSZiO
         Fw97Qw3JfErGv/wKoQLpEwBF7+D6YfhUYXD/38P5yGU7kmG0bbHbjyh97x0cIypw7clh
         HI5g==
X-Forwarded-Encrypted: i=1; AJvYcCVxGQy1vbEIxSr6kp/+qNEgl1Kj95dntuuPEAVln2YE1z3PjjoE6y5nlFxUEuVHcW+fCD22vaXBKuDG@lists.infradead.org
X-Gm-Message-State: AOJu0Yzqk9lKGuN6O6ZetnfI/YMI3vpn59cPEWAygPX0ysusHcEfi1Hb
	a7mMTQVSbJ9cSpHY+CZ76tcqI5hEo/tsqhTWCcTVbPx2MnzdbgZXJeQe
X-Gm-Gg: ASbGncte95gLe8bGxkPVIugWXLQkuKTwmpE8WuZKB5wWSZ2ZWFVJu5/quPV7L2tbIRU
	K9ajbtvvO4auwWOzMSSs1Ylne1mVLdtWJwfrrdGVr0Y46+xC4YCjZo3IMSB/EXgu78Q0rgc8wnh
	PllBMEyhiSeQM1zAkxs2ESTkcG1Tfz6Z1FqPTLAEB0qZMtKHyFyjmdRFuAS5QXW/417ARqRLb/D
	wADa39oqIyRIr+MwpO5SaGPLY+PTLYVVAd/tv7+wQsTYkNbC8eSuaktbbgAWvr6A80ZHJo3X22s
	atBCg99q/XCavu852I2HjF7g8+TBZaJaPK9YI8Oxhd0GaTlC8SCUfwKGmX+tJj3h14B6NxJ9hoF
	WF8jH6orN1xiCIwQ1gNafmGO7yXaTDD/F6vE7gUDrHzmvkjdaGqROl03kNgHnrE0Qei6OG7Detj
	K0+HnBStyTXKmzgF2QxR1M6sa0UCDtE7F5XplcNKfdWRqVkESREKypWCZj3wpKK4xIn3t8QDsZk
	pfmSkbxFgQUWy5cZ0eh
X-Google-Smtp-Source: AGHT+IE3Loe/21tReTiMC1KE1PN6nnxQShPQ2aeX3VGqy1tfwwjN0OSJDK1WmyW+Y1kgS8QPEPO/LQ==
X-Received: by 2002:a17:903:1250:b0:290:dd1f:3d60 with SMTP id d9443c01a7336-290dd1f3fc8mr6269945ad.51.1760675048710;
        Thu, 16 Oct 2025 21:24:08 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:24:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 6/7] nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs
Date: Fri, 17 Oct 2025 14:23:11 +1000
Message-ID: <20251017042312.1271322-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251017_052448_944971_CCDB4A3E 
X-CRM114-Status: GOOD (  15.20  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace to trigger a KeyUpdate via debugfs. This patch exposes a
key_update file that can be written to with the queue number to trigger
a KeyUpdate on that queue.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v4:
 - No change
v3:
 - New patch

 drivers/nvme/host/tcp.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 791e0cc91ad8..f5c7b646d002 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -11,6 +11,7 @@
 #include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
+#include <linux/debugfs.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
@@ -1429,6 +1430,75 @@ static void update_tls_keys(struct nvme_tcp_queue *queue)
 	}
 }
 
+#ifdef CONFIG_NVME_TCP_TLS
+#define NVME_DEBUGFS_RW_ATTR(field) \
+	static int field##_open(struct inode *inode, struct file *file) \
+	{ return single_open(file, field##_show, inode->i_private); } \
+	\
+	static const struct file_operations field##_fops = { \
+		.open = field##_open, \
+		.read = seq_read, \
+		.write = field##_write, \
+		.release = single_release, \
+	}
+
+static int nvme_ctrl_key_update_show(struct seq_file *m, void *p)
+{
+	seq_printf(m, "0\n");
+
+	return 0;
+}
+
+static ssize_t nvme_ctrl_key_update_write(struct file *file, const char __user *buf,
+					  size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct nvme_ctrl *nctrl = m->private;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	char kbuf[16] = {0};
+	int queue_nr, rc;
+	struct nvme_tcp_queue *queue;
+
+	if (count > sizeof(kbuf) - 1)
+		return -EINVAL;
+	if (copy_from_user(kbuf, buf, count))
+		return -EFAULT;
+	kbuf[count] = 0;
+
+	rc = kstrtouint(kbuf, 10, &queue_nr);
+	if (rc)
+		return rc;
+
+	if (queue_nr >= nctrl->queue_count)
+		return -EINVAL;
+
+	queue = &ctrl->queues[queue_nr];
+
+	update_tls_keys(queue);
+
+	return count;
+}
+NVME_DEBUGFS_RW_ATTR(nvme_ctrl_key_update);
+#endif
+
+static void nvme_tcp_debugfs_init(struct nvme_ctrl *ctrl,
+			    const char *dev_name)
+{
+	struct dentry *parent;
+
+	/* create debugfs directory and attribute */
+	parent = debugfs_create_dir(dev_name, NULL);
+	if (IS_ERR(parent)) {
+		pr_warn("%s: failed to create debugfs directory\n", dev_name);
+		return;
+	}
+
+#ifdef CONFIG_NVME_TCP_TLS
+	debugfs_create_file("key_update", S_IWUSR, parent, ctrl,
+			    &nvme_ctrl_key_update_fops);
+#endif
+}
+
 static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
@@ -3065,6 +3135,8 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 
+	nvme_tcp_debugfs_init(&ctrl->ctrl, dev_name(dev));
+
 	return &ctrl->ctrl;
 
 out_uninit_ctrl:
-- 
2.51.0


