Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4B7C4741F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:06:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58910207F7
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z3pIl1e1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="czHmUMvq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aKfWOTu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58910207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=u+DnWgxa3mP0BQU8ZrEhciAxhMflB3JzBFYZup9Ip3A=; b=z3pIl1e1M0kVooW+VYQ1LEEvM
	A9zJNKn/zJD9j6f0kijLcFkyPg/O7pw0HZthGL0ppDYSKOLU0BMmImsGglmVZwM6CR2XoajCqGQg+
	xfZBXS1UbV1gYMhla/34SiVU7TvSP1pGKpkUbQO4OC41IxANbsJ363n8t4VmmSLPWAFFAdDy1dMpd
	gwdsFXqraCKChAWs1p6AKn6gURotHC/tSkZO53wWrIr9vKZvhA4vq4YmDimk/nnF7OtOaT+3c+fZl
	4F6DNkROqQNIOxiB48gGyoAmsL0erqtAyTRvBWQwPUaCfImL/yN4ogQ7hQ19N2nuRDjPw21JQGKd8
	UJ0ncMAqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMujM-0004Kq-OF; Mon, 28 Sep 2020 15:06:20 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMujJ-0004IZ-14
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 15:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601305576; x=1632841576;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=JakE235vNu/wlStAEoyMl0hIoUef8kDk+yMhRYtZrMo=;
 b=czHmUMvqSqQuAJAcKhEfXgtpw8n5Yq0vn/1ZrZ/A7OmOQnLHv1tuufZ4
 2fJRBkFkZ78S6TkobJ5/re7wNkfgbvJ3MZbUETA3FtpRWPyk/fbuAVa1q
 36Z8yxaC+c748tdWuGJAlMjdLXY1jpG963rxEqELLQOOYgYWnuhfId4GD
 oRdDi+rBfirk7AHBMYE4sA6U/LgqVF07Qo+Vt84TotDKFJ3S+4jf2Io2G
 MW4R9xaBPj9cxAJaj6boq25YoQbVAzGfrRTZceoeIdb2R78xmgVww0u2q
 ykKKM20EfuxYsAdPLH+BYg5yLeQzLwfgXJBSmPrLIqux5XPswmWStN26h w==;
IronPort-SDR: QprKEib6Exrcw88uGMsK67r0ufiVy60Ko487R9wjcvLsPvyNJ/EjJMo1MULaxG4a3wdvbE4s3F
 p68iY4nEn3WclBoZjMNLerryyCZVpWfKcuKW2w+b/myQ7iDfMenxRc2uVLXEDPdqGS6cA4YQ+O
 jQvEaPv59b47iqeyk7GnbZMpMyGtkktBweVbvtbURa5BnAhWlYV5neUeGDu6skrKCqxmDr8jDF
 oGre6g9WjRRAME4ek3eDN0O21F+OKQFyNaS8hDtO9jxyoa/1vppFTrKjCH3kksDIfGIRsjFudE
 sRE=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="258173735"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 23:06:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmGT3bdvALfhqsPBXYoft6n1QoZZuORJgYNOebHf2Tq2sP3B0FFcgiRhQztL/ASP4xhWUYutrJNhJzyT5fZP85LP7bd1/LCRmucqvNUxgDjJmoBAbB7e9p2iedwUNJs/z+JjlUU0FDEdcvUmMgxx9yt0kAiPqkfRKzX9dji/HeAFOof9UwF6Yq1lemxfTLz9hPZCOECMHPfoIV6SMBM7/4nAfTHlqQ6X8MNhDFsa/mflY4fbQgG1GbS6Lna/jU+k2XhSUkkxm74RQhJ7xlnQ4AJh1kXNPPhgyg8SIjX8XGU4xz1VtLwgDU0ru+ypSWNPFToPRb5vQz3QisElWXKYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsnttcsx5fS3EJizXvP/A2Mq/J1XOE5JUcTEsoF1jQo=;
 b=Oyr9ONqLVA9j8xZxha77p3IXhafJOnODwUUJMs8sTKzLEFXddQJNL6HCXdc8HbrDzFmycsFBMpKaol2uTXzejin/G8i5we6CnTC+V7K8QHT/vKaw4v1kgERAkgH+hiTQHRAgbRlm3fceQh+a1V+plxEBuoLp1JhiGFZrt/t6pU/YKultbTIE7s8GioEEk51GE0StnbVc8pH9cR4L3MeA+sreSPbL8ub/7iH4Fp6Ofn+EbPVgzHehoC+SAmJUXf2zerXrKtcw/gBtErN2SmcwCxfjvNjLY6RnNA3WQwL8QG0ceblwJf1PZwsDi4Gnns5hfYRHxKFqI8m9Pj2/bqR7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsnttcsx5fS3EJizXvP/A2Mq/J1XOE5JUcTEsoF1jQo=;
 b=aKfWOTu0bt9P92aPfpJ81Mga6sXXyN6QikNUZR58GJ99tPrFLpK3JvV6j+P7xn3uXgCy2VKPSfo8ZU9D7oUljyrK+qRIV9hj/Hh0gFgIBo9/x3kplBczgYlzVylVhrQ7EB6JcSlxAkBLp/AhG4oEzV55DUuYe3ZJSsK4HSCk25Y=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0425.namprd04.prod.outlook.com (2603:10b6:903:b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 15:06:06 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:06:06 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 16/20] nvme: revalidate zone bitmaps in nvme_update_ns_info
