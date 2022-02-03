Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CE9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 08:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GihEeRJ3Wf/VQfIHbjEzWELokqpTaaKZ5mGMMJm/aYk=; b=EEbUcv0PLnjg9NxUfiYJSaRM6m
	nvT7jdFr5bHSyli008vNeqJzfG+neyS+47Q/VjkfezmUhd8s/t6LS3fzurtfeIkzbAQVNKTF3I5NG
	dZ8odCtEBAWstetjDFnynxnGufbcA6wno65btsznc1cV58n1OW5VT42HGV8NS2Q+rFtEe1TlzB7Yx
	CkD0uxHbd/3IRm3iwcbVjeTTVZ5qD+USNlqDdPEvJso6JnEcQE7Nlc4Nvikqnm2rMOMZJuY9MW8eh
	Zs1gv1xB/pZDDNlFxa5QhOId1JsqZKKil/7q+y6xNZ+k8P6NSrJANmm9g6VTVCUjn/Otx3McvJP2C
	EharLQPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFXPO-000Jvy-Dr; Thu, 03 Feb 2022 08:24:02 +0000
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com
 ([40.107.237.55] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFXNw-000JJY-Gs
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 08:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhK1ePCaXGzs47EI1JUw3/zGUHvF/EpG4NG7jOOC31JxYtPOFmPlJHd/b10koL2ZnIdqZZyDeTR4DM3uvfxmJ03AgX8wDQIoE0Qfp7IS9iXD+3Q8RSfpDHlCIsAi0jQANHswyH5Qp6LbhDedZfmcNacfSDeAaSyS+CJgK27QpB52TlTmQ35IBy0cMfNKtr/IPnvrbpuNlhkTHLt3GuGaphC6CJV1xccnHlL2F2R3RWDJzZfDu/GH+RToSTk9Rs12MxxQu6vrFTLz4rIFyf6Pt/tPxHGrBmHK6L6hqF88ahLoZCmrXF1em23EGpMOGF2n714JlCQNa7epHkTNDRktkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GihEeRJ3Wf/VQfIHbjEzWELokqpTaaKZ5mGMMJm/aYk=;
 b=hfDCiVcUjlRQ3pcThoVWtUGSf1zx2BSD/wyMGHIV4U740VgdVk0beJpRlPNbAsombt+sfIz/0flu99k2g81ltUaaLajj3H0rB8ZtKwYiQ8cK0ybZ/zc72hZaTZQBfiEH+SM2LamKRj4JQNvvH3t7sYZ7OVFAyRG4f75q2f3buXkmt/7H1JAba1pY26Oz3P48+OHVqRP1PWnQr4pxK9ku7QkQzoNhyvQGo7WysIame2M2GQJvjYAYFgi/CO8Nv29BlLMvokjhU71blFpQOoITiWjlQkjtgUTjCKlXV08oXoK10ixXRcL5MwnCf0tNDhhXjvJxUai+BsMuOujAEVq6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GihEeRJ3Wf/VQfIHbjEzWELokqpTaaKZ5mGMMJm/aYk=;
 b=tH4iiQCqXp789Zuc2H8lcC7cmLoH4FmIu8QQUSyjhhpYThocNRDLCqxMnd9Y82/nC2kAa3N4W2UXZKUHGbzb0bGbCmCG3hHP3DktELpsUSep2MfKap3xatjo2522Ai+dxbVoDpUSUd5/t2IvDXTi8vJVAt5z4bfpc/PhV/2y3UJYPP+QMIOZTAXOHjXDWugcmv7jP2J8t/g2sWicDtxEisse3+HA8WgwWNL30rRWjQp1KxFiJaZDWSgrxFE/dGKflUcCya67YR2ofo/RIv6gWPPTwB3Ge0/OGKcBGnObnfDRyNTeVI68ka9NH2+vPupgMeqBryiVJBIQ1DgtbsR/1g==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 CY4PR12MB1286.namprd12.prod.outlook.com (2603:10b6:903:44::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.20; Thu, 3 Feb 2022 08:22:29 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::ecc8:cc10:19ac:b66]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::ecc8:cc10:19ac:b66%5]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 08:22:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
 Alan Adamson <alan.adamson@oracle.com>, Himanshu Madhani
 <himanshu.madhani@oracle.com>
