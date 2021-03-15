Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D4CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 20:52:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6474764F26
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 20:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6474764F26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gakPHe4hIF+phb8k9qxAfI+3HQ10ydZuIsFPEf0GQro=; b=rPoDHvtMftyJwl
	pxQuK5aM6svNUk7RECIs0GV0q7L3LhzNgQXpZWHYKCCK2UoxDOQgMK1JYGFYeWlWIRrpZgCntUhrh
	12WTtPUDz1eufGObqK4UFtZqld2QD6A73qny+dFW8xrq8aLUyzC/+kcUxvUXdSb/gXKYvrM6MUbG/
	v9wK1JIZkR/RWINdG/rCPK0pSEQ/hOusihD5U7W0d941nv151YA/6QD4vCQ3ell9VUlkNGoDHl84J
	Xy7QM0FkPbnxNT8jR3qOpmqktzsmohKi/Sh+PAv1wwAfz3v1aQZVXeO3kbR338+iQERq+F0NJuF8w
	mtpfvKf0TnCh7Nc5xwFw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLuCK-00GsJs-RW; Mon, 15 Mar 2021 20:52:20 +0000
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLuCD-00GsIp-3S
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 20:52:17 +0000
Received: by mail-pl1-f170.google.com with SMTP id a13so808714pln.8
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 13:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t92nd0o5ThHFFp1nQjBSIRmacIUMwabopNHeuU/kWrc=;
 b=hCvkn7qcgHibY413kbFcxo+c3uNHOg21H44CLoBJQ5pazW8UrHP9q19fdTHyAl9rE2
 089ePKxhK3xbg7/pWlJvkgMQPsaDdnIgZztn3vQFChLKowCB2IEbIouJgur2AkTogNnP
 D0LmqgZO4jSQm3kjTbFTOP3ljLNwzyMgq8uVQiHC10PB2N342IFng8UI6hXkJjRat6Iy
 wOlFmbk2j3Mt/yB9BH/6y9AGLOY3C/bPV2BpPfDHYSHlIGAFN5Yc0QBf92jsSI52jriZ
 mEQY4CXGVmqWIGqF+UFFKUI+zGgZv4o0jdRIGb7Xxv/HdfYJ+LIMj1VuTOnF+8M+ejvK
 5uxA==
X-Gm-Message-State: AOAM531+Xs+Hm3arpvmFY5b/NjEpMVIIxBeJsFH7NRL4LdIgO2eKgCjh
 U70uisil7xKZMEVPO6vO2yQo1nsvWgk=
X-Google-Smtp-Source: ABdhPJzET18EIvWqf6O4UwitMZm6E6ItWkmj9QhC2UkDrWJuuE1OhC6L2qHEXPXgaJvcU42/YySS7A==
X-Received: by 2002:a17:903:188:b029:e6:52f4:1b2d with SMTP id
 z8-20020a1709030188b02900e652f41b2dmr13483642plg.58.1615841531358; 
 Mon, 15 Mar 2021 13:52:11 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id q25sm14302841pff.104.2021.03.15.13.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 13:52:10 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-topology: have list-subsys print only controllers with
 attached namespace
Date: Mon, 15 Mar 2021 13:52:09 -0700
Message-Id: <20210315205209.352846-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_205214_743532_591091F7 
X-CRM114-Status: GOOD (  21.88  )
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

When running list-subsys on a specific namespace, we output all the
controllers that belong to the subsystem regardless if the requested
namespace is actually attached to them.

Example:
$ nvme list-subsys /dev/nvme0n1
nvme-subsys0 - NQN=nqn.2016-01.com.lightbitslabs:uuid:07cfffe6-5a4f-4151-b663-e13cf835609b
\
 +- nvme0 tcp traddr=10.113.5.1 trsvcid=4420 live optimized
 +- nvme1 tcp traddr=10.133.3.1 trsvcid=4420 live
 +- nvme2 tcp traddr=10.133.1.1 trsvcid=4420 live
 +- nvme3 tcp traddr=10.113.1.1 trsvcid=4420 live inaccessible
 +- nvme4 tcp traddr=10.133.5.1 trsvcid=4420 live
 +- nvme5 tcp traddr=10.113.4.1 trsvcid=4420 live
 +- nvme6 tcp traddr=10.133.4.1 trsvcid=4420 live
 +- nvme7 tcp traddr=10.113.2.1 trsvcid=4420 live
 +- nvme8 tcp traddr=10.133.2.1 trsvcid=4420 live
 +- nvme9 tcp traddr=10.113.3.1 trsvcid=4420 live

