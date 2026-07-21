Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343CEC44532
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EsXD0NNw+hCO8jhrbYSt/sSNSXA2mVOBq4GloqJETrI=; b=DmHpnHcHzjZ0F0pghqMpPENOVl
	+o4REcJ54j7169+hj6TY8DqhV8jCO0PU1qV9MILREGR9eD/TlsmSGHedmaiwIV/y50Cw9klvJzTzs
	7otW0Sn0rKWiFOP2ddCNtNRNbPMdv2vHwciDPrSpp/94TgwyEOEUaB1owHHFxB2BeIl+q1H8lWh40
	p90BGZqZsWMbHb4MBKSWK6jfv0Dx+0HG+20pSzItU0dMfw3+wmtRa1WF03Tis2p3pJ21WYgB5MniG
	GhfQY1j3SgW5q7nIVDMmb2JuedDIPxxLzZ/A2M/QlYV3BWX4x6ozFdxWeAchOTzir0O76ZFyAWfuq
	R+Y0hbjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmB7x-00000009bwj-2Cyb;
	Tue, 21 Jul 2026 14:07:21 +0000
Received: from mout-b-206.mailbox.org ([2001:67c:2050:102:465::206])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmB7v-00000009bw3-0r3t
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 14:07:21 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4h4K2R44CPzGv;
	Tue, 21 Jul 2026 16:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1784642831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EsXD0NNw+hCO8jhrbYSt/sSNSXA2mVOBq4GloqJETrI=;
	b=pvZPYiiIDsnTHVuT31C3+it9mh76wChzFc+GJSQDJu89xKcAYRzB4D/56H5c2BNV/518r2
	0PDuAD9hLVSHuy5NCwC11VWqz7cyNwWyfeK1endov/ftTRZO2RNVpJElEpvfUC4SnkB5XE
	U5l2aWEYUybw78SKfiq9aFCBaj0CFKnELw6Cp3Ym06yCBJ2UxOSYYaDqznCBy/+ILzwEk5
	ME5dTiWNF/EQj9QAXtvg/HODvjGVi6sKlKcG3CEDzX9Y+yUcquzrfLeURCduJO9bAA26vs
	2VOZbRUTw2aEPejpMxeAWGrd7FcV2crYZ8hmTYSqVL7NTVu46G40vfG0H745pQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	ebiggers@kernel.org,
	Jason@zx2c4.com,
	ardb@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-fscrypt@vger.kernel.org,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	linux-nvme@lists.infradead.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	antonio@openvpn.net,
	sd@queasysnail.net,
	linux-kernel@vger.kernel.org,
	Marco Baffo <marco@mandelbit.com>
Subject: [PATCH 0/5] lib/crypto: add HKDF and convert fscrypt and NVMe
Date: Tue, 21 Jul 2026 16:06:39 +0200
Message-ID: <20260721140644.780006-1-marco@mandelbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4h4K2R44CPzGv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_070719_680685_08A6D093 
X-CRM114-Status: GOOD (  11.62  )
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

fscrypt and NVMe authentication each carry private HKDF
implementations. Add HKDF-SHA256, HKDF-SHA384, and HKDF-SHA512
functions to lib/crypto and convert both users.

Patches 1-4 are intended for review and inclusion.

Patch 5 is RFC only and is not intended to be applied. It shows how
the OVPN epoch-key code currently under development can use the new
HKDF API. That patch has an additional dependency on the OVPN epoch
series. It is included here to allow the API to be reviewed against
a third user. The OVPN conversion will be submitted separately once
its prerequisite code is ready.

HKDF-Expand accepts info as an array of segments and processes them as
if concatenated. This preserves the byte ordering used by fscrypt and
allows NVMe to encode HkdfLabel without allocating a temporary buffer.

HKDF-Extract produces a prepared HMAC key, avoiding repeated key setup
when the same PRK is expanded more than once. The implementation uses
the direct HMAC library functions and neither allocates memory nor
returns errors.

The series is intended for the libcrypto tree. Patches 3 and 4 need
review from the fscrypt and NVMe maintainers, respectively.

Tested with:

- HKDF KUnit tests
- NVMe authentication KUnit tests
- kvm-xfstests smoketest on ext4
- kvm-xfstests generic/582, generic/583, and generic/584 on ext4 and f2fs
- kvm-xfstests encrypt group on ext4 and f2fs

The following shortlog and diffstat refers only to the first 4 patches.

Marco Baffo (4):
  lib/crypto: add HKDF-SHA{256,384,512}
  lib/crypto: tests: add HKDF KUnit tests
  fscrypt: use HKDF library functions
  nvme-auth: use HKDF library functions for TLS PSK derivation

 drivers/nvme/common/auth.c    | 120 ++++++++-------
 fs/crypto/hkdf.c              |  56 ++-----
 include/crypto/hkdf.h         | 131 ++++++++++++++++
 lib/crypto/.kunitconfig       |   1 +
 lib/crypto/Makefile           |   4 +-
 lib/crypto/hkdf-sha256.c      |  22 +++
 lib/crypto/hkdf-sha512.c      |  34 +++++
 lib/crypto/hkdf-template.h    |  97 ++++++++++++
 lib/crypto/tests/Kconfig      |   8 +
 lib/crypto/tests/Makefile     |   1 +
 lib/crypto/tests/hkdf_kunit.c | 276 ++++++++++++++++++++++++++++++++++
 11 files changed, 653 insertions(+), 97 deletions(-)
 create mode 100644 include/crypto/hkdf.h
 create mode 100644 lib/crypto/hkdf-sha256.c
 create mode 100644 lib/crypto/hkdf-sha512.c
 create mode 100644 lib/crypto/hkdf-template.h
 create mode 100644 lib/crypto/tests/hkdf_kunit.c


base-commit: e4f23159c8d09b6b15d47f2c95e0a3e7c62f52a2
-- 
2.43.0


