Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A2606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wy3NPXWd;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=C6QRBgW6;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=dscKJk/G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=reJWFZl57s+l/nohwuJ7UicZz+C+pzhcjFCSFHmjJeM=; b=wy3NPXWdaL/C+Y2n1+/rl5dnZ0
	06VN4ieKr5eVRCS4M6goNEGTmoLQdYURCelEHBExxgxP29jMSvZ8XhDEVjWryRzImePrCMQX/TQ+B
	IZqte0WmrlF3l7a7d245v858fdRqTjDF7+WS/bfr9jF8PQdhwUIHFIWBfQnazVTtsN2SyH6T9Gc1j
	C6dypvMVB0pMB/LL8R5NrG7UQsBxOGty/wDJGDrBX16PiwSbwwfbTiD1q11rPi/btjuVhbuMbwTBK
	nbLiFunb3knczT+ydB/w+Z1XkJYGca4DFi0XsiSl6OCvrlI4SR8pRKSIwKY45C/nfhs76T5rDM6gf
	zd60pmQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR5eF-00000006MIv-3Dyh;
	Wed, 11 Nov 2026 10:33:47 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR5eD-00000006MHa-0AP7
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 10:33:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794393224; x=1825929224;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lcGUmSJdUk/oR/q1txC7cWLqeqZSy8AGOlD87NHJb98=;
  b=C6QRBgW60nlfBno0chDG3jaDIbaInLUnhn4bJL3yB/6uPJ8VGwcFkz9n
   wIxaT3THnAm5dIS5IdQi7Oq1odmP5X2n1fvzjO8D3eLH+KES0yL+wlK6V
   TDPQr69fDufUqBtCyVzjLTBNe75zAryNuPuvn21CQk57rqF1p1vxdncim
   6+24L/aDzqohJFoTgUYa4kvHtLWZ5pJ9weHgpf4dLW0WrBOL/LKT7TDSC
   JMMvd7O+bjui8WmXdaSqwGdC4S4q7wNoSdZYnYuNHoWt2QN+kZlHiSTMB
   +M3XKrZAh2c5E3ojUk3OZB0vPlTEu6yri6htJkN8+Z1ehfuHI/3n7CnED
   g==;
X-CSE-ConnectionGUID: lLgjS/OOTtWJo+hrmqisaQ==
X-CSE-MsgGUID: Tl+50SlKTRSXo0OIewSM1g==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; 
   d="scan'208";a="159663173"
Received: from mail-southcentralusazon11011062.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 18:33:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVongUiRPFoTPKPsgV6YyTYNyvh27c7WmzMBMsOwdFHN5zDn2TS892Q5FuCqj0+RwXcgQTkm4LM4xKdvp/AKfkPjh7PkhtGVPNHMuQ//hIumBK0Ss7RjgyWd733FuANTXdLTvA2fky/WCNj22hJ6JW28iMsN/Hi11AEPmUEBppGr8m9cpCst/JdyzFcPL8Vqy4Pd4fMVYl1rbqTpwNYbepDSPAovYVLm6fSPywpyOht0EosJVpjs0BaerM8gVxfpARqHWU3LQZjJB/fzuzXLPVP9KgdCAz32LA0khgHp8eCsWmZJxN7ozpyB4cR7pMrH+yL7T+Xqvae3GSdCQ/jf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reJWFZl57s+l/nohwuJ7UicZz+C+pzhcjFCSFHmjJeM=;
 b=Hc/7D5nCtvY2kygMjUAaMXpyANcoUSaO9gk2N/Y9Vxoc6ii34/2LxmhkzG2JScNBEn2b2eZk9ISL66sPap+sblmfPoQpD1YSvWRiVAYFfi1yUgKdSTsP1xuZa7UThRBwyBZ/ufsThfQ5048Dm0ULAchA61ghmcbA+4fJ/KVee8bT/DpzNGy4Im6BJsLSTN57KzktlJezVVf8qSRXweLM2g5WwtRVfSdLUNTvskCLyWMWURUZrkFG/ps+dOileJZJ2O3H5L0V+GZ/RJBU6qvDrUSW8qHb17S/EyQCbbfcUyL9TfSvAEY54RRa6oofqoEJiqgSxEVUtqibPUH7ifhRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reJWFZl57s+l/nohwuJ7UicZz+C+pzhcjFCSFHmjJeM=;
 b=dscKJk/GlGHvckktVxXV9Kd2uAtdIb9nAby+4HSBBQ1GwxB32xmTY9QvS4+mCt+fRa+odbA7eff97XeAbsxFxhAog2rpelgeMPYeMnKZ/p2W4iYNEMDCZAx/IfUpiou+hPEMa4794xAQy707LLujnplojcYcEeS1gL47hhaOXAw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB7517.namprd04.prod.outlook.com
 (2603:10b6:a03:32d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 10:33:41 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:33:41 +0000
Date: Wed, 11 Nov 2026 19:33:36 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 09/10] nvme: skip the tests which need a feature
 the remote target lacks
