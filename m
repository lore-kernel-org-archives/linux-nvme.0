Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB86CC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/yEA3OIUGfTpIygZpDklri2XVQoHPctFMzV/hTDCxE=; b=y80Ik17a74rWuWsV6PB4Ps1C8j
	LgcNXTqOUjj6/oUcV5Ex4vqUN2l09M0SQSwB3BJOcNrru5dRQwje0ivcosQtx4oz79ut+3MwBh20p
	28y9QKtWWF3igt6BADo54IuSt2vZZEuOUzayOtSL2zlFpz6fbWhug4nQMDGOqvJ/sGF1fyOo8sj6M
	AmmRWSg++ZZRYLpv5k0qsd1jU4D4jtrs+2H32r9tF46NpZF9klI1BPeRb8EfG/odl1aDMp+Rh7kS6
	sC9cmAiewB4CduRz33UrhC8CH5daxuNDsyvPsOmTkUQAu6IKR/0pgFfe8kUvMhtQCAUABmJ+pZFvQ
	CfK10XIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onnwn-00B1xo-Tm; Wed, 26 Oct 2022 21:28:25 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onnwj-00B1wZ-6W
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 21:28:24 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QJHwPd001007;
	Wed, 26 Oct 2022 21:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=E/yEA3OIUGfTpIygZpDklri2XVQoHPctFMzV/hTDCxE=;
 b=babOlXO8OjJIhCdxTsLH+TsVQQXQIJVy1JnVtgfOvM8Ufmarfok/uCcM7N7zymBxx9/v
 BH4cu7lZB6TuPwPvGXYfyF1/w/TgicvzWbSAgwzGgtbLl++cV5H7tgQoLdOaXcVGPSvj
 RU9mGzMqC8yrjzLZN6Vvv0VFzz8HvMKJT5z56ulZKgVwandYC44ndVXBKGlPkFjnX67c
 qhVw4TffyH2mQgwxoGORT3rc5P3MlrG6rsKi/21btY1CSinT5CmgJiWGpy5EOiRbFoTw
 A9KFJi1Xs3ngNdQbMarYt/41suTvBhNXS5ewLVfnN0rgpoYMY3t68Ce1ETjuI+Y9eB2s qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7rbhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Oct 2022 21:27:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QInBco011644;
	Wed, 26 Oct 2022 21:27:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqbv55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Oct 2022 21:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dViFWKWP3FDqhedhqqI3G9ayHLgQ/aKdkD3v+WNBiRx4o2XJ7HUX1q9Mc/2qGXe6Af4qVut4dSoXM8wPF2lpAQYW38dgoYuIA/CDbgwDTsVxpRWZbKwH8AYlVc1WPEtpEAAgD9UMyQGRP+TXsd8ihuRAvz7O3mVVg7YbSqzWYN/uU7HJAH5UVE9HlTV1Y661S32Z2hasnJGSvXfWyzRc+2mICwO6Rb160WHIW4DHMvAEt+WCM9AowjI9x2gqRszcuUq/4JEurhWUqwjQb3Mi+7FLcXGz5J2x4VkPGGgElTZLMk4b7vaBghFpBcee9eUn70vwtP+H17RoEtQ0CDdx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/yEA3OIUGfTpIygZpDklri2XVQoHPctFMzV/hTDCxE=;
 b=FhWn+4TXIgk+7S8teh3nYk66i9m4o4GKsiW8ahoogbm0Vmk3IBuBde+pWnmXYEnjQn8mnO2bAWEq2IuI5kwijuk5lx/HVKX9/oekcrXYljjOLQiLel8IHuRn1cSNd2yXct0nUzi0rwk/G2yBs2b9J3XqPhoDtTCg0QXx0WFTcLN0rcCsknwJ2D+SD6zGeDcyZxOqwwT/jxZwIz+fyMv70pDVxohb8aBm+lgAPoLSkCHkc9Cluw94NJ/EMLCbECs7YSJQ5eGZ0FvFCo/49bRkdOre+pGACblLurjC/tmD3JaJKgpWGpQWOIL4ToK702PnS7ERiv9IeWHKFyvW4Uhwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/yEA3OIUGfTpIygZpDklri2XVQoHPctFMzV/hTDCxE=;
 b=jl/UOApj+UWN8ghxwtRCg7aaHFUVa5ySG3PpZ6CUWT4hi/tpwtDg+SF7dCcgnKn+YQjTDKAtvijZV4zZhdpJF9poBXcWuh5lHgZC1svSZ8hZIXVfwcCw3wm3yHFLEjZEM60TYhMWit/6Jxvzcrh5u2zoV3R6GZbd4IWKJImONB8=
