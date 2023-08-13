Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D594AEB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7AWTYv68aQVVnNFR+NSxXe6l+mKIYpBWbUfUA1iDRk=; b=116XP3gzlfF5Yu6IYUs4kNl/Ni
	2L9gxNHJj7oiWxiSfq4MLyYw5+j5FpiqRVcPu+IPQ8AaZ/IYL1V7t0lR6nbhODKUKz60liN70QYhn
	CWkiRpxyq+8+6YHQIhWM/JWWbfijlauOwvswSMdWiSjNII0AN5uSaHop4KLcTLtHIKtOn40Q/2b/d
	KjTUQO8pc1OIoEY2W4uJKHh2NfTEDAHrwEdIbapAbZzR1hQjgY0JblaO5xDnOIpI6dMfrp1BUZjSV
	rjHdXXHJhiAnbqYlk4NK3UXRmABw5/txvugp5e23kfyYy+VKPpCb9aETiTRc05Z1GRx6xlJm2YBjz
	mfwVI8mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qV9kX-00F3pn-1L;
	Sun, 13 Aug 2023 11:59:13 +0000
Received: from mail-bn1nam02on2072c.outbound.protection.outlook.com ([2a01:111:f400:7eb2::72c] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qV9kQ-00F3oe-2J
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 11:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhK3gyzBxnBe/TlUUOARSODoFy20LAt+ivha47b6SSSC2s7kKqsTifVQHWtYP1PN+oLsoXLrlgtMGSUklWvk0sm2C/vgGkCd37HbtRnP0WpMpMTvGmdlhTboZ6FG5n1gs/YmpKpo/Tsm8b4I/vZs9zShuvqZ68ygY62wTJRPdDk0LtSwWGpmYGzze3hsTmtPV68QbyAEUtchT24JorLF0VKL04z8v0WMpELnwI7hqy2pHu43PfT8+06MyycfuuBCrNlnooxK45Kev8Q4IFpJGs74GpjiZnlgGuTTmTiII+67iC0SJPMaDWAEfek0Ck99xL2UfO83toAY8gzg7huyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7AWTYv68aQVVnNFR+NSxXe6l+mKIYpBWbUfUA1iDRk=;
 b=XDLYGowGckbKxlexd+paJ5z8AYp+8JxHbTVBhTx7Oupme/roMw5tfaby2cs6IexuvhgutokEZy+DhkPEf+ElYu8r3lVY+M7IwvgX+U47K8Iuh3WSLQXJmbMb5vZlSQ8uUPH0n5PhYrPwlz/8iBgX7pXfYrTJ64nMW2C2TXjNU35VS/0z5cmZPbaZoxT9v7z3Vz7KTkgIV9NAt/zc7dGDxcE3PjPNAE9oqPOSmbO2o7U16zNo3A/AnNq/8f8KJKnSch5nLV+UHqoqK8deWNj3dT9BQXtsY9CBcw9OHDPUyEoYJ3pwJX+XNT7z0k6CEwDJiCvfAwL2aqVQ8dUDKufWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7AWTYv68aQVVnNFR+NSxXe6l+mKIYpBWbUfUA1iDRk=;
 b=mLnvubxtpVtgMJxcS76+gwrCyHvHvWp3iuoERunfs+UCJNGAjcOxo4duQdTTlzKjn6FC07cNr7AdRviIiZm0DRIvtkcMZtekHa87HOQwVdNfd4iMokAnKXG3G3PVn1Q79EBu5j3z18Rwh7i3SGcRoJifW99WnYBX5RPV+BGoX5k=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 11:58:40 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::5bab:f7fa:3d6e:2267]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::5bab:f7fa:3d6e:2267%7]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 11:58:40 +0000
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Rakshana S <rakshanas@chelsio.com>
Subject: RE: [PATCH v2] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Thread-Topic: [PATCH v2] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Thread-Index: AQHZxfXezBBlNj6SSECn0Sdt0gsgnq/eueEAgAA77ACABFJ/AIAE5V4g
Date: Sun, 13 Aug 2023 11:58:40 +0000
Message-ID: <BN9PR12MB5324D0D07761F9375342060DBC16A@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20230803105839.6139-1-varun@chelsio.com>
 <eb0ec990-50f2-128b-93ea-5a997e36bdee@grimberg.me>
 <BN9PR12MB5324E8DC829612DD1463116BBC0CA@BN9PR12MB5324.namprd12.prod.outlook.com>
 <2a8abad4-8c6c-2353-d056-ea6f04cc0f12@grimberg.me>
