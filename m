Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84030C021A0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOMbVsFYS3u8HZm/TkUmtEgcmW0L1FUes+T7OCVdA+0=; b=awrJVFhVEUjWMYEczYTqiF02wo
	XKAzkSTrfkWITope6Mjj59K+iTmXuFLNy3xbg2WZvThvnUz8tHxC8BIGxsXU8fSsRJGy8mXaNZQPx
	VyqiQJsxX/D/+kc4Hi+IxJPKu5zBFPeMdKrWFiERdjcmbJSwGqo/F+IdnRPkMQzRDA+6S0ttrLBwy
	D87OvRq5hR/YMRX1UgDNudr6wLShYnK69oHvoYq2rzS7iX/UX1kDWrTSukiKPi55w2W73bHV2qiRp
	LkxiNFkDumxZefU2tTAujjMVmHVJaG+kYCZOtU1ijlKGtLNNyLU4MY6WGQUk3po1bk5ed6XM78neF
	TuG3dyew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiduc-0000000CE7u-214l;
	Thu, 13 Feb 2025 18:26:10 +0000
Received: from mail-dm6nam10on20609.outbound.protection.outlook.com ([2a01:111:f403:2413::609] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tidG3-0000000C3h6-0B9X
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 17:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKWjYrMlc5EfJ1D/Oy3qyFJ+yb0cJiJIkfNdSlKzOt4LSWIGvnGhBgd3go82P0c20+AK98Qd/DPGtMOaMMpR6ktouzYaW82vyQ/nsWaANp9B1ofmQ7fN96Um8icq+bEao3NJaSQ1I9t3mO37s0KLRwr75LYhk8mb754kER1iNIcS5emg/pJKWpf3OsZ2VZfFAGpdGSZnczz1cGXb6nbXiaV4dlTVdG3OPgeoAeScvZcvbObln+6p9x1OVEbEN/RhE1JWB7cX3MJ2Angs/y5arLSq1Ri4oVnNoC1i5PcZv6xIVtR7Dryq4weptZruGHDjUxjhyJgeQpML5yS0YDsmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOMbVsFYS3u8HZm/TkUmtEgcmW0L1FUes+T7OCVdA+0=;
 b=VAindiTT+Z9V/WaLlmzSXPOLsMkHDbzkrv8fOijezb7boDHQSfFgnEuVsPTzJ9dJbH5FMCy6G8XY1rICfvwGP/TJI0tdJTfDuYYcCAJq+vdmD/Z66IrRR3VwL7yHlP/owL6caFpRBQ340EZRXF4km86VJiUNQnksJgMIBSxfj1+0YjQyC8yVABjZOUAKUuNG+DrSUvYX7rU+Ec3psZNGT4kMZ0za8tL+7BuEsB/wgXGfKXUtME1DRBPtx4Bc8c7JdOhuIKqpdDXumPSWvP+3tkDi/hILwWTpQqRWY6hb1ooSu1+FJAVdSmnoyMZAn7P+96X9od7rUHJqueFNp/GfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOMbVsFYS3u8HZm/TkUmtEgcmW0L1FUes+T7OCVdA+0=;
 b=W/EF7OoXp/GM154gSanl0ZgjXdGNq/d59sThfCg0WPYIr+irwT+bCjk27pk6c9tuJOXeILzHc13KtAdH0HCkXA5nswuys4+OvqfPi12UJS6180oKKdr4zPCMJC91mGXX22Ly6jJStkYUqWwvJWlO34jjZaV0L2WiwgxHq+bD9UE0QbExn5W+3URU8Kud5FOPDWBQoc4DgaxJUXz3LqQyLuSdYVMlhaIMVZWneomPwXZHYT0gjEMXDW1lMEX5wyfdWBTEQShCoj5h+zxucBSGCH4D+nGQuAlJamoobTjUvpulHch90CZ7rMaDAk3+8NwS87gakJO/kKqyYO2yibUbmQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 17:44:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 17:44:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/2] nvme: Cleanup the definition of the controller
 config register fields
Thread-Topic: [PATCH v2 1/2] nvme: Cleanup the definition of the controller
 config register fields
Thread-Index: AQHbfeOOifn4/dvxlkupPBWQZ0u637NFgf2A
Date: Thu, 13 Feb 2025 17:44:10 +0000
Message-ID: <09e3b782-26a6-43c3-bb66-c7636b1882fb@nvidia.com>
References: <20250213065000.598443-1-dlemoal@kernel.org>
 <20250213065000.598443-2-dlemoal@kernel.org>
