Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40F1C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 05:15:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14BB61452
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 05:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14BB61452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hWvbHZmi3zHkEC+fFN+V6fDKtSVqVEkRtgzBhFGIteA=; b=BZaraoKJt4SUwN1n+dLzXPRFf
	wbqGne1w1TCikRMmWpUm/hdJ7bNxV71enu5V/J9FL7ZcYIPFXY89nJXTkKcrA3OsYy4CxoBj3dzd6
	icdGLOP5jgw+Uhw+uyJRljpLf2YnCXHZ46Hdf4y4jB8Cwwncp5AIajL6w/99vKDy7eoF1wBy7U3Yg
	9cFo21msMP0JL6sxqBoBfwA746IQaJo9mwEkInD0EoZZ8ws4sz6wx4PMzcpJ+SMQBsA+GLFAxHBoJ
	xUBRZwndAscYIBv9GywCdD32mEtGlzuYru4UH64WN8Pn2mLvbtJ6oKChgv9/HprS/NwOXgLxEk5dD
	59rczK12g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcLUf-007DOl-Dm; Fri, 30 Apr 2021 05:15:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcLUb-007DOY-CQ
 for linux-nvme@desiato.infradead.org; Fri, 30 Apr 2021 05:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=eyrhld9Xl7b6XdUV/ZIWLCTBLjQ6N81fj7Jjh6ii3Gc=; b=ESjC9GtL5yXe9ThodVSNpcxiKV
 pLxUelSgabz5W4nyVxKSRhJaJHZMtDiP6nRzUEulwWeHXj2XPrhHzCh1Ac5x2YAFvm9qNGpAdB6Xq
 HjRO9yjZZpSrw1+hWKqOp3QwDu3WLbPnFWFhV8QW340Ft/TVgj+T+83I9HPbPbtLwMgjQYqEa2X++
 BDI7LtLUH/zlz2G+52+HpUcYz/HHL6J/a14WFE8ZJ0nT3TC7K/jzvE2WCoGE1+LqigKudg8FWNagb
 dhK11MZJos2kp8o5rvo8orp+0Q2qpMdVnxuKpxM8KLpTzyjgfzPknV9SXIMeS65HJ+O66e5j/IdGt
 LTuQc1RA==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcLUY-0017pE-3d
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 05:15:07 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13U5DXb1023252; Fri, 30 Apr 2021 01:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=eyrhld9Xl7b6XdUV/ZIWLCTBLjQ6N81fj7Jjh6ii3Gc=;
 b=kVqiX6KUIxAN+zG0//s+SzPkzre8qOjE5i/cHVqd/l3bdtYQ9u5B9W05jdYN4WFhuYb0
 EREEdSABWmOsAxTeInuAHGFyLPxM9C3JKZpef+mASwZJ5OdZaqE7f3n91topoaljqg8c
 m9xnJJ0ruyek59WZM/xv9wy2QTViac2r/1jf7A+SR7yXWdFtxTOpc1ufPC1OUApj0FvD
 DY7BtGymoExVI2nPvoMp/X4hz2lmOEQTslKFatV9Yqz7sLnwobPOizmW44/BmHhlTXDK
 497EwC4Y5Wa65Kft0eQhBZJXWrLW5QEPX3VFj15V0czSvP964JKeU0Df4RaIWYYbHqBp YA== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 387est5j9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Apr 2021 01:14:58 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13U5A9jX054124; Fri, 30 Apr 2021 01:14:57 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by mx0b-00154901.pphosted.com with ESMTP id 388a0710y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Apr 2021 01:14:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7vlQuZ5r7U6QVFsj9yNM6q4GLWb90pLz/H54XDwdg8CsjZ9LYYgOjRZ8+bbePlzClqafWy3dKbkfJKYJ+UogfEWwrR9lkQoqY+TtdwhTisRY798/LLFynNa5NEfP3Mw1ylexFLhAOOI6E7uhfj8P8Ljv/Or/3Q9GGP6pe6qv6rheGIkxRJs10CekCKr/0tePYW3CBFfDBhhu1NIIVk1y/fAU8kPr/H+y4/6dUrEF5/mjREO3/wiO8NaTMwWxHIaHRUbpICX2yrY0s6PANWZ3WqDrqsug6b6oe3f9f1xPsdn26zziRlSR/icKDMyjPSc0TKSnt3oN62X0wTxpupRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyrhld9Xl7b6XdUV/ZIWLCTBLjQ6N81fj7Jjh6ii3Gc=;
 b=F7WllecubqTYjf14GAggchh90VrrtRDUcemiDI/O8rm53+A97LyERZv4S0IERferLMwUd6dmLuwObG97RjwtzncRAKJ0F+PKiNOFNRzpUH4vNKdlY6IiH2uUQWWbzF9Sx8/vhpbfIS+SzdiKxii3H8okW5I0ZCHUPSQ2JYMmHVpgV9p+q6QE/20JTDg0pC7IqflVzvOZbEC+eaZBsZhYx8R9mZZaFDYgT02iWx0urnlDbiZTelrALp7hVu2MkDiqFiR5HJwMmvhsfA4OvA+qIrdsC78cGuIf7i/Dl5yr3ZP+e1HLhyrz8lUtwcVK4VXyTpiY5oPrhtcNthkSychiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BYAPR19MB2935.namprd19.prod.outlook.com (2603:10b6:a03:b5::33)
 by BY5PR19MB4067.namprd19.prod.outlook.com (2603:10b6:a03:227::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 30 Apr
 2021 05:14:55 +0000
Received: from BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::2843:ac16:7f75:35ca]) by BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::2843:ac16:7f75:35ca%4]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 05:14:55 +0000
From: "Rao, Vinay" <Vinay.Rao@dell.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "Belanger, Martin"
 <Martin.Belanger@dell.com>, "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Tarikere, Madhu" <Madhu.Tarikere@dell.com>
