Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366B9D35165
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8b5YjJg4rmj8LckcZi9uAyJ0W6yiVVniN0kNGLUyW6c=; b=d6mN3MfEEam0pfL3eyvWQrf7W4
	Yta/rrDj3QN2/7/fQumqsqHP2qeye9G5zdzyn3DG1QrYsM0X9LU3wcLOqvEPEStSFioB/jhtciBiH
	i/GDrYSHBcsMqPxvIdwWeRgYdK0DhvooCsue1ESEbyDt8OREOp1MLA4B9k+Rv5yO/cAf+3OTpBw6n
	EHGfXUM0e+ImDoOv8q0wHUvTDm9l+GLOee6g3nBcFRNKRR2qrXV5ICL8EGPy1/gLPau3mGUikJi/A
	/aVEk5aF23nolCea/5VW/sQ4ga6NPH8yHuCSKw7/rMDnq1P8ZvD6a8aLDSXU+UnrJXPBuM+czGzNJ
	TD/jIBbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7yH7-0000000FiMS-2Hxz;
	Wed, 01 Apr 2026 16:18:37 +0000
Received: from mail-westusazon11012016.outbound.protection.outlook.com ([52.101.43.16] helo=SJ2PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7yH5-0000000FiM7-071o
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 16:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6XUfKEA9xnuSMdsc2+NUOxlfVF2B0iarCUV6LaFdEseo3jldutIDZL48Vi2VS8WRc9epd/FAF2ar+ETlbDiq77V8X39YJlXqdkaXsf2vZxeXDuuC7hhjGtTrFk/blfSuBXastdLQ7SNoxNSH3erXT9UAXZAH5qIis4NgN3x/pB2d5PNlSVHV6jDsrhfbWsLozahrcssDI0dfI7Xx1a82zw0hXTgxE6gIXZVs5+KMuoJzqthZ0IViGpPAOVnVwEscJYMiG1a8O0aXfh0sxBhWvaz5grGV6LCIZVnGfMyn/pZyjimJse1j72FZaa4ktQAHLro3LPdzGSTk3VNjSu6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b5YjJg4rmj8LckcZi9uAyJ0W6yiVVniN0kNGLUyW6c=;
 b=gsVvt3ilGsR5S+jXV83qfPuQVxDJtkYNkHvvGIpj6p4Q2zLb5Ct8z+x67Gjh9j11EwEh6Iy3D6hTiRP/nImLZSyWMxpwOjS+bOcDlOnRtdte8XGX3znATTZq3FpJIiDPETRx4nKV8ujf0wKurByRj9cFmCWnsX/lN6bkdhoUHkgPPl2rVPiX5UfEo407nbnwR4rO52M12IuyKKt+wP+D1tNymX/HfE8jS8ZjTKXenfZvLEci+3SD8kSXBE0NrLw29LBuRWvNzGEpBuWBvoBDwyR+pZ2EAzntlmt/IwK3qq6plt+ddQt7RMcsuQ76RXbeCxYV0NzqC4p2nQzDb7DVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b5YjJg4rmj8LckcZi9uAyJ0W6yiVVniN0kNGLUyW6c=;
 b=RcKCpjdxdt6KSSmHzNJS+VPdI3kzEyxi89hSUG6yz8xjMsNrWTEcbQQyzEB/NKec/wOwaEE48XGgL4jd05SRqthhuf6nUIYNLZTw8WY2HVR0HNxMxeifJmy7wjQ0rkDAcdlStPsq+4exThYKKokmCZmENtKXbdeyAoct+J9mXUAYw0Bko9HKR5gNNNBrzrMiUywd7Y2Gv5HkPuYnFA7wcm+H65fGpfNqoMPlOKhrdLnA2c1QXreWQ/xf933qc3yBwN5o3+ie6Eb6CnNhffCrteZFEdJ+GJIeuiI2VnGtUqdMRzAsZ2BLJN80KyrIQU9pi3XqGREtDV5ZWDMiHdBv2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 16:18:29 +0000
Received: from CH2PR12MB9517.namprd12.prod.outlook.com
 ([fe80::2be8:2dfc:4d86:cfd3]) by CH2PR12MB9517.namprd12.prod.outlook.com
 ([fe80::2be8:2dfc:4d86:cfd3%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 16:18:29 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 smalin@nvidia.com, linux-kernel@vger.kernel.org, Max Gurtovoy
 <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] nvmet: introduce new mdts configuration entry
In-Reply-To: <20260401141035.GE21703@lst.de>
References: <20260401101355.163294-1-aaptel@nvidia.com>
 <20260401141035.GE21703@lst.de>
Date: Wed, 01 Apr 2026 19:18:25 +0300
Message-ID: <253ikaa1woe.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To CH2PR12MB9517.namprd12.prod.outlook.com
 (2603:10b6:610:27f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9517:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: a42b2318-f059-4ac7-d183-08de900a4f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Dh6Q2kT98gyfG8T2XhQIwCdQDtlgh5ed7BBo/ZHQvRXkrux6SbPI76AOww3BtAjy/xmunwZ0Rs0ZU9hSvuK+i79il2ig3cdD8L53XF9/EtAUrZxhsEGGbz/G0AjpVU6M2w/EYMWxq+GJFAsjTtSl07NU8Z0xHOGrCEuZnjPMNm7RdwLCxbIS+FKyWz+tgiu8xYsKRr587HmyFquBd9NCAtpsxKcSeUTAow6i2Xbov2m7hmdKTBKBxhmjWOIkwH+OyDEXc7XqtSC9/mKsmCfF94rx5UNKxmKZkV/J56iHTAi581qr3oItlaeRW9sYkDsFQ9Zrn8/COosdJ3dOE1ETBrxravL3PIVIdcYMUEok/w6rg5B9ZfORve79DYikgLMmtPNwzlBEG7l2qK2rxU/u8aO3/JfettHiWDLuNtItgQ9Qo2AGf48QXwZUgVQRePSDkHu6sWDDgYe95Z4a5IDXQfgazmSkiMAIx5eC37sfIjC/rRoQnZyntwsWz40sz8pp74+dpYea8M1sMYS+pKLWQLKfClG4QSPP4XWGeB7y4MzeuJCRAxg0qFUxa7xusfw2GDnoNToyWyq99iz0sRkOYmByh07UthAk+h8vhLWvpbE9igVvZv2VxmLWtnKoKSUfnUnZM36cSE0NakmnLjrrBncmuU4m2BMROxQCCzAediQuUmS9m48nVoOqzdGgVewFak7rVpAWnY7eAn0Cd9QrjN22Zx4Tw7/XPEVyjaiHSpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB9517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9W8NINglsGjx/ZuWoLsvYpz6nrnxajPkv2AHQ2wgsSnwzclZNhfEtcB4+2Fs?=
 =?us-ascii?Q?fZ6OC7s0Rb6vbZxYJFg7LEUOT2NB34VXV+xprO+O44HqOOFfO/Q76nK9qsg8?=
 =?us-ascii?Q?XIe9wdkG52yWPf4/hnZFWe8SShMszixpFyE6YZ3SMM4PHNoEkHFU5JwVOLiv?=
 =?us-ascii?Q?LywAflSKJtYYeOPO+DUTmFjhyKFS3HX7UkUABjtNfLVRATzBRZiSW5Ys+X3n?=
 =?us-ascii?Q?93O6l8pw6uRg7y/ZDfRpMzPlgfhXyhhmXZirx3S1K9mA64OR1jlIiGl8k0ZP?=
 =?us-ascii?Q?0I2rRvIQWERlHLuN6RrfqVqVwCfAatfm1AzSFMdbC777qPofyWXbkftEOYh9?=
 =?us-ascii?Q?xbOyagCXJRjyFqAwkVB49uwD1gBK4IgyUkSJpNJqgiTbykL6CZiaAuhCbXhh?=
 =?us-ascii?Q?VamOwBvD+8Y8YNmT3/Fh8e3tAYfI66nVuOZrYCJj6SQRPPJjYyEWfPtmON0Z?=
 =?us-ascii?Q?zteytGyTJn/hloiTBjvhh43jRw7aEbf2jd5lNEQqVkRoRZAlxutQTMwDszl5?=
 =?us-ascii?Q?M83rhv2ZwzBq/QUvGlwJUWIvwW5uGd8Hvjy4/igaKwWDeq/QtWxD8q6nNqFT?=
 =?us-ascii?Q?/a8O5FnuoH3OWEj4zZ0IeQURI4NpvHO7cII6d/LTit7O41vfQIBUWjSOXWrU?=
 =?us-ascii?Q?yhU6b92QFNJDYjsCEHDK906wAiuHS0nNp+Y9EdV/xZvqarM0J3priUw9ZFGu?=
 =?us-ascii?Q?3wL4fRFhefx3kbHjGbUkYIhuFNt198K9X8PvbC1WhxSPNlSA2RZHkxNEtFf7?=
 =?us-ascii?Q?sJx0/uKnK1ebbXtPhQrNJTiTlUMbPrA0T5mj2Bl2Vd0uoSjcWRZoEQP4af5P?=
 =?us-ascii?Q?lQpcjsnZ7f20/DWyU5wCthJqTFZ7HL4IZe4xivImAErsS+5Ko0xarSoC07Ai?=
 =?us-ascii?Q?tfHBGKolxSp8j1eNDwoksu72OHOdfRlgcJZhG9pYdBLosn0g2KvdaDa3MckZ?=
 =?us-ascii?Q?sdJQu/NEzTONZ3H8eLA1EYCSR/Q6BDktpXHjv01uyyr8rRKljpaUp2iUXpom?=
 =?us-ascii?Q?XNRubi/iZv3VeW79YCeJH4JH63O2fHFYX8718ayGX47eKy8O0xT2OOE5ASS+?=
 =?us-ascii?Q?LeISvlYQtVVxCbXPYvQWVjn2E2dAqSvTUKKKGbVvKfaeQwsvpeDHnU8yCIGh?=
 =?us-ascii?Q?Cp5t3zSEVArvFyp046nAA5TKED0kAI7twUoc5pXwtQI5HfkrXvKoXhV0nWiz?=
 =?us-ascii?Q?qvnBob0CoUAk6XNJyE/5cvUOrmIAakR/BOQbmwKjk1X40cFW9X/ImP0/4pBl?=
 =?us-ascii?Q?tBT7+nIkhuELvFx61SrhJYdkCuKf2DjNufRpstzVCJMqI4a2gX4oqn7aMLph?=
 =?us-ascii?Q?zFmJ2rIL7fSGkByz6kPjciU1L4XkriKj+uYo6d/h3Xzth2u5xRumOnvmUaKb?=
 =?us-ascii?Q?wPCMNj2BPBKwbVUumCYZMsuHT4hb+EQ+opx5US/wpNbg8bLciq8kCGyLELy+?=
 =?us-ascii?Q?IBtWqVgdgl6Hbt3F4UvLE+5505N57Wx7Q7ktv9o/s6dJz5z+HqV377lyzytG?=
 =?us-ascii?Q?626zOBw045CIrqX/RVvNQDdxcfepB74QRazPdcIPXnoNfsrGqYEIYy+FZ2CZ?=
 =?us-ascii?Q?fMGPc8A52nS0qwbT6KEYRrj2ish4ziQcLr+w1Z3E8E6uRK3rpkom/7N6KJKU?=
 =?us-ascii?Q?JTGneI5vOIPQ6y/VvAAuDP++L4xWjqsLN5Ywdifvnfh237gHLAtrauU7ccfW?=
 =?us-ascii?Q?KvDy9UYQZJJvrOIK8O0DTVM7Bnk/DAhxDEjHRF1aGYxiXIu8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42b2318-f059-4ac7-d183-08de900a4f9c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 16:18:29.4730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMb3nBeXKuPacT4fdNxn8poV8RELIIVtgYWnl0qPnvV6HfpL7oBJqOagZrcafgx2UjHlCJBLVAyGhuHql8VNZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_091835_086168_44FB60CC 
X-CRM114-Status: UNSURE (   5.41  )
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

Christoph Hellwig <hch@lst.de> writes:
> The ZASL calculation in zns.c also needs to take this limit into account.
> So maybe add a helper to calculate it?

Ok I will make an inline helper in nvmet.h and use it in both places.

Thanks

