Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE28606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DM1Gcxa1;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZAGW+/va
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CQAx1Ai847iDLG4HZJZrcin2b63VwNQmAeEQ35tXNc0=; b=DM1Gcxa1/k9CTK
	UvbExO8YQ7LTlDjFAjtujqO2mtFpVASRtJnGoHaaDwII7+/oxa8lV/izyyBZOzibtaQHBZwcWf95/
	cd9x/jzcJtVOgBy8wl3mU1DMURLHfEeMLNZQNJzsgLUR1vLZXevz5WMPZuwOi/tebt8R9HNPpMl99
	wEkV10QYK2QWQFBgWrtlGNaQc4rGNqmC6Uzwac3x29wS3VN5yRy3tptLdNeTjEFzEuCuAnqlLwduM
	/YTco6lQkjljApXsm5fu1q5VWN9w5sX/5nia6HVV7TstM5M/tKEyh8D7z1eORYcfPdEu9s8wdBI7D
	BAtd3ki/3QV0aReIyZLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEI-000000081Yi-3IOj;
	Wed, 18 Nov 2026 07:37:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEF-000000081Ud-1Ha2
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:37:17 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2S00c4063384;
	Wed, 18 Nov 2026 07:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CQAx1Ai847iDLG4HZ
	JZrcin2b63VwNQmAeEQ35tXNc0=; b=ZAGW+/vaUHv0TlGpI1u/XOqTiG7CRBuOj
	Jo6Op51lHHi7eMg8UFgak+gvq74EXsAqLf8jVUcIZ/6jZ3S9a2bjqm7Rlmy5JMjJ
	RgzSlxdlaN+0fTHx8tfUIuRsvs6eclV9DoRDkE5tWbTFe6jb94cTJPYU5VZLn0L8
	WsaYNvHIDG1Ufar15rWSwCzSi/Uw5t+kg8TzKRIrVq+ToJr1UrXdaHiLiiIBxh5B
	wsG0AyGwaDCSvGmyvENobAMJ4WulFOpqnAZVyDMPEx6BuNpiDTD6tP0IfWQDDB7w
	CHUA1IO8Y3BRspylZgpEal/uZg+lOZfhlBxNmnsL9a9PD3SIe4X1g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t1cy8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Z2FO2477260;
	Wed, 18 Nov 2026 07:37:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02jufb11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7b1M748955784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:37:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B0AE2005A;
	Wed, 18 Nov 2026 07:37:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A879020049;
	Wed, 18 Nov 2026 07:36:55 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 14/22] nvmet: fix nvmet_ns::enable access using nvmet_subsys::lock
Date: Wed, 18 Nov 2026 13:04:55 +0530
Message-ID: <20261118073505.288910-15-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afd55a2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=n9zvV__x3XKbqTZYCRkA:9
X-Proofpoint-ORIG-GUID: xncw8W2AvTdST6aFLimwNDSITC2AbKqS
X-Proofpoint-GUID: w4dRz445bqcUfoLWIS1iBH8WcjZmSn96
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX7dJSwpz1e+/g
 wyYst4lptkQZ9IQpNnNZJLqMuS3mYAzU6k5TKtDOGjcXO7AaWVqhv5gs4KwQ3e80tXSq/uC1/xd
 hUAvW81DejSfs0TaOczDWebaWyLIAI7B5TDQSyXN2D5whR+QFsVx4FfQdbcMxFVCiIEMEgJSnhk
 Fi5poDM+gUqgMHziOcJjIL1NIgxS74pfRLpWc87iSP9iMO8HabpxsK6EI6einmxtCvj4LDCKmj7
 2cIT6WWuJj9mNegB62x2VbHsSxytwHwsEJekAr8LHDyrzGvsyBsPrduShxq1R8osiq9Br/HSbc2
 ZfgX0MCSOM0u3SoXerE/DApOY5C3PruRXW7t6GG7A63c4YOjEGu24VlBAHBFRb0dEwRBUgsfNwE
 0IfHgyBVxhxIFpEsj319Yx/km+oXznSfz47Q6coaFCt4R6LFdbLy78sKzKb/FpK0jP6kyRsY0Fn
 UDjxOUnmdD5YruF4y1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX3I9MwT7VmCRC
 n6MqZT3+1sNPdaeMkgFlqcCnojfkyOZQ+ZiK0YFHbZkqdKJMgrqmKWgiFC2uugbKX1XwhWCJiw5
 R+hs55mi5ZzYzn8LPIHv6nQGh4rPjfo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233715_411372_4187CE78 
X-CRM114-Status: GOOD (  11.89  )
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

nvmet_ns::enable is protected by nvmet_subsys::lock. The clang
context analyser complains about accessing ns->enabled without
subsys->lock in nvmet_ns_enable_show():

drivers/nvme/target/configfs.c:741:50: error: reading variable 'enabled' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  741 |         return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
      |                                                         ^

Fix the above error by acquiring ns->subsys->lock before
accessing ns->enabled in nvmet_ns_enable_show().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 154d917ed21d..997d0a1fa07a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -737,7 +737,14 @@ CONFIGFS_ATTR(nvmet_ns_, ana_grpid);
 
 static ssize_t nvmet_ns_enable_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	ssize_t ret;
+
+	mutex_lock(&ns->subsys->lock);
+	ret = sprintf(page, "%d\n", ns->enabled);
+	mutex_unlock(&ns->subsys->lock);
+
+	return ret;
 }
 
 static ssize_t nvmet_ns_enable_store(struct config_item *item,
-- 
2.53.0


