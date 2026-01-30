Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CE0E6BF30
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oToz+9utPowP6jzp7sc+BD2J8Pgh9fKYKRsR023J0RE=; b=CZCK/Dt5JKGziY7nTJl7XE6/2z
	NKESJOm82Picsq5jUR23noX8KN0xpBKVprChjpjic1ZRaTOUow7SbPkPt9Mbr8wuHKVlkraBYDNtl
	trdfgv81avUjcuh3z4l/1ljv2OTr3lL9zpAxvybS8bVRkQW/YoMZk7lWBiLIl1+t76jo92glDq5R7
	M28RGoqdNdx+Hm0847Z91PHOHuIx5sr4zhmVKJjZITnP0OL6PcP1fPMVBBrqmmeeSZy0PfYi0/EJn
	x6dW1WUalnkxTyFAwfoqss/mMqi8kpgq8CF/JBWTN+76qNMLxHxBuuOhkQM50zcaGne84+NzkwvN9
	uf3Jllog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7V-00000001p9Z-0Qjp;
	Fri, 30 Jan 2026 18:21:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7S-00000001p7A-03TM
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 18:21:23 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60UH4a4h011191;
	Fri, 30 Jan 2026 18:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oToz+9utPowP6jzp7
	sc+BD2J8Pgh9fKYKRsR023J0RE=; b=CQS6Dk4IfR8yFluVvS1h0r+F1qvnrmzLw
	MmeW9/k14xXrWVmGZlnxb8hANDICgcyh84AgsBqRVnqDT+Pb9awLz1VbtJQRkwfz
	wxNQ/CXhz9OQD26mtSDYzzbEO4+S/NWQp64xCaag0ppB6m7mun5iAhTEzeU/SJZu
	DbqIDEHlms4FgRw1ArhnBlJeOsdBHAZz5NxnakudmcdxlXQzWLtm1KgRTb/8bRFD
	dpRjrul9LJ6QYcCEc5yRm1NilJAy7+/+B4NSGSfUFaa4VhMede0PnvII9dVUZyDO
	6Y2PlLF9vfZAnT3mN7Ngp3jtg18I325iXcU1x3MbHdegmGdRcoYeQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmggc57a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UHgXYV018239;
	Fri, 30 Jan 2026 18:21:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb4272h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60UILCqK34013670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 18:21:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8658F20043;
	Fri, 30 Jan 2026 18:21:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1C5320040;
	Fri, 30 Jan 2026 18:21:08 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.154.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 18:21:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 6/7] nvme: export controller reset event count via sysfs
Date: Fri, 30 Jan 2026 23:50:23 +0530
Message-ID: <20260130182028.885089-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130182028.885089-1-nilay@linux.ibm.com>
References: <20260130182028.885089-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697cf69d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=XQ-XxMglAtByCkMZczYA:9
X-Proofpoint-GUID: f4gWEcSmW0yvahsWZr7HhyZPUKxAlABl
X-Proofpoint-ORIG-GUID: f4gWEcSmW0yvahsWZr7HhyZPUKxAlABl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1MCBTYWx0ZWRfX3bAqNsISEBo5
 wJTgR445lpNyQoM0hQvPo+ewnUNeLhhPN+dOxddHCid9H6X4njpIcYW3XlIX9JXSPJEd1nrwOlG
 uY5Pahsgd0sgVPtEjCOq3o1jzmv9ZYZcAzWAFNorlBfywcPZ/yXHvtbM0Sm7gJRuqsQfDt8sUiY
 fX7F06rJDpt2S84+jfFBb6uhHeeUWVKFpeeaQgbYN/q2QvjTgCEIhO8q42Q1B0SFAoW71EN8Ey9
 bgK9cuwZjoi2RH+sNf/QmPGMrFV2YbsG3Xd3DRWLzzz51FTuWegtIb1Xh20UO1KQABAWTIU/3Y1
 d5a21mBEOgl0aLuN0BbCFwrgKRaXqPY5elmYVE3onWU7YJj1pwEa5Q2UymD3AkEVB9VCZSV0PS6
 ax+o68vFoIshqEwD4zKgwehmimttKS4kRHVVqVM4Z9IM0CkUWVfYfh6MxgVd5qVGOKW5dkyHuTA
 2WnoSeG0qZWmP+PihUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601300150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_102122_169918_E136D8BA 
X-CRM114-Status: GOOD (  16.62  )
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
index d16a3f4cc466..bb74834c4ed8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -597,6 +597,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 			changed = true;
+			ctrl->nr_reset++;
 			fallthrough;
 		default:
 			break;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 66bd4db1fe0f..d76e42fee01f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -361,6 +361,7 @@ struct nvme_ctrl {
 	unsigned long events;
 	u64 retries;
 	u64 errors;
+	u32 nr_reset;
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
 	u8 anacap;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c23d9a0ba3f4..e1ef44e69768 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -669,6 +669,15 @@ static ssize_t nvme_adm_errors_show(struct device *dev,
 struct device_attribute dev_attr_adm_errors =
 	__ATTR(command_error_count, 0444, nvme_adm_errors_show, NULL);
 
+static ssize_t reset_events_show(struct device *dev,
+		   struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", ctrl->nr_reset);
+}
+static DEVICE_ATTR_RO(reset_events);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -817,6 +826,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	&dev_attr_adm_command_retries.attr,
 	&dev_attr_adm_errors.attr,
+	&dev_attr_reset_events.attr,
 	NULL
 };
 
-- 
2.52.0


