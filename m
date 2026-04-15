Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A70F41995
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8KKxYdgNmOXLBQs+AiOdNDvr9p5UbDGzNWKZIY+Q98=; b=eRlBVhE+dsIQoCOUTzCkTEDXfk
	Ia8jH6S7v06HqwNAQTjZR8mhXaFCB4YWiYNB3qTPGl1ni4ZUg3Lj1aAxCzjSkHAd9ICXTf3GBTDgn
	0LYVHY10KO1OQVxEafqKMMEr3GaP+samxK4GaTbxQsaE0PAqHKhw8zp62FweyiOV+ZjUmJM0dWQh+
	WCkQFqlKllMK3TVgA6SAAp7KEOxnMC6ZcQiULNMm/+3KB/no8CkGaMka2jwH4JtagqmJElTidfyYz
	G1ltkNGR/d9E6Uvyq+WyAoQPR5VQWRcHHs9jGegNZ7ZPjmIsdZMSitRXBcyT0nlAJFDZsfbwSPRC2
	uEZd9JHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD4QR-00000001TWw-0yhx;
	Wed, 15 Apr 2026 17:53:19 +0000
Received: from mail-northcentralusazon11013011.outbound.protection.outlook.com ([40.107.201.11] helo=CH4PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD4QO-00000001TWA-0FWX
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 17:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8/lxYHy4QcSe0Zrnp50Sc4ZLCQX4jot1pFVryMNZuXFzTCEzHwDqYu0EW1McUK3BbAE/zKk5x8z8uZ2NY2tGkhMmjXpQIacNI60RB9EWlF8zmSe2ghvwRvSo3fLsImKU5hFCqMiZvJiC3HxpEEYu8lU+oaTNIa6dPgEEIhc+lGGBSd4rkDZjnzwBeqMJ2N4ATBKLP/jR9SXSYSQj/LrDuDnN2hKBd5NMsGhMYtpB7lXvr5Zcq3N3pNf9U5T6Uvev7mLW93iRg/0XLNRECru6Hpxn9XBaU+OPQzVATQZGDbG2fJTiDLWfxCxyAsoPOb33Fvi+VKQDO8xoBdk0ohi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8KKxYdgNmOXLBQs+AiOdNDvr9p5UbDGzNWKZIY+Q98=;
 b=sBUrUdI6TnTK7cCaJg3woHyd1PvwTCMc5H75WwoyxDMmfbrRrPNestfNx+RMJJMK8YgG3mHG10vpKNugPeXP/JHVA7m44W1QNN74j1/6L1ZOsASfYENjxNPRmtoyh+N+t2b5625VcISSa96WGre4tvuY1ce3OhSITiJklNTgcDILDvS5qmx8rawFzd+hd77TeMoymbdeirUEkjA5e6awiEot+1lDKS6ihl6xRdhAM3g7WgZQ+iyizxAXza/6rR6DvQgiS5W7PBvhVYVh8tb+P9ndprSq3aBnSuOPLk9O7ExIWOoZGjXxlO4TwNR7ATaR7vwzVKm6vfSMiU1Cl+l+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8KKxYdgNmOXLBQs+AiOdNDvr9p5UbDGzNWKZIY+Q98=;
 b=Y5X0pbgqxzkBwwdf2NQo9rJl7r/gciyESd6utt91+lICaVdXxjs06qWngFfmjZkZJB9WNezh4DL3Qr+Gfgo983scjJXAYAEcwyCR+BuooPlRnzRQXgzV9fcOGPUO+iJrydVe3YbwHkjycvbtpO+rgKO7kM38QKzud/sjFZ4nkkHDH7Eq3tpkvn64rML3ioZYxJmFYu8SecvjIlavnQP551r+zfozfh7cZoyqRVrwQhTa3cpZ5zV31tf6tbNVOkzZL5jNBJva9UEJFH1Dfx0KHh3rYXTcCbIz3xcgvr6nsCynb6UHYnm0J4Zmehrlh3iu/ZzE4LTBcDgwH5URE7QBkQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Wed, 15 Apr 2026 17:53:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 17:53:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-multipath: put module reference when delayed removal
 work is canceled
Thread-Topic: [PATCH] nvme-multipath: put module reference when delayed
 removal work is canceled
Thread-Index: AQHczPA8/GAYN3P1YkalV4/qAT/H2bXgZ4SA
Date: Wed, 15 Apr 2026 17:53:00 +0000
Message-ID: <e1dabcc2-ff41-4cd7-98f9-5a9b17815344@nvidia.com>
References: <20260415155358.1517871-1-john.g.garry@oracle.com>
In-Reply-To: <20260415155358.1517871-1-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6312:EE_
x-ms-office365-filtering-correlation-id: 7d5caa0e-428e-4b30-66f3-08de9b17d5a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: I7/0PCmk6MHIc3CgAMzgIo41mXBC63F/5n5nViASHLNEHS8fMltkD5nfqF23nYMMDorcViayMzbxwy0mWTKDmBGHCxcUktNZsCt3UnOvzWi9u4s7gdzZgHk3xb9Ogkf1NHDWvtOVBAKoXLSNPTFZfv9WYuAV90Yj/Zm4RnOKkKnfWdnHEnJMm6n+sXgjhP5WtI/0FDWerbxAcC7EdvvohXsXwy8dDh2LK6Uc1ucxpTnkwecBg1CPOwvBZ+XZSr9v7yBg3Ks6GDRQkxhq0iH6lQs4OFKcc4twRjJZABXsw1wENwOBOAG1lk5uj81bwzJLHDH1SOJ3ZRQ1C/zpm5/PsPXxV0ni3+pzF4/GGVFv4DcEyvEWyZ8FY/5ui7YyPZEi+p/a0XjSswm/xd5DtRbcyXwh0/GrwLRu463IXN0muUG/oCGSM99SW3NOLiLxCJIj1Dvg0sS4sjQqJv/3/sVFm21ykE11ejxbffBgpPFuEF9yLbVwk1c2YKKE0+k1jiKDYIlw5jefODw2hsThL4rjSx2YJOEYCNz3jja7mu0kloid29HAsYNlCsxaWmcAzr2QOB4lc5LeSMWY+fySspEhDSIgSRNyC++p/wh+T80U6utd+R4DrqEwLsp+8TwSAPdUiEnuWa9+UJ8+6Oi62zvXX1gAWBnGuPEYuOSKd1IM61SfFHelVuh/jlPGrL5Wlh6Bgh2v4ySjuBOewCEioFVMEyzI1Du9waD5eSPq7cQckqXnJTCEgM2O45cLwW6/bJXG/pL1w5uuA9yga3OV+WaJjE38d6MMnyj4e7E/rhxK+Cw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmNWNWt3aGdSV01hemV2dU1GL2krVXBEK2VocG9xTEtjSzJzbVhqdm91WE00?=
 =?utf-8?B?VHpJckl0QzZ2QzMxcUhoRUZERDlEcHhjMVRKS21Db0YyQUh2VGZTeXJuRzU0?=
 =?utf-8?B?cVFRNzZ2eWlCdlQ0a0VJUk5DVW9POGZac0gzL1IyS3p0eDMwK0MrL3YvL3J5?=
 =?utf-8?B?ejB6ZDEwYzdJRE9LMkhneHJJSlVaMXBYMzdIeUcvOWp0dmFDaWVDbDBGUzla?=
 =?utf-8?B?T0ZqaFV0RHVSdUNKMVlUZk8wdWNhOThvNWc0OEh2Q2R3UDh0U29nb24zNGlN?=
 =?utf-8?B?RU5HbTRGaGRwUkUzb1kwYlZwd05zV3B4WjVIY0J4c1phQkJCZko2MW1HWlZW?=
 =?utf-8?B?VW16UGUvVkZUdnlZT0pPZ3FKOFczNFRYTVN1eXNWMWJmLzdCK3NtdlVtS1Fk?=
 =?utf-8?B?SEhTaWhvc2NjaHR1T3BtUDZaa3YyTzhJSzk0bngvU3pJaUs0dlhpdnZ6bUdj?=
 =?utf-8?B?MFp3NnRsb1ZadzJvazNDTWs2Rk9ybzhLMFRMRU1sMy9YRHlDZ0ZUV2lpTWZs?=
 =?utf-8?B?aTQ3UmdXYnhXbWlaaUNSWDVvUGQ2QWxiNmJQVDJPcDBBWUxFdGJ6ZzhLTGNH?=
 =?utf-8?B?R3AyWXBKTFV0aHJNa1grTFJ6ekdhUXpLaExiVVh0TlQxZXRwZm1OVlJoWktD?=
 =?utf-8?B?dS95ZS93c3hreTNNRDR0SUFiMC9qT2gvamJldVphZHVjZmdQTWJjbmdJSGlJ?=
 =?utf-8?B?U3JuVGk5MUxneE1CZ0l3QytXbjBiTHhJRFpZTGsySUlydWZFclVkam4rQW44?=
 =?utf-8?B?ZkU2bnZSVFI0ZmRYeVl0bEV4cEE4MHFqa0luTk0rTkkybkVYVmJvSHAyK1M0?=
 =?utf-8?B?cUR5NVN5R2YzSnVNSlB1c0JSUzQzTG9UeHZEcHIwdVJlUkdtOU5WY2hYaDdU?=
 =?utf-8?B?T25jNHhVNGlCaUxPZTQybng0Q0Q3a1A3Z3FLRmF6MlhZanU5dDJNcVJHZytl?=
 =?utf-8?B?Sithd3I3N3JEWFhSaENXYlcxZmxuenBwMTZWaFZWT2hrN1JCMzI1ZEYvN3J5?=
 =?utf-8?B?elM5cGZBSngrREdCTUwyZGIrYkZqTWttS3Q1YTdJS1JtdEQzTWlidW5TeDFz?=
 =?utf-8?B?SkhBSHZWNytZNkVSc3EwVGhKcU5GNTRBR2NTUTZsZE9UYnN3UldBYWM0TC9l?=
 =?utf-8?B?cHJ5cVZweWQrU2Jab2JwUHhKbWJ2RWMzNndKUWY2bGhybHJkY3ZwZElvdTVp?=
 =?utf-8?B?NnEvY3ZRRDhGcEtzajI3TjVsUFR4OHpQVnVIWWFlTnRWWWhyWkVhQ1c5d3Ux?=
 =?utf-8?B?UFNkbDRWeVJwbGJRYmNkNHVpMlVsSzl4TWxHNTNYMGxvT2l0QjJkQkZHMTFh?=
 =?utf-8?B?VXpXMy9FZHowa3EySjErcUloUEp6SW50dUdkdk84S1ZEUDhLUThMUGdOdjd2?=
 =?utf-8?B?WkpKM2ZSdVpBdGZ0ODdzOUtKcmtOT2liUVY0bEJhcjVjbkhhTGFOVWZCdTlK?=
 =?utf-8?B?OFRrTkI3amQ0VkxNM1FUWlZ4bGlOeG1ERnVuYXNwWWNXRzZjSHc5ZFJzNjlj?=
 =?utf-8?B?c0FYeERMcTNOaXEyR3A3KzhhTVBFeVduYXhNY1dKQjR5RG1tVE00U1AyV3c5?=
 =?utf-8?B?T0Z5d3JFOGdMbWdDOVZiNW5MQ29uNVRwSEM2N1JnenFOd0VwTzdkaVkxR2Zp?=
 =?utf-8?B?bGdLVUxvUkpWSE9lcDk2L0RlaHdEcXZ0TlB6U09pR3RDS29LTThqcEtaSEVE?=
 =?utf-8?B?UHlGYkdmenFPQzJldEx2T0dDYkJDOTVtRkNPMVdHMnZCblBudGtkNlBEMjNL?=
 =?utf-8?B?T0dKd21jVWlMSkpCQkhBelJnamx6VHlNSkltZjZsZG84Nmx0d1krWUJBaXFB?=
 =?utf-8?B?bzdvcVA4bHcya29vYXc1Z1FGYzZYa2VXSHcwaVhZVFhKMkd0RjI4MHZuVG0w?=
 =?utf-8?B?d01lUEJCblRwV1lXbDFNam9mbjMxUng3MzVWanBMMVVWNkUvSUdvUThBbWsx?=
 =?utf-8?B?TDExYld4VHJnKzk4MmdCMCtOTFh2OHpiSmZkbjRNYjN4Rkhhem5Va1pvUVM4?=
 =?utf-8?B?Qzc4MHpGNDlDelZ6SVhHMUJ2RVRoTjJ1ZlpXdHAwMnc2VGMzMGw2d1h5N2pj?=
 =?utf-8?B?a01HY3p2N2lMSlBYYlhNbDFMSTFWUnhGL0dQN2FGY0dneW0yUUtLV1FpQmVq?=
 =?utf-8?B?OEpCbllNekdEN2JlZk95RlcvODJBTWJRRVZNb1k5cGZnTzNFQ0ttVlJzakxZ?=
 =?utf-8?B?SEhjTXJSbyt5SnJnL3JhNHdQU0gwK21OSENWZjdxQS8zd0hkYXdvWXNXZmNQ?=
 =?utf-8?B?bXM0OWtYMUNFbG5kdGd0eE1lRFdKcGp0NFZRWGRKVkpDVzJNRmo1dXk3RW9x?=
 =?utf-8?B?SjdVdmo2Sk9BZnBQVnFDd3JRMFMwNDFJMElvRGV4bld2RzRvclA2UVMyTFJr?=
 =?utf-8?Q?UwUvwpJ8tzz/O1CTZNtzCNiQoE2yOxhg8Y+QQ2Hh/SHXH?=
x-ms-exchange-antispam-messagedata-1: stqCq8wSZcFi2A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B88C3F89715EA4BA9395BBD7C3F0FF6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5caa0e-428e-4b30-66f3-08de9b17d5a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 17:53:00.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaesIw7AbM20f22W7Izes1FT7DoOy5BJn3EOLXnaOo7e3yLq0nacT/yxMyTy0oHWNSC6m8fL44IyHavBD6stSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_105316_102938_857FC5BA 
X-CRM114-Status: UNSURE (   8.16  )
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

T24gNC8xNS8yNiAwODo1MywgSm9obiBHYXJyeSB3cm90ZToNCj4gVGhlIGRlbGF5ZWQgZGlzayBy
ZW1vdmFsIHdvcmsgaXMgY2FuY2VsZWQgd2hlbiBhIE5TIChyZSlhcHBlYXJzLiBIb3dldmVyLA0K
PiB3ZSBkbyBub3QgcHV0IHRoZSBtb2R1bGUgcmVmZXJlbmNlIGdyYWJiZWQgaW4gbnZtZV9tcGF0
aF9yZW1vdmVfZGlzaygpLCBzbw0KPiBmaXggdGhhdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSm9o
biBHYXJyeTxqb2huLmcuZ2FycnlAb3JhY2xlLmNvbT4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQoNCg==

