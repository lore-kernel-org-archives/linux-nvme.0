Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EE6C02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 03:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tJ2md3wdXAx5uNQEeHVmZo1qoA2rGZE1EXSrxqt444A=; b=zxdZ4B7MuE3U4czBmShRjpXSps
	qiqFQdmlsp3lBhnqQ9MaoK9fVwUGVV5+VDN4j+4OklIRwSkDBXaJ2HS4VFTGXMRJN1OZR/EljtGu5
	q/jb7yHjV76lylQPCMo70RuMzIhcTytuPUO25+4p8+W+x4yGbgy/UmuEa43shZo1BpjT34DO0ddzJ
	nAUQn6em3+FHmkNTIA31h9eLExRRRTrzBhesAh+CqVnRWTkazs6GCAuBDhPqlH3ZNfsinplPyqc9W
	6ashU4p4exBkgj3/Fz31wcnj6bkqNDigQ7Bqmn+80YIj+aehMx6mO+RGldM3yf0lJ9vrf/6MUNQcX
	GlhBM96Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXuPk-0000000AYSO-3uNu;
	Wed, 15 Jan 2025 03:49:56 +0000
Received: from mail-bn8nam12on20609.outbound.protection.outlook.com ([2a01:111:f403:2418::609] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXuPh-0000000AYRM-2CpT
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 03:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtUFeg/KSmflHRfnIzRixEbd0cFB6DNq+AuHvkscLCS5O/wUWZOjFnGw6dp7hXQELce4xNHdJBEYWGEqV6oAiH8iQ1dVLQZK3vSY6zmWmbxTqY2COlhBJv8drenKm/EOrZ9MbVvgwHtlXGX1HF0DJv5e3Ja62LHl21olY1YKWRX8vehvWz6l913A129YArMfEd3Jyo68RFtXPVKaIEz1Ehc2e4398twDBDRTui8nu0h8WbFb8soRjK1fnv9FE46s9xM9jWkvFXL/HH2mg+yLwDL/e3LvZpUBwOQcDySmLPH/YXw0bAyorG0CVw8kxOWfv1r4vmoB9XGgnOMVd93O6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ2md3wdXAx5uNQEeHVmZo1qoA2rGZE1EXSrxqt444A=;
 b=wpkDdnDILoPQcXBP/mtvgBcTK4H1RPIUjIxpc+Es7d/8Feskq5zMh9hGn1TlZD6ukVI8Au7YN/1adusQXbuHxQjySResoFKwrkNSS7KvACSRWeXsbnIzjX4kw53Ix4tWLgx2v33ZCxcKJU4ocnEjX96RWzt26zEWIwIa9yy5U5QmSVM+xUPfhlMCq1Qy3PXijfmS2kBCKZFIE8ijkcbZdY53uK0HuiGjK9jH5nbXbU6y3N2aRsQ/rDGI3qAtYmzz3VkSgdTHrOX2AbrwHbsN76GR4hlzP9a5CgPtpuDrJFwGiNB4yXyHKzpnL7mKnrZ2GjO5iR2YNDOOGV/QhGOiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ2md3wdXAx5uNQEeHVmZo1qoA2rGZE1EXSrxqt444A=;
 b=n/jGVLJfUiwnOND5SNMB+R3/33w5S1jVR4l1pXXA7BvvrUiHtsAXLo6A3+lFmJelM7RZeTudSBIG02B+dBJAKrMdrz7/QSahu2v7y5Ovl9WLaNIXbQt8LDhR/HZHB+JHWALpwGTGHfu0wXKUrK87rJ4GSlEa0UErW+Un7MrJQqYln3GCy7Pls4FtfNFU9XubpmmKlkfE3b4OlGlT3pIJQ/TMrs/fKj78Xs0kwiNFTyXVxzquiNUnlperxb3/l14cLZllJbHoqn6NUfu4oMbKw76l0Xlk+FjB8rnGjOR6MbL87oAsqc+ADMFRfCFfisJvHdM8DiqCymL256tTffU7Nw==
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Wed, 15 Jan
 2025 03:49:47 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::91) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 03:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 03:49:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 19:49:31 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 19:49:31 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvmet: fix compliation errors
