Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94870C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SA+BGpC8n43Qt62MfSwHJpKlBJloqQWFnl9Yd6JRcIo=; b=4zvTrDlJK8X2kRb0DrqlRpOTgN
	hKosrXKCzZdSlLdodVi9/5ooN7bwJVwsNp1oIFoxkrkyOpl+bneneflmv3BDjkG8WD8EWv5U4Prht
	v8kk33i+W677PQ3RrlVkC9kBOkPKiJMvCLm4ibmW5B1j0BLpAVilA64RHoSgfYmsctKG5XkzzUqiz
	sJ5aIa1VIgyHCnE99WueTuVOXZ2m7Vc+7akQ05yXQF7+HsbG9MT1LlD2XKsNhhCt0AGQfou7eYApi
	j2FJzuL3rBdU6ubjfudQtb4LcDEETKi4bCSr4q1farLF5zNB/3WfmSRN00ADxWWnSnfw/rnjChlFU
	SljspBXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz09V-00Edwe-Ha; Wed, 08 Jun 2022 18:11:33 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz09S-00EduV-2I
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 18:11:31 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258Hch9H005805;
	Wed, 8 Jun 2022 18:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SA+BGpC8n43Qt62MfSwHJpKlBJloqQWFnl9Yd6JRcIo=;
 b=enL8IkVoWc8sjSt2uvnXStQki4fw0CPZuYsL1pAZclhNHIzAqT+ei7xOLRaKwCknY/Kj
 36y2GWmPXUr3HNFHBO5Zaboy2BXsHsm/KoZb2B3H7YAOrXAE4UV3xVVEkjVLfK60u27m
 rfdKasKi8YDeJBIAkdkC2iOYwiumqaW/ybmHxGfM8IzxAesy9irYMKVz04t150CrvcnP
 k5hWgKDFYV1pyEltZTb08r0kQrgOM45EOIMm180wUFwm4LsFvi6Xou1c/i7ughjczQLl
 enpnl664Qzc0gB/eCIIwMRYM7K0+F22HFOAacWKRVD2saREGBO2NLAqWmc9g1QpzjvhW 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekh5th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jun 2022 18:11:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 258IADvu037013;
	Wed, 8 Jun 2022 18:11:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu3vx8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jun 2022 18:11:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsvgX6ZBJdx34UdgWUtVQP9hsYqliuI/lcHg8vLOxURbXphCfGp2F6ww2daumr9s/WbEOERexeOH+OrFBDPtvMI+mejMJ3tMmc10pizHrX/YCXrHfNyomq4Hu52/dYf2ZDZFmwdZNsPUTejYeMVGbjtd5d3nVTwgT4yNRzW8vIhMn2KeJhVa5OFhfT/nkyVnd+80slKNg3LUpS4jmZPwblWwjtqmSv2axgZEIzgpjm0S3BBG2+WqzR+bWQKOrXyDl2VkrFnAvprBkUKKRNVHdUu8jpj45Y0+ZmcdUls9aBzikp44dSqUnPiNSGGxTponhMP4SBlZBGa4kA5BDOXRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA+BGpC8n43Qt62MfSwHJpKlBJloqQWFnl9Yd6JRcIo=;
 b=bu0DLR8+g5j/pMqCeYi78o5vJF/TmvFdyBbgQxG/lnXwBE4q5i+MzwuWwh3by6xhEC3XT+EWilvXP8H+WMH8NPW497SltoaDAY3V5MglIitbyCBytwqEK6Vpka2WUEmA0EBUJiCxZi75uCVT3ycDXaQEhcaDa6chCiw3lNJjLtOQgoDAMIVNKXf6E+ocdi9HQcXtXepOmAJZLIXiAPQmtbRYunm5oLw0bHTJb5AkjAcl3cmJgd3fe8QRe/vsm8YhHAoFIKjX9pXOuiMtwn274EpmmHuQBF5K7/NXl9RB+m5eRqk9vrnzCaslLURGJ92K7O4HLvCzQ4V5pjabuz5hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA+BGpC8n43Qt62MfSwHJpKlBJloqQWFnl9Yd6JRcIo=;
 b=SdSr+6Rz2ZE4rduylOkoNa6InWgnI4rTKUvE+zzJ90kkuMhfAKx//nYI4/hhBdeMCiT7d63ZspINvxbAWIPnAaRCB++za33hl4monVmlEKYqmBJM6IvqRyjYh4U9wR7Xe344v8muwt4DlNLFo6yUCfSIYSpCuHQBKpLbd4uFotw=
