Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F98C71155
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jun 2025 08:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tDhu4oOdGKC2axosTO5Fm/ui6IIrmJVosxiS3JF/KYM=; b=V5wAZuP3ieTEDRCVVeYlxaPRMj
	TbUEL1baDvcMoh4S49hzrCHupWNBrsOGPUx85g3b45JyCBgxbsg5fX4UU6A1qrHXshj2AB3y4iGon
	a2vtYh41hJ1PvzJQwDzbx36wCdXaBUNbKo15y587jCYBor1dP6EPHQHAuJOvU3S0U6vfiNH/4ZDzb
	cNxbKvmwf5sZrVYe46FIE4lTN+u8RUrCGXQmNRTRcjiRMKl7dWLU4CeFfGWhIgmzw9VCe6BsiEDb0
	c2XfjHjb83uW9UDs2gVX0sWRgD6YoXc6RfXnkqaLgqqW0Wukc04bSO84UBaXjwk7FV2iEY5ZYTGfd
	sbSP2Dfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSWqj-0000000F0tz-08Ib;
	Fri, 20 Jun 2025 08:11:49 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSWiY-0000000Ezu8-1d89
	for linux-nvme@lists.infradead.org;
	Fri, 20 Jun 2025 08:03:24 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JKF10M022848;
	Fri, 20 Jun 2025 08:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=tDhu4oOdGKC2axosTO5Fm/ui6IIr
	mJVosxiS3JF/KYM=; b=iVNv/F4wcpyDPv9AFuBV1rwV/gC/c5wg77kziPZ2AhRW
	Kcbry/TSU1hq3qi1vdOM0yzgtzMv4RnyOQym6GZD7A6UuGPoJFUIqKM77rMwH3d2
	4tqzDtwZxzG5NDvmwaZ54tCSwH6AD0o6V7DKFecZZ+H4716WiMIN3Dh66juWTJ8i
	RHqQV5CKnk1Y43lCoN7EYwQWjbPRle/ioAx1y6dehaSv9hqalpD6d2m7RqLhpBXG
	aRz+jb4AjY+uIIuuthAtOors76bUoF8BOgo2Cf33RaDttwCyaKMFmpK6J6n9LITr
	lQbPMiYE0iRn66ZtJsP8uN7FdwWnECDbYrMvDK/z6w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qpryn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 08:03:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4IwxV011233;
	Fri, 20 Jun 2025 08:03:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdttanx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 08:03:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55K835NN51577252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 08:03:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D4D720043;
	Fri, 20 Jun 2025 08:03:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A862F20040;
	Fri, 20 Jun 2025 08:03:00 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.191.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Jun 2025 08:03:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@suse.de,
        dwagner@suse.de, axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        gjoyce@ibm.com
Subject: [PATCH 1/1] nvme: correctly account for namespace head reference counter
Date: Fri, 20 Jun 2025 13:32:43 +0530
Message-ID: <20250620080257.27993-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YZgDBRElDfIC98nXiJthncgAjN1mAjUJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA1NyBTYWx0ZWRfX2eB9yQ7Wtwgr J6jufX5KBsNnnwIohurImk2wSXwOlW5UaZi2cbEiVh5emZtnh1kQyYgDY/jU547RiRprQ8L2Nsa dKrzy0pBodq8dZtK29uDpRf+UizLpNngkMlwxZRqAPESb2eBxWfIrmlbF+ZKHrisgHU0CczQaIq
 FB36na/ICU/qdcxuoA4DBpWKR7Ryd15asc0ktU53ts3RCbZKYqTwKrs9USPrX/eOSkuTg64RzCh BlEF4RLJBwkvo0NNlvos5NlcIS9ybtWE8NZAQnCBumENqsr/8fv1eURd7kYteC9enFgCcw0Nn6i TtxITtC9MNcupOAE79gIjN7aBNuWF7UxoIvlZOOMDRbYpWjBb3keWejXzF/0V8n7L8U/EXN2eT9
 aooRw5HORS+U3AQuOp0H9W0GL1CYNSuyTxKSAHr7ifV7v0LXbezGslfpnEW2IfUhNatpAqP8
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=685515bb cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=-z5qL46lnT9URsB4TOsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YZgDBRElDfIC98nXiJthncgAjN1mAjUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250620_010322_725645_AF70385C 
X-CRM114-Status: GOOD (  22.39  )
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

The blktests nvme/058 menifests an issue where the NVMe subsystem
kobject entry remains stale in sysfs, causing a failure during
subsequent NVMe module reloads[1]. Specifically, when attempting to
register a new NVMe subsystem, the driver encounters a kobejct name
collision because a stale kobject still exists. Though, please note
that nvme/058 doesn't report any failure and test case passes and
it's only during subsequent NVMe module reloads, the stale nvme sub-
system kobject entry in sysfs causes the observed symptom[1].

This issue stems from an imbalance in the get/put usage of the namespace
head (nshead) reference counter. The nshead holds a reference to the
associated NVMe subsystem. If the nshead reference is not properly
released, it prevents the cleanup of the subsystem's kobject, leaving
nvme subsystem stale entry behind in sysfs.

During the failre case, the last namespace path referencing a nshead
is removed, but the nshead reference was not released. This occurs
because the release logic currently only puts the nshead reference
when its state is LIVE. However, in configurations where ANA (Asymmetric
Namespace Access) is enabled, a namespace may be associated with an ANA
state that is neither optimized nor non-optimized. In this case, the
nshead may never transition to LIVE, and the corresponding nshead
reference is then never dropped. In fact nvme/058 associates some of
nvme namespaces to an inaccessible ANA state and with that nshead is
created but it's state is not transitioned to LIVE. So the current
logic would then causes nshead reference to be leaked for non-LIVE
states.

Another scenario, during namespace allocation, the driver first
allocates a nshead and then issues an Identify Namespace command. If
this command fails — which can happen in tests like nvme/058 that
rapidly enables and disables namespaces — we must release the reference
to the newly allocated nshead. However this reference release is
currently missing in the failure, causing a nshead reference leak.

To fix this, we now unconditionally release the nshead reference when
the last nvme path referencing to the nshead is removed, regardless of
the head’s state. Also during idnetify namespace failure case we now
properly release the nshead refernce. So this ensures proper cleanup
of the nshead, and consequently, the NVMe subsystem and its associated
kobject.

This change prevents stale kobject entries from lingering in sysfs and
eliminates the module reload failures observed just after running
nvme/058.

[1] https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/

Reported-by: yi.zhang@redhat.com
Closes: https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/
Fixes: 62188639ec16 ("nvme-multipath: introduce delayed removal of the multipath head node")
Tested-by: yi.zhang@redhat.com
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      | 7 ++++++-
 drivers/nvme/host/multipath.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92697f98c601..b3e280149a25 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4089,6 +4089,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	int node = ctrl->numa_node;
+	bool last_path = false;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -4181,9 +4182,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
+	if (list_empty(&ns->head->list)) {
 		list_del_init(&ns->head->entry);
+		last_path = true;
+	}
 	mutex_unlock(&ctrl->subsys->lock);
+	if (last_path)
+		nvme_put_ns_head(ns->head);
 	nvme_put_ns_head(ns->head);
  out_cleanup_disk:
 	put_disk(disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e040e467f9fa..5f52b50907a0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -690,8 +690,8 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		synchronize_srcu(&head->srcu);
 		del_gendisk(head->disk);
-		nvme_put_ns_head(head);
 	}
+	nvme_put_ns_head(head);
 }
 
 static void nvme_remove_head_work(struct work_struct *work)
-- 
2.49.0


