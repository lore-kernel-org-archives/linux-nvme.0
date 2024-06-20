Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D081CC27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=K0yI8p8bslzcK6KV9GhI4wEFr1h12z2li+5+PeBEnwU=; b=AdXLLP1HJjkvPY
	zbLAecQnBVzP/GJl87yXt2KNsciDlJBTIMoAflLdtpR0o9SPlxtk8Ue0fD9WzfwQ3/T4vXN9XAGKA
	HEvmm689v1Bs+HlXuee0NttoK/FWIRQcDzu9fjzn56fgGx2E3nDE4Yd/6CaeFJpztw8PK/IN48MBB
	svKZfG19rQCLWjN8vWvLW36oTpZ4Wnru3Ou44OsUQhjrEgo+V3RU+LaCTvIfqWKn7hTfWuPlTdOBS
	WqNl23wvImOdD9sEXGhdBy/1w45sJyLnbju2uKxrby58k/mh3IAd8BpTkuh6tD27I48lXnrjGZo3j
	JRQxhFRCv3wPjweDDy3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKHLP-000000051zH-2Pao;
	Thu, 20 Jun 2024 12:56:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKHLJ-000000051xA-1Xxh
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 12:56:48 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KCuAal007098;
	Thu, 20 Jun 2024 12:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=K0yI8p8bslzcK6KV9GhI4wEFr1h12z2li+5+PeB
	EnwU=; b=SZpD/FX4Z084L4s/iiGYbj4mq0QI8bp8OqBZkh25frCXTAkMNDdyBwq
	s4i1gR9oU7YJxGfwRSF/lvkZRKUwfun4Vm1N56dfXLVFU7vRgEE0+ddVrdXuAT5v
	4I7pDbDrab3AfguZxJ4jj0/sT01wn5HMryhhcUPQB7I5FR7fAy4Jx4XcrSJsFjCY
	zU/vu6ZZOR7feRMu7LxNkHfSrWgPzdIwOrLr/Z8/UK9waStjE396XjLiezCJPMU5
	hCVnrw06di49+hjVePFg0Nq8BLxPdzBKYQj9Ki2zHamqllhRuDZPH/Boz9odOSiz
	UrpC7nFPapw4Oym88zSwau8BQi3jlkg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvggs8q88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 12:56:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KAvBdI009457;
	Thu, 20 Jun 2024 12:56:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgn5sam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 12:56:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45KCuOcS17301786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 12:56:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3963920040;
	Thu, 20 Jun 2024 12:56:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF6612004E;
	Thu, 20 Jun 2024 12:56:21 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.39.114])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 12:56:21 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: dwagner@suse.de
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@ibm.com, msmurthy@imap.linux.ibm.com,
        axboe@fb.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH nvme-cli] nvme: warn about attaching a namespace to unknown controller
Date: Thu, 20 Jun 2024 18:25:45 +0530
Message-ID: <20240620125604.3017138-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S5npcxZney2nLhqr0ReGtXP0Fomt1VPF
X-Proofpoint-ORIG-GUID: S5npcxZney2nLhqr0ReGtXP0Fomt1VPF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_055645_794083_96D1E450 
X-CRM114-Status: GOOD (  23.19  )
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

Sometime it's possible for a multi-controller NVMe disk to have only
one of its controller discovered by the kernel. And if this happens
then it's also possible for a user to create and then attach a namespace
to a controller which has not been discovered by the kernel. In such a
case the attached namespace can't be used for IO because there's no path
to reach such namespace from the kernel.

This patch helps to warn about such case to user when user attempts to
attach a namepsace to an undiscovered controller by kernel. If this warning
appears to the user then user have about 10 seconds of time to abort the
operation by pressing CTRL-C. If user doesn't abort this operation
within 10 seconds of timeout then nvme cli goes ahead as usual and attach
the namespace to the controller.

Link: https://lore.kernel.org/all/f1a7c1e2-3203-4b7a-a922-82fa812455bd@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 4 deletions(-)

diff --git a/nvme.c b/nvme.c
index ba760901..0f3b3297 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2811,6 +2811,84 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 	return err;
 }
 
+static bool nvme_match_subsys_device_filter(nvme_subsystem_t s, nvme_ctrl_t c,
+		   nvme_ns_t ns, void *f_arg)
+{
+	nvme_ctrl_t _c;
+	const char *devname = (const char *)f_arg;
+
+	if (!s)
+		return true;
+
+	nvme_subsystem_for_each_ctrl(s, _c) {
+		if (!strcmp(devname, nvme_ctrl_get_name(_c)))
+			return true;
+	}
+
+	return false;
+}
+
+static int nvme_cli_ns_validate_cntlid(__u32 nsid, struct nvme_dev *dev,
+				       int *list, int num)
+{
+	const char *cntlid;
+	int __cntlid;
+	char *p;
+	nvme_host_t h;
+	nvme_subsystem_t s;
+	nvme_ctrl_t c;
+	nvme_root_t r = NULL;
+	int i, err, matched = 0;
+	nvme_scan_filter_t filter = nvme_match_subsys_device_filter;
+
+	r = nvme_create_root(stderr, log_level);
+	if (!r) {
+		nvme_show_error("Failed to create topology root: %s",
+				nvme_strerror(errno));
+		return -errno;
+	}
+
+	err = nvme_scan_topology(r, filter, (void *)dev->name);
+	if (err < 0) {
+		if (errno != ENOENT)
+			nvme_show_error("Failed to scan topology: %s",
+					nvme_strerror(errno));
+		nvme_free_tree(r);
+		return err;
+	}
+	nvme_for_each_host(r, h) {
+		nvme_for_each_subsystem(h, s) {
+			nvme_subsystem_for_each_ctrl(s, c) {
+				cntlid = nvme_ctrl_get_cntlid(c);
+				errno = 0;
+				__cntlid = strtoul(cntlid, &p, 0);
+				if (errno || *p != 0)
+					continue;
+				for (i = 0; i < num; i++) {
+					if (__cntlid == list[i])
+						matched++;
+				}
+			}
+		}
+	}
+
+	nvme_free_tree(r);
+
+	if (matched != num) {
+		fprintf(stderr,
+			"You are about to attach namespace 0x%x to an undiscovered nvme controller.\n",
+			nsid);
+		fprintf(stderr,
+			"WARNING: Attaching nampespace to undiscovered nvme controller may have undesired side effect!\n"
+			"You may not be able to perform any IO to such namespace.\n"
+			"You have 10 seconds to press Ctrl-C to cancel this operation.\n\n");
+		sleep(10);
+		fprintf(stderr, "Sending attach-ns operation ...\n");
+	}
+
+	return 0;
+}
+
 static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, struct command *cmd)
 {
 	_cleanup_free_ struct nvme_ctrl_list *cntlist = NULL;
@@ -2866,12 +2944,16 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
 
 	nvme_init_ctrl_list(cntlist, num, ctrlist);
 
-	if (attach)
-		err = nvme_cli_ns_attach_ctrls(dev, cfg.namespace_id,
-					       cntlist);
-	else
+	if (attach) {
+		err = nvme_cli_ns_validate_cntlid(cfg.namespace_id, dev,
+						  list, num);
+		if (!err)
+			err = nvme_cli_ns_attach_ctrls(dev, cfg.namespace_id,
+						       cntlist);
+	} else {
 		err = nvme_cli_ns_detach_ctrls(dev, cfg.namespace_id,
 					       cntlist);
+	}
 
 	if (!err)
 		printf("%s: Success, nsid:%d\n", cmd->name, cfg.namespace_id);
-- 
2.45.1


