Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A442C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7CD64EAA
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7CD64EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JJIzVrhz6i5N7FbIUON81FWEZexBQsuoshtdQ45su3o=; b=NNwpJV7qs5zjSIUtxv110XZdY
	UGgQxzeUFQDfUxvJNFLkkP5HBtekEtj+P+sVNWeE9tG+KoJtzeveIBMGlXAzy+6KiNRLPM1//jLjB
	TQtym32C54benBVikjx/Js4AUCn/NMWUeW6tAAWtBke/VJvGNYkoJT6PiELkjdoPryQgN80GTNdoP
	qutyU6bNCDOnLBvqVkbIGmZPAECDYtXetz1K+IHz/YN9M7BYvlEIUtjuEq0Qzv1xs9GP2tNu2Qilb
	nYdj3ljodqRRPtuLwYopVtpYXlsE1W9zWV/P9cymNniFJgSOyeyMNC1VX9+aGJZa40VO44oYdpwu5
	3BnBFlJ0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KKo-000302-Oe; Tue, 09 Feb 2021 04:09:06 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKe-0002sC-6N
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:08:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843736; x=1644379736;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bg3R1rWLO35WyKYY3Buo3HOjMqzJFRMc/OIHvh8ow/w=;
 b=UK05EQ8SC7S0Fm8veBd146BPmd9oBvJSgE+jqwLSlynLMgY4WWJ4ZbqR
 fMXsuCURgZWmrgUyKqHcEjWUrccfpwJ+/n6cABwxI6Z/GZrglPdevZAiW
 Iupdb6JMnT4Q1wQkImvbEWucvPe/BQEYVdGBu+NEC9iWj2TyaJgwMznB/
 hb6E2dqwFKmVMro8An2aYZWCYS+sVwUpQuPfD5Xvd4q5vVnFPxcFbhXqX
 RRRLsSrrM5OVSDj2vT2KR5TuxxuWmLB08SGqmP51scXRucXjJvp7IQnuN
 pJmi79MuqTRxBaPDUlxY9JR7Y+G3xs7ouPl9es1GiLpGjv+aGIskDBOpN w==;
IronPort-SDR: dIxwKjXV17okG2a5bwrn5ZdcuTacXEvXnkW3v1QeSbAcnHXv3SSUA1PsSzX4GpiuczxY2rlC7V
 xQoxAf19Lfd+O+AnYYuzFRDTnbpMwDRql86h70RMDQBL96dVMh3UYpmx9RNDSmJiwCrQaN0oKy
 BU8uwiRTgantYihbUpvWur6Jw8L5d5gCsJJTsOEl7UN5SkocVUExe6l3WsEn7E49PAZMS7W/7e
 X+Weel728FV3g18GaG4itiYUbpG5bLz8TAxJpjgoBqSiLs2J/C+orCKwPw8nGNuxhcCy0PsGZY
 5+Y=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970522"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:08:55 +0800
IronPort-SDR: vgUlHL0k8eaEYy7YA7aqyAganlXoGOZie+mm1METzIdoc9qKr0FAAiCrhVBmWDQV23SHZ41Tsv
 1buFcvDfJaCxLlPv+oEGOFGrz/2bWTgDc+ItLO+y7qIYsVdN8wozW9LP6KVzpsmZTAdIv9iZpI
 vRA/FWI4rNLWuRF7AEa5UIW0jUsxmzK4UW+hVhdcJhzd0PB8t9+zmgtskWrKqZUD8JXE/JTLQr
 tJhupKqgWu2lxTwGpZSvB1so4t3OGEofjpX0NsYL+NJ+rNv5AbRmZPneNilmE4Cz9KyoHmIhmI
 oFJyw9KBhfa5pFdqmbZHYEfb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:49 -0800
IronPort-SDR: w7IVbKblRLdh42aT6alBGPyAyc4T8/SHe8dYYVp9xfOXX+YjjYaG6NXN+uBjUZHhgRDH3Vfu52
 1u6N5Gia2ZuAh954fdaucsLA5eDzcNr3JBzWXyzIcyxgBWcIeqmTHZTs7ds583lvE8t6ii/OSW
 yPSK3Q+UWLUGtygt3aGgWsfBua5OZ9BI9xMS7z2b9SET9288Ma6NyiwgBP75Lm/GpJMZ9DwiCI
 Wik3UNywHz3Aqm5nETTZi7GCY0dPzNvYRKIs3DUb8CMbopkxmsM0Cmwxc9CRoMCNHCMmb94u21
 x9A=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:08:56 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 06/11] nvmet: use invalid cmd opcode helper
Date: Mon,  8 Feb 2021 20:08:38 -0800
Message-Id: <20210209040843.45572-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230856_412533_742D621A 
X-CRM114-Status: GOOD (  12.37  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the NVMeOF block device backend, file backend, and passthru backend
we reject and report the commands if opcode is not handled.

Use the previously introduced helper in file backend to reduce the
duplicate code and make the error message uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..715d4376c997 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -400,9 +400,6 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("unhandled cmd for file ns %d on qid %d\n",
-				cmd->common.opcode, req->sq->qid);
-		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return nvmet_report_invalid_opcode(req);
 	}
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
