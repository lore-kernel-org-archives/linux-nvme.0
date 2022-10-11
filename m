Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF04C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIEqD/0EDBKOtRPtB3Airh1XoXoRMKXNYl2y227Mmh8=; b=WN6u/qUMYw9h/ZxXS0zXgt8mdI
	oYyGWtf5mtcg5aFGpvbXEv3wRf6lEV1HTUGYdEagYnjlnp8en70X3CxM2akP7n3zO/H4j80DUoZmc
	rI63uIvQ9uV2wWAp9JireFbR8wsdkBAPig80Jm/Bs6xvQ89PIdMK54N4a0TWHuJ+7ZHcKQDgrtedX
	ixgehyMTehqMwmgyNH0F2N5ksS3u/QPXKLabCGJEP+MbQrBeOXNnFaf9mbop0jDP2vJI8QINXXoW0
	h7DzlCvgkO3OPNeWIFJHOqzF65tJ69vIdSw8/NAOdzFVH8RUGdlEo5bZViZT2Wud/gquvB9xKBFye
	nuq/4aHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiLjN-005kvs-0q; Tue, 11 Oct 2022 20:20:01 +0000
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiLjK-005kv0-63
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 20:19:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9qRtzYHmS57QAbnv9BYE9lAPHkIqw9eEIOjTwRA9oUUWxFGF3kZgT/nQbVcpVBELMhA2PkZetRkW3qGSWkWyMOA5x6W6SaHotbkHQ6OCKMb2ml0IAWxFsp9m6jkPPCpV4TjwRZnbVXJ1TZswnXIRKNXRUjDKO47f2Rf9Q7iVPIBOCF61/2ZBScbGKi5Nl7onmMrHSKv25noLw7hGst5XPvp8yLteVRE8N+rU2fUKUQ4MiTKwQ4vR0XsUOabDLEBv+qBelmV9PmAp+Zn6i+7jLR4qW1SDfbbEExBTxWa1R2rB8mDpLb6lITnCSCr7CG6HMqSFrCTUVFnTYSB+ACOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIEqD/0EDBKOtRPtB3Airh1XoXoRMKXNYl2y227Mmh8=;
 b=EBEZA503zsNjsF70poMYas/86CvocYopV50+fVWxUb4NDOTzOhXt1cZUNBiT3BYzolMNWBLxCKSvvzOCDFNB3dHt/cvdPEoxn8GgrDYj5Qxkj+w9x8Wzwl/+wKcJ44czylRCELa6DMOXeIco5jtsbOpUj3gKaJRKe6ZR1P3w4vKB4C6CA8izHwQfFnWwqO34HOKRoi/mqgCY34atsBmD/K2LXVexpDP2yTDLBoiuI5hrD6S65+2bNqxxTGuJJJHu/FqQhWVc3+WLsrXfM1m5btGncO8YI+aYqHmJYCQ+yhg7nALTRL1kxsxqO5RdhixpoGXoamFO9xltMcO6iEUPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIEqD/0EDBKOtRPtB3Airh1XoXoRMKXNYl2y227Mmh8=;
 b=FsuBY5VcQJN5f4xt/T8wfZureSxWdT7wgq368ifI1GqWM4P5uaFnLgCuebTUThJjpQ+W/J2xOwKaJMSW+xuwjHbOMCcRiypvx5jhhA9nqU91HxbzkGi1Y2IY2+hfWwRX98W0SeTXAgbzmHGVkN/tYKH0ApTDAgUP8UcUMta/Qkr1wVSksZI/fwlLSmd61HjCXA2N5dkoBS5aNKn5xSwFvzYm3TQ5LWeEgwomE2+pobpwUw2IgB2t9XspzUAlI9J7Kyh/Z/MMzA6rhVNKRmRPKF+P0dZigLKeswk7AGKjBe17Gy87RqYqXMLv6BYWsxT8Te12KOdap4d9OVV1Pbcvcw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 20:19:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947%4]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 20:19:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Seth Forshee <sforshee@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: nvme-tcp request timeouts
Thread-Topic: nvme-tcp request timeouts
Thread-Index: AQHY3YaTY9yuAD8lP0yF3XXSJfjJZ64JlOoAgAAMJoCAAAGAgA==
Date: Tue, 11 Oct 2022 20:19:47 +0000
Message-ID: <f72fa6ba-e55a-6bb6-2efe-60458802c870@nvidia.com>
References: <Y0WMXSv8REysoqFy@do-x1extreme>
 <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
 <Y0XOoSmfwAdfOD9g@do-x1extreme>
