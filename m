Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E0CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Dec 2021 19:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4ADmTcTfsGd8e3njpqKbgdytgQSE7c42Py8wBh7qu3Q=; b=3zZe+U34VnFU8HWWErIWCb209B
	t4ojiThraQcJRNu/hDdlOFlipit/jwYwElNSdczVV1MUbr1MtUk6MjUWUbqeeyAPIj55bSTMq4+ew
	GZRFYNd3VgMgX7lPYLFq6jzOHS/ZmmAwE45LRpMrbo5JF8/y86T3DKv7/rDJnx+rUl4CfF23k42EO
	e9y8QWAW1gSE3jkeswY1lv7zD76IsKzIBglnoFb3d80gRqGmPsUn1v7IyseN6WPkEp/HTz4NNydWu
	15Qn7wT5MW9boG8U5f7Kfwa2PNeIWlGHgHxYIGHgaN82NP6W5FXBJStnQ+DmDxoGmhJ8f2ApL6T6W
	e3zJgWDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1myIy0-00C8du-KT; Fri, 17 Dec 2021 19:32:32 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1myIxx-00C8ct-Tk
 for linux-nvme@lists.infradead.org; Fri, 17 Dec 2021 19:32:31 +0000
Received: by mail-pg1-x530.google.com with SMTP id d11so3091881pgl.1
 for <linux-nvme@lists.infradead.org>; Fri, 17 Dec 2021 11:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4ADmTcTfsGd8e3njpqKbgdytgQSE7c42Py8wBh7qu3Q=;
 b=kX3ng2FN9ISmTCdOV+S9NgF8uR4pNkXJN5KMeEwe6vmzpAAXkQMUGEoab62kwT+/U+
 cCsHxjobXptgRrVbC5fMAbi/MwYPHo/dILlUmfejGxYdTJ9hrEvLkKnhGuGwA+GA6lop
 qp16RSp3TUwiyVfs0GtORV0DNWsfsyOARckxFZH0PDcySivjdi/FWAuCdfepoMwAaFQX
 oinWfp9yOAf7iRjANHCwB1V7dTl6fud7kDGWPMwTGB+alHOG4K4EUqfLYBHG5E1mIRdk
 bDdaI+sxj+ersKQLtb0IZkcDGDf2oxwaSi2AG250IVKeAr/zp1XTMq4by/mv5EZcb7Bj
 uMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4ADmTcTfsGd8e3njpqKbgdytgQSE7c42Py8wBh7qu3Q=;
 b=1aK3wQiGQW2f9DQnS6HMdqQhTL9e2HrBD3Qj2aG1if3aC2uSplWdmQBuwH/rJ6wHDk
 M0Bg4EBaKqrXjQP2PILJL5y6FSFFp+WPB+Eve1/AiCa2s/42SIizu/OerkzMf7ay9fV/
 MkUdscMH7Y5oyLnGTF8J2GWlS3liviNE5YLsMb7ERiMXx7m+WlgtGslGuIDYHqltAnLM
 aoI4pyR4MR/oYsxnRZeBjZNHEYQ3mRXS4Ap9+yvHV6ochaKFFuVyj3kFtRl+1MKcKsjP
 4HGoBoSYhoTVJWVojHl5mvPzBxc1owPf5ukrMqCjPScG7Q3QXT9O0gWc1YjxaPCPS/sK
 85zQ==
X-Gm-Message-State: AOAM532eFOlm4B+AOFLDzrd13797Ih0sDxU1uudMlxyV97sTre3+sajb
 dC0xJq/jxEwhvjjZgDjP067F5pyFHJQ=
X-Google-Smtp-Source: ABdhPJwflBY+LM0mMKwbOlvF9DAQVeGvGRUHGLc6CKP0MsIzPsV5Egw3IfEEv11Itjk9EoWuzWfuVg==
X-Received: by 2002:a63:6806:: with SMTP id d6mr4186348pgc.68.1639769548374;
 Fri, 17 Dec 2021 11:32:28 -0800 (PST)
Received: from mail-lvn-it-01.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id w2sm7938071pgt.93.2021.12.17.11.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Dec 2021 11:32:27 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: James Smart <jsmart2021@gmail.com>
Subject: [PATCH] nvme-cli: Make connect-all matching be case insensitive
Date: Fri, 17 Dec 2021 11:32:20 -0800
Message-Id: <20211217193220.28984-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211217_113230_004376_2C9793DC 
X-CRM114-Status: GOOD (  11.56  )
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

The comparison routine that checks discovery controller traddr with a
discovery log traddr uses a simple strncmp.  For FC, which kicks off
connect-all requests vay systemd, the nvme-fc transport will build
traddr strings with lower case hexadecimal.  Some FC discovery
controllers return traddr strings with upper case hexadecimal. There
was is no rqmt in the NVME-FC spec that it be upper or lower case.
Given the case difference, the connect-all fails the match logic and
doesn't connect to storage.

Revise the traddr comparison routine to duplicate the strings and
convert them to lower case for comparison.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 fabrics.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index d691191..f3bbf50 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -34,6 +34,7 @@
 #include <stddef.h>
 #include <syslog.h>
 #include <time.h>
+#include <ctype.h>
 
 #include <sys/types.h>
 #include <arpa/inet.h>
@@ -681,6 +682,12 @@ static int space_strip_len(int max, const char *str)
 	return i + 1;
 }
 
+static void strtolower(char *str)
+{
+	for ( ; *str; str++)
+		*str = tolower(*str);
+}
+
 static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec,
 				int instance)
 {
@@ -1383,7 +1390,9 @@ static bool cargs_match_found(struct nvmf_disc_rsp_page_entry *entry)
 
 static bool should_connect(struct nvmf_disc_rsp_page_entry *entry)
 {
+	char *dctrl_traddr, *log_traddr;
 	int len;
+	bool connect = false;
 
 	if (cargs_match_found(entry))
 		return false;
@@ -1396,7 +1405,17 @@ static bool should_connect(struct nvmf_disc_rsp_page_entry *entry)
 		return true;
 
 	len = space_strip_len(NVMF_TRADDR_SIZE, entry->traddr);
-	return !strncmp(fabrics_cfg.traddr, entry->traddr, len);
+	dctrl_traddr = strdup(fabrics_cfg.traddr);
+	log_traddr = strndup(entry->traddr, len);
+	strtolower(dctrl_traddr);
+	strtolower(log_traddr);
+
+	connect = (strlen(dctrl_traddr) == len) &&
+		  !strcmp(dctrl_traddr, log_traddr);
+
+	free(log_traddr);
+	free(dctrl_traddr);
+	return connect;
 }
 
 static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
-- 
2.26.2


