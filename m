Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD248C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 04:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aKC5oR78WLHmxdPEqPg3cQ1taizuPsR/cZXDoXfIjIo=; b=MgjvTZYKXWrYRO6VpFX0MQMO+i
	RpdawA0+plrdWIvaion2HDx7C5PklyxLTq8NAlTh8c6p7Xipqjz+xPYzExD7lFoF80xr9hhdOAtGo
	akPJk8SUT/33uYfbyzOMr/6qfIQqP3ducUiEezh9UgDVP0bwS8Tv9Jj+MRpbdgqRJEr8EWmAb66HD
	mqUOr493WJK697jYnobZRF+EIsgvg9Ym+i/RkzcgWml7CX1oPtPMv7Cc+HPxGGiXLtkji9AKvNNkv
	jJkGWZEUZE/xL+OKbH3y2IfiVXN74H4nit6pUkboQb3+JF5EVOIVncHiUXhTS5KQokYCmXbi20xom
	yhsny18A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5JlI-00CH73-Fq; Wed, 14 Dec 2022 04:52:56 +0000
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5JlE-00CH3q-RQ
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 04:52:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1SYbFce7ew0/WzNh93LrqWLNM5ccXphg8eLYsH6aZNRy0i01vWT71gVM6gZPwT/0DJQ22NCZCbI12jJXI50MBfAj5RGnCR9aeDn8C520I3IYvXfBotJJS+4Pz4WmJoAEAEWf+JGhHG5BfsuyG5UoXeijM1dM5aO7tQzSTNjxOnvACu+ti0EwpZlE2t/UyyxWdmgFYlslwCvYHvT6t5IA0NbRTV/VqFs3MFJzXEEu6EszULCrQWle4MDYYCy7otAwz318yrNyTIla+upsqqZNJg/1ex7gfiLoiEM3W7KqMP8WqzlWuRms/VdTik8gmVKNTnc15Hsy4KI8rOSZpAgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKC5oR78WLHmxdPEqPg3cQ1taizuPsR/cZXDoXfIjIo=;
 b=lvHnSRQlYRr6IkQlwmhrJYdNRrRvq2zo2/W6mVBw16JYGKIn3t6D3VeppqCLxQO8yjeBcuBOyhlX/aAksXi3IVyVbUgW5hIHRPLYrOriImpL5bTulBnXUQhVZLtKQjgofnZVgnJtotQeBGX+LHAvLaYM80UqHw42yMjTNNV2BvvmXu0hpVzLMrqTJjJL7b/D2B6zYcHOzLkMcjSx/F8NBo6PdXVrsaLPbVKF0pLZztBi7NoPEMt2vt+CP21M/FZS7BfnDpM6/e4m54qDrWmJE8A8Ac9VFMZiZls5dwz8isXk+l92qvcHiflRUWVMGf+pPuDmmIw91xzs84FOcyABXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKC5oR78WLHmxdPEqPg3cQ1taizuPsR/cZXDoXfIjIo=;
 b=JOjlXmWJmHO3yWyfcOVerOmNVpkTIQ/7pwtTaC4PagGDhJH9fstu284OOwqeVD4tuZA/PmYcU+F/2wqn0XIatJOn5dTVT0w5dVGwVmAcjy21bDXlogCzmFtlA2Ohc6+RTG+BTDvIV6Mb4mQoGi7E/N0WfVocyid4PfxO98CPgMv7AMSNLOOWg1PvmhZg87/+sJ3aYSAPpWEoJr7bhVZEqNWD95uYmROsxRnOavewk1wpERv8+c/qd+hOnRnePHH5Jgj0zzV2tjftrtwtF0KOnldWXH0XHE78W2rZLnsV/7qCdrOu4voltWG/LArjdh/cybWABH6C1hm67yN5r+Xulw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 04:52:47 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.018; Wed, 14 Dec 2022
 04:52:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Kanchan Joshi <joshi.k@samsung.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/7] nvmet: allow async passthrough of commands that
 change logical block contents
