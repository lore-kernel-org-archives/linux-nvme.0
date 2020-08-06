Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99856C433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 12:21:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E9F22CF6
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 12:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bwyh4Yuf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dKvcoZJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E9F22CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qAY69GmWSI844x/wnOxhkK/LiTEI7UF7C+XGFEWBDVw=; b=bwyh4YufWXrQbfMg/hG1jAs9J6
	EIhmX6FMwSNJj+BxmCLYxhTWod7ONnaSwoeqwdoOgzoV0x/u/hZp6Y4kEFBPVEhBRQbjv6OWgAUiH
	ib8PEw2gXyy3Ow7fEHVoulKTY5/2kg/ebzjZHZEyJC3vY7ysCF+2UNrQHMyk7a6NuTxer0m7GD1Vv
	2cFulJ+nIOZJMOTiIZOt4KT8eEZCKk6H0up7I5kMnv6iSGlAm3Jp8Z11bo2dI3Cv+Wp7we6Rq1nD5
	zFBMUadxiON88k+tfDkbLWHkS4z/0LPIJMVRcFp1Lx4TRwreg7Z6sbSbPS/iyFGStD3RwquJj9tr4
	Lwt8aq1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3aNd-0002cO-9d; Thu, 06 Aug 2020 07:32:01 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3aNa-0002aZ-8t
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 07:31:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596699117; x=1628235117;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AEPUT3mqiTGQZVeIYHwpu39hnlvFnDYctVEZ2nqyW3o=;
 b=dKvcoZJX8Vw94+Jluz0mZVf6fTfj0ALScMZXnQZoO/bAXpxi1UC0gwoj
 nQPTsiKYDuCukkgSSNMUHvPHoIRxhly2C7EvX1L32aTFger7kLk01mmZA
 XfSb54IDInZHvIvun4CVP84+FCx1D+x3eJJfIO1kQIq0HUJ8PXe7sEH4Q
 MyuESHtARsyn4eFXRT6+Dv7X/3c/KRyrXxtJXAJDPWKBsT7PdsNfo2C/t
 /R18edjyDFniQ5Su1cSwdOq+pdZYG+sdeh7yfrKsyUAu6SSa2ClSrZ9JK
 FsrPh/AqTeJj63ypdGcuF75eUVZT0LgrtHFQ3RJ5LeTENMWP33pa26//y g==;
IronPort-SDR: TsM/dnLZu8cZtvWiNTrHiZtS3WxmOa+SE8r29nuuofbwY6lrm2v5tRtaIR1J3rvdd5ygyR0OL1
 5HRuv6fEA2zCTGlwJ3FplaFr2nwAn9UIGE0eRRNjDPQN1CQkAmgii9llQFA44UkvQ2vdjGs/7X
 dv4P25zARD/kYzjzQr6rqTkMVUEcG6LHH9GXIXdIZ8aCKwvIntqNzzvITDRWq0soQnXU4tSnra
 tbqvkpBLfXoSclNkjvHawN2f5sD7p2isQfpz/QviuaREUQAnvIn4xEevkCpBoJgHpkBQ1yV+0C
 qAk=
X-IronPort-AV: E=Sophos;i="5.75,441,1589212800"; d="scan'208";a="144279249"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2020 15:31:54 +0800
IronPort-SDR: b80pn/ZN6oNchZFMtKmoKhT1swVcfgKmE7u33J0pi83wCpbN/frH5qYWFU9Lf7ymcV8VcIsEu0
 +fGfLeffIBew==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 00:19:12 -0700
IronPort-SDR: TVBKiKj40DKEFzy8vgyXS6TFRlb/tRRNQhKG31M/q/rFT/XCOIaGHQRXNPBGHPtoZLNFdJWBOU
 asVo8cX6D/lQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2020 00:31:54 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvmet: couple of passthru fixes
Date: Thu,  6 Aug 2020 00:31:49 -0700
Message-Id: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_033158_498454_382AFB5D 
X-CRM114-Status: UNSURE (   9.38  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is a small patch-series that fixes a bug in the passthru
submission path and makes the the direct call to blk_mq_free_request().

Regarding second patch I didn't understand the exact reason to call
blk_mq_free_request() indirectly via blk_put_request(), if there is one
feel free to ignore.

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  nvmet: fix oops in nvmet_execute_passthru_cmd()
  nvmet: call blk_mq_free_request() directly

 drivers/nvme/target/passthru.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
