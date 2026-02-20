Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEBEC5AD46
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 17:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNUkRVMo4Hn4PrQi8F0uPoeihnl+rBbaiBP+jxHNwa8=; b=LnjwBl79+i6uR5jygqU8NsZRV9
	JJ953p59t+W5QuaLitqxtswF2a0nM5iI7MNpwRDNP96U1p+v2NpK2Rk40G5GA2rHEZjw8sV6ttliq
	Qji9Djc+DEhFRW78GCvLMINvESYJMQnuWkQbebMvVIsqVDcKDfncaxspjOLyrYSEDz3yGGAWY3p53
	npr3REgF5wV/jzW40QNYs/nvxpHZyJyL2fyL1wSWUedjt45bQAHTeQHIyEV5uqZbdHpbhhdrH5qzk
	KDWz1KGr1WKky6w08zhYq23tmRJPgq9chhleAzc3scRJKGMAsLfuW9mdyzKyah7Bm/DqLzQrZiywz
	LKA1iC7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUfE-0000000FPIs-35gA;
	Fri, 20 Feb 2026 17:51:40 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUf9-0000000FPGN-3FZd
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 17:51:37 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KEwIcO1271499;
	Fri, 20 Feb 2026 17:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WNUkRVMo4Hn4PrQi8
	F0uPoeihnl+rBbaiBP+jxHNwa8=; b=KbrmRy/8uaXjxV7XSmDvHU9MMAzba943v
	GFvBS5VeehwCU+ZPpUgZSZ/HtnZsAXinD7qCVAfT+UPW6jYpd9pCW8T3Caung3+Y
	89STVh35Nfu5z65dwBsGmSiA+CMsOcMnU6xpfeVDMRjsVVI65YbRQU0b2+7o2PEA
	piIuPmomxohQfyDmfyJnGBTiY0CXFbFXfSn9O/YYuFE7zcfm6PFLTVV9kzQii7Fu
	HU3giU1kYrgLfHK+MyhjG3wYXVLYABkDbL60lVORNZCd84XMRTO96n1Bm7micWuq
	/DzJ8vzZ1ClWEHqD8kZLjqKOUVqppwnU8DGAPcalO/XUBc6N2pxSw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4ktrvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:51:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEo2Dh030711;
	Fri, 20 Feb 2026 17:51:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45hchs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:51:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KHpNwO51773928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 17:51:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ED1920040;
	Fri, 20 Feb 2026 17:51:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 837E820043;
	Fri, 20 Feb 2026 17:51:08 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.6.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 17:51:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 6/7] nvme: export controller reset event count via sysfs
Date: Fri, 20 Feb 2026 23:18:51 +0530
Message-ID: <20260220175024.292898-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfX5shmvXr4tUin
 IgmgOqmdyYCPI7a5x2H0pQDJnbS1C4Y7Nf8Vj5foejMpCp6Wsc0+scwhtcvClcuvxFictJlgUaY
 rChBz7zs86qeQiBLicDIJHnkhLq2ruG1L/ZKbyToEzMqm8PCQlW1IT3WX1PKBpw+LE3QTpwtcHO
 8EiV3XXOfDaqeLAodl3FgE4y5tgoWVzcCwYd2sbUWB7p4vMfTsWFMdWp0EzivXlMQUUu0s85TRG
 rpXLAh/B9eV7oe7DTryxdT61nLORzButP6W7bSuofwLJpc1CLHKAsTi98IJXuicxVW8pOcPNwUc
 jOiYUsTgiDOLZn+G8VvWfsRNgoRxHS7cPgOzWCcnv95Ew0ZyBP8mzCGccZ7qjrnFADobppqDQe6
 DlHwOKvMt1rn2/KyuNtCj5qQYtJEbTnkguGD67hkoa1GHePlD9HKTMmKY64HJd65j7sgzQli4uQ
 wtvPgdBzlaNbcRT6tRQ==
X-Proofpoint-ORIG-GUID: IGdPC314Sgd3V-JjAVaU9mcJTj04_XpN
X-Proofpoint-GUID: IGdPC314Sgd3V-JjAVaU9mcJTj04_XpN
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69989f20 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=XQ-XxMglAtByCkMZczYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_095135_999279_DD519F0A 
X-CRM114-Status: GOOD (  16.68  )
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

Expose a controller reset event count via sysfs attribute named
"reset_events" to provide visibility into these RESETTING state
transitions. Observing the frequency of reset events can help users
identify issues such as PCIe errors or unstable fabric links. This
counter is also writable thus allowing user to reset its value, if
needed.

This counter can also be consumed by monitoring tools such as nvme-top
to improve controller-level observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c  |  2 ++
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 27 +++++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d07e2ed9e494..1cba460d8563 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -593,6 +593,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 			changed = true;
+			WRITE_ONCE(ctrl->nr_reset,
+				size_add(READ_ONCE(ctrl->nr_reset), 1));
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
index 790bf875dd1b..f3e6c7208315 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -710,6 +710,32 @@ struct device_attribute dev_attr_adm_errors =
 	__ATTR(command_error_count, 0644,
 			nvme_adm_errors_show, nvme_adm_errors_store);
 
+static ssize_t reset_events_show(struct device *dev,
+		   struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", READ_ONCE(ctrl->nr_reset));
+}
+
+static ssize_t reset_events_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int err;
+	unsigned long reset_cnt;
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	err = kstrtoul(buf, 0, &reset_cnt);
+	if (err)
+		return -EINVAL;
+
+	WRITE_ONCE(ctrl->nr_reset, reset_cnt);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(reset_events);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -857,6 +883,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	&dev_attr_adm_errors.attr,
+	&dev_attr_reset_events.attr,
 	NULL
 };
 
-- 
2.52.0


