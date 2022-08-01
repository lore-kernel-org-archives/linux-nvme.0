Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130BDC00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=spn+RMQZMFAOvj44QnSPHt9L6ZXLy+q8YYSmBztX/60=; b=nG4Tp9V60AWa7iaXB/+xwNWOgB
	YvvsopHBrqHOe9PwT/sPM7GR7wPbo3acQ1y5ZrXAk3g7I8rRFasGUaHUGtYmCJSaqdIlAVbQFLrnm
	NU+VeGoOxgDNB88pv+eGKyAXInf7bo2rY3W5qAC5phjpG3birx5pxBxWiYFbY/WCFIHm7OSDPi7A2
	tWPdUB5eWWmaLgpDK8UGTzL0Erv0g95Xusvc/dWBJkJVzk+EiV8nSTvJ3wpuZHFTa/zX5S9IF302R
	JXnvTCewsu61vk4Vjmw8hKI4OMrsjWTgbIs6kb8hGx5kisFUXOQ0XHYuDPcJgPQHqLwj8yb0f/JrD
	XOw2XPow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaLX-009CwT-C2; Mon, 01 Aug 2022 18:40:55 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaLT-009CYf-MI
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 18:40:53 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271FNQrn025238
	for <linux-nvme@lists.infradead.org>; Mon, 1 Aug 2022 14:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=spn+RMQZMFAOvj44QnSPHt9L6ZXLy+q8YYSmBztX/60=;
 b=eugXuf844on7lf6dgxTSA6iMBBwbYRcPWUyFwKGjF1FnQ4T8E5DDjMPPkKr5htKOLsX8
 h23XnWTosjpVjjfkrb81v8tQvTIkPbsS3Bg03JHWz2L325AhZ7kFVlc3/Krz3QicrdUG
 tCLYK59dZPMAJb6UNuK2wrnUWW/fwuOgJC7eP+obIA486OC6Qk/54l5qF4+WJZW4UCMl
 xthFaEbgVIW9I4txjzcdDipkW9wmBCsWGLvgB/fMB4hqzO60PEDSEWNg23SlPeJV40EM
 X+Y0IdUwwoyic+PgdllsXvgNlHLx1wOCcs5i2cjH8ZwVzr0RuDEOSeqsAWSqzkhtnhVT Jw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3hn1aq6pnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 01 Aug 2022 14:40:46 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271HdU1G020312
	for <linux-nvme@lists.infradead.org>; Mon, 1 Aug 2022 14:40:45 -0400
Received: from esaploutdur06.us.dell.com ([128.221.233.10])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3hnj6be16y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 01 Aug 2022 14:40:45 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="211532629"
Received: from vd-amite.xiolab.lab.emc.com ([10.55.225.216])
  by esaploutdur06.us.dell.com with ESMTP; 01 Aug 2022 13:41:20 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@infradead.org
Cc: amit.engel@dell.com
Subject: [PATCH] fabrics: parse nvme connect Linux error codes
Date: Mon,  1 Aug 2022 21:40:39 +0300
Message-Id: <20220801184039.17593-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010093
X-Proofpoint-ORIG-GUID: 2p-OxyxOWtwABZ-SoPW1c6XNDOPMreLf
X-Proofpoint-GUID: 2p-OxyxOWtwABZ-SoPW1c6XNDOPMreLf
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_114051_994361_4C948426 
X-CRM114-Status: GOOD (  16.16  )
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

From: Amit Engel <amit.engel@dell.com>

This fixes the assumption that errval is an unsigned nvme error

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/host/fabrics.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5207a2348257..cc84c4ea251b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -268,6 +268,13 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 		int errval, int offset, struct nvme_command *cmd,
 		struct nvmf_connect_data *data)
 {
+
+	if (errval < 0) {
+		dev_err(ctrl->device,
+			"Connect command failed, Linux error code: %d\n", errval);
+		return;
+	}
+
 	int err_sctype = errval & ~NVME_SC_DNR;
 
 	switch (err_sctype) {
-- 
2.18.2


