Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ECFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D2E64E02
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D2E64E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ae4Hw0t8bFGU4cdBVSOqglQQKsxya3mykyLv8LHMmDY=; b=TEdj26LnyjF1jdMCwoauydLUE
	qYFCIKEuvuUpzy8mmzLK+6+cCPgAJ6IdYTBvbzc3H4a2McFRR0sWssATjLrSRa326lR107pQSUdZS
	buSoRDmZblD+Vtl7ouwZr1dqBenUR4zH1H/u3Q+vCXBwNuW6OS1/TBhqmVqMZejO1FBgS//L1Lw6U
	XkBXtAGQwAVU5pX13wCqwMpHiymMCZPqpycI9zzCWNH5C1Hjov0TjKp0CgU6e+IyeDKQ/hHDdSa2Q
	dBaXGPVm/qoA7q3gPQRa39xEPvCMgf1j0cBJqsPUQ8q1X7tS1z7HzkLD5zEeB+s8gdGyiLaDPc8Av
	1Ig7kww6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF5tj-0007gd-NW; Thu, 25 Feb 2021 01:56:59 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF5th-0007g4-00
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 01:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614219012; x=1645755012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KBUOH1ZJ96GuD8c/fwPtxLmreUZyyTuHx8vyLEkvmvw=;
 b=S2DYop/Z8PWhu2NIFJCXbNuXXtYo3JvG6NMCpiuFGiOgic5e3rvvVGEA
 Mv3TKf8NjNJ2OZa4hiGNfxsTxEWISOnv6mlfUxYWWtmKaY3jZMMxsnbsu
 v+c1nNlMTfXXV9pzbM83PB8cunMmr5c7yx3vTPgAggadE6SkT+/sB533d
 x8y5JscH9pva7/S2lwiajEQH8wSixCcJ0kMkrs35vJZYXHnG4TmDBItMi
 6Ah0WZzlh+5RQQep++0PNPzQhnlXri92CZNe2eTwDYFBHgYbsj/+P11GG
 PXwIrZ91qJ5+wl8CqbAxZeyRTuNq2HgxoJg81g4NcVLwL+9nmAHYSqmtY Q==;
IronPort-SDR: fmDWBK9R6ejNpKEtqMb2g5hh7ZkZRuTxk+henuYkFCIPBjlzG8E/kt474JbvBYGbOCTtVYkC3n
 28X4Ke2Z+iOfr+Sct1sr0EONV9GsAsTMcxlF5/RottUuVOjkm8lytyIDh4LwCocbxD1zxamWHf
 XU95BmUqP4OCrlkkDESziRCvDUufHiWlQYWK01NjpzFf6GQushz78Ox9SqSjBCyrBuGwise1wk
 vqABRV3xXJfwAoMXhyZzk7vdB/zHbAtK2PowIBsahizR9H0g2E5SspZK6GvaTHvjfls8tuv0Fw
 8f4=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="264959758"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 10:10:10 +0800
IronPort-SDR: g/owR9lS/4e/7LlDXwHiK10NFopb2kNMlPzv8QZOS9OxKVb5azBIQcmeh/OLA9pmfm8rzBEu3W
 W+FqTO+8EIeAnaJt6ELQUs+XbDBnHxixqWMt10XTjp2CKSVGjeXafdeiUVngKyp48+vJTGVhDA
 xgRNLxsZkfrs0ucORzg2TNfyfwnC4hMcjdONJt4QEoAP24OIwqj4qZjoSlrDnUtM4RvconIw1h
 Mv6bu5oROBxEqPV1TaGVvSb5/pLxEaY29t+ki0pkq3NUn2DJH0qNjq48lbG+iiPp5N8cI3/ZTb
 woMvia3praFJ2aydYEYefSV4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 17:40:10 -0800
IronPort-SDR: Pv+pXyvo9z1RqcuH13ja6euu4GiJOlBB/NG7VYETUfgtOCU19fEQwolsbw/YtZQCfLq2i9/CjU
 i6ZLf+pDwbxRkDnJVS1kWVJmklwtYhBI9rL1RnofHulIj6YHBnLofi1SVUN4BG0EzqMADd2Z/C
 3hvakzJGWhLyh79xaZOCpVxFIw3C+GGSetwPfe8gUXuMqp4zRJHYnD1ezJTloXp6CuxymK2+F/
 M+vx2LmWsfb8aDFj8MEJGAmAxF8VvezHLZFpH2oj6gFgoKl00ut8TwJ9YU0TAMhIdn/JKrirbo
 ov8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 17:56:55 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/6] nvmet: remove duplicate status assignment
Date: Wed, 24 Feb 2021 17:56:37 -0800
Message-Id: <20210225015642.29288-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_205657_230100_F778E5F6 
X-CRM114-Status: GOOD (  11.05  )
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

In the function nvmet_alloc_ctrl() we assign status value before we
call nvmet_fine_get_subsys() to :-
status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;

After we successfully find the subsystem we again set the status value
to :-
status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;

Remove the duplicate status assignment value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index be6fcdaf51a7..e3b8ec535eb4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1314,7 +1314,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out;
 	}
 
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	down_read(&nvmet_config_sem);
 	if (!nvmet_host_allowed(subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
