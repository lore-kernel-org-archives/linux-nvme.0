Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E5EC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:32:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06FC21941
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lmfPhyS4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U5gQmCrL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zmQYcR4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06FC21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=dSzpu0JZR4mZK/p7sUIN12vEIub7S6xx1yeL63RWpbk=; b=lmfPhyS4v0B/0dbOHFH3jbBJ9
	VfcU/2bc7oiMgjIZ0ebJRIsJV/pbcyq5hNzafwMOOwE2GPE7SkDZXSy1Vpyc3O7ZgsbxlXTWrwbye
	jYLcUdi/GAg19CrXjzHXguAxIIf/MpE4PmkcU6aHd2xBFucR9VcdcCgPOaIht+Y8Ve7WE6EL3P54T
	ZE3n8m4b2pengG7uKwV0Qa6MYpFSnCS/ALF0LjAitdfKIDk5BMObMKuIcHNTCJD7n4ljXi4NMDwJr
	r5B6CNcc5oEc79SdX0K+Pik9GWn5FFRa9VanFyLGAcbjkdFDNtSTSoisjoTmSE2lJ7hCqOLgailf5
	RZu7qe2dw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMuCJ-0004ZE-AW; Mon, 28 Sep 2020 14:32:11 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMuCG-0004Xn-2o
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:32:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601303528; x=1632839528;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=gRTLyzBaj/UIGrgLbfQ6MNLzAdm6zj2DJXxPFBL7vFk=;
 b=U5gQmCrLqFBVntcL8W8403lr3qnd6nhPc8Cx5iVm9UCjdZgPhmNqcV4Y
 3hU8L1BY++dnRwS4rUDvTpNAB63u6HSiw0tATXeNcMBxoxk6Dy2gcaFYX
 UVPT5ItFjEbZ2n+V6Md654XEwclkOqTV45QW4X7sXJeBo++yTTeJJsXBK
 sO1OH8dtHbN+cdy/TPbLP6XeNFvEcX798gBHJGAsqbj60E5PPx5gGl0My
 JBL8cEUw5MzO3Eut9W8chKiDfdkD7wbluvCGEe3fJIRUrkqU7VyMpLxLT
 26I2dp0WPJTeo3J94q0AhAwxcCw+gjQYPYb5lcJgDbrOJOvzy4ykEWJpf g==;
IronPort-SDR: PpdQVtXicRnuQWddWW7W71uGLdj1Etd3VNX0LNUXiP7MO0+dLtq3PsIGCtoAs5Z3Gka3TbexiU
 WyySOcvwp9/Iz//KGQDFwp0GBi+lYZyu3xNYMc2N4kAwZxd5mjsp2GS5GAGVtg2HpQehFjPn9Q
 yWle0tD1yypgw3WSQAmJlRyPajza2lqRmcQkWZwKcXd3lV3Kj2AeK7/EbFdfEbRCEiQN1pCr39
 2wMuOxsvA0ytHZkhfp4Y4KedWCfIzskWF2bjJSCEhHShEPWz60sRt5Es7H0hqTJFL9kovXuSEx
 4RY=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="149667437"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:32:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrPJgKSf9eCafEeGnobkGK/WyCHpFK1xP/IgB4WF5cWRdn7WgPiOAgtusrr/CjAOtZ047lh4JEoZvHDtCWdJ9eg84qsRe3bO599Dz6BBVdxPMGB3Psnby9GLgQN71gYXBokfVZgNjTOvLon7TsJnXKydG5GXm1wabThgtf+fpxYeMFxUT8U3i3V2ScJaGLBvEIojSfogrzBidwsIJhNS30Atio2yPbaAkrNzMbSBtryYV42b3vETgqrJVn20K7RvuMs3vRN/R1xYs/otlXoZXxOcYTDvxZmsJmqUcut03TakZ2S7VG9iy8vnyyAFB0oE9/7lSYjwppI5LqPaFz6ixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdsX7NhIPODQ2+rHaPwOBG9qFD3gueioUzBSSct9KQc=;
 b=CHq8iKnqlSwRteiq7y9m2C9cMjP8NK3DJDlOXdvZIlLteU711AxjifO0nhOZ+rKNRzOu6w+xRptPWw5hUYi8bHVLH/N/4QvVL0zq8j22SQb7ArFNHkmihJDCNoZpAeKmoj/u3twOVQQ83TCn+dDAZwGMCaLdPsI/zuBGIGpefxmes2YjiVM715MhPtBiwF1CHE5B89X7RagMQvYtrxbrhsV3eP8QdCCoE85+Uj3aNWG3Bs+rtGcwJyKkqW9WTyGDrFlsf3adWM6399AzZkoT0OzsDx4yeiKKSe92UmaBxG0opB7nhsgUCeINVegGSW6UFzdOwuvWSdkpc71MVPzoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdsX7NhIPODQ2+rHaPwOBG9qFD3gueioUzBSSct9KQc=;
 b=zmQYcR4GElRwi7tCn0MAGYJQYA7fpekZXuO6YkuozwWsN7XlwQIqziAOuzy5pBcoM7jOHim7EonD6BP/AeUJ/K07ZxoSq1GmBVFOlnkp+XuU0hctsmbjlnLClCdaV05vKtYAvSIgq67ty9geYWSJb4V9cm90ZKFLuNs0c7++8zU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1031.namprd04.prod.outlook.com (2603:10b6:910:51::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 14:32:05 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:32:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/20] nvme: call nvme_identify_ns as the first thing in
 nvme_alloc_ns_block
