Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24A606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FrTl7FTn;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=mrobplXG;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=lbHFUsNe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4u550JZ1j75c4Te42ntR9XtgsH5LCHAVJES+hM1SLrU=; b=FrTl7FTnVWeLexxmXpoLioDG+z
	uhpLe3Z6wo01vE1FxphZKw1GcCZVQ1hngC88cVlwNEpXfRhPyq1CWmCeoI5YN40ff0xFbcpo8R8FR
	htBVeGhJ4gc3BcVzA1Cld9SAnPkHTXw/yrY3ABTVJlVKTNG6z9wz7hp6KCiLca1QENtubw9Wod1iO
	G0oQX5LrrwEEt1n2wDdP10XWdRgw+T8LqouI87AG4dQS6evPy5CI04vSLLq9G8SPgNoPjzJs3766Z
	JrloBENlJvW6uEIP7vYG3uWNWSfl+YIGilVaeTkBL8TzgXjtjXE2xcpMwPmqYmOqhbgkG6Di5MCkp
	lXv0sY3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ77x-00000009RAw-39YS;
	Tue, 20 Oct 2026 10:31:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ77v-00000009RAb-2bVp
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 10:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792492287; x=1824028287;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZDYXhfjjJYYeMfhQdUOZp1bVnNixRTutXNJseWa9+2Q=;
  b=mrobplXGL5DEoO31Ai1JNEdGYp3s+i00YSYjQsE4BBgujOkkxleejFj0
   RjxjZe/raRrqis8TctUKBd1S3+j/AhpdwJ+RvaqI52Nj4hfhnt4OBfFC/
   E3cw1yjLWQMUFoMCOn7kvWZaRjEgQFPCShpnBEokPkxrc40Qjw+j44Njg
   c4FhbG0C4SJipKvOPkWbsCq0o2330RzTv2Y6Vy08zj7B98E+HSCURgTnx
   xGM0cVuhN/OzI1vlx+7lQPiIdk0pF5a3SziuDN34E8yS3qktVqwjBxXQX
   uGJvrbqPrwqvFKvhWeJFc1or2qW53dlcCKdvN8xkEjzwuXIfJc86m/NjY
   w==;
X-CSE-ConnectionGUID: LoyEwKloSnu7T8TGPO0lGw==
X-CSE-MsgGUID: GLWBNqMeSCuay5svWtNprg==
X-IronPort-AV: E=Sophos;i="6.27,168,1786982400"; 
   d="scan'208";a="158431299"
Received: from mail-westusazon11012006.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.6])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2026 18:31:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrLiMM3GtgW3YDU4+Fn2vpSn+KjIGXXE0IPFdiuT5yExMMUMYK9WkUeG+GpBf7gFjmSCWijAH0m2rF5BpC+UE2TFyqH4rvZGGb6AN/gS4EVN1Lj3QOclnQhv6vkug/9C0jj9oNJqMlnXrNPCnf9xPp8bhuxDx72OLt+9Jk01f9zQDu5cRSk2GSE0wPTHvYVJWRjrDa2VzEgIdre07uLnsvhfVYgZj68kajfbX4y5+WYlCY/q3sFmffgenWLJODGh3Z7+633B8hau3FHBP6T4d6A8HQ0fwfy6SnjfJGrV1FZ2qlRD1L1LtD8D/9hBI6Pia3I1LL0wp00hG6kc/gYUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u550JZ1j75c4Te42ntR9XtgsH5LCHAVJES+hM1SLrU=;
 b=be6LAaOh+gzBscypfWDaHdbSZMq1QIR5D6oRa351hcKenQN/zaDU460bybc/uP+ddUDMX013EDhvdkbqvh5FTefFCBefeyHIdmdlI8DjKX950/MNrzmEH8kV3zy5/PGMFRunlMXhIhIW3sbCoJbiGK/4Ol5L2nQV/qtS9t8Wae663VnYQljGCR1xeo1e8VTvN7MK1rTGUjfqUQLmdiu1IiDNI+PEqVBfCegQAnTWGcIR7wL5EMKLW5snIQG+mDcrTNpfkKN2+SXumoHWZPr3EHnfF16n1BX1IXq8M4Bpvt/kTowcrBdDrHJ1Wr97v06iWt25fGSSbL85s5gdj9L67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u550JZ1j75c4Te42ntR9XtgsH5LCHAVJES+hM1SLrU=;
 b=lbHFUsNe3TFcHwY+E3vKGjh1SWhdQIJqkELW1Qid77OFxmxMkIjqawaNCH7qDMIa2RvypwaxIXl/L9HHRH7Uu9xPrvV4j+3wbT/M4o8fqaJW0WvWGo3nM4y9F7/BK8j7vRLtMB9n2R5iObeozQyGKTwbHeu4HixUQWzOvVbWy0Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB784716.namprd04.prod.outlook.com
 (2603:10b6:a03:2cf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:31:25 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 10:31:24 +0000
Date: Tue, 20 Oct 2026 19:31:18 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 1/4] nvme/rc: add zoned null_blk target helpers
Message-ID: <atdCWaPEmu_v2g5N@shinmob>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
 <20261014170046.2516-2-parri.andrea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014170046.2516-2-parri.andrea@gmail.com>
