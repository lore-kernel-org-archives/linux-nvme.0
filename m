Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C661606A325
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3oUEFWOP;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kl8U/7So
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LZBzE/KzY+3j5vfld6z8D+GXNnzSlCCckheeCXiKFoc=; b=3oUEFWOP7bDIxQ
	uxJgz5JXt+RAPGk95zch3d8bHa4Oktatju/S1Avtd2W3DlE5gaWWIQbwYTAx7B17Z0RH5LWwzmGx2
	zV64k56jqmK8HdPivKR5eWeLobe1+8BMke+1GxCWxEjlFYrvLdwaGcBqoEFGfPFP+TKPE6/uJaApk
	z72p46roj4AcazoeoM+E8ESWGSVA/wjDgIKtJy0uxz0MJ3ZSUVDTk165TvOEeogNPk6rhnjlzaBl2
	1+PK2p/cc1Tg5O4RJG6/43qjZkviAp1DeXYQ5CfreKeru2EYzWG+RCm1sgUEG2UixF2t51awaldJk
	PNponduBYhih/JidVd0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8B-0000000HDem-0dgO;
	Mon, 09 Nov 2026 03:33:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG89-0000000HDbz-0eys
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:33:14 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iGCv311549;
	Mon, 9 Nov 2026 03:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LZBzE/KzY+3j5vfld
	6z8D+GXNnzSlCCckheeCXiKFoc=; b=Kl8U/7SotsoLJ1IGQ+vZO2eAGIH31qMqK
	tdQhW+VDq0HlKQiYn+Gz1CIm43XRKMZKO1lEIQJGOGIgbzXsK7N5TGwY//LQEpRs
	IPsamhjZE/acKrZIrxhqzySsuC7fXNX8eKl2gIww3JQFEg4ZIeRYyizwxeKnm4yU
	EJkfhWCCKcAk9wARCtQ+thaKpqXmhxSxp3+n4EA0mR16FZ4H1rAyjxDCCD5QlJcU
	5V0kWKF6CXhqqSQtOf+jjlyvmFY8o/P3gCMB1RUOj+y7Kgm7LJt/moAkXZQ8WrfN
	et1AtGW/KJpH7QGFQgbT/8LDhes2cjfrBeL29XU/YUht833DcQ42w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunstffa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K3BQ3580750;
	Mon, 9 Nov 2026 03:33:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteapwp9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93X1Zl47382906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:33:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DDDE20043;
	Mon,  9 Nov 2026 03:33:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75CC720040;
	Mon,  9 Nov 2026 03:32:55 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:32:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 15/23] nvmet: add context annotation for nvmet_ns::enabled
Date: Mon,  9 Nov 2026 08:58:20 +0530
Message-ID: <20261109033102.982191-40-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX+vS7ZgEoZMlK
 84aszime3WD17FC+lAGZAsT9Ce/9C0e5JLRcrwI6uLnMZqpJ996TLWJF8M463NmTduhXIa1drCC
 kW/jKobTU7LMi9fntXYXY3c+QY/16J39POLFOjphNnSu1SFKSuKQ8WdwjSNoZZHEfwEAMQ184yL
 5oU1I7DIipBV8+qWt81Fvd/YEBJgbjFtSUYJzcBOxQ1cyYVhI2Q/6rEYCG8KCERcOh7untXG8Oc
 P01mIJszBVUH08fqu0rxPZhNU0SSnHEx7PNmyw01z3SSu99/8a96RjsFaGxwZcKXpS52C2yKkvW
 rVZNwbHt6Mi93hZdHJhC98uj+7qVoR6/LupbWIi449Sxcf7tAhLHWbcARPg01ylnTqVwruVYaXW
 rSdO6LImgjY7Qm7rtIwPgRIPAEMsyHwAc3W84LEmkXUvwWvq3pp6wsBpBjDr/45KsGoGT9v4Qsx
 CZYOlSUHOqBuv95Cezw==
X-Proofpoint-ORIG-GUID: 8phdP13jrTIJffP7FZsn1_VFWZINcGEr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX/uhM7x5E4yBx
 RlBbK/SNWKabQpu4kd1rS/y3uDr2TyUZkxmMrwdhmdPYTuwXy+/pt3eJobQ3BGb4ykgtWYn63Om
 cF3mwQjAnUcM3crM6VHE/bJbeJciPFI=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af13ef2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ytfzEcs4y3VMyTrQ1fAA:9
X-Proofpoint-GUID: n7tguUmO1p0hralLfmDxS38VN6CbQcJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193313_204565_F66F7B88 
X-CRM114-Status: GOOD (  12.69  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The nvmet_ns::enabled field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) so that the clang
context analyzer can validate accesses to this field.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/nvmet.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 572f495b06df..a6fb3aab0c5d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -171,7 +171,8 @@ struct nvmet_ns {
 
 	bool			buffered_io
 		__guarded_by(&subsys->lock);
-	bool			enabled;
+	bool			enabled
+		__guarded_by(&subsys->lock);
 #define NVMET_NS_IO_LIVE	0
 	unsigned long		flags;
 	struct nvmet_subsys	*subsys;
-- 
2.53.0


