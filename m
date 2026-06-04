Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7FECD6E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 02:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BHjLOK+sx80VYbs7BBjjz/KbcgyLTD+PEhwXieR2PYg=; b=bE2DDbY9bxaCFGp4TmK5vSwkOX
	pAkjNuJoMc7JeEmAl+wdfqA0HRPLGZVKF/5v/QIuROHFvhD5t7s0h5Tft0ENv3WWEhoDqvGXynBpZ
	2p7/5tgBSFyvlnsT9o8lSChCamrrhzAj08XShHBLlyVHxpeiERkn9A7/Ng/Vnm6VFbXgR//eoYc+n
	x/LLoV+7jnzAZVV9U6gbgqVj3OpNcqQvPJ02tmloxDPY1dB2pMoCHObGPAPBQ1tBLrt8J9GC3nXJr
	MO0gM2bCgDDg9JCqhFbrcnHEQxTbV0nZofH7Ekrj/mW43MZHXYcnDjgkD3e/Z1XA6lJxpCgeq9o06
	Ydw9KyRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUxnk-0000000G2P3-2NGp;
	Thu, 04 Jun 2026 02:27:20 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUxnh-0000000G2Od-0wIL
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 02:27:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1780540037; x=1812076037;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eLCZSYPlY7chMQ4/KEcHCxu/TFXM/wF0qpQRVJdzycs=;
  b=gFg0MtRCkI6Z9KgPrB+bJBn+FXTZolFzSNUAmFUop30mToCtVtstP2AQ
   yyEWdJPF1Rw2zvygMuvegyuUPGhrDFHClJ/9oAT/n/4sWZi69TNZmUUXW
   OnvEnC5QG5OU5rPJeehDtVsAslimfVzLgaaZv+Lhkvcj7FcJq5rd+V/Nh
   lWk27ED1Ogu7cMHAQJJHNqVeTcspzPVipqck8qsfavCuXfwfzSR2ROKIr
   e77vakJ21WvatXsVDEhZ6uspnyfgktwzDg35qme4yTbl+Jjj5/+ognsC+
   RXBGh7CwDCg2wP89jYRSHif8eZs+sJ6Sx30tHeyj7blTOll6LzzIrikaL
   w==;
X-CSE-ConnectionGUID: VUoKkrBXT7et8IgqvPquZQ==
X-CSE-MsgGUID: N5FqmtGWTJuSASbIe3ItBg==
X-IronPort-AV: E=Sophos;i="6.24,186,1774281600"; 
   d="scan'208";a="148389675"
