Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5E7CD98C5
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4oV0YATnMk8wx4/zuEPoGA2HSbUDyKzWn69tU1MuZM4=; b=SBcIC+YZcpXzvKJ6RTTYsPcsKq
	OfYjc0A1QuP+ducV2ovcuRJbCx78LAr5ch65cwVC2Lpj7ta/lLVO4ed9aTgP1IUpeJs+/AQwMlK8g
	PYF5t1BvSX+ANdDn8QxURF+s8CGPqOYY9ec5Mx/OPE8JGBd/4+EE41FXwoYmPCvQ/IzLyRHn4J8dc
	hqFuwarV8h8cSQ+JOsgIidhxt9Es7WduMfzNaEGlMD5PbgOAkIc9RohI1R7ndZFJMitBa18j9tjpJ
	jBQXedUc9GhPtlK9Ojbk5bZttPGTLdoKR/F73ML/GESHXttG+ZEiOriedK0l+T1oY3gZbiYs4uS42
	xbXh32Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhN-0000000D0n5-0jzb;
	Sun, 14 Jun 2026 13:16:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhL-0000000D0mM-1d9R
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:24 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmgA93541600;
	Sun, 14 Jun 2026 13:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4oV0YATnMk8wx4/zu
	EPoGA2HSbUDyKzWn69tU1MuZM4=; b=dWfXpYXCmTRt6NiSQsnNGlzJSM2qXTXL1
	+heq2XLW0SNlkJz7cRyXc92CDfyT47Bom1K66byPF/UlV4N2n1bKnKYGG8+RdPm/
	W41WHSCiPSaj1+XW/rLdmmu++6KgOzgQSxmyzuDC6/dNrT3Vw9CU7KujwElCidTi
	xo97ggSEF6IfgJV8hmpNSSilMe5KvLclGDS8cjveQ01qvKWGgsgqi3OcDkmR+kBI
	1jdfqaYSyyltjP2mdBgcrov2GRwiPjN7QhpKmV2k+04CCD1znUqLoPRzYpLvGVJj
	JEu4tO/qqjQia69WxdcB08dZS2z1ZRCqOfFsIiGCoPVYhK5os57kA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1efubyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED50RY031726;
	Sun, 14 Jun 2026 13:16:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg1fw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDG93g48169308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27B2E20043;
	Sun, 14 Jun 2026 13:16:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89F3020040;
	Sun, 14 Jun 2026 13:16:06 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 06/17] nvme: add Clang context annotations for nvme_dev::shutdown_lock
Date: Sun, 14 Jun 2026 18:45:21 +0530
Message-ID: <20260614131541.2017845-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX+tzvligkxQsd
 QFeW+IaISvxEwOa3lUSHY44qwmcgovo2A9RNo7Wub4DeoGNgwhgX6twT6xhwjap2R8kmiieGALl
 R+vR3yv3jTqeMPexypRd6PFY0gqudkI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX+pRybAITNUsF
 puvX3iwqKyD1O1qUYjaNHBLvndLJW0dg8aFqYXckVRBogZf13CbliFe/7puNAHjpD7lqWhd6Xco
 Bs+Oq6zoxEvLZ1APqqArC6Mvn/0v693vOhPLLnTEP5X1Arnfb/qJVHUCjorZ3zdcJEs0sQZhNuS
 7oxCWJdwmcIbPfUb1CfQ/J/Ngr4i3RqYPPxFFMzGXOx2DH4ELjb5D/UtIoo/aSXogQvBPvjYryN
 tKW8P7UaFDY2Qu2YLq9SBmbs1l4s2v6Cc7Cc9mnvd6zDtsQQ6H43bHvAyfyd3CPee95uR9ZMSMN
 kPHj06oyRVxydG14sCu3WEtD9ebedR7kvjTamhqehXUbZXFlNpXehB8yhdp/TYaSlqHBOO+5dKu
 3z6oUgaSCi40hURQy8f6+bYOQ0gooL9NqwFtjTIkbtV9HNb88ZV7kWwMhE4AlUE86OhER/oA99K
 /ZZoPt5C3Lz0jKL2W6A==
X-Proofpoint-GUID: iLvtoU0nNe8BtvPxUwZoYSxHjSeueJYn
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2ea99d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=lhRNW2dt6MhivXYX8oYA:9
X-Proofpoint-ORIG-GUID: HH8UJUBIYx06vzqNxMpJfRnzHkvyXSw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061623_561458_75DB1DEE 
X-CRM114-Status: GOOD (  13.61  )
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

nvme_setup_io_queues_trylock() conditionally acquires dev->shutdown_lock
using mutex_trylock(). The function returns 0 when the lock is
successfully acquired and a negative error code otherwise.

Annotate the function with __cond_acquires(0, &dev->shutdown_lock) so
that Clang's lock context analysis can track the lock state based on
the return value and verify correct lock usage at call sites.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b5f846200678..894da63127a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2194,6 +2194,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
  * Try getting shutdown_lock while setting up IO queues.
  */
 static int nvme_setup_io_queues_trylock(struct nvme_dev *dev)
+	__cond_acquires(0, &dev->shutdown_lock)
 {
 	/*
 	 * Give up if the lock is being held by nvme_dev_disable.
-- 
2.53.0


