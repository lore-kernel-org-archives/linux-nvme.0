Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E882BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O92IEgFheAgEFrlUrT6Dqvrb/Xst/rDsNn/FhJUfKxA=; b=bzfzRmwMvvz+lezUB+Md7cIDyH
	df32P/k0wQQ/TeC7DPBnqSHP/9B3+/5cL/mVMwno00FgYUjf4jBQse1LpLGX0sgC7w0KZJh/mTxXF
	MjBKS8FkFlaJ1+0nrPGcp8vZFiqGfKkHSS9n+uH5euvXjnhof2lP0lvLDrzS8Li3DPHHKsnBTK4sx
	crNQGd2Rp143pq/UA6UnfMylhIfIPrBy6Ug9xFxF1Kmv+DgZn4EnBPWc3IDlIhNRaDwax2UJ5wyXE
	IiYpxIanCAKurr8+s18IfFyuOVYSUw55J8c3BFBXPCQ0M8Z8qyjpXtshTTNmCL421PrJBeCSzpVml
	lD84r8eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK3bb-004LKo-1Q; Tue, 15 Feb 2022 19:35:19 +0000
Received: from mail-mw2nam08on20620.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::620]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK3bX-004LK3-N1
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 19:35:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLe3qwVDZwEsiTVWA/+XrZOIZAfXQh62F3OWagSoL0Clj0ewUfQWrLquuS5dJY58H0FAhBsFo0D81oREDgUXSPHmaHwiryKXWYK7bfddBnlZO650jWTY10RQedY7yXjxviQpp9fYWwC/k8o2Bp+oq2+Y3H36WvySEdUCfEYLLrGjRO9Yi8IE6wX4wjubUvAq7QQchfTvBBelAn5/acWJSkis+6jH0ArIKEeu+HSztBZ+az73QeBxg/GwHFyiwZEJuJu/BYcBczhtDZvCPo7D0LAO4SBD6XEWzfOBFmddeduiGQU7IdQO21rQmkE/FvChJo3abtPaL+/wcL+DpgMHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O92IEgFheAgEFrlUrT6Dqvrb/Xst/rDsNn/FhJUfKxA=;
 b=IHSxzhVJl29nMMmvb7sBvdczD5n50a1TlI7p9mpJkoaNQzJnCWvJneLPsNBY+Ha/wfLv5USzlHHHVMzpFNWPA2fiQXx5dPmbBhp0p33Rdv2/iIJwhEh+U5ygzErw/G6YNa1m5LN377wnqqSOEeVl2Xjm43xjwHFyVGOsUwm2MuEvHhKbD6gcNwuKg4l97QC9PEGmI3tsx3nLuxQ2eV3FWaHiuN8YZ6DYvMELed/UMiCigSqNE6ZnKBPqqzRkHsPX8QCdwCePEad3Te8MOzKHyBnag1y4m4uB/lsRBMYju0g+RiXEpXITjQho80WRQirjeyd2IMQirM+bJAZT/X4wpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O92IEgFheAgEFrlUrT6Dqvrb/Xst/rDsNn/FhJUfKxA=;
 b=TdcfEN6QpmHR4AS8qes8SnI+w8zS7yMr4cvydA2HO9nxpYuixbxotP8I8Shzw9iRGOhIMuVsFqn5AalcQ4xbAZqtaTGbQ8d03xTPEkVwsy5E+qDyLQQ4TFAi9XeHUmUSF3PDo/gPZhl108ptiOqLMqBVs8Qdx/GoikgdpkECj5mLz7qPHEeutREBIYpb54AmHiji6AzmS9GDW8b4IYq+uQ/SATLxtYXLKVWCpue0Y6mQSRZKzgXYQaL+Alh9oiu8OX4B0C3s822WAUuK53QHHue/4uco9pUFnQxXryUzMx3fnJ0W/TFiFDJJesSeLEsWyssUuFqgEyo53JABHNQdzQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 19:19:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 19:19:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: remove nssa from struct nvme_ctrl