In-Reply-To: <2a8abad4-8c6c-2353-d056-ea6f04cc0f12@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|PH0PR12MB7930:EE_
x-ms-office365-filtering-correlation-id: 10e6f5db-cfeb-4730-325f-08db9bf4a2ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDVf0z7UneDZDHGFybEIP2k/2Or/CdEzwoRYZL3I1BoJLX67IqFYkbsH6wZd/AvnqArb+MC/KUMpBXOAoHbodI8ellg2RxVSarF4Ed+rSoRfisrGZDyYwr1OWAFW15fDv9P6hfhE0bC7+64T91rcE7Ti7c35/cuHo3aJ2f3y3O47UWNhi7jcg9KmCvNvSO6P6oB9kY3z2Q2QuexB0TEwu6lwH3QNQmajis0V5FpKLWAl9AYb5JBKkJvZQYPXPR9jWy4CSRU1OGHkwL+Q3lBGdW4xvHAzjxtgIlhaPvQ0/Jv90P7EgoIgp+8641f+hnLkpDkF938O6PqJ7eGd9e2stcdPUjAbPflkow+3ZEQFSjQJpMnbR3Ac0+lQ8eHNpEiuXaj9SC621PRXR8XAnmtGtZbLMjkoYXW5TE1Pu/envqx0lGTNlTcXHha6g1bwJ6A65ydGxTxboDQAglGHs4fgIU/0umVAKXG+QQnJmaZsmVs0dkvfabTiJtyhJuIrL1LTCq8/eUpdc2H3uwSlmRimbjB7XuETQipJQ9UAiYQpFu2FO0JDke9tqGINPw6NRJ/alJTqYXWxHNMve7d24M9zmPaS1/nSgVDn+Y+MfXGQCLPuR4jzggVdO0JpWYAHGPh+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(366004)(376002)(39830400003)(1800799006)(186006)(451199021)(107886003)(6506007)(26005)(8936002)(41300700001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(316002)(9686003)(83380400001)(71200400001)(7696005)(122000001)(478600001)(38100700002)(110136005)(55016003)(54906003)(33656002)(86362001)(4326008)(5660300002)(2906002)(38070700005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXZqWW1XUXkwbTFFenpiYkI1QmJOZTM0SmQwTE1xWG5MSkU2VWY2a083Wklr?=
 =?utf-8?B?d2hZN2U1ZXRPZkRqNzNIY3NucTB4UjIrSU5LeXAwcmthd1BEOW1kSnhuSXZQ?=
 =?utf-8?B?SFFQZngybEMxRGxRK3A3TXV3bmkyQk9Bb2VwS1NxT2JGWmJUUkpPNTVzR3ZC?=
 =?utf-8?B?dGF5byszVEx4Rm5PdmtrOHlaOEw2ZXVMdVk5UVROZTltWkRWWWtuZU5kaTRv?=
 =?utf-8?B?RHRtQnpJMStkbGdpM0kvWlp1Zi9qQzRZWjZFOFlhalNJOVpsNW1BUERWdGZz?=
 =?utf-8?B?aCtocVdPSHM5K1ZId2xRVE1zTHp4c0ljcldwV3k1a0FZMnA3WTB1bmIwMDd4?=
 =?utf-8?B?bmhIUWpzL3duU1VuTXlhdXB4Z0syR2xpMmloTjBBS3J0OFRKUXBtVXlBcDdY?=
 =?utf-8?B?OHFPRWwzYWRHUWxGTHZYeTJGOEhsYXBLeERRZExSdzYrc1A4VXhza0FWU2hY?=
 =?utf-8?B?ZnRFWFk2bm9reFlYdVVzbnNia1kxMEtWeXBHRlBiUkM1enNhV0RkSDlnTmZS?=
 =?utf-8?B?a3NxdzVzRFI2RVZ4Nlh4aVNubTdyTTk5eDRHUHp0TFJ6NmJ5TUFPa2tjdHhq?=
 =?utf-8?B?ZHpPdTNuVTNUNVJEZS9ZN3hvWGZITjByNytvVXJKYXllUWxzTTF6SVNBM3F0?=
 =?utf-8?B?N2tFWm03d1k5TngxLzNnTlh6Skp6SDJXTUJYUUhTY2h0eEdrN05XOW1wM3Y5?=
 =?utf-8?B?VmVEaVVId0NsUE9zTkNZU0FqbE9Pam0wajNNSEVsdXVYa1BLbGRxQ2hLcnht?=
 =?utf-8?B?TENsYW5zR2hsMmkveG5Vd21xMW9RODhmbnp4RzhRd0tzTGxuQ0xwcjgwN3pZ?=
 =?utf-8?B?cFM5cFlZYTZtTkVQOVUxSDJaV3N4c2UwRTBJd3ZDYjF1b3BJMTYvQWZadllY?=
 =?utf-8?B?MjZFZ0NQdzFlZEdGK0tjcjd4OHdhQTcwNzFTVEJMQ2FxeDltVXdmMUpOQWpv?=
 =?utf-8?B?ZDlSa0FZaFRQTmJqbjMwTlRPak5SdlI2RmlwZGpQQzBQWmJQL0Ntd1JCQnky?=
 =?utf-8?B?ZzQ5UllreHRNWGQybEZRWnJHOFgxT1dGcTBaUGJSeEUrNVZvU0ZxT1pMNGhu?=
 =?utf-8?B?QVlVTEpKbG01V0Job2tQNnNEVnlQTFYzN0lrVTRnSVN2R2lCZWZmdVgzWERs?=
 =?utf-8?B?ekdaYzRCK0hJWFZLVWVDRWZkZUNsVHVDTml5MTRzUmN2NDlqZFRNaFphMldS?=
 =?utf-8?B?NlhwQlY4QVJuSUJBWDNKY3d1U1lTL0RPNUw3TVBKN21XaFpJdmQrN210K3U0?=
 =?utf-8?B?eEZrSVBxMS81RFVWWXZ4Mnl2dlhrdFYrZHo3L20wYnBLUkN6TmtlTEhXZnhH?=
 =?utf-8?B?aGFOaStPYXhpbzk2TlBPQm1Oa3ZHMUJoZ0cyZUgzSDBjWjNrdXk1dTdUQzQx?=
 =?utf-8?B?dytBVk1tZkJmcGtFZHpFQ0VxSmFRNmhjY2l5SHlTS0VHN3dWTGJGRXFlUXor?=
 =?utf-8?B?SWNLL1dQdmc4Nk1GRlZxdkpVd1I5MXBXelhYMERyTTc5OWlZNHh6bGluWGFo?=
 =?utf-8?B?RDExMkg4Q3JFVnNNRFdJVE8yQ1lpUTViK09Od1RKWmJYUkZkUXRHbzR1UnZT?=
 =?utf-8?B?YnZLNnU4MnhodDRHdEZ1VHZ1clBUSFc2MzFJSStqMG5IR3F3cGtld09YU0ov?=
 =?utf-8?B?ZlpkSm5ZN0lRVmhRMTVWSi8waHdsV0xPSHdGNmxsVnJsOXpsSGNPZ01YajhI?=
 =?utf-8?B?U1A2QTRyWVF0OHBiK2orbWVzRWUyMmpsMUNyMjk5bUpZOTlHeHdpek1oTDdz?=
 =?utf-8?B?ZGc3N2d6VVNJY1lyV1Y2ZnV2MytMN2wvUmplTm4zVU5xYXZ4RU51RGdQNTNj?=
 =?utf-8?B?SS9KT0pmdHh2d2lOSzNuSldHUjNRbjBydGZHSXUzV2RtYUlSOUsvM1JQVWNm?=
 =?utf-8?B?ZG5GbXdaTi9KdFRXZHR6K2xkTkMrWUliNGM3S0dNRlJEaW81SDUxdzlZbVZ2?=
 =?utf-8?B?VmRCUTBtcE1TRTFsbDB6K0piWmxPdm5zQWt4OTc4dlA0eWNoNjljRGFqNHBQ?=
 =?utf-8?B?QkRwaTY1eTNJQjc4N0NBbWdoWjZMSDAzRFM4VVBNV2M3c25JVGNmVmxDU3pJ?=
 =?utf-8?B?bllNZUtwNnU1TG5Ub3VBb3RIaG5RS1dJOHRJTVo2alpFc0c0dXZ4a1J4dVVZ?=
 =?utf-8?Q?GpIJ010eUAfIZTm6rqVaL9OPG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e6f5db-cfeb-4730-325f-08db9bf4a2ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 11:58:40.6255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hnD6RW7m6+WW1CXGtzGNwf4ZXEgkG4Hriv0UEfSHbllucIO2EBKZ94EMtUHbcpuV1pXgdFsq6hpbmGD+/UzJdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_045906_933902_436E7486 
X-CRM114-Status: GOOD (  10.27  )
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

Pj4gDQo+Pj4+ICt7DQo+Pj4+ICsJc3RydWN0IHNjYXR0ZXJsaXN0ICpzZyA9ICZjbWQtPnJlcS5z
Z1tjbWQtPnNnX2lkeF07DQo+Pj4+ICsJc3RydWN0IGJpb192ZWMgKmlvdiA9IGNtZC0+aW92Ow0K
Pj4+PiArCXUzMiBkYXRhX2xlbmd0aCA9IGNtZC0+cGR1X2xlbjsNCj4+Pj4gKw0KPj4+PiArCWNy
eXB0b19haGFzaF9pbml0KGhhc2gpOw0KPj4+PiArDQo+Pj4+ICsJaWYgKGlvdi0+YnZfb2Zmc2V0
KSB7DQo+Pj4+ICsJCXN0cnVjdCBzY2F0dGVybGlzdCBmaXJzdF9zZzsNCj4+Pj4gKw0KPj4+PiAr
CQlzZ19pbml0X3RhYmxlKCZmaXJzdF9zZywgMSk7DQo+Pj4+ICsJCXNnX3NldF9wYWdlKCZmaXJz
dF9zZywgc2dfcGFnZShzZyksIGlvdi0+YnZfbGVuLA0KPj4+PiArCQkJCWlvdi0+YnZfb2Zmc2V0
KTsNCj4+Pj4gKw0KPj4+PiArCQlkYXRhX2xlbmd0aCAtPSBpb3YtPmJ2X2xlbjsNCj4+Pj4gKw0K
Pj4+PiArCQlpZiAoZGF0YV9sZW5ndGgpIHsNCj4+Pj4gKwkJCWFoYXNoX3JlcXVlc3Rfc2V0X2Ny
eXB0KGhhc2gsICZmaXJzdF9zZywgTlVMTCwNCj4+Pj4gKwkJCQkJCWlvdi0+YnZfbGVuKTsNCj4+
Pj4gKwkJCWNyeXB0b19haGFzaF91cGRhdGUoaGFzaCk7DQo+Pj4+ICsJCQlzZyA9IHNnX25leHQo
c2cpOw0KPj4+PiArCQl9IGVsc2Ugew0KPj4+PiArCQkJYWhhc2hfcmVxdWVzdF9zZXRfY3J5cHQo
aGFzaCwgJmZpcnN0X3NnLA0KPj4+PiArCQkJCQkodm9pZCAqKSZjbWQtPmV4cF9kZGdzdCwgaW92
LT5idl9sZW4pOw0KPj4+PiArCQkJY3J5cHRvX2FoYXNoX2ZpbnVwKGhhc2gpOw0KPj4+PiArCQkJ
cmV0dXJuOw0KPj4+PiArCQl9DQo+Pj4NCj4+PiBXaGF0IGlzIHRoZSBjYXNlIGZvciBkYXRhX2xl
bmd0aD0wID8gSSdtIG5vdCBlbnRpcmVseSBjbGVhciBob3cgdGhpcyBjYW4NCj4+PiBoYXBwZW4u
DQo+PiANCj4+IFRoaXMgY2FuIGhhcHBlbiBpZiBIMkNEYXRhIFBEVSBkYXRhIGxlbmd0aCBpcyBu
b3QgYSBtdWx0aXBsZSBvZiB0YXJnZXQgcGFnZSBzaXplLg0KPj4gDQo+PiBGb3IgZXhhbXBsZSBp
ZiB0cmFuc2ZlciBsZW5ndGggaXMgMzJLLCBwYWdlIHNpemUgaXMgNEsgYW5kIEgyQ0RhdGEgUERV
IGRhdGEgbGVuZ3RoIGlzIDZLLA0KPj4gaG9zdCB3aWxsIHNlbmQgNiBIMkNEYXRhIFBEVXMsIGZv
ciB0aGUgbGFzdCBQRFUgaW92LT5idl9vZmZzZXQgPSAySywNCj4+IGlvdi0+YnZfbGVuID0gMksg
YW5kIGRhdGFfbGVuZ3RoID0gMksuDQo+DQo+SSB1bmRlcnN0YW5kLg0KPg0KPkxvb2tpbmcgaW50
byB0aGlzLCBJJ20gYWxtb3N0IHRoaW5raW5nIHdlIHNob3VsZCBqdXN0IGdpdmUgdXAgYW5kDQo+
aXRlcmF0ZS4gYXQgdGhpcyBwb2ludCBpdCB1bm5lY2Vzc2FyaWx5IGNvbXBsaWNhdGVzIHRoZSBj
b2RlLi4uDQoNClNob3VsZCBJIHJlc2VuZCB2MT8NCg==

