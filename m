Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4843FC77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjIH+ZkJY6sExw4Zff9uMCqQmevzqmWpsZLUmGlTo6g=; b=EmOPLEec02jKFt17Z93suRy06C
	ihfa4M/h6VFLDFTRbc0iJN/G1hOR/Xf/wAeuQcOUYd9p9HkqwN9/PUM6GoHLr0NCSHSPpf5v9K7yw
	/bdaBCXoqRHQYNHHN7JdgLJaaA029nqQr3UOyQyjPWYtY/Dwx67U7i3IJK/Z/NG74lBHNVWLi1z5O
	HMz0VDaZwRbSvhlPiu4Xx8kfbHUartiWENkNQd2+ApkAZ/Oms+6pIeUS+5dWg1hDr+pbWJHsrHDoT
	LmN3IxNmd+5l1D+nGqw/jsGQSRXIntO7EcDjpPRKhdQutczjxkEYrkpBOQfbLO1n33AxDGgFa7M9m
	1kJM8hzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUuZ-00COeC-1P;
	Fri, 12 May 2023 15:42:27 +0000
Received: from mail-dm3nam02on20606.outbound.protection.outlook.com ([2a01:111:f400:7e83::606] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUuW-00COdH-2e
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 15:42:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjUY3NYjsBzCRTmbGoFqT/BJvFw/iyJehhoGEB8dq7qjfS8zt1AuN8YHHmTdkhzseCIoCg2RwtyNqG6XToGGrV3QUfkzDYUz9L7wsBhd5fFeBOguOmFkkHu+PH1q/B8guV7O+IjA0ovThEWaQJmomGJ5fvosKsS+d5khGZdOkRQ3V0I2IdTe7Uav/SZcaQ471qcC8m9vkShMGhdUhpJWPYdx6M7UMWe//+5uGJ3Wku+ChoaYGBPwEgj3WNPe9g3wzH7XcnA1q4ePayEfx4P/VgmELJepTEc4t0MRwm1k/1yWv115ufsgnoEgFAyqKKxMMggQpgU+x3vNgAXxmQxSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjIH+ZkJY6sExw4Zff9uMCqQmevzqmWpsZLUmGlTo6g=;
 b=CkfvtD8PyRhZHRw54PaCOT6imORZzTGdsg5dOoTei3EU9kVDIc4rff5FoPSxoruhAXfKHOmDQTOjfm2BqoEOvyNad6pWpE7xDNzrsBsls/m3kLfuSk/YmTbdXHpPwvVt4zp625NWFaxIK5IcwXq0ZCGJs6lnzAiKew9QDQ8m+gZIFb1ZZgwir+fxZA2DfPJGEb4h3qDZmu7Hh/1ARsOI4wPI28Oc3Jw+gJ7Yixyqoo5M/dFRpTFOiEaaPoBe83qByxFQSdm6zrQqP8s5woJ9qxtSLRLiGgox13Z+5JpoRr0qPTORbLaLoPBd28lwwzyDKrrzPP0irFW74ZOo37nsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjIH+ZkJY6sExw4Zff9uMCqQmevzqmWpsZLUmGlTo6g=;
 b=eV7vvO4tpoW4AVQrrxFH6SEZzLAyvw5p0/R0p9tVw5+0h5kuafFqTwbE/7WmTWD9+JLzEP6vTLxsEYw2v0HxXdXQu39nlnOwU8N6EciBhqIr6oAKRSDSblzXutyeWCCGrA0s1/qGZr/Ch1LoHhQyz652XYIzMdv6IQgCylbUavh6kE7MENjRzO0/FP/ZOouR5iB++IUgWSfMspOlF4o5Uk93Y/dgil2sNbRVk74KgvcHiiXC3+k4obldPknr+dKcbex9UwLylg9iIn6u0xT/5DG5XYWWxb3iYJa2qNz4INgJ9skLc7KkpAMnc7ehIta1yUlHCXAhCnaOVe5Ww+5myQ==
Received: from BLAPR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:36e::19)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 15:42:21 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::cb) by BLAPR05CA0010.outlook.office365.com
 (2603:10b6:208:36e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.7 via Frontend
 Transport; Fri, 12 May 2023 15:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.11 via Frontend Transport; Fri, 12 May 2023 15:42:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 08:42:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 08:42:05 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 12 May 2023 08:42:03 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v3 2/3] nvme-fabrics: check hostid using uuid_equal
Date: Fri, 12 May 2023 18:41:54 +0300
Message-ID: <20230512154155.38694-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230512154155.38694-1-mgurtovoy@nvidia.com>
References: <20230512154155.38694-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|SA0PR12MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6e2765-6bff-4521-6dd4-08db52ff792c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	x0gDqGIAOZHZCm3OjX7FFGLu/y6Zd7P+j00HPuT1K3Jhs/iw0to+lWsQz2SaaYF4cK37xmJpvTOwaO3RIHp9CjldxiQzGctlAzGWsMGeAA+ycxuEI4r/9uoemgBiSnuRLhhFmtbP8hXdyY4puDlrBvuOU4gPRkdYsNbpDwniyCymH1ZwVEi+wvk97l6F8svleWZwjOjiAmLV7/0hQvZmGLWpDonpJ1Bg3mXjs1eQYpyVOqJV8s9X5yn+BoDjKxKuq3xXpj9MqSHnX8jsH9Sy9jYWzCjLfk7jsw4v9u3+jdOLCT2XAnRLNq/hn4pGjJnYo8iktJC6GLJRhUEy5m1HROD7aaYCOF1oBIlZw2SkwD6Uu7QL9D1EPXmV3AIu4K5izE2mlqTkQzdBwlbsySi+DRUJL2CyXdgxtyD+Aagd+azf0bJSNAVkuGWh/hezPZ2rHYVyhu/wVnj0uKMzJNMey3QChdP/edN2+XZNFzVvFrz+ZWFXtCJuZ19vQw1NZIRmn3UuVbwcdde2oC/0w+DfYf2iG+RzeZYj/7MSzV+6RW5PgTTuYN4Ztbkj+SUAVK9ZM1ERP/lopbBfERCv5Qd/fJ9r31NkKlGiA7Rlc/WwUz7okpHi3Tudodhbx/7jzKuSzBdPAb4XR597d25kHmgfGd/XXFjdhHBDmmxwItEx0GDBk30awWohOkPX+Vdb6y163WGeTGhwFlWIZo6LIs4kJg8+XbPgA7Gs1HEhK/SqapnYYz2zIykQv3v/CZJKEnEL
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(107886003)(186003)(26005)(8936002)(1076003)(8676002)(2616005)(336012)(426003)(47076005)(36860700001)(83380400001)(5660300002)(41300700001)(82310400005)(6666004)(356005)(7636003)(478600001)(82740400003)(40460700003)(2906002)(4326008)(316002)(110136005)(54906003)(86362001)(40480700001)(70206006)(70586007)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:42:20.4431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6e2765-6bff-4521-6dd4-08db52ff792c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_084224_861722_090A16AC 
X-CRM114-Status: UNSURE (   9.78  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v2:
- collected Reviewed-by signatures (Hannes & Christoph)

changes from v1:
- address comments from Christoph

---
 drivers/nvme/host/fabrics.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f7..862bc4e5e3d9 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -181,7 +181,7 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 	    ctrl->state == NVME_CTRL_DEAD ||
 	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
 	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
-	    memcmp(&opts->host->id, &ctrl->opts->host->id, sizeof(uuid_t)))
+	    !uuid_equal(&opts->host->id, &ctrl->opts->host->id))
 		return false;
 
 	return true;
-- 
2.18.1


