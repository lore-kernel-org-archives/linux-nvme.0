Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F3FCD6E56
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rlnc5AyjGP8WNEWT/B7YDb5IJVCMgQMr0tdkdqWjNC4=; b=vrA9LvQzO3gdSesGAfuJVL9Pzo
	+CdEcehkFexe2Nu+FnaqSN8gAiPhNHffd5yb80nXHGKXB5chDYVtA8M/jDEhHbqJYFzRCj4RcBM65
	rm+Qi2lYtHtK9eIN3YhKBquZ5pSunZdwzfg7tQe0JpescnWKPvp8wYTdH956TjOYREZyxcL9z+8gt
	9rY/1Q/FK+Jw68/0qZAkISkVjmHrFAW7ob/T7AE0pbw56Cf9sd74oE6NiM3VApgt00aiHSV1hQL0M
	RqQ1S4xuYUqONvQhqqp5wxQ4GgpWyUckfP2hJV/1Wy0Y14WUbW65IcgBeHNckMe9kcp5TyM2oDW4E
	XB5qTBLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUjM9-0000000Erxz-3f2S;
	Wed, 03 Jun 2026 11:01:53 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUjM7-0000000ErxH-27Sl
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 11:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1780484511; x=1812020511;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vtn+/h1/NjMUqVMDvlBfGCusbpWmFHXnqHQsoAPqp4o=;
  b=b2jbTeqvPSFBoafVh4Stq3PC94fNgCR5FnN+1eLN1FdSj6i6VIPMFWii
   OJR2j+C0yq8qfFN4ZUH6p6b1ah2x9d1x2fcWHcq22BLL+WMsUFiwSzY3/
   El11TyamAmRZEFilc6Twzw0yvDLlsIGllJOtAPkU9b0Uq0kYM5grxB4Bb
   eTXCYKd4HFM9kxzywj/a1PyIaEqwELFiuvo3u6zhQr3G3q2HYdA5uDLFg
   khVzsJmu9gn4B3YYwniPWRZ5eL4gxCcYXuXIs2zSzHpyJzdTseaMbz0mb
   gLzjidBtb5Ghat2sATThsSSEl8lwOxsHrxJ+a6hAeTMufVf8XieVdiOzp
   g==;
X-CSE-ConnectionGUID: onp40rSxSDyw0eAIoF8SnQ==
X-CSE-MsgGUID: i/6WIZSLTVSC6A30Pn7vHQ==
X-IronPort-AV: E=Sophos;i="6.24,185,1774281600"; 
   d="scan'208";a="144206476"
Received: from mail-westusazon11012038.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.38])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2026 19:01:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2DmNFm022UqiU5/EyFImIPgw+yzuWYOh6QREVWWoKp3Zs0UGnfP8tcJ7UWi+0YZwswHtixaKSF9H9X2h8kMVT7/DLOM08f9NUVIv0vTs3VVivJ78R1mP7eCO3Y+0ENgL/k8UpU9r9WDcctXE1CkiVvMKDOmF3/mJc1kBgps3navBiO6IdZEn5vMFnyf7NNQWjUp6iYfiLkVGVEFSS3CCTZOhcAct4GDb6YAHtix8RDjAIbY4cGwHHNFe7NLk5wGYS9ZdqYyeQv9lmzzre/Ry6ZgckcbVZL0MlEIHEqsISw3buyylchF0q2Up25fiz4hht0b9Q3hhWVTRXw5DgUVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlnc5AyjGP8WNEWT/B7YDb5IJVCMgQMr0tdkdqWjNC4=;
 b=GIG+PNPUopCWixM7bBuSUeZYhoWGw5w7lGrtHR+y+xKtttD4TTLg80LXOddbYvCgMGAi1qNyCCWfwZsfMhI3dxVjPcaQcDn8w7D9VV3OzN38dg5iuTU6SjN9REqr0KYKqx7H/j3pKgMy0Mp0T7Y++1SDhbCX1sKO02kSvcTu96CX16JQnBa/YWr3Awuqs88vSQqasf2nTpudqJ7Bum8y/4UWJQ7egUY/gg1+V78iDp0zI0Ja6GFRvBwpocpUyM868tGPyQmrKBtkNPl2CaNAjurzeupY97zLKqhDF4tuLfJrNBv7Bq4kwA36iL63auRONqw0HmMVWugrjHQDnCuqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlnc5AyjGP8WNEWT/B7YDb5IJVCMgQMr0tdkdqWjNC4=;
 b=JvOZDBXytG7Z9jJR2e/TqPMosGnXHbRTtZnFAWIdRoRoKqB436t+TcQ5D/Q95/SJWN1UwErLQTOprdKwQmb6fJWQV+m1DpXyLgpOOAv6Qi4UKy8tQhCl2S3397DW5UAdfTTNc7Vh/Ru8cjmPsSebAXsYeaJ+EKqNDWugOdpCWq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DM6PR04MB6777.namprd04.prod.outlook.com
 (2603:10b6:5:24b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:01:49 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:01:48 +0000
Date: Wed, 3 Jun 2026 20:01:43 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 0/2] nvme-tcp: lockdep: use dynamic lockdep keys per
 socket instance
