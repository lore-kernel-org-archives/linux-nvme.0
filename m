Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A797DEB64DA
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jul 2023 08:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XWJhIhhQxi3f5uCy8pceqRmuFdZBzaqWogZlywi0cvk=; b=BVYnFf3KaIEDlhHdrReZAo8GLr
	vrjg7eJOMIDVsBMMwWTXfOMYc6R+hGyAx1k/d9qWgxWG/k9KzuPMp6+YsOu2+Jtdr5Lc7UQIyicIb
	ly3IE6zQkNtSx+VUsLYBAV3ElyKt6+jnnc3YN/VXcU5t/+2JWdxTRnJIhv38d+qInHQhRW2lcCaXV
	TWoKdEy06dHt80bGmJp4X6lRxnvup2AKZmQ9eDtzfIjtpupiPx5AKHQZrvJ5e81farQnlPby+bONP
	ep8HxXREEgQfFivGe5GfPp67A8KncrJJHBv0bbwiyM4U6QYZaquOjyRhYlpMQoccP+MQ0+tiKlVU2
	2ixbyCVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMOba-00ADrS-3C;
	Thu, 20 Jul 2023 08:01:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLzVY-005BgB-1c
	for linux-nvme@bombadil.infradead.org;
	Wed, 19 Jul 2023 05:13:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
	Content-Description:In-Reply-To:References;
	bh=XWJhIhhQxi3f5uCy8pceqRmuFdZBzaqWogZlywi0cvk=; b=HYOrFOAsMsAIJc+rXRSDhyTSNg
	eSQNbsCYGEmnbcTygjSRoqG6xXWrn99NgV4Gpy5Ri0gzGRjp4H20nkQJUvI3lrEgQjqPyz9EIA5d4
	6wKVBTvMaSC7IkJ2bPrFV2hRsr0sWFi2p7Fx0JsLxPC/WasTzgNwzhSHX8o/3j5EgljPJxUr9Di5P
	mlIeutAf10BqzL0zVv/BwOXC2f6iJBVPzX//lW5CQvjLpRrxwLVjMy22SPXgWhQfLwoCQM9ctiJ1Q
	ALz17wbn6wAUIfV1kcxfx4jTHgpcMbIYTOD5H+wksIq0pbnbjh1in3wn0emkbxijaNwkAY/eDJ37K
	knxWoutQ==;
Received: from mail-sy4aus01olkn2082b.outbound.protection.outlook.com ([2a01:111:f403:7005::82b] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLaRD-009Ycj-0l
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jul 2023 02:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjJtv7T5jBcm9GSDIOWyzCGeMdsatqAdORX19MSj4dS1KnpmEOyLim/wandcXZ6NCVGNNqzmKADBhKmAglABRMi6cAs8uZ+CVXY8RbMRKXm9iI9LQX+2gI0T5w0h3KI0wsu5A9eNswrsv8kIbra0vvAJAxYzB0r+WsaxnXO0y4qFA/AxewOEMPTnGAC76PaKP6AoU7sgrEuBHVn4OMIgjoXJmg+EZ4cqOdSjIN1bddsRcCmukH5e/DsNQ+4QbSG6W3tjpSUkPv6TdL0rTEsP7rCIGzPa0ClwNbxDeQ/aSe9/a0bwx58FsDIjyTgrK2V2papYqW+1zbbv824+NTSJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWJhIhhQxi3f5uCy8pceqRmuFdZBzaqWogZlywi0cvk=;
 b=ORSyA4FEm5pdLmKSaWTf7t7ukk0jKDfOC8agpeea3K+xVfSSNN1MAan3bSpcIWPqlKMCkuTk3C9FC7TXSojzMzA1Ap94goueGA9zHGXLCzDCOiJTpgvXRomnFPM7e9KxEBCTS+l50KD8kdPB/flbXdyLU7mJu2x4nQWQrCwx8qgSOpyjsWylVWMBRo4zQISYiTaoSIyPLbJkc92usOmV0Qt8DD0SjtDTw0qEDT48Z6tPQGfxbXlM4sI2BZZFAtOGvYU2OHCv3bWgyWe0RUPq9y0IC8pbDBUsrgeI5bwx+mrWcbhoBd432qMBACjGXeioSRmjpi0uIDRKTWVin2nkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:67::16)
 by SY4P282MB0713.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 02:10:19 +0000
