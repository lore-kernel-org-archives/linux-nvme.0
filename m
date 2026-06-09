Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570D7CD98C7
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ytn1WWPrihAOoQGWIOrnsmenC+y6F/7E4AZqpUX1Mk=; b=3ZUi7shGldLEm8CmYLd1QJHOiV
	yIBj1bVjws8a0PQjJLICgMYxKO/AWfaQqeuuf2x6qup466U5F9QKatGHULGrWjBwHqsm8/XtUncJn
	U/eq0uyA/GmYz7DywpSE2sxXCLKn2DjQ3xv+4i8nxp0tLEMeWoA0/GbnCZ50gQGT+/uXaj9iJkIrC
	ljayTBlRFg67o8qS2yP2TN5oFog4MQ6YKvHwRRZyb4c35hsH/mcwKEU9rIkauKfGLrs8SlGXkp29G
	UASA6r3Zn+MoP12yjhwBrnh65CKuNdP1NLrbEW8Nh3tfulQUeMlkNqP5wdCpYPbm4n19xHs/ouWl5
	HZw2i6hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzll-000000065y3-01B0;
	Tue, 09 Jun 2026 16:57:41 +0000
Received: from mail-dy1-x1349.google.com ([2607:f8b0:4864:20::1349])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzli-000000065wK-0Ry0
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 16:57:39 +0000
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-304f1820babso7200192eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781024257; x=1781629057; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ytn1WWPrihAOoQGWIOrnsmenC+y6F/7E4AZqpUX1Mk=;
        b=qwBPX9fZt8S9VQyfsF0J1jq8jlRmWfM7ByGpDy3ygluYG+u2ixghrM+lfhYJIwUcv9
         qQTdwwFm1KROkMU9ZIP+eUHsEyDE4GBUYH3L9046zV5JwdTKZVNeTLkzTHLyIHsYzO0O
         dRs3oWgZnPIzAtitz0lksvQkjvVLmBR6B2yZuQ7RZB2hEPJjTJEN7iEwE1LYFqmbrkwi
         VIeYQO/5YmwEZ0vIDM3dvWCNKPk9GEOBMuk1AkDKb+CUV2GS/Dt/FDKa3WQs5NtyPFFh
         9ys1ExdQ4e0J7SyxU/KiaoXQpN//U513fFw74uMsSVgZ1AECahi8HwD8W1ASW8t8fgO5
         5vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024257; x=1781629057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ytn1WWPrihAOoQGWIOrnsmenC+y6F/7E4AZqpUX1Mk=;
        b=jFyMxuocNFKoxQsmpE4Wri8W+FlhL3MDU6G/C1YbsFbzTBfcZ7ELuZ3ADj/TsVJHNm
         swcMwHIFAxYOzZ5RFF1bC0lKtMielwZ93MfoOA+tHsqLdzFeLC7baa2TJJX4K9A6rnWS
         wbpMnpnPrgj7GWQ62wxCP9Zf5IP7G5xmie6Dob4RwrRJNRnJ+SRZfquwnb7Xy8UX3Pka
         svlNIwpflaJzS5qhAeW86miZhuJ0G6UTqlZZcpdzFCHPRXJQxjFla6gQoYTXjVR9/vHi
         u/k2+5Ft5m76VULwM4qArKPQXtTU3ZYog2WX7YEYlOwVTku84exodL99z5i5gGGfZMSq
         MB9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/SKMmqaQphQVfu4Yfx30QeS1r9NmqabySpgc43QkE+ZGiKf3zmxC2+Xa0SHBdxqO8lcgbSpyDGXW8j@lists.infradead.org
X-Gm-Message-State: AOJu0YxcatWdoiZ9IoEYbIqEcNJPXgaGxP2irITGQv3aIpxuGsEc2mO8
	QjfQ3dZHxIP4atAydPBETuLRGWi2BIlVKFkZplLooSvCVz/Y/5mF+UhTn5/JOsTH0mRUtf7Jmwi
	Z2M5FCcaxPA==
X-Received: from dycns11.prod.google.com ([2002:a05:7300:f78b:b0:2f6:ff42:df28])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:20c5:20b0:307:287f:9bbc
 with SMTP id 5a478bee46e88-3077b7509d0mr6348279eec.25.1781024256499; Tue, 09
 Jun 2026 09:57:36 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:57:25 -0700
In-Reply-To: <20260609165726.786694-1-irogers@google.com>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com> <20260609165726.786694-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609165726.786694-3-irogers@google.com>
Subject: [PATCH v2 2/3] perf pmu: Implement tool-provided NVMe PMU
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
X-CRM114-CacheID: sfid-20260609_095738_183658_34DE62EB 
X-CRM114-Status: GOOD (  28.91  )
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

Add a tool-provided PMU for NVMe devices using libnvme. This PMU
exposes metrics from various NVMe logs (SMART, Endurance Group,
FDP, Error Information, and Zoned Namespaces) as perf events under
the 'nvme_nvmeX' PMUs.

Features:
- Generic configuration encoding (log type, size, and offset mapped
  inside the event config).