Received: from PH0PR10MB5548.namprd10.prod.outlook.com (2603:10b6:510:db::14)
 by DM6PR10MB4331.namprd10.prod.outlook.com (2603:10b6:5:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 21:27:42 +0000
Received: from PH0PR10MB5548.namprd10.prod.outlook.com
 ([fe80::c015:b0b:e3fb:19b4]) by PH0PR10MB5548.namprd10.prod.outlook.com
 ([fe80::c015:b0b:e3fb:19b4%3]) with mapi id 15.20.5723.029; Wed, 26 Oct 2022
 21:27:42 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Keith Busch
	<kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvme: quiet user passthrough command errors
Thread-Topic: [PATCH] nvme: quiet user passthrough command errors
Thread-Index: AQHY6V1ukevfyd7VB0isdL1YlJjCFq4hMNOA
Date: Wed, 26 Oct 2022 21:27:42 +0000
Message-ID: <2FEDA77F-8160-4AA2-AEB3-0556B7EE9499@oracle.com>
References: <20221026170715.2657664-1-kbusch@meta.com>
In-Reply-To: <20221026170715.2657664-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5548:EE_|DM6PR10MB4331:EE_
x-ms-office365-filtering-correlation-id: a4da0638-3f43-4dec-5def-08dab798ea7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  4LyoN8z9dXoTSAQgoWMcNEHX/R1uTxsj9A3hPwt5qA1OO0UzL6uZh1h0pOj/OWh4I1dNTwsNkAw/+kK+aPcgDWb+YA3bMVBxDvTuA5u1WtCHYa8aTWme2HbwD/99N5cDB+wS2FLWC7EJC5kTAJxraAPdUKG6tGoR9QhFHAaNJcO6iREUKrNu1lULQVDoIDn81i5fCkiaz9JpAbK++wxeCqiErxUWacAtErFq1lVTZ2pIm3KMyZo3h9MiNg2F3mfO5oM6wTdb44S2ZszIXvM/RKFDhuS+R4tcWPimUPVgxbKnMUY2HjPdhNXDsGMSKeaRCgFUyIbsSeGD061tSzaJ6fNW/DyVvEGXaboJ4BgO06AqcTzRV/gKiGpqX0urXvXtikf+LC1uZEFHnuAdPlByxoyTG1eVNF6lPZEFn/RUXoYfMiEGgMvaOfpEznE0S6NgpMEl+2HM9b3yiXgePFjeyQnMOu0bm387PuxFp8JiGngAC3KfB4jOKLqkSHxIBtpmR0CYbd6V9YERPREbUTNgfh9wbVLslZDmetOyl6baMTum1TaiLbU/PsChQulofcy0CXXZUB7lvQJ3D1Hxn+LgGzvJk60cZ3g2rJOd7zGpcqKBK4wU045urf+6qpqWwt1I5WThUvVGWSnCLJmssiP6ShPBC2Pcv4cgAl4wu5nJcY4K7cc7UU7soY57SsGxVYwFlVevF/3rah7RJwSEwANj+U7kwHN3/4ns4DoW6Y6TEdTd3VPrdu8KawZVt0BTnGyrqALkSfnKwMkCiF3WNX6lLVyNkjiIWzpt/Odp39ryLa4=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5548.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(66446008)(41300700001)(53546011)(91956017)(38070700005)(44832011)(64756008)(6486002)(86362001)(4326008)(5660300002)(8676002)(122000001)(186003)(83380400001)(6512007)(478600001)(71200400001)(38100700002)(36756003)(54906003)(2906002)(2616005)(66556008)(6506007)(33656002)(316002)(8936002)(76116006)(6916009)(66946007)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?hgkfxBnlnrppFBwXyCea2e3wR4OtiL5PiFttHsZB2+2zjCR6pdpt9sN6pwdO?=
 =?us-ascii?Q?vvLipeYFurnSa1CIbiUetGFuOi3WIl1qpht0V5b/qoPVnMCYqakT2ZqtvFrF?=
 =?us-ascii?Q?/6/nHec5ffAYo36hcCq9j0q0Z/ITEcC77F8rmT+ZSVPNTDC+t0Qj8wqes19u?=
 =?us-ascii?Q?A7KLuVVJgi5T+tc5JKZT8T66QBsqIjMdnV3xVxygN+KhplaT2eNUI4+ORlGP?=
 =?us-ascii?Q?RKseqyIm6o8Wl1oqxOn1LOzjY78dM1v6JAAkj93Tnkbj0wHsu0GCjCtww582?=
 =?us-ascii?Q?f7st5vwHGCj4y+Ce/qnk0ttyvnvoWXXSPEAsd5vDQh4/sWdyngkUkZK1bm48?=
 =?us-ascii?Q?sD3kUJ0nu/EtzwPZvoyAR+mOYTTSOvjKAFgJ1Zxk6q6ERK7lz5ozVnBPZLE/?=
 =?us-ascii?Q?zeosFC34cvstdyP6dcKuHKQUqstJWgpzTw0nePW44AMJxazFzPyfHjALiC2G?=
 =?us-ascii?Q?LbCVleuqD9vqaOg92mx7KdZGFDNZFYMMeCbQVT++AJP+R1dDpt/sjqyh6i2R?=
 =?us-ascii?Q?FiKQKY+lm00lYA0rjgWjq1FsoUpKWr1npgxoeTBti4pz7kx4Sj3JnumvimKn?=
 =?us-ascii?Q?I+1Sxa2tG9RtoOpB5eQLrfmzLBcIwzADtE9G/ayIM7OhWkfHh1JhobkKEXjY?=
 =?us-ascii?Q?eQtu16URArMtYKSOWz+tVoxiMwoTu0qTQEiMmr/KJ3FiiclYc/o3a4rVI9w0?=
 =?us-ascii?Q?wEQ6JXxpMpe9mq9goNFvAY/5oKCDGssiLdY4nw76wP2uAgGRlaRShQOxajS7?=
 =?us-ascii?Q?z99+zyTHYAN6B6cplbGIoW7xeoDAvL+PaebUyl6egmVJM2+fuuSQP74+nlMs?=
 =?us-ascii?Q?Ib6Vyu0nVeuTkraYBEAdvrpEiCKP9112U6XXM/+M3IHquuxeM8c2DECsnuUV?=
 =?us-ascii?Q?DQTxf4L9A9NHmRp1aJL1VzzL3aI0QULYkcLRh5b2d2iVOCf/7TSomoZ3WSUr?=
 =?us-ascii?Q?RIjOxc+6uBokB/mmkO9DFlgL7ZBe5chkX+sfaMpWsZP9M5J1dFfZJIQY0FAt?=
 =?us-ascii?Q?IyCkvwj7DVQz7KA7ZmiNflOAhlBuEdkXPUwMzD3WonfweHJCQdquV0xlaN27?=
 =?us-ascii?Q?tuN056qWOUJr7DkY+9bOXyUw2639/abd29xSfrcSepYqtHpv/ygLmDYlsxWe?=
 =?us-ascii?Q?jzCibH21sq6htQStov9aD7tBnOJWL5H5IYxsMbsBnUM8TxGQqarkRBLa+Fhq?=
 =?us-ascii?Q?Yb5O0ChdsRNBCvLmvD9rNnojFmOk/3uINYNGRD06K8TTAtEVKCWL+tLIP7Ru?=
 =?us-ascii?Q?GwyBaj1jBRgkk8YbX5TTwPo3P4JKmhVgHrqCFOL9v3fkBpl2iohDfNlmyZcm?=
 =?us-ascii?Q?9XOlruxLItPjAZMY4CB6oVBx7ZfepswvUfDDV6ZUf9gPPPkxnFMcR7yWbKnE?=
 =?us-ascii?Q?E6uN+OiIqdp2m/j0/YS6I1E7bmO7lqD8pZWlkjjemdk255SjdH8TiO8Td1uF?=
 =?us-ascii?Q?WsrxQ1TGqDDeeJ6gro1m2njSWZXB2z1SfkFHkwso6jjcGzAq0nHZxjwyxL39?=
 =?us-ascii?Q?dU2VxXd1o+pUtw38JfuIcgsHaSVkA/tVhLSCivgpNl1wtPgrZE3Rm/gVbv26?=
 =?us-ascii?Q?qLXH0jaf0xHuix3IGMps5GRx6rNWC18A9Of3BUPKkjZgEhG36dSUK70V4Grs?=
 =?us-ascii?Q?ycIEo9MQiEqRehJos3O0ENHpZ5/OR2lrh8BIW30avOUW?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDE7EC0C45C5F44BAC0B1BBBC8A43379@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5548.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4da0638-3f43-4dec-5def-08dab798ea7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 21:27:42.2783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JekGLdrpj9X9yeSmLbIDWMarV2MSE+wWzdPFlVjYykooq3LHY0gmEABH5DV89Dj/XvHVru6Ufb3YguLwsqHxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_08,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260117
X-Proofpoint-GUID: a0Mflz2Qlh7wYHcREuZCEaMFL-GZXQux
X-Proofpoint-ORIG-GUID: a0Mflz2Qlh7wYHcREuZCEaMFL-GZXQux
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_142822_361441_7E931638 
X-CRM114-Status: GOOD (  22.62  )
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



> On Oct 26, 2022, at 10:07 AM, Keith Busch <kbusch@meta.com> wrote:
>=20
> From: Keith Busch <kbusch@kernel.org>
>=20
> The driver is spamming the kernel logs for entirely harmless errors from
> user space submitting unsupported commmands. Just silence the errors.
> The application has direct access to command status, so there's no need
> to log these.
>=20
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> drivers/nvme/host/core.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 686c55cb5d1a..da874172a31d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1156,6 +1156,7 @@ int nvme_execute_passthru_rq(struct request *rq, u3=
2 *effects)
> 	struct nvme_ns *ns =3D rq->q->queuedata;
>=20
> 	*effects =3D nvme_passthru_start(ctrl, ns, cmd->common.opcode);
> +	rq->rq_flags |=3D RQF_QUIET;
> 	return nvme_execute_rq(rq, false);
> }
> EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
> --=20
> 2.30.2
>=20

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>

