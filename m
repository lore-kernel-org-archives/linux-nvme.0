Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF0AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 13:45:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C105610FF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 13:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C105610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TCl4BLG4QZ8eqy55ytz0g6wWSRCfnAurorZTrsvgMyc=; b=4MtR9MGJrKmqbp
	niKAMkJb0CV8/rLuS4LTCiItVLF3SX1UZ5R8MZH//oxxkpNPLQLbgWXRW1MDjzHr2KBSF+jannBLo
	dbcZ/VVa7Y1COic56tLohBNqq7dVAnrvmnDHfiIEYWEL5cQ+9/qeK/7qIPRW3GS4u+0fWmU27tSl4
	b8Xlj/TH/qEntFns0+12HN0LNAsTSmOIoI0x5Wj/LNOKysbfp4DAgxySEuzmb/WEy/UGhO1lubk9A
	GABGxYeWNd2xF+y/fonLQ7yMq37/4ODxvf5MKqmx5R9r56AV02RojNe4Znqg7mJmpPmy+URHGiFMK
	L2E3xuKEblKE3oba8zEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNxtA-006pLB-O4; Wed, 08 Sep 2021 13:45:20 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNxt7-006pKQ-MV
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 13:45:19 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188AJmdV030428; 
 Wed, 8 Sep 2021 13:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vOESXOr/VFB1HtflQKKalf+xm6dKuxH5S8DcPoeDBL4=;
 b=xUdvj8+itAHnFmTcg1fSGZ73LqJSQr7CuEtaYgFFHii7qkFGszJEqanx5ShlAJjeh1Qw
 2Q4n2x8j1ebNK2WupyELP3nXADLZTOsXYd6m8whTLo9khW8d+XCm8iKrAXIbiPFsNYoZ
 V3Wfc96Qy2F+h6Vr1eaMHDW2fPu53ol68KSAXxxk2ZJzArLcE/kZnzGUIGdKBT67eycj
 F9QFUk+hcXnWOv1IPZqdIFxR8jkKuA6MKzcsiMUYI6hKTFx+8am6k0E9xfDRxJ4b4EfA
 1tjQlDp6/o8zlGLN1zL+hwiVl/xNdI1tm66H0Z1Nww9fkkNkfVXc+YZ/wg82H9y28zLf OA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vOESXOr/VFB1HtflQKKalf+xm6dKuxH5S8DcPoeDBL4=;
 b=um0npuJBQ55436/chGMI1cOhVkvxPh1Ab4b1yWyysCApxqIAsjCF9yzR8Hnqs9SmO20c
 rkfTmpBAUZ+8TJAP6Lj05pS3LGWQwha5u1o5CSTWybdWM9LmCOYCiOPZFaj/Bz486mjY
 GLBKRznNXezTTea9GnJ8EghapdUyPXTfohC2nQk7YnqoE8b7pAarHTEEtyf+4yWSxCSr
 jm87IJOeE4O0mkHhx9AUrCgG/tYNMD8IOIN8KTHQDNdA6z3CkKHAtUT9VJiQ4N3SC/AC
 u692j5/1hqZ+7M57ckuUigLYDYcTf/c1Q9HmAuz17WT7YmpSkYJgAvDXci/am6yNyOsv 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3axd44tq7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Sep 2021 13:45:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188De56E147473;
 Wed, 8 Sep 2021 13:45:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
 by aserp3020.oracle.com with ESMTP id 3axcpm8uc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Sep 2021 13:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgwlKhoZwSmkyKUn72IINYejHazI3Em08DFp6Xs7mzw8Ewxm2CuTfrpaG7oETtyjhAnS8tEWDaVHZBGePOOxO5rcAnMxxAvfCc1jBDLKjXC5hsvuiTDzWOAGtiPrYCsD6n0OWD6SJ6Kvm1ehvORtYwMC8ExMVtoJp8oMrxOQT+Bw0tZm+GUI+5sOwh9q+f/y1I/Ltz+pKb5v4VJQgVDnrrcZIIz3GNrwlDyahKT3lm05MS842x7HbxpHXpOmyvHutXEckx8V8bu8eqgirIWH2KfBgoSCRBS69HuOjXxNLFZ4mSN2wVicKf5NWdlwEeQX4EDe7MSjsKZgWLu8IHHgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=vOESXOr/VFB1HtflQKKalf+xm6dKuxH5S8DcPoeDBL4=;
 b=h5CHRysligMB0es2txecVBNtR5G8J+jBWUOv1Uy7P6FRinKutb4cTpGhDRaxgt3h18mhTK6BLyeaI1556EEZJUAh4ISUAZCe7ERHRHRRyKZExB/D3AmrwkIGePnsL/hhYMKUv9Odp+6OrZ1maxTGasdT5emp5mP6fJI/XwswYvIyhHVc1UmV/SgcP+7FzXQnmXb6zeIXE7LTEY6HP5myScdnu6715pIbYAznsN61XBISllbrofc0ZLG00tqTpSnlavbY35xRUJxyF+H3qvVDPT+ec6t0Tq+IEyzNFtTH74AtH2twOrUHZVwIuWvtQjBOxyxG3SIeldysHA+FIVl8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOESXOr/VFB1HtflQKKalf+xm6dKuxH5S8DcPoeDBL4=;
 b=uls6qb2fPN/HW1UK5QtDhLTm23aDdlzA/x5fDuoW+1jqRmaIdCrEZ2P6ZPnbnUp43/++9occSPZ7Wextmfz//ve6zK3WC6zx8I9XqsYtMoWoTZ+lhiidiM1PVqEfAjP9uv44t4S8j7wJkI6w1LDNl3O9jHWMEIib+Svy2ORQTYM=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN4PR10MB5637.namprd10.prod.outlook.com (2603:10b6:806:208::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 13:45:13 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::38df:8fa2:1602:2dfe]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::38df:8fa2:1602:2dfe%3]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 13:45:13 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Nilesh Javali <njavali@marvell.com>
