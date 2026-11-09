Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F99606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k/u/llzf;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=maFiG041;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TT882ugN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0CxsY8V39pjbGIroMUoOMGbdcrj2pgQFhzm1/8yaew8=; b=k/u/llzfDIrnhz
	GdCKZ8eWtFvSXH8xLY9IP2ffnEust7kA2s+4aC1+eyDDp6/VsGYNfQIABWT0TXP2nbk2MsxdP5XUj
	Q4Z9pnXP7CCAVoDPH7gvDFqVm7ZBpqhhdPncQuk6xJMW2T2H5CXbWj6rdQSublZVruGa5OWpNs85D
	1vH8A+dk5ehK9WShn6H9UesS6k8fZeqqDuGtSn4cce1p4vhO0a2VHYbX5RsIRjztPjM+va3Qob80x
	YR7d1yWNcgxIs/Qk0+jIXPtNzDnoBnCTaUMLnIikE2jM69MLF4rim8/OGLBfsMBtj991RVg5ZWNci
	Mr8NL6g/yrZbcyz7si/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8S-0000000HDwY-2072;
	Mon, 09 Nov 2026 03:33:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8Q-0000000HDtt-2AGY
	for linux-nvme@bombadil.infradead.org;
	Mon, 09 Nov 2026 03:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0CxsY8V39pjbGIroMUoOMGbdcrj2pgQFhzm1/8yaew8=; b=maFiG041SWkEhVR0xigcli0bm6
	4iJGvd6iVN1dBckts6mBuSFtU4k7roACkT5+q41XSZpcFLaLRTtKZX8mgLWw5aTqzhDoDfqkLsC1g
	rKs2aFAnph6x9UmT1QQiO1nw5T3Zyokhl/Zfv1Iy5nxbEAApUZ49mpWGgRctBmZ1kTpe2sTRzWSCg
	ered/npaW4Sp+94H5KR52v6NyBeKPJpd+1ag1Smq5A6WN4d4Oy7zElxoCFoka93/bxHntyGf0mAHc
	Uz+XrsiLj1fuTUQdf6/eXEXD9ch1aYju2aEu5nnB4PI0XE928XyF/Xa/OmuqLsIqXgpjemd/QSOp0
	QtlQktXw==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8N-00000006Fh5-0pug
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:33:29 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iBWl1887784;
	Mon, 9 Nov 2026 03:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0CxsY8V39pjbGIroM
	UoOMGbdcrj2pgQFhzm1/8yaew8=; b=TT882ugNZRR7pqekCJ7aYWJk+p66DbXca
	ZJWGlW7vLN9owl2Q08wyO9kZrJkNVwM+cy0d5CU4NhWKOc4IPdRf5HWANVefk7nw
	1wsD8Ku4IaHbs7EPJVcEeuwB/RQz08jxDlGuI7OESHs4e4GrVudrBXfGosLWZTwc
	vY499VuY1I4RxotJ2BME0oR3hZNwslnJ1I7g6UeVAdIsAjA7vVXoQb7jVTbQt8Hu
	IynCYgVOfcKdA+251AUpr333X7RXCHQiQX76oUkBSN9XvIBSdk8GRR49fMm2h5T8
	Oxz26yRp8pty8o73F83GdsTdLAgN7+OEpVFVt2E9BBohKezT+Nh8g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkaxt0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90YwFa3423126;
	Mon, 9 Nov 2026 03:33:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvnmj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93XE1244237234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:33:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C01D92004B;
	Mon,  9 Nov 2026 03:33:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22D2620040;
	Mon,  9 Nov 2026 03:33:10 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:33:09 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 17/23] nvmet: add context annotation for nvmet_ns::device_path
Date: Mon,  9 Nov 2026 08:58:22 +0530
Message-ID: <20261109033102.982191-42-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af13eff cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1pHAsNxKj0yKW5Bc50kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX/If8/3WRESrj
 Vj3WcSrHUdJq+oW5thG6x+rzzIXRtoKLQRqGKdDQyl+7mjgJKRtB6W5DunnYuiRay6uqanCMhHS
 t6ias04a5WKjcSMudMQzMwwbAT9RvAZAC/j4DRe2IGzOZI3nXwzJOpEriVbIr2Stsdvj3ZyWkvX
 g0aJndkJJxfllsf2zJOimY7jbcOcDkzi1szGFrw8SkYrs+n7caYXNzvkNjkSlVs28uIMg1Ya4DM
 yUVsMYRIVhjtISfmNB3AacaJd2/xAgpMH24pkVSMXgryj/PPPa+zi72EbL9uIGTdeukt0E/AGte
 2Gin9iC3KdT874P3iJ18LS/qerqwXxuUCEGo5kdknaXvv855fQBUgx/zJENEsxsPAHK1hj6v7Oh
 ziaW/A2v8OBl723Ze/1PiEMyApxGZx49sKa3B2jzeY+VorUqPdoxOnPfTLiztQdDjymxMcqkj5b
 HRGFEriYnz1z64HXa/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX/Tcd9eHyaDFz
 kFBhLFVO59aWzX426C2EUd0JZXEeGQeGnVVsnFJS9ahHNd190Mv52gP2QkgUdaoyhgVzDfPFQU1
 U7uNo2Ge/ZfF/Lp+RbLe32MMWFzfr7o=
X-Proofpoint-ORIG-GUID: FAeRezhZ5wzdyg2iV7-Jl4TW7cxWITOU
X-Proofpoint-GUID: BoEAZTN_IbAFsPpXvibyqCTLGEoXGbmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_033327_684911_CD421B88 
X-CRM114-Status: GOOD (  18.39  )
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

The nvmet_ns::device_path field is protected by
nvmet_subsys::lock. Annotate it with
__guarded_by(&subsys->lock) to allow the Clang context
analyzer to validate accesses to this field.

Some request-processing paths access ns->device_path without
holding subsys->lock. This is safe because the namespace
reference held by the request prevents the ns->device_path from
being modified while I/O is in flight. However, the context
analyzer cannot express this access pattern directly.

Introduce nvmet_ns_device_path() as an inline helper
annotated with __context_unsafe() to allow these lockless
accesses without triggering context analyzer warnings.

Additionally, update __assign_req_name() to use this accessor
when copying device_path into the trace event's request name.
This is safe because the tracing function is invoked after
the namespace reference has been acquired.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/nvmet.h | 4 +++-
 drivers/nvme/target/trace.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a6fb3aab0c5d..fa932c1fbf29 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -176,7 +176,8 @@ struct nvmet_ns {
 #define NVMET_NS_IO_LIVE	0
 	unsigned long		flags;
 	struct nvmet_subsys	*subsys;
-	const char		*device_path;
+	const char		*device_path
+		__guarded_by(&subsys->lock);
 
 	struct config_group	device_group;
 	struct config_group	group;
@@ -217,6 +218,7 @@ NVMET_NS_ACCESSOR(u32, blksize_shift)
 NVMET_NS_ACCESSOR(u8 *, nguid)
 NVMET_NS_ACCESSOR(uuid_t, uuid)
 NVMET_NS_ACCESSOR(bool, buffered_io)
+NVMET_NS_ACCESSOR(const char *, device_path)
 
 /*
  * These accessors use data_race() and READ_ONCE() to allow lockless access to
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 7f7ebf9558e5..b15294e24793 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -59,7 +59,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
 		return;
 	}
 
-	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
+	strscpy_pad(name, nvmet_ns_device_path(req->ns), DISK_NAME_LEN);
 }
 #endif
 
-- 
2.53.0


