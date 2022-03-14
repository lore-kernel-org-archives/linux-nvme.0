Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E90AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZLtZcE2N9vpJXIZYxO0FGSOwlXMQpYDlYWfkP4Rsus=; b=RWaGkxQFvnrPttgnjbYeljTOHz
	6Vc3lK3TWvrgpkOAccIVxZK4bhVIcTOyaK47PQnCGlSoebXcgvx6BX1+gRq5ckSy/HqChSW4vL5eU
	ChvL+FcAXwbE6sPsozXutiCXY2XCdsyio+nv6QtPDKcgaNL7kGWN5eo1JeRuL4RcXeZvPnYNrJVep
	c5m+RGDo21gvf1hF1UGP5a2ZAoa9DSvIlXNpmPuViWmHSnfJhrKH+hU8j2sKklf4gPXzHyCindJ9j
	QSBTG58amHmVDo+Ur5LOIggpRyRKR4geXDgkU+XJ5aURnYF6LacLajC1nR0F6q6AWNi8yo2bqFrUS
	V7hhvGtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTtfq-0077G5-E0; Mon, 14 Mar 2022 23:00:22 +0000
Received: from mail-dm6nam08on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::606]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTtfn-0077F3-Ve
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 23:00:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM8j3z+Y0KKcJmPfpAhzXfFrXLAIXBe4cVA5AZmWQw+xCWhw+Pf01YBvdOqPCjpbKwJfOOmTPYdDW9p7YWkSrL0QAB+ZvCxrfvhLKW8y62cXRjJrGrZq5lLzyhYhvQ/aj1tE9sbAjlINHe6J7JDEcO2VojK0aWC6/BHzWRDTRmAH9W8HAD+yvbAOtBm1TF3gtTGghIdFuMFCpZC6R5uLAZWsUIKy1GrhbCsJe5pGVxzkBQSIVgT0YZ3SwayvYLTOE2v631IvwFpV27WmikrHoTTyQyO18O8JB9j/XMhxvCIyg/BhvdyrWLodm86NOF1dRJ4Kyt1HNo2wQPKiF0b+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZLtZcE2N9vpJXIZYxO0FGSOwlXMQpYDlYWfkP4Rsus=;
 b=Im3d5ipWfKUUxiy5/JJyyZJ2qSgyCT8kWSnmFkOL0XOP+q6u+5b6MBjDGDQqtzlQs3D1xWr+nIY2OQEc4gY4teo1sOw+JCYFpmSgjXcdjOQ2D40UmvAWRFSTczoSGH3SaUBowXPAU3pypDS41sKuGnto87oaoib7yqGjvDLAQ805y69FREfA1JqW03BzapD1Zoc6Gribm3zbJtrnWU66ukvmGGdcBHxiflhhDq4au9Wb2z97p6/nUH01KqMjpvviyEJncMnfp5scYtn6y3xRijMZcYAzPU65iRFDCQutN9xm2/XMbmiY449scWmZeyHYhWbGOqlO6zid76Ykg7EMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZLtZcE2N9vpJXIZYxO0FGSOwlXMQpYDlYWfkP4Rsus=;
 b=ks7L0e5TYYmejLTgSdhMkK85TMKdMFaCPOlSTbftLJgt5WRnw/MYsEpxt0ZVO1wbEw83+/h0b0Bt30pickWiB1Ens2U6baQqEgpJBOaThZ1kLcYJlzwDrN0a3D/5M+BxOImJasYF0cfb3lSNdV9nJ+spTd+ydRl9cqXVb7eQPAlDpktX1hhPcGz+UVKGR7clB4XrgdX55bj5PWoHCfP+CW06lmpEqdjUoNXNyK61fA795rklWyHR7OMw4E0PKtnWRrsB+TERfio1FhwvMeSqK6J+BfJoMPCtpue8rBtGDTWbDPhEyQmWN3aiU9+R+i/6/e4MeNhdPcx/DHQjKWr6ZA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (52.132.153.28) by
 DM5PR12MB2549.namprd12.prod.outlook.com (52.132.208.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.24; Mon, 14 Mar 2022 23:00:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.026; Mon, 14 Mar 2022
 23:00:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvmet: nvme_excute_get_feat() cleanup
Thread-Topic: [PATCH 0/2] nvmet: nvme_excute_get_feat() cleanup
Thread-Index: AQHYM90vQR12UPwzW0yWETd0inPfoKy+hnqAgAEAVIA=
Date: Mon, 14 Mar 2022 23:00:15 +0000
Message-ID: <cc10b52a-00fe-43ff-07cb-fa9cd3a4bbf9@nvidia.com>
References: <20220309174308.41832-1-kch@nvidia.com>
 <20220314074249.GB4570@lst.de>
In-Reply-To: <20220314074249.GB4570@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc2d7eeb-ac1d-4442-8a71-08da060e6765
x-ms-traffictypediagnostic: DM5PR12MB2549:EE_
x-microsoft-antispam-prvs: <DM5PR12MB25495E08746D2AB1C572D9E0A30F9@DM5PR12MB2549.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9qMXP2zWpAAOa6oL5sQTM2qfwJ4UcMwYnW1pYPhS2s3K/vCb9ZrtOGXOeLrHOy1DgMrv4gYVPlOecS0l+n+T3/33aejfhvvd4PWRFoI8nHGgD3xf7Qwm8JVhqwF2rLKdkxe1EPXcYKK22tqN/ILpBS1zK8EUA4WQoFfFuatpF46EdrfGZ1a+iCyREBiV1lfC1SFvGr6nMS9DJGu4UhIfrSQwW6UYilURt+BVgiagKhytTSQ4WDcZ67qmbDMHez1Gu7ZVYXcsbyCzHSpKtdPUZtK4R35Vks2SopsGx4Yyik1aEBfLrnKsqHAIIF+jSKilO1509JRzZfyuB3JKwP/eqrPsQlXv3Y1j+tk4J5l1tBQuCZuO5ueW0R/1AKL3/qvH+McIdHcLuc4E6xcBtTRVajFjDD+5KloWbUxYPXr6wcTs97vmSsKFvIwHRlfKqm6gEyTxJ1ZAgI3rnncLsROpvoMlefQTt4CdULBdOmVyxFIDBJbUjW0UOfu4Uj1SYVUeKYlCC2gvYQkHzNyUvqi/k8F0zOjajUMFDmimqbOQoKn5seEUOqLeBroarBpe2iX3rHxWLaNkibLI+UxAPt2a2MFkcaL79NhGrmP/huTN0jTWU0ATf5fEWcCAMIG4LD0gywOgCkZHaEPhZVOjNEpq5FHc1vt/5eqThvUZeDp0tmTKLkd6xiyf+yko7/xk7nTroz1BRmKkx/1imq4b8nNip1zYbwhaYrybk+5be5Pj1KDU8DwH7gZn9nJpLhOu6kDGsF5fO3qofdGKAvxa+Jx2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66446008)(8676002)(64756008)(66556008)(122000001)(31696002)(38100700002)(186003)(83380400001)(53546011)(86362001)(26005)(6512007)(6506007)(2616005)(31686004)(76116006)(66946007)(508600001)(38070700005)(36756003)(6916009)(54906003)(91956017)(316002)(66476007)(6486002)(8936002)(2906002)(5660300002)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW1mZkx2aGRaZkFQM3pRenRITzZjNm80Qyttc2tmVVh4ZjdwR1FvSVZSSDlj?=
 =?utf-8?B?a1F3akZvZ29GaVFhZXp4OTR4NXdhZ1Bxb1psdlA3a1NvNERYSVMrVUgzNnl3?=
 =?utf-8?B?Z1dOYmNidGt0WW9qMmtqcGJ0azR5Znp2WDhoTzBKajg1NmpEL01VTHV3VHYz?=
 =?utf-8?B?TmU3Z1dCVnlwM0E2VW02S1VvYmREMEtSMWFEeS9ocktJYmlFcU9RQWdWRVVU?=
 =?utf-8?B?ajBWVmZwT251Z25DRWVOU2pJb1NCOEV6OUV1aUdNWFgxM3crRGU4WS9pQVIv?=
 =?utf-8?B?d09RdGExRWNvVVM4bWdVZ3BqVHI2c00ra0NSUFJNV05IWEdzdHFuandyQmht?=
 =?utf-8?B?RnhOSDg2VUJ6UDAyWFE0ckYrSk9hUEVRWHhJOVZrV2ZaVDhMY1JyT01DTlV6?=
 =?utf-8?B?SFI4WFhZRjgrVjN1SWlkM1FSb0VwcDJ3ZCtUZDBJNVJtSXU0d0ZDaTlhRmNp?=
 =?utf-8?B?TjZWMDJ4T25NVlpjWU1LNkp3RTB1U21DbnE4VE8vVUlxK1F0ZHJ0RGMrWktq?=
 =?utf-8?B?SUdQeU9yWVNsKytRWXB3Rk1wQ2hGZmNpT0ZQRGFpL3Q1dkVnNGVMdlM3c1Iy?=
 =?utf-8?B?clVxVDdSYlp3WnhzcWVSa1dLRmdlMXJwYkZZYWszTXppYU11YTlwT0lUbEZH?=
 =?utf-8?B?L3lYKzIyME05QjNyRElySkdBYkFuZHBmZDhaR0xhRzhHV1lONjhlQlBoKzZ2?=
 =?utf-8?B?VGlLNDJOSlliL2xxYnBnTFBHNmRibHRjNVdhbHZYMEl0RHpYWGt6d1dJdWNS?=
 =?utf-8?B?Z0pRNnJzUDFyd1RPQ1YwcmkySUhKdlBCT1pVZFYreEV6bU5CUDdrdGpJNm11?=
 =?utf-8?B?ajIzb0NDNHdBVS9qSXVqZ0FjUlNIcVE1ZlZxRjBDSWsxU3RNMWVEMWNRaFh3?=
 =?utf-8?B?MjNZV0o5L251UTFZcGNaTmc2NFJoWWREeTBqRExERlBkN0lrbks0T0ZLb29t?=
 =?utf-8?B?QXhIK2FCNkNFVStFdHRnUFRTdE1ibUFqT2gxb0IzeVV1TUFRMWFObHBjc0xu?=
 =?utf-8?B?ZVFRYUtYTXhMN2xEbnJ3cXdRMGJvLzd3ZUhYN2h4OFNMWUlpUEJYODI1cGcr?=
 =?utf-8?B?V1FaSWRLOCtWY1VEUjMvd3lJVmFHUkpiSDNTeVg3U3dwdU5PaVIrQkJQdDgx?=
 =?utf-8?B?TGRFd1VsMGppem1zNnJYb3NGdkNnSVFwMUgwUzFyZTIzVnRHSFVzc2dXaTJI?=
 =?utf-8?B?SGI5MWpIQ2h0dTlVN1FTU2JCK1dTMWZqcVByVCtJMGZqWnQ5dUJmb2xOditG?=
 =?utf-8?B?L2JBQ1J1VmtVanFwU0JrVFc0UElKRjZrc3NJYnVsQ3JORVM3Y0dZTnhoeFJy?=
 =?utf-8?B?UU1LMDdya2ZaT2FNUVJpU3F1cHFpR081ZDYxeFFCbFVNK3dMbW9VRjdEMHNn?=
 =?utf-8?B?aHR1VFN1UDNYNWJ5UkNVYUpaaFdpZjFQcVR3RWVqTGViOFM0N0FnaVA5cXpS?=
 =?utf-8?B?cE9RODcxdWcyT3NTbUlQWHkzK3FEK0N0TlFwM1R6YzFXa1k1WUNZdEh2ZytS?=
 =?utf-8?B?eGJzQlh0Yzg2ZjNBWFB0WGpRaDVvRnhQTk5zbnpRWnh1T2FQS3hhem9RZDJP?=
 =?utf-8?B?eFZQSlRJRHM4NTM3U3JNaGFLMkw1OU9RQTB6QmV5SEtsRVlKdjd4dElMZjVN?=
 =?utf-8?B?aVFrYU42ZUpFVkdNRmoxRVg5WXFENk1QQVZoK21WNlY5Zjl4M2xQajhudkE2?=
 =?utf-8?B?ZG1RZGVSSm54bWRqSnhRY290RjNLSEx6YWJWMjZtOENQODVDcDkyZTBRV2Vh?=
 =?utf-8?B?RFU1dTArTmZndm91aGZJdDA5QmVNZTRqQjhicHVWRkJYU3lESEFzdEJLR0Q5?=
 =?utf-8?B?S0lHaGxWcEVkVC9yWWo3YjNEa0VkNytLc0NsNHBMelU3Q24xNnJHY09CVW9q?=
 =?utf-8?B?YkpMUGpxcE1iTXRhcGpXL3AwMEV0ZWthV3hOOUszNUowc2RER2tXMXpKNWdC?=
 =?utf-8?Q?3eskDESiTUjjzD8mh9BmqLnRAdUl/W9E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CF27642206BD24C80DC80D0D5B6C304@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2d7eeb-ac1d-4442-8a71-08da060e6765
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 23:00:15.9581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTQfGT1Ahs19m7zN/q/tqBsqBafJFUDfhmiWKIN78CUmsssmMUoFIhm6AhMNRc3udL/2h69iLEXFvYuey00pbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_160020_043080_41B7C0E8 
X-CRM114-Status: GOOD (  14.14  )
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

