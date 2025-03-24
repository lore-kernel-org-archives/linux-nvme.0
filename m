Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19148C36012
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Fi8wxHWT94T7MY3v+TZ54B5tpjZFyKAx//BA1E8YHc=; b=LvoRFeD7rd5bnmphkVrCtzC4KO
	Jw8HKwDfZ/HhrbArubUk/ypnQZ+5zjSbD3BcDFXoXOeygSzFFG1OSa+/AbZiCOaY+fiW3ohVthpfm
	bGC3M7NpdKxmISH+1qvcuOvF9DY85bTU3+Q6sv+x3VxhC4AsOu1QFC6zBcp3mIrNVL8kodPuB1/s9
	/RzKHoLQLJ+EeV2sE4eExpEPHMgkEw1XKmI6pY2FUoevKXyikkq5nGTQB8ROAuVWOGLOp6SEAlyQp
	MXku1HlODRJef0+G4wZ8AIbQC6fD2VTA4g5blcgkyz2YIdegA87o26cTyn99eNQYi2uQh5aQvVyRN
	biwX6YYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyy-00000002oRW-1ZzZ;
	Mon, 24 Mar 2025 10:24:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyB-00000002oFK-49gl
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Fi8wxHWT94T7MY3v+TZ54B5tpjZFyKAx//BA1E8YHc=;
	b=iSYBbIYlJTnJ0WYRSFssUoC9tjQukZ1dn0e1FlljoLCGcuncPiEsG/NPH9ba5vDYE1dkej
	9zP0RiUfB3xSZT6eaAJiOYb2mHPFsfuNHjM9yCts8/X/ts5R/b/OBYlxVvE3X/E28z7b3/
	3v7R67SkPE1H9wJaxDB0a2BRte8AMbQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-18t8FN9LMvGjxKqF9hcYcw-1; Mon,
 24 Mar 2025 06:23:46 -0400
X-MC-Unique: 18t8FN9LMvGjxKqF9hcYcw-1
X-Mimecast-MFC-AGG-ID: 18t8FN9LMvGjxKqF9hcYcw_1742811825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 097A818EBE88;
	Mon, 24 Mar 2025 10:23:45 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46657180A801;
	Mon, 24 Mar 2025 10:23:41 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 08/11] nvmet: add delay debugfs file to nvmet_ctrl
Date: Mon, 24 Mar 2025 11:23:07 +0100
Message-ID: <20250324102310.658007-9-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2NIGzaHXCFmVmauKLray7wKKK67RJGukL5zzzVcXki0_1742811825
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032348_099302_95733F12 
X-CRM114-Status: GOOD (  16.38  )
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
index fb7446d6d682..e0a1ccb93da6 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -126,3 +126,12 @@ config NVME_TARGET_PCI_EPF
 	  capable PCI controller.
 
 	  If unsure, say N.
+
+config NVME_TARGET_DELAY_REQUESTS
+	bool "NVMe over Fabrics target request delay"
+	depends on NVME_TARGET && NVME_TARGET_DEBUGFS
+	help
+	  This is a testing feature to allow delaying request completion in an
+	  NVMe over Fabrics target, which allows for support of the cancel command.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e4300eb95101..4a80cfceab34 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -153,6 +153,42 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
 #endif
 
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
@@ -183,6 +219,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 			    &nvmet_ctrl_tls_concat_fops);
 	debugfs_create_file("tls_key", S_IRUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_tls_key_fops);
+#endif
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+	debugfs_create_file("delay", S_IWUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_delay_fops);
 #endif
 	return 0;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7599dbb4347c..7a360285b254 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -306,6 +306,10 @@ struct nvmet_ctrl {
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
2.43.5