Message-ID: <avRD23enUQ1UfQpj@shinmob>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
 <20261104-nvme-target-control-v1-9-b31b40537bb4@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-nvme-target-control-v1-9-b31b40537bb4@suse.de>
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9584b63a-1d41-4e0d-b748-08df3fdf4103
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261022105027099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: /ugJu//CuV/nhroLTC9CaAfcVhKc1BSsbhFDD8yZQOK/y/LM/Xbo9DD6pkeBIbHNNda4k7wkNONEO7bzyJi9/EUUXSclmFQqchzyvh/f0Rg/a1BpdzK2e0avQ6gV49GhPJR6NAvgd1wylhmnORrHyCFMdBjqiatfTv1h04d/yoBYwTl1UMJxMxaZo2Oh14ebIpdmtauYPzRqlOK++sWoxmfRvQav4j74fEnZwa9mJK/iwoplTp5BJ57h1SiorCKje3TMfqzxo24bFpzP39h2hO2LRR2wWm6ecUaRhGHD2KhKjLep3dmxD9RHGb3WaBmmnn/dlxjGjQMXaR1SuV86XUQdr7aH2gl/61Ak9rOqI8KovcTseLvspD86HYwfxPGIVYFAa+gboHbw2EBdzQGMd4KwLYLOQJVSWiiQcAqnFywdnBYFj7K+STnxH8lHNyM25use74oO8O7kzx1PnFXyIIe694P2dHIXlOKPVsoMjp8d9ucHVcvDw3pdbuu8bnKtSHBESwF+3pB1HtSBrqaV0s9g36GvSeRIuh5jbrJ1KhKZcZCz96OLDKVPpBuLVKiPGPa/BznJq6a8L5rKnQA2L5E/avA5+R7we3w09Vwwgh4fzbbDFmwDjojwNVeVIQSBYYI/HMuz3mxUTciySdyosKCgxhCfTrW69PCPziFc3WM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ooT6hIsHnrW8a6yFnqgkihyY5pdom2fwVPfarudQWjQpWBb+SGQ3XwB9AwYl?=
 =?us-ascii?Q?M+0oEzDD7dlTP2uNDbpTEwNtFbSWTO1GPl7iRvxK2mJi4Ye0rItPdFp0Z8UM?=
 =?us-ascii?Q?+VC9ntKqmtgC+d0zGVZl4zMFMy//9a1cE3xS+05Hu4KwbNUnCrmXbOFJtFnJ?=
 =?us-ascii?Q?4bN0Qj/nxK6PQxekW2xJBQEQxQZQi5jmgXxS8u3gxkcAIC7adCeYNpRJ1GDJ?=
 =?us-ascii?Q?aioXRbley5oeZMZeAwxxk08kp+elpAoSXaRwH9NqkYXf18i8CLUmXzq+hf34?=
 =?us-ascii?Q?HxQV6iiBgMjmefIXfXYSkHw20+s1+w8+q+17oNfL78WjzWuAnWXbqT+Rufc6?=
 =?us-ascii?Q?AeuTUURJsbuA7PI+vqxES0Oh7gqFYirvbhrZshhrcJ7cO6PMP6smf1YjVBzk?=
 =?us-ascii?Q?hPVAWkozX2B1/fhpXQJBlQ6rlAmz9wEY0XqxAIuT2c4+WuH7Gark9hTpY8Mu?=
 =?us-ascii?Q?HkrJyJOMd738/ZdloP7x1Wd0K6eKIgnLvNk5+ABVmoy0d7VyjuDH0ngIfl5l?=
 =?us-ascii?Q?mjBDTv5v443NAMGyhOHRlMB9IYFS4liZf5sG8CWlH179AAio3tphCl13UIe9?=
 =?us-ascii?Q?uV/ukZw6BTxFqYF7SS91ZRomndehKSJUGn4tmhOT6SpGOGj6DTocdwLo+RPY?=
 =?us-ascii?Q?N4PSvNY9MWSNnHXjBTQvU3lGecjR3cempd6Ih0fXg6Q1e+sUXQPW6V4rthJe?=
 =?us-ascii?Q?2lP68qXpBv145kOLYwrytwTvEhySwgR1MGOlHeZQ6W2i7Hu1x96Nq1VYcDpe?=
 =?us-ascii?Q?D99BmmCY59BJnOpoIsveq/wua1w9Avo2MiHkZS59lt5soAR0sUjusLBUAOib?=
 =?us-ascii?Q?btrZ4HVOXWfj+Z7uA6q920G29KhRc3+/kLk7bVXCLbnZUTsyEr0OfVU3R/Vr?=
 =?us-ascii?Q?l4sMRC1bvv7Fiiwqhg3ZqiFO5dW9h1QltJEDeJvPVUmfjX+y0hd7KrYM4BtB?=
 =?us-ascii?Q?tOGy0ehw5XMEIXvA3V1HmAiyTVee7G2WBOlj5qIv6AWN28VZCMYekLCnCCMa?=
 =?us-ascii?Q?uOkHiL71ud4O7CPycz60BAAwUsLBWfGvkMpSM3uadq7NZClfA2dX0Q1TN3PR?=
 =?us-ascii?Q?Ie4cPm/JqzI8y5C+7lJfuGIc173WLnxQCq3H/V8Z6Yizy3zVMK8BN/DhDtFL?=
 =?us-ascii?Q?CZfijP+AC8KEe0uOV8XbCbbBp01xEGxWxuuj1FA9w9GBRu5SpruQVS5K2/Zn?=
 =?us-ascii?Q?LP8jorGeT/C/KcUOXZyyM4HjRrdlJjRSwAAYuvtAqFUvrXpnLjMZhfAQfqJT?=
 =?us-ascii?Q?XRCz5UNsFoRNbeY2uDs6s3KmZPozT9KzhJAQt+JRQE25hM65+2TX8x9jn0vo?=
 =?us-ascii?Q?dA8vjBHB9Ds4JuL6HAX4f1y2mVYTz5FLMAAr3ZIaDaFiE3UUVGentoKL7CdY?=
 =?us-ascii?Q?xqF0qxWhxdQ002g/nALhF1tJfyK/0PyCFBPrY5R5kGFklYZLgqVa1Zb7z5pI?=
 =?us-ascii?Q?jfXWb6FJlRnvh9CHReDNICHGJ6uYQQX1D5aEXDCmJ8G6N/3dRFzN8EOj7Fj4?=
 =?us-ascii?Q?swg/l1R5rcnD61KxkYPBFOtIBhy4eYVPnea7b10eFBbY5nbg1MelaG3Zvr6C?=
 =?us-ascii?Q?W1ZkxkJFn5yHiIWykDnkXJzhaGRXnLWUFaZl1T43zOhaSqpfTeAIpQvnfOBG?=
 =?us-ascii?Q?8KsKjlScBuPWqc09n1Pw0NCu2HX06gzl+WMjV/d+GmawdTfqbC8nEtNcI+ou?=
 =?us-ascii?Q?lEvAcLPhGet7DZCB4KsMiNH16oYnr9WuihoQsiP/8XZGTmilXhZwA7CyNShy?=
 =?us-ascii?Q?rI7iJTdSHZnwc6eL4z+CuIYJfjj15Bc=3D?=
