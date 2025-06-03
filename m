Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73964C5B549
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 00:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFmr5Dh45WYCs32u6AY1Aq+xoX/fdoF3XOuJEEUg4yY=; b=NpkMWARScd56+1WaHAR/y8S9Ou
	AcKJuhjGK5/8usnTqrwYtyP32IuIMGCTqsi8OnLiuI9yH6YtK8q7EOXgciujjA5Ko0zkSDHyVY0Qk
	MyW/JRSY/oaigwzLlSsJYgmFdOOLnzCftXt7WTR3WAXcV2RrlYaaaW1+WN7w6CklN4H/SFEVgvaM2
	IVbApZT8pQ6IVynvhsat638z/vQDSebgT4TC5jzTIgIPBEeRacGZjRfIdVNz0RcEoFWXOp7tA/mdl
	L64DoiuJtfDemLvL4NOoNfNUskLdfVlfOGf4SOt46+eeIPOD4GpxBphvdaVDu6xGt7AIBZGEVSO/i
	uQq7w65Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMFsm-00000009RVI-2Asm;
	Tue, 03 Jun 2025 00:52:00 +0000
Received: from mail-bn8nam11on20630.outbound.protection.outlook.com ([2a01:111:f403:2414::630] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMFsk-00000009RUv-0TIn
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 00:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gmq+zGq5bRmlioAGWduBc+m/lxMMXktgueAZsoahV8Nws0oZcfPuBd+sWvqiASW0TfXn59lmBx1IUFLD/2vFBadX24ikQDRHNDDFPBzcqhwK1MSkFNq1Kl9mPBconpWqpF8Wb7ym1hXMzojj0Cumc8q++eE2J/FMuOr1ZnUT4/T+/klwSATZ1BLG53b2v1JsGW0CjfDdHdraBjoExPBfdYoUe33whSpvythv7hkvg9McfNGy4jeGaOojP/VTRDGHT9PUcI/ZZ0+sZZii9AK3IGoTmXjF+ZpgpOpi6RwU/Zkl4w2/iDn42PpgU/1h85Uc+fose5g7JSIggzBrNwFpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFmr5Dh45WYCs32u6AY1Aq+xoX/fdoF3XOuJEEUg4yY=;
 b=MKAcLrTkkGUODAOq1yiWfsiyXV4VzPMMT4E3w6X9RnUKZfHAzQmuYh/M7nsXdgpLWIMjbjjiqOoVeLNASdQSvTThVKxiJw0lJV953qm8znBJoyRFgZWyE9SNjAMny89nibqYgsbg5STE4jfs8E6Ft52ilw/I24kdg3Dh782AgLbu12lMHNKj7o1oGqJagIlhjCkmzCGWbHrHZitc1jaCTi8axQ2V5WEbYbLtBSgoDWudWyznV9Wu0bK2n4bEkwA1agG9EJcY/S1qZPRwwzgG9H6jc3xguyWRJlPD5+h3380smQlOIAfaFNe5jn59VcQ08dNTM4NlEm4YnPwh5iX6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFmr5Dh45WYCs32u6AY1Aq+xoX/fdoF3XOuJEEUg4yY=;
 b=ne/77+u4Dy9CHvBDGHzIoVorm675/97Z6f3aWAoFY4zp2GMIEU/0NqGE0wKHNgP44EMjJKfMFaCNB0P156XZDOSplshkwqmj2pA+LIukHwgY2IruJNiOOxv6aunpgfIDZ3h8DX/aRvktd3Q1doBliOnWT6GB2hhqaXy2z0xmCSAiPrdfiuL1/821iRCt9WbEvThL5WxFV+dZie6tqahLS+3qqvIuwJTkjbBQ5y0jqE11dY63oxNirDtPxz97ZIPGEGUHJctPRgMllfLo9enhGscJE2kXoK0xWHEQpfji0WxWo+HYNXiKnPHxHF6siDQU7LPamWUFcMO7Fjti2PlHRw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 00:51:54 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 00:51:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Tokunori Ikegami <ikegami.t@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme-pci: add NVMe controller statistics
Thread-Topic: [PATCH v2] nvme-pci: add NVMe controller statistics
Thread-Index: AQHb0L9dVMm1aJt2CkiA7Of7T4TKHbPwoeQA
Date: Tue, 3 Jun 2025 00:51:53 +0000
Message-ID: <66e31639-d516-4d33-b51d-eafc77697ef6@nvidia.com>
References: <20250529172954.5217-1-ikegami.t@gmail.com>
In-Reply-To: <20250529172954.5217-1-ikegami.t@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB8790:EE_
x-ms-office365-filtering-correlation-id: f6e4adef-0796-4ec7-eb14-08dda238d526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VmxHWWtUK3NCNDdqRkE5TXdQek5YUk5IUTVVNUhhQVNPYW55N2FKS3I4dUtY?=
 =?utf-8?B?M1JRclhZdkZKSDFaNUgrRlVZbkwzb1BUVXk1TUZRSFRJVG1tSThjWXEraito?=
 =?utf-8?B?amgzTWZRVS9SOVRFZk1GWFhDU1dzN3JwbTBRWjNkcmdXdXVYMXdHUExpSHhU?=
 =?utf-8?B?amVraFprOXFLZy8yN25SbjFPUWRrN2xzb0Z4aE9PNGhWMi9wSUsyVUFQaFZO?=
 =?utf-8?B?UWFlUjM4WVRoc0FsYXdiUStJUFlsdTRucy9CaVdWSk56SElTL3A3Q01ub3M1?=
 =?utf-8?B?S3l3dWdZeGhUODRkOXAvYi9xZjFFMDVUMm8xNmhXclYrZCtNb3c5YmxIVStu?=
 =?utf-8?B?aU44eUpxRXBXQnpqNVo5Y2NBcmVDa1F3c1hLQmQwajFpMk1mMTAyZUZtU01L?=
 =?utf-8?B?WUQ4OVRlb2dxaEd2ZS94OS9nNFBEU05GZitCNlNaWnJNK0U0dzJYa21na0xj?=
 =?utf-8?B?bCtudENKTWJwb1hpNlJEdnNnRkZUVGppQkhHY0gvTExHTTFMQ0JTbjJjakwz?=
 =?utf-8?B?dE00akVoRUZlUkZVK3JOWkJtWm1aN3hGUEhocmY0ZVZnZERZZ0NMYzZyMVpY?=
 =?utf-8?B?QitMNUpzdTZDVkhoM3M2czlENW5WVTZoVXFQWXdEd3hHUWRqNTFaNi9VS3pF?=
 =?utf-8?B?Sytob2U1dDY5UUZHaks1dWZmSHdCbVE5Ykt4bTFGS1RZSFMxSElWczZFd0Jp?=
 =?utf-8?B?MG9meC8ra2xncXRSQnB4MDFmMVFhemJuSmJkZllla2ZFZUVoMTU0N21MQkd4?=
 =?utf-8?B?c2lEcUF6QWttZTFWeVJFc2xIdnAweW9sdm4wVFF0emVNN3dRQ2JRZ1UwYlBQ?=
 =?utf-8?B?MEtSMW5oeUhlZWZXVDdlY2lkOXBHbU1jL3JkSXJMbWtTNFpCK2hvSmlGcm5k?=
 =?utf-8?B?bm1aOUxQNi9LQ2xjNjFIYy9QK0xXcG9KbDJXVmlzdnQranFTa2tlbkx3Mytt?=
 =?utf-8?B?VTQwMXNMa21kMnovUXFFaDMwQTAydlVEcDk5MnNoSm50RUUvWkxlRW5heUw1?=
 =?utf-8?B?bmFzS3dKUlRaYTBXMmR6R2t3Z1gzZWxWYUhIVklsTDZsb2xrc096R0N2Rko5?=
 =?utf-8?B?eU1RNnZjVmF3cURkYkl4Yno5REpJc1Z5a1k4SmJsRXNLQ2psQnFrTUVmMUtr?=
 =?utf-8?B?bTQxaVcvKzREUVY1T3JZMThENW0yczFTLzJMdEVmSkxFVzdRLzhFTFBXRUpO?=
 =?utf-8?B?TTJNVExyRWxReHJRVHRBcHNqYm0rUVFxOEFtanNXbHJsSGhNcXkxZS9LU0hC?=
 =?utf-8?B?ZjNlcGh4NExMNEdnRE5SVUJDcUU3NUxGbVdoOVcrUzBETFp6K3JZbjJ1R014?=
 =?utf-8?B?SnhLQjFiWnlBL3Q1dkZLTDF6TlZ6VkV0RzJlZ0o4QW1YaXdIbHJBVWFqR2JG?=
 =?utf-8?B?SzhaamFiWFM0eVZkc2duSFE5ZEVUVUFkNm5PTmd2T2FUblZVVCsxdkpSOUdx?=
 =?utf-8?B?STRReGtVWUNtdUVCaWlhRjdwV3BYeWNZK0tHbk55SnFyZmROZWhIQ3ZjTUxQ?=
 =?utf-8?B?U2RRU1NhTGdySm1nV2RvejVjZDNVSzN1cEJ0M1k1QnIyb0hJR3hERllkRkdP?=
 =?utf-8?B?VTJJTlpYVTAxUmtqUFdDNlFnL0FtUDVQT3hkSmhlbVEvZ05GTTJCb0xlYncv?=
 =?utf-8?B?ems3STFpbXhXWUpubUpTZ3EyQUZKNXYrN2t0WnFHRDFBUmp6enB3TkwwNVJB?=
 =?utf-8?B?T2FyUXJZd0JPWGhVS0lMekF1bVZkVlU2NjV1bjJrMEV4enBjbmlGSkl0bTVC?=
 =?utf-8?B?R3lVV09vTG5hUmVYbTJDcTFJS3p6SDhWTDVYbXd2Y1hVYmF5ZTdYN1hvMFcx?=
 =?utf-8?B?RDEwS2JJQm1kM3ZZcnpxVGZ1NkVQODhXaC9JN3BMUlB1eDZ0TjREUzlSNGRR?=
 =?utf-8?B?djF3eTNwZ2lIbGZpaEpkV2U0OW5WdmIxRVphRlhGaU9INmJsUm1QMElwSjZw?=
 =?utf-8?Q?SemztO8vSPotuVAuQPNv08tl+WTC6K3N?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHlMVHhoQ25pM3pwWlpJVUZXZ29yUitGN0owN25LL3JidlBwU0ZwY2Y3M2I0?=
 =?utf-8?B?cVZmR2t1MUZwSjJ6R1dJeit3QmpxRlNsNWx2UThLM0ZVd0JMZDRsYzlSbzlP?=
 =?utf-8?B?THNhTlBmSXgrZlVnTHdnU09ESFNGcmhJVndnL3JkamRrZHlZNlRuTzZhcmZl?=
 =?utf-8?B?QUVoVjBTVkw0aHAvR2hLbVB3VlNRVHNDbFJWY0FHa2lmZURTZ2RWdGNpOWtM?=
 =?utf-8?B?UXBOMFRBQUJHcURVbTdiU0VWb3dJb2tUYTlteDd5VUpXVHEzd2NiWmlmNXNn?=
 =?utf-8?B?WXR1dURZYTR3VFNjOXgwUnZ5RFA0UGJXN1N3SzR1MnJvaHNyeTlkbkJUdU1X?=
 =?utf-8?B?MEQyM2Niek1QNU5LalVXUnRtTHFHK1htSThRUTZuWFJESWl6VXA5WkpHYkdU?=
 =?utf-8?B?SjYrOFRCNG14TjRxSmJPYlRocG1wek56QllPclFFRjBCdVIxdVNJRElocnU3?=
 =?utf-8?B?UE1sR3FxR0JrWG9WK1g4OTI5MS9ocy81cnRORlNiaS9hbHE5Mkx2WWJVdUox?=
 =?utf-8?B?TkZkY282VXh2Qzd0WW16bmhEVm40VkVscnhRRGJYNU1rbW1aM0NvZjFrUlRD?=
 =?utf-8?B?eDBYYVVtZU9oVGQ1WVU4ZlhMa2lBVkdXeFcrS3ZPdUJ3cjNnM2o2aWtaZ0Rv?=
 =?utf-8?B?RU9iZkJnWVFpb3FHMkY5bWY1RngxSzd4aThpN3VjckYrVjZqVHduR1V0d0N5?=
 =?utf-8?B?K0FXVzFDVW0yZTlIR3NKUEIyMVh3V3JpVVpUVysraHpVYVVSRmNrVUtDRlZj?=
 =?utf-8?B?RjVCYmRrYkQvNnFSVG5RRlBGeUdGdWFlVEszUTdMalkxQ1VGUzR5OVVQSThW?=
 =?utf-8?B?VWFZU1lHdHkxMHNqNkNGd0RIOXh0UjdraysvZnNCZXc0SFQya3pOSHV5dTk0?=
 =?utf-8?B?d1FObUtRVnhJRmhTUDJFb3NMQ3hQRWpnNGRkSjlNeGQxbUlnZGF3QkJEOTI1?=
 =?utf-8?B?SHhQMDN4bk9yQXQ2OUl2ZUJ4aldkajR6TFFpK3BNR2g3WGhTUUJITmxRN25D?=
 =?utf-8?B?ZVAyZFhTbjNUcmxuRzVWbzJUTytsYjlCWFNTSFhqdjJrYS91SmhON2Q1RWdj?=
 =?utf-8?B?TFJXTGdPTTJCek1DUkxMU0ptR1hqbmJDZmk5OUZPQlZheU1TT3J3QjVobWdv?=
 =?utf-8?B?dGoxdklRTzZPNDBMb1RyRnBocFdRbTN1SGRHUFpKM0EyblR2bUZ4RHczTGhW?=
 =?utf-8?B?Sks3ZG1Wc3hqT3pQbXJicXEwR2lZMXRTYm43eEVqRXg1SWxTZFZPSUJDMVZr?=
 =?utf-8?B?eDFrZ1plQjJSSjBDZG5lMS9BSExYOHRZSHYxRXlJRlJrUGhwQjEvTFFhVTAx?=
 =?utf-8?B?eWdqazVNU3d2U0RaMUFrdDYxY1MwM2cvNWRxd0dFcnNTcEFzN051cHJVeGg3?=
 =?utf-8?B?d01sODZvYlhJaWFvLzRMVEd6NHBtb0hlZzhoZFRycXM4V0dTbDJxdmdNRWdn?=
 =?utf-8?B?a3QwZlVDV253SVpybFBBL3BMTXdoYnFCRGhLcTBaWi9XR2k2OHBKWFhWVzJC?=
 =?utf-8?B?SUFJUWNuVGRQYVNSeldCaGYxbHJUekhBWUhkZUJPcVNRUEg1M1pjdHVyd0g4?=
 =?utf-8?B?N1pCRVAyOHZlb0pkLzNQVFFrS0pLM1ZyOGE2b2s1NEdhQUdRb3BDUTM1STZm?=
 =?utf-8?B?UmFiQm85dnhydm16eTlJQWpEeGpha2l1eU94WkNoS2N6TXNXdUd3V0JVNjBs?=
 =?utf-8?B?QSthZEtsMWpiRFJuak5veDBqbmpLMEV6eVJ2ZEYxemVGbVkxT3EzMWtUWDAz?=
 =?utf-8?B?b215OTRqdnJxNkUwNUllWWx2eWJNT1o4MG1DZHFaY0htZXVWSC9Cc1d2R3F1?=
 =?utf-8?B?YXlnVDlXYTZTRXppeU9tZEt0aS8wM3BtSXIwYmVyT0N1V0dIcDdwUm1OaWQ2?=
 =?utf-8?B?UmN6VzIwRHdzUTh5eXdYTk56bXptQVB0Q25jQ0lqalY0VGVtVlRicGk3N1Nk?=
 =?utf-8?B?RUIwK1gyTXg0UTZVdGJrUzladmtKWnVUTXRXbUJzK3Jib3ZPWmhlNG5neDJu?=
 =?utf-8?B?S1BaTlFyOFNNRXdZcmRJNHh3V1MvSTZBSFhkbytWZFJkVDNLWlZEejhhSlZj?=
 =?utf-8?B?eWJiOHA3ZEV2RlJuL0tiSGJ0WUx1c1lKczlVZ1dsd0Q4MUl6Z2JCM1ZMVUNI?=
 =?utf-8?B?NXZ3UituRnRvNEtMSWU3Q1NSY1ZmdFlIQmpYWjdRTzhRalhzKytjVEZBWFdY?=
 =?utf-8?Q?3eUdlz1GdUNqw6855Ac/E88DiJb4k9nGO7emCmn+MS6M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D6190191037C24EBC3C16FA199FB6B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e4adef-0796-4ec7-eb14-08dda238d526
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 00:51:53.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvuFx2G2EURElFPbh3Wm8WG+EtJ/TpYdKdAuBDmwqbUtKygbJKD+4gMZhxEvLdLyCm+MegXqJhXjDDj9GxHE0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_175158_196717_1A353C97 
X-CRM114-Status: UNSURE (   8.65  )
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

T24gNS8yOS8yNSAxMDoyOSwgVG9rdW5vcmkgSWtlZ2FtaSB3cm90ZToNCj4gVGhpcyBpcyB0byBj
b3VudCB0aGUgY29udHJvbGxlciB3YXJuaW5nIGV2ZW50cy4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
VG9rdW5vcmkgSWtlZ2FtaTxpa2VnYW1pLnRAZ21haWwuY29tPg0KDQpjYW4geW91IHBsZWFzZSB1
cGRhdGUgdGhlIGNvbW1pdCBsb2cgd2l0aCB3aHkgeW91IHdhbnQgdG8NCmNvdW50IHRoZSBldmVu
dHMgYXQgdGhlIGZpcnN0IHBsYWNlLCB3aGF0IGtpbmQgcHJvYmxlbQ0KaXQgaXMgc29sdmluZyBh
bmQgYW55IGltcGFjdCBvbiBwZXJmb3JtYW5jZSBiZWNhdXNlIG9mIGl0ID8NCg0KLWNrDQoNCg0K

