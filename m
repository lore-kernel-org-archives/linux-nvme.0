Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E09C76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 05:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yil6z0qK/a7f65kBvgPUhzqyqmqxJMji2XZE/DBXtGU=; b=rXeTGEBmFGpN2d0bELMlyQCSrw
	4Ek5NZMnPVaoWop4THrAJFxuHZNcJ0BPEH048D1W3UXfbj80yU7mKhkgRn3uOMoP6cGJaEqo1HoTb
	KHdz/G2IiEMRINc07q7UmDjpoydU0N8kTmq15YznSNghjD+fjCoXtV7/laXwmTANoiQ4RydcPozsD
	hfJ3Q9cotvUBQkXOZSuj6f1Gwf8DzwBYL2pafWzdhrQuy7dCJ1XQ3e/PgDcmfQea3P4Qhuw9ANw87
	oxZQUD2ikG8ORO8ogvDIPIY0PW+TirrlEN8Zm3IeJXyAC3onFYVuke/LgT3F1j2ermVoXBuydlEb8
	xl+/kbyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfYf-009pjC-1A;
	Mon, 27 Mar 2023 05:38:17 +0000
Received: from mail-dm6nam11on20622.outbound.protection.outlook.com ([2a01:111:f400:7eaa::622] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfYc-009pia-2c
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 05:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8T326tuAZr8Lgmci4cUOc4DBn7xlH6O/kjn3NCV4Sc7q8Xpnl6ahch83kFbTj2g0VD1+k7LdVxW5hrW2qXJEOVEFBkUxfsYCJZCBGrA5kjnT3ti2Re1V+L2agqOnEc5RVRrY4gtl+mvd9SW1zRGCJDBbRPjrapgumSwrghBhhkshIKAYITO73nMMNAtuwt2CvMwIjbNgIQZedZuCvcinqPKltw/WNuTbgATwW+j1pgjFSA5i/xVFljR+pPqV6UUvelTrgRfjr9DEOlrJtzTa5P4DIaPoF6W/XtTKj52PyoTrqkOKnc63EelySjxLs2CNvxHcDnicD3mXAdYeQZ/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yil6z0qK/a7f65kBvgPUhzqyqmqxJMji2XZE/DBXtGU=;
 b=frqHafv8NcCJHkyHruPiv2/7EA/Qhz2vVRyqH0sju+KC4v7yjhTPiB8M+kxLhkHCPKv9fOsE0OjqGN9c3A5hEueBl3efuXWEAbi0XVm63pAMIwYOmW6ZXSf3ZU85wg2c55eQRKf2ikrh+/VuKuHhYywCt8+R/+BHGc7/OocC/D51iNB51oXJV6iQkaJJTvSCNbVLFfIQw2bngkV+OepkYBNCm7rCmkUfnSsrHNWDmisikxIMxnjDRT4ojgeGpxLzSVDigu1RcOoyKMVSbFaqLn2/qKC4gHStMCAcZ+/ZBjXgSg/eU3oLg/1HP3KbmESZP+yrYNXaRnEI1QjT/djQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yil6z0qK/a7f65kBvgPUhzqyqmqxJMji2XZE/DBXtGU=;
 b=CLiTF8UyANtQ5gGdB7RbZ8/E/Rd9n9EWNJh85l/lf7DKlZJiQ0RfjVQJ/SJ47TLfE+lehWWHVc2sezuM5walxa/Rgt8dOjsHtLCIMnE4tRRjWTm4eRv0SvKcsp0JOnbfEOjRUl86uWWmRYoMUVBgO4NXncCvmhrQQC3WjOUXHxYUTPILD6yxCjTFWSjih/5EWyY5fiOCSF9ATRhd/qFj1PVR0Pi52vM0cOOx8dWHl/FJ2Ks9YN5V7GRO4ot5T/PrG0dsCXwfuzbResaQKyCRE/dTwpoBlQSkAtUsMCdmr4Mq+Y44qjUq05VjupWgEt1cnDJWZaqkZjbvNreJqpNEog==
Received: from CY5P221CA0069.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::32) by
 MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 05:38:12 +0000
Received: from CY4PEPF0000C973.namprd02.prod.outlook.com
 (2603:10b6:930:4:cafe::1b) by CY5P221CA0069.outlook.office365.com
 (2603:10b6:930:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 05:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C973.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 05:38:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 22:38:01 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 22:38:00 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 1/2] nvmet-tcp: validate so_priority modparam value