X-Exchange-RoutingPolicyChecked: XyyB2wbXRWxkBqWaAf7Na7wNu9Rwel1/5qfL9UYkyu7sqgTWBNS6aVD+x65FO1llZNNrgmcjIZM1OSDEv6E5vbL4kShhjxdabBR7xdgQUPxYG8+jVS1Yla4/HPna6K3gMbTtWG1ZbTY1jquC1pDB5LZTwrE2f1+Q1XHGZaA/WW7JtkNBpJQ1VW3BSNw6d6cZW43hKjc+2i9NGGjJOuLD/0mz3SokyenJF9kABIoSKERR2kSo+y9QuRADA1AiQO4iIGGv2MJZ5iDVB3KZ2KTPrlly/9pI6ugaWjeDdP6YW5CEmcndRAPOgIkLNJT5MCUCw0a5gIB3JWQtsRCB7gTuQA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DzKtvJizHYgT09mvps7aKaH3GcAumnUjEKq+CzWotGTq5WyFlFuGD/wg7DnFH4RaPmeVh6fKkxZqUHuZdWr6/5/ne8j1Z4XVLAFokLjdNjDt5bXZFSganyh7VnbniFHoeaZa2QsYChGs8fB3nEDGYS0GPxBGYnHNxUKrtnX8Iug2kpk84mgT8/ul0pIUe+UbdQ+BpvMNWkDYU9VyWzC2TQtIR8EYhoRHzUtnId9TjL+RJwh0wGis1PksLfKPoQ/1hOK9TH1Hmy0f8KPAoUduoWsZIxgxssOa7/ZR7iSOhs+UmRRccU5NvM2W90pb4ciJFQ+C3Y1r2Gamjs0+5FS1aXQDz8HNMOUD09nyUdKN/ibIflLDw2c+uUmv3AKsPVLGmjnwtHrL5iaE7CrGoSFC7IOPeEn2IUCe1WvPG9qHFbFRN5xDJO2E03jmjCEXTP4KQet6Qmkwn7Lmnn5niqpvkeMoNY9pUmkuoEfNyewbUjaBQCIlXt7QnAyN4mLxYDjG9r4NqbjrnNuO8lJMnc1OPlszQK/74iyJxxc3hyHcc0bzSfkiKYr6Bev7jxcbRSD0q/IRO+COiokB5f0k3MJJ2dsTVGHUburDFlJ0WCL1YT4KD0AvJMBH097r0fIc198a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9584b63a-1d41-4e0d-b748-08df3fdf4103
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:33:41.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOUSvyfTrlbjbOI1k6sw/+Glsp3Y1ni2OXDNI3kPaEO7PkVRN6uLDaEa1Puuf5pIGQcyoOfJ7XfePCw3Y2XuIyn03OfdhhS1uzcxjNZ+Eus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7517
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_023345_086120_B4CCA311 
X-CRM114-Status: GOOD (  23.11  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 04, 2026 / 17:44, Daniel Wagner wrote:
> An NVME_TARGET_CONTROL target need not implement the optional commands.
> A storage array, for example, has fixed ports, manages the ANA states
> itself and may not take host keys or a TLS key from blktests. The tests
> which use a missing command then fail, e.g. nvme/057 on set-ana.
> 
> Add _require_nvme_target_control_feature, which checks the features
> config --show-features lists. Use it in the tests which add and remove
> ports (nvme/031), set ANA states (nvme/057), change host keys (nvme/042
> to nvme/045, nvme/063) or set up TLS (nvme/062, nvme/063). No target
> lists tls yet: blktests doesn't pass the TLS key to the script.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
[...]
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 3c3ed680e416..6bdd4058586a 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -155,6 +155,24 @@ _require_remote_nvme_target() {
>  	return 0
>  }
>  
> +# Skip the test if the NVME_TARGET_CONTROL target lacks one of the features,
> +# the optional commands and e.g. tls, see Documentation/running-tests.md.
> +_require_nvme_target_control_feature() {
> +	local features feature
> +
> +	if [[ -z "${nvme_target_control}" ]]; then
> +		return 0
> +	fi
> +	features=" $("${nvme_target_control}" config --show-features) "
> +	for feature in "$@"; do
> +		if [[ "${features}" != *" ${feature} "* ]]; then

The line above is a bit confusing for me. I guess the line can be simpler as
follows:

		if [[ "${features}" =~ " ${feature} " ]]; then

May I ask you to confirm it?

> +			SKIP_REASONS+=("NVME_TARGET_CONTROL target does not support ${feature}")
> +			return 1
> +		fi
> +	done
> +	return 0
> +}
> +
>  _test_dev_nvme_ctrl() {
>  	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
>  }
> 
> -- 
> 2.56.0
> 

