Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C32C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m6bTRy33AgeyXbYoo//BRHjNgf+oqdllD8TAF1QkLik=; b=jpxdNCb4QdqiXP5/gPLDZW12+8
	jjLZh8Ye8SyacVvsNtcU3px0et7/WFc2uIZYrz0mMyWRDD8xddhwqmExuYhtGDEDtydJNykRgZxG0
	uoyAEC53UHAc65cIwKOCSqshCuPOfERAExqiuuyJdEP8amEr+Q6DfAGAqArfcYrmlHXAq8UgWRHYi
	dHpbta/QZXiBob4rs8FGO6cDiZ9tqeCpDzPBiQpC9oW195fvnHg22LuAoxtjnksef3w3E3Jj7ZcPF
	g8g6o6Kfn56Sc0dByznHupr8SA+2F2+6pSdniiObOfMMII1P3f+JTawGwmPEcurOZRkCOuw4cRSX9
	KXRvoc2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPOs-0000000CKHc-3066;
	Mon, 29 Jan 2024 11:02:02 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPOp-0000000CKGi-3qWh
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 11:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrD6r6fqBtupbaRRbLsz3+OXyycD0lklCHIYKwV61hZ+6vXN581zwCNh1kDwH7I/NQLc1C5utOXivvs2mX4wnUjZHjKy/cBzNZBvOFqnuJrVhiKiUho6T1QgwhAmsWXAlWGmn7Fr/4beSEswU1vc893vrFfFAQd2dVbvqN2CU7XQnNqD3FRb5j/QoZ6VVzNLNONKTXib8goo2jkX5kko382tc8bYfvrOjXaHg/u3110ZYwE2K9PK5iHG7prmC6P7hfaLpULLGW4Ro9SBDCICBoeGrylO7tEyck6cnIXo6BQ8mAkGUjrbeFI+g71zWidumzZuCIObTtqUk/x0r9f6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6bTRy33AgeyXbYoo//BRHjNgf+oqdllD8TAF1QkLik=;
 b=KRE8QD7k/lK14FgWgkX7KlKvuYujsorIixEevFGgcgXs8t/l+dpUTh2CbtuP/y1NpF3nDYgM0bpQKZfNBR8EHzsoDOK1uACchPnOBD9471qoP6nZ15Y4W5KZMoN4gKJwH5xogn7RlpTSlBsU5+Bu2/Q6b7o4w9N847TNPFStFkWMZe9Js0zTK6Uuwc3kmAXC4JyyHd8OZxAukF9pAU417FpdlBOpKdt/lGZwyM/wCkbZlhxa2K9ytcECe41RqD4ghsvpMtlqlRC1AYWYRexAQFlzlWU0ghBXs1Knu/QgzF1lEF5lMSMvpzYZ7iQ8vlRAZKdXqcYGLli4O4KFjB7PyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6bTRy33AgeyXbYoo//BRHjNgf+oqdllD8TAF1QkLik=;
 b=VSLYx6dz/ayTP9mqGxJppDgPPRmmLLoPY79tIwpSWdIdXKZJaaIZO9/YYUlOtkb13PTuV9IASlwmlUnFyhJ1pI1JffkPayeF2bwN/HpPiPT4dr5HnisijIHpaTXGsEvDENWVaABFnCb42PgY/2NsteS4T6if/Nk69BUD86HUReDkUYr+EQe5qDcm7qoelATefJrcA2uRXNjrH9exuOtfPNUgRgcQPkw/HReqsNh3b7cp7+ffsVVDn/H96RlW0SlaeAecPcaHIZBSNBCjPNGz3YYPxPBYtjfBNeOC9sWxf55zt+s5W00jezkrAKs5D2qj4pJZLqUP521I3W/UC3I1Kg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 11:01:55 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 11:01:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme: parse format command's lbafu when tracing
Thread-Topic: [PATCH 3/3] nvme: parse format command's lbafu when tracing
Thread-Index: AQHaUox0CmSi1Fj/J0W0OUpucco8kbDwoAuA
Date: Mon, 29 Jan 2024 11:01:55 +0000
Message-ID: <ab356f7f-cc42-4e16-a771-d2eb15a3c449@nvidia.com>
References: <20240129082256.63239-1-kanie@linux.alibaba.com>
 <20240129082256.63239-4-kanie@linux.alibaba.com>
