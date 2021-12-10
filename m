Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4F8C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QpjNM0UW97bK1BkiCI1SzAEjOs7usifCK7qeUXNfWyg=; b=vhxbqkOA6TtFJljkQd4PGiJx2N
	upbLXF4DAuqiGl6ZrrspQ3iVc2KvMEvVTpA2OHa0kfRhCMZEDgzW9qlCagYDuF7fGalpAY5DoLXex
	kuxw9hXBG2w/NUOmm69GkqymuzxqjvraM9PfObs3JnTL61uAaXRunRzR3eKTKnh2Ocd8gU69jfuiI
	zDFh+0eoMmpqNrrJlInAbuTtQwfQTcL81f2Iom3dCn9WlCinkvuoUZSGaVi0qKstTkv1R5S/KpQvq
	Lj4WNc8aHD4pnZqTaE4ab/o+35FpBTKnaLW8mG7WTZwGKby3SIw1TWyEwAznSYdjkqDRDBOqv6rQ3
	O0Tk7sGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvjzX-002yaC-MQ; Fri, 10 Dec 2021 17:47:31 +0000
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com
 ([40.107.93.66] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvjz5-002yRd-F3
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 17:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmzcuLxGiZtiCPbezx7o3MrzJVLZ2uklTanW439cMis3BCvH3wh06qADRzcpPkM66ZIlk1T7y7eBGA1unxcYQ7x4n8cZbYsuvptZs4qNUzyrBY2ROhYiKH0ufOAAgxgkTw+h4kCTkrreWLjEbsqHPQVNNRWAWK1zDqRUENevH56XRLVYk9rxa7rlyRvKUIO03ruxBqtVnxHmyO2H488yYzoPtBJPrRD8wvNTNsCP0N4oHK6PHf5pJZorOJf9MHCNC+cGVv7jBN36a8vaJdshAaTEhGKNleYGiiDp3mN2YR3KFIgGFMZgGLj0KBaaeF6HQd5pB32K//iyi4JPQ1JvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpjNM0UW97bK1BkiCI1SzAEjOs7usifCK7qeUXNfWyg=;
 b=U+dGhWnZIN/QMcu7on277aG5zJ2XHezk+jYSNJeGeHQBu6fkdasK3BTAqtNpWZozjfz+hXsthMg6/7mzblOpFiHXkgdClv7MdspevtslOqLs9F/uEty5+3KCgp5aRYi9+p0LWPBuw61M685TW6zEYw5ZsRxFSsMbUL06zrJ/FNXzZrHWlvVFPLR23JFtTMq2lpm+oo2BAgvpUA90Iv+maDKMMaI90fE+iTzvwmHMjeLO6RaND65Uq/AoTMv4IaeaL5/oLl1AZj/K9muFmg58UR+iuBmK5KLckwanhhdMLhfgfPHR80QkOgz+jZIlNFg5tljuS7fKgfIQkur9PZiFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpjNM0UW97bK1BkiCI1SzAEjOs7usifCK7qeUXNfWyg=;
 b=uqkdhNF5rsw577dJfxufeaqTiWw4X9dFAiXOPin0/AXmEDcMpxMzWP72O6BeLtWWp/0LIitC8o7Iqd+TiKTbEUGBCxVz/C0BN6vg8VLTDj/odoq/argAiE9XoUgv0Mef4aKO5m1yjHICAY7tdwrUddEiX/mjvJJljgpmp9sc/j6UOAs71rNHUGoWcck57gG0wVQmRa5DrpGwk+rLzEWk+PrgUoyga27MYu1xgrIV9eK/Nyjye6lmKPEcxW8mW8PZQpwF85X5SygvXF4ErRfH00AU1zYg/12LoZQ8L5f9Zndy8AVFhVeS5RJFOL9aBd2VA7uw99FttC9Bv2Fzt1/5pA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:110::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 17:46:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 17:46:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 2/3] nvme-core: move gencounter check into nvme_cid()
Thread-Topic: [PATCH 2/3] nvme-core: move gencounter check into nvme_cid()
Thread-Index: AQHX7bgvtLb6GLoTo0CdCskgu+VpBawr3eQAgAAihgA=
Date: Fri, 10 Dec 2021 17:46:59 +0000
Message-ID: <d0ce0b57-211a-5e04-9528-a99a83f22600@nvidia.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-3-chaitanyak@nvidia.com>
 <20211210154324.GA3856533@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211210154324.GA3856533@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 729178ef-dfdf-4493-786c-08d9bc0510dc
