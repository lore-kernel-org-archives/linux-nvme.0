Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1457FC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Dec 2021 22:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ObJetYCehqVv4JW3JCQG6OObak1Yon+tTEha+0CKCIQ=; b=4LhGRw4ZhaRIvn/0wLIFptPKLF
	dq/D219SnSYHUIgTRp+KhoYfZZaA9azbW2fEhQeVORFMxxIvs5E2stgQePfABBqjHtgHeIj0bf/7+
	r+2hNg8x1QhjQzZdAW+82lP7b091mfBfr7ff2wuvjwImN5a4dyfVV/C/kda/Zgww1HXpGPRht75eY
	3ooIpXo14igkqLJwQ7cfKpz/sPqUwxex4TxyhSs7+8rqJUoGV8LPmfpZZYtF3yAVnmn82I4HDNbH2
	hwosWXm4C5bIxJmcRqCYRldE+MUvXcX3LbuC+i/I2IDsljfDiUS+/Je0umY//AVAYgASMIYYSU9qy
	/X5Whl6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1myLab-00CYSh-21; Fri, 17 Dec 2021 22:20:33 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1myLaY-00CYSB-AI
 for linux-nvme@lists.infradead.org; Fri, 17 Dec 2021 22:20:31 +0000
Received: by mail-pl1-x631.google.com with SMTP id y7so3057706plp.0
 for <linux-nvme@lists.infradead.org>; Fri, 17 Dec 2021 14:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ObJetYCehqVv4JW3JCQG6OObak1Yon+tTEha+0CKCIQ=;
 b=Q50ncMyMqUn5IxTMeVaDBXUUayk6xBdXLfVnSPcKZJ1PsktV/64dr+DLk2v9onougF
 hOKB5DRHDIRFCD4olS8kBUAcjL/2buWTZSCJ5rZOjVtvEYGVdQVp+qk3Scp1uuWcF8tZ
 /KzuGJRoLp6V4OXf961ZQ77EuTgEboMF+iSNOuAQUkCtOEQzc3MndP/QTx43loetKSTo
 E5+ncvBhc8A2RvgztJke+QCPy/k7IcB5DQQlGwYVp56s1qRyz802ORsad31eXpGAERWy
 QlH0UGPeH/2PV4Tzwp6k3D0tjLQAZS+kD3b9u4Mgi2kcYaB/k+BW4Alj/kH/fxeCM6x7
 8MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ObJetYCehqVv4JW3JCQG6OObak1Yon+tTEha+0CKCIQ=;
 b=qWRxRHfvFghBLJfTSSdaRLA49hEh0Cq7Ij1AQSVjYB82tNWuKU46zz1GD9i+658502
 wlp3VBJ3GgBMB1VsUeOdnfjHP+//xon429xhURBAuaplCnU8JgoGlQoOWWr7DbBDxj+k
 DxPzQRiB9JdHW5p4Izrp6OjhZr4CBSrDwimi8zpI7W5hrVPwzzGywHSh8AOqSCf0uQpL
 mI2qsyo+PqfekwscRbJ4fbTDD/+oSSJfFBaY8r2RRoDmAZHoZm3S4SUB/TSG+Lz+4duI
 3qvnaP3dFHGAfd15N+Ra9et9yzjRmjHSyih9Y74w5ndyvuLkf7bRxll+5QWSGuTqoB7s
 G0zQ==
X-Gm-Message-State: AOAM533B/7Wg5xH7mNL1BjRAwcBpRSM1NNS8JaqCHxn7ONL42vGoK8Sf
 GhrInjt/Y9s+GiJQIJOphY6fYwHzoWI=
X-Google-Smtp-Source: ABdhPJx6aNpDrtNgZNBDWkyN+Fs1qSemG0lx0JHwNRyLtSogBJzddtz7inFw9kaaGV5/yhEcYFrT7w==
X-Received: by 2002:a17:903:11c7:b0:148:ab0f:9faf with SMTP id
 q7-20020a17090311c700b00148ab0f9fafmr5124175plh.125.1639779629445; 
 Fri, 17 Dec 2021 14:20:29 -0800 (PST)
Received: from mail-ash-it-01.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b16sm9237335pgi.36.2021.12.17.14.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Dec 2021 14:20:29 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: James Smart <jsmart2021@gmail.com>
Subject: [PATCH v2] nvme-cli: Make connect-all matching be case insensitive
Date: Fri, 17 Dec 2021 14:20:22 -0800
Message-Id: <20211217222022.30516-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211217_142030_384387_83D432A8 
X-CRM114-Status: GOOD (  12.22  )
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
v2: handle strdup failures
---
 fabrics.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index d691191..ab4488c 100644
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
+	bool connect = true;
 
 	if (cargs_match_found(entry))
 		return false;
@@ -1396,7 +1405,22 @@ static bool should_connect(struct nvmf_disc_rsp_page_entry *entry)
 		return true;
 
 	len = space_strip_len(NVMF_TRADDR_SIZE, entry->traddr);
-	return !strncmp(fabrics_cfg.traddr, entry->traddr, len);
+
+	dctrl_traddr = strdup(fabrics_cfg.traddr);
+	log_traddr = strndup(entry->traddr, len);
+	if (!dctrl_traddr || !log_traddr)
+		goto free_exit;
+
+	strtolower(dctrl_traddr);
+	strtolower(log_traddr);
+
+	connect = (strlen(dctrl_traddr) == len) &&
+		  !strcmp(dctrl_traddr, log_traddr);
+
+free_exit:
+	free(log_traddr);
+	free(dctrl_traddr);
+	return connect;
 }
 
 static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
-- 
2.26.2


