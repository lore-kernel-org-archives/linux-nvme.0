Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34216C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 06:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YgzogYlRX3xhOPRdhdvgIRmTawi4aaBnsau5YehUups=; b=TJhuomfCehtNLZ7XB4/GhWohKr
	WrmCdcq8WP2Alq/JUc0FbAeYAtLMi4F9Fv4zahx5eKOz8tXiNqmisaEZtQlvDykBP4rusR5vh1B4m
	AHhrRD+4+xqq3pjnGbW3v9EPomkrG0yd2QcTPLcryY4nNhJ5vGxvmHvEpQ6qPPVtq3nclDtjAJSOQ
	/LmogbId8BWdRQN9DRmRGBguLt5q2dNx7R9w3/5u1lmwQFqM+M2Clw+NrUZbGo4gHNmWnrjVsKq2g
	OOjcjmGBLN44Zfu5ZMY8CpOP91RZ4TqxENFxyPHqh5D4yMQRcksavIomvlTHreJgo4QlaO0fJ+R+x
	cTFit6EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfF4d-008rGP-Ii; Fri, 15 Apr 2022 06:04:51 +0000
Received: from mail-co1nam11on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::61e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfF15-008opG-Qw
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 06:01:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEqEdi08YzyKzb9r03TWZ/sBLHxtb9fKhMpg6bIlRILG+RmP8FjhrZwmsZ8UajWqADywOwPuJxvTzME72TabAeVMW9JLScRoVsML0utuUd6EeyBldD8rM0ohQ4kGuAfhOC2/P2YQY5P0nvJEEgO5cgWiZJjmi+qIgkKgyaHXV2z/rGV28a8xQhWsDfaPyULeJqzUXclvUKMnqoSJYWnYhSDNVhge9s5p0GQrt/ch4LS3eQ93ugshwAku5zQ4SJsuAfXnzr0a1t3/10CENqI0w3/HrKlWOXoslZoIyHdNn0op5Vk31DKfNEaVbtPg9hliWefSK2bkpO4FzT8fnGQG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgzogYlRX3xhOPRdhdvgIRmTawi4aaBnsau5YehUups=;
 b=Ox5izmUGN6Ab96UfoZZdDzF0Xg+4nwPwNDwqRkkxazitPLZOQLc1OQCvHrwFPKXjW6hysMGMAZXkj+C8dLevJ15vYd1gB4iQ34UZabk69YX75lTniJjUdZ5NtHaySqloY7puyR9jLIAC6y1cGAfAMO5dU0DFE5+pFtJj7jIWVFI0PxIjRYWSr1QaSnOQ+AJj1rBDPo4OvVOKR3FI4ZxuenJ0zq/E6NoECO9oEevQaJrNooN3TqkV6UFNDqGwgHmZjsX/oImcsrcIPxzJwmT2+O/1bGO/RuZ5w3WAtrjDrEN6qJpnmjqLtN2DiECmG6sIe7Fpd8hNcHM31xjjzinhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgzogYlRX3xhOPRdhdvgIRmTawi4aaBnsau5YehUups=;
 b=TCSHMXTULFgon79EzpGRu7tLR+FpQcesrlOZrbH6BM9dV/6LmwQJGiRo2nNXnRuXnoAjocIbVAnKVWgHBVfbJ8JYlYBvIz4UHhOEk2VKQaEpEaB6IcM2CC56Gsm5LEIrMkIx6T68MR2rCjcVF3uI15q0pgs0Uua5m5dyGpjLBUpOOZLvayDejE7xv0zmM8TcSLAlqJ/gGBqndwnVw6zoLjERU0SAjhGPIOLBFOJwD5ANjBlJ0iuEeFcDWuj6lwxcEpI1X7LXqAJFOUqOr6JfxenG0vBm5862Dj/IzjBpkGYFkd5pGfmxbHTuOruoghRv3HO/5utl9cfJpJ2kcmXlWQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1513.namprd12.prod.outlook.com (2603:10b6:4:d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Fri, 15 Apr 2022 06:01:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 06:01:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Jonathan Derrick
 <jonathan.derrick@linux.dev>
CC: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Thread-Topic: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Thread-Index: AQHYTVIguewqbSTMiE+3bgRKWDMtlKzuEkKAgAAA3QCAAAFPgIAAA22AgAJp44A=
Date: Fri, 15 Apr 2022 06:01:05 +0000
Message-ID: <3ee642fc-ef58-aeb8-78e5-5b356fde1b3c@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
 <cf4534ec-c8d1-c020-2079-5636177ca1b5@linux.dev>
 <20220413165238.GA31786@lst.de>
 <fed97517-201f-f7a8-04ee-4a12698b4e41@linux.dev>
 <YlcDz4x+PNLgsSCQ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YlcDz4x+PNLgsSCQ@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c32d5edc-3a5e-412f-94da-08da1ea5540b
x-ms-traffictypediagnostic: DM5PR12MB1513:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1513BA61111DC0B1375DDAE1A3EE9@DM5PR12MB1513.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQm5OQYM2fq+pW426P6kq5gLbQfC29X8nVXr5usKiMt4fRFWwDHgkRtsebiSoXu34bag6SVjNmL+BbJWjmRhYRdrIPqotokxleqVRDVF8VbQLNHyivMsw7q9Y7P1Yre8NADXaHFEujnQw8M8hP1JfQj3ZCnoWlZZL59x48D79zkBGgiCSOxHEpp9UZSmn502tkCQg8Bu8xKzf7Nm095XK3XCUjhQVUTPjKOgZhf0EZkPsK/rC4cwqmzI0yBqNBahHdb0/s1Wv2oajD5lPTIohBC79VJlfAdeZ8ve7zQrHZ7dZ/kRFvVWqL84MkFkTV7LVeYX8C3gqZdNYcVKMyjuwVe/YyL10FvX27ELpheid41zaN9kGgrBMZMjRWT8XUr+kCdcOTl/7yM7r/X7qgtx+glbwCj+z9qBeV/BpjAw48eLSNSq15MSHETbMcrxhXoO58VilbVt+PLkkAAgNsoTziNQgCefBkfQb7uivx2dV1np/86GU/aBfwxhBph8bzjlHUzjxtvRWWnlXuUCrKE5R7Yv1HKZtYTBxVnAC3hjmexxffb2++aijqmyFc0q95rLng8d1/Vr+hZOFsrNBBebrLJmPTDW8rIFirXx9vNfXB7t/erDOXFBXTDsESTR7BxIJgy5A3JlOWtnt16DFZuLifx/wpRrzT/Yud8jNelc9pbU1oFe1v6d2KL7UTqdoUVqARdr3c18+M/WHaizjdQIuwb5UDFs7iXYjlP1UzRGVB5BfykjcC9YMEMPrKv/CSlyOZqJS6aaWYb3ApbYyDiUqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(31686004)(6512007)(6486002)(316002)(5660300002)(71200400001)(54906003)(110136005)(2616005)(91956017)(83380400001)(186003)(66446008)(64756008)(66476007)(66556008)(66946007)(4326008)(8676002)(31696002)(508600001)(76116006)(86362001)(38100700002)(38070700005)(2906002)(36756003)(4744005)(122000001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGJaNnNLc2NSNDlva01JWG16dlVraUQ5UU1GamdNM2IrREtNWHpWbUdrZnVu?=
 =?utf-8?B?cFZmaEVHTTNhUTRtSWxHK21oM2Yrck5SZVFRaThycmZOcmVDVnp1bXJ4cGxk?=
 =?utf-8?B?aHZieWZDRjhaRE5tK3VsY0tGN3dVM2FPNFdCWEZ5SHVxM2tiNWlzT0lFMFFJ?=
 =?utf-8?B?ckN0aGJsKzJ2eTFvRW9wY1FNYzdMYll6ME9qWHVXTjFnOFdUOVo3aFVCanI4?=
 =?utf-8?B?OTJYUGxhaWZKaU9mOGhEa2VXNkJjOVJHMU9JWVMzMENjVTFmYmlMVmVFSzR4?=
 =?utf-8?B?SkZxeE9CWHNuTmphamQ5ZENoVklVUGljUjJkZTQzcGgydW05M284RzJlVEMw?=
 =?utf-8?B?d2hvYzFyMnBWckFzeWV4ZkZ6bTdxb0k1QVV3LzZuRGNuV1NucEx0S3dPb2xN?=
 =?utf-8?B?azBIR0lueTBvSTdqc0ZyVTQrNzNwZFZ4NTBCM0poUXV2LzdSaW90NGxOMXdr?=
 =?utf-8?B?SjlwZFkrZ2ZqL1k4TlBoQzlMcFN2d1RSR3E1bnFRZ2tNaGFiNmNWZityZTVh?=
 =?utf-8?B?SGljczFkSHhOZy9aaFJmZGw4QklXZ0k1OHFEeXJ4SlB4WUtNeWNuZG1vWjd5?=
 =?utf-8?B?Q3hsQS9QSWp2MDV5empza1N6aVlEVkptYngxaDdHT2hvMHM2OEFYSGJGL2g3?=
 =?utf-8?B?bTJ3QUY1d0U1eVUzbkJuMjl6cnRCd2FZYWRYSFpsL2FNdC8walV2MGVsMk1E?=
 =?utf-8?B?KzFPS0dLMWVrVFFzUjFuQ0xFdkRlS0tadHRIeXJXMjUvZlB4dXBpa2ZCNHIw?=
 =?utf-8?B?VG9YbGVveUJsem5oek5TdmdDYlhKYUdadU50R3BLZmZsOVNGZE95Vm9mQzVL?=
 =?utf-8?B?cGdRTGkzSEtGNUR5MXJJUEVLS0tRK29Sd1Z5NHdnU3RYUGNYL0lLRGxaVlJj?=
 =?utf-8?B?SkREUjNQRUtWaERScTN1dks5Rm5HWE5jZHhndXRZbURZT3M4RnByYnJUZ283?=
 =?utf-8?B?WnZTdm41WURCRVJsem05S0lJWHkzZWNGLzF6MUh6N2FVTlBSY2RJK2RrUXFB?=
 =?utf-8?B?cnpDTDdxMGlmWkx0Qml3Z2xReW1TekRvNnlycEFqRlMzRzVwaUtMMkREbFZx?=
 =?utf-8?B?aU1hN084U3dMN09vNHUwT3c2U0dyeWFNc3ZsQkI2eHR2R3FFZDZBRUw4bXc3?=
 =?utf-8?B?Y0xZV2NpQ2cycXhrbUhnd1NCNExxUzRLRmI5MCtZOXZVazk3a2pYL3NJallV?=
 =?utf-8?B?ZGVDRGwwOXVtZ09xSEQ3U1d3REFac0NsSTZtKzNyZUFEK3I5TGxyYk1lQU1m?=
 =?utf-8?B?UTRoa3lURU8zMmtzeHVZTUhWTHBhZFdRZ3hhbjNFOUMwTm11MzNLaU1BdWhj?=
 =?utf-8?B?Q21KbTBFTzhwQ3AvY1dGY1JGeVFHQnM3NURMbUpLSEkwbVhTQkVGYS9vSFFW?=
 =?utf-8?B?OVgrUWlwdzhaUVF6ajFWNGgxOU5URnBDVmFQUW1aM2srYWljbXBkYVdKVVlB?=
 =?utf-8?B?Mnhaa0JTLzlRSVVpL1dPZ0x0S1lsNXA3Rk9sUXlnZTF1b0VrVDdTNWhLWjlo?=
 =?utf-8?B?L3ZWcnhDUTZ3L0loUkJWOXNTRHZOaUFxU3JxdmNTckxyUzVZU2xoT2t4VzRR?=
 =?utf-8?B?Zzdkd0ZndDFMYmU5c0RIZHErMTZRa3ZOT21aNTlZc0Q3Rm5EZmZVd243WDFE?=
 =?utf-8?B?RnVIem9rNDlkaGpJL2NBVndsbnJ5M2FvVHFlb1FVQ0xJS3poTTNMbXh3OUpp?=
 =?utf-8?B?WnN1bDI4V1RXRUwzK25pV2VxSWlMNHFxQWVTZzhLRWdUcm5oUXBHNWpSYldm?=
 =?utf-8?B?NHNYd2E5V0NKUHFoa1pjaGxUREZlaWN6akI0MEE5OE81T3BvbXR5ZUFvRXVr?=
 =?utf-8?B?VlJxZzhmVlNCS05TVWdPbllJZkVxeThLVWZYUXRGM1I5YmM5TENZYWVBcHp1?=
 =?utf-8?B?QmZZK1JSRTVCNmoxSUpCcHA1SWp5bE0rMytId0xnejBTNElIZEEyaWRmRnIx?=
 =?utf-8?B?dDNoTTBwdURkTE9Ibmd6UW9SZ3hmRTB3Q0tPQ0lhVkp3UGZkanRwczZIUkJa?=
 =?utf-8?B?a3FoZGxITjRndEFOR1dJZE5PcUZjQitPbmY3MlVubXU0YkpqdlVKRzlwcVFP?=
 =?utf-8?B?NGNrQjhmOUR1Y2NzTWZKcGZqRWJHN3JMVkx4V3EvWFJibDhOS2ZmVkN4cGs2?=
 =?utf-8?B?QmlhcmtMeklNVGRXSmhpR3MreDBvWXdiWThJa2REZEZySlltL0FPRnpTR2Rk?=
 =?utf-8?B?NnJBUGxTVzRKeHZDVmtIRHlKOTljWTQzZ2JKN1FPTURrenBpbStIaURNRTVM?=
 =?utf-8?B?ekhybGNkMjFVZEVYN0tMRlJLcDNTRnRjV1doWnRVMUltc1pFTU5EVldET1hh?=
 =?utf-8?B?cE5kSFJxN3RYbEkvY2NFWW5xYUhKOHZ2Y1Z5QTlNam9DOGFZLzJ1cmFEeU51?=
 =?utf-8?Q?kX4zxnHbg1NAuILwmpXXV4Mi2FqamPS1WVQzu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <367864641E0EB943A9650D27422F2C58@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32d5edc-3a5e-412f-94da-08da1ea5540b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 06:01:05.3891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIs8QIMoX1O/Lxx97NtxHEpP+l9o3NYmJcsZZoL2/xp8xu8s4YrA2fO3JG4GUTcSNrd+xM2oveoHScJq/pfaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220414_230111_904707_5C9C8227 
X-CRM114-Status: GOOD (  12.90  )
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

DQo+PiBXZWxsIGxldCdzIHN1cHBvc2UgSSBoYWQgd3JpdHRlbiBSUUZfUVVJRVQgaW5zdGVhZCBv
ZiB0aGUgbm9uLWV4aXN0ZW50DQo+PiBSRVFfUVVJRVQNCj4gDQo+IFRoZSAiZmxhZ3MiIHZhbHVl
IHBhc3NlZCB0byBibGtfbXFfYWxsb2NfcmVxdWVzdCgpIGlzIG5vdCB0aGUgc2FtZSBhcyB0aGUN
Cj4gdmFsdWVzIGZvciBycV9mbGFncywgdGhvdWdoLg0KPiANCj4gSSBndWVzcyB5b3UgY291bGQg
YWRkIGEgbmV3IGFsbG9jYXRpb24gZmxhZywgbWF5YmUgY2FsbGVkIHNvbWV0aGluZyBsaWtlDQo+
IEJMS19NUV9SRVFfUVVJRVQgdG8gdGVsbCB0aGUgYmxvY2sgbGF5ZXIgdG8gc2V0IFJRRl9RVUlF
VC4gVGhhdCBpcyBzaW1pbGlhciB0bw0KPiBob3cgQkxLX01RX1JFUV9QTSBpcyB1c2VkIGZvciBS
UUZfUE0sIGJ1dCBJJ20gbm90IHN1cmUgd2Ugd2FudCB0byBhZGQgYW5vdGhlcg0KPiAnaWYnIGNo
ZWNrIGluIHRoZSBmYXN0IHBhdGguDQoNCnVubGVzcyBpdCBpcyBhYnNvbHV0ZWx5IG5lY2Vzc2Fy
eSB3ZSBzaG91bGQgYXZvaWQgdGhhdC4NCg0KLWNrDQoNCg==

