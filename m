Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98964CD342F
	for <linux-nvme@archiver.kernel.org>; Tue,  5 May 2026 09:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qyCJ3ggykR9PaRuJp41aV9bP8LPh+ADnNvVpj0aBDcE=; b=FkZAtF9h3/yEQw/L4pLd6CU6ze
	wXAz9ItSWrEFPS9WaGzDnKlOZ3OmJ8n4BAxTtJSHF0kkOK31hdP4rKDJ2kzIEskpEIz6jAkcCETVp
	5rxHqZ2tbCcwGaZizkDxtgEkqrHPwPXTrtwHd6kmdl8XszOAl51D47LcwU+jGtv+4KBGR9E21P4+F
	pswe5EiaKsgwG3jwZTBSGa2me0c7X8z3aJBCzYP9ok+MYInX8bDS3plFdt6vfwuVMbx56VRRevzyx
	XjbmcTJSm+Xnjlsvl/s3IWfrnR0Gdz2Pu52y1XZdjUCEqAGpr/faE+ioR2ifHhN+8i+i9gGKTXQha
	g1vZb94w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKCRo-0000000Fi4B-3je2;
	Tue, 05 May 2026 09:52:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKCRm-0000000Fi3I-0uvR
	for linux-nvme@lists.infradead.org;
	Tue, 05 May 2026 09:52:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A67B843491;
	Tue,  5 May 2026 09:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E612C2BCB4;
	Tue,  5 May 2026 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777974729;
	bh=iBGlTXZl4h+aX5HdsyySsN6AuvOHgDHVSwVUXF9R/MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uas7diRFDTmdqsGwghbbfz2tF5QwT+n+8ZW7IB7czDXf4T/CGO9aQcBBRBMjTm4um
	 FbMP80t5eE/Dxt2PWCNleaYaQHXEnee6dSfRB1/2yiaauLgoR2+o7HfWzeO62cK+EO
	 k18cCjj4g7iGgif79PGmFBqcNEaTMgXuKYZ4UTSVc5urPtZIvQ2ftb/Tw9Cey3QJZO
	 wf8fcGpJ9kzLGQbZw4l0+VDXDww7xNoCHFRyOoOZZp3rnqr769Qwrefy9Fou17SI+t
	 rzg0yq/0A1kbbSvFcvjO5eGMsLmHpjVlmydgtMUjT5lMJRkZam8cvHxUvK8w90P3SM
	 bZg29++mLw08g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-5.10] nvme: add missing MODULE_ALIAS for fabrics transports
Date: Tue,  5 May 2026 05:51:22 -0400
Message-ID: <20260505095149.512052-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505095149.512052-1-sashal@kernel.org>
References: <20260505095149.512052-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_025210_369373_EBC5A5C3 
X-CRM114-Status: GOOD (  18.05  )
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

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit 723277b15ed97185ce6f75abbf19f06e00f0a6f5 ]

The generic fabrics layer uses request_module("nvme-%s", opts->transport)
to auto-load transport modules. Currently, the nvme-tcp, nvme-rdma, and
nvme-fc modules lack MODULE_ALIAS entries for these names, which prevents
the kernel from automatically finding and loading them when requested.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Phase Walkthrough
Phase 1 Record: subsystem `nvme` / NVMe host fabrics; action verb `add
missing`; intent is to add module aliases for existing fabrics
transports. Tags: `Reviewed-by: Christoph Hellwig <hch@lst.de>`,
`Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>`, `Signed-off-by:
Keith Busch <kbusch@kernel.org>`. No `Fixes:`, `Reported-by:`, `Tested-
by:`, `Link:`, or `Cc: stable`. Body describes a real autoload bug:
`fabrics.c` calls `request_module("nvme-%s", opts->transport)`, but the
transport modules do not advertise aliases matching `nvme-tcp`, `nvme-
rdma`, or `nvme-fc`. This is a hidden bug fix despite using “add”.

Phase 2 Record: files changed are `drivers/nvme/host/fc.c` `+1`,
`drivers/nvme/host/rdma.c` `+1`, `drivers/nvme/host/tcp.c` `+1`; no
functions changed, only module metadata at EOF. Before: modules had
license/description metadata but no matching alias. After: each existing
module exports the alias that the existing autoload path requests. Bug
category is logic/module-autoload correctness. Fix quality is excellent:
three literal aliases, each matching the existing transport name and
module filename; regression risk is very low.

Phase 3 Record: `request_module("nvme-%s", opts->transport)` was
introduced by `d1f1071f81513` (`nvme-fabrics: request transport
module`), first in `v4.15`. RDMA host came in `7110230719602` (`v4.8`),
FC in `e399441de9115` (`v4.10`), TCP in `3f2304f8c6d6` (`v5.0`). No
`Fixes:` tag to follow. Recent file history shows normal NVMe churn, not
a prerequisite series. The author has prior NVMe host commits, and the
patch was reviewed/committed by listed NVMe maintainers. No dependency
beyond the existing files and `MODULE_ALIAS`.

Phase 4 Record: `b4 dig -c 723277b15ed97` found the original patch at `h
ttps://patch.msgid.link/e3076c80ee2e0c4a2cae0374afb617a3365946ea.1774944
415.git.tanggeliang@kylinos.cn`. `b4 dig -a` found only v1. `b4 dig -w`
showed NVMe maintainers and `linux-nvme` were included. Lore mirror
shows Christoph Hellwig replied “Looks good” with `Reviewed-by`, and
Keith Busch replied “applied to nvme-7.1”. No NAKs, no stable
nomination, and no separate bug report link found.

