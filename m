Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F45CC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6RYGTSFGqbrxyV6IP+CPwqcs1x/X2dCodnt54JZ6h4A=; b=YD2wRG/C4AepUfqlQFQbrBCBKP
	fIPqamMhF/81LZtmvDTO97ahykLE/JbBfzbGBCv/WXLYE976yzHMyTZwuhmZOsAg/6VQjO2Ytse8m
	JtG7Osfr0S+P4BOnc7fKGn7SOAAQ0Nxekw29H+6oQ6OtDMDtkWdZ/JY9NweIR5WwrL/OvbE8hhwX2
	NYB75swi1hQCPYcwz69BXof1UYa9J+g7pIpg4kMYBV3anyWuRagnHmwOPgBkaXGXoUd6+2u79cppa
	wBcTfS5VAIW9UOxPl6PQQVcOAP90UQ8Y1RUMePWmrD8S0rQzaxwP1iuWj3g2Di1oUftuxN9vtiY+X
	RMB/yfKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJit-00000005p5Z-267S;
	Wed, 31 Jan 2024 23:10:27 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJiq-00000005p3n-1QLj
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 23:10:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdAN4kF095qAAR+rTPR+hX1WwH4MaZtkXElIJI0ShwFrvh5dZzkbBvsCWIvZ35n9hu96iIkAZwU7gVNZXVyTahs+FP3Xfu1VkgY/oF2aKzahea1hs/iUYb/t9CYdymi/CFkFNYf7ikkDAGoiZHt8oCTEHgmpKUwbxzrYkiXH8FQn/0liiOwiXAyxIVazKKkccYvm3/dygvdDm6TC3P6pCdEho0nD9pFgR2O6U6vI2phbaVMi2jhzymMw9as+GoYXmuRYQHQwyISbBOJ5LL174Y2mJ8Wpi8HeTJd01Hlx/4mPBWF8tIaIR26+RtnPnaOTp1Q0aFq4hKP5+GijT1F6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RYGTSFGqbrxyV6IP+CPwqcs1x/X2dCodnt54JZ6h4A=;
 b=UKMl8stNjd/N2hzS0sk7WA7CYZXQ/48G7HbWXiW76UQUXtFLWo7jUpBjwknK/qKkd+Fy6LW3+njXESdo349j1jEebQQWChb4nzgyz5u7op8WS/DSGNmcW0/XYNviTJaD7ojo0yVT0GFSk+9FuOfetFjoyAekKeSPSLJlah/xFdeUzVfCyz3aD/4litn6HH2xT535ctRPh4cXPuTtPO5satwy9lTAR0Xd2QZFcGlAKnGbVHS3JIfJeATTDpo+aOMy6ro+VNe6t1caoEAV8dRGU/+Ftc57cWnl/6TTyUIssJ+c/7QzZNhGHsLGVSsPLJWXk2PGOzMPu1me9OvXht/6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RYGTSFGqbrxyV6IP+CPwqcs1x/X2dCodnt54JZ6h4A=;
 b=fTNB+mI1Jt60VrS/P7hZOKsA+YvPoroGz4bMzZGosERPWUbv5XEXsrT8ByiK07TYxN83B+YZE4XmU2eJVdAGYDW3VG6uc/i+MByWWLUPW9Ocxx9PGEBvCak8uDd0M6PN3Cd6io53fZUfJrXPj5ffvrwCRdGsDFPx7PNEQi7KegZH3vlNkzRYY2lS25YlRoPE/z4ikcpQ5cQ6Do2/FnaRk840YKObfZBRk9KHWE5EBZZiXJ6AR1tjAcqQPb3VwoFxkybkE/IITsWVP6cxR/YYW7VzKOgabbgxQe01BH0fbSul9mB4kwPlZ7tL2icRmIfYsnKHrke8T1t7a0XLYjKm/w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 23:10:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:10:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/14] block: move max_{open,active}_zones to struct
 queue_limits
Thread-Topic: [PATCH 01/14] block: move max_{open,active}_zones to struct
 queue_limits
