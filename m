Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D93CC88E77
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2026 11:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+JZv7j7QIkmFq/y0JVByroVutCG0XVcp8p5T3GkQKBA=; b=fg4vWLWwS+01UqIOWPVPlS6d/6
	swkdQz38n30jUqY1jPXjsbaXSIa6xL14lKkYjfELgdRiEXPZalz6zFS4P5dQzar4gImaTf6Gplzsf
	utoXFLhwaJxHw+4i7Bm+hLgQk2BfDopMWJPlsXejuaw1YBaReHlBfzAr53y6GkSdeI5fmJmcue8ft
	5rKh8oemFVWNeERJMX9YE4R24tgFwHKtny7eJhzZfD5T/WKxCO+spEtoSuSf24O56ZLvtsoPh8yJZ
	ExHNq70XYL/D2PqA/xFAw7LUy6cpONx6fA0VpceOK4Okcmb7c3Oc1HzHDbLUp2uZVaXm34IFYaW4i
	NGgcUMnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6o57-000000096lB-1Tlm;
	Wed, 16 Sep 2026 11:45:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6o55-000000096l1-3QkV
	for linux-nvme@lists.infradead.org;
	Wed, 16 Sep 2026 11:45:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5148C40048;
	Wed, 16 Sep 2026 11:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10B31F000FF;
	Wed, 16 Sep 2026 11:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559139;
	bh=+JZv7j7QIkmFq/y0JVByroVutCG0XVcp8p5T3GkQKBA=;
	h=From:To:Cc:Subject:Date;
	b=PuGqz4cDUMMm34JxHLNB6hHMbDAnpMBG+2w6ZrJOKrQWL/u3PuXfU7YCvXbT0Z4oZ
	 jgkAdKtP4clp0J4BSvknZP71M82sWNWvZtEVCkNE19B1RbXMPpsMeV5CAXZUgoYNzt
	 /k0Ne7JxWq6U1UzQHEMnfupq5Bjtt+mStqogvzdKWjYiTTFQiI8t/Un+928HBNyBRM
	 OJ4IO73X53TCfaX8SNAVUVLeS1YaR6AUOGXY/T/ididfE/FJinmseKmW7iRksA04mU
	 Nq0UbaPLJgyvYgVhLGsd60Ppo2dIKRUBcizoCyHPWRli6o2Ua8UcsWGfEYlATqLAL3
	 48eFwBDWw81zQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Maurizio Lombardi <mlombard@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: work around -Wformat-security warning
Date: Wed, 16 Sep 2026 13:44:51 +0200
Message-ID: <20260916114533.237863-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Arnd Bergmann <arnd@arndb.de>

Passing a string variable into dev_set_name() causes a warning
when building with -Wformat-security enabled:

drivers/nvme/host/core.c: In function 'nvme_cdev_add':
drivers/nvme/host/core.c:3911:9: error: format not a string literal and no format arguments [-Werror=format-security]
 3911 |         ret = dev_set_name(cdev_device, name);

Remove the temporary strings and let dev_set_name() do the
same thing internally.

Fixes: 26acdaa357cd ("nvme: fix crash and memory leak during invalid cdev teardown")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/host/core.c      | 21 +++++++++------------
 drivers/nvme/host/multipath.c | 12 +++++-------
 drivers/nvme/host/nvme.h      |  6 +++---
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index beea23d04a70..79f6a2c7923e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3931,9 +3931,9 @@ void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
 	put_device(cdev_device);
 }
 
-int nvme_cdev_add(const char *name, struct cdev *cdev,
-		struct device *cdev_device,
-		const struct file_operations *fops, struct module *owner)
+int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
+		const struct file_operations *fops, struct module *owner,
+		int ctrl, int head)
 {
 	int minor, ret;
 
@@ -3941,7 +3941,7 @@ int nvme_cdev_add(const char *name, struct cdev *cdev,
 	if (minor < 0)
 		return minor;
 
-	ret = dev_set_name(cdev_device, name);
+	ret = dev_set_name(cdev_device, "ng%dn%d", ctrl, head);
 	if (ret) {
 		ida_free(&nvme_ns_chr_minor_ida, minor);
 		return ret;
@@ -3982,17 +3982,14 @@ static const struct file_operations nvme_ns_chr_fops = {
 
 static void nvme_add_ns_cdev(struct nvme_ns *ns)
 {
-	char name[32];
-
 	ns->cdev_device.parent = ns->ctrl->device;
-	snprintf(name, sizeof(name), "ng%dn%d", ns->ctrl->instance,
-		 ns->head->instance);
 
 	nvme_get_ns(ns); /* Undone in nvme_cdev_rel() */
-	if (nvme_cdev_add(name, &ns->cdev, &ns->cdev_device,
-			&nvme_ns_chr_fops, ns->ctrl->ops->module)) {
-		dev_err(ns->ctrl->device, "Unable to create the %s device\n",
-			name);
+	if (nvme_cdev_add(&ns->cdev, &ns->cdev_device,
+			&nvme_ns_chr_fops, ns->ctrl->ops->module,
+			ns->ctrl->instance, ns->head->instance)) {
+		dev_err(ns->ctrl->device, "Unable to create the ng%dn%d device\n",
+			ns->ctrl->instance, ns->head->instance);
 		nvme_put_ns(ns);
 		return;
 	}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..3d46c4f28a47 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -646,17 +646,15 @@ static const struct file_operations nvme_ns_head_chr_fops = {
 
 static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 {
-	char name[32];
-
 	head->cdev_device.parent = &head->subsys->dev;
-	snprintf(name, sizeof(name), "ng%dn%d", head->subsys->instance,
-		 head->instance);
 
 	nvme_get_ns_head(head); /* Undone in nvme_cdev_rel() */
-	if (nvme_cdev_add(name, &head->cdev, &head->cdev_device,
-			&nvme_ns_head_chr_fops, THIS_MODULE)) {
+	if (nvme_cdev_add(&head->cdev, &head->cdev_device,
+			&nvme_ns_head_chr_fops, THIS_MODULE,
+			head->subsys->instance, head->instance)) {
 		dev_err(disk_to_dev(head->disk),
-			"Unable to create the %s device\n", name);
+			"Unable to create the ng%dn%d device\n",
+			head->subsys->instance, head->instance);
 		nvme_put_ns_head(head);
 		return;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cff9fcbf740..e0260f4d24fd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1013,9 +1013,9 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 void nvme_get_ns_head(struct nvme_ns_head *head);
 bool nvme_tryget_ns_head(struct nvme_ns_head *head);
 void nvme_put_ns_head(struct nvme_ns_head *head);
-int nvme_cdev_add(const char *name, struct cdev *cdev,
-		struct device *cdev_device,
-		const struct file_operations *fops, struct module *owner);
+int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
+		const struct file_operations *fops, struct module *owner,
+		int ctrl, int head);
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device);
 int nvme_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
-- 
2.53.0


