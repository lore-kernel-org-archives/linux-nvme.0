Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E00C4829C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 06:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ApzK0l4Qd8hGC2vateHVlflxWqrFSh3B9YS0mUXWKXc=; b=qXxJIWN63ceDuQdpk17kuCIAF9
	aCY7VAlSu3fiIXPf85FS7ufqFsWkNyumNW6ako41JrlYUFOUfSvHWaluXDVHsEGwy9A6JVEx5mFvF
	Zw+kOnYu3olaoTMcti8DLDpa9XzGIS2AJBixoz2JXR0XMeML0ZGM/gIJUQLEJuEQTYNhNo+1EVphO
	n0DqTc23biNUC8EaZh/8sbxuMX3oQAoB701p1w54PyV0Ak6jD0xhZPnsFEiB0uu41wxNOhi9igPX9
	/stIiPww6P2G3C2Q92AkRw+YFjcOUM/u0AXZ9b5sc9rUmFzpJbZ6KoEdWw7Ero5xcRcZGnvMnFuoK
	D7VLrm9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXxqW-0000000CnKi-2Cx4;
	Thu, 08 Feb 2024 06:25:16 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXxqT-0000000CnI8-1HaX
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 06:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC5z/RKOcCZmgCemK0i/9TfgvikTqc6I8wrOZXQud4ZGx6elNH/f40xJfq6fzusJ7QFMQdpJllmmDzUtyw2ob25eUbExZd/0MaARd2jFhhNKIpgbrpItPaKyBNoDEktc52hzxZLV50Q4BZyBWy/9CjnFJRJHgbmB321mDbvGrKo9mn1kcfyReb+kUBosfVr+TJSJDLQLT88V8sR+1bjStna6CYbByhtL68kOqcX2rguwy5bekGl8dZQcgb23pNjSMoSvwXurkinoO1MsCte6GgjFu4W7XcpwREDLP+1ulLbvCaDbUTSyKYA+HtzRsVKY0VqiZq8xkcYcIpb8N4fmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApzK0l4Qd8hGC2vateHVlflxWqrFSh3B9YS0mUXWKXc=;
 b=VBXziQk/olFwqT2Q6TvRzYFye9dmS6oWgnuOUR3pClSuKjm2241Bqamn4ySubzQzrkwHmRYBzgLwxB3VBVSUc2cXhpCxxmWfOEN85rlM/U8uy780fiiGvRk/a/qSBj921raK1P/wBS/boDzQKaR31KZ46zVhk4WnW4OOOxcMyr4tONvtsRxDRBW6fF0BDf39rVoBgMl4fCy+aMbXrci/bDXhOBU/Tv0nPEPtO1Bcm8EOVMhhzHvZJPQ28Rpv/3uLSVv5q9f/YrAEAeVQh29Ea0Wa2rVG3uImn2TrEOubwT1r2lbvYe/T+ZP3bkSNu/xrc70YTbsZbqsPTd3dyND0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApzK0l4Qd8hGC2vateHVlflxWqrFSh3B9YS0mUXWKXc=;
 b=RX5WAGxOmj5EK7b4HjsAepwF4GS9wDJ/y5/UFgWNuJJdTCgwKAYL9zQ5bAgJqnZfnu2Z3yqj3O48a3XS3FUzjgqjD9nO7e+N2xD33VA7u9cMHRaCdMACgvtVPE8Sm8Oi/9zvpFXnpy40jBVk+XL3CbdKe45wvu2e+p8Q0xtP4a3OBnIXbvLtTWg4jP23pdIluPbAhkmTsMfuk4yejDDlwu5sSQNxbxkh8Pq2090otF+SseS3rQK9zjSq9m+L1igrqnkAtuP3NWCN6nfe7CEou1NSBo/fyIexz4biqSBUqJKA0MRSTsxcyxX5/sjl0WWgldOuwnwIs69dqlV0KULWFQ==
Received: from CH2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:610:50::34)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 06:25:09 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::f6) by CH2PR16CA0024.outlook.office365.com
 (2603:10b6:610:50::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Thu, 8 Feb 2024 06:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 06:25:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 22:24:58 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 7 Feb
 2024 22:24:57 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvme-fabrics: use post connect auth helper
Date: Wed, 7 Feb 2024 22:24:26 -0800
Message-ID: <20240208062427.31255-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240208062427.31255-1-kch@nvidia.com>
References: <20240208062427.31255-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 538604b3-c4f5-4dbe-19ba-08dc286eb28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zr29G1AKQDyuuMlMAOipkR+RYSASC9vVhcjuKKzCylkrprwuU+ekniG8QVKlpXQmNkquqS8BysIWxIgyABZOO7ttj1W23+FlFrmz/Aj9jmDYaLPdoaKyIZMC0l139lJ+KdL9d3eZVm+iZvzmnTHPMX5bh13plp958r/mBWBK9Tc8HDbKmv0jH6mzwQJso7qL1QrOwjb/CTvQTU/Py1zpDh4dD4HL40MgMYZoK7tfX+kyhWwTVm5e9+FiJxKjGTUO9nsRvZOH/K+jZkaAqoMWHquU1ASSzgFuVMpfGgxxE6t99rvyck87SwYpgfyvHysiNjGv/rQ+8yTQAR9l7Jvfna4G5m0w1BdO8jErZeq1Uzn8UMwXxd84/xr0GrW77O+SVCS0EsTGcoG3x4oF83czwX/0DdP3uEvMgEn1i+94lS9jMKI8ZZkLWBE6BLZVqLkug7s2/sGiD4L6IkjAzSv/Oik/jArklTLhzfC7lI1PLq1loW5vSYp3VKSCye1u9PBV65HL7AP31dlEGJW7BL8fEs4XCPU9OFH7QTUJJFDUxx7JYwyN1+NJNjo0m5PdkNqPNdqFmhWw236qGOFzMMRvmQmeHMp1PYzEiMWHjd0rJdo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(41300700001)(83380400001)(6916009)(8676002)(8936002)(4326008)(16526019)(356005)(5660300002)(82740400003)(478600001)(2906002)(36756003)(26005)(336012)(426003)(6666004)(70206006)(2616005)(107886003)(70586007)(7696005)(7636003)(316002)(1076003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 06:25:08.5310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538604b3-c4f5-4dbe-19ba-08dc286eb28d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_222513_386888_3353A90D 
X-CRM114-Status: UNSURE (   9.91  )
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

Use previously added helper to handle post connect command auth in
nvmf_connect_io_queue().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 24f0d298825b..19130e3bd00a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -493,7 +493,6 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	struct nvmf_connect_data *data;
 	union nvme_result res;
 	int ret;
-	u32 result;
 
 	nvmf_connect_cmd_prep(ctrl, qid, &cmd);
 
@@ -508,29 +507,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
 	}
-	result = le32_to_cpu(res.u32);
-	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
-		/* Secure concatenation is not implemented */
-		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
-			dev_warn(ctrl->device,
-				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
-			goto out_free_data;
-		}
-		/* Authentication required */
-		ret = nvme_auth_negotiate(ctrl, qid);
-		if (ret) {
-			dev_warn(ctrl->device,
-				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
-		} else {
-			ret = nvme_auth_wait(ctrl, qid);
-			if (ret)
-				dev_warn(ctrl->device,
-					 "qid %u: authentication failed\n", qid);
-		}
-	}
-out_free_data:
+	ret = nvme_auth_post_connect(ctrl, 0, le32_to_cpu(res.u32));
 	kfree(data);
 	return ret;
 }
-- 
2.40.0


