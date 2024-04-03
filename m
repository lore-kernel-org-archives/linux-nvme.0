Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59D3CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 22:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BWGjBkZQVxioon5nNDjXtDv/K8tmWD3Tf4BysnDuU8g=; b=mtmDc2ovi7trdVe9eEAVzMaMEP
	viWhTcetEzA9+etp9mcX0Q6SJsXA9jezCPkOm3Und+Zcej9KeUiQoZf6BxYv2kXVMdo5fLMW4EGW+
	q+3fFuUqXvSIcTxE5e48dZ7PFJ/g1wV7NsijO4e0GX1ms+qauB6Z8WudGDCgVDZiaoapuV+L7ZqIO
	I5NoZRTkAET0cIZIHl03tEb3YyUM2MpuX37sY2jWCHgWcGKusqd+4Se6r6WCv3xfyb/1QLm3cSJf2
	I5imq9ZMMDglMDNJEWbsgoiQjwNmBnFW/5UfhU0X5tGn9WC7NzQX1b64Sie46OP3bg/A0CCBo+Wxx
	ouw9cb2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs8v6-00000000MkZ-3GsB;
	Wed, 03 Apr 2024 22:17:24 +0000
Received: from mail-dm6nam10on20706.outbound.protection.outlook.com ([2a01:111:f400:7e88::706] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs8v4-00000000Mju-1nUb
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 22:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xxl2WrMqymZ1m2Y+aglbZklKabaTTOlZt8lXc6tWHPYaETxEyGRD8XFH7iW0kAel0sccs7A6H8lglr+HHkJBmXyh3NbOSCK1LYh/z9TEWjIuPdwmTYvVi4Efa7wVt/yEj7z6d8SE940O7EjzSXYSDfw3CCpr/zitYZy9Xz3fImlHEKPFfvh0iwnUIY38dPXoLUZvlY9OmN9z0SNl9kqyaQEd9AFC/btgFqzUdiSRp7qQXZwVoLjvP0ilWI77pPKOOZeAlqj/hHxK109SALR8oySi2R/GDcmfrCJOMJuCo22x1b2asRdql4Wl5JfYykmLsu/yaKxoHLw95P447+s+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWGjBkZQVxioon5nNDjXtDv/K8tmWD3Tf4BysnDuU8g=;
 b=G7L1fFI/JE+MHIp3fBbwVwpOOOGFQDN7GPop6Qj39KTEKLaOt+/0whzWQmqTzC7/jkjxoLBZDj+b7/K7dsynMIQRQ3neEXhdxH7QQ89LbVaK0n5aGTMPwyXIwiwOmj39mzltMPe0Bw/GWIYyLzYDVEPW7sTRlFxuHM3H07Nx3qBVDXZ25MMwStormqS06DO53VlNCzdvuVDgn/SW6xbfJ+AeUMgi97X1aFdTE6zd0meFk09KxcB4xqyoloABVdA+bG10Z/Yuggcfq6pJjvqYvT6mGw/r4kAZlQWNxti8YQQ8xMPq9yRiD4Fmfx1vUbBhxkzRW9eQNOMcm5yrRRTcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWGjBkZQVxioon5nNDjXtDv/K8tmWD3Tf4BysnDuU8g=;
 b=fhDLheo2FP2oBBzzUWIacax9msDRYcDw2z4wzhzAd9SaSsaZH8lwxo5Jw5EFrQ42XaafpCFDYnCniouc1wsO/94b3+MYV/WYpfFUq902tpr8KF7YyaXkxWioUvQLIH7AAOc/FHAj2Hqw6mLrhnOByTGSPz0ZzPcyC+5O43j/zqTP1Qwchs/v6IQ/LWJ05NsjX7Q+kZP4Ih+V4/diecWNxWD3PjR/jPY8uvZXYGzlcwP0KOfA0dCMStv0HBwc23ooDlLyefHQYPQUsS8mB9MhGssECt1hlWCPZyrG2Z1GPWDs/FjF0pqSkSs9YM+z6TErgTCo5LaxCZDyogEWP1rXMw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 3 Apr
 2024 22:17:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 22:17:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv5] nvmet: implement unique discovery NQN
