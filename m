Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42714C47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yjM1MnS7hf2H9KEmcAAQOdguJadN+Lp0xihyDcpBnWk=; b=gnjilDj+gPwWLsh2J5ubhsXvq5
	lZd5qImQ3zo2D7M/+EBBpnAf5oyT363ZQowxWwQkaA7JGjblvtSNaCkdSAchc9OWCqPia2aQX9B5q
	2em68yl8rCZxMDT4Dqf+SiVQbugHdirbVyceIBBAkrmmmiANF2x/LvJ34FrfuGVl+mGU2wADZKPnc
	ACaDkqfNVnw0XIpHgB/Lr5IYDGYGBuT/YTRtsGvoXHERSxVQh4Li7Zj6otKuIvbcA+KRKd8AJeWrK
	cRjLatgai/mtubVx0fZJLnxzppzvxz7NZN3Lxf1jnNJlMSkfHDlPyT364IBi4IsfNY1WS/nhrV1Tk
	v+Z8virw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkb-00CWAD-0X;
	Mon, 22 Jan 2024 14:58:13 +0000
Received: from mail-dm6nam04on2066.outbound.protection.outlook.com ([40.107.102.66] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkJ-00CVtw-36
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 14:58:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2f0RwhyDZu5rxCE1q4STHjJ2LPRg9Z7OoeRIN3XFwFmtd5JVl3Ju73qtj335qwwD5hO5jK44PgG/DYVH0RsLX6Sv6RexQXS+LQNouAhryjhZyswmj71icHLYcGFAViN/Ghm26D48s8fkW2XZlXZYiV7xfa5siW0rQKvyRy2VwonR68Jd4uQoBRDHGmIKtK0qrUoCj+0OfAJ3w75vd/lyzMnBwjpHeQ7qXv/XHiVyBMFjJibJB6Du64qYRVSWi3TCu0kT1NKOvJXk9JHM8ykCo7Ltp85DZoJzLmjRvTRno1jym5juT3vpfhMaPeaSwD5XCj9CCUj+eweHrf/hYqVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjM1MnS7hf2H9KEmcAAQOdguJadN+Lp0xihyDcpBnWk=;
 b=MEo1dWQFZU0rEH9ipH/z8zc7zqJy1Eag3jiDAs47grVC/GpFqvjNIa46waHOzSTtWF2AzVvB3NqhBtuV7RejMyH47AoklDK4HE7uKSBPZp/nm3JW4b2vAM8VX866okTEK+pWwIg4XdeA7BA+nQIzQATnSx2PmHHIKRAoUD9FLU46JiHwuJJijT0bfPTqfk6+OoFRidi4xvYH0cHd7fV7EtvmLUHNb5bzNW/K9Nr2Uy9HHublb+bEv9jZ09lUrb48z4OW/fcumo8CC7Uqh2AaiHsK5wcrLL13za+78jvD5eHdWm2fsDRsj4LqtwIJU2S8JqLpO4JjA8xUu74B1p/0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjM1MnS7hf2H9KEmcAAQOdguJadN+Lp0xihyDcpBnWk=;
 b=kEl9hDJIWjwFZhuWcmkF9uM0pT//IdkfGzuk7ynaHcH+8uttxnKyENqLms5VeuEnRjJGt8SYKNPmSX0MgViz1U0SK3tltvzcB1P6d0wOy+2ZFU7dZnaevFs/80rVPjgzR0hVyvant9FgyMOu/VH966t0vSFjp55aVXzTK/geb+1Bt/FKj/nMuP8HjgRUx3wg7dsupNPdezqIDlvJmJ6jBLVasbCqP3AagCU0be/pUpdJOdYk412Rl5u+rpgqznLNRkIvTsFXr3syyOUjjlfc0KEFAPU6qkhV+gddr11luNeNm917XTw8ifUX9uXCVpaoSF9AL+FDQpUG/8v5QcniAQ==
Received: from SA0PR11CA0074.namprd11.prod.outlook.com (2603:10b6:806:d2::19)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 14:57:36 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::d3) by SA0PR11CA0074.outlook.office365.com
 (2603:10b6:806:d2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17 via Frontend
 Transport; Mon, 22 Jan 2024 14:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 14:57:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 06:57:08 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 06:57:08 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 06:57:06 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <dwagner@suse.de>,
	<oevron@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/8] nvme: set uniform metadata settings for ns head
