Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4A9C5AD55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 23:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CqTUy+d20O3yqwfJsJb+KAJrUYH21+D2vZQRH2C/sVI=; b=PZ4OZ4/XWlJytk9Vu5dGcs6nJ1
	juza8gXCCGsuHcBUAl3MSaxq7BwfWhvrfJxWEG0fm5eVTQE3N8sJJ8C1Ex4Ggsxa/bU9UXfNEXPoa
	ZyGHpJumH1NHpUdL/B20HQk3ldgWEuMXe1t45+PsdES4Rifq2zCKBgeRbziUsqTuPsdYaY6XjZiTG
	tJpMhxiVbWYTW/HhC9Pe7xXPcmjJnyDeIOkpV7rxvKKJqpYLQaoP8O/19ph75bpxvJsxDdMolMX5t
	M0UAMG5Dp2XRNTZchzDPSGynJiqi+yUEIOCu16eR6gLyO1HwsGHzdC7g9kE3rBKZwn6RB3SFoZvWZ
	u6vbZv0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZm7-0000000D3Fd-2DwB;
	Mon, 10 Aug 2026 23:51:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZm4-0000000D3FI-380Z
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 23:51:21 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1VYZ2964889;
	Mon, 10 Aug 2026 23:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CqTUy+d20O3yqwfJsJb+KAJrUYH21+D2vZQRH2C/s
	VI=; b=bLo4mtYGXJqS1/+2XnMP/zKZ8ML6GMgzpHXyTQ7ZzRgs3vJNyzlm5eCrm
	BveMZZZPB8FOARN3pf+Ur5VPqGrRvWbU2SfTqh4cEsvjUdSciYtjJkVqEfJBqBQ/
	O5r1scOxRNi6owLPKKvegC8qFACt8WFye4ZDW8IeJ0rEXKCqF4otwZ6Te79wwen0
	tB6aAdWZ8YFv6zDHDxGaJJwSfT/VWDIpxuXqiuGHCmApxq08pHvUvEKyNKLkLEWK
	jARwoL8Zr2i7lhSvfoXkN5gOx6h3oZzE8/AoFA7zxGt8GCzfMwaTuITNZfMfVhM+
	fGeLC+a/QXSBLwSaNH5j+kUq+Rtlg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9jkne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 23:51:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ANfFwH023907;
	Mon, 10 Aug 2026 23:51:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gxt2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 23:51:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ANpELt3277648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 23:51:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61E0558059;
	Mon, 10 Aug 2026 23:51:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9CFD58058;
	Mon, 10 Aug 2026 23:51:13 +0000 (GMT)
Received: from ltcrain119-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 23:51:13 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: linux-nvme@lists.infradead.org, kbusch@kernel.org
Cc: gjoyce@linux.ibm.com, wenxiong@us.ibm.com,
        Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH] nvme: Add module reference counting for multipath nvme device
Date: Mon, 10 Aug 2026 19:50:34 -0400
Message-ID: <20260810235034.544797-1-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDIwMCBTYWx0ZWRfX8D6E6nYJm2MV
 uX2cweBL8ppENYFCqEYiCrQMVuaANyoLfH/Kv5YvHpP2we0cmZp03lNtYxCfmdhfOnQ8UrrTKGi
 xB30osyTk1gqMtycM8+lio9SVvwoa5BvgNU+M3w89za1mq2w4hyK0uZDa7QuklmG3CRf5etE9sa
 pOHAfZCzreChxBYPyLd5sWXXAuOPUtWjmevMC/hV1ytgiJ/aGa/r7VzjhgW6sC51QQ5YE9M5v5K
 E0pPLFj+InDt8Ru8QCdz/eUelKOgSpAEDqPtuQM9SjkQWL9ldmZmtpj8l+9StnVC6VqNL+hadPQ
 sFy51s06oHpYXXBSjMoXp6P7T4gJQNpj/A5Gi4Gjl5xH5FY7Ib4Cz8MHFdyrTdh03i6l6xvxpGi
 47B0SxPFysDY2TzbNqFwa+Jvq4lG4GLPIFxtRVc5se/RP4R5+Ib5wh8+pttlYHUIA74b6z9LmlL
 vkMhHhhhc22a5gt+YZQ==
X-Proofpoint-ORIG-GUID: AtA7zf8HiwBe8avptkGI4sQ5HWg2iH9V
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDIwMCBTYWx0ZWRfXwJrlZA402XTo
 LYNXZvJykoYRJjGu1aWaIKTBfVRUtgnPiZfjz08rmub/iPn2WPDKulKwEsTl7YBlMSqrKRO/oL/
 p88Xr6pUJzxNg6kSDrOVaajkXIdHKBs=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7a63f5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=1fbOtlSNfdWzmPJnIF4A:9
X-Proofpoint-GUID: AtA7zf8HiwBe8avptkGI4sQ5HWg2iH9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100200
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_165120_797582_31764215 
X-CRM114-Status: GOOD (  16.25  )
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

Ensure proper module reference counting for NVMe multipath head devices
on open, preventing the controller module from being unloaded while
the multipath head device is still open or in use.

This patch acquires a module reference in nvme_ns_head_open() and
releases it in nvme_ns_head_release()

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330..74c3710bf5f7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -554,14 +554,39 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 
 static int nvme_ns_head_open(struct gendisk *disk, blk_mode_t mode)
 {
-	if (!nvme_tryget_ns_head(disk->private_data))
+	struct nvme_ns_head *head = disk->private_data;
+	struct nvme_ns *ns;
+	int srcu_idx;
+
+	if (!nvme_tryget_ns_head(head))
 		return -ENXIO;
+
+	/* Get module reference from any available path */
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (ns && !try_module_get(ns->ctrl->ops->module)) {
+		srcu_read_unlock(&head->srcu, srcu_idx);
+		nvme_put_ns_head(head);
+		return -ENXIO;
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+
 	return 0;
 }
 
 static void nvme_ns_head_release(struct gendisk *disk)
 {
-	nvme_put_ns_head(disk->private_data);
+	struct nvme_ns_head *head = disk->private_data;
+	struct nvme_ns *ns;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (ns)
+		module_put(ns->ctrl->ops->module);
+	srcu_read_unlock(&head->srcu, srcu_idx);
+
+	nvme_put_ns_head(head);
 }
 
 static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
-- 
2.52.0