Phase 5 Record: modified “functions” are module metadata only. The
affected call path is verified as `nvmf_dev_write()` ->
`nvmf_create_ctrl()` -> `request_module("nvme-%s", opts->transport)` ->
`nvmf_lookup_transport()` -> transport `create_ctrl`. Transport
registration uses `.name = "fc"`, `.name = "rdma"`, `.name = "tcp"` and
module objects are `nvme-fc.o`, `nvme-rdma.o`, `nvme-tcp.o`, so the
alias strings exactly match the requested names. This path is reachable
from userspace via the `nvme-fabrics` misc device write path; I did not
verify whether unprivileged users can trigger it.

Phase 6 Record: stable refs checked. `stable/linux-4.19.y` has the
autoload request and FC/RDMA files, but no TCP file.
`stable/linux-5.4.y` through `stable/linux-7.0.y` have the autoload
request and all three transport files. None of those checked stable refs
had the `MODULE_ALIAS("nvme-*")` entries. The patch applies cleanly to
current `stable/linux-7.0.y`; `5.4` through `6.6` lack the newer
`MODULE_DESCRIPTION` context, so they need a trivial backport placing
aliases after `MODULE_LICENSE`. `4.14.y` lacks the verified autoload
request and has no TCP file, so benefit there is not established.

Phase 7 Record: subsystem is NVMe host fabrics under storage/block;
criticality is IMPORTANT because it affects NVMe-oF connectivity for
users of these transports. The subsystem is active, with recent NVMe
host changes verified in history.

Phase 8 Record: affected users are NVMe-oF users with FC/RDMA/TCP
transports built as modules and not already loaded. Trigger is creating
a fabrics controller for one of those transports while relying on kernel
module autoload. Failure mode is not a crash: `nvmf_lookup_transport()`
fails, logs `no handler found for transport %s`, and returns `-EINVAL`,
preventing the connection. Severity is MEDIUM user-visible functional
failure for storage connectivity. Benefit is high for affected
configurations; risk is very low because it only adds module alias
metadata for existing modules.

Phase 9 Record: evidence for backporting: real autoload bug, existing
request path, exact alias/name/module matches, important storage
subsystem, very small patch, maintainer review, no API or new feature.
Evidence against: no crash/security/data-corruption impact, no explicit
stable tag, no explicit Tested-by, and older stable trees need minor
context adjustment. Stable rules: obviously correct yes; tested tag no
but maintainer-reviewed; fixes a real user-visible bug yes; important
enough for affected NVMe-oF users yes; small and contained yes; no new
feature/API yes; can apply cleanly to `7.0.y` and trivially to older
applicable trees. Exception category: closest to module/device autoload
enablement for existing drivers, not a new driver.

## Verification
- Phase 1: inspected upstream commit `723277b15ed97`; verified subject,
  body, tags, and absence of `Fixes:`/`Reported-by:`/stable tags.
- Phase 2: inspected diff; verified exactly three added `MODULE_ALIAS`
  lines.
- Phase 3: used blame/log/tag checks; verified autoload request
  introduced in `v4.15`, RDMA in `v4.8`, FC in `v4.10`, TCP in `v5.0`.
- Phase 4: ran `b4 dig -c`, `-a`, `-w`; fetched lore mirror; verified
  v1-only patch, maintainer review, maintainer application, no NAKs.
- Phase 5: read `fabrics.c`, `Makefile`, `Kconfig`, and transport ops;
  verified call path, transport names, and module names.
- Phase 6: checked stable refs `4.14.y`, `4.19.y`, `5.4.y`, `5.10.y`,
  `5.15.y`, `6.1.y`, `6.6.y`, `6.12.y`, `6.19.y`, `7.0.y`; verified
  applicable code and missing aliases; `git apply --check` passed on
  current `7.0.y`. One intermediate shell formatting command failed due
  to a bad `sed` expression; I reran the stable metadata check correctly
  afterward.
- Phase 8: verified the failure path returns `-EINVAL` after
  `nvmf_lookup_transport()` fails; privilege requirements were not
  verified.

This should be backported to applicable stable trees. It fixes an
existing intended autoload mechanism for existing NVMe fabrics
transports with a tiny, low-risk metadata-only change.

**YES**

 drivers/nvme/host/fc.c   | 1 +
 drivers/nvme/host/rdma.c | 1 +
 drivers/nvme/host/tcp.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e1bb4707183ca..e4f4528fe2a2d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3968,3 +3968,4 @@ module_exit(nvme_fc_exit_module);
 
 MODULE_DESCRIPTION("NVMe host FC transport driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("nvme-fc");
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 57111139e84fa..1ec6e867aedb6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2432,3 +2432,4 @@ module_exit(nvme_rdma_cleanup_module);
 
 MODULE_DESCRIPTION("NVMe host RDMA transport driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("nvme-rdma");
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc84..02c95c32b07e3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3071,3 +3071,4 @@ module_exit(nvme_tcp_cleanup_module);
 
 MODULE_DESCRIPTION("NVMe host TCP transport driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("nvme-tcp");
-- 
2.53.0


