Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC942C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bKxboCO9RJDnoe1/2+byHzuPFK5h7lZPoqfHSK6jzS8=; b=diFVlTHLO0PA/mRRf9F8VCxA9V
	/XUnUvMoICyF2lXuGKm3FaI4bQQ057zUXGGO5c071YQrIHt+YR3/PbT/KAzs78OgulrAZksRxhqvp
	QL2eavlBfODDFP+efKfTjTvcuBZWWMcj5SPgOeAiQxaqEbyt0aCFM+MRFVmGAw54JHL9Hul+NW11j
	/V++VreKAUaR3Nx1cU6pno192Ek2KJwBu5UfphIED8teupUPItVfhDomjvEXCppSlClC3vISuosdb
	qxU5zcwWd8r/e8jfK0k92vyZh36zTTSFvCp+OjWQzv95HlJazDy+hc8hgoXkRGLGEoh0DJPETEf/o
	aumqsPGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFG7-000000094nb-1RaB;
	Mon, 13 Jul 2026 11:55:39 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFG2-000000094eD-2wZN
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:36 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6g5Ce1672536;
	Mon, 13 Jul 2026 11:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bKxboCO9RJDnoe1/2
	+byHzuPFK5h7lZPoqfHSK6jzS8=; b=RfNjB1bPG1XOEvBZ/g8ipfl28DAxfPiV5
	OjMUMmiRnMwQYDKocnRqJIPEjaqXaMXDpgWEMaXdAfRc6Pj7nVXQkKQ/IW+g7uJl
	B3BPlbZGfAQpt33BIswVACp5PF4VxZStkzyyb5x8Iqh4an9WINTHxVocs9dnHHA7
	lKBU1S0MdA/o8Ux+lTGXhLlH18PbLVX+anw/Q0CeJVE2Dz0wx0Vln9ydzPRBTvr9
	nKL2Dz6PFmZbMM/IrjwfOHoDu/02EcNNbBEd5Nl2xTPZmFcKj3ptpQP6CSuutZPB
	kNhSmmUFmSHUR24xSYiX5CYdpDN6485R6ii7omXXtYJoPFriSrhKQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a01ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnhsE001929;
	Mon, 13 Jul 2026 11:55:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg58pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtNE638404484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 149DB2004E;
	Mon, 13 Jul 2026 11:55:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42A0A20040;
	Mon, 13 Jul 2026 11:55:21 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:21 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 12/20] nvme: add context annotations for nvme_ctrl::ana_lock
Date: Mon, 13 Jul 2026 17:24:13 +0530
Message-ID: <20260713115444.465704-13-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX1EqSEstlvkYI
 eKs+PBb/P0qfWZPzlWd0MoP0xthtRBHQE8gA0DjY5a+R+oOZlRwSJPN6mD/EWijRdcxmG5I9Rjf
 fSeST17xq65AHoCxzU8yEMdLYB+y8qw=
X-Proofpoint-GUID: 2l4JzMV2DhZm3KVCEszizGQVAFYy3dGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX6ZApbsauEarA
 B2tO0AYbpefW5lguAW+vcwD+IhybUIDtHOGjWXuaaP1Ey85CVZtvF486dqy3oJgjjiu37VOcYmZ
 RV/yxSB7FjwMd5D2xFuV3XgQF4yPinjspJ313QPzGOMof2fxUgRlAKO8wbJ1C371wQTvMoTurWB
 ttFLshXO/QtIhL2H9+FzWbCEZg83swsKP23TRS56WWlRwuljaV2e6X7xN13wkn5dPcN/R1rOSoA
 ApY45GmOPyFPLImJ6fhiaKtrMB9z3kdS92NQjc9kUSkofeJKYvS/xzVNkLFB6ws7kGvnHdc0JYI
 oZRNd9IwJX07lHq1hqUabQIUytM1NWNaB5kugSuhbUS6ZybcNKeO41131uRbneqIIBhzylONHDm
 KEyiyQtC4rynLF4cVnx4mHlxHUVeYaUC4elng+eYeZnGcJVR2sKF5bC2cK1Dg+gOzURCU3jpnPN
 T5TwcIO9754j7NmonYQ==
X-Proofpoint-ORIG-GUID: w_2gv5lushqVimUQlyRFebiIB_fiu3uZ
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a54d230 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=dKw57NzDpq4Cn0Z9zg4A:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045534_900504_0C414F0F 
X-CRM114-Status: GOOD (  13.01  )
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

nvme_parse_ana_log() accesses ANA state protected by ctrl->ana_lock and
therefore requires callers to hold the lock.

Annotate nvme_parse_ana_log() with __must_hold(&ctrl->ana_lock) so that
Clang's lock context analysis can verify the locking requirement at
compile time.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 698d79a97045..d714852ddc01 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -829,6 +829,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		int (*cb)(struct nvme_ctrl *ctrl, struct nvme_ana_group_desc *,
 			void *))
+		__must_hold(&ctrl->ana_lock)
 {
 	void *base = ctrl->ana_log_buf;
 	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
-- 
2.53.0


