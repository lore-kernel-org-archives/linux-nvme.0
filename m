Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A76C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 03:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G1PhBb7YWKobED9ldD8LDP14/1uDqBli27USXzDuoKE=; b=IneeFbeOEc0ameD5Z+XN4dr1ly
	CDYpYkiUYnUIaGC3p/9w6t2xLpY653kaAz1lt3/yuI2P6s2slvK4+YWEyZcevhGUrzwMmwr8dnk0r
	tNujqV+wGFgLSlqa471azEih/PwF5vMlSZocNxuBxX0YY35qlZM5j1CKTjgyA9zc90IUsJ6u/fibF
	JmFGPXFV1e4sA02KnqTdtErDCm5PKkWg9PjQqFKn32Rrcj6GUknitCNtyUGe80imwpSH1fgPgDmkW
	9Nynl6pAAhAFVL5/yF245QjMJQJacQwJHfnA6MxFXV1zzEB+PiXsQLAWJzZay1hoN5zi9nv+5Q+zu
	dq1WaHPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSU8q-001MhW-2O;
	Wed, 24 Jan 2024 03:41:32 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSU8m-001Mf5-0p
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 03:41:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD+LktrrCFWLot28Pbdvq2Oq9PaNg3tpYbYO5Tar5s1YjOuEoWmZPchSMbtPdKWomoPyj6ohqhwSC+/sAV7egRAo/8BcyFXEocKL8M913lAfNMjwcahzfEkD5CKR2miemqw1jvJ88mL4xkU5Xrh3UshcC4kTnuhLnjCJOF8sUEJ7rb/RcoM/1mLw4/M2/KATPeNluoA1S7y7Y0Ds5H6Vy9FNrNqtdXI1NVKY8VFEXBVToXB3PH3UQ+lAD95ZUnx4IH5qB1c542OjbrdhffGcpwZzgMssjxhB+NhAHETp7hqO5Mz3clXKa5Fc/rhlblHObI32fZjXkVTYe9AXZU7JLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1PhBb7YWKobED9ldD8LDP14/1uDqBli27USXzDuoKE=;
 b=QPoTOBE11f6JWi01ckcxQHfGw9jkYPzKsdReapR9pS8y8kMZgNaJwwXnE00asgSOlgcClx3E8fMci59YoIjJSB3bspjDvsRzykoo73A6vhYdwnqrz9FIgDcm3Jue4dsEd5ZWenp8bb4zSOo7+IGRFZ/CxlnZ6TsGw0Erlr+eR1w+Y4DAooOJpKqvXjpzuHc6c9rYPuCc3gwYNfrJpZQR9/J0uA82/2hQOxntXDLAzVheEuhpZlP5T3I3+e/XIeT3f75PoQ25TAfJvZbNSTcZ6SR1zrGfdR2QtNMakeQoLxvFrQPO9TMSdI+5f9CzQRpCaWqAyYx+ut4FjYFp0zoGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1PhBb7YWKobED9ldD8LDP14/1uDqBli27USXzDuoKE=;
 b=PSDSa2drMXtcQBKLc+M5LZ3B+MXI+T1HoSYycIp5vXw/+p6wUpcXhr/dIM9/eqKQyJzTwGtFkcUfuKGvl16PxpnYNgU2BdBLC63pwdZPfMpJCluDvLpwrE3DW4io8dAu/abcZRL3nTKUxaMA+7bM+3WAICGr47KeZipba53Pv1/JTrdi5dcMo6f5PoaktitfqNC2+JS6KX5ADrFu7yI5OACcPRDu4/Riva2hoHpzWKNsoH0x1RYnDBvfGzd3KmcPZWphjfw1+hsa9m4ZCxaSVPLCGZ2p8tSLfK+KDTnGEH75XA3tLXbrZKroyQMnWEe7JfPx080My/ledzwLHxqxxA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 03:41:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 03:41:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Thread-Index: AQHaRCI5o/0gWRRNpE6eYNPv+sWFV7DUMKEAgAk2uICAAK87gIAA3ueAgAhiSoCAAF5iAIAAr/wA
Date: Wed, 24 Jan 2024 03:41:24 +0000
Message-ID: <5a9a9473-7a32-4808-8053-3668ca3cb49e@nvidia.com>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
 <20240111070441.GA7889@lst.de>
 <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
 <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
 <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com>
 <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
 <718a0a43-40b2-41a3-98d5-dc2eebb41681@oracle.com>
