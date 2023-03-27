Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5076C761A6
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 18:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2YAtTAtXtBg/cxdoWM4egBveEftnmyYqrgGq1fNJjzc=; b=dh4dR2XJUgy5/ILirq17O8sPZM
	Fj//3vXbf3xTrw459tC37+Cp9A6rpkwo2kiuca3luZiltHOql5xLth3pjdkTnwnhMMHfZZQjJ7yM9
	a3fnB+1/WHI61/vGMNY9gJVn05WlWrC8wIOkS3VbMGDX6RmcBMO0qIxvH3XITYRtzOERzeNrBP0mo
	g6BdVQx6vIki/0ULCm1MGze/2Gkx3hJ/j9qAkYV5Yzv6b8vcLDmAETQSGHo+YzvKNvzIKSL0p2fNt
	TSaLR+gGNgnGkiSBr9MnUFS53t7I2hB/O9lTrZ0JHVpLWnaygf/b72YgI+QNlOYZtvqB+FK+ml+0s
	nG5bMdyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgrUv-00C2LB-1L;
	Mon, 27 Mar 2023 18:23:13 +0000
Received: from mail-bn8nam04on20625.outbound.protection.outlook.com ([2a01:111:f400:7e8d::625] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgrUs-00C2Js-0A
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 18:23:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZz4Dt1wgcXzftYx+FmcfmbrrYXPZFmE9TL8vr4TVpQ+8k7fIKEe09XdaTs3oCwJlSKNHeEsT1q64PCJsOpzQphCpS7UOydpM1RjZC1Eg+UvmBdfCcTHtVnpSS5sM3s25DJGyphiWwfkhT0uvOnW7yuz2Fig/AbgDwJ4Sw3unmEWshFzaq53Ih8vy4FNXcVywUGpxCzlBYqvvxxKKavBJs/HQAu1679PA/Bqst6ajNgKHA+c+HoUdWRjyvBVNfBTqKKt+OUsfQGW7oT95clBhE/5pOnIRDvT9lOc+BV5uS4SY1BRquLWVlzzg2kdqneyr6nrTByfYCIrwXPHG6D6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YAtTAtXtBg/cxdoWM4egBveEftnmyYqrgGq1fNJjzc=;
 b=dOdi3uEwLU+hhuX3pp7GP7gBxu/ST/GcolA3G98i84zSevQDCasLnnCFFzeAZYpA9opCiIdnRqtGIDyRKnD6BDPONJPIBysVOJSDISDvx1u1xIZmkEMjuCrg2oJcKa1tIpy4ukUjZkoqA8A5c0V4InkZG6BpwDQ2e5RYwAS3123dLdB+YILu8pOT4KjDrDKiUhKgg/ZPwgDpgs5190PnufEr9SwyG6mvjtspAECmrGLbrZLAoH4dTLdJ2eoVW4Snh8rgqzgAeHlBc2A6dVA7zVMuZVFFhfl8f2ezyJrAbEiLOGmHMlCSzTN68pSrkMjUjg5m8kcZgAqmrEcSsD57bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YAtTAtXtBg/cxdoWM4egBveEftnmyYqrgGq1fNJjzc=;
 b=iikb/SOMia2FPqLEeipqhzB3f2ue3c0F6rL1Y7wrQrX2Vj/y9zCKJsVki6kP2AoSJ5vBG9TtatEKcxHiyh2qwzUy6metf3V+wrbG0nWQNKUT9PS2QCMQ8kW0aA7VmTZUaeZ813zSLRPNrudMlkCcANX8URHT1H4zFl5YP6JotjgAIailU6q18rCWQvj/3DljBF36jsUPa16e4uxcazqSzLqAMsCBa8uI8OdfuaqmrUi4mQnI2p4vAB/uJfehDAsbPbQkASlFE/S86mjyDrtBX5x31Oe022xEzdQmZZUx5fFvSntCwCjbTP0KTYgwTk4rC0MRQtHQKbdRe0PMTto65w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 18:23:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 18:23:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
CC: "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvme: fix error handling in nvme_init_ctrl()
Thread-Topic: [PATCH] nvme: fix error handling in nvme_init_ctrl()
Thread-Index: AQHZYNPab2uyTnJkOEmpJJtG56enI68O8K8A
Date: Mon, 27 Mar 2023 18:23:05 +0000
Message-ID: <84da07bf-c384-de5f-4639-66d406fd3f5d@nvidia.com>
References: <8ce877b6-5b25-e71e-9061-dcda19c2bf9b@nvidia.com>
 <20230327174406.10880-1-akinobu.mita@gmail.com>
In-Reply-To: <20230327174406.10880-1-akinobu.mita@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB8501:EE_
x-ms-office365-filtering-correlation-id: c5f7c87f-f311-4be3-2bf1-08db2ef04ece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  UxsG1sSugCMeXKiEPkZx+PxxKOjl8J+93p1hvb3rOGNvaVTP4rroelQFkKy6+mXW+q+3RTnElP9PRT4XGaRcyd0iUFHGn90ASEA8fnYq3Qu7CGBbUI71tPlmDFG0wS8J/56Y5aW/Dx5nyKV3/b09HWZ45UWd3d6y8QdQoXFwAb57Xrcc3bGbx3kL6IGUZwr+e3M3CN6rDQX0yP/0uo71S9CeYENalRT0YeqaL466FP/uw/3BNxnqZq5FuoA/ZcQoRTzLDyq9VPVeq3oFWKHUtTypdQkQCRrvxANPZDBiST9OCQvIX0uQygN/2N1zPiypJ1F7UGAfch7BjPn8V+gwQCOBGQOrXxMye8Yu9b42Z68iJxDCfPoaRQHdp6keF5fCaRVCIO94QH/G45fOGEjkKcYMS8tAJfmbNjbkV3PpGacWduiS9wLkRHTrWHxafBZ6cny+iZQWWPlfciVLpZMmlYLN2/4FjyhPihEJiveM2jbZHR/B0iVgudYphl6eukWTerGOX7qj2gtZDWD+15LoQzlJB41/1Ah9B7jLmFKu2dDVP+6Wc9IczxIts3xokdIAi1KPQ8InWSvTa+u7uc6gsC6SJDvnTbFfqDGkKCh3EIphhfWIYP7wsrzMbzVNuxFzDc49sB85CKEmy3yyRZ8Jkh2HZqar+Zkj5Uqhmt2H8WSBd1dDlTuz/W+Yqy0K6SYO7HtXrVKDRFOI/inWYmST/vnKsLQm2r7dWH0D58MXnUk=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(71200400001)(38100700002)(53546011)(6512007)(186003)(36756003)(6506007)(83380400001)(6486002)(966005)(86362001)(31696002)(107886003)(54906003)(31686004)(41300700001)(2906002)(122000001)(8936002)(316002)(4744005)(8676002)(5660300002)(6916009)(66476007)(2616005)(66556008)(91956017)(64756008)(66446008)(4326008)(66946007)(478600001)(76116006)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WnBGblpRRmVNQmp1bmxkK2tjUXBOZ01FMEVVRXU4a2JNU1FYTGE2TWRxSkZw?=
 =?utf-8?B?d0pTZm14Z3BwbWg2K0l2N2NuclM0YW1tSHZvU09wTGJoUWVVc0xKKy84Mkp3?=
 =?utf-8?B?MVIybndZY3B0S054dzNENUxsd2cwb1MrYlplWTNuRG8vb1p5eWhSTmFrY1pC?=
 =?utf-8?B?SFpySEd4MTNkL3B6VWkvUUcrSzcrRDV0VkFDOExMRTRvTFNqU0pON2VqRzV0?=
 =?utf-8?B?Z1ZVMnFTZGNvV2JJL3RMTiszOGR6bExzQ2ZqWGVDclBUNFllKzBNL1VQcS9B?=
 =?utf-8?B?bVI5QjJZT1hwNGNHK3owUGVBdTB0TkVEdXNpOFgyWjE4d05kL3ovNHZidVZz?=
 =?utf-8?B?bVJQa0c2dHVDb0NsWG5vYzVHbHBEdnk2aDFyQk1CamVPRUJSUUNoaS82UDJi?=
 =?utf-8?B?V3AvRkNLSURDa0haejJpU0g3ZmY0aExWcUhhK0VyYXVoQmlkQmRGR2JlR2NC?=
 =?utf-8?B?Rkt4c2Foajk0SWdHUCtGMmF4SlludmRmL3UzdlZsZ096aTRtODY1aVQyK0Yz?=
 =?utf-8?B?WWh5T2xkcmh6NCtQdGZkMzlMUGtJS2ltTGtDdXBjeWszbStxYTFncFVPQU43?=
 =?utf-8?B?aFdFM1lQek91ZlJjRmJPSnVDV1p3czJtY2xaOEMwUzFmaDdwbDZXZW9JQ0Vp?=
 =?utf-8?B?Wk1Hd3VSU2JHYStmT3VLcmpTcUh5eXpFQnQ5QzBqNnZRWCt3aW9Zd0ZzMHJw?=
 =?utf-8?B?RVl2YkJiVjhncjVPdmRpeUlvWlFTVzQrRTZUUmdnMTE0UHU0TEFPaWhoUW1q?=
 =?utf-8?B?SjU5R3dqTGhIRmFlUEpFaEh1VlFaQ0dPWGNaSE13R3BxTW1qaXVBZ21wQTJy?=
 =?utf-8?B?WDhFNEpNWi9IRGpBQ2d0cFBleC8rZy9WeCtrcExVVjdINHFVSUlPOW9mL1d0?=
 =?utf-8?B?MDZNWG8xUjBOY3phOGZFd2FKYXRVazdVbmtOdldXbkxJU0RRQ1JmelRGM0Zq?=
 =?utf-8?B?NFhGWWtSRjRPSFhmYnk2aUtub1ZBcDlnK1E3cUVJYklFdlhVdXdNcGp3ckU2?=
 =?utf-8?B?WG5rMWxJbC9DMWZva1VLN0FKL056KzUrQkF6NU0yUGFhQ2pSaWk0U0QzdW9F?=
 =?utf-8?B?QW5ZNVAzSS9Ec05Hd0cvSTVXeDR2R2t1R2VpVGdjNVQvSmVyN2lXckllcmNJ?=
 =?utf-8?B?Y3U0N1d5dHVsSkVxSWgxZ3ZPVGNpS0hnb3BkbDhFbWhaSnE2a0UwR0N0Tm5W?=
 =?utf-8?B?TE05L1ZFN0tKdFlhZTQzWFMyaWVTVmdjOGxqeXlMU1JoRmdacW5ud1ZETlJT?=
 =?utf-8?B?TDVvaDloMkRlcHEvQ2ZCbEkyU0dZRUFDSzlXS3JZaHJVSTk2UXpQK2NIMnFZ?=
 =?utf-8?B?ZW9MNVp2Z2ptZUw2REU3WE5TdXZBK0Vjd1VDUDljbmtnUWtBOVNiRHg0Yllx?=
 =?utf-8?B?RGs2dGNDNGwzYnNLZ1U1NC9PeUttWGRlOXR2K2JQdGNuNEhxaVZXSG15b1Qw?=
 =?utf-8?B?WXpZZlEwYU4zWXhqZlRLMjRsTUROVmptRTl3TGdtUXVRMXk5bmZadlI3eGNs?=
 =?utf-8?B?b2x6UmV6Y3Era3lKZWlhczNZZ09wNE1sQytGZzN3WFE1bERvNFBuY0Q3OENq?=
 =?utf-8?B?cFk0S1dTVnM3bFREcmhSVVhkTkNrVGpZSk91SU9KaUFOUm82RXEvUDhYNXUv?=
 =?utf-8?B?Vnc2cGxyc1NXM0Ewc2JVQ0JPQS9PSmpTbUlUeWZaby9zRHQ1MG4wdi9QMWxY?=
 =?utf-8?B?bk96MTE0N3QySE51L054L2I0czMvbUhpbU5ocGhxVGZETlFzMWJxOWhnck14?=
 =?utf-8?B?ZjBkMDc0SkF2ZTBJOWpON3dESXl6Vm9UM2Q4aDBnM3Q4SVJxQ1htaDFNTDRO?=
 =?utf-8?B?ZERTRGxka2VRR21pbGx5QUQ0aER4MlJmc2N6aGY4R3YrNzZnTFlpbklaNjF4?=
 =?utf-8?B?N3VtTWE4dTVmcFNpWjRDbEtRM3pkZnYrS0p2b2JCcERSR2VuRTFQVTlXM0ZI?=
 =?utf-8?B?QkpqUGtndWsySm9oby92OVUwdGRCdGZvWXJZaVBzb1ZQaUgvazAxeTVMbGQ3?=
 =?utf-8?B?cktET2hmWFA4dmpBdEQyR0lFOHN4YWNDNTZWaU5iUmx2R04vbzRqd3VmUWhm?=
 =?utf-8?B?OVBMSkRtL0d2dDdieFdSdVJpR1M0L0o1S2hEN25JY2NsL0l6MkE4NWV3V2NJ?=
 =?utf-8?B?R1ZOQjBFTXh1dkM4YTN3UFQ0OVlaa2RJKzlxRjl6RlRjeWcyYmZVaXhvYzB5?=
 =?utf-8?Q?ZrrE4SGurcHpg8MP4NGx4QeH2yAbLieiCT1xlkuzppqJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A929E1ED8F55604E8FA3A2FCCD02588D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f7c87f-f311-4be3-2bf1-08db2ef04ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 18:23:05.1925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGuU3yXp1oLgec6jeEfqtprSgensM5jtbGUL9HYD92MeOgDgt4dg9CXCaeAz9HQY+RcOvaGJcNyjuEGQr3ckQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_112310_095308_8A110DA7 
X-CRM114-Status: GOOD (  11.00  )
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

T24gMy8yNy8yMyAxMDo0NCwgQWtpbm9idSBNaXRhIHdyb3RlOg0KPiBUaGlzIGZpeGVzIGVycm9y
IGhhbmRsaW5nIHdoZW4gbnZtZV9hdXRoX2luaXRfY3RybCgpIHJldHVybnMgYW4gZXJyb3IgaW4N
Cj4gbnZtZV9pbml0X2N0cmwoKS4NCj4NCj4gVGhpcyBwcm9ibGVtIGlzIHJlcHJvZHVjaWJsZSBi
eSBibGt0ZXN0cyBudm1lLzA0NC4NCj4gVGhlIG52bWUgZmF1bHQtaW5qZWN0aW9uIGRlYnVnZnMg
ZGlyZWN0b3J5IHdhcyBub3QgcmVtb3ZlZCBhZnRlciBydW5uaW5nDQo+IHRoZSB0ZXN0Lg0KPg0K
PiBSZXBvcnRlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4gTGlu
azogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS80MGJhYTc1ZS1mZGY1LWNiNzMt
NWZhOC1iMTJkNjViY2U0ZTdAbnZpZGlhLmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBBa2lub2J1IE1p
dGEgPGFraW5vYnUubWl0YUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIA0KDQpUaGFua3MgZm9yIHRo
ZSBmaXgsIEkgYmVsaWV2ZSB5b3UgaGF2ZSB0ZXN0ZWQgdGhpcyBvbmUuDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K

