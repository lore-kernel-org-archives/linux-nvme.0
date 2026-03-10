Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C3FFCC9C2
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 05:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kbgBxxtIVuV+rM7NXZxBw0V3Oe5/6x/0XWIHSyD3RD0=; b=ckfXQii7wCZlNQmAjf85xkJDbZ
	2V7m6PzQ3AhNYYISj+jBNQ9TeJ0JzJrSoo5EUt3rD6mCWGavf5Vcj0OTY5A+J+Zq720JwU7mV3w3l
	SIt4x5TOaz+nAS3/b6d6/dmf56tsG4rXWzjXiiuG6gks/7Z4V7nkPsuAGOyNmC4CTu5nXx3gbL/nO
	45WET+ODpLrYdoF2mBGam02JTo/TXarU678vZ1I3QkMbXre+jJIZHDJzYoyTgEQYEEwZtpI+aWvOg
	rUFIoU45Q7qfXciSqzKY5bIrKmvmJmw9J618zAbhG914t9b3XGKl3AdfI7G+JwjRD1W9uXuBj1JGc
	N8p2fLLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzpuK-00000008kkO-4Bhd;
	Tue, 10 Mar 2026 05:45:29 +0000
Received: from mail-westus3azon11010005.outbound.protection.outlook.com ([52.101.201.5] helo=PH7PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzpuJ-00000008kjr-1UaS
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 05:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha3ZhiFrT7eEhDOiuaU3Kt2vE3aH2I1LwEDwyLixSiDrWk+i6ryB8AHBVyHWmXGNtyLcrMWIne2klCE/ZP9tcHNXZas+A5/oUwuh7MDMsFlSwCfjGPe02flteXNWyCQYNsJ3GFFnQy+r/qVNDs8bYhbJYUSYEvlk+/rTiQhVpnhTOhNgx0Zh5WXUige1itoiy9nI2e2H+m919DhlXqS1cc/kugF1hq+5gJMAhFuxaQASTxerwMbPA1nm7Rdhs8YZXaskA4WIQf7qlCnJQ03ruR1xp6K7fLusJjdxjhzt6woRLxNRh6WZONEwBKdIyB3PuxG5BCCanUEAYv1MzGC7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbgBxxtIVuV+rM7NXZxBw0V3Oe5/6x/0XWIHSyD3RD0=;
 b=PrMYzdwWyX5JJaEFfJ7DhDon7Bu61OjRmRo+hGVcsFnW/NT97JPKaqynQ4ApC63fUy//Zg9NNINtQQTmqmm29IxjsUXAOBZuFpIq6wIucBZ8C0HhS1+vylwzSGHauxYT0wq70Mm2rFj1y2Cwm25XWm1jZ3UBFxKOryKoyHPjn9stK5+3OZzmGNZVvXJBWNFLzD3+Xox37fFo+qfSUApawlFQFhjHNico4rVDSZoFLCNWvtD27RRqt9WH6LKg1VTfJO15uicgb7aCL4K+yKbO3hQGWyy0UNq8RXsoMGfgPQGJbc2cs4/gYxhyRlSUpc+HCa+6ll44lhBzFqL+88omAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbgBxxtIVuV+rM7NXZxBw0V3Oe5/6x/0XWIHSyD3RD0=;
 b=pZCCdiYhVXYptIkdY8M4/R1uVzrm0UsmNAoGpUJ10nwPOyGmIWsE5jLWCZRKta8X2KqsLQADES5C6WzGabY2Y/sP4CPNV8HrtPjFKwnPsbattEIaT/gCD+0aTQnarNwldKGERsRxU/g4/qHy+r2G0hojorxuXpZwEurLYzBawMJ93fdUsEwxNekJfihMVWuMej/Saoj5zNmh/Qz+thZ1Bk33EhjT1IaRYcqtvngqTfnZ4iuJQktOZPpRPEJKqIwC2czlI6RxZKLhCoO0sNvQr44ZlhpKxOQy3SgxaR1MtU593vkCoA0r1YM33vBAn8vaVWcXaG9RTKX3p6mw5TAklQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 05:45:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9678.016; Tue, 10 Mar 2026
 05:45:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>
CC: "hch@lst.de" <hch@lst.de>, "nilay@linux.ibm.com" <nilay@linux.ibm.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH V3] nvme-tcp: teardown circular lockng fixes
Thread-Topic: [PATCH V3] nvme-tcp: teardown circular lockng fixes
Thread-Index: AQHcpsuyg0Dk+C1Zik60fgvuDocUaLWXL5GAgBAlBIA=
Date: Tue, 10 Mar 2026 05:45:24 +0000
Message-ID: <f5065c2c-e30d-418d-8c7a-723e958b54c1@nvidia.com>
References: <20260226025658.86496-1-kch@nvidia.com>
 <1f2272c6-f6b8-4a82-a49b-d651fe19a823@nvidia.com>
