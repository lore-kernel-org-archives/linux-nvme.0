Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C16EC44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZNwHp1WLvUb5u+QxIV8sWET71/YQVNBNKDMDCrQyGDM=; b=Xvl71Vf4JzlexcL7imYl4datMv
	W3gDGdKZ9ek04soGNw9vwpPQlFnX0dlSjsyxhB+Lg76lO9M/RWpwFnrJ8okDIyU2AkFMAShN85WEp
	0QFtbM1c0TzyDbflg14UGsrTp4PeKy9BvjtXJNwuRLUV0FuTtOGjyB0lM3u2WDawJeZYOmsyqZ/OA
	LHiGXr7hZotJVLML32MZmIuAIAKi83N5h8teGDuaJeexjfhoL0JEe2ZA0ZcoUcZ2DItatjftNT1iH
	EyqnmA2Yg07tIooH9kttKV/De+DcYN9+DKfJgE6dnBkrCxN03uBiWK1O6qnZrlI02bIay9diwbA1U
	CyDNpwwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFt-000000094UM-21H0;
	Mon, 13 Jul 2026 11:55:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFm-000000094Oa-2uxK
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:21 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fYdU1740140;
	Mon, 13 Jul 2026 11:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZNwHp1WLvUb5u+QxI
	V8sWET71/YQVNBNKDMDCrQyGDM=; b=XuEA7eg+dRNi4AomCSmXRMxlQjKyPolhP
	o/utX/Cq/cBQHlUxBJvcAtbxX6jzBK3u6VY/LLl0eDUkCOIhsHEdEYaluBQUf2b8
	KYI5TOsPDqE8LAcgiV01OtkM5BswJS5VhTjZ/AwzleOWRES34gJD8ivvk8AgLC/m
	diFyzuAvBNsJH92yGGQyeKU1Rr3KCVm2mw6EKHSplV7vUNSFLxKUT2yvgXjREYb6
	qZMDuLRVe5F5ojwHUDoRCorl0ssRqkWUvnkIlO6sWg9OdZYeUnBUxbcztuIVR/5c
	sf2ie3dBAI2+z8ZJfgy4ZGOiKNBf+lTZ8lK26ySOpyUlLomsCjhlw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt0f9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBndB9006908;
	Mon, 13 Jul 2026 11:55:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pwnvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBt1Y842991982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7EF42004B;
	Mon, 13 Jul 2026 11:55:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1B2920040;
	Mon, 13 Jul 2026 11:54:59 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:54:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 02/20] list: Permit context-unguarded access with list_empty_careful()
Date: Mon, 13 Jul 2026 17:24:03 +0530
Message-ID: <20260713115444.465704-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pBXu_KgKEnzESMAVMVi0knc0nyS4Hqn5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX0PJWpUfvdfx2
 uIlnjfkKrVsicG6eqGstkmC8oQb97wqyMO/G6WB9qqZtjdAIP60obgKZsfouqKx+B/If27wYne3
 mmzX8EIrm2ZSJrc8JymMZMOf6oeJPPg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX6l3+y5MTFnws
 AZXkW19M3LTmTvC+OGFFaqeNOmpxh/B2pNy3FagzsR1PgKQecDKjWbvqwjN88xOonohBjUQCRxL
 zqrmPXTMT7qBgVUM+ILNaleCN9AFSnnxBXXyUJwlaEn5XnVctJ/A0wYNEXuUjc1VWbfowVYztYU
 W3ROqLpMidafFM+T5/VNi/oISfuzqX+QPz++2LuZcuVIBnWmQ8gBM/36TUeP2/Flh1HhIR7OL/d
 POgFSFqPM2nd2xgv1F2ChmYEXqx82gjxaGvWtp3p5nzC0VScn7yNHCO9eomc2SOpTWpz6ngTPJ0
 dlzo7d+NJHr+R/gBEf7C0zkgaIQDCAFIheKMqollnL5gYOxwgz0fjaOEYhWuMS7izc85uytt3X4
 n/RK0ZXT5K5A46UIkiYMpHHx0Pr8MaR49KAOpUlkNEzbEKtck8ayAOB/A6gvb4P2dvXjOxCH6Kb
 V2c+bqiRywdZQ9afI1Q==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a54d21b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=4at8UNLr3tDfbFC0C8MA:9
X-Proofpoint-GUID: oR7CKBTJwnTWHzyfnKAHwgeyasazEjKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045518_771826_F0E59D62 
X-CRM114-Status: GOOD (  13.70  )
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

From: Marco Elver <elver@google.com>

With Context Analysis (viz. Clang's Thread Safety Analysis), list_heads
that are __guarded_by(..) require holding the appropriate context lock
when accessing and manipulating them via the list API. Because Clang's
warning diagnostics do not perform inter-procedural analysis, this is
enforced by Clang with -Wthread-safety-pointer in the caller at the call
boundary; a warning is produced when passing a pointer to a guarded
variable without holding the appropriate context locks:

  warning: passing pointer to variable 'list' requires holding [...] [-Wthread-safety-pointer]
           if (list_empty(&ctrl->list))

An exception is list_empty_careful(), which is like list_empty(), except
that it is permitted to use without holding any context lock (carefully).

Mark list_empty_careful() __context_unsafe, which disables context
analysis within list_empty_careful(), but also suppresses warnings
generated in callers related to its pointer arguments.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 include/linux/list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index f6f22c8b06f7..19212bfc3f6d 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -444,6 +444,7 @@ static inline void list_del_init_careful(struct list_head *entry)
  * if another CPU could re-list_add() it.
  */
 static inline int list_empty_careful(const struct list_head *head)
+	__context_unsafe(/* intentional lockless access to @head */)
 {
 	struct list_head *next = smp_load_acquire(&head->next);
 	return list_is_head(next, head) && (next == READ_ONCE(head->prev));
-- 
2.53.0


