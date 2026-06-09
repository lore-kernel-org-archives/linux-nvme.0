Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14306CD8CAD
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JqifOfdVc95h96Q4UZJnIrnFSeB34LFLKmiuA9pWjLg=; b=1ETgPESgjQVsWw+yq/tU0mYMTq
	HRbq8kmLlmpIlreJdvLcQH4B1ArDJGC52ei5cOn7rUuLK+z4OKI9H6IegFJ1AAeHC+UJaZ3uKYxvV
	5c3lhLETciGFUzELgGDL5RA3vgC2520Nj4nKnyjy6KNb7xxCEP4zin1dXG6ZtaHm37wWH/suIbk7/
	rBCjDUj9/2Yfg+GiuzodH8chlA3Tw/fN7fHcoMOYfIi8JpkwaU8UFF3ldznOV1fX4caZXdxm+YQ83
	2QOqv/CvEtmXuUQsDDiKpzE0W2v+YUtj9dzJojV7Eoa/RvVY8ZMMLwxa/Xgag3RnIpoW9cN+FlJ3z
	Qf3/b/4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWqVJ-00000004w4e-2dXx;
	Tue, 09 Jun 2026 07:04:05 +0000
Received: from mail-dl1-x1249.google.com ([2607:f8b0:4864:20::1249])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWqVG-00000004w2S-0fRL
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 07:04:03 +0000
Received: by mail-dl1-x1249.google.com with SMTP id a92af1059eb24-13815e0e6baso2114593c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988641; x=1781593441; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqifOfdVc95h96Q4UZJnIrnFSeB34LFLKmiuA9pWjLg=;
        b=vT3NusjhFx/Qk29tlH1LZktRVhPnk4ZjGbI0xmLPiBL9m1I3iNt+saR2FHsEiDHiDu
         8VO1O3WxXqUTPzjyy0W5070zBrW3/f29KXgC1vZmAb0t5M2krpn1bvZrfFtcnBsapXOv
         j/8bDb9il0yeCWpW+kOjW2ZD5MD8TzAfZFSdMhV8JMA0JyEFlb23Op10fHCN1EHGjC2P
         NeQMAY+V5Kd98yw+DrbOfRCy1oI/BR3cJlI5Gv8mp96SqhcmzgAYIRHkHnpwapXcxPzs
         cCmkHRR0YktWXCDABUHFNKnw7elEJrD3H8bGXwHXmMdFYBLWN4W4Y0+YgdFNoX302z4z
         VAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988641; x=1781593441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqifOfdVc95h96Q4UZJnIrnFSeB34LFLKmiuA9pWjLg=;
        b=EzUlNXSmiB1lscXW/JnIMhNNigBVrZ+7kkAd4qIfu/OpQXk9ufTnPlzU2cqwr8PiVT
         Z+0gtoEvC0PxM3WNnTytjm/msKEEbtlQWUm505pKrkgikO+rOu1PioOzzi9Yv0XR3wZH
         R8fPIHd0siv/7zGJPvLUjjCPFFnUcUZbwcn5STWb+Z/5S+yX9fC9PdKL6BgaVeIPOuDx
         rm+yBsWc4fm7BZrCL6Xgpjt6NEXA0oh+WEgZTB3iI8R6GM0sL3qblpnvkVs5zl7o4yqa
         dCSyGNt8nAJ7R/4PlPXlcThn8W9UAsGZpCEICFezJQGBi0U3MkWBRobC//Wsy7FXsKcd
         IGGg==
X-Gm-Message-State: AOJu0YzfxY5GONhYHytzJAkvPaurdaiMtUCx/dPSaZxMCdOwPfl7tuF6
	s2k9cchw7aVC3ATn7ubST/i3Rt9vFPpnlIdxH/hg9TPmeY+y4faoeTazEgTSIS/lsr6JfJTbEQ8
	9s7Aa32JEUQ==
