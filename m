Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6802EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 07:07:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D9D64FF6
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 07:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D9D64FF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=C0HxdBJZdhua8x/crUVBm7kAA4Qi8YWgxDCt40NV52Y=; b=WXho1qtQuCDSuJOPBUAc9kYh6
	e9SFovK1x3g1plmSsRiaHvNKvnv85yjJmiZom1ADCZl2gR5tN/F60Rb7vXBcZLbZfWeE3MO91Cg/l
	UF/zqViTUqFlAcWf5zUDa7ZrEhrle2CA/NeUkVPzfKMo70ZRJmAb/2YTcvXoeiieuspg8H52wTJ+v
	zAotlAPSha/weiKyX3q5qneIkyo2edNSFxe89cwNQaPpHHsNtkrUv/Qn6qOmtwmzXavmXVCemXK9H
	Tdig4BxebdHBGFGnesFTkgRvZkj2VwND8ucHltrm/F2mIrFRtJLM2YGeQNu2v4Cx2wZK+6psRNkH5
	rBVTguq5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJsw5-006BE1-Cz; Wed, 10 Mar 2021 07:07:13 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJsuF-006B2R-Et
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 07:05:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615359919; x=1646895919;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=T6/ATyuLXasZz7NDagwuhQMJeeE5XEOtQm6lHiELj+Q=;
 b=Wa9g0CityYSXegcjQ4Q0qXo/MhJc2TEt4ioQIOb6O9gkr+zYkNQqSV3K
 sygfJokoIrywOLpb/a72ko3MDN8nY3lnkLBsDWHYjzm0xgKbcd0OYy6mQ
 A1k1vNUTke5pemGxgQcvxWaC6ezDZEV0rBDzqz3Sy7XozWx57PSoxD1hT
 LDRhPLoVyhMX38nfC/65LPe/WMzcC+3+KwPWRkgrvWBVupW8eDJsjb4Nb
 xyrk+bsb+Ol6wG0PByMgJfXpMji9YW7NCpg+JmQbaqGM7UbiqBM4QZZRF
 fi15rKkOnjzFPVcUaLCe3iJQ22ZU71PGN5E29E2h41/yjmyD0NnOULQJ3 w==;
IronPort-SDR: bq+ihBo/V58ctL9+lPF+gMlxWM2n0fO5f7/sMDsk8VbjynKy2b9xm0RlB+L+lQ7piLOs3wnHRb
 apvGWdecfBibNh4AQ6PxeI38025X0+pE+C3iezimt9l2UoPbWmlxozyB7claKpIqW4pj50IRSJ
 l9+I1NtXyxlGA/RbIp49pzBDy/AW1F3f9hjAxj8BLutZ4t/zgQS6LMCHRcBcwZvZB6/nVHq+71
 LRxzztT+4wJtK0yZDeL33kGB8HpTDxH1IO6K1BOQQ6ckhIbqWHgL5jMWArJXvmFayeXXM1dMsa
 1Pk=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="272473944"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 15:05:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os0tBktbIapnQEBabxkIOzCu1zSTiHxlyk18jYqU9GxoCA1hFadk/giomB0tO5s/5iDFIXmbgjQzWtSylX+tjo8wzXqy9n9KKtIWqtZvvzXH5SIFs4/pjdWUkjIod5KXvWhjRMSTdX1Vxi26SNBCCBbkKY27WSsr/qPxBJiv+Fu06MTex0MrfE0wrzeVYXB3LlOLqgQkTN5lXXmhMM0c6nOtBWxySC5UX/8YzRLqLVq97C+XYTzzldqQyaQ0C3PDZTo/iKDKPDD0MVWGjnuYe5SAw4OWesIIfZZ7jHa3+LVhVB2VCLT4Biafp0KYhl915/mYR2CAwhML9NuKRz/Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7AmKTNsyArReF9LyB8jKcisNfCPP4RZvMjf3LOHC6E=;
 b=ZPv7QVdsaHTv5Nq7ClvmjRWZJivucDa0VSAoC5VRe7Z3fBDxhltNWiITvUuoITRlWVH0GGL4OWb3qqPeunkVDoVZoB6khUuAHUtvoZEF0x7FNN3idxSrWCY0prmeT4EbDGd3JVkYFvUgXXYoTKWGQIbjTHekK4L87UhbbcE0tbOWkMJO+18oyVP4I65AtZ7fLNVr9hNKiS7dymISEsvQ3gI5RCy3DiRdPUZFAvgj5Yt7EXaWM9r1OoGCbVhOrG9bObbZ/qmd9SAURgFq2Ek1OBfYAmwipdMV+o4SbDGCYH+GKtoLddS0aRm+BOozHrVtuGVMeHHHEzS/6JOrzJHkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7AmKTNsyArReF9LyB8jKcisNfCPP4RZvMjf3LOHC6E=;
 b=H4QqnLKmynhhkXKrq4DYawl3wOivpWPuOzB1+eWbG9aTM4NvMWEujxh2aunKDJbu3DSpzh/Krp1UtMuu74yqyGHkKWnQoTd2PCZ/UH8AwtVDMolPuJODTJTcqyhK8kl1h5F51nFSIEZ3fdNjPUnBCnBKXFxl3VHEg0EEyRXTaKo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7027.namprd04.prod.outlook.com (2603:10b6:a03:225::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 07:05:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 07:05:14 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 3/8] nvmet: add command set supported ctrl cap
