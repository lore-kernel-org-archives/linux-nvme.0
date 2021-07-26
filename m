Return-Path: <SRS0=7ItS=MS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880DBC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 05:27:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2A360BBB
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 05:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B2A360BBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Sp27MNLSPsHCYkeYBBNqs3k9AzcAjtdhr0TnjkOhxBI=; b=PZE+a6t9D8laso
	0gmdP2Tp8fd8/iiqKMnAgZ7UABhNzzWlmzEz/BDD5giwA4V7oG7VjpgNe0cQp5bstuPHnJ78mu0nO
	j0v1Cl7w3cjBCZF2whwOni4/x8NUJJ7AZBTkyPTdBg0uCJ7jjgILpA+gi0lNi5vffwsdHN7Ngopfg
	pujwJUOR/NpiPpcoHkTt6iT3DMMw7URleypJEDb+nZnpwPkzYK5FmqRCRPIN93mSHAH/ppOJf86VB
	G8HLJmYeWDpXT7q6BTHDhuCljdD+zwodz6ENLma/plSpDr4dDmKD+BYwRseA/cPeR9IjatflWpVcC
	8DC5CCV50jJdsuVEq5NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m7t7a-009dsU-Lc; Mon, 26 Jul 2021 05:25:46 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m7t7W-009ds6-UH
 for linux-nvme@lists.infradead.org; Mon, 26 Jul 2021 05:25:44 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16Q5GvkH023569
 for <linux-nvme@lists.infradead.org>; Mon, 26 Jul 2021 01:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=b3HjWGh+WGAzhsarJWibgGp6GXWTAIRvOt+hDAsmaSk=;
 b=FH1xVF7DZD3mr0BChZsrka0ZcAYCe7nrF5e543uihUKdyG4YOESrv3iyHIm4MiMOUaiF
 0SorcLPQd7kmH/TF9VBvrTsUBzGuUgzUQFSfV5alcgjaeFNaISV7a3Bna11dvPZfUGPO
 oBm/d16WaUAFrfDQEL+BIwmh+c4t+E/J8oIS6Slnq2gfn87qvtW+D40+Rlk9203/BvN/
 eBzZLc/uDHV7OdBu3tsUUNnreOANHk5j+QY8LPYDyar7fy1ZUHjiCZXePHzGwsilo25e
 OHcI8ANpQ33AzatIj2Hrbrg2k0CtOqN20KN71warpZZXoMpRg0tVC1N9N6FHqwTY1ThX mA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 3a0e6jmwbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 26 Jul 2021 01:25:40 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16Q5FOH6139837
 for <linux-nvme@lists.infradead.org>; Mon, 26 Jul 2021 01:25:39 -0400
Received: from esaploutdur03.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 3a0d4x2v7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Mon, 26 Jul 2021 01:25:39 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.160.107
Received: from arwen1.xiolab.lab.emc.com ([10.55.160.107])
 by esaploutdur03.us.dell.com with ESMTP; 26 Jul 2021 00:25:38 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, sagi@grimberg.me
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet: check that host sqsize does not exceed ctrl MQES
Date: Mon, 26 Jul 2021 08:25:35 +0300
Message-Id: <20210726052535.123959-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-26_01:2021-07-23,
 2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260031
X-Proofpoint-ORIG-GUID: ePvdhP64IZsU8f8bSFWIrSMvnpwC2glw
X-Proofpoint-GUID: ePvdhP64IZsU8f8bSFWIrSMvnpwC2glw
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210725_222543_082177_F8BCD75B 
X-CRM114-Status: GOOD (  14.65  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

Check that host sqsize is not greater-than
Maximum Queue Entries Supported (MQES) by the ctrl

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/fabrics-cmd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7d0f3523fdab..bc9407525d2c 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -109,6 +109,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	u16 qid = le16_to_cpu(c->qid);
 	u16 sqsize = le16_to_cpu(c->sqsize);
 	struct nvmet_ctrl *old;
+	u16 mqes = ctrl->cap & 0xffff;
 	u16 ret;
 
 	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
@@ -123,6 +124,13 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto err;
 	}
+	/* sqsize is not allowed to exceed Maximum Queue Entries Supported (MQES) */
+	if (sqsize > mqes) {
+		pr_warn("sqsize %u is larger than MQES supported %u cntlid %d\n",
+				sqsize, mqes, ctrl->cntlid);
+		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
+		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+	}
 
 	/* note: convert queue size from 0's-based value to 1's-based value */
 	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
