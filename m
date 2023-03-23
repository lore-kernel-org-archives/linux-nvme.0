Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C87C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cIGYF/XE/ubYvwo5aink+2axZHBEutwEQoQNVnydNHI=; b=C6V1Beag4qeWP5x0sbHpjZIHlO
	tZVG308qbzDIgd69T59ueKvqS3PgrgOhR2+gkkH9heDaBm/MWftVQt/TirxOSWsNu0jAQloe9rOGy
	aIq3NqAMk0SSdTbfpUZhXqAejlGWI4HpK/BLjABdHTM8WFzSTkixSk/45yiqHfHDESFJoQykECglI
	5sxR3ibv0HVQC9bdDOMvRCT947s2ooGacuT3NSZjF5TB9zdR6e8j0ih2P7UhEs+ZgtKenegbWuhBv
	7C42IxKDLk41pNJlEIoEHZPH9meAAEtw0FjoLMNNJzKtvZZx6jHBO9Tj1HGYpQYpSFDQsa8lIqJaB
	e+Z+9/ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFl2-001ACH-0J;
	Thu, 23 Mar 2023 07:53:12 +0000
Received: from mail-mw2nam10on20621.outbound.protection.outlook.com ([2a01:111:f400:7e89::621] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFkz-001AAH-06
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:53:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVScvRMC4EWNJnmZIb05rbrLRYIbQ4Q7oHYgk0RPu2xYOCJ6ciKJ6GrqWM+nyGkbCBzvCTKjYhzoJV3ava/TOVewTEnwLudkswY6k74bCNb/GqgdNbJsJm5vVkmFJ09rEQwI21ZhPNoZxzvcSWIKLbjfdvY9jzg5toQHZ/3oonZt1FTfJgU5TsXDnPBg+3PoD3pw7MJy9YFtdU77y+KhwktI6XiCwkomDOAaaG0BmsjJq0I6te+gIVQKs3P2wo7UKdO20DYCgudkhiWiRkXE689PZeF9YEg4xVoaJKyQV6pJKJbFP/+pcI6pNWv4VIDpXTUefiSx3k6mEnPHZk5BcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIGYF/XE/ubYvwo5aink+2axZHBEutwEQoQNVnydNHI=;
 b=HAh2QXwDSCUA/mab9nZ0i+KEbv8b29/aszH+i8eRBtJXKUK0fGHy5cyTHrAbx43XfS1hCZRIfZM8EpDJymstkNe4R8i3taHbjXnP2kWma9grq6QeopAuxX63WjGeGDya6CVOdW1EeRZrsWRa5RTbTUcNv3tkJ4HqU2cCBpk/5vthUIwgKHxdwbOfvvA2JTRfDlAXvnAHbB4yL2SsLqrpze3zQV4OE2ZAtpbXiRKnd/9ZpO+zEHtitTMPMJr4mkHK9nshK4NOKx+ceS1aFJuUHeB4oUTCw6ua/YuGLN3XJeIPdh9mxCgIMJOLH6rb75qdKjteVCWNmec7xM4q5z6IJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIGYF/XE/ubYvwo5aink+2axZHBEutwEQoQNVnydNHI=;
 b=gWEuYVP9rIN+Uzaq4DVf8+8grrIKXN87lOlq+L+RTU1RKqb5Hjm52ASDXp9mAx7SXWBzY7eb/apwwH5K+Mlt4jiFijegCkF5SG5Ig0zrwwGVFsMxl0Sc4uvdsaA6RwsrrMQedu3rV1SsatOt4Ie7hdkXD0AVxYgzYFxC/hRF3WHZWa2CCcJncIPkT7eWbiNvnPitbFVgR7hhTWaH7RzI9dw0wOEzwFW1TAhn6zhz83O2776z55a0x3F5C0Kz6NopCm+og4khL6e1+4/hdlQc9A60BaARsNF31baqs+POMJjfzjlkUfyMTe3PIkyHaDG7tQWlfVnXCnVvbvZO53E4hQ==
Received: from CY8PR19CA0006.namprd19.prod.outlook.com (2603:10b6:930:44::27)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:53:04 +0000
Received: from CY4PEPF0000C97A.namprd02.prod.outlook.com
 (2603:10b6:930:44:cafe::9c) by CY8PR19CA0006.outlook.office365.com
 (2603:10b6:930:44::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 07:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C97A.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 07:53:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 00:52:56 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 00:52:56 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 4/7] nvmet: centralize req completion for noop log
Date: Thu, 23 Mar 2023 00:52:00 -0700
Message-ID: <20230323075203.824096-5-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323075203.824096-1-kch@nvidia.com>
References: <20230323075203.824096-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97A:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce0d2dc-9a89-45b7-f521-08db2b73a24f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	si4uiAw+XFcgChdyv6rG4z0aCZMP8zOk7XNVAvipDblogPZ7+j8yuxSx/aZtbWDnfgenYabL17fTdac0FNdNRNwjExZnFMG4JJLGuKE0VyQL07pk4CWHbpSJ0PGl/EIOBKyzHbPvcatxhPMg0oCYUSWDlg/LgSzzveKfJTsJtaF7tcBoBgwUZxnLrk+H5VqC4ghwh+G5zFAj0S9mNPvdKkO5iFD79BUZ73epxXrj5iAqhLC29B3BrAI5dv/7EdtkB+LF03FuWdrvs0TM+36lfZ9Z+qeT5mCM7fxCRv386q4V8ayutILd+Gn/L7fTE5OHtoMCWYrVH9xVtnEVkKpgdRaF+jqJ638AeZsEMXxAY04SvgAx5DGAs6HSvl1kH2BAxEEodMSQ7DdDbNusSmC7EF/lGQ4MiKa2Pa8JwRspJuQgM+i6W+k17b6rP4AHsQUiZub7EPHXSqhdXUeQqMdqZYWq9ftuwUjyfRfSFXL+3zEOFCuhHmkpOdTcgURykczGb8vHWJuBRJVFOWRMSJNj0nELAAwPzAaBmj7IGIZx8tVi9IGFKUc4SAoMusUCeiLL9D6PeG8Ja3JYPd/LnbTM3/v3x94JW9iAyEX3K7NnDgUw4boFr8DT5k3M74i7xMihYQ0bTfInUaCFXHLb22/nPA4Rj+kkHw82iSuCeIwy67FXJLKYygRcpD5yiva3/yG8sDbAos6fuGMTJn/ItwTZNZswYccmT2f9QauJZdUu5qDIm+d9VjlnUQHGGqg36WSg
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(478600001)(83380400001)(2616005)(186003)(16526019)(336012)(356005)(426003)(47076005)(7696005)(107886003)(6666004)(6916009)(4326008)(8676002)(54906003)(316002)(70586007)(26005)(70206006)(1076003)(8936002)(41300700001)(36860700001)(5660300002)(2906002)(7636003)(82740400003)(40460700003)(40480700001)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 07:53:04.6345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce0d2dc-9a89-45b7-f521-08db2b73a24f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000C97A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005309_072686_92D3408D 
X-CRM114-Status: GOOD (  10.82  )
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

Remove nvmet_req_completion() call from
nvmet_execute_get_log_page_noop() and use the one that is in the caller
nvmet_execute_get_log_page().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c2f510c80bbf..84cacc93bf65 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -40,9 +40,9 @@ u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
 	return le64_to_cpu(cmd->get_log_page.lpo);
 }
 
-static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 {
-	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->transfer_len));
+	return nvmet_zero_sgl(req, 0, req->transfer_len);
 }
 
 static u16 nvmet_execute_get_log_page_error(struct nvmet_req *req)
@@ -336,7 +336,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		 * active, so we can zero out the whole firmware slot log and
 		 * still claim to fully implement this mandatory log page.
 		 */
-		return nvmet_execute_get_log_page_noop(req);
+		status = nvmet_execute_get_log_page_noop(req);
+		break;
 	case NVME_LOG_CHANGED_NS:
 		return nvmet_execute_get_log_changed_ns(req);
 	case NVME_LOG_CMD_EFFECTS:
-- 
2.29.0


