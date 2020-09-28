Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E67FC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:55:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7C621941
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TaMlQxah";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pbPAauol";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R20n8b84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7C621941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=lYmGY7V92/eLhCERpn+Tt6iVMmYq/pZTgCNGOK8SLZ4=; b=TaMlQxahPAPNOYD5sxJxEyE9d
	ChHpYM63Vw/lROht6spunVaty8bAS65WgH6qZgT1R0S/eOSYnUJ6rT6rqkwVy29Jyu9rmBO8oGFZZ
	IqR39n2C6dWRBRVG/N1mDfvakpI5y7vcjh5Reur740RphW5dvjmjMv7AJBxUlFrivM31ei/e6y2LA
	s/xn0xcGI90PjPPhxyYwU1ZQ7+55LMzgNmQcGdQCmQgcIAPrRrvxnyebu61CNxb2o3e97sJ3vOdIt
	yrLX43lpm34NbEIbPS+Lt8bVs9DTxAvCXl0Nyjd1t3w2Yz7IGQqIRs+786JikI0P/J0UnKlbTMHj6
	bloL3Q7oQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMuYk-0001FE-HN; Mon, 28 Sep 2020 14:55:22 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMuYh-0001EW-EW
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601304919; x=1632840919;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nTSVgBLzf1um9zjRgZTAMKZeZqSK9m3nnxX9y+ajOME=;
 b=pbPAauolrVoD5xdvyvs2OSAIQv3e9LAU4WQaPvOWXPhpGZANHvlHdnN5
 j6H8yHwbelSnCJxoMjIq9N9pqCjlkc9XIpnm5iMMZ8gu521Vdb4z5UDe+
 VHsmZMU9i68BDi4tqXt5VSWdvWqR/cWgKh8717WAgFNUZMVvQP0XLMo/l
 aKa+WWMZnNiuqzLvrB1FPp+xF6AUNV0oW8dXXLcRVf5F+3BG358QYk+Ff
 ac3yYOBHv8NNniQv1y3NVmdNz/GoTjhGIz8IrdQGyLUn0gT8cGGa5v7mB
 bGStdmtANl/MdF7HHh+Gd0VBF/tFyije65C/GntbqxqXytIkXzEYpqkDf w==;
IronPort-SDR: UoTuGCMlX7YRZs4QpqDmY9N98fUAb53TWz8qS8ZgyHZwG9TwAF6p8ps/chmRESqAonKnUVTfBC
 /d65rc6T+9iyl9juuPxAQCOlEJ4xnWgIuxug1WEGkQvnr0EHka1BUMNBZtvlGukEu+tfIpol3V
 QprT9N8j9fwhodDqDScEFhki1opgYRvrMk2fQixaRooBahzG06f76MG/dx1fEHTxQw7Xs0MOFO
 Vjeijiyrt/ZnpG4OlF9NK2Py6IsKCqBW5CkLMP/SR0iWY5Jxg0ewUBe6uMqaCg2/Ifu+dD1ek7
 sj0=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="258172522"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:55:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI4G0nDjySL+jljgJed2S2V8lqcaRRH7gYIAvn1wnC20jMBHzFmMrVojom1m3ZB+etcxSSjFwHrw8TtOztPXb2vpvhzGECy1kvCh0bqNWTDs1m4N43CZGR13+saevigUaABo8MoU9/dRumAxRrc4ze22lAel5sVTvsnjQjaAYlAoKiDYJh1avvcC/1gxNcZKwzQOCxP7LT6gUjhAKbHrJ8z0r/WDPwFzWbSlPt9Iv/CsYbZ0oBe3ZMqIH57wyNW72F5i0CF27wxIX/KDdHS1qvqF4Jlsz6dPcONvWSml6L7ohXMtSH61tqm7wEoNY7zTBnLETEyLH1JLQKwkB902lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7DPL9Ji5RUrmvAQ2sDrBeXuBeIrJLILEp4Jj5bjEuA=;
 b=Uq9RXlg3qjTCjrDsSPkiWHTRfEKkvsDFbKtwwaEKZ0T/pJSyy/kiwf2x1XsB5QU2kcSmHhTTx9Dm1atHPzg3z230ttEcm1QU6ZBotBJ5VsRX5W0xW7Ug5DDTyEW03iX/Gr89yEQSMRxDHCUgQi/xBkOlkB/Ev4nyM/uwc8ka4qdzstwSBtTiIHHirs7fQ2qfnu2CHx9r8sOfwVe0WV2iz/mkuXMW3vJ6P1Q6ZG54QO/kC+Tj/yuXm/r61b36hHLdwDC8I3qZLeeBa5S+HAIGLBazRFQ/pFMXFCXw/BwVwvGH2PhhqoCUV1UxRWG1lEKLepA3RZaMUPDsc8Yn+wR5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7DPL9Ji5RUrmvAQ2sDrBeXuBeIrJLILEp4Jj5bjEuA=;
 b=R20n8b84wpPN0X8uN8qV0obusJnJmge5b0SAcyIDiAACi0WSUMnslV0i6v7ab4Qf2Oo7HBXYEbi1A3HztoH/P4swljz4PNHopZxaLNYh7z1GhaWsK3XyDydWk3xFt0OEsyZhGZlpWdRT74HpFVj+XcemYul5qeQO7FzJ+BhTBBI=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1255.namprd04.prod.outlook.com (2603:10b6:910:58::35)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 14:55:15 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:55:15 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 13/20] nvme: set the queue limits in nvme_update_ns_info
