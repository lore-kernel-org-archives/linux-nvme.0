Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BD2C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FETTXwBi1XkfRqi7NafCnZq7GF92a/2kCl63J+TMzXo=; b=Idt9qnVXEMLGn+mlF7gxbLICUZ
	bCLu/IAb/azasyvHpOX45oFbp+8n9Ff3P3I3ZybfX9IC4AsAsL4xIzssDJGflpgbFAW2kd74DLeys
	kuMrOllfFM44wyeRedPRmb3TqXJpzro4EMxB6z8ytzkrN8kT32UJjsB0nLf5xgT7+Ot9D5yWQy0G+
	iNOIj/mW7dSM7iYmP4lso5+oVBeacIsgkLewrV3qIHvjlLOpySPVSKFIBtnEhCqHZMu3xOHxHcQlD
	AA8YOcbdBYom2u0DSKS2YbP4OVEvUifIgBMI5McREv/+IM7aiI9KXl2mT9KLS1bJQo8T6N5GfvUuH
	l8DY9EYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFXDv-000GLS-1t; Thu, 03 Feb 2022 08:12:11 +0000
Received: from mail-co1nam11on2043.outbound.protection.outlook.com
 ([40.107.220.43] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFXDs-000GKh-Ek
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 08:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1iFT3KJQi8DRC65UCG6BkojhlbTirL+5h1oV0zfGPYvMLSa7LvmHEFJRBbdBXHiRjdHHb+OkUGTYcBueWgAQ9PlRbbhaPHGQRJaXzbbZkjUMYwi8MM58QogM/q/e8xmTzlSKHQ2HMfW6k4ubzyEPUs7SRlbvCnIeePun12fmmaA4vEyTAQ76Dn0WzX3OEvFDiJ6Gt/jSf1131nDZvOT1VskZDkHlwGwqJCpmWKrVCJ8PkW/pZg9FHWqe1V+tHZDuHHG4/aDaL+uf6Q8bf7HHlmyJu1lYg6syJizhHW8QhhqbOgpQjbJrII60PIDQJRNKnrKLqx4Zfg5wy7PvmD9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FETTXwBi1XkfRqi7NafCnZq7GF92a/2kCl63J+TMzXo=;
 b=aKw5R7pyRe8raLwnqUdReWAM38GHF67bSwaN56sHtiNWAUg/jgBNtpJoeNKvyiEQLQlbeMzrug63mJ8SENuvdyNsHCEUYb+SJqpnvQ1G73fzEXnlpV1g5ridewQRj9bc+RdrneRHJCUh1BcR2kve0xfN3vOoRRQ2xYQllVT03P3C7VNlwdiuz9ZFqazF7PKkhGokxw59f9jTC3zOS0xKEGvqOf2nVefRLxXhoFnvT9icV5a/KHy6aFrT4XelzNdXXYQT6PKtBT44p8NydoFmXS4W6TdkUMFc0zqg7SFQb84QsMrlfq9LYSCgNF4I4qTb6nnwz6AuL1nd4e7WCVn0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FETTXwBi1XkfRqi7NafCnZq7GF92a/2kCl63J+TMzXo=;
 b=e4qjObskfZAbvWbk75B8QjU9pb9/VfTHHJ9ELGBYimXKGPa6er7ZkOva2h2kmewrUIQt2lwO3VRTxUW3ddek6KV5t2K23mz7iCPorc6V4+ALfIM7sdVz43tl2kXoDBnujT7LXYEsA/QQoXUdTIXy0/hjAFACqPYj6AW4mMjlqnunN+icFmdEeaWi7gRcIT9nvHuf5Ohusc8qpWFXzghwPTUGtFMxWFirSAq1WGmLgnXj/xDrgPMY9qCaHQRG2KnICBz5XFZUlgxodW1YqbvNgGrgjM1arqAvyCw6U/tKmqWk1pzH75agBVe1AZRnlTOX3QZ8glXt15EmC0g1Cf/Jjw==
Received: from BN9PR03CA0300.namprd03.prod.outlook.com (2603:10b6:408:f5::35)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Thu, 3 Feb
 2022 08:12:03 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::2c) by BN9PR03CA0300.outlook.office365.com
 (2603:10b6:408:f5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 08:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 08:12:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 3 Feb 2022 08:12:02 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 00:12:01 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH V7 0/1] nvme: add verbose error logging