In-Reply-To: <1f2272c6-f6b8-4a82-a49b-d651fe19a823@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7239:EE_
x-ms-office365-filtering-correlation-id: 8fde5ff7-8889-490f-656e-08de7e6839a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|13003099007;
x-microsoft-antispam-message-info: WlQ/4eccBYDsgIX/rCdAxtLq9PZVzmzYAMpq8J78HJg8mhDio9TbbdOxvZX1chtX6qpyxwpesXiRegVd9FbW43TMe/8w5FrvJnlfESz2S3WjVoNoCFoDBWWGp3uduvMsKTiMF+faA4Z+FnwWfWXsQFOPrGsPnHl0890cGCuE2ASjpWPzxsIXtqFshYtJwqRmZd9pTqiorsGg9rJx3C33ueliO5eidm+77Xeqa67gkk0rA4hzAnFI8bfLs95MbZIHNyE25pBuqAEm+vxT7i3kp4Nai5d/Bd5TbqQQJYDKuozoQOjcM7AHO5ivtTHz+LuM9U2AwSbcDhpfrfbgW74HJsIVxc/7ToBcALYW3j4LOHnZxxmUET27MKSuVVdc8wN5THNTLwG8aYCe6YZb1836pREBIJchOd85CIbEStbLtOCvbWGc8CQzguC6wWDoBBnzgWHAsXGnb7kKEnZHTasKvy0dRlbyq3JxrNX6i5JZX8pJE3ujkCKhUSWXA4XWuAQwtDP1sSOy2IMHZx+Ik80lg8Z9RYYMOJ5f8IjW5IJVxYJDycZ/WkWYLJmEL6FbQ7fL5LHUjoPvrcoG2mKtyEZMPQ0lZmTFzAvKGhic8N9V8ZoUsTQytsLT6Ys30SDgOY+IGqkEN35YQN0tsym9SR1JfRyOUhZtZCHb1GWI8qh8yE7/hWRYLOa/ItJHd+Acz7a/7Xk6ujovVagr0jP1RBLVV31/IeW7AevQ5Rz2ta77wyDKTGt8cxJSvLJE0m65Ozk2pfjsvXaGniHDFgIibEVgM4eeoPJ7GVvBfezXTO/nne8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0dRYXF1a3Ivd2FUdHVKYUJlcEJZOGVyckd2OVV2WjhyYTdIcm8xc1lhWDMr?=
 =?utf-8?B?YWZUMVZQZG9NSGUvNDI5SXJWcHhTOTRvQnVvSWlGbm1Zc1RQQzZwS2wyTE9V?=
 =?utf-8?B?WjFRV0d2d1pSMHFHc0NEYUNwK3B3Y3BWZGlISTcyb1hHY0U0YzhEaG1rYTRX?=
 =?utf-8?B?Q1ZUUnVGNGJ2eklkYk4yblhKV1RFb25KQk1OQUt2TEI3ZE9xQjdzTVQvdlFG?=
 =?utf-8?B?SU5weXpiK0RLN01BR2RoMndhTDB0QzBPakdKNkVXMkQzVkNPZ2l4VTU0RzlV?=
 =?utf-8?B?bzlFTVMrRThzUDlnSFJYZ1AwcjNBU2FvZnhBMEV2bkRlL0FJcm9QWjZudW9w?=
 =?utf-8?B?Ulhoc0tLSU1JRWdNZ0RBQ01KN2N0YTA0Rjc0eFlQczJhUkhqSFBvQXhpKzZm?=
 =?utf-8?B?UEJoNEkwMlNZSm1IUkVUN1I5dFhENlZiZlBRMmxyS0hDWmM1OE5DTE9qNEtR?=
 =?utf-8?B?Y0xQWk9KZDhaaGRXbXBFTGtqeUVMNEw0cXRkakpGOVNUNCtBUXVIODZFYnE1?=
 =?utf-8?B?ckZ6OGNPOWdvR2FUVlFqUHRCb0lSd3h0R21qOE5qckdPV2pYbTA1OXV1K3VK?=
 =?utf-8?B?bkVJdEVVZ3JHd0Q5ckgzY0RTR0VVUVVFZEJQcHZvbGhSQXdSR2pQUzdqa0V0?=
 =?utf-8?B?Q2FvM21UTUJNZXFUcnI5YXBTcUx0OHFqbytCeTNFbUN5Snkyc0hDSk4zSkwx?=
 =?utf-8?B?R1JyaVRCQ1d0UkhncGxPMW8wQ29EZ2ZLSG5jQ2R3ZmVoM0JLQWJPeGE1Q3dQ?=
 =?utf-8?B?Y00xQXZmZ3F0U1RXMEJrVEFtajI5dzUxVjdUbkc2NmVGMFJ5OXhPVUlmaGNL?=
 =?utf-8?B?bEd4MXVwS2g1dTBSNVUzeUUybU0yN3FvUTl0M2pPZkNmWkpKckhRWnNxTmY4?=
 =?utf-8?B?VjZSQUJBR2JENXJ4eENhL2ZDUFI1TG9nMklHU2d0SHRJdDBta05ZbUlmUFRH?=
 =?utf-8?B?U0U3RXZWa0xrOEVrL3hpQnJQUnhONUcxU0wyU2JGdlZVNGcwSjg3TFY0aWl0?=
 =?utf-8?B?Q3crb1dVMm94ak44eE5EMU9PZ1NDS3FvSmphRE5ZRUpILzVxelVWdk5hNzdB?=
 =?utf-8?B?ekFSTURVUW5VOTR2eE5BTmRGLzd3eXVMNTJNOXJnRGU2c2ZwTFA1Ri9YdnF1?=
 =?utf-8?B?VXlJSW44eHA1U2ErRmg0QlBjeDk3MWxNb0trSE5mZS9qSndkZ1F5NFEzN0RH?=
 =?utf-8?B?eEY5YTlHQ3lMTEJOeTlCdVBVU0krTUpqc1JvUnp3WFNnR0NhOWlYRks3WjhC?=
 =?utf-8?B?VVRkOW5Ed2E2NlVvbW1FaW1OYW9PR0VnOUtzOXVMaHBMaUFERFlEdDRWOUVC?=
 =?utf-8?B?cERkWi96c0pGOEppMjltTGVqVEZIN3IxcXhGVEtmclp0WEhnRFBNTnIycE9h?=
 =?utf-8?B?TU9hQVBRZk45T3FVZUpmU0V0S2szdEtZV0dSZHpHTmVSRGhYUzlBeE1PaXQy?=
 =?utf-8?B?d0dEbHpOVVIzZm5yL093YzRFcnprcFRTRnVKZzkvVjhnWXJnWWJSTU56S0hS?=
 =?utf-8?B?aEpSb0ZXdFZmUWEyTm52K1puT25TY2xiWmNQNFRHcm1UWVRIa2xqWE1nSnMr?=
 =?utf-8?B?NlhYeUlCV0RHeUYrSUNMc0hsM1Vab2NsUDFPaUVIKzBOWm9rdFZxZU1EQkF3?=
 =?utf-8?B?WUEvbDhBQXlTUDExV1BpaW9RcHlJSk1tdDkrOVVNK0plWEpmeVNaalBiYUlI?=
 =?utf-8?B?WkdGd1VMYzBjNHkvdkN5SU9OMTVTdkMzYW90aGFnaGo5Wkx0aVdyUnp1NWtR?=
 =?utf-8?B?U1FhN3g0T3NtelI2aHUxQXpOQ2JjbmJiYkIyZkRvMFlxWEtGQTZCa2FNK05T?=
 =?utf-8?B?ZlA5M3FGSDh4M1pRWXlzbDN6WlJJQkwvci9kY01JU2VtbHkxWVVSaXd3V1h6?=
 =?utf-8?B?ZS82SFVwVFVzT3VDOGJVZWtyTSt0Rkc3WHdTZmVoQlJQeGFrTUoxd3FTQU5X?=
 =?utf-8?B?ODFSZjVoLzlocWMxcDgxU1F3cG1oK09lSHU3bk5UditNa2oxZmVRWEJ0VnhD?=
 =?utf-8?B?SkdIN2o1RURBbzFISFR6U281ckZsbXVKM0hSQzlNM3VRd0pwZXBlNWFub2R4?=
 =?utf-8?B?bjIzdHBaQkxHZUltNlFlUVUxZW5WSU5zenhEYmdCbHhBa0xWWFpVbzJER2Nw?=
 =?utf-8?B?bUppVGVxb1BNaElGL3VBai9YQWNhZnhzYXY3Wmc2MitZUHhaY2Z6Q2tYYlpL?=
 =?utf-8?B?bG1QWXA3WWdXcDgxcnFkRTlEdnlKTFAzcXgvVVQxcUVwR0VwY2pYSWU5djZY?=
 =?utf-8?B?Q01hazdaenJrdy9Md3Y3V3VhRWpkaDNqWG8xcDhneVFkQzBndTNPTlFobmYy?=
 =?utf-8?B?MVNvNkd3cXVDbzF6TGlqNFB6Yk9jbjVubkJhWXQyNG5EYmllREplWTdrTkgx?=
 =?utf-8?Q?Ct7xNMbRNbuYJCz8D9vI20+se0tdanBe2nJeY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B134B68B16A4384B91C7624E44BCD510@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fde5ff7-8889-490f-656e-08de7e6839a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:45:24.1411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDZiefTkeIOH65tLE8r6JbJjSluE3M8QLC5ZokFE59R7CImN22XSSkzubL30mWAFNOhh7NFIglOXTMbm0cfp8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_224527_396961_245221C6 
