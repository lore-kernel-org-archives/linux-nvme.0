Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55924C3DA7A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QOBgvIN3PYDY+cIEwUK+qMtv/Bkt+tCopG81B61mV0c=; b=SIKWMP4NgrmfO4d2/ZpaxkHXT/
	3S1Bkl1RRPNn4IxCSbrsypf9sy1mroI+8qaj1eQHTLie3KGputY08bVa2c70CilKkMCRaOs4sEHPl
	yCEGrib7Mbtc49odQVVMKyylcmcVpvw4cplwx7nDAd3koku5LBo2NtbWQpTutgXA4vMGr5Uy9iVcj
	mD6rFbiryEkLZVbVNfYhRNkdDIiu5LbbqWxknQcNYMztp+nVZ13BZwwwoRmcaNT0ikeyjKkNgVqMb
	h0To1vrB3WQkLGki44NJKiuCdqfDjTXkHsx594+58A5n4aon9yDOr+Hk7/hhOozC7uLb9D6GA5dpO
	s+Wm6ZqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2Lb-0000000G37z-33Nm;
	Wed, 14 Oct 2026 17:00:59 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2LX-0000000G379-32f6
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 17:00:57 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso41178765e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997254; x=1792602054; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QOBgvIN3PYDY+cIEwUK+qMtv/Bkt+tCopG81B61mV0c=;
        b=RTSnCzmlrL16ZObYrIJX/4lixEd7ZiVNHVqqLXiRzIPlZ4iBZct3IEQ3vC5ztNs8kx
         /zBxLkAYxmpp7yfb5UoR9jalW8cctFlMTXdZ7UcMezKg43Nr2odTSad56ACxcSkwvfTE
         0qJ4KhNzNuqF987nrvQIZsixwIE6nOD1uUgj2/XdvoO6gYRzwb3Y/r5W8ZJ+GsxxIRLQ
         oC522Hxwu0zlNiykJsSBWSjatsZwCAGzcnumn5nXUzZZM571R6mXUWm3V/UGwug0llrW
         kJVYaBl+n3vcKXJwGgb+/ze65bbEE0GKRO8FcABXFejyGn33UBbKlLcEZekt/3ksMk8k
         SwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997254; x=1792602054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QOBgvIN3PYDY+cIEwUK+qMtv/Bkt+tCopG81B61mV0c=;
        b=kiiTtBmynivtIptzoQVkeVre/YYqXriYaejdZqmLIa/xKEnH7LrZTd86fXTPRQueKg
         GGkU4BJObPjMhW5ORwfJwr3+BYoVLwPa6vXgBm/jhDOv0FisMip3pwZV6N447M3Lx2hn
         6aQ5rfxjSy/dqgv7XPK3cuvvfsHD/74XtS2d6YQx2z8HpCRDYUmnORBZMhjXXkKq+wT5
         evlXJ0Oof8tqR3dMT50lknzWQGt0b6fxSpvtYjLLLS+d+zL34fJlIIVuF+W1DkL/HMWj
         5JsB4ciHsL8QBGlEfe8Yyqo7siDlQil9QF3k0vWgwiDD+a2dvRH6Qc4D/jXo8eTRr9x6
         cTkw==
X-Forwarded-Encrypted: i=1; AKwUvByKfQPHsPx4tfmmn/iPQPl+eTkObysm65F5LZuWFFw5M9hJJOiwUndk3Xc4ARi5gf4voRgHGLNN2xGN@lists.infradead.org
X-Gm-Message-State: AFq9FYIKN2h/Ku7X0OQv1DCHO++YfRWhy990UA86YeD6NAXzRNoY7a2X
	OF4jC3xhM8uFMuB7r7B9vZFNclYAK+gM9uEVblBZ6CCXDJMsYS6/VtFU
