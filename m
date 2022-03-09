Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D17C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m81ggzzpMTMCgjKdyQeTD/JKxbAlg/tm8jf9V1vV2+0=; b=o6/jwh1GeSj6dHDNbGiE/J3dzb
	6eM/E9HzIz4GQELJXxm+Ryv22OTH7XLK5rx+2ZYeqfqIbk8P15kv6c/Ysu72NelMRFIGoOr5XFw4w
	LzkMt4TyDjikrtRUUxJ6LHt1WppyxtLQGDuG2F+EkqIDE8uo/HaPfB85A3OT7Kep2bYUlosqhcSj0
	bin0h9C5XmhFlElakKf9JjQ5v3MPRmQzgYu878Xc/ILrux+212uq53xOxUHcL3VAiZy61WUXrmT1o
	RyY1m4Zy1EMan17TGwID0jb8a/bqQef9PSgozijoJaFJJdUp6VcDPFJdMBeF8EYbscRfpQVrYpaOu
	UUGRrG1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS00H-009mM4-Oy; Wed, 09 Mar 2022 17:21:38 +0000
Received: from mail-co1nam11on20622.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::622]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS00C-009mJ8-SX
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 17:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhDsZO7lVLvmpKqCWkT346AhfZiERCByB+ys4iA12eq5BglT9CuNkag8ZDdCpLivk2g7VXUAq340rQtQWJC0uLMZHMxhTndmGdQTiU/og/JjLR8ZsvZptqutqkTyTVI2j3G630tjd7EdAPfXevF1is8aM0af/y8/CXtj1loapmrszMFbM1FQw/ZOWgP3Wo/XDzcT2+9S8jOBR9sJnkkjvmjs/KADWbkTnW7ACHJF6MqFBDjyzYb5VbeD+exdBuRxJqDW7hLzhKyd8zhP+fdi8keNk2Z0XsodkmDnGpFbFPvkRVMXp2Pw4P4uzbSPVgnQ7i5f3CuvnSVEOO0oQKut4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m81ggzzpMTMCgjKdyQeTD/JKxbAlg/tm8jf9V1vV2+0=;
 b=C9xvx+aXSqZGZZvkixvIWeNv2DchtoJUFhG5b3SNUMYkhzf4OpZRGRVLlfBEBenNr0kiaVseE/OLIImRedufXJOuFEcADnMdd85x5nMNHS091nzzPH/JOWdj6XeBCJubLZcB+7zmAqIBSfMcGugxKVQw3Oe+/tjR5ylC13MWBjJfPA6fDzFmn5sOEYgGE2wZ5P0pv1CEjG6aRWXsxVL1p4m1X+GYbYEbhS55drRsFh/A+im/gfAlaMxsuoHiynhWvb+AMF8e1YBnHfVqyq1FbmuazDe+bgkUdnOrEM6JIE2+Ybw9ySAzD9IpP5b0xSPbvqT252zPWbviUGb3V+ofjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m81ggzzpMTMCgjKdyQeTD/JKxbAlg/tm8jf9V1vV2+0=;
 b=XWAUORcD9nneaMfTARCYXsAjvjgg2YsF7ZypJPXu+JduYymwcXC6joCQTZthODpMeC5XtzpXY3W1N31ZCXBD7UC5Vid2pYFKqkQEofnXUa9agaT4PA1gQIM9dVdrOpia1Myz9CsPyKxpGybamMl1/ssDtpKq+1PmXbAVJ5e32ZRTAfZT3oLLTsf/KMqs3snZRENFjOoz78N0tbq3ckZchE89t8J5Diih9eyc+yT0KYet4/IwUzETnnXahXREJlYM3QWsK32YXJQP1z9GbZWb3rK87ccsAyF4mMDTtplaYkKE2m6OVtHv71xwAp7ARPxYXncFIYaL2SDVP3nAH3JUuQ==
