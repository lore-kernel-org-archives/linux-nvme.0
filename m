Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3C3C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 22:15:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FE164E2E
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 22:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FE164E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/d6IuKYacUk1UfosTT/Bw0RBrNW7F7q6Mhr4kI0del8=; b=JIdi+kKfKm8wtCtQc9xRYOsWGi
	6u4twNp8YkcM66t4J8UOEuLis6RG+mZuQjKstNIb4RPAiEcdyH+GI/OYKywA/PPb7h4PvKJQ0jIyG
	Us7eMbp1xqR0CiPtPQCeubs4XUrXKiafI6gTcVc1RsW54pR2mPwNtPacSa8cTG4KteCJuLJBBubI/
	ZJAl+1RAgYlA/SZlDpN/hpfPp4Q/7NUkju6mvIGNqBZNSsVVETXHEsPdrl1CtKbXtZ4p538u9PCWp
	XOFZNVcrDYZ20+w6WZsKxDjBCl9R8BQj30j72xplNe5cdBqxDLRZUQwg1xA+4jtTr8oQ/6zjEUA0F
	wPH8XrAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCV62-0001kh-VW; Wed, 17 Feb 2021 22:14:59 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCV5x-0001kG-PC
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 22:14:54 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11HMD33B009589
 for <linux-nvme@lists.infradead.org>; Wed, 17 Feb 2021 17:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=+XlD24ZZ3TnZ2OnIsRcUrvUN/a99qMd9xhQIzyzo5o0=;
 b=dNSKki50JX/HXzJJsBNVc5+e/HdtzaWHwsxa2iHg0WVJYSKkIf0v6njcYkgwU15aVNtj
 IDTt0/rU4Yxn1VCMHbNvxzyJnVfx+XqrgbNCL2fGsVmS56Iu32QyVUUWmzO2xrD4L5KQ
 8AFu8k/m8MaDtXTfVSNdIFc/kiiMhp4kK/IimDwSBwSQ2YBX5mhJi8Z8j9uMP52q+ppc
 GXVLCiX4baZ9+XUag/bOSGri2N+yv5kbGiOsow/XiasHLFOsG+jFuD2o/Mwg5XvoiPDz
 rGEkG1sgdWv8ZgkqJrA3trve3wozGPLE8da1esl6tTE+SBUcOUmHFoIZUFrrJ+iFIOzk hg== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 36pa7bx0nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 17 Feb 2021 17:14:52 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11HM9idi087679
 for <linux-nvme@lists.infradead.org>; Wed, 17 Feb 2021 17:14:51 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
 by mx0b-00154901.pphosted.com with ESMTP id 36pvuvp6ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 17 Feb 2021 17:14:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Onjw8k/SzuN80T9i1Etu+dD6G9oZQDDraTu40xscNz5y1m8E5hAm2e557+HPdhjX5LdR8+8yFNI0uUPi2XBIzLVyL+E+c9YcQn2GQcaJDKIZalm782kyp4FQmxeSCE/7LRuuBsLH9yy4qCI2/RgWy4prdQLV49IURWx25R1JilL33vT2N43OAfIcXfSQU4mLDz761k7SIGhVlQHVxZeQ0f5jN4Uhos7FMaA9N9ejmL4Hyba/UT4C8uJFTAQbEVckYWnsLBq6pGOFpmyGi2gS74ttIkqIEcs3CNd+5pZo942+kvG55/dSybjTvgNvegDVvoTWID1U//vEay5Ioe2tyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XlD24ZZ3TnZ2OnIsRcUrvUN/a99qMd9xhQIzyzo5o0=;
 b=Wjy3/2Ac7YN1nDRrgaI1BRn498g+yzxHLGwIXdsfzIxYPYvP6j/IVBVH0sL2DYQODJZoVRs1mGG2p8cFz8ZLjEJmHkaJrzlMx/8ju1ovRSQDAiqOxwMv69yQ1sB6VJ7r6i1ManFGVhYdrgtmOX9Ltl3vGHJN0ZetSThSLAHz8iSRwxf5Vv8sZioYty0lSe9PARqE3Y7Q38TPrdg6V7JNN14OifvVUuTjeUeuiBAclNO1kCl48YlZpGoJ/A2hXupbis6F3WqxbYIFWB2RqwX3VgpAHty8+5YtCNzcYvxdlo3oKKOyLuJ0XgyKwI0SXtQGU4Dx+Kvf6/SXQWCBDVKy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB3142.namprd19.prod.outlook.com (2603:10b6:a03:182::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Wed, 17 Feb
 2021 22:14:50 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c8c3:8600:d46d:f9c9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c8c3:8600:d46d:f9c9%3]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 22:14:49 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: How to identify the device created by "nvme discover --persistent"
