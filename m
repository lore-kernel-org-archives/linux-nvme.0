Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286E8C47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz4ldz9+NmA+/A/8Feq0vTN8uvD7C2WlxvASIo3SgRo=; b=gObPNsIg0EO6PlDyu3s6sSPnku
	HvF1sWHRjBV4WvcFwp7g6gtplVMX8eyUQ8hOdELM7dRii/Uma4gHoRfq183J6GsAFLSxlxT8XyiPE
	Q5qO85cJc/mEKBzGKPSsbpNUgKxTJ1zlw26UXd6psU3RlB2+kqqG60yN/UfwB24wzgBGPWNKbMYbk
	o2037fqGyKuuV7/ARH5IsBLAUXr3gjSPbu60u+oyct7Q/lekdk06NJYle88rg8w0rtr08Z+sgYW1m
	nb4tVrfgC2zfJgVDF92miLEbyzZgJL4htGBOm8+T9eW5pxWTpthq8sfBKoj6eXUpbzPKlsRuSzxcU
	DIp1rerg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkT-00CW3C-2j;
	Mon, 22 Jan 2024 14:58:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkR-00CW15-33
	for linux-nvme@bombadil.infradead.org;
	Mon, 22 Jan 2024 14:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gz4ldz9+NmA+/A/8Feq0vTN8uvD7C2WlxvASIo3SgRo=; b=EMkClcMNhaCNe1feFqnYrKZQHa
	1XhX0bI68NUHw3x0T/68Fr0ijngeHYb2HXDFS0ag6dO+AWcpFXd/vkazI1TVBw5uOhdZWB6lsjAHo
	h8MFMCP4fJU8+32HjV6WSxeAfGostvmNNsuey/nj+dGSRkSz7wPl5ShmJJgz9hG7sQ3MMhjADMP5A
	a0XQveY0aZH9dyuoiFYXO0S9gn06ccj9p7nktt49dL//Y9ZFIkaIfvrsj8fDQPfuLhGFob5Ml46xO
	bIpToMm08WYo/7VtMDN1EfopFKNVnEnS0NyJTHvIAabdW1+N7yrawS1USwszP2j4x2l9Vx0Hu1mSO
	BfqPNjAA==;