Date: Tue, 14 Jan 2025 19:47:22 -0800
Message-ID: <20250115034722.145742-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3822a4-5849-4192-edd8-08dd3517a7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjNNMEdIZ0Z0RW9YNUFlTFhzYUoxandPdTdjSGU1d3ZucmQydGtqK1BvL0dR?=
 =?utf-8?B?SFBEL24zQ2xGTHd2Mjk5a24remZnREhTRXN2a3FmOVduVVdMWE5UaFloV0ln?=
 =?utf-8?B?K3JmQ3ZzZ2ZnU1pjdUM2VFd6d3U1ZHpvVkN5VnR5RUtKdHZ2RnFiaG11RTlm?=
 =?utf-8?B?L0ZjVXpwRlQ4engrT3czdmtNUE0vUlJ5Z0hyT21VZTlaY0VsNFFTR0x0bjVz?=
 =?utf-8?B?VFV5TmpTUFRaTngxUVBRbU4xTXFaTFZPWEI0REpSaHhkT2x2aGM2UG96VENm?=
 =?utf-8?B?UDJ3bDM4OURSR1BzUEZodXJNL1kxWlM1NlJFZUZhZUlZaStkMDh6VzU2UlhW?=
 =?utf-8?B?MDdlQytjUldhQWI1RW1DVzV4Qzlmc2wvRnE3RVpzRWEvWWpjWXFHSmE5RVhy?=
 =?utf-8?B?LzIySkV0WmpvSENyS2RuUGNoMitBWFN6VlBRbHRlNWxnOWlnWHVIc0tZaXBF?=
 =?utf-8?B?aFFkSXkxZnJmMzdOV3ozNlhoenJBR3FzREQvQWM4WWFkcVpjQWFWaVZyeHZC?=
 =?utf-8?B?MWduOXFrOHU5c2xoUnFxRUdCaWVMZFJWdUNydjdyazZvSTg2RWxHZkd3a2NY?=
 =?utf-8?B?Vk93RDJoamc0dk5UaHY5UDI5OC8rR2s2cExWOVM4SnRqZHI2NjQvZVZXNDJH?=
 =?utf-8?B?U1FXNnAyVm1xT1JybHZZWVZuM2dBWXlrS1MxVXNCQm5zaUpiS3NGRGR0bmpu?=
 =?utf-8?B?ek1xZEJhTzhMejdhTjR4c01VK1g3SWdpeCtqbzkzQktpeCtHK2dpVnhFc3U0?=
 =?utf-8?B?cktkREVJM1k0QzhUWExTM1BUQUNYRVdGeTc5b3h6aEtsc0FlaTdHcUpSZ1Ix?=
 =?utf-8?B?dmJhN1RoekxzL2hkZ1NveGJqbFFVWjViR3Bxb1BKRUM5YzdiaFNzdWdpLzVp?=
 =?utf-8?B?dHJDU0tvOTlYcE9CQy81c0dvK2VSOGFvMUp1Q2Y3U29BUUp1dDVRVFhod2Ev?=
 =?utf-8?B?Q0xmYnA3VFkrR20yR3NLUzVYNDBUNDZUZU5pbi9iZDArTW5zNmZ2UXk3cmVi?=
 =?utf-8?B?c1k3cGVHZUNRYU4zSXhNaHk3Zmp3ZlJrOVRySnExcFJwOTZHU0hLRTlXUmdW?=
 =?utf-8?B?VkxaRVlhMHZSVll2ZWp4a2g4K0Q5VmJuUjFLeEIwbWV6bHJxUlZtUm55UjdV?=
 =?utf-8?B?bDJ0VnN5a1Fsdi80bDI4UE5rVmx4UHVtQm9zd2hxMjYrelpMczBPd0E1djd6?=
 =?utf-8?B?T09oZVd3NjFSbjNCSWFXaDBSUi9xdlhTcUNjbitsdHlNcE80VlJpQUZPOTBx?=
 =?utf-8?B?ZnhoRHF0S3E4b2hqQUZpenpNRDQ3cFJzYVBSM1Evbjh3QnU1aUwxUnVpSnky?=
 =?utf-8?B?RzdRbUQwOHFpQWxaRkVpZzBLUlhxTFZSL0tCcFFCMWRSUmNFSm1zekxmakNp?=
 =?utf-8?B?WjFkOTEwVVY2WTVGNHcva1JEcHVvOHNvWDMvYlhsSCtBNGI0eERaWnJDVmw5?=
 =?utf-8?B?Y1dLYkYzL2RnVTd2UWdNT2hGYm9Ocjg3Qy95UUF0TFR1UXdhSVNPVXBmQkFZ?=
 =?utf-8?B?VUxrYkJMTVl6cXhqWDJTUUtEekExbThDUTFlK1lxVFF1ZVpZMXdPdkt2bWFI?=
 =?utf-8?B?QTlDcHphQnVFeUZ1OVVpWVozbDAvbGN6T24wdVdXcFJkSUFHNlN4NlhiR2RN?=
 =?utf-8?B?OUVhUEJsQUdTNXJMQnNtZ0hiWnJtclVFRG54TnllQUpONGNaOU9YZXBwSkdC?=
 =?utf-8?B?Q2RPWkYycm8vN0trTmMyQ20zUjhVY3ZrZVpMOFVyUDlGUWx5cEdLNXhRUGZo?=
 =?utf-8?B?M0ZJZHhhMndwcDRSMjBaWll5NDdUM3hMT3c1alArYkI5cG1xUmVHSjVnQ3k4?=
 =?utf-8?B?Mno1bkhlTmNIVkpTaVBCSi9oYzZsQlFaM0hBL3VabmI4VnBoQUNjb214bnFl?=
 =?utf-8?B?UUpqMTRLSUZ3NUlSWkVFTTVYdk5RSlhmbE4yUzNwbXlCUitSOG9aTmNSOXRU?=
 =?utf-8?B?L2FxdVVSb3NBODA1ajVLOUk4QTEwRVhYK1FUcTNsY1dYK2xmRzRJRUlGd1lq?=
 =?utf-8?Q?v4liM1Y/mXo0nkfc4g/BQ3TpC5LyoQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 03:49:46.9713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3822a4-5849-4192-edd8-08dd3517a7b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_194953_647841_7FADF4F2 
