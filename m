Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A06C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2HMLkV+fmkqIFY+zXT8APLPLDch2tFd83f8dQlTRR7Y=; b=KFejvyCbGE3RLTNJATzaxOqp2t
	VkoS8L7nNqWlzQDUpKq4YD93U/c1edk8JRsy078s6Oa7qWqq2uzdtrDn2hEqfHGBVSgQT8x0BRuHN
	7mF7VuAT0AWmcwDrIacNTG8bzPVsNHnH0tvMIJuLyX3TW8blPREHSFUFmIPROQa/Qexu1BHE5jjTM
	MwyXToYZSRS/5KT2r+kuooFJa1xOk62Yh7jtqd/yU9QwTY46ip1BLX3e8WIzDDrQ47rhX1XIisSNN
	oW6y6CL3qNXiNsJfXNYOMYj2p2EltuStVKvJXQ6xzF8fynE3nreeRfTQsVZ2LYxFPVG/xvh/G8aKv
	zPD467Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzJow-002fV1-Mf; Thu, 09 Jun 2022 15:11:38 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzJos-002fSn-G0
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 15:11:36 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259CeDEh019619;
	Thu, 9 Jun 2022 15:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2HMLkV+fmkqIFY+zXT8APLPLDch2tFd83f8dQlTRR7Y=;
 b=wf2KAbgN1/v5udCSAb+6tqi5uy7YO8ZgnBYcg7EkKa+VYoomXBkenKQKbMKD/TKqVUSy
 xKEeKMBj6uw+hzMNn+aCR706uNjJ8jfgrmqecBelXLYz40ecu8yiZC2euNNqCJtTYaB7
 Wd1Ob6QgUMSXNJkyFPy56rQNtcPGz8kc9BAc40JCefkkJZl0b54bVpjCasWjZzAr/Lfr
 ycm/M8HASZG8ZqQV7WL/mRissA25LU31x+OGXohr0nBg7UEX0VCpwLM7gfzIc0TIxZMB
 DRXxuj3BQ3f8I2w21q6vLksUd1EsM9jDEuupalrRTZH+4fqOkhdYPsbnAjjFv9trvkXS eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydque12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jun 2022 15:11:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 259F6oSe035266;
	Thu, 9 Jun 2022 15:11:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu4rks7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jun 2022 15:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buUiLJtgQOKjQHkqw4OII7kgjAzt+aBgl/oIdx9SIu9whKD2L4W2VM3o4/FDe9Z8L/CxLksJ+iMbrLESm6ErGqSRSzvIKnfQzhrEAkilN47wd7e5bNYBZ8aEBgu6EsCaYVOg5JM7Kd4BCRmroSishtpLGnp+DMW1SAUoPHarXw4rU035kGdMshtgb52+eujFfJ/LPLO0GfVSc+e2FwA5ErO09WILmO+gn6HEBsCpgQsxEI2Ws8o0rxc+8Nfs8ENK5HK+1hxU8hP2sMd9ND1MMu51FM3T05wUQDHXiqi8XwjIyJWVSeUpfeouvKKMJ4aM9YDaQ6wSaoNhwLd4n2EneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HMLkV+fmkqIFY+zXT8APLPLDch2tFd83f8dQlTRR7Y=;
 b=EhXCIw0ptWSt8kjKkdafML+UH+r0XirWiks6pHD+Vq0lxams9G2Rsd4INtRkpFULgGQVh8M5PJw3std26lyLV0NEJpVpU1IZa7T4udi7xunlIOcOBeOUk4I2o45vVg05JnE5Y95GcRn7Ueq5lMTEDR0ErVqjZ+QWb/RMb/dREV7e6WzKm2rFeQaiJ5M3fG9aVbVlf+sSECsjrtCR7vTlxo0X8qBJcKrv9O4k7M2T7pDzHMeMcOyPoZfsk8pvfdpHjZ+cnrBCnJOgwkVrWt9wl12ABBqjTrDEOtj60ppC+QVE47Zf8ITRJ3x8EApyVCEoALGA7dAX+kWO5SpZlGGBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HMLkV+fmkqIFY+zXT8APLPLDch2tFd83f8dQlTRR7Y=;
 b=PzOwbdVvz2Ry/5Xy5W9m1EiskXa6dCi4+7uFjLLouPos5x/kruWacN36R2UUAbhPF+eafsNH/SOP0UtEjNoBxdcIOn3Q++Y2LuUtrX5TSwuXghd3Zs0ZUdfVybsTvx2PxsQSXGt8v9E8OpiHcx7LEpHRnGsI4s8jA1dKcvZtpZk=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CH2PR10MB4310.namprd10.prod.outlook.com (2603:10b6:610:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 15:11:17 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5127:4537:1880:c8e0]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5127:4537:1880:c8e0%7]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 15:11:17 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Luis
 Chamberlain <mcgrof@kernel.org>,
        Klaus Jensen <its@irrelevant.dk>, Sagi
 Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index:  AQHYKbXc39T2BoiygkiETee4KuxaGazldeqAgABJzICAAB64AIAAlJYAgAAa2oCAA+JBgIAADcuAgAwnQ4CAAhongIBKtzYAgAJPjACAAKy4gIAADwUAgABa9ACAAPYhAA==
