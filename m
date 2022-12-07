Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589E0C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 03:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6NTfGkFhRv8GDOVoexCrjO+ZOlMRiFsHUhJCfn1AOGA=; b=e0pX22mUg7rQYt7HoZ0WgXiakq
	+BmML1OWzSKZpkLo8eEllx4EtF91KFANMkQlBl6y39nv9OqNRw07StIB+Hx4wT1jisPpo6ThDi0Sk
	pAiR0VzDfRtLqgOH5Eq8K7r3oXAB4pnPfhloyFzi+8fzGQ+uNNznku9mqdVt+ZFkg7ZU1GtcfkDQj
	T2y6+qIQjxa/2kAU/WJya/tNSwbpziwTsidqa4W6v2i4p8K9NDNqhSf/tRHnJujHPSdvw8pJMuVT7
	nls8hXHNSfBbULNbQ5ZUFGWNvIxCi0/qUYzqwBPpPKmKSSoJgdzBLEuYjSC8J6R19jOd3ElHLPcX5
	eTzXVIig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2l11-009dC1-Ha; Wed, 07 Dec 2022 03:22:35 +0000
Received: from mail-co1nam11on2061b.outbound.protection.outlook.com ([2a01:111:f400:7eab::61b] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2l0y-009dBE-6q
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 03:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6JcKNfkpAOT4YF+AAO+YY9Yn0n6xI/Tknkd9CL02h1pZpE611YIPEviMm7qmirmhomNJyJ4xREPL2tLRhOSTN3fU/bhPyAlWAP9kfzZvAAdwvWg4Tg9hIBwIzuPjlvDHeFtRrteBOo85eEiCJMeDw617gaynHD9tlSIwVyjUpq0Bncg8HFtz9wgJQy9DFJpvHBcru5B+BICWEhVRihD5CpG+8JN5MUiEwNv2mA00ah+YMKkoa4JJItkkowaJb4Saz9T3176M/ma8jGCSzNS0v13PMPYvQsea1Uljm9b6m5Agj7ef41y6WHqCpqM1JsjaJ6CsGms3K7341R/NaM1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NTfGkFhRv8GDOVoexCrjO+ZOlMRiFsHUhJCfn1AOGA=;
 b=OSt3s2qne6kWKtFMgBaZGfknI6/M+lkQRQItcQreNMYlGjrSOcjy8isqJmNkkUxehi8M7ONI8YpRMRg0GFsFP/hEimc+aBOOSJC94ZB8DDCutX/j5ZPXlFhBFk1WtenKrbMqo4TYO07M2In96ECkQaw87ze6hZTT+FRvYRfKpMQe5O+4lIrxnnfUP24tNaF31mRwRXBI+9+LWtaa81C1D03AweyGPF0xvqOL0ihU7arKBdRw5xOB2d4505LpDZg6uQkgFpCaVFlKGSQPAWCXjqHUegePQmfU/oZCVxx+MGnUcIIwcGAxTi42pnUuBQvQssPMmYk7jZMz1eC1SyolOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NTfGkFhRv8GDOVoexCrjO+ZOlMRiFsHUhJCfn1AOGA=;
 b=D/E/H9fTHJSCC/Ps/g1oXBY1HLT79NrMhxtmqvpoCGKKBjPREbiJpX7k8P6/etxvMHNmca5RtD6mWnAi7ljF1yJ///cvl0c33WDZsiUwwlZWDloWJKJedn82AMzlKYXN1X0x092jci1x2DVr+3+VPcjtA+wvPIrfjXJZAV+Ts0pOYvhb/H/HaeGCKVQlsiPQZ8GFgt2yUYaAB4XzCX1Cdd6A1VhK7vIb/uy0PN99TwQZnxoKMW5noW+RDGK243LULrUinRHShQj6qzNhpQkTzf5P74msHlXgBhEYtWeCNtaj1ZM0fllBdH4m2N0cPCaoZ/mcb3JN0uR/38VSSEl7ng==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 03:22:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 03:22:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: use the core tagset alloc/free helpers in nvme-pci
Thread-Topic: use the core tagset alloc/free helpers in nvme-pci
Thread-Index: AQHZBOMsR5aWamQhwUu1cLlJ5WnVfa5gjNAAgAE/qwA=
Date: Wed, 7 Dec 2022 03:22:26 +0000
Message-ID: <41888603-787c-2856-a984-bab097023794@nvidia.com>
References: <20221130174240.227616-1-hch@lst.de>
 <20221206081818.GB8738@lst.de>
In-Reply-To: <20221206081818.GB8738@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB6872:EE_
x-ms-office365-filtering-correlation-id: 65da3428-c268-4236-2b55-08dad80243b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  HXS06GUPLGhiDZMNssh/1PkTBGGENIxXX4rjqwTT+mNHj9YvwQQQc1HNWZ2KuFuBQ6ltuyS4GBB5lunu+OrL46oTXbvMZ1I/CcaOpXbPbaqtEqSP8Dnkcc+cgaWA5PdaXawbrlCCoaboMlt/WRIdJA75FGYvCXZ46l+8n/geHRlKQ8qzebsYpt4c5XClGuxdywfOqy7SUKddxNZSj3V8OfgLw2SyqwwaZEK0d/XwVAz2gIpydJOx6SqdXVAAQxpZkxvup/syoSPu3Q4GSl6kXRuUx9bSIE2AYa+smGlbpmDM32KrthaOaxyHSB1w1FZHVIpSTVV4wcpNGOBq+DA8WSS7ABbBHTjcQw5w9W9TT3mh3SgdL2sKMRKlAMbxDGcpFtKCr9VO3vU6uaNLZr6zNYBopaCdkNCRmQ9IUKgTLv10Xo9JrIQv9arXm1XdD3B0Rd5Y63OPM3MA/PaLGXiN7AHvbK0zbZLcJpX18pqMviAii4M8gdeetoPf5FHbpPV3PBUTLhlXMC76GgbsZ1DU7qNpV1195X+SHFzdzziW7RCHhopteR/Da76FGfGDcI3ayPEyVUChy17bCoHBPSz3znxP0gJ4/SCshJ9AgzEEHLcKufgQ+D1z3RX7uEk3XX4MAtoJA+POmuL11HQp77ERJ3B9odCW0nNgPlL8jKBT3D78tY7QjNXpwVxRyH9sATct/hqHkuOf+W/zSMRjJwcOXKqOeQ6VIMAqtYLNq5IziK04ynsAFIOCgvrc1Sr6iuJwV+6VbIzGDU8sA0qAVU9v2g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(31686004)(478600001)(86362001)(53546011)(36756003)(558084003)(38070700005)(6506007)(6486002)(71200400001)(38100700002)(31696002)(186003)(122000001)(2616005)(64756008)(4326008)(5660300002)(41300700001)(8676002)(6512007)(66446008)(316002)(66556008)(6916009)(66946007)(76116006)(91956017)(66476007)(54906003)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZEpDSngwMDNER1dvU21VU3hzZjNzczZaaUlTUGY3Rk1OV3czQ0V6d0Qxa2N2?=
 =?utf-8?B?UzRLckhKMmlEZEpWRDM2Q2Eya014ZU9wM09yNmxpRzZUSWZLSXUxZExHVHF2?=
 =?utf-8?B?WGRDUjNoeUI0WDhxamEvRFc5UHFCWmJ1RGxDYURNc3NvZldOSmxSN210T0tV?=
 =?utf-8?B?eFVseGNPMWNFL3RyZ1p1S1NPK0FpZHdhTTdrYW9TRWJUSGg3dGJwY1lpTi9K?=
 =?utf-8?B?NmpBZk9VUzRURTlVSHNkdy9Zcnp5SDBBS1g2UkFjWnNnU0lEaGdLWlp2SE1W?=
 =?utf-8?B?R1FLNXgzRnFsMzRjRHFIaTZEY2VtK2dKNVRBUFc1MmkvTXJWUGt2MmFlQ21E?=
 =?utf-8?B?ZE1BYTdrNGo2TW00UVp3Q0FOempaT0VZcWovaW5GV2p3TTRkZnJSNmptSm5N?=
 =?utf-8?B?Wjc3YmllTHl1UmpRTVB5VUpGbytVcnJWaU5QajVpMHdvWStmV2pOQWpsQTlC?=
 =?utf-8?B?cTZSUk5DTklGSWRzaENnWm1mU2NlUzVLamRnMjNjMkZFcGRWTno4VzNhdk1a?=
 =?utf-8?B?QVFYV2s2UE4vRmtrZjBRejlMWDl1WFpRRm5MbjB5M2RUWlQzZW1KVE0rdWVk?=
 =?utf-8?B?Z1krK0Y4Ty81N05VT3R0N0puQzdqSTdmd2FybWkwdnlQY0hvVE9pRVVmdStm?=
 =?utf-8?B?NDdrSXZYS1FSVlZzY29QVmxIZTF4dWE2ME1IYldMaHVmdzJKbDBEVzVuRWU3?=
 =?utf-8?B?OElONTA5aERIa2I1RTVIUEJ4YjFDSElnVzJBa0NncDZRbU40U1p5eUtid0lL?=
 =?utf-8?B?Z21EQm1tSUk1Wmp2Rks4UTR3R3A2Y0FuRGFGbGdXZzhXT1JCS2hEU2xZSXk5?=
 =?utf-8?B?dG1zbVJJeGp5SzZ5aDN3ejNycTRUNTByWWM3Q25VRHNYTllDVSswMXNMZG1N?=
 =?utf-8?B?eVprTnRqUVR3aTFsNUs4cG9SbHVFUzd1MkYzMzg3MWdDMml6SXFSdWJzNWpT?=
 =?utf-8?B?VjFyQXkzcHc2RFpVSjhBZUVHQ0pqWGt1UzlIM2tJVjBIWjlwcTJVMU0rR1lM?=
 =?utf-8?B?U2d3Y0NTODY5L1FmNE1GaFRNUU1CZjVWMzJPQUU2SWx6TnBnY1A0Yy83dk03?=
 =?utf-8?B?SFpyTEtFbTJScDIvOFRqcWo2R2NHT1pvZkZvdk1RdzZ5eDFGemg0cE5TT25J?=
 =?utf-8?B?d0prNld1TFpsTXBobkFkZDNYUklIc2VTUkhZZC9kY0RpSWpTRXpBZlc4L0kv?=
 =?utf-8?B?aGIyc2l2dnV1Yk9DaGxseS9kamRaNzhjQlhsVzhJY1BoSXlWUWx5ZGwrWmlJ?=
 =?utf-8?B?SjhDTmlKaWordGVwdzZDK3Q2cGU1d3AyMHpUMnJ2akxoSG1jaFRFN3FSYXBy?=
 =?utf-8?B?TE1Kc2tELzhWaVVMWVlxZStXMWpaL2RkYzRJOTVQY2xUMkVnUW1UbDVQcU15?=
 =?utf-8?B?MWpkRkw2ZGxqd3h1Qk9kbXEvTytOTGFDS3FsTG01Z01MaDFzMTJwalVHSkRq?=
 =?utf-8?B?MDc0eERKQ0VwM3IwcDAwMFYySXl6N1RDdU9RL3doTHFJaXVQNzkycnl6eHR3?=
 =?utf-8?B?U1B0cXowQ3NmQUpadjVxQnY4S3dEbmxvRlBaUi9VRk1GTWFUYnNTdDV2ZW5s?=
 =?utf-8?B?aVpEU0JLZ01lR25nRUp5dUs0bWZGRHZJWjVtdktLbjF6a2twRVpuK2w1NTBO?=
 =?utf-8?B?R0tqU3BMQlRNejVKQWxqT2hMMllKcUl1QndhRk1JY0ZyeGJtcVcyZ1NPZm9p?=
 =?utf-8?B?NzNmbFo5bFVwM25tQ01tVExuTUdqTDh5czJVYjRSZzU2UmxpWm9FMk5DOE91?=
 =?utf-8?B?Vjl2UVlla3VBUkZlLytUUldlaGtsZlJpRm4rT2Zkc0h1cHo4OHNJR0ZTZWNX?=
 =?utf-8?B?QkxjTmpwQ3NrbW80V05Wc1BiV3BuNGNZVGV1MnhlNWFGemVaRWlkVVRFODdm?=
 =?utf-8?B?NXlqd3RsTXpjNC9lY2toZHdyM21rYzVwbEdSZ0FUWGZnOTBDWENIQ09LMHRK?=
 =?utf-8?B?d0lFMzFMVE9GWm9QT1pxTDI2dk05TElPdVo0NU9OV2pUMWdqdlBtN04rOVpE?=
 =?utf-8?B?RjZMUUlxUC90b1l3Vmw5MzdvU3RHeFQxbDFRR3dCaWx3MTlWTG5Zc2FoaGwx?=
 =?utf-8?B?bUx0WExzaVpXQXZSOHpYcFEySHFDcFdSM0tSVGoxWENqcW5HUGRid3F0OWRh?=
 =?utf-8?B?OVAyVW5SK1lDQzBXMVBRL0Jield4ZFZlUk10U1orSDc4TnlzMm5TV0h1TDU3?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C99CDC54BC1AC4CA86E4B61BDAA9E97@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65da3428-c268-4236-2b55-08dad80243b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 03:22:26.3227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vA0+T2uWewnuLraM7x0pRGfA8hVuHxjkBnDA42A5Z8P+MspPHLyktI30/GrIrS0lti6uv3JSorvIJAbY3U+6pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_192232_289471_0EFEFB1B 
X-CRM114-Status: UNSURE (   8.66  )
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

T24gMTIvNi8yMiAwMDoxOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFueSBmdXJ0aGVy
IGNvbW1lbnRzPw0KDQpUaGlzIHNlcmllcyBsb29rcyBnb29kIHRvIG1lLCBJJ2xsIHJ1biB0aGUg
YmxrdGVzdHMgb25jZQ0KeW91IG1lcmdlIHRoaXMuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K

