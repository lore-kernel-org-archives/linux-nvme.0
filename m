Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADF6E88D66
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EhEQb+BqaaDvCox7Zc8d0AHuD8UYxNe5ok0PRm78sGo=; b=zHiLBdKjwXtYBbpyIhVnh1HY1O
	LFjvzRhgcri9E3coGV2QwnRkgD4MEgYnXYS1TFHAr2GLr3jYbTNntZ6R22/qU46SHPayUAbAI92Yi
	TQrRKEJ6mgPorcaIheAJOXcZ1bIfiMI3z+qBz7RjPu6sX4kPRsxZO+aiTysqBk6wig+2TZYpItlu4
	D+1zoBQmoYAiJTwSoStKhql25A+iRsaiE9qd9GDSvLYiBXi0yQp4Xi41+zNaeLKzfjjXelHtbfrG+
	xU3pDkbOsvnZSpeo4xMz1cZ1151tGG0BtQrPVx/DSewNu9wjMju3GuOy/xvSWUDuShp7oY+PIU2FS
	zvjt145w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2s-00000003MfC-38aC;
	Sat, 04 Apr 2026 10:16:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2p-00000003Mcp-2Dfg
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:16:00 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6347j4gG3593493;
	Sat, 4 Apr 2026 10:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EhEQb+BqaaDvCox7Z
	c8d0AHuD8UYxNe5ok0PRm78sGo=; b=pp4ewgRQytfyOCLtCqFwSngyqRRzKIOer
	M1yR5lhEEKmAMkAlYTn0K7WoY8N/WkYiUO0hemOaXZ13MQn4u5661DwX4yGnMs6G
	mxY8i1vw9/ihE7Oj+gVuV+vcN7sTjZFu/TiXHxk8kVilYV5n8ySikzW7t/JmwmJc
	BjClwfms+6X/Ogu+rsoOXX1JoBfbBw8nPnDvYdPKdCkwEcFN3+hK1SHAEeF5i3iL
	e17Byi2jFJqnXyWlGj+8oYzrOInUvuFFNw6UKpgZH7knlZvkPT3ejxUv0v+zxuAI
	tdOr1Pduriueak3Fa10lZdh1FNuQycHm8u+K9Zmx0asOCHwdPbTMQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2gqhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6348VBDW022165;
	Sat, 4 Apr 2026 10:15:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tanh3r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFp5N46793140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B86A92005A;
	Sat,  4 Apr 2026 10:15:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 379502004E;
	Sat,  4 Apr 2026 10:15:48 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:46 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 9/9] libnvme: add support for ctrl diagnostic counters
Date: Sat,  4 Apr 2026 15:44:59 +0530
Message-ID: <20260404101504.44539-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfXwRNS8FdReT7m
 C+73q0zHnwVeKwG5qofTQGqBfWVZpWMnLvL6hPsQTjrzA2Hc1MTKG54W+bjQfj7jZQC/w4Yq6j9
 XhrkgT/VGjpMrao/6rVFoTLLCocTnUFnfZAYy/QF/DcO2H9EvHG8mGHoNMC4L8ZKzqzXdNZEHz8
 GUjvLGxIWm4wtn0G9GX2+3J27OyY8aIaFxH/k3HcLn0kv/0Id2zh5DYlFPw1v9gMiN0VDduxwt4
 0bo7WxNBLEVveBFIVBL1uUk7MnfYGkBKqrY0+hEWJ9Zh2XqD7Gf+GYciYFtt8jJuKjY59YfW/e3
 sfhPLC32stBJfGRykbbCnmpB78Qmj5FkCtFIrRxajz42VIE1HIe9CNac1uah492DSocxAbizmmg
 xxKVXf+BZhJ4vBdIRqbsNfBaqM9P1t18uTus6N9yZWZzIejSROVy6RjWJD3jMFXaYgCOoT30H/K
 lqEiSAhTjGQscNjusKA==
X-Proofpoint-GUID: JvVJTdHHJnhyhHtwO_8eT6nipAqj0OoF
X-Proofpoint-ORIG-GUID: JvVJTdHHJnhyhHtwO_8eT6nipAqj0OoF
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d0e4dd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=UWddX7ZrEUmAjO3ds3UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031559_570432_20A38F0C 
X-CRM114-Status: GOOD (  14.31  )
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

