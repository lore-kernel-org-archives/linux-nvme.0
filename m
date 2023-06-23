Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534EFEB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jun 2023 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b8PflpT+7+8xKn77rC95PMBGP6g9flgif8InDOYppEU=; b=jDoz+bH8WKP6ZOYIMA3TyiPrLj
	nk/xBaNMorjcgEVG820W8LK0S7oLT2eJyftOvVjT9UnY7Hio/ZvykCzLCWDgE+aGOlfOWgjVq+lms
	aVEmzPImdfCFxPBVUoC/UUzcr2n1NDVGdxsJrxx3ku0TVuvirRveII5O0pAkiHmLeKs012eAs00GA
	F3TDaHqz8J0//DUOcZCN8XqWTGhjd5OdmL/WxFx+mOqY2DBYmd5zvUNX2aksSjmRlJkrNvduI6C1X
	diXTu+LFVanqtbiHf7a2pmNzhCUulj/S5OPyyPTdNdK0k2QVVJt2tjwtjJtzMCjYt9+eN8UPUX17+
	gtDpR+fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCj92-0040Lb-1D;
	Fri, 23 Jun 2023 15:56:20 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCj8y-0040Ki-2M
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jun 2023 15:56:18 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDmJKf032678;
	Fri, 23 Jun 2023 11:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=b8PflpT+7+8xKn77rC95PMBGP6g9flgif8InDOYppEU=;
 b=Yq3Wx2eJn7IMqSRiEC1KvfvVjHUoI7Un1QqThTUuk8TIUhTY35x4CqHfOteBWILDUVMT
 OyzN/qjhNfQyKzTqGIH7ADYFyIqLev9P0PYiAEjFsKu+zKU68afEggM7mVrX1pa/e+7F
 l4NWOAETd8Ml7wrpi993ITNnxVLXRehATze0rZW9LFsjBMBugf7v+PAHBLimj3oMgLg2
 KGQfhipFHGI0Q35rlAN2q/FHJj9keVodcFMo7nK3khZBXuigu7vz2O3Uy2DMlyi5YC5D
 tJ3ScElbSYWNbj3c7enIj5RYXkW+vOzUbDpmwpVMIObsLOTPiKuUnQfUhXFXOeSktq1H 2w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3r97w3uj79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jun 2023 11:56:11 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NEBDxi008642;
	Fri, 23 Jun 2023 11:56:11 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3rd8bpdbxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jun 2023 11:56:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2Z8OY8Pbq/ynmu3OA/0EZjsRF1vJmm8QXrXngoOlVqESkirwnCm36JfEcEZbvirjPXN9W7E4Niz8DKucLEvkTYGzbI4M9M0c6RrwsdGOulHXR8R4BmlGpHyoVeArsflo7j16Hre+Zhtdez/2WOyIYb3ov+GO5LYRA3LAwM0xL69nvceQur3H/AJNBVAlWB9bCj6rx8Fc8jwz0ci4jTqfZU1wwhkxUiemxR4jxJQeut4HyocBlTNNoZhUAA/GJ8hFBAL6etjClpx3QucmC/Z9v9zj2sttx+wVSGUd0IG9dSiZIER+d6mMctM1kYxMNoxoEqx4FlIIRZBGVi0YYzOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8PflpT+7+8xKn77rC95PMBGP6g9flgif8InDOYppEU=;
 b=VqX/3U9tI132AvOubEifq5WUUcmBJInC75QEF85gzBOVRU3IkMfRCkyBOTPK2XItDLc1Y0PYUnf/hKvPIeQdDJoFGISofUw0ncNqa1INQpk9LC+oN4OFxs2ncp3OyEZA2yCf53PrZaMhYMn6iOEKWlQlT1C7XNqy1Bu8FheqQzujhEmip+KSESjhr89d8nIw5fKBZpPQKRhu+ioBwctcTovcYZALjVSAc5VqUE4YwFLIw+moFlwd5bCwG+34mENqO34gBJ8ph8x9Dxy/qCdacNidN7pUTVBD+phzip91SXG+0RH0j1A+YQw8yui6t985q+GWKmLyvzmT+NzrarVUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BLAPR19MB4228.namprd19.prod.outlook.com (2603:10b6:208:278::14)
 by CY8PR19MB7643.namprd19.prod.outlook.com (2603:10b6:930:7c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 15:56:08 +0000
Received: from BLAPR19MB4228.namprd19.prod.outlook.com
 ([fe80::47a2:6e3d:ce2b:ba88]) by BLAPR19MB4228.namprd19.prod.outlook.com
 ([fe80::47a2:6e3d:ce2b:ba88%5]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 15:56:07 +0000
From: "smith, erik" <Erik.Smith@dell.com>
To: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Rose,
 Charles" <Charles.Rose@dell.com>,
        "Belanger, Martin"
	<Martin.Belanger@dell.com>,
        Hannes Reinecke <hare@suse.de>, Martin Wilck
	<mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: RE: What's the upstream disposition with nvme-stas?
Thread-Topic: What's the upstream disposition with nvme-stas?
Thread-Index: AQHZpTDOht9jstEG+U2YiNbApagSiK+YidIAgAABe7A=
Date: Fri, 23 Jun 2023 15:56:07 +0000
Message-ID: <BLAPR19MB4228E1B24E91404BB3E02F86E423A@BLAPR19MB4228.namprd19.prod.outlook.com>
References: <b7f6bba3-30b0-8d55-e285-b922101a04f4@redhat.com>
 <ZJW+toS0tyjMsJf+@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZJW+toS0tyjMsJf+@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-06-23T15:56:05Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=4f5c55a9-7c77-4108-8d68-ec9a82e7f997;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR19MB4228:EE_|CY8PR19MB7643:EE_
x-ms-office365-filtering-correlation-id: 726e3100-7151-4b5d-07ad-08db74025b76
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ImRghtgrx4HXeNCT8/27H/7gBwZ8o1Bcg4KDJkHuK7EIA5Od5jjgJHuoHxsXNJsbr8S3ZAqJ0SDqHS6Z8wcxfu3CV5Df4AGJXMdQJy71aTOrbtTlUOrVrwsrJBrP9iucKJtYMs1dpzUBpSVE+pdIEfeNC7S/ZtQFuLVThaUFgVKmhyEILOJRdNJB2F3XFyoLzJA8Yb/OLpuWtRNJV4z+cIISvHAn77KgPm9TLCDMh4qoK1aAk93PNFbd/nhkj3iAdkmLhchM3SnGzDzCsBDWMW19SWV3ZPCD+bVeroejb8V7pm141+PtgUrOs8BPlZN/8RTebyzazzgF+UcT+iiH16BAcDBdz1Tue+zbmeYPRKubFD3Pp9z7mnrEnk8QfHyIcs4UBMA2gfpjCMeX3gqq64/FYqZWIME8+l5uM1PLqoJ4ceqFYOp69to5aaf0DtQ0weI+CB/vNyY1yXULJR/hi0hsun6P+yam5HikqwpMiHAnkTMPMy+vaZ4tf+uZyYKdJEaf1j13rBAORstB9OfxjXOlPFH79ZZGeEstxgtcJj2CBPK4LQiZYLQgWFKEjKe/Rm3uPp2VpqR9JBXrrG337R7RZ98BqPHlcEG5o7Cj63eagjWa7lT0iQu1P8yfhWr+5DY6lq9jfIIls5juiUUceA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR19MB4228.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(2906002)(7696005)(71200400001)(83380400001)(38100700002)(122000001)(82960400001)(6506007)(186003)(9686003)(53546011)(26005)(55016003)(41300700001)(86362001)(110136005)(54906003)(478600001)(38070700005)(316002)(786003)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(33656002)(4326008)(8676002)(5660300002)(52536014)(8936002)(556944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iTNErrP9pMHpq5pPzlVSz4ROLsaDX21Azg8OxfMqG33ePvbQgytImGCsD98a?=
 =?us-ascii?Q?pw15n6mMgArDRgzkxp3xO0ftsSyaxguRNu16Gm+VXdsQiChtP9eV05D9sfJn?=
 =?us-ascii?Q?kZEfolAn2FZVPRiDSoYvf9lKkaFxP+G7Vj5KcYTTDL5+Las2TF03Qgerhl/c?=
 =?us-ascii?Q?k9d1BsQncpF61N/lUi6aiG18wwz+LHTpaJvTPXufYS8rFwDt05xPniAhf3IO?=
 =?us-ascii?Q?czYc7Plp52Q9M5z9oIFqlrg7lkG13PRWwluuiXNgOfOt/1WzCFvmi+ZlrSnf?=
 =?us-ascii?Q?aidmvL4JsAfFE9WOL8aWE5RpcqbnB/Mg4MJGYOylpEz9xNR8mKaUKxsjwtiz?=
 =?us-ascii?Q?UUidQFfjYswSkm3R7RMOmoCB5E1ztonHDXT1Ecyb1wW4Q5tIVhoH9YGDr3nc?=
 =?us-ascii?Q?XyleHkwoUTzdm7tpF/ZoZx6K+cFIxGJGB6Zgeqdgd8XejemRygRKR77OJBLK?=
 =?us-ascii?Q?qPzDquyPxyXQBCJ0N1jv4OtgBBbT44ULKJTWVvscQs1LH6TO4N8QkhkVBcJT?=
 =?us-ascii?Q?kcorzQD7tQkIWFQ8cDSL5JSc4xQqOSCGFt6i4vRtxcffPhSCTIpoq50Cl/x3?=
 =?us-ascii?Q?/5NuJIG5J+890mLt9MNdzx7imHNsJMo4Mp2r9HkWXsWeY/PNnDnW3ZfeVCM9?=
 =?us-ascii?Q?P+Z36VAG/baIa7yeP4+31bGd4kyqGVkqorM7fIOhB0EZ13Wp+TYqH5iE2FbV?=
 =?us-ascii?Q?Qpe2+V501dLtJ3D5o2x5HTw+206XTNItgRCt6C+zRYFEY/WSjaMzO274Q9qJ?=
 =?us-ascii?Q?DqUDu7Hv6Qn/Yo4TXwxye7NYv4wFshNhdl0KX7P/gI1RsjxPS9ODtQ2fATEX?=
 =?us-ascii?Q?UlkSIYFD61ip+Kdcg5c5qGJobDa975zMqJUPZom08hkaxObz5/EchEAqTnch?=
 =?us-ascii?Q?XBHc8jQ9drFKlGkWwoo5mIJ+GsNR4K/R7q6ptH1VQOdYUdR4pgX76bdt8lUe?=
 =?us-ascii?Q?kJYDQZkKNUPm71xr08h9aT9uW1tQ8FoZXoEa3kXDZ2N2ruFbGL+NGD94vIRa?=
 =?us-ascii?Q?2FQCYzNx9S0ECWdlKjRjSkpUPl71mgI/Ln3fYVIHtmaJ9NnulXJ6RIDLc1+F?=
 =?us-ascii?Q?WWx9xGrnVbKkkWdyxhqRR6ZSzQ71fLZLRwaVPSTivQDUjaJFWH58ggQF1F37?=
 =?us-ascii?Q?oXgbAhtovoP3Dci7U0CwSkgAdI2wh0pPCSMWd7jFFMeqErZAX2LbUTpDn1SM?=
 =?us-ascii?Q?60SsJMnD0cA1YHbAH0y+6EyuKBmLUtBpDzHhWnmSKCaOmsL2DOAZhsn3EYFs?=
 =?us-ascii?Q?sI4UkpUxObiRdOi7W8Xd3zIiOyAVSbngtgS3uH51NPGYFKjF2EibXvnr0IKH?=
 =?us-ascii?Q?tKGI29kPrSnnj/k9tYgT/e9lyplqSez3bwREUjJYN4410oJ03tKidlwDSWZI?=
 =?us-ascii?Q?GEi7MP5ENLDF6XO5JGPoVJtrxjPKdGISZcJJ5qf1tBOx4diX0Qmws9dSqw7q?=
 =?us-ascii?Q?zXds9imch3hpL+1afig5NtSrJjEHO1/YIsBAcTkUAUHJaYtGMLkhLjW1vxmy?=
 =?us-ascii?Q?WH8DKfjL0u0ejG59lOdFPvM5L2D+Di459d8WvRDLUC/hjlmrSdtjgaOlyxgM?=
 =?us-ascii?Q?Yg1KZmD0ZJXR2Pzp8Gj5q00fZLO3Dm4VfHWwmP21?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR19MB4228.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726e3100-7151-4b5d-07ad-08db74025b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 15:56:07.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GntYiVCJ6p7zSfCuO6pUp6Ecdx8L2fGT/I1765RfuWh1v+Qt9FH3gBf7g1++TVNgY/ob23AN7iVvKYsV7gm2Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306230142
X-Proofpoint-ORIG-GUID: rL3VMG3mDnmdGdlpbwVhN03elKSe1sWs
X-Proofpoint-GUID: rL3VMG3mDnmdGdlpbwVhN03elKSe1sWs
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230142
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_085616_830632_3EBFBD8F 
X-CRM114-Status: GOOD (  26.67  )
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

Thank you Keith. =20

With regards to "stas can break things that don't subscribe to their way of=
 configuration"  We heard this feedback clearly last year and Martin update=
d nvme-stas to make sure it doesn't remove connections that it didn't estab=
lish in the first place.=20

Regards, Erik =20


Internal Use - Confidential

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Friday, June 23, 2023 11:48 AM
To: John Meneghini <jmeneghi@redhat.com>
Cc: linux-nvme@lists.infradead.org; Christoph Hellwig <hch@lst.de>; Sagi Gr=
imberg <sagi@grimberg.me>; smith, erik <Erik.Smith@dell.com>; Rose, Charles=
 <Charles_Rose@Dell.com>; Belanger, Martin <Martin_Belanger@Dell.com>; Hann=
es Reinecke <hare@suse.de>; Martin Wilck <mwilck@suse.com>; Daniel Wagner <=
dwagner@suse.de>
Subject: Re: What's the upstream disposition with nvme-stas?


[EXTERNAL EMAIL]=20

On Thu, Jun 22, 2023 at 01:41:30PM -0400, John Meneghini wrote:
> At LSFMM this year I spoke with privately with Keith Bush and others=20
> about the status of nvme-stas. When Keith and I spoke he told me that=20
> Dell had talked with him privately about nvme-stas and asked if the=20
> nvme-stas functionality can be merged into nvme-cli or otherwise accepted=
 upstream.
> Keith said that he told Dell, after looking at the nvme-stas=20
> implementation (again), the answer was no.

It's not that I told anyone "no" on merging -stas with -cli, or that I was =
asked to do so. That was a mutual conclusion. The two projects are sufficie=
ntly unaligned for such a destiny. nvme-cli is a stateless, one-shot comman=
d based utility, just like it wanted to be. Not that it couldn't support th=
e features; it'd just be done in a different way, but there isn't interest =
(that I know of) in developing a fully flushed out solution there.

While I personally don't like the tooling fragmentation or that -stas can b=
reak things that don't subscribe to their way of configuration, that's *the=
ir* problem to sort out with their users. I don't have such hardware, so I =
haven't got a horse in that race.

> general purpose Linux utility used for discovering and managing nvme=20
> and nvme-of devices. This is the nvme-cli utility. This is what's=20
> "supported upstream" and I'd like to end any debate about whether or=20
> not the upstream community supports nvme-stas. Nvme-stas is supported=20
> by the upstream community to the extent that it uses the kernel and=20
> libnvme APIs to access nvme devices; just as any other third party=20
> user space application that exploits these kernel and user space APIs=20
> is supported. Other than this, nvme-stas is not "supported upstream".

I'm not sure we're all aligned on what "supported upstream" means.

The linux kernel has to support the interfaces it exposes to user space no =
matter who's using them.

The tooling using these interfaces are independently developed, often loose=
ly organized. There's not really an individual authority that makes decisio=
ns on what counts as "supported upstream". These things often happen organi=
cally as developers and users converge on solutions to common problems.

Dell is free to call their repo the supported upstream "nvme-stas"
utility if they want since they are apparently actively maintaining it.
That doesn't mean any 3rd party entities or greater linux-nvme community ar=
e also backing the effort, though.

An OEM/IHV also can't really force distros to support their products either=
. Usually those support decisions are based on some merits of mutual benefi=
ts, and it's perfectly normal to conclude either way.