Received: from mail-dm6nam11on20610.outbound.protection.outlook.com ([2a01:111:f400:7eaa::610] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRvkO-00000003LKL-40np
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 14:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUUMjS4wR0SIGMOXZuB+F2ImZDt3dA030L892VaSAXZ+G+5HUAUSPDTAQ3HjppMN2/1prxlmHM9ChBEt4mAi1LT4CcyGCXk+/n5QvDRHrClzVriU5Z1m86hLE0dtVb5QLJKdN4OAfUBkPthutIRwRD/89tqmulXR9VkITR1+EAEg15Pq1yu0wmoxIX7LQy/HE4PiD0Zucl+crfiVjmLrQj3uVau2JvQERSDJL9/yXG4L4umO2IpMV3JXUiiXzCYayf3QrcwK5D5f0d1A01rWjIsR/75kflnOawV26LBxP+ErHFIrN+ON7VoG+dCRVeyqnGK2Uyd/vOmLiA6JzTa68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz4ldz9+NmA+/A/8Feq0vTN8uvD7C2WlxvASIo3SgRo=;
 b=N/rhdUfAI9GLzcaXHUT+r1Ct6nL1gmkLo2XhXOJfJZPpHvC0TfXY2LlwHxrRijQ2KhcK6tlJFfnRW2NaUBDQV2B7M8zXQ4cCMot4L+uC9z2Kg0ucN8r6g6Uhe+pBm6Ny1y+27VUb56QX7UcOn7XXMyUfF2DWFxvn2qaMR55q3VKvo1eGDYtnJsxz+ggLGtG/C4nucM6ZUjCFjFm94VxBagYPTbTLUVFk2yaYij8VFy9OUHEY8kk/yeEDtIhYgyAoosCCGAllQG3aimVom2h6D1d0WeCayDb20ERCuk/eIpFACXeCEOHiv3eaXFsEOEluqTfnuh3ZI2drKDpI4vyxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz4ldz9+NmA+/A/8Feq0vTN8uvD7C2WlxvASIo3SgRo=;
 b=tk3lnKWt491Di+wPmelSpquP4jmUFbkRbDi+lB6ie3y9eRSMuLexZ0xp3Cl6Vvo8ZglZySBCCscg3cE9Cgk2ovQrNcr3SG4IBsxBcLrJylG7N154emN6spBlKJh2S1zB9347DcIo9S2HgtL3UYh4QJzi5UJqZo98kn00WKfn83ppXizxdjQjFRAdUAPU1xW/s8622dI6IfU08JXrdB8LTevWEnd+l1/IgSDhx5GDtPukrRMNu5aNsgIwvL3yeo48Y9CSxEIdl02n+NHwKvAvhONZ9TavN0/doD3XUYAJmyHYFy2gprFzX0iWnKlz7kKm9lhuacgOPF2h3RDsnUNwoA==
Received: from DS7PR05CA0045.namprd05.prod.outlook.com (2603:10b6:8:2f::7) by
 DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.34; Mon, 22 Jan 2024 14:57:41 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::68) by DS7PR05CA0045.outlook.office365.com
 (2603:10b6:8:2f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.17 via Frontend
 Transport; Mon, 22 Jan 2024 14:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 14:57:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 06:57:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 06:57:24 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 06:57:22 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <dwagner@suse.de>,
	<oevron@nvidia.com>
Subject: [PATCH 8/8] nvme-rdma: enable user to disallow T10-PI offload
Date: Mon, 22 Jan 2024 16:56:59 +0200
Message-ID: <20240122145659.5574-9-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240122145659.5574-1-mgurtovoy@nvidia.com>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e98cb4-6e55-4b55-3217-08dc1b5a7b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ylq+TeaLNN+CZCe8KHP2UFRjjG6euigmrutxt8EQXfRw4LKGKYM3b/DwUsDSSpnBC5GvLtB5wD9IvnAYXEpQ+NsGzvGNWmZ377jrFK4fBLYpPumnoTxH6ObG02J+NlJYBKZGx0HpjgIk84bqUpwEjRFCzcbA4ackNADLX8j6d/eO33J9O1tLDzaYS5Eysz+bLFkGyAp+1lXvvLKjsj/Hd4Z7mNabI78nLDPZfbg9nQUuixAcrjCR8t4mwXCC5MDAV1XCL8SSyBtRC9XPUxJP3KMFQwkSItQDwpCp8IqwplIH2gQWTwbi7hnmuXvMw6hfQXRfWcxs/AGWNHfH7X2N7IB0sS8wum0vEHgrMboZNvQ+Zxx5/k6sYR982P4MG7jx3P7jYB2NcCw55HwIFZa/1bIN/LhfNWm9UTK914T8EiEZKqbzq5vK9TCCdG79WO1Fkcf3hLdhmBs4EwxD01hov9lMQpV4IyJeiNuUE6fIeeDdzGNqgJAE+w39Q8yE/0/ZuwaTsHMnqgFCVCNOzDuvzNStuY+qwrvBXDcGh+Yqs+Wko/BSk3DHxy+kNEBF8113+LjEA4jtASahfEbqRETGh3PMpgKNj8UCye1DgEv2QXe7ah48mUOhwrMCFppnVavGFYkIREB3zC+qOqiqzq8NLURXdiKAOWA3pyW9RqB1XCZXpeW3dJc6U7YjdaSMquBevwMvOF5+HIEPOxQWJvyCaRPuU04UfRJvuvUJgRiL4eK9oZT5bUak+IgHmeeYywfT
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(1076003)(426003)(26005)(336012)(2616005)(356005)(107886003)(82740400003)(2906002)(47076005)(7636003)(5660300002)(70206006)(70586007)(41300700001)(316002)(4326008)(110136005)(54906003)(8676002)(8936002)(6666004)(478600001)(36756003)(86362001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:57:41.0565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e98cb4-6e55-4b55-3217-08dc1b5a7b6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_145801_095264_E8AF960C 
X-CRM114-Status: GOOD (  13.31  )
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

From: Israel Rukshin <israelr@nvidia.com>

Disallowing metadata support helps the user to save system
resources and allow a more flexible configuration. For example,
in multipath case, when PI offload is supported only on one of
the paths (running on ConnectX-4 that support PI offload and on
ConnectX-3 that doesn't support PI offload) then two NS heads
will be created by default and multipath can't be enabled on this
setup. But when the disallow_pi flag is used on the path that
supports PI (ConnectX-4 path) then only a single NS head will be
created and multipath will be set properly.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a380bafbed08..0c5671832b50 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -791,8 +791,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	ctrl->ctrl.numa_node = ibdev_to_node(ctrl->device->dev);
 
 	/* T10-PI support */
-	if (ctrl->device->dev->attrs.kernel_cap_flags &
-	    IBK_INTEGRITY_HANDOVER)
+	if (!ctrl->ctrl.opts->disallow_pi &&
+	    (ctrl->device->dev->attrs.kernel_cap_flags &
+	     IBK_INTEGRITY_HANDOVER))
 		pi_capable = true;
 
 	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev,
@@ -2325,7 +2326,7 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS,
+			  NVMF_OPT_TOS | NVMF_OPT_DISALLOW_PI,
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-- 
2.18.1