This output is somewhat confusing and makes the user think the namespace
is actually attached to all of these controllers, instead we want the
output which provided by the change introduced here:

$ nvme list-subsys /dev/nvme0n1
nvme-subsys0 - NQN=nqn.2016-01.com.lightbitslabs:uuid:07cfffe6-5a4f-4151-b663-e13cf835609b
\
 +- nvme0 tcp traddr=10.113.5.1 trsvcid=4420 live optimized
 +- nvme3 tcp traddr=10.113.1.1 trsvcid=4420 live inaccessible

Do the same trick as we do in scan_subsystems, we add the ctrl to the
topology if either ns_instance wasn't passed (see all controllers) or
it was pased _and_ the controller has this namespace is attached to
the controller (to do that we add nsid down the call chain for that).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c       |  2 +-
 nvme-print.c    |  2 +-
 nvme-topology.c | 30 +++++++++++++++++++++++++-----
 nvme.c          | 24 ++++++++++++++++++++----
 nvme.h          |  2 +-
 5 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index f84c45b5f724..ff34c3039faf 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1777,7 +1777,7 @@ int fabrics_disconnect_all(const char *desc, int argc, char **argv)
 	if (err)
 		goto out;
 
-	err = scan_subsystems(&t, NULL, 0, NULL);
+	err = scan_subsystems(&t, NULL, 0, 0, NULL);
 	if (err) {
 		fprintf(stderr, "Failed to scan namespaces\n");
 		goto out;
diff --git a/nvme-print.c b/nvme-print.c
index b2a55af699ff..f66c3808a909 100755
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2514,7 +2514,7 @@ void nvme_show_relatives(const char *name)
 			free(path);
 			return;
 		}
