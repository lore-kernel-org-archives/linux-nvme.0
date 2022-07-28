Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4411AC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 23:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJFODHA/sMgLPvpRTK/SF1cd4dAPrx1H/AYcpgSJg0o=; b=o3YqLdsUv/499t9YlxddoFy+8o
	Dx3BnO6GC+me5PMC7q8ZbhGsI5Z83ARu83/cS0Jo9Nj0F88ei0SiAGRTxLGZvUNHINanddei4tHbK
	MrJK2gU+K6h/Wjy/l6XFSq81IlntrnPPt3D9qLpicl7cRVhKjIE50n4ljHvtPgDU0zMcJHYKH4Q1R
	6qNtDEvM6t8Qt1G+WL59A98yL3+yMwj1IzuOTR8wsXV4b6H2DIyAcbG2aOw0EaTD+iA82zbp7pAD0
	VLh/jCtgJOL43ZdVIZYvCLsreTwY3EyCPbROcfOV5cPmI2cZF3P1kHKYMBXJASbhM+iBQ5JobEnb0
	semJXTBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHCjY-00FhLY-Qe; Thu, 28 Jul 2022 23:16:00 +0000
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHCjW-00FhJx-7l
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 23:15:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blngPTq3D72jFpB64Vk0QwxiTQHEoiK1EEOFus26e/RP1QHYpDhwYE1vXu5PUfV04pKjgpIwn1UOhtC8QzvaaBW97p13sneWKxWpCDgPJpf3sXQ3DbQNg9SODlvpf83kft6N2gkrk2dcTU+2YlkDXID9XGhHYLL1YE58trUthAuWXmyTicH0J1pbB7Bi3Ml0W3Pm9B0R4D3Y/RjL4N8JaFvhUNltRHX82pT45VQmFkfJTJPUYGnisomLxaPIAOw+a92c+B+SGHdLZcacR0u3fnZtHyHSrWijzHMS2CpmCOn3Hjk20q4WkeopDPRgnwLlPCBB8fefCUm1wEMZm5cihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJFODHA/sMgLPvpRTK/SF1cd4dAPrx1H/AYcpgSJg0o=;
 b=kPE8tofFxeKml18pLK4sUVY+1q6I+egnGtqnn+x/zyRaT4BKYRfuL/jDYqMmY6+Vit0zcxhcNoA+Xoj5GBwLuKLxlpVyTOnVpjHPqFHsO4aN0y3lUmWR7WiPnRWAzj7F8LRVsPLIZVVp0vVrwzeMc/hz5yE708rvkPdPANKL9NqSvUunRptV+UU7UT6SfXvyboN/buoCrWM0HD+lymFdZGR0fmh7Xcli/9D4kF7gpfGByLItOxMT8jqyELdJsPNfJ6aPxAPqUWG6b+g97XUMk5kL6/aEjriZ2O0imVxqcYMurOmbACdrS+Z3iLAXal/NRfMGZLFjocEobrW59wDY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJFODHA/sMgLPvpRTK/SF1cd4dAPrx1H/AYcpgSJg0o=;
 b=UDWipz+v6wkrYCvfFOBWF/rhG9ozI+FpLW+RpEQO0LXxhAG/SMetV4w9PmB3g1fIim9S/M0HDDOLVaeuE++YssNOdbJK2xf2Eq0Ws+vkw7wl9s5EoinyiWDDqS8ia5Z1hnWhYp9Xw8lNOp0wav+GvlQ1rqXJcTwjsNpBAIMdlAP+YjoErED0oKGUW4n5ybKyzHrsc8bf+KYbigLcczWP/LPG9wipCdsntX5p3G75AszoBeLJisSN6IUyW86kGnLS0705kaYG7pDFlw0c6e8tT9ZglCXIHVk4eytz2es1s9/htIxA2t3wSOm25+G9YnsgEiF2kz3nXQ0PJNs5P4Zp1Q==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 23:15:54 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 23:15:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@fb.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/5] nvme-pci: move iod dma_len to better pack
Thread-Topic: [PATCH 5/5] nvme-pci: move iod dma_len to better pack
Thread-Index: AQHYos81KU1MrArtsEGZu0pAvOAA5K2UaliA
Date: Thu, 28 Jul 2022 23:15:53 +0000
Message-ID: <62596600-fcd6-0bb5-ec8c-384d8fb62ca3@nvidia.com>
References: <20220728221152.538648-1-kbusch@fb.com>
 <20220728221152.538648-6-kbusch@fb.com>
