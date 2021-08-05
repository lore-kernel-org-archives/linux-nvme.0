Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A621C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 15:03:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432636104F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 15:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 432636104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GcpJ0v4IotKnN0efLLg5XL/jaBu/m+Stb8NFckLYerM=; b=1gWnExGypzUrIQ
	FlwwL5+rH8vWcCNjgBoS201sxzJDFpsy7xFGj0hc8AYCYToipYnaAJY091vxsOQuw04LmSze7jamY
	oHinK9aHsdB2rPt4LiB+xPeohHOCbhYPx6PqsGFF5SUy2A4X5yaD3uIu9bG52WSCggCzqXI7+5yRx
	+wtIth2KsGET+APSkbfOrvNi4alM8/P/E5LXJoXGuER1ydwP55LLRJiCW/MutKCZIOZi66lpAEFp/
	ZxZBV8hMGqwCH5buBZMYAkvqzrt0VsrdHFfxh1N6f7QLK+Z4GpwsMytU6HsDMU3ohFFiIQBChaqNy
	OfDW6IsAf+a1YN8EwstA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBetm-00A0Pu-HZ; Thu, 05 Aug 2021 15:03:06 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBetj-00A0Or-AP
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 15:03:04 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 175EujON019937
 for <linux-nvme@lists.infradead.org>; Thu, 5 Aug 2021 11:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=Kgp0SP5QrSx+b3mkysSbu1ZcmwOiCNOjdKc3BW9Za5I=;
 b=GgxZsfin6nFk7wDVRBgFthjMWXgMlcM/znNhtbRewLbhpKR1MDH11w2Z6TzoR9pKDSyv
 27YQO7EJ3sMNrg6YJTUWbwmkv4WySKjqmJP5tbL5ykdiQqbfNDf4/Au3tTtxv1yx/Mr5
 Hys3NgX/ue3zdPs4uFE0qsn/UqbKZEBSSRHGub3cAo2E7lKkgMvKYUiVDmu8eYWCuZcd
 5HAq0syr3457gKML/sJTaiBCbtkBl69461KmE2JLuu04CDmy0UTDlsNay6DPdPqa55ai
 56w3l7+sFJRZzLFtl86U2wIuAzct0LnSyD6L7QSzi1Fy5lT6TSXhJiiXPk02GtC/AgmN 8Q== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 3a7tdpn3mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 05 Aug 2021 11:02:59 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 175Eswgl088283
 for <linux-nvme@lists.infradead.org>; Thu, 5 Aug 2021 11:02:57 -0400
Received: from esaploutdur06.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 3a7pmey8am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 05 Aug 2021 11:02:57 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="80919897"
Received: from vd-amite.xiolab.lab.emc.com ([10.55.225.216])
 by esaploutdur06.us.dell.com with ESMTP; 05 Aug 2021 10:02:54 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet: check that host sqsize does not exceed ctrl MQES
Date: Thu,  5 Aug 2021 18:02:51 +0300
Message-Id: <20210805150251.30385-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-08-05_05:2021-08-05,
 2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050091
X-Proofpoint-ORIG-GUID: --WjCPRU2lO59UM30KuAalAS_tMUgZJU
X-Proofpoint-GUID: --WjCPRU2lO59UM30KuAalAS_tMUgZJU
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_080303_456680_23621B2E 
X-CRM114-Status: GOOD (  15.12  )
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
 drivers/nvme/target/fabrics-cmd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7d0f3523fdab..2b4a41b45c45 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -109,6 +109,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	u16 qid = le16_to_cpu(c->qid);
 	u16 sqsize = le16_to_cpu(c->sqsize);
 	struct nvmet_ctrl *old;
+	u16 mqes = NVME_CAP_MQES(ctrl->cap);
 	u16 ret;
 
 	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
@@ -123,6 +124,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto err;
 	}
+	/* sqsize is not allowed to exceed Maximum Queue Entries Supported (MQES) */
+	if (sqsize > mqes) {
+		pr_warn("sqsize %u is larger than MQES supported %u cntlid %d\n",
+				sqsize, mqes, ctrl->cntlid);
+		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
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
