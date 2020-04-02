Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940D9C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 05:42:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F5B20784
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 05:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZtgC+j83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F5B20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dujFL1QoyOj0bUuS/rrwvMEPC+Tx9pBPTpKLZV9gKOg=; b=ZtgC+j83/g0M9/
	alPkncBnYbfa/zlV3gWIZcStv+DgZEoplD77mkqQfZvQKpgVPXxM3qqP2Ic87brLQKViR6CF4V0d0
	hRapu48b5WkOXwbdvkFPC+RQdoa1iTOmsyY49xC8uLfyA+UsdIYoY0NhegiIvgTHymcWhv+TBy1mW
	y/pzQbETpLtWpGjQusxz5nJ70/up1LxvmgK8hG1dE9fRhKePnZ2fo/Pw3onbolzeFLUeCHOPYKV/j
	d7HDuIH2ZqVnz+qC6GZhxXXLYMUG1H4VFtmyzAjHwM6VHK/cnJtA9DNOMOb3z+BAi00C0S1Vn+pJp
	R6kJ+Izeduky9wyQ5QkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJsca-0005b4-Mh; Thu, 02 Apr 2020 05:42:32 +0000
Received: from [2601:647:4802:9070:a836:db4c:a7ac:3d7c]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJscZ-0005as-BE; Thu, 02 Apr 2020 05:42:31 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH rfc] fabrics: support default connect/discover args
Date: Wed,  1 Apr 2020 22:42:26 -0700
Message-Id: <20200402054226.14066-1-sagi@grimberg.me>
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

Introduce /etc/nvme/defargs.conf where we allow the user to
specify connect/discover parameters once and not for every
controller.

The format is simply writing the arguments into the file as
if they were appended to the execution command.

Also, properly install this file with some minimal documentation

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 Makefile            |  3 +++
 etc/default.conf.in |  5 ++++
 fabrics.c           | 63 +++++++++++++++++++++++++++++++++++++++++++++
 nvme.spec.in        |  1 +
 4 files changed, 72 insertions(+)
 create mode 100644 etc/default.conf.in

diff --git a/Makefile b/Makefile
index 5c5c8b21471e..f7b5fee2f45f 100644
--- a/Makefile
+++ b/Makefile
@@ -152,6 +152,9 @@ install-etc:
 	if [ ! -f $(DESTDIR)$(SYSCONFDIR)/nvme/discovery.conf ]; then \
 		$(INSTALL) -m 644 -T ./etc/discovery.conf.in $(DESTDIR)$(SYSCONFDIR)/nvme/discovery.conf; \
 	fi
+	if [ ! -f $(DESTDIR)$(SBINDIR)/nvme/default.conf ]; then \
+		$(INSTALL) -m 644 -T ./etc/default.conf.in $(DESTDIR)$(SYSCONFDIR)/nvme/default.conf; \
+	fi
 
 install-spec: install-bin install-man install-bash-completion install-zsh-completion install-etc install-systemd install-udev install-dracut
 install: install-spec install-hostparams
diff --git a/etc/default.conf.in b/etc/default.conf.in
new file mode 100644
index 000000000000..e91106bf5bbf
--- /dev/null
+++ b/etc/default.conf.in
@@ -0,0 +1,5 @@
+# Used for extracting default controller connect parameters
+#
+# Example:
+# --keep-alive-tmo=<x> --reconnect-delay=<y> --ctrl-loss-tmo=<z> --nr-io-queues=<u>
+# --queue-size=<v>
diff --git a/fabrics.c b/fabrics.c
index 7027a19103a5..5a172d23aec7 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -99,7 +99,9 @@ struct connect_args {
 #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
 #define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
 #define PATH_NVMF_HOSTID	"/etc/nvme/hostid"
+#define PATH_NVMF_DEFARGS	"/etc/nvme/default.conf"
 #define MAX_DISC_ARGS		10
+#define MAX_DEF_ARGS		10
 #define MAX_DISC_RETRIES	10
 
 enum {
@@ -1246,6 +1248,59 @@ static int do_discover(char *argstr, bool connect)
 	return ret;
 }
 
+static int nvmf_parse_defargs(const char *desc,
+		const struct argconfig_commandline_options *opts)
+{
+	FILE *f;
+	char line[256], *ptr, *args, *a, **argv;
+	int argc = 0, ret = 0;
+
+	f = fopen(PATH_NVMF_DEFARGS, "r");
+	if (f == NULL)
+		return 0;
+
+	while (fgets(line, sizeof(line), f) != NULL) {
+		if (line[0] == '#' || line[0] == '\n')
+			continue;
+
+		a = args = strdup(line);
+		if (!args) {
+			fprintf(stderr, "failed to strdup args\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		argv = calloc(MAX_DEF_ARGS, BUF_SIZE);
+		if (!argv) {
+			fprintf(stderr, "failed to allocate argv vector\n");
+			free(args);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		argc = 0;
+		argv[argc++] = "none"; /* just to make parser happy */
+		while ((ptr = strsep(&a, " =\n")) != NULL)
+			argv[argc++] = ptr;
+
+		ret = argconfig_parse(argc, argv, desc, opts);
+		free(args);
+		free(argv);
+		if (ret)
+			goto out;
+
+		if (cfg.transport || cfg.traddr || cfg.trsvcid || cfg.nqn) {
+			fprintf(stderr, "args transport, traddr, trsvcid, nqn "
+				"cannot have a default\n");
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+out:
+	fclose(f);
+	return ret;
+}
+
 static int discover_from_conf_file(const char *desc, char *argstr,
 		const struct argconfig_commandline_options *opts, bool connect)
 {
@@ -1347,6 +1402,10 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 		OPT_END()
 	};
 
+	ret = nvmf_parse_defargs(desc, opts);
+	if (ret)
+		return ret;
+
 	cfg.tos = -1;
 	ret = argconfig_parse(argc, argv, desc, opts);
 	if (ret)
@@ -1408,6 +1467,10 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 		OPT_END()
 	};
 
+	ret = nvmf_parse_defargs(desc, opts);
+	if (ret)
+		return ret;
+
 	cfg.tos = -1;
 	ret = argconfig_parse(argc, argv, desc, opts);
 	if (ret)
diff --git a/nvme.spec.in b/nvme.spec.in
index 11e424f0f6b5..6be43cab37c5 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -35,6 +35,7 @@ make install-spec DESTDIR=%{buildroot} PREFIX=/usr
 %{_sysconfdir}/nvme/hostnqn
 %{_sysconfdir}/nvme/hostid
 %{_sysconfdir}/nvme/discovery.conf
+%{_sysconfdir}/nvme/default.conf
 %{_sysconfdir}/udev/rules.d/70-nvmf-autoconnect.rules
 %{_sysconfdir}/udev/rules.d/71-nvmf-iopolicy-netapp.rules
 %{_libdir}/dracut/dracut.conf.d/70-nvmf-autoconnect.conf
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
