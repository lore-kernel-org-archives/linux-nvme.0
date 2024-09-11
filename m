Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A85EE01F3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 05:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xWMuQ73ytd2okeszXVJKPD6mKFkyJwZpLTdxDr1pbEw=; b=Ngbw9lwOtScxHGdcGeXsKOBytT
	87QXJDstnxvJm5iQyao+gGKLFGZYn+doYyhd16lwt5sOt15TxULC46j2F0kkFqcP9pt8uATZ0W4kr
	kn/kvIRKgSBygxULITyGqtdew5UA37PLjkg5hR70pg7jK1vuGPFsCUKUzuyWK6bZXAypqLakcjgDl
	l4ciMQycsEwzL9HhyGhuMDX0+zp/qM6W0spWL1Y7rXvEF01wZfHvND6aLzpk33X1fFHYPMEVdr9vl
	Fkij423L4yqzFkLqiLNip273ryojtHpi6v9ZVh4HQs1wfKEBju0+9mXQHJt3hS0XomAKajQ0pp1Hk
	/QgW8DQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soGGe-00000008CCE-2XbR;
	Wed, 11 Sep 2024 05:51:52 +0000
Received: from mail-db8eur05on2060b.outbound.protection.outlook.com ([2a01:111:f400:7e1a::60b] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soGGY-00000008CBS-2ntC
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 05:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAcUSIO6Bv9SqRZ3M7DnoK/2aiIk7G8U9rky2i/1lkllCga01VnjdcKuE1cqLHIw0lni9o6ckNDDwwYczV1y/IuLB2cMNBlE2D0MHdEL29/sIJrwdMncmrhXxNG9yv7H1FVeLNZ3N0uYrrMc3BTsnR0qc+UsTmCL9fDlE2fpAYsGw1vuJRvhn/5UIcioA5rAESo9w1RVI8MqsYWxGExMrTj1lSioAyh3Il7C/MVR1swLCjw1TY1DGTCyhE8EJ2cDoMHjB1DHpEX7zM4RS4OyEfPwzG6W5y9jZum6u/EYFfudQVwBFpGNh0odgZy6wfy8HR65F+mxlxGyLrHnATZjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWMuQ73ytd2okeszXVJKPD6mKFkyJwZpLTdxDr1pbEw=;
 b=UlCJ5tMSEezp9BYoHZDAe0KOQ4CG834mDYVyWzLzMhZxL3hY9meid6KDS7ViEvLaNKM99x+3le1aPqbIYj5nJ5jKtw/TcyJq/Oie6sd1UdH2Sjq+2lx4m7bb8bn3AL3nNcYJhKTe6DsgsewuFcL1PVg1aC/kqZ8EKrZZpBE+JJSh2qHVKv6mLuJGHI8MmXHVOnIyZzJAshMDasZE8wyP1MiQ30XGMPGmGGiXUh7p5DroCOxT/W6w23qH2ws8bpHlsXZXFn2/ph4BkX9xPUHR9F7H/OQp1dWYRwrPbJLM/OtVoURFXSNkUuMYSTksLw659HbQze+jm4BJXylgmbBsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWMuQ73ytd2okeszXVJKPD6mKFkyJwZpLTdxDr1pbEw=;
 b=ypAgqDj8zwEesUo+ckq5x143eUi98TDyqIr/8NSiGDVO1TPXxgk5jfGAc+E5UIWLzHAp2/jlg9qLNSV9kdARWgLuKd8JPeluyWTVa0UIPG4VC25F4qYk5DbbtwC7grWOfDYWYUUO6r9bd0uLnr6RHGCGC2myx5PpDQkWUXEbH4IZmbnMpppC9tOygHyG6Pg0IkJnDMdODRjqXZCnFSUagfHEDOyIcTcI+CGJbhtYpcjdLAjtF5t/mu/Vc3nD/XkEIf7ZrD1EJzzz7qYC+2fI0AvcdE7WoN7NJbstQq6eSnBBCuMagnslOagG6PorNQeHebpPC8BKXfNbiZSeMC2B/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 05:51:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 05:51:34 +0000
Message-ID: <c1f065ec-c544-4191-85b5-e1bb01808183@siemens.com>
Date: Wed, 11 Sep 2024 07:51:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: stuart hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Nathan Chancellor <nathan@kernel.org>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <83f39f2d-7237-4880-83e3-1c3afc62087d@siemens.com>
 <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: 079e5f5a-239a-40e2-89f8-08dcd225cae5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWtXR215Ry9qZVMvK25KQ3VSQTdCKzF4WTZhbC84SlN6Nm5Lem9TYnQxdUJI?=
 =?utf-8?B?N2V1L1RSQlZOb0svRTUyM1dnS1FUMXRVN3A1bmM2cVdxbmxkb1ZRWnYwSVNn?=
 =?utf-8?B?WXlQVWpua3B0dmhYb1dxeDBQRlQyWm5TTUkzRW5XcWxDYlAycEVSVVQ1RUt4?=
 =?utf-8?B?UG92UGFQYkc0WDRwYW1NNkFtV2pKV0psRTBjZm5xcVkzYkdBYUVxbnZmeE16?=
 =?utf-8?B?Y3c0WTJSbkQwaVI1NndzVlBFdkducGpsMkI3c05kSzYrV2dYeThMczdNdVdV?=
 =?utf-8?B?bkU3RmJGc1pRWHVzTzFLWmRGOTN3V1h1NVRESkFhZWsxTUFFeDc5WFVDcmtx?=
 =?utf-8?B?MC8vZVdNOHppOVMxWXJXWEx6eVdBODNibDRqbnZsUlFxcFNVbFhMZUE5ZXha?=
 =?utf-8?B?NzZTQVU2OHpNZkNGNWEzeW5nT3hjRXBzb2hmb2Q2M3E3YkUrVXlDWWc1ZkUr?=
 =?utf-8?B?OFZlb1J5Z3lKVnI4UDFBaXFWRldtNHY3SmVQSnppRCtycDV0MjVJd1ZLTS85?=
 =?utf-8?B?SEhUeU03U3M5SkNwV0VBQXNLYWdKNTlqWFZhdTlsNnNOSUxsSDhtRHFpSGtr?=
 =?utf-8?B?enhhMTNseUErZWZNbzFIZ0xNWkVxVHVVcXJvWXZhZEFTZEVNU1FObmhBYVY1?=
 =?utf-8?B?Zkd6L2QxSno1S3phSmhIY0hKUDhWbVNmczRrcDJNeDU0NlRINWFNVDlIN2cr?=
 =?utf-8?B?S3A3eXcyMzB3c1JMZmtiV2luOW9acXVJQTZxS2tPWGp2c0pzem1QT2dJYkgw?=
 =?utf-8?B?L0dsNTI1bCtoRDBPUGxpVTVpQldQMDUrM01JVXpyeG9kSUtKY3VydS9HUXQr?=
 =?utf-8?B?Q0RaUzArMHM2QitDWGszSVpQK3I2VlNvZ3BUd0pPaC9ST2k1Nyt4NWtDd0px?=
 =?utf-8?B?R0VjM3ROUURweWxIQS9HRXZnbnFYdjJKQi9PMm93ejYxNjU3SXN2bnZiamxn?=
 =?utf-8?B?KzhpM0lyNXhmdnl2NFNNN0hMWC9Lc1lPQTUxa1doUWtOVVB0bklqZC90MGlJ?=
 =?utf-8?B?RmNoR2lNWXhWYWF5V294ZjFmMHdXRkVlY2tzUlFBMUowN1NnaEM1MmZ2QmdZ?=
 =?utf-8?B?ay92QzVUUFZ4SFZPa2E2YnJWYkEzWnZiSVZwODVJOWw1WUNBOTBLZE9qYW9J?=
 =?utf-8?B?bC93bUFCOHZ2cXdKa1cxeXpwTUdhclV3L1pDWmx3b0VtR3FtRCt5RndZYkpi?=
 =?utf-8?B?Q3ErTzBLRkc3S25EWTR6dk41eDZRNzJOay9YS25pVkJKN0ZmbURaSFR2dEZz?=
 =?utf-8?B?UFFXN0tsOVZETXprTUhKTS85TnFPK29JbDdRRkZoWXVUTDhqZlFDL01udEZq?=
 =?utf-8?B?NjVwWTRlRUZxbjhiU2JMWURrRVZQODZ2SFVVZjFYcFN3Z2JRTWxybVNFVTZH?=
 =?utf-8?B?bzl5RHo1Qng2ZGFQQmhJOEg5UHZQL1ppS3VmMEZZRHVhK2pGbk56alJqTkxm?=
 =?utf-8?B?ZkpDV0syUG1LWEVWOHNEbjZDakNSUVhsTDlvbE54TkJINjNESEI0RHo0ZVhP?=
 =?utf-8?B?eVhIY2dQT1NaMmZBTk1UdENJNVVqdHRSbUZLR3NaR3RWbHByY0MzYW8wR1NH?=
 =?utf-8?B?QzFRTVQxaFJjTjloSFJBMzdUMGF1MFBoUnh4b0cxNEZvSnpEMXo0S1RwVE05?=
 =?utf-8?B?UnhTdzFNdGdSWFhmS3lMbU8yek9YQzlvNy81eVM3ci9wOFVqN2hybzdiYmxo?=
 =?utf-8?B?WVNxanBrMG5vMVdpSkljWGhReGVhODBYNzBjKzdRU3k3UnJMOVJjOHVOenJS?=
 =?utf-8?B?U2lMc1QwVWp4RWF1QTBLTVd6OHhZakxIQTVXU1oyS0Q4SDdJcDhZVk5yZlBW?=
 =?utf-8?B?ZUJhOW5RMEUvelRrTUZ3WU9jeTBVdVRJaEczNGwyUmlicjl1cW8ydTdIVU1T?=
 =?utf-8?Q?//BYh1z1ky401?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJZd3UvVDZNRzkvOHV3MmtCK0l4L0x1cFNCOVNDZUlvbm1XS0gwdlA3L202?=
 =?utf-8?B?c2FNanJ2b1VEUVluSGorektLYmpqVVRIcmRrZWxWNE44WHNmczhCckd5TkZv?=
 =?utf-8?B?QWZES3dYcG5ieG9RdXV1VEJMRUw5b1VrRGg3b1ByTVZqOSttUHdxa2NQWTlW?=
 =?utf-8?B?MmRLVFJmeTgxWTFqMWNGSWZQNk8wQkdNcEo0bVk1czJyem5YNE1Fdm52bjVT?=
 =?utf-8?B?ckR6VXZUY0pQTjZhaW5yMFpndEM2TUdtdEpqM3R6Q0hTRFdCQXZGQXQzMnBq?=
 =?utf-8?B?SWp5NXFtRXJ0VXVOcmlqWnFLRXlKdi9rR1BtRnUxQXlNSHpjUEZ5WVZhUDdQ?=
 =?utf-8?B?SGI1RmZ5clkyVjhrU0VlWVhHWXNESUd5ODZldWVDZTRKZHl4cFJib05EeFNH?=
 =?utf-8?B?WjB6NzBYM0VMamJXLzZzTEI1OXdoOGNsWTFIWERHMXhVRFRBZHVSTFA3OVNw?=
 =?utf-8?B?TmdXeDJiUjRKS0FRQkpaRU8wSTR2OG9lUzVBNHRJaksyd0RiWU10ZG51NWhK?=
 =?utf-8?B?dmdOYVJkUGp6T1o2QVo3RE56YklnZHVpNUt0Y2g3MXF0Q3VjVHh0d0dWdVlw?=
 =?utf-8?B?b21wamxDNFc2MVQ3NmwrNlN5SG9TYmJKL2tzMEZuUURheVR0U1ovWFE5TEND?=
 =?utf-8?B?QnZocnJwMUlQMEdLcUhLZmxZaXVXeHdkYmhGMnRlZVRxMW5PSmFYQmJORXY1?=
 =?utf-8?B?SXY2Rk5kU2xlWHptbDJ3UnlVeGwreTZGK2lVaDJGd1o1elE3OXB2ZU8zbmZE?=
 =?utf-8?B?WjE5K05ZSWIrOE8zK3I5ZGpsRDNjZ3dKSkMrZ1owNHpUZ3FvVlNUREJ4NERJ?=
 =?utf-8?B?N0dIaDBXQ2p1dE9yN09JMHNQaE5wZFU3YW53SjR6ZnBGMWJqaG4ybTJPUnEv?=
 =?utf-8?B?bmxCWUlpdUxPUUhlV1p6Q04vMzJnUE56TTF0T2Nsand6R0NrMkpleEhkcGp5?=
 =?utf-8?B?OFZSUEtaMW5DNUtwSVBSNTU3M3I0MDRMUFNvYW5XYVlZVFNYWVpLcisyUzFn?=
 =?utf-8?B?ZjA4TXBlSTRiRncraWxHclZPQjl4OTdqanpvb1luRTN3NGpwbTBQaHA4RmVk?=
 =?utf-8?B?Q3RLcVExT21pcjhjbmd5VjNKczJkaktrRkJHeXFEc3JPSGI0Ry9YazJVcUND?=
 =?utf-8?B?aFdtV25FdU85Q3YxY1RUb214c3hCWmdXeExKQXZpT2xkQ1ZPSWJ6MHB3V2V0?=
 =?utf-8?B?M2k3SGJkMm5veDlvUEtmOVdNNnVtR2VhOWVUaVNzcHJ2dW52K0FIRG5rMUdt?=
 =?utf-8?B?dlhjQ0N0N3ZPUyt5OSsrNmdYV3pkS09OVW1haE8zWTdDdS9lZ1Y2Qjh1d1l5?=
 =?utf-8?B?N2lwOUV0TnkzN3lCRXFZQ3NOS24xOFhJTDJsazFSQWNISWxQei8zc21TU29m?=
 =?utf-8?B?L0Y0alhmdkY1RVR0S0oxekc3VElCK21oQThtUXBaOVo3amEvQXZpMUFZd2Jk?=
 =?utf-8?B?b3NlV2pRNXQwQ3VkaUp2YUNzZlhrblFPeENZLzJBYUJsRjEvYkdYVlpNZzVF?=
 =?utf-8?B?ZEQzdXN6MGtCdGJBakpseDBERzdwejc4eUV1ZGQrUU1NbElqUjdTS0ZSMDRY?=
 =?utf-8?B?SGkxL1dNcmpWbmVrZ2hNNW5kdzlZZjVHM01VRjZBaVNoY1o3Z2NYcTNmNE5L?=
 =?utf-8?B?bmJRTngrT2EzcXZUSzBVVmJtVnB2VGNZOHFJU2phVVVISHRMRml1bTAzd25Y?=
 =?utf-8?B?dkFvVUtEZ3U4OEpCTXZLU0NBcmhCSVNpanVwKzZqQy9hS3ZaaTFEV3RtREN1?=
 =?utf-8?B?dFB5YU9SblprZEk5VlVmcUJUN0VWbDIvcmlJRmgzdm5IQm9ZT01SNWptczA2?=
 =?utf-8?B?OFJhdml6a2pOVFFZWnd0Y1FoRVZ4VHlEYXNMMFVJbDRDOXRaT1ZRSVVnYnNT?=
 =?utf-8?B?clVxY0hIZzRuNER5MHNFRlJoS0NJQlgrOUtvYnJ6TG1MYnJiODZSelNVemlN?=
 =?utf-8?B?cHlpeFRiR3BFZnNLNWY1SFJBVFRBQW96TE9FcmtReUk2Z1RObklpS3N3Qjh6?=
 =?utf-8?B?ZGErbG5tMUE3azRMTHJ2SGk5RFlrS3k2SzNLMjdoWEZSUC9aSjJqWWhSM3BO?=
 =?utf-8?B?M0hjRjRuZEsxbkRjaEI0UEtPdGlPa2kwSUtoL3dZTys0dmZ3RWtUTU9uRnFC?=
 =?utf-8?Q?94G0DnxgwCI0M8PwuyXglGQdK?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079e5f5a-239a-40e2-89f8-08dcd225cae5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 05:51:34.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSjvOQR3eh4M75wvsaWrtcrwZ24t0jsT7CLjSR9j/SqWvyFuRlDKkzjeaMw4AhwdTUUtsTvzW5Ur2v8JlZgQ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5365
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_225146_943675_C25A339D 
X-CRM114-Status: GOOD (  16.41  )
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

On 11.09.24 02:14, stuart hayes wrote:
> 
> 
> On 9/8/2024 8:36 AM, Jan Kiszka wrote:
>> On 22.08.24 22:28, Stuart Hayes wrote:
>>> Add code to allow asynchronous shutdown of devices, ensuring that each
>>> device is shut down before its parents & suppliers.
>>>
>>> Only devices with drivers that have async_shutdown_enable enabled
>>> will be
>>> shut down asynchronously.
>>>
>>> This can dramatically reduce system shutdown/reboot time on systems that
>>> have multiple devices that take many seconds to shut down (like certain
>>> NVMe drives). On one system tested, the shutdown time went from 11
>>> minutes
>>> without this patch to 55 seconds with the patch.
>>>
>>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>>> Signed-off-by: David Jeffery <djeffery@redhat.com>
>>> ---
>>>   drivers/base/base.h           |  4 +++
>>>   drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
>>>   include/linux/device/driver.h |  2 ++
>>>   3 files changed, 59 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>>> index 0b53593372d7..aa5a2bd3f2b8 100644
>>> --- a/drivers/base/base.h
>>> +++ b/drivers/base/base.h
>>> @@ -10,6 +10,7 @@
>>>    * shared outside of the drivers/base/ directory.
>>>    *
>>>    */
>>> +#include <linux/async.h>
>>>   #include <linux/notifier.h>
>>>     /**
>>> @@ -97,6 +98,8 @@ struct driver_private {
>>>    *    the device; typically because it depends on another driver
>>> getting
>>>    *    probed first.
>>>    * @async_driver - pointer to device driver awaiting probe via
>>> async_probe
>>> + * @shutdown_after - used during device shutdown to ensure correct
>>> shutdown
>>> + *    ordering.
>>>    * @device - pointer back to the struct device that this structure is
>>>    * associated with.
>>>    * @dead - This device is currently either in the process of or has
>>> been
>>> @@ -114,6 +117,7 @@ struct device_private {
>>>       struct list_head deferred_probe;
>>>       const struct device_driver *async_driver;
>>>       char *deferred_probe_reason;
>>> +    async_cookie_t shutdown_after;
>>>       struct device *device;
>>>       u8 dead:1;
>>>   };
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index 7e50daa65ca0..dd3652ea56fe 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -9,6 +9,7 @@
>>>    */
>>>     #include <linux/acpi.h>
>>> +#include <linux/async.h>
>>>   #include <linux/cpufreq.h>
>>>   #include <linux/device.h>
>>>   #include <linux/err.h>
>>> @@ -3531,6 +3532,7 @@ static int device_private_init(struct device *dev)
>>>       klist_init(&dev->p->klist_children, klist_children_get,
>>>              klist_children_put);
>>>       INIT_LIST_HEAD(&dev->p->deferred_probe);
>>> +    dev->p->shutdown_after = 0;
>>>       return 0;
>>>   }
>>>   @@ -4781,6 +4783,8 @@ int device_change_owner(struct device *dev,
>>> kuid_t kuid, kgid_t kgid)
>>>   }
>>>   EXPORT_SYMBOL_GPL(device_change_owner);
>>>   +static ASYNC_DOMAIN(sd_domain);
>>> +
>>>   static void shutdown_one_device(struct device *dev)
>>>   {
>>>       /* hold lock to avoid race with probe/release */
>>> @@ -4816,12 +4820,34 @@ static void shutdown_one_device(struct device
>>> *dev)
>>>           put_device(dev->parent);
>>>   }
>>>   +/**
>>> + * shutdown_one_device_async
>>> + * @data: the pointer to the struct device to be shutdown
>>> + * @cookie: not used
>>> + *
>>> + * Shuts down one device, after waiting for shutdown_after to complete.
>>> + * shutdown_after should be set to the cookie of the last child or
>>> consumer
>>> + * of this device to be shutdown (if any), or to the cookie of the
>>> previous
>>> + * device to be shut down for devices that don't enable asynchronous
>>> shutdown.
>>> + */
>>> +static void shutdown_one_device_async(void *data, async_cookie_t
>>> cookie)
>>> +{
>>> +    struct device *dev = data;
>>> +
>>> +    async_synchronize_cookie_domain(dev->p->shutdown_after + 1,
>>> &sd_domain);
>>> +
>>> +    shutdown_one_device(dev);
>>> +}
>>> +
>>>   /**
>>>    * device_shutdown - call ->shutdown() on each device to shutdown.
>>>    */
>>>   void device_shutdown(void)
>>>   {
>>>       struct device *dev, *parent;
>>> +    async_cookie_t cookie = 0;
>>> +    struct device_link *link;
>>> +    int idx;
>>>         wait_for_device_probe();
>>>       device_block_probing();
>>> @@ -4852,11 +4878,37 @@ void device_shutdown(void)
>>>           list_del_init(&dev->kobj.entry);
>>>           spin_unlock(&devices_kset->list_lock);
>>>   -        shutdown_one_device(dev);
>>> +
>>> +        /*
>>> +         * Set cookie for devices that will be shut down synchronously
>>> +         */
>>> +        if (!dev->driver || !dev->driver->async_shutdown_enable)
>>> +            dev->p->shutdown_after = cookie;
>>> +
>>> +        get_device(dev);
>>> +        get_device(parent);
>>> +
>>> +        cookie = async_schedule_domain(shutdown_one_device_async,
>>> +                           dev, &sd_domain);
>>> +        /*
>>> +         * Ensure parent & suppliers wait for this device to shut down
>>> +         */
>>> +        if (parent) {
>>> +            parent->p->shutdown_after = cookie;
>>> +            put_device(parent);
>>> +        }
>>> +
>>> +        idx = device_links_read_lock();
>>> +        list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>>> +                device_links_read_lock_held())
>>> +            link->supplier->p->shutdown_after = cookie;
>>
>> This will not fly if a supplier registered after its consumer. As we are
>> walking the list backward, the supplier will now wait for something that
>> is coming later during shutdown if the affected devices are still doing
>> this synchronously (as almost all at this stage). This creates a
>> circular dependency.
>>
>> Seems to explain the reboot hang that I'm seeing on an embedded target
>> with a mailbox dev waiting for a remoteproc dev while the mailbox being
>> after the remoteproc in the list (thus first on shutting down).
>>
>> This resolves the issue for me so far, but I don't think we are done yet:
>>
>> list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>>         device_links_read_lock_held()) {
>>     if (link->supplier->driver &&
>>         link->supplier->driver->async_shutdown_enable)
>>         link->supplier->p->shutdown_after = cookie;
>> }
>>
>> I wonder if overwriting the supplier's shutdown_after unconditionally is
>> a good idea. A supplier may have multiple consumers - will we overwrite
>> in the right order then? And why do we now need this ordering when we
>> were so far shutting down suppliers while consumers were still up?
>>
> 
> The devices_kset list should already be in the right order for shutting
> stuff down--i.e., parents and suppliers should be shutdown later as the
> device_shutdown loop goes through the devices.
> 
> With async shutdown this loop still goes the devices_kset list in the same
> order it did before the patch, so my expectation was that any
> parents/suppliers
> would come later in the loop than any children/siblings, and it would
> update
> shutdown_after as it went to ensure that each device ended up with the
> cookie
> of the last child/consumer that it needed to wait for.
> 
> However, I missed that the devices_kset list isn't always reordered when a
> devlink is added and a consumer isn't dependent on the supplier (see
> device_is_dependent()).  I have a patch would address that, and add a
> sanity
> check in case any devices get in the list in the wrong order somehow:
> 
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b69b82da8837..52d64b419c01 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4832,6 +4832,13 @@ static void shutdown_one_device_async(void *data,
> async_cookie_t cookie)
>  {
>      struct device *dev = data;
>  
> +    /*
> +     * Sanity check to prevent shutdown hang in case a parent or supplier
> +     * is in devices_kset list in the wrong order
> +     */
> +    if (dev->p->shutdown_after > cookie)
> +        dev->p->shutdown_after = cookie - 1;
> +
>      async_synchronize_cookie_domain(dev->p->shutdown_after + 1,
> &sd_domain);
>  
>      shutdown_one_device(dev);
> @@ -4898,8 +4905,11 @@ void device_shutdown(void)
>  
>          idx = device_links_read_lock();
>          list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> -                device_links_read_lock_held())
> +                device_links_read_lock_held()) {
> +            if (device_link_flag_is_sync_state_only(link->flags))
> +                continue;
>              link->supplier->p->shutdown_after = cookie;
> +        }
>          device_links_read_unlock(idx);
>          put_device(dev);
>  
> 
> I'll submit this shortly if nobody responds with any issues with this.
> 
> Thank you!
> 

