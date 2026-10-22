Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF758606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zOEqC3H7;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KINGNoTn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=2aB4n5jrJ+eDnutbPVSuTN4FJGF30ZBUQ83WroDaOXk=; b=zOEqC3H70oBXFrMQ7Vg6x7K2CK
	Mo5liGL+7dQydfEpRbcr9TZBdka+ckVBDcinpjS15AuBVOK48PBie2fCMHH81gFKYIStCXqSKJ3np
	feehu6hznT50s5y+6qzSuK0342qNXpGweJm7oIfQeVDR1l0uQKurdYASiMhGAcFipcAhz6r9eZYOn
	beGuhn2cauJ3FiKHvu/dFUjoJnhV528qsDmJi0vDGfacpIo36Ectxn2tWbIOsGFStzJeroQomsKAY
	jFBjGVeEbiQH66ZrI8wDUZEZ3VT5AIwlFoskJcplY50cT42eCAm9Y/gJdz4xYYwZABoctveZsDKZr
	ps9Jovog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsY8-0000000E8ox-3m71;
	Thu, 22 Oct 2026 13:09:40 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsY7-0000000E8oZ-0hLs
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:09:40 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso23472075e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674577; x=1793279377; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2aB4n5jrJ+eDnutbPVSuTN4FJGF30ZBUQ83WroDaOXk=;
        b=KINGNoTn8aYqi0AipDIJ0G2iZcfzT6TSyKr3w91mGyETJMjgzxXij+mXmIu094wHCv
         uJAvzNMwgw43pQ+k3fnk99nCCKqHjI+GhuTtAtB+TPbMx4mGMKn51xM6FmLwK2fJ5xbo
         iIJv/DVdi54T30eCHQJubx/MAWxCWrZ2Daegvlpx/zTHJT36c7Tq2uWFo0C/6zg5aeeP
         3+K3fF7ey0neFoplP65jHz9v/VMxeyLvVsTchtTIb314QTo0afpip1SZu9IRjlTEhVYO
         j2Fv6jh/COYFYjE10AMH8S/Th0r/EYdT20zzJ3jef/MEA6Hf1wjXbCLSuj5vVB12BK1d
         bxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674577; x=1793279377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2aB4n5jrJ+eDnutbPVSuTN4FJGF30ZBUQ83WroDaOXk=;
        b=l/zVDIB+TI8evlx6VfxXHcsqY0BGTPZsIuNKxVQn9tdEpo9+uFQLAB3S22KxIzIcAb
         eCRobRHQParqQejEGqRSFpZvGnqzxwywEo8x2zDVqZxNzTAPBmOKi4tkcCyemNWct+Mc
         8tazPn5Gx+V4II2jn/oVLDzcmh+T907pmhalsWEbD5MJTOq6BrfPf7qYNHnblbi1duyF
         /vR9vS/xj1rGHwUi4f2eEAGgxU2Z9o2iye8qCQq/LZAcG5mYWf5B+32Lyj/RfX9sG50w
         PvCypVBLxmcl01wu0/ADgoM2kK/pYcWffgtaReeLFKf/GYOosbT0u4ABlItauEGs+TSL
         y2OQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZTeq+SiVFZOddZwM9aeZPZVexp96PSVeDf3td7w83N7lkgpz08C31hHqeHcjhZAs+9qM++jFsIn6x@lists.infradead.org
X-Gm-Message-State: AFq9FYJlLCMF2u3c82Vp+De0ZTkDpH1bW4ckQMCD073ySsnFeKsYsxSv
	vNs8KDO/e4I33ynWJ72E9o9N5VfZHzbtov2iG0zBb98x1jvnj0GJfnP3
X-Gm-Gg: AYBFou2mwnFrCBh0ZU0ZoEwb1jHIg1XTAutizGs5M/rmJx3I9iwIlURutf5pfP42QTU
	eOrKsjdvETB27hhtkbdmOQYj9UoBaCfqAJpoS7h4LxrnXrezYZLNjxBJuVxqZGUKQn5jkntnDnm
	fuILGr+tK/bgB8+V1yoL40JD+xeS0J1OPse7kMPapVcH1pl+VXmjxrClkAVHWmOWoU710WuwAfr
	eQWMhg/wmkoaMLbDtTn9jh2j6r9htvBQPwEq/6ocY8mVZ7XWXL+YtN0ESjtkKVGR81uNzRW5wEL
	yU0SnKiS+hpCxWTQ7tdkZ7gCUxufgHP5m0plU4eWxL3whvp4WqRwPFsLZFUrSbdzfqP7bL/Pitc
	ATVqaa8+R0vIOBhcHJmQTr3inzti+Mip1eHYNeVHYZ4qfF8YqnWbnCYFn1H8c0rjkUZu17XZriQ
	l5MqSmhNN8vAc2iVGG+YCaZg6pRJsG1yQyhLeAncCgNPq1Sn50Omd2sf9flsXBriOygJc/qkxw9
	CpiXv/TMot91pF65Uey+g6gG9wkJe8Nw/WD0gJF3TgE+2Av/TQscWe8852oe3BSYn9ClAwUkS4Y
	Q+WY+Cw712BVL/LZeCmYJT+Q