Date: Thu, 9 Jun 2022 15:11:17 +0000
Message-ID: <48506679-81FC-43FB-906B-7C565C3B06C7@oracle.com>
References: <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <20220608075252.GB13027@lst.de>
 <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
 <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
 <c0a42bcc-0d2b-7999-78e8-cfc70b0fdd37@nvidia.com>
In-Reply-To: <c0a42bcc-0d2b-7999-78e8-cfc70b0fdd37@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a89c9e3a-269f-4467-3285-08da4a2a4d43
x-ms-traffictypediagnostic: CH2PR10MB4310:EE_
x-microsoft-antispam-prvs:  <CH2PR10MB4310C6EFEC9C720D3120EA25F4A79@CH2PR10MB4310.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  yYK1BzOaiTcKA50V/rxYjpoT57CaGGUNTRCBTJd4l6FttlY9T/VfTRmORquNxs476OEQd6gL1UEq0o14JgtKuAgdzynbZGsnXFvLF2nnjTAwCcKYjoWckLDpTSDU1vPjp/o+ogFc8pC/6tb8NbePtHt3RQAViJvGcYKArP3e5dpwS3lrwI4xhFPvJnGkoY9hs2SEGKkZ7dmA3n8tiZWdJX2CD2zqhPEDmocStkI3Ak9VGVzkl1CQ9nPZXsqwXmicqu+n/ZhP40hZ7/zcwEC7NNylRtMXiNGYTETmb6PxFJukKJZXr6PpBC0TV4Qx/zuVuFAXfHjDjY+kfT9fou1ZHmpdOL7eNOjhxkvP04cJTT44izv5QruFHnw8XCMgJAwhAxIpQrMaSmpZk6JeCtGjP8T7k+RCtWetsf/eBGxqWCiR00NFBavmo2aVh1bMQbaAAJxB3/lhfzHPYTklmyywkHfHZEWI9PJicKUEfNa2DgMyqPnZ+A5aq0e0sJJYeK3U8N0iUqx+K6M5tMwommqHxzoW0I473SRs7FIvwt/q2UYa1yIa6rvhBwGzkQ67xewIRHSYnBr1UVVxIicG0fKOUEqzws3ROQjwcTcNw22af2piRadtBWBqSucFPSRh9wkFZId6lXbh51z2gq8o3BNyXFfhrNYoR2+TK1Qd7IYVSna7wTWob3zLStrbN98UUEkgvVZgo70YFB7b0bIRYmQl9hkr3OYxQq0l5CalLfTQaQw=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(6916009)(44832011)(38070700005)(33656002)(86362001)(316002)(186003)(53546011)(6512007)(71200400001)(54906003)(6506007)(8676002)(4326008)(5660300002)(36756003)(2616005)(122000001)(2906002)(8936002)(91956017)(66476007)(66446008)(66946007)(66556008)(64756008)(76116006)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?zz5SPYdzYjQYQ7uhVzbAGM3lbxC2Syad+ePcrlhtWdy5Xszn6RWkPoADySfT?=
 =?us-ascii?Q?R6257NCf0wSuULv6BNa1fHAGMfr5r+7RMdGzOiBNDWW5wjfi7V0Vd6WmREGq?=
 =?us-ascii?Q?xZD9jxS1OspIYm8RyVFWydHo6U4d7vlGEM5JDJYJ9DkGP2MBrD3tal0IUU1b?=
 =?us-ascii?Q?LXp28UOQTKpdk9IIXgBZQeu0Kk11DkOR+dOsdML2cGDWxmTX9ddQqTU6JcVs?=
 =?us-ascii?Q?VwUIMJ2jdYMqY1LLug/W2mxsNu2owcyJyxdaJFTsPWmcM+907+fXmKzHE8Sq?=
 =?us-ascii?Q?CeYKdwASFUrJEnu+RqxpP/JWpGCDSvvPWkjF25bBgwgNXP0O+vlw+MrCXrjT?=
 =?us-ascii?Q?ya4DdOD7K20fvMsWMBUkx5Femsfc5a3h1QPnZQNnoeT2TJSGgcynFVjID7dr?=
 =?us-ascii?Q?gDFJ4FP8VwUJ+rZUHheV1xYKa5Vi/AuhtLlpeOXplhziJJjKaX5i1biqN0+Y?=
 =?us-ascii?Q?K0quipy/rgD3aOMjL+ys40kZ1fYxMM8Y+R1M6ELF3Setm7lrU/K8O+hf2/qL?=
 =?us-ascii?Q?WGAjAwRhRM+WZFive64gB1e3Kap9fZgakdcmTk8yrZk1jAomYzZokBemLntq?=
 =?us-ascii?Q?YEmfKfs06Mh9qHOxe115VlZDLvVmoLnjS0d2LYR6oE6y29TkhXHQ5R+CYdV8?=
 =?us-ascii?Q?OtI4RxwdY4IcqumVVKGci6XKcEIX5YinRe1pV/J8PE1RO0XAOw4YuIdolsQq?=
 =?us-ascii?Q?xLf0Kb9gkOG+kZJPclhYJcVTPKCvdy9Tz3KajppWggmW+YG8xqJtjbH3YPew?=
 =?us-ascii?Q?I+pEPjOxkBppgKqkilfVZ/GwdohXLrTnhN6+25zuWbX3W0NAC8XD+9LiWXsr?=
 =?us-ascii?Q?2sGOBO0A43KaFdNhILrpJ1Pd92xRWN83MbNARWe3QgfXc0MqeGcGeLBzvtNV?=
 =?us-ascii?Q?d1sf3QkCPeJ1sAtoy+tmU4YfWK9MrUJsFnFKv/C5XUXuzBV+BOpmixJj5SPK?=
 =?us-ascii?Q?X/GFZkjL5rjKWCHIjWo3AnWTi7HkHkjlHgMbSjuH8pB8K8/WRSDIpOQQjctC?=
 =?us-ascii?Q?J/BibKAk/q6j0dEklBGiA8vDySE7tG68vWYdNnM9TjsclRADHP86BtOd8tsp?=
 =?us-ascii?Q?b1HIRP385ByA6h/8EQBQ/DFyXSvWqD7ZBbcYORcuSjsMkzfGecEouR1q4QND?=
 =?us-ascii?Q?FGpORhvviLk3asXlEBhfbyXgypRzOeUJ4DvUBBVmx8pN/w/YUe/QVFKHHluG?=
 =?us-ascii?Q?ABUZN9+xD423swebYThnMYejYEk/QA4muQJCf6n/rxV7OZkglpZkN49vXDF7?=
 =?us-ascii?Q?Yofu5GJNgSW48Rw0agAjYw6BnTsssxgNGu+RBFY/0ncNJ95tI6fWOJPGoSWr?=
 =?us-ascii?Q?Zcp4mTqI/3234mpEUO4ZvgSgY0RPOJZ+sdzDaRl8MQ1+ZMAcRCYDCOFBQ0Fi?=
 =?us-ascii?Q?rRqNaiE1vZ7H/SaNtUoxeHCdpQum9D0feu3lZXdxf0WwvvmV0QL3ogrHkbyh?=
 =?us-ascii?Q?6aznHlkvysX0OD+/vVB2I7/oB/Q20bA5CINHMLUUxsuIQtU0FITy1KygIzLD?=
 =?us-ascii?Q?qegy/gkbVxmfNj0+Ryn/ZAhYLleTyzhZgrOf7BfP6Rw6/DL/6eQMV8ukigXW?=
 =?us-ascii?Q?GYjX4ROrlMS4Vu3z4us65olt1tdn+iGhEQieR7gBsg+jGa2AZh+tdognnuv2?=
 =?us-ascii?Q?3YViHE/auKxU4fNhRf7LCDXafRX12KcXVxm4HbM5Us4bH7j3+ONNnbc3rXzv?=
 =?us-ascii?Q?abEmoroWI/PoS+nZ0IJ/IkXYDOS+o753atDNahTZdGWPdgTeqiWKVfNRBFrG?=
 =?us-ascii?Q?T+xpsqx8fjwingQChGKOiwi87pqSUpUaf2Z0CqIVBaortNQOBNRWFkx2NLGm?=
