Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FF2C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v8KvQttFevL5r5KRufff604Qze0CTIPmrwKvnJrkZf4=; b=4B6RNF8HDEtqhbDtqJ+3f4bA59
	G6ntkBxovfu0O0sqndlWrrhWNnEpR0mS30/afawW5qzkbc/Zx6RZ+VmEMg/8dLk8Wxy0R7FXYPgd6
	L84NU5OnNsCiTCKW7dkqprWEwzd6Am5kzr+8rZ1uUVUOskg9aNbpGuG+86rrHayDbSZxh55mbRKXh
	t/+3X2Yr2XU4a4rTnZ0BzWkpU2E5xifqqb1xgttbfM+eh3QnzujRVrKN5FFtq25n5uuvVEAh9U/ri
	78VwEtllLC4lfywkJlBkV3EfEkHIddYMj/wdqXaPRZ5tjb16TlS2JhiozQwk9jKvFuCGixRc5TpXw
	kVDuXEcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFjVJ-002uo7-7L; Thu, 03 Feb 2022 21:18:57 +0000
Received: from mail-bn8nam12olkn2077.outbound.protection.outlook.com
 ([40.92.21.77] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFjUx-002uk9-8I
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 21:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp8MRZTDYwFVaxHXYbekm1eAlPpEFDJiXMXzrH0Zw1TipFRxOd+be8m8fxF4VMbjLUV4ygDsftUk9/LkIvSDgcd7Cy81VxMiTj2sQ1NDrBEcF/I2z09y7726ZqZwbIlLIV4XLQPMAebrB+oaD9MUrzSbGXXqoJwL+yfxk2+TVUodFzBFIJhnc84AqbvFKQMlK21qXlcWd+rkgNEhCkxw34xwuU9uI8AK0f1amuOWOZkDnnuGhENkNj4y/k7Gr2/NBth9CfMFu0pTsFoXEvJ11JhFacFl+G4d9iZPAIGKaJwVetWIeJVEsDLQ4NOT4QcVgphyEo7exdRUeq1j5FLftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8KvQttFevL5r5KRufff604Qze0CTIPmrwKvnJrkZf4=;
 b=gFhIntzFBNTp5A1ggleRE8sMAXIt7fyrJ3RTcPW+HlBo+m/b9t/uve034hNcXpm9BKqKcYNTV7+BLGvygGUWSZJBYeetXXWdEimeO0fEL+ERJwddpI4I790IsV6BNFo2lrlOfEmg8dQz+vlt+BH0gcuYjAuu8eQ+lYn8n8fryBqFbJe1qGHxPTNRwfW4XpU7XYWwlWar2kezI5FmjVAKbmIk1aihLqi0fKM6zHc1F7g6u8nvFesGPngZWzIcZ7Bl2bnw/XF5QH4BWlKxmpElGHVp2CaDbcHEz52p/ElyTREdlV8NciBhoAEsXLaGdluNB+zI+HL1N3YbvGTHHrpc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8KvQttFevL5r5KRufff604Qze0CTIPmrwKvnJrkZf4=;
 b=YMItKtcbKJEm/NjKqnqQ5GvzZM8pzVdpLpIdAMMID32tsVj5obFPUM7xHdMdPamOVr4TPGccWpGh5D4moW70R6ifz/02zPikvrcbiwuPEepvwhdfcJ+aI1koft5uWs/Erdv5QmO9/QfVDh223K/iL4X/iIfmH6GI7uDW3aMP9xi0KKbCEacN3oknVhx1e7RhgCnhkM23jUZCGQ3q8fW6XiYGYDpWLoXK/q1M9l87EtKVSLfmJh3f6AGk1LvHG43BiLxXifNBSVXDr6k7fjfsWpZQjhNIEllA3lIQiFGLy0Wwwprcj/NtQUImuyHxYLu1D3C4V/OPBmbogXCLl61SXQ==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by BN7PR13MB2500.namprd13.prod.outlook.com (2603:10b6:406:b4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Thu, 3 Feb
 2022 21:18:32 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 21:18:32 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, gregkh@linuxfoundation.org, rafael@kernel.org,
 charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCHv2 2/3] nvme: Add device_update_groups()
Date: Thu,  3 Feb 2022 16:17:47 -0500
Message-ID: <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203211748.27542-1-nitram_67@hotmail.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [W5Je0RDqkMc7N9+nuOQMn2zqGKn0Td6p]
X-ClientProxiedBy: SA9PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:806:27::28) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220203211748.27542-3-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8e04a21-2d90-4cfc-1ac7-08d9e75abb2d
X-MS-TrafficTypeDiagnostic: BN7PR13MB2500:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDb+V7m7UgMtmlP87Y3UK8nQZXigFBOsecA9dly1EEixsWGpMjF1yHRLqvaIYPdXyfsXm+hms3P/bHb6oh7jFeSPP+Qj7oo7lWdCia5xouosHaoeH9X/jCXd2hKdEKpOULdijP2wyXIR/HxZsgE5IrDa1k8tQulcjxlBftA8+dAQRgOgeXL40eaxstM0n8EEhcDjImXfMXJ0TitXhTEsikY9CIx3PlcuZZafKkasiJAvxEVcphyCcJ2fZyHV9F9Zloc8uu5OTdbKhJ0jZDTNNaGFE/nZBjVKSGR6MA1bh9w4IcyNvHnNA1VgcLSzXynUMhsKpQXWxktwBM/IiGenCMseyVNXhTMQg+aUyel9wVg+nIW/l3o7TNyk3v5sQS+O8jDdU9tL3wakzwgJbmxmiPDTb5rr6+xvqRHsS87U6nHGf4haAQgxlrRmXKfsYJgHVb77XYqWp8v4LjSxGjzh5ylwPfUDtjIYuIcSLH33o6Bdcm10yHrMrK0k//f09riMyw9lvx5kthvUgulCP5yCKOcytdPPi49/fdxGScKOcQ6RpctFSlbC8FtixeOOpFAxn6ZqZfrabfmn+0EcwWux6A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wN2lKky1Z40yylhgVjnlXCLC92YUssxAHZQfuLhua6REFSmhNIe8mdNeX+MT?=
 =?us-ascii?Q?rl5kwUo+hiKNBFXplzCZ3PF4n1/4xdSgwiX9ATLQ+qAX9l+jYhJo3O3Zj37r?=
 =?us-ascii?Q?EgEoUzEybLDfSfXOZVrfcaV/RG5FeTZqAZIrDo4BjlpMyxLXkJdAoanudsV0?=
 =?us-ascii?Q?MoB1dsl5gV0mI0gpY24qw3VxTvHAeNGOYDmgWP4uIQxHpf1rPhNQS0XUDuHU?=
 =?us-ascii?Q?/asME4ANVJCUXZEdg8pvyGZyRHTxxCbGNwiJKTIzlY4hSkhdQv6HKCMTnVaB?=
 =?us-ascii?Q?Obx5VWR2uuuPVPChM1J1PQ4Q/rJRfa+hhOhBUp9+bfxzBAxNBnBqpuKHFx3f?=
 =?us-ascii?Q?v9rlSgK3nqfT5rwbdvfMA8Kmp8IIVsb51x231fT+01iw/N8KJ2juh8GlRcUs?=
 =?us-ascii?Q?weaIRaUCJAgA8Q6+tQwdtZE+JN3i4gz4mQymJgc9qFDiEQCYjUGj+YaXbzdb?=
 =?us-ascii?Q?YNlgFmJeCs2/ODtBvPaC8r+w81awqaRg2Bqg4qPZ1oW5MMGjVsJheO7cedcc?=
 =?us-ascii?Q?32rt5eXKgtyY17j1o4Uvd1iXN1DOMZnE4tUbRALuazD4wQ8hZRHVXp6FOWt/?=
 =?us-ascii?Q?L896pnTFLgivbYHkVPUWKk5txRmogbWCFmVFc/K5rRBTlRHXfhVtzA9Rhx0k?=
 =?us-ascii?Q?QRwKG4U4gyJbBA90BziPwc0ucEi+EvexqoxfI8IbfhwttJlS+MmqiB8X6Q62?=
 =?us-ascii?Q?x1X/i0yX5PuErQcjRorTSGY8gVNZ3GQeg10wZDMAYxOEkl1o2yajTSYn2TMn?=
 =?us-ascii?Q?dStWgSI8Ih02zdiH04mVdy0uHyFuOTYvOzTyh9AS4l6nMJBGLMfjwM8j6BXP?=
 =?us-ascii?Q?smRKD1hOaNROtOilPHrsgirr3AfkOa2UEbJBzlBlBMG+Eydh/78q9G7AvndA?=
 =?us-ascii?Q?Gze8ny5qXj/LRXrua90y3nJNl68YhFQHwpezCczXa3L9CmOn9KXgZsqLQWHt?=
 =?us-ascii?Q?RgMeuRaob2cwjvYRs+ogKQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e04a21-2d90-4cfc-1ac7-08d9e75abb2d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:18:32.8784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR13MB2500
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_131835_323392_4A598FA8 
X-CRM114-Status: GOOD (  11.64  )
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

This is used to update the sysfs groups after device objects are fully
initialized.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/base/core.c    | 28 ++++++++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3d6430eb0c6a..0b5f6d5d2459 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4473,6 +4473,34 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+/**
+ * device_update_groups - update the sysfs groups
+ * @dev: device.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int device_update_groups(struct device *dev)
+{
+	struct class *class = dev->class;
+	const struct device_type *type = dev->type;
+	int error;
+
+	if (class) {
+		error = sysfs_update_groups(&dev->kobj, class->dev_groups);
+		if (error)
+			return error;
+	}
+
+	if (type) {
+		error = sysfs_update_groups(&dev->kobj, type->groups);
+		if (error)
+			return error;
+	}
+
+	return sysfs_update_groups(&dev->kobj, dev->groups);
+}
+EXPORT_SYMBOL_GPL(device_update_groups);
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
diff --git a/include/linux/device.h b/include/linux/device.h
index 93459724dcde..a623790173ce 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -841,6 +841,7 @@ int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,
 		enum dpm_order dpm_order);
 int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
+int device_update_groups(struct device *dev);
 const char *device_get_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
 			       kgid_t *gid, const char **tmp);
 int device_is_dependent(struct device *dev, void *target);
-- 
2.34.1


