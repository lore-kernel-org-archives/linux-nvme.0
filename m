Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE086C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xc6vjtNSt1JrooA+Vhoc4Zrw3rX1MdIVrIEEKSLkihY=; b=1xMqGcwhpQhvNV2ALokcTTD5qb
	eEMI3bq4R+/v33ytY+++TJigvKynWpG8oJ7jnrEz8DrtuULRxYEk/nRLnMijxF7WGSmkPtTQLossD
	Fy0GI8KVOLXYGZ0LcDPz0m2/X/swkcYALRE/iOhnrTGxS3e1jbyEEcnfjb9i76B3bNFyHersmlq0g
	iu8CGI0to8OIw9CCa+2zT6ZTnJlEmq4dIhjNLbXxZFKlVpu1ER18FtfTqnbtDXyR1zOTL6DGyUvVJ
	URv/Dm1n0f5pxUxzZselJfHP4LfYljlu5QWCaE7NMEhw1tsS5uYX1bcKgNBZ/ZPxBdRfIFH9A+Q/S
	QkThcw1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNlc-006ToK-VE; Tue, 25 Oct 2022 17:31:08 +0000
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNlW-006Tn2-Uz
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROJCnYO7x1kVkbinLOPMQ3uHNn1Uo0a4AQlV1buTa8THA3bd5iOOJPRmAundQk/SacA4co6OuOOTnO3991/mt4fxOf3yPbRCERJ9X8ivJri/rUsqelGk/+31li66AJKFqJDXfI7ewF1Id4o8iJtjuB2wtpOsy8schMBCWbeJe/Z2viGBxVaSgvLuQLjj1R0Xoa/twvlqz/Zw6o/xoUvANpw6PPzh7s+haMW5JZ5dSaJP3i63Gl23jY4ENmIKlOWL4zoiA/Nq4KYduAFdYVZVcil9oV0LrqTveYvliqvdIZJNB5buUBbFluGcW1RDPOy8hZ4hccC8xv9FrkkIZhpT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc6vjtNSt1JrooA+Vhoc4Zrw3rX1MdIVrIEEKSLkihY=;
 b=Z/UlEzoRACETM3eYckZHiJsq5JrEIdMlsoOi2jQ2QF4w0OjS61xyIQYjmmGJa0OyJaanvEzsZU9ONCJwgyRyav87gbKjsp8LoGsVyj+gE96MW74HHwiS+Ln5wMU8esdopFl6plnSX/4eDQ/PuXrtQ3vcALHtwBSBqaCmMat3F3bCHJxsWJYvTcgGnn1IzzZzlNMNGeYd5zg0GdTI7PePIQgXFcQRtNbBVsnQCTlzUpxHQ2qPzn2WeCZ8L8UTtiTiULHvcv4/t6I9jZ9prX+5rzcBkoWCg2XPygqWPUaaYa44DrxMiIxL0zHnyOswWkuz61vXDlN5z1/nvafA7a+zeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc6vjtNSt1JrooA+Vhoc4Zrw3rX1MdIVrIEEKSLkihY=;
 b=LnaMx28xPLMJLta+ZswDDnRK98lM+leSMB8jk0H+Gkt4OPtM/tahm6sRf50wZOc1wl0HhKSzI5pMwwTdShKKojB3eldQPb//XEAbGX9yUPZDnAH4IWKsz9x1q9gxSDX6iui59ULts9dX0ZZCx9d5w7NM/npTnxr1e1H05FkiHflBgEQVnVoFOlpqYTAyJIDrRZo4XocDw4oESwfpZjlVx5CysSaHfpaobPd7cA5kmhHEOUCqgAtHHZFV6SYuHKtNaxbWd9KacSpbvwmgRh2yh2KXZPKLhJ4MOeDVW6YDsjcyaG9vDe0YcxnQdMN7YZyQIQBCYHPD8ZiESy9l6JbyXw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 17:30:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 17:30:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4] nvmet: force reconnect when number of queue changes