Date: Sun, 26 Mar 2023 22:37:23 -0700
Message-ID: <20230327053724.62363-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327053724.62363-1-kch@nvidia.com>
References: <20230327053724.62363-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C973:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: c2099d1e-9512-4a21-41ae-08db2e85743d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	f5LudzYkjGQlO9DPFjPXRar1yyPYywYNSJ581ucJpiHIQk3nFHGMF7zR8iznX8uwwNZ0kZ3Y0sPhMXytjQhXTNc/wm6gbgakC61g0eboa24KhFBkUSUWKVS6z+Dy7XqzGB0vsjnvh5aW4qy/UB97IDZq8CJEox3QFzkzetQxj9nqHAHTNamRT5hzlDsPpAo6e2UCXrJ8+1WZURvz9cvlKsZsCy4gH5ziyqhxrfNW9CFHUUdbg/4k6hP2jQb8/TIkNiW7PJGsFoPHU/o3NysJFd6NGxI25NQWTW5tAfoUFO2V3oGmWdP8SCfZLO4PZITv3R5kOa0uvXmwy1BQytBABq8aEqavTj3aM1WuvH+K5BN3TU62T8JwkIzlKsysTUcXukkKE3yJUsORbH3K5YYuPVZZbZmzyk+J745p1F609NTHJvxtvmabETPlCCqO1xKkk+baAVdB3jLwk1BAiGQStQiCMwNGWQygATe1d9e5GVY1ur79ogzfsX/4TrXUkEHYv034t2iIEJeFUM9nYe6FNCE+8Ofbse1XtdV8tOuOVaP3vmL5j6E5BUY5n1bXgubC7XQa5fMOWAWpynhUCfANQZDjjDxK8e5kudYoNLvp7eQ1DU6vC1Q8x10tl4iQuTKoYSwhnsgKRrv9kUn6xR4Yg4zaHGKtYbRz3zP/KTW3+oc139DzirLjd8oIunzdO+2WA1DNkmktL7CIUmHQkd3j638XJ0gp+b9zUR72TdAf7YHjBq4uAK78QI8otagPAIRL
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(336012)(83380400001)(426003)(2616005)(36860700001)(41300700001)(36756003)(40460700003)(5660300002)(7636003)(356005)(8936002)(82740400003)(54906003)(478600001)(7696005)(70206006)(70586007)(6916009)(8676002)(4326008)(2906002)(15650500001)(82310400005)(107886003)(6666004)(40480700001)(16526019)(186003)(1076003)(26005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 05:38:11.7350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2099d1e-9512-4a21-41ae-08db2e85743d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000C973.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_223814_854977_77D22FFC 
X-CRM114-Status: GOOD (  15.35  )
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

The module parameter so_priority is passed to the function
sock_set_priority() which has following prototype and expect
priotity arg type to be u32:-

void sock_set_priority(struct sock *sk, u32 priority);

Add a module parameter validation callback to reject any negative
values for the so_priority as it is defigned as int. Use this
oppurtunity to update the module parameter description and print the
default value.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

Sagi, perhaps you can suggest right upper bound for so_priority?
as I'm not sure if we TC_PRIO_MAX is a right value ?

 drivers/nvme/target/tcp.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 66e8f9fd0ca7..85ffcc8d0f99 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -20,6 +20,31 @@
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
 
+static int param_store_val(const char *str, int *val, int min, int max)
+{
+	int ret, new_val;
+
+	ret = kstrtoint(str, 10, &new_val);
+	if (ret)
+		return -EINVAL;
+
+	if (new_val < min || new_val > max)
+		return -EINVAL;
+
+	*val = new_val;
+	return 0;
+}
+
+static int set_params(const char *str, const struct kernel_param *kp)
+{
+	return param_store_val(str, kp->arg, 0, INT_MAX);
+}
+
+static const struct kernel_param_ops set_param_ops = {
+	.set	= set_params,
+	.get	= param_get_int,
+};
+
 /* Define the socket priority to use for connections were it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
  * A non-zero value being sufficient to indicate general consideration of any
@@ -27,8 +52,8 @@
  * values that may be unique for some NIC implementations.
  */
 static int so_priority;
-module_param(so_priority, int, 0644);
-MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
+device_param_cb(so_priority, &set_param_ops, &so_priority, 0644);
+MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority: Default 0");
 
 /* Define a time period (in usecs) that io_work() shall sample an activated
  * queue before determining it to be idle.  This optional module behavior
-- 
2.29.0


