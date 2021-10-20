Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AE7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 13:34:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E4B61260
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 13:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3E4B61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n5u0W64IOsZOfIjQPHTUUwTx82g3rCSNP2kyQxJCpAo=; b=FHhB8xsJraq//DDQ6o2LLSwolw
	bs00xT/RFNiWS9QhtDxfDFmuX/vakOhf06ANgWWvW0dMBcO+YJy50aba9+NkV3atYDCEzMvqL/773
	nqxWxAXx2fRx6GKwK+38ID+AJDgTx0d8Mamkn6CKHRWWNXi5yGrhblKR1MMYitnxpEKkol6Ux0WmV
	h/a2zUk+tCOcLOjGi+XY6szPKOA5HOYWZcAp7a2mT2QWTZH+C6mUjitfuSq69Qthu+6TL4aO4yXr3
	MN6eNy11xc2xsspVsX0FIK8vdYDJfQe9oeSSubhkUCm/veRk1wcXbJ/Ac0rmKv9gcayYFhqB+YlGk
	G/rc4rng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdBju-004ciQ-Sv; Wed, 20 Oct 2021 13:34:42 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdBjr-004chQ-WB
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 13:34:41 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KDJBFS008145; 
 Wed, 20 Oct 2021 13:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=n5u0W64IOsZOfIjQPHTUUwTx82g3rCSNP2kyQxJCpAo=;
 b=g+A5cyAp5/TA8sJ22zkev1zevdkFaX5vokzTwPdcv7O6YVy1h6ROm3r1UxCJ5V2TyNa6
 e/4qGUo5/yo7cbpd12UQJa4R2QIa6U3RN/2aTld099gLISeRRjCcw3ugIF+2HX24ICyQ
 bLqhbOuvRyaBFNDdjy8vqdPHlPV7rHUsgPcMu2TfRwm2DRRIfNryvprlZqr4cgvICjHL
 agPETsL11sZf13kI8Gpb1sos/T1+lHUMb9/x30k0vrEfs1yIddALG1RNExcJwMWic7dc
 oCw8qSzHsHkKsNPl4kay3LKiaOD3CGWT+xC9MdaEk3hPhP76hnj/S/eM9t67oDcyor9T bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bsrefh5bv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 13:34:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KDLCjO142669;
 Wed, 20 Oct 2021 13:34:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by aserp3020.oracle.com with ESMTP id 3bqpj7301j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 13:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zwnz4qAIOGzJhVSpHvZWbKU92UuD5cwWFjvvwoVBB6o231jyo4TkgEfhtJywSDK2LiGK3nJnUx+kAnVUNBe+eGKtJHm154Lfe4QPURT4y5KGhU+ibBvpQaWsPSoWYKuxG4jLiUwy8+tYL+aSLVCpyC6WTzZqL40pT4vty1VCeAOE5skzmaJ1cE60xQuu5WDFrSkrDfjqo7kw/wXLUNx6OqhL4aNTK4F37Rd8Me0b6Gnc+0DaVgCCPcdzQ9i6vMrKBnsKSc2Km/vBnjrvqpiJrZWOCzbRVFulAsU22Kfmc6Rtq4flxGvM6RJzSn0SzbBxoE1wcJV3Jjp1SZKP7o7h3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5u0W64IOsZOfIjQPHTUUwTx82g3rCSNP2kyQxJCpAo=;
 b=btLHcWBdf29cF8yEYmT2WNjQX7haRRhxFOGdCTWZXrW2INgOBA4OwgdVU5AQaWcWmfv9gQRzTfTWYR/O8MU2/BnPbKhu5HYnQavnAePiZjZPA3Xrd3RGaFsxPJZIq9fAQZZpWeHYhJkP5Eg/pDJ0buME392L4XJAA+LtvVBwPkSZf19Cc5hkei6o16O6BsEBxPrDGeFOYuBJOKLSy0KZvOk4nsW4RBPNx7w0cOXziQHPgw/AH0OvPaXOjaHg1yN4FlDfbY4Rn1bJ7SspLlDztGdQ+4bu+XS0aGMOHrEfCyjjVhd+j45EmnHYBrvxVb7O8JgUaU5VD2h0QVB8tZHMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5u0W64IOsZOfIjQPHTUUwTx82g3rCSNP2kyQxJCpAo=;
 b=yz2de5zS3WzysFHL2e9/GcI6QAjYAPNSpnBI2+AT0C74q2Ufo5nUvzyYbUVfgXTPoN9gH7xjnaOLBhgGO1hWVmHgosT8Ls8tKs+ugyqex5mOcJwta9tnKbkR5KnfPVgI1uGuHFfQi3+TJO9mcMrSRASC9K2MdJknZs4NjdB6ltw=
