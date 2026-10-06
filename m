Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B468CA9EBF
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gRQWlzz6ZnloXGS6UNIw8p3TKn59SMFHYEi4N1DFvwE=; b=TSUtO+tDbSou8dd6GW5mBDqMkR
	b6fTePakAZeVF1hYHG5thw8Wsy1t/O8qhnuD+/vA+L21BEYiSCIegUsjZbDpqgzU5Okf071tTW+OW
	zqYbLUJR/mqE12TFHX//6pi97UD5IhdH/pExYkB+cgEHf9aRb4JDKvhoLnGpKu902KUghGrjLFVUI
	yv0cK0oIBtS2zzvDDvrI4x7nL4sm9FRPY8N/lubKuBUu+gP04TqH2G1gEnyMZgQiYPhvo1Z12KCH1
	LR/+I3ULw/v5UtUl+U+UUdQMKe9KigUePM6Q/Hwidnqn42RcuPknRVGbL2eAI/eTy2MfleJWqpuX3
	0OLbhrNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDta-00000006hUZ-30tM;
	Fri, 09 Oct 2026 16:56:34 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE4ch-00000000nvW-2vXg
	for linux-nvme@lists.infradead.org;
	Tue, 06 Oct 2026 12:50:24 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BQX8J2323593;
	Tue, 6 Oct 2026 08:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=gRQWlzz6ZnloXGS6UNIw8p3
	TKn59SMFHYEi4N1DFvwE=; b=FpxOTKtNC1FsfzM5zJ5TcwuGLoh6JN1MfYUtszM
	T4kn3oOarN2fz1bkHa4fyS83DEj/pT33UqMIyw3qnY9i0U6Ap8zLr4lKBDNrA8GR
	INC5bZtk3zSv0pRiR8AAhmGrBHaNI84FwQn26Tu94HtiQfB0f+t3shP2lkY/A2CE
	3hBvf9l9xD5ch8EPb0pHFZLTYWsDgvz5Uxtou3kFPjNz7qwmgj8Xc7knOo5AWj8E
	Qj7CwOPpJ97eA243Zw1sE6ZVTMvPOlSwFKniWZktB5l3g0BTYVja38+kldSoci2q
	VwRHKvng0EkaRV1Nn6dkUE8L149LXgw7nQEFoj1k9V86HDA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4h2w1fvs38-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 08:49:55 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696CVamO1095382;
	Tue, 6 Oct 2026 08:49:55 -0400
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4h4wfubdwp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 06 Oct 2026 08:49:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKEqwJ1kdC6c51LRmUbYjwb0N2khiGwN4/mG3fmK3lw9FQ6+dZzFp0UyT9c3Y68kefnFi29J74URmk/vmTXcmwx4pWHCeiMLI9KJkgiWM8nznjvLYF4eWb5UgCKLTdjTHQTwzasPQkHCSalswpdtv9bllw3i4is1e2528/po5CqZ2FZ4xu/kkIv6vicDzFux+vhyIFWwnjgC4QQsbPzI7zMvKG0j50WnO5FBwaPPiMYLNWOlqikMDV2YD6LS5MRzGUnKHqvZ36IBPuZGN/VW4QMAyi0ob0WL9wTctE+cyVEfBmHJQ6VIlP3Fnhmlk3o0Vkoph/N9tpPVdb/oRIDoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRQWlzz6ZnloXGS6UNIw8p3TKn59SMFHYEi4N1DFvwE=;
 b=cGwuezAdqsFdNIsI15PPe9ABhtZ0rYXnYyi/JQb9Y7wwM7wsaG9jMqrkKKhxif0iK9q7yRh7slyvJ2R4L8AewiB/srBhdn+Gn2XN9IJfX5SaAfqkybKiJ6ch4JnAXB5j79JxPeu0Tbp+RNOX7ENYDyscTcL60zJmtbMqXNLKz8idEGaCaM8y874bmlkzP8LP/+48VdZKWKaKQFcDSvZZL6oRybAQymv5EEIm5Ovuel2WRUzkKb2kUSeeIUFwC/J5sVL3aWFcuXaYif6Oqmvr2bqy99f+VMj5flXz0ZpX6vnB2rYSDKH1UI47UCjlbfPq9B131WGWR1PosMknP+h3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS0PR19MB7696.namprd19.prod.outlook.com (2603:10b6:8:f8::5) by
 DS2PR19MB717513.namprd19.prod.outlook.com (2603:10b6:8:405::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:49:28 +0000
Received: from DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9]) by DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:49:27 +0000
From: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
To: "mkhalfella@purestorage.com" <mkhalfella@purestorage.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hare@kernel.org" <hare@kernel.org>,
        "hare@suse.de" <hare@suse.de>, "hch@lst.de" <hch@lst.de>,
        "jsmart833426@gmail.com" <jsmart833426@gmail.com>,
        "justin.tee@broadcom.com"
	<justin.tee@broadcom.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "nareshgottumukkala83@gmail.com"
	<nareshgottumukkala83@gmail.com>,
        "paul.ely@broadcom.com"
	<paul.ely@broadcom.com>,
        "randyj@purestorage.com" <randyj@purestorage.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v6 06/18] nvme: Rapid Path Failure Recovery read
 controller identify fields
