Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE6606A320
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qlo1Iu/Q;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ZD1OprH6;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lRFFkXcx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gWS1VXRi78ndF8SXRZTdAydAI4QgvyDyqlkaEIwUOMI=; b=qlo1Iu/QCs57sX
	oATygQthzLnZCWGjlzno6aW0unpKb+wrSJCAWFpoT1wvKCcmSbdN/PRAIMoEkKNEVQ4sgnI2tgYQp
	S3citYMhFgCkTp/Z4auU2MXsg7ITJMHOp51BydIMrQW8iVX6utnB44pxRu83FyL32MO/Pn5aG3wBw
	NtCAW842cQbptcD3GR/C/rMhIpXNyR3MmGEp/NUKcBhPuOm4szBksUqTi0DviKxKXzuImIZ93Itzb
	kErMshSJPjFGaJnTyuEBaTimecvV/Pq6Kltm55nAfL1AkwSg05vHWemNgsyh0t3kGT/LiUHpNd9XF
	CBQbi2d/IGvzgXzBFFyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG96-0000000HEYH-3Fhi;
	Mon, 09 Nov 2026 03:34:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG94-0000000HEVV-16aJ
	for linux-nvme@bombadil.infradead.org;
	Mon, 09 Nov 2026 03:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gWS1VXRi78ndF8SXRZTdAydAI4QgvyDyqlkaEIwUOMI=; b=ZD1OprH6IoJwF8+VCZxQ95mpFD
	FzPgARTgGvGfkVDrhGifvWRvJ69q1dUrcApaTHO2bxNWC2nSyMl7ax0CFaHWYmQ5ay/Uzh6J8j074
	wBJ/hsFfkv8BKQmIr3TRb9mSrpbLtccfpXYC674xdoQa2ubOEA142tnGIN5FbaYZYGrSpLKJYRJRl
	2hy9z8KO5BaM59bCtvOd/BxkA4d4r+SQRTl+xsajGbkNOUFjzWNB0N4aBmrUep4fJv/K7gyYU94bd
	5oJhn3rkKK43JtoC8fOReKKBTopWo6vTWqSFM/arEQ99Kd5qxkkEBubCre8tw+XB+oJY2k4h2YpJQ
	+XdN/rwQ==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG90-00000006FjY-10mq
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:34:09 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iXND1888259;
	Mon, 9 Nov 2026 03:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gWS1VXRi78ndF8SXR
	ZTdAydAI4QgvyDyqlkaEIwUOMI=; b=lRFFkXcxHzctNE+PIFO82xykYdILGiC3P
	co4pymNIvKKUg+plkrtG0bcMTaK1DE9lRiYcurVSVlcYtTZbMegKeqPeVSjpjnDs
	+1/E5bhecAhS6t5LHAzx7cUYfHSLRJAOS3T26o77EbiMiP2eiU54dhyIXOKS7lGR
	1NKv3ONl24qxXUXHGjgyC1gRYEyKqReEWuv6nT8AY514LKhq7tW4y/nG/wQ6au7Z
	4nvgsC0d20XJ/UQE4+rvrgiyb4ijVeWUX7bKbcMWAj4hpYlY6L9RHqXClQ/IYuA4
	v2bDxJgVSBfGbp+pR3HIEui9HP4TsZOIEyFofv5cPi7iD9PRmhbZg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkaxuh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K4v22454181;
	Mon, 9 Nov 2026 03:33:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghfw796-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93Xs6D31326688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:33:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C61020043;
	Mon,  9 Nov 2026 03:33:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5691F20040;
	Mon,  9 Nov 2026 03:33:48 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:33:47 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 23/23] nvmet: add context annotation for nvmet_ns::debugfs_dir
Date: Mon,  9 Nov 2026 08:58:28 +0530
Message-ID: <20261109033102.982191-48-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af13f27 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=SkLaCrf0xh329ntBOpoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfXyuixARyKGCFz
 xr8hJ6KCYSk+FrpsURbiDcWtOIk69WN7mrwj18+fAYpvNsbY/SBklrrNPR0P/LgJE2mkQSZtcVz
 GW/UfZg7n4pqLsIlzNMJ99hEtT4NQWSS0OiJm4rRC/z5p96I1QJN9dHaHUyRqtmn996E2wjEoai
 BSzjzi1MWRabMZYiiGZuFKDOeb8gLAmYYU5p6mkRHlXnLItW0EmQ3fPCCQMcWzOQorzXu8dRdre
 rsgrrRAIJ6J9DiidKZ4tD7TuDIkpfqPSZZWkd7zjoys449xlLbIz4SysvHuJyl0Q5fEJiFphs8g
 tnvoA/NhqXLY9QkSPhyz77MFevluu4DqK0xeiOfZ4zxgcaJ7bKlg7pgmq2NNzimAyoqfVHw3cdB
 J4RJRtH23MduV1xM+aIHznxU73d3rWhvd9knDW27qkQ4cmOm94bR+KkIPF/7IF4f2cYW8B2kxh+
 mOdMlnTm6BWUDfO7rnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX45mM+4pKs2mu
 6RCS5lu98VdjpSV3xRRx/CyVsK8QqA65+O013aGS2gtM0sxqob8IMEDFstn5irV+IdMlbQsl1mg
 sgpQeCRd1d4dE0FyyoiVmNcWreSkmZ4=
X-Proofpoint-ORIG-GUID: 1vpnE5C_HM4FzTS5V25kK_PM_gImOMm1
X-Proofpoint-GUID: zOHDOPDbyxufuDbufE6g7e_AjKSvr3zj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_033407_624296_B18DA0D4 
X-CRM114-Status: GOOD (  15.14  )
X-Spam-Score: -0.7 (/)
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

Also, mark nvmet_debugfs_ns_free() with __must_hold(&subsys->lock) to
make its locking requirement explicit.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/debugfs.h | 3 ++-
 drivers/nvme/target/nvmet.h   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/debugfs.h b/drivers/nvme/target/debugfs.h
index 2dde79e8a2ab..ebab05ddf3e6 100644
--- a/drivers/nvme/target/debugfs.h
+++ b/drivers/nvme/target/debugfs.h
@@ -16,7 +16,8 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl);
 void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl);
 void nvmet_debugfs_ns_setup(struct nvmet_ns *ns)
 	__must_hold(&ns->subsys->lock);
-void nvmet_debugfs_ns_free(struct nvmet_ns *ns);
+void nvmet_debugfs_ns_free(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 
 int __init nvmet_init_debugfs(void);
 void nvmet_exit_debugfs(void);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 77d518739f91..a85874992c19 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -198,7 +198,8 @@ struct nvmet_ns {
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


