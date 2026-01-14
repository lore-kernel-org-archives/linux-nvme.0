Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D25D31A16
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jan 2026 07:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3EsM6fsCuyZR7jfkZK39hL3LKS0Wd+eeqbJN8ThtLnE=; b=L97Im6P4nlAPkZJh2SfX4nTMTc
	V50+Stj+fTYoXGjUXX0F4tQHyO9qQanafuixYJNqNUXO17sXST0ydRZc/l3tqW+A0m/726YVbCmhf
	SgcXHKds6GzEwLqo+CAQW6QaR28/EDWg7pwkhM10IiLj5GfZN5Aaho/TxqhRJywjyp3pdV7AnErSb
	PFA+4UDIJWBhyJw6nUDO0hs1X59cjzoG8Zxbn5GXnH+KMmRGel+LupueuzxWGyxFIWnEtcx4BE1Rx
	t9JIPI2wXRJsxk2FaPX+pfE4FbcTKbQ0hE/Jr+7vSOhzn7rHbnCMgEnP27R79BKW0Z7ZvxKPmqKqG
	AnnJ2oLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvFL-00000008Bk1-1AzK;
	Wed, 14 Jan 2026 07:24:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvFJ-00000008Bi6-1fUx
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jan 2026 07:24:50 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E7NUgj032261;
	Wed, 14 Jan 2026 07:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=3EsM6fsCuyZR7jfkZK39hL3LKS0W
	d+eeqbJN8ThtLnE=; b=lQhFQJgLkeVQ70kUeoMB/3Q18qzKhrLnflCty7Gr0RlC
	tKj08ctOSSMcRwPwwXcBVW346NbnOT+Ng7JO7kHHPOIgFLolpKaH793lyjSILBiY
	3CbP+Ky2GUPij6A0TJ7vFITuRZYcns10BLxH0Vqkz9rPxO4QAK77oCgi07PWtXvh
	Q8dpu+1tZKvGPXF6LIgCOUtHkuVqIKiIbQCl57a8VJkrNffAHtwsB2J3s+eTU3JB
	Pm9yzLmNdxfcFM5rpz1SUE7+1DWnugQJDnFOcwnkEMZTBpkI9YhdXtvow5BB7L+W
	U6gFMEptkqS0XiFiWMCyhfRroQNXefd4S8CNa7GEMg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsyt3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:24:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60E6QtWZ002511;
	Wed, 14 Jan 2026 07:24:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13srxqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:24:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60E7OTto56492436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 07:24:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 262B720043;
	Wed, 14 Jan 2026 07:24:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 543F920040;
	Wed, 14 Jan 2026 07:24:23 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.133.154])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 07:24:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: jmeneghi@redhat.com, wagi@kernel.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com, hare@suse.de,
        shinichiro.kawasaki@wdc.com, wenxiong@linux.ibm.com,
        nnmlinux@linux.ibm.com, emilne@redhat.com, mlombard@redhat.com,
        gjoyce@ibm.com, Nilay Shroff <nilay@linux.ibm.com>,
        stable@vger.kernel.org
Subject: [PATCH] nvme: fix PCIe subsystem reset controller state transition
Date: Wed, 14 Jan 2026 12:54:13 +0530
Message-ID: <20260114072416.1901394-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA1NiBTYWx0ZWRfXwLfjDh4qtMp9
 NdImLvS9dI4wYvjFiRrQ64PcDDRdwIbI2gkr16j+u9cyiyKXT6RXGJqTE7y8I/WXM4ztxte7Xp1
 vy3/2wzybq4u89FxImnQfvQRspaUIjy87A3tb4l/m1bWeR2I5hxNPzW7HVwZoWw+nCsSN/6wC90
 W3iRgbQzC3WT5LReiXUKUxR8ufGvGD9s1geSjIQX0v+HfkC3NZ+be/LhTFu6pkUdWhxyPa2j8tx
 +2YEMrRElzEXPKl7yjmX+H9ONy30PA1BSozahhtwD7AHnQzUEXRQ+MwsRSpoLKHqGK8yktca1qb
 ivcm3FP/Sbr3L21VS018ZvZkKVCzj8ha/w/RCTYoUDxKYwNZNO8yi7yMt4G7kkX/CfjjTii4fL/
 swmPc2NAAX1QGEjMSsDIQooLX9g29bXeV0IhHOWQdQLcxdzgE3r7s2tahp4tL2JIqOulbbyZOPd
 DCXJIQaDXkhS4jc1G/A==
X-Proofpoint-GUID: gW0OW5-_sg8mLAJKpRtZuVXmQOrGgZHC
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=696744b2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=bihmBxQwaCVq7hZI4EMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gW0OW5-_sg8mLAJKpRtZuVXmQOrGgZHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_232449_559763_AD14F152 
X-CRM114-Status: GOOD (  16.78  )
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

The commit d2fe192348f9 (“nvme: only allow entering LIVE from CONNECTING
state”) disallows controller state transitions directly from RESETTING
to LIVE. However, the NVMe PCIe subsystem reset path relies on this
transition to recover the controller on PowerPC (PPC) systems.

On PPC systems, issuing a subsystem reset causes a temporary loss of
communication with the NVMe adapter. A subsequent PCIe MMIO read then
triggers EEH recovery, which restores the PCIe link and brings the
controller back online. For EEH recovery to proceed correctly, the
controller must transition back to the LIVE state.

Due to the changes introduced by commit d2fe192348f9 (“nvme: only allow
entering LIVE from CONNECTING state”), the controller can no longer
transition directly from RESETTING to LIVE. As a result, EEH recovery
exits prematurely, leaving the controller stuck in the RESETTING state.

Fix this by explicitly transitioning the controller state from RESETTING
to CONNECTING and then to LIVE. This satisfies the updated state
transition rules and allows the controller to be successfully recovered
on PPC systems following a PCIe subsystem reset.

Cc: stable@vger.kernel.org
Fixes: d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING state")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0e4caeab739c..3027bba232de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1532,7 +1532,10 @@ static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
 	}
 
 	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
-	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+		goto unlock;
 
 	/*
 	 * Read controller status to flush the previous write and trigger a
-- 
2.52.0