CC: Martin Petersen <martin.petersen@oracle.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, GR-QLogic-Storage-Upstream
 <GR-QLogic-Storage-Upstream@marvell.com>, "djeffery@redhat.com"
 <djeffery@redhat.com>, "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH 02/10] qla2xxx: Display 16G only as supported speeds for
 3830c card
Thread-Topic: [PATCH 02/10] qla2xxx: Display 16G only as supported speeds for
 3830c card
Thread-Index: AQHXpINsbv/Bpsvx4kqtySEV1efN+auaJniA
Date: Wed, 8 Sep 2021 13:45:13 +0000
Message-ID: <B85C1B1B-DD6A-46FD-8C4E-563156E95839@oracle.com>
References: <20210908072846.10011-1-njavali@marvell.com>
 <20210908072846.10011-3-njavali@marvell.com>
In-Reply-To: <20210908072846.10011-3-njavali@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 480adf7c-09de-411b-3f81-08d972cee27d
x-ms-traffictypediagnostic: SN4PR10MB5637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR10MB563708B1D5CF27493737D980E6D49@SN4PR10MB5637.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QxsGeLOP8mdPqn+lkbjqlv3fAKy6nWPlMGTBVjFdADBcCG0y/jfByxEVTeLFc73JjLRZPTWAKO0CM6c79OTVnhYyivtoJELsuYYyHq/BP5pX+xIR5Kbj7L9ZGGQyEI+VB6EQVIa2gAikLp51g5nWWKJpIoUGnFb3t6DPVBDwBf16JTcvH4JX5jFZGJSQt5SD//GQ3W9NQ+szHOLEOLjiyAPdhpn+Biod7WRpolDVMSdYVxqUqsCiTdDJYxdLXWWEjmwk2vw3mtdhnRL4nwiZeTZdM7HhoWjvd9+L8K5pVsVbdZ1uon+esLqL+lvw19IW+NhMS5V1m9lRpP5Mx0klc26dabtGKVj+twNvBBL1pxeeMqisf+ck84hZ3jpypKYKZYRsEG2ug5UEY95YOGRGeh8rvipnFLlWGUAfyMNUnw3ycEJbpLu6A9A+mXSw3JnenTD733em64dk670lgsjZO2ebYLxv6kmtrxNX0pt90Rheo+NRxpJxXkzoh1YmlBbcwd7cdSCkXzfmXypJv22HPwriiHsue6JSSokvgBRkElfayZCdhNeOUWnLwafPUYyWRucge97bNhCAmSnHltbgef+i6HHtQT/AA0PmtTaShB4iNOhHIpFQ1sV2ogFWG4yyzj/WTdWymX23WvwZI5TW3SnWvnB1EcFoZPe77gSojsuRz1aGdEYeZsb2T0b7AOYA0ypWHuyZBjiSfEe4+Qz4q/5CDMclUrY/dbDyJGym9Oo3pQ661I3CAj2ecUo5yViS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(346002)(376002)(396003)(136003)(39860400002)(76116006)(5660300002)(86362001)(478600001)(66556008)(53546011)(71200400001)(186003)(36756003)(6486002)(8936002)(6512007)(6506007)(316002)(122000001)(38100700002)(4326008)(66446008)(6916009)(44832011)(2906002)(66476007)(64756008)(83380400001)(26005)(54906003)(38070700005)(66946007)(2616005)(33656002)(8676002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8AQvaYdpT/jX/T3LbVYIV2fQuiY5sXcImDTGvOW9P+R+EnOandWTiuPUSMOW?=
 =?us-ascii?Q?B+brd8G2dusabKzY7IiNddvbgpLk7Ds+BTIBpnr4sxSiBiUsKm506qihrMgI?=
 =?us-ascii?Q?bJfMd7H0z6J2NT4o0iL9oqmAPe4zXE1TGuBIuWLGRvWira7NmkSDeOKZ9Fjk?=
 =?us-ascii?Q?nw9EfvoLTKwZnguCNKWlD8rTdlz0IXWogjo45kgUAKxI9UaajBXKadFWXCIn?=
 =?us-ascii?Q?tBT2zgbMpwzpXHtl9xYRvAV4d/CKUfwkwnMTYI+rv9Kie2QbrTGZIxPL48yZ?=
 =?us-ascii?Q?RFHyLvvACn6pFO+MQufNv4iMyK40Bln9US2UR8qCZb3idpXxp398p6XV0eZ3?=
 =?us-ascii?Q?s3Tdtolyt8EpNctqACE+iplNXYGddjA8ESH+A0svlRg+PlXO4VHGnRu3ymW8?=
 =?us-ascii?Q?UfNwk6Ig2pLRZAVgCXnAbrh8LaHDQg0YidnJ/wA/wXKJWcelZrwH9eTLLEbr?=
 =?us-ascii?Q?LpbThKRUki9nXBixBsTf4X/zGWAXCE5z6lcQhFCo+DrNQaKWY9ct3weyM27c?=
 =?us-ascii?Q?avsMeBY4zsCNOHgUyQ6y8Fj/E9UbrfS2fM3RMKeQXyW3HWiokRIudhEjmTwP?=
 =?us-ascii?Q?VLPzlD2IOTk7hm48uN82s7yXCQRvXpTj+zZ4oRlOKAkK/D7HIrCgrfY/UjlP?=
 =?us-ascii?Q?KXtAve2VNm96+qbJTupW5RiXbEAOrmxSeR1wDTrzFIqEN43ltuxOPmvJbni7?=
 =?us-ascii?Q?wegSBxdyKS94nBM4FOBSiFqPfKrotKXL24w1B9XY0I/ywND52P0V2MUwmdG+?=
 =?us-ascii?Q?V+PVV8wCYBKxpTRzS/bBPa3/RrKUfBApIE7cjY7NeyKC7qle6VjNxXO8WDoM?=
 =?us-ascii?Q?ViSe1rwZ3r7Fm+QReyNUMkr78rxbB7RWDxTHUYqnUgG1bKXIm8dN0rgS45P5?=
 =?us-ascii?Q?5FH5DjM/3L9oRJ9/1mFwPRgfbacY70rCe1hsrQEjhbUc2Ne/53Fd16U1Ct6p?=
 =?us-ascii?Q?HZpziq4OoiUUdTSWM8PyYOR3niZLWo1Ft1yerbMzYO91OH9ORvpIgHEMv7lz?=
 =?us-ascii?Q?68SuEreFItwxwdY6HJ9HxhSVk7zX9v0ExwRLtLxWbpyJshIJ4Casha2XEyaT?=
 =?us-ascii?Q?XQ4l8SL7dQNukTVV0WOjxAyVoatOkHKt5guO1XAOEzQuU65MW9LtJiZKs+3m?=
 =?us-ascii?Q?mlmiABnvU1vUs/tlTmBscUn+zunkqM9y92A7pTrgyUncwpVpZIpi4D5UKhjT?=
 =?us-ascii?Q?csyVXOLsCLbyaxApJzQ504HLtHqCvdgRu80FCPSOaHszYDgMZUMB9H6bqDEp?=
 =?us-ascii?Q?q3HSPQJgQxgUBVivIXfLngY7pWOaknw2LYbsAb8j6mhKikXC26djMqYIbMZC?=
 =?us-ascii?Q?UXlzWh9PrjamWhCcUc35+okIhBzHHpBw601Z9BFr4IyvWw=3D=3D?=
