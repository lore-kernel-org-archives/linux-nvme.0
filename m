Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D2CC4829E
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jMpmuYoxP64jD0trNBRezvNJRDIMnIgzN11QIK2BqI4=; b=cBfxSQavc5gMr01xgoOsCY8B0M
	xwWDbiCcdLYQEeCdKpbnBF61Pw0z706AoJY077GQFKInaASIL1729QYVUupq2Y0OaYRv/bBthYTuH
	8j/+gFKSNulU24jrH1HueVu7X+VXZru9Q7+RgsulH6B+Me8mfDrFPUrMicCoWa94h8HoXmILWVs0u
	XTiYPpS4ZEQOWmN59630KyjSRYxEMWFn5NmDCiyxa69hTa7nVna3h4xDDDO5gJO8+TxoiDWcABrTI
	0iun0m6ndXK4CRfDQrr4dqhAbfIIA/0d7yrdKeIg230eiBxUX43v0NkYN70iTnpQvlDar9pY1gU1s
	aiw6bPEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY2dc-0000000DZm2-1S61;
	Thu, 08 Feb 2024 11:32:16 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY2dY-0000000DZfy-3kMR
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 11:32:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajx2vj7Otvq+LGWKeTFr/yDoe8ntn+nmFJS43g0rsfn2YgiKW9uPgWQea3lJwwdx9QlY5jvJ2F8rzi+C7T8kKPz+GWPeq+VecKOwSDVoAyODtQITo/xPKA7/Q6YRqHIavzVAuFNIMk2aI12Yuf4I782EXcw9WHGEgZupT32cEGjRDeagHgucGPHm2haVUFEBcGiQmeUFaFqgyHPTbJhw7F4TQ7OOGpamyEjX9G/uXrUd6EupQqadOqb+Jigeil+m7LZ2VEXHIYQVyZyNariBikfASa2EnPthYEHLgAFi9P7Rag4byVHd9QcoNGNhTRIONYrEi5dYNdVmm6nbmxNl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMpmuYoxP64jD0trNBRezvNJRDIMnIgzN11QIK2BqI4=;
 b=C1Wxm8Tg4YWz1zfYfIbhrEbjNfAl4wrg13vetyZ8aUq/NkpBRWWP+Em9QFk3BvRse3jlkllKTcaPlLPpRApIGMRDme4jbW7VUh7KFDlEwyrrq9vm+agIUH6dIz2eqUfipHJV3LGxXpafWIr56buikVi7xQaPfVlpjNgzhTpDqhO8/FEi8mDWLjbr+N8g8Qo7ifUQLX52JyhCCmJiMJYws1GBgpO6+/UMj+jxAbWEtUp8Kmpq26fyFwUnLA7eVB4aXJPbb4RSfjqsjvCfqR+jewWrCXhfsK6x4ISj99x1AOIvkZ99uQ4vB3xGUqxr43F0opX5IrDRc7hGHE/CIHbdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMpmuYoxP64jD0trNBRezvNJRDIMnIgzN11QIK2BqI4=;
 b=QRMgQ2t8EkM1R9dy2aEvozfZKmOtKMTEEsvG6IyII1Hd4O8Bu66s+8yMKGG/7/fctGrFllgKnC6J+5n7/0Ztq/LJXFKXxwVD8/r9tIlt+aF8NrI96pJKnfxy4KOeXCboOvnn0EezdLpvBedikcCTCW9V3kwAlJyz4k/KT+6e1WCUdHWKLyfwkM8rZv2sWNE2Dk9QxPndaVHk1SQENXuz4ECazunUWgk6KjujDcYgmAmg9sIDWZSV/Lkbp8csRUorh7DZqNRKpwdFCzyW+wVhPshUx6HEtGQ1acPxGdt6wDLQPNIQ2wu9fklifro1ofnf5/suK24BYfV16TY16TuWhA==
