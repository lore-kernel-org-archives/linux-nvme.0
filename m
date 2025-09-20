Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62AECAC5A7
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Sep 2025 23:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hd9PnaUG55abxDlaXLv81qMnX+k7eIzyw6FWVKR6X7s=; b=OI7vEPdLfL3w+CSV4p1pp9v1bZ
	5vcZliKWLGhUVoJNWWriE8nbICtXUy09a9K1PXRCPz0xz/5g5fsHXX7O6bPXuZ/LF+gvf2Yu0ww2O
	RK1S7NpJ7rh0nydlJhNDiJhBfOXwX10L1+ma1E2gN18ddFK9rSEbGPNHU6Jjgl8kcvrrjofhiG7uD
	9Cu7B1GgmkuNVgoJdT5pcmFOHnGX9UkgdT3wlehtUCFO1xBplP4UuBnEgsf/ccdgm9PulOsSEUjD4
	rAo3KQf0/KaGMltICrCEkN5xr0o+UqlsnOs36FzgdPg9ETdZCT4/GeshmvADljLGLcbN4oLhvyphc
	iZD8632A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v07LL-000000065Xv-0AzO;
	Sat, 20 Sep 2025 23:50:15 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v07LI-000000065XC-3aaZ
	for linux-nvme@lists.infradead.org;
	Sat, 20 Sep 2025 23:50:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ+/ikuHjAiTTwqJSmIvAdRODj0w5eHNt0kLQHHFVyFxSX95xnJKCjxHIeSHof+oxsXuEBkXgiSfBcHR7BXfvUsKoF/xRGQfONbmrXq4p9kc4cjf8MkT9Ee1U0Slwlfk+ifNxolpDC8PKwoJX3k7H0tNbUJbAkattTVzXohIc4iELPTGhESLKZvoEmLWgfFu8pYaZKtyXv1hAg/s3cJ8YOZTMwIcxqRr2lnQcQuFBZzyMZVKX+eEnkO2EYLehxmDDH8aMgd9mDj1XSkgAPK+iB/+fcoSIaxLsu44GtZUOCWvq5VKOz++RCoZzgqwgIC/w0QA/D/ejuq1GfWW9T3a0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd9PnaUG55abxDlaXLv81qMnX+k7eIzyw6FWVKR6X7s=;
 b=IXmwQkFxlI1gElAmrZg7zXos+zpa86fwx7Ur6mu+6ZTiJm33SC2hINfKeAd8yXNXSF4pgxcEI/fojPuILmzbqu6skLfUIpEGtMA29TaoPqtKlPonVvF3Qgj6fU++5Xf1mwkGvSBCdmwKktI/4qGAz/U0aBjy3xGURpZqQIzHmyjSvoZNSxtWqGGkRlRwp4zflQeyrjcf4zYE8FerFbPVEPIVrDZ1R74N376uwL5jOk8SG4q+JD4C6iv14Zw7MdHB2YhNNIx8YdHeKvLOr+Uh4byfVnxXVqXQehs78zlrhb6O2XNAAY0kdRXC3PIWIznSrkBkQ2B9H1e0SZCczyBuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd9PnaUG55abxDlaXLv81qMnX+k7eIzyw6FWVKR6X7s=;
 b=h1t1URZcjNPGWzi9jMgs7DuRINrH6OyOJ/hYvKlPkti0jMU2RSJoUt3kEBlS0RjxYHAQ5PrCRKIOba62TtVeC/xvzB/bxSd0uhWcMxo4HK7VnnpD6Ncc+DIEOQzejAyFx+u3m+m51ppotRBGAazMNO4e+HOgBI3Z57q47oG9DShRoGEw1uyC47aVXvuXoIvrK9PmzG0tEeeBShE/XisjT8XffSMB/uwpqKeIYhfNvN4+N4fAvEtJdjxTuQXFqILN1LYuSCPzzvOziM+AMSv7Eq5SVTwbssrPKaTIDl0iwhXaqLKCMbn17c7jUTKIwzRYS4y7IifpUqAMgcn5HY9TRQ==
Received: from BY5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:1d0::18)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Sat, 20 Sep
 2025 23:49:53 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::ad) by BY5PR04CA0008.outlook.office365.com
 (2603:10b6:a03:1d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Sat,
 20 Sep 2025 23:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Sat, 20 Sep 2025 23:49:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 20 Sep
 2025 16:49:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 20 Sep 2025 16:49:51 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 20 Sep 2025 16:49:49 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/3] nvmet: replace transports array with a linked list
