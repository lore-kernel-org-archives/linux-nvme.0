Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8D1CD8CAE
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 07:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kEG6upLE0OCaQvJtXF2OY7o4khEThpYQjE5hsRLVHoQ=; b=QMLzY3geZ+1FGx08KUTdxyM4q9
	RNPkxxbb8SenDaVUs21fhY/2sT3Jf5eMyeDN6KHtBHxggvQKcj+yuIq7g9q1kPdHb0Ghi81WkDqk0
	pCsA0gksP/jj1Ui+NNLAbda/ehjyLUPsRJyzFmxTmvhZtybQaoo2JBES+RvqvhJfjHQTvsjHphcQ6
	Ebu7RJVh/Y45hN3TFRnaaOuBR17j6bJ6f+sSGap+C70OR8sKWWABhWvAstMAHKL748xyrmcneN1Pz
	HqXzUS5i0HTsE3uZ1k+LwWZ5cnLiZmjwRC+qEgJKvXiDJzpmC89uPU4kuiViXldRPHNz1VxfmLtJ9
	wytW3Yww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWqVE-00000004w1Y-2OnM;
	Tue, 09 Jun 2026 07:04:00 +0000
Received: from mail-dl1-x124a.google.com ([2607:f8b0:4864:20::124a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWqVC-00000004w0j-3qYX
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 07:04:00 +0000
Received: by mail-dl1-x124a.google.com with SMTP id a92af1059eb24-137f3465368so6856347c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988637; x=1781593437; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEG6upLE0OCaQvJtXF2OY7o4khEThpYQjE5hsRLVHoQ=;
        b=AMgGiA+sB8gnfQTGCfoUiRPfrCX+9oHVAgr+QsrhW+flon0dxyvIyORLPtb4FDO/Y5
         5ejoiVpwarmFiUMr4sS+3LH4taL6RkUO0s9KuBNGQ1Vw1mRPtF1YYECyVh6jifmYseGB
         lbCe8cjzwT61D4vok7ZqvgOWHz+Wu8m97caJaVQR+Cb1qwdwJ1DDl0/XdBUZH4p4M9Ma
         Ov3lgefpYjk4SJK0jWx3C7c44u7aFEsYPFsaglvgOOEXOKlMblE1mijF31IX8cV/sp+V
         CmdG1Kk0yeQBtcojkZCapU+g1rWfDG4phSRpkl1EWBMI36GRqP8M24MUAzwL9vSxUMb7
         0Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988637; x=1781593437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEG6upLE0OCaQvJtXF2OY7o4khEThpYQjE5hsRLVHoQ=;
        b=SlTrsL8NA1JIbPmBnd3XvFnXNDKrbCb923utbEdA7RqCCKrcmW4y7T8D10K6CEE1yc
         w7ZpUtNEsQUist0G+hh/hEbbVbMjm1fPk6+QpRTbIJmdov/JEK20JGTLp1G/pHM+Vevi
         FbPb2SY1DowuLJv5Sv1WPHzEgUsxP9MeEPvkuaJFCrwbNeFHLj6nUfwseNy3UZOjEoVx
         vbkPq/KTmlZNyy2Gx0MD1DMLMxbVFs2xdbpU9hhOUlOPbeB+PyD3jfSVNTGjkiVZmSDS
         6giTIkC8cyLsQ9owTcdWNo4n6aXNVAVAsxhAtobw1rydFQ6gR2hmjouiSd2iwlMyPwvN
         kuug==
X-Gm-Message-State: AOJu0Yy4qaazcWCoMFcJLI+uX0LxAEAiBU+yMOGrClHRu9ClFqK1bk+g
	wgvMa0PFnttaoGRiXaiINIEPj85Dhs6ItKf/nVIzDdsMxoR6dNqzUkpLgSc+lKN2qIM9HwPiBgS
	7VvlTk3cizg==
X-Received: from dlbrh9.prod.google.com ([2002:a05:7022:f309:b0:138:106:9053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6897:b0:136:c77a:6509
 with SMTP id a92af1059eb24-138067036e8mr8600936c88.25.1780988637161; Tue, 09
 Jun 2026 00:03:57 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:03:46 -0700
In-Reply-To: <20260609070348.541964-1-irogers@google.com>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070348.541964-2-irogers@google.com>
Subject: [PATCH v1 1/3] perf build: Add libnvme feature detection
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tomas Glozar <tglozar@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, German Gomez <german.gomez@arm.com>, 
	Anubhav Shelat <ashelat@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_000358_956738_A2E13E97 
X-CRM114-Status: GOOD (  16.70  )
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
 tools/build/Makefile.feature       |  2 ++
 tools/build/feature/Makefile       |  3 +++
 tools/build/feature/test-libnvme.c | 11 +++++++++++
 tools/perf/Makefile.config         | 12 ++++++++++++
 4 files changed, 28 insertions(+)
 create mode 100644 tools/build/feature/test-libnvme.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ed1374af31c1..bf8503241539 100644
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
2.54.0.1064.gd145956f57-goog


