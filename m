Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53013CAC5B5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Sep 2025 11:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wja/M1s46qsef/aM0/hjUjVh7Y/yNp92rKQZGEQXbU0=; b=ujDX4V5aivwZKSCMVBggW8aPvc
	YEPsChp8q98OE3ADocUqdoBbWJxISdhRUqaPqQnSjcHAfYheSffZJfQOIUYAlRDIlblvPDeWO6xxH
	bfOMWkTTmb+vlq8FtlRf6AhU8Z+IbIPigO/Ks0Juj/9RJPyPdmPcs4FQ3QPMPBnObS++FTK2/lKh+
	kEgB2bovilZECcHsmq2bk1VE1SCXpuyioduYeFWMMJeuAH8hZZaa0viHC/F+U0LlzJLfN/R1hMxuA
	v9Ezrrcsm5BclTdkGvybBfWm7Tc04VY8Lxj8tVjysnktTGVIpwhfUbRneCWkxR44dOPeJck2Xalm+
	2UqCGdAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwb-0000000FJwq-3TlH;
	Sun, 28 Sep 2025 11:51:57 +0000
Received: from mail-westusazlp170120002.outbound.protection.outlook.com ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwZ-0000000FJvI-3SML
	for linux-nvme@lists.infradead.org;
	Sun, 28 Sep 2025 11:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqAs76eEAyuttboc4XLL19W+jpQces2CArUoO655L5/8losqKec8Izss2s7S7oQyxkXzl7PswALgBCk4btNYnj3vCPqJcJveFy9PNYR6aNT4UqxtRkr+PNZ2ocicEkoQV9lJtxoUJDhTX39549Gqn9VE2YHAACZPfXbwa5g6FjupEoNco/37L0ZeOFZbwaORUie4bXpEoka5SvRG0tOcplsIiwQz1Y1EW8MxKVmmmXYoUCDTUG6RJxtIeQNfCAbwl6YsQ8+57CL6/RsHsLSVgDS9kRK2/sYpcRyMm7vwP+pmkeb2RWIjnXv3te3JygIE+c+sNKfpLxJj0EqVgkzmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wja/M1s46qsef/aM0/hjUjVh7Y/yNp92rKQZGEQXbU0=;
 b=G4xQu5htSsCois+kTGONEde2wzVwHlAmKgfTqCHUup+Noheizpz2OKS5tf86Cj9asyKE3i9bX6qNPZYERH2t02Ymoe/H7KJ7Xh23NfjG2QOBU1aKfu5wOJE6s3bL82+n9zX2u61ZMp+HFbwKUZ0h+3MHjk5j6678VLoghWIl3rRW6sSMFeyYa8wB3lWBmyFWLh/ATBlUkGDdsbPri243ro7kyhm98xPEGh+Ukx+iE77zqyk1xFvXOUftiJJtFXsALbI8aX01uOsN5eNg7nPR+54fbg9AC1jGWZBrAoDOcpjwDwI4QxL9CjAbDkQpxkNM5VMZXMnuhvH5ivI3Oo4NeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wja/M1s46qsef/aM0/hjUjVh7Y/yNp92rKQZGEQXbU0=;
 b=fj8IbuTLJJ6IMALZF1lJDJoXrrPXQIwAe6rApQUrshVU4xckK6C9MNXnApKoH0xPbvWHJo5s5yXXB3A5BmU6dUTgcwcehJxOyTiK1UAxAk9n9ARVuZCFbDQxdJqvWsCGmnYD4wwZ4a3wpWQGJ7n0U4ouWxaU83G0zJo8Ai+MK19v7uzUeJ9GWzAue7eaGIqSkibEYAeZs3FbAFaX/aaqKqu5DyctK6yerxVDNhRjiOjK0al0YouE9vDN7+w2M3L49gGU3gtaaOnAqc0vS5HF8otV2alRpA457rzyPb6YPoDZ+On+I4LTBCfbUj3XyLJhzeqFlfrUc7XtlQUpX7RMzQ==
Received: from SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::20)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 11:51:40 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ee) by SJ0P220CA0013.outlook.office365.com
 (2603:10b6:a03:41b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Sun,
 28 Sep 2025 11:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 11:51:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 04:51:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 04:51:37 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 04:51:35 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dwagner@suse.de>, <johannes.thumshirn@wdc.com>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <shinichiro.kawasaki@wdc.com>, <hch@lst.de>,
	<kbusch@kernel.org>, <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/4] nvme/002: extend test to support TCP and RDMA transports
