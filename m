Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5571FC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 13:35:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1C1611C6
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 13:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F1C1611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=onwIP38pEcdnv36Me4VugyuEvg7e2GcEwyMRWKUmRFM=; b=hhfQREYz4w/xbWdRFDfnC/ZC49
	78tXDj+rCJ+LWklqtMyn6PdlJ/E2PAc1nyKs/AStfa9su6g9zMDbVyiyv8ajF+/yWT4l7GJTdCuzq
	e9F91TEQcheQ5hcOkYo+vuDfDSKKDZxfLdQZpUyKy4S79ySF1bcJJmk7YXu2p9lnJS6Fjlhny/u+w
	npfBIjy0BXnXTNo26tWC/sXS+ZuC07hZRqi7Xsq89g8tI6u8V3noBBHTqH4LbtynwNhU8fqcvXDsg
	gkxkxF3ukaGZ8s1JUaQv47rvP5kch2PcSQXS87YkubWPDCxTRerPjglnLOIq/A9DzZa3y4/5rcbD/
	LiBVDc8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdBkU-004cuw-P6; Wed, 20 Oct 2021 13:35:18 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdBkK-004cra-Et
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 13:35:10 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KDJC6W008159; 
 Wed, 20 Oct 2021 13:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=onwIP38pEcdnv36Me4VugyuEvg7e2GcEwyMRWKUmRFM=;
 b=jyYpuvUk1vlrWDS7kuJmJDYx+bxq3viBSQXVTxCRG4vZgfq/2qMod86BBlIQVglXUhlG
 zE5LUaIUra0r1/Dbr/Cal+i7vM7u5Rf+0IG85X/mz3Fr4B/HMGQ4y3cd6UU0xdNhsU+K
 NMCR/vLRifZmijWKp4jXgDjuK/N4ZCJHvHSG9O1Otn5HkA4XZm4ur9KCLhJlPxmAnM6H
 arBy/bZnwQPq4gz6A199K1mOsvN2AiWNPMa78Tgv982h27OTWcFfRukHGR9eRK9OMo32
 8xjB5CmBbFz31cUtLTkKySMNzY1pH+/ylWbODuGH3YKb4bxyFiYs0U4eP9bROpqncCPM 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bsrefh5b0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 13:35:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KDLZoP081943;
 Wed, 20 Oct 2021 13:34:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by userp3020.oracle.com with ESMTP id 3br8gu5efy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 13:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmHrfILm6YuD+EoEbrn4Q7N0/52lIo6sgUw0sK4lliPKT/CuoADdNrzsrVMxvX6WGq8uH3bT589Pv8EggPhqhhNK79dVxth0Ye8zhZVb/D7x3t05u77GcHLQSFQZRRAz8a1oedi16dHfvuuP1c0mQTPwOy4SNd7TJEs5ox3OPpmDW1oKfKujfJs4gCHI3C7dHm4OYWq3yUWge8g9F6vlI1+2hWM+vwp1+VijkvLTxKAyeyhAJWZPJH7p+rfhNCCq4uN5PKqRCWLp9b+Jz81bwy+lkjAfHfKd1KCkMYpzGhKx6axHSzN6HJJx9gzPmNciHnIe2sHDKX92TEMwEqmXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onwIP38pEcdnv36Me4VugyuEvg7e2GcEwyMRWKUmRFM=;
 b=gcKfHIO/66FwkdI729kSymi4BZsWlXzOG6j6HIiY6EeqMS/yosJ7ScAa2Go5eacuOmcKgRi2ZDKNLwJGePjKM/3j9WGCYEvWnGDdNOVQqG2Hycw34pIMFwD9pCni1r8yt8BEd+3938VjhtYJDrfYN+NLLWeXJR6glFAcyrhIRZ+mPXWD17gBbiJxX5DgMC/Noa/v5AnuQgtEghoRfhZ0XO2ldaO61muMv4QA0asxU9770LxVG78DmGrg8MQKl0IeVRU47V50MYoS5Kv08k2D9X9IlP3aWOycuKyaFbWXyXMPfMSQ5Ls1L/bNB1qM5yKlY/tOyNa/m8BSFAyQRQY5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onwIP38pEcdnv36Me4VugyuEvg7e2GcEwyMRWKUmRFM=;
 b=OpL7N4g3aieik+aK+0IpQzEeyP8LA14TgiX4PZZaX2VaReN7rJ/Xo8rUsihS5WqMgJUlxP0sZkLh1SH7aIXnhl3QdzRAilakD18MTvy+J31pUnnv235k2/wTPfc1PYgeshBe0+QZ9c7JFw95DGuRiDV8sWiQGlS1J/liDYhdpRs=
