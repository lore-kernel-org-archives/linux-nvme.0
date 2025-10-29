Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A334ACCF9EB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 10:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MnA5k8KsoV1ze5vVhBRV2+hvyms9kuv5Kp74LGBGZE0=; b=dT2YwYO/bif2K9nWpiom5J8VcW
	e7yGXTIPMWXW6eIv23crpq3TCN+/IibZ9odEJOamR8KQyY9fyIKfJAGq7vkh2e/2IoAdY3BumwbYn
	EApoCmshid7pwc5mHdcfiPEozm+CFuwzKRfrI5t1pvUseexfMGCWMFX/VjL15+wf/2jTeEkUgkRXz
	wsnemgroh+dHU5CLmArvi9ppaU4UgxcNrafzI0+DAaWWFDqvY7NTxKDT021LHp+a1m7UmVJEjB7WV
	bh1V43xw7n05POfVGBeT8PJm44xw93t6rbCo6BLfFYoQg1l2o1mP10eHpX60Y9dQarz9z0buVS70N
	c8BDHhyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3Fx-00000000gwB-069W;
	Wed, 29 Oct 2025 10:18:17 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3Ft-00000000gup-3vlj
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 10:18:16 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so225386b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733092; x=1762337892; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnA5k8KsoV1ze5vVhBRV2+hvyms9kuv5Kp74LGBGZE0=;
        b=p7KJScMLA6ifcnnpHZwICUb/9uKowXQSnmSnMIknX+caPNW6ffpFbSDccFm+EKwY63
         bK6Wz0S/jy+N56YsHlDVRstqNVy9TBtCptI4GN7hV0XjZYCZj14j0qUTtWAbheVLS0RO
         AhjmVs+s+sozQqZNv/SPuuDIRBoaXRXpDGy9E/vmsVqSSJICnuKKpmV4PcZjkpqRNfrC
         Ijy10TlVu2sZpOFy9tj0xIBne0hg6vwk5SCxjEXjmFTzTY83dvCXyCapUwDVvuqI3m9D
         k9qmwNO+CoM6MMiyqW7toqMlTa6NczTjDmB8iE/UVglYrzRvRkQvVjJaMNERvIXt/HKc
         20WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733092; x=1762337892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnA5k8KsoV1ze5vVhBRV2+hvyms9kuv5Kp74LGBGZE0=;
        b=sUyx87id2bd7QfbLWVDmKM2eKZsFqupN6V1PYIFHDAQITSGDJG7EeNGv8hwvywpiZV
         GZ8ojrrBq39SvQPcLcVKm6rx305LC9nN6aMEcJs8+LK9gyFxxkDAggRoAThS8Wa0Nbn6
         EuFFu5oVigxOYvU2owoo+6sfnXprAnv+N6r/Kd+1qv2p6W9ULR3wcWDgGYzBY2XAeXYC
         YDE1WvKvteQ1RJWLN1v+rc+2NEPBhlhXrBZKZhWO8N+Dq3BoJbCnJ08NjZBe3EId/qWd
         nqwXckdQ6auBuHX8nC3d8LD49vKXE3wHmzIfcWYc3ypi033Nn3b0UaTrUzHAcjT/lZT4
         7qUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNE2Xj3hVYZtwKBGc9fU/nn0CIzAHg5j77lOuAQtSmVJHQYBJrxVs9BOh205QpOJWMGkjByzIhc0x8@lists.infradead.org
X-Gm-Message-State: AOJu0Yzo2Cy5KyccUVpvBvIBwg+pLyl4a8cD0SkEGFjWcLl8449IYHfm
	oNViOynnt0tvrYO+RRe3hBGVBMxi9GzZuYQEOGvT9o81F7uHf5AX2mYtWusbQXXud20=
