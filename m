Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC35C2D0F3
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 21:53:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58D22054F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 21:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qabFWule"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58D22054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3RmfZEeTTc/S27SWiclQiVNw2lOf1vz4yI9GJ/Z2jzk=; b=qabFWuledM4kKO
	jddqLB1qAT4W/6D6+T+MmBY06HE/g909vEsLdndoJuvxL0w07aukT5BkVAuUp12ABD+Wbcg2JqX5k
	GJ/sV52Y4lKMhsiyp1dnGp89EehdF2Q7O7wkRuots5IDFucmHcAX1kQo+hASazvwpSElhXh5iLRgR
	GZOQVQh0xHr4oSAK2CmsRApMpkIHTu8QVaaFjG2HS6+IuCrcBXbfpf6vQj9firsM3MP+QyBSco3Xv
	VJk4apolhbs1HQKysI6gRPlDyRFcKLP1iHCpX7mgmNlaw5gvZi06aV3pnqnb7IY5kwaepp0Of+vEm
	XdAI6D4THbNeuXnK9Wzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJlIz-0004VJ-Rp; Wed, 01 Apr 2020 21:53:49 +0000
Received: from [2601:647:4802:9070:a836:db4c:a7ac:3d7c]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJlIw-0004QN-Pu; Wed, 01 Apr 2020 21:53:46 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/2] fabrics: allow traddr to be host name for ip based
 transports
Date: Wed,  1 Apr 2020 14:53:44 -0700
Message-Id: <20200401215344.2519-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401215344.2519-1-sagi@grimberg.me>
References: <20200401215344.2519-1-sagi@grimberg.me>
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

Some users would like to use well known hostnames instead of remembering
ip addresses. So, allow users to set traddr to be a host name and we will
attempt to resolve against a DNS.

This applies for IP based transports only (e.g. tcp, rdma) while fc and
loop will ignore this distinction.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- have traddr be either ip address or hostname for ip based transports
  (tcp, rdma).
 fabrics.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index a7d628b1f0c9..7027a19103a5 100644
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
@@ -857,6 +861,63 @@ static int build_options(char *argstr, int max_len, bool discover)
 	return 0;
 }
 
+static bool traddr_is_hostname(struct config *cfg)
+{
+	char addrstr[NVMF_TRADDR_SIZE];
+
+	if (!cfg->traddr)
+		return false;
+	if (strcmp(cfg->transport, "tcp") && strcmp(cfg->transport, "rdma"))
+		return false;
+	if (inet_pton(AF_INET, cfg->traddr, addrstr) > 0 ||
+	    inet_pton(AF_INET6, cfg->traddr, addrstr) > 0)
+		return false;
+	return true;
+}
+
+static int hostname2traddr(struct config *cfg)
+{
+	struct addrinfo *host_info, hints = {.ai_family = AF_UNSPEC};
+	char addrstr[NVMF_TRADDR_SIZE];
+	const char *p;
+	int ret;
+
+	ret = getaddrinfo(cfg->traddr, NULL, &hints, &host_info);
+	if (ret) {
+		fprintf(stderr, "failed to resolve host %s info\n", cfg->traddr);
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
+			host_info->ai_family, cfg->traddr);
+		ret = -EINVAL;
+		goto free_addrinfo;
+	}
+
+	if (!p) {
+		fprintf(stderr, "failed to get traddr for %s\n", cfg->traddr);
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
@@ -1230,6 +1291,12 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		if (cfg.persistent && !cfg.keep_alive_tmo)
 			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
 
+		if (traddr_is_hostname(&cfg)) {
+			ret = hostname2traddr(&cfg);
+			if (ret)
+				goto out;
+		}
+
 		err = build_options(argstr, BUF_SIZE, true);
 		if (err) {
 			ret = err;
@@ -1295,6 +1362,13 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	} else {
 		if (cfg.persistent && !cfg.keep_alive_tmo)
 			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
+
+		if (traddr_is_hostname(&cfg)) {
+			ret = hostname2traddr(&cfg);
+			if (ret)
+				goto out;
+		}
+
 		ret = build_options(argstr, BUF_SIZE, true);
 		if (ret)
 			goto out;
@@ -1339,6 +1413,12 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 	if (ret)
 		goto out;
 
+	if (traddr_is_hostname(&cfg)) {
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