In-Reply-To: <Y0XOoSmfwAdfOD9g@do-x1extreme>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4125:EE_
x-ms-office365-filtering-correlation-id: 3d0abbaf-c35e-4174-f513-08daabc5f1cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  m8zvfBC9/ksHLTEwFX1cSElKziTCctA6MixvvOILVIXDIE+59406acddUWmSNZ8WO7b0GD4h8NepHxD3wLOw8V92bykcx/q71sW+pRGeP1GHQf46wEUnXugmM/WSzyxe7sFO+g3bLZ1uzPP/CrkvSrQxisGYMMn7bzsfVIFO9OipjePSUfOw3zUfwclIgRMRzlMEw4PyQu2hXt4+OLJVWzUV9ehyU4vw830nWrhD8bto79BJktKMEkwPBoiB4KeUNyJ8o4zW10C34i6M5V8CFCYhEL2hDww2UUuCJhQ5+j5j0XWWoMqz4HdTjew54l/f1hx6JwIsXhhBE0tjx2Di00OU3g8X5PE+0jV3p/X2BxOPc46a2swUqNPYYmVQqIk2lrGZRXAGY1PTcuIIg7KZRp5JPyaiO0lLlkCWRFesFYDj8nLkWZg0lJVFJBqVUKcIBgSsrsPkmGgL5hrIV6gTYa5H5CtXBbb8eaSWGOJFEjLElBUTmPLl8IsNTcXyhY/kxSeW3+t02pCvFLLFzQxi73I24TF+jYHiBum9ZZaOr8495UGPQNje0mlvl7+ynwrvTIvAq5mYAvgFNdjZ0387kin5R4EqB3KR5OCjil4ovYyrONNJYbIwqpOTOmJn/NjOHtzwFUeu5/Zd87l3OqBUZDVI4iWVCCh0fYf0EXX3LesbSsjTmYc+smpkxpd35acZVlgjVBo+YJqKi/viLZf5gckPR6w+OOLOgwPe1X0AioIeOr5r9kg05OgyXqtvn3V8KjMoFjxFIvLEqBbG0PryYX9TifHiqvNA58ksuO1wWUnR/jT3PalBIAtSJXoSWhRN+48vF/3So6vfWNNL9Vjniw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199015)(38100700002)(122000001)(86362001)(31696002)(8676002)(91956017)(6506007)(6512007)(53546011)(41300700001)(2616005)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(4326008)(478600001)(6486002)(71200400001)(316002)(6916009)(54906003)(2906002)(3480700007)(38070700005)(5660300002)(8936002)(186003)(83380400001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?OTZQaDRkS0tEcU5uc1AzT3grc1c2azZEbjBEL21MRllwU0cyWmRmN20rVjdT?=
 =?utf-8?B?Zlo1YlhDMVZxZThNZEdJUVhwMFJzOTlSTmtLZFBZcUQ4UDFFa3FyaU9YNUlk?=
 =?utf-8?B?dkNzYWVLY3FsempHd2ZjeDFla2ZKeWNLUkhrQjJSc0hzbFVQcURsMXBmdG5X?=
 =?utf-8?B?Y3NWUmJsU3Myd3BiM0plbGkvUWxycmswd01ScDlBY05Td2QyN08yaVdDR05E?=
 =?utf-8?B?RUxZQzh4dnlEUGNHclFhYXFLbnFuQUowUWtRcXhQQmoyMFM1OW50WFdubHpB?=
 =?utf-8?B?cE1DN0RVMk5VR0JjeWxXblFnZTFyeE9BRmt0bWxSYzAzZlF5TWtiRkU5T3lt?=
 =?utf-8?B?ZTNKaXlTdkNUb2pETjlFSnEwWHh1Y1BjWEFEcUtwVTlqSTFQdFd5bkgrdm1I?=
 =?utf-8?B?eVBuVkJ6VjhNeDVLb01DTytWOW4zR3hONitHOHVJaEN0bmFoVnVKMjRseWVr?=
 =?utf-8?B?M01HVzNyaGVWdG4zRnl2dzM1cHU2UkxYTk00UHVlSFNWM0FyU3RoZU14WDVm?=
 =?utf-8?B?ZXFQVUp1OGIwZ2w5T09CN0RqL0I3Z2ZJbVEvcVQ5dEpSUkdZbExIRDlyVTN3?=
 =?utf-8?B?YzRxbXVvWmVud1c1d285NDFpRkh4YmdhSmJEblBSWFUyaDRWdE12Vm5WVzA3?=
 =?utf-8?B?elRqVGc0YlVaOTBwYk5SZm9mZWhKVEIzeFg5WkV4dnZKbDU5cVJUUDVGMUhL?=
 =?utf-8?B?YVZjODBORmtBVzV4V2hXaGFNVUdiWUFjWVhBYW5FY3BJaklWZVNFcDRrdzAw?=
 =?utf-8?B?UmRydnFmK05TS2pkUVV0UE91bHhRSjIreExpL1pvVEtWbm9vNlc3S09jQzNR?=
 =?utf-8?B?RzB5MmptZWQrREoxVkFabHNIcFhDZWpyZUdaRzNGZU5tbXJCajg4bjIzQjVC?=
 =?utf-8?B?aGUyaFBGQUdwWnZDVkxFM0JyeWxwYmNUc1BxN2d1bDAxRE4vRWJyVENIekJO?=
 =?utf-8?B?K25uWUsvOU51UFFyMFRFYWFLbnp2TmVXaHBIQzRyN0V5NjVLcWMyM2lhcjFN?=
 =?utf-8?B?U3RGRlFZYlhENExjbFdnSTlUejE2MW5RSEppMnZoQXJmVDhKcFdZc3YrbkVT?=
 =?utf-8?B?dFFyRXp2YU1OTjc0N2hSbmYrVGJqNzdtRFdQNmx6VC9xTGVFbnFva3hzT2dl?=
 =?utf-8?B?Ykt1Wm1MM2Q2eE0vSXlFOFl3cloyb0oxY3plSUU2bnhzQTdoWFJRTDlaa3Vx?=
 =?utf-8?B?eXd6SGpjdnVYYm01bk9JQXVXcmFQR1dGQnpyVXJ3ZkpEU1A0R3Iva2RpcDdh?=
 =?utf-8?B?OVJ3TUY1Y05HenFWTnNwalIxNy9UYnZqb0hocklpODlZRmc1WmZZbjdqMWxa?=
 =?utf-8?B?YVhFNndiRTVxVCt3VmtiNU5pOXFWMWs3c1NsRzFwV2RUMm5CTGY5Und4V3ox?=
 =?utf-8?B?WGlkK2R0dGtBRDBaMWNBWjFZVStONVY2Mk9KaGpEaG1JRG9qYkEyd2JFSmlM?=
 =?utf-8?B?WWRQL0pwVEFGa1dzdHVSbnBvOFdWdVNDaEhxaklUU1JFQmhTYm9mQlhFVmZy?=
 =?utf-8?B?SCtLckE1RzM2Z1VtTVdkckxxZUM0Qi9hc1Y5WWpCUUlLeTl1dzFpOXl2L2RQ?=
 =?utf-8?B?aGtRS2ZtNXRGeThQK1FJcUJrVUgwRVFtMzRDeFBNT0VkNkNxd1o2Y3hMY3hk?=
 =?utf-8?B?bUZJRkJEY2wrbkliNFFKaTVyaHk0bHpsTGNIa0Jib0hYdUhwWXQ4blZPM09m?=
 =?utf-8?B?U0lOT2gxMWZJUngva1dhcFcvRW5YTVoyMjlJeWIxTVBVc2pMNG5iWXprR0Nx?=
 =?utf-8?B?VGtBMWlrdWsrKzB5aEg5eWVBa3lBOUliYzFOWnhaNWdYamRoWXQwcWw3SU9r?=
 =?utf-8?B?MXpsZ1dFVGN1SXVuUEpUbFA4WEthUVdHalBQTkFyQXRFTUM5emIyMmtWcUtI?=
 =?utf-8?B?UmFDangzaDgxTjFFZzd3alF4RTB6d2pzaXVrck4xK3JVeEpsUVVLenk0WWRy?=
 =?utf-8?B?RE5RbithdjB4cWhlWGJGZUlrNTgvSUFEeWxDeXd6NFo1WGF1ZEwwdFF6bWJn?=
 =?utf-8?B?R3dFcGFTcVFxMjNtOXpBWGpmbjZHZjl6emZnUFVlb0RBZ1lFY3VrdTlNSU1z?=
 =?utf-8?B?QlAyeE9KdGJtbnU1TXI5WmR3ZlMxMjNhWFg2NUlVa3hwZW8vOGZkak9RQlhW?=
 =?utf-8?B?Q2FqaEN2OEJPQjNBNkJDYUE1S3F5bDdNV0NaQ2pXcWVvbzN1N3ZXUGpyTXl4?=
 =?utf-8?Q?xC3tM/kjPwlDCKPXvUr2eMno1goQixG0zX33ZZ7qYhyR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F958F4D4B4B044BA6FE593B7FE8D9B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0abbaf-c35e-4174-f513-08daabc5f1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 20:19:47.9838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fe5n2YBp81KCresMdswymtNHoEujdEFO1D2adE/rrq7ulwfyCEKq7VXyCtfWAXoLUHonFoA5l4kGP59YZuSKSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_131958_248701_78F8B118 
X-CRM114-Status: GOOD (  23.01  )
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

T24gMTAvMTEvMjIgMTM6MTQsIFNldGggRm9yc2hlZSB3cm90ZToNCj4gT24gVHVlLCBPY3QgMTEs
IDIwMjIgYXQgMDc6MzA6NTZQTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4g
SGkgU2V0aCwNCj4+DQo+PiBPbiAxMC8xMS8yMiAwODozMSwgU2V0aCBGb3JzaGVlIHdyb3RlOg0K
Pj4+IEhpLA0KPj4+DQo+Pj4gSSdtIHNlZWluZyB0aW1lb3V0cyBsaWtlIHRoZSBmb2xsb3dpbmcg
ZnJvbSBudm1lLXRjcDoNCj4+Pg0KPj4+IFsgNjM2OS41MTMyNjldIG52bWUgbnZtZTU6IHF1ZXVl
IDEwMjogdGltZW91dCByZXF1ZXN0IDB4NzMgdHlwZSA0DQo+Pj4gWyA2MzY5LjUxMzI4M10gbnZt
ZSBudm1lNTogc3RhcnRpbmcgZXJyb3IgcmVjb3ZlcnkNCj4+PiBbIDYzNjkuNTE0Mzc5XSBibG9j
ayBudm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJL08NCj4+PiBbIDYzNjkuNTE0
Mzg1XSBibG9jayBudm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJL08NCj4+PiBb
IDYzNjkuNTE0MzkyXSBibG9jayBudm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJ
L08NCj4+PiBbIDYzNjkuNTE0MzkzXSBibG9jayBudm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJl
cXVldWluZyBJL08NCj4+PiBbIDYzNjkuNTE0NDAxXSBibG9jayBudm1lNW4xOiBubyB1c2FibGUg
cGF0aCAtIHJlcXVldWluZyBJL08NCj4+PiBbIDYzNjkuNTE0NDE0XSBibG9jayBudm1lNW4xOiBu
byB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJL08NCj4+PiBbIDYzNjkuNTE0NDIwXSBibG9jayBu
dm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJL08NCj4+PiBbIDYzNjkuNTE0NDI3
XSBibG9jayBudm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJL08NCj4+PiBbIDYz
NjkuNTE0NDMwXSBibG9jayBudm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJL08N
Cj4+PiBbIDYzNjkuNTE0NDMyXSBibG9jayBudm1lNW4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVl
dWluZyBJL08NCj4+PiBbIDYzNjkuNTE0OTI2XSBudm1lIG52bWU1OiBSZWNvbm5lY3RpbmcgaW4g
MTAgc2Vjb25kcy4uLg0KPj4+IFsgNjM3OS43NjEwMTVdIG52bWUgbnZtZTU6IGNyZWF0aW5nIDEy
OCBJL08gcXVldWVzLg0KPj4+IFsgNjM3OS45NDQzODldIG52bWUgbnZtZTU6IG1hcHBlZCAxMjgv
MC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcy4NCj4+PiBbIDYzNzkuOTQ3OTIyXSBudm1lIG52
bWU1OiBTdWNjZXNzZnVsbHkgcmVjb25uZWN0ZWQgKDEgYXR0ZW1wdCkNCj4+Pg0KPj4+IFRoaXMg
aXMgd2l0aCA2LjAsIHVzaW5nIG52bWV0LXRjcCBvbiBhIGRpZmZlcmVudCBtYWNoaW5lIGFzIHRo
ZSB0YXJnZXQuDQo+Pj4gSSd2ZSBzZWVuIHRoaXMgc3BvcmFkaWNhbGx5IHdpdGggc2V2ZXJhbCB0
ZXN0IGNhc2VzLiBUaGUgZmlvIGZpby1yYW5kLVJXDQo+Pj4gZXhhbXBsZSB0ZXN0IGlzIGEgcHJl
dHR5IGdvb2QgcmVwcm9kdWNlciB3aGVuIG51bWpvYnMgaW4gaW5jcmVhc2VkIChJJ20NCj4+PiBz
ZXR0aW5nIGl0IGVxdWFsIHRvIHRoZSBudW1iZXIgb2YgQ1BVcyBpbiB0aGUgc3lzdGVtKS4NCj4+
Pg0KPj4+IExldCBtZSBrbm93IHdoYXQgSSBjYW4gZG8gdG8gaGVscCBkZWJ1ZyB0aGlzLiBJJ20g
Y3VycmVudGx5IGFkZGluZyBzb21lDQo+Pj4gdHJhY2luZyB0byB0aGUgZHJpdmVyIHRvIHNlZSBp
ZiBJIGNhbiBnZXQgYW4gaWRlYSBvZiB0aGUgc2VxdWVuY2Ugb2YNCj4+PiBldmVudHMgdGhhdCBs
ZWFkcyB0byB0aGlzIHByb2JsZW0uDQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gU2V0aA0KPj4+DQo+
Pg0KPj4gQ2FuIHlvdSBiaXNlY3QgaXQgPyB0aGF0IHdpbGwgaGVscCB0byB1bmRlcnN0YW5kIHRo
ZSBjb21taXQgY2F1c2luZw0KPj4gaXNzdWUuDQo+IA0KPiBJIGRvbid0IGtub3cgb2YgYW55ICJn
b29kIiB2ZXJzaW9uIHJpZ2h0IG5vdy4gSSBzdGFydGVkIHdpdGggYSA1LjEwDQo+IGtlcm5lbCBh
bmQgc2F3IHRoaXMsIGFuZCB0ZXN0ZWQgNi4wIGFuZCBzdGlsbCBzZWUgaXQuIEkgZm91bmQgc2V2
ZXJhbA0KPiBjb21taXRzIHNpbmNlIDUuMTAgd2hpY2ggZml4IHNvbWUga2luZCBvZiB0aW1lb3V0
czoNCj4gDQo+IGEwZmRkMTQxODAwNyBudm1lLXRjcDogcmVydW4gaW9fd29yayBpZiByZXFfbGlz
dCBpcyBub3QgZW1wdHkNCj4gNzBmNDM3ZmI0Mzk1IG52bWUtdGNwOiBmaXggaW9fd29yayBwcmlv
cml0eSBpbnZlcnNpb24NCj4gMzc3MGE0MmJiOGNlIG52bWUtdGNwOiBmaXggcmVncmVzc2lvbiB0
aGF0IGNhdXNlcyBzcG9yYWRpYyByZXF1ZXN0cyB0byB0aW1lIG91dA0KPiANCj4gNS4xMCBzdGls
bCBoYXMgdGltZW91dHMgd2l0aCB0aGVzZSBiYWNrcG9ydGVkLCBzbyB3aGF0ZXZlciB0aGUgcHJv
YmxlbQ0KPiBpcyBpdCBoYXMgZXhpc3RlZCBhdCBsZWFzdCB0aGF0IGxvbmcuIEkgc3VwcG9zZSBJ
IGNvdWxkIGdvIGJhY2sgdG8gb2xkZXINCj4ga2VybmVscyB3aXRoIHRoZXNlIGJhY2twb3J0ZWQg
aWYgdGhhdCdzIGdvaW5nIHRvIGJlIHRoZSBiZXN0IHBhdGgNCj4gZm9yd2FyZCBoZXJlLg0KPiAN
Cj4gVGhhbmtzLA0KPiBTZXRoDQoNCkNhbiB5b3UgcGxlYXNlIHNoYXJlIHRoZSBmaW8gY29uZmln
IHlvdSBhcmUgdXNpbmcgPw0KDQotY2sNCg0K