In-Reply-To: <20240129082256.63239-4-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6093:EE_
x-ms-office365-filtering-correlation-id: e4c761ea-7817-4edf-98c1-08dc20b9b507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WljlgnKBJFS6s02sgv9o+tDQLHqjvVz/9jZzDDf0e3nCJnBb2QtOyzuW2eWnfm0twFjhWS580tblntwK4QHfRjqsOMCYtg3P/3tYNK1gO9x0avVzvEiFS3YFsouhoIE5HpEOaPz/1TpHtlx37++WhRk8aG5xdlzdymUZsEZr1REN2l91edVV2FFT3cigwmZIzKrpgrPAtHshWq4Vdd+eYPsIo6OeI50c4pm3fuDtzz2AiBFJ0FzL3Z5qZGBwj7Q6/ntND99WnQkVCWBzPahVOZa4ggllpjT9U+ai+N9bJr+91GImrdl1zAWiwdNDGDpXrQqnO5prHr9uLFSROi/axPEWD7WnJhEcluHg6fLzFqH246EWo4pPz8Ku8pa07L6J8tRRZ4+sws8u8igdMpasGO6OnKZoZIEByxyuxFfURMr0V2usSuSMmy6mtX3rvsD3bVXarmNql9LDD5qvNzszxKy8Mb+mqVw44Qnm6k9Rsw4V42oXlOPcB8DHKsptCa85kk0Rv4UWmLb8fp0n23MX7JDDRsH2B077IXxOSETBsrZ6ACs/mqGi34YW6jakG61VaYJmzadQViCyod6dE+94Eu79pGy06m1gQQGIYwdTW3iOZrdl+FSF9Q+Pz4LEA7zl8bmi/R6nymiX1Kwf4mWTbFrYIEcbfwUTG7WHNDXlpk5acevg7QRX7bpPogEldmw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(53546011)(6506007)(6512007)(2616005)(38100700002)(122000001)(5660300002)(4326008)(8676002)(41300700001)(8936002)(2906002)(4744005)(478600001)(71200400001)(6486002)(316002)(54906003)(64756008)(91956017)(66476007)(6916009)(66946007)(76116006)(66446008)(66556008)(86362001)(36756003)(31696002)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGtvTUNjeXhFSFVJaTVmNis1VmtKNWJzSm1sd3BGeDRmYmdqRE03MndOdHdR?=
 =?utf-8?B?aGkvMndQam14dkk3bVF3cXlrZE1oV3hJY0R3N0pnOVdpMFR0aWhtb2pRak1s?=
 =?utf-8?B?VEQ2MWRPbHcyVEdWZ3NpaXlSdnZoc2REUXFORkRzbUR6QkpydXc1OS9CMysx?=
 =?utf-8?B?cEhzYWJnbWF2YlgyZGpZLzNVVVg1M2VKRHd6ZmFzWEEwWHNMTHc2UkN2dFFj?=
 =?utf-8?B?TmhUek5KcnJhZkhhb01KUitCNVJwSXgrd01JVWEvYllhbWw0Rk4xdWlUbnNY?=
 =?utf-8?B?WVhMdngwVk9ydzlCVm90ak9FRHJKUmRxNTRMdTMybGl0akNLdnJPZlVlWGds?=
 =?utf-8?B?TldNb2hlZ2grb0NFOHJ1dEZPVEtlc05vYWxWelFFdGFVQ1VSUWtVMHRnTTlT?=
 =?utf-8?B?ckxZV29RUTFtb2hhd0ZHYm9kNnZTYloxVDVFY3FaZzhXM3l4RW5UUG1oa0s5?=
 =?utf-8?B?Y0VlT1ZKWmxJUlg3WjExcUVBSDNWMU9jMmF3Rk0ycnl4L1pkTE1yWnVPK0Zl?=
 =?utf-8?B?VERBRy9GdndIeGFVMlNiZVdsMXR4WDVjSDR4Ti9LcVhTZ3RJdDM1dCtVdjN2?=
 =?utf-8?B?UWQ1eUhRR3l5bWJvdGVEVUVNUGJ0UTNnN0dBclJ5MWZYdHpwV0JuTmRQczNJ?=
 =?utf-8?B?OXJLVUNzbUZxMVdtaENRSU0rTEZ5aWxCazZvT0FpQVgvTXpXa3pER3R6WnMx?=
 =?utf-8?B?LzEzTmVOK1NxcEJ4cVFpWFQ3cjZNZTBPYVV3dE1qYmwyTXY0azU0VEgvQkNX?=
 =?utf-8?B?aG90THJuM0FpK0JOS2xHQWJkdVF0WEZiMU9hOHJDYU1ETG8zTzV2NGM2RGlZ?=
 =?utf-8?B?TXo2S1BtNHFxNkxqNjd5RGZnNXI1RlBRcG1OZ1g2ZGd2RW1SOTFobnUySzZr?=
 =?utf-8?B?elkvc3NQb1BseGkvVXJnYzRzNGtocWd0bEwxUy82akZvWHNrZ2dMOUk0ejZa?=
 =?utf-8?B?ZDh2ZXozMHk3bUlyQW1VZlZXdHhVWXNUWE9jcnNKRkNXZVZpazlXSDhCNFla?=
 =?utf-8?B?bDN3TVZib2NYK0duVC9RbDZQOVlPdHUzejA2cW1haW9lL2tDS1o5UUllSERC?=
 =?utf-8?B?VzJpUE9hTWxkUGJpVVlDeE9tK2hTM05ZeUpjU2hCY3EvaFN1eEM5UFZSN0px?=
 =?utf-8?B?QmY0c1FFQno3RjcydTh2L0c2REI5L1k2YVdUbGhOQVMvRkxYaXVIcEpRdnl3?=
 =?utf-8?B?OU5kQ2IwOUlEOWxCOEF1a21FWHh6ejJpaVU1Yk1RYmVMTW9HNTJOeHFjTjhs?=
 =?utf-8?B?U2s1U1B2QWN3MXVIN2VFNkp6bzJPQ0o2U1lGdmlwanU4TkpObkE0NWtRVWdi?=
 =?utf-8?B?MDJxN1dPZ2h1L1ZaNm5IcnFFK2RLRklSbEIvd2R3eEhGaXRxQ0dPVXk1cW9w?=
 =?utf-8?B?VjllNk00MmdWR0pJWlVtODkrV3plaFdDZE1EZTAyOUFrRlI3cG1qVE0xTnpo?=
 =?utf-8?B?VjFZdi9jTHF3ZUN0NVlZc0QyajlnNTAwSG1DZWJnajdnaVk0TXRpNWdFYVRm?=
 =?utf-8?B?WDBUcnIyendlNnA5c1kvMExJWVRBSFdUbWkxakl5QUx4WmFtZUV1ckk3WlZV?=
 =?utf-8?B?SHJSTUVFNHV6Nkx5R3hDbEtCZHBFS3pBTXJzRDgwdGNRSWptdzhWVHd0MGUx?=
 =?utf-8?B?S3dxV0ZIQ1gzRzRwWmxPcW5PL1NreWR2RDhPNERLdG03c05pWkJzWlpkQUtk?=
 =?utf-8?B?T0V1TWdZZWl5UnpPSnNNODFzS3RLT2Z5SmsreEhXOEJCcWdPdkJiWGNNckRi?=
 =?utf-8?B?UDU1S2F5S3hNdTh0bFJ1aWpXS2tkN1QySU5qUm1WQThteTl3SGxCZTBTOTNI?=
 =?utf-8?B?Y3lWTDFVZEs4VktaeDRkNWxPU2ttOE1OMTdUSDJWZnNOcUxKckY0RmZXeFdU?=
 =?utf-8?B?UHVna3NGRWd6VWhhWWV0ZGo2bmFHYlNHV2h2dldYWFIrU2t2RmRjUG1Eb2FF?=
 =?utf-8?B?NDNXVlVMYmJObUdVdm9DZnNsT1ZFN2lqTWFUSENXanpDNTVLOEcvNFBoSWhp?=
 =?utf-8?B?dEI2TVhTTGxvN1BYd2ZFVy9ML3BwTmR3QmN2WmhDZHN1ZW85enpzam5abWx1?=
 =?utf-8?B?Q1lXQ0hCek5UTXpmS0xCWnloUG9WeWZ1Y3J2aGV6bFFXZGF0MEo1UlFRL0ND?=
 =?utf-8?B?bDk0ZmR5VlBNQUgrcVN5dDlDWGdpc0FvL0piTUUwNXJyaW95OEMzZFhzNG5M?=
 =?utf-8?Q?lEjFn6bfW+1W/7Pxlkz5W8OQP4HkDns/uN/BeSwfcBh3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A19ACF343837744AB7E2006D8797FAAF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c761ea-7817-4edf-98c1-08dc20b9b507
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 11:01:55.7566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rj/0i0ZcFysUpemNXKFOuImTalOKWa2pTLi1QGK9nCk6qQuslSU8oRvpVwadhA0sUGM4TlflesgINzPCIF7PZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_030200_000577_4B9D5BDC 
X-CRM114-Status: GOOD (  15.49  )
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

