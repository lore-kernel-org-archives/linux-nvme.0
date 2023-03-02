Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B87C678D4
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Mar 2023 03:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3VUVweNRf4CVet3ekdsUSqMiha/t24sm986AS/ZaHcU=; b=Q7Hq632OAieWAG5OgtdYXOJP9d
	CB8ceAt3CFvpiUOcO6jVdfL4nlSlPGKEGlLIZ1RU5NSiFbIYHgCUJzjKhXPvYHJAjoggA4aJBWJTJ
	TbHmO/Vyx3fTEKxqaH2+UYfj2V2T5vOiyUaJg4je3pHAFiwlpaoAI5Jrj2OBCsW/rv/tS1f/SdThu
	txPZPKXEscgnbuK5ldU4WFxGNGzUtGIlMCYXISQ11xjcJ9hVSe5Out0f2MCS6WOT6/67+5VMuGgYy
	ydE9Ol6Gj02iFRT9YuW9tZf/7IDC4RPW0Mqjt+rkvkQH1dGBg+FFBxI2gG2csQp0e1n4GRqC5SY9/
	rXcwjQjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZDZ-000cGD-2j; Thu, 02 Mar 2023 03:02:53 +0000
Received: from mail-co1nam11on2062d.outbound.protection.outlook.com ([2a01:111:f400:7eab::62d] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZDW-000cF4-27
	for linux-nvme@lists.infradead.org; Thu, 02 Mar 2023 03:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFHqTNQmbjSJr8YIno9UAFsM1dKv72djXgF1OmrXtVkS4BKLlYElSQhZ8uXhwVTMbmrnjDyl7MAWVXl42mUSA92wD0zcXIN2F9K41LlQ4eR7aEVKvJpHTg2jjRW/mkQL+rfQ+Qs6lhCpZqLTDOAp6zxjV1TV3qioJsfceGMKYYHz2wz2rddlv9Fvu4N1jDkWbtDezBuR6l9xW1tNvy4m9O1N2eKCgH0s0SEQetTs1R7OV1N9y+ZS85VpYr//lk8PVu7upUXHxN11mPFm2z8TmR5q2FvfnjtAKpdhS6NU3ZXPklhKgRnyjkyFzlKxqvqg/EXb6C7kWHVrxCszY0CC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VUVweNRf4CVet3ekdsUSqMiha/t24sm986AS/ZaHcU=;
 b=UB4TxP9ax45N2Wtho7H5ufr4aKyB1KkZrzgXWAeTd+g3l7D66xr2bMmTsNxTrphyiYULktXLwJbPnhBKmbMCJeMx733DXMs4wyO1fl+Wig73ACadi8HJOhlGDiKAKAvLfyq0+WToJuxkSXPFvtLmod1NfasRD0GaOOIUxfHgUTh6SDXrHYLtCtKx8F1uPYLO9KNRS063bnlfZbWBFeFOlcudaIXEGEt8NeJw2nDp/4AGmGrnd7t8Wk5c6zELEOw05ApYiUQs9nNeYTc6rVoD4Ybw++Su4CKEh4kRYkHRDRHTSpjELybTM+wVHbvPmMcV2PDnPwFsr3tyyIaa9Y9rbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VUVweNRf4CVet3ekdsUSqMiha/t24sm986AS/ZaHcU=;
 b=P8H8Wu5erAcsfpObEELXzoez7A+Ip4HW38Hwrwcx1k4abE7vSdzj8Kfmq1g1C9MTg4PzIfemn/150+YA5FSob+kEO4vdyC6GSTMgwG4H3N9+31bRzd4DKNFPqlzf+pwJJYBtu19MfSC/ZiI/LWLJGsRv+qpwkM1ajHLog7Kj0oyXG4qbiy/2wDJa7H8JMDX6g61dGbEdNFbUtqslSK2k0Jz+gu0uUt2UMYZ7LgzOnjYpY+10SwxVRdAZWdKFx7Pblea8moImc+sq574f24xM8DNa58PNY26OrGfpKp48BEXyBpHSNLV8yvTpOwIU31CM9eOXYR2as7ZG1GtFCvcNEQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 03:02:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6134.026; Thu, 2 Mar 2023
 03:02:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Thread-Topic: [RFC v1 0/3] Unifying fabrics drivers
Thread-Index: AQHZTBfUN4X8lnt0eUyvUQCunQlG167mzrYA
Date: Thu, 2 Mar 2023 03:02:38 +0000
Message-ID: <6e4fc38c-4b08-1f3b-f746-2fb4f2b4c2b8@nvidia.com>
References: <20230301082737.10021-1-dwagner@suse.de>
In-Reply-To: <20230301082737.10021-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CYYPR12MB8732:EE_
x-ms-office365-filtering-correlation-id: eacdc688-acfa-43d5-8a30-08db1aca948c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  6fvTPcftnajUGJtAyZH7Y2S2Qf5DMxZ1SZ3O8OsgDM+Ql2DOI/MyHy+2sXSB3kVY7oFacEMU724dmJPa4HI/L6PNQCUvqneVMcTqRE5WDSyTLQ1z7hfmQrBG7NiKsynSd7NI6y4EYJ3IVKZF/g4MI4h6TGu2XV213aZDFe/f0MfGlapk9J/8aTVowJEggYDAHHvZJuuj186G87bQBDHWXlM81A16gUKVXhCeT4L8TckqZ5P6+CsHNHfcuUrG66iQxvLipAasVh+ITepA739kHRgZRh8G4Qrrrz1A+sxm6xU0r2WGxA7Qq/FzgDsEfUIM8JqPMSEon/Nqtfon9S9/AMa2rGLdyI9hwI7aZiwndqCWKh0HVlJhU2gsH9Mb8DzYgD+o8VSvj+4M7X7pI+ylwTLEtn3EmrPi6xTYrZHt9DjmZ0ZABWbQP7UN5S0HgPoEvoxhynVjQ5bBKnvjkJd338ha2o/LbO/Ir6l8F+CnqnZwVUp82YZqDZ65hxJvsP6w3wHgbsUvfe4BNuk9CMWVROr5AN/SS4XBPoyd/YS/NPDvLiSNByWJJe48LfsKiV9Qk5/uDeo061aATPefjHbCYh/hx9Ixky3szpv93XRofYwwmok1gqkPt0MXNCOkE1g5l1ma4qh1H1T72ZMn/jNiZCtudLsW3FTvrL0I8Y3WWqQnmmBrresT1MtKKEL8+f4ZbsqHwWEU14PESks/dUR0zj5Pob7UFV6NCvBGuCg8+MHXbYMa1TC9Ir/PoPZ9RX07cJe7Is6l8rG6wp9gO79EMA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(31686004)(36756003)(86362001)(41300700001)(66476007)(5660300002)(8936002)(31696002)(66446008)(2906002)(64756008)(66946007)(4744005)(122000001)(8676002)(66556008)(38100700002)(6486002)(478600001)(186003)(316002)(38070700005)(71200400001)(76116006)(91956017)(110136005)(83380400001)(2616005)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dGtUVzFyMjJjZEI3bnhPNFpwRkg0bVRhajRrdm9RYldwaVhMcSt1YU54Z213?=
 =?utf-8?B?S0trVm5QYStBTGhvTEpHdUZETTVpZ2JMQVltZnNobnlYQlh3MFhkTmtERWQw?=
 =?utf-8?B?Wjd6M2cvdDhiUEFYYkJseCttdnFsZUt6YjFGZWVnL0s2UXErUjRQTVZOQlgr?=
 =?utf-8?B?L29xVHFIT3J6OUlGQU5LdzZ5TzFRT3FyNFJYSDVUUUpvRXJwRG1BWlpSVkty?=
 =?utf-8?B?aVFGSXJRRFNPZWk5ZDhublJYU2cyREY2Nk9VRHNlY2FPaDdVSCtsOEM3azJn?=
 =?utf-8?B?TlQ5bUJrR1hSNTlWTWRIZk5uWDF3N2p0MGFRSllYVGo5SHVxOFhvejVQeE5w?=
 =?utf-8?B?b09XVVBJa3NYU2hGV3dRK0lFZ0U5QjNlbHpYa3p2a0NtaFVMM01kQ1QvRTFu?=
 =?utf-8?B?UzdIM0JpT21sTlVjcTJIV0RuSkdXMGtOMDVjVG5sd3hYVVNKTi9SRzlMRGh0?=
 =?utf-8?B?RERUaS9UQU9LcWxtblVoZDRUa2l0b0tIYVFFMk14N0k4RldUUHZVdnlNRk9q?=
 =?utf-8?B?NWlhenRmUHVUY21EblZxMSt0Wkxzc1JqWjFwSWQvL29kZzVwcGc1UEFZL3VN?=
 =?utf-8?B?KzVqL1FVUnVmU1pEeFlKYkFEUHR0YSthMDZ4QlBIVnVNMjYzYnQwaG56dm9u?=
 =?utf-8?B?bmdhWDA2NjRrVHova3dCZGVrSzVJckV0K3FUdWJxci9xMkpsaGI1eVpNZytF?=
 =?utf-8?B?a2FESEpxRkhUVlVHc2VQdy9jOE4xZWh5M1hBbU5TWVhlVG43bXp6UjJ3QlZK?=
 =?utf-8?B?Qm9wQk0xOCtnRmFmWWN4NXlzbXkzSzV4N3hPMjEvZmQ5V3ZBTnQ1M3JkUUNn?=
 =?utf-8?B?YWlmb0VWL3UrcVZwbi9XbWtqTlYxNGZLMWw0cGR4eE1vbEp6dTRvM0hQUE5O?=
 =?utf-8?B?NldiOEdpMTRVRFpqTTVvZTMrdTZFNHNDMjd6NURMOThnTTNUeC8wSHZrSExv?=
 =?utf-8?B?RStIeTArRlRWMjJxVDJtTlM4V2lWU2FDNFUzanNDWGtnU1hkeHdRdklwNVVR?=
 =?utf-8?B?S1N1OStFazR6eG9EOHYzdjZiRzhPcHNyNzRGdGJQc3FtMXZ0andmNWNsRDFi?=
 =?utf-8?B?NnRSOFA1bE1SczY4UzBkbDRZbmR4K2wrTWc3N2R4OXBsVHVacU1TWkMreWVY?=
 =?utf-8?B?TmJlajNDVlNIVHRGYWlDdXQ2QndFa1ZIaGhhYTNJNXd6aDJxR25xSGNHalNs?=
 =?utf-8?B?MHVZK01SSzRYblNRRWhjVkN0NWRvelZGcVJjQnJQOFdHSjNJT2hLQ0E1VUdC?=
 =?utf-8?B?ZzhWSHpLd1o4d0lIeCszc3dHWE5BdzlPUEE3R0tSZElRU0hHVHp2WEtlejQ0?=
 =?utf-8?B?dWZBSkpxSGxBU0lxeVBiWkRsK3EwN3RRRHN0aXduMWdlMEJ0eG14YnJTcXcz?=
 =?utf-8?B?bXFhL3dFbTJyMzVheUxRbDNWOGx1RHBISW9KYU0zMGJMOEpMazFDWXFVNEFx?=
 =?utf-8?B?UEYyZFZLdHJOU1NoTkhXMlpHdXcvSkhCWXQrVmo2ZTBMY2p5YmRJSld6dW94?=
 =?utf-8?B?dkJseTZBRkJVK09abXRmbnhwbUovNUgyMW5Gb1VqYmpUb3dQMVM4dllMRFVB?=
 =?utf-8?B?cXdVN2ZkWWZiNG03bUFqNEhIcTlDWkZhcGo4ZENtQVIxRTd6akJqVE9GQjhp?=
 =?utf-8?B?K3QwQ3Y2RU9SVkZucFhVRk5wRzdwVDI2M2UxcUxPQStuM3VqcGszellXOVNo?=
 =?utf-8?B?azd1TzFHeWxhTWpHKzNWcnRzSkV2T3dibEdaWlp1SkJZendMTVJ6Vm5hVjdp?=
 =?utf-8?B?QVVKbWZlTlAwSnB0VFB0Rk9GbDRrVHF2QVpXb29HOEhvSWZFZzZ3OHowVVA3?=
 =?utf-8?B?RG5yYTJCZ2F2d3JUM2ZZVTRkQzh5dWVpc09SMHRLUlRTMzg4dmVNcmpuUXk5?=
 =?utf-8?B?TTVoUEZ1RUR3ZnRuNFFNdE5lajFlTDUyUVByaXMrNkVWNVJ2T3JBbGpveHBO?=
 =?utf-8?B?cndPcEQ3Rjl6OGlPeWFTZHRFYU5BQ1Q1UmJsS1c1UHExazhoQXRqMks1SUJQ?=
 =?utf-8?B?cWF1YXR4dEtLZmFVYU9QZTdnRzB3ZFlFNDJLdUVqQ2tyUkxQZ1UwTTd2Vy9q?=
 =?utf-8?B?dW1VdWk4WGlkQ3E5VGM2OHhYV3hwcytBWU0vQXdkMXlaU1NLbG1VMEQ1MjNh?=
 =?utf-8?B?aVhEckkwQXkrMHE0dmJMWEVkRjVjOUNKTHcyR2YvOTBPYjFGNkkwVGpQK2F1?=
 =?utf-8?Q?M5MqYc8qAqa4jnZS6KzeYrSJasQwmF1vscbyIQGJVKuj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FA0220CDB4B974DA82C2DDA45FCA060@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacdc688-acfa-43d5-8a30-08db1aca948c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 03:02:38.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg9IJODQ9Q0pwKE3IOnG0g7sTcdQ4iL1uDqjhMzeR4moGn8+MhotfHW1fqGGx47vhb+nORprUVpKK1URObIsCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_190250_149217_3524FD1D 
X-CRM114-Status: GOOD (  11.44  )
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

T24gMy8xLzIwMjMgMTI6MjcgQU0sIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IFRoZSB0d28gZmFi
cmljcyByZG1hIGFuZCB0Y3Agc2hhcmUgYSBsb3Qgb2YgY29tbW9uIGNvZGUuIFRoaXMgaGVyZSBp
cyBteSBhdHRlbXB0DQo+IHRvIGNvbnNvbGlkYXRlIHRoZSBjb21tb24gY29kZS4NCj4gDQo+IEkn
dmUgcGlja2VkIGp1c3Qgb25lIGZ1bmN0aW9uIChzZXR1cCBhZG1pbiBxdWV1ZSkgZm9yIHRoaXMg
UkZDIHRvIGdldCBhIGZlZWxpbmcNCj4gYW5kIGZlZWRiYWNrIGlmIHRoaXMgaXMgYSB2YWxpZCBh
cHByb2FjaCBvciBpZiBwZW9wbGUgaGF0ZSBpdC4gSSd2ZSBsZWZ0IG91dCBmYw0KPiBmb3IgdGhl
IHRpbWUgYmVpbmcgYmVjYXVzZSBpdCBkaWZmZXJzIHRvbyBtdWNoIHR3byB0aGUgb3RoZXIgdHdv
IGRyaXZlcnMuDQo+IA0KPiBJJ3ZlIHRlc3RlZCBxdWlja2x5IHRjcCwgcmRtYSBpcyBvbmx5IGNv
bXBpbGUgdGVzdGVkLg0KPiANCg0KSXQgaXMgcmVhbGx5IGhhcmQgdG8gZ2l2ZSBhbnkgZmVlZGJh
Y2sgd2l0aG91dCBzZWVpbmcgZW50aXJlIGNvZGUuDQoNCldoYXQga2luZCBvZiBpbXBhY3QgdGhp
cyB3aWxsIGhhdmUgb24gdGhlIGN1cnJlbnQgVENQIG9mZmxvYWQgc2VyaWVzDQpvbmNlIGl0IGlz
IG1lcmdlZCA/DQoNCi1jaw0K

