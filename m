Return-Path: <SRS0=DVYa=NY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E59BC83028
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 17:27:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2852E6108B
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 17:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2852E6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=y4PXqWhJgyYBOpqhuQBB0rGpNHxB2YizyVr7Q752w10=; b=qVEcrkdtB9evlb
	0E+lnkDmbT2Y+YHTFO+BGsSE9vR07WjScBO1HQq3nSFi0h3wxmxJS1a0ibAP+zCnYCTmeiwNBFnX4
	xYK5vMYa7WEF2Bb7aZTK0AHAd8Qg7vuw3M6dDgkATRNtDbAM1XH3N8TVSP/GBUOn2l62Q5jILUQML
	Q/4WQgUAYLs0whFaA0TREIuC4T7G5sQLnTC9cfpVs04FWaZztfOsgbdU2kHUBKd+Y8wmKhWRBN0ZQ
	6LrLbgZryZmtQb3ozCDzYr+znavXQuaWqznPA4+Su/xeVgFyKBG/rerSveZEZCI4ic5hEJWWAqQuO
	Xg6xrnn0lqpQ/he0oJMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLqUc-00A7AK-VJ; Thu, 02 Sep 2021 17:27:15 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLqUG-00A79r-15
 for linux-nvme@lists.infradead.org; Thu, 02 Sep 2021 17:26:53 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 182HBhMp020169
 for <linux-nvme@lists.infradead.org>; Thu, 2 Sep 2021 13:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=t9Z556/P/96nzNA5qvK7fxpJ4dvc6WPyZ6d2iDFGapY=;
 b=I259E4NbYhnPlBybY02vKq5K59eb+9ow3jZYnPuDFpAWbJFcPjjUZCgD9Pm9JJ/CP2bW
 SDMrBfHzgP3YJkdUCbhNrXf/F2+3ujjt6HiJgxdYCkKlg6KrrlZ6DdavUWDUzBgvwUvc
 j6jLocPCO+6IkS0v2NRJ83Z1/FdeTup4+qQJn8MGI/kSA+TNIyDhXrudRKdCkW7JNKUk
 sRWPpBriJdLf++A+AMb9Xl6Rt8H6H+Vt8/b8Ga8QNG4Ixu+BOVjkf5XxMAx8CYZgyVom
 EgLwNL3h1JlNruvoV3DhkqeqsN3IuDDjfLZCWHwDfG/sg29+Yq3/0IuA7sg/oDpMvqVZ sA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 3atdxummfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 02 Sep 2021 13:26:49 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 182HQQmK005422
 for <linux-nvme@lists.infradead.org>; Thu, 2 Sep 2021 13:26:49 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by mx0a-00154901.pphosted.com with ESMTP id 3ate02u53s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 02 Sep 2021 13:26:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koRdAeB8ApIjGcY7pDHgver7UFFazyCJEvTEw+rNfYYkEow0j7Bhy+CnAW12brZja3Gc2PwoMnRXOp3UP7oOTMKo2Nvw6pZBXOBoCg+wVxkZiVlyanmXbtS7ZGj6AQufw1iMEvnIR9kOuC5jIgEDn5WfHtE/IVPyCfMEbOZgNmS6hw5dxX/l/vUg7cL0yDKcNLMV69Ho3syA7c1d5VVNq74D7o7cLsA+2X9Qbw8Wy38NNc9kzHaTf3h9yLyr0huwgMYtdZDdK9Eszg1ikliydgid3ptB+V5NgK6Kc2jarbBaulXzvczEapTxPoeICGgciJdXoK2U80iFcn/jAcgQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=t9Z556/P/96nzNA5qvK7fxpJ4dvc6WPyZ6d2iDFGapY=;
 b=dOnXnkphmbIEtCeQgR5C6OV/csj6NumjQ0fylLI+XJ0pEMjCjAYA2J7LAlvvRyOYI9Mnd8rtEAAlJusZl5/OHueF14X+NBmiZiR0+qNKggk2Nu5KtakDoW1h7SzsyDhFZ8b8muWOIGiIVirxPmyMjgxarAfMoI89HbEu+Jd58bWVUhuWjvfd526LrPtnWtONDemTEj8dD2JZ92kRXRjYehsjtjgmZlBiWlDYegh7bP7A//5hSj6AKVWQgvVHpHJLt5t/oQuPmip3fbPPkTAFHONqZXJIX2TnT/HsB7MjIxy/mGicyH63zJABBbeEBnMCMVAvJ/yP+RoLH1pt48lUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BYAPR19MB4711.namprd19.prod.outlook.com (2603:10b6:a03:9b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 17:26:47 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::88af:3327:6ca7:e439]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::88af:3327:6ca7:e439%9]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 17:26:47 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Problem cloning git://git.infradead.org/nvme.git
