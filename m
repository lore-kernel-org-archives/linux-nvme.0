Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE809C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Mar 2022 21:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6R5lYuuup8VZtWBfEtQA2UbsBf1NFiXrWcDZS5J3ZWY=; b=Mmu5Up0QUjGsWU1LaUWkIPq5cr
	y+NcPGNAEO1HXyzYTuSYhMRL9rNTfHNHpkSnaVVaZ2RGwb1xJ9y0z6jcgXxn7lKTNwDE0djxJ+6ST
	L0lXmBFb1rQib9iXIX+JxnhjCy/5DdNfinjWySzrdN6vNvv3FcR3IDxSrggpR2QoZi2JHwJMq1V5D
	VGOcgzsazL5EbWtmLs3vz0OPLKPu05LCft0sLHpoz+s5A0fpRdGj7h8rKfufWMQWKFNBO/HLccqvU
	k/EboyWByPM3ekZsVYAYa0PkV5WGfoBtxZ/6a8xuv7Nf5yJR4W87yqYSf10YeBOu5IG1XeTqt1CRY
	VWYU92FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1na2cN-003kZH-A0; Thu, 31 Mar 2022 21:46:11 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1na2cK-003kXM-77
 for linux-nvme@lists.infradead.org; Thu, 31 Mar 2022 21:46:09 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VITFXF029851; 
 Thu, 31 Mar 2022 21:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=6R5lYuuup8VZtWBfEtQA2UbsBf1NFiXrWcDZS5J3ZWY=;
 b=nu7pS04JeWsb3fzg0+eoe1nba11aaWeOZlHk88a3zaFgYLMmKDL35lGIg7Jnz9Uhs2ot
 Z4IvERQxKJQ0EfK4UooMuQ3hfhWKzPpSdKvy8SgRTbA3fzrFWmZHr/ofxemMDa+I3OI7
 fZIO5mL6f+CFEL1XWMnEHHsjRveZ7wfo5s4VUxDEgwi4xQdAjPxqEDJ2k8CV28RBR3WR
 oqEWADuXJm+1I9kQEJxQ+FWEkGtfc1YYgikeICy9rrqEcEPgzEXGRGAwhFW3k64az4m1
 nGSOd7rBZ5b67PLkm8ecsdth10+782z7c+hf0o5T5s14D6x7Hq+d8qcDK329PoUfQEGB Yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqbdb90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Mar 2022 21:45:59 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 22VLfL5w013723; Thu, 31 Mar 2022 21:45:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f1s95cuxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Mar 2022 21:45:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VLjvTk025801;
 Thu, 31 Mar 2022 21:45:58 GMT
Received: from dhcp-10-65-129-122.vpn.oracle.com
 (dhcp-10-65-129-122.vpn.oracle.com [10.65.129.122])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f1s95cuwy-2; Thu, 31 Mar 2022 21:45:58 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, linux-nvme@lists.infradead.org, osandov@fb.com
Subject: [PATCH blktests] nvme tests should use nvme_trtype when setting up
 passthru target
Date: Thu, 31 Mar 2022 14:45:26 -0700
Message-Id: <20220331214526.95529-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220331214526.95529-1-alan.adamson@oracle.com>
References: <20220331214526.95529-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FNBtg7jMc_d7N23fEAGceCrUnmJ_byHw
X-Proofpoint-ORIG-GUID: FNBtg7jMc_d7N23fEAGceCrUnmJ_byHw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_144608_296808_79C98477 
X-CRM114-Status: GOOD (  15.64  )
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

No matter what was passed in with nvme_trtype, the target was being
set up with trtype as "loop".  This caused several passthru tests
to fail when testing tcp or rdma.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1c27cdee1b5f..3c38408a0bfe 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -335,7 +335,7 @@ _nvmet_passthru_target_setup() {
 	local subsys_name=$1
 
 	_create_nvmet_passthru "${subsys_name}"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	echo "$port"
-- 
2.27.0