X-CRM114-Status: GOOD (  18.07  )
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

nvmet_alloc_ctr() only takes nvmet_alloc_ctrl_args. nvmet_alloc_ctrl
doesn't have nvmet_req argumrnt. In nvmet_alloc_ctrl nvmet_req is
needed when setting up authentication capabilities since call to
nvmet_setup_auth() requires nvmet_req argument which later uses req->sq
to determnine if tls is enabled or not.

That leads to following compliation errors:-

target/fabrics-cmd.c: In function ‘nvmet_execute_admin_connect’:
target/fabrics-cmd.c:318:35: error: too few arguments to function ‘nvmet_connect_result’
      |                       ^~~~~~~~~~~
target/fabrics-cmd.c:237:12: note: declared here
  237 | static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
      |            ^~~~~~~~~~~~~~~~~~~~
make[4]: *** [/mnt/data/nvme/scripts/Makefile.build:194: target/fabrics-cmd.o] Error 1
make[4]: *** Waiting for unfinished jobs....
target/core.c: In function ‘nvmet_alloc_ctrl’:
target/core.c:1527:37: error: ‘struct nvmet_alloc_ctrl_args’ has no member named ‘req’
 1527 |         struct nvmet_req *req = args->req;
      |                                     ^~
target/core.c:1635:25: error: too few arguments to function ‘nvmet_setup_auth’
 1635 |         dhchap_status = nvmet_setup_auth(ctrl);
      |                         ^~~~~~~~~~~~~~~~
In file included from target/trace.h:19,
                 from target/core.c:16:
target/nvmet.h:879:4: note: declared here
  879 | u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
      |    ^~~~~~~~~~~~~~~~
