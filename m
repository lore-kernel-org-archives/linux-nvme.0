Return-Path: <SRS0=vsJd=PF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7881C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 08:58:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594DE61040
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 08:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 594DE61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w7ItCSDVD1h/1s6oeBJPL938lNR1CoVajuDq1tZho6k=; b=i+M7hO3xv+L51FJiILXC89w3Nx
	o+CdgyNSc+ivmyIzxnZIupb/7FKyBh31CxnucSmXD4u4vX1xYyn/Wa0EukdEV0I+OOlUPVFdE97+O
	980aG+fYObazLWEKTxFTh1h3Ch/yXa30PzpowuYGT251+ktvqLm3bqClo1fsbxGRha6eCXq/wL022
	g1TE5Y9Nre+CrCX4xnMwkFcJcOwR4EtpBuMstO+EVwl9zcD/DWsy9vLWfGGgrmR/LQBjtFQrzCdrK
	0w0pbOsVy7MpSwC9cThUgMAUAH56Uyyt/guu+WmJ2y52yqwU4n2jp1YN/PhggfmD3ynqVJJQNld0K
	FBPaS+kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mc204-00Byrm-02; Sun, 17 Oct 2021 08:58:36 +0000
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com
 ([40.107.236.88] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mc200-00ByrF-N3
 for linux-nvme@lists.infradead.org; Sun, 17 Oct 2021 08:58:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0r7EEWp6ju7ywtODqd1XCY8jzQW9C57MVI+Bwnvjv+bQwymtZWFKrldao6KzrCttDTRKlxXyEPyFQqMQAZtwLo7fBfjWLAN2QnWmzlCxLKfruC/IpX5apMMDE+Pg7cwoEcbffXNm9Sane4+aFqIGszr5OAyk8t8TB0PZlSxOJqyp8oABMt+sLNdnm1VPI0jNw1gBmppD16kpPw2PLTtTE4lBojYC9F+7u+aGlSefLgEebglZRLKtn3uITL85XkkHTrqrDlQlmB+w1g2fe+fa4Yp9S3RIw2l/yBxxEwrKtvv0Ef7jwQDfzd2s96vGxbfrmiHWE/O8dp3uB8czgjD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7ItCSDVD1h/1s6oeBJPL938lNR1CoVajuDq1tZho6k=;
 b=TVAqCPBPUQxN8OX+DIWbB2EdKcL+2IdoBqiuFB+E9MY5gxQK50zzdk/8tTOgQHmd9ZIZuiDp9fyC16KJVIHm5/LGG9iyPjX0+4aQjQ0RO51nIZ576ib39RtbDcvwj3GX+YzGevT1s3UyIxEf0j+bco4+4VLziC6w0ekNLHArBq2imnzG1g4BeX2HDmJxtni8Fc+x0QrFo5WrCp1RvSndug6sg1jqSrCVgpKypQIxv1JrwTE/nZBRvY82iR6dw1QxDAY7aaLmg9pJmqUK8F0NpZdgZTSSlGjKuHWTMbOyxcakQIJYS/+OeQztDUAKcm/YR43xfzY4qDxc35zY6LnprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7ItCSDVD1h/1s6oeBJPL938lNR1CoVajuDq1tZho6k=;
 b=f2gQkb2nn0FuE7Hm61mBuZhIvlp7yv/ZLBkYeyvQJya0nQQDDZMg14hsPUehSIG9tssebYVhcOfga/1vKK2XhihIOWhbrUjQ5MlSjRad9E7GPgPukA4a0Pvd8Zluqvb63Bz1/WxPtmshxC4mheGYybAoLuZj8VfEPNlcMiE01pGdgof0RDnVijn2KdCinpIHiaQU6P3m523QNd6mK+ZRCLaMEHcd6pneJovivaw8DRTIujvVPfxEf2ycqXAObvBzsoG3aAqip7+F3WSFNq1i/8OyQPKDgECNgBjT3wP9vexa7F84FzTGoO8Ijlck/pUY4U9OWySSRuVBdHuEH4zKkA==
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by BN6PR1201MB2499.namprd12.prod.outlook.com (2603:10b6:404:b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Sun, 17 Oct
 2021 08:58:21 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::4b) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Sun, 17 Oct 2021 08:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Sun, 17 Oct 2021 08:58:20 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 17 Oct
 2021 08:58:19 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 17 Oct 2021 01:58:17 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>, "Max
 Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme-rdma: fix error code in nvme_rdma_setup_ctrl
Date: Sun, 17 Oct 2021 11:58:16 +0300
Message-ID: <20211017085816.4940-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08efcc85-4d1f-4a78-7153-08d9914c44c6
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2499:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2499F8C358BB8BCB58484B50DEBB9@BN6PR1201MB2499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5ExG1b5y3w/ST7DIkW9yZp273A+b7S5ulExpjzWjLxE7KkrTZKVE/YTDFZo8Nw99vbR7VCFTZOu1J9ffqqWFDnSiY12oH+qa5bkYHqC3DDRDre9fi4Hgdg2bnzAXeCxopyv0xZ9xGDU3pNcVitdba16v8UBLxtUppAq/4hdHrHK3IstCXJ1UK6zsXI0aXR2+QLx9wqrsCpxoS28ucdz1dfyLeX1pNUgoqKX/QmCLoTPg3uH3DwX7UmSVQMpV+YPcIidUtVpp6/Inteb1vmcjslPAW9Vxo+gMpU09vvdxqK8TRC4+zhwwZaLJ+dOqaQAoh2OLjhpaN2wR5hUfTBz4At/f1NtlnyOwC4WjA9mPvOOeTxPt1xGN1VyuxormJzwFEpk8ML63t5/LU2T6+Tc+Uh9c0VhdZvsM1nlV9e5S9tRLKlGJ29rqM/P0AifH1eSYTQJtyw5QgycqGoNGrcUAP2ReHXfanK1f7b6qRZRIsjgO56bE4Okpix7okNZvDXTx3cUIscm2UxZM2tAysZztqKiatqqL/F+AP7R0fkjkAa3hIv0zQGvyFko96rBxafXzN0/Gr6+RaAZeIepV327EN6dy9O6r5T1V8XVKgwC+5URtBtHKjcH2h6KLO5syYp4vRJe1GWGXQlGOCf/vyWX6x2jA6zljbRCbkcg1SjrR8/N1lwncNDpwBb53Wof6Akw17IRavXf4zcx5aJgeiKLDA==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(86362001)(26005)(2906002)(36756003)(54906003)(47076005)(2616005)(70206006)(8676002)(8936002)(70586007)(1076003)(107886003)(4744005)(4326008)(508600001)(426003)(5660300002)(110136005)(186003)(82310400003)(7636003)(356005)(336012)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2021 08:58:20.5900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08efcc85-4d1f-4a78-7153-08d9914c44c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2499
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211017_015832_802924_C9976EBE 
X-CRM114-Status: UNSURE (   8.72  )
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

In case that icdoff is not zero or mandatory keyed sgls are not
supported by the NVMe/RDMA target, we'll go to error flow but we'll
return 0 to the caller. Fix it by returning an appropriate error code.

Fixes: c66e2998c8ca ("nvme-rdma: centralize controller setup sequence")
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 142067d92f02..aa3e142047eb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1083,11 +1083,13 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		return ret;
 
 	if (ctrl->ctrl.icdoff) {
+		ret = -EOPNOTSUPP;
 		dev_err(ctrl->ctrl.device, "icdoff is not supported!\n");
 		goto destroy_admin;
 	}
 
 	if (!(ctrl->ctrl.sgls & (1 << 2))) {
+		ret = -EOPNOTSUPP;
 		dev_err(ctrl->ctrl.device,
 			"Mandatory keyed sgls are not supported!\n");
 		goto destroy_admin;
-- 
2.18.1