Date: Mon, 22 Jan 2024 16:56:53 +0200
Message-ID: <20240122145659.5574-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240122145659.5574-1-mgurtovoy@nvidia.com>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3ed50d-24b8-4a59-595d-08dc1b5a78a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pp/piZdINmmVMNdUPssGIKfvp4uuqAvpx48EdUxqjDAqUERunWXRGUtQrmA6p2whg2S1hm7NYCLDMfWhcPsKNNDd/f6aavFEandjQBtp739VBRG71LmmLpUo/hCz5+UchGqJ/vIuPHyRDrBhDNV7z7qVISNpzHZTntsBxRZn/vwJYxLR7P97PwGInlGTU9CBWk5d513lq3cTX4Fomt/cXGzjWfEhejHroY1XFfAE+NQ4xD85vJiM4awhbaikdGWzbMKlV70SSnOQn54/jm1xTRjzla1tcsEiX4hspRHmFBLby4GUf06zrs/LFImczZcE+/bFlUi5QH3x2Gk9iGuVk6ZceEi88I3rN2TB9OU7IJc8RA1DIkgHH+h6rJq/UdhvgckhhxZauBvGuGAak/35fzeLDGkiJSFubP4JI7UZHxf0UU9H+7V2Ewo+6eHORD1aN3RVVMOFl7rjYF7G5vYKJu401BI7RoEdAfHNc3mjbCzUu3pSMX1iVHCagm/kxujvd6I+qr6jFfxhpvr1IOfZJPOw6Es2ddH52FXyld+Zutg6cTe32JssG0dEhFKRzjfnSL5pUTvcgFcn9zp1+KjIk3E1Etc/NViPj69nXCf4oAugbXccpNgg3RC25tWe2gm4MZO8bFvSBFAWPmS+++37F1HcSO7RCxw/dkhARIb2flKSUCNXKJT2pZw6FDV4EO+suNvSKlXfJ5CEW91uLse+sjE2Q3K9ccrgm1j096dA6+fNCgD+Rr6OQhS+5aCa4be
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(46966006)(40470700004)(36840700001)(66899024)(40480700001)(40460700003)(336012)(6666004)(426003)(2616005)(107886003)(1076003)(26005)(356005)(7636003)(86362001)(36756003)(82740400003)(83380400001)(36860700001)(5660300002)(30864003)(2906002)(47076005)(41300700001)(110136005)(8936002)(8676002)(70206006)(4326008)(70586007)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:57:36.3339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3ed50d-24b8-4a59-595d-08dc1b5a78a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_065756_115057_51B22B4D 
X-CRM114-Status: GOOD (  24.54  )
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

Do not allow having different metadata settings for a namespace and its
associated head.

In case of a different metadata settings discovered for a shared
namespace, that can caused by controller or path capabilities, create a
dedicated namespace head for each controller for that namespace.

For example, in the fabrics case, where there might be a multipath
configuration which one controller/path supports metadata offloading and
the second path that doesn't. In that case, we don't want to put these
paths and their namespaces under the same multipath umbrella.
Therefore, if the metadata settings are not the same we will create a
separate namespace head for each such namespace.

While we're here, also make sure that all the namespaces under the
namespace head have the same lba shift size.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Ori Evron <oevron@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 372 +++++++++++++++++++++++++--------------
 1 file changed, 236 insertions(+), 136 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ff18c263c62c..9d46acf5b6cb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -35,6 +35,14 @@
 struct nvme_ns_info {
 	struct nvme_ns_ids ids;
 	u32 nsid;
+	unsigned long features;
+	u64 nuse;
+	u16 ms;
+	u16 pi_size;
+	u8 pi_type;
+	u8 guard_type;
+	u8 flbas;
+	u8 ds;
 	__le32 anagrpid;
 	bool is_shared;
 	bool is_readonly;
@@ -1473,6 +1481,126 @@ int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	return error;
 }
 
