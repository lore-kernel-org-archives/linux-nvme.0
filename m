Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B424CAC59A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Sep 2025 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2dp2GZV9jrs18SyIzLfCLlKztwLE8hHG0Vpot2PpkE=; b=kHVzTTBnRLQY93iAVZGMOAbBl6
	7pgcN8NhFMhYU/Tu30V6inXNB+QS89dnhr/q/lO/B68cKvT+n24IP0qxopX8CMeWnYhB3SEvKEIHA
	2ZeJMHLFhbiOdtueuDHAafyZMD6UkkSb1I6ygKhxVQ1C4xf/ESOMR1u35WWggQ4t7gFcPezE/DjXM
	I2RjAFYzrpxLWzxGsX+uvWM1o9lKgAYnaqziofGdzeW/Y3RRhraWJTti5kcjr9DqbPGffzDnGiwGb
	ezzhhT3w86ZbbeLBM3+eervNRy+8d3Xl7yg0Ybq+/f3eh4FS5IL2TAq4DvR4zbwQYIyZiozdUnlp/
	VrWp+ltg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I09-00000007MRx-3fCy;
	Sun, 21 Sep 2025 11:13:05 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I06-00000007MPz-0fuQ
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 11:13:03 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L8W4xQ028900;
	Sun, 21 Sep 2025 11:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e2dp2G
	ZV9jrs18SyIzLfCLlKztwLE8hHG0Vpot2PpkE=; b=U//p8MCfzxA1CzrDs008vz
	F7vfnbQQlmQoyJg31+2TKt3W0SAU1RCHox7I5jikhLZP5LtPDjOBNqp6l2nOGcXV
	S01tiptiCwneUlCHUO/j/tQDEbXIc+9p9BSzEj/uzjSNBBjPTangeya8OWOVT8qY
	/9D1VLpI1cllP0Ot/rWHAr4gwiOVJgII6PCqS5GYQwCww3QlJfNjMufxt8LlMO95
	nyYSMZVq9lC6g2OuehGZPz/wBUIquSWVhVFwZpCwE4sGt22nCDDqlwrDbn7n3JiN
	UK/xbNX7xqgTIg90hymH73BDBF8SoaDTV/lQEwY7p+DgYTmb/5axLE4dZ+8tw9yg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpjwan6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58L5iaAx029554;
	Sun, 21 Sep 2025 11:12:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a6krhr00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LBCtt448628176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 11:12:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45C0820043;
	Sun, 21 Sep 2025 11:12:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0CC920040;
	Sun, 21 Sep 2025 11:12:52 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.45.7])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 11:12:52 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        hare@suse.de, dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCH 5/5] nvme-multipath: factor fabric link speed into path score
Date: Sun, 21 Sep 2025 16:42:25 +0530
Message-ID: <20250921111234.863853-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921111234.863853-1-nilay@linux.ibm.com>
References: <20250921111234.863853-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68cfddb9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=NPz-_jcsiUfpbwu_A58A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX8aXwk96Lm93T
 MW9UcjpiOHbMhEMedjP3lQX+n6z+FJcZ+UkU9/46iAsaJ7zCvRwAo3xFy+zU3j9Du0yESonsJHu
 PdYVgZvGSscBu81Q1Y0J+p9z6Kt+RqhUGXrWn9BiHahv2c8AHiHU7dWm47bECiomHZmS9brmUhU
 52WBcE301c5r43C+2jexf5+pfABkAl5smwiK2HeAGa0jW4TVXPKC5cvwS1Sw2q5mlKhnnWSdZF5
 BJgSUscoZM4EIgnlB+fMmo3wiyteFejlOtRlJ5CwbWeDgFX+Q3bV1tl5Rse9q9nuyZtXRmEmbT9
 t0k5JqJ+iOFCb3SKozn4M3ICXdI2g3dHWN8pfPpb37xGSxzgk8j/8FPCMfcm6nhTdDg8ZiyrUsu
 fFOVs1XK
X-Proofpoint-ORIG-GUID: PI5PrnxN46gZxhwGcBbQSeLLViBsmQ8t
X-Proofpoint-GUID: PI5PrnxN46gZxhwGcBbQSeLLViBsmQ8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_041302_327984_7843F286 
X-CRM114-Status: GOOD (  19.30  )
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

If the fabric adapter link speed is known, include it when calculating
the path score for the adaptive I/O policy. Paths with higher link
speed receive proportionally higher scores, while paths with lower link
speed receive lower scores.

For example, in a multipath topology with two paths—one with higher
link speed but higher latency, and another with lower link speed but
lower latency—the scoring formula balances these factors. The result
ensures that path selection does not blindly favor high link speed, but
adjusts scores based on both link speed and latency to achieve
proportional distribution.

The updated path scoring formula is:

    path_X_score = link_speed_X * (NSEC_PER_SEC / path_X_ewma_latency)

where:
  - link_speed_X is the negotiated link speed of the fabric adapter
    (in Mbps),
  - path_X_ewma_latency is the smoothed latency (ns) derived from I/O
    completions,
  - NSEC_PER_SEC is used as a scaling factor.

Weights are then normalized across all paths:

    path_X_weight = (path_X_score * 100) / total_score

This ensures that both lower latency and higher link speed contribute
positively to path selection, while still distributing I/O
proportionally when conditions differ across paths.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index bcceb0fceb94..6ab42350284d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -246,7 +246,7 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 	unsigned int rw;
 	struct nvme_path_stat *stat;
 	struct nvme_ns *cur_ns;
-	u32 weight;
+	u32 weight, speed;
 	u64 now, latency, avg_lat_ns;
 	u64 total_score = 0;
 	struct nvme_ns_head *head = ns->head;
@@ -347,14 +347,18 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 				continue;
 
 			/*
-			 * Compute the path score (inverse of smoothed latency),
-			 * scaled by NSEC_PER_SEC. Floating point math is not
-			 * available in the kernel, so fixed-point scaling is
-			 * used instead. NSEC_PER_SEC is chosen as the scale
-			 * because valid latencies are always < 1 second; and
-			 * we ignore longer latencies.
+			 * Compute the path score as the inverse of smoothed
+			 * latency, scaled by NSEC_PER_SEC. If the device speed
+			 * is known, it is factored in: higher speed increases
+			 * the score, lower speed decreases it. Floating point
+			 * math is unavailable in the kernel, so fixed-point
+			 * scaling is used instead. NSEC_PER_SEC is chosen
+			 * because valid latencies are always < 1 second; longer
+			 * latencies are ignored.
 			 */
-			stat->score = div_u64(NSEC_PER_SEC, stat->slat_ns);
+			speed = cur_ns->speed ? : 1;
+			stat->score = speed * div_u64(NSEC_PER_SEC,
+					stat->slat_ns);
 
 			/* Compute total score. */
 			total_score += stat->score;
-- 
2.51.0