Received: from CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20)
 by DM6PR10MB3833.namprd10.prod.outlook.com (2603:10b6:5:1d2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 18:11:04 +0000
Received: from CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::5d5e:5635:36c5:a8e7]) by CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::5d5e:5635:36c5:a8e7%8]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 18:11:04 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
        Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index:  AQHYKbXc39T2BoiygkiETee4KuxaGazldeqAgABJzICAAB64AIAAlJYAgAAa2oCAA+JBgIAADcuAgAwnQ4CAAhongIBKtzYAgAJPjACAAKy4gA==
Date: Wed, 8 Jun 2022 18:11:04 +0000
Message-ID: <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
References: <Yk+KO8hEYpnKdGu3@garbanzo> <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <20220608075252.GB13027@lst.de>
In-Reply-To: <20220608075252.GB13027@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31d7bf86-2eb2-4cd3-249a-08da497a4061
x-ms-traffictypediagnostic: DM6PR10MB3833:EE_
x-microsoft-antispam-prvs:  <DM6PR10MB3833A3A81B080AF92364029AF4A49@DM6PR10MB3833.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  JSI0dGV4BHd3ohhKNUhTBsdNMHj1+g3XSk/Kx6KvpLY+lporoE0+WLz/QpwwYWF906712kFh7gjDZYQIPw+/v18s/Mq/B/e/y7Dhhe5y+fbLWRmx9xRhgONbOKCbsuIkK8s3YCfpCoavEy9vW4VfxQ5DfT9j4N43RA1l64MTb/zJ+xUmB6h7XY/QeVUpoBUc/wDAiAaAY80ngpgKAtbgxWeYjtJQ2afCgzBdxAKepXujP1QnH5i+8j63TlkYI2965mk0jlwX+noji/SjfnRL/R/mUhmopPmftMtV+r9T5XUkixo7luAZ2CL1dVpw34FGbUqcHjlKx2NE6SA1ENPwSbdz/pIEnvbACgsJaX30Q2jlWZkhn3ZgOphbHndwREjS8s31+MeuNNnvmiWtqdrNjlvFZ2pYPzPa5smX5NztDbRR78BFK+6Ln7xtGubMfoHDzrl8RRnfUQqYlscZUfjyQEnTU/oZC2XwNG6O/WOr0fWZTUanFVMdWt+79P6eZINFb5eNQyLPuz3ILu2L7WoUx/qQG9vMvRvYlcHV2uBv+AJT/35FDbhZMjTF5cPtGTxkMrwTXoyvnWKKYQAF1Gqun26qtcP0y/gVNGtzvmtSTq08oRDyahsm3EilPPVbDOPyKWIItSU4sfQ1xbQHxHx6dR+WVNih+Ua6+j7q2Ao0eWlIxp1lSk12iY17rS9fLHzdwkEzVVPLBJvmLUDY5ZtVlPKvyPox9j+8chh7dRXOvmJPCWkn/YNcUpEuSdNuHClX
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5537.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(64756008)(8676002)(5660300002)(66556008)(66946007)(86362001)(44832011)(186003)(8936002)(33656002)(6512007)(76116006)(66476007)(91956017)(122000001)(2906002)(2616005)(66446008)(53546011)(4326008)(54906003)(6486002)(38070700005)(6506007)(71200400001)(36756003)(38100700002)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?66u/yWKuZchslukp2+WBJ3SfjKWXUMhqd3f2TOQpmyQfM16dDxID6ocXaonr?=
 =?us-ascii?Q?UOyiafusAuJhYsbsQff0N7Lm19/qXf5PS4B+eLv8fiSciP2YjIavTdJMa3j9?=
 =?us-ascii?Q?jE69D1Li2uVvZ0JlOuHmTOBEwAxRoU4pXDUp1YiivxRLhO4JrEHiElc66S/M?=
 =?us-ascii?Q?7B34dYGhR+3BH5FxiuNlFx9mp9wV8uzMsorahxecTYscpBPnMYk5tbYAKOUG?=
 =?us-ascii?Q?wQHeWpsfyNVnwtofSeczRVJHrO/H3wepKUj5Rp5/3tHbIsCN13SPREGo1cFu?=
 =?us-ascii?Q?otVNkJ5Q5pc8cvoLjTWwym5Z0vUlby1FMyncNSkLESUIOiBpN/lrqAkwn9gQ?=
 =?us-ascii?Q?iQ3BPLrcvFpDTMabdUDvDjRRo13xJ4HZso9XIloV0HbiDBw/dMjO7VXHEeRq?=
 =?us-ascii?Q?hU1W8mPHPZhDNoHAFktUzsowl3enTsj39L1AxxS1XTAlfPcphCPnF7lLh8cB?=
 =?us-ascii?Q?XKf1vBNXrRevclsl9HEziJRL5+nYqHdGe1BRwIV5KmzmUiadPYD9VBWpJN4j?=
 =?us-ascii?Q?UOd5V0TDf2L8f3kpsLiaysbIjCxhV23VYw8OY4Fah2w0WKRuoLo33aOASGTu?=
 =?us-ascii?Q?Tu+Kl1XaP5U8xywTgRCD0QfRtRLO7GXs0790YjWhAO7k27avk1C3SyXcx6Ok?=
 =?us-ascii?Q?K+1KbP7xEjEo7FYI7qph4P4zVJWpinWEzPc8PViG1Ar/NNNQpqGpvJ1/Z+hl?=
 =?us-ascii?Q?rrADJ2+0lp4+q9NCFXBX4wHdU5I3p+KRql6nTLqc0uLtZjWzzd1BAvweCYc8?=
 =?us-ascii?Q?/dzqHsoPh0h003BSmXIR7o4bVetnGDbyCx1EMb2frxQqarm7VLpaFkJdciS0?=
 =?us-ascii?Q?NmmGQY2qdmiiVhG76AQSI1EKFjRsyu1EtL2fFSpqvtWzcSFq9JkMNuyAOlgP?=
 =?us-ascii?Q?atAYb0bQXlUAFq1oX5zXwP/7L+TrLP+0d3xNPDyHoBg5Hl5a9TO9w+W4zvil?=
 =?us-ascii?Q?WZAIYnfvvRpEFlEtqkFPdVUEjwQ4ABH3vXi3jfCszQVWS54SUQKaMynq2y0a?=
 =?us-ascii?Q?zwIJV8jsvitJbgg/Extsawz2FxD5Xxv2aDwzkdjOE1O9OEC+BySPXyGUd+Ig?=
 =?us-ascii?Q?vv3E+8FPPt2wTfTUnLGxnycXsJn32XC2U3VdfKuyzNJGRF5iFdoLwslO6265?=
 =?us-ascii?Q?gAwiVItHlK5r/sogv17Deibqi8rOMVuZ63L2q6s/rN7crsjFCmFikdxpbMrt?=
 =?us-ascii?Q?4u5HpKRVKTUSktBrXfLLBXbqzZpG5I3vuHLWKRtFeB/lVXq+jepABHnz3NmN?=
 =?us-ascii?Q?0nbgzwFdw4Z0IlkZWROF1AJeQtzvX2cgLFeX6Nwu3zD7O9rb3+o6MK3JzsnR?=
 =?us-ascii?Q?NWxZl9/FSqGAmYHW0IFlVKNemfqFklRG128zizBWtXYjNebHz7m56c0Q1VsF?=
 =?us-ascii?Q?zZHDDSweNYFBK5bLRac4wswYxvUEoyu4gdJZHnYYNE3AbjW2eCqTMhR8qEbg?=
 =?us-ascii?Q?irIa01WIMhnc7wjMEhIdvC03T8SuSV+Zrbm7qb/JCSWeh50y+htV9M3EcG6R?=
 =?us-ascii?Q?p0z3YLkkGqAw0bht1ld/XMMMEuxDPK9581CvgiNqeWFdk7dZJTFnHGe9dISj?=
 =?us-ascii?Q?8DwE0lkxeRG0nibqD03tPEN5jvcn3dU/sFQ3gCFQC7+EDb+yMLJISOKpyU0q?=
 =?us-ascii?Q?1QZCsAF4CgXsfnDOrzVa6K6IZLzPtprpb1ZQkGop5asoq2VdnKgNjXQFoc5G?=
 =?us-ascii?Q?Rb7piePuRoxS7UusDulX94Efe6OiTFfMw8WA6kgcrKzYAvKrxnw2EEaqby1n?=
 =?us-ascii?Q?cMG7Lmk4NILCc3HGXT2QfLhw+PFgxetzWMvPA6WudwX3AIiOHKBhVyrdzWuS?=
