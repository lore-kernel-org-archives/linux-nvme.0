Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC4DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 22:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bmdHSDB6hdh8XwN3FVHOiadEXjmAvJEq4VYgPpQaXlA=; b=S+RprqwDIB1AVKckeh6G7fi/k/
	K76+/bwvuwRQaBZe4FfYFRt8IWcoqdBkku0CipEfFzoIfyWf+m8i/VW4BkjkL9ZOExKAjsE1jmjdH
	/+eW8Lg61s6HUNe8l6pX8EEapBoyesYbrTzHdLKtIEu2HMPqwFkr09osy+w1JlOM4iw9qfl4IhXHq
	7XsImfcgDp/sYE3WbRSemKrx1aTZj2IBwjeMH8//85kvRsj3PU2SQCgtLstR1oe00UjOZdCU75+yq
	v6Nru6SxuHVfxtZHOi8hzZVnMMF0p6m6SCRh6+eDxfG92/M73oxGxuv9eJ9+wBwfclaQ5rBDi9pui
	M/zkDleA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRilZ-006Sln-3I; Tue, 08 Mar 2022 22:57:17 +0000
Received: from mail-mw2nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::629]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRilW-006SlB-KS
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 22:57:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dql8FIY0Hv8lSEZJSVC+AyvtAD/2CIcoFvAnTHnbq5/Dj/WoKk1/W8Kf7rwMSGtbX4TaNPip61TdYmBRWs9F/8W54CD9gzB+qh0Qt6Gh3RhFIud+L5DdcEryW8PM001cUwEOKWi+M3h9fUcc7XAooa6JqiAPakGSzD29yJHaGdkB+G4mU8sqrfZw6SMhyA56dgkYVWelzORahqUh4i04/js1yM+xsrWaGUKUC/N0By12pFS4VoSNlmWf/6IsLf6pAQKegXu9lIraGQF5spl2+PhKAQUKNhjBk75TzR4UbDce2Xu0F+q33veNbd4XTAOg8zLDhJAr1S8IXrRsnOIy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmdHSDB6hdh8XwN3FVHOiadEXjmAvJEq4VYgPpQaXlA=;
 b=SjwfHwXsfcevuYvVIWaV7HBGuf02Eh8i8jQ8Aq0F3N/SSl3h75jZioICyGUXtMjStz7Mjgu0Sd6WlgeEVXFkwmnFO3SMvZH+MigOmMW44xaKtYXOnlErofJKf2/6W+joOOl/tIP4IxmjstmR8scWg6uAPcy3KYkozEjL0r59fZVKt7NKgITYtfLNq4K6jdDC1b4+jl0KDEeXQXI6uuGtjW/iJwGQtFysu7kFiK3IgSGFc/wdsXnBmgfPPUBVvcZQpQVIx85j5xOjUg2irwfpqmVTRRRFwwy+NBQ69ZiOpZyhBI5kWmicUeiGC6wzudXB/lhCLSu9JtjanMSXNZfvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmdHSDB6hdh8XwN3FVHOiadEXjmAvJEq4VYgPpQaXlA=;
 b=tfPPuVnrX5TKIOhja7nFJoCT533TlemsAUZIeRTajyGAZqSvmnHMbz/3UFbnkYGBSMLYOAV8WqzNSQgEW2VsgU+y5UI+VFBsc4CjQ/pfiS2/e7xZxpl1ng+TvOyZoJR5fGXNaze6Fzbh+922Kjr6N1Mr6KQfGwcYyKSYuDwHFmebi/SjGb2Nx+PkV7XGECxv2XRnehVCr8D1FqQJCCioBrfm0R9oYuXUs0QRA2vzN4a50BB/VRvazSVcy/XLvToUh0d4VaWweBsP2YyH7PD2IUpsfZGMDkRPBAbFKyOfeRSNOMDJXxG9U1INqgmS4v5E9+qqRPQ4IfNBNi7kD9kcww==
Received: from DM6PR02CA0143.namprd02.prod.outlook.com (2603:10b6:5:332::10)
 by BYAPR12MB2776.namprd12.prod.outlook.com (2603:10b6:a03:67::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 22:57:08 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::65) by DM6PR02CA0143.outlook.office365.com
 (2603:10b6:5:332::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 22:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 22:57:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 8 Mar 2022 22:57:07 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 14:57:06 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/2] nvmet: configfs small cleanup
Date: Tue, 8 Mar 2022 14:56:56 -0800
Message-ID: <20220308225658.8202-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 319a6f8f-6ac5-448d-1383-08da0156f922
X-MS-TrafficTypeDiagnostic: BYAPR12MB2776:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2776EDB33082103704DD5A35A3099@BYAPR12MB2776.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwpKjb2rjri6Q7V7jKqjU88ProUwGxNSLPeo+tV5UjdkS+b9ODwGTRNiVLa+kJWTJUygyOiLtiyogbcE2K7cwq6Y/VxP+J2yernkRg+U+4iNYkYmt0EnxvPI2Y4WL5X2bAI4+ch0bcrDefVGfPvuTB+scDSkJp6XLVnTYFeU9JJ2qqLi3wXCYNI1r9ztL+9zVEYN8kRD3XiY0nN3VT1H0odw3ae8LMPCZjlSg3qE7n+1z5CD1UuJUC+aEM9BmenNa1nVacBUX0UHOxsU/MYaWwZbLOpgY68Cg4U6/fDPws43278XxAkdsBB3vNaDgz6XdiNMmVVHnv9En2F2to6wBSuFViRT0Lucx6flyVA/JOuWeBV8C8EMQQ6hnqtud0R3k4baXv7g7nptDidHLJFpEDPm2rJ04OBDdzwuV2lJlvgwp8Zn7sTCawU6hk0TlVf2X37v019dI7UPsD6SvA+EaIiLVMPBq3Mji0iysg/oyrXmpmblK6+3typMM4f5HBsX+cfgq7M1xL0AnZ9Rlbj7wS2jrJ4oz1n69SVUHHNqe3lqLgNfXmFPUS+y8Ln0cJgNHeXTMGoppx+5jLSXfixfdAcSz7mcoSQ7bjyhVqjj5GkGpva2hcKGubYIqW+AyVnJP0vA2k9NVJ98TXWtnMx+1S/0AQ20ISvB37FUb2yd3qCleDPlNd4s/VKDKCl3k44gcy26sGC6bGY6CanFlBJ2xA==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(6666004)(82310400004)(558084003)(186003)(40460700003)(54906003)(316002)(6916009)(8676002)(4326008)(26005)(81166007)(356005)(70206006)(70586007)(5660300002)(2616005)(8936002)(7696005)(2906002)(1076003)(47076005)(36756003)(36860700001)(83380400001)(107886003)(336012)(426003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 22:57:08.2734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 319a6f8f-6ac5-448d-1383-08da0156f922
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_145714_718713_29B10258 
X-CRM114-Status: UNSURE (   5.50  )
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

Hi,

This has small-cleanup for target configfs.c.

-ck

Chaitanya Kulkarni (2):
  nvmet: don't fold lines
  nvmet: use snprintf() with PAGE_SIZE in configfs

 drivers/nvme/target/configfs.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
2.29.0


