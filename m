Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DB5C3DA7D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 00:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pMDIu46XhFCPKS0ldab3pq2gV7sENJtEWmjxJXjPHik=; b=4sb9uxJdopXD+6+ghTeuhCcZz4
	SJyNrha9LYPB7bMSu3F5JyvyKrgPJuh31NlfseRW0E2xQo1yIJI6heG3TkYlvPUyGNqCT5qRth8CB
	BkwaaTqQhG6h59atLPlGuhAi9c4MEg4fd8CrDtHxXzuKRqLjZ7p6y/nlTU7DB1H4Xd8OJm6GSxJo5
	ZMcIin/G0gH9nRszEXmtXjMsXMncEnCh0yWny+qAGAI++PqDMcJLntMyfVUEw1DPWPfFMkoGczr4D
	45gDjPERjNCFB4UuKfEQbER8OPKn4EJ4rQ28M163wYlOMHhEKe8tln62xvYnwgB5fGpKSXKzn/G8G
	jipIRTMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCrjv-005tcG-LF; Wed, 04 Jan 2023 00:34:43 +0000
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCrhl-005sn9-Cq
	for linux-nvme@lists.infradead.org; Wed, 04 Jan 2023 00:32:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmozTfvtbIg3/meO97Lyp/fHABmmTf8eCFMAI8bWXzaGeFMeue16z4mj6BdhUwGbJc9Ds6rohv2AjIJ2K/eZrguEJpcDEA2Q/w8ysrEBDEwMIjpT7XtxDEyOYItXIf3BuMfNfRW4MnN8gceu6wt+3tZbpxEwYanv9UA/yF5mOR0OV80r81Db3HuDWggtUtX4V0BrfN+93MJyrP4SlufdT73s3MKUzFRxzSEOvtgVLVTOFw6sHYjDkElNFXodEyy7mTi8+WJKkts6qsJZkrmvAZQj/dn09vgHOthrKakngTTxGUQ6rCjZ3bOS4sn/dQSboCqqFNMZCcZY05q/n447LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMDIu46XhFCPKS0ldab3pq2gV7sENJtEWmjxJXjPHik=;
 b=OyWw/4rfHAGPo2n24KXCPXCcWTNzyfQVJSPS3Z/jIaRrXT3vrNrx7ssjid/aTyio0YqIP4qo/8Ug3XBAtkdS0vQJLaJ9Znzxi6mg9c4V2/XvdpuBguZm72PH5J8JYeVllsx3jsKdpnrmzkDXjPqj+AnThFt1x8Z8j4cn4ZnqzhdYIZ5Sle4yWQZyDYWIXbZouH082kxfV4J+sEESlv5x5sCOEqvnSbDyai7uN8FdgK9ZvjWlNtKMJ26L1umsIzjRzVJyaHC0kXRXTZBzbnCTFxUkLow3m0wIMYkyax8oN34K8F3d/p0zX0JLksSGamfg797wncLl9ZZnxC0sLsNsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMDIu46XhFCPKS0ldab3pq2gV7sENJtEWmjxJXjPHik=;
 b=NyQ8wVJSlKwKYhjYDLj7s4g1UmKS95f6ZbIA8QrY4wqj5Oh9mzluh9OzpEKeFW9qvlzPDzvccegU1gx6b4N0e7TmHB1EQdTiDkGZFYxn2sPJnmfDoEVbs1V7mzYZgX03nakkrmPF2XTKUrM8LAPY2z+WiomPev+50L46UF+k9fpDdehnykmWKLe/z1TssVIrzo0myloDLYGS82x/ensFHk3k44jbI0Ns6pg5ANQPOy9weoS/iH7qp3q24mRbhQ2pJpooBDNbv0VPXy1vTBB6z7DwSbFZLlBLaqtGmEsB/KlBlW5IcYDFBffZh4HKgrR+4kJK1fGgRfJqLK67EQVYQg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:32:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:32:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Taehee Yoo <ap420073@gmail.com>
