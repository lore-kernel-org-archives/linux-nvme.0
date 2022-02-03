Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCBCC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 21:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lGtQxjO0qGL6ZJkgI5jxEX6JKkiEJc7TvqDkMwFbpgI=; b=C1gelpOjBjgWWyve9c7tcG6AWh
	8yifvDd3Wu3bNBWsnHlbfZeps1oyXW2m/zaSQNUAnC/Ijb3l/FA9c5ODXLNkuzNxnt1j4Go+wA91f
	ApihkkK+qnOByL5wRV2ii3zHo3fEwAXNrfW3OCWasG2j+FqV6YbIWqgagriVCH882CPuXGYUigQ+c
	kQunVIY4yig0nfXsUbr5ZtWwgH3A8lptLYpNmbaMhYzP6wZqL3SP0qlumq9mQSgqs9ABDUaoC2MUd
	OBm1c5WkS0/ZJuLIZHeiRlmQWl6LQi7jkdBeSc/ornYw9ivRtqsh7Yjd9zV2XMBbBMWibDyQaEPHq
	Vho/bSAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFjVV-002urz-69; Thu, 03 Feb 2022 21:19:09 +0000
Received: from mail-bn8nam12olkn2062.outbound.protection.outlook.com
 ([40.92.21.62] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFjV0-002ulB-Pb
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 21:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr1I8DL3nl4Nribq4NPS4rDFx7Qj6vXESiXN2Gjv+fTd7JlPQqsbgesf9lJL/xlvAO+Mt2+5+7DYMa8nvNOYcanJjupM5kFowgryfS/ttG5ZS8x23pzhmBB784J/Xj513CSVRbz3Y/qnNewyVxBzk4ejQKr330GT3xhdw+39hqNzSTxO9eUsOc0R1UXCezn0HsUjGc6aE7LT8jvq2vII80jf3M2YnvATlymmH/WmtwU9ZP4PZcHBmXdbW9Gs1HY9oBPtko2Y+GfnTK2pR/J7qTDjQjExLZ5+drA4w5dn9hLaRZ9MtYz1SGilnse3BtSDBTUaeT7pQ1XmO6YEIFMadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGtQxjO0qGL6ZJkgI5jxEX6JKkiEJc7TvqDkMwFbpgI=;
 b=Pw5EB5hzFIr+dTyr5jrqt7WVSCnU6awd63jZ2FTU8Tx2BsyfZ/LHgNvGXF12VHOHA4m27D60t/lVxdOwCFj8m4xx+u05BS7iVj/X+V4kwQCogT1bcCCw8MKev1TAORv1w6awG5lm31G5rtn0olpuzc4L59bbE1xHcDg2Ut869ICsBlhMiSzP1PjFxAYYf6+PpX2J9m8v1d6Stses31oniX/MTWIrbtarz1Cv1cS5ZezVeyIJO8YsuVt6ne8gyu5fCTdh/6a+tE7PXEGsdL1sdRSc7HS8ZLuIFg27I0B3dssTR67DyTEyNbRl58nA0GivL4+a7EZVwp0DeXDnSMR2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGtQxjO0qGL6ZJkgI5jxEX6JKkiEJc7TvqDkMwFbpgI=;
 b=vQdgCJVlLl989rVS2K81Pofn7CEL2sTuNosUDjzth09BEpKSoX9MPe5gTK0I4DlihL9WMGT0zUW+K4JPRAPqw43Oo9Q6t5bNUaDBSoUGa43EF45QiMZ5As+sRCuakuH9z7iEZeJyo6HUjS3SIOcVAngIaWl/4yayucUigd/QDAdauVdQCBp5/wzeGHO70TGkHy3rO1CllOazQK7CLo90So8YcvUKxCzcUESNzLKDxOXATfENFuk1X2tTyFLoN/qjbe2GAiZMr7MkO1DXTqWFyrsn6n2OW6JFuamLBXklk3jemDgwXRU9/Y20aUI2d+w7G7KvPH6t2IdLc1gTKS9vrA==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by BN7PR13MB2500.namprd13.prod.outlook.com (2603:10b6:406:b4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Thu, 3 Feb
 2022 21:18:36 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 21:18:36 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, gregkh@linuxfoundation.org, rafael@kernel.org,
 charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Date: Thu,  3 Feb 2022 16:17:48 -0500
Message-ID: <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203211748.27542-1-nitram_67@hotmail.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [NJ447Bhmp09f6E12mmvWsgZdIAJ0Jt/K]
X-ClientProxiedBy: SA9PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:806:27::28) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220203211748.27542-4-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c71d09a-1b65-45c0-9960-08d9e75abd1a
X-MS-TrafficTypeDiagnostic: BN7PR13MB2500:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6V8M6SLQlbwn9VHSXJNW26/N389Xv+Gp5UahJH/eBtzBEOuCKwupQsHyzMFAuCpItxDdebQTwPtMBZSM/XJs0U9f4KiDLST6IelvO/eNMT1XpoZ95xEvk4eBCXo2nuxsMnpLIrOVzvnfS4gytQcGV7aJmudH2yYLQmfmSiNtAIjPgP5WHtjhNPgHtOvPMnSxqfz0MzFop/j89yqk7sCONx0mmXlnhHvRlI/umRf0iO4Dh0IyVdLzxJ3SjeET7ZZOQDeVEVNAMPBqfSlfzWpx+d1fvikVEmKgdz1zFThKfeYWfjf3QWCsmwYNzC5b6kNI9EmEg2PKPXc7ZQFijmgOeU75CEzw1+2m5TuMFdOOJQ0jVdG8bkmS6dCpHnvtsNT6OeB935SMadQjbaPIUqNHyNyf3v0X0vt2L2zRn6h+9NtdTZrtTvXgyLfxygNah0JumZ/XKGW8lWIx4dTWeDDLbH7WWDkNzGGJMCVBQDl1sJMQ6rnhgKSRgGcFVlnxOaYPCCOI6TofZbShu6opM69CQJMvHbJYGtiuko3TVsa4evAxDJt5oGhs7fAx8H8ODafr0HHdw+1PAfGZuRe4PHId/Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZJmMaQuJK5gKoWeJz2BhCYvgoQ6+XQkRUv71gLkpa5bdliWVhfQmzKrmhiL/?=
 =?us-ascii?Q?jhHr+cs4+aR8HJSL3LRMiNtJSryqWMlAyjMatUO3JkYpuJjgEqO4RPA2awLt?=
 =?us-ascii?Q?GhmHK9uISLyEnAf1bszRrpK4NklH8Qw3OA0a/vCP1IWs+Twdaf+UoMvkz2aB?=
 =?us-ascii?Q?SxOon3+RMsSwCVHWogg+xjnhJmvaa2CJXbikZM6D9sJKZf1nDWJJEWXpFL8n?=
 =?us-ascii?Q?xlFUfZXzztaDiFlRPUMGQ6hdgo2Sbq/exdMOYj10GgbMfLbJ49GkXuMUeX0y?=
 =?us-ascii?Q?hctsjykhfpI1TPDgfGND3pJKPWQjJ1ccavA7EU7NBZJK6EQpFfpap/bPzeIO?=
 =?us-ascii?Q?PAxhOaznvf2DqQjBRHjTBL1n/PgwDIGCgSiZA12OrUYH3bS2MmXgpD7n6+cy?=
 =?us-ascii?Q?GVkCz5DldvJh3Bu2JAjQu7J9ns0cGhCRefmsCXglb4grf/8svayGR5XJafCA?=
 =?us-ascii?Q?rJpSTqM2JeCjmWD0FFSlvWeByKkewpaK4QX6rQroDxq5QTac5qjpgXRZe7bZ?=
 =?us-ascii?Q?eiz6bdNb9WNgTr/Ir5e+o1D9ESd66FsbwzxfAN+86vZN24FRBTWUzJBClePY?=
 =?us-ascii?Q?g8WXLVJfykEkfRsw0QjZI8QGVBiv0x2S1kzlsOYMQKgC8Ws7OAOUwDrQd1Tv?=
 =?us-ascii?Q?goHTiBTlS++Ce9IoaC7sefRb/o/CSSPE/uAloifcc4x0LFebvWPRfsnDHp15?=
 =?us-ascii?Q?ZyrH+ZXQiVMZcwk6Y9rHwYxTYH2qZrSAt/sEbi6tqfCTtBcyNQymKaozF6O+?=
 =?us-ascii?Q?HFoHBTGSu12ltO59/6dkeisub5R2O+fOeCHoAiz5j6k5b+zFFjESJ9Umyoqf?=
 =?us-ascii?Q?VtK13I3N99xHNM4m76xMCY09S8lEAuWySlJto/RKgDqp9l29UzdqwYFs3gEZ?=
 =?us-ascii?Q?6l0mmFX+cU2RI/U1QpoutMCPfixtZBswdME0eZuklHvoD9nu4Yxrk3xCV8hH?=
 =?us-ascii?Q?9w1VMrpxrbf3Jx+bvzfBTA=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c71d09a-1b65-45c0-9960-08d9e75abd1a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:18:36.2376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR13MB2500
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_131838_861997_6715795F 
X-CRM114-Status: GOOD (  17.68  )
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

From: Martin Belanger <martin.belanger@dell.com>

TP8010 introduces the Discovery Controller Type attribute (dctype).
The dctype is returned in the response to the Identify command. This
patch exposes the dctype through the sysfs. Since the dctype depends on
the Controller Type (cntrltype), another attribute of the Identify
response, the patch also exposes the cntrltype as well. The dctype will
only be displayed for discovery controllers.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/core.c | 45 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 include/linux/nvme.h     | 10 ++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b5e452aa3c0e..4e3db5ec3924 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2990,6 +2990,9 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
 
+	ctrl->cntrltype = id->cntrltype;
+	ctrl->dctype = id->dctype;
+
 	if (id->rtd3e) {
 		/* us -> s */
 		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
@@ -3115,6 +3118,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 			return ret;
 	}
 
+	ret = device_update_groups(ctrl->device);
+	if (ret)
+		return ret;
+
 	ctrl->identified = true;
 
 	return 0;
@@ -3523,6 +3530,40 @@ static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
 static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
 	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
 
+static ssize_t nvme_ctrl_cntrltype_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	const char *type[] = {
+		[NVME_CTRL_IO] = "io\n",
+		[NVME_CTRL_DISC] = "discovery\n",
+		[NVME_CTRL_ADMIN] = "admin\n",
+	};
+
+	if (ctrl->cntrltype > NVME_CTRL_ADMIN || !type[ctrl->cntrltype])
+		return sysfs_emit(buf, "reserved\n");
+
+	return sysfs_emit(buf, type[ctrl->cntrltype]);
+}
+static DEVICE_ATTR(cntrltype, S_IRUGO, nvme_ctrl_cntrltype_show, NULL);
+
+static ssize_t nvme_ctrl_dctype_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	const char *type[] = {
+		[NVME_DCTYPE_NOT_REPORTED] = "none\n",
+		[NVME_DCTYPE_DDC] = "ddc\n",
+		[NVME_DCTYPE_CDC] = "cdc\n",
+	};
+
+	if (ctrl->dctype > NVME_DCTYPE_CDC || !type[ctrl->dctype])
+		return sysfs_emit(buf, "reserved\n");
+
+	return sysfs_emit(buf, type[ctrl->dctype]);
+}
+static DEVICE_ATTR(dctype, S_IRUGO, nvme_ctrl_dctype_show, NULL);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3544,6 +3585,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reconnect_delay.attr,
 	&dev_attr_fast_io_fail_tmo.attr,
 	&dev_attr_kato.attr,