+static int nvme_elbaf_from_id_ns_nvm(struct nvme_ctrl *ctrl, u32 nsid,
+		unsigned lbaf, u32 *elbaf)
+{
+	struct nvme_command c = { };
+	struct nvme_id_ns_nvm *nvm;
+	int ret;
+
+	nvm = kzalloc(sizeof(*nvm), GFP_KERNEL);
+	if (!nvm)
+		return -ENOMEM;
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(nsid);
+	c.identify.cns = NVME_ID_CNS_CS_NS;
+	c.identify.csi = NVME_CSI_NVM;
+
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, nvm, sizeof(*nvm));
+	if (ret)
+		goto free_data;
+
+	*elbaf = le32_to_cpu(nvm->elbaf[lbaf]);
+
+free_data:
+	kfree(nvm);
+
+	return ret;
+}
+
+static int nvme_info_init(struct nvme_ctrl *ctrl, struct nvme_ns_info *info,
+		struct nvme_id_ns *id)
+{
+	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
+	unsigned lbaf = nvme_lbaf_index(id->flbas);
+	int ret = 0;
+	u32 elbaf;
+
+	info->nuse = le64_to_cpu(id->nuse);
+	info->flbas = id->flbas;
+	info->ds = id->lbaf[lbaf].ds;
+	info->pi_size = 0;
+	info->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
+		info->pi_size = sizeof(struct t10_pi_tuple);
+		info->guard_type = NVME_NVM_NS_16B_GUARD;
+		goto set_pi;
+	}
+
+	ret = nvme_elbaf_from_id_ns_nvm(ctrl, info->nsid, lbaf, &elbaf);
+	if (ret)
+		goto set_pi;
+
+	/* no support for storage tag formats right now */
+	if (nvme_elbaf_sts(elbaf))
+		goto set_pi;
+
+	info->guard_type = nvme_elbaf_guard_type(elbaf);
+	switch (info->guard_type) {
+	case NVME_NVM_NS_64B_GUARD:
+		info->pi_size = sizeof(struct crc64_pi_tuple);
+		break;
+	case NVME_NVM_NS_16B_GUARD:
+		info->pi_size = sizeof(struct t10_pi_tuple);
+		break;
+	default:
+		break;
+	}
+
+set_pi:
+	if (info->pi_size && (first || info->ms == info->pi_size))
+		info->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+	else
+		info->pi_type = 0;
+
+	return ret;
+}
+
+static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
+		struct nvme_ns_info *info)
+{
+	info->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
+	if (!info->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+		return;
+
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
+		/*
+		 * The NVMe over Fabrics specification only supports metadata as
+		 * part of the extended data LBA.  We rely on HCA/HBA support to
+		 * remap the separate metadata buffer from the block layer.
+		 */
+		if (WARN_ON_ONCE(!(info->flbas & NVME_NS_FLBAS_META_EXT)))
+			return;
+
+		info->features |= NVME_NS_EXT_LBAS;
+
+		/*
+		 * The current fabrics transport drivers support namespace
+		 * metadata formats only if pi_type != 0 and ms == pi_size.
+		 * Suppress support for all other formats so the namespace will
+		 * have a 0 capacity and not be usable through the block stack.
+		 *
+		 * Note, this check will need to be modified if any drivers
+		 * gain the ability to use other metadata formats.
+		 */
+		if (ctrl->max_integrity_segments && info->pi_type &&
+		    info->ms == info->pi_size)
+			info->features |= NVME_NS_METADATA_SUPPORTED;
+	} else {
+		/*
+		 * For PCIe controllers, we can't easily remap the separate
+		 * metadata buffer from the block layer and thus require a
+		 * separate metadata buffer for block layer metadata/PI support.
+		 * We allow extended LBAs for the passthrough interface, though.
+		 */
+		if (info->flbas & NVME_NS_FLBAS_META_EXT)
+			info->features |= NVME_NS_EXT_LBAS;
+		else
+			info->features |= NVME_NS_METADATA_SUPPORTED;
+	}
+}
+
 static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 		struct nvme_ns_info *info)
 {
@@ -1491,6 +1619,21 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 		goto error;
 	}
 
+	ret = nvme_info_init(ctrl, info, id);
+	if (ret)
+		goto error;
+
+	nvme_configure_metadata(ctrl, info);
+
+	/*
+	 * Only set the DEAC bit if the device guarantees that reads from
+	 * deallocated data return zeroes.  While the DEAC bit does not
+	 * require that, it must be a no-op if reads from deallocated data
+	 * do not return zeroes.
+	 */
+	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)))
+		info->features |= NVME_NS_DEAC;
+
 	info->anagrpid = id->anagrpid;
 	info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 	info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
@@ -1773,116 +1916,6 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 		a->csi == b->csi;
 }
 
