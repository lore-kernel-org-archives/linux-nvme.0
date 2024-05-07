Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16B3C25B4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 11:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uSv/AAFBn7XmwOVoCHYBPDGheMTZpYLRrTbRDSTy5nM=; b=RQCDWgptUgiY3r06YkrvTTnOk1
	+mywhh0TjDItKWec5igIHFHjR6ZgI8/c/y/0iWeymO/oc8AanJXhlSJ430CSWDVTfaYGVhStWKvRo
	Sue3vCi+i2PyZpy5n9c7BMYgz6/1pTWGMnrueNeuEtoor+EutYrBkmxvQuqiqAveWlWaXRErhClfZ
	kwsKRpVU4eKJ/hvUFKF89Gi8vEYHCIUFJwqYMxfLXkE6vh+6mnbuk8Zb7caGajm1X6xW55+HmmMlj
	5uTrT761iqETvdYMLHAkuMj22sK16aVRbMMbJjP465OI3dTdqtnuOutKnEbGuXkcu5d2MG1HRgg2m
	ROZbUP8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4JFr-0000000AlnT-13CR;
	Tue, 07 May 2024 11:45:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4JFo-0000000Alm2-3DsR
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 11:45:06 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447BgAln016270;
	Tue, 7 May 2024 11:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uSv/AAFBn7XmwOVoCHYBPDGheMTZpYLRrTbRDSTy5nM=;
 b=Zhh+F8Zn0m8UJdVS9lNC5q4iHWZOENdjzn7fDbL6SpMcAjCwKQbaUyDWGFuIvgXnA+IO
 ZGwhKmal7qNdAclbaT0yT8WUL1ItE/HxF4Q+cSi0dBbRUyglf4cT5yYyuu8gwLKYUuXy
 XAxkgMydeTvm0lOvYZQxJJsCd2htY5H7Yto2kxSUjZfIsUA120JLxZDv355s5mUipy0r
 YE01hjmnhmd8TjJhoB2k8xK+tZUp9rLyYbQoD29S/rcPRLljPW0yc+hFQViLoV8z/XkI
 nsZGZFhN3J/GTFJd/COhe7t/yaLHeBdc2Es4MhP3ZPUjyk3C1aHEhfvW25ex7Zz6aCl6 7w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyknd009a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:44:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 447AUBAQ014034;
	Tue, 7 May 2024 11:44:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xx222wf5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:44:48 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 447Bijdb42009108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 11:44:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43C1158059;
	Tue,  7 May 2024 11:44:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 616D658073;
	Tue,  7 May 2024 11:44:42 +0000 (GMT)
Received: from [9.109.198.221] (unknown [9.109.198.221])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2024 11:44:42 +0000 (GMT)
Message-ID: <dfb2488a-6275-4822-94ec-07a575cbf09c@linux.ibm.com>
Date: Tue, 7 May 2024 17:14:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli : attaching a namespace to an undiscovered nvme
 controller on multi-controller nvme disk
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Gregory Joyce <gjoyce@ibm.com>,
        Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>,
        "axboe@fb.com" <axboe@fb.com>
References: <f1a7c1e2-3203-4b7a-a922-82fa812455bd@linux.ibm.com>
 <yhvmfctxhfzrcsq4lx6nr3f5n67kegrixtthh3pals7vn5qr26@k5as5whcdrum>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <yhvmfctxhfzrcsq4lx6nr3f5n67kegrixtthh3pals7vn5qr26@k5as5whcdrum>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nW0FVCOgi3FhOujcuVmXhqJdE8Iwsy9L
X-Proofpoint-GUID: nW0FVCOgi3FhOujcuVmXhqJdE8Iwsy9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_044504_855887_01EE631A 
X-CRM114-Status: GOOD (  29.71  )
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



