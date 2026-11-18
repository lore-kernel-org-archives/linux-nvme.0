Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B4606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BHxXkEHd;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EsmdgvqQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sXRNO53dnlu6cNdw98xll67t6w0d9cqmo6n9hO7qhlQ=; b=BHxXkEHdSBkwl7
	SiWLqd1A4LxMsviT1AssEYql+UHJXv4A+5uzEmjzPFlGZuF/yZBLRyftjEUNt4WJY7TMCNiQ4qqIx
	Z29BPvmWcWdeiDW7zRMLN7QsLecC3Ujnsrpd8LeHyeh15kxydylo1DKePO6bNEeswvt6qhAHkRcEU
	U+Rxmksqn1/J4LTvsNf2Uky48pc3oCX0EttCAPSFuaFxzJuixbiGyJs3xgZ0Wxvv9YBtAMpakPgQk
	i6Rg/Lbtz/fL75F+Kgf2EM8hxj1oXa4PgDkDXG/GCk0YRvK+/XQ7UDVsTiu5W5pQRF3eZ+7Need8+
	hK5AQ9CJ/BTUEfK1LURg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaF0-0000000824V-0fbr;
	Wed, 18 Nov 2026 07:38:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEx-0000000822D-0KFN
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:38:01 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2S2tC4063459;
	Wed, 18 Nov 2026 07:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sXRNO53dnlu6cNdw9
	8xll67t6w0d9cqmo6n9hO7qhlQ=; b=EsmdgvqQeaD9cDJHhUjI3UZLYV/8F3kGZ
	CgGgf3y84x2ITRIKlykvwqeUe0WTxVTEgoOQEDLzKtrgrMnUGipnjv27Ztt8iobg
	BX20rqln00bm2YS5+bCTac4mSP7lVrx+jNT6mZX6R+tLYPkgBUUREOgiNiiXAviD
	vhzjTikriZh00ahO6E3dy1BzL3nxn1ihGRSJagh7NkBCvzv6z8jcge3UUjuQiaon
	hsloT+hBayAlMnN1usA39SjKIoJaErDQPSf9ISLmaXQcgjml+lm4dM7PyjLDzp1v
	1RXsq0lIlLl3XBQz2gf0dOwAWhK3Sf0YUAg18WHx7ikWRAIj/c/4Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t1d15-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2nuAq680851;
	Wed, 18 Nov 2026 07:37:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvh6nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7bjtW45809948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:37:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD9320040;
	Wed, 18 Nov 2026 07:37:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AB7F2004D;
	Wed, 18 Nov 2026 07:37:40 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:37:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 22/22] nvmet: add context annotation for nvmet_ns::debugfs_dir
Date: Wed, 18 Nov 2026 13:05:03 +0530
Message-ID: <20261118073505.288910-23-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afd55cf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=SkLaCrf0xh329ntBOpoA:9
X-Proofpoint-ORIG-GUID: 1cReAKioiRCKSORyxniliutQtPdQqyi1
X-Proofpoint-GUID: C7MHoOUyRzpnvro4txfupagGRc55jg31
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX++yLYmHFPCph
 k2tm3ti6bsKiFRzKdrWlyG7YZVxjZbpkxkxanj4TSsnGO9zXqzs0THrWyHMyBiPX5KxQYw6ZPRU
 kcTAd6TMJfQ1nmlAaZjc/UEZQQB9wpJZ66CNaoxULkUi32BtI3RR8MhopXcqFVaO5beVwt6rqcl
 yvhLjfT6/lE3hJBSfTO2RHwdIqcQYCu+zbS0+cAoeXbaBHOazLRlyFs5T+NXJzACdMDWvelD1bO
 QihBDe54+u5Qnmh8Z4VPDld+c0PijRicII0fwVuZV4OiLwjwj3kQApI1y6TX2LxppPGf1acrpqc
 j3hrD5wpGsWA1QUKDV1uVtIfi1JZNm7TU1EOa+WbpAcGCSGwPj+4CugL+OSZqB1ATdupbmLoDdq
 i9j1y0bkCwEFkyOliNWs5OvX8TSo68g93SU1QH7BtxYXX3vFXNUcjUVEXcj/N4kmYjxACT69Lb5
 ojJ0CtpP2YfOeNx7x4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX2Y19kWQib3DD
 l91hCEACRpHrlXvTFsgMm0RdEDS41KAXkAz1PHjk73CS6joiYGy4d1JWumTBExBYE9wV78TMtKp
 Y8GfzyGSJZqmvvR00PInezI/B3Spfh0=
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
X-CRM114-CacheID: sfid-20261117_233759_936352_C140FF13 
X-CRM114-Status: GOOD (  12.27  )
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

The nvmet_ns::debugfs_dir field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) so that the clang context
analyzer can validate accesses to this field.

Also, mark nvmet_debugfs_ns_setup() and nvmet_debugfs_ns_free() with
__must_hold(&ns->subsys->lock) to make its locking requirement explicit.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/debugfs.h | 6 ++++--
 drivers/nvme/target/nvmet.h   | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/debugfs.h b/drivers/nvme/target/debugfs.h
index b559d254fc2a..ebab05ddf3e6 100644
--- a/drivers/nvme/target/debugfs.h
+++ b/drivers/nvme/target/debugfs.h
@@ -14,8 +14,10 @@ int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys);
 void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl);
 void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl);
-void nvmet_debugfs_ns_setup(struct nvmet_ns *ns);
-void nvmet_debugfs_ns_free(struct nvmet_ns *ns);
+void nvmet_debugfs_ns_setup(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
+void nvmet_debugfs_ns_free(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 
 int __init nvmet_init_debugfs(void);
 void nvmet_exit_debugfs(void);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1123c9c708df..e6309960f026 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -197,7 +197,8 @@ struct nvmet_ns {
 	struct nvmet_pr		pr;
 	struct xarray		pr_per_ctrl_refs;
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
-	struct dentry		*debugfs_dir;
+	struct dentry		*debugfs_dir
+		__guarded_by(&subsys->lock);
 #endif
 };
 
-- 
2.53.0


