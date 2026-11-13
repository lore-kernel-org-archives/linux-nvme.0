Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F356606A333
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WoCn1Wm4;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MHsVYFN4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WfUO+QAnUhk3kJEbZLZWOhsMR7Pb1ynIqJCBQIT9iaw=; b=WoCn1Wm4wQT7yJ2G3pJMoSdd3J
	4HhWaWlpgxsQy9LIBm+4vm8iEquxZWaaGiq+TIpmUYstPt4m8WW4GuMfddQscFwYC3yyOLzjWEdSU
	g9w6U5C4+ei0jpZm9gUH4UcU8UN5Zj6IieXLCVEd49kVk34NDYMUBQGhIvryJzO4kHwV8xotmMFHI
	iOqQpYRJgcb79ujTffa5OTXRZyUItsDkSnB4jkfQ7A6Qrts+CCtdRMG8ejc8b1+P5hbFmmSaHL/Iq
	3n7y9VqAEPMDFOTbYZiDNq1AeRDAv0r5FIjGKeb26XaO0rmXdQttpt9/PdEV7j/0s1/bwUC23j4hc
	kVNyAmUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwi7-0000000E7hM-0c2d;
	Fri, 13 Nov 2026 19:13:19 +0000
Received: from mail-dl1-x1246.google.com ([2607:f8b0:4864:20::1246])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwhz-0000000E7bX-1ZD1
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 19:13:15 +0000
Received: by mail-dl1-x1246.google.com with SMTP id a92af1059eb24-139b62317d0so5040606c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 11:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794597190; x=1795201990; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WfUO+QAnUhk3kJEbZLZWOhsMR7Pb1ynIqJCBQIT9iaw=;
        b=MHsVYFN423ZjJb7d6uVkDPcHx0/ScjBJvKMI7hDgNxV4bfKzdqe1ADXJPhLAM/C/CL
         kKn5locEp5FsfKcUCL2+z5zhoOIsh7iuaFlidK7Rdt/nodBvG14w0wFNaZpPGOyWW0u4
         ryep2qrrpaFpQyvo1rdNb8Tzv0reEAzdUxtc7TjuxtGUwGuACjeYB9y3nwEnCOCj/HlX
         Yft/NeSoVbtTCA+NOWaiSNDhX5qvo5E7ZyHe37Ub5lSJ+0RFW3ZJq0dWUqcSzqowPV16
         o7bp/ZTsGsDXtiQrHMmsqRKtzYdoe/fQWdqfTz+32VYHX67FaJpAVsCoOaArFMBxlScP
         Kh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597190; x=1795201990;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WfUO+QAnUhk3kJEbZLZWOhsMR7Pb1ynIqJCBQIT9iaw=;
        b=QNhR3r2tuO2MqqFTynk82XCKwy46Nf1AM83fmMm7s0QHkIbruklfjr/AxPbjj2BitV
         AHIfwCRvi/RV4xNopRPBZpCg7zG6jOhqecyvi7cYM7SJtZ3MNb1NL6x09jOT2eQLNbhL
         REw3CYE38i0NU9wy80rBfEt6P2hfVIuJbXAH9pbyp+9YMnOqRj6X7jig2eWXj8694VBE
         jRSV0Rc3Nix3oFKvuugiVsdpAGAslKktLoWVuLSydHICDcsaKFA7AU1v+l7C6zUrJGHg
         NCrbqTy7hdF8Bl1eJMDyBlGV39MIQFiwoj5Bioo+ruKo9T07DZ2WVzM3sAy1R/BZGE0Z
         Ft7A==
X-Forwarded-Encrypted: i=1; AL+hErFwl+9uaFgR31FR40TLUebPqWYAqM667Syy3ZBDT//h5mrSpyELS5hz3+oQNT3ATzroXBqGxX6qqSki@lists.infradead.org
X-Gm-Message-State: APuU4Z/yeHwm3zbnKIuzSqRKoa0N4ks69JQrwkstISoWJ10zhBU+pel5
	8c5SaT7rImiZhd2H44mZUQwdgqQ9B1eVgB4dtdLZjbraRzKphU50Y+PChEx4JCO1gjmyZE9XfOf
	HOiBjDj0fZQ==
X-Received: from dlbuj4.prod.google.com ([2002:a05:7022:3d84:b0:15f:5ef4:b896])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2513:b0:1ab:faad:cc9
 with SMTP id a92af1059eb24-1b503115806mr4410106c88.11.1794597189054; Fri, 13
 Nov 2026 11:13:09 -0800 (PST)
Date: Fri, 13 Nov 2026 11:12:34 -0800
In-Reply-To: <20261113191234.2509964-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113191234.2509964-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113191234.2509964-4-irogers@google.com>
Subject: [PATCH v3 3/3] perf tests: Add NVMe PMU event parsing test
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
X-CRM114-CacheID: sfid-20261113_111311_444196_A2DAE8D2 
X-CRM114-Status: GOOD (  23.23  )
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