-		err = scan_subsystems(&t, subsysnqn, 0, NULL);
+		err = scan_subsystems(&t, subsysnqn, 0, 0, NULL);
 		if (err || t.nr_subsystems != 1) {
 			free(subsysnqn);
 			free(path);
diff --git a/nvme-topology.c b/nvme-topology.c
index c0e2d5100b99..63e433d70f01 100644
--- a/nvme-topology.c
+++ b/nvme-topology.c
@@ -11,6 +11,7 @@
 
 static const char *dev = "/dev/";
 static const char *subsys_dir = "/sys/class/nvme-subsystem/";
+static void free_ctrl(struct nvme_ctrl *c);
 
 char *get_nvme_subsnqn(char *path)
 {
@@ -230,6 +231,19 @@ static char *get_nvme_ctrl_path_ana_state(char *path, int nsid)
 	return ana_state;
 }
 
+static bool ns_attached_to_ctrl(int nsid, struct nvme_ctrl *ctrl)
+{
+	struct nvme_namespace *n;
+	int i;
+
+	for (i = 0; i < ctrl->nr_namespaces; i++) {
+		n = &ctrl->namespaces[i];
+		if (nsid == n->nsid)
+			return true;
+	}
+	return false;
+}
+
 static int scan_ctrl(struct nvme_ctrl *c, char *p, __u32 ns_instance)
 {
 	struct nvme_namespace *n;
@@ -315,12 +329,12 @@ free:
 	return 0;
 }
 
-static int scan_subsystem(struct nvme_subsystem *s, __u32 ns_instance)
+static int scan_subsystem(struct nvme_subsystem *s, __u32 ns_instance, int nsid)
 {
 	struct dirent **ctrls, **ns;
 	struct nvme_namespace *n;
 	struct nvme_ctrl *c;
-	int i, ret;
+	int i, j = 0, ret;
 	char *path;
 
 	ret = asprintf(&path, "%s%s", subsys_dir, s->name);
@@ -336,12 +350,18 @@ static int scan_subsystem(struct nvme_subsystem *s, __u32 ns_instance)
 	s->nr_ctrls = ret;
 	s->ctrls = calloc(s->nr_ctrls, sizeof(*c));
 	for (i = 0; i < s->nr_ctrls; i++) {
-		c = &s->ctrls[i];
+		c = &s->ctrls[j];
 		c->name = strdup(ctrls[i]->d_name);
 		c->path = strdup(dev);
 		c->subsys = s;
 		scan_ctrl(c, path, ns_instance);
+
+		if (!ns_instance || ns_attached_to_ctrl(nsid, c))
+			j++;
+		else
+			free_ctrl(c);
 	}
+	s->nr_ctrls = j;
 
 	while (i--)
 		free(ctrls[i]);
@@ -550,7 +570,7 @@ static int scan_subsystem_dir(struct nvme_topology *t, char *dev_dir)
 }
 
 int scan_subsystems(struct nvme_topology *t, const char *subsysnqn,
-		    __u32 ns_instance, char *dev_dir)
+		    __u32 ns_instance, int nsid, char *dev_dir)
 {
 	struct nvme_subsystem *s;
 	struct dirent **subsys;
@@ -568,7 +588,7 @@ int scan_subsystems(struct nvme_topology *t, const char *subsysnqn,
 		for (i = 0; i < t->nr_subsystems; i++) {
 			s = &t->subsystems[j];
 			s->name = strdup(subsys[i]->d_name);
-			scan_subsystem(s, ns_instance);
+			scan_subsystem(s, ns_instance, nsid);
 
 			if (!subsysnqn || !strcmp(s->subsysnqn, subsysnqn))
 				j++;
diff --git a/nvme.c b/nvme.c
index 7ede27509bf7..2a3d0ac5da49 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1685,7 +1685,7 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 	const char *desc = "Retrieve information for subsystems";
 	const char *verbose = "Increase output verbosity";
 	__u32 ns_instance = 0;
-	int err;
+	int err, nsid = 0;
 
 	struct config {
 		char *output_format;
@@ -1710,7 +1710,7 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 	devicename = NULL;
 	if (optind < argc) {
 		char path[512];
-		int id;
+		int id, fd;
 
 		devicename = basename(argv[optind]);
 		if (sscanf(devicename, "nvme%dn%d", &id, &ns_instance) != 2) {
@@ -1719,6 +1719,22 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 			err = -EINVAL;
 			goto ret;
 		}
+		sprintf(path, "/dev/%s", devicename);
+		fd = open(path, O_RDONLY);
+		if (fd < 0) {
+			fprintf(stderr, "Cannot read nsid from %s\n",
+				devicename);
+			err = -EINVAL;
+			goto ret;
+		}
+		nsid = nvme_get_nsid(fd);
+		close(fd);
+		if (nsid < 0) {
+			fprintf(stderr, "Cannot read nsid from %s\n",
+				devicename);
+			err = -EINVAL;
+			goto ret;
+		}
 		sprintf(path, "/sys/block/%s/device", devicename);
 		subsysnqn = get_nvme_subsnqn(path);
 		if (!subsysnqn) {
@@ -1740,7 +1756,7 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 	if (cfg.verbose)
 		flags |= VERBOSE;
 
-	err = scan_subsystems(&t, subsysnqn, ns_instance, NULL);
+	err = scan_subsystems(&t, subsysnqn, ns_instance, nsid, NULL);
 	if (err) {
 		fprintf(stderr, "Failed to scan namespaces\n");
 		goto free;
@@ -1796,7 +1812,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	if (cfg.verbose)
 		flags |= VERBOSE;
 
-	err = scan_subsystems(&t, NULL, 0, cfg.device_dir);
+	err = scan_subsystems(&t, NULL, 0, 0, cfg.device_dir);
 	if (err) {
 		fprintf(stderr, "Failed to scan namespaces\n");
 		return err;
diff --git a/nvme.h b/nvme.h
index 3fb1060760ee..8501754c6502 100644
--- a/nvme.h
+++ b/nvme.h
@@ -106,7 +106,7 @@ int scan_subsys_filter(const struct dirent *d);
 int scan_dev_filter(const struct dirent *d);
 
 int scan_subsystems(struct nvme_topology *t, const char *subsysnqn,
-		    __u32 ns_instance, char *dev_dir);
+		    __u32 ns_instance, int nsid, char *dev_dir);
 void free_topology(struct nvme_topology *t);
 char *get_nvme_subsnqn(char *path);
 char *nvme_get_ctrl_attr(char *path, const char *attr);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
