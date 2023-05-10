Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8F2C7EE24
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b31Xr8z8WoL5BzPeF6ZsHeEJAuO1hKizMheyhTbzna4=; b=YAYs2+dwMKCq11vs7CE1oD+AJ0
	SNEy8mytLnydsnVW0mGMiH0OWnPvsUQeG1yTItihbN4BbnpE4eEha+i0kZueQJgKOOjPaMCepxWZU
	4T0u58M5gTECxCEc1scRdLXn/eFW7W+OJDlBp697/S1Jq0vM9pK006rBxPjogyJWgbXH9WrT+kYdB
	7vf7oxXalNAUvzM0w2Gv9xncFbnsc3IM00jQbddLnOuUeX8qe7yLxYZLY2T8V4LKMof/C+dp0KIxk
	A6K3tP92cqIek6LV1ccs6A3e8bhz9xuHuxLNZK6Bl8zVf2uCaJh8Mqe/7fBRiSQrTY7umPiRc4m8F
	JplR9pBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwo9U-006hpz-2m;
	Wed, 10 May 2023 18:03:00 +0000
Received: from mail-dm6nam12on20608.outbound.protection.outlook.com ([2a01:111:f400:fe59::608] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwo9S-006hol-2A
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 18:02:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6lxZQ2vMDU0jPbIkx+f9e0Yl3wd3nhbwRdnVknUKGfULfs8Yzb04wm8YvTlRs9s6u8EV4ojwxtGBs3bisAw1OMDcqTD2Qt0D1slUZqMOFInkrerqSg1uF/gtfIUMl9GbsT5JB9rYu2g4Li4xXBeGAggmKMmx3vqxhtmMx1V8++BvmlasJlXCGlptD06eYRp7qQ2NaoW0LWRGXuaIRVQOpCpBV1CWBsQxfdFheXC5WzBccRS2DIvGf9723nw2My954+fjK3Pklk9eUDMxDf4ugnC9yBJ0d6iJctwSXt/7nbvEqrBqsx9uuV5O6tjnjxkwgPnjJ51jH5O+qPehxm4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b31Xr8z8WoL5BzPeF6ZsHeEJAuO1hKizMheyhTbzna4=;
 b=HZFuSbhHCEIe/bNwJjH/8q6GlrGYszY2wBwJWP0dfAcEC6SZ4aa/5CQRgKqBteXK45yGZZJhb9s8vdfU3YeQwZK20ywkdNy6Pt65DwX5xTRcPIONXjfTUUVEbw/bNu6OxIal8ZE/stK5pZI6+FxjKkI/gf8FKLK4oPU/W2IWKUqOnyoz/JEWkkxSwjEjOxDF9n7iXqfk6c1u81JBcs3j9twQ7NMb41GuDGuECAkHytossZZL9IE+FDIO5kGCrJWsBs2/wGxggPDFPSCGKoZvCrdTGsUlP5KIjH01bPwDiBqk95q5DqafZgVnucFiiLuPtV7HY5S4M+v+gHIOxBSGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b31Xr8z8WoL5BzPeF6ZsHeEJAuO1hKizMheyhTbzna4=;
 b=NzEFZfOxjeQi9ZyS99frm3GetG7PfwuX5E2ATpdI3En6wP4A5tssEBgyFXVS9wRQw+9NsI/1SLS2Fyl+lUnUqvDZcuzOan0qja6uBJ9svrvY1gESQ1NlwbNb3xJygZMrylFyst7UFkc2cyTAWfBZH2PhqlPCmMbybf3e8rnmr/sa/ZWHkq4O4S+cOLs8M3dPn549DyO7s8qG/o4TtUrOEcUApX9nN3b9zkEWtnd/vzxwJzHnh7JLbZaDV4hqLrsFm0ZY14BPQK1CM4AH83lGAWKVUh7Dy2iQW1fSYRfk2kYKSSkeX65sSNheVeaZLBu0nEHZc55IwgIz+XYWwCTFZQ==
Received: from MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 18:02:54 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::f7) by MW4PR04CA0225.outlook.office365.com
 (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 18:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 18:02:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 11:02:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 11:02:41 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 11:02:38 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 2/3] nvme-fabrics: check hostid using uuid_equal
Date: Wed, 10 May 2023 21:02:30 +0300
Message-ID: <20230510180231.18865-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230510180231.18865-1-mgurtovoy@nvidia.com>
References: <20230510180231.18865-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: c4385a01-820d-40d8-a0d7-08db5180c750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	sdJ9PSkl1eVeT3hDcFmXLrtZgW0DGX4VrmOkBbVuSgA7wC99bO0sC7txEvPwJhtFsgAhhrLUtkmUq/5Q/jpPQP4WJXFhhRVypAnx/Q0QUHtvF+uB5EHxtrJfKZcRLrahTUhZSPjTxyWJvbDpIR/8ovyEKfhRzxv787F9wVL/gOWpveBO2OOKInQEBVnx2vLigogG+LSIVVxcFwDK4dFU20qQ058TuYQ/eHzOI9rvXfihaJ++wRAuCFgzlWXkkoRqb5PrvUjBw5+uYlhcG8rb9r3SVAlApPK3ggburac+tgLbVv1FxZJ8PnUCe1Hz2GUQJrmWlxDCP/5RZaFob7uOIukIylHEmOfmOt/Gki29jFSV9TYqbaM05UlOqLi53WVZYfKMLzeTzhCefE42shdPmJV6UHPN+8x9QA8CjmYLSK7AIr8u0gkU5eV3qoJ3jWnW7c9gyCBT9xFg8tijpeQ4ztRP+WnJakr4ngFbqpUR28dkr4c3uk8Py/Dcz+uQ7DkfCmYYY9s5/+llaDNa98JcGPwMh5jaNcXzucVR5mMef58iMXrnbTh2FdBwHDnrDckA68frkBNGg+qxO1W+rWc1Ia5UFDAfArtrtr8F73DpVSVysHbjqWIQbAgw2+zfTr47ukl2QnrH5hA7ePXtHmrshDaI85xa+X6zD5uT94rrz3rhOpz0cimUYmBFDVG6Oo3dxmp2lFPj3jPkxZPjuKW/lvurA2tNDGZH7myJiwJLSiUpoKEBGPS4yNbxQUatzoST
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(186003)(2906002)(4744005)(40480700001)(107886003)(1076003)(26005)(5660300002)(40460700003)(82740400003)(8936002)(8676002)(54906003)(110136005)(478600001)(36860700001)(83380400001)(47076005)(2616005)(336012)(426003)(36756003)(7636003)(6666004)(356005)(82310400005)(86362001)(4326008)(70586007)(70206006)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 18:02:54.3733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4385a01-820d-40d8-a0d7-08db5180c750
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_110258_713220_F4A8E88B 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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

Use a dedicated function to match uuids instead of duplicating it.

Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f7..0f3763283222 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -181,8 +181,9 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 	    ctrl->state == NVME_CTRL_DEAD ||
 	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
 	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
-	    memcmp(&opts->host->id, &ctrl->opts->host->id, sizeof(uuid_t)))
+	    !uuid_equal(&opts->host->id, &ctrl->opts->host->id)) {
 		return false;
+	}
 
 	return true;
 }
-- 
2.18.1