X-Received: from dled13-n2.prod.google.com ([2002:a05:701b:42cd:20b0:138:14f4:c975])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ebc3:b0:138:30b1:4c09
 with SMTP id a92af1059eb24-13830b1502cmr1247788c88.10.1780988640669; Tue, 09
 Jun 2026 00:04:00 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:03:48 -0700
In-Reply-To: <20260609070348.541964-1-irogers@google.com>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070348.541964-4-irogers@google.com>
Subject: [PATCH v1 3/3] perf tests: Add NVMe PMU event parsing test
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
X-CRM114-CacheID: sfid-20260609_000402_206985_FF0C237D 
X-CRM114-Status: GOOD (  23.34  )
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

Introduce a unit test suite for the NVMe PMU event parser.
The test registers a mock 'nvme_nvme0' PMU and checks that all of
our mapped events (SMART, Endurance, FDP, Error, ZNS) parse into the
correctly configured configs.

To support this, moved the NVMe event config encoding macros and the
'nvme_log_type' enum from nvme_pmu.c to nvme_pmu.h.

Signed-off-by: Ian Rogers <irogers@google.com>
CONV=ca4c5d09-4ef8-405a-80bb-aa988020b436
TAG=agy
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/nvme_pmu.c     | 176 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/nvme_pmu.c      |  27 -----
 tools/perf/util/nvme_pmu.h      |  31 ++++++
 tools/perf/util/pmus.c          |   5 +
 tools/perf/util/pmus.h          |   1 +
 8 files changed, 216 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/tests/nvme_pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 66944a4f4968..acaf5e3e728b 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -68,6 +68,7 @@ perf-test-y += event_groups.o
 perf-test-y += symbols.o
 perf-test-y += util.o
 perf-test-y += hwmon_pmu.o
+perf-test-y += nvme_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b64fc2204f22..9a2fb706c2bc 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -83,6 +83,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__pmu,
 	&suite__pmu_events,
 	&suite__hwmon_pmu,
+	&suite__nvme_pmu,
 	&suite__tool_pmu,
 	&suite__dso_data,
 	&suite__perf_evsel__roundtrip_name_test,
