Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B777BC433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Jan 2022 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XEZJ7Wxx+3jQHxSBiP8y9W9fAc59dMrKayhElfYcT90=; b=ht3fEkv2RMHhFvAvUGqXwxSKl+
	GtUoyv4RMZtQY9Q6d4M1Fi35avWDFoQ9qf1WXfArjn0IahNtIkfSmsCUOQtaBxSDArDaiYnQLNDUC
	f5g2ZVev03CIrwnSAmaUAjFh+Gj/pmSL5O9XSCA2cDFzZ1hSfkT9Ci1iFD3Xm8kQjoSY8pqNKzfQo
	Lh+irzhhZ2WzwpgiWZvnoUYdvQKzD/a/bhZNgwRDvFgf9hMX1+9T9bd8qVPp1YwpP3WFj2pnTVEJe
	lRhxeW7iZaTcbibv+p7lrKCz7ZLcfrdkqRuPyfLHuu2dHEwfBayInwrgY22uVN+wlLgGHUoP0jkOH
	Q5PbHVNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDmvD-004jWe-AJ; Sat, 29 Jan 2022 12:33:39 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDmm7-004fCL-Qg
 for linux-nvme@lists.infradead.org; Sat, 29 Jan 2022 12:24:19 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20T7uGe2014007;
 Sat, 29 Jan 2022 07:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=XEZJ7Wxx+3jQHxSBiP8y9W9fAc59dMrKayhElfYcT90=;
 b=nK7gVSxceK0vJRN91nUD/Vcadg8ElsZpMzmRY+RLlZgR82slmhqiWOf1wE0p4TnOhRkU
 6LbrkJPp6uk5VX1IFQqQtXEfIEfNCFsqgrYRwpVkDCiMMFdfeix2d97ZUqernMgZ7bwe
 SbnynFeCjBrTsbxdWKpHBdMWClU4490Ltu++vewIlca+z5KvWpovQskpXTvFYzQfDh95
 S6DhDftQAA0DpchwS3LgbDLf7hoB/8qiHwsy9BWMkUecUVZ9QJPBIM0OUgEgFoUkCTPF
 WvrJkEcwEU4WjcYTBVXkYoFLp/1L/iDhtqg0H2bimwgMfksTDiZEeQp/jbLEI61LNr3T IQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3dw1mh8dbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Jan 2022 07:23:57 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 20TCAVD6132989; Sat, 29 Jan 2022 07:23:56 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0b-00154901.pphosted.com with ESMTP id 3dw0r2a7vr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Jan 2022 07:23:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWfhJYpXQ2+2qvXtNw0hDutcidSdG3QBIY8LuE3G3NQc8a+MoM9xlWBmR/eWIXrbrnprteWahXcw01nHlDUJgzUwEl3cUOpJ0++PHuNK7JE1TQ376udrztWvfuE7sVmvHayGaUsi9qVUV9LOnQD0FRGrOhBAEs9BV6abmzrXr2aijsjNhZ9y05ImHm0SOpE16Rmk+bvXqvSaFrabtrlVek/XM67V4MKOgBxZFh+ElWlfnhYPp04Z4AS6FqUff7s4ZMXd5BPZrED1ry8TA6q4FL+losvoX/Y0AJsZqobqvm1SXxEeYrh569dovyGwdekUIadV9ZM9Q7pO4RSkF53m/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEZJ7Wxx+3jQHxSBiP8y9W9fAc59dMrKayhElfYcT90=;
 b=DnIgjOv8fSqtwVsRBDKw+4wWo9UijdE68OuVpiXdLOfbXP5vBLB7LoiNGSJM66ilNOUtwMBMYJaLMw5EEtWlbv+Hc7/7JOeWAeoT4ToIspAPW+q9U7kvm+aXgIvJ3UGEiTRCW1NcSb99Ix7nAXdeaQKWU7kIWb8U5ACZiuoMvIkDUMiY6/EKY5TvhPl4MUBU7GHA6XAiHJRYjr1ivMG8tbl5bootRbWy8/xZIFBZnV066yBN8BU83HU7hOYojGuPDEOjFDceeQel5TQ7lBXpDVtrr8+Bhg1vFZpsu4POu26cOm2gZHIS5RcvQmW9ZVpYOykT28GbOzJ3dM2mq9jLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by CO6PR19MB5433.namprd19.prod.outlook.com (2603:10b6:303:14c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Sat, 29 Jan
 2022 12:23:54 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9%4]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 12:23:54 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Topic: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Index: AQHYEfxP/F7s1ilTfEGG+nDhesZTRKx2nSQAgAA92YCAAALhIIAAkHMAgAFJADCAAEaUgIAAEf4QgACk24CAAD0u0A==
