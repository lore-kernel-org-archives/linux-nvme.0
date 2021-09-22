Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8636BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 21:56:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF7D60F24
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 21:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FF7D60F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rjuHeeT2nTa1qTRviAR+cAEklkr+vzSzCjtDshrzg1k=; b=OsFJD+aN1N5TJd
	y8qgohhtG6LqR7jh5qHPVMj+azOUbfC9Uzp0VzUquSHfiik2xFfjX/t4480S+dXWu0qF28TUkCz6J
	Dn6FVume6g+ew18rqQoA+HoNdqTCcz1EsYJC80M3I+v7x15CFBLbTafOoexj6IzA6Ye/wLj7mmiQs
	+jFj5wSM0iGXEZRDLOjZ0joDiIKdGERqkrNorgRdz39NvArXRsl9hBthKfJZ5KgzW84I6T0Ek9+Fd
	LIvfP6De+JWzmbpieSsh3sD+ZIjyFUPpduykMj6fZ1EER/Wj4oJeV410yGSmGTTON7cS7vhFDtcXv
	DEwUKWONimGUohfsl4Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTAE5-009mkH-7P; Wed, 22 Sep 2021 21:56:25 +0000
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTADa-009mhN-90
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 21:55:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ+3KKZ5xtUyMc/S0C8JTrUAPZ4yi/jeGRJ/11LgQtncrAAkzhWWqDy05G4vSQ4+8xR8KDqai2uC0ZJILCGgbGImHaYXprzhDoFQowS0xxJ9TZJVqOPaMTGn4pUmwwD1H1/Sb04P/Z1yCO1GWbLjnZPLs6z0PtRcMKaSgez1goWZMZvBR25uJcU5kZcDdeTj/qMOhMhKT6KxAxe7iFROuS8EcGMFVcr0fYqDEY3pUbgMFZgs3+lF5YW3wqu5m9mcIun7n2AJ1KeasycNfXr6wGjmY11tB2bYETT2iGTHGi7T5E1lHgrax7A3iScTpwRCec6W1ryuJhvgvICDQsjh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=mDrA60JfSGxjmCsXC/EjZAES890PWBHFLUKuTKZrw7Q=;
 b=jkDhP5POEjhj1Lb5hHzZrJRIeWKTdvL1luEBVazGYzctMws/bYQYJAvpKH31bhTLVCGHhrfH+ykR81mDUKZlCbAAWqLiUMKsZZ5Z2ysdWhlwsObVig3ClqIFt5cE2ZBUmzw/m8PAm3uZ+DxUg+FP/JN0DrDeYsTxsNkeZoM3kHdZQoMMvI3ybSjwvHDvLSKwZIhbQwzPPBOrPkDK+EqoadTxCxDYV9BvacAIynEsomXt0MhQ8qgCzPoXECf7tm1qKsnyJrWHQKkAuvDJsTbiardjn63+RNwUKbFz7FTeJFHV39YY1a9GVoS25xcfVm8OBApAvPGUmdFqE33grA6wjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDrA60JfSGxjmCsXC/EjZAES890PWBHFLUKuTKZrw7Q=;
 b=bHuV3+6WKwR7F2zDYYdyvk4mJRNbIbhEElOcLu7xH0jj1ie4TX5iq3dO1HKz7X7nAgdzcmsSjQaI98ezJsukBhQ0cektsoDfs9UCWvDjajx6GDxuhInhcKlzsTNGRL35uQPGF+fNNCCw1ThjUM4V3LeZI/inn3QHXg3Jap7hgbNtVcYKWrfLJ/5ufMvqHm0lndBjiIN+/bD03pWkC0UbSqcmJFlOljkDv4gZRQFx0CdajizspTVLkbQhf0/0O76wEWGqxPbmXzUhBUuLnJ4uVZr2C7OcBJvM68BOU6DYK1XIiFhtIoADVdf8xviJ8MK3vTbnJq5ZrlfoHWcVnchj0A==
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by MWHPR12MB1327.namprd12.prod.outlook.com (2603:10b6:300:11::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 21:55:51 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::9b) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 22 Sep 2021 21:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 21:55:50 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 21:55:49 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 22 Sep 2021 21:55:46 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>
CC: <israelr@nvidia.com>, <mruijter@primelogic.nl>, <oren@nvidia.com>,
 <nitzanc@nvidia.com>, <jgg@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/3] nvmet-rdma: implement get_max_queue_size controller op
