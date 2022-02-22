Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C60C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 09:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yL2poQ7q/NAPUB4qhYVJ4b9oam6URpk7ZwncbqXG+XE=; b=BvLfoG4d5L6dYYzpDOC8z1fgkn
	J4vBclEwUluTte5UkdKImhPoPwG3v1M6s2Tw8eBJ24x4yYNLbaB55XdZtCLQoyjydRPn+48moGaLU
	HybjIjfbbHwVl1wmie3amp2VgUEgd+096hzxvdjUnGRCfDB5vPR9WJ7N9yP+jpxF0IaaSO32CcNUE
	lvRt1e1UnQAq741e5VU0SXHRgTbUf+FA2zfWxglTqW/CvGJhPEU9pj3BoFSj/ZSrongAcaDpHDWzj
	xQrIE01uaqRn5L2ANMNueucxmPrM9IbZ/uZ6+iqGklHwwqW0jSe8arsPaMpk+LdACyxIJOfNZGaeJ
	v8/8TFCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMRoq-008pKS-0F; Tue, 22 Feb 2022 09:50:52 +0000
Received: from mail-dm6nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::629]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMRon-008pIj-Aj
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 09:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy+OXcKmyoZe1qFYz2lsxUxgSOfg273sdxpzg81AJJxDP712Sc5soqM2FUskHjLOSDWzs19oWBpYOyaFv1ViF6xLbncQeAL1qv6LUVODlGpdjMpjBTprrvEcNI2j03q1mdZq5ab285RKC4SmcFdPYkUvPQQ9q/QEyqwGg0fRNHh6ZvkhQG/QBWvuWdJoFHH3By9pFTPcixgd5a6o/ryNsIXAhWeFMsHIJywHZjiEDMWI6LOn0u+AVPGyrhUByHqmDg5hvEZ2BZAgR3UM9my4TXfFlBDUdoadF5kSakarjwvDcjX3YHB4MbR2+uFmdhHuJAVhwaKKzgaSEneq3K+PqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL2poQ7q/NAPUB4qhYVJ4b9oam6URpk7ZwncbqXG+XE=;
 b=MyVLh0M2DAryWPPKWmvGIKv0IPUF+9IGbhTqS8yIJMvgL9qGhoPv5svUhNRiv0CQc530FwA9sP0H35tprP/5+LnMGfCbXgpEyGi/16KtoxkybHxOp0YPNDag96PnvsrUEJYRf3OFNHwCW07G8F+YteBhI0fdA+1lBsGxaPxdEvhvywKbbHqEQ0mhjaIedZOyRrUnBXdGuM65yfz4OH5f+OS7HSvm/UkDBFz3f9UE5OH7zhr06UmR2QyuclznCqT7Rli4PYXDb9IlMmokvHiS5lQsFJ2AEf1SMiifPNpFILC5lBWKC3sOVi/222n5TQCCAjIHrqYxt4W2E7w0W0VcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL2poQ7q/NAPUB4qhYVJ4b9oam6URpk7ZwncbqXG+XE=;
 b=XORJDr7yE32O+HF+AHJZuclI5wjsIM4QQQno/IODR8FedWbcWBhDRj09JvahLRjZ14AJfVnkQqUeYHXgkdy4Cl5mvxpcU27htspy+O4aPImfhZY01dgRa6S0cvTn/8Yrb8MwL0nLZpmOp5alkeouoCurTtOnzaZ6gqecisXF6LbwAWLvPdVRZ5GkI/AzfENXZc8EcEF2ZOm76b/OuvmapNhm3ORJsZfUe7uSQ4AGr81hW+leBLKoIFUbyGC0iorLgohn02qUMiTWhYw5v+brJvqBcCHIwDyV+4M0U6Qq63/THzwMBJ+Zw0A5nriRydt3Kps03wjUfBIz6IkmJ1lbAQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0125.namprd12.prod.outlook.com (2603:10b6:301:55::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 09:50:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:50:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Aleksandr Dyadyushkin <alextalker@yandex.ru>, Aleksandr Dyadyushkin
 <alextalker@ya.ru>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet: parametrize maximum number of namespaces
Thread-Topic: [PATCH] nvmet: parametrize maximum number of namespaces
Thread-Index: AQHYJ8oNzqmc7ZE++ECk9dxk/jNAUayfUI0AgAADL4A=
Date: Tue, 22 Feb 2022 09:50:44 +0000
Message-ID: <2c0cae51-44a5-e156-cfb4-6e00c9d0c7b1@nvidia.com>
References: <20220222085415.292729-1-alextalker@ya.ru>
 <c400d418-8fb2-a603-d669-077b2d09f789@suse.de>
In-Reply-To: <c400d418-8fb2-a603-d669-077b2d09f789@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 887de4f0-9386-43f5-3070-08d9f5e8cb45
x-ms-traffictypediagnostic: MWHPR1201MB0125:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB012523B56BCA3F87A065187FA33B9@MWHPR1201MB0125.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vnJ0SWBAR3V8s0AwAQpdfQ/NNtf0LdS/fJeZh7Qypn7nkgEAIqLPSVT6ooK+FqPtKjTWDr12ZMyMqwKNFT4QvHZEtLq8pU7qdHOc42G5ckKF9Osas3uyT8PAn8M9Y4ne7w6fCk1wlWRxBwXmNRWF+4eIbZMhjr6jl8PZ6F9R210q5DYzy8aufnfd1rpyXalhqbJS6Ntcf3GEI0N6934UyQX8uJ/jvXShFM5OTYp+1f35zGVNx7PsEVMj1LWeyYF5F66ACp2Fxr+JOG+aaDLRuCN86vrIk8Soz18sh9xtyZ0egss+UJ3irvVfu9DpKVpyCFM+Sv+57lclreJICy04GVYoLTcMi9aY0YH9++hMbh6BGtv0Cpm59VgUcz07+yerzhAhrHLrLti63OcuVO/Web21mV86TLeRLVATEtYiWJhAqhShCtlx5zWnetBt/ix/keQKchcU1fzEOuF0+tbhG9kwEKwW+1qDomT0+HpHwnA1DVL3lYy4hk+f7OAlBbgfeLZGKwjCrL4dwg9j56uVvpAArBFbh4hJEHd4Br+UoPfXi3MdzLqOnnjTbRflK917Am9cbk9YDEQY1IV9hzc5EuZ7wQ8+nucUjcUbzg4KA0NHDc2oJL89duxKD2NZci9JifvXidoBc93rANfSce/SBn2+E0oCBm51EscWYlPM8NVPShQKJKt+yBiABYbrJQAevMmnDVuQlGGeft6lehUpz9yJNoVCC4Jzb2MhqVWMMQVI9NEDhCZc00QliRSgrOgIj34oy1ZcRM6STbd4uLZtqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(91956017)(66946007)(66556008)(6512007)(76116006)(6506007)(2616005)(6486002)(31696002)(508600001)(54906003)(110136005)(316002)(66476007)(71200400001)(86362001)(66446008)(64756008)(122000001)(8676002)(38070700005)(4326008)(38100700002)(5660300002)(8936002)(31686004)(2906002)(36756003)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U04wRmF2UkttVWJXTUgyRFlId1FkL1hDUmJGYm8yaXYrdWtvM3pST1VLbkYy?=
 =?utf-8?B?YzgwN2Noa0NVWC96Smc2TUMxUzJvUFdaTFdURWxUUFljTm5FUy9MNW9JTXZr?=
 =?utf-8?B?ek0vVllGQW50S1JMN3l5cERSaDlYTUlnckk1NW9QMGZHTlRXdVpsaUFyRXZD?=
 =?utf-8?B?Ykkxdjh5MzYwNWoxNzRmclNUR1haRjFtNUQyaEJ1dnN4NGUwTTZKMFBrVHhv?=
 =?utf-8?B?RHA4MUpZWGU5YzFKWWJEaE9Od01SVGdFUkVIQXdZc0JNaENqVForSE5pOUNV?=
 =?utf-8?B?am5UdWp0R3BEWkN3RWRXK1FGTkpqVDdKQStBeE5WUFV2bXlmTFB4ZTVqeWdD?=
 =?utf-8?B?b2RiZlFnRUs2TndBcXdVOVNOVVYveDZJbXl5c09XQ09MU082ZzVOZFdpRVF4?=
 =?utf-8?B?NW1JTUZjOHBleFgzL0x4RVpNVUhzVC9HVEE3Ujd2dnIybUZ4eFR4R1RodUxC?=
 =?utf-8?B?SjIzYnQ5NVdKcnJhRkp6d3hlUy9kbmZKZXhvSitJbnE3cmc2akM1Mlh1WURG?=
 =?utf-8?B?bUdrWHFKQjJ2b3FuSGJIVzhZbjlHZEhnc2wvQWlEeWdRcXQ4RmJzOURtaXVI?=
 =?utf-8?B?RUJPZW9EazFBNC8zWE81R3pzL215TXE1YmxYT1FDNVdZNGpWQ0s4WS9wb2pk?=
 =?utf-8?B?Y21yR2JBVTZkZVlYeExzRDdBYjMrOHBaYmlXOUlJT2NzK0xQVXRsTmE3eVlC?=
 =?utf-8?B?SFVlSXhQb1ZKRnZNMmU4SUVFNVBERjV4QmxXWEFZcnh3eFF2ZHdqcFBlZkhD?=
 =?utf-8?B?V2VBMXk2bXdMZ3lNUm1kdHNmVE9RUVRDRXZlQVFjUWhNMGlKTHhyVG1YMDhB?=
 =?utf-8?B?aWFGR2dVSWtOY3d6UEdyUnlWME5UVHZjUC9IVElEbmtKMjgrY2paajVNQlBS?=
 =?utf-8?B?ejJXNGkwT3JqQ080b0VIZ1d4bUdNbUVmUlhjZVVQUUhmQmg1ZEpNTmZMN2h6?=
 =?utf-8?B?N0pxUHdPc0VpaUZpMEV2UVZBZklJN09ubkFTcUFkRW9Zb1JxamxwM1VadFBp?=
 =?utf-8?B?L0NvRkZKT3BEMDVUdnpDTis1TndFY3RMbVllRVRPaldVSVh0cytLeE9PQ2FG?=
 =?utf-8?B?VUxuMFNFRVZiUmVCQjlhdVkvZHBrR1R6dEI5d2tHcFFtTE5obXR0ZWFETXNz?=
 =?utf-8?B?MUw0UStURkJUOE1EZStjWXVEcGdCb3pSSzJWKzgxMnNtTEI5a0NZRFFXQ3hZ?=
 =?utf-8?B?VUljckFqaTBuYnFWczhPZkZWRmxtVllXSHVsQUN4Z2xWV1o0cGlQQkdsdCtE?=
 =?utf-8?B?Z1NmajQzUWl2TGVnUjNpbzRMSU0weVpFUzZXVkwvU3dsejAwbjUzdTU4Q3o5?=
 =?utf-8?B?WVBwcndrRzBRb1lKcXBycHYxK09MNkNCZG43SmlJU08wUFNrbkhIMzVUd0hv?=
 =?utf-8?B?UEV5VWNVcFRlK0JyZkFXMmtTd2FYVDJCbDF4UTQ0ZWlua3U2OWRCYVVvYit4?=
 =?utf-8?B?bGY3MElKeFVPNG52Z096bkIyWStoWVl2NitxaFBPZUVjcDRhaVFXK0VNWjhp?=
 =?utf-8?B?eThITlRSMFRXV0N1aDJIczRhYk81SWVuaXZCS3FkSGV4UFZ2UkNaWVovZlhH?=
 =?utf-8?B?TFRNMWpLMSs5YVhFaUFjVVBmUW0yMWhWQ2R4UTNseDZuSzFFUVdxRGhFRHhK?=
 =?utf-8?B?aWttdnV6d00xaC85TEpvUWl4Si96NE9lYnVTN0xnOUJkY29Pd0J5TU9Ncmhj?=
 =?utf-8?B?cmZudk9ZR29INTY2NnMrVlRlTnpBeGVqRURvZ3dNNk51bnJGU24zZVd6bkR0?=
 =?utf-8?B?WFllNm9qeVNBT05IVkhqeVlpQ0FXOU8wdStJbExjTm56S2F2SkcySlFIQzJG?=
 =?utf-8?B?R2Mrb1VBaC80Wm9abUVZZGlJdmlQcENvSGlDNksrOGFiZGtRY2lJUjljZmRr?=
 =?utf-8?B?VDVoM2FkRmt4SzFhV2N6UitZbWdlNDhtNjk0aThUbGJ3Z3F5NUJ1dis0ODhK?=
 =?utf-8?B?b05WQlZpZTFmKzdUTGJuWVBNcm1XbDBDNEpzNVUrWjNGUmNENzZJRyt3OXh2?=
 =?utf-8?B?NytWZ3JtZDdoQ2xQdURNaTNORytoazl2QlJtUlFBcFEycHhPdzFjbEFEWlFM?=
 =?utf-8?B?cVduaTFBKyt4MnFXWVRjZVhxNTkvQ0JBRU1XQmFSanZhb0p6clRxSmdNaFRy?=
 =?utf-8?B?eXJTZ3lua1VrQ3p5UXpma240RlVuRE0xOHdDeGVreURURmxpSFlzUWdaYjNZ?=
 =?utf-8?Q?odf2ZTdglAEuen8CZS2cNUtCdhsSv7niRR8/ByJp4uL0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D70AB0E1675DE14F9A82449F49653DEB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887de4f0-9386-43f5-3070-08d9f5e8cb45
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 09:50:44.0381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgiSxeCJZp+rZAKI3i9ozJ7HjSdsWCTsxJgZLNOfF4MoXKiO7oNsWs/tFcH6P+Zc58lI+QEwRZ0lfoFaZO11xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_015049_602216_EF24820F 
X-CRM114-Status: GOOD (  10.58  )
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

DQo+PiDCoCAjZGVmaW5lIE5WTUVUX01BWF9OQU1FU1BBQ0VTwqDCoMKgIDEwMjQNCj4+ICtleHRl
cm4gdTMyIG52bWV0X21heF9uYW1lc3BhY2VzOw0KPj4gKw0KPj4gwqAgLyoNCj4+IMKgwqAgKiAw
IGlzIG5vdCBhIHZhbGlkIEFOQSBncm91cCBJRCwgc28gd2Ugc3RhcnQgbnVtYmVyaW5nIGF0IDEu
DQo+PiDCoMKgICoNCj4gDQo+IFBsZWFzZSBtYWtlIHRoaXMgYSBzdWJzeXN0ZW0gYXR0cmlidXRl
Lg0KPiBUaGF0J3MgcHJlY2lzZWx5IHdoeSB3ZSBoYXZlIGNvbmZpZ2ZzIDotKQ0KPiANCg0KUGxl
YXNlIG5vIG1vZHVsZSBwYXJhbSBmb3IgdGhpcywgcmlnaHQgcGxhY2UgaXMgY29uZmlnZnMgc3Vi
c3lzIGF0dHIuDQoNCi1jaw0KDQo=