Thread-Topic: [PATCH 08/20] nvme: call nvme_identify_ns as the first thing in
 nvme_alloc_ns_block
Thread-Index: AQHWlZPW6eM1+OaUkUCQ4oSLtnn9Pg==
Date: Mon, 28 Sep 2020 14:32:04 +0000
Message-ID: <CY4PR04MB3751EFC8BC7CAFD9A1FFDC36E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a58ead70-a680-464f-89da-08d863bb4594
x-ms-traffictypediagnostic: CY4PR04MB1031:
x-microsoft-antispam-prvs: <CY4PR04MB103118DBAD24C07491C37141E7350@CY4PR04MB1031.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUFbpIOtrlyWhwdjQX+xAYW1qJHe08q5bjW7DjtOsS3d+Lw7uW0V3YOsrtHoA7o7QUXjUMCUF8zSjNqqWEnAHoVbPZp430jQX/NZZB2aAZPvCRjrFc5OYlUBUmrJsZtdyAK3ZM6qqUZFdFgoJ0O18RmqzMaVLO3a+7YliLIrL5ciee6ahlSFaALSwJpn5c7GTiCeD8wq2CnMDynAiPNRhmShhyF5CToq3bk0Rwt64ok5a+bPXYsXh0ayj2FT+ACRsM/UVk186SCde7Host8d9DLszyhU8qxhZrwXE9Osu2KA1Hfo2molGGRB/DJcSJFtXIoigMjxMDionib/kqJn31NRUUWupXFuLu4Gbof5Oikx9JfJ6cLzRG1amez5WnTN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(52536014)(91956017)(478600001)(55016002)(86362001)(33656002)(186003)(53546011)(8936002)(66946007)(6506007)(76116006)(4326008)(2906002)(8676002)(66556008)(66446008)(64756008)(110136005)(54906003)(7696005)(9686003)(66476007)(83380400001)(316002)(71200400001)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: skGWZfFdBbQp50zd8QcC7uejIzWWj3NUmMypYfEeknBkuSUOg+ZzaF1BAYYWtaVC7UX1KCeHoXOs3Mpxaydw2YbqtqhF4fXmoMyL8wrDNgQ7NWbDaKnlWGTQCDR43gGMoBK0ae5yjuLXHk2JFCPBM0CO9F5jQCp915gLXGKiT3+OEgfBhyQMD6jlIoJTKKDw57swasn9Y8vw32nfyZi4vB2yoekEZpsBuZw6xDXA21t/lB3ypY1xkK8USOlpUiHq/Nj43Y2Z/xL6kf+yV7E22p478W7twmxU3zvUoPSjVqPVxW2tQO/loN3q+e3YVSF5O1Mq+qef8cnFA+PaIcBu81ya2+2eIGO8oHgYEjEUZalGcR4Tj8HsnoIMsXBx1xvUHyB7lcbOfSltqeeuG4o3NLf0Qeahc8BAXo+kBvZpr31bVnSAPEBSZZn4vtJFz1cmKTZpshigH3hk5dJrtTf6fXkfcs32aRmSNW0mdn6yvGVJWhTUe2CvJPiXE1LFl3IT37aHmUkWoTqPbShyBJUHORUQIUh3Qh0Vza48U86RwjhcW7D0R1iAqiEzhADq2aSkaOfjMUykgnf9VFJWzte8TjdLXqiECwFlG1RILiCKv/vnMX92UXtmqz+WrJfj8XQDNxkOg6NqIQ/wGr1F6lMZlyNswhIPQBJRVid7UaPGUURxoaXsXC5C+6NxnKY+QJ/R4XWvkM9lI9dJbDcLTuMLTg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58ead70-a680-464f-89da-08d863bb4594
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:32:04.8642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UuG5m3iWjJd9xt7eX0DN6Rh4olYc3kAxqhcjE0fE0iXwa1grHkX6zQq8Jq9Cgg4bhnpXXHwQsRdGU7aSsPXFIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_103208_266326_709B9762 
X-CRM114-Status: GOOD (  18.32  )
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
> Check if the namespace actually exists as the very first thing and don't
> bother with any extra work if not.  This should speed up and simplify
> the sequential scanning for NVMe 1.0 devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7b1423c7e7fc58..4a5c4d45755b55 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3887,9 +3887,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	char disk_name[DISK_NAME_LEN];
>  	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT, ret;
>  
> +	if (nvme_identify_ns(ctrl, nsid, &id))
> +		return;
> +
>  	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
>  	if (!ns)
> -		return;
> +		goto out_free_id;
>  
>  	ns->queue = blk_mq_init_queue(ctrl->tagset);
>  	if (IS_ERR(ns->queue))
> @@ -3911,13 +3914,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
>  	nvme_set_queue_limits(ctrl, ns->queue);
>  
> -	ret = nvme_identify_ns(ctrl, nsid, &id);
> -	if (ret)
> -		goto out_free_queue;
> -
>  	ret = nvme_init_ns_head(ns, nsid, id);
>  	if (ret)
> -		goto out_free_id;
> +		goto out_free_queue;
>  	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
>  
>  	disk = alloc_disk_node(0, node);
> @@ -3968,12 +3967,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  		list_del_init(&ns->head->entry);
>  	mutex_unlock(&ctrl->subsys->lock);
>  	nvme_put_ns_head(ns->head);
> - out_free_id:
> -	kfree(id);
>   out_free_queue:
>  	blk_cleanup_queue(ns->queue);
>   out_free_ns:
>  	kfree(ns);
> + out_free_id:
> +	kfree(id);
>  }
>  
>  static void nvme_ns_remove(struct nvme_ns *ns)
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
