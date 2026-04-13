Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F76F34C76
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ou7MGmKUn6RWsuddWPnfvsnlwY+xdUyccXyy/JTGyq0=; b=oh1Lu0G2gjKgMbyABIkllIABxI
	kOMrOs5v/CHRWAo/yIVbBXyQkDuiXAHoUFcre4GK2+AcBNRq8/KyYavHYtYd30TxfTGJXMJKXG7Ho
	SRdrXyQ7SHg+ZJIaWTGzfCQm2urCMFQKRU2YY6asG8C4DkvHb4dOE8E+fh6i0IuaF9USd7s5PMvY/
	XzxyI1p4FSRo0wqg2BVPGJ3jlV66UVUNfkF5x5GBSpPZYssQFxRhZJDxWVwm05tfEbsVeef/XHIie
	On2+2RUY+X6dFW5QDZcN5xpOabmmIaiMVcoz2f2Rpa5/XM8KTZoCYKEQBT0rOaGDliL2r17+qg3ny
	VSMCi2+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCKvX-0000000G7WJ-4920;
	Mon, 13 Apr 2026 17:18:23 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCKvT-0000000G7VV-3Uiz
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 17:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3/puPwBhswYUjnUgkqouPYzVkOrVulnqlb7TlZd8nG0nFNg1po/XWS/kYZp+TUhqk4uRvgt9Dt7zkvq0ABQgNdOdhaKjn55OEcBSzuqEOsDSlDmXDiJbclbe1k7RJhU0vflhza5SaIuuFssw8tLXHhVz8x7rN+6O4XA3wtALFfkjtlhMmaZ3lP/6AqmO9wAY2hh7LScBerXqWtoXl294AqUxrfyBMxMNPcuupSvc90SZu+nCHByEcp5ME3lA226rNRC2AfCL8YciPiD8rVOSxjXQMzH6eQeHKuG8Zur20RPJyzlrPgYjrnhauLsgGH3UtTBWz8xiTVGD4WqjS+GxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou7MGmKUn6RWsuddWPnfvsnlwY+xdUyccXyy/JTGyq0=;
 b=QDQUqTG17szzyb4RR+kZAU4kIqbt/c9A84vXlCASnJIjHVE+ggrn17KgQNEoN0hS0lM42UgFN7ihwBT4zEposSJEfAgAt4vY+GLjk1jqlM4FVClvsWVvXZtukL8UckOasubAOyX0egllFL4o5kbIrUgETAQ6MoUhYL0sInQsxa348DKa1SGbCf5ivyGvOvPRsscsCibviMjDmZMTUsEcJkIwLcdMU39Vj+nAdhIrXXLMwQYXBieWWodGfcNWBLf/cdVWrvOUDJDAWdnAraTI5xdDFAQKrvJfCzmURqrpoHXncppVMI8M4NgKHo4t+HW45xRKmqHY02yBv+mO5tV0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou7MGmKUn6RWsuddWPnfvsnlwY+xdUyccXyy/JTGyq0=;
 b=PHAmUs3YIP4jwa/DlxwlciT9/jCE+2/0pgGorIiL0YA8gfxuKDRsajknSGJnIj/jbJvBRz+j3ui/3r8/KACg9G7oNLNQPyxt2dAfTZARp2y/k363pkI2K3k0YBboQylt5XclpkY6uGtHN9GuB9L3RRIuN6INcUNvL0OOH4t0WBXcTMQtzSmK5QgzlsRzYzphd1YpPvvvZ6PRqxMfSiNLnA8dSJ8s8QhIdZCt2QaNSF4vatycuJtmz/Ls/VlG53GGVbhW9l+sZvUnoiASa8YBxgN57PDAu4q6k54qKa9rphTLIiKd388C3KX1n9wQltZx89G+s5EZDoJtUGHE3cw2Lg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 17:18:14 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 17:18:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "wagi@monom.org" <wagi@monom.org>, "hch@lst.de" <hch@lst.de>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvmet: move async event work off nvmet-wq
Thread-Topic: [PATCH V2] nvmet: move async event work off nvmet-wq
Thread-Index: AQHcptixhf7e+Xh4a0aud5WZEflxqrWnVD+AgDUSFgCAAP9agIAAH6OA
Date: Mon, 13 Apr 2026 17:18:14 +0000
Message-ID: <8b001133-f62a-4f15-a12b-c98524454b98@nvidia.com>
References: <20260226043003.160555-1-kch@nvidia.com>
 <010359e2-c219-4e2e-8b5b-5e86eda5653f@nvidia.com>
 <3c93edf3-87fd-486f-bb00-8db2cf925641@nvidia.com>
 <ad0Ky5rrzZt3Xcdu@kbusch-mbp>
