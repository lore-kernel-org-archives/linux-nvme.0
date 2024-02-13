Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5284DC4829A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JP4o7b7ZhzF/bv/705t1z6UlvdCr17ts/bHceRvxZFo=; b=b8BUB3zhxEdip1TrC3U1UqSz8U
	kuyPNVRC+ONAW1XQxz3EkCXXCZfNUWMLs3WI7v0SqN8tzP8tR/xZDywyVpPp9QpFZ3MZM9FXTjKTD
	fbqplDFgG+PqbaTeZQlaPdL13sZd1qmzsfM0N9l4/lpNs51KK262bpr13FiCj4JA/9R43Is9sw6tb
	SDaoyoiuayeywKbzicUEJCXTPMopyskeXulI9EeobPCbt10MpWbz1T8y2V7xWOon6gK6Yk06vUUOa
	4vywvCi71LaudYRtnr4P1Ab6ozU91hDtWN4bGOivzQUeWnJHvNvVB/yR9LbNxl3bsCKoukgb8ddjt
	d9O0kVow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZo8L-00000008QET-3L8T;
	Tue, 13 Feb 2024 08:27:17 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2415::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZo8J-00000008QC2-0ghD
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 08:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOEnjAwl3bGhhacWIgyB1m1cqg8o2P32T0kR4dD22qF+fa285or2MiXXXoD22MELN7Xxqsi09y94Ftn84uZRzARutep4NnPL96Ktj4rEnHCKaI12vTMnrFe0uMWjM06tzVhuTQHSLmuBLfnMqEq0e32aESF8kFSTC+QhlDsRzg64KGLZZ9e1ESycx7fWZRC+c+mp2Pr70BmId6jtGi033mVVLgGODSEClHslSu1X11PB/o3gSrQfWGBUBjn9lQlTX3MPSPkXx9J6EvqLT56+CN67yKMbB7JVHYzU6yORm4LxOhbIFxAVmqwzZ+EKMo1TPXMNOhEprhfiIYA0swcRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP4o7b7ZhzF/bv/705t1z6UlvdCr17ts/bHceRvxZFo=;
 b=J2R2wCa54X+J2AQlikzff6hWXwieKTpavU/0CdLVRKrLrQTCxnuymR35UvEPio4zHx35uBbFY0xxdHYTr/Yd4Xzvc4MRdWC3bDsp6f4cpIaUpcCh0SwakgzXbmF8w1GlMhuNY/Adh7LsMgmWOob1dgKOFkx45t+UKSqZvNq/KSEf0BevSZTbMq7WIPu6ArETCKwteJeCagL05EUr2f5ZN//RitAOPknF6Pv448u14rUaXpem9+SrhftEKrItUYrmKAUozVZGVLgdR9V9yNmHM+RIetKZNDu3iez01d9lUdiu8r2xXPjUibbfKByQsUyLzqYJ3oDPuBPMCFkyxqeiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP4o7b7ZhzF/bv/705t1z6UlvdCr17ts/bHceRvxZFo=;
 b=B/IW/gflws0OVTLFBDDEhrEpGzkbOEi8hHy+NUIXJND+P9h/+3mys+i7MEA6X+DYf1GFWa5RVfqGF14J6SsH0O/R/1NH6DQXSWN5nPQWFWBJVz8tUEJk6kJ/Q0jYBZ1cX2wtvxbhZTtEtTp2bL67fObIpnq+Eei2jCmHPWgJhzygujoJbIMNNw+0Yn4ht2WkLlstQfNtmwyyQUxxuW0l5kxjR7lQ6beRrLJ+LHxDpdIkP+7RKVzUUxFqSloz45OGcCmDaQKrbWafgoGbnN2LjYcA9lDNq9IYN6lfjyhlnI1AtxArM94XgSRDLjc3mqAPrG5JCatwUcFk7SbHIWf3hw==
Received: from BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::30)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Tue, 13 Feb
 2024 08:27:08 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::34) by BL1P222CA0025.outlook.office365.com
 (2603:10b6:208:2c7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 08:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 08:27:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 00:26:54 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 00:26:53 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2] nvme-fabrics: fix I/O connect error handling
Date: Tue, 13 Feb 2024 00:26:46 -0800
Message-ID: <20240213082646.49308-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 37102cc9-7031-45a1-fc17-08dc2c6d9118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNAZiQZwh5pf9pCo4tzzOdzCYfnd7lroBH0FHP61A9tYWxFVTW9txEY0jeurGPLqJQy5jOuE/cJ1RTr39CFgWmVpKl+OJM0JiGTv4TWTn1E0J/ajG1drjANnR6OdZXvuDwxWMuiWlnzUXhN2S/zw0h7lcUfZGeFJi8yGO+7CX64LHXcod7GrHFM1i2onbUZtEcYIQgT3BBpXsy+6uV+wRuHPMXqp+vInN3ZdT36q4u6e0xNL3KxzbQRjk0H3VlB3J/LVmJ1yHO0L6iEPVmCosMfbYG1eGeAhmXM1l0fQZMZGfwNz/XUDeceZ5dSdp4zQ3DP9E4xs5jHFNTcJ6Z/okQktMkS6t+srGGGmXkBHWsbqnvNlWYuJ3jLPIPjKNlmL6G3DL6QDo4eaNy58+uIkHOdPLWviNKI79If/ibc3bFlgqeUYm+jM5qNvmGWEqvI+nmsrGgApVjYi/Re29VgYrXc54N8UeriQS6QE3sTKLoademNmZeQK7VCTPHFbiQrwMEP6n8Ty+sKW167F3FkwfO1m8mtUmBpDJ8mQAzC4S1jd3En4Zs/sqXHCqhu0C4lOLInmsIHHfss4MD9BFY2o7ikBtQsiee6DjiyJ7RpTGSQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(36756003)(41300700001)(70206006)(70586007)(316002)(6916009)(54906003)(7636003)(4326008)(5660300002)(8936002)(8676002)(478600001)(6666004)(2906002)(82740400003)(356005)(4744005)(2616005)(7696005)(426003)(336012)(107886003)(16526019)(26005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:27:07.5127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37102cc9-7031-45a1-fc17-08dc2c6d9118
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_002715_288602_B4D0CE34 
X-CRM114-Status: UNSURE (   8.08  )
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

In nvmf_connect_io_queue(), if connect I/O command fails, we log the
error and continue for authentication. This overrides error captured
from __nvme_submit_sync_cmd(), causing wrong return value.

Add goto out_free_data after logging connect error to fix the issue.

Fixes: f50fff73d620c ("nvme: implement In-Band authentication")
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
V2: add fixes tag (Christoph)

 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..495c171daead 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -534,6 +534,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
+		goto out_free_data;
 	}
 	result = le32_to_cpu(res.u32);
 	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
-- 
2.40.0


