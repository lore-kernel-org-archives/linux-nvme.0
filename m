Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9143C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yIAQW3P9R/Ag/tmzI4Xn0BXsUUWg5P7cqOENfxHxqZ4=; b=NoJkwUQEbfmUIZXOVWv4AtqCbP
	VDPWgh3J1gSx1rJ52J399Th0l9teIspdhLfKnSZTGWFVKAZwWuGWnYxzOta6oZwRSprus0kX2iuni
	gDpri7kXCRWU3vdq/zBRDFy5uraZlgSPeWOYzgs/YHYPt+QJHKL/0JysnstiXf+P+Ti8xa/DT75Pf
	Ibbn992wff4m8MeEgn5YTWoI7BmxL0ONQLdxzIBIJ/GiYqEUHu5f0ejW7aEy1h4yGildtwz5Bmlui
	UiWOje+sYGUGUeH+dMhsdGPG2+yBZq/EXONy3c4tI34oEC0O6OLbnddVq9o+4ZDqPGSLXbtks8D2t
	BOkToz2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal2k-007B51-EJ; Tue, 20 Sep 2022 21:44:38 +0000
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal2f-007B2x-Jv
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvHXsATOsEb2tYUeeRaMik4aWQ2HAatJ0wLL7L+Gs/TM1lAs5PWddZAkCYd1C38u81HDVtO08p5jcNmFdHoyDh8BBWgBCbDpLro+sWQ2dfB24JHiPcCtLJv9hQb87yNqAZ0StezHKERY2/cCufI6ZIuGIQo84gQJ7NhN+md7Gn75QYUbzYdG4GyuWT2XHaKn8Fcir+D1eCWGoaRkJkcZIZm14krWwj5x/XDOkl8aBLhAYeewol5vHyPj3CASjfeoV7iXjZFVhFsvZIRFkkZVUvMafWDlRdJ4K2nfLwsIzawe739prlpfQ/XGggqRSDQIrLqSCSL8zgP82WAT0rmUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIAQW3P9R/Ag/tmzI4Xn0BXsUUWg5P7cqOENfxHxqZ4=;
 b=IDkPaGxia94YQ4gRrq3TbQ2qexx8eVmdtd62fDoDXgNcS1dCXm+H/s69GUwLYkhIeDY5rtoN3gFtukFG12gm/bkiepMm65aT3I4tbI6Zqfy/9YUn8did7WFYvlHUH3LdDWS5GpwDgswLXSWzX1YBTEqTzeZ+/cmECZ7L2XI/j0SZdB4Deqd9ek3Jt9dn0+fcgYeNev3wdPiHF4CckL+gBI1o0cBXJa7ooN7REXGDr/9taJ/WsUEq8/QhfZWngekLHWpyGPkijMUCDfjhFdESbd6RuA25xYEyQ+CoWNfABH4v4E82jPl5yYxMAVcK1hhOYwe1NaGnLHHAuKwZEm/nyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIAQW3P9R/Ag/tmzI4Xn0BXsUUWg5P7cqOENfxHxqZ4=;
 b=gk4s4UDG/4sV2KydcZGPynu13XjYT5yrMQncPMkv9TghrZYUI4yve7b27PmhC6LuloXn9VJPU/b3pYhJB7id4+T5/Va3CqlZyOzeBErNtXO7UdeVfHIH/hm7fsJcdYLv8qYL9NporBy43ntgMILslK7Qu5HT5UbySdXIZE+T5r5is9yuDSLoxI198JHv4vpM33SBuebkx8DvRliUL7Xi8mEvNC37EVh6NxKICEV9ly9pl2y1RUH0O+3zhmYpfVZyChzZ4rL76lFogwD1K+pZRVTZpcGZg6y28EYt6LDK3sYwDE6zpB8erehVtNa400CbBdA89D3OQ3FSVilUVDTy6A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 21:44:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:44:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 05/13] nvme-rdma: store the generic nvme_ctrl in
 set->driver_data
Thread-Topic: [PATCH 05/13] nvme-rdma: store the generic nvme_ctrl in
 set->driver_data
