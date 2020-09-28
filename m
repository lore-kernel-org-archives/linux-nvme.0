Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A0CC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:11:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60092207F7
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AGLxRFij";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DKTgm7nG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gW1aHB0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60092207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=dWmKkkLj2iPlMjM1GJbpqkoAlgwbTliVilqSXv6JPhI=; b=AGLxRFijL5wRfKzxlZoCvXiec
	qs8GUxPeJFxP7aiPVehfmsa2j7ajSKYwAPQgloAXdu1rzJmIJsSegaSzN8DXzxl6pxdv6mDdKWO2g
	NA20iOVfajD0y6vjcb4QD4sMMZRZ8rZG8xtvpJRtoWyo2tg58vf+FPPYmkSmgyG7Wc2wEHJh9TX+h
	ah/uaVutaooZypoEIpdbk+MRb3AracaHa2A8wyJAcM8DmnB9LYaYmf8U87TzFOSNEk6vrNtweWaPD
	tkZCfzgNyQrzPAYyv1AqqDtjo4SHyNv83yEe1u7kj/tgKTCyOBMPn/39ke+Z9v0n/Wk5otZ8IYaUX
	Yf6+Moh2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMuof-0005Eo-8c; Mon, 28 Sep 2020 15:11:49 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMuoc-0005EJ-Bx
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 15:11:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601305906; x=1632841906;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=VTOShEf3a6Z+0t2BivgFp3FGAqztEkxR4AaM2rt0s84=;
 b=DKTgm7nG59Gn/Gz29znaKCPQSDVTiaWFKH5zLWyirR/M69Cy1bxWcw8d
 rxjGw9l5sIiCUDm/PixmxaNvtxFTzPrgHO5SikNG8bsCl33EQFEKNr5DI
 5CrIbsOZFZt9AYsuri5TGiMJtFZVb591OAmkJFLAvJXxslqqjHtfH14Yg
 Y0C5JXLiJ9I+tj6bPe+/xJs6C6oRO3Hd5zbUWNyyErcBi6Qivyg8m14aV
 hH70772wkpaONir8h7qiS5q54EmpTBVxpJJRPSTrVjfFfRYsnadltX3eQ
 gWQWDhlyse8tURssZIySxXAaCfAWa4VyJNPExrd6RkOeSxO2mbERONMjT Q==;
IronPort-SDR: J5+a6CShwdJO8xOl6wOfIRUtJCksie8pH9dxxquWXupB34njtmfj2esSOeO62hD+4l9RyezMe7
 0DLLqAt4ZUqbKOmdnN4NbhslwXbfH5zRFdKTEissiMVyk5E6sGNBmIPI6bsLLpBPnKoXKr/cCV
 rtFQ2uxu0yKTOR/Q4bLEVZh5n6eCFnL36JaYbI4Br/bH0eIu5/dr1LTnd6IbRlktIUfEMRUuJE
 aiE/LEnuRlecyzANvH931S4F8QKxlAgpNwBKX1jf9D7xvXJEqQ6ZdS2NjwYiqQoRL6gMVUfrUN
 /lc=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="152818053"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 23:11:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WP0xR6+y1McJRfRBfQkhEXKDklthDaiVAV/kTuPsXFCzTP542zXE1H6FkKIms+6VOC6rToFGeGivRL4XoS26DDmbq8vl7cRGRG03cdcKPIoJxY7rfJEb0jxv223D2gtqc9qEIdUtZ9R4HyZIvNcQ7/YYjTGONngcZ5vaPNVs+g8ZejKYusmiYzVkM0oy8RNUfgNPwRW6n99e386lYCaz6wYhRsSoTeiB0yMna5r8iRo6kidGHwHbkH0sLG9Ik0CpjO2XyHYLktNB3gCf1PlXnSxUFE+k6/DTM/3jDUAOYXfcvVXqW4WgcPR8aJ0kXDWjedpKt/7dIBxpoDfSS5h1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjxZ/xfVpdKCBTmqaYw7jvRpoLGyCMUmxFvOaBnZaXE=;
 b=NunG2kxUQgwaIjXp8qUpRQT8uXgGQ9qBFWQ9aSD/rt5UAWdD8Aw6Kizf0+AACNuOnYlYj6jk/wO+51N0i4XIr/A7mS+Hv2YEuNTOvHbnzjlyh0N/QCKYN1WE4cWrL8tGkuSQ+GMiu/bqS0Z18jTyrYBX5kx4q4x8VIHKuzUkHUqxUr7L5jbnG/2LXhdPH7ABt6HXRbmSP1sTqDvIu00zMmcMFb9MC3HmH+BH9JU04vdH818aVKYcDQMLzMRyJ78HvsP5tLZJzkkidvWWtLkfSkzMrNRxP9b+rBujXZkiOxtQ/BMWk6v3hyRqzPJPaPV4W4FhzeVTzPYfg1aXEn8FVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjxZ/xfVpdKCBTmqaYw7jvRpoLGyCMUmxFvOaBnZaXE=;
 b=gW1aHB0KkepSGc9h+o3p6Ar2RvEahK6QyKiHnz4AkwLoZkRcVGDdycZNU3wRi00j9VcZ8nk0zji5GD2dlpaIMIFJb6N1/RoCvIEAkBpZHXvG8JWFPsIWjP+yh61vDLLdkJSljlDf6cIfwNmX56jMAvCp7r4JWHtE4zzLGkGlbkI=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0425.namprd04.prod.outlook.com (2603:10b6:903:b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 15:11:43 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:11:43 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 17/20] nvme: query namespae identifiers before adding the
 namespace
