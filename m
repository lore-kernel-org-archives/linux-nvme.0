Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61161C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OSs5t5d8XjNuYHz81yiSiCzc0oNLWoe3QxrEZKe+R00=; b=lGbwt7qX8CddudkzY/qNmN/Qn1
	mvFGtCHi7CzaeoRKFsS+7HqZXGPDbERdL5tQ5WnAc+UycUT1tBalCioJmSORHdUa6C6o06l9Jpjye
	5IBPivp7kPhIj70+oOIBlNGkUEjtMTQKY0P2IUxkJIaxQO1Oehk+gycXxWlPz5jUFai/LC5QJ2QdX
	sfibuynLrSps1wZy+sFjpiwraAksnLzflGIkArPvY1ZPG18RkIbQYzdC4UdplAx+jrtN9suPel4qZ
	qR5TGAbLoZO/X2f/nceXwDJoCY0o5WQBaYL21bqv4nLxpbrwDNbRq8+wL3TNRj2gLaAQ1vipLYd7W
	7LEANrkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIZmq-008G5D-Pn; Fri, 11 Feb 2022 17:32:48 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIZmn-008G4g-KY
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 17:32:46 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BGtUGG011225; 
 Fri, 11 Feb 2022 17:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OSs5t5d8XjNuYHz81yiSiCzc0oNLWoe3QxrEZKe+R00=;
 b=JyQGEJ850mM9btOF/L24Cnht6dI9bOLWqewYRd3tC79c6GllGBPEjcFqIyks/zKxV0Qg
 4c1UAQUcvaYjP1qOoseOQL1irt5w9CcrGMYTXojtUkoh0a05l2yxmlf0fmSQfMrXgNsV
 UixSxyphQrP1AzNg2qfn+7I1Ak2DGKUHZ9ocu83leTXUv7cAbkmaZTVlAj1gG7VP3QLM
 CyQcX+BxwW1RQWYVQnFA8ZG/ZvBFJVp50U2jdtvdHkpu1pk3HHCwURUtnjCk5cK2aU4U
 kQrrSyx62IKsx+QDCa1V9uFNPvNrcIUulnSmpLtJjWXYT3EzCj9clAKSLjOqTvVcAwEg SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3e5njr116b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Feb 2022 17:32:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BH6GJJ196455;
 Fri, 11 Feb 2022 17:32:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
 by aserp3030.oracle.com with ESMTP id 3e51rvpkpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Feb 2022 17:32:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTDBUXGu7fIpo7jFRfTXb2QBNTrvkui8TIpA3R3d0gZw50NnGN9SHYxAtDwX2AKlE7jkVjbId1KeMaPxSxQQ99s4sZSGocI/n/M+6tGyCqeQYbjTMV7v3pl0uuTY4opnVltKEtGhUL6T5rY3dEQUA0dE7bT/o7EpIkjXRF6HG2jCsIIXdUrykNBGIYZLbXrySgOoFz3Whqe0Xxl42L16jmIwg+x+AOmBUiTgQssn1ZnaFMg4eey0e27HNkjFoxIX/u4dP5NmFiAWQSFU0BLG1MyXWhPpMVclhkpYMRVTZa6n1QRLmOMK9E8UFPK4nD246cwNUk11e9smRN/LU6JUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSs5t5d8XjNuYHz81yiSiCzc0oNLWoe3QxrEZKe+R00=;
 b=PgCWhNSeO6qf39VXQaGAH4T28I722+3C4mo9HjdQevWO1YeAXG8TBI5n75pueLP0C9YqCNR+z+67bOMWPnn+0ORHM8dE36VU+rgPwgHXrvElcvCsZQnccQ3DdBmpLyx2EAhpYf3xQ9i+aCUcGwT0cfyc3rSuxAe1XAOFtcYV7PMxwnT9Hb2gHSXjP69LPdimpQ83DvCKlwdYrdtjAMjxMLkXNTMIMl7BCPJBuyq/8x5jzlJb/jKUcri+0+BJBBQNFMEc1ulVhct1CK70wGIKO7W1HwRWKrVRC9t30suGb5kEP8MNruwidtX8JnDB+t3uiSkT2mLi1/hCk6+mssC6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSs5t5d8XjNuYHz81yiSiCzc0oNLWoe3QxrEZKe+R00=;
 b=JHsQJWILXdJeJDMDaniy3OQRe9r9AoJk9fr4wWnEdoGNQMu3/zSGpC6QEjAt3BBc8i+cE1ND5wvKkqMnDZcgstDW4SijB3SdwVP6P4HGlZXWFJ0diUEfoQ8PhBY+6/2MAkspYdw94HS8Px9lAAe6iGLWI/IWYlcNKEtRkiACrXw=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by CH2PR10MB3896.namprd10.prod.outlook.com (2603:10b6:610:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 17:32:34 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4048:6aa0:455d:7844]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4048:6aa0:455d:7844%6]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 17:32:33 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Martin Petersen
 <martin.petersen@oracle.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH V7 1/1] nvme-core: Add verbose error logging