Thread-Topic: [PATCH V10 3/8] nvmet: add command set supported ctrl cap
Thread-Index: AQHXFKDqkfFBzzzlLEWAOuIWvtRxmQ==
Date: Wed, 10 Mar 2021 07:05:14 +0000
Message-ID: <BYAPR04MB4965B3BB165D157291466F2A86919@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-4-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd52ee67-08bc-4c43-e0cb-08d8e392dac3
x-ms-traffictypediagnostic: BY5PR04MB7027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB7027FAAE2376ABB68516B95C86919@BY5PR04MB7027.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3FHM6aql1HF625jW3+5rWvfxmTSeh/sGTOjKDV88AuASs+l315WQscog3PwtNvjGWTdli6qzB9dXFx5OIuQ9gr0c/hg6Q1WD1ngkZjqcmP2U3iWLV2PNSJ5MwxwmcZZJWK8yAXBS0efeQqlA1yw7jTKWBrWMPzwk1hR3xE1d8FGj6ykZ4OK90I9GsFg+hi9FpCU+m3OxH2jFPhtFICnUQ9LbaZEQ3dXX47ZrIw+r4i3neu5ppYNAH3w0Md1eQaXb/iew7P/h4BWWZKJ2fU0Lbw0kzJHAxm709nv1tn4x6K8+2qnj25IhNzxq0i6JTXNtmN+eeJOECiXM9a8tDkO/qhIkuNyLKUxbr5tacJGUwa1u4yEbZ0qIhE71h4DsdCl/S8QeHnCPUJur0VLEgKbsLNucjq9BqXnPZ1yjLwXMFmGMWzUCDYGHDAyhd9G3w498mqtqt6N7eS8YSzFoIxZRs3h1W+2eRPFXFXCm8ayVyouwx/1URF/VbzGK1Ra57wSwmXg2RPB14UNXdXE0RBznpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(33656002)(53546011)(66446008)(26005)(478600001)(316002)(8676002)(9686003)(64756008)(6506007)(55016002)(186003)(71200400001)(54906003)(8936002)(4326008)(7696005)(6916009)(2906002)(66946007)(66556008)(66476007)(91956017)(86362001)(4744005)(5660300002)(76116006)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rX88nYBVC5pV0dQ11wvlZ7hoa3lhy/B8KeOauvLbmHgekm0LmeKe/hnFCqLM?=
 =?us-ascii?Q?CIfq9o2m3ofz4DUgbrmYLGZWNhV6eYbpRqIEgP/oIpitVXw2NVSwP90fh48l?=
 =?us-ascii?Q?6/1igwU1CY7XnnK9vWnN8QwyWfs+4Oun1NvpepsMzIck94LQlH9yEX0ALelj?=
 =?us-ascii?Q?rLnZCVvrLw5b0hHm4g1QdWsURISm9lUR+9hfH6qmxlu+Um+An3B3cOp3cE27?=
 =?us-ascii?Q?orECnJzbd8HBIAxwJtW1/a3I+9UceLY3fLxytaaLmPmJQO4GnjheuZKnIbDt?=
 =?us-ascii?Q?zSMflMedItnUC3GS92smrTpWiQTabeOdOmIWdujKIm4FxOGxhHmFYjHxCSfa?=
 =?us-ascii?Q?L7f7p3ykniRw/kXSoD/6l7gncLoH9y4hAfjAMfUP8TCZn+vrU0td3MwCG81M?=
 =?us-ascii?Q?EIkP7uN6ilkZvvaE+hCBy+kld550mEGYpVrKEcsViuWvFnXT/xxe5bXpnBZu?=
 =?us-ascii?Q?rGQIWqsrvOYDlBv6V2Qab40Ss6cOG0ZXlDIQj83mTiXe5eMz0KV5AxaP962W?=
 =?us-ascii?Q?VP9kwyOEZpP6vw2PmTzMwPBTrdfdHIQrP5jN/LurRBn9F5qNpMKHRESMVemC?=
 =?us-ascii?Q?86xaL37cLc+EaSHSsnkXQo/OXc9D4v3PZAZjPNKgtjbzgQE04j4CaYKlkpKY?=
 =?us-ascii?Q?AjfSxGY5hVFxE8R0z4R4w1f8UqH2sMmWC4c+v+v+17/bcW/snkzNyFjc9KDd?=
 =?us-ascii?Q?gniXIEEKnAeiotIdXXSe7jlY/mX9enpZzyYRxNMZDqzfk0f9e8FvBOHcSWOK?=
 =?us-ascii?Q?8ARai8J2ew6gV3pyz6g6W1/ikf2yYhTonC/6WYAEsxRTT6YUVjPDlKkp1Q7I?=
 =?us-ascii?Q?mybS2+5hWHqk/kG4V6EAWBJTagcA+D2MWHy8Q+b01lwh7zu2CF5wIJ4BwB5m?=
 =?us-ascii?Q?B7Km0f55SkEJ5uetyFB96W9D0utOL9JE0HmCZ+v7tFM88ID7ekFv2EuIJUrQ?=
 =?us-ascii?Q?hcauO8DskoXA9ZEePA8j4TT30v698nBAmHg5+axI5Vys/0eE9QI5vCJb1L8S?=
 =?us-ascii?Q?Qty5UMriW4EuxQCyvYAvKO+jxi4ca4ec/LPiCRsZpwWxZKKZC9JEFUFh7atd?=
 =?us-ascii?Q?Aep+RJiVxQ3O6nlDadQozNTdo/nPlu1qw3ZKuLqsxd8+jkbDMgKEpjbvcEAJ?=
 =?us-ascii?Q?2495cQ5PhPXuDAxUY2ndL4tbvrVn/kL7qnvC/VIet68aL+ZB3sEwl9YLEqg9?=
 =?us-ascii?Q?ORyqgJtMUoyxtkd0+Y3h60gcoYxYtXlejImcArqKl194kODQ42wZ57FibdxV?=
 =?us-ascii?Q?4yXQSgSdrxfG3QfQ4SKqCihPV5Jr8S1MklASaLjDQUPhdHopWhib12/gG0Ot?=
 =?us-ascii?Q?0YKa4SM2/GgDSGx6ZrSvYYMSEWEpYVA5vBVS7AnskBzi/g=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd52ee67-08bc-4c43-e0cb-08d8e392dac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 07:05:14.6456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XOowk8kSbqaCbbzO8M90O64MpDF2GeHqIoVtRL05fXrlYo0i/h+4nFQ3M8iEEoxTqYhn1VDjavCw1eiwxq8i7PK/vJNCU0ajUj5Hj5KFCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_070523_024051_3EE1D32E 
X-CRM114-Status: GOOD (  12.38  )
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

Christoph,

On 3/8/21 20:58, Chaitanya Kulkarni wrote:
> @@ -1174,6 +1185,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>  {
>  	/* command sets supported: NVMe command set: */
>  	ctrl->cap = (1ULL << 37);
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		ctrl->cap |= (1ULL << 43);
>  	/* CC.EN timeout in 500msec units: */
>  	ctrl->cap |= (15ULL << 24);
>  	/* maximum queue entries supported: */
> -- 2.22.1

I've completed all the changes from your comment except this hunk.

Based on your commmet it needs to  be merged with patch
"nvmet: add NVM Command Set Identifier support",
but since it is based on the BLK_DEV_ZONED I think it should be a part of
"nvmet: add ZBD over ZNS backend support" patch, any advise?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
