Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4547C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 18:29:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6F560FED
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 18:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B6F560FED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m8bBuRbKkbLcWj+RApuDTQSgT7W3cyeoUk3VRJgBVuc=; b=ug2iMK1jsOSQ/6
	hjmpNJUrgIoonC2SbR70Z7iEZ/PPMNmF0C0fRb25SiH+N55Gx977zLqSYOk4BD6Q3Gc91RN9oFeo/
	RaQbvt6NvPoTPjXPtXYN4BKOw/W5LrbU2GqIo5aTutSTWm3gwWJw5IkWdBSrOskEEcfCcVAy2n7nv
	lwukRhaafMX+6bWtXkn8bCGtJOL2/E8iZ4V2qZiUMEjMSFwVyWON2EGrp10ztkx2HBcibAwPpQnS9
	kNjD6m1QVWkc9sqFX9W5HCoQQDwymrYYsY65x5kN8M0xPel8HW0imightVKZq2dzDfD6270xENMZi
	QBg0j/2wj+42cQGTYVWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUYuA-000u7O-J0; Sun, 26 Sep 2021 18:29:38 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUYu7-000u6S-R3
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 18:29:37 +0000
Received: by mail-ed1-f44.google.com with SMTP id dj4so59567351edb.5
 for <linux-nvme@lists.infradead.org>; Sun, 26 Sep 2021 11:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gedtYrjgCgYDuPGYsFV0dH0meSidysRhHKrbN1apCbk=;
 b=S9tGT46h1mMvbaLK8rMhQnKB0TtgRmr/7KB3WdUwHFcNzGZl1ROdJKVxJeTWpEIw5V
 tvOkBqqDDzW/Ka2dlxwUaAiZZkebiwioKN+8iTBVs5OfMJlf0eMJAekkao9m/x+PT1t0
 Bix+L+20H6dg5pSQVgwGh3pDENIFl0rlRE/mDAZaYUyN9JDLiRnmxUF/s6nmRRDV9PwL
 uASZOoEexGv7SMeZBTxtxV8rFFXuDdcvoXs+fWZnOGTrDSVdzgLOWa2uCNrksyOH2fS4
 O+stRz0LGvJwpwmNzZHmPHH7A+b7fHFIhFCE6cw02bDPSVr8xNITmayhaPVXbU28mEj6
 LP3g==
X-Gm-Message-State: AOAM533759wPYQxPgfK/6wcjM61OuysUleJCRNFESEZ/+dmeI4X4dP1m
 s+CGvKtvrk0hUQngzqdWWh66DqEX1Zc=
X-Google-Smtp-Source: ABdhPJxGmV+JS0MKMY1boSMZx3Yo6mn6kNQpTYkz97NXYScS02zmOKpIYzcQLCFimG96LwWDpv34Dw==
X-Received: by 2002:a50:d80e:: with SMTP id o14mr19024074edj.49.1632680974430; 
 Sun, 26 Sep 2021 11:29:34 -0700 (PDT)
Received: from localhost.localdomain (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id t19sm7615704ejb.115.2021.09.26.11.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Sep 2021 11:29:34 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH libnvme] fabrics: restore hostname traddr support
Date: Sun, 26 Sep 2021 21:29:32 +0300
Message-Id: <20210926182932.55896-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_112935_896307_1965CE77 
X-CRM114-Status: GOOD (  12.16  )
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

We used to support hostname passed in traddr, with the move of nvme-cli
to use libnvme we lost this capability, now lets restore it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 src/nvme/fabrics.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 4b0ba16e66a8..ebfc6356844d 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -21,6 +21,8 @@
 
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <arpa/inet.h>
+#include <netdb.h>
 
 #ifdef CONFIG_SYSTEMD
 #include <systemd/sd-id128.h>
@@ -213,6 +215,63 @@ static int add_argument(char **argstr, const char *tok, const char *arg)
 	return 0;
 }
 
+static bool traddr_is_hostname(nvme_ctrl_t c)
+{
+	char addrstr[NVMF_TRADDR_SIZE];
+
+	if (!c->traddr)
+		return false;
+	if (strcmp(c->transport, "tcp") && strcmp(c->transport, "rdma"))
+		return false;
+	if (inet_pton(AF_INET, c->traddr, addrstr) > 0 ||
+	    inet_pton(AF_INET6, c->traddr, addrstr) > 0)
+		return false;
+	return true;
+}
+
+static int hostname2traddr(nvme_ctrl_t c)
+{
+	struct addrinfo *host_info, hints = {.ai_family = AF_UNSPEC};
+	char addrstr[NVMF_TRADDR_SIZE];
+	const char *p;
+	int ret;
+
+	ret = getaddrinfo(c->traddr, NULL, &hints, &host_info);
+	if (ret) {
+		fprintf(stderr, "failed to resolve host %s info\n", c->traddr);
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
+			host_info->ai_family, c->traddr);
+		ret = -EINVAL;
+		goto free_addrinfo;
+	}
+
+	if (!p) {
+		fprintf(stderr, "failed to get traddr for %s\n", c->traddr);
+		ret = -errno;
+		goto free_addrinfo;
+	}
+	c->traddr = strdup(addrstr);
+
+free_addrinfo:
+	freeaddrinfo(host_info);
+	return ret;
+}
+
 static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 {
 	struct nvme_fabrics_config *cfg = nvme_ctrl_get_config(c);
@@ -353,6 +412,11 @@ int nvmf_add_ctrl_opts(nvme_ctrl_t c, struct nvme_fabrics_config *cfg)
 	int ret;
 
 	cfg = merge_config(c, cfg);
+	if (traddr_is_hostname(c)) {
+		ret = hostname2traddr(c);
+		if (ret)
+			return ret;
+	}
 
 	ret = build_options(h, c, &argstr);
 	if (ret)
@@ -375,6 +439,11 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
 	cfg = merge_config(c, cfg);
 	nvme_ctrl_disable_sqflow(c, disable_sqflow);
 	nvme_ctrl_set_discovered(c, true);
+	if (traddr_is_hostname(c)) {
+		ret = hostname2traddr(c);
+		if (ret)
+			return ret;
+	}
 
 	ret = build_options(h, c, &argstr);
 	if (ret)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
