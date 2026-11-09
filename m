Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182F606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cn8bz03M;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SoXG6tfQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LJU9B7q4iW75svY48oVpJc+3/fnHkYTztmtHkRrYVD0=; b=cn8bz03MvycGse
	qnTh4VP+vyGaoPfBjJUovBEZlxT2d0JUdVul+aaIr7VsPsfcrZNxj15sQbHskabcJf2xtHI1mNrs6
	FW1/3qhGIKCAJzZUKHVhmqI9hd4ciFD6zfC2G2tU4gssrZ9Crleo/naDN1++Ixy+ReAZJjz3q5Eu8
	1ix8OQMLAi7FlRn77o3hHH2DXYOvoLcz+960wmZg2UwQ+3rrtf0XTBsOMC9X056aLt7f3edaCoDKW
	qW0O8R8C72ZYSVBfGL1mm8QPX7WanmfRqugqNmIOXN+UfXgvoFPuRtSN/g4H+nQ07oOERRX66EvZa
	XXHbp01IsUCxVNNuqrsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8d-0000000HE75-0Rcg;
	Mon, 09 Nov 2026 03:33:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8a-0000000HE48-1YAm
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:33:41 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90ilNG312376;
	Mon, 9 Nov 2026 03:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LJU9B7q4iW75svY48
	oVpJc+3/fnHkYTztmtHkRrYVD0=; b=SoXG6tfQ9TSy1sgRHMAIPVXPn3fgS4LzD
	4OkHe3DlPgrFyM2gy8Avx+2gbB7Ni78+0oDI/UEN6yD18wggno0iwA1HzdF8upvn
	o51akC/WfpUCsAbRcswRDQSylN4xwujZ656cj+b+lykbIbX0r3h+Es8/911Vda5+
	MxQvnmgeAyvs/XBedyrUJk8iQ/MO+IGieVCgHf6Q0Nz5i3e9AKQzKKLpOjfZ/QFd
	JybEYLoWoU3Dqga8tCIjy+912jla0zDCWpP/QmdS1yFnzXV/0lTUZSY2APybmnmI
	uqvJzbE+9h4OoRLBLEzs3yv+hQIwimAKGGaPEhgYCz2FYk4RrzyTw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunstfgg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K1HO3675040;
	Mon, 9 Nov 2026 03:33:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthdbn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93XRV550659584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:33:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A387A2005A;
	Mon,  9 Nov 2026 03:33:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 053D120043;
	Mon,  9 Nov 2026 03:33:23 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:33:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 19/23] nvmet: add context annotation for PCI P2P parameters in struct nvmet_ns
Date: Mon,  9 Nov 2026 08:58:24 +0530
Message-ID: <20261109033102.982191-44-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX77B0jn/t/y7E
 z0I7DDbvVR+nNAwaa6yEh+mEBqftwzcCQaivZNOiK2oReMAKiJCsLZYymMlIqeH08L/18uQK3XI
 rmjw9M/+glrkviLyafy5By1JGKdlCAnWB2BrVFz0NuKtiJWDmWotNGindEZyfq3PoS/OXXS3oFx
 InNet3ZoekY+3zl65eAjdnTI7xY2mYHG1cepbxIaHdOANcAXyRkeuL3xHBNJw1b6xN6qnntihyj
 g5XA+KdNBwQDlaSL04myyQd0N2baoKB78H2T77H6tsuGzVuTfWp70c+zitGp5tPFrS6WgHJhmBn
 kljyu+V/pIn/Q6DFMMkDgsEtQ7KDRUdhrq8MJOx1g4OwDJL8b30LOfMwzXNNfg6sovOKXQiX3wb
 e+gpEOp5e1OjaKoXBxLwqpRcs7dmb3FpKJSgUEjAzhSM5SmCz9mYGs9mQp0kf4JSDID5PRlicwQ
 Euwr/e4qm4TFJOLGxHw==
X-Proofpoint-ORIG-GUID: TP_lITZ4lHuEr1uDz105QL3Ri700edHT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfXzfr6IMo9Vve+
 F87xy+WNlkXdsDw029Z4W+f2g7iur41Gky7k8YALFqL9qmB6/msBk2rvMk2a9b9Om7ZEXcqTyqi
 D7rb9lmaM2JL8sfLLh26o61PDcvSOuc=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af13f0d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=YeBxuRm8RaLLF98ZCrQA:9
X-Proofpoint-GUID: hGD5ZKiSL6tRuTb6pb8UWQy6Ur7KyW2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193340_433695_205B9D6E 
X-CRM114-Status: GOOD (  13.55  )
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

nvmet_ns::p2p_dev and nvmet_ns::use_p2pmem are protected by
nvmet_subsys::lock. Annotate it with __guarded_by(&subsys->lock) so
that the clang context analyzer can validate accesses to this field.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/nvmet.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fa932c1fbf29..9e7a3992bb76 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -185,8 +185,10 @@ struct nvmet_ns {
 	struct completion	disable_done;
 	mempool_t		*bvec_pool;
 
-	struct pci_dev		*p2p_dev;
-	int			use_p2pmem;
+	struct pci_dev		*p2p_dev
+		__guarded_by(&subsys->lock);
+	int			use_p2pmem
+		__guarded_by(&subsys->lock);
 	int			pi_type;
 	int			metadata_size;
 	u8			csi;
-- 
2.53.0


