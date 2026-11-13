Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37182606A336
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LHLh7bP2;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=grn3wypg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wrqvH3AhF782vONmeH/kzFm9VdJB+763uftNTds/i2g=; b=LHLh7bP2zxkY9gnChFgNITd/9P
	QLN2X0A89QybW/8BcjmswIMdZEkD/7rgsZOMvlXXDWOZDqS5IIDD3b2kYne6yh7wd/op0wKP6Y2cy
	UafgNGi3asWu9PMruYIEGqRIus4neTxW1OZjG9mBKpozE/98Lc2B4O23g2XaJkk4bJt5amOwnf+S9
	YnAaroQMWKgG8lTcAhxyABDBeeS2vAtP0jHLVUtiXEEkGuZQQBOgLEinQQ0mBdTE35wED+eFiqS+Z
	P2IIKqG1fD06pMjJluQesybB+nqE8Lno0aDmylmMtpr43Btd0EPoU7110JiynC4yQmWW3a8npAQtV
	rfI8ne+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwi3-0000000E7fE-1GAD;
	Fri, 13 Nov 2026 19:13:15 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwhx-0000000E7aX-48uL
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 19:13:14 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2ed276af91dso22682355ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 11:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794597187; x=1795201987; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wrqvH3AhF782vONmeH/kzFm9VdJB+763uftNTds/i2g=;
        b=grn3wypguyA3/ituXw3+XomIrgFiYJlF4XAvFD2kobqK8cZQReLyiV/cNjA9GlV1ep
         j88IkNo77lQ+1owYwkoCJ1F32mLrdxYfU0Qhm4mCgx7IOOvyXI1H+2gZuQfTRRikSaEA
         MVvlcCmoWKrsrdRXXjAP4YoyqGZhY3VkCq6zLNlZ8ttKCOKlN9R14cNo8LqG9LnBU4go
         WEY/i/2BYvx/In2xe6+MBTlsrRVa5njySJwZchdlR1RtmZwDuxJh0kzqAl0kVS9gV00G
         8nK7T60wcHCQl16tCYW1tNE41CI3prGO9ipSrl8qjrZYS02osEYKJNmRMct/x7HYpb7h
         ThZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597187; x=1795201987;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wrqvH3AhF782vONmeH/kzFm9VdJB+763uftNTds/i2g=;
        b=VnZqJ7hpNYDRnjS6rUX2HJAeNU4XNAxPGaDS6L7A9rMsr23B2BN7iFAJiYSpOoCBs1
         i83lMoHRxZFn0zNPCx3eqlbhfZpfNvQwbNWQ3VXS14m5iohxe3HjRFk/Gs84uVUnti/e
         uBW0wUwQG3lynBQuP4gZcpSqu7VG5Br2V3paNCqejUrW99KyJafa33TWtMqnpeSdtomO
         4dj1kuuJsjCphpAN3Dm+uot46qibTrA8gNkT2Qd/Wi2yFXHkB9pL38Gs26AKM9ENmc8e
         eZ777BR3y71gLtVWpm9+zP3z23OMuLz/UvjF3au6VUcXhaxsi1UayKGUN9mkCNt2LbOP
         sBVg==
X-Forwarded-Encrypted: i=1; AL+hErGSlyJck4iECeh12ezuqCTTkUx0fxQMXGAmbe44dbTjJtT4wTSrlNOOIUDqJ2oAK1r00HNECsDuLFPD@lists.infradead.org
X-Gm-Message-State: APuU4Z8KhCPUjVD+kkAst584a4iXbJ/Uz1RuZ3W/V/EikUUIZR42c+ys
	EO4MsbDTRFSGgHZMHc9Nli0gkDvVYEofdyUdfsGYVYUs98oi86xX9ubkq6DYMv2rgyMRygeNK5u
	4U5TP35PF3A==