target/core.c:1654:17: error: too few arguments to function ‘nvmet_has_auth’
 1654 |                 nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
      |                 ^~~~~~~~~~~~~~
  889 | static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
      |                    ^~~~~~~~~~~~~~
target/core.c:1527:27: warning: unused variable ‘req’ [-Wunused-variable]
 1527 |         struct nvmet_req *req = args->req;
      |                           ^~~

Fix these errors with addition of the nvmet_req *req parameter to
nvmet_alloc_ctrl(), new prototype :-

struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args,
				    struct nvmet_req *req);

When nvmet_alloc_ctrl() is called from nvmet_execute_admin_connect() use
nvmet_execute_admin_connect()'s function parameter nvmet_req *req as
a second argument to nvmet_alloc_ctrl() and when nvmet_alloc_ctrl() is
called from nvmet_pci_epf_create_ctrl() pass NULL as a second argument
since as of now we don't have a way to know if pci epf needs nvme target
authentication.

Also, fix the nvmet_has_auth() and nvmet_setup_auth() calls from function
nvmet_alloc_ctrl() by adding the nvmet_req *req argument. Fix the
nvmet_connect_result() call by adding the nvmet_req *req argument. Also,
remove the local varible nvmet_req and arg->req assignment since there
is no nvmet_req *req present in the struct nvmet_alloc_ctrl_args.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/core.c        | 8 ++++----
 drivers/nvme/target/fabrics-cmd.c | 4 ++--
 drivers/nvme/target/nvmet.h       | 6 +++++-
 drivers/nvme/target/pci-epf.c     | 2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ef424f7e0ed6..d642d0f40b0a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1522,9 +1522,9 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 	ctrl->ops->delete_ctrl(ctrl);
 }
 
-struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args,
+				    struct nvmet_req *req)
 {
-	struct nvmet_req *req = args->req;
 	struct nvmet_subsys *subsys;
 	struct nvmet_ctrl *ctrl;
 	u32 kato = args->kato;
@@ -1632,7 +1632,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (args->hostid)
 		uuid_copy(&ctrl->hostid, args->hostid);
 
-	dhchap_status = nvmet_setup_auth(ctrl);
+	dhchap_status = nvmet_setup_auth(ctrl, req);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
@@ -1651,7 +1651,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
 		ctrl->pi_support ? " T10-PI is enabled" : "",
-		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
+		nvmet_has_auth(ctrl, req) ? " with DH-HMAC-CHAP" : "");
 
 	return ctrl;
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d1e03c120893..3b3af19f8aaf 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -305,7 +305,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	args.hostid = &d->hostid;
 	args.kato = c->kato;
 
-	ctrl = nvmet_alloc_ctrl(&args);
+	ctrl = nvmet_alloc_ctrl(&args, req);
 	if (!ctrl)
 		goto out;
 
@@ -315,7 +315,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	args.result = cpu_to_le32(nvmet_connect_result(ctrl));
+	args.result = cpu_to_le32(nvmet_connect_result(ctrl, req));
 out:
 	kfree(d);
 complete:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 845af16561ab..3dcc01da1abe 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -594,7 +594,8 @@ struct nvmet_alloc_ctrl_args {
 	u16			status;
 };
 
-struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args,
+				    struct nvmet_req *req);
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
 				       struct nvmet_req *req);
@@ -888,6 +889,9 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
 static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
+	if (!req)
+		return false;
+
 	return ctrl->host_key != NULL && !nvmet_queue_tls_keyid(req->sq);
 }
 int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index ac30b42cc622..fe7053809308 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2013,7 +2013,7 @@ static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
 	args.hostnqn = hostnqn;
 	args.ops = &nvmet_pci_epf_fabrics_ops;
 
-	ctrl->tctrl = nvmet_alloc_ctrl(&args);
+	ctrl->tctrl = nvmet_alloc_ctrl(&args, NULL);
 	if (!ctrl->tctrl) {
 		dev_err(ctrl->dev, "Failed to create target controller\n");
 		ret = -ENOMEM;
-- 
2.40.0


