Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B022606A8AC
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IFXtZoKz;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T06mAOLl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EpSUjkvVyuVjTU8V73krPKRXpvbCCfxf8Z/PrENmWGc=; b=IFXtZoKzqhwDdJgEBouhGfoDAJ
	WF3u7Pl8gGyvVAjnNznwYJIktGf9YxtCIDi5Ofvjs9Fxq5oPSNOY+GFpcz+bEI1kYTitGmYlu1yO6
	7K+V3aPS4ozfMlvYRQAEY5j4sT31gCNSZWptkxUr54xiXSnfxYucCLWGNFkav+5u4dhGbfbuCRLOt
	zebfPI3VMyWIxoeCt86PYUpPM6QO3+CIa/Fpjbsn25uf1ByX5L0fzRCMOw4fJF8OC31YVrgVk6yvA
	j4iE7m2Ui4CxUgHaMOqgTQIpjSILST5vMYfel0eLYN+BS8p/POKHtK9zZYmVRu/N+O582VKh48zRJ
	uCY74rZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwhz-0000000E7cZ-0bYy;
	Fri, 13 Nov 2026 19:13:11 +0000
Received: from mail-dy1-x1347.google.com ([2607:f8b0:4864:20::1347])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwhu-0000000E7Zl-1v1y
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 19:13:07 +0000
Received: by mail-dy1-x1347.google.com with SMTP id 5a478bee46e88-375bac6bd21so949053eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 11:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794597184; x=1795201984; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpSUjkvVyuVjTU8V73krPKRXpvbCCfxf8Z/PrENmWGc=;
        b=T06mAOLlE+O0pCWUFaMWvHLXahyMJs3e9A9E3CcjncFSU3AbZVtOnzqiYm7fYrrZoP
         1+2dsb8ttM1Ldc4ZS6bN6J7ickoUquoFC4omEr4mzHfwDnR39mrtiF+2TohZ7NvILJFs
         lBskwUlJsn2cR2qKbbKYaeIt3uCDyl2g3o4OSBIjczATtVRMvzwrgQBmonSZ9uRoyCX5
         IlDl2+5e7J4OxTUk7UzjbP6EpnaCZB6zDebLv1IBNPEeU1QkVODSbIMSrR2eZGcOOWPw
         HTI6o9H5G8LD5PHx5/SxfWn1ezGwno+1i9YumbHfxYNbEwGDk9iozybMCe7H40XBaOXC
         b3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597184; x=1795201984;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EpSUjkvVyuVjTU8V73krPKRXpvbCCfxf8Z/PrENmWGc=;
        b=qMxf7RdWoMzTQ8z7hy46MiY2hjHMzSgPw7SAarUOYqjuxtw+fSAENLE0Q/vYFJeHzy
         NFITBiNI8eKtMCH58VhwpHYXZ0tUdLVhisNu9Ypk/p+FL6FArJw6Aol0ZkZ6Hv26rCFR
         feLkUAJD/5nAuw7PlH6i1UWZzm/n5U9qIPfmkx5oMRwSDO4jRGe6+ajH+FyV1gO6soVj
         1dCbheSgNqQF7W4N7Q1c+vxTGXOO8n7r7I6/w9RhBv9DR5Fiq0GOsDzLYRC8WqX9cf/p
         1hiiT2diV3QgPbFn09OiqIjmu9O9/u8VNm1VzfynvoOIMZ10nuXdnnBCSnNFP5S6TH7t
         MMhQ==
X-Forwarded-Encrypted: i=1; AL+hErG7dkphxBh8STstuzIbc1CGSDgVhSuRMIWkhS7tGvjrQMzxuEsqiMzX0+z9HB9NGUCoF/n2X3BqG0zi@lists.infradead.org
X-Gm-Message-State: APuU4Z+/k6SzR8BeqWAvRgu2x6+9zjcjAuUJec00PJYFp8rXMQr9qBTl
	bCqlUI8bHzYb0kWB9Mg8qYFtGsfX8KwTGD6U63gE5sH7joktFsnzRMsmD8jypNpk1pDTSGXoNFi
	aO9FHkk/M4A==
