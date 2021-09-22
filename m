Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE394C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 15:50:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33026115A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 15:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B33026115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xwswi7w3GtkmKxvPUGNB10lL1lybCh/0cHqYdG4EuTI=; b=jppJ1M8lNGIxNE/EkgHM9h95SY
	WGO+f0T69fMMsD0DXgYne4PXeLAfNqHkWxIU07JMAC2bI3ruLuA3oRjyjtc1yR1j+bxvV1HQRdCX0
	p06r8KZfqFllJ0buEQMF9C79S9E1QJJAJa5Pn/meb/7zm4bWlmOL/YLFCVBr3icfNnTUv6WCxuJkM
	t+rJJxE/m3AMK+5hvKrs4ovu8EhGnJzfISUPwTVAN8lBZ+gO3LJk2KQ93fYGxUPIgcsBqdzLl8EeY
	Kj+r3Hze5Gv229FEec9p0cU592FsWKKjt2aXAJV7C6lx9JGmpvDwUoVTaVVzX3aPIRbgkbJKYQwCW
	LOXKiHqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT4Vh-0091B2-3R; Wed, 22 Sep 2021 15:50:13 +0000
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com
 ([40.107.244.59] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT4VL-0091A4-TZ
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 15:49:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLL3b2t8yS35HMjbsK+h+k4AbaCpNdmi8vEYA6+HbfMgSTOqpuX20211Y++OWuQGFxTuIHQk5o35rs03U7EVmwLoem9ZD/wfozjRUgkGPXWheuiPKwpH330uXCwZEoHFodCnRSXHCp3kIw93e1NkD/5lfDLsts0nfJeJPSA52tDOlnxKzmpuNcbP3UDiX0UMuEi6NJKNV8Q3A6zckToMqkcQ2mjAxhTIf/ZIfyzyMPdoJuH2x6sQWXXH2fF+NvFjhFAz+k1H0isXJKQZomEq0x16GGuvy/n9tqVrBoNvjGfPyNru6QS/QPWttaQQiF9CrtFvxKmBR2g/rNVpvFM7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=MOkFAwBpFT2aeonHkkjhMzRKedW2KSGaU+4u4xA2GRY=;
 b=G6VpvJf+u1S1vtZaxUQCHasSLY2bkY7WkAy8V8MzRLkE6Yg/yy3jSfOFka8EkJX72yaWNbam3f8RJgpb4hOz0AXMDgAYxENJtlzegEFqsPPi79q+yNfvONKH0Pt77CVid7pB+MaxUN6oWihM59mXO5u2O40WHUWP/y/Mj1OE/1Of3y7e/mhhDKMuIypkzba18zDuVoweu6wrbl8tUdFMaEi/3oCnB3O6kS4y3FU7yljIpwYwiCX/ASjkyOymlB1B6MVcQMDV+UfjS/nTjB3fR2WHC7mFGED+Saougqfo+43Vnuv69lo+rx0J41dKPHSmEEitFGVSMoJvuPhwkkV12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOkFAwBpFT2aeonHkkjhMzRKedW2KSGaU+4u4xA2GRY=;
 b=hTqu+JTmzoAxp7lwIiHx7lq5Jf386+cXvyl7Kqu/2bwdnbNCKj6+FyYsoCSI5rfRMTHh03JO+k1ZZ99Nj2E7FAOrsYBDjse3SW/nwJzYh9ITs7A8JcjEt4ZUtgpCGZWjLz3uqQ/vPEkLn8tp3FxWRnR4pOYH4oIK41RcAgoIiM8MydKH2x4oNfcZXpdBAfWOgUzuI80JE80u0GVGqogoqtXCELwpNWYigFySVUxWroCffJDHN/W7l+53nay59UkHXDOa5bAbnSUeZsEkghArSmvYX7CanfHbF0GMf5oPptFxz+gwTxl/n03kU0uYz9QRArqigYIj0h+Gk44fR8Xybg==
Received: from DM5PR20CA0006.namprd20.prod.outlook.com (2603:10b6:3:93::16) by
 PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Wed, 22 Sep 2021 15:49:50 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::c9) by DM5PR20CA0006.outlook.office365.com
 (2603:10b6:3:93::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 15:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 15:49:49 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 15:49:49 +0000
Received: from [172.27.14.84] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 15:49:47 +0000
Subject: Re: [PATCH v2] nvme: keep ctrl->namespaces ordered
To: Christoph Hellwig <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>
CC: <anton.eidelman@gmail.com>, <linux-nvme@lists.infradead.org>
References: <20210915082449.1058141-1-hch@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <f7f571df-9685-2803-50c5-f222bc1826ac@nvidia.com>
Date: Wed, 22 Sep 2021 18:49:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210915082449.1058141-1-hch@lst.de>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0d7d73b-8a41-4db7-9f8a-08d97de09c6d
X-MS-TrafficTypeDiagnostic: PH0PR12MB5401:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5401607CC0C2DA7112D3320ADEA29@PH0PR12MB5401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQbEUlVpG5DoJhFz9zEp1lxsL6931AUJkT4c3lYsElosDcVwcm3NTARQ1UDIcM6ruty4H6638lAwOdEK8tW3NdVeNRLHXPuFVIA1qkXF184zYCNKF/5aqDTgCG49dTp+0vQVY6A1AWIRFQVchqYh1+lqd1zLq6vT0rwDYKwAsD30p+1j5PX1/WL6sUw8Mk3N9l1SN7xOFPeThQEODi5XhPhJ65PQJ9uhNWyf19iyIBcirmi2ltz9LORP+XQhC2ij2NtMw0Y0zUKG5xQnWT5izv/8GTdhw8Et9xpZgF+0iOpzHgl6wr0Fw7b6HWQyfZ5Peyyg/prjZEFnn6PkhOvkUvEYyGlSt+dpt/kxLiSCVSX2s48N3JgQeOWDpHvUw7QZHnZUJXDC2GiY1lsRh+nbjxXzLlgH6GxLrsHJfd6brFKMl2RqWafYDdtosqG2UKogvimvQbFbjNf/0UpWzHUgpfaoipyQ0UL35ERycmO8PHDbKCBOkli9rT23K1jBzx9RrtlH644ED2YaJ5eVLseeeEZqjg9Yb20j+9BFqLcQVnIiWxyTXN5TdJY8G4YlHhcSGhZKXX1vlfI0gd3pWRQ71/YN0gcGEMRecqLznmmTm0N4/0DprbJhimvDmBOaLD9jgcpg1OCsv08jB3b+P3r7zrsTFY1HWGmUjivcokHB7c1taei/YM31ZeJouhFtK33hrt9QGfzwy0Hh9AzqG+I1SnqRroQ+hCwFhoBG8nKIOaI=
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7636003)(356005)(54906003)(36906005)(110136005)(316002)(16576012)(8676002)(5660300002)(53546011)(70206006)(426003)(4326008)(186003)(26005)(508600001)(31686004)(16526019)(336012)(558084003)(47076005)(2616005)(70586007)(36756003)(82310400003)(2906002)(6666004)(8936002)(36860700001)(86362001)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 15:49:49.9152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d7d73b-8a41-4db7-9f8a-08d97de09c6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_084952_074854_54CB1086 
X-CRM114-Status: UNSURE (   6.66  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 9/15/2021 11:24 AM, Christoph Hellwig wrote:
> static bool nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)

Maybe consider returning int here instead of a bool.

Otherwise,

looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
