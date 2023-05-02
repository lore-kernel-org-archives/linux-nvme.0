Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CFFC77B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 06:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gHLPiOtRZumDkfJLzb5YPcM/mftgv5fTrWL9Nzr/p5A=; b=YPgukCpF2A8AhXLQ8mtbPk/3lb
	A0p/G3eotEwcGzSdW/Sx5z49no5HxquEJevKdTrzNk8hCix81gWPTJxPCoKb939/QQYiFLd0jpJdS
	49JfMO9+xzJgEHLOqMFM49pxeB7gdXI2yrmK2hbOdMqkkMdUPLzRjl1wYZfzZyv6b8laZwabofr3c
	hHw+P4PThHHf2jw3icqM13w+xrx9gOt1TVTolaOZ7Z8+OmYT7Vi/DtG1gENl7ToMOWIs3nhhPaDdz
	sAy7cGng0LcSTxMVEMNu8iJzIA0F7M0opwLMkw26OX/4J0/ryzhKTDVow3C2zWR8NHerUPrNwgFav
	ubrR7ZwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptjpk-000OFR-1I;
	Tue, 02 May 2023 06:49:56 +0000
Received: from mail-dm6nam10on2060e.outbound.protection.outlook.com ([2a01:111:f400:7e88::60e] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptjpg-000ODr-2T
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 06:49:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul2wkMW1Mp3ucuUMB+7JdiVfugkkhzd8UaBypMvfOEPXqzJ1ED6PPepjus7wR5522MbwNHl59ZCm1zvsUdYIaIHOGMWu3257EhKeTa9TPElv4NuIxrefmTr4zVvYzOttgNaQJ59Z+wSZGVjNE3JXg/O1WLPkxrVJwGNLZKA+r/ZA+LD4UFwS3ui5ej8dsyQAML1sgJUKQQ3JpzuO1cjxz1R80nZ6r4zTLlHRDCEZzsmSOBKA0yhSXCSXLgLhJokl7AVB2qTJoFYoJFxsQH4I4tePeQUZi2ToYA6dOCQSdc78uvLmvG64Ff40pWPGvsVM3Tk9T0HDN/91ZmlSvq7t0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHLPiOtRZumDkfJLzb5YPcM/mftgv5fTrWL9Nzr/p5A=;
 b=VGtS07mZES7rktiImWqTQi/GIEMTclKwq9qXQWypbsOgK4a+tqRAU1exmOx8n/LjwIWmVEQX6sGDJnZp2kiguAhQ/W0HROKF4ag3Si19saQ0wmBp1OfM6d5L8jRRZvUMRZhSP8T7sTZSjRrWen8HzrZeYpgEL+N72C9q9YhGVFycHtzzwlhb/XeN61xv8XAqUvZcZU4Gt2AzETJQe3eA21L8hVIGP2l/2DD6W3/swtdP++SJD1MRqtaipVSDEZ36t+AxKdCdso2Tc5yr1fTplvm6JSIyr4kBhIAvxH7k6r8iXjjuefEM1XMmSGNqYrqDfuO8G/k4Szuu7CR9OgX/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHLPiOtRZumDkfJLzb5YPcM/mftgv5fTrWL9Nzr/p5A=;
 b=Ur2e5zA9UIOxuUo3HdWEzfdm/Bcw9X6m2uZQp7SvQgUAeB+4kP/6HnXKsQ77VaYzJP3MVe8mKas21HtmqLsT54zPzjdd7qfVpJVKFWGyL+9FxpPVCJG699EfR04t2REmvygb9so6/O7+PRhZKQnt4mKfJFFcDJRWBRiMr5JpjqGIesvlc5M7sBUKFIzIpuxngAlX7P1dzNdUkluOFGd+Bjq00cbDi5B+gP+Pk4V92tLI8HX5ErQxwJv3iIGRV2+Tto2v4kpB4JbcrtUtWJwqHIRgnwi9AY9j+xR/NvX66Rh6qIIjNF8xEASmJBWbzQFvYwlgAB6p7b06n88/QA7/wQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 06:49:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 06:49:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Smith <dansmith@ds.gy>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [bug report] Duplicate IDs for nsid 1 on another drive
Thread-Topic: [bug report] Duplicate IDs for nsid 1 on another drive
Thread-Index: AQHZfLDqljHGSVovQEOhbZG1BBZJQK9GizKA
Date: Tue, 2 May 2023 06:49:50 +0000
Message-ID: <e092dba7-5e7d-7306-683c-e9d53228cce0@nvidia.com>
References:  <CAKv4OQ08jfk6r-c0T9U-WtZ6ORt2kbR0ARiH1isav-uFZYoYpQ@mail.gmail.com>
In-Reply-To:  <CAKv4OQ08jfk6r-c0T9U-WtZ6ORt2kbR0ARiH1isav-uFZYoYpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB7767:EE_
x-ms-office365-filtering-correlation-id: 81ae719f-52bb-497c-e171-08db4ad96d03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  wMpv+u4v2hSvybuCBc6RC5uZaGh3VkGyiEjEJQDdunv7rkjYJM4eBj7Vg8R04W6MikXH5RP9O2bMdzev5SsO2z8KmDHV5+XRY41uLqcoEo1hCJ2AruxC7yWGle05NQ3lf9fnnVumnUX6ih0gUdKb3rifc8W2lZc4JPoQn4bhetkIPugpSZaTgJzsG82LGGrfQovJWE2E+E95MJD4K2cV7PZ9CBcV5yvWWUbmSH5V16ncjXjKKbcZ1lBueyUcK9AFXHVuLnCGwf6fsXNDOyB99ET/G3RulWnYYU0vc2kWx7tM6CeaexYV05uxm3SfFDFmSbio+5ZiuEqBugidFk9h3Io9hi7m4sXGGNd/ngtDUE6TlkUmjPT8w+mTto9nVoVBeowkIF9b62J4v/ROoZB9QWIrvd59TiCNxYCqykuIZrFGhZbEd0lWCkwDIBxgGt/5EyRmvlX6+qnKXSwP4mbMVyFbRowG/GGFiIG3NlpdteS46TXwZ7w3TWyCRzHXULOnKEIrrAzodsJCXtJLOG6ZZg8X5HTfJhpF5er1s6yChxU9aB21Mh/Zcqgj/N5rCOjO5v/t/mvsF+125Y+J16yOC6+CAGGl5cD1Rn7fC4TtKDMrOxJB4epIXQswaV6X3T0rJzRkxZMBfUGTo0zb+PLblnfQyqov3E/BU1JWqWr1RBOGwAQbK8IzOpUkGdPd5tKh
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(2616005)(83380400001)(478600001)(186003)(31686004)(91956017)(76116006)(110136005)(66446008)(66476007)(64756008)(66556008)(66946007)(53546011)(71200400001)(6486002)(6512007)(6506007)(316002)(8676002)(8936002)(5660300002)(41300700001)(2906002)(4744005)(38100700002)(122000001)(38070700005)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RE9CVEdEV1F5UTZ6d3Ezdy96RE9CYlgwRnA0NWJqM1hqdGlUMVFWV0dRVFk0?=
 =?utf-8?B?RWY3OGlMQW9RdDlrdThYcGkySVRFQmhUUG9wc2NrVDRlR3B0V3RMVXpEck8w?=
 =?utf-8?B?NWJMNW9JVzdDdHNQekVIRTZ0aVpGNmNTdzU0SUpvT1p5Y1dUNEV1a3pZekpC?=
 =?utf-8?B?SGJyRXlTaHRIaDZXZGlMclN0dGpTYTc1eVNYcmtRdmlEYjlNeklIbGVFWGdq?=
 =?utf-8?B?OVdtWmU0aVpsdU5JQTlTMVg1c2p3UDQ0eVk4ZjZ5bWpwSklENkY2VHNwQjU2?=
 =?utf-8?B?QVMwL2xFN0Jhbnk0cTYrNjVvRDJMcFhmV1l0WTlZYlowdnVIR2Z6T0tFTjNu?=
 =?utf-8?B?NVBXZEQxS3BHd005ZVQvWFVLSVUyekRzYWJuaTVOdzB3RVpFQURyay91TENU?=
 =?utf-8?B?MCtSdndPcHppRVZRV2FYb2ZyOUxrdHFyYmtpa1pUYVk4WHUvOExQWTdSaVhC?=
 =?utf-8?B?WWpVdnhrU0hrVk91UGRXLzJUaDF6bldzVWNYOWFndHdIRldLZ2t6NlNGMTlU?=
 =?utf-8?B?azZwZElPcHRZZ2h2ZFVycUpDSktNVk1nTmVTQThmZXl5aVR6dlpHamFhVTlE?=
 =?utf-8?B?NjAxa3ZYTTlocEpjSTZ0anVIWFJXWW9zS1ArYmdSUzZ6bVBDbFdLd1RHTkdV?=
 =?utf-8?B?YTZwNjRQTE9GdjlWY2R3Rnc5bUVQRTREYXZvTHgxaXFRQXNRcHV6V2MzRWk3?=
 =?utf-8?B?U0wwVXlvR2xERUhsVkl3bTN3aDdMTEMyRGhqZWFXbmR0aGVEc2tzOGNKMDZh?=
 =?utf-8?B?VkRmSlZTaEhSeFRBaHorVzFBOE45MU8zZjZkZWY1U2JqUndGUS8venBYdWdw?=
 =?utf-8?B?dHhTSUl0UWI2OTFVWEN6V01PanhHcnFEOEFGOGNFeWFSOGdKSE9zdXdSYzNM?=
 =?utf-8?B?NVBDSGt0d29PQmZpNWRVK0MwVjdPMm9NeEYrWFh0MnUzcnlhc0FROEJwSnVs?=
 =?utf-8?B?ZzFBNDRtMFdhd0ZkZWFmNW1PM0VJTEJQKzZGbWRneWw4aXBkTEMrR3VWT0Ez?=
 =?utf-8?B?WEN4Rm5BSXhTUGxUZ2FSZ2dnTUpIOWhhUFoxd2EvaWgxem0yOVpkWmFyZ3ZI?=
 =?utf-8?B?UU5VZ1BPVDJoNUVOTHl0bTdUMjhqdExoS29Rck1mN2ZBOWJoaVB6YTVhUTNJ?=
 =?utf-8?B?eFgvbzFXQnRJaHF5a0o0bTU4RE8vRW0xOHg1WU9pbTg4YnZuaWJBdzFjVlI0?=
 =?utf-8?B?RGxWVDZvN1RHYnJCQ045WjZEUTNyakJCNGhpbGl4WGFhVW1NL0RIYjJyY01W?=
 =?utf-8?B?NEsxbDlKREVnTWNVSmhnTFhlclpDVW1tZkNPQXJTRitHYktCSzhhN1p0dUN3?=
 =?utf-8?B?S1grR0lpMkRnSk56bXNiL1lQd1VvYVovTEhpOUxBa2FDaEl4U3VVMFpRNm9s?=
 =?utf-8?B?UXViektOSUVkanlETVF4VVZ3WGFKRTVLb3lEK2NaQWljQnVLc3NtM3NTMHZY?=
 =?utf-8?B?NFYzMzZ0cmNwZ3IrKzBRdi9KSC9tL0VjWmcvY2xvZkNPV1Nhd3Jha0M1cVUy?=
 =?utf-8?B?M3pLaHZFQjc4WWx3czRyNnZDa1NuV1c4Rnh4QURZc3g3TnA5Tk90QmJMcVla?=
 =?utf-8?B?T0Fmbys4Zzk2emtIYngra0pNV0NZRkNrb3JXZFBHMEdma21jWSswcVluL2hP?=
 =?utf-8?B?VEo4M1IrMXdXWisraTdsbkh0dlgzOHo5OHhiUitVbnJybjg2ZTgyMW1HNGlN?=
 =?utf-8?B?bWdzMkJVbjdDWWJYdkJmTWRBU0V4NWJNVTU0UmJaMnRLV3Y1ckFGVjdJS0ov?=
 =?utf-8?B?NFEwbXdYbjdRZlE3b2FhZ0QySnVKR2g0ZVUwa0dLeVV4SGdNVndabjM3M1lw?=
 =?utf-8?B?c2I3OUNzNEdnNW1tdDNXcnI4cC9COEcxMDlLcXFHcnEyYjA0anRtbmhEaVlw?=
 =?utf-8?B?QnJTZ2tiQ3RCdlIwUTdNNnJBU2JWazRIK0hqU0tscWRhNlV4YTY5Rm9Yc3BI?=
 =?utf-8?B?SXNNbThFMzR6T2lmQ0hJai9CWTR2LzNRTTQ5S0ZKN2FsVjkvc3VnR08rTVVu?=
 =?utf-8?B?ZWF0L3JHYm82Zyt6bE95T3A1a1h1MnZTUHZsdEpSTmR0YkFWcHdnc0RtdXQv?=
 =?utf-8?B?ZnIxOWYrajU3Q3VoeXhNSVYyODA3L1Blcy85YmJCeU1ONEVaVDdBdW9VRGR6?=
 =?utf-8?B?OElvY1lDNS9zOEFUa21kbUg5b2xQWEtLMTJvYjdLbDRmWHlzVDRMMlE4WExu?=
 =?utf-8?Q?5UVW27O04qmqDl0nYp+E8VkioJ4U0mNWRrCfPfyqpTu3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <528DB96932DBA54B96EA8BCE193E602D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae719f-52bb-497c-e171-08db4ad96d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 06:49:50.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYog1RsHD4jgqc+EXhhai8MSunV/Upjr6SpG9SyLPCUMpnpMvIdys9AQlgHXEXTyuO9kMg3Dp2i0GwF9DO2GrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_234952_808603_5A982540 
X-CRM114-Status: GOOD (  12.57  )
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

T24gNS8xLzIzIDIxOjQ0LCBEYW5pZWwgU21pdGggd3JvdGU6DQo+IEhlbGxvLCBJIHJhbiBpbnRv
IGEgc2hvZGR5IG1hbnVmYWN0dXJlciB3aGljaCBkdXBsaWNhdGVzIElEcyBpbiBkaXNrcy4NCj4g
SW4gdGhpcyBjYXNlIHRoZSBkZXZpY2UgaXM6DQo+DQo+IFZJRDpESUQgMTBlYzo1NzY1IG1vZGVs
OlRFQU0gVE04RlA2MDAyVCBmaXJtd2FyZTpWQzJTMDM4RA0KPg0KPiBJIHdhcyBhYmxlIHRvIHNl
dCBOVk1FX1FVSVJLX0JPR1VTX05JRCwgYnVpbGQsIGFuZCB2ZXJpZnkgaXQgcmVzb2x2ZWQNCj4g
bG9jYWxseSwgYnV0IEknbSBjb21wbGV0ZWx5IG91dCBvZiBteSBlbGVtZW50IHRvIHN1Ym1pdCBh
IHByb3BlciBwYXRjaA0KPiBmb3IgdGhpcy4NCj4NCg0KaWYgeW91IGNhbiBzaGFyZSB0aGUgZGlm
ZiB1c2luZyAiZ2l0IGRpZmYiIEkgY2FuIGhlbHAgeW91IHRvIGdldCB5b3VyIHBhdGNoDQpzdWJt
aXR0ZWQgLi4uDQoNCi1jaw0KDQoNCg==