Received: from BYAPR10MB2934.namprd10.prod.outlook.com (2603:10b6:a03:85::22)
 by BYAPR10MB2533.namprd10.prod.outlook.com (2603:10b6:a02:b4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 13:34:17 +0000
Received: from BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::1f5:12bf:3985:e2b6]) by BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::1f5:12bf:3985:e2b6%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 13:34:17 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "chaitanyak@nvidia.com"
 <chaitanyak@nvidia.com>, "israelr@nvidia.com" <israelr@nvidia.com>,
 "oren@nvidia.com" <oren@nvidia.com>, "jsmart2021@gmail.com"
 <jsmart2021@gmail.com>
Subject: Re: [PATCH 2/7] nvme-fabrics: introduce nvmf_reconnect_or_remove API
Thread-Topic: [PATCH 2/7] nvme-fabrics: introduce nvmf_reconnect_or_remove API
Thread-Index: AQHXxCgBuEdn+G9XbUeHnBEuZGGWiKvb5goA
Date: Wed, 20 Oct 2021 13:34:16 +0000
Message-ID: <AB847671-032B-4C54-A17A-52B0B9D74360@oracle.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-3-mgurtovoy@nvidia.com>
In-Reply-To: <20211018134020.33838-3-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd3f3b39-f452-44b5-018f-08d993ce507d
x-ms-traffictypediagnostic: BYAPR10MB2533:
x-microsoft-antispam-prvs: <BYAPR10MB253343C64F4CAE66BA950B17E6BE9@BYAPR10MB2533.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5AdnHe71zCpwGr2N2wSl5fz0vJuUlvAXfzUNs6YI8M5v4ms9t6+9xffu9qn1AnhAfm4lOL01sxWSkUA9YNYQTFq1K2GCByxOfjyrXNMdV2aTaQ0BnQgv8ZY21gCJQMqqQvlxZ/OT7HpluBQbfTbBwjrRagy7vmbJv99KZKzo1cBL1238Hv6QoZJ6lKOI0sD+7mD15rP7QxJIeErp3CFMmctzvBtwCCzqcpr3aWDEINiOfYbkYTPeWwgg35tQv2/Qk87zENdlrU3jDkr0Cgy90dK5YDWOrxYxWxns8KN3VAMVDqHtIi2ZZ5xc7Ik3SzR9uk2j9kn0NOwqSbkrfRnjqvLS92qB+a7HmMzlhA7xze/EtSJXanoc/cUyjDhUXOyRZS6fxoQ2icFkL7PjxI333SRxkqADz9jGWjY/gFIIPYuRodRkPDSM9SdLRD1Ziw5piwz+NYMw+FU3WIJ3qTenfF2D2DNFwjsoHT8WM6o2SFnDx1Y26ERZtIEZMyi/zDBUaddyMqyZ2SPMbYMBNe4aOdBzJou9Y2FFjLV4rAiNoSsmBhNfjeORFcv6JvmItagurVcMDPNpA1USQjOcS+RQeQ0nlU0tAAPp23smoxz9yu2bqhqNwr7mBQUwsNV4FvVqs5culzZoh+1nct0sA5omVlC3dwFsZwzLfcdoIrRIpRuueHemWXZcNaNBn9DctHeagVhnwa9PFwd5g9+tSKRGCFGxAH2u+XkJ1fPPzIjE0Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2934.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(33656002)(26005)(66446008)(186003)(6506007)(53546011)(6512007)(64756008)(2906002)(38070700005)(66946007)(508600001)(76116006)(4326008)(6486002)(86362001)(66476007)(66556008)(2616005)(36756003)(91956017)(38100700002)(71200400001)(5660300002)(316002)(54906003)(122000001)(8936002)(8676002)(6916009)(44832011)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OqP0MyXs0n/ZZ0ejyqoAzTzuog9sNJVOpJ99/dRHN4XFBXL9gWrfpd2tOCJy?=
 =?us-ascii?Q?LM/OgCp38qmncEzeZgl1idVPJUFgDIdNCRcQdirDrn8T/J4FQ5SalkqQSgFD?=
 =?us-ascii?Q?iwzF+4fa5ckN17msxkRZE3wTs7ozMYb8/YX5L3IQsmULfiWUc6IDFMZssaDl?=
 =?us-ascii?Q?tFWnxgGhtvt49QC9HL+r4cKIDjwC0kJTE+OUiRQsho04DEPWUcglai/iGwbT?=
 =?us-ascii?Q?+pTBRh+sZuOsmkaSbbYGr2+s4U++ceYDVBhHed56fpwun+WcNJAFO46YwFwN?=
 =?us-ascii?Q?AXuujfNjlibI2mwvBFTYrfx/xlCP5lNrWjvjo4p5U3EwACURxQ8pa271zlik?=
 =?us-ascii?Q?6czcN+9EZ7vBVZMqdFxbaXZshJv8jI1lGdCcmvlLUVzsPIL/+SAIOFemmq/f?=
 =?us-ascii?Q?ilRvtVy0qbuw8pFT4mCb6TWsnx1LehflNX8pzwr9Ogy+CuqR67NRQFrjqiEp?=
 =?us-ascii?Q?YiL0sowMy14LCu+zUerurHqgZXZ/Np6xXwvaCkoG5Xru3QePAnXKFXmhMMEx?=
 =?us-ascii?Q?DVhCrdaokgX1S8ksyhKi/7Rg08sYuBs/1bRiOF19DuLkJ3D0/zfTrFx42VaR?=
 =?us-ascii?Q?gHM8bxdtc7lcC6NkqamDxEYybVkRbIEOlwcBC5WHh//OWhGOHnbXUDnB210P?=
 =?us-ascii?Q?hUwCsvRkHk5k0kAseLNVQrHJi7aa6wjdJUuUV2Ubqk8OiIs0CwFkm80ZU9vp?=
 =?us-ascii?Q?hebnqbspawJXGa7KVR1WOXirBmBXHLBOB9oBcOdYwKj+M1Scj6VG/l+IZv9J?=
 =?us-ascii?Q?iQ+YI/NIiAPDoQPSZVYE8vcektXEZkRp/1IHnrB9EaSzJDDgpyH5T7i1vnut?=
 =?us-ascii?Q?myx01VHrd00N0Uz7Hba/J3Ikb4ES2VqFlqXZwvNSq4mOABfkPC8kiCe/cXc2?=
 =?us-ascii?Q?LeiVuB/RcRlEMp42XThDG6P0orzPExltdKUgFGb8xq6hcQBqYi9wgHUXspyz?=
 =?us-ascii?Q?23QGuIegrvTyDgkWuwqE1JZzPc7nQtoRfwovUVNHx1jmwaaht3in6kw4BqKH?=
 =?us-ascii?Q?6qGQ67nUJo2e4BTlgnDSI38w0Lr8Oho0ufkRyMR/9frOA8d5NVG7IHf9++mM?=
 =?us-ascii?Q?Z6BDo5rsDpPWG3Uv8hhlafEKIkv8EVpMk7bS0XNi8Nknvf+2O3VINSLqizcg?=
 =?us-ascii?Q?qBDTnzKFdhbZ1+zGKf4MzVNCYDwehk7Ctnv/I1p6f6G+EiHsuTPW76nFLyFQ?=
 =?us-ascii?Q?O+x0k3DV8ejpj+7PAowzQHUH0zHMzs5cYyPiBkr0nZa7Wu11LnKaX8gV8SdC?=
 =?us-ascii?Q?Sgk6drcXBcnfGfKCeyDbKQAQaM6ZzIT6bFCFnh6Nkv5WvCK9uzl/Yy594Dw/?=
 =?us-ascii?Q?diKfy/Veb+Yd3K+SWbRy7p/er183LQREjdbWlNe81DT+puH/zjOhSalsVyy0?=
 =?us-ascii?Q?8JhPB31Y7mO7H236H4dNKmlmLu0JFGtn1DE5tSx/pGPqo39v6Jd2yTWDaiXe?=
 =?us-ascii?Q?wJqCuKP/FbneLuZo6utQXsiujJLzmip8XQ0L6St7gOoaXY6HDmrSsEbuOYao?=
 =?us-ascii?Q?lW0VGx2ONitwvhtE6qSXs4sJd5cuX36hEKCyYSry7aJqMmQ3vF7t3QOlMizm?=
 =?us-ascii?Q?VoCtV0g+UMQ60taI6hs6PggKIYlDs8r25AiGvdooCN3bp6nNDiYoBiQmzLNu?=
 =?us-ascii?Q?78hB5RHME149BXec8Zm3ZIGYiNCIO4J4lsxeDYTfdGRAcQ23M5s52wGsvqfJ?=
 =?us-ascii?Q?PcRUHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A129A85474D5FF48A79BDC9B558B8CBE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2934.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3f3b39-f452-44b5-018f-08d993ce507d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 13:34:16.6664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmbHRyC2zOj7IkNjwkUqpvMmLFvjA8CnNnqfBC8+8vJvx9uu9O4WTpvgMX5fzI23hriEAJBcv3gZvvKw5rfKvtlZoZqjp+a7EdfKyuIdTr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2533
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200078
X-Proofpoint-GUID: 2DxqGB53sRkgRW1kg7GASiNdAYoj5Agk
X-Proofpoint-ORIG-GUID: 2DxqGB53sRkgRW1kg7GASiNdAYoj5Agk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_063508_680435_815047BB 
X-CRM114-Status: GOOD (  27.84  )
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



