Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01256C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gCXHzXqDX4E+hxM6etaZQnP3ZhUkSqluUg0YdEYb3LQ=; b=rferXswi98OXw/aKWNJTn72GxM
	7WeB+eKd0ITdTAdGA3/ZzI/zIwTKzY5AZDI+qICHtBu8PaQnc6f1W/cXUxeqEkJ7dp2l5WmX4wHiC
	uNam5DvnE9waQAfB/3ebYcEv2w79tvmL9SyxrwSHXxblOa5RLd6YEjzyIJ9TbRErUOeZ5+RNDALu+
	l8HRslkxNQmtDsDk4hMAP5PBRHjsUam1YMO05GwHNQTFtkrRRJEqX7sh030PA0u4GZ8bnwCXf1Oh/
	mSusXxqTKueK6sQ0WprrTPXqHjPXEe2aUjaQ4bkZFnGWQaFiee2s0PwoY9aS9l0fkDVN99lA7tCZ7
	LUT+1hvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7X0n-001Gs7-FK; Wed, 12 Jan 2022 06:21:33 +0000
Received: from mail-bn8nam12on2062f.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::62f]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7X0k-001GrG-9n
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 06:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdh2t27l6sObdvb9o/Qf6huenfAycyiYd1pwhWDLtLWxkwTK6rgiO0v1WrKyTq/KEdnzT8zHYQBTd0KUhxK1AbvHSvK6ZAQwaWtjS67vfqylXoSvLvATGzbfureBkiZJHMhN89N6HDGFNpQ6bht1SA9yvv3CHF1HXKPx/rdsHo6RexViodgV0WR+GbuXvGkGWyjSmfF6EK836SuMDttYdq4/veYpq/MsrQw3ubPX/o+bsYyYcXzl46rN9qvJvWSqbAtyFUtxbovLrxp/5mwcmYTYhOtq0dO+YGMqkAR2d2SxfsAMCDTRSXFje/eSE66+DmtlQL4Faom3O6kbcMzNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCXHzXqDX4E+hxM6etaZQnP3ZhUkSqluUg0YdEYb3LQ=;
 b=IR6jCbXjNnNInSfno5CwU0Sb6DdcxbE29Byz5O3cymFVZU+YVorCsMDXB9QVC5TnS80uXTV/QirK1zUgoUDjG2Dka3QjqiVRYYA0tmZqAWqc/thMb2JgC35cD+lb57CVx1insYd6yxaVBIpJVd5Zp0S/YFHBpZZZzZXXLJ84X8SqqN54Rzl1RPKTlBN2McAJ83RrdRvc0e0NOJq5vxSlolNSW65n9FvACu/3TZuurD/TuLVHs2e3iOWVpdbxWi5wL3BQ0nkG85LbBfpGmYwAxFRlkrV+AvtwJoXMNIE+f5ujTmy2lMul1zjVV52nJNJhR8s4+Fxt/sYRABYLyM9hCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCXHzXqDX4E+hxM6etaZQnP3ZhUkSqluUg0YdEYb3LQ=;
 b=FXPBgOLgWGInSmsaqh9Vuz591N2CenhjHBW+t4MZTmbPBxkG6SDHcz8lGbO68fI09Ldc6bzA60BUjdYhLFemkpdjlgy0zog3uVrvVmOPRuR9e2alNAJy+h/0V0VEunbklOhFZfJosrUdWIu6VqyjkTkbg4hYEo/Tl8wi8Tlk6u6BPFRhamDEcsf9JaaUTiM1ZBpDolEi6rHjquA+8M6BRrnZLzQy4W8BpYraNFVImp6S1Etca4U3vhSVGEY4u0Y12HTkYgVDHvZSs1AjYGMhuIp2HB79rj4CTgbnRwmDi7SVXEcNDzYbeZNxq07lixw+MHT7YBwOwUe4sBZcfLNr6w==
