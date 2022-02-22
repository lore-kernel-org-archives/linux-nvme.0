Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A601C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 09:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=urV+9h1EYVgo2wT+MMwamunNMx6M8y1XXCR6nxXU6zE=; b=PD5NST9CKm92hb+Yy3+3q2QFoa
	sxjOdQ3RNny9Gk6RpgNrtMKZfkwl0VDOfgoOmy2jrENF204E+zAU257TrsyvNJ66LWH5ShY0yp5bw
	uyTcSxPpOEISVjQabOQvrqX91fM3QwCzoEBhIjdb8fEpWpqO8LE5KUNA9piO10CfANaHCUFRo9DtL
	mE8mrHDAGIUHP2JqZe0c85pqylMzWqSAcA/CAB+odrm8pw99zAkJuX+EFwR2/Zde9/4oLkx3Grbi9
	dOJV6s1NCvoLg5aPpqz2IgJ5ffQuPxWV69j/WVMrCCeyPkgdgHa+HDpwt+WMbpt3A+Ly1f40DIGdD
	RVpN94IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMRrU-008pmf-3o; Tue, 22 Feb 2022 09:53:36 +0000
Received: from mail-bn7nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::60f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMRrQ-008pl3-Tp
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 09:53:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfE9jH3UXT+b2jjacGhHjHql+gpyIzNbixDRnhMEc1b8v7VLenljTEYcwPJoEpSl16gn8BDy/OHQdtRd1sCGjdiWi/mpLBmLkwviPaF/gAEcDQy9jbDxpIpmKF5Njipq2+C2LiSZakn1AlhzjGRQTFIqw/64TiwYoVHth1HGYnbt/pbDMzFH7AHHmoY/ZekUY+MAjEBG+qIh2DT4PyYnJnJlk7Ao7qIIR5WGtVX/iiFpECbjp9QqpH00lyjKdrZCt24Z+6l0A1bwmGyWbEIF/crvubsXAmrnaGSPb6YPlsZiql+PYCjaOpkMHmYyJQkE4kUx5M+6a8MSUO7R2k+BYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urV+9h1EYVgo2wT+MMwamunNMx6M8y1XXCR6nxXU6zE=;
 b=DtDhcs1dszgqQveXnsKlhS8h4CDpoF2pbhbsNjMHdvpKghyLxVOd+aJYtPM3Ul+t75P0jY+E+5YdUYmMc+zmN0SDWATPmQ5J49gic9lk8NFml1gmKkg5m3JDRmFEj3s7XAGN6c2LyND6YiCEh9vpRfpc0cA/E5m0/sqsXLmnb/zfU76Cicxo1kP+I7c4ES2EwP6XZRnJq/t39WsP5Gekn7dfDkPMWfmFm/EdqYhbxh1TTUFKAKQaLghRtHF4R5CsXLRZ8j2MyxAvVAFjyCNQwfAoWqc/z6L+hLPq77it12GGseL9ulgHxzn5nwDHqjctgpfPij9ZZbm9fLeVUUFWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urV+9h1EYVgo2wT+MMwamunNMx6M8y1XXCR6nxXU6zE=;
 b=CbFZDMF+iAunawsBLyYlSA//2WTEKN3QCpALr0mMMnajk0vuAVtl8T91XOObRRA3jupDfZFqO2lL/MBbhsdm+9nol1dxwzaMjBIkRM4IDwcbN/9bnw5NhAfoBKqcjlHLWC2fy20zRL19vaqCujRQIUq7LibkIWUY2a+IN9IcZgg38l21eBi6rJfpK35gRWx3GqhTW2DmAA5FmNULyVURzlic4F6SuZyAVE2CeJBXH1FrbvSXFhRx/b/8GWcVJJVNca8LXIE/bzgNorP/fEoTCBHq5Xb6J0zHbgJtSpWiLRZMRVOszzZ/AgPlNbjhel+zwhj8WMEigoUtAHtuoy513g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 09:53:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:53:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Aleksandr Dyadyushkin <alextalker@ya.ru>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: Aleksandr Dyadyushkin <alextalker@yandex.ru>