x-ms-traffictypediagnostic: MWHPR12MB1726:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1726516F2BFBD166033D29C3A3719@MWHPR12MB1726.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovNjhmYbJ9N4COsbP41S5m6rnSfpn4nti7F+kDYKnegjs/JyP4PG2aDwcpbJKfEEk2i/0rbj2tezjDdSzEWOrk2VCll49UQBU/8j3LYNQiQWnCv/lLtYNUFtUDHocCs5yisWuGK087f0eWaRD0SxUj1HPUlZiJZxch5bY/pKUqf3n62N/p98QBIU1m9R8kR9Beow8M1TB7h9+Q3JBB//IGrBYqroWe1/UzJNWbLhIHzsssdHllVbkyruY1nklHQjcD5S9yOPWR4YzSuiBhP2RNdJyzZcPLZtafsJGXDUDGATk10PxCUHn00R+1C9JsyC1Y1dCX20pFs93reg6qI2QzZAMCnARc3KNSsq4y3Gr91o4EYRij3HAy9c+6Zq5XciYHz9E1kGscmg9DT1G5sq9C/q9F9XT/yZsobmm5o5QdNBSieEQDfhpOelzRLCPFjKdAGpnhSFr1TlhoNLkmRhmRv79gN+z3pSHBenZy+YQkLxBauv7HFz2kN7PRZqG9pIuoooF2UhnUfPNbZn6HQZh8hZvk3OXdGQAKLCKJU/wJZBTfzgl/lqkC9qyrklzJKxGodGWoTFChjbOMLribX0df+Gn4kLF9Alkjalz4HxF6lwa7Nu2otzzRevQlDDTRwlnT+KMCMjvKuQebwwMct5kmtz3CQNJQum8/pIND6mekjfVjtzs6S3MFXuYXVkNIVVddbw4GjUTAYcdqb17I4+hnqz904oQjYzpqUVxKk1/2Br+owkkYQFMd+oxsMJmpveQEDywS1zeDg1Qe4kMq+CRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(6916009)(122000001)(107886003)(38070700005)(31696002)(54906003)(6512007)(8936002)(6486002)(86362001)(4326008)(2906002)(316002)(31686004)(36756003)(6506007)(53546011)(186003)(64756008)(66446008)(66556008)(66946007)(66476007)(91956017)(76116006)(38100700002)(5660300002)(8676002)(26005)(71200400001)(508600001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFMrbUxteWV3OWMxNGo1ZUdZcjdtQUh1eFlTaURSSG1FN2VjNVI4eTdvMjJC?=
 =?utf-8?B?SEFTYUQxYVh0bWRTTEVJdEhXTW50bjMyenFuOTBrQzZ4VlhiUE9KQmFWMW83?=
 =?utf-8?B?M3hmdllTM0NwNXVzbzVmOWRjUUdadVhObWVuOThnTUFIdFNhY3ZJMHNuTnZU?=
 =?utf-8?B?QzN0R3g2YzFpR3NISEJVSUFUSDZDaFlPWWY2SHh3ODBxU200V25KMlI1Vm5Q?=
 =?utf-8?B?NVQ0NVZ2TlZ5bmFMZ3lzbEl4TkgvZDcwbFdpbHdMczZtRGlEZ0tDTjNxdGFv?=
 =?utf-8?B?WVFsenJRNUV0UmxRVzJwMnhpWCs1bGJKTldLelBYS2hiQUlTQy9XWm1wZk1O?=
 =?utf-8?B?TjJjUE1ocU1VK1pmS01jMGJNRWVDYWk5UnF5OElxM2VxemNVaTcvKzI0Y0ZY?=
 =?utf-8?B?NVJlV05FSGdVUnE3Q1dvQmgyTmpmMit1Tmdocm9qR0Z5VDZSZVRsRGY3WFM5?=
 =?utf-8?B?OEdhT2xocjQ1b2RnalZjODk3clpCVXQrQWxna0tEWS9wcURXYzhMWHR2ZnVO?=
 =?utf-8?B?S3l2b0NCejdlRkRJTUpZNTFPRjNJN01mTXNVQjRWWE01YXZrRXE1NTEvcVBn?=
 =?utf-8?B?bDdvektTRzhSMjl0Y1NZdFdHM0N5Z3RkSWtZU29LOUNhTFNUOFV4R0JYZ0pH?=
 =?utf-8?B?YXU0Q3JTQmIraHl6YkVkRVc0U3RNRXhUanphbUtlRkNpd1lOL3B3QjVDdUU2?=
 =?utf-8?B?TTFlVnlkK0JUY0dQTzk5Kzhwb2x2QWprWWlrcFlJMSt2cDVmSTNRR1d4WnBE?=
 =?utf-8?B?dUZFQmgrbjBhWUNMRUFPYm5lOE9tS25CRGtXNWM1QVgwZjEzWUJHU1lHSEN2?=
 =?utf-8?B?K1YyTnZBYXQ5bGNBUi9FbmovdHdEc0ErUXg3ZXU4anQxL1QrWndjMmlseVBJ?=
 =?utf-8?B?cGc3M0pmcTEwa3hWZkVEQUR1Z1JtMGh2THJsYXpPc3NmU0ZDUjVEbnFOa3JG?=
 =?utf-8?B?YUZaR0dzaDZzdDB2QXRZVm51M2tiV2pZUkQzQ3YxMVR2Sms2aklTWUw1aThr?=
 =?utf-8?B?VGxUMEJSSVFpdWRVcDFuNHRLanNTRVkzWkR4Q2NvVytjRy8wSTE0cDVaeE1n?=
 =?utf-8?B?dGk0TXZibVlSVytUSkFOeXVFUkhZZXBDT2RqZDg2b3RSNGd2cmlWc0FzZ29v?=
 =?utf-8?B?RnFXT0xZUDdkbWZFRHZBWjFiVDJxVGpEMStROWVUQU1FcXZVeGlWOS85eitV?=
 =?utf-8?B?eHM0Qno3eFV0MFhuTjg3cDV6clQ0UWZVdFB3amhYQUZUcFk1Q2I4S1dqTjRN?=
 =?utf-8?B?N1JqM3M3dFJTeTVLcnN3K0M4bGRCOWVzVzdDQVd6WmJzNXE0engwck91bkVG?=
 =?utf-8?B?THAvd0ZEQWpxdDlQZE1zY0dHMmZMVDVtVzBTajBMTG02eW5DcjM0OUdNbHpl?=
 =?utf-8?B?QUhQc3FndjhtV1JCUmowVFhNY0xLRDZNTUgwVy91Q1dyZ0RxU3ZnTjBTWTdt?=
 =?utf-8?B?R2J6dllBeHF0ZHpqNXA2Ykg2ZWJYTGVKdFp3Q2dlbm9YQjI5MzNRZUljOVVx?=
 =?utf-8?B?Q2ZhWS9ZZ1RVUy9LSWJWNktId2RGNmJzdzlteUxxYmNybW13TEpUbVppT2tw?=
 =?utf-8?B?Sm9OOVlWNDMzeWdWb3BIeVVFVVphN052RGpUbWNDV25RZENzSEMrcTFwNjJN?=
 =?utf-8?B?SzlzODNCT3RZUnhXT1A3TFBJMWN0QjJCQ05ZR0YyU1dGY2V6OHlXT0loZ0xh?=
 =?utf-8?B?a1Bjd0pXWHRtQ096WTFwNGNjSjRmS2kyVERGcEZ1MHd2ZjFNN2tGcFdQdDZw?=
 =?utf-8?B?eXl1MGxDTi9RSk95cTEyaEJPR0xxQUlwMlRoaDF2MjNoa2VFenhjZ2drZWgw?=
 =?utf-8?B?bmtwd1V0Z1hFbWsveG95eXUzdGhBZXBYUEJnSFQyemwwR3didEdUWnVMRjNB?=
 =?utf-8?B?dEJVSWFMRlJoTEtxNmJIeWRad2tDVEZKd3BWVmFoQ0FXZGJtZFZlZ2JXNzRx?=
 =?utf-8?B?QXpDTGlEMHhYRzBjdUhtWjhLNk8xZCs4eS9aNWM4U1lneEQ4VHo1UkRDVUc4?=
 =?utf-8?B?RXNIbWEyeXZUTXAxMXN6ZVVET0JrRVlNTmIrd0JqQW55eW1zTDZ1SnpKRUdS?=
 =?utf-8?B?Q3JWa1lBSnV5RmlHSlA5a0d3eUNtNHRQRjhzYkIrZG5oQlpGbnJ3T0xkZ3ND?=
 =?utf-8?B?REVIOXhPbUxKNkRXV21XbkI1N28rS3B1NC9uMStITW4zcEczR0Q4ZUtLeHUw?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B64012052F34254C83AD14051C938817@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729178ef-dfdf-4493-786c-08d9bc0510dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 17:46:59.1939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiQC6QM/mZBhBa1tzGPIPVT6K7BlbrISUliThzzKBG7uUxqYLXrNK/QDJmRuEot0BRNU2gNTWnzIjqZc/QVMnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1726
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_094703_703486_37C44A3F 
X-CRM114-Status: GOOD (  13.85  )
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

