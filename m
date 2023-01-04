Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA89C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=97lRTV1hHopwpRk8ybJQY1osI54OEk0Kr3fYLL6dAv0=; b=APSkGC/9vw4H8HrQeqs9QOhTSV
	7SMtt1GATDBH8h9Pdb6c4Dj6hKs8b6Z3AJxqpUXIpOkkFG95gSDM+woS25xMSx/+0Gnwm/24IES9W
	DtlcKVQw0O/oTTboZf4ltduOCdRNPAlReFuCsq0aJOZZt3WFfcA4f09c230ukQsHZ54xCwMQXJ2o8
	uioOOpYxKePjI9LOkGZ8MiP063t7VFmzc19awtOYk2/sPADrAA823o6jEp/zUCD5KsLZko4pIU8eS
	KlHb0HDkktsGEo8S8RgHwyU3ZsK5nYNz3LQZlM2+ljVhqDe+FwDTxPzkxKHJnn8A2N+SnNhrk54RK
	Owl+M7fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCzTl-007mjB-30; Wed, 04 Jan 2023 08:50:33 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCzO8-007k3l-Gb
	for linux-nvme@lists.infradead.org; Wed, 04 Jan 2023 08:44:46 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3044iwYi000854
	for <linux-nvme@lists.infradead.org>; Wed, 4 Jan 2023 03:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=97lRTV1hHopwpRk8ybJQY1osI54OEk0Kr3fYLL6dAv0=;
 b=FU4saetqgvnXcXREtNhUW/tQdSZsemkVF+vsc1s22u86IzQgJrspr6Bzd5Hf9jt7oFX6
 fED59YuBvgNnIZB6rMjc8MyYvxoTLGhKpJLLKoUH4rcC62DxEoebf5lA+ZMwZJKvytw5
 d/IGYRp1zn+8y5dZv+tLPoFoubS3T62CO+2MbI4mx6jYrC1TtkXEA6i/GLojW0XDJTw3
 Vwc6C/ScDKANlllXxVkpieQM7ZBiJQf/qZlOdDUlRvUhWtYde91Zddk8nYqC57q3RpMr
 TsMIttt0Ztmv1+BeV5fHagpmAd4pAfNYOdcZ0EPmjrAWl76SRjepVnqVfMN4hvND1w1F Bw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3mtjmusp3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Jan 2023 03:44:39 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3046XQMp003078
	for <linux-nvme@lists.infradead.org>; Wed, 4 Jan 2023 03:44:38 -0500
Received: from esaploutpc105.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3mw1wn3jp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Jan 2023 03:44:38 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="150821545"
Received: from unknown (HELO vd-engela.xiolab.lab.emc.com) ([10.55.227.144])
  by esaploutpc105.us.dell.com with ESMTP; 04 Jan 2023 02:44:36 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH] nvmet: for nvme admin set_features cmd, call nvmet_check_data_len_lte()
Date: Wed,  4 Jan 2023 10:44:32 +0200
Message-Id: <1672821872-3193931-1-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=958
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301040073
X-Proofpoint-GUID: DOyApIM5g7fcqvbXibwdkoC4-j7620Xh
X-Proofpoint-ORIG-GUID: DOyApIM5g7fcqvbXibwdkoC4-j7620Xh
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=980 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301040072
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_004444_965476_FFE55CE7 
X-CRM114-Status: GOOD (  16.90  )
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

From: Amit Engel <Amit.Engel@dell.com>

This is due to the fact that the host is allowed to pass the controller
an sgl describing a buffer that is larger than the payload itself

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6a54ed6fb121..80099df37314 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -840,7 +840,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 	u16 nsqr;
 	u16 ncqr;
 
-	if (!nvmet_check_transfer_len(req, 0))
+	if (!nvmet_check_data_len_lte(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
-- 
2.31.1


