Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AF3CFA747
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0ZCkaU4b3LRtOfKRzVYrWDpKmG/Intyrls11rwoypKw=; b=J/lUhhifgU6CkMLxG7kwb9/5F4
	kwjKaj8ohXkQSz+ZFCwYRBjrjbYyqMSKOabUy01xLpIDwBDYUuxO84EqT84c1UjDgMScjSH3dGCpV
	jYkFdXJxSCyawH89GHkUDDSKymmPHOWMe2EMM7+Nbi3vZn48P/+bpR2hIwXQUxtnSgNrZmso1lEjg
	OGfOeP87fsthJ+bFwWUv3yw52VpE9TrSP2kNhDTtmZiHrH3aNY9MypDfGurdu0BwraQKmtQ8LOMRR
	HXy5frxf4wvgDofFXO/kLkgIdBYGqeYIjXZMsOa9tvRJjOqO9VvpOgJGiCs2R5r51HyA6jS9YnGCV
	XgShAARQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLF-0000000824i-2hGe;
	Fri, 21 Nov 2025 08:18:05 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLD-00000008248-383G
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:04 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-2a45877bd5eso2695047eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713082; x=1764317882; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZCkaU4b3LRtOfKRzVYrWDpKmG/Intyrls11rwoypKw=;
        b=gBcJFB8eQnWGpyWyQoUAHb0xIBP18XUY4sjfWQS9fKEnihje1/SWFGLYC4rwEstQ2y
         vbpZaYJYV3xjfAhC6Zpz2LB8GzdB/xRbdO6fJIDdAL8KmlEOAqv1mgHO61HcKsTs5PUm
         NFDRKi3KkwEsgR977fXtZB+oQwOtGLwVNFAsFlhWtRej6yRZk0ZvzZSYKh27iNu7OZkv
         6B8wybkw514xJSCc12sMFxaF8pFV+Ii3q29ZKoY6uyiawOjhqKLSGGiMYNQSTVY2ijgf
         BPtGZTobWWKPczGQHMkZkucvfvHKQKComxm5LLInxpXIvQKo5pyUVFAQWmg5KeN4tfhq
         jtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713082; x=1764317882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZCkaU4b3LRtOfKRzVYrWDpKmG/Intyrls11rwoypKw=;
        b=wAPmOpagrfba9Y6bXZc2+XRzvc1kZlUCZ6606NtESL2QuOvmxDdbBETyoMeJ4lQPUA
         z0kPCn9ccLEcl0VfKQ2HT4c708kpGEC1pxyYA8lkA68SGbgcTLWzeWm/k7AH7rNaPD7c
         34NPac77GT4cbcp6xBnIfORu7oyF7AMkJrcpig1lhEcZ9Txu5sAr9Pt3m2mP++z3GRhr
         vWqVdVBD/ujO0Yf7uhhZKghgeV9hRekOFW/pz6WB9gkdPdRMK280xPM3MGN4pGUvoUDQ
         WBjvR2vQV4EAl/U/GhdPNREMfPkx/zaOHktsaeYGiaiJVpqwdZcTUka03towe4hJYWpi
         v6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHAL93EfhWiRf/l6UD08CN0QO6X2MMMhu0vO5MK7Tus7Tor01hwjGFAkTnVg31nrFgMucqf15jWHQM@lists.infradead.org
X-Gm-Message-State: AOJu0YwX9+uPfxe09kZfbSTOeheE95ZKYMREfB0D9BfhTahayAc1fwgw
	aXZAAxP7m+AFLDJ/ZeB6M4lslMBGwLo1Cs8BSgOT/kIYpKIo/EAJWvP/
X-Gm-Gg: ASbGncvwq9eeHrLTO2qMa42DffB4DG7dQpbqrG3eFQIBubhep+4SGQr2ivjRjH/g3et
	No4cH7XeeFrNV51Vkd8aQY5qC3k3XteTbo+TyRdJb/VPULtM8iF5Fg98vJ22MYRg//su17nFpLC
	HPyyeaz1RyfCMWlylQG7WnILsaifj2LNFTR7a69L4qVtxOMATSITtiwFlopTgprYJ2mGJ/JL/o8
	21dOxRRQm4pcgykbi1LJXhbCHGZV2iQojHN0BXdCBXxn/HXPf56DKpduqh8NQYFzKsbFQi++/n3
	lkvrXop1DldxYpO2WD5ZCJIODqclCSk+5ut87rn9QGcR8uIf4d9C8414PDoPz6nP4OydqxZjAbZ
	CtlVUV4RIMPqpMqg986FS2XNmpQVHtFGWWGby0p6vnhJRxdANsmzj1h+a48bB0+i6e1eWsL+i8/
	ErBN7corr8ZofrLlZK5IT2Mvd675Ckmr+W1ire
