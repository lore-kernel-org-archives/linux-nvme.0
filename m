Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E7AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 22:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TnTzUZ4p76l8G4IaH255ICnzhsJdtOOIKf/MWQHXWo=; b=082QvpI8T3voENI1zil12OzazA
	QjJV73f0rakIm6Bx+Jzbp7Iaw5LO278KOtuUhJL34ZOIUGjR676fr3iz8nS3KL0pkYNS/zdOZ7+EM
	kyMjNX95CJ2GF+EgsAgAFAzkl858StUXTbDuXwDvjZwGMSTfRivVUpfJvpUkgo7gmewpvMOmm1gZ0
	tAKgdrx9eGg6w2/1TYiCel+p52vSYBnNBX93q7b4/U9f/upQ8rfOwvp9SywGYsjhhfLpYeOzmJsiS
	aF5bhAKneL0kMshfDEW0tbm4+6ZQ0MTKODDqSA701cLxk9O6WUN8BoDnYJ8480Sb6SN4zmORpAwuO
	nOrarMnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncDnF-0085wE-EX; Wed, 06 Apr 2022 22:06:25 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncDnC-0085ul-Cr
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 22:06:24 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236Lep0i005378; 
 Wed, 6 Apr 2022 22:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2TnTzUZ4p76l8G4IaH255ICnzhsJdtOOIKf/MWQHXWo=;
 b=IWrrycL3nKbKWiIp6+saxuXtik1idKBRBEPIelY5vx3emozoFpZViri6DX5GK+2rkZi3
 cPsPZITwYWlXdjeMpg5Kis6zygZ4XjY/iuiwwmFKfKxJOfJly2k/y7a4b7vYXAr2D/2o
 EbHPOuRzXajh6uKaog3ptZnILLSOwOie81NcfxzaOnHHVhWRpYN+qjZ/OrheauXiC74c
 gC+iM9zNzbPuBM4xXX9wdfuI12WjHDfjEzc3Fa4JfE7OwK8ecb1dpa3OZo0usYndvygZ
 q3YHUECOaSc9v0Zcko6ggarSMC/8qWcNC0StOH7+kAYC57eE8523R7OLYvJZAPdM5OnM iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6d932a58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Apr 2022 22:06:09 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 236LuvH3026828; Wed, 6 Apr 2022 22:06:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3f974ddrrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Apr 2022 22:06:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUYvTDEh6/2E1QM4j+6vZZjGAn0d86nYm5mrCGfLdF2MZKQO+P/SJvT+ixlvUPvyzxSwTt8d1sfa3Tvp+jMHewytdm5UsIhGFSfR9ZCy2+zBZjaiW2aojlAl/IAUWCk9CQvhzcQo0DoLOsDINvDB03NFZqw4a4OWaViRJTdmhKLoBRBLU0JJUi8h4F1Krykf0nOUd+LZNeIvwUDCecAKFXP6T/PVdSi4JWa5foVLHvFp2uciNDEeQxIn2fPhLNNxJLvFrILtjV/jST0kf6sf3oHkdzqmOVPhVgnCbhmv+j0qrJ1LWnBajZV76yMrOyFyi/C2M97FtuFwHA+HRQw77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TnTzUZ4p76l8G4IaH255ICnzhsJdtOOIKf/MWQHXWo=;
 b=IAkYVY1y08HGPOgeneH0Sx5yUvOSvf9Xz0AmPrrg9WdsrHO87sCY+gsgU9dPliBQ1LOc8qxEpLYwe0+rwMKTUua+SbS4dcVL89fZ6FqlQTc0yT4bZ+c/jkRliu8et1cjlmWYZtN1p9A2OiYzpKjKe+unFWz7QkXqIKt9uK1Dh6C62atImsunpfCqbr5o0EGYCz5ImSCXuU1GzoQmhIF8y9nDYhwoDLz1VtwcaeQz/wkn3ezyI66J8YZGXfNYEiql67niSYow0574OTyeXHDQvy02DiEIXFyjbKfPPsnodGuBCaJeW8QEiTqQ6dLxNPm0ge18+o87lv/xn4JwAsmuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TnTzUZ4p76l8G4IaH255ICnzhsJdtOOIKf/MWQHXWo=;
 b=y3VGFaKZwrKF2hEbSiqpT3scIgbcR9ot3TEmjRJhgOEpC6NkOMiGi9MQs6GXkZHb376FUjKF16g91mlpMfHciIni/1o3IUM6SseK7owMyfpmbJXsOElj1aCxX9jEN+DQ9AL8ECTe37upeCH4Dzgc242DjqIYt4OsXzRI4e2NuCA=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 22:06:06 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 22:06:06 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUqFpKGiT1CSkmELkSF7x4OoazjGb6AgAAClgCAAAWlAIAAT2KA
