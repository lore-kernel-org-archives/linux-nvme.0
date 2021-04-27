Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89471C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 12:03:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFE060C3D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 12:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFE060C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6J5P0+iSrSlwJRgPEJfxb2uDu37OrSSusJqLaV81Dhc=; b=d/s49sEcdOVxka3qCTjn1UG3g
	LpcjkiWkLW/Jb5RwrNz9p8pBj5LAFgfI7S/VbtIRLQT/vvG+cZMIAHEctzH175pa8ktne1aUyQyKf
	F5h4PCbnmoHs1dbCQDSlOitMIithU47yfCZZ8sDv5QPXYtB/t0lsi9qycQRBTN389fPzZp3lEQUhA
	JdvHoShAk8s4lfKiML1A6Pl27j8GD9M9zkhO8OwPnq5bCkqGYEBuawb2WXfifVwb+yCuh2mpVgvZf
	JFYalvDGOhQ2u+LwuZalvtIeAhlxJantyEoSuxjtTYVQj6z9w+x/DPQpQzG0H3sllvFH62SjjkEmz
	5hINJ5bWQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbMQt-001Zp1-Qx; Tue, 27 Apr 2021 12:03:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbMQo-001ZoQ-UQ
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 12:03:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=uILVY6O7ZqUnFAehUPFYgbdDz9kz+GC3pYbf/He2wKk=; b=YpfG0F+9RRPEOPIlWpDzM2XS/r
 t6OpyLdjUFhKS/l78FvsEVfPZ93djMtN+O0Lj2PHvX0uMUBEIGefDqN7GNTOizFyN2W4mb9CzyJHE
 pv/X6u76xs+kXxF4Sp1KVDMKR2KCnTELUtE0U12/LV4rzLw3zrox4MfGcI9XlDstB702QzLt9H0sE
 F0nbKQRxOa7STfjH+YkopxVSr5CX3xmKbsjTmTUOnvUQcB84QmKRbQp3s9z3xQAHnhseTHtjDO1pI
 2xWDc6G0+vyydbq1e/fVCMAai63zqtBq/J/vZo6WkLL4H9lKbO91KskTR/QaexPq7DuzDz1IKg2Nt
 /lIbwY+A==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbMQj-00Ghx1-O3
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 12:03:08 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13RBwMgk027113; Tue, 27 Apr 2021 08:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=uILVY6O7ZqUnFAehUPFYgbdDz9kz+GC3pYbf/He2wKk=;
 b=Rh3UZpqoIaW1LND63HcLEzSr/jx0JuR89bUuT532RLrv0yLSS7jwUHBIBJtrvRt6HS3I
 Tf8hdbzpz/HtjLBHmC7/d/Dfbo4wL432ZV0WEnc18ue0U2aNVNOvDFQnIuy3yCLnidcP
 vJhxPUB0XPnuh9EedcwyHmUZHUO53d9BpqQAwu6yUMNUyOWkYxwz3RCyApG9OMZ5iRlJ
 1DGqBxeBSSfVmk/XAAomVWmEsXtiyx5QEuYG4Wws3DHpqa/rbe6eZxDi587ZHcUQqoHG
 RQl8+Ef+GXIhnunipTc4MGXRh5tIjX17HDbkqGB+jHvY4Vq5ds0QfEQV/b+xpKoT0Jd+ lg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 38600bud09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Apr 2021 08:02:49 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13RC03MV038571; Tue, 27 Apr 2021 08:02:49 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by mx0b-00154901.pphosted.com with ESMTP id 3863qnjqxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Apr 2021 08:02:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLzy3YIJYBzavSG0n3s0XEgE2HybeOyd0bZGvH7Z0rt5K52yyujGdGniWbRET5U2tR3/fw248gJoJRWz30IyoFkTvJyZmsjslSfgYn8rxnLsBBOaYtEJ2Oc7WGcuVWqWIjvaywNgosLLe6FDWcVp1cEh/2z4KtIvlLDzzsOmqve/16g3tRYSJDevzvtZmz4QlcZivRIZ6yFMaXkOImh3eVLz0OVKH+Y2+6eUwDyT2JVZlArzujVBXsRa7/7/VdQS15xXDzZEJJAD4cJQmLx9xTr03lDGBYMg62C68OduoVSpZViHC/u8GcaV7Nt+akQKcKuPHEldWo1KkUy8FiiG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uILVY6O7ZqUnFAehUPFYgbdDz9kz+GC3pYbf/He2wKk=;
 b=HoK/6jX3jSephmfxEBoO3I32TB6kiyO85ANxf6QYiQL91i9jeL3LV4PbZau7T+XtUzD1Lco6pl5djqR0YaozKNZpBrqmu1c99xp8JWygOqBwHPpapDbyZ/OpwwSM5YytbqE8VHuc+zUA/dBPr1wylxdLxc6BxPZLqC4xjwD7ltEX4Uz3gOGyVRJ6eyYdbpwMaXIsZ1lrqq5dGoRFWnFV4pBTUkjWWpfg89GEdiTF42NtIuVG8Hz21YwdqzIxyjV42CefQT0JIE8rHAlzrpozUIUuhyiyHDEL8o7D9OfzRtqcksk2j7vFMmOMqMBb63xVaG7j+/EmpjvVR9BidheMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by SJ0PR19MB4827.namprd19.prod.outlook.com (2603:10b6:a03:2cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Tue, 27 Apr
 2021 12:02:46 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4087.025; Tue, 27 Apr 2021
 12:02:46 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Martin Belanger
 <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] Generate uevent on namespace AENs
