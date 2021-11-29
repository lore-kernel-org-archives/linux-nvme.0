Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E340BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Nov 2021 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQv0fcyrfJNMCbejXbT6YpUfWsvs8k2qHr6Y57Y+13E=; b=E5qbm2kkW7bsDYjPXLlwGOufXQ
	PfINKv9pQKHW/YhypgA8wgmUwe3p1/a76VNgIMrNHqrf8o6pqPwqOzaLFbBb4xd3kVe1QUCWFyrUj
	Z88nJbW5x0JDE8pCoQDBgeDnMasUfFiZYWpwm8iaPkyGfTAArYt/Y+Auh96ju2CNF2wbwyZcgXLi1
	wszMKrTchaw719tsnnrugWBU26+mX5FxXAz1dKjKJ6pSbj7OQeqmR5WitlD745uB3nBuYHSS1cr4e
	Jej5POkblXcYNSYVjWyN/XTlA5NDE37Dtci2f6an1n3F8SxzQO8XqhrY8kpqhiEwrxGfYj5jYQUpM
	Eer/VJyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrljP-001thN-JX; Mon, 29 Nov 2021 18:50:28 +0000
Received: from mail-bn1nam07on2042.outbound.protection.outlook.com
 ([40.107.212.42] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrleh-001r80-6O
 for linux-nvme@lists.infradead.org; Mon, 29 Nov 2021 18:45:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GohXcVFUmkMABOnE7H95ualBOz2OyrRqmAokGMpKFwDy8/ejRHycVRxmZg7V8lc6NKXWiZHAseOgwAGGmjzOiYpitJGCP0DCxkTuGJ8TRcgd2yyiKmZtahez5dWOUTgAkms7eZcXzqOQV8x/tcSYypV3Tzy2yFpsju1ifi22OnUh6E+CfM9JVpsUd68685j9l77i6SDHl97pbqSVgRFLbvBz3+Er5jyrhnYnE2qR/5V9/F+MbGdxz9jxwo7eZVpUhr514dhBAMLmjFj/hoJDsRC23UR+NkiXOkUlZypcBtSd2tY+JawoY1zYyuCOLYGlfYZnHyhUIid6SbcssmUL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQv0fcyrfJNMCbejXbT6YpUfWsvs8k2qHr6Y57Y+13E=;
 b=LOFkCs5j+7H3GG5/tUB968nbIj071PE53r+TXgaM6QQ6J5xM0GHd6qjKae6tEqPDWojJlL35kEsFa7Hk0/QXjerY3VBOCMJ7nEvvxZ4Fhe//0kskGrqqX86tWdKha2ZuMYsK0sAnLAZ7rAenaxY6DJ1Qb91Y1PzFuJLc6bSOlIcUDV8GeWuEANe3a49bV73dTae5cbYHKKpLKIHPkMzggkFkS7Q7v5C31wZnLggFSl3Bl+T0IAoYfCFRZ34+m6QF9n6W3IMqpLggf6hJ1gHBm6ydJC1lAW153ktu4qFglBuWgZjSTHAmrcjXZweve/bnrpPOVpiMEc28goRn5Y44Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQv0fcyrfJNMCbejXbT6YpUfWsvs8k2qHr6Y57Y+13E=;
 b=XWpTwW6Xe3WZ9Xr4mDiVYE7tktUbD8Ll77QrCyZYFPY6yLjqdit1OmudxWn6MFvm+EaVJ1TC8+7RznQ4RABcKGlktNS5uS+80rk/KE2Itc4mnRzeGLbQNT0EuRzWXQfCh9LCAT5w4F9eqQ6ncxJ9jItfZGNz27nOsx6TtUbwZZDCaRidz3lqxFGDStviK5dooGNdECW6gfUX74HxyRAkAPuY7fVREK6waCftPRh1SKC3AF4IsLpz6lqOKUvd9MbVScBIlkLJQz4b2TS0L3eg+d7vxPMYaCrQAIpaq+rB6tAmGMwepejAovrfAV8KycfVhgSuDFAURwtb8DqUSgGGHQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1136.namprd12.prod.outlook.com (2603:10b6:300:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 18:45:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 18:45:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: show subsys nqn for duplicate cntlids
Thread-Topic: [PATCH] nvme: show subsys nqn for duplicate cntlids
Thread-Index: AQHX5T3ehOJpDvYDAUeoMqhKtLMI5awa2BUA
Date: Mon, 29 Nov 2021 18:45:31 +0000
Message-ID: <1d5d1e96-8d62-af25-1ca7-270eab09fcbd@nvidia.com>
References: <20211129162434.3611259-1-kbusch@kernel.org>
In-Reply-To: <20211129162434.3611259-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c280410-67d0-404c-8132-08d9b3686bc7
x-ms-traffictypediagnostic: MWHPR12MB1136:
x-microsoft-antispam-prvs: <MWHPR12MB1136F6434BB171E004AB69C1A3669@MWHPR12MB1136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+KtpPcR1MrxmOh3yGKCUqHya0AuxelPzwdIXcmnYIyH8eLuDOqUKSqjieanNbaJ0HoojL04GWrFFKiD17jj4rScBx+Lnwrb8EpIB+nwi+RCNUtt8pgexDYcCOcnByEV1T/gO92QliXGWBN542jRDel4v+SmeX6rDbuOYd8mJ13FxgyWecOERbC1YKtb6cUPz4c8+sca5poQYnVkGig9mTUD1sw9EAf09aNKq9OHKhO6bYsx5KfmYzfgoxRF+RFnhaIE2ZjVVHpcD4l327HK86l+o+9pyeD8y/iWMDaNQn5dYXOxhl1+zj0kiC3+BZ0utre86LpLT3/eDwVBD+A2wbIAE2NJH8R2Ofl5ufJVJ2sFcReVwvbBFMRjmynmI6tIHbdjcXl7SJvCLDARCfmEvZ4gR3Zb/7UfdCDxZdMyT3wBYsQsKEpyjwxJGQCZKmzW4uvYr9z08kzLT8/M41W/VvJQ+Hk4ZW2dD9aDcyOfIYIvS8Br6GPXFx6iYSW3Ja+/OLH73cM0ONJ6gCLHaL2rA+C0hLOeODJyM9hoDeErFQgG0RacITYXh0NMVzYuz7VBwXL7EfEfEHjRzVbWU4kZ0J+krSjy3XYuD/zxPusWkJR848jBVmm+9WUFrfmQ0UEl8rcA8LYgaWJ4WT780UlrB6DhhkiqvIqpQNlOWwZjpymLO+9it5GqgHo7ujNq4hwfWfjfoj38OWKPfgG7bIFeB4b+hjqAVrQx59fIWfOZItnpIcNOYspt0sRKdTZa6pMWaKMyqiiT5lxkemfdrlOiW/WDtsySwNVWl+5I0Lm5B8As+sazp7Wve//L5NrNqs2PyMsFeAvdDfOSrmSIbKgGlBvS8gbtUvDLq2DbZ3K6iP8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(966005)(36756003)(38100700002)(122000001)(53546011)(4744005)(2906002)(8936002)(186003)(508600001)(31696002)(64756008)(66476007)(6506007)(91956017)(38070700005)(86362001)(66946007)(8676002)(31686004)(2616005)(110136005)(6512007)(6486002)(71200400001)(66556008)(66446008)(5660300002)(76116006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVFNOTIramhXbnpNakVTTjdlU1RpQnFPN1Fab2tiVmtLeWVMWUNwUDN3TkFp?=
 =?utf-8?B?R2g4eHVrd1RoL1dhWUxySjJJWmloajZ1eHJGRkNURjFiN0dNanAwTXZHY0VP?=
 =?utf-8?B?cW4wTjV0OWt4SXc0Y1Y5WlhCRzAvdGIxMlFCTGt3UWhzSWZKbmpxbXh1cUNm?=
 =?utf-8?B?OWlNTW5HTlFPNS9qb3JDcDNDVFNWRkxiemRIcW1mMkVNbVZlWC9QVUFJdjJt?=
 =?utf-8?B?eG03M3V1MXFSbVVvejBScXd4YVltaEdoTXl5dWZKMGkyMnNsRDhnMGFyWFJN?=
 =?utf-8?B?dkVGeVltMnhrckxaSElDekZFTXUvMXYxNFNtVDk0aW1FZ1hQWnAyTUR1SUZU?=
 =?utf-8?B?SWZsZ2xDREpxczFZQm10b1VPWFl5dUJZaHAyTFpscDB5ejNrblN3WTdUNXN3?=
 =?utf-8?B?Uy9FdTQwS0hsc1JIUTJIL1RVU1RsZ1FUUE9GRjRZWjRHaEZFQUhyYWh6cmFL?=
 =?utf-8?B?RmVkMCtTVDNZZWpkZzNFbWM1QW4ycVY3TVNuS2ZGL3ZhRVo4Y1V1WkVJUmVM?=
 =?utf-8?B?VHl6UFQ4c0hadkJJZ2Vwd1l3d1B2MFZvUW1vQ3RSTy9nVHEwUHl2SmVqSzdV?=
 =?utf-8?B?azE0dU05dzJmSy9yZ28xeVoxTkJpSlo2R1Y5Q2MxbUZHL2t0Z0dPLzIrc2FO?=
 =?utf-8?B?L3J0WU82dGt0UDZUQkI3K05xbGM2OTlJWjQ3RXBOQmNFTitQeWJmUXdBRklk?=
 =?utf-8?B?QWR0eitKRDNJaHZ4R0VFT0gvb0RhNW10YTZwQ2dKdDBKUWpLTDVrcDRRUlZR?=
 =?utf-8?B?OHN5ZmtxTDRXdjcxK2VIcC9lTGhIejEwNzczbE9nYWJPNDZ6Yjl2QUw0Zk5l?=
 =?utf-8?B?WDlCSGFJUWMwZ3V2TTRERVJEbWp6U3ZKVGZqVGN3YVpsWnhkK002SXl0Mllo?=
 =?utf-8?B?M1ozdVNNQjNQNk5Id25UOENlekpndXp6L0x2V3c0N0U0OEFmclYvTXJQNkhm?=
 =?utf-8?B?a1hlcVFSNnBJMXNxaW9YcTUwY1pPSWpSQnBhSWVsVmhCTnA1aE1GVUhtejBj?=
 =?utf-8?B?WjB4d0N4cCtIMFRlaVF3UGtLcGlTcysxc2s2TkZKdWlmWCtHdFpKc3lBeFlh?=
 =?utf-8?B?ZEZBUEc4dE44UUZ5S1loUGdyRlJhS3o4ZG9ROXlIcHFJRXduNERzMFN6Q3hF?=
 =?utf-8?B?K3VnTHZzZjFLbHFXc2hVTndPdmx2QWdvNThwQU15ZXZYRHoyK1RyTUsrUjlV?=
 =?utf-8?B?ZTc2WjlHTWlrWVNUUVMrdmVqVTNCK3VFcndselRhYWJwa0I5aXROMGRabFU1?=
 =?utf-8?B?ZUVyTFpjWGFRS2NhUjRsbDBmSzBjSEg1dnZ0NE5lcXBqNmRNYnVIdEhHNktq?=
 =?utf-8?B?ZnROYVFBNUdPYko1LzlDcEpRVFoweTVJTytGL2ZYRXhLbERuaDZxeEtwejYz?=
 =?utf-8?B?NCtKaFpBZ05HT0ZOVENXbjY1ME9hUjI2QkJwZ21YV1lTdUdKOGFJeGc1d2t2?=
 =?utf-8?B?dVZ3a09yZHRGamR4ZmoyV3hON21ML1dnMllnWFVWY1JacVpHcEQ3eUwwQXJE?=
 =?utf-8?B?Z1o0M0JhNjJ0L1RoN3ZVc3djOXNJaldFMHRDMkIzL3VKVHVCSUFPZ2tiS0Zt?=
 =?utf-8?B?anFsTVB0cWVMV1FFaVNlKzU3VTJRZ0pQRGpQSzVxeE1aS3dxRldTOHZ6VElT?=
 =?utf-8?B?TWNaNVhvWjlQMThaTW9jc3ZIaG1aSHpib0NnNVUwV09vVGd0czN4dlpESmdZ?=
 =?utf-8?B?NzB0cWtrRDV3SUVXWmd2WjdDcFJJakphcjhKSzdaZDk5aGFRMzBJTDFLVWpq?=
 =?utf-8?B?amRDbFZxdEtDckI5TEp2WitTeC95bGZrMU1pTWUvM3daN2M4R0lnUE1qc0lu?=
 =?utf-8?B?L2NIS1dqTlJ5aEY3QldvNTNCUStsNWpuVmh2WlBTa3QybExmOTZ3YkNkL3ZN?=
 =?utf-8?B?WmNCdy83SDhnZG5XVDFLTWJhUTJIa2VoLzVSREEvZEhqc2xmZlRKRmc2Y003?=
 =?utf-8?B?ZXRVVGpENEdoSEJrTVc1UTdGOWdGUUpWYUQ5UHVoRVRBYTlJWGdKUENKZGY0?=
 =?utf-8?B?UFF1VGlraTdaNmNjNEwvcW8raGNteWxCa3d5L0tlUGdLU01FYVdOa2tWRjZT?=
 =?utf-8?B?WUJEa1I2RVM3b2FzWWVpdGRqRHRDYXRHaEtnTTVwa3FJRDhxWU05SldlSXFH?=
 =?utf-8?B?R1pIMTRISUJvSVhMUVB3eVBHZFZXcTVEM0RjWHNzNWdXdFE0Y2djeVlPU0Zs?=
 =?utf-8?Q?aUSCgzOfvqT75YesQvRWv9V0gZPiQNNJ+3n0HtG/EusV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C833EEB48D17F748B65814DA1E637EC0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c280410-67d0-404c-8132-08d9b3686bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 18:45:31.4554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJtIfNsnFwMjYdwoN++Q8RojU5taW3VJSbojDvVN509dipaGwV0fPGRo4B2afvgPY5xeTWO8WR2T7wzjFrDShA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_104535_290268_2ECCBB06 
X-CRM114-Status: UNSURE (   9.39  )
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

T24gMTEvMjkvMjEgODoyNCBBTSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IFRoZSBkcml2ZXIgYXNz
aWduZWQgbnZtZSBoYW5kbGUgaXNuJ3QgcGVyc2lzdGVudCBhY3Jvc3MgcmVib290cywgc28gaXMN
Cj4gbm90IGVub3VnaCBpbmZvcm1hdGlvbiB0byBtYXRjaCB1cCB3aGVyZSB0aGUgY29sbGlzaW9u
cyBhcmUgb2NjdXJpbmcuDQoNCidzL29jY3VyaW5nL29jY3VycmluZy8nIGFib3ZlID8NCg0KPiBB
ZGQgdGhlIHN1YnN5cyBucW4gc3RyaW5nIHRvIHRoZSBvdXRwdXQgc28gdGhhdCBpdCBjYW4gbW9y
ZSBlYXNpbHkgYmUNCj4gaWRlbnRpZmllZCBsYXRlci4NCj4gDQo+IExpbms6IGh0dHBzOi8vYnVn
emlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE1MDk5DQo+IFNpZ25lZC1vZmYtYnk6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg==