X-Received: from plgl13.prod.google.com ([2002:a17:902:f68d:b0:2eb:4a7:306e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244f:b0:2cc:6018:f030
 with SMTP id d9443c01a7336-2ee0da98749mr37874725ad.14.1794597186553; Fri, 13
 Nov 2026 11:13:06 -0800 (PST)
Date: Fri, 13 Nov 2026 11:12:33 -0800
In-Reply-To: <20261113191234.2509964-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113191234.2509964-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113191234.2509964-3-irogers@google.com>
Subject: [PATCH v3 2/3] perf pmu: Implement tool-provided NVMe PMU
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
X-CRM114-CacheID: sfid-20261113_111310_122835_835A7422 
X-CRM114-Status: GOOD (  27.48  )
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

Add a tool-provided PMU for NVMe controllers using libnvme, similar to
the existing hwmon and drm tool PMUs. Each discovered controller is
exposed as an 'nvme_<ctrl>' PMU (with alias '<ctrl>', e.g. 'nvme_nvme0'
and 'nvme0') providing events from standard NVMe log pages:
- SMART / Health Information (data units read/written, host read/write
  commands, controller busy time, power cycles, power on hours, unsafe
  shutdowns, media errors, error log entries, temperature, warning and
  critical temperature times)
- Endurance Group Information
- Flexible Data Placement (FDP) Statistics (host/media bytes written,
  media bytes erased)
- Error Information
- Zoned Namespaces (ZNS) Changed Zones

Exposing these controller log metrics as a perf tool PMU allows storage
activity, write amplification / FDP efficiency, error counters, and
device thermals to be measured on a unified timeline alongside CPU
hardware counters, block/kernel events, uncore counters, and hwmon
sensors in 'perf stat' (including interval mode '-I', CSV '-x', JSON
'-j', and perf metric formulas), without separate polling scripts. As
with hwmon_pmu and drm_pmu, NVMe controller discovery and log probing
are gated behind PERF_TOOL_PMU_TYPE_NVME_MASK so there is no overhead
unless NVMe events or wildcards are requested.

Features:
- Generic configuration encoding (log type, field size, and byte offset
  packed into attr.config), supporting symbolic event names, 'event='
  terms, and raw 'config=0x...' encodings.
- Dynamic probing of supported log pages on /dev/nvmeX. Unsupported log
  events are marked deprecated and hidden from 'perf list' by default.
- Baseline offset snapshots stored in struct evsel's tool union
  (evsel->nvme.initial_values) so cumulative device counters report
  interval deltas while gauges (temperature, percent_used, zns_nrzid)
  report instantaneous readings.
- Temperature is reported in native Kelvins ('K') matching the NVMe
  SMART log specification, avoiding unsigned counter underflow on
  sub-zero Celsius values while allowing metrics to convert to Celsius.

Example 'perf list' output (when only the SMART log is supported):

 $ perf list nvme

 List of pre-defined events (to be used in -e or -M):

 nvme:
   smart_crit_comp_time
        [Critical composite temperature time. Unit: nvme_nvme0]
   smart_ctrl_busy_time
        [Controller busy time. Unit: nvme_nvme0]
   smart_data_units_read
        [Data units read (in 1000s of 512-byte units). Unit: nvme_nvme0]
   smart_data_units_written
        [Data units written (in 1000s of 512-byte units). Unit: nvme_nvme0]
   smart_host_read_commands
        [Host read commands. Unit: nvme_nvme0]
   smart_host_write_commands
        [Host write commands. Unit: nvme_nvme0]
   smart_media_errors
        [Media errors. Unit: nvme_nvme0]
   smart_num_err_log_entries
        [Number of error log entries. Unit: nvme_nvme0]
   smart_power_cycles
        [Power cycles. Unit: nvme_nvme0]
   smart_power_on_hours
        [Power on hours. Unit: nvme_nvme0]
   smart_temperature
        [Temperature. Unit: nvme_nvme0]
   smart_unsafe_shutdowns
        [Unsafe shutdowns. Unit: nvme_nvme0]
   smart_warning_temp_time
        [Warning temperature time. Unit: nvme_nvme0]

Example 'perf stat' interval output (captured with mocked libnvme SMART
log responses on /dev/nvme0):

 $ perf stat -a -I 500 -e smart_temperature,smart_data_units_read,\
   smart_data_units_written,smart_host_read_commands,\
   smart_host_write_commands -- sleep 1
 #           time             counts unit events
      0.500432960                311 K    smart_temperature
      0.500432960         36,864,000 B    smart_data_units_read
      0.500432960         12,288,000 B    smart_data_units_written
      0.500432960                900      smart_host_read_commands
      0.500432960                270      smart_host_write_commands
      1.001068028                311 K    smart_temperature
      1.001068028         36,864,000 B    smart_data_units_read
      1.001068028         12,288,000 B    smart_data_units_written
      1.001068028                900      smart_host_read_commands
      1.001068028                270      smart_host_write_commands

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt |  10 +-
 tools/perf/util/Build                  |   1 +
 tools/perf/util/evsel.c                |  13 +-
 tools/perf/util/evsel.h                |   4 +
 tools/perf/util/nvme_pmu.c             | 691 +++++++++++++++++++++++++
 tools/perf/util/nvme_pmu.h             | 144 ++++++
 tools/perf/util/pmu.c                  |  17 +
 tools/perf/util/pmu.h                  |   8 +-
 tools/perf/util/pmus.c                 |  19 +
 9 files changed, 902 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/util/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.h

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 17e582998474..520e08a6efc9 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -254,8 +254,8 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
-TOOL/HWMON EVENTS
------------------
+TOOL/HWMON/NVME EVENTS
+----------------------
 
 Some events don't have an associated PMU instead reading values
 available to software without perf_event_open. As these events don't
@@ -268,6 +268,12 @@ Hwmon events provide easy access to hwmon sysfs data typically in
 /sys/class/hwmon. This information includes temperatures, fan speeds
 and energy usage.
 
+NVMe events (when built with libnvme) expose controller log page
+metrics for /dev/nvmeX devices under nvme_nvmeX PMUs. This includes
+SMART health counters and temperature (in Kelvin), endurance group
+counters, Flexible Data Placement (FDP) statistics, error counts and
+Zoned Namespace (ZNS) changed zones.
+
 
 TRACING
 -------
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c1f880c4c47..d7740aa06249 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -23,6 +23,7 @@ perf-util-y += disasm.o
 perf-util-y += env.o
 perf-util-y += event.o
 perf-util-y += evlist.o
+perf-util-y += nvme_pmu.o
 perf-util-y += sideband_evlist.o
 perf-util-y += evsel.o
 perf-util-y += evsel_fprintf.o
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d69f63b7fb1..9c98478692dc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -63,6 +63,7 @@
 #include "hashmap.h"
 #include "hist.h"
 #include "hwmon_pmu.h"
+#include "nvme_pmu.h"
 #include "intel-tpebs.h"
 #include "memswap.h"
 #include "off_cpu.h"
@@ -2104,6 +2105,8 @@ static void evsel__exit(struct evsel *evsel)
 		xyarray__delete(evsel->process_time.start_times);
 		xyarray__delete(evsel->process_time.accumulated_times);
 	}
+	if (evsel__is_nvme(evsel))
+		xyarray__delete(evsel->nvme.initial_values);
 }
 
 void evsel__put(struct evsel *evsel)