Thread-Topic: [PATCH 17/20] nvme: query namespae identifiers before adding the
 namespace
Thread-Index: AQHWlZPeH+mkK9qpak+aS2rz7Ix9hQ==
Date: Mon, 28 Sep 2020 15:11:43 +0000
Message-ID: <CY4PR04MB3751E29EE08865FD1D804FE4E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 475b82f1-145d-4484-1a67-08d863c0cf45
x-ms-traffictypediagnostic: CY4PR04MB0425:
x-microsoft-antispam-prvs: <CY4PR04MB04259DE9AD0E1E26068CC342E7350@CY4PR04MB0425.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1xRcAep0hc8BPePUst84hMnUAlnHazkK2dl0ff5acVnMgaVUYvLUbrKcyLebtmo6rezKEsNsbkDZM0mZ7oNtVuIBVTlUuaGzUOwKN6e+Q/vKQo+KSoQtREwmqafSD3xRq/rb7GD5faCvNZBLKtjzVWr7wgFY0bU1VOhFagWngbHopKbDtYOrvDcUrqDciwf/sh7BqLf+Pdj31CQdwJFsSWajEcL0i4fkTzkHX3/RrR0SJyTcxZgu3b+cQsVjE6zb2L1n6LsN6AbAHn0WkdQ+1zIti9NyPkEMS7XFUwIfxTdAOhNc/P6v21n691mP+IPrRS2cE2HSiuql9FDKQeWOa4JBLt44DZe/wWD7W6KvHOaAvmmtEwU2y0FhWwGq72Vv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(8936002)(478600001)(9686003)(91956017)(76116006)(316002)(186003)(33656002)(83380400001)(86362001)(66446008)(64756008)(6506007)(66556008)(66476007)(53546011)(4326008)(5660300002)(7696005)(66946007)(110136005)(54906003)(2906002)(71200400001)(8676002)(52536014)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2ful7QVkudlCe9WJ5ODhKekUTx210FCfsYEOE5V1N1wivFJKuoCYkUFva2qv38IefkEJBS6RdTVP0OjMFKAqsLCFbfMx1JunM1Oh5jhXkBFA3lHhevbWPpSSHYL6xYcGhQBj68mYmZ6KayemqENucAf2qMSpNQ8Mk21YF8qGso+TRSMkD31taW7gMVCNKpJNfWuoSr+9Km7JfsNE4C/P9f8G3iYfF8qeKjGsI91O+W6vwpywCxXh5UXDPpJKeo+iptRGJcu5yFC2fJFZFT4+wisEo60rQ8MOf9hqqM/FOcC8ocyZIOTwiuVb5FqjkUruevTDiHJLxSM7NL0RLthVAZrILi/cIBvPrYHCeIyx1vQd0okLDjStNnNjsJn1gPyrKkdcvN1hMCi5/CA52zpd+PIzy8qLq4Leyi+V0Pa5Tno7pu0shIUw36QxebmWCdyCRUQZOF1QWFVfp/70aja0wc8WlkewQUWK03MXbWQHGw+491iH8d3TpVkFkDyLy82R3vuOw+W8WmhdrHu4/vsUxJJoPWOnMr43bLDMzTDUXhPg366bNregEvY5fkvXEErHApTXBFwLCxpGvbh+b3YEq5w/dqqdKD9zsAk/7TFSLXUEqZpVMlEfVNZjtE/VF9gydNOpsFrxUgbhmL5n3i3E5nXWdYJdsfYfIPWmp9MQu3+ZwoAjt4kPnpQxFmGIz5P7Rk2c0ZpePhSTyOj1YRbcoQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475b82f1-145d-4484-1a67-08d863c0cf45
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 15:11:43.4298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOmvOAsVtG33nQoUjhusAggZcKRAWiZ9fR8h73zgsQW3wI/4JPEqcEAGB/lE0BswfIlNcUTEuiakI33Nyph6cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0425
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_111146_908915_8466750D 
X-CRM114-Status: GOOD (  21.98  )
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
> Check the namespace identifier list first thing when scanning namespaces.
> This keeps the code to query the CSI common between the alloc and validate
> path, and helps to structure the code better for multiple command set
> support.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 116 ++++++++++++++++++---------------------
>  1 file changed, 53 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9c137d8819f756..ad18c32b36e7b6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1281,6 +1281,8 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>  	int status, pos, len;
>  	void *data;
>  
> +	if (ctrl->vs < NVME_VS(1, 3, 0) && !nvme_multi_css(ctrl))
> +		return 0;
>  	if (ctrl->quirks & NVME_QUIRK_NO_NS_DESC_LIST)
>  		return 0;
>  
> @@ -1335,8 +1337,8 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
>  				    NVME_IDENTIFY_DATA_SIZE);
>  }
>  
> -static int nvme_identify_ns(struct nvme_ctrl *ctrl,
> -		unsigned nsid, struct nvme_id_ns **id)
> +static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> +			struct nvme_ns_ids *ids, struct nvme_id_ns **id)
>  {
>  	struct nvme_command c = { };
>  	int error;
> @@ -1359,6 +1361,14 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl,
>  	error = -ENODEV;
>  	if ((*id)->ncap == 0) /* namespace not allocated or attached */
>  		goto out_free_id;
> +
> +	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
> +	    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
> +		memcpy(ids->eui64, (*id)->eui64, sizeof(ids->eui64));
> +	if (ctrl->vs >= NVME_VS(1, 2, 0) &&
> +	    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
> +		memcpy(ids->nguid, (*id)->nguid, sizeof(ids->nguid));
> +
>  	return 0;
>  
>  out_free_id:
> @@ -1884,20 +1894,6 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
>  					   nvme_lba_to_sect(ns, max_blocks));
>  }
>  
> -static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
> -		struct nvme_id_ns *id, struct nvme_ns_ids *ids)
> -{
> -	memset(ids, 0, sizeof(*ids));
> -
> -	if (ctrl->vs >= NVME_VS(1, 1, 0))
> -		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
> -	if (ctrl->vs >= NVME_VS(1, 2, 0))
> -		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
> -	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
> -		return nvme_identify_ns_descs(ctrl, nsid, ids);
> -	return 0;
> -}
> -
>  static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
>  {
>  	return !uuid_is_null(&ids->uuid) ||
> @@ -2117,30 +2113,16 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
>  static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
>  	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
> -	struct nvme_ctrl *ctrl = ns->ctrl;
>  	int ret;
>  
>  	blk_mq_freeze_queue(ns->disk->queue);
>  	ns->lba_shift = id->lbaf[lbaf].ds;
> -	nvme_set_queue_limits(ctrl, ns->queue);
> +	nvme_set_queue_limits(ns->ctrl, ns->queue);
>  
> -	switch (ns->head->ids.csi) {
> -	case NVME_CSI_NVM:
> -		break;
> -	case NVME_CSI_ZNS:
> +	if (ns->head->ids.csi == NVME_CSI_ZNS) {
>  		ret = nvme_update_zone_info(ns, lbaf);
> -		if (ret) {
> -			dev_warn(ctrl->device,
> -				"failed to add zoned namespace:%u ret:%d\n",
> -				ns->head->ns_id, ret);
> +		if (ret)
>  			goto out_unfreeze;
> -		}
> -		break;
> -	default:
> -		dev_warn(ctrl->device, "unknown csi:%u ns:%u\n",
> -			ns->head->ids.csi, ns->head->ns_id);
> -		ret = -ENODEV;
> -		goto out_unfreeze;
>  	}
>  
>  	ret = nvme_configure_metadata(ns, id);
> @@ -2174,11 +2156,10 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	return ret;
>  }
>  
> -static int nvme_validate_ns(struct nvme_ns *ns)
> +static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>  {
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	struct nvme_id_ns *id;
> -	struct nvme_ns_ids ids;
>  	int ret = 0;
>  
>  	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> @@ -2186,15 +2167,11 @@ static int nvme_validate_ns(struct nvme_ns *ns)
>  		return -ENODEV;
>  	}
>  
> -	ret = nvme_identify_ns(ctrl, ns->head->ns_id, &id);
> +	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
>  	if (ret)
>  		goto out;
>  
> -	ret = nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
> -	if (ret)
> -		goto free_id;
> -
> -	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
> +	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
>  		dev_err(ctrl->device,
>  			"identifiers changed for nsid %d\n", ns->head->ns_id);
>  		ret = -ENODEV;
> @@ -3794,25 +3771,16 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  }
>  
>  static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
> -		struct nvme_id_ns *id)
> +		struct nvme_ns_ids *ids, bool is_shared)
>  {
>  	struct nvme_ctrl *ctrl = ns->ctrl;
> -	bool is_shared = id->nmic & NVME_NS_NMIC_SHARED;
>  	struct nvme_ns_head *head = NULL;
> -	struct nvme_ns_ids ids;
>  	int ret = 0;
>  
> -	ret = nvme_report_ns_ids(ctrl, nsid, id, &ids);
> -	if (ret) {
> -		if (ret < 0)
> -			return ret;
> -		return blk_status_to_errno(nvme_error_status(ret));
> -	}
> -
>  	mutex_lock(&ctrl->subsys->lock);
>  	head = nvme_find_ns_head(ctrl->subsys, nsid);
>  	if (!head) {
> -		head = nvme_alloc_ns_head(ctrl, nsid, &ids);
> +		head = nvme_alloc_ns_head(ctrl, nsid, ids);
>  		if (IS_ERR(head)) {
>  			ret = PTR_ERR(head);
>  			goto out_unlock;
> @@ -3825,7 +3793,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>  				"Duplicate unshared namespace %d\n", nsid);
>  			goto out_put_ns_head;
>  		}
> -		if (!nvme_ns_ids_equal(&head->ids, &ids)) {
> +		if (!nvme_ns_ids_equal(&head->ids, ids)) {
>  			dev_err(ctrl->device,
>  				"IDs don't match for shared namespace %d\n",
>  					nsid);
> @@ -3873,7 +3841,8 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  }
>  EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
>  
> -static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> +static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> +		struct nvme_ns_ids *ids)
>  {
>  	struct nvme_ns *ns;
>  	struct gendisk *disk;
> @@ -3881,7 +3850,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	char disk_name[DISK_NAME_LEN];
>  	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT, ret;
>  
> -	if (nvme_identify_ns(ctrl, nsid, &id))
> +	if (nvme_identify_ns(ctrl, nsid, ids, &id))
>  		return;
>  
>  	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
> @@ -3903,7 +3872,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	ns->ctrl = ctrl;
>  	kref_init(&ns->kref);
>  
> -	ret = nvme_init_ns_head(ns, nsid, id);
> +	ret = nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED);
>  	if (ret)
>  		goto out_free_queue;
>  	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
> @@ -4006,20 +3975,41 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>  
>  static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
> +	struct nvme_ns_ids ids = { };
>  	struct nvme_ns *ns;
>  	int ret;
>  
> +	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
> +		return;
> +
>  	ns = nvme_find_get_ns(ctrl, nsid);
> -	if (!ns) {
> -		nvme_alloc_ns(ctrl, nsid);
> +	if (ns) {
> +		ret = nvme_validate_ns(ns, &ids);
> +		revalidate_disk_size(ns->disk, ret == 0);
> +		if (ret)
> +			nvme_ns_remove(ns);
> +		nvme_put_ns(ns);
>  		return;
>  	}
>  
> -	ret = nvme_validate_ns(ns);
> -	revalidate_disk_size(ns->disk, ret == 0);
> -	if (ret)
> -		nvme_ns_remove(ns);
> -	nvme_put_ns(ns);
> +	switch (ids.csi) {
> +	case NVME_CSI_NVM:
> +		nvme_alloc_ns(ctrl, nsid, &ids);
> +		break;
> +	case NVME_CSI_ZNS:
> +		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			dev_warn(ctrl->device,
> +				"nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
> +				nsid);
> +			break;
> +		}
> +		nvme_alloc_ns(ctrl, nsid, &ids);
> +		break;
> +	default:
> +		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
> +			ids.csi, nsid);
> +		break;
> +	}
>  }
>  
>  static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
