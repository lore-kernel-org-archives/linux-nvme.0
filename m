Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DCBC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ojAhcpJUHqmE5QU5cWAk6vHNyATJX/TNwCo1mTNtRs4=; b=gHQoW7/BVImrZxAcPHQUJq1+pJ
	/DSKWP3WhN1DTaeIbC6+juh3lPQqwptcfj8ZvJOxWsWGfiJtdntyrBwxkiw5e4CFewkN7TlFBDhP8
	WsIAKjBtXfolOXJw7ghLYcrTxVAZxKFJ9HZEw3Ejl+T1zccJqS8Az2jka5c3Gox1eo+F77tZp7tqe
	IJyzNf4JMYbN2lB62tkSLIxo3HMpCCTjd4ng55Yk2PO7kk/aDJNB3DrQYmyg6/GXB10fo7QiIycRF
	ElrtPmxvlkyfWdWg4uh6Jg7ygS+nJn8aSt9cmR4Ehw+OCM3hRQ8WVm6MloxcVMQRB7uhVJ+8Ib8yA
	s3RYVV7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk0Jb-005fbe-HU; Thu, 28 Apr 2022 09:19:59 +0000
Received: from mail-dm6nam11on2061f.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::61f]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk0JU-005fUA-5O
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 09:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeZXaP8jjl62VIDVf22bAXNntiiXPftz5HuizidmRru6gHkBS8ZqwFO+4URPqw4gSvgaDNHMdSQNDpqSLY0WsQNA7kXteFWH5SML4+3q68WmeqFAGeS4IndmixW/iT+tDpi4X8jXytT43g0MBQNWDGLWhURSedmh1zSsp3Nsf7vhXdcv516IveWxhZYce8+LGe67PyUzOfifkWS4V5yXX1WoYdI4Ua4/MngQ1mC7lsjlXuhkw9+UxQBWyQzP0k32pzyU1qdP5KKgNE2uNcBCKF5MoAurnf9tqVKyCNSePAwBCvc5+L/5RW8fFkpQjCTJLLZjMPZxKrZ2E8Q2sQGbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojAhcpJUHqmE5QU5cWAk6vHNyATJX/TNwCo1mTNtRs4=;
 b=MiOQwCKUhlSDJoABOs47wbXNP3cMUbB7GNREno/0oVldRbZZ07RFtnrshRyaBqwwNTxVB6i8Rb8umcvrYazsjfIaI8y0Y3oKaWXo2dXlrlC1hyYzLVPAr6BLXtASlZ4WfkMRM6LwVbPRCuXSuAf2g/pX1qw+Spl+WpXYMWmZJkwo+wtLLPz6pK1rP8QQUmDP24gpgAV8rwdYalMubQ6iM/+YwFyZ0Uc6a8NlFln2sHzC7iM4nvcCdTgLkmXJzZ/jYZtr6DdmpmQc2+Ijt/BQrbVF9IHXBLAz21YkYYZzc9zPY2MKa9Qhl5I0Vjxif9cfmkAOWwT+s6ij+SXZPerbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojAhcpJUHqmE5QU5cWAk6vHNyATJX/TNwCo1mTNtRs4=;
 b=jAvx6GAdDQSpmMoqNsI6vU/pSEU6y4bgh8LpXZa6FABEu020u8J5ixVwHBxWpyoItTQitQfZR7nK9NUdOTyvmwOPIyQ/xG7fVqUiNn2gEriqkFDhYvYwCZm+/eaaW/bAY1CzHW6I91Gvy/PaUm4N7e+2HRI9x5hzMAft1ONpGZOrUKcfyO/zN4IloFgtsdiycG4kItfDXos8Ajt2g76rnTm+KfFCrN/sis781qbRilWdISANu1S/nPM4Lr1Pa/EqYcRXGaoO58ruk5csMpsXK0esI/CoT5klQwlkAvx0FxhiUykq4wN4lWTPJlLEQIiSumw8xsvMoakeDKQ8kxAK6g==
