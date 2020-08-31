Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88B4C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BB520E65
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2LCrblwM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ksL/e4sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BB520E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bkmkjWZn/dP9aU3V4Ekt6MZ0eTsEGTPiJcUlWwGZmME=; b=2LCrblwMdhJVPkTrXJu2ndbqP
	m0y+oAQF+m0/WPsgacW6QjfQyuVjhukrAkxqJ0JP6ukzPflkuW8muWXgC/eVmQw3vPgfHf3sqCs5n
	H9iBAR7DpFHJCHoS63R9ja+Vk8hU5eIcaBSQSJzn+InM19+SW7DqleT7CPbn5C8p5ttFsSuTUWzQ4
	tpLxa5fVqmRhmn1ARHf+yJxjY7d9rIfmnXmecA5OJ7dMRze7FDjXxa1TwJl08ilw6/0R/Vu+s+au7
	U7XrMa3NFTyPzlHrisjOPm4ILe06errFpCRuJjCQW/CMtKaDeDIXRRF9FqEi+vvI92WOh5sKiFGur
	aY20LG9gA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsHC-0005b2-Db; Mon, 31 Aug 2020 22:27:46 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsH6-0005Vg-3X
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912860; x=1630448860;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TsIkMw5TBQJ2ZiDxDgkXD8BkPM23MeDDAQViVeGExVc=;
 b=ksL/e4sgEDsIEzwT+DUQ44aOmfrUOYi9OkbS/0K24/V9qExLr3QtuHff
 SVNeUX54RJ+Yh26PgBghQktuk9knhVjYs8u8qoMbxjL37+CvJkxO30j1L
 7Jyj2FzaQq+EWPSfibdY4YbA6GeV7x9aeKNFy3aZLXKo2XzmTl8R2JICQ
 1c9ztw4EkyMcSScCJOc7L8ppXViaZZpLzT9t9WOQAJKQmTu1IiqHSg3Ye
 XR2gtiYRreUaxcjr5PTgFZuXFjsf0t8vtHGE87AJn6ZKfV7AUdS3kPmyf
 T6aVB2dt9y/uj7y21uDm4APTemNBKpkLutGi20NpvDzFb3ElLJ7jX4EsO A==;
IronPort-SDR: +f0JJuWOEoJhD1x6eDVXAHnCl9goaEovidtA/8sLgW7gG6Ll4ee2eRGuUEs9AaJfI9eNBLUFlh
 6Z25miyMTlgRrXfHlzVBQv5Z65DyrJlkewSa1nZ3EhUefUGOCp9eEoVWIRtzvnk/uI77N+3ieo
 Ut7ZzdX62qzZDNA8apIqvasPdsBscgXGzqLl6L361WmPM9vr1YRYvQ7DwOUQ314focVFU3r/Zg
 dmoK2z3ane/QGvevr2+wTzmP0GyXm+NaaCY8i1yaawmjGLOJxBTDereb+0uIolbSV/u8ipEkQZ
 2VQ=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="147482854"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:40 +0800
IronPort-SDR: YzF9HM3G2pMrzrywP3q9ka8/JCdFzQQbpo1/52E5CG0QtKcAMN7BYV5PlVU+bOOeShRm4jDguZ
 SzXzsWNu48Xw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:15:08 -0700
IronPort-SDR: zjOXoCC3dVWfB18lvEIXZ7MoZsMRZKA2mH9xLM6/mvvSRdIxa4vy5p8nJfnlJcf8F8YKCrDLsY
 ZNKoOgfQ51AA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:39 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 06/12] nvmet: remove op_flags for write commands
Date: Mon, 31 Aug 2020 15:27:01 -0700
Message-Id: <20200831222707.35611-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182740_385572_9A2E5D65 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_passthru_map_sg() sets the op_flags to
(REQ_SYNC | REQ_IDLE). Currently, in the block layer this check is only
present for not throttling WRITE_ODIRECT requests for REQ_OP_WRITE
opcode.

Remove the op_flags assignment for nvme_is_write() case.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8f9c2144a103..fbe2678aea6a 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -188,8 +188,6 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 
 	if (req->cmd->common.opcode == nvme_cmd_flush)
 		op_flags = REQ_FUA;
-	else if (nvme_is_write(req->cmd))
-		op_flags = REQ_SYNC | REQ_IDLE;
 
 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
 	bio->bi_end_io = bio_put;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
