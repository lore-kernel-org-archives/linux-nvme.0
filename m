Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6F8CA0EE0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qjJsmINYoF7rdAxkx3lL5lKQ2VWnXJsBlc1sNGcVjDE=; b=unAxRYaRKOZfoG86bWq2WHVFJd
	lOVW22eHGM/oMxIEdq7SHftPTM0k+eXWDC/mdOkO8/5L3kxl4spi7n+wP9/eJ1Lqw08dnRxOqCHTR
	c+g8GFCMw8mPV60ivn/quVpmwoaOyIuzcBTQJ1ONxtXyAUp68ggolAG9EcqnBwtWlMiCQZGNQGwDc
	FeBATFwMbQojcwMrVP2WVurNNLiQkf9Q+glQ9GpLhIzuz0cLJBMK+8VLtIX2CVs/kfyvSlvQ0Rbrs
	uLn62uwOO3c7DkuVpeWqEwQqrnaJCXlecVMHr6paNAoeWgtW/HJoz7fhUHvpa0yjqzBF3vbmZ+Ru8
	h8bbX1WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsqS-0000000Ba0P-0Oyx;
	Tue, 12 Aug 2025 17:31:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uloYo-0000000Aqp3-1hQR
	for linux-nvme@bombadil.infradead.org;
	Tue, 12 Aug 2025 12:57:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qjJsmINYoF7rdAxkx3lL5lKQ2VWnXJsBlc1sNGcVjDE=; b=DU8f3dxu4fdUsC4+98SuWrx/Rw
	J7MDNbsPSDlBltsJZSchgxs8lLJZXqo418J4Ek721dxJQ4q4AMEr9TFwjBIn4O5YnZHh57MaBRg0M
	r9DPJsSG2OhY5RLgEQZS1pPv3MIFbsQ6CCw1NUG1NCktRUw1avuqQNvqQsqzz6G4fsKGBP7wwWYDW
	6nFxc18pGwBI5RIfN8ouRHE1m2uiAFZSo74e3RDxOk3Ycrd+4mKFcMN9blgW+vvRip5+jTGf/0du8
	PuBq3EEMSOi/IfY0wzvTOei4kj+UTdQvQduYhuoWfcsHYc9t86hmmxUkwoEAyOKbzyscJgq7+BKLa
	EktWUPEA==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uloYl-0000000FoGI-1aYx
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 12:57:01 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAHm5a013132;
	Tue, 12 Aug 2025 12:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qjJsmI
	NYoF7rdAxkx3lL5lKQ2VWnXJsBlc1sNGcVjDE=; b=R7PmVqvqAZ1ETy2gyKXe7t
	8yFPKorA7IIPf78XaBOzKIlwuSfg5bFSxtngxlENNefdeFL+HThvLJnelF0axCwI
	tQx6W4Qijik0VfqztUWS6wNc9QcBu9CpdudpQQNVwtMZucjH5Bk+/vyZ5iLAoFb+
	EsJB2AYOaXo/KXQSM8402PrHNjMiPCvoQACbNyNpSPPUCC0fAP7rq400sAPvcH6y
	qQhl55WiY7/y6WBAgbuYv7lUr2DPgnu/0crg6HjQKMyDQqy2h8hfWeQYaEajGsIM
	SC0i0EYz0gJD9DYct5KERQhKP0SWrCqOX2D55/Xy/4eymZMBWkcITXai1nDTTnhA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cxfas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 12:56:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57C9vaQk020795;
	Tue, 12 Aug 2025 12:56:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnptec2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 12:56:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CCuMiw27525736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 12:56:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F7F120040;
	Tue, 12 Aug 2025 12:56:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D79320043;
	Tue, 12 Aug 2025 12:56:19 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.161.148])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 12:56:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv2 1/4] nvme: support <device> option in show-topology command
Date: Tue, 12 Aug 2025 18:26:02 +0530
Message-ID: <20250812125614.164445-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812125614.164445-1-nilay@linux.ibm.com>
References: <20250812125614.164445-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEyMyBTYWx0ZWRfX42HpV/xnABQX
 RVKPmDCMVkwAq2CffxSNwUbFbZWptW0uaa7/fEHRWNjQsFEZGem8JM2hxSnw355KLDLEhYXhjoB
 PKig3aJcRUWpBuzZduWvLUXZARCNhRPuCs3skwT+hex2Xz5IuPO13YOfkALPX3mgx3GwvdW+SQY
 kYv9qhvzijXT5qwL7w/sMC41RSb2kwRwIFBhkFYbRK6a7Mpj9rQV6UBUHtmBmpX1mk9BUzHoO6R
 iT3r/homCvGCeseXVgveX0/rHUEMQ1wuPgq039zECasb2El+aZYM/gH3HshVxbHERrT09sEomDk
 DJdPwY4gvOsoJEggpzK9VYs8mqC5yoml+eRwJ+4H0pS9MZAS0et39M8qGZZlmoNij3KfSiGpqPR
 MYGZ9Mbx4ivnvxjbsQOEbriiLS582NBzScL3NY4Mv1ea74NnwkNjGX0cFWBF+BKs16EK/d5t
X-Proofpoint-GUID: RMcx5zMdMBhCGXQEJBzJAwcdWcsSs2w1
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=689b39f9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=fQhDe627euf1iyP7odYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RMcx5zMdMBhCGXQEJBzJAwcdWcsSs2w1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_135659_820628_10513E50 
X-CRM114-Status: GOOD (  16.98  )
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
index 27dac37b..c6779cf4 100644
--- a/nvme.c
+++ b/nvme.c
@@ -10155,6 +10155,8 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
 	const char *ranking = "Ranking order: namespace|ctrl";
 	nvme_print_flags_t flags;
 	_cleanup_nvme_root_ nvme_root_t r = NULL;
+	char *devname = NULL;
+	nvme_scan_filter_t filter = NULL;
 	enum nvme_cli_topo_ranking rank;
 	int err;
 
@@ -10197,7 +10199,20 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
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
2.50.1