-static int nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
-		struct nvme_id_ns *id)
-{
-	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
-	unsigned lbaf = nvme_lbaf_index(id->flbas);
-	struct nvme_command c = { };
-	struct nvme_id_ns_nvm *nvm;
-	int ret = 0;
-	u32 elbaf;
-
-	head->pi_size = 0;
-	head->ms = le16_to_cpu(id->lbaf[lbaf].ms);
-	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
-		head->pi_size = sizeof(struct t10_pi_tuple);
-		head->guard_type = NVME_NVM_NS_16B_GUARD;
-		goto set_pi;
-	}
-
-	nvm = kzalloc(sizeof(*nvm), GFP_KERNEL);
-	if (!nvm)
-		return -ENOMEM;
-
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.nsid = cpu_to_le32(head->ns_id);
-	c.identify.cns = NVME_ID_CNS_CS_NS;
-	c.identify.csi = NVME_CSI_NVM;
-
-	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, nvm, sizeof(*nvm));
-	if (ret)
-		goto free_data;
-
-	elbaf = le32_to_cpu(nvm->elbaf[lbaf]);
-
-	/* no support for storage tag formats right now */
-	if (nvme_elbaf_sts(elbaf))
-		goto free_data;
-
-	head->guard_type = nvme_elbaf_guard_type(elbaf);
-	switch (head->guard_type) {
-	case NVME_NVM_NS_64B_GUARD:
-		head->pi_size = sizeof(struct crc64_pi_tuple);
-		break;
-	case NVME_NVM_NS_16B_GUARD:
-		head->pi_size = sizeof(struct t10_pi_tuple);
-		break;
-	default:
-		break;
-	}
-
-free_data:
-	kfree(nvm);
-set_pi:
-	if (head->pi_size && (first || head->ms == head->pi_size))
-		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-	else
-		head->pi_type = 0;
-
-	return ret;
-}
-
-static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
-		struct nvme_ns_head *head, struct nvme_id_ns *id)
-{
-	int ret;
-
-	ret = nvme_init_ms(ctrl, head, id);
-	if (ret)
-		return ret;
-
-	head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
-	if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		return 0;
-
-	if (ctrl->ops->flags & NVME_F_FABRICS) {
-		/*
-		 * The NVMe over Fabrics specification only supports metadata as
-		 * part of the extended data LBA.  We rely on HCA/HBA support to
-		 * remap the separate metadata buffer from the block layer.
-		 */
-		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
-			return 0;
-
-		head->features |= NVME_NS_EXT_LBAS;
-
-		/*
-		 * The current fabrics transport drivers support namespace
-		 * metadata formats only if nvme_ns_has_pi() returns true.
-		 * Suppress support for all other formats so the namespace will
-		 * have a 0 capacity and not be usable through the block stack.
-		 *
-		 * Note, this check will need to be modified if any drivers
-		 * gain the ability to use other metadata formats.
-		 */
-		if (ctrl->max_integrity_segments && nvme_ns_has_pi(head))
-			head->features |= NVME_NS_METADATA_SUPPORTED;
-	} else {
-		/*
-		 * For PCIe controllers, we can't easily remap the separate
-		 * metadata buffer from the block layer and thus require a
-		 * separate metadata buffer for block layer metadata/PI support.
-		 * We allow extended LBAs for the passthrough interface, though.
-		 */
-		if (id->flbas & NVME_NS_FLBAS_META_EXT)
-			head->features |= NVME_NS_EXT_LBAS;
-		else
-			head->features |= NVME_NS_METADATA_SUPPORTED;
-	}
-	return 0;
-}
-
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		struct request_queue *q)
 {
@@ -2058,15 +2091,14 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
-	ns->head->lba_shift = id->lbaf[lbaf].ds;
-	ns->head->nuse = le64_to_cpu(id->nuse);
-	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
-	ret = nvme_configure_metadata(ns->ctrl, ns->head, id);
-	if (ret < 0) {
+	if (info->flbas != id->flbas || info->ds != id->lbaf[lbaf].ds) {
 		blk_mq_unfreeze_queue(ns->disk->queue);
-		goto out;
+		ret = -EINVAL;
+		goto error;
 	}
+
+	nvme_set_queue_limits(ns->ctrl, ns->queue);
 	nvme_set_chunk_sectors(ns, id);
 	nvme_update_disk_info(ns->ctrl, ns->disk, ns->head, id);
 
@@ -2078,14 +2110,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		}
 	}
 
-	/*
-	 * Only set the DEAC bit if the device guarantees that reads from
-	 * deallocated data return zeroes.  While the DEAC bit does not
-	 * require that, it must be a no-op if reads from deallocated data
-	 * do not return zeroes.
-	 */
-	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)))
-		ns->head->features |= NVME_NS_DEAC;
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
@@ -3294,8 +3318,18 @@ static const struct file_operations nvme_dev_fops = {
 	.uring_cmd	= nvme_dev_uring_cmd,
 };
 
+static bool nvme_head_is_same_metadata(struct nvme_ns_head *h,
+		struct nvme_ns_info *info)
+{
+	unsigned int mask = NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS;
+
+	return (h->features & mask) == (info->features & mask) &&
+	       h->pi_size == info->pi_size && h->pi_type == info->pi_type &&
+	       h->guard_type == info->guard_type && h->ms == info->ms;
+}
+
 static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
