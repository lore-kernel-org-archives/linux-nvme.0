Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDCCC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 02:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9lozBeKVl6375IfY9+sAdBAkyC8LDJ8PY49k2V5TtTE=; b=IlYomYPUvu7qMD0FwhlMazmaIk
	Fb3DI73YZaqowF6yWOGh0B/NgH8Ya9zc/JQZ9gJ03ddZ9HW/lMMdwbi+ZsCSSN0w4BP+kh0tzI3Hr
	QQUTIDD5fAU2WPPZqd8JGZWC1V0qrxslSwR/5hs1bxCWOZDRd6WlffwGL56BSdSlx8XjiDuQxbWy+
	uQj10EbXj+R3zysLQOOheBFsQwxrAmWnH1zKD5InvAlld4BibpY2frSqhRDwjBqqMHDjSzShXr9EO
	xMQ+IpCapNe6hjfq/kRc+Pi8RD7l4vVOaszxtUVkTNF9Ha5yZTPFiC0GoTMh184XqlXcbm2BzXQs/
	5oEGXqMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYvK-0000000AaMf-1nh5;
	Tue, 16 Apr 2024 02:51:54 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYvE-0000000AaL3-2ve4
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 02:51:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6MuBbpmcAawVOCaOwtRgskHZ88U1EcbDr+Krf6NaWTxIVtSGnUwE+z56bjfNF7op0hC1kmloF7P8r4TfcJdp1RrsNfrXWoV9Y+NapORMX3H3UabVEBYfT15MOdZfCF62cSj6swfeEhcSJqlRPXO5XrOhyjOBGmkHTeIEM0UafgEnQ7He9sME/hWhvK93erunZVsSw+HHNMzQO0F7pr3ANZtDcL0/VOgO7g0E2r43IknRMoVPjGCChqSYVhwlwHJE//DBXXRC7aFszDjz1kfwlK+fmG7px6vJ1L1Fcy4Zpc4++rKlDU4swRiG/pLbuXXw+/zc8gHFt0AAN5pdezLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lozBeKVl6375IfY9+sAdBAkyC8LDJ8PY49k2V5TtTE=;
 b=X5N/7PoyVuopxrkS/aSHr7JNa8nrrSUk0NHmxig/teX71kOk0UMDvJ+8KOt5y+TouEnTiLbCz4y2/7rwdwtE8kQE0w6vRTwunbf16syNHFRk0i/44fOFy6yG8y5xIVD7vMfWxASVfbBgveX++JReWKZ/eUsjSxnwymGnrpQH44UIvPFHB0vuATw/4Nd1Dt87ctTavD/ALBTjpRTsQYkbvf4RUUU7w9F6iy4GOvcJUPT5o1VJIfiY98IUxDk1ENSZ5Hjqw0e2SOk3pzMmHE+ecgRY+aoehm3mIKekgrnEe46J7fNWPyyBZTwu3m6NOiqGUX5b5VstZ/jzy/AvBjwCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lozBeKVl6375IfY9+sAdBAkyC8LDJ8PY49k2V5TtTE=;
 b=aB8uO+lg5+FK3gMfN4BivUnfTH+sM75Auq/HQPDizslyq21RoeW8D/cKdlKp7dvsOrjyoyK9Tjsoknp0PVcHSfL/p+iwLmor2FHK79iDqiHHi8VwD/r9PUpF2vIQueJmYf6pe8Yj/fbvFoszT9R1x6R4gafNpMfSz9FEfeW/ir5sq5tUk4FrvfxbStiQkKaIX3XkGKRJKS8jgTgh11T33Y9iYZ+UttG/BOk5lGZSlUB4XdPB0xQ+R8NhTzn1xXKrSEAYa77F5U97beIF4mh4AaJSLDv4OVQB7t/k1wWj6Hld8LcSeoLnpbA6u17ZEpofIm5nmhZPKdLdRiiVYcg1bg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:51:44 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:51:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
	"dwagner@suse.de" <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] nvmet-auth: replace pr_debug() with pr_err() to
 report an error.
Thread-Topic: [PATCH 2/2] nvmet-auth: replace pr_debug() with pr_err() to
 report an error.
Thread-Index: AQHaiyypabhJQAxZb0ykUU3Vuxkc7bFqO64A
Date: Tue, 16 Apr 2024 02:51:44 +0000
Message-ID: <32f5f7d1-bf44-428b-a19b-982d5d1f514c@nvidia.com>
References: <20240410094842.370170-1-mlombard@redhat.com>
 <20240410094842.370170-3-mlombard@redhat.com>