Received: from DM6PR12CA0028.namprd12.prod.outlook.com (2603:10b6:5:1c0::41)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 06:21:26 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::31) by DM6PR12CA0028.outlook.office365.com
 (2603:10b6:5:1c0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 06:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Wed, 12 Jan 2022 06:21:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 12 Jan 2022 06:21:22 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 11 Jan 2022
 22:21:21 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/5] nvme-fabrics: use consistent zeroout pattern
Date: Tue, 11 Jan 2022 22:20:57 -0800
Message-ID: <20220112062101.90102-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220112062101.90102-1-chaitanyak@nvidia.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41b463f4-fa21-465d-869c-08d9d593c2ff
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50303D99D05D6B93BAA3BD69A3529@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vVnsgjMPTWM5PhLu59hmkPa9Wvqh5cN71Ftt72DnRc8qxLMpApc19UiULB0Ynm3u0TQqOqDHZrELCg6VZur+SKvl9Hpzi09SvisUlQivF7sPpzjMNrvhsCqa+KY/VUUNjZJjOaV+hSMkvnmUkIHb+4P8QOP1POQjcYnvZHccZbl9JtBb7U93Da4e4U5hjtaSXLNNW5LQSQ49MlcJ64Y9Eho54XViX574xDLN7r21fXQzCnahC+61N2u8PN9eq9GVTrCIiYbFVhzRmqa36RWNl7TzjOciEDOzxYzVOAfhJfaODzXedomF8niLOcfphORKdoK/0Q0ZfPlwyfk9lYIZjkIZMvlg8cxs/5sAWDxhUPZUSW9CPTVKtvbVs8PCrP+WnspXaFUJ/GkHSPFk4JbMR1hwXaXdDrZF0xL9DCw7WseBdI2ThFlE+qZaItCoAMP/kb4l4xkl2NGiA4xPnJzVzvBWgJVGdN3gj9ui+0hDsGV8L+Bc4FkMjLxLDvWSge2JuDhL7cItV8hsVuYDYtLFMfK4LlBREZjMc3PqsizhzV6ytA00hdcr+HROTlPQYgwoAtzjJXKlBbSJbETD2tC4XKkFzjm0fPBHCLALsBDzEMbIvvk1wVzW00kp6ZbYAzIjKs/pY0yIRfcq9ynJFpHvwhJmuOL7mFlsZp33O9WW3s1nTTTAweQCDvZo80PX+42JgDb0LJWGrq39DDOq5KLnjjaWz8cK6zyfbJuZCFZp79sAeotFMJZQnzTlSinoEZWBE09GtzduJ7qVOQMbf1x0MIgHrx0TxKAzSans9KLBAc=
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(16526019)(508600001)(47076005)(4744005)(5660300002)(336012)(426003)(81166007)(36860700001)(186003)(1076003)(2906002)(316002)(54906003)(6916009)(26005)(70586007)(36756003)(86362001)(8936002)(82310400004)(107886003)(40460700001)(8676002)(2616005)(6666004)(4326008)(7696005)(83380400001)(70206006)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 06:21:25.6820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b463f4-fa21-465d-869c-08d9d593c2ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220111_222130_369222_9258060B 
X-CRM114-Status: GOOD (  10.70  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Remove zeroout memeset call & zeroout local variable cmd at the time
of declaration in nvmf_ref_read32() similar to what we have done in
nvmf_reg_read64(), nvmf_reg_write32(), nvmf_connect_admin_queue(), and
nvmf_connect_io_queue().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7ae041e2b3fb..a0640986add9 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -144,11 +144,10 @@ EXPORT_SYMBOL_GPL(nvmf_get_address);
  */
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
-	struct nvme_command cmd;
+	struct nvme_command cmd = { };
 	union nvme_result res;
 	int ret;
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.prop_get.opcode = nvme_fabrics_command;
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
-- 
2.29.0


