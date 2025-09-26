Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23AACAC5AC
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 06:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t49lkyvPjjmG8vWQnPs19unibZLUCNGA1EtqRug4pDY=; b=eQOJy9lqqLATLpVW/FNNLOhsmf
	ilw408KWKF5N7h0+9Emq9SztMtiXTX9KMj3P1AF7UIfHXGUxHbNcxFoqNzREc2o5EjQBXu98U1rfx
	WbX/u3h2Bz3ArgXf9Wk/sKffopOboj63p4e0ZEvjZ4gX77yKxaUh0BZr/vGjK+3xbWXQP5vqySiME
	UqC3UYKXcWsojv+/vuUIJvNwszBiRCtn9ioYR+aEMlg7XqBFt0ji1XRpT+GFc6E3zbRHDFS6jP5+X
	tFDlqyKbtpwwFQ8lwrGz4ugcxh1DkT0KIfDM10I+M03CQnqaUmYjgNjDM75CdoaG5wr84vWmPLV90
	6s7GF02g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22K5-0000000GWGF-2WKG;
	Fri, 26 Sep 2025 06:52:53 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22K2-0000000GWFO-1ytD
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 06:52:52 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3322e63602eso2312233a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Sep 2025 23:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1758869567; x=1759474367; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t49lkyvPjjmG8vWQnPs19unibZLUCNGA1EtqRug4pDY=;
        b=cqJcBxlfWngGhVRD5u8rPPgi2EfOzXk/+VmMb0aw8pDe4LdSl2WDTidGrhgviezHuJ
         PcPgzx62rOnPcpt1b55mn/sASe3R5Ny5kZkr+wQOSuvhfWbT8CKLxhNhFKpNSZ5Px4ov
         6uv4jkIq016aBW/xR+tfnFYlpfkHvaZPK7fvKwBhfWXuFvMt1vDg7KXWSdi0S47lpqna
         GnCxnlbDCfMI18OfLltKdo9u8sluVxzlWrNr81948apdkWnnCgPq4YH5mSOyYysLevoi
         OHA6XKcLAqFLK+RDFEL162Gv+iqfZq8lAyN1hdcjuJQJlYkJtrhX4tshqKQa7MtGiTSs
         iMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869567; x=1759474367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t49lkyvPjjmG8vWQnPs19unibZLUCNGA1EtqRug4pDY=;
        b=RfaFY1QiVbXB1m3lhvBhoutHfHdPIC4kZi8ntnW77xhZt3OpbjLO8F2oxKpR3oY6iu
         0buaf4xyk6zaG1WjutaKnWnAwSE22w4eSN/6dZsab3Spzwgn0x0mHCdB9IGmGmxm4PP9
         r3J5GwjbDQbE5ZvLZ77l8LMH3p1z/KbsxNv/qx0tDIQ16fsnNUAreqAo7HJYzjfXnkiy
         WDgp3pqF4ruyckwN4GnwGUNCLc0peZ96E8Ucp7MlDxv1X8yZE29Du0Fysitm7mTXE9gb
         l0ZW+aZI1uZK/Vk0BdK7LDZ6wJNs6LnLpbao1vzlKNc3zPa7r0UlmJSiRjNE8MZAQjmx
         65mw==
X-Forwarded-Encrypted: i=1; AJvYcCW2UrwKE+1IyAhoubju7dtKVn59Y18GGJnACwQ/NYhBvogSJ3iOw5MVJZYbxxfXr70ckej5wW7JPZrE@lists.infradead.org
X-Gm-Message-State: AOJu0YxD7CpSU/PUfo80t+LEbNiE77RCTUlLE/4e+JHXLRZ+Wi5ia2/F
	Jinv2jGckOVAsiF72Mo4AbujWWw/KKTxd9VXaWqF+eqD+r294mcbuxbPSFggUhz2OAk=
X-Gm-Gg: ASbGncv+74k7EglItYmfiJ7oR7qKrM6P7mrjyYE9h164NPOW/xlbmIO5j0UqO8UWn3c
	+kGEhwUh2vjzbeBXW1xSwPdev2e6MmyJSLxGzSmYtYNJQhEBiw9PtNheGKWUa/aAC/nnEOO9Cao
	WGgL5h+r+BdlMP1AFLMio2q+o7ICkVo23j/3vNydN6uSHWj7Ku9VSSaRK2ZqJ5GJO1+vH/xhsxW
	XIWv8ywNnqcO7iWs8tB3KTQdDoJn2paTfXko/58JJx3z266bt+lwDoifVzJkXmyaWsFhUkboS7q
	987/KezBYLKC+fEXeQinCOkE89pzdIS8lYrOkbm/+CfAAO01zANSV1WeAnJDGIjDkZeCS1sXug9
	6Hd6oEM5YYT5UmTKU4pQTWG4LNAQhYLEsX+eRKH1fKkLpxjG2PXU+WZK5Ug==
X-Google-Smtp-Source: AGHT+IH/5rSRyxyzzwAVf8GtjSII3G3mtDPelN6ys1aTgI14FWVKkGLrFodstg9rym1zwY+fBiFhZw==
X-Received: by 2002:a17:90b:4c06:b0:335:28e3:81cd with SMTP id 98e67ed59e1d1-33528e38f06mr2280913a91.18.1758869567293;
        Thu, 25 Sep 2025 23:52:47 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:94ad:363a:4161:464c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2b76esm3556178b3a.102.2025.09.25.23.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:52:45 -0700 (PDT)
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
Subject: [PATCH v3 0/6] lib/base64: add generic encoder/decoder, migrate users
Date: Fri, 26 Sep 2025 14:52:35 +0800
Message-Id: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_235250_750986_71B1B85F 
X-CRM114-Status: GOOD (  12.41  )
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
by ~23-28x.

Thanks,
Guan-Chun Wu

---

v2 -> v3:
  - lib/base64: introduce enum base64_variant { BASE64_STD, BASE64_URLSAFE,
    BASE64_IMAP } and change the API to take this enum instead of a
    caller-supplied 64-character table.
  - lib/base64: add per-variant reverse lookup tables and update the decoder
    to use table lookups instead of strchr().
  - tests: add URLSAFE/IMAP checks (no '=' allowed) and keep STD as the
    main corpus.
  - users: update call sites to explicit variants (fscrypt=BASE64_URLSAFE,
    ceph=BASE64_IMAP, nvme-auth=BASE64_STD) while preserving formats.

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
 lib/base64.c               | 241 +++++++++++++++++++++++-------
 lib/tests/Makefile         |   1 +
 lib/tests/base64_kunit.c   | 294 +++++++++++++++++++++++++++++++++++++
 11 files changed, 525 insertions(+), 206 deletions(-)
 create mode 100644 lib/tests/base64_kunit.c

-- 
2.34.1


