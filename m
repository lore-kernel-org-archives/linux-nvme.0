Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B466CDB464
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 05:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fupJk9ycgxTR9K+qzkaB5UIJKdModxQ3EoXqNJbHRwk=; b=K2p0RICGMinK99onTYWWkWxemC
	kF9TI0zQoKqAAVFdOBueWfhNRePQaKRI+KF9qWiJbaDz66CihpCpShnFF7M1eBIUFdJSsRgClJsa7
	C+vyLIYf/Om4uzvrkDJ2dWUyrnR8xBcd5jkMsbgsS5ER3ffp8iJVM5s0LTyu3APnYmZ6t1KKKZuaq
	ZD0fgodMeS0VyvB+U23OnH4k1FWWOnaDiRP2Jzqp37XpxY1YtydafvEsRGoQnCLjb9z3ciDTLHRx6
	AfwlSEE2/98jt8LoDVAFiMr/+DhfblAvPjoUJA7yN5vXmnfyK38ziDBPzRfbzi/p1kf64yZnpWUmD
	MZ2Jf4MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmpW-0000000BcKN-1q27;
	Fri, 14 Nov 2025 05:58:42 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmpT-0000000BcJv-0Dib
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 05:58:41 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-29516a36affso16900995ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 21:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763099917; x=1763704717; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fupJk9ycgxTR9K+qzkaB5UIJKdModxQ3EoXqNJbHRwk=;
        b=BKNDFign1x/Jt53KHm60mAX7D7q1eDB6MPF/zwZrlTvu8WAaz6tEOv+bQB8cXDBK4f
         sMm9428TfyqH6bmrC5ls1FLCJgaMYQWEz5YXsHiGZO53Oo+aI5jFZjSUuRTJGkWfmF0R
         KqIbiRhx3y2wjxITa7j73QByW/v5xqnp1hoTZH9lB7mEds6tHCW/4PLsgeJpJ1ru/zaV
         YgAyZvzpvR/xIKIFE27d4nvi+TouMRvwiPAHV2pUzF1tP940gD/pV1kBQNUE2tIFe9jf
         evDzj/DB4KzWhhmQx8ENgc6uWpL0koyy/JXdqsVvvDPcwNDbc7rSaEavHPAlHIXkH+hA
         PIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763099917; x=1763704717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fupJk9ycgxTR9K+qzkaB5UIJKdModxQ3EoXqNJbHRwk=;
        b=gNx3eLsTj9npTk6vxySK9gRrOdKEGtrrIeOtYABvnm9mroO5EH2uIjUmun60e4AI0l
         uVxdL8N6G6ZA/Hdb1hSUx8amphjoZIe4+oSAVhChhPTE8AtuXztohRKDPWsDOLOSzs6V
         zh3A+FoWRk+hd3hG/0aJekEAq6D/6+kkD1Y+GEbY+2OiE6c5inGEFolGPtQD+1zZTYH3
         bxtDigwUmgmD9AFh2QLGiRvYpJ/lmIG7/Ib16NQHezB8FeaVooO4Lb3F+1SjfOVuRx6f
         Cfu3DF+q28sDC4/RFbhkF34K4DleqQhFpl7kBnZXhf1xi8N8sE8HVFQzExoSZNA/cJS2
         AW2w==
X-Forwarded-Encrypted: i=1; AJvYcCWbD99S1g2zvLa3THqsJwG+LexOxnKRj4icLT27qk7Fw/Ubsu8UYowxpuD8KdSEUMDiRQabJAp4i5EQ@lists.infradead.org
X-Gm-Message-State: AOJu0YywxX346DE+hYPwSR9QkJivE2egAbtmv14YwEun/h4t9wTVdCOn
	4JRZKDBREi9K5fk6E1TijdWqYRbmuEWD1aS3a1ZTj0Nmmo/aS5ahLMRFBxy28z4yEYs=
X-Gm-Gg: ASbGnctTaeNfd6Qit+jx86w6Ft1gjfXMUlkSGem6Jg+OHtnxL3k4XDY1dTqaPStk1x3
	LY4PBNhXgxeGEGHQ0vJqpdn0wDQKJx9PQTb8XMC780UVEiFpOqQ1+QvXXlydTrsc7YchKg4KbDf
	5CyAHLDASTZJOIC+vMY87tVE2m7+4dxzQWmiSC5Ysf4X8xRBfnDyjDHDNEqbIq6yR7QQdylKPfX
	IP9QtJAdEj37leMTgOftimXQKlLwwQF8xRUSB5Li3k5GDOC1qM/JvEEFhTvGX7Nwodph2zkILFY
	daNFJZlRsdp6q+n2byMFl1RgTqYuYvarylc0Fc6aluj8sq5SbxTcE1o55BtjKZoIDpJGCpdRUMm
	JPi95O99/kjJH3Uyq1Cy1jh6EPWT6FvPez7CvdQ+SttL2sOPo2gMvALtv+rY3zyrQnj3juq9Dr1
	MxdwizDvEAd01tzPzk29GoGS0k
X-Google-Smtp-Source: AGHT+IFojfSCG/W0M3Jt5J4Jz8XjM+U4I16pRFtTj2FRmRxZFPiZbCx8UawP3/kCmEgwqKCvZRSjlA==
X-Received: by 2002:a17:903:2f0e:b0:24c:965a:f94d with SMTP id d9443c01a7336-2986a741b6cmr18474075ad.46.1763099917503;
        Thu, 13 Nov 2025 21:58:37 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:22d2:323c:497d:adbd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2beb34sm43727825ad.76.2025.11.13.21.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:58:36 -0800 (PST)
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
	andriy.shevchenko@intel.com,
	david.laight.linux@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6]  lib/base64: add generic encoder/decoder, migrate users
Date: Fri, 14 Nov 2025 13:58:29 +0800
Message-Id: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_215839_349250_BF502A48 
X-CRM114-Status: GOOD (  10.40  )
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

Link: https://lore.kernel.org/lkml/20251029101725.541758-1-409411716@gms.tku.edu.tw/

---

v4 -> v5:
  - lib/base64: Fixed initializer-overrides compiler error by replacing designated
    initializer approach with macro-based constant expressions.

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
 lib/base64.c               | 188 +++++++++++++++++-------
 lib/tests/Makefile         |   1 +
 lib/tests/base64_kunit.c   | 294 +++++++++++++++++++++++++++++++++++++
 11 files changed, 472 insertions(+), 206 deletions(-)
 create mode 100644 lib/tests/base64_kunit.c

-- 
2.34.1


