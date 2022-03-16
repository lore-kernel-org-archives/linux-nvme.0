Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C29C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ngGI7o63Gwi0uomtkRj75hvtRyRnpACb4JpUKBiAynk=; b=hyUSzUNKlXPakyB2GSmWYZJU2K
	riVa0fTvZIIazD9IDVJ5Iy2snya8x/Rp7MvHKrTqgxcYm5j8pg6/Jx/nvXyF4eAAr+1BixVPE6Aag
	JELvGcNCSA1l0BZLaMOobRf8R134IR1NWLuSlXYlkeKib4k9TD64xUrkUy8kH+C77ZRZYmZNY0b3m
	jphCtuEUGktJ409BDcyXklAAvi+nkT8JIlQi0L4wTMZoSnAwLs9oEHc+JpAgdXScHZWQ6jpAHfCwh
	C/rX9vVE2eJ3WmqLOUrrINTXZm89qIIcXZxa8nlTux70xFLloSUOTSTiFKV3i3hNg2MbAPvIyfzKR
	XFf6RALw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUWsf-00Dqkw-1t; Wed, 16 Mar 2022 16:52:13 +0000
Received: from mail-dm6nam11on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::613]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUWsc-00Dqjc-4e
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 16:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPbKtuXRsZ7Medo13OIYZRXjg173Ylt+9mvNntwfNRCK5695kwnTz7/1JRB384cWhXkeH8qNezsrzMtpNt4aY3i1LAmKpNlQ47OHS0IPRVAu3n2aGgDYStcyKoN2ZhpWgMM+huiDnk2DAMOekmE/IJ+LJpgid9qHg5XhW7gZHWrZE/KoskwKGPl3wY3rdLE/QgWziMk71oGOdsxn6VZZODuKRnOr+37hRYuR8kIAYeEdXVLRd3RWhYQFVyqFTBpBsUpwpNo9WRGuKlsbkOroIDrVXA2Gg5ItNRatFG1Usngnwa1ojspbsSZoO2PIdwNOzjlVGkCImwSVtOneddbQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngGI7o63Gwi0uomtkRj75hvtRyRnpACb4JpUKBiAynk=;
 b=Oqh4ObrwPzjloSj94hK0oarQC+MW9H1K8CFdDh1va/7Erl/zRdS2UjLcILdv1JxKIHFkyQ5cOEN5jrXDRMpNaFE+FAGcl0+MYiI9zD1+kXbh+tcvjiPnbhdvFZ5zeNiHu/LKX3G8kTl7wRtoX7ycODwQKUYonYZCkXHEAdlOeq+tdj7HIIpb7qeDzF/y66mPWKKVA/eK9gLxgVRuTICqqe2jKMI/Ixnn7fc0rbuqdunoXvoECLGVq8H10DDXQdk/VOipNObIR1a0PAxINBaAhlZpAX8um3/AVQQtPExzWZgJ657NHrMhnPZ+vD1h3mdjWuSiqMbP2MI5f8KOuOjK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngGI7o63Gwi0uomtkRj75hvtRyRnpACb4JpUKBiAynk=;
 b=e3fSMKSiATB90rV4N1jHTlpQcjs3YaRdrZdvYKpRKnAVkohF3ZWRP6SBdMu5GGu26FOAko+7pYelGADJHwoXW+3Vx5vNOg5aGLjJ0gcez8fj0dh6P0ZjXTaOgujD6Lysw5l58cM7zV63b0kOJxZxLvmK8AX5wleBTsli1TH+IoA7xJD/i+YXuO1ckbToP8xRUuz1f/C/lPH+35tIOfew8PmYYm3XC7ASVLOj7v3R5Uv4esrDswpLRikyksui9RaKy65/OFNd2Kseh8KqXxCGk1bhZqDwZ2dihqDEn6ooxw1khFDqeiF6ZWs1ZBXwdEcPtQnlNgBRURb0ZxnKf+tjjw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 16:52:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.017; Wed, 16 Mar 2022
 16:52:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Pankaj Raghav <p.raghav@samsung.com>, =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?=
 <javier.gonz@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Damien Le Moal
 <damien.lemoal@opensource.wdc.com>, Jens Axboe <axboe@kernel.dk>
CC: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Johannes
 Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Topic: [PATCH v2] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Index: AQHYORlQ7U3+JbEzPUiEJOfuOlviEqzCOiMA
