Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C3C433E4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C132B20774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WUKZatou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C132B20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9FMuHQ6CuapjLCaB0E3QXAtkNprGfPq1n02DarUIaEI=; b=WUKZatouoHOi8S4FuaidM3oa0r
	HCPCYG6LH2gHP6LoA82bdeHd7tfQomMFZwq+DgS8vXLLHRvo4kaJGTTOrZZLy+OwIqwOUXuPuMfln
	qlzRe4LNKTEm+9sMIL9/EDbsHkVYmhhiRHFCkzprCeIpcP+mXIyZzH/eEl7I7mcUY1B8SnD2B9819
	A7INUAdOtFxQYSgmkcX0RHd4DYWkPfhftKzJnjPpzrE54ujmc8OoEhxAmuxnRwmB9mYQti37yNTSt
	gAvhNxChpc5fqv+SMiCH23YptMVtUFcbDKJd+Yh9ulrRN+Vx9jtNz3B9kn9HCI1kk7LEmoL8zuhTg
	qCHKJreA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6gXI-00037F-Us; Fri, 14 Aug 2020 20:42:49 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6gXG-000368-4W
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 20:42:47 +0000
Received: by mail-pf1-f194.google.com with SMTP id 74so5095430pfx.13
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 13:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oCYweqM8eP15htsXqKVras/FuHcj9/SeyUb9D6o1b+E=;
 b=cMI28yjORPs9QfIreyqsSVx23Ag0RYaLKTI6niocvk2A1/xp+wKFy5yw9rksRSigFQ
 pvBZGKACcPKQD4JIKKGB3+VMW4fL2kUIXtadNa0yK2V8uJsGaeSbIV0CKoCNAuXWNcUv
 chq8bRLZYkVZEu5vSGQjqE7mgFVVaJ8J4R48byp5MJjd5M3rXCx0DmnZLCy+dV28RIGf
 7yF4/FdoQGAU4n6FnSzXRPTnb5fxWj6OUJhEIQ1WW6F/U4lVT6Z24xam7XBbjBB/huwc
 09dUjsW/R+sT5mAueF13Fsf0nHhNipyukmmhBcXwgvBCSiYU2MAEXvXnVdxxlvXDSuqk
 xApg==
X-Gm-Message-State: AOAM5310eb/6cwgAHrt9IysLrekYAZEmLBLy8x6BNiyavmBZ78CWdc+o
 obaWIGvNNlyMg6rr30DJ5Nl2+7AmmdIf9w==
X-Google-Smtp-Source: ABdhPJyhMWU9KdtYpe551Q8AxhPlogrqe3xK9G4v3y6WNq7JQXwQ/EevahgDv5zMeXZFW6/vHhEAwA==
X-Received: by 2002:a65:63ca:: with SMTP id n10mr2945630pgv.252.1597437763758; 
 Fri, 14 Aug 2020 13:42:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id
 l63sm9141125pgl.24.2020.08.14.13.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:42:43 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH rfc 1/3] nvme: add fabrics discovery controller default port
 number
Date: Fri, 14 Aug 2020 13:42:37 -0700
Message-Id: <20200814204239.751787-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814204239.751787-1-sagi@grimberg.me>
References: <20200814204239.751787-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_164246_254546_4624258A 
X-CRM114-Status: GOOD (  16.13  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The IANA port number for a discovery controller is 8009
for NVMe/TCP and 4420 for any NVMe/RDMA port number. So make
sure to fill it and pass it down, it will help us as we
track and match connection arguments for filtering purposes.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common.h     |  3 +++
 fabrics.c    | 17 +++++++++++++++++
 linux/nvme.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/common.h b/common.h
index aed2a9918b23..1c214a447fd3 100644
--- a/common.h
+++ b/common.h
@@ -9,4 +9,7 @@
 #define min(x, y) ((x) > (y) ? (y) : (x))
 #define max(x, y) ((x) > (y) ? (x) : (y))
 
+#define __stringify_1(x...) #x
+#define __stringify(x...)  __stringify_1(x)
+
 #endif
diff --git a/fabrics.c b/fabrics.c
index 78ed6251f8a6..17d969b17dd5 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -863,6 +863,17 @@ static int build_options(char *argstr, int max_len, bool discover)
 	return 0;
 }
 
+static void discovery_trsvcid(struct config *cfg)
+{
+	if (!strcmp(cfg->transport, "tcp")) {
+		/* Default port for NVMe/TCP discovery controllers */
+		cfg->trsvcid = __stringify(NVME_DISC_IP_PORT);
+	} else if (!strcmp(cfg->transport, "rdma")) {
+		/* Default port for NVMe/RDMA controllers */
+		cfg->trsvcid = __stringify(NVME_RDMA_IP_PORT);
+	}
+}
+
 static bool traddr_is_hostname(struct config *cfg)
 {
 	char addrstr[NVMF_TRADDR_SIZE];
@@ -1320,6 +1331,9 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 				goto out;
 		}
 
+		if (!cfg.trsvcid)
+			discovery_trsvcid(&cfg);
+
 		err = build_options(argstr, BUF_SIZE, true);
 		if (err) {
 			ret = err;
@@ -1392,6 +1406,9 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 				goto out;
 		}
 
+		if (!cfg.trsvcid)
+			discovery_trsvcid(&cfg);
+
 		ret = build_options(argstr, BUF_SIZE, true);
 		if (ret)
 			goto out;
diff --git a/linux/nvme.h b/linux/nvme.h
index a7ab85d03067..de2502929ebb 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -70,6 +70,7 @@ static inline uint64_t le64_to_cpu(__le64 x)
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
 #define NVME_RDMA_IP_PORT	4420
+#define NVME_DISC_IP_PORT	8009
 
 #define NVME_NSID_ALL		0xffffffff
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
