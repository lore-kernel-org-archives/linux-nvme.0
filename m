Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E74C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Az53GOEMZ9bzWtbQpUcT5bkhQXOVwoKSdi+tQKd8p9U=; b=JIYVMszCvljF+vkCn5E1CUkBOq
	DhOZWDQBrhd6NUzeYpY0y7YTP+Q3R9h8tyEnvFybwYHe95I+0nPaGbkpKFNfavnNGWIkz+429DN0u
	fGyn4XbxOM2TkyM7RRbMd8y83+6lCc5u10gmFIcaGHeKWZ5XNlpQXIw+bnLITClT6F69U9Pzys9yZ
	Y2aFrX3g8OG/Wlmhc4EVzi8Op+/D0ojHOQ0sdwa0sCLaJinZ0cCxPM7DTpxm6DMnGL612lBp4aIJx
	PPgDH8U0P7fvgtTB0fZf82vKDAePMtW9tAdWWGicc8qIWzUo4DSDhjlV+uEQwHvKKN5pZ7VmxNlG2
	b21prj+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounPQ-007ZSJ-Ir; Tue, 15 Nov 2022 04:18:52 +0000
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounPN-007ZR5-MU
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a76K8iuW2O5f8RhzHW8qt0pQ5A+4+4D/312FMeyLc/OPv6MVjI5jL62wtfZ7wmxRUtKfEKpIJDbObo+A2Hf2nnkF2r8doONCcGEfXCRFou7GFgsa8ZAAV39uH/2x68lLwpmK6O+on5fS2HLDoHn5BkdaxVIJdpGg31caOpeuJ+Ni/SVDzDTufiEBrtfQXE6MMg7UkFqwl8P6QGoQrhfA4eNT3WagKlod8MKPnAgQD80q54D15+Ab7TpMK8o5EwI52SbTpGKJvYChEZogN95Okij2EjC3pxDWrxwMbrgoB5guhWy+G9b27q2WLh//VPC9LJ9rj5Hc9QyMAI0BUURXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az53GOEMZ9bzWtbQpUcT5bkhQXOVwoKSdi+tQKd8p9U=;
 b=dQD1mU+sAsXyeJGgx2cV8Bie+7Zbd153M0GreRFQLcXYD0PeRtH7zIEC/eRRpC9IgMfaQCQIVkcPkc7RCWbCigFN9Q5QRwcVBHUz9vhqXG1jEWC6B8wfRxoXRrBUroAZZXu+D1LHlwpgztku/EdZN/o17yv9d6N54tEOoFXyf+ST7wZ4Z5eeZTKlJhsITwE6V3xPGiSjgbnOhxDDqQ30bY8PEMMfge37WctbAAryXuHpufE64VUvch75ZinXgeO0Dwz1MkR54l0jvz2PurVtLXeJKA2wyxvLuuQaOmv9/2oOmh27sLGNFc20iEO666dm9zCC7dVUDY9vOlkRlkhZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az53GOEMZ9bzWtbQpUcT5bkhQXOVwoKSdi+tQKd8p9U=;
 b=fnftALEFEpjkbnug4ZIpGR30wr/TjCWTOigvcl1gWoFeaGp21W+bgiTwtCOlJUosq30lOYPCXJToygEBAcC0Pf0D2ryj8Y+XHSqlhX/HF7O8t0lhtfngzhR7nxWHBgyt9EbGQeyoDtsP8Nhls+2z4Tbdlv3LQxNtaAzqyITFyZXxPtb21D7m87f9TSpqzjFemg2o9ONsgsKDr69Q7urSnvJZdBNjEW7PSpiH/w1YjzdWlgO2zzaAJ/W/ypQqoh7eJfdK0V7jstFS4EKSnFqBIJD72c/+3WpSZ2Nus+mvvyxqokRVxbU36/VNyRNLRh0slf1Jcm7lqNyqLtDu68Q5ag==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:18:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:18:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 20/20] nvme-rdma: stop auth work after tearing down
 queues in error recovery
