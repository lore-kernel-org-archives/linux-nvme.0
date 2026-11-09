Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53FD606A325
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2kexJUgD;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AjnONRdC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TJ5OotTNvKrvDZaBtpCs+XMfcxNpvGpdzy0u0EIr5HQ=; b=2kexJUgDk331AZ
	OVcpipXANVA5es/iJSGQmZhpngi+C3au9jEyXOFjkRE/Fm1+2sIcOC25nXZ5Sz0bCqb43SZyKXG0S
	8dXj8wb6wJetUbq9RZB3xEs/ByLYcfNYYr5osnhoZU/Caa68ynpsg7iRbrUu1+sCfK4DaoxKX8p8Q
	KWLwtQIGDqDW/QDAKTo6HzbB9SJ+zYMtO7TKoa9NX14adivCKqsqldaUm8K/gErqdZQhZmYdnxSnr
	QwUSsKl0bXfnDaE1NkxmEFFJRyjeClUpSAJFD1pNc+v0xXXteQ0bZDMSENpsQXpKS03RJZHw+Oyjf
	iRduLbJlnjOAG6z1NFlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8A-0000000HDdt-2SrU;
	Mon, 09 Nov 2026 03:33:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG88-0000000HDaj-1CCw
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:33:13 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90ilNE312376;
	Mon, 9 Nov 2026 03:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TJ5OotTNvKrvDZaBt
	pCs+XMfcxNpvGpdzy0u0EIr5HQ=; b=AjnONRdCkfQFMowOJag8LnEspjtTMJB/v
	L9PfjKBrBNqdZ5BgX3qZ9I/zhFNjHWi7BrxRkfxcr8o2WOzdMcW3egft5Q33AWdE
	aN3c5nW0HAU6mMUHzIXanYGZ5YtcF9muYkqCrUuapStCGcQpzBrKmBZjOGBmt8xg
	txXL/pYzr3qSebHOjqBbWkzuN6yyEiFxme+f5CiLnxY4EABHfKe3X+5/+U93gGXL
	pV1DOvXk8OxVyLKwyFO5ldMZcKOsAzBDZi0XRuwxt6DyYDGFKewuXJUP7eMYYxAK
	uyK8PVj4qt/YGYlVdMzWYULK9DuqFOHxIsUTo9upLopVBhpTF7JdA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunstfew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K2As3630224;
	Mon, 9 Nov 2026 03:32:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0xw4pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93WspH44695936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:32:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A293620043;
	Mon,  9 Nov 2026 03:32:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E0C120040;
	Mon,  9 Nov 2026 03:32:49 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:32:48 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 14/23] nvmet: fix nvmet_ns::buffered_io access using nvmet_subsys::lock
Date: Mon,  9 Nov 2026 08:58:19 +0530
Message-ID: <20261109033102.982191-39-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX9x/soj0nwM/a
 YhGdbTjScOakGu/IIqtbnbeIpz7nAJw+Fy/AOchA9p17x7Yah9riWFDSCtdxgvN1Pxa7zHNZr/g
 HLL2Kv0BhCVxE/FbV+679rXOFofQfSGmoPdNRvPq17YWgueD0I0oUZFooEzNEdliDNce7SxVwJ/
 Mrv02isgvJNnzG8yJurkQRhUzjwdfuq/zRO31dz+mHRtzhHwEEPI5ph5DZiE7LuirUcKNj7vqXy
 5oSENosDj0iUf/BxIRacf9VcnseNKddpOrAvPpTLWJxtoN3ZeCMgAEex1gnEju0qNuowtSdPnaC
 /FvTTMfmk+zoeqTMR3VB2UOV/nt7fJxI9Vt6RpEfov91CvHOkogKjXNQk3JquX1xf2v8ocWTXJ8
 PopYP6k0KAanAXeQX8PQ4HoxLyO6LAY2ddBru6y7gmh6q4TLfTsJWXUOaLWAZABv2o0CgSHsJ3k
 9ZZFR/mNXtaIfeFjDzw==
X-Proofpoint-ORIG-GUID: FtF3r5E_s5qs008AiDZDSKgldso-Oiy8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX2Drdg6+jilCM
 vOoz2x8sdUFdHoGcGr9UPTJTZISwYsIWRnlzFD/sGCoA6rK0m5J+OeuBs5XPf+G05jVzOMwQhA4
 NUPDp3PnmpUEdaUiFZvT380scG2pyRs=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af13eeb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=F9QprSnLlG7oTixIaTEA:9
X-Proofpoint-GUID: gV0crhjzR1E7mLxC44ulmAvOWeUDJP7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193312_345477_8D0ECC87 
X-CRM114-Status: GOOD (  14.96  )
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

The nvmet_ns::buffered_io field is protected by nvmet_subsys::lock.
However, nvmet_ns_alloc() initializes this field to false without
holding the corresponding lock, triggering a Clang context analyzer
warning:

drivers/nvme/target/core.c:782:6: error: writing variable 'buffered_io' requires holding mutex '_res->subsys->lock' exclusively
      [-Werror,-Wthread-safety-analysis]
  782 |         ns->buffered_io = false;
      |             ^

Fix this by removing the initialization of ns->buffered_io as we zero
alloc namespace struct and so ideally we do not need to initialize
ns->buffered_io to false in nvmet_ns_alloc().

Additionally, nvmet_ns_buffered_io_show() accesses ns->buffered_io
without holding subsys->lock, triggering another context analyzer
warning:

drivers/nvme/target/configfs.c:774:50: error: reading variable 'buffered_io' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  774 |         return sprintf(page, "%d\n", to_nvmet_ns(item)->buffered_io);

Fix this by acquiring ns->subsys->lock before reading the field.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c | 9 ++++++++-
 drivers/nvme/target/core.c     | 1 -
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index f8a4d0d88946..34d79fadbf15 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -770,7 +770,14 @@ CONFIGFS_ATTR(nvmet_ns_, enable);
 
 static ssize_t nvmet_ns_buffered_io_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", to_nvmet_ns(item)->buffered_io);
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	ssize_t ret;
+
+	mutex_lock(&ns->subsys->lock);
+	ret = sprintf(page, "%d\n", ns->buffered_io);
+	mutex_unlock(&ns->subsys->lock);
+
+	return ret;
 }
 
 static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 08a70439fd55..805b5f70eb06 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -781,7 +781,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	nvmet_ana_group_enabled[ns->anagrpid]++;
 	up_write(&nvmet_ana_sem);
 
-	ns->buffered_io = false;
 	ns->csi = NVME_CSI_NVM;
 
 	return ns;
-- 
2.53.0


