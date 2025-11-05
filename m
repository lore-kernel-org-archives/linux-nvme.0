Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585C9CCFA13
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 10:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v7GjF+32MO+wYY0etIqjP5parL6SsITNg3ltflKlDIY=; b=wiueaQnJ+/ZIyot7dTGorbJDUA
	UOnQoQ/i/7cQPPHCHJ7xVkiUnbpvOf6ZK+w43UIGDnA/7Frs4OqK+AaovekaIwSWgx5vgXrMeZtUF
	00Scn0kcpAE/exgf3gOKsbKAu7U19pEwAw1vKDeKvu0S/OD6mkVoHhO2KB/qN5dpPTFN90cPPx/q3
	HoLxf8BQONvriQJtIT8CusShGtfGRLDU5B+XYw4dx+J9znfMM+Dcwqln0lLgLr0vxQ1VLZukuZ48s
	nvlIq9VJZM6Toft9NDT0CBpcqp6kcmJsQuQkASz/k3lF1BCgpjBiWBskYDYFbNZdXwkihz74yXx6r
	V9LAahug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaqN-0000000DToA-2GhQ;
	Wed, 05 Nov 2025 10:34:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaqL-0000000DTm0-2Y3H
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Nov 2025 10:34:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=v7GjF+32MO+wYY0etIqjP5parL6SsITNg3ltflKlDIY=; b=iPdhIvQFRb6ytSRZcGmj+W0bBy
	hneO07KZZX9P1EyMlqdUa0Hpj2Aw/1BJoC/rFPb90jUoQwuRlI+URJ1ra895DYksKSRruM8gYQZXp
	QHztqfbzocKhheqo9npiGmMm1IvxicTu8pToTLsm6e5NpiL1DdpxFSGqCdqC+AGiANtLg9lhNuUbS
	VO2q25TOWRsaGzPsNZh/mFybk+3dHlSpyhZ33SUrhl+PcaUbWoqABXk1C5mObj5OyeS/hLn6/FbQD
	BX8zgIxkstJ5vu92tqqaPPqsK5Bt28JYTLkOpyOUvJrwuQrhrAJSOeIjz13ZRhGfbP1QjPoYzK57x
	KS7iTfhQ==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGZyb-00000001rXk-1fXX
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 09:38:51 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A54lWTE011115;
	Wed, 5 Nov 2025 10:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v7GjF+32MO+wYY0et
	IqjP5parL6SsITNg3ltflKlDIY=; b=szeK1LgayyDxjUQmXp2BB7vuByG/rq1uf
	ZOPFmPI979OB+qqPQyTM+2g1ZCrK9eQNf6VQyYqqMlXfSMqeCayOAub1AOyFwp5I
	aP5cAue53ezb7AVvtYyWJ4OqX9CQtH51+Iq97FNl+H5pzD/i4tZUDoDLGMdPZErJ
	KLYD+y32oiyk0Dzq67NQWfNcWWvt7YELFzzHuBd4OynwVMYWrLyN527R/+BhN4z6
	grfQP2K0cDSFy08Mr9AM+ZGpYT53e8dSpPRz+Eiqw973pS1nkRkr3lXsphZmYBTh
	qP/YEQswQKWYq84DXnxHrfFYtwp0bWVaECJZfT8SIq7gKwwYZ4uVg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc0nsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5AYB9V006223;
	Wed, 5 Nov 2025 10:34:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc0nse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A58T8h0021467;
	Wed, 5 Nov 2025 10:34:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrjqbfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5AY8hn22610642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 10:34:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D944C2004D;
	Wed,  5 Nov 2025 10:34:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC23320043;
	Wed,  5 Nov 2025 10:34:06 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 10:34:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, kanie@linux.alibaba.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv5 7/7] nvme-multipath: add documentation for adaptive I/O policy
Date: Wed,  5 Nov 2025 16:03:26 +0530
Message-ID: <20251105103347.86059-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105103347.86059-1-nilay@linux.ibm.com>
References: <20251105103347.86059-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX8pZh4RXrvleM
 3LfwKAmaLYqGoWuVBkblgZelfj1xWBJ8jWRySU313DVlQkpMD0dPS4EoQmyAWGNXhRHHi827Ftj
 4RvZGrFkUVgrfGE+c0BwLbhY7K13DHNmkLRFYDgkvljyCpq5RLI0vWU4RZ9NLYz68urA5GhLVAA
 iG3r7qRUihpTJhn/JjmpQL/9WQMh6JmQ6HJ49Kwvxqp/WdgubCBOWSTGLJ2Iw9mJM1shywv57yt
 jneSVAnCfCbVWTEuWXVDRj/a1WdZ2ukiFFt3erZVOD1nLeDQB0mMO/+lzqH77mdvzMZ6V8VAZsM
 +Onb8ZS13el3FXLFurMNHLClB5VkrtnncFb4WwfafFVO7n+w2QWBLVX2dNAYFEYDC5QQTrmpUWM
 lFsfFrVYaetjvD5rpKim82AMxuk4FQ==
X-Proofpoint-GUID: AtbkHQH5XrgjejIvz5hu3L1cZQ-l6tQn
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690b2824 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=NLV-vCcRgePVHmOrxzYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: F1Leao-xclmQhwedqVAGAYk4ELYjP5pV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_093849_815123_07E10334 
X-CRM114-Status: GOOD (  12.58  )
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

Update the nvme-multipath documentation to describe the adaptive I/O
policy, its behavior, and when it is suitable for use.

Suggested-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 Documentation/admin-guide/nvme-multipath.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
index 97ca1ccef459..7befaab01cf5 100644
--- a/Documentation/admin-guide/nvme-multipath.rst
+++ b/Documentation/admin-guide/nvme-multipath.rst
@@ -70,3 +70,22 @@ When to use the queue-depth policy:
   1. High load with small I/Os: Effectively balances load across paths when
      the load is high, and I/O operations consist of small, relatively
      fixed-sized requests.
+
+Adaptive
+--------
+
+The adaptive policy manages I/O requests based on path latency. It periodically
+calculates a weight for each path and distributes I/O accordingly. Paths with
+higher latency receive lower weights, resulting in fewer I/O requests being sent
+to them, while paths with lower latency handle a proportionally larger share of
+the I/O load.
+
+When to use the adaptive policy
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. Homogeneous Path Performance: Utilizes all available paths efficiently when
+   their performance characteristics (e.g., latency, bandwidth) are similar.
+
+2. Heterogeneous Path Performance: Dynamically distributes I/O based on per-path
+   performance characteristics. Paths with lower latency receive a higher share
+   of I/O compared to those with higher latency.
-- 
2.51.0


