Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8CFCA1012
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Sep 2025 20:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kJmuyD5v3K/MasC8Fmoj2E+g64+kIEHXAFRoG+nKRlA=; b=lfanHkrABTEnzrsS7x4q45PlK8
	RqVdOCQsiO/j86/1KXY/tpys3PW8PAxWz+gBnBnri/nsdD6c85bq+yBFZRnv1Fb3qxD2TIkfwHVct
	epO3dZThtiGiikTZxLaq3acYHn2Lu++4ZgPFB3zUHJtg3gxdC/RdXhJYBJJ4SzcqAGQ/NBzjBWe7e
	s8+LrmpMYjZHoyC1QjXMkTVTGeKxBjF6q0gT2mhPvajIzw8S5gUghQOU4uWjHtSk81nbYGVtOoeXL
	ddVUUVXJsX7UQ93Iwl5Lm7LK2qWwTH/9N/XwUkqtPkQ0QDSyGfizmD8zuwzUk6LFniDphcc7oiNm3
	0VJ2t3og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuGbz-0000000EGZv-1Mjb;
	Thu, 04 Sep 2025 20:31:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuECm-0000000DPSx-35Wx
	for linux-nvme@lists.infradead.org;
	Thu, 04 Sep 2025 17:57:05 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584FcHg2013229;
	Thu, 4 Sep 2025 17:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kJmuyD
	5v3K/MasC8Fmoj2E+g64+kIEHXAFRoG+nKRlA=; b=AaGci4kg0r1XWURXjLFSQS
	gKSJqY6B0yKcPZZoN9xNwyGI+jQvaXWDDIQbF7ibEpS8oHwozO9imn6ZaHm/wwD7
	5I8Y2txmoDOZp1qBz3MWYWUfMJv5NSiic6PfuL4FC6v/5NuYLefD81fL47ZhbjVO
	2Ck8L4b5vO30jspx64jyAL3ns9YMx90b4XDYCjR/RZsuQbv8BzMhoG3I+mIWKoQ5
	Tr27zqAzVJdVXmP3TeFoFqAyOMklMZkEj8wq8CTCweMIeNEaF/8efKkQp7gOoOyF
	Gcm3c2Zu21nYec2gIIPeCsR5YUE/cQIt77NC9T/5oqHe3dSQbk3oqdIgqR2iiMMQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3byc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 17:57:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584Fn4Rr019404;
	Thu, 4 Sep 2025 17:57:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n5n26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 17:57:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584Hux9556426838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 17:56:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72B0E2004B;
	Thu,  4 Sep 2025 17:56:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9767320043;
	Thu,  4 Sep 2025 17:56:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.24.25])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 17:56:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv3 1/4] nvme: support <device> option in show-topology command
Date: Thu,  4 Sep 2025 23:26:48 +0530
Message-ID: <20250904175654.1183750-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904175654.1183750-1-nilay@linux.ibm.com>
References: <20250904175654.1183750-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xiLOIWmIwD1T7675SF9W67EYu_ixtVaA
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68b9d2ee cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=fQhDe627euf1iyP7odYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xiLOIWmIwD1T7675SF9W67EYu_ixtVaA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX96nd92xE/Bgj
 pI348uLxzHJ9X3UrSpUeplx9skuH8h2UW/mrK3yKfp4ThpBVzVjbXAaAQv3mtIGA4aJCPSm7/II
 kFYzeSLlrauokka/uk0HyRLWY0hdLEdW78cYjR+pljzQzvjlGe96xzM234xlYtyKKHbEpaJOOYv
 gJdJAMkjyKYtCTWXTlzgB5waWrzzxQCF0D5hy6i0EghLE+jklbp0Lb9CKl7ioCSF32OU3q78tFg
 imB+ByUOo0cUcK14op/z47kfklHwrsOK8mAwwg2QY5OUjfcI/VKtoFsSeAOk3rxi4t7uY9dPivc
 bcgJUsDDrV8kTslQuHWEKwW6Tj3ABYw9PxELHm0oQ+s2nSRY5DL6cRgyx/brO1TgUrg8QeVOmVz
 Vrs5zcBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_105704_777977_651AED74 
X-CRM114-Status: GOOD (  17.01  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-stdout.c |  9 +++++++++
 nvme.c              | 17 ++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index c597b608..eb56349a 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -5683,6 +5683,15 @@ static void stdout_simple_topology(nvme_root_t r,
 
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
index b3cd538b..f17a8091 100644
--- a/nvme.c
+++ b/nvme.c
@@ -10182,6 +10182,8 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
 	const char *ranking = "Ranking order: namespace|ctrl";
 	nvme_print_flags_t flags;
 	_cleanup_nvme_root_ nvme_root_t r = NULL;
+	char *devname = NULL;
+	nvme_scan_filter_t filter = NULL;
 	enum nvme_cli_topo_ranking rank;
 	int err;
 
@@ -10224,7 +10226,20 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
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
2.51.0


