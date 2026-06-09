Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8B3CD8CB9
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 16:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kk15DTxaQ0tIvg731hyT6citJMfmYcqs4ehaiocNNGU=; b=0wEMnaV5n0ucm3ywvzZEJ+VFOG
	HAza1QmmdkzREchmlo3NGW/kGEPXtiAYCzSpZnsUnhzzFfCqXK9+mkDaGyDqmQIzZ1sMYswgx5Mik
	1NfDWOsLAHhU+lS0TmtcTL1ogNGYJgu4CBE8nyOqKGgWU975eJ1GiwTgl18+bvNZ2mhflhLGjSJPB
	R7EGsDCInC6APl8vLhL2Z04D1cEwbhCrus1PUyGJPQMkLDCBNqLzAaS/VXps68PNgTnGmoiNplS90
	QdrfLIX+CSQzq//xneXfRen7P2d+OYxiqC1UIQzQdQfUEDUE9Ju8XvdP+16Tuxz7YyTqAABiR3WZV
	LasdUBeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzln-000000065zo-1E1w;
	Tue, 09 Jun 2026 16:57:44 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzlk-000000065xL-3zba
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 16:57:42 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2bf32259e0eso76371515ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781024259; x=1781629059; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kk15DTxaQ0tIvg731hyT6citJMfmYcqs4ehaiocNNGU=;
        b=XL9m48rRufWqVcD2WNa8pRJuASqc5LG9PAdD9Jf+gxUuwLeoMoXbH1xXBGWzmLgLm+
         Px8FfoWvChw48CcMbm3po1B5QcB8muj+TaKT/u5QuzauAojQd6C+f2d/LsQQpyrtjyeH
         VdowJEVxYWY4e/n/vQK5jcw6OGbtfTAGpW1CYf1fR6qwIzMdBFYXcSg63MMkE1OPlBCH
         MSjzsymybWO6EAZRzVX568FfVbHOJQkl3gGOcOiXA8+dEyu75Rqjijvg5h8sfkHye5R6
         Agc33ovobnLIL4MQqTk7jAL7Gzgvqpbsl8+8yYkp41iIlfXvSHKzeI0XUqDwAdsEff4p
         VJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024259; x=1781629059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk15DTxaQ0tIvg731hyT6citJMfmYcqs4ehaiocNNGU=;
        b=ZsP0smazNX7uNAQAqVh/D2dUDi//fI7u63xj2XjwqHOmy/Xy76/0axagp2rXgUSew1
         NY1Dwb3GTWjcQomAxjKGx5/uK3pyTH6xeP3usKYExZoBZaRUHMdG7Fs8iowkKrG2E40i
         TjCqcfrZQKtYzMBo4INNMuG0bCqa2klutNpBu2vBPGeJK3fVJOcAjuxyMJb9av/aPO4K
         XZjoymIAzTTPjHpecUVZ2WfFwUeyn1FiQtx7EluCl9sL3LpEsOdfaLf5nZkc2s25ktVB
         kB+PL+YzoxIG+P4BLGG7nW7n2PN/m0Lu4IBwjGp4a5V5roDEWoVxZDW9rOCOWomMTx36
         lvqQ==
X-Forwarded-Encrypted: i=1; AFNElJ97IH750XolzvVDlUX4cN9YQ56li9+pphw2JOEZlk/+AzYbm4Ublcr5ebToeJ+J+u0YcmH5YjcuUauN@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+B0YuQS1s582vjtYX2prufsYhl9E76lD1VR4ksP2aRXssDGsZ
	rybEeE7sTAQychJkFLKzItpxs6Vsm67Z8br5AyNM7GZnen9K+/se9rxoYLK1rsY//BnD3ovq6I7
	zrpBJLXAQ/g==
X-Received: from plbla3.prod.google.com ([2002:a17:902:fa03:b0:2c0:3419:c540])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc50:b0:2c1:6e2a:40b
 with SMTP id d9443c01a7336-2c1e80d2ae2mr236942335ad.2.1781024259126; Tue, 09
 Jun 2026 09:57:39 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:57:26 -0700
In-Reply-To: <20260609165726.786694-1-irogers@google.com>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com> <20260609165726.786694-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609165726.786694-4-irogers@google.com>
Subject: [PATCH v2 3/3] perf tests: Add NVMe PMU event parsing test
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
X-CRM114-CacheID: sfid-20260609_095741_022799_E2E92857 
X-CRM114-Status: GOOD (  21.70  )
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
index e2391726d76e..c58048f69b43 100644
--- a/tools/perf/util/nvme_pmu.c
+++ b/tools/perf/util/nvme_pmu.c
@@ -26,33 +26,6 @@
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
2.54.0.1099.g489fc7bff1-goog