Date: Sun, 21 Sep 2025 02:49:43 +0300
Message-ID: <20250920234943.4959-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250920234943.4959-1-mgurtovoy@nvidia.com>
References: <20250920234943.4959-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: bca65d10-5825-402d-f192-08ddf8a06482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8grj4ftts1c2zbA3hFx0GM1+16zDnxHa3gpyz91uBfvwvnVQLHSMH2pO23/g?=
 =?us-ascii?Q?rrpGxSq4ptm8PPi3hWlJV/tZH5Akphn/1aWkfTQxZ92y1rUE3PcH+Gad+Q8b?=
 =?us-ascii?Q?c2FbZt+yAKn5ic6GzRhDg6glFvT0GoyflJ2gWUVRWNqCDYIj+vT2YEE69fmz?=
 =?us-ascii?Q?2Pmy7TpWT9c8UE3Av5xJfMVEtSAtdxA7s2v00xKtTvxbUJn867ljOyxFRq5s?=
 =?us-ascii?Q?iQ/y6Bh39qisc/yRBsLPD7LDNW2ZG1MXGOTBRraWeD/kuKi+NmLDOtN1uR3Z?=
 =?us-ascii?Q?MEtS263lrNanDTSltCrHNOdU2zu+CRDOlAxoNlk0lJSi4Gtn+vGTk3FEDJHS?=
 =?us-ascii?Q?TS3dunW0EcFJH2bAF4r1OplmFdkaCMKvjGEtn+EwtcDwzfPS8ap8aib5N1Tp?=
 =?us-ascii?Q?RjKsb/05qM7m5EwueZRiOxLQ2HCPq1Uq5HSYpEk3bR1Ds1+aeJb5uEbejqNw?=
 =?us-ascii?Q?kBWUK7CxQVbKAtHfD3ebzZTpMesSPcR7ShSvoTnGNz0HCNdbqOjN+pYRqBN0?=
 =?us-ascii?Q?NvI2Qgpqo1LkAiPGUVSQvUzyMDMn+6CWHXouqgZAGdZO6bkavQLmP4XOE35s?=
 =?us-ascii?Q?euNsHm/WaPP5ZOYDtYeXTUY1TPW7bZHLk9ZlNvjyYmxbnp5de7orzk0gyg/L?=
 =?us-ascii?Q?RBPaQXJ7exAx5BDb31nJU+hQB06ZyLKm62jk3pJAt9v1tZ35a0Oy0cnHpkq7?=
 =?us-ascii?Q?TV9no3sk8rIsPyOK/OITpkqaQIo+OV68WIaqY+RCTioWA26C78fnWmlIEDDY?=
 =?us-ascii?Q?nM9vTMSzvajQGTs4w3lXGx1drHJVKAsD07eZJc7yG/mNDbYknqNGvV56WiqR?=
 =?us-ascii?Q?ld0MQwSc/WEWAA98QQJqvzs6/XepVJ7/qOpa9oIin8QcuniqkXoRW0buogBn?=
 =?us-ascii?Q?Rw2UBHGveG8XZVXLcda55G1ZjS1w9j6PTpqkEe6TAaDN+9rcYhU8NdRniuoA?=
 =?us-ascii?Q?jY5ajWWLSmP0SPjklqOMY18abYtki/o2JxEBr5cq8M6FpJrXgU7KBWAsrwIV?=
 =?us-ascii?Q?XCEGGR3FLgaNdiwgwKBIKkL3Lbxll6yTpyDUxLxh9Xw1jiAHV8CC1djR6JCX?=
 =?us-ascii?Q?KW40zLMBpAvmRYkJAqB5HkW2bnW+02N8mYWqH1VNkL6RfFe+k6nYTFr2JHSa?=
 =?us-ascii?Q?akwO0m6ZMs13RRRGKZUjlnktl0Da2pCuPs6ck1xfCQjXQM5qElmR3fRl62o2?=
 =?us-ascii?Q?MJ8ivupdkYYkbNQz1e6SC1khCuMHjfj55Uf/9znQTaary4Y4SHC8PtbOOj7o?=
 =?us-ascii?Q?on1GsY+r1W1dPk2WnkXScKU8+TLuwyM3o44/IkhYIbq5UtWENQfUKPosdo9W?=
 =?us-ascii?Q?R6vfjLhSGIFGCKOI5ATKHlum7CbW7aYK9XXy/mfAucHmDhg9d6qyE0ubsatK?=
 =?us-ascii?Q?WTDY0X3cIXrFmQ0ahrprm2Hdm2cRF0sQIMRk13vBvEKVO2no4cBYG75Vi39e?=
 =?us-ascii?Q?3dycGyiXhPuqe3S9LHvrVyqnV6WJgocvmLxhoRFQDfImI8O2m8TVgBy5+M9K?=
 =?us-ascii?Q?EjcSukvwH2IbqQiTQCHIgQEUwQj9l0zA4Q1q?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2025 23:49:52.0973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca65d10-5825-402d-f192-08ddf8a06482
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_165012_978378_DBD13A3F 
X-CRM114-Status: GOOD (  17.40  )
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