In-Reply-To: <20240410094842.370170-3-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB8129:EE_
x-ms-office365-filtering-correlation-id: 5d50d65b-822c-499b-dd5d-08dc5dc026bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lETKbRlmJtk5kf6JS9HVSC3ZIA8/BILfc03xcyHcRDm4THEB8wM02yYVIYdOIJ44/Q/oxJkvjMyckimMS/LCxOuYicFUqBfrkP6h7Ym7N0x+2SKk5bp3It9dpKUAwno/DnaUGDDR7wpnPreJmY881f94C/ukNDUJsEa/HnWTOV+6nnavg2GGBWeMJCgJsmohNFRZgKFpN6d8ghes4+f8JbO53PWjNnalJNPOH2tfIOxxKGmfGd8elb7V4lptoWw/HsIiG3cEgC33BoBqYN+yvjUChnuzxAVyCWkTS6ExwmBRIHjlcjrGLAVV8YNmkXlpPOExNnP0t3YcHnKTgKJenLjKjHHygwQosgMWAlI+kASKTXJAyrwDmsItINSxX/S5PzTQuJ3SNaSJYnvozb8I6rkSRrrKPpGYybWCTkFS/xSaMabBGgJTjGiZySmXvILvSqlEPq67/zDZg+BCG5ipx5Iab5jv+g42z9FZcg0TwSmQDymRkH9ymaxHl+tGP0sZDfhqrRHyGDj8FoiIpBvAjKxXypbKhz+BH0lsjmYAN3uGmhW5SLMOOD3fQcw6PJWpEQZVHgx+w31JVpSFJCqHWifnD+8WgIdcH9ifriid0DU07o8G1+ImxR5dnWiED0N0P+FyOHzzF71sikh0voArjkz7HBZkQau31uIaQq4QGezVjR13M/hT95GGbx/VacnXJ12OcjKmWo4qCsdNGUBmEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkVheS9sRWpZdUxIYlVnVCtxR2JXNnk2OVByU1RaME1aK3Bvb0J4dmxKVnJi?=
 =?utf-8?B?WEpTSU0wSHZkeDNzSk54YTdPbXVTbU5BczFtb0NmMENTNERqNWd3UUVkS1Vo?=
 =?utf-8?B?RFYyWGx1cnFndEt1eEJDbDZoUUdFdUF0MFN6cVV1U0dCUEgvNHJCSm5hQlJt?=
 =?utf-8?B?aUtGQXZWV1Fqd2tRcDBON2FuQ3RUbVBza3hKVWFpQi9iOUVXQi83Rm5mL3A3?=
 =?utf-8?B?YndXY0VtLy9ETHVadjd5c21uR1hYZHRqeTcwS0UyTWZqendEODJySStpOU1X?=
 =?utf-8?B?VmdVRGtLWEZmYnZiOEhCYjd6bnFaUUxFSW5LcHMwWHg4b1BZVXVmZE9STm5j?=
 =?utf-8?B?MEJTZldka2pJNkNxS3FQUVFGZVBnZEMvV0ptazUxT3psWVN1cGtHTmFBWFNM?=
 =?utf-8?B?bGRDc2oxRTJCd3hGbDhKMWpsdkV3aFg4NDhkbDBoYjNGVlBhaUdHMUJnQ0RJ?=
 =?utf-8?B?YjlJbkVUWmFsUmxMSHFWRjlHcS8welMydk5hbTNGSFp2NDdDbVVOVWRHUisv?=
 =?utf-8?B?R1JRWFhwVEx2c0hzWkUwMU1JVUg2TGxaQVpWYkJQT1BMM3dHNUpWRW40OWRO?=
 =?utf-8?B?czM4dW9obkJjdzUvTmRVUncyTy9DUHVEWFp6Y1h1SDYxZDlmclVmVmk2aWk4?=
 =?utf-8?B?OW93eFdjaWwrUDk5VEh4aWJpK05UV1ZyM1VuZnF6MXU5SnorNFpKbWNDTUpZ?=
 =?utf-8?B?R2dZUTU5ZSsxSW9OUlNBK1QzTlJCTk1uYWNnMVZjSFpZZklwS0EwOExhMU9h?=
 =?utf-8?B?Y2tlVDhubUV3ZnRhTGxuQ2NHQm9oaUhSVHhlWElqVTFEYTFhd0VIelFDOFRS?=
 =?utf-8?B?UXh3YWhCL1JTd1pqQWR6dytnTXRQZU9rL01VMGdTcXgxTnJyRWkvM25OYjd1?=
 =?utf-8?B?Uk1mc1dTZGczWFdqUmtFM3B3NXBhWmdFdXJEMVZyWnd3dlh3TkhvR3NycU9a?=
 =?utf-8?B?QmthWUJKbjExN2phRTkxRzNQazNBVWgrTG9OT3NSNk1Sa0hEbkJPTktHbzVn?=
 =?utf-8?B?VVlXNFNGZGRXQXBDa01jb2ZCYVhkNVRMSWl4aU51aTYydXJ5eHp5OVRGbWx1?=
 =?utf-8?B?eEFIbGhRR2hjQW9oc05Sc2dUMDFGTEFjUFZRdytxTjA3Z3VFOU9ZdDJnYnhx?=
 =?utf-8?B?SXU1K1d0SWdHdEd4WThaOGltWHBxanU5SGxOS1pvUXBuUFhjWVRiK3RTdzF5?=
 =?utf-8?B?VHJidngzaVc5c1JQcWhBMTN0cnlLRW1VMmRFdE84Wjc2Y3dVV2RPMDhMOHR2?=
 =?utf-8?B?Rk12dUhRQVFXM2VkRlVZT3VGVmhqQW8wNjRMZnpKeDJqakQxcmtncm5NREI0?=
 =?utf-8?B?UFRxWWhIbENCSVR5cmlxYXJhMkxEWmxhV1FGZU5nSzZTUVJFdnJ0cnUvZm55?=
 =?utf-8?B?OFpkTk9rUUFTRkgvbXQ5N2RSdlJ2SCtNSkdNOWZJQ211Q3VDaVY2NTNUSVRh?=
 =?utf-8?B?d0pHdGlpLzk4YXEvTy83VVdCUGQxNVp6b3VHS05KWXhWTXZDa3o2RXp2YXZK?=
 =?utf-8?B?bzBTTi9DMktwVE5tQitkUlBTSDlidmNhb0NCNnR0K2tsUk9zS0lHM2pzMXVz?=
 =?utf-8?B?Q3VtWk1iK0VBd3ZaQVQzMFI4VitpeEFxMXBSL1l6bVRxNVUzQmlUVE1SM0xB?=
 =?utf-8?B?ZmxpcG5VbHNUeCtqVk90aEFqZGEyVkxya3gybkw1TGNodm9nbzVXMXJLelBt?=
 =?utf-8?B?cW9GQkQ4UzVMLytvSjVsTFQ0UlluRnl1YnprQ3VoMFJVSE1sUG9hTFNKTHhL?=
 =?utf-8?B?YWtZeWpDL0Z2Tjk5MzBQaTNCeXpLU0ZLaENmYlV6Yy8wcXMxZjgxMGErK292?=
 =?utf-8?B?NEp0YnJnbzlveFE5QzV2VFNnZWxyTjFFVW5uU1hyTXI5Rk1lUlpYdSt2LzU4?=
 =?utf-8?B?TFBmYTFiOGZicFcrd29GcTFENEFFY0NURGVOdWVDSHNuKzY0ck1rM2tSNVpQ?=
 =?utf-8?B?Y0JwajQwQ3ZKekp6eEI1UTA1bXpUN2s5bWQwdTVhd1NHYkppZXYreHA2ejFw?=
 =?utf-8?B?aThVT2U2bWVPanA2MmdjYm5nUVJXZjVGVDJOa2xMQktWT3hPVkxsQTZNWHRt?=
 =?utf-8?B?RVdMWTU1RngrdzRzSmpFOXViVEF4Vy8yOUc2TWFjUE8wSWVwc3h1a2RCbGtZ?=
 =?utf-8?B?SmZwWEpYUWM4UzFFZWNpblQ5QlFYejVlSnl1OUxRcHJ5TnRLNzZ3UEJlbWR3?=
 =?utf-8?Q?aWOjSECkLy5wnv+KnoxBNGdM4u7L+lB5RKrHp9aAloHT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FBF5AEB89EDB04289DC242FB240CD27@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d50d65b-822c-499b-dd5d-08dc5dc026bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 02:51:44.4633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UY9JZ8RK95VCDltRKNveqUlGOLpb3GB/Y4DD8qLtrkBldlMh5+4EHdVvKVo8/KIzIDaKBTHvI7/00705YM4tmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_195148_820433_7425EDD2 
X-CRM114-Status: GOOD (  10.25  )
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

T24gNC8xMC8yNCAwMjo0OCwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IEluIG52bWV0X2F1
dGhfaG9zdF9oYXNoKCksIGlmIGEgbWlzbWF0Y2ggaXMgZGV0ZWN0ZWQgaW4gdGhlIGhhc2ggbGVu
Z3RoDQo+IHRoZSBrZXJuZWwgc2hvdWxkIHByaW50IGFuIGVycm9yLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXVyaXppbyBMb21iYXJkaTxtbG9tYmFyZEByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL252bWUvdGFyZ2V0L2F1dGguYyB8IDYgKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

