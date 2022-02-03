Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2352CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NbJSiu3Sm39Y8pbKDP/re475PgpT0yQFIyRMWSn6Hzo=; b=khkqYo9nugXv4q6wYWtTEXRaoj
	M783Q38H8KD4DhvF394EjgGCPlG7huiT1lSBrDat7iqxKfw58iR0kEBm/Wv0rGfS32/C7dHDF6xXv
	mGCQYrrF8jzcg8V0P7it+IKvfqC8mlhxK2CU+OFAc5K5Vq/bhSFf5hSQNiLvse0Mxox8Aw0fSwO29
	P0f2TOgw3FWzhjOOnUbbtDcZJP1VfiWZR4574bu0KDpdvn7skxJhHfKfrAV1IZ5BWAZ94dF2k0B1x
	Va6Fuaew+RGif2IVCId0TVP9OeaABGL9w/CeLD8hXzARIHJwsmYfm2WsjUsnArbNRmBQsxZbvJR7K
	pNxOPc2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFcMA-001SUZ-C8; Thu, 03 Feb 2022 13:41:02 +0000
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com
 ([40.107.243.76] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFcM8-001STq-LO
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 13:41:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFrTZ3zBTtcpQyoJucn0NmVAyeLKxqJwKCz3CZTEe0Jz7tNzTImB8E7xel3PJ3Do18xyz90Z1maCnXNg9M/EdXfbkYnJmmynV54ecORA51qCLLvKmFbmuXCq7O0zCy7yMU7bRy+nTCoCwJ+NDfnvp4m2Ag/Vkr0WskcREONOFmYlVL+Zmq1jZgvRT07HOAJ4/ee/htiQvweNvkCYQWAJm2ebFxFfqHjlZnAX9FZXpxe4uYImelaLiNgyYJ2BP1ARuMILLJtQJCGmlpGSJJBrh1bQSJDyASTPH14X7MJVeYtod7MGuB6g+Cbq/E1OgrYgdqA3i3MKakZJlwxX9+RUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbJSiu3Sm39Y8pbKDP/re475PgpT0yQFIyRMWSn6Hzo=;
 b=S6/g9YIY2TAK36bQMtmPP21GHx5n9+DolT4LkCJ4saWg0dpk4NGfgNPlxiDpl3NwYlOmr1ByOMG6OJ7qBTEJTOAfN926Vq37gy6Ide6m87YozGLVRtDhPdmTDrsiixccirB5wMS+FHcJ80zv5jSHjwml7vtCQvWzH4fJxLlzvBT4by85hRJWg+TB8d8j9JXwlW/oT6DFlVJCuPYgnJh8vQi6oH2AHM626fIuZUDV27WiiddZeoaoM4pH2T06wLT204inz7KDfcpUP6V3Sy8tJyLaRQhCn57s5c3g0J2YaHV8isx9Q0U1J0r3CEcnFkq1JHPylTzJZZh3hhoWXOPziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbJSiu3Sm39Y8pbKDP/re475PgpT0yQFIyRMWSn6Hzo=;
 b=Wz79mAsIALbnAByKCfp0JvQCwcPB55cgnrH4oG8/LkPFpUah4h5OPxrIf8Eo8Nw21Z2hSoYBgFiYMPrz3Ez6TPvfpks2ZPAcYr0eHIfiaulYDX0ysaMcKGd2P4N2SdYafyt/Yk+K8LamsLT3i1+f4iaegyMl+Me1OvgoWmqyjoLbjNYyCECkuyyRy6kZ4g4R0bzGItBikYR6hSZa5LoCi8leioP/VgUA3NZuSiHmWs+rI3An6P0vAFPNTqhwSx6q+tgApEblCwJQBUfXPFX6SerO1NSP3muRpz+V7aDiIUzRGcVNrA6IS7b/RDHcOpWwKiIpC18zptn7woHxn0gYjg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB3670.namprd12.prod.outlook.com (2603:10b6:610:21::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 3 Feb
 2022 13:40:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 13:40:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, Martin Belanger <nitram_67@hotmail.com>, Hannes
 Reinecke <hare@suse.de>, "Hayes, Stuart" <Stuart.Hayes@dell.com>, "Rose,
 Charles" <Charles.Rose@dell.com>, "Belanger, Martin"
 <Martin.Belanger@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Topic: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Index: AQHYGH0rKR6woBpeMkavuzSGK9jMn6yBa44AgABOe4CAAAnNAIAACWCAgAAJJAA=
Date: Thu, 3 Feb 2022 13:40:55 +0000
Message-ID: <25abd257-d22e-b709-b5ef-0fd0722ebc99@nvidia.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
 <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
 <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
 <95306ac0-3572-17fa-889a-5b6fa36fbc2a@grimberg.me>
In-Reply-To: <95306ac0-3572-17fa-889a-5b6fa36fbc2a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60a9ec53-8f0b-48ef-f12b-08d9e71acd76
x-ms-traffictypediagnostic: CH2PR12MB3670:EE_
x-microsoft-antispam-prvs: <CH2PR12MB36704DE31FBFDA5A71116356A3289@CH2PR12MB3670.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYdWic6ixDSZ0NpRY/oeJKYO9KDIFh0ke/rJZGJIoYlisBwaPyVdfsjj6zngOR+T99G19ohsU4DYfmJXKVdP2Bw9MaOxrgs9sJKRcoSVzT2bLhtLVEjfqJSY5Dvl9w+ml8y9D9RDfmpynrX4aX62oHJHOsKd8EzZmK+HutstSj3bL7aGUvvufOkD1xgX9p7n2xLpeW/gr497hKZ/ha4J9JxrxbYGjNNxQqvoz4g+gxnGvizHUaaevOaNpjKMA1FUMS9rZ6COsSAg6bDHLRtH+C63bcGHH2k5/IdDiWGGy6EulYakRVCXEJoOgzbJfSghMZ6JJkp48abxwJm09EB575PrOMsON52MWM9T2d4UxsukITvqhVIrJrOfejKYWhFImFzQTsyFSeSaNjXkpz8tLp4JEJ7sRaWqxmmFWgRVJPExl62A9xHVGGaNCkbDN9uhclRkM7RNhBnk3ZG3Pg0VD0fCOmlL42ROwijAyJIHGUhwjv7r1ffA57JezlaVzrGc8ljPF5W+XjNk+TKhhd/v69NGNN6Xgb0PqhD8rPCAuCJouNBpynA00rsMGmOisl2yIcJVRkfOlXZigZU9UoBkhdTF0i35HOeRwXX/U7ReGvrDVY6IZeeZpJgF8IxUOI2fjv1l09khFJbpsmtSVrTdVr/F81jF98ibB/R58TQsEWdXQ6QcBH+JKeiL2K0BE9Vcjje2tltPOxWsUI/+m7ud1cdXG8/3PMH+VneLB8OJbyVJ59mQP8W/mIWZCW2rqnAI9iQkFQVNvLT3VyTQKKbnDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(36756003)(2906002)(6486002)(186003)(31686004)(2616005)(71200400001)(6506007)(6512007)(122000001)(38100700002)(66556008)(8936002)(8676002)(91956017)(7416002)(4744005)(316002)(76116006)(66946007)(31696002)(38070700005)(6916009)(66446008)(86362001)(54906003)(4326008)(66476007)(5660300002)(64756008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1hQWWpNbzFlWnhKaEZvQndpY09ValBEeWgrUWtyVVZLRTZzV01TYzBHTjd5?=
 =?utf-8?B?TWp2VTAvcldLdFdkYW9LS1lnT2IxVi9kR1JzRzJwejJnd3pJVnZuL2hJU3M2?=
 =?utf-8?B?RVpTYkIrTVJlZllNZHIxb05jMzZ0ZTRBM3k0bEhkWnBWdVAzVmdnOUl3VVYw?=
 =?utf-8?B?VjY4VU45S2s1L0pCZlBXWWFvMW00c1ZYaWJpdGd1OXVOdmZKZW1ERXFaZjg0?=
 =?utf-8?B?bWpMVW1DMWFrQmc3RTUwdnZWT1RWcWtlUFpac2NmRXlUVlp0d2pyTEZOQUVM?=
 =?utf-8?B?bmlTSkwvdzZNOU4yVkVWa0FZdmkvcGpLdFZ2RXA4S1cwUVpGZXB6QnMzclVh?=
 =?utf-8?B?aEozclBTZjgxUWluMUJsRnZ3L1pQa1ZVUnNPQWtPZ1dORlN5U0N3TjlsNzM5?=
 =?utf-8?B?VWpWYm5yUXVrKzlmZllDT2U2VHRMTFFZTzVSV3FVVVY5VzY1aWRmWU9pekh0?=
 =?utf-8?B?bUwxcDROQzRPYVZMMnhXdXdJRlRDNjV0aXZUUUtPeUlrb3Z3U1JqNmg2eCsz?=
 =?utf-8?B?MnJ2aG1SVld4MDRVd1haTU51V0dBL2QyU3g1SzRERmY3VUs1M1hIVzUwWHFL?=
 =?utf-8?B?d3ZaVEhOVXQ2YXpjY3FhK0l4ZUV5YjVMeFB2SHFqa0dJK2E3dDlnQ0J4ZDda?=
 =?utf-8?B?WTltcEI0VlkvcU9aQjhrZXFzcmEvSlNGWGg3dFRrOWJqVnJWbUtPaUlXS2x5?=
 =?utf-8?B?YlNOSXdPeStCb0FnTnpFZzVkcXFLcG5uRyt0VGh1WWwyanVtdUV1VXpDc3JW?=
 =?utf-8?B?VllJVFhUTGZxUk5IM1d5UjYyelYxVlJqYUtVSEdOdFlxZ2RvbStkR0M0YUw0?=
 =?utf-8?B?ZTlvUVVUNXpSTnVnTUZ3UXhsbkRaOEFFWW5QL05WOHhFMnBtRXNWdDBFWlRl?=
 =?utf-8?B?b1RMSWJ3Q3g2VTU1NXNSQjc3Qjk2aDEyc1JCU0RNUHl3SitmanUzb3V2Z2dL?=
 =?utf-8?B?QStDMXJkOVlxV1VSRzdZcFB4M2x4Z2FzRHQzcFNGRXFWcWx2NENNc0dkOE1a?=
 =?utf-8?B?VDZwYm5JQnZYblVrNis2L0YyaVNZbk9kL1doNkdWOGpkaWNLbUNkS3lNUGpL?=
 =?utf-8?B?TnYzTmptZGFnMzJidURwOXRoRDQyR2MvcDZiTnE5NXRYL1M5TXA1YTA1QnRn?=
 =?utf-8?B?RGFGMS82S09yc3U0VCs0cnozN3dYQVBFLzFTalZhYU9kNVlRYjczd0VJMmtR?=
 =?utf-8?B?SjBzdDhpcC9XcXFtYnZQckk0djBnUUlzbFIzQUs4MWFybTBTTFptdnVHekFp?=
 =?utf-8?B?U2RIQ1FoRDVyck16dDVUTlYrcllPUXNiaUw1VkVZeVpUSWNRQzhlalpkVGcz?=
 =?utf-8?B?VlV5bkhDZ1N6eURQK3hndG4vVSt6NEwzcVFPR3REWUpIL3lmTzdTQ2RUMEZa?=
 =?utf-8?B?N01Pd0VOSDJGb1FUT1FKRFZNWkFLbnVYRm5aWDhWQkpjQ0x5bnFmeTB1eWts?=
 =?utf-8?B?b0hlNmQyTE9uSkpmcEdKbkFmbFgwZzh6cko3NGs0dkJZSUhvR2M0Tk5vZ0Nn?=
 =?utf-8?B?eUZpUDRvamY5UjB0ZExFMFpQSXFJYkozMkxnSDUxb3lTNFlXT0RSa016S1Zx?=
 =?utf-8?B?M2s4STUyQVQzVFc1bzluRzVidHlXenZQSE9YRDYwV0VjNVBjVkc0cWFoUEFl?=
 =?utf-8?B?WTJmM0NYVGhzb2IxNVRiOWFaeGo1NnJxVUgzN0lmUTVPL3MwOTlBMS81MDdu?=
 =?utf-8?B?ZjJDWDc5WTRIZzVVOWIzbzlCMXlCTVBkUnhLNjlIVWI4Y2MrZWk2Qml4eU91?=
 =?utf-8?B?SVR3OFIxM2wxanF4WTFOSWo2TjUyR285N1RvdVg3aFg4UHZxNjBybzY2Z2pV?=
 =?utf-8?B?UnlBZ0pOTlBIWitDcVNDM25YK1Z3VVlQWHc4d2t5dENVcWxCdWFIT2FLaGdI?=
 =?utf-8?B?VmtSakp5Z0kwQ0lEcjRQVGJKQjl4NW9wbmdzYUNweW1ZWG9EZEdETmNyUEtj?=
 =?utf-8?B?V0xURlNJRzVUek1QRW5yUzRyTmdCbTBzNjNpM2ZOY01sc0RXT1B5bldkaFRI?=
 =?utf-8?B?azF3QTlQVGhWbVhvZ1JxdGxOQ1pxQnkyWitGcU9BajdTRnVvZ2xmMUZFNDE5?=
 =?utf-8?B?Mjd3Q3VnRkY2SEhwWUY4a3E0QzNXeGE4dWJZZVRCNnV5YklyRWxIcVN1aHhm?=
 =?utf-8?B?clpwaFljemk0L0huZ2pZVUg3RzZNcXhBc05vMm5mRk1MMnhMWWJmWHpveElh?=
 =?utf-8?B?cnZqY3BDL0JhVEduaW5zOEZObUp3Nlk5OEtRMnVRMnU4NTFKSjU5bDRIRFJk?=
 =?utf-8?B?Q284YWMwODBWYUNaMzU4N2w4M0NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FA33475CABE954BA00EE9819166307A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a9ec53-8f0b-48ef-f12b-08d9e71acd76
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 13:40:55.1457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MMaSTu649+u2OU6Td2kZr8e4RDPTIrLb0o1Fay9Vv1O1UzENLtspI7cPlGVNRrGrIOM7wC2+MTLaavo1TZWyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3670
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_054100_724723_05F99948 
X-CRM114-Status: GOOD (  12.05  )
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

U2FnaSwNCg0KPj4gTm9wZSwgdW5mb3J0dW5hdGVseS4NCj4+DQo+PiBCdXQgbWF5YmUgd2UgY2Fu
IGx1bXAgYm90aCBhdHRyaWJ1dGVzIHRvZ2V0aGVyIGluIHRvIGEgc2luZ2xlIGN0cmx0eXBlOw0K
Pj4gdGhlbiB3ZSB3b3VsZCBoYXZlICdpbycsICdhZG1pbicsICdkaXNjb3ZlcnknLCAnZGlzY292
ZXJ5LWNkYycsIGFuZCANCj4+ICdkaXNjb3ZlcnktZGRjJy4NCj4+DQo+PiBIbW0/DQo+IA0KPiBX
ZSBzaG91bGQgcmVhbGx5IG1vdmUgdGhlIGN0cmwgZGV2aWNlIG5vZGUgY3JlYXRpb24gdG8NCj4g
bnZtZV9pbml0X2N0cmxfZmluaXNoLiBJIHRoaW5rIHRoaXMgY2FtZSB1cCBiZWZvcmUuLi4NCj4g
DQoNClVubGVzcyBJIG1pc3Mgc29tZXRoaW5nIGFsbCB0aGUgdHJhbnNwb3J0IHJkbWEvcGNpL3Rj
cC9mYyBzZXQgY3RybA0Kc3RhdGUgdG8gTlZNRV9DVFJMX0NPTk5FQ1RJTkcgYmVmb3JlIGNhbGxp
bmcgbnZtZV9pbml0X2N0cmxfZmluaXNoKCkuDQoNCkFyZSB5b3UgcmVmZXJyaW5nIHRvIHRoZSBj
YWxsIG9mIGNkZXZfZGV2aWNlX2FkZCgpIHdlIGhhdmUgaW4gdGhlDQpudm1lX2luaXRfY3RybCgp
IHRoYXQgbmVlZHMgdG8gYmUgbW92ZWQgaW50byB0aGUNCm52bWVfaW5pdF9jdHJsX2ZpbmlzaCgp
IHNvIGluc3RlYWQgb2YgY3RybCBob2xkaW5nIE5WTUVfQ1RSTF9ORVcgc3RhdGUNCml0IHdpbGwg
aGF2ZSBOVk1FX0NUUkxfQ09OTkVDVElORyBzdGF0ZSA/DQoNCi1jaw0KDQoNCg==

