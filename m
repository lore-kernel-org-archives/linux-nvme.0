Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E542EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 03:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2F521EN2mFA7cwwxoF4M2qnO6eCFzshqQpjh4YEcoeM=; b=DDcPtTqp5CpEJk4ttPEoGbCVcP
	8yCkH+41xyKN4eKD7aKwnN8m9gyW3Mnl6VQHtdtyFBohBUOTvrf57A3+BgZ3xe20V24nnqHoaL7oH
	NrP9xvnHpmzkWm8nFxKVXs46X1YzG5uAdB9k10kNuobvARJj/mqryfOriW5wkhNpHpum0sObmmbSn
	/TSzT3DWuAgm6pti7FwqxB+dF4GfWO7ujy4FOZIPNeSijfqAYQOb6sJ1beYzM7mtVjtaCXyURL3k2
	ukBJNoaQ16fKJF2WEKovgQNihxrg89Iu2kHcAhtggYwKr2i8CLIbskqcBo/ODWvCBbEbvI8flmHZB
	sLEuSreg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun2M-007KK9-N5; Tue, 15 Nov 2022 03:55:02 +0000
Received: from mail-mw2nam04on2075.outbound.protection.outlook.com ([40.107.101.75] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun2K-007KId-2n
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 03:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klabzSK7E46j+hvsRR5BxJYJWUxW9FZELoZaF+NYLwR4egcEDX06LJS0GtSaQcmpvoeUp/GcAB7AUOdfhFxKxsLWTUDi3GUXCV4ertlVMQXRq4S6+RwCjkSgbK5+xzSp3J+kHR3pkO+QrJprFjvmS31W90vJnTqTxfcY2RkEuo9GHvDC88jDfwpV0FZgq7g7dtqNt2wSiAy/WI1mNA+SyWllrdlPQD9ux+mmgoh8dQVrD8GfD0zZqZ9sIgbxP3kT1NTjrJiaAefZerSUnja4KVXJP/1vBn5z0IeMO0AgBjUDtMfsqIHgis1/OnAWmyche78uYjhnhQCC4gFkGAZ5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2F521EN2mFA7cwwxoF4M2qnO6eCFzshqQpjh4YEcoeM=;
 b=YJf/Z3c3iS7kCcapvPiiZ+jsK/RlMSvvFgTJ8wF++/kuy0UWuFxfAFMw02lNDMjW7PTMLzMhjVTFKe2KqaFEFFTsYnH0XGhjFtL0gBttgxO8oSIFl7Dk/37MoW0f/QWBqbtSzYo/0qwhj0z4rYKAayS2VJttVRsh1WtjJYR79htLRd1YqOcxNEinoeeUMucJ6XNBZGgAJMRRuODbW9uyr7KFVnMhp8qnXzCYsBADSJn7QVsLJvvsQSa/QZ1yzFqiDUbnegaTrrJ18KFab4y2LSCMKdqDjls/NEmU68Yk6TipmvUeTx+4CQ5mAqz5GAvGlzS61Ubmwr+6SCzfjJWc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F521EN2mFA7cwwxoF4M2qnO6eCFzshqQpjh4YEcoeM=;
 b=p1UvRQ3X8alfxVDIobmYTGW2jHDBEarAl3NYs/F8Qxg7+jaseoAoLbwP5whUymEQX75PNU2mGQEbTaHpcEkTKnOK18OhQIm5rW/xWfklWk8p4BBsN+KAZAesYGbDM6wx42zxLf+Fys7nXNhbfUyFEHR7+KroYjkAOIllEFs5K6DARyvliNQqsbrIxAYqQJdAHGKBG0a7Q80CRB4/uMGCYnFk1v1UGrPE848ZxarZApNLbRlGmB0qpTJiw19sANTQjGzs5M4rpVvnOGlVsWewl7Scjt8I8b5Dul/rzJmPAPqODRd7G2t1kdOIt6hHfUVWp4WOyox09YxLLGI6Lw4OrQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB5423.namprd12.prod.outlook.com (2603:10b6:a03:301::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 03:54:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:54:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2 05/20] nvme-auth: remove redundant buffer deallocations
Thread-Topic: [PATCH v2 05/20] nvme-auth: remove redundant buffer
 deallocations
Thread-Index: AQHY91KtLGzrl0eflU6ymnKQH0WEd64/XWiA
Date: Tue, 15 Nov 2022 03:54:57 +0000
Message-ID: <443218c6-94e7-fbb2-4bd5-b995e56c98be@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-6-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-6-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB5423:EE_
x-ms-office365-filtering-correlation-id: 6479d2dc-94bb-41bd-ca31-08dac6bd2990
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5sjCrKLxorcdSV4q8Fm8a/vU1JschVWNy1ygUiti9kmoCH0ElODrpPk/gMoWjML6cpN/GZfWHvhd5B6x/IQnRGsfpLFPJaaUed3yMSz28Dnz3l0IS4gayTDP6h6jHMfW988NS2YD3Fv+S8MZVtybthUE9zAasUnczREA9bvWjW8Lx4x0YvNmYiZvb7HGqewFJngo7kgwEnfdwOStiqSbh1dXIKIA0sOy+VUKhZkb8kTY16xWXxkCdqSICQ+4stIH5AgS8N34o/Zmiawg3gIjdVwWI4zHgKvDRc01UCPB48C54UjXrDsC4J5Y80Aa0Ttlc0jxKVt24+A59oVtLKE8mDMcqabG4ubWrWsLJSlavWeUvqmhitmf/IIPUVPQTervcxmxHEmWennHB7d+CFL1Zafa8M7GvoB9RA6ZY6160Ycf5G4XCskZXaGo0qP/7T/qta37ylHvySCRumYiqJvq1lsL1SW6yyxAtV36J9L+80M70FPsrIsSwIbPyYp5FLj0s/NAVeKgn224LXOu5/g9dydbnP06QEnNHdgHe/HzN+MlJGEI9SWedJPfYN+vmfn/kvyKECmqE3YGIZ9yIi2KlNXoq5svRDSh8eguh/OyQkjfDkp7JFYOQvduH3Mw2pvfmAbt1vp8XIsxsb6JxOvE9OgvOCLowxn10jWYBp7qff4rKerM1dmlfsvTczl8mqRXhnhcufQe/YbPYSybN1qBQN3GLxQsG5uCqe1AgYmz8g/qYK2J8Rszm8hg1s/lNBkOs5RV2R8qPgghCqAxmvgeiFcMwGEKqpHcGMLIyATCVTnfLPCjcBpacCk+A12TFNLTbv7xDLx7kMdMpGWl3gSFdw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(478600001)(71200400001)(66946007)(6486002)(66446008)(66476007)(36756003)(66556008)(76116006)(8676002)(91956017)(558084003)(54906003)(64756008)(110136005)(316002)(4326008)(38070700005)(122000001)(38100700002)(6506007)(6512007)(86362001)(186003)(107886003)(53546011)(2616005)(31696002)(8936002)(31686004)(41300700001)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?c3VCNDFabnVUS2FmSDlKNmljY093d2laRnJYYVpyTFVFMklRc0d2VGowUEF0?=
 =?utf-8?B?MWNIUXpoMjgzbXRndWVPSVI1ajhCZmVwYmE4RFVkcGlnVUp0b1FjMXA3Z3Vi?=
 =?utf-8?B?Tk5KNVFxZ295ZnRTbEtRM0RpbUJTWUdEMUx1d2hiQi8yQzZzZHptbXFObmFn?=
 =?utf-8?B?dUk0T3JsOGR1ME8wSGRXdFkyNEpwVE9qZ1o1Uk9KNW9vTTFFemVkSUdaNlVs?=
 =?utf-8?B?K3Y5UkdsVm41NkpIeGtDQ3JYYXdQZ3hDTnZKQW5QVm8yV3JQNWVmU0liSUdX?=
 =?utf-8?B?NFNxeURuVDFwVHBVVzE3dHJkRUdtZ0MzanNmaFMrdy9iQmhORzluY1Z6cm1M?=
 =?utf-8?B?ZE4wcXppY3JRcnAxblpOd3hHRWpUTHRNc3J5clk3citNRU14TUV5Sk5LYnc3?=
 =?utf-8?B?SFNvSGpVVGJGb3FMdDZLeGw4Rm9ka1plYzhvS3FBakJSU3c5L1ArQkwvR1lQ?=
 =?utf-8?B?RDVMK3lnaldLMFZPYTN1R0pVb3hRc3BlbUxjOTd5NTZQOHRrei9IODlvdWVJ?=
 =?utf-8?B?UW5qaEJmbXBrbzRJZmhlSFg5SkpZVmlzeFJJODRxait2L3ZRR3dQdUVjWWZ3?=
 =?utf-8?B?VnJLMForRERHNlQ1ZGFxTWVsRTE0aEpFczNWUHE4bFVoMUVsVlN3NU80Qjhj?=
 =?utf-8?B?OFBTMzE4ZFA5UVYyMlhONEFGTEdITHBzOGo4bzJkM0dpaVNQdXpCUUs2aHlk?=
 =?utf-8?B?eStKaEVsMVVVWm1WZ3pnNHJsR3NWaGtOZmp4dWRPWitCS2IxdHBZMTRDU3RO?=
 =?utf-8?B?UFIzWmxRNlR4VUlrY3lTc2Z5VVRZRmxCV0l5VysrVEJKeVlqQ2FPS1ZYY0gw?=
 =?utf-8?B?djlPR2hKdFBqWWl3NFBjby9xd0dtcnVvbzZmdWtEZDNRNVRVOTczc3diMUcx?=
 =?utf-8?B?WmNSdWg1dkQ4Y0lKbjY1b0dDY0UvMGFXeGppaENyRndVQmhOMWNOdXNPaDM4?=
 =?utf-8?B?aDY4S0xlb2pmRUJyVW93d0ExRXZtSXhwamNkL2wxNlpsZndSK1ZsTWFVaDY1?=
 =?utf-8?B?b21rWG4rSzBzNUthWHVtdDFWYnNaKzI1ZWtvWWFsS0tDTWJ2Wm4vQWlmYUxM?=
 =?utf-8?B?YXlRelpJL0ZNNzl3OHBsazZSNUQ4ZmV0NUh1eHUzdkZ1MWlmZHgzVWJ6VEhQ?=
 =?utf-8?B?S2tVUFVaRitualMySVJ4V3VnTUZNdEx6TWloNkszaWd1dDdORHZ4U1RWMUFI?=
 =?utf-8?B?RUNPVDFzZzlXMkErTWVVcFdFZmMyKzZPQWovS1E1RkRsaG9yQVNhYnVvYXRk?=
 =?utf-8?B?NUIvSGFkMDgzK25aZ24veGMrTXpBazhFL1VHL1Fyb0Y0LzQ2QTdNbHBaTHhM?=
 =?utf-8?B?WUlhMmVqZEJ5ZlBPVEFCd2VuZkZIdGRJeFBtNU16UE9obEVmUkVlZHdCWnNl?=
 =?utf-8?B?aTZyNzlFelcyYnNObWxUOHplcWNvdU5jQWVGMjRjZjQvbXh4V1B2K2tNbHRH?=
 =?utf-8?B?VUZDWTdCL3o3YmduS3R5d3FSS2I4WldOb1BHallEY2IzdEhiSUpQU3k2NTRP?=
 =?utf-8?B?cU5tV0UrOTRYUURwRFdkZXpIVFJiNEdGcW9taEI3M0hXS3A0d1AyTkl4T2RM?=
 =?utf-8?B?alNGKzFMUVByMWswL044RlhaOUxHQW9RM01POXY3MEkzSjQvZWlmQ3l2NTNh?=
 =?utf-8?B?L1RmT3RLOElSMERNQzh4UnNLQVdPUXZhSWVxTStRbXdyNHZwY2piL0hFYmVR?=
 =?utf-8?B?WUpwUlRxTlVaeWxFWHZYd1ZCNUI3MkJ3dTNSOTlsQzhwOUIvcmF1MlRyRWZC?=
 =?utf-8?B?dUMxeG9kcjZEaUdIdEkxY2UyeWp2V2d3NmI5NVpNRVBZVGp1TDljRWFRMkMw?=
 =?utf-8?B?NnZHbDRobVNodkh5VkgvWTJWZlJEU0xNdzc3MmdxZjU4bUlmVW5mUFNlbXdh?=
 =?utf-8?B?T2VLc3FEK1NBRDN0VS94aHdTdkYwUXp2ZTdLcXpzeklZcWhJMzg3RTZBdlpZ?=
 =?utf-8?B?UVhjZ2Y1aFVmMGFwTFhRTUxwQWhtN01ZUmwrMk81T1ZvbFBDUVprUWZFekVN?=
 =?utf-8?B?K0l3MGpiWlJXQzlFQ3pBQXUxRXNzRGVUUUtnUXdmZDNKVG4rYWpzVzhJRkpn?=
 =?utf-8?B?aTdqN2c4NWFVYmZFQTNtc0l0RDN4enlGQjc4R1UxeHBKb1R5Zkx6UE9sZUNm?=
 =?utf-8?B?ODJiRXZyamxwdkJUaFJmTVdpdmdXai9OTC9ySFNFRllraUFDdytia21xV3ZZ?=
 =?utf-8?Q?OpX3GnJgzR3T8lpaTPfat7qZqbwodBJGGExIgXixXH2m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <310B196401811D47ABDE0EAE8FBE923B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6479d2dc-94bb-41bd-ca31-08dac6bd2990
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:54:57.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6IogF+iXkcmdeMKWEWgSZGSGsGwrXHTkbMUP7pCo2cY/O/xM4Ns9u2YBow0hw1LfweFtnLG0rR7mJ1uBZ+0EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_195500_158054_FA4A77EA 
X-CRM114-Status: UNSURE (   9.97  )
X-CRM114-Notice: Please train this message.
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IGhvc3RfcmVzcG9uc2Us
IGhvc3Rfa2V5LCBjdHJsX2tleSBhbmQgc2Vzc19rZXkgYXJlDQo+IGZyZWVkIGluIG52bWVfYXV0
aF9yZXNldF9kaGNoYXAgd2hpY2ggaXMgY2FsbGVkIGZyb20NCj4gbnZtZV9hdXRoX2ZyZWVfZGhj
aGFwLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg==

