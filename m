Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36A9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4OX5s7pUaKQ3dGlLKROmk1GZOyFwpVLPhHnbpNj3V50=; b=n/9xlh2NGQQsSPzBIfI1Etgkvm
	RSBRPyakq+GGaP9hxD5YqeAWv37TnIoPnqCvilw1G7K33wUfIRcO1KFk9qPnEO7ngK9Cb7Atndgm0
	9171lQERGeEV9xyfwXvHRyFxGEHmNdniWrMu3kKHuAwKXj9nKzRKodUcdQOhiJVSg5THcek+wPA5T
	/HREUkJBd0h3IDQ5cIkTaPxb8UYrxp4O5Dtq0nAUVqcZAugRaQ4pFUgQGEPqzURDuM/AhPyQcP5wQ
	sQ1Oap9b3GG5LfjvubkJsA7dYti3CjwkLm2Ahc8a2F4zAySQjH34XIqu8fzcFDgJNdNVe1iLhY0iZ
	3EYyUVxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNMxv-002ay0-Ad; Thu, 24 Feb 2022 22:52:03 +0000
Received: from mail-dm6nam11on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::608]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNMxs-002awu-R0
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 22:52:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZvUWtjLs6uDvoFDhuJhAnLJAyvMqbfEilNDG0xc20f2a0CWs/2H1DlCW9x/+hOjf+vU6YhDbfW72MFOBwYgh9WPMA2NfTVSeVImju5kA21dWxjVuUgenatcG1lk41ML87Z2v5kvDlb4WT9bYZvJ2PoYDbjyUtMAIcfcqu7GygcJHH2qbjzkHg6TzJOt00GtqfHwo1AVAHAtMhqEm7ds4IvSMT9huEPze3RFFGvnr6iD2RoZZOsj6ptBi1uOJToiNg3RW1EAWE67MLE2B7qWw+pcMwkO0B2A73nBVTTXn1qeGDrwT33imn9MLx4h4EB4MDGcf/jijW+O5LkXjSAkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OX5s7pUaKQ3dGlLKROmk1GZOyFwpVLPhHnbpNj3V50=;
 b=VKtLwAFGyiOuL6GVdBrwTY3d22B4wNudp1A0nouwSPm/p+1dwz16vOeApt8jYqoacv7cQtZHONkGmgpbI5hMgQ21PWZfxCYf+NvPNkQ+ZKbGwjN0j3aFCDYykYWlayXSqLGD+FJvp7AoebSsBXqkSUnuEi6FWwJCkKKsvrv6WrDEj3wPUWDeXJfOwVXqQNbBWITxzU7nc4RvRBOy96jqdJERq+doC7jBNypgLXGs2uRrEJP12EIIbyfbo5XA4JhH2xwy9WzFrZPkSu17Zvl88W01r9KAB+HnKalLg823yw1B4wAXH+3KvIsVpgTCx93on8hlZHDbhHcSDwB+H0MHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OX5s7pUaKQ3dGlLKROmk1GZOyFwpVLPhHnbpNj3V50=;
 b=Y6wkQ5DEv7iZt8z/eCPqsNy1qJR3ol4biZLyuieP2+F2lwE1tMKBF6DwZBjFH3lbknw5URN4QlfTNlcu1PypwjO1g4IAIJiAasKqcQL+kPT1ZwTM3I5J/x8BsC6rp3mMv3wTrCr7Ntf09nxTFxQY00/7f3QyYEErfUrQIjUT2PTAYZ0rbytUAQgFvW1WJ5hJK5c2HylGYlJWYmPwjYt4Pv26NIBpm3IYGaY2IqWvVgO+BhN1ZuFh8GoyLcwj2aOcXoouQvsZLv1mt+eb1AxYgReQ6nKtKFbAIBXwbQ3HIMbKqpHy33r/ijHyvlSQPnUcCqOhBkD+isC+DbFJJN1GTg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3323.namprd12.prod.outlook.com (2603:10b6:5:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 22:51:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 22:51:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/4] nvme: fix the check for duplicate unique identifiers