Thread-Topic: [PATCH V7 1/1] nvme-core: Add verbose error logging
Thread-Index: AQHYGNXIryfsuicW8keFZ7WPQbsvWqyK4igAgAPG4IA=
Date: Fri, 11 Feb 2022 17:32:33 +0000
Message-ID: <05D84E6D-5340-4163-BC17-DDEACC3EECA5@oracle.com>
References: <20220203081153.162956-1-chaitanyak@nvidia.com>
 <20220203081153.162956-2-chaitanyak@nvidia.com>
 <20220209075158.GA9647@lst.de>
In-Reply-To: <20220209075158.GA9647@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0b27ad9-4016-48bb-5156-08d9ed847d17
x-ms-traffictypediagnostic: CH2PR10MB3896:EE_
x-microsoft-antispam-prvs: <CH2PR10MB3896791453D5423B7A2D4A1FF4309@CH2PR10MB3896.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGRfEXmZxmzLnWEpsF7Q6U2ONSNt+9O6d2jA4FOLaSTFIrGNs1bAr44FaCqWM6eSpbkXWn1lsGK7TYHF34lsuxybcPD5dVau/nwErKDGLWQeBTmQdFyUxsM69DDjBhrgu3NJaj4p19yF9Hid6K3dL3un20SIU5Ks1AgIv2TXsauczugx3AYcWg4GeS5OeJ/6nUyy2CL9gxgDecUXTFms9EbpCPl+e6kUJRx1CYRgdGkIMRyhMRATutNqlU1EkmdcKtOXMvcONIJbD+iWlqyhmFQMg6+K61sWSdS73FVgFMglp/K+BKZDjVWeUETQq3gyEAfaOiyLPNeo/dlvBSvK3vzohBdecMZIUMaRYhZkjydvyajbIVylLpn2dqvutJb3ZwSKae/8aIKeuzFOYJPUfU6HpDBGwtvqksA299VtEZawYXClDfOFNw1noTl5xD9miS/W6hsmqoVXlsL/v7gnPRl+ps3AF9MzIMTKwpbc7y4N4PWO1L9KvGOAyilbI9qyP4JVGhzhUpoiLLRWEZiNgbFA0eEWNFUyDTneXJONzX8U7GzJc2WYLzTm47CvKy9P+cU8a4OzNOmAvWdGsSfTmvGsAppICC8Elo0sS3cSHLljvXl/ZdrFwptMLYS38Wph64F/SxO8LgPb4nlBPzeik6WZWh6YPIrK+hdKJGfylm5kofLZS7FjQGwHLhkAYJlCjwP+liCOshpVKpOkftFKxXthEKxDXxz0YHIwMb9q/Gs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(558084003)(508600001)(107886003)(2616005)(33656002)(53546011)(36756003)(71200400001)(6506007)(6486002)(316002)(6916009)(86362001)(44832011)(5660300002)(8936002)(76116006)(91956017)(122000001)(38100700002)(54906003)(186003)(6512007)(64756008)(4326008)(8676002)(2906002)(38070700005)(66556008)(66946007)(66476007)(66446008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U1RAj2jUyiVZ0Y5EsDbgW695f1zQWGqn2bPqxfUaZUjTOzvl29M7dj1DbK44?=
 =?us-ascii?Q?Z6OcFeQVbEdYyzXmTRhXvdobCm4vWOb+zwEUDseAwdlSK2AUIEjfjfldxkYl?=
 =?us-ascii?Q?9C+ZY0DzqdrQLQ9fvoEdU0p7m4gYvM0f9YZNd5e3lohyX9+JSn+G7NgCNcBt?=
 =?us-ascii?Q?EP3XFzAP3tCpgG3MW7nfyHpby2XkltM0SEj/rnCqhweKZzZ2K1ze3p0ZenGT?=
 =?us-ascii?Q?qqIOJG/Rzh7sSTJGOVnBxkTmXuwW0tZhtPztoJ6FluFKT93AbnyF23ddYgrC?=
 =?us-ascii?Q?gnzyYs8wC5o+fJ0HLR60ofgjZZDR56qY281yK/MWnwWtbflfUqd2qxBQGo5K?=
 =?us-ascii?Q?mW4bGucxayEOnpYYAD04+tmeim7ZHyK3gZiaJpXBctiz7U7gS1tyqXOKpMcQ?=
 =?us-ascii?Q?Jbg/6TzNzj4NDMrs9S/IdUw8dGahi7GVjmNSBzxV/iUcUrXTT3/EUdqmbjBN?=
 =?us-ascii?Q?QA6MqnuB7T7HW3I9UCMq5ark2YjpSN1RNfbno31tFFd8rN45U9B6Nr5wqmM9?=
 =?us-ascii?Q?0UZw+GtjMTmCx/Rn9ehqRYUiY1bqC7H1MTE6ZO2qqE9gZh7VJ1Sv6A0Wd6Ue?=
 =?us-ascii?Q?UFXyLbp6L0EJzhq/iSHE3JgxrLRNyLRMWypMIDyGfzczDeRaTlw3mmQdOAQP?=
 =?us-ascii?Q?zcovfoNxQ/bb5O59pDmodmTLRLpaFVIYP+hPmeov1KlEAUQuUhG2v9wQQsbG?=
 =?us-ascii?Q?TJ7VSd3wXIGT2C7xUNy7YwxGsjUfXnlO7PyG6FfgPu8/oWNcBU6ZL/y4/IMi?=
 =?us-ascii?Q?HaptxVZZvwKetVgz3aJZad1YDmFmJBoacE41AlgzZC03NjY5Qc2C+JNueqWR?=
 =?us-ascii?Q?4/NDAphty4vt0+yeLyGDFm9O5JGhaYF+XdlZ3hOZejZypTrpCMtshJGzyfWU?=
 =?us-ascii?Q?bruOumR9Z9cjMNYhyPpHPADgAwaMCLqXyCeTvXpQwekvFbDjBJkM2gMqM+t+?=
 =?us-ascii?Q?oMXgZ/UtEqC5ao87HbgByfIx/W5xmFTHGIfsJk0j40Q2qbRBe2ce9u8ZgiIM?=
 =?us-ascii?Q?+TOVLAq2BmOYdVThpF8cOrmRYViNkLTTz6/qGOLQQ9NHxPummIx9XLaHmREn?=
 =?us-ascii?Q?ZKL1LHPF5Kra98nJWOIzhdkm2R/MhKqNFLE6Ctf+CSgNJBNEaH/c5tjcEq/o?=
 =?us-ascii?Q?Zy4xktV3K2nTTbbKfXdsVup8lMVd2ERpOALFffSLC7jBVJvsX+LaYxRQ3vrS?=
 =?us-ascii?Q?K3zPaf0xZbvrRzAEmcWIApYGuxdCUdsnYJmJgwiGkidQuizQgfHaT6LbzFt/?=
 =?us-ascii?Q?ElNUXv6unGgxwPz+xhJ97fvusZuIIbZb3GE4tVoZpUGcxqQ0855h0uMYO5CP?=
 =?us-ascii?Q?F7ho/jUc/do4o8J3kgqhbxRymzZl4XCAt0AV+4g+fSwV2uT5UhfiHJ7GjjZW?=
 =?us-ascii?Q?sTQFs5Hxdl7JO4B5Yt2z+4d0heUCo5BHPN+btNLFVsmof+0AM4l572GyEhEt?=
 =?us-ascii?Q?Y2/jE36WSDnuBnjIJcNsD32S/GWXSdUus0wiQBY1Z+Tl2xSweUNPpL5zrw3B?=
 =?us-ascii?Q?RVsrwdQmGuNsSeFWe6CPfOcgU3AN2r7GDgihWDIxiO8+1rTdmn3MIsr9dDIj?=
 =?us-ascii?Q?XDdxz/FbOY5QpTff0qMmk/HAmyLIjUv5z7bTF3y8uDRZAU6wCn5Q/aNv1mGR?=
 =?us-ascii?Q?SPegwWhqzMVk4YAmFR5s20IivJL20/2n5WyD/mTk1svtoT+ZTtZLYAJ5FPkJ?=
 =?us-ascii?Q?lfDkDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <397C60C115798D41B006A1FB50F8126D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b27ad9-4016-48bb-5156-08d9ed847d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 17:32:33.9157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vf9MXaaEm7LifrDZdxhhtdsVSwFdLiRIj+T6cyW4fyvt4DPcgDIGfptKqSSNRdWCok0fGSEvWIbnYf3TM7Q2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3896
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255
 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=847
 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110093
X-Proofpoint-GUID: 9SsRx3Ou1osFejGuDBPgJwHRMPzOrTLr
X-Proofpoint-ORIG-GUID: 9SsRx3Ou1osFejGuDBPgJwHRMPzOrTLr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_093245_711619_222A9443 
X-CRM114-Status: GOOD (  15.68  )
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

Yes it does.


> On Feb 8, 2022, at 11:51 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Alan, does this good for your with the author line fixed up?