In-Reply-To: <20220728221152.538648-6-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7233ae7-55ed-460d-be68-08da70ef1e94
x-ms-traffictypediagnostic: MWHPR1201MB0062:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  eU8PRoG6O9OIZimqrMll0PgUMb1Vq9XWC1CinZSvI4IJpC0gIMTdmL2N+I9CzubniROSVuIkn1xjVw7pABy6wTs5s/A2K5VjlcWMGwNbN9IhLvXOYkqp4k67BAe/WBg5yAIdNSNhfgUOJOUzREBOyBlycaM6hKUsEOLN9Uo64tit7UIZPPw+4khqLZtoF/cMu+AaDDlt7SdsQXvpJL82MtSTn4W2Z8CjTaVQua8JQJx0ciwDfrJ0AQapf6rE0Gx9GsnmCqNNkf+4BTq2/sMukBnF8tS2cbxFVkVjEitK5RiPl4xUXDRsPWUCHijZVmfI601z0Z94T0yKrnSCQXi3R9b13E79XG6FgMANW4I44YhnY9firced1h685lWUmafJKQlp3zjCk9ss06m8wLuA7t0qA/HlPh3HCMwNFfdAfA/lJ6PN7cHYVW89IqjFnUCvkkbrixLuCwWEdGoozHYHsO/X+5kWRrx1ATU1wDMDWe1tWtQrKSlKqJVK7ki5CJ2PnkMBzyWTEDmClWq5iR+QfkkzcfZfsRJIYlTc0rniSs3wEbo5eo7Znerrebcx/b5GE8zuZ8TmcnfaqsUa++FeIEWgD4N8dIEwy7mn4Dz6yqtZ56FtqnZe64iVGujt9Vknur8fDGPV2V1iYUiskTSlWAxTOh0mPM2a/RvhLKww2z6agQKDjq8Gd/g3X7dIa+HKbq16GSf7txZ/PVuqHWE1TUxgkv1QUYOGwPqWehKLEbrPxo56HOLobuvcy9UXY/jvIj6lTJhPT51Et+b0C7XCUv6kK8k6YvH7XA0ckftusOR6sW8hz0gzm/mnPU3+YEvvwgn1JjFOwFIDG9A1i3pg+yHvXqSFYMKupYailY6oc1eo3FifJsUpNA+MCdMyy1Ko
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(53546011)(31686004)(478600001)(6486002)(31696002)(86362001)(71200400001)(122000001)(558084003)(38070700005)(6506007)(36756003)(66476007)(6512007)(8936002)(41300700001)(54906003)(64756008)(6916009)(316002)(2616005)(66946007)(38100700002)(5660300002)(8676002)(186003)(66556008)(76116006)(66446008)(4326008)(91956017)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?QURhZDVQVWI0cHhTQ2x5bER2c0p4N3FIQ05MYjllNGJoZDU4K0pEYzMxMEd2?=
 =?utf-8?B?U1owMmt2NlUwVnJlNktwWmtXd3RWYitodW1uRElUTHZNc1RiUU5lTmZZUURW?=
 =?utf-8?B?RGpZSytBdEVmaXBuRFRiK25RS2x4TTFLVU1IM3QvRjd3clVaRGd4djlzWExj?=
 =?utf-8?B?U3ltakVzTHB0cGdld2hxejdDWVlBd0dCbXF3ZEpBSnRMWEQySFlpMjB5Umtl?=
 =?utf-8?B?dUl3WnB5Y2Y3bS9UTHFzZFNDRnMyN0w2SENLeDE2djZvYVNjb3RyM1ZYT0M0?=
 =?utf-8?B?UXk2dGFUbm8velRCNndFRGNhWERzRG4xS3hkQ3Z0eHZJM0c4MTEwdkszNTZp?=
 =?utf-8?B?RWRIOVgyZDFxTkQxOGJCcjd3bmZWVnVmNm5GQVF0ZEJmUWkrZlp0a1BPV01l?=
 =?utf-8?B?SFFSRGVxTDYvWkltR2VnQ25XUXV2cnBpQ2VyV0dsOGNGZHI0dmlFSlc1NFBT?=
 =?utf-8?B?ZVY0S0hXcHBUTE53VHRNSm1lY2VCNWM1MzZRQVpjRk9jS0V3Q1l4TG5jQ1NF?=
 =?utf-8?B?QlJWMXBGT0NJMzFvQytXQVFTeDBqTHB4U29FSnBaTVpUVmVkblY0MGkrY3NM?=
 =?utf-8?B?c0NFM3lGQ0dCMVFXaHY5WGRrWEpQUGNFeXR2eGg3cno5RWhxdkhNMzAvZVBx?=
 =?utf-8?B?S3N6ZXJWQS9RYjZXWTVLemc4QVBnSmJDcEh3UGI0dCszN0FSVE5pdWhyc2FO?=
 =?utf-8?B?K2hrdkV2anZkOEpiWndDUERtYXFBUVRtcUc0RzVlMy9hNFNSQVVIWWswOGxm?=
 =?utf-8?B?ZWtSSGFSbVR3NXA1N2cxdTEvdWNyYUdNY2dIU1Jpd2VUZVd6clQ4MmZQQ0Jt?=
 =?utf-8?B?ZEU5NlVBdzU4V09rMHlYYWhtVkpodVkvWUJBUzdjLzhjU1BKdldnMFBtRlB6?=
 =?utf-8?B?TWtGd3licnNUYlRQeFFaMHZlREh5VzN6bjhXOUJMOGcwSWpkeWFzanFOQmdx?=
 =?utf-8?B?bkdiRm1hdFdTRC9DVE5mak1pWUNQcjJEcHRHTktuMUVNenRjdW5WaEJqVmVB?=
 =?utf-8?B?dTFKa1FtUG9ZaGJnV1dWMWFvd0VJRXYwUFpDUHQ5WU51UStGU20xNW9KV2VI?=
 =?utf-8?B?b1FSN1lRR0hWWmhKNDgzZjltU2tuYjVTMUxoU2JCamFKZDBNcDRUMkllUlFQ?=
 =?utf-8?B?Z0JmTFJjOTNaVmp4VU45aEtoTHdoYjk3RHFPcitNbzBCRFBTUEsrQ3Jhanho?=
 =?utf-8?B?WXVqQU5ibUtEU2d5ZWRiOTc2TFhlWXdUeFBrbXNWUkczbk1pRlphcW1KWlI1?=
 =?utf-8?B?RFlLSDdQUyt6MW9BU3hCWDdDUy93TjJJVUthR3B6MHpGUzJoS25aUWs0VXdT?=
 =?utf-8?B?L3pNMXZzcmhEd2RabUpWNTZFbGc5RlNEd2RNZFBtY2pvRTJkSFpKVjlvMjQ0?=
 =?utf-8?B?YVJRem8zcENUalRRZVZqZlVGZWVucVRFUUs1YlNmL1NOOVc0VUpRa0grQ3U2?=
 =?utf-8?B?cjZMS1grUWdaeE04VlE4Y1JES2J3NFdmR0pRazJNNlBSNHVvQi85YkxLWFVX?=
 =?utf-8?B?MGx0RFJ1cjU0RlZBSlpqVzA3bXZNSGFBclptTFRHY0cycG11dC9rdkw2V3Jw?=
 =?utf-8?B?bFBOYWVWWUpIV09VUlg1M0U5TGRHdHBPSjhaQnlhdHRENndiYlhpRWpGWlBq?=
 =?utf-8?B?MFJlM0pPUmtMdlVlSmkyejhnUWRRSk1OMGwvN1FDUENoOFVUZGFpYmlSTFlD?=
 =?utf-8?B?dW1FTC83K3EvalQ5bHRjUVlZaWpVdTVLNDhsbmJjSkszMjVHaVBtTG55M2x5?=
 =?utf-8?B?SzRuaVEwSnNxUkQzelE1VHk0NTJBVVhkSWZadE01TFVFMmlMSlN2dG5KY2dt?=
 =?utf-8?B?TkJscnpla0Jua3ZBQTU2OHN1dHQrQVl2d0g0Z0FxU2ZJVE1MRStNd1B6U2pp?=
 =?utf-8?B?ZU1OUXFrb3h2RnQyL2t1UzR5bjBhZWRrbVdHMEptbk4wR3MzTG5LR0syYmo1?=
 =?utf-8?B?dDY4b0lyQ0hyY2hsSWF5MituT2d3QVRicVBUamU2QzRvYXdLMGNsWjl6aW1w?=
 =?utf-8?B?RWQ2ZDJxSHJOYnlOR0lpYUl3K2tWSFJldS9mNEkxbVVDVFNqK3JPbXo4cStM?=
 =?utf-8?B?Nlo1YVIzUmUyWVNXVlhXZlRzVUdYMng5Ty9adFdjMmo3UGtmdmQyV0VwYkNk?=
 =?utf-8?B?MjBHT2MyZlR0ZkVjWnBVb0RYWk94eTEzT2diZGhqUFlSM1FJc1htTlJxKzdY?=
 =?utf-8?Q?EyFy2NP/B/LU9BZShcVtL1QVeWAkCKzR72kh9kryYDa1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F4FCB08EC5DEB4E94A80E6B751FCBFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7233ae7-55ed-460d-be68-08da70ef1e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 23:15:53.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ow7HolYoh+wQnUi6A4KImyjLHG2kOOnNsjp/M7ZzqOtRn9+7HOfh0i7aIwMxlZERUzmThUnqOOuu2ZB5dXEicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_161558_299437_4DF9DBDF 
X-CRM114-Status: UNSURE (   8.48  )
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

T24gNy8yOC8yMiAxNToxMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSAzMi1iaXQgJ2RtYV9sZW4nIGZpZWxkIHBh
Y2tzIGluIHRoZSBpb2Qgc3RydWN0IGFib3ZlIHRoZSBkbWFfYWRkcl90DQo+IHdpdGhvdXQgY3Jl
YXRpbmcgYSBnYXAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

