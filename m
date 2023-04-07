Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D6BC6FD1D
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6zCkItg/47On1NJzWckw22zJBsr+uFN1gSEB91Fgvzg=; b=o+zFEyOWlo8bb15gHuQmLsGmUz
	nSI49eBdbrFasheekSLfgfucyc5llW4fgM6jFm/4PL7hrtaSa5RYT0KRNK1RMaDhudMRPnYEIMQaa
	WbuT4zGn4b/SAzxjzjnYwTj4yDsJiDnq/BYB9AEc/S7GPl6oTpC4kFeHX2xtsmVWJeYbWMbEEzcWM
	e5ILu5slifxUmBNuZjP+s78qir/4yOnOnjqjlSGKMgV/il2QBf1Ly2IDJ2l9rM/CVs/xF4pmmeu86
	hpD0e+UyDPxSO8NgwiHQCGkM+hQgV/0H1E1DLzHgVpgJEuHeVD1pVZJ3yJWCui/P0GG+TYBRzBoGC
	clYLwCcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkqCS-00AqIg-01;
	Fri, 07 Apr 2023 17:48:36 +0000
Received: from mail-dm6nam11on20612.outbound.protection.outlook.com ([2a01:111:f400:7eaa::612] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkqCP-00AqIE-1L
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 17:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etS/XMhv8FWv77oqO++yaWM3FcwAkez7h8Cw7rIuTdZihWsGPgxPcs7pYN9s9ys227/oJTPcYChnktB5ou/0hnnERUNZwYlqce7uFTr96j1YXV238Ss43YypAQ11HAESvFtuDMzzlyeOwfNl4Ir/NHob3HmCAeoEFh85D1nuM1/cEQattcigCe3+JmQUQNpXOeXsuLrLw05ggqh+Z8go/egOb/eKGIcompXcNvhc49dyuQJrZhr88MhTiJlc/LObTmwXp/3qjtSNoDJS1MTZiA81hhLleGpH2n7+orMS1ewSYB3p/gGy6gf4VjwOtgeO7TAuIPxr1bJqNMCdW5pxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zCkItg/47On1NJzWckw22zJBsr+uFN1gSEB91Fgvzg=;
 b=MexYOt1roufSOUfXPM0qqieeWiA9EzZFCZq2XkPVYxugHVjANrA3k5BZbeV/1qMLSgD6gXoALmCUF0R3VldiFvHNLLZlv7YbCfK0KjnmCEDIXd8XVhhr6e5oGsP2u9FK8yhzJLLsCHO2TyR3oeTeidkBDN+CPZPG07RVFfAAFis9S16zcwxC9Bwd5JRQiGBfNxseFTfgQZ6cF9ObaXbEzKuYX0zU6D0YPhv0/skcfuCtb+ua2Wq35iMnIzZKysBdQ/CLiQtqTpf9dUZru4LZMuGbfevS1WjjKClOdBWxwz3kMu1X0VOCuaMUW7dxwBz1gxgmK45oukjvUbjaTb0GCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zCkItg/47On1NJzWckw22zJBsr+uFN1gSEB91Fgvzg=;
 b=aAiWuILbFrC3+oNLohm5ff04ySYCL2QkItlLnc6y4m1b93U7g8UMEjSkKrbLYTXPgI8OkqVUfpOspvOoB92xlJ1nde7Cir5J7XVYaMYNf6vujUdF89aT7FptTVG1p0znIXS6Qs4xQem1Ayrao3au0ooAy0uRP7PcJv1nKJ1qCgabTkWMR4k9W0GGwRNfVOVFmELWj3KbsyMt8nxN5Gkct/wVMIObPE3oln8zFF3I2ChXuwrmf0LuSW8pUTPntXS7HnfU2LFZ/o9SeMTqhOfuhraq9GJ6xsUlmf/QLqfcJPWjrGs/CUOv6XzxO6GfzfU5ot55L4uBy79qrdD3y79eEQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Fri, 7 Apr
 2023 17:48:28 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::c447:32e5:4322:403a]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::c447:32e5:4322:403a%5]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 17:48:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [RFC v4 1/1] nvme: add passthrough admin error logging opt-in