Introduce a unit test suite for the NVMe tool PMU event parser. The test
registers a mock test NVMe PMU ('nvme_a_test_nvme_pmu' with alias
'nvme1234') and verifies:
- Event parsing without a PMU prefix and with both PMU name and alias.
- Event config encoding, unit, and scale across SMART, Endurance, FDP,
  Error, and ZNS log events (including Kelvin temperature scaling).
- Support for 'event=<name>', raw 'config=0x...', and 'name=' qualifiers.
- Clean rejection of unknown event names, invalid raw configs, duplicate
  event terms, and unsupported string terms where term->config is NULL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/nvme_pmu.c     | 303 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/pmus.c          |   5 +
 tools/perf/util/pmus.h          |   1 +
 6 files changed, 312 insertions(+)
 create mode 100644 tools/perf/tests/nvme_pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5eebb2ec5dde..336bad77c8f4 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -71,6 +71,7 @@ perf-test-y += hybrid-merge.o
 perf-test-y += symbols.o
 perf-test-y += util.o
 perf-test-y += hwmon_pmu.o
+perf-test-y += nvme_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 327483f96401..0b88018c7036 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -124,6 +124,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__pmu,
 	&suite__pmu_events,
 	&suite__hwmon_pmu,
+	&suite__nvme_pmu,
 	&suite__tool_pmu,
 	&suite__dso_data,
 	&suite__perf_evsel__roundtrip_name_test,
