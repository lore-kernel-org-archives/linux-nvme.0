Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A558C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 02:26:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B202E60698
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 02:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B202E60698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IVkEO6gIsogxHdwsIlZojlUA1ZrFffDjhZ1WTc/aMzs=; b=ShfsfvD4K9eYzS
	mf/KzPEiICHB6QxKX8Q6C/uoYZcfGCldvlUFC5Xj6aNzc+1OqUt9ywQgAwDOzsZk8pd9EcCYCWHbm
	YOZ7N4FtrfT72en102EV5qiCVoBgqpXJ4OzShsoynRWdqTDa3xGWCYmEngdLLvP7Yt3f/6zd73Eew
	ScJhMEE30PI+EoTxnHNQWKdg1H3H/vN1xn/OVxmGlWT//P6sk63lsiWZaVLW7hTFvrFo2M6RsTrnD
	TCMAi9l+goyv92K2KhcvAv/yiP27pC9WRj1yu/xu3PowJGo2gGZTshOINAKGLa53lOBxlw5whiZzC
	juhKsEJX56wehAnUZ62Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN4L0-00H64f-Bj; Mon, 06 Sep 2021 02:26:22 +0000
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com
 ([40.107.243.62] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN4Kw-00H64K-HT
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 02:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaG1QX7CN1xOPgZAxG7OQZPppOdrdAfJnN0bNCIUcyzVz1lxcoWfP+MyEmSTYXh3qTMuablFk4h3pEcqq7sIhRc93i2gULyKUpiSDD893nblvWEr8len1hpRUC4pH+HsfsMIao/Q7QtDXyMHivRZm5jeTnQzjf9vRPQ959VYJQys1TM72AMvQO3DS+NkKGXprVrL7q3G+PgK+j/TLa5Wxb21xxkTYy+J1OLWhY29o6XpnOGGa2hNCNE1BkUNpaVqk7f+soAA7frcItaIiYUjEhYVCtuUcXadIpTpWmRBmcs491ZwH2CBelNhKkPL+0+0PmtKUL8f8IeDiSWht6TGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=q9in1qRAXDDokHhEqi0I9gK4kIF43SeOUGoNj5K41v4=;
 b=H681IF4/HbUiB42pDVHy/PSy2GP9SMBBu+LErvRrmJi7B16D2jsdfnd0Y9IVl0Ui7bfseO+p3OMipEtFjIzGyN1OaU+uhS2uMFB8QTsEhRKqDP9Q4CLtxzZeClU99X5CjMyt6X+8bQmzADBRXgJlLdxlXiG9VD83w0v9cdKyVICNbCnRD1fnQhjBQMepkSr9GBS+LCjIWv5ghBlnvcw+PfOAHTgRGfMNb5C0T7Xr3aM/3bNW+6ycVgdKUudRPvt00/Og93zLKKL2DJpnW9jiQ1uQ9Oj6qd5yB12Q1R5H41d3Z9Hy+eq0CT8uz5tXfh7d1xXs5bmZlN8OSVX7eW/Y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9in1qRAXDDokHhEqi0I9gK4kIF43SeOUGoNj5K41v4=;
 b=sQFlTkaPqlkIVL5Qg1DxgHb9DRWNN3bTLvB+xMOEGPQKLe3377lEGu/IrnqFQMHqV3TknEcCyfcvBTXpl9M7hJKHKNt2kOrEFgbLHjPjzGG9sOHjvIehf3NGOaJYyU6zTKBUnx3YsljY0TvfqW0nRGRZKTqce4F3gbKY5GWxgPmecdWQnP+5e9fQUjUVX23blS+HnPTOdgIbSjLqqfGRrD/y+n3U39k8ic49nmgmqeaJyT8DC8dV5/M9QMKwDAWNYApo+MxuSXx882Gz1uFOc1LBY0034EqqUFVBsXuC9Q+qVE5vNCQx06GS96ZNFD8Ge828cOxOymH44jSeWcAREw==
Received: from MWHPR10CA0064.namprd10.prod.outlook.com (2603:10b6:300:2c::26)
 by BN6PR1201MB0258.namprd12.prod.outlook.com (2603:10b6:405:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Mon, 6 Sep
 2021 02:26:14 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::c1) by MWHPR10CA0064.outlook.office365.com
 (2603:10b6:300:2c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Mon, 6 Sep 2021 02:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 02:26:14 +0000
Received: from dev.nvidia.com (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 6 Sep
 2021 02:26:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.com>, <sagi@grimberg.me>, <hch@lst.de>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH] nvme: update MAINTAINERS email address
Date: Sun, 5 Sep 2021 19:26:01 -0700
Message-ID: <20210906022601.297304-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9d1db37-8fc7-470c-6154-08d970ddb336
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0258:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB025881C9ACED8765704F46CCA3D29@BN6PR1201MB0258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+h51pwm55WTX7z14NWr9RuMIJI5y4fAcT0iATwBqPolFRlXXzajqnbWxc8gWUZUfYO7TAwQ846GlwEQEL3TneODkY6d4uq8ouY8i1SUmMmCZ4dE05XxwUsGmfUT1x9EaB4H62+CkL6i7PPILBIf2NK+MX0UQcE+cEB76F+mBHiLjcNdnF8wbza4oyOkc9o+mdCAuQWsim/B9Kmvc96Nwdm27/JgQo6J1hRLeJjI5gItxvMLH+yf7SJ2O5jf82kvYwTSng2U2qhYAKuEijMXnytMjdQ3kB25/dG0IaV0Nvyj6sw2NBwyRvidt9yEtFrlW3/kext05wtz27VLjPzba1j7nGGrJjev6GRaApwn5KjhrHaBLzFvMoG1j6AJohZENbc6q+GMzNGWEb5SiqcF1W4CYBA3AcaOYoLSkQ6XGl+gjYxCzW+Teu1X830bq7OPqkF3A/pkzR+MX2h05FqCulaCk+vqxBkFBQX8k+PKch07nSsx8l0/M/Maze6wAUBExjrOVqg35f50ELF2570KqjlvUmhcK/fGwfZfKu7PHYIqMHFzLdntiNbjFzeFU85B/EPaPFJN6zaRk0WPOOGtAMSjUEEIrnkpDTV4rFsgZp1LvyktEJrZ/3QO6tHfpfQNrVHqutxkxixa+WP6m37x42g3IgMkRZRYSizmTf+yg3C5QHUqzHnK1e4eyYd3vx12iPuEn5c9vKfoufPseLlS4HsVni8UTC08gfD7HA+U9g2ENdtPPHc44+09g7nk+TWqHBOU9r43OpNyLVo2ykTEZvYoT6CxeVZTxT2KQ7by+uk=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(36860700001)(4744005)(6916009)(186003)(4326008)(2616005)(1076003)(36756003)(83380400001)(107886003)(478600001)(966005)(26005)(70206006)(47076005)(6666004)(70586007)(86362001)(82310400003)(336012)(8676002)(426003)(5660300002)(15650500001)(316002)(82740400003)(2906002)(356005)(7696005)(36906005)(7636003)(8936002)(54906003)(16526019);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 02:26:14.5305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d1db37-8fc7-470c-6154-08d970ddb336
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0258
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210905_192618_779480_AE3BAA06 
X-CRM114-Status: UNSURE (   9.29  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Update the MAINTAINERS file email address.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f298429a5e9..64bf202c8c62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13367,7 +13367,7 @@ F:	include/linux/nvme-fc.h
 NVM EXPRESS TARGET DRIVER
 M:	Christoph Hellwig <hch@lst.de>
 M:	Sagi Grimberg <sagi@grimberg.me>
-M:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
+M:	Chaitanya Kulkarni <kch@nvidia.com>
 L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
-- 
2.29.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
