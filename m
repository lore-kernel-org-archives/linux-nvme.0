Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7DBCD8CB9
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2MaddhjZSLJjQwBreN2wO4fD/cwTQ9BQwJgEVkkOTsM=; b=effJ3Zd9RjO1XvoQbeAqNdG/A3
	I33nhbR6htV3MWhCx6D4+HPtJeJQ/jwo5Rz3LcBPIHpobz2VcJ4dEjd6+fV3cjLfgq6SDUdhwzerV
	jnF3J9niXG05tJIsRLZRrXHnuvRJD992OV12lG1lBzhdeOncitdfDhQqIHJlEJlGG6bSAHUCD8yAQ
	NgjS0ZmR3hc8V9938f2CkhmwrSegX+5jngMvArD9gTjlLJovVW5uJ/g7fqIyKUV/ztNrP+XLJ2r4F
	0wpGHWQVj/J3z0Gqhc6DCwsR0OgufgzYUwftsTJNbndaOFbCyPWbqCS7v2a//mnVA1IqarVPqAMGR
	pVGeDMbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzlh-000000065wB-1e6S;
	Tue, 09 Jun 2026 16:57:37 +0000
Received: from mail-dy1-x1349.google.com ([2607:f8b0:4864:20::1349])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzle-000000065vX-18oi
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 16:57:35 +0000
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-304d8613efbso5862048eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781024252; x=1781629052; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MaddhjZSLJjQwBreN2wO4fD/cwTQ9BQwJgEVkkOTsM=;
        b=CiY5VmkGaYds7Oy25ibC6bNcttX80MFmyUSNwOiK3H6EHNW6Wb2a7DmPpPoAt9bqu8
         JYEKhxS29oALUdtoHYLg5+U8aSpKPG6OrCMfmJFgCPGC1OZuJSQEvkI6cffnb2nY8OPU
         63js5RsICtPIENFS7grTfO6BfijvG6wnHFdMZTWyi9W6l9SY0C/M6A+FATGDnEzoBKIQ
         f0f7RCrLYUkojGnVU4VkecWn+kPvUrDXYdit5xO+edajSZz1u4Pv6Nmj6CVyOT+yadH1
         PaG70oIMri7nNvIJRdK70jDU+gPbARvHn6mWnrL0v3rc0wd+V4cHi/HmWS23YcFGoLFC
         aPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024252; x=1781629052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MaddhjZSLJjQwBreN2wO4fD/cwTQ9BQwJgEVkkOTsM=;
        b=ND/mFPrdC1ajGstzuUjb4H9i8cPtn6AwkzdgstKVreOLpVVGKjkLEb5+FD0t6rXWO3
         TgmVH0DTBvSv6/2VgdzY3txgi/bvWotqKYGLhVXtZrUk4SCIXSb2sv2iUVns9oJbTpkt
         Bvo4uZ1QE6GMO/7kD4G2LB/EF3aihHj7HEBrteix7mws0xzTkkz8tsIEJ7wiiFlxRl2n
         //+vih2X3jvpOQtFfMAC5rDf0fd7ttWq412SBbUAXAjmvfu7quxLjszazABxsQUnVzGK
         SupUAtz7lmPGqPUCuTi3RvnwF19F+d+CQgrViBlFVHWirMy3UHmwrmCM6jgwZ2oFTHRw
         C9xw==
X-Forwarded-Encrypted: i=1; AFNElJ/wnL2yn3xwGvWiEVhdAbfhTIjEJiBZa7XdFKzQbEw0EXc7ziYN8qUIs6rE0CwW7+F/i9ceD9bJd51m@lists.infradead.org
X-Gm-Message-State: AOJu0YxM9XpPIDxByVm2tKHRL8+PZgbaPY8TXoCbe/YJYIbuQXa1JeNp
	Ef2WHKu5LAlwt9eEjkownhxfNIJaxeLFbVN39uR6tIPF/dwHTCjSnWe8/h5VNcqBK0J+KCASFFG
	JFaVlgy2aXw==
X-Received: from dybpk17.prod.google.com ([2002:a05:7301:4291:b0:303:c230:ac8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3b06:b0:2ed:e14:e954
 with SMTP id 5a478bee46e88-3077b8014d6mr11298822eec.30.1781024252274; Tue, 09
 Jun 2026 09:57:32 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:57:23 -0700
In-Reply-To: <20260609070348.541964-1-irogers@google.com>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609165726.786694-1-irogers@google.com>
Subject: [PATCH v2 0/3] perf pmu: Add tool-provided NVMe PMU
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
X-CRM114-CacheID: sfid-20260609_095734_478680_95484A24 
X-CRM114-Status: GOOD (  12.86  )
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

Changes in v2:
- Fixed feature check: added test-libnvme.c to test-all.c to correctly
  propagate fast-path discovery failures.
- Makefile cleanup: added libnvme to FEATURE_PKG_CONFIG in Makefile.feature
  to ensure correct pkg-config flags are used during feature testing.
- Alignment safety: replaced strict-aliasing pointers with get_unaligned_le*
  accessors inside nvme_pmu__read_val() to prevent crashes on strict-alignment
  architectures.
- Heap safety: refactored evsel delta snapshots to use a new 'nvme' union
  member inside struct evsel instead of clashing with evsel->priv, preventing
  memory leaks and heap corruption with active tools like perf script.

Ian Rogers (3):
  perf build: Add libnvme feature detection
  perf pmu: Implement tool-provided NVMe PMU
  perf tests: Add NVMe PMU event parsing test

 tools/build/Makefile.feature       |   5 +-
 tools/build/feature/Makefile       |   3 +
 tools/build/feature/test-all.c     |   5 +
 tools/build/feature/test-libnvme.c |  11 +
 tools/perf/Makefile.config         |  12 +
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/builtin-test.c    |   1 +
 tools/perf/tests/nvme_pmu.c        | 176 ++++++++++
 tools/perf/tests/tests.h           |   1 +
 tools/perf/util/Build              |   1 +
 tools/perf/util/evsel.c            |  13 +-
 tools/perf/util/evsel.h            |   4 +
 tools/perf/util/nvme_pmu.c         | 537 +++++++++++++++++++++++++++++
 tools/perf/util/nvme_pmu.h         | 143 ++++++++
 tools/perf/util/pmu.c              |  15 +
 tools/perf/util/pmu.h              |   8 +-
 tools/perf/util/pmus.c             |  31 +-
 tools/perf/util/pmus.h             |   1 +
 18 files changed, 960 insertions(+), 8 deletions(-)
 create mode 100644 tools/build/feature/test-libnvme.c
 create mode 100644 tools/perf/tests/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.h

-- 
2.54.0.1099.g489fc7bff1-goog