Thread-Topic: [RFC v4 1/1] nvme: add passthrough admin error logging opt-in
Thread-Index: AQHZaNKx6zIAHFQZF0W8oLoBQ6xu968fRgsAgAAy8QCAAKexgA==
Date: Fri, 7 Apr 2023 17:48:27 +0000
Message-ID: <62b3cc59-ab4e-96b4-542d-b43e57abfb43@nvidia.com>
References: <20230406215544.113127-1-alan.adamson@oracle.com>
 <20230406215544.113127-2-alan.adamson@oracle.com>
 <4ad89897-f4a7-59a4-e7d0-e0f79f4cb1f6@nvidia.com>
 <20230407074818.GA9335@lst.de>
In-Reply-To: <20230407074818.GA9335@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|IA1PR12MB7711:EE_
x-ms-office365-filtering-correlation-id: b28fe922-1123-4025-7b79-08db37904b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  +trPee+s2B/FvQEPMEEziN2iRDjgmYOtueD+sdIWVal2R2xRpeDqcUmgvEXw6ZG7BV1MPlF80wcB4B+aBp1OwpjM04zziJmn2Ckh40CgX0543RnXPGsJhCzsVGSpMKSsm7kuhYIxp3Ct0tlO+ISLvptbF6BcKMtI3Iudq/AWOgH0QL6y5zdUrdX1twVsYaVSSa3fcZooXdHEVt/f58x3UCXZDI0ZgnQZ1wR9lJb2pxcyD1iQgBtoJr/MJ2SGMsets7IJOS3+O7TBvuTwm5vJ9EzN0aM4HNRs+Fx9Od78Kkf5O0lcWBqvp3zkO0jncog9l89QDKse5hqG+MZ37mX4jbSCOKRQvM+E4gkKm+/K/WDnpj8gqejoahB+IsB6zwxV3K1wBsVGhMMez9VqpfoMaZtoiAEuvbtMMCkyVgKU1As6ycu5+svSmtwEXjDUAXELb0tJHhEm7Fq3Ldbqk4EOLeaWl+jIBI8zii3YyhYVYCDUYTAfzL4jibC6NhkyAATox/hlwlYwjmX4yVXHYDd7M7lzh4EsmN4uxw4afVMwpZ/EMrrbUAvGpkkdAT7HMA4UVF886lIm1Ru4U4oXGIFjOlAMC+cuidtxsBLyfJ+OXREgugQS4Zp0aiwTIxrr/+683UJSr7LJTCHXpBvfy6QOnVMU5J24KnCS5PVz5DVUxPjCeThvNyQtRXumHMkHh73j
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(86362001)(38070700005)(36756003)(2906002)(31686004)(31696002)(91956017)(2616005)(6486002)(53546011)(83380400001)(6506007)(186003)(71200400001)(6512007)(4326008)(76116006)(66946007)(66556008)(316002)(478600001)(4744005)(64756008)(66446008)(6916009)(66476007)(122000001)(41300700001)(38100700002)(5660300002)(8936002)(54906003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?eGdQN1RmNFdDT1AvQ01RMmNHVXV3ZTVnQUNTRzFsQW9meDM3U1duMk5lTkFQ?=
 =?utf-8?B?YkVLaXdqdDNyM0xFY2VDL0RIYTRxcFh0emsrU2lPcW05QUFxSThBWm4vNEFs?=
 =?utf-8?B?L2JZV2dOdUNrQ0QvNW91d092d25LMDYzeEZIVWJ0Q2s4QTZ3VmxWRGljWEo4?=
 =?utf-8?B?WU15VzYvRFNwNEROeUd5RERYa2p6L2c0ZjJPNVMwMHoyd3lZV3RubkdPMDM5?=
 =?utf-8?B?KzdEMDdid2Rsa3VVY2xOQ2t5cW9DMVpDUHVtN1pGQU5xc2EranhlN29zQkor?=
 =?utf-8?B?NVFpWXpOL1R2VEcrRlhZajhvTXEzVDB3bGdVSWdTaURzbGljTEtOcG5SN3Vq?=
 =?utf-8?B?THRLRGdmSEltZlNWQ3JKeHBmQklKWE4yalduOW5admtXOGxmWG9VU1RZYnVz?=
 =?utf-8?B?MUdDWU54ZERQZEdOVmk1K2xsTURPeFhnZlYzYk1hYis0Y21sd1NxVzJDdTh1?=
 =?utf-8?B?OFJEOThXOXJBblN4c3duU0FTbGQyVzlIaVpscjBnbVltbm9WTE11MEFqNVoz?=
 =?utf-8?B?aTE0K2tVelJMdHJNRjJNOStJelZrN2didHVFUTJJeG9aTmdGK2xaN1ZVdytu?=
 =?utf-8?B?UUVSaDZ3RFBXTitPbDdsVW4rY2pPR25lVnBjZ3lpbHVHTEl3YmZ3WTVDZkYr?=
 =?utf-8?B?Qmd0bHFPcDUvZGhmZ1A3aFByT01aMXZ3dzZhTjV1Z2pBMkRsQ1ZXbko4TC9I?=
 =?utf-8?B?VGlsRDk4dk1CUzlFOStvc0czRGxzZW13SkNpbVN4a2VPN0paWWJzSTF3czVL?=
 =?utf-8?B?TlVLKytqY3BxZXBqNjJ4TzFoQmJKaDVVNUdzWTZBM2ZOMXQxSDhKL2l1cU53?=
 =?utf-8?B?WWxTS3BJcVRyWGJLYjFFYU0zeVozK3dBQkpYME04dkQ3OVAxaVlkOUdHTFVU?=
 =?utf-8?B?U2hSdEFZdVE1eWk3SmNDS011dVF4akg5QU14eWxJOEtrUHN4Vmdic01kd20w?=
 =?utf-8?B?azlZaDk5WGFxN2lINXlzYWRKSkMwZm1EVEhKSEpVT2ZzVGYvL09QVmhTMDJs?=
 =?utf-8?B?a0FPWlAzMkh3MWR6ZHdaYlRRaXNBcDRDZEtJcDZ0R2ZHYUoyek1jMk9OSFdY?=
 =?utf-8?B?UHlGcVJhZEUwWHp1RmZGNWxxNHVKWVRwdEpVLzBGb3p1SmI5TTc0dU5YSXd6?=
 =?utf-8?B?eEU2R1paWHVtRWMzZWpVYjV1ZDlHdW8wcytQaHlnNHJxUDhlc05Cb3dwdTJC?=
 =?utf-8?B?WGRHZjRBTUM1S2tSUVlBdjBlZHE4MTBoTEFJRnJHZVhySDJQWUpBeFV1NjNN?=
 =?utf-8?B?TFozUk8vZ1lXNVlWcVl2M2tWMHpsUDUrNUdXamxWTnZGbFI4Vk11VXhHY0Zq?=
 =?utf-8?B?MjdXR3hZcS9JNDNLVXRVM2hYM2FFWVUvK0xnYmp1SERXMkVyQnVZd0pacXNN?=
 =?utf-8?B?Z2oyUzNEaVNibGxhSnZ1WVBKYlFHcmlvbTBUSng0Nis0N3c2UUR5MjZVdFhC?=
 =?utf-8?B?UjlITUxZZlhBRHV3ZFZkcWxPSFM2cUZZTnE4Mm40WFRTcFhHR2RocWxuRFVY?=
 =?utf-8?B?S2VtckU5ZDhqbk4xd2hGR0w1ekxNcjhtYmUrNk8zS09YUGQ5K29qTEhzRFdC?=
 =?utf-8?B?UDg4Mm5wZW1zSjhkSUhENU5QR2JGRlIzY3doNkhKMjZ5bWxCRDR6RXpSQ1ZL?=
 =?utf-8?B?aDRHeDJzdjFhZmxTNDlPUW02eGdHaElBNE1ZM1VnTFR5ZzFYM1NDVWRSRlB0?=
 =?utf-8?B?RXRHNVRlQXVxaVNvbXdwUEtHWVNQbXpmcG43Vm5lWWx5MDJ0ZzJnNDE0aWp0?=
 =?utf-8?B?MitManBmWmoyRDNYKytDY2xkZ1huUnlYbXJDZDUrbXFRNnFsR1ZsZXVCK29D?=
 =?utf-8?B?SnNjdEgyN09rcVk0OVZJMU9nNytwM3d0bnlIQncwQmkrRmZDSFJZaHpiR0U3?=
 =?utf-8?B?UkFVYkZBSHZIcisyMXczRDQwN2RJS253cXpJeGMwMkxzOFV3R1pOV01lNTgr?=
 =?utf-8?B?blFMTllNOTVMVE5tRTlOWFlYcU5lZFlnMEVvaTF4U0w0Z0h3TFNvbk93c0VW?=
 =?utf-8?B?NC9vR2o0UVl1M1NXNlJwazZRSHUxejNzL1JqNnB1TGZXT2JjS0ZIZXgzeWVK?=
 =?utf-8?B?WHVaYUZoV1RMdHk2VjJVYzBqOFkrbzM2MEVqUEl5cUxYcnlWUHpQekc1RC9K?=
 =?utf-8?B?OXkzdytvRU03UUtNZmtzeEdoOVJRUG1DNzYvS3Z0RDZDYjYzaVovaUZWVG5w?=
 =?utf-8?Q?DIjTaySWsEVidKdveoMbd2pu+tLrZHApVLoVTEsCiShf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE33999272D9F642B85F4648CAD07E9F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28fe922-1123-4025-7b79-08db37904b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 17:48:27.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVz0HSUhtpafdxJM1GMxaWFRDXs+0X2vsUDU68QkbcyVTi0ebx2haV14DiBCzbNkXK++vGiWQdwC7MsXH3zkMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_104833_627284_424F0681 
X-CRM114-Status: GOOD (  11.41  )
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

QWxhbiwNCg0KT24gNC83LzIwMjMgMTI6NDggQU0sIGhjaEBsc3QuZGUgd3JvdGU6DQo+IE9uIEZy
aSwgQXByIDA3LCAyMDIzIGF0IDA0OjQ1OjU5QU0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3
cm90ZToNCj4+ICvCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqZGV2aWNlX25hbWUgPSBkZXZfbmFt
ZShuci0+Y3RybC0+ZGV2aWNlKTsNCj4+DQo+PiArwqDCoMKgwqDCoMKgIGlmIChucykNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldmljZV9uYW1lID0gbnMtPmRpc2sgPyBucy0+
ZGlzay0+ZGlza19uYW1lIDogIj8iOw0KPiANCj4gSSBkb24ndCBzZWUgaG93IG5zLT5kaXNrIGNv
dWxkIGV2ZXIgYmUgTlVMTCBoZXJlLiAgU28gdGhpcyBjb3VsZA0KPiBiZSBhIHNpbXBsZQ0KPiAN
Cj4gCW5zID8gbnMtPmRpc2stPmRpc2stPm5hbWUgOiBkZXZfbmFtZShuci0+Y3RybC0+ZGV2aWNl
KQ0KPiANCj4gaW4gdGhlIHBhcmFtZXRlciBsaXN0LiAgV2UnZCBzdGlsbCBuZWVkIHRvIGFsc28g
Y2FsbA0KPiBudm1lX2dldF9hZG1pbl9vcGNvZGVfc3RyIHRvIGdldCB0aGUgYWN0dWFsIGNvbW1h
bmQgbmFtZSBhcyB3ZWxsLg0KPiANCg0KQ2FuIHlvdSBwbHogZm9sZCBhYm92ZSBjb21tZW50IGlu
dG8gbmV4dCB2ZXJzaW9uID8NCg0KLWNrDQoNCg0K

