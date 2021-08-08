Return-Path: <SRS0=j25R=M7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A16C4338F
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Aug 2021 06:21:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5FB60BD3
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Aug 2021 06:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE5FB60BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MSpxvHD8tpu0iQvCDQdqK0a0U9oUJ1B1EqMUFNpa9Og=; b=R6+lKDWJsO5P7w
	nA0kV+Zyw+TdTfeNzPk2Tl6pfhUXnozz13KJniGGCU528iCnvd4ykEX7FpC0uk0FvxXRJ1KwOw1la
	vNrRITlSFgIuNRzx+38R52vcp9ad8TKQZfr8TBDl09KQWwWCCLCCgKPyqWQoawbkpOHYSjsMQUfSN
	PyEUrC6DEFF4Sg+pQfxfGqeaOHVWfbtdKaBuY9K30sFIKJrD9N7IlMRqIMUISTO2knIE0wfEZtdC8
	V6qNmp+E/TaUlrpRBnWcOOaGFBBgdqXvjLJOHd7ov/aKhx88IZIrSAPlpaT6LoX9rA1xM0Fqmd7kF
	7RqL6kr8KKjTix/5Ddkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCcB5-00FZLs-Vb; Sun, 08 Aug 2021 06:20:56 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCcAb-00FZLI-M4
 for linux-nvme@lists.infradead.org; Sun, 08 Aug 2021 06:20:27 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 17867t0t001229
 for <linux-nvme@lists.infradead.org>; Sun, 8 Aug 2021 02:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=PeA8kbU4c53Mpiy3uFTM02C/RmwGvLMFE7tPf3nf/0w=;
 b=BkYOi7QTPVyFZrzLDM8pXvD5uqx7mouJrSGppx2w04yiRb/oMegx6yHeb/Ns8tGXEe+8
 GM7t1p9u8x8s5rZi4OUObj+gh/dBctNMTy7JwLcgdiOb0d5b9fB+IAcjCIaq75F1nL3E
 F/S5XgtNMwCnFK0peEkQiMwe6G3Fyaea49A6gZBF5K22gYfEwIKqBr/1tev2AiRSzuMn
 EuPNs928C7tSbNI073Y7C5Dio+RoRgfxxNrXpHBaU/niPRa5DxyMalEfqYXeUO3JkVwR
 W96mfMrnGmbrUgNw2JJtf3+tt1k0Maax8RcLTMPwCDqQH09ZDoUQZ60gWFCSBYAuFiYu cQ== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 3a9pur1jt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Sun, 08 Aug 2021 02:20:20 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1786AFAH144134
 for <linux-nvme@lists.infradead.org>; Sun, 8 Aug 2021 02:20:19 -0400
Received: from esaploutdur02.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 3aa7d711n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Sun, 08 Aug 2021 02:20:19 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="82147492"
Received: from vd-amite.xiolab.lab.emc.com ([10.55.225.216])
 by esaploutdur02.us.dell.com with ESMTP; 08 Aug 2021 01:20:18 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet: pass back cntlid on successful completion
Date: Sun,  8 Aug 2021 09:20:14 +0300
Message-Id: <20210808062014.28151-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-08-08_02:2021-08-06,
 2021-08-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108080037
X-Proofpoint-ORIG-GUID: Ij6e0OFYhWn9aMPJO1oqpiRMxBM-ogHT
X-Proofpoint-GUID: Ij6e0OFYhWn9aMPJO1oqpiRMxBM-ogHT
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108080037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210807_232025_936764_EA3D9087 
X-CRM114-Status: GOOD (  15.78  )
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

According to NVMe specification,
connect response dword 0 value is based on status code:
return cntlid for successful compeltion
return IPO and IATTR for connect invalid parameters

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/fabrics-cmd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7d0f3523fdab..8ef564c3b32c 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -120,6 +120,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	if (!sqsize) {
 		pr_warn("queue size zero!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
 		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto err;
 	}
@@ -260,11 +261,11 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	}
 
 	status = nvmet_install_queue(ctrl, req);
-	if (status) {
-		/* pass back cntlid that had the issue of installing queue */
-		req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
+	if (status)
 		goto out_ctrl_put;
-	}
+
+	/* pass back cntlid for successful completion */
+	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
 
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