Thread-Topic: [PATCH 13/20] nvme: set the queue limits in nvme_update_ns_info
Thread-Index: AQHWlZPbmvKkxmXfEUGOrpD8OIeQLg==
Date: Mon, 28 Sep 2020 14:55:15 +0000
Message-ID: <CY4PR04MB37512D4F6B9F318B5A9E4299E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0cd75cf-c424-4bb1-b633-08d863be825b
x-ms-traffictypediagnostic: CY4PR04MB1255:
x-microsoft-antispam-prvs: <CY4PR04MB1255291D63B7B028E3BE400DE7350@CY4PR04MB1255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nCn8Q7S1287FbrPvM3BcD4LR5k6Z1Oz5g+i6DKiVOE+pMoLnKUqc58EUUOMpNMbAfdWPiXxWUDjR0jCpbmCfF5ZO2u/CPrsTWml0TuLuw1CBb7qZ9VyEcI6dIbmt9hmyAAJJykvSF8oKtdbisVsCNYW9cK6zsYaBMa29608m7oxMWpJAzBA32eGZQEuU1wiS7rrAtNk8ZwqVfmMWl/rfw5868gnCt+N3Md4Exq+Jy0eJD6SRAxMKG4/L21QVPyBWMPrdJwcW5/mLin+534DXaERSRc7oicqefnxdTfY0n0mAq4HqB+FK8XICsPqRESzw5uybBdyT+ad4We7jDRoe7Nom4eBqKUkm2Li4Sg5xxLXW4a38e6QOHKjtpYYtYmky
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(52536014)(91956017)(5660300002)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(9686003)(71200400001)(316002)(110136005)(83380400001)(55016002)(4326008)(33656002)(7696005)(86362001)(54906003)(8936002)(186003)(478600001)(2906002)(8676002)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 08TXic5SIXCel4626aabjvqQ/HyKGBTkLZtk09VMvYkBYz21roM3e2QqYNN2w3mzGO1+H+mGcZMTFOWihegJfLRvmRba6l92yfXQ23OH0xFA4A/TU55nuyXPikTFamJvXqCc8bGIZM8J0fuat1zig82hPQUAkTAH7E7CiFTYrn5fwMW9RKSk+pj+BW9Qayb4VjxBK5hPdGrmIqxQ8P69oTjbnv0Jzea5+cofu9oRGZAjWB9BAVCfS74GUWh82xErVB1eCJQIMdI2YkhyPm4A6y27GUY8pV9uIQyH74Qg2+JByz9URHBmgqBWFv4tn8jP5y7+hRPWjrzJisXysrtEEcKy7/UPZ76AFo8LAYK4WEMapRfhwK/8yg4238ZtyaGc9jP501Ucfe82GzSxO+6588w+JAgEboTibju5cRfEdHPrSddbbWSnwG6NatMqyiXg7xImf9Byg9/GCT1vnqsPE6XuL4rXLa7KcwujwRobmnsdIsfUHv5o3rIRH1+9h/jMDopRQfXJJQ/4rkcdnrEFq2yVHfAE3w+N992JIUHQs/+KuYz0icYFCtkUg9x8psCUYxSyWxlZuejo/uC/gt0k3djIeQNiXxnqSoczjletEufNm/W4GgButM9/gw6dhYYeQWrL3DIQE7ZbwBik4VbyvLdF115M4Koz4/Yz0Toj2yQBrhw687pWaT88XSXs3lGLahmuNIjYb0iUfbrf56LzpQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cd75cf-c424-4bb1-b633-08d863be825b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:55:15.4090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUyCTAXmwm3ZMpghRB5WyjP+FN7S6lDy1xbj50131HVbSasavjRRcfivfDserAORHsvoI1h+wKuT5Sqaxei/EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_105519_647805_4C631304 
X-CRM114-Status: GOOD (  19.68  )
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
> +
> +	if (ctrl->max_hw_sectors) {
> +		u32 max_segments =
> +			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;

It would make the line longer, but using SECTOR_SHIFT instead of 9 would be
cleaner...

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
>  static void nvme_update_disk_info(struct gendisk *disk,
>  		struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
> @@ -2130,6 +2150,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  
>  	blk_mq_freeze_queue(ns->disk->queue);
>  	ns->lba_shift = id->lbaf[lbaf].ds;
> +	nvme_set_queue_limits(ctrl, ns->queue);
>  
>  	switch (ns->head->ids.csi) {
>  	case NVME_CSI_NVM:
> @@ -2495,26 +2516,6 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
>  
> -static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
> -		struct request_queue *q)
> -{
> -	bool vwc = false;
> -
> -	if (ctrl->max_hw_sectors) {
> -		u32 max_segments =
> -			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
> -
> -		max_segments = min_not_zero(max_segments, ctrl->max_segments);
> -		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> -		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
> -	}
> -	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
> -	blk_queue_dma_alignment(q, 7);
> -	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
> -		vwc = true;
> -	blk_queue_write_cache(q, vwc, vwc);
> -}
> -
>  static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
>  {
>  	__le64 ts;
> @@ -3922,12 +3923,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  
>  	ns->queue->queuedata = ns;
>  	ns->ctrl = ctrl;
> -
>  	kref_init(&ns->kref);
> -	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
> -
> -	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
> -	nvme_set_queue_limits(ctrl, ns->queue);
>  
>  	ret = nvme_init_ns_head(ns, nsid, id);
>  	if (ret)
> 

Apart from the nit above, looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