The nvmet_transports array was sized to 255 (NVMF_TRTYPE_MAX), although
only up to 5 transport types can ever be registered, resulting in
some unused memory. This change replaces the array with a linked list to
store registered transport ops, substantially improving memory
efficiency by allocating space only for active transports.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c    | 48 +++++++++++++++++++++++++----------
 drivers/nvme/target/fc.c      |  4 +--
 drivers/nvme/target/loop.c    |  4 +--
 drivers/nvme/target/nvmet.h   |  5 ++--
 drivers/nvme/target/pci-epf.c |  2 +-
 drivers/nvme/target/rdma.c    |  4 +--
 drivers/nvme/target/tcp.c     |  4 +--
 7 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f31c7fa70740..7ee12819e2b5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -21,7 +21,7 @@
 struct kmem_cache *nvmet_bvec_cache;
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
-static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
+static LIST_HEAD(nvmet_transports);
 static DEFINE_IDA(cntlid_ida);
 
 struct workqueue_struct *nvmet_wq;
@@ -37,7 +37,7 @@ EXPORT_SYMBOL_GPL(nvmet_wq);
  *  - per-subsystem allowed hosts list
  *  - allow_any_host subsystem attribute
  *  - nvmet_genctr
- *  - the nvmet_transports array
+ *  - the nvmet_transports list
  *
  * When updating any of those lists/structures write lock should be obtained,
  * while when reading (popolating discovery log page or checking host-subsystem
@@ -275,25 +275,46 @@ void nvmet_port_send_ana_event(struct nvmet_port *port)
 	up_read(&nvmet_config_sem);
 }
 
-int nvmet_register_transport(const struct nvmet_fabrics_ops *ops)
+static struct nvmet_fabrics_ops *nvmet_lookup_transport(unsigned int type)
 {
-	int ret = 0;
+	struct nvmet_fabrics_ops *ops;
 
+	lockdep_assert_held(&nvmet_config_sem);
+
+	list_for_each_entry(ops, &nvmet_transports, entry) {
+		if (ops->type == type)
+			return ops;
+	}
+
+	return NULL;
+}
+
+int nvmet_register_transport(struct nvmet_fabrics_ops *ops)
+{
 	down_write(&nvmet_config_sem);
-	if (nvmet_transports[ops->type])
-		ret = -EINVAL;
-	else
-		nvmet_transports[ops->type] = ops;
+	if (nvmet_lookup_transport(ops->type)) {
+		up_write(&nvmet_config_sem);
+		return -EEXIST;
+	}
+
+	list_add_tail(&ops->entry, &nvmet_transports);
 	up_write(&nvmet_config_sem);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(nvmet_register_transport);
 
-void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops)
+void nvmet_unregister_transport(struct nvmet_fabrics_ops *ops)
 {
+	struct nvmet_fabrics_ops *fops, *tmp;
+
 	down_write(&nvmet_config_sem);
-	nvmet_transports[ops->type] = NULL;
+	list_for_each_entry_safe(fops, tmp, &nvmet_transports, entry) {
+		if (fops == ops) {
+			list_del(&ops->entry);
+			break;
+		}
+	}
 	up_write(&nvmet_config_sem);
 }
 EXPORT_SYMBOL_GPL(nvmet_unregister_transport);
@@ -323,12 +344,12 @@ int nvmet_enable_port(struct nvmet_port *port)
 	if (port->disc_addr.trtype == NVMF_TRTYPE_MAX)
 		return -EINVAL;
 