Message-ID: <aiAJV2Hi05Wt4961@shinmob>
References: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
 <ah_3h7cIS8e6QTdT@kbusch-mbp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_3h7cIS8e6QTdT@kbusch-mbp>
X-ClientProxiedBy: TYCP286CA0281.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DM6PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c3c42f-8309-4dfe-0052-08dec15f825f
X-LD-Processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 6/0EZ+JjHdP0gyDotoI+aGlLVn97oPj3gkEKzRoR8zDGy1CLIyekGo/fqFXK37ccn/OiOZ1Y8CCQMXlFJyC3bzYIUGjd3GFJwrTM1pqnl9y4gIuKuQ1HhnwLl3EJLJf2wAiiwbQ4y4BCjf8ZeUdHVUeff+B7P42gxTqgAshKKvRacv5XhTnEPHUiIyyFhgz4i/n2WsOiy6Qn7lqL5cN60pf27B7eo2nmYnazkRCmgPiPnczrPjyUITEPYxwcEYhykDjoYBDYgRBvYNI3IqVNt2qgHREO65U/xQVlB9JQtdn1esuXfdWdoVarHF30LnRPldOsvQmlQM2V6v90PZ0PJQNQuXF+Guj7NSkXSfHEGhK8b+nl3/liVqXn7M2zW11Lzrr252APhFqzm8JoQs0Va7Tn00lTpOCDpaCjNbudEy6qmH0qh7KbQHLanpPt1l2FQ1diK+KhmTfxilLHdoxTsDU4BFcExwA7mgvlx1J5aTLhmw+QXZk62wZknd7bDI2l065rtt+64A4y9ARdXDq9y0WtxWgWxXfzomqLfbx8Lo6QkPvOhxcqTH5clk0wgZBG8whCMBoqqUD0sXhORAZhCqAoQigK8bE37HlWynqVN9PftA79a5QJYaEYz5IW5PpLqcDLPVAY3R10hl0WFg+XG55B/AT0WFOJ91U3PylBE1x6IEIntAdMFAnCFLPf9CXU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CYfjeXSQbc+DdagcAw+t84MU1a/OhXYizengy7k0Sh4x9B31+I0tdx7rZRLf?=
 =?us-ascii?Q?oDkYPJfvwNq1uboVhzQFi2mjd842MfEJyufubTqBkn4sfg7urt1qbwqXLRUv?=
 =?us-ascii?Q?8xbQyauiCl/kanquW3y4SpJWVqGZe5Kf9Jcob6dECJyQoYEeUwRWObwMtZ2e?=
 =?us-ascii?Q?2EnlXf1lRot9G0dFizRNMvJT+aNtPdbET2Jal+/Wn8mQl+P3XFtb/qNtdZBW?=
 =?us-ascii?Q?0RRvp3JkNgE4FwFdZD1IM/kCZPOs4xd61YckGnWyNYnjCc4yTbGG4FcxgwEl?=
 =?us-ascii?Q?l0e8PJnNctwxdnGvQ7FqrHzUkxDBLKGAFWJwKazNKIqdRDFJvPSy0l3mO685?=
 =?us-ascii?Q?/jRUueVesLQS8pLtibt9OaCqxOcZccHsizRo1sfUso7lmsKhcCz6oHJjZO+Z?=
 =?us-ascii?Q?4WpAQPpyDGXK08HlMmlXAi3k0PckqDnTxDadJzwToheUST/fKCRJJZLpyXqe?=
 =?us-ascii?Q?KpOyJGBEFtoWFhUMwth7chGqL1Jq8B1UFN4SFFctM2/SCeVGm4VXyUaa3lKT?=
 =?us-ascii?Q?4ow7a2p36sL1Z3XjFgIU0hSAyQDlAPD6Yr7SpJXl/zJWHekScEAcW2wbP2FE?=
 =?us-ascii?Q?1v/fYu1SBMQtiWDsCcM0yKDFLdW+bsKKhNjJuyQ/zOOYqcLmKJQqdXeu+aea?=
 =?us-ascii?Q?CLvOlvlDcnpSTkJjEJDVenGaE/iNzAx7n/1DLbHBkVE2W9ZRRf7DxXig56In?=
 =?us-ascii?Q?jdsel7hjDmnOBg5S5x/O/kgAomQrFlCpf1FqSApv1yz9K4YD4r50+j7nXi1I?=
 =?us-ascii?Q?I36nDB0Qqu5ybb6QxT3IiFOZ/YnX1zqPfPKJ5st5a7ReA80La23KWBGvTJB4?=
 =?us-ascii?Q?ArZyMKjpWk8SlYMWNpdTM9k2zPLLFZKcFPuKWC9SqBRPHF4OQyiyUE5Vp8I/?=
 =?us-ascii?Q?3ZP7hPZaUYhRhU9+NTfDf8rpSbpslFAe9YdmWzkYEloUduipdFvrMFNT9N8V?=
 =?us-ascii?Q?kqxy+Qq40tDJJS5gK0JDqutTWKMaqUcIsbtxrfgm8RvybqAbQgaABZcTYWBo?=
 =?us-ascii?Q?y43gD3xSQPrrJlNtjwBJxW4FjfsqPL0xXHSiCX6vbodRli6n5G0Klt4GlCFI?=
 =?us-ascii?Q?UPDwzI7w2zArLfHISzua6vwxhuDnEmdtCQhaP+sU1Y0MV/7a5ApIBcC7zpd3?=
 =?us-ascii?Q?nSGx4g4eMb9n8aJVnIEcxdwvpLvOb7gidffNTiA0oMDpW7q4oDq1PTB8Jm60?=
 =?us-ascii?Q?ddh2jCbnbErQKwZSY0xqw2Sq01b5OJe1EwiGINFbtKGV4gCUXCqoN2aM3gwF?=
 =?us-ascii?Q?VEPbCcr54k4Y/9RhzLu5Y4FjnQoo8uq95k6n5M2DxwBJQVocwVAcVZdY3lTq?=
 =?us-ascii?Q?juuSyBLpeCxWomfVa6OAMItbQ+quT18Dx94fIzencWaFrnOv1Zxq7HOGxOqZ?=
 =?us-ascii?Q?sci3qz61Ct4OSwx9w0OUkPdrqB4l9t1NU09p4rspsFc9NzNihr2KXtQQ2roj?=
 =?us-ascii?Q?q4Ty9JLBSX5HRXgLCu9+cabZbNF3wBenyhZnwkEfxBJ2JhYv/iWDeabvCLr9?=
 =?us-ascii?Q?nqRNqhA0uyPAVRG+CkQtl0NfkY2Go+7kUC//2j660+wNyxjYRTxXZmKxulEB?=
 =?us-ascii?Q?xywAU4JJOAN+mKSY74dfZj2hNx245Do8OJ2XCWwwM/qfZKTk7gHKxFSsMtfd?=
 =?us-ascii?Q?6GTTfLdMxIKva7fpQhbUS6rowsPiHM7bZGISmp0aIhPxY3S77+SKnzGnuoaT?=
 =?us-ascii?Q?u3s6WHghdLFOq1N0eY4cgL5YEe71xTmMQiM3GO9nFXatSu/Git8PXUGtS7Pk?=
 =?us-ascii?Q?uGK1/Xdl9AiuTEb3G6pJ1X1jyi022XA=3D?=
