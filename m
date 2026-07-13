Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD40BC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1i6d4hwoRxvcYPiwCzCA3z0Yi8e/soMW87XruELS66U=; b=ar4/7qbyxSvN91JqoRtCXJ7ROd
	sPg3oILf4GkAEk0cXv6NUgglzQWZSQv4DPTT2Fm7aI72j88CRJa5z+OWhj8wtxhwgoVilTyjajHFt
	+jMbUqQS5BEiPN+VS7DRBHtnYHl7ty2RIRhn9pxugLRuM4SaqJBnn7iRb3MguaBFjnYqgodPASC0B
	wV5v4xCVAoh+wb4eH63AuA7JnBgxBTcZpagRojcJ9aIsOsYOIOTcJcV2BVbnJZKyrQz586ZvrK7Ib
	qy87FCYIDUexerQytYulaE4gQM+6j+Ahqq5FVPOO18kKrDxeKKVpaLafOLL1HkDm4/eGqRIVpTPK9
	DpB/Z0Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFy-000000094aK-251x;
	Mon, 13 Jul 2026 11:55:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFw-000000094Y8-0R5I
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:29 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7vBPs006476;
	Mon, 13 Jul 2026 11:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1i6d4hwoRxvcYPiwC
	zCA3z0Yi8e/soMW87XruELS66U=; b=mMM5iOSmSmYbDs5JRzpJYjgBop+Arnluy
	uydUhYckWQLmUY/UxR+xICjQNBX7PHcPbDGSh3I2bLM7RpZZdQN+pxlSfnZm3RO9
	CT2CFWLftZMuAOSa3aDHIjiZI8nEI5N6SlaTCpTsXuNjGGA9Piy/UfIemw7ho5lE
	aCLyOLo301+Hb19Tr5mZvNs7kdWv3btNyXD4jVA/wr1GnDhxe1d3qn4xCsbXEDED
	3mJ44H8f+Jv1uCMttgk4xJftwd8hdVfChUIEqzQx8agJaEYbuTua4ToorvY9DsM5
	nG3xwAgxOSDZ1I8dfTBwwkn1ZKkXKSTPr3IN03uF1sDYCS2HLUk5A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv330xx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnfGB027150;
	Mon, 13 Jul 2026 11:55:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jnfuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtEBE12255522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 885992004B;
	Mon, 13 Jul 2026 11:55:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9234120040;
	Mon, 13 Jul 2026 11:55:12 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 08/20] nvme: add context annotations for nvme_ns_head::current_path
Date: Mon, 13 Jul 2026 17:24:09 +0530
Message-ID: <20260713115444.465704-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX5pHx9v+YSYBW
 8mi6QrH6XQuBan6VrCG5/Z+ocSIrrPb2mpuCyrwhOYul2M+Oo9rq+7uqpDb33aINEjwrpdhThRX
 OWWbHRGJGyy2KFnzLZ9qn7j91H3Eq1Q=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a54d228 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TuOugfuq9IBefrGnjZgA:9
X-Proofpoint-GUID: b6Pv_6aCkUt1aotHgJsq2mTnhc-MObW8
X-Proofpoint-ORIG-GUID: GwU0V2HzGffqwxunjWRkN7NWF9NDKbv8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX79O3jrPX9gl4
 iXzGHFW7G+Qvrx23WfiVsE5Cq0fmjO6R4x1lG/c4RTNWVOvaomoloaBDW7mK/pajiXLh/Ng9IeZ
 eJw4J9oC3Ln0/L1eWyj9py0x1t9ZUbRJ/H742CGtCrWyRzNEDtIfcA1huj3q7NVXriD5aPcRyh4
 hErSQeHDMj9g5RLgbdzNPs0L+uwPKjjfHv+wK1gy7Art1y0QAjb0PHdOYmmcqxk2UfYE8nbIFzX
 2HXczkBbrZQYTU0vZFMouHFbF0n93v2S7aTLPeJYgw45XMm69KgzcgWFvhPI7QLDKe2X+4TQd9Z
 tbwqkA/6fp7TgS3ojDpcshFD2pe91viGzmIK5HB8uaexvAtcotpvEa04gljWPMGBvD2pCi5LORe
 pZMj168yejsZuuC3IG3wFYmUW/Btc9lknbRcnBsu30GVQ9oWTIN7f97vQ+Yr/OwQo0tYIwijH3R
 QifDnbJX7BnYdZJnaIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045528_190395_7C0786BF 
X-CRM114-Status: GOOD (  14.91  )
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

Annotate nvme_ns_head::current_path[] with __rcu_guarded so that
Clang's context analysis can validate accesses to the SRCU/RCU
protected pointer.

Cc: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5e746ae1c805..610c685e2263 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -575,7 +575,7 @@ struct nvme_ns_head {
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 #define NVME_NSHEAD_CDEV_LIVE		2
-	struct nvme_ns __rcu	*current_path[];
+	struct nvme_ns __rcu_guarded	*current_path[];
 #endif
 };
 
-- 
2.53.0