+	&dev_attr_cntrltype.attr,
+	&dev_attr_dctype.attr,
 	NULL
 };
 
@@ -3567,6 +3610,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
 		return 0;
+	if (a == &dev_attr_dctype.attr && ctrl->cntrltype != NVME_CTRL_DISC)
+		return 0;
 
 	return a->mode;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..e30626c00791 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -349,6 +349,9 @@ struct nvme_ctrl {
 	unsigned long discard_page_busy;
 
 	struct nvme_fault_inject fault_inject;
+
+	enum nvme_ctrl_type cntrltype;
+	enum nvme_dctype dctype;
 };
 
 enum nvme_iopolicy {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 855dd9b3e84b..21e92e97ca88 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -43,6 +43,12 @@ enum nvme_ctrl_type {
 	NVME_CTRL_ADMIN	= 3,		/* Administrative controller */
 };
 
+enum nvme_dctype {
+	NVME_DCTYPE_NOT_REPORTED	= 0,
+	NVME_DCTYPE_DDC			= 1, /* Direct Discovery Controller */
+	NVME_DCTYPE_CDC			= 2, /* Central Discovery Controller */
+};
+
 /* Address Family codes for Discovery Log Page entry ADRFAM field */
 enum {
 	NVMF_ADDR_FAMILY_PCI	= 0,	/* PCIe */
@@ -320,7 +326,9 @@ struct nvme_id_ctrl {
 	__le16			icdoff;
 	__u8			ctrattr;
 	__u8			msdbd;
-	__u8			rsvd1804[244];
+	__u8			rsvd1804[2];
+	__u8			dctype;
+	__u8			rsvd1807[241];
 	struct nvme_id_power_state	psd[32];
 	__u8			vs[1024];
 };
-- 
2.34.1