X-ClientProxiedBy: TYCP286CA0270.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB784716:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3af109-a709-40bc-e5f2-08df2e954aac
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sJrrjldujH2lYn5ssi6Jq4cFx83QxGxwoELKHEa0H8oT3PsIdII6vKkGRdK4VHN/7ZqDTS+Tz7Ux6qVhIp3nBZ8bsc/zvp2VzvNhe0vrhwISVUGRC3TEaqq3H5y1jQQnW5/RhIsbhp/7ifHO7yiuGdwEpv0baOc52+z7UXofWY1jhZlBxUcSqNWfC4S38VCn5C3oNdhpLco/2y3UQS1HUiB7qk8twWejFTrlD5NiXjJA2SKCK4CIBo0w9aVaV6DovzPmOWtyUwryZJwguxPMrZjxfxRvrLMnE+fwc7pSVLZTKiuX6J40UQ+xB5MTREwz7FImKsEVwrxQUYbJ6LCRLjv/ywokB9lqVUFl9LWxyqV8uKab2NyI1RUXmJPLlPW9a2gxQS1VTwyqURd95qAvDS9G8ABYKvlmY/3qCkgp7zSIixE9yZkILiKHVHiDU/bMetKtnY57CLdKVPzH/OOfQLHAl7xHAD5SZGqtgWalggNvTJDBZHkubfTSOuc4BDIH4Hx9iO8aVEH/865+HZvrMzqUrpCRlKv+IHvPEKqFRa8HHXtR5UVGyA+Divv6PfKP0MQyJ/g9K72nxpiUJjnokVr1f0Btos2MZ+XCidtJsRmwopkcBvSRT6uBDnxK4alvKT3PJeTsWOKTAen2J0bkprkrKH9gSCIY3eyxtj48YGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQVKI2STonXiMq9kjbFm9v4A14NbuaKe+712SLxvtGM2Wow5tkfPcFpec8st?=
 =?us-ascii?Q?cxtLu3oUHUAa0WfMO9tPCWin0e727Tl8GEzLVtyPFQ9/vtIMajKSEUoWgX58?=
 =?us-ascii?Q?vTdE8KqOnus5LphrFb0ZyKPAacvZBgPfC/JI7MRIpUXngSK8YALBjua3z1gn?=
 =?us-ascii?Q?saQFz0ls0kRLK9xzgCRYTI/JvfB8UPXmuGk9sbWrFjUAGobP/2ZBBCW+nR/F?=
 =?us-ascii?Q?hcN2wT1hW5lA3aBeJlq17ysm+A78ILHQ925zqWk7wMI7JQRcYD6lzuKNYavn?=
 =?us-ascii?Q?Y/FthIPbNw9gnf/1ntfx7z794ddQ+6YruNoy1ZAAmJDltb+FvmlsIjt1U0ob?=
 =?us-ascii?Q?zFV40L96pWfddun3aavY1tv8uVqF5NCua/iHAmTjtngEV5wqMyyQ1KUBlTkr?=
 =?us-ascii?Q?mTjz/x5V9oyBsnVNJrCMkPMFck1y+/ashasWGRHNtVjR7Hms7W62vDD3XRQQ?=
 =?us-ascii?Q?agGDGt+Fs6aVcT9jRgwgJhqO5KplBcJb4+51VC7MgoKNTZKCufu296VU8fW1?=
 =?us-ascii?Q?dqhm12HnqY5aFi/txa+R7osSNRW3pkh7QpiuO457J43NOEZLbRrL5ZG4J6Lg?=
 =?us-ascii?Q?X29yDK/gv6//4Bukbqny5wWWZ8F2NznghG9+BJjKZICylEdtgTDJcYnEWbBM?=
 =?us-ascii?Q?HGabR7qF+oI3WGTTKPuLKxqun3dly2WApkd9uWf4av55GNEzhFFipxuYnF3o?=
 =?us-ascii?Q?M/nLSTotJvU3w6zaIstRuYt7HIwIu4ZXtfXDsUuPRQJXkhCBghrby+YLGb3l?=
 =?us-ascii?Q?SwwUsyXqYULUceDyaQU/Mg/9W9V1CFXEJVyGNUBG1jsFeq16+ISDB9YtQAxT?=
 =?us-ascii?Q?yjzGY2MJWu2AOFytZ2uTcIEW93APRlAs2/ytC8FSxL+JPngL87L4SPYi242J?=
 =?us-ascii?Q?y4EEfivsJJKMLKzbqjuyDm72GAIMDlpMfhGNg/jxdeNoRTCQGXsJSNpFgw4Y?=
 =?us-ascii?Q?TYHNfuuf7VTbIHlS3B+6UyArO2sw01CoXUvsLZC3mw5xvQoU9ZGCe6GtIBsa?=
 =?us-ascii?Q?2Sua+OfZqCe0h1L/sbYljO3B1zw/MdKXRoRH3GWxOOKvKbhDeAc8V+wpimD6?=
 =?us-ascii?Q?kktVefWnE0vKIATQ8ZivbPmsWGO4dukEYQvI1qxsyJNXPO1LsMDm9dh1hxzz?=
 =?us-ascii?Q?Wy8gy45X6qIIRaGIYUhOJyftKVk9sroA/SHavCUVn6GxWRMZET71j063+dWn?=
 =?us-ascii?Q?Hfrtc9pfEeR/axcKGuJMgs/SWyFOp5r4WiqZD5D8z6u16z3Ly1aEOZuhdTfL?=
 =?us-ascii?Q?Uwrtmlo7VOnu3vm2R88aePv6ryNpu0L0A9obV8DVqDZ1uUsJtAz73k25IAjg?=
 =?us-ascii?Q?Y9r5OzYwb1QopnmzZMp8lchROYet/Nk2UbLHPs5zzQt9cb2tH3CQeDcfAIP3?=
 =?us-ascii?Q?ENlcZm3WN7OxjZVPdq7EGTFKVuCd0r/RydJFjwFMK+yt3GoE2L7il5uX2jaK?=
 =?us-ascii?Q?1lrlDAsVB8ck73O+w1nakrEenOR+yjLa1QcRVvDJecPVwWdZ+4+D6Gai6S2+?=
 =?us-ascii?Q?zEzwLS8X2S7y5xfhdnxq2VOOkU3mKgRQ47SXDF4Np0XAcaFATJGnCS3sVEFX?=
 =?us-ascii?Q?Zqei4vPmL1MRj+9lfb87k7to3zQvV4o2BkI2Pue36e7VWfm2Fc9r0+hiRqKy?=
 =?us-ascii?Q?rVT58l7GhcdbUR1xG/JidiEiERHK1ydB9Ap2ogp9+RiZNBD67MMPG2+cehWf?=
 =?us-ascii?Q?it0ERMT6ODvpxNEux72wG5fhr00HJrtjdVN5Bh5f3AtOAW0KgWF90nMkGRMm?=
 =?us-ascii?Q?zUzcXp6tdvmqSSyBmXWx1rLviAnqLQQ=3D?=
