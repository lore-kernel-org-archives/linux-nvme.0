Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679DC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:02:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512452078B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fGhwiy5W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m5dyGESV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S0990TDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512452078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=iNVD04FElVk6AKjCbDGtzNFv2cy1sGeuSAy1tpoPPgU=; b=fGhwiy5WDXqBMHo5OkY0mlbYY
	WyMddGV0nxFGQqzBe/gUGxyaJLtPq3O+Fr/w0sutN28oH89EfbXrO6kHzoU63VM/2csi9RXcHfC3H
	S9a0BKhLiJbE9Di9rSSL48NXUS+gbxrbDlzHDrYvGPVcZKhLigbeCsj2daVZAQQYXxWX3Y9yie7n6
	vgRbvbU8XNoTHi6hxY4RdVu6u9n7eiPLxujT/BWjUNuFyg1D5P8A6p87yJW1bcar6MAfAxaIcYlY2
	2pLMEp23rqUAgSMmNDURdnnZQiHdsa7oinry1Xnk7VOO9b0ldBaH7RiMdoQkEjwyQPx+k0UAtoo/2
	HjfXTHEfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMug1-0003O6-Cx; Mon, 28 Sep 2020 15:02:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMufz-0003NJ-1l
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 15:02:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601305370; x=1632841370;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Cw7kbC4mIzdtae4Ix3qt68hOIpo4f2kAiMjRFVFpAmg=;
 b=m5dyGESVt/+rFUtyiXV7cEWoN6iyozAf9LRLxTG/35CqZ6wzI1/c09ai
 JJy+83K0gBNWDetzt8IyoMrlHKwP1aND5N6hOlRF61H1BmvDgLzoIE/eq
 cIh3mJFtlLmCVxKMZoO1jKbi9PuEZv1JPcDzyZ4gSbU9GPW2X6sC14cIO
 /3OFJoDSVanTBeVKf8Vm/bpgdD/pxyU1h0Qg83ev0R2rZhF0aFEL+GHWP
 3E1niCFrstEawmDUCZ1tbGsn+8Cfkx+5XXQB0DOocolGYaycGskH8BW/T
 Vw5lJoUZu4Fo/4m2GS5CDqtoFqxvrnBso1IMyFa6qaugGOTlkjfrY0hWY Q==;
IronPort-SDR: OQHpDuIAzFIeLIH8I9rB1kB6GRl5OaKcbtpXMcf9qrh59QqzhH5WfSADxSgpqbhcQh32XJM8Dv
 KrSp7aFqm2Bh01SQYmjfbzMjyLeTOeV6atBU6N+0zdUFhBJgx1SJH1TYd0VO/fmVWxEr2P6Smp
 rzrAVvMF886RGWTaIFFqwZ/JpfdM9eFNUtRlFLtHFzTvL12vGPMAsF2DArv+6JeMdVWy93i+aX
 CAYhl1vLt40W7yTvg1I9d02ljq64JrNNn7sOYRSqhteNz5MRXiaLbbEEkaeCmmql3kOJtz5SQO
 gtA=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="258173309"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 23:02:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n17KV29hxAHDs2e+XIKwtWAxrGVLS3KkcEpRpzRmSJDRQF5Zxddk3QnOhJ0i9Ndg9kiiYLM1dVPIytV7S0yhYTvstkbuRbRLwHa8Dt8B1G8S7Dxmu0xg6fI8pT3tQbMMUaRkztKItO2M2CIfeD+x8EsU5GVVPM4PKkSmi+N/j1q6qz9pVfsAYchnO64pBbiD73fWgDmSHQBdLIMEwaMBpv+9kpVSFrY0eaxYsUy9jw0FKE61sZjYjCvdUrB6j/lliIIx9x4OPXQ7N4AdUQpHI8ZrTVXH45Uo96tNAin5YpG4p3Qif7Tgq7ItgFBWvmdXJ23a2Ui89ou7ktWfKhcawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxrLAd11rjL9sEIKQBIWmszY6gSWNxfuHfgL4YGwf1Q=;
 b=M7QvbUwH+GjBJZcwIvjAQ64hQhpoBmaswL15696dq6IWFfhK4RFs6Xp8XSNccPmOMChhSX/UeXX6LNeNj03x8r+avLzQapsRHfZ7mfgDWIWmi7qB5LzN09ePaVbt/AfemN0B9jcMGjkw0OM/+MuXICRZEnYXtjGblzrYbzo1WfBJ7QFBtAxQq7/jR8tRzSCD1XoemiBjBTsoogey0zx9J3OF3kG3pxbInGV3wqu7U0SUoyirhkvdkwzWYRUfpoSQoTPzb3tgV6Vtn8T2ONJb6Ego9mdPkkh+O71BE7sPHB5/EQWIb37ChzjRJu4nJBa1l9xahYM6R0+HAtpYBULyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxrLAd11rjL9sEIKQBIWmszY6gSWNxfuHfgL4YGwf1Q=;
 b=S0990TDVl6aCv57el1l2Jsb9zUq9SFcN2EEbelEwwoK3QRn47lN58hXJ2lwuhLnGOF0nFg4r4fdJiLRUTFysE/DNOjQuqK7RG/4SP6u9fsozyNgKKN1IcorD2MMq2rjT/LM/X+trjPt7D026RnEx4kklOhSKLGaZTRmFq07pGNo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0377.namprd04.prod.outlook.com (2603:10b6:903:b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 15:02:48 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:02:48 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 15/20] nvme: remove nvme_update_formats