Date: Wed, 16 Mar 2022 16:52:07 +0000
Message-ID: <2d52a62b-209f-e68c-c2f9-dd56af17a18c@nvidia.com>
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com>
In-Reply-To: <20220316093423.17906-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d09608a-624b-4d2d-05d9-08da076d4e4e
x-ms-traffictypediagnostic: CO6PR12MB5459:EE_
x-microsoft-antispam-prvs: <CO6PR12MB54590C7C4471FB72B70E3135A3119@CO6PR12MB5459.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hLtpBra5qDJljlGVTlvbmYycQodaK6YtUG9uKbNE6DEhMRnHL17Nq3eNI/hmKe9GerhBN40zyLcVzheTMoCxPYGjBavtkBlMxZRY/7XkhPq6jv+rXMO3PWteamLBh6Px8DKph7a2zoA7XlQhRRUBc4kt3Q1+7bPGJlt1GjoWk8y7kVW29iEt/LJx/Ep14seskCr+4roDrWUpg29lkkrRmF/WGcvST029eB1Tjmt7fMvutCZJ9UNJgkG9RAjjlNWcn5R3e9gNc8Y3I9Xi85Fuhkn6aeQiGm/7faqgtKj5kCmvCa39M9LDl+/svloqQXl4nPdemGgSZxdvYk17phX4dbOlV60ryfCgSxfis9RRlpo2M952pPCXUmOE5XGS1CN45f3pwj3o1KdvmaNQUvj3ssMrv+DvvWdB8XrlivELCGT+ynelFGs4sjP09KdA8KJtDKkgZPKkao5F/mrbVc1tWZkvX4ak2EBwEashXVmhwmxKjpNi7lr+B+Qpj8+6trr//J3DZkcnMduQKQd21MFNlEU8btzvdqTp3RSh8ZwnSKaz/ffg9Pkl4CTm44DW890orEnAq/hX5NdAwvMrcBzIn2XWGkrgjy6joDAI/8KaJQ42+wY+GueiY1YQWVSw2oNlL+wtVYTLYW1eQjJYtpdeX/x3SNPyBPm2Lc/xOmdi0LAd5sSdRib/dOM89aGwDSQRqImH3YVq9OmQMvvu43c4saJi8m+ADL3Nyd+1Nl1DZtEufsZSjjDyaHXfGUNo9cEvBu7LLyU/W9RR8aIb5Cca8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(7416002)(2906002)(38070700005)(5660300002)(6486002)(83380400001)(508600001)(122000001)(53546011)(38100700002)(2616005)(110136005)(31696002)(54906003)(6512007)(186003)(316002)(66946007)(66556008)(4326008)(66446008)(64756008)(8676002)(66476007)(76116006)(6506007)(91956017)(36756003)(31686004)(86362001)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEtNSDBaUTh5UTRnaS9pTWhJTTFwcXVRUGV5dmhFVU5ObWJ2dnltVy9SZ2JB?=
 =?utf-8?B?WnV1RkZQWFBNVFdxcnRmelNBVWtrVU1XN3J6eHpseHAxRktnMlNiek9qWFlm?=
 =?utf-8?B?UGd3SWt0aXFQZXlVNW1ONDJNMkZwckdUOVp3ZjBVak9Za01wUzdjZGdSbVd2?=
 =?utf-8?B?UExjTHZRK2daeisxN1RkK2wwY2lXOW1sbUxOUnVMbUFjbGVUZHlCdGMzNXpF?=
 =?utf-8?B?cFJMR3JES1dhTFhuNjJkaTYxQ01nclVpbFdjNGJwVEVwU0tQUFk3UkJWUGdK?=
 =?utf-8?B?NkFrNWZYOVpZOWFsQ0prOTRmK2pqdWdtNTNFNVBxQXNvUWFnOEIyMDlpNlFD?=
 =?utf-8?B?NU5tREJnUk5DRmx0M1VTa1EvNXZQWk4zR3F2cERZL0lCUFdUSjZVMG91VWUy?=
 =?utf-8?B?TjBRS2JadytvQTBESTAybDUvQ0c0MWh1MXM2cFA1cTBGVGt4ZTVDOW9GN2Za?=
 =?utf-8?B?S05TY2NQaTRDR1NFdDkwbTMwTytDR0VVMytNd3ZBdnVIbHpaSVBuVFRiSnF3?=
 =?utf-8?B?L1FIMTFKaWxqcktnMFJNVCtlWFEvRFdERHlJM2tJRzlCU1FnUm9WWVZONFhG?=
 =?utf-8?B?Q09OS2NOdWJvL2h3RTJyNFdYL2E4UmtoZ2J3NHFwM1lwcjhyaXkvU0w5OUNa?=
 =?utf-8?B?akMvYnpHbGJUR2JVL01LWmxrUnoza1ZrTUNDa210dG8yd2c1dTJ4VjdNUjdo?=
 =?utf-8?B?dG0vVHRRNXFtRk9GTnFESVhYZG5RNkJ3Y3dZVUVqczJNbGNRdVM0K1dxWDBv?=
 =?utf-8?B?cXFnbHMrVmczRnFwWnJVTWZjeEsySWVuOG10dlc2bkk4eXBBMWoyVW9sd2FS?=
 =?utf-8?B?ekd3QmdsK1ZhaEhmUlJ0c25zSVdKM1BocGExangvQ3NmRjBmRFdZVUpHYy9P?=
 =?utf-8?B?c3UrTEk0bFlvVG1wMm5ZMURPNDA3bVo2ZnN1ckpRTVJGRGVLTFJ1dzMvanA1?=
 =?utf-8?B?SFEyOUl6QnArbkVmbm5odXZHOENiT1RNWngzV3hNU1Z6UzZhVEx0eWdSV1dN?=
 =?utf-8?B?UkR4ZzBlZVZ6WkJRcEEzUWhWQU92aElubzZKRThkRitoWDR1T0krdVBEZE1T?=
 =?utf-8?B?eTZ2MWRydjNGS3l2aHJiNUw3eUxYN1Z1OTRtV2U5TkR5ZGt4K2p3VDhmdE1I?=
 =?utf-8?B?azU3TmxkaXVxYjc3aFhCSVhqSmpta0JhUUc2RDVUL2JpRGo0dlpCeEE0bXVU?=
 =?utf-8?B?d0F5RTQ1cEtZR0tXYnJvdzBBUHhYajhyMCtoclVNNXgvdVUya0tRVlllNjBy?=
 =?utf-8?B?RDNpSkpGYy9kdHhzRlhUSlFZZW9tOEVDRlpLMGc3QWYybHRiNXBRMkoxaklN?=
 =?utf-8?B?dngxZXZVYTZYWHM0QmpTQVZTQk1wRFRTM0ZBb3ZqUDZjYmp1QWtLR1RSREJk?=
 =?utf-8?B?SWpLRHNFSDZ3NXl3Qy9WRU9YVzJZd2E3SnJ1bWZ0aGJxN2l3bHRkblFpZmEr?=
 =?utf-8?B?Ni80TWZMa1B1VWdkQlh0ZTAxOW43WFoyR0kwRVh4RWhRajgrdVZvWW50dEhi?=
 =?utf-8?B?dzBLalV2dE9lUXZGVWNhQXZIQ0VEdUw3MndpOEJ0bUV4RisrTGVLWk9oOXR6?=
 =?utf-8?B?UVBZVk1OT1l2aG9sMEJCUlFpU2dZNElyeE54NjE4bHBTY2hFeUIrcjFkWTdP?=
 =?utf-8?B?Ym1ETW95OEtvcTNGbDlxMEZIVzdHVEdObDNML0hBWDM5SUhQY1IrV1ZTd1Vi?=
 =?utf-8?B?ckNuWCtvR0JJV2UzZFJIYy9TdTd3RVhENEFQRk9pWHBiRGo1Y1J4dGd4M3JL?=
 =?utf-8?B?ays5UWNHMjVOTGVqV2dWMUh6Y2FKYnd5VlczMmR4NmtOeUFmL1NNVERKUTFw?=
 =?utf-8?B?b25ENVYxTFFrL0pQR01OaUg4WWdrbEc4TmNKUW9TekhhdUFaRklKUGt0MU9n?=
 =?utf-8?B?UDlTL3lCbDJkK2g3YUppNGRxcElCWCtKSTlTUU5ZS3BMTUg5djFiTzlWWDZK?=
 =?utf-8?B?eVFPVEswUmM0TCtaVkJPemphSVM5bzRwOFdJNzRSNVJwTXNtQmxRaSsyRlR5?=
 =?utf-8?B?ditEeXpLMzVqZkI1WnhmbE9YVmpZZVBIdkVzL1hJcmZ4ZWVRNkZrTjgyR0ZP?=
 =?utf-8?Q?W1jX4R?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C7D509BC0DFEF4AB72978A0A9C96790@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d09608a-624b-4d2d-05d9-08da076d4e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 16:52:07.2131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yvZCaaNgXSK8FwSDowYF4t1OdiB2SDGZ+v5ADKqbcUiQx97dkS/fA8vRFdjtV/dHLv1IGXf6d/g4xZuIEm4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_095210_203095_7B4E171F 