-		unsigned nsid)
+		struct nvme_ns_info *info)
 {
 	struct nvme_ns_head *h;
 
@@ -3307,7 +3341,11 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		 * In that case we can't use the same ns_head for namespaces
 		 * with the same NSID.
 		 */
-		if (h->ns_id != nsid || !nvme_is_unique_nsid(ctrl, h))
+		if (h->ns_id != info->nsid || !nvme_is_unique_nsid(ctrl, h))
+			continue;
+		if (!nvme_head_is_same_metadata(h, info))
+			continue;
+		if (h->lba_shift != info->ds)
 			continue;
 		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
 			return h;
@@ -3316,24 +3354,51 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 	return NULL;
 }
 
-static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
+static bool nvme_head_is_duplicate_ids(struct nvme_ns_head *h,
 		struct nvme_ns_ids *ids)
 {
 	bool has_uuid = !uuid_is_null(&ids->uuid);
 	bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
 	bool has_eui64 = memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
+
+	if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
+		return true;
+	if (has_nguid &&
+	    memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
+		return true;
+	if (has_eui64 &&
+	    memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
+		return true;
+
+	return false;
+}
+
+static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
+		struct nvme_ns_ids *ids)
+{
 	struct nvme_ns_head *h;
 
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
-			return -EINVAL;
-		if (has_nguid &&
-		    memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
+		if (nvme_head_is_duplicate_ids(h, ids))
 			return -EINVAL;
-		if (has_eui64 &&
-		    memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
+	}
+
+	return 0;
+}
+
+static int nvme_subsys_check_duplicate_info(struct nvme_subsystem *subsys,
+		struct nvme_ns_info *info)
+{
+	struct nvme_ns_head *h;
+
+	lockdep_assert_held(&subsys->lock);
+
+	list_for_each_entry(h, &subsys->nsheads, entry) {
+		if (nvme_head_is_same_metadata(h, info) &&
+		    nvme_head_is_duplicate_ids(h, &info->ids) &&
+		    h->lba_shift == info->ds)
 			return -EINVAL;
 	}
 
@@ -3432,6 +3497,13 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->subsys = ctrl->subsys;
 	head->ns_id = info->nsid;
 	head->ids = info->ids;
+	head->nuse = info->nuse;
+	head->pi_size = info->pi_size;
+	head->pi_type = info->pi_type;
+	head->guard_type = info->guard_type;
+	head->ms = info->ms;
+	head->lba_shift = info->ds;
+	head->features = info->features;
 	head->shared = info->is_shared;
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
@@ -3536,12 +3608,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
-	head = nvme_find_ns_head(ctrl, info->nsid);
+	head = nvme_find_ns_head(ctrl, info);
 	if (!head) {
-		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
+		ret = nvme_subsys_check_duplicate_info(ctrl->subsys, info);
 		if (ret) {
 			dev_err(ctrl->device,
-				"duplicate IDs in subsystem for nsid %d\n",
+				"duplicate NS Info in subsystem for nsid %d\n",
 				info->nsid);
 			goto out_unlock;
 		}
@@ -3565,6 +3637,21 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 			goto out_put_ns_head;
 		}
 
+		if (!nvme_head_is_same_metadata(head, info)) {
+			dev_err(ctrl->device,
+				"Metadata doesn't match for shared namespace %d\n",
+				info->nsid);
+			goto out_put_ns_head;
+		}
+
+		if (head->lba_shift != info->ds) {
+			dev_err(ctrl->device,
+				"LBA data size doesn't match for shared namespace %d\n",
+				info->nsid);
+			goto out_put_ns_head;
+
+		}
+
 		if (!multipath) {
 			dev_warn(ctrl->device,
 				"Found shared namespace %d, but multipathing not supported.\n",
@@ -3780,6 +3867,19 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 		goto out;
 	}
 
+	if (!nvme_head_is_same_metadata(ns->head, info)) {
+		dev_err(ns->ctrl->device,
+			"Metadata changed for nsid %d\n", ns->head->ns_id);
+			goto out;
+	}
+
+	if (ns->head->lba_shift != info->ds) {
+		dev_err(ns->ctrl->device,
+			"LBA data size changed for nsid %d\n",
+			ns->head->ns_id);
+		goto out;
+	}
+
 	ret = nvme_update_ns_info(ns, info);
 out:
 	/*
-- 
2.18.1