X-Exchange-RoutingPolicyChecked: zA30YRcYwnPdrcnBBz/WU4yZzF5GdzqBMJm091mhaNE2+l5bKu/gRTjsdEqUFCF7ASsnnk1TUqGoujdWU1S5GqsgF1Vzjx2PBKS4lisb2qdI0wtd5SQXCu9Ra6lMODFkcRRexqd5BxgKWG+WuwPoxlGkppmMAXW+7wKNynzAq2pQESFg9ZzdhCV7s7qgtwEgDL5kZ8PfqmE87ZoXEanPmVbxDiAI/qmUdqPlrZJH2EtPtM9elI/1K6ysEALe7RKDCTsVEhbWhCYkW+AXLGX1v/yzonbgeyhoCBQOLDDD2ccFfhoypHp4XxSJnP56hCeiHgaQnr0KR8+tFTU95qewpA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ns5mWFP35DepSWFNKGAYDDG8Zyc1RCfJHDMgxA8Iiqq9f6OOTTBcI6VudPNaVCbJDaB9+8/Oa4bRo+AFJBQNAn2ytkgISEubNTVhTV/dyS3qHGQAXugFOo6UIj/nHjNN/at+dWUFeFPR679+hUuI9fAw3HQVotvXq8n+zm7EZJPpyBecJVaGhjw6DYgfNUat4KzTD3pBeCpXkB6i5KJT3+gkY5FWzg4QLmd647Gh8Om970vbcv+HN/GKMveEbjVj6B16s5IQmwBxf5T5YQ/45b+0Sjks1tWjyEayfyqFEhHP7RmoRhqLmlWEw0R+Ck+9WpnWS/58Xa0PqwIPoOS0EmDlwKnExITBsg/n4T9aegmeiIq27uE9VX2fpFa8zQJ+ChZfKZeHfRcFz0PElHDChGWCZOXGIRuuPVCznbU1VQJziNihFqL3V7quM2aPWGLFUnw2bMTjdEvkG30MKMW4dZK2NLhhIewxb23SIGoJIhFNojaxZuoDZfKtx+J9+5CgMakYCZXDClHWt0jtMhoPYEBi1/47swlMWjLZMLnQne/Sg0bNm88ai/n9l32tlL2GWJrNRcXBd4IBZ5HPmeJLfINvy6GJYy9zXCHOqbUOBTQZS4P8eWUKt1+SDWPLq+yq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3af109-a709-40bc-e5f2-08df2e954aac
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:31:24.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilgHMaIdKJcKWU9cIGI+HjLwXFS3ePQOI1PPNscaF0x6Rneh7gCcEFPYcceKKGoPMJf0Ue1TxjXf3vJWZ75fNB2/7j1+vH+fG5DH4EkhLAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB784716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_033127_680144_DB13AF19 
X-CRM114-Status: GOOD (  19.88  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Oct 14, 2026 / 19:00, Andrea Parri wrote:
> Add helpers that export a zoned null_blk device as a namespace of the
> default subsystem and connect to it, tear that setup down again, and
> issue a partial Zone Management Receive and check its completion status.
> 
> The zone report tests added next share them.
> 
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  tests/nvme/rc | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index c415ca1234407..270fad19d61f1 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -408,6 +408,67 @@ _nvmet_passthru_target_cleanup() {
>  	_remove_nvmet_host "${def_hostnqn}"
>  }
>  
> +# Export a zoned null_blk device as a namespace of the default subsystem and
> +# connect to it. Callers must source common/null_blk.
> +_nvmet_zoned_target_setup() {
> +	if ! _init_null_blk nr_devices=0; then
> +		return 1
> +	fi

I suggest to remove the three lines above. When null_blk module is loadable,
_configure_null_blk calls _init_null_blk. When null_blk module is built-in,
_init_null_blk just fails and should not be called.

> +	if ! _configure_null_blk nullb0 blocksize=512 size=1024 zoned=1 \

I suggest to use nullb1 instead of nullb0. When null_blk module is built-in,
nullb0 device is already created and not usable for blktests.

> +	     zone_size=1 power=1 >>"$FULL" 2>&1; then
> +		echo "could not configure zoned null_blk device"
> +		return 1
> +	fi
> +
> +	_nvmet_target_setup --blkdev none
> +	_create_nvmet_ns --blkdev /dev/nullb0 --uuid "$def_subsys_uuid" \

Again, I suggest s/nullb0/nullb1/