X-CRM114-Status: GOOD (  16.41  )
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

T24gMy8xNi8yMiAwMjozNCwgUGFua2FqIFJhZ2hhdiB3cm90ZToNCj4gVGhpcyBjb21taXQgMmY0
YzliYTIzYjg4ICgibnZtZTogZXhwb3J0IHpvbmVkIG5hbWVzcGFjZXMgd2l0aG91dCBab25lDQo+
IEFwcGVuZCBzdXBwb3J0IHJlYWQtb25seSIpIGV4cG9ydGVkIHpvbmVkIG5hbWVzcGFjZXMgd2l0
aG91dCBhcHBlbmQgc3VwcG9ydA0KPiB0byBiZSBtYXJrZWQgYXMgcm8uIEl0IGRvZXMgaXQgYnkg
c2V0dGluZyBOVk1FX05TX0ZPUkNFX1JPIHRvIHRoZQ0KPiBucy0+ZmxhZ3MgaW4gbnZtZV91cGRh
dGVfem9uZV9pbmZvIGFuZCBsYXRlciBudm1lX3VwZGF0ZV9kaXNrX2luZm8gd2lsbA0KPiBjaGVj
ayBmb3IgdGhpcyBmbGFnIGFuZCBzZXQgdGhlIGRpc2sgYXMgcm8uDQo+IA0KPiBCdXQgbGF0ZXIg
dGhpcyBjb21taXQgNzNkOTAzODZiNTU5ICgibnZtZTogY2xlYW51cCB6b25lIGluZm9ybWF0aW9u
DQo+IGluaXRpYWxpemF0aW9uIikgcmVhcnJhbmdlZCBudm1lX3VwZGF0ZV9kaXNrX2luZm8gdG8g
YmUgY2FsbGVkIGJlZm9yZQ0KPiBudm1lX3VwZGF0ZV96b25lX2luZm8gdGhlcmVieSBub3QgbWFy
a2luZyB0aGUgZGlzayBhcyByby4gVGhlIGNhbGwgb3JkZXINCj4gY2Fubm90IGJlIGp1c3QgcmV2
ZXJ0ZWQgYmVjYXVzZSBudm1lX3VwZGF0ZV96b25lX2luZm8gc2V0cyBjZXJ0YWluIHF1ZXVlDQo+
IHBhcmFtZXRlcnMgc3VjaCBhcyB6b25lX3dyaXRlX2dyYW51bGFyaXR5IHRoYXQgZGVwZW5kIG9u
IHRoZSBwcmlvciBjYWxsDQo+IHRvIG52bWVfdXBkYXRlX2Rpc2tfaW5mby4NCj4gDQo+IEFkZCBh
IGhlbHBlciBudm1lX3NldF9kaXNrX3JvIHRoYXQgY2FuIGJlIGNhbGxlZCBpbiBudm1lX3VwZGF0
ZV96b25lX2luZm8NCj4gdG8gc2V0IHRoZSBwZXJtaXNzaW9uIGZvciBaTlMgZHJpdmVzIGNvcnJl
Y3RseS4NCj4gDQo+IEZpeGVzOiA3M2Q5MDM4NmI1NTkgKCJudm1lOiBjbGVhbnVwIHpvbmUgaW5m
b3JtYXRpb24gaW5pdGlhbGl6YXRpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogUmFnaGF2
IDxwLnJhZ2hhdkBzYW1zdW5nLmNvbT4NCj4gLS0tDQoNCg0Kd2hhdCBraW5kIG9mIHRlc3Rpbmcg
eW91IGhhdmUgZG9uZSBvbiB0aGlzIHBhdGNoID8NCmRvIHlvdSBoYXZlIGJsa3Rlc3RzIHdoaWNo
IGFkZHJlc3NlZCB0aGlzIGJlaGF2aW9yID8NCg0KLWNrDQoNCg0K