Received: from DM6PR05CA0039.namprd05.prod.outlook.com (2603:10b6:5:335::8) by
 IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 28 Apr
 2022 09:19:43 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::a8) by DM6PR05CA0039.outlook.office365.com
 (2603:10b6:5:335::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Thu, 28 Apr 2022 09:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 09:19:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Thu, 28 Apr 2022 09:19:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 02:19:39 -0700
Received: from r-arch-stor04.mtr.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 28 Apr 2022 02:19:38 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <kbusch@kernel.org>, <kch@nvidia.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/2] nvme: add missing status values to verbose logging
Date: Thu, 28 Apr 2022 12:19:35 +0300
Message-ID: <20220428091935.35651-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220428091935.35651-1-mgurtovoy@nvidia.com>
References: <20220428091935.35651-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7a0e4f5-b34f-4e9a-6924-08da28f83ab6
X-MS-TrafficTypeDiagnostic: IA1PR12MB6068:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB60683E3BC7CF73535B595617DEFD9@IA1PR12MB6068.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zgVOWZ5JmD7sm4R9KQIdC0P2lSAagq2vQt5DknNlxI247o+5ddiE0Cy6a338lAnZOO317b5H5r40q3jtIWYdO2BO+AYi6xvcPdXKtpyFFydmCS7/LVllVI0Wbo6yq3ODizXn78WWwT5CdgTRF1mTcynkyISGfc0Tb6mTHNPKw/5WsyztgzOJNroX08jj6c9NdA22ihhhCsPV0T3nlXOpZu92z7TgPa9d8BJlrkll+cIFyzfBcXvJUDioJqTM2q6VvioLV3TlVjB1tutlwkfxdKs66CAJBykN86xGGoIAJo7ss0hdMklIANaaEwYwQtMEYuQPgV4FU+Kx9Q3tBcbGTPFLiQ+WMRkiK3Bzlt2NMV4IygAF1G05qQZKHtUZ0NPLzEBDQcKhcgj0daJY7KkBlexslkNwqPKscJb/0Lg+rwPzmEjofYmUysYVr8fE4VqQjd/RQ1do8c18fcK4Q5mkQ+5aiE5VyC+EX6Uc1H7SYq4x+ap1dxbYHq+SfaYUXP+IqtjPOEi9p/D3er5J7LuHQDNRCe3gNyEHYJ+PCaMfYIFiqUGc/vtux2zRFqafI6jd7KdyVcmgxlzN0UtTFkbHemvWtEsyutoNbNJLzgq+yoYRQpstumGChvGyqA1UKIKx82GS9nCQRzLVzJfctU/D7ogkEaGpbEK/QzBASzY3CmXGwVSZFrwlc4TDxz1nG+qh7c9eUxKcFM42WoaVhKXVazrNNHYruZ+heeUy88sDg0=
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(356005)(336012)(110136005)(4326008)(8676002)(81166007)(82310400005)(2616005)(70206006)(70586007)(316002)(6636002)(8936002)(5660300002)(47076005)(426003)(40460700003)(508600001)(107886003)(2906002)(83380400001)(6666004)(36756003)(1076003)(26005)(186003)(86362001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 09:19:42.7286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a0e4f5-b34f-4e9a-6924-08da28f83ab6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_021952_253543_56DDD30B 
X-CRM114-Status: UNSURE (   7.49  )
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

The following status values were added: NVME_SC_INTERNAL_PATH_ERROR,
NVME_SC_CTRL_PATH_ERROR and NVME_SC_HOST_ABORTED_CMD.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/constants.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 6c2aa8eefb55..1dd1d78de295 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -154,10 +154,13 @@ static const char * const nvme_statuses[] = {
 	[NVME_SC_COMPARE_FAILED] = "Compare Failure",
 	[NVME_SC_ACCESS_DENIED] = "Access Denied",
 	[NVME_SC_UNWRITTEN_BLOCK] = "Deallocated or Unwritten Logical Block",
+	[NVME_SC_INTERNAL_PATH_ERROR] = "Internal Pathing Error",
 	[NVME_SC_ANA_PERSISTENT_LOSS] = "Asymmetric Access Persistent Loss",
 	[NVME_SC_ANA_INACCESSIBLE] = "Asymmetric Access Inaccessible",
 	[NVME_SC_ANA_TRANSITION] = "Asymmetric Access Transition",
+	[NVME_SC_CTRL_PATH_ERROR] = "Controller Pathing Error",
 	[NVME_SC_HOST_PATH_ERROR] = "Host Pathing Error",
+	[NVME_SC_HOST_ABORTED_CMD] = "Host Aborted Command",
 };
 
 const unsigned char *nvme_get_error_status_str(u16 status)
-- 
2.18.2


