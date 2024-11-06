Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8507DD1CA17
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jUozKt5mGVh/WlgQonQq1D7/6IveJVu7x2NTBinhCUs=; b=BaKLmtuR99DN9uP3JFR3su71nw
	DZaG0G6Ugpk9GeKQe1EoEI3YJ+8eRS2MIM9YV+AB70FAyI6NebHRUT/d3bYakvPuzwO/RX867pjLE
	J/OS4fZwh75TumolarsTk1zPxGDW/LzgkL/mhP9YiKfNF9eWERFxuN3ohCXzFG0e23gkJ4vA8OZzr
	J2FVQv0ZzyzktE8sSMph9qT41Qay4ARHEhAMQHAhFrHxiLU9Zt5/WnA62LyRk9TBI+Wc4Wf+hrIlJ
	Q5CAK3IFrda+2VeQ8S6neRqru5sVCRtHt9e4UylKQg87T/RguGhzCKYVUhy5KXPDf5hIGeosbCJtN
	xlcyvd0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YW2-00000001rI4-2tGo;
	Wed, 06 Nov 2024 05:23:38 +0000
Received: from mail-dm6nam10on20619.outbound.protection.outlook.com ([2a01:111:f403:2413::619] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YVz-00000001rFa-0aCr
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:23:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUca+M0ab+/9RuMRgxZGLF+cZC3H8gJzb3UkLYUtzrJo6vFKEoVE6oiXxflBhM4LpwNTmOW5ggFCcz2X8xkWXA5n/tKK13VnPgCdcSrvTqsXGxeH4sg+epN1VLB2QdHkMk1AOdNqO2UTijOBtRjZNVcSG2YsfFdMqxfcCg9m4LnNBR/z7U0vwfdQnosun2IADKmyp67NAtmlQ11ynwPkSXBk8LsrXM7IzDb1HOjjZSRGUkEEWtQTE0HpgAZ5e+udfOXVOTEIWDQZ3TowslDn6UswJ+VwKxFJ0T0XEM48QHlGRwBOtXPnTRLtNoR1Ed902JOKckqwGJOlIZmBjoWOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUozKt5mGVh/WlgQonQq1D7/6IveJVu7x2NTBinhCUs=;
 b=G/IHXf2ff6Jfe0w+sDrZndCd84WScQEN3vrmfOvjE0CH1HE3ni/rY/jrJ3WTY9D1UrSCcv+aUXnEZH+xPIExWh+3CYDzTUopFpCVrdIxzw6kaZuFWrTKS3KHvY7c8mzUwe9MFlXFNnSvglzzMuxWqbMhmpJBUPnkswiMWr9nhuCZxk1r73MxPNXUXHgk5l4h3OQrzP9rC2ACdpXXnSuvqEnskJGJgJ1hIStaje1j8KGGl1ZDJ+Yvdt22BDI6SY/sf7sBXuNIwK2rMEraoEB0DFPYKkTU7W88NE2oxBD901lfrpwCRT/R54pvCAjdCP8wcijgmbWQ9XrBO1nT//KjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUozKt5mGVh/WlgQonQq1D7/6IveJVu7x2NTBinhCUs=;
 b=M5WdZPDAYfjv4SwaoRTTQEZmT5kb/a2L3NvjkV0R713SPmDzcYQlPZNbZ0g3uX8wvVtLk3nfbeffro3xuxeEhg+cVagJmPxUdxTrxVgSx4YVIkRbPYEysDy8MKSLOvn3MjkPLG2NX1A1w71oJhX5gi3HjjLdGNVR0AiqbeLnhO9CXO81crn05w4OubrBMyUGMuvZR3GfHphUX9q2IJL2r52DJfArnP/ClOwq3QJLUbWbJpzX25HBtE+4RXbj6zCT8jl0iHOKgaGy8+ltpuvL0b50NwiaaSkFMscBMRDcGE3v2xo7sVRcv/ZWwmV2FLNb+QPCj/F3sUnrWuscNr36iA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 05:23:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 05:23:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "m@bjorling.me" <m@bjorling.me>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv3 07/11] nvmet: implement endurance groups
