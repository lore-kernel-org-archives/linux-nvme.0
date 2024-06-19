Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78770C2BA15
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6hBwj5wQBtNNO1HXWOPx85aWbwptrLstH5ewrovVMCE=; b=MQDxqKvca8weO/PjJfNYic+UWA
	wYB7Z36mdBJUD6IGgnRsNjG5FkFvZzVExaywkJmfJCMsLFcqww/rbgvl8imO9t2nhqtAup9SNTQWJ
	8yqCobTCNva8XN9mmvM+a3h4n0Q/Iq2zsdBJVWayuyjytec3Eo5uFKR890hg/oLD7K8XTuQTda3s9
	LmU7yxvApG71eLa7TKVDtInh6xXCWsa3cUkmzVPCfQd1XsiERO9PdljNMSy4m/qBF7fNMFfjx7/id
	INyUCoWz1GdQWX/WyvAN0YDnNY+bD3e7HrleaJIKbQIy8UOWz1Ib9vp1ZcZolwyT/zqHurIPpeHhB
	bOdjczqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJroa-00000000coW-08oi;
	Wed, 19 Jun 2024 09:41:16 +0000
Received: from mail-bn8nam04on20623.outbound.protection.outlook.com ([2a01:111:f403:2408::623] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJroV-00000000cno-1dy9
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 09:41:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcpzqVO4f4JxijA0eL6WshsS0CkVJDAOmZzBoKbr6373yTJL84caaSrkKhW2VsWchAWDPZjIaBavTpXv3w+dpmceucxJSsC4qn+cicz+3Bv9/HSGyV8j4DybZcKSnp6nT75Z5swAZtB4FiBhR0fwOPln5tozWTjI8xR/uEez5o15OcImwrJdFqGY6Q0h4s3q5MwSN6K63eOOrjZVhvNQCXISzuX/0kbVEOzG+TBrwze4ZmbRRMjKdP3xPfVY9+Uyb3ieD+izoCG/DEW+GUtNT857Mu1CcKHVUtDDx1NcXDPYBGuwO0nzqmj4BEMrWB9V3UGymIdUYTtNTe2ss7EnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hBwj5wQBtNNO1HXWOPx85aWbwptrLstH5ewrovVMCE=;
 b=KT0DIVJxImwkkDVMXFuyMW+6dVq+TJMA+QD2AVy+Z5C6bInpWkfrtInAB3zV54yAFi27fU3tgYGHPgi9i0K1R+Yr7tnWwKuWtj0dftiu+89psjx5o4heRgpuxNDafyyE4cVc896uCBLJh2LvaK0Md5fuiRnW4THKp9KK9U8XnmI3TeP5jVN2Oy8WMVf9ue9EC6FBkgnwLSqW1SzEBcVVVg32ZbwaoU3AjNxlZfG7MiAIxnmFq9dN6Ft/r3etiFOfBE+TMNvMn1l2xK2iIkRKh9rsSSgvwP1kWIbHkrqct6YZYyiXL4EWLe0YqZO+NkvcO8ZPrGdCREhzBVidkBz8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hBwj5wQBtNNO1HXWOPx85aWbwptrLstH5ewrovVMCE=;
 b=Bw0p9Eh0O8TE3RboFkVhg3eniZ19+0GYoQR38wRnL45czPWCKIV3k8RLujgk65ZcEAi3GWEwEF3NXPb657DxICouwxv7LqHL1PF1dFN83HS81mDckTDDmyDibDWOUca8ftemONXJuPYaEYd9pexgJ1yEVvmzxX1+mGoZOpidV8iVo32dbFsqHUx+li6G/21eFPA/p4wVUWVm6rTpH/NeXh9w1qQUBws2F9q0GLY8arpWNBS0eNdhsES/DRke0VN2hmmj8HIeB39Y1mgoRDhbY+K6KVRPv72Dy3fqWF82MPkOMODcj1xfae/XFjBimxV948UzV+b6BiEyFvzxxhJ/gw==
Received: from BL1PR13CA0326.namprd13.prod.outlook.com (2603:10b6:208:2c1::31)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:26:17 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::99) by BL1PR13CA0326.outlook.office365.com
 (2603:10b6:208:2c1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 09:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:26:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 02:25:59 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 02:25:58 -0700
Date: Wed, 19 Jun 2024 12:25:55 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, <jgg@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-rdma@vger.kernel.org>,
	<chuck.lever@oracle.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<maorg@nvidia.com>, <yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>
Subject: Re: [PATCH 6/6] RDMA/IPoIB: remove the handling of last WQE reached
 event
Message-ID: <20240619092555.GN4025@unreal>
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-7-mgurtovoy@nvidia.com>
 <66d87932-eeb8-47eb-8c89-e1f10cee32d4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66d87932-eeb8-47eb-8c89-e1f10cee32d4@grimberg.me>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b315710-e9ca-42bf-6fea-08dc9041df24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l3xG1gt6H6lqp0+TjCLjWD3xCbrZgo/3Dm9TeUeo515XSrafpKB7NJTwe6/B?=
 =?us-ascii?Q?xNTvflfRJGjS74Int36YE72BZaptTUrUhntjFIn0/PuagdaJPUsuJjI5Rk/7?=
 =?us-ascii?Q?3SU8hh4Yjke8kkT02D8dDIrw/Ija2ZQkm6zawQcmzv2FHBcI/kaTIBGlc88h?=
 =?us-ascii?Q?fOfqlRln9kC2vJqbc65aghUdebU3kBAOGxsIpBIy1Qsj3Y7OjEWmIWuVAQjk?=
 =?us-ascii?Q?2ecfy2Sz8fTdgORKHDVisTYsWiHHIfTMEbI1UC/vCDzuOz/vbwocAWVWwTpj?=
 =?us-ascii?Q?8ZFRZbaFmrAMVDJ8pCudUlD6cdXVvxi9+2pID1MLjhSfM/oUJMI40vgkUm+4?=
 =?us-ascii?Q?gOyThr2jmqVQFXQXdhBj5gA1C8dCqvskHWHGP32Rl+1EXPlCYrj/+LIlWPIT?=
 =?us-ascii?Q?ykVAUi+EVI1WklMu+jDcWWNRW8MQ8kLAUoys7Mme9qk+w5p0LB5g0nX0VRZU?=
 =?us-ascii?Q?bInTwCRhaMky4pAxxjaQYv6WDLP9fA2RqroRDptXZsffF5B+ld66BCvXPGeO?=
 =?us-ascii?Q?VPMLRDAigpthsbd02cXbiwyqdEYIRVJvT2yvPFvxLswiHcVUxMfSda0iU650?=
 =?us-ascii?Q?oDE9bf+sE6JR0YA8k912C+GWxGnHRAYlxf/OtOTkb4v+v4yrGZLYDRiF38S8?=
 =?us-ascii?Q?OPlartyHHr3FWBz5OB1iDyUE9GW2919PBry9QP29mN3wjQcC8gcaY6/BbR7j?=
 =?us-ascii?Q?6ye6adjjTWGDmIkWZwp6z4Sj3QzrgeqCm+RFzNa34cWtktlucPztNizspx6w?=
 =?us-ascii?Q?+1fKgCWrSrC8PtNtihVFfKxJIAMAJyOXglKjFfL1oUZNC8U2V1HlfwYKEaOM?=
 =?us-ascii?Q?nvG6OS0i7F/1XDsIdZYTm4epuVKiSeOg+AmFdD09c85aildWCYjsbztBcZO6?=
 =?us-ascii?Q?I3Luir+tVWT0KCP1lC1YNA94eMSwOVmwIJaYFfb9GN+roKWgclUHj/WCV8ak?=
 =?us-ascii?Q?cbBSUbDyFGl1NLY6BqwF6gU+b8Ez1ncLJb4fnt1FWVmoi63cw33OUG3RmNsc?=
 =?us-ascii?Q?sx1GS6ZFroYbCNCxoa+XzF3oQEnLx77eCp9Uvj+UGB2DCw0k7drOwoHrc0Hb?=
 =?us-ascii?Q?Rp1++TAtOTAxGmsfbw9ZF77ZtgzcyuRYoe4+IDo7/eX+l7JpQvhg0nM0jplE?=
 =?us-ascii?Q?6HjNBMZ993lOcYdT4GaDKZ+aSUsqYZoAxz9d7hJzg9QXJaiJ5QBNvDj1XeRA?=
 =?us-ascii?Q?JerGdZvL3oZfMCjfyF/oJMrI5FS9YlvzWBpz328/Cl+Hob79v7p7Boyioxcm?=
 =?us-ascii?Q?KzecPlrvxLfD2kbnETT933aABmfodBTGiuCLAB92ESAAc6W5Q8lpR3m7/1O+?=
 =?us-ascii?Q?bMqh/yCuEiU82wuCvpqeO5Cbjtmk9DafqNi4ptDdL67yFUmQxucITkqvQyFZ?=
 =?us-ascii?Q?ZYgOo1G0GWxLoElI6YJNwH2jyXZqZiMO99atrcqbIJ7p/WYI1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:26:16.8873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b315710-e9ca-42bf-6fea-08dc9041df24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_024111_543703_DE518D06 
X-CRM114-Status: GOOD (  10.52  )
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

On Wed, Jun 19, 2024 at 12:18:27PM +0300, Sagi Grimberg wrote:
> 
> 
> On 18/06/2024 3:10, Max Gurtovoy wrote:
> > This event is handled by the RDMA core layer.
> 
> I'm assuming that this patch is well tested?

Not yet.

Thanks

> Looks like a fairly involved change.
> 

