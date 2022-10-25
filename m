Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4F1C67871
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sMmRhwzHcVYL0cNgsvDyCdLRbzApe8JKnNsKtJiNF4k=; b=p+3yT84/jLDBxZt8dtScJxiPuX
	OPD0ni6iv7k3N+MV15UwweyVhNf7JIrI47Jy0J1RdZ0nTgNyDig+y8d+C1sIJLwDutgMfA/HaAPKM
	bZZEFQaUExCjytbnxZtlOji+FzEpUlc5FmkWusKS6pZRGntqkJl99oinJYsVpJlV02o6d50afyqGf
	Um/YUVhCZZ7CqKOGb4jQ6vsixTaCDiXpX7uGMKTKfyxCh4xkgx5QuAHEPMbTEGVwqYPZkXFH6SmlJ
	HKe1eYEHhf40VqTJ6qLl/gRahl2hD2s609HnbJoHtsSS5TC0GbpwkK231uDQNa2+pT8t51ESC0rdg
	tMz00fCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on88s-003SsR-7h; Tue, 25 Oct 2022 00:50:06 +0000
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on88n-003Sr1-Lm
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 00:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/ZuB5dxC4rSL8Yr4ZoXGST9o8tFuUGcZvWJuMO/ASOhrl/v3p2tgDLkBiqy/lRtll4jaeyp8x+BcXpg8ifdvY5LwPk4w/OnwgHptwCA4b4ZRCc250zU5R2bfRWISSZk7LVOT6qgGWaigNQYlJIvUKm6rZHbtdTmoPt/gHKTU5Q+iWAjVayygH1MUNAcR5afN+zkeyPjh+BS29ab7uVBUbucXpbnsTySVc2jcqBRIfEHq/KdLGOy4q7C1u6Jhs4OcJ8/1Pzb1OosuHlkMphorxQxwW30clBEV1w0pLarXjX3KYJ4ooeoY3/0ugqJFewH4Iw2ARHq4VYvuBR7LzVRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMmRhwzHcVYL0cNgsvDyCdLRbzApe8JKnNsKtJiNF4k=;
 b=IiZgq1EIlAHlNC5X8t5kWDBjEUKS7LWNVp19MMYQHhrHr3G9/P4YeXOtrzxmmdqRgZZ4QsqDEMKD0kSuTI1F39ml7J5UOvKj3L2LROxnctwWjXsXL1Mhu6jfREoRD1jqmbAXdYpeNuV/u52EM5mcD61zeHh0so07B2FTL0xJRXpZytacws4vgLXMkB1+eZvb3b46R4/k0dVMBZ2FB5BRNFVS9YEejdymuK8qcQ1aUglxzOmqKip8M5NLNRKGbr1QRpu01+wNf91dfJykinAl4Aap1jVnKgUFfIeI7OjaYLUXSWAp/I7fDMwrU+oIYTy81DkIZXKgE7xc2iKdgGn5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMmRhwzHcVYL0cNgsvDyCdLRbzApe8JKnNsKtJiNF4k=;
 b=Zvu5M3jJaetsdtQFOF8l4LDPur3NRSjRal6K1bLPndYis43e6fbgoCi7p17CKYTC00glNbvuJZra7kUdSkJ0iFH2N8/Pnmowmwm+OZJcZySG8OQ9kRNWaIUCQ8oTU3HcPzYYXWFlJ5n/NF6bqmg54cn4wyXLODuZZQjO0Pfy7RBXXHb2aVISL8i+UJn9G/abexhtxRRCoxLRutujhIx5z5ipfmyZpN6ocAyNsnjA3ukR98CLP1V5oGvJmuTmef+0vgEoMTz9s+JbA6zfpjMvSDkQfzb8NcwzdEq6uPrOjd/LuMGFbS7dwT0MiA5BOBrdGtLyaC0Fw2+dkEZcwEDyNQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 00:49:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 00:49:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-multipath: set queue dma alignment to 3
