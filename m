Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C428BC5CFCF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 23:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j5XO0Ftejnu2x5mCX27AI7amocnEUZMn2SqbBK6AAi0=; b=J3674QjCm8/CrrZTep+MMeYjY5
	jTw2DdgUE25nogvDTFfuZPgQCuVsh/Cz+j1WMPSBeItE4r5QTEiK+iUa4GB6gpgi6b3o0KUSvEEjz
	dZFriTIkfE8U5hKNUq3BIuXI4A/frbeuW9UHH86A+C68BEqrSygUPtGXDbyaQyGmQXp1mIQsYVHZM
	a8cLFiOX1aCxClxgTZo9a90/t60bj4jwdpUtUrRR7YA4GVEu4pSOsbC/gP0nuag4cHPxl0RpPKUTc
	OL6b5UAVLP1rkkyRzDzF8aymaPCO9dKeihIEU7hl6dHJiRd8Hl28hT1/4XKktakT/sX8bAXXmahMb
	smuddDnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtwA6-0000000F6KA-08Jh;
	Tue, 11 Aug 2026 23:45:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtwA2-0000000F6Jp-3fVu
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 23:45:35 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BNVSWM1797079;
	Tue, 11 Aug 2026 23:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=j5XO0Ftejnu2x5mCX27AI7amocnEUZMn2SqbBK6AA
	i0=; b=NFv4MxTlRLXREW9scinwZm8BsN6xKunurhsidV/ZGhB/Z8cGYSvq83+sS
	o75mIL7fm56SHIgyQwKF5yookzl21lyMXMSCzTzyqEfTPBF2TTWTp1p6OCn7kwHz
	+wVB76RAL/6Rvj8hXaF2K36cSriot3SCBT0o+WQ9ZqZT3iwpvBZ38lhj7cykB92a
	aP5FNho0D1GO0RxWip5yF2csPikIrWwon548cK9ZON5NuSuSU7egIjyGTy1NCuIo
	t1T7jPMS+bsNpJ+Pi41zMuVQ7Qsl6o8p8PwS2hffrDapoz9BuHnGW7lciTlJnMFH
	1OZW6gE2w5WHEM2g9T07TyKc0ycPg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9frq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 23:45:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BNfqiJ014861;
	Tue, 11 Aug 2026 23:45:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w3md8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 23:45:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BNjT0m31326616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 23:45:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EBC358056;
	Tue, 11 Aug 2026 23:45:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB10458052;
	Tue, 11 Aug 2026 23:45:28 +0000 (GMT)
Received: from ltcrain119-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 23:45:28 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: linux-nvme@lists.infradead.org, kbusch@kernel.org
Cc: gjoyce@linux.ibm.com, wenxiong@us.ibm.com,
        Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH] DMA mapping leak in error path in __nvme_fc_init_requet()
Date: Tue, 11 Aug 2026 19:44:51 -0400
Message-ID: <20260811234451.633638-1-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SodGjVR1oHRkpJcomWrCNtpSYMjpfXC9
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7bb41c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=LX-qTxKwgSROWho_uCcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE5NiBTYWx0ZWRfX7zsQAwlD7uc5
 mqc/X7XnbBblFu6DLYLhDEuGASPV3s/EomcKwvclv/aMsYvPYbfneaQ0LoWIf1YDTJThJv+9/N+
 /1QO63buccBmKuSyizxAp7VGZF/ck6Y8h+Kf0a5dS8uaZH7a3P+Kqtfp8j7WepJz/UjEHyirz8g
 keP9TmUokCK2XJJle2/2SYd4EitiJkbBFs3bt1iewsesLYt8kXrbU+HOlbgr6wbJxSMX7CVdTu5
 jLBuOBplrW2RfZh1ElljG7NTzfdl9/p7pR5h09Aunvfe3IpTngnpv5XnIPD4B6PdFZw+gdufgyV
 3gojxtAkjUbRcNjJSY4RxlXL3VmJi4Sfw9Tb0oz0o4Q14UX473tZ2pxXWhDDfmCXMEy3QS2iPM6
 wgROPbR+vOHcqjGaaSUV1gi9F7StryMCSEyb6eQvOEmoPMtXxJw4go9Zcvz5yVi9afH0RzlXU3N
 J2zScZj5klzEPAxFbBA==
X-Proofpoint-ORIG-GUID: SodGjVR1oHRkpJcomWrCNtpSYMjpfXC9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE5NiBTYWx0ZWRfX1Ds6oN0mzuiA
 ZzVbuehJtxECmAnWTjMsUR5U7L65YCkUNtF+2Qyfh1iYZXzWQJoPM3yf9eo8vWdPCF4KnFvehW0
 Di3kvMdGDxEt90NqujmHk0iS67etPrI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110196
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_164534_924996_82B006B5 
X-CRM114-Status: GOOD (  12.00  )
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

From: Wen Xiong <wenxiong@linux.ibm.com>

In __nvme_fc_init_request(), if the first DMA mapping for cmddma succeeds
but the second DMA mapping for rspdma fails, the function returns an error
without unmapping the first successful DMA mapping. This causes a DMA
resource leak.

Fix this by unmapping cmddma before returning the error when rspdma
mapping fails.

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 68a5d971657b..7684fb053963 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2129,6 +2129,8 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.rspdma)) {
 		dev_err(ctrl->dev,
 			"FCP Op failed - rspiu dma mapping failed.\n");
+		fc_dma_unmap_single(ctrl->lport->dev, op->fcp_req.cmddma,
+				sizeof(op->cmd_iu), DMA_TO_DEVICE);
 		ret = -EFAULT;
 	}
 
-- 
2.52.0


