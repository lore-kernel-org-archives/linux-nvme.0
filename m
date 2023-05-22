Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8F7C77B73
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 05:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Epzgfb7V87KlIEnL1f3gyEeNOhuYeP7RR7/UxT+b7So=; b=g0WJyQKZ7e+QSRJ/cRnbZH4kzX
	y/iTf7k4irqJOB4Z5NEyVZ+3cyd/8sOA0oj4EQGBMJxCB7RwgQvxOumompthlbuDodXdcYpgBwAUM
	i137vCjoS/QhYcwNYknvpif0QUAQOJtpK/tysY9tgve8fu8kvSnxWD96Zbpr8kndRnMdC8s48DOpg
	RZSsF9GKueN5pgAtBmcblsGATkmGvGDr/oc3m9XIHxdrRUS7jQ3i5qW2tY0OQPP0RNyJgSt5huj1o
	8FdP3URtuJrm053cJ6IlRdnJpiSPFO623BfOadgYz/fr7O8GGBssda1KuJo0XAz4omTlAJpviHQ0r
	4e3ysfWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0yTS-005S4k-0h;
	Mon, 22 May 2023 05:52:50 +0000
Received: from mail-dm6nam04on2061d.outbound.protection.outlook.com ([2a01:111:f400:7e8b::61d] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0yTP-005S4C-0q
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 05:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhU0RBI6l0fLPGggiCyd8T2JVT7ITNbI3j4blMpIQHyx2CD+altwjrJC4EtQDW6+Ug1stZipvI0jCm7RIKcUNBcaHqdqWAXl/ZZHNehkbdwqnAfUiTrhfUhci6iAtTcKaGa2kXC6siUo0zTei44mylzNry2ONAMt2z6SWQOFGyDMrPBRe1pSfW1CXBqC/QqDOHzN2jYNYeNcPhCFWn4/ejiO3G2SbuhKbsMfvyIxdTRq/6vLi55Pepxn9XU/cpFBPIC99p/JFV+skn6uXEwsXKoXoc+KGo7aHKCdxe+lmb5PfjwHEmzm+NHGVgaMLQ0Zn96Rp3AGJ05rNXvh8H5DFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Epzgfb7V87KlIEnL1f3gyEeNOhuYeP7RR7/UxT+b7So=;
 b=diSS1d+YwKzv0ZHKFbfbZDc6jRZT0jEybi0U49xLs9k4YMYYR6jpaFB17gqyJ5gUFbBIbKCp24SumNxB3JDCJnPgnMhGvN/YwAW0yjMA8z05hv+0j2fxurnKQdS6HdL0uCcklQSij1xHEmXFSVbEzwW+nRYzYOdJQJCjk8C9Y2FkHHQuNt84dYTgALUt9Bu+sPIPpa8XHKBjZQ/7IHJkn/GQUt++ulfQek4t7PVcVdb7e3RW5upc6J4iD06dvk37YIBCN6Z97aqG7qKDQo4JpezAPTh6K9mMZnLeBIHoHkE1MzYcDX/tqyRanceCAZ8G16egnYgcDHCsnNhy6R5Omw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Epzgfb7V87KlIEnL1f3gyEeNOhuYeP7RR7/UxT+b7So=;
 b=seniGHJwKvR1mAskWyDb5VcJAMqea4xswqxvSYIwYjDLsgux1juqOzFzwGHqnyF6SkEb4ide+x/qbsRK1cDx0b/a4XQbmZj7/hEMJXA9SKId7w66YMyLVR3kTXs+QVY3zRdN5T29WBGp/52Br12bDwO5ciQdwKMSTCTvHwHzEzXw7o904S+iNwtzqzsVFwejQI+FhexM0VNwvWHmygRQJ+S6lBNuS+czJU98FbDpd3wl1rQoAGkTlYdX/ZZulg92P/U8nHPWXLmHKqhECa4RvlCTWv4klVs7jTXg6noYr+16QLCJHPHQ/8Gg9ENsOd6iEuU4+06QbYOJ7RyTJFWQHQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 05:52:42 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::714c:2499:6bdb:6742]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::714c:2499:6bdb:6742%3]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 05:52:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "Engel, Amit" <Amit.Engel@Dell.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: nvme host complete request tracing
