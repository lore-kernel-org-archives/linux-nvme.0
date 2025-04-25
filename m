Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340E3C369D7
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IptuEpOqY2rkRSVrpSL+ohAr8/s7SZ0DjnTM7IdU7tA=; b=vJJomiV8HEEPfu/cFlV/ovUA1/
	N5MtWl0UEpKQ42a1mf8sW1xcg/N2XXR/HS/zn0Sl7KPl+eJCTGMA0IWa6nOHalUc6eQgf9LsOyWgZ
	b+9AQD8gZ0yGKr/z3EN59m3blnZHlrqRlgLRPZm60fWZS4GTE9UYBmg9M3eqDrUZPXuGyMsPqcBA1
	hmSak2aBUGjigO/Z6c839OHV6LQMlWcAFV1Hm7Ju7tQgr5DHEhn4SZeY0CtaL1V31lWYy9IuYpePE
	+KwTZYFo7rt8pdWgPR8AORjyhI5PCZAY33hw13u02q7Vrm8oTMkJrFSY9ANNq0iYoyysAMJpZEb8v
	D3ObvPtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ODz-00000000Zn9-1nIP;
	Fri, 25 Apr 2025 18:56:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ODw-00000000Zlh-2h51
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 18:56:33 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9PbID006508;
	Fri, 25 Apr 2025 18:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IptuEpOqY2rkRSVrp
	SL+ohAr8/s7SZ0DjnTM7IdU7tA=; b=WCcGXLN77YcsU5XytPM9qB/zFvUDMgw+l
	eGTQ/hDxu3JgLpLnbL6pTxMwGqDwx6d5Di+pP9hqHkiqSNDyfF+XfPjt8Ho125/1
	mvMrdcZQs+5yi17nJxHyAR/YlAUj4HypTXfDFeP7MANCGOT2fDjO8Xlukei8qRX0
	a38I0wE16D4HHX5Jv+w4gSnG0scqx5jg9FDhnXobKOKuQnS6Y0F/kPB7Mh6AzQv0
	DLCkyv4w69ITC2QH/P09zB/K+ckcLVZDucWphLCM+Wn2J0Il+IlOs+31Tpvl4IpD
	/16d+bYOQLTgMH0XfOLesvxF91rFLyeJb36JhMG7yYqqfyGEoyvUA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9n37p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGOhUh008792;
	Fri, 25 Apr 2025 18:56:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxxqgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PIuRl451052808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 18:56:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF3820049;
	Fri, 25 Apr 2025 18:56:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E1A220040;
	Fri, 25 Apr 2025 18:56:26 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 18:56:25 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv3 3/4] tree: add attribute numa_nodes for NVMe path object
Date: Sat, 26 Apr 2025 00:26:08 +0530
Message-ID: <20250425185617.1242994-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425185617.1242994-1-nilay@linux.ibm.com>
References: <20250425185617.1242994-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vvLewm5AvozbaR6lp1uQiDc-i7rqJ0kF
X-Proofpoint-ORIG-GUID: vvLewm5AvozbaR6lp1uQiDc-i7rqJ0kF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEzMiBTYWx0ZWRfX9V4t+bw0dpqN IFKOeHuTOsREMs44krhA1QkjGsXLU2QggaU744umwDb5yUhorQf26UmlONZSHt0R5LZXtS1E3Zs f2ECtUNOgjR1NG3JbNXlQLfWH6oeF6ciedTp/WIqoulLZ5ifuWE4lkEiqqZrgtciCDMbrpNGxzb
 CwZfYQnueMhVs+iwPNt4MbrZn3sr/+sf8WECtrObm/36yqoQUJMv9D+HSxT8M3Qf5+c+EAUIWZf q0r+9JwWL/Sql9f2lR4zdjQfl5PoblFWIY/9mTIkAoUmdNEemeXDkTcsTyP7rUP3zxchfk5gpzC mKayaKmXME1ukmjXMe7oHnV77TdVaCcYSpdcHE6sykVYYvIS4BtUQ/09coMlAEhQOlhr5Qy/ap6
 vYmWVYN3QeH1jo22NMRW/jJf5m93wVvqkk/Mi9FzuekiyBF92G/ht7l4g7kTBMEsRnOJdv+l
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=680bdade cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=K2osYvVS4dd-3OXIFZAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_115632_687012_FF9CB5DF 
X-CRM114-Status: GOOD (  16.73  )
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