X-Received: by 2002:a05:600c:3e14:b0:4a0:174:579e with SMTP id 5b1f17b1804b1-4a1fdd517f2mr102306365e9.28.1792674576373;
        Thu, 22 Oct 2026 06:09:36 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:35 -0700 (PDT)
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
Subject: [PATCH blktests v2 0/4] nvme: add nvmet zone report and FC regression tests
Date: Thu, 22 Oct 2026 15:09:20 +0200
Message-ID: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_060939_244010_0AFC80BA 
X-CRM114-Status: GOOD (  14.31  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add regression tests for three nvmet bugs fixed by the kernel series [1]:

  nvme/072  "nvmet-fc: only send read data for successful commands"
  nvme/073  "nvmet: zns: don't leak stale memory in zone management receive"
  nvme/074  "nvmet: zns: reject a NUMD whose byte count wraps"

The nvme/073 fix is already applied to nvme-7.4; the other two are still
under review.

Patch 1 adds the zoned null_blk target setup, cleanup and zone report
status check that nvme/073 and nvme/074 share.  Patches 2-4 add one test
each, with a small C helper for nvme/072 and nvme/073 where nvme-cli
cannot express the check.

All three tests run on every configured transport.  On a kernel without
the fixes, nvme/073 and nvme/074 fail over loop, tcp, rdma and fc, and
nvme/072 fails over fc, the only affected transport.  All three pass
with the fixes applied.

Tested in virtme-ng VMs over loop, tcp, rdma (rdma_rxe) and fc (fcloop),
on v7.3-rc4-108-g551c722f4080 without the fixes and on nvme-7.4 with the
v2 kernel series applied:

                   loop  tcp   rdma  fc
  unpatched  072   pass  pass  pass  FAIL  failed Identify transferred
                                           4096 bytes
             073   FAIL  FAIL  FAIL  FAIL  stale report bytes, and an
                                           8192-byte transfer for NUMD
                                           1023 not rejected
             074   FAIL  FAIL  FAIL  FAIL  NUMD 0x4000000f not rejected
  patched    all   pass  pass  pass  pass

Changes since v1:
- Renumbered nvme/071-073 to nvme/072-074, since nvme/071 is now taken.
- Patch 1: configure nullb1 instead of nullb0, and drop the
  _init_null_blk() call, so that the helpers also work with a built-in
  null_blk (Shin'ichiro).
- Patch 2: rename _identify() to issue_identify(), and drop the
  namespace read, which only served as a control, together with the
  file backing it needed (Shin'ichiro).
- Patches 3 and 4: use _have_null_blk instead of _have_module null_blk,
  and read the nullb1 attributes in patch 3 (Shin'ichiro).
- Rebased on current master.

v1: https://lore.kernel.org/r/20261014170046.2516-1-parri.andrea@gmail.com

[1] https://lore.kernel.org/r/20261012141239.156408-1-parri.andrea@gmail.com

Andrea Parri (4):
  nvme/rc: add zoned null_blk target helpers
  nvme/072: test that nvmet sends no data for a failed read
  nvme/073: test nvmet zone report initialization and length
  nvme/074: test that nvmet rejects a zone report NUMD that wraps

 src/.gitignore           |   2 +
 src/Makefile             |   2 +
 src/nvme-sentinel-read.c |  89 +++++++++++++++++++++
 src/nvme-zone-report.c   | 165 +++++++++++++++++++++++++++++++++++++++
 tests/nvme/072           |  72 +++++++++++++++++
 tests/nvme/072.out       |   2 +
 tests/nvme/073           |  68 ++++++++++++++++
 tests/nvme/073.out       |   2 +
 tests/nvme/074           |  46 +++++++++++
 tests/nvme/074.out       |   2 +
 tests/nvme/rc            |  58 ++++++++++++++
 11 files changed, 508 insertions(+)
 create mode 100644 src/nvme-sentinel-read.c
 create mode 100644 src/nvme-zone-report.c
 create mode 100755 tests/nvme/072
 create mode 100644 tests/nvme/072.out
 create mode 100755 tests/nvme/073
 create mode 100644 tests/nvme/073.out
 create mode 100755 tests/nvme/074
 create mode 100644 tests/nvme/074.out


base-commit: 9ad5a10fa8ed56f74c23fea2c35f4594a110b8b9
-- 
2.53.0


