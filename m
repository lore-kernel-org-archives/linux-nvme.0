Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55151C38A02
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 21:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L3+W8PkzUB/ceF0S/Afoyu0CESoI2PB3xmlrB98frtg=; b=he8wl2XquF1l4Y51IK7ntB57Ln
	Ii1alWkSq6rbSHHT4yxFqCovG4558mV8Ay4TtenI7dSQmjKOFsRxwUm5sFgS90xLRTGpmkVwBVlKp
	c+RuDrlWJe9WjPFQ3wNvx1o+fxBvgIIkGQ6JDfbrX9HAV4QmkoR6waxVquzlPjaNyT3iI2GW+h5kM
	h8FASTPCQrlfuMdpMIeRCMGM84RWpmiMIMh+J0siip4pAeWd+Z8Q+QJ/vGarl2VzD/KS22FA5NTs2
	4a0D3jZEJkB76CViQz/xGCCkf3BMAKm8Z7RiA2g/R1i7OfLRGX/uhAj5Eddz0rCpOfnGR9OzuEhh8
	SjA9sGPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooWVW-002JaY-BC; Fri, 28 Oct 2022 21:03:14 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooWVT-002JZp-3b
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 21:03:13 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKxQb8013287;
	Fri, 28 Oct 2022 21:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=L3+W8PkzUB/ceF0S/Afoyu0CESoI2PB3xmlrB98frtg=;
 b=laISljeCKmqKX1rqze/7kEcl2SeZAf6wqd6mpex2LhKDP8pZGWadWIl1k482d2cK1RoM
 9hDnKzHOLFncsCiHQMqxgegMtbelmKn3VAFBM5FKtLqafjSYHQtoZw6mRF1LOeNpt84j
 Hh05mWZDYTDaKIHJ9v8efzcbla9mVkesYJ48EEzQPlctxOd9GXH3gazDg1mqh0tLSq6d
 Nid4HCt5WL3MxGrQ7R+j+H5g0GfTVtKI63iFU4KLswzxBLJuPTZEm5Wzhn1Jqugu9AcR
 sMUdS+T0KCn48aaWzYM6wBKoSF72n6hYPzeCCjHR5/y4Nfq0cRvafKrGSK0Y7ZMEMg25 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgmsd8a2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Oct 2022 21:02:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKeGpa033241;
	Fri, 28 Oct 2022 21:02:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagpfpvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Oct 2022 21:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFblrGavlu/U5CuIX4fcXEDZRGuPr2yVZJt5ln1sdNo4qVrLacfx7ekAbq6RLZtfMXXgbTrlbQjB8efb3w3PFIdBms6083kzrWCFqh+5N3NMAwW6E+6T3KrTjVD06tpzWu5TJWrzaN3lCKHuZl0+RSNPeqLu48hqCIHjXaDVmn7WW9GXmzJzD+4PjijCmZXhO58f5PO7JZRx1LO8K+wR0bZEoJxP2NfSIf4nQZ9ciOGQIE20W4iCCA2Exk5IPEvtkOHD48Y5qin9WFT7ZriGCAT6ijyDj80ZZg1ONNy6iuAG4Ax0ujw6HEE7J8kX/pvj78NyLDsutskTUPb2rClT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3+W8PkzUB/ceF0S/Afoyu0CESoI2PB3xmlrB98frtg=;
 b=Ag6gZFHSXY3V6fRuroCWf7jszpfSMp/aGRwmzwvzg2uJDz3gbUVlzRUh+gytiup7nOBiDKg3T3oE/zgyAfx6JjS22CIESt0QOhGXURwO+TexQVohwQzKlQnOoPouZnbzpTpaGHuey9cYxTAs73sZvf/PVveoDsDph+FldayVqY1w5WuJPVKhpBsy8CqO7/kV9fruyNzccKRNUCpUKzhfP7u8TGkPtYgAytpi7FNuM+WLotnJ0PJMchO5bspic/oSG/exKIpnpKM/Tee190Ye7bXHSkQeU5e6yTUf1SQb0xAXPLSKrKTp0h3yqFLQY0S+wjBu/rn2uV+ZErPa6xyG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3+W8PkzUB/ceF0S/Afoyu0CESoI2PB3xmlrB98frtg=;
 b=W8d24qMHOVBerCC5FvXJC2eUZxo9HQrouck/cw0mWF32U/WfUDTvXL98iKEWgt+Zxv9LHgSD7+khtWSAK68QJkFQU4zUVKS0Fc7iPifaWrW+UX5RWgMuib1UwHD082eJPJ9JYh/u7/UpSKq/EMbQM8j0eTT+c7gpdzwOPslDCb4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SA1PR10MB5688.namprd10.prod.outlook.com (2603:10b6:806:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 21:02:49 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::8896:7475:58a:7003]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::8896:7475:58a:7003%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 21:02:49 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Keith Busch
	<kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
        Kanchan Joshi
	<joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: Re: [PATCH-v3] nvme: quiet user passthrough command errors