Thread-Topic: Problem cloning git://git.infradead.org/nvme.git
Thread-Index: AQHXoB7fYR9VoGr0JEuhfPkIxpnTpQ==
Date: Thu, 2 Sep 2021 17:26:47 +0000
Message-ID: <SJ0PR19MB454438986DE447DAE1B5384EF2CE9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2021-09-02T17:26:46.916Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=Visual
 Label; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard; 
suggested_attachment_session_id: e98a01aa-7ba0-8848-85bc-4bff6fc5c5c0
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbaa7608-ff19-4d82-60a9-08d96e36d7a6
x-ms-traffictypediagnostic: BYAPR19MB4711:
x-microsoft-antispam-prvs: <BYAPR19MB471136F073B684ACDEDBBA52F2CE9@BYAPR19MB4711.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FbPUHJGs2nWCL7j64uRYRCAK65ngguepfgd3ySs8P8npG0cDcDOk64BanP6RjNgGEdEzBUC3xr6cGfpRXGm060jSXvgl3x59Q+XlKOH0qruT+Y1iRP3wmX1uviASIdxci1Bfn08hB5wxxLHJ5xsQMItKHxOiOY7Q0+JmRLorAtjzhT8pVN0U21dAW4qKndvnZZDcuz71NGXPga6UnV5a1MPeK0qfw6pvyor2C3kOSIkqFTXyGEdvJEGr1VMt/dGhw8uRoW2FM9wDBrpEJSyRUDCd8fR14TsJXBRfV/I9ZBZrlkgcugEwacUbqUwQvz1eQO5Ly3Pme+p14eqi/7qXy1hmpbipwKCPv0xmmN9Ipv6oVCZodiPE7jcBuld40IUzP1tbaWMqf+BrDxo7QBBkxXMTlIAGECEVf1+CkNveeCltn1u8ICJPzXLcEekpvJX81PizK+YbsEbxZiZpZjDT4+kSgQ36MvPezw4fmy7SZXWT5Ouhcd51+hEsqz/fos58rXn7UA96nJglsWjDeOfVdBUKmP5YRX18lt4DqevZHKWGDBhnZsWDEuaKSsIU3Zkr1rqreBQFkO2BsmY7W/2JHhmLhq58fGDTt7ewmA097cFOhr/Y7uvWt9q+BLU3VlrkFJp8+m61JhZO4ZwliIZ6gFKhj3JMp2b6Z08mrz+C39RaWexlTZUlnWZIH4soG4W2fSaiJOuZLhU5s/1P+l7i3vFJEUDAH54cXYD4sxNX3dkYlqJypM3MGKscgnYo2PKec8YKu15X+1teLVb9owJvQcA009DueX/anOFTHuAvzM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(38070700005)(52536014)(7696005)(6506007)(966005)(508600001)(5660300002)(9686003)(55016002)(33656002)(6916009)(66556008)(64756008)(66946007)(86362001)(8936002)(66476007)(66446008)(26005)(186003)(8676002)(4744005)(316002)(122000001)(38100700002)(76116006)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FdFd9LTIROqjtPbHluQ27xQ4CnuD7fgRpqkpY5vKKQuCqAkMUBnW+iuQKF?=
 =?iso-8859-1?Q?ppQr3NoDyB5wzEuFy6ZcEIBbdd2WN1zYCZqfp1AiuO8nmDgYNAteoHJ1/V?=
 =?iso-8859-1?Q?1B0Yi7k7MRFOo/NDpyggAmAIESOFE3VgMbhfwtedKFf+4998/YbnSVe93o?=
 =?iso-8859-1?Q?N2JeKysJ/wtu0MhUicbNxJrw3sLw1F60NKR0rWrRuAtBYum9NWA0YKhNX+?=
 =?iso-8859-1?Q?ZabaJprT4pF/UHNdIC4nA4j71l+lOjhFVX9YQhjWv+7U2E1ZZl0kepTp99?=
 =?iso-8859-1?Q?JWDYsUbvAe/zpnzY1m+MNAQiYfIAPlXIB+wL5RfcJQ393Ik3FdGems0o1z?=
 =?iso-8859-1?Q?vMNbid6Z10ACzgmNSxoqq1KzW2KjB6OdDID/GDqVrFIFcVTYWL1ORP106x?=
 =?iso-8859-1?Q?4VdP+6NpI7JSbDCy87Kyj4DCPotpnxRfRDcosgCal1P0lQCxkellMFGCIC?=
 =?iso-8859-1?Q?XTg1l06ZKj1M1v+/+5lqfnDPqia3T7HiuEh4as58FY4KT5AaUFmEj2UgHL?=
 =?iso-8859-1?Q?Z55lp3xqwZtyf+fsHaFlVaWKPxMUApfzAH2YTwsAg7ZS7qzejMBXgvv+Nf?=
 =?iso-8859-1?Q?yoXX6jTRgI2wjUD6QjXozmCZp9sJsBL+LwXG4wuYTowAcjSiNZPzZ8Tdk7?=
 =?iso-8859-1?Q?viLE3hW3t/CoADdrevT/mpJKHKIW333HYlOcQikSnyUA7g9WEi18dbMhcp?=
 =?iso-8859-1?Q?luBzC8JQpfV6487NtQ7SildZh7o6GBiA0FonIYhbKTlV/WeSeEMtGYGNq4?=
 =?iso-8859-1?Q?nfx0BK7zT2qBdkYfoAgT61qw4OrsGQW1rMu7JWYlikG16O8g0zdubWHGoz?=
 =?iso-8859-1?Q?A9HIxyqxLPvqnAEYNhT4z46Pj/pa119S751YGx2w3t8CH+3wvydLV/110Q?=
 =?iso-8859-1?Q?1TK3H/+/pvfgvV8Uq1UuppJoghYk55UHSFhiqnCd3TxyuI1BhpUcy/NeVz?=
 =?iso-8859-1?Q?MOXbhrYUd+0TtIaM6+W4a/isI4BWQXN0+y/cI+WKvwtZPjH2aFpIJ+80fa?=
 =?iso-8859-1?Q?lbaesYSLQ1zAAcV/skxqAupf6MnqkxAYdHgFQ46J5zmSWYQUd4Zn/oXLnH?=
 =?iso-8859-1?Q?RLAZXQj/lg2Bo6m2nQrdI8tt6q6llj4RCscjBffcJsp8Bl7T6wzrTmf97r?=
 =?iso-8859-1?Q?hmNlJuTs756sBeFIqsTrBvqO7jXoOs94CiXCnJ9Ij6CFatWiGTOG3sDygH?=
 =?iso-8859-1?Q?c46vwr/QMmnc78ZxPQmJ9xoNYBx0ua24/ggJ0MXKZZNF24PCZXOGKTKNa9?=
 =?iso-8859-1?Q?H8sp1GZr1b2uP5E98Olzwtcdh/yDiTFnNyGUhlK71V8vTAFhl0UR2JvhbI?=
 =?iso-8859-1?Q?JQYVe/JKZro0diyvoC2fvga8YroTMfsOvr3rYRqbn5FUTyoSn1E/k7I6rI?=
 =?iso-8859-1?Q?a6j/kEynSn?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbaa7608-ff19-4d82-60a9-08d96e36d7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 17:26:47.3486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfjFlyhhELHXixhrFrvx1YEETL3R0yKhYCpzp2JBIFtu+favA8E0LC000JHshYN542GgotBMMG07RbZ56iZVs31A2M5k++ikcJKjsEpSISI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB4711
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-09-02_04:2021-09-02,
 2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=465 spamscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109020101
X-Proofpoint-GUID: iYkbig839KFkS2bO2wZ8ZBcZFh48RXll
X-Proofpoint-ORIG-GUID: iYkbig839KFkS2bO2wZ8ZBcZFh48RXll
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=608
 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210902_102652_166910_A9F43605 
X-CRM114-Status: GOOD (  16.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've been cloning git://git.infradead.org/nvme.git on different systems without any problems. However, there is one system where "git clone git://git.infradead.org/nvme.git" doesn't work. It simply times out. I suspect a protocol issue because I'm able to clone other repos using the https protocol (e.g. git clone https://github.com/torvalds/linux.git).

I have two questions:
1) Any suggestions as to what might be the issue?
2) Is it possible to clone git://git.infradead.org/nvme.git using the https protocol? What's the URL?

Thanks,
Martin

Internal Use - Confidential

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
