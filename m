Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAD2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 19:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uNCxZwV9GBhtg86QvI5W8yBAyojuMcuK+vDGpsIq32k=; b=eCbuvE9pl16Yt26pxONAzeRuri
	TMedCc+WZkMFOujbw86lVZpmA+CLV07BQzMr2JU76Dj/JopWi87cO4qJzEGWzhvLkOBrvzA0V1aeb
	iATxdJyAj2TcCEKEc8OxPwTj061blKVMRDrqsF9Bf64mW/k/43r7DB18mwMqJDJBz7qpSHCwwyUk8
	7/RuIolx5I/QL8Og417MVzva2/XJANzaJb4KfYq12NQHMYfadfLGGa4J5BdPAQfFk1mXqzWW+43xl
	D9dc+3WG/wyeOXfbMBa4YZRi89n96DUk10T96RuhrRFSz80CkR6FN5FdEGtjLkZMR/2Rv2KQ1+Q7O
	+LeO/Q+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHWGI-00FQZQ-JO; Tue, 08 Feb 2022 19:34:50 +0000
Received: from mail-dm6nam10olkn20829.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::829]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHWFv-00FQSf-FB
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 19:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp+JqrS/CTr1duksMJSxIMK4Uh4Xhb0bJ8jCniD9iqIcSuSFaIimMbweeeIRTxUvrMIUFmu8CQU6RPrGtNwPam6qcUsFpWA00T2CuYdeowE4x2DMzovIaFF+XWtBAD+uxdHu3PYQCyN0q4MsNWAm4DcRzrooJImZ8H9G6Sa6djfgwSbNdOGDheISaGburI1JjyKztVasmDaaKzxYFNoVDMntldoAApo/t1WmSEZHgoingU1L1moNtXUXijQNRbOPaSKUoT/r0z4CI+yps27U0bWMd2x6oe4CIGjFgV14ahWMCyQD19CujD+WtoIvdUgM1oH2fEy/Q+VsnCiXAWJR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNCxZwV9GBhtg86QvI5W8yBAyojuMcuK+vDGpsIq32k=;
 b=T9ve/hCPUV4SX9PkIU9pVSvacXpDuVVuE5oSO+lq8hqS3efEe+bwB8z05SkHAW3Zvk5f7o/yjCetdHglma4k/hHZ+64sBSensPp1uK/mS9mg7+GTwiPQZ3+xBM259laO0Hc5H/Y8zD3YOUdZcT9LNBxuTbp88Wr1D8BrmFttVc3Uy1AxYMiis017ndraH5Sy1dB4MI+4L/WQmkhcSDZRpi6rN/7tn+c0U5Pmqt5/NW36rw12q7cNXcJw4q9jErKvZn+jA4riCrPeWqOH8bCQD1TzMo5eAmWoKECq0bKcXiOxacektcB7Ah4Hm5nBWhvm8+H3Ec7/t1hH2LBBs2C0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNCxZwV9GBhtg86QvI5W8yBAyojuMcuK+vDGpsIq32k=;
 b=BNGQxzUmIUGrKsFVXmBP5QA/bRFx3P0SvlwNYHDDfbU1Zj4gwp6/38QHgb9BPy+jcgJdn9swIfps9iwfnAoBUQm6f0Um0y7iF1QsEdMXnAl4pLKehM4yz0iY+SmEeOJeJd6IZViJ8a0LIGLuCQ5u+pDgV+eYLGPku+P0B9wrtFLL2sdqept1N88z2uZQ2XWDwHNQ0skV99zuRHqrb/c6VFdxAesPthmkVWPofaL4XK4ffkYeLX7Fd80iIS/we4q7s81eLeBn6ZXmzcbvowyjlV3KOPenWOaymSlh6vpay9eyYLKcRRzKCJjwrST06uytKlUvCut+2mXtP9vJAD4rwA==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3805.namprd13.prod.outlook.com (2603:10b6:208:1f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8; Tue, 8 Feb
 2022 19:34:25 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4975.010; Tue, 8 Feb 2022
 19:34:25 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Date: Tue,  8 Feb 2022 14:33:46 -0500
Message-ID: <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208193346.22580-1-nitram_67@hotmail.com>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [bQz6wV58nFRQZWNrVPYpn4IBMG0++3c/]
X-ClientProxiedBy: DB6PR07CA0195.eurprd07.prod.outlook.com
 (2603:10a6:6:42::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220208193346.22580-3-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acc58537-809b-4f04-3a44-08d9eb3a0376
X-MS-TrafficTypeDiagnostic: MN2PR13MB3805:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1sUfh0IHy8pAdpsN22ykTBb36nYYnGrFDunWnZV9RyoUGKiBRp/PyJbjLX9EvcXl/PgfyIoU5mhjG2aT9vh4XSafZfvO9i3dFPR552QY4d5ANyQQWQUrl/tYNpsnNZHEDjglw87h5U3/y7R5mHxLVCeQLwIk390iMWG7RRt8orAhAyIx/O3J94ap58FiPd0UXdYJpBEOjgV8egNr0ShEX/tYC0qkyjMD7ot697EyVnmVT1pfVE7vEnmiO7zzVEil77BzOSjtupD2R1eW6iL0Ym8GHftbFdIGI7CIEe55cyOkTpF2J7wW5L+witypddbHseB1I0TFm8KGjpReZscb55TAlZx1fdOkWaH2VtIq91LAfnsXES3eObh8kb8hyhlI4fz0uptRVvJkJ4wBsX4nkK2z21oRo4RMYQgYJOfiFA40PKLxZy6P/7tMdvx2cTWJGX6dLNlkIn0pgealzGWiJCSiHvaDXRFnPXFD5BGL8tlp38fMWsq9XTWaLKB61e9eTrDTWsPGblwlh0Si/tv6xIiWsiUT6U73s+q80nVe/s2DzWQmvmcfn4sxSoeq4zAuI+xjRmWZq/NxvVc5UXZowQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2mZYlF20s+fkg2Kzjk6QRHU3Ncm6P/6/l24I6Nqjl7cFGvh8RRMVpYdEzDuI?=
 =?us-ascii?Q?hwDfBxlyGeGXmvFuMdQUOEfYIYNVr35SyvTxjtmGH5ce44LVL1i2Ovk/M57K?=
 =?us-ascii?Q?AdGZMgjq4JkGHY30uvrgFihu26zSCb8EFDp2iSPOPAPSG2/X5JVWZ1+aZ6cb?=
 =?us-ascii?Q?TA8KL5m7+2ruooXjtUOFe3sV3uQwKvWGwm1tb8M/HZwrE9snKcvXzGjQK8B+?=
 =?us-ascii?Q?nEMdhjiZCb9mxEqR2h4UKIvnbC0mwnd4hHvtSaxqfobYqwm9CSOKoZF18vT0?=
 =?us-ascii?Q?NsL0BWQYLLp8eBwbc32V5HDHsRG1riX1WlpxeNs590/ZCT4k1DkPmxdJTobW?=
 =?us-ascii?Q?A4fMZrKhpRCSLygxCc1OOKljJhe2GYWZ1Q2IwErn6VUQCon1kthcAIrFXUip?=
 =?us-ascii?Q?RHZ4CfF0LU8HmX3pIDYufAPCaGIj5sPrCla0mmRW+I3kNh2QH/A0diGoaYvP?=
 =?us-ascii?Q?3c1wLTrcsnwbOaBDyDnjBjL3pBuLhzQ01TE2q0KUBuNc2WMNEAZVBaSgWrov?=
 =?us-ascii?Q?kQ9nmgr0bnpASxhUQ/u93qq0wRrx/aEUT9s89ZJ4+qsyau4TL93u9ia1qmeL?=
 =?us-ascii?Q?9MvpsCdVF0zoLWQkrOUyUH01H0meno/WRkc/MSSkOLGG3O4DM9X7iURgzV99?=
 =?us-ascii?Q?Eopkaxv2RfnbCh2LCESPyXS7hdMN+TMBj0So399V39mx5y+ehU3kr97NNPjk?=
 =?us-ascii?Q?5uLkxj4XWHViVmIykRJK4tKtUuCqTrwqSAR0eaT3EIvXB3N42l0pX1InphKL?=
 =?us-ascii?Q?CsLWV3Bw0glxCQ4+dxWAHT6qG0w3yEvM/UXSHdp4u9bUqtrKWfN4RCJyp2jp?=
 =?us-ascii?Q?20ozpqqCSD574KuSBYYf8ijIFi+ijOdOwXd7YnXtSb/xhgkqmpJ/uTfBqsIJ?=
 =?us-ascii?Q?3EgdaSUpMykPU2Ou6nRCDKHC8gmd57CERTTPdFPWvCKKnl7sNA/OXRAf/lG0?=
 =?us-ascii?Q?jEku0rnQ30Qn7rGQXlssjg=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: acc58537-809b-4f04-3a44-08d9eb3a0376
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 19:34:25.4439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3805
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_113427_546719_7E0A55EA 
X-CRM114-Status: GOOD (  18.43  )
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

A note about the naming of this attribute:
Although TP8010 calls this attribute the Discovery Controller Type,
note that the dctype is now part of the response to the Identify
command for all controller types. I/O, Discovery, and Admin controllers
all share the same Identify response PDU structure. Non-discovery
controllers as well as pre-TP8010 discovery controllers will continue
to set this field to 0 (which has always been the default for reserved
bytes). Per TP8010, the value 0 now means "Discovery controller type is
not reported" instead of "Reserved". One could argue that this
definition is correct even for non-discovery controllers, and by
extension, exposing it in the sysfs for non-discovery controllers is
appropriate.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/core.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 include/linux/nvme.h     | 10 +++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b5e452aa3c0e..bb6ec2759e3e 100644
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
@@ -3523,6 +3526,40 @@ static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
 static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
 	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
 
+static ssize_t cntrltype_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	static const char * const type[] = {
+		[NVME_CTRL_IO] = "io\n",
+		[NVME_CTRL_DISC] = "discovery\n",
+		[NVME_CTRL_ADMIN] = "admin\n",
+	};
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->cntrltype > NVME_CTRL_ADMIN || !type[ctrl->cntrltype])
+		return sysfs_emit(buf, "reserved\n");
+
+	return sysfs_emit(buf, type[ctrl->cntrltype]);
+}
+static DEVICE_ATTR_RO(cntrltype);
+
+static ssize_t dctype_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	static const char * const type[] = {
+		[NVME_DCTYPE_NOT_REPORTED] = "none\n",
+		[NVME_DCTYPE_DDC] = "ddc\n",
+		[NVME_DCTYPE_CDC] = "cdc\n",
+	};
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->dctype > NVME_DCTYPE_CDC || !type[ctrl->dctype])
+		return sysfs_emit(buf, "reserved\n");
+
+	return sysfs_emit(buf, type[ctrl->dctype]);
+}
+static DEVICE_ATTR_RO(dctype);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3544,6 +3581,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reconnect_delay.attr,
 	&dev_attr_fast_io_fail_tmo.attr,
 	&dev_attr_kato.attr,
+	&dev_attr_cntrltype.attr,
+	&dev_attr_dctype.attr,
 	NULL
 };
 
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


