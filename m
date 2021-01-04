Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ECEC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 12:16:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900CF21E92
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 12:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900CF21E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=qaL9c8qJYUgStVALglaaucEr2dFF02BXgG7dyCa3kf8=; b=A9negAky4AI7eAYEYItXvkv98
	KpZhPBH+ZNdFyXny/HsT6aOYiVlKl2J6gM69ZBVdw7u6qTmur+3UOG9p0/6C9gJ63uFNY3G6NiydI
	7UQw51dUnKKYIMxbKtzk06ZdqTDfP5rUFbewxY8eCdXYvVeCvqNWG9jev6h50Ky3WVZ6MKMcj2OcU
	Dl9M8BQuLT4/Gek+RAv0caRjIK3i/ukMP+X62SudA4etOVARTYiAwTk5TvkjwDP45ViDTFoy5QzJj
	qZUh02l0/4/H5FGzG+YHuOFJPGzRGGgvmhTShjaiWR4DvRR2wj1aSMWnGaBxYiE9/vH9sDGtD8l5N
	dqr/+/NiQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwOm5-0003bZ-D7; Mon, 04 Jan 2021 12:15:49 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwOm1-0003ZG-BH
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 12:15:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609762545; x=1641298545;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AAD45JkrV1ppBFtHD+mZCBggwTnvVE+T4xcVH2gYUaY=;
 b=ovIZkouiY+XFNAv2R20NQrTAxXFujKAQkV49qxYS01Tjg0pJ/G9wyQhq
 RfRmo+Clj7ZWpLCucPCOCgR9JuYE8rrXZTXpi9z1tVRQ+zBZeP/3KKfW2
 dJKYtM/EA8o4DXUIfAHNmPyM4OzTnakAgm/CmZFsnD31OMHIHbv0rRXzv
 iillmcvPGpRyQ9m0k9S5Vjri2VfR5vRQp8qe8MUqvttJBNAeu8FytmyXV
 MktpnqGGh0ZvlvUGsGRel/qU327Q2BX0UHGhz4he6dsMKhA/UmuPJSMC3
 wiO0yECjAxWXkvr0L5ODYC1tNoAtcdtWmSz2IoF2jod0md08EUV+P9y5Y Q==;
IronPort-SDR: RtKuc2ZuyZbVaNzupwE5PvyxCmLuU+WI2L6U0+9+IabClFjlbyF/Q6+DYm1vREmezSOjq9XFvN
 WWUbGWCP7K+gm0vGpm2O54+GAdqaIyH7blyHachelioPSiCnqI/ypq9zfaSfJ8LlwXItun4tgD
 1XDxykqRX6zTR6g/z8vdfUFY82o2FV8lF9CBbcOrRTcC+wERkGsloNq8IkyV9I+UJncSNcjNt6
 JD7g5V+7RNVT6+jTvknojAL+t7QO7DJky1g6AzPhjD6Ta2hpqvlRgS+kpdDc3CbczDcOI33CjR
 pcU=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="156456899"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 20:15:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5zpzBsIV26UWpNZ6wktwAntCj2yNufGHNIdkw28JDOywOGowyg84WmXoBzrhX1ZtrIM/fmo3RRsjkHC0dEvTY0ri0dlpCyaQ44zEmIhb65UhWSuE33/rPJtoj4kgLu7FmA7qSZbQeIUvnGle7sop113Y5UMWCNePYoSADxttNx27GY10GgbLWrmLREpnNpmxR45JUbmqh1x7oKXCnyEdMQUnFeQ/UzMXjD0XljwIAKReuyCAhJhkAtAtruOlYjT0PLBIpiDlIQ0kzn4Z+OJV9aW4ixDZT03msWsw4q4oQZSWk4d7ygQoI/PDhizPbSLoGFhCosTqCMCqZ//mOFRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuHwa/3aHljtT5JAxaSKGm2UVXmJqGd4KlQnOmarzHA=;
 b=EGjQw1JXDzSDc6ujYpF1ALlg+YgiNaSOtqoG7bl8xrjgMmfwwQUhABwJE6rCwSoB1pCw6BxsCPiQqR5V0O5WU778e5Fghixpo2ImmxWJKg5UqgmCtLRjEm1kXl01GEFu+gThr4csJwsul2QA7EvEL6IzRn8fbMsnE4KIwqtwzaLMskas0a+YogUqbrjQAXLZGqIGnftQQRLZw/otqLWsFNI5KtG8quu6Usq/Vawg0SxrmznYoEQ1a0SaVIj8+HIWJPFRJGO6g3ls6Qy63zgCtnifLaUf121fjryVikglb6CoR5H4LdO6IAFhWc4mzDIq9v60wcMZmyy+7iJlfJ9ZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuHwa/3aHljtT5JAxaSKGm2UVXmJqGd4KlQnOmarzHA=;
 b=oDOSrDyzxd8HRvF/qnL2SYIebPOdnvFMrCmdHspHRq1HknUgxPjpZSk0fgZtFiYuJFomlxf3pfAPdXUq8ASjuSND7PophGKeUlCJUFQvDa5bar/NAEQk5iUuoCAQWGCq0FoLL2EAaBvqHX+o44VLVihl7/xD2EbYjQkbDRJKqt0=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6734.namprd04.prod.outlook.com (2603:10b6:208:1eb::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 12:15:38 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 12:15:38 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: SelvaKumar S <selvakuma.s1@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH v4 1/3] block: export bio_map_kern()