Thread-Topic: Re: [PATCH v6 06/18] nvme: Rapid Path Failure Recovery read
 controller identify fields
Thread-Index: Ad1Vj13rTQ1CocYYRpOc3TgiH2yZTA==
Date: Tue, 6 Oct 2026 12:49:27 +0000
Message-ID: <DS0PR19MB76967E8FE20ECF6D2EFF1EE1FD952@DS0PR19MB7696.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-10-06T12:36:53.0000000Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7696:EE_|DS2PR19MB717513:EE_
x-ms-office365-filtering-correlation-id: 3b8ba27f-fb08-454d-bbf1-08df23a84202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|786006|366016|1800799024|6133799003|10067099003|18002099003|3023799007|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: HY3xiHjwbXMK4di6TmFhMAnFSxp2JnsdEEZnKmrDoBVVco1uZZ4DadhS2UkiQBr03leLL08XXqubGoN2QRK5J/MIE62jXtRfX2nG0mIgJzUILB+11JQOaUopwyx4COKcDoFBn0W2m4z2Fl0bGU4pQAi+O5bxcUZXn4odOdtEse/+FBJWwb0LmbKweICF0cty7XvMLVTNvL6zHxFVF11nQPS65aUzmo879fNZP2E9xwZeDidKjOO9sg8csl41HnzmlVrh0bYkP1c4GYAShmLZA8LDvdacMLbofyqksb3frzG6HFRaIqMjZEZUWm5oWzvtPSQU58X5QmZxNjxS6XtBcuXVQkmU3oh4M4r8WMl66fFnZbD10ScgAoaqkgrWZXXwyTY390mdq+sJDuHAIYIe50LGDqnNqqSBxX/7QP71mbTZKwNsN3jgdslmXYPATDB+/FECxcMOc/U7fVqebdfI+3nGyRsFZcMHxp/PRIFrkbroxM2JjBNZfsQC8EdyW9bbgI+xgk6MIAIOTiZxYDl/4JaNhw19Ei13mYT1lMt4bb8VipdH+I8cYQGjo5E/z5CxEd7GOKlAF7Q5IvWuSBJ8c7cBS4OVzA6fG3dDF+ddcJU5YpU1KPR6VVo1gcIkYh5CWBgGJXd+szHSvdy6EyTRLLQRTM2EA9ueZo9/bnUJCuOah7ouSAcOugsIhBTz9ml5U+DrYtq02398mEML5Znd9m5SkyUml2erScu7C0UA/tg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7696.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(786006)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(3023799007)(38070700021)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rihPerEAPXJM8K0BF0htbxNieCpWOPfVhp72VWk1Gpm+KtegO7ld/qJxZKnK?=
 =?us-ascii?Q?biHrt+13kSYbjcbI7rHXmkt5h1HxI72y1DrRNXwpbbD8fCNKqhGk8eL9jJLs?=
 =?us-ascii?Q?k5To20hbWq+DiuKXClhmyNW5nZsQEJcxUA21H0kT6aGB8NY0n7thxKhMH2OU?=
 =?us-ascii?Q?2KBxVI4WacLDEQpxmMkBjWhEOFV5QwuOfZJw4Pc1er5ADnDSJbXBdOFmWLCi?=
 =?us-ascii?Q?xDOL7QgNAroTrmRvcxG9hrbPC+icYMxg7m37qdn8cRhNXIWAmE59aTaCnv/4?=
 =?us-ascii?Q?3U7RZENrmPtC8FyDPedXP2v78nMT3CRJnq0ugfa4l1sIe+lU8HduTaCT9Abu?=
 =?us-ascii?Q?ZNa7SyqC1m0UFBbHoTEtiIF5IozDP94nNQkMxlsqFEeLpJTxPtxLqGUkUK3l?=
 =?us-ascii?Q?uESoJa18s7Oq1ed5C6JJp8lncU7aaB8dx9E8q8PYxqF4xZNzBc0SxmgoNsXh?=
 =?us-ascii?Q?Sgw5Uq2q7SePiSswVoQ/Zelj9Aj8cDemPfJAuGB92A951SxpSiEwa2rOP4rY?=
 =?us-ascii?Q?IN9Bw6y1AAaBzqfPTbK9pu3u3UH1LyQ3XjlUkoa2oMIvEiN/AU+ux2AUBiFZ?=
 =?us-ascii?Q?bTNee4LYEdFKjybC4Li5G2c9r0ca8ZR4EmEYOIFA27YAG/Xj08dBr/0q/+Kb?=
 =?us-ascii?Q?6bCdvdRgoQ8PxAerefouL9yk37tcbvJ0lNRa/8bYOolXHMUp6oGbg5UrQ5C+?=
 =?us-ascii?Q?dZT5+TzWW0lDU/kADnmsw+g00xWxyEdIVh7+714ZqqEW0sxfexXfwi/LMjPE?=
 =?us-ascii?Q?EbNf3rjaH5Jk6jrJ7nMwAO74/f/m/863h7yc9mRjAmmfmDOSASXVT+o7BM05?=
 =?us-ascii?Q?jF1cXz5dHnU3VyDRerz0mXoJLGFX4xZ6XOudVv8U1aoyBMdOzJYz9ZnYw1gS?=
 =?us-ascii?Q?1ZomJ2kjuZd+dhMxU7ocOKxjzkd05LELrgowr6bidY3sb7szmnOhiNjsabQP?=
 =?us-ascii?Q?EQk9gW70YHwXS0riloU4tvYru1rWGRFM1+xLthfkRXI3465qtQcthRWa/kaM?=
 =?us-ascii?Q?MrxK2W73vRKwOi5BirpALwHn5Q41MaVtLwY1RvJFXA1EHI8s2z6YBJp1CBXm?=
 =?us-ascii?Q?xyCuIQuRhpvPepr9Xf6uWCHg4Qfr0rZ7b6s1nJSJIBhylydmJW08K7hTpm0u?=
 =?us-ascii?Q?WD84RN4J1qJUtVaxlrnMDxbotPKL4VSNfHyeej5KcQhv1QXXEVtUHNJe7rol?=
 =?us-ascii?Q?hBlOL8iHxYa5xfGOy3iB1HO01nKUVY3cwZMkQcNpZdKcWPl93K7E6ttel2X7?=
 =?us-ascii?Q?0mUZxy/kW7hESkuB4a4Ne+uUASgkoliJJnd6BDVU9AHRkHZkp6vBogpBKTuE?=
 =?us-ascii?Q?Vmx6Bokc5967kmxor+BePbTBVHoqpS+PPZjYpx+tW5jQ8xpPFRBZ/XtSY8IJ?=
 =?us-ascii?Q?SGbty7Od6IyBaRvccdCGjg2F47U3v98woOli7zeVIVSkPkA6Tj6cicc+CwVd?=
 =?us-ascii?Q?oZjokLqOrB9F2sXbcaUqGgWk82L5OaEFRa5u5DH38QS4qemuOnyiccfOZ43G?=
 =?us-ascii?Q?jVx0iybjSwXnN+mw5HJM+LOiScJUyUc7LIy8WqRTErJ+cNyJwwAEe6yh21/I?=
 =?us-ascii?Q?Lp40mWHRodn4MBaJwfski2cB+/deJRnfqx7t8Tawval3wQBEHSixbgpiIENO?=
 =?us-ascii?Q?dqObLoSA+T0vGE9D0n/xhO19d/rnXDOI1ZyuocGjqSP5sRMlK9RRVKwOeUXk?=
 =?us-ascii?Q?JpMtwJeXqKXhwT0q4lf4jtZMbzeRnZD+Ua8RMMLYvDvuxcL5HbvlzicMuTNz?=
 =?us-ascii?Q?WVRFdxDpEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yQZuqtCr49NzgWkNzbd4Ll1BUQcv7k0j5XbOtFRytTK3/ad7dRH8YHdcnoKM71ENZMWc0OqMp8gjjy9aU7YtI3NJd7CU4GuqFsTwa+qJ1HpQ29Rml7m9beXPtHxQS7W37m1cNBK56s2Qe7Y62NDVkTRMnO+7o3h72sgCr2CKWs8jGdc5Q2E/173mFjP/BVkwrO46xkalv5w2GpiZp0G/OkCsTAQC7231dRy6yO5Sl1OUkqFk0hEzbChwPgdKDdENHVc7Vo5ELGEG4nahv9N7C3OcPBh9YcSPBJlwr9QrcktT8x9IV0l6cXRKwQLKq3ujVYT2FtxTnjJihbPpTqmf4g==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7696.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8ba27f-fb08-454d-bbf1-08df23a84202
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 12:49:27.8751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXwU/fpLytntR/AKf5M+PxaFskTqYWtQEDkLIhIb3XlDqvHtwp0Y1d+afghFMhUnha7cRUV/lQJKIwcHfv9wDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB717513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060050
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MSBTYWx0ZWRfXwmMPETVs9zXG
 nFjX+vEzh2bahkcQzZ03xuwSVgltsmuDfcksFXWcuSZ26t1uf1JZ1GiiWCgC8858kZD8A/WqVkP
 dEeFXOS4rTWMOZGoJUppYXpGJ9et2Lg=
