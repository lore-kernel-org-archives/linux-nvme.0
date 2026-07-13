Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B448C44507
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlZg2WL9PhzUTcVOCL9j+gYbUADaKzo/Ork3fhiGgTo=; b=atdB1zDsaggbKgL2ItHywU6mn6
	wk8RhoyYlnKg0b9yLjQdt759qDciqlUB2918g54Yj5k8uGk3z74MlIIfs9tjYB6FLGc78JLY2qmKG
	roBJlUvkdubVLt/ZDkc71zugAjG0W+PjNQ/QQyXh9C7VVcv6arCsYRMPN+EK2sECmY3gsvrFVUIYK
	7tnPPg04EROgSE5JvcEsxcVnC7arLxF9BG5deYJBEfUcwXJUQIrFx7DU0gekPwkOsBgwW98w2nhC5
	wY+eJGe/bKyNnoZtvITJvGs+o4wz0QZsidqoF3foLF3G880zdOG+KFshboBcs4BA29NdX5dlS924f
	NtKUx7OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGG-0000000954x-2Qkc;
	Mon, 13 Jul 2026 11:55:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGE-000000094yq-0RIB
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:47 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6gPdx1669232;
	Mon, 13 Jul 2026 11:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SlZg2WL9PhzUTcVOC
	L9j+gYbUADaKzo/Ork3fhiGgTo=; b=Jno+35ETnwEfslaPCNOpsLGWqziKqlAVu
	BmFzYMlNt2/m1O3FPcRa8h4Qzxm0xzYTvxOzztW8QaY4FV1AZCTdedY5cZtIz68m
	92fDHJHZS+F6aj7AuIeXAZj0fRZxlPzkkr3Ls3OY136b1FFj3UbH0idxfhwo6DES
	TQtcvEYB9bN7cr6pmFmFcMbox+50R+5DISPMV4uZl/BhdsgFAQxq8FO5pDeVFpYG
	7Oi1Ag0QKA6kl3wbHurG4LrjcVaSDpGZ0D1ONoj65i18dZZ2/lfqhtNQu0uue6wt
	YlmviIS+uYbcSwNggcCUQXt5ZbPYsJb8Cd93Y6svbXG7TZT+fM7Zg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwg1w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnaKl027142;
	Mon, 13 Jul 2026 11:55:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jnfvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtXT714811636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D59D2004B;
	Mon, 13 Jul 2026 11:55:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D498720040;
	Mon, 13 Jul 2026 11:55:31 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:31 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 17/20] nvme: fix context analysis warning in rdma.c
Date: Mon, 13 Jul 2026 17:24:18 +0530
Message-ID: <20260713115444.465704-18-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _K3Lq6yLPal-Fw4FKggRXtdwad9XgHzR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX8CxGqsxEqscA
 YGObHfWf7mzNC5FNsbt6JwAzLHcp4PEdTkQ/OPqssUH6EYO7tP0pLwcMBe7wBtwoSTW+PFBBXBI
 DReXWRcFDP+vR7ygaCNkyhAqBWFrkDN4qL13ja2Z537UuPbbShsUSlI6sk3kbdtBy6GgWbwa3AV
 2WjYfjG1GCKoNVeJOMxCCuOk62i6EndCTKLowaTwGQ4JKmZGq7eHxRgxH9aEF0XWtrew0QWTw8x
 v/LswiKu50sJHhsAJSFsLwL07/kjkC52IYW2K51n3zrD3w8ZcuiyF7HoKLTI+Wu3hB8uUs2EcRz
 +u9L8Oo3STIDYQ4adrQz+9tSfvgE+akwNOo2MeogU+et1gdIB0RGQFspvsRTrlmAbtf/42qxZDm
 iw3KXQobj8QLIrvmJFgOewqIqwLP5o4/hUhPvFCUVvKQwgbJ6J7dFYjDxV4OxTz0Tw2beOUAACL
 O5aeZD5J1WKpe0GU/KA==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a54d23b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=L-zbExpT5qCHzqbmkREA:9
X-Proofpoint-ORIG-GUID: u1-EEtZRuTsszOJWTJU5D-YW94gzRvHZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX67t28ReGyAow
 0n7+0RSYMTwkkRNtoGahBHjI2HzglFuHDND/610N5ARPLLjTjeU4ix/SQXNxmEA3Ctcj2O3WDDh
 YoY+s4VJhJgCN+bTVd+1IajJeLXzS0A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045546_353183_2A4A2410 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

After adding Clang lock context annotations in rdma.c, Clang reports
the following warning when context analysis is enabled:

drivers/nvme/host/rdma.c:972:24: warning: passing pointer to variable 'list' requires holding mutex 'nvme_rdma_ctrl_mutex'
	  [-Wthread-safety-pointer]
  972 |         if (list_empty(&ctrl->list))
	  |                               ^

The warning is triggered because ctrl->list is annotated as being
protected by nvme_rdma_ctrl_mutex, but list_empty(&ctrl->list) is
invoked without holding that mutex.

Replace list_empty() with list_empty_careful(), which is intended
for lockless inspection of list heads during teardown when no concurrent
list modifications are expected. This suppresses the corresponding
context analysis warning while preserving the existing behavior.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bf392035037a..cdd8837da03a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -971,7 +971,7 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
+	if (list_empty_careful(&ctrl->list))
 		goto free_ctrl;
 
 	mutex_lock(&nvme_rdma_ctrl_mutex);
-- 
2.53.0


