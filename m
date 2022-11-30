Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A113EC4321E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 21:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dA2TDCotRN6B7ACMVDJ4mBYEqsQfTn+Xc0mVm9JnBkk=; b=rsVLfN4P/L9kxXAvvVmSz5qwES
	YaPZsM/xRtG3wtE/WbNmqdyODLQYT5Nv7/zmcBwJe3j4pgcJZllZ135+gFz/0bElLWkOelycma+vZ
	CPqiuFST729ga18cy3gr0XvCpNv/C7Y9JxwGA4qyJGvC9n1HbvhRV1zS/lrosxVZ1+qo/35imP3xL
	/ZazauIC9rXhKLUigHsz0mIYk92trxUbZjxU56N6g0XAyH2sBXPT8NdE0Hf2MzkoMYIeKnV0gxmpQ
	yFbLdXdWW/uubfOaSyPLKK0/7UOIkHrKdwUpzEYVnhAXhStG5njg8RVN/+EIr94wOUs3eW7l+XbGh
	sJmABWEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Uic-002qan-Cq; Wed, 30 Nov 2022 21:34:14 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0UiZ-002qYo-A2
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 21:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmzByhg1b69nvaju+JeAqxTOOZpmk0CmnI0RoXztBigbg2cSrTp+X2i5Ge/AAr5IQEo9lSTKkSZHh/Q1lVWIG+QaSp56SJFMYY9TOO8tS1lvhv0mVQMDwPXdmzO/lzfjoHNxM2Dn59OJhF9T1e9o4zWQ8oF//zyZAt/9mjrj6dXusxYOLr45mfxuIEw6MapPFhlluUXt4ZzMkGO5xvNDLtQ3d7tMhpnO+2ap/r5poG55krFlFFA4lhjkVz4I8EN6TD7wZNcmR27Eeo+FRECfq4bvg4XrD6uOEFt/nmCUv/08FlmPWEfJoJBPQNdF2dmEzLKXgQAqrbkhvY/u6FqCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA2TDCotRN6B7ACMVDJ4mBYEqsQfTn+Xc0mVm9JnBkk=;
 b=H4hvz0vciTYcUmEThC1EDZH9bLu1zQfoyhZoCAA2VUw/o+PphHsrqpKzsGyEOzEuV4J27Pj7gDGg6d7X/7D1sPTN3dRC1yTxMhcokPyRL2FUySo1t3ctK1wOd0vt9958C3scOJqm0G6hidygQV385yd0r9xCbTjqjiLRSIZIC9JUJZRtGfVlzyzUOOEwogz/+nvzY+FBU+azgCuMvNOo+B55Grfvnpx15XR60vxxecjtZg0c35dQyp4Kw+bM/3B9YUMuFc5o0rWb6LiAdelyllBrqt0slR9jCn75RKM+2XV9Hi9oJXpYA+ftG0nWDf0SmeGmo+D7LNYXuJSECmy4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA2TDCotRN6B7ACMVDJ4mBYEqsQfTn+Xc0mVm9JnBkk=;
 b=hsBMGlpysNkYvjOnD0MQEBdV6KJW4/W1YoQ+btC23mDgm8qb/qrUMN7x0x6/1mcJBhHhtPEdVVqBHL7O+xwn7RZwtSetNlETJzCiwmSGFDGccTHFWUJuDax7NPTJyOSkHz8+gDzVKUntkD7A4VvL+rOq+4sYMnVlYsvpfuWXAy68A/CUtD0iqXnJbzM7E8lVmLsISc0ood/0XotFZJPBQMLMABaRliO5ih9eiOeOs2V+bm+9+czNm0m9i9Ykxd9qGO8GlcY6Utslc5u3T3IFvQkQ8xiS3b7ZhcWUcrgpcjjMM3HW1pRJ4QEQGg+dH0Qu5SN1TarcerUXS0aT4jCFkQ==
