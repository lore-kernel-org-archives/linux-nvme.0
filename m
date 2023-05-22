Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C372DC7EE26
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 13:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbqOwE1fVztGcPNih4yFj+XDvLq6yysn56qCdgsXrFI=; b=LpbsBwIxuUCus1FiY8YedPPdS3
	MCfsHRi1LXGT+9bnojAu8xJXQ6wQj3gbsNdWu5qxQEhrfPBW+gIm+b7/zWH1lOo8G6yYOx4qShVGC
	Yd8oR1+hZGjVspJi0H2muShyublbbj36PW2bWEUe4K4QStII/gz9lT2PIwOcQCvvllPUij2eGjqzo
	PapU1JjDzGdF0pfB+vUvBVC+T8xKMLZMuTv+7VDcNNAlrUHDKWy0UwECJLIDqTdiMgRsh4YILGmbE
	5nOaD9/g0PtQzSZFXV3Qa7g9XqOjbqAxoxsZCtNuA0RIVwQUy82423sti/l2pzBk8HV/jIUzLnqtL
	OajKCq/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q15De-006ax4-1n;
	Mon, 22 May 2023 13:04:58 +0000
Received: from mail-mw2nam12on2061b.outbound.protection.outlook.com ([2a01:111:f400:fe5a::61b] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q15Dc-006avi-0S
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 13:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOT3FwU1qGmOEtzZUfSYIeOm4tBrpjaFy/sIzyl5JTurtyszbSzPlu2AFb4OHH5lP6QugMAUSzeeivJVDHfR8NFE9Hh/3eluutZ54d+b1f2ZVNBDBpMNx2vGo2Se18+D0UQzyvjfMkq26k/BQLyCFypgbO8yfRhdaZ1+N80KrI25PFha8NiD6JTuDjiHEz8cvPurqk5GFWRCV1kvELD9hG17Zih4vD+ZCp1GuuaDzcoJhhTODO0sOqicsbAcnf+Q0KXPhbiIdf35yvMo8b4ZD7OJPSFOZkkM550DFz4TLvWRUTZ2sXc+sragKZMv69+M1+LSl9FO+RqFzV7o42vQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbqOwE1fVztGcPNih4yFj+XDvLq6yysn56qCdgsXrFI=;
 b=FnX7+nfhII2QFc6ogE7Ki550IQVzopixEQ+7OnRCdW5OSOmQlx6RW5Ej7hKrN4RoAdkuDXz9YtaMAxizQnB41ETozJHhlz3jcPglIdqUMmsDkYXD8NfUEPidK7V9pnvEEck9FBZeE8dXceU7Gzcx9AuQogfx9T6Y1134fYsMNSyLelIuD2DeqFxaJ2jd2zyrhlo2cMJXuefgYT3yxciJKxUHwAZGhSxj6FVj3LoyRY3wjLHqEwNhO+hg7JKRS9qpRNT1bwFcHobwMOSLOf08SqBL1ae+E+dwhmUhJ/wN6LVzPHHxaRmfj4V27yP9c/8Ofs2YVZnFRLf1soAY7WM1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbqOwE1fVztGcPNih4yFj+XDvLq6yysn56qCdgsXrFI=;
 b=WslzbVkxs8jN6JrKO8AQ8JUMiu54YzDXPEX8osq/suLGQG6SefAdG536aVoagGKQv2YVGGcXc4dgiqPhTq264LnYz7fWoS3nN9jmZ+UEpJqDqqS4rc6yD2JTO8ER5plVOrSQRrDAUKEtbn7EswNVusgZWD0w7vFusFqEeJ96JofB4vmOxiSHPDbmHxlfObTNmRC6uDr9x8zgLm/U5b+NkBkbrPNcF261EbdhXdnXbsk3QHJh6P9aEJDEsS34sTrm4ftxzKU4XMmbzK5IRLjBXHBIz+2tNTdsC+r5TM34RXeIZ2zN0ZAkf+2G0uoPZ2mxGv7iOx6D5dcSRP7ugSeTkw==
Received: from BY5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:1e0::19)
 by DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:04:52 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1e0:cafe::6a) by BY5PR03CA0009.outlook.office365.com
 (2603:10b6:a03:1e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 13:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 13:04:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 22 May 2023
 06:04:38 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 22 May
 2023 06:04:37 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvme-fabrics: error out when connect I/O fails
Date: Mon, 22 May 2023 06:04:07 -0700
Message-ID: <20230522130408.105328-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230522130408.105328-1-kch@nvidia.com>
References: <20230522130408.105328-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|DM6PR12MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: b65bc5c2-5de8-4ded-0491-08db5ac5216c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	qy6J5aYX9BNvFjMik3l9PVwUjIcLkBMbCBgj72mQKLo8o/CrQnhMP3+vDKWULZc3Ox/l1c0INuTpQRsmGYeIYyG7GyJD4r63d/o2TPkRj1mYCiJR9DmzujLtqOZyBYdplkyoDETUa9CGgpcOGCM/x31dZ3Ce1EtS+XMX0ET7A0T5scSP5UGMVuxT+r/vM/MOxSaARlJQXK9E6mHsblSNgBhSN8duwLv/50J1UKL9sMzGZgfa8aE8xbX+ecCIJYr50FJQJBdXuYubbXSuXcDD02+IBZ8XCKVN91hN6lK+NFDFPbZrTlgLlzPh4JKfxpDsdBdQNLPyVPuhOE1K6X3pQgfuBNBqdiyxvraXz+2xF+k3wvFykha+PlhWzigpbQ5G3nkEbBP/+GywA9DhNun/o+J+HCmdLBrCA5P2sSt1D9fMe2wI3gFhlUMaUb+oRQqHFIZ//ihtVLx4upt3RWPF8rqHcFS7YgdjVQhPSBUkNerZrbkOUBacUbqkmwBHwySNvZpAyqYjYPatmX2eb3nD1UE3HvvLubqkTtlpPuVqwerr3EYzOaQ1K2jtnlo6xhesb6HGPSrIhSSsPq/zlvB2OB3xfO+rVlSAkvk3eSLm4m+jT8xnljgdn8+nc7JKx8fVcg3BWXtgD8lHFZ+cqY6YQn36xtINqb3Bq72W23skCqsmNaKt9wTWq/Rtj2hv3RsUB6IRKAXz9IydIGrPIO/wqVwJ4oSbWLBpMqvV4WrrRNE7blgNxkYPmj/46FWs5Rkz
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(316002)(54906003)(4326008)(6916009)(356005)(7636003)(70586007)(70206006)(82740400003)(41300700001)(7696005)(82310400005)(6666004)(478600001)(8936002)(8676002)(40460700003)(5660300002)(16526019)(186003)(40480700001)(107886003)(1076003)(26005)(336012)(36756003)(4744005)(426003)(36860700001)(2906002)(2616005)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:04:51.7435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65bc5c2-5de8-4ded-0491-08db5ac5216c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_060456_192417_E0CD2567 
X-CRM114-Status: UNSURE (   9.27  )
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

In nvmf_connect_io_queue() when connect I/O commands fails we just
log the connect error and continue processing for authentication.

Add goto out_free_data after logging the connect error to error out.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 529a86aea5f5..9d3df63eb49a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -548,6 +548,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
+		goto out_free_data;
 	}
 	result = le32_to_cpu(res.u32);
 	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
-- 
2.40.0