CC: Christoph Hellwig <hch@lst.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPGuycJt9Bz7cOUOllIRgoPqYsqrMhECQ
Date: Fri, 30 Apr 2021 05:14:55 +0000
Message-ID: <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=vinay.rao@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-04-30T05:14:51.5799581Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=80dd8340-1a5c-45e7-99bb-2cfbf33dbcba;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [49.37.21.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b1b71d9-9bac-4964-7973-08d90b96e489
x-ms-traffictypediagnostic: BY5PR19MB4067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB4067484A7AEF115F59B65FA98F5E9@BY5PR19MB4067.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJzTf1Cflgjz3yJW7SV/wLxNGV+tuKMOc+BRTK67VkJF4AYLCYHjNhMeUDy4LgRo2IZ4uoinbBnLfcy62Anev11g43bAv6+bMYN8ATvmX/3fbGYCLUCjN7ujBg6hHh9bao08g5mPNNrwrFg6vA30RQhIEwOd3CuMDXIef5WNHALz8tCR/TtEJcDIA/mufstCFVx1J/Xh23HZvrw8RdBhqVfm7gPm7U3nezeppddONCOWYHpmz779YWlvp5smJwqyB4HBb2wgfFPYIwrQ6XvCIANG6B/dl3wfAyi1kWuE0W2bSJ/nG/2pATzdRSFB75Sej9wE5MOAc/S5XU0oxYnORNprsbJabsWeKp0cvPC6WtNq3YijJ0uDMr5OE3v/anplnybElrtu6qZh6b11JVeh8/yaNlqztfHs+ueETE9mDA4g4MPJN3jA6c/I6DvUuzBKAxFCREHnysGdiKlYS+EcyvhlMwVZL2Pv1laieol4S+l4OjFF15g2IBbCXWVMYMkSqHk2FO6oXX5rIMyXFWYj0WKFvAmsnK1dZtlpLBp5a9BsyD/apH/+U7yoxbK2i6avHdOk17JXtD+WryAuwNCbRmbDDhSl0FgNZF7pj0d5QVk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR19MB2935.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(55016002)(122000001)(6506007)(64756008)(786003)(71200400001)(66476007)(38100700002)(4326008)(83380400001)(66446008)(8936002)(7696005)(66946007)(186003)(86362001)(66556008)(110136005)(33656002)(478600001)(26005)(53546011)(54906003)(76116006)(8676002)(6636002)(5660300002)(316002)(9686003)(52536014)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ywr37x0FAPguto01IN+Yrt93bq8VUWcWqxKxh7O5aXIeHuChAcu4Lx2lcFWn?=
 =?us-ascii?Q?o464KMwWhLWq5d9v7M0VsblVoNc3Z1z6j1qPrGgSCy3a3sZvUr0PK5ek0rw3?=
 =?us-ascii?Q?lzQ8/ES2UuUGdI1UuguufGR8FOjrWoZ+v8BT6BuzsnKfwE/oQ8wOkBplHaWk?=
 =?us-ascii?Q?5NygZSfwtSsax+jEBjOVbJn29uEWJ04lqsvnc8jyWgCD/Lc0O5l4L9Rzya/E?=
 =?us-ascii?Q?7ZNeqysSFSbBtxsFvEWpgGbEM/Qb5twT14hz0cB1JJPbb2cFkDxtXEqLaMXe?=
 =?us-ascii?Q?3RZ8jvu7HiNd6VveZYWQF+lEeFSDLETQHVIAGFCySzIX68nN8tpkw2mcrVzM?=
 =?us-ascii?Q?s07pfsFmqorxpmdjyL5RronXh8EzRt3YzvSAyVOsRCHSJCIce9caHd2QkLPt?=
 =?us-ascii?Q?zJO8G/HjqcH+qWGyJHBXnSfbmSwkhuc5Mz/0nqb5yfB5h5+IcCBX425fHKZj?=
 =?us-ascii?Q?g++BFVdJgSsLqqSQ0zFefF5Fyhq0shR2r9GkSaoo1ia+6agO4KBngO7xEcmP?=
 =?us-ascii?Q?6vRZn0U6J4Koq5tjYxA98eGLzFFnnOTOkiKMznhRWyIbh93mj0y4WxgtSXlb?=
 =?us-ascii?Q?4+1gifMBqwoDNXjtbpL7iyHlRik9gXTIz1UXJWnPyNB+6nnKIG2w+1Ub9bI2?=
 =?us-ascii?Q?h614wE7Xun3RFi6uLcwTBfU0elVbRbYY0t90jkjntHO6CZegYWqp0KGND9Qf?=
 =?us-ascii?Q?pjPfF8ilY678n1RvJ6Fgcrw5hq/RKMsiylBmBRniDKrXoQ9Qjb1U4/TDmTJQ?=
 =?us-ascii?Q?PnfLiIoFeZNW6kg1IuBiPlPDl20iQPa67zs/v5wZhZpx/F4T0s4VVdT+MXPI?=
 =?us-ascii?Q?R/sxkvvU16T371e9ohvvLnw1EAhrj4cXVmU+vSTcywsQ5FZXGQ36sl61oMem?=
 =?us-ascii?Q?t4DKpp07t6FMcwhtl4o+7T7MJGhuiZ9G7JyNgR9LiQQXocsAO82Ydn2EhkIL?=
 =?us-ascii?Q?ci5cMG0w5g1Bpm0fCmihDuKjhb1wQLPA/j3Dm06/urXS3GyZVI3quV5Ckn6G?=
 =?us-ascii?Q?jAL/t2CjAH1b27iNLU8X64eVQgh6SDIh73aMA9RZZajZ3L/qjmvHG1FZR1XU?=
 =?us-ascii?Q?kDqfVHSTysJADxfc4N2thTgMzbVF9wMPjFV/uUMlYOry7mbEtAMRVbNy9rDS?=
 =?us-ascii?Q?XAzxCY89WWgxvkyiIcXIEHlRl3YZG1xAbzqhlzzqsavG3bbsr6k8WPizTB9W?=
 =?us-ascii?Q?rKaDGXJISH47tQa7hX5D+o15hVvwzT1XYSgQpPbA5aJPURpoPbS/DoNbctKa?=
 =?us-ascii?Q?6Nm8KINfS2RqlpOK8eR2viSy+qi2RnANyud6wvHrOLziNm82ExjhleafmgJs?=
 =?us-ascii?Q?k1k=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR19MB2935.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1b71d9-9bac-4964-7973-08d90b96e489
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 05:14:55.5571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MT9MPxnR4tsz1uH1SoC1gBKXoX3g4olzYjZuTLGsR909Q/eDRKi7CK4cB5Y9buKj7YUjLZfW3/bwlRtK+gXbeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4067
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-30_02:2021-04-28,
 2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300035
X-Proofpoint-GUID: zvg98La62t_eX80pUUxBcOZ8vyixeWT8
X-Proofpoint-ORIG-GUID: zvg98La62t_eX80pUUxBcOZ8vyixeWT8
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_221506_225517_B405D24E 
X-CRM114-Status: GOOD (  30.64  )
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

+ Madhu

Hi Chaitanya, 

Some of the AEN's like ANA state change and Name Space attribute change events are of interest outside the NVME driver. 

It would be good to consider these events to be propagated up to user space. I am not yet convinced on how propagating this above to user space is problematic. 

Vinay

-----Original Message-----
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> 
Sent: Thursday, April 29, 2021 11:52 PM
To: Belanger, Martin; Rao, Vinay; Hayes, Stuart
Cc: Christoph Hellwig; Martin Belanger; linux-nvme@lists.infradead.org; kbusch@kernel.org; axboe@fb.com; sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs


[EXTERNAL EMAIL] 

On 4/29/21 10:09, Belanger, Martin wrote:
> ++Vinay Rao, Stuart Hayes.
>
> ________________________________________
> From: Christoph Hellwig <hch@lst.de>
> Sent: Thursday, April 29, 2021 02:30
> To: Martin Belanger
> Cc: linux-nvme@lists.infradead.org; kbusch@kernel.org; axboe@fb.com; 
> hch@lst.de; sagi@grimberg.me; Belanger, Martin; Belanger, Martin
> Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace 
> AENs
>
>
> [EXTERNAL EMAIL]
>
> On Wed, Apr 28, 2021 at 04:18:25PM -0400, Martin Belanger wrote:
>> From: Martin Belanger <martin.belanger@dell.com>
>>
>> Generate uevent on NVMe Async Event Notifications for NS_CHANGED and 
>> ANA. Today the uevent handler is not capturing on 
>> NVME_AER_NOTICE_NS_CHANGED (Namespace Changed) and NVME_AER_NOTICE_ANA (Asymmetric Namespace Access).
> So the problem with these events is that they are only really useful 
> to then issue the Get Log Page command for the corresponding log page.
> But reading the log page will clear the contents of the log page.  
> That is if userspace races to do this first it will completely mess up 
> the funtionality in the kernel.
>
> This is a bit of an unfortunately design issue in the NVMe protocol.
>
> Maybe you can explain you use case in a little more detail so that we 
> can figure out what we can do instead.

From the patch that I sent on the same topic to enforce a particular behavior either way, I remember that we've decided not to change the kernel code for usespace.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
