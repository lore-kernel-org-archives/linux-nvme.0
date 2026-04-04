Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA39E88D97
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v+2yxWw2XKwwUc5PP0FC6xoCAzGFi5xQNPOs0AlwvKo=; b=ismt44Zr3WmDUNrNpjJ2WWJMa2
	y1b3MNbvstR7D9+wMIDCIMVkchaXZ6w98xqwTCh0oMHjgPDFIszpoC6jYH3LLBwS7JNUcxCztqMS7
	unPi03QeZSZWT+TQB0GFgNEAUfW9Mq1ytuDKKggdls0im/CEXxfjn3yXqA5evf3YE3Ar93modS/+R
	P7xudjMY3YMJwkEMC4eS50YqRi+04QdrmvoVRNu1oyf8995yzUiCADCDMSKitiKr+wYfcM4G8Aveo
	1APopIv/ef9SKsZ+KuCh3cf35AMwTEwNBnm7h4ukT26SjP+T2G3wq+0OZMXW9F34F4ZIJoGFzk0+1
	oA2LwISQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2a-00000003MRd-3hA8;
	Sat, 04 Apr 2026 10:15:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2Y-00000003MOt-2cPC
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:15:43 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6348bdsR3701323;
	Sat, 4 Apr 2026 10:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v+2yxWw2XKwwUc5PP
	0FC6xoCAzGFi5xQNPOs0AlwvKo=; b=iKArkVdx2y/YY8qmQ13R0jrvj0e8aIHyk
	0NypxpqyDRTkhK2Ti8qTBiK/zL5Ic2t4ebMoWMVmWoc66F0BTeOP3K5ortd1ei4c
	n/OJ/4GYTqjPiG/g0/1dRnzQOjVdb2JxVgZo9GSThmvfJdgImUsSKxqL5/Udbqt0
	Ay/pRbGorjtM+8XVEV6XtFlclVnkKG6kvFBscNZtz8/jTOE+LKo5ICD2bZQkDqCq
	J3tzMofLyJQB9LDbRLR47vlXBtZwnCtFX7DgAv429ZZeyEX+e2KQn1elNwAD5b1F
	8EQBZgS3xs+//k7eyYbiobTIxSH4m+PWCVO7eZw3g1xuRMyDGO8gw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datap0qg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 634755nI021709;
	Sat, 4 Apr 2026 10:15:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sat19n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFaQB22216966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F17D42004E;
	Sat,  4 Apr 2026 10:15:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2AD62004F;
	Sat,  4 Apr 2026 10:15:33 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 6/9] libnvme: add support for per-path diagnostic counters
Date: Sat,  4 Apr 2026 15:44:56 +0530
Message-ID: <20260404101504.44539-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Bp+QAIX5 c=1 sm=1 tr=0 ts=69d0e4cc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=NKCsueVTR_sD4m4h2I0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfX540X4812K21D
 1OtAO3wl+LLE06h27V7vG9AI5NVtcAJCb9AdjkY9gaoHrK3OFD6GquV9MaTJlwN3LXD2Yc0UQYa
 ju7dApxm5IP895vCUZWeRp3ck7WM3fPbyrZ4zT9oBrfpiGuHBNm46bfdE2T0yO/gJcwG2Tx32Wj
 vgUa3BHGl8vRxIXDxJKnILPyaSOJkVjErZBcCN6q/q4CD443rOsbKOx9MQx9SN3eSWOf5pXbBrl
 mwucTgurXIsHLM4TwmAQQE1VErYHU6y8A+Dk4eqcw8D7kyNrr1fFgBh6A9Y52gJrD4UEbFswlB4
 Y5/tixQh3JhyOolVYbvqElwzaFdqK/nu1xoJLfyUF7TenYVeIMfaN2rUTda64nWyTGpBKJnGH3E
 XIEl0AK9cnwUBxwZTRjpqjrhINGQol1oBMAeoVp5j+/GJ0GECymldwf/6fCZtFLFu2Vz6xAr9wq
 7asA5S9TFOBzCfxq6/A==
X-Proofpoint-GUID: bXFppP0A1USG-nQi9knGotTo9aPAZD8m
X-Proofpoint-ORIG-GUID: bXFppP0A1USG-nQi9knGotTo9aPAZD8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031542_677614_0B530496 
X-CRM114-Status: GOOD (  15.30  )
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

