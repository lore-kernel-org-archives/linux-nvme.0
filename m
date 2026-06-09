Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F9CCD8CB2
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9LaWkWhrJUw9a/giq+cHZdt0Sg1l4kluVtd55JMhqgE=; b=qGkpiJY8v7dWV0CzDK+9N0Sc2V
	GMXDshnFKJPrL97cA7CFA8EhagI+164e7gmO5gaUP7dCvu5exbAgk+liTkqOAnhrBi2aiSvqwHHq1
	bPbgpI9V+bMuPRY5PStCO7U6/DfNNWTHl4XuxOY7bh3F+8q87vFhDM6HIYLfopwwOhAL9LXotMigg
	KeqROu5w2sFutIiVyn+bYfGsSbZG7++4i0CPYZvEiG08iL7tpMYeNw+cBdY8gCDAMqN3Q+WuNY0j3
	gvUbJPK5qOgPOjN0n3KUZc7PRxCoifjq/of9bWQ4H8YJDxRzt20P+1fu0UgEKIAWLInwmj7WnvL3Y
	a0DL9TvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzli-000000065wz-3c5i;
	Tue, 09 Jun 2026 16:57:38 +0000
Received: from mail-dy1-x134a.google.com ([2607:f8b0:4864:20::134a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzlg-000000065vp-07Zd
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 16:57:37 +0000
Received: by mail-dy1-x134a.google.com with SMTP id 5a478bee46e88-304e4636205so724435eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781024255; x=1781629055; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LaWkWhrJUw9a/giq+cHZdt0Sg1l4kluVtd55JMhqgE=;
        b=G6aGV2nT9bKA/P7Tb03N1ZNceVh4Z2daY4sC9wqS5+q46yGFe1JwUEIlhIjTX1qKAC
         a5mvk6BlWjcXOkLNs/cl9roCVgs8SULVBVl1ofXJFjPuEyn6plh2g5XcJPdO3scvfpra
         9Z1u03Yx+B5QDr8PuynvIYVLJK84rxZiJbyyrYEZdTGpTXSixPZ7MA/8LtbAy4FsfBMq
         VSqosYDPRXBU+x1mJudx37JOhQtGU1TQGe6wXxn4Hw+mJh8aPUmTTax+FJod+KWVGZ5n
         qcLBYX/FMmOZ3QRrtJy6XRCv4j6lLfPZvH7f+PobDjcB/4rdQCgE45qVoRDuZyg92SbZ
         kcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024255; x=1781629055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LaWkWhrJUw9a/giq+cHZdt0Sg1l4kluVtd55JMhqgE=;
        b=gVPZ/vFE5WzgRfLaPQAuSZUZvOWwd+McNOtOEUGMpObLpTyyQE23YbbnIHLbe4z+rj
         d5iVtYE8yQxDIl3B8tlCGMwS2cfncMH3dtYL/gibNi+EZmOk5SmI+o7yy/98ncf2fCye
         jKqvejF3R2Vpx1WXG0rZc6Hn3+M/zq7+uhh0YRFAYJrZQzGJrr7yDiQBn030SDRZzDMK
         vYKzv7Ceu/rb0muRITPKbHzx1cCI3cH81+t6zsCyIAQFdsGlchRhpqeMg9U/2UBIZdB/
         CNkTooqXWoROQJqtrCevpNmipUEdBPVBVt0y4CbVH8PYEQWZqIB34OnM+FyllSYt63zr
         iASQ==
X-Forwarded-Encrypted: i=1; AFNElJ++wM3arOVE3qE79TZWvtVpmUdb+MlDms94Bd4o9PtGPw2my03x5DnGdBfXg6XxD36RrJqHkxF5hzwz@lists.infradead.org
X-Gm-Message-State: AOJu0YzTaNSPznyo/bQcV5JbykPVNiXQlysZhY61bUwkkiWkDXyiE2jI
	ZWxKHKYBprM4Xbbq8GkbC6rlpgIxMhJLODyc9jewU6qoVYFEspRJvelk2STUEce/uQM9coPPTbK
	bVYYAw2m70A==
X-Received: from dyeg12.prod.google.com ([2002:a05:7300:538c:b0:2da:2af9:bfe2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72c9:b0:2ea:5057:a304
 with SMTP id 5a478bee46e88-3077aeed2fbmr12622888eec.2.1781024254393; Tue, 09
 Jun 2026 09:57:34 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:57:24 -0700
In-Reply-To: <20260609165726.786694-1-irogers@google.com>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com> <20260609165726.786694-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609165726.786694-2-irogers@google.com>
Subject: [PATCH v2 1/3] perf build: Add libnvme feature detection
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, yuzhuo@google.com
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, ashelat@redhat.com, german.gomez@arm.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, mjeanson@efficios.com, 
	namhyung@kernel.org, peterz@infradead.org, tglozar@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_095736_111627_769F291E 
X-CRM114-Status: GOOD (  16.09  )
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

Introduce a feature check for libnvme so that we can conditionally
compile the NVMe PMU driver. This checks for the availability of the
libnvme headers and library using pkg-config.

Signed-off-by: Ian Rogers <irogers@google.com>
CONV=ca4c5d09-4ef8-405a-80bb-aa988020b436
TAG=agy
---
 tools/build/Makefile.feature       |  5 ++++-
 tools/build/feature/Makefile       |  3 +++
 tools/build/feature/test-all.c     |  5 +++++
 tools/build/feature/test-libnvme.c | 11 +++++++++++
 tools/perf/Makefile.config         | 12 ++++++++++++
 5 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libnvme.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ed1374af31c1..3bc9a305256b 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -73,6 +73,7 @@ FEATURE_TESTS_BASIC :=                  \
         libbfd                          \
 	libbfd-threadsafe		\
         libelf                          \
+        libnvme                         \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
         libelf-getshdrstrndx            \
@@ -146,6 +147,7 @@ FEATURE_DISPLAY ?=              \
          libdw                  \
          glibc                  \
          libelf                 \
+         libnvme                \
          libnuma                \
          numa_num_possible_cpus \
          libpython              \
@@ -171,7 +173,8 @@ FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
 FEATURE_PKG_CONFIG ?=           \
 	 babeltrace2-ctf-writer \
          libtraceevent          \
-         libtracefs
+         libtracefs             \
+         libnvme
 
 feature_pkg_config = $(eval $(feature_pkg_config_code))
 define feature_pkg_config_code
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 62909a9c799d..fd00e0be6069 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -147,6 +147,9 @@ $(OUTPUT)test-libcap.bin:
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-libnvme.bin:
+	$(BUILD) -lnvme
+
 $(OUTPUT)test-eventfd.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 544563d62950..875eb9185e23 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -146,6 +146,10 @@
 # include "test-libopenssl.c"
 #undef main
 
+#define main main_test_libnvme
+# include "test-libnvme.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -178,6 +182,7 @@ int main(int argc, char *argv[])
 	main_test_libzstd();
 	main_test_libtraceevent();
 	main_test_libopenssl();
+	main_test_libnvme();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libnvme.c b/tools/build/feature/test-libnvme.c
new file mode 100644
index 000000000000..3fefad70a680
--- /dev/null
+++ b/tools/build/feature/test-libnvme.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include <libnvme.h>
+
+int main(void)
+{
+	nvme_root_t r = nvme_scan(NULL);
+
+	if (r)
+		nvme_free_tree(r);
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6e7b15fab2ec..79c4ad10bc18 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1060,6 +1060,18 @@ ifndef NO_CAPSTONE
   endif
 endif
 
+ifndef NO_LIBNVME
+  $(call feature_check,libnvme)
+  ifeq ($(feature-libnvme), 1)
+    CFLAGS += -DHAVE_LIBNVME_SUPPORT $(shell $(PKG_CONFIG) --cflags libnvme)
+    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libnvme)
+    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libnvme)
+    $(call detected,CONFIG_LIBNVME)
+  else
+    msg := $(warning No libnvme found, disables NVMe PMU support, please install libnvme-dev/libnvme-devel);
+  endif
+endif
+
 ifdef EXTRA_TESTS
     $(call detected,CONFIG_EXTRA_TESTS)
     CFLAGS += -DHAVE_EXTRA_TESTS
-- 
2.54.0.1099.g489fc7bff1-goog


