Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6B7C5AD4E
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWnNaFayhn3wE4L0m1Hw4a6/ZNOJzasM9erMdCrpD64=; b=nk1tnhUjA8XwwukzTDhk91JpY8
	+Lnx1WAbojjosLcGoKBx4E88UzjqQE9xlgZVW4dK80XH2HXZDXpf2FETx+xeKEcnjK5w2SQyG5hug
	NKQJ++HKKKhEZhiCJwPvygotwEMdyBrJsnAys83Phv1YnmxwIWPf2akPQgqmQdV/+Qo+0orCPvxSd
	40G3i9H0OPr1NsKDHYLLbD//X+qkTqkc/dkBU1J62ZGSKnH6H+3LNuhbRUvI3lt1uB8UU1RK+Omnx
	MXDNWps8/oWiKoG+9FNw2Ll0EuhUKJcb5MlTd5QuH840nn0xpl0ZeI7dIEt49rC5y2rBN3mUtRyzr
	GZPrNSUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0TD-0000000AB2r-1kGe;
	Sun, 09 Aug 2026 10:09:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0T8-0000000AAwR-1OgE
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 10:09:30 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67992w9O2445748;
	Sun, 9 Aug 2026 10:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lWnNaFayhn3wE4L0m
	1Hw4a6/ZNOJzasM9erMdCrpD64=; b=tkmL7azrdQrfEIBxuVcisPj5ZXBBlNr69
	ACcmMlYaGO9/cwSECAdieIJ0faAJ7yscgNx4t1KVHAmTXh3Lbcz/eGyhfCg2UnGK
	ssWQCP5/okP66NiMyDa6jf8dGqD6CrtL3amOvA7PTcDkd5HWL2YiLkBhiBnhWo6W
	gxKkJj5HRNBGg8xkVPrCvoenarDhDXKgeyYcNiKqJ/5qsS8kAydkQHoiPD659Axm
	8zVoR9loRWeZwrmrK4OQ30x44P1e0An3ufNKDWXPSvv2LM3Opg4Ij6bD/BOFyGD0
	HLqnfUrhVPg4qswBLDVpyw+bVCrbb7s5SBGl6fvMPU68kQL/4CXdg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkckmm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6799uKjG030242;
	Sun, 9 Aug 2026 10:09:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vs47m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679A9Fl437683510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:09:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C302820043;
	Sun,  9 Aug 2026 10:09:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C729A20040;
	Sun,  9 Aug 2026 10:09:12 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.73.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:09:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v7 9/9] nvme-multipath: add documentation for latency I/O policy
Date: Sun,  9 Aug 2026 15:38:04 +0530
Message-ID: <20260809100825.2014133-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Lcm-k2kYRuATzgUoKjVDqYqLEqcLVHNo
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a7851d1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=5c6VxMoH-_C0Ghh2t7EA:9
X-Proofpoint-ORIG-GUID: 7h_j7NqabeqxugU0UMzotphPZHmv2Uu4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX8RbNj7PCRkDw
 Yoqq2g43dXxs/SDVkxniOd/PpScooY00zjfJY7kMf2Mw2ptDtLMJzCWo36FoSQNru6wxJHvseO2
 z/Lj515cWLoVUVkMxrwPtPw7jX84zNeqcZlxyv5G+UESATa92T4xpf4MvtMeXPxku688QVcjMw1
 9RLUFI5IOM1ngBnk4pwMK1sItaPLpcIFnHCscUKUOPG/IOpwW9kBq7rAo6Kbmrag3kwEEDCHUW/
 /yGF9F1f0sog9ZGE7byUaGMIjsx5ztDvNWEbGIGc6/AuTUye57RHKYhndKVEXsQuv9EKKWaar2h
 TsWOR5s6vOYZswcxC7WkHn4GohzYEfB97mE/vn/nIZM1D0zpG/EbImsiv2ZE2/ECVZQZe/boPVR
 YxTrC80wWoGKJ9ibWW2F++wQ5OR1W3Ptek3DuCh0U6Szun5mrVFwfaD8bEcWiwa94RcpsJucMAt
 nkGM029SHpdURGPN5tQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX5OhB95yh5uod
 u9HxIfeJBU/fA63GPsu6Br0tJGvzJpfUv2jzD5s/NGQlVBwwPnCE0sX0V0abgLnNzx19FQrhS5I
 MP9AqR69lATAot2GX+yU/riAsMrfIDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_030926_504384_5172DD7C 
X-CRM114-Status: GOOD (  12.55  )
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

Update the nvme-multipath documentation to describe the latency I/O
policy, its behavior, and when it is suitable for use.

Suggested-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 Documentation/admin-guide/nvme-multipath.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
index 97ca1ccef459..41a8054638ff 100644
--- a/Documentation/admin-guide/nvme-multipath.rst
+++ b/Documentation/admin-guide/nvme-multipath.rst
@@ -70,3 +70,22 @@ When to use the queue-depth policy:
   1. High load with small I/Os: Effectively balances load across paths when
      the load is high, and I/O operations consist of small, relatively
      fixed-sized requests.
+
+Latency
+--------
+
+The latency policy manages I/O requests based on path latency. It periodically
+calculates a weight for each path and distributes I/O accordingly. Paths with
+higher latency receive lower weights, resulting in fewer I/O requests being sent
+to them, while paths with lower latency handle a proportionally larger share of
+the I/O load.
+
+When to use the latency policy
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. Homogeneous Path Performance: Utilizes all available paths efficiently when
+   their performance characteristics (e.g., latency, bandwidth) are similar.
+
+2. Heterogeneous Path Performance: Dynamically distributes I/O based on per-path
+   performance characteristics. Paths with lower latency receive a higher share
+   of I/O compared to those with higher latency.
-- 
2.53.0