Add support for retrieving per-path diagnostic counters such as
command_retry_count, command_error_count, and multipath_failover_count.
These counters improve visibility into NVMe native multipath behavior
and can be useful for tools such as nvme-top to display real-time
statistics.

Unlike other sysfs attributes, these counters can change dynamically.
Annotate them with "!accessors:none" and provide custom implementations
to always retrieve the latest (non-cached) values.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/libnvme.ld     |  3 +++
 libnvme/src/nvme/private.h |  3 +++
 libnvme/src/nvme/tree.c    | 33 +++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    | 27 +++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index c32198324..a10629dce 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -167,6 +167,9 @@ LIBNVME_3 {
 		nvme_path_get_write_sectors;
 		nvme_path_reset_stat;
 		nvme_path_update_stat;
+		nvme_path_get_command_retry_count;
+		nvme_path_get_command_error_count;
+		nvme_path_get_multipath_failover_count;
 		nvme_random_uuid;
 		nvme_read_config;
 		nvme_read_hostid;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index f09c0d83f..3d7dfb3c4 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -170,6 +170,9 @@ struct nvme_path { /*!generate-accessors*/
 	char *numa_nodes; //!accessors:none
 	int grpid;
 	int queue_depth; //!accessors:none
+	long multipath_failover_count; //!accessors:none
+	long command_retry_count; //!accessors:none
+	long command_error_count; //!accessors:none
 };
 
 struct nvme_ns_head {
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 2949b5cf8..844e18b5c 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -852,6 +852,39 @@ __public char *nvme_path_get_numa_nodes(nvme_path_t p)
 	return p->numa_nodes;
 }
 
+__public long nvme_path_get_multipath_failover_count(nvme_path_t p)
+{
+	_cleanup_free_ char *failover_count = NULL;
+
+	failover_count = nvme_get_path_attr(p, "multipath_failover_count");
+	if (failover_count)
+		sscanf(failover_count, "%ld", &p->multipath_failover_count);
+
+	return p->multipath_failover_count;
+}
+
+__public long nvme_path_get_command_retry_count(nvme_path_t p)
+{
+	_cleanup_free_ char *retry_count = NULL;
+
+	retry_count = nvme_get_path_attr(p, "command_retry_count");
+	if (retry_count)
+		sscanf(retry_count, "%ld", &p->command_retry_count);
+
+	return p->command_retry_count;
+}
+
+__public long nvme_path_get_command_error_count(nvme_path_t p)
+{
+	_cleanup_free_ char *error_count = NULL;
+
+	error_count = nvme_get_path_attr(p, "command_error_count");
+	if (error_count)
+		sscanf(error_count, "%ld", &p->command_error_count);
+
+	return p->command_error_count;
+}
+
 static nvme_stat_t nvme_path_get_stat(nvme_path_t p, unsigned int idx)
 {
 	if (idx > 1)
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 01f7fda86..4b5d3fd70 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -704,6 +704,33 @@ char *nvme_path_get_ana_state(nvme_path_t p);
  */
 char *nvme_path_get_numa_nodes(nvme_path_t p);
 
+/**
+ * nvme_path_get_multipath_failover_count() - Get multipath failover count
+ * @p: &nvme_path_t object
+ *
+ * Return: Number of times I/Os have to be failed over to another active path
+ * from path @p maybe due to any transient error observed on path @p
+ */
+long nvme_path_get_multipath_failover_count(nvme_path_t p);
+
+/**
+ * nvme_path_get_command_retry_count() - Get command retry count
+ * @p: &nvme_path_t object
+ *
+ * Return: Number of times any command issued to the namespace represented by
+ * path @p has to be retried
+ */
+long nvme_path_get_command_retry_count(nvme_path_t p);
+
+/**
+ * nvme_path_get_command_error_count() - Get command error count
+ * @p: &nvme_path_t object
+ *
+ * Return: Number of times command issued to the namespace represented by path
+ * @p returns non-zero status or error
+ */
+long nvme_path_get_command_error_count(nvme_path_t p);
+
 /**
  * nvme_path_get_ctrl() - Parent controller of an nvme_path_t object
  * @p:	&nvme_path_t object
-- 
2.53.0