CC: "james.p.freyensee@intel.com" <james.p.freyensee@intel.com>,
	"axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "ming.l@ssi.samsung.com" <ming.l@ssi.samsung.com>,
	"larrystevenwise@gmail.com" <larrystevenwise@gmail.com>,
	"anthony.j.knapp@intel.com" <anthony.j.knapp@intel.com>,
	"pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 3/4] nvmet: fix hang in nvmet_ns_disable()
Thread-Topic: [PATCH 3/4] nvmet: fix hang in nvmet_ns_disable()
Thread-Index: AQHZH1rMTRsBQ8Z2Vka7/EN462AqG66NaVCA
Date: Wed, 4 Jan 2023 00:32:23 +0000
Message-ID: <17ff8d10-d25d-3ea9-8d3d-2f07f7d7c9c0@nvidia.com>
References: <20230103100357.875854-1-ap420073@gmail.com>
 <20230103100357.875854-4-ap420073@gmail.com>
In-Reply-To: <20230103100357.875854-4-ap420073@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4872:EE_
x-ms-office365-filtering-correlation-id: d0429b47-d8f3-4545-e711-08daedeb2625
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  upnEcuHiHHqS/2UP/cjkbmuD3XNVz9RLLTxPQZcqG2uut5042hfXZfgPwfoMiB8qXlLHnAcCYVDHW7RspMRuAwLIGJwI3wdfQdMnSU+rm10Pq+4f8e+AmspHm2GkbBu+HTNccEseTEVu6UWSan6+VATB7fGEGcZ0xADbAP5VTw8278PUYCxeSQcua20bImLqzpBZgsPzN99VVJTDakH+QghBBm98ToJylrbjQ04biDZNro1DwedPFJEeXJUnVOYGn56vVY7uZrq0vRHvscu251v/0Ytpjk0/sNxSLDFEXpphgk8yjPEWyp1euoqUXD4gSZi0QfphGFbqe+0Uly8G7SuNY1EESZaQ0jSTInMU8wjY3nCfCUz7JS9Cl1n3YB8F9QDKhimqArstGhELcprN/RQ6xasgizz/+tAgzRwme5tJYR5xChMCNv8NY/FNdn0rYeSIUvDGSqvEU532XsXnwRzt72Ft4YC11Qzt0CkODtRL2i6WfxL+YNB97n75nJ/LwhaKMgqTb84oQSEMo97WpJZgqLHqr4ZNWRRk5kRey2+XYx9nxg7hUZ/mkAXj3OPLUDeeWQcCFYdL/yAyOLvWlsvq8oVqQpLghnaZwvKXJK8tGzpO1s/UiACFNRNAd2/73sUwJWcn84AF5uuEq/mZuz4NH6jE3ZJyJjggstUg6Idt7i/937g2ifA2tH7bm3yv2BjwBPB9FJtnzxQJWJ3ngGYS5YvQR0UWUkfRegMdgpVPBHzn4UKnSeZ2KY+vjH4oxDrlcPbaLhG5BR/SQeCoLQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199015)(83380400001)(2616005)(6512007)(186003)(53546011)(6506007)(31696002)(86362001)(38070700005)(36756003)(38100700002)(122000001)(41300700001)(4326008)(8676002)(7416002)(5660300002)(2906002)(8936002)(6486002)(316002)(66556008)(478600001)(71200400001)(31686004)(76116006)(66946007)(66476007)(6916009)(54906003)(66446008)(91956017)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dlVCYUowZG1vUmw2aDZBTTNaZ2JNOXJaTHJPVUVvRENzWVFpL1J3UkdCU05R?=
 =?utf-8?B?eHlaZ2JJVGVFR2JkUFB0cXJhdFFNR0lYNUEwczA2Ty9ZZ3Y3eTBmTTJ6dkpo?=
 =?utf-8?B?SE5ZT2x6ZUhJdmhqcGpPOFJaemk5c2F2b2YwM0VPb0h3YWpwUHFPL0NKWUZ4?=
 =?utf-8?B?YjJhYnBZa0V2bUtIVDFpenFkUU5xcHpaUWVRQkJNcWRNcHFZbloxWXNXUFBD?=
 =?utf-8?B?eU5YUmVYVnZ1a0UzckxJdFViemtxbEpxZ3cvNHBnSU5wVGd3VXNhaXVuVWF3?=
 =?utf-8?B?ZHJOOC8zbnZKSGtUVUZlSmpET3pVc3FsanpBRE9XTjlrQTJjZnI0YlV6eEsr?=
 =?utf-8?B?QzBScmNwcytlK1AwWFJOcEowbzBFOG9VNExMSk9JYzdtK2JzV2swSkhnVzlm?=
 =?utf-8?B?TnUvdEorRnlEREI2N3FHOUNlQS9Tdk4rZ3ZMVWRXVVR3cUNXN1lUZTl1RXgx?=
 =?utf-8?B?dkw4NVpOYSt1ZWxoSTJRaTZDWWVDdUcwR0krWERQRjFUbjVubUsxZVE0NXJM?=
 =?utf-8?B?aWhIcktyS0FsVjhiVnNmZ3VqN0xzNlRsd1h5Q0pGQ2RQWE1keUN0NkJ1Zm5j?=
 =?utf-8?B?WXpKZnU4YmswQlR5VHNXMTNFeFpLWXhBTTg2Z3AxeEpsUFdKZ1NYNXRqWDVC?=
 =?utf-8?B?N3ZBaDJCQzJ6YTlXcWl5NlRtWCtnaElMSTdFOXBncW5KM0lPMi9NVlhBeVA1?=
 =?utf-8?B?aEd0djlwMUxkcWtzTkRxNGpXa0NoNXlzQjVNV2JidytsZGNHM2JyeFc4d3Va?=
 =?utf-8?B?QzV0VWlMMVFNcC9qSHBSbTJRTTZuSW5DWndmK1JIbjZHZTB1Y1gxMG1zcERP?=
 =?utf-8?B?R0xUK2VNM1NpM0pTaVpjMlRXNUJ2OS9KSDNhZExDdjYxZ0V1Vi9Zd092K0Uz?=
 =?utf-8?B?cm5KUzl0WG1sUHpqTjFVcFMyVEUyMFZ2S1JRY0xWdmJRSUVHUFdDWm9DWHRl?=
 =?utf-8?B?RDYvYjdJTHJGSmE2alc1WjJCZm9ndkk2U1RvZlB6N040WUU2cDVnekNDVDhE?=
 =?utf-8?B?ZFljVkVvOWRXWDJva1NKVTB6cmpOa2FqQjRIcTRXMmhUTzU5ckhYOTYrYUFW?=
 =?utf-8?B?L3IwR2V6My84ZFp1UGNieFBLb3FHN0xCTmJXNUtzMVRyRUJQMXBkOWFEVnNY?=
 =?utf-8?B?eTVmbXJxM2hhU0wrRlVJNGdmcXc3dEtoV05kblhXeWxnM3FEU3FBb1VRWGNE?=
 =?utf-8?B?ZXZlZEFGYWx3Uk1wa3Vja01RTjJ2S0NXUGxHU1ZES0JlMitXMG5QNDlKNVNh?=
 =?utf-8?B?RVB2dy9veHU0TmtSQ1JYSnRKQm1VdDJta2FLUEhUZkl2aHBGNzA4YmZpWU10?=
 =?utf-8?B?ZVBraUJHM3VuOVNnN0E1QmJTT2lLNW9TREhpNk1FdmtOQ3F0OUF4TDhnYmEv?=
 =?utf-8?B?Rm5CbytrcWc1YjVSUnREa2RQNCtjbHo4dUYxNG90U0JRU2NWRUkzUFNFVmFh?=
 =?utf-8?B?a0wvV3RYOVplMmlpOWwzQnZaM25lRlRLY3p6YmhrbHBudFc4QTdHa3hPTk5n?=
 =?utf-8?B?UEFLN2hsZTVSY2RzSVc3a01NSVZxSWk4cXhOYzgvNG9XMHJ2emdwOHlNcDg1?=
 =?utf-8?B?anl6VHpVOFBQSEx6R2tjL0sxY3lGMkdYQmFNd0tUOGNkRWVFYzh3b0JwWDVo?=
 =?utf-8?B?Z2ltcmhWQVhES2V2L1V2aE0wc2ttYmVpZXFTSXNDbHZwZXRldWV5RDgvd1dm?=
 =?utf-8?B?bk1xMS9MMkJsMDZsSHU2My9wOE0zc2NqaUFRZDNuaWRGdEl6cmV6c2pmcDhB?=
 =?utf-8?B?UGg4eEdLN2RIQ0lPdmZsNUpsNVpsKzZKNDNRb3YrZm5VWU5paTdhTnNCQ1VB?=
 =?utf-8?B?NkVmU3NmWnlXMzYyTGhnL1RhaWQvK2YzNGExVkZSUVVWMWNLRzVHam9OWGxh?=
 =?utf-8?B?MUxjRDlKb2tVSmRZOU52NmlBOUE0R3l5RjhFMGFkcjN3djRFekl5eG95YVVP?=
 =?utf-8?B?TGFsSWl1SGQ5VEtST1NQdEpTSFphUXhEMWhXYzZCanJJVlRic28yT2pCb0pa?=
 =?utf-8?B?eXo4SENPdTcxdXdQWDBYSUdqaEVYeEltR1pTbjUrYkVmWnEzSklYYXV1UHRl?=
 =?utf-8?B?RkZhSjN2alZZQ1ZyTG9pZ3oxTE1NOEJtbE9PZnVwdE5aYW54dmJLcEdhOUJi?=
 =?utf-8?B?TmZ6NE5mYUZxRGJmemNlbUFkZHBTMXlyS1QrZ216WEwwZDkySmRyK1BGR1Yx?=
 =?utf-8?Q?klJeavScJwFmI5T8kyF7o0fHZjb2UpjKDXATpYMHhYnB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95395326796F5D4DA48DF4E946C6D60E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0429b47-d8f3-4545-e711-08daedeb2625
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 00:32:23.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITj9AN+1ZxYA8fxPOIXTyrfWhgWSKn7cLsLXfC+M2nK32etch2yR6qV50ii0sXbn9kA4TkxiO4TvEcA2i4Bo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_163229_762094_1C2F3662 
X-CRM114-Status: GOOD (  20.83  )
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

