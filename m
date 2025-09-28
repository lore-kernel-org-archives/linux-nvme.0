Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A10CAC5B5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Sep 2025 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qsI5GwzQjzRTZnuO9OD8fNnpWUiEwRG5cB34YKNO75A=; b=hHBW8YTKwq37Vx/1CLXH0eh1Z5
	byMZpVd1QJOi9NMQ7IsRDvsKsQWNvlMesrG4T15dZM3w3/TCEKVwo9RxMXjwReipbvFXrFqn6v78n
	91bZbhZDmp4hw/z251GdvDRiyDqxH/7f0HJiD7r5M+l/Vwjv7w2ceIQu6+1/ub1h7dMBaKyicLLwR
	QcWAX4IflwFNWPrcc+QYNx5qsJ4aWG8RqSCF9WMEVbKqS3DP8XdISZlduI7FwLXvF9ZkSbNIkNtXC
	yH1W4ZDGsm8NSIJWU38Avg1jgSwhclRJiTrY6fDNZP+019Ki9s5oDLhXZp+JHK0rjq7b2ALPZ6P94
	SgASdq5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwf-0000000FK0v-2qva;
	Sun, 28 Sep 2025 11:52:01 +0000
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwd-0000000FJxb-10On
	for linux-nvme@lists.infradead.org;
	Sun, 28 Sep 2025 11:52:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBK+ym0CNpKHhbYCdM4eJiyImJmqzO/glY6dGBE904vdiCvTY+SQqaKSGobMe0NBDBA68CPijxgNDCSI6lAc3DqRWN6dCZvFHbYwMkG5BZ9LGU4VJ9nqkABiiPiDWrkzaSF8IuhdXWPAOZDuvPKz6K9eoTYkANJfnVWdD67Wuxdg9cTTR9yOEupBLkPETaMOhAnSv0QLwgPNC6BpFAWCc2DBqgQhlunB56cC2vdfnu8xahwEed3vXtOHUo0mwg5kBEHsfsmQi+n4+nrFXsnR0M8mCREJGuxscotfeoqZdEuj+g55igRd2aEtmfiLv1rd+Vf25KbI8DpxLS4vj1uRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsI5GwzQjzRTZnuO9OD8fNnpWUiEwRG5cB34YKNO75A=;
 b=NI93+iyk3xnlracVLFP8Oaevwoq7LYwum6X3t+k9DR0ar31985MciShpt9y1upG6iDH0ym4Oxiw8564MUlIX7k3G9UqXWEr9dgugUUqqTVeFFrjfpLoT6231aSre275CCiIZXMV1Dm3MzkxgjLB01xppvctiR93o0Xc5X3+6j0Sg/Ea4Y/zEK+tbQYjqWKx+/lkdTTzNy0GH0k29CzCAVfiJq0DhXdDuhmBbZ1KUHOlAvKXlluP0wZxXMUs4mqOig//wnYARIwWtj+XuRxFfq77Ug9ZiHuy6bOi/sxOZY/XfpNdN6vjd5DKze+lYUuAOFHSdpEYK1jFxMe9DJPJDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsI5GwzQjzRTZnuO9OD8fNnpWUiEwRG5cB34YKNO75A=;
 b=E5tpcMVYNXz8b8wP1Kh3FSl40d1Zh7PkjenGvx01fzd3mxv1nBxiormDfJvyNLz8GrLxpv8XkdcsfXP9kzOc/pVsjmqQxBUCKI3XDCKNnAc2GbzgMi45iOq/ppApepH68f3aUD91mCh6zRTOnkEALcFOWQa0HtKqMuo1pfEZ83pGF72FKwYe1AJLIj1/mdL3+ko61pHf4pROUAMq/quhXmJWmbzViU7iHneGGZVKLdSsSUfmVbIYNAPGX7T4iS7HprZVUlY5kAqxakuGrtl9qX3O13MVqABSh5piDB+ozZ7gOfq+L2xL8H/nF8hreNvtn10UycZZyx+Pv4CneM22ag==
Received: from PH7P220CA0090.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::13)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 28 Sep
 2025 11:51:52 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::8e) by PH7P220CA0090.outlook.office365.com
 (2603:10b6:510:32c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Sun,
 28 Sep 2025 11:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 11:51:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 04:51:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 04:51:41 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 04:51:38 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dwagner@suse.de>, <johannes.thumshirn@wdc.com>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <shinichiro.kawasaki@wdc.com>, <hch@lst.de>,
	<kbusch@kernel.org>, <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 4/4] nvmet: add --qid-max support for subsystem creation and setup
