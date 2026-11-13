Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C05606A339
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qg5lSHn2;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YgusQksx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=eAWSWKem9zfHt+XlC1XEIj2qyzJSlOK0o6wdT7kCa6s=; b=qg5lSHn21kJnhzPAkHs+YLeEvl
	yIsqQvZayqHOcf8nAMk3D2LrJiS90Ad6Q3wRrNNfrXPqTCRYDDEMz4LT1Q7JDmKclKtI6oa4KAx18
	stcBuBbiIHB4kKX9Lh/QR/M6PmQAk7P10Ml1iAgXRBt0NvX+rX9TKE8tUOADlVm7AH1S/wzMH1b+J
	SYNd277fq7Z64072xguWIQgRINOlcUzWqnBAqJpE6ui14AB6lMfT1Nn8Rc5tPCnAcfxjbi02jdKPS
	EGda4Dry0iR4K813XaQ5UWktEBoTCOdneb922GdQLq7bArNF0eC9P5d1bSHFq1UCCMkaivdvsc0cY
	UMHDchSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwhv-0000000E7aK-17V0;
	Fri, 13 Nov 2026 19:13:07 +0000
Received: from mail-dy1-x1348.google.com ([2607:f8b0:4864:20::1348])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwhr-0000000E7Yt-1LJm
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 19:13:05 +0000
Received: by mail-dy1-x1348.google.com with SMTP id 5a478bee46e88-375bac6bd21so949022eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794597182; x=1795201982; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eAWSWKem9zfHt+XlC1XEIj2qyzJSlOK0o6wdT7kCa6s=;
        b=YgusQksx+8vgvjxwaTt58F+mdpfD67r5Agf9SDeH0EhYuVNRulDn9kXObZcPtvBCgJ
         wFl1GyWRHXsCuzz5lwM/InNUi4srase5gjLFHMuE63QpnUMn5KBEqurcErLhjBhwgg0T
         AY9Vy5xKGU+wK4mPSsGg4wwZHSJimbDtStKOeiJNEJcA/InUqni5c/rNXXpVigpuWIdv
         5mS9xiH9ua2nMCDrqvHGLhIdxeTndIp+o4rnWPUrScuEnYOFlHC46+LYTnllPsSkDWWu
         wH2yY0Ci2BSv5FVToauvZj1PvGghrNzWie8MAZXCML7SlpKbKHNDQtlDbdBSkHnw+foY
         8aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597182; x=1795201982;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAWSWKem9zfHt+XlC1XEIj2qyzJSlOK0o6wdT7kCa6s=;
        b=wBky3wEVz3GExw+2lhjvt/Cp8cOIbQlJvLZH3Kmp6aK/vNeqtqsUXk7psp1n0eq+ti
         xr/s990C/AVQ/M6YSERKViwPTGfl9euuN+jOFZlTRc3RfX+FwrNWeuvsPEJvsQHhMx3l
         noC2vyGuFwIj45vmyq+IZpXiVCZ966CuerqW58UIGfHCVslNGHVhpeIx5h6Vyu5IyIan
         a9W5+fb/8SelYHQk13ho1KQVovk01ZxOM5fdYw/rICGMdWpun9o8ab6f4wbPzWPwnBg4
         1slTjmOMnAhwcBdAf8D1cgfufjBRvMn1DCiMcyTkmbdqVKauMhexuSWNZYEX+waWNLxl
         UDHA==
X-Forwarded-Encrypted: i=1; AL+hErFHE5wPxbE3TLoWS1YoZS8IEPUsKE2yDMnchpdrhAoEovPTu7vinsErdRCYlvuUQLChty5QxSjvI7IL@lists.infradead.org
X-Gm-Message-State: APuU4Z85XKQ9GdPvtDbiRGQ/vtXte9IMSdNgFQRQmVN72XJ3IozHlJrQ
	o+9/MfACMbkKgZoXAPYwzhHXHUCIv1yrB6x0PhetJKP+WzjFZMmcK0lxH/mFmmHwiAz0ibQ72Cs
	vBXv3CHuZmw==
