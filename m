Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B11C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3D722B3B
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3D722B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oJvwH7NRjEtiZkFmDuHfmpt6PC3Sbr5/89sEjTCGUHk=; b=2JAvADEHiT62wMq5VieWwRUCd
	0iJWStOIp06EPjHwHhXTT+G6Xhr+T/n0BIMOg5x6fLuz5w6rhGFi20JF/MLBe38wGUJlMiJOUIWUH
	9Kb/40gLTJQf4Vdyx1vA55wXZxgc0buji/9ExxYhNV2PWwarS+PRk/djkjrsWGZt5dgpxjuhJ8JtA
	J8VAPsIEWM3jyr0MeqPo6zwNRdwLcWuh66p/S+CnkBjcZzXnwyMeHwul8Tejrwv5mON6iMQyoDGXR
	GxU1amz3zmL+F4pdPVoXWhky6s0dmNkrYiyZoB35vCkFER7I4dNeFf3dwabdOJGJQVp1SPyg5tb3B
	RWctZ5d9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2d-0001AO-J0; Tue, 26 Jan 2021 20:34:23 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V23-0000vQ-Tm
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:51 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiGwulb6DhrS/iRyJjlVaOZfDXN5y1Fu6ghHhinEkw0=;
 b=b+I8IBbI7sQlptRMg0E7QFABpZCwHszmZeVIWl1XKiIt2wwguFfQ5EPOgZWvJVtN0Va2sx
 XzpNdJS5mEWO+w627AYp+PAggfPdTh7L6nRzCXhUJPEQROzlNSphKYZbyVPVWYSamlOCqy
 56DGpBCLNQoFkScOJPAc6ySqcqG/USo=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 21FD3AF54;
 Tue, 26 Jan 2021 20:33:44 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 06/35] monitor: Create a log() macro.
Date: Tue, 26 Jan 2021 21:32:55 +0100
Message-Id: <20210126203324.23610-7-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153348_127355_5DCF148B 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

As this is a long running program, we need to make the log output
configurable. First step: replace fprintf() by log(). The log level
and printing of time stamps can be configured at run time using
global variables. These will live in fabrics.c.

Allow toggling function name printing at build time.
Printing the function name is useful for development, but perhaps
not desired for production.
Put '#define LOG_FUNCNAME' before '#include "log.h"' to switch it on.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 log.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 log.h

diff --git a/log.h b/log.h
new file mode 100644
index 0000000..2017731
--- /dev/null
+++ b/log.h
@@ -0,0 +1,44 @@
+#ifndef _LOG_H
+#define _LOG_H
+
+#ifndef MAX_LOGLEVEL
+#  define MAX_LOGLEVEL LOG_DEBUG
+#endif
+#ifndef DEFAULT_LOGLEVEL
+#  define DEFAULT_LOGLEVEL LOG_NOTICE
+#endif
+
+#ifdef LOG_FUNCNAME
+#define _func_fmt "%s: "
+#define _func_arg __func__
+#else
+#define _func_fmt "%s"
+#define _func_arg ""
+#endif
+
+extern int log_level;
+extern bool log_timestamp;
+#define _TIME_FMT "[%ld.%06ld] "
+#define log(lvl, format, ...) \
+	do {								\
+		int __lvl = (lvl);					\
+									\
+		if (__lvl <= MAX_LOGLEVEL && __lvl <= log_level) {	\
+			if (log_timestamp) {				\
+				struct timespec __ts;			\
+									\
+				clock_gettime(CLOCK_MONOTONIC, &__ts);	\
+				fprintf(stderr,				\
+					_TIME_FMT _func_fmt format,	\
+					__ts.tv_sec, __ts.tv_nsec / 1000,\
+					_func_arg,			\
+					##__VA_ARGS__);			\
+			} else {					\
+				fprintf(stderr, _func_fmt format,	\
+					_func_arg,			\
+					##__VA_ARGS__);			\
+			};						\
+		}							\
+	} while (0)
+
+#endif /* _LOG_H */
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
