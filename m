Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F5C43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 21:53:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844222054F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 21:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qmL2suOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844222054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4bY0U9DA5yMaFWzTkxX+ztSFJs5ng1MFTNqh2VgHSNQ=; b=qmL2suOGjC820A
	uCsFiAYNCbngEy27n1jVpb9O5GJmKEjlRpT2gdgX4tU7NXL6nniSc+YsgWWVXKnsuDa0IkAy0L5G5
	ooCTSDVdrFxsSi09VGK3B0T9b/MWsSnFrBvv5gxqkmG/f4S/W6jzwXVcDV5XXYdZbImfIZhheye89
	ZtDeXyPpLUtbgo/CNgoSeHy3df3zzhj3NkeZ/oYrTrniSIkBOX2/6nnFuQEOl4mef58hRr4OUnd9q
	b/UWtDynj2O4s5voMN5P6f7vAvH71e3/6XLgfmRl9d/Qz0jb/B+WApDfdBwghsz2xEqFuyBn7ORch
	mwRQ8j7A9Q8pyli4Ehyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJlIy-0004U2-Ho; Wed, 01 Apr 2020 21:53:48 +0000
Received: from [2601:647:4802:9070:a836:db4c:a7ac:3d7c]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJlIw-0004QN-Kx; Wed, 01 Apr 2020 21:53:46 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/2] fabrics: add fabrics_ prefix to fabrics operations
Date: Wed,  1 Apr 2020 14:53:43 -0700
Message-Id: <20200401215344.2519-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

discover/connect/disconnect are generic names which might
clash with other external included libraries.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c |  8 ++++----
 fabrics.h |  8 ++++----
 nvme.c    | 10 +++++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index e2c9bfb37177..a7d628b1f0c9 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1251,7 +1251,7 @@ out:
 	return ret;
 }
 
-int discover(const char *desc, int argc, char **argv, bool connect)
+int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char argstr[BUF_SIZE];
 	int ret;
@@ -1306,7 +1306,7 @@ out:
 	return nvme_status_to_errno(ret, true);
 }
 
-int connect(const char *desc, int argc, char **argv)
+int fabrics_connect(const char *desc, int argc, char **argv)
 {
 	char argstr[BUF_SIZE];
 	int instance, ret;
@@ -1439,7 +1439,7 @@ static int disconnect_by_device(char *device)
 	return remove_ctrl(instance);
 }
 
-int disconnect(const char *desc, int argc, char **argv)
+int fabrics_disconnect(const char *desc, int argc, char **argv)
 {
 	const char *nqn = "nqn name";
 	const char *device = "nvme device";
@@ -1484,7 +1484,7 @@ out:
 	return nvme_status_to_errno(ret, true);
 }
 
-int disconnect_all(const char *desc, int argc, char **argv)
+int fabrics_disconnect_all(const char *desc, int argc, char **argv)
 {
 	struct nvme_topology t = { };
 	int i, j, err;
diff --git a/fabrics.h b/fabrics.h
index b8e53f492b53..f5b8eaf6bba0 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -5,9 +5,9 @@
 
 extern char *hostnqn_read(void);
 
-extern int discover(const char *desc, int argc, char **argv, bool connect);
-extern int connect(const char *desc, int argc, char **argv);
-extern int disconnect(const char *desc, int argc, char **argv);
-extern int disconnect_all(const char *desc, int argc, char **argv);
+extern int fabrics_discover(const char *desc, int argc, char **argv, bool connect);
+extern int fabrics_connect(const char *desc, int argc, char **argv);
+extern int fabrics_disconnect(const char *desc, int argc, char **argv);
+extern int fabrics_disconnect_all(const char *desc, int argc, char **argv);
 
 #endif
diff --git a/nvme.c b/nvme.c
index dd3ab5870e62..7e6713a1c8c7 100644
--- a/nvme.c
+++ b/nvme.c
@@ -4779,31 +4779,31 @@ static int show_hostnqn_cmd(int argc, char **argv, struct command *command, stru
 static int discover_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Send Get Log Page request to Discovery Controller.";
-	return discover(desc, argc, argv, false);
+	return fabrics_discover(desc, argc, argv, false);
 }
 
 static int connect_all_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Discover NVMeoF subsystems and connect to them";
-	return discover(desc, argc, argv, true);
+	return fabrics_discover(desc, argc, argv, true);
 }
 
 static int connect_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Connect to NVMeoF subsystem";
-	return connect(desc, argc, argv);
+	return fabrics_connect(desc, argc, argv);
 }
 
 static int disconnect_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Disconnect from NVMeoF subsystem";
-	return disconnect(desc, argc, argv);
+	return fabrics_disconnect(desc, argc, argv);
 }
 
 static int disconnect_all_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Disconnect from all connected NVMeoF subsystems";
-	return disconnect_all(desc, argc, argv);
+	return fabrics_disconnect_all(desc, argc, argv);
 }
 
 void register_extension(struct plugin *plugin)
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