Date: Thu, 3 Feb 2022 00:11:52 -0800
Message-ID: <20220203081153.162956-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ff2263d-888b-421a-6c4c-08d9e6ecdc7c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB30735E6BF7C40DA81F45794AA3289@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gyS6TVnITItnzwJwM60BQ1y5zezO2O2oYfwOM2gFVh1sOheAE9Bvg7KoOHEPoMxvo3yqmd2Z44v2pinK+LbvTQ1DVdlrb9HhYGNatT1wjoaAshUnv9Oz57I+RrYteJpHU3VDHmVTadFdl/kUGtNVK1oqatJJ5m61ikeANm6tfPlr34p68+azJtBhQ9XjBmS+XvYpTl+htKy52oMOgVdYqE7zodedjWzvhyCSMO+4PPCEO3qr3X2/fHM3/+plF2XXnUtEKno45l1PAG3I/ANWlNXQg56Rt+ksqTYrfUUgJhnpNsxE2ac6KDRQXcmVVjtcF36F8GP9Ddy1b5ZB7KKCBoiWfFnqi5Gtc1+zY9meQM0phApAGV2gtCF/h2zNmL3JzScS14+xKB7isrLih1I4lI69PGy3vtt49kBDUkCbzYE90zUgBsbq5SvpFCQVrPQl7IOaxdub75JO+7gUeadgUrE5kjqILTrD2p/Kl5UBqfAP66Ck1Dui+ibxpleGdWZN+K7sXclcUaX9vjff4ZvtQr2RYBLbuNTXoaQxW7JdeMWn0FlRCAx80KEhgtY97G9t+Xv598yu9GcZRuw0dlMAZBhPqYzGsCV3Ojx1jbabcX8Dvzt9X+PqgBhDnRwasGj6U8jdcFe+wkGaw2zZNcoc4fbWi4k57tm+fSVu/V/UIFYEgtX1zq89oEvYDjve/7YiqACxLIv+wviXLjkbsWIRg==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(47076005)(40460700003)(82310400004)(83380400001)(107886003)(186003)(81166007)(426003)(2616005)(356005)(16526019)(1076003)(26005)(336012)(36860700001)(5660300002)(6916009)(36756003)(4326008)(86362001)(54906003)(70586007)(70206006)(8936002)(6666004)(316002)(7696005)(8676002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 08:12:03.3728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff2263d-888b-421a-6c4c-08d9e6ecdc7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_001208_615053_2A5A9B41 
X-CRM114-Status: GOOD (  16.14  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Hi,

I spent sometime on reviwing this patch, thought it will be
helpeful if I fix things while reviwing it along with
Christoph's comments.

Follwing is the original cover-letter:-

This patch improves logging for NVMe errors. Currently, we only get
a vague idea as to why commands fail since only the block layer status
is captured on error. This patch allows us to see why a command was
failed by the controller. This is very useful when debugging problems
in the field.

An example of an improved logged error:

[  183.333734] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR

[  227.767945] nvme0: Activate Firmware(0x10), Invalid Field in Command (sct 0x0 / sc 0x2) DNR

-ck

V7:
- Remove local variables from helpers nvme_get_error_status_str()
  nvme_get_opcode_str(), nvme_get_admin_opcode_str().
- Fix commit message of patch and remove the example since 
  cover-letter already has it.
- Un-export helper functions.
- Remove forward declaration of nvme_log_error().
- Move nvme_log_error() before its caller.
- Remove local variables initialization admin_op_str and op_str
  as they are getting overwritten by respective functions in
  nvme_log_error().
- Rename the error.c file to constants.c
- Fix the return type of the stubs
  nvme_get_error_status_str(u16 status),
  nvme_get_opcode_str(u8 opcode), and
  nvme_get_admin_opcode_str(u8 opcode) to const unsigned char *
  to match the what have in the constants.c.
- Add tabs before the comments for pr_err_ratelimited() functions
  arguments so that it will be consistent for nvme and admin commands.

V6:
- Create helpers that are stubbed out if
  CONFIG_NVME_VERBOSE_ERRORS is not set.
- Couple more nits.

V5:
- Change nvme_ops[] and nvme_admin_ops[] to a sparse array where the
  opcode is used as an index into the array.
- Various other nits.

V4:
- Adding logging for admin commands.
- Display NVMe Command Opcode value rather than generic block opcode.
- Various other nits.

V3:
- Don't populate nvme_errors[] array with NULL strings.

V2:
- Change nvme_errors[] to a sparse array where the status is used as
  an index into the array.

- Change pr_err() to pr_err_ratelimited().

- By enabling CONFIG_NVME_VERBOSE_ERRORS, the verbose status error is
  displayed.  If it is not enabled, then a message will still be
  displayed, but without the verbose status.

- Remove call to nvme_error_status() when determining whether to call
  nvme_error_log(). Speeds up the fast path just a bit.

Chaitanya Kulkarni (1):
  nvme-core: Add verbose error logging

 drivers/nvme/host/Kconfig     |   8 ++
 drivers/nvme/host/Makefile    |   2 +-
 drivers/nvme/host/constants.c | 185 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      |  34 +++++++
 drivers/nvme/host/nvme.h      |  19 ++++
 include/linux/nvme.h          |   1 +
 6 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/constants.c

-- 
2.29.0


