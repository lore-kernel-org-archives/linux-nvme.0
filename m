Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979DAC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 18:28:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C814060EFD
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 18:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C814060EFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FzyaXN5DX8FG2yAHNes30BFB7jcULjM680lJwgFQYaQ=; b=nONHGxYnNk3cMY
	QgMPPe6lwNHQrNRpuR5JiPmjyoV9ytvgY1XAjtMrCj7XEmjL+8wMiObXbuOy/bB6ypwc1ove71sNt
	7saI/5+X7Zu01JLcsz544+QyzGbnKA0B6eZLLeh0MUP80B6sfu3E2r4s8CT7t718sz7lTaGC8Alle
	25BqV63lCD7OpK05FnABZZLY6XVPAqSadnVNeAF8tJjexWm+H/53g2kS0woOBfCGcOhySoM9dOA+B
	0WmE8XvlzNiDi68hLnfFGG5LaReQViADxRvaPR7hwEInRpdIj0XALmCZQOYWm7oubrNcMCAeNNpw1
	eRkywQxqZeThielGCC2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUYsW-000tr1-Nj; Sun, 26 Sep 2021 18:27:56 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUYsT-000tqJ-Jx
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 18:27:55 +0000
Received: by mail-ed1-f44.google.com with SMTP id v18so24163152edc.11
 for <linux-nvme@lists.infradead.org>; Sun, 26 Sep 2021 11:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m6S6npILdeE1LAH8WSSYErih9pRmxmAqQELhZFtVzc4=;
 b=3b4VeHQAF8MFUrilDrkT5p0yQqQ49mX4HThWqPPUPhyYzmh3yA1JLEI21W3J3F0A8b
 flgpBGKXeF8zWuaWAlMnwCpmrsdW8fgXRMihle4XiwS75Ef9lv5zxGTZJP5JzpvzJ5cp
 NePsnqgVNsZ5G5iDpDtRjoIZbyhRuYZgW0Jjirhbxtg13hf6AOqmMRZcvrtKpZjKJX+8
 hQZjKbQtFrxfiwZynvcaETTuertlQRvBRf6+MUeTBXtWQ5Y12PK7uVvuunjEJrZ5kc4q
 3xtoWNa81JGIfqbroa40rj08a58YrGgNLIaTDycaZU9vgVcQ9nEnEebjCrszlkisDM/A
 mCsA==
X-Gm-Message-State: AOAM532tqpQGVxnga1sJwmFnh9csAlwnML8PbHAvMflBobjQD8yse+H9
 VScP+Cz29pUCgiJ7KnDayrSc6UFjYWA=
X-Google-Smtp-Source: ABdhPJy1WKrU8TDAzWwx1Vmu/l1H7wKv3f/hdcJBQUoW4aSTOHOiTo1wYQgzNYtsO8Ye+2eIqEpE3g==
X-Received: by 2002:a50:e006:: with SMTP id e6mr18391454edl.302.1632680871818; 
 Sun, 26 Sep 2021 11:27:51 -0700 (PDT)
Received: from localhost.localdomain (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id cr9sm9268146edb.17.2021.09.26.11.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Sep 2021 11:27:51 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH nvme-cli] fabrics: restore discover_from_conf_file to actually
 work
Date: Sun, 26 Sep 2021 21:27:49 +0300
Message-Id: <20210926182749.55191-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_112753_704662_68B6067C 
X-CRM114-Status: GOOD (  13.40  )
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

With all the rework, discover_from_conf_file was completely
broken. Have both discover and connect-all working with
params passed from /etc/nvme/discovery.conf

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index b13254683e14..012bcb8819e0 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -299,7 +299,10 @@ static int discover_from_conf_file(nvme_host_t h, const char *desc,
 	char *hostnqn = NULL, *hostid = NULL;
 	char *ptr, **argv, *p, line[4096];
 	int argc, ret = 0;
+	unsigned int verbose = 0;
 	FILE *f;
+	enum nvme_print_flags flags;
+	char *format = "normal";
 
 	struct nvme_fabrics_config cfg = {
 		.tos = -1,
@@ -308,8 +311,18 @@ static int discover_from_conf_file(nvme_host_t h, const char *desc,
 
 	OPT_ARGS(opts) = {
 		NVMF_OPTS(cfg),
+		OPT_FMT("output-format", 'o', &format,        output_format),
+		OPT_FILE("raw",          'r', &raw,           "save raw output to file"),
+		OPT_FLAG("persistent",   'p', &persistent,    "persistent discovery connection"),
+		OPT_FLAG("quiet",        'S', &quiet,         "suppress already connected errors"),
+		OPT_INCR("verbose",      'v', &verbose,       "Increase logging verbosity"),
+		OPT_END()
 	};
 
+	ret = flags = validate_output_format(format);
+	if (ret < 0)
+		return ret;
+
 	f = fopen(PATH_NVMF_DISC, "r");
 	if (f == NULL) {
 		errno = ENOENT;
@@ -340,7 +353,8 @@ static int discover_from_conf_file(nvme_host_t h, const char *desc,
 		ret = argconfig_parse(argc, argv, desc, opts);
 		if (ret)
 			goto next;
-
+		if (persistent && !cfg.keep_alive_tmo)
+			cfg.keep_alive_tmo = 30;
 		if (!transport && !traddr)
 			goto next;
 
@@ -351,8 +365,8 @@ static int discover_from_conf_file(nvme_host_t h, const char *desc,
 		errno = 0;
 		ret = nvmf_add_ctrl(h, c, &cfg, false);
 		if (!ret) {
-			__discover(c, defcfg, NULL, persistent,
-				   connect, 0);
+			__discover(c, &cfg, raw, connect,
+				   persistent, flags);
 			if (!persistent)
 				ret = nvme_disconnect_ctrl(c);
 			nvme_free_ctrl(c);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