Date: Sun, 28 Sep 2025 14:51:24 +0300
Message-ID: <20250928115125.38383-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250928115125.38383-1-mgurtovoy@nvidia.com>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a21f5c-896e-4fba-3045-08ddfe856300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VLcSRLt4xI1sGOnWMpG++0b2NjKX+E3EY6FgO5bMC/ur1I0kZvYXyAk4cBqV?=
 =?us-ascii?Q?MBQjuPzCQsRBsvjubmjMpy+93bjkVMdJy5QuVD9x+pqAiaaq80PlrXprxyqo?=
 =?us-ascii?Q?eHAIxXTb1WoccgOV5od60EC3QryfZWgT3rlBYpaBdguUotACXhcTd3nJK/Zh?=
 =?us-ascii?Q?BXyRbDlTskPTW3U+gvuGPwpyAx1XjgmKyW3SbL0QNlbavw4vPL5EaJBhdk8f?=
 =?us-ascii?Q?6S6ZABANoDR/2NQiotlZs5ElXexO5aFtO/4iONMM7DgszlbWHWevNr7Sx2sA?=
 =?us-ascii?Q?3aE4JpofZTz+2l6DICCqJ9W3O20xNX6pANrr5ycKZvwJ8pIIDEsJby7vaxlg?=
 =?us-ascii?Q?t6On1s6Gsghz/ShGv38DGp3psFtrhnn1D4Q9YQkBBSUJoIwdUdsc531BEdqf?=
 =?us-ascii?Q?a5eUQgHucUhTdvohuanLCmmjK0pVS5q2XYLiEbJUaCdUbzQI7045cQ/TJry9?=
 =?us-ascii?Q?pqIkKKokSuXsK5p7sc34wJO9lzNdIso3UFTFJzbesl+ZQaXMR/eQ/23wORFc?=
 =?us-ascii?Q?hg+LU/98MFLN7ZryKbbt50mjm4N3s2mIQf/SvxVQg9dvaOvU5OARnBYiszMV?=
 =?us-ascii?Q?zDfoV6lO3Ct8BHQTooeR/yl0pcWIKUrRCaQIlbCS+ASe2w6unD/c/OhTgYwd?=
 =?us-ascii?Q?7MpR3sxp3S9eOV7z0SOI/cUM1RiD85HJeipr6QedVgU5b7B7JFlPmL08xJ8V?=
 =?us-ascii?Q?w2rFcxb950vzgIjtp8F89JzjmaUEBgC+zsdWgN1LAi2UuSK0uT8uXCb4/rXV?=
 =?us-ascii?Q?zt0DlwS5uNtBs+Up7s7Tb/WHdMdH7MpXtr6FxB5p+LORjKlRekzO3nawhh22?=
 =?us-ascii?Q?GhEEq1bWocXWSajLc2k+zugYnewbbB/J79illtpbcNbDX+Mswpqhab2vUWdR?=
 =?us-ascii?Q?Koqg5E1NgAtsviK8Ef55v1zkZvK7J5CO1XArqEeNQlO5TsVjBgSH/vwoF+Lk?=
 =?us-ascii?Q?938Dj+U3SSBCCKfjrctIOjIqidSt0b4c+MGQlx0frUR8y4H+dgfD5Eai4/Ch?=
 =?us-ascii?Q?JLJoIB9JshW30rXzUiznz11Yxc1z1ETvOlWzCW2hmcFXiAs0o4hOLfXwoRPd?=
 =?us-ascii?Q?n9qMhaMKwWkC4iKpANKdiIoaYXLxISOr7eRlK99c0+admI0g6xt9QvJBP9Lh?=
 =?us-ascii?Q?6RqjV+CiY0myWrXsKGeQ4S8S5Z9363TsTJst5Tz8sz/ap6O/nigzH5Ljx0xm?=
 =?us-ascii?Q?jyqho1CU01wjvvMNSNz15Pmx4XygabCOUOeUDFidPYFD6QJDaG9RiHIYy41R?=
 =?us-ascii?Q?7aD7F3Nf7vaBS7XEbhuzuCK+7q8IE4GUhf7qs/YkAacWgXUImzPqFT3W85vo?=
 =?us-ascii?Q?haMH3KyhiW34PIktHvuXU9Cuhib4p8LDdGXZDc7/uppd22aNASiyMpawQrUO?=
 =?us-ascii?Q?Rg/3wVLw+2ZKEkOvDXDDVOsyGDTpaYVofUgRmmpKwpLuBjexXf/zZcVc5ik8?=
 =?us-ascii?Q?mdIi4gwi39j9GcZMfN34U7a4WDQz/wzfqU/8MYgB5qoXuK9ZBaTjYQnhZzNH?=
 =?us-ascii?Q?8uQHU45vijwS86j21QbFJT5ZWz0qwK/zrNs8g73LP2opDLuHj3oHgVT6tAya?=
 =?us-ascii?Q?9+Pos5beruxeSX2dXhc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 11:51:40.1299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a21f5c-896e-4fba-3045-08ddfe856300
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_045155_867132_B0E0C313 
X-CRM114-Status: UNSURE (   8.91  )
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

Expand the transport support for the discovery test from loop-only
to include TCP and RDMA transports. This allows testing NVMe-oF
discovery functionality across different transport protocols.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 tests/nvme/002 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index b87570a..64c84f9 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -12,7 +12,7 @@ DESCRIPTION="create many subsystems and test discovery"
 requires() {
 	_nvme_requires
 	_have_loop
-	_require_nvme_trtype_is_loop
+	_require_nvme_trtype loop tcp rdma
 }
 
 set_conditions() {
-- 
2.18.1