In-Reply-To: <ad0Ky5rrzZt3Xcdu@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6548:EE_
x-ms-office365-filtering-correlation-id: 74501bbc-05ac-40cb-76b5-08de9980a577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: TmRGv/toIoAVMDCgEme5qLeXVpP7PIwY5YspQpkAr6PEsxq3pfBkx8R9hPKvZqn7/0yJHq3GPnkc3Tmb0etZ7/o0KsbHQXbJ8rTansWl+545Utk86e0T+TJYbdgI1evXhSrDQMrkgVQTdw6Ji9YaUCDdl6O7B7889aFBTWi4yk28H0sDWfzBibgdyb3CfCqf0i4qSOq5JABB98HAWk7aoseh4osQz92C6hnem02Ldb/OsZV+g6fgzrnrc8HjzzFF5ObotxyFqWdBFelygMHv6DgzoK3H9VUpihfPodgHdAODU028D8946tIBnMcdgPZj+2tzgYuZvGg0NlO2qlJE0DG6bnWWBfzS4w2nFnXzMJAkTBX7QiOtxFpNK73KeYrylBloWULnxFQAlojOLbRrTfcvBLb4q83BCAMgeCfDtxWvDEZtUhPboksKPcUBlQsslNdIJtZGw7tmLs3oIsqOGUuTTRUJVoLbgE2Qv70RNWaJrZvX+iNNPKUDzKNyLK0pXX4/8L7ECQXghnFnwHZ9AZAuvqZQTgre5w364dnFZconfYsJEzjmJU8NaIL9cFGwLj94WL91eOoo0Wms78rw/tOs0PQ1Mbt7/ulx2xEGqk/5u8s8UyihC9vZLhOTLytbRyVVI7yr4NFCohJyWKDCkTAHnHxlO398BbdNYJw6jJSaAvKwhuGrXRVRz0kax/R5ti2kF78lobZknX5t5ryWD7vtsUvssg3p7oVbjizu1a3v4d/4pjM+Wu0Ex7rTM2ayeqH70Oz5r6M+mWoVDWeVm9/4F++0Nvua1L0Fn0NZ7e0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU5peXlUUXprcFUrRlJlZEpneEduT2d0RThLMHNWaXB6dEZnMXVvUW1PZDNZ?=
 =?utf-8?B?aElkZXBocGZrbTgySnlpR0FwbVp5cU1sdmUydG5rd2V6RHgrV1gyR3hVRWFO?=
 =?utf-8?B?L0dLUGRDU2ZXWWs2VXJ4Y3JGOE85cTc0ZHRlNE9EVXJBSTdQRkFJZ0xQNXZl?=
 =?utf-8?B?NHRXNnpCcEZodW1COHhKRXB0SlIxNmgxalRDQXQvdVlGaElTN2prdXF5aDNH?=
 =?utf-8?B?TThDWTB6QlBpeHRmT2RGQm1rN0ZkUVJveGZkMm1HT0E4ZDU3ME12KzE2L3Bh?=
 =?utf-8?B?WVdaVzc5a0Y3QUh4TERnbmZPc0lPQlliOTM1Z0tTcUtLTDJsNEViS0RwalQw?=
 =?utf-8?B?SXcxU09KZEhBVEM2a2tJaFgvcU0xdFlqRlFZU2Z1elpKWW9xYW9tSzVLS09W?=
 =?utf-8?B?alViaUloZDY1Mlg0a3BtdmY0cXVEREpmWXlpVThIQ1grMXN4eU9DOVVYdUFU?=
 =?utf-8?B?a0JvMWlUL29sSWk0Qi9aRHJYZVhleHlVeDlNcG05MUV2TTl6TG5OMlNVNEFM?=
 =?utf-8?B?TkM1R1BzKzdwNkpBN0JjWWpyeEt1NWJGTFczTHZXYURZc3NqQlgzQWlIVTdx?=
 =?utf-8?B?VXRYZXVXbWdPWExuYnpmdEJFWG9COEZXeURXbWNXMGdEcVcyTFBPck1IdjVr?=
 =?utf-8?B?MmZ1MG9CdTdvTmZDZHpvN1FrNlpFL1NpNjZ2MjkxdEdBa3lmY1RseTFVVkZX?=
 =?utf-8?B?YVJaeDhmMEg4cC9HMGswdkc0UVlPNmR4cDd2cDJCL0NwRXFJWE9KTmViVUYv?=
 =?utf-8?B?dERNMENmcnhaVjF0ZWNCdy9aRUV6eUtvRXBhbFpDdUlwTkljRmxJdys5QURj?=
 =?utf-8?B?MkpHaVVXbWp3VmJRYXVYNFN4VGlqWDI0TGFqaXZTMGg0eDFTeSttbDA4c0Rn?=
 =?utf-8?B?SjRTbm1PYnBZMldwQjg5Q0F5K212Y2lwenIwUEl4azRaRnpMWUNxTmIxM3NI?=
 =?utf-8?B?MEtqQ3RsUkhmUktERTIvaTZIemEzajU4TXhxbVJveHNKb29SRWNJZjVuTkdM?=
 =?utf-8?B?ZGw1ZTI4TThkWndmelB5emhLdXUzTE9BMUF5TVI0RVo0ekZ1VEpiNThWTS90?=
 =?utf-8?B?MWZiZzF1MGV0bDRBdkVadWdXc3FNdWdRTHpFaFordWk5V2NIREdENXdaaXM0?=
 =?utf-8?B?U3RDRnB2cDlweUpWcTk1YXNDbTM4QUxnTUJCSkZadHRWTERsdzJTbno4YkhM?=
 =?utf-8?B?WDZ5WmE0VkcvK3YreTdwNmZDWEFXclMvSVh1dVhOaHVsTVhIaWhJUmhsdzBn?=
 =?utf-8?B?ZVdCc2NsTnZhc1VSQ0tma25ZUVBsZGpyN294VHhsd0dOVk5jNjFhVkJYWStN?=
 =?utf-8?B?RWt6TmxQSUZLRnNPSjJmVzNNMy9FOW9sWWVNZi81dW0vVjJkR25PQ1ZEaGV4?=
 =?utf-8?B?YzhmcUx0RDlKbVNmVWs5VXkvV2I0d1Y3bnoxSmRZdlZuWGZYSm0wcUwwVEpX?=
 =?utf-8?B?a3B4V0lQZ09nQm51VmlIVnhnMnNUWUdlOGR2WWdmUnNZVGVralJuSHZJU0cx?=
 =?utf-8?B?Z0JCbzVvUTAzN2JwOTN0c2l3SnRwNmV0UENmTnI3WURHWm9iVVdoUTVsWEg2?=
 =?utf-8?B?M2hnRWtUZzRleFBxQzZFaHdGQnQ0L2NHY0FJUzhEbDZVQnVJMVpnSjhHT1NR?=
 =?utf-8?B?QUl5MFgzV0xvTVdCbTNQTWxGTDhyY3V6WmgxeEdseklka1crclY3N0d4blpW?=
 =?utf-8?B?NEJVRld0NTdFYk1TT1BYOGtOUkp6c0xlYjBNTHBFNlQ5ZzV4S2YxcEJSTkhy?=
 =?utf-8?B?MlF0TDlXT0dUSUVIUUpNQ3hxKzRMcVFidHNiRDkrNFpZbWNVdiszVVh3NDJq?=
 =?utf-8?B?eUM3OUgzcDlKK29DWVZDYml6M0hrVksyYUpoY3kzdjJXbExiTDl2TUJDSUNB?=
 =?utf-8?B?VmZ6SjF4dmhtdmxMcWhUSEtFZDk3M2R2NytFQVpkdkpRWlZuN09HNmMzMDNv?=
 =?utf-8?B?THU5WVpPT1c3Z3lycGJPOUNBeFVvTmkyMlpKS0dYOFhMU1VvQWhIamdtUW13?=
 =?utf-8?B?YzZObGM2TzN1d1BXMkxXdW8zaklvTW1DRkY5VU55OFU3cVBpbmpaamFIeGZC?=
 =?utf-8?B?bzVZbytTZzNGRDhDZU0yUFJDN3FFYzNFZGxhN0lXWmJ5S3ZEZ3ZBdk14d0Z3?=
 =?utf-8?B?bTVxdEFTQkh1NWFxL25WMGM1T3UyT0lHL282bnpQdnNmY2NRbitmZjU2MklC?=
 =?utf-8?B?eUIzNTBZNHRJYjAxV0V2T1BjMFgyS3dWVm5zMndRWG45ZSthVVNJSmVXbFUr?=
 =?utf-8?B?UjYwbmNwUVhtclEzc1FXNU5JTy9tcjRDRjBLbS96ZTBndXo0V1AxZXh4QVkr?=
 =?utf-8?B?NG05Z1F5RVR0cnVObmd5a0NGWWw2N1UzeHNzb1o3Qkdxd2Zwb2lzTGR6aW41?=
 =?utf-8?Q?jq7bvgLsjNrh8OFahGmgsLx/JNLdSUH6+4aoEBbfTsIXl?=
