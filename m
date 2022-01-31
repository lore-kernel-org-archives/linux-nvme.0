Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3264C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R9JDXxcaHQuw2RGuWzsM7UIPa+/w2iSo2NaweFaZzOw=; b=JxCqhQpK2MylCSRXHK3D0QOQx0
	9Rid+Xc8PUask89AWEWZxlb9G56cJvt4GDCUiN1saybv/vrObpcoZiUstjaoJEEc7Is/UXOGGbtG5
	QKi3iUkAp5KbP+A/n02QScefx0hKzalHn8X8MXMjdBKo0XnH14JwuUe92K6elgtEyF2LFO82KwHip
	RRYQdLR5d8MnuQ4BXH4riDTFf/kuRMz0UYFG+u5TVp8hDKw1qD/dtBZsvOFfWq/HmgLCAs5/9gLp9
	Kb4ydLNLe99UffgHO8z52Js+NQKZEnsbEVQgattbMro0zK2p3zDLdBIpm+3z1LzrB5sOl4uRtFjMJ
	PNu/C3Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEVUO-009Glv-BW; Mon, 31 Jan 2022 12:08:56 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEVUL-009Gkh-Lk
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 12:08:55 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20V1m8TT004044;
 Mon, 31 Jan 2022 07:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=R9JDXxcaHQuw2RGuWzsM7UIPa+/w2iSo2NaweFaZzOw=;
 b=JETX0CZZUniyPrhvqj4LlGuJBFAbddAxl939QXi6aoHdKCOjBVfO6mriMO+rl8o5G1El
 nX7On9EbjzPxDfTVlOcasIqZOkEB4m1015wQ+c4bEHH1SpOWOn42sKJrco2zwCm1HhSD
 MvhSXFUsSADT/dPBwh/EO7Ho+wXE4hQKKU5z2hecJ06Fdu10jKurxVie94Z95iRjKbIP
 0jEJ63cjIxkVcp06gNmA/O04h6z+9UXSEbXl3NPd8G2Ngr1WbJZgE5RzOyCW2UbEr4+D
 0YMVXyPOqOFgtnZAVNr6++m2GiS57g2QlE71lkvuSim1R89n/rNOGc2IAT5wIJs2yzYh 6A== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3dw34t4vc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jan 2022 07:08:32 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 20VBxlBb019741; Mon, 31 Jan 2022 07:08:31 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by mx0b-00154901.pphosted.com with ESMTP id 3dwktudbey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Jan 2022 07:08:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4d5qLeO2tQqO/2Jmgk9xWEQQTuJw4Q9AdTfK91u383Q4RQRGyCAaChL4PFCp+xfmt13yhPfHAFNMHEAY3m2xqFFFzkySlmA2i6QCdGy6QpsNXM6LQJnijD7IF/k8ThQsqtxPeWL77VCQC9UnrCD7d7fVORY3olWzehQw7Q2Hdr3gsua/fZaTKcFjrCBRdF40vWbvIvooe/yCNr4B7vlGHjFqMpj45uTAwBLDt78/u4GXa4SFQ3gNQl/cvnZLsyTejtlGJ54mMzja6Qb/5cLeNLGOdur1bbpwtJO9QHVmv+wyh88dj+KecuuaxtrCudjVPTbcNg7Ngg/b4jI5jMPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9JDXxcaHQuw2RGuWzsM7UIPa+/w2iSo2NaweFaZzOw=;
 b=m2W9njJAQD/dIskv39j7wmAMH2+kF5KonmOzGJ9UJDlqG7hSGKPByQBRmkYlOd9z4dhqPJBET5BOqdlLiEyiHPVgCwQbBfk1B7Too65hYdxHw7vzPdfHQi6vmxr8pO4MBd/n7VndPZcRnUUNPiv3OHLUaReSiGCfIBQahBBoYq81W9A1kXMbYxHd7apabT/xruQS1IhRgSvpKH7nnwEVNf+lcJ59e//7t2tG4OhFrkB4E4MwPch5EYfMh/CEzPTEIBZ+FG36PlHyUyLe78g72d4Btk4Iu3eZvxyXwgviMWz5Q0FwzLbVvBw1KHWgs44oL0T5XiuUHAWDB/curqDMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by DS7PR19MB4535.namprd19.prod.outlook.com (2603:10b6:5:2c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Mon, 31 Jan
 2022 12:08:29 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9%4]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 12:08:29 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Topic: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Index: AQHYEfxP/F7s1ilTfEGG+nDhesZTRKx2nSQAgAA92YCAAALhIIAAkHMAgAFJADCAAEaUgIAAEf4QgACk24CAAD0u0IAABt+AgAFO2wCAAciAYA==