@@ -2308,6 +2311,8 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 
 	if (evsel__is_hwmon(evsel))
 		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
+	if (evsel__is_nvme(evsel))
+		return evsel__nvme_pmu_read(evsel, cpu_map_idx, thread);
 
 	if (evsel__is_drm(evsel))
 		return evsel__drm_pmu_read(evsel, cpu_map_idx, thread);
@@ -3067,8 +3072,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
index 53f3641b66e1..b30b5b6251af 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -208,6 +208,10 @@ struct evsel {
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
index 000000000000..3ee967505dec
--- /dev/null
+++ b/tools/perf/util/nvme_pmu.c
@@ -0,0 +1,691 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "counts.h"
+#include "debug.h"
+#include "evsel.h"
+#include "nvme_pmu.h"
+#include "pmu.h"
+#include <internal/xyarray.h>
+#include <internal/threadmap.h>
+#include <perf/threadmap.h>
+#include <sys/types.h>
+#include <assert.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <strings.h>
+#include <unistd.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+#include <linux/zalloc.h>
+
+#ifdef HAVE_LIBNVME_SUPPORT
+#include <libnvme.h>
+
+/* Valid NVMe Endurance Group Identifiers start at 1 (0 is reserved). */
+#define NVME_DEFAULT_ENDGID 1
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
+	{ "smart_temperature", "Temperature", "1K", NVME_SMART(2, temperature) },
+
+	{ "endurance_percent_used",
+	  "Endurance group percentage used",
+	  NULL, NVME_ENDURANCE(1, percent_used) },
+	{ "endurance_data_units_read",
+	  "Endurance group data units read (in billions of bytes)",
+	  "1000000000B", NVME_ENDURANCE(16, data_units_read) },
+	{ "endurance_data_units_written",
+	  "Endurance group data units written (in billions of bytes)",
+	  "1000000000B", NVME_ENDURANCE(16, data_units_written) },
+	{ "endurance_media_units_written",
+	  "Endurance group media units written (in billions of bytes)",
+	  "1000000000B", NVME_ENDURANCE(16, media_units_written) },
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
+struct nvme_pmu {
+	struct perf_pmu pmu;
+	char *dev_name;
+	bool support_checked;
+	bool log_supported[256];
+};
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
+	struct perf_pmu *existing;
+	struct nvme_pmu *nvm;
+	char buf[64];
+	unsigned long idx = 0;
+	__u32 type;
+
+	if (!sysfs_name || !name)
+		return NULL;
+
+	/*
+	 * Usually sysfs_name is something like "nvme0".
+	 * Extract the controller index; if parsing fails, use 0.
+	 */
+	if (!strncmp(sysfs_name, "nvme", 4) && isdigit((unsigned char)sysfs_name[4]))
+		idx = strtoul(sysfs_name + 4, NULL, 10);
+
+	if (idx > PERF_PMU_TYPE_NVME_END - PERF_PMU_TYPE_NVME_START) {
+		pr_err("Unable to encode NVMe type from %s in valid PMU type\n", sysfs_name);
+		return NULL;
+	}
+	type = PERF_PMU_TYPE_NVME_START + idx;
+
+	snprintf(buf, sizeof(buf), "nvme_%s", name);
+
+	list_for_each_entry(existing, pmus, list) {
+		if (!strcmp(existing->name, buf) || existing->type == type)
+			return NULL;
+	}
+
+	nvm = zalloc(sizeof(*nvm));
+	if (!nvm)
+		return NULL;
+
+	if (perf_pmu__init(&nvm->pmu, type, buf) != 0) {
+		perf_pmu__delete(&nvm->pmu);
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
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return;
+
+	if (nvme_get_log_smart(fd, NVME_NSID_ALL, true, &smart_log) != 0)
+		nvm->log_supported[NVME_LOG_SMART] = false;
+
+	if (nvme_get_log_endurance_group(fd, NVME_DEFAULT_ENDGID, &endurance_log) != 0)
+		nvm->log_supported[NVME_LOG_ENDURANCE] = false;
+
+	if (nvme_get_log_fdp_stats(fd, NVME_DEFAULT_ENDGID, 0, sizeof(fdp_log), &fdp_log) != 0)
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
+		char encoding_buf[128];
+		struct pmu_event_info info = {
+			.pmu = pmu,
+			.name = e->name,
+			.alias = NULL,
+			.scale_unit = e->scale_unit,
+			.desc = e->desc,
+			.long_desc = NULL,
+			.encoding_desc = encoding_buf,
+			.topic = "nvme",
+			.pmu_name = pmu->name,
+			.event_type_desc = "NVMe event",
+			.deprecated = !nvm->log_supported[(e->config >> 24) & 0xFF],
+		};
+		int ret;
+
+		snprintf(encoding_buf, sizeof(encoding_buf),
+			 "%s/config=0x%" PRIx64 "/", pmu->name, e->config);
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
+static bool nvme_pmu__valid_config(uint64_t config)
+{
+	unsigned int log_type = (config >> 24) & 0xFF;
+	unsigned int size = (config >> 16) & 0xFF;
+	unsigned int offset = config & 0xFFFF;
+	size_t log_size;
+
+	if (config >> 32)
+		return false;
+
+	if (size != 1 && size != 2 && size != 4 && size != 8 && size != 16)
+		return false;
+
+	switch (log_type) {
+	case NVME_LOG_SMART:
+		log_size = sizeof(struct nvme_smart_log);
+		break;
+	case NVME_LOG_ENDURANCE:
+		log_size = sizeof(struct nvme_endurance_group_log);
+		break;
+	case NVME_LOG_FDP:
+		log_size = sizeof(struct nvme_fdp_stats_log);
+		break;
+	case NVME_LOG_ERROR:
+		log_size = sizeof(struct nvme_error_log_page);
+		break;
+	case NVME_LOG_ZNS:
+		log_size = sizeof(struct nvme_zns_changed_zone_log);
+		break;
+	default:
+		return false;
+	}
+
+	return offset + size <= log_size;
+}
+
+static const struct nvme_event *nvme_pmu__find_user_event(const struct parse_events_term *term)
+{
+	const char *event_name = NULL;
+
+	if (term->type_term != PARSE_EVENTS__TERM_TYPE_USER)
+		return NULL;
+
+	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM && term->no_value)
+		event_name = term->config;
+	else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR &&
+		 term->config && !strcasecmp(term->config, "event"))
+		event_name = term->val.str;
+
+	if (!event_name)
+		return NULL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+		if (!strcasecmp(event_name, nvme_events[i].name))
+			return &nvme_events[i];
+	}
+	return NULL;
+}
+
+static const struct nvme_event *nvme_pmu__find_config_event(uint64_t config)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+		if (nvme_events[i].config == config)
+			return &nvme_events[i];
+	}
+	return NULL;
+}
+
+static int nvme_pmu__err_term(struct parse_events_error *err,
+			      const struct parse_events_term *term)
+{
+	if (err) {
+		char *err_str;
+		int idx = term->err_term ?: term->err_val;
+
+		if (term->config) {
+			if (asprintf(&err_str,
+				     "unexpected nvme event term (%s) %s",
+				     parse_events__term_type_str(term->type_term),
+				     term->config) < 0)
+				err_str = strdup("unexpected nvme event term");
+		} else {
+			if (asprintf(&err_str,
+				     "unexpected nvme event term (%s)",
+				     parse_events__term_type_str(term->type_term)) < 0)
+				err_str = strdup("unexpected nvme event term");
+		}
+		parse_events_error__handle(err, idx, err_str, NULL);
+	}
+	return -EINVAL;
+}
+
+static bool nvme_pmu__is_passthrough_term(const struct parse_events_term *term)
+{
+	return term->type_term == PARSE_EVENTS__TERM_TYPE_NAME ||
+	       term->type_term == PARSE_EVENTS__TERM_TYPE_METRIC_ID ||
+	       term->type_term == PARSE_EVENTS__TERM_TYPE_CPU;
+}
+
+int nvme_pmu__config_terms(const struct perf_pmu *pmu __maybe_unused,
+			   struct perf_event_attr *attr,
+			   struct parse_events_terms *terms,
+			   struct parse_events_error *err)
+{
+	struct parse_events_term *term;
+	bool have_event = false;
+
+	list_for_each_entry(term, &terms->terms, list) {
+		const struct nvme_event *e = nvme_pmu__find_user_event(term);
+
+		if (e) {
+			if (have_event)
+				return nvme_pmu__err_term(err, term);
+			attr->config = e->config;
+			have_event = true;
+			continue;
+		}
+		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CONFIG &&
+		    !term->no_value && nvme_pmu__valid_config(term->val.num)) {
+			if (have_event)
+				return nvme_pmu__err_term(err, term);
+			attr->config = term->val.num;
+			have_event = true;
+			continue;
+		}
+		if (nvme_pmu__is_passthrough_term(term))
+			continue;
+
+		return nvme_pmu__err_term(err, term);
+	}
+
+	if (!have_event) {
+		if (err)
+			parse_events_error__handle(err, 0,
+						   strdup("missing nvme event or config term"),
+						   NULL);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int nvme_pmu__set_info_scale(const struct nvme_event *e, struct perf_pmu_info *info)
+{
+	char *unit = NULL;
+
+	if (!e || !e->scale_unit)
+		return 0;
+
+	if (perf_pmu__convert_scale(e->scale_unit, &unit, &info->scale) < 0)
+		return -ENOMEM;
+
+	info->unit = unit;
+	return 0;
+}
+
+int nvme_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
+			  struct parse_events_error *err)
+{
+	struct parse_events_term *term;
+	bool have_event = false;
+
+	list_for_each_entry(term, &terms->terms, list) {
+		const struct nvme_event *e = nvme_pmu__find_user_event(term);
+		int ret;
+
+		if (!e && term->type_term == PARSE_EVENTS__TERM_TYPE_CONFIG &&
+		    !term->no_value && nvme_pmu__valid_config(term->val.num)) {
+			if (have_event)
+				return nvme_pmu__err_term(err, term);
+			have_event = true;
+			e = nvme_pmu__find_config_event(term->val.num);
+			ret = nvme_pmu__set_info_scale(e, info);
+			if (ret)
+				return ret;
+			continue;
+		}
+		if (e) {
+			if (have_event)
+				return nvme_pmu__err_term(err, term);
+			have_event = true;
+			ret = nvme_pmu__set_info_scale(e, info);
+			if (ret)
+				return ret;
+			continue;
+		}
+		if (nvme_pmu__is_passthrough_term(term))
+			continue;
+
+		return nvme_pmu__err_term(err, term);
+	}
+
+	if (!have_event) {
+		if (err)
+			parse_events_error__handle(err, 0,
+						   strdup("missing nvme event or config term"),
+						   NULL);
+		return -EINVAL;
+	}
+	return 0;
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
+				const char *ctrl_name = nvme_ctrl_get_name(c);
+
+				if (ctrl_name)
+					nvme_pmu__new(pmus, ctrl_name, ctrl_name);
+			}
+		}
+	}
+	nvme_free_tree(r);
+	return 0;
+}
+
+static int nvme_pmu__read_val(int fd, uint64_t config, uint64_t *val)
+{
+	unsigned int log_type = (config >> 24) & 0xFF;
+	unsigned int size = (config >> 16) & 0xFF;
+	unsigned int offset = config & 0xFFFF;
+	union {
+		struct nvme_smart_log smart;
+		struct nvme_endurance_group_log endurance;
+		struct nvme_fdp_stats_log fdp;
+		struct nvme_error_log_page error;
+		struct nvme_zns_changed_zone_log zns;
+	} log;
+	const uint8_t *p;
+	int ret;
+
+	if (!nvme_pmu__valid_config(config))
+		return -EINVAL;
+
+	memset(&log, 0, sizeof(log));
+
+	switch (log_type) {
+	case NVME_LOG_SMART:
+		ret = nvme_get_log_smart(fd, NVME_NSID_ALL, true, &log.smart);
+		break;
+	case NVME_LOG_ENDURANCE:
+		ret = nvme_get_log_endurance_group(fd, NVME_DEFAULT_ENDGID, &log.endurance);
+		break;
+	case NVME_LOG_FDP:
+		ret = nvme_get_log_fdp_stats(fd, NVME_DEFAULT_ENDGID, 0,
+					     sizeof(log.fdp), &log.fdp);
+		break;
+	case NVME_LOG_ERROR:
+		ret = nvme_get_log_error(fd, 1, true, &log.error);
+		break;
+	case NVME_LOG_ZNS:
+		ret = nvme_get_log_zns_changed_zones(fd, NVME_NSID_ALL, true, &log.zns);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret < 0)
+		return -errno ?: -EIO;
+	if (ret > 0)
+		return -EOPNOTSUPP;
+
+	/*
+	 * 16-byte NVMe log counters are 128-bit little-endian integers;
+	 * reading the first 8 bytes extracts the lower 64 bits.
+	 */
+	p = (const uint8_t *)&log + offset;
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
+	int idx = start_cpu_map_idx, thread = 0, nthreads, err = 0;
+	int max_cpus, max_threads;
+	char path[PATH_MAX];
+
+	if (evsel->core.attr.sample_period || !evsel->core.fd)
+		return -EINVAL;
+
+	snprintf(path, sizeof(path), "/dev/%s", nvm->dev_name);
+
+	nthreads = perf_thread_map__nr(threads);
+	max_cpus = max(xyarray__max_x(evsel->core.fd), end_cpu_map_idx);
+	max_threads = max(xyarray__max_y(evsel->core.fd), nthreads);
+
+	if (evsel->nvme.initial_values &&
+	    (xyarray__max_x(evsel->nvme.initial_values) < max_cpus ||
+	     xyarray__max_y(evsel->nvme.initial_values) < max_threads)) {
+		xyarray__delete(evsel->nvme.initial_values);
+		evsel->nvme.initial_values = NULL;
+	}
+
+	if (!evsel->nvme.initial_values) {
+		evsel->nvme.initial_values = xyarray__new(max_cpus, max_threads,
+							  sizeof(uint64_t));
+		if (!evsel->nvme.initial_values)
+			return -ENOMEM;
+	}
+
+	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
+		for (thread = 0; thread < nthreads; thread++) {
+			uint64_t *initial_val;
+			int fd = open(path, O_RDONLY | O_CLOEXEC);
+
+			FD(evsel, idx, thread) = fd;
+			if (fd < 0) {
+				err = -errno;
+				goto out_close;
+			}
+			initial_val = xyarray__entry(evsel->nvme.initial_values, idx, thread);
+			err = nvme_pmu__read_val(fd, evsel->core.attr.config, initial_val);
+			if (err) {
+				close(fd);
+				FD(evsel, idx, thread) = -1;
+				goto out_close;
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
+	} while (--idx >= start_cpu_map_idx);
+	return err;
+}
+
+int evsel__nvme_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	int fd, err;
+	struct perf_counts_values *count, *old_count = NULL;
+	uint64_t val = 0, base = 0, delta;
+	uint64_t *initial_val;
+
+	if (evsel->prev_raw_counts)
+		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
+
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+	fd = FD(evsel, cpu_map_idx, thread);
+	if (fd < 0) {
+		count->lost = (old_count ? old_count->lost : count->lost) + 1;
+		return -EINVAL;
+	}
+
+	err = nvme_pmu__read_val(fd, evsel->core.attr.config, &val);
+	if (err) {
+		count->lost = (old_count ? old_count->lost : count->lost) + 1;
+		return err;
+	}
+
+	if (evsel->nvme.initial_values) {
+		initial_val = xyarray__entry(evsel->nvme.initial_values, cpu_map_idx, thread);
+		if (initial_val)
+			base = *initial_val;
+	}
+	delta = val >= base ? val - base : val;
+
+	if (old_count) {
+		if (nvme_pmu__is_gauge(evsel->core.attr.config))
+			count->val = old_count->val + val;
+		else
+			count->val = delta;
+		count->run = old_count->run + 1;
+		count->ena = old_count->ena + 1;
+		count->lost = old_count->lost;
+	} else {
+		if (nvme_pmu__is_gauge(evsel->core.attr.config))
+			count->val = val;
+		else
+			count->val = delta;
+		count->run++;
+		count->ena++;
+		count->lost = 0;
+	}
+	return 0;
+}
+
+#endif
diff --git a/tools/perf/util/nvme_pmu.h b/tools/perf/util/nvme_pmu.h
new file mode 100644
index 000000000000..8e16494a69f3
--- /dev/null
+++ b/tools/perf/util/nvme_pmu.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __NVME_PMU_H
+#define __NVME_PMU_H
+
+#include "pmu.h"
+#include <errno.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#ifdef HAVE_LIBNVME_SUPPORT
+#include <libnvme.h>
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
+	return -EOPNOTSUPP;
+}
+
+static inline int evsel__nvme_pmu_read(struct evsel *evsel __maybe_unused,
+				       int cpu_map_idx __maybe_unused,
+				       int thread __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif /* __NVME_PMU_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 01753d5c69d1..d33a313f5604 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -25,6 +25,7 @@
 #include "pmu.h"
 #include "drm_pmu.h"
 #include "hwmon_pmu.h"
+#include "nvme_pmu.h"
 #include "pmus.h"
 #include "tool_pmu.h"
 #include "tp_pmu.h"
@@ -1696,6 +1697,8 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
 
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__config_terms(pmu, attr, terms, err);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__config_terms(pmu, attr, terms, err);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__config_terms(pmu, attr, terms, err);
 
@@ -1860,6 +1863,12 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		ret = hwmon_pmu__check_alias(head_terms, info, err);
 		goto out;
 	}
+	if (perf_pmu__is_nvme(pmu)) {
+		ret = nvme_pmu__check_alias(head_terms, info, err);
+		if (ret)
+			return ret;
+		goto out;
+	}
 	if (perf_pmu__is_drm(pmu)) {
 		ret = drm_pmu__check_alias(pmu, head_terms, info, err);
 		goto out;
@@ -2121,6 +2130,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return tp_pmu__have_event(pmu, name);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__have_event(pmu, name);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__have_event(pmu, name);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__have_event(pmu, name);
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
@@ -2142,6 +2153,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 		return tp_pmu__num_events(pmu);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__num_events(pmu);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__num_events(pmu);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__num_events(pmu);
 
@@ -2278,6 +2291,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		return tp_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__for_each_event(pmu, state, cb);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__for_each_event(pmu, state, cb);
 
@@ -2786,6 +2801,8 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 
 	if (perf_pmu__is_hwmon(pmu))
 		hwmon_pmu__exit(pmu);
+	else if (perf_pmu__is_nvme(pmu))
+		nvme_pmu__exit(pmu);
 	else if (perf_pmu__is_drm(pmu))
 		drm_pmu__exit(pmu);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2c8916ad073e..fd33835da4de 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -46,6 +46,8 @@ enum pmu_kind {
 	PERF_PMU_KIND_DRM,
 	/* A perf tool provided HWMON PMU. */
 	PERF_PMU_KIND_HWMON,
+	/* A perf tool provided NVME PMU. */
+	PERF_PMU_KIND_NVME,
 	/* Perf tool provided PMU for tool events like time. */
 	PERF_PMU_KIND_TOOL,
 	/* A testing PMU kind. */
@@ -54,7 +56,9 @@ enum pmu_kind {
 
 enum {
 	PERF_PMU_TYPE_PE_START    = 0,
-	PERF_PMU_TYPE_PE_END      = 0xFFFDFFFF,
+	PERF_PMU_TYPE_PE_END      = 0xFFFCFFFF,
+	PERF_PMU_TYPE_NVME_START  = 0xFFFD0000,
+	PERF_PMU_TYPE_NVME_END    = 0xFFFDFFFF,
 	PERF_PMU_TYPE_DRM_START   = 0xFFFE0000,
 	PERF_PMU_TYPE_DRM_END     = 0xFFFEFFFF,
 	PERF_PMU_TYPE_HWMON_START = 0xFFFF0000,
@@ -366,6 +370,8 @@ static inline enum pmu_kind perf_pmu__kind(const struct perf_pmu *pmu)
 	type = pmu->type;
 	if (type <= PERF_PMU_TYPE_PE_END)
 		return PERF_PMU_KIND_PE;
+	if (type <= PERF_PMU_TYPE_NVME_END)
+		return PERF_PMU_KIND_NVME;
 	if (type <= PERF_PMU_TYPE_DRM_END)
 		return PERF_PMU_KIND_DRM;
 	if (type <= PERF_PMU_TYPE_HWMON_END)
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 1355b317f3ed..980035b640dc 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -18,6 +18,7 @@
 #include "pmus.h"
 #include "pmu.h"
 #include "hwmon_pmu.h"
+#include "nvme_pmu.h"
 #include "tool_pmu.h"
 #include "print-events.h"
 #include "strbuf.h"
@@ -45,18 +46,21 @@ enum perf_tool_pmu_type {
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
@@ -180,6 +184,8 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	/* Looking up an individual perf event PMU failed, check if a tool PMU should be read. */
 	if (!strncmp(name, "hwmon_", 6))
 		to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
+	else if (!strncmp(name, "nvme", 4))
+		to_read_pmus |= PERF_TOOL_PMU_TYPE_NVME_MASK;
 	else if (!strncmp(name, "drm_", 4))
 		to_read_pmus |= PERF_TOOL_PMU_TYPE_DRM_MASK;
 	else if (!strcmp(name, "tool"))
@@ -282,6 +288,10 @@ static void pmu_read_sysfs(unsigned int to_read_types)
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)
 		perf_pmus__read_hwmon_pmus(&other_pmus);
 
+	if ((to_read_types & PERF_TOOL_PMU_TYPE_NVME_MASK) != 0 &&
+	    (read_pmu_types & PERF_TOOL_PMU_TYPE_NVME_MASK) == 0)
+		perf_pmus__read_nvme_pmus(&other_pmus);
+
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_DRM_MASK) != 0 &&
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_DRM_MASK) == 0)
 		perf_pmus__read_drm_pmus(&other_pmus);