Date: Sun, 28 Sep 2025 14:51:25 +0300
Message-ID: <20250928115125.38383-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250928115125.38383-1-mgurtovoy@nvidia.com>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e88291d-2e36-4a5d-f26a-08ddfe8569d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P5Sx64QdGUB628b6sNZI/3eTZUZsovEHQZBfOBdQznLj9kpk1o88BF3PapFC?=
 =?us-ascii?Q?TiFXAxiCNSzdHWAJwH8raVkZb4hw5FZKNK5eVhIcfzJkm+GnOSH6ORcyUq1k?=
 =?us-ascii?Q?YPFRe0lPhZoEird58T/N2N1pyl5oL6p4BodcALmyKsiW/amV8lERtTO/tdvO?=
 =?us-ascii?Q?f4H9LUO4FPAUowBZgDIceeWO+Ay0uAQTWyhZz3j7bftDkAOrvDK/szkDiFe6?=
 =?us-ascii?Q?FHi6EvBeoIvm3vvpaxaHInbTdvnq0Vc4Ke7gbVe79O+jiaDreRGjRlyU6T53?=
 =?us-ascii?Q?RW8x+6WRicVj6/Z6FaB/X5/48iDfIqwWFPgfh44+Bqb69h0JUF/tKfvUlaul?=
 =?us-ascii?Q?kPgNEe7JB1WdE0XvMLqV6eB1+a9+SVS+T29rERl+xpKvkbmVXTeWjsy5JwYh?=
 =?us-ascii?Q?0I0Yb//3dEkRpyuRr5FJoUcCeFqbcDLS1QzxOLs5z4vx3PaSMERmEi5acPj4?=
 =?us-ascii?Q?Or1KHWNFX1wrZoLHECOpwKjg8JPXJBR/sPeQFGuoBqoGcE9qlWkkRxLG3Xcn?=
 =?us-ascii?Q?swy+X25UF6LKgEZ/isQBjTkyVm57RDP2UdQNGr+NIW3xOEots3asquG/UWZf?=
 =?us-ascii?Q?umW5ZTC4oCmS26fbl2E5CK9/aqye+KhqTgiaI56Zz9CuvEYcK+5FAET4/ZSU?=
 =?us-ascii?Q?8e0HYLzizicjdAIYpgwATAWyFg2SKfWRgiBOqgwpP06tMJppFIJXeezva+qK?=
 =?us-ascii?Q?lYvlMAeNEBztKpOes83c93GEeU8y227qoLrmpVCY0a9lbfwXCwWaYiDkiCAL?=
 =?us-ascii?Q?Hyoj9tVaiAnNOBuaFQuLfxCb4sWDSTQngwzN/Z/2oT62uZjVlGBMZDlwV61r?=
 =?us-ascii?Q?73we4yzk13bVy089bjleDWywrHB0sCraOBQQ/15gsgVOpysCcHW97WxYbYEh?=
 =?us-ascii?Q?/r8yZWZcyN7ox1nDsUFgCZ751o5EUuqe6B4xw19NjxMou7UnL3gzwpaN1s8f?=
 =?us-ascii?Q?tA6rRcIr60iUFv8Ozp3Pk0yzS5f8BJXg3nnVazmp6auGJyBlaZXUgtfu5ZA9?=
 =?us-ascii?Q?Nk8v8AJzPH3GZGRQNAzA9w04Rvs40Y/VWtP+HATupQ9OYA3K/D0VCtTzEvHy?=
 =?us-ascii?Q?toQClOvZjvSe7w4HrN/3R8rihYKAxg4N5h8RLSPFgesPg41fmwqfStCNwTpI?=
 =?us-ascii?Q?n8C+YtEs2j+8Pz+kJQ/0m6aTyYPhlLxln8MPlM1K771e+0IfJclZO6Ar3FQt?=
 =?us-ascii?Q?oon2JnVcqjivAQ/OhEVrEJmJv15kh2/20jMy7jENbm9mag0CqNL6CYH4z27R?=
 =?us-ascii?Q?lTgeTMYMAvC3oaMXRzeCeYA1OJyzgYFsgmYpCT4pUmAFhMome50fuCdET/n9?=
 =?us-ascii?Q?52xeh1Oyl+079CV1i+34Fms+eH7rO0XA13yf+RI2D5hhVW8h9tMZITEKiY40?=
 =?us-ascii?Q?T9rDd7tupTvIOWWyp+wZqSe759vshamqtkc1htCtXzqSyE0EHOZT49MTqL6t?=
 =?us-ascii?Q?5QiU+EtFyoXYK+ZGbrJTr/J6TgoSXi0Hvnn0W2th1/AoG1D0sgxiHQqdhiWI?=
 =?us-ascii?Q?fY3bM3XDtPJAIx6ZLzkWhAHIN55edBCCJEe0eMCYhoKoGZY5emex6/huWzng?=
 =?us-ascii?Q?rZe668I0IKDWx6sVqnw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 11:51:51.5759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e88291d-2e36-4a5d-f26a-08ddfe8569d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_045159_284057_54EF2132 
