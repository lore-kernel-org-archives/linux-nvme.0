Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CAEF36C5F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97+LQNkMTCiV7galmwtepC+58fHB+LsnfYeslR1Yp/w=; b=VNIugcNuNXkqrKiR6en9Me+4px
	YzIS8lUkk86M9/sHOFHS9Lcrio766ps4H6GWiI84alTEQHDpwxKfGhdqjwSvlqRWajvPgVZwSJW5A
	QTtF9RB+v4qdqRt3Jo+b3d64mZHxlBiS1saYbb8Lq5jUETVUn2E0/oeYdSb46c34+yZuYCWFZEPi+
	Rk6qmP9x/GPdMH/DR5bbvyXDkfWL3SZdE1QXwUob7jTjJm5P9jsseeksCiNEel+mVQ4NSKkj98yRe
	2AM6WtLlUd6zheEH79Q5nvU+cjsfaZHYL4zccsMLqloJL0RJwC5f+apxtkyqnK62As3yi3U82TiHi
	NQKzuYEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnG1-00000006pRe-0tc5;
	Mon, 20 Apr 2026 11:57:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnFy-00000006pQy-3sYM
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 11:57:40 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JLkMdJ3213038;
	Mon, 20 Apr 2026 11:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=97+LQNkMTCiV7galm
	wtepC+58fHB+LsnfYeslR1Yp/w=; b=j/JidbHm0Mt5oPhXphqR8ztIoeqEYo5tw
	s2oTrN56ApTTplt4IlKsaM7TSbhw9Fh2XaTVtOofaSK5EEjGwBJx6OnECPxTnDRV
	9UTkICwK2pEvuuiYSUSFfAl3mF+nVT0d8mGsdNUkbCz7iIh8vUwS2HbvtHPOsCZ1
	SRm43S9vKMEItNmD9Cuc9E52GxmCNpyjroktP8jlj5B30ZALZvL+Cg8iE5PTPd5+
	fzVXmawLPKRqnJe6CDlpAX/2vHRiyJEfvE9er+lofnUshCF7QEwYe1ZyQ2gba/KK
	EmcRTJb421KI6ot+x/S4WC3Co7vOsuHJk3oCdEFKnf2nhIdADBRBg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6fksm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KBoPxB017549;
	Mon, 20 Apr 2026 11:57:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyxvckf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KBvSxR46334270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 11:57:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAB512004E;
	Mon, 20 Apr 2026 11:57:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CF5A20049;
	Mon, 20 Apr 2026 11:57:26 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 11:57:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RFC PATCH 2/4] nvme-tcp: add a diagnostic message when NIC queues are underutilized
Date: Mon, 20 Apr 2026 17:19:34 +0530
Message-ID: <20260420115716.3071293-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420115716.3071293-1-nilay@linux.ibm.com>
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExNSBTYWx0ZWRfXwasw3PPlVC7s
 XaI40+hGxbaUmdwovW+Mb6Xctg/Dw5C24XAnJJxYjvzfMYIUw0KQiGgCj/KJJlnOLGoCpuJnWFN
 P3R06BCdS8G4QKx0MRauUjbsWFiBUqi82IWzWIyL7W3UtdDCY0suOSWPsFPLXyqSAgvtL+2EvHm
 B5I538az5qBHxFKgV79EHB9zp6km2bk+VWhhO6VXrx1dz5S+Et0Ix7LyGbmdLAiOGDiIB8ymHoR
 tMzuCSp04hg1zNiLQdi+aGAIQgZ+3z1j/h2Nwx3yERxld2SgW+ySBwhF/Je/yqjBs51UHHlIjuX
 zl1OPYmtWOa5UxsBVl/LlntA9JHPWxfKimvvjFW9F+DHCLIZFz88Kl6vOukGRu2D3GyqeClHnZi
 FDPrcLwfeHxNG8wnDKknqz0Jd5kCB60Whk5tWgj0J7KQP/AYbbROFZq/Z6VVtW9LT7LyFx3HEIz
 DY3i9G5Qbi/SHufFBtA==
X-Proofpoint-GUID: SzRYGYHNQfM-xZnzcqkslM22PsDQ-q6T
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e614ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=XrrK4mm4PIy5CEp57zEA:9
X-Proofpoint-ORIG-GUID: SzRYGYHNQfM-xZnzcqkslM22PsDQ-q6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_045739_015139_474D842A 
X-CRM114-Status: GOOD (  18.71  )
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

Some systems may configure fewer NIC queues than supported by the
hardware. When the number of NVMe-TCP I/O queues is limited by the
number of active NIC queues, this can result in suboptimal performance.

Add a diagnostic message to warn when the configured NIC queue count
is lower than the maximum supported queue count, as reported by the
driver. This may help users identify configurations where increasing
the NIC queue count could improve performance.

This change is informational only and does not modify NIC configuration.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 45 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7102a7a54d78..9239495122fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -11,6 +11,7 @@
 #include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
+#include <linux/ethtool.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
@@ -20,6 +21,7 @@
 #include <linux/in6.h>
 #include <linux/blk-mq.h>
 #include <net/busy_poll.h>
+#include <net/netdev_lock.h>
 #include <trace/events/sock.h>
 
 #include "nvme.h"
@@ -1861,6 +1863,35 @@ static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
 	return min(tx_queues, rx_queues);
 }
 
+static int nvme_tcp_get_netdev_max_queue_count(struct nvme_ctrl *ctrl)
+{
+	struct net_device *dev;
+	struct ethtool_channels channels = {0};
+	int max = 0;
+
+	dev = nvme_tcp_get_netdev(ctrl);
+	if (!dev)
+		return 0;
+
+	rtnl_lock();
+	if (!dev->ethtool_ops || !dev->ethtool_ops->get_channels)
+		goto out;
+
+	netdev_lock_ops(dev);
+
+	dev->ethtool_ops->get_channels(dev, &channels);
+	if (channels.max_combined)
+		max = channels.max_combined;
+	else
+		max = min(channels.max_rx, channels.max_tx);
+
+	netdev_unlock_ops(dev);
+out:
+	rtnl_unlock();
+
+	return max;
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -2245,19 +2276,27 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 
 	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES) &&
 			(ctrl->opts->mask & NVMF_OPT_MATCH_HW_QUEUES)) {
-		int nr_hw_queues;
+		int nr_hw_queues, max_hw_queues;
 
 		nr_hw_queues = nvme_tcp_get_netdev_current_queue_count(ctrl);
 		if (nr_hw_queues <= 0)
 			goto init_queue;
 
 		ctrl->opts->nr_io_queues = min(nr_hw_queues, num_online_cpus());
-
-		if (ctrl->opts->nr_io_queues < num_online_cpus())
+		if (ctrl->opts->nr_io_queues < num_online_cpus()) {
 			dev_info(ctrl->device,
 				"limiting I/O queues to %u (NIC queues %d, CPUs %u)\n",
 				ctrl->opts->nr_io_queues, nr_hw_queues,
 				num_online_cpus());
+
+			max_hw_queues =
+				nvme_tcp_get_netdev_max_queue_count(ctrl);
+			if (max_hw_queues > nr_hw_queues)
+				dev_info(ctrl->device,
+					"NIC supports %u queues but only %u are configured; "
+					"consider increasing queue count for better perfromance\n",
+					max_hw_queues, nr_hw_queues);
+		}
 	}
 
 init_queue:
-- 
2.53.0


