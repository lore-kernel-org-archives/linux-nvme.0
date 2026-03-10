Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEA1FCC9DE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 09:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rTzdHL6pvHyFj8hY6+Rdhw9p0m9v/1+vHxTxbd10eWY=; b=WzfgSxpFbZIuiI/cGIF12bX7lC
	n9zRnIntfS+skD8TGjnEnTtLcxkxgozQ5dNRoyGUjYLemmjjFn8pTpIH0jPh8SWTq6sQdyCQVI39F
	bsScmLjoE2EbknvFDEyI4/syUe9VvtixbprpT2dTq35TXJNe9jf/9evRGK5f7Zrsnpl8eX8+Gffts
	mKyN2S1J0+mieBJ3p4GflbYbLps5s9BjTDWL7+HHzHDlY7FNPoMUjH2wem/po1DwHse4nkfB/5wtH
	ghKoErzupSAZ49GGzVdH+VQAHn1ySpSLx9ogpIWRhVN6IuRv+KlE1jJGVLZ762MYTxQi4nPYZZW6n
	we1hpG4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzszI-000000091Mj-3yEi;
	Tue, 10 Mar 2026 09:02:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzszC-000000091KW-1rJX
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 09:02:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D6CEF436B5;
	Tue, 10 Mar 2026 09:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CC0C2BC9E;
	Tue, 10 Mar 2026 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773133361;
	bh=IzRLsqOSMJ8oiH+0nYYt6+k0f1VePCr+DzvMUpqK7m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnzksy/AQXPa6O2fZVT5hSVuKzA9iWe9GPk+MQhRT7slHLThpc5p+g/qhXC18RVCu
	 b+qOT8d+ES34n2e9ET3Yp3plCOltLe0Os/+oOLfs0SLUTvv3bhryZJamLI7c066spd
	 vdSZ7kQDa3RkfdG1q8galaQ9IPqIt+gmxZY5fHv1KoXLTx9YrpNpriuQygse2GGcVN
	 yru6RBWMNq84A8b6IplH7EqsYqnA/2OELqqoSLLkOsKpai87xoYlVfJQEYPSF+1EgM
	 HIR6NvyUxsGnCewvrgk0+M5U4eM+QhAnsQ12oIWNPTz3uIyEI0rFmogMjmmr7oDdBU
	 RiHijo2wECoJw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Daniel Hodges <hodgesd@meta.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.1] nvme-fabrics: use kfree_sensitive() for DHCHAP secrets
Date: Tue, 10 Mar 2026 05:01:38 -0400
Message-ID: <20260310090145.2709021-38-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310090145.2709021-1-sashal@kernel.org>
References: <20260310090145.2709021-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_020242_527087_5D5E421A 
X-CRM114-Status: GOOD (  18.42  )
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

From: Daniel Hodges <hodgesd@meta.com>

[ Upstream commit 0a1fc2f301529ac75aec0ce80d5ab9d9e4dc4b16 ]

The DHCHAP secrets (dhchap_secret and dhchap_ctrl_secret) contain
authentication key material for NVMe-oF. Use kfree_sensitive() instead
of kfree() in nvmf_free_options() to ensure secrets are zeroed before
the memory is freed, preventing recovery from freed pages.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### What the commit does
This is a two-line change replacing `kfree()` with `kfree_sensitive()`
for two fields (`dhchap_secret` and `dhchap_ctrl_secret`) in
`nvmf_free_options()`. `kfree_sensitive()` zeroes memory before freeing
it, preventing authentication key material from being recoverable from
freed kernel pages.

### Bug classification: Security hardening
This is a security hygiene fix for sensitive cryptographic material. The
DHCHAP (Diffie-Hellman Hash-based Authentication Challenge Handshake
Protocol) secrets are authentication keys for NVMe-over-Fabrics
connections. Without zeroing, these keys could potentially be recovered
from freed memory by an attacker with kernel memory read access (e.g.,
via `/dev/mem`, `/proc/kcore`, crash dump, cold boot attacks, or another
kernel vulnerability).

### Consistency with existing codebase
The NVMe subsystem already uses `kfree_sensitive()` extensively for
similar authentication material:
- `drivers/nvme/host/auth.c`: Uses it for `host_key`, `ctrl_key`,
  `sess_key`, `tls_psk`, etc.
- `drivers/nvme/common/auth.c`: Uses it for `key`, `hashed_key`, `psk`,
  etc.
- `drivers/nvme/target/auth.c`: Uses it for `dh_key`, `tls_psk`, etc.

The two fields changed here (`dhchap_secret` and `dhchap_ctrl_secret`)
were an oversight - they contain the same type of sensitive
authentication material but were using plain `kfree()`.

### Stable criteria assessment
- **Obviously correct**: Yes - `kfree_sensitive()` is a drop-in
  replacement for `kfree()` with added zeroing. No behavioral change.
- **Fixes a real bug**: Yes - leaking cryptographic key material in
  freed memory is a security issue.
- **Small and contained**: Yes - exactly 2 lines changed.
- **No new features**: Correct - no new APIs or behavior.
- **Risk**: Extremely low - `kfree_sensitive()` just adds `memset(0)`
  before `kfree()`.

### Remaining inconsistencies
Note that there are still other places using plain `kfree()` for dhchap
secrets (fabrics.c lines 1034/1048 for option parsing, sysfs.c,
target/configfs.c, target/auth.c) - but this commit fixes the main
cleanup path and is self-contained.

### Verification
- Read `fabrics.c:1282-1296` to confirm the current code already has
  `kfree_sensitive()` (the commit has already been applied to this
  tree).
- Verified `dhchap_secret` and `dhchap_ctrl_secret` are defined as `char
  *` in `fabrics.h:130-131` and documented as "DH-HMAC-CHAP secret" /
  "DH-HMAC-CHAP controller secret".
- Confirmed via grep that `kfree_sensitive()` is used extensively for
  similar authentication keys throughout `drivers/nvme/host/auth.c` and
  `drivers/nvme/common/auth.c` (18+ instances).
- Confirmed via grep that other dhchap_secret free paths still use plain
  `kfree()` (sysfs.c, fabrics.c option parsing, target side) - this
  commit is incomplete coverage but still valuable.
- Reviewed-by: Christoph Hellwig (well-known kernel developer and NVMe
  maintainer) provides strong confidence.
- The DHCHAP feature was introduced in commit `f50fff73d620` ("nvme:
  implement In-Band authentication") which was in v6.0 cycle, so this is
  relevant to stable trees 6.1+.

### Conclusion
This is a minimal, zero-risk security fix for sensitive cryptographic
material. It follows established patterns in the same subsystem, is
reviewed by a senior maintainer, and meets all stable criteria. The
security benefit (preventing key material leakage) clearly outweighs the
negligible risk.

**YES**

 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 55a8afd2efd50..d37cb140d8323 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1290,8 +1290,8 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
-	kfree(opts->dhchap_secret);
-	kfree(opts->dhchap_ctrl_secret);
+	kfree_sensitive(opts->dhchap_secret);
+	kfree_sensitive(opts->dhchap_ctrl_secret);
 	kfree(opts);
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
-- 
2.51.0


