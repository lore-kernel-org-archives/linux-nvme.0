Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA795C369A1
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 10:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8TvsJx9TiFwmDMKaPJ5Ok/tqa+BCGhNa1Ouuawpp7Q=; b=milyFXpTjs3VrlXMuhWE2wd2mS
	1uyksvRlSERKfM94wEa1QMuv3kRPFCkq8+yTuWhsW52+zLw4cllZAViI4akZPqWI99uTu9rFjnUuL
	RSBqMVCflnZMYrfXpwEnnKK5fiAtY78CGl2FdQqa+gFazKVNQGBJL44rlF/BLLTaQtTy7eDrSyQHs
	egbkcBnUV7EOC2zyZAUkMpQ01xJ9aq2872MLZnk2H/gSrv8FuFolbIxdm4+y7J0oKW0uwbfLE3uyM
	2WGFou+c+yiNLdBL6ce25nNPTin9yW8O2xULWP7KZ05MAV5XBpAOIUJWjpztEqKrml3D5cVekogdc
	CRBbwHYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0e2d-0000000BMTi-0toS;
	Fri, 04 Apr 2025 10:12:51 +0000
Received: from mail-dm6nam12on2060c.outbound.protection.outlook.com ([2a01:111:f403:2417::60c] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0e2a-0000000BMT2-1w44
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 10:12:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdYU6Pg6o5ueEGWdtrl/k3dg6P6Iw4hBezLe34SbsllCJJbnwJPnA4/ysnwGtcPqsQ8hU/nw9sPx8361607oQiA5+hMjbA3+KhfMRH3iZUGP0as8X/ANqKcmaNza9JIaFxitsuAebAgxiNllskRNIhuw5N8jFjYRyGIdjvybikVutl44E/CGVvFVBrTJ8/sluYKI7mESB12R/C4/FjPuTcYwDJP+OYLLIZBhZn2YHL1k+gpc9arwWNJLp1ZWRe0pDf7mCk0JDsApKtqcsss3cnA515x11TXrG332P9SurE5UGpGLubCSYzFPfTcaK9D+RtzaOxJLLpVBRq+3sFLoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8TvsJx9TiFwmDMKaPJ5Ok/tqa+BCGhNa1Ouuawpp7Q=;
 b=L4l/tf8tlohGGdUBGZxUnVImGCa1+EXNJj+cEa+oP5ocQTQ+Hy4xrzmdi1GlQD7qBcRNK3FGD3PAp96Hx4kcifgOlAYb1+dtjhMeS1eRa7BdaWRI7XpoiUrfiyZXhDWRhGZ0wCeutIhwFXYYuSsnB4LaEPTRjZfwyo/DoeJUbxfvb/Oug0XxNsmnLfaA+ZN5mNL4NHBIaZUCtKaXX1krwdfNO5ZjN/YfbMSNS9JyeEJwz0Hioi2e1g5SrmPwLcaGbl1nMvE5uGCkRGlOKQsgZyjwVWZA/cgcgx4t8ESSwJfRL2I5bDd9VYSpMOTfynSNUg4uclXSAeqgpDEq5bohjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8TvsJx9TiFwmDMKaPJ5Ok/tqa+BCGhNa1Ouuawpp7Q=;
 b=ktG/eGSwJmDw+6l+/oVZqxe7vU5YjIO0pRMq4BcdKOehuiFVs6eFP1kJlUOW3dIKxeFwyWo6fohXOZRLvaGhSAOkEfxBsEXcCLDHywJexdKfz3g56olbpTv4GCKXnkhqtO886/hdwcsRFY60i9NTWJvuEHAPNpJ0PL0kyJd9JOFLGQ4a0wCZWIGtrTOqq4gs5EhEqeGSpTo6nv8B7xPQbyFz3UA4atglBwhm4cg1yQbkNsnCSvLTO3M8h/Zs9oRcJ2KVhsFXyJO7K9wmYq97ASG+Y98gUqY79W2J41UwaucHtILUmtlGAvzA9k3P/NZiKjueHIISL8dO4dL6my4F/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 10:12:39 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8606.027; Fri, 4 Apr 2025
 10:12:38 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Simon Horman <horms@kernel.org>, kuba@kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me,
 hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
 davem@davemloft.net, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 tariqt@nvidia.com
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
In-Reply-To: <20250403044320.GA22803@lst.de>
References: <20250303095304.1534-1-aaptel@nvidia.com>
 <20250303095304.1534-16-aaptel@nvidia.com>
 <20250304174510.GI3666230@kernel.org> <253jz8cyqst.fsf@nvidia.com>
 <20250403044320.GA22803@lst.de>
Date: Fri, 04 Apr 2025 13:12:35 +0300
Message-ID: <253h634z14c.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: c53afb40-ea03-437c-f934-08dd73613a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+8KKebxInSjNG+DCX9ysReZjcutV1Lohd7he9f4iV9rNyKHNGewUnwCWQeC3?=
 =?us-ascii?Q?jxE9jDmzaWA2P0x5VNFDBrjRr6ind9gMxS/Ar5IFVXKK66elj4lHgQcQA/Cx?=
 =?us-ascii?Q?7zntboPZztr03NVXN8Z0mUcdGKXhU6WClXCj1EdZsGi3X0MUbtH7qZONhXsu?=
 =?us-ascii?Q?dkR90gg4Yy18u6B+IAKK9ZjzidgDVvYcCzhqW12dwl1Qp68/iRk4rEOTaEtW?=
 =?us-ascii?Q?s4ECnfpljz5P8NE+pACQqCREItzlnX9BO15z1juTIJfceHSsD9u8tz+sJUjL?=
 =?us-ascii?Q?s8+VyKPtXBppO5JRlH+v3OISayoUGT5I8aL+dTTDcFfmbaHbKXYoONjo+1hR?=
 =?us-ascii?Q?DtL4O78bEoxt/DR+vVBLGo/D4uGml3N02LnKJe2WFXrXkagzHZx0crOrSf4K?=
 =?us-ascii?Q?QXNjY/pJhbunXmeiEN6lwfu9ENcKzdrUEsjVwrKcbiLZ85iOTfuPoSBTo1wz?=
 =?us-ascii?Q?xuE0xOGtLYFnicgzD+bA9BvX6hitGjECdzrKj5TTJtGXhOVzGbYDH006hQGj?=
 =?us-ascii?Q?RTaw2+6Dee0G9rnvU2Wh2gHLokwQItaoq/Z/JJdHTJ+tcKqhKaV/P5NZ6+wu?=
 =?us-ascii?Q?O90WURkJLs3bJI3oOcBdAQmplKfiNlsrOBYtLqQWH/ygsxvWaK86IZJkPduf?=
 =?us-ascii?Q?pNE46ku3BH1kMfZkSsdgHGTBAdGODhKi94K26rVEfF1dMVsDevwl6fj4XmYl?=
 =?us-ascii?Q?tI5xe/9FTiVT95gDZtnyWp25/Oglkku4l7pLQhaXqHIl1L2kHIOHP+69NGQO?=
 =?us-ascii?Q?EbAJKDYNBUU5LDIRsegc06gVAzfB2GhHQriq9u2h1AsFigW1P0H/CZmYj8tf?=
 =?us-ascii?Q?DuFeV4DUXtvOZt9hhsP1FGkkCTws7M4F5W7gK8ZeQGp0SO46n8pKod2/+4sD?=
 =?us-ascii?Q?50lGoQNsOY9FmiIMrhOVdckWhifGZ8lvMJWPf8TkLz8u+gQwk9uWjRzrJnjq?=
 =?us-ascii?Q?15G1dJDFrPYnYRZH2GSPlT0PpPeEuTxV/hZscfGttutgKyu5VPPH6SLvoLNK?=
 =?us-ascii?Q?NPUGOWI2BYL4h3vBVCJj2RL7GieuhUMwDmnIUkr/sQsoFwUjgkJNz7NtBhoR?=
 =?us-ascii?Q?yFoO0A5XHKhhlfXYmimG5t/3WSVlR2TPRrR+k/yau5VxguNY6TzBD6mzOgqZ?=
 =?us-ascii?Q?AWIVG5dGIoO1aV1t9tEOiesSTMHEU6+Y8NhU00qajZwGeP9x6poRWlk/Je3R?=
 =?us-ascii?Q?w4xOQZZcCg2crv0xXouVHxeG3sg7CnOYJyYPQIVCgbYvXkTtoacZjwUTcjqu?=
 =?us-ascii?Q?L6dF7OvpOEjNXcYx75Ls7/AktZpnw/bfzIPbR+X4g+uNYZfXMbQWQn2A0PV9?=
 =?us-ascii?Q?d4WY6SmImFivMonO8XIsNxa+6R3dlcH2TI6XAJX0Skf9htGawtyZE7hOAz4K?=
 =?us-ascii?Q?bNUqCoAPpNmCQfFxaQ33XhjSgur5SNWGbdUPMgUYWLqWjS3KagTJyP0k0uhO?=
 =?us-ascii?Q?LHUlqtWzQGE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zb3c+v9l0r2xOcg3GVa1diLEXlbVHyFUTcbfaiNES86Tl40cxIOF/OxZTYdE?=
 =?us-ascii?Q?7xHRe1mJBkHXsXx6RoY1vSBB8bs5TPaWw51PVvFiMD3IncFNot6mKftsdVxT?=
 =?us-ascii?Q?i1lRqavMkWksO+ZX7EAGHy+3tLbe6Qo8peJDyB/24r5J/vFRFHsogCUyFgXq?=
 =?us-ascii?Q?zx6vfv7G+77nacLvrFZ++n/EuJaYr3yRxq0hoO4FFj4M7PkWc+FuEyHHWowP?=
 =?us-ascii?Q?2Wcafthxj+CzmtzB7lemxQumpvr33aQ2zJ/HxJsZaJaH8EpOVL6oXV88oUve?=
 =?us-ascii?Q?S5+jqSFCglRyTiP+eGkSxaqRClHpqpX2kq7xVKh2j3XrzHqoag3yTj0NE+JY?=
 =?us-ascii?Q?5kRWLZHnLrIBZSfMIcPVV+yOl5105tgz+KIsEBeNRYpDZeAcf0RU0UrBS0MR?=
 =?us-ascii?Q?o21rdOOyZjNhnnjzxoOESdPVK/ISyuCKEsp/6/fKn1mZk9NlUUfNxKaTjdpy?=
 =?us-ascii?Q?YBqe0xQ/zLK4bZet3rIShfrCkmLC1O6Ozv3ZruxveAttSyxH1OwAerG2q+w/?=
 =?us-ascii?Q?NkMbXveeUYRGxl3RarsID1Q+YKrVRmVmG82On2ms0BI7FNao7WEwnV5h9yNl?=
 =?us-ascii?Q?JNEw/Sty8aJYlW9E9xfXh4Xtkh72cta5+0h12kZlV4YFAmcujXBh34wd22eR?=
 =?us-ascii?Q?jockr3Yl5uNRanO1OqGsAmevizAVbiAlJwoX/YNyf+Od6HEEEHzpc30SDIkf?=
 =?us-ascii?Q?0+j5yXkrv1WAzYXDcv/7/bjRG3fa6zy2CM8chTwXcx+2XD1RYWzVxO9hjCSh?=
 =?us-ascii?Q?dLPr0ZjIspVfBgJz3MLJwHBm6B4K3mGmxNB5x6jMeoPtTS3RM+OLfQ48J55q?=
 =?us-ascii?Q?sKnPQ3LGDRefochLkY1YkAazv67iV0DhKoEeD6P1UZ6rzcx1uqfkms3wN+kB?=
 =?us-ascii?Q?79eCbmBAeVIjkJ89a1sNsiH3O+tm7FYVqp76CvWnKTRnNkcnsLuaECquYbY1?=
 =?us-ascii?Q?kYf/G6k+WlemtB6KGSuwpCYJEqTDzz3Mil7hTasIBrjpRguEgGiCRg9zxYzK?=
 =?us-ascii?Q?pI4z3puZvYMRP6/V6kJOvfVbCXtlX3Da7DU4hBXlihgE4fpg5feRp6PIVho7?=
 =?us-ascii?Q?/NDpE6v6IOvKS3qgz/bwPRBwz4u3NSjYAdZqHR5eALQN2ujUX9tFypwBbmxP?=
 =?us-ascii?Q?EHvl6IxU9Yv1h6dbehq6/nS9P0ykmtfEhrN1/r+uklODBqVRHWTaShGjX8Vy?=
 =?us-ascii?Q?215xBq0fLMTiTIypBZQ87HUHzDjhhpL8EtKWLDwkYlrhrqUZRmGD+hUPbY0O?=
 =?us-ascii?Q?TnRnlFxj4NS0RyCLDjnzdfovTARitf4KB1IT4a+z47VgUm7sY1+t6XEOZ71C?=
 =?us-ascii?Q?+3iLfe0TYqdhTwUyDWR6Sxb5xRN5qt0J97kP/1PvGxV9tfsSoEqqPbHt54XW?=
 =?us-ascii?Q?pKMCWWUUd4oUqVU4Au97s34bz8fmhMXJdgJTUhGLtszPj4YVjpYhzkz31oKr?=
 =?us-ascii?Q?GTaz59JJdJT70tjH1DWllr9IvXoGwLu0jvsgH9mrb5e1ydM0fH1AhirX2d+8?=
 =?us-ascii?Q?PI2S1esY4QXF/HWNUQelLSKifkt9gK/Ba/MX4hVeJLa/fca9ziPZfuFFLG1P?=
 =?us-ascii?Q?jLWX7TL7XKCSX2aWLmwcvYApwGfYME2eRzNh9d+I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53afb40-ea03-437c-f934-08dd73613a83
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 10:12:38.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FD33ujnXb1k1rnI70yGBs4KUzUQJWdGeEclAbnoGeAcjwM4Jq+wYiCaJi8SFZLvFzkOMgIxE3WYt1QbtDds7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_031248_530872_FD25CB71 
X-CRM114-Status: UNSURE (   6.59  )
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

> Btw, just as a reminder nvme code has to go through the nvme tree, and
> there is absolutely no consesnsus on this feature yet.

The series was acked by Sagi, and the discussion with Jakub is about the
CI (which was just resolved from our side), not about the feature.

Can you please help us to understand the concerns?