Date: Wed, 6 Apr 2022 22:06:06 +0000
Message-ID: <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c265685-c955-4a80-4888-08da1819a629
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1381A4D202E686D8485548ACF4E79@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rm7ZsrdfpRG13Dq/3nxpdaPHbMPHO6Zr+lIsouS7tXhnPNZI/2UG0jWC9tZGTTzwZE3GaZYEfHVjBFs+vwwSfPtJI0j8V/sEneJc3jdO/GWVffAGG0mQtLTeIk9WRT4vNY6PgcbfHhkhd3O8+wl34wt/V/iPZpT2QXIb4+L/wN+XLntJ6yrJG/s2yCqcQOptkTrbfL420nUmwHRkGbDqQfLL7d9DohrqGOFLDexYBj2WwPWk6nUY7sF1T5A8kVEmsDBrjKi560CFMoKRGKXJKDDrz+B5C+1j1olMUkfForNYIkEehoL0LoEJN+K+qFWJ/ylulxMdqwXycFJnTyWJEonURUjZdvk+/V0lN77aIi2lo6WMjTimE2QgIUUFlEpCORO2w4+fp6mQ4dKihc84zhiIHkhiRb/zBCUXsTI2QoGc8+5tKylMThikmhU3KxbWp8U62YVLGkUOcLT6o5YlLugCtMZiOciTqxjg4YXuF4poAI9tO+P3Hhhyh2fl8p0cxU5Dw8YqTh67Ae3pEKnXEDeSGiuMssn1n/yJpLLdr8nZSO4NDmaJg3+w7HJ0kqY9X8xmFUpxQR1fY3A/IEUwfmf2agoFPCPuL4/WKw090Ae7Jqax+ghvWOrwC7K17yakogmH9+Efod3u8WmOwRzGScd39k1TCKk9p44vWRJer6MShdtj+iA+tZ7ZYBLj49nsU7rn+MDPQZX5qa3sh1EgRDdcHV82lTcyT7uZv9KZ1+0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8936002)(6506007)(8676002)(2906002)(6486002)(508600001)(38070700005)(4326008)(76116006)(53546011)(64756008)(122000001)(66446008)(66946007)(66556008)(66476007)(71200400001)(44832011)(38100700002)(5660300002)(83380400001)(33656002)(6512007)(36756003)(86362001)(2616005)(26005)(186003)(316002)(6916009)(54906003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0FZNDFQaDZaeExZOHpWQlhuTU9zalBRK1lqNitKa2ltRmVlOGFYL1I4L1ZC?=
 =?utf-8?B?bzdzQTNNRnRxdVI1YkxEVEFGQmRGVXFJQnZ0dzJ1UzJQb3hMWk5jQnR1RXlV?=
 =?utf-8?B?VTQ3VWFCZ04vRTk3clk4S0QvZVl2RFJ6Q2NHRDdMUkNGSGdvSG9YV00yeGVM?=
 =?utf-8?B?Mk0yWTM5cHB5WjE1akk5ajZ6Z2N5ZFdEd293SWhWU2RqS2dMOUxXZWNmYmlr?=
 =?utf-8?B?dG9Rdm1YTXJYRmFleGJyYVZCVmVncy9GQm5ZcTNqSGJHeFN6VjNaT1lnSXcw?=
 =?utf-8?B?U3V6aWVLdzNUVlJRYkZ1N0Z4M0N1WS8zM3hUUlBCbkh5SVpUUUFBUktUUnNC?=
 =?utf-8?B?UnpKMWxEVjhXRCtWejg2T2tsdmRUQmFlWkNXNHZzVUJDUkI0RWJ6V1pibysy?=
 =?utf-8?B?eGJkWG1oa09DZXEyQVcwTU1kWXhoVkNEVTZlTCtxYm9wOGxlMkV4cTZrdVZs?=
 =?utf-8?B?QWNkY0krWUxjejhubWl0cDVXZDZzSExXR3ZDbU5aZWRIY3VOVzZHSFpRUitH?=
 =?utf-8?B?NjBCbEJTd2FpWU94UE13QituRzR3Zjk3TDJTZXBKQnlRL2hMMG9VbHY0Tm9O?=
 =?utf-8?B?ckl0ZjhCcWpKaHF1Z0h3Wjd1eTFUZ2RhUUR0bDkrK3gwangzdFNyUHIxS2tD?=
 =?utf-8?B?c0lYMGZJVHNoQ1AyaDhzWUh6dTh2K056bXR0R2hocWE1dktQZzVCaGdoSVZ1?=
 =?utf-8?B?VFQvaWg1anViOUN3NG1pa0dIanI2K3dLaFNuaDJucG96WmllckQ1ZUU5Njlm?=
 =?utf-8?B?ZHNzeFUvSW1rVDZYSElmZFBnMEV3S3paUUtCN3dSRGpxUE14RW80QXJhaCtB?=
 =?utf-8?B?Q0JScG1MUERNL0d6NllWb0hnbXRaZER6ZE91dFYvLzV1eUcvTUZQT0xkYi9t?=
 =?utf-8?B?UkRKeEEzOU13K0ZoQURRSUY5U3d4ZWFqUlMyaUtPcHp1TXRBK3RmSXppa1dl?=
 =?utf-8?B?OFRQMzNPeTVZeE5CUUpuNXhJYWc0bksybGgrbDlOajBTYWJONVpmbEFZdERy?=
 =?utf-8?B?UkZYQzBzN0lxdDl4dmswNVVKUFd3YTNUalBqeWswdmpBM3NhUWJUa0lvY1hI?=
 =?utf-8?B?VkQrbDhGSWpBTlBsYXlOcGU5TDc5U1Q1dmhZTldrRTJTM3JvcVpTT3ZhcFBT?=
 =?utf-8?B?ZmhDdFRHcGhWaDR1cVQ5alVvUmRMUll6Uk9STWJtemlMdU1JcjhMa3NlVlVY?=
 =?utf-8?B?MkNuRjJXbE9SWHRBdzNVRnMyYXVtQ01lOGpzclpscWxxbXMyVUEydDM0UjJO?=
 =?utf-8?B?eGtlaDcvd2p4NDRlQ0FaOTkzMTFzYW9jQlIyN1ROcExwQ043TDhETGx0NDBi?=
 =?utf-8?B?Z2ZuenRIZjA2V2IzSlFPZS9UMWJVTjNQcW5VT2hYZndURytXMTUvMVMrd1Zp?=
 =?utf-8?B?VmUrNEhqM0dHZW16YmI2V2ZoM21pOUZPdDYrUnFXbnVGeHNoaUt4bUI2bkM5?=
 =?utf-8?B?OXRrcCsvTFZSM3lGWUNmc1lrMXlwYjlyczVlVXdvVHZXcVhVVjVGQVhwM011?=
 =?utf-8?B?QjZ1NW00Tm5ybmo3amlCQ3U4SjlVZmsvbEZtSkt0UkZ2TTdlT2R3SEU1UkFy?=
 =?utf-8?B?SG1HdzA1azkwV1h4TVhDdG9kdWoydkdTK0hZa3htY0hmQlNkeUFTZlpxMlcz?=
 =?utf-8?B?TDEwbG8yTXIzUEZhMEp4OHRqWWJrUnZVM2twTFJnblE3MUFING5xbXFHcHlT?=
 =?utf-8?B?b3k1QVVQRlJUbzhrTTc4M0R1NG9pdkcvam9aWG0wNmFVRUUrbGtyV1VkV3U3?=
 =?utf-8?B?QjdrdEZWaW9FdFplVFZWUG52T3Y3K1B4L0QzK0RaMzJoS1F6R0xTRSs3cnQy?=
 =?utf-8?B?cHBBMEtCSThheVF4VG8xcVJRSGF4cEhvZ2o5Z0lXdThhN1VwUGFNL3BoT3h6?=
 =?utf-8?B?WEs3OE85b2puQVJLbzBWSWhpRDl0QmtUcDM5RmVJTVF1REdyUnJHOHVCRjFU?=
 =?utf-8?B?b29sR1lCTXNRYlM2YTBhTXRiMVE3UjlVbStUeGFMNWhTNVFWeFpGNkNKbGty?=
 =?utf-8?B?WXh3aHg2Z2JJWGNIUEVqMThmY1BwdnBCNmRoQzhWMDlkT1JpdDZnMlltcUlM?=
 =?utf-8?B?SXkzb3E0aWJJeW5McDJkMFBPUHlFdlBHaUo4M0I4SkpDUktZMHYxa3FUM3Q3?=
 =?utf-8?B?dlY3bWNpRTNqVzNxbjJIeVBSVUVyZllKTnFlSEo0OGZ3N2tNREFaK3RhOHFz?=
 =?utf-8?B?VmZMaU5EanVYd2FnTWtzZmdUbnNudzlwa3JISStLKzRWY3drdWpyYUxDUjBT?=
 =?utf-8?B?M0FWeVZUczUwcEdwOGpDMHk4RUtCd0FBYXFjTXBiTGZVRjBVNTBWUzB4YXFO?=
 =?utf-8?B?d1dyZ0VFQWlUZDZrdk1JUU80c29BVVlxd05xdHhjaHU2VjhsMWwvb012c0xz?=
 =?utf-8?Q?VPKol+USYQ2HWjOE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <193749E1F1D2E540A340D5D0F4F784A4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c265685-c955-4a80-4888-08da1819a629
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 22:06:06.5912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAH0GKk6e43V9zPI04G16CN6sjOnI+63YtkrdzBxWMw0jbKrVOO4yB3VXYJcaV/2Eh00iEaoXQkvRA3XFfU4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-06_13:2022-04-06,
 2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060108
X-Proofpoint-ORIG-GUID: JlEi8fV1472wNUtd2hdfGXgYK-HntpKK
X-Proofpoint-GUID: JlEi8fV1472wNUtd2hdfGXgYK-HntpKK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_150622_589771_E744EE60 
X-CRM114-Status: GOOD (  21.95  )
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

DQoNCj4gT24gQXByIDYsIDIwMjIsIGF0IDEwOjIxIEFNLCBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBBcHIgMDYsIDIwMjIgYXQgMDU6MDE6NDZQ
TSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gT24gNC82LzIyIDA5OjUyLCBL
ZWl0aCBCdXNjaCB3cm90ZToNCj4+PiBPbiBXZWQsIEFwciAwNiwgMjAyMiBhdCAwOTo0MTowOUFN
IC0wNzAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+Pj4+IEBAIC0zNzAsNyArMzcwLDgg
QEAgc3RhdGljIGlubGluZSB2b2lkIG52bWVfZW5kX3JlcShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0K
Pj4+PiAgew0KPj4+PiAgCWJsa19zdGF0dXNfdCBzdGF0dXMgPSBudm1lX2Vycm9yX3N0YXR1cyhu
dm1lX3JlcShyZXEpLT5zdGF0dXMpOw0KPj4+PiANCj4+Pj4gLQlpZiAodW5saWtlbHkobnZtZV9y
ZXEocmVxKS0+c3RhdHVzICE9IE5WTUVfU0NfU1VDQ0VTUykpDQo+Pj4+ICsJaWYgKHVubGlrZWx5
KG52bWVfcmVxKHJlcSktPnN0YXR1cyAhPSBOVk1FX1NDX1NVQ0NFU1MgJiYNCj4+Pj4gKwkJICAg
ICEocmVxLT5ycV9mbGFncyAmIFJRRl9RVUlFVCkpKQ0KPj4+PiAgCQludm1lX2xvZ19lcnJvcihy
ZXEpOw0KPj4+PiAgCW52bWVfZW5kX3JlcV96b25lZChyZXEpOw0KPj4+PiAgCW52bWVfdHJhY2Vf
YmlvX2NvbXBsZXRlKHJlcSk7DQo+Pj4+IEBAIC02NTEsNiArNjUyLDcgQEAgdm9pZCBudm1lX2lu
aXRfcmVxdWVzdChzdHJ1Y3QgcmVxdWVzdCAqcmVxLCBzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQp
DQo+Pj4+ICAJY21kLT5jb21tb24uZmxhZ3MgJj0gfk5WTUVfQ01EX1NHTF9BTEw7DQo+Pj4+IA0K
Pj4+PiAgCXJlcS0+Y21kX2ZsYWdzIHw9IFJFUV9GQUlMRkFTVF9EUklWRVI7DQo+Pj4+ICsJcmVx
LT5ycV9mbGFncyB8PSBSUUZfUVVJRVQ7DQo+Pj4gDQo+Pj4gVGhpcyBkZWZlYXRzIHRoZSBhZG1p
biBlcnJvciBsb2dnaW5nIGxvZ2ljIHNpbmNlIGV2ZXJ5IGFkbWluIGNvbW1hbmQgY29tZXMNCj4+
PiB0aHJvdWdoIGhlcmUuIElmIHlvdSdyZSBzdXJlIHdlIHNob3VsZCBkbyB0aGlzLCB0aGVuIEkg
c3VwcG9zZSB5b3UgY2FuIHJlbW92ZQ0KPj4+IHRoYXQgdW5yZWFjaGFibGUgY29kZS4NCj4+IA0K
Pj4gSWYgeW91IHBvaW50IG91dCB0aGUgdW5yZWFjaGFibGUgY29kZSB0aGF0IHdpbGwgYmUgZ3Jl
YXQsDQo+PiBJJ2xsIGtlZXAgbG9va2luZyBtZWFud2hpbGUuLi4NCj4gDQo+IFRoZSBzZWNvbmQg
aGFsZiBvZiBudm1lX2xvZ19lcnJvcigpLCBwbHVzIG52bWVfZ2V0X2FkbWluX29wY29kZV9zdHIo
KSBhbmQgdGhlDQo+IGFycmF5IGl0IGRlZmluZXMgYXJlIHVucmVhY2hhYmxlIHNpbmNlIGFsbCBh
ZG1pbiBjb21tYW5kcyBkb24ndCBsb2cgZXJyb3JzIHdpdGgNCj4gdGhpcyBjaGFuZ2UuDQo+IA0K
PiBZb3UgY291bGQgc2tpcCB0aGUgUlFGX1FVSUVUIHNldHRpbmcgYW5kIGNoZWNrIGJsa19ycV9p
c19wYXNzdGhyb3VnaCgpIGluc3RlYWQuDQoNClVzaW5nIFJRRl9RVUlFVCBvciBibGtfcnFfaXNf
cGFzc3Jocm91Z2goKSB3aWxsIG1lYW4gbm8gbnZtZSBhZG1pbi1wYXNzdGhydSBjb21tYW5kIHdp
bGwgbG9nIGFuIGVycm9yLg0KSSByYW4gaW50byB0aGlzIHVzaW5nIHRoZSBibGt0ZXN0cyBJ4oCZ
bSBjb2RpbmcgdXAgZm9yIHZlcmJvc2UgZXJyb3JzLiAgSXMgdGhpcyB0aGUgYmVoYXZpb3Igd2Ug
d2FudD8NCg0KQWxhbg0KDQo=