Date: Sat, 29 Jan 2022 12:23:54 +0000
Message-ID: <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
 <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
In-Reply-To: <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-01-29T12:23:52Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=68008cfd-3173-4d63-95bc-63a9c7b1170f;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 988ea64a-c80f-4130-c2d8-08d9e3223767
x-ms-traffictypediagnostic: CO6PR19MB5433:EE_
x-microsoft-antispam-prvs: <CO6PR19MB5433A6DE7B530E5781C4BF3EF2239@CO6PR19MB5433.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LlfT5Y5L7NZePemeNXcN8j4EH/AJqPkeb/FYusMbtjoUzYJkiVTJAi3/gvSJ9P4XWUCOZAuNwtg5O5DanCb5Wep3mifnHQYNxXMQf3yvZ4a6K+mo4DJShNx566f5SuLYrzBfDBJtpp9aOkDi3uGWeIzueZYgl5/y67YvoTNFBFIHxkfvBwPnEg1pWfCqwqFBiL3YKY3XfCyI6tQzlfQTR7CyiDJLf028KXIwDcbVLqW6ZO114Z8uXWJ7lnBXY3FRer97PDJ2Kw5YUfqtZ98bPMni6dvq5ufMnBvOcT8vCJgu+dTP+z6oWQ3q3T5Rh2F/AedBzjxQKtXAVcwXWmsdaMI+TglrnA8bJ61sIDYU1CRpVB1WOYMCFyBJDOxVHS0Mastl1hZFn/BovJybrWUsNUfyVdUmA/7xobT9J8VYjJO5BVgvKkk4bvnKy+7ufcF7N4du7U4X+xtgv1DvF59ZkI/EbCQ/3AzWhgqRCWkNvJw6Z6RjWZQJsW+L47755vgYUAFgu9efTtHybdwjnwRTzZxRXmRDSFImvT4rC0fZM6ScrIT4IYvmG7BE63gfeeOgrjZhiLTJEzdC9VG1ZRuICP1uoc0domdfYrjxEnGiTq8iVlofZDQFm7E/vETxKEDesNvSCNVPJ21La8ohEyKMg8TAD2ysf6MmSPpBFLgKEiCcMlkWoIy24FEDTAhcDT7eCODEVJQsxQJpPDoUUBgJxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(110136005)(9686003)(6506007)(7696005)(53546011)(38070700005)(38100700002)(82960400001)(122000001)(186003)(26005)(66574015)(33656002)(71200400001)(54906003)(316002)(786003)(83380400001)(76116006)(55016003)(52536014)(5660300002)(64756008)(66556008)(4326008)(66946007)(8936002)(8676002)(86362001)(2906002)(66476007)(66446008)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHJpVW9VNXFKRTdQbWh5TENsZGlOTFdGTGFOT0xxYWVhSEpZTHJlNFVkd0ds?=
 =?utf-8?B?N25YWVdsbERNK3ZMWnUwRUFjRTJjNmYrcEJuTFdybUoxV0FibzBrRnI0SmE2?=
 =?utf-8?B?azB1WjVrQTJxemd6R20vNll1UndPc0pDWk9MTkRqaWg1Sk1JRjlhdDdUQU5x?=
 =?utf-8?B?MHd5dDB1ajE2cWxPanpVSmxkS1pVMlNIendWaUtSUHh2OEt0OUJmOW5Lc29t?=
 =?utf-8?B?bGNlSUtBZnlQU0xQYWExNitFWGdkVHVnVSszRmExN2NJeUFBTWV6ZWszeUFz?=
 =?utf-8?B?cGxHRTJFbldIZjMvbHV1dnp0YW8zTzliOEVLS1ZjVUsyTUVRSEcwMzlvOEFm?=
 =?utf-8?B?dzlnSFZFV2tlUWNZeS80SzA5ZWZtTW1zL0JnbGhDZkJ3WjBoLzQyZzRkckVk?=
 =?utf-8?B?SFAyVEJpaVVid3doVjZEZE5oZUJiSEpUU3M5eWIzNElYMFlFeVNSUUFaUCtv?=
 =?utf-8?B?bHZQZ0k2dkQ4V0F4WEp5a2s3K0gzSlUxYVZYaFFnM3dDRmpCUURwWDk4VDYr?=
 =?utf-8?B?NEd5NGhwNWR5T1FxRGNQTGh2TjFIQUgvRFlFaG05L1FLMC9Vam4vZk52VFZN?=
 =?utf-8?B?NGY0TGhjYVcyT2pVSk4wa1NVVVRMYWhBcFBlK1prenBEM3dnUTE2RThUcU00?=
 =?utf-8?B?WHlJdDRoeWxNM1ZweHAzMUNiSUxhSk9RY2h2Q2pWUE4zcG1VSkdNZDlaTnlB?=
 =?utf-8?B?YlBjNGJ1VlZac3E4SUphazh3SThHem9WQmZoQjVFd2svUzYram9IZXVIL0Qx?=
 =?utf-8?B?eU85ZjY5Z2xpcFdyYnlTelo1aHd2REFHeUp6NmYwcHNzNnB1T1crck1mZEdu?=
 =?utf-8?B?cUdHbHY1eGF2VVIzTkVtSWhmK0xzd0ZzUEsydHBTMmlVTGZGOWkzdDgvdmpO?=
 =?utf-8?B?a2VUZENIRXlQS1JibnJTMlRMNFQ1N05BVkM0SzhZVGlxaU9qNWRHRHM2MTQv?=
 =?utf-8?B?ZEVRZVFBeXIxOXJnYWFYb3duQU8xZTUwK0VSZ2RKVUN6V3RYc0xVTm85TGY2?=
 =?utf-8?B?TkFUT01oWitsTnljbHZHc0pzZk0rOExZcTdhSnlKYjFENHE2NmtIR1Y5bUl1?=
 =?utf-8?B?Q1ZScjJiYno1dERrbmdoRTFpeVpNWW50OUYvQmgvWHl6TkpFZmE5SEVZRDBE?=
 =?utf-8?B?bDBVSjV2NzdXMXM3Z1doc0l4OHErOUlXV0VMWUlrVXFkNFZlaXNDUldSY05W?=
 =?utf-8?B?SVhoY3JTTVFQLzlrVFlkRDNHUVBHZktGNXdHajFGdXg4bE1ySjlpSFYvSkZk?=
 =?utf-8?B?NExuTVhMM0JxZTI5dTZ4eDY2akR6MW5GZ1V2M3l6a2tEc1h4VEt3TmR5NW0w?=
 =?utf-8?B?WlhtY292OThWNzQ1ZVBDTnpKMGpPbU40bVBsajJ3bkdKNWVtbmRYU1k2RDBT?=
 =?utf-8?B?L3VIa3pOZmxvZTQvUHlCaGVCdWJ0OVIvM0JQZ1pBakpFOENpWXNMYnZHQUU5?=
 =?utf-8?B?Vms0MGJ0ZGlLOHBtdkdKMUdkK2FzWUIwVUhYTTNNL2graklLN1E3VkxiVjg4?=
 =?utf-8?B?akx3d3QvR2VVUnc1RC94cWNmaVE3amxHUC9USW1hSHI0d0NSNGRRWjVFMVoy?=
 =?utf-8?B?TDI0WjlQejZjQWNQSFlES3A1MUV0c1p4aksycFQxSC8vLzJrbU5Tb3prL2g3?=
 =?utf-8?B?VmVxYWVKZUcyU1hZL0FKamUyeHgrR0NidjlWRno4TG9HQjJ3dDQ5VFJaejhu?=
 =?utf-8?B?cm1rUXZ2cEcwSngrUEQzb0VKS1BUSmpDNkxZQW1HVzhxckNQOFVheTFjNHRY?=
 =?utf-8?B?WUR6M21nMHUxeE90QXNDN2R5cWZkRkZEUzBlWkJ5NEZyc3pHWDRySXVwRlpT?=
 =?utf-8?B?QlZqaU4vVlhkTnJWOGJsanRCcUl4YmNEMGxQeUo4SE5vZTA5SFF5UDdrK2JY?=
 =?utf-8?B?RTE5VnJWRUxhbURDVGlQa0p0NFB3TXNOY01FS0dsb0dHTk1pYU9uRTJCR2FC?=
 =?utf-8?B?T3BWZlZLbS9zMjNDdmZvbmV4eTBJS1g4WE8vMkpXRTlmcDMzajRQRUJ0aUZZ?=
 =?utf-8?B?blV6UVJmNGkrZzFlQ0MvK2JXb2pNWmZhYVlUbHVqZVNqb2ExczVjN3BDVXA3?=
 =?utf-8?B?eG5FVFNqNnZFUmFhbXRMemR3Q1BuWXdISlc5cTBKM3dQREtTV3pXek43SFE4?=
 =?utf-8?B?QkU3RnVRM2xKZ1JtNjlUVUJxT04wa1h5U21Yb3VYVU9GckRPMFFOQ3RLdlhB?=
 =?utf-8?B?aEF0bzFnZmZtR2JzanBUZmxObnZXU3I5WUdwbUNRVkhZbE9Wa2o1aWc3ZXhi?=
 =?utf-8?B?Wmx6NDVuWGhWNkFQdGRjQjZOa213PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988ea64a-c80f-4130-c2d8-08d9e3223767
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 12:23:54.5701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxF1sG+DChfe7ntMpvdZfMZBlyZgb0aE/aluyb/RKdbEWvndO3PCjOCU73N9OsbyT2F5CohFnAHISDIomhZA43B0BMYTfutuNEYKvQda5I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5433
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-01-29_07:2022-01-28,
 2022-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=800
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201290074
X-Proofpoint-ORIG-GUID: zKsJDGOdCZj9to-0lCgaNWY6VAyyDo81
X-Proofpoint-GUID: zKsJDGOdCZj9to-0lCgaNWY6VAyyDo81
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=893
 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201290074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220129_042416_032397_4F83C1F5 