Received: from mail-southcentralusazon11012002.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.2])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2026 10:27:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj1tiQa50XvwSXTUbUY5a+JNAzYF38FE52N5eJQ4yEH4I54ysF17bg4aGCtYGHrrNSZVY30uaP0iRo7YsAchhvv7oVL1SGnOjptFhxFUuaaNqU7tsFFp5E3aH0Iy4prXZEtE4hlIfSxPcw568h8xyJI0BUYhOgqjx16SXX9MT0IzTRPGu2PBpdV297WCOhmXhIE8pKuDMrYlGBGdSuDH2TyCnPXXdBsJlBvwXoljth6kKevCgs28JlSq75gkmJL75a3Pf2vq2HIrTAk6Ge8gsTYhyIYe2hszeoFqd5QbRiWrTUYf4H1FngVQ8Z7gx7Tu7roo27ULCtAVAA+c+jY4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHjLOK+sx80VYbs7BBjjz/KbcgyLTD+PEhwXieR2PYg=;
 b=jnYULHHcV/ckTpWyR12RusHc6GNjfjzr0eAUk3g5GkuAekIdYz6ZSLbNcMcZMaJSsRJhZFg/VTKFYWdfCispNF+JuhGO/4Jkxh6h+8fKgOlhWL1NIDRr+mOgle6zmEJIAQ1OZXs4x/fwO9tgxmMQ8OY+9BWZ8YxHfZ3Aih85WgUBecfxuvNXYgJeNp0NaFJwnHTRtlDWDRlMKWHW/qQRCeJ5ERaXL8u/I2uM34sOfpRs9lM0z4ECinUvYq9clBrZLSdZkPm79ha/Qx+AgMV0flZc6EndTJx8U3ZqBqOhT3anGH2E8Q/uktEa8RAiFWGP7K0fTW4Y/mty35N7xnQQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHjLOK+sx80VYbs7BBjjz/KbcgyLTD+PEhwXieR2PYg=;
 b=dSyJ0zq1hPlYCq9hedIFjQIo/Vw8HNoXu/B6gJZj2zTnC3yOGi5L0keX1b0zvsMXKTloMAoiIyY8nwdPbKuHVd574rwCyCyHbGCjA3ZWr0/NoO0VHgHdFkYkWYHQsDmJy3oBcm1qQO+CyKxQmZVUZ4pcfzfyYg8l39QEqr1OB1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH3PR04MB8862.namprd04.prod.outlook.com
 (2603:10b6:610:175::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 02:27:13 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 02:27:13 +0000
Date: Thu, 4 Jun 2026 11:26:35 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme-tcp: lockdep: use dynamic lockdep keys per
 socket instance
Message-ID: <aiDh8DUwDxYdTepv@shinmob>
References: <20260603112533.375925-1-shinichiro.kawasaki@wdc.com>
 <34707988-b1be-4ff0-9786-ef02b26eb0de@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34707988-b1be-4ff0-9786-ef02b26eb0de@linux.ibm.com>
X-ClientProxiedBy: TYCPR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:405:1::13) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH3PR04MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e20ea5-76b9-4847-89c0-08dec1e0c996
X-LD-Processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|22082099003|11063799006|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: 8dbDuu5lEI22Wb8t+hptwJWkIwGG03tAqIkJMFuhV62JO2D87e/jK9aR3j9rorcQa6oeSQ+wOvysKMgK2efVIdcVVrellRCOH1diqI/y6IAWV9bNTgaeBLmMwYYKeWeKk7aTzE+4kICtlFsT0ZRGwgD6rMwZL2c03C1Nz9mYQf7X6NldbK55g9QnbW0TrsxQ/WEG3PFY0gh2bJVXX/fiDwn0VIR5/+mghXh8Z6+8HHyguD9Bd7OteTpuHH11RNQ7XmtJtZHXiJtqI9dXdeqbFO51zVolVtqwdgc0WkGEKHxHYrhcFRwk7Ew8H5WzPaOGPzyBdkdZQbAa1WOdzUXevgxbAcjEzewZcc5CA13UH9sdMs/uhtg+gAFtGV02qj0mFKFUxwlruNSJ3MQ/CPHd5ZBtSqXH2Grwd+ZMtLyBcPp1VyNeMXCzFYda9TAW9iO0L8zf7v6sQT3CSs/wEgku/Jotnz45S987YcI89cVLhgXwjAVzHuFSA6rvKUuMQojXzlpAQwE56IGCGjEI/7VfGvX9K02RuOrCwTahX0yTU4EqdDR/I4I5Isy090CNki1+V3aI9vTcYe1i9nIfp80HpnoQuwNiWcyX4G4sP6H/vX6ZLYK/YJ3eTWKm6I7MUwedUVDzPYQspHF++azNHBrwYUcVnomN2QQtO9Elo/ASYOOgxetyYCGXgixFMy2XtoSM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(22082099003)(11063799006)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pJ2AFjostQo0Hv3KQNMPtuhRt+VC2g3PP01FeuXafVZbzCIRaGPie+mSW8i8?=
 =?us-ascii?Q?jzR/h8dVztHUvXjaVxgV5L0+3dN5Cz6oEpHHeVUiwXQ0CVRjDmcp9MJ742uK?=
 =?us-ascii?Q?cc+cf1tGmItGW6oN+CIwCftjSIjK6Pj0eFM54g1QwzQ8ATrRuv6kXdPCcViJ?=
 =?us-ascii?Q?yvt91nz+AYrgcMBTBp1mEjOqaMtLqWMmzInaTim0enpum1Tyu5CMijKRWsJ6?=
 =?us-ascii?Q?dcwlx5GYYlx3O8JB/uHG2TfX24V5I75Y7exzxHQR1RpN8aFszjsgvo/rrB3q?=
 =?us-ascii?Q?pj2FtqrrTRL34ZpvH05aw7GOzVf3N7Ff2kAW7nq9Lc4CjF8mywaxKH8EtCK9?=
 =?us-ascii?Q?J3OK9JVndYpM4NqGrjPJue34a9hA+zk06AJ/SjJ5ff5f7vJjukCzdeI9S9es?=
 =?us-ascii?Q?KLgk/f2av9PZi/SdSkTLVLYqC86SXcQqkHLPEYAJVuYXmMI1G4pBmyQ+nEXf?=
 =?us-ascii?Q?mufdLGzurfXmLSLv+FZuLdb7Jit+NbSaJinNWgbJaIk2VyuraLbJJmMLM2IE?=
 =?us-ascii?Q?UP2ZgSweBJeTk2d6A67MyO4BQubm4KWXQ1Ilrsfj4gIbcPC/N9zKG+E0L3G3?=
 =?us-ascii?Q?XJkj2RW18X5fEnGjis9e/pL/Lwf4Qnl1ZEcH5Mn9c4rx/bMnOMHRH966tz9I?=
 =?us-ascii?Q?0Us8VkSzy5yBysAj9Mf8We0hAgRXaPpL9Z20qaoAwh+KDVyNpKUX4YMVpOrp?=
 =?us-ascii?Q?kCjCrDiV7WJpyPidPfQuWIMoCwCfdWklWiu4uiD0yFzP659nj5V4zR8dPKTl?=
 =?us-ascii?Q?9dhWG0tnf/J8tnVWq7TtVcc0F3x2xizykJ21txqULNdvzbaClN9X2hFfF6eG?=
 =?us-ascii?Q?CfqWDFnqLPsqZcomkEHO0OYLQ7NE+Hr4sEvWxczicV5sMSPkqckz0jvW7kse?=
 =?us-ascii?Q?m6m2jVvsJ/29L6zU1ioq28f8F9ORoVDgJ3CsjV5OOBd4lfvZdjf6f7dOdpxZ?=
 =?us-ascii?Q?+kpspHXRSzkEPUfjocvKiVxr15RR9+NAwvhigpX23ccYuOpDoQaciQzSAAkd?=
 =?us-ascii?Q?ZvsowT5HLOE+rSwkNCz4MiB5fHsEGdEfI4PU1y00gZnHCUVxgpECEMMaKMHe?=
 =?us-ascii?Q?JxXV+q92lIxv02RF9kaetc3OImjJ9lHz+VOQTa/VU76XKAZv6ZlVbm1Oz6vb?=
 =?us-ascii?Q?60xzCiHtNYRfKdudAbpoY9p7YRVrV8cT0BFyioc9g6FfQ0qxeLa4W9IvFzOZ?=
 =?us-ascii?Q?ui/4Fdxoq6hEMurqbEfKIvak2H2r6SEFjLnwoijNDaOyJjRbt+1ku2ZZkAfy?=
 =?us-ascii?Q?7ZCM1I6bFsbc1r851C5DU96Y92x41KxN8lL2ii1vJUOHQqrGi52jg5dJNF+R?=
 =?us-ascii?Q?YUMfrbm64Ji2rnxyVMB5WOWRqUyhZiwG1uMbNasIDgFENbJIaLbkyrlhPdKe?=
 =?us-ascii?Q?1afB0OEKZuWbv9K3nbfZuUMJVMt++SXNYay/6c6vU9T11cZlKCw2yp5436XE?=
 =?us-ascii?Q?hTlNwyDNuXWfdZmQcA2NdsiGNfEGH4lbUtEDceqlLiDDxgeNgBcCCvXRi14G?=
 =?us-ascii?Q?eez3jMzJdCqIdg72g7X55ddhYiuVldWMWfgOC0I6fhSTxuSqbicZG+cdllle?=
 =?us-ascii?Q?Is4A54mAFOTw+iuzG2IqiY11U/rZoHvP0sVXEL2iHGv+TeIVGI+Qx5jq4apc?=
 =?us-ascii?Q?mJQeXIj5Of40NMmMPT7l1uoAA2BE3Y1gkjD0OsVqBCxUEaZB6KCsSd7Zf47X?=
 =?us-ascii?Q?DnnvW6vsWX1HagOztWm/yijPOWYMa50hiYlUrV3t58ppbZCtwB00S0Sn0fgo?=
 =?us-ascii?Q?i+yg/49tkgrcpQQFRjflNUO3BBsCYnQ=3D?=