X-Received: from dyax25-n1.prod.google.com ([2002:a05:693c:4199:10b0:36a:16ac:9308])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4544:b0:364:377c:cabe
 with SMTP id 5a478bee46e88-377e1af656dmr5493378eec.24.1794597183856; Fri, 13
 Nov 2026 11:13:03 -0800 (PST)
Date: Fri, 13 Nov 2026 11:12:32 -0800
In-Reply-To: <20261113191234.2509964-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113191234.2509964-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113191234.2509964-2-irogers@google.com>
Subject: [PATCH v3 1/3] perf build: Add libnvme feature detection
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>, Yuzhuo Jing <yuzhuo@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Tomas Glozar <tglozar@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Leo Yan <leo.yan@arm.com>, German Gomez <german.gomez@arm.com>, 
	Anubhav Shelat <ashelat@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_111306_503356_9F8ED8D7 
X-CRM114-Status: GOOD (  16.81  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a feature check for libnvme using pkg-config so that the
tool-provided NVMe PMU can be conditionally compiled when libnvme is
available.

Add libnvme to FEATURE_TESTS_BASIC, FEATURE_DISPLAY, FEATURE_PKG_CONFIG,
and test-all.c so fast-path discovery and individual feature checks stay
consistent with the pkg-config flags used during linking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature       |  5 ++++-
 tools/build/feature/Makefile       |  4 ++++
 tools/build/feature/test-all.c     |  5 +++++
 tools/build/feature/test-libnvme.c | 11 +++++++++++
 tools/perf/Makefile.config         | 12 ++++++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libnvme.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 4d37d11f674c..54b51251c4c3 100644
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
@@ -143,6 +144,7 @@ FEATURE_DISPLAY ?=              \
          libdw                  \
          glibc                  \
          libelf                 \
+         libnvme                \
          libnuma                \
          numa_num_possible_cpus \
          python-module          \
@@ -168,7 +170,8 @@ FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
 FEATURE_PKG_CONFIG ?=           \
 	 babeltrace2-ctf-writer \
          libtraceevent          \
-         libtracefs
+         libtracefs             \
+         libnvme
 
 feature_pkg_config = $(eval $(feature_pkg_config_code))
 define feature_pkg_config_code
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 10340a537224..851f458163f6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -24,6 +24,7 @@ FILES=                                          \
          test-cxa-demangle.bin                  \
          test-libcap.bin			\
          test-libelf.bin                        \
+         test-libnvme.bin                       \
          test-libelf-getphdrnum.bin             \
          test-libelf-gelf_getnote.bin           \
          test-libelf-getshdrstrndx.bin          \
@@ -147,6 +148,9 @@ $(OUTPUT)test-libcap.bin:
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-libnvme.bin:
+	$(BUILD) # -lnvme provided by $(FEATURE_CHECK_LDFLAGS-libnvme)
+
 $(OUTPUT)test-eventfd.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 4a6890290f74..155f92efc2c8 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -150,6 +150,10 @@
 # include "test-libopenssl.c"
 #undef main
 
+#define main main_test_libnvme
+# include "test-libnvme.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_python_module();
@@ -183,6 +187,7 @@ int main(int argc, char *argv[])
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
index b4764f69f47f..d82273dadf39 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1065,6 +1065,18 @@ ifndef NO_CAPSTONE
   endif
 endif
 
+ifndef NO_LIBNVME
+  ifeq ($(feature-libnvme), 1)
+    CFLAGS += -DHAVE_LIBNVME_SUPPORT $(shell $(PKG_CONFIG) --cflags libnvme)
+    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libnvme)
+    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libnvme)
+    $(call detected,CONFIG_LIBNVME)
+  else
+    $(warning No libnvme found, disables NVMe PMU support, please install libnvme-dev/libnvme-devel)
+    NO_LIBNVME := 1
+  endif
+endif
+
 ifdef EXTRA_TESTS
     $(call detected,CONFIG_EXTRA_TESTS)
     CFLAGS += -DHAVE_EXTRA_TESTS
-- 
2.56.1.703.gf848ed807c-goog


