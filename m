Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECA606A323
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nhBacWdh;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ne1w68Hg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6lBzG5pHCCITcAmTijtm8sczzu3scA2cDZ2tVz/G29k=; b=nhBacWdhhWwFi2
	lQ/3PUUZ46HpoPVKcCpUooWU9ZYToeiQWicbz3qOICZRVy7CswZk6H4y4G3g5DL+9eeRDXLGZcmVW
	u6c7R+Qv2As4jiuBDJvXnZ7HU2GQ+zj5Q3mchX0sHp1W8mYOE/qHSmvr0MjaXBGU+MERSqJS+80OB
	si857YNWhZQ4lB1jTJHnXectBFc9KBcoyK34OFciFApUQF02Fb0m54HQZMi0jKWsZbALKN8qC2g1L
	rmflrAOEA8+zgYaHam/japrweximVksj2jjVTHuB3tz9xGpgd7v0xzLuMPaCLUlKPLD4lF6AN1nks
	QdUQWjHhdtVfNX209IoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7v-0000000HDOK-3Oqg;
	Mon, 09 Nov 2026 03:32:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7p-0000000HDGd-3hZZ
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:32:59 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iLlL746244;
	Mon, 9 Nov 2026 03:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6lBzG5pHCCITcAmTi
	jtm8sczzu3scA2cDZ2tVz/G29k=; b=ne1w68HgAS+CqCFvedTN2V0c5FlfFFzi0
	4KkeGWOWNfjVA0QG9mkTSJSdw3M+ksoJQtTe6wkP4i/wpHVIARV1meerbsGDBdYH
	qXpmR6Ns0sS5dL4wG+8ZcXiYVdQGln1DlshRhufSV1GPmZUMEcqE9DDVwJwf1NCl
	iij6JpXMgO14gougYiW6s/v+dDOHiI9ePL//fw2nBbtGzJH+enkNlcMYExP0fQPG
	zlIZgxlYCyyos48blHoxofE6nZ+Mp6Yo6Jjat1/3YmAix/VB8CTzoNkiTWICpZVl
	llAwiFO2TuK1LJFqp6FpX/Bjnr2wKF/5XPom9X3OQIrokszFI6uhQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdfte23-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93JsNG2454049;
	Mon, 9 Nov 2026 03:32:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghfw75y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93WgvF51052990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:32:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D0182004B;
	Mon,  9 Nov 2026 03:32:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009A520040;
	Mon,  9 Nov 2026 03:32:37 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:32:36 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 12/23] nvmet: fix nvmet_ns::uuid access using nvmet_subsys::lock
Date: Mon,  9 Nov 2026 08:58:17 +0530
Message-ID: <20261109033102.982191-37-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af13edf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=tnssPzULpzvW8DzHSp4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX3cLSHkd046XH
 mqM3AOi6GPb8sOpDGwBZlMv6TACuN3JS1Y0+o4dtFopZXiP3nDUm1mfPWFUL5sOWeUS39P5nVTK
 UI4AAGoXFxp8T3To/BlpQUYK13opU4dfeAoSR3CbLWaekWIOcRYOtdinZjmemALwUcwAilDGBWD
 jtNV2lzuaR6lUGt4Zz4HS2R1gAtrFQENqsWhulj/QcroS6OMDzKcw3s58dF5NXJe1REw7AJFwji
 DTu052DZCKqzpwMwtPqsmH5LQo4Q3wKVZREoJ7xlGncg+ByJ7c93rBFSGp4iYpFTfLca81PXrQr
 n0zKnAVfk5HiY/FQxKklcdCxOBgtOWw0OB2ae7+1Lr3AbxSD6yVpGPbq3KKC9vXMm+TD5n9bp3d
 UUZyOJZuBzBepZnDgTUAcb9ZE5uJI0ssG2DbmLXEYPx585OagzFFmC4xJo7/Dq7WQg5ZAxf4z1/
 jHNwLypnzkIzieZpmeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX4+pFATPf+dTZ
 pRWs96cfR0mJrk8HbezM+vVinl7EHlKM3CaIQtSMnzhHlzZ5aBTwT6ssV0CL318jZNt3oQuo90/
 rP9/8peFC0nH8TAq1o/YgemGLQpJ9tE=
X-Proofpoint-GUID: ljkVnKbGk7bcJAY4m4M3IAoHUBlG4QgH
X-Proofpoint-ORIG-GUID: _w7UjROlgAi2SCwY7cp9Z0OFfOLqiPd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193254_050367_D3DA2484 
X-CRM114-Status: GOOD (  14.27  )
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

The nvmet_ns::uuid field is protected by nvmet_subsys::lock. However,
nvmet_ns_alloc() calls uuid_gen() without holding this lock, triggering
a Clang context analyzer warning:

drivers/nvme/target/core.c:781:16: error: passing pointer to variable 'uuid' requires holding mutex '_res->subsys->lock'
      [-Werror,-Wthread-safety-pointer]
  781 |         uuid_gen(&ns->uuid);
      |                       ^

Fix this by moving the uuid_gen() call into the existing subsys->lock
critical section in nvmet_ns_alloc().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 77e2ef211711..08a70439fd55 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -771,6 +771,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 		goto out_exit;
 
 	subsys->nr_namespaces++;
+	uuid_gen(&ns->uuid);
 
 	__release_ctx_lock(&ns->subsys->lock);
 	mutex_unlock(&subsys->lock);
@@ -780,7 +781,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	nvmet_ana_group_enabled[ns->anagrpid]++;
 	up_write(&nvmet_ana_sem);
 
-	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
 	ns->csi = NVME_CSI_NVM;
 
-- 
2.53.0