X-Gm-Gg: AYBFou2SYI1zDeLxdwvaBw6NOoyv1EnVzvFB8jODBHhxSpulBI2I28U+0zSqcl9qoBG
	W/YBvf8M9EjNBVPS2Cw6K/HlGGwnecksER0cKvkYl92T3LhcP8OQp//nBXonFB2sthXQ2JrwKnn
	QpulMNnr7/Ob5qWENeLK8GYJ2cZFNneJYqYJ9QpbeXidR82dQULIcSXBS/OzssIlhn8dk0bzJnz
	hcPq77liRd0MJ0rQD4CpYqH04beqSDPHALxgVhyILfNQ3wtEh76nfNlKGAGveTCYMC4Y+/BEVC6
	lsphsK/wxrob1M4wOcyBuRVtBGX0ZC8+/CO9jZCfhR6pn2GsJlhJz8Bdjru8CZsXtj4JlMvGSEZ
	9S/9RNafugt2XWHhVtX1gVuJP2ugA9u6RPvYGG6tSFvv2+2n39fWyDn8H6oydIKpceEoHgd/Xl1
	7pSN8wu6p+E6KaBReYy4/4NsWuGmTzuXRrcivIuaCyidB3Pt59E/NqFfbkNwqALZlSmuZf+Mo/u
	l3PSMSc6lY8Yb6v6+4PPIFlypRBTHF297Qrhbh4FrCgsQ==
X-Received: by 2002:a05:600c:609b:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4a18e4ca1dcmr313482265e9.18.1791997253716;
        Wed, 14 Oct 2026 10:00:53 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm5349415e9.5.2026.10.14.10.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:00:53 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests 0/4] nvme: add nvmet zone report and FC regression tests
Date: Wed, 14 Oct 2026 19:00:37 +0200
Message-ID: <20261014170046.2516-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_100055_797817_A2176FFB 
X-CRM114-Status: GOOD (  12.97  )
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

Add regression tests for three nvmet bugs fixed by the kernel series
"nvmet: fix stale data exposure and ZNS validation" [1]:

  nvme/071  "nvmet-fc: only send read data for successful commands"
  nvme/072  "nvmet: zns: don't leak stale memory in zone management receive"
  nvme/073  "nvmet: zns: reject a NUMD whose byte count wraps"

The nvme/072 fix is already applied to nvme-7.4; the other two are still
under review.

Patch 1 adds the zoned null_blk target setup, cleanup and zone report
status check that nvme/072 and nvme/073 share.  Patches 2-4 add one test
each, with a small C helper for nvme/071 and nvme/072 where nvme-cli
cannot express the check.

All three tests run on every configured transport.  On a kernel without
the fixes, nvme/072 and nvme/073 fail over loop, tcp, rdma and fc, and
nvme/071 fails over fc, the only affected transport.  All three pass
with the fixes applied.

The tests take the next free numbers, nvme/071 to nvme/073.  If other
nvme tests land first, I'm happy to renumber them and resend.

[1] https://lore.kernel.org/r/20261012141239.156408-1-parri.andrea@gmail.com

Andrea Parri (4):
  nvme/rc: add zoned null_blk target helpers
  nvme/071: test that nvmet sends no data for a failed read
  nvme/072: test nvmet zone report initialization and length
  nvme/073: test that nvmet rejects a zone report NUMD that wraps

 src/.gitignore           |   2 +
 src/Makefile             |   2 +
 src/nvme-sentinel-read.c |  89 +++++++++++++++++++++
 src/nvme-zone-report.c   | 165 +++++++++++++++++++++++++++++++++++++++
 tests/nvme/071           |  80 +++++++++++++++++++
 tests/nvme/071.out       |   2 +
 tests/nvme/072           |  68 ++++++++++++++++
 tests/nvme/072.out       |   2 +
 tests/nvme/073           |  46 +++++++++++
 tests/nvme/073.out       |   2 +
 tests/nvme/rc            |  61 +++++++++++++++
 11 files changed, 519 insertions(+)
 create mode 100644 src/nvme-sentinel-read.c
 create mode 100644 src/nvme-zone-report.c
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out
 create mode 100755 tests/nvme/072
 create mode 100644 tests/nvme/072.out
 create mode 100755 tests/nvme/073
 create mode 100644 tests/nvme/073.out

-- 
2.53.0


