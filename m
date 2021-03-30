Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49EFC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:00:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321CE619C0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321CE619C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pSxkv0nDWmmsgtFE7yCV9l8G90lKrlNJjEyPhL4r5Ro=; b=jdI+LDxNSSoMIYY+IUBGm8Yx6
	N/MkMkQWo9XIJ82282w9SfzfDgVQ/YvRoPHClfoXfOaFpS7GL6mIKr9sMrPrne65uc0omECeg+S2J
	SpuYW8itSlcYQfqJAMlzSWqXZGI9B8yRe6ysPY8bfN0/XHzK/HtofBKfpqGGuGLVpobrbUtKiX5c3
	A0AxKZ+31EF3bbfA+TG8SJhNKYFlBrSvZ5KckkCoW+V8dPqjp+SdSIiiUY3nB6BiofGu2gCgjtSf6
	zcAUdfBzlbZ6pQM3pBKbxAROzdClrcF6I6yniBCQNkoxyRsTuKtwsiplDb8dQ3/F++pGpSJm6NVBJ
	RYj1O0ljw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRGnH-004Hiu-JJ; Tue, 30 Mar 2021 16:00:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRGll-004HQr-Uy
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 15:59:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617119941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lu+dmSGtiOa9SscCH743MMzu1VDMmLukLT8GXZmg1mw=;
 b=TkXy4P8Mu5qmYe00ixwEbmoZV9T/9T+/FNMt07iTD4+6bYGCCoAEzHK1WQV+Gf91/P3UYO
 Fkpl3go20N6a1J9rPD8LY5y2wVQ33C53YUJbTHJirZmKO6Ye0yC8n1oEAbvfVhtShv+aZ5
 LEKtU19PCYJfcejx1mBHuZRuxCseZrk=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D2034B1B7;
 Tue, 30 Mar 2021 15:59:01 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 4/9] nvme: add some simplifying macros for
 __attribute__((cleanup()))
Date: Tue, 30 Mar 2021 17:57:06 +0200
Message-Id: <20210330155711.8436-5-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210330155711.8436-1-mwilck@suse.com>
References: <20210330155711.8436-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_165906_188670_994E719E 
X-CRM114-Status: GOOD (  14.12  )
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

From: Martin Wilck <mwilck@suse.com>

Using __attribute__((cleanup())) is very helpful for writing leak-free
code, but it requires lots of awkward boiler plate code. Add some
small helpers to make its use more comfortable.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 Makefile       |  2 +-
 util/cleanup.c |  4 ++++
 util/cleanup.h | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 util/cleanup.c
 create mode 100644 util/cleanup.h

diff --git a/Makefile b/Makefile
index 3ea17b5..3412e5d 100644
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,7 @@ OBJS := nvme-print.o nvme-ioctl.o nvme-rpmb.o \
 	nvme-lightnvm.o fabrics.o nvme-models.o plugin.o \
 	nvme-status.o nvme-filters.o nvme-topology.o
 
-UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o
+UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o util/cleanup.o
 
 PLUGIN_OBJS :=					\
 	plugins/intel/intel-nvme.o		\
diff --git a/util/cleanup.c b/util/cleanup.c
new file mode 100644
index 0000000..0d5d910
--- /dev/null
+++ b/util/cleanup.c
@@ -0,0 +1,4 @@
+#include <stdlib.h>
+#include "cleanup.h"
+
+DEFINE_CLEANUP_FUNC(cleanup_charp, char *, free);
diff --git a/util/cleanup.h b/util/cleanup.h
new file mode 100644
index 0000000..89a4984
--- /dev/null
+++ b/util/cleanup.h
@@ -0,0 +1,18 @@
+#ifndef __CLEANUP_H
+#define __CLEANUP_H
+
+#define __cleanup__(fn) __attribute__((cleanup(fn)))
+
+#define DECLARE_CLEANUP_FUNC(name, type) \
+	void name(type *__p)
+
+#define DEFINE_CLEANUP_FUNC(name, type, free_fn)\
+DECLARE_CLEANUP_FUNC(name, type)		\
+{						\
+	if (*__p)				\
+		free_fn(*__p);			\
+}
+
+DECLARE_CLEANUP_FUNC(cleanup_charp, char *);
+
+#endif
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