Thread-Topic: [PATCHv3 07/11] nvmet: implement endurance groups
Thread-Index: AQHbL6sZjz4KRC8uxEml++lklFWoObKpuLCA
Date: Wed, 6 Nov 2024 05:23:29 +0000
Message-ID: <392f97fa-9c68-417c-8ede-1fe1347fbdc5@nvidia.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-8-kbusch@meta.com>
In-Reply-To: <20241105174904.3612888-8-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB7088:EE_
x-ms-office365-filtering-correlation-id: 751987af-b5f5-4afd-737f-08dcfe23261f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dTE2dE11RDlhdEU0a2t4OGI3MVYwR1pTTnFCKyt0bnk3OWxrcnJzZ2Ivb0pM?=
 =?utf-8?B?UnQ4MXJBN0JuZjY4V1ZJbmFiWktIZTVjZ0NvY3FJbVMrZ2kwVVBDQWRRZ3o4?=
 =?utf-8?B?VVJCdXFISmg4OXE1cFRKMUZmcFNTYjNBL29SeE1SczVVQTlHNE1QSkZVUkFK?=
 =?utf-8?B?TE1mTStpWStnNW5KTllJa3pVNDMvd3VUSVJBeXo2bnlIWXhLYlhvV2pMRzIy?=
 =?utf-8?B?MU1oRkh1ZWNIUmNtWU9TNEZwMUs4ajdmVituU3QxbUV3WThLWVJqS1hXWlht?=
 =?utf-8?B?Nll5Y2pXMFVJVU0rbVdKMUtmenBFUVhvVlhLaU44NkpVbHErQlBUMDJtQ2Vo?=
 =?utf-8?B?MG8rUU93SFM2aTBaZ1ErSUlTeGtHZGZVcEhRWEFDY1U3cnBmU0JEb0J3QWh4?=
 =?utf-8?B?SFVXQzR2UXB2R0tHOUNpbm1uRDdoR0doVnF2QmRrM2JLOGxzdDh2bEZBRTha?=
 =?utf-8?B?bmswRXpKRVgvdnp5MHhFOEg2MWZNSitiL2tNcGpTL2pReEt3eXVEKzNrekNn?=
 =?utf-8?B?Z0lqbVNudXlubnpSQUZPWjhPalFPaU5LY2VZSytOVmtMeFAwbkVXZXZBVExY?=
 =?utf-8?B?QW5EMGN1VDAzN0lVTFcrRW9DSWhLR2t2VncyV1hleUlWWkk2aW9FeXo3bzBt?=
 =?utf-8?B?MmpwRVFoM2paS3RQRmhnRUZIbDZNdUxiNzJ2TkJERXFkTFlXcUxIMWdLZzcw?=
 =?utf-8?B?d2EyTy95cVBiSGx2ajU1aVNGdDVtOGV1Tkh1MUpIRWk2MlZiVWxVTzJKcUxU?=
 =?utf-8?B?dEdSSUdhampoQUdTN05TbkZrUzlzMWJOYzVkd3lqTUF5VjdHL09xbWQ1NmVh?=
 =?utf-8?B?QllaZmFsdjB4dU00aFhYbCtycnQ5cnFXajBJeU9OQXAzaEI4Y1ZvaUdnWTVr?=
 =?utf-8?B?enA3eFJFSUxZZGJHWlBnL0pTMUxiN3NUZnJRQ1NJUlR0NmtJRHZwWmFpWnBH?=
 =?utf-8?B?dWE2YTNVSElxTjhRU1pWdTljR1Q1a2dKaWRyV0tXcUtoM2toRURYSGFTVDRk?=
 =?utf-8?B?TEtLMExNbjFZL0ttRXo4cVFHcHZyUHVUTWc0VXc1ME10VkFmcGgvZTBxTTJz?=
 =?utf-8?B?anZ5bWYyWmtyVjN0QTJRaG51MTdMSitnSU9DN2Z4RnZTYTJUYTVWTURNblJq?=
 =?utf-8?B?MUVQc3ViNGovb0VhamcvZFplSHJPS3VDVy9Fd2Y0aFFwSUE5U1VUSHg1Zm9t?=
 =?utf-8?B?a09QRGJtR1RXbm8rMVJRNHNDakdhZHQ4Z25XamR6UVZrUjhiUnpSQmpEeVNK?=
 =?utf-8?B?Ukw4UTl0MlFVVVhjLyt5VGVjUnV6dDd6VXFDYWl3UDlBanhyeTBEWXFEbzFN?=
 =?utf-8?B?YWhIbzc1VjJ0d2JnUG84VkRpb0p3R0NHa2lIVUc1dzlRd3BCT0VEb0MxSGNS?=
 =?utf-8?B?cVFJRDF0Z1RlMXJlVXZRYmFpa1NTVU4vVGtTRTVHL1Jsb1UzZExaOTRxM2di?=
 =?utf-8?B?dEhtTng0N3Yzd28rM1YxbnQyVFJYcHQ5U2VPYUJneHdaUkRmWU1JQnBWRWk0?=
 =?utf-8?B?eEtodUFUN1YzajAvb3pOMDQ4WWpLZHREVUZKSTZvZUN4RGx4akZBdUk3YU51?=
 =?utf-8?B?Z25sWXdRQ1o3SWtma1JUVTROcUt6aXFxTVVodnJYNTl5cjNYaHNZTC9heGhN?=
 =?utf-8?B?akRWQVNpd2kzdUJrTHp2S01HVTBabEFyWGl1NDFteHRGSGlwOWJQUjl2QklR?=
 =?utf-8?B?Sk0zS3o0RDU2a1JGeGhIbGRYTGttU2dGU0gvbkQycit2SU1EMk9oaUsyV2Fk?=
 =?utf-8?B?aUNLd211ZkdqMUZNYktaQ3EwNktoMmVrMy9TVFNaV0xWbHdUZkp3NEZ6VFhs?=
 =?utf-8?Q?zFLnDguq3fTfDi6Tk4We8GzRQW3Ro5sWyLY6o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2RMMW85eE1VS21Kbi95U0o2b2VjSnZWMnplUHJRcWlRckxhamFtazRsWXdy?=
 =?utf-8?B?TG9OamZQL2l3UVBteFJrLytPOU1GSEpMOW1Va3c5d0dZYWhMQnZkd05HUTlm?=
 =?utf-8?B?UDdXMjFHMG1iU0VQYkx1WHFmSFJaMWgzOWVoa3NPVXJyeC9BREZlbkNHTmFt?=
 =?utf-8?B?Qm5PZ29HWnYzc3lzNE0wSnRkQndYNTdIbERTaGIxZjYxbFBtMFI5bHpBN3R0?=
 =?utf-8?B?MVlmZXBrc3VaK09BL0UvL2U1bkN6RmtPRVh2RU9lZDJncFF5QTB1bVdxa2R6?=
 =?utf-8?B?NCt0bG9za1JGVTFyVmhRQzlqeDhVYzhJN1orcGozYVlrMUxCakMyRUxCVzQ4?=
 =?utf-8?B?bTIvU3Fpek9NV1krRXdUZFhMdzBJQityOGxQbjFVU0tqZzlLRmVsWmoreWxM?=
 =?utf-8?B?dHNYc1VBelkrM0g4VTJzcU0reUNlclZEZlBseTFzazRvNFN0cGZJWkJHWGJP?=
 =?utf-8?B?UVdjbkw2WFpFM2pDMU11bTBBYldrSU9yQVNBRWY4OHZnMk1Qcm9WeDdSM29n?=
 =?utf-8?B?MGNFNmp1cUN5T0hUaW4zd0p4YjROTTBUa3Bzakl3TDEzZVBXRHlYNFRlV3g5?=
 =?utf-8?B?WjJFQ1c2SmtweUM4Q0NXU1lyNzdHWlRkMEx5WTNUcnhXY0wrYmVlS0JrcHRY?=
 =?utf-8?B?aDZJbzRPWkM3RXd6L3ljRWZCZWNvc2YxQjhWQ2o1VmNldHMzdEY1KzZRRzRa?=
 =?utf-8?B?c2ZKVnEraThHcUxZK3huZ1FnRzVqeTFZMC9CclFCTmlRWFQrZHJ1ZkxPTTF5?=
 =?utf-8?B?QU82WVFUTEJYZk8yd2dzOEd1bnFrRWlINE45akZ6cFR6S3pkRVUwYUYya21k?=
 =?utf-8?B?eXJ0QTNQVDhaNVBRQVAzTUZtdHR2ZG0yV0NvVlVSNGxSdkd5cm15UE1jVExs?=
 =?utf-8?B?NDNZZi85Uncza3ZCOC8rcEN3L3EwL1VHRDNQMTE1ZkJDTE50ellWUWs3Qlhz?=
 =?utf-8?B?Z1p3UU1VOTdFZ1h5eDBzRVhGbXhYV1FWVzNBekpvSTNDczYvSFFYWndCUTcw?=
 =?utf-8?B?cWVvNnBZZWE2UW5KVktlUllJZFVyWFlxVlhPcUM2b1FxVGpVdS9PRk1lYnk4?=
 =?utf-8?B?MFdwWE8rK2pnODY0RitqelE0RHhqQ1pERHFENSt5dUtWMDdhL0FQeXRxcmpB?=
 =?utf-8?B?UmJjTDdMeVBRU2VJQTFQM2F5OW9ORDREZTFsamtKL0c2Si95V0JWLyszT0dj?=
 =?utf-8?B?azdpNDdBbUw4djhVTVZZNkZVQnVuekp4Zkl3Z3Nmc0ZOZGgyWndnODNVWkE3?=
 =?utf-8?B?bUdEZW9qQlp3b2Z0T1dtSVZGSVVaaVdQTDN3dm8wWFVuZmdQWkpzb0pqNmk1?=
 =?utf-8?B?QUhOZ1JiRG9RTTd6eVU0cFJjWWtJTkY1Q1ZyOU1Ub09ySlBHaXpUK2UwZ3ZU?=
 =?utf-8?B?RHJ6WCtZSmVQakFaZ3VYMHU5c2ZvZ2x4eTZCR0E3Rjk3c01DK2ErNlpGakpv?=
 =?utf-8?B?MkllcXBFMVZsdkdXUHViaWJrR0kzSE0ybDVSYTZ1TlNyWHVEdTRtd0oyUlJG?=
 =?utf-8?B?d3ZpOVF0WXJQaWxYN285bkFGMkhYNGgxTkc3eHM2bkR0NDFoZUorL3pBVm1Q?=
 =?utf-8?B?K1M1MllzNzNaMEk4alJiUHAzNjkyWWlnUjVGOWoxZXBwWm95MURaK0tuUmdZ?=
 =?utf-8?B?dVZSUGFhdk9VcGkvVzVzc1A3ajFJTFRwbGRZZ051cG5FVkk4R29BMkIrQ1U2?=
 =?utf-8?B?SkI3ckZ0bVc0WG10SmRlenNFU0Q1dkR2SS8xQU0wMjczTzNxaGpnYklISkhS?=
 =?utf-8?B?MEwyRzNtTVRDcjFqN0VWOWZnVGRhbzFvZ1BuMUdEV1h2TmZTMFRBSnptYlRT?=
 =?utf-8?B?WHJ5RnpOeW1nc3J5U3JxYWs0WEFkUStxNFEyWDV6NTdWa0t0Y0JYYlpTZUJr?=
 =?utf-8?B?eWZ2bDRtcDAzdnZ3Y3BoR2JWaEp0NlZKd2JsZGJZMDFvVm40UUowM0pFREhU?=
 =?utf-8?B?Y0dTZDJVd3RVVDdaWjRvSnp1MXZBSHJuRU9MRzNReitVdGs3dzhXa3JmZ25l?=
 =?utf-8?B?a3N1My96aFZPVUZ6ZStab2FZbWwrWjFuOStpSytqS0J2aDZJSjF6VStDclU5?=
 =?utf-8?B?a1ArN2lNaGw0a240c1YvYW5DZFhBbnlJb2FaSTRCelI3SENzZmZnZlJhNUpl?=
 =?utf-8?B?eUY5QjlBR3JQSkozTE4vY0lPQlppSDZnNzZmaXRCTURMSWoxM2Q4ODBkU08w?=
 =?utf-8?Q?CrTr1ToCOhytzuo0eqB1u4o452vBekX6vxsXm+ZyZ9vj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <845BC29E7EA0C043AC0DEE855B69979E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751987af-b5f5-4afd-737f-08dcfe23261f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 05:23:29.6166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQcf4zHa0RY9R+W8j2JiZLftLd8IWfehu///0exH0ESuO0JJ9vqxTCudA1xz+CYXz6MNodBAuLkEGOQ48QE6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_212335_224905_6F9FD32E 
X-CRM114-Status: UNSURE (   8.54  )
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

T24gMTEvNS8yNCAwOTo0OSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gTW9zdCBvZiB0aGUgcmV0dXJuZWQgaW5mb3JtYXRp
b24gaXMganVzdCBzdHViYmVkIGRhdGEuIFRoZSB0YXJnZXQgbXVzdA0KPiBzdXBwb3J0IHRoZXNl
IGluIG9yZGVyIHRvIHJlcG9ydCByb3RhdGlvbmFsIG1lZGlhLiBTaW5jZSB0aGlzIGRyaXZlcg0K
PiBkb2Vzbid0IGtub3cgYW55IGJldHRlciwgZWFjaCBuYW1lc3BhY2UgaXMgaXRzIG93biBlbmR1
cmFuY2UgZ3JvdXAgd2l0aA0KPiB0aGUgZW5naWQgdmFsdWUgbWF0Y2hpbmcgdGhlIG5zaWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaDxrYnVzY2hAa2VybmVsLm9yZz4NCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==