In-Reply-To: <718a0a43-40b2-41a3-98d5-dc2eebb41681@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4110:EE_
x-ms-office365-filtering-correlation-id: fb30dfb4-548d-412b-5d54-08dc1c8e56b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +nHsPoq03WwBY5cawPx1nVPmCJ5AqTJhs9NeQR+fgVQeruUZV47s6KHUFd77gbhCcPAPpYufhhYOEB1buIGW6e9187s86tRhP8FLppMmvhr+mFtLGTJ+KDkcwH8Yfwe5e4/MEz8XxirYFLdQpMO20fJldTf9I+Qk20N6yNHmdkuOkNmEylLIpZGSmneNTKb1ufCQ+H7ihtyz22umxoKZFM7svA9DQ37rhjcowD4fRj23NJXz4irmP+C1EpkcyVo7dk0HxV+YZRCNV2Afontgw8w9kLgQjwYn8JgqB5x+kv4AugGJd7imi3zEuyEzbtOnN8D/S2K2XbAWFu+qmAUiO8i52awFHfgObRvafasKsHnFOnZlLK7qkoK30VAwjzF7iKEkQPH7qr2zMdSZD6g04sBCbEpNBw40zQqTGCaE1er++wUnuabS+kqYYPnc4sGHSD8HrnNnWYTEEmZiiuqLg8DqpAOEm4UiiY9F9qELdXEnHJW9jRdX3s3Y92R092KojeQzjzXVjHqorVAKZl+6nqOeGAFdQsKwwxrQEgZpV5F0xbaIpk4vVrYYF6T7xOd1Q0EqVK7dvIO5PMv4QK029TXdqrttOHGvwWuVS+kwhUOG6gXZlvvVR+xf5y0i7SlDPzHSQM2QzxiHNHy6AuLg5SHtlTnjOTaNwRTcv4srVg3yyvfXwxOpE2P3H5IypXfg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(478600001)(6486002)(71200400001)(38100700002)(83380400001)(4326008)(8936002)(122000001)(6506007)(8676002)(2906002)(26005)(5660300002)(86362001)(66476007)(31696002)(66556008)(64756008)(2616005)(36756003)(53546011)(41300700001)(6512007)(66946007)(54906003)(6916009)(66446008)(38070700009)(91956017)(316002)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NERkWWwyTDh3dDhiREJIcy9XWlBqNFVWTWlONVZDSUxkT2ZxckVIRmdRdjJh?=
 =?utf-8?B?YTdvUVVVckRyYkxwQSsrVjNHd2E4WGFNNWxOclZPQzlPOWZ3QWs3anVWbXBR?=
 =?utf-8?B?R1dKNEwwSmRpWUJQWHcwQUx6ejB4MjZiYVVnTUpSS0tsNzQvUGMwQXhyOUJI?=
 =?utf-8?B?Vzg0QjJYbnlZcDVuK3VaT3dHWWpVV1lkWlZwR1BvdkZBUVRUMWVhbDJlVGlM?=
 =?utf-8?B?ZVF3S0JiZ05RRlNNZmo1UVRBV3VsZnpySFllN2dya1VROFZSWEVXaTdTWjZo?=
 =?utf-8?B?R2Vvdzg0N0d1SVZva3lVdU53clNxbkE2MnYyQmQ2NWZoVEQ4ejBsVnpVZG5N?=
 =?utf-8?B?TFk5Qng5OTZkNVNndTduVlFzTXVkM3pYTWxkZjcxS1VGMDQzeklSdXgwMHc2?=
 =?utf-8?B?aFZLTnJhZ1NIeXhYWnEvd3RZL1AvbFBPM2VoR0Y1dnNNeGpxTjRaMDVvNzRu?=
 =?utf-8?B?YjhRU09HV3hvNi9EN2RYVDk5ZFdMZ1pHd0pjaUFGdnNLUGllZWR2bVl4U3hL?=
 =?utf-8?B?OU4wbDRTRXdCUkluZmM3QzVEdzZ2anY4ZjMyQzVGblp6R3kzQk1tVHE0SFdn?=
 =?utf-8?B?RTFFSXBRVzFBTklwS3AxVDBuc1FiN2RVMzVwZk9yQzdOZmwrZkF2VkZqcUY4?=
 =?utf-8?B?cGZjMmZWbThjNWExYTM0U1BDc3NzYnRxenU2cDlsOGoyTWo0d05Hb3dzaDdy?=
 =?utf-8?B?NjdxVUZHeEJGKzBDV01uSDdISUw3WjFzUFFOeWhmclZMRnZhY29CbFVocHdy?=
 =?utf-8?B?bk4vcWxOTGI3MUh3a2hwWEY2cUVGd015bmRMdUkwaklYY3U3SDBVTW5Ec2w2?=
 =?utf-8?B?TnpBeHdDOUtZTUNMbGRjOTV6ZVcyV1JXcGExUDRFaVlGRU1lYXdpSnBLalI1?=
 =?utf-8?B?bUtkc0xjdTR0Wkh2cGh1dGFwenRaYmhpekdyUWV0MjBVRU5sMFdCc0J2ak85?=
 =?utf-8?B?ZHh6ZjJaSmdsdmVrNmM2T2JwSzNTbHlQZTljaEZJN21zZHBKcGFIeDg3MFF6?=
 =?utf-8?B?dlVKNHE5NkVucTE4Z3hFMGdPV3E4YytGUHVQV2hoS1pWNzRsVVc5WjBHb1hs?=
 =?utf-8?B?YUtZQkZxeGIxNTRQUmFJamJaNThtWThHUHpHcGFmTmszWi9vUDJ3YmJQNk5m?=
 =?utf-8?B?bGNQTkQ4c2l4bnR6NzA2dGFPSDFIaHZSMGMrYjlNTktIR3AwWnc5SndMY200?=
 =?utf-8?B?bFlRbmZUMzB4WFBFckZTSysvOGFCQ1VBQ2V0cGFYZmVja3FoUGxoUWFES2tx?=
 =?utf-8?B?SE8vQjlxUG1LQkRqWWNHbGVNSkpvZU1NZjMwVmVMSVdQRHpqVHQwREZSYVpk?=
 =?utf-8?B?ZDE4Y1RwMUtxay82Q29zK1pSZWVQeHp5bGxka2Z4SVM4aTJtMGh3QjVmMVo5?=
 =?utf-8?B?RkxhcW1wYXZoWXBjc0VIcFJOaXZQZmkwdW1ZK2tZVEVrM0Zqd0ZNYXZySGFJ?=
 =?utf-8?B?U3FhNVlybEtLREVjZlBNM1VQUGNJTkdrUDU1aVI4cWk4YldTdnEwR2N3enky?=
 =?utf-8?B?K3h5WTdDbmxLZWpUeDFHdjVlKzYwTW41SExmWG50Nm5ReGJBdmgzVmZyREJE?=
 =?utf-8?B?V3BQL0ZOMmc1UG1mSFFkTWlQNlZESENwSlRDdXRzcjBFT0VsUU9yNWM5NzJa?=
 =?utf-8?B?WU9XVTFHcHp6dCtNbHlCQkQvZzcrZEZYNmJEMUJ0bU9zcjVQay9HOG1kNEFY?=
 =?utf-8?B?UWFMZXdmRlZId04xMUthMkpSYnYva3JhRUV5MVAySC9zQk5obUdYcWt0cVp4?=
 =?utf-8?B?YldtK2thMUZaZVFMOHVreGNxRjk5bFdNQ0FkNWZ3ZUNkVXJiaHZZbGwzcUFt?=
 =?utf-8?B?akdRbVdUVnZ0NHVoWmh0M3h5cmJZcnIxY01Zc1pmUUxCdGlhM2tPY042V0Vr?=
 =?utf-8?B?NXZoSjllTGdXdW1xSzNVSmRseVhMcXJNTVVzTUtQa2RsNEN6YXRwa3pZSENT?=
 =?utf-8?B?WlNSclZSNlk0MmMzWHIzdjFzWE5jSU5XZWsra1VmZUJpSTh3TnZ0cE1zVWVn?=
 =?utf-8?B?TWhPWnNEVE1xL29tdlArZ2dpV29wNWg0KzU3NVRYOUtFZkRwb0x0SHB2R0hl?=
 =?utf-8?B?dXA4cWVUaXlSOFA1bnluYk9jcnd6NWJpaG5yY1NGYnNORGxTS0hzWGZOZkFB?=
 =?utf-8?Q?o5pPg+YVnxR3WHg+88DydgbVl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8129A8CB2D4A434DAABAB49C179C748F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb30dfb4-548d-412b-5d54-08dc1c8e56b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 03:41:24.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rwOowh0ksikWI3HX5hJIIOah0ec8tt9F/7sJUYJ49HsvhSVsVz38mWT1se4wWE+xviw4uhoKo65fUuYvp28+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_194128_294466_1D0EFAF2 
