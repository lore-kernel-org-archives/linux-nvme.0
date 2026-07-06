Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53DDC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDOuf+17wYcDr5PsyvzgD2sagqVvJYl3zxrieacw8BU=; b=CY7gsSdcut7iME3P11p3zquHIe
	SNpV8MeRS5iVQHVPUDj1edVu/v0AasX06rxQu0uD6ELCk0kfXnMOnOz8kqbPoA0OWIwvEVdRd7WOn
	wNgrNwd4NZaCghP+RjihRoacF96jDfpeF9qb8flMZ8eBmR7j+zQ9ADTW/1bnF9SsbXTuF6CHvh5xu
	OvdOzSqoc8U2uC5FmyWwpoUSSt9IXd8jGx5RjviRnTMfXM/BLInxk2Uo8Y2H050DxFQyD88hy57No
	rWsdg35bv1ywZ42IchZsMQpa5SeJQ4y/5dR4GcZLz0MBLJRHGkQ/Bm2FTo5OcDiMHhNKUHYfPgMf8
	nS1XAMTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7k-0000000Cieq-1r47;
	Mon, 06 Jul 2026 14:16:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7j-0000000Cicd-231B
	for linux-nvme@bombadil.infradead.org;
	Mon, 06 Jul 2026 14:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZDOuf+17wYcDr5PsyvzgD2sagqVvJYl3zxrieacw8BU=; b=G7bo1SImUee8hyjtpxGQkdZNSZ
	4ZQJBTuL77mrqdeurSfOcxnrfcMZ0AqWv7gkXfx6sXxu7WhTX2EaQKDfJeZxiTS1FNQz41W2brBxe
	ihz80mifSGpN+9ap5IrZ3nYjRQ0THZ5veI8xZfR8cxxgXiEs7Jj4UPS8+Tem0xEp3Xdz5E3yH5tK8
	8K3q+Cpse9EebL4Z+nAeBu5W1m4EFSnE6jR0mXZCMs4out/KkRp5C2so+1h0Xn26LLNgFXPKJPE25
	VaFBLRxqezBvIn0GAJwgBwN52az9eOpSRa9QZJvjUPNgzTK55TFegYX3Ceb1LRpKQPGh+y7GAtULn
	rXACqt/g==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wgk7g-00000006dqy-2RCW
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:38 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIQJE4094223;
	Mon, 6 Jul 2026 14:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZDOuf+17wYcDr5Psy
	vzgD2sagqVvJYl3zxrieacw8BU=; b=Cyx4J1XC8pENwWdiY7+dWSQpFKsz4OYVt
	g66uB4AMORVIAyeKZznHm+B52LNyzu3L27ds+LqGzYnS6kh69/tr2dV4Qy5m0Abd
	OTGdVrfFXOoRa3nPi/ECQI+YBXgtfC9rxM2DDTpKZvDyKGEHWja/1lF/cfKdK6r8
	mUhhzHtf1vhFmrLy3SVqWkSbFz3mLXFf688HEYjczkUBCY046scOoXV9WHfBMyHk
	0b90p+eBs2/TdpVEXkN8FYbQofxKxDgKdc0Sx/NWCikQodq7Cc+zxfRJzjmHp/Io
	QhcgPuqquBJnQFM2V2TwDTDZKnVnlQlg9IZOesEQBjpHPdVV9ctUQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4hsuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4cYK015292;
	Mon, 6 Jul 2026 14:16:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfwpaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EGKmT24576454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:16:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A641320043;
	Mon,  6 Jul 2026 14:16:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 950A720040;
	Mon,  6 Jul 2026 14:16:18 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:16:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 18/18] nvme: enable context analysis support for nvme host driver
Date: Mon,  6 Jul 2026 19:44:20 +0530
Message-ID: <20260706141452.3008233-19-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tL-QW59aHwePUHdog1QxfO_PWTsKZTQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXyVUSm8IsoKXQ
 ETgediMTi49l2aZARwY79g4iYb7W21sxzNa5TS+Li6/Nf7Egw9voNM6GDiIeLsHNbrJ8yJkqOUU
 A6EM0h9GIz9MwG3/YKRLR/mVqtBdmHA6o2WK53PLBz55l/AQft31UcoeB0OU3Z2afz/gpubULNc
 l2zbaHF3qY46EY66uImKmsMHYFg6ki4Ru+nqHLWUiF5kddPewwE5UnM1BxvEEFLXSLoTDSRszhd
 lsnFPcEB1uWmhbuhn1Q1o6iWnJz3Zoar+eGzgHodGAaNkw50MC2BxA/W9LL0KCsSUnNrIrzB9QC
 v6Y2YK5OJ/S3wpILoGqssDtmBCc5pCaH9DGz+6eHTaya4oT89fhRe76ZyOv0m0DyRbvFBJXd9tl
 QfCZSiI66/n6wyBt4gnsxOQ2eeFAFxzmYBtCPo4wCXWsda1VujeJ2wtS7iTcqQObmUzyU+HtjJ9
 K71IG2Gn7mDIM4j0rHg==
X-Proofpoint-ORIG-GUID: kr1dgVEQrosvEYZyV1IZYZyCUuI6495k
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bb8b9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=GVzyxF2uuL8LOb_S8PgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXwtc2ITXx5LmJ
 uBRd9+wma6WdU1pGA8wreVzO6RrMAJbK2XkA4ZcAwNdYc8phhsKdluKLaQEUJ0CO7wRuoy9SfEf
 DF/6XHnDoAZXIpaN71Yu1M+lJTFLTFo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_151637_061249_71A48A1A 
X-CRM114-Status: GOOD (  12.44  )
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