X-Exchange-RoutingPolicyChecked: gvpKsgsxXamD2ck9QoGghvPy+r37aKYueeqdU83F7YqxGlq+9QoTSCmCTe/UUuYgReC7Pg2Ij2Lr4sIBXNhoRQfTbwPnQmuzjFNl7O+wrHSbbn0k/Q39IjmfvUOe/0S7iu3wB+vIwNGHCm45Hdcl6sEU/U4tnE2jWWZCLGvteXzImYbG05eIMrrS87vsmmSygV6ByZQ+Ipxi/dMcmkZqC6pKWGmWPJ8kzJ7zh0v2vNlwC3uXFMgp9PuD9X0H8m6vzWztqgy3jx+4gSaz7pu55mdtPylDE2+hdG6g6La/oKxGy/bwWBWFVw8y/7AVMp8FxzvBTiK1863iriP/fSfNeQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LCF5MMgyCTD3lw52fmZ4/Ymg0gZ2LAAOkgfIyQpiTrCeNmMB+DMiyScvb9YhBI8iLv8LqC3zeHYgAPFPaGv7fuTb2HimReg5/8LA9fwWGL/2G8EvMNu/XyBZIzLI+Z/DEGKBxV5m5ZUpQzLIURKZ7QOcmQhrk4nj+/ulXoXCyOgDQhpRyiGSfE5yQnAb1Pb1oXlWpmUXfIkB/pNot2N9ziWC0mnRPL8li/39JpP7ciQdWc5xGtqgdKi9xR8rwH04X7kgd6ybzqWNOaGy3YV15x1KR0yvpBjKT4JWxwqg1PXK76OX1DnVVZ8/rlsTuGo0geedlFMmFlf8e6qqPdMTQ4+8P1NbOZMfYtBXnebhLj3LysXaCwh8N546kWwYN5iRnT2d5oFuICZdLjmarfVZ1Cs0YJJx3CZgZir/gLyYH62pext+SKkNruPH3HYiDyPwh7aU0J+a8UQtfGGKCMRswDWn527Nk1ZdwC8NgIlShmscP6M5a8Dd8NI77546K/J9D0wS/6MNjasjvOySneqW+U/WdblU9rncU4ysrlI3pYbrsJeK6YZrI40ZDy7NL7RPpHPhf/RtccTkZ19HoBicdHusqHzY1PLUEn5JBJ06LSeJtoztYpSH1dpl4nq4UdM3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c3c42f-8309-4dfe-0052-08dec15f825f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 11:01:48.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swyzDa1rNB90gVhLS5AgTtPSHgYdPvhzj7/2cfZqZYMwMlftdKLout3q0nDS3xPdP6D3EcygOklPl9ZAu/O587RAsnm3YszttU6WEYwKTQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6777
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_040151_627068_3B80E901 
X-CRM114-Status: GOOD (  12.55  )
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

On Jun 03, 2026 / 10:44, Keith Busch wrote:
...
> > Shin'ichiro Kawasaki (2):
> >   nvme-tcp: move nvme_tcp_reclassify_socket()
> >   nvme-tcp: lockdep: use dynamic lockdep keys per socket instance
> 
> Thanks, patch 1 is applied. Please have a look at my comment on patch 2
> and let me know if we need to respin that version for it.

Thanks! I will post v2 of the patch 2.


