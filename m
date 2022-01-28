Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7411AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vRMxwUQp/2+HwWsvAqS3Zo0r54cFR9KJ9Ksrpu00jqU=; b=GGc3lZH7OyCUwoQR8cuFB/4at6
	b3+pH6tvzI9iI8UyvCmHJqRk+jLRWx6Cn44QtQ9kFtxTSMQTmbKZkNb9TkOM7K7L0uYJAsexrfjlH
	9xnL6Es5u49uts1PHM37D2hhwKbUf3EOkEI7i52eLJD0CDiNZLEtenzGURuCQ7GKjObIvSti94moG
	tr+YE6qEpTm5l6oC1QelksTBf57n63R6UvGSZajoH7Vs6Rwqi9IVQRqsqAkqWvgaM6+MqylbrGlRU
	Gi11dl3+oVyyk2Z5B2iOHxASxvqNK6T6SNxVU3kaM7itYDCmbJqox5lYYQqWhCd18u2y/vmKU+LOh
	+KFJsBgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNRP-001Cwk-Oe; Fri, 28 Jan 2022 09:21:11 +0000
Received: from mail-sn1anam02on2042.outbound.protection.outlook.com
 ([40.107.96.42] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNQk-001ChY-JR
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:20:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIpu4pmuI3/H9salwrgdBe8A6zwJQRUai64q8n3eliodqIzeKCGQ2szas7kodv3ThtXs9bd89xxdJwjhF0v7ZbCAnL6wltjxuT5BI/rk7j9q14DmEDzgQTafgHaFyphLy2v86ZnhFzkDSRD5EBukQ0Bmq+w0y54ZAlPIl7Ape09bmqqiclAWV4hDxOqm0qJMGSz8YN3NzRG9A3JrjgmwkgH3CF9DP+vpdjayMBHibJlZz5D4KUe2abmTNGFagJTsffdt1P8DW6HdRWIfRRx0tsRhFPETqpFEA1pJuHC87kruinfRz39ITFBYj3HU0dLaNILzvYMlovGwnJcW2QYlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRMxwUQp/2+HwWsvAqS3Zo0r54cFR9KJ9Ksrpu00jqU=;
 b=h8B6Q1JjJbqtOW3n4VocFexUd/Be5m441vSSC92jlbXz5BQVqbUN0JkWDN0AS/8eYa45+zWa48+fVKtly5daKrLab9RJX1DMPGSd/ikjU31vh2d1Sn7NYpmbV55xUK0ffYtj7fMgxEH+RjLWeeBbk3etoGfIJWXE8M/ThOnRdMAfIH4Z4zGBsj5QCYfVWAESjlY8kRsaduYpCXwNxbETv6Q4tbBjobugi1p40Z2DjM6qUOh912mHAHsbwncNA4flAvK60bCwGhu/SomFG/AhhaVu0CV1ceOu9khsk41nU1B+neU5v3msyUJN0ptXIbIF9HguCFzMMw09P3YvxJS6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRMxwUQp/2+HwWsvAqS3Zo0r54cFR9KJ9Ksrpu00jqU=;
 b=BTjupr7EUTQjrX1FS3GBbASpfeDkOjY6nPbC/cbRYNHy2gwcqLSLxR/7PuXe99cPolThdn+Vo257FxI6s4iZnMWEUeyo4VKRSJ7VLbegyTFRg2WOAI1t5PfqjlqoN/0EsN/Xz3vNEjlBJwLJu0baIqIG/lmMJmvzkOfd7l2OLgc3pAqHdLDGFCeRsPfcf/E5VBcUEuQbVhnPseRMfOTItQkoW5ledmNYXqNfZ1/LuOVHLvd5QUA9kXN0/HYW4kB9FoShRU+lBWU96DteiWI0NnpN0n4zPcsNHMZ3ExBQAIm902YHtoe/EQSZPc2azvzAP8RY+FezDOoGqsKa/Vx88w==
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by DM6PR12MB2652.namprd12.prod.outlook.com (2603:10b6:5:41::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Fri, 28 Jan
 2022 09:20:28 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::b7) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 09:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:20:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:20:26 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:20:25 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 0/9] nvme: add helpers and remove duplicate code
