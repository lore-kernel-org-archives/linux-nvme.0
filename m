Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A11C4321E
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 05:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=62XGme1LfNc57ARoUNWpcJMqJ2orwB9Z5aZybJLE/Ag=; b=oUvuQdeq44lriRmA1cFVyxN9An
	brhS8lNk3u2srj2GsNt1fciyxHcsUmfg1mYCdNOSopBFguksdCvt4GMCXtgvVTG9YH4GkV2hfAL1F
	cq9u57ypQ4eLhzTI8lCvraxvkOxds21qNmbmpCGo/SpQEqXl/NZyVTv4DwJJxxA+hOpeB2gBzeUmX
	oFEeRPRACraRST9xK153/tx5eJ5Aw4ZQKJQ0DZAT3QO9M1tXosowusAdydspSPxvta6lhsLsOUICN
	wYA6QKzyayVFOHj96uay64ZrYSwddji8mN9C53rjzEY9K/iVc0pYRiJ26drGcKMDEh09Xtkn1GaNL
	YIFjsMhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p24Bh-00EKC9-OC; Mon, 05 Dec 2022 05:38:45 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p24Be-00EJtA-Sz
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 05:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jISBEoG5QWkegztlj3+vwxl6oGia1fGv0/bwAEoAGph5CBTYDFdAh8c8+sLf0iOX2siMPYqPR/TcRD0TskfGesd+hXufEhSIlycjvZpeB78Ai70GYcmIWvfr0GZS6yGero8JXkizLG0Rf2FgvRwn9Gq8kqo6R+0ayW137rOGpfRmwvl+W/QtBhhTZ9Y+ePZYgXEAnelER1pTLP4q0xJpeh+mfkeNPfyVjsA38simxFR2UMrQzO9J6fRNfx862q+83dAi1/f5w22Zqb1YCFlAAbDFWzx/GlRoaT+Z9ZVvqpZf6ZJZZ0j5A9gXxK9Qo3cNIU2j7hucJcNMgi100UGeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62XGme1LfNc57ARoUNWpcJMqJ2orwB9Z5aZybJLE/Ag=;
 b=Mg8O34jEaOkUhtzQXcEuT62toN6gALfYCWSYbKP/+/8Xv3kR7TUgevMcL4qzCANuaZmpmW76PmuoBgB5nsFh8dn8yEQFiQFgPNn0XyO/5uwZGgYk9dDodYK7Say986LsEF74iPqCzvMQ+33Wy3qf9Ij3nDU41yUzRFK5bFjYCJB0r2TolT+8G5Hi2E7UuWgBWXDaVg7e2r8HR9oPIiJEFlYRKlSQOedHCM/VGUtHcIO5Zbo6tDD0sCd6Lco8IQKEddowrmx2hinG0prnPee2nF3ejzXSyyJPQhzQZzzUEOuvdmbB1+3D5GgnbczloSBz3qWjE89xK+TSi2src3QxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62XGme1LfNc57ARoUNWpcJMqJ2orwB9Z5aZybJLE/Ag=;
 b=V/sL1CPM15BVlUxjc0IJ47EISYWOfq1tsKoHOBv6pgpIHw52L6JVSiu4y/o1gVluK88e5cabiR4xP9K3JiewxxDgd1othgXmQE71dLLB0JN4Q6CwLpJIeRATOdQ9NOvFmsZHJ9rRB9bKaQPWLnYLBrMY8tyNwgr//e9td3+TzUgcYZsvGEj6ZX7eXA9HoI2+DhjqJFid9Keb3OjUXkIOeVR4FSbOG4zwbUoOctYALdAV+WuFkjJzwtzpMTE94bRSkIeXqb/Fdy5G/+i3fTqj4SuCJEeC4jtNTpRbQN+THA8G7a55B0bUkcZwihuF0JI/UTm16nvruwZWYP0B7l9y+Q==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 05:38:29 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3134:69a3:d1a3:beae]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3134:69a3:d1a3:beae%7]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 05:38:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Engel, Amit" <Amit.Engel@Dell.com>
CC: "Grupi, Elad" <Elad.Grupi@dell.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Index:  AQHY+obsZyL7ATBa8Ua7WNpVr5tNRK5HuhAAgAGK0wCAAAD9AIAACfaAgAAnu4CAFJ7qgIAAzBKA
Date: Mon, 5 Dec 2022 05:38:29 +0000
Message-ID: <f948dbe7-b226-ab59-7a66-2af5c960b0a4@nvidia.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
 <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
 <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
 <CO1PR19MB4885EADF8C1E970867C71487EE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a6fbc43b-7f7f-91f6-a157-186f2663b734@grimberg.me>
 <CO1PR19MB488579DCD958B74B2C8E38AEEE199@CO1PR19MB4885.namprd19.prod.outlook.com>
