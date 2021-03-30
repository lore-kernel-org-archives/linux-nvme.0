Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F06CC433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 11:59:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0AD60190
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 11:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0AD60190
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yB/T2KW4mO3I6LmsMtWIy+bxUU81eTctL+2PutSTGm8=; b=CZA8kD/Y9jHNiEbswZojuNP0K
	AgPm/pXv46WldnHZHKIZx/DkzGvpW6fvaWhU+uJKNnokPYcl11e0IYkaqBmTdYkaC4PLaowSt7A35
	2HK8mKy4KpH5Ynv2kyuniNcSjcOb9ZJRqA2G9ps1rjuiXDLd2QK/GNR5zeY2D8R0jLsP9f5f/x9uD
	GJ2/4smmKBDQw859CfklBxlAs0gUchTH/VNHyDTb4Sz/hYQeqoKuS6S0bOkPreu7TTqJJ2uooTUri
	IkTbGu01o+UWaZCQ85JScRU28bEudMNDE9ybRE88XYGScIEku3c2RtPgPB3mKyiheCgMm7si4LgtY
	d3Q35n2nQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRD2C-003dY1-IG; Tue, 30 Mar 2021 11:59:48 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRD23-003dWe-4J
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 11:59:41 +0000
Received: by mail-pj1-x102c.google.com with SMTP id
 il9-20020a17090b1649b0290114bcb0d6c2so9360102pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m4Y5gzaHrEa08dvfUZETSykHjHYgPmAWkTNLxKttZ2E=;
 b=Go4fp2PQUquHuJhR4VT+u1yV2R+nJOqW2DDIaaBQg6hZ4XLmoVH0PX7J1i8iyYMeq1
 M4tmhxem434rN1QLn73wUGDGiKWiD8wXq2cNOW9ZZappMgwQCaLr9pB0sIHhGig3y9ff
 uayYPk0/jyLfO9USD7ROvF1NJpERebygFpTCqd0myvPLs9F3HaGg2nj3uVNqLLo6FFXS
 SY02od+LSqAzFylf7SqZFa7OAxm9a49dEpgQXv95yjGBrwV5kW4dk+wfGeQ/uG9v7DVQ
 3MuJ4FPamQb9lwZG4UynMJ0wt5wMIfabQEd5wGJzu99kib3Y1PJMxXlyqAz+0f9GfKA7
 ADHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m4Y5gzaHrEa08dvfUZETSykHjHYgPmAWkTNLxKttZ2E=;
 b=gD+HZHrDgVod+nGX8jPIlxlXVN6cUMsBmjwa+HaY648rNMCEqIUKydNt4ogS6qu666
 0vdSgLQJcAjgXWt3SrhkUQqVHNGlDv+zBhxxD4McBuD8Nl+IeBpKzKklpkLa2Hof4j/L
 ffKVo/O8GSZruFjG9B2aQYjIg8E7nLS2rkcKGb5PebAS0aS88I1lFhf1ZawsRYrMmpqY
 Jrzh5wRmGRnK+THOlK00P5NQWk5KIc7KRqtRudfyAt2SqBxZE/KFqRGtDfMklmKhQkcD
 gnwJqSGm8k4ioEaXRllAPZqyyCchCVnaFFswOmbQRh5Pezt/CATnAHuKxeCAVY4loKBW
 Do/Q==
X-Gm-Message-State: AOAM533FQpcfisNAro7+29SdBE4kk6u1ulseXqcKyHQ4M2lS1u3TL63D
 opmJfeI31MG5oTUQx/abvvI=
X-Google-Smtp-Source: ABdhPJwoyZyRHkoPK1Q6RQKWMAj6YGQPb1tpVGIxOJqvABeFbVic1Kt2cGhFrSABZYB+Wnxisyeo5Q==
X-Received: by 2002:a17:902:d4cb:b029:e5:f608:6d5e with SMTP id
 o11-20020a170902d4cbb02900e5f6086d5emr33163332plg.20.1617105577675; 
 Tue, 30 Mar 2021 04:59:37 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id a204sm20088284pfd.106.2021.03.30.04.59.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Mar 2021 04:59:37 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH 1/2] nvmet: return proper error code from discovery ctrl
Date: Tue, 30 Mar 2021 19:59:06 +0800
Message-Id: <20210330115907.15432-2-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210330115907.15432-1-houpu.main@gmail.com>
References: <20210330115907.15432-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_125939_553579_645DB158 
X-CRM114-Status: GOOD (  11.38  )
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

Return NVME_SC_INVALID_FIELD from discovery controller
like normal controller when executing identify or
get log page command.

Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/discovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 682854e0e079..4845d12e374a 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -178,12 +178,14 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
 		req->error_loc =
 			offsetof(struct nvme_get_log_page_command, lid);
-		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto out;
 	}
 
 	/* Spec requires dword aligned offsets */
 	if (offset & 0x3) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lpo);
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto out;
 	}
@@ -250,7 +252,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 
 	if (req->cmd->identify.cns != NVME_ID_CNS_CTRL) {
 		req->error_loc = offsetof(struct nvme_identify, cns);
-		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto out;
 	}
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
