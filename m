Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C393DC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 05:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OTCR1/n3A/Rycbr84jhM19fmyz10kv8cBK76XL15VIw=; b=zlRmUBcD/UUnsOd0GXNKqoMJIO
	nRoqc6snX3hJ0Hhypzgk8FkPOm/D7zAbHbjpuCSV1fh1S4TYCYGtvkDariESMyPTT/EXbdlZT3ULz
	apJ/Ooyz9BfJ7iO/K3Asq9yUlwNrqXv23SDKZs07WbR7eoYFyOk+pWiUPL8Qpz2SwyEOK20vW362t
	ZoDJAjPGxKBu9iIwKgqZBQfj9seN+6kEdGNYhL5dqsF6micvt/MBg5F4m0zF0c4Xz04UE45OO4sCO
	dgIQiDb2/Hm71h6SJqXXl/WXmX2NuLw7GDdfUZvm2azN5IysFyKQVaG5wyZn4u3mYZ1naeoKk3pxN
	7ltBEpVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peqyB-00EhIG-1u;
	Wed, 22 Mar 2023 05:25:07 +0000
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com ([2a01:111:f400:7e88::62e] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peqy8-00EhGW-1d
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 05:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwBbuzYTkoq1SDhSXa6ancbtkYlhzWXbcHp71XiP7z9pPqwr0mjkieOvGWGfbfl5Ynu8qse2YV4QILVsKunJMMjfUFWDexdkW6FvVR43pL6hFZvXlGWFZXGqfN/FbBE29sPzSJwcfk61XAomapIE1EethTTomFx3XgdU3kMsx9DK9iYCSwKQ7CIiQe35pmJhW8L/v3NlY/4CgRK2NPd+pLHFdVuetu5+YGeqRqGYRHdCcHtbilGzCFlYlTBU8EptizJ9uBhlMuu9Int3Wvmwsrql0/iK/b0xcX6L9OwA4bjISnw+peJiMgf3b8uKry0mkRoyb88c6UU9Dxt5teYidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTCR1/n3A/Rycbr84jhM19fmyz10kv8cBK76XL15VIw=;
 b=PATOlcmKA44kTsEradDkBPl/ujq0PNANbjNzPVvfvVFSuTvQia+zYevBh54zRzcKoV7/GcBAIrKp6a8iQ3Rj6Ew5K6m2EIxBZOqcTPMW90qW2+02FoBnMTutBDvv5HwNLJjyVnQl+6PoAI++uFRbLxD9RACNRxj4OLqjl0Bp2YovWQavyASPMZJjU58xOpi5rzFepH4BEagZGjiwlCALHU/NgKYtaA0OdZshmJ8/HhN4rmsbfy67jPT+bRE+eS+A4zrURoTeQ4caVNU5vQA6f2f0VjXugZafG5K7ue7+Rct9k29Uk0SsN8dqfjULSX05LwuGJuUhqzHicOugoKLfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTCR1/n3A/Rycbr84jhM19fmyz10kv8cBK76XL15VIw=;
 b=L6hISnj1VWzRyh1xL6kitFLC+2+y9VkKgucpNrBWNxgnz5FhaVMapxeFEwGyTsyavJmUXp5nr9Sw+rRUDi3UVnOtiKB/y3iLbYVCxZV/lX0u0NkCKjbYIX6UfBGPMQfwMziF9ZY/BA6R7UjjhOqn4D6nMtximCXawxHi2r1NR+ZzTSjGCltVlVDP1A8/+SxA15Zn4aw9QnptLSNUqJmkh96n4cqfANqWzxSJ+BQezzbtSaF8mULjl/jPa2V19ROGJCNbwUpCwHcv5uasmdG5SiTWMgE+7jDtUr3z6BXvbBf1Sok6XmvIyIQmpqfl17MrE1N9ywm1CWF16alUnPbxLA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:25:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:25:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yanjun Zhang <zhangyanjun@cestc.cn>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4] nvme-tcp: fix a possible UAF when failing to allocate
 an io queue
Thread-Topic: [PATCH v4] nvme-tcp: fix a possible UAF when failing to allocate
 an io queue
