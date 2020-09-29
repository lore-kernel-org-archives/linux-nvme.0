Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EBCC4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 22:00:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3EE2083B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 22:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o1exQENO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k0muix0b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lebxqZNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3EE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=glAZpMCK90fd/vWMiuPW6PFnK0QQ//4cAoxp0JHmJ+U=; b=o1exQENOFW8rProZ6kba+Tlrk
	hDWKKYFDt7omGy8Zhu5q7i2f3r3V+jIkEe4W0yqMCwnl90A8/RDQCgBCEMgIZIczHjIIgJjfTEcFl
	MLfEtC/NdFUryA0h17NIR5IY2cfH43NNmceUPcLP/9PPPXfJ1DLUKIseLq+9PwEeNlwaZKVgwTxrA
	dAjSnLhpRRaLKUKrej9ld2T7Ifpi/pRdIDLu4Wu0OolL0xewuG8yEPgFAHKdP9Mq3QECiI5L16BMq
	uCSveDLIiLYPaEEORIHHqqi9QSWhzIC6QUvQdSFomsfE71oS+2OUH9mJao+WFM/R3wW3Dh6bKDpgR
	PZsh5gAgg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNNfz-0007Rl-Bh; Tue, 29 Sep 2020 22:00:47 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNNXo-0002uW-CI
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601416340; x=1632952340;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=cHudAESbK/+XM40ddfpz+QnT5xH+IXL8S1nFG6vPs3g=;
 b=k0muix0bWKwzQSDHx/FpsH4kyqguCSTfohV3khDkAIq+u9mowTxlDCCM
 dIqYNhs3yaTV3mTeHeINy/0+4V1WpQ51VG5BfKCg1GWCxEXnEdsF2em/U
 69dhGFtDicJKbCJMEIkALXvH23iwGbvYJ89f7IsUcOqYMxafy5PtBvOpn
 tTY77XBhHKSD+I64OQDIIDeB4HJCZi5TAb3pDF86w9bIeGuUNL87NsjuG
 lccE9HCcEaVzr+1nqepA7xdP5s862aE18DtPCRf6WRKZYsWSmsfXFwYvO
 MOm/DWLLuDts7BcJZTt99cTOdzcEJZU9Let3B3v/GDqpccifAs+BqStDd A==;
IronPort-SDR: CNHKHTjTrHthwy0qaE8cx3NhZ4QyHTru33jcpJGt1/DcUgI+vd52fIBlFNTeLg5PKbL8ys8Ch8
 /Ark60gY5ASQB7gFWZhKPKfMJA+d7TKv6I5vxLuDUkbaVIolG9K2c/KCYjWzuxMWngcePVLRYJ
 V3yEkQ5rOsE1Urn4KFRGi6dt92BxeRb/5+e/qv3NhbFW2FxGZ42I/WbZhdnICe2wqDromk6VrI
 HEV12+2cBtPRDqW65db6+MOy7llUI3THNhre2or0cQqvB+/xBAR0mWVOVlsjKq2oFVO8V2vEWD
 Agc=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="148622695"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:52:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjh94L7vq2zzWi5mMJgmyfgLXcBQYDRBIhNmtpTxG/hzL1lvulruNa08i2HMhLXw9T2WGl9sgVsjnJihYv1PXVDX8EA13trCQiGPYMit6TNNiZwGC2iIHNqZtLDuR7SOdh9Kzv9tkswkfVBHzrkhAQzDw/vFXeVshEU0sa9Xgb86kaFCMhWMc7ak9L1uHWs/QbgYDbsCrtl+fHg5tCKLC30PHTratQ5QrsVklDcD6Zi4l7jZXELSxUwvjXiORzdwTmddUpgMmvZ5VW0LgBubf8rik2AYZOmdyy5rJH3xnlp1TSOe0p1xg2drZkbDBqr7XnZqM+oLLn8xhoxPvjcB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgCmWbi4da5Gq1TV66AcobE00uE/JNkjFPJm0RgPtTA=;
 b=fVlQtIDL1UXl+s7Jak1wd+tGVCpVqfOCIQaZ2Ann19PX04M8JLE9alh/+FBevrrXenVXOin7mZSEN9QkX//0ngdh3rflY6jvsQSV6gT89jMfXb8+qhaHheteNeuuHdvtRTckjsfBxxkJsqpZuEIgeFYDKZPnAofnUHKaPzPuwc66bTp4SG2iyxEqbfDih5N2SAXS8AeWkyQPzHa1jQGPMvsqi25wbJ3sllCQhl3jnUAzDy/CuqCM0qqebbl964Ytyiy1b3fMKh1ItNTKThkMQmFTvmaJ6AbcbvLFextd8SvcC69GSzKFqN6vblDjPnOo3m44jpUDOCzFD55Ea9WTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgCmWbi4da5Gq1TV66AcobE00uE/JNkjFPJm0RgPtTA=;
 b=lebxqZNAyQuJyn1gpN80ZpycpCa2sB4EdgZ7lj62Y5UL6GAZmIsMLWzjOMmGxJFC44WwTsfLQ4l3VrqVjFgeWmFNylFGyWqOQCa7n3UkanW5fsfmBCjirK8KaGi5P4k/r2Ggk6JipnsG4igLpCX2qFd6tl1yBwATu0n3DvRVlck=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6280.namprd04.prod.outlook.com (2603:10b6:a03:1e2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 21:52:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:52:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 13/20] nvme: set the queue limits in nvme_update_ns_info