Received: from MW4PR03CA0089.namprd03.prod.outlook.com (2603:10b6:303:b6::34)
 by MN2PR12MB3870.namprd12.prod.outlook.com (2603:10b6:208:166::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 17:05:09 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::8f) by MW4PR03CA0089.outlook.office365.com
 (2603:10b6:303:b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29 via Frontend
 Transport; Wed, 9 Mar 2022 17:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:05:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 17:05:07 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Mar 2022
 09:05:05 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [RFC PATCH 2/2] nvme: derive nvme cmd opcode from struct request
Date: Wed, 9 Mar 2022 09:04:37 -0800
Message-ID: <20220309170437.4448-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220309170437.4448-1-kch@nvidia.com>
References: <20220309170437.4448-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea384e48-897f-4d98-e1ff-08da01eef734
X-MS-TrafficTypeDiagnostic: MN2PR12MB3870:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3870CDB176ED00C66690DDA5A30A9@MN2PR12MB3870.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoPrtS4u6+hFYAkWaVx1gJ32HDUezE4kyZdljRVe5I5Q0XW4hW9ZWp3ZVe9AZEmbGpG6259YUHyThuDkk4eg+49VyfXoG8imdcrDagxqsLD+RZ6sWaYjz/D3elSqxzgEpCME2j75uaB47Y6XjhwByyVW7eUlcAeB6l2NvK6ulobuAobS+JVU46K4KD3vfr3sKOH3M6a+3cWYjAnb5uXSCvAMoaAfpdCX6XAn6db5mGcQTxt3oJYgpsgvCixb7rGG7mUWVWPW5BZ/RwVcdMetWfFaHirR6qTS5Nkv+nUKXe9Vq2JuHn3jGQrMsfZMf02Ej6De/ftApkC94RNJn+ozOqKAFr4VkhQIZJNBBg5WEnZWPC0mB1yp2TKlED6bRkILRIyFBV6jwp5CDWPK2BnpkRe/ICWJ1rj3JEyomEJyLOO28Dn1o+/7VT9IM/R02UpU5Lo52wqQx70dQf97tKFAQtp26KCvf08hfKilxpHLf3x91agSrdn3jRAIBsiXngFUtoi1cZyH1LMmKmvagOpIClw4O++kPhdtO+CN4+6SqP6FMB/4I0g5Hmar3bJQuI1t8DgAFaKssEFNOV8WxxVqygbR4E0EgXaU/nMjhBD1cR6S5UlNGgt49ZBlX++0uC7OjYCSD4DhTfvzhSmfheYi1XFXPmlwTasMzFey7uuOjW7+ovqvI6XZ6r4zSwPjf6n2JNWCvAaEXhmrIWW0H5ir72zg8MJv0cQFeIFXWotIDck=
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(316002)(356005)(7696005)(81166007)(82310400004)(54906003)(6666004)(8676002)(70586007)(6916009)(70206006)(5660300002)(508600001)(4326008)(40460700003)(107886003)(1076003)(426003)(186003)(26005)(2616005)(16526019)(336012)(36860700001)(36756003)(83380400001)(47076005)(2906002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:05:08.6535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea384e48-897f-4d98-e1ff-08da01eef734
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3870
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_092132_955644_C57787BE 
X-CRM114-Status: GOOD (  11.10  )
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

Instead of having 3 calls of nvme_setup_rw() with nvme command opcode as
a separate parameter have one call from nvme_setup_cmd() and derive
nvme command opcode from struct request that we are already passing to
nvme_setup_rw().

This reduces duplicate calls and break statements with removal of extra
function parameter.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b5d36e09e763..fe6179a4a31e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -949,12 +949,16 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 }
 
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
-		struct request *req, struct nvme_command *cmnd,
-		enum nvme_opcode op)
+		struct request *req, struct nvme_command *cmnd)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 control = 0;
 	u32 dsmgmt = 0;
+	static enum nvme_opcode req_op_to_nvme_opcode[] = {
+		[REQ_OP_READ] = nvme_cmd_read,
+		[REQ_OP_WRITE] = nvme_cmd_write,
+		[REQ_OP_ZONE_APPEND] = nvme_cmd_zone_append,
+	};
 
 	if (req->cmd_flags & REQ_FUA)
 		control |= NVME_RW_FUA;
@@ -964,7 +968,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
-	cmnd->rw.opcode = op;
+	/* caller already validates REQ_OP_XXX */
+	cmnd->rw.opcode = req_op_to_nvme_opcode[req_op(req)];
 	cmnd->rw.flags = 0;
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->rw.rsvd2 = 0;
@@ -999,7 +1004,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		case NVME_NS_DPS_PI_TYPE2:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD |
 					NVME_RW_PRINFO_PRCHK_REF;
-			if (op == nvme_cmd_zone_append)
+			if (req_op(req) == nvme_cmd_zone_append)
 				control |= NVME_RW_APPEND_PIREMAP;
 			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
 			break;
@@ -1054,13 +1059,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
 	case REQ_OP_READ:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
-		break;
 	case REQ_OP_WRITE:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
-		break;
 	case REQ_OP_ZONE_APPEND:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
+		ret = nvme_setup_rw(ns, req, cmd);
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.29.0