x-ms-exchange-antispam-messagedata-1: 4lgZ6Frs6u6Zxw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DD96FCE6D93914AB88F16D7C5052B90@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89c9e3a-269f-4467-3285-08da4a2a4d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 15:11:17.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QE6qgB5TaamP7NuHs6+eVTAEE7b+Rka14fyLHZAPg/9VqSoLqSKzqO5nNsdw8hRKkF0ZAcRRlO4RvwgJMzAtLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4310
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-09_12:2022-06-09,2022-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090060
X-Proofpoint-GUID: EA_hvSHr-7ZLENs-8vW0Fo-3HArAWb88
X-Proofpoint-ORIG-GUID: EA_hvSHr-7ZLENs-8vW0Fo-3HArAWb88
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_081134_647712_4D7AC9F3 
X-CRM114-Status: GOOD (  25.03  )
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



> On Jun 8, 2022, at 5:30 PM, Chaitanya Kulkarni <chaitanyak@nvidia.com> wr=
ote:
>=20
> On 6/8/22 12:04, Keith Busch wrote:
>> On Wed, Jun 08, 2022 at 06:11:04PM +0000, Alan Adamson wrote:
>>>> On Jun 8, 2022, at 12:52 AM, Christoph Hellwig <hch@lst.de> wrote:
>>>=20
>>> How do we get the clear_ids setting from the connect to the target?
>>=20
>> I'm assuming something like this (untested):
>>=20
>> ---
>> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
>> index 59024af2da2e..3eaf463d0567 100644
>> --- a/drivers/nvme/target/loop.c
>> +++ b/drivers/nvme/target/loop.c
>> @@ -687,6 +687,7 @@ static void nvme_loop_remove_port(struct nvmet_port =
*port)
>>  static const struct nvmet_fabrics_ops nvme_loop_ops =3D {
>>  	.owner		=3D THIS_MODULE,
>>  	.type		=3D NVMF_TRTYPE_LOOP,
>> +	.flags		=3D NVMF_CLEAR_NS_DESCS,
>>  	.add_port	=3D nvme_loop_add_port,
>>  	.remove_port	=3D nvme_loop_remove_port,
>>  	.queue_response =3D nvme_loop_queue_response,
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 69818752a33a..03ce045af54e 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -300,6 +300,7 @@ struct nvmet_fabrics_ops {
>>  	unsigned int flags;
>>  #define NVMF_KEYED_SGLS			(1 << 0)
>>  #define NVMF_METADATA_SUPPORTED		(1 << 1)
>> +#define NVMF_CLEAR_NS_DESCS		(1 << 3)
>>  	void (*queue_response)(struct nvmet_req *req);
>>  	int (*add_port)(struct nvmet_port *port);
>>  	void (*remove_port)(struct nvmet_port *port);
>> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passth=
ru.c
>> index b1f7efab3918..9fa5bc0e26d0 100644
>> --- a/drivers/nvme/target/passthru.c
>> +++ b/drivers/nvme/target/passthru.c
>> @@ -30,6 +30,19 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl=
 *ctrl)
>>  		ctrl->cap &=3D ~(1ULL << 43);
>>  }
>>=20
>> +static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
>> +{
>> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
>> +	u16 ret =3D NVME_SC_SUCCESS;
>> +
>> +	if (ctrl->ops->flags & NVMF_CLEAR_NS_DESCS) {
>> +		ret =3D NVME_SC_INVALID_FIELD;
>> +		nvmet_zero_sgl(req, 0, 0x1000);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>>  {
>>  	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
>> @@ -176,6 +189,9 @@ static void nvmet_passthru_execute_cmd_work(struct w=
ork_struct *w)
>>  		case NVME_ID_CNS_NS:
>>  			nvmet_passthru_override_id_ns(req);
>>  			break;
>> +		case NVME_ID_CNS_NS_DESC_LIST:
>> +			nvmet_passthru_override_id_descs(req);
>> +			break;
>>  		}
>>  	} else if (status < 0)
>>  		status =3D NVME_SC_INTERNAL;
>> --
>>=20
>=20
> this problem exists from early days of passthru,
> I think something like will be definitely useful.
>=20
> Alan, can you give it a test ?

Yes, found a issue.  Working on a fix.

Alan

>=20
> -ck
>=20
>=20