Subject: Re: [PATCH V7 1/1] nvme-core: Add verbose error logging
Thread-Topic: [PATCH V7 1/1] nvme-core: Add verbose error logging
Thread-Index: AQHYGNXNSMdKFetEYEicIhQuvt0CiayBfLAA
Date: Thu, 3 Feb 2022 08:22:28 +0000
Message-ID: <87a89963-edd7-a0d9-02ba-723efe25f498@nvidia.com>
References: <20220203081153.162956-1-chaitanyak@nvidia.com>
 <20220203081153.162956-2-chaitanyak@nvidia.com>
In-Reply-To: <20220203081153.162956-2-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f79f9fbe-d960-4888-374e-08d9e6ee5135
x-ms-traffictypediagnostic: CY4PR12MB1286:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1286844404D898D5F8D44830A3289@CY4PR12MB1286.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuOgybpGPIIxs13BO9zf/mZ8uFs5hWrjNKAHsi4ZuS5WxiAdw8AGKYfWyUnb1rBlC+vRwY0JvrMaZl6z+pmJJCDJddfa/uS8ypdIeWVrXksoTovDdyUk7Pjl/GsUALoBRM5Q+9+vdM6emq5D0CPKHF4gqa11427gN8fJiRKcDJTJJu41lrHXbHrkuC8Bg9R7blpnNQihyZHsFArp57RBvicle9vTRzpwIVZa0ZsO6Yvr5GBDu2giKfyx6VBSXn5wbTTyJWHh8ZFe6ab+Q5jS9dNZhG0evCbECDBlw2dwMh9akvJMQZm3QZiQgwO/HoWB4ntw76w9DHG5EEuYKDL+VdGvPzXPMnK8OvIfA05U7vRDiFfU3EM7WTKNAYHeZjhpJ6MMsUdFe4BwX3h2ItLQjl27l/wSAc0XVFD1rzTO4bUT+qjq8a2HXKzl7QBvhXiwiihKI/Jn/BeK/RAE8A0wwz+F+6k5hCNd3tq/2ozKq44fedyjGGil4x2v/6reh82Brhe8l9FDbeVKcQeDPwGOo3VKr3YVsoFqhi/CzQBplta75trnzeAJaw1zP0oQ55P4SP5psSL599tmglQCFmNHBLaQFxBuM+dNTD7LpgfYu5NAU4/opiHp6Bl2bmjo03eS4koUr0Ld/CegvH2rUY+Gldv4J+OxGkAbwfAK3Ut5vgPSmeidJhMbOC4kC+acuwreRRMq0rDuZ3i2r+Z5gwhjxk1PRKTAHflgEjVku06yO3jV1C/56T1a5qcbJjFHn0YitFsAGJ+Tzqiu9Sb0HZNYfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4663.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(66476007)(2906002)(122000001)(76116006)(53546011)(64756008)(66446008)(316002)(66946007)(71200400001)(6506007)(6486002)(8676002)(6916009)(66556008)(91956017)(31686004)(6512007)(4326008)(54906003)(5660300002)(2616005)(31696002)(38100700002)(38070700005)(186003)(36756003)(86362001)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnMvR0oyQzZma21LUTQ0WUpWYUtjVjdodjBwbkpHNFlZRTZpNUFRZ3pUcmJs?=
 =?utf-8?B?NnFLYU5lU1hmTE9FS1J4ajA2K2hhQTJ2bC9OUFZYNnBremdwdUtkZFMwYmpV?=
 =?utf-8?B?dEdNZ3ZQRnRReFZCOXFCckhORW00bjErL3locXE1NEU5NHlnazVWYWFEYm0z?=
 =?utf-8?B?enV4TUwvQTRoK2o0Qnh3bTFFdzlDZGFvZUFMTGdrRnZaRjc3Sno2dnNpdGRN?=
 =?utf-8?B?TkRMaU9kMVdJalkvNWQ3Q280WHMreFZoUHZibDR0S3g0Vy9tQ3JUYmNjZUNJ?=
 =?utf-8?B?aG9GWUZKL2V0YThwL01oK1NOMXg4SWlCMWp6Zk9nQlJEWFZINkxZZmMwdWZW?=
 =?utf-8?B?OGhrTnVLTCthOENhTkE3Z2piK2RwZERuMTRra0FLdmhxQTZkdVpmdFFaL0Fh?=
 =?utf-8?B?dU0rSnNwaUpwT2xKdDdmOUVBSGoxOEdOeU83R09LZU00RU9PSU8vdzdsOTZ0?=
 =?utf-8?B?cFNtdEtOOXdHeGpmRzlrNFR0QTJPVFZNMUp6elRZQk1Tbm5DeG1lajdUek00?=
 =?utf-8?B?SHZlQkFoMER2QzJHMVJSRGo3Uml4U0xaRVVPT2VZZnQ1YU9xZzcybGRuVmFH?=
 =?utf-8?B?TWltTjFwMjl5d1BZVlZzbFRVb09zeTFYdjFWajZsUHF5S0p3RWJrc3JQbVZa?=
 =?utf-8?B?dWpyTExVckZPeVNVVForS0Q4akRHcXF4NU10YitkM0k0VFdNRnJCTEY0dTB3?=
 =?utf-8?B?QUpKMnFLMVRxLzhFeEdGWk1VTDZxUGpwMlNSMEwyOENSVStUNEpNWnZ2ella?=
 =?utf-8?B?L3pUK1BCdWlSL1RTd21qUkRvdmNha2o5ZzlGU1NQUldnZ3BPejZBZkJIRTRm?=
 =?utf-8?B?clEwT2Z2ZmcvK21UaTBKalRSa3h1TTdCbk8yV2NJTU04K2pPSzkvQStDMGxC?=
 =?utf-8?B?bFVSU2JZWWJhODhEdVN2SDQ2VFFRdWh0ck5XUWE3dzdmS250eTQxeitJVS9N?=
 =?utf-8?B?cXJJZEIwdUROalZwaExBdU9LRzFIVnBlV2VjdDczNC81a0VpZHlNMSt0VFJt?=
 =?utf-8?B?c29nckl2UHBBaHF2ZE9Cajg4elgxejJPT2hzYW5DRWpqSFRoNmpoa2tIRzdw?=
 =?utf-8?B?OEhGd1hIU1JwOFZYMHMvYUtKMG5OOUhKVC9QdE5ObFhuc3Z2Vzc5RGRHWHI0?=
 =?utf-8?B?VHpIak11OVF5MlM1elJWNUdIWENOZVMxdGwwejAxNGZPODVxMlJmWENjSkdG?=
 =?utf-8?B?WDc4UWJ3Z0U4WUNiU1JVZGN6dytOV1I3RVV3ckFXRzZRaHUxUk45UHdYd0dN?=
 =?utf-8?B?RkFYUWRKcWtYejQrUWV0dVZtaHhmdzF0NHlZbURrTkprUzNZM3FnVVpPZ1Fk?=
 =?utf-8?B?RWxBSUhFYWV1NkpSZ2s1SHhXeTB2UWc5b0NHZGY4bTc5VFdkdWluelh2NUU2?=
 =?utf-8?B?Q2JKK2ZTeTRoUWgxRUpoK0lLd1ovZU1LZkJIYTBnKzBSV01rSHc2L2JwTjJy?=
 =?utf-8?B?eXhUZk9oc3lzdlJyaXB5MVJ0YndXcUZLWlljUUtEVkorMDZ5aUZxcVR6U0lr?=
 =?utf-8?B?TWdvU0Q4K3FmSlBadHB6SFVleUY4WHJ0eDlGYzNDazk3RUE1YWtwNDIwcVl1?=
 =?utf-8?B?elBGQU1JL2l3MDFsMnUyanVJL1RVSkJDcnhGY2dXdmY4TTFXZ0pQUG1DSW04?=
 =?utf-8?B?c1RWWE9zUWlvOUFvWDB4NkZaN0NteHdiZTBoMVhCREY1OGkyVnBUWE9SakNB?=
 =?utf-8?B?ZExpUnJKWGdjTWZBYURrTkMrRjBnL25uMGdpdkJuVjhWSFNkMWQ2RmVvM1F5?=
 =?utf-8?B?bEtLT1NpaUZZcVMxZHIxblNJdnBMbkxqQ0JoMDJwTWIxL3NGRi9CZjZ4YWo3?=
 =?utf-8?B?eEhxdTB3emdvdllsVnpxMDJybyszbFdHMXh1czZoTU11Y1pWUlRDT0N4bHpH?=
 =?utf-8?B?VnFSV25OZ2F6eDBHeWZaOUR3bG5MUHhuVzBKZFcwQlRCSmx1MEovWUFCUDBL?=
 =?utf-8?B?V0ZwSkQrbkFWOU1kYWVmZGpVcE52RTlTTHlRS1BkRlc1Mkh6anJyM1Zka0dQ?=
 =?utf-8?B?bWh1eUF6U1VkdVR0emcxdEpjRjVTMEI3ZUJoN1BuS2hRTjA1SDFaWlBLQjhJ?=
 =?utf-8?B?ajdiN0puWVhVOFlUWGQ3YkpiOGlHQkpDL09tdndaWHJxSkx1ODNmMUZRUjNn?=
 =?utf-8?B?L0RMM1RHcURnM2kzcHFTWmdkZlA5dklhOGU1SGpjdVRJNjF0N2ZrSWNRZHJz?=
 =?utf-8?Q?kE6XPjTQhtZhMO6kTI+x120xZ7VSvwis9Nh+LlfSttsq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2C8404B9E12A846B42984A47DEED866@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79f9fbe-d960-4888-374e-08d9e6ee5135
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 08:22:28.7745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6e1uKj4+meP/DA2clFxM9tBDbsAeUpEU24NMwatwar13dWWKDM0g3V8SevH4Trwn9PUX4uXM+IiMOyAMco6Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1286
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_002232_641824_B5065D9A 
X-CRM114-Status: GOOD (  12.60  )
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

