Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8584AC2D0CD
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 12:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/9PzkPgc+Sz6XknB4yIcwEqaSDYKpSGnokdwmOaNzdE=; b=NoJqmkxbmbpWifDdVdeNmN5J/S
	0L7zRytoYCEjW+7fqkGkQ3qBpaY9RbUqjHEsA8VHmuirpibe5ZaPbl/SV2RlGPptUB93bEeikrrC6
	GlZufqtUsQyyhVTKksZrgk3dsL30Kijd3Yp/TBzJ7tsn/1QlOrQ6DU8GazK94f5xJrZ4SWCqTdfe1
	68NxiK0Zf4rXuRXWtC2l2MsqnrJgV5Wi0AzWfGnymmFWdAxilOfk9D1lNcQgAZCSZqxC3wBfN2+Sl
	wAy1uAiDFIQGPeyHAeUWz52q8zu8gqtvAI5VLpVjl9sgsVietfYLVAgEPtOC6rRtqeVOA018nYTNK
	AP8v0xZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHisn-0000000FpAg-1hf2;
	Wed, 21 May 2025 12:49:17 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHili-0000000FnnS-1SBp
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 12:41:59 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L8pSDv014332;
	Wed, 21 May 2025 12:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/9PzkPgc+Sz6XknB4yIcwEqaSDYKpSGnokdwmOaNz
	dE=; b=OqYvNxb9y/PmJ1VEjyWHBWfOgihhd2KZzcLE9WNjLMULHCA5PHAt2mWFQ
	4YCi8G5Q13Rv0O49SdTdNNA52ocSdxFC4uMXzrwe3m31COko5vhkw6Bet3bCjuRF
	iReebUF7yXHWmrramghfr19dPKI3Ol2wnmIvGytdRxO9wQfd0Rrb3D58zWn6xS/y
	47N7HPZTVMjgRHfQuB9cBqiOlK0vWIbJTWwkhdeYn1VIkO8llNCmksj60Pbj4eM2
	/1lAnNBlR55/FwZJFQPOEEHdxUNp94NGkNBD5K5FjRejnZ6CkGLllY1uuQIaJ33j
	DDO3dfwyxAOHvangwOBRgLIdAW/lA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sbph11u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:41:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9S4Kf031977;
	Wed, 21 May 2025 12:41:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmq46rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:41:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LCfeSh22086052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 12:41:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E6532004B;
	Wed, 21 May 2025 12:41:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F1B020040;
	Wed, 21 May 2025 12:41:38 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.223])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 May 2025 12:41:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, gjoyce@ibm.com
Subject: [PATCH] nvme: avoid creating multipath sysfs group under namespace path devices
Date: Wed, 21 May 2025 18:11:23 +0530
Message-ID: <20250521124137.99939-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyMiBTYWx0ZWRfXzqswoTI0ffnO 8NLYesE5QzAP16+PH08l+FtaFr4EScjGBJbSVBrvAA4oK2c8AFUo6ohGsT3H7Say9Lc5j0c6115 V8VDHKWbGvrzYW+LqP+Ex0lF5B/YejyC+EhOwSLgdYshAEUYacnZCWh6UGuPfgbxwsmJ3dCIKF6
 vhdqRnlQZOfPkKhpiU5RG/6LB7c38qM6VRGlP12upYLbeqtOS7SBToNERarVz1exLwMMgGO1O41 Thlpd11PF3+AnbUE2j7uMdR3iwc++jk5aNNI5GolJBsGulJXihnwxulw1iTntMkBn2LGaxvBC4l VVmKFqAkFJn7AspCrIXidfCbBvDEXDYfyvIEcVOrNZXnSWER1+zKRo3o3Jv1sc3SlM9XxBu3+Nj
 NbdfremON6DinA/qc6LsBl4+ydvSl2tgpilYiv8juwaSMGOvHSgvVrABih5KSNQxPtWJmre9
X-Proofpoint-ORIG-GUID: Ik2Wug1OFJeq0kObxUwev9k0xc4iazZL
X-Authority-Analysis: v=2.4 cv=L5kdQ/T8 c=1 sm=1 tr=0 ts=682dca07 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=AjJlw9t7D9_i4YqfV8kA:9
X-Proofpoint-GUID: Ik2Wug1OFJeq0kObxUwev9k0xc4iazZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=754 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_054158_387266_E8D6E725 
X-CRM114-Status: GOOD (  19.24  )
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

Commit 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin
io-policy") introduced the creation of the multipath sysfs group under
the NVMe head gendisk device node. However, it also inadvertently added
the same sysfs group under each namespace path device which head node
refers to and that is incorrect.

The multipath sysfs group should only be exposed through the namespace
head gendisk node. This is sufficient, as the head device already
provides symbolic links to the individual namespace paths it manages.

This patch fixes the issue by preventing the creation of the multipath
sysfs group under namespace path devices, ensuring it only appears under
the head disk node.

Fixes: 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin io-policy")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index a48d30c31d51..222e7448f0f0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -313,13 +313,44 @@ static const struct attribute_group nvme_ns_attr_group = {
 };
 
 #ifdef CONFIG_NVME_MULTIPATH
+/*
+ * NOTE: The dummy attribute does not appear in sysfs. It exists solely to allow
+ * control over the visibility of the multipath sysfs node. Without at least one
+ * attribute defined in nvme_ns_mpath_attrs[], the sysfs implementation does not
+ * invoke the multipath_sysfs_group_visible() method. As a result, we would not
+ * be able to control the visibility of the multipath sysfs node.
+ */
+static struct attribute dummy_attr = {
+		.name = "dummy",
+};
+
 static struct attribute *nvme_ns_mpath_attrs[] = {
+	&dummy_attr,
 	NULL,
 };
 
+static bool multipath_sysfs_group_visible(struct kobject *kobj)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+
+	if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
+		return false;
+
+	return true;
+}
+
+static bool multipath_sysfs_attr_visible(struct kobject *kobj,
+		struct attribute *attr, int n)
+{
+	return false;
+}
+
+DEFINE_SYSFS_GROUP_VISIBLE(multipath_sysfs)
+
 const struct attribute_group nvme_ns_mpath_attr_group = {
 	.name           = "multipath",
 	.attrs		= nvme_ns_mpath_attrs,
+	.is_visible     = SYSFS_GROUP_VISIBLE(multipath_sysfs),
 };
 #endif
 
-- 
2.49.0