I tested the change with blktests which uses user passthrough:

Before patch:
[   69.041515] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error=
 (sct 0x2 / sc 0x81) DNR
[   69.041557] critical medium error, dev nvme0n1, sector 0 op 0x0:(READ) f=
lags 0x800 phys_seg 1 prio class 2
[   69.055721] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc =
0x75) DNR
[   69.055754] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x800 p=
hys_seg 1 prio class 2
[   69.067335] nvme0n1: Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 =
/ sc 0x80) DNR
[   69.067385] critical medium error, dev nvme0n1, sector 0 op 0x1:(WRITE) =
flags 0x8800 phys_seg 1 prio class 2
[   69.085449] nvme0: Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR
[   69.103265] nvme0: Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0=
x1) DNR

After patch:
[  167.375311] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error=
 (sct 0x2 / sc 0x81) DNR
[  167.375362] critical medium error, dev nvme0n1, sector 0 op 0x0:(READ) f=
lags 0x800 phys_seg 1 prio class 2
[  167.388812] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc =
0x75) DNR
[  167.388839] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x800 p=
hys_seg 1 prio class 2
[  167.399907] nvme0n1: Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 =
/ sc 0x80) DNR
[  167.399928] critical medium error, dev nvme0n1, sector 0 op 0x1:(WRITE) =
flags 0x8800 phys_seg 1 prio class 2


The messages that are due to passthrough are no longer present as expcted.

Tested-by: Alan Adamson <alan.adamson@oracle.com>


blktests will need to updated, specifically blktests/tests/nvme/039.out.

Alan




