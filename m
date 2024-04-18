Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3151C04FF8
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 06:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0pq3v7oITATSgKdQt+YZg8k+n0vfd8lyCw/ExfOmAjA=; b=VmlVM1CsiL563lbIQhfGKZ11eu
	F+KI0CLRds81VIHBIQUjhf0Mg4EujmYwxEel4TCzKc18gCz4pi9pR8Tu/67+R/YDoVUmMxktdFEiB
	DKb0nCyX9hPMSlGcn82+a2gYygnvLtBYj74/jrwkw7mEtXIeyx4bplbC209ROPvtfob2cyWaR0wwt
	9XeuDBHAQ65ozUY0W+7YItgPIgXhiErdQ70bxr/2LmCDSyU9i0CJMWgxDS6V/amdY0VmSWPXz6Jg+
	fJ4Ed+kllCjt/mHzLlxHCFKEDH2YFdkTfdI+LwGhHRPPN3b2b1daFhHwmRVwSIVZfgYl9hpzoOwcc
	j+Lv6WqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxL1A-000000014uz-0DQM;
	Thu, 18 Apr 2024 06:13:08 +0000
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com ([2a01:111:f403:2405::601] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxL16-000000014qF-2in6
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 06:13:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOXLz21zqToqSDzr+s6B0eWi8IV4GLqqeRvtvXFLzhBKNobvqqn54177XKTpu6sn8jPt3JvSIyh389ZIeKx3nc2C2045mhgmYf+NdaU3UFBnxc2caRMDbpVGReJIRDmXsUU4r9V5eWT3PU6SkYoVzC5Nr2EaVVorHjaPG1jbZE2GaQ6/VyWMxQjDwgSdH1cOV1fBYHigKUUcMq3vIzmhfwIKc7iT5+2hD5C8ZJ8QG0SbDKn4bf2fpPEe/RwnJSPdJ23NnBRhov9YEaQCMdY0CIfq+NtKBxzqJE4vmByBvy75CXYirkU0/SRXoxkYcPAX7f3+J2IQSKJve7u7Nut4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pq3v7oITATSgKdQt+YZg8k+n0vfd8lyCw/ExfOmAjA=;
 b=OawLXkLo+wmpq65vqVRkv8JJfnJ7YSjjnqjre2rz1bRl4XGSaIlPahbxsIR7vhBevqt9iTQwhrJHhJomjY53QNWzmTqI/B6ocw5vLwoWuo60ZbEBNViCMwoi/UpeFliMKIMl0TX0P+kjvEorZBMYVDKY/o2gU9WULTCnrPYQYqZEUoladUrggnPm3VNCyKGLHBbOLbGvYjIoboJYEj/ySvvVRbkWh8gjsGVcg2FraSZQBVixSMawEhEKbQjYajMA+vwAn8Xxh23vm+fjPIn74PmtWyCHxGLwYUpPWoKnSgbP/9aHJ+Hv7aBBbEX/9WL7MEbGGhvL2iTWwbvKTvpeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pq3v7oITATSgKdQt+YZg8k+n0vfd8lyCw/ExfOmAjA=;
 b=gMEaDUXNh9+M0Nj2eAuxGCeaYPORH6rPtTW4+kfNzer4mislwoal/FepNEjwX/ie9q2FA3yFRPpFZ+J+9yc3SNkeHOUkzg3uEK5LwJ4cTN69MHw06oY6bxmXoim/b27Cq/gudk0lRpkPQ+ljhYWnQ4TPo1Apn2sVMuKkcrQl4ndzN9FmiAMtTdiJjpUMhSG6VCHWEiPbBqsRyErx0nxEngVATnxL318sdNWNIjCGFl3qgfrfOt7qPd2zuzDU7s0y4EPk7i9+QGBH3WqdELSzBq8uGMeBqpwdJfFrRf2NIF+OMGWuLfDH1IcV98t01ebiAbd/iT5CBK3xklq6WHFkbQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 06:12:40 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 06:12:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Topic: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Index: AQHajAEqsQCXyo+DXUatOaKWBnORo7FqY7IAgABWCICAAGMtgIAAJv2AgABo7oCAAFX6AIABlAcA
Date: Thu, 18 Apr 2024 06:12:40 +0000
Message-ID: <f4b9ca90-3d8e-4782-a54b-b83c01316d29@nvidia.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
 <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
 <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
 <b159e306-2b08-4880-96c0-2ff7d5c3023e@nvidia.com>
 <epbj4opovczrfrs3o3mdodjs2dtekl4jsxgbwhtnqhq5bjhjnl@54b5mo6wixsk>
 <extncf2en5xoiov5mhnaglwd33nmffx2u2mw3zlnrxuty3zurx@nij7avtahebv>
In-Reply-To: <extncf2en5xoiov5mhnaglwd33nmffx2u2mw3zlnrxuty3zurx@nij7avtahebv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7354:EE_
x-ms-office365-filtering-correlation-id: b0fa50a4-5bf9-4265-5179-08dc5f6e8dac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZX2aa7wTvEbq7RMVzoTjASaleVv0rEoGbL51od72ZTHriJb7bjK261QA0Y4UzEDbqawtSRfGr8/HPrrbmPaS3TzOq7kheVsjqmpvW6sYaU+kSXthC3Mj4Q1384vw1jqMUGbtEQ4b7AEMajUv/3EGKmwnDULwdHbxMFlmYZmH03fSvK/gRP173oq0KoS6e4RulNYNLkGk9i8UjFYrwFNYFgRQwntmIUIZkXUnQSxkxmolVZhP2OcXwndT17HwjmgOom7iAyUryjZUtkOjAX03Vez/rVN4jqfm975oMDrp5SBpW/wKdm4gKpbDP1c8cw+fvDip/T4m1z7XrBNd0VxwJHtfsxvpOoPVcnAgg16tofPy65zaOK1rzHCdSHSssk5+6IKAuNs03msiMyZ7C6akkysaD5WYcu4RWeJkUItYpfLqBGLMpHO/HJQ8K56fRIeJJfehTDViSxEAeMSdCRMKAGWcm2CpA1fTr7ZzINU4Wx6hw4glwdbMqDHAYD5k9QtmFKzPvi7yaWcE+pSG/m+xJ8Q12FygfJPykd/UOPBQp2x861zyuskt2ANPJeQ0z9pGgb+Cz57eZWGNd3jbZJ0aF4SC2TWGXNfHYEKtiqkniCTPVgDR69EQ81ES07zj1hwCN+p0STnlLkl2W1HwVpcVT042BxPIfVtGxp6eRYU8vUOZkgNIMC34ZQokNFszUnKRU1YyssE6xRjTkUkeuoNHiK04zgOak/djAb+4vLsyss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm1Wd1RYaERiZlQ5Mno5L25nVm8rbnhHN2ltV0xOUFFyZFpZU2lFdFpXaVow?=
 =?utf-8?B?OGZhamY4YlVCTElUZ2RraU8zcVNxeVNSS1ppa09uY3F5RlRuQXJpdEIySUYr?=
 =?utf-8?B?clAxUU9CQ3dNTjdFT2VsMExjcW1JMDhlVVQwZGNBUW8vU2lWalFXeEMzWHlQ?=
 =?utf-8?B?Ni96TnIzNDY4YjZWMjUyaTZCZ0Rlb2xRS3ZBQ1FyTmZxWk9hZW1abjVqamJO?=
 =?utf-8?B?Yi9kcUp5d2JpZ0xoNlJIa1ZKNXNGeGMwdFpmMy8xcmRYdXhQckZxTG9JdUdG?=
 =?utf-8?B?RzhPTHAwb29ZWjcvK0RGdTJ0d0Y5Sk5VUCtGVjAvdGFiTUJWejJZQU9CemVB?=
 =?utf-8?B?akdsVlNQV0pTKzlWb2lnTnZtelhUUTd4MmN2VGJiQmQ4bVcxb2RHdTByU25K?=
 =?utf-8?B?aEVWTllWVTAxc0tBMVRFKzE3d2NWbjFUQlQ1ZTltN2FXdFlYczN0T3FuRENM?=
 =?utf-8?B?VklhYlBPOFhKWlgvWmZIWFdNWWRhamkvbkVTQUN5c0pUbWc3b3VrcTVuR1hP?=
 =?utf-8?B?RVBkZmk1Zm5VdzlnTTZJRHA5SjBhaUhKOVJuUWI1MnN0eW94K3REcWxBMTlx?=
 =?utf-8?B?MlkvS3pMZUFlUGRsbEhjeURxcHppNjhoclRycHNpSVhtWExTdDNqbU01cHNE?=
 =?utf-8?B?NTlZN0lnMk0wK25uais3L1ZaM3JITHVZMEJueE1zTzU4OVVqTW4yNk9MNEJq?=
 =?utf-8?B?YThpTHdwS0JMNzZxem56MWViYmZ4TlViS0lody9UTjJ3NjdYdUFSQWhudGJ1?=
 =?utf-8?B?b0RKR3ROMXF5QlRHckZySVplTXpZRUJTM2UrSWkwdkthdlJHT1kwZGNiVkV5?=
 =?utf-8?B?Ui8yaGJ5QVFnb3ZZWjlNTXVCNmtFMVdGOU4vRUFWMWRKdG11czlYNjQxa0Vo?=
 =?utf-8?B?NnZiNjUrVFhvOS9uWHpNbW9oWmlTWWZDdUQ3NS91VlV2eDNwdnQyMGtZcjgy?=
 =?utf-8?B?MkZnMG1JZFAzbFl0eGRZaFFWeXJSMWxVa3ZmVUlETkY2cUhpT3F1d0lrR2ZX?=
 =?utf-8?B?MU02SXQ3aWpERVdMM3BKUHBObTFaWDJxUE03QytTUHdTY29DWUZDZmp6VXMz?=
 =?utf-8?B?OVZHaUZFbTkyNHNKY3Y0VVhSUmh2enhheW0rbTlsdlh5RU8vQ3NrY1d4cUVF?=
 =?utf-8?B?VWdvZGhxZnVQMVNKL001MDZpWXFOK3orSFd1d1dwSWJTQS9UTE5hNGJIdWZU?=
 =?utf-8?B?UTlsMGc3QTNzYkRCMU9ZSURNK055b1krMmt1OW41ZnpxeitVZnZEVElWcHFS?=
 =?utf-8?B?Sld1NmVhbm9CV09iUENmU05vY3JPbUF5ZEt0bXF5ZVl0MG5OYjJTR1M3azlZ?=
 =?utf-8?B?VnBmRnUrY0VhekczTVZXdXU0RUNIWWJyUDlDc3ExVHErUDBBVWtwTi9DclRX?=
 =?utf-8?B?RVRkbzZraHpGbzBIOG5ES2R3cFNzTEtadjB2S09xSWN2eTBkNTJlSDNZSVlq?=
 =?utf-8?B?eWJWbEhlalRDTkNsaktsc1EwSXBFanZpamU4cjl2VTAxZ0p6cmd3aG9ucWNP?=
 =?utf-8?B?M1p3YWFUZVIwZitvcC9OM3A0ZUFwUzh5RkVWUmlzYjhyU3V2TFJ2QUN1VjJN?=
 =?utf-8?B?b0ZIK3hmTWxLRndxaEhIZUhZQVpCZytQaXlicXV0SDVXTGFRakZmblNqSlJo?=
 =?utf-8?B?cnlCSTBENmZzZCtDaFNiMkprNlV4cVl0Rkl3d1BpdUwyUTQ4NXB4UkNPbm8z?=
 =?utf-8?B?dXRxWW1LT1U2S3I0VGhsc0FWQWhMY2pCNVVhWnV0aFdFd3JCb01NMHAxejJv?=
 =?utf-8?B?aFBvdVZlcmlXN2tBSXZpNG1zVXlqN0pWZXk4eDVWdmxZNHp4bnBnQnBnY0dk?=
 =?utf-8?B?dXF0aWVacjVOU2xkYm9Gd1lKbytkcHZVVC83Q1NsdzFmdnJURWQ1RzVGemRp?=
 =?utf-8?B?eUVKNzhwOFErV2hzWlUyRG1yK1F6dDVKdzZQMGVnNkhCa1BuMzd6ajdxRGp4?=
 =?utf-8?B?alpTN0l1WEJZZndyd0lOMGx5RWoreDhYNkZLbEtubVYyTGFFTFRMcFhVK2RF?=
 =?utf-8?B?aEdiaWRDbk9jK0RFcTZDTHM5ODRkRUNHMmpNSURiQjU5UiszZE5YSWlhWmwz?=
 =?utf-8?B?Vlg3UlRtSEdVaTNOblREbVpVa1hNWWxXZjc2VGlXcGtMMG5HNllSKzRKNlpW?=
 =?utf-8?B?dlpyYnB2ZkNraWgvZmczMU0xbFhQS0JGY3Vua082RTlMaTFDWDRodndCdzM5?=
 =?utf-8?Q?+G/bPqqA3MULKAeyLRtaPe3frBNU8XS6JvGfEYJHzmim?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBA47BBADD43434C8B0AE45B1DE5D4FC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fa50a4-5bf9-4265-5179-08dc5f6e8dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 06:12:40.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQ0jmvUcrgZnMlY/nisYSzp3jHRYHkmdFVM/uqIjr5r01oyGPQkTPRPgHu/EbYn/Dt8IFyyAtobeXWF4+4bAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_231304_708398_18F2F5E0 
X-CRM114-Status: GOOD (  13.33  )
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

T24gNC8xNi8yNCAyMzowNiwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gT24gV2VkLCBBcHIgMTcs
IDIwMjQgYXQgMTI6NTg6NTNBTSArMDAwMCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4+
IFllcywgIm1hcmsgdGhlbSB0aGV5IGFyZSBpbmplY3RlZCBmcm9tIHRoZSBlbnZpcm9ubWVudCIg
d2FzIHRoZSBvbmUgcmVhc29uIHRvDQo+PiBoYXZlIHRoZSBwYXJhbWV0ZXJzIGluIHVwcGVyIGNh
c2VzLiBUaGUgb3RoZXIgcmVhc29uIHdhcyB0aGUgY29uc2lzdGVuY3kgYWNyb3NzDQo+PiB0aGUg
YWxsIHBhcmFtZXRlcnMgZGVzY3JpYmVkIGluIERvY3VtZW50YXRpb24vcnVubmluZy10ZXN0cy5t
ZC4NCj4+DQo+Pj4gY2FuIHdlIHBsZWFzZSBrZWVwIHRoZSBzbWFsbCBsZXR0ZXIgc2ltaWxhciB0
byBudm1lX3RydHlwZSA/DQo+PiBJJ20gZmluZSB0byBoYXZlIHNtYWxsIGxldHRlciwgbG93ZXIg
Y2FzZXMgZm9yIHRoZSBuZXcgcGFyYW1ldGVyLCBidXQgSSB3b3VsZA0KPj4gbGlrZSB0byBjbGFy
aWZ5IHRoZSByZWFzb24gdG8gaGF2ZSBsb3dlciBjYXNlcy4gRG8geW91IG1lYW4gdG8gaW5kaWNh
dGUgdGhhdA0KPj4gInRoZSBwYXJhbWV0ZXJzIGFyZSB0ZXN0IGdyb3VwIGxvY2FsIiB1c2luZyB0
aGUgbG93ZXIgY2FzZXM/DQoNCndoYXQgSSBtZWFudCB0aGF0IGZvciBudm1lIHdlIGhhdmUgbG93
ZWNhc2UgZ2xvYmFsIHZhcmlhYmxlcywgaW4gY2FzZQ0Kd2UgYWRkIG5ldyB1cHBlciBjYXNlIHZh
cmlhYmxlcyB0aGV5IHdpbGwgY3JlYXRlIGNvbmZ1c2lvbiAuLi4NCg0KPiBMb3dlciBjYXNlZCBl
bnZpcm9ubWVudCB2YXJpYWJsZXMgYXJlIG5vdCB2ZXJ5IGNvbW1vbiwgaW4gZmFjdA0KPiBQT1NJ
WC4xLTIwMTcgbWFuZGF0ZXMgdXBwZXIgY2FzZWQgZW52aXJvbm1lbnQgdmFyaWFibGVzIFsxXS4g
QWxzbyBvbmx5DQo+IHRoZSBudm1lIHBhcnQgb2YgdGhlIGZyYW1ld29yayBpcyB1c2luZyB0aGUg
bG93ZXIgY2FzZSBvbmVzLCB0aHVzIEkNCj4gYWdyZWUgd2l0aCBTaGluaWNoaXJvIHRvIHN0cmVh
bWxpbmUgdGhlc2UgbnZtZSB2YXJpYWJsZXMgdG8gdXBwZXIgY2FzZWQNCj4gdmVyc2lvbnMuDQo+
DQo+IFsxXSBodHRwczovL3B1YnMub3Blbmdyb3VwLm9yZy9vbmxpbmVwdWJzLzk2OTk5MTk3OTkv
YmFzZWRlZnMvVjFfY2hhcDA4Lmh0bWwNCg0KYWdyZWUgdGhleSBzaG91bGQgYmUgdXBwZXJjYXNl
IG5vdCBkZW55aW5nIHRoYXQsIHRoZSBvbmx5IHJlYXNvbiBJDQphc2tlZCBzaW5jZSBleGlzdGlu
ZyB2YXJpYWJsZXMgYXJlIGxvd2VyY2FzZSwgaXQnZCBiZSB2ZXJ5IGNvbmZ1c2luZw0KdG8gaGF2
ZSBzb21lIHZhcmlhYmxlcyBpbiBudm1lIGNhdGVnb3J5IHdpdGggbG93ZXIgY2FzZSBhbmQgc29t
ZQ0KdXBwZXIgY2FzZSAuLi4NCg0KLWNrDQoNCg0K