X-Received: from dycnm5.prod.google.com ([2002:a05:7300:d185:b0:35a:c4b6:314b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:20c8:20b0:36a:37:1404
 with SMTP id 5a478bee46e88-37966e3af34mr2810296eec.13.1794597181337; Fri, 13
 Nov 2026 11:13:01 -0800 (PST)
Date: Fri, 13 Nov 2026 11:12:31 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113191234.2509964-1-irogers@google.com>
Subject: [PATCH v3 0/3] perf pmu: Add tool-provided NVMe PMU
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
X-CRM114-CacheID: sfid-20261113_111303_367053_9D125328 
X-CRM114-Status: GOOD (  16.45  )
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
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a tool-provided PMU for NVMe controllers using libnvme,
following the same pattern as the existing tool, hwmon, and drm PMUs.
Each discovered controller is exposed as an 'nvme_<ctrl>' PMU (with
alias '<ctrl>', e.g. 'nvme_nvme0' and 'nvme0') providing events from
standard NVMe log pages: SMART / Health Information, Endurance Group
Information, Flexible Data Placement (FDP) Statistics, Error
Information, and Zoned Namespaces (ZNS) Changed Zones.

Motivation / Use Cases
======================
While standalone tools such as nvme-cli can dump individual log pages on
demand, exposing NVMe controller log metrics as a perf tool PMU allows
storage metrics (host/media bytes written, write amplification and FDP
efficiency, read/write command counts, controller busy time, error
counters, and device temperature) to be sampled on a unified timeline
alongside CPU hardware counters, kernel/block events, uncore counters,
and hwmon/drm sensors in 'perf stat' (including interval mode '-I', CSV
'-x', JSON '-j', and perf metric formulas), without custom wrapper
scripts. Discovery and log-page probing are gated behind
PERF_TOOL_PMU_TYPE_NVME_MASK so commands that do not request NVMe events
incur zero overhead.

Example Output
==============
Listing available NVMe events (unsupported log pages on the controller
are marked deprecated and hidden from default 'perf list'):

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

 $ perf list --details nvme_nvme0/smart_temperature/

 List of pre-defined events (to be used in -e or -M):

 nvme:
   smart_temperature
        [Temperature. Unit: nvme_nvme0]
     nvme_nvme0/config=0x20001/

Interval 'perf stat' output (captured with mocked libnvme SMART log
responses on /dev/nvme0):

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

Changes in v3:
- Remove accidental internal tracking tags from commit messages
  (Christoph Hellwig).
- Document use cases and include actual 'perf list' and 'perf stat'
  example output in the cover letter and Patch 2 commit message, and
  document NVMe events in Documentation/perf-list.txt (Christoph
  Hellwig, Namhyung Kim).
- Rely on $(FEATURE_CHECK_LDFLAGS-libnvme) from pkg-config when building
  test-libnvme.bin instead of hardcoding -lnvme, and add test-libnvme.bin
  to FILES in tools/build/feature/Makefile.
- Report smart_temperature in native Kelvins ('1K') to avoid unsigned
  uint64_t underflow on sub-zero Celsius or 0 K readings; metrics can
  convert Kelvin to Celsius.
- Support advertised 'config=0x...' raw encodings, 'event=<name>', and
  standard event qualifiers ('name=', 'metric-id=', 'cpu='), and guard
  NULL term->config when formatting parse errors.
- Check xyarray__new() allocation failure (-ENOMEM), propagate initial
  log read errors (-EPERM / -EOPNOTSUPP) in evsel__nvme_pmu_open(), and
  bound incremental open error unwind by start_cpu_map_idx.
- Use an aligned union of NVMe log structures in nvme_pmu__read_val(),
  use valid Endurance Group ID 1 (0 is reserved in NVMe) for Endurance
  Group and FDP logs, fix Endurance Group data/media unit scaling to
  billions of bytes ('1000000000B') per NVMe Base Spec, wire up
  perf_pmus__find_by_type() for NVMe PMU types, and propagate
  nvme_pmu__check_alias() errors in perf_pmu__check_alias().
- Expand unit tests to cover alias PMUs, 'event=', 'config=0x...',
  'name=' qualifiers, unit/scale checks, and invalid term rejection.

Changes in v2:
https://lore.kernel.org/linux-perf-users/20260609165726.786694-1-irogers@google.com/
- Include test-libnvme.c in test-all.c and add libnvme to
  FEATURE_PKG_CONFIG.
- Use get_unaligned_le*() helpers when reading NVMe log fields.
- Move baseline initial_values xyarray from tool-owned evsel->priv into
  struct evsel's tool union (evsel->nvme.initial_values) and free it in
  evsel__exit().

v1:
https://lore.kernel.org/linux-perf-users/20260609070348.541964-1-irogers@google.com/

Ian Rogers (3):
  perf build: Add libnvme feature detection
  perf pmu: Implement tool-provided NVMe PMU
  perf tests: Add NVMe PMU event parsing test

 tools/build/Makefile.feature           |   5 +-
 tools/build/feature/Makefile           |   4 +
 tools/build/feature/test-all.c         |   5 +
 tools/build/feature/test-libnvme.c     |  11 +
 tools/perf/Documentation/perf-list.txt |  10 +-
 tools/perf/Makefile.config             |  12 +
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   1 +
 tools/perf/tests/nvme_pmu.c            | 303 +++++++++++
 tools/perf/tests/tests.h               |   1 +
 tools/perf/util/Build                  |   1 +
 tools/perf/util/evsel.c                |  13 +-
 tools/perf/util/evsel.h                |   4 +
 tools/perf/util/nvme_pmu.c             | 691 +++++++++++++++++++++++++
 tools/perf/util/nvme_pmu.h             | 144 ++++++
 tools/perf/util/pmu.c                  |  17 +
 tools/perf/util/pmu.h                  |   8 +-
 tools/perf/util/pmus.c                 |  24 +
 tools/perf/util/pmus.h                 |   1 +
 19 files changed, 1250 insertions(+), 6 deletions(-)
 create mode 100644 tools/build/feature/test-libnvme.c
 create mode 100644 tools/perf/tests/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.h

-- 
2.56.1.703.gf848ed807c-goog