Thread-Topic: [RFC PATCH v4 1/3] block: export bio_map_kern()
Thread-Index: AQHW4ocU0RUveu4eRki+HX4FIJ17pA==
Date: Mon, 4 Jan 2021 12:15:38 +0000
Message-ID: <BL0PR04MB6514554D569AC302850BA1DDE7D20@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210104104159.74236-1-selvakuma.s1@samsung.com>
 <CGME20210104104245epcas5p26ed395efbf74e78a4e44048a6d7d6ba7@epcas5p2.samsung.com>
 <20210104104159.74236-2-selvakuma.s1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:4d2:96cc:b27d:4f9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a49498b1-7384-462e-4cd4-08d8b0aa72af
x-ms-traffictypediagnostic: MN2PR04MB6734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB67344E16F859876580EE0C87E7D20@MN2PR04MB6734.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mcvD+SBwh3dbOi0uVo6OBPyUWb6hnneXAv8JpqB1brob1ZQs8aRj3iGEtRRVqHenVb+8MR28qwcOPUiFaNkNoU/kN82hA+dH+LKH1JLyLeEcNp4NwyUvj+OfU6t0oh2m1pWTrFO1ote4OhjArx1V+IPnsHcbCGhZ9Ldg/2dWy4ekjhcA5TfGgGHrClNa9LIAlXfOKRqod9seiJnJ4zkTnSi8xKIPdbemDzNmvw9Po3bMl/nAMNlRORiOAhvdf3ClqzSq1OQPlWHikuosJgxvJv8tXFOyO1qMkktrnx71W5x7hNuiuVEXttZ6sb+2Jz/yk4q4A3/giRqoVdkk1zCVRllbvvQtDRrpyeL5d9/g6/81g4MpR99E6FdZC2TNGbYdcdbG8iaBS+YqV8Gs3CUCmw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(52536014)(55016002)(9686003)(53546011)(7696005)(33656002)(4326008)(83380400001)(8936002)(71200400001)(6506007)(5660300002)(316002)(186003)(64756008)(66476007)(66556008)(110136005)(66946007)(91956017)(76116006)(54906003)(86362001)(478600001)(2906002)(66446008)(7416002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6wfQL0CEuknbUUvXyIZHzKIh5IsLibPQ3+gAPFVG+oOTe6ZAXQx0pS5XdmGX?=
 =?us-ascii?Q?vPrXieaJsI6ntfeTQx5kZiVguM3alj0U2StYNW10qWXi5GzDYYL1scGN3xPl?=
 =?us-ascii?Q?uWXuJ+CqpAhT7KgwQV1a3Ed3Y/ck2SHj6i6U2AQ4Tw5ukIKpmO79JdsS4kax?=
 =?us-ascii?Q?28Ts6U8pBbxvAsrKuUytgjDKz8BjCll4KQmoXyd74SKPKBsnzQPCTbwvP/z2?=
 =?us-ascii?Q?pEBec0uM+bmSPAcVrkjb0OCRb3h7j3x+BecpCB6WzHocnVQCLcnhHnCyhaPY?=
 =?us-ascii?Q?Ml74hGxshtR5WeunMO98Es8dtXGFStrwjlL27AP97ZzKl//GvQB4C63trV0g?=
 =?us-ascii?Q?ozffo2VaNu4kF5DXBxKcyByiTXo+veUlUYly2EiJNhuM10dsvBQt72YYP2yn?=
 =?us-ascii?Q?dXS6l/uQzFpDE2LuLFFO95eMWCUZ+mlXY8paIjzNCOmAgkEa3rcTJyKgJs9x?=
 =?us-ascii?Q?6MvcOKvZuZVtyRc0N6AiEqXyC/d1hTHTJ/T3vtyRWkSF2NtB3mRR7RJtwnTX?=
 =?us-ascii?Q?KshPFC77LyteuG/qB2X9pUguW5LtFcHAQ+WmU2kUIaNke5SCTTjezFSHbVIG?=
 =?us-ascii?Q?7X53rgnfG8CpC4eWAnZ9tYQqqhjw+l6INiqlP6OgVMdoQfPdT7CWePBfPUOn?=
 =?us-ascii?Q?yz0WtNMr6ptfuJ4AWDKHP4QrEkkQW8G1Q0wFzeTPIvjmAIttkB+4nKgbK//i?=
 =?us-ascii?Q?BOVO52E8PAprla+GvsG6cUYYmqEJ3jc2DFBDIkTJIJo6G6pCLxpdlIhVbOJx?=
 =?us-ascii?Q?gWBSYtKLh6RK79wjhfFrjCdL0KDnboFyLn/G+JAvGGNe89wC3+hAP9gJIf28?=
 =?us-ascii?Q?UJoFlM4WlHkevAKOF1DhvllvQZoENexDfbf499DIc8LYzz6M7YYc9L1ZPYAA?=
 =?us-ascii?Q?j1e/XQbgQBST/vexFgXIxPpzjm7dVPUjEVN2/xrFcsj/C4RqQWqxImI/RtOf?=
 =?us-ascii?Q?/2jkiC30454NQcOA817tt6S7w3cTEdLxaEyla/+SnsZGD+cxL1nCOl64FvZH?=
 =?us-ascii?Q?2GWyvCzHk6xeURLmxxbjM4BMmALVL+i6gz/J5i7coTx+eXq5NaK8GoFf3a8R?=
 =?us-ascii?Q?jgZqFFSY?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49498b1-7384-462e-4cd4-08d8b0aa72af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 12:15:38.7059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSKz19corPi6dlFsrZTAHchb8Q42ljd+SX9gHASSKK0d857v0S5cGcdfRYz36/sqzDeihc0wqa1mlz+IWMCBcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6734
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_071545_657240_153C8A9F 
X-CRM114-Status: GOOD (  20.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>, "hch@lst.de" <hch@lst.de>,
 "bvanassche@acm.org" <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/04 19:48, SelvaKumar S wrote:
> Export bio_map_kern() so that copy offload emulation can use
> it to add vmalloced memory to bio.
> 
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> ---
>  block/blk-map.c        | 3 ++-
>  include/linux/blkdev.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 21630dccac62..50d61475bb68 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -378,7 +378,7 @@ static void bio_map_kern_endio(struct bio *bio)
>   *	Map the kernel address into a bio suitable for io to a block
>   *	device. Returns an error pointer in case of error.
>   */
> -static struct bio *bio_map_kern(struct request_queue *q, void *data,
> +struct bio *bio_map_kern(struct request_queue *q, void *data,
>  		unsigned int len, gfp_t gfp_mask)
>  {
>  	unsigned long kaddr = (unsigned long)data;
> @@ -428,6 +428,7 @@ static struct bio *bio_map_kern(struct request_queue *q, void *data,
>  	bio->bi_end_io = bio_map_kern_endio;
>  	return bio;
>  }
> +EXPORT_SYMBOL(bio_map_kern);

Simple copy support is a block layer code, so you I do not think you need this.
You only need to remove the static declaration of the function.

>  
>  static void bio_copy_kern_endio(struct bio *bio)
>  {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 070de09425ad..81f9e7bec16c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -936,6 +936,8 @@ extern int blk_rq_map_user(struct request_queue *, struct request *,
>  			   struct rq_map_data *, void __user *, unsigned long,
>  			   gfp_t);
>  extern int blk_rq_unmap_user(struct bio *);
> +extern struct bio *bio_map_kern(struct request_queue *q, void *data,
> +				unsigned int len, gfp_t gfp_mask);
>  extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, unsigned int, gfp_t);
>  extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
>  			       struct rq_map_data *, const struct iov_iter *,
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