Thread-Topic: [PATCH v4] nvmet: force reconnect when number of queue changes
Thread-Index: AQHY6ImZD093VYIbAUyEWCPACr7xJa4fXgAA
Date: Tue, 25 Oct 2022 17:30:57 +0000
Message-ID: <3e102dd5-da6a-cdae-5bf7-6c3f635a9308@nvidia.com>
References: <20221025155008.30028-1-dwagner@suse.de>
In-Reply-To: <20221025155008.30028-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB7377:EE_
x-ms-office365-filtering-correlation-id: 3d031e5e-0e49-4607-b902-08dab6aead5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5tz1KGHg0vzgdrGcP75avHmxrYGiXusGtdZPDe+FDyOWYg7oCftY3ya1ysRXaOMk0t4DRuvAG71Vz7BZxbvHvf4hcXep/AthwcJ2bVHly+QT8qMcLuRO2P4//0TevlAcrFvbNDguSPJdDhrHLM0cN4fdNXoDZBS1HI3iaZF6aRzy3E2apwkJCofCwlQ2xhSpjJ7sb+FofQby/qWeTbOp4eqmunW7kAzB9d746I/yry33+Sd01hAo0fIVEVO08PlKvSt57870Q9GgSFGpaFO4lD2n1UlwyoeyHCgr0f6WjB17if81KfO0KI2UbmORAlpQkuGfkoAZeLpQQZA470L43SNTMzjLKCscPcHGS+zpzeNX2s96S50mU+Rre52xWZAeIQNIDZE3QX3tepR8d3h9UWuc+/6mcC1fcQebPBldSw7yobrAMFBHTSxqJctLfRV3I9StbEV0nAmR3hU2Wiy70EkMqPn6wM4j+IFvqiJA/Ae4AqcGC9jcCPtrDMkqFvj7jFr80GKGipO+f3ZRntHEOeaUdI8Aw8Lp2E2mikFBAC7693TES01seacd0KWe+T/lAWbv5qcn2MdnBPBbbbTe28F5NipBc4YUagAZ8Kl/O+7YDOv/Ef8BoersqPjKdMQM6zwHtNW3tYoYfWyjuNby17fpCvR+L2mSNs569bvS7LYb0JHvmzxnyjqkPmH1HevTb7L8kr1HP4LFA+PQ7ACJ6Q9gVqV47KWN2V6kA4PrMckeQDy4vuGrOrjR++ZeQkv6GpMh8/NxyNvbrLwKTHYHaIyvwpARVT8lfXnTCj0PQdTK3IZa9bkSqK7c8Vu8e2QHkg6gjrBTnXvv+6izbe+j0g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(71200400001)(38070700005)(8676002)(316002)(54906003)(110136005)(83380400001)(2616005)(186003)(478600001)(6486002)(6506007)(36756003)(6512007)(26005)(53546011)(122000001)(41300700001)(8936002)(86362001)(38100700002)(5660300002)(31686004)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(2906002)(4326008)(91956017)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NUJ1UE11dWFmdjNabGl5UGVYaHloRFhoSmZQOUhlbWhORzRoS3NQYnFhN1A5?=
 =?utf-8?B?NWczN3hYeXR0MFdJOERTS3lXUUpFSGpmWHFHUmZxZmgvUXZLR1RiVXV5Ri9V?=
 =?utf-8?B?b2JYT0ErUFhHcXkxaE12RTl6SmRWaEd3K3Joekh3R29oT1pwbzZkY1lCTzFJ?=
 =?utf-8?B?Z2t5QTU2MUt0bGU4c2I5M083ZGJodmtMRjIzVUhQNXk3L1dsL1ZsV29BcGFR?=
 =?utf-8?B?SHJDL2U4Mndqc0oxZUp5YjdVRDlnWHFuSHZpRENOcEJMckFxMlc5WkxxbTZs?=
 =?utf-8?B?TGxuUVNleFhkekNEdzZuNXVzdWRzUXlNVlZtRUtqNnl3alU1MW1YRzZaMWtB?=
 =?utf-8?B?UXAwK2hNOVhlT0pVNzBnaUJxREszenhBYXd3ZWtTOXY0S2trSFBHRHNjWU1i?=
 =?utf-8?B?RjVZNGN0aW85NzR2OE5valpLUktWekFqZUV2RWF5Qkg0dlRSeWUvNEpMaHhG?=
 =?utf-8?B?dk1xdVllNzZWOTFPazRFNktjRDNaZjQ2Ym42eDE4WnVvRWZXbEp0aHBFbDFl?=
 =?utf-8?B?TjVYTWZvZnp1YWt5YzFEWDlVQk9NZTVoQXJKdEZCRkNUdUFZVzc2WSthZTdS?=
 =?utf-8?B?dFhhdDhlem1PM3JtRVBaTHA4VFhpNCtEaUk2SHZPd2R5OWwwNWJ3QWdmNG00?=
 =?utf-8?B?NjN0Y3NzdjFIV04zZ0R3cHEyaFpDVkpJck5vbXQ1bllmSGhxbmxlSUNFRzRo?=
 =?utf-8?B?VGNPWm9pWjA4dmJKZ1k0MXBadjY0aGlXMGp2Zi9sd1JMNFNNL2dHQkhMK21F?=
 =?utf-8?B?UzFKNnd0R0lnaFJDK0FFeDJaVjFobTNZdUhhSHpTNXhCUzhxU0lMdmtodjFv?=
 =?utf-8?B?WkZ1WWVuVWpFNnF4ckcxY2QrY0ZJamtydHpySnJlM0JtQWh4QVpFY3FWN1Vw?=
 =?utf-8?B?RjNzK2Z6TFQ5Rk1FaEZ3VkJBNElmYjRUc1pQdk1keklSWmw0TzU2VEg4cXht?=
 =?utf-8?B?TFN6ZFdsT29pTTdNSlZab0czc24zTkUySW5CaGptdVUvYVVCT0VkNkZsR1J1?=
 =?utf-8?B?YzVBZitZeTdRYkFmblhrRStkcTBCN0JqWElOVDRwK0VQN2xHK3IrWW5ubFl0?=
 =?utf-8?B?YzVNS296OVM5ZHYwcVFHVnh2OG1kWGlsN3l5UWZ2cWpFcnFFSFlnV1kzMitB?=
 =?utf-8?B?MG9JTXh1VVk5cmNUU3ZwRytzSVhydDZzZ3RBRGZaYm5qZTh5UG1DOFcxYmln?=
 =?utf-8?B?YnVVbmFVL0RHMUR6NHJxalNmY2hQbnluaWdzL1VoU2loRitvR1NETGRlTDU3?=
 =?utf-8?B?eXVRZk05KzcvTTFqREJwT1RobEVCdGZZK05BdnlFWkFYVHE4T0cvSWx4aSt0?=
 =?utf-8?B?V3ZxLzcrREdFdlYwWVZtQXJ5SGZsRlMwNW9Tc3NSb0NoSDNoNjJ4aElyeHNy?=
 =?utf-8?B?RXVRT2dJUkk4MjNGYlphODUvQmh1cEI0WEFNSVo3am0xUW16NnluR1lBZmlv?=
 =?utf-8?B?U0xuMTMrb1gwVGZFSnFVemYxMmFqN3BHUUpYMVlrazk0MzVRK3d0YnBad001?=
 =?utf-8?B?MjJZVG9kbE5TQm41YmpxQ2ZDbmNZWmJsQytISDVRaDd4bXJ0My9CUFdGdUtD?=
 =?utf-8?B?a1N2bGJuNW1MME1ZVUVTSGxadDhYektVRzJUUDdUNTRWbWJySDJqUnBVd1dG?=
 =?utf-8?B?K2hFYmNYSXZuZVQwMHphVVA3SGRwK1I1VlByYkNTeDJjVm80c3VtTWRMMVI2?=
 =?utf-8?B?UnNZam1aa2RMcjFFZnBRSG15RHBod1M3MUFMZ0JVMDRRR0ZTcmduQytTdWxE?=
 =?utf-8?B?cDgzQXZkZkZqRndQVzJGY3lZMTdqNGkrd2ROWGFlRm1tMXU1Mkg1aXVXQUc5?=
 =?utf-8?B?OThITm9xaDE0a0EwQUlqSzRzd3Jia3ZhMDNwVzhKVjdEUERSMExOZUJzMWNG?=
 =?utf-8?B?MlFYL1cvenQzSVZkVFpZU3NwZVgyWis5ckFuMVBiQUlvNlB1ZUhvRmtmdHIx?=
 =?utf-8?B?ZlgvOHpIKzdpRlpGRC91RFhYeW82cG1vanl0VTBlbGpUWGZKLzRXQzlHNmdm?=
 =?utf-8?B?Y2xXQVMwWVk3MWpyMVg4ZnFlTVI1VExOS1gyWk9XZHozVGFJOFNyQlQ1TEJX?=
 =?utf-8?B?VmtDQ3IyWml5MklibG5XWitiSEU0b0Rvby9FczU4d0w4alZNaGt0bWNMQWNI?=
 =?utf-8?Q?c4MLYV6sqSWZlOBi11ndUywQm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4B15B2DD9970F4DAF1CA69BF4511477@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d031e5e-0e49-4607-b902-08dab6aead5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:30:57.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKD87F2MP83rqvQnalZ+WaJ115FeURXotrxcmQi5mW0/08Mt7gIJMg+ZtVfESJwVo9vFPHIkHQnx0Vamjoyzww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_103103_228080_A8921EA3 
