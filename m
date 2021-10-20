Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 13:34:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1949611C6
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 13:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1949611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9INuua/jVtPQ7rT1RX48j0dhJyIwCRbGwBDzznusU5A=; b=aYQifAFekqyeZLI6e+rm4u+L90
	LVUuyYampaLu0ogRM7RcCP2Bi24hmnBorXFiPkiRSiwV/uyI69nJ+SoseFC87o2EUZgk8oCxQ1p32
	LZbRNonrK8TpG21w4ExK2+OziT+xVNDa9isJJIbTlvVgl42rOQOsodrc6kV/g2zZwpuM70RzSrvIe
	gRWm1uIbP+XjuPXgON/+Vn3MzSA9betK8cM06C+Gc5PFk/xUJKEHoySQ6CM9fP5LDpGTnJQuJAsLO
	+NRtTLWza1V4pq5q9xAgmwRtsvJ1Z3v0J+mublFU6liJ4jD6igLUgEBxsAA9l7pB72whwcekPvS8X
	pF93OOqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdBjd-004cdD-VZ; Wed, 20 Oct 2021 13:34:26 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdBja-004cb0-NQ
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 13:34:24 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KDJKfh028324; 
 Wed, 20 Oct 2021 13:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9INuua/jVtPQ7rT1RX48j0dhJyIwCRbGwBDzznusU5A=;
 b=rIIbdUNEa1sLkfNBKsb4lSQp4gdtgW/rnSg6TajDZdPzoxRpHiYW0/DANq4XYYUAkmH1
 B0jzb/B6QmPihJydZVTxFkM/BHZrKSvSL8+4NPsmSUGcRSSRxLq/QYhlfCDVX/UQafh3
 yyDNeKKGeqSGocovRZGY6W/jGfDrS8pTU6mzmloq1lTISyYaPXvnsMW+iUa3iVM9SjN2
 VqV6pmSwZtSUvLcIGA1mFUoFPYx/ALIk0JUYzyzlUS9/+xepZaI0tCI80rnXxa0owusU
 VCdqNxUMckgiP0TTXd7npHAIXopu5q3IXEmmpVKaPZlvenC8NQiElI5+1M032DzZ8Ohe Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3btkw4r2g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 13:34:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KDL05K173971;
 Wed, 20 Oct 2021 13:34:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by aserp3030.oracle.com with ESMTP id 3bqmsgf122-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 13:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrOvgKWKdUGWajc1IYHMp9qFDYWTH84OSMO5O2fyL6qh+AdNLy2jEtFq2iFNiSB0Fylt46fOygq8lOBYktDkFBFTUxMp1b6JeVAIqSdvleVAggSvD4epogketvSMI0oW4tBX7b3vo4dukYYUEq16pPQZmqdpPQkq442fOr7Af7woZDZHXEFmTVnLvgWHsKdOS2riHVXse9EAd10hJERE6rzLhf7LSccM5iQI4Uf1hVf+50mJVuJZ6iSROueZOjdENrVO0RLbr2DdrPQrhz8JLI9CoZesEJBHFlJOmX2YW/s9P9YI3jczrwDzGsnAwZIsM7PfA5Ol43rXDLMraT20KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9INuua/jVtPQ7rT1RX48j0dhJyIwCRbGwBDzznusU5A=;
 b=n4ne5J1Kka89Yeyvb9tbPexTeE0IQtr8ikl8MBqFo4MmSv0RWL6b8ixcK/VmTADyanUdDzXnWvEd7CQrIwkZ3h5TUzLV3gOUsjHJ1p/LyPbmBJUl5Hr7SxCad+10qZIs82hm9fYLtjg4eLCMGrJf5E4LPR6V85wnzKGkN49yRMN2xmKXnKZB7fW3nxz8o7NZnP32lWL9R5BKzxSmYXdP+y2r5PtkO4fozwi4/TCLpjoQ7Jj0Esoucv2zuJ6b9pvBWPnSIOidUCmsWiOImFq7n/UfE0dfUd5NsBWTE6eSdoZLIM63rpyCiSy26YI4SUr82x/VBC/MDVgJE1nDD85n9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9INuua/jVtPQ7rT1RX48j0dhJyIwCRbGwBDzznusU5A=;
 b=s81ZCzvKvSHzoCXgHTrjhzfW9JUmwjRtMJqkFAgX0069VtzkxV/ghtayBvuf4CoGsI8PkhBgHkkA8W+hMlLOnUVteylb97cTr+lCr+V1oHzbSnpu45OV2m+0rn2Fu1AqIT28bpjXsBRSh7B0dXY+sOVeqqo9oipNrrRaWPfFp58=