X-Exchange-RoutingPolicyChecked: Zzsau2QPsy/7Rgui3vF6xgIhd5rXgVAV+pWLSN0evLcQ3ZaP6/+aA/TM2c7eaORGmakHS1ZaK94wq+ARejpeCaKljBuhMMdv07dLKpyaPvoeCjO4Ddf0hTU5u8IGQtQsYygBRmbd5FoYrmvCMzlRoWf8oCfDrj2pKUpd444AZXZw4kRyiKPr4UKJ9xKRw7TcSN0Gw4iE9NER7xq0B5CkLLWCPW8UQeaMtE3gmHFLjcrgZqpdV+hyP6qjCIipUeZgg+zmQA7a1ZFjSJIPPIgmN0MYXIVQIVzhS2XSNj/Gx5+PqD01HLAS453+EG6iuK5Ee/De7oUlI3BZXbqEDOGziw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: saOYxSZ/ipszRbtb1qKqg3AfoDNokqdaPn/SmnFnZflELmcGpI9BeXULfYL1cBvgkcFLOHb/o4j0f6K1zxw09KrZRAQ1Fzaf3eUXgX5+xTeu8odBYq+eYYcfndMXEv5E34s+Im+DSxNGJmi1N+TaJb4nZCOPGdKwX/SD0gWNRb80qtiH3vPJBYEmZLParaoxiGNMO8WpuzDjQcS6mlKjxiQ9rRtZOtT9likslkAAeLWx8K8TAOJBOtlvtUVeyX686hX2chA5paWkbtjhQGW+qxK/CBjBcvAc+tMBOG1IPKr9XCTnyHdvTG7SET67SxFSSxscYbw4T061tkwNW0unm+ADM+Wx1KpUagmRqFb7P/pIt4cDKGZqDakGCjSoZL7Akggk92bJNMIWUp7RU7iitWGLgiituDfLPfWgNSq0i7x2C3AcCRxRsxS3xjL2RWQXTacAH+WDSmm03CP1/HlEcZj2NbGuM0w7SntiLja3F+x1GBnayCC3gb/4XP+qAjfni4/1MgDEtIe4fZ/dhEkBPDkEplEW/JMi/d1+XMeWHKheyGqTERwcgJgI4VamAfS+W7RPC/m2riqNt4YhyANl8yo6nduCfqLdwDsPFN5DgRbwGF5XIca91mAkV6AkwbeT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e20ea5-76b9-4847-89c0-08dec1e0c996
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 02:27:13.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aL5iLrHiXrI9pg3YXYwuYlLG4R6c/mz4uEriaSER8PYNx0TKcfJx8Xbfu2CmN7w9C6YekDJWQv+MtnhXBEzmVKdHXmGEmzWx1EerI/17zao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8862
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_192717_309396_3094D6F4 
X-CRM114-Status: GOOD (  16.15  )
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

