Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89927C636C9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:53:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB6161165
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB6161165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NJDxSCidsf/N6J14tOeGPqyElbHjzAdCLgndbST6bi8=; b=w7T+2ASf85BslW
	nAptOPsfkMEsru0rNsUWc848wQQUI+4E7PPRSySX4+2bhF+DRzkU54OAw9KrjAA0xaf5GtyrgA44C
	0f6sI5ZqtXnRodh0a4NcfFE9IVJGsj4ckCd/qjgZuUFLMdinZbVwcIoYP0VUUBqgHXBQHTCJLqLoa
	blp/2PLH2AOHO+h6yLbZ9VC+o0UW0lW4CV08yA5BVQaG3MTJjWCbpEb2pU360zQxETao1z01n+w0v
	eq99mkJ4gzeClG3UHhLUtiCdOMV84jLfxCoOtwT+4+STjQ5ZW8+VzTdVRdUMJU7nVxt5uC3CpTwHp
	LTBftlHQHmWot+Q95PyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5Pxg-00998M-BK; Mon, 19 Jul 2021 09:53:20 +0000
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com
 ([40.107.223.71] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5Pxd-00997t-HM
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 09:53:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFTaHbPu6gjyv1AwbHFWoaO+v/qlciq1vGpS5RR0tOaklw0Iq2OoNH6TyfQHkKGLPeOACtbZzNs23Vga1LcVxQ3QYFKwGKwtMx5aSChCm/7tPQpXNKqYM7a6TwR0p92qWjB1ijHTERuYjbMhnvPmqR+yssITXpO6DNdW7cwsh8/fFhCtYfpb+/QCoR2lTZAq6rvElJLHWDte6tT6hXzA3Ajb/dAYm1szRjSL93JfoUBvDkoPh9s0MCKYu3C+x3cFdZ5FxFnkoDyesir5SrFasHnRKb6g80Tjdr3gcd+/0PWnw4srO+xK9dVXqHQxT48gIiEUAkvb7n2VNhAaAHjGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPtcd8D38ISrbi97JzGnrsIVrKJjbrDpy5PHwIoCW6M=;
 b=F/A6NqtXnU/UhWYEm9jlmx5OC2Wde3/dKKJUp5gTkyZZq/c4T17bUTwFBDgp1tqGsm4Y3QUsqdr3k9wBkYGY7mj9Rz/4yFX+nGfnQ9epoLJOR1FBFT3Gwh/BHxd7J/nSskGe5hv0fYmcTemKrKo4xjwid7TPgHg2WnF/2t42DXK9AKrguyCgZI1WUJ7o12xpEqMPT9ncER+Uz1nt8WYBm6gAF6xBG/B3SDqiCKop+T2/pzFuhPluzZ5L1rLKzDCJ9yv9KIQduewynzuN/Nm1GkZHlNdWUArbQ37R2LVTNp++LA58n3nXcrKcfdxhOYAIpNGev23yDTTEl+cG1DDxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPtcd8D38ISrbi97JzGnrsIVrKJjbrDpy5PHwIoCW6M=;
 b=OClJEoQfXkUrsbRCnep9JHcIFXoqXcJxr3QTsM33em5m8Z3lZPhIPy9s7p0cL5kuU73NQMO/0mQNeSc8TbK0Y4kw5BPrQo9Djo6wbpfkvDyjHkb1r5d0mjzRJDtA7qvmZN+aaIMdezp3fvKlyfbWP17DQNFBuXPqbRwqFQMe2H9Wq/HYz3kn3rhWZRK+0n1eBZaAA7L4z8lRreVJ3SsTPgDawpVmfRPo5+IqTTLLjwy+osGLX4/PflvGf0EOO0jpkV0Z73CqjUSrjChdtkgkTuiDNJ7drlY1gL8wp79hJ0JIavnSt31AnuaFx/Cv2U7xLScSDfCYHyaxjc28jSOZ6g==
Received: from MW2PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:302:1::32)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 09:53:13 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::2b) by MW2PR2101CA0019.outlook.office365.com
 (2603:10b6:302:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.2 via Frontend
 Transport; Mon, 19 Jul 2021 09:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 09:53:13 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 09:53:12 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Jul 2021 09:53:10 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <james.smart@broadcom.com>
CC: <oren@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme: introduce nvme_transport_sgl_desc structure
Date: Mon, 19 Jul 2021 12:53:09 +0300
Message-ID: <20210719095309.7777-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d517d69e-e395-441b-4422-08d94a9b061d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4780:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47802F79B268D5EB35976F73DEE19@DM6PR12MB4780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yfh6HvegAetbJODYnrGVvHW9ffhnzoOPONEqryEnbIoKmTOWxnwmMxGD22r0aH3vuZd8czOnR+1DSHEyNCVpHUy4IrPecI189huipOjc0HDRB/nuSHNlsj9NMFpOsNtSFWrq5gjHtX75Se1aQah46ZRKuNg/hEkZZjTks86KBol9hf/A7GJLRvm60wb5DLDcrfI+cH0dYQgYmKKJ9byEOuNekJskvevXJJj+IY+sWZfMO0oOVs9IPD+ZWCNOAkqdBzgEnux9ktHkvaTQU/b6j9n6MJzJTT1dPzo9NmhKuMuGIv7ePaZ1BkiV530qYAU4MO27eQxuK57agTuaBebLjRj9wcZziXx86oqQAjcxbtWiCkLqdpwMYhto+YyPaiyBCQmGYi5h2mTWLgufz3GVrswW89iamlN8Ow0YlQJGaA4hIHDFnzqs+ISc1aNairTbjiXrcE14YlGKjOvLqYzTETMnSIJEcrxg/WUOYIewdv+8R453aDiGdIjFYO3pJQu8WNf5r9T9cKkPkOBeeCzJV6eAzKBHerjbzSDSDf2zCVdAD2U+ZMUqpQ2Y8iPP2oLhz6TRPT/QhQebSZ4R1GWG4AMCourtUwflZ3IQ5HQbI2e0jJDXNAXWPBRAlyGkCmreFUKNNUBTAJrQ09kHKeqk2FrE/QsUx3b3+Rh0ttr+Oy9WuKldvoxtFHS921JGh+1XTouf59kGxV+3QRyY2zBNew==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(54906003)(110136005)(82310400003)(36860700001)(82740400003)(83380400001)(2906002)(186003)(1076003)(47076005)(356005)(8936002)(478600001)(2616005)(36756003)(426003)(5660300002)(86362001)(107886003)(36906005)(7636003)(26005)(336012)(4326008)(70206006)(316002)(8676002)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 09:53:13.1474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d517d69e-e395-441b-4422-08d94a9b061d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4780
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_025317_693903_628C4E3E 
X-CRM114-Status: GOOD (  12.01  )
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

Currently the tcp and fc transports use nvme_sgl_desc structure to
describe transport data blocks. Replace it with a new structure that
describes the Transport SGL Data Block according to the NVMe
specification.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fc.c  |  6 ++----
 drivers/nvme/host/tcp.c |  6 ++----
 include/linux/nvme.h    | 14 +++++++++++---
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f183f9fa03d0..adcf39a01d14 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2698,13 +2698,11 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	 * format SQE DPTR field per FC-NVME rules:
 	 *    type=0x5     Transport SGL Data Block Descriptor
 	 *    subtype=0xA  Transport-specific value
-	 *    address=0
 	 *    length=length of the data series
 	 */
-	sqe->rw.dptr.sgl.type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
+	sqe->rw.dptr.tsgl.type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
 					NVME_SGL_FMT_TRANSPORT_A;
-	sqe->rw.dptr.sgl.length = cpu_to_le32(data_len);
-	sqe->rw.dptr.sgl.addr = 0;
+	sqe->rw.dptr.tsgl.length = cpu_to_le32(data_len);
 
 	if (!(op->flags & FCOP_FLAGS_AEN)) {
 		ret = nvme_fc_map_data(ctrl, op->rq, op);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 34f4b3402f7c..c696b962c486 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2143,9 +2143,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 
 static void nvme_tcp_set_sg_null(struct nvme_command *c)
 {
-	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
+	struct nvme_transport_sgl_desc *sg = &c->common.dptr.tsgl;
 
-	sg->addr = 0;
 	sg->length = 0;
 	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
 			NVME_SGL_FMT_TRANSPORT_A;
@@ -2164,9 +2163,8 @@ static void nvme_tcp_set_sg_inline(struct nvme_tcp_queue *queue,
 static void nvme_tcp_set_sg_host_data(struct nvme_command *c,
 		u32 data_len)
 {
-	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
+	struct nvme_transport_sgl_desc *sg = &c->common.dptr.tsgl;
 
-	sg->addr = 0;
 	sg->length = cpu_to_le32(data_len);
 	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
 			NVME_SGL_FMT_TRANSPORT_A;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index edcbd60b88b9..ca0a17970c75 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -742,7 +742,7 @@ enum {
  *   @NVME_KEY_SGL_FMT_DATA_DESC:	keyed data block descriptor
  *
  * Transport-specific SGL types:
- *   @NVME_TRANSPORT_SGL_DATA_DESC:	Transport SGL data dlock descriptor
+ *   @NVME_TRANSPORT_SGL_DATA_DESC:	Transport SGL data block descriptor
  */
 enum {
 	NVME_SGL_FMT_DATA_DESC		= 0x00,
@@ -766,13 +766,21 @@ struct nvme_keyed_sgl_desc {
 	__u8	type;
 };
 
+struct nvme_transport_sgl_desc {
+	__u8	rsvd0[8];
+	__le32	length;
+	__u8	rsvd1[3];
+	__u8	type;
+};
+
 union nvme_data_ptr {
 	struct {
 		__le64	prp1;
 		__le64	prp2;
 	};
-	struct nvme_sgl_desc	sgl;
-	struct nvme_keyed_sgl_desc ksgl;
+	struct nvme_sgl_desc		sgl;
+	struct nvme_keyed_sgl_desc	ksgl;
+	struct nvme_transport_sgl_desc	tsgl;
 };
 
 /*
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