Received: from BYAPR10MB2934.namprd10.prod.outlook.com (2603:10b6:a03:85::22)
 by SJ0PR10MB4448.namprd10.prod.outlook.com (2603:10b6:a03:2ad::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 13:34:09 +0000
Received: from BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::1f5:12bf:3985:e2b6]) by BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::1f5:12bf:3985:e2b6%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 13:34:09 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "israelr@nvidia.com" <israelr@nvidia.com>, "oren@nvidia.com"
 <oren@nvidia.com>, "jsmart2021@gmail.com" <jsmart2021@gmail.com>
Subject: Re: [PATCH 1/7] nvme: add connect_work attribute to nvme ctrl
Thread-Topic: [PATCH 1/7] nvme: add connect_work attribute to nvme ctrl
Thread-Index: AQHXxCfiDaJ1M5Zd6USM0b4gq00EV6vb5gCA
Date: Wed, 20 Oct 2021 13:34:08 +0000
Message-ID: <B30E85C0-812E-4FC1-8D33-AC6A192A655B@oracle.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-2-mgurtovoy@nvidia.com>
In-Reply-To: <20211018134020.33838-2-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a04f8f9e-9a78-42c1-8bad-08d993ce4b94
x-ms-traffictypediagnostic: SJ0PR10MB4448:
x-microsoft-antispam-prvs: <SJ0PR10MB4448097424467EF6F548C92DE6BE9@SJ0PR10MB4448.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00hWmf7EfnzvFB5uQyyrVFzH3ael1MJowqs549wf1wWyq6LhBsTjqFZSrSc2B/nbBGP5PwJ/jfLs7xFS+4em4vHyqXPpY0bk1QRmcytvxnir3RWM80YPERWSTeWzxcdqxv59b8gazI4reJy5sLfnm/Ib/FX5oQuA4sMtuhvpECimuh4Bm++cUsN1MUXSrEkha9k5ygOtR8nVRGAoygXwXj7Le0TQ2QvRf+7cX5SsDGqix80qiX+kvB41euqTVlAyjDo1NuO0AbDzr5J4lZISHAf6Xu0Uak8OLb/i8y6fRH2SDl8q1rW45UNmkDmrLm0lvYk8Oz2m2XDxoKy4iZB+Ct+gOFqfGCgHg6NA1JVLaWMOWVavq6I8i6RHiDr2iWCuzeP9jqqpm3UtMiDrjK8U33vrUMVYylsINTf/heX8ECjIltCCj0bjLqPys4Qe8VyQCk9LKfzm4nlYqTDmIDp3Oo7nhHcL4V+QoHDe8j3B+JxKciz3eecMwa+JkjqlNasDsYauN7uaVu1sCr34nNb+eWjRZKFiFNxvL3D42pFgBcuWJyO0zfD91J8STe1623ZiouE+WUmlhdvsYJmau2EyG1EsinMUSb2aVkjVxSLSdqSuxPbwjWTrgG8iT70ouzH8FN++1EIu0qd8Y4WC03CYXJHnFgt0Fba62OvEd98HgzElu8Qj8IIbpAii1bjS0qISfkM+HpNbbbbz/mvIlvObAnJpr8xi6Kz3zNixhMrSyOhmLRQ8AxlKN8Njng9K/dxv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2934.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2906002)(83380400001)(36756003)(8936002)(8676002)(44832011)(6916009)(2616005)(316002)(66446008)(66476007)(66556008)(508600001)(64756008)(54906003)(5660300002)(53546011)(122000001)(6506007)(6512007)(86362001)(91956017)(186003)(66946007)(76116006)(26005)(71200400001)(38100700002)(4326008)(38070700005)(33656002)(6486002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6On+mLpJKQwjfxaJZylEbRjcjGx1JKwtcaunwl/EdbEAVj2lrnZUMo1tVo9s?=
 =?us-ascii?Q?GH2srjeYaWXYTOeuvnpLmG7wNsXEHnm7VHa92HcemzAh8wXvhlJvJHrQYn5p?=
 =?us-ascii?Q?+XmbrCbH3Ue6wrBu5cVAeFPLeXMhp7wyeOfL1MaruYm+JXeCjDJ2b8dw+bR0?=
 =?us-ascii?Q?Yqt2Xv46PZl1eJ34B7HRzYU8Zet0x1EGE2xTC5CiquiAgbxdc266eSH99nPs?=
 =?us-ascii?Q?BtPoa32ngWNsI/z3kah2iK/Emf3U6PcNHtExR2qPjdu6yRU/FR4pGCXuon/9?=
 =?us-ascii?Q?Wzoto0yGoQKhgjbe6KniPeC+bxcRvmVrUfLLGrZp1U24RV+RKPEaV2rAmEGf?=
 =?us-ascii?Q?uHVZMfDtUWpJn4yB75WijktWM41r6r2XGBz7lFDNfZqxFdwWl4EXC17ZPJhq?=
 =?us-ascii?Q?GzrE3OwfmZNa18pThs+ztel9Io493k1RyLHQHyPjd2T4rwkHLiQ7hUs8nHln?=
 =?us-ascii?Q?h0RuAVAms0L0wTL3aDiLa1q1j0SgrCBOu2qYjR/iwrt0O/WCsv02RjxFk2z7?=
 =?us-ascii?Q?C1nQIn13HcnTlJwtGy24Sp5MoLvseDY0nkj6nnpn6W4VKPBKn6B4iwfIe8bP?=
 =?us-ascii?Q?M7Om23Ulo8Pw5TpFZ/AHWOBr9ULwYdSRqM5oHU3ol1p3BM9sTQrHvGHXAojq?=
 =?us-ascii?Q?ZjpAOdgAgyEUWnGzC07MHEYklD30B8kpPVkemyjhF2gatJiJFxNoKp1uZZAJ?=
 =?us-ascii?Q?xvyKbFUWVXF4H8pP4xaIJK4ctFD4aU2s91AA9CDmj8iH0bj5qAnTUC6OOko+?=
 =?us-ascii?Q?mL8zwLty5MwnUNJqk0zoiSTC2uqlwJecMd+XH3d5933pJdE6DuF1v3TtUe7Y?=
 =?us-ascii?Q?8AxTc9bvYXapzQ0q9qx/mQmeqXSEBv4Ay3dl5i1FNw+ulFgC6DKLF86ZgoHG?=
 =?us-ascii?Q?WLUcoCrZ/8AhoKhFYzLaRDMZVZKejLl1InLkHzqsFY2GixRYdY6ti02tPGYi?=
 =?us-ascii?Q?kxMylZJobTRKHcMlHzZ3SaDGJB0U00utpQ9EWYlxdWo4HRxL08jR+Z611x62?=
 =?us-ascii?Q?6bKiICVhkWgEnX+4mtaYaIuzOJsqtD7tVvMb7VjwuQEldu5edVlP9G+MX1MT?=
 =?us-ascii?Q?q66cuU1uZl2Yg4QB+N1haRG8f0DdTy/lwtlB70B6ONuOIFEF54qWxU4b89dI?=
 =?us-ascii?Q?RcGbdwEyaYM6FShPK3ZVjNo5wiemp2VUsHBHjqpAnsLiOgKYliEHpWs8TH0H?=
 =?us-ascii?Q?X863b7aSCsoz+j1c/TkS9lIut7rT8IdWmFlbWPCa06vKSNzdFD/z/C5jssUp?=
 =?us-ascii?Q?VMHSC2Avh0vtJxBB2pkjLCq3ZhE0LFtL+/eQ5RO5zkJ89MFekiJCUGY2UAtH?=
 =?us-ascii?Q?ZTzsqcpWqwjw0DD4aWO5gr5Y?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BC307C942D29747B4EAE1F63487B5F4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2934.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04f8f9e-9a78-42c1-8bad-08d993ce4b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 13:34:08.8679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ezc/B5q1juSR6AxVDvMncB0B1KkUt6k1hR42XN2Mbqv2F9w0C4O27S8OXQXlCcFNJvciIX9hE74HwYz7zLpAwtD/iU/qqvtx0wczyea6cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4448
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200078
X-Proofpoint-GUID: H3-Nb6c2Q7Vjm4itn6UTY8zCmy43_cxq
X-Proofpoint-ORIG-GUID: H3-Nb6c2Q7Vjm4itn6UTY8zCmy43_cxq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_063422_978941_436D06DD 
X-CRM114-Status: GOOD (  30.52  )
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
> This structure is duplicated for all the fabric controllers. Move it to
> common code.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> drivers/nvme/host/fc.c   | 23 ++++++++++++-----------
> drivers/nvme/host/nvme.h |  1 +
> drivers/nvme/host/rdma.c | 10 ++++------
> drivers/nvme/host/tcp.c  |  9 ++++-----
> 4 files changed, 21 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index aa14ad963d91..4c7dffa8126e 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -167,7 +167,6 @@ struct nvme_fc_ctrl {
> 	struct blk_mq_tag_set	tag_set;
>=20
> 	struct work_struct	ioerr_work;
> -	struct delayed_work	connect_work;
>=20
> 	struct kref		ref;
> 	unsigned long		flags;
> @@ -567,7 +566,7 @@ nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
> 			"NVME-FC{%d}: connectivity re-established. "
> 			"Attempting reconnect\n", ctrl->cnum);
>=20
> -		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> +		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, 0);
> 		break;
>=20
> 	case NVME_CTRL_RESETTING:
> @@ -3263,7 +3262,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
> 	struct nvme_fc_ctrl *ctrl =3D to_fc_ctrl(nctrl);
>=20
> 	cancel_work_sync(&ctrl->ioerr_work);
> -	cancel_delayed_work_sync(&ctrl->connect_work);
> +	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
> 	/*
> 	 * kill the association on the link side.  this will block
> 	 * waiting for io to terminate
> @@ -3300,7 +3299,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ct=
rl, int status)
> 		else if (time_after(jiffies + recon_delay, rport->dev_loss_end))
> 			recon_delay =3D rport->dev_loss_end - jiffies;
>=20
> -		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
> +		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
> +				   recon_delay);
> 	} else {
> 		if (portptr->port_state =3D=3D FC_OBJSTATE_ONLINE) {
> 			if (status > 0 && (status & NVME_SC_DNR))
> @@ -3340,12 +3340,13 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
> 			"to CONNECTING\n", ctrl->cnum);
>=20
> 	if (ctrl->rport->remoteport.port_state =3D=3D FC_OBJSTATE_ONLINE) {
> -		if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
> +		if (!queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
> +					0)) {
> 			dev_err(ctrl->ctrl.device,
> 				"NVME-FC{%d}: failed to schedule connect "
> 				"after reset\n", ctrl->cnum);
> 		} else {
> -			flush_delayed_work(&ctrl->connect_work);
> +			flush_delayed_work(&ctrl->ctrl.connect_work);
> 		}
> 	} else {
> 		nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
> @@ -3373,7 +3374,7 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
>=20
> 	struct nvme_fc_ctrl *ctrl =3D
> 			container_of(to_delayed_work(work),
> -				struct nvme_fc_ctrl, connect_work);
> +				struct nvme_fc_ctrl, ctrl.connect_work);
>=20
> 	ret =3D nvme_fc_create_association(ctrl);
> 	if (ret)
> @@ -3485,7 +3486,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_c=
trl_options *opts,
> 	kref_init(&ctrl->ref);
>=20
> 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
> -	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
> +	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvme_fc_connect_ctrl_work);
> 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
> 	spin_lock_init(&ctrl->lock);
>=20
> @@ -3561,14 +3562,14 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf=
_ctrl_options *opts,
> 		goto fail_ctrl;
> 	}
>=20
> -	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
> +	if (!queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, 0)) {
> 		dev_err(ctrl->ctrl.device,
> 			"NVME-FC{%d}: failed to schedule initial connect\n",
> 			ctrl->cnum);
> 		goto fail_ctrl;
> 	}
>=20
> -	flush_delayed_work(&ctrl->connect_work);
> +	flush_delayed_work(&ctrl->ctrl.connect_work);
>=20
> 	dev_info(ctrl->ctrl.device,
> 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
> @@ -3580,7 +3581,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_c=
trl_options *opts,
> 	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
> 	cancel_work_sync(&ctrl->ioerr_work);
> 	cancel_work_sync(&ctrl->ctrl.reset_work);
> -	cancel_delayed_work_sync(&ctrl->connect_work);
> +	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
>=20
> 	ctrl->ctrl.opts =3D NULL;
>=20
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ed79a6c7e804..81ca5dd9b7f9 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -343,6 +343,7 @@ struct nvme_ctrl {
> 	unsigned long flags;
> #define NVME_CTRL_FAILFAST_EXPIRED	0
> 	struct nvmf_ctrl_options *opts;
> +	struct delayed_work connect_work;
>=20
> 	struct page *discard_page;
> 	unsigned long discard_page_busy;
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0498801542eb..fbfa18a47bd8 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -110,8 +110,6 @@ struct nvme_rdma_ctrl {
>=20
> 	struct nvme_rdma_qe	async_event_sqe;
>=20
> -	struct delayed_work	reconnect_work;
> -
> 	struct list_head	list;
>=20
> 	struct blk_mq_tag_set	admin_tag_set;
> @@ -1078,7 +1076,7 @@ static void nvme_rdma_reconnect_or_remove(struct nv=
me_rdma_ctrl *ctrl)
> 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
> 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
> 			ctrl->ctrl.opts->reconnect_delay);
> -		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
> +		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
> 				ctrl->ctrl.opts->reconnect_delay * HZ);
> 	} else {
> 		nvme_delete_ctrl(&ctrl->ctrl);
> @@ -1166,7 +1164,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ct=
rl *ctrl, bool new)
> static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
> {
> 	struct nvme_rdma_ctrl *ctrl =3D container_of(to_delayed_work(work),
> -			struct nvme_rdma_ctrl, reconnect_work);
> +			struct nvme_rdma_ctrl, ctrl.connect_work);
>=20
> 	++ctrl->ctrl.nr_reconnects;
>=20
> @@ -2230,7 +2228,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_o=
ps =3D {
> static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shu=
tdown)
> {
> 	cancel_work_sync(&ctrl->err_work);
> -	cancel_delayed_work_sync(&ctrl->reconnect_work);
> +	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
>=20
> 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
> 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> @@ -2358,7 +2356,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(stru=
ct device *dev,
> 		goto out_free_ctrl;
> 	}
>=20
> -	INIT_DELAYED_WORK(&ctrl->reconnect_work,
> +	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
> 			nvme_rdma_reconnect_ctrl_work);
> 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
> 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3c1c29dd3020..3ace20e39c86 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -127,7 +127,6 @@ struct nvme_tcp_ctrl {
> 	struct nvme_ctrl	ctrl;
>=20
> 	struct work_struct	err_work;
> -	struct delayed_work	connect_work;
> 	struct nvme_tcp_request async_req;
> 	u32			io_queues[HCTX_MAX_TYPES];
> };
> @@ -1983,7 +1982,7 @@ static void nvme_tcp_reconnect_or_remove(struct nvm=
e_ctrl *ctrl)
> 	if (nvmf_should_reconnect(ctrl)) {
> 		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
> 			ctrl->opts->reconnect_delay);
> -		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work,
> 				ctrl->opts->reconnect_delay * HZ);
> 	} else {
> 		dev_info(ctrl->device, "Removing controller...\n");
> @@ -2066,7 +2065,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ct=
rl, bool new)
> static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> {
> 	struct nvme_tcp_ctrl *tcp_ctrl =3D container_of(to_delayed_work(work),
> -			struct nvme_tcp_ctrl, connect_work);
> +			struct nvme_tcp_ctrl, ctrl.connect_work);
> 	struct nvme_ctrl *ctrl =3D &tcp_ctrl->ctrl;
>=20
> 	++ctrl->nr_reconnects;
> @@ -2113,7 +2112,7 @@ static void nvme_tcp_error_recovery_work(struct wor=
k_struct *work)
> static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
> {
> 	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
> -	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
> +	cancel_delayed_work_sync(&ctrl->connect_work);
>=20
> 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
> 	blk_mq_quiesce_queue(ctrl->admin_q);
> @@ -2513,7 +2512,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struc=
t device *dev,
> 	ctrl->ctrl.sqsize =3D opts->queue_size - 1;
> 	ctrl->ctrl.kato =3D opts->kato;
>=20
> -	INIT_DELAYED_WORK(&ctrl->connect_work,
> +	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
> 			nvme_tcp_reconnect_ctrl_work);
> 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
> 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
> --=20
> 2.18.1
>=20
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


