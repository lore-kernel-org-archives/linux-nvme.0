Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63200C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:49:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18ED42083B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IqjerWae";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="WJddIssg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZHtc4vKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ED42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=AVTGh4gRBfiUgwo6nERqipJsyFyM45XWpkvaAMohKd8=; b=IqjerWae9DQwngT43csPBzn8T
	8vwk1yST2p75nnx24A1/E71CGkvBefGotGA/8COgTLyaTy8CsZjbSUKOXC7lvTBmw83IKzyKd05tg
	jxZ6sdGCC100kNcZpWZjWjxiPYbClmKBpcydg/bXdfOttIOYTaWZwbKnfyFakhvmpAX3pVtV2O19f
	4gmheyP43OS5CiIrbtH0z5z/5GoPEuCwUQt64gT5bXykJxsme1+LOH23F9kjDJlB5HX+ThmtctkMa
	oCM0B02S8YBDsyPDgXhFTGYRHiHqpJpUHGDt/OI321ZYp6KRY3c07daab9Y9tnXMadRe4qsE6P6EC
	D4fEWceWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMuT0-0008Qg-4o; Mon, 28 Sep 2020 14:49:26 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMuSx-0008Ps-1O
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:49:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601305505; x=1632841505;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5dHCo7RnUfEBu793LKLozo3/80ksSU612MWLwbSEZ78=;
 b=WJddIssgjRazNBJ+tKlK1HxIrNczZPMAyQIvTAVnJWkUZp600m5XlGnC
 ZUlWGMbTAvnLpWleN4829L3PATIEPjUqhjdO6CNQBXWeX3erabuvQ5Uo3
 dRQWdRJ7OCw9PKO6zcAVR07i4YRz7+9MZJc7wX4ZC8zepwwdWguzvJn46
 0KWiNu9D+7+q7pEXANn81e6J39BTQeDX/0KBXXCeP4ItiwoKAeybIjdQ9
 J227yabfpP1N0mBZBmHbBA+Ekskbwk9+jLz8cxGNxXhpAYVqgt+S39WXe
 j7Qq7Qbzb0J4G3Jtdu1eM7ukfTeq9L4ElFAGijpH4DqIgIrqgpHhHiOJK g==;
IronPort-SDR: cNx1QZv+0VfusuN150Ts2JgM2649ZM3IiSkGd1iwkl4etj1jPE7cl7fyaaPyvKJGec3lEBqgr9
 +K/2A7SP0eoIZVRAaryZYE7vxMcHfuGECSETsGV3H8cie5ECsInAmrmFNS+6WModTZMEFahVGe
 0BlD0rX3iNwn2G+/pdNtnBNz123jQwvsTnZJHWiJpTgIZhCD7e3LeV5CgW5GI4HkNQrJO3KTAp
 A0R7CbydhekABs80t9f3cUABhj32N0Dk/RfmlrflHkCmSslIIrfYezBms/0A/wlwJVzWTcqkyC
 iNU=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="251844688"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 23:05:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8PuFXcqjVEXPv+2yJXCrySZGvCWUQ2QDJSbFcHaa7PeqCK3zApzrhKWqNbw/BTeOTVMPhcgw/VeQC8p1mIWUlguzU1icx08IfPZR6by2w9pgWHGDM1GWYiIEcOV21c4NGJriyOc2aKy+7Gw1XRQee2FItylFD/6XeajPoS9CZubb3GISjKGyM/GnLMiSGI59nRf9Zf3fTIA3ABfa8E8lX7Hlsge+VRWQmHeRtmUNvAkr09X8RFGVv09GL25z8PPAoUo6Ltps4nI8K13zfJXhKTQdFITL+Owtwtn5PAVLwvFnwFwatsMfBFOYp0GQFgQT+RjqnrdevBnqzpMRz/atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNxcah6Myyb8s+k3QP3hBx69njUrIDGh2i5sHvVivbw=;
 b=BhRexIziebYFi51fXcNSzcUvNgE6N3CcD+CL6jiELLGP40FAejFljJFb2q2Zgpc7QnKffCV3FQZ9Qj/E4+7ndIOazxcJR3IFagBD4SXdVqPoV4BQW0YvIMOw4RIZWE5PKZ9CwHsCiX8tsUPuaPDM6fteT5lEOr91xumRBq0/NhaIubnJ/dF6yix/4PglsAEkRd6PwnNIbXjtYwaWwFF3oT9/8xG3wKu0woWLIXJr0vP4yfwUVXB1VAR6j/fi8gqg8fKHqDmUDtD4q0iA19kbxJNjeIwaWBfDpAkskpELLAn+DTi0txqnSNzcOC3qRnuMSNxw5RFeqC5Ky8QhM9tJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNxcah6Myyb8s+k3QP3hBx69njUrIDGh2i5sHvVivbw=;
 b=ZHtc4vKmR3UQujXeTUo2iRe9BSYNGyCWQq/pCQli8tsm/zd1x8u1CR2uzBb1x4fuiIBx5SmgEB9O0aFALGuNYdK42hrBfX/6lS2UuRnHSlE3K94Q15jjYCA2EaYEn1gYM2yZ+n2GpF7pGmyBQsixPmgCRxleuNfXK+NHr655odY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0375.namprd04.prod.outlook.com (2603:10b6:903:b2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Mon, 28 Sep
 2020 14:49:19 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:49:18 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 10/20] nvme: freeze the queue over ->lba_shift updates