diff --git a/tools/perf/tests/nvme_pmu.c b/tools/perf/tests/nvme_pmu.c
new file mode 100644
index 000000000000..3c1de6e92efc
--- /dev/null
+++ b/tools/perf/tests/nvme_pmu.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "nvme_pmu.h"
+
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "pmus.h"
+#include "tests.h"
+
+#ifdef HAVE_LIBNVME_SUPPORT
+
+static const struct test_event {
+	const char *name;
+	const char *alias;
+	uint64_t config;
+} test_events[] = {
+	{
+		"smart_temperature",
+		"smart_temperature",
+		NVME_SMART(2, temperature),
+	},
+	{
+		"smart_data_units_read",
+		"smart_data_units_read",
+		NVME_SMART(16, data_units_read),
+	},
+	{
+		"endurance_percent_used",
+		"endurance_percent_used",
+		NVME_ENDURANCE(1, percent_used),
+	},
+	{
+		"fdp_hbmw",
+		"fdp_hbmw",
+		NVME_FDP(16, hbmw),
+	},
+	{
+		"error_count",
+		"error_count",
+		NVME_ERROR(8, error_count),
+	},
+	{
+		"zns_nrzid",
+		"zns_nrzid",
+		NVME_ZNS(2, nrzid),
+	},
+};
+
+static int do_test(size_t i, bool with_pmu, bool with_alias)
+{
+	const char *test_event = with_alias ? test_events[i].alias : test_events[i].name;
+	struct evlist *evlist = evlist__new();
+	struct evsel *evsel;
+	struct parse_events_error err;
+	int ret;
+	char str[128];
+	bool found = false;
+
+	if (!evlist) {
+		pr_err("evlist allocation failed\n");
+		return TEST_FAIL;
+	}
+
+	if (with_pmu)
+		snprintf(str, sizeof(str), "nvme_nvme0/%s/", test_event);
+	else
+		strlcpy(str, test_event, sizeof(str));
+
+	pr_debug("Testing '%s'\n", str);
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, str, &err);
+	if (ret) {
+		pr_debug("FAILED %s:%d failed to parse event '%s', err %d\n",
+			 __FILE__, __LINE__, str, ret);
+		parse_events_error__print(&err, str);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	ret = TEST_OK;
+	if (with_pmu ? (evlist->core.nr_entries != 1) : (evlist->core.nr_entries < 1)) {
+		pr_debug("FAILED %s:%d Unexpected number of events for '%s' of %d\n",
+			 __FILE__, __LINE__, str, evlist->core.nr_entries);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel->pmu || !evsel->pmu->name ||
+		    strcmp(evsel->pmu->name, "nvme_nvme0"))
+			continue;
+
+		if (evsel->core.attr.config != test_events[i].config) {
+			pr_debug("FAILED %s:%d Unexpected config for '%s', %"
+				 PRIu64 " != %" PRIu64 "\n",
+				 __FILE__, __LINE__, str,
+				 (uint64_t)evsel->core.attr.config,
+				 test_events[i].config);
+			ret = TEST_FAIL;
+			goto out;
+		}
+		found = true;
+	}
+
+	if (!found) {
+		pr_debug("FAILED %s:%d Didn't find nvme event '%s' in parsed evsels\n",
+			 __FILE__, __LINE__, str);
+		ret = TEST_FAIL;
+	}
+
+out:
+	parse_events_error__exit(&err);
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int test__nvme_pmu(bool with_pmu)
+{
+	struct perf_pmu *pmu = perf_pmus__add_test_nvme_pmu("nvme0", "nvme0");
+	int ret = TEST_OK;
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(test_events); i++) {
+		ret = do_test(i, with_pmu, /*with_alias=*/false);
+		if (ret != TEST_OK)
+			break;
+
+		ret = do_test(i, with_pmu, /*with_alias=*/true);
+		if (ret != TEST_OK)
+			break;
+	}
+
+	list_del(&pmu->list);
+	perf_pmu__delete(pmu);
+	return ret;
+}
+
+static int test__nvme_pmu_without_pmu(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	return test__nvme_pmu(/*with_pmu=*/false);
+}
+
+static int test__nvme_pmu_with_pmu(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	return test__nvme_pmu(/*with_pmu=*/true);
+}
+
+static struct test_case tests__nvme_pmu[] = {
+	TEST_CASE("Parsing without PMU name", nvme_pmu_without_pmu),
+	TEST_CASE("Parsing with PMU name", nvme_pmu_with_pmu),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__nvme_pmu = {
+	.desc = "NVMe PMU",
+	.test_cases = tests__nvme_pmu,
+};
+
+#else
+
+struct test_suite suite__nvme_pmu = {
+	.desc = "NVMe PMU",
+	.test_cases = NULL,
+};
+
+#endif
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index bf8ff7d54727..abffa51c5937 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -115,6 +115,7 @@ DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
 DECLARE_SUITE(hwmon_pmu);
+DECLARE_SUITE(nvme_pmu);
 DECLARE_SUITE(tool_pmu);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
diff --git a/tools/perf/util/nvme_pmu.c b/tools/perf/util/nvme_pmu.c
index 17ba758aec59..ee0e958ea6ef 100644
--- a/tools/perf/util/nvme_pmu.c
+++ b/tools/perf/util/nvme_pmu.c
@@ -25,33 +25,6 @@
 #ifdef HAVE_LIBNVME_SUPPORT
 #include <libnvme.h>
 
-
-#define NVME_CONFIG(log, size, offset) \
-	(((uint64_t)(log) << 24) | ((uint64_t)(size) << 16) | (offset))
-
-enum nvme_log_type {
-	NVME_LOG_SMART = 0,
-	NVME_LOG_ENDURANCE = 1,
-	NVME_LOG_FDP = 2,
-	NVME_LOG_ERROR = 3,
-	NVME_LOG_ZNS = 4,
-};
-
-#define NVME_SMART(size, field) \
-	NVME_CONFIG(NVME_LOG_SMART, size, offsetof(struct nvme_smart_log, field))
-
-#define NVME_ENDURANCE(size, field) \
-	NVME_CONFIG(NVME_LOG_ENDURANCE, size, offsetof(struct nvme_endurance_group_log, field))
-
-#define NVME_FDP(size, field) \
-	NVME_CONFIG(NVME_LOG_FDP, size, offsetof(struct nvme_fdp_stats_log, field))
-
-#define NVME_ERROR(size, field) \
-	NVME_CONFIG(NVME_LOG_ERROR, size, offsetof(struct nvme_error_log_page, field))
-
-#define NVME_ZNS(size, field) \
-	NVME_CONFIG(NVME_LOG_ZNS, size, offsetof(struct nvme_zns_changed_zone_log, field))
-
 struct nvme_event {
 	const char *name;
 	const char *desc;
diff --git a/tools/perf/util/nvme_pmu.h b/tools/perf/util/nvme_pmu.h
index 6d5d2bbe4167..9203f461f381 100644
--- a/tools/perf/util/nvme_pmu.h
+++ b/tools/perf/util/nvme_pmu.h
@@ -6,6 +6,37 @@
 #include <stdbool.h>
 #include <errno.h>
 
+#ifdef HAVE_LIBNVME_SUPPORT
+#include <libnvme.h>
+#include <stddef.h>
+
+#define NVME_CONFIG(log, size, offset) \
+	(((uint64_t)(log) << 24) | ((uint64_t)(size) << 16) | (offset))
+
+enum nvme_log_type {
+	NVME_LOG_SMART = 0,
+	NVME_LOG_ENDURANCE = 1,
+	NVME_LOG_FDP = 2,
+	NVME_LOG_ERROR = 3,
+	NVME_LOG_ZNS = 4,
+};
+
+#define NVME_SMART(size, field) \
+	NVME_CONFIG(NVME_LOG_SMART, size, offsetof(struct nvme_smart_log, field))
+
+#define NVME_ENDURANCE(size, field) \
+	NVME_CONFIG(NVME_LOG_ENDURANCE, size, offsetof(struct nvme_endurance_group_log, field))
+
+#define NVME_FDP(size, field) \
+	NVME_CONFIG(NVME_LOG_FDP, size, offsetof(struct nvme_fdp_stats_log, field))
+
+#define NVME_ERROR(size, field) \
+	NVME_CONFIG(NVME_LOG_ERROR, size, offsetof(struct nvme_error_log_page, field))
+
+#define NVME_ZNS(size, field) \
+	NVME_CONFIG(NVME_LOG_ZNS, size, offsetof(struct nvme_zns_changed_zone_log, field))
+#endif
+
 struct list_head;
 struct perf_thread_map;
 struct evsel;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 83777f941e9a..1c45164ae244 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -909,6 +909,11 @@ struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
 	return hwmon_pmu__new(&other_pmus, hwmon_dir, sysfs_name, name);
 }
 
+struct perf_pmu *perf_pmus__add_test_nvme_pmu(const char *sysfs_name, const char *name)
+{
+	return nvme_pmu__new(&other_pmus, sysfs_name, name);
+}
+
 struct perf_pmu *perf_pmus__fake_pmu(void)
 {
 	static struct perf_pmu fake = {
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 0d55edb3f2fc..2045d4cf44d1 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -37,6 +37,7 @@ struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name)
 struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
 					       const char *sysfs_name,
 					       const char *name);
+struct perf_pmu *perf_pmus__add_test_nvme_pmu(const char *sysfs_name, const char *name);
 struct perf_pmu *perf_pmus__fake_pmu(void);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
 
-- 
2.54.0.1064.gd145956f57-goog