Thread-Topic: [PATCHv5] nvmet: implement unique discovery NQN
Thread-Index: AQHahbqHviYdafhyEkOO3+TsZdj7BbFXHeGA
Date: Wed, 3 Apr 2024 22:17:10 +0000
Message-ID: <4bb91f36-c051-487a-b2a6-c6e7146dcd72@nvidia.com>
References: <20240403113114.76342-1-hare@kernel.org>
In-Reply-To: <20240403113114.76342-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4056:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ynO6bjJJyoMrY50KbKV4VWGB+2JsgW+4okDjBa65i073vRpMgXRx4HkirMEHaPVONw7l3NRrU7/wgIfeLi4ftUzvKELfC88vEuddtuIFs/L6W/M8cKZ54aFIs1wnQuS1scVmh2jgvxt1K4jxjceob6S3CTdYw5iRN27izjcZl11r+nzuLDXBAxdpQCCWfL2LHipHsFSQ40QAlRhcStNB26xdf1ubzSPkmg5pY4I/zg6oHoHRNBg9GwuuS3RFlFlwQwq+K6NOJ9wn0MqcqsZS65vjVlTMgkgEi1qx0gOeMnvEa3coE8SfbQpEp/v2Dqa2eHzf+DAs4/jm2ZzyQSGtoYaNEP8Hhu9yz82T9qKby1N+jWc++WRmArD+kpE/gvsjiYZfoWb5ZGBGMsFId4kOnKNVKZwkfXxrUsLU/UxQmNdC4rsIHxGpTiRKGloCZueaTkZm/XZc6fFN2bTBgs60ccAWO6J/6rtyutLHdbIfwMnHVAjc47RKZX60+zP6uRHYARLFghaNPvy4qj26G98+y/IvY6nYpitxbdQGwR0x0anetf1UH19WX8YAujcibieNUlsuzyfI4x8bQ0U/86kUYDTQxWL0VkhEFbYzPbC/BbmWoOo6e/NBvMNJW7LrJDQlSEynPuVBP/37ZKZDPViYb4J+fFf7nU3b1IQdVx4a4w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU9YNlJDMTRKM09raVZ0MGdJUlgvK1V1dFVybG9odzEzSjg5UERzS2JnZDFt?=
 =?utf-8?B?KzE0clkzc1ZDejUweFlaUUJja0dYb3dSTVdjOFdLZDM5dHNnSGhyUzdvTDRJ?=
 =?utf-8?B?TEM5clZsKzhTVmN4SXZHeHNNTHdJMUlhcGdkZVI2NEZkQ2lrd2REODNhenpu?=
 =?utf-8?B?dmpxdURUMXp0akFsaFRMMWFGaUt4MWRLQ3FCTTBoTEZEWVNYVWtJNHh5aUV5?=
 =?utf-8?B?Y3NtM1lYSVd2OE1CdktTLzlzVkVpWHIzaTNadU5zb3pGZG1FNXo0aEpqRzNS?=
 =?utf-8?B?WXNIbjNhbzRpTVdVdTVxTE9xRW5oYW5vczg2Zzd2T21xZm1JdG5oN09oazJu?=
 =?utf-8?B?N0cxeXhsei8xSVAvQ2YwdUZBNlFnRjIzZzVUalFtOThZVTJ3N09SbnFGell5?=
 =?utf-8?B?bTBHZ3Z2VWhlSHVzalFaOEt2dWJSOVB6QWpoNHdMekRxeXdFdlhTdEVZRkgr?=
 =?utf-8?B?Y0RsL0M1Si92SDlxMW9nOVFONWNOWUZUajRvQ09yb0FFM3I1UFNWV3B4OWg5?=
 =?utf-8?B?VGhlUkU2UkZTZWRXalNkNVRVcGhaczJtbkZMKzduRXBCMEdxS2M5NzZwY1Rq?=
 =?utf-8?B?S0FzL2J4K3ZDdGhkM2FLOUJRazZBekxqRC9HdlE0clRvbkx1b0JUTzdvZFFL?=
 =?utf-8?B?UkFmNzlwbWtzbWJmUzRNT044UFpYYVBja0RxcTJGa2Mwb2MwcjJrTWx1OTQ0?=
 =?utf-8?B?QWV1T1YySlFldjF2Uk55cVk3YVRuN2dIZTRZZ3BqbmVsMVNISFd6Q0ZySzhZ?=
 =?utf-8?B?TXJvWUgveFZEK1RhTS91UzJad0VRbDk0R2xadldEOHZtc1FrN244WGM3SnM3?=
 =?utf-8?B?blZ0ZWNITGNmWUdKZDlweGY1TjBVcmMyTWRIU1pxd2lVNHprLzhvQzZMQlQ3?=
 =?utf-8?B?QllpakNSTDlnZGZ5QXlqV3dUTThQalZZdURCSDJGUFJyMEhacytXVnp6SU1V?=
 =?utf-8?B?a2Y1L1BTOEFaeGsvbWc3cE9RY0pndXFxdXpyMHh0eUZQUmpWcEpnSWE0M1cr?=
 =?utf-8?B?dlJUZCtkdStvaVFZUVRhUUhld0pMSUxYMjhnZkVPWGJyVVkzWko2QlA1Sjd1?=
 =?utf-8?B?N1U3STRGMFFCdHJ2ZU1CdTBEYXhlcDdwV2tnSmtnSElxSW9TMi9IaUxyS2Vi?=
 =?utf-8?B?RG9HbFlRN3E1N0JGL2FIdm0wcS8wSzYzQkp3UEZOL3BEbk45dmRJbFR2cFpp?=
 =?utf-8?B?Y3JtTUlKbEJhVmh1dFBGUDZnV2NwUFdZS24xRkZuQ0NyYlp1czdvTzZKYlFy?=
 =?utf-8?B?bHU1R0hPZU5DaHBnVGp0K3NuVlU2aUZLODFCNkVWTXJZdm4rbHlDTG1ENkxs?=
 =?utf-8?B?dnE1bnJPMndEM0JheTEwczl0bUZ6VWQyM0VGYmVNTzZFbDFqZVdLb3BhdnI1?=
 =?utf-8?B?a2dUZkd3YmQ1dHRPUUY2c3VpVFEwd3dNSWM1ZlV1OEs1K3ZHRjMzWCtWVHo1?=
 =?utf-8?B?M2h0dlRhaXBjazhUMnNSd25XY0NzWFBENVJLN1QzOGFiOFZMRXZQVkl6OUdq?=
 =?utf-8?B?cDFQVEQrSWVBcVp2b0hOZ1g4bllISHIrc2t4aVh4ZmNoTUt3Vnp2Sy9QRDNm?=
 =?utf-8?B?aWJaVC8vWTFKcCtEczNPODAybnJmUHhRRU9qb0I5Y1F1aVhXdW41RHNRc2VU?=
 =?utf-8?B?NVFjMDZRdnpySXR3VUFVZ3Rjc0xKWjJnMlk2UFEza0Q3UzlmalFVK0hUSmgr?=
 =?utf-8?B?Z2ZPOFM0SStxRkNpWXRCRVdaWmhibEczRWEveVEreVUydEJOc3ZOb2RkenlM?=
 =?utf-8?B?M1k0S09rS3lxMEYxRUFhbWZiclM0OWd4ZzFTUng0T1R1WiszbjNLdmc5NzVv?=
 =?utf-8?B?TGtqT1ZwbUFYTTZYK3N4UEU1ZE0xM0NtdTJyNjlqWENGdTIzZVJJdTF5dTVt?=
 =?utf-8?B?SHpYdFJ2L2wwTm9ENmJLS0I5aC8vNjB4WS94N3BsN09mVEZZdUMrZjdheDRW?=
 =?utf-8?B?bUM3Z29nbTBTL3JuWmFwNDU4YXh6Znp5VWQ3Y05MNHVpdW1HK1lYL3pSalFn?=
 =?utf-8?B?VFNRcXU0TzZjd3l2S055QmgwaG1XVGlDK0VaMi9SNXpmYkY2OG1reVJBaytw?=
 =?utf-8?B?M2pFSjY2WDVkOEt4a1hvNjFsK3BoU09IYVpLQ2o0ZEYyYlAwTWRxOFRaUXVj?=
 =?utf-8?B?WFUxVCtENjl1elFNL2JQWFhHQUNrcDBIbjRiYUhFQ1dnMVEwRlIzb3VtZ3h3?=
 =?utf-8?Q?dRi6sra1v1cH09jQAn3nf2Kx23cbPp5kP4ajbeKwkgMd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3F7CBE9365C4142923A43C9B151A3DA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a3a68b-e070-4dba-0cba-08dc542bce6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 22:17:10.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChIbozjk4tAxWOqoYO2GNXDYylNzhwgIHP16OVCaVMphoOY/b4+igrNPniX9FVhUY8B063pFEpnMjKChFyctKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_151722_580961_965DE0B5 