Thread-Index: AQHZW9BX10oQRSeZaU2EutYA7rR+g68GRauA
Date: Wed, 22 Mar 2023 05:25:01 +0000
Message-ID: <100f4ed7-e61d-4297-419c-0b7a4ac4f4e0@nvidia.com>
References: <20230321083636.95424-1-sagi@grimberg.me>
In-Reply-To: <20230321083636.95424-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5899:EE_
x-ms-office365-filtering-correlation-id: ba5d9edb-9578-4d12-3cb8-08db2a95c8f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  pwzYkT+Ocf/JCG3AuxA50GCEYcQvJb/YTums2TNlzg8n51JlFiRkVfOa4DwaE+C8vH1/C3Jm1R1dbI0QEsfdrrsNHQnyojeACQvgOJNr8rpJaovZFXBS7AHDfqpCsZ1j+oobgFXmHtd+Z8Plfz/lna0aDqef0RKr/scZQ0sGQILC9MUrDClTZIlcI4a3stLAEwpLzUl2r+n3Gp0RFLnHb+5mo0919+1/V8G2YLRC2w2OWiDNYZY+OJUr68/hYdzBsQ80eFviShxN+Rmp6JQPB+z8JMFVGEmFjXfWuv4GUeOzjqDlybA2CMa3YbzsR3ndxSIn8yUFbQ0dljFVDUE8vlHvxz29uHAmDf+Z4LrpYPlDu+owSMeaNK5s5fmlCtEVHLYBvxtWoQM3veubS/o4snPkT1gptMqIO3DEWdpIS9vkpKhQHkfPs9qwBiRmAlvMW0pep1hr8G2sZ5hEXuvLC1om6dZaD78TeyA6XxdIbWDVaCJPv3ZU7GyR4hVI/r1K8yQPaIxysakbM4GljSMPTc8y7U4/Q43BKjQL+gl3u4OM3Mk1HGypvzGHmr2aLCuEgl9Ry6G1hAhS0eiBO5nL+HKCZftvUGFJNptBlfAZwr/8vJtGZSiAhNlHOfsm/NVpAVT09X6IU3dw/AhsBJdESMOsXexiDlnStLWlkFe4+lnSnhecR6k16piW0JF5g2uvRTdLmeyN9D2SuEWrgvHVwB2MASK3SEaPbWktDBHf8v01HBKdG9HZY523vGoyxKguSDA6+eVDWO9S8NOlDxGjAQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199018)(38100700002)(66946007)(91956017)(122000001)(31686004)(66476007)(64756008)(6916009)(4326008)(316002)(66556008)(8676002)(66446008)(41300700001)(76116006)(54906003)(478600001)(6486002)(31696002)(5660300002)(8936002)(38070700005)(86362001)(2906002)(83380400001)(186003)(53546011)(71200400001)(6506007)(36756003)(6512007)(2616005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YUtRU0h2aThCOFpIQXQ2RmlEdDNUMFBuODVrTzQ0V0Z3cWZDTHg4anZWYjdW?=
 =?utf-8?B?bW1rWUJCNkJpU2NrM0NGcUViU2ZDZzNJNnNlazVucERqbHh3MlltSXhBR0RE?=
 =?utf-8?B?b1Q1UlFQekVDOUlFYW15ZzFLU2RWMW5JeDZSS3JZNjhEbEozN25wV1FYL1VD?=
 =?utf-8?B?UUlTMHZKek92OHByYVlpRTNHZk9UdnYxckFHclhnWmVhWlpadmQ5Njc2QlJ5?=
 =?utf-8?B?dHc4cHFKS3VqSmFhTmJIOWU1cHFIMW9qTFFCSVlVUUhMU0xpeVVKRU9wNlFJ?=
 =?utf-8?B?MDV4VVZEQU9xTDdoajRQWDBTOHhQdDBnMWtka0ZEc0Y0QVlyNDNvMGtJeUVs?=
 =?utf-8?B?YTZXZVJKcVcyQWVla0xpK3BlYzMwbHQxQUhKTEVScDUycHIvZWY1R0lZd0Rl?=
 =?utf-8?B?MmgxZGd2RnJQNnlMTW1lTkhjSlc5MFdoS2dzbTNydWZNYmR5anlaWTV2R21E?=
 =?utf-8?B?eXlDLzlCcFowUGx2MzFnREQyN01DWXpadURTOFFLS2lyejYrMVdSSXpSR2d4?=
 =?utf-8?B?Q2JoSzlaRTgyWExhZjc1eVluU1FITUcvTnVBT2cyZzRMMFR6eUVpcTh1RVFK?=
 =?utf-8?B?WnFZc2FxNkdyL1BYYTBMbmcrdCt3K2VtNXJ4c0lFbTJrUGpiZjJITTloRDZy?=
 =?utf-8?B?YUtvczhsK3ZIekxVSnJJRHliWnE0RWFHc3BKYWtZeXJrb2pwbitYQ1Z6Z3RH?=
 =?utf-8?B?OGRLQi9FNU5JV0x6YXA1UStvMjIxbWVDUElRbnlhMHpPNmRjWDRUMkF5cEZv?=
 =?utf-8?B?QmM5SkxSVlM4WjJzTk1IY0NWU2I5KzEzdUlwWHVwVDJnanpMeUpaOUxURnNN?=
 =?utf-8?B?eThlZHRrbERvVGlobjRlQ2toYlpZSEg0bWFvZ0F5WFViVlV4bkpCc3I0UWUx?=
 =?utf-8?B?QVUzN3U0TVdWZ2FSWFZVa0pLaHpMZGcxdGhMNE5EV0dJazhsNDQyOFdFd3BG?=
 =?utf-8?B?OFdzZ0RJVjRqRGJieDF1TUJxZ3o3NzQxc1Q2UGxwc05ETkMwRExTVmM1dmYx?=
 =?utf-8?B?dFVQUTZrcCtrU2MvUDZZQlBBMFJTMUtvblRCUlppOGxhbXYzQlFLWFFxc1VS?=
 =?utf-8?B?ZFY0OS9Xcys2ODh2YnNLZ1hpSmFWNUxRYVovYUN4N3FJNzdQNFlmbTVHdmxp?=
 =?utf-8?B?RnpCdVVEZWN6WHNndEUrRnZGMUxTZ29DemM4MGRNQ3p6dGwxVmdhYVIvWTUv?=
 =?utf-8?B?U1cyNk1YMFlXUk9jcWE3cUtrWlZFbEhOVXRCSEVwUG9kTXNudzdYT3o5V1I4?=
 =?utf-8?B?aEQvLzNtbUJmb1k5Z29jQnVZQXVEUk8zeU5WWVUwVDZaRW5NbHFQUXhHMHZW?=
 =?utf-8?B?cGNVT1FyR09SdDBLSEgzQzJJSXUxTjl1TXVyN0VGcnVYb3JYdzc4WDJWMWZm?=
 =?utf-8?B?UURBOEQwaXh1NXV1c0phbStQYzY2VjQ2Q0tNdHlkdHd4R21xc1BKRzNPazdh?=
 =?utf-8?B?UVFSQnJjbWdEOFBWNFBsb2VLTThabnEvUWJMNnVjQU14UXE5MXJKbC85aSsw?=
 =?utf-8?B?VnFSRy82SlM1ZHNXMVl0M0ZuWVJTVm9vcEZ1MG16bHJwTTh0Slhyd2p5T3FS?=
 =?utf-8?B?U2N4aTZucFlPNUt2TExSU0x4N25lK1JEbWg1NkFqTkZYLzA0N0ZjNlFzZ2Fh?=
 =?utf-8?B?amEyTDY3ZUx4UUdQNkg3ZXVQamsxU0d0MnBtanp2RnJHWTd3UlpJd3hwaGJY?=
 =?utf-8?B?c3JkM2N3eEo3Vk1MSGZZeVhRenp5MnFSRjBvdUNwcTR1cm0vSFVYRytLRzlX?=
 =?utf-8?B?SkF3cnhEZmRXdzVFdCtzeDZQMG1zY3NTU3IrVlh2S2RwZDVaV2lEd2ZIbjZQ?=
 =?utf-8?B?VTh4L2NwWU5lWjUzdzF0Z2VnNFhGQk8zSytpRndSazhxQ0F3SzBjeWszUTM0?=
 =?utf-8?B?WTJia216eXpqekhwWmNWN2ZXdjI0UncyMlUwZnR4aXZ5T2JMc2VKMFJpUUdF?=
 =?utf-8?B?UUdORTdmWW9nZjdMWlVLT2xWRVpaRVhlaHNtRTBYeXdpTXV6YVJCWlNpMzRJ?=
 =?utf-8?B?VGNpcWVrZFdzdVljQkt1ZnpuOXZReDI4NEZaU1ovZGtVTXpWVnh2U3c0RmF2?=
 =?utf-8?B?a0wrUlQ4cGlDWHFJYStuVnI1K0NiMFJlWGFWczRkWThwRHVBMUVZVE5mTUtl?=
 =?utf-8?Q?ShYnPslq3dXvo5WEAm48KWi0B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <510F91AC532B364D825A85951B60A1D2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5d9edb-9578-4d12-3cb8-08db2a95c8f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 05:25:01.2909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ap4Qamv5upfMWI/OyVz17oQNJnL0Urnh8KwwtEs793Zv8KI6MeIIXxm8l7VUcDcdcXclaAh1dZIVm6LFPRTM2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_222504_552716_45E7227E 
X-CRM114-Status: GOOD (  20.94  )
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

WWFuanVuLA0KDQpPbiAzLzIxLzIzIDAxOjM2LCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBXaGVu
IHdlIGFsbG9jYXRlIGEgbnZtZS10Y3AgcXVldWUsIHdlIHNldCB0aGUgZGF0YV9yZWFkeSBjYWxs
YmFjayBiZWZvcmUNCj4gd2UgYWN0dWFsbHkgbmVlZCB0byB1c2UgaXQuIFRoaXMgY3JlYXRlcyB0
aGUgcG90ZW50aWFsIHRoYXQgaWYgYSBzdHJheQ0KPiBjb250cm9sbGVyIHNlbmRzIHVzIGRhdGEg
b24gdGhlIHNvY2tldCBiZWZvcmUgd2UgY29ubmVjdCwgd2UgY2FuIHRyaWdnZXINCj4gdGhlIGlv
X3dvcmsgYW5kIHN0YXJ0IGNvbnN1bWluZyB0aGUgc29ja2V0Lg0KPg0KPiBJbiB0aGlzIGNhc2Ug
cmVwb3J0ZWQ6IHdlIGZhaWxlZCB0byBhbGxvY2F0ZSBvbmUgb2YgdGhlIGlvIHF1ZXVlcywgYW5k
DQo+IGFzIHdlIHN0YXJ0IHJlbGVhc2luZyB0aGUgcXVldWVzIHRoYXQgd2UgYWxyZWFkeSBhbGxv
Y2F0ZWQsIHdlIGdldA0KPiBhIFVBRiBbMV0gZnJvbSB0aGUgaW9fd29yayB3aGljaCBpcyBydW5u
aW5nIGJlZm9yZSBpdCBzaG91bGQgcmVhbGx5Lg0KPg0KPiBGaXggdGhpcyBieSBzZXR0aW5nIHRo
ZSBzb2NrZXQgb3BzIGNhbGxiYWNrcyBvbmx5IGJlZm9yZSB3ZSBzdGFydCB0aGUNCj4gcXVldWUs
IHNvIHRoYXQgd2UgY2FuJ3QgYWNjaWRlbnRhbGx5IHNjaGVkdWxlIHRoZSBpb193b3JrIGluIHRo
ZQ0KPiBpbml0aWFsaXphdGlvbiBwaGFzZSBiZWZvcmUgdGhlIHF1ZXVlIHN0YXJ0ZWQuIFdoaWxl
IHdlIGFyZSBhdCBpdCwNCj4gcmVuYW1lIG52bWVfdGNwX3Jlc3RvcmVfc29ja19jYWxscyB0byBw
YWlyIHdpdGggbnZtZV90Y3Bfc2V0dXBfc29ja19vcHMuDQo+DQo+IE9uZSBtb3JlIHRyaXZpYWwg
Y2hhbmdlIGlzIHRoZSBDT05GSUdfTkVUX1JYX0JVU1lfUE9MTCBjaGVjay4NCj4NCj4gWzFdOg0K
PiBbMTY4MDIuMTA3Mjg0XSBudm1lIG52bWU0OiBzdGFydGluZyBlcnJvciByZWNvdmVyeQ0KPiBb
MTY4MDIuMTA5MTY2XSBudm1lIG52bWU0OiBSZWNvbm5lY3RpbmcgaW4gMTAgc2Vjb25kcy4uLg0K
PiBbMTY4MTIuMTczNTM1XSBudm1lIG52bWU0OiBmYWlsZWQgdG8gY29ubmVjdCBzb2NrZXQ6IC0x
MTENCj4gWzE2ODEyLjE3Mzc0NV0gbnZtZSBudm1lNDogRmFpbGVkIHJlY29ubmVjdCBhdHRlbXB0
IDENCj4gWzE2ODEyLjE3Mzc0N10gbnZtZSBudm1lNDogUmVjb25uZWN0aW5nIGluIDEwIHNlY29u
ZHMuLi4NCj4gWzE2ODIyLjQxMzU1NV0gbnZtZSBudm1lNDogZmFpbGVkIHRvIGNvbm5lY3Qgc29j
a2V0OiAtMTExDQo+IFsxNjgyMi40MTM3NjJdIG52bWUgbnZtZTQ6IEZhaWxlZCByZWNvbm5lY3Qg
YXR0ZW1wdCAyDQo+IFsxNjgyMi40MTM3NjVdIG52bWUgbnZtZTQ6IFJlY29ubmVjdGluZyBpbiAx
MCBzZWNvbmRzLi4uDQo+IFsxNjgzMi42NjEyNzRdIG52bWUgbnZtZTQ6IGNyZWF0aW5nIDMyIEkv
TyBxdWV1ZXMuDQo+IFsxNjgzMy45MTk4ODddIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDA4OA0KPiBbMTY4MzMuOTIwMDY4XSBudm1l
IG52bWU0OiBGYWlsZWQgcmVjb25uZWN0IGF0dGVtcHQgMw0KPiBbMTY4MzMuOTIwMDk0XSAjUEY6
IHN1cGVydmlzb3Igd3JpdGUgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+IFsxNjgzMy45MjAyNjFd
IG52bWUgbnZtZTQ6IFJlY29ubmVjdGluZyBpbiAxMCBzZWNvbmRzLi4uDQo+IFsxNjgzMy45MjAz
NjhdICNQRjogZXJyb3JfY29kZSgweDAwMDIpIC0gbm90LXByZXNlbnQgcGFnZQ0KPiBbMTY4MzMu
OTIxMDg2XSBXb3JrcXVldWU6IG52bWVfdGNwX3dxIG52bWVfdGNwX2lvX3dvcmsgW252bWVfdGNw
XQ0KPiBbMTY4MzMuOTIxMTkxXSBSSVA6IDAwMTA6X3Jhd19zcGluX2xvY2tfYmgrMHgxNy8weDMw
DQo+IC4uLg0KPiBbMTY4MzMuOTIzMTM4XSBDYWxsIFRyYWNlOg0KPiBbMTY4MzMuOTIzMjcxXSAg
PFRBU0s+DQo+IFsxNjgzMy45MjM0MDJdICBsb2NrX3NvY2tfbmVzdGVkKzB4MWUvMHg1MA0KPiBb
MTY4MzMuOTIzNTQ1XSAgbnZtZV90Y3BfdHJ5X3JlY3YrMHg0MC8weGEwIFtudm1lX3RjcF0NCj4g
WzE2ODMzLjkyMzY4NV0gIG52bWVfdGNwX2lvX3dvcmsrMHg2OC8weGEwIFtudm1lX3RjcF0NCj4g
WzE2ODMzLjkyMzgyNF0gIHByb2Nlc3Nfb25lX3dvcmsrMHgxZTgvMHgzOTANCj4gWzE2ODMzLjky
Mzk2OV0gIHdvcmtlcl90aHJlYWQrMHg1My8weDNkMA0KPiBbMTY4MzMuOTI0MTA0XSAgPyBwcm9j
ZXNzX29uZV93b3JrKzB4MzkwLzB4MzkwDQo+IFsxNjgzMy45MjQyNDBdICBrdGhyZWFkKzB4MTI0
LzB4MTUwDQo+IFsxNjgzMy45MjQzNzZdICA/IHNldF9rdGhyZWFkX3N0cnVjdCsweDUwLzB4NTAN
Cj4gWzE2ODMzLjkyNDUxOF0gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwDQo+IFsxNjgzMy45MjQ2
NTVdICA8L1RBU0s+DQo+DQo+IFJlcG9ydGVkLWJ5OiBZYW5qdW4gWmhhbmcgPHpoYW5neWFuanVu
QGNlc3RjLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJn
Lm1lPg0KPiAtLS0NCj4gQ2hhbmdlcyBmcm9tIHYzOg0KPiAtIGNoYW5nZSBDT05GSUdfTkVUX1JY
X0JVU1lfUE9MTCBjaGVjayAoQ2hhaXRhbnlhKQ0KPg0KPiBDaGFuZ2VzIGZyb20gdjI6DQo+IC0g
TW92ZSBzb2NrIG9wcyBhc3NpZ25tZW50IHRvIGl0cyBvd24gZnVuY3Rpb24gKEhhbm5lcykNCj4N
Cj4gQ2hhbmdlcyBmcm9tIHYxOg0KPiAtIEZpeCBzaWxseSBjb21wbGlhdGlvbiBlcnJvcg0KPg0K
PiBZYW5qdW4sIEknbGwgYmUgd2FpdGluZyBmb3IgeW91ciBUZXN0ZWQtYnkgdGFnLiBXZSBuZWVk
IGl0DQo+IGluIG9yZGVyIHRvIGFwcGx5IHRoaXMgZml4Lg0KPiAgIA0KDQpQbGVhc2UgcHJvdmlk
ZSBhIHRlc3RlZC1ieSB0YWcgd2hlbiB5b3UgaGF2ZSBzb21ldGltZQ0Kc28gd2UgY2FuIG1vdmUg
Zm9yd2FyZCB3aXRoIHRoaXMgcGF0Y2ggdG8gbWVyZ2UuDQoNCi1jaw0KDQoNCg==

