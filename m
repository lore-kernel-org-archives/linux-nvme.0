Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66837C5475B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 00:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pehw/cy5p7siecLF9Ly5hhCHaTojwfIbZsAvYtiboII=; b=BPPPfD4EwDEt/IUFyE6b0WXW70
	uL5G3zu7ARHeT3I2SQKaHzT1N0FmrdK3+eJtV80WPtIMSEpTrQAgiDVD2OZsvz9fBmPX8YLXydJtP
	yjsntBdj/8QZACVgOKy2j9Pq/JPQsPB8ADmk7S584nv3dvDN89csBVtEnE2G69eZNXU10yao7GCj4
	WOGbY5gfJktKUiSK1QqSFB/VZY37lGdyzPhP8ovLmVdBi21ihdDHSgUPwtNH1R+/6/HL0jheF8tIQ
	ek+jEKFdautCvLIlcLFuuILaXDURhln66OhGKdfP0zP7AOqM7tvy6bhZ8Ljq4v2hz+RjC+6wYkyE3
	Z5EVRL8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjqLx-00000003jEV-1Nvi;
	Tue, 12 Mar 2024 00:50:49 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjqLs-00000003jCv-46rm
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 00:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmKiXuCmA91Mpy/Bwcq5gHxzVoqppCPt24bgOX5IOUx6Zx3Ja+ynLqqnql7NKKT3nkrdBPJLlYOVBbmMpzCkCc/7YDqErqDnMXlS0DU5JQCUxWWXljI2aUbpTOTmjaJKCbdn/0F0qKuqZDBdwtRIoDmhlbbxDaOUJRVQQspKVUZtQqdtntL2edR3QEL44PcXI5vElIFj228WJ71E7t/xR4M2HjhCjtgyF57PS1RYbMiF8gO+mbpkAO3hsslapbC6TY3oRmc336MVmF3U6scWiKFOuZJ+axAacm7tPpcSA8kVHER58f2BJQIzDYK7+LLE7YNAha3aHaeshEHnrkj4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pehw/cy5p7siecLF9Ly5hhCHaTojwfIbZsAvYtiboII=;
 b=SuFHu5vERkh2PSpZoVdo0pfAQbfnPIKp0nTqa4/vPB7/hzGrhWrqzVoUJOBruA8oA6QfZbkvnn9avLdfoqqXc2lBi0iCPgFYNah4UkWOsru9zzng3OfR1cQGKP/twg+RPLz9gnfRQ8KhNB5N4cTAwI1PW+YjiCINBYUoSeIjybF1CgPktWXWMNdB0uZ4TvmJKG2cDC1hh8aFieG0H0n51ZKViRE9Gyq6Z7JQMUik1r4vxH5oLuGvZBf+s03F5hUOrFF+2qUBhGJP5qI4A+GAn4iRhfExHRZOT+O7Sm10oTpwsrwdpPAFqHlIoG6VbYosZrNm9RHYVODOIdYTPoSozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pehw/cy5p7siecLF9Ly5hhCHaTojwfIbZsAvYtiboII=;
 b=FXUMNXopLGfFYwsGFv8KoIpZdjPdwEq3bqXr62C2jqyZgOhe59yOvJn2lJjk5ZrC2DxqZFmerFNEzidmNGto4DGQfV9a5nzynGD/LVTZDwHeR2m0ZYnvPc/+o2w5Q9xdQRj++iit8SL02eW8LabkVg3V7PwihiCnlUIELswVFm/hCrTjHROKR6+FOO7mLFKPjMkp2EQIWJJAy8n8RgkfX+mocxt5MTtR4YnjnYibxyJcBJaztuUGE/aWDaFtioP0IdEIthaY2r+DBYIwUM5gwXR0go/3moqe55B5XT5N41f2uGEP6dLnvlH2pnpMao9s5exK6sB/keAYSmeX8BtXYw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 00:50:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 00:50:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v8 0/1] Implement the NVMe reservation feature
