Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF17AC369B2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UhFIu5HVdURktam60nNxxbGkq33x6ItCQpMeJA+AaLg=; b=iPq0/Wu9iCPBbn1A+bnui1oMVO
	CqMKYRW8SL9fttDAnZz5dEjdtSsIcfiu4fx6hOuIo26YwMUZ0mvyrY9gsbDO3kghQ4YgQNBlzqCmk
	vT765BsuBSEHXCmKrtVZD87IzZp5jQ7RRKx/jS2KXrsEy2iHkq45XSOr2S04peIcWbF1ZeNkG+gUX
	2fPoB41n9Pz6ljlGcLn8aQhRrZeJRNEjO7Lv70gKn64N5WOyVWo0pMhajKIPkefjC0BuFOrp+I7ub
	ZAnX8xMj2JQG6Lld+Bi/TeqPdDosd0oS0B6wRC3Q3efE6U1TlbGfKihE7ulc1vlwUCxl1KpCFOPvI
	/NdupyTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Po2-0000000DEnv-3csV;
	Thu, 17 Apr 2025 14:01:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Pme-0000000DEcs-3ftr
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 14:00:06 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBsefP019755;
	Thu, 17 Apr 2025 14:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UhFIu5HVdURktam60
	nNxxbGkq33x6ItCQpMeJA+AaLg=; b=JmdE38T98OeiZV6MOUbthdEFTjOwoo98c
	FKq4HIIZPbqezq3dPwXmcimWfFNjmX/LapkypXGOtnQWH8TJ2pPHpsOaL+1ecMx9
	lQc+z44MT5RVqQGvGGdx0v8TiyUvy9lwJOkdhnvWOBNtn70BnVUev7LEwLqUCUl2
	oqCeObE1Cazfcwn9zDLYfsdZSsy5TCL6xorU2RhhNSRIJyvJu/H3i0Tr1pDt4Wws
	0V7amfgVTg9D6LcwVNqztZXH0kdC8o1CorwIdXK4fkFAfo7wXVYL0gendYNraaU1
	YD270jeHWUTlPwg9uIhLWWDw4n4ZWSSltk5SXgnFeOH3xaT0LmFoQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462ph0bcp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:59:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HDJ1SL024900;
	Thu, 17 Apr 2025 13:59:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtp94w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:59:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53HDxvK159179268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:59:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27AF22004D;
	Thu, 17 Apr 2025 13:59:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E145220040;
	Thu, 17 Apr 2025 13:59:55 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.1.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 13:59:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv2 2/4] tree: add queue-depth attribute for nvme path object
Date: Thu, 17 Apr 2025 19:29:44 +0530
Message-ID: <20250417135951.239447-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417135951.239447-1-nilay@linux.ibm.com>
References: <20250417135951.239447-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QJdoRhLL c=1 sm=1 tr=0 ts=6801095f cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=Ht8HIYEzmufRDo8zFfwA:9
X-Proofpoint-GUID: 2SOhkkU5kYIc-03oUXgeBLlvU8sxaKwr
X-Proofpoint-ORIG-GUID: 2SOhkkU5kYIc-03oUXgeBLlvU8sxaKwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=981 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504170101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_070005_044673_9CB94E12 
X-CRM114-Status: GOOD (  18.22  )
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

Add a new attribute named "queue_depth" under the NVMe path object. This
attribute is used by the iopolicy "queue-depth", which was introduced in
kernel v6.11. However, the corresponding sysfs attribute for queue depth
was only added in kernel v6.14.

The queue_depth value can be useful for observing which paths are selected
for I/O forwarding, based on the depth of each path. To support this,
export the attribute in libnvme.map so it can be accessed via nvme-cli.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 src/libnvme.map    |  1 +
 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 12 +++++++++++-
 src/nvme/tree.h    |  8 ++++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/libnvme.map b/src/libnvme.map
index 4314705f..e53fad6b 100644
--- a/src/libnvme.map
+++ b/src/libnvme.map
@@ -317,6 +317,7 @@ LIBNVME_1_0 {
 		nvme_path_get_ctrl;
 		nvme_path_get_name;
 		nvme_path_get_ns;
+		nvme_path_get_queue_depth;
 		nvme_path_get_sysfs_dir;
 		nvme_paths_filter;
 		nvme_read_config;
diff --git a/src/nvme/private.h b/src/nvme/private.h
index f45c5823..f94276e2 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -34,6 +34,7 @@ struct nvme_path {
 	char *sysfs_dir;
 	char *ana_state;
 	int grpid;
+	int queue_depth;
 };
 
 struct nvme_ns_head {
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index bd7fb53e..b7a38a07 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -903,6 +903,11 @@ const char *nvme_path_get_name(nvme_path_t p)
 	return p->name;
 }
 
+int nvme_path_get_queue_depth(nvme_path_t p)
+{
+	return p->queue_depth;
+}
+
 const char *nvme_path_get_ana_state(nvme_path_t p)
 {
 	return p->ana_state;
@@ -921,7 +926,7 @@ void nvme_free_path(struct nvme_path *p)
 static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
 {
 	struct nvme_path *p;
-	_cleanup_free_ char *path = NULL, *grpid = NULL;
+	_cleanup_free_ char *path = NULL, *grpid = NULL, *queue_depth = NULL;
 	int ret;
 
 	nvme_msg(r, LOG_DEBUG, "scan controller %s path %s\n",
@@ -955,6 +960,11 @@ static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
 		sscanf(grpid, "%d", &p->grpid);
 	}
 
+	queue_depth = nvme_get_path_attr(p, "queue_depth");
+	if (queue_depth) {
+		sscanf(queue_depth, "%d", &p->queue_depth);
+	}
+
 	list_node_init(&p->nentry);
 	list_node_init(&p->entry);
 	list_add_tail(&c->paths, &p->entry);
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index 9f382e9c..a9082f8e 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -867,6 +867,14 @@ const char *nvme_path_get_sysfs_dir(nvme_path_t p);
  */
 const char *nvme_path_get_ana_state(nvme_path_t p);
 
+/**
+ * nvme_path_get_queue_depth() - Queue depth of an nvme_path_t object
+ * @p: &nvme_path_t object
+ *
+ * Return: Queue depth of @p
+ */
+int nvme_path_get_queue_depth(nvme_path_t p);
+
 /**
  * nvme_path_get_ctrl() - Parent controller of an nvme_path_t object
  * @p:	&nvme_path_t object
-- 
2.49.0


