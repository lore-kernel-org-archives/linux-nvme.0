Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E08DC3DA7D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 00:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h09LchcnvodGHkaThnG7NVLDZLkqnirIot/Rzz5bJHA=; b=OZvcHsf303RXV2BhaScPV9IICE
	8Gif6AlLOQu0Stofy5Ymel/Po+oInbUMWSwtlPp9Miw8yCwAhbCg7+FLVn1t5nRPdii1h9UxlSSVE
	v3E2Ic1WSL3BJ0G83VlzwYsZO8e0wioX3s8q7MX5+jouo41TGebSRZAmpkodH8LQd5TtIOjqNBReq
	m/TdT34YZnHhrP3MiXEobo3Lz7dhWQnZUYGNS3IvXkNNkHQfbS0Bx9G221U14yrQgwR8LIvki/csU
	x+8xMpOg9UobaQF9JmqqpUY77+wqos9mJeZ+GTJMwSMBxRyyHas1kxz6hgKfNGY3IUpeWM+IGiXPM
	BV5KeAEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCraG-005q65-HH; Wed, 04 Jan 2023 00:24:44 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCra4-005q2Y-Ew
	for linux-nvme@lists.infradead.org; Wed, 04 Jan 2023 00:24:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8aPyBVs4hDlPLTvxay61obJyu+1MLx/1iO9ldssDnDoufMScvtO9hMqMqOcs0cVL5O0uPvkXjU4qUuqFFxiDW+oeT6JZoP7m/DwqwrGpQ/P8C7/OC1aMxBVONhYkFkAaUgxVhyGe36o8MVd+4HSSGwBJDtHOENwXoINA5fwkJFTAZvaWgmHRFXL/M1EZB1Pywn181OS9Jh9ju9TFMSO0WVnwaprS1uqtDybsvH0dTwr4GA5GOV5dTF3bsTe0WC+Zm3He/qjFF2DaZY+qmVeH7k/Uu+BMS9eUMMtX1OrbnHChiFarQ+R6cSskmOtLo0WAnIaXDVZyLn5Q3QnrIJE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h09LchcnvodGHkaThnG7NVLDZLkqnirIot/Rzz5bJHA=;
 b=cLJkrQgZwW5RXh/ChcHMhJfdl3tLB6vRRFnqh+I+gX8+5EvNMpyz4DxEHpJ+9sQj1y3kHykNhJmF6hBuDEU7TeNw/kNDSWk1RIYZK9sEHfOeUhN7S7Wsfv//TlW1vKbIA5eKpPBipCXcxRnc8RCHT1JMdubGR1L5wASmIhWfY2KoA51BZQ5qwSCQxKxbzcvXur+3pvURwLFOQoSGA4+FPDfSA4SD4dXbhdcDedw5Y2P2AHXjRz4/NB81xTxE7rUxD3X3T2WYhR6uiD78O+FORCDIiAAATi627RJo/Qu/WqeXLaDpP0ZEuf4Ox6erYe9w927Ms6tddeW5WLLcVxxKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h09LchcnvodGHkaThnG7NVLDZLkqnirIot/Rzz5bJHA=;
 b=GDl/jl6z5vyhwJgxrSWmGJh0WdVvppB1GP8NUMga+CURKXULk8HEwbedZC74pvGFXHK915WC086MX77VOsD3cCiSt8XJInil/S9c9iXsMliub8OcX74xxVVCYlqocYi4ZIJBHu3nZ2dRD+GQRBOuhGlZUVNNwDskAusoz4aLYEIGGnflstV3AGeJT/Yp2PYuX70MsJasAy4ZfioGtr5VJ9WxCM1qYzqXZQn95fikDAweuiej1mwoGFBLOUsvxVasGlvG7a9FOgNRdIrp+zbHihen3M3uV+xwmff2EfSRBQRXalnDOgxJ3WiTj+j0biW/kkY0U6+DNax8F7oZZNV+hA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:24:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:24:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Taehee Yoo <ap420073@gmail.com>
CC: "james.p.freyensee@intel.com" <james.p.freyensee@intel.com>, "hch@lst.de"
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"ming.l@ssi.samsung.com" <ming.l@ssi.samsung.com>,
	"larrystevenwise@gmail.com" <larrystevenwise@gmail.com>,
	"anthony.j.knapp@intel.com" <anthony.j.knapp@intel.com>,
	"pizhenwei@bytedance.com" <pizhenwei@bytedance.com>, Sagi Grimberg
	<sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/4] nvme: fix delete uninitialized controller
