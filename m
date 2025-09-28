Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2E4CAC5B5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Sep 2025 11:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/tRZrpSuaX8I+XK4orEyEXtetXQCDaKJ7uAkoyMKir0=; b=u/wmX/qRwTHTzvbtidPlH1r1dW
	rUdUiq7RI7hbX0FlJXC8yh+fk2LqIxlrKF3ysUUqzM5Hqd+4+lIZozTuefOpDG7Da07ehn4FEQgkJ
	YvG/7WImO0DYd2bNIAOajyMay3g874+pdsFZlKS8LIz/pQ1/yPUYYHrP9w4w9pw/+uknH3kq+MQxT
	IC/VF8IXdc+gxiQytu9wjYEyxzpBHEePJxSfgyZ6os/ghZXjj/ObxIuyUiO6bwESbqErZkdkVoV4F
	dbzyHiqvrxdWscYjhvKCfEB+bMD0YxUBtXwdQAJzGU8rl/qRfm/nZvHdmlSe7iynrweYxT8A+sVvQ
	sG8ZGanw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwN-0000000FJnR-1cpi;
	Sun, 28 Sep 2025 11:51:43 +0000
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwK-0000000FJli-37mT
	for linux-nvme@lists.infradead.org;
	Sun, 28 Sep 2025 11:51:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9dVU5UynXqJrAliGINQ7XVyLVyoRPuYijqmAY7geDrQTuIvvZ9mNSUmV9P4rKDpYI/PzhTZdrNdhTTv9xiGbUEteNyLG1DdxNO5qHYah9RGn0qJd6ZBLpS+Pcr9zA9OneNw/zGjoNSTwdVj8QES0Ww2vP5NDEERygSTw7D5GNB8EF/4jS9T89yURm34DZPXVq3bBBjOA5X+A7CIGQkeN7TObQ0+nYttCvKQbz4xXuTgKKY1MDA9Qw5s2OGjNeiKIAvu1w1DgdPyqVT1X8EtHfM9c3B88Yi/+ieNLS5JB1UlYVocsm+tB+C57tZGyCNy+H5OSy95YYd4bSxSKTk35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tRZrpSuaX8I+XK4orEyEXtetXQCDaKJ7uAkoyMKir0=;
 b=RY3NkyN6tn495V3d7qPSdo3UnSPwcvBfBIfwPDEozv0vClSQEMVj+xzwmpjQ7her07IWJ2iHREP+zpdQkumV8+b2LRO5zyKQWoOmDjX6wKuSEfMUJxfYfbm3ob6MyZGfepvL2ln1LPJXiYmm0c1+0kKQxW7vPeSrPeAmM5eDBIdrC/6IWbn1L9RakVbGu4qkgR95V796fstLAmGYOE/cqB7RXCBxAjS44Qb80agO72xP2Efx0W5Xwy1MPpvy8EsjxCQRe3t77XzpZyciNvX5vPiZ2RCz5F1EWNP9Ogsvjq5wETPTT2xd4EQALPSPThX3K95x5K0gHXdBbXwMdyqgfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tRZrpSuaX8I+XK4orEyEXtetXQCDaKJ7uAkoyMKir0=;
 b=QdaJnfE3XmsQQnC/yYNI1H94PGGtayTscmR1470XOwr0b6z5IA6G2jyNcovke7zCZK82U2ebAFgtIJA/S15auHxhGTRw8p+MoKj6KA3o64rfa5TxARMRfN86cjexxeu5H1m4WUrJ6YWYNUYnz0VZKy1zko7XpCCzxbEsy8ds2YNqsmCg9enRkpEZx083qeZTmsVk9D9NW0/+b3hQxcTiqcGNGOKwt09OKb0ZMVU+RKQayUY7CZZjdAMFJrHfZT6j9jxYfN+Yk5Zt2NE5S+/yd+sZWzib2poyPXSfDlpaV53g+JXwgsNmDE5Al1acvkxUVoUzxShgC34pB2KyZMf8XQ==
Received: from BYAPR06CA0051.namprd06.prod.outlook.com (2603:10b6:a03:14b::28)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 11:51:32 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:14b:cafe::34) by BYAPR06CA0051.outlook.office365.com
 (2603:10b6:a03:14b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Sun,
 28 Sep 2025 11:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 11:51:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 04:51:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 04:51:31 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 04:51:29 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dwagner@suse.de>, <johannes.thumshirn@wdc.com>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <shinichiro.kawasaki@wdc.com>, <hch@lst.de>,
	<kbusch@kernel.org>, <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/4] nvme/061: increase nvmf state wait timeout to 10s
