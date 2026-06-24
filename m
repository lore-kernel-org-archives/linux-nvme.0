Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E10CDB479
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 19:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ea3HIUVto5uwz2Q2ZR8R/Q6C7MwhYo1rdMh3Z+B5Zow=; b=emcaUgqrbicDGpOb1DLfF8ccR+
	v3ZiKtjVY8Gie/FRv4Q+mFMpUlcVRT9Ev56smqCatzmK1FtaHr6yYZv+XS6pinfaw/oWe5isvukjQ
	ScNICrh3sSyQT9eW/9qkUiZ0IpXhaiGaAgH92AaR6PyEQXhLS95ABMNQ6SbepF4i7qQlOt8v9WYvC
	GvQnPrhDXOn2cvbezqx5jtUegO2xUBcsuGjjFS6iTI0+1EYs0E/XaGp/pgNjgENMdXNSVrm7XrysS
	9+Ud4VH8SZFdMgA2toxNjDL0sRA96BDG2cszIp5Unc0R0uA///CnDeP51evDApQwObu1q/GFNdPKd
	W/CnOwrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcTkD-00000008Ihl-3ZJt;
	Wed, 24 Jun 2026 19:58:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcTkC-00000008IhY-408l
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 19:58:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EFBDC40AD1;
	Wed, 24 Jun 2026 19:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1AF1F000E9;
	Wed, 24 Jun 2026 19:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782331123;
	bh=Ea3HIUVto5uwz2Q2ZR8R/Q6C7MwhYo1rdMh3Z+B5Zow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ao72++iiPoFqzJl2YBsSYZPh4n4xYyvUTnNNajCu1hcd6VeiYmJijo77sns55UflP
	 NA8N08hF0H6bhwqDP5WTDg9sz8tarvMFAvc44L4tSqSDk2597ikCgRgUost2aQ5EuX
	 RJ9oC+Pk2tojI6Mv/PuwNDVTUATo1AF9E1pIyB6eXf8S062mrsmBghZiFbqz73T5f4
	 0vv4BICnJ1iJ90boPuH3mp0gGONcbnX0TgfLF40SDaqSaXVQlEb6iHCc2oaJgxWIpa
	 rNlITbjYWM5xWsGZjxa7oX0tWJXs4CxYQSt6ViNAR2XapvEAMulGStLUKkotZGC3xf
	 ksgLCYQ6z/eFw==
Date: Wed, 24 Jun 2026 12:58:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Yuzhuo Jing <yuzhuo@google.com>, Leo Yan <leo.yan@arm.com>,
	German Gomez <german.gomez@arm.com>,
	Anubhav Shelat <ashelat@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 0/3] perf pmu: Add tool-provided NVMe PMU
Message-ID: <ajw28nITeOgtH0GF@google.com>
References: <20260609070348.541964-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609070348.541964-1-irogers@google.com>
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

On Tue, Jun 09, 2026 at 12:03:45AM -0700, Ian Rogers wrote:
> This patch series introduces a tool-provided PMU for NVMe devices to expose
> various hardware logs as perf events.
> 
> Using libnvme, the new nvme_pmu extracts metrics from standard NVMe log pages
> including:
> - SMART / Health Information (e.g. data units read/written, power cycles,
>   temperature)
> - Endurance Group Information
> - FDP (Flexible Data Placement) Statistics
> - Error Information
> - Zoned Namespaces (ZNS) Changed Zones
> 
> Key features:
> - Dynamic probing of supported log pages on /dev/nvmeX. Unsupported events
>   are marked as deprecated and hidden from `perf list` by default.
> - Generic configuration encoding where the log type, size, and offset are
>   encoded directly into the event configuration.
> - Correct interval delta tracking using baseline offset snapshots. This mimics
>   the behavior of the hwmon PMU, allowing gauges like Temperature to be
>   reported instantaneously in `perf stat -I`, while standard counters
>   correctly accumulate deltas.
> - Robust handling of cross-architecture endianness when reading 128-bit and
>   64-bit fields from the NVMe specification.

Can you please show actual output so that we can understand what you're
doing?

Thanks,
Namhyung

> 
> The series is broken down into:
> 1. Adding the libnvme feature detection via pkg-config in tools/build.
> 2. The core implementation of the NVMe tool PMU.
> 3. A unit test suite verifying the parsing and encoding of the NVMe PMU
>    events using a mocked device.
> 
> Ian Rogers (3):
>   perf build: Add libnvme feature detection
>   perf pmu: Implement tool-provided NVMe PMU
>   perf tests: Add NVMe PMU event parsing test
> 
>  tools/build/Makefile.feature       |   2 +
>  tools/build/feature/Makefile       |   3 +
>  tools/build/feature/test-libnvme.c |  11 +
>  tools/perf/Makefile.config         |  12 +
>  tools/perf/tests/Build             |   1 +
>  tools/perf/tests/builtin-test.c    |   1 +
>  tools/perf/tests/nvme_pmu.c        | 176 ++++++++++
>  tools/perf/tests/tests.h           |   1 +
>  tools/perf/util/Build              |   1 +
>  tools/perf/util/evsel.c            |  11 +-
>  tools/perf/util/nvme_pmu.c         | 535 +++++++++++++++++++++++++++++
>  tools/perf/util/nvme_pmu.h         | 143 ++++++++
>  tools/perf/util/pmu.c              |  15 +
>  tools/perf/util/pmu.h              |   8 +-
>  tools/perf/util/pmus.c             |  31 +-
>  tools/perf/util/pmus.h             |   1 +
>  16 files changed, 945 insertions(+), 7 deletions(-)
>  create mode 100644 tools/build/feature/test-libnvme.c
>  create mode 100644 tools/perf/tests/nvme_pmu.c
>  create mode 100644 tools/perf/util/nvme_pmu.c
>  create mode 100644 tools/perf/util/nvme_pmu.h
> 
> -- 
> 2.54.0.1064.gd145956f57-goog
> 

