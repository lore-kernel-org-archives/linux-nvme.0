Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DF7C5DF65
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 22:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MPGpDS1bHpdIKp3uqg2yXO5NzAiTHIWo/GBb0pYqBx0=; b=P/Qo0eLxjmGILPH7EiMXoxi7mM
	d35zQ0/cTPZVKA2QKBit6SgSIJfY9Ah1F8D2fPnb270CIUkNCSH4RCEgazvr5kPmauyAlKUFLQjRG
	gf8yrtuOaojE2JrAhwNZOwZv8CrAY3WDY/lruW6IKMlg88OwcC5Zo3EMbZQO0f559QFJF+xv1o1/4
	/WxmSQD7Iaj1T/TvbtVesrKfsZjvboDhmJ/x1cBl/YhXFRtOmTG0PoKPpUI/JqKsxG/lv99Um+GCF
	34IFrBHpwIOykCqfJjRZgoWIxRUw5e5ErT4N29QOT3MEw+gYczuUymls9Uh+mHKg6UTrVZadj3OOg
	yn4WI3Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuHVD-0000000H5oV-3qlE;
	Wed, 12 Aug 2026 22:32:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuHVB-0000000H5ny-3Eno
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 22:32:50 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2elF291763;
	Wed, 12 Aug 2026 22:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MPGpDS1bHpdIKp3uqg2yXO5NzAiTHIWo/GBb0pYqB
	x0=; b=PXsSaRFDZGyjlYTZPZoTg/LYaBZfIeYSyWQJGJttS0ti90wWEr1eRasXG
	xeHJnZ7UENtJBwTLPkvh5uEWffDHCqqysTFBSZSyxs8CTu6q3bODTmESY6iL3mm9
	Q1JFM12mP61zlcTourD9S8fHmyknLG1xU9G6059XL+PZ5XKzaQSGktYoqL2TXucF
	kU4enn5+wZAi2MVAo1RRfAeLy9mTjJEUw6+qiFMNPEhYIlrbtNOMjO62uXcsEpGp
	WLymEQoV7HOJd7XjtUFZ7VQaZFySYdDMgSJT4cZDMFWX6050EQ88wSljVzANRweM
	mFi75ONHVWqLvO0jx/ZvhXJYY4qFg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9w50y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:32:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMQGUF026563;
	Wed, 12 Aug 2026 22:32:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq8hx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:32:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMWiEE1966782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:32:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6A7658056;
	Wed, 12 Aug 2026 22:32:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94B8258052;
	Wed, 12 Aug 2026 22:32:43 +0000 (GMT)
Received: from ltcrain119-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:32:43 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: linux-nvme@lists.infradead.org, kbusch@kernel.org
Cc: gjoyce@linux.ibm.com, wenxiong@us.ibm.com,
        Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2] nvme: Add module reference counting for multipath devices
Date: Wed, 12 Aug 2026 18:32:06 -0400
Message-ID: <20260812223206.720363-1-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE4MiBTYWx0ZWRfXx7qtGUdFYnvw
 NVUJlBF5cs4BHjPoF+yUhyEBTTkvq35fQ5vQfHS/hxrOYyhVyWRv7V6+4XLKfpW6KpaLpcdeQZz
 a0mUClh59EWX4uOOC/v1hARZfrZJT/5I03ed2gK3+L49ayeG0HK3dlAKSxMk556XU8qa0rR9Lm/
 27aYGTvLrqe6F31DNccuubjIoBihkHomUagbymcczLFiyw8YvuQGLhI/g2N+Da1mVYpvcjYRcRm
 cT1j1GGDUaVLlYLIhWjeyPZ1OTO3ar6bJQqmDOkY+eb3LwNUAxUgqyQXeLf9+mv2p+FjJj/i/sO
 owuZ2KPBp0s9a0WeqDah3Ae2nukXdircLi2xShpaCYpkd2HoWeXHYZVhLJ2piyLTs0VGazzcdEb
 JiddBPxEpCJP30crZ66V+Tpmo1P0PS8m9yjlLSKb8cZwS9s4eXJC6vJxlA0SctSZSr1aCoLUf0T
 YYyH4GQ1tE1+qUjkjFg==
X-Proofpoint-ORIG-GUID: Flx7-TPQKtIEnonK43VtmzdMdjLD1HYa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE4MiBTYWx0ZWRfX5ibe7UHJvDYE
 ltZ91c21d8BngEJyF4ghtbj87m4MTsRwY1M8amICDfKbeFSgWKytKRAtvFdB4pbCldszJJ4JoS0
 qneCOB4QcEhdp1MUc0TT5rGPhilAQN4=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7cf48f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=vqZyQLm1gNXVToo2ePIA:9
X-Proofpoint-GUID: Flx7-TPQKtIEnonK43VtmzdMdjLD1HYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120182
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_153249_838909_FB761957 
X-CRM114-Status: GOOD (  13.52  )
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

From: Wen Xiong <wenxiong@linux.ibm.com>

Add proper module reference counting to prevent premature unloading of
NVMe transport modules while multipath namespaces are still active.

When a namespace is added to a multipath device via nvme_mpath_add_disk(),
the underlying transport module (PCIe, FC, RDMA, TCP, etc.) must remain
loaded as long as the multipath device references that namespace. Without
proper reference counting, the transport module could be unloaded while
the multipath device is still using resources from that module, leading
to the potential system crashes.

This ensures the transport module remains loaded for the entire lifetime
of the multipath namespace association.

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330..707b8f95727d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1348,6 +1348,8 @@ void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns)
 	sysfs_remove_link_from_group(kobj, nvme_ns_mpath_attr_group.name,
 			dev_name(target));
 	clear_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
+
+	module_put(ns->ctrl->ops->module);
 }
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
@@ -1379,6 +1381,9 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
 		ns->head->disk->nr_zones = ns->disk->nr_zones;
 #endif
+	if (!try_module_get(ns->ctrl->ops->module))
+		dev_err(disk_to_dev(ns->disk),
+				"Failed to get module reference\n");
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-- 
2.52.0