Content-ID: <DAF9544594B2074F870C646FE783A967@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480adf7c-09de-411b-3f81-08d972cee27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 13:45:13.7344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tZbmZyV1SraJE0wR8nU7TuOW0BHXLnO3Emh2S8hy+uy2FSf9lIg6SqQqwbug3ehnmseGkwjKNb0LvI4CLFWFYdBSSEDI3A3bAmmjlUZ7n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5637
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080087
X-Proofpoint-GUID: RXjczTvKge9wEcrnVmW4jNZCkCHeCyp2
X-Proofpoint-ORIG-GUID: RXjczTvKge9wEcrnVmW4jNZCkCHeCyp2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_064517_917348_4D165806 
X-CRM114-Status: GOOD (  21.31  )
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



> On Sep 8, 2021, at 2:28 AM, Nilesh Javali <njavali@marvell.com> wrote:
> 
> From: Saurav Kashyap <skashyap@marvell.com>
> 
> This card is unique and doesn't support lower speeds, hence
> update the fdmi field to display 16G only.
> 
> Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
> drivers/scsi/qla2xxx/qla_gs.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
> index ebc8fdb0b43d..28b574e20ef3 100644
> --- a/drivers/scsi/qla2xxx/qla_gs.c
> +++ b/drivers/scsi/qla2xxx/qla_gs.c
> @@ -1537,7 +1537,8 @@ qla25xx_fdmi_port_speed_capability(struct qla_hw_data *ha)
> 	}
> 	if (IS_QLA2031(ha)) {
> 		if ((ha->pdev->subsystem_vendor == 0x103C) &&
> -		    (ha->pdev->subsystem_device == 0x8002)) {
> +		    ((ha->pdev->subsystem_device == 0x8002) ||
> +		    (ha->pdev->subsystem_device == 0x8086))) {
> 			speeds = FDMI_PORT_SPEED_16GB;
> 		} else {
> 			speeds = FDMI_PORT_SPEED_16GB|FDMI_PORT_SPEED_8GB|
> -- 
> 2.19.0.rc0
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