Date: Thu, 23 Sep 2021 00:55:37 +0300
Message-ID: <20210922215537.6499-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210922215537.6499-1-mgurtovoy@nvidia.com>
References: <20210922215537.6499-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eea493d3-3422-4ab0-3b8f-08d97e13bdde
X-MS-TrafficTypeDiagnostic: MWHPR12MB1327:
X-Microsoft-Antispam-PRVS: <MWHPR12MB132738541B8FFCD0194CB63ADEA29@MWHPR12MB1327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Sewa0TSGIHRxfYHeJGSrzQgwehKbKyZ2J4/pgsIv7Gi4uxS0gZfiRdOWAldC22objXIu27mWFrBdbD4kit6sw1gCKEycO01Mt+/W/xXrMf5ZHBqInm83urlcBoLrT03g7Jq01Q+NeyvGwwgNmMjq1R0ywh4RTIDCZ2fJ1ASZm67EPARYB5QKeD14JUqS+98G0/h3WUtDayNNw7iS7k48GdX4yTQJ2OEQvXJuH/gl4w8CGqifHsxmoWx8UfjW1LPj5yfsARaqXlgVyVAGvZR5jyRDzShXIY4ML8hEGyCP4Ms2t87OchqwI6hktjK5fBnV7LP8ph2NyYD/zb+URoJk/SXIcyuxxlgGlwpak+wfpf9H9q5FWWa5dtCP5IScafZ/fBgmBBnSY6nwpKYQG7fD7c4Ki3d6yWrxbUWtjHjVmFtY1bfQf253h32Yzhd6ggg6GiaobymbxWUOSvs7zzB+NulsNo02rLaZec4nMa2DKiDs0GqM3MVCQuxqDeIP6Fd1DasJtd79Dp3vMeie2EVEwY7K3JjdF4/vHctha0SGFAX58ZBVWRPdUt10RpDMi7Ai3iIiJCXa+DLUqU7KkGo0zkaLb8yuScHrQtUsrU8PPYBK7jzN+9VNLo4Jd7k2R7uSU2ME4Mw7qJeLCf/Du5/tV+e9l84bsqUD2Zj1IeziblpiWdblmOoyoneE4ZKH3Xc+Lct5+nr+ZJlNfp1ZC7fsA==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36906005)(316002)(2906002)(4326008)(82310400003)(70586007)(54906003)(110136005)(107886003)(6666004)(83380400001)(356005)(70206006)(7636003)(36756003)(1076003)(26005)(5660300002)(336012)(508600001)(8676002)(6636002)(186003)(47076005)(426003)(36860700001)(8936002)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 21:55:50.2753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea493d3-3422-4ab0-3b8f-08d97e13bdde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1327
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_145554_362008_C505BB29 
X-CRM114-Status: UNSURE (   9.90  )
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

Limit the maximal queue size for RDMA controllers. Today, the target
reports a limit of 1024 and this limit isn't valid for some of the RDMA
based controllers. For now, limit RDMA transport to 128 entries (the
max queue depth configured for Linux NVMe/RDMA host).

Future general solution should use RDMA/core API to calculate this size
according to device capabilities and number of WRs needed per NVMe IO
request.

Reported-by: Mark Ruijter <mruijter@primelogic.nl>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 891174ccd44b..8bf2fad429f9 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1975,6 +1975,11 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 	return NVMET_RDMA_MAX_MDTS;
 }
 
+static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_ctrl *ctrl)
+{
+	return NVME_RDMA_MAX_QUEUE_SIZE;
+}
+
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
@@ -1986,6 +1991,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
 	.get_mdts		= nvmet_rdma_get_mdts,
+	.get_max_queue_size	= nvmet_rdma_get_max_queue_size,
 };
 
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