Thread-Topic: [PATCH 3/7] nvmet: allow async passthrough of commands that
 change logical block contents
Thread-Index: AQHZDw93i0HXxfCgEEegkSt0XcHZFK5s0bIA
Date: Wed, 14 Dec 2022 04:52:47 +0000
Message-ID: <e80c7fdc-09b3-111f-d479-54ab49008679@nvidia.com>
References: <20221213162453.584965-1-hch@lst.de>
 <20221213162453.584965-4-hch@lst.de>
In-Reply-To: <20221213162453.584965-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW5PR12MB5597:EE_
x-ms-office365-filtering-correlation-id: 5c1a1849-0520-4716-f9ec-08dadd8f0bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  JV9sGP+20MfGcOYfYkboO35UbbkiUVGj74s+dZ6HS9L3JQ8v4NVudJfvf8HKw0c7q0pT8ktANh+eA9UXAJHMu5S36n6AB4pnMd7J4D7BFvbenJVizp/qtxmupSV0FB24moF6dB0U8tWUSRkEQ7m6VsuPj7dLMLwUx17bIg8JTRS4PUgKrOT1N270EHiC0kQDKSivmg7+8H6MYzoXFtAcnijjktEvQUob6bhAYAh8FXEIoMmABRekwoDadWHJ6F1Ieh99xNucCk4MGbqO7UbxGff4GTHLtuy8PUnRH1nZrkM7lroN0RxRgV9rcCJh5KQB9SdRxYWTvJSXJ+rVHnPCwPOmzgPvTCDMnZLIAabJw8ha7rA90aHtOVNORfTsRnXWjPxAOjrcNPxj1IY3+DOcy4d1UTcmmTtsWzSEpFz+GwyLhntMDpTcfedtMZkXiOA7R/zEFH77dZtdCF4VNKtoG1AqdRpd6p4ZWs9IVGMe8iBPLW3WdHgLxesAPLUddPTw9v0DayPFGWIVdOs1YfYpdE5djp0n1RUZVskKRk7Yw6xua6JRML/TX90NEgtt9QRsJc5rIY7x9HDe51Bd+KbcYJUo8QSsmNMKewgRVKbCFGhexoZmLO/tjAGctJqVJPfpG0bj5ZpMIJ1kA3PLC45c2owQ/FEEJ0wIzm0ZsrhErfRC4SgXehzOfl/M21HvzaRnFGVgmTDRhDl256AxzN9VFbXcaUlzqyTxyERo+OGWH2xRgRNrCA0vl1pwdqzr+t4Z49P/rJJ/B39gaeWigPFk4g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(76116006)(8676002)(66556008)(66446008)(66476007)(64756008)(91956017)(316002)(54906003)(5660300002)(4326008)(41300700001)(66946007)(36756003)(53546011)(8936002)(38100700002)(83380400001)(38070700005)(122000001)(6506007)(2616005)(478600001)(31696002)(186003)(71200400001)(6512007)(6486002)(110136005)(31686004)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?b3VjOEk4eStNc0o2dWdZdFhYTUduWUo4WjRSdURkSWNFMkZqSEFsMWNvdjNR?=
 =?utf-8?B?Mi8rMUVrbVdNMi85M3duU1FlaWJ3UnM1OHJVV20weXBvVzhCSEZvQXFlRXNk?=
 =?utf-8?B?RTVNUzQyaS9JcWw5OERSSzN5VW5TWDluL0FpZmZjUVN6K2dPais0QjBUNDEv?=
 =?utf-8?B?YUFuMDFOaHVqTlFycml1MEZzKzMxbjQwSU1YclRldTNJODRXbmtENDBoSHlT?=
 =?utf-8?B?a2xBNUk2V2dkcVlKOTZtR0ZidlpyODljQ3RVWUtLNEhEOWNwNFBZSnNWZ1JO?=
 =?utf-8?B?NFdzUWRLdXJENHhBRE5aRi92ejh4WnFmZGhGazdwSEp6NVRINnVaNG1XNW1S?=
 =?utf-8?B?UEJzNDVyaHRZUisxdTI1WmlmSDJqYU9KMVhZeFNLOElwVUZtZXlvcEZhWDFu?=
 =?utf-8?B?M1RFaS9ZUkV6MWsySjJ3UCtHRFM2NFJURUNEcE9nVWFpaFRaL0F5QkFURSty?=
 =?utf-8?B?cFRuMFduTktKb3RXNWQvTG9JL0pQa1R4TmF1SkkzU29rR2FHY1JBdkdGandW?=
 =?utf-8?B?RUtpLzFLaGt2R2dKS0d5SVd2STZCTlovY2ZiRjFoT2JjOC92bGlXYy9KM25B?=
 =?utf-8?B?WUYrM1RoY0xvQ1c3ZjhyRG9OTHd6aDh1ZzBKWXVXU0xxdm1MeTdWOEkxWnJz?=
 =?utf-8?B?cXFnT0wxd1RYOVFoakNaTXZWdWlxaENicVdHeGZrVmpaeG1EMUdiUGRwRmVL?=
 =?utf-8?B?Q0N0VXhVclU1K3l1TWMvWFdJanl4dzN2RWFmWlFMR29tYzgzYUNwTzBHRWlB?=
 =?utf-8?B?Q0pjanNzVmlpYW1PcDFXb1I4RG9lNE40Q1lVM0RjOC9oa1pQb2ZrMERtdzJT?=
 =?utf-8?B?NjBlYkRJZlI3ODBXUnVIMjZsRlE0c2k5elVST3lDYnh1RTNPOGpMWkxBelh1?=
 =?utf-8?B?Tmt3cno5bFVNRjhrTmtlY3ZTMHpjVll0VzJjbWxDQkRKeHVTZWZZTnNzTXRG?=
 =?utf-8?B?anZHNnFNRmlYTXpSL1ArUWRNUW1DS2l3TGdEUitmOXdueHpvM1RHTDZFNlpX?=
 =?utf-8?B?K3ZYSExqeCtaU0RYR3oyMDBTQmVsVjVFL1BEbVdhb05UMyswNlVxNkpiT0o0?=
 =?utf-8?B?MHYrSHJYQWZOaTNnN0wwYmphRkFPZFI2Q2g3bnlMRVJuSTVBSVZNMEVZbUpO?=
 =?utf-8?B?Q3o1R3VPR1ZlVUVHOFNhRm8xa3Y4MW56VHZiVEZnYUMwNktBY2E5cThlOHl0?=
 =?utf-8?B?a2xoaEJNb2F3b05KUUJVRGNCSzhUK2d2ZG9KZDZEblQ5RktjTDlqUG9XQTZu?=
 =?utf-8?B?RzNsQ2xaUCs0NzBFTGhDMzlXdUpvRlpXS1NYdmE0SWlEYk9nKzV1QTF0eGlW?=
 =?utf-8?B?dWV1clp2dUxmTDNKNDM1R0pXR29TY2I1dUJHNVV6T3ZKa2UwUUhyN2lTekxJ?=
 =?utf-8?B?UHlrOGx1WWEySVEyRENyRmdTd2RXVjMybmVqSWpiRG9TbXNDdlcyWm1sQU5J?=
 =?utf-8?B?cmlmeUtEeFdlc3pvVk5vM1hGOWVaYnVLdXFSMnUxbmk4L3U0UUR2QlN1UDFX?=
 =?utf-8?B?Sm9LVVVhSkNGMEs2amxzT0RqWndORXI5Y0gxbVJVOFVPOGZseElrZkFCd0lo?=
 =?utf-8?B?Ujl4RGk4YjJIL0NjcGkxdU45VTVGajBIWVppSEtIOWZHRGRIeEUrbFdYQUY5?=
 =?utf-8?B?OHJxamtZQkIzM1ZFL1E1U3hSeDRhUDRsaTEvUjcvY2VuQ0R1UTVxenJJVlJ3?=
 =?utf-8?B?T2pEUDVxNXExY2NqK1o0WWpFbndQWXlpTEhObTdKMVVVanQzbXV2Qm5CaUtl?=
 =?utf-8?B?QWxMZmpoMlM5U3RGUGlWV2ZnSVo3YnFBQmVOR1hURHhJYlkzY3lzZ3NzM3JK?=
 =?utf-8?B?K3NqeTROODVqejRmcitFK3Z3YUhrZDVraHdwWTVLZWZBUnptYm11eW1SMUw5?=
 =?utf-8?B?ZXRkVDhNNUZNem04dGVHbUJYZEpEU2RabVdoYmFMREdyNmZmcisrWnQrTU9P?=
 =?utf-8?B?NTdHZ09tUG5qUE0zYVROOEFpK29qSkdqSjFKZmVPS29zWGVQZU8zeVMzWHUw?=
 =?utf-8?B?Z21mL09QWHVCbTdpSDZMbnhEM0V2eTg3UzY2dC9Pc3A4SVVQTmlWMGk1Q0cx?=
 =?utf-8?B?ck9BRUpUcXM0Q3RwVUhNY2lSUHpVR0pvVFlMQUIrMHBydVRoRk5mY1FaSGlK?=
 =?utf-8?B?VEhCTUVQM1Azd1Rob0VpVFRGMlB5UmdzYUx1QW5MK2ZMcEY4SjVpaFlvbGhP?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F814ECE2FE50C488C164E2BDBFB76F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1a1849-0520-4716-f9ec-08dadd8f0bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 04:52:47.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/6H6UhhhuI7Vc53ohK6knkMHeS+DEU4qSG15FdxNbvFsRI7vEs+qO5iD9vHBN5RRrBxr+riIYEOVYLbFUp9Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_205252_981316_3A481F46 
