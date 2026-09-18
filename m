Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8D6C982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y2ManuN/mQuTHBLEwhLWm4cyLDIrzAffSanFy72svN4=; b=TcZLjMSj3ZbDY+C1O9CZR7Q9hT
	UK+vi/o3akfis+tiVOIp0oeYAcTc65yCvPaDGK0HPiRUBmD/p6EnkZMn5kMbonB3zAnSgOVusRhN/
	xRqVX+rPUzHyrFOUJVdSVkPyaYHR/3ECzIiVhK++sgf0K2d8P6u76HebD6Ci5neNckVjHIrdzjS8g
	bzAO6R3hj3qHtrEG5J+WjXtZ1Yw3PdFpFKZSjKh+xkPtZKOxaVBX2+gs2xR4xqCesgANV89xvuRKb
	RXdbO8H/Svjotdvn0a9k5Ci0R/XXSp1ug843RQ1gGPIaKJrmBfOn3gE/FBFQl+8l3dL3FUDnE+D5z
	63ZwYTmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7bRh-0000000F1X0-1FKh;
	Fri, 18 Sep 2026 16:28:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7bRe-0000000F1W9-1Kde
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 16:28:15 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVoB8217702;
	Fri, 18 Sep 2026 16:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y2ManuN/mQuTHBLEw
	hLWm4cyLDIrzAffSanFy72svN4=; b=iI/1L+gbogTbBs8IjWabXJJE2GgSiPb6z
	Kwsx8ttgzXB3EvABVoT2LZMpW0DIFjmp90f3dPuLQTSSGdj0hvcGbDSsaA+i5EaD
	qBuj/+MBuN02b9lMWSosBp/hzGx1n8TUCOAg485C+zShVnpHXc5x4Uqfjo/kgwol
	oPys/5u8wAjiTGjrcP4amH1r1w/jYf9aJlYOsC79f/77i+mzkTwR1FzdFFEWMBTA
	f8SChVhHf8PbcgqY9aiI/FMN3LPZ5MOvpHsecArB9Wa+qPEUT5WWw3wClcE2gtXl
	V9lbWKTSJD2s1q9xnOcfkGp7zXAEZNQ4S6q7qQsxoG7RPK6QoQ93g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5egpbm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 16:28:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNrNi777353;
	Fri, 18 Sep 2026 16:28:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yy8ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 16:28:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IGS6Mw14549344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 16:28:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 552FA20043;
	Fri, 18 Sep 2026 16:28:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6489120040;
	Fri, 18 Sep 2026 16:28:02 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.58.220])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 16:28:02 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 2/2] nvmet: don't allow I/O admission after percpu ns reference is killed
Date: Fri, 18 Sep 2026 21:57:31 +0530
Message-ID: <20260918162736.802665-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918162736.802665-1-nilay@linux.ibm.com>
References: <20260918162736.802665-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfX6uiIrG/3IzkS
 uR7q5/hmTgf5OvjxhXiNhi5LNSb0Mw0rbPcm2cqlo/9a1oWKCn6iCIWsnbrCeSa0UrMNbWJqJ7Q
 aqs8TQji3qxwXpiq8zjVh91TcAtIarUT21Xi8fYGHkMWuejOkk0ggubQiUkzp1BWlPpFcKqVmAa
 lTQrRnEy7nTw/NBZ4hJkcuCyyv8UDagN6CeTR69bZ/23m3W4+GrxsC7/Wcd8SFnpTXc3IzY4xWL
 gX1lu6uASXrIShDRBGW6z4ooMmSpvCCOWab+zxeNLHZE4dbEjybd2/9LkGH5RlSrTo5+YJVO++D
 IhsJbXWi8B7GZ6WsnrmsiWLCmZtlBKYHKuvzHXzQZbpRxRdVP5tEc0sEVFTS8notYQzbH6yNV/g
 zUEnUTedfmLPxSIQBIInLDSLvRM+MHKDzZ3j+cG0pnLFukrgiA/TU5d7sngXak7NEAkLjs4btXv
 JezL2qRT+1bi6NHwcTQ==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad669a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=uDwynFsZHstSZAYALL0A:9
X-Proofpoint-ORIG-GUID: 7oz9sMOwtZnmaSxna116-9hYel6NeCd3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfX02NkDgY76MVF
 8e/cwsTfVj8McB4BJu3GL8FqF8doc50Zd6WtyEqdRmVp8pvr8xx81IZ1ad1A52+EFr+ZxwG3tOG
 nPf+gAz9iCo9hw0b/jUyEs6i32c4mqI=
X-Proofpoint-GUID: 7oz9sMOwtZnmaSxna116-9hYel6NeCd3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180229
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_092814_472977_072A2E7D 
X-CRM114-Status: GOOD (  16.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_req_find_ns() uses percpu_ref_get() to obtain a reference to
the namespace. However, percpu_ref_get() can acquire a reference even
after the namespace reference has been killed (or marked DEAD).

This is undesirable during namespace disable because nvmet_ns_disable()
kills the namespace reference and then waits for all outstanding
references to drain. Acquiring a new reference after the reference is
killed can therefore extend the namespace drain period.

Replace percpu_ref_get() in nvmet_req_find_ns() with
percpu_ref_tryget_live_rcu(), which only acquires a reference while
the namespace reference is still live. This handles the race where
nvmet_req_find_ns() finds ns is admitting I/O (or it's live) but before
it acquires the reference to ns, its reference is killed in
nvmet_ns_disable(). For instance check this race:

CPU0                              CPU1
nvmet_req_find_ns():              nvmet_ns_disable():
xa_load() -> ns
IO_LIVE == set

                                  xa_clear_mark()
                                  percpu_ref_kill() // DEAD

percpu_ref_get()                  synchronize_rcu()
        |                         wait_for_completion()
        +-- succeed

Replacing percpu_ref_get() with percpu_ref_tryget_live_rcu() prevents
the I/O request from acquiring a namespace reference once the
reference has been marked DEAD.

Perform the namespace lookup and reference acquisition in
nvmet_req_find_ns() within an RCU read-side critical section.
nvmet_ns_disable() uses synchronize_rcu() before draining and exiting
the namespace reference, ensuring that RCU readers which may be
acquiring the namespace reference have completed before the reference
is exited.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1d4b4936bcac..01bb42a3e42a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -446,21 +446,27 @@ u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
 	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
+	u16 status = NVME_SC_SUCCESS;
 
+	rcu_read_lock();
 	req->ns = xa_load(&subsys->namespaces, nsid);
 	if (unlikely(!req->ns) ||
-	    !test_bit(NVMET_NS_IO_LIVE, &req->ns->flags)) {
+	    !test_bit(NVMET_NS_IO_LIVE, &req->ns->flags) ||
+	    !percpu_ref_tryget_live_rcu(&req->ns->ref)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		if (!req->ns) /* ns doesn't exist! */
-			return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
+		if (!req->ns) { /* ns doesn't exist! */
+			status = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
+			goto unlock;
+		}
 
 		/* ns exists but it's disabled */
 		req->ns = NULL;
-		return NVME_SC_INTERNAL_PATH_ERROR;
+		status = NVME_SC_INTERNAL_PATH_ERROR;
 	}
+unlock:
+	rcu_read_unlock();
 
-	percpu_ref_get(&req->ns->ref);
-	return NVME_SC_SUCCESS;
+	return status;
 }
 
 static void nvmet_destroy_namespace(struct percpu_ref *ref)
-- 
2.53.0


