Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA204CD98C6
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDOuf+17wYcDr5PsyvzgD2sagqVvJYl3zxrieacw8BU=; b=q5XNaRqbsaD0xZVVIDpYkPh3Xd
	1MF9gYWSa1f1p6yAo3sQdoCTuFfxN2+53Y12wwXOjYBCeEOw5gMFsyIrCPjbsyLugoKAcXzDUTqcc
	6QaTzB+J5YFJvDC4aQ0p9HP0HSecmlUPwCA6DWPiciGiPBPVddYMVSSj6BTOjkfjgaisvtBfU3MO3
	+FWwGk8Khi5QZmt8n2VvTKpO+LDk1nGQW4B9LmGGeibHFzHUI3yo1K6F973p5/JxlM2Az8zKx1Jvl
	BBhB6/HsawTfW/ghuB8azjXIbT72erU4olo0jUZKSZscNhmmr5PiI4IBS8Xcvjt8T3AaSQlp80ahk
	ayA/W8DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvS-00000007t7c-12Kf;
	Wed, 10 Jun 2026 14:29:02 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvP-00000007t4D-3egW
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:29:01 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AAEi6B3920443;
	Wed, 10 Jun 2026 14:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZDOuf+17wYcDr5Psy
	vzgD2sagqVvJYl3zxrieacw8BU=; b=UxyVULVHtZk6kPB05LU0Z/kRPZ8b3oYSh
	vNtw/C9XcfcqeRyR4Bpivqh46dDGHf89sB1Bb4hduZFximYILZoskFWARJKoAO56
	vkDoj5QariLjSPduj0a8A7Lswrc9x/zfMvjhJxbKl83uCH2GTPRjtc9ICdfK98TM
	W4pYmhQ06n/qaVjoZ7n5CeWu70cNGMLE52W/sum6jg3UA/IteGY4KN+X5oThZ5cP
	zaV7Kf0VgNVZ0xAaiNCEdiJmXkSEd/2YUjqIiXwqZTdNcwR0h9s33mzlZFCuf/BX
	pTAU5HIhF/PNmVObUbSZurwjLXu4FyzFW4eqj8nMQWF/KAwfaWKjg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6t12f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEK5o4013524;
	Wed, 10 Jun 2026 14:28:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq767p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESlwl44368208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63ED520049;
	Wed, 10 Jun 2026 14:28:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0802020040;
	Wed, 10 Jun 2026 14:28:45 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:44 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 15/15] nvme: enable Clang context analysis support for nvme host driver
Date: Wed, 10 Jun 2026 19:57:35 +0530
Message-ID: <20260610142743.115898-16-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KULi_zgF9L-_moRbXRj4gBFK2jNChcjt
X-Proofpoint-GUID: whYAyN49U-9HK-Dmm5D2i9OxCH4BZ8t6
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a2974a4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=GVzyxF2uuL8LOb_S8PgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX1ddmvCj8iCg9
 UMcKn6g1oTAINcqP9VwHz2XgmI4QLeZ4Z8S6hdzedfM1+UQ+iQgTn/Pu+Wvg5XoflYZV6boSZLe
 +UcJlicYYPqD2CLHfgh7FR5K8pSrobmdo2TwfulssRG6/nbRjB8kOpCD934AjwY5iG+j6aZhLoa
 DsdpC3DQU3YVxKgelfchDTGBDDUreawqgZ/gWP5eGJRBrhL8FXeHbTfZ+bJE1ao2/Y1ARgC+dar
 vOEYQzqgRAjvyWPL2IAA9Ud9N0UwFaNjWS0KpCqBCQIfTNJ4e7ApOn1vbO5dm76xKHHVE+02pg3
 8zjz+mWqyNTW5x5Wryb/bDhq2XTTnHKU1LKVMRL8BYbAaw+faQ4uA2Bi6EghSQBP6KdUWNPu+jb
 k3sBJge/bRKvBZ0wSHSxgQGXQARTXCN5TCpR0xN1+gO/4a+F4SO1YQArQg3+oMjgY4qwQftcrxz
 6gOH3OZlO3xlXcvu1fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072900_054479_7DA795C4 
X-CRM114-Status: GOOD (  12.07  )
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

Update nvme host driver makefile to enable support for the Clang's
context anaysis.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 6414ec968f99..67563a69f7dc 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CONTEXT_ANALYSIS			:= y
 ccflags-y				+= -I$(src)
 
 obj-$(CONFIG_NVME_CORE)			+= nvme-core.o
-- 
2.53.0