Thread-Topic: How to identify the device created by "nvme discover
 --persistent"
Thread-Index: AQHXBXjtalFrXFZMzkC+tC9hLvIvPQ==
Date: Wed, 17 Feb 2021 22:14:49 +0000
Message-ID: <SJ0PR19MB4544BD8195099696F434E8D3F2869@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-02-17T22:14:49.431Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged; 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7b44e47-451d-479f-8a2f-08d8d3917163
x-ms-traffictypediagnostic: BY5PR19MB3142:
x-microsoft-antispam-prvs: <BY5PR19MB31428414C5354008E1468397F2869@BY5PR19MB3142.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0L/y5EZcYx0cTwA2X8kf+RCnMgSwsw27Q7UIZsLiz5fZ0LPQ80AQCdKAYPHaYlK9DkS4J61utyhYvHhGvI9S3fu/+U7suSYOZxw+d3X1J/OQ+U7lPAjn9KxeY2SGH6EUOccoec/dei+GrSLzZVtHxZoiSQqRTqMJUjVCovs6xQQ4sAzJaGlKzWybpUj3sJLM5BYsF23mnjnqs+4jVnlALj1NiRt4QUC0QzMY0WxCcam5Myq3ULmrD/KZyoXd4ImLHWaHsgzE3MrNuORtADSwWLvWX/3ENkFN5FMoYRwZV8OV6QojT/7Koo0ovSHDSEa0lRD+JhUmDFLGN9wlbfFOLDqUYKPQpkemSBvejj5EQlgv2hQ4I2rUMv3xhdH29G8YpFxMeUVaAycydK+Fhmbs6H8rP3IyQGR1HgMOTDir3CUzsJTv7cwMblkpLUKM9sqU/ilS+uMQNYcUg3ms8N9GDOlSrt0z1maeKB6jFlSPhg4EzaiovA3YXKeU30GxSu5Ga91yf5ZiFUayjGsr4dKvxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(71200400001)(186003)(26005)(55016002)(316002)(66446008)(2906002)(7696005)(76116006)(64756008)(66556008)(5660300002)(4744005)(9686003)(8676002)(8936002)(786003)(6916009)(66476007)(66946007)(6506007)(478600001)(33656002)(52536014)(86362001)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Bqt0MpoobUkrVLpXvefDSHnKqVlL0XaWOgz0VYFP/cLZgbxkyUPi4uq2cT?=
 =?iso-8859-1?Q?rG1QbMcpyAX8HVqEk91KU4RKsBHZr6D1VGKebsF8NtdooUmxN0FguEZBNa?=
 =?iso-8859-1?Q?yhqgKnifbiJGaswi+s6mEVkXRHKZEC8/ckB2hjUdabAcRzpYgVv8VYxO5a?=
 =?iso-8859-1?Q?ZbFL48dR0jnt87SQjkiquhD4XeP7v5SqBQ2OWEL6D+p+mwR1oAuZBMBnBA?=
 =?iso-8859-1?Q?HG2oVnkZzQ+T7lTbbDBZM6OF428sWWTqQVoG9fDuFEIgFvN3leOh29u88c?=
 =?iso-8859-1?Q?oitSz4g5AEC1bS68T1TPzKkRnwVbZJBcWwV8KwBRwLkkzwKK1qLK0cl0NN?=
 =?iso-8859-1?Q?JyyTBDd2vUeTDJT/4evsbPKvzVsnv8U1vB1LF01i8orRlqIXD8G2kEXQ3o?=
 =?iso-8859-1?Q?2WII+NwukP1Xl37J+GvB4L3KOgwtcHnYQRP4AvDwH5rLsxs9nsl88TYRU4?=
 =?iso-8859-1?Q?4Hyruw2Fi8SK0k5WmU/3UhO4wbUmaiOfejTgIvYlJIPNIdDCtsQlJWxzeW?=
 =?iso-8859-1?Q?aAHGF8MVwnlfYL2/Uou/KzEDd/Gd611r22o8UpMWDwm6iTgiRyj6jHHVs7?=
 =?iso-8859-1?Q?x9O9keFzRbJWEa8usAH/W49FXsSr8GMRlCBfP+xywgIwG765NLrU0lPKzf?=
 =?iso-8859-1?Q?lpi/DWMHs0dCAdJZyIzlG+6dptE55ocj+LiYMdE+Dmy0hKIJRnWLC4jvVz?=
 =?iso-8859-1?Q?+zyh6lPsIyPF28KfAvYKAgqRpFwW9HD4nDcO1nvaRpr62sQM/JoFZUDFM7?=
 =?iso-8859-1?Q?N+AyObA38hDHm4pK88GPUHeEeIwtQW3FYxWmDKwzr1AoGmBCZrSGAaZ2lp?=
 =?iso-8859-1?Q?y4vked8btD9TQJcflUlAbGBCp2cQo/Pp+BW4ez/xTA9SsbQahdUN+XICrn?=
 =?iso-8859-1?Q?B+phKWY68454PxBTGgYEO0KbXYaiA4EZhPhL1iXkefM53kpKz11eTk56yM?=
 =?iso-8859-1?Q?iofi5hFakaINHOwWGcE2fcHTWZtBsPmWJ5HVe1s4ZgjfKTC/q25x12ryvO?=
 =?iso-8859-1?Q?hwzCPR9+IJo8HvQjd7XNvSk4JaTJVf2NlmVQVB1aRAUFXe2UlwAKxj2FtJ?=
 =?iso-8859-1?Q?atSXD+xWm238sL6nBB6mA3VzoFKHBvIxy4lI4HCfa17pFzGczOehSwwzij?=
 =?iso-8859-1?Q?h57NicvFpYt/A/Fb75mSMpUCNvUOzM8xwomtuk0/xsxXxDlagEVHqW59ff?=
 =?iso-8859-1?Q?4QjXFYO3uMDa7wMBsYnP3RRq/Q17dIbEvUsZBdD7EBjJHu38e1lr6M0hLg?=
 =?iso-8859-1?Q?4wbdSAXiIV2035pBmDONxRZpg7JuSWWCdX8WxuxMtzZxQ1CQGGY7dnnMVb?=
 =?iso-8859-1?Q?PmN0bNDNX1saq29Oi5xDRVhItAlyoDe4U2YQUwom86jpGwZ76XRw/ToI4n?=
 =?iso-8859-1?Q?0wMnZDCjnr?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b44e47-451d-479f-8a2f-08d8d3917163
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 22:14:49.8126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxQk8M+BgrYFwXI4Kd24RL0KrmLJOu/YTGC5ofylDBmUU+2qi4IGWuA7ngmEL8DvKCWsXJ9Egc8sA63D6BTrxIUz2IiXzRSWRiojb3nsuRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3142
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-17_19:2021-02-16,
 2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 mlxlogscore=593 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102170164
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 mlxlogscore=718 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170164
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_171453_965556_704D1D36 
X-CRM114-Status: GOOD (  14.58  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

When I use "nvme discover --peristent ..." to create a persistent connection to a discover controller, is there a way to identify the device (i.e. /dev/nvme?) associated with that connection?

If I later want to re-use that connection (e.g. nvme discover --device ..., or nvme disconnect --device ...), I will need to know what value to provide to the "--device" option.

Thanks
Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