Thread-Index: AQHaVEYG9vIPszc0h0GrAkGzSDKvFLD0jMEA
Date: Wed, 31 Jan 2024 23:10:17 +0000
Message-ID: <dafd9deb-86a2-4ad8-b565-7d5bed67044f@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-2-hch@lst.de>
In-Reply-To: <20240131130400.625836-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8496:EE_
x-ms-office365-filtering-correlation-id: 113840a8-69a2-4b17-285f-08dc22b1c9ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VAaPNnaV3UYrriIQbcIdpUseMioqzdS969mK1Geib/89UOZG92EHuBe1XQESCiv5caAKXAMgRp1GTM0XJs0qjTxNjFl4CM++1PfaTkJBUTxHWpBSCHf+Kpe3dzocdckunYSic2EeU9YTQH25VbM6cKJ8wXbNoOZqGtl/dzfWHOkhILjY+NahhFxL9C7s8qT2i61LLUY6lf7p6+LBfN4/KDPGC8OsWZ7BiyE4zLYgoGkQueHZaOtZGSYcYIpAqa8QWjY10qNIUxnzBoFQt3Vk0zgOQ0wDP16v2bHfm/mAu3+GvFV2MQolXbmZ3fNNb/O+vzUn6TuZC+ZWut/31rgS4jUizMSwLAdQGKYQid1B3q4wyaHP3oWfiYU19eGYJCrxioY57E9Oq/QAi8bqerIy9QJzw4KGo/Bh/DWhUCP8q4Oj1eMR6q39TKLRH77asnwRXXzjzwRdDJoVNg53ssdhF3UTkmg0TxQI2/2L3P3SDFWkmO0KxJCvaFTKFUO7KrKC7cxfNH168+NtFjq0UAZZ9gxgx+kQsj74N+BFYLHoDECVVr1noy6zyeBjxcEMawrDBcBkfEERQw6QJJkaOmpNPZNiJ5hfT2xUB4Dz/QIOSS/9lhCQwRT5wl/WqBDOgMrY3snRtJbKh4+/xawL8ftZpuWdACdDbIiTGHxNH/zUOcKTczRbgGrOEAZZk7YFu65Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(2616005)(6512007)(38100700002)(8676002)(4326008)(64756008)(5660300002)(66556008)(7416002)(8936002)(478600001)(66446008)(6506007)(2906002)(6486002)(53546011)(76116006)(4744005)(316002)(54906003)(66946007)(71200400001)(66476007)(91956017)(110136005)(122000001)(38070700009)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEtacUJaWDJQV29OcnI0ck9oKzRjOWYwS3BjeWVaT2VLYVdqalgrZ3pnT2Vu?=
 =?utf-8?B?UzVRWkJxOTFIQlR2T3ZzL1l2Qy9QVVVJTGxZUlprOWhxUFROYW04ZDdIYTNU?=
 =?utf-8?B?ayt5dFA5UFNQSDV6UllOQVhSeXlrTlFITTRLL1pkeTNQZDYraDRyUkJFRFQ4?=
 =?utf-8?B?UHNzejl5VEZGZEE0bzlMYjc3Q3NZMkdzZmNYcGNrNDJBWXFJK25DaWNjNFpt?=
 =?utf-8?B?V0JwRWd6TGF1aUwxWWFXTDBIYVg2N3NCLzJESGV1MlhybEhTWE9DNENMWnU2?=
 =?utf-8?B?b1AydHNlNENPSkhtZkY1bVI2Mkt1NC9EazhBMUhzNjg4UkJaRzliVm9GckRz?=
 =?utf-8?B?ODlTQkR5cHRvTnNWNXhuSExrZDJOT3hwSi9iZGEweFhvZTJmeTAzQXkwV2da?=
 =?utf-8?B?V3R2R2d6bnVIOUNLbk0xNlh0b1YvNEdBcWVSUEJPSEJBbjdoTFpLajhRRVF1?=
 =?utf-8?B?YUcwS2Rod1FmeHVBSEc2SURPZnl3TWdBd3ZRb1FaZjVkd2pGYkJDTVpjVzNv?=
 =?utf-8?B?TlFSSWpxSmtCRVYvUWNDRithRW82RTB4MmRaVGR5b3czTzZiRWJoNFU0dUlr?=
 =?utf-8?B?R3JxbjdXQm1SUFRZV2VGRjVXNjdyV1E1emtkWEN0am1ONmVQRTMydEo4WGk2?=
 =?utf-8?B?cTFyVGh1T25lallhVVRlakZrNWxienFJYzNINmppMXFSdDNPNjIyZXkxSjUz?=
 =?utf-8?B?RG1CRS9ob3A2b2dLYUxZcnkrNWhoWnVqVk9WWnkwYi83MmRnWGFmVE12Z2Zy?=
 =?utf-8?B?QVRVMitwd0RYQjVXMnZXSkxnSGNvUWtJL2ZzT2tuUEJmc0NXVlN3UWx3OEhW?=
 =?utf-8?B?V2pLREs2V2x5MTR2b1JRMnlHZmVpSlZic0E3aDNWVXZtOHhZZndzZWEyTkRP?=
 =?utf-8?B?R0p2RUhMYVdBRVJjOWZXc3FrWFFFWGZtTGgxbnZUb0RtUy9JN2ZrUnRKb3ZS?=
 =?utf-8?B?YnZOQmd4dWo1eHBrOTJsMHkxcDgvdE1BbHl0S3k3Q3Q5VTJ3SnkrK1pxNjN3?=
 =?utf-8?B?R3lWbi9QZE0yaFhLaDlibXI5REUzVmFaV0lJdkdiR2o2aHRyQzZIWkhzcGtU?=
 =?utf-8?B?enV2d0oxZmlnRURiYWcvTVkyOHZjL0ZtTE5KMGZ3blM4V0ZMUGZucmR5T2Ju?=
 =?utf-8?B?RW9iSXg1b2lLVm5yYzVyVVBFenJsNS9YWVRXWnNHRXJtN0xzZlhKN3lpYkYy?=
 =?utf-8?B?RTBQclIyUHV2d3VZNGIwNEE4MXhjc0pHSkJDUjhmaFY2VTlxUTZpWDZIek8y?=
 =?utf-8?B?VWwvWDVCUDFvOEszRkJFczQ4UWRqZFNCWkdURG1kWTljb1dOeitLUmhQc0pw?=
 =?utf-8?B?aU8yK2t1ME9GVDQ1ZnFqUzM4QVpaSnAyMjl6aHgrNzBwTFpybk1SaHhBQ0RQ?=
 =?utf-8?B?dWx6VWkxQ1lUZ1UzR3pwcFp0OFdJMkQ1ejFkOGtJYU0rbW4rdG5IQ2s3YnRo?=
 =?utf-8?B?eUVqUW50bTVMQUdzZzJ2Y0luVU93bVg4cEJxREl1emFRZEZVQUMvcWF1aEVZ?=
 =?utf-8?B?K0w0Um82VHBES3hvNzhFQ0phNmdqY2VFNng4UzA1YU13RE43THBuRGRnYTFX?=
 =?utf-8?B?cXJYVHZzMU44V2h3dTFGc2dndjBYQ1BkMGxWekZvMzMvRmpadUI2NG1ibDdK?=
 =?utf-8?B?N3ZGZGMrQ2UzM3ZoVTcvOEQrNlZmUmUyYUdObDFsTEQ0K0d5NnoySzFRVkti?=
 =?utf-8?B?REc2TFBVbVhtYWozSUpLZmtGV1JNcVJ2U01hb09pQlhBWHlaUlE5UGNxUWc5?=
 =?utf-8?B?bG9BblVWaTJFRmNuVU5EMmNhK2xGRTFRQkZDanRsZndzektVdGxBbi9XTnZw?=
 =?utf-8?B?cXdqeEJNTmdNQnhrS3ZlR0ZkT3JkeVZTRkQvUmhhZXFjM2YzYjdXa0JpRVRp?=
 =?utf-8?B?VDZ2a0N4dThxOTJHVFRNV0hMRktNS3ZXM0pxc0R2NWgxVW9rbndEbU1DUFVu?=
 =?utf-8?B?Nk9laEt3RStFbXQ1RXFPM1JGRDdqU3ZNa0lJYzI5aEMwSURiRmZmbTNFZ1dR?=
 =?utf-8?B?bG1nUVZKMzNDNjV4eVdtTE9WTjlJRkxtQzFFMUNEWnRMaVBHNEQ2QmRJcXQr?=
 =?utf-8?B?akttcWkzdUpUMExzbFNEUi9nUDJxQm1RcmpsT3d6bjRobCtxcTU5a1MwK3BC?=
 =?utf-8?B?YVdVMld4VjZ5cUdGRzNKWTZXYWprTnBaUExLdVFSOE1tS3JDL1hXOUNxZEpW?=
 =?utf-8?Q?4huEDHlIem2P5mmVwPeMR+xK0QADJgyXHM2olYA/Que+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11C512EE33FF7F4F9C74EEC094FB26D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113840a8-69a2-4b17-285f-08dc22b1c9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:10:17.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBWD1xRQ3LvbV5iNc1FylFAYReXZgdAhbkH+xMoI/qH7cPbz+9UaY5la9HS3dskgdt3GcbOkzJqn7fej/+cBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_151024_402257_5D55A70C 
X-CRM114-Status: GOOD (  11.29  )
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

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBtYXhpbXVt
IG51bWJlciBvZiBvcGVuIGFuZCBhY3RpdmUgem9uZXMgaXMgYSBsaW1pdCBvbiB0aGUgcXVldWUN
Cj4gYW5kIHNob3VsZCBiZSBwbGFjZXMgdGhlcmUgc28gdGhhdCB3ZSBjYW4gaW5jbHVkaW5nIGl0
IGluIHRoZSB1cGNvbWluZw0KPiBxdWV1ZSBsaW1pdHMgYmF0Y2ggdXBkYXRlIEFQSS4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2Vk
LWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K

