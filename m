Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26D606A32D
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c1e/Di/W;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P4Rq0Zzz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YZylHTDgVXQibYTPd3sf3O0FU3hKf08d5znGmrFGm4k=; b=c1e/Di/WdE0DPO
	j4i+15oK1/DKwnMCrnO9DE/WI69/kuGcl6wYr3alVmK1vtmpU3TNI6lDkkyrhk93rIfjGdfoibr6C
	Hp2cEMv/6WBUCc1y3ie1RyfAA59XKGRYCGWOF5Pp8oOC0DeBX/UyKGXOLxCKZFXPPhxrqVFYI6Md7
	nMaaLHJKWnvGuOq2O3pLqP5x9NR3DXvYpWUbtoYXAyf/AhLfrDJSBKxdZucGZ+04uoTDmETKyRdaR
	3fXkMW9AkbSh9oHd+8M40mBUrfmbeHz6IQ0rS9AvmF1WrIHA3Xnubvj7z2vmPf5pUM+ANOT6Rn7Qv
	55KaKrNiD4jT+bLnTRpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXzb-00000004OHI-3LwH;
	Mon, 23 Nov 2026 17:38:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXzY-00000004OFg-2NBG
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:38:13 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGYvRe063604;
	Mon, 23 Nov 2026 17:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YZylHTDgVXQibYTPd
	3sf3O0FU3hKf08d5znGmrFGm4k=; b=P4Rq0Zzz0gYjHxbMUXdb1o+xA4ak8LYPs
	IWp2dITfW1fGgvX/OHnHYUvpmZqPVWzxT367qX2pqkL99GAO6JJUypVsDkd0yjZd
	FwZIEr1LMhKlU3degOBQd+UPObwcZOn2dy/npxBgJ5XSxMNboFlXQm0xK+7OoL7k
	5ZDELAaoye51MEymGstvhEDxsA/3rQcPbFtAukslRe3fwEkqA3ECD8rvSgoPRQsb
	BcCZsN1CmDtiU8Ge7N1a92JGg2rYfnUySAchx+jPDHE1gK3CJ/JUBxhfl1SnwXU5
	DE5LxrTnSaJHfIpqZTgsyvAJnCxSZCGq8+QF9+pbNvEogMuC4NcTA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa4ckj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 17:37:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGJj6m1418131;
	Mon, 23 Nov 2026 17:37:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vftjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 17:37:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANHbrLx36307292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 17:37:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DA452004B;
	Mon, 23 Nov 2026 17:37:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15D0B20043;
	Mon, 23 Nov 2026 17:37:49 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.173.125])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 17:37:48 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, dwagner@suse.de, hch@lst.de, hare@suse.de,
        sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 2/2] nvme: document NVMe/TCP per-queue address sysfs attribute
Date: Mon, 23 Nov 2026 23:07:24 +0530
Message-ID: <20261123173727.2022020-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173727.2022020-1-nilay@linux.ibm.com>
References: <20261123173727.2022020-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX77srAjOj6mMv
 1AJxK5vcs5rEV08M2fOTgU5yn/9mRTUuJiE9sOPR8DVMIBVNtif7g8/oklVw8jnwjcFT/zQN4sn
 IuwPFCryoZvuZy37CnOQyrKVrB0G4U+bdM3pw6IzAhtdtoHbwpI854zkSzV9YEWN6Jf7rSli5cr
 XqKWpEGgLhBxmVeU7nkVDrT0FpU8vUi/tMxkpOmkAwqkJrTQttp/En8XJUoJwhjDDr78n4rctXv
 Kg2cZBifpeVWruFDT4OyBFDXikdLXEOUCjrHP8+OOmMWUuSv2aCAFXYm2VG1Pt3V/n/LYBplBeF
 xndKjy97ESNt7x/lovowpwWvg3ucmR04YzByiTefaffEBGAHzfd5b+wz6/jYDSPflAxt5VMRz8+
 UxpI03SG702AIt5h9E9irxPPuRk8XXYb8NoaBmrf/AbrPMzoIxh6WXzFKcypfQM9UIFdrBLf5Io
 0wAtpd/Zn50ziQUop7Q==
X-Proofpoint-ORIG-GUID: SNd8q7U-VF3gRb_bd0F2mH7OSB450L7K
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b0479f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=kkgC75qXn2rPK17aiC4A:9
X-Proofpoint-GUID: SNd8q7U-VF3gRb_bd0F2mH7OSB450L7K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX/BXetlyemqF3
 GPEo4kHmvlJL9G4puoX2AsbaCIToUcjjYvmykg8BrRAg5/OSAUZN0r+b1joQYSCHc1aesK/k+uS
 cLCo3EGygcvqwVSSCOfPXvBqEsHW1pc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_093812_645858_7C1C5E93 
X-CRM114-Status: GOOD (  13.15  )
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

Document the per-I/O-queue "address" sysfs attribute introduced
for NVMe/TCP. The attribute is available at:

    /sys/class/nvme/nvmeX/queues/<qid>/address

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 Documentation/ABI/stable/sysfs-nvme | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index fcfd0426866c..953ecee81c43 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -534,3 +534,21 @@ Description:
 		managed: (RO) Shows who owns the CPU placement. 1 while
 		io_cpu is driver managed, 0 once the user assigned it,
 		for the life of the controller.
+
+What:		/sys/class/nvme/nvmeX/queues/<qid>/address
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	Nilay Shroff <nilay@linux.ibm.com>
+Description:
+		(RO) Shows the socket endpoint addresses associated with
+		an NVMe/TCP I/O queue. The output contains the following
+		comma-separated fields:
+
+		traddr: Peer transport address (IPv4/IPv6).
+		trsvcid: Peer transport service identifier (TCP port).
+		host_traddr: Local transport address (IPv4/IPv6).
+		host_trsvcid: Local transport service identifier (TCP port).
+
+		Returns an empty result if the I/O queue is not live.
+		Returns error if host or peer transport address can't be
+		determined or transport address family is unsupported.
-- 
2.53.0


