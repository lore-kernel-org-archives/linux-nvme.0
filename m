Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83907C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 07:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437A4604AC
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 07:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 437A4604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=d+gxrmWgBUF4zbSQFMDQ7ZaiR6S9hcCxfV/Fc4yJrSA=; b=cEZwyFnhhX3gal
	PX7m1NP/i3uX/8FKu7erT6GrubU0NCdShcTqf4xObehDMm0a1XUXThOp9bPpPmdw/QsXPFuQ4Tus5
	jOEDQqTJU8q0oIlJnz7kEwDju2GjJgs4kHIN3yyxSMs6aXEjMS+JUgtStfSXXQRIO30Z+G3FmMhSs
	A0Wxp0TBGKgI31EBA8DTLfoVg5MyGSAKbu2U8K+FiotWGy8VqPcsi9kFmvDB+dR0wMWFn+dxoVD7d
	YofmiAx0EapeVZEwZ7me8HCoQ8bf3cMLBUSqYQFB8syrZKsj5rNkIttrY7r50Pf4a5O8za/EXTjgp
	jC9h9CyZ33Z89953pAWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQPSk-008Jl6-CG; Wed, 15 Sep 2021 07:36:10 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQPSi-008JkR-55
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 07:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1631691368; x=1663227368;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=2fz6LR5c+ZMNhortDRpWljyn3mEcNAxS6QyRY7FEAJM=;
 b=mJHuLvoCpjRNtEjN5FFXQgU/UgFqTBSFKmz7Jw9tdObE9jZdOEthvwpE
 avRJdgTbrYDe2TJpcecHDWX/YFvNMtmNQt8gj8e/Bc+W6g6tnpSZcsZ9x
 1chFZfwGuml3oCldn+z4iU1MMcnqq1InCGu2iEiKFJsL99MdETEt1ocGu
 DObxO2t0VCraWAAa904LCX0jtANick/mEYgxlBNtA9H/xOtbpB3MLeZvS
 7IJPWzpePOkuqQW/u6v0rXd4oAw6Yb9YtockiskdBCGNxEydILaeTfRZv
 o/H7f1fnnJREcA1PsectDMku00sjWokpCERZl7OpapOcmSg7xbkkyXnGz A==;
X-IronPort-AV: E=Sophos;i="5.85,294,1624291200"; d="scan'208";a="283841434"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2021 15:36:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN3o/HiDv6rqm6f7l9mgr8gETJlqFKV2xzAYF6LZtuAtiWWcfQGGvOoLBuBk3jL4xqzlrB/nXVzFWkJPIiRSi2fOX4APgr97cyX0FuuxBl/q0Wgr2SBDCRTUD2upWBtsrN1uCzmqLvpLYGrJS++59qB9EB+WIBs04TpLrL8k7v9C3k1IUGikMbScJCH7+3pxj2poEHrmJ3SKdCU3+QQ7HEk8d5I8YiGWvYKx31Y0qM1uxBgVe76PdRwJ5X5tmlCtLBXwO5ADrSVE1YGItnnfafSta4cPBlbylQ/26jBotwaUPFx1lb52uOkqsembvOJY0/2svu5Vf8vW5rHJJLZ60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8iXkRDMMb+ax5EPCIdHwji3X2vWbhrWgMox+ZV07lOQ=;
 b=Tl7m70IB5sMxdrO56QA+LNuDN7MhO79JTeRS4vPV2eK2eheEdvwZ6sYxXGNf4PEFY1omgkdPwXGJK/5gxc7XPPVWm1ZKWpHAtm7Pihb8QPKXopQhhx0HP69gBKE0Osj3zQKvbM90vZk83IbWdvpNJjujx7UDFY6Fm0TGlqSxHPvajTj5cEo3ATKDfAI1ECdsfuaVBP+jkeiUdiTNF6knx1xYB03Q0FW586A/JhyKM60ckEQP3GkkNsdHq1sd3IW43vPdxcETcZlbTLCOU3QNtYIbpQnSWZLQUsSqOBerh904U/mpIKYGHVG0UXd1loKH/prgQQZYbLmsVCVNSdcWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iXkRDMMb+ax5EPCIdHwji3X2vWbhrWgMox+ZV07lOQ=;
 b=pXTpVv+pW606hbnr+95rIL/ocfAwsdWaFwbR5BMp1RIg4w57xy2qByxFEJ/SfGg8/VE3mZqrD5D/fXPCHqUOnSreSGkPUrbySYJdZrvtg/+SuKGm5cE1+nnX0JTtGktOzQwX1XSCyRZC0J7RgyVfgx3468QtXCszIViaW5GDdrk=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5657.namprd04.prod.outlook.com (2603:10b6:5:16b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 07:36:05 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%7]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 07:36:04 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: "anton.eidelman@gmail.com" <anton.eidelman@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