X-CRM114-Status: GOOD (  13.10  )
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

U2FnaSwNCg0KT24gMi8yNy8yNiAxNToxMiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBP
biAyLzI1LzI2IDE4OjU2LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBXaGVuIGEgY29u
dHJvbGxlciByZXNldCBpcyB0cmlnZ2VyZWQgdmlhIHN5c2ZzIChieSB3cml0aW5nIHRvDQo+PiAv
c3lzL2NsYXNzL252bWUvPG52bWVkZXY+L3Jlc2V0X2NvbnRyb2xsZXIpLCB0aGUgcmVzZXQgd29y
ayB0ZWFycyBkb3duDQo+PiBhbmQgcmUtZXN0YWJsaXNoZXMgYWxsIHF1ZXVlcy4gVGhlIHNvY2tl
dCByZWxlYXNlIHVzaW5nIGZwdXQoKSBkZWZlcnMNCj4+IHRoZSBhY3R1YWwgY2xlYW51cCB0byB0
YXNrX3dvcmsgZGVsYXllZF9mcHV0IHdvcmtxdWV1ZS4gVGhpcyBkZWZlcnJlZA0KPj4gY2xlYW51
cCBjYW4gcmFjZSB3aXRoIHRoZSBzdWJzZXF1ZW50IHF1ZXVlIHJlLWFsbG9jYXRpb24gZHVyaW5n
IHJlc2V0LA0KPj4gcG90ZW50aWFsbHkgbGVhZGluZyB0byB1c2UtYWZ0ZXItZnJlZSBvciByZXNv
dXJjZSBjb25mbGljdHMuDQo+Pg0KPj4gUmVwbGFjZSBmcHV0KCkgd2l0aCBfX2ZwdXRfc3luYygp
IHRvIGVuc3VyZSBzeW5jaHJvbm91cyBzb2NrZXQgcmVsZWFzZSwNCj4+IGd1YXJhbnRlZWluZyB0
aGF0IGFsbCBzb2NrZXQgcmVzb3VyY2VzIGFyZSBmdWxseSBjbGVhbmVkIHVwIGJlZm9yZSB0aGUN
Cj4+IGZ1bmN0aW9uIHJldHVybnMuIFRoaXMgcHJldmVudHMgcmFjZXMgZHVyaW5nIGNvbnRyb2xs
ZXIgcmVzZXQgd2hlcmUNCj4+IG5ldyBxdWV1ZSBzZXR1cCBtYXkgYmVnaW4gYmVmb3JlIHRoZSBv
bGQgc29ja2V0IGlzIGZ1bGx5IHJlbGVhc2VkLg0KPj4NCj4+ICogQ2FsbCBjaGFpbiBkdXJpbmcg
cmVzZXQ6DQo+PiAgICAgbnZtZV9yZXNldF9jdHJsX3dvcmsoKQ0KPj4gICAgICAgLT4gbnZtZV90
Y3BfdGVhcmRvd25fY3RybCgpDQo+PiAgICAgICAgIC0+IG52bWVfdGNwX3RlYXJkb3duX2lvX3F1
ZXVlcygpDQo+PiAgICAgICAgICAgLT4gbnZtZV90Y3BfZnJlZV9pb19xdWV1ZXMoKQ0KPj4gICAg
ICAgICAgICAgLT4gbnZtZV90Y3BfZnJlZV9xdWV1ZSgpICAgICAgIDwtLSBmcHV0KCkgLT4gX19m
cHV0X3N5bmMoKQ0KPj4gICAgICAgICAtPiBudm1lX3RjcF90ZWFyZG93bl9hZG1pbl9xdWV1ZSgp
DQo+PiAgICAgICAgICAgLT4gbnZtZV90Y3BfZnJlZV9hZG1pbl9xdWV1ZSgpDQo+PiAgICAgICAg
ICAgICAtPiBudm1lX3RjcF9mcmVlX3F1ZXVlKCkgICAgICAgPC0tIGZwdXQoKSAtPiBfX2ZwdXRf
c3luYygpDQo+PiAgICAgICAtPiBudm1lX3RjcF9zZXR1cF9jdHJsKCkgICAgICAgICAgICAgPC0t
IHJhY2Ugd2l0aCBkZWZlcnJlZCBmcHV0DQo+Pg0KPj4gbWVtYWxsb2Nfbm9yZWNsYWltX3NhdmUo
KSBzZXRzIFBGX01FTUFMTE9DIHdoaWNoIGlzIGludGVuZGVkIGZvciB0YXNrcw0KPj4gcGVyZm9y
bWluZyBtZW1vcnkgcmVjbGFpbSB3b3JrIHRoYXQgbmVlZCByZXNlcnZlIGFjY2Vzcy4gV2hpbGUg
UEZfTUVNQUxMT0MNCj4+IHByZXZlbnRzIHRoZSB0YXNrIGZyb20gZW50ZXJpbmcgZGlyZWN0IHJl
Y2xhaW0gKGNhdXNpbmcgX19uZWVkX3JlY2xhaW0oKSB0bw0KPj4gcmV0dXJuIGZhbHNlKSwgaXQg
ZG9lcyBub3Qgc3RyaXAgX19HRlBfSU8gZnJvbSBnZnAgZmxhZ3MuIFRoZSBhbGxvY2F0b3IgY2Fu
DQo+PiB0aGVyZWZvcmUgc3RpbGwgdHJpZ2dlciB3cml0ZWJhY2sgSS9PIHdoZW4gX19HRlBfSU8g
cmVtYWlucyBzZXQsIHdoaWNoIGlzDQo+PiB1bnNhZmUgd2hlbiB0aGUgY2FsbGVyIGhvbGRzIGJs
b2NrIGxheWVyIGxvY2tzLg0KPj4NCj4+IFN3aXRjaCB0byBtZW1hbGxvY19ub2lvX3NhdmUoKSB3
aGljaCBzZXRzIFBGX01FTUFMTE9DX05PSU8uIFRoaXMgY2F1c2VzDQo+PiBjdXJyZW50X2dmcF9j
b250ZXh0KCkgdG8gc3RyaXAgX19HRlBfSU98X19HRlBfRlMgZnJvbSBldmVyeSBhbGxvY2F0aW9u
IGluDQo+PiB0aGUgc2NvcGUsIG1ha2luZyBpdCBzYWZlIHRvIGFsbG9jYXRlIG1lbW9yeSB3aGls
ZSBob2xkaW5nIGVsZXZhdG9yX2xvY2sgYW5kDQo+PiBzZXQtPnNyY3UuDQo+Pg0KPiBDYW4geW91
IHBsZWFzZSB0YWtlIGEgbG9vayB3aGVuIHlvdSBnZXQgYSBjaGFuY2UgPyBTZWUgYWxzbyBbMV0u
DQo+DQo+IC1jaw0KPg0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUx
MTI1MDA1OTUwLjQxMDQ2LTEtY2t1bGthcm5pbGludXhAZ21haWwuY29tLw0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNTExMjUwMDU5NTAuNDEwNDYtMS1ja3Vsa2FybmlsaW51eEBn
bWFpbC5jb20vDQo+DQo+DQoNCmNhbiB5b3UgcGxlYXNlIHRha2UgYSBsb29rIGludG8gdGhpcyA/
DQoNCi1jaw0KDQoNCg==

