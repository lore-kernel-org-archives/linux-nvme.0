Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35F9C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 22:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IBRpUTjrcPjLi12V2/abHhsCuQQrukxPEn0+So5Z6R0=; b=P/h/7hd9K5/SciVhZ9urzhWxrK
	IXq7mfz0DJqcrAWhRPaQOFFUhh7Gdx7W3NOIO1H3QnDw0Sy9p7PWPBJU+tZ+xLlS2OUkykWfMazFe
	FhmyhzFdlunSFg/fQ+o79ZPjG6jpHW7jNY5Dgz+SlQvyXouldHT2KHVZZVNcZHub5brq2KYwXiBxG
	lo/A64zpYCMOFqHQzydxnu5GlY+tidJM7h0bkGffdUdI6oQFV4tgMhxPwoysdVJfTmI5AXPxhAJw5
	mRV0T/xyQtTN8j9R5iefuyMbLnzUsFmM9fQABmZ0UvnRUu4GaqngPSr3zgqBaPpEyvgXtfbgvDz04
	/7QPbjyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSPgx-000lE4-1m;
	Tue, 23 Jan 2024 22:56:27 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSPgt-000lCo-1H
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 22:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwZHocADYrdu5K+HP3h7ZWgu9iV4XlhDAdoOpWVMWRrwuwUFDDtOuYQ5t9TR8BmUcC9mU3c++tHrHVyfkA0yK4EREDr0IUomBJQwhtOopGF/edLmvOnAVOll7NXXtVZvC5KgxaL1R/SbkcdhsEsmRl3N2zW0NRMCgPqAo/cGx6wovAmgNwCfM6OjEOHQn3gg+SDCecmpoJxNO+pGzOOrVv5JqcXms19Cqdz2CyckComA4RLAOdx5P/5qeCH1bvsK182byqw+8wYfjYAN080Xt7cHOV8BtA4o6gmwO3sRzAfeT6WZRwLbyKyEQcTDkfExER9hy9gMhmgSSoZz87BEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBRpUTjrcPjLi12V2/abHhsCuQQrukxPEn0+So5Z6R0=;
 b=lsbHE+dUQRU+XYK0106CZSme1amb6KVkmM3rCEDV5nVH+GFQ/wHP+BmEVpp9Xls1G68gm7xTaOxTlcbybphAz3MfeHYAYbSDGyXpLBk2OrNLdH4pCw8B+j+NoAT8HO6bov0+/ae9L76UyNG0ahKbnRFs/vCP9m1J6q/reu22qZ+uVrG3PxQP+XLJe+1g/Txtruc3HCoFD923ULtGgXEN6qku7H60j2wfaf1Sv7bNKgO4KgdVSByrSjMI8SPstMQ/SCuy+HZDaZ+Wi4It3tD/9RW/leByJ3q4K9PMq4XmsojuMRUSaYYUyR/ZqXJc0/DgUaUsEKY4R1mvpCDCNNZjQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBRpUTjrcPjLi12V2/abHhsCuQQrukxPEn0+So5Z6R0=;
 b=QT7dYXejullbaRwGSqVC85ZMq6PshDs6Ne1g2+cEsBgzkGQzBqIPZGRsHspjUQ5pX3o1CMA+jHjccb0xe5tHQYLK0cSPVoKfxZfOJZIzeR9J3/W3hyAFGN2TjLnJqFMcdzO6SjjwRe09sCIDFRzSLoEKMTH6GTKKLW+6qycmafyRB6hiUseEn3hQkF7iDkqn9aeHD3VepXDU/gcQ9k1jz8jWd6Q+eTKOMZ3o7vbPBmEHRT9X+5Jms4RI+RpX+0K8jO/XL9kMzhrihpce0gLWuoC97HE8J2XQ9FZXXadQ1jZbe5U/KfTzWsHcOp+ZK3ZgsbsbtW3R9K+PQ6GB/APtMA==
Received: from BL1PR13CA0442.namprd13.prod.outlook.com (2603:10b6:208:2c3::27)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 22:56:12 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::e) by BL1PR13CA0442.outlook.office365.com
 (2603:10b6:208:2c3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Tue, 23 Jan 2024 22:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 22:56:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 14:55:54 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 14:55:54 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests V3] nvme: add nvme pci timeout testcase
