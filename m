Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A372EC388F9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 22:34:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D2024658
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 22:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2lDSB38M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=micron.com header.i=@micron.com header.b="Pg5LVvvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D2024658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=micron.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vM/SAqkzMbn+RkC2FNB55X+mELPjfx5mIDBF2B1U8oY=; b=2lDSB38MBQZqyCP/hJ01dnnLd
	0f2uvmm2zj62udDX/CTavsFV2LaxOu//nwa1EpRLcf5WnR9VMHMBJgkLOREiRjYtm0fKfuVUxrPfG
	aWACtk0E6l3xO89KvgPTEv10AglB7xFTpugvY2CwEDjWMF2nu/X/a+agpPt9Tb6fXE1+7NFESwHOp
	JMLivgTsQ0PzG3xHe9h6v9TXuZjtydVHHkXZ05jqBesKo1xdJ7skY21raQc8nqr8tiyBwVYNUANhs
	/KHSwhLvTVI8Z6eMThgNmKVxlEomb9s1B2G5V7SBVSSIps8v6HetoV+SRhV+Ow6d5EjtKEHe5jA4m
	6CnpHlkeQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVjAT-0001QD-EB; Thu, 22 Oct 2020 22:34:45 +0000
Received: from mail-bn7nam10on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::617]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS0gN-00028h-Sw
 for linux-nvme@lists.infradead.org; Mon, 12 Oct 2020 16:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DobY1eonkuBCz7PBnzndXqzziGKowCM+8WzMZ8XMLYNDT/4nud10X2+d47dFfT14L4xUQ+QroqZVspC4Wl8N8Vh3OhNZxoRrgJNxPOeCSmo39UWqV1qEHlATsphsH5D6zlnJh1KcuXi47Xhz9hrzfdlVPN9EIQyBIRbCIJXreXObV8wgx2pudr394tiqZfwWhtTgo0TBMT8MikTS+B2tNtrXCZ6ttof9T60cwoIbsZCKtskqhgUaaXwLjowWSzld0+zKb5RUlfRbY9OAcDK/Z9p7esnlmyJYmu3FtfODVfzylGGHkPEzYjGWsIhJfwEVSyh01KGzj1umJcXVWCZOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sivWVj8YgbRrfOJAgLwrFfWRzrHH9/DNTTC+ioRFJA=;
 b=EffTEHYmx7LuiixntXumvHPACi5rNqUA7RkXZ3JnuXGv2FHuSZqR920X226elwDJE3H8bC9fiz2O6ZGOdbMLPF/hNciCppW8imoBu4pUJx4Z8tV2q0fn4sTlEtjmSRNG2gYseDioR8y2Dxrq/52DRtyh/r9j4yzVuY+t+WGgFXLsJRKkicScbiAJqVmXALKdwcICx0Ozrsb7+JoEZyMjyaQOMva8Yiw/BaFMtQmuDe7nAUSzrxp+0rBUWSl7SnZ80FHSQP1EQvAXWVUC/ZLIlTB2gmn4yS8eAGVyhmtCJ/g8PR1yKo9jnd1IRZSPRloFnDwnzrr1T0Xivf8WZrlrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sivWVj8YgbRrfOJAgLwrFfWRzrHH9/DNTTC+ioRFJA=;
 b=Pg5LVvvSxgRZmqhC3YGVrwZLx9z7aP9+lqBM/y3pW955T+8n9f0GRB978qg2VX7v5y0p62BPTcTittry2Zles5QRgBtnwBgTKIhkcM+gP0rmf8uectmH8YjKdWy/XV7vjsANSwCQEqZQIFL5hwiMnjcKbIY87+LYrlUNHRF/ASY=