X-Authority-Analysis: v=2.4 cv=IvyL47/g c=1 sm=1 tr=0 ts=6ac4ee74 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=2Lpba0WeoN7BYVdwMO11:22 a=iLNU1ar6AAAA:8 a=-_Dj0B074LiPcoKQ5xkA:9
 a=CjuIK1q_8ugA:10 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: JQb7bVPHUa5TmF3Zh0CTkCPycxtFa9Hr
X-Proofpoint-ORIG-GUID: JQb7bVPHUa5TmF3Zh0CTkCPycxtFa9Hr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MSBTYWx0ZWRfX7rn9iviFFJpv
 +NZlGWgyGFUYC7BmCDFGaLVAk+BHVjn4CTFrNmdp9o4i2L3ByeRvOCjFtzfLX9sh+uRelVJbiAP
 v7jxU5Iyi3R/f9rDVigH0hmuIogN+HO4cyl2Tm56usvwp5+eaz+erGRzr4hHn6CLL7+x+Cl6u2L
 iHbKaFyoGajwZOyDsztjxWRkTDsrobMkANVAcrL2XbaM9k+ZKzz+Ea6d74qY3QoCR+ZB69H0FEC
 V3XbvJn1JTT80Mkxvqg5zKGPRF/aRLmJza2hrZ9VL201q0Iu7OnzSgSCzXDvPpIUx7/FNu4LfXq
 OCXuxeU6ATs58GbB0SM1csBPRzDjbhPIZ5WGR6xIaM44HzM27grxR36X03FXIbB9b8hD7sQne02
 ssLnEw8g1oWAT7Cx+q2h3AVFgomqOzRaXc08AQuE4UmAs+AnRjPnywpeeTsNgdFY7ScmmDrRJ4Y
 RdGyrq0sBasX/bTOL6Q==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060051
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_055023_779511_8E2F17AF 
X-CRM114-Status: GOOD (  10.25  )
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:56:33 -0700
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

