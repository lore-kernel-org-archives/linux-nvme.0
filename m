Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5297C44525
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 02:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6haOqw4sMzqkvRt7FMeQodIca7RNaMNQcHflseQQRzM=; b=g9pS4z2QFbcm2hoCzzpeECBVaC
	deOHKfEm/ZA4s1dp8ckYJxn8mx3ONERkgZfX0ij+4A0gRZ4iQq2YXTivd/f78xqdYPO4XCjcUi6V/
	beO4M6FqkefHSqOKHFgEZ+i+GKOnnoC75NZ52TejHi6ccTV9Cr6v7yEef1S+2JmKbT3xnZDb2Y04s
	8w0/pRBBr/RWFtpNeinBjOeZ/VwsNZlIoGFErrWaMl7uEgLwvnwTOvkElrc7ZVW9d09pRzd89WQt6
	fJqs1joE0lSxPnPEjcyjyOG0aiqWTBbrlKS6GA+zK8DwpHP6zAEk1mOToxLnKyEXFORPv65Ws8rpT
	MvTfsBAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wldel-00000005gik-0iNV;
	Mon, 20 Jul 2026 02:22:59 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlded-00000005gh8-0YNj
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 02:22:53 +0000
X-UUID: e17e610483e111f1aa26b74ffac11d73-20260720
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e390a6c2-7537-4cb6-83f4-c791550d57f1,IP:20,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.3.12,REQID:e390a6c2-7537-4cb6-83f4-c791550d57f1,IP:20,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:ddcf4144c4b80efb0878fbfa9319f18f,BulkI
	D:2607171221038F3RLMWT,BulkQuantity:2,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk
	:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e17e610483e111f1aa26b74ffac11d73-20260720
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1876469084; Mon, 20 Jul 2026 10:22:39 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v1 0/2] nvme: use local limits for namespace heads
Date: Mon, 20 Jul 2026 10:22:03 +0800
Message-Id: <20260720022205.1798805-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_192251_460238_CDBCE888 
X-CRM114-Status: UNSURE (   7.58  )
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

Hi everyone,

NVMe native multipath refreshes namespace-head queue limits whenever
namespace information is updated. The current path uses
queue_limits_stack_bdev(), then overrides selected NVMe configuration
fields afterwards.

queue_limits_stack_bdev() also applies offset and alignment handling
intended for stacked devices. An NVMe namespace head has a different
relationship with its underlying devices: every path reaches the same
namespace rather than a separately mapped lower device. Its limit update
therefore needs to refresh Identify-derived configuration, combine
path-dependent request limits conservatively, and retain user-set queue
limits.

This series makes that distinction explicit in two steps. Patch 1 moves
the existing namespace-head update into a local helper without changing
its behavior. Patch 2 then replaces the generic stacking operation with
NVMe-specific handling for configuration, features, and request limits.

Testing:

- blktests nvme/004, 005, 006, 008, 010, 012, 014, 016, 017, 018, 019,
  021, 022, 023, 025, 026, 027, 028, 029, 030, 031, 040, 041, 042, 043,
  044, 045, 049, 051, 052, 053, 054, 057, 058, 059,
  065, 067 and 068 passed.
- blktests zbd/001, 003, 004, 005, 006, 008, 009, 011, 012, and 013
  passed.
- blktests block/003, 004, and 012, and scsi/009 and 010 passed.
- xfstests xfs/643, xfs/646, generic/765, and generic/773 passed.

Changes since RFC:
- rebase from nvme-7.2 to nvme-7.3;
- keep the thread kernel-only

Link: https://lore.kernel.org/r/20260709084826.3208740-1-sangyao@kylinos.cn

Thanks,
Yao

Yao Sang (2):
  nvme: factor namespace-head queue-limit update
  nvme: stop using queue_limits_stack_bdev for namespace heads

 drivers/nvme/host/core.c | 196 ++++++++++++++++++++++++++++-----------
 1 file changed, 143 insertions(+), 53 deletions(-)

-- 
2.25.1


