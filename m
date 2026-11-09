Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B577606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zz5gBK5o;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=odqKNwFm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=51NKiPJdg25EzlrvR2XNMVSwDaWW7ntivC8fkAFuaGw=; b=zz5gBK5ort0n5P
	ZPJQOFFbnHg4X2hjd2ql1yTWxo46I0s5rqH3jOJnRk0QFfSpp/Xh3oNZtG2Rl4O6hNuyoyfDuD2sp
	XmKHvRoBXe6iI6GINjUXLfUoQ7lo+Dl5egj9294u2qspvZGwnYbxLE9fQP2/E2VKCzaxtYWI/IcU2
	TBnpekkn3WUccaaVtuqb3BELg3Ytde/EMz0InnU9t3+rYEyDMngs83jaccaYOhF0iqpI0Za9m8B0w
	YwEkguMUUg3OLr9FqMZny+dOM9lWWDcfXq7I5FkgjFFkJRaw5OSu1C1/aeRlyrFgU4WV9891ZU+Oe
	5AJ0ewEVdIuKHYyGuDaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG72-0000000HCWT-2kAB;
	Mon, 09 Nov 2026 03:32:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG6z-0000000HCU7-1Khn
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:32:03 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iGYB1945674;
	Mon, 9 Nov 2026 03:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=51NKiPJdg25EzlrvR
	2XNMVSwDaWW7ntivC8fkAFuaGw=; b=odqKNwFmchpD73wtd5BXUb6PK0SxzNjgN
	KMvx4o4qjt8DnnKqv8dq9uEhB9Yk4yamhb7Yh6DgCtj67bk4+MEMPKU8vsNqIcbE
	8z8GGKyqIHuAt/XfkgVHgvBaQLROU7GKCcGlbH8IPJCWfHZKIZgsHLBO/9Z1Iotk
	8uKPipjq6v1HE/xpJVWoB8DFOWefR/Dfm/9z8D4Q4d0JoWpP9Y12nqCnqbMZkXvI
	oVvR2a5xgUP/fYRZffGaUiGFvWUqHaK5fDfayL+oCeCHi2Cy2NbjP6AqySvh2UT8
	Ck3GjrF8jNfMVESqDU19b13NawclOjT2KXyfxWKnaUHK3eAkM+W2Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6jec8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93JxW03535219;
	Mon, 9 Nov 2026 03:31:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfajwfk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93Vm9e30998850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:31:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB99C20043;
	Mon,  9 Nov 2026 03:31:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B07420040;
	Mon,  9 Nov 2026 03:31:42 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:31:42 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 04/23] nvmet: add context annotation for nvmet_ns::bdev_file
Date: Mon,  9 Nov 2026 08:58:09 +0530
Message-ID: <20261109033102.982191-29-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfXy/e3g8XDoZqO
 3GSFEdUUZdnzXYKSHKb17hqXGXH3AL+5QqL4Nv+bSjMEhl7M6SbNtan4y2j4pPRTopYW8A1K2a8
 6gDiVUxSweH7jrjT6aedooUwIhyn6wg=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af13eaa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ytfzEcs4y3VMyTrQ1fAA:9
X-Proofpoint-ORIG-GUID: L-fElWYSs8f-T0OMoc4E9DU9pUlGXt-r
X-Proofpoint-GUID: a4Z1HwSXm7JDZAgl_zkAEs96P4O41zZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX+QhdIOE566Cu
 uIoEJztMwmNR/NZWqybsUl2YeYRpi5OdaMCqAao3GhhNVuouCGH+XBE75xWTCZxgHool/a2TOB7
 2vGE3lZB9DByhD4F4bBotOppqifoSsvVJtnbEl6h4zAQ+cHMTgV5kyBKYZiLyEL945q6L5e2pW2
 UGIu3Sil+9SSfNr094X3npnObNw1e5hjlks/0GU2ti4ntgwRixq2XxrZzql1xhGD0kL8I+V1nT2
 NZeh23I0ECHevsITgGvAe7lKh0haSfmtYzBlUOY4fSMpC/nOkrQ6U/7StLXXYtiROVT2VNRRm0i
 f3rmEkYqxzvhrIVXLm6yHTroHad7qyPVms9xv6XfAllA8XXd/i/YeOFhznVTmEU+TnHpOG6Hw+i
 5GC/q5hqQWiCfUt9RZoaBWeHPhyU0y+GCKbNaXiwphif8vbdUhv1JFfN/7vPnjYmPakCybFR9Ro
 V9+34f5l+1iWiPojI1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193201_369537_850FF885 
X-CRM114-Status: GOOD (  13.29  )
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

The nvmet_ns::bdev_file field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) so that the clang
context analyzer can validate accesses to this field.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/nvmet.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 74b066ce9ab0..b63664250ef4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -149,7 +149,8 @@ struct nvmet_subsys {
 
 struct nvmet_ns {
 	struct percpu_ref	ref;
-	struct file		*bdev_file;
+	struct file		*bdev_file
+		__guarded_by(&subsys->lock);
 	struct block_device	*bdev
 		__guarded_by(&subsys->lock);
 	struct file		*file
-- 
2.53.0