Date: Fri, 28 Jan 2022 01:20:06 -0800
Message-ID: <20220128092015.19289-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01c33020-d734-44d5-0023-08d9e23f6c46
X-MS-TrafficTypeDiagnostic: DM6PR12MB2652:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2652C2E3F5E8410D90E0664EA3229@DM6PR12MB2652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oUp8vMr1JIFNHskn8aXtTdx1ktsVoA3oL3yn2ywGNeksiVAW+NE1NlzIO69M1qLZ6VyD9LiRVkDAwPaHi76vnbRmclSV3Fhq7ecPH78u8Qb7fOBLZdIc0MPh/Xx5UWDgz3Jlg4fv6P5IPhAUj2a2qSlTKuGvlE/jHdx9FYXMzEuO/e5d2ny3eagqoDmW29Ys1L9J0cAq7v4hR5hNG9Vq0Ezk+dJasPmZynMcUSG/5WCJhLWve2zm3ug6s/tTvBvQIFTA+qhZGa4RvFc1hvBE4KwrNKDnvSlaA2a0BNi1KGF/3TNxn85rUVebgL6mxUPY8SC/YCM/lDS4GTjPM3nTSsMuRDoy7K0nbtSQ+n3ahp2GnLss3yH8t+W9snmGx7UwaorTorUsA62cYw9l5voIg4Bu+Ay6Txq2wL69mpZyyab4uX3R8fNlkB0WdFWSpCeacsCQBoQL9EHcpSerwQZA0lvhhLHNV/Ix1E9Gy6UIngkl3gBK8Il8uZDVzdcWgg374L7BvXXWwiOwbImPnXsd+4Ae9NvBN6fRByiuiEtfwoCbW9x3uUAbjqaGgioM90bTOVQ6UtBamqybMeSRFWloDI/maxFH9y0EeZF6AIqasazqgs9qjP1a3YJ8bV4Loc3AYszwgletp6xo3HgT0qkww5OURH+diCGKdxDT/OEVf5p2qBYdJYnzqnSvZH0wR/k6FdIsWfRv6QRgtJPg54IkO5ZXfVzvc/H+ZKSjcw/uG8KiV7sWyvqku5ilmIWZq3QN2aZSZp4ynR75YwqP4Xooz1qArGP6+PsJAp6uxk26SY=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(82310400004)(5660300002)(47076005)(81166007)(16526019)(356005)(83380400001)(508600001)(316002)(26005)(6666004)(1076003)(4326008)(7696005)(40460700003)(186003)(2616005)(8676002)(8936002)(6916009)(2906002)(70206006)(86362001)(36756003)(70586007)(426003)(54906003)(36860700001)(336012)(107886003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:20:27.5886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c33020-d734-44d5-0023-08d9e23f6c46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2652
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012030_682378_1E048659 
X-CRM114-Status: UNSURE (   6.05  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

HI,

Instead of opencoding connect_q initialization/error handling and the
initialization of the admin tagset, add common helpers to remove the
ducplicate code in different transports.

-ck

Chaitanya Kulkarni (9):
  nvme-fc: add a helper to initialize connect_q
  nvme-rdma: use helper to initialize connect_q
  nvme-tcp: use helper to initialize connect_q
  nvme-loop: use helper to initialize connect_q
  nvme-fc: centralize admin tagset initialization
  nvme-pci: use helper for tagset initialization
  nvme-rdma: use helper for tagset initialization
  nvme-tcp: use helper for tagset initialization
  nvme-loop: use helper for tagset initialization

 drivers/nvme/host/fc.c     | 18 +++++-------------
 drivers/nvme/host/nvme.h   | 25 +++++++++++++++++++++++++
 drivers/nvme/host/pci.c    | 11 +++--------
 drivers/nvme/host/rdma.c   | 19 ++++++-------------
 drivers/nvme/host/tcp.c    | 18 +++++-------------
 drivers/nvme/target/loop.c | 19 ++++++-------------
 6 files changed, 50 insertions(+), 60 deletions(-)

-- 
2.29.0


