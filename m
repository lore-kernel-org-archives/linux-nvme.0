Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D93C5DF87
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P0ufWGdWa+PETzbLKdwFDxUNPhNI0Vo9Wcvqc0amaSs=; b=qbB95Jo2zv9aeAOhFgRNlg27ZV
	CNcRYk5bp5KgXAOvrGh1f7rl5HAcL+J13+vnceUhbBHc3vQrD82MyMQxg/iNXiDVolBtoMXM72jb5
	42q0Ex5VbpZCmuHTqBX39tqnViYC0boJV5KGz/j57258ekaYBuma1wjXAsdtVIWua7E6Tj0AR541I
	UhDHFO1K+c20NuqO2ro5Rr3uxbw469tMh8ELkNVf3/AtnUY7jW3L8LhDkdIPVVHeHPtw3E8vRh8/I
	85Pn3gckMISXBI1LCh5lb34ZFFegbvFLwISAU6P5eh5cADC1Fa1Dki5/nl/3PVzHcNo4PsqFM01+i
	v9AUc+AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMDj-0000000D2zP-07m3;
	Fri, 21 Aug 2026 10:11:31 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMDf-0000000D2ud-0nnf
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 10:11:29 +0000
X-UUID: a573f5369d4811f19a56ed5b684f684d-20260821
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3191121b-e5cf-414d-ab40-8319822d0955,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.19,REQID:3191121b-e5cf-414d-ab40-8319822d0955,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:7db8b62,CLOUDID:377b769edb134166019e45e59a75be90,BulkI
	D:26082118111975IEJGT1,BulkQuantity:0,SF:10|38|66|78|102|127|136|850|865|8
	98,TC:nil,Content:0|15|50,EDM:-3|-100,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a573f5369d4811f19a56ed5b684f684d-20260821
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1683432199; Fri, 21 Aug 2026 18:11:16 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v3 0/5] block, nvme: support same-LBA multipath limit stacking
Date: Fri, 21 Aug 2026 18:10:45 +0800
Message-Id: <20260821101050.1464087-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_031127_525899_A836C225 
X-CRM114-Status: UNSURE (   7.07  )
X-CRM114-Notice: Please train this message.
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

blk_stack_limits() stacks limits for a top-device range mapped onto a
bottom device. Same-LBA multipath instead needs to stack limits across
paths without applying mapped-range topology calculations.

Factor the common topology, path and atomic write code into helpers. Add
block helpers for same-LBA multipath and use them for NVMe namespace heads.
SCSI multipath can use the same helpers.

Changes since v2:
- replace the exported low-level helpers with block helpers for same-LBA
  multipath;
- keep mapped-range and start-dependent checks inside blk_stack_limits().

Review of v2 noted that fixed namespace limits should not be updated for
each path. V3 separates these limits from path limit stacking, but keeps
the existing NVMe update behavior.

Changing this also requires explicit namespace-head revalidation after
events such as Format NVM. That work is left for a follow-up.

Tests:
- blktests nvme/004, 005, 006, 008, 010, 012, 014, 016, 017, 018,
  019, 021, 022, 023, 025, 026, 027, 028, 029, 030, 031, 040, 041,
  042, 043, 044, 045, 049, 051, 052, 053, 054, 057, 058, 059, 065,
  067 and 068 passed.
- blktests zbd/001, 003, 004, 005, 006, 008, 009, 011, 012 and 013
  passed.
- blktests block/003, 004 and 012, and scsi/009 and 010 passed.
- xfstests xfs/643, xfs/646, generic/765 and generic/773 passed.

Link to v2:
https://lore.kernel.org/r/20260806024658.4193386-1-sangyao@kylinos.cn

Yao Sang (5):
  nvme: factor namespace-head queue-limit update
  block: factor mapped-range topology out of blk_stack_limits
  block: factor path limits out of blk_stack_limits
  block: factor atomic write hardware limit stacking
  block, nvme: add same-LBA multipath limit helpers

 block/blk-settings.c          | 252 ++++++++++++++++++++++------------
 drivers/nvme/host/core.c      |  83 ++++-------
 drivers/nvme/host/multipath.c |   2 +
 include/linux/blkdev.h        |   3 +
 4 files changed, 202 insertions(+), 138 deletions(-)


base-commit: f1a8846e06388113dfdbb89dee005083fa9afdf9
-- 
2.25.1

