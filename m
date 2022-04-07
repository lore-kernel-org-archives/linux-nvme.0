Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1EAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dovGkRkqi4blIV6bSUR2F7JaWXg8c/1+xQuWVQUGdIc=; b=Ct6CVcEgynT/tFs/NexiL55uer
	3afEby7mZfba72kitTGzUO61mPrSPCL8mYAW6fMrCh/vJ3q77DVJekjLFPr50I6/8rR/SwhbwZTts
	laPoEso1VZSc3PeOqwC/0vWWxGAb/t3o2DFaZINXpYKvF/JJhd+E6J739bES/crIny42HQN6afwmb
	zY4JrUuaCDNOqBU7AyZIRCJ36GntxwPmtPiMobDsG6RW5oyFsFw5UVzVBQvkpgZpOQ9h1GP/1rm/c
	tFCifBdXxp30budGCdq2yXgCs7jrsH+KrfMSYKUQBceU4jjF9Ltbu59VlhZMW4w/UNVVakQrmzvZw
	Ru0qni0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncZEf-00E3xn-Op; Thu, 07 Apr 2022 21:00:09 +0000
Received: from mail-mw2nam12on20626.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::626]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncZEc-00E3wY-IY
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 21:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4hBVQjvJBMGSGsqGS48UQ236D8z4euTWMGGC6cgo0BHLpRCwxBVe7fMQRvzCCy5JzzQI6053ADYAzOjxAmDYDjKYCFMyt0KvV3DYd127FeTLgLFFG2nHvSILgnK5rVCG+XRF/gfu68lzQune1H5EcD/k2fGOgaomWXlfmCfF1bTxPSVC+nTEIFwkeqQ2v8ltS2yVA4+92Bh3N47YygaNcRL+BSH0NgzEN8PkwErw22lUmnn4d2aBvrMV8Lu4XnKjzkxe4QI10e7qyaZn0SyGmicNs3qgNW9dWzFppvAbQUY02+JX5JMi1yijV1y+3+ceeRf42V/mrRqE6GPT49u5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dovGkRkqi4blIV6bSUR2F7JaWXg8c/1+xQuWVQUGdIc=;
 b=UnnWn1B64vo6DblHIwvK5qo2lxaNDrNv2JWQ6X3O2f2VZH6BHIsVwFLjji77NN+xMYG6pfpcx0JEF4nZXNDuI8T2zL3UEq6Gv1garIVYeMakQn6vFz0xMbTkS50FZ/onvTC5x0hFYCQmo78NMpCbwh3ZyUWYHoe02fDv7iP8Muqc+gIos6eY/Km3oCHnyjCGjFrH3T2f7YO+aaEextC2NZ5DY3OiZ0DxBmZpbNealeCmu0j6o59h3OsZwxfWFZ6bvYg9v81e5as9EtzsLuYoMkDGbRj+c8/P9Y7PHbis2udumziqgFhHtdaeTcnLJlQZdlSrXeIwnye3H6vfBOgeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dovGkRkqi4blIV6bSUR2F7JaWXg8c/1+xQuWVQUGdIc=;
 b=grzePaa3s2ind2qgCSha1cpZonYXEV7xwKzI6hGizpZmgrrZnaMqzRmcuym1ZvOCYpTiXRtYsmWqquOYBhnIwus0jGyBBotdv28Sf2eXvIiSUa4IAMqN77XnzSf9ZU0AC0WMrxxObDhQ5FoJnJ2/GBFAEeksCsq9fTXSznRo9Sr1JnEmpvpdIXKvNkcqapa0zOdKPKwnQGz0j6VN/u6wi5iJi9VNBMckR6+nKDis17g+7xBlpcSqXB/8GENx1v2khrXV0xbi+fqx16ula+p29uvLCHMI1sAP7XJ4jsdoyDKE33iCEeF3aeXSzrhNy46CBE7vo3/WFkodPGFpV7FTLQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR1201MB0098.namprd12.prod.outlook.com (2603:10b6:405:55::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 21:00:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 21:00:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUmD3brgDUei0iedZF8Ixk0L6zjGb6AgAAClgCAAAWlAIAAT2MAgAC0PoCAADK+AIAAiyCAgAAG0ACAAAbxAA==
Date: Thu, 7 Apr 2022 21:00:00 +0000
Message-ID: <b793928e-f127-8155-b124-642614afbb85@nvidia.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <20220407085113.GB19062@lst.de>
 <64ff1e92-6c6c-da38-8753-0e6098394622@grimberg.me>
 <4386789d-6722-add8-5b42-f605e48e894b@nvidia.com>
 <650E6456-BCAC-47DA-B50E-4321E98AC9AC@oracle.com>
In-Reply-To: <650E6456-BCAC-47DA-B50E-4321E98AC9AC@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67e73f52-1d85-47ad-5abe-08da18d99485
x-ms-traffictypediagnostic: BN6PR1201MB0098:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0098ADF75A0563E96A8A0B59A3E69@BN6PR1201MB0098.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E5ezYJ2NFBj8DqA2+1Lj0LJmpJ+y75zVFI//3NCRl65gs021GWEiBZa7WBFI/5n7nuMyAssQajdGk6mAZmpx8VUUldpxBcHDBcc9BZGrLV7tuqOx6SY3ZfKBSF+EVDzeXXJz3Dlg6PvOChpX/KNt96k1Q+888RGCr3qVoezFdj+Uw0gHGjXbCZ7g60m6WWzL+kEHBn+6+DSIt5fyacvhb46snTfZHRMR1aY1o6UJbKvDHXta7VILbceMnOt4jEBLqD6CkhmKPFA0phdu5OVAMZE61ifXvsjDcDkR4trdAibXb9JxsIfBdF1l6T8IS0AElnFB0n6oG59AAbHUp0sOEy8GCKGYj7qkrWInGzKj502cyjvy8Y/thJthoy2HvsDnbvK3YhvVNd/uEikfoiIh3sC3+yYg/QOCCq/FSzWLDB9ub3gZVd+kRNasDIqUFdDARCeN2WKnyMyzYslBO95aBRSYmDJ+fm0qpSqKEXxgRP/SXd0n106ILZ3LOi/i27VCCHPv0fmsZ0kRhUwDCuM08dJNO71zJuFiFc/eYZp7/1E7HHyr4mZ3Y7AQ3Wot3QXx1NfxEAovE/8yIvXLBAqEwDvIQcpdAFDD5dsOHKUgYqX06CN8oIh+EcLv/4Q7w8i8pweXpbPICOKgwSyRyEevCf81BauhbRONMBKlwZ98vEiUHA77nQdeT4tom+eHvKRFcGzqOmKOTckIfIQJ1KlXFEZhfYJe7HCOQBuuyLVRAvbLJSwF7DT/DXh+GF3cCzp5BHUDXefctd1d1y0XQUisoHdv4XsAXN0JA8uz3sKUclw7CBWZh5g6iNWVEVv5QcfIiqp63cDwMTg0Yg5g3huai5xQwxgjtr8kgTf5ncCRi2PCMxuacBXLfQWUipcre0iKcxoBKkcIB2BmfdDFJ8LrxA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66446008)(4326008)(66556008)(66476007)(64756008)(66946007)(86362001)(54906003)(966005)(6916009)(31696002)(36756003)(508600001)(8676002)(76116006)(6512007)(2906002)(53546011)(6506007)(316002)(6486002)(71200400001)(91956017)(31686004)(83380400001)(122000001)(38100700002)(2616005)(8936002)(5660300002)(38070700005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1RoK012NXNaV1FzVjJhVEFSeDEvMmRlcnYxTDNyTVdNSTBJVG1Qa21lZkha?=
 =?utf-8?B?ajFlUWpmS1dneldRTlNtV2x5Z2k4Z0hOQjFCZHNKOFduRkZDSmpha1dzTHlt?=
 =?utf-8?B?NzMza3JpV2IrMlpPUElVYUZraXhyZnJ5TUNMYmJWVHllYmN1VnRvR2gvK09l?=
 =?utf-8?B?QW5BaStjYXM4cWp0QXNjWXpVVWpFUUtrQ0NlSFozNzlvZE9ZSjlYMWM3Vysr?=
 =?utf-8?B?alJvb2IybHdVUWc0elcvS25kWUV6Nmt4d3dBWmE0Z0o0OXFHNTlMdHZ4akQ5?=
 =?utf-8?B?WVJmQkJ3bmMzNUNXbDQyN2JpdWdIcFJleXZndGlvbVZkRzZpQzYrUVhGWGdZ?=
 =?utf-8?B?T0RQbk5yL01kUHM5Q002R1p5MWdzMWt4cG51YjQzWGYxZDBpanUrZTF1TnF1?=
 =?utf-8?B?T1pQbWpwVUt4VWpCUGxnWFRMUmdGYmJhRVc5WTc4YmlhcitYOFhLQ20yWUdT?=
 =?utf-8?B?S3hSUEdZVXR5emlyVG0vSll2OUdEdlhnVW5lM3oxZnd4eElaRUlES0RCWEtV?=
 =?utf-8?B?VFR6Q3dSTkszc1p6dHNWMWYrazcrdXpUT3hMckJqakhJWmY3bzcwcU03V3Ja?=
 =?utf-8?B?TjJIUUlSY3E5STZaUmVFby9kVjdRSUZMSytjVm5aMDF1ZUczM0tlRFM4QnJl?=
 =?utf-8?B?SjZoL1pQYnFLWGx2bVAyQWZmZFVkemRXbTdBd3BTNi85czVSSXoyNjlReGxw?=
 =?utf-8?B?ZlI2SzMzSEcrMXUvK05XQ2RKS2N5RCt4U2JZT2l2WG92NFNCL0pWeGw5OSt6?=
 =?utf-8?B?WWtENU9sckdPT2IxdVM5aC80RHJZeEZjU0pnRXFMTUVON1hKckJVMUVIbnh1?=
 =?utf-8?B?MnBScjRGemlzS0dIV0JkU29iL2h3MDVldGNoeTQ4TVNNZ05wckx1TnNnWjU0?=
 =?utf-8?B?QkhCeWhuRW53S0piZG90cXNZdndCYXNndDVzL295VzVOTHg1OU9LbnBXUEpI?=
 =?utf-8?B?TEdIcHdBNFIvRDc4Sk1KaEprVHltdnJmbnFsalRvaGh3aHByd2w0VUFpMWg0?=
 =?utf-8?B?Y1RieUtDZDR0UnhQV20rV0tKQTRoVEd5ODI3SElxaVJGOW5tckRvNFpza3dL?=
 =?utf-8?B?VXZxa3IzcHZFdFk0Znd5dFoxeTJuNC9xV0w2dFRRczN2UHVSd1M3dE54N3dG?=
 =?utf-8?B?TGYrTEJPNkNzZUVPODRVa01URGxObWFDS0pwOVI5bFFBZE5WNVQ2blNzUkI2?=
 =?utf-8?B?YUo1Z1FhYzRhc3JzZnhJOHBQMkhwOG5vRXplMFpsZXlLcmNGQlZtSHh3RGc1?=
 =?utf-8?B?bStadmkvOHdRQ0YwRkpnUUlBOTRIek9la1pFTmhoUE1LUUZaTDVEaEdOMVdr?=
 =?utf-8?B?bDVXUS9KMWN0WmdFRGNOdmZvM2NyTGlXNDkrcHhVOUdESWRnY2FyN1BCWWFN?=
 =?utf-8?B?OVQ3aVZEQk5qdDdySHBYaE1FOW5SVmYwbWNkQmk5Q1dGUllGRm9CUzNVbk1Z?=
 =?utf-8?B?N21rYVJja0JVWHpnMFJ3L05nTlRNSEpINm4zdDN0UzkxZUVoNnJITXhacUxn?=
 =?utf-8?B?ZlhRbm0rT0IyY1hQT1hDM0IrTEpUVE9LYUFPcmpMRTY2TFp0SzExWnFKYVF6?=
 =?utf-8?B?K3AyVnpqUDdvR2VLQ3l5UUpYUXVVL25VZ3UvS2ZWN2J3dVp6US9wbmtyV0xt?=
 =?utf-8?B?ZDE1V1BkYUVkTjBQRUtTQ3R6ZkEvdHhkTEkwblY5K3lHUlZyU3Z6VkwycjJs?=
 =?utf-8?B?ZEwxWlIwYTdQbGFqK2tUQmkwMEZoTHBBZTM1SUlBZ043OFUzdlBjMWtWcXNi?=
 =?utf-8?B?cWJGdW90VThGa2ZFWVh6cjQ0SWJoL2FXaWIvbzFmdjhINCtId2FRaEdLRHBB?=
 =?utf-8?B?YmZSSnI4TTJzQi9tQVN4Vk5VakRDN0E4OFhDOVRtM0tOZDJlK1lqTk1DUHU0?=
 =?utf-8?B?M0wxbVFYTTZDRk5SbjlsVHR4SHE1czIreTRhY1RZRE9TQzJsaklYY1AyRFI0?=
 =?utf-8?B?ZFlENkNHTG9BcTE0NWszdzlTRVRMRlJ1RVNQKzZkcFdMcXIvbkdHWkd1ZXJN?=
 =?utf-8?B?Z0lMUys4TzRuaTgreThJOFhBRlVRWFVHNHJubGxLbFoxOXMwZGdVWUxtdzRI?=
 =?utf-8?B?UERaQ2J2VDVBZk5hK1FiQ3lnb1kyWVlxeWVpT2o2bTNKdHo5anFjamplVTZy?=
 =?utf-8?B?UkFtRjlsZXVBNUdGTFZrTC9TeUhNbTIxRTVhbVJld0lqSlZaQm5lKzRhb0lJ?=
 =?utf-8?B?RHhUT0RKMzB5SnBVOHlRQVljMEtkeXdHOUZuUnVCcW9RUTRsMGZCYjhYcXgr?=
 =?utf-8?B?QVkvODNaOHo5N2FQL2hlc3N3a29PVjFTbC9meTdZdThCVmU0TTJoSzZjcUpN?=
 =?utf-8?B?WUo5SGJFcmZHdkg1VTkyTlFKbDZQZG1TK0k1M2I5LzRXcytxbmE2cUQxb3ZX?=
 =?utf-8?Q?xvroM+924GhHBDqvxwY1QZBePVOaj31RNnYv0uyCGIixE?=
x-ms-exchange-antispam-messagedata-1: LbXNURH8OVVaeQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9FCEA428AB46241B0C77AADF49C6676@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e73f52-1d85-47ad-5abe-08da18d99485
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 21:00:00.3677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPIkyaVNl7977IOlgELPtyVGgGtR5gxTrBzZRYjeuIJy4NFfFYSH7ha3kGSrM9CJZizPNM8U0ZhvZ4OgJ9pf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_140006_692634_59C0D4A2 
X-CRM114-Status: GOOD (  17.99  )
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

T24gNC83LzIyIDEzOjM1LCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+IA0KPiANCj4+IE9uIEFwciA3
LCAyMDIyLCBhdCAxOjEwIFBNLCBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YWtAbnZpZGlh
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gNC83LzIyIDA0OjUyLCBTYWdpIEdyaW1iZXJnIHdyb3Rl
Og0KPj4+DQo+Pj4+PiBVc2luZyBSUUZfUVVJRVQgb3IgYmxrX3JxX2lzX3Bhc3NyaHJvdWdoKCkg
d2lsbCBtZWFuIG5vIG52bWUNCj4+Pj4+IGFkbWluLXBhc3N0aHJ1IGNvbW1hbmQgd2lsbCBsb2cg
YW4gZXJyb3IuDQo+Pj4+PiBJIHJhbiBpbnRvIHRoaXMgdXNpbmcgdGhlIGJsa3Rlc3RzIEnigJlt
IGNvZGluZyB1cCBmb3IgdmVyYm9zZSBlcnJvcnMuDQo+Pj4+PiBJcyB0aGlzIHRoZSBiZWhhdmlv
ciB3ZSB3YW50Pw0KPj4+Pg0KPj4+PiBXZWxsLCB5b3Ugc3VibWl0dGVkIHRoZSBsb2dnaW5nIHNv
IHdlJ3JlIGN1cmlvdXMgYWJvdXQgeW91ciB1c2UgY2FzZS4NCj4+Pj4gU0NTSSBza2lwcyBsb2dn
aW5nIGVycm9ycyBmb3IgaW50ZXJuYWxseSBzdWJtaXR0ZWQgY29tbWFuZHMsIGJ1dCBub3QgZm9y
DQo+Pj4+IHVzZXJzcGFjZSBwYXNzdGhyb3VnaC4gIFNvIHdlIGNvdWxkIG1vdmUgdGhlIFJRRl9R
VUlFVCBpbnRvDQo+Pj4+IF9fbnZtZV9zdWJtaXRfc3luY19jbWQgLyBudm1lX2tlZXBfYWxpdmVf
d29yayAvIG52bWVfdGltZW91dCAvIGV0Yy4NCj4+Pj4NCj4+Pg0KPj4+IE1ha2VzIHNlbnNlIHRv
IG1lDQo+Pg0KPj4gVGhpcyB3YXMgbXkgaW5pdGlhbCBwcm9wb3NhbCB0byBmaXggdGhlIGNhbGwg
c2l0ZXMgd2l0aCBpbnRlcm5hbA0KPj4gcGFzc3RocnUgY29tbWFuZHMgWzFdLCBzbyB0aGlzIHNo
b3VsZCB3b3JrLg0KPj4NCj4+IC1jaw0KPj4NCj4+IFsxXQ0KPj4gaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyMi1BcHJpbC8wMzExNjAuaHRtbA0KPj4N
Cj4+DQo+IA0KPiBJdCB3b3JrcyAoc3VwcHJlc3NlcyBsb2dnaW5nKSBmb3IgZHJpdmVyIGluaXRp
YXRlZCBhZG1pbiBjbWRzIHdoaWNoIGlzIGdvb2QsIGJ1dCBpdCBhbHNvIHN1cHByZXNzZXMgbG9n
Z2luZw0KPiB3aGVuIHJ1bm5pbmcgIm52bWUgYWRtaW4tcGFzc3RocnXigJ0gd2hpY2ggSSBkb27i
gJl0IHRoaW5rIHdlIHdhbnQuDQo+IA0KPiBBbGFuDQo+IA0KDQpJIHRoaW5rIG52bWUgYWRtaW4t
cGFzc3RocnUgYW5kIGlvLXBhc3N0aHJ1IHVzZXMgZGlmZmVyZW50DQppbnRlcmZhY2UgdGhhbiBp
bnRlcm5hbCBwYXNzdGhydSBjb21tbmRzIGkuZS4NCg0KbnZtZSBhZG1pbi1wYXNzdGhydSA6LSBO
Vk1FX0lPQ1RMX0FETUlODQoNCiAgbnZtZV9zdWJtaXRfdXNlcl9jbWQoKQ0KICAgcmVxIGFsbG9j
YXRpb24gYW5kIHN1Ym1pc3Npb24gbm8gaW50ZXJuYWwgcGFzc3RocnUgY21kcy4NCg0KbnZtZSBp
by1wYXNzdGhydTotIE5WTUVfSU9DVExfSU9fQ01EDQoNCiAgbnZtZV91c2VyX2NtZCgpDQogICBu
dm1lX3N1Ym1pdF91c2VyX2NtZCgpDQogICAgcmVxIGFsbG9jYXRpb24gYW5kIHN1Ym1pc3Npb24s
IG5vIGludGVybmFsIHBhc3N0aHJ1IGNtZHMuDQoNClRoZSBpbnRlcm5hbCBwYXNzdGhydSBpbnRl
cmZhY2UgdXNlcyBpdCdzIG93biByZXF1ZXN0IGFsbG9jYXRpb24NCmFuZCBzdWJtaXNzaW9uLCBz
byBpZiB3ZSBjaGFuZ2UgdGhhdCBpdCBzaG91bGQgbm90IGFmZmVjdCB0aGUNCm52bWUgYWRtaW4t
aW8gcGFzc3RocnUgaW50ZXJmYWNlLi4uIHVubGVzcyB3ZSBhcmUgdXNpbmcgc29tZXRoaW5nDQpl
bHNlIGZvciBpbnRlcm5hbCBwYXNzdGhydSB3aGljaCBpcyBub3QgZ29pbmcgdGhyb3VnaCANCl9f
bnZtZV9zdWJtaXRfc3luY19jbWQoKSB1bHRpbWF0ZWx5Lg0KDQpJbiBzaG9ydCB3aGF0IEkgbWVh
bnQgaXMgZm9sbG93aW5nIHBhdGNoLCB0aGlzIHNob3VsZCBoZWxwDQp1cyByZW1vdmUgdGhlIGJv
b3QgdGltZSBtZXNzYWdlcyB5b3UgaGF2ZSByZXBvcnRlZCBhbmQNCmJsa3Rlc3Qgd2FybmluZ3Mg
YWxzbywgY2FuIHlvdSBwbGVhc2UgY29uZmlybSA/DQoNCmlmIG5vdCB0aGVuIEknbGwga2VlcCBk
aWdnaW5nLi4NCg0KbnZtZSAobnZtZS01LjE4KSAjIGdpdCBkaWZmDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQppbmRleCBm
MjA0YzZmNzhiNWIuLmExZWEyZjczNmQ0MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYw0KKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQpAQCAtMzcwLDcgKzM3MCw3
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX2VuZF9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkN
CiAgew0KICAgICAgICAgYmxrX3N0YXR1c190IHN0YXR1cyA9IG52bWVfZXJyb3Jfc3RhdHVzKG52
bWVfcmVxKHJlcSktPnN0YXR1cyk7DQoNCi0gICAgICAgaWYgKHVubGlrZWx5KG52bWVfcmVxKHJl
cSktPnN0YXR1cyAhPSBOVk1FX1NDX1NVQ0NFU1MpKQ0KKyAgICAgICBpZiAodW5saWtlbHkobnZt
ZV9yZXEocmVxKS0+c3RhdHVzICYmICEocmVxLT5ycV9mbGFncyAmIFJRRl9RVUlFVCkpKQ0KICAg
ICAgICAgICAgICAgICBudm1lX2xvZ19lcnJvcihyZXEpOw0KICAgICAgICAgbnZtZV9lbmRfcmVx
X3pvbmVkKHJlcSk7DQogICAgICAgICBudm1lX3RyYWNlX2Jpb19jb21wbGV0ZShyZXEpOw0KQEAg
LTEwODYsOSArMTA4NiwxMSBAQCBpbnQgX19udm1lX3N1Ym1pdF9zeW5jX2NtZChzdHJ1Y3QgcmVx
dWVzdF9xdWV1ZSANCipxLCBzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQsDQogICAgICAgICBlbHNl
DQogICAgICAgICAgICAgICAgIHJlcSA9IGJsa19tcV9hbGxvY19yZXF1ZXN0X2hjdHgocSwgbnZt
ZV9yZXFfb3AoY21kKSwgZmxhZ3MsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcWlkID8gcWlkIC0gMSA6IDApOw0KLQ0KICAgICAgICAgaWYgKElTX0VS
UihyZXEpKQ0KICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihyZXEpOw0KKw0KKyAgICAg
ICByZXEtPnJxX2ZsYWdzIHw9IFJRRl9RVUlFVDsNCisNCiAgICAgICAgIG52bWVfaW5pdF9yZXF1
ZXN0KHJlcSwgY21kKTsNCg0KICAgICAgICAgaWYgKHRpbWVvdXQpDQoNCg0KaWYgbm90IHRoZW4g
SSdsbCBrZWVwIGRpZ2dpbmcuLg0KDQotY2sNCg0KDQoNCg==