Thread-Topic: nvme host complete request tracing
Thread-Index: AdmI3FpYoIdvP2ktTp+vpy0OIEBuFgAjU8CAADGlgIAAAJy2sACPu3yA
Date: Mon, 22 May 2023 05:52:41 +0000
Message-ID: <bb0f7100-1875-3416-0534-ff4093dba510@nvidia.com>
References:  <CO1PR19MB488584F51B17C06C58E8E84FEE7E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <9c867339-2c79-ab45-4ff8-cfdfe4af2abc@grimberg.me>
 <4ff73000-e25e-fc9e-708b-f89b6504d0db@nvidia.com>
 <CO1PR19MB4885D8C4834416E820A17E6AEE7C9@CO1PR19MB4885.namprd19.prod.outlook.com>
In-Reply-To:  <CO1PR19MB4885D8C4834416E820A17E6AEE7C9@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|MW4PR12MB6730:EE_
x-ms-office365-filtering-correlation-id: 2a189774-979d-4da9-09ba-08db5a88c1b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Tqv3R0wSWTFAJWEgQhEXsM/eoDLU3g1WlM3gkVg6/f2o6/01spzigILtlE35ck1xa/3xFrmdMw415PCt/6drswKH4Pzm942h78PRWK9vZm7ecmBy2grYsCL2e5iGeMOU4berak8DoO5Vt2E14tjlU1wqjJ1lVra3uKbJRWsVrxzXlpK4PYH32WfOkxUkWhU6E2CZOSVTosuAhLdybpMhn35AOK1vHfkjZi1IuuqDdj6XREjSqyCjBkQfpCShLINIRHVuHj/s32vUjkmYvvWz7eSzLlJga1WjH0FuKsBz9VqBumvu4WHhhMLM44tilRd6wfeKUpSOBaQgRfKGF9DBXcaDQdhv+401wEiyYCirQGpCoDY56VdhJdUiky3ASLk4uRNGbypCP2il/0mTmjaPFD/i770hbv11TB3TlnZU1V+51xFJjHwCP5Kc/T5/m2jnY1XvhEujow7ZPvn3pJ6S7Ym7vMLzu+hX/71FqrIcAjJKrQHbGj0w+ozJ1918uTo7+OpSNTTqJPDTnhhsoNTC3TZUoWYNyuO91r7qapgp/4LQHpqz9trA708Xh0IJef9PGqDTDwJdRiiWtQirykORUp4sgqGhErZTItkfzjG1GDpDgyY3J2LF51mtBJP2FifxUhhuSGUl6nod5uOuiJuPTUBtKE9OdXH3tIE16lP6kSkCceiESxx73VfBQx+e3xgJ
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(54906003)(478600001)(8676002)(186003)(6506007)(6512007)(122000001)(8936002)(41300700001)(38070700005)(5660300002)(91956017)(316002)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(6916009)(4326008)(36756003)(53546011)(6486002)(38100700002)(2906002)(4744005)(71200400001)(2616005)(31696002)(31686004)(83380400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZDBSVEllZWc3VUFKMTQ3YVhoYjBjQUxUbEk3bU9weHlsQitiKzFIOE5pYzVv?=
 =?utf-8?B?S0tuNGF4M1IrNjZGK0RTbTRWYkUxYTFvTis3K2VHL0ROSUNaTmZnYUZiMVk0?=
 =?utf-8?B?SWkrbUxZN2o0Qld6Qzd6WkhBSlNsRmpZUE1MZTZuMGlFRWxGL3htMGd0cndG?=
 =?utf-8?B?cVI0TkxXOEhTVGFPQTI0M0owQjREVHMwenZNWHFaSTFSelg4QkJ4eFg5N2Vv?=
 =?utf-8?B?TFdnTkl5emJONDBHYU9BS1N5UDFObjBzSVpoeEZoNnVScDhzUXlaYTRmbDZR?=
 =?utf-8?B?TEZlbCtDQjB1RFZYcjRsMHVHRmJEbUY0Z0ticHZ0ODRETXEvYXdBdmRSNktz?=
 =?utf-8?B?S0xtTVN3c3NFSVB6Z0dybXBZRGNLTUNiT0UxWXc4SnBFZ0pGNm9uM0lqY1pU?=
 =?utf-8?B?L25pcWd2ZFdlZFVCWUlLRFhadm1vbGhDTjdTcDBLSHFLZkpObkhuRlV2SnY2?=
 =?utf-8?B?STJrM2dOdTBKSkhJWUJHK2gwR1NSalVRemhtbUNVRU53YWgyRFNmaUJwOS80?=
 =?utf-8?B?eks2OWc3NG1NK2NtZ0NnUm9sUlhyOVF6VlQ5Zmo1U2FTYkQ1dEZXZmFBQnVY?=
 =?utf-8?B?ZmpMM1pYQ1p6V2dKT2VmUHZEb2QxRmYvTThERlZSQVdqaENkWVoxekd6YWZU?=
 =?utf-8?B?SlJqWHVSZG5sNkYrV2RsSDJkbm5TQVVBOFZDTHZhWVN1T05tNk1IK2hUQ0RQ?=
 =?utf-8?B?T1dCYXZIdzVGeld3QWZnbTQ1d3AxWWx3TTBYQWtBYjR6WGg3d0F3L1Q4T2ZG?=
 =?utf-8?B?TzdYUUZFaTQyRFdXbXNWVnNsU2pHMEZYOFUwVXkrbkREaitNcm9uNk5EY2Ji?=
 =?utf-8?B?Z09PWm5NeVVDcDh6Q05FN2VZWUkzSkEwWU9oWjAwbjFrd1VodVRtc1BVN1ZM?=
 =?utf-8?B?MWFFdHhCUjcrL000OGRMdjYza1hPZXN5Ukl1bUpuQ09VQkFLaWk5NmhJWnlD?=
 =?utf-8?B?UCtIQUh3Ukp5K0trT2JLMWprM2NrbXpkWHBOM2ZHQmZGQ0dKaURyVm9lRU9a?=
 =?utf-8?B?ZGtFSmFHMGRONDk2UUJuQWx4bXNLa0dFOGoxWTJxNlpzN2M3aFZZdDNJcUhw?=
 =?utf-8?B?VEdmTFRmV215d21kY1ZabC81SVF0RlNFMFphUU9OM3c5eUJXOEJNazJjTDhs?=
 =?utf-8?B?cGZtYW16NUoyR241WkRENDBCcUYrTGhvYmIrQThrdE1laEV5L2xSNTBDTU1Z?=
 =?utf-8?B?TVpUQUV2Sm52WjVmS1Q3aXFCdDlCODRLVElDS09zZUdWeUVhZUt5MHZ1dms2?=
 =?utf-8?B?QWZXQTMrYTZUYStPMVFJQUF0Qm03RUg5eWd6REF6dVg1NFBHL2JCY3dvYnph?=
 =?utf-8?B?R1hTd2RHeWtpU2pQbVV6dkJnU3pXZm5taEVrOXJScUNPWXZjV0Z2QStObzlP?=
 =?utf-8?B?ZUgxVVU0dnpjZXBSaTVZa0owL2ZnNWwrczl3Mm1CaVpoblZLaDhMVGZicnpF?=
 =?utf-8?B?YWJRVzFIeG5YTzFiSkZaUUVCQ0lJNEl5ckQ4eW1ReFYxYTNWM0xtTFpXYk92?=
 =?utf-8?B?Zmh4RS9TQTE4RlFESG9hZXRrN2dPWURkSFltQWNDSURRKzAwd0JoemN6aDI5?=
 =?utf-8?B?U05uR1gyTE9CbVBkdnZEblhRY0pZYktnVE1UdHo5KzdnOERlYzBLN3NCcFlY?=
 =?utf-8?B?TUNpZDhySWJlYkc2dmdYdXVpVGVBYnFMMlRQbUY3OFJYZFhOK2dxRmdMVUdm?=
 =?utf-8?B?MWlXVHl3bUJiTUFZdHpjdTg3TUxGK1grN2kxeTJwNyszWWRWb0Z2Zk9wb1FD?=
 =?utf-8?B?VHVXQ095anBrQ3haYWxac2s4YUlaNmZNTHdKUi9YVzNaemVNOS92U3JhYmVl?=
 =?utf-8?B?NFpPTXRia2YrRGZqYlh1enl4M09MWno3UTY1OW5zd1lSanZoaE1iaWNIYlJG?=
 =?utf-8?B?L0VHZDBRaGViakZRdStYaUV2LzhiZlAzL0JmbEFRdmptTDN2dU82R1JxREw5?=
 =?utf-8?B?Rkl5ZW9UQXRtRWtjZk5WMVI1ZUh6bkhTSkRrYXk1d01PSmVuQ09BVHpmWEJW?=
 =?utf-8?B?aVBpR2JEMmRZNE1kOFBoR0ZKTUY4bGVxcTJYc0pVaUVpQWVSRjU1ZTVLSUVP?=
 =?utf-8?B?eGJMd1dGRzAvVjBTeUVENW45MHY4N2xpNWd5YXJTYXg1TklFRmNSaWtuZ3R3?=
 =?utf-8?B?dFZTa0p6aTFiRUR6VmFmNklCekVjVk1pSmxmNDREMFJDWEgyanpoMG1CQTZh?=
 =?utf-8?Q?w8OgguPBVngspylTsnRCG77BP9MCk38YtQFkhvQQWQfF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <129156ACFAAB814AAA11EE37B2E75E0C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a189774-979d-4da9-09ba-08db5a88c1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 05:52:41.4491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uuIWMEYyplUw/YRU+PVDoORzJh36B1fN9VAkXLepJyLMx6I52llMkqwagdlgKJCDd8Wz6VnNsLbujiPp4dbvcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230521_225247_358238_EA90E522 
X-CRM114-Status: GOOD (  10.51  )
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

U2FnaSwNCg0KT24gNS8xOS8yMDIzIDI6MTggQU0sIEVuZ2VsLCBBbWl0IHdyb3RlOg0KPiBIaSwN
Cj4gDQo+IEkgd291bGQgZ28gd2l0aCBbMl0sDQo+IG9wdGlvbmFsbHkgcHJpbnRpbmcgZGlzcG9z
aXRpb24gdmFsdWUgb25seSB3aGVuIGRpc3Bvc2l0aW9uICE9IENPTVBMRVRFIGluIHRoZSB0cmFj
ZV9udm1lX2NvbXBsZXRlX3JxKCkNCj4gDQo+IFRoYW5rcywNCj4gQW1pdA0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YWtA
bnZpZGlhLmNvbT4NCj4gU2VudDogRnJpZGF5LCAxOSBNYXkgMjAyMyAxMjowMA0KPiBUbzogU2Fn
aSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gQ2M6IGxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgRW5nZWwsIEFtaXQgPEFtaXQuRW5nZWxARGVsbC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBudm1lIGhvc3QgY29tcGxldGUgcmVxdWVzdCB0cmFjaW5nDQo+IA0KDQpBcmUgeW91IG9r
YXkgd2l0aCB0aGlzID8NCg0KLWNrDQoNCg==

