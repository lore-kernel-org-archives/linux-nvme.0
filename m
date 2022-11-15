Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2365CC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 03:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=di4ZwzPFjofCbDIKr/k5shslZGD4XZoMt2iS3xSmLv0=; b=ujYTSX7yt/NQNFhMPKIszxm4gh
	EYMucJ7aOekrMM4LGlXH1mBIhvVgwjzV/erfuZFHJBTWIphLystI7jyJQzUr3SW/i+nbZjr7Hol55
	QsQ9ajzO86TtnOtRryUZiHeHjTvgHfJQLp+zVat30KOkFff7kuXmHhDjUCEVVr5ANINQQl+McuPdV
	Lin3oxA4cQh+sQDBWAl0R8yTEikqm6disJWqFPp4In6A3rn8s1AnJQ8iUJKtLIPuRFdVgWAJEBsvU
	dcgYI91JR9vLxGjXQILspW4SX++8GPZS/i3pZEtDugQx0sK9jH3wFy8j7+xN8KU8loLxfArQhBl87
	LqmxGnXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun5Q-007LdH-8y; Tue, 15 Nov 2022 03:58:12 +0000
Received: from mail-dm6nam12on20618.outbound.protection.outlook.com ([2a01:111:f400:fe59::618] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun5N-007LcU-AZ
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 03:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/8og7kTk5P8rblsRJhiON0ZT8kTsMP73oBLJ7QrlzEy0SYiZbuPe+nYluQM0b3a5rrdFBM//dtRbc7Vybynj+a0jTfI1BEwIutqf0ZWZzsBvTz8THduU872o3+A3nUhjbGfAuiV7LPf7bj7TYinExIncsy40hUyK8N9kSxpyR5ZrWb0K3oANdJCekHIVAU71psS1eS6wF7Na0Q2fRab4wK9D8BNdeV/mdOgtZ4lUm/M+HN8oECMsuors6hunQWUtQLqevBdjEW9ShiPSQynp06tW/rqFEVdZ66dnLF2D0+irS2JzoCDLcZt/q3o/b4ChkB/a19+AwDPjWI6/REJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di4ZwzPFjofCbDIKr/k5shslZGD4XZoMt2iS3xSmLv0=;
 b=XD12xzylG7ZoQsh4eR+AhGDP5F2M1JmSYX2iwEOw3hHZQ8YN1DADngstzpbRK4xic/yTnnx4XRwGftbkKyNJ5AY8nyOubajrj0ZU/TRbvSDrzJ42XirJUEYsAyJWTkyr1rNqtiqBhRv778ov9j6PnNMDSwGxqd4/RCPBD4b5CTgZFdpOghv/ylcBvEVMlQ+rEdA99EssclmMs3h2d4SXibJSm/J7irBusT4l5b+A6lMhYdmpSmstSt1TA5LfHEmNI2MRNXu3zvfDtK2NzkHmq47/88QYCDHXlkyrzXhQNa/vHLcRVJdiy7JjNgrv3S9GRBFjswPXutbkrE9H4YI5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di4ZwzPFjofCbDIKr/k5shslZGD4XZoMt2iS3xSmLv0=;
 b=EywbiWQ8KIY1E/pfGxU4uyac7GyzGVCA8o6gwUoyO9LnHm/1TlLUTG4tj+3MC+LVE7I2B8RrcTn9TkmHYAsV2svs0UIo2ynXXL12JroHykISEPw4LLEY/eQejgU+EJkJeppkLgNFzqXbwyuk07kbPJXqA0lquGAMcj65Nn+yjv+xgaZivVaoD9xIUxcaBTab8up5RgeqNAAl4bjK8Rh0PdCxIuEVe+xx7hUJ7Lpd++eIx4MxHMYFZA0tC9nI9RP0Wa6OVWSpEVBiSYON4dIV+Ouvj07kFW/ZBu2jWjymOa657vGwb3A1qYvkEahHvv+2xFTlc5qj0bJk10mmkrHO+Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB5423.namprd12.prod.outlook.com (2603:10b6:a03:301::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 03:58:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:58:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2 07/20] nvme-auth: don't override ctrl keys before
 validation
Thread-Topic: [PATCH v2 07/20] nvme-auth: don't override ctrl keys before
 validation
Thread-Index: AQHY91LB+1C1Daytc0unHjdcqTe39K4/XkcA
Date: Tue, 15 Nov 2022 03:58:05 +0000
Message-ID: <72fec63a-16ae-2350-dc96-949c9c3e3f96@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-8-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-8-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB5423:EE_
x-ms-office365-filtering-correlation-id: 85b2781b-6aac-4d6c-64f2-08dac6bd9977
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  MYuVXLiiD3tKHDpuQT5E9xxWxCZZSQ/6EkQs4z9nRw6tSPyI4MhEp539ME7aTCqaAk/Yz1dOrrplZw+0Q6Iay+CsOLWw5qkBXyWwt0Vn90NL5bwLqxo2Q7PePSljZcqvNZzP4jwEBcSBLv85LnKVonvdF8OkJCOYOPAMheA0uxNnn90TvJecc+gyWw9PWhWiGdepUgbPCgoVp5/KE6nNgFR0OydBRfnqWALuUeAkARZTKSci1tqZW0v1eJdy0n0+bXUG0oG2lDRW2WLV0zq6hNjLe3tgeCZxejQ6lbt3IWapPucypAHZrGptbqfXtpsbDtS+HdIOTkCgQWxsa1YtZ9yFxh4aYEOI6I3FBtOiCC/EwCJ7VRKZx4WHy+v5Na7r8qDgjWqmghQTPGh4s4QGWKeDzLFdT9MK4pXw5POIpI1She57idG3GbJpBxmnZlfF6+IkHt5lzxq4QtvdgxcLTazQYAB8Jz5MYht58o6VygmkbLPjapJ2E9Zcm3E4YL74gqwpLuiyfZn9BP6AnPPaMbXtn36lpbsxARfsG1nFR6VEurPhUAIOa8/2iotAISMkCRpvhhj8JTH+pESRuel5wwE9aqmsd75CTxD99lNoU63gLspsxpqupzcrqclH7UF6VbTUQnYqgh3BJW2rLPwFdN01WkzQ+SAXYPPB8DpH2XqiGbOP/AZ8PbGp3RE25fWEhIP1srA9SfKGp7cmo4ujaPdwcwJypM31sAOEC02/lq1Xjmr+bgwcs7cDkSKdTJFMsdz5+adDFWAhJxOM5IS0DhQ9ivuxUIrRFG6uY7vCSDBvncmDz8we5DIH3Yk8UkJb9NdqOonK//hHKKAT30oTIQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(478600001)(71200400001)(66946007)(6486002)(66446008)(66476007)(36756003)(66556008)(76116006)(8676002)(91956017)(558084003)(54906003)(64756008)(110136005)(316002)(4326008)(38070700005)(122000001)(38100700002)(6506007)(6512007)(86362001)(186003)(107886003)(53546011)(2616005)(31696002)(8936002)(31686004)(41300700001)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?N0pJVDR0a0dqY2R3WHZIQ1VZN1h1ZzdlNUxpb1hQeXcyVDhOVk5Va3R0MGd5?=
 =?utf-8?B?Wi9zYW5Xc3NBbW0wbzZiZXpQOEw1RW9aQndwajg1aE1tR0FqTnFxMzFyc0I3?=
 =?utf-8?B?WVZjUkNlcGF4U1QyV21iZENCT2pRTm4rNzhKNVZqU1B6U2k0R0l0cTNEYldk?=
 =?utf-8?B?cmgzWHRuWmFzMDdwQ0ZqUWUyWi82ZWlXbGhQWHpPblhkVUwwMTd6NUJydUNQ?=
 =?utf-8?B?ZXBIVnI4Y3JwbHVsWWdjdkhUK0VEbG9lRGJaVmRuVzlwRXNSQzFZalorUHA3?=
 =?utf-8?B?UWJuNGk4Z1doTDlpczlzM1JjZnV1cDBraFRvS0daTW96RWpWcEhjZVFBUWhL?=
 =?utf-8?B?WHJFRVFoVjJDUmRyQUx4Rlc0T3VVNEtuSUVqTkU4ajYrbDlDbmQwUzV4QS9z?=
 =?utf-8?B?b1ZNeXFmbEhMYmpKZkJwZThhK3JJanNvaC9TWDBvWHdEMTZMZmVuV0ZDbm8w?=
 =?utf-8?B?RTBiZEQ4MndTZGxKL1k5T0NGRUhUbXNLeFoybTM0cE5BL1hoR0pRZ0NUdmpB?=
 =?utf-8?B?MkdYR1pTKzAzdDRScXJGS0s2cE5IZjJnVU9tejVVWVJkRDJGdEE2em1nWGNJ?=
 =?utf-8?B?em1QNEdXUGtkT1ZIUmFlZmt4WENhT3lvYU5JOVN2L0NVTFFSTmxqN1NrNHhU?=
 =?utf-8?B?eEpUQURoOEZqVjMxM0cxMkNRVTBTRSs3cFdDNDFvc2RYRktNS2M0WDdKNys2?=
 =?utf-8?B?Wk1kQlNtRGJVNUExWFJwR3FPaUhXTXQ1SlA3ZVZGNTUwVDVBeVdDRWt3d014?=
 =?utf-8?B?RmhXUTM5a1NISUx5RUFDVHJvQXc5MVJDT3o4Smw5b3p6cnFIdUNoRUlwVjBZ?=
 =?utf-8?B?THY3blhNSUlRM0RKYVVpT09FUGRha3d2eElDVjcvenNMVTdINkh5YzZEVGRn?=
 =?utf-8?B?ZnNxRmJFc3VRbHFDdUR0T2NvRzZma3ZmSy9sODdoWEY1QkFsS05KUmxJK2R6?=
 =?utf-8?B?OVI3U2NnVGxSVVpYYUdTVmZzTXJuOFpQaUovVVpoc1RlRENzU1dBRldzOVlR?=
 =?utf-8?B?cHBPckdWekdqRGhEbXQxbFNZbDJObDBLUzFKOVdyWTYvT3VJUXIwZE5MUTZh?=
 =?utf-8?B?VXZZaEZVYVJqRkt1Qit5YUsxVTVwR3kxRDZYUGxpakVnNnBEN0o0OGhmUDJC?=
 =?utf-8?B?WVVUSFVYcytkaUNnM0JNaUlDMzlCUzVRSVI3ekJlZTNtN0IxTU5nQVV2bXNT?=
 =?utf-8?B?d2dTR1RGS1BoSUJjS0REME1kWGNlazFwS1VpVytxa2RIc3U4UUszUUxSMHlF?=
 =?utf-8?B?Q0VCVktIcXZQanJZUmEzZHJMZnQxWDU3UHljMGxObzk4VHA3eGVxa3NjRGRC?=
 =?utf-8?B?eEJSRlo0bmNxOVJoRTdrelRkTmhSTkVtcmUzSncyL1M1WWpxbldyOXNuMDhk?=
 =?utf-8?B?Skg3N2J4L3Jielp3WktQL2Vqa2ZZMmdkd1dIVnRGaStiQzJFTmlHVGJiV1g5?=
 =?utf-8?B?ejRTMU5wUzBhRS9rWUh2bUlLUXJyWWRBMUdPR05iN2QyWmhOdEZMWmtQcmJG?=
 =?utf-8?B?M3JXRVFLNXp0Y2hoQURFQ0NCc1ZVTi9sbHdzbS9pNGlYbnk4UGVYRzFyUXBt?=
 =?utf-8?B?cEFncFRONjQ3YkUrZUZ2Z1ZmU1VXQ0tHQ2FDM2UrbjVaRlJDeEdGRDJCYkJK?=
 =?utf-8?B?Umh2cks1Sy9VWHpkNCt3dENobldjZldta2Z6S1Yxam5qdlhlNVhGS0dJODdL?=
 =?utf-8?B?SzJ6S1VCZUlIenpzMEdMVVlkcVZJRWdPczlJdkVDdXNMa3RkSitueVJ3NjN2?=
 =?utf-8?B?ZHpMN0d6dVNNaDJocXRVWEpJTmljUU5hdEVyd0FCMDdLc3huVjh3VGo2MHZL?=
 =?utf-8?B?c1Z0U1BkZHU3dGRUdjNSNklXclU1eDBVNFpzVVBtMHNxTzFCZ1hoU0NhU00v?=
 =?utf-8?B?RktEYXVwVDlobU1mcC9OcFM2dGZHVVl6TXk3N2xuVmpYRXhzY1V0SGxVK3JE?=
 =?utf-8?B?YVB3dWF0bWZKaWxsWDkyOWtJMjhDNGN3UXlsYTBHUTY1UG1XbVI4WkFMZ2FG?=
 =?utf-8?B?ckZMR0p3enAxTHcyVTBWU2pOOFIvWUpWR3duT0VvOWphZTNwTjZTYmllNUw5?=
 =?utf-8?B?UW5SRTVjc28vcnRhN1NkUWk3SUJKNzRKRHlsSHVTVks4dVdQVVlJRFd3ZDZh?=
 =?utf-8?B?YkVKWDI0VjhodkdtVURqTy9xRkN6OWYyYXMxc3lBcjR2Vlh5MjZZTitOWHI0?=
 =?utf-8?Q?5Yh1eBAsJCMiw4sJvx6oite8g8q96O2cds8RphNVzy99?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7455B7ACF9C27D489854EEDEF354A1E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b2781b-6aac-4d6c-64f2-08dac6bd9977
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:58:05.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVYwt5cQk0byrYKdPI6Px6p9lxcVVW8mSNsJcjTWPQ1EDlvez4+Wh+Ie+hv60H5w06pIWKaRaUvgpY+62NB5tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_195809_393017_54CC25DF 
X-CRM114-Status: UNSURE (   9.55  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IFJlcGxhY2UgY3RybCBj
dHJsX2tleS9ob3N0X2tleSBvbmx5IGFmdGVyIG52bWVfYXV0aF9nZW5lcmF0ZV9rZXkgaXMgc3Vj
Y2Vzc2Z1bC4NCj4gQWxzbywgdGhpcyBmaXhlcyBhIGJ1ZyB3aGVyZSB0aGUga2V5cyBhcmUgbGVh
a2VkLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg==

