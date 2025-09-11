Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CCBCAC587
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 07:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D81Vt79I/BTOBBePW6+0X1oh6zDyKaYVMRC1TVaQyRM=; b=JDc7TX1dgL2dMdNaqTdLSWeRkI
	MKrr2cwjiKIFrQyyhWSIyxwh3Ot215DXvNRRkVpjKYtZxLkGyNzoEDRplyjrTIg3nakt/pyViiF+8
	iVUFtk4CCjPj33nLMRp1Ft3ol5kL3WdAsr3mfX00EnM2CSMsKo838mjk6R+96CQSDJjrZ5sTPtsMW
	eJ8nfHPe43isVZX5w3W+C2pJUAaneSkKUGcCa+t0ACu8ZLulBOl+fDlYp4aN/lC92yWqjy1URGx+v
	axffX0eFyhGbG/0DPx05y3Ai52/KXL2HSOvaXzu10uWACl54N801N50ohT127npw2q9jmBa4M8Cjj
	XifJwqrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbkW-00000001Uev-3y2b;
	Thu, 11 Sep 2025 07:29:44 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbkS-00000001Ud7-0LA5
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 07:29:42 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-251ace3e7caso5134635ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757575777; x=1758180577; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D81Vt79I/BTOBBePW6+0X1oh6zDyKaYVMRC1TVaQyRM=;
        b=rVFxNjuA4fHPnCMI1GeSTy7qm0at61g/x7yehPxbLItfiKgcMjhLgeNo3746tqsZEu
         WcCWZBwmyHNbP70rwzx3HShFnIT/t+HkLDME4qq9tdoKGfLL1xP65BT3wjlH/jlAkKWc
         9BJ4zsJ9qJypQKLoNK8FitOa9LE7Le2H6J9kWJXfpgsVkr8u4n0tA1RuXeo7Zn3CSx6X
         Fh3fPu7w35ADI9UDfWYHhCD9lVsj+ct2cMoW52fAsvPrvfec8w4vggvNFQldty5j1E7t
         AvQuqeQ6Fu2xomm+GsId09t3dncFk7xWMlKTXVGcffrZEINBPkjj7N1vIuwXrGoRTEK6
         u3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575777; x=1758180577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D81Vt79I/BTOBBePW6+0X1oh6zDyKaYVMRC1TVaQyRM=;
        b=X/lTEAZR+XvrbzyLZdeREQJ4c838b/kt7NS41ko9JYrNUWuCevDcJ4kkSDiOuP1Vy7
         t6iELG8uYohJ/Muz9GuGwESWYOlVocI53TtMepaeGsFlYq9QXakUdEzrqtSLIKkMF+mF
         1jts0b6B+zO4tjbyEtVcxLAdYMBqAQZmS14QcNkiAxfkbN8bTRWPfxJ95ngYbfTVnepa
         dcB6DPLNWCyMKxhlVriMJf+d7BTvE4eYqtIzKiAy5YSjou5cxpX4JDGINLC/sTeo649D
         ePc3AnB0RN7xFITL8l9vPmEctQXmIYQetoqd2l4eIx93GQDWoo9nyr52k6nEfjk0idvB
         Muqw==
X-Forwarded-Encrypted: i=1; AJvYcCWWy/4xYmyPeq70/7uwQedEGZ8dWP5VSi9eA/8+v38gWXHRo5c5tq0mlVo0kPVZ5oUbqL8c+1rP01Zc@lists.infradead.org
X-Gm-Message-State: AOJu0YzjqZSOiJRI0mQ660uVlT8hJ7k3W8D8x3Td6smEa4fPNtLIkQCH
	FqOk2sJM9wHzj+K2RcPI7hj+2+pqFbBHlWqYt2CeFuAuXDXDCQr0mAx+GJ/JTLQI9ji5p20OWc2
	NwT+w+5g=
X-Gm-Gg: ASbGnct9eaFQS5glX72g3zdMtJg3lcqsiBBluTgCQL/birFDKiqCYMivm9IVs/J/eC2
	TUJEcEgNH7SUBpa8Jo3yEN731wuQYHjMig6QIYRlLcIXQeneV3vGX1A/ynin5iksuFPFpJjPRqN
	vWt65ekTwwzeJ5wZwLhEuADzpiSZjlcyUbGM/HLQZ+QWAuodpVJfu9SkUZZkmsARyoVOWx6wMqv
	qEfpTdfVJKSt7hPPASy4GpEew1E1HzUwF0oteQPf+DuN2OALaSjdRWOtq8LooDhfypm7IF6dwDB
	TOEukuJnElnhxNLBbX7hbfPMrzh0+r8EuM79H0EBkvyTBcSTjyqQ161/jfOg4WvsgI7nTvIiHbC
	GxCjIS8sxK6orHRXO1A8GQ/f7/A4xJx7eyRH9B5Qb0e2zf2/GnkCoIIG9Bw==
