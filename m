Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD801E6BF30
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yq7Vn/OxYJcooIV9Ic/7poJT32v5vwwRWCWBUJuJuj4=; b=M+WsLKG42DoemQPAKArkzIIeu5
	dZY26boQsR5iK8qlmY3B7pNMegE2d9hTDxojzIn2J8/akmR6QmIg0ADLgTkkmlacu8sF+AA2tlHHI
	ijYRmycc6Q0AorExcXp3eEmwAxDqHqGjH0Bi4rHuttXp5qWvcLv5YswPSs6GKqLs5gcug8U1srGAG
	YEfkjNbjNr49kCqua4omekIbwfH1Q/A7XPsXvG2/p9FoA7MYwHbh5Zy9Kna7Zccm3yt9IbPGeGMGd
	25l80KeZSQeZ7r5dGlbH1Xe3ddoyl3t9sYXemcFN2DP1bv5iX5K0P3a2XupEoGgn3vDbi6F99xoyU
	lKJFQNzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7X-00000001pDK-26Cn;
	Fri, 30 Jan 2026 18:21:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7V-00000001pAP-3Q7X
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 18:21:26 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60UGubD4012099;
	Fri, 30 Jan 2026 18:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yq7Vn/OxYJcooIV9I
	c/7poJT32v5vwwRWCWBUJuJuj4=; b=smC4Y4ifQqSHS9xG3U9AVtqWvTjLaR4E2
	CbNkAco+2W3DawIlmGAU9HIvWzt9IpInLajn0x7PTGqvoZGie3mzUUXTVt2uW6De
	VfbqdxVpgnLALw/isuI+7H5sVdu7W5Wss1GsjMqvukBPKUYnvzas5Fd8zuotloLF
	CugNZxz7jQc2QDHE1r4Vb4F7utCEIaAjVxZmHyVt0JaNGCZG6iTK33HPIW4j8Ey6
	bH073iuQ9NhFkhL3ObrJ/YbTnhX2DecqlX/uxcNEnzI7++uTb0dRJ/J4Aso/mlNM
	g3zS6WcyLbqfg3HxRF9dgojScOonfO5k4TaqiSEOa5Rzt6HwgebNw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr6kwhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UGUmvf019844;
	Fri, 30 Jan 2026 18:21:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dnfa4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60UILHuW50200870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 18:21:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B11D2004B;
	Fri, 30 Jan 2026 18:21:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CD3720040;
	Fri, 30 Jan 2026 18:21:13 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.154.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 18:21:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 7/7] nvme: export controller reconnect event count via sysfs
Date: Fri, 30 Jan 2026 23:50:24 +0530
Message-ID: <20260130182028.885089-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130182028.885089-1-nilay@linux.ibm.com>
References: <20260130182028.885089-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1MCBTYWx0ZWRfX+YJ2yII3eG5d
 YedKzMJljYexlufkm8Hlesez8/CavZUDEG/ma76IZIKPIrKMX/+gvp2dHEn74Z9DY27urYnPrgn
 tuzx0xjiwwmbfGYy1OXRlon8WkyjJU38iga6U7uK/UFRvaQXw3f7CByyRTJDKEsisrd1YQE1fDf
 cDRjJqi+bFsvhRXBonL8mUZCHMO/Rl4zPtwQ0l0TOjRD4pbZH6AG3s/J2n2TY4+os9A+QaeJEn1
 6rvTqh0tycqNyxoP+w71koyRHf38kqzVMc556bQtwg797v92eIuOMoejExuA0ji7GxXPvLNJCuO
 9Uw1TtvO0jrUXdtY0p5XJcmKUsY0zEPwf5reu3Iw73cXehB6RiRiY7W/xRT4t/pz5wE+3qrXvqv
 sFVAF4B/gxaYhrhEHOygyqTafg9xQdhEodIBTWCsdGtPnsu/Rsbu0iNXcqU9Wa+FJqrD5JjoRr+
 WuDXl8MR76/p7OEDKZA==
X-Proofpoint-GUID: SfmR9tPufRtRHLu8V-kxZrxh1TvBYR6r
X-Proofpoint-ORIG-GUID: SfmR9tPufRtRHLu8V-kxZrxh1TvBYR6r
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=697cf6a1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=f5T8FIHjskq37WK-NkIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601300150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_102125_970079_56170A63 
X-CRM114-Status: GOOD (  15.87  )
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

When an NVMe-oF link goes down, the driver attempts to recover the
connection by repeatedly try reconnecting to the target at configured
intervals. A maximum number of reconnect attempts is also configured,
after which recovery stops and the host controller is removed if the
connection cannot be re-established.

The driver maintains a counter, nr_reconnects, which is incremented on
each reconnect attempt. Currently, this counter is only reported via
kernel log messages and is not exposed to userspace. Since dmesg is a
circular buffer, this information may be lost over time.

Expose the nr_reconnects counter via a new sysfs attribute, reconnect_
events, to provide persistent visibility into the number of reconnect
attempts made by the host. This information can help users diagnose
unstable links or connectivity issues.

This counter can also be consumed by monitoring tools such as nvme-top
to improve controller-level observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e1ef44e69768..c78c494f4ee0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -678,6 +678,15 @@ static ssize_t reset_events_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(reset_events);
 
+static ssize_t reconnect_events_show(struct device *dev,
+		   struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", ctrl->nr_reconnects);
+}
+static DEVICE_ATTR_RO(reconnect_events);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -827,6 +836,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_adm_command_retries.attr,
 	&dev_attr_adm_errors.attr,
 	&dev_attr_reset_events.attr,
+	&dev_attr_reconnect_events.attr,
 	NULL
 };
 
-- 
2.52.0


