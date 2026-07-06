Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A02BC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3J85hvmz2E9i8XDjgZ5G474hTVS6CIbxarQmENkbdAE=; b=ZYzHbU/T+7PEp9dpwbd+WtfpeU
	0fSOfUsheW95xFX3iYm6djoEK5mMmNU1m/5bwbE2cQ7TCW/6mVUvHyJU1qRtfmOlXcEbOw/nFTku3
	uh5tDmiTf1S5MsQyC5A8FLM7cPdySXKtg0rtVtgDQEwcWrk0uJox3mhgn3lXD0iA5uXYOu6xwyaF/
	s/7RBO4cHz8JQUtqMtuWvcqrCZ30Cb9iEZPXxa4F+DHXNFjIh1htl/Eiy5IjyFEfuiHlheDmFxqMO
	n/SDcjRhPhegpB9iMXW0grqQMUWSKZQ+cEIEdrYF9AHX5BmweXOMoyiZauVcI+/nJ1OtPpGaJUbDu
	vSiOOi9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7J-0000000Ci75-1R0i;
	Mon, 06 Jul 2026 14:16:13 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7F-0000000Ci2u-45qm
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:11 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIRRr041311;
	Mon, 6 Jul 2026 14:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3J85hvmz2E9i8XDjg
	Z5G474hTVS6CIbxarQmENkbdAE=; b=msyUxuW3BUrYoy82miov/k/76U018xkDP
	c64ENbT6NvQGnaCGnxYQULHrMCPqqm+tOxLxYelMNrbxJUQT6sxp1+DpqSXFnsAF
	pTn17xNtExytNymZD8vel5RufTwp6eR/rQoZjw/O51sGeyYel8Xzuc022BLlR72j
	9t44WQu1K0CTrKBx3rq33FSM/l2rcaVhGmsvfFt8CPokF4lS2yH+r4AxAu8dCSTA
	rgRusVyEqqncByWiOslpk3DQojUh3h6NtFDLd2AnMKfvw8Rr1OQ8lgfT1CMYitpT
	6mG0IFjrx3lCOD7y2a01u3pj+uGe9jLytO6Rk4Qwf2ysny1LW8yew==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn9x2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4dlV015309;
	Mon, 6 Jul 2026 14:16:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfwp9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFwax46531006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ED9720043;
	Mon,  6 Jul 2026 14:15:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B6DC20040;
	Mon,  6 Jul 2026 14:15:56 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 09/18] list: introduce LIST_HEAD_GUARDED
Date: Mon,  6 Jul 2026 19:44:11 +0530
Message-ID: <20260706141452.3008233-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4bb8a3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=yEdB1FNURbGifd-vTGUA:9
X-Proofpoint-GUID: eZ5ptmhWKkxdJpQLwFUMWjw-EJY4FLG6
X-Proofpoint-ORIG-GUID: NnJjfAx78N0ig--vMUQxXrBcx_aCD_le
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX0DdfheCFAAZC
 wrePBjcdpXMLL0+ilkmAEdfNjG2rXyFlgiyPbXkFgLYcHu3L/U9abY3J1FgxwzE6MzJfmR4ZPsC
 XNWuryaff2S/TqTuuB0e6vbE6ZsqGO8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX8rpIPUJw0vIo
 gj+4f17dJgR2mIZcq+rnUXh/CDyojx0LKpMOiCHC8NgXs8VW5LRVFegeNLL6tTXc07Y9iZCKIuv
 uhcrxahyMgYSIM0WemzIwcaYZC+BDRaT/RYAFc+l5sATbieRTtyp9MNzWaN98YQAJtSj9YzStTd
 BnS248ZCWLZ15zYTkHrAtPKiGcY7GcSajm9KwQKNvaRjsLepwu3BcNPyJtVB3+TzJeetssp0NJz
 d5SFze7sjlN8afv1bJIcrJCHlhT9BfhMLyJ3io/a4lxLo1TWVWFJQXQvdq4IrpEjanvBhbP5zFZ
 LCfmGPcwoINezqreZG36HbDbllO0F6Nr0Q6c2aBIr9aKSiwiLl0D5M5sZ2pzmrBZE4bN1RtIAHC
 tNkDs5Hl5DwOC0JepUQmQatpDrRBm0Ay6u6q+QngVBHP/u5H3NLMvkTJ9vaK3BuEmlFyIPtO1Uk
 U+XLqHcNdrK34bTvlKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071610_160125_1EA6E835 
X-CRM114-Status: GOOD (  13.52  )
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

Introduce LIST_HEAD_GUARDED(name, lock) to define a struct list_head
annotated with __guarded_by(lock). This provides a convenient shorthand
for defining lock-protected list heads and allows compiler context
analysis to validate accesses to the list against the associated lock.

The new helper also reduces boilerplate and improves consistency across
callers that annotate struct list_head objects with __guarded_by().

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 include/linux/list.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 09d979976b3b..f6f22c8b06f7 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -33,6 +33,14 @@
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 
+/**
+ * LIST_HEAD_GUARDED - define a &struct list_head annotated with __guarded_by()
+ * @name: name of the list_head
+ * @lock: lock protecting the list
+ */
+#define LIST_HEAD_GUARDED(name, lock) \
+	__guarded_by(&(lock)) LIST_HEAD(name)
+
 /**
  * INIT_LIST_HEAD - Initialize a list_head structure
  * @list: list_head structure to be initialized.
-- 
2.53.0