Thread-Topic: [PATCH 16/20] nvme: revalidate zone bitmaps in
 nvme_update_ns_info
Thread-Index: AQHWlZPdbtKlrwfA5k+n53zkRfN+8Q==
Date: Mon, 28 Sep 2020 15:06:06 +0000
Message-ID: <CY4PR04MB37517CB7AD3055B588C58E83E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-17-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b7ca745-eaa8-405b-e2a8-08d863c00645
x-ms-traffictypediagnostic: CY4PR04MB0425:
x-microsoft-antispam-prvs: <CY4PR04MB0425074EAEC424791DD993ECE7350@CY4PR04MB0425.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXZ1tj4aQ0PpxNfVmCbPy9z/IHX38WlCbVM9tOMnNIDr45CUiOLnPxjN6moMumUfM3zOjRQcMUVVKgOXaLC+1RHt/vIEz7WXlqnD7qKMvQywNh2D2LaHssPXdZtEf7ewNny1M3H4LHyLt7Mew9AmDLhWJQRVLUR4t9uzc9IX61SBasLT898cHRBaiuNV77TAotNzOsI6XF4vEEIy/A68SuwAWrcS++vJq8tfknQiDNLueO7bq7GwEUxsh5ZuXE75riYPRZxU+E7RDu2QXkRu8wN/6dbQVctqtvWAA6RThKFMlOJC6K9gx2SfKi/I89z/KNoEyZUOv8HS4j+1tlXjJ2aK30Utw9iUwBpc7MREg7umbayYGWyOzH8DZn0JCX9R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(8936002)(478600001)(9686003)(91956017)(76116006)(316002)(186003)(33656002)(83380400001)(86362001)(66446008)(64756008)(6506007)(66556008)(66476007)(53546011)(4326008)(5660300002)(7696005)(66946007)(110136005)(54906003)(2906002)(71200400001)(8676002)(52536014)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 0e4RMdz/eKRo88EKxU+lyyiYuIejbzbxUDYHnjPPVEDtL5mq68WO3SLDUzZ/efI8KemSJFuGZ61K9PEvXIPqHcH6cTMVkeQQs24cJOrkzSuwlInbB51ngXvGpN+rPN2Wx4VKAN1HwDecwHReXhGWt1dJX1QZkn36cUuSuq33LdD3jV7jqgwf5JRsxp52RH1U0QF/ckL/Cr7gem+BCHkwhxtCAbzpwkJoxYB9OA5ueK7V5K7/cg3pSKqu2UEsMv1Ba/BWzFGFtZ0C3HTwlhKcsW2GTZ1dA34ULpfvYAsv77KtxQ989JuUoxCmtGfMeb5sR+Nw+xEo5x320/sUyGETTv2+064A1elnVs/TS7BJsUBM0X0Z/nNIdsYEaTBkM03qZx4L8rlCiSDSujbFmqG5VXIgDTrErO6hgM8Lj0w6DPD56Pixc9GS1Z6WXNY8wVgr614hPsLePRotez/0247i/j4/9h78BOgPvLUaWtz0+SotD45WkfoZApFRQBHG6UcUPYHVQ4DxjJ/juBGZtYQXiJe/67eXfCMKo9m0B7DfzwkW5c9cxdjlF4/YZq1l/ZBnhfm3qBWV4xEAQ9NVj2kzhYl3RCdX1sLyuvIXy7CqGWAssuItsOWW+rBz2Iy1BH3IYeIuQQJPeCQnRQzWfJ8rZZsJYdWl4EJ4loaoNUN/9iaZuQXsH4gy8co56RHmrDVmLiCbcMhdwYU76O+55o4hVQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7ca745-eaa8-405b-e2a8-08d863c00645
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 15:06:06.2229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7fLG28FfhYDUBnMcCGlw6CwW8LF7a0OMxnaM5a54d/L65xGmgFVLfnAY/hjVnFrBFbHBvqE/YaEkRNvjnDcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0425
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_110617_507818_ECFFF914 
X-CRM114-Status: GOOD (  18.11  )
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
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/28 21:35, Christoph Hellwig wrote:
> Consolidate the two calls into a single place.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f19f6c7c5b1242..9c137d8819f756 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2150,6 +2150,12 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	nvme_update_disk_info(ns->disk, ns, id);
>  	blk_mq_unfreeze_queue(ns->disk->queue);
>  
> +	if (blk_queue_is_zoned(ns->queue)) {
> +		ret = nvme_revalidate_zones(ns);
> +		if (ret)
> +			return ret;
> +	}

Is it OK to call this before nvme_update_ns_info() ?

> +
>  #ifdef CONFIG_NVME_MULTIPATH
>  	if (ns->head->disk) {
>  		blk_mq_freeze_queue(ns->head->disk->queue);
> @@ -3915,8 +3921,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  
>  	if (nvme_update_ns_info(ns, id))
>  		goto out_put_disk;
> -	if (blk_queue_is_zoned(ns->queue) && nvme_revalidate_zones(ns))
> -		goto out_put_disk;
>  
>  	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
>  		ret = nvme_nvm_register(ns, disk_name, node);
> @@ -4012,8 +4016,6 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	}
>  
>  	ret = nvme_validate_ns(ns);
> -	if (!ret && blk_queue_is_zoned(ns->queue))
> -		ret = nvme_revalidate_zones(ns);
>  	revalidate_disk_size(ns->disk, ret == 0);
>  	if (ret)
>  		nvme_ns_remove(ns);
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
