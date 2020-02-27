Return-Path: <SRS0=7/L5=4P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_SPACE_BRACKET,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E0BC52D57
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4727B20801
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pFneke9T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="qeQ6eX7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4727B20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=UpUv4tNRjuEvTltgpmCxNPWlFGoCF7MJBoOJkcuUTzQ=; b=pFn
	eke9TTnMnbv5WDa7EHMqr0ZMP71cbvG+AmvjZAoUVwrPSi1+Ge9z0MWfM5QYejcdJnCClXTHs8Cmt
	2yPMv0JQO1qJs22TLSqu1z/r1G9L1EU5EjhUCzJ2kU3f0R5IVaO10vsroATlzVh8RddLVou0gaqMo
	mWDhwF2nfpYflsGNh2ba12gYKAREwXncIlCgDd76G3NHBH3qdHzqyoVckFSyB00Opv5xX8K/f87As
	9wxFzhivGXC9tP3A9a5DdMnFESjLX54CNKNlp0UMxiqYAWK91879L5oakMCjGPLeiM8QxFTM34Tni
	QmUNAY3nZjBucfhz9CN3W85R0EoqI6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7Jz5-0002u3-DW; Thu, 27 Feb 2020 14:17:51 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7Jz2-0002t0-4W
 for linux-nvme@lists.infradead.org; Thu, 27 Feb 2020 14:17:49 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01REHNgx005860; Thu, 27 Feb 2020 09:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=sUUmcd+Q/tinQ8uQn1pKCRpczxt1qL2enI16z49BedQ=;
 b=qeQ6eX7vtd64//8ip+PByqogs2nswWBnVIQErB0fuvSztKa2ctBkPbzU0b+1TE8UXmFw
 av9X3tRLfsiE1Pl+hkhbnTP3tPIE7RE55xLBR1ArDvBwVmCCc7MKllSEDiki7duHu6Jx
 DDizBbgb0Wt/SUtkFFwDulxxGNnyvAgHj/DBha2wX2yOlDn3CEmqDO8ree4BDt84sQKP
 VqpUyk7r2yHmwQCbSbxCSmfluD7jDCL4n+gcEBu1GuBkYAB5Tds8KMAdtZzCoJJKjPem
 lYIArkddbqbw8V0FGiGU0nls7nXzgBB3W2c5Nzrtr8euIzLchwxmDynUcra7dl/qgjrq 5w== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 2ydckvqp32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2020 09:17:35 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01REDhdd050565; Thu, 27 Feb 2020 09:17:35 -0500
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com
 [128.221.224.79] (may be forged))
 by mx0b-00154901.pphosted.com with ESMTP id 2ydcqvxf62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Feb 2020 09:17:35 -0500
Received: from emc.com (localhost [127.0.0.1])
 by mailuogwprd55.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 01REHYhL000676; Thu, 27 Feb 2020 09:17:34 -0500
Received: from mailapphubprd03.lss.emc.com ([mailapphubprd03.lss.emc.com
 [10.253.24.70]]) by mailuogwprd55.lss.emc.com with ESMTP id 01REGvUu032526 ; 
 Thu, 27 Feb 2020 09:16:58 -0500
Received: from vd-amite.xiolab.lab.emc.com (vd-amite.xiolab.lab.emc.com
 [10.64.137.6])
 by mailapphubprd03.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 01REGtZa008332; Thu, 27 Feb 2020 09:16:56 -0500
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: return Invalid Field error on set features cmd fid 07h
Date: Thu, 27 Feb 2020 16:16:52 +0200
Message-Id: <20200227141652.80584-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.16.5
X-Sentrion-Hostname: mailuogwprd55.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-27_04:2020-02-26,
 2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=989
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270112
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200227_061748_347910_B8D2785D 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: Amit Engel <Amit.Engel@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

If the value specified in NCQR and NSQR fields (0's based) is 65,535
the controller should return an error of Invalid field in command

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 19f949570625..f76b44768100 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -733,16 +733,25 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
+	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
 	u16 status = 0;
 
 	if (!nvmet_check_data_len(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
-	case NVME_FEAT_NUM_QUEUES:
+	case NVME_FEAT_NUM_QUEUES: {
+		u16 ncqr = (cdw11 >> 16) & 0xffff;
+		u16 nsqr = cdw11 & 0xffff;
+
+		if (ncqr == 0xffff || nsqr == 0xffff) {
+			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			break;
+		}
 		nvmet_set_result(req,
 			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
 		break;
+	}
 	case NVME_FEAT_KATO:
 		status = nvmet_set_feat_kato(req);
 		break;
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