On Jun 03, 2026 / 17:49, Nilay Shroff wrote:
> On 6/3/26 4:55 PM, Shin'ichiro Kawasaki wrote:
> >   static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> > @@ -1813,7 +1818,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
> >   	}
> >   	sk_net_refcnt_upgrade(queue->sock->sk);
> > -	nvme_tcp_reclassify_socket(queue->sock);
> > +
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	lockdep_register_key(&queue->nvme_tcp_sk_key);
> > +	lockdep_register_key(&queue->nvme_tcp_slock_key);
> > +	nvme_tcp_reclassify_socket(queue);
> > +#endif
> >   	/* Single syn retry */
> >   	tcp_sock_set_syncnt(queue->sock->sk, 1);
> > @@ -1921,6 +1931,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
> >   err_destroy_mutex:
> >   	mutex_destroy(&queue->send_mutex);
> >   	mutex_destroy(&queue->queue_lock);
> > +
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
> > +	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
> > +#endif
> >   	return ret;
> >   }
> 
> I think we shouldn't call lockdep_unregister_key() from under err_destroy_mutex
> label, and instead it should be moved just before the err_destroy_mutex label.
> The reason being, when the code jumps to err_destroy_mutex label, it hasn't
> yet registered those lockdep keys.

Thanks for pointing it out. I overlooked the label. Will send out v3 moving the
lockdep_unregister_key() calls before the err_destroy_mutex label.

