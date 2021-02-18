Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD6EC433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 17:10:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7AD660230
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 17:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AD660230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6xosJCmJ2Ap4H6lWqRRgI195MG/D70qAAxyxg1+n00w=; b=ysxnpHHVPrfHb+ErCGZs7N8fV
	8aHSUXGeZjYfXZIa1ypbMC2CxXKgOcZSfwtNeR/SAQhHXPHFfTivy1Caj+Fckuph3sVvgr+yQJ06Q
	/m+BhSTVZSXfMwvxf2x7DISONsm/NZVEWt/fgtlRoSXZcFnfe1d34qx21Sp/097tZeM8rE2MFnOWh
	lAefSWR+eJdsH78/J01+cfj1TGl4E7mMlUJyxkjtSfEnQcOkxXQpDXcT6inzfq4VKkpen4X4rp/el
	pm+l3E799hJN70A8aAUIwC1OLSMc/ZDojRp4ZD+mutmEyAor0iTUGTaPyH/t50RhHPTIzCTpLPlgO
	+KEKZbdbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCmoU-0005ZL-AN; Thu, 18 Feb 2021 17:10:02 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCmoO-0005Xc-WC
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 17:09:58 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11IH2vUt017755
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=AL6O6/4UzNnSX1pXXdvIbx6l2dOBH2jL6kSua+5++PA=;
 b=RwJTANEIy1yHGUJiHwMqW8b7x4NQxg7Knqh5u+ZUU09+CV8VUTguUlWLOJpYVKqoecxs
 thvpcP4dNFM5+qO+JrxZ8tB5RQiJvK/3RIOU3+k9mFCQUVQGzL5ZM/ysX6DpuIh1QFbi
 nJG/R3gtL29Aktfd5UhP4gfBZFsWLBcfinBc46CnE0BRVTjUDWsoDxclWjaL3CCLfvO4
 DcenMiVUtKNCyYyy/WaZop+hjE0d/iZh++FoJFYVtbw6ii4f9WMWakIeNunReHECRu3X
 LVQRdKW/A/BioVkfZL+vDoWRV2fxpTIPs/PFJ0iPPGfD0k5Fm4Ujn8WYUmI891oDJ8Sr mg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 36pr88g8p6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:53 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11IGxSX0045130
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:52 -0500
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com
 [143.166.85.200])
 by mx0b-00154901.pphosted.com with ESMTP id 36pw0bvmbv-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:52 -0500
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,187,1610431200"; d="scan'208";a="1047578352"
From: Mario Limonciello <mario.limonciello@dell.com>
To: Keith Busch <kbusch@kernel.org>
Subject: [RFC 1/2] capability: Introduce CAP_FIRMWARE_UPGRADE
Date: Thu, 18 Feb 2021 11:09:46 -0600
Message-Id: <20210218170947.15727-2-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218170947.15727-1-mario.limonciello@dell.com>
References: <20210218170947.15727-1-mario.limonciello@dell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-18_08:2021-02-18,
 2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102180144
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_120957_251313_6FB365B5 
X-CRM114-Status: GOOD (  19.89  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Mario Limonciello <mario.limonciello@dell.com>, campello@google.com,
 Richard Hughes <hughsient@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 jorgelo@chromium.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Split out permissions specifically for firmware upgrades from
CAP_SYS_ADMIN to a new separate capability.  This will allow userspace
applications that would traditionally have needed CAP_SYS_ADMIN to perform
firmware upgrades to have a reduced permission set.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 include/linux/capability.h          | 5 +++++
 include/uapi/linux/capability.h     | 7 ++++++-
 security/selinux/include/classmap.h | 4 ++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index b2f698915c0f..e9233e217402 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -267,6 +267,11 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool firmware_upgrade_capable(void)
+{
+	return capable(CAP_FIRMWARE_UPGRADE) || capable(CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
 
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index c6ca33034147..0f204c6a1c0b 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -275,6 +275,7 @@ struct vfs_ns_cap_data {
 /* Allow setting encryption key on loopback filesystem */
 /* Allow setting zone reclaim policy */
 /* Allow everything under CAP_BPF and CAP_PERFMON for backward compatibility */
+/* Allow everything under CAP_FIRMWARE_UPGRADE for backward compatibility */
 
 #define CAP_SYS_ADMIN        21
 
@@ -417,7 +418,11 @@ struct vfs_ns_cap_data {
 
 #define CAP_CHECKPOINT_RESTORE	40
 
-#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
+/* Allow a device firmware upgrade */
+
+#define CAP_FIRMWARE_UPGRADE	41
+
+#define CAP_LAST_CAP         CAP_FIRMWARE_UPGRADE
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 40cebde62856..188318eefb41 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -28,9 +28,9 @@
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
 		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
-		"checkpoint_restore"
+		"checkpoint_restore", "firmware_upgrade"
 
-#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
+#if CAP_LAST_CAP > CAP_FIRMWARE_UPGRADE
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