Date: Sun, 28 Sep 2025 14:51:22 +0300
Message-ID: <20250928115125.38383-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250928115125.38383-1-mgurtovoy@nvidia.com>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8ba4c8-6348-462e-6e7f-08ddfe855e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c5PHsd0UVYraOe/EbXzKEl/siaOdOLB33BgtQoi9771S3JcAi29W4wQR7gCu?=
 =?us-ascii?Q?FIfkZfVWdFxUOex20t4iChCJBO9gPNf7bVvnA0DMHtefzvmyt0sC6+RDUeEc?=
 =?us-ascii?Q?FD87LiwuAaFzz8KxCeHRtcMS9fFbUQcMeG149/44XYKXiIfrUgyKqypDcVin?=
 =?us-ascii?Q?iOXxZ48PWa/os32emOJLLk0++U1X483ASD9vmj6vTgjvzWciR9zSr6xc/qvG?=
 =?us-ascii?Q?85z3UhhKe0IDXWGefO2GAV6Oep4rWcCWvfcPHu4jpMG8h2ZtDS8uFdxEdzkA?=
 =?us-ascii?Q?N8BFLDYqn95QtXK/ktbWyZp0+Cc0vQQoROr0RCFfCjetpY+K3OSHo+iWlan+?=
 =?us-ascii?Q?4KQXeMuL9/dUf+sDmOwGxN8LqNmgTJaUhrmVR6xYv8Wc6fIvbJSh/SIymaLU?=
 =?us-ascii?Q?NYDtLvfLN1TC9iYTMEtMBwfgUO8AA6841/Qn3l5qbY7Mqp06qvwzvD+aEEd9?=
 =?us-ascii?Q?ODhbddtsvy0fhR57AkGGg2JsCQGG+cL/vSSyBPvgiil+ZNKCXBY45zg1XMAx?=
 =?us-ascii?Q?Zirkt4U2m35TYQplPzXcVHBnedQG9WQr0Nn9MZaZKdSdTVDZ7SOmnnEZh8RY?=
 =?us-ascii?Q?AvMdNu3+z16s+it36BP5vn6MohOfIQ4+J9rrq0cd1qUnz3TOtwFZfHYur1A6?=
 =?us-ascii?Q?BgcyzY/Oszc0i2lm7vqpoaau/kj63V+HsjJYboKWkKERQ1V6achI6IgjQDJD?=
 =?us-ascii?Q?TlQVyokc+qusUlb/UCLnGNKfDXU2Sktt09BIXp5xt6gedeUTCcI6gRgQpze5?=
 =?us-ascii?Q?q3IzFt7oHht7PKteQxVWuRV6WuGTT7eIAjg2cFgspTvxkuGVrgVbkB3PGbde?=
 =?us-ascii?Q?HyhMd2oL0rV5wQJYJDagp58geYqqmKzD57oKw/L8e9MmDM/0nmlpoby33cSr?=
 =?us-ascii?Q?qUPszRQ1LMk2d1TD22k1Swo6xbpamVClSFwJNhExnwN4GNrWdXMHT+vzHpjD?=
 =?us-ascii?Q?YWRy46rNRZoqIhz+d9MDGbIkLcRsEDfImTI8MfAY20UHBw4Zp/lUshdT2n8F?=
 =?us-ascii?Q?dStlJp8XXmgrOClphtSVznskDsFj9PsCVW5mV4RFYLWL2J35cWIBzeovoge2?=
 =?us-ascii?Q?8BTq3T7gXKYgzPCaqht5qmSREOLUipOPMQ0ykf7iTXk9F5tTTDlmKAW+q6R8?=
 =?us-ascii?Q?WdCK6ib4mIQ2V1nTIjo5ANhbN4kUYYLxsa4ehp2bSPpGXul+n777FV6zdcBT?=
 =?us-ascii?Q?iabwV1AwuNJ7JtxFbkBFBJ7ZfN/JAWQ5+bEVzihJ/y2zJQ1mNpudUNjV+IVS?=
 =?us-ascii?Q?vF//1gPSMSRaxRJEG07A7fPiyuENbJq8+loTXRJMMyRaByhKh9CQT3vuh/Hh?=
 =?us-ascii?Q?aNY/vACDcnUW/Zd4SFMVB6J3yI4qLGhkMRygvMTl89kaLceITR0C2aVD/Omq?=
 =?us-ascii?Q?TVi9wWtI+IMvUXGNtbghb0fR4HvXJQc3mULmWN9q0jBXY/7NKyLK8Bh/nN0k?=
 =?us-ascii?Q?RjO2+PEkiSCMGnF6Luce9vUsYQirl1g/n4eDVezo+oNF+LMrriOtSisO0Gzi?=
 =?us-ascii?Q?Gn5TlQrRzyt/m2L/44Kj5v/ODJAr9xlOVVcW5nJ3F/s+Bf8aNFqLOgQCrakI?=
 =?us-ascii?Q?O0aEL3s5905EtfmwWrY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 11:51:32.3656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8ba4c8-6348-462e-6e7f-08ddfe855e60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_045140_787837_37496685 
X-CRM114-Status: UNSURE (   9.52  )
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

Real RDMA hardware devices require more time to create resources, so
increase the wait time for subsystem state transitions from the default
5 to 10 seconds.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 tests/nvme/061 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/061 b/tests/nvme/061
index b47e626..f2894dc 100755
--- a/tests/nvme/061
+++ b/tests/nvme/061
@@ -47,12 +47,12 @@ test() {
 
 		_nvmet_target_cleanup
 
-		_nvmf_wait_for_state "${def_subsysnqn}" "connecting" || return 1
+		_nvmf_wait_for_state "${def_subsysnqn}" "connecting" 10 || return 1
 		echo "state: $(cat "${state_file}")"
 
 		_nvmet_target_setup
 
-		_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" 10 || return 1
 		echo "state: $(cat "${state_file}")"
 	done
 
-- 
2.18.1


