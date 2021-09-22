Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:35:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA6561050
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AAA6561050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nYs8seCx2vfo63ahnlaRG//5zcN1ea6T5ZOvGX14anI=; b=gHkWjLkdp5FPcS
	rXHR2Xim/qRYyxaxaABywwt63iJYntQSIyt08KKkgRo2hlxZ6rfUeG+SbMo0znlmmzd4m6DK971h2
	s2HAx6sjGm9Aq5EGIhn6LuJIFF9AazMF4YII4WM4Ke7hbo0R5on81L4kDEs5J6eWZB9GkHM0XAIw7
	5XJmdxHQaplIDZxmT5+ai5xAALzF+jy+bJ/pZh2jN+io63ejKlmGNmP3BMDLGwTqIOevwcOgtaxdo
	26l13Rg1nDNM/Bjus9RKUe1GnoTIrJZYmLjSuIszCLsTDj+if/kwnukW1xZfujljTwrTcYP+9tz4l
	mfcnMPqOL8kcapSXtGuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2Oe-008dlh-MJ; Wed, 22 Sep 2021 13:34:48 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2OL-008di5-11
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:34:30 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MCsSQl028874; 
 Wed, 22 Sep 2021 13:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O7EwQKG8BooNc0GzvfimkcGmlyuX+98g6OTfOwXjOb0=;
 b=lCWTx2wbcH7R6NX7gjvsuZk7/SUrcki7Wr71IBUAHupAbcvsRhwfofdkPMkVGVFLPOfl
 g0XVq5PVNnQKLEbK3nRFPn71YlRoXXpbVCELqJbUKJhRLtLXg50xbvZGwrNsdnzRVzwm
 JHNI/Vx95eRRb2IN5Kx1tCp8VSEmgREU/71FbIc2QCEFGXnGVv0+7BhW+CKlI+nHQM3f
 86PVRue0v2ZWIJdqEOoR2AO/60xzjOxjanTajENA29j4ZkH3IL+GEZYMci6PTaHLFM1T
 9eI+j6MVWKYdoXSr8mj6EesDbgrIP+XBrCIIEkM0J+A8h1Ztye0P74dlZ0LJnzkV+dZA /w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4rbyr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:34:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MDV0PU170795;
 Wed, 22 Sep 2021 13:34:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by aserp3030.oracle.com with ESMTP id 3b7q5c66ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAyHOVr+66gKs/Ypixeb7moegVAGGsHEj1S4Juw4VPKtm1SkYxDdrodGFRUniLtEuPE3qAZjGE3nRVmoqJ/KCjbEwAs1BcCZ9l0QA0R84Ge8jri/AeOwJRNUvfweEf1Vhn80vx4sPbDdjQaKnDGhQMq1gtc6JvksBx0D1atVYgql7gdLH2yWB1/Re5XFBtMDME18VfaCzUTDBUUIRRXuLX7bRJEIGoPv7Lh8kR+1YPeoqsZBjw7TdVDP5k/2U3gS34+Z2R9Jv7nf8ak0/r+Lwb5m+6jvODQVJTTCWCsY0RdfoAVAFBNnSORiGKMXqEk5JLKjM44QkZ0q2DkigWznqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=O7EwQKG8BooNc0GzvfimkcGmlyuX+98g6OTfOwXjOb0=;
 b=a/fNRA5HYMc6XducJoiAQo/xzvt9KbTdhK884Ji282FCR/775i1zNuGVXlFa2vpW2j26tQfU58D9cnEMn6C96UhIPRbtDol37m3dCYLcjYYnsc9wOhxzDD/JmbOlkB+ixMAgpcNn92lRFFZOJLwGBYfYrX6fI/J1yPJPwgbVbJoabhCZeZh+g/XxvG+aL3tnjyk6cpSKsSzIgCurVnbbVyqI26EGeNvTDskyXICyX6lFiDUh67ZJpXYpdpSRyXh7HSEgeLky+MEcFXbayzCEsfE9cfDfBMVt7EwmKQ7WNgXEk7IrqRKOcwsPVzwNpArbOWrCcEGhJosl86M+rqGcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7EwQKG8BooNc0GzvfimkcGmlyuX+98g6OTfOwXjOb0=;
 b=Ejdc9Y9bwCTrBSEZHzcRb0JUjH73ijUt+Ckom5Ukgk/IYS0pgKHvJGvikoVS39DmDsCGFLGC1+7im2fd8wEjKk+zTbzwJSg3qNm3Z/blX8ykouUo+2mBoZzj6Fn6ox2NndigBbEep5Ss4rH9d7ksi4oRch9RIMUhba9GvhHLZSk=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 13:34:21 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 13:34:21 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <keith.busch@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 5/6] nvme: Add connect option 'discovery'