Thread-Topic: [PATCH] nvme: remove nssa from struct nvme_ctrl
Thread-Index: AQHYIoXgocEhShxKnkKjy1hThFgXH6yU1s6AgAABzQCAABiNAIAAAFyAgAALX4A=
Date: Tue, 15 Feb 2022 19:19:35 +0000
Message-ID: <84dc9de5-9257-fa6c-c1e4-f9289f721310@nvidia.com>
References: <20220215153719.1934484-1-kbusch@kernel.org>
 <8e48a72e-8d52-2395-4889-6ec6a493c3d6@nvidia.com>
 <0c105b7f-c24b-ed24-1dcd-e9d22be13b1e@nvidia.com>
 <20220215183736.GA1934598@dhcp-10-100-145-180.wdc.com>
 <20220215183853.GA24529@lst.de>
In-Reply-To: <20220215183853.GA24529@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e504130-386d-4962-b92c-08d9f0b81a3c
x-ms-traffictypediagnostic: DS7PR12MB5957:EE_
x-microsoft-antispam-prvs: <DS7PR12MB59572FDE82EFB1D4B7516197A3349@DS7PR12MB5957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NaZK8yqqXD0dLXm3snCFdBR98dU4elb+/VgyneB3tKAq/tA7DVOGkTiqpx4caUFdOXtfAB6sDp4/xzxGXWHKEz3TAlqa33UwXRlgL9OxRh1wfccCTrKGctq6AFNpl9IlIa+//YfGlwnGwtUUsosn4EN8xjCaf8vTbhMhXR6jAY7szgdCFLv9TbcqYpaIKFamE3kjBQ6dan10xjqN+Kvj1h69dLHO1SCCWYGyLdYAPS/scFQTbRlSIbVBGQq1/Ppf3Rn4C83DI/w5AurhXvamzpYcKQXHxFGB3res7T7y0cErBrxVHfxSogWgU9EagADi6igT+Zq6+btDGT3aC44sTf2lUfi46Le+zkXlOwgXfuodPO+BJ/teyrAa/S1qn6jkHRHCJr/nZsupSR+qHOQ18lBle2VIYRjdLLStK1dw5rXXrK2oJXDq4sZkOZrtMbos1OEOpF0VHfeRGbG+mb35q7Bz57IDAlPya3ceYhvmHAhc9RPxe7H+qP1eq+3vt6LHapgeahRL2xBp/KydCGRHoYLeZaV/6n/iNwXbbE0A1JrBptE6IIrBIdmjPZiXrKrNWlJRF3hH2DhPsxuB4cdKNcKl5UaHNdSflQ7NySmZltLvR/BeXKMuXsHjOPvXbtMPwqrUR17+2CY9Kc/u8ZdfmPDABrxir7g8++OcyvoJbAJm9Un5w3WCenHIqjSx3FAoKp4Rioc28RHciWLs0/DYdpPyEit6SK+P3lupgT8LokMfwOdpqI6PUXmJhRNBgPrURgDInM+2OiA8THy1PgS6sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(6512007)(6506007)(110136005)(5660300002)(36756003)(71200400001)(508600001)(122000001)(316002)(6486002)(76116006)(86362001)(31696002)(83380400001)(2906002)(186003)(31686004)(53546011)(4326008)(8936002)(8676002)(38070700005)(91956017)(66476007)(38100700002)(2616005)(66946007)(4744005)(64756008)(66556008)(66446008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0w5bkhrckdoNVg2N2p6RE9qQTNnTmFSZjVtTFZjK3k2Z29TRG1rL0NhYUoy?=
 =?utf-8?B?M01Uc2dvNkVVWFpWcDBidDcvamVwaTZJVTFEeTdhNDI2c21ZandtUk5vVmpp?=
 =?utf-8?B?VjA2cDNvK3FJVW14Nk1CU2dHSjhIc0VnK3RUNlhXMktlbXJWMENUTWl6RE5C?=
 =?utf-8?B?cUhJSEhFNG1WRGpOek1LU2lhOHJ3dkIvdi9SN2drZ0FWL3VCRmRicjVydUVP?=
 =?utf-8?B?ZENhaVNqblJlRUFRM0FwL0loOUE1SkNIL09qNytNYXg5SHN3QVZuVG9LYjBV?=
 =?utf-8?B?R1gyUEFZWUw5MDZ4amxXNVphcHV6SElRY0s3VmVkYUdJNWkvYkdCSzB1cXg2?=
 =?utf-8?B?YWZEOUl1RzZUaW9aNEIwckY2SU8zTGNMRXB3dGlKWTZmbDhBSSsySGxvRWNk?=
 =?utf-8?B?aVdrd0k4N3QySkRSSXF0ZFM4MDNHRVpvZjJ0ZDYvc2pkNGlDemFwNHcrNlk3?=
 =?utf-8?B?clMwNGs4YVBiZ0c1clZ0b0RLeWgweUtsUkFvS0gwNUlHdS9CSDZBZjBKMFNw?=
 =?utf-8?B?Mmo4cWRMckIxYU9VRW41TnNGOWVJeHRUMXo5UlZVbUl2ckkyOTczWGVmS1U1?=
 =?utf-8?B?UXd1dS9IdTZTcWNGa01iOTBEeXdwbEJURVNtVlNGVXd5RGhBbFN4OGY4NzNP?=
 =?utf-8?B?clBPcEpLNEVneVRJQ1NSRGZDclNrcTJCZ2dNd1o3TituZHZCcGN1RWFjQ0Nk?=
 =?utf-8?B?UkY5Rlp5STAveEthYVFQYTd0N2lQUm9OYkowdzV1QnNSK3ZUa0pocUtFMDNV?=
 =?utf-8?B?cmd2cFlQdGg2T2VQOFJkUG82ajFhYm9aaUZPb0xUZWZ1NmRFalBWbi80MEQ0?=
 =?utf-8?B?TjRBbWVQQWEvT3Z6eGdxQVN5aWRXWElKOFlIb1NjZGFDQUlHMm0rWE4wVURj?=
 =?utf-8?B?WjVXYVFpb05XcDlxcytYcEN6MlBKUDVPTGIwd0RERGptR245UzRiY1VDVCsw?=
 =?utf-8?B?NkFmZTQzZ29MRGh0WXBkb2VFZng3U1k3SzN4TXZFRlZBM085dHpiVmxyR29R?=
 =?utf-8?B?NzJlUThXQmxNV0dMdkdQMld3dFZJMFhLcGgzblhWVjFlWC9OVGhoV1JjaGFY?=
 =?utf-8?B?Zm90VGZSRGU0L3ZwdU53ZlFZdUVyM3lNQ3lGRE9CbHBqQUFINXZDNHQ5bFcw?=
 =?utf-8?B?Q0QzZGh5ZlM2MjVUSmFFek1vYUNPSW9uOXAwOEd2U3R3M05IQVRqelFQTmdL?=
 =?utf-8?B?UlR6WCs0clV2TWwzS3M5K2lESHJJT0lYNEM2MjRmaHlsSmtSQzhGYzN6NU5D?=
 =?utf-8?B?RFAwWFF3bDRETW1DUFVybFlLV0xwS1BUM1lQdG40U2N3TkZqUFhvbGxWOG9a?=
 =?utf-8?B?Mmd6SHB5UnZVM20zUzR2SEE1MWNHL0syMzhPL2tiRW5BWTJsdVE4ZXdIUDda?=
 =?utf-8?B?ekQyWEVOd3pmVnJCdjJpcmQzQW9oUEdOTjUzbS84akdDS0FzVWhxRmtIa2s1?=
 =?utf-8?B?WElzMHZMb09oNDV4Nnh6eUNYUXdzZEpGVElHZFRqaXdZMUVEOTFVMkpENWZw?=
 =?utf-8?B?bktUdXdVTVozRWd6S3hSVXRXMk0vR0VFcjBxMWFGZzR6MGRhUWZIVE4rTFdC?=
 =?utf-8?B?bjA1MlVMck1iUU1rR1JqVHpmTW1wL3BwRVlYTmRNeEd6MHZmRjhyVWhVR0Qw?=
 =?utf-8?B?cjBMUGhoOXNVZFBSYjBaMkxZTzJhNXkwOFdNaSszK1NnSHdLcTBodWpmQy8w?=
 =?utf-8?B?UGEyWHJLUXRJSDZMQnpQc3FZOW9CY01wbm9tNTYxajBoOEdxM0RTaXhDTkQw?=
 =?utf-8?B?ZVhwMjlpT3JlWlEwaHNFYjZTNTY3YXNsT2pQR1pjUW8zNWtiZmgwZkRVZHhm?=
 =?utf-8?B?KzhMUWZaNE1hT0ExRzFPbU9hT01CRHpMeDNNNlN3NkxDVE1PcFdRRnVoTHBL?=
 =?utf-8?B?MllMcldyTXpmMmYzMzJsSlJCR1ovY3BhdEFwYVlxdE5Ld1FrVUhPZWZ3Mm1l?=
 =?utf-8?B?c0Zna0FrQ2ZxaisvK1M4WUhQWldieW5FM1dsR2NEVWNCWUFUVXdZYzNaSjho?=
 =?utf-8?B?SmI4STY3YWY4OWJiZXEwNVFoZHBpT2FNQlZFS0V3ckxRVnhrdThIZWJTVVVw?=
 =?utf-8?B?TVZVanp2Wk1hMldTeXljNzA5ZFI2Wm53b29GOFNBd3JzbXo4c2pQMEJKVklw?=
 =?utf-8?B?OHdWVnlRdzF3YUlpYVZjalBXdS93N25DdDZTYmozNkg5dmNpbFgzUjcxQ2Ey?=
 =?utf-8?B?QXdzMXVtNUxsdThGL24rN3pzeHpLLys2RXFWRng0LzYvR1BaU1Fnek1mTWJr?=
 =?utf-8?B?V0lvK2o3Q1p6MDFDT2Mya3VBck5RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2845DFD95375C4096A54DDB076DBE72@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e504130-386d-4962-b92c-08d9f0b81a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 19:19:35.3690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3zjIXZbSsjjjnen63Jwcv7w1BRNU9szeLWCN6qzejLeOUZA1NZkJ/CJ2mwVSAbmS51cuCKDl4fP3TFy39zCvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_113515_764405_29CD189D 