In-Reply-To:  <CO1PR19MB488579DCD958B74B2C8E38AEEE199@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|PH0PR12MB5417:EE_
x-ms-office365-filtering-correlation-id: b17f05ef-3468-481c-4311-08dad682f0b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  aJdLqDiZtAsw8oHOqlAPLxKutpBPGa1hAV+VrI8ITk6+6Sssb37QZ2K0W3CyhbTXShuLr6voa2MzDFUCiMi7MVIOeJcvHlEs362LluQ/SC4JFDRo07oxB2DiA+55++QL29X+axg6Dec38IlwOL+zWxcWb6eS/3kXJMAo4ekvYquc1vS1ecgsYwPK2Czvq0z9K0a6T83yXNGbYhwCLYPPejj4wqFMI1zzbuPixxuBDKriTImfA3Vr+Ol1AiJBistQDex4RQRq4TrY9lfJJ0IB3EOhIFXNZ6pXRY4xiFJyL1/2QdE7dm9GnShQXuXEKQlAME4dHAbZa4Z7b33kocZKGtBMNS806bcQlYtUujpOhp10lR28tq3M8Rx+YGUpKi8o8/gCwOlaBmg4tLHhls7G5MPebwASCIcGKjYnkXAB4bAP1+nWnUIUEo7cjJByCPgCSc/xSfKUUu7v7zlblCtCVev8dp6vzS6FmtpaX6Pw+qoyru8QSLb4QrTT/aoevCNhqxn1eD8sUtTD91tcsKIuh8dA42DFm1OI9iFrQKpah/hPj1KQaugCwK2tEhnCx0p+HW9oKcMtTY0QH4Q/M6wLBj3j9FZacBsqzsksVwep2qPDYre8hsm0Vk59BJt1QyAUKZ9Ul3xzwhVDrCtbsfvCMD9DfyVUpe6fAIXTmPZcaynW3EnZrhjT0KcafFXsjhiCl++I3rLjeOuYrtE4VPpfw8uRK5T4RO/+5AANyF44ojk3t0pxVFjadgnJ4lqSnY/8nldkP2OKysuZv6U0Pz/Awg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(31686004)(558084003)(31696002)(86362001)(478600001)(6506007)(71200400001)(6486002)(38070700005)(36756003)(38100700002)(2616005)(186003)(83380400001)(122000001)(4326008)(8676002)(5660300002)(41300700001)(6512007)(66476007)(66556008)(91956017)(76116006)(66946007)(316002)(66446008)(8936002)(6916009)(64756008)(54906003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YkdzYTZ0Q2M1ZUZNMjM0aTkxa3dEb2tkNDg2UnRkM3ZWb0FtcEdPTVQvcmdp?=
 =?utf-8?B?dW80NGxGQnpGSnRQTHVkLzdYQVcxazFhRklkZUdDanFSUWNRVUhuQmp0TGxK?=
 =?utf-8?B?KzE1ci8zUjlzTkNmR0t5ZEpJcDQrYkVvd3NNNFBtMFB5eWVsNG4xV3JVNDMr?=
 =?utf-8?B?ekM1eTJnajRic1VqVXBqSWJIQWU4bm12RkN5anJIZ2VvR29yTE5qc05aaHBC?=
 =?utf-8?B?T1JiTXZ6T1V3UjdzNnhqRFJUK210WitSZXBzOGw4S0xXdm9zUUZaV1RMbzJK?=
 =?utf-8?B?UEpiTWo0UkttUHcrWjk4TGxTUWg2Mk5idkJ3Mm1IZGQ3dDhYTFMyMERFZmhB?=
 =?utf-8?B?bEl2K1VkYmNia3RUd1dnQmVCQ1ZFZ0svUzVZcUo0bUxuQ0tGaWRqbWZjSkg2?=
 =?utf-8?B?cjVNN2MwVFZCSWMxdHNNN1R6S1gwZ0w4dmtVWCs5Z2dFYSsrNlFJQkVRekU4?=
 =?utf-8?B?Y1NQVjJSWlY4c1dTM0xsVVgra2J4d1paMGlXKzREVkdpWmo2a1IwTnowTTdt?=
 =?utf-8?B?WjViZlpvSk9hT3JVUWVyZi9OM1d3bkdXcDZmeExFUGQ2dTZJRTJNSWtqWEk3?=
 =?utf-8?B?ZG45N0dPU29zYVc1aVVXMGdXU0duSjZSRC9lOUtoZlJEby9LWXhVMHMvTjdj?=
 =?utf-8?B?SFNNc2kyc1N3akI4allHYWlJbVAwNzRxT05TeVBEMm5ObFFiWjFBRWs5VThL?=
 =?utf-8?B?ejZCTzUrbHZ4ViszNHgzbWNFcVpZL01FOG03Vml6NmJ0aGdIQlhGdS83eXVC?=
 =?utf-8?B?Nk1pRFhBTjZaVE03L2NsQ2I4My9rRTFBd0w5dm9KeDlLVjVwWVErZmRpdG9s?=
 =?utf-8?B?bkhRY3hENEZjVFFtUnJLUEVJNHhHd3E2R0xPS05OaFN1NGxJSjUvc3AxTzdU?=
 =?utf-8?B?T3Ira1dubXU0bEtmUHg5NEVIWWRGSjU5OVIrUG41dEVSQ2tZOEp0a3pJQ01J?=
 =?utf-8?B?YzNxdldjOURteWRnbFRydWVyZlFOTk41Qjg1TU03NWtBMkwza1lRSzF1clB1?=
 =?utf-8?B?UVdzMlFWaHF1b1F4Z3pndGZrQXUzeThkL0d3VVJjQzRRVzFxeTgvRzR2NkV5?=
 =?utf-8?B?ZzZlWm1yb2ZIUkhvRjVCVlA4WnpNejBDbmRyOVBCWVNYZVI4WVNlUUxFZVBl?=
 =?utf-8?B?Mkp5VDdsdHlKd0xlSS9qd0c3Z3NMVnNEM0RobFl5cHNLYUlDMHFIY2FGZml3?=
 =?utf-8?B?MjV4YXBuZWZHN3FyL2poNDR4L0g2Q3lkUXVHTnY1WVRZOTVhMy9TbmlsdDE2?=
 =?utf-8?B?SzhjYkVVcEhGam1mSUdYdlN0Zmt2TlU2K0N4NlZGUDdLSkNicVYvdXIrMmR1?=
 =?utf-8?B?NmVDNEU4ZGorZnZjSXdsMnJTYXRlMkZrVnlOanVCYU4xTEVmd2Y5Y2huMmNS?=
 =?utf-8?B?djlRMDlwVHlrdFU3TlI1Q3FxeUcvSWlwTzVxM3VNZStva2pSREEzUVl4YStK?=
 =?utf-8?B?MjY3UmlGN3hVRGJQbTFVS3gxRnpVSHdET05LcEkwaEp6TEVsSTFHRUR5Y0F1?=
 =?utf-8?B?dTJsK2FMU3hvMkpIcFFRY0JxS3RYR3N0T2grdWdocjd4NHQzNlFBUlVFaUts?=
 =?utf-8?B?TGpRanloREdmK3h3dUhVRUptQnJjMU9IdG5BbDd4VE5NSmdKUW0zVDhxaGJx?=
 =?utf-8?B?eUhzWVY4c2lRWFFZTkxZaEFrb0MyWU5FRTNCTmhDcTU1ZHMzOWVabWRiWUFR?=
 =?utf-8?B?emp4MkhsN1liU3JicmwwMjBsMGZmMzZNM3NWaFlYVnR1a3hEcFRHbUR5cDN5?=
 =?utf-8?B?TlVlR3N1RWNiOFFtSCtHK2R0bkZGa0xsbGxyUUY1MVdhbk1rY0IxTi9Kbllt?=
 =?utf-8?B?SlBxTkE1MERGczE3ODhHK3VFbXhEbmhuUmdtWHJIdjljbUg4bzlOcUh1L0J4?=
 =?utf-8?B?VFFmQzgxekx0dmwxbytiVEFuQUV4eUpjNElxblNTVHFQMkd5eTcxZkthSVRp?=
 =?utf-8?B?ejdRN250U1F5WlQ4dGU5Z0hjVXJiT0l4S0Uxa0hKdEVFUWNqNWwyR0RweUxI?=
 =?utf-8?B?VEZWcUdKYzBKalJuR040MGxMMEY1b3BwS2VGZ1pHSU1iWXZQT2JyWlcyalF4?=
 =?utf-8?B?SVlvRzFvVXlEOUd3bDVqanhVeUpXcWdLeFViRVkxQXJlT2h0Q2RjQ3h5bWVR?=
 =?utf-8?B?Y1Z3QXYvZFc2QnBFOFhJa3VlS1N3MS81NHlYZWpZR3Fod2Vrc2FWdldjdlUy?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <261FD56AEE34894783A073820BF5024E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17f05ef-3468-481c-4311-08dad682f0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 05:38:29.8955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90B1zLuvPvu2wDjChPi5LtjtzxahS+ElxqOMRAVKI80OuhPUP7F7OxcEgjvOCD44hcrWsM7bhBb2p6z+O9WGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221204_213843_199673_0596C94C 
X-CRM114-Status: GOOD (  10.15  )
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

QW1pdCwNCg0KPiBsZXQgbWUga25vdyBpZiB0aGF0IG1ha2Ugc2Vuc2UgYW5kIEkgd2lsbCBzdWJt
aXQgYW4gdXBkYXRlZCBwYXRjaC4NCj4gDQo+IFRoYW5rcw0KPiBBbWl0DQo+IA0KPiBJbnRlcm5h
bCBVc2UgLSBDb25maWRlbnRpYWwNCj4gDQoNClBsZWFzZSByZW1vdmUgdGhlIGNvbmZpZGVudGlh
bGl0eSBtZXNzYWdlIHdoZW4gcG9zdGluZyBvbiBtYWlsaW5nIGxpc3QgDQppbiBvcmRlciB0byBh
dm9pZCBvYmplY3Rpb25zIG9uIHlvdXIgZW1haWxzLg0KDQotY2sNCg0K

