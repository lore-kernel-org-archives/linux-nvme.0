Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D921CC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KrCAlsfRbcabep8P5AcNC598DotxTa1w+cjgS/viezg=; b=ifDE5lvtTvMo+OvsJ4VVeFCOFI
	Nh4GCazN9QKi6hvzH+zleXJvKd0blevb5CwrV95HP8n+JNpuHRhPZz3TftFn7hWV9jHiuZWBrrnXl
	AdiEVqW0kSHW6r/vZzeeXDTUfUEcf3Nevay7LxUKYBfGod1hwvBpVweaIhDYL4diLtvSuMEztc2Zr
	VWl3evf6ZXpB+nrsjIWJWpyXERv5izQNm4E2Mj/+Glv5LQCe54MwwRB03kAcbvRt2ItSq9nb5fJEQ
	XTuYm3K9s6Env6RbJ1yeLNxg0wDSyYtXjifKAvD+l21nYuXh3JdN5Wcqa9avng3staQubwSmlUXBd
	bec/kRaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk72-0000000Chsh-2214;
	Mon, 06 Jul 2026 14:15:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk70-0000000Chq6-1pfe
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:15:55 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIOSD007695;
	Mon, 6 Jul 2026 14:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KrCAlsfRbcabep8P5
	AcNC598DotxTa1w+cjgS/viezg=; b=Bxjmv5c6FK7MOnrUnQTMi+TWDR8jh9hmc
	btTBE+1bRe6oDjZzFipJHvJGR+pWrh1CWdGbFxiQfQ3/IMSjLuCtCnpVAbZtJ0YJ
	j3DFKkTeHDEskx63ppRuYcAkfj7ZjMCriS6zfGRofY0lXR91qK1JMU98P8Ngm1qG
	vENpa7VGB+hhV8K1lTTfRL74GBfmR1DTXtRBaAxsoeta4Unbqn+31nxB89beGmpi
	YU67BZLFQuGgaq4Hvf1L7FYtUw4EgQPau4uTK+AH6ynxm+OkupNlHD6PZvvGZb95
	Jcgt5G9GN1czVsJbN2BBfceVz+C4MWyDeDF4A3jhqRl6GSLkrh2nw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3hupu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4cIW018959;
	Mon, 6 Jul 2026 14:15:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpx43b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFfIH51118362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 821F120043;
	Mon,  6 Jul 2026 14:15:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E34220040;
	Mon,  6 Jul 2026 14:15:39 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 04/18] nvme: add context annotations for nvme_ns_head::requeue_list
Date: Mon,  6 Jul 2026 19:44:06 +0530
Message-ID: <20260706141452.3008233-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4bb892 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=gCGRpEvQKZDurPVkv08A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX5nS1mLJZCEut
 iakQHijDPLXzG/694Vv7RjGr1/HvqzsetROmv9cuKCZvlQgTZ+6Au6vmMmP3LF2x6PhRqBrvC0Y
 nIpn07UrG61Lb9Hs0sKFLXw2RejAeFQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXyTzuUO9Hg8M8
 PLQH/j310Sks5N1mKmgY0tDTmUA5VIrDaMSB9vyjd/ZPfQd7dKVTT6DosxX41AF/aPEovvKCaJr
 CMECmIni7KJqDrNXwlsFdIPZe8sobrfVehzPKfXRbIarYt+fE+W5HPnGE8nh+i0fN7jjBahrBLh
 H+UDyko9wfSg85u5yVTLcATod92gtmhCXFGJ/B7YIBUd4H7cTBWz88E0KkAE2P2RjRcFW5V1mAZ
 24hq0Ey7mRmQA4GlEn9cNLn11VIbyWQiF6IkH7c3yBvNoucaBY/Ez4mEVtkIUxKRLGC29Q0lm1u
 c0t2galNujUGGrz4Jmiw/QMmLJQEWO5mnX3Nzlvti1Nblw5ezanMTAiBg80ENl6bNXHzEz8jryL
 UNlv7VZngrSdU5NunYXg3h5CFQUewBCWTfIopBCc+ib25F07k/iKs41nLXpgc96Bhxu/LfF3zQn
 wCYfFBvZmCjX3qPVQuw==
X-Proofpoint-ORIG-GUID: TSxR_Hd5IdhMMUmgUMXQBd138E660TAZ
X-Proofpoint-GUID: z2JIFkkt3WdDt9dZHCQtnsw_kObh7fTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071554_484805_62DC00EB 
X-CRM114-Status: GOOD (  15.00  )
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

nvme_ns_head::requeue_list is protected by
nvme_ns_head::requeue_lock. Annotate requeue_list with
__guarded_by(&requeue_lock) so that Clang's context analysis can
validate accesses to the list.

For zero-initialized objects, bio_list_init() is a no-op. Remove the
redundant initialization from nvme_mpath_alloc_disk(), which
initializes nvme_ns_head::requeue_list. Besides simplifying the code,
this also avoids a false positive from Clang's context analysis, which
would otherwise warn about accessing nvme_ns_head::requeue_list
without holding nvme_ns_head::requeue_lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 1 -
 drivers/nvme/host/nvme.h      | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e4ec5d5e2df1..67fd0752e894 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -732,7 +732,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	struct queue_limits lim;
 
 	mutex_init(&head->lock);
-	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b7c3ba9c0fc1..5e746ae1c805 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -561,7 +561,8 @@ struct nvme_ns_head {
 	u16			nr_plids;
 	u16			*plids;
 #ifdef CONFIG_NVME_MULTIPATH
-	struct bio_list		requeue_list;
+	struct bio_list		requeue_list
+		__guarded_by(&requeue_lock);
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
 	struct work_struct	partition_scan_work;
-- 
2.53.0