Thread-Topic: [PATCH 10/20] nvme: freeze the queue over ->lba_shift updates
Thread-Index: AQHWlZPXz0tAoMychk+WgGF8hhAQbQ==
Date: Mon, 28 Sep 2020 14:49:18 +0000
Message-ID: <CY4PR04MB3751100E2E228636E9BB05CDE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93631439-0639-472a-1010-08d863bdad6c
x-ms-traffictypediagnostic: CY4PR04MB0375:
x-microsoft-antispam-prvs: <CY4PR04MB0375D356C82F0F6E308465BCE7350@CY4PR04MB0375.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0I0mGM6Bhb68I6/fkPrKPC0Yo4IZjktBU6UDt8+C0Q1J7OGEsDYpyxIqw3hYjaTrqHoHDto/XGNy/ixSuXw88A2sVfZXK3y+wTleoZwnkpfYV1os2UGdYMboP8cqq8gaOtFAyyt2ujzE/4sV0AvX9+QVcODAcXSBDw///R4svf85rs44G6E3BsorSMFipLwa9hrW0ZcVDH4znFE/rOvFppQUNYfWlL7WHkUEGQRSpPgDuwcGXUsUkVaKDdpcIzmYw9qSb0uZ+EfndREZ/+njkEqTurtnoyCP/2Wa8kWT+9q2j8CnpBbI+RtQXPqJxISQhotMCcrQEiVu/pne4ZwDbl+EfKxDGlTBlsdiTUnQR1U/OEP2vjw9m0A2iWlFje+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(91956017)(66946007)(2906002)(33656002)(71200400001)(186003)(478600001)(55016002)(9686003)(83380400001)(86362001)(54906003)(66476007)(66556008)(66446008)(8936002)(76116006)(52536014)(8676002)(64756008)(5660300002)(7696005)(6506007)(53546011)(110136005)(316002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nKIMN8lOvm7gc1yYUoIsIG2JSwTXu30O+CSqKQ/qAO0OO5DbjjWklE0b2uaoRzf2l+04SJdTP3nctAa10SzejywXcbr/eVFROn9C8Bb5qgr2YdoTMbwdcHhqSrcXtG/OMdENLNHCLurAqxeZIoocUeGXY26xrXTzZHPmt5HFplKHYf/b7ESZQUfkmG/1vtsaxI2etUykDuLeg5djAInVe8gQYqbST4R20DzGyTuFt3H/X5Usj5neG/xqPzSQWpYmoGyaEZrvJKGS3fkvi9schEf4ZxNUNZ/+poDIKL6YcOB/l69Ff8KoH717iWLPge2pjFdyplGOF7gVPOxlYih7hVpQhGvYXfJ+9F/TFsU3oLg1UHU7NG8ZigRXHDnrhmzbcMFxSTm0GMnJuFMpno5Czb9QddmsVa7sjT0SQJA6qzAqwaMiMXse4e3OiKF/QXyhV21uccvuhnvaSbFUnlGbO5H30QhLH572NbuPxT911/aY287jUB1VoZi3/LFw8F1B0Zv5+ybPGeZtdvbzo3Z5PaNSxlq7XsFcUpbbPJFDfVjWqGcS/FCar3wesFKRxodhVAOBPnwgN64YxCCcoa+5ev0ylO2gD+XL/XCMtGuceJs1wlPBVpAggR07zjUnu//QwLoZpRUFCCRXXUEanFM8oBe8uyj42ltFCAKgjCvAGBIsbkOXeGEbrifSUhPyyMZttsv0OAtKYli3s8SF3gVcag==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93631439-0639-472a-1010-08d863bdad6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:49:18.1584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCWATxOaUCDmc76WADAb2VGIf5C0F7sn9ysSsgTgJd8z9LtsH23myKCmGU8080NGqq66jVdf+XDtDxjigCdYFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0375
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_104923_267646_760C7927 
X-CRM114-Status: GOOD (  19.20  )
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
> Ensure that there can't be any I/O in flight went we change the disk
> geometry in nvme_update_ns_info, most notable the LBA size by lifting
> the queue free from nvme_update_disk_info into the caller
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 443aba9c9fdd11..82cd03c0ba21ba 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2021,7 +2021,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  		/* unsupported block size, set capacity to 0 later */
>  		bs = (1 << 9);
>  	}
> -	blk_mq_freeze_queue(disk->queue);
> +
>  	blk_integrity_unregister(disk);
>  
>  	atomic_bs = phys_bs = bs;
> @@ -2086,8 +2086,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  		set_disk_ro(disk, true);
>  	else
>  		set_disk_ro(disk, false);
> -
> -	blk_mq_unfreeze_queue(disk->queue);
>  }
>  
>  static inline bool nvme_first_scan(struct gendisk *disk)
> @@ -2133,6 +2131,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	int ret;
>  
> +	blk_mq_freeze_queue(ns->disk->queue);
>  	/*
>  	 * If identify namespace failed, use default 512 byte block size so
>  	 * block layer can use before failing read/write for 0 capacity.
> @@ -2150,30 +2149,39 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  			dev_warn(ctrl->device,
>  				"failed to add zoned namespace:%u ret:%d\n",
>  				ns->head->ns_id, ret);
> -			return ret;
> +			goto out_unfreeze;
>  		}
>  		break;
>  	default:
>  		dev_warn(ctrl->device, "unknown csi:%u ns:%u\n",
>  			ns->head->ids.csi, ns->head->ns_id);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out_unfreeze;
>  	}
>  
>  	ret = nvme_configure_metadata(ns, id);
>  	if (ret)
> -		return ret;
> +		goto out_unfreeze;
>  	nvme_set_chunk_sectors(ns, id);
>  	nvme_update_disk_info(ns->disk, ns, id);
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +
>  #ifdef CONFIG_NVME_MULTIPATH
>  	if (ns->head->disk) {
> +		blk_mq_freeze_queue(ns->head->disk->queue);
>  		nvme_update_disk_info(ns->head->disk, ns, id);
>  		blk_stack_limits(&ns->head->disk->queue->limits,
>  				 &ns->queue->limits, 0);
>  		blk_queue_update_readahead(ns->head->disk->queue);
>  		nvme_update_bdev_size(ns->head->disk);
> +		blk_mq_unfreeze_queue(ns->head->disk->queue);
>  	}
>  #endif
>  	return 0;
> +
> +out_unfreeze:
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +	return ret;
>  }
>  
>  static int nvme_validate_ns(struct nvme_ns *ns)
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