Thread-Topic: [PATCH v8 0/1] Implement the NVMe reservation feature
Thread-Index: AQHaar0vgM+mTBYbv0eIQriM5FJjN7EodTqAgAOFc4CAB15qAA==
Date: Tue, 12 Mar 2024 00:50:32 +0000
Message-ID: <43565275-d71b-4c51-9a5c-b528e6387614@nvidia.com>
References: <20240229031241.8692-1-kanie@linux.alibaba.com>
 <1448899c-6056-4070-8b34-da4ecd2bf470@linux.alibaba.com>
 <105d14ec-b4db-44e7-b98a-135787c17b10@grimberg.me>
In-Reply-To: <105d14ec-b4db-44e7-b98a-135787c17b10@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB8089:EE_
x-ms-office365-filtering-correlation-id: 2a641fce-1bd5-497b-7f1c-08dc422e6c22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgdxVp6kuuKYMWlxUG1iBtVaJx88O/Z4dcFDvdxmTaCZnM1dO9Dco2S+4fvS6snUHGC1nP8Et013iuwNT978tSH/F6PXHqEQvP6h5NshMT0ZvObc6OnBJZt5Z8lWNWDh23nhRXgfwRxkbzx0h4JX0yGZN9FKrcWKEd4yIayO6GucUsU3f3d1K7Zc6kGaweyTCCtuZA3MYNiPo6VTwy3u+4ZGlwy5hZ2BKvu0PydUFgv4UBZcoP8b3HsuJbNr4JWA+kR2BADSq0I+yoe+twKa3IAZIJjzbSnkZti3NNAo5a+NFXbUW8Bi8RQzxbbo1jSep3aQSewBZ0S6BdTFd346HI0msZrQ5gAQJmMVt4Jd+vrAWUFpYJOCKtLk9wNIFXycEuVT11dXUFKJzg8QUM4ZGfKh7sPZsh7UG2BAdSximapx5K0HANFyGSpdR4zG+DU/63FkxWsXs5y1QVNweXJyHQwCk9/o0QLghftWnvg7hnwsKt0T8+pZd5AF37/D15p4Aj1d6rpTjycVDEyyRgw0godRc8lqCi3VYgIi2Vdum5lgfrSfyC5ILMnPlY/bRO7epGV8Cs+YUZZgBTxBsh/p5fDuuUge+Z++gbrxcj9Zj1+mxRvXdiuijX1T/lLLIqkXAUrOjmXSMRUEFpxkSZUz4oiq2INaM6a5mLkwa84SevGV6NIW2F87JIMeuV1c0fjAtwKv55wUmWsy46vnY6O3NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzdNb0ZKV0FmMENzSCtSRDlUcUhRMklDWEFxK3RHWWZlTTVVZ1Y1RkVONVhM?=
 =?utf-8?B?YnZBeC80alJzU09lbkhIRW9NQy9JWXBHNVdiU3NURnhIRGJQUG0rNE50N052?=
 =?utf-8?B?TTQ4cGpvQVVwdkJITXBPRDhIT2YwejU0ek1iOTZCNzdEUDNDOHRtakNBaWlM?=
 =?utf-8?B?UGk5aHpVdGoyZDIvOW0rQUlUNnVDWEFkQUZ2QTN4OEIwdld1Y1YxWHpKMnB0?=
 =?utf-8?B?UWlJblF0d29vMFJJTzBYODFnVjNTNEZ4WURFUWdxdEdTN2k2cXNISWJ3Q0ky?=
 =?utf-8?B?VlJIc0ZpbzNrZ0xLZTc4Yk5EdzQxQlpwaFFTUkhnam5SL0ZxRzMxeHc5QldN?=
 =?utf-8?B?SXJabEVhNFJpZ2R6NFcwRE1pZElrM2lCTVM2QXZCRFNQSlR2MXpmRmxYRjJz?=
 =?utf-8?B?WHowbXFZeWg2THJ4d0kwVmpOZENqNjRHWlRMR20vUXpwVkVaKzhFZEVWZ3dn?=
 =?utf-8?B?QkRhcCt6a2UxQlJvRWZxZnpyRzErT1M5YjdvNXZPQVYxUTVxQUFqUWpTMnIz?=
 =?utf-8?B?TDRtWW1mVjI3SHp5NGxMMWppVjlyMThMRjI2TlRUZHNMWmlldER4Z1RWSHpG?=
 =?utf-8?B?M1Z1a1JiUEdTVFB4RUZkWTZzNmhqNUx4N0NlRDNGQUpqaER6SktVeGVZc3Z2?=
 =?utf-8?B?WkFyTmkrQ0U2cHVVbk5mNExxYXJTS01HVHdMVm9qTUFjeUdNcURRcnhDT3VM?=
 =?utf-8?B?TFhtc0s4V2c0OGVxMkZ5cGdCYmljeHBTWXJ0bTZFc21Mb0FrM2tFRlBCMDcz?=
 =?utf-8?B?TFJjK2ZSdUNSdVJIdXJGNzNLWVhMUi9JNm91ZG92RzJ0NTA5YWJTZWxTcXJn?=
 =?utf-8?B?d21ISnBHZnVrZVNLV3owSjNIeU9VNVpncG0vNzdMYWkwbmVxY0pkRDBab2tn?=
 =?utf-8?B?eGdDemlSekJBU2ZpczJkZ0VMMXJ3c0cxOUV2M2ZjcFJGaExteHRCTExkQ2xr?=
 =?utf-8?B?Z3JlVDZlNG1Id1ZzbGlwNEJYQmlpbzdZM3BOOVJvUE5SZjZVMmhTZnRFOUdV?=
 =?utf-8?B?RElucTVKdWpKaFh4NmtBaVYralBzWHNuS2lSV25LL05TWmlpSVlpTEFwUUVT?=
 =?utf-8?B?QTZMSGtmR2RwVVNuU1ptRmZLV0VhbEtKd2pKM3U0TDZrUE9vY3VDR3NWN3lG?=
 =?utf-8?B?NVBuYWkzQmFaODdJdFR6ODY4NHc0SW93SEZMWVZhdmJNVHNyeXZWZVVTekRC?=
 =?utf-8?B?YnRaa0pxaUZpSGU2NGpsYXJIbVZKYWZiSHNlN2Jtdzd2UGl6WlhNSjBZT1py?=
 =?utf-8?B?clBaV3JCdDM4VWZDZTNQR04zWlVsUXZaRU9wZ09IRFh6eXlUWHpNTjN5NUJ6?=
 =?utf-8?B?cFd1M09yTk9uNWpHWVlza3RLdlJLNkREdE1XS1hENDNZbS94NDhQTXNyaHBm?=
 =?utf-8?B?dkgyU1ZLc1A2VktSOEhDMDJ2eVRoOG1CN01xMzNwazhSQnUybFJZNFc5U0dV?=
 =?utf-8?B?Qnk3L2o1S0dIQjdxMGNUWHRTTUFtMGpZTmxIbmtjUmFVZkpzMnV4Q0N5dUQw?=
 =?utf-8?B?UWM0U2haVlcrbjA0dnJnQnVzbW4zVVdtaDRTR2FwZ05lS3ZzYmpldWFvZ2o5?=
 =?utf-8?B?VVNQazk2Z3pVa0hqWUwxL3NrTVhvYVg1aWhtZmFjMEdENGQwdXhYbXQ4QnJr?=
 =?utf-8?B?TnltK1JYcHRCRGk5M295eUNXaXZoOURqeGkrMURaT25sVU56YUNxNGthanBS?=
 =?utf-8?B?L3dBWWxxYUJZWk81MVg3ZVRuMXhXS1VmTHZsQ2dqNXRObkM1VFNwSGMvUTkw?=
 =?utf-8?B?SDdUMkZ1Q2RKeUR6ZXhuZlFOcFNDZEtrZjd3Yy9UV2tVdDBMaUpmN3NoaVZs?=
 =?utf-8?B?WDhNZ0hkaXl5NHkxZ1A5M0R3N2ptUWlDSzlOQ2MyYng5UFZwaFMvMzd5VS9S?=
 =?utf-8?B?bUEzZ3VDOFo0cHJWVFZFbFRkSWNNQTQ0UmtYM2laVmNPRE1zeFFIY0VjQTg4?=
 =?utf-8?B?Z3VrTTFSTVREY01ONEhuMHk1VHJCR3B4bVdJUGIwdXZnQTZVbHJGQUkyWFp0?=
 =?utf-8?B?U1cyMXZBOXpDUnlwYjZJNjJMeUhGS0IwQ1U0MFhFZzVnc3Z3WVAxeTdCdE80?=
 =?utf-8?B?VlJBVnVMWjJSYm5IM1ZzSURlQmlNSkV6WndJYXc1cmZoRmwrYVBkZ3hkaVJF?=
 =?utf-8?B?UkVienduWVB1WFpxa1p5cmZ5eUYrRFNZZ3dRTm1YNERRcjRIa3M3WVlSOVYx?=
 =?utf-8?Q?KOE9/dAxs1Lu+ul9Q8YaVc+q6Z/Qqk6w5QgLTpFREc0P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <667A1B6DB300F04D829CBB691B8A6FE4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a641fce-1bd5-497b-7f1c-08dc422e6c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 00:50:32.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXpzWVKgWp+47dxxAXpbd0r85FxZpsei/QV2rV1tEuhgzS6rnzLDQ5BNE6a7H/OqAPV+Lh14OR9WbqbohyooLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_175045_071566_85D71595 
