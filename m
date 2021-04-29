Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59CCC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 16:59:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242CD61441
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 16:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242CD61441
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5uy0fa+U07Hj4masuR1Tx7q3WJeUvEq5ub4aqPdlbWA=; b=PzxamjfzgAGMzxYsX95UoGC0a
	jsWmtYFNviUT/K8jt4EY1VAEzJbru3kz/0opWN73pRTJ+OJJleR1f+ukwntS6NumoU1CyDvIlJXgP
	AfvazxuyfLcoQMPPLC0Vxl5qEPKCrEum4gGDdwNvcAgAn9meAvt4IsIS6SOoltLtGUJjrCQvPDhS1
	mpv5NcLqBbyId1CIjMBHo8hY5MbEBLhg0SECQuYnegXzk8MuFcW1Mm0eVzhMhs8HlkbpnUqDShPf5
	hG+/iD8YuHWejIitnHm30Na9rDe3XL8ZDsQ9ttD/hcv8TcBfLd7H5H+RAz4rSDTyGYNiPT8LA4s8g
	G4mEh/cPQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcA0G-0065TE-6J; Thu, 29 Apr 2021 16:59:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcA0D-0065T4-Rc
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 16:59:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=1Hv+1Bfrw7+qtdxRQU1e9X0ArE1v1JaqMl2hkf6d5mo=; b=LuZphOIsabEuZEgzp2xPOUrWnv
 KnTUmBNfpPAidv1Ea/5RZWhv+JtHTcgO3gnyg4SLlq/Xr1DyT/pl6cu1KJ2CUDGS2QqWkeGNhKeml
 PGw7FQJbB7CyzSLjMdJtyzelNV5cqm9aX5Rp16c2V1sKgizSKJjiN2xw5BoX7NAkPh5KIOM5MT8hM
 socRg5k0aEKIbHUgQDaFeIUevehI5Wb5mStUQMZMVk+4IYnDFvjurARoJsmgl8LNay7zgsoTuOSNe
 9GyYI/Bo2RacX5Jvb6w2nnUyfUSjms4HefSrzAPFb+z7lSXbkQLlvEmHYRh+tA/JZxWQ0j9WuZZW5
 LXeYLmyA==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcA0A-000n4J-E9
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 16:58:59 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13TGq8ma023873; Thu, 29 Apr 2021 12:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=1Hv+1Bfrw7+qtdxRQU1e9X0ArE1v1JaqMl2hkf6d5mo=;
 b=mMZQ7zSRVuNG3U7uh1UHyGO/xrcLIdlw89E7OMxG7dNzQj8Z3zrohzcO4foNDp0vqHfN
 A6EqFiocDfiKJXAoFzvJTyvcFRGbtm5zacp5jMh7dT+bdBi/whWWcH+hDKGiyBZXtaOD
 GteDTr3SN2LPLIuViaVIY4mBcX4E3Ew4g2FgT6SqE3P4oR/cj1MTGc6sDtcOVIQg7KA7
 RQv3OgaejFvM/18hTtjplpkFcEyY5epmHUfToXaiqexWjbDGKr7OyLehEzYpjGclOjCF
 kadwqF1HPqzhnNYPdXRaTqR1uXkggFRkugT4mqW+rZqUXnog4NXtiYgwWRPgIT+Mjvqo 8w== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 387762web7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Apr 2021 12:58:43 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13TGtuek179896; Thu, 29 Apr 2021 12:58:42 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0b-00154901.pphosted.com with ESMTP id 387835ekke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Apr 2021 12:58:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2Ztcu3J3OHIf/Of35ANrDK0vV+0F+lv8RyocMs4hugwY7sB+Hf1JKy1RhgA51lBgpeyelXGjdWG8rT8Mu8g1LzhCXuSqqBM1WJ8hdEByEZAVXZzvvaE7HRphDYTIHjdcSYDmLhkXjUiDbHj6vcafvrSRYQhwhVhInuwdtFTQtTI+EyHgD19M7B7mcfcQWdVgO7OpMc9wBr5XonCtC7T36B8UIEP0gqZ7Xw9Hu259T6+v6ldvRBUoeuUbwpzj2zRIWE/LkuPZyIIU1ETAhGjIiuZoU/JbOc6RvX3hq1A+oRTh8Lo6oqG0/sqZsFlw/5Bi9Wt3Jvnz/RWvsX9lSlYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hv+1Bfrw7+qtdxRQU1e9X0ArE1v1JaqMl2hkf6d5mo=;
 b=FoSGdWRXIA2VzvAnVLQzfRDPZQw2SB58JQuEu7EK2Wm9uT4MxGF49r+h061qZvSOeCteXCZC4iffyix0KjO8x44+W4/g2cSrae8tXplnpRNsO7lJMKuvBpKCE+qjisF7wLnB4lWcEi+wfabiqqOLm79Jklp3I7Ryb+r8/78OVpOA7prMpU+nFnp5x6SgaYLVN1fI1qrSJtfmZteTKek9qrrafUegu2jpPncN4Qu978FG+QZTvmRemxb0Xl4wngSX+/ddEHD8Qq1xc3AjHylgO6rCgd7SFg7JsfIjJA/msFdleWzwdQsYmuGLFIQYMnb49d4zJsYeuKAL+c0QJglpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB3288.namprd19.prod.outlook.com (2603:10b6:a03:181::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 16:58:39 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 16:58:39 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Christoph Hellwig <hch@lst.de>, Martin Belanger <nitram_67@hotmail.com>,
 "Rao, Vinay" <Vinay.Rao@dell.com>, "Hayes, Stuart" <Stuart.Hayes@dell.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPGuycJt9Bz7cOUOllIRgoPqYsqrLCZQAgACu+Ew=
Date: Thu, 29 Apr 2021 16:58:39 +0000
Message-ID: <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>,
 <20210429063056.GA2482@lst.de>
In-Reply-To: <20210429063056.GA2482@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-04-29T16:58:38.747Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged; 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d04ada6c-faa0-4732-d583-08d90b300998
x-ms-traffictypediagnostic: BY5PR19MB3288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB32880B98482EEA14F56A4518F25F9@BY5PR19MB3288.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ouNwVRBIqw6SxcbLuUjTMXSh1+WxwES2zC2kL2wqNowJcWLkmp/hflph7wMb5scwxDK89F6Vt3XXgMPWKj1CfUnKG7uOuADO0AQ2gvJmfwHsD9XBmLCAc0MRNfTi9DflmBZzOloUqS14kq0EnbdKcSWcyYQBjJDAMGS2NZTSMm6LoUA29IlcGEA2WHv3WwkAdsh75l2pJKX5k4TZnf3BEGLB6uvX/knQkhrxCaboH+sxJXQGkKlDxazqH/gznF1bcgfyrSae5accr8pGE+FhVJVNEBTbo3qSVDBtosMdKZZRgWHobJhd2ys0RouYb73ZbjZFMTSpAAtf/ZvsxrrY5MWjGBBWDB46VvXVA7pRWkZigcAB6nu951ceJd66AFYbsZGrNmR+PbNs8mEjw6qV0YY1p0SKlnCTwPE+4eXV0uw/xjelNs4TfSB9OmC5j2zLQro0zG1eIfLf+zS54kXcY0TFf757u035Q2g2EIoKt5OdjpL+bf4xqxlgX0cJma4ePISlbm57wXc04Kc9zueVeVP/kjKnBC4rO9vvZPfBOY/gqXiVNuKb3W7Mi5KgRAxnUlnP0hFycAjo0rrXBtrQF3TdBoaYZdDWPRjnVmn5tPw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(4326008)(91956017)(76116006)(186003)(55016002)(52536014)(9686003)(6636002)(786003)(66946007)(83380400001)(2906002)(33656002)(7696005)(478600001)(38100700002)(54906003)(64756008)(110136005)(316002)(71200400001)(66446008)(66556008)(122000001)(5660300002)(53546011)(8676002)(26005)(66476007)(86362001)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m6Wl/LZURBJ9oXL5ECWnstNFdJWJRs4zy36FFrulLWgV4k7LKcBPKiZz4NA6?=
 =?us-ascii?Q?A4el3mEyGVFHQZBB/Vr/G7RmQGprFOoctFSMQBZcL/Q0+MxlZByeSRXV2rhy?=
 =?us-ascii?Q?BozPd03DJQw+jrf4TN4TZ6AdAxMKouo9miczr0j/DkZRTXyumiEcGgML2a+f?=
 =?us-ascii?Q?JyvOYXYfqKTGMakCkklDGw75/nAKD73Ie45UL+obMqJR6t2SyZu9ciCkdWVJ?=
 =?us-ascii?Q?ZmPBIbcvaQmxGUXa7rhKJh8IA2cdPM4wQQ0kcuTzoBXZtatg3CTugr41GL1O?=
 =?us-ascii?Q?Zh/FzgtgtLuxEBGxtl7Ty8gWJYf0FiK8NAr/WqZci+jCU5++HzXZkb1u80cK?=
 =?us-ascii?Q?eaYApkXmkzbAoGZiBhYvr3SF5gEY+DinGIKchTiqdE+xKem5YmCcauipmW4y?=
 =?us-ascii?Q?d8O7mYsRm4o9dKQ/v9v3kq0q8ulcK2hsv7ntmkY/DSNipeymWpdq837IW4Pu?=
 =?us-ascii?Q?kk/SIsHFJuYz3kf6tfxYMqG0znnWEJ3f+bO0D/ptegQErGeg1CurADE7jXRB?=
 =?us-ascii?Q?vGz8s4dsH0F5F5KTg2GTZpq2E9df6dHDg5BEFuYfw3n389nFOyDZEWbzlFes?=
 =?us-ascii?Q?nNb6n2Go+rfyPl5uFtwwCZEqqCPJGQ8W3G4FYQgKe6Q7pQ9ow7fhqDSeXrVb?=
 =?us-ascii?Q?OqFxby8NyvLXNNN9EZMqEneIjTjMNto9b97LUSsJv3JJeBh2aimQKosWgsBY?=
 =?us-ascii?Q?5Ay04xRsRyl/M6cx6sO9TGFi4ie1I8+1HkDY/k+KtTrUFT1IQQ1PcB2ML1Y5?=
 =?us-ascii?Q?HAqWkCNGbdDvt7MpZyAMGDKaN5jUDfuOozeYZU8UXQHEdP8TsI9ffzGIlYPg?=
 =?us-ascii?Q?UPqG9UKaLQTJ+zSi8WyQD47gvyF2ZH/QicM9al7ZifMXWU7J5novK7Zwzuqx?=
 =?us-ascii?Q?oT5ViNjBRcEP5n6vxw6PDUvHCtJE8CXHI8Yx9PaLgPOTObcqw455UbQ5ImiN?=
 =?us-ascii?Q?421mQ2zvdUPON5CCDM9uppsLkqeuhshQul+j2R2nMLqGSZS8PffYKYMqdRKJ?=
 =?us-ascii?Q?PlI7UMj+LEKj+BC1Q1d5fJvG2AMO1GtYW8G5yETgm8pBTHJ+1ToFHEuSb7nw?=
 =?us-ascii?Q?FjMndsFw0Qd8Epq+efhOxqWIqRxGKg1nN+1CPwLWthrHwtfvQAn9Ha1LKGSZ?=
 =?us-ascii?Q?dAiC/zuJ4COflSloC+RhIoJE1ZPVW7jAiot5TD8iDiU6xU+rJ/tvEn8yJKHe?=
 =?us-ascii?Q?YjPpKgJIQnyx7p2qCHNiGKmivM31LL49FWwe9pli1wvV2JU1epIC6Z4E5kM4?=
 =?us-ascii?Q?wcZDKF1eMaFMh6aRMOr7buWQcLGsS8Oczrzn15ZSN7HRUImDN2QOo5SnMuwj?=
 =?us-ascii?Q?n/nUbhgX4KcJ5aXKz/0VKqWP?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04ada6c-faa0-4732-d583-08d90b300998
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 16:58:39.5598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJG7HBAiN7P6CQUNGMqtFLCBKtVRWZYQdPaN7LceWLjlpdx18JgViOg8Op1cGRSJ69k1Lw2Vz+hp9D0pZbQyIhgvTr2J5U3492R2gPTNoOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3288
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-29_08:2021-04-28,
 2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290105
X-Proofpoint-ORIG-GUID: K_aQvH0c8yWfRk6xrEwz6pi94PIRJBKi
X-Proofpoint-GUID: K_aQvH0c8yWfRk6xrEwz6pi94PIRJBKi
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_095858_656688_6C985579 
X-CRM114-Status: GOOD (  21.05  )
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

++Vinay Rao, Stuart Hayes.

________________________________________
From: Christoph Hellwig <hch@lst.de>
Sent: Thursday, April 29, 2021 02:30
To: Martin Belanger
Cc: linux-nvme@lists.infradead.org; kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; Belanger, Martin; Belanger, Martin
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs


[EXTERNAL EMAIL]

On Wed, Apr 28, 2021 at 04:18:25PM -0400, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
>
> Generate uevent on NVMe Async Event Notifications for NS_CHANGED and ANA. Today
> the uevent handler is not capturing on NVME_AER_NOTICE_NS_CHANGED
> (Namespace Changed) and NVME_AER_NOTICE_ANA (Asymmetric Namespace Access).

So the problem with these events is that they are only really useful
to then issue the Get Log Page command for the corresponding log page.
But reading the log page will clear the contents of the log page.  That
is if userspace races to do this first it will completely mess up the
funtionality in the kernel.

This is a bit of an unfortunately design issue in the NVMe protocol.

Maybe you can explain you use case in a little more detail so that we
can figure out what we can do instead.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