X-CRM114-Status: GOOD (  35.18  )
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

PiANCj4gT24gMS8yOS8yMiAwMDowMiwgQmVsYW5nZXIsIE1hcnRpbiB3cm90ZToNCj4gPg0KPiA+
PiBPbiAxLzI4LzIyIDE4OjU1LCBCZWxhbmdlciwgTWFydGluIHdyb3RlOg0KPiA+Pj4+Pj4+IFdv
dWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byBkZWxlZ2F0ZSBleHBsaWNpdCByZWdpc3RyYXRp
b24gdG8NCj4gPj4+Pj4+PiB1c2Vyc3BhY2UgKGllIGxpYm52bWUvbnZtZS1jbGkpLCBhbmQgbGVh
dmUgdGhlIGtlcm5lbCBvdXQgb2YgaXQ/DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSXQgd291bGQuIFRo
ZXJlIGlzIG5vIHJlYXNvbiB3aGF0LXNvLWV2ZXIgdG8gcGxhY2UgYWxsIHRoaXMNCj4gPj4+Pj4+
IHJlZ2lzdGVyIHN0dWZmIG5lZWRzIHRvIGxpdmUgaW4gdGhlIGtlcm5lbC4gV2UgaGF2ZSBhIHdh
eSB0bw0KPiA+Pj4+Pj4gcGFzc3RocnUgY29tbWFuZHMgc28gaXQgY2FuIGFuZCBzaG91bGQgbW92
ZSB0byB1c2Vyc3BhY2UuDQo+ID4+Pj4+DQo+ID4+Pj4+IEkgd2lzaCBpdCBjb3VsZCBiZSBkZWxl
Z2F0ZWQgdG8gYSB1c2VyLXNwYWNlIGFwcCwgYW5kIGluIGZhY3QgdGhhdA0KPiA+Pj4+PiB3YXMg
bXkgb3JpZ2luYWwgZGVzaWduLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBVbmZvcnR1bmF0ZWx5LCB3aGls
ZSB0ZXN0aW5nIEkgcmVhbGl6ZWQgdGhhdCB0aGUga2VybmVsIGNhbg0KPiA+Pj4+PiBhdXRvbm9t
b3VzbHkgcmVjb25uZWN0IGFuZCB1c2VyLXNwYWNlIGFwcHMgYXJlIGNvbXBsZXRlbHkNCj4gdW5h
d2FyZQ0KPiA+PiBvZiBpdC4NCj4gPj4+Pj4NCj4gPj4+Pj4gRm9yIGV4YW1wbGUsIGxldCdzIHNh
eSB0aGUgbmV0d29yayBnb2VzIGRvd24gbW9tZW50YXJpbHkuIFRoZQ0KPiA+Pj4+PiBrZXJuZWwg
dGhlbiB0cmllcyB0byByZWNvbm5lY3QuIE9uY2UgaXQgc3VjY2Vzc2Z1bGx5IHJlY29ubmVjdHMg
aXQNCj4gPj4+Pj4gZG9lc24ndCB0ZWxsIGFueW9uZSBhYm91dCBpdC4NCj4gPj4+Pg0KPiA+Pj4+
IFRoZW4gYWRkIGEgdWV2ZW50IG9uIHRoZSBjb250cm9sbGVyIGRldmljZS1ub2RlLiBGcm9tIHRo
ZXJlIHlvdQ0KPiA+Pj4+IHNob3VsZCB0cmFwIGl0IGFuZCBkbyB3aGF0IHlvdSBuZWVkIChleGFj
dGx5IGxpa2UgaG93IGRpc2NvdmVyeSBsb2cNCj4gPj4+PiBjaGFuZ2UgZXZlbnRzIGFyZSBoYW5k
bGVkKS4NCj4gPj4+Pg0KPiA+Pj4+IEJUVywgSSBhbHNvIGRvbid0IHVuZGVyc3RhbmQgd2h5IHRo
ZSBob3N0IG5lZWRzIHRoaXMgcmVyZWdpc3RyYXRpb24NCj4gPj4+PiBvbiByZWNvbm5lY3QsIGJ1
dCB0aGF0IGlzIGJlc2lkZXMgdGhlIHBvaW50Lg0KPiA+Pj4NCj4gPj4+IFRoZSBmYWN0IGlzIHRo
YXQgd2hlbiBjb25uZWN0aXZpdHkgaXMgbG9zdCBhbmQgcmVzdG9yZWQsIHdlIGRvbuKAmXQNCj4g
Pj4+IGtub3cgd2hldGhlciBjaGFuZ2VzIGhhdmUgb2NjdXJyZWQgb24gdGhlIGhvc3QgKGUuZy4g
bWF5YmUgdGhlDQo+ID4+PiBzeW1ib2xpYyBuYW1lIHdhcyBjaGFuZ2VkIHdoaWxlIGNvbm5lY3Rp
dml0eSB3YXMgbG9zdCwgZXRjLikgYW5kDQo+ID4+PiB0aHVzIHJlZ2lzdHJhdGlvbiBtdXN0IGJl
IHJlYXBwbGllZCBldmVyeSB0aW1lIHRoZSBob3N0IHJlY29ubmVjdHMNCj4gPj4+IHRvIG1ha2Ug
c3VyZSB0aGVyZSBpcyBubyBzdGFsZSBpbmZvcm1hdGlvbiBhdCB0aGUgZGlzY292ZXJ5IGNvbnRy
b2xsZXIuDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4+IEJ1dCBsZXQncyBzYXkgdGhlIGtlcm5lbCBk
b2VzIHNlbmQgYSBzaWduYWwgdG8gdXNlci1zcGFjZSBvbiBhDQo+IHJlY29ubmVjdC4NCj4gPj4+
Pj4gV2hhdCBpZiB0aGVyZSBpcyBubyB1c2VyLXNwYWNlIGFwcCB0byByZWNlaXZlIHRoaXMgc2ln
bmFsPyBJJ20NCj4gPj4+Pj4gdGhpbmtpbmcgb2YgdGhlIGNhc2Ugd2hlcmUgb25lIHVzZXMgbnZt
ZS1jbGkgdG8gc2V0IHVwIHBlcnNpc3RlbnQNCj4gPj4+Pj4gY29ubmVjdGlvbnMgdG8gZGlzY292
ZXJ5IGNvbnRyb2xsZXJzLiAgSW4gdGhhdCBjYXNlIHRoZXJlIGlzIG5vDQo+ID4+Pj4+IGFwcCB0
byBzZW5kIHRoZSBleHBsaWNpdCByZWdpc3RyYXRpb24gb24gYSByZS1jb25uZWN0Lg0KPiA+Pj4+
DQo+ID4+Pj4gVGhpcyBhcmd1bWVudCBkb2VzIG5vdCBqdXN0aWZ5IGFkZGluZyBmdW5jdGlvbmFs
aXR5IGluIHRoZSBrZXJuZWwNCj4gPj4+PiB0aGF0IGRvZXNuJ3QgYmVsb25nIHRoZXJlLiBJZiB3
ZSB3ZXJlIHRvIGZvbGxvdyB0aGlzIGFyZ3VtZW50IHdlDQo+ID4+Pj4gd291bGQgYmUgcGxhY2lu
ZyBldmVyeXRoaW5nIGluIHRoZSBrZXJuZWwuIElmIHNvbWVvbmUgd2FudHMgdGhpcw0KPiA+Pj4+
IGZ1bmN0aW9uYWxpdHksIGhlL3NoZSBuZWVkcyB0byB1c2UgdGhlIHRvb2xzIHJlcXVpcmVkIGZv
ciBpdCB0byB3b3JrLg0KPiA+Pj4NCj4gPj4+IE9rLCBIYW5uZXMsIFNhZ2ksIENocmlzdG9waCwg
ZXQgYWwuIEkgZ290IHRoZSBtZXNzYWdlIGxvdWQgYW5kIGNsZWFyLg0KPiA+Pj4gRXhwbGljaXQg
UmVnaXN0cmF0aW9uIGRvZXMgbm90IGJlbG9uZyBpbiB0aGUga2VybmVsLiBBbmQsIGFzIHlvdQ0K
PiA+Pj4gc3VnZ2VzdGVkLCB0aGUga2VybmVsIG5lZWRzIHRvIHNlbmQgYSB1ZXZlbnQgd2hlbiBp
dCBsb3Nlcw0KPiA+Pj4gY29ubmVjdGl2aXR5IGFuZCBhbm90aGVyIHVldmVudCB3aGVuIGNvbm5l
Y3Rpdml0eSBpcyByZXN0b3JlZC4gVGhpcw0KPiA+Pj4gd2lsbCBhbGxvdyB1c2Vyc3BhY2UgYXBw
bGljYXRpb25zIGtub3cgd2hlbiB0byByZWFwcGx5IHJlZ2lzdHJhdGlvbg0KPiA+Pj4gKGlmDQo+
ID4+IG5lZWRlZCkuDQo+ID4+Pg0KPiA+Pj4gSSdtIG5vdCBhIHVldmVudCBleHBlcnQgKGF0IGxl
YXN0IGhvdyB0byBzZW5kIHVldmVudHMgZnJvbSB0aGUga2VybmVsKS4NCj4gPj4+ICAgRnJvbSB3
aGF0IEkgcmVhZCwgdGhlcmUncyBvbmx5IGEgbGltaXRlZCBzZXQgb2YgdWV2ZW50cyBkZWZpbmVk
IChpLmUuDQo+ID4+PiBhZGQsIHJlbW92ZSwgbW92ZSwgb25saW5lLCBvZmZsaW5lKS4gVGhlIG52
bWUgZHJpdmVyIGFscmVhZHkgdXNlcw0KPiA+Pj4gdGhlIHVldmVudHMgImFkZCIgIGFuZCAicmVt
b3ZlIiB3aGVuIG52bWUgZGV2aWNlcyBhcmUgImNyZWF0ZWQiIGFuZA0KPiA+Pj4gImRlbGV0ZWQi
IHJlc3BlY3RpdmVseSAuIFdlIGFsc28gaGF2ZSAgdGhlICJjaGFuZ2UiIGV2ZW50IHRoYXQgaXMN
Cj4gPj4+IHVzZWQgd2hlbiB0aGVyZSdzIGEgY2hhbmdlIGluIHRoZSBMb2cgUGFnZXMuIE1heSBJ
IHN1Z2dlc3QgdGhhdCB3ZQ0KPiA+Pj4gdXNlIHRoZSAib2ZmbGluZSIgYW5kICJvbmxpbmUiIGV2
ZW50cyB3aGVuIGNvbm5lY3Rpdml0eSBpcyAibG9zdCIgYW5kDQo+ICJyZXN0b3JlZCINCj4gPj4+
IHJlc3BlY3RpdmVseT8gUGxlYXNlIGxldCBtZSBrbm93Lg0KPiA+Pj4NCj4gPj4NCj4gPj4gSSBn
dWVzcyB3ZSBhbHJlYWR5IGhhdmUgdGhhdDsgY2YgY29tbWl0IGY2ZjA5YzE1YTc2NyAoIm52bWU6
IGdlbmVyYXRlDQo+ID4+IHVldmVudCBvbmNlIGEgbXVsdGlwYXRoIG5hbWVzcGFjZSBpcyBvcGVy
YXRpb25hbCBhZ2FpbiIpLg0KPiA+Pg0KPiA+PiBXaGVuIG11bHRpcGF0aCBpcyBhY3RpdmF0ZWQg
KGFuZCBJIGd1ZXNzIHRoYXQgd2lsbCBiZSBmb3IgbnZtZS10Y3ApDQo+ID4+IHlvdSB3aWxsIHJl
Y2VpdmUgYSAnY2hhbmdlJyB1ZXZlbnQgd2hlbmV2ZXIgYSBwYXRoIGdldHMgcmVpbnN0YXRlZC4N
Cj4gPj4NCj4gPj4gU28gdGhhdCB3aWxsIGJlIHRoZSB0aW1lIHdoZW4gYW4gZXhwbGljaXQgcmVn
aXN0cmF0aW9uIHdpbGwgbmVlZCB0byBiZQ0KPiByZWFwcGxpZWQuDQo+ID4+DQo+ID4NCj4gPiBK
dXN0IHdhbnQgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZC4gV2hlbiB0aGUgY29ubmVjdGlvbiBp
cyBsb3N0IHRoZQ0KPiA+IGtlcm5lbCBzZW5kcyBub3RoaW5nLiBXaGVuIHRoZSBjb25uZWN0aW9u
IGlzIHJlc3RvcmVkIHRoZSBrZXJuZWwgc2VuZHMgYQ0KPiAiY2hhbmdlIg0KPiA+IHVldmVudC4g
QW5kIHdoZW4gdGhlIExvZyBQYWdlcyBoYXZlIGNoYW5nZWQgdGhlIGtlcm5lbCBhbHNvIHNlbmRz
IGENCj4gImNoYW5nZSINCj4gPiB1ZXZlbnQuDQo+ID4NCj4gDQo+IFllcy4NCj4gDQo+ID4gSXQg
d291bGQgYmUgbmljZSB0byBoYXZlIGRpZmZlcmVudCBldmVudHMgYmVjYXVzZSBpZiB3ZSB1c2Ug
dGhlICJjaGFuZ2UiDQo+ID4gdWV2ZW50IGZvciBib3RoICJsb2cgcGFnZXMgaGF2ZSBjaGFuZ2Vk
IiBhbmQgImNvbm5lY3Rpb24gaGFzIGJlZW4NCj4gPiByZXN0b3JlZCIsIHRoZW4gdGhlIHVzZXIt
c3BhY2UgYXBwIHdpbGwgaGF2ZSB0byBzZW5kIGJvdGggYW4gImV4cGxpY2l0DQo+ID4gcmVnaXN0
cmF0aW9uIiBhbmQgYSAiZ2V0IGxvZyBwYWdlIiB3aGVuZXZlciBpdCByZWNlaXZlcyBhICJjaGFu
Z2UiIHVldmVudC4NCj4gPiBJdCB3b27igJl0IGJlIGFibGUgdG8gdGVsbCB3aGF0IHRoYXQgImNo
YW5nZSIgdWV2ZW50IGlzIGZvci4NCj4gPg0KPiANCj4gQXUgY29udHJhaXJlLg0KPiBDaGFuZ2Ug
ZXZlbnRzIGNvbWUgd2l0aCBhIGZ1bGwgcGF5bG9hZCBkZXRhaWxpbmcgb3V0IHdoYXQgdGhlIGV2
ZW50IGlzIGFib3V0Lg0KPiBJbiB0aGUgY2FzZSBvZiBhICdsb2cgcGFnZSBjaGFuZ2VkJyB1ZXZl
bnQgdGhlIGV2ZW50IHBvaW50cyB0byB0aGUgY29udHJvbGxlcg0KPiBkZXZpY2UsIGFuZCBwYXls
b2FkIGlzIGEgc3RyaW5nICdOVk1FX0FFTj08YWVuIG51bWJlcj4nLg0KPiBJbiB0aGUgY2FzZSBv
ZiB0aGUgJ3BhdGggcmVpbnN0YXRlZCcgdWV2ZW50IHRoZSBldmVudCBwb2ludHMgdG8gdGhlIGJs
b2NrDQo+IGRldmljZS4NCg0KVGhlcmUgaXMgbm8gKmJsb2NrIGRldmljZSouIEl0J3MgYSBjb25u
ZWN0aW9uIHRvIGEgRGlzY292ZXIgQ29udHJvbGxlci4gDQoNCj4gDQo+IFNvIGl0J3MgZWFzeSB0
byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gdGhvc2UgdHdvLg0KPiANCj4gQ2hlZXJzLA0KPiANCj4g
SGFubmVzDQo+IC0tDQo+IERyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVs
IFN0b3JhZ2UgQXJjaGl0ZWN0DQo+IGhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICs0OSA5MTEgNzQwNTMgNjg4DQo+IFNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgs
IE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZyBIUkIgMzY4MDkNCj4gKEFHIE7DvHJuYmVy
ZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXINCg0KSW50ZXJuYWwgVXNl
IC0gQ29uZmlkZW50aWFsDQo=