X-CRM114-Status: GOOD (  17.50  )
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

QWxhbiwNCg0KT24gMS8yMy8yNCAwOToxMSwgYWxhbi5hZGFtc29uQG9yYWNsZS5jb20gd3JvdGU6
DQo+DQo+Pj4gVGhpcyBhbGxvd3MgdXMgdG8gZ2V0IHRoZSBjdHJsIG9yIG5zIG9iamVjdCBhc3Nv
Y2lhdGVkIHdpdGggdGhlIHN0cnVjdA0KPj4+IGRldmljZQ0KPj4+IHdlIGdldCBpbiB0aGUgc3lz
ZnMsIHRoZW4gYmFzZWQgb24gdGhlIGRldmljZSBjbGFzcyB3ZSB1cGRhdGUNCj4+PiBsb2dnaW5n
X2VuYWJsZWQNCj4+PiBmbGFncyBmb3IgZWl0aGVyIGN0cmwgb3IgbnMgcmVzcGVjdGl2ZWx5LiBJ
biBudm1lX2luaXRfcmVxdWVzdCgpIEkgdXNlDQo+Pj4gY3RybC0+bG9nZ2luZ19lbmFibGVkIGFu
ZCBucy0+bG9nZ2luZ19lbmFibGVkIGJhc2VkIG9uIGFkbWluIG9yIGlvIGNtZC4NCj4+DQo+PiBJ
IHdhcyBhc2tpbmcgd2h5IHNob3VsZCB3ZSBoYXZlIGEgc2hvdy9zdG9yZSB0aGF0IG9wZXJhdGUg
b24gYm90aCBucyBhbmQNCj4+IGN0cmw/DQo+Pg0KPj4gV2h5IG5vdCBoYXZlIGEgc2hvdy9zdG9y
ZSBpbiBudm1lX2Rldl9hdHRycyBhbmQgYSBzZXBhcmF0ZSBvbmUgaW4NCj4+IG52bWVfbnNfaWRf
YXR0cnMgPyBUaGVuIHlvdSBkb24ndCBuZWVkIHRoZSBhd2t3YXJkIGlzX252bWVfY2xhc3MoKSA/
DQo+PiB0aGUgbnMgYXR0cnMgY2FuIGFjY2VzcyB0aGUgbnMgaW4gYSBub3JtYWwgd2F5IGxpa2Ug
dGhlIHJlc3Q/IE9yIGFtDQo+PiBJIG1pc3Npbmcgc29tZXRoaW5nPw0KPg0KPiBJIGRpZCBoYXZl
IGEgdmVyc2lvbiB0aGF0IHVzZWQgbnZtZV9uc19pZF9hdHRycyBidXQgZGlkbid0IHRoaW5rIGl0
IA0KPiB3YXMgYW4gYXBwcm9wcmlhdGUgcGxhY2UgZm9yIGl0LsKgIEkgY2FuIGdvIGJhY2sgdG8g
dGhhdC4NCj4NCj4gQWxhbg0KPg0KDQpjYW4geW91IHBsZWFzZSByZW1vdmUgdGhlIHN0cnVjdCBk
ZXZpY2U6bG9nZ2luZ19lbmFibGVkIGFuZCB1c2UgU2FnaSdzDQpzdWdnZXN0aW9uIGFuZCBwb3N0
IGEgbmV3IHZlcnNpb24gPw0KDQpUaGVyZSBpcyBhIGFsc28gY29tbWVudCBmcm9tIENocmlzdG9w
aCB0byB1c2UgaXNfdmlzaWJsZSBtZXRob2QgaW5zdGVhZA0Kb2YgZHluYW1pY2FsbHkgYWRkaW5n
IGFuZCByZW1vdmluZyBncm91cHMsIGNhbiB5b3UgYWxzbyBhZGQgdGhhdCB0byBuZXh0DQp2ZXJz
aW9uID8gdW5sZXNzIHRoYXQgY2Fubm90IGJlIGRvbmUgZm9yIHNvbWUgcmVhc29uIC4uLg0KDQot
Y2sNCg0KDQo=

