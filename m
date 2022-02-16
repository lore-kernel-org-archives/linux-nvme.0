Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D97C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZQ8YuXtD+g9x3jNH2CnEBPDsqoWCNG1auJWUZpVhSM=; b=0M9qxTvVUilpZbDKX7socfLcW9
	myzZ9oAN0Hh74Tzh6y8YJ/+vKa5Cw3sDDGsf6PP7GrZFc0+88JOLo1CJifUiB9PataZk5NCkciu9j
	ksljGHaFEfAg/fJwCK4XiXYFsZgvPPUcj4EgDpW1UndV4+tLmKmp/TfKjpOL/lAxNGlFgfIrBs8I6
	1vUFHVjoO9l8wQqpiMCXTPIC48YvW/nUNqCGv0HNN62B8YBC1HsFDUIbqVV7PjTKfsIZ5MPdrtXB5
	yhbqTmHOsAzI7meVmtTs/zj9LECW1wIK7ezfZoWMuBrbInsibLyeMKnwlWBmzPeqhPLeuIW/1YseD
	NdCQHhwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKNrA-007rvD-Cr; Wed, 16 Feb 2022 17:12:44 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKNr7-007rtO-GZ
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 17:12:43 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GGn0PD005435; 
 Wed, 16 Feb 2022 17:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5ZQ8YuXtD+g9x3jNH2CnEBPDsqoWCNG1auJWUZpVhSM=;
 b=hlmIYxii9xdqqnM23y+9G++98s/bnNDn97vt0umIJEo8WHvRgWK4+/NU0742ac0mqLYA
 NbCRCVIy24cqT7daShPuLFcvHv3F4jcalfZgNKR6TZWO278eNvAXQJA9XOLMQrsCotOV
 IPaO1iRTHb9n/t88m5iHxfsTqrrcXnmYrQSFS5ck93aLppmd2fyrgrrQOj1Wuma5WwL9
 B8aJj2FEmGwuSRanibQGWn9vd4QhF2A0l/tsn+YuA8xZPQ8As1ot26jvQ87/QubsLKII
 dI3dyuIA6OCuSuQ3eye9YkiXo2N+bx9wOVsfW/gL7KyaxaVMJ3gY5cnS/s8MEil2LBPU Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncatt98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Feb 2022 17:12:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21GHAXIo125673;
 Wed, 16 Feb 2022 17:12:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by aserp3030.oracle.com with ESMTP id 3e8ns9b32p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Feb 2022 17:12:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEyTAHB3DEMlLpjTpi4CYdXuo5q53ECorG7mgyl7BTe76Zkg890pKBjGVCG39/cYi61LUR4pDJzeVUDTtKTSYm8rkzJQD2LdZWsPRRVb8HG41f8nolbFtT3QadOALYHC6NZtwvwrsh6NEd0EQ9jqaDHlt00ntqikRN9KDWp+CIuqbKTXrhgY9bpdnARgFCjdjfDJJGEJp1LCJWFkLlebHeXEdQDD2QPbKKBi3Qw6KF9kSC+17YH/fLgD5z2jS5WXOUZClBuuI1VtZrV28Yg+dFi7J5jmzEpnvIkTEWkPrNBJ8iulGxfzwj0kd74p4zOcfPC51j2bOfWHx8ruvOjiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZQ8YuXtD+g9x3jNH2CnEBPDsqoWCNG1auJWUZpVhSM=;
 b=hSYFIf6jxNHRzhqRmelg9zR3vXYotQ7VH1sJ67RIDMwayYwXN3NFpJSIRsGpidnplpAiVlkPiGYTvnVZkyA60SIq0t7PafDYjIs0d68mv/5xi4oQb1zWDgz1A7eS6UzDDXoGycCV3GfmW4wWZYqTy+BvdjowXGRA9c3QcL/j6clvNvfaxqqoQAs+3yUIKEHE6DrzTbxXc5AXiWY7gcpT9DI2f7Ogxq+6kISXIXmGZwUm0TO7s2r2LQQ74lxJ5kPRSips0CitXZANoh42AJyJDawfdqEk78ILLPGQn4/ld73NSJkR4VrWjUxTcTZK7kK8JjdowPfWxoRQN2HaouGXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZQ8YuXtD+g9x3jNH2CnEBPDsqoWCNG1auJWUZpVhSM=;
 b=oPIPQdObUCbiovOvYn56h0iOkXkFFe/w8hjlF3ZzFi7v8EKcoiPGbYAXtIY1wFp+sosCcEl7othg4swksY1eh7YWjyD+lioQKVucdbWnLMu9UGR9LWH2b39n3OMZqbIkeOHQkYdvmWtABY6fRnKnS00ebxICudQCL6Crl46js1A=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by DM6PR10MB2843.namprd10.prod.outlook.com (2603:10b6:5:62::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 17:12:35 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4048:6aa0:455d:7844]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4048:6aa0:455d:7844%5]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 17:12:35 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V7 0/1] nvme: add verbose error logging