X-CRM114-Status: GOOD (  14.33  )
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

T24gMy83LzI0IDAwOjE4LCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPg0KPg0KPiBPbiAwNS8wMy8y
MDI0IDQ6MzIsIEd1aXhpbiBMaXUgd3JvdGU6DQo+PiBIaSBTYWdpLA0KPj4NCj4+IMKgwqDCoCBG
cmllbmRseSBwaW5nLiBJZiB5b3UgaGF2ZSBubyBmdXJ0aGVyIGNvbmNlcm5zIHdpdGggdGhpcyBw
YXRjaCwgSSANCj4+IHdvdWxkIGJlIHZlcnkgZ3JhdGVmdWwNCj4+DQo+PiBpZiB5b3UgY291bGQg
cHJvdmlkZSBhICJSZXZpZXdlZC1ieSIgdGFnLiBTdWNoIGFuIGVuZG9yc2VtZW50IHdvdWxkIA0K
Pj4gYmUgaW1tZW5zZWx5IGVuY291cmFnaW5nDQo+Pg0KPj4gZm9yIG15IHdvcmsgaW4gdGhpcyBh
cmVhLg0KPj4NCj4+IMKgwqDCoCBUaGFuayB5b3UgdmVyeSBtdWNoIGZvciByZXZpZXdpbmcgdGhp
cyBwYXRjaCBhbmQgZm9yIHRoZSB2YWx1YWJsZSANCj4+IHN1Z2dlc3Rpb25zIHlvdSBoYXZlIHBy
b3ZpZGVkLg0KPg0KPiBTdXJlLCBJIGRvIHRoaW5rIHdlIG5lZWQgYXQgbGVhc3Qgb25lIG1vcmUg
cmV2aWV3ZXIuDQo+DQo+IFBsdXMsIEkgZG9uJ3QgdGhpbmsgYSB0YXJnZXQtc2lkZSByZXNlcnZh
dGlvbnMgbWFpbnRhaW5lcnMgZW50cnkgaXMgDQo+IGp1c3RpZmllZCBoZXJlLCBpdCBpcyBhIHBh
cnQgb2YgbnZtZXQuDQo+IFNvIHBsZWFzZSBkcm9wIGl0IGZyb20geW91ciBuZXh0IHN1Ym1pc3Np
b24uDQoNCkNhbiB5b3UgcGxlYXNlIHNlbmQgYSBuZXh0IHZlcnNpb24gd2l0aCBTYWdpJ3MgY29t
bWVudHMgPyBhbHNvIGNhbiB5b3UNCnBsZWFzZSBzZW5kIGJsa3Rlc3RzIGlmIHlvdSBoYXZlIGFu
eSBzbyBJIGNhbiBydW4gc29tZSB0ZXN0cyBvbmNlIEkgZmluaXNoDQp0aGUgcmV2aWV3IG9uIG5l
eHQgdmVyc2lvbiA/DQoNCi1jaw0KDQoNCg==