On 5/6/24 20:35, Daniel Wagner wrote:
> On Mon, May 06, 2024 at 07:45:20PM GMT, Nilay Shroff wrote:
>> There could be multiple ways to address this issue. However my proposal would be to address
>> it in nvme-cli. As nvme-cli builds the nvme topology it shall be easy
>> for nvme-cli to detect
> 
> The topology scan in libnvme is only using the information available in
> sysfs. libnvme doesn't issue any commands anymore and I'd like to keep
> it this in this way. So if the kernel doesn't exposes this information
> to userspace via sysfs, I don't think it's simple to 'fix' this in
> nvme-cli/libnvme.
> 
I think the information which we need to contain this issue is already
available through sysfs. If we scan nvme topology then we could find 
the controller id assigned to each controller under each nvme subsystem.
We can then leverage this information to figure out whether each controller 
id specified in the attach-ns command is valid or not. So essentially we 
match controller id specified in attach-ns command against the controller id 
learnt through scanning the topology. If we find that any discrepancy then we
can show the WARNING to the user. I have worked out a patch using this method. 
I have attached the patch below for suggestion/feedback.

diff --git a/nvme.c b/nvme.c
index c1d4352a..533cc390 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2784,6 +2784,23 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 	return err;
 }
 
+static bool nvme_match_subsys_device_filter(nvme_subsystem_t s, nvme_ctrl_t c,
+		   nvme_ns_t ns, void *f_arg)
+{
+	nvme_ctrl_t _c;
+	const char *devname = (const char *)f_arg;
+
+	if (s) {
+		nvme_subsystem_for_each_ctrl(s, _c) {
+			if (!strcmp(devname, nvme_ctrl_get_name(_c)))
+				return true;
+		}
+		return false;
+	}
+
+	return true;
+}
+
 static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, struct command *cmd)
 {
 	_cleanup_free_ struct nvme_ctrl_list *cntlist = NULL;
@@ -2839,12 +2856,68 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
 
 	nvme_init_ctrl_list(cntlist, num, ctrlist);
 
-	if (attach)
+	if (attach) {
+		const char *cntlid;
+		int __cntlid;
+		char *p;
+		nvme_host_t h;
+		nvme_subsystem_t s;
+		nvme_ctrl_t c;
+		nvme_root_t r = NULL;
+		int matched = 0;
+		nvme_scan_filter_t filter = nvme_match_subsys_device_filter;
+
+		r = nvme_create_root(stderr, log_level);
+		if (!r) {
+			nvme_show_error("Failed to create topology root: %s",
+					nvme_strerror(errno));
+			return -errno;
+		}
+
+		err = nvme_scan_topology(r, filter, (void *)dev->name);
+		if (err < 0) {
+			if (errno != ENOENT)
+				nvme_show_error("Failed to scan topology: %s",
+						nvme_strerror(errno));
+			nvme_free_tree(r);
+			return err;
+		}
+		nvme_for_each_host(r, h) {
+			nvme_for_each_subsystem(h, s) {
+				nvme_subsystem_for_each_ctrl(s, c) {
+					cntlid = nvme_ctrl_get_cntlid(c);
+					errno = 0;
+					__cntlid = strtoul(cntlid, &p, 0);
+					if (errno || *p != 0)
+						continue;
+					for (i = 0; i < num; i++) {
+						if (__cntlid == list[i])
+							matched++;
+					}
+				}
+			}
+		}
+
+		nvme_free_tree(r);
+
+		if (matched != num) {
+			fprintf(stderr,
+				"You are about to attach namespace 0x%x to an undiscovered nvme controller.\n",
+				cfg.namespace_id);
+			fprintf(stderr,
+				"WARNING: Attaching nampespace to undiscovered nvme controller may have undesired side effect!\n"
+				"You may not be able to perform any IO to such namespace.\n"
+				"You have 10 seconds to press Ctrl-C to cancel this operation.\n\n");
+			sleep(10);
+			fprintf(stderr, "Sending attach-ns operation ...\n");
+		}
+
 		err = nvme_cli_ns_attach_ctrls(dev, cfg.namespace_id,
 					       cntlist);
-	else
+	} else {
 		err = nvme_cli_ns_detach_ctrls(dev, cfg.namespace_id,
 					       cntlist);
+	}
 
 	if (!err)
 		printf("%s: Success, nsid:%d\n", cmd->name, cfg.namespace_id);

Thanks,
--Nilay