X-CRM114-Status: GOOD (  18.08  )
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

T24gMTAvMjUvMjAyMiA4OjUwIEFNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBJbiBvcmRlciB0
byB0ZXN0IHF1ZXVlIG51bWJlciBjaGFuZ2VzIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhl
DQo+IGhvc3QgcmVjb25uZWN0cy4gQmVjYXVzZSBvbmx5IHdoZW4gdGhlIGhvc3QgZGlzY29ubmVj
dHMgZnJvbSB0aGUNCj4gdGFyZ2V0IHRoZSBudW1iZXIgb2YgcXVldWVzIGFyZSBhbGxvd2VkIHRv
IGNoYW5nZSBhY2NvcmRpbmcgdGhlIHNwZWMuDQo+IA0KPiBUaGUgaW5pdGlhbCBpZGVhIHdhcyB0
byBkaXNhYmxlIGFuZCByZS1lbmFibGUgdGhlIHBvcnRzIGFuZCBoYXZlIHRoZQ0KPiBob3N0IHdh
aXQgdW50aWwgdGhlIEtBVE8gdGltZXIgZXhwaXJlcywgdHJpZ2dlcmluZyBlcnJvcg0KPiByZWNv
dmVyeS4gVGhvdWdoIHRoZSBob3N0IHdvdWxkIHNlZSBhIEROUiByZXBseSB3aGVuIHRyeWluZyB0
bw0KPiByZWNvbm5lY3QuIEJlY2F1c2Ugb2YgdGhlIEROUiBiaXQgdGhlIGNvbm5lY3Rpb24gaXMg
ZHJvcHBlZA0KPiBjb21wbGV0ZWx5LiBUaGVyZSBpcyBubyBwb2ludCBpbiB0cnlpbmcgdG8gcmVj
b25uZWN0IHdpdGggdGhlIHNhbWUNCj4gcGFyYW1ldGVycyBhY2NvcmRpbmcgdGhlIHNwZWMuDQo+
IA0KPiBXZSBjYW4gZm9yY2UgdG8gcmVjb25uZWN0IHRoZSBob3N0IGlzIGJ5IGRlbGV0aW5nIGFs
bCBjb250cm9sbGVycy4gVGhlDQo+IGhvc3Qgd2lsbCBvYnNlcnZlIGFueSBuZXdseSBwb3N0ZWQg
cmVxdWVzdCB0byBmYWlsIGFuZCB0aHVzIHN0YXJ0cyB0aGUNCj4gZXJyb3IgcmVjb3ZlcnkgYnV0
IHRoaXMgdGltZSB3aXRob3V0IHRoZSBETlIgYml0IHNldC4NCj4gDQoNCldpdGhvdXQgbG9va2lu
ZyBpbnRvIHRoZSBzcGVjLCBpc24ndCBzb21lIHNvcnQgb2YgQUVOIHNob3VsZCBiZSB1c2VkIGZv
cg0KdGhpcyA/IHBsZWFzZSBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZyBidXQgZGVsZXRpbmcgYWxs
IHRoZSBjb250cm9sbGVycyANCmFuZCByZWxheWluZyBvbiByZWNvbm5lY3QgbWF5YmUgb3Zlcmtp
bGwgPyBpZiBpdCBkb2Vzbid0IGV4aXN0cyBpbg0KdGhlIE5WTWUgc3BlYyB0aGVuIHBlcmhhcHMg
d2Ugc2hvdWxkIHRoaW5rL3dvcmsgb24gaXQgdG8gdXBkYXRlIHRoZQ0Kc3BlYyA/IElzIGl0IHdv
cnRoIGl0ID8NCg0KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+
DQo+IEFja2VkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IC0tLQ0KDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