Thread-Topic: [PATCH] nvme-multipath: set queue dma alignment to 3
Thread-Index: AQHY59qt+vDYqERVxUa03hAQJCAjBK4eR7CA
Date: Tue, 25 Oct 2022 00:49:55 +0000
Message-ID: <c8b80ef1-0b80-0f03-daa7-7ac2236b6f87@nvidia.com>
References: <20221024185745.3164002-1-kbusch@meta.com>
In-Reply-To: <20221024185745.3164002-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5998:EE_
x-ms-office365-filtering-correlation-id: 5c9001e7-bd14-413d-1465-08dab622d5b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Pj+QUPDpJZckHuXr0170Z2eCN2cGJ4Uq2dhN77NpcQw9zYuHdDeOwr0aJhVoePOIzvQ3Sb+vS2+IC4WiSxAsfNQI3OvNEpotEy0jEo5OJBNT80ylNPcZ6q15UuKjR183/YJR6q7UFys5vPrn7XWpShG4W9QJ36WA1UNVA8QUhiPZGKJayEXXSynizy0FhVncmYPuhHyOoqN9wtxyrFGIkiswOr+TvF5F9e5COgGvQLZAehs0VZ185UcU5Pf5HcghkwpbHU1sdXWZlHAR8E+DckmzGc21Yxw4bQtrFUCo6wBye3KE6Gs7XeqvysWEc4owNOL/g3XRYwHpp7PX3evCpZiGM8NukiOgarvcPSIybAgNUdskRX9OGCMAUpiFCNQKjHN7zNn+AsADNtFFsKLzepbG05nyS1qrz4HxSJEiGmuX3S3d96gGugnSdx3QjgyS3lN44pel4UFNZLwVo/XE03eGcJNbiW7FtEKst0LUjeBBcXFwU22ZWuNjW1TDz3q1KKIKRJfbSwmpZHCF5136BGRizMzwRGFIPjtxF03kCG/OrJIrl/VI6kMh/rmpNDpcSON6lUGIMMZnIHTncu38zESOvsucimWOrhdB+EPWCy6oO1WZDy71IOKSNDBoS51TcrrVYrSTshP9UAZN0BlR+taGHKObkOIH/QI575kgPTkv37DkAyz1Uuwqb5/NiSmrRS3V/LnO6jhsNMma4E4tJctV/DswWwn3ddqfi6DspcYHmlOSdH5dCsbWrjvSGj4Djf2NKR3iEntHoC7Zx/6D96Y/pIGvp4122wiapq9/6zXrrNvRLDiLBCgQsKO4KD1Q+uEdb0psmm28R42B6hUeCQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199015)(86362001)(31696002)(36756003)(31686004)(122000001)(38100700002)(38070700005)(5660300002)(6506007)(53546011)(4744005)(83380400001)(2616005)(186003)(6486002)(6512007)(4326008)(316002)(71200400001)(2906002)(8936002)(66946007)(478600001)(110136005)(54906003)(66556008)(76116006)(64756008)(8676002)(66476007)(41300700001)(91956017)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?K2g2SjUyYmJKRUI4QTNoZ0lxd1VGMHc5L05PcDVWZzhmek83aGV6YU8wYkN0?=
 =?utf-8?B?elptNUtxQ2Q4NW83LzlvdFV4S1p4MjduLzdrWUxpcytjaGpnaGh0SVBQY3I5?=
 =?utf-8?B?bHJVbXA1QXB4OUtoSDJIVWZpMGU5VDNLWC9Nd2JVZGtUZHF4SW15K2hRN3NZ?=
 =?utf-8?B?T3MzOWllTFpLOEtrb0lWNzNpK2lleEJFdkMyMEN4dGRnWktJQkdnM2F4c1pR?=
 =?utf-8?B?VHUwMnVXV2x5Uytmcm9jb3hJUUVXYXRzMUcza2pZZms3L0tyTjlvd0RwSDJ0?=
 =?utf-8?B?MFUzN2d1VzFSL1phMUpTVndudzdKOWNUbDR0ajVQYWFRQUJvYlJYOStuYiti?=
 =?utf-8?B?bmZaRHdxUDh0UmNsNUltYnhvT2xSZkxKT01pOXRUaHkzZlF3dHUvUjBxcTR3?=
 =?utf-8?B?YjRsWkhRSFN2WC9PK1YwZDN3ZEh1dlhuNW5RYVRhb29leHFXZ2V6a0xXTEZB?=
 =?utf-8?B?WFkxcm1CK0lpVHEwM2xZTUU2L09rL2V5a3BxcGk3b0t3WnpTMUxsS2lIdEl3?=
 =?utf-8?B?dGFKQWJPZDlETEhmRk9oZThidnVFaEJKbGpPd0hLalB2ZEtKTE51TStMTjho?=
 =?utf-8?B?ZWtkVUZoN2pjSHNxQVByY2txNCtvWFlRaEsycUVCNkVhVUtvWkFNblVEY09I?=
 =?utf-8?B?Mm45ZVNGbUJ4aUZwdTNLU2kxOEZoVFNoaGR4LzczQW5YNGFOQ2xRTEJ1Mkp5?=
 =?utf-8?B?U1duWkN4MFJzamw4ZGd4Rnlxek9zVitTZkNjdlgzM1VBaDhObkZIWTE0L1pv?=
 =?utf-8?B?RjdKd0FtZktnMG5tRTNFbGZPTnJFRUZXUFd4SFgrZk0xOHZ2NUVVYnRXNjkz?=
 =?utf-8?B?NGRwY2RvSm5qLzl6RHYwS0huL2dqbkE4RGEyVVdrWkdQUkxyUjZZNzczb2hk?=
 =?utf-8?B?RmJmVng0VUtZKzhPNWYvMzlCTWxjSmFxaEtWSkVsTVpsdVVSc1ZuL2xwT2xT?=
 =?utf-8?B?VU1sSHk0eVoxOXowVEsvRlZuUnhYVG1pYTdHWWtGKys3VUs3eXRyM01Qckw3?=
 =?utf-8?B?QWV4NHhVZ0owL2RjL1RHNlU4alRvdWdTQXJFSlpKVHFVUkV2ZzVjd2dDMzgw?=
 =?utf-8?B?T3hOOUdnRXlIZFA4dEZ4UGx3bnFycHB5N2Ywdmorb1VJTEp1WDVTUTBsVnFJ?=
 =?utf-8?B?Q2JqbXkwbHJlZUs3VE51cFdqVU15eUxsaHJyQmRscGlHR1VNN3NOMWM5V0J1?=
 =?utf-8?B?WWJpaVRXMjQ1MERlK25XandiSEtITi9pNTBWSHcvMFFialdFU0tVT3d0c0dC?=
 =?utf-8?B?ZzczbmdyamJGUnF3NloxRDlQSS9wKzQ4L3Z5R3hwYzBpdjh0NEljbjh0ZnlB?=
 =?utf-8?B?ZVp2Ukk5Ry82LzB2aW5hWHFIdlRkazZiY0J1RjJVZHpEUTRkRDZ0WndaQ3Ro?=
 =?utf-8?B?WjNhY2JSaFRaWXlBT2lYWjBnamIycTJlTEhtcE5QMG9uMlBUYmVlQ0hnMDBv?=
 =?utf-8?B?c1J6UDUySEZ2bHV0RDY3SFUxbjlrMjJ2c1Z6Z2V2VUhYZFZBVE9obDNXZjF4?=
 =?utf-8?B?bjJlQmVVRUxnUnFDTTlLbVoxL25oZk9RZXZzU0I2NzJXckozbVZ5a1ZqaVdB?=
 =?utf-8?B?NSttL2FzM0J1Mlozb0lEQ2xnY2NHdDNQcllDYmQ5RDRJS3F6U1pMQUQrbVo2?=
 =?utf-8?B?TGttckVLbi93ZDJMSW9FelNpWVhkT0dKUnB0Sm5jYTM1Y1VkTjRQZUlHMHRj?=
 =?utf-8?B?UmRFWTY2RytPbkhzbXdjeEl6T3JVcEFsMDZCN2kvbHkvclBPK05UT0pleEpM?=
 =?utf-8?B?eDlmRExSUCtDTE0wZm50a0xNbEFMR0hOZjBJU1RoU3VNNmplalR6eWpsOWk1?=
 =?utf-8?B?NGFJdXl2K243Ym4vNzdVb1BoNFZKRHRKV0t4Q1NvamprKzI0WVFhOUtsUmo5?=
 =?utf-8?B?TGJGSEZLZ0loZ1VMMzQ3YWRQUkQ5eHZ0UkY1ZGp4eUdDVC93QzJXT003R3N2?=
 =?utf-8?B?aDlrLzg4aWsyTy85SjZuelQ5NGwrS1hqUGt2TmZsQk1SRGtaMEtoZDFPU0xj?=
 =?utf-8?B?Wjk2KzRXdGdOYm82QlZDckhEZC96WUYreHNKOTZaWXhpbVZoUGM5TU03a0Y5?=
 =?utf-8?B?a1hWM3JZSGNwSVZ6NExYNHFUSWsvb2laZkt2T2JzQVI5OTdGcVFBbFN3UDZs?=
 =?utf-8?B?Zzc4WHJHVjlxWDJwMk40dlJGcHRFS1hGZWVjNDUydHJnc1NtY3BPWEdZakUr?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49D7B4DDD3E1D7408BCD6F4E963BF6DA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9001e7-bd14-413d-1465-08dab622d5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 00:49:55.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5EiJPKeCt0y639KOhs5jruUMQLXvi7IBzP/DuQLzao0rGNuYb4kQGomFZL1AVHKU9E68J0PwVwAKawYM/0vnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_175001_751264_B6D2F6DD 
X-CRM114-Status: UNSURE (   8.92  )
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

T24gMTAvMjQvMjIgMTE6NTcsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IA0KPiBOVk1lIHNwZWMgcmVxdWlyZXMgYWxsIHRyYW5z
cG9ydHMgc3VwcG9ydCBkd29yZCBhbGlnbmVkIGFkZHJlc3Nlcywgd2hpY2gNCj4gaXMgYWxyZWFk
eSBzZXQgaW4gdGhlIG5hbWVzcGFjZSByZXF1ZXN0X3F1ZXVlLiBTZXQgdGhlIHNhbWUgbGltaXQg
aW4gdGhlDQo+IG11bHRpcGF0aCBkZXZpY2UncyByZXF1ZXN0X3F1ZXVlIGFzIHdlbGwuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+DQoNCklu
ZGVlZCBpdCBpcy4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==