T24gMy8xNC8yMiAwMDo0MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoYW5rcywNCj4g
DQo+IGFwcGxpZWQgdG8gbnZtZS01LjE4Lg0KPiANCg0KV2hlbiBJIHB1bGxlZCB0aGUgY2hhbmdl
cyB0b2RheSBpdCBkaWRuJ3Qgc2hvdyB0aGlzIHBhdGNoLXNlcmllcywNCmdpdCBIRUFEIGlzIHBv
aW50aW5nIHRvDQoNCiJudm1ldDogdXNlIHNucHJpbnRmKCkgd2l0aCBQQUdFX1NJWkUgaW4gY29u
ZmlnZnMiIDotDQoNCm52bWUgKG52bWUtNS4xOCkgIyBnaXRwdWxsdGhlaXJzDQp3YXJuaW5nOiBQ
dWxsaW5nIHdpdGhvdXQgc3BlY2lmeWluZyBob3cgdG8gcmVjb25jaWxlIGRpdmVyZ2VudCBicmFu
Y2hlcyBpcw0KZGlzY291cmFnZWQuIFlvdSBjYW4gc3F1ZWxjaCB0aGlzIG1lc3NhZ2UgYnkgcnVu
bmluZyBvbmUgb2YgdGhlIGZvbGxvd2luZw0KY29tbWFuZHMgc29tZXRpbWUgYmVmb3JlIHlvdXIg
bmV4dCBwdWxsOg0KDQogICBnaXQgY29uZmlnIHB1bGwucmViYXNlIGZhbHNlICAjIG1lcmdlICh0
aGUgZGVmYXVsdCBzdHJhdGVneSkNCiAgIGdpdCBjb25maWcgcHVsbC5yZWJhc2UgdHJ1ZSAgICMg
cmViYXNlDQogICBnaXQgY29uZmlnIHB1bGwuZmYgb25seSAgICAgICAjIGZhc3QtZm9yd2FyZCBv
bmx5DQoNCllvdSBjYW4gcmVwbGFjZSAiZ2l0IGNvbmZpZyIgd2l0aCAiZ2l0IGNvbmZpZyAtLWds
b2JhbCIgdG8gc2V0IGEgZGVmYXVsdA0KcHJlZmVyZW5jZSBmb3IgYWxsIHJlcG9zaXRvcmllcy4g
WW91IGNhbiBhbHNvIHBhc3MgLS1yZWJhc2UsIC0tbm8tcmViYXNlLA0Kb3IgLS1mZi1vbmx5IG9u
IHRoZSBjb21tYW5kIGxpbmUgdG8gb3ZlcnJpZGUgdGhlIGNvbmZpZ3VyZWQgZGVmYXVsdCBwZXIN
Cmludm9jYXRpb24uDQoNCkFscmVhZHkgdXAgdG8gZGF0ZS4NCm52bWUgKG52bWUtNS4xOCkgIyBn
aXRsb2cgLTMNCjE3MjAwMDdhOTFkOSAoSEVBRCAtPiBudm1lLTUuMTgpIE1lcmdlIGJyYW5jaCAn
bnZtZS01LjE4JyBvZiANCmdpdDovL2dpdC5pbmZyYWRlYWQub3JnL252bWUgaW50byBudm1lLTUu
MTgNCjk4MTUyZWI3MGZmZiAob3JpZ2luL252bWUtNS4xOCkgbnZtZXQ6IHVzZSBzbnByaW50Zigp
IHdpdGggUEFHRV9TSVpFIGluIA0KY29uZmlnZnMNCjczZDc3YzUzZmYzNCBudm1ldDogZG9uJ3Qg
Zm9sZCBsaW5lcw0KbnZtZSAobnZtZS01LjE4KSAjIGdpdCBsb2cgLTMNCmNvbW1pdCAxNzIwMDA3
YTkxZDkxNDZkNTM3ZGE2NjJlM2NlNTNlNjU2YjQ4NTBhIChIRUFEIC0+IG52bWUtNS4xOCkNCk1l
cmdlOiBlYzdkYWYwMTYxMTMgOTgxNTJlYjcwZmZmDQpBdXRob3I6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQpEYXRlOiAgIE1vbiBNYXIgMTQgMTU6NTE6MjcgMjAyMiAtMDcw
MA0KDQogICAgIE1lcmdlIGJyYW5jaCAnbnZtZS01LjE4JyBvZiBnaXQ6Ly9naXQuaW5mcmFkZWFk
Lm9yZy9udm1lIGludG8gbnZtZS01LjE4DQoNCmNvbW1pdCA5ODE1MmViNzBmZmZhZDkxMGVlN2M1
MTFiMTEwYWZlOThmMTYyZmM1IChvcmlnaW4vbnZtZS01LjE4KQ0KQXV0aG9yOiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KRGF0ZTogICBUdWUgTWFyIDggMTQ6NTY6NTggMjAy
MiAtMDgwMA0KDQogICAgIG52bWV0OiB1c2Ugc25wcmludGYoKSB3aXRoIFBBR0VfU0laRSBpbiBj
b25maWdmcw0KDQogICAgIEluc3RlYWQgb2YgdXNpbmcgc3ByaW50ZiwgdXNlIHNucHJpbnRmIHdp
dGggYnVmZmVyIHNpemUgbGltaXRlZCB0bw0KICAgICBQQUdFX1NJWkUganVzdCBsaWtlIHdoYXQg
d2UgaGF2ZSBmb3IgdGhlIHJlc3Qgb2YgdGhlIGZpbGUuDQoNCiAgICAgU2lnbmVkLW9mZi1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCiAgICAgU2lnbmVkLW9mZi1ieTog
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCmNvbW1pdCA3M2Q3N2M1M2ZmMzQyYmZh
MjNkYWVkZjQ0NzVjZGQwNjYxOGU0NDdiDQpBdXRob3I6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQpEYXRlOiAgIFR1ZSBNYXIgOCAxNDo1Njo1NyAyMDIyIC0wODAwDQoNCiAg
ICAgbnZtZXQ6IGRvbid0IGZvbGQgbGluZXMNCg0KICAgICBEb24ndCBmb2xkIGxpbmUgdGhhdCBj
YW4gZml0IGludG8gODAgY2hhciBsaW1pdC4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UNCiAgICAgaW4g
dGhpcyBwYXRjaC4NCg0KICAgICBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KICAgICBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4NCm52bWUgKG52bWUtNS4xOCkgIw0KDQo=

