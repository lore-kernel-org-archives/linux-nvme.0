Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280A3FF8850
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 00:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hlYyxAHFErN0O8bIJbsJS4BCeC/JRIpc/oeR+h/cS4M=; b=yTX86U07BW8MxS0DTOjYjwri1U
	/nrRKMyX1Ug86FtvhuzM2E/ypGQwU3pYl+Scf72OQx/uqHn11rhDK14j1iqrI++GMwic1qZOTRj4e
	NmG8j3UgYpO/7O4gfJHJmlvDUEelOPtuZH6TBGW05g/FIDDoi0SBwMs4P6gOs5WwbbeMDWdzIwOMS
	gVbCW/eG9nDUgzlCpAxmFA3ShFzbV21D12K4hkVWbjgrqKnPZ8f73YpfkgvedrCnM7niCdP2ItQKm
	EuejWapAUi4g5cuPNlJtuEKzb5/l3e2gPX0WEmPuymIp7xgmVxessYhUNjlavvhj3qUqNMvuQAh6w
	UVpDAXwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH9wY-0000000FyJZ-1eYx;
	Mon, 27 Apr 2026 00:35:22 +0000
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH9wT-0000000FyJC-1j5p
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 00:35:18 +0000
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-56f6afbd205so4681793e0c.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Apr 2026 17:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777250115; x=1777854915; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlYyxAHFErN0O8bIJbsJS4BCeC/JRIpc/oeR+h/cS4M=;
        b=mWfOZS8UbDdfMH8/Gby/RJcOv/TYVin0CnsjLr+oRvRrTjpHj3fUeoZA8/vEfPoV36
         36Pt0SPX8wQdwCDHYBj+aOV+Cr19DeQal6U+Oz768AJi8bHbHzNGmFFOf7DOfdqapph0
         +kT2B9cjuplE1h+801nIPdp/XXJGg1IZ8o5HWp2dpgPmW+JORekAYH6w3zKdqbMdgxSE
         MNYUpkteuYINRFBC5khsO93oNZK+ZH3GESYXPfc00+rtVMdNKwkk4gkPBvoi1aIV3D30
         tmPfsxLnKkXvo1kTvmbCtes0k7TiAQAKAMSEAkf6zssZwvty8vuYaw5ZjkcN1aOYDNu6
         7lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777250115; x=1777854915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlYyxAHFErN0O8bIJbsJS4BCeC/JRIpc/oeR+h/cS4M=;
        b=Da/Ah87lJ05/NUMR/VPKLBwJdx/33znygsxAcY3h6sb15WBuSk+1iJlLOus+/FOB/e
         /sDbaHzhvnGl7LEiqbTA1ULN4McCclLC/d2TE4YqClXqHfgbe6NqKUoURIlEk+ljjTaZ
         +wNF1B7Z0xPq6hctlelSaafJIrJIKW71upCM2QYM/uCaSSp77zS8pyW1+PyzQTr02jLn
         0OT8SpwKZJC+zjXxQDtdRk0VwD3jRqsl8ggD7Su8BPgJ2VqL9dZqIfNi1Hr2PUzgqvFu
         pHp63Eoyld50eIBg/alStgadpOn81wPHewTqhck+gtX47a154GIxVJCX7+MRVQYkZwCG
         9B1g==
X-Gm-Message-State: AOJu0YxSsS3VbOHFE2OkutZXMN0FZ80qCe1okoKgeT7acVf0JXQtenM/
	K5iBSkLCFuckJ0HdqxDwfdjobkVuki/T48778KuFcVwVUPySOjIgrpVRrlxtUa8M+T8=
X-Gm-Gg: AeBDieuxR9vGNcMGL8A0g1gHBrM+qB4sNUvyaSeXHojeEPeciJOo8C7jvYpFVUSJEbD
	BVpFZzWhns/jUl//WoLzWImH5+itUEJwqcqM4+oYdzXQHya7FQ8A0qGCW4H46EfqtXgkKEGQY6g
	JbUMkfYTMTPmgxJjZ2SXXTw2fBqvNOxhzzN8IKBTgO8KYM/sW2pEI/pL9qH7rsCVHLMG41aCsWT
	gB6jhnd9LWQ+6YQ5Pi8MMoX20UOnKPcB5i/4OI9eV31k3WHkh4evFC2jToSP69uEubGma8rtvvD
	tpW/bBFtCKFpuJTGju7RCU2BYJOURjrODaMRwLvNgeD/X2bSScRixZpJSLFKwp4Uhr0SsC1Rjc1
	CRcl/J64xLGuBJjtgQZMD911+GyXdyWrZGPxJUHkhNpFq1ilw2v4KsE8i/zcwecwLivm1i6tcyY
	ofhwCJre3SUd/GBIu49vHIAbbcxwSvTRINv86+xoZmDvm8bImBZm8/
