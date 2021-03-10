Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20178C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 01:15:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92C8650F2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 01:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92C8650F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=1c6GqAj4yXMSH2q+1rXnV2Dvz1nSd5pMvK6ZlNm8rmw=; b=cDEc3wAlaLjD2JDNSpsfYJvgJ
	PQfCz748R0ygWNHN4JlTBdB+Bnn5xUyzNps8HFkf9d2ImGGg0oJkNA0Snr0LesT2FKPgKQ8mllEAZ
	0UlFBhWOHCmxu4vCckav63n4E2QgRBfaz7aHTzeas1VMgigVDBbVUABWoV2jSkTyzUTWC+2mLbTK7
	SpIbz6x7c4YFdgHxbUmwiqpZvPsKRh1QH4stXubSC7zIfOnoonOLhkzKS19i3w5F3EcCqYEiBwqrs
	a8IlEYbLDB9Hh6jC+D0hQp4jh61yskApOojvx8fUQumQYC7yWvOIGl+MbHJ/adtYG2SrGvXMOFTGB
	c6RPEu+9A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJnRB-005jdy-KY; Wed, 10 Mar 2021 01:15:10 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJnQY-005jcH-4S
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 01:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615338859; x=1646874859;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=xj7VF9mUBUCqWAREiFX2JUYP38sHMz94qO5yZ8GoljY=;
 b=fXrPIv1L2vSYHEXWGPKoIijjHwX9EL2JFBj6WaarHJtiXr6x4z6LWryo
 Ct6eZp8ALAnAtibG8ahvY8vZDhv58XGnwkqPxjyPE2ft5fNlPd0Gtutqd
 eRKH0THZoJAZf1GR3w+vTyw6PWRR88XdqWNHNPfRIX5CwJDLI5gWwBufT
 MPC1usw13kjKnnnLJV3rY2A+v4giorPQsGqOqEKXWdr3nZBOoAs2RNXys
 +ojUiPiPIUlO6KUDvWOESfZkF5YQR+PqBFCMs61/6zC2s3LR5I5nkqwRk
 eFMLJvSmmXytqaibxmUXq+1n7HCGOGauqdpnmRToWv2WH0Fd/WLZSKit/ g==;
IronPort-SDR: v3vir9BAkqfd8/EzTKAuCWT70wTbJ3CtejNF3ZlA1KYEuO+rP6gG/FVZyy6Ty5aWzCPd7ll3VK
 uxNGV+5Umiu1R61hxiVKAzcq4zP3my/PcpYxUlfvHQhiMCgMyAQlGQHR/x26VueCoEkP2RbnKJ
 +oaEaMgwyuyFZKQLrwSczEv3hc6fumIYRycjnqGFLelYcex6zqd+5wvl7viTPVYZAoZYTNOeM9
 so8wHZPigONX/Ev2HpTeqlNCW8Ywmaqd5Vd915C8ktmrfxHkNL4pCyiU/tq4x0vzvxB6s+q7JA
 keA=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="162931703"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 09:14:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHP+P4BdNjY/0DkjlsifqkNzEHhX9AQvYieA0d0nWfJDo4WDUUsod8fPOkNMlwLKvtv7YfWHf9guE74nZpyedAqD2X75E5dcTvgcmnoJb+I/b6SDmKnUmgjK2vq8lf9hnGDmUXdKlp/Pb+jXbi6kVZJ21FMUEosu84XVtpDfPSvjj9CmLxdd44I0YfMRInAliGV6Bvl86xIG3lpNhlfEZdqALSvLZpIt4HLwf+dewfZcFp+7V7DZoh8Wb4N5Ro2Y6E2UAlhi1+Cr8jiCmLLYCk86wR5TgraOXQRPcK1mzTG0MCkf9X45KMnKrj/PictPZ7ZHsZp4eTTowiIOWJ70Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdpEv+yuNdOPHbwVylBdMf39v14xFaBfv/EoHrK2Pxs=;
 b=Rr/jDYVrVY4ps2dDXQdvv9Q3L0OaoEL0jByWVhp/e5jbjixifiwrhKs8iiJBy0YI/iBBv6T0clJ+kHqu8EU7QJf3NEi5fUvzI9xIpPHTcbIx89hHmxkeBvjQhb2Wj/edMgaP3cKE5W/7mCZWCX/A4qrBq/Crixrr7IT5bfr6CZO0YnYmbN2fhhwZPYFkggOORzI7RE+/DbWQ1PuZNdePFhIcOln0pCYivWKuJdm5MTJ+pd327702n8pJDwH9wPs9FweiYbZIRhzgpx0ENRq8r1+lJgi/5u/3mzwaCz9z5iCuJFq9H8HavaYx8VvU8OD+XI/CdnNBhEpWBSYbh7T2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdpEv+yuNdOPHbwVylBdMf39v14xFaBfv/EoHrK2Pxs=;
 b=K1J739ouf7S8/H7vKhLSWJKOjqTExkgXiR5pzUZyTuDolq5dmqQlMYehIq0K+g2ywXSkShvy1X7FKBJT84/gDYtXE3ZR/mukTJ41Z1Fd2kTHlfOU014BE5LlFWuZKF8zdkw6KFY5qLTaTLrSRbCUhTSDwSkRxjke2EFBAwBGgQc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7694.namprd04.prod.outlook.com (2603:10b6:a03:32a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 01:14:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 01:14:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 6/8] nvme-core: check ctrl css before setting up zns