diff --git a/tools/perf/tests/nvme_pmu.c b/tools/perf/tests/nvme_pmu.c
new file mode 100644
index 000000000000..c3c17ccc9ea0
--- /dev/null
+++ b/tools/perf/tests/nvme_pmu.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "nvme_pmu.h"
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <string.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/string.h>
+
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "parse-events.h"
+#include "pmus.h"
+#include "tests.h"
+
+#ifdef HAVE_LIBNVME_SUPPORT
+
+enum test_encoding_mode {
+	TEST_ENCODING_NAME,
+	TEST_ENCODING_ALIAS_PMU,
+	TEST_ENCODING_EVENT_TERM,
+	TEST_ENCODING_RAW_CONFIG,
+	TEST_ENCODING_WITH_NAME_QUALIFIER,
+};
+
+static const struct test_event {
+	const char *name;
+	const char *unit;
+	double scale;
+	uint64_t config;
+} test_events[] = {
+	{
+		"smart_temperature",
+		"K",
+		1.0,
+		NVME_SMART(2, temperature),
+	},
+	{
+		"smart_data_units_read",
+		"B",
+		512000.0,
+		NVME_SMART(16, data_units_read),
+	},
+	{
+		"endurance_percent_used",
+		"",
+		1.0,
+		NVME_ENDURANCE(1, percent_used),
+	},
+	{
+		"endurance_data_units_read",
+		"B",
+		1000000000.0,
+		NVME_ENDURANCE(16, data_units_read),
+	},
+	{
+		"fdp_hbmw",
+		"B",
+		1.0,
+		NVME_FDP(16, hbmw),
+	},
+	{
+		"error_count",
+		"",
+		1.0,
+		NVME_ERROR(8, error_count),
+	},
+	{
+		"zns_nrzid",
+		"",
+		1.0,
+		NVME_ZNS(2, nrzid),
+	},
+};
+
+static int do_test(size_t i, bool with_pmu, enum test_encoding_mode mode)
+{
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
+	if (!with_pmu) {
+		strlcpy(str, test_events[i].name, sizeof(str));
+	} else {
+		switch (mode) {
+		case TEST_ENCODING_NAME:
+			snprintf(str, sizeof(str), "nvme_a_test_nvme_pmu/%s/",
+				 test_events[i].name);
+			break;
+		case TEST_ENCODING_ALIAS_PMU:
+			snprintf(str, sizeof(str), "nvme1234/%s/", test_events[i].name);
+			break;
+		case TEST_ENCODING_EVENT_TERM:
+			snprintf(str, sizeof(str), "nvme_a_test_nvme_pmu/event=%s/",
+				 test_events[i].name);
+			break;
+		case TEST_ENCODING_RAW_CONFIG:
+			snprintf(str, sizeof(str), "nvme_a_test_nvme_pmu/config=0x%" PRIx64 "/",
+				 test_events[i].config);
+			break;
+		case TEST_ENCODING_WITH_NAME_QUALIFIER:
+			snprintf(str, sizeof(str),
+				 "nvme_a_test_nvme_pmu/%s,name=custom_nvme_event/",
+				 test_events[i].name);
+			break;
+		default:
+			ret = TEST_FAIL;
+			goto out_put;
+		}
+	}
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
+	if (with_pmu ? (evlist__nr_entries(evlist) != 1)
+		     : (evlist__nr_entries(evlist) < 1)) {
+		pr_debug("FAILED %s:%d Unexpected number of events for '%s' of %d\n",
+			 __FILE__, __LINE__, str, evlist__nr_entries(evlist));
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel->pmu || !evsel->pmu->name ||
+		    strcmp(evsel->pmu->name, "nvme_a_test_nvme_pmu"))
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
+		if (!evsel->unit || strcmp(evsel->unit, test_events[i].unit) != 0 ||
+		    evsel->scale != test_events[i].scale) {
+			pr_debug("FAILED %s:%d Unexpected unit/scale for '%s', '%s'/%g != '%s'/%g\n",
+				 __FILE__, __LINE__, str,
+				 evsel->unit ?: "(null)", evsel->scale,
+				 test_events[i].unit, test_events[i].scale);
+			ret = TEST_FAIL;
+			goto out;
+		}
+		if (mode == TEST_ENCODING_WITH_NAME_QUALIFIER &&
+		    strcmp(evsel__name(evsel), "custom_nvme_event") != 0) {
+			pr_debug("FAILED %s:%d Unexpected custom name '%s'\n",
+				 __FILE__, __LINE__, evsel__name(evsel));
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
+out_put:
+	evlist__put(evlist);
+	return ret;
+}
+
+static int test__nvme_pmu(bool with_pmu)
+{
+	struct perf_pmu *pmu = perf_pmus__add_test_nvme_pmu("nvme1234", "a_test_nvme_pmu");
+	int ret = TEST_OK;
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(test_events); i++) {
+		ret = do_test(i, with_pmu, TEST_ENCODING_NAME);
+		if (ret != TEST_OK)
+			break;
+
+		if (with_pmu) {
+			ret = do_test(i, with_pmu, TEST_ENCODING_ALIAS_PMU);
+			if (ret != TEST_OK)
+				break;
+
+			ret = do_test(i, with_pmu, TEST_ENCODING_EVENT_TERM);
+			if (ret != TEST_OK)
+				break;
+
+			ret = do_test(i, with_pmu, TEST_ENCODING_RAW_CONFIG);
+			if (ret != TEST_OK)
+				break;
+
+			ret = do_test(i, with_pmu, TEST_ENCODING_WITH_NAME_QUALIFIER);
+			if (ret != TEST_OK)
+				break;
+		}
+	}
+
+	list_del(&pmu->list);
+	perf_pmu__delete(pmu);
+	return ret;
+}
+
+static int test__nvme_pmu_invalid_terms(struct test_suite *test __maybe_unused,
+					int subtest __maybe_unused)
+{
+	static const char * const invalid_events[] = {
+		"nvme_a_test_nvme_pmu/nonexistent_event/",
+		"nvme_a_test_nvme_pmu/call-graph=fp/",
+		"nvme_a_test_nvme_pmu/config=0xffffffff/",
+		"nvme_a_test_nvme_pmu/name=only_name/",
+		"nvme_a_test_nvme_pmu/smart_temperature,error_count/",
+		"nvme_a_test_nvme_pmu/smart_temperature=2/",
+	};
+	struct perf_pmu *pmu = perf_pmus__add_test_nvme_pmu("nvme1234", "a_test_nvme_pmu");
+	int ret = TEST_OK;
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(invalid_events); i++) {
+		struct evlist *evlist = evlist__new();
+		struct parse_events_error err;
+		int parse_ret;
+
+		if (!evlist) {
+			ret = TEST_FAIL;
+			break;
+		}
+		parse_events_error__init(&err);
+		parse_ret = parse_events(evlist, invalid_events[i], &err);
+		if (parse_ret == 0 || list_empty(&err.list)) {
+			pr_debug("FAILED %s:%d Unexpected parse result %d for invalid event '%s'\n",
+				 __FILE__, __LINE__, parse_ret, invalid_events[i]);
+			parse_events_error__exit(&err);
+			evlist__put(evlist);
+			ret = TEST_FAIL;
+			break;
+		}
+		parse_events_error__exit(&err);
+		evlist__put(evlist);
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
+	TEST_CASE("Rejecting invalid event terms", nvme_pmu_invalid_terms),
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
index af822885890d..5a77bc5ecf7a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -133,6 +133,7 @@ DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
 DECLARE_SUITE(hwmon_pmu);
+DECLARE_SUITE(nvme_pmu);
 DECLARE_SUITE(tool_pmu);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 980035b640dc..66626ce3494b 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -925,6 +925,11 @@ struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
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
2.56.1.703.gf848ed807c-goog