Thread-Topic: [PATCH 5/6] nvme: Add connect option 'discovery'
Thread-Index: AQHXrvzjpsvHWt7HMkaY9e1t2SCgDauwDx4A
Date: Wed, 22 Sep 2021 13:34:21 +0000
Message-ID: <E0B928D5-3F36-49D9-8F6E-160E57B9B98A@oracle.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-6-hare@suse.de>
In-Reply-To: <20210921151529.29419-6-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f36ebeb-bf8a-4500-137e-08d97dcdaf49
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768D90096874F1BE2C95C86E6A29@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XT7YzmL51DWz9OAGNcz/j5MWmG0r8NgDePHovjmIflgC9LhWocXuV7TV0970uX0rjXaK28jntMLOd4ICwcL3s/6u4WdU+REGdCy5l0RgqhxUSUTPzWIR+INkXBVGzj59mgTOF9JZOtXj0Wz5HrdeMS3R04eo4WV0X4zt/jQH0o+ZZBac9C2Hf6obHfARnL6hsdSV81UeRuvzkpZ79btK6NJz6liQd1VCPfYzl4cgNIQaNJTiVc9J8oLSJwWmKuwQZVlO5kK1xyKMv8uJUI2eFTQ83Py+IFZToD5CUuKI1hyuRAUHZBLO9m8NGThyozPLUfBiD+NpBQ0i49yJkf12yHBInm5vdWeEfGMUcrQyjQczmNiw6WPgP+7MvcpesVZADVZXwWyB3LnCoYSML4y7ws+QyZKfGuJjXLL9NScuZzQoDLnMRp7s1/JzeJhq/JI6Pun7OX3tSsqHyE6fAQGsFPvhIEOv1YdygoPAk8SyEnoNH43+iQ5FXddr4C00gmP9PoPzzwpfIzU0Ea3XlZNM2ftw8vtwpEo76rLdEvFWCElFIdH4NKXYdtXUkKZufyqeLJymixNhPHB/SAJUKEjquzgxJ+7UYLycDIlez5oL8ylmN/ugiWSIRniZbouVMj4RRsHwUenthVJRfWNQtUKkuX7GDYWPbr4/80QgIoc1BIB9FkUVNRZL42taXJlCg8xbpx4FwiLlRZsZBT7VYORzWoXV1sGYXZT/TvjKtU6kG1Ie77kL9It/yvrXoI1By69AZCMWPgZ9IjPWTHwr0iB11K1GVSF/TRqgj5sinTADIvs6VTi2AJYs2utTE21yCFI9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66446008)(53546011)(66946007)(83380400001)(6506007)(64756008)(76116006)(2906002)(8936002)(71200400001)(66556008)(66476007)(122000001)(38100700002)(966005)(316002)(508600001)(38070700005)(44832011)(54906003)(36756003)(186003)(5660300002)(8676002)(4326008)(26005)(33656002)(6486002)(86362001)(6512007)(2616005)(6916009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M191J5jFUAgHB//SwotY8l4jaBh+EL9IHugaERRoHQv1FfDWeLy6X+SmV43J?=
 =?us-ascii?Q?oUY597a/37mnv0ezBF+TAYAIxjZowNZrsIM0YqJ1D2txxz3Bhc3vpxmm5a2E?=
 =?us-ascii?Q?ADzjDEAvg+3QggD6m0MnKpF7h6uPkL+ykjirQGUBkbzO6DKuJUQtxSYL/gAZ?=
 =?us-ascii?Q?iCglFzvZG+YwT7CQ98/XDXIjApS6efG3aFjy+o2FkRyUM6E/6WCXB/bQ8RCs?=
 =?us-ascii?Q?rTIAkLVcFhedpvfblDVYo5NvSNPaKfRX8GkVvvke5E3rF4z0xhq7JnpkD0/W?=
 =?us-ascii?Q?9nx2sobufcMt8cLMkkatMH9yoAZyMP4AyYaEyxUI3UH6eOe9k+aoFtQkRRw4?=
 =?us-ascii?Q?CpbGQmkuXUxjhWziDcesYxmt1PX61iAImRr25+OpRzgsMkES/UDxARGO0fTk?=
 =?us-ascii?Q?aEyl7ekrE2ZJsiAxhfSmPGh7uEn6yBmJZV/aRV1kQASXRUwo9VrD/XD0/ZZ8?=
 =?us-ascii?Q?MC79LvIRMV2xsZDc1AYTKldOu/4aybmxPyqLLz4RBHfNfAw4dOOGIAVowp+X?=
 =?us-ascii?Q?2pb9TiQMA9IXBHEDj/aWp6qtlReBRyM5WRNjscS99HJuZ7ySi5BEbKPT6Wmk?=
 =?us-ascii?Q?3NYDEA1xGU4jFA3oe55cXItvuic1kmdFuuk6LgIr54Hg/Wk8V8U8aYct/X2a?=
 =?us-ascii?Q?vtNwMH31QSMwhQBq3X4N2LzaMQBZfCuRWM4KzzRrHmllhLlu3y59G8pz6why?=
 =?us-ascii?Q?5/DGLrkqWMNZTR3u+C9DlRB7VnZkVhYChRbSXwgCHW9DUO8lQzx46Lm0VsYq?=
 =?us-ascii?Q?bOiS5B2CpSM7WZ1XnP4R4cCFrsKfQhH1BvDbY4Do3N9q5vQ4/osrkMmKG2XX?=
 =?us-ascii?Q?9Pm+/2UuJouRpy0kX+kYVwN2MwJuo5SHcCq7lY+cM/Tj+Q9dYgji1wfKwnRH?=
 =?us-ascii?Q?UJybOjX/dNt9TLDLAQzv60O+dtjY4BuU8Jz+/e2ht74PAk/Ln/uMp/CxV0Xr?=
 =?us-ascii?Q?ocYCmH7AbmpiB0XQuJTvAo+4C+jebkYOljk8qsu4Gyy0Nt8dbiS+lsDStwzo?=
 =?us-ascii?Q?LllZnYt5GQxgdBfSpoA0OB3KdiA78QpfoV3Jl4ySLgAa76zi6ElOtRlEgF0u?=
 =?us-ascii?Q?n1Qyy17aRfpBgMBLGt8pYNpz/54+zDwzWIQNOFC5KSxWT1Xly1iHAbNNgp7H?=
 =?us-ascii?Q?Cm/08C2cwfGexAliW2nUrsII9E5zqVbAXpHPcRwlJ+ToWXGPcF39N7RVqkb4?=
 =?us-ascii?Q?JUhSc8GghUsYqOIPfIie+X5rA7ZoSA3xCM+y2RV3B6OR52Ji66uO2JGLgR3S?=
 =?us-ascii?Q?cJ6EjKiZMZnV8ZRXzQ4Q7V/c0tVmX7GjpZLezHGffjSWNtoYMQqbOK2lrOf+?=
 =?us-ascii?Q?vVpeMdtr7vYz/VyNu8bnz/ZJFhR5Qbb0HSAhXNc2oQdY9Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <08D578EAF912DB4C8F15098B829ACB02@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f36ebeb-bf8a-4500-137e-08d97dcdaf49
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:34:21.1136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUianrde2u4ucvCvuhuCqp2lvHI4EFucn2fBIQUE4PudtOlwhbvsZULwEgxtMtWqMFZZWmfgemBvLNSt0qk9mDnm2c6gwu/3hBhjd7bTno8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220096
X-Proofpoint-GUID: zk6xefdQQIpqpJwGmhz0YwhPg-Rps9Dt
X-Proofpoint-ORIG-GUID: zk6xefdQQIpqpJwGmhz0YwhPg-Rps9Dt
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_063429_144467_C6270CD7 
X-CRM114-Status: GOOD (  32.59  )
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



> On Sep 21, 2021, at 10:15 AM, Hannes Reinecke <hare@suse.de> wrote:
> 
> Add a connect option 'discovery' to specify that the connection
> should be made to a discovery controller, not a normal I/O controller.
> With discovery controllers supporting unique subsystem NQNs we
> cannot easily distinguish by the subsystem NQN if this should be
> a discovery connection, but we need this information to blank out
> options not supported by discovery controllers.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
> drivers/nvme/host/core.c    | 7 +++++++
> drivers/nvme/host/fabrics.c | 6 +++++-
> drivers/nvme/host/fabrics.h | 1 +
> 3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1ed1b7be2812..ad01e2778cb6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2715,6 +2715,13 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> 	else
> 		subsys->subtype = NVME_NQN_NVME;
> 
> +	if (nvme_discovery_ctrl(ctrl) && subsys->subtype != NVME_NQN_DISC) {
> +		dev_err(ctrl->device,
> +			"Subsystem %s is not a discovery controller",
> +			subsys->subnqn);
> +		kfree(subsys);
> +		return -EINVAL;
> +	}
> 	subsys->awupf = le16_to_cpu(id->awupf);
> #ifdef CONFIG_NVME_MULTIPATH
> 	subsys->iopolicy = NVME_IOPOLICY_NUMA;
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 668c6bb7a567..c5a2b71c5268 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -548,6 +548,7 @@ static const match_table_t opt_tokens = {
> 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
> 	{ NVMF_OPT_TOS,			"tos=%d"		},
> 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
> +	{ NVMF_OPT_DISCOVERY,		"discovery"		},
> 	{ NVMF_OPT_ERR,			NULL			}
> };
> 
> @@ -823,6 +824,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
> 			}
> 			opts->tos = token;
> 			break;
> +		case NVMF_OPT_DISCOVERY:
> +			opts->discovery_nqn = true;
> +			break;
> 		default:
> 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
> 				p);
> @@ -949,7 +953,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
> #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
> 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
> 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
> -				 NVMF_OPT_DISABLE_SQFLOW |\
> +				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
> 				 NVMF_OPT_FAIL_FAST_TMO)
> 
> static struct nvme_ctrl *
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a146cb903869..b61b666e10ec 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -67,6 +67,7 @@ enum {
> 	NVMF_OPT_TOS		= 1 << 19,
> 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
> 	NVMF_OPT_HOST_IFACE	= 1 << 21,
> +	NVMF_OPT_DISCOVERY	= 1 << 22,
> };
> 
> /**
> -- 
> 2.29.2
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