Thread-Topic: [PATCH-v3] nvme: quiet user passthrough command errors
Thread-Index: AQHY6wnl8Qn4NTSaZkqpII65IoXFj64kSy+A
Date: Fri, 28 Oct 2022 21:02:48 +0000
Message-ID: <0C219A29-6740-42DB-A92A-F82D4FEB9095@oracle.com>
References: <20221028201415.3487291-1-kbusch@meta.com>
In-Reply-To: <20221028201415.3487291-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5550:EE_|SA1PR10MB5688:EE_
x-ms-office365-filtering-correlation-id: 35c4db7b-3d90-40a2-be34-08dab927c543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  0J2GqNJSnAcr6encwJmzOOzcwOtRhpEimaGLBJyF31iQ0N+KTcFAB8IReylcsiKM9qDUZaC//kMSYebLMH1O/ABqQ74u00zi/f1xYT6gYR8IAjUhNtwI3+o6pGx9qCT3jodhc38gquQKf7NutPR6Af1XLmVN/7WaJjyDQzKJVamIpGMmgro4sf7/9rlA01i3lHI36qQyjkW0/vwod3GEKiPBJwp0a0qx4S/EtnlqfXpUNs1DERElmOWIayfomncH2hSioF0fQMVfTb3qNf9eXJZsFdm5tZ0h8TVqtMAls7GPkJH3ha59ZGbJYsNapk66Gd19ICzr5pUaVJQxIH5BWy4xOAkLcYRkkoIaU2sSMOIvi5aqVVCARW/9tLYSo6eky1CxuLN8SE0Wkzxp8SCWP+nhqm4BpG34b4IGrToU11Sz+Hn+5n/1lpA32eV5g9+8a+liPXm32ik3BRu0ujMxLg2ZIGTIy5lQ0+15KCAN/VIoQas1bFvqkn+UV8xxTlrC/m7wnzHqORt7v1lShLOn71FRunkSmD3kL6RB42gCm7l+T5sJ/ECPxEaTQLMsC1BZ3pSrbFhGP6OU9WduGcOxczZEgz0NiwiUt9mGbST5FzxYr2gqEIS2BCpsdoNvdi/NCBJSNP9W9OG2vGB3eXYhE3EWEOL3XeQlmgMT8CD104lk7J4fHnlRv+MNfU7MnPCj2649rxOL/ZjTeigjdM/pO/qpgVD/gHBpc+9p+H7AWFCb0xIr7TCWzuuPdbhPW2Vd8olqo9nmfR5hgyU1/u1hXsyEBWO3jio2BoKVQgBe2BXA0XVnjgjou1K3xSyGuMhF0NjuZGZqBQPcvdRyIo5Ra1+k+/jPq9d2wl9F7OOIoOg=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(6916009)(186003)(44832011)(33656002)(8676002)(4326008)(66476007)(86362001)(76116006)(83380400001)(53546011)(8936002)(6512007)(316002)(36756003)(54906003)(66556008)(66946007)(71200400001)(2906002)(66446008)(64756008)(38100700002)(41300700001)(478600001)(6486002)(38070700005)(2616005)(122000001)(5660300002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?i7sIXwc94to2VG+dowTpPzGFyCZGn6TWR/svhnXp8VYHvZM9Nz0b9jkIwLtc?=
 =?us-ascii?Q?jya1g60SeVEv+P06jJX/Enj4Qudw5G3JpzHr6RnP2f8NAO5nI1xLNwxxDBql?=
 =?us-ascii?Q?+BgUdHgKsgtywi/4y3J7J5jb89bq6AeZ471g4LHE73YczS8/H3l/bUPGbjTW?=
 =?us-ascii?Q?5SXLTY/6qqx2/XkWVQdl3n3RUfY2cfF6DPYa6PLORAQUoWsh0vrmmlYHErvg?=
 =?us-ascii?Q?15hAI7VPVDLPF++Qi1MoyQcibpuX4OSS9TBiU/tzz2QbfcvA3g7wp5LnklG5?=
 =?us-ascii?Q?IPnZMU+hIRM1nWIlwArjjtn8WpFK7H5BYmSfl56kFWqWFUqqmKbKgsHBHLZQ?=
 =?us-ascii?Q?ZM0KSPqpinVJ8NxqHuKhaAHCvyxl68UXaycd3NhtjLXLruceGVdddM6ycInF?=
 =?us-ascii?Q?6Bm+xszEh3N+NN0V3yPJsnKGEhsIZmSgokeYGWddD8egHWyoFQ6ghOrlUTR8?=
 =?us-ascii?Q?poJa5iO80OajJYQE8YdhfDcqwD01/nS4zaJ7G4kBK6HVMZ5R6ZBD9DVdT0Zt?=
 =?us-ascii?Q?ugIHHHnfA0tTNWp/P1Rfyyv2eBlyYSuqru+aOSP+douHcSj6EfnfsS9gabjq?=
 =?us-ascii?Q?xCiSpNg+R9WKXwbaLX/3QVVivA412TRHn+Jt3G2MqmzH2w30tOXYobZb4VXz?=
 =?us-ascii?Q?qWB6+dl9N+MaXWjVkQP723TkNKsTJyP0nmpx1OCIP/0qvQXYycHczLQeGlsk?=
 =?us-ascii?Q?rPFmDXHvaFTYNSHbwL0y2EinZd46MjJ/Wo6nvEE3hyAs63MVMf5Xs6uf4Erc?=
 =?us-ascii?Q?K1aKcng1B/Cv89WNeYk8JR+VEexx4w8BsD3updFVgU1LIRQ4ampEusHQvhLA?=
 =?us-ascii?Q?r6VQDGKSCNhJMSCpfL1GbpmjLiomwfqRqZTTXgkOferThz5LqWzS5VCNAt7A?=
 =?us-ascii?Q?7xsNtuLUb7PH4JGHjdCDKuMK4+XxbUlcVQUycWD38JaGwm/sxbWc8+Oi0PFv?=
 =?us-ascii?Q?HX4ktnEdVOmKsYIbRwS1dU1BoNVi+9kSqlGINiGpJ2Bs1xkJMMaPtZtZkMo2?=
 =?us-ascii?Q?i2FCyza3mWH4fIltEMcTH8hCIyvjZrMuSQP4KDBHuGMR3rOaihdc/yd9ubdU?=
 =?us-ascii?Q?6WrYlrg9QRBIiHswdEBI+ztEP5a7c2fksOnN3OVGmz5jJ1v/zUTAWvZFY047?=
 =?us-ascii?Q?M5bYBQDZKgl7vKmpAJAeoMgFtAhVRxAYUnybFiQGzv5Dp9EtwND/GSIEeAkd?=
 =?us-ascii?Q?DdzPgtlzaRS4CXrPAxP3NT23yAt1DwqkcANUQi01bL+wKcIORlMe6g/ZYuCB?=
 =?us-ascii?Q?1O3CN/lrHxvbMJteIhQ1rJ8veQ7kyI1UVzO+6nRLFxYq/1nEVCvHsPDTgOpb?=
 =?us-ascii?Q?n5Y6KBUVDh1OHwZeDFKOv0pXSZY7fDgbsZQV4Ny9lHo1pVsnOuqiYaLEHjX6?=
 =?us-ascii?Q?yL781rd+0ApxHBdiOErX/7Ktg+BN3SX3ytlplRHAWZYcWErXc/eqiaML8ToP?=
 =?us-ascii?Q?ZY0HyYFKI5gCblPTfrh30xjslzDNL2l3TXxGDGFrPNrMqfIkIpNhM3yqe6lT?=
 =?us-ascii?Q?ppZwNyeIc/JJ7b7eT8IdF6QLHjjJPvWdQ9SCJ+ev7ydupvASHGTK0JxbHx1z?=
 =?us-ascii?Q?v7Le8MiAMHxRH1c3w22YCYqxZmj9j+KOS2QAQ2RK/XF3KeHZIODIks7QBAzV?=
 =?us-ascii?Q?uHL4fRFj6wI8NLLjWdI3+qUSQKpNKEuzWZ0/Oj2LwH2i?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3724F745C2BD14BB8C25BCE596F4183@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c4db7b-3d90-40a2-be34-08dab927c543
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 21:02:49.0135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boATZb4fAMpNMIIicVdjC2lK9QxFStNaHY1gfT6XwJpNeaZbTWdsSaQS09JM2e6RIgRVdRJm+nZdgebSoleadQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280132
X-Proofpoint-ORIG-GUID: fXlRULp54AH0uudPt9GiqyB7f1cD_NvP
X-Proofpoint-GUID: fXlRULp54AH0uudPt9GiqyB7f1cD_NvP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_140311_178724_C6E62A1B 
X-CRM114-Status: GOOD (  25.13  )
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



