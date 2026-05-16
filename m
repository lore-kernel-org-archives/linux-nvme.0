Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFE5CD4F49
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nIHTlMwowWedR5cxXqM9GFbQaGfWqBvJ54d6NSX96lc=; b=fXcOKL1EnijGkI6pGXda1LB6cq
	IUaLTcJXTcjiRr6ptEB/SuMu+Dqk0Q32En1mN2wzyHgJcOe5Vr/M2DxL7QN1ksqFm/hYcXSlI0d8j
	//b+0rWlVRZVCezEDdPWKkufmy3CUOC1Jx+W7fESPvg98k7NpMPQwN48iFrGOYDI+FjvuIv8glv45
	qpm4gfgRFYruB0elhVJ5yQczWBnbNL8/gLzjVnsxTtQ+a5N8Bt8uJFc8NCYhDyinXaGFBAFul5AaU
	AqprGA4FqWLrZPyqlMCdj+Q4MW8ZoMN9M40XR9UUNzn4KGAsLtN/bQXUSLPKzLlkW3VhH2lI88ctT
	rmz4r0ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtn-0000000BE5U-2mva;
	Sat, 16 May 2026 18:38:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtk-0000000BE1h-3ZvU
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:38:06 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G46Ckn069628;
	Sat, 16 May 2026 18:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nIHTlMwowWedR5cxX
	qM9GFbQaGfWqBvJ54d6NSX96lc=; b=rDP0r0M+IUvgV2HmBp0JKqGi1ifWJrkJj
	SDKg7f5suLVlgACOfh/EmBKhnF2YUj4tF1cbWPnP7Mwrka54xPJUOLiosszIta/+
	JNXUTfa+GJ4ARmS0uHljmBoso1DSZ2fzhD3z+bIl4Dwb/PfW2NpAfZ6RVXJLp6Rk
	+FB+z3ivrNlY8rRUj7BhIMnDSqLmfhRioe7sxI05GThxP6ZLAEpZjmApEx/1JRh7
	Q+gOzqOWdqK2rAuCo8c/swmQ6dEUWKYKApgAMT9gu6BG4Nx5CMgdHCN4IkW69Neb
	ksEqsIGKqrRZg64mn3lzLwfy1aITLyOUctFCYuJahSTGWe6w0jQJg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8m9v4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIO9Ug022630;
	Sat, 16 May 2026 18:37:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcgsk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIbtg051183932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:37:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FEC020043;
	Sat, 16 May 2026 18:37:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7321020040;
	Sat, 16 May 2026 18:37:51 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.111.59.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:37:51 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 7/8] nvme: export controller reset event count via sysfs
Date: Sun, 17 May 2026 00:06:54 +0530
Message-ID: <20260516183709.269937-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uZpYuAgYYsCJJSu6jB2RUso5A3ZQrxIJ
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a08b987 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=XQ-XxMglAtByCkMZczYA:9
X-Proofpoint-ORIG-GUID: uZpYuAgYYsCJJSu6jB2RUso5A3ZQrxIJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfXz/jmCZn6sWR/
 ghHjpRZq8fGMpdvwDOV6eCVCsU/kiLJ9GBGxXn0M8DxCpV+9xGFwaEb+JjKwlGB1jo58HZfv87a
 AqRmGDjZxWkPY2XUPVrVh9H/L+QTiq63XPsUsPArxq0Y2dDKf/fjzylNWQQmTK6/0Kld+/LNKPR
 IgtPwORPbVH0d0V9lEPgMHb6WTT754LHxzzZ5N6HUucC7lgcGu9w3xSpL/sXJyj14gybf1sXzyE
 8tb/5sT/9npedeKuklLa88rFcbpo7yBYJnf0APnx5mgOqHvrvPf4hTjTIPqQC0KUDTFLKayogJ0
 mBriZPwNgoRXWctvsEP1BhmDVFDG96SuTa7pPEtckBi3rt7GXoAZVJsI4MPVXUycUL9cmbUk5P2
 CaiSXUZWV9fvhQaTy2fVHFXXKbRmNViCZgic1iZqACFdk6/PcU46a3h+OjRe+owITmAznrUE+F0
 C13kwuMf3Wy72+kANKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_113804_902988_AAF54328 
X-CRM114-Status: GOOD (  13.31  )
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

Expose a per-ctrl sysfs attribute reset_count, under diag attribute
group to provide visibility into these RESETTING state transitions.
Observing the frequency of reset events can help users identify issues
such as PCIe errors or unstable fabric links. This counter is also
writable thus allowing user to reset its value, if needed.

This counter can also be consumed by monitoring tools such as nvme-top
to improve controller-level observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b2f7a972941..b4dace419552 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -596,6 +596,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 			changed = true;
+			atomic_long_inc(&ctrl->nr_reset);
 			fallthrough;
 		default:
 			break;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9434abf2659e..e575bef99d4a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -414,6 +414,7 @@ struct nvme_ctrl {
 	struct work_struct fw_act_work;
 	unsigned long events;
 	atomic_long_t errors;
+	atomic_long_t nr_reset;
 
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 01d771d85f31..72300d6de880 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -1070,8 +1070,35 @@ struct device_attribute dev_attr_adm_errors =
 	__ATTR(command_error_count, 0644,
 		nvme_adm_errors_show, nvme_adm_errors_store);
 
+static ssize_t reset_count_show(struct device *dev,
+		   struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", atomic_long_read(&ctrl->nr_reset));
+}
+
+static ssize_t reset_count_store(struct device *dev,
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
+	atomic_long_set(&ctrl->nr_reset, reset_cnt);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(reset_count);
+
 static struct attribute *nvme_dev_diag_attrs[] = {
 	&dev_attr_adm_errors.attr,
+	&dev_attr_reset_count.attr,
 	NULL,
 };
 
-- 
2.53.0


