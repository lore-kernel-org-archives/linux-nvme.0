Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB1606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t/8gm8mH;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JoxawyO8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZNvmg38jlp3K86l83CYqPz1IB+SjBuASS8eg5hLbYCo=; b=t/8gm8mHaZVXcv
	TOc++oVZWwAEPl21ZsUAFSqLOnNRYEdhl9xgMIo9Y2yCy5szq/Ssv9EKXnsAqiQmvo20PfgqaHW+T
	w+5RhstZv73m19p+ibw3nuVBpOYLyZcMeSJnjixF1xbQsnI9u/Vgid1+o/PujK20Bhh0ekfsOUPob
	jF4bBENfa7uJqIdCFAfrhHIfhoQr7jnwaQpNfRwAXZnjzhDmRCmtZAGDvxxktzuMJjQNnloLtrBjW
	9pssHdRWspd550tD60ZjiHGHTHKYCZEzXpcl3LOhW2Kd/GxDJ3r22BgU07YvKt808iiv6+EI2HaEw
	g2O6RQ1UB4wqbb4gUqEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEH-000000081Xn-2XAS;
	Wed, 18 Nov 2026 07:37:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEF-000000081Uc-12SE
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:37:16 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2T92P2864771;
	Wed, 18 Nov 2026 07:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZNvmg38jlp3K86l83
	CYqPz1IB+SjBuASS8eg5hLbYCo=; b=JoxawyO8ME35y5LJfQqoEyzff13mLVZof
	E6FbyX+qj55W0OQKdpA4yRSdW5K+ivSC/AIzoYIZUhofc+pI4JJPiw3nM90P6wez
	TTmKxBX8t8lavL8WVvOjHcKPLC/MCRPRWnyBB/mKEIytzQS1mUX/0Cec3ykUDMU0
	IT7X9TIKV1anKeQPPDokebYgZmUa5fyE9z9k1k/IkZba4+4lpqy8bdZjeF7ki8P5
	hvbrgQXx437XiFLRI7CAtMW+cIntW/4Lpxz4V4bt6eBQL8l35ciAp9jxLaANBlxN
	GS9Ht5QaT4aYoMjxTqJ7pwnpSkx2HvzkMDlkAGTZx1EbKwiXkWgbA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vsb5n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Yw1M2477187;
	Wed, 18 Nov 2026 07:36:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02jufb0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7asb349283528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D63F420040;
	Wed, 18 Nov 2026 07:36:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 553D620049;
	Wed, 18 Nov 2026 07:36:50 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:49 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 13/22] nvmet: add context annotation for nvmet_ns::enabled
Date: Wed, 18 Nov 2026 13:04:54 +0530
Message-ID: <20261118073505.288910-14-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 57gfu20_0REvkuMSSPeDmpu23nj2LFam
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afd559b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ytfzEcs4y3VMyTrQ1fAA:9
X-Proofpoint-ORIG-GUID: qaJN6X8Q29cCjAM1B9QsBT5lXTsKoV4R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXx7cZr4z6o5Yp
 uMDZRyPhAO6V/nyMRZCfi9fflFGm1IQGVBnt4KGCfTnxFPAMzNh3Bw5Kwt43vKkdoIrt+nyi1Kb
 RKWTsGvbVv0Wqm24SNbm6kYuPO3aIwY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX7Jn6ufKjpyfX
 SXMex2dvtE7BwTi7fg+urNFBpAH/JTAsG/vxNibQdpS5ecnZYeuBXiUsZuLoCfykdPjMtkqUlt7
 aFpXUokr35gNiuqR7x4Yh/7hjhh/nAbqv+nOmkvtQ2qqsyqKCMW80Dl9SbX3qZ7TVa6OkVJOBoD
 Q0ECxEJQb1LI23vb13nNI/cEBPW5J00AaOetl6QlSZQI+qDVgBs3LA9w/Y+to58AkxipaI1OhdK
 6fHTM0/5/6yoHgIoc44iGnjr/uTj8YrN/1ZmN1q4CsI9eR//DZ+WRnPyPD7u1wBmyrVKD5C8lpl
 lSZsUq8yKjLroJCI2xZV54dP9K3UpJHHNJNBlxrfeafoL3UfQ21jvtMEwEZsV9rKD+fsdmpwN35
 syR7qUxWzEz9f9yQXxRsmXq3c+44ww64GTE+jLMtUFxdbiJoMUY7YyrbHUDz7VUx2O+Oc6ENzQi
 pIPNQC9lmL05znySfYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233715_424951_8BEA1019 
X-CRM114-Status: GOOD (  12.70  )
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
index 5e9bfec2d384..6a1c27cc08e5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -170,7 +170,8 @@ struct nvmet_ns {
 
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


