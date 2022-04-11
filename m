Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96BBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 03:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GOrgSxN5Ixs8NUF4BEnUZTZuWe0trrt2wPJacA/j7M4=; b=vbvUPo5knMoVs8LMk9QfQzRPyF
	2+qQMDhR+PiTvsrnhhlrIls1Xa0X3ujRRey7e6Zt7ximd8sOz5468evtykM2/VFXqjN8vDvjHXBCB
	/rll9UnbMjw30+/7Bl5eZGJ2k2fJScKnMnDKpry3YhZe5MX1f9l8lLIAM3AQ9NETO0xB7HMWoDOrI
	HJlc+MVHtgvZT0wEsegSItXsKiRRnDRghAa0Gc5dWKW4QH/n64p8xIVeRdJNrFb1kDmGCHcRVbGCT
	nZ/ABLU0BKuWqkyv4MBzaq4mBkryxQzeesJgYFbfXfCAg5zaNspMht0zsvvXtjVCfQblO3cTw6bZ6
	MRwkP8Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndkUW-006PBb-KT; Mon, 11 Apr 2022 03:13:24 +0000
Received: from mail-dm6nam12on20623.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::623]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndkUM-006P5x-OU
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 03:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHgmgt5JH8ACaL1/jYcN3iwLWaUHMwtIonzAAQWGSzzVcJd9XcJC3rs7iUreiqtjMD8d0GJWsVP1DRdJi38u4TdRJiyCo38rIgIk5DH52e0QQXGRGSVI/zHyM1HQiIGWiIeAbCkn6JvMf2lyKBHJuS4E8jlKAivCr/aXJw4ZxbOuAV12JtD0rN7QMiR6ChN/8AEe6sX1lV/rqLc6Otk0dJbBvxIK6jPhersEaoFUC/GswYZOTAeptY641PH3BxYVyL8q2nd1+y5ne7+tw7KZmpdDnqCAp7VRGqo1aQAGqgGeIoV/AtAFIWhIthwlu8nNlf12T7ostjB8Nfk8T1nh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOrgSxN5Ixs8NUF4BEnUZTZuWe0trrt2wPJacA/j7M4=;
 b=MzkelklZy8uo7lxu+kBsr6zTpqiYtWx9N7DX/ioFPSATk7RlOt85T46w+zaa2ChHltToEeYiuaXPdESNH3Vt2nF6QZOCyaedO7ZE5DTPIFyPtMTPBUyHEva7lYI6iB6afEEaYvUCmPIABzaRK+Eo3wIPXz2Pal/QwuEb8nmfdjjK4w6NrRbYq2mdBrdBLLJo+dQX8nqTfZbzyz6nLD5UADy3XsmlUCZ63J/ZzRzqYWcJQiPxXDVbhhDB7UfxsC7MytNuBKBJ365m3DQinREEeMcEZtCMmtFNdwlblGCHq1RqWb6JTN5Qu7FLg8KBll6SpGXAHXuZizXuc09VUsmWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOrgSxN5Ixs8NUF4BEnUZTZuWe0trrt2wPJacA/j7M4=;
 b=k32a7v19ORApr98htHg3auRNIrVd+aV0rEqWUH0AfD1HAcDIOk/yoAG2cAYbVuzBXozuyNm6hOJ7x5ClwPWdRtH+6e8lpECnSZkFHFpL60JNH4PZpuWVcDESSzQ8YxQ4lUGLBfl9MUojTMJQ4q0Wwgv+OwU+1Z87tmcnLDGYqnAj0SvkuTTPKOOgJ2UH3eRFcIQQ/t6DNcj+YJ7V8gx5CEDzak/0dlM/l6YnTUxkJWILgGfIGy21p5WTIAVuoWI6TjHD6Z8yoghcIeqkamxUApH32iqVW09+DwgOzIJYhLkNSkbbQiRrPBBIFm5uIuYQHLEXnXwFqFzWKZtv0MPgXw==
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by MWHPR12MB1759.namprd12.prod.outlook.com (2603:10b6:300:113::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 03:13:10 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::8e) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 03:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 03:13:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Mon, 11 Apr 2022 03:13:09 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 10 Apr
 2022 20:13:08 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 1/3] nvmet: handle admin default command set identifier
