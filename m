Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2863FC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ojnq+jhCygrKzsA/boyjFhaGPNOv/fvpBJXdQ+akl4A=; b=pktSjXTv22nTYEF98xOqCJu3p8
	hXYf89pWfflFKx/tV4zlinMUcHp7i0fVvchKozDrwjfARILQH3J0JUpIbnkJ+Mu7HtBhBb7CKoEzZ
	wnxeUp1y++UbXvDu5a7yG6eYqSyreVzzQFei+K3Oj+fi/abBiAy9H20hADPEyBVFhJDdbRY+xmFhx
	gxaWmWwBd1Nu1Vee5/NVsqcTejamhRogrishNeGx/JHHQtSjiboEApiPbGw+0STGy++LeQQyQk4Wg
	Ktql4/usOXeCYEMwB6wQtH6Ae8DrRzjk+zyLjcnK1JMgyyMsileBA67p+pxtJ5qBzOs9Z3DaLzA8I
	r8nXzhvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kfT-00748c-6K; Tue, 21 Jun 2022 20:40:11 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kfQ-00747U-Nk
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:40:10 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ3wFT009733;
	Tue, 21 Jun 2022 20:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ojnq+jhCygrKzsA/boyjFhaGPNOv/fvpBJXdQ+akl4A=;
 b=lcJSYuTMH59vomR8ehznimKMDqhr+2TVku1HOZWbxS8u3/eNTz69964oYdr6NULZ7lV/
 DunT+/4njgEW2NnJI6QgsyJfprMyWmr92I0bDvNGOI3JKS9ii3gVqmQkjZmNkWYFSMWM
 TpvM2hsxQ1UspSEjqcnKSe+elbyVG/wv10VHg752tTfBW8taq7MLlNo3jHHmpt1DVPlD
 NVQojSV044YwJ8NsOZZiSf00vneBGAElCJAOuEqN+hT9OSdWCIxWsyc6QAznujnntqqN
 P8ha6o4U+5VAQbJ8jSJnSDUaz1Op6b3zzt5mVmHrNZm+UCgTROWdJlomoF9f/mkOp2XJ 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txnqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jun 2022 20:39:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKUin3019117;
	Tue, 21 Jun 2022 20:39:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cumv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jun 2022 20:39:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdoO9iDxKSVfJ1N4y1rPgNgZ6WlxwX6WChTIIuDWQ1VRSkrB96wT7mZNMKwJXKaEB6lnAV7pJdglFgOIVcNrd7LLFHJ+bB9zTFSmaDTCQJ/oDu/nRDb7lytQ0t4O6dDCqmrIy48RFVuOD/Aja2XnrLbMaxYB/E/iE1bAts8q7SDviTIjukcXByJt8QsxVwBvB6unNW9d01T8OsUmg5yXdrlxDoVh1OM6XfdT3jq9t/Z0/WIKOdaV1pBhVA+ZGHrpW4lhKw6l8GCDKu/k6u6qZmk4KqpiqYpiteFJ0JaE8/SkiNwOMEEBoL7qZLsV9E8feyZFtc6kTVSiC+t+XVHQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ojnq+jhCygrKzsA/boyjFhaGPNOv/fvpBJXdQ+akl4A=;
 b=T1qelf1sE/Qt7r3D6kyKGgDCZFFAOIpgTmGM4kbzgC7g8yCgVSkD9Q3Nh4i0XduWt/3Uwc5I4JervVuKGDjj3eWT+rcGqXQoqljULeaN1IvlgVwb73Tk+FL/J38ZWauYhnZ/VrRo21qJ5GKS9EXECOrs0NNQVbzOr+Hwj6U8j6f4v3LBOJoBKRhRDahruTFpLap4b4/BKQmP1HGeBAGPLsesefRMMDA68BngY8ak0nhzzq48OVawpsge4OCfzbZ8qjzj9w3Y9L3sabL+/QLdQtvosk/TPBa+PPrzoC7LTH3iPROjpURqJ63q2dtqzvihh64qSWJ1ixpoLoM3YvhzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ojnq+jhCygrKzsA/boyjFhaGPNOv/fvpBJXdQ+akl4A=;
 b=DLHdbC71YV0u16VdcUYrp/HDxPPGPLvg+XLhri3+KPZQvngfL7o9VPv6y4PjjSP4TjNwd8hwceyZDcq7Gl2wkloKUPoe4CCwb6HwnoRAnnvgrLYTGs3tdAZXRvcr6OIEvnBe63DVYlLEcQX9RmGXU3kbFYN8C8Zw2fuRl5XOP0I=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BY5PR10MB3908.namprd10.prod.outlook.com (2603:10b6:a03:1b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:39:53 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5064:d3d3:558f:63b6]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5064:d3d3:558f:63b6%4]) with mapi id 15.20.5353.021; Tue, 21 Jun 2022
 20:39:53 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
        Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index:  AQHYKbXc39T2BoiygkiETee4KuxaGazldeqAgABJzICAAB64AIAAlJYAgAAa2oCAA+JBgIAADcuAgAwnQ4CAAhongIBKtzYAgAJPjACAAKy4gIAADwUAgACTr4CAAVjIAIAA5nIAgAhBGoCAAmhFAIAG61AAgAAImYCAABisgA==