Add support for retrieving ctrl diagnostic counters such as command_
error_count, reset_count and reconnect_count. These counters improve
visibility and can be useful for tools such as nvme-top to display
real-time statistics.

Unlike other sysfs attributes, these counters can change dynamically.
Annotate them with "!accessors:none" and provide custom implementations
to always retrieve the latest (non-cached) values.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/libnvme.ld     |  3 +++
 libnvme/src/nvme/private.h |  3 +++
 libnvme/src/nvme/tree.c    | 33 +++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    | 25 +++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 13bd3995c..52611f38b 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -16,6 +16,9 @@ LIBNVME_3 {
 		nvme_ctrl_get_subsysnqn;
 		nvme_ctrl_get_subsystem;
 		nvme_ctrl_get_transport_handle;
+		nvme_ctrl_get_command_error_count;
+		nvme_ctrl_get_reset_count;
+		nvme_ctrl_get_reconnect_count;
 		nvme_ctrl_identify;
 		nvme_ctrl_match_config;
 		nvme_ctrl_next_ns;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index ae0b8507e..2009ac3c0 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -255,6 +255,9 @@ struct nvme_ctrl { /*!generate-accessors*/
 	bool unique_discovery_ctrl;
 	bool discovered;
 	bool persistent;
+	long command_error_count; //!accessors:none
+	long reset_count; //!accessors:none
+	long reconnect_count; //!accessors:none
 	struct nvme_fabrics_config cfg;
 };
 
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 77aed7eee..210952785 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -1414,6 +1414,39 @@ __public const char *nvme_ctrl_get_state(nvme_ctrl_t c)
 	return c->state;
 }
 
+__public long nvme_ctrl_get_command_error_count(nvme_ctrl_t c)
+{
+	_cleanup_free_ char *error_count = NULL;
+
+	error_count = nvme_get_ctrl_attr(c, "command_error_count");
+	if (error_count)
+		sscanf(error_count, "%ld", &c->command_error_count);
+
+	return c->command_error_count;
+}
+
+__public long nvme_ctrl_get_reset_count(nvme_ctrl_t c)
+{
+	_cleanup_free_ char *reset_count = NULL;
+
+	reset_count = nvme_get_ctrl_attr(c, "reset_count");
+	if (reset_count)
+		sscanf(reset_count, "%ld", &c->reset_count);
+
+	return c->reset_count;
+}
+
+__public long nvme_ctrl_get_reconnect_count(nvme_ctrl_t c)
+{
+	_cleanup_free_ char *reconnect_count = NULL;
+
+	reconnect_count = nvme_get_ctrl_attr(c, "reconnect_count");
+	if (reconnect_count)
+		sscanf(reconnect_count, "%ld", &c->reconnect_count);
+
+	return c->reconnect_count;
+}
+
 __public struct nvme_fabrics_config *nvme_ctrl_get_config(nvme_ctrl_t c)
 {
 	return &c->cfg;
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index e6a26efb1..3a86208ef 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -1030,6 +1030,31 @@ unsigned long long nvme_ns_get_write_sectors(nvme_ns_t n);
  */
 struct nvme_fabrics_config *nvme_ctrl_get_config(nvme_ctrl_t c);
 
+/**
+ * nvme_ctrl_get_command_error_count() - Get admin command error count
+ * @c: Controller instance
+ *
+ * Return: Number of times admin command issued to controller @c failed or
+ * returned error status
+ */
+long nvme_ctrl_get_command_error_count(nvme_ctrl_t c);
+
+/**
+ * nvme_ctrl_get_reset_count() - Get controller reset count
+ * @c: Controller instance
+ *
+ * Return: Number of timer controller @c is reset
+ */
+long nvme_ctrl_get_reset_count(nvme_ctrl_t c);
+
+/**
+ * nvme_ctrl_get_reconnect_count() - Get controller reconnect count
+ * @c: Controller instance
+ *
+ * Return: Number of times controller has to reconnect to the target
+ */
+long nvme_ctrl_get_reconnect_count(nvme_ctrl_t c);
+
 /**
  * nvme_ctrl_identify() - Issues an 'identify controller' command
  * @c:	Controller instance
-- 
2.53.0


