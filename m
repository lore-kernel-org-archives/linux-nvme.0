Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7550CD8CAD
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 07:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JxPb+RxK32jFv/xJSoX/EYo4cdhBkfXrSsqEtmmG9wM=; b=T7vAE6xGZ9wRPPRXUtTwpQbgwJ
	1VYipRVaFeucVNDa3gzVAmzakqm28vGLL+NTJyMnGnv972ReHommFwhMRdlCt+0CMa+WOFiGkcye4
	ntm6/lGoZq3Vo/XrKUCcuFm0EZMqmIkOxlFesw8/c2J8F6RymBtMnrVLXgk2coAX1ccDbFc7TU7v5
	dYZoPqpCkn4kX36hNV1OqRtHH85xzdXpU5xC9DRIjWeaNzQpr7ObtXaITAFz18kpsnU3brGBpSaGn
	GqzDR09DQcSMQec4Sv1gSCFJmmdrGvGtjEwrkxdo2LiEXPWKYxMfhsbLVaYshSHYpNAqcmlqWEJCe
	dRxBolOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWqVC-00000004w0p-1sMn;
	Tue, 09 Jun 2026 07:03:58 +0000
Received: from mail-dl1-x1249.google.com ([2607:f8b0:4864:20::1249])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWqVA-00000004w0P-3L1Z
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 07:03:58 +0000
Received: by mail-dl1-x1249.google.com with SMTP id a92af1059eb24-13815cb1507so6229079c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988635; x=1781593435; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxPb+RxK32jFv/xJSoX/EYo4cdhBkfXrSsqEtmmG9wM=;
        b=L5Bj0CxbPSIltM3ZlQBpdrJpTF2qFEnwaOXWc9TREGxfDJwP1Ts5xQyzPAQHHThesJ
         DUaRa79MQNxYFszL8cWStrdjxnHP2CUnD/Jocx6KR9zx9tIIClRvXcjGjMhUagFRDv9Y
         DqLDK7FFgyqT4S/HzzOnaCsLSiLejQON8mqzSkr2YXKQ8LPn0MBK2OU/SXyxN/Rg9fog
         C9XtGOH1RgRzxwoj1Y9ffsPuiwufKXgRvVxH9qdFanu2HsrMVSNYeP1H5XBUaGcdy6Hv
         LFJ687RGU3oz4biOmCfFPjqLoLsIyhG/uT5vQbz8qkBj3mEXn5GJ5LuBhhPXj5+ctkkw
         8VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988635; x=1781593435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxPb+RxK32jFv/xJSoX/EYo4cdhBkfXrSsqEtmmG9wM=;
        b=QxrQNC1s+DyQeoN3iizJWPK+bB8imIEFZaDDK/WMaAYpWNrImnEM7BUIMuam/2KHAK
         5y+a30ivli3811QCKGqfdyczTm2oNxAmeiKjLLIMNPugYN725YZgrgenYcakeWsFrLv5
         skbaGJegmkb+JT/Ru4LPpeo7BmHP6oPf01wu+IPhx80SRw6FfDZWD1RhZr1JR+BnUT2e
         ULRRcFYmGlNVqJ7FZ9qynXirSVNfBroVJMqoXtptdCs2hzy2pMH38YkyC/QaSJfMceGi
         24TX2yvRCGA+0l87hCb4jX4YI9nbkTSXKx/J13IIJ4HLaIWcr/nn7LJ4WSpxBBgygpm1
         G/ww==
X-Gm-Message-State: AOJu0YzBsMcTq1tJCrVxLFDYhfMVoIaycE8YF+29rTnpJ9aPI+dLYsJ8
	KmYl9WZKgXVBaNnMeABByJghrgPttGAJ1U7xwttOrVuCK5xsWT7nYy0rfWiLFhpcdQe2tjh5Hbr
	cWgnaDq+asg==
X-Received: from dlbrx14.prod.google.com ([2002:a05:7022:170e:b0:137:fb92:f7ee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6613:b0:12c:8e70:c33b
 with SMTP id a92af1059eb24-138066be665mr9925946c88.8.1780988635043; Tue, 09
 Jun 2026 00:03:55 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:03:45 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070348.541964-1-irogers@google.com>
Subject: [PATCH v1 0/3] perf pmu: Add tool-provided NVMe PMU
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
X-CRM114-CacheID: sfid-20260609_000356_868111_FA9C7619 
X-CRM114-Status: GOOD (  14.72  )
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

This patch series introduces a tool-provided PMU for NVMe devices to expose
various hardware logs as perf events.

Using libnvme, the new nvme_pmu extracts metrics from standard NVMe log pages
including:
- SMART / Health Information (e.g. data units read/written, power cycles,
  temperature)
- Endurance Group Information
- FDP (Flexible Data Placement) Statistics
- Error Information
- Zoned Namespaces (ZNS) Changed Zones

Key features:
- Dynamic probing of supported log pages on /dev/nvmeX. Unsupported events
  are marked as deprecated and hidden from `perf list` by default.
- Generic configuration encoding where the log type, size, and offset are
  encoded directly into the event configuration.
- Correct interval delta tracking using baseline offset snapshots. This mimics
  the behavior of the hwmon PMU, allowing gauges like Temperature to be
  reported instantaneously in `perf stat -I`, while standard counters
  correctly accumulate deltas.
- Robust handling of cross-architecture endianness when reading 128-bit and
  64-bit fields from the NVMe specification.

The series is broken down into:
1. Adding the libnvme feature detection via pkg-config in tools/build.
2. The core implementation of the NVMe tool PMU.
3. A unit test suite verifying the parsing and encoding of the NVMe PMU
   events using a mocked device.

Ian Rogers (3):
  perf build: Add libnvme feature detection
  perf pmu: Implement tool-provided NVMe PMU
  perf tests: Add NVMe PMU event parsing test

 tools/build/Makefile.feature       |   2 +
 tools/build/feature/Makefile       |   3 +
 tools/build/feature/test-libnvme.c |  11 +
 tools/perf/Makefile.config         |  12 +
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/builtin-test.c    |   1 +
 tools/perf/tests/nvme_pmu.c        | 176 ++++++++++
 tools/perf/tests/tests.h           |   1 +
 tools/perf/util/Build              |   1 +
 tools/perf/util/evsel.c            |  11 +-
 tools/perf/util/nvme_pmu.c         | 535 +++++++++++++++++++++++++++++
 tools/perf/util/nvme_pmu.h         | 143 ++++++++
 tools/perf/util/pmu.c              |  15 +
 tools/perf/util/pmu.h              |   8 +-
 tools/perf/util/pmus.c             |  31 +-
 tools/perf/util/pmus.h             |   1 +
 16 files changed, 945 insertions(+), 7 deletions(-)
 create mode 100644 tools/build/feature/test-libnvme.c
 create mode 100644 tools/perf/tests/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.h

-- 
2.54.0.1064.gd145956f57-goog


