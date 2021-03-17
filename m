Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63C4C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 21:24:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FD464DAE
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 21:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FD464DAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ig49AiVsnZKMQTnigJetfQkejRWmii8eidfwrW8mWII=; b=lSqcLV+8258lENFaVdN6PmR0R
	a8x2zQoNulqqEdoqpHWXkPJuP3ba/C6ktq//r3N/YYKiXeMEsf9Nj3PUY/W858qOg5BkqMmILJjiL
	nxUt1pPkinMEZyxp/puRS4yrLyvGE7HEpPt5RzB9KHPh6TJNiuLvFjTqWFSFOJHVP1zA8vnqusKx8
	Q0WL57YvCtDRyPEji5B0NOXankWf1Jshbi2veGlIP1Vb6H1Nj36F0SwX6seJ64besNiSfcQPx2YBl
	x01/meOLb55emCPdzCIIJRcNKVJU4tKuiwCoSg13YYL5i8ngwSSxbj0PbM+Ewq/M2SK2Ij84IIJJz
	vKVidgomA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMdeD-003wBr-KE; Wed, 17 Mar 2021 21:24:10 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMde5-003wAp-HM
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 21:24:05 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HLFib2015583;
 Wed, 17 Mar 2021 21:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4daOYo6R4LlYRUeaditlM+Hf54Yy3aqy3ob5Udr6Lk8=;
 b=Kw8EED/paPHMhrfR4FE4p8n8dba0o6skrQLBKud7QxJScZboUx5biMm1VcOSpp5UIOA0
 bwP9Tl5jnHwl9JZpYVn4RwOYiErMl5/bs65MXhXAPR8w22uLq/lK25Y6mnZBiTzfYWBE
 /mGdJ7mGupE97Sq3MKHyoE+nI08r5Z15DnZfmTr6n+1cDq2bSUe38lWhGVV3iz4i6BlD
 NKdEvoT1dhXKtmbSZjlJ7oPtfBgAzatVQqeRFqr+KuxAkm4xaD1ZmFCVs80B1HK1OsET
 t4GTM48ywF+QcAkgLNkfqrZ5d7rCKlvH1CAVJnVQecTUl4lCmRX0MxEMIYmcDSSd58nx 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 378nbmdka0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 21:23:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HLA157123341;
 Wed, 17 Mar 2021 21:23:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by userp3030.oracle.com with ESMTP id 3797b21gmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 21:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okpz0UxSTSluv++Aci+UEpb4KNlfhIt3DKzcqZECmJdow6Zty1caGLK/ut/zV14tjX76F1o6Gy6t3GMrL972whs83frIAI61y4EbCNPW90m8ZTHnXOhOuFiDA+cCZZSBy8Mbtm4T/2nyVRP79FKmyUPiowK2ALo7w9FR7X42uA8ZBHUK1ZEKq9keM1PvqxEh7kVSQekH2yKnUzgxM7PmV+hYrOX5U49BdfOhEUlM4czNbeAcLriUgG/0SizSWPHhgAUJO8fu318fhBvrFyLbf4yCZdOXkUaxkJfZl5MgGlz9q/yiKWEMe2h8fjm4gbo0KTXVtOIGaKoHkEgW8fDOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4daOYo6R4LlYRUeaditlM+Hf54Yy3aqy3ob5Udr6Lk8=;
 b=grB1Yvz+Lfk3uiRzFZRed1iyxeAiw1Pj4/OpG6US59xp7dTzj8GpX5gKc6uLrEXcTa0/sZbrOicpwNjcORpkJib1/uneb1k9HWU7t2oLoj0ZYDYcRyO7DcqCQnuWZvxU298ljlgLrcNlunaR0VgvenpoJ+kTvhkMKNcL9OzMbZA/Urm/cU+gtkTLX8L/umNMQcR58A7MVGhJn0Fv3mePk6klupHTT5KPs9B7+Ha8of/THa0RK0rvCIgznJCZwjUQu1nygSlVeOocK4BAMpJ8mNjhJTPUoXb4z4v6hSauejxv6azf17GbCuPjakYmDdTmJMSGyBdVDyAmnZLhj4Gpig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4daOYo6R4LlYRUeaditlM+Hf54Yy3aqy3ob5Udr6Lk8=;
 b=gNBT4Cq3gv+aTrkCy39vIRadWP2a068LxojjihTFC/OrCPWFGmpZ7mbn9AoTSzUzibRhLnboAlI1+5Ryet050fmeutrGQITfL5Fk+QrMajP0ujI33JkHQXFftoy5dOnLOSHi6d7e9HREQFrcJp30DVdpx5siBLfnUibXaovvtVo=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2717.namprd10.prod.outlook.com (2603:10b6:805:46::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 21:23:45 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 21:23:44 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: "keith.busch@wdc.com" <keith.busch@wdc.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: fix Write Zeroes limitations
Thread-Topic: [PATCH] nvme: fix Write Zeroes limitations
Thread-Index: AQHXGX+yX5XJp+M0hk+cDX554GJZhKqItJuA
Date: Wed, 17 Mar 2021 21:23:43 +0000
Message-ID: <5A1E087E-ECEA-4451-AB48-44DEA50B229B@oracle.com>
References: <20210315093438.66082-1-hch@lst.de>
In-Reply-To: <20210315093438.66082-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f47d14a-3ac9-42ef-9328-08d8e98af1cf
x-ms-traffictypediagnostic: SN6PR10MB2717:
x-microsoft-antispam-prvs: <SN6PR10MB27174BA2BB1A90997D48CC9AE66A9@SN6PR10MB2717.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OqZoCESGqVcE9QsUx2qsYuaXmANJzHQLhwzyQ3q0q3r/WioUuQzyLzZQkJzm/jpFZbUizAl7o9LPe08tOuDFyFXhZWHqQ7yJNAYz34LGtujeNnm9b0DmesSHFz8avg7PJQhAJGZHtUVy6LuI23u0h+FUyOMhqpJVw+tvrYAhlxztqXQLDNJ/jErMoOa8XJLtWfTcyUzwfPPmNxiORElNjjM/5wFWehbXLcgHklg0MbxlJbEw76HK7Kr58e0W9+2LnNUe7f9NIUkPt6mUqEDVgVCoe7PsCpRK1XSFaP6/A3AZRKJCVnMmgXhugHS45ph7lljx5FC5jMLCG0jQWTru+iek6jdBzltFW6wAzol6NVECbjnLusdEtOtAoi+8gUsOQFd+yNOx0kJ/3XDoJTj5cz5Ik4sHNMeIzfdhM3e3ALfP1Tep3XKFy5vBmILWVKWstlUw19uSNpWuBC7F62E/7c8dsGy+HUACFK33cvK0DSAJzCAG0FC60qxrIqD0rwbO9KfRH0YY/6kq9Wk3JIsnmhxtuj24GmiZLaBwpRi/s2yoBxE4RHmN1aP5EFqGqBXhT0KkFaGbHYhcaTm+5bqrKUxVEiTL8b1fKeCJoOboMVGMSb1BR2f3qhGJpxsfxDX3sDMvqDqpDbUcIN2gNuZLD0wQQtIQzZqcKKJYE5aAQgX2jNkxHJB4u5vdHdok67B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(346002)(366004)(136003)(376002)(2906002)(53546011)(2616005)(4326008)(6512007)(316002)(5660300002)(36756003)(478600001)(186003)(54906003)(966005)(83380400001)(66556008)(71200400001)(66946007)(6486002)(33656002)(8676002)(8936002)(44832011)(64756008)(6506007)(66446008)(26005)(76116006)(6916009)(66476007)(86362001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eVGd+//pvZk/KTFSuVOx8MGwE83gd3KGeEce05aTo6/quDbWYNEusRIIoCXA?=
 =?us-ascii?Q?lQX97SkCaFFB6gj++Lg13TnDHq7lTrlEezghpvFntPW9mRk0H3CSQx3CPqaM?=
 =?us-ascii?Q?4GS32nrUrpK6xASJyFtEhHmiuyj4ne4aAHFl6itt3EDvzdrbAit6D0e2jSRb?=
 =?us-ascii?Q?Tur1gBvd5XPZwUemRJ+kFjDPHhQGWUOgK5IrUvxOdOYXZ6ENIINPqPjnx5tN?=
 =?us-ascii?Q?Bg0FpLP6PGsmRmeos2bNl4H9BNOma3/3wUmEuP/MAqTJEczkfiu5u2ihOvT2?=
 =?us-ascii?Q?8ms7zFV5I4C2Xk60rIh+9mrNvH6BdWkO4FlR2J+ilH++2QRAygd1F4qDEshG?=
 =?us-ascii?Q?DFYD76Pb/lONhiB5nNd4BgdwnPB1Zc7QLYNAJMfgDCWxtxdxkNaEQTWvKKAB?=
 =?us-ascii?Q?Oe0IOdLvCi4QwSsXXsyd8LBUb8npwkcE89mzQrE1copGESOzTdP9YT9NFxxx?=
 =?us-ascii?Q?p7Vy1NW0UbGe1dS4E74zAg+z6O+8RFSLv3d/wWV6KvrYPixtYdPQHXA7OwaD?=
 =?us-ascii?Q?0l0bq1c2FEJAkbNQZBrddh3psXfoL/vod0MoQhzsrifW3xeJKiFUU5TSNBy+?=
 =?us-ascii?Q?ym56K5izTBeb+/0UrKVUaTDeqeeDX7Le4I4wDd73hFUyS0SCLxd4VsxPL/mC?=
 =?us-ascii?Q?62lnnhkcbfZBaLA+kJjqKJlHD1BzfL5rYidHDvpTMxtuKCzuzIpEOcaRKD6y?=
 =?us-ascii?Q?SspjxLNCugq0iZXKzRhoQi2SBxvIY0IM4MuDZDE/fFmArSvdb6q/vX9I54F9?=
 =?us-ascii?Q?ErtlgGDYgw4K+3TypjoKmoYKPqezJ4o5be9tVEWJ0q6QhsilFXhbOWK/omz6?=
 =?us-ascii?Q?v1WIYAB4Fk6pxkqM/8J28hDj+/PZLcItXuMXBD4fvJcSR2OwsoeKgvdRQdVR?=
 =?us-ascii?Q?5/lstcNylOw1PthG+mmmFk7B0YXvYaF3BMalPr2OOgrNkPWhcLCpDIQ525kG?=
 =?us-ascii?Q?18/owWQSPJ2YgMLZil5lkjksqNZ2E3cd3BBt5KUfo51aFzjnr5/QVFkjk6bP?=
 =?us-ascii?Q?TIUwRqlNWUeGA1pJY/6u/Q1/leAY76XDGfUsojHgFU/ArOgLm221/lHA9W59?=
 =?us-ascii?Q?AWfvQGP/hy3ifFdX3huYU4nTbvSAtHu3oK4lWc6WSv1Yu2q0tVHQaItNf74H?=
 =?us-ascii?Q?0Eank60LLV0EzsqwFLvowEmxZ7zb7mDBvnONNUzEmtfBaAkiasTjy+B8Unqt?=
 =?us-ascii?Q?xsVJ9a41rtZExXNIbx3Kz9XMZKf/twPBR47+rPBOUUQZtK1OljZ4k8B/MxUm?=
 =?us-ascii?Q?E8IdVq/6vgAELAY9x+2eay4swC9c3xwyiDFNb1ONzNlZnOeBgwpyg+Q/EqGV?=
 =?us-ascii?Q?iS/8oFC9SL9KQSA2bV/b4k3aRZqaJmbqDHPrK5LMs6f8Bg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <62DAAFE9E5F01B4F8C38667EC10C2935@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f47d14a-3ac9-42ef-9328-08d8e98af1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 21:23:44.4126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGlmM5bRcCtwfF2kPF51jXxuYg15ODbMb9EuLL3yy6+i9eaZ8Rfm3ClgdJhUcF7ymfs6hq8P9gc7ksobMOML9A+Do/DpI4RZzJRMupdkMcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2717
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_212402_954039_BD4B6DE6 
X-CRM114-Status: GOOD (  32.81  )
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



> On Mar 15, 2021, at 4:34 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> We voluntarily limit the Write Zeroes sizes to the MDTS value provided by
> the hardware, but currently get the units wrong, so fix that.
> 
> Fixes: 6e02318eaea5 ("nvme: add support for the Write Zeroes command")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/nvme/host/core.c | 36 ++++++++++++------------------------
> 1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 82ad5eef9d0c30..1bd18d7f53b316 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1964,30 +1964,18 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
> 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
> }
> 
> -static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
> +/*
> + * Even though NVMe spec explicitly states that MDTS is not applicable to the
> + * write-zeroes, we are cautious and limit the size to the controllers
> + * max_hw_sectors value, which is based on the MDTS field and possibly other
> + * limiting factors.
> + */
> +static void nvme_config_write_zeroes(struct request_queue *q,
> +		struct nvme_ctrl *ctrl)
> {
> -	u64 max_blocks;
> -
> -	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
> -	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
> -		return;
> -	/*
> -	 * Even though NVMe spec explicitly states that MDTS is not
> -	 * applicable to the write-zeroes:- "The restriction does not apply to
> -	 * commands that do not transfer data between the host and the
> -	 * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
> -	 * In order to be more cautious use controller's max_hw_sectors value
> -	 * to configure the maximum sectors for the write-zeroes which is
> -	 * configured based on the controller's MDTS field in the
> -	 * nvme_init_identify() if available.
> -	 */
> -	if (ns->ctrl->max_hw_sectors == UINT_MAX)
> -		max_blocks = (u64)USHRT_MAX + 1;
> -	else
> -		max_blocks = ns->ctrl->max_hw_sectors + 1;
> -
> -	blk_queue_max_write_zeroes_sectors(disk->queue,
> -					   nvme_lba_to_sect(ns, max_blocks));
> +	if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
> +	    !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
> +		blk_queue_max_write_zeroes_sectors(q, ctrl->max_hw_sectors);
> }
> 
> static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
> @@ -2159,7 +2147,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
> 	set_capacity_and_notify(disk, capacity);
> 
> 	nvme_config_discard(disk, ns);
> -	nvme_config_write_zeroes(disk, ns);
> +	nvme_config_write_zeroes(disk->queue, ns->ctrl);
> 
> 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
> 		test_bit(NVME_NS_FORCE_RO, &ns->flags));
> -- 
> 2.30.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Good. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