Hi Randy, Mohamed,

We have tested the v6 patchset against our PowerFlex NVMe-oF target
implementation with TP8028 (Cross-Controller Reset) support.

Our testing covered:

- CCR for an impacted controller on the same node as the source
  controller
- CCR for an impacted controller on a remote node in a distributed
  system
- Fallback to CQT-based timeout recovery (2*KATO + CQT) when CCR
  is not supported
- CCR limit exceeded and log page full error handling (tested on v3,
  still applicable)

CCR dramatically reduces recovery time compared to the (2*KATO + CQT)
timeout path.

When PowerFlex returns CCR operation success (via IRS or the CCR log
page), the patched host resumes I/O immediately. When the target
returns success without the Validated/CLRI flags set, the host
correctly falls back to timeout-based recovery. On failure, the host
appropriately retries CCR via another controller.

We also confirmed that without this patchset, the Linux host can
retry commands too quickly during path recovery, resulting in
duplicate commands outstanding at storage simultaneously. This
patchset's fix for that retry behavior is long overdue.

We strongly support acceptance of this patchset. It makes a
significant and measurable improvement to Linux NVMe-oF usability
and correctness.

Tested-by: Igor Achkinazi <Igor.Achkinazi@dell.com>

Thank you,
Igor


Internal Use - Confidential

