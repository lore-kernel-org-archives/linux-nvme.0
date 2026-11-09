Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECFE606A335
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PSPfFp5d;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DA7NOsij
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Mj7Su9R6Bn/lsxOplfvSGZr19K2rz7FY5UeLkG/IMJ4=; b=PSPfFp5dNvIMp4
	ykTXICzeisIYh84i0/85dyz2f7xO1Pxd6mdf328FssUgPMWyv/3CyQj8F+ihquSCXvlOnYhz3/vTi
	8+MS2zefQfquNeAAeQMEp+9ZOzDSplVVmIfR97lOFrZNL+Jy5OpM5vY8ZqStJxdrRCUrymEws+QsD
	e7XVclcOz6J8c2dwDvdIz46XxwvhQi/FPwKiw8Dai5+O9OwitDEfuvBdO3+t5WgCcddvnSQstwrGK
	QBshCiRH7YeIR3OGvzDfy+PmADmZaWpeTv/jdd/2qMcixubAb417XrNYHgTbmOJMQn7FuDwLOhVqg
	P1Jc+TVmINJLZ9uwPSmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8K-0000000HDpy-1Igg;
	Mon, 09 Nov 2026 03:33:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8G-0000000HDmd-3Hqf
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:33:23 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90j8dB1961093;
	Mon, 9 Nov 2026 03:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Mj7Su9R6Bn/lsxOpl
	fvSGZr19K2rz7FY5UeLkG/IMJ4=; b=DA7NOsijsrPAO7dtEpEo11XjfQXKsftNr
	wlyCYbp7Ya3H6JizpdLhj1N8DILTqPenNcUXbG2JPDKxaqqX2hEpHd4hLrq9HpCj
	lLoRmzgOCCj+r7pbt/hB/PRiz3gmNjeAuiJsiOAiaG3GJ+XbArZLvptJ5CfowB/Z
	kiptr8zvBVpy21CaHHhNHAbrm3Jsu2A4h5nCi/cBcbq1HngkmenGOIGcKlpMGs87
	CvqGvvx3dmQTr7UUq2EpEBUWujAsryHX+43eb1zxLNrwIhdNFbACvigsdBiWyRH+
	o9f5coktLG2a3UkyBgwsQxGdYRMVu0Xhn5nezb5miMTKtUmOTeIYg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuj32c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93Jtts3535201;
	Mon, 9 Nov 2026 03:33:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfajwfs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93X9re28181074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:33:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F32520043;
	Mon,  9 Nov 2026 03:33:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D40320040;
	Mon,  9 Nov 2026 03:33:02 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:33:01 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 16/23] nvmet: fix access to nvmet_ns::enable using nvmet_subsys::lock
Date: Mon,  9 Nov 2026 08:58:21 +0530
Message-ID: <20261109033102.982191-41-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX+j4b6Rv8y7C2
 PaLeiVaBcqEK0nJhnDxDvl1/AfhMlSkXYca50Df4fBrRSr5S1KfoU5HaeGvE3k/YTP7I+/UyJAT
 7LddrV03EWaCZF4xpope37vI8VxmLp0=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af13efa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=n9zvV__x3XKbqTZYCRkA:9
X-Proofpoint-GUID: yPPbpeMdhwaE1XMX95J0FffODSOo_QgN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX3/b7gGDVMFxz
 S7dSceOEgUmII9aulWTvz8JgInsNDmrHUWMjvwyDa4WDb3cwJ7RAOCQ49dTB2smGdWqybEOWlL7
 O+7Ht3pfxJQXIEf+ZOeERYbds1bBTa/rMy62tq8vFnhR9AqvGPDtgpW67yZfyCYsuB2vzMApo/H
 wLI2BD3EhnjPRsnOZcXO0YQ37xM2qsYGHJqbvete0H0+KeahorsglZ+vVQz25SObrNEm1TuputK
 M88vVuYqkRvSMdVfKGUjxGAI9RLIf4G3HIfqtUuTnLze/dVZ//R5HPnEhXxpHxeRcddZsBC6VT1
 yxaDCtISbCMjvQNjzUd/TmsX9kxJyZGTAJWYLkQW3rYcU/um9m2HPx6oq/hGVgYl0Y6U8Tk7Bbw
 sMOBsZpnHelo8Knt0aezmE5o7vGofN/SKhIEjQZ1fIgPBW+hNgQExx54yQ+dZXesnXqjROopajR
 LC1TZ7u/h3/qC2yFPSQ==
X-Proofpoint-ORIG-GUID: kUHSk-lCY2bgqK7G7uO_J6P1uTtGV5g0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193320_954839_BB099BF9 
X-CRM114-Status: GOOD (  13.43  )
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	T_SPF_TEMPERROR,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_ns::enable is protected by nvmet_subsys::lock. The clang
context analyser complains about accessing ns->enabled without
subsys->lock in nvmet_ns_enable_show():

drivers/nvme/target/configfs.c:741:50: error: reading variable 'enabled' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  741 |         return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
      |                                                         ^

Fix the above error by acquiring ns->susbsys->lock before
accessing ns->enabled in nvmet_ns_enable_show().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 34d79fadbf15..ba44d404ad56 100644
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