Date: Sun, 10 Apr 2022 20:12:47 -0700
Message-ID: <20220411031249.5158-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220411031249.5158-1-kch@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a23af1d0-7466-42f4-5d79-08da1b69351e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1759:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17595024103BC09A83AAD2B8A3EA9@MWHPR12MB1759.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GavLDXEgGrKwGAvbk/CwsDuzYZp9AlYRmrO/3mM+1xUCmGQwq+tNefpwccV/O0pINdDnccPPBCnnv8SzMxGQzVtj0I7VFIWUqUnfDh1FrkZUmttMc5T9Sq+bLXpRh/n1188L9JPdBMeGUUzn8xZVqfFk35+j/UNsT18GNxUd0Z20OQruNATB8YFzTOeyv1h3Ob56FW56wzJh08WM5mVChH71aY2tiJCwVX38WV9uhqGnThG/b6mJiZAVjY2sa2P0OBwn2SKWvbVPcFGF1qG8QyEqza1hRAKQdjaFQq/PLYJUA4Mcru1FHhDAPudgbs7XVZqXQdp2Gt9MmhMqMN6LmZRnX9qQd5rfWzA20iObKcnieWnQPvjJ8fSConn2ooZtpY+SUMmIIUZ5xx2LMX21zl8tabTWuqZJqqeNlmGZbA5aVByqj1sxsQcvj+8Ue9qbNEzdMgGtDi0qTKaVqeW32q/n7BxG7psXtSq2S4hY18oJvCTPxJjWcZR25MKoZFwwXZEH43dz3/aRcwXXwXRkIMskg5JZha1dKZQHhYo1NsRAhKNOv4kT+eyIAlTJ+kz9BSlm3qNBVeXHlbmcTIsTs+6kK783E7XHG5kVabov/z3CtqFwdByvUdQWlpeVunnux1pFiui7SQuriBKVWBKHnBJ+gbuY2cedXqXg+5Jh4Jr4sZvyUDK59C3JG0MfXLn5C5ZOB9sb0LXOcnv4JrP+NA==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6916009)(47076005)(54906003)(186003)(16526019)(5660300002)(81166007)(356005)(36860700001)(6666004)(8936002)(107886003)(36756003)(2616005)(1076003)(40460700003)(2906002)(7696005)(316002)(8676002)(82310400005)(336012)(4326008)(426003)(70206006)(70586007)(26005)(508600001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 03:13:10.1951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a23af1d0-7466-42f4-5d79-08da1b69351e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1759
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_201314_821859_CA463B58 
X-CRM114-Status: GOOD (  14.27  )
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

The NVMeOF in kernel host when configuring non-mdts limits uses
idnetify controller cns value to NVME_ID_CNS_CS_CTRL and csi value to
NVME_CSI_NVM. In target code we only handle case for NVME_ID_CNS_CS_CTRL
and NVME_CSI_ZNS when CONFIG_BLK_DEV_ZONED is set.

Handle missing case for CONFIG_BLK_DEV_ZONED and !CONFIG_BLK_DEV_ZONED
so it can handle NVME_ID_CNS_CS_CTRL with NVME_CSI_NVM.

Use this opportunity to add default for the NVME_ID_CNS_CTRL case which
makes code uniform for all the cases in the
nvmet_execute_identify_cns_cs_ctrl_nvm().

Also, rename nvmet_execute_identify_ctrl() to
             nvmet_execute_identify_cns_cs_ctrl_nvm() and
nvmet_execute_identify_cns_cs_ctrl() to
nvmet_execute_identify_cns_cs_ctrl_zns().

This also masks the following warning reported by the nvme_log_error()
when running blktest nvme/012:-

[ 2131.702140] run blktests nvme/012 at 2022-04-09 16:59:53
[ 2131.722144] loop0: detected capacity change from 0 to 2097152
[ 2131.730586] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2131.738826] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
*[ 2131.738911] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR*
[ 2131.740540] nvme nvme1: creating 48 I/O queues.
[ 2131.743925] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 2132.790058] XFS (nvme1n1): Mounting V5 Filesystem
[ 2132.793667] XFS (nvme1n1): Ending clean mount
[ 2132.794030] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
[ 2142.471812] XFS (nvme1n1): Unmounting Filesystem
[ 2142.492566] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 22 ++++++++++++++--------
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/zns.c       |  2 +-
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 397daaf51f1b..428303f1acca 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -342,7 +342,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
-static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
+static void nvmet_execute_identify_cns_cs_ctrl_nvm(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_subsys *subsys = ctrl->subsys;
@@ -710,17 +710,23 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	case NVME_ID_CNS_CTRL:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
-			return nvmet_execute_identify_ctrl(req);
+			return nvmet_execute_identify_cns_cs_ctrl_nvm(req);
+		default:
+			break;
 		}
 		break;
 	case NVME_ID_CNS_CS_CTRL:
-		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-			switch (req->cmd->identify.csi) {
-			case NVME_CSI_ZNS:
-				return nvmet_execute_identify_cns_cs_ctrl(req);
-			default:
-				break;
+		switch (req->cmd->identify.csi) {
+		case NVME_CSI_NVM:
+			return nvmet_execute_identify_cns_cs_ctrl_nvm(req);
+		case NVME_CSI_ZNS:
+			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+				nvmet_execute_identify_cns_cs_ctrl_zns(req);
+				return;
 			}
+			break;
+		default:
+			break;
 		}
 		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69818752a33a..fdb6956314ad 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -547,7 +547,7 @@ bool nvmet_ns_revalidate(struct nvmet_ns *ns);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
+void nvmet_execute_identify_cns_cs_ctrl_zns(struct nvmet_req *req);
 void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index e34718b09550..5003d48b6630 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -71,7 +71,7 @@ bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
 	return true;
 }
 
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+void nvmet_execute_identify_cns_cs_ctrl_zns(struct nvmet_req *req)
 {
 	u8 zasl = req->sq->ctrl->subsys->zasl;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-- 
2.29.0