Thread-Topic: [PATCH 1/4] nvme: fix delete uninitialized controller
Thread-Index: AQHZH1rHEeMxqm+BK0uZ5GYiebwHX66MfiqAgADo7IA=
Date: Wed, 4 Jan 2023 00:24:25 +0000
Message-ID: <af53be64-4ed3-96ea-7700-ac8f0cc8de6b@nvidia.com>
References: <20230103100357.875854-1-ap420073@gmail.com>
 <20230103100357.875854-2-ap420073@gmail.com>
 <b6b16a5a-d592-eb12-ea30-1535b80d60dc@grimberg.me>
In-Reply-To: <b6b16a5a-d592-eb12-ea30-1535b80d60dc@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH8PR12MB6770:EE_
x-ms-office365-filtering-correlation-id: 8e5a00d7-5de3-4e3e-1a03-08daedea08fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  cHUqUFMe4iwAv2XbSJD9e6lyRVNtT5ubpnOdFdZFhGLFXE1+BLE4BjuKnwtPvSoE/C3S3Xlur6OrWwy+PleVoL2AVMfvGGGL6jY9P73PWYEj0I28UUl+feutFSuwXWdEaJd6w4w3ehB8YlMOcgGaEb/rs1e6Lpi3J4sl84CTMAqv00BJ1T/u7lM+GCdEM11lW0wF41rq4JTQNJNlbLmLMPoA5dC5vLkHPo7c5VKI0073ZjHuJLcmpQG2ApHNVAdYqAWozu8wUmla0Vlp1mt5YrZMOyV9/ZiFURhUEtecOjN0a9WpKmCTrOp6cqrHyJP9Sr4EyNVQAGggIZ8YP0vNz8nE10s9bjebwyMgv4A1IRxpvGetZ6n4Xbzn4yM6QQ3BO79HONm/4haHhmpgc6+biTD9gqGfD+ossnpQjw37E7PDcmk8+xqyDm1ULMTkJbhqkfc9eucGg1LaoMAh/Qu4ROU0l+8tQub13gU8krlSNzGNstjWIpid2RHQnD8hqtaSAPbw4+x8/FbTMNVtYVTwAuG9yLs/BUUM8D6j10bNceYLaC/zOHmyQ/RQdBJx+zqkRsU0P0rSIzxi9lrdgzQ7R1CVfvJ7PQD9joLBTw5ELKbPFag7RMMUVW2YNOrStDtqnSf+KnXpgJZTxdQVBb4KwwVYlE7wgtKMJDAUt9xyJ9NpfSAn5yGiFSjcGq5ustC2MBvpz/DM37lEsOtqVLsMKo0Nn7Xi+s3Yo+ThdAjR21gCv9YxFqWa36JTK7XiYONrltm9T+OUP+htIEH9G+AJhg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(36756003)(8936002)(38100700002)(122000001)(41300700001)(7416002)(5660300002)(38070700005)(2906002)(83380400001)(86362001)(31696002)(71200400001)(6916009)(54906003)(31686004)(76116006)(6486002)(66946007)(107886003)(6506007)(53546011)(4326008)(91956017)(66446008)(66476007)(66556008)(8676002)(478600001)(64756008)(2616005)(6512007)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SEVuUVBJWkdIM29aR3JjaEFTTTdmS2F2TFNQRWFQVHJQQlcxK1hHZ2pZb29N?=
 =?utf-8?B?V2dEV3VNTHhGZTBZVjJUOTlFcDUxek9HQUhETm1ldS94ZmR6SWJtR2pJcjlp?=
 =?utf-8?B?SEdTZkwwSW9FTTFlQzRuSEtSMUI3UGZUQ3NSUHpFZ2Q5SXpKOXVmMXN3QUNa?=
 =?utf-8?B?ajhXMVlZY3pPcGZ1YkduMzRxYVNIRW1qK290UVBSYkFCTXZSUm5xS3IrUVh0?=
 =?utf-8?B?b25CY3hnUlhqUGlXVHBjZktFSEZmYlhQakQ5amtLL1IzdmdOeUhEYmJBMzFV?=
 =?utf-8?B?bnFTT3BrVzR6QkR4UXhVZU9zL0NvU25KbHRCV0FRVmhrcnFUdmNEVnN6U052?=
 =?utf-8?B?MTF2SDl6S2VCc2VPZFJBa0F1b3V6Njc2ZVBWeW9GNWRiL2VkS1hQWm0xUXFs?=
 =?utf-8?B?cS9CUzBmV2pwWjZvM25EZHRaQTRFRnNSbzJrcW1GNlM2dkVPQUNkS2tHRjVF?=
 =?utf-8?B?eXJXdU5ZVXJjcGhpc3JRWWJwcDMwMnJTWk93UkUveko1SldzZUpRZEhxcG93?=
 =?utf-8?B?MitiSHVYbjV2NmFacnN0dGx6ZlBMYzNIeGZPUkxrU3k3Z1dXRXFSYnJVT3l0?=
 =?utf-8?B?aXRqbW4yTk5ORU1pZFJaZEZHZ2UyamdRclRkOE9mN1RDQVpPWS8zQUZqNmwv?=
 =?utf-8?B?MnlZYnY2NUozc1BzdHgzMEpaZUJnZythY055cm1MSFlWbnRadXViaFB3VWpT?=
 =?utf-8?B?SWlkYTlyTnltclRQZEN6MHVMMXB2ZHVKRzlRNUFPMUlTR1g0c3grK3BCZUdk?=
 =?utf-8?B?Y2VPWnFHS3pLSEtER21SdTRYWmcwU0VienBXZ3ZwSHlWODVheUlWSE5uVklq?=
 =?utf-8?B?VFZTWi9DOXdjSFVPZlNZeFhSekxZR2JmejY4dHBTVlFYZ3M2dGNNOHQ5SVB5?=
 =?utf-8?B?N0hvdEhCU0UzRmpKNWY1RkJSWERQaWxzbWpVL3IyMFNtK1NSd1pZL2hVVlQz?=
 =?utf-8?B?TlFMY2U1Q2NTM2pzdWU1QW84M2RqU3BiNEFna0VpK0N4VnZGdXhEU2sxbGFD?=
 =?utf-8?B?THlyWW1IcGptdzNLZUExZGRmQUI3dnUyV09KMjB4L01ENDNXOGlQMEloTEQ4?=
 =?utf-8?B?bzhPTzhWU01CVHJjNzQ3UlFIQlFOZzNqYmRCWENzQ2h2R0lLS0tmcFByR3VX?=
 =?utf-8?B?bDFvUTF0aWRLTXNDMHBoRWhZR3VzWkNsTG9EVVRtUVN5K1dsZjBUQ0F6bzZW?=
 =?utf-8?B?NjJGelBxcWo3dy9kcTg2NXcvZFVxcUpNdVc5UE9uN2pvTjdSbzFjb2NEMEhS?=
 =?utf-8?B?OVp4TldnWkZPZjA5SWMxMW1tdTJvdjl0bkpEZTZWU2dZQk5SU3lQbWVtZEdU?=
 =?utf-8?B?RE92U1JOOGhnQm9SY3QvVnlma0dMYnB4SUprZEFPbzJrTE1waWNTeWlLR01Q?=
 =?utf-8?B?SnBsNm96RFZFU1pWSnI4TGFWQjdRWUgvTXpjUDhKRk83YXNVNGZKU2cvYWlY?=
 =?utf-8?B?YlJIZTR3czQ2MUpZV2lxb0R2VjlEb0MvWEhadVhlZEhhMitQLzdTSU5WdGhG?=
 =?utf-8?B?Q1Vmc3hyQi9lcHp2UGwvL2NkODRNT01uaURmTFhhR1Zlc0crT0dkcHhzSTNP?=
 =?utf-8?B?dVRGSWwwU0pYQ011ZWNSdG1oeDNib1pLRDRGb0pvcWIvd2N6QUt2dnV4WGRC?=
 =?utf-8?B?QzNKZWZUQ0hKTmt3YWdZdW42dWxoZ2lMeW5GTjRyeGQ3TWI1TjI1Nzg0RFlZ?=
 =?utf-8?B?ZXZFN3dFby9ObFJUbm55SFJ0ckVmSUY4VWx2RWF5blM3MWczd0pZWEFidWdv?=
 =?utf-8?B?TGM4dU5XQkVIdlEwdEFJR3ZMbzBWc3pqd282UkZpWTF4alJoMkx0UjB1SWxV?=
 =?utf-8?B?enVXNlNlZ3llb1Rza2l0S3dlazljQ1VJbVQxRWdRWFBYUEs0bXJHTlJOQ3dQ?=
 =?utf-8?B?NVg5MTlIcTRwaFJLOTc4RThEcE93RVNPcXdtYlVrbStZNjI4ckJBRDFHUUxn?=
 =?utf-8?B?Q2hyRnE0SUZHT2FqRlZ0Q0NYVURnQnlKeWkxR0dNWTdmNEFVQituVmt5Y0FV?=
 =?utf-8?B?QnY2bS91UGdWc0d6dWM0dTM5MU00N1IvK3I5cnM0c0NqajRJTWV5RWZQRVRZ?=
 =?utf-8?B?OFcwVGswMWREK1ZHZzhLbkcrQ2Z0c2hwcGVENEl1S2o1UEdzT0lhbVNOby9P?=
 =?utf-8?B?RW9JT0kvZ0MrYlVoNGxkbU5jTUtkeWhobWRsWEtRSHptQmhZOG5CUDVoU3RL?=
 =?utf-8?Q?vmnSnx/BvVEYLyD3/3rZhFX2Y48lqV27NnvfkdxioS7S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CE90B7EBDA77F48BC53E27FBDF878CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5a00d7-5de3-4e3e-1a03-08daedea08fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 00:24:25.4747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTfpeCiTiiRsOeYwhLwRzoyrl9rQaRluYTzQP8nEPektpPonHE6czQFHU14W95+qp6lkjXL667wfeFP0f11xtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_162432_816929_DD24F49E 
