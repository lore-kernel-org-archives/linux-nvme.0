Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3174EC41621
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 09:03:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0344C2070A
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 09:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FEP9yglV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0344C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DCmGtMInQ2pwjkZu8jTcybQ6gOvtblWAoiCUkk+GSrM=; b=FEP9yglViM2NRK
	GVrRToPTNr88b74mw5ZIoiCYVAGdFxnsmxkbUUdX+tbQTgWrWdlFoGzPDDe6nAOqV1RiZ4MlDV4/m
	zlDaZWHOz3kY9NnlUfMtoPWIw9g0ughUMsrXXYRyu3BAHeTtn9LfP77AeRrgJ7W3eoYkMyGsiLGgT
	ieCWYMGhHq0KTHXjv1KXucnPptZQxHM7Y7JFT3oFfDljc49HeEeuYpS+9fWycWVIvT0O7p9GMwTlI
	rhxB9JElw05l4Trl6QuE2ZduPn204eKglR+CtlewKPuuIFGKNiXplRMlYvwHWkFBQJhvKzof6CN0g
	9xLUOMpxcUg46VU5lNsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGfTF-0002vK-Bo; Tue, 24 Mar 2020 09:03:37 +0000
Received: from [2601:647:4802:9070:45a4:15de:f2dc:1149]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGfT3-0002hx-JU; Tue, 24 Mar 2020 09:03:25 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH rfc 2/2] fabrics: allow user to pass hostname instead of traddr
Date: Tue, 24 Mar 2020 02:03:24 -0700
Message-Id: <20200324090324.24459-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324090324.24459-1-sagi@grimberg.me>
References: <20200324090324.24459-1-sagi@grimberg.me>
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

Some users would like to use well known hostnames instead
of remembering ip addresses. So, allow users to pass --hostname
and we will attempt to resolve against the DNS.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index a7d628b1f0c9..7bd95c4b0d10 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -33,6 +33,10 @@
 #include <sys/stat.h>
 #include <stddef.h>
 
+#include <sys/types.h>
+#include <arpa/inet.h>
+#include <netdb.h>
+
 #include "util/parser.h"
 #include "nvme-ioctl.h"
 #include "nvme-status.h"
@@ -60,6 +64,7 @@ static struct config {
 	char *nqn;
 	char *transport;
 	char *traddr;
+	char *hostname;
 	char *trsvcid;
 	char *host_traddr;
 	char *hostnqn;
@@ -857,6 +862,54 @@ static int build_options(char *argstr, int max_len, bool discover)
 	return 0;
 }
 
+static int hostname2traddr(struct config *cfg)
+{
+	struct addrinfo *host_info, hints = {.ai_family = AF_UNSPEC};
+	char addrstr[NVMF_TRADDR_SIZE];
+	const char *p;
+	int ret;
+
+	if (cfg->traddr) {
+		fprintf(stderr, "hostname and traddr cannot be passed together\n");
+		return -EINVAL;
+	}
+
+	ret = getaddrinfo(cfg->hostname, NULL, &hints, &host_info);
+	if (ret) {
+		fprintf(stderr, "failed to get host info for %s\n", cfg->hostname);
+		return ret;
+	}
+
+	switch (host_info->ai_family) {
+	case AF_INET:
+		p = inet_ntop(host_info->ai_family,
+			&(((struct sockaddr_in *)host_info->ai_addr)->sin_addr),
+			addrstr, NVMF_TRADDR_SIZE);
+		break;
+	case AF_INET6:
+		p = inet_ntop(host_info->ai_family,
+			&(((struct sockaddr_in6 *)host_info->ai_addr)->sin6_addr),
+			addrstr, NVMF_TRADDR_SIZE);
+		break;
+	default:
+		fprintf(stderr, "unrecognized address family (%d) %s\n",
+			host_info->ai_family, cfg->hostname);
+		ret = -EINVAL;
+		goto free_addrinfo;
+	}
+
+	if (!p) {
+		fprintf(stderr, "failed to get traddr for %s\n", cfg->hostname);
+		ret = -errno;
+		goto free_addrinfo;
+	}
+	cfg->traddr = strdup(addrstr);
+
+free_addrinfo:
+	freeaddrinfo(host_info);
+	return ret;
+}
+
 static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 {
 	char argstr[BUF_SIZE], *p;
@@ -1230,6 +1283,13 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		if (cfg.persistent && !cfg.keep_alive_tmo)
 			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
 
+		if (cfg.hostname) {
+			ret = hostname2traddr(&cfg);
+			if (ret)
+				goto out;
+			cfg.hostname = NULL;
+		}
+
 		err = build_options(argstr, BUF_SIZE, true);
 		if (err) {
 			ret = err;
@@ -1259,6 +1319,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	OPT_ARGS(opts) = {
 		OPT_LIST("transport",      't', &cfg.transport,       "transport type"),
 		OPT_LIST("traddr",         'a', &cfg.traddr,          "transport address"),
+		OPT_LIST("hostname",       'A', &cfg.hostname,        "transport address in a hostname form"),
 		OPT_LIST("trsvcid",        's', &cfg.trsvcid,         "transport service id (e.g. IP port)"),
 		OPT_LIST("host-traddr",    'w', &cfg.host_traddr,     "host traddr (e.g. FC WWN's)"),
 		OPT_LIST("hostnqn",        'q', &cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
@@ -1295,6 +1356,13 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	} else {
 		if (cfg.persistent && !cfg.keep_alive_tmo)
 			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
+
+		if (cfg.hostname) {
+			ret = hostname2traddr(&cfg);
+			if (ret)
+				goto out;
+		}
+
 		ret = build_options(argstr, BUF_SIZE, true);
 		if (ret)
 			goto out;
@@ -1315,6 +1383,7 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 		OPT_LIST("transport",         't', &cfg.transport,         "transport type"),
 		OPT_LIST("nqn",               'n', &cfg.nqn,               "nqn name"),
 		OPT_LIST("traddr",            'a', &cfg.traddr,            "transport address"),
+		OPT_LIST("hostname",          'A', &cfg.hostname,          "transport address in a hostname form"),
 		OPT_LIST("trsvcid",           's', &cfg.trsvcid,           "transport service id (e.g. IP port)"),
 		OPT_LIST("host-traddr",       'w', &cfg.host_traddr,       "host traddr (e.g. FC WWN's)"),
 		OPT_LIST("hostnqn",           'q', &cfg.hostnqn,           "user-defined hostnqn"),
@@ -1339,6 +1408,12 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 	if (ret)
 		goto out;
 
+	if (cfg.hostname) {
+		ret = hostname2traddr(&cfg);
+		if (ret)
+			goto out;
+	}
+
 	ret = build_options(argstr, BUF_SIZE, false);
 	if (ret)
 		goto out;
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
