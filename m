Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C30C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mxz0gQxo2YHYB3A4UklgIHArHv6YDiwY9qZJ7jpha1g=; b=nVdMWWvp+AZ/0CYKKG14fu2etk
	NvDV2xJBAiyOv1+dw2hh34PVnnWjfGbHFnR3qwgVvmHYgTJYKqXwdfv+xoSXA1rbn9FR8gl4pRHIG
	6Ch4PMD3zLsA0uhH/6UDjYKDG+T7BBryvgiUInRy0zVRE+3VHiyiX/pPmsxvaHNlLQH+Nw7XM3A4v
	lMKqot0uNcpetZiChwf2XL8XfGUk/BrIWoMrHTIqpGAJZQK2/g3exDU7jHaNwB9U05/T9PfNFZVgW
	a1lZgSzmHCxjetkR6ga4SDszTLAtFAIlHvjQrgpH7rYUsJ2ndA+h3KvwrEhQgQiU8KHMl2XBcChCQ
	kPrd4I+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk77-0000000Chwr-2Veb;
	Mon, 06 Jul 2026 14:16:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk75-0000000Chuz-2OQS
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:00 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIQ2B3447686;
	Mon, 6 Jul 2026 14:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Mxz0gQxo2YHYB3A4U
	klgIHArHv6YDiwY9qZJ7jpha1g=; b=iHorv7fZ3t7+GmVi3hU6T8dYT/0nE3KCy
	ZiitCIZBu/iVf/VwEiU+yTn73S8Q/SESaEnACdzZXmMrgPzRtpI1y9TDaO0fHerI
	sZJEk3XoVkUdpbRIKwadl7jU9Ng2K8bwma5Mku+4ruvzD8jWGW36/PFf4aAA4Mer
	TpF7Eu1E4kw/pqSgE+CyHRcExKEpHHAGAUTGo39mxuDpfn0jMiAsllT6hDEIVSYE
	CbW7I+r+NfRTkw2JQOwvodCAEipp41pujtLnf1vTdJ27pN1CmcV69Hi2L7rEwgxE
	/GjDkAcT9ft6boqbTgX7+nj0fhnNNj6GFHaTA0GiSPAaRh4vGiqUg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsjarn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4dBf024511;
	Mon, 6 Jul 2026 14:15:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xwk0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFkWp51380574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A2F20043;
	Mon,  6 Jul 2026 14:15:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D7920040;
	Mon,  6 Jul 2026 14:15:44 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:44 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 05/18] nvme: add context annotations for nvme_ns_head::current_path
Date: Mon,  6 Jul 2026 19:44:07 +0530
Message-ID: <20260706141452.3008233-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 53b2W5n8Q6p62WG3enYuXSFb4YuwlsH-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX7WdOlaJSyH1g
 FIi2JeX6Q43o+pI+l8uIOm3CwaM641wX35sxurW65KGYwn/FqW+SjmjzC+YOYYPE/R7+s6SG3hd
 XLGzF1hnaIez4aDvmdQKqB4PutegoKs=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4bb897 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TuOugfuq9IBefrGnjZgA:9
X-Proofpoint-GUID: Onuxx9ZHR6ynLmEdpskw4COoP3RlXJF6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX8B3og8rwEXQ8
 xGRSomD4xiN0YraKnDm0DuYJewpB+SsdZoVDRMg2cBjNgWt1W/AQGLzy0ABEiyogl/ErMx6RCVa
 x9Xoi2tqeiBH385JM781gU90RZVa8PCGDF7syXuJ2+NsyZJ+blGhQqzv6C4Lz96Vvj1ur9P1q3Y
 k4msuruCwR8Nfw+v5a6JBuz4aOma/pZzAfGVHiVLHEiNd8c85RKptGPRGyczpBeNfOiK5IS+GOt
 ARpSaNRPk+OJtyLuoAFwRTBF2PqnPe3+oqxoygwvsU8/PgIPqyW1lmeqMIbOCmsAcn1WenHe890
 zsnGmbZCLARimehRBKfDJ5QGXoTkdC8Dvo2pVE1VJA2/DzRv30q2+/ocvWT74vQBC3rN/vNJAt+
 WOcc4nAvyaaCryiDfCJjsCLNWUd/k1+JccksDx/0SzoWQkWaqANX6Ddg8bNw6+wUL+5fVF8jX16
 hV/JliPUS9D6iWdrIIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071559_728118_18309B0D 
X-CRM114-Status: GOOD (  15.28  )
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