T24gMS8yOS8yNCAwMDoyMiwgR3VpeGluIExpdSB3cm90ZToNCj4gQWRkIHRoZSBwYXJzZSBvZiBm
b3JtYXQgY29tbWFuZCdzIGxiYWZ1IHRvIGNhbGN1bGF0ZSBsYmFmLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBHdWl4aW4gTGl1IDxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4NCj4gLS0tDQo+ICAgZHJp
dmVycy9udm1lL2hvc3QvdHJhY2UuYyB8IDQgKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3RyYWNlLmMgYi9kcml2ZXJzL252bWUvaG9zdC90cmFjZS5jDQo+IGluZGV4IGIzODNk
NTFjMWEwYy4uM2NjYjMzNjQ2Nzk0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC90
cmFjZS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RyYWNlLmMNCj4gQEAgLTExOSw3ICsx
MTksOSBAQCBzdGF0aWMgY29uc3QgY2hhciAqbnZtZV90cmFjZV9nZXRfbGJhX3N0YXR1cyhzdHJ1
Y3QgdHJhY2Vfc2VxICpwLA0KPiAgIHN0YXRpYyBjb25zdCBjaGFyICpudm1lX3RyYWNlX2FkbWlu
X2Zvcm1hdF9udm0oc3RydWN0IHRyYWNlX3NlcSAqcCwgdTggKmNkdzEwKQ0KPiAgIHsNCj4gICAJ
Y29uc3QgY2hhciAqcmV0ID0gdHJhY2Vfc2VxX2J1ZmZlcl9wdHIocCk7DQo+IC0JdTggbGJhZiA9
IGNkdzEwWzBdICYgMHhGOw0KPiArCXU4IGxiYWZsID0gY2R3MTBbMF0gJiAweEY7DQo+ICsJdTgg
bGJhZnUgPSAoY2R3MTBbMV0gPj4gNCkgJiAweDM7DQo+ICsJdTggbGJhZiA9IChsYmFmdSA8PCA0
KSB8IGxiYWZsOw0KPiAgIAl1OCBtc2V0ID0gKGNkdzEwWzBdID4+IDQpICYgMHgxOw0KPiAgIAl1
OCBwaSA9IChjZHcxMFswXSA+PiA1KSAmIDB4NzsNCj4gICAJdTggcGlsID0gY2R3MTBbMV0gJiAw
eDE7DQoNCmFzIEkgZG9uJ3Qgc2VlIHRoZSBuZXdseSBhZGRlZCB2YXJpYWJsZXMgdXNlZCBpbiBw
cmludGluZyBhIHRyYWNlIGRvIHdlIA0KcmVhbGx5IG5lZWQNCnRoZSBjYWxjdWxhdGlvbiBvciBh
IG1lYW5pbmdmdWwgY29tbWVudCBpcyB3b3VsZCB3b3JrID8NCg0KLWNrDQoNCg0K