Thread-Topic: [PATCH 15/20] nvme: remove nvme_update_formats
Thread-Index: AQHWlZPcOtqNlWTbIka8bgAoPbr2KA==
Date: Mon, 28 Sep 2020 15:02:48 +0000
Message-ID: <CY4PR04MB3751105F9967301E5670C5C6E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-16-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c128405f-96be-4ad1-ed22-08d863bf9042
x-ms-traffictypediagnostic: CY4PR04MB0377:
x-microsoft-antispam-prvs: <CY4PR04MB03770DB2EF76C7FE8DC298E6E7350@CY4PR04MB0377.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OrJ9CZBqijCLCq/0ItRkLvwZffNQCXWfJmw5O0hAJnp3I7tQzy+AS+I2PwetFJkfMSXeSyQuX0ricNNbeYwxg2/PlH+3/iNA50H6WNEclRyiaqc/nMXjeZ96z9+ivjXfslK522hBWuAQICBCDDSBbnzBY0229o2qHoIOc603LIL634FwkfPP1KHpLy2Csq0nicn/lAE9ZG/ftF2xUu0wm1XnaBKuGkvYfBlKEf8CKBoZwumsPRFqYAXrn3Jf4kD4ISpLLZO/vqZ0+kh4HWqRufhacz1zspa4oCI2aGSBeEPNdIo//ezUU2KCG0Cn3cd+WCzJ+qEJ2bg/on7PHvVkRNEZQx5LIIzpf8LaOlsUL5L/Adx3J5SVzHwNH6fh+24h
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(66946007)(2906002)(83380400001)(33656002)(8676002)(55016002)(4326008)(8936002)(478600001)(5660300002)(86362001)(52536014)(316002)(66556008)(66476007)(110136005)(54906003)(66446008)(64756008)(7696005)(76116006)(186003)(91956017)(53546011)(9686003)(6506007)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: gKRjSVx8Rd2M5jWuPNZ2tc2Jfl8pQ2Dh8qCsVoFQRqz4rkMHoSjnAFm5LMkUmWtAxwlPENX4FTm3jbfSKwREZTnGwkYISssnXfZmUb2LHedLK0zvBuUNO7CapD2sno6+gRL7lFUdZfYU2Lebf+z6KTrQ2VKXchMntjNrzDe90x0F15gEPpRHx1vDR4lCvsnj+iXEw7NAxqXnT9JrHZ0cUAbQJNrq+p7rwtG3bx53VBszm+m3u5DQqC1iVv+lOabJbqOYG9MUCVZw3gtq+1RdcdXkVpl+MizEb4FFTiBM+SPoYuNhpy4AHOWVXHZuDq4bJDGS4/mVM0Qat0BMoJFYj6AteoHqrjTxQOhzPmvurw6ejLliwnutO6L6wdKq1np/76ajj6ZM3AipgM+v5eeGiRKzxclQmDuCwBXzsuOoO3Ae9KIMFVBlqTcHLrZNX0pggD9ylxIr1o0M4etTkrSI6vLXkX1QUKjDLKRyL934qTndaDKny1dBZJc4w/gSs2qXbqS1eZ+4C233Uymdyjrvt71FA2ndJVFIFsiqyMA0uP2QOruO+imE6XHI4xcpgTYMKcWFvPS9SrYCnG/ktZNtpsGijVqLBWiBWCaFkk0MSJ/RHmLp3eyO+l0N1qbDXSA+FR0RsmwDKhdCtgESsoGjYHMo74pRtT5NZtmp8kb6OY3JMJfWPFJa1RThTRgKPoLp2Y0WMykJjnSnvBKiY0OfIA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c128405f-96be-4ad1-ed22-08d863bf9042
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 15:02:48.1724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSaUoEDXFE/UADezgHHID9ywqqnHiLg5F3XowgtADO5K7dleydvGPMrA+EyvDejS6aKE/mxnErGkiWgb8qNM8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0377
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_110251_237630_3FE62E39 
X-CRM114-Status: GOOD (  20.00  )
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
> Now that the queue is frozen before updating ->lba_shift we can't hit the
> invalid references mentioned in the comment any more.  More importantly
> this code would not have helped us if the format was changed by another
> controller or through implementation defined back channels.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 32 ++------------------------------
>  1 file changed, 2 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4737591c1143ae..f19f6c7c5b1242 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -89,7 +89,6 @@ static dev_t nvme_chr_devt;
>  static struct class *nvme_class;
>  static struct class *nvme_subsys_class;
>  
> -static int nvme_validate_ns(struct nvme_ns *ns);
>  static void nvme_put_subsystem(struct nvme_subsystem *subsys);
>  static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>  					   unsigned nsid);
> @@ -1009,7 +1008,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	 * For simplicity, IO to all namespaces is quiesced even if the command
>  	 * effects say only one namespace is affected.
>  	 */
> -	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
> +	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
>  		mutex_lock(&ctrl->scan_lock);
>  		mutex_lock(&ctrl->subsys->lock);
>  		nvme_mpath_start_freeze(ctrl->subsys);
> @@ -1020,36 +1019,9 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	return effects;
>  }
>  
> -static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
> -{
> -	struct nvme_ns *ns;
> -
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		if (nvme_validate_ns(ns))
> -			nvme_set_queue_dying(ns);
> -		else if (blk_queue_is_zoned(ns->disk->queue)) {
> -			/*
> -			 * IO commands are required to fully revalidate a zoned
> -			 * device. Force the command effects to trigger rescan
> -			 * work so report zones can run in a context with
> -			 * unfrozen IO queues.
> -			 */
> -			*effects |= NVME_CMD_EFFECTS_NCC;
> -		}
> -	up_read(&ctrl->namespaces_rwsem);
> -}
> -
>  static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
>  {
> -	/*
> -	 * Revalidate LBA changes prior to unfreezing. This is necessary to
> -	 * prevent memory corruption if a logical block size was changed by
> -	 * this command.
> -	 */
> -	if (effects & NVME_CMD_EFFECTS_LBCC)
> -		nvme_update_formats(ctrl, &effects);
> -	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
> +	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
>  		nvme_unfreeze(ctrl);
>  		nvme_mpath_unfreeze(ctrl->subsys);
>  		mutex_unlock(&ctrl->subsys->lock);
> 

Looks OK, but I am not so knowledgeable in this area...
Anyway it does look consistent with the effect flags change in patch 14, so:

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
