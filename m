Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354A4C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a8XInRexXL6EiSy9fnOUC8Lmf9sI6pMbmhYaWxMrUQs=; b=Pob6XCPXt13/a+TK61Ocai/apv
	aSym7ia7PDoIQxMDRlN6PEu6fjk4zIP/VB+cdTnXEgw9qWC3s4xYD+yDY1LV5uDVOdlb9/7yvQvJ+
	4pQOAHGbLrnQHyXJ47z2aK0RadILQGTR3ACYBK/h3FyvX8W0HbwVukgiIq0/bkdJdbsZJo6R5PxvM
	P4mlRcVQfRbAJznLGSXsXFaiR4V+UebsqqoM9nt6kt92yYmxoxV5C/f08z0BFfPY4RQPUP6vcbbh1
	sGt3alZUmjulvESKBftjtc2Z+vQIDXAGcoSqd8T4JQ/w8JJR5wqsNCr/q4mKJxJ42M/pMqBRkiAjO
	xfXqU0oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyGLl-002BS7-IA; Mon, 06 Jun 2022 17:17:09 +0000
Received: from mail-bn7nam10on20615.outbound.protection.outlook.com ([2a01:111:f400:7e8a::615] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyGLj-002BQw-0q
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 17:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuNkxooIFAvd2Jklq2j/PFO5zZTardiiLAX20PrlVEdCFbqX3P2it1ZxVCm4BrGxI8G4CEDvSdFRWw1xdMeu45a95lyb7tFUzxTlt12FmxdNbdLCaSUTgN7gE3mPiudeZ3MYvzBgJD3cmjYxLLLyuD7Z0sKJ0bJQ49NFdEtwskpvaZ9yxzQTxT0e6RIVwloyg3rvGdN7dG2QqcB5h9ubdetkwmeA837qAaoQkmytP/v98KnfDFldBhPQkDsqAfGWpakNxmiKRxSnzBPFMItb5aiS+bicjw5YLqU5L/VT0DpdLhrR19w4c42ebmn6Bt3HMlcbVAQxRkwK9VivXr857g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8XInRexXL6EiSy9fnOUC8Lmf9sI6pMbmhYaWxMrUQs=;
 b=CzGIIrDLXBXCgPF/iV6sgCYb622FieRBJb9R19Pw/ARjboHxPWYn7HEGub2dSUIn2K8lOrP4iybXSaKN7Jw0sR/k1T90tGzTMNFRfln6R2D721zRPPeZRDFzQcNF4oCJ3KlgpNaIZCaZVZaiRJxgsW5OlSKmmAM1bJ22MZZDjv+7AL/pRaSN7rhnG1qPpEXs5s+QyynDd/Z+pF1nrSKxKglVTnszWUXKN8XGutYn9y7e+DhL/LCQBu9WTnRY7yWS44mSFSCjwVk9La0d5qnKkDGoBDJVjEtixqot6T4l6xZC8rImlYVIUutIy1bLCqfNgRpTPLjtN34J73gBqAfLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8XInRexXL6EiSy9fnOUC8Lmf9sI6pMbmhYaWxMrUQs=;
 b=oYtrJl3h4pWvfbXF4+Sz9yNpT6pBVYteZIBok3vqt0zU4g2emrsGB3tb3CbuEaccfRwjVCuJmnzvgtQWwzAMpPIXBcKldaslnX3d+YZ/3O9QES+piwVAJyeIByrwvYjj8DdTaZxr+FGAhAHPLyr1U/14o8+poPMI0u96WsNp4MYQn3d1DpYJwCXGY+tw8/5B9qrl20C7Ks+2aSy2z7gBm84K7NsNAIJjQpppKW8qKduxK0ZqBoS8NJ5Vgs27S3Q1zPc2E8SWFCn/fK3KPae0fY2uf3p2r9qIMnvfy2m8cSPSVUsL0x4wH0mWN8+vvnhvjiMUAVpN0o2y0s43P3m+Og==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1513.namprd12.prod.outlook.com (2603:10b6:4:d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 17:17:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 17:17:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@fb.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: add trouble shooting steps for timeouts
Thread-Topic: [PATCH] nvme-pci: add trouble shooting steps for timeouts
Thread-Index: AQHYecYTGWCzpboNuEC/Dm23kNv7Ca1CnuuA
Date: Mon, 6 Jun 2022 17:17:02 +0000
Message-ID: <4144bd92-670b-7cb2-3499-390d9c4f1897@nvidia.com>
References: <20220606165317.2633782-1-kbusch@fb.com>
In-Reply-To: <20220606165317.2633782-1-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4935f46-e9c8-471f-09f0-08da47e05f45
x-ms-traffictypediagnostic: DM5PR12MB1513:EE_
x-microsoft-antispam-prvs:  <DM5PR12MB15130262D1BCE13FD1816F52A3A29@DM5PR12MB1513.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ldjofAmwJq3eF9GcMAgJ3/E3dnvOMRGePrAdmtTAKZt82ucEW/GoHpWv8aD879XK6qltIrtUpVCPSjM1XbiUh2ggAZCPSNTQyEijPzsrRZZj2LDVRXnx1WrNHBQo/Xwo4Og0LYM2HMaGj1AFjAEUCX8PANtU8Th3tyuVhM2GVitCLL8wZW4WFcPtuTIjjTJcOZJDuHaCJmBPOVybyG6E1jg+yWeWhUfAbDUxGYR0cFB9nqf40Kn58/vNevqrX086vSizoXT+kOHv3t/2NQfubcIZi4SQgGugRIlMkFjisyef8X1QC4CudkEpXG42mPYRel6AMb/U/MFLuoSNIblPsudHZpKFbdRjmlPgQUfC+yrhXfZCbNVFy7Lzut3ssMeofTngAvrmSc0/OxVWUxCi4LbKgkwPVxl3+mbliUUgahY8cnFl/OyHCPfRWqQ+nuOc83eyhvhNOJPKMhidHN93O+o/z37IuF97Nhv4RDfG9c//0f7b46/ViWNcKHsoTpYz8NqlwOIHteqnW1a9bGtBCw3HB1JYniBDPkcQaoTTPWLol7rb3t84NpkVutBAwuzP24nVWwcP64z16+FMmuV2JMyE8nsovFDLUtPPZ8Jw7ty7joFGgjpwuo9wZRaZPTvxnfzI4ny9HU2PxymeMmFT1oyjhYXSkyxI5GEJ4qzbd48IHnUfOJEhgSH12XI+Mm6JsgdJl4+4OManzIoGTYVv0PxNRlSqrdtTlnr4qD8DclY49u3oXIMZU4tTpbJeHun2euKCkSO2hsiY87GPSIVr6w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(316002)(110136005)(6506007)(186003)(71200400001)(6486002)(2906002)(508600001)(83380400001)(54906003)(38100700002)(38070700005)(2616005)(122000001)(66946007)(66556008)(64756008)(66476007)(66446008)(36756003)(31686004)(4326008)(8676002)(76116006)(53546011)(91956017)(5660300002)(6512007)(86362001)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Z3FyV3hjNGhVcUJQS3hwYjFFZWNGRmUwcG4wKzZzZnNaOXVKWTJQVXZoNnQ2?=
 =?utf-8?B?SXlTRFhrVzY0SnRIZFE4dlY1akNwMlpLNndQRmdFbnR1MmdJRk01ZE9NdFpo?=
 =?utf-8?B?OFdjMW5YS0NLb2RqWmpiUDBvcWlZZ05nZzI2bnFmUDZnNm1XM3NVM29ySmx1?=
 =?utf-8?B?b1Yrc1ptNHdCY3JqQkM3ekhic00zaXpnOGZSUVBCYWo3NEFVdUVoVVZXZTJD?=
 =?utf-8?B?Vkcyd2t1WC9xU2lnV1ZaUVM0KzFHYWFmVlNhZHJKUUhheTBwMmFqOUdsVzZK?=
 =?utf-8?B?VWhmVWhRV25OY3prTUpEdG1SaVZlSTE3NDlzbFRHcVFHOStKbHlaZ0UxOGYx?=
 =?utf-8?B?dWFkVWs1bUM1Z0NtMmsrb1oxL0diZDJ1OHNabmZyM2VlN3BPTEJJc2VJOHRV?=
 =?utf-8?B?cjRnQ0M3Tkp4aUM1eFgxS1ZTMzZid1pzNW5UU25OUEZTSG5tVm1zZmRLd241?=
 =?utf-8?B?M1F3Ym1BNThJNHFhaXdiQ3g4VU03RmRXMzNuNExTK0swdlFDTXFQT0RZWFJ1?=
 =?utf-8?B?Qk1qTEgxRWZ5MUNFZkpkaEI5Sm9QOW5Sd29GVWhEWmU2VEpRNzVteElmS0pG?=
 =?utf-8?B?Nlc2Y2I2dlpjV253a0U3QzQ5dUpqRFBzQWZPMjQ3U0VmVVFWSEtBc010clJY?=
 =?utf-8?B?TnZHV0FTYXZsVjJVSHA3cVJ3a3RYUS9PUXR6QmFvdU03SWgxS0EwaWdXUi9Y?=
 =?utf-8?B?bFlFMUVCZXF0RjdVYmUrNndTdXlPUTI3ZXVNTGZkK1N6ZllnRHVhM2VYdlc0?=
 =?utf-8?B?b21NTDN1ZkFHWk9pOXkybzJyM3BteDBpWGtRSEhmUU9uR21oQTh5cjQ4NTQr?=
 =?utf-8?B?Q1h2NDZPTGg4RE1PMGl0bDZVU20vcXVMT2ZETERkdi9lY2xydENZbDcwWkFI?=
 =?utf-8?B?ckt0a3hpTWdmWWNBZHVUaGV6VHFsV0g1WUVxQ2ZNdENmY0gzYzk3YTY4KzJO?=
 =?utf-8?B?aUpsY1pXNWlvMXpQMkFRL0NMTm5aN21LcTIzdTlkYWQ0MGg3K05iWlpoellV?=
 =?utf-8?B?REhiUDlCK09wZ2Y3OVVPSEZoUFZOZS9YNVRSTjRmck45eWozaFRKVnJEQmZL?=
 =?utf-8?B?REZHOHZubWpwSm9iQjhKTE5jV21UYXdwb0plWCtjWFFuclcvVW9ZTE1nUTlx?=
 =?utf-8?B?LzdpckNxNWN0S1NjVytNMXUvNHNkTU9xbjR2eFdOOXFvNnRJYndwZ1Btd0Z3?=
 =?utf-8?B?ckgxc0dEVVN5L3kybUdmbi9iWTAyL2ZYSncwRmUxMG9NNXQvWGtkaXZxaHVP?=
 =?utf-8?B?MHREZ3lKZkVaMHVqWm1HTUZTMGZQNzVMZSttZ0g5anNhSnI3NWZpMWIrcnJj?=
 =?utf-8?B?NHBsUVBtYXFZUXFJcE1YamFRQUZCK2tFMUZiYWR5S1VJaXZUUXRUN3NpSUVy?=
 =?utf-8?B?Lzc0bjJPdWF3empFNHNaZGRhTS9kY3pWbVlqc01aY1h2Q1NkT29MRVdlSlRt?=
 =?utf-8?B?bmdoMFFKYXo3V3VrWHM4TWE4czJuSUJzLytibmV1VXFTbWZmK1ArL05UaWlv?=
 =?utf-8?B?a0czcmZtT2FFcXZuUW9zR1J6WmpBWUlMNmZNUy85YTdFQnpEbmtjSjBXOVRV?=
 =?utf-8?B?NlpIWWRXS0V6SU9NdTBpQWNEWHhBRzFtMnBpMXFGOUFrVG1YU09rbUI1WnVl?=
 =?utf-8?B?NXFHY3RubXdIMlJ1NVZ4TDdzVHl5dGxGNUE5TGpHOTBZZm1VeHJPbDE0M3FD?=
 =?utf-8?B?NFBtZVQrVFhXclRITUxSRDlmTng3cFZzeEZIdFpOVnlaTkZZTE0weWVpQ1FV?=
 =?utf-8?B?MEtvcWpSRlNZcGtjT0hWTjUzQnU1Y0RWY0h5UFlkTnNiVkFjRFNSeEhVL09Y?=
 =?utf-8?B?SmxpZHR4UmhTWEI0a3hmdmNSTmJ1OGU0YjNORll2RCthc0cyallVZ1VxS0lN?=
 =?utf-8?B?RXZheFFXd0Vyc21RV0RoUnBpWlFCdFZjSER6eXpCWXRhL1RkQlRwUm9kb2M5?=
 =?utf-8?B?bS9tK1dYRFZ3VDNVQXZTaGJVM3JFbDVlYU5hM25mWTZyeTRSL2pMNFV5a1lO?=
 =?utf-8?B?SExQTGNRdHlRTDhFS3hhUzgyQkxXZ1Vab0ZNWFl2VjVXZitaZTh0TDJvdklt?=
 =?utf-8?B?d1FLUHJKdVNHSE5TRXJMWXNCTFIwSFhoNmFsSE5nUkU5VzBxVlVIS0o1eFVD?=
 =?utf-8?B?Y0Fjd1cvVG1JcFU2Z3lGSSsxVnpYM3IxVVpsUVR1QTdSc2MrTk9nc3F5SHU4?=
 =?utf-8?B?ekV6U3oyL3BQRmtwOWd6TEw3YTF2VDAraHpCTHdzWjBSV1RmMndVU082VGVH?=
 =?utf-8?B?dWRNV0ZiNi9lZGF1RklwOTdsUktHdTFjQy83T1FhNkdTUGVEdUlKS3NYU2JI?=
 =?utf-8?B?TWpFdGdTOGhEMEJraHl1ZW05QlJiKzdUQmxoZ05vMTR1QlFsbXNyUXNKa0ZW?=
 =?utf-8?Q?l7Ou3T6yoPArdOP8ieSf4zsfGoxeOt6XUmEYH/mEo3CUb?=
x-ms-exchange-antispam-messagedata-1: nn64YYcJUa7kVQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FAE2DA971324C4E8DDBFD1EAB845390@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4935f46-e9c8-471f-09f0-08da47e05f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 17:17:02.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JMYhWv2ek6d3owffTbPbl5fZ4K1fhpuXqWvDNnLjmIpeVWR3LmUwUR2x5ZWbioKAEmMUt27UMc3SgQ0RE5tBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_101707_118553_81E17946 
X-CRM114-Status: GOOD (  10.35  )
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

T24gNi82LzIyIDA5OjUzLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gTWFueSB1c2VycyBoYXZlIGVuY291bnRlcmVkIElP
IHRpbWVvdXRzIHdpdGggYSBDU1RTIHZhbHVlIG9mIDB4ZmZmZmZmZmYsDQo+IHdoaWNoIGluZGlj
YXRlcyBhIGZhaWx1cmUgdG8gcmVhZCB0aGUgcmVnaXN0ZXIuIFdoaWxlIHRoZXJlIGFyZSB2YXJp
b3VzDQo+IHBvdGVudGlhbCBjYXVzZXMgZm9yIHRoaXMgb2JzZXJ2YXRpb24sIGZhdWx0eSBOVk1l
IEFQU1QgaGFzIGJlZW4gdGhlDQo+IGN1bHByaXQgcXVpdGUgZnJlcXVlbnRseS4gQWRkIHRoZSBy
ZWNvbW1lbmRlZCB0cm91Ymxlc2hvb3Rpbmcgc3RlcHMgaW4NCj4gdGhlIGVycm9yIG91dHB1dCB3
aGVuIHRoaXMgY29uZGl0aW9uIG9jY3Vycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1
c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gLS0tDQoNCkkndmUgc2VlbiB0aGVzZSByZXBvcnRz
IHdpdGggQ1NUUyA9PSAweGZmZmZmZmZmIG1hbnkgdGltZXMsDQpsb29rcyBnb29kLCB0aGlzIHNo
b3VsZCBoZWxwLi4uDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPg0KDQotY2sNCg0KDQo=

