Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19603C8303D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/Y4ZL22FgeOqkAWLTU0W3SEoXlgd75XzUD6yYL0dyU=; b=AiYRmXUZxXyd9gt7ZHA3I5WYDX
	uOu8y7YhYVbZpopI+EqIrnMnup8itigv0PHqTaKR+G/aNBJZl5hIiAxDT4TW0V0HYCflzf6zwpBMv
	bknYqEeFF3AiF+RpUD/Px1PVYoxZO0eO7DESR+ftY2fkSCxxq4LFaNnle866HrPMcDIkdGrqpFZMx
	JgB7UwvoAGkzmbWP6WQxIceJw1VIQvmOeRuNCMN/N2q0ms/CCf07O9H5zRX37ICOMBPIL5nIjutnr
	c05yNmh9ar4Yn+V9KuXmJroi9Hlr3EhnGZWrHTxULEfyRSW+eIIvkRrbrR5DTjv1kgg5tTsAP5oHC
	ueOAXO6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXhAo-0000000EdPP-2yTj;
	Fri, 04 Jul 2025 14:13:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgoC-0000000EZpR-1Dnw
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 13:50:33 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564C0G5O013609;
	Fri, 4 Jul 2025 13:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4/Y4ZL
	22FgeOqkAWLTU0W3SEoXlgd75XzUD6yYL0dyU=; b=p7u+dSharrTtCFUr8aBZcb
	H04aaz6dHkJ1/0C/aAuUI7pWgRxooGg4vXx7a3ZOlkReN8YoRb7CItsTzIJeAM+8
	So8es8oVpzWC4mf4WoFlLD2r6k+LP4e6NUmLuuQ10GKMxXgcx/AzNI/BrZfL9Frz
	9X3jsSoFQdm/iekG/aFu9GvmnoxhSoN620y39BhvrQw4JAnOzsaCVA74MvK4rTfb
	2uOJBQK06Z+xEmkQALm0mYCUcolt4cQBPrHcaSA0VsWuk/7CnTHaygN/9yKJcgFp
	Oe4FgAc1QpYfhukeO4m9nf7j/k2LPB5MxYR44Z6a0DB3nsURCHP72BqC2AFZZU2A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82g9e7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 13:50:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 564A0AqY021088;
	Fri, 4 Jul 2025 13:50:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqutb3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 13:50:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 564DoQbL53477736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 13:50:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A11520043;
	Fri,  4 Jul 2025 13:50:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 685F920040;
	Fri,  4 Jul 2025 13:50:23 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.81.118])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Jul 2025 13:50:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCH 1/2] nvme: support <device> option in show-topology command
Date: Fri,  4 Jul 2025 19:19:53 +0530
Message-ID: <20250704135001.292763-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704135001.292763-1-nilay@linux.ibm.com>
References: <20250704135001.292763-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EIc0sXSY6eLU5Ob9E64wpq1CWKkY_pr7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNSBTYWx0ZWRfX7dkYvD0h0Oq8 h9ALAbtS9JXQtxe3Yfh1r58MBrK4xG5p3Ua6kbRjLMBgcoN3ga+tmtSgQFImRPGNnc3wHBf1PAG dQCFBZWM//iy3Hmhz7X9II/P62QH2jiMU9b04q0Y1jxaDNSWf8fR3T8z5Q5RdMNL9LdgWso2+i9
 B2oSIjxRSx3HPtvpwhrSbR1gfRDZmBZkwZS3U1cWZw9Yjm93whJ4rfJTv7/kCDTGtb2kI0TfoIz Uks/UoxdBtPgvcAxHgcJUC+lDZSayUFWaGQHZCQNMAw+2Uf4qz9f0igyzWhcQgHO3xhQldWVdaQ KLVHok5UPr/QXTWoOt9oGcS8gZWjiG0rSKtcJh4rRXKciS2gViPfz6aW+t4Rp5evniH/YkBBMgT
 075MJAA6zdVDhnBb7O5zOeL/W5IK4rct9wFumtgEpzvqrJwS3NPuMxOjJpdPrdFyzp+Fttga
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=6867dc25 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=fQhDe627euf1iyP7odYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EIc0sXSY6eLU5Ob9E64wpq1CWKkY_pr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_065032_445238_3D73CA49 
X-CRM114-Status: GOOD (  18.02  )
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

Although the help text for the nvme show-topology command indicates
support for a <device> option, this option has no effect in practice
— specifying an NVMe device name does not filter the output.

This commit adds proper support for the <device> option, enabling users
to filter the topology output based on the specified NVMe device.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-stdout.c |  9 +++++++++
 nvme.c              | 17 ++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index 7d7d4b27..2c97abd7 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -5679,6 +5679,15 @@ static void stdout_simple_topology(nvme_root_t r,
 
 	nvme_for_each_host(r, h) {
 		nvme_for_each_subsystem(h, s) {
+			bool no_ctrl = true;
+			nvme_ctrl_t c;
+
+			nvme_subsystem_for_each_ctrl(s, c)
+				no_ctrl = false;
+
+			if (no_ctrl)
+				continue;
+
 			if (!first)
 				printf("\n");
 			first = false;
diff --git a/nvme.c b/nvme.c
index be0c5f23..772ab000 100644
--- a/nvme.c
+++ b/nvme.c
@@ -10059,6 +10059,8 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
 	const char *ranking = "Ranking order: namespace|ctrl";
 	nvme_print_flags_t flags;
 	_cleanup_nvme_root_ nvme_root_t r = NULL;
+	char *devname = NULL;
+	nvme_scan_filter_t filter = NULL;
 	enum nvme_cli_topo_ranking rank;
 	int err;
 
@@ -10101,7 +10103,20 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
 		return -errno;
 	}
 
-	err = nvme_scan_topology(r, NULL, NULL);
+	if (optind < argc)
+		devname = basename(argv[optind++]);
+
+	if (devname) {
+		int subsys_id, nsid;
+
+		if (sscanf(devname, "nvme%dn%d", &subsys_id, &nsid) != 2) {
+			nvme_show_error("Invalid device name %s\n", devname);
+			return -EINVAL;
+		}
+		filter = nvme_match_device_filter;
+	}
+
+	err = nvme_scan_topology(r, filter, (void *)devname);
 	if (err < 0) {
 		nvme_show_error("Failed to scan topology: %s", nvme_strerror(errno));
 		return err;
-- 
2.50.0


