Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9868FC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vu5pXr/0fldsPMTpQVIvaqwf9JkMxVaGPBAwpvDW3ks=; b=E89QjWuYgxPy8sAFhUuGLhYK9L
	UXbq5McbNB3ENdtaL/Jtu5BUvivggeD8AvZWyjIbuT4PjxwloPZrmICL92MZUsWLEqlcXsppazIWC
	YvSnIHp3KhMU86sifOCzcYbdahsEyi/Ynt4H9NQ7Ja1xv6eZq7mGCwMmwsiIEWZqaihcgDkb8gorj
	7/nFW9Bvxa18UesYau7nQgUYiwc3oyH+mWoB6nruHIqquMea83+qRky9CjSR6cQ6rRROc0CWwnlhb
	tTDB78fdnPDIOp71j6P8obhpwXPOjttZQSOTfVSSqGjgMo4QAEb8UFHikJTsOBDAGFIvOBtcXRfN0
	r+3ZSbKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBmU-000eMW-1q;
	Thu, 23 Mar 2023 03:38:26 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBmQ-000eIe-2D
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAfxeuqusD/JpqlcC/M3Xeb2guFtiNEgJrsB1FOek08WClGGLT8O2FwRKe7/gHwF2zkSmTcPj969oRzLgnwKfFFkBsWpjh4O8WHErteqPa1hDXyNCBcSjA7930aS4qPzKLVNewpm9CTIlkCm6V1SrpD3U/MKk5onaNjAWHgXjRBnll/950Al5PFwN0GFx1oCn1Ac64xY3Y47rEwcQSUiLl/kz8jJmEoIWSKXG4YnVKtHd8NvYVmml0MI2cBuzDXg1iRmL9Z0xaRCZjwT9ZjC1tTjv5tq97mQtLJ6W6fLF6eq7XzQP2dxR4tTeRjhRk9K+CzdHJjRYg1cGeUNVilOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu5pXr/0fldsPMTpQVIvaqwf9JkMxVaGPBAwpvDW3ks=;
 b=J/OOhOjUJYuT+8EuLaIXzr+XtEhf9YO4YuUeTnHGGk9kY5LoepGw/+8IdceWZfOWD5PJD+ZYfd0tgYw4wC8MlLVwS6zbINgb1Lb2cMtsDc+cT9YQeJxh0KMGGVveI9lTFB1E+zrhpcW0q5Of2NIwoM6sn/EjdgjyEQkBiGQqk1tLXx1YHGt5a21eGBoUNGmzGzVEgGKjL6FvJkY6yyJ43iC8ZVAplaG4VcB7amfb+sV26Hq/vT3HNhn40u/LkhspI3Z0Dvt9N5myEx1qR+UMDlpCtsgMpJhX8rY4IPxs1xgXTLL/zBkEhjkLbO+H422SlTFm54xfjqbDGfQon4eQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu5pXr/0fldsPMTpQVIvaqwf9JkMxVaGPBAwpvDW3ks=;
 b=KR79JtlyX+EiXqBecnKiZhJePx7X5b1Rh6e7MKmNoPr1d+TxL4HmEFCGf+p3XvP+Nt4cZUF3ybQAtQDQI2ntbuVzsY1s2peogU/GOBLh93V110ielRIftH/OqprjY6NQ7+s7rsiVkIyjg3FaI6fD7fqA1gNdgCrPALU6pyqOBXaq9g+c2LJ9YnLUXIWIE7dC/883dfr4ov3TIm6/wOAXE3cmbyPsXXttMpyN5Y6GLt9a76NvE1jlJAQWQi2xSPu9Y9W0iSXZdp3d58gIei7NzqoXUp/jg0lteyUXZ56Knm1YZJYjlbXrlTiZRqwHujPgih9ncYV6kguEu8Yo2T9FTA==
Received: from DM6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:5:190::29)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 03:38:16 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::f1) by DM6PR11CA0016.outlook.office365.com
 (2603:10b6:5:190::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 03:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 03:38:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:38:13 -0700
Received: from zion.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:38:12 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 8/9] nvme-core: remove unneacessary else
Date: Wed, 22 Mar 2023 20:36:35 -0700
Message-ID: <20230323033636.812758-9-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323033636.812758-1-kch@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: ec555b4e-06bb-43d5-3f00-08db2b5009b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	1nL9cIO6maW+8EYjM3nND6kkGAUXfjdcNeGExroWcsnYrV77SCSHKdixW5yVVLack7/AiAL/xeaqK7NG3dX/XzuqGw9EmaL1jfUqT6aBA5dBX75AdtX9U/tBktbJY5upOM/x0MCnaQL+3Li91TIoWoxGWmFRWDvNKDqs1gXGEd8fJXkrwH80EJ9qH/BoDZQrOcOKVPn4Xg8ge8U3cSLAfJZ74QjFqZLdNaioyLAGSqJ4lq8zjMPX+TLSEUktjX8/eti1qwtWfg3QS9zC/i/oJWcU60L0VXd57oSx+ubcJczbqpnZJ/YCWqSMplWzhs9mJBAGHMi6/4SPqZxzqExOmfLQR3+bdQa9zPd1wwxxPSlwi6lt9e4FinL2QnyqSDpXUiplB5YI+OX1oLiJrGJHP4rTKFEinGOmfZoAq1Ng0gFEQjpsU/lhR6N0IpKWr/O6wMQTv4W0Czukb9IiV9+q18YKiElKGuXsEE3XuqJGkl+B/XwoepbJ7q9KGtpZiAMzKQHXwGuJpKpQZTn5dXRz4arUBu7k4fUk2tk9WOpZn+G9zwO/13j14pFZC54+/0V6uzeJYPNqsFxZMUempdEVksABLSeACvxkFuZ4dQ44blrEBHWTnTFqWP7erdAvCCQeRUe+aUktkpITeTbxnYZrtnjUL3dp/FbL8YtXWNfkmEpMnU+NbFPPyO7rQx4LUkATHtIMHLtQC77qXn8TvAIGYWIKR8/0l86ypPu3GmCKZFp84Iw87p7onf7BNE/uxenq
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(478600001)(83380400001)(40460700003)(316002)(8676002)(4326008)(70206006)(70586007)(6916009)(36860700001)(186003)(54906003)(2616005)(107886003)(26005)(336012)(16526019)(7696005)(1076003)(82310400005)(2906002)(6666004)(36756003)(82740400003)(5660300002)(8936002)(7636003)(426003)(4744005)(47076005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:38:16.2008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec555b4e-06bb-43d5-3f00-08db2b5009b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203822_734328_E094B2BA 
X-CRM114-Status: GOOD (  11.72  )
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

There is no need for the else when direct return is used at the
end of the function.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fdcba1dc583d..481a326e80f7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3418,8 +3418,8 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 
 	if (disk->fops == &nvme_bdev_ops)
 		return nvme_get_ns_from_dev(dev)->head;
-	else
-		return disk->private_data;
+
+	return disk->private_data;
 }
 
 static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
-- 
2.29.0