x-ms-exchange-antispam-messagedata-1: YKZfo7p27iRgmw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1730D5DC63B5C14D81A7C2F2D5EAD840@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5537.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d7bf86-2eb2-4cd3-249a-08da497a4061
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 18:11:04.1136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXAc+vWsuL3aALjUzxdRer5p1IrTfdOLy5pJ2ZyJYmA5g4z5SU4fVHcaBUWBjwIdUt5N52XLb3J+dF7C9+lfZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-08_04:2022-06-07,2022-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=915
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206080072
X-Proofpoint-GUID: i58IOoxz5ahUsHNpha4sJG9HmVaa371c
X-Proofpoint-ORIG-GUID: i58IOoxz5ahUsHNpha4sJG9HmVaa371c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_111130_260380_13E4CA47 
X-CRM114-Status: GOOD (  25.09  )
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



> On Jun 8, 2022, at 12:52 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Mon, Jun 06, 2022 at 08:35:39PM +0000, Alan Adamson wrote:
>> nvme driver changes:
>=20
> Thanks!=20
>=20
>>=20
>> 	ret =3D nvme_global_check_duplicate_ids(ctrl->subsys, ids);
>> 	if (ret) {
>> -		dev_err(ctrl->device,
>> -			"globally duplicate IDs for nsid %d\n", nsid);
>> -		return ret;
>> +		if (ctrl->opts && ctrl->opts->clear_ids) {
>> +			uuid_copy(&ids->uuid, &uuid_null);
>> +			memset(&ids->nguid, 0, sizeof(ids->nguid));
>> +			memset(&ids->eui64, 0, sizeof(ids->eui64));
>> +		} else {
>> +			dev_err(ctrl->device,
>> +				"globally duplicate IDs for nsid %d\n", nsid);
>> +			return ret;
>> +		}
>=20
> I don't think this is the right place to clear the reported IDs.
> The proper place would be in the target code in
> nvmet_passthru_override_id_ns and a new
> nvmet_passthru_override_id_ns_desc like it.  Otherwise we only catch
> the kernel driver uses and not other users of the IDs.

How do we get the clear_ids setting from the connect to the target?

Thanks,

Alan

>=20
>> @@ -593,6 +595,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_optio=
ns *opts,
>> 			}
>> 			kfree(opts->transport);
>> 			opts->transport =3D p;
>> +			if (!strcmp(p, "loop"))
>> +				opts->clear_ids =3D true;
>=20
> And maybe add a comment here.
>=20