x-ms-exchange-antispam-messagedata-1: ikK6AB22d3MNQw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B795FAADE50304A9C431390C2283B42@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74501bbc-05ac-40cb-76b5-08de9980a577
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 17:18:14.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUgr/bUKoeC3pC4VhDVkJBDKK+UY3q0o5PNNWTHnPdMIStRF8RD5FqUEPkC9Kb4Q7iP//J6L76UdKpwEygp7rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_101819_891110_518DFE7A 
X-CRM114-Status: UNSURE (   8.49  )
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

T24gNC8xMy8yNiAwODoyNCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIE1vbiwgQXByIDEzLCAy
MDI2IGF0IDEyOjExOjAzQU0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IExv
b2tzIGxpa2UgdGhpcyBwYXRjaCBpcyBub3QgbWVyZ2VkIGNhbiB5b3UgbWVyZ2UgdGhpcyA/DQo+
IExvb2sgYWdhaW46DQo+DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQ/aWQ9MjkyMmUzNTA3ZjZkNWNhYTdm
MWQwN2YxNDVlMTg2ZmM2ZjMxN2E0ZQ0KDQp1Z2dnaGggZGlkbid0IGxvb2sgYXQgdGhlIGFib3Zl
IHJlcG8sIHNvcnJ5IGZvciB0aGUgbm9pc2UuDQoNCi1jaw0KDQoNCg==