-	ops = nvmet_transports[port->disc_addr.trtype];
+	ops = nvmet_lookup_transport(port->disc_addr.trtype);
 	if (!ops) {
 		up_write(&nvmet_config_sem);
 		request_module("nvmet-transport-%d", port->disc_addr.trtype);
 		down_write(&nvmet_config_sem);
-		ops = nvmet_transports[port->disc_addr.trtype];
+		ops = nvmet_lookup_transport(port->disc_addr.trtype);
 		if (!ops) {
 			pr_err("transport type %d not supported\n",
 				port->disc_addr.trtype);
@@ -2006,6 +2027,7 @@ static void __exit nvmet_exit(void)
 	destroy_workqueue(buffered_io_wq);
 	destroy_workqueue(zbd_wq);
 	kmem_cache_destroy(nvmet_bvec_cache);
+	WARN_ON_ONCE(!list_empty(&nvmet_transports));
 
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a9b18c051f5b..58dfb658453c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1932,7 +1932,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 
 static void nvmet_fc_fcp_nvme_cmd_done(struct nvmet_req *nvme_req);
 
-static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops;
+static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops;
 
 static void
 nvmet_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
@@ -2994,7 +2994,7 @@ nvmet_fc_host_traddr(struct nvmet_ctrl *ctrl,
 	return ret;
 }
 
-static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
+static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_FC,
 	.msdbd			= 1,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f85a8441bcc6..72c126b95fd2 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -66,7 +66,7 @@ static DEFINE_MUTEX(nvme_loop_ctrl_mutex);
 static void nvme_loop_queue_response(struct nvmet_req *nvme_req);
 static void nvme_loop_delete_ctrl(struct nvmet_ctrl *ctrl);
 
-static const struct nvmet_fabrics_ops nvme_loop_ops;
+static struct nvmet_fabrics_ops nvme_loop_ops;
 
 static inline int nvme_loop_queue_idx(struct nvme_loop_queue *queue)
 {
@@ -670,7 +670,7 @@ static void nvme_loop_remove_port(struct nvmet_port *port)
 	flush_workqueue(nvme_delete_wq);
 }
 
-static const struct nvmet_fabrics_ops nvme_loop_ops = {
+static struct nvmet_fabrics_ops nvme_loop_ops = {
 	.owner		= THIS_MODULE,
 	.type		= NVMF_TRTYPE_LOOP,
 	.add_port	= nvme_loop_add_port,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 51df72f5e89b..2d29df0f66eb 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -409,6 +409,7 @@ struct nvmet_subsys_link {
 struct nvmet_req;
 struct nvmet_fabrics_ops {
 	struct module *owner;
+	struct list_head entry;
 	unsigned int type;
 	unsigned int msdbd;
 	unsigned int flags;
@@ -637,8 +638,8 @@ void nvmet_send_ana_event(struct nvmet_subsys *subsys,
 		struct nvmet_port *port);
 void nvmet_port_send_ana_event(struct nvmet_port *port);
 
-int nvmet_register_transport(const struct nvmet_fabrics_ops *ops);
-void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);
+int nvmet_register_transport(struct nvmet_fabrics_ops *ops);
+void nvmet_unregister_transport(struct nvmet_fabrics_ops *ops);
 
 void nvmet_port_del_ctrls(struct nvmet_port *port,
 			  struct nvmet_subsys *subsys);
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2e78397a7373..6be4e7586a98 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1523,7 +1523,7 @@ static u16 nvmet_pci_epf_set_feat(const struct nvmet_ctrl *tctrl,
 	}
 }
 
-static const struct nvmet_fabrics_ops nvmet_pci_epf_fabrics_ops = {
+static struct nvmet_fabrics_ops nvmet_pci_epf_fabrics_ops = {
 	.owner		= THIS_MODULE,
 	.type		= NVMF_TRTYPE_PCI,
 	.add_port	= nvmet_pci_epf_add_port,
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 0485e25ab797..9336cb7e25bb 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -176,7 +176,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 				struct nvmet_rdma_rsp *r,
 				int tag);
 
-static const struct nvmet_fabrics_ops nvmet_rdma_ops;
+static struct nvmet_fabrics_ops nvmet_rdma_ops;
 
 static int srq_size_set(const char *val, const struct kernel_param *kp)
 {
@@ -2038,7 +2038,7 @@ static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_ctrl *ctrl)
 	return NVME_RDMA_MAX_QUEUE_SIZE;
 }
 
-static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
+static struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
 	.msdbd			= 1,
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..88e728cb4779 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -211,7 +211,7 @@ static LIST_HEAD(nvmet_tcp_queue_list);
 static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
-static const struct nvmet_fabrics_ops nvmet_tcp_ops;
+static struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -2180,7 +2180,7 @@ static ssize_t nvmet_tcp_host_port_addr(struct nvmet_ctrl *ctrl,
 			(struct sockaddr *)&queue->sockaddr_peer);
 }
 
-static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
+static struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_TCP,
 	.msdbd			= 1,
-- 
2.18.1