T24gMTIvMTAvMjEgNzo0MyBBTSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24g
RnJpLCBEZWMgMTAsIDIwMjEgYXQgMDM6MjE6MTVBTSAtMDgwMCwgQ2hhaXRhbnlhIEt1bGthcm5p
IHdyb3RlOg0KPj4gLSAgICAgaWYgKCEoY3RybC0+cXVpcmtzICYgTlZNRV9RVUlSS19TS0lQX0NJ
RF9HRU4pKQ0KPj4gLSAgICAgICAgICAgICBudm1lX3JlcShyZXEpLT5nZW5jdHIrKzsNCj4+ICAg
ICAgICBjbWQtPmNvbW1vbi5jb21tYW5kX2lkID0gbnZtZV9jaWQocmVxKTsNCj4+ICAgICAgICB0
cmFjZV9udm1lX3NldHVwX2NtZChyZXEsIGNtZCk7DQo+PiAgICAgICAgcmV0dXJuIHJldDsNCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252bWUvaG9z
dC9udm1lLmgNCj4+IGluZGV4IDk4ZDc2MjdjZmRjZS4uMmJlMDE5MWUxYTFmIDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oDQo+PiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9udm1lLmgNCj4+IEBAIC01MTEsNiArNTExLDggQEAgc3RydWN0IG52bWVfY3RybF9vcHMgew0K
Pj4NCj4+ICAgc3RhdGljIGlubGluZSB1MTYgbnZtZV9jaWQoc3RydWN0IHJlcXVlc3QgKnJxKQ0K
Pj4gICB7DQo+PiArICAgICBpZiAoIShudm1lX3JlcShycSktPmN0cmwtPnF1aXJrcyAmIE5WTUVf
UVVJUktfU0tJUF9DSURfR0VOKSkNCj4+ICsgICAgICAgICAgICAgbnZtZV9yZXEocnEpLT5nZW5j
dHIrKzsNCj4+ICAgICAgICByZXR1cm4gbnZtZV9jaWRfaW5zdGFsbF9nZW5jdHIobnZtZV9yZXEo
cnEpLT5nZW5jdHIpIHwgcnEtPnRhZzsNCj4+ICAgfQ0KPiANCj4gTm8sIHRoaXMgd2lsbCBpbmNy
ZW1lbW50IHRoZSBjb3VudGVyIGV2ZXJ5IHRpbWUgc29tZW9uZSBxdWVyaWVzIHRoZQ0KPiBjb21t
YW5kIGlkIGZvciB0aGlzIHJlcXVlc3QsIHdoaWNoIGhhcHBlbnMgaW4gbXVsdGlwbGUgcGxhY2Vz
LiBUaGUNCj4gY291bnRlciBjYW4ndCBiZSBtb2RpZmllZCBmb3IgdGhlIGxpZmV0aW1lIG9mIHRo
ZSByZXF1ZXN0Lg0KPiANCg0KWWVzLCB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gaGVyZSBpcyB0byBj
cmVhdGUgYSBuZXcgc3R1YiBmb3INCkNPTkZJR19OVk1FX0RFQlVHX1VTRV9HRU5DVFIgYW5kICFD
T05GSUdfTlZNRV9ERUJVR19VU0VfR0VOQ1RSDQpjYXNlIGFuZCBtb3ZlIHRoZSBxdWljayBjaGVj
ayBpbiB0aGVyZSwgd2lsbCBzZW5kIG91dCBWMi4NCg0K

