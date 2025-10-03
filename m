Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAAECCA470
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 04:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6RfUYBKsuo8ddTyCuM4jvFb8g3qBzZAb/Bm18mx0r0I=; b=Pbw3E9YIlcMS1DWh//7iNCGEca
	KUwGWeSpDSyfIduzYCaqg+u6bhKPAXnei7sJe/Mau+FZiOjgJBZJlPV5osP4PBKbrIIVHq2CWh+4K
	KB8WhI5QfQyj40+aM1cU6mhqRylTvz40SccvZPiw8axqByS0XFKIeeqJRwEkNwCJY0WoLkOJPXIgV
	sU6SM93i0HUhR+6GP+TUHhxn7L8oJKn1tWJSuRDXIujIL/dt9DjvWmcBE00JayHMwPmVJId97C7eL
	gprV8dDTzzYORg871Ex8NkjQ0rCFe/Rs7jZqXS0A4cWk/7OmQFEHNo67i1GxrP4s/m1BgHqfFw+2s
	9iVYrn6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XTX-0000000BeJK-1Gmo;
	Fri, 03 Oct 2025 04:32:59 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XTU-0000000BeGh-1yXg
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 04:32:58 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so2327084b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 02 Oct 2025 21:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465976; x=1760070776; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RfUYBKsuo8ddTyCuM4jvFb8g3qBzZAb/Bm18mx0r0I=;
        b=QjKLD8XlrPerp9Hu8vYVrzp3XQkHFkfoIa1xQNzC4Yn5PpI3aQs6LfOL8DPtGNIYw1
         cR7NkDMBMjhbyC2jbdgSc2eX7831dq+EAfovULL5KUXGVpAzRxvBtCXDmA7Mz2AjRM6z
         AXsPDLRTm5LNqzlfkkz6ze28I1i5V892Y3vhKyCauO+W5/6h34vTSqPIc294FaSoxn3j
         FtcRt0qQkLLuFhPlOGjV/v9DFU9CTFz6jK81fTINTTU0mJLiA5DCqP9pfn1fZomn4OlU
         2laNAk9/BjiGIO433R4pyqX1NHIT/n1U3WSW11+Ywa/grizvWZCByzY2imwYmCvF6xrs
         NgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465976; x=1760070776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RfUYBKsuo8ddTyCuM4jvFb8g3qBzZAb/Bm18mx0r0I=;
        b=AHaMGU9piiEAF1m19mh6Wkg7Va5M/PJhchgKQyNP4GUDbSHErgZ8UBUgXAUf/XPQdE
         2p5elZ/CWa0E61lDReWKUnUsQJQSkvYEisD3K6Kwm4ViLpKXHFlN1pNsRvbmKCBybbMF
         jD9gmuqaQnPFMsAQGlFbwyxkRKVjnFwbCfMuQY7tXBLEPSTXJWfoGu4DOYLcePaWT7vs
         ntVj/KUpuqZ/qSYFr3xL/Jy9gonMRUEEO+c3vHqXWnaLSLgqG5NqKwApciFjaI/rgOCY
         M9Ly5vDeBQqyF4bEo4nI5V5xr05vR0OBP8X7xumOVi3+tnIufGzd+cZ5mDjIdnEm+m2v
         6n1g==
X-Forwarded-Encrypted: i=1; AJvYcCWMF3KcVNMeol52DSFOc9J+1x9CGNh2GHHdC97WKOQ8rRLLDvpX9jRaFq4uwprqgYjBk84yT+aexQS9@lists.infradead.org
X-Gm-Message-State: AOJu0YzU22prt2PI8One06rm7uXGd9jbZtJMT+3GOWa/eXuGK5m7SOCp
	cF7Drw2ro3wddll782K2Pts0tcuvnSwvTZ6WymzRBVge5v7wO8hQcbIs
X-Gm-Gg: ASbGncvsvkFKGsiHoJRMgxH4iyGkcgoasZxPe1HfCBJiViLau2bpwaPJMq2TmgwM652
	5CzNpg8AhTsRByoFn1Ln9WVNf4zqsNIXPRqEsLJSv7kZuswiNILhC3tHI9ucyCKQxu2Z5aV7Fgh
	dvcZkfd56+C3d0oF2mdPPZmn8FdVJ6RAKKEqJ26sXFiPVkSSz/j0yn5QtvzQAA2zmYZQHBAbzgF
	rbc+lU+0sYfricLjHTZipJqnAMX/Bgg3sIJP3XPLKiTASXMGqobJOlnvPlBhxoLZfePY2FaIbM5
	Gav9U4mU1/VDAf3laX50b/9KAFM6R6c/Zbo59Fpi02q4vVsCbCZM32EoyyQzfJB/+5av3g4WbOu
	dDc4NO2W4sPdq5nR1QLiJd5i6t9XLCNFWDpWFzdTVS8D+Vnc/vMQCkFt6ojIV1iuhNIvbw9SNpc
	bddj1iEFYQKAP7U+5Lpdy8Lz7OBOXSb79vdboJcYDEZ0/FFcy4pWJDQbEQ6xYy5F4=
X-Google-Smtp-Source: AGHT+IGGX+e0auRKkNgRCpHofPZBmDCRUu/ZNBz9qUrUPtdZIEwSRDXKxeRRWzhaVI2evV9MhLLdHA==
X-Received: by 2002:a05:6a20:729c:b0:2da:f4be:c8c2 with SMTP id adf61e73a8af0-32b61dde689mr2200196637.31.1759465975599;
        Thu, 02 Oct 2025 21:32:55 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:55 -0700 (PDT)
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
Subject: [PATCH v3 8/8] nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs
Date: Fri,  3 Oct 2025 14:31:39 +1000
Message-ID: <20251003043140.1341958-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251002_213256_536757_9DDE9EF7 
X-CRM114-Status: GOOD (  15.69  )
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
v3:
 - New patch

 drivers/nvme/host/tcp.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4f27319f0078..8c6d18727e90 100644
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
@@ -1432,6 +1433,75 @@ static void update_tls_keys(struct nvme_tcp_queue *queue)
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