Thread-Topic: [PATCH] nvme: keep ctrl->namespaces ordered
Thread-Index: AQHXqgMqZnbOVkPf70+Bgl2sgXE5RA==
Date: Wed, 15 Sep 2021 07:36:04 +0000
Message-ID: <DM6PR04MB708140E359AE0511803F1346E7DB9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210915072006.956307-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbc47606-7ebe-442a-a5c0-08d9781b799d
x-ms-traffictypediagnostic: DM6PR04MB5657:
x-microsoft-antispam-prvs: <DM6PR04MB5657B2D2301A03B7FF7A5493E7DB9@DM6PR04MB5657.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qa/VCfUvV5G2TllgKywn5KQAnogBuV3o0y/k8ApWHL6pTpyRa2QRY1Jkb4KD1LINOVLBdQ0/rABTKJ6Flgp5fxAL+mkgTc5nOyV3k8ixRthnfU34JpmqYoM0o+vBNCl30vCoq4x8xfEGl83qHUbMv9U7ss0QrgDJTG7BeoLxwTuowmKSVQDeVZdV7rCKi2pkixhie7OxlepmUo1w+HxpKltJdll+g4TD3UxNT2Zs36zo2stNZEGOnj6RVnXAnREtZ7Vt2ciaKM5txU27ygPHuZgoTqEMUrDrh+TLu8ZI8SO3igHgX2MTXcrPI1gDc3Ca/88BlTbHwuvdali4XdTbXkIhVOyfGQIHR+KdTxgmEtB2/dEiQMqSEqlpRr51RLHMkszB3+Rf/1gnRCq/nSdaL+MoXexXhc5/XCA4sZoWQxKAhqix+gMqg9FCcortgaEI7JXxaZobPVT2JdlyW8UAc21oxSudE/xlStkEq5idhz6qIGXKM74rxrWm2g8MOXeALi912+7RklBQIAtHRaxfDjI8cItuoxZmTN8PBHs8vHLONZJDZc9h3CckrLQKolbRtakpafv//Ybw+NNaXAYqaWY1FARYSjve1aS0MEL3g6SMqFcRD7+zZtQWHcsY+JJpItvQxorsioFEtevFhtxvxY1ThfrbKPjN38sv5Ri3BwmAXjU7orabLBa4PePZe/nF7g/yVGIOo5oZqYNvhNJ1LA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB7081.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(52536014)(83380400001)(86362001)(122000001)(110136005)(38070700005)(478600001)(38100700002)(55016002)(5660300002)(316002)(7696005)(9686003)(6506007)(66476007)(8676002)(54906003)(64756008)(2906002)(53546011)(66556008)(66446008)(186003)(91956017)(4326008)(76116006)(8936002)(71200400001)(66946007)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/T3Q3VhDCd6p2i2s7bS2RkNNB/hg+05lGz1Wm64p3o7nU5qSZHdPocYJZds1?=
 =?us-ascii?Q?VP/eDOXfMigdI/rB17r37ETPvJylBNOWn9jcQ+Q9d25xYgreZnxuL3zdMWyg?=
 =?us-ascii?Q?NkWyfJTlmDawHuIKONBytM0vun2T+YFTkQA0gUPtb+DEJe2MDQcs4W61ZFDL?=
 =?us-ascii?Q?bXSjbNCe9KdHqjgpp8Xy6uAfGZqJidSCyISLU+/ipBFwSsBuZwedJkFI6rxJ?=
 =?us-ascii?Q?MkaextiwfnsX8C0xx+Ek+2cNOfDZKeg/P5uVvtZevAZMpGKyMVCLwAZXECqU?=
 =?us-ascii?Q?xArVt665c9hMOGA8maQ4MPgZW7593UcKoi0jNbaLhAfkc3tIt8P0qt4w987q?=
 =?us-ascii?Q?LsazPIz++nO3TkcrCcYnz+xwqBaIGiHjIY3kpkoH0IvkcA9eEqS0CoKCJg0R?=
 =?us-ascii?Q?SFhAjvP5u5WJTx/LYTyjz7CDSvBb0O2q+NPJ7c/pmMiDw2U6s3IySoNfdTg7?=
 =?us-ascii?Q?6ryHhXMJmyBxhmjvQb9ZhNs5X1ngxIKytKbXQeJ8XQtwuQDPxzU/yo+QwIc1?=
 =?us-ascii?Q?ZTB62YVgCPdUEU6MKXlTQIODTOZxu4vJ+tjXT5Jaa5tWZkw3wSyYzl600+Pb?=
 =?us-ascii?Q?FipU/0RtyIw/1pVuen6Qp8EcuLNjzKiKM63c9cdbjY1Po2GUyxuZ5QAjfyoU?=
 =?us-ascii?Q?AWZW+0m2Esq4jXj5oQZjHDDcrBOk6xXzmvL25hv85tbX/rb4s/OPq6dRLd3Y?=
 =?us-ascii?Q?PYpM/RdIU+OuLTmvB11AwVP42QkgYmh0rPSldnOez0BQIKL8h9PQznrYjvzh?=
 =?us-ascii?Q?28lx5AppGLe//aWD045RZnQP7cqtsm5yOzk9zUQyImCHrukU+rOIasZAXoPl?=
 =?us-ascii?Q?S/IrSgbCNuz0slUNBQkqAXOkBzc/NAWaIu7uOakaYCZ+7cEwE0R8SNNyL2yc?=
 =?us-ascii?Q?UjzgIHeQLzQu1K4IfObezcoKSmxSGMi1/J1eo3pIfEUnamIyATjbWkbP0bv1?=
 =?us-ascii?Q?/CG/u9l2U0eN9Lht6I4824lYqkZQIfLg1w/YGJ1igQ3stkF8aR/z+zcBGEnL?=
 =?us-ascii?Q?w434C6cVyc2hO1r7hK7dTtTuGb1ONmWPoL+hIBAEl95+aqDHyb85AuFBpniK?=
 =?us-ascii?Q?Sp4ah2FbIfmW4LuwDC74g51fCwQhV/3ENUFsja9pZzdTSILHvwLGnlstck4V?=
 =?us-ascii?Q?njEiMmmIOo/fFlTb6JWXgX1slgIwySIQtNx3IWM2GkgXiuTC2MBQrA97YklE?=
 =?us-ascii?Q?u2gSAJPTR90TH43FLVDEgGPUmzjI7FofB1QxDZKBUhLs8p71jNkldOaCUEuk?=
 =?us-ascii?Q?CR0H+WoN6ZPDeQO912RPcoT65LuQsaYfWyZElewj4zH0rWDxZDB8am9/6Nx0?=
 =?us-ascii?Q?lUKj0pFnOsi1BpNrj0sP8oirizFU+p+86BJM4WyWWCXqGw9EinJCIi9jAw/L?=
 =?us-ascii?Q?k7eUu3+NOZTyp4f8v3+a/D5IcANC85tPLm4l9MNVV0wZn2apsA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc47606-7ebe-442a-a5c0-08d9781b799d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 07:36:04.7817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FR1jJ8GThyPZDumF6/1shl7ra5/oiIhvWZZBUTq0l90JAgsIiqxolP5XyWxRkr4bP4imo1uSx6L4FLSXBlUScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5657
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_003608_306145_CA43EF24 
X-CRM114-Status: GOOD (  23.88  )
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