Date: Mon, 31 Jan 2022 12:08:28 +0000
Message-ID: <SJ0PR19MB4544E634C5B347F231783B20F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
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
 <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <e4c48b97-8f79-a373-96ea-13286632624b@suse.de>
 <13c327cf-8f04-e005-298f-0e43bb39b89e@grimberg.me>
In-Reply-To: <13c327cf-8f04-e005-298f-0e43bb39b89e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-01-31T12:08:26Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=2b9a5654-ab65-4a6e-84aa-fbb779013524;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b7dae7d-72a0-4f86-1a43-08d9e4b26475
x-ms-traffictypediagnostic: DS7PR19MB4535:EE_
x-microsoft-antispam-prvs: <DS7PR19MB45359503369F89E7284DA015F2259@DS7PR19MB4535.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2uBWURXe/eZMkC0tjFFhLSSOkDRO5X916qXEMjeSxtS4jALaZxcAT2N4DAkJiw6DZMbk1xDMZA7yLihJr3VVa2Zof36/xUCcHurz16TFQdKo1t3fJyWxHN592x5iQHE7WUvyxSP5/hcjeEGHw53G31QWOJP+X6DR0SnPAY2kgYtqZoSB/QtADgKM7bzQjcLHgxGjYqlYXF7APZbUld7HK8WT11/TMTF7Ji35hIgt5qRAuWIeIMs2ctxWfihpVH96KEP3GNWe970Y1XrJtZjEqA/LkEXODtopUCo8td587cPiRHSjwnid1W3rK8AzSqp1bdGyEYR11gP4O0ub0LlTYIPDIqZ7Rp72tAtxDJq/A1YEJWjeVL1YhCQW6Ow8X0dh/YdftX+wmxJWSHtqBYHUJ/0dwOQrMQtBwO4CLtap7OJYgTUKfg8p6RBVyHg3ypdNmOOGMoM0spbYnqsrNm2HV+UelnlgLG8P3NMoHys9eqCODymxnjs9HQTN3+BcITE2y10mXYdAnuZ1Rs/O0aCMPG7+Anu/hW/xKLfrzN3Yix/9NpekgJo6y3gUdpDMI4JNIAVLAlLBSiMQZG/fusU0vLjIajP8Iv4aeu9pOc4HlOzbdi0LyP7PJkzEfAgJC3CPMr3GaVOk3pXSPE8OUAUJl92gye2MhU5MGF/VG6nZDmwoU3aWgM7Yrm5R4RYeVE1nruJgrpaSq63gEXp+wymt8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(7696005)(9686003)(6506007)(33656002)(86362001)(26005)(186003)(71200400001)(64756008)(38100700002)(66556008)(66476007)(66446008)(38070700005)(8676002)(4326008)(8936002)(83380400001)(508600001)(122000001)(52536014)(66946007)(2906002)(54906003)(110136005)(786003)(316002)(76116006)(82960400001)(5660300002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTkyUjJFWGwwYnVjMUloWWVxL2xOYURNbzltV2RUVEd5bDdQREdkSTVReFA3?=
 =?utf-8?B?TTdkSW0xb0N3VXZPTCtUQ1VuZE9oOGlVWWw5eG1RMHJMTFdyRTRSU3lncTZG?=
 =?utf-8?B?cFpUSWY1cUF3U1dQa2NlY0NVNmpWYXVybEhtV1NjVmo1TkYvRE84a2JaRjRt?=
 =?utf-8?B?TjZEbVdHOTBWdDl2UGtQZ0lvZ2dLWUVQYitFblNISklrdFVrc2ZNS3ZPS21K?=
 =?utf-8?B?WjJ5YkQxREJ6RHN2enZLUHpzTGdwTWExV3YzVFI2U1A4b1Z1T2daZy9hUU9O?=
 =?utf-8?B?aXF4MG42TVBOdjF4cHE4SzJYZDBFNzVNU09Ic2pzWFpmWDQyK3FDQWNqcUoy?=
 =?utf-8?B?bVh1ZDJZVjlxeEZzZStFSENmNlVQSncxNy9WT29CTjVva0JjcG5PbDJaZ0Nt?=
 =?utf-8?B?R2FLZTJtblgvaHE5UXRwVk5TYnIxNG1YeXQ3SHEzTTl0T1dmVDk2ckkrVnhx?=
 =?utf-8?B?T0pLV0REV2lvMWd2SGJjSFF4VTFIcTcvTEdjWkc2eE8rNldnSVR1S2VMbVdx?=
 =?utf-8?B?cU1QeFpQQURHU2pTV3ZFLzljL2F1aEdnSHp2dzJITHBOTnZXSk5nd2NsM0Ur?=
 =?utf-8?B?Y2x5NGJkeDN1Yi9ERFJKaXJWKzNkM3RpdnBPbWJrZ1VPMkZFSU5adGh4QXBQ?=
 =?utf-8?B?dHJZeW40bmlYY0wwMFNvZTQxaktHNFVQRzk5ZmZLQVR5MkNDVWxRenA4a1hw?=
 =?utf-8?B?cGpDSDhWV2VWeWx2L1NVQVRSeTZ3WGhNTVU2NHhTbTUyeEZRcDJ1c0RmQjRV?=
 =?utf-8?B?cXRPMTJHT3RSS0JWQ1ZGbGFiNm5JNDI1U2plUnlMa0VzTER5TzZtUndjYTc0?=
 =?utf-8?B?ZGF3ME8zd2pQZzNuNUdLRlN3cnJ4Q3NCcU9JeWV2QVVabzl0YS96dFRRdXMy?=
 =?utf-8?B?SkdWSXpLWFh3bE9KL0l1QW1TYmplRktsRElSVzRlKzJoWlFLQzlHMU9JVk8v?=
 =?utf-8?B?UWhZVWg0czQ5Q1UzVUhCQ3dUcnBGd0lKOXZndDdKQUZTK25PcGZ1QWdDaFVU?=
 =?utf-8?B?RmVzUVZvNDdtTHJvNDZqZ2ZDZEtqUHE4WGhxYWxKZ0ZyUnZIQTAwbXZrMTln?=
 =?utf-8?B?bXlpSFlzMi9mLytEYVpjQUJzWHpiVUVRVVdicEVGcHFkclpVNXVNTmlsU21R?=
 =?utf-8?B?Nmc2QnhySDBlbWRoZVFXNWpnMkNuOXFlY2dScFMwdEhkTFNTS2ZLNUtGTktQ?=
 =?utf-8?B?T0V5M2ZFNjdYUnpKUUJVQ2ZZODlFZG9TZnRtVVRrdElRUmt3ditHWEFvUUpM?=
 =?utf-8?B?NTNwajBQbHR4Mm4zMEw3Y2I3UlkvODBWeHdCbmNwRFl6SnBTa2hLdStha0l5?=
 =?utf-8?B?Y2h4TnlhTEY5N1pKN1lzM0lwdkF2Qld4L241TW94R2h4RS8xT3FSVSt3OXVH?=
 =?utf-8?B?MGN0cTNJSUNFQ1VVcDVPYjZ2eTJ6MXp3Mi81b1Ftb3hLWllwcU1jSU5zcjJJ?=
 =?utf-8?B?bWZDYWhsV28zbE5yOS9Fa1pham9rWXZZU08zTG1LUGZNLy9McWxRcG1QTjhK?=
 =?utf-8?B?RytHUCtXZEhaYUxWdmJEN2xLK2VmTUE1SnRORzh0aXZxVXk4UHlmb3JpNXZM?=
 =?utf-8?B?b2J2TkRraEhvbFpYZWZSSU1qYXRXNnJMSkI2REVNUkRTblI4WEZ2NWVDTk83?=
 =?utf-8?B?R0FFT1dZWWIwNHYvbHVRSFZHWjdTYllRN3c1TnhJd2c3MlV2Vk9mOG54SlJR?=
 =?utf-8?B?akxqOXNxNXRyWllnRXNhODlqRG83OHhvc1QwL2tIQTJBRzhZMU52d1BBVjZu?=
 =?utf-8?B?cXhxSXpQRU5uSUNQYXBSdkpFbHM5ek91WnVDaGlJeUxjZDNjVVlxL1hLbkR6?=
 =?utf-8?B?QllYajVhREhsbjNsRHhSUjg3U3NRU256UkNBdmw5ZmR0d05wSnZwOUEyN0dU?=
 =?utf-8?B?akg5Q2N0OGY0VmFyZzVuSGVWbVhYK1JHM09qeDh1TURETGh1S3lCNUVwRjlJ?=
 =?utf-8?B?YUZuVjQvT2hXMkl0U29rMXpkM01Zemh6MnRjZXYwTjRvVjZOKzR1RXRmeUxD?=
 =?utf-8?B?RFVoVnI1MXVBbUthdk1mZm9wNHEzOVJMTkdBWkU3M1F6NllTbldBUFR0NXBv?=
 =?utf-8?B?VWhadXAzam9KOG14cURpSkRxV29IVTVYMUdjZGlxSGJFUkNxZGVTWUU4M2xX?=
 =?utf-8?B?OVFFc3Y5ZXhLQWdaUjJacEtKcWFlZWxibkROYXByREpodHNmQmREY1FsL1RO?=
 =?utf-8?B?Sm1HenVqYnVveVRPaW1LL3R4SHViWlNaRldIbzBWcWF1emgyWFlmbVdDd3kv?=
 =?utf-8?B?Y1ZsdUdJSHF6T2ZhTXEzMk1xT3d3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7dae7d-72a0-4f86-1a43-08d9e4b26475
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 12:08:28.9562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEC9+t8wyGAfmHHQNByyAnWhA6W7I4oKF8AdZztgU097/GE46n4GgYsRUwd9o5kH2zDoG1hNWSu5wOKaNVW5zfLzSM5AQqPksb+kg66TZB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4535
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-01-31_04:2022-01-28,
 2022-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=772
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201310081
X-Proofpoint-ORIG-GUID: cdQCWALd-5epxd6N7aNvB6Qw4MYf3DQa
X-Proofpoint-GUID: cdQCWALd-5epxd6N7aNvB6Qw4MYf3DQa
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=865 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_040853_919368_8031D42A 
X-CRM114-Status: GOOD (  29.12  )
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

PiA+IFsgLi4gXQ0KPiA+Pj4+IEl0IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBkaWZmZXJlbnQgZXZl
bnRzIGJlY2F1c2UgaWYgd2UgdXNlIHRoZQ0KPiA+Pj4+ICJjaGFuZ2UiDQo+ID4+Pj4gdWV2ZW50
IGZvciBib3RoICJsb2cgcGFnZXMgaGF2ZSBjaGFuZ2VkIiBhbmQgImNvbm5lY3Rpb24gaGFzIGJl
ZW4NCj4gPj4+PiByZXN0b3JlZCIsIHRoZW4gdGhlIHVzZXItc3BhY2UgYXBwIHdpbGwgaGF2ZSB0
byBzZW5kIGJvdGggYW4NCj4gPj4+PiAiZXhwbGljaXQgcmVnaXN0cmF0aW9uIiBhbmQgYSAiZ2V0
IGxvZyBwYWdlIiB3aGVuZXZlciBpdCByZWNlaXZlcyBhDQo+ICJjaGFuZ2UiDQo+ID4+Pj4gdWV2
ZW50Lg0KPiA+Pj4+IEl0IHdvbuKAmXQgYmUgYWJsZSB0byB0ZWxsIHdoYXQgdGhhdCAiY2hhbmdl
IiB1ZXZlbnQgaXMgZm9yLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gQXUgY29udHJhaXJlLg0KPiA+
Pj4gQ2hhbmdlIGV2ZW50cyBjb21lIHdpdGggYSBmdWxsIHBheWxvYWQgZGV0YWlsaW5nIG91dCB3
aGF0IHRoZSBldmVudA0KPiA+Pj4gaXMgYWJvdXQuDQo+ID4+PiBJbiB0aGUgY2FzZSBvZiBhICds
b2cgcGFnZSBjaGFuZ2VkJyB1ZXZlbnQgdGhlIGV2ZW50IHBvaW50cyB0byB0aGUNCj4gPj4+IGNv
bnRyb2xsZXIgZGV2aWNlLCBhbmQgcGF5bG9hZCBpcyBhIHN0cmluZyAnTlZNRV9BRU49PGFlbiBu
dW1iZXI+Jy4NCj4gPj4+IEluIHRoZSBjYXNlIG9mIHRoZSAncGF0aCByZWluc3RhdGVkJyB1ZXZl
bnQgdGhlIGV2ZW50IHBvaW50cyB0byB0aGUNCj4gPj4+IGJsb2NrIGRldmljZS4NCj4gPj4NCj4g
Pj4gVGhlcmUgaXMgbm8gKmJsb2NrIGRldmljZSouIEl0J3MgYSBjb25uZWN0aW9uIHRvIGEgRGlz
Y292ZXIgQ29udHJvbGxlci4NCj4gPj4NCj4gPiBBaC4gQ29ycmVjdC4gR3Vlc3Mgd2UnbGwgaGF2
ZSB0byBhZGQgYW4gdWV2ZW50IGhlcmUuDQo+IA0KPiBZZXMsIHRoZ2VyZSBpcyBubyBiZGV2IGZv
ciBkaXNjb3ZlcnkgY29udHJvbGxlcnMuIFdlIG1heSBhZGQgYSB1ZXZlbnQgZm9yDQo+IHVzZXJz
cGFjZSB0byBjb25zdW1lIGFzIHNvb24gYXMgdGhlIHRyYW5zcG9ydCByZWNvbm5lY3RzIG9yIHdo
ZW4gYQ0KPiBjb250cm9sbGVyIChyZSlzdGFydHMuDQo+IA0KPiBEb24ndCBzZWUgYW55IHBvaW50
IGZvciB0aGUgZGlzY29ubmVjdCBwYXJ0IGFzIHRoaXMgaXMgYXN5bmMgYW5kIHdpbGwgbm90IGhh
dmUNCj4gYW55IG9yZGVyaW5nIHdpdGggdGhlIGFjdHVhbCBkaXNjb25uZWN0LiB1c2Vyc3BhY2Ug
d2lsbCBuZWVkIHRvIGRvIGl0IGJlZm9yZSBpdA0KPiBkaXNjb25uZWN0cyB0aGUgZGlzY292ZXJ5
IGNvbnRyb2xsZXIuDQoNCkhpIFNhZ2kuIFRoYW5rcyBmb3IgdGhlIGNvZGUgc25pcHBldC4gSSBq
dXN0IGhhZCBhIHF1ZXN0aW9uIGFib3V0IHlvdXIgY29tbWVudC4NCg0KWW91IHNheSB0aGF0IHlv
dSBkb27igJl0IHNlZSBhbnkgcG9pbnQgdG8gc2VuZCBhbiBldmVudCBvbiB0aGUgZGlzY29ubmVj
dCANCmJlY2F1c2UgaXQgaXMgYXN5bmMuICBJIGRvbuKAmXQgcXVpdGUgdW5kZXJzdGFuZCB0aGF0
IHBhcnQuIEZvciBleGFtcGxlLCBJJ3ZlDQpvYnNlcnZlZCB0aGF0IHdoZW4gY29ubmVjdGl2aXR5
IGlzIGxvc3QgdGhlIGtlcm5lbCB3aWxsIHRyeSB0byBjb25uZWN0IGV2ZXJ5DQoxMCBzZWMuIEFu
ZCBpdCB3aWxsIGtlZXAgdHJ5aW5nIHRvIGNvbm5lY3QgNjAgdGltZXMgKGkuZS4gMTAgbWluKSBi
ZWZvcmUgDQpnaXZpbmcgdXAuIFdvdWxkbid0IHNlbmRpbmcgYW4gIm9mZmxpbmUiIGV2ZW50IHdo
ZW4gY29ubmVjdGl2aXR5IGlzIGxvc3QgDQpnaXZlIHVzZXIgc3BhY2UgYXBwcyBhIGhlYWRzIHVw
IHRoYXQgdGhlIG52bWUgZGV2aWNlIG1heSBub3QgcmVzcG9uZC4NCg0KVGhhbmtzLA0KTWFydGlu
DQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0K