In-Reply-To: <20250213065000.598443-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB8243:EE_
x-ms-office365-filtering-correlation-id: 31e54f1f-6b9b-4ff8-2353-08dd4c5605c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OHJ0S05oRWNqbXlnUkdsdnJtRnRaRzN5TnlVc0F2NnBRTGQ1V2R3UTBuZXA0?=
 =?utf-8?B?KzVXZGRpVmYydjFyZk5IVnFEUHJ3ZSt2TjE3OGVDbldiNERQYWVSY0h5Q0R1?=
 =?utf-8?B?SlRxYlRrcmVUU0lyQlducDA2QmZsakdsUW5ZcHNlUlE1ZWpDYk9ndnMwUWJB?=
 =?utf-8?B?R3pGTTV2cUNGaldQSFMwd0g1dDBxVU12cUFORXRLRWxEU0cwQVZvWHBuRXlY?=
 =?utf-8?B?anlOK3A3bll0d3h4aXB0ZDFvcm5mZzYrbjB4czZ5ODl5eWc3RG1ENmFtTjFC?=
 =?utf-8?B?cEdycDdGRFREVEZ3bGxldTRNYndYa1EzcXRQdHRlbVZEYmwwK1JqLzlNdFFw?=
 =?utf-8?B?R0pzMTVMVExxeEIyQ1o0MjBRVUI0bWt2Y0lVNi9IVUhDcnlkbzk2UTQ4YkZC?=
 =?utf-8?B?dHNDUS9CQ1FNLzlkWjMzaHhaU3VKQkt2ekhVZGVVUzhOQlZkOGFqYk9MU2Zr?=
 =?utf-8?B?M2dCditiZkhnTCtxYTFJbHRzcDA4anVwZ3crT3lESXlxU3AvMjZOSW5tYXBT?=
 =?utf-8?B?U1c3dzdQa3lpL2JKZnAwVTFLbTFCSTdJYVRlTFMyVi9ScjhwSk5lTk1zZ3V0?=
 =?utf-8?B?cGVkN2k5anNNMGRjYUUrNVpiTStEV09DUHlvZU00TXdiSjN2bG1xQW5NbUJq?=
 =?utf-8?B?WkFoMGViMURrOXdZQTJUZUNqbjNtTHFaZ1cvNlV2MnBCNHNGclpOTzZ3TzZN?=
 =?utf-8?B?SDAwTlhBQkxmZEd1c09paU5QVTJicmQ1QnBvMVBLNzU0VUlFZS9JOWR3WUs1?=
 =?utf-8?B?dFNHYVdzOS8zanA4ZDV5Ukh1dkRISUhpNDlyaDFmR0VOM0laUDdINmdkTmdk?=
 =?utf-8?B?OW9GaXJ2ZWJqS1pUdG9RRUdBZEhPMEp1ZHlRSnZzMTRkazFkK2hvcU1hMVdi?=
 =?utf-8?B?R01zUkwwWmJPeGRnWXdMYVlRUDd1eTVPM2lXYXZJakVSaHpPclFFVjNYUkk5?=
 =?utf-8?B?Sm1mMmNuZEY0NGpQcDFITTNGcEJGVUJiWjlzWTlueFF3OXRUa0FUZFh4andO?=
 =?utf-8?B?S2ZHNHVDcmFvZkxmcHQrSC9wd2o2Z0FEY3YrQ2YvdS9rOS9LTm02MDY3UWpE?=
 =?utf-8?B?UVJpVmw5UjBhMGR6N0Q0VFZSZmFkaWZMSnZuRFlWVmVNbmhxajVPdWk4YWpm?=
 =?utf-8?B?ZWdqMG1QTXZDNUxZRHlQTTdubUJLYXRWZTE0Ty9iMGFDUTc1U2FtMXJtb096?=
 =?utf-8?B?aFBNa0gydGxjRHNnUGJjbUF4YkpDcmhFY25ROEtSTURwdFRzZmcyNXp2MUlJ?=
 =?utf-8?B?UXUvL09RUWNma3NTSnNJTVhTTnRTeXM5NGI3ZHdSV2oxcjVvVUppb3JxRkJZ?=
 =?utf-8?B?c3hSQUFDeUUwcWxkdjNSRk5RNHdaa1ZsWWJ4eTNBMFNRZmU2NUtyd2xtQ0k4?=
 =?utf-8?B?bFZSb0xBOXpzNVhkREF5c3paa3g1dldZRjR1bXlma3NxeTh5blVZcmtHYXZm?=
 =?utf-8?B?czd0TWlGTnhRMnRzanRhM00rU0YxNVEzbU1xN1ovUFgxeGZYbmp6azhZVndk?=
 =?utf-8?B?ZUVSQnNucDhjUjdPZG9VUmpvMUtobW1DbC9LOHdWNE5wdlNCd2dJQi83c2V2?=
 =?utf-8?B?YU9scnRuVFl1N1oxaHY2ZUpxV0wxZzloZ0JsaHk5R1gzQzlKTjhvNGdEd054?=
 =?utf-8?B?cDlvcjVjZStIYXN5WEJyQyttTWllWThzUnpQUGJPNG04ZDcwblY1dkloVG5W?=
 =?utf-8?B?VjdtVmtsY0dZN0JRN3RSUTRsWDdBaEMvQ2RPVnFUbDVWaU9mZDNpQnIvK0p2?=
 =?utf-8?B?d2VxbTVDOVJ6cVB3c3ZaVWpjU2dLejJVdUU3QjZhTFIvU0Npc3FlNHdOSlJ1?=
 =?utf-8?B?N2JnTmhacHdOalFXZU5NbzF3eXRBU1I0SDhpd3hYWVJJcnNzVkZ3N2dBS1A1?=
 =?utf-8?B?RFA0ZE9GOThreThOWEdvKzBXSGtLYjB5S1JlREhTTE1YRDR0anRtMEVOKzcw?=
 =?utf-8?Q?w/UojUgAonohkN3ev2mwC5DvL7mHBtj2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0NBUnM0L2pWQ3lmZVpZQy9Samhic0ZCQ2NjL3R0VklqM2lYVVpYc29NQkZI?=
 =?utf-8?B?am5tNkpHWFlaRE1TdlF6MnpkZkZMMWJxdllxVytYdUNaV2R2aWtUVSs3L0Er?=
 =?utf-8?B?MW9QQ0N1VVF1S010Nnh1OEFCQTdobFFtZkZISUlBK00wdmxXSk5hUFdlWVJL?=
 =?utf-8?B?ZXFnL1RPZkNjejJldnBuNGdXUUZoUWJuN2U2VXFhbitkSDVFMjY4QkJySUwz?=
 =?utf-8?B?RC9SRUJZbm5wM0NUaFhMcW9EOFIrVlN6bEp2MWh5MmhRUWVGT0ZhWUtYWFlu?=
 =?utf-8?B?eithTm5sVElUK3JhbnVsWm1ZR2p6NGg3NnNWZzh2SmhLSGZpNU1hWHJQUTRB?=
 =?utf-8?B?cFVtNTNqMldKUElGWnBuMnM1RnNxbWxlcnhRR2dwOExRNXgwc25LcTF1dlla?=
 =?utf-8?B?SWdFQ0FHOS9BbVlnYlVOY1F5cEMvYzVNdUlDbHBKYVJVR3FhaTl4Nk16a0ZV?=
 =?utf-8?B?U0xoLzd4L1B5WjZqRmZMYkJoRHpYUUtSY0lzemVkN1Fvb1ZyZEp3cDlqbVJD?=
 =?utf-8?B?SjNlMStzcitlcEVmVUJseHdQN1BmS0twZjdpZ1BpTlJJeTFOWUlFY2lTdHBp?=
 =?utf-8?B?MTNET0dXWmJBaEVBTGxwSUhzSStrRHhBdnpsZ1B2c2w3WUMzZVNRbFlmd01J?=
 =?utf-8?B?N3ZncVlWQ2g4M0dMRkJ0cUZhVk9OQjFpbzl3N2dLT21XM0dXbW1JdHFWWjY0?=
 =?utf-8?B?UWFWTGxmd21WUlZKWDc3amtBUHZUVzlkUXpwQmY0NzRBazJyQ3hkTXhUeGo2?=
 =?utf-8?B?S3hwRGdIM1czaGdvVlduOVZhZk8wVTZkWlRoSWJYcnIrZDdMNEN2L0o3eU8y?=
 =?utf-8?B?Z0xWU1FhUjl1RlExMExFMXp6b04vSlpWaDFzVTh1Nk9pUHZJS2xZeGRTeC9I?=
 =?utf-8?B?Nm9pdVMyUDhRQjdsa0ZLbkYxVDJ4aGdudzFHUFVnY2RpdUVndE16OXNKaG5Z?=
 =?utf-8?B?OGlweFhGaHY0TmY0QUxKdkp3QnUyWXo1SVJBb096WisycXhJeFh1OUl3azJu?=
 =?utf-8?B?eXJ0RHVGWGZoNHhnSm1sbFlERk41NzBxRVdYZmd0c043QlBRNVBoemhIU0ZN?=
 =?utf-8?B?cy92SHA2UkJoamVQTlVReVVEWEFvUjNHVGptRTN0RHpLNzhNZEFkeEdZSXpz?=
 =?utf-8?B?RDZlU1hGb2hjcEFKbmtTdkNwN1Vrd3A2OTZVdGdEVUthaTVFdHRnRGdoU1oz?=
 =?utf-8?B?UzhJVnNBSzJzSkZlOEVac0JFbzg5YXRMaVFZRkhSWGxuNXJwWlJkRmxZYmM2?=
 =?utf-8?B?K1pNcFBncWVocGVXTXNweEFLTUNhVUF0RGN6bUlVcVBRbTRVM3IvQlZBRitu?=
 =?utf-8?B?MlUxK3Y1WCs0QTJhd1JjMUxMR1NKbnVWMnlvZGg5bVU0d1V3UWtEdnhZbzFV?=
 =?utf-8?B?MHlDNVdGMS8wNDI3Y3pRQS9lbXcrb2g1aFcrNG0yZlN5cS9GVnBtdExTSndw?=
 =?utf-8?B?Mmx2OUR4OHFWSUYwc004alFPWXJaY3FqMm9xdUxGTkpDUnVjYlFUaGZud09X?=
 =?utf-8?B?VjFVN2JPVUluRENLenB3MkxOQ0xMOHUzcHdtK2dhWEN1NVlpVSthRGNSNTZZ?=
 =?utf-8?B?WjF0Vzh6RkU4ejZ5TVBJczI3TFZGUVlxSWtPTXpDS3drQ2UyT0dwVEljVTNi?=
 =?utf-8?B?TWRQZkp1YmlLUE9DMXY2NEU2dFFEYWl4a3psNmNQb1Q3dkVEcEJlcWV2NlVW?=
 =?utf-8?B?cU11cWtHeWtRaVhGekhNd2FGNUgyY3p5YU8vaGZ5UU9mQ2pKRkVrR0FIa2hw?=
 =?utf-8?B?T2Nmc2oxL3VrVnN3c0U5TkxLYzM0YkM4dUxOL1BzaHBlWmVkandmOG5jQzBi?=
 =?utf-8?B?NUhxM2FiRDd4dHBBTUZMTnhyN1B2T3QrMVppaUpESFYzTVd5TlR3NW40YnBS?=
 =?utf-8?B?aUJpWTRiRVZwaTR2UXFDcEowaDNFUU9zR08vNHhsUXpGanpTYk11WjlyV0R6?=
 =?utf-8?B?a2hMLzMybFFGck43RDRNZjNpdis4MlVIbVFoNnBDa3V6MXVyN2pEWmh6dHFh?=
 =?utf-8?B?SzB1TERFdmZuNHh4S3lYYmNqNGtSYzRIUzhDcDJGb0ZjbWpPOTkrWnVwN3BF?=
 =?utf-8?B?VjhGQy9QOTNDSFZiTGhKSWhIemFET0g4a0JUMmcrTHc4QjlPS1Jld1BXdnIv?=
 =?utf-8?Q?fCPNDHSFl0ERe9DpwyBQ0rzNm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3553C9713E1DF143B20492BC66BBD4B2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e54f1f-6b9b-4ff8-2353-08dd4c5605c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 17:44:10.3681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYFRsJtffaHbO5n5sCYcWHT5zyJ3oEaHTGcg119BQ5aW2uxvwo/th7szVRVo47KIppfaDL638UmB818q6b4Lng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_094415_087905_21D5B7D8 
X-CRM114-Status: GOOD (  10.11  )
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

T24gMi8xMi8yMDI1IDEwOjQ5IFBNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gUmVvcmdhbml6
ZWQgdGhlIGVudW0gdXNlZCB0byBkZWZpbmUgdGhlIGZpZWxkcyBvZiB0aGUgY29udHJsbGVyDQo+
IGNvbmZpZ3VyYXRpb24gKENDKSByZWdpc3RlciBpbiBpbmNsdWRlL2xpbnV4L252bWUuaCB0bzoN
Cj4gMSkgR3JvdXAgdG9nZXRoZXIgYWxsIHRoZSB2YWx1ZXMgZGVmaW5lZCBmb3IgZWFjaCBmaWVs
ZC4NCj4gMikgQWRkIHRoZSBtaXNzaW5nIGZpZWxkIG1hc2tzIGRlZmluaXRpb25zLg0KPiAzKSBB
ZGQgY29tbWVudHMgdG8gZGVzY3JpYmUgdGhlIGVudW0gYW5kIGVhY2ggZmllbGQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