X-Received: by 2002:a05:6122:8f87:b0:56b:8ba0:fd58 with SMTP id 71dfb90a1353d-56fa66be43fmr14917079e0c.6.1777250114838;
        Sun, 26 Apr 2026 17:35:14 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa9351ca8sm16854880e0c.18.2026.04.26.17.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:35:13 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Date: Sun, 26 Apr 2026 20:34:56 -0400
Message-ID: <20260427003457.1264511-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260426_173517_494863_31AC6E05 
X-CRM114-Status: GOOD (  14.21  )
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

When an NVMe namespace is configured with embedded metadata (flbas bit 4
set, NVME_NS_FLBAS_META_EXT) but no Protection Information (dps=0) and
no NVME_NS_METADATA_SUPPORTED, nvme_setup_rw() fires WARN_ON_ONCE on
any request that reaches it with REQ_INTEGRITY unset.  The WARN was
observed repeatedly during NVMe fuzz testing with a FEMU-based fuzzer
that performs semantic mutation of Identify Namespace responses.

The trigger requires three conditions to align: (a) a namespace
transitions through the EXT_LBAS non-PI state (head->ms != 0,
features & NVME_NS_EXT_LBAS, !(features & NVME_NS_METADATA_SUPPORTED)),
(b) nvme_init_integrity() returns false through the early-exit branch
at core.c:1834 without populating bi->metadata_size, leaving the disk
without an integrity profile (blk_get_integrity() returns NULL), and
(c) a request that was admitted to the block layer before the namespace
update reaches nvme_setup_rw() after it.

The admission gap arises in two places.  First, the plug-list flush
path: a process with dirty pages queued in a plug before the namespace
update flushes them on file close (blk_finish_plug -> blk_mq_dispatch
-> nvme_setup_rw), bypassing any capacity-zero gate.  Second, the
cached-rq path: blk_mq_submit_bio() at blk-mq.c:3155 may find a cached
request; if so, the bio_queue_enter() freeze-serialization guard at
blk-mq.c:3174-3176 is skipped and the bio is dispatched immediately.

In both cases the bio was submitted without REQ_INTEGRITY (because
blk_get_integrity() returned NULL at dispatch time, so
bio_integrity_action() returned 0 and bio_integrity_prep() was not
called), and it reaches nvme_setup_rw() for a namespace where
head->ms != 0.  The existing BLK_STS_NOTSUPP return correctly handles
this dispatch; the WARN_ON_ONCE is a false positive.

The WARN was reproduced six times over four days of fuzzing (April
2026).  A representative crash shows the plug-flush path:

  nvme0n1: detected capacity change from 2097152 to 0
  WARNING: drivers/nvme/host/core.c:1042 at nvme_setup_rw+0x768/0xfd0
  PID: 785 (systemd-udevd)
  Call Trace:
   nvme_setup_cmd / nvme_queue_rq / blk_mq_dispatch_rq_list
   blk_mq_flush_plug_list / blk_finish_plug / blkdev_writepages
   sync_blockdev / bdev_release / __fput / sys_close

Replace WARN_ON_ONCE with pr_debug_ratelimited so the condition is
logged at debug level without splat.  The BLK_STS_NOTSUPP return is
preserved; I/O to the transitioning namespace is still rejected.

An alternative approach that addresses the root cause at the
integrity-profile level is proposed in patch 2/2: populate
bi->metadata_size for EXT_LBAS non-PI namespaces in nvme_init_integrity()
so that bio_integrity_action() returns non-zero, bio_integrity_prep()
sets REQ_INTEGRITY, and nvme_setup_rw() never reaches this branch.
Both patches are sent as RFC for maintainer guidance on the preferred
direction.

Tested: Compiled on linux-kcov-debug (6.19.0+, KASAN/DEBUG_LIST).
Boot-tested under FEMU with NVME_MALICIOUS_RESPONDER=1
NVME_SEMANTIC_DATA_MUTATOR=1; ran 4 concurrent dd processes plus 500
rescan_controller cycles.  No WARN, BUG, or Oops observed.

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d1711ef59fb..4e20c8f08e4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1039,8 +1039,12 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
+			if (!nvme_ns_has_pi(ns->head)) {
+				pr_debug_ratelimited("nvme: %s: metadata (ms=%u) without PI or integrity request, returning NOTSUPP\n",
+						     ns->disk->disk_name,
+						     ns->head->ms);
 				return BLK_STS_NOTSUPP;
+			}
 			control |= NVME_RW_PRINFO_PRACT;
 			nvme_set_ref_tag(ns, cmnd, req);
 		}
-- 
2.43.0