Subject: Re: [PATCH] nvmet: parametrize maximum number of ANA groups
Thread-Topic: [PATCH] nvmet: parametrize maximum number of ANA groups
Thread-Index: AQHYJ8onNiZMrCX8GUmK7qPInV5pPayfVIAA
Date: Tue, 22 Feb 2022 09:53:28 +0000
Message-ID: <6aef5693-1ef8-45f1-741e-541cd5fdd98d@nvidia.com>
References: <20220222085522.296465-1-alextalker@ya.ru>
In-Reply-To: <20220222085522.296465-1-alextalker@ya.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 367c9e48-6a9e-4a02-4f27-08d9f5e92d7b
x-ms-traffictypediagnostic: BL0PR12MB4947:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4947DD2787C7A9A4B4EE61F5A33B9@BL0PR12MB4947.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UWUODBD6KO2/bAcwBy4PV/YQpkq/eLGMKEMLUnIaQMKzvXImIiaCwhyt2xW4lnMd5SIh9n2BUTo19ZWnQAgmZiz6lKTghtE5wvFdH6FtaB+6I5HpxnVoIrIVl2G9mLR196exRZcxa94QAE8sPMg/IXUBLPzjOcFs5Ns4PlSbzGJva3rMZE6O2XFMIWltxV3yRoUEWoq7GLKDHvR7DUGRDqo2Y5oAtYy8G3qqIVOErxTZebUSkr2wB81PGhR1lTEPmxQWx1PZ6jff0c3xrToq4w+qpUb5y5ylVAk7hWmOoWdl1xyQILppWqOpIIoeAdhhWccUKHqwqFpwMhwCPL+V7bwwgCgLWoE1DgfDC2XwDzCuexzjyIgUDPeq2qapikuD43nmDy2D8+zDUa4l3I/Lk+4Fe8BaUaBXkLoW/uorcbNcjHjH0euLu6gn1xUNWMYSbVv62ejtkgldCV6x3gSGvLWjimtwWOaARIQwsAD+gQVunZKNg62uytk0OrTgZzQefzQejfgoRIvWreblAC5ogUMHxdAOl+otFMFWbZ5oWKcTyeIjLdLq0psOfqBZBjoCMDD41xoJEQrf3QQEtLuUlryxuh3HTVgGQ7YSm8k148kggprF22x2WCRO592dE+TC1ObVYxk2c8ithbaDuzYaHrMNxG2jQTKzaB+MlXidKuNb3sGTDv5QldLWc6Jn2fRJrhspWhUQC5fSYhwJUK4HmqK0wBBrvKIKPXebXYHjC378QeC+YfQfLtjE6BHcRETP1rdGb4BzIAQIcxZU6kFgXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(71200400001)(6506007)(2616005)(6486002)(38070700005)(6512007)(53546011)(508600001)(31686004)(2906002)(38100700002)(66556008)(66476007)(5660300002)(8676002)(4326008)(66446008)(110136005)(91956017)(8936002)(186003)(316002)(122000001)(31696002)(86362001)(76116006)(83380400001)(66946007)(64756008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1BpcGQzSDR4TTBIbGlBejZSUTBGTEljLzVSZEN2NFFsdXk0TFpMYUpYMWd3?=
 =?utf-8?B?OERvejBDZWpVR2JvZTcxSkdhVzlmTDVJeCtWMmVPQllpMlpxenpoM1YyUkw1?=
 =?utf-8?B?b3lPUzJOUVAvTzBoRGhyNXVHUW5iM0pwalQzbjdlUEdxb0xSdmVmWi9mUFlv?=
 =?utf-8?B?SUZ6R3pNNkluK29OMVhBTlBLTjRVS1FKOTZEdWhlRWh3TkdLalRQcU1UNnds?=
 =?utf-8?B?dDZMeDUyQUlZRytwZVlXVW05N3hmT1dYOGNMMmxkY3RIZTJXOElrVmdiY3RD?=
 =?utf-8?B?NXlzb3U0MFhtUFpTbDhwcUxabTdrYngwSFdERHBTVkljYXpzRVhXQWwrUExy?=
 =?utf-8?B?djBPeTgrRERvb00wbWdOblpxbkVjalhlZnhCNFpIMXNJSE9ERFJGLzhlV0dZ?=
 =?utf-8?B?alA5M1cycEdHMG5nV083ZmRpcFBxRTNZQThNZmRGZ3FvSm4rN25qczdYSXZi?=
 =?utf-8?B?bk8xQ3V3ekZJdFBNZFVHaWFmZm5TUDhNTHZBcTlyejVPUkg4endYWDBrcFVZ?=
 =?utf-8?B?THpNN1BGcjdkVUFaeGoyR29yMlpCZjBTWDZodWs1VnBPQXdDSHNOUnFXdEM2?=
 =?utf-8?B?Q2hqOVVIdXJCY3pFakZ6UmNwMmNkV0IvVFpnejZYTjRCcVlGTVMxNVJuVDcr?=
 =?utf-8?B?dzBhZ0JndTRoSHpHMUxEclBRb05WQkhDQnpreVYyQXZnNm1OYXJOWFVYSVpw?=
 =?utf-8?B?RUw5SGRsYVE2VUsxSjM4anRWd1lrMTRWRFB6ZGY3UjFTUlpnQitjL3RMUnUx?=
 =?utf-8?B?M1VYdFpxTkV5ajZ6UzZCMCtmMnZZTXZLMlVRQ3BKQ2NGODBTOXRGNHlVSWtx?=
 =?utf-8?B?MDdrQjlHamNwMTA1dExDKzBkSDEvdUtpYmZoZ1Vhb0FqK09lYjBxU2VubUl6?=
 =?utf-8?B?TWl2ZUxIajZoY0d0YWs4WG9RZE1ENlNaVlZQNStEWkJBbmpsYU9nYUJkaks2?=
 =?utf-8?B?UWJySGpEQUFrd1FQT1hRQVVLTzlFUStNQkNZSXhqSm1nSU5Mcmh3cG1QQjly?=
 =?utf-8?B?MmpQY29ZZzNWcWpPNWVlNkZOUXQyOVlrRE1VaEtGZThMY0lWcHpOV01jbWEr?=
 =?utf-8?B?WVZWZzZMQ1ZwdklJbVNwMFduekQ3NTNOejFzbm5NdnR3bHk0a1BWRHVBWkUz?=
 =?utf-8?B?SjArMmNMUDd4bitjMFBsL2wxZXFHcmNwOTdDUnRwbmtEU2FMWEVOclFzc0Rx?=
 =?utf-8?B?alROU1dHSGltRTdWd2xGUGdudWRVS2NvQkh3QjRqUUlWODUrRjlZNzdRYkc0?=
 =?utf-8?B?TjFCTmNWbCtxVnhjRmdUMEJuZy95Vkp6N1pKcGJENExkQVJYZ0tSMWgvbVBV?=
 =?utf-8?B?S2tGeUJ5YTFJV1ExZEdiSEdHZXU2RjlJK2c3N3d3TnBWblBFNWVnb21ONFJY?=
 =?utf-8?B?NEdSTmQ1VUJVSXJGWGtQWFhuekFiN2wxbTdMbUN3Zzl6M2NESmFySnAxM1Zz?=
 =?utf-8?B?UG85OG1RS25LckdwVHN4SmtuREdaUTVDOVNWVGNJenFLdkliNHlrd1U0WVRN?=
 =?utf-8?B?YlpHcXFNaXNvV1hJU2NKMGQ2MThEVUU1MWs0ZEljM1BUTmEza3VkOEdTM1h4?=
 =?utf-8?B?MFJIUWxORkpnYy9udmZNam1JL0k3eGFCbkpqbjN0RDdSem5ud01nR3NFTHB6?=
 =?utf-8?B?QW1hSGE4aVY3T0F5S1pxdjVCZlh1QlN0dUVUczV4WEtwYnFyNG42VENKR0cr?=
 =?utf-8?B?bWFaQ1lLZlhDOTA4eGVScitNaHY1WFpTOGlOa2pvbk5DYktwQUY1Y0tyTnBa?=
 =?utf-8?B?TWc3MklVckZjeC9jeWE2bm1uRFFQWXVnTmI3VDZWaXJtYWVva0FVK1NHalpL?=
 =?utf-8?B?M24rRXV4R2oza1g5czJnZGw3d0tMM1FQQ0tUSzkrYU1zQXgyTU5YbFZsbE1G?=
 =?utf-8?B?MDd1UzJvQXBNSDVIcTF5MldtZXhSVHdPTHNUelRWcitmdkIrR09xSkp2R1lU?=
 =?utf-8?B?bkdDdkZpZjA2ZGh1TGt2Z3Q2R1lMSE9IeFMrVytyL0dqbHk5ZktEL0xkdEx1?=
 =?utf-8?B?T0oxVnV5d2s4SFYwZ2o1azI5azF4WHZHNkxMZlZOM29oVURKSWw0djd1cUdi?=
 =?utf-8?B?cFJuMEJiMkpTZVp4VUlCN2R6dTFSZmMrc0YzOS8raTBRWDJtYnZ2bEZSeTBu?=
 =?utf-8?B?dURyK040QmdkbmkrcXAvMFg3dStJTXBjT1ZQYVE1VHRVOHA4NVV0ZEptR2U2?=
 =?utf-8?Q?uBVDr1ei5WgfLF/FFrIN9FrmkHq1lMDVlznmPTw0mDDN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EFB6FBD1678734F98895F36D48BC2D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367c9e48-6a9e-4a02-4f27-08d9f5e92d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 09:53:28.7783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUUqv9Ls3yqHXj6lofkWrdzYmpxiHZRx8TAiHPKH6+gpZZdvwlb6+M+WyXQ6YWqUFiOjPnhPqDkEBo5WZqSJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_015332_989953_58472BA1 
X-CRM114-Status: GOOD (  17.80  )
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

T24gMi8yMi8yMiAxMjo1NSBBTSwgQWxla3NhbmRyIER5YWR5dXNoa2luIHdyb3RlOg0KPiBGcm9t
OiBBbGVrc2FuZHIgRHlhZHl1c2hraW4gPGFsZXh0YWxrZXJAeWFuZGV4LnJ1Pg0KPiANCj4gQWxs
b3cgdGhlIGVuZCB1c2VyIChpLmUuIHRoZSBhZG1pbmlzdHJhdG9yKSB0byBzZXQgbWF4aW11bSBu
dW1iZXIgb2YgQU5BDQo+IGdyb3VwcyAoYW5kIHRodXMgQU5BR1JQTUFYIGFuZCBOQU5BR1JQSUQg
aW1wbGljaXRseSkgdmlhIG1vZHVsZQ0KPiBsb2FkaW5nLXRpbWUgcGFyYW1ldGVyLCB3aXRob3V0
IGEgbmVlZCB0byBtb2RpZnkgYW5kIHJlYnVpbGQgc291cmNlDQo+IGNvZGUuDQo+IA0KPiBNb3N0
IG9mIGFsbCwgdGhpcyBjYW4gYmUgaGVscGZ1bCBmb3IgZmFuY3kgbmFtZXNwYWNlIGFzc2lnbm1l
bnQgc2NoZW1lcw0KPiAoc2luY2UgbWF4aW11bSBudW1iZXIgb2YgbmFtZXNwYWNlcyBhbGxvd2Vk
IGJ5IGRlZmF1bHQgaXMgMTAyNCB3aGljaCBpcw0KPiA4IHRpbWVzIG1vcmUgdGhhbiAxMjggZm9y
IEFOQSBncm91cHMpIG9yIG1vY2stdXAgY29uZmlndXJhdGlvbnMuDQo+IA0KPiBGb3IgYmFja3dh
cmRzIGNvbXBhdGliaWxpdHksIGRlZmF1bHQgdmFsdWVzIGFyZSBsZWZ0IGFzIGlzLg0KPiANCj4g
V2hpbGUgcGVybWl0dGVkIHZhbHVlcyBhcmUgY2hvb3NlbiBhcyBoaWdoIGFzIHBvc3NpYmxlIGZv
ciB0aGUgY3VycmVudA0KDQpzL2Nob29zZW4vY2hvc2VuL2cNCg0KPiBjb2RlIGFyY2hpdGVjdHVy
ZSwgaXQgaXMgd29ydGggbm90aW5nIHRoYXQgYWxsb2NhdGlvbiBvZg0KPiAnbnZtZXRfYW5hX2dy
b3VwX2VuYWJsZWQnIG1pZ2h0IHlpZWxkIGEgZmFpbHVyZSBkdXJpbmcgbG9hZGluZyBvbg0KPiBz
eXN0ZW1zIHdpdGggaGlnaCBwYXJhbWV0ZXIgdmFsdWUgYW5kIGxvdyBmcmVlIG1lbW9yeS4NCj4g
DQo+IEluIHJlZ2FyZCB0byBwZXJmb3JtYW5jZSwgaXQgbWlnaHQgYmUgYXJndWVkIHRoYXQgcmVw
bGFjaW5nIGNvbnN0YW50DQo+IG1hY3JvcyB2YWx1ZSB3aXRoIGEgcGFyYW1ldGVyIGNvdWxkIGFm
ZmVjdCBjb21waWxlLXRpbWUgb3B0aW1pemF0aW9ucyBvZg0KPiB0aGUgbG9vcHMgYnV0IHN1Y2gg
YW4gaXNzdWUgd291bGQgb25seSBhZmZlY3QNCj4gJ252bWV0X2V4ZWN1dGVfZ2V0X2xvZ19wYWdl
X2FuYScgYW5kICdudm1ldF9wb3J0c19tYWtlJyBmdW5jdGlvbnMgYXQgdGhlDQo+IG1vbWVudC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kciBEeWFkeXVzaGtpbiA8YWxleHRhbGtlckB5
YS5ydT4NCg0KUGxlYXNlIG5vIG1vZHVsZSBwYXJhbSBmb3IgdGhpcywgcmlnaHQgcGxhY2UgaXMg
Y29uZmlnZnMgc3Vic3lzIGF0dHIuDQoNCkFsc28sIGlmIHlvdSBhcmUgZG9pbmcgdGhpcyBwbGVh
c2UgbWFrZSBzdXJlIHRvIHdyaXRlIGEgYmxvY2sgdGVzdCBmb3INCnRoZXNlIHR3byBjb25maWdm
cyBwYXJhbXMsIHNpbmNlIGl0IGRlZmluaXRlbHkgYWRkcyBhIGNvZGUgdGhhdCB1c2VyDQppbnB1
dCBtaWdodCBtaXNzdXNlIHdpdGggaW52YWxpZCBudW1iZXJzLg0KDQotY2sNCg0K