T24gMS8zLzIzIDAyOjAzLCBUYWVoZWUgWW9vIHdyb3RlOg0KPiBudm1lIHRhcmdldCBuYW1lc3Bh
Y2UgaXMgZW5hYmxlZCBvciBkaXNhYmxlZCBieSBudm1ldF9uc19lbmFibGUoKSBvcg0KPiBudm1l
dF9uc19kaXNhYmxlKCkuDQo+IFRoZSBzdWJzeXMtPmxvY2sgaXMgdXNlZCB0byBkaXNhbGxvdyB0
byB1c2UgbmFtZXNwYWNlIGRhdGEgd2hpbGUNCj4gbnZtZXRfbnNfZW5hYmxlKCkgb3IgbnZtZXRf
bnNfZGlzYWJsZSgpIGFyZSB3b3JraW5nLg0KPiBUaGUgbnMtPmVuYWJsZWQgYm9vbGVhbiB2YXJp
YWJsZSBwcmV2ZW50cyB1c2luZyBuYW1lc3BhY2UgZGF0YSBpbiB3cm9uZw0KPiBzdGF0ZSBzdWNo
IGFzIHVuaW5pdGlhbGl6ZWQgc3RhdGUuDQo+IA0KPiBudm1ldF9uc19kaXNhYmxlKCkgYWNxdWly
ZXMgbnMtPmxvY2sgYW5kIHNldCBucy0+ZW5hYmxlZCBmYWxzZS4NCj4gVGhlbiwgaXQgcmVsZWFz
ZXMgbnMtPmxvY2sgZm9yIGEgd2hpbGUgdG8gd2FpdCBucy0+ZGlzYWJsZV9kb25lIGNvbXBsZXRp
b24uDQo+IEF0IHRoaXMgcG9pbnQsIG52bWV0X25zX2VuYWJsZSgpIGNhbiBiZSB3b3JrZWQgY29u
Y3VycmVudGx5IGFuZCBpdCBjYWxscw0KPiBwZXJjcHVfcmVmX2luaXQoKS4NCj4gU28sIG5zLT5k
aXNhYmxlX2RvbmUgd2lsbCBuZXZlciBiZSBjb21wbGV0ZWQuDQo+IFRoZXJlZm9yZSBoYW5nIHdv
dWxkIG9jY3VyIGF0IHRoaXMgcG9pbnQuDQo+IA0KPiAgICAgQ1BVMCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBDUFUxDQo+ICAgICBudm1ldF9uc19kaXNhYmxlKCk7DQo+ICAg
ICBtdXRleF9sb2NrKCZzdWJzeXMtPmxvY2spOyAgICAgICAgICAgICAgIG52bWV0X25zX2VuYWJs
ZSgpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRl
eF9sb2NrKCZzdWJzeXMtPmxvY2spOw0KPiAgICAgbnMtPmVuYWJsZWQgPSBmYWxzZTsNCj4gICAg
IG11dGV4X3VubG9jaygmc3Vic3lzLT5sb2NrKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGVyY3B1X3JlZl9pbml0KCk7DQo+ICAgICB3YWl0X2Zvcl9j
b21wbGV0aW9uKCZucy0+ZGlzYWJsZV9kb25lKTsgIDwtLSBpbmZpbml0ZSB3YWl0DQo+IA0KPiAg
ICAgbXV0ZXhfbG9jaygmc3Vic3lzLT5sb2NrKTsNCj4gICAgIG11dGV4X3VubG9jaygmc3Vic3lz
LT5sb2NrKTsNCj4gDQo+IElORk86IHRhc2sgYmFzaDo5MjYgYmxvY2tlZCBmb3IgbW9yZSB0aGFu
IDMwIHNlY29uZHMuDQo+ICAgICAgICBUYWludGVkOiBHICAgICAgICBXICAgICAgICAgIDYuMS4w
KyAjMTcNCj4gImVjaG8gMCA+IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2Vj
cyIgZGlzYWJsZXMgdGhpcyBtZXNzYWdlLg0KPiB0YXNrOmJhc2ggICAgICAgICAgICBzdGF0ZTpE
IHN0YWNrOjI3MjAwIHBpZDo5MjYgICBwcGlkOjkxMQ0KPiBmbGFnczoweDAwMDA0MDAwDQo+IENh
bGwgVHJhY2U6DQo+ICAgPFRBU0s+DQo+ICAgX19zY2hlZHVsZSsweGFmYy8weDI5MzANCj4gICA/
IGlvX3NjaGVkdWxlX3RpbWVvdXQrMHgxNjAvMHgxNjANCj4gICA/IF9yYXdfc3Bpbl91bmxvY2tf
aXJxKzB4MjQvMHg1MA0KPiAgID8gX193YWl0X2Zvcl9jb21tb24rMHgzOWIvMHg1YzANCj4gICA/
IHVzbGVlcF9yYW5nZV9zdGF0ZSsweDE5MC8weDE5MA0KPiAgIHNjaGVkdWxlKzB4MTMwLzB4MjMw
DQo+ICAgc2NoZWR1bGVfdGltZW91dCsweDE4YS8weDI0MA0KPiAgID8gdXNsZWVwX3JhbmdlX3N0
YXRlKzB4MTkwLzB4MTkwDQo+ICAgPyByY3VfcmVhZF9sb2NrX3NjaGVkX2hlbGQrMHgxMi8weDgw
DQo+ICAgPyBsb2NrX2Rvd25ncmFkZSsweDcwMC8weDcwMA0KPiAgID8gZG9fcmF3X3NwaW5fdHJ5
bG9jaysweGI1LzB4MTgwDQo+ICAgPyBsb2NrX2NvbnRlbmRlZCsweGRmMC8weGRmMA0KPiAgID8g
X3Jhd19zcGluX3VubG9ja19pcnErMHgyNC8weDUwDQo+ICAgPyB0cmFjZV9oYXJkaXJxc19vbisw
eDNjLzB4MTkwDQo+ICAgX193YWl0X2Zvcl9jb21tb24rMHgxY2EvMHg1YzANCj4gICA/IHVzbGVl
cF9yYW5nZV9zdGF0ZSsweDE5MC8weDE5MA0KPiAgID8gYml0X3dhaXRfaW8rMHhmMC8weGYwDQo+
ICAgPyBfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHg1OS8weDcwDQo+ICAgbnZtZXRfbnNf
ZGlzYWJsZSsweDI4OC8weDQ5MA0KPiAgID8gbnZtZXRfbnNfZW5hYmxlKzB4OTcwLzB4OTcwDQo+
ICAgPyBsb2NrZGVwX2hhcmRpcnFzX29uX3ByZXBhcmUrMHg0MTAvMHg0MTANCj4gICA/IHJjdV9y
ZWFkX2xvY2tfc2NoZWRfaGVsZCsweDEyLzB4ODANCj4gICA/IGNvbmZpZ2ZzX3dyaXRlX2l0ZXIr
MHgxZGYvMHg0ODANCj4gICA/IG52bWV0X25zX3JldmFsaWRhdGVfc2l6ZV9zdG9yZSsweDIyMC8w
eDIyMA0KPiAgIG52bWV0X25zX2VuYWJsZV9zdG9yZSsweDg1LzB4ZTANCj4gWyAuLi4gXQ0KPiAN
Cj4gRml4ZXM6IGEwN2I0OTcwZjQ2NCAoIm52bWV0OiBhZGQgYSBnZW5lcmljIE5WTWUgdGFyZ2V0
IikNCj4gU2lnbmVkLW9mZi1ieTogVGFlaGVlIFlvbyA8YXA0MjAwNzNAZ21haWwuY29tPg0KDQpb
Li4uXQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmggYi9kcml2
ZXJzL252bWUvdGFyZ2V0L252bWV0LmgNCj4gaW5kZXggODliZWRmY2Q5NzRjLi5lNjA5Nzg3NTc3
YzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaA0KPiArKysgYi9k
cml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgNCj4gQEAgLTU2LDYgKzU2LDEyIEBADQo+ICAgI2Rl
ZmluZSBJUE9fSUFUVFJfQ09OTkVDVF9TUUUoeCkJXA0KPiAgIAkoY3B1X3RvX2xlMzIob2Zmc2V0
b2Yoc3RydWN0IG52bWZfY29ubmVjdF9jb21tYW5kLCB4KSkpDQo+ICAgDQo+ICtlbnVtIG52bWV0
X25zX3N0YXRlIHsNCj4gKwlOVk1FVF9OU19FTkFCTEVELA0KPiArCU5WTUVUX05TX0RJU0FCTElO
RywNCj4gKwlOVk1FVF9OU19ESVNBQkxFRA0KPiArfTsNCj4gKw0KDQpUaGUgcGF0Y2ggbG9va3Mg
Z29vZCB0byBtZSwgYnV0IEknbSB3b25kZXJpbmcgaWYgdGhlcmUgaXMgYSB3YXkNCndlIGNhbiBk
byB0aGlzIHdpdGhvdXQgYWRkaW5nIG5ldyBlbmFibGUgZGlzYWJsZSBzdGF0ZXMgPw0KDQotY2sN
Cg0K