> On Oct 18, 2021, at 8:40 AM, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>=20
> This logic is duplicated today for RDMA and TCP controllers. Move it to
> the fabrics driver and export it as a new API.
>=20
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
>=20
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> drivers/nvme/host/fabrics.c | 21 +++++++++++++++++++++
> drivers/nvme/host/fabrics.h |  1 +
> drivers/nvme/host/rdma.c    | 25 +++----------------------
> drivers/nvme/host/tcp.c     | 26 +++-----------------------
> 4 files changed, 28 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 668c6bb7a567..4a1ef67c6fb3 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -472,6 +472,27 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
> }
> EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
>=20
> +void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
> +{
> +	/* If we are resetting/deleting then do nothing */
> +	if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
> +		WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
> +			ctrl->state =3D=3D NVME_CTRL_LIVE);
> +		return;
> +	}
> +
> +	if (nvmf_should_reconnect(ctrl)) {
> +		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
> +			ctrl->opts->reconnect_delay);
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work,
> +				ctrl->opts->reconnect_delay * HZ);
> +	} else {
> +		dev_info(ctrl->device, "Removing controller...\n");
> +		nvme_delete_ctrl(ctrl);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
> +
> /**
>  * nvmf_register_transport() - NVMe Fabrics Library registration function=
.
>  * @ops:	Transport ops instance to be registered to the
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a146cb903869..de213ab26977 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -188,6 +188,7 @@ void nvmf_unregister_transport(struct nvmf_transport_=
ops *ops);
> void nvmf_free_options(struct nvmf_ctrl_options *opts);
> int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
> bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
> +void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
> bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
> 		struct nvmf_ctrl_options *opts);
>=20
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index fbfa18a47bd8..f31a56d8fd73 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1064,25 +1064,6 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *=
nctrl)
> 	kfree(ctrl);
> }
>=20
> -static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
> -{
> -	/* If we are resetting/deleting then do nothing */
> -	if (ctrl->ctrl.state !=3D NVME_CTRL_CONNECTING) {
> -		WARN_ON_ONCE(ctrl->ctrl.state =3D=3D NVME_CTRL_NEW ||
> -			ctrl->ctrl.state =3D=3D NVME_CTRL_LIVE);
> -		return;
> -	}
> -
> -	if (nvmf_should_reconnect(&ctrl->ctrl)) {
> -		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
> -			ctrl->ctrl.opts->reconnect_delay);
> -		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
> -				ctrl->ctrl.opts->reconnect_delay * HZ);
> -	} else {
> -		nvme_delete_ctrl(&ctrl->ctrl);
> -	}
> -}
> -
> static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
> {
> 	int ret;
> @@ -1181,7 +1162,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct wo=
rk_struct *work)
> requeue:
> 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
> 			ctrl->ctrl.nr_reconnects);
> -	nvme_rdma_reconnect_or_remove(ctrl);
> +	nvmf_reconnect_or_remove(&ctrl->ctrl);
> }
>=20
> static void nvme_rdma_error_recovery_work(struct work_struct *work)
> @@ -1202,7 +1183,7 @@ static void nvme_rdma_error_recovery_work(struct wo=
rk_struct *work)
> 		return;
> 	}
>=20
> -	nvme_rdma_reconnect_or_remove(ctrl);
> +	nvmf_reconnect_or_remove(&ctrl->ctrl);
> }
>=20
> static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
> @@ -2265,7 +2246,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_s=
truct *work)
>=20
> out_fail:
> 	++ctrl->ctrl.nr_reconnects;
> -	nvme_rdma_reconnect_or_remove(ctrl);
> +	nvmf_reconnect_or_remove(&ctrl->ctrl);
> }
>=20
> static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops =3D {
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3ace20e39c86..530ff76d4ac9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1970,26 +1970,6 @@ static void nvme_tcp_teardown_io_queues(struct nvm=
e_ctrl *ctrl,
> 	nvme_tcp_destroy_io_queues(ctrl, remove);
> }
>=20
> -static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> -{
> -	/* If we are resetting/deleting then do nothing */
> -	if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
> -		WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
> -			ctrl->state =3D=3D NVME_CTRL_LIVE);
> -		return;
> -	}
> -
> -	if (nvmf_should_reconnect(ctrl)) {
> -		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
> -			ctrl->opts->reconnect_delay);
> -		queue_delayed_work(nvme_wq, &ctrl->connect_work,
> -				ctrl->opts->reconnect_delay * HZ);
> -	} else {
> -		dev_info(ctrl->device, "Removing controller...\n");
> -		nvme_delete_ctrl(ctrl);
> -	}
> -}
> -
> static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
> {
> 	struct nvmf_ctrl_options *opts =3D ctrl->opts;
> @@ -2083,7 +2063,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct wor=
k_struct *work)
> requeue:
> 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
> 			ctrl->nr_reconnects);
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvmf_reconnect_or_remove(ctrl);
> }
>=20
> static void nvme_tcp_error_recovery_work(struct work_struct *work)
> @@ -2106,7 +2086,7 @@ static void nvme_tcp_error_recovery_work(struct wor=
k_struct *work)
> 		return;
> 	}
>=20
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvmf_reconnect_or_remove(ctrl);
> }
>=20
> static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
> @@ -2150,7 +2130,7 @@ static void nvme_reset_ctrl_work(struct work_struct=
 *work)
>=20
> out_fail:
> 	++ctrl->nr_reconnects;
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvmf_reconnect_or_remove(ctrl);
> }
>=20
> static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
> --=20
> 2.18.1
>=20
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