Date: Tue, 21 Jun 2022 20:39:52 +0000
Message-ID: <BD12CD24-EFD5-4757-9732-CA707A9610CE@oracle.com>
References: <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <20220608075252.GB13027@lst.de>
 <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
 <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
 <20220609035323.GA31248@lst.de>
 <6ACB62F8-BFC4-45A3-9886-E05DB45248D5@oracle.com>
 <YqNRPEpZgT8Xn9Nr@kbusch-mbp.dhcp.thefacebook.com>
 <B396ED69-5559-40F0-92F3-8B319D90584C@oracle.com>
 <20220617090100.GA7767@lst.de>
 <572E6BCA-2B80-46BB-9FBE-F6AA3D7C8FAC@oracle.com>
 <YrIX5Q5xODHMC5AT@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YrIX5Q5xODHMC5AT@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa7f80b5-57a4-4369-7691-08da53c631c9
x-ms-traffictypediagnostic: BY5PR10MB3908:EE_
x-microsoft-antispam-prvs:  <BY5PR10MB39083BE4CE0A69B447F4CA62F4B39@BY5PR10MB3908.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  n+cosqWm0GuikPf2syCF6sIhAAzY4y7sFz4cMX3eZGI4Jzci3RwhOpUTCYhkfIwkVUPPHxG+1YiGf4pGP4nZk2bF/HVfJEP5k/YiznW7iMekcFzby992bhtUQLjq5R8UPXvdS63Ffa025j8Rkb39cQKpuO+e6YIuU0v0Vp6j7WzxLs44PU2oU24IsJdBLimoZhehNFZvlef3YcnzCdz2rYIbN6WpinkL4u7W4hqnCVS6KSFZ5Ybnsc5Ux4kk/IK5Wpv01wPApVR+854vtcmqWe3aIcC7L/XqU7GjmVuOPyll3f9fbcUJpEPFM1JjwH4SWR0mpuSdLVL6JVLkZYIdf0oCNnJvhWwzTKcpfSjNXbudWg22F/6cLV6FO7bsbxqvIzrayEEeFXYEL0lFXYTKHCupRzeZQlGxwKUGqwBg1Sqvqh9SFgWO+gSslDaQCHEHhS+cO775lPEeIXxvY0FNp7hIcI5vNGl7Ir8C+UKYGlGrE7ApbE1kW29czotTVORv6eTmjh7ia0L/JbQRN+gtPd9EPqKWnnsQ9E0k6iQaXAW0KLxK5AYxadMVIxRukB3SOhJfUFBtGL/Cj4tgp+R1eGiByD1OWkyth3O6OuEYgAqtciieUseCxGi6ZjP/4CAkRcQ22ffPgM0EaTTg+nKZyHrjfkYOA1mkuQ8QOh6GSMHiBDAT4UKgLBELo5cSl503njNbT2Xm/G0hjIijwCoAB7PvG9NbuAh98Mzh0lLEP1T1mh2umT+W6mUrH+mURkWy
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(136003)(396003)(366004)(6916009)(36756003)(54906003)(2616005)(4326008)(122000001)(71200400001)(38070700005)(44832011)(8936002)(33656002)(186003)(38100700002)(6486002)(86362001)(5660300002)(478600001)(53546011)(8676002)(66946007)(2906002)(6506007)(6512007)(91956017)(64756008)(41300700001)(66556008)(316002)(66476007)(76116006)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?hb7i3+SHptzRIWquADuSrp4llCuY81cmd2U9v20wY0luejghuRrP+4JC74bH?=
 =?us-ascii?Q?7nfT7pLgyIgZACfw8T5unBo66cHdd7FMP1sDLRLFyKXLu7BBVzD6yIORVGBj?=
 =?us-ascii?Q?Gws0GHSReaxAr//8PN2/ap+DGLc2i+p/GGBWCozptZj+hQoMJM91CwI0Gbhz?=
 =?us-ascii?Q?2KQaY+xLfq9c0iCCky5pNcc97Nkq8zczMAfDa4sq4ILiTZc9ubdk3Ab1qsc2?=
 =?us-ascii?Q?zKfGBVXtVCbl8SDCuFjTnT9jZgtRhru/HMCNPWq+8N9xhi00VuiKCMat7AhS?=
 =?us-ascii?Q?o+eioUT5D3yUsJ4J+nYMDT4g77iqJ/yKSAXfTqQPphRT9fr4ZjsZwdbHd0ut?=
 =?us-ascii?Q?Y62+ZV2Td7wEJzdBsziTDvpXIU6d+mWqJn0Ru2A4t45liuujSQXXIIr/3fUY?=
 =?us-ascii?Q?u5nsnYKwZxO68RFOOW+GhP4oW7Se7EoOAhGj6T3wjpKL+w8ouA2YsSehzKjK?=
 =?us-ascii?Q?iq/oWbp45nv+TBdAqwz9rCkr4/oA4TqCmT8+mFztRFnGPp9tbkMlY6mEyf+a?=
 =?us-ascii?Q?G/BNqVfIJAnXJR1flAZyQetl4pfJQRepzO+dyGld6kAigaPuoX9k3ixLxP5x?=
 =?us-ascii?Q?HBUnsdjoHZU9pzPT9gK8+T8C9IUYqjRFrrO/0Qu0d3aJXin4O/0WABASjt/I?=
 =?us-ascii?Q?D2ppazS5apW0bVEu3gEbJ8vnYu58UfVN94he9ACBLgusx84WNx/WRXdfUBtM?=
 =?us-ascii?Q?8nRvPMYe8frL0Ws7SIppYDrEmaZaZlXqN4/zQaotgJ+t5uz3UT0lEzzgxBOC?=
 =?us-ascii?Q?HBAumMphmqnHnfh3MrESlYEsM/vG7YTiX4n+9EhuJg3AQewZdD8wTCiW0iUg?=
 =?us-ascii?Q?RlcTbGI1HWepM7p8ZC+keHdlGjCOScEYZbKIH/jigkYYBIOxnxau3syZwanF?=
 =?us-ascii?Q?tO6KV4vKebobGiXk6bxwXFEsL0/IqYAk+3SXSmvO6PqtCuqeltPQ2QXFX+Ku?=
 =?us-ascii?Q?UaD1cPmviUc9Zrc/3fVPYKNrBBojgDIsTDnuDrSPwl7mqkufTXe5J4HO71lb?=
 =?us-ascii?Q?kfVepWpUwQ6C8oZQV5VtzBaMQDbt9yR/PUcJwiZRf1HhhYvQy15a32xuyIbr?=
 =?us-ascii?Q?c+pcZeSiZCJ0pxYNDUdBFiNmV9QBIqpmzYEV04+rAAe7yPuHIp7v9lTBk3v5?=
 =?us-ascii?Q?Lz5L9ZtP0VMaO+KryegeFq66z9klP1A4QMZy+hSKZPbb0buJRDgYedBThO+A?=
 =?us-ascii?Q?Oti7pratB5a98KYggIVRQ9/BaA0Vso4NlFtA2DaOlSYat85rTq4tVoikIXfZ?=
 =?us-ascii?Q?y3iPXpsXr+DBNdsrDlx8qk1KGuQpZq/+4/vTEp1gp3BoVylEP0HwNjULR5C4?=
 =?us-ascii?Q?hCWXb6nC/5djOoga7FrwetOU5kkH00+t2Os2rrea6b7OFaAGXRhSGGKsW4Vn?=
 =?us-ascii?Q?zg6mdutOsv4gWPgdP2TYdeDqnnhuxlM8/hqDOqVJDXseMtGHJvdAxeTOFSqZ?=
 =?us-ascii?Q?UdoMpnA1FdjxdvelWDISpZxY5SINAG6461yD2J0GYLfJniqrbhwor/hq2Jnk?=
 =?us-ascii?Q?EZ3b3/SxFu+w4raNaZHbZtqe7LUBuW7mly2A5zCWISZN75l6/jV1/BuCQ+Pg?=
 =?us-ascii?Q?yMj1NQPQ9BKDEJkToT70tt7UY4Kr7fr/Oau6KsMU393ZXkN5ewlM8Kiur5pX?=
 =?us-ascii?Q?JDsNbI0mzIzQ7XZT0MHMrPKCohbMQRpnf5CUb3Cgk1z4BtPuuVNpkx52262R?=
 =?us-ascii?Q?lXcMBJ9+IGq0Oq+TDZIG+ZPichAw217SILXs0/Fmgr+NBhS7dMjMk5+H7HvN?=
 =?us-ascii?Q?A7fsBScSB/ccJq3VK1F6gtW5T5/Sn6d/TKdw2x19c9q1YRqpNt9jkbEThbMh?=