Date: Tue, 23 Jan 2024 14:55:47 -0800
Message-ID: <20240123225547.10221-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 144f3fa8-155d-4137-eab5-08dc1c667ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IASm98q5dOBhZjJfguYYOyyxZEVaHF/0lYF4svicaOt1lybUTye25YK4QWWe8slCFEIYZENBW0wg7TwKd2taF7qtN/ETpW9+ZqbBwanb37Ms8DisD6dW7GSTe0oG+o8ueTxS3/zzypI8rlVvE+agXYxlFN+UgMGBIfyxNaQZaHuNEEWrKgk7p88hCR2C1L2XFBqh6diBptbCDad0ei251h/XErcLr/7QRqXS0SfwLS54p5SwDNFdXx8JkNjywbW0aLDKKVorICzceEoAc/JSJf6rjHlLswPrqpxkYPsAjM1Tl1vcxDPwV7rVyYYQxzGF4v1p57upHirG27gsYb1ybjX7R1SGN+0cZ0lWThvKNUuL1m7yHn0Q/VOJZ8W/ObjfvEjQiIpUHvL1n6LDZ+8yhyTdVV8yB3TPjSBT8XP1xTigyOtDfgwBdN7J7CXz9mdmOT303GHwU+774l02mCS6fC7zKb0piT82S3qLt87VoCeAE8hnXLJAn0j2iHntfjg1R4woaEntTYh8F9vwagG/FotAw6aQPSyFJVGFQaJ/MQgQQoeuK620QFtbNOiAJeTIyR0Q6i6VNvwHWM8DH+Z73pRrde1osn08p9Fu5ER1kaxi2OjAqmowmEiFefdjKCmjfZxso89Ovov33u/zDOaBslm1rGIQ+0Sd/k25JWws4FpszaFil46tw5zXm2U8uBMqe3Syn7IF1UiduFcU1w7UF4rE1TVo/VLLEOwYH/Fn45F7x2JTPTxSQeq4GRpcW9y0YzFeOTeFj9q5MWERNgryyQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(356005)(336012)(26005)(1076003)(107886003)(7696005)(426003)(6666004)(2616005)(5660300002)(2906002)(83380400001)(47076005)(8936002)(70586007)(70206006)(54906003)(478600001)(4326008)(316002)(110136005)(8676002)(41300700001)(82740400003)(36756003)(7636003)(36860700001)(16526019)(40480700001)(40460700003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 22:56:12.0024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144f3fa8-155d-4137-eab5-08dc1c667ef5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_145623_440713_8FE89E1F 
X-CRM114-Status: GOOD (  12.28  )
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

Trigger and test nvme-pci timeout with concurrent fio jobs.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
V3:-

1. Add CAN_BE_ZONED.
2. Add FAULT_INJECTION_DEBUG_FS check in requires.
3. Remove _require_nvme_trtype pci in requires().
4. Remove device_requires().
5. Store fio output in FULL.
6. Revmoe shellcheck and use grep I/O error value to pass/fail testcase.

---
 tests/nvme/050     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out |  2 ++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100755
index 0000000..cacaba6
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,69 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Chaitanya Kulkarni
+#
+# Test NVMe-PCI timeout with FIO jobs by triggering the nvme_timeout function.
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme-pci timeout with fio jobs"
+CAN_BE_ZONED=1
+
+sysfs_path="/sys/kernel/debug/fail_io_timeout/"
+#restrict test to nvme-pci only
+nvme_trtype=pci
+
+# fault injection config array
+declare -A fi_array
+
+requires() {
+	_have_fio
+	_nvme_requires
+	_have_kernel_option FAIL_IO_TIMEOUT
+	_have_kernel_option FAULT_INJECTION_DEBUG_FS
+}
+
+save_fi_settings() {
+	for fi_attr in probability interval times space verbose
+	do
+		fi_array["${fi_attr}"]=$(cat "${sysfs_path}/${fi_attr}")
+	done
+}
+
+restore_fi_settings() {
+	for fi_attr in probability interval times space verbose
+	do
+		echo "${fi_array["${fi_attr}"]}" > "${sysfs_path}/${fi_attr}"
+	done
+}
+
+test_device() {
+	local nvme_ns
+	local io_fimeout_fail
+
+	echo "Running ${TEST_NAME}"
+
+	nvme_ns="$(basename "${TEST_DEV}")"
+	io_fimeout_fail="$(cat /sys/block/"${nvme_ns}"/io-timeout-fail)"
+	save_fi_settings
+	echo 1 > /sys/block/"${nvme_ns}"/io-timeout-fail
+
+	echo 100 > /sys/kernel/debug/fail_io_timeout/probability
+	echo   1 > /sys/kernel/debug/fail_io_timeout/interval
+	echo  -1 > /sys/kernel/debug/fail_io_timeout/times
+	echo   0 > /sys/kernel/debug/fail_io_timeout/space
+	echo   1 > /sys/kernel/debug/fail_io_timeout/verbose
+
+	fio --bs=4k --rw=randread --norandommap --numjobs="$(nproc)" \
+	    --name=reads --direct=1 --filename="${TEST_DEV}" --group_reporting \
+	    --time_based --runtime=1m >& "$FULL"
+
+	if grep -q "Input/output error" "$FULL"; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+	fi
+	restore_fi_settings
+	echo "${io_fimeout_fail}" > /sys/block/"${nvme_ns}"/io-timeout-fail
+}
diff --git a/tests/nvme/050.out b/tests/nvme/050.out
new file mode 100644
index 0000000..b78b05f
--- /dev/null
+++ b/tests/nvme/050.out
@@ -0,0 +1,2 @@
+Running nvme/050
+Test complete
-- 
2.40.0


