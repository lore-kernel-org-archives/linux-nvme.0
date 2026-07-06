Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A07C44500
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlZg2WL9PhzUTcVOCL9j+gYbUADaKzo/Ork3fhiGgTo=; b=aPj9ASEuuHgFNnieuV1eG1ewwr
	waAF5PL5ZkM9GlGvPwwkS4pNb9ANQWydAY/KEe7v2WuoI4Gnz8JYJCnLkO6gkCRdDjEdFTDoWtrVz
	nfOfhn5ovIzwkjk+E05fcW4OamSdOBhpd0KAy+SKK/SZNyw9mBFvqjeGgzSe16teIdZNd6xigexCT
	a77LZTQ07TydNsFqymypXaeU0FaTdIgcldjSDArFrPo0iXARnB5CmpdHMB7f4IYtEM+NTTDlONkgt
	IpStlTP4Srav/yX4ZNZUn2QmudXJizHtj+ISyOjjA1uIGhR34p5BzMdMmZgpmdEPm1PkCr+eChrhI
	N64+J2WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7d-0000000CiUL-1jfO;
	Mon, 06 Jul 2026 14:16:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7b-0000000CiRq-2bXs
	for linux-nvme@bombadil.infradead.org;
	Mon, 06 Jul 2026 14:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=SlZg2WL9PhzUTcVOCL9j+gYbUADaKzo/Ork3fhiGgTo=; b=eFVoxJD5dgLJCoqobgmQGYwftQ
	N3ailFFdEmh7y5kXl4lVglyDfy5hoqE6bgY7zwnL6m/UPP4xPV+cINDI2kXjQhr/wY6VnIhpXbdoO
	lsG2h2zLBFUwgRYph1JMypSl+2pgpc+pmxD1Y+/R/WSuqokPiQSkbR8MMqsbp4kLRxc2aXHjl9Qvo
	yarLKpiaDjAg3ZY0WMan3KW6P4BpiQSyTXhOUDyV67YQSqGP1G9nZE7c7n32TbdTG4+56D5lcpSmc
	8kApn/IrDXGw1CuL07moXnm7lUIxh8fZV98l0BoEXlu2MuJcBErkJFx7EXOHTV2XCDYrtRcNE+e9F
	I9N6WUUw==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wgk7X-00000006doD-3RM0
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:30 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIMvO041181;
	Mon, 6 Jul 2026 14:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SlZg2WL9PhzUTcVOC
	L9j+gYbUADaKzo/Ork3fhiGgTo=; b=NI/1Nf/FOhtsnglBF1G89SDuIkaiq/wxo
	k8ubfvVMX6EGZ5wGud78oAkyS6bkz8dvqDjsGUZ3AvKLfRuhyoTVLsoDi5x4rRkW
	4iGg8bcgUIuywoL1e9LPcgK+RktvREErr+GaLjwoqSo62u7rr8AQJueeKlTqiD9Y
	3kpPxo2XC1gb7RnKvljLxITZy0lM8plXUzb5vpQrkf7MKtY4fL7n1KViAghdtpBy
	7GO2BXxk36vYGDFV7pSHNRCwDE9ekJk0xp6PBJTfk09HIxule5dJ83/UtaXg1OlA
	RVy2+uEhO+6jUH8NoQBIWtwKb3PH16kB6MzzQrNAzVOHkpqvigXJg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn9x3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4jCY019274;
	Mon, 6 Jul 2026 14:16:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpx44w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EGDMl30998886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:16:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A90E20043;
	Mon,  6 Jul 2026 14:16:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74CCF20040;
	Mon,  6 Jul 2026 14:16:11 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:16:11 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 15/18] nvme: fix context analysis warning in rdma.c
Date: Mon,  6 Jul 2026 19:44:17 +0530
Message-ID: <20260706141452.3008233-16-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4bb8b2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=L-zbExpT5qCHzqbmkREA:9
X-Proofpoint-GUID: vpBfwbYDqkP9O-97Gy9PY1q13vMLmYdd
X-Proofpoint-ORIG-GUID: RhMeqG8a0iw9YHvXyuwGa14W-pP96EBt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX3gUbYRBoG4QS
 OnKoL+uSYKjaMwjvflcNv2yboJIiDn8D0DALmIpYhaB9tK7olp5EAuDLV8ZfK2TmhbAhBQaqweZ
 5MqoBrqho3KjJUX3ZoWsjyMPB5PHCYo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX89eLb8WQ+MzW
 KNjBVXQd8P6Iz+PyaasKf3dhqXdwU8bDyv6ewRZraUqQSvOMWb95q0fP40RsAam6fVLWLDekds1
 rcWjN2NAmt0Pal+UgyfaBfsM5CsQeT9F/rmLA5XiM/eLtlRk8guP8JMyIaDYsQPT1P5DhugkQEG
 pz43I5s9gqADeWcNl+6d2OCud316gW2yoVnzPrS3BU/6Gqy3YLlAtfpjj9iPCOdPcJtEB9lwHw6
 qgI6AbGQdNDRa9d1pGx+c2KAdnSVfHcoHeeuYUQISVK5n+UXS0AkVkBCbhY0ZWNL7BNfYyNDF8A
 CAZypkb9CDX7yO+1k/aMIafSl2FqtSqh87Czi/WMD6EWl+zOtrLi1O3n5Tou7MsPF6t6DUlqhM2
 jw1kflW0Luso/yMpU9cmvTveFLqPbxetEg2gzbvNprby5q7twDb9nutZ/Q1kE4c6CiCz8b60aqc
 15ji+6hg1cD4VzAGYyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_151628_263356_34B36ECE 
X-CRM114-Status: GOOD (  16.23  )
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

After adding Clang lock context annotations in rdma.c, Clang reports
the following warning when context analysis is enabled:

drivers/nvme/host/rdma.c:972:24: warning: passing pointer to variable 'list' requires holding mutex 'nvme_rdma_ctrl_mutex'
	  [-Wthread-safety-pointer]
  972 |         if (list_empty(&ctrl->list))
	  |                               ^

The warning is triggered because ctrl->list is annotated as being
protected by nvme_rdma_ctrl_mutex, but list_empty(&ctrl->list) is
invoked without holding that mutex.

Replace list_empty() with list_empty_careful(), which is intended
for lockless inspection of list heads during teardown when no concurrent
list modifications are expected. This suppresses the corresponding
context analysis warning while preserving the existing behavior.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bf392035037a..cdd8837da03a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -971,7 +971,7 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
+	if (list_empty_careful(&ctrl->list))
 		goto free_ctrl;
 
 	mutex_lock(&nvme_rdma_ctrl_mutex);
-- 
2.53.0


