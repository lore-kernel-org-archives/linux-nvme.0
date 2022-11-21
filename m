Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51D0C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6xHfMRsSjSfEDbTSoG8bpEXdzXK52YpTYr91FSPJkrc=; b=g+u6V4wxzxZG4sqr444YfMpLVJ
	Iw2+GwDmj3iCBItmVrd40i3QqY9Tlxcxl7LpCRbwsIHzMenSR/tK4dUjD2l28E2Zdp7qtkmESxPpN
	WbFQgMCH/SAmzAZGBdW753aykiYCznDp9P8MDhuTTabCDZfc5Psfc0Uz7KpSklNOoI9uSi1JUMoxC
	kBX1LwQGIPY+iewJt0M5knQ5sd/iyQHcmTU0WHtZD5SbX/1Ll9Yt4JYawDRvDQ802D4A2mozV6ZZl
	9wMe1J28hK+ifqtJw8Ep+DbNVtJpamUAsMcBqYNOLp9Fvi4wIboGjREyBE//+I/iDcIv23EkMdQqT
	BWZsIjMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox5ei-00DJb6-Oz; Mon, 21 Nov 2022 12:12:08 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox5ef-00DJHm-Md
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 12:12:07 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL7BP7D025784;
	Mon, 21 Nov 2022 07:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=6xHfMRsSjSfEDbTSoG8bpEXdzXK52YpTYr91FSPJkrc=;
 b=AllHMfM0jasInkihHHfJd4a0rpvf5f9VSEmVKZHfWIom2/8+5Wg0FglqR8Wt+qGbfYt7
 yIbTOdqjE1jOjTvaMWlpaXS2G78jdxxXmdFHhK8FUiuvbMFLmI5T42Jawu4Fw2l+UI7/
 pzXg02qEiGKJOeXrUVHnX1uBi2VNY/24VCjdDSr5c3T4NaS21sx2IDEHUgi8ZiQMCUC5
 Di6Ign/HO2bmwocRTjFewUjnPmTp5c3b3LoT4oAK3LTiaQ32T6INFoCVdyH9mMYXCop1
 Rvf1ajOvLu27xLlTl2d69THcntKXzjjw3pPDLEVS/2r5I+hh3YNzuAY22BBJ6yLF66j3 ew== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3kxubp6afb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Nov 2022 07:11:58 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALC6ubD005209;
	Mon, 21 Nov 2022 07:11:58 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3m05m93dbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Nov 2022 07:11:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmY9IS/ffuolE5g/tgR7jwvTBeMpLClOrEBtMrQxLCGBYpq+6OKbx7qXg+Tz1bKxmJK+JufnQoO1EPXyFbkq9Np+vxPNNZ8LgTWYpigeDUiFDYHncp1CQrq2TlgOOv1jSBh/WZyFZJjDxYTPRqRgn0iSWDpE0AiMAujbjh5C2Vbqfs3jhUDTQYWjmDXK0ZEbMrpEo5n9zD2gNDd8NSz1HICvSydu4fs3ODP/QAqm8Q4MbIlkLjKEf8V9sS1RKZXN8kGj7qyNXtnDhovkoPJnbL8ARdNrTguPvWS36oZNWjTSQih6R3f1tPR0YU3ZZYsnHQDCHInxYCSh1pbTwwwzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xHfMRsSjSfEDbTSoG8bpEXdzXK52YpTYr91FSPJkrc=;
 b=FtRtb1U7L2SI0HO1Vuli+CNQmNlNrJ62o0c50kLUHnqBdZWFE6Zxhq0FVcY79DEQPZmsbhxpFFNzDTw8Mddc6+k429bM92IBFxN9tG9kXP/NdZwcc276SAExHTRMcWln2+mZSo+7dbaulfAVkrXT9vtLONUIysWpIrmPQn58eJiijbIlZloujlYmYS4bMnFaE8AllmBV+QD7W7Yul6kCzOR2jp3JKCCtDZKXeSXkZIURv1bfhM+Z5+5g4sUVxBnzUlhXuvQkNn+jtFhpYRM18bqWfCUUzxa8ztYHe1/cFMKENvzLSeDRw8lGJAOQvdqfj+r0Ikt0vOknGfXUGCRm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SJ0PR19MB5611.namprd19.prod.outlook.com (2603:10b6:a03:42b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 12:11:55 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 12:11:55 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Index: AQHY+oZ3D5fYZrPgTEKaaKTSawClOq5HuhEAgAGKjLCAAAFEAIAABSLQ
Date: Mon, 21 Nov 2022 12:11:55 +0000
Message-ID:  <CO1PR19MB4885EADF8C1E970867C71487EE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
 <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
 <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
In-Reply-To: <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-11-21T12:11:52Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=44cf28a8-5934-4f6c-8042-54ded2c44bde;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SJ0PR19MB5611:EE_
x-ms-office365-filtering-correlation-id: 19f87aa7-93a7-40ce-1b99-08dacbb994ea
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  segvcJ2E+KimL2b0T0Yqt13bDZlfP/MmG3zjNhT83Nryee+CovC5L27C2VjK7qooJBjYgyktX4/ygV4tt/Fg/S/gGaalGpAtM8FLHrQ9RPBDz6rVlSDmRl99Mwsg+hyn7KDf6QTT/g+ChMnsAlYhQdfPZNuChqp5J+CEcx5B5LEsQXSBCXVvSIvF11mxEauYK/F8AG9SzFQRF3i6KUALPCQ32awoojZ6NqX9PeMBHpzq3YxVidoFlrEuozKCZfoOOwuxNfoYA1jJIU7qMY8InXrtqKhyAMCestjSo9uZOEM1kuUCVMfnGo7F3qevIcRaSfnbc92XQntWGl4YbKLtIqvo9FbxfzDk9QTzIsk4txdPR+lGSGV1Db+FutC4Rr10da5lD3iP9qY8/Zc2fNvlBqLHToin/Kak2swebAP3dYAXPTIpsjrzSgP2T5IXtIIpufLBIv9VCo3w4LgB+fl1XO0S4xDsAVTfPI+ZpDlpVgUvw/WBXgHddE8+oM+1rngoYrOw4rlXBnbV10W/oZ0N4UCqDI7r67Yi+XvWQjdjhgHf9VuCq0kPIGW1wR36qHWDG+QUbHyxNWidJqye9C+SPxYUWv1lA2uCyGLhWAlK6qGt6r9raY0EbRX67FQfobcjYvU6uGjXtuYKRQ4f3f447SdBy34Caby1kspf2msydPi4wCUpBCnr/i+hDVN803MCLb3SuTSuk2qAkbhPyN00lw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(52536014)(8936002)(786003)(110136005)(5660300002)(66556008)(316002)(76116006)(66946007)(66446008)(66476007)(64756008)(186003)(83380400001)(8676002)(41300700001)(38070700005)(82960400001)(86362001)(55016003)(2906002)(38100700002)(7696005)(122000001)(9686003)(6506007)(53546011)(33656002)(26005)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?QzFBaXpNanNnVkdwbm5SYVcrOGxQR2MzOThWWnpVL1hGK28rSmNpdXVuUFRr?=
 =?utf-8?B?cFJIMFo3enE2WGJVazV4UWVGRTJSbnFLZkxsbWEzclRYZzBmRVF5S3VvbDJD?=
 =?utf-8?B?aFJINWZZcUQ2VGQ4czA4eTNUSUxOdWpRVkhYdWN3elQ4dnJiY2p2OHUwR2V6?=
 =?utf-8?B?R0tRSjAra1FpWWFndnpqL2RhM3JDUGRvZmVaWForNWY5UDVsZXFmV3NyN2Yy?=
 =?utf-8?B?eDhTQ0F3a2NzT3VrY2VucDlGalF5ajdDZGtRTy9tSmM1RlVPSTBER2MwWE5Y?=
 =?utf-8?B?ME1WdDZueTE1eFVhLzhTTHV5YnVUK0luVDBTT1pIOTU0Y0t5MXB1Y0x4SlFB?=
 =?utf-8?B?SWRvdE1Lc1NyQ0I4YlFzbW54aDhzUEg0VGdDOUZEdExMM1ZOalNWNm5PWlFI?=
 =?utf-8?B?YnJuWnExQ3pNeS9LT0Q3eXpIR0xYRnJXaDBIZ0VCMDFzdFhXQko2akc0dTVa?=
 =?utf-8?B?VHhRenpNQkllbVZYVUxORFYrSUNydWNIQi9zMFhnYjUzSTRwTmxJVGpScGt3?=
 =?utf-8?B?ejhOQWM2cDlSSVJOY2Q2SHUzZFRVTVkzL1FMcG55b05sZ3lCRUM5S2Z4LytS?=
 =?utf-8?B?M0VPRU9qQk55emwzYW1iVkZjbUdzVG5sM0xWdk5DR3hVUk1FYVljS1BDRGpl?=
 =?utf-8?B?S2kwaUFWV3RUZVRKaGs1R3R6NHhBWWNjaXd2NENhTFhpSHpDSmRzYnZmaXpp?=
 =?utf-8?B?UHNub2crbmQ1Rm83dVZvT1YzTFZsRHJRb2hLYTN6ZDJDaVdMdU42M0g2Yktr?=
 =?utf-8?B?K1ZBT1RRUFVQSWZReWUyakJQdHdSY3FCUUVDT2pLOGgrMG9RRzFTRkgxTG5h?=
 =?utf-8?B?blpOamNUY0p3c08zS1JpVmJJRUZwclFEU2IvNEpmNW4wN214RUZvUlVlWWZI?=
 =?utf-8?B?Ukc1R3JWNFFDTDczd3Ftd1ZVWHlDLzU0WDVFbnQxdkZyRFJ3UmJianpNeU1j?=
 =?utf-8?B?R3d6LzVQQnlwNjFYbEJCbm95cEVhVFhFRmh1cFptT0NMNGtUckIzWDI4Y1Qz?=
 =?utf-8?B?RU9CYkU3UlNLQ0hwRHgzeW9oZmZmS0hJc2hnYTJnLzVKMU5PTytXeHNTN2tp?=
 =?utf-8?B?WkhrbWxLUTBBU2pwTE1rSjdRNkR4ci8xRUtvSWpMczBwdkZ0ZDEwNDNOVkpI?=
 =?utf-8?B?QzUrWFcvRUlyTHJqdkd2OVBwWWR5ZGtic2NrbHVGNWlJZHNyMm54ZzE5NFph?=
 =?utf-8?B?SlgvNGJCU0ZRbDBGTXdoQXpsdXE1N2s0cXNvdmxwMEZSMmNSMk1rQUFGTVVv?=
 =?utf-8?B?VExUam5XRnpTWmMrRDhoY0hCcktCWWkwTmM2ZjFOQ2dhN00rcGszVTN6UzBi?=
 =?utf-8?B?RzZ0M3RhZVptazlTWkRFNEJ6cTZWMWtycnp1b1VjSm11S2VhVUFKd1FVUThs?=
 =?utf-8?B?M2dwQVNBb2k4VGZ3c3k0TjZ3b1VYdFF1c1NWT3JwWElaZjJoMzcxalJERlZa?=
 =?utf-8?B?cFk0eHBuQVdFMmk2YjhjSzV4aE9wWGVJekFEQkxPd3FZdUN4TWRBNXFqbi82?=
 =?utf-8?B?amdjbk1jOU8weGgzNFIvUE1NNmFHVFcxUmJrSmpWbndEbm8zUktFYU1mWUZV?=
 =?utf-8?B?WFBCK292WnFEOGhwVS8zWHFXVy9NSFhuSjNDVFd2di9TalM0RU5OSTc2RHZo?=
 =?utf-8?B?Q2IxVkN5VXBHdlQxM1RXZlpqdTdMRUtrSGk1cG9hQ1g1K2tBNHQ2Snd4NXZS?=
 =?utf-8?B?ZGpVWTRxY0w5NnlDdE82MnF5dy9YUDcvSHZVVjN1dmxUcnoxUFZDWVRLY0Fy?=
 =?utf-8?B?cmk3QTJoTnZGSG10TDFXckQrZFp4ZFB0WWVTM0JkZitiVmxlSFZyUEM1L0d0?=
 =?utf-8?B?aXBtZjVkNW1iT1VzTnN1V3ZNeHpsSGFXTW1kQ1hYOEVCeVRTVnYzbzFNQ2Uv?=
 =?utf-8?B?MFRtQ2FqUTQ3QVNBWkxvRUpJa0VmTnI5ckJ6YklYNVNaTkxYWHdTaW9ZVEZh?=
 =?utf-8?B?ZHZSNXp0aHEvdzQ0TElmd0FROFQyeDFkbm51Tjh3WjFpQ0Q0UXNDZTlsVkxG?=
 =?utf-8?B?em1aOEw1bmcxMDYrU2FOdzB6RjN0UXRTdWltMW1yaUhCM1R5RTVkSVRtb2Fo?=
 =?utf-8?B?RzVUdWhndTcyUk96VGJ2V1p0aXI5M25idXpEK0x4c0FLeG9WTUhqOGpxaFZK?=
 =?utf-8?Q?MrcPDXeURmN7Lz0Fm4x7aQFeN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f87aa7-93a7-40ce-1b99-08dacbb994ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 12:11:55.3480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzxlLXe+eam0xcU0MkQCwrS5Pjg5KKphYrLtKYq7jqWJZzsgkvbU+Jh/9EV9X0VEz+g7t75K/N9AVfcBkV20dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210095
X-Proofpoint-ORIG-GUID: fSUprX3jqpfzgWA0hGounK6Z1XumRC8g
X-Proofpoint-GUID: fSUprX3jqpfzgWA0hGounK6Z1XumRC8g
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_041205_776570_BFD563A1 
X-CRM114-Status: GOOD (  19.61  )
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

SGkgU2FnaS4NCg0KVGhlIHByZXZpb3VzIG1zZzoNCm52bWUgbnZtZTA6IHF1ZXVlIDA6IHRpbWVv
dXQgcmVxdWVzdCAweDAgdHlwZSA0DQoNCldlIGZvdW5kIGl0IG1vcmUgdXNlZnVsIHRvIGhhdmUg
YWxzbzoNCmNtZCBvcGMgdGhhdCB3YXMgdGltZWQgb3V0DQpjb21tYW5kIGlkIHRoYXQgd2FzIHRp
bWVkIG91dA0KVGhlIHRpbWVvdXQgdmFsdWUgZm9yIHRoaXMgc3BlY2lmaWMgaW8gLSBpbiBjYXNl
IG9mIGEgdGltZW91dCAtIGl0IG1ha2Ugc2Vuc2UgdG8ga25vdyB0aGUgdGltZW91dCB2YWx1ZSBp
dHNlbGYNCm1vcmUgaW5mbyBhYm91dCB0aGUgYmxrIHJxIC0gc3VjaCBhczoNCglhLiB0aW1lIG9m
IGEgcmVxdWVzdCB0aGF0IHdhcyBhbGxvY2F0ZWQgZm9yIHRoZSBJTyB0aGF0IHdhcyB0aW1lZCBv
dXQNCgliLiB0aW1lIG9mIHRoZSB0aW1lZCBvdXQgSU8gdGhhdCB3YXMgc3VibWl0dGVkIHRvIHRo
ZSBkZXZpY2UNCg0KVGhlIGxvZyBpcyBhbHJlYWR5IGV4aXN0cywgd2h5IG5vdCBwcm92aWRlIGFk
ZGl0aW9uYWwgaW5mbyB0aGF0IGNhbiBoZWxwIHdpdGggaW8gdGltZW91dHMgZGVidWc/DQoNClRo
YW5rcywNCkFtaXQNCg0KDQpJbnRlcm5hbCBVc2UgLSBDb25maWRlbnRpYWwNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+
IA0KU2VudDogTW9uZGF5LCAyMSBOb3ZlbWJlciAyMDIyIDEzOjM2DQpUbzogRW5nZWwsIEFtaXQg
PEFtaXQuRW5nZWxARGVsbC5jb20+OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNClN1
YmplY3Q6IFJlOiBbUEFUQ0hdIG52bWUtdGNwOiBhZGQgYWRkaXRpb25hbCBpbmZvIGZvciBudm1l
X3RjcF90aW1lb3V0IGxvZw0KDQoNCltFWFRFUk5BTCBFTUFJTF0gDQoNCg0KPiBIaSBTYWdpLA0K
PiANCj4gQmVsb3cgaXMgYW4gZXhhbXBsZSBwcmludCBvZiBhIHJlYWQgY21kIHRoYXQgaXMgdGlt
ZWQgb3V0IFNob3VsZCBJIGFkZCANCj4gdGhpcyBhbHNvIHRvIHRoZSBjb21taXQgbXNnPw0KPiBu
dm1lIG52bWUwOiBxdWV1ZSAxOiBjbnRsaWQgMSB0aW1lb3V0IHJlcXVlc3QgMHg3IHR5cGUgNCBj
aWQgMjg2NzkgDQo+IG9wY29kZSAweDEgc3RhcnQgdGltZSA1MDIyMDA4ODIwbnMgaW8gc3RhcnQg
dGltZSA1MDIyMDA4MTMybnMgcmVxdWVzdCANCj4gdGltZW91dCA1MDAwbXMNCg0KVGhpcyBpcyBu
b3QgYW4gaW1wcm92ZW1lbnQgZnJvbSB0aGUgZXhpc3RpbmcgbXNnLg0K