- Dynamic probing of supported log pages on /dev/nvmeX. Unsupported
  events are marked deprecated and hidden from 'perf list' by
  default.
- Correct interval delta tracking using baseline offset snapshots on
  evsel->priv.
- Proper conversion and scaling of properties like temperature (K
  to C).

Signed-off-by: Ian Rogers <irogers@google.com>
CONV=ca4c5d09-4ef8-405a-80bb-aa988020b436
TAG=agy
---
 tools/perf/util/Build      |   1 +
 tools/perf/util/evsel.c    |  13 +-
 tools/perf/util/evsel.h    |   4 +
 tools/perf/util/nvme_pmu.c | 564 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/nvme_pmu.h | 112 ++++++++
 tools/perf/util/pmu.c      |  15 +
 tools/perf/util/pmu.h      |   8 +-
 tools/perf/util/pmus.c     |  26 +-
 8 files changed, 736 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/util/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b22cdc24082a..e28e99634178 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -20,6 +20,7 @@ perf-util-y += disasm.o
 perf-util-y += env.o
 perf-util-y += event.o
 perf-util-y += evlist.o
+perf-util-y += nvme_pmu.o
 perf-util-y += sideband_evlist.o
 perf-util-y += evsel.o
 perf-util-y += evsel_fprintf.o
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 34c03f47a913..4148186384a6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -57,6 +57,7 @@
 #include "hashmap.h"
 #include "hist.h"
 #include "hwmon_pmu.h"
+#include "nvme_pmu.h"
 #include "intel-tpebs.h"
 #include "memswap.h"
 #include "off_cpu.h"
@@ -2006,6 +2007,8 @@ void evsel__exit(struct evsel *evsel)
 		xyarray__delete(evsel->process_time.start_times);
 		xyarray__delete(evsel->process_time.accumulated_times);
 	}
+	if (perf_pmu__is_nvme(evsel->pmu))
+		xyarray__delete(evsel->nvme.initial_values);
 }
 
 void evsel__delete(struct evsel *evsel)
@@ -2207,6 +2210,8 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 
 	if (evsel__is_hwmon(evsel))
 		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
+	if (evsel__is_nvme(evsel))
+		return evsel__nvme_pmu_read(evsel, cpu_map_idx, thread);
 
 	if (evsel__is_drm(evsel))
 		return evsel__drm_pmu_read(evsel, cpu_map_idx, thread);
@@ -2947,8 +2952,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	}
 	if (evsel__is_hwmon(evsel)) {
 		err = evsel__hwmon_pmu_open(evsel, threads,
-					    start_cpu_map_idx,
-					    end_cpu_map_idx);
+					    start_cpu_map_idx, end_cpu_map_idx);
+		goto out;
+	}
+	if (evsel__is_nvme(evsel)) {
+		err = evsel__nvme_pmu_open(evsel, threads,
+					   start_cpu_map_idx, end_cpu_map_idx);
 		goto out;
 	}
 	if (evsel__is_drm(evsel)) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8178858d168a..002e045e9015 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -202,6 +202,10 @@ struct evsel {
 			struct xyarray *start_times;
 			struct xyarray *accumulated_times;
 		} process_time;
+		/* For NVMe events */
+		struct {
+			struct xyarray *initial_values;
+		} nvme;
 	};
 	/* Is the tool's fd for /proc/pid/stat or /proc/stat. */
 	bool pid_stat;