> On Oct 28, 2022, at 1:14 PM, Keith Busch <kbusch@meta.com> wrote:
>=20
> From: Keith Busch <kbusch@kernel.org>
>=20
> The driver is spamming the kernel logs for entirely harmless errors from
> user space submitting unsupported commands. Just silence the errors.
> The application has direct access to command status, so there's no need
> to log these.
>=20
> And since every passthrough command now uses the quiet flag, move the
> setting to the common initializer.
>=20
> Cc: Alan Adamson <alan.adamson@oracle.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2->v3:
>=20
>  Move the quiet to the passthrough-only init (Alan)
>=20
> drivers/nvme/host/core.c | 3 +--
> drivers/nvme/host/pci.c  | 2 --
> 2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 686c55cb5d1a..52ae0bdda65d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -675,6 +675,7 @@ void nvme_init_request(struct request *req, struct nv=
me_command *cmd)
> 	if (req->mq_hctx->type =3D=3D HCTX_TYPE_POLL)
> 		req->cmd_flags |=3D REQ_POLLED;
> 	nvme_clear_nvme_request(req);
> +	req->rq_flags |=3D RQF_QUIET;
> 	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
> }
> EXPORT_SYMBOL_GPL(nvme_init_request);
> @@ -1037,7 +1038,6 @@ int __nvme_submit_sync_cmd(struct request_queue *q,=
 struct nvme_command *cmd,
> 			goto out;
> 	}
>=20
> -	req->rq_flags |=3D RQF_QUIET;
> 	ret =3D nvme_execute_rq(req, at_head);
> 	if (result && ret >=3D 0)
> 		*result =3D nvme_req(req)->result;
> @@ -1226,7 +1226,6 @@ static void nvme_keep_alive_work(struct work_struct=
 *work)
> 	rq->timeout =3D ctrl->kato * HZ;
> 	rq->end_io =3D nvme_keep_alive_end_io;
> 	rq->end_io_data =3D ctrl;
> -	rq->rq_flags |=3D RQF_QUIET;
> 	blk_execute_rq_nowait(rq, false);
> }
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 72b5c1addbff..8cd92283cbfc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1436,7 +1436,6 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
>=20
> 	abort_req->end_io =3D abort_endio;
> 	abort_req->end_io_data =3D NULL;
> -	abort_req->rq_flags |=3D RQF_QUIET;
> 	blk_execute_rq_nowait(abort_req, false);
>=20
> 	/*
> @@ -2485,7 +2484,6 @@ static int nvme_delete_queue(struct nvme_queue *nvm=
eq, u8 opcode)
> 	req->end_io_data =3D nvmeq;
>=20
> 	init_completion(&nvmeq->delete_done);
> -	req->rq_flags |=3D RQF_QUIET;
> 	blk_execute_rq_nowait(req, false);
> 	return 0;
> }
> --=20
> 2.30.2
>=20

Tested-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Alan Adamson <alan.adamson@oracle.com>

Alan=