Thread-Topic: [PATCH 13/20] nvme: set the queue limits in nvme_update_ns_info
Thread-Index: AQHWlZVyW/qOEImTZkmg7w48SVFacw==
Date: Tue, 29 Sep 2020 21:52:17 +0000
Message-ID: <BYAPR04MB4965A6DFE5D488DDAA31876D86320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 777187f0-8b65-4246-08a8-08d864c1ef0e
x-ms-traffictypediagnostic: BY5PR04MB6280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB62808A7D80D1907667A3CB4386320@BY5PR04MB6280.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5i9z0b3plNhqNCWi9Iwp7Vc+DSl1Lz0Lp2ItyaF7OCFCp0OL4BbngyluUo6sRHUpbL4ZQv+pIUfPCy0B8GvCkmlN2hnZBIm7FYrJWkVSKPp7w+mKpIVcWn3RLbaalbDbqJak5qdEE1FyTPAGyI+271o7deJe9vweYgoqFBnlOn5HRbsX/B2Sr27KANkymz+DPRNjWRX6bYCNJBGkg6uP3Of8mgIHPq6ZeZN2SXYEwhFYTXe7O0ApFq4yi17nkEL37ohnTUJmLDatuYMWBzl2B/HiNbqvF4NZZ7/M8bGeW+NWXVY/EWbzNwrIm5xCI2uiJD0WvGLg518arYxqLw3actJRovO5cOutLdN4pQNsSN7ThrzZ3rGJefEK6sRppytp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(186003)(83380400001)(5660300002)(66476007)(66946007)(64756008)(66446008)(66556008)(55016002)(53546011)(6506007)(26005)(71200400001)(86362001)(76116006)(8676002)(4326008)(52536014)(33656002)(8936002)(110136005)(7696005)(2906002)(54906003)(478600001)(316002)(9686003)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: L4bL3rNjdzCgO0AYxV1x9ETQTafzDkOJ5bxeVMmMKuzOu0IlGrvFFth2UdO6zz2AOSayQlHS2d9zNdt9jzGmzGfFTsCdYKcEDUjO5LcOc9OEOMrOTM4BZKn6BjXd2sOPgVZZsuV/2KZm8jVs8YGrv1TOFG4jYkY0SWLlH1ayc5S4oVSoGeKj8nD1QcNRIT81nP+51RHsLGh22f5L4INkCqrj8mbywvJgg8ndH/AWkCFFELT6eRxIIDleLeijeKVv868ZgaT4zsCDOAzCc5JDdxuEcu07ZrZ+e7fJXtCBwbRj/WwSiKGjNaBNMVOxaIwtHhsB/vXe54Bdqp+cNE9bMEOSA0JfxEKpjKbvxhJNqXsLPkYPrl/ov89eGToLfaV302DSjUKpc/AR6pIkNyqrEzzdVVgEwq9FhUwfZi5bvH0uuv4wNO9vpQ2AEQFKVYqZ3N15DKv5tOGCq8OjzPH/Qw1YO4cQ21UJA48m7PM8F0qjTVJSvhaIWll+s28hfuLGcfAJqxtf57hxVWSBoMtlTHYMnZXsFraPCEmN+L+lfTQF+xJ9+/A+VoUqSvZS++hqdcioInm03jNmSATV/bKkxMps+qmfDjqrwbg230APSwLRsdsJDCOHIp/1A8awcNiIBg+q/7GDWw/DuNS0/m6N+g==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777187f0-8b65-4246-08a8-08d864c1ef0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:52:17.2946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DLcW/2j6ftdPsfH0QtKg9bfkciOCQZsuIlWw+VI8GvgNVHq8ysxzdhxZOts7uNAavJkG5pvTHAdN24DiY7pQMzz5fqqiqbmYG9JZcIgYO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6280
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_175220_585651_FB9E7E05 
X-CRM114-Status: GOOD (  18.82  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:46, Christoph Hellwig wrote:
> Only set the queue limits once we have the real block size.  This also
> updates the limits on a rescan if needed.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 46 ++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 910198c3e0bbd1..bb630d5fcb9647 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2010,6 +2010,26 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	return 0;
>  }
>  
> +static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
> +		struct request_queue *q)
> +{
> +	bool vwc = false;
nit:- If we are initializing vwc why not :-

 bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT ? true : false;

and get rid of the if before call to blk_queue_write_cache() that way

all blk_queue_XXX() calls will look smooth.

Irrespective of that, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

> +
> +	if (ctrl->max_hw_sectors) {
> +		u32 max_segments =
> +			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
> +
> +		max_segments = min_not_zero(max_segments, ctrl->max_segments);
> +		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> +		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
> +	}
> +	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
> +	blk_queue_dma_alignment(q, 7);
> +	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
> +		vwc = true;
> +	blk_queue_write_cache(q, vwc, vwc);
> +}
> +



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