diff --git a/tools/perf/util/nvme_pmu.c b/tools/perf/util/nvme_pmu.c
new file mode 100644
index 000000000000..e2391726d76e
--- /dev/null
+++ b/tools/perf/util/nvme_pmu.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "counts.h"
+#include "debug.h"
+#include "evsel.h"
+#include "hashmap.h"
+#include "nvme_pmu.h"
+#include "pmu.h"
+#include <internal/xyarray.h>
+#include <internal/threadmap.h>
+#include <perf/threadmap.h>
+#include <sys/types.h>
+#include <assert.h>
+#include <ctype.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <api/fs/fs.h>
+#include <api/io.h>
+#include <api/io_dir.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <linux/unaligned.h>
+
+#ifdef HAVE_LIBNVME_SUPPORT
+#include <libnvme.h>
+
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
+
+struct nvme_event {
+	const char *name;
+	const char *desc;
+	const char *scale_unit;
+	uint64_t config;
+};
+
+static const struct nvme_event nvme_events[] = {
+	{ "smart_data_units_read",
+	  "Data units read (in 1000s of 512-byte units)",
+	  "512000B", NVME_SMART(16, data_units_read) },
+	{ "smart_data_units_written",
+	  "Data units written (in 1000s of 512-byte units)",
+	  "512000B", NVME_SMART(16, data_units_written) },
+	{ "smart_host_read_commands", "Host read commands", NULL, NVME_SMART(16, host_reads) },
+	{ "smart_host_write_commands", "Host write commands", NULL, NVME_SMART(16, host_writes) },
+	{ "smart_ctrl_busy_time", "Controller busy time", "60s", NVME_SMART(16, ctrl_busy_time) },
+	{ "smart_power_cycles", "Power cycles", NULL, NVME_SMART(16, power_cycles) },
+	{ "smart_power_on_hours", "Power on hours", "1h", NVME_SMART(16, power_on_hours) },
+	{ "smart_unsafe_shutdowns", "Unsafe shutdowns", NULL, NVME_SMART(16, unsafe_shutdowns) },
+	{ "smart_media_errors", "Media errors", NULL, NVME_SMART(16, media_errors) },
+	{ "smart_num_err_log_entries",
+	  "Number of error log entries",
+	  NULL, NVME_SMART(16, num_err_log_entries) },
+	{ "smart_warning_temp_time",
+	  "Warning temperature time",
+	  "60s", NVME_SMART(4, warning_temp_time) },
+	{ "smart_crit_comp_time",
+	  "Critical composite temperature time",
+	  "60s", NVME_SMART(4, critical_comp_time) },
+	{ "smart_temperature", "Temperature", "0.001'C", NVME_SMART(2, temperature) },
+
+	{ "endurance_percent_used",
+	  "Endurance group percentage used",
+	  NULL, NVME_ENDURANCE(1, percent_used) },
+	{ "endurance_data_units_read",
+	  "Endurance group data units read",
+	  "512000B", NVME_ENDURANCE(16, data_units_read) },
+	{ "endurance_data_units_written",
+	  "Endurance group data units written",
+	  "512000B", NVME_ENDURANCE(16, data_units_written) },
+	{ "endurance_media_units_written",
+	  "Endurance group media units written",
+	  "512000B", NVME_ENDURANCE(16, media_units_written) },
+	{ "endurance_host_read_cmds",
+	  "Endurance group host read commands",
+	  NULL, NVME_ENDURANCE(16, host_read_cmds) },
+	{ "endurance_host_write_cmds",
+	  "Endurance group host write commands",
+	  NULL, NVME_ENDURANCE(16, host_write_cmds) },
+	{ "endurance_num_err_info_log_entries",
+	  "Endurance group number of error information log entries",
+	  NULL, NVME_ENDURANCE(16, num_err_info_log_entries) },
+
+	{ "fdp_hbmw", "FDP host bytes with metadata written", "1B", NVME_FDP(16, hbmw) },
+	{ "fdp_mbmw", "FDP media bytes with metadata written", "1B", NVME_FDP(16, mbmw) },
+	{ "fdp_mbe", "FDP media bytes erased", "1B", NVME_FDP(16, mbe) },
+
+	{ "error_count", "Error info log error count", NULL, NVME_ERROR(8, error_count) },
+
+	{ "zns_nrzid", "ZNS changed zone nrzid", NULL, NVME_ZNS(2, nrzid) },
+};
+
+
+struct nvme_pmu {
+	struct perf_pmu pmu;
+	char *dev_name;
+	bool support_checked;
+	bool log_supported[256];
+};
+
+
+bool perf_pmu__is_nvme(const struct perf_pmu *pmu)
+{
+	return pmu && pmu->type >= PERF_PMU_TYPE_NVME_START &&
+		pmu->type <= PERF_PMU_TYPE_NVME_END;
+}
+
+bool evsel__is_nvme(const struct evsel *evsel)
+{
+	return perf_pmu__is_nvme(evsel->pmu);
+}
+
+struct perf_pmu *nvme_pmu__new(struct list_head *pmus, const char *sysfs_name, const char *name)
+{
+	struct nvme_pmu *nvm;
+	char buf[64];
+	__u32 type;
+
+	/*
+	 * Usually sysfs_name is something like "nvme0".
+	 * We try to extract the number. If parsing fails, we use 0.
+	 */
+	type = PERF_PMU_TYPE_NVME_START + strtoul(sysfs_name + 4, NULL, 10);
+
+	if (type > PERF_PMU_TYPE_NVME_END) {
+		pr_err("Unable to encode NVMe type from %s in valid PMU type\n", sysfs_name);
+		return NULL;
+	}
+
+	snprintf(buf, sizeof(buf), "nvme_%s", name);
+
+	nvm = zalloc(sizeof(*nvm));
+	if (!nvm)
+		return NULL;
+
+	if (perf_pmu__init(&nvm->pmu, type, buf) != 0) {
+		free(nvm);
+		return NULL;
+	}
+
+	nvm->dev_name = strdup(sysfs_name);
+	if (!nvm->dev_name) {
+		perf_pmu__delete(&nvm->pmu);
+		return NULL;
+	}
+	nvm->pmu.alias_name = strdup(sysfs_name);
+	if (!nvm->pmu.alias_name) {
+		perf_pmu__delete(&nvm->pmu);
+		return NULL;
+	}
+	nvm->pmu.cpus = perf_cpu_map__new_int(0);
+	if (!nvm->pmu.cpus) {
+		perf_pmu__delete(&nvm->pmu);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&nvm->pmu.format);
+	INIT_LIST_HEAD(&nvm->pmu.caps);
+
+	list_add_tail(&nvm->pmu.list, pmus);
+	return &nvm->pmu;
+}
+
+void nvme_pmu__exit(struct perf_pmu *pmu)
+{
+	struct nvme_pmu *nvm = container_of(pmu, struct nvme_pmu, pmu);
+
+	zfree(&nvm->dev_name);
+}
+
+
+
+static void nvme_pmu__check_support(struct nvme_pmu *nvm)
+{
+	int fd;
+	char path[PATH_MAX];
+	struct nvme_smart_log smart_log;
+	struct nvme_endurance_group_log endurance_log;
+	struct nvme_fdp_stats_log fdp_log;
+	struct nvme_error_log_page error_log;
+	struct nvme_zns_changed_zone_log zns_log;
+
+	if (nvm->support_checked)
+		return;
+
+	nvm->support_checked = true;
+
+	/* Assume all supported if we can't test. */
+	memset(nvm->log_supported, 1, sizeof(nvm->log_supported));
+
+	snprintf(path, sizeof(path), "/dev/%s", nvm->dev_name);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return;
+
+	if (nvme_get_log_smart(fd, NVME_NSID_ALL, true, &smart_log) != 0)
+		nvm->log_supported[NVME_LOG_SMART] = false;
+
+	if (nvme_get_log_endurance_group(fd, 0, &endurance_log) != 0)
+		nvm->log_supported[NVME_LOG_ENDURANCE] = false;
+
+	if (nvme_get_log_fdp_stats(fd, 0, 0, sizeof(fdp_log), &fdp_log) != 0)
+		nvm->log_supported[NVME_LOG_FDP] = false;
+
+	if (nvme_get_log_error(fd, 1, true, &error_log) != 0)
+		nvm->log_supported[NVME_LOG_ERROR] = false;
+
+	if (nvme_get_log_zns_changed_zones(fd, NVME_NSID_ALL, true, &zns_log) != 0)
+		nvm->log_supported[NVME_LOG_ZNS] = false;
+
+	close(fd);
+}
+
+int nvme_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+{
+	struct nvme_pmu *nvm = container_of(pmu, struct nvme_pmu, pmu);
+	size_t i;
+
+	nvme_pmu__check_support(nvm);
+	for (i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+		const struct nvme_event *e = &nvme_events[i];
+		char alias_buf[64];
+		char desc_buf[256];
+		char encoding_buf[128];
+		struct pmu_event_info info = {
+			.pmu = pmu,
+			.name = e->name,
+			.alias = alias_buf,
+			.scale_unit = e->scale_unit,
+			.desc = desc_buf,
+			.long_desc = NULL,
+			.encoding_desc = encoding_buf,
+
+			.topic = "nvme",
+			.pmu_name = pmu->name,
+			.event_type_desc = "NVMe event",
+			.deprecated = !nvm->log_supported[(e->config >> 24) & 0xFF],
+		};
+
+		int ret;
+
+		snprintf(alias_buf, sizeof(alias_buf), "%s", e->name);
+		snprintf(desc_buf, sizeof(desc_buf), "%s", e->desc);
+		snprintf(encoding_buf, sizeof(encoding_buf),
+			 "%s/config=0x%lx/", pmu->name, e->config);
+
+		ret = cb(state, &info);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+size_t nvme_pmu__num_events(struct perf_pmu *pmu __maybe_unused)
+{
+	return ARRAY_SIZE(nvme_events);
+}
+
+bool nvme_pmu__have_event(struct perf_pmu *pmu __maybe_unused, const char *name)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+		if (!strcasecmp(name, nvme_events[i].name))
+			return true;
+	}
+	return false;
+}
+
+static int nvme_pmu__config_term(const struct nvme_pmu *nvm __maybe_unused,
+				 struct perf_event_attr *attr,
+				 struct parse_events_term *term,
+				 struct parse_events_error *err)
+{
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
+		size_t i;
+
+		for (i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+			if (!strcasecmp(term->config, nvme_events[i].name)) {
+				attr->config = nvme_events[i].config;
+				return 0;
+			}
+		}
+	}
+	if (err) {
+		char *err_str;
+
+		parse_events_error__handle(err, term->err_val,
+					asprintf(&err_str,
+						"unexpected nvme event term (%s) %s",
+						parse_events__term_type_str(term->type_term),
+						term->config) < 0
+					? strdup("unexpected nvme event term")
+					: err_str,
+					NULL);
+	}
+	return -EINVAL;
+}
+
+int nvme_pmu__config_terms(const struct perf_pmu *pmu,
+			   struct perf_event_attr *attr,
+			   struct parse_events_terms *terms,
+			   struct parse_events_error *err)
+{
+	struct nvme_pmu *nvm = container_of(pmu, struct nvme_pmu, pmu);
+	struct parse_events_term *term;
+
+	list_for_each_entry(term, &terms->terms, list) {
+		if (nvme_pmu__config_term(nvm, attr, term, err))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+int nvme_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
+			  struct parse_events_error *err)
+{
+	struct parse_events_term *term =
+		list_first_entry(&terms->terms, struct parse_events_term, list);
+
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
+		size_t i;
+
+		for (i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+			if (!strcasecmp(term->config, nvme_events[i].name)) {
+				if (nvme_events[i].scale_unit) {
+					char *unit;
+
+					perf_pmu__convert_scale(nvme_events[i].scale_unit,
+								&unit, &info->scale);
+					info->unit = unit;
+				}
+				return 0;
+			}
+		}
+	}
+	if (err) {
+		char *err_str;
+
+		parse_events_error__handle(err, term->err_val,
+					asprintf(&err_str,
+						"unexpected nvme event term (%s) %s",
+						parse_events__term_type_str(term->type_term),
+						term->config) < 0
+					? strdup("unexpected nvme event term")
+					: err_str,
+					NULL);
+	}
+	return -EINVAL;
+}
+
+int perf_pmus__read_nvme_pmus(struct list_head *pmus)
+{
+	nvme_root_t r = nvme_scan(NULL);
+	nvme_host_t h;
+	nvme_subsystem_t s;
+	nvme_ctrl_t c;
+
+	if (!r)
+		return 0;
+
+	nvme_for_each_host(r, h) {
+		nvme_for_each_subsystem(h, s) {
+			nvme_subsystem_for_each_ctrl(s, c) {
+				nvme_pmu__new(pmus, nvme_ctrl_get_name(c), nvme_ctrl_get_name(c));
+			}
+		}
+	}
+	nvme_free_tree(r);
+	return 0;
+}
+
+
+static int nvme_pmu__read_val(int fd, uint64_t config, uint64_t *val)
+{
+	int log_type = (config >> 24) & 0xFF;
+	unsigned int size = (config >> 16) & 0xFF;
+	unsigned int offset = config & 0xFFFF;
+	uint8_t buf[4096];
+	uint8_t *p;
+
+	if (log_type == NVME_LOG_SMART) {
+		if (offset + size > sizeof(struct nvme_smart_log))
+			return -EINVAL;
+		if (nvme_get_log_smart(fd, NVME_NSID_ALL, true, (struct nvme_smart_log *)buf) != 0)
+			return -EINVAL;
+
+		if (offset == offsetof(struct nvme_smart_log, temperature)) {
+			uint64_t kelvin = ((struct nvme_smart_log *)buf)->temperature[0] |
+					  (((struct nvme_smart_log *)buf)->temperature[1] << 8);
+			*val = (kelvin * 1000) - 273150;
+			return 0;
+		}
+	} else if (log_type == NVME_LOG_ENDURANCE) {
+		if (offset + size > sizeof(struct nvme_endurance_group_log))
+			return -EINVAL;
+		if (nvme_get_log_endurance_group(fd, 0,
+				(struct nvme_endurance_group_log *)buf) != 0)
+			return -EINVAL;
+	} else if (log_type == NVME_LOG_FDP) {
+		if (offset + size > sizeof(struct nvme_fdp_stats_log))
+			return -EINVAL;
+		if (nvme_get_log_fdp_stats(fd, 0, 0, sizeof(struct nvme_fdp_stats_log), buf) != 0)
+			return -EINVAL;
+	} else if (log_type == NVME_LOG_ERROR) {
+		if (offset + size > sizeof(struct nvme_error_log_page))
+			return -EINVAL;
+		if (nvme_get_log_error(fd, 1, true, (struct nvme_error_log_page *)buf) != 0)
+			return -EINVAL;
+	} else if (log_type == NVME_LOG_ZNS) {
+		if (offset + size > sizeof(struct nvme_zns_changed_zone_log))
+			return -EINVAL;
+		if (nvme_get_log_zns_changed_zones(fd, NVME_NSID_ALL, true,
+				(struct nvme_zns_changed_zone_log *)buf) != 0)
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
+	p = buf + offset;
+	if (size == 16 || size == 8)
+		*val = get_unaligned_le64(p);
+	else if (size == 4)
+		*val = get_unaligned_le32(p);
+	else if (size == 2)
+		*val = get_unaligned_le16(p);
+	else if (size == 1)
+		*val = *p;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool nvme_pmu__is_gauge(uint64_t config)
+{
+	if (config == NVME_SMART(2, temperature) ||
+	    config == NVME_ENDURANCE(1, percent_used) ||
+	    config == NVME_ZNS(2, nrzid))
+		return true;
+	return false;
+}
+
+#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
+
+int evsel__nvme_pmu_open(struct evsel *evsel,
+			 struct perf_thread_map *threads,
+			 int start_cpu_map_idx, int end_cpu_map_idx)
+{
+	struct nvme_pmu *nvm = container_of(evsel->pmu, struct nvme_pmu, pmu);
+	int idx = 0, thread = 0, nthreads, err = 0;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "/dev/%s", nvm->dev_name);
+
+	nthreads = perf_thread_map__nr(threads);
+
+	if (!evsel->nvme.initial_values) {
+		int max_cpus = evsel->core.cpus ? perf_cpu_map__nr(evsel->core.cpus) : 1;
+
+		evsel->nvme.initial_values = xyarray__new(max_cpus, nthreads, sizeof(uint64_t));
+	}
+
+	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
+		for (thread = 0; thread < nthreads; thread++) {
+			int fd = open(path, O_RDONLY);
+
+			FD(evsel, idx, thread) = fd;
+			if (fd < 0) {
+				err = -errno;
+				goto out_close;
+			}
+			if (evsel->nvme.initial_values) {
+				uint64_t *initial_val =
+					xyarray__entry(evsel->nvme.initial_values, idx, thread);
+
+				if (nvme_pmu__read_val(fd, evsel->core.attr.config, initial_val))
+					*initial_val = 0;
+			}
+		}
+	}
+	return 0;
+out_close:
+	if (err)
+		threads->err_thread = thread;
+
+	do {
+		while (--thread >= 0) {
+			if (FD(evsel, idx, thread) >= 0)
+				close(FD(evsel, idx, thread));
+			FD(evsel, idx, thread) = -1;
+		}
+		thread = nthreads;
+	} while (--idx >= 0);
+	return err;
+}
+
+int evsel__nvme_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	int fd;
+	struct perf_counts_values *count, *old_count = NULL;
+	uint64_t val = 0;
+	uint64_t *initial_val = NULL;
+
+	if (evsel->prev_raw_counts)
+		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
+
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+	fd = FD(evsel, cpu_map_idx, thread);
+
+	if (fd < 0 || nvme_pmu__read_val(fd, evsel->core.attr.config, &val)) {
+		count->lost++;
+		return -EINVAL;
+	}
+
+	if (evsel->nvme.initial_values)
+		initial_val = xyarray__entry(evsel->nvme.initial_values, cpu_map_idx, thread);
+
+	if (old_count) {
+		if (nvme_pmu__is_gauge(evsel->core.attr.config))
+			count->val = old_count->val + val;
+		else
+			count->val = val - (initial_val ? *initial_val : 0);
+		count->run = old_count->run + 1;
+		count->ena = old_count->ena + 1;
+	} else {
+		if (nvme_pmu__is_gauge(evsel->core.attr.config))
+			count->val = val;
+		else
+			count->val = val - (initial_val ? *initial_val : 0);
+		count->run++;
+		count->ena++;
+	}
+	return 0;
+}
+
+
+#endif
diff --git a/tools/perf/util/nvme_pmu.h b/tools/perf/util/nvme_pmu.h
new file mode 100644
index 000000000000..6d5d2bbe4167
--- /dev/null
+++ b/tools/perf/util/nvme_pmu.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __NVME_PMU_H
+#define __NVME_PMU_H
+
+#include "pmu.h"
+#include <stdbool.h>
+#include <errno.h>
+
+struct list_head;
+struct perf_thread_map;
+struct evsel;
+
+#ifdef HAVE_LIBNVME_SUPPORT
+struct perf_pmu *nvme_pmu__new(struct list_head *pmus, const char *sysfs_name, const char *name);
+void nvme_pmu__exit(struct perf_pmu *pmu);
+
+int nvme_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+size_t nvme_pmu__num_events(struct perf_pmu *pmu);
+bool nvme_pmu__have_event(struct perf_pmu *pmu, const char *name);
+int nvme_pmu__config_terms(const struct perf_pmu *pmu,
+			   struct perf_event_attr *attr,
+			   struct parse_events_terms *terms,
+			   struct parse_events_error *err);
+int nvme_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
+			  struct parse_events_error *err);
+
+bool perf_pmu__is_nvme(const struct perf_pmu *pmu);
+bool evsel__is_nvme(const struct evsel *evsel);
+
+int perf_pmus__read_nvme_pmus(struct list_head *pmus);
+
+int evsel__nvme_pmu_open(struct evsel *evsel,
+			 struct perf_thread_map *threads,
+			 int start_cpu_map_idx, int end_cpu_map_idx);
+int evsel__nvme_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
+#else
+static inline struct perf_pmu *nvme_pmu__new(struct list_head *pmus __maybe_unused,
+					     const char *sysfs_name __maybe_unused,
+					     const char *name __maybe_unused)
+{
+	return NULL;
+}
+
+static inline void nvme_pmu__exit(struct perf_pmu *pmu __maybe_unused)
+{
+}
+
+static inline int nvme_pmu__for_each_event(struct perf_pmu *pmu __maybe_unused,
+					   void *state __maybe_unused,
+					   pmu_event_callback cb __maybe_unused)
+{
+	return 0;
+}
+
+static inline size_t nvme_pmu__num_events(struct perf_pmu *pmu __maybe_unused)
+{
+	return 0;
+}
+
+static inline bool nvme_pmu__have_event(struct perf_pmu *pmu __maybe_unused,
+					const char *name __maybe_unused)
+{
+	return false;
+}
+
+static inline int nvme_pmu__config_terms(const struct perf_pmu *pmu __maybe_unused,
+					 struct perf_event_attr *attr __maybe_unused,
+					 struct parse_events_terms *terms __maybe_unused,
+					 struct parse_events_error *err __maybe_unused)
+{
+	return -EINVAL;
+}
+
+static inline int nvme_pmu__check_alias(struct parse_events_terms *terms __maybe_unused,
+					struct perf_pmu_info *info __maybe_unused,
+					struct parse_events_error *err __maybe_unused)
+{
+	return -EINVAL;
+}
+
+static inline bool perf_pmu__is_nvme(const struct perf_pmu *pmu __maybe_unused)
+{
+	return false;
+}
+
+static inline bool evsel__is_nvme(const struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
+static inline int perf_pmus__read_nvme_pmus(struct list_head *pmus __maybe_unused)
+{
+	return 0;
+}
+
+static inline int evsel__nvme_pmu_open(struct evsel *evsel __maybe_unused,
+				       struct perf_thread_map *threads __maybe_unused,
+				       int start_cpu_map_idx __maybe_unused,
+				       int end_cpu_map_idx __maybe_unused)
+{
+	return 0;
+}
+
+static inline int evsel__nvme_pmu_read(struct evsel *evsel __maybe_unused,
+				       int cpu_map_idx __maybe_unused,
+				       int thread __maybe_unused)
+{
+	return 0;
+}
+#endif
+
+#endif /* __NVME_PMU_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9994709ef12b..26ec19753644 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -22,6 +22,7 @@
 #include "pmu.h"
 #include "drm_pmu.h"
 #include "hwmon_pmu.h"
+#include "nvme_pmu.h"
 #include "pmus.h"
 #include "tool_pmu.h"
 #include "tp_pmu.h"
@@ -1687,6 +1688,8 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
 
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__config_terms(pmu, attr, terms, err);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__config_terms(pmu, attr, terms, err);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__config_terms(pmu, attr, terms, err);
 
@@ -1851,6 +1854,10 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		ret = hwmon_pmu__check_alias(head_terms, info, err);
 		goto out;
 	}