Thread-Index: AQHYzRThdNKYkEmT00G0XQGeBnaxna3o2iiA
Date: Tue, 20 Sep 2022 21:44:30 +0000
Message-ID: <5ca3609f-1456-d384-1895-0b3ff7965e37@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-6-hch@lst.de>
In-Reply-To: <20220920171611.1289361-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7129:EE_
x-ms-office365-filtering-correlation-id: 1b983db6-3a1e-4632-926b-08da9b514c66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Gcj0GkP05KMcz727sk/YEOLdPH/mXLzGltlFuRB02jrPqqJcL8n54d/eKPOn/+YFwW0Y/6WmIroVViR2jrBI3i9opYk4+HOyIpD7ZisD7g/KD6AEIHNdZWuqTiaE2l9e4WhSHpLldCYGnDqi6jDKZ7W4oTuWIpNFCIs7q1Kwektg4vxvqKmC4AsYOLCwfjHNvzQLTo8ej8vWx6gfEoj2fK23rrG74np5dMtbGn6gA14cqe1UYqEskmH+mzoucwmjNnrBbi1fREMp2iitjQLdAlQ/m0W0CMwaTj94KTpQ4Y5ONWWNFKN+aTyRhXk7l7okgvC1eGqsfFrv+No1dNewWwi4iAV/yXX9Y6b4sas8Qg8zyPrWXirg6bSkBwHkTaVjySWXg1EJHV9a7bGdLfZPeTcmnua/ahV68ipqdPXcYOY12Evq0nXeGyr0Ik9S2SMOORua0YXsnfYNbswQbrWN9LINSEdTyy6CQ4Omk1vaFIo9wkf7PEd1pmjqAZCVn5Jw6Fpk9Q6LyExKrnRJxC/8jAUINsCEj37Ho/mpBoJHgufI+R3xMtoMPSQIne+LhdTImTcpcT4S4ZKEVUoeHn3UPwpy0g6Mrz4/AIyE5xc9rXva3xwtedrKfGwxWEtB6lsGft/Tye33eIiNcwIReZ47a3nMTQTm+Ef6gtyu2PgxywkT2qB9jIyznWloMPmBqIMHhMx2bMMxlUTIHTivDcb6/iG2amCouZh/A2MU++I0yrNPFU8bv4olSpyvsJBctBUJH8vlzrikg/8SrkP2CvM3ZOsAFNSx8AMAYOFQLJulcUUbAyZOFVhLobfn8GroFMlj4+9IHarl46uaXihGyhVxWmzBCe8yztPcJUmHCKp+oWs=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(6512007)(6506007)(53546011)(38070700005)(316002)(54906003)(6916009)(478600001)(71200400001)(6486002)(122000001)(86362001)(2616005)(31696002)(186003)(558084003)(38100700002)(31686004)(5660300002)(8936002)(2906002)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(91956017)(36756003)(66946007)(41300700001)(76116006)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bXpxbXRRc2x2QmFHOS94ZG1VcUJtbnFVNGRqdmhJQURlZS92UXdLb1pQajh5?=
 =?utf-8?B?bGswT0E2N1QyaTJPcTVjS05Za0EvSldEQWMwL1hlWlNzWi9OdHhJQlh2a01Z?=
 =?utf-8?B?aHpxTWVIRncwR2FOanlzbkIweERSczhaRjkxOTRuMVk5ZnVzUlpCS0VzQ05n?=
 =?utf-8?B?RUNnanNYK3pHQ1ZiZW4vZnRLSGlxSys5L2dGazdvSnVNTm9zR2JQU1Q4eUk0?=
 =?utf-8?B?U3NiaFVGeGFZb3NLMmtMeDI4TWxRZFF1YUcvemRCNE55VVJONHlCVU14L1U3?=
 =?utf-8?B?c1VGQzlkQytOUmV4RXNUd1NrVDlJSkxPOWx5bkcvcmRaOUV6dWpxai9Wd3N2?=
 =?utf-8?B?SGZpMU1ZbTJMTTNNTXJKQ0daNHVzaFJlTlE5MnVuTFM2TVRLYWU3TTY1dytz?=
 =?utf-8?B?N2xpOVR1WVUwNUUwNTRXeDNrYkJ2Q0tkblp4M096dnRTTVhuWDJnbkQzMk1i?=
 =?utf-8?B?R3R0b0dKV3JBNjdjYnAvNmRHQkYzNVRkWUtLV3hKTUdkTVBhcy9PL2FEMXFO?=
 =?utf-8?B?SlJOd2V2ditDWUNXT055YmRVWFNhQWoyZEJleHc1UnZPZDlaQ0hEN0ZCK2dU?=
 =?utf-8?B?RjJ6YVp6TnFEYlg1ZnluSXRWL1pwUm9OcnVuUFhLTW9EUFNBRi9zdmNBZXJy?=
 =?utf-8?B?MElKREFnc3R4Slc4Y3Q5STFuZmNZQkpQM0FObEJCTTRCUk1NVWhuQUJ1a0t4?=
 =?utf-8?B?T2t3Q3VZSG1mN0xVSjlObXRGcGtXa1BndGo1bXZCQ0cyVkZqc0J5Q1dKRTlP?=
 =?utf-8?B?ZUFPdEoyaXhhYzkyRmVPK2d3d2pGdjc2SEFyaFlVR293TXh5Z1dXQ2wzQUZ0?=
 =?utf-8?B?U3h2TEdWRTdLdXMwbDJrMmp3Yk5Fcm9VWFFUdiszUmFQWUlPeGlLVFlxQ29Z?=
 =?utf-8?B?VVNKUGorOG4wc2lpcWtONHFRSDVoYUU0S3VRSUEzdnBZekwwd2tLanNtTUZi?=
 =?utf-8?B?aC9VSHo5dGxTY2VJSzFwZG04SGRHdHhFQ2tacmkrTmYvVytTTUNXam91ZlVu?=
 =?utf-8?B?d3FRR2NxbmJvOTM4L0ZLbGNFOExXb1hMV0JlSVJQTXV0T3BydGhEUDVaVysr?=
 =?utf-8?B?RVpGWmt4RkpaK0U3aVh5WktuWDRZRW1nYkZ4TW1NV2NiRjEzUUpwYjE0cEhD?=
 =?utf-8?B?UDRBdlNLQjc4YklBdXhrMS9SeW1VRFJISXhKdkZ3bi92NHdMNndJbmdJaWts?=
 =?utf-8?B?RzV3VXN6Q1NFNTcvc2thSEVqc1VkL1RPSkpTbmJPMFBxQzJWMkJDMmFIZXdE?=
 =?utf-8?B?OHVzd3hEcXp3NVZRVUZROGNYdGVwMGliTlk0aENraldqMzg1RUUyemJVeGcx?=
 =?utf-8?B?d3h6VktycGlpcUx5VjhLcW9OZXN5NjRiUHo3MzZ4QWtsb2llUlRhNWxORGt4?=
 =?utf-8?B?cjJIRm5ETFg4clBKNSsyRlhtMVgvd2NKRWl3UWNZSXVaR3hVK1dMUlFLSlpx?=
 =?utf-8?B?KzdzUWxiYXRwUk1US1A5SHUzb2xCZWhiUTREUzYwSmJEWWo5WU1NakRrQzJz?=
 =?utf-8?B?dHQzK3RaU2JDNkFjNjVUTnB3NU1NNjBiakhiYUh3bk9oTml6cERIYzhkSVo2?=
 =?utf-8?B?bkJPU2daRld6bHlmY3NoYWNoL25oblYyK2Fhc2FsUjlDSjlCR0JPWXpEcWNN?=
 =?utf-8?B?S1BUQlp2K2NaV2RVMkdDaDA5WnNGazdHWTB5ZmhpWEdXTFE2bEpDQjFXc3lI?=
 =?utf-8?B?NXRuYTVsTkcrTlVIYjNVekVwTlFoNy9QRmtYVENRQVpMSFlUTkZjZ2grTm1J?=
 =?utf-8?B?cUtDMzFkVzV6Mk96TkFIQ2IvaGdUdmFGWFh1dDhzY24zdkdiMDdxMEhtQUpv?=
 =?utf-8?B?QWdEMjAzMHI1QWU0T3pWb2hTT281OENiZXFKUXM1WWp5dEowTWhkR3FVWUFk?=
 =?utf-8?B?eTBjMC9Eb1RwNnRIYkwraTlUTXJHeEFzYTVSNFMrVUNSR3UwUXJmTG85QUJW?=
 =?utf-8?B?SEt6SEh2cVdLNUd2Z0dTUFpMcEtpOU5jVWNXMWU3dUhwemw3YVpBKzBMWGNG?=
 =?utf-8?B?emFaUS9RdTdUT2VGZUdMdlJRTGl3eUlHSitoZElJWVNsUmhkd3N3SmNjekJ2?=
 =?utf-8?B?L0FldTlQRkd6Q1MvV2J1eW9oeTU2ajBKZmdVSGhEd29vRFJjWnp4ck1CQUNU?=
 =?utf-8?B?WkRiMHFxV050VkFEb2FtT2VIeWlaamk4aDN0QmNXaEVJYWNNVjMyVkFXMkd4?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F06C82EBDB8A2246974BEC8F13FBC75C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b983db6-3a1e-4632-926b-08da9b514c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:44:30.2637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUPzhgcgm9u3dMXmIsQOx4dGxwLwU/VLq9I0gvD7cq0m+I/rTFVZWlBp/xtsBDIuRb51hzrPQws3Godu9/fnvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144433_687242_4544BD48 
X-CRM114-Status: GOOD (  10.30  )
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

T24gOS8yMC8yMiAxMDoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBvaW50IHRoZSBw
cml2YXRlIGRhdGEgdG8gdGhlIGdlbmVyaWMgY29udHJvbGxlciBzdHJ1Y3R1cmUgaW4gcHJlcGFy
YXRpb24NCj4gb2YgdXNpbmcgdGhlIGNvbW1vbiB0YWdzZXQgaW5pdC9leGl0IGNvZGUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCg==