Thread-Topic: [PATCH V7 0/1] nvme: add verbose error logging
Thread-Index: AQHYGNbeR3XXx+smrkye3PvLHXeAJ6yV5Q+AgAAV44CAAIQnAA==
Date: Wed, 16 Feb 2022 17:12:34 +0000
Message-ID: <5A83260F-EF53-40CA-B29E-D7C6062D49D6@oracle.com>
References: <20220203081153.162956-1-chaitanyak@nvidia.com>
 <20220216080115.GA10554@lst.de>
 <25d819e7-7cf5-2244-1550-7df10c3f049a@nvidia.com>
In-Reply-To: <25d819e7-7cf5-2244-1550-7df10c3f049a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42d0a0bf-d2ed-4c0d-d5c9-08d9f16f868a
x-ms-traffictypediagnostic: DM6PR10MB2843:EE_
x-microsoft-antispam-prvs: <DM6PR10MB28432795809726634953B9B1F4359@DM6PR10MB2843.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qi+uU0OlHaSJeNdohaKtJD2XjRWCD0bG7kq7IlFN+qLPf9pnQBE6m79MM3Yku8P2FUX4URUsiB5Ss7mmX3mGWPZ2eIbG/k/gUqvn+Rlr+munDYWG3SU5xvMmGFoiKrffvF2L5/yEAVrXbVyJoqIqwkYUbt8UYS2HQR+poWDzcSLacns1UJYBIhjHM56Z6wjEDaFwtbKUcXlN/kRsvX/9hkXa85xjqf5Z1g3xeiuAokc2QH9WBoPH3rQZgxvWygpvCNIy6tc/7uNv/3yOaUG0/jjaE3GNGRUyvQ/gXxVLoZRbFG+llASHurYAAltYjvIycK1GSGcv4HiwWnH0V8ZXr0oCBvDdk2vxQzMR+Ssjie5YAyj1dIh+w6aOmztiR+8i26HpugURPZc1FVdpNCbaYkmR3EKF8lJE1NdkuU4IZ39g2DwUGcRC1ISvUFrmiTvb8uRpNovM7kTj3vNNEn5pxo5DQBV9UASS3sIOpY98biUvG8zlL7aQA0acO5BYNvHTKB78qYiCk/kxSvaT1V5hkpFndpDrffa39i9oF40OxRk3P+smQd55tw0ld+t4lc1zTrIB6HB1Bug6buF6UkzkwZMgOALSuDp2wT/zhbN0+xcQt5DWRSyiPKcUOuBa07aR8QQFOmMprYwuWQc2Pei8H254VsB5DNyYJVYDzDB/ozG0DfBv2w0hFtUXR/rxWcWDoivCeqOy0Gg7ijRQlFGSPa73/QSFb3PR6uwjAO7cewY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(5660300002)(558084003)(66946007)(33656002)(2616005)(86362001)(44832011)(186003)(8936002)(2906002)(38100700002)(71200400001)(66476007)(66446008)(66556008)(38070700005)(4326008)(8676002)(122000001)(64756008)(53546011)(508600001)(316002)(6916009)(6512007)(6506007)(83380400001)(6486002)(76116006)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gkrJuJJi2jQBsuqoT2wOSNajlnKqA+1SbZk1Nj7zPHnJ7e2bEkcj8UjwLzvO?=
 =?us-ascii?Q?+6/s4YjLeBogq6/Mwcq8m7sw8yLqJx1aPzxhVA5b5mz3yve5DzSoMzymBqv+?=
 =?us-ascii?Q?LquMmisFlxgToUF1aFJjfIDEfnmxwU/zm2OEsSaRZYgF98qiT8KJrkxfB8mO?=
 =?us-ascii?Q?wWLd2KpUiKpRMl8to1bnoS3XGgmka219xDPGXd5Z2ahHMoJ2nvPvFjF4VGwg?=
 =?us-ascii?Q?8jCXhIGTxY/1TYAsQzpsDLIevl3mDvPbWeVLnBQCKyWDVqrRxPlbD1XteL35?=
 =?us-ascii?Q?vatP1JgIxO7McpmjkrQNKYdRxCuUTYjooY8V/18pBQngTXgEHTOkEqUAYWxt?=
 =?us-ascii?Q?JHdRFNMyuLFxOv4FpotVkLJvNJVqPFQQ7Ab/KAVhxWw+7pC0tv+vVmPlhd0j?=
 =?us-ascii?Q?5xDntNBdgHl1t7upAhImvNcoJoeuZkvh7HmTOYcKOJpkH99y+Ps84cfUsuMs?=
 =?us-ascii?Q?l4zEpOZN3InnLbfbCFa/Wbxldj1w2jt5uq2I9Aoqcff7nLCb4Xa0vrHKrKV3?=
 =?us-ascii?Q?FJ3q46HaeVygINDKtpPxjzcsLopzoVEq1UzOJX6aDr0uB1rlgYCrEGyY+Txq?=
 =?us-ascii?Q?gmfrymCwTvEBux2gmgFtiiWYsdgkUqw1cmuwA6xcVzdJ0gBPdCU9/jyS1uFT?=
 =?us-ascii?Q?9VKCTCRRqDBaZdRE8F+bFPZEMAkHYPrS6YzaaTlLfU8uFNIpI6foeVRpN8dK?=
 =?us-ascii?Q?bAiqZtEOgEajhsSoqGu3yO0uFW4WR2tGCy0xm7aL5O0RUwhQ2letu1BKu6zl?=
 =?us-ascii?Q?TzvzQ6qjzkN+1RQXZVDhBjjgxJ/H09fdYXpHHtp5QNNV9O3SUiWDXOENBaOq?=
 =?us-ascii?Q?Ejl+1UoXKm5xCQsjPhUlHFVSUU50re/92mvOizM2kGlvDAO9Z6MsJSLTBtV6?=
 =?us-ascii?Q?FdYdSUKJDISgRzPmwS0Ff3S2GzA4TRlSOKqxBPvUPHABZDhXcX6in6ujYhs2?=
 =?us-ascii?Q?q9VzVD39DQHdJzD/EsvCEUFuxNYTZMkeB2RhDwxkxZd4Qdt1AZaGLkKkUTR4?=
 =?us-ascii?Q?nrYD3X+vgz4zE4w+KNHeSeMyuOTSD1zLwcIWOHmX8EdQpgSdq17v0oY2YWrP?=
 =?us-ascii?Q?ZDzdi1/JaW2yq6uK+QSii5m6ohCPo5pXCv4fQLF3L0/DBkgJkScPLQjp1W8d?=
 =?us-ascii?Q?TuGgHa54GFPnPK/7nUzRouBeruFVdkX//+69mF23vgk6PxDHgE42rTv3bz8j?=
 =?us-ascii?Q?BuCKoztpU2cBhkdzGMVP6BrT/bRzP2YwIMwGbh9z8oBYshWNsU/4vI3WZppc?=
 =?us-ascii?Q?9iq4UG4iPQQbkNuN4VX9VxdMeZRdHJuplR3yOcDJtrwcAA2YWpfVp924OuID?=
 =?us-ascii?Q?4KUsSp2vAjNSNE138YfzvSWREd7UI9o1+aK4o90g/dE7z7OF2IIVwG1Ugr9Q?=
 =?us-ascii?Q?8GoZVsu0W5r4RZMHEIps9dX95ClKyrE35hxLpdX4wnNeHOBy17Q9+lMWbH+2?=
 =?us-ascii?Q?TAtJefqI4pL1gO4mrUR0n/U1k2oWUqsisjGvgt3hHotsuq5D4+eBM2YDBfEk?=
 =?us-ascii?Q?Qs18gHhTjo/7JVKAUUzD39i/bGz3Vi+9cTrzLjLY8wCNUPjKtDoHnYJeRVX/?=
 =?us-ascii?Q?6Z1NbIgzfNUr6lfFOu3q3AjVgeA4McID2vAzc/2jRtVt8CQZ7wlkMuJgccik?=
 =?us-ascii?Q?nFhcbd140CZSk04C8dp4wFaci4ckemdAg7BSM8q3xryzfQPFa3RCEfpeKBtt?=
 =?us-ascii?Q?Uc8t+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D37C6ABDEC9D14EB450A56BA1A79784@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d0a0bf-d2ed-4c0d-d5c9-08d9f16f868a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 17:12:34.9752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1yCIa9tFo2d+pTSfnMJb7f5d0nrChfJ/uDr4jJBMBGb/LEasH5EcdrOMV2YeLRLu/qSiiA1QmUktncGx4SHCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2843
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260
 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=958 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160099
X-Proofpoint-ORIG-GUID: UPPmankSmcloMZfzAs4HUVAjtKiihJpY
X-Proofpoint-GUID: UPPmankSmcloMZfzAs4HUVAjtKiihJpY
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_091241_729508_76E663E5 
X-CRM114-Status: GOOD (  16.49  )
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



> On Feb 16, 2022, at 1:19 AM, Chaitanya Kulkarni <chaitanyak@nvidia.com> w=
rote:
>=20
> Alan,
>=20
> On 2/16/22 00:01, Christoph Hellwig wrote:
>> Thanks,
>>=20
>> applied to nvme-5.18.
>>=20
>=20
> Can you please write a block tests for this ?

Definitely.

Alan



>=20
> -ck
>=20
>=20


