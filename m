Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20E2C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oQzt6DSnh8HNFaDmjperdqEls3Dn86BsgAXHZnqrEDk=; b=dZ9dTewyJVl6dtZHcsF6qzk1yf
	QNemFkloG3JOVK72mnfsvHaCeTHQnZPWFhYeTfeO6gL6Ef4Wpd0ewkgp+u11o1FmczjpY4VQ7pH1b
	MlikbibNqwwSoK23OkXd/0wZ9bM7KG88YD55P3NrF6aSiyUNtxb1uqkFIGuUr9BrTKbvxjliUASwC
	dBu4jFwIFHqekO2e2oR6Zofe6nWoIh4wgmVhtAhBp28+qLKFzNbdXkPgC37QNAT5d9EdK9sgV7wFN
	Bd+4xU+4H+j8Ef8VrSnqTTZGIOLZcpJK59x/TCtCHCVAgE9KX++b87tzS9LBxcxZ/wAETgE0a83qK
	5t4NM+nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3OH-00000001Yti-2DsT;
	Wed, 31 Jan 2024 05:44:05 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2009::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3OD-00000001Ys9-3vgI
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 05:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR+WBvwmOKZlerBLgHvrT486BdTPU/Zo33mrOWQX8zZUiUIoqhxG+V+dpKUbRKuG6F0vmQKTYYUoX+F0VMYSOkd8KfSUQ1WrRVQqDX5oFy8fIwV3/uMuP6j+s1ikZCLFioOn3LijU8l/X3oT5gO86vNZ5pGJpkxXrGiU8NAbEw7Gn5eRN/OixsEuKUtlkDxkhMzpQL1F0U2BzyvGxV66B0K3TxIjASdN/BuxWbMLCrAHZYSjEtLCXLB+XRhT2uQiExTPLxhUCl4igABzhgb+bFtegyIxs3huTvZ5697xbmHqMd2dNI7hJCPhSu0FVbQ/FutYhraBjC+QYiV3D/JVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQzt6DSnh8HNFaDmjperdqEls3Dn86BsgAXHZnqrEDk=;
 b=f3pFSSpzO9CDd6K8wWBMj2wt1n2DBfBAmMtbFUUfV4Zlla6VwHgONkkJQkqJpcOtBJOrVn5LUyoUlNFelKDcGGbK4sISWc73jdFb/fPL4NpFjhlWP2kwZMBfNk0cfTIt1Kyh4D7yvEkxJCPKMQYsbsSb5YxDpy1kH8BMEzPgHuTXS68W8spgd11bmoT9rbxdm8VgXs/9Cn02tw4/NfNwgQnbrOXwViMS9eDrmKN8/ghAm/Jol4URtbcahMEY6U+y0CT42slxHQ+4IO0PYvTUQsIcdEuKLfbufzzldguW9BMAF4ZnZ0qoxxmK0M4Ijm9bVaS3Zea28Me4DebkZ2tI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQzt6DSnh8HNFaDmjperdqEls3Dn86BsgAXHZnqrEDk=;
 b=m/l2Uad4JC/kCOnnCyKe+oobIBG9Ua8Xmb9p7UDCqkTmBdXHqyFpqqBgiXh7SmLhlxRThMRqEAw/NdCH27+oZD8YCORziH2p00NgFO4JEqbzvzy3Qy29kPbTqOqaJd1dIcw8X2PQfB4tCugBchCysqa5YrbhnwJEOGzNGJZTeNk8Dfq/mCofSCO/8ZCPci5OuI80p/fuDbHrtQxHzF2fnIg1QkKsSbYryMVYLi06xIak6OW6owylCS8MD74ZLWFp3UprPs0uE7GjgFYmDQ3ab1NOKpO9FXLG5UXAsJ32jnJx0971jYvpKPeHFAAb3mug0fZWx/jwtlYQYJG1Y0tWLQ==
Received: from DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7) by
 PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 05:43:55 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::e6) by DS7PR03CA0309.outlook.office365.com
 (2603:10b6:8:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 05:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 05:43:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 21:43:42 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 21:43:41 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme-common: add module description
Date: Tue, 30 Jan 2024 21:43:25 -0800
Message-ID: <20240131054325.47405-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: f52ed328-b0f4-4a80-fb16-08dc221f9c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSPwExv38uphgSovc8M9EDnlEvEJJiXpcO3VYvGGZTS6f8JITH6Zse2Efk503CpAa6L97LZPDowG/6Gu0OvgtndmHskWb79eoTl9WLWJmg1b8Q2Z1wqL5LOqBZb5w1Wgx12JTkmCRq+5wdqwrUfbBfbBTH6BSrrCi+Ljywi224vZmCNoPfJDYxfT2MkERu8nZWpceRsupwXpklbM0CPOT3YWsY3X5Me/hXc8KpklmzoAzkuYqo3qfPQKeK5FnYk2HT9wKyiGr+V0dTACsgUB7EQtg6rmwsrSioA3KQZ1vc9vGUrtBobjUKYi18RS4h24FsEi8ezOXvu5Htp0qG+CfgMCjxuzdw7KdVB3tw9wure3pCCCRNjowWfZvtsus/AmQhFVwxzJBIfd5CJSYrT5Rh4spsauqNHYAyrAZUW8LaMpfK+VE+rRkDfi5DAZK8bs3/+GvEQfFgShRD0xEDrlepRaKAwSx+Yq1J/GXDnnEwsHy9t9kjuzltzvyj6t0UiU7dJDI89IJbaFhu5ZCTJHn/4XaHDKdci5WG0Qr959WkvrW0qjilBQD7gyqnOkVKlHdKkn2ONKErFyhlISOHTTiqt+ea1yH3GHUOGFLY9GIWNP+y7/adh93YTihWE/U0CsjnSb5aYZf09o7wm7j8/0If3lGpPgK8QUsbHO6NbUZlaV/vkXHpw2EG6Wkx8Fyw8djr5HmnuE5vXoSihofWHGtFw0hWXkoiZO63s+GeCgc2bmqg6OCbCSv5vwPB1Y//KExDi89qbVMsA1pIlEimMqcXfBvZ+pYY68lH5B8xsNpKk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(41300700001)(47076005)(2616005)(336012)(426003)(16526019)(1076003)(107886003)(26005)(356005)(7636003)(82740400003)(36860700001)(8676002)(8936002)(4326008)(5660300002)(2906002)(478600001)(7696005)(6666004)(54906003)(70206006)(316002)(6916009)(70586007)(36756003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:43:54.2185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52ed328-b0f4-4a80-fb16-08dc221f9c70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_214402_010163_19699499 
X-CRM114-Status: UNSURE (   9.53  )
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

Add MODULE_DESCRIPTION() in order to remove warnings & get clean build:-

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/common/nvme-auth.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/common/nvme-keyring.o

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/common/auth.c    | 1 +
 drivers/nvme/common/keyring.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index a23ab5c968b9..b707e6b7d263 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -471,4 +471,5 @@ int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
 
+MODULE_DESCRIPTION("NVMe Authentication framework");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index a5c0431c101c..394c3948e339 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -181,5 +181,6 @@ static void __exit nvme_keyring_exit(void)
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Hannes Reinecke <hare@suse.de>");
+MODULE_DESCRIPTION("NVMe TLS Keyring implementation");
 module_init(nvme_keyring_init);
 module_exit(nvme_keyring_exit);
-- 
2.40.0