Received: from SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) by SN6PR08MB4975.namprd08.prod.outlook.com
 (2603:10b6:805:69::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Mon, 12 Oct
 2020 16:28:15 +0000
Received: from SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::5a) by SN4PR0201CA0056.outlook.office365.com
 (2603:10b6:803:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org;
 dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT015.mail.protection.outlook.com (10.152.65.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:15 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:28:12 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-nvdimm@lists.01.org>
Subject: [PATCH v2 21/22] mpool: add documentation
Date: Mon, 12 Oct 2020 11:27:35 -0500
Message-ID: <20201012162736.65241-22-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--12.530700-0.000000-31
X-TM-AS-MatchedID: 700076-701429-704961-703215-701479-188019-701480-701809-7
 01280-703017-702395-700954-704978-702754-703588-702638-702617-704599-703140
 -703213-121336-702688-703226-700958-704714-701073-703361-705279-704726-7032
 30-700863-702719-703080-704418-700010-703640-139705-780058-701321-703415-70
 1880-704500-701510-703812-705244-702783-704959-700335-703414-704841-702779-
 703851-703700-704965-148004-148036-42000-42003-190014
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ab65a47-ae5c-4171-8ed8-08d86ecbd209
X-MS-TrafficTypeDiagnostic: SN6PR08MB4975:
X-Microsoft-Antispam-PRVS: <SN6PR08MB4975AB6F3A650F1E583FA083B3070@SN6PR08MB4975.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNeAA2vfbec9Q0oNgrz7RLak097ELWklUP/tMuDW85t/AGBL8flitqm60aaWOTVLjRZeKLi9js1CXAn3IfGPx/DqF2o0HJ+nuUfJ+y9oNixUr66gCD+kc7MyDAPV5OUpAj9mHtYt7Pp+usqKC43O6aBu2LEe3TAAk+CYoM7urGEtceUuXj7E7TZ+H9criVcZa2TQwTKSmqnc9+Hy5Uc3OIPXwH7/lREIay4PZ/xJsIG82WHo4yY+aOFBvY6KzpSqVDi/03tgYGtlYngBAtoJ2RaAxWxBpTiZtkvd6QRzhWWqAXV6+vqPED2GyHk5p0w3TcLrnhIQLvQOJOThzBb38aF/ZTyRPY+b9e+96k5peivjRHBwnt72TugdA1tXfw+FvOlaHWOI8x+Sm5MQpuMeIIE98WRx/ywJjT1YxgQ792Hb9aDX1BQVR1oGOc0PEZP4aXqpWZTeyZGkwzxPtXGt17w+rHw+w5FrEi3GRgzdM68=
X-Forefront-Antispam-Report: CIP:137.201.242.130; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.micron.com; PTR:masquerade.micron.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966005)(316002)(54906003)(6286002)(186003)(82310400003)(26005)(55016002)(82740400003)(336012)(8936002)(7636003)(70586007)(110136005)(70206006)(5660300002)(7696005)(356005)(83380400001)(47076004)(2906002)(478600001)(6666004)(86362001)(33310700002)(8676002)(426003)(36756003)(2616005)(1076003)(4326008)(107886003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:15.2484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab65a47-ae5c-4171-8ed8-08d86ecbd209
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f; Ip=[137.201.242.130];
 Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4975
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_122820_007411_E65C09F8 
X-CRM114-Status: GOOD (  14.27  )
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
Cc: plabat@micron.com, smoyer@micron.com, jgroves@micron.com,
 gbecker@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This adds locking hierarchy documentation for mpool and
updates ioctl-number.rst with mpool driver's ioctl code.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  3 +-
 drivers/mpool/mpool-locking.rst               | 90 +++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mpool/mpool-locking.rst

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2a198838fca9..1928606ff447 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -97,7 +97,8 @@ Code  Seq#    Include File                                           Comments
 '&'   00-07  drivers/firewire/nosy-user.h
 '1'   00-1F  linux/timepps.h                                         PPS kit from Ulrich Windl
                                                                      <ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
-'2'   01-04  linux/i2o.h
+'2'   01-04  linux/i2o.h                                             conflict!
+'2'   00-8F  drivers/mpool/mpool_ioctl.h                             conflict!
 '3'   00-0F  drivers/s390/char/raw3270.h                             conflict!
 '3'   00-1F  linux/suspend_ioctls.h,                                 conflict!
              kernel/power/user.c
diff --git a/drivers/mpool/mpool-locking.rst b/drivers/mpool/mpool-locking.rst
new file mode 100644
index 000000000000..6a5da727f2fb
--- /dev/null
+++ b/drivers/mpool/mpool-locking.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+Mpool Locking
+=============
+
+Hierarchy
+---------
+::
+
+  mpool_s_lock
+  pmd_s_lock
+  eld_rwlock          object layout r/w lock (per layout)
+  pds_oml_lock        "open mlog" rbtree lock
+  mdi_slotvlock
+  mmi_uqlock          unique ID generator lock
+  mmi_compactlock     compaction lock (per MDC)
+  mmi_uc_lock         uncommitted objects rbtree lock (per MDC)
+  mmi_co_lock         committed objects rbtree lock (per MDC)
+  pds_pdvlock
+  pdi_rmlock[]
+  sda_dalock
+
+Nesting
+-------
+
+There are three nesting levels for mblocks, mlogs, and mpcore's own
+metadata containers (MDCs):
+
+1. PMD_OBJ_CLIENT for client mblocks and mlogs.
+2. PMD_MDC_NORMAL for MDC-1/255 and their underlying mlog pairs.
+3. PMD_MDC_ZERO for MDC-0 and its underlying mlog pair.
+
+A thread of execution may obtain at most one instance of a given lock-class
+at each nesting level, and must do so in the order specified above.
+
+The following helper functions determine the nesting level and use the
+appropriate _nested() primitive or lock pool::
+
+  pmd_obj_rdlock() and _rdunlock()
+  pmd_obj_wrlock() and _wrunlock()
+  pmd_mdc_rdlock() and _rdunlock()
+  pmd_mdc_wrlock() and _wrunlock()
+  pmd_mdc_lock() and _unlock()
+
+For additional information on the _nested() primitives, see
+https://www.kernel.org/doc/Documentation/locking/lockdep-design.txt.
+
+MDC Compaction Locking Patterns
+-------------------------------
+
+In addition to obeying the lock hierarchy and lock-class nesting levels, the
+following locking rules must also be followed for object layouts and all
+mpool properties stored in MDC-0 (e.g., the list of mpool drives pds_pdv[]).
+
+Object layouts (struct pmd_layout):
+
+- Readers must read-lock the layout using pmd_obj_rdlock().
+- Updaters must both write-lock the layout using pmd_obj_wrlock() and lock
+  the mmi_compactlock for the object's MDC using pmd_mdc_lock() before
+  first logging the update in that MDC and then updating the layout.
+
+Mpool properties stored in MDC-0:
+
+- Readers must read-lock the data structure(s) associated with the property.
+- Updaters must both write-lock the data structure(s) associated with the
+  property and lock the mmi_compactlock for MDC-0 using pmd_mdc_lock() before
+  first logging the update in MDC-0 and then updating the data structure(s).
+
+This locking pattern achieves the following:
+
+- For objects associated with a given MDC-0/255, layout readers can execute
+  concurrent with compacting that MDC, whereas layout updaters cannot.
+- For mpool properties stored in MDC-0, property readers can execute
+  concurrent with compacting MDC-0, whereas property updaters cannot.
+- To compact a given MDC-0/255, all in-memory and on-media state to be
+  written is frozen by simply locking the mmi_compactlock for that MDC
+  (because updates to the committed objects tree may take place only while
+  holding both both the compaction mutex and the mmi_co_lock write lock).
+
+Furthermore, taking the mmi_compactlock does not reduce concurrency for
+object or property updaters because these are inherently serialized by the
+requirement to synchronously append log records in the associated MDC.
+
+Object Layout Reference Counts
+------------------------------
+
+The reference counts for an object layout (eld_ref) are protected
+by mmi_co_lock or mmi_uc_lock of the object's MDC dependiing upon
+which tree it is in at the time of acquisition.
-- 
2.17.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