X-Google-Smtp-Source: AGHT+IHO7xlf6/5dPDqWynFAANB+M0UuBkmme6pcsf85zd3+cmkflA/c+A0enwc+u10nZW1Fv/oP5w==
X-Received: by 2002:a17:903:1111:b0:251:3d1c:81f4 with SMTP id d9443c01a7336-25173bbbab1mr288649825ad.54.1757575777526;
        Thu, 11 Sep 2025 00:29:37 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7811:c085:c184:85be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37293ef1sm9838395ad.41.2025.09.11.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:29:36 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	xiubli@redhat.com,
	idryomov@gmail.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	akpm@linux-foundation.org
Cc: visitorckw@gmail.com,
	home7438072@gmail.com,
	409411716@gms.tku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH v2 0/5] lib/base64: add generic encoder/decoder, migrate users
Date: Thu, 11 Sep 2025 15:29:25 +0800
Message-Id: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_002940_358865_1DA36274 
X-CRM114-Status: GOOD (  11.63  )
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

This series introduces a generic, customizable Base64 encoder/decoder to
the kernel library, eliminating duplicated implementations and delivering
significant performance improvements.

The new helpers support a caller-supplied 64-character table and optional
'=' padding, covering existing variants such as base64url (fscrypt) and
Ceph's custom alphabet. As part of this series, both fscrypt and Ceph are
migrated to the generic helpers, removing their local routines while
preserving their specific formats.

On the encoder side, the implementation operates on 3-byte input blocks
mapped directly to 4 output symbols, avoiding bit-by-bit streaming. This
reduces shifts, masks, and loop overhead, achieving up to ~2.7x speedup
over previous implementations while remaining fully RFC 4648-compatible.

On the decoder side, optimizations replace strchr()-based lookups with a
direct mapping table. Together with stricter RFC 4648 validation, this
yields a ~12-15x improvement in decode throughput.

Overall, the series improves maintainability, correctness, and
performance of Base64 handling across the kernel.

Note:
  - The included KUnit patch provides correctness and performance
    comparison tests to help reviewers validate the improvements. All
    tests pass locally on x86_64 (KTAP: pass:3 fail:0 skip:0). Benchmark
    numbers are informational only and do not gate the tests.
  - Updates nvme-auth call sites to the new API.

Thanks,
Guan-Chun Wu

---

v1 -> v2:
  - Add a KUnit test suite for lib/base64:
      * correctness tests (multiple alphabets, with/without padding)
      * simple microbenchmark for informational performance comparison
  - Rework encoder/decoder:
      * encoder: generalize to a caller-provided 64-character table and
        optional '=' padding
      * decoder: optimize and extend to generic tables
  - fscrypt: migrate from local base64url helpers to generic lib/base64
  - ceph: migrate from local base64 helpers to generic lib/base64

---

Guan-Chun Wu (4):
  lib/base64: rework encoder/decoder with customizable support and
    update nvme-auth
  lib: add KUnit tests for base64 encoding/decoding
  fscrypt: replace local base64url helpers with generic lib/base64
    helpers
  ceph: replace local base64 encode/decode with generic lib/base64
    helpers

Kuan-Wei Chiu (1):
  lib/base64: Replace strchr() for better performance

 drivers/nvme/common/auth.c |   7 +-
 fs/ceph/crypto.c           |  53 +-------
 fs/ceph/crypto.h           |   6 +-
 fs/ceph/dir.c              |   5 +-
 fs/ceph/inode.c            |   2 +-
 fs/crypto/fname.c          |  86 +------------
 include/linux/base64.h     |   4 +-
 lib/Kconfig.debug          |  19 ++-
 lib/base64.c               | 239 ++++++++++++++++++++++++++++++-------
 lib/tests/Makefile         |   1 +
 lib/tests/base64_kunit.c   | 230 +++++++++++++++++++++++++++++++++++
 11 files changed, 466 insertions(+), 186 deletions(-)
 create mode 100644 lib/tests/base64_kunit.c

-- 
2.34.1