Thread-Topic: [PATCH v2 20/20] nvme-rdma: stop auth work after tearing down
 queues in error recovery
Thread-Index: AQHY91OWr01RYJrezkySnTPdwNc8tK4/ZA0A
Date: Tue, 15 Nov 2022 04:18:46 +0000
Message-ID: <7714c74a-ed8c-3491-725e-afb891403b15@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-21-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-21-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5068:EE_
x-ms-office365-filtering-correlation-id: b8886110-bf4a-4b7f-1907-08dac6c07d7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  9WFkbOXIo3+Q7w4wDF9lCTOmnlZMux4n4uK+COaJgQJGxA9qNF1Oe7xv5jm+dn7kTVmO7hJguBRn2DyuvqebXu53EsZYM6y0kG6IJbGcq6+qKE8rSk/eIDG9moamtTn3vf/vr2PbRjO68Ijwz+zhDiO0L9oVULYF57xA3zv6P5iGjRrIVJg4SHojW/qgGhFGRHdH6AsdECvT4DPQQ5iWVtSWd7ZOHFT/7rxYdjQ0xuq5pW7Tv1X86pz64thcwHa82O2URWuYWkE3aKXS9jlAf3O3yAei0jSoEo4j8MUC1bqk9QQi4O/jZ1Y/eKYEAeC/PZDjnqbfZNNiqrnWXO3tGCLm7b0mdKW/cBQQKeqmWEoBnt9VIlRqpPUtZBDna+gFLntQa3pnIrshlAwRY30MILwZ/27vXns+aK9Qb0XNSpYHrTsWi4M44qoTwDh0H06vFYjev3N4M8QGrIkTijcL+MuM9H5HnFtpqxFlETyAi0B1QKvJ+kRbksLtBmjWdkKJijsEO/xNGpQ6mFzyRMWTvtl22wv/hANFiEaTHbomvMRM9KynwsdfC+0h4FDWgGwTvPQdiZVvXVbVf+FMdq0QW82bRmchfqlH0WSxSghcEp5WcxootR+JEekk8opzNoHy1fBzT/l9SWUsY0M+1Jj5QoHTomjlyIGTsKFpYwbc5I0yED2tzry6hK5wU+RJxVIoLeqd8EpSMc0J5NAZnBDc2EyEHnFOM5k6o39lrJFyA39ZrRMuMVeeZwNKa3+NTe8AZEWpJn6CBJ8q3BtlBt3T3pTfpyVnH5blQJJahDQ4gVO47slVuv1tNlRjUmtVq1wLE44XoTTgrXWuEOJlvVqjQQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(8936002)(31686004)(41300700001)(4744005)(83380400001)(186003)(2616005)(5660300002)(76116006)(71200400001)(6512007)(66946007)(66476007)(53546011)(4326008)(6506007)(66556008)(122000001)(64756008)(66446008)(36756003)(8676002)(6486002)(38070700005)(91956017)(478600001)(54906003)(31696002)(316002)(38100700002)(110136005)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NzRwWmVuVk1ET1BpbkM3L0xMc2VrdDg2eHd6Rnl0YkVWMlA4aU5jdndxOHB6?=
 =?utf-8?B?a1VXTmM2VENHM1RLQlB1Q2JhVUlmcXJSRm8wTStnUDBGNXJ5aTVCdHE3MkF3?=
 =?utf-8?B?SUQyaGxweEdqNGFZZ1RmcXF5VkM3eDBQSWcwYVdsVVpQekEycmtJQmR1bVVF?=
 =?utf-8?B?T0hxSDdyakNucHAxYWJMUjBaMExOelpFeHJSTE5XRDMxRy9ZQU54Uzl0cUk1?=
 =?utf-8?B?V2hVVk9OVmhkc0RqOFVFdk9sMGtIQVUvYVdGeXl5M25xMGdyTFV1bW9ld0w0?=
 =?utf-8?B?UU0vYmdNZU5qekJNSVRGMG9VN1RMejk1OW5STjVCVjNTM3FIaVljUkdPUHAw?=
 =?utf-8?B?aTJsT0Q5LzUwcGlXRnF0UWk3V2hiaXgyRjFvRktSY3RiNVhlbTQ3T0RWNC9F?=
 =?utf-8?B?RlF6MEFZcW9sUVl3OWg3ZUdTck5GNFpBaEsxK0ljNHRmZ2hlQmorSXVSQW9Q?=
 =?utf-8?B?NkRGWE1BVWRUNWR6cG5kRDJpNlJMVjVWUWNaR0tnMzFrekt5ekJlNUxaQ1FY?=
 =?utf-8?B?YzZNcFhlM3BWUmdVckFnek04NmxsdUJXa0p1R3dDQndoNFRXK1FRd2RocCtt?=
 =?utf-8?B?bUU3UTlBZUFUbkx1QWpDbE1JRU81K1FVNnlzOHlyRWpla1IxblFpTkN1Rith?=
 =?utf-8?B?MlJoVGUycExtMEVTQ1U4ZHJBWGVUNm5UK2dDcnZuQ3d2VW1yNER3d2plVHRx?=
 =?utf-8?B?Yk1zWTJteUJJY0tJOVNEbVVVMy9EazlLTzFmb3N1aGVQcU4vVFJDbjNkRlRU?=
 =?utf-8?B?TUFWWU1sYmpjN2JFZWJIc0R0cWJsNGJRNGo3ODFaSTI1ck14eTl4OWk4Q0ds?=
 =?utf-8?B?QXUvdFNRVUFDc01PWk91VDZ2QlZyQ2REcjNJUktrblh3NnVlc3EyOFB5b21n?=
 =?utf-8?B?VEV0NFJtWnltbDNJV1dqb0NXMUJERzk5MFIrMTZSQU5FekxYK1RtRGhJb3h6?=
 =?utf-8?B?Y2ZkYzlqQlV5b3VjNS9MNitseElZbG02bCtBTE5qV29lVUxHTExHSDlQVlNZ?=
 =?utf-8?B?cXB1VkxvY3N6NU5IQlZWNk40L3JrNHhZUWM3VUVlT3R3OEo5Y3VzNXZSZUE1?=
 =?utf-8?B?SnVQUnRGTHQ3dVlkY3JaM1gvbHlnbmpKZStZOHJhZ0lmOW5zcnNZMVpsWmVq?=
 =?utf-8?B?akxCbW1GSHQ3Y01zTk9QMXZtM01WMVQxai9YVWhERlgxTGEwQzdBTUJKVWZh?=
 =?utf-8?B?eU1qSEhydGRaWU5Td091d1I2Qkh6QVNLeVZmeFVnRFBRM3dmUUVHLzNWc2xQ?=
 =?utf-8?B?VU9zKzE3eUZjMisya0pGODN3eHpKQmhYTmRQQzVSaU12cmZzZytTZ0ZuRmdM?=
 =?utf-8?B?c2NoeHRicngvQmNiWGVBTWdTZFhVQXNtRWVpTjg4QzRkUnBpTDVvdnJhOTVH?=
 =?utf-8?B?WmpnUHlMY3BYb013KzZqb25pdGh5NnFDZjN5bWNUemFCRm5QcFVEM1Y2cWpP?=
 =?utf-8?B?ZGZ1RUZlOFBaei9xblhaTGc0SDVtay9QR2FNYkRQeFJwTXFhcUY5SUpEdHpn?=
 =?utf-8?B?ZjdpckFlb1U4ckh6MlFlL1pBdmZiUTN3bFNjcFJoS3lmVE9Tb05QNDlra2Nv?=
 =?utf-8?B?TlRHRkJsdmlzbnY3THVES2FkMCtQaVdaV3lCK24vWnRWdUc5K3laL3MvRGZX?=
 =?utf-8?B?dkthWngrWEN3c2VqMzJFMzRSeDRCd2QxU3RwVU1xN1hlUWw4Z2ZBNVNOMFd3?=
 =?utf-8?B?Q1Vwb0REVTJSbzZaOUJiWnZVbWxOZEl5ak05aVBKaWxDd3VEcjV2dG1KczVY?=
 =?utf-8?B?bnp4Y2xhTkxIR2VON1VKUjhpaWhJcGlVNEhNM2huUWVZRnFVaEtYZDEwbmZk?=
 =?utf-8?B?cmdHWUdMam5mZWJkenVzbWIxTllCbE1GT2xZMTZ3WUJxNzQ4VWtVaEpHVjNS?=
 =?utf-8?B?OXNCV2Z4MGhST09TTjU5VXREb3oweHArdTBJMGJnci9CU0lmTWlSb0ZKbHNp?=
 =?utf-8?B?UkZVSUFUTEJSL3hkL0doSWUzSnhWcTAzUU9VMXBWbUQ1QUJHS0JkN1krSzBV?=
 =?utf-8?B?YU1XL2tWSlBjcTdqcmJoN084NWRXY0dIZlp5YS85R2VqTDV4c1loc1FXNWpB?=
 =?utf-8?B?QTlEaFJrVDF0TkFRb3B0L0JPcjRvdUphZFZIQ2tUVW9GTGRyNENISlVRWEFQ?=
 =?utf-8?B?L0dycVplNTVSYlhOdTBsNU5FeDZ6eXprajliQTF5K3dzb0MzdEZDZTZSOTM4?=
 =?utf-8?Q?VS3aEJN2iuUHs5278tPGJJQ0/3DDEwPGt8i1THP8JIFS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D43A8BF8DD7C940A3392E152DF3CFAC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8886110-bf4a-4b7f-1907-08dac6c07d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:18:46.7692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txrUeivFlwcJqBEMYbywDlmIr1uX1j8P1z8DZgfj47KbFRa2GwWg2I1jOJ8p9LQDG8q7LQQwqr89d/FBhpVIkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_201849_756851_3BAFF73D 