Received: from MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM
 ([fe80::17f0:47ec:5b80:befa]) by MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM
 ([fe80::17f0:47ec:5b80:befa%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 02:10:19 +0000
From: Sean Wang <wangxiao@hotmail.it>
To: Keith Busch <kbusch@kernel.org>
CC: "highenthalpyh@gmail.com" <highenthalpyh@gmail.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"xuwd1@hotmail.com" <xuwd1@hotmail.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO
 MAP1602
Thread-Topic: [PATCH] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO
 MAP1602
Thread-Index: AQHZuRz/4pM7Yx5Izk+nN9+4clyb9w==
Date: Tue, 18 Jul 2023 02:10:18 +0000
Message-ID: <MEAP282MB0391131326CF9E3BD5C26FD0B338A@MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [yonEutE58g/aawD2P1RM/V78dO5MDEcjlzRWIlj8Pcw2R8kaVr1xNaE+oWnN8xTw]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEAP282MB0391:EE_|SY4P282MB0713:EE_
x-ms-office365-filtering-correlation-id: 0212d734-818e-41f2-3086-08db87342288
x-ms-exchange-slblob-mailprops: AlkLxVwsndlK/xdeJGbCEqdX7kEGFcHSyLAJIUxS97hoa48xhCiYaxhVcOtuSiImW5SJq3uofzwY6PluW3PNRKp+JuDJsJZltqtWDHQ9fGyzGd3tDYCuGWgfeTdDSbEGVEsSwTMOK/Eqvy6CoKkPcnxrfGrapBSZQFCTpG3YWQIK0hdnlEfH4COZ2nlM9gQOk5ymyT6dsMhkY6qvDxL93vu8XRPT8GypSHGcAKTPv25MLiTcbEdtTa57/vPJLZFCW28aQ6SfF+VMzGueX+1CDyL00MvkJQvVVkzuJphvZ9bynVKc76KSzYdjzgxaC3GalJnQ7R5G6/q5QF2aBaTARVZyAvZmB0pjXu7vUqFh7Z7Ewee5efK1nb9nVpIh+Bi5uhJYx+eAG7fiN1WTz9fbdmu6imHwU046NGJiuZGn/OjqmbtdA8eTyGx7TwhGoRdtgFu23/4DwfwDRAo0xrGCrhkUAasBK6iP39c+yR8wrLrWPtRc674eG82Q5ChFGVqBhESd4sOvNiR6MO4rHiEjTxD5zJmSheOszO52WkT1bANAPLXGkhb0wX7iprLeVNkJ4qPJ3Tho7h2Hg8eTIO7JTvbGYNcuFUPNChOXNgLpuJRrbqjLV+yXhIlZRqgO6+N9qUyB0LXrIkwuLRtZO4ozRB0Nr3C6Y7JZBVzHBNH2E4+nBJSL1m5oNHahGroo1rmd8EolY4vEVUX2Du2+mE1Ma3iHsvOoQOyZp3uJDMGZSJir8VieZvVOO644vg4N+cnyx019p33Pypgrd2AconQdA0pasivhzSTW
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKTKFazlY5Q9OImZBVW1to9XLXXU5wRjG1c09rqkXGJ0FeZS0ZKtZvu5KCEJhixKuTWnAzPjhleLGcIZxIw2jTHAdjpwNu6QCVVh0o6vjMJY+oqHGOKgBWEmlqvbb/r2KAF7v0tokTBc4q6Qh8bN7a3JMWzFxDLYlbNzkiMjLtkp2KIbmo+wET8Ml9GUVkj7PHmSsuFbInEpzpICTdQl3/IYr2GIFsG9WNTeX4kZwscxAUPMj7XlbAoIaoQco9mEThEXRtHIBitYCfgcdnSIObcwb0kOZWl0KieW7Mq3N79/+rE9XBcMlTIvDFhUp5ljfCcmTQrlIz6I7Xuu/Qxd4O14sFEGLe5tkoOTKHsqc7o85pal8weX8oas5znISr9d2mUTmxzzWZmUpBLYD6gtuZvV5OSA2uyLazhM/3aUSI1wnQJzbgp+Ed2TmPbeOoWhnNbVoMI+oj/IFAiBOIVt9SOgjjjbxmRydtD6+ly7EwywVEWN+r/s560LNBGWnbvV0iq5YDxDuK/nMNu0A4uLiUZxkeeW+h8DQOyqZBec+Apfoq5uqB0gJ+NGHS7vETgF
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk55bTVJdytmbkVaTlNlOUtBMVpycnY3SE5NczRBV1dVNndLREtrZFZKdjZO?=
 =?utf-8?B?aDVhM0V1UU5LSlBFdDdGUWJYbWpMZ3NZT3l1V0FQUXlnR2JXVDk2amRIdUM0?=
 =?utf-8?B?KzcvRmNsQnZ1M09JM2E5RjRrY1RzMC9VYkgzQTQ3R0tMRElTN1BxODlWRjNF?=
 =?utf-8?B?cThkM2hDUjE3UHlmOHZpYUdyTnRJSlUxbmdJQlNWdldxTkRyRUpCMmR1cUgz?=
 =?utf-8?B?NU9KM2crb0ZIWDZYZ01Ya3dyMzF0UlplVy9Uak5Fc3Nnbi9YY0pHNTdvbzR3?=
 =?utf-8?B?WU9XQ3lOdUJDM1prU0FmNVpoUm9iREp0bHhLeTdtQnlyN1UyVTE1MDVhUjlM?=
 =?utf-8?B?aDlhUnhEWVFpY3BwMkxoQlBiUW1NcmZNY3hWVWdVTTVRTlUreWRGdUEyeWlH?=
 =?utf-8?B?bTk4Sm9FblZGemk1MUwyTElzZ0JQaEkxU3AxWFFoRGMrQlY0Nk1hUW5xL2R0?=
 =?utf-8?B?RGlVS1I5aURJWTFaejhiUStkVXVFV0Q1UGpGaFg5ZitzdnUrK3Z6RTlSdzVi?=
 =?utf-8?B?SnBhbjV3R0ZBZHJ5TWwvN3RUVDM4d1gvZ2tFUGdJYi83ajRTdlVvQ3k5dHI1?=
 =?utf-8?B?R0tWbVR0UGU2NTI3c3pWMlJtMiswclhQOEh1WmlPNWs3dkRIRzdpU05XN2tR?=
 =?utf-8?B?d3luTzFxeUgvaGlXKzd1WlFQNDFRL1VWNnk1aHVIeUdKcDRUdGhJaUtnNlRP?=
 =?utf-8?B?V2dBTzh1OVZuWjFpc244dDZzVG80M3JJclEwK0pwYlhHT0F0N1VMSWhpZy9D?=
 =?utf-8?B?ZkNVbTB6RXQwdzAvdjJtTk9GWHl0UTNFSzZGWFJ4L0xOWU03MTFFclhqTVRB?=
 =?utf-8?B?ZWNPTHd6UTN5MDBlMXdoQ3lJaGhFWVRYc2Jsc0hVNkpQclNjNE1rbktnNGty?=
 =?utf-8?B?Y0ZybTBDSXBFZTZOTlFpY2wyYkRDZTd6WnJLbVUrNUFzWnhRYllZRlF6VVBp?=
 =?utf-8?B?cExjcEdmZS93OTlBbGVaUnNmNmVzZjVPUWs2azZLdnRBK3p3TkhWZkFEZ1kr?=
 =?utf-8?B?NkdnYXRxSW9IV1Nja2JlTHZ3N0owTGlQVW1aVlROd2pzY2E1RmJZZjNXc2xn?=
 =?utf-8?B?Mm94T1BKNzdYMGp2QWh2UFJhT2lDdkR2UkxiUEgxMzBFMzFQM1V5alRTY2xh?=
 =?utf-8?B?dHJ5MnpLSy92RnU0aEtRT2wvcEJYMDlwSmFORGJZQTllNkRyWjVRME5mNk9W?=
 =?utf-8?B?RjN3SXNDOTB4ekJVSFpocFZITUFQNnRuamw5UEZoNldMcTkxRE9JNXB4SWp2?=
 =?utf-8?B?NTNWenJZcjZnUUphTUROeU1zOUdRTkxDdmxLejN6VnZoN09SL21UNEFOSWdD?=
 =?utf-8?B?dEhtQmgvUzV0WVlsZzVWcFlGMTU3NWE0Y1p2QzFBS1NBb1JsUGVjYnl0ZEFq?=
 =?utf-8?B?eXdhcnQwWVFnR2RYMGRrMjVUbnJsM3Q5R05NQkFBdlFGQ2lCY0c1VXVpbGdG?=
 =?utf-8?B?eS9Ybmd2S2x0SC9ocVFmd2pPUjhldzhnVkozYy9ROThLdHpXK1ZWTlM1eTNs?=
 =?utf-8?B?YzN0WDhuYTllazZ2OTdoYlpkdWxNNUpyMGZHbzJLKzJzdzE0NUVtYXplSkdq?=
 =?utf-8?B?cnJ4alZRbmtmK3JGZjEwbmcyK2p1blNlYTRVVHFkaHJXVk5MYkR0bndNYVNK?=
 =?utf-8?B?Uk9XVFNpcXpDblU3QkdKNk83U1pJZHhQNkZQZ1YvL09LWHBEc0dnN1pQN2Rr?=
 =?utf-8?B?SUdxLzFVK2duaUR3YnBTbTkwTFFHYWpTajR3YnExTWFUTnYzMHRVM2RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D2DC4DFF217D24E93DEE78920908954@sct-15-20-4755-11-msonline-outlook-746f3.templateTenant>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0212d734-818e-41f2-3086-08db87342288
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 02:10:19.0183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB0713
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230718_032744_851764_50FDDA0E 
X-CRM114-Status: GOOD (  14.81  )
X-Mailman-Approved-At: Thu, 20 Jul 2023 01:01:44 -0700
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

Q291bGQgeW91IHBsZWFzZSBwb2ludCBvdXQgd2hpY2ggcGF0Y2ggaW4gNi41LXJjMiBmb3Igc3Vj
aCBkZXZpY2VzPyBUaGFua3MNCg0KU2VudCBmcm9tIG15IG1vYmlsZSBkZXZpY2UuDQoNCj4g5Zyo
IDIwMjPlubQ35pyIMTfml6XvvIwxNjowM++8jEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9y
Zz4g5YaZ6YGT77yaDQo+IA0KPiDvu79PbiBNb24sIEp1bCAxNywgMjAyMyBhdCAwNzo0MToyNkFN
ICswMDAwLCBTZWFuIFdhbmcgd3JvdGU6DQo+PiBNeSB0d28gU1NEcyBhcmUgZnJvbSBkaWZmZXJl
bnQgY29tcGFuaWVzLCBidXQgdGhleSBhbGwgdXNlIE1heElPIDE2MDIgbnZtZSBjb250cm9sbGVy
cy4NCj4+IA0KPj4gQWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaCwgdGhleSBjb3VsZCB3b3JrLg0K
Pj4gDQo+PiBPdGhlcndpc2UsIGhlcmUgaXMgYSB3b3JrYXJvdW5kIHRvIG1ha2UgbGl2ZSBjZCB0
byByZWNvZ25pemUgdGhlc2UgU1NEczoNCj4+IA0KPj4gDQo+PiBlY2hvIOKAnDHigJ0gPiAvc3lz
L2J1cy9wY2kvZGV2aWNlcy8wMDAwOjAyOjAwLjAvcmVtb3ZlDQo+PiBzbGVlcCAxDQo+PiBlY2hv
IOKAnDHigJ0gPiAvc3lzL2J1cy9wY2kvcmVzY2FuDQo+PiANCj4+IFdoZXJlIGRldmljZSBpZCAo
MDI6MDAuMCkgY291bGQgYmUgZm91bmQgdmlhDQo+PiANCj4+IGxzcGNpIC1ubiAtZCA6OjAxMDgN
Cj4gDQo+IFdlIGhhdmUgYSBnZW5lcmljIHNvbHV0aW9uIGZvciBzdWNoIGRldmljZXMgYXMgb2Yg
Ni41LXJjMiBzbyBpdCBzaG91bGQNCj4gd29yayBub3c7IGhvd2V2ZXIsIGl0J3Mgc3RpbGwgcmVj
b21tZW5kZWQgdG8gZ2V0IGRldmljZXMgd2l0aCB0aGlzDQo+IGJlaGF2aW9yIGluIHRoZSBxdWly
ayBsaXN0IGluIG9yZGVyIHRvIGVuc3VyZSB0aGF0IHRoZSB3ZSBnZXQgdWRldiB0bw0KPiBnZW5l
cmF0ZSBkZXRlcm1pbmlzdGljIHN5bWxpbmtzLiBTaW5jZSB0aGlzIGNvbnRyb2xsZXIgaXMgdXNl
ZCBieQ0KPiBtdWx0aXBsZSB2ZW5kb3JzLCB0aG91Z2gsIGl0J3MgdW5jbGVhciBpZiB0aGlzIHF1
aXJrIGFwcGxpZXMgdG8gYWxsDQo+IHZhcmlhdGlvbnMuDQo=