Received: from MW2PR16CA0066.namprd16.prod.outlook.com (2603:10b6:907:1::43)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 21:34:02 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::f4) by MW2PR16CA0066.outlook.office365.com
 (2603:10b6:907:1::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Wed, 30 Nov 2022 21:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23 via Frontend Transport; Wed, 30 Nov 2022 21:34:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 30 Nov
 2022 13:33:49 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 30 Nov
 2022 13:33:49 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <james.smart@broadcom.com>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] nvme-fc: avoid null pointer dereference
Date: Wed, 30 Nov 2022 13:33:40 -0800
Message-ID: <20221130213341.9625-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef197ca-e0f5-4efd-722c-08dad31a99b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	lWeEiN0g0fN1rbtEjZC4cwymq5/LUnidplNRtDdNUyrobgYWAqkOL9nz7vtNdGHCIQbvqB7d5jENy6fTJAWw/4cp88GRvl9S+HW8+uSUIfuoSX+HGKjqKrx2oXwMyAtxLydnx70+IiOZB+i6aUv2OcPTza+FDW7cCzyt8rf/0fSqiJcNh0phw/WWp06+sHY7Ki4CWJMkpPKI8oXckiK0eoQGbOCQz7QnDEAyV9QqrgxKDLQOlLw72T7ANyHpMdJEciwK5yT7fkVAVeEFavWYFCsf5zuTRcp5Irn3RM6y+BYl4hI4HSY8bxzZIkrjibZqaFYGAZzkQcFZz6I6bOvzu/uvDu9EzRofGNQMrhxbfeW1XmXz9g04Bs+4C94FibEfAX9ihq//CSWFg0k8k6yJXz8a5c7/3aZwFm76cFncSBLNCcqnsJrCFK5iNcSWA2IrD69RsW7oy40YxZ1ZD6EvOtkSUqiApvYJut5LPObKPAvoRQkJpkLW3w40d/+hJOjCiie/m0wv0UfGl4e+bd2EeAfsu1UfihsDhxZA0/08w2ZuXm4iEYDuhe1d/EgNe4h1NFLgSfywDfrWINsfqKq1T3mbryZJgyk5UEkl0AjdjVH+Pc7gfkf4MXVe8aq5+bd1TiUio79a3LTDWi1NP2E8Ao4yQfHXXsLDhoz5U1Yy8un7tejWIcZNGJMUi+v/vWLkNoVqM3lVYArGAcmzL9Em8g==
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(7636003)(40480700001)(6666004)(478600001)(82310400005)(7696005)(41300700001)(26005)(82740400003)(8676002)(356005)(36756003)(70586007)(40460700003)(70206006)(4326008)(316002)(336012)(54906003)(6916009)(8936002)(5660300002)(426003)(1076003)(186003)(16526019)(47076005)(2616005)(83380400001)(107886003)(2906002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 21:34:02.6330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef197ca-e0f5-4efd-722c-08dad31a99b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_133411_721005_05CC2812 
X-CRM114-Status: GOOD (  10.12  )
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

Before using dynamically allcoated variable lsop in the
nvme_fc_rcv_ls_req(), add a check for NULL and error out early.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 489f5e797204..06bae7150087 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1754,9 +1754,18 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	}
 
 	lsop = kzalloc(sizeof(*lsop), GFP_KERNEL);
+	if (!lsop) {
+		dev_info(lport->dev,
+			"RCV %s LS failed: No memory\n",
+			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
+				nvmefc_ls_names[w0->ls_cmd] : "");
+		ret = -ENOMEM;
+		goto out_put;
+	}
+
 	lsop->rqstbuf = kzalloc(sizeof(*lsop->rqstbuf), GFP_KERNEL);
 	lsop->rspbuf = kzalloc(sizeof(*lsop->rspbuf), GFP_KERNEL);
-	if (!lsop || !lsop->rqstbuf || !lsop->rspbuf) {
+	if (!lsop->rqstbuf || !lsop->rspbuf) {
 		dev_info(lport->dev,
 			"RCV %s LS failed: No memory\n",
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
-- 
2.29.0


