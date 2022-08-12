Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544C4C00140
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWdn4FEwc7ZpnZXnFMqWTe3BoDqoBdqc7oIc14qXzMo=; b=Yexn2I4iayxTsM2qaiGiQISRhu
	CHAojQZzgsljwllDKA8BqNwMzgnBKuh7rXwZcJkI4+JoxKRxPpNUsWWCihhldz4i4Lfar+x9F8dkL
	EzATa6DMG858fU0JSwSzv3AOizsDmgmxG9tZzOYK32jskiuti5ruz1L8577Mpjt8A90EZh6NmGfbp
	RR/YS0kCdcBnqkPicmBfqOVsJFxG6z8tkKJ0ZVpmtW/SHGSbmP8CzZv8U45+AZCOC9LP4IWfgeoCq
	yiGNaVwiKIP3A3spQX6bLNkRPTa6OEMF1WfBDQ8e6YgMMWvg+jObYXoNDKIwq2tp+rgG77zPSuO1N
	3lJXKlIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMYgl-00Bf9M-Fn; Fri, 12 Aug 2022 17:43:15 +0000
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMYgi-00Bf5m-Nr
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 17:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpBDFWYatEQu4Dm87egId1baMLujgXwB7qgSWueK8qfK3l5aBlltdOuiDirOM1Qt93h14WTjUcPSenMx+NCszEDzAlXuHDx9Mj3dPalnAyAerKrUT9E++eU8rMEqi1mlJ/mDsWLtPdxjdM73CkyrBv3Ya4/LqM/YBLMzwROQuhM3XS7i6RqG0f+Nmt5iFnLeK8pP0VeJUhW4KcCENvhseNhL2zH1Pc61rh9526dPGZG6UKF4Guxb+AIJTzWVCNAFxg7lGLe6oTzfoBXof3UKQ23QgkTTGtdBtqAVGBoUf7lqZbjRk5XE25w8rYx4I2SZmNdkL4EbSSOXGm08zbX/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWdn4FEwc7ZpnZXnFMqWTe3BoDqoBdqc7oIc14qXzMo=;
 b=JR972+/lHwCDgvRrhIaMXMcfETzL90JvZ2gTJRAr/f+1GsTUFfT0SblQ5ikKImhUXq+J2Wk27I6Xqr2a+oVqCVlSMRUOGUAz9VgRbZyzRmYKJAGdzyVzqyzuU7jLCAAC9KnVTKqcqMUaxwmlyldOh/A+q+Xpq5GMq4+Ikv6K+YlqQubGKMEGi+33ZGDjMjd+/Q4YeMa87PblXTqnsE8Dlvm9/SMapqOQr/5OuMWg1z6hu4anNoEYYrNi+FZq3owwaiCYu8W0PRU+LH0yz3duLfnCzQKbPAQYHb1dZ9cZ9XBHzfd0mPr5XiTb73KEqAYmkpCKCWZ38KFOiwpGaz184w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWdn4FEwc7ZpnZXnFMqWTe3BoDqoBdqc7oIc14qXzMo=;
 b=dPqy0qh8i4ceVGoyGcJlJrP7M6WZ/bA2/vRB2uTIK/0K42OrHguUf9Q3NNVxUzYjRF0eM8lCgE5aO8fHBbuUiTZEmm/A5bubGGtzgDrrLqCeSlV0p2lxAI+ePqvAAwIeIXghCWTbc7pYXyaIzK6cHCxPOTGTi5Y79r8WVcp6msHLNUHe9bR2IpSbWH6mcvqZBPFatJOkoWXuvEZkkL+q42clykPyXOUBBY//8hGecjv24yZB2xMxtvS9PJT2kwksWxRei36ytrmyXjqSxg+dhhECidFasMPD1CGx/Dx6SkwvV3S3mtMNWFFMMmz0XGcrcMlosESwcC5Cv79jcr3RlA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Fri, 12 Aug
 2022 17:43:06 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5482.016; Fri, 12 Aug 2022
 17:43:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jackie Liu <liu.yun@linux.dev>