Received: from BYAPR10MB2934.namprd10.prod.outlook.com (2603:10b6:a03:85::22)
 by BYAPR10MB2533.namprd10.prod.outlook.com (2603:10b6:a02:b4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 13:34:23 +0000
Received: from BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::1f5:12bf:3985:e2b6]) by BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::1f5:12bf:3985:e2b6%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 13:34:23 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "chaitanyak@nvidia.com"
 <chaitanyak@nvidia.com>, "israelr@nvidia.com" <israelr@nvidia.com>,
 "oren@nvidia.com" <oren@nvidia.com>, "jsmart2021@gmail.com"
 <jsmart2021@gmail.com>
Subject: Re: [PATCH 3/7] nvme: add err_work attribute to nvme ctrl
Thread-Topic: [PATCH 3/7] nvme: add err_work attribute to nvme ctrl
Thread-Index: AQHXxChCg7TvhwjB302eFHszQqJpcqvb5hEA
Date: Wed, 20 Oct 2021 13:34:22 +0000
Message-ID: <094D3089-4F3A-48DF-BC2D-56ACBC16EA16@oracle.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-4-mgurtovoy@nvidia.com>
In-Reply-To: <20211018134020.33838-4-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8848abb6-b343-4e52-32b0-08d993ce541e
x-ms-traffictypediagnostic: BYAPR10MB2533:
x-microsoft-antispam-prvs: <BYAPR10MB2533E6A481AB6F813FF69A55E6BE9@BYAPR10MB2533.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F1g5kfO5vG7tEP5lmXTa4M0sGmz8b1zDb+A5Uxn6rOYiHkuzfroUXNSDo60dQ3jUtGl5uZkzy8S27LlJvyo14U3998mgbe1Oat5finjAHLVGharfX26pej6296kYEfWpImHbP0QJcF7WYtot8m5QWE6EFh6OgBeDl1gazZU/Bo8iXUz3SUm60HjmRfUxSzQI4I+w3OwVuCchgbGaqagSs8ZIjneJ4SzR2MhLPtS5HYo6as5hnCakMAGqj3gP03mcdYdSGhrtNCtZ+/WWzMtWA94gDXKv6iSV0+wZwRCO2cegVCawVK6WOMy4Ek7+P1r1/X/03hm2WiHHpstGTkoM1Jt6XufG4slDyBIpFBWLDco4Okyd7xmag5tTbjKtH+uDgrW+GIazxdMhKzXiWpsw5jCgHoRYRgtx6cDaSRM8UMHGDNckYboCwENpcUNZ6CQ2SKogj8yLL7kktUzqvygBUdhct5Xr9xNgkVqDLLzN5/MoGGHUvueZmDdp0UdG9xDFestJ5j0O40vx/ipLRymOyESr82mkZYaTjiVgZgPQ5+CKcgFu2Xhi+pZQIGlQskuKmJMwq/7noMV8A3I9ClSipOyf4a9RSA5ODGGMDC7tkohYwsCHZIgANhVMZywxjJCYXADjmCDtkuylr6aC7B2YBy1FDrzDDir5249lOWr8xqCjzeP2NTrcHrWoeo+Nel8B/oRvKHT4/ga6jAYxc5MZr9S2rd2VL2k8psPzQMRUi9o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2934.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(33656002)(26005)(66446008)(186003)(6506007)(53546011)(6512007)(64756008)(2906002)(38070700005)(66946007)(508600001)(76116006)(4326008)(6486002)(86362001)(66476007)(66556008)(2616005)(36756003)(91956017)(38100700002)(71200400001)(5660300002)(316002)(54906003)(122000001)(8936002)(8676002)(6916009)(44832011)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a4whaCQJmyE75rd3G8hFG90O9UP/5cuGgBl+Bl1xPeXQFM7BR9GqDA67rLOK?=
 =?us-ascii?Q?aUKIGqmpCjdsFpt6QEu2U/Bpsmaxhb395/h5Bp79Nx4KG5hTWkVyMuVoNQqg?=
 =?us-ascii?Q?l9GsJJXcSAqP9Hci3EmVJsxYZB1JVnkH2K0GqRPEVf8nAne24FfwFZudGuTZ?=
 =?us-ascii?Q?+OJzGHotim5RK8NXN7Acula+/NIv7VxlMaT9vj9ovUmwxJBlo0aGILd4Y0Ud?=
 =?us-ascii?Q?Txpq9mrtTfBKbwtmb6pPxfSZ7Akqqkf5HYIkQfg9RL5nVzYvPPz0q8UZyiGy?=
 =?us-ascii?Q?LsYC+eLG5VY0X2FGm4Lx1G/+yGN/yf6Kw7v6X73gxBwAzldykBMWXBIkAorV?=
 =?us-ascii?Q?GRZX3AG1JLST7q4NRk2i+yYG1xtGVjHV3VuolZG7uwa374gKHXNJ5YSlVkOO?=
 =?us-ascii?Q?xfs2xoIIjdnCyV5IPbiGPDUba5B0z9WBVYe7YfN0AmDPEL5a4ms155QFJSSF?=
 =?us-ascii?Q?7IwTLq95UXyBk8coHe2Tl7jghHWFP+/ya4NhSjDKLX6hS7LB+AUEa2a73co0?=
 =?us-ascii?Q?zhgIPeeigr2Q6HSjMfb0pAsdIDtEs1CC2RGE1ZS72NEbhEcGVW3Xd44ky+c0?=
 =?us-ascii?Q?SWsGl4E2yMCvji/8AjNwendqbexzb4tn0AOOBXXDOemMap1BhTHnsJH8oIZt?=
 =?us-ascii?Q?Vs5AcLzUcZH2y8/+AhNf7a7IIIT2IXFvFq0/Fv6k6cBR19TRVT0dqYj461xj?=
 =?us-ascii?Q?/6QptyH36jVAKIBwXFyf4gnhHo7lPqBZ7Xax3pMGxMEyu8b6P9nhHl43+BVz?=
 =?us-ascii?Q?j1koHSk2YYZ3y1u1zRYeWyVvYjhl3nkHkfuLWOTzUI+S+Yuq3xv5BYASWRRt?=
 =?us-ascii?Q?3cp7chhS6biKc5muLWEzKoT3Z3KexPBFS96UmqfCE/56UvOgTAkM+nO+ERqb?=
 =?us-ascii?Q?aiK40TTnHq06klDHY6K/GrHruLeFTPJwzCjp/+oL958EsNG1nwZgQ7cT7N2z?=
 =?us-ascii?Q?E4Jkk06oVA2UXkvhUAdp27SM4tuUXpEbJ8s+hzCxx+5cudErCGtTr7Q1bM0s?=
 =?us-ascii?Q?qpmRwteGhVElKLNLhAhjKTZFJcFBDzZr6G9iZtt1myYMvL1Uw3ovjY8u9cAx?=
 =?us-ascii?Q?h6M3jl5RtNNKch8U39d6vCOQgzZVaQIu8wVzlika0loFEUNo+NoqVvfphQUN?=
 =?us-ascii?Q?34nTT6ENYwiUzFPo4aWkGXJNLCzUD9cLxvPBQihhupKXrlqyw+f5R5XfHuMk?=
 =?us-ascii?Q?XFyxYYXTpSA1QLKjsXkc+n/mQLummprrIM0rR8HLGJn5ea1v1A0PJOVZFhXG?=
 =?us-ascii?Q?orGHbJnqMMg0CWm8RIJXcFLMCErg6MovIV45fNFr0YCTbB26UaWrlwOuRoVc?=
 =?us-ascii?Q?Ku291+yz1YeJDCRITAUwHo8OZSeTJyU5+JYZfR6J7c25aK1V6tZGe9VTrdDX?=
 =?us-ascii?Q?Euitrdec4w/rVFEUaoJxDFLIsKxjE2Pw3fUl8N80TY8FSKR3lykERZgSsdIY?=
 =?us-ascii?Q?sQscnMRxp/4TgVp7Org3V6RCmJMSlTQO5cLGPCIQorRWzu6GV64qKZLkcDWS?=
 =?us-ascii?Q?UF90waDMXLoTS9DLWf61J694yRd8aPQ778UoC8vrAWcOCcPAv4Vsu6BOGUlh?=
 =?us-ascii?Q?v0TDqvcLyIj2hAwGrRCvtCKkZpQqJhUgwGvUTa5Sn/yo99Cl7YxcFH5dmccw?=
 =?us-ascii?Q?zmQMam70kzko3ky2in5vReWUFBtcMTeO6f+wSIhXqdHt/oCMgxxBWkxI2STE?=
 =?us-ascii?Q?lw1qPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CF83F0A9B42BD49B723E21FC14583D2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2934.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8848abb6-b343-4e52-32b0-08d993ce541e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 13:34:22.9499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5PD8hJUE0GzBhLLsTukTbZUU188FcT3OdzAqHaPKYnYqwax1VgmSVEyuT5vVGMT9Oa0lWuRt5HDaYnL12kRdgTzSIgezFwBZtsa+8Pqa2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2533
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200078
X-Proofpoint-GUID: 1e9wp0BSKk9L5imS5uS_yr1dDy-HWNid
X-Proofpoint-ORIG-GUID: 1e9wp0BSKk9L5imS5uS_yr1dDy-HWNid
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_063440_185337_E2306F89 
X-CRM114-Status: GOOD (  27.06  )
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
> This structure is duplicated for RDMA/TCP fabric controllers. Move it to
> common code.
>=20
> FC controllers might use this attribute in the future instead of a local
> ioerr_work attribute.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> drivers/nvme/host/nvme.h |  1 +
> drivers/nvme/host/rdma.c |  9 ++++-----
> drivers/nvme/host/tcp.c  | 12 +++++-------
> 3 files changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 81ca5dd9b7f9..f9e1ce93d61d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -344,6 +344,7 @@ struct nvme_ctrl {
> #define NVME_CTRL_FAILFAST_EXPIRED	0
> 	struct nvmf_ctrl_options *opts;
> 	struct delayed_work connect_work;
> +	struct work_struct err_work;
>=20
> 	struct page *discard_page;
> 	unsigned long discard_page_busy;
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f31a56d8fd73..da7f61a5fac4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -106,7 +106,6 @@ struct nvme_rdma_ctrl {
>=20
> 	/* other member variables */
> 	struct blk_mq_tag_set	tag_set;
> -	struct work_struct	err_work;
>=20
> 	struct nvme_rdma_qe	async_event_sqe;
>=20
> @@ -1168,7 +1167,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct wo=
rk_struct *work)
> static void nvme_rdma_error_recovery_work(struct work_struct *work)
> {
> 	struct nvme_rdma_ctrl *ctrl =3D container_of(work,
> -			struct nvme_rdma_ctrl, err_work);
> +			struct nvme_rdma_ctrl, ctrl.err_work);
>=20
> 	nvme_stop_keep_alive(&ctrl->ctrl);
> 	nvme_rdma_teardown_io_queues(ctrl, false);
> @@ -1192,7 +1191,7 @@ static void nvme_rdma_error_recovery(struct nvme_rd=
ma_ctrl *ctrl)
> 		return;
>=20
> 	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
> -	queue_work(nvme_reset_wq, &ctrl->err_work);
> +	queue_work(nvme_reset_wq, &ctrl->ctrl.err_work);
> }
>=20
> static void nvme_rdma_end_request(struct nvme_rdma_request *req)
> @@ -2208,7 +2207,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_o=
ps =3D {
>=20
> static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shu=
tdown)
> {
> -	cancel_work_sync(&ctrl->err_work);
> +	cancel_work_sync(&ctrl->ctrl.err_work);
> 	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
>=20
> 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
> @@ -2339,7 +2338,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(stru=
ct device *dev,
>=20
> 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
> 			nvme_rdma_reconnect_ctrl_work);
> -	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
> +	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
> 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
>=20
> 	ctrl->ctrl.queue_count =3D opts->nr_io_queues + opts->nr_write_queues +
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 530ff76d4ac9..07a9cc4f2274 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -126,7 +126,6 @@ struct nvme_tcp_ctrl {
> 	struct sockaddr_storage src_addr;
> 	struct nvme_ctrl	ctrl;
>=20
> -	struct work_struct	err_work;
> 	struct nvme_tcp_request async_req;
> 	u32			io_queues[HCTX_MAX_TYPES];
> };
> @@ -486,7 +485,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl =
*ctrl)
> 		return;
>=20
> 	dev_warn(ctrl->device, "starting error recovery\n");
> -	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
> +	queue_work(nvme_reset_wq, &ctrl->err_work);
> }
>=20
> static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
> @@ -2068,9 +2067,8 @@ static void nvme_tcp_reconnect_ctrl_work(struct wor=
k_struct *work)
>=20
> static void nvme_tcp_error_recovery_work(struct work_struct *work)
> {
> -	struct nvme_tcp_ctrl *tcp_ctrl =3D container_of(work,
> -				struct nvme_tcp_ctrl, err_work);
> -	struct nvme_ctrl *ctrl =3D &tcp_ctrl->ctrl;
> +	struct nvme_ctrl *ctrl =3D container_of(work,
> +				struct nvme_ctrl, err_work);
>=20
> 	nvme_stop_keep_alive(ctrl);
> 	nvme_tcp_teardown_io_queues(ctrl, false);
> @@ -2091,7 +2089,7 @@ static void nvme_tcp_error_recovery_work(struct wor=
k_struct *work)
>=20
> static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
> {
> -	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
> +	cancel_work_sync(&ctrl->err_work);
> 	cancel_delayed_work_sync(&ctrl->connect_work);
>=20
> 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
> @@ -2494,7 +2492,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struc=
t device *dev,
>=20
> 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
> 			nvme_tcp_reconnect_ctrl_work);
> -	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
> +	INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
> 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
>=20
> 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
> --=20
> 2.18.1
>=20
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