X-CRM114-Status: GOOD (  20.08  )
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

T24gMS8zLzIzIDAyOjMwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPj4gbnZtZS1mYWJyaWMgY29u
dHJvbGxlcnMgY2FuIGJlIGRlbGV0ZWQgYnkNCj4+IC9zeXMvY2xhc3MvbnZtZS9udm1lPE5TPi9k
ZWxldGVfY29udHJvbGxlcg0KPj4gZWNobyAxID4gL3N5cy9jbGFzcy9udm1lL252bWU8TlM+L2Rl
bGV0ZV9jb250cm9sbGVyDQo+PiBUaGUgYWJvdmUgY29tbWFuZCB3aWxsIGNhbGwgbnZtZV9kZWxl
dGVfY3RybF9zeW5jKCkuDQo+PiBUaGlzIGZ1bmN0aW9uIGludGVybmFsbHkgdHJpZXMgdG8gY2hh
bmdlIGN0cmwtPnN0YXRlIHRvIA0KPj4gTlZNRV9DVFJMX0RFTEVUSU5HLg0KPj4gTlZNRV9DVFJM
X0xJVkUsIE5WTUVfQ1RSTF9SRVNFVFRJTkcsIGFuZCBOVk1FX0NUUkxfQ09OTkVDVElORyBzdGF0
ZXMgY2FuDQo+PiBiZSBjaGFuZ2VkIHRvIE5WTUVfQ1RSTF9ERUxFVElORy4NCj4+IElmIHRoZSBz
dGF0ZSBpcyBzdWNjZXNzZnVsbHkgY2hhbmdlZCwgbnZtZV9kb19kZWxldGVfY3RybCgpIGlzIGNh
bGxlZCwNCj4+IHdoaWNoIGlzIHRoZSBhY3R1YWwgZGVsZXRlIGxvZ2ljIG9mIGNvbnRyb2xsZXIu
DQo+Pg0KPj4gY29udHJvbGxlciBpbml0aWFsaXphdGlvbiBsb2dpYyBjaGFuZ2VzIGN0cmwtPnN0
YXRlLg0KPj4gTkVXIC0+IENPTk5FQ1RJTkcgLT4gTElWRS4NCj4+IE5WTUVfQ1RSTF9DT05ORUNU
SU5HIHN0YXRlIGRvZXNuJ3QgZW5zdXJlIHRoYXQgaW5pdGlhbGl6YXRpb24gaXMgZG9uZS4NCj4+
DQo+PiBTbywgZGVsZXRlIGxvZ2ljIGNhbiBiZSBjYWxsZWQgYmVmb3JlIHRoZSBmaW5pc2ggb2Yg
Y29udHJvbGxlcg0KPj4gaW5pdGlhbGl6YXRpb24uDQo+PiBTbyBrZXJuZWwgcGFuaWMgd291bGQg
b2NjdXIgYmVjYXVzZSBudm1lX2RvX2RlbGV0ZV9jdHJsKCkgZGVyZWZlcmVuY2VzDQo+PiB1bmlu
aXRpYWxpemVkIHZhbHVlcy4NCg0KdGhhbmtzIGZvciBkaXNjb3ZlcmluZyB0aGlzLCBkbyB5b3Ug
cGVyaGFwcyBoYXZlIHNlcXVlbmNlIG9mIGNvbW1hbmRzIHRvDQpyZXByb2R1Y2UgdGhpcyA/DQoN
ClsuLi5dDQoNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4gQEAgLTI0Myw3
ICsyNDMsOCBAQCBzdGF0aWMgdm9pZCBudm1lX2RlbGV0ZV9jdHJsX3N5bmMoc3RydWN0IG52bWVf
Y3RybCANCj4+ICpjdHJsKQ0KPj4gwqDCoMKgwqDCoMKgICogc2luY2UgLT5kZWxldGVfY3RybCBj
YW4gZnJlZSB0aGUgY29udHJvbGxlci4NCj4+IMKgwqDCoMKgwqDCoCAqLw0KPj4gwqDCoMKgwqDC
oCBudm1lX2dldF9jdHJsKGN0cmwpOw0KPj4gLcKgwqDCoCBpZiAobnZtZV9jaGFuZ2VfY3RybF9z
dGF0ZShjdHJsLCBOVk1FX0NUUkxfREVMRVRJTkcpKQ0KPj4gK8KgwqDCoCBpZiAodGVzdF9iaXQo
TlZNRV9DVFJMX1NUQVJURURfT05DRSwgJmN0cmwtPmZsYWdzKSAmJg0KPj4gK8KgwqDCoMKgwqDC
oMKgIG52bWVfY2hhbmdlX2N0cmxfc3RhdGUoY3RybCwgTlZNRV9DVFJMX0RFTEVUSU5HKSkNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBudm1lX2RvX2RlbGV0ZV9jdHJsKGN0cmwpOw0KPiANCj4gU28g
d2hhdCBpcyB0aGUgb3V0Y29tZSBub3c/IGlmIHRoZSBjb250cm9sbGVyIGtlcHQgb24gZGFuZ2xp
bmc/IHdoYXQNCj4gdHJpZ2dlcnMgdGhlIGNvbnRyb2xsZXIgZGVsZXRpb24/DQo+IA0KPj4gwqDC
oMKgwqDCoCBudm1lX3B1dF9jdHJsKGN0cmwpOw0KPj4gwqAgfQ0KPiANCj4gSSBkb24ndCB0aGlu
ayB0aGlzIGlzIHRoZSBjb3JyZWN0IGFwcHJvYWNoLg0KPiB0aGUgZGVsZXRlIHNob3VsZCBmdWxs
eSBmZW5jZSB0aGUgaW5pdGlhbGl6YXRpb24gYW5kIHRoZW4gZGVsZXRlDQo+IHRoZSBjb250cm9s
bGVyLg0KPiANCj4gSW4gdGhpcyBjYXNlLCB0aGUgdHJhbnNwb3J0IGRyaXZlciBzaG91bGQgbm90
IHF1aWVzY2UgYSBub24tZXhpc3RlbnQNCj4gcXVldWUuDQo+IA0KPiBJZiBmdXJ0aGVyIHN5bmNo
cm9uaXphdGlvbiBpcyBuZWVkZWQsIHRoZW4gaXQgc2hvdWxkIGJlIGFkZGVkIHNvIHRoYXQNCj4g
ZGVsZXRlIHdpbGwgZnVsbHkgZmVuY2UgdGhlIGluaXRpYWxpemF0aW9uLg0KDQphcyBzdGF0ZWQg
aGVyZSBJJ2QgYWRkIGNvbXBsZXRlIGZlbmNpbmcgZm9yIHRoZSBpbml0aWFsaXphdGlvbiBhbmQN
CmRlbGV0ZSB0cmFuc2l0aW9uIC4uDQoNCi1jaw0KDQo=

