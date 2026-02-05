Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE57EEC1EAD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mE6KuINyudjMlLCZPSNTccGdswLTogVCChZaob8Oobw=; b=i099wYmVICIBh4QuD68hDnORj2
	wkOB7ER3i7CFpqtqXqVDebBaBcrtZ3iPGL4IQlZVy/hCLwGMsal7Yu981A9Xa0HldDuc0IRMmX/U7
	Ze62HeTbd7mXsYpDFD9e37iXmKbyiOeTWrhEBKHQgtN8Aap99tU0UCWJN38Ret4TubFDd7AL3FJoA
	UYrbsblFID/kU9mhaiEkICeVhYdLFVQy5OReXU2kAikS1/FnZGPHWIkyxUlEnE66o2/O4z5Y6EeYi
	S9o7iYvFwqgv2EyyKY9rzdVR+eTUhwyzpvbQhDdFzviuDCctPjA0KOtnizuaIKVeUAGiBFUG/I0mU
	2j4HljIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymw-00000009tlI-2os9;
	Thu, 05 Feb 2026 12:48:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymt-00000009tiW-1lll
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 12:48:50 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6158Ck6v024626;
	Thu, 5 Feb 2026 12:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mE6KuINyudjMlLCZP
	SNTccGdswLTogVCChZaob8Oobw=; b=cNzAi0aH5gGse7CrNNqQ0R9rl60YGni18
	x4XXWzs7fA7VOvEdt9ko2JtGK/QdqBGHH80Noq/pQgAPGST5jRIJW8UByKfBpebV
	3NDxXMgPF0uAEQIH2BXeQXaSRPxSdbn0dApThNT1Ik0Ky11ghrrZmC6+d8eZr6kO
	LcBY1p15XrQ25mPbMutmtz9JBQO5kzBx8NZXtoqKaIk0Txx5t9LX8J1nOGcKRtSp
	jGbze98UnSgpyYXDkxnZh1GvYHxJNLSCRlhFXu/yt+x0GGy+qIvV/JkX6jPkAwYk
	OyjCRcq3KJYr3vLwtAL/yL/nW+nKUNT/GMl4QyNdpEmX9yDE9I4kg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dtenqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615ACPrY029421;
	Thu, 5 Feb 2026 12:48:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2shvx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 615CmblK56099194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 12:48:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2841020043;
	Thu,  5 Feb 2026 12:48:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54B320040;
	Thu,  5 Feb 2026 12:48:34 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Feb 2026 12:48:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 6/7] nvme: export controller reset event count via sysfs
Date: Thu,  5 Feb 2026 18:18:05 +0530
Message-ID: <20260205124810.682559-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205124810.682559-1-nilay@linux.ibm.com>
References: <20260205124810.682559-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MiBTYWx0ZWRfX2QcHtNX3vfBN
 1wo+n+K4FswpBRjVRG7tQAXk2MOL8mZ1UlhohTvi2ryXsDbkBIBKWIHIQBZqrCW8OMn+rbkCLuY
 TtkDj9INe7zrlhwXlwocDHKOvHSMGQgN6CkSDpUanfZAv8DeQ94yNyzeVgqNta7Mfz9q3wicSuS
 PN8Rd1D3ShJlqXgKyDWbKGuBeOiRrVmwBBaqYUuplYEsQTR2LawEWf3Kybubr2nDFuUFRYoaziw
 4QbcrF7nTCdAlD1+UkX9HPDcWyZsa1+vLaZtk+bnvNlrTN5K/ruclIQje2PMUIa0CKl5s5QHHjE
 ZaGM37sSgAfZDMEJoZ3XEubhqOAL9KKHZZZCrqVkcygSWxAuwrZGcYOCpJ+toIYuVA0BfZqmt6m
 2rYjEXHUi51EXLLlOahboRgFWEvCbxnuMFKQ/DK1otKhIxba0DZjmXzpK+X7sY1bQpvEc2KwtGh
 nb3i5siOg9lb9/lNBPw==
X-Proofpoint-GUID: dCQW44JjzCa9dihWpMTO8gsT9_n5eCsJ
X-Proofpoint-ORIG-GUID: dCQW44JjzCa9dihWpMTO8gsT9_n5eCsJ
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=698491a9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=XQ-XxMglAtByCkMZczYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_044847_516601_3918EAD5 
X-CRM114-Status: GOOD (  15.35  )
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

The NVMe controller transitions into the RESETTING state during error
recovery, link instability, firmware activation, or when a reset is
explicitly triggered by the user.

Expose a controller reset event count via sysfs to provide visibility
into these RESETTING state transitions. Observing the frequency of reset
events can help users identify issues such as PCIe errors or unstable
fabric links.

This counter can also be consumed by monitoring tools such as nvme-top
to improve controller-level observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11eb28117501..36af86515cb7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -591,6 +591,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 			changed = true;
+			ctrl->nr_reset = size_add(ctrl->nr_reset, 1);
 			fallthrough;
 		default:
 			break;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b1ce2857899a..5d90e5fa7298 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -360,6 +360,7 @@ struct nvme_ctrl {
 	struct work_struct fw_act_work;
 	unsigned long events;
 	size_t errors;
+	size_t nr_reset;
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
 	u8 anacap;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c1e2b93f7ae8..7958fe998139 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -658,6 +658,15 @@ static ssize_t nvme_adm_errors_show(struct device *dev,
 struct device_attribute dev_attr_adm_errors =
 	__ATTR(command_error_count, 0444, nvme_adm_errors_show, NULL);
 
+static ssize_t reset_events_show(struct device *dev,
+		   struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", ctrl->nr_reset);
+}
+static DEVICE_ATTR_RO(reset_events);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -805,6 +814,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	&dev_attr_adm_errors.attr,
+	&dev_attr_reset_events.attr,
 	NULL
 };
 
-- 
2.52.0