X-CRM114-Status: GOOD (  12.33  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IHdoZW4gc3RhcnRpbmcg
ZXJyb3IgcmVjb3ZlcnkgdGhlcmUgbWlnaHQgYmUgYSBhdXRoZW50aWNhdGlvbiB3b3JrDQo+IHJ1
bm5pbmcsIGFuZCBpdCBpbnZvbHZlcyBJL08gY29tbWFuZHMuIEdpdmVuIHRoZSBjb250cm9sbGVy
IGlzIHRlYXJpbmcNCj4gZG93biB0aGVyZSBpcyBubyBjaGFuY2UgZm9yIHRoZSBJL08gdG8gY29t
cGxldGUgb3RoZXIgdGhhbiB0aW1pbmcgb3V0DQo+IHdoaWNoIG1heSB1bm5lY2Vzc2FyaWx5IHRh
a2UgYSBmdWxsIGlvIHRpbWVvdXQuDQo+IA0KPiBTbyBmaXJzdCB0ZWFyIGRvd24gdGhlIHF1ZXVl
cywgZmFpbC9jYW5jZWwgYWxsIGluZmxpZ2h0IEkvTyAoaW5jbHVkaW5nDQo+IHBvdGVudGlhbGx5
IGF1dGhlbnRpY2F0aW9uKSBhbmQgb25seSB0aGVuIHN0b3AgYXV0aGVudGljYXRpb24uIFRoaXMN
Cj4gZW5zdXJlcyB0aGF0IGZhaWxvdmVyIGlzIG5vdCBzdGFsbGVkIGR1ZSB0byBibG9ja2VkIGF1
dGhlbnRpY2F0aW9uIEkvTy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNh
Z2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KDQpTYW1lIGhlcmUuLi4NCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQo=