X-Google-Smtp-Source: AGHT+IE6TpNLTdqJhjkLhKVLohT6o1vUjYsRLYbuQCplrHZnwWvmxZgKeOeAEDl0LIesl5PjIoxoYQ==
X-Received: by 2002:a05:7022:4591:b0:11b:9386:a383 with SMTP id a92af1059eb24-11c9cabc7b4mr475750c88.22.1763713081645;
        Fri, 21 Nov 2025 00:18:01 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:01 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
Date: Fri, 21 Nov 2025 16:17:39 +0800
Message-Id: <20251121081748.1443507-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001803_789299_05EAE1ED 
X-CRM114-Status: GOOD (  13.13  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

Hello everyone,

We have recently encountered a severe data loss issue on kernel version 4.19,
and we suspect the same underlying problem may exist in the latest kernel versions.

Environment:
*   **Architecture:** arm64
*   **Page Size:** 64KB
*   **Filesystem:** XFS with a 4KB block size

Scenario:
The issue occurs while running a MySQL instance where one thread appends data
to a log file, and a separate thread concurrently reads that file to perform
CRC checks on its contents.

Problem Description:
Occasionally, the reading thread detects data corruption. Specifically, it finds
that stale data has been exposed in the middle of the file.

We have captured four instances of this corruption in our production environment.
In each case, we observed a distinct pattern:
    The corruption starts at an offset that aligns with the beginning of an XFS extent.
    The corruption ends at an offset that is aligned to the system's `PAGE_SIZE` (64KB in our case).

Corruption Instances:
1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)

After analysis, we believe the root cause is in the handling of chained bios, specifically
related to out-of-order io completion.

Consider a bio chain where `bi_remaining` is decremented as each bio in the chain completes.
For example,
if a chain consists of three bios (bio1 -> bio2 -> bio3) with
bi_remaining count:
1->2->2
if the bio completes in the reverse order, there will be a problem. 
if bio 3 completes first, it will become:
1->2->1
then bio 2 completes:
1->1->0

Because `bi_remaining` has reached zero, the final `end_io` callback for the entire chain
is triggered, even though not all bios in the chain have actually finished processing.
This premature completion can lead to stale data being exposed, as seen in our case.

The core issue appears to be that `bio_chain_endio` does not check if the current bio's
`bi_remaining` count has reached zero before proceeding to the next I/O.

Proposed Fix:
Removing `__bio_chain_endio` and allowing the standard `bio_endio` to handle the completion
logic should resolve this issue, as `bio_endio` correctly manages the `bi_remaining` counter.

Shida Zhang (9):
  block: fix data loss and stale date exposure problems during append
    write
  block: export bio_chain_and_submit
  gfs2: use bio_chain_and_submit for simplification
  xfs: use bio_chain_and_submit for simplification
  block: use bio_chain_and_submit for simplification
  fs/ntfs3: use bio_chain_and_submit for simplification
  zram: use bio_chain_and_submit for simplification
  nvmet: fix the potential bug and use bio_chain_and_submit for
    simplification
  nvdimm: use bio_chain_and_submit for simplification

 block/bio.c                       |  3 ++-
 drivers/block/zram/zram_drv.c     |  3 +--
 drivers/nvdimm/nd_virtio.c        |  3 +--
 drivers/nvme/target/io-cmd-bdev.c |  3 +--
 fs/gfs2/lops.c                    |  3 +--
 fs/ntfs3/fsntfs.c                 | 12 ++----------
 fs/squashfs/block.c               |  3 +--
 fs/xfs/xfs_bio_io.c               |  3 +--
 fs/xfs/xfs_buf.c                  |  3 +--
 fs/xfs/xfs_log.c                  |  3 +--
 10 files changed, 12 insertions(+), 27 deletions(-)

-- 
2.34.1