This sounds widely reasonable to me, and a quick check confirmed that it
apparently resolves the issue I was seeing.

I'm still wondering, though, if overwriting the parent's shutdown_after
and only checking later on in shutdown_one_device_async is sufficient or
if it wouldn't be safer to have a check when we write. The fact that
there could be multiple children for a parent is worrying me.

Jan

> 
>> Same overwrite question applies to setting shutdown_after in parents.
>> Don't we rather need a list for shutdown_after, at least once everything
>> is async?
>>
>> This needs to be thought through once more, I guess.
>>
>> Jan
>>
>>> +        device_links_read_unlock(idx);
>>> +        put_device(dev);
>>>             spin_lock(&devices_kset->list_lock);
>>>       }
>>>       spin_unlock(&devices_kset->list_lock);
>>> +    async_synchronize_full_domain(&sd_domain);
>>>   }
>>>     /*
>>> diff --git a/include/linux/device/driver.h
>>> b/include/linux/device/driver.h
>>> index 1fc8b68786de..2b6127faaa25 100644
>>> --- a/include/linux/device/driver.h
>>> +++ b/include/linux/device/driver.h
>>> @@ -56,6 +56,7 @@ enum probe_type {
>>>    * @mod_name:    Used for built-in modules.
>>>    * @suppress_bind_attrs: Disables bind/unbind via sysfs.
>>>    * @probe_type:    Type of the probe (synchronous or asynchronous)
>>> to use.
>>> + * @async_shutdown_enable: Enables devices to be shutdown
>>> asynchronously.
>>>    * @of_match_table: The open firmware table.
>>>    * @acpi_match_table: The ACPI match table.
>>>    * @probe:    Called to query the existence of a specific device,
>>> @@ -102,6 +103,7 @@ struct device_driver {
>>>         bool suppress_bind_attrs;    /* disables bind/unbind via
>>> sysfs */
>>>       enum probe_type probe_type;
>>> +    bool async_shutdown_enable;
>>>         const struct of_device_id    *of_match_table;
>>>       const struct acpi_device_id    *acpi_match_table;
>>

-- 
Siemens AG, Technology
Linux Expert Center