On 2021/09/15 16:27, Christoph Hellwig wrote:
> Various places in the nvme code that rely on ctrl->namespace to be
> ordered.  Ensure that the namespae is inserted into the list at the
> right position from the start instead of sorting it after the fact.
> 
> Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
> Reported-by: Anton Eidelman <anton.eidelman@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 97f8211cf92c1..3e3c835777458 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -13,7 +13,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/backing-dev.h>
> -#include <linux/list_sort.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/pr.h>
> @@ -3716,15 +3715,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>  	return ret;
>  }
>  
> -static int ns_cmp(void *priv, const struct list_head *a,
> -		const struct list_head *b)
> -{
> -	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
> -	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
> -
> -	return nsa->head->ns_id - nsb->head->ns_id;
> -}
> -
>  struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
>  	struct nvme_ns *ns, *ret = NULL;
> @@ -3745,6 +3735,23 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  }
>  EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
>  
> +/*
> + * Add the namespace to the controller list while keeping the list ordered.
> + */
> +static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
> +{
> +	struct nvme_ns *tmp;
> +
> +	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
> +		if (tmp->head->ns_id < ns->head->ns_id) {
> +			list_add(&tmp->list, &ns->ctrl->namespaces);
> +			return;
> +		}
> +	}
> +
> +	list_add_tail(&ns->list, &ns->ctrl->namespaces);

I wonder if it is worth checking that ns->head->id is not equal to the ID of the
first NS in the list. That can only happen for a very buggy system or device,
but that is not unheard of...

> +}
> +
>  static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  		struct nvme_ns_ids *ids)
>  {
> @@ -3794,10 +3801,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  	if (nvme_update_ns_info(ns, id))
>  		goto out_unlink_ns;
>  
> -	down_write(&ctrl->namespaces_rwsem);
> -	list_add_tail(&ns->list, &ctrl->namespaces);
> -	up_write(&ctrl->namespaces_rwsem);
> -
> +	down_write(&ns->ctrl->namespaces_rwsem);
> +	nvme_ns_add_to_ctrl_list(ns);
> +	up_write(&ns->ctrl->namespaces_rwsem);
>  	nvme_get_ctrl(ctrl);
>  
>  	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
> @@ -4082,10 +4088,6 @@ static void nvme_scan_work(struct work_struct *work)
>  	if (nvme_scan_ns_list(ctrl) != 0)
>  		nvme_scan_ns_sequential(ctrl);
>  	mutex_unlock(&ctrl->scan_lock);
> -
> -	down_write(&ctrl->namespaces_rwsem);
> -	list_sort(NULL, &ctrl->namespaces, ns_cmp);
> -	up_write(&ctrl->namespaces_rwsem);
>  }
>  
>  /*
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
