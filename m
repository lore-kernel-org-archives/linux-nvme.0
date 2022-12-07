Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E712C4708D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 21:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RY7Hi2ZyrMQH+lLhC0irK8zrknxb5uVseJhVqHcZA2o=; b=rGU0eLKwoqurD5+IDIrWzfprDS
	yKLkEc1Z0oWLynuffYtbkNIEDIO+7d1K1ZxlPaGuAxUWwpujczdM7qrhbnCI3hsCrydeI+pgyrBMz
	txrUg7XJrboQfLmQy2T6/bqtnDNhEGcJIa4aIZjx1annddxG87gHFtWjpUC0gyG6V9ca71AGcjqSR
	92k1+ixIUL1jft0RiYJSfEC4qpIgOa61NyIoXQf1aU1KAaF564oX63BZ+czvoeeYCSLupEqV3tnN0
	2xo4bY39SzaaBIa52ncdYEno+7zclSXS1Wn4NL+HiI2mQ8/iOygUxd1gvt/7ly9CptXg2jAh991U3
	4LrO9bDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p31m3-00Cjv5-Ba; Wed, 07 Dec 2022 21:16:15 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p31lz-00Cjmm-5d
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 21:16:13 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B78nxBh011618;
	Wed, 7 Dec 2022 08:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=RY7Hi2ZyrMQH+lLhC0irK8zrknxb5uVseJhVqHcZA2o=;
 b=SKPjScMvoAZbJQ9C+oIRxhHIVQcpzqrjmEoJSmo6Z+9X89G3j+z51tiOGJl5J0/zQGFu
 Pgg9A6ObqZhdzrUVh8AQqinFhS4z4zG/2J6oIqsNZxnRFkC4YgvM5Z1SHw5BpWRArhYw
 MYvsJRXRlcPP57+6iBAbWNHCf1Dpb954bP86KbrEAXGVqcqa0Kq8KL62UWNiNKYPZAo8
 H4kOQlPm5RqHyUlh9jzM+WzAFp44JyzaqzfMWuTWUgUaYK51vx6tL6vGLTwzcdgZ4yrq
 75P+PF8D8dRnEs395TcvcF3kPV6F9MpJSCV8gI3N3u30sR5erpR3U+wYKCfmbBBndhw2 rg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3m82jf34eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Dec 2022 08:42:47 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7DdmFB027331;
	Wed, 7 Dec 2022 08:42:46 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3maqtdcbw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Dec 2022 08:42:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeYPE8kafEGMT3V8t3mqCumcsY4N0uWTjJ+l41hBDCU32DC6ElCyfWi6KMNj8D09oN4cPMLJwHaNCR6HM0T1KU9uXntJdtUIaGY21smaZGv0fKhdb9x93d/Yz7uDkBkcrZw30PPpeF1LLYPK6VgFFi6a7yKsfYW5v62w2xc1sMeUM5Z/ivxexFl89N2JT65ysvKNM84Lv1EsyrWl2gPQ7KlrOZOAjd6OW958XZBEZztkrih2GETdyuGvvPzYAX359HZpN+SIj8tElfNaewcAhIl9Iej+MQt8rStwLHl+SzT3UeRGpErT9nVKu3eASFecAFZBNCDb/6VLwNPWM5YDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY7Hi2ZyrMQH+lLhC0irK8zrknxb5uVseJhVqHcZA2o=;
 b=CACQIwR6kUhJlkI+nphJcBHLh2X8x3scn1Mn0Ni/GMxuNxmu8PbrlEvqpvD99WWRT40I5SiFBFYwPWB8D7IyXKR83Jys2nboP0VbbLtyr7sDY3G0x2IbDjNHsIWoyUK2HhtbR73NKHQc9xQUAQXU2B/aPp+apTU+Zo63qcGjxYfVQxWAi0d84u3CUYgNDfX7fdc6HDnWxzzyaRDEFmevD7MwCfp1ZoxX+sBKe6IkyObNNbgm5xOpD+zfQ7WOtEB3CD9mBPJxwIhJUNOIM7hihhR6tmgky8CaNsqbogHczoxo8nGlwtQatI1Vvir/d/1JOtalR5ovsqjVYaI0P+QFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by PH7PR19MB5870.namprd19.prod.outlook.com (2603:10b6:510:1d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 13:42:43 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 13:42:43 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: RE: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Index: AQHZCircZassPCXK70uAR/3KOBzuUq5iR1uAgAAmnIA=
Date: Wed, 7 Dec 2022 13:42:42 +0000
Message-ID:  <CO1PR19MB4885380AC6E687A3FC8A858EEE1A9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1669889667-1034818-1-git-send-email-amit.engel@dell.com>
 <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
 <40ec518c-db1b-8fa2-af66-3b2f3dcc235d@grimberg.me>
In-Reply-To: <40ec518c-db1b-8fa2-af66-3b2f3dcc235d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-12-07T13:38:14Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=040275a3-d5cc-45f5-8043-c8f88aba2bbf;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|PH7PR19MB5870:EE_
x-ms-office365-filtering-correlation-id: f18f1a94-428d-4763-892c-08dad858ea8e
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  TWaoDUnx/BNCliF12KG6H/4MWlVFbJHCULTZWrLbZSuiFrUULBvZ3claATnhOOnc71M15OeReKXW/0WOOT9sxCTKJF00oalIOSr5k3EIXkkAfz7OGBIwh7MSvRV2nHo23Xb0OfWmTS6g+DZ9vW9B3g6iic+Mkdl5WNolmtNjDvFwYixHaKEgsLbcBdJaIreTUh2COUUOeWeQM4j1G/EjdeaS7nx2HYr0m0aCb18Qy21/ynjFBnOCjpflDwgCmSkeqRhpLOqVs5mZAEpiwiswth5JNclwCmvjTqgZhC97RwxtY3waZQdb9GNGP+ju55yYZfrFYUfzSwOhqZSZ4nfIv3o/SvVwrCg7tXhlFPAcrkrEBiXZyiDj6KH2C4BQUaUUbT5eRvPSGtoOCwWC2NcpGrgRTSU9FedNpe136JjSkbixQnxUsKMnBja8n8/W/iBt7+lPgMFpXp7NBxKQW/5iwelzOlfQ5xwEDzjBKxYw4Sz+3GYaZmtLdbBF/E0/pj/dWjmi8AmHm/SYwEuGb2fSWVnWIPZSFT61Vq1fssLBfd0o+Ng6qSFwTVSAogFD7cAaQYwqKxjKLro4M2QfSffIB2DgGewjCUZAHrFRYdxFrG7OLr1UnIPHBc3fHOE8zHDUsK9IFF6mIDVj6cueAIzjuBERJqOWSKNgmQ52Xz3IqMW6y+Ez7gZ5jlL4COWI9tVQX2OZ9Am3SviiPTYEOYL/qA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(82960400001)(2906002)(41300700001)(478600001)(38070700005)(4326008)(33656002)(64756008)(8676002)(86362001)(66446008)(52536014)(66556008)(71200400001)(55016003)(8936002)(5660300002)(66946007)(9686003)(76116006)(66476007)(110136005)(186003)(26005)(38100700002)(107886003)(83380400001)(316002)(786003)(53546011)(6506007)(7696005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?T3E2YTBBYVpWc0VLRUR4cStyV0htSW9lRDlDWTRLWVBMemtsTStibFVSaWlR?=
 =?utf-8?B?aVpaUjMyZDMxYzJyejBjRnNWTGRXZFZmQVErQkp2OER1MDZDbWZwUVNod3I1?=
 =?utf-8?B?bTNZdSt4VlRIOEZCMEtoVVYwczFDYTdmUnlJT1JpUTZmRzRiaUQzdWZZUEFp?=
 =?utf-8?B?VDh5amdZTlA4OWRwZ0VmaXAzSTVVTnBzdFdoV1poanRZejd0ZjQzQ3lJSTFW?=
 =?utf-8?B?ZnY2MXVEcTlwYVRsN1RHSEVSYk1hYWo5RUtTVjNNdnVhaTEzMXljM0JBRVFE?=
 =?utf-8?B?MnhNYmt5MS82Wmxpcm9CL1d4dWxCZWdvRUlsa2hCamJqQ3N0UHVTcUNqVjBz?=
 =?utf-8?B?dWxzWTZXT1FUbnNyaWxGRnBjVlFkRS9yQmFXUFVuM2VSdE9reFZPek9IK3Y1?=
 =?utf-8?B?YVdVTk1acDBsNkxLT3NSaitRY2dlenBYZDltNGdNeGhORGtrWXJMK2pTa2g3?=
 =?utf-8?B?OWNITUF2dDVqZEhDSXlvN3EyZGtyYWNXS2ZkWTIxaFRSVG9vcmJ5NlFLZEhR?=
 =?utf-8?B?Z3FPckNyZkhORTRVT28zWVFrRWwvN0tJM0FlQzJNNE9QbWxLQmZzQ3NMYjV2?=
 =?utf-8?B?VUF5Q0FnMmIyYkVpQ3dteDJYekVqQTZpMXZjQTlPUWFRbVJPeFFNREtQR1BS?=
 =?utf-8?B?VlBkRmlaUUIrd0F6ZDVYU3pGTVBmMUhsQlFibjhkZTNIeEtyOWtlZjg4bU1N?=
 =?utf-8?B?OW9nN3VVRElJZlNBcE15MlVheXluUHRDZHNTUUcvNXVHTTFuTzdLNzUyeDFt?=
 =?utf-8?B?Q0FKWFp4WDlSWmkrTDdScnRJNzFERVNyZ3RLbXJ0bVo5NkVoUmhXRVZsaUlY?=
 =?utf-8?B?VmVVZGdMcUNNaE5wY3Nya01TdE1HYUdCQ09tYWFhN3plQldmMytlUlloTjBm?=
 =?utf-8?B?RUYwWmJOaHhhU0xkZlJIbTZJRjErNjBVQTF3emZFc2dpMmRBTW0wdHk5K1JW?=
 =?utf-8?B?Sk1vU0toNEJwNFVncjNvTU9NOUNtanlETFFjR2l4dmQ1eGtvNzBETHZ5SFor?=
 =?utf-8?B?Vys5NytEVC85cUhTaEtWcVpUOTFoS3Vvc2pabmhnbHdpRDJHVk1mczBPRDA4?=
 =?utf-8?B?OW9Rb3NkWk5QaHVGak5yMGF2VmNJb25SeFZoQm03N3NKbU4vZmxGcHQ4RDgv?=
 =?utf-8?B?NG9UdTRvdk9aOVFqaDVLanYrbGpXWUs3VnQxRFR4bStqYlJuQ3VwQ0lwaThL?=
 =?utf-8?B?RXBodFFSbW5qdlJCNHN2c29rWWVpUmU4TGtjamp2by90eUdkUUR6Y2p0SjIy?=
 =?utf-8?B?QkRmYzVOWE02bngxV1d1UDV4Wm9xT1N5WU01VVRUcFRFeHdkRUZSNGd2Z0Qr?=
 =?utf-8?B?azRWSGR5OHYvaVVLMGNqSWFuU1c2Wi80ek5Kcit3RDZ5Q3pLeHcyaWJPZVF3?=
 =?utf-8?B?cHoyTHZYM3EvMi94aUs2a3pJdkdGWGgyOXMvR1c5SjVjS0JzMHdqb2ZNbSs4?=
 =?utf-8?B?YWcxZ1dLN3QwR000NmtXeXRLQTA3elMyQVNjT080WHBydUlKZlNCbDhTSTdZ?=
 =?utf-8?B?ZjJDRitCU3FhMXhtb1hpL1dZaFF3dGhvNjRpenpGMksrbFI4QTliWmdGTWx2?=
 =?utf-8?B?UExucGg2OU9zQTB6ZUhwb3pNRHprcmZMUFdDNStya0pYRXhCY3VYUGI0MFl4?=
 =?utf-8?B?aHRnQVpqeEsyWmdFSTg0c1hhKzJ6cHNJamZ2bDFkSWRaZEs3bnlQQlJNK2dD?=
 =?utf-8?B?L2RFNWVyTDFyTlZrL1JxVnphMll6Wmx5RnpIZW9KdVdOaENiZnJHZkVxeG5B?=
 =?utf-8?B?NVR1cTF5aVl6NVZNOEdsbVU3eWN3RjJBdm9XVi84RXZwY1FCeGVIMGkveXVF?=
 =?utf-8?B?bWlrYkFqZ2EwWkpzWU5oTkNDdjRhYnV3M2ZzVzZqTU52STErcEpiS0lmL1Jx?=
 =?utf-8?B?Q2k4QUhnRmJIYnh4SFZYQ3Fjc2N1UXpxZHZoVU1qaWZCYUpFUFRDYURqQUZz?=
 =?utf-8?B?RmIyekY3NzFSOURsL1o3Nm0yL0tYQVdNaFpQWDJyUU9xbk52T3NmcVNKdXZu?=
 =?utf-8?B?cnRwOCsxMFJ3bGdrZ0I4aTU2Tnh3UEd2dEE2SVJVd3FkNEVPOFhuQlVIa2Rl?=
 =?utf-8?B?MXNDdFhDQmR4T25iTDU4V3V3RjhkcFJ5ZTRZVFRZSlNpOFY5VEUzdmRQUEh6?=
 =?utf-8?Q?p4AQVY0VErAVrmmKpPBhbk0H+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18f1a94-428d-4763-892c-08dad858ea8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 13:42:43.0121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCTLHeQY4U+K+Tke5FkuVYZSWzQQWn9r1KFBAcXSXzjJhWHhsUgW3rsaMuAkWm8Zy0/eAHOJLx/3PjG+BMiPYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_05,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212070118
X-Proofpoint-GUID: RDCSApcysniVADnTtxZniO9YkVijKn5l
X-Proofpoint-ORIG-GUID: RDCSApcysniVADnTtxZniO9YkVijKn5l
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_131611_457362_D0D8D416 
X-CRM114-Status: GOOD (  21.40  )
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

SGkgU2FnaSwgDQoNCkRvIHlvdSBtZWFuIHNob3dfb3Bjb2RlX25hbWUoKSBtYWNybyB3aGljaCBp
cyBkZWZpbmVkIGFzIHBhcnQgb2YgVFJBQ0VfRVZFTlQ/DQoNCkFzIGZhciBhcyBJIHVuZGVyc3Rh
bmQsIEkgY2FuJ3QgdXNlIHNob3dfb3Bjb2RlX25hbWUoKSBkaXJlY3RseSBvdXRzaWRlIG9mIFRS
QUNFX0VWRU5UDQoNCkNhbiB5b3UgcGxlYXNlIHNoYXJlIGFuIGV4YW1wbGU/DQoNClRoYW5rcyBp
biBhZHZhbmNlLA0KQW1pdCANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNh
Z2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+IA0KU2VudDogV2VkbmVzZGF5LCA3IERlY2Vt
YmVyIDIwMjIgMTM6MjANClRvOiBFbmdlbCwgQW1pdCA8QW1pdC5FbmdlbEBEZWxsLmNvbT47IGxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gbnZtZS10
Y3A6IGFkZCBhZGRpdGlvbmFsIGluZm8gZm9yIG52bWVfdGNwX3RpbWVvdXQgbG9nDQoNCg0KW0VY
VEVSTkFMIEVNQUlMXSANCg0KDQo+IEZyb206IEFtaXQgRW5nZWwgPEFtaXQuRW5nZWxAZGVsbC5j
b20+DQo+IA0KPiBUaGlzIHByb3ZpZGVzIGFkZGl0aW9uYWwgZGV0YWlscyBhYm91dCB0aGUgcnEv
Y21kIHRoYXQgaXMgdGltZWQgb3V0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbWl0IEVuZ2VsIDxB
bWl0LkVuZ2VsQGRlbGwuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyB8
IDUgKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvdGNwLmMgaW5kZXggDQo+IDFlZWQwZmMyNmIzYS4uZjJiZTdjMjNhY2U1IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC90Y3AuYw0KPiBAQCAtMjI3Nyw4ICsyMjc3LDkgQEAgc3RhdGljIGVudW0gYmxrX2Vo
X3RpbWVyX3JldHVybiBudm1lX3RjcF90aW1lb3V0KHN0cnVjdCByZXF1ZXN0ICpycSkNCj4gICAJ
c3RydWN0IG52bWVfdGNwX2NtZF9wZHUgKnBkdSA9IHJlcS0+cGR1Ow0KPiAgIA0KPiAgIAlkZXZf
d2FybihjdHJsLT5kZXZpY2UsDQo+IC0JCSJxdWV1ZSAlZDogdGltZW91dCByZXF1ZXN0ICUjeCB0
eXBlICVkXG4iLA0KPiAtCQludm1lX3RjcF9xdWV1ZV9pZChyZXEtPnF1ZXVlKSwgcnEtPnRhZywg
cGR1LT5oZHIudHlwZSk7DQo+ICsJCSJxdWV1ZSAlZDogdGltZW91dCBjaWQgJSN4IG9wY29kZSAl
I3ggdHlwZSAlZFxuIiwNCg0KSG93IGFib3V0IHVzaW5nIHNob3dfb3Bjb2RlX25hbWUoKSBpbnN0
ZWFkIChvciBpbiBhZGRpdGlvbikuDQo=

