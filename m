Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439F6C982C3
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2026 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tyn7p4qMx787NAdSdnxhAQIMdWPHTdHAcg4NY+NhEC0=; b=Yk7R8lSQ+gSQPHQjUZeyACfA3w
	SizwCyZtTEY92tgUDiES+Wm1j5dKhC2gI9txD4qG6YGbd0bMBxtcae8RPT8zdhSXqdsFpGU/LTXfJ
	yIAYvVTYUORTfhVV/tbCQb9u5RZVF4eT15aFtv78iiGL3HWflq7oaIevcFfT3fdP8idebiG8S8F5e
	emEISlb6tjj0tZapcmmcVEBLpciVZ8THHxRx+v/i7TjXEmX4yeEkTEQXjwB0ote3QTgtTaK7l1YTK
	e2fESZqq2+WiY+Vb+Dzi7dyqHmbMs2LnHRhayuXnvYDbklYxJl3/IbfmAZJtVU5f0D/wxtgrYc5qy
	xe9oidYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6rI0-00000009Wn3-2ho6;
	Wed, 16 Sep 2026 15:11:13 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6rHa-00000009WQk-44As
	for linux-nvme@lists.infradead.org;
	Wed, 16 Sep 2026 15:10:53 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEVwGQ2848423;
	Wed, 16 Sep 2026 15:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Tyn7p4qMx787NAdSd
	nxhAQIMdWPHTdHAcg4NY+NhEC0=; b=czMpeaFIzK8XXnuENgrEoGmnJGhhLWE1n
	y3tw01nKB+cw4dVn04e9CCsoP4Uxlbf+716wXnoy51ZN/+jatzJG6osej0bClFCX
	yK+a+FztqAk+xMRq9RxqNwkM7t05xHNLZ7Nb/VxjAT+M4Qjbtk6kIvQFH/VQE+60
	V8kbXGcYd7V+0AzDQKU04Xnn33Y83tg+mT2jZ4lh2IVcON3+M+gq3ryLbSO18XmT
	VT51gG6Uofs+bqpuH/IIE0T4Ug7dt4b1Crulky72DD1mMsQps/ObOCdaJ7Yu80wR
	wdBXINjRP+MBYpoIcq8B2we2y4xYHUrUs+eWXlgjEbJtfE8Fhwmtw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e51qu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:10:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEaAL71585010;
	Wed, 16 Sep 2026 15:10:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089putm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:10:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GFAc7h45613390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:10:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E54620040;
	Wed, 16 Sep 2026 15:10:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E89E620043;
	Wed, 16 Sep 2026 15:10:33 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.52.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 15:10:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 2/2] nvmet: don't allow I/O admission after percpu ns reference is killed
Date: Wed, 16 Sep 2026 20:40:00 +0530
Message-ID: <20260916151012.3702896-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916151012.3702896-1-nilay@linux.ibm.com>
References: <20260916151012.3702896-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX9AyQMTC/Sczo
 aNWfdl02ezkbAk9eRO7cK652SlupP1yzWVE4EVil/ywkWbDAtjnmbmB1zwa67lSngnlUnUYmd5s
 PrXt9K39hMAuCO018IUTXe4vVPHmYhG/PrFOwOUEU8g3HBSdqh/dHwWOEUxvpdGScZyoTB5D7zS
 83tyQJJ7MUUQiLOoSsp/isobco+/iel2HNzQsvP6kWQce5lm6xU+bkbqVUznpnG8iDJOw74No5p
 2N7ezkQjHQMDRnGRztk2af4DSKCDcmkbnR4jNNEXlndf5W1gmZfbPUaYMVxvMR6zr5qnoKIZxTJ
 RHdaX5GMW8OiBoolCatt8opMrCJO4KoQBNveRUiVqFSbjbaGji6x+bmiwwXpYSaIED9219lqDo/
 K0sBMmaYxs4XU5BAsBbK4WvkzJ3Mg2ogFTT73hecbzW8dufyNbTI+/a+FSKOAadDTCeMB9Z5CNE
 J24EnaEh+gy5DyZVjWg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaab172 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=uDwynFsZHstSZAYALL0A:9
X-Proofpoint-ORIG-GUID: dZn6IjynXkF34tanayK0rMyapIUqzj9I
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfXx6mlc+Tx3Q9A
 ubMHMxcWNFUSDmt9MM5IfmRx/bvFl5YuHFz9eyu7Tcp846T5KplXT/wyfgURHbYIOsHrEEI+jnP
 /f/WcmCbGMdDwx5sfSeFWegaIdttYBQ=
X-Proofpoint-GUID: dZn6IjynXkF34tanayK0rMyapIUqzj9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160204
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_081048_048834_9CB64EFD 
X-CRM114-Status: GOOD (  16.65  )
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
nvmet_req_find_ns() finds ns is enabled but before it acquires the
reference to ns, its reference is killed in nvmet_ns_disable().
For instnace check this race:

CPU0                              CPU1
nvmet_req_find_ns():              nvmet_ns_disable():
xa_load() -> ns
mark == set

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
index 77d113fceced..81a2ae072909 100644
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
-	    !xa_get_mark(&subsys->namespaces, nsid, NVMET_NS_ENABLED)) {
+	    !xa_get_mark(&subsys->namespaces, nsid, NVMET_NS_ENABLED) ||
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