Thread-Topic: [PATCH V10 6/8] nvme-core: check ctrl css before setting up zns
Thread-Index: AQHXFKD51fPZpYdA5UyYuEhfzoDMxA==
Date: Wed, 10 Mar 2021 01:14:10 +0000
Message-ID: <BYAPR04MB4965064423066F535ABEA9D986919@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-7-chaitanya.kulkarni@wdc.com>
 <20210309114204.GE9520@lst.de> <20210309150324.GA14966@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a76c301-f325-4a5b-6d80-08d8e361cfdb
x-ms-traffictypediagnostic: SJ0PR04MB7694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7694B8A82711512DCB0C2ED386919@SJ0PR04MB7694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzmHvQIDzJ+mLxumbPdtzA3QKPhU7IkEpleCj7QozxuwIVeAqnA3nZEpJBcfO4UfHmknTLlzSGj78ag+48GY8DHJJDmg6dF7fCjXc84y2CXOxa8jd4ZUCoOPaA3DPClVwaOOrZ4yoBxbEQe1/q0HhjrHtm8JD98Y/2gLGENwo34lEvLpO9+aEmrwYgxKC61E9a6gFNZpyVq6zBjhY4wMOVrApOMCZdg1TivoD8YjdA/s6TCLJVMCGJD3tMywRLMPTC6Db8IJuVUtTBAiZ8jcKVnJ+eH/ZIHmjkd5X0lNYu/AwI29AfCbnrNQIzJUgC9+k8r/cNwd0K7xKIzA/+WUMOu9uhtPopNzxO8RwpK7wzayVWdt0EJZ3AuUST81tt4clCTy/jtGmCucRwOyO3WVzhxZhNmJ5ibAKPacxkFnOhJ8b3Ymny9Z8DcLLQN9OOlAFelGZHfKzq7uvLljD2EnWljlQHuwGpNYrSRvJNChH+myA2ki3yXLAO/6ALIsmR82tzendfeXoSItsUvj1YwcdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39850400004)(136003)(66946007)(66446008)(26005)(64756008)(66476007)(55016002)(66556008)(4326008)(6506007)(86362001)(186003)(478600001)(53546011)(7696005)(52536014)(8936002)(5660300002)(83380400001)(6916009)(76116006)(54906003)(8676002)(33656002)(316002)(2906002)(9686003)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ldSR7a/acQ3mgxjLgBuFgay3pG/70BtG2GKnaNzt9v22w0Ws8Jmh24ytN2zl?=
 =?us-ascii?Q?xeYBEBEkPUOVLxpObMHwvo5aAia983yokuqn0SOw1EcP7h4zcQs2m+hyau4t?=
 =?us-ascii?Q?eqTBFewofurprFVsWnRNZcUSVpKSmo0c42FnMioMnANrGyi8WYeTEH1YEm1x?=
 =?us-ascii?Q?utsQvxCqpKv8C4dBY5UJvx216lkR5zltGGm7CiqAEedn0hZY4Llru0MyDn1x?=
 =?us-ascii?Q?KHz3urCnq46r3x74wAb/8RP4ret11P4q+J/1d76fNUn7CuezJuXSkEadz3YE?=
 =?us-ascii?Q?djj0MyVm+2S+QWs9YNusrmY9B+70rPoCw4l4X0izCmIcf9QSPWN/Xb3HYB8z?=
 =?us-ascii?Q?pZqU4EhG32jRiURKju1joyVrFJLZcZKXn5WbMxLzpOoVGqD3JgSCOcanFrVE?=
 =?us-ascii?Q?+nuJ91kekJSA6CZh/VlPE5u36yIa7c9mkRbvjnwpRvB2/j8APuNvYkT0vynQ?=
 =?us-ascii?Q?/GRjNpvb1e90015L2+PUTalwl+fhghzYYV3/FOv4TSsvaWkwEfpgwDAzvNdX?=
 =?us-ascii?Q?YuVcSAeGhdsD6+fXN52ogykJXZFabVLqK/pxtX3W4QQN9CeHcm2SGZ9i5E9O?=
 =?us-ascii?Q?1QMZ/5DswM7r90AiddIF1SJLbL76DayUZnuRi5Kycqxwt8zkN4AvCrKS77Qd?=
 =?us-ascii?Q?4X2vtyKecoxsgWJGRX2Ds8cTV8euUnC8I7f4t2/Q3g3sImq/sQI+r/M7N1Yv?=
 =?us-ascii?Q?R3Q7wejPJKtmlZFx7IMyXrRPunkmfrZEmBmb5ZGZf/Q4vx/73S2cz79gd1Oa?=
 =?us-ascii?Q?KbpiDs9mQfqqeZnTGFIv8HyP7pbMKvXlXNO52hY8xjtUskWyDa5UBxQSqc0P?=
 =?us-ascii?Q?l2uV8X6Pr0jXFWDc9rwD64Me+eHBmSrdXk0MSs8Ct8L1uW7JQ4Ps1d9w9qiq?=
 =?us-ascii?Q?JZMin22+mpZKCPeCPihweeAVwqrPmVMLyeaOJu2aBgH+OVtXhQZSKgOUUXF4?=
 =?us-ascii?Q?OMxjLT9gogSpbAOyKFZEv/3Yf2TnZ10Wb/Eiy7ihW+yiFuOAB88QUFw8L8FC?=
 =?us-ascii?Q?inkQhSj5sjg7wuVFnztAEzA04O8OQ4PVnl3eEUc/aTofUS5a2X1rsSwKdybB?=
 =?us-ascii?Q?b32+6TR009Xrhmge6iqmjMt4DykbsSAEznNGrNxiV7DnW0JVpWktv3CNRtzK?=
 =?us-ascii?Q?j3Ys6cDBAxN3L8YOsUstOdnCCLYqv2wG/IfRY6BCe8NWpqIcV0bY2+8gc/i1?=
 =?us-ascii?Q?vvIxXZ5FxMdfZvY8NK4wQOQ9I09Ztf5gNGyUgo/ZB56tlLZvFNX/dl8c+0II?=
 =?us-ascii?Q?XbUzqPkuVZs+nnUgJGXUQzFNy9wWn+f3S335+KC0eKNkTLYaBq7xpyoQa5Ye?=
 =?us-ascii?Q?rcnYDQ7jt+nBSEMkj4e15fvI?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a76c301-f325-4a5b-6d80-08d8e361cfdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 01:14:10.9673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/GVlaHhgIbq0iF5X6q2bV+06qQkZkYCPpX5ZcHjlmva9w3EYOuGzw88FS48xaaJSWCE4IGtQaHz3X90r7K2nSWEv2vtmROu1y6hcE6iRSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7694
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_011422_983721_965BEBB4 
X-CRM114-Status: GOOD (  20.72  )
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

On 3/9/21 07:03, Christoph Hellwig wrote:
> On Tue, Mar 09, 2021 at 12:42:04PM +0100, Christoph Hellwig wrote:
>> I'll pick this up for nvme-5.12 as it is an important bug fix that
>> might allow not spec conformant devices to slip through.
> So while looking into applying this I think we should move the check
> earlier.  What do you think of this version?
>
> ---
> From 43b82e21c6ae2f7d2d99550cb348fbd08610fa06 Mon Sep 17 00:00:00 2001
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date: Mon, 8 Mar 2021 20:58:21 -0800
> Subject: nvme-core: check ctrl css before setting up zns
>
> Ensure multiple Command Sets are supported before starting to setup a
> ZNS namespace.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> [hch: move the check around a bit]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 63bb1da0861e9d..82ad5eef9d0c30 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4096,6 +4096,12 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  				nsid);
>  			break;
>  		}
> +		if (!nvme_multi_css(ctrl)) {
> +			dev_warn(ctrl->device,
> +				"command set not reported for nsid: %d\n",
> +				ns->head->ns_id);
> +			break;
> +		}
>  		nvme_alloc_ns(ctrl, nsid, &ids);
>  		break;
>  	default:

This looks good.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