X-CRM114-Status: GOOD (  11.32  )
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

Introduce support for the --qid-max argument to both
_create_nvmet_subsystem and _nvmet_target_setup functions, allowing
configuration of the maximum queue ID through the "attr_qid_max" sysfs
attribute when available. This enables more flexible queue management
for NVMe subsystems.

Additionally, update test 048 to set qid_max via the new --qid-max
workflow. This will follow the new logic added to the NVMe target
driver, which forbid changing the attr_qid_max for a discovered
subsystem.

Also increase the sleep durations to adjust real RDMA HW devices.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 common/nvme    | 18 ++++++++++++++++++
 tests/nvme/048 |  7 ++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/common/nvme b/common/nvme
index 01d054d..3a883ff 100644
--- a/common/nvme
+++ b/common/nvme
@@ -752,6 +752,7 @@ _create_nvmet_subsystem() {
 	local blkdev
 	local uuid="${def_subsys_uuid}"
 	local resv_enable
+	local qid_max
 	local cfs_path
 	local -a ARGS
 
@@ -773,6 +774,10 @@ _create_nvmet_subsystem() {
 				resv_enable="--resv_enable";
 				shift 1
 				;;
+			--qid-max)
+				qid_max="$2"
+				shift 2
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -794,6 +799,11 @@ _create_nvmet_subsystem() {
 	if [[ -n "$resv_enable" ]]; then
 		ARGS+=("${resv_enable}")
 	fi
+	if [[ -f "${cfs_path}/attr_qid_max" ]]; then
+		if [[ -n "$qid_max" ]]; then
+			echo "${qid_max}" > "${cfs_path}/attr_qid_max"
+		fi
+	fi
 	_create_nvmet_ns "${ARGS[@]}" > /dev/null
 }
 
@@ -971,6 +981,7 @@ _nvmet_target_setup() {
 	local port p
 	local resv_enable=""
 	local num_ports=1
+	local qid_max
 	local tls="none"
 	local -a ARGS
 
@@ -1012,6 +1023,10 @@ _nvmet_target_setup() {
 				tls="required"
 				shift 1
 				;;
+			--qid-max)
+				qid_max="$2"
+				shift 2
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -1054,6 +1069,9 @@ _nvmet_target_setup() {
 	if [[ -n "${resv_enable}" ]]; then
 		ARGS+=("${resv_enable}")
 	fi
+	if [[ -n "${qid_max}" ]]; then
+		ARGS+=(--qid-max "${qid_max}")
+	fi
 	_create_nvmet_subsystem "${ARGS[@]}"
 
 	p=0
diff --git a/tests/nvme/048 b/tests/nvme/048
index afd9272..c6f4d9f 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -37,7 +37,7 @@ nvmf_check_queue_count() {
 			return 1
 		fi
 
-		sleep 1
+		sleep 2
 
 		retries=$((retries - 1))
 		queue_count_file=$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_count)
@@ -58,9 +58,10 @@ set_qid_max() {
 	local subsys_name="$1"
 	local qid_max="$2"
 
-	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
+	_nvmet_target_cleanup
+	_nvmet_target_setup --blkdev file --qid-max "${qid_max}"
 	nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
-	_nvmf_wait_for_state "${subsys_name}" "live" || return 1
+	_nvmf_wait_for_state "${subsys_name}" "live" 10 || return 1
 
 	return 0
 }
-- 
2.18.1


