Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85741C54E5D
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Mar 2024 03:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvrDzXzBmxElYQjVDl3XF7WnWKrXYuuGxbmxc/0aUiU=; b=cJdOP/qZe81u+enzoUu03SHUPe
	geUmrOEFHr7nPIsRfsaVgtxt0YoRuixuD+q7/fU7k9U5L9/oCfXw+sDg0JOx6KPN7yEqCnccfV+Zs
	FiGh1PN0zaJoiBNMqZeco0Bc67JzfB7+k1yy+ujAtWl5fwONXe+Xtm11qR/Iw2MdvbHxbVA3mHiVl
	XIYWH7SYmrycrMZ0cI3BRad2oljmDVpqujXEgdthhaIDs8SFHNzsQBns861jVS8Ly0pmTVh0JS7Uv
	gM+8qjIaFRXOKrHzTMFG+1fN4fiMF+U6IPxGcsCW6+TrfjsU59cCEiH3hfmWwl+yT9ADChq70yH/W
	SAqnUSRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmPwy-0000000B3A5-44CU;
	Tue, 19 Mar 2024 03:15:40 +0000
Received: from mail-bn8nam04on20700.outbound.protection.outlook.com ([2a01:111:f403:2408::700] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmPwu-0000000B392-2ZbT
	for linux-nvme@lists.infradead.org;
	Tue, 19 Mar 2024 03:15:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSf1A+oveMJKc8E6dm6hvF/d3DxuXUuzRVEgDT/ROXt9SRTO789svitflmwlmGSiVkGS4iYD5fihEKRlYj2rTqJNYRfBwyi+ZercJ8OA1DWSDcWvMSFC9/2y7r6+9IVo2Dc6abyXyRnfMylaZve2we36lPCmiwA79bN9DF2yr5tO4Etcga4fBQxcA6uCCYwQKV2/ZrqLcbPkXFmjSFUVl7ora3Ommqs0AIJWN2CQRnDz/nHgKfXociGzuV7seom4zKlnk+7HTmIVFoXNb/QcjFB2DWg5cZUhLLx9N7t4zQOJ2n49jLHw8BfweLijc/YUbStwmXtX5yiGnBAk1ZYulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvrDzXzBmxElYQjVDl3XF7WnWKrXYuuGxbmxc/0aUiU=;
 b=Nx5W+VKdIMLhe0eyw1lRtDQIXdJ7GoSv/hh9+J5qYLYZUtyi9YJ5Fu0FlPAHI3RXJ/EdS0lBv5b2yj5LLy0iOGZnqK9K/Tr26phhk79n5t69hW01uNWeN1wHbkKXHixSoldmNlLRX1+7+I/a1c4sxLl6fDkFfnmXROj2PsarF1NZzbEq743BL+e5U04EfStyNbrNcfCJ5U3z14HOQbY+l6zzpW321SK5Bz0PS9FTxzI9ScSvs47gUY1a7Z0Ln9S35E26fMkYmdyLUCxLKylUmBQFk7Za9jfPYBEgCsFjxH9vc2M5hfj/QrwFGJ53b/5uIX1TdJu5n5sKlBfILgxP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvrDzXzBmxElYQjVDl3XF7WnWKrXYuuGxbmxc/0aUiU=;
 b=SGkThMtftiwyGOM2JF7idBH9u0CPqhUVfELvX3RF+NCB2UGnFU2odNJyf0NsxWaYfsBqwBiknAcLufyGdVyN97aBQHjk7jm7t45iO8iZyepYWjcSBe474E+kxlBRqM1KXyxrOiwlsdi+rBgkv/lOtL1kYiv2UIgZqIAbmsJDdMApp29YSadCLpQsTGTJDobEax2BB7A2daDrSw3OwxrWa0LSpbEdl+7XLGLG73X1uURZFI1l7MEwAAusYeSj24XJyTVkWysZsmgWOYSlr6zLonWUPvTnKB58TBu+85t2v5u3G6IwCOZfOUx1CHDSOhaw42BwEy40KjIo52V+6lCvSg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 02:59:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 02:59:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, Sagi Grimberg <sagi@grimberg.me>
CC: "hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Thread-Topic: [PATCH v7 1/1] nvmet: support reservation feature
Thread-Index: AQHaVLbjkz0QMzGO+UKZIHEcqOuwNLEfFBgAgAAcSICAABCaAIAABVMAgAzzpYCAAY7vgIAADqcAgATLIQCAAj1AAIAAZ4YAgABoGoCAACIJAIAACzsAgADhQACAB+twgA==
Date: Tue, 19 Mar 2024 02:59:30 +0000
Message-ID: <cea98ed9-6b65-4475-8497-62f1ca9f81a3@nvidia.com>
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
 <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
 <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
 <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
 <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
 <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
 <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
 <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me>
 <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com>
In-Reply-To: <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB9251:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x0+p4l/0ZGRaSplv4PWig5nHkXnna3nYDt8pDNscEXSKpOe0ydF30PmO+Oj0y+h1i+lSHWgxaVRra5plwdFwTUT3HrJOhOdfOstqMUIl+XdgvI4vASiDaSC7yoLhhaSHwLK9q4L79t+meGoWKEsjIwVF6WMp7JO2a9Z7a/JlHZsQpYwJ3oOOegTn+afEu3bUbBYw2mZYLFXA6NqQNrXyfcsci4srUCYCIhOrE9EUJaIWWJL9CJoARP2zoR2HBHs9m4FPzwB/6zGcfl2eLJkfRrelNcNsU9/rzP7aiw2fQ7hDmY7Ua6wnP5xIhcoEeSpx39GRugcKe9jMzCP+0yzPJjJj4INRUBxlpQhocNXxPPQu1lwpOsMvxX4lAE7cwc1LOFSH2kigI5baMYv672KBO88ZOR95FlDSw+qobNFbE5PKh6un0I6XbDdBOx87M7aR7Cx0O3Larxy39I0x5jk1zve5ZAxDsfTNJl5FIVmbVkoK5CXMXB5homGteiustgLndYEeNDFw0ACpLJuAh1DQczu1he1iJvwTbbpSi+xx9gL0q/JaCnQjJWR7UyyD9D2x5+jNoecqcC51JzvWb8G1dxzSZjbIm7Y73ij7eWIThR+87WqMk7aJzZN1fj2/rfHMH7/NbfW1pmzC+NgchEF04jUioUTVq3YezeiJnRhD0zs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGhxVjcwczZxcCs2WDRONHI4bmxCVjF1VGVGTVkvN3NzeDJGcUJienlyRTdV?=
 =?utf-8?B?UHY4VHhPWFQvMEFxdVREaXZqRmw5djRMSmZCQWpBUjRFekZxN0dHTUM1ci9I?=
 =?utf-8?B?UHJFdEk0c2IxV09MNWlIV0EyUUIxRDg2OFF6U1JZdlF4cUl4a1AwOGxISEUz?=
 =?utf-8?B?VDRJWXV5K3ZmWENDSUl0Ky9hU3ptMjlkQThCSzg5aVcwWTFXUHFQMkloeHJB?=
 =?utf-8?B?c21iTFB2bUswNHNGTTZrQm9IUk5qWlhHcUloR3ppUG9hcTlxYXJwSkZlcVpj?=
 =?utf-8?B?cmZTc0RqamR1RGdid3BlMURPOXhZdlM4a3FRbGQwUXNhNzdTb1p3MExIYi8r?=
 =?utf-8?B?L0s1RDBIbFVkYUxVckQxTzJid3FUNEgrcDEwd3dCUzM1R056Y0NhVlNDemEw?=
 =?utf-8?B?bmU2eDdjVElBNHZoSGxGb3BZbk5lTDRLN3BZVjJMODZobDhHbkdoUzR0RDNJ?=
 =?utf-8?B?MFVyRVU0RktOOHJlZ1dDQXZYcThWSXBmOU1oZkJxa3FDQXpEMTNqOGE3R0Yz?=
 =?utf-8?B?Y1l1cE5DdG9CemV1Zys2WDhXVm1ydm9QTkY1dUM4QkpyZHNsc2tyeVhVSHRz?=
 =?utf-8?B?VEhQc2kvbUxQdS8vYjBsOU0yeG0zaFBuMlJ3bllwNG43eHlDUDgzaDBiUDBu?=
 =?utf-8?B?dHV6ZHhwQUFXNVpvbFNqNm9hQVE5V1hCQ2haMUtBVE1pdFBnMklHOEw3Ny9C?=
 =?utf-8?B?VzNiZkhjbUM0amdKMFZhaWdENDJLd09uZFFHTnlTQ2JYb1owaFg2ZlBuQldj?=
 =?utf-8?B?cDNFUjFDSjhlSjc3cHpub3hnWlh1RWRQUVFvVEhOaGs4ZDFxMXJWZGgvKzI1?=
 =?utf-8?B?Vy9nNStLcjY2Y0piaEhJVTVJSC9DcU9HWDhqMm9MakhsQTlqMC9MMEpud2pE?=
 =?utf-8?B?MUdITFhkMkRDZno5SWlGa3FocDF2VEs5QWtLOEoveDlrSHU4Ny83YWJzdVBu?=
 =?utf-8?B?QXk0a2Z0aGxLeThlTHprWm03d3plL3lJQWZ4QldqejVZSWQxSktFeHQ5eStv?=
 =?utf-8?B?ODZIQVppWWh3SWhjS1MzUlhEQ1d3YmRFeXJrN1BPWExtTjdsdndoYmQ1dXdZ?=
 =?utf-8?B?dTNaQ3c1WFBqT3JEVUc1Q3ZwZ093eGY2YVdVeUJhWDJub3hRc0IvRHVoWEVh?=
 =?utf-8?B?V3VXZXhuWWFDK0hZVUdXcjlyNkNBSTVoY3k4VXF4NlcrV3NCb0liUW1DWlpa?=
 =?utf-8?B?UWg2bXFPMERQc212WWpWTVMwTjBvVC9sQVZXRm5mbThIWENYZ0IyeWlQQWFs?=
 =?utf-8?B?NWdiaURZVWxrWHgyZkU1ZHM5b1l2RUhwVXNoN3hGMVJhTGhJYlRMTGRuTmhT?=
 =?utf-8?B?MUx5S1haT2lXT1RFVXBEZmtWTUttbEN0ZUVFVjRERUY3RzNMQXB6dE5ZTDNE?=
 =?utf-8?B?b09sTlJrTUNQbS9kenk4cS9PcTdsWW9sMG1yN2xTNjQ3L1FDUGJaMTBWMFd2?=
 =?utf-8?B?SDI0YUxJWEVseG1MYktxMXowSjIrdEtFT3V6akJwTksxcmJYc0dkb2tVc3I0?=
 =?utf-8?B?TjAxbVQzQUdFbzE2emVVNVU0cHBoK0ZFa2MxOXRFSVV4eVlxNWNpSGpLMGh5?=
 =?utf-8?B?VDNnZ1NGQWpBRVZlVDBUcTNKWk1OOGpSclJuWnpySTE2ZzRMdk9KUXRXQVd0?=
 =?utf-8?B?RDB0dXBHSlZUM2JtNEJySk1HVHArTzRaZHJuOXgyTmtUYVJ3M0M0cVpsRnZw?=
 =?utf-8?B?M1hBUEdZa3BBSk9YMmt0bU5kVXZRKzFrcE1iYm5OS283NFJGdXJKQ0NOY2wx?=
 =?utf-8?B?TDY2MjV3TW5qY1o3RzIzQ0hsN1F0WG9wWjFGYXlzemxmNWR0Nk5FRXRzQWd6?=
 =?utf-8?B?dURvcW54K3RLOTFQN29Od1MvamtOYjY4VG4weXd1TDVwSU8waWRXTWtKUWRj?=
 =?utf-8?B?eG5SV3F0WFhPdGhiUVE5YU83TDhjVkpTYjh6aTM0cjdmME54dXBnL3FDTkJt?=
 =?utf-8?B?ei96R1lBSmkwQlBrbHgxbEFSRXZkcng0eGxlak9Bd0llYnVmb0RnTXJJN3JR?=
 =?utf-8?B?dXJyaG1YSk5KdFRDSXVYY25LKzJoSEluaFA3TVlJMHgwWFRETjNaT1hpRnNJ?=
 =?utf-8?B?bHlxQzFsRGRXdW55VHBOZmswKzFnejE1eWVDS0RlSlJoaGZSSkljOVp2cGhi?=
 =?utf-8?B?MDJCeFk5NXh2a2VYT3FENTA3YW9ieVJoOGRKV3Ivam1ROTE1cGtTWis2QU1u?=
 =?utf-8?Q?0Q6sh28LK3BChAV5M1GTCK+vIxwQFmpuMj1xnjpYC4kP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF9D83D51047424D83BDF4631BE97E19@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0cf348-29e1-4436-c154-08dc47c098a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 02:59:30.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PSVwFJH31okwAGGb0Wxq0F5xRkSYYiUHwhbfVDzoTwJKzBm2kjVvKGu7wFdjEyRU+dIUqm2KxRAGzDfx+tzKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_201537_921566_DE135170 
X-CRM114-Status: GOOD (  13.03  )
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

T24gMy8xMy8yNCAxOTowMywgR3VpeGluIExpdSB3cm90ZToNCj4NCj4NCj4+IERpZG4ndCBzYXkg
dGhpcyBpcyBhY3R1YWxseSBpbiB1c2UsIGJ1dCBhIHVzZS1jYXNlIHRoYXQgd291bGQgYmVuZWZp
dC4NCj4NCj4gSSB3aWxsIGFkZCBhIFRPRE8tbGlzdCB0byByZXNlYXJjaCBtYWluIGNsdXN0ZXIg
c29mdHdhcmVzDQo+DQo+IHRvIHNlZSBpZiB0aGlzIGlzIGFjdHVhbGx5IGEgc2lnbmlmaWNhbnQg
dXNlLWNhc2UsIGFmdGVyIG15IHBhdGNoIG1lcmdlZC4NCj4NCj4gSSdsbCBjaGFuZ2UgbXkgY29k
ZSB0aGVuLg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+DQo+IEd1aXhpbiBMaXUNCj4NCg0Kc28gd2hp
Y2ggb25lIGlzIHRoZSBsYXRlc3QgdmVyc2lvbiBJIHVzZSBmb3IgdGVzdGluZyA/IEkgd2FudCB0
byBydW4gc29tZQ0KdGVzdHMgc28gSSBjYW4gcHJvdmlkZSByZXZpZXdlZC1ieSB0YWcgLi4uDQoN
Ci1jaw0KDQoNCg==