Add a new attribute named "numa_nodes" under the NVMe path object. This
attribute is used by the iopolicy "numa". The numa_nodes value is stored
for each NVMe path and represents the NUMA node(s) associated with it.
When the iopolicy is set to "numa", I/O traffic originating from a given
NUMA node will be forwarded through the corresponding NVMe path.

The numa_nodes attribute is useful for observing which NVMe path the
kernel would choose for I/O forwarding based on NUMA affinity. To support
this, export the attribute in libnvme.map so it can be accessed via
nvme-cli.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 src/libnvme.map    |  1 +
 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 10 ++++++++++
 src/nvme/tree.h    |  8 ++++++++
 4 files changed, 20 insertions(+)

diff --git a/src/libnvme.map b/src/libnvme.map
index e53fad6b..ffadc647 100644
--- a/src/libnvme.map
+++ b/src/libnvme.map
@@ -317,6 +317,7 @@ LIBNVME_1_0 {
 		nvme_path_get_ctrl;
 		nvme_path_get_name;
 		nvme_path_get_ns;
+		nvme_path_get_numa_nodes;
 		nvme_path_get_queue_depth;
 		nvme_path_get_sysfs_dir;
 		nvme_paths_filter;
diff --git a/src/nvme/private.h b/src/nvme/private.h
index f94276e2..5bfa027b 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -33,6 +33,7 @@ struct nvme_path {
 	char *name;
 	char *sysfs_dir;
 	char *ana_state;
+	char *numa_nodes;
 	int grpid;
 	int queue_depth;
 };
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 20d4c2e2..80dccdc4 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -920,6 +920,11 @@ const char *nvme_path_get_ana_state(nvme_path_t p)
 	return p->ana_state;
 }
 
+const char *nvme_path_get_numa_nodes(nvme_path_t p)
+{
+	return p->numa_nodes;
+}
+
 void nvme_free_path(struct nvme_path *p)
 {
 	list_del_init(&p->entry);
@@ -927,6 +932,7 @@ void nvme_free_path(struct nvme_path *p)
 	free(p->name);
 	free(p->sysfs_dir);
 	free(p->ana_state);
+	free(p->numa_nodes);
 	free(p);
 }
 
@@ -962,6 +968,10 @@ static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
 	if (!p->ana_state)
 		p->ana_state = strdup("optimized");
 
+	p->numa_nodes = nvme_get_path_attr(p, "numa_nodes");
+	if (!p->numa_nodes)
+		p->numa_nodes = strdup("-1");
+
 	grpid = nvme_get_path_attr(p, "ana_grpid");
 	if (grpid) {
 		sscanf(grpid, "%d", &p->grpid);
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index a9082f8e..f6116c2b 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -867,6 +867,14 @@ const char *nvme_path_get_sysfs_dir(nvme_path_t p);
  */
 const char *nvme_path_get_ana_state(nvme_path_t p);
 
+/**
+ * nvme_path_get_numa_nodes() - NUMA nodes of an nvme_path_t object
+ * @p : &nvme_path_t object
+ *
+ * Return: NUMA nodes associated to @p
+ */
+const char *nvme_path_get_numa_nodes(nvme_path_t p);
+
 /**
  * nvme_path_get_queue_depth() - Queue depth of an nvme_path_t object
  * @p: &nvme_path_t object
-- 
2.49.0


