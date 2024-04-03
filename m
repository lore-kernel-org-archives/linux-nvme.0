Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C16CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WL5CrUA4/sJ6f0fIa9fx4wGkaAiaAhR6FB8mxTgkwMw=; b=Hs2Rw8ZGBv63cs
	UFLSahnjlwGKKrY7sZMHLE5VC91mMVRnJtpnhc5tb7SCPu9t7FuHZmHXA2/YE0/pDmpfNEUvPK5sY
	i6vL5SAVtX3+0ZV371rcdk/8FG174hNGYjLxB/kca6Gurtb+e4P6GtzKcPXib36a1Zswy+QDJjcvX
	IfbbJGUR2wofzc0P/Q2ttAknQ4Tl6JkXRWH7oU70RKpMNb4S8fTMdl7rX/pt1JtM14b5RRCfEAGJr
	e7FdzXNDtVaEn1KpfK73o1t5sU0F47U+K+IRIRf8j/mfLKkRLDC+C9run4zjmIH/0yxpbwFnXag/L
	7MlA6Otmy5m31AxaLVuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs0lT-0000000GFCN-3j3R;
	Wed, 03 Apr 2024 13:34:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs0lO-0000000GF9f-3n9k
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 13:34:52 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433DQHJM015064;
	Wed, 3 Apr 2024 13:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=WL5CrUA4/sJ6f0fIa9fx4wGkaAiaAhR6FB8mxTgkwMw=;
 b=rIRzGgoDtlb5tjGtGPUHmZutX7pQJWVgOMyQdTaKobgrpDr0Uec4hWmcTrUKRYtDRSmJ
 S27KyLQBTnjALD1vPzbez4jb3eU1/Ld6gzHlm1rnxuvGtACbMIcyQ3fZKfbfZ9rr3oRh
 zxm6rp1JS45k46YvXl/1aw29c1tDDfB6CCKJhC+JPJw6+5WbWZac/Hg35Y7oNf0VDG+j
 a3q48+Bw37EsisVDPsm7XZS4igM6G+rsd6Sp2lVpKzzckY0RC/oqSRH4kfi2f7PnQ5/R
 c6GMKV3dLdMJYgCdzxa2W6M98jnoxA9FBu5Sel/MTVmEEuInYGoSe0sXOzhGkYfctH0l QA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x97jn03cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:34:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433CUWSE002195;
	Wed, 3 Apr 2024 13:34:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjmnc62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:34:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433DYgRL38666728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 13:34:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06F7820043;
	Wed,  3 Apr 2024 13:34:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 629F820040;
	Wed,  3 Apr 2024 13:34:40 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.231])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 13:34:40 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: Amit.Engel@dell.com, kbusch@kernel.org, dwagner@suse.de, gjoyce@ibm.com,
        nilay@linux.ibm.com, Amit Engel <Amit.Engel@Dell.com>
Subject: [PATCH] fabrics : allow host to create duplicate connections to target
Date: Wed,  3 Apr 2024 19:04:16 +0530
Message-ID: <20240403133438.161916-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NrSHKs501wf3hbU8xv1JkvGdO4GJE4Lu
X-Proofpoint-GUID: NrSHKs501wf3hbU8xv1JkvGdO4GJE4Lu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_13,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_063451_065492_0CE23931 
X-CRM114-Status: GOOD (  18.43  )
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

Apparently the nvmf connect code doesn't allow creating
duplicate connections from a host to the same target even
though user specifies option "--duplicate-connect" or "-D".
This patch help fix this issue.

Fixes: 07d6b911e081 ("fabrics: Do not attempt to reconnect to already connected ctrls")
Reported-by: Amit Engel <Amit.Engel@Dell.com>
Closes: https://lore.kernel.org/all/CO1PR19MB48850C446CA2FED70F7E5D69EE3D2@CO1PR19MB4885.namprd19.prod.outlook.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 14682907..0f55c617 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1001,7 +1001,7 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 	};
 
 	c = lookup_ctrl(h, &trcfg);
-	if (c && nvme_ctrl_get_name(c)) {
+	if (c && nvme_ctrl_get_name(c) && !cfg.duplicate_connect) {
 		fprintf(stderr, "already connected\n");
 		errno = EALREADY;
 		goto out_free;
-- 
2.44.0