+	if (perf_pmu__is_nvme(pmu)) {
+		ret = nvme_pmu__check_alias(head_terms, info, err);
+		goto out;
+	}
 	if (perf_pmu__is_drm(pmu)) {
 		ret = drm_pmu__check_alias(pmu, head_terms, info, err);
 		goto out;
@@ -2071,6 +2078,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return tp_pmu__have_event(pmu, name);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__have_event(pmu, name);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__have_event(pmu, name);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__have_event(pmu, name);
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
@@ -2092,6 +2101,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 		return tp_pmu__num_events(pmu);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__num_events(pmu);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__num_events(pmu);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__num_events(pmu);
 
@@ -2223,6 +2234,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		return tp_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__for_each_event(pmu, state, cb);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__for_each_event(pmu, state, cb);
 
@@ -2714,6 +2727,8 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 
 	if (perf_pmu__is_hwmon(pmu))
 		hwmon_pmu__exit(pmu);
+	if (perf_pmu__is_nvme(pmu))
+		nvme_pmu__exit(pmu);
 	else if (perf_pmu__is_drm(pmu))
 		drm_pmu__exit(pmu);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 0d9f3c57e8e8..0fe47dd429e8 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -45,6 +45,8 @@ enum pmu_kind {
 	PERF_PMU_KIND_DRM,
 	/* A perf tool provided HWMON PMU. */
 	PERF_PMU_KIND_HWMON,
+	/* A perf tool provided NVME PMU. */
+	PERF_PMU_KIND_NVME,
 	/* Perf tool provided PMU for tool events like time. */
 	PERF_PMU_KIND_TOOL,
 	/* A testing PMU kind. */
@@ -53,7 +55,9 @@ enum pmu_kind {
 
 enum {
 	PERF_PMU_TYPE_PE_START    = 0,
-	PERF_PMU_TYPE_PE_END      = 0xFFFDFFFF,
+	PERF_PMU_TYPE_PE_END      = 0xFFFCFFFF,
+	PERF_PMU_TYPE_NVME_START  = 0xFFFD0000,
+	PERF_PMU_TYPE_NVME_END    = 0xFFFDFFFF,
 	PERF_PMU_TYPE_DRM_START   = 0xFFFE0000,
 	PERF_PMU_TYPE_DRM_END     = 0xFFFEFFFF,
 	PERF_PMU_TYPE_HWMON_START = 0xFFFF0000,
@@ -363,6 +367,8 @@ static inline enum pmu_kind perf_pmu__kind(const struct perf_pmu *pmu)
 	type = pmu->type;
 	if (type <= PERF_PMU_TYPE_PE_END)
 		return PERF_PMU_KIND_PE;
+	if (type <= PERF_PMU_TYPE_NVME_END)
+		return PERF_PMU_KIND_NVME;
 	if (type <= PERF_PMU_TYPE_DRM_END)
 		return PERF_PMU_KIND_DRM;
 	if (type <= PERF_PMU_TYPE_HWMON_END)
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 5e3f571450fe..83777f941e9a 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -17,6 +17,7 @@
 #include "pmus.h"
 #include "pmu.h"
 #include "hwmon_pmu.h"
+#include "nvme_pmu.h"
 #include "tool_pmu.h"
 #include "print-events.h"
 #include "strbuf.h"
@@ -44,18 +45,21 @@ enum perf_tool_pmu_type {
 	PERF_TOOL_PMU_TYPE_PE_OTHER,
 	PERF_TOOL_PMU_TYPE_TOOL,
 	PERF_TOOL_PMU_TYPE_HWMON,
+	PERF_TOOL_PMU_TYPE_NVME,
 	PERF_TOOL_PMU_TYPE_DRM,
 
 #define PERF_TOOL_PMU_TYPE_PE_CORE_MASK (1 << PERF_TOOL_PMU_TYPE_PE_CORE)
 #define PERF_TOOL_PMU_TYPE_PE_OTHER_MASK (1 << PERF_TOOL_PMU_TYPE_PE_OTHER)
 #define PERF_TOOL_PMU_TYPE_TOOL_MASK (1 << PERF_TOOL_PMU_TYPE_TOOL)
 #define PERF_TOOL_PMU_TYPE_HWMON_MASK (1 << PERF_TOOL_PMU_TYPE_HWMON)
+#define PERF_TOOL_PMU_TYPE_NVME_MASK (1 << PERF_TOOL_PMU_TYPE_NVME)
 #define PERF_TOOL_PMU_TYPE_DRM_MASK (1 << PERF_TOOL_PMU_TYPE_DRM)
 
 #define PERF_TOOL_PMU_TYPE_ALL_MASK (PERF_TOOL_PMU_TYPE_PE_CORE_MASK |	\
 					PERF_TOOL_PMU_TYPE_PE_OTHER_MASK | \
 					PERF_TOOL_PMU_TYPE_TOOL_MASK |	\
 					PERF_TOOL_PMU_TYPE_HWMON_MASK | \
+					PERF_TOOL_PMU_TYPE_NVME_MASK | \
 					PERF_TOOL_PMU_TYPE_DRM_MASK)
 };
 static unsigned int read_pmu_types;
@@ -175,12 +179,15 @@ struct perf_pmu *perf_pmus__find(const char *name)
 		return pmu;
 
 	/* Looking up an individual perf event PMU failed, check if a tool PMU should be read. */
-	if (!strncmp(name, "hwmon_", 6))
-		to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
-	else if (!strncmp(name, "drm_", 4))
+	if (!strncmp(name, "hwmon_", 6)) {
+		to_read_pmus = PERF_TOOL_PMU_TYPE_HWMON_MASK;
+	} else if (!strncmp(name, "nvme_", 5)) {
+		to_read_pmus = PERF_TOOL_PMU_TYPE_NVME_MASK;
+	} else if (!strncmp(name, "drm_", 4)) {
 		to_read_pmus |= PERF_TOOL_PMU_TYPE_DRM_MASK;
-	else if (!strcmp(name, "tool"))
+	} else if (!strcmp(name, "tool")) {
 		to_read_pmus |= PERF_TOOL_PMU_TYPE_TOOL_MASK;
+	}
 
 	if (to_read_pmus) {
 		pmu_read_sysfs(to_read_pmus);
@@ -279,6 +286,10 @@ static void pmu_read_sysfs(unsigned int to_read_types)
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)
 		perf_pmus__read_hwmon_pmus(&other_pmus);
 
+	if ((to_read_types & PERF_TOOL_PMU_TYPE_NVME_MASK) != 0 &&
+	    (read_pmu_types & PERF_TOOL_PMU_TYPE_NVME_MASK) == 0)
+		perf_pmus__read_nvme_pmus(&other_pmus);
+
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_DRM_MASK) != 0 &&
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_DRM_MASK) == 0)
 		perf_pmus__read_drm_pmus(&other_pmus);
@@ -387,6 +398,10 @@ struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *eve
 		if (strlen(event) > 4 && strncmp("drm-", event, 4) == 0)
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_DRM_MASK;
 
+		/* Could the event be an nvme event? */
+		if (nvme_pmu__have_event(NULL, event))
+			to_read_pmus |= PERF_TOOL_PMU_TYPE_NVME_MASK;
+
 		pmu_read_sysfs(to_read_pmus);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	}
@@ -424,11 +439,14 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
 		 */
 		if (strisglob(wildcard)) {
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK |
+				PERF_TOOL_PMU_TYPE_NVME_MASK |
 				PERF_TOOL_PMU_TYPE_DRM_MASK;
 		} else if (strlen(wildcard) >= 4 && strncmp("drm_", wildcard, 4) == 0) {
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_DRM_MASK;
 		} else if (strlen(wildcard) >= 5 && strncmp("hwmon", wildcard, 5) == 0) {
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
+		} else if (strlen(wildcard) >= 4 && strncmp("nvme", wildcard, 4) == 0) {
+			to_read_pmus |= PERF_TOOL_PMU_TYPE_NVME_MASK;
 		}
 
 		pmu_read_sysfs(to_read_pmus);
-- 
2.54.0.1099.g489fc7bff1-goog


