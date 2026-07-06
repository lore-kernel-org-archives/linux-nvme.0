Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4325C44500
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVqYHJTGwHjJRZvPxZaIIdOFYX5q7SzM+IrdknWaL1g=; b=XZnZ4POQ8W7thQH0mxUe2DEg6Q
	grpwYwQxbe3XnYHAt9V1gHe3w/fpNOaDQ0FrIrcarb2q5DzwbtlIpDb+g+Po1KFv5ncnoQJRscJGD
	+t97y4UfXwS2bGJShigrBrc/rtadnQmSxpkjiFp4ShsD7p8a7vwpTtRqr2d0cpwAcYWFqCSLqcPLu
	/LBQ1TOcFE2S2Fw/rbBLYiiNDu0ZgIyssufHWkBVprxy046jv1gqmi61NxO/wBGRJfi3beL8r5E8w
	wUEm3nu663hMKryHI9eJ4lBqgPdPagELduIoi0YMFwagNaCuMdZclIX5AXs9F6zw8rqoWgZVn0rnE
	AHJl53Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7H-0000000Ci54-0sfK;
	Mon, 06 Jul 2026 14:16:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7E-0000000Ci1p-1FfE
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:09 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIO3M4094107;
	Mon, 6 Jul 2026 14:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sVqYHJTGwHjJRZvPx
	ZaIIdOFYX5q7SzM+IrdknWaL1g=; b=r8y7g6yrOtSHXlwR7RUg3mtcb/xJRLyXb
	ey0tOTUhXzJABnWE5vAiVUIvvM5p1OvDt1eldQfpcn8OmFiCC9KYcJBFFdFJKV2D
	OqgdVzWSj53Yt3onRzRq24daS8jE6D92urBqU2Lvbqb2kY5akjb8A0Shn+mYCPaf
	s9bumXz1y91VbzJ3pBLwS0u5GXzN1z9EYnnp3xord5ISfIaHMOnYuL+5a76Zk8Ew
	QOXuVFo9kR39//oemsVpjAHKmpyB44g9R48ZXco2vcWFAnyz7IUBMk3Nwb0wZOcz
	RvetlWq58ZVv2tXzB52aS1+lyJ1+gw0h+IHJNlDcWqIpg6pZeoqFQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4hsst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4bO6024482;
	Mon, 6 Jul 2026 14:15:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xwk1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFuPO45482316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6BE320043;
	Mon,  6 Jul 2026 14:15:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B09E020040;
	Mon,  6 Jul 2026 14:15:53 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:53 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 08/18] nvme: add context annotations for nvme_ctrl::ana_lock
Date: Mon,  6 Jul 2026 19:44:10 +0530
Message-ID: <20260706141452.3008233-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: effZwyVUZMQnREqnn3m-ayKEDTX3BEu2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXwvlkW7fuSlXf
 4s1HseyRIveyFVmsaayoMdqg5zWORLVAZ2OMk8jlB8wRFyikuDamwrCNbgcsA1GxZg4rrMAfc+1
 VANVKJJG8dIaykDXdTsLVZ8mUyLVZ3Kh/I97AO9xXn+MB+WnInRbut0Rtt1/j1kto5hWBttvNcv
 YUI0RoTN357Q8WzexXv1CKsdlnvjliZ3cfMVJ9p4OsfzM4pvracgTvcH+jnBIy5BjHQ2CDMg6UB
 Adk4Etf0eMnKA4Qch9f/RL8DUBES2Gd6bSRWGoU9BSNoT57dpG96hHdmTSK74g8484CC8R3LMDC
 8d9JYYqDMK6wVLnzc0ZpmANtHs5IbtJfi5l6S7TLiThtSUNq2/YeDQcKflSkvj85Xsp5bFzIz1q
 4fJ36OZJba8MlUCCGHBXfWNfZkspBkCRepxRlkv1L3ENTahE8kzshbavbsZw+VU6tgjpwsR8m4U
 slPzmop7NRTE/9NeLPw==
X-Proofpoint-ORIG-GUID: 58q7SpA72GhlY-JLMOikDSWp1bBTwAOq
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bb8a0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=dKw57NzDpq4Cn0Z9zg4A:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXyLhy3NolNU59
 mVHS1arcG6mvpL8l1w5vFjMFibJxisri55X/GJ/EDsa5EvytBmtLpp5mY/7ef/BMkYO1x9gX6Fo
 c2o0uRNhtY6oImPFt0YLoZIqz863wHw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071608_353526_BD12F024 
X-CRM114-Status: GOOD (  12.27  )
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
index 765c3fac2823..47d3a3b30a1a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -827,6 +827,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		int (*cb)(struct nvme_ctrl *ctrl, struct nvme_ana_group_desc *,
 			void *))
+		__must_hold(&ctrl->ana_lock)
 {
 	void *base = ctrl->ana_log_buf;
 	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
-- 
2.53.0


