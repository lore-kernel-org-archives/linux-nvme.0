Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBC6C54E60
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Mar 2024 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YDRvf123KJOj4gCmURmNkby0/Ak1EwyAQDi+aUDutYI=; b=D4WlwL6LHmANMu8jEXaYNEhlaz
	WftisDPZL5g3eaqqa4UwLPdDoO6xAl/wYactMrwkTatGM9CsNATDDCbi51HGA6eU4GTAjJ1m5ns4W
	xT8YNYNRRS/kta0nlvF44LhM2kKlJfGN7NSwbYHwGq35ZOv0pfv0Og7YDBpyCiAfWfIdgdAuRE55G
	PEqsJs33ZpKJTQyzmiwo0XgY0R7EzjiGrue3Rdpr5vdNl361Mq4XOurOlRqpRlXeys1J4H5Pi/so4
	yrw7KkWys1pdYhBnshCVqd0+9bhi5HtuHjX9UEIC4nuE8VfHrS2y4tnFrq0AS5VedtTDOPQm4NwvM
	UBDlccLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rloqW-0000000533s-40SR;
	Sun, 17 Mar 2024 11:38:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rloqT-00000005333-1rzc
	for linux-nvme@lists.infradead.org;
	Sun, 17 Mar 2024 11:38:31 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42H8ik7K016425;
	Sun, 17 Mar 2024 11:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YDRvf123KJOj4gCmURmNkby0/Ak1EwyAQDi+aUDutYI=;
 b=S8Ovhj9hDQ411zHj4h4kbybxXK+fvy8p2ykbQwRSxXXRd3EkFqMgVyDU+4NJxUqN2Ofv
 SLhmo3J38bP6CtGmm9WhCcMVMMJ23kxklrskZPWWu3vQxBM9vbY9rJeZrrTK7obdX88y
 HnF1NC0iP+vzu7gs9rv6+zXrkcE3+59C/nTxhNszSDwGOKB77TDCnXtbLbmJbt4txN+U
 6HXcJakH0MjehMPcfoaesOJ5hEopsmKuwK1QOfeS+XAnl+eQNjSunOt5ltdj1ROEHADt
 w+c5UFxXGmJpORzPWNcsZhx+SRQaTIeG6I0ndZM1kAShd+ItJ393yCFbKV4ePpHciZ/s ew== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wwtw4hmbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 11:38:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42H9ULqM011582;
	Sun, 17 Mar 2024 11:38:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8kj5wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 11:38:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42HBcJFR52560158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Mar 2024 11:38:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E72CC20043;
	Sun, 17 Mar 2024 11:38:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CCFA20040;
	Sun, 17 Mar 2024 11:38:17 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.47.162])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 17 Mar 2024 11:38:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, dwagner@suse.de, gjoyce@ibm.com, nilay@linux.ibm.com
Subject: [PATCH nvme-cli] nvme : Don't seg fault if given device is not char/block device
Date: Sun, 17 Mar 2024 17:06:22 +0530
Message-ID: <20240317113758.3055071-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nv7KsCXodVMkJtBodC0yUhNkVBJZ37VJ
X-Proofpoint-GUID: nv7KsCXodVMkJtBodC0yUhNkVBJZ37VJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_07,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=951
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403170090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240317_043829_537416_0475E37E 
X-CRM114-Status: GOOD (  21.50  )
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

If the given device name is not char/block device then in
open_dev_direct() set errno to ENODEV and err to -1 before
returning to the dev_fd(). This would then ensure that in
case of error, dev_fd() returns the corerct negative error
code back to its callers. So now the callers of dev_fd()
would handle the error appropriately instead of try
accessing the nvme_dev which would be NULL.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Hi all,

I was running nvme-cli command "id-ns" where I inadvertently
passed a device name which was neither char device nor block
device. Surprisingly, after running the above command I found 
that nvme-cli reported the device name is invalid but then it
crashed. Further debugging into it, I found that it requires 
a trivial fix to avoid the crash. Here's what I tried:

# nvme id-ns /sys/block/nvme0n1 
/sys/block/nvme0n1 is not a block or character device
Segmentation fault

And this is the corresponding gdb backtrace:

Program received signal SIGSEGV, Segmentation fault.
0x000000000040a6ca in __dev_fd (dev=0x0, func=0x8772e1 <__func__.36> "id_ns", line=3639) at ../nvme.h:76
76		if (dev->type != NVME_DEV_DIRECT) {
(gdb) bt
#0  0x000000000040a6ca in __dev_fd (dev=0x0, func=0x8772e1 <__func__.36> "id_ns", line=3639) at ../nvme.h:76
#1  0x000000000041620b in id_ns (argc=2, argv=0x7fffffffdeb0, cmd=0xa14280 <id_ns_cmd>, plugin=0xa15280 <builtin>) at ../nvme.c:3639
#2  0x00000000004482f5 in handle_plugin (argc=2, argv=0x7fffffffdeb0, plugin=0xa15280 <builtin>) at ../plugin.c:171
#3  0x000000000042a2bb in main (argc=3, argv=0x7fffffffdea8) at ../nvme.c:9040

This patch fixes the above seg fault.

Thanks,
--Nilay
---
 nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index 3f0f2ff4..00625151 100644
--- a/nvme.c
+++ b/nvme.c
@@ -254,7 +254,8 @@ static int open_dev_direct(struct nvme_dev **devp, char *devstr, int flags)
 	}
 	if (!is_chardev(dev) && !is_blkdev(dev)) {
 		nvme_show_error("%s is not a block or character device", devstr);
-		err = -ENODEV;
+		errno = ENODEV;
+		err = -1;
 		goto err_close;
 	}
 	*devp = dev;
-- 
2.43.0