X-Gm-Gg: ASbGncsF3I0SNwdq8ULByy87cCtbAVmlDkzAcLkPjhSnUFE+i+oJ24jK1xGO3NUVM8c
	3zvL5nInrsfxeR287Bf5uugkbV2dqh6mAvwf707HjQiCCQzIa1qtK12H1a1S3hQHjRmJvKJZd2X
	YGgybtbVV5KrpReoPmqzI9gQMiQPREIJOOFVqXbdzDE4Itn9V8SlEX5+WbP9NzduiJRqAhQvNgK
	3NjbzSRB+m7gbjhV2zDcLDtWfhsOfkT3FW4auZhg+OqVl5YaFeR2EWC4ILVDfz6JDCerCLjPs5T
	PXiAIr1kOd0kLWkrTpY7z4GgKUnGphPU8R/jVoXvE9i12alzk2XDfUz9j3roPcgmNByYytzVAQu
	PxcuVAV6MygANURiLVOgMFU7hFB5bfdLNtmBRYWJK7k7752WKxsM+zkuaNJZDkaXqu0UfKTJgtK
	lfEnpKRLshLMrhI1AR3VL71+vt
X-Google-Smtp-Source: AGHT+IG12NVk5cbJTGyTVKHLaQKC7YUnZ6JUn/xWRMCP6ZX7N2wYfe554nd/X6z1OGt87h+b+ioXUA==
X-Received: by 2002:a05:6a00:1785:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-7a4e2dfdfebmr2813190b3a.8.1761733092228;
        Wed, 29 Oct 2025 03:18:12 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a42aa5d9a6sm11080454b3a.62.2025.10.29.03.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:18:11 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: akpm@linux-foundation.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	xiubli@redhat.com,
	idryomov@gmail.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: visitorckw@gmail.com,
	409411716@gms.tku.edu.tw,
	home7438072@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate users
Date: Wed, 29 Oct 2025 18:17:25 +0800
Message-Id: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_031814_087975_69AFA119 
X-CRM114-Status: GOOD (  13.30  )
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

This series introduces a generic Base64 encoder/decoder to the kernel
library, eliminating duplicated implementations and delivering significant
performance improvements.

The Base64 API has been extended to support multiple variants (Standard,
URL-safe, and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes
a variant parameter and an option to control padding. As part of this
series, users are migrated to the new interface while preserving their
specific formats: fscrypt now uses BASE64_URLSAFE, Ceph uses BASE64_IMAP,
and NVMe is updated to BASE64_STD.

On the encoder side, the implementation processes input in 3-byte blocks,
mapping 24 bits directly to 4 output symbols. This avoids bit-by-bit
streaming and reduces loop overhead, achieving about a 2.7x speedup compared
to previous implementations.

On the decoder side, replace strchr() lookups with per-variant reverse tables
and process input in 4-character groups. Each group is mapped to numeric values
and combined into 3 bytes. Padded and unpadded forms are validated explicitly,
rejecting invalid '=' usage and enforcing tail rules. This improves throughput
by ~43-52x.

Thanks,
Guan-Chun Wu

Link: https://lore.kernel.org/lkml/20250926065235.13623-1-409411716@gms.tku.edu.tw/

---

v3 -> v4:
  - lib/base64: Implemented padding support in the first commit to address the
    previously mentioned issue.
  - lib/base64: Replace the manually written reverse lookup table initialization
    with the BASE64_REV_INIT() macro for cleaner and more maintainable code while
    keeping the same behavior.
  - lib/base64: Simplify branching and tail handling while preserving behavior,
    reducing overhead and improving performance.

---

Guan-Chun Wu (4):
  lib/base64: rework encode/decode for speed and stricter validation
  lib: add KUnit tests for base64 encoding/decoding
  fscrypt: replace local base64url helpers with lib/base64
  ceph: replace local base64 helpers with lib/base64

Kuan-Wei Chiu (2):
  lib/base64: Add support for multiple variants
  lib/base64: Optimize base64_decode() with reverse lookup tables

 drivers/nvme/common/auth.c |   4 +-
 fs/ceph/crypto.c           |  60 +-------
 fs/ceph/crypto.h           |   6 +-
 fs/ceph/dir.c              |   5 +-
 fs/ceph/inode.c            |   2 +-
 fs/crypto/fname.c          |  89 +----------
 include/linux/base64.h     |  10 +-
 lib/Kconfig.debug          |  19 ++-
 lib/base64.c               | 161 +++++++++++++-------
 lib/tests/Makefile         |   1 +
 lib/tests/base64_kunit.c   | 294 +++++++++++++++++++++++++++++++++++++
 11 files changed, 445 insertions(+), 206 deletions(-)
 create mode 100644 lib/tests/base64_kunit.c

-- 
2.34.1