CC: "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/2] nvmet-auth: clean up with done_kfree
Thread-Topic: [PATCH 1/2] nvmet-auth: clean up with done_kfree
Thread-Index: AQHYrflunUJWRUbf4EGKB3vwVcVOSq2rigIA
Date: Fri, 12 Aug 2022 17:43:06 +0000
Message-ID: <8f2aaedc-6337-32f4-392c-8bb4d6025afc@nvidia.com>
References: <20220812031231.3386953-1-liu.yun@linux.dev>
In-Reply-To: <20220812031231.3386953-1-liu.yun@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77edc7b2-a3f0-42f5-02be-08da7c8a1d65
x-ms-traffictypediagnostic: MN0PR12MB6222:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  k5ZiLaUHhwZOk2CGMYnRKEkTCMKNvAnXraNIG0A3shV4t79M8+emb8Tey+spX5KTBOXcz17tuiDd7CbbjHzUOnZirs7tZdoiB2wDztgf+/5ZwucQaw+Pr5Nr3ItWl/heyoIQXJIKEfzqrZmosX5r+y8Q7/kCDzPvA/1RxncjyarUUjwqHsCcsRUA+zrrxa4CaFIMQVZP3jg2ozq97vuZuZNBOQrqt2uIvAn5K+oAohsdQg5BXpLe3nSjwiY6V2q8GX1kQST5OqanPO4FNhRhFryVfCM8NlbK5lD7vEWGlfjBGPC+b0NAc8vRv0JxV4YtZUCp7EgVS1W3yipyShUXs3rfnpe2f2R6VJC53AwwCU0OeUqThrl0wL7gHEueBxZw7GUhRGAiupAgFSGtCyk78nPO82hRWfVH0Z+z5tZdpPkdToXf90UpaB/qDc+C2YjTXMKaea7K+tNj3jcTLlki2PPQuRTACQr3UdHeXecSDkgsO09SytXlgej09WTEyF6SimNu9Ot5zBQB9UsNAEblXoDqSEz80oruGrQnq0P4cHro52cUNHa/gkDEKO941nDLTSguWV0grhXkxLzteurxuRc6vXNSxjzINnvORberB590/t/VprF6HkMRUBCxcje07mrvUXgCzfckPaGj4qi1pHgLpWsgcZySfFQoF0vXQkqX3FN0wXKq1A2dIqtgBOcBh3xznuITHau7zD++R4npzlnLaMaLLrfNw2TStUivxAvql/0rysPLIZfl3EQHu6sdXDg2LWFVEIl9GzcKFE8ihMthHhvWh9oXU2rduy2+zzCS2hVMT844Uh7WlqY5QIcsLUbv7XnLO3lKF3AY1oO6Qze6isdA7d5qBFckviLG54l3eiMDCI49cZS0/oQrVBl+
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(53546011)(71200400001)(478600001)(6506007)(122000001)(107886003)(316002)(6916009)(31686004)(36756003)(6512007)(54906003)(186003)(38100700002)(2616005)(41300700001)(6486002)(4326008)(91956017)(76116006)(66446008)(64756008)(66476007)(66946007)(5660300002)(8676002)(8936002)(2906002)(31696002)(66556008)(86362001)(38070700005)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dnZUTS9oRDFDaTNuTlBrSnlnbHpoSndtQnNXSkR2dlNVNjlvV2VBMXU1ZGtX?=
 =?utf-8?B?cE1TWXE2SE5KNGg0THo1YnFQcWhGWnVHZzRKTzhOclZSQzVLYkJKeng0dWdt?=
 =?utf-8?B?NWNVUVhsVk1OTTZlOTc2WWlqZi9WcEY5anNtTVVHcGUxVnpTNEV5WUNBV1NC?=
 =?utf-8?B?TjBxK3RhN1ZKV0t3R00yZ0NSTXpTbDV0UzlYNzdKa0pkeWsxdTl2L2ZlN0tY?=
 =?utf-8?B?MjQxMFZ5RG1hVDlwSGpicms0L0ZCUTBDRHVIUVZWdm0xU0ZEQlBZMGVqMFJx?=
 =?utf-8?B?UHZCbnBpS3kwcmhKMS9lUk5DcmJnK241UnZLTGI3YldLcW1tZWJZdXJ3TjZE?=
 =?utf-8?B?MlBQc0F4SEljQmxPejZvTlU4NjlrKzRGdlltZk5LVXhOQUtrRHFxdzI5bDBE?=
 =?utf-8?B?dEZ3bU51RUdHa2lqNThyZ0txQVZDdXBtcDEwUGhQL2tYYVh1S2RZY1Rlc2Fn?=
 =?utf-8?B?M1RQMEgxT3ZhUmVTNUwzUmpuT01VS3dYMC9PYitIbmNqTnU5UmtEeTd6K0NL?=
 =?utf-8?B?N0VlQWlUNldkclNvM1hoUGhaZ00rZEpnYzFBbUx2ZGxoM1Y5OVg5UEtYWFZu?=
 =?utf-8?B?a3NzNUp3WlNRMFdrc3B5b1hqNU54SkJyWVJ6TmkwMEl6K1dGKzdRM0dLU2VL?=
 =?utf-8?B?ODBOMncvWThzRklUS3h2NFhrcFVBUG1LWUE0SFltdW1LKzA0QUw2RThvWUcy?=
 =?utf-8?B?QWFVd1ljRnRDcm51a09uSzNhQ25WaVVoSnZucjIwUVhiS1B1Rm5hM0lLaEJ0?=
 =?utf-8?B?cmIrcGxVSzFOWFJkV1Uzb0ZiRlJFdURhOHVkVVBHemZpaGgrdjZpZTU2VkQz?=
 =?utf-8?B?OVRzVU9DczV1WmN1MkpnMkprVVYrcC8rWVVVcjkyY3hYdHNCSjFPbkxibVFD?=
 =?utf-8?B?MzZ1UnBETVdvZ2w5bXMrR1V1RkdNUGthcXNtUUM0S1VTYzE2c2xsZnlVOGdi?=
 =?utf-8?B?S0hDRWdRTWNMK1R4UklmSXc0Y1B2WVpuR2tScXdTT0x6WnQ5VStyUzZjZ2F3?=
 =?utf-8?B?MjhGYVFmQXFSVUdPQ2pCZnVOZFZuTUdWQlR6U0h0Rmoza1VJNFVnU0djaUp5?=
 =?utf-8?B?bDFPRVJOQ0dqcUVQUU4yQlJhcGFTMlFiTm0wZkdZd2ZTQmYrZkZ5VEFIb3ZO?=
 =?utf-8?B?ZnF1dk9RT2dkTUd3WWYrL0VObUxvTzMvcHcySnV0UnFVWkt4Nm1tYUlhMzdL?=
 =?utf-8?B?Zy9Qalo5c3AvYUZHa2VrZFh4WVlzREJ0TkVoN1VSNmtQQ3Zaa1hTVHFJelJL?=
 =?utf-8?B?bExLNzZxSTIyYzlBRVNFSFdsQ2pUZnVER2J4cWVvTDJmTmZHd3JyYTZyUTZi?=
 =?utf-8?B?Z253ZThMN3F2ZHNvSlNmOS9vUCtCM0dFSnkrN0k4R0VSR0RqTGtyTittbmNr?=
 =?utf-8?B?TG5iUkkrY0xhZG9SNUpPR1UySWUzOERLeStDbGQyUzJ5dmZaays1c2RvNWpU?=
 =?utf-8?B?Vk5xOXB6aHFLOTJhSkNUZUdIdVZHek1vak5zM1duWmVPdk9PcHR2ZXFJUGRl?=
 =?utf-8?B?UnVuemZVRFpjNEM0OVYvb1lZQ0kyMHc2UFpPbkROVnljMy9HMHgvRGd4Vi9t?=
 =?utf-8?B?TGZncTlZbTFLdys2L29JenhIaFo3aDVvaEJLMFBnWUFnWG1RZHZEalFrdDBl?=
 =?utf-8?B?cXU4MkJIUmhrb0VvWlkvU0RGdTMvQ1NvU3ZlbkpIcXpHZ0JkRjZVcjRJVllR?=
 =?utf-8?B?QnJXak5wb2pzWFZ0d1dRdUQ0dUNoZzhKdmJYUENiUk00QWpxUGYxbXZ0MGZV?=
 =?utf-8?B?MXJINGFrRXJTQ1JLbWpZUVZJYVM1QmVVdTd3ZEI5MGNjRTFwdEtiYm5qUHBQ?=
 =?utf-8?B?VVFUeHdFeU9NemhOeU10ekVNNm1UUElTNGliSHpjdjhENVpUSDE2RVloNzgz?=
 =?utf-8?B?a0FNcC9wbFdzL01tTE1vWm1lVXhiUFMwNUhzdWQ5a0gvQlEwd3JJRHpmVUtj?=
 =?utf-8?B?cVh1RGtGN2NBQ1lWS0QyQmgvR1RLZWtzZHBrTDhZaGU1YU5DTTFoeDY1blF0?=
 =?utf-8?B?TGJXL2hXZkFreXkxUmpPME9YYUJST1IvS2RjZXV6SGltQVB4R0Q3UzNsTjJr?=
 =?utf-8?B?T2pBYkkrYmtEVDlMN1NNOWh5dVlYeWNlZWx3dnQxUWFjZU5KaHA0MHlLc0cv?=
 =?utf-8?B?UG1pQXovV2o1L1diTUJTZkNxUFNOZzdTYm1Pdk9GVXFCcWcwTU5JWUYwMm1C?=
 =?utf-8?Q?q4HLHPIcCqWJMhMdOB7qvRjMdgnCSstBOiHS7Nl+wQEB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49F35A2010EB294497515ECBE0ACD600@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77edc7b2-a3f0-42f5-02be-08da7c8a1d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 17:43:06.6524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHVNP5o0fuCkhUndB554hjIgy56USFbMAWnJ2sR7VKJrRS5+Jg/2VsT20CBlTyUksPOgWqHVd1Y2gaLVg0MRkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_104312_826214_64057DE3 
X-CRM114-Status: UNSURE (   8.47  )
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

T24gOC8xMS8yMiAyMDoxMiwgSmFja2llIExpdSB3cm90ZToNCj4gRnJvbTogSmFja2llIExpdSA8
bGl1eXVuMDFAa3lsaW5vcy5jbj4NCj4gDQo+IEp1bXAgZGlyZWN0bHkgdG8gZG9uZV9rZnJlZSB0
byByZWxlYXNlIGQsIHdoaWNoIGlzIGNvbnNpc3RlbnQgd2l0aCB0aGUNCj4gY29kZSBzdHlsZSBi
ZWhpbmQuDQo+IA0KPiBSZXBvcnRlZC1ieTogR2VuamlhbiBaaGFuZyA8emhhbmdnZW5qaWFuQGt5
bGlub3MuY24+DQo+IFNpZ25lZC1vZmYtYnk6IEphY2tpZSBMaXUgPGxpdXl1bjAxQGt5bGlub3Mu
Y24+DQoNCmRvbmVfa2ZyZWUgbGFiZWwgYWxyZWFkeSBoYXMgYSBrZnJlZSBjYWxsLg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K