T24gMi8zLzIyIDEyOjExIEFNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IEZyb206IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+IA0KDQpJJ3ZlIG5vIGlkZWEgaG93
IGFib3ZlIGxpbmUgZ290IGFkZGVkLCBzZWUgWzFdIHRoaXMgaXMgaG93IGhlYWRlcg0Kb2Ygb3Jp
Z2luYWwgcGF0Y2ggbG9va3MgbGlrZS4NCg0KPiBGcm9tOiBBbGFuIEFkYW1zb24gPGFsYW4uYWRh
bXNvbkBvcmFjbGUuY29tPg0KPiANCj4gSW1wcm92ZXMgbG9nZ2luZyBvZiBOVk1lIGVycm9ycy4g
IElmIE5WTUVfVkVSQk9TRV9FUlJPUlMgaXMgY29uZmlndXJlZCwNCj4gYSB2ZXJib3NlIGRlc2Ny
aXB0aW9uIG9mIHRoZSBlcnJvciBpcyBsb2dnZWQsIG90aGVyd2lzZSBvbmx5IHN0YXR1cw0KPiBj
b2Rlcy9iaXRzIGlzIGxvZ2dlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQo+IFtrY2hdOiBmaXggc2V2ZXJhbCBuaXRzLCBjb3NtZXRp
Y3MsIGFuZCB0cmltIGRvd24gY29kZS4NCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEsuIFBldGVy
c2VuIDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxhbiBB
ZGFtc29uIDxhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhpbWFuc2h1
IE1hZGhhbmkgPGhpbWFuc2h1Lm1hZGhhbmlAb3JhY2xlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtl
aXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gLS0tDQoNCg0KWzFdIEhlYWRlciBvZiBv
cmlnaW5hbCBwYXRjaCA6LQ0KDQogRnJvbSA5NmZhYjZmNjQ3NDU4NjgzMDExZTAxZGE1NTBlZTQ4
MjBhNDRmN2UyIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCkRhdGU6IFdlZCwgMiBGZWIgMjAyMiAxNjo1ODo1MyAtMDgw
MA0KU3ViamVjdDogW1BBVENIIFY3IDEvMV0gbnZtZS1jb3JlOiBBZGQgdmVyYm9zZSBlcnJvciBs
b2dnaW5nDQoNCkZyb206IEFsYW4gQWRhbXNvbiA8YWxhbi5hZGFtc29uQG9yYWNsZS5jb20+DQoN
CkltcHJvdmVzIGxvZ2dpbmcgb2YgTlZNZSBlcnJvcnMuICBJZiBOVk1FX1ZFUkJPU0VfRVJST1JT
IGlzIGNvbmZpZ3VyZWQsIA0KDQphIHZlcmJvc2UgZGVzY3JpcHRpb24gb2YgdGhlIGVycm9yIGlz
IGxvZ2dlZCwgb3RoZXJ3aXNlIG9ubHkgc3RhdHVzDQpjb2Rlcy9iaXRzIGlzIGxvZ2dlZC4NCg0K
U2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCltrY2hd
OiBmaXggc2V2ZXJhbCBuaXRzLCBjb3NtZXRpY3MsIGFuZCB0cmltIGRvd24gY29kZS4NClNpZ25l
ZC1vZmYtYnk6IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBBbGFuIEFkYW1zb24gPGFsYW4uYWRhbXNvbkBvcmFjbGUuY29tPg0K
UmV2aWV3ZWQtYnk6IEhpbWFuc2h1IE1hZGhhbmkgPGhpbWFuc2h1Lm1hZGhhbmlAb3JhY2xlLmNv
bT4NClJldmlld2VkLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQotLS0NCg==