X-CRM114-Status: GOOD (  10.84  )
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

T24gNC8zLzI0IDA0OjMxLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IFVuaXF1ZSBkaXNjb3Zl
cnkgTlFOcyBhbGxvdyB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gZGlzY292ZXJ5DQo+IHNlcnZp
Y2VzIGZyb20gKHR5cGljYWxseSBwaHlzaWNhbGx5IHNlcGFyYXRlKSBOVk1lLW9GIHN1YnN5c3Rl
bXMuDQo+IFRoaXMgaXMgcmVxdWlyZWQgZm9yIGVzdGFibGlzaGluZyBzZWN1cmVkIGNvbm5lY3Rp
b25zIGFzIG90aGVyd2lzZQ0KPiB0aGUgY3JlZGVudGlhbHMgd29uJ3QgYmUgdW5pcXVlIGFuZCB0
aGUgaW50ZWdyaXR5IG9mIHRoZSBjb25uZWN0aW9uDQo+IGNhbm5vdCBiZSBndWFyYW50ZWVkLg0K
PiBUaGlzIHBhdGNoIGFkZHMgYSBjb25maWdmcyBhdHRyaWJ1dGUgJ2Rpc2NvdmVyeV9ucW4nIGlu
IHRoZSAnbnZtZXQnDQo+IGNvbmZpZ2ZzIGRpcmVjdG9yeSB0byBzcGVjaWZ5IHRoZSB1bmlxdWUg
ZGlzY292ZXJ5IE5RTi4NCj4NCj4gQ2hhbmdlcyB0byB2MjoNCj4gLSBSZXdvcmsgYXMgcGVyIHN1
Z2dlc3Rpb24gZnJvbSBDaGFpdGFueWENCj4NCj4gQ2hhbmdlcyB0byB2MzoNCj4gLSBVcGRhdGUg
Y29tbWl0IGxvZw0KPiAtIFJlYmFzZSB0byA2LjkNCj4NCj4gQ2hhbmdlcyB0byB2NDoNCj4gLSBJ
bmNsdWRlIHJldmlld3MgZnJvbSBDaGFpdGFueWENCj4NCj4gU2lnbmVkLW9mZi1ieTogSGFubmVz
IFJlaW5lY2tlIDxoYXJlQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBTYWdpIEdyaW1iZXJn
IDxzYWdpQGdyaW1iZXJnLm1lPg0KPiAtLS0NCj4gICANCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