Thread-Topic: [PATCH 2/4] nvme: fix the check for duplicate unique identifiers
Thread-Index: AQHYKbUNf1oepxhWbkG+HGK2UJDHMqyjTtIA
Date: Thu, 24 Feb 2022 22:51:54 +0000
Message-ID: <bfbc8ecb-557a-5a2f-7707-f14f3ab8ebdc@nvidia.com>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-3-hch@lst.de>
In-Reply-To: <20220224192845.1097602-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f07d4a51-a180-4049-fa72-08d9f7e84145
x-ms-traffictypediagnostic: DM6PR12MB3323:EE_
x-microsoft-antispam-prvs: <DM6PR12MB33238719BF8F6B504D84B3F3A33D9@DM6PR12MB3323.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrRTvYxzHjbryOj2XtRrUTYwm1wdZDKU/CuwMIH3pNAk8lRAjdbm/Se2CiSl2Dph+nWgIna+qbEO2P6hobnF0DkoR1/mWNuxyKOjXY4NFx5uikp1c4TRtvWUaTynoroXP6Hico+qxs6X5Auaj/xNub5PIYS/f7DETYzo0PuEouGG7eqOpZM2qzoT6DyAHe7vPGhFhWGAe3zRM8nj91ifZpQk4fMzBHcDKgOUOkA9c+kIHGuqqFtYSkb/0Vp57YYfSpa1wR0G7xGYNERrXpOO9GEUv+9A9YdRIHU5jVw9IoAc45rYP09hE4ShSuhq0W7MDy7jWIJwmqqZqdrPIFnwbbP8kqPuSGJWmgenYqSU8kJc3ZAMHa65tZthj0qPePLoWs/RBA/8NzlyV1WJaXMfErAmAGLDToJ2KksLBJ0fNUEqJbhztOqdWYe4BkfluhMm8M9Zcbu07b9W72PNGrif0xVAt6r9kolBXP8CSQALrR7JYLT25yR6RaFBg3pPCdpQNxkRRmqGeSpHut6irbyVyiLCLG7BRR/hnmUYSBl7Vxz3NKSfkdhAFjZcJzGEGXABoWOv/313iNzfw5HI/a3ydssWIu2cPcMTrkMP34YKgLjJhe9zRKD4Xb1QiuhEtENj3AxdiTnSOGZg9yoY5cjKJ8XJxbVEL84Afmz7P1zzNy9ZB6qSUOY8l5odV3DYPLs4PIWQ+0E3zBe8oT6Xl3SubI1DCGLWM7hPBQwFQIr9aH6ndjKpIqVtyjj7eTUT+jGEbN5HbxGjfUhd5QFt/JeoWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4744005)(4326008)(6512007)(186003)(66446008)(6506007)(71200400001)(76116006)(66556008)(64756008)(91956017)(2616005)(5660300002)(2906002)(38070700005)(66476007)(53546011)(8676002)(8936002)(122000001)(66946007)(31686004)(36756003)(110136005)(86362001)(508600001)(31696002)(38100700002)(6486002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0UvNlJQMEN2aUhvQ1ZKV1ZWV1QvdEU0M0xMSXlDOHdoeENCMmhqTkJDOWFt?=
 =?utf-8?B?cDZTaVRJV2I0UXZjbFlkVk50eU1oVGppSjNIek91UC9CdXdiOHhLcmwwZlBy?=
 =?utf-8?B?ZTdUQmNJaXM4YzhxamloOXg2TndDVFVFWmJuTWgvOTgxUm9OMk9sYmoybk1X?=
 =?utf-8?B?djZ2YWE1TTNHSUZmVW1sd1hQN2tJK2RWTy9EOWZWSFpNTERjMm1aR2xEblRx?=
 =?utf-8?B?blc3NGppNkVkOWJXWGdLdlhOa25tZUlsdWd4MEFsQzkyOHNqMWcvSlFoc0Zj?=
 =?utf-8?B?L3BseUdmRVFZUkg0Zmp6eUtrS203YnVoeVRTTnRCQkZYb2xZL3Zva201anhE?=
 =?utf-8?B?TXJ0NEVJY2grUHhZZzVXd3MrSW9RT001VWY1Q2x1Z1FWa2Zmc25TaDhwWi8w?=
 =?utf-8?B?VHRJU2pUWSsyWkRGeXg0TDQvV3ZFSVFjMG83QlllaURIbHZ0V0VmcDU3MS9T?=
 =?utf-8?B?S01Kbkd4a0hXSTdOMk5CdCtUZXZXWEpGaHlXd1Jtc2hUWFF4OHZxTVRmMmRw?=
 =?utf-8?B?aldMK2pxajErODl6dGRXdGxOUFg4cXVmb25mamFzYUw3TWVidUdwaXVkVy9M?=
 =?utf-8?B?NHFFcXV2UUdjU01hQlNHUWM1RmdBYWxNZVFFcmcyZkRYU1hmT2pqQVFCeFc0?=
 =?utf-8?B?d2xUK1ZLd2c4aEpleUZXOVExaFVZSkIyd0ltanNrMnZJMVRlVTN6SEdhcFpX?=
 =?utf-8?B?dkxURW56YVBsSUo3dkVscjExekhTZitnSHhobnc5cEhrZWgycVAyVmVvTEJv?=
 =?utf-8?B?TkQzZVhmMUg1TVl3TmtLMjNJNXIvNE5RZVNtNko4aXhTVVdPbllGbURsWXp1?=
 =?utf-8?B?WGV6cU9SVHlwTEtKQXprSGROS2F6L1JhTzVpN3lxNTc0Q0tOUlVub2lMeU1X?=
 =?utf-8?B?elRwQVpyUWtwVmNxclZBdGw0OVRTaGZ4RUVWQktNaTVtTGtsRGdHQUZpcmVx?=
 =?utf-8?B?QzBFdmxjSHFtZ3drZ3MvWW9DM0RNamVZWHJpSk41NnVYbnplVXZHVWZOZjBo?=
 =?utf-8?B?dkh3NVVnblQvOEtyWWdpR09HU0thczBoNkpkQ1dPR1lqWDg0cHkzRU44Y2xB?=
 =?utf-8?B?TUxYeVZsVDByS1BWcFJxT0RkV1FyL0tLWkptV1l1Z1ZxVlp2Z1hhbVFEZ1lT?=
 =?utf-8?B?dkJvbUpUNDlMUkdoWXJ0ejBtZ3BDOGd3WGV2RXY1T0w5eWlxRW5GbG53bHJN?=
 =?utf-8?B?emE2S0NLU0prVUhNMS9aSWdSNFg4MWRicXVuQ0h1SjVvNXViaGRVbDM5UHJi?=
 =?utf-8?B?d0RlSlVrZU1KSEdENDBucFB5Vnp1d1pHQWl5TkNNT3VFMW0rNHhsUi9vRmlR?=
 =?utf-8?B?emF2eTVLVkZRWmRSZkxPVlp3T1VDZlM1Slk1UUV1NW5wcWNuU1kxemFUWWNx?=
 =?utf-8?B?b2xVSmRTK3pqS2U0U091cVd6QmZESzdlQ1Qxc3NKZ1dlUUhlMTNtb2E2aFFW?=
 =?utf-8?B?VmdKZy84c1NPdWRMTGxleGhjbGdBR0c2YXVUekpaS3BPeDNFUW9NK0IrU3ps?=
 =?utf-8?B?VGRkQUo5WUtPOEtxd0JSclVKUElyRldkWmt4UU1EUGZvSElFL1licnJKMDhy?=
 =?utf-8?B?MVF2MGR2TE5paFFVbndpOUFVNzlHcU9MM1BBVG1IdkNQb1ZPYmNrZHR4SGVS?=
 =?utf-8?B?M1pIb1ZMbzJJRDFqOFl2dVY4U0dpRGtFWFVYbXlSK2c1STBtYlZtUko1WW1D?=
 =?utf-8?B?bFVpeThqTDFDMlV6M1ZLTTJwUWJJRU1oQjR2emVucDJFOERoYXZsZW1FZ0tK?=
 =?utf-8?B?bm83bzcrTDlnbGJvQUZoRVdaWHkyV2RmWEYrcTZYTDlQdEtrUm5wMTlwTFNP?=
 =?utf-8?B?eWJUK1p6bS94UjNZVWprdkZQQ1FnMzFVKzlFL25hSVluUmYxYVBlS2pHVmRs?=
 =?utf-8?B?VnFuZUJOU3JQMk5FOUxZTzNWZC9WeTBOL2N3blFpWklWOW0zWjZPM2dJNm9r?=
 =?utf-8?B?TGwzR0YwcjIyMEYvWEVKVnRpRkFOdy9HRjZKdFVVcElQazRKNTdSd0s0cGsx?=
 =?utf-8?B?VTEydzV3akRZRmZkVitBYzd4V0Q2RHRZVXVsMm45T2dmMEIrUjhsMm1sVUdM?=
 =?utf-8?B?UHQ2OUl5Y2YyeUVrQVVSeGZ5TXRhQmpiTUQyQmo0dVh1UjlVbG5kSVJ0Uyti?=
 =?utf-8?B?SmlEQkFUc25LOHM3UUsrWk9EMzZsaXFkRjFWbzhkcTh2NHZJV2lmRjFwbmNT?=
 =?utf-8?B?Uy9QbVRROFVkeTk2cUtucnZyMVNWaXorbVBTYkxJUExkOVJuUHZVTlJqWVBX?=
 =?utf-8?B?WXRCNUdsMElqaStrZXJTaDE5YmhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CF6597CBB6366438C57F38C6DF2E667@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07d4a51-a180-4049-fa72-08d9f7e84145
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 22:51:54.8589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBa7/5umJ5e7MeIwqkcP9vefjSWq8M0bJMuoSIwkqamGzZz3wztDnCpOPcqsTSqsIxzoD9LHkGu9G6UI1ubGEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_145200_896160_19807767 
X-CRM114-Status: GOOD (  15.12  )
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

T24gMi8yNC8yMiAxMToyOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IG52bWVfc3Vic3lz
X2NoZWNrX2R1cGxpY2F0ZV9pZHMgc2hvdWxkIG5lZWRzIHRvIHJldHVybiBhbiBlcnJvciBpZiBh
bnkgb2YNCj4gdGhlIGlkZW50aWZpZXJzIG1hdGNoZXMsIG5vdCBqdXN0IGlmIGFsbCBvZiB0aGVt
IG1hdGNoLiAgQnV0IGl0IGRvZXMgbm90DQo+IG5lZWQgdG8gYW5kIHNob3VsZCBub3QgbG9vayBh
dCB0aGUgQ1NJIHZhbHVlIGZvciB0aGlzIHNhbml0eSBjaGVjay4NCj4gDQo+IFJld3JpdGUgdGhl
IGxvZ2ljIHRvIGJlIHNlcGFyYXRlIGZyb20gbnZtZV9uc19pZHNfZXF1YWwgYW5kIG9wdGltaXpl
IGl0DQo+IGJ5IHJlZHVjaW5nIGR1cGxpY2F0ZSBjaGVja3MgZm9yIG5vbi1wcmVzZW50IGlkZW50
aWZpZXJzLg0KPiANCj4gRml4ZXM6IGVkNzU0ZTVkZWViMSAoIm52bWU6IHRyYWNrIHNoYXJlZCBu
YW1lc3BhY2VzIikNCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==