@@ -318,6 +328,8 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 	if (type >= PERF_PMU_TYPE_PE_START && type <= PERF_PMU_TYPE_PE_END) {
 		to_read_pmus = PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
 			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
+	} else if (type >= PERF_PMU_TYPE_NVME_START && type <= PERF_PMU_TYPE_NVME_END) {
+		to_read_pmus = PERF_TOOL_PMU_TYPE_NVME_MASK;
 	} else if (type >= PERF_PMU_TYPE_DRM_START && type <= PERF_PMU_TYPE_DRM_END) {
 		to_read_pmus = PERF_TOOL_PMU_TYPE_DRM_MASK;
 	} else if (type >= PERF_PMU_TYPE_HWMON_START && type <= PERF_PMU_TYPE_HWMON_END) {
@@ -390,6 +402,10 @@ struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *eve
 		if (strlen(event) > 4 && strncmp("drm-", event, 4) == 0)
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_DRM_MASK;
 
+		/* Could the event be an nvme event? */
+		if (nvme_pmu__have_event(NULL, event))
+			to_read_pmus |= PERF_TOOL_PMU_TYPE_NVME_MASK;
+
 		pmu_read_sysfs(to_read_pmus);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	}
@@ -427,11 +443,14 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
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
2.56.1.703.gf848ed807c-goog