X-CRM114-Status: GOOD (  23.86  )
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

T24gMTIvMTMvMjIgMDg6MjQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBNYXNrIG91dCB0
aGUgbG9naWNhbCBibG9jayBjaGFuZ2UgZWZmZWN0IHRvIGFsbG93IHRvIGtlZXAgc3VwcG9ydGlu
Zw0KPiBwYXNzdGhyb3VnaCBmb3IgV3JpdGUgY29tbWFuZHMgb25jZSBJL08gQ29tbWFuZCBlZmZl
Y3RzIGFyZSBwcm9wZXJseQ0KPiBwcm9wYWdhdGVkLg0KPiANCj4gRml4ZXM6IGMxZmVmNzNmNzkz
YiAoIm52bWV0OiBhZGQgcGFzc3RocnUgY29kZSB0byBwcm9jZXNzIGNvbW1hbmRzIikNCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvbnZtZS90YXJnZXQvcGFzc3RocnUuYyB8IDE3ICsrKysrKysrKy0tLS0tLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMgYi9kcml2ZXJzL252bWUv
dGFyZ2V0L3Bhc3N0aHJ1LmMNCj4gaW5kZXggNzlhZjUxNDBhZjhiZmUuLmFkODBiYTYxYzQyMjM2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCj4gKysrIGIv
ZHJpdmVycy9udm1lL3RhcmdldC9wYXNzdGhydS5jDQo+IEBAIC0yOTUsNyArMjk1LDYgQEAgc3Rh
dGljIHZvaWQgbnZtZXRfcGFzc3RocnVfZXhlY3V0ZV9jbWQoc3RydWN0IG52bWV0X3JlcSAqcmVx
KQ0KPiAgIAlzdHJ1Y3QgbnZtZV9ucyAqbnMgPSBOVUxMOw0KPiAgIAlzdHJ1Y3QgcmVxdWVzdCAq
cnEgPSBOVUxMOw0KPiAgIAl1bnNpZ25lZCBpbnQgdGltZW91dDsNCj4gLQl1MzIgZWZmZWN0czsN
Cj4gICAJdTE2IHN0YXR1czsNCj4gICAJaW50IHJldDsNCj4gICANCj4gQEAgLTMzNCwxNCArMzMz
LDE2IEBAIHN0YXRpYyB2b2lkIG52bWV0X3Bhc3N0aHJ1X2V4ZWN1dGVfY21kKHN0cnVjdCBudm1l
dF9yZXEgKnJlcSkNCj4gICAJfQ0KPiAgIA0KPiAgIAkvKg0KPiAtCSAqIElmIHRoZXJlIGFyZSBl
ZmZlY3RzIGZvciB0aGUgY29tbWFuZCB3ZSBhcmUgYWJvdXQgdG8gZXhlY3V0ZSwgb3INCj4gLQkg
KiBhbiBlbmRfcmVxIGZ1bmN0aW9uIHdlIG5lZWQgdG8gdXNlIG52bWVfZXhlY3V0ZV9wYXNzdGhy
dV9ycSgpDQo+IC0JICogc3luY2hyb25vdXNseSBpbiBhIHdvcmsgaXRlbSBzZWVpbmcgdGhlIGVu
ZF9yZXEgZnVuY3Rpb24gYW5kDQo+IC0JICogbnZtZV9wYXNzdGhydV9lbmQoKSBjYW4ndCBiZSBj
YWxsZWQgaW4gdGhlIHJlcXVlc3QgZG9uZSBjYWxsYmFjaw0KPiAtCSAqIHdoaWNoIGlzIHR5cGlj
YWxseSBpbiBpbnRlcnJ1cHQgY29udGV4dC4NCj4gKwkgKiBJZiB0aGVyZSBhcmUgYW55IG5vbi10
cml2aWFsIGVmZmVjdHMgZm9yIHRoZSBjb21tYW5kIHdlIGFyZSBhYm91dCB0bw0KPiArCSAqIGV4
ZWN1dGUsIGNhbGwgbnZtZV9leGVjdXRlX3Bhc3N0aHJ1X3JxIGluIGEgd29ya3F1ZXVlLCBzbyB0
aGF0IHRoZQ0KPiArCSAqIGVmZmVjdHMgY2FuIGJlIHByb3Blcmx5IGhhbmRsZWQgYnkgdGhlIGNh
bGxzIHRvIG52bWVfcGFzc3RocnVfc3RhcnQNCj4gKwkgKiBhbmQgbnZtZV9wYXNzdGhydV9lbmQu
DQo+ICAgCSAqLw0KPiAtCWVmZmVjdHMgPSBudm1lX2NvbW1hbmRfZWZmZWN0cyhjdHJsLCBucywg
cmVxLT5jbWQtPmNvbW1vbi5vcGNvZGUpOw0KPiAtCWlmIChyZXEtPnAudXNlX3dvcmtxdWV1ZSB8
fCBlZmZlY3RzKSB7DQo+ICsJaWYgKG52bWVfY29tbWFuZF9lZmZlY3RzKGN0cmwsIG5zLCByZXEt
PmNtZC0+Y29tbW9uLm9wY29kZSkgJg0KPiArCSAgICB+TlZNRV9DTURfRUZGRUNUU19MQkNDKQ0K
PiArCQlyZXEtPnAudXNlX3dvcmtxdWV1ZSA9IHRydWU7DQo+ICsNCg0KSG93IGFib3V0IHRoaXMg
aW5zdGVhZCBvZiBjYWxsaW5nIGZ1bmN0aW9uIGluIGlmIHdoaWNoIGlzIG11Y2ggY2xlYW5lcg0K
dW5sZXNzIGl0IGhhcyBhIGJ1ZyA/DQoNCmVmZmVjdCA9IG52bWVfY29tbWFuZF9lZmZlY3RzKGN0
cmwsIG5zLCByZXEtPmNtZC0+Y29tbW9uLm9wY29kZSk7IA0KDQpyZXEtPnAudXNlX3dvcmtxdWV1
ZSA9IGVmZmV0Y3MgJiB+TlZNRV9DTURfRUZGRUNUU19MQkNDOw0KDQppcnJlc3BlY3RpdmUgb2Yg
dGhhdCwgbG9va3MgZ29vZCA6LQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==