Thread-Index: AQHXOtrQJIxM4+p3wEqBbfroR30jnqrIRBFt
Date: Tue, 27 Apr 2021 12:02:46 +0000
Message-ID: <SJ0PR19MB45443BABE01370BAC883B32DF2419@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20210426202842.42096-1-nitram_67@hotmail.com>
 <BL0PR13MB42914E1160F96F3EEFE518009C429@BL0PR13MB4291.namprd13.prod.outlook.com>,
 <BYAPR04MB49656A4930E8A4367DFD9AC886419@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49656A4930E8A4367DFD9AC886419@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-04-27T12:02:45.899Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged; 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d487eb07-e5b0-4a6f-e978-08d909745f0d
x-ms-traffictypediagnostic: SJ0PR19MB4827:
x-microsoft-antispam-prvs: <SJ0PR19MB4827C9A95E60F4F4E84DB361F2419@SJ0PR19MB4827.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SdSZaBB9Y5TMbUNxJRBASuBJtCAmHp9fxzktwvQ14y4aeKNxhcX3/0z2qRxSUGz+AX0AIW+hQoFsmzpv/EJbkTi11li5E4qRYqCYtaOdUotxrns6eBTG8yMkfflbOHKA2uSnaZyVJ+z3Q8qlGDyjcfb0Ky5mlLQriwVsWuVe+sIQOuGuos57EeDcadgTaBRG+2/1HxmqwpSDNpOGmTR/v2ZLezanOZJuejpeGLnNy98J1loh92oy0AwZhkIvzCn7qoEOZf0X4pbtSiaeCC1/p8EMWOfT3gM6C/V+/sC7TJXrl3Er52BsNkY2JZu40XvhpJtzDGAhxnOpgyhSn5ZKKtyWiMM5pd1p0dmS5VmvvQFGtBW7drNk4yOLV/gGUcOJWvy/zhkNS1D3NT9zzL5iHkIvuk4Hbk77SZbII8lKWFnG42OXD1IO/9JMpqAhQgcPVNAr3H7jRMGWXbUxQVNsELvqMsx839M2eb4Js8ZNN68fI4MU+GgdyZyJJSq0cWF4Iy8lcLXlX//FpyABEUztDCjye8sXZiunwj/Mqk1llDPHZzJC1z6lZYw0/BBqpRpq4yJreqjvxinBwfpZpZqEvVT5kaGqOAcjT4fLvcrPp/o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(86362001)(4326008)(66476007)(66446008)(64756008)(76116006)(8936002)(38100700002)(91956017)(52536014)(66946007)(6506007)(66556008)(5660300002)(26005)(55016002)(2906002)(53546011)(4744005)(71200400001)(8676002)(478600001)(9686003)(110136005)(33656002)(316002)(7696005)(786003)(186003)(54906003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vBddFh2dilHbrEHSnWAHcNJscAgV1v2lxdZODrnGUiWM5t9kEqRSDBTQkdjd?=
 =?us-ascii?Q?INsS/YMJuyGLclp8+bSHBh2AAUr8q2LkLwSwHwouhwZK6QULLcyEoL2hfc1G?=
 =?us-ascii?Q?q0i586cuIzu9iedN25j0cyH5k8XRkNQeNrj2ErPknX7hmxdUrPTvBxmznkxK?=
 =?us-ascii?Q?ytP4ITpQKoWFRineGDyqAF9hDZsccNl8r2V5wgEreqh1rPkhGmMnmBJS/uDk?=
 =?us-ascii?Q?WRkNnudJHTRZplQwbn03ryJbuB6voY/vs11+gJDD86pDQy0NJrdsu3MJLkPp?=
 =?us-ascii?Q?f5/J2JXhnjbWWglixGB01znFOtwakoxYlsFBDYq5YEFxC4DA3taIcAtYrren?=
 =?us-ascii?Q?wAQD1KXJ9WT1Sy8aRg96hqW7DV44U8r0wvr84e5adZbNyGA4THlCtNR7Agr6?=
 =?us-ascii?Q?VknoG5c4IKAEvPg/Twwi3tVwwdBjULMTzTsOVYFAY3ctuYls0z2XB+5VxU1v?=
 =?us-ascii?Q?Yfuivuqqxin/9dD1qLs7ZH1SImVHZrJKdJJPURh/f3n2WVAkk1Rq7DUoe9bv?=
 =?us-ascii?Q?5fDOPHIciZ3glGj3a2L3Z0RRlTrgMm1grfycDl6KK1clSpwpVObz+8nng14U?=
 =?us-ascii?Q?mBe7y7jHOyZg9kl7/0MfbViDjYepP6BVgy6+4WgyIFYETsLbosq7IluoDkHb?=
 =?us-ascii?Q?hxob2fgrQHLWllGJE4DR78DZZLRGXXQLrImjGacRqjAZFvHNaMopK/wXkmmj?=
 =?us-ascii?Q?4FNcOPi/C0Nl4GPbls9v7SPvVx4lbYrp5akEK8q6EeGz4VqoCXTFOP4Uhryb?=
 =?us-ascii?Q?uVKcqGStmQr9FDFABDgZscI+tnkUy0G1GlGRgVRk+aWGR6doXcneHMmN/OSv?=
 =?us-ascii?Q?1O1syDLzLnT7xmeW8OYleeA/fjKIJpbrYvXDgBEZWRCnvFNDV+QX0571FkCk?=
 =?us-ascii?Q?YrL7YqAogptgB2Vc/HfavbxwGwLNAGHry1gTyQH6nkkdpY/mejnSg5wLEuvA?=
 =?us-ascii?Q?s35D5pGNPduT5k8ReYb/p7mWn8JDuuaxvunlTdaPoG55T6kEfMNt5K03NKHZ?=
 =?us-ascii?Q?ez6SGlZblaSJ+2P1yJ/SR0J5ftmiVdq7tL42M3KTXsijGt4sd4tAW8e2YhMy?=
 =?us-ascii?Q?yYvB7//U+SQvW25NL+cdOJLiPa76v1mqojKhti7CjAN5o/Vfn/gTbggE/pFx?=
 =?us-ascii?Q?y3/XQV8VOGc0Yn5yESn2pvku/5PJ+blw/b1l6Fd7xDlDG0cXWH1d5op1g1VK?=
 =?us-ascii?Q?1o028vDIIx0YfJt6xoElBwO90D8a4i9RseNogW3D7bypFITa+Hn+cgN2319k?=
 =?us-ascii?Q?VQReymP/4kxpZo1Rjad+g32IQauq+UYfhmQhvTYt6MSljnbL0SY47xotsAsO?=
 =?us-ascii?Q?zgxPYf5I+T3xMGiVavSKGzAN?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d487eb07-e5b0-4a6f-e978-08d909745f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 12:02:46.3387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40JqjMnaxwAd99/4Fu+p/7KoSwmlA0sOWuVvjIzZRB4GgIP+R60HCGWya/kd55KGJ66gET41I4uY6pwNeFjqksf1CKz9G4cZ9EMx+XOCJ0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4827
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-27_06:2021-04-27,
 2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=712 clxscore=1011
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104270090
X-Proofpoint-GUID: nlIHOdpfhGqBlmy_yW2Zi5gKv7NfBK22
X-Proofpoint-ORIG-GUID: nlIHOdpfhGqBlmy_yW2Zi5gKv7NfBK22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=820 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104270090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_050305_969801_BC0F654D 
X-CRM114-Status: GOOD (  14.61  )
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

Hi Chaitanya,

I'm sorry, but I'm not sure what you mean by "proper commit description". What is "improper" about the description I submitted.

Thanks,
Martin

________________________________________
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Sent: Monday, April 26, 2021 22:34
To: Martin Belanger; linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; Belanger, Martin
Subject: Re: [PATCH 1/1] Generate uevent on namespace AENs


[EXTERNAL EMAIL]

On 4/26/21 13:41, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
>
> ---

Please resend the patch with proper commit description.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