x-ms-exchange-antispam-messagedata-1: ghhBoTnEcnrKVQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <095580B1EEF566448CBBC4166A6209BC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7f80b5-57a4-4369-7691-08da53c631c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:39:52.9794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFrDIm+veTs0IELrxIOKy+EU4qcK/095USmhDizPJgYn1OU8M21QtjEOKLmA1lasP0qA7FAFi887Dq7904D36w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3908
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210086
X-Proofpoint-GUID: l6ct9dbu4ThQyz3mKmzWyZrgAjALdxV4
X-Proofpoint-ORIG-GUID: l6ct9dbu4ThQyz3mKmzWyZrgAjALdxV4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_134008_807715_891B62C8 
X-CRM114-Status: GOOD (  28.80  )
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



> On Jun 21, 2022, at 12:11 PM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> On Tue, Jun 21, 2022 at 06:40:49PM +0000, Alan Adamson wrote:
>> +static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
>> +{
>> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
>> +	void *data;
>> +	struct nvme_ns_id_desc *cur;
>> +	u16 status =3D NVME_SC_SUCCESS;
>> +	u8 csi;
>> +	int pos, len;
>> +	bool csi_seen;
>> +
>> +	if (!ctrl->subsys->clear_ids)
>> +		return status;
>> +
>> +	data =3D kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>> +	if (!data)
>> +		return NVME_SC_INTERNAL;
>> +
>> +	status =3D nvmet_copy_from_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
>> +	if (status)
>> +		goto out_free;
>> +
>> +	for (pos =3D 0; pos < NVME_IDENTIFY_DATA_SIZE; pos +=3D len) {
>> +		cur =3D data + pos;
>> +
>> +		if (cur->nidl =3D=3D 0)
>> +			break;
>> +		len =3D cur->nidl;
>> +		if (cur->nidt =3D=3D NVME_NIDT_CSI) {
>> +			memcpy(&csi, data + pos + sizeof(struct nvme_ns_id_desc), NVME_NIDT_=
CSI_LEN);
>> +			csi_seen =3D 1;
>> +			break;
>> +		}
>> +		len +=3D sizeof(struct nvme_ns_id_desc);
>> +	}
>> +	if (csi_seen) {
>> +		cur =3D data;
>> +		cur->nidt =3D NVME_NIDT_CSI;
>> +		cur->nidl =3D NVME_NIDT_CSI_LEN;
>> +		memcpy(data + sizeof(struct nvme_ns_id_desc), &csi,  NVME_NIDT_CSI_LE=
N);
>> +
>> +		cur =3D data + sizeof(struct nvme_ns_id_desc) + NVME_NIDT_CSI_LEN;
>> +		cur->nidt =3D 0;
>> +		cur->nidl =3D 0;
>> +		status =3D nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
>> +	}
>=20
> This is clearing the other descriptors only if the controller also report=
s a
> CSI field. I think just do something like the following on top of your pa=
tch,
> and should be good to go.
>=20
> ---
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthr=
u.c
> index f863cd459652..f9599b0cd129 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -54,17 +54,15 @@ static u16 nvmet_passthru_override_id_descs(struct nv=
met_req *req)
> 		}
> 		len +=3D sizeof(struct nvme_ns_id_desc);
> 	}
> +
> +	memset(data, 0, NVME_IDENTIFY_DATA_SIZE);
> 	if (csi_seen) {
> 		cur =3D data;
> 		cur->nidt =3D NVME_NIDT_CSI;
> 		cur->nidl =3D NVME_NIDT_CSI_LEN;
> 		memcpy(data + sizeof(struct nvme_ns_id_desc), &csi,  NVME_NIDT_CSI_LEN)=
;
> -
> -		cur =3D data + sizeof(struct nvme_ns_id_desc) + NVME_NIDT_CSI_LEN;
> -		cur->nidt =3D 0;
> -		cur->nidl =3D 0;
> -		status =3D nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
> 	}
> +	status =3D nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
> out_free:
> 	kfree(data);
> 	return status;
> --

Yes I can do that.  Originally I was doing that, but wanted to avoid the 4K=
 copy of zeros.

Thanks,

Alan