X-CRM114-Status: GOOD (  13.61  )
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

T24gMi8xNS8yMiAxMDozOCwgaGNoQGxzdC5kZSB3cm90ZToNCj4gT24gVHVlLCBGZWIgMTUsIDIw
MjIgYXQgMTA6Mzc6MzZBTSAtMDgwMCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+Pj4+IExvb2tzIGdv
b2QsIGNhbiB3ZSBtYWtlIHRoaXMgZmVhdHVyZSBjb25maWd1cmFibGUgZnJvbSBLQ29uZmlnID8N
Cj4+Pj4NCj4+Pg0KPj4+IHJpZ2h0IHF1ZXN0aW9uIGlzIHNob3VsZCB3ZSBtYWtlIG9wdGlvbmFs
IGZlYXR1cmVzIGNvbmZpZ3VyYWJsZSA/DQo+Pg0KPj4gSSBkb24ndCBzZWUgd2h5LiBXaGF0IGJl
bmVmaXQgZG9lcyB0aGUgZHJpdmVyIHN0YW5kIHRvIGdhaW4gZnJvbQ0KPj4gY29uZGl0aW9uYWxs
eSBjb21waWxpbmcgc3VjaCBjYXBhYmlsaXRpZXM/DQo+IA0KDQpub24gZGF0YSBjZW50ZXIgc2V0
dXAgZG9uJ3QgdXNlIGFsbCB0aGUgb3B0aW9uYWwgZmVhdHVyZXMsIGV2ZW4NClNTRCBjbG91ZCBz
cGVjaWZpY2F0aW9uIHJlbGVhc2VkIGJ5IG9uZSBoeXBlcnNjYWxlciB3aGljaCBhY2Nlc3NpYmxl
DQp0byBwdWJsaWMgb25seSB1c2VzIHNtYWxsIHN1YnNldCBvZiBiYXNlIE5WTWUgZmVhdHVyZXMs
IGJ1dCBhcyBDaHJpc3RvcGgNCnNhaWQgbXVsdGlwYXRoaW5nIGlzIG9ubHkgZmVhdHVyZSB0aGF0
IGNhbiBxdWFsaWZ5IHNvIGl0IGRvZXNuJ3QgbWFrZQ0KYW55IHNlbnNlIGZvciBzbWFsbCBmZWF0
dXJlcy4uDQoNCj4gSSBjb3VsZCBzZWUgdGhlIGJlbmVmaXQgZm9yIGEgcmVhbGx5IGJpZyBmZWF0
dXJlIHRoYXQgaXMgbm90IHJlcXVpcmVkDQo+IG9uIHR5cGljYWwgZW1iZWRkZWQgc2V0dXBzLiAg
QnV0IG11bHRpcGF0aGluZyBpcyB0aGUgb25seSBmZWF0dXJlDQo+IGFueXdoZXJlIHRoYXQgdGhy
ZXNob2xkLg0KPiANCg0KDQotY2sNCg0KDQo=

