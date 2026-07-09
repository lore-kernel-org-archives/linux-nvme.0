Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF72C44506
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YEeMxrTkK+uVIj1KQJ1Gew62lQSplcI/QnjXePppFNk=; b=h64sQSBaPWnVW1HcCv52JEU6kK
	0HfGX5wbHQMv/NkpFNHCFyO7WxRmA3ZK11yV6IrvINE7PlK9vze1SOHoNCBmNzT6/fhanhcc44vcr
	7U/PZpG7330ruJdzQkAqZF3nYeOOaRcarkUw+WL5CxqMb+oGkZd33gn9P8P/XBCWOJXC92obT3uYT
	bzwsA87Rn4PulVRUIOwKZ75liyFuI9Wp+S3tk5MdRRia4q5KdyfF1n0QonLNqJiAGWqpI0wYiv/y8
	MMGsXMp14FypAYs8ib+HciwJkLz8MM+2+lj+ldw9Cgtxg+i0obUCx3U4LoLDodODk0WiYpCKToF5H
	2a5GgHnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkWl-00000001eKQ-3m8g;
	Thu, 09 Jul 2026 08:54:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkSO-00000001Z8w-1MdE
	for linux-nvme@bombadil.infradead.org;
	Thu, 09 Jul 2026 08:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=YEeMxrTkK+uVIj1KQJ1Gew62lQSplcI/QnjXePppFNk=; b=kQGEH2xbVCZCamB25QIW6mb0lY
	14ezpUzWLkd/XB3VgCzGFwHRGNLwxUhAlreQ0pzNfC5yojXEYj9N4wsFElqwY6AXE+nctjn2r2BC8
	em19g5OykEBnOJjRLx0UvQMfY7mztQBnWrkTaRNZLEDLul3Drt72PG/QcVHQ0PcQFs0cRPFCpG6sx
	qeUTZUT4PgOSDxkyhpC8S6B3FY9uLAZ68HzkbIn+tHGdjqxarPQQRHrwAMIIghFyj7t14ngWRi7fy
	CW1jn5G3iexdjg4/uGUJ1R/BzXNd4qhWYFx+MXoY3SsLuFdlqBUZnhUtbyBfigTKog6UgUOb5VGYp
	7cMk2rTg==;
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1whkSH-00000008ybG-1nAq
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 08:50:06 +0000
X-UUID: 13559cbe7b7311f1aa26b74ffac11d73-20260709
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c29b30d0-0587-482b-8439-a107c600937d,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:c29b30d0-0587-482b-8439-a107c600937d,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:a50fbfcbfcee484f14699107e6e42695,BulkI
	D:260709162240S0RJ0A0N,BulkQuantity:1,Recheck:0,SF:10|66|78|102|127|850|86
	5|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 13559cbe7b7311f1aa26b74ffac11d73-20260709
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 149286387; Thu, 09 Jul 2026 16:49:20 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Yao Sang <sangyao@kylinos.cn>
Subject: [RFC PATCH v1 0/2] nvme: use local limits for namespace heads
Date: Thu,  9 Jul 2026 16:48:23 +0800
Message-Id: <20260709084826.3208740-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_095004_869906_264C6B8A 
X-CRM114-Status: GOOD (  10.43  )
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

Hi,

This series makes the namespace-head queue-limit refresh in NVMe native
multipath local to NVMe instead of routing it through generic
stacked-device helpers. Patch 1 factors the existing refresh sequence into
nvme_update_ns_head_limits() without changing behavior. Patch 2 replaces
queue_limits_stack_bdev() with NVMe-local limit handling.

The motivation is a zoned namespace configuration issue that made the
current namespace-head limit refresh hard to reason about. NVMe native
multipath heads currently call queue_limits_stack_bdev(), then adjust some
NVMe-specific values afterwards. That mixes the rules for mapped stacked
devices, such as DM, with the rules for refreshing one NVMe namespace
through multiple paths.

The goal is to make the NVMe native multipath path easier to review and
decouple it from the configuration rules used by DM and other mapped
devices. If this direction looks reasonable, the next step can be either to
keep the helper local to NVMe or to discuss a smaller common helper later.

The main RFC question is the exact handling for individual queue limits
once NVMe stops using queue_limits_stack_bdev(). For example, this version
does not carry bdev offset and alignment handling from the namespace
head refresh, keeps the existing feature inheritance behavior, and merges
request limits conservatively. Review on whether these field handling
choices are the right ones for NVMe native multipath would be appreciated.

The thread also carries the nvme/068 blktests self-test as a
companion patch. It can be submitted to the blktests tree later if the
direction looks good.

Testing:
- blktests nvme/068 passed.
- blktests nvme/004, 005, 006, 008, 010, 012, 014, 016, 017, 018,
  019, 021, 022, 023, 025, 026, 027, 028, 029, 030, 031, 040, 041,
  042, 043, 044, 045, 049, 051, 052, 053, 054, 057, 058, 059, 065,
  and 067 passed.
- blktests zbd/001, 003, 004, 005, 006, 008, 009, 011, 012, and 013
  passed.
- blktests block/003, 004, and 012 passed.
- blktests scsi/009 and scsi/010 passed.

Thanks,
Yao

Yao Sang (2):
  nvme: factor namespace-head queue-limit update
  nvme: stop using queue_limits_stack_bdev for namespace heads

 drivers/nvme/host/core.c | 188 +++++++++++++++++++++++++++++----------
 1 file changed, 139 insertions(+), 49 deletions(-)

-- 
2.25.1