Received: from BN9PR03CA0509.namprd03.prod.outlook.com (2603:10b6:408:130::34)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 11:31:55 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::72) by BN9PR03CA0509.outlook.office365.com
 (2603:10b6:408:130::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Thu, 8 Feb 2024 11:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 11:31:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 8 Feb 2024
 03:31:38 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 8 Feb
 2024 03:31:37 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvme-fabrics: fix I/O connect error handling
Date: Thu, 8 Feb 2024 03:31:25 -0800
Message-ID: <20240208113125.50498-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 184288dc-6a51-468c-6b5b-08dc28998df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEc+PZDzbWcyQo9oFb1dFwyl/PgHK30aUEjXxfWbgElX9q4PpURVeJQw6mrSL4gBIQ0G8/jHhfD9JnWChmDvKNhxRT+lzreWv9Nn0nZ7UBKD6oZ9qk+Vco8ZgzRRTwaXRc6sekPWgd8bEPeFLK9booFEHSSi0UHqO/+4LE3DHXLiZrmNeSOhAFu9Z02xJ++CTnlXj0guW+voF+mCdwKaXGv/MytFYY+QY0mQeUnHLJ6M+yI30d42thggERWMgRS9RyufuPtKibs12iF975MozVuwWKoFS/Ajmnv24aFFTz/Bj+1EhukF0/iK3l6AxEIBLuWt3AcFbHq2x+u2dXzGzPBATLrdA+Atmrw+dfmvt58/YuegHuFY5RQnFQz8AX4DXWSl4bPWvtspJr/YQbcEvuiI9DhGLv5wNfvoybwsF8vUJbu0AbFWTWKg8z7M6Hi1UTAvgpKuMD1a+O+ku/doO/v4LhboV/A9oCZrW2Sni348PU2YeZWwVXS8HEoFDcrfD5zCs45Tn+ozq1C2fct0aM7IhmOFwNkvysnE1wqnn+uHL/18RORQSrDR8LTqUAzNsQYyZ46+CNUy2tnWokpNMEFo8pczXKr3+sfjL9fx83U=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(2616005)(26005)(16526019)(107886003)(82740400003)(6916009)(41300700001)(5660300002)(316002)(54906003)(356005)(6666004)(7696005)(8936002)(4326008)(426003)(8676002)(70586007)(70206006)(2906002)(336012)(478600001)(36756003)(83380400001)(7636003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 11:31:55.4358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184288dc-6a51-468c-6b5b-08dc28998df5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_033213_019334_EC21A9F5 
X-CRM114-Status: GOOD (  10.62  )
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

In nvmf_connect_io_queue(), if connect I/O command fails, we log the
error and continue for authentication. This overrides error captured
from __nvme_submit_sync_cmd(), causing wrong return value.

Add goto out_free_data after logging connect error to fix the issue.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

blktests is passing with this patch :-

blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  24.281s  ...  24.481s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  11.262s  ...  11.275s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  0.492s  ...  0.496s
nvme/005 (reset local loopback target)                       [passed]
    runtime  0.810s  ...  0.807s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.093s  ...  0.091s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.063s  ...  0.064s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.490s  ...  0.491s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  0.478s  ...  0.466s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  51.736s  ...  41.236s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  203.890s  ...  141.790s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  45.403s  ...  33.713s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  113.799s  ...  119.578s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  8.669s  ...  8.488s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  7.303s  ...  6.619s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  12.945s  ...  13.004s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  14.377s  ...  14.490s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  0.491s  ...  0.472s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  0.488s  ...  0.505s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  0.502s  ...  0.472s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  0.472s  ...  0.499s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  0.802s  ...  0.812s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  0.505s  ...  0.488s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  0.474s  ...  0.481s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  0.484s  ...  0.470s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  0.482s  ...  0.479s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  0.473s  ...  0.493s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  0.492s  ...  0.474s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  0.671s  ...  0.667s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.244s  ...  0.241s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  4.329s  ...  4.257s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.019s  ...  0.020s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.225s  ...  7.154s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  1.946s  ...  1.938s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  5.804s  ...  5.733s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  25.909s  ...  21.684s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  4.080s  ...  4.091s
nvme/045 (Test re-authentication)                            [passed]
    runtime  2.213s  ...  1.706s
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    nvme_trtype=loop is not supported in this test
blktests (master) #

 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..495c171daead 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -534,6 +534,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
+		goto out_free_data;
 	}
 	result = le32_to_cpu(res.u32);
 	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
-- 
2.40.0


