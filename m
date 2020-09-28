Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06803C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:19:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4934321941
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J7oj0SfH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j4g0N4Lo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MiDq669B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4934321941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=j2bIx8BR4CCvoBAUhw1199mhGBTM9J1vEgEcLPrbmEA=; b=J7oj0SfHuJjXRO/fJYKjylgrS
	RDYJk0Giiy9ci+s9N6DLPjJA1IzrUgCi7mRL7UYMvES3Q0JhR+Uwh8r2QjswmPa/9ZT1ROmXN62/h
	IU99xBWKFqnXEKLZac3MKGqQEhS6qJmIWpbp65+Bmoxu/3qu9nxh0j/mMEGzIQn/L0rkHvOmAfDJt
	quLutUIB5KptuFhMm6k3j07Ags+Zhlm1MRcW9jceEJsDR7GmvhK8uAmkrnhTAYGQr1mTus1Op9Qs+
	q1kW6/sMZe467kK8qxP8kiH4J4guWSi72SzvmJUveRFDYQwkpuaeB+d8nREOWwJ37eWIx0q2UmCkk
	LCVjMUZrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMu0M-0001iN-JF; Mon, 28 Sep 2020 14:19:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMu0K-0001he-81
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:19:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601302823; x=1632838823;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jEHUAOqf09dq3qFCoROIC8rb1qFLXSAWIMGPY5v+X7Q=;
 b=j4g0N4Lo+TIExcpBHL0m8haqp1kRohdIgXe7sKqbEiaOiGzsnu7Cl7KX
 0vyCmEJXnlnLL+F25LzKlVrpOwYDtNSWzvuv71veCHIps0U1M7jcD0Ux4
 reSc9OakPhAaEQeBnqofhXMVJX2uYsz1TqmkbVLkPAvtrgMSnDZ4HHvRU
 +Uwt16rGxHdPF2Jm1e9jP+hFasUV+m3SwRCXyIYnyJmagSrOugkWvpKdS
 yNI3E7DJHUHD6a0TKT04w4rCrDN/PCRz+B+d+3YETWde8oqptLrGDFbDA
 CpE9/p62qIFib7D43PpSePgPmolSGoK+YeRASnWNVafvrZFql6DyZsI/I Q==;
IronPort-SDR: 8JK2hVDG04EMNnGiGg2C6CiW/i7aadpARJF8GqWx8bmDX8zgT8xVqO009MqAoRkUYW53TTY9nk
 gSrxbQeq7cnv+gXiUQd7B+etdEKyLPB1k9r2rgenoxBw56pJMfcqLrIbcYJyYt/6UyjeEG6wQU
 vgdEC0mBhf0gaxHBGZwXocwj6D8MovSMPdcx9PsLeDx24EhdT5I//m8Lh3ldOjhaaa5RQiiMfZ
 Mv9Z0Yh4HHu9XTctJUJ34ta5bB6nviuOMXsBCfmdFHyOTaLM+zYEQViqKKIYJTkmLpMpINd/US
 U7s=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="251842787"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:20:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm7M3MtjvAsOQS3M98xlD1DEkR4MfGslzGakKK8wXDN8rVra30m+3SeGiGE7W61+TN7oK/q+2V9nEJEuRAnDl+Dox3YAkF4SEh/YPTea46JRaMhM0gWFjOzPZ4I8auXJ/am4xbNAqHnVF7VNjKN4RtXs/v+1BsNHd8ffqJzlAz0giEY/fpaQBa/1kBTT0ZYbFGLH4pVZLheHzJU//gSlKkIWgN1Eb5A4T2dWu9LzWuS/DmQ1d9zEd+H3nGoVr61BcjR4RLoV5V0uBVhXsvZAlfXKaIKIUdmVEyP0W3c8rVZv/9vVxnH9h4Q+TPsDOURFi/hT0u/lNuPP18J8rEDmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plwUZssidDd8+zlDOm7oy8Qfb8a3XYuniJd4Z+XuMzo=;
 b=T+fon3NbZ+0S1c6PObxIOGs0EXHAxBG3mhqbVDQmCuo9Zn0eeb2KLOAp+iCW6H8tZIFGFVUeEv3VHbcdBz1AhvllbF3kQ5uuu7VuEcz+UHQMWIC0gqPwIK3ZFBY/5wCfGXrY/OO6XQ82dzsk3l4+6ahmvyVG+58eoFsjg5EHEBIXw4rPPmVthXgEZQhju8HfZOD5upPGX/ZbysxxxHFXIwGARUJjXDcX9FqFR69UkTjMyMIvBA/2w3CX+hU/Y1bYjcKgRvV4AFwG6UrBlei3EFitf15qkBEfKfHvoFpnORqWbXZbsofzhPjt2rvnzgY1OF/Rps2cWZOP+X8Of7h5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plwUZssidDd8+zlDOm7oy8Qfb8a3XYuniJd4Z+XuMzo=;
 b=MiDq669B/ojbWnPA+5QuXn2yBEX60sdfr/lJ5lVTquQEJy8hrlDmKy5YdFk5xXVyb+lXm/rIcPP+jqlwzbMF5oOaTaVYysmyoiRNzQ7QNa8QkYKFDFOXTOodZeJlSSb0Igs2FfXEFRMLCSyIvHi/KO0HSefGn1pL+Y1Aia1GHMs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3636.namprd04.prod.outlook.com (2603:10b6:910:91::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Mon, 28 Sep
 2020 14:19:45 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:19:44 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 04/20] nvme: rename nvme_validate_ns to
 nvme_validate_or_alloc_ns
Thread-Topic: [PATCH 04/20] nvme: rename nvme_validate_ns to
 nvme_validate_or_alloc_ns
Thread-Index: AQHWlZPUS/q90JkG5EWFch3Fxx8OOw==
Date: Mon, 28 Sep 2020 14:19:44 +0000
Message-ID: <CY4PR04MB3751D511F13C4D6F2E838694E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77035e44-dc2a-47c3-9034-08d863b98c77
x-ms-traffictypediagnostic: CY4PR0401MB3636:
x-microsoft-antispam-prvs: <CY4PR0401MB3636AC558FE95BBFB98013F2E7350@CY4PR0401MB3636.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N5UGtGBdZQsVmTitPt0pJiloM97KOnJ0gaWy0F/G5DhFBzW3A77IgtivxzN/oYe2Nwfvgdpjgz5u8Z0/GJB9B8fIKfgrw5jQZmvVtVHTg4kEuSzZdAeKrrDplKjfVmTOb2ShLoWFLmZAUiTOWjuRsosI1cbrxqVsxXv6un+Qy0VHDTBf9INP+nBeLzwCduu68ClMvJFl2v7MxfunI/Ot6tcFIW41wjPR7/46IxaE7QmDEs863U9OQvV0DX7/wJ6CH1rRWE6tiIqrJWrgvOMALjly1CVsx+v5Nl41cCR82TfXluFSWYlLfzGBW5/PCltBDWFINyeTM9V5cdGnFwIMQQd4VEnm00IK11SaAG0r8pZOk78yrVjqazqZvUOYL0dI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(5660300002)(83380400001)(54906003)(478600001)(186003)(110136005)(316002)(6506007)(53546011)(7696005)(91956017)(66946007)(71200400001)(86362001)(66446008)(76116006)(66476007)(66556008)(64756008)(52536014)(2906002)(33656002)(8936002)(4326008)(8676002)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: XnH+nJVJ89LNiA0PH6nNTCxpWlm7aU6+T8nHHlSdeY7w9/LphXniM6duMJNKoS49rvWJ9ClWuRZDL3/1N2Inrf17ukX6GNHUZZexaLPDOGgZESk57RdnEp2+jbhogqzCzhd4JV+V9QjF8MlE5/ZKh7Dw9cjKurmYnBxVZ/ow+Zacc1+3MrmnL1Z3f+um+lnG/HWJRGJFXEeY+lwPIuuAUjAn/VTrIExUVQMBCNupLXbrjnQFp8ONvxX8rH1sN2W8N2gk0IrzRn3HddElMOeSvfsB5pk5HTrGi11NEmFi9IhVCjTRQuCpIi3eoGId6fKxgj/qyEIA/olPRjYsRtxUsUpZ8C2v6aNntxlBTsMLyZJa1KoBZBHQX/eGRXKTe/fwW0Y9ECTCsbfZ7fiUifKQSXVbyJcqN9rEAGOy46JSAcVKYxNW07JVFp5UoibN9ANrbBVSPhadBsRixww2cFzyyO2EUWW1RIj6X2nvH1OWNZxqSLUNg7QqYG/OcuKo0DYLKfiMYNjLTYSmqqAZjLSBoQefS36ZaV13oMwV27eH1gSRTYZNhuyrCBrjvK0RCKAaJo9u/ZYNJdKAI1mO9tkIz2Qj9ccxDQIRbky6hWnpuhUs+0CE0NvP7hVqC6PkLdNmxywaVgJ7mORCAnd/k77ONdfREZj4i5LZnr0McZCwpOiZ6VlS+7uP77Zt1K1F0WDjxAAGsfwJgA+cf86eV7I/Ag==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77035e44-dc2a-47c3-9034-08d863b98c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:19:44.8711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGxgFJbJWbfsKJ/if/bsU8/XViAx7LtSxXml6NudQY5AhBwSc2kSlTIvylgDlDuQjhXQjdGnve7jWt4eqVv/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3636
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_101948_397960_D2520CB8 
X-CRM114-Status: GOOD (  17.54  )
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
> Use a slightly more descriptive name to enable reusing nvme_validate_ns
> in the next patch for a lower level function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d4b5032084972a..c5f2615bf58374 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4021,7 +4021,7 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>  	}
>  }
>  
> -static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> +static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
>  	struct nvme_ns *ns;
>  	int ret;
> @@ -4083,7 +4083,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>  
>  			if (!nsid)	/* end of the list? */
>  				goto out;
> -			nvme_validate_ns(ctrl, nsid);
> +			nvme_validate_or_alloc_ns(ctrl, nsid);
>  			while (++prev < nsid)
>  				nvme_ns_remove_by_nsid(ctrl, prev);
>  		}
> @@ -4106,7 +4106,7 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
>  	kfree(id);
>  
>  	for (i = 1; i <= nn; i++)
> -		nvme_validate_ns(ctrl, i);
> +		nvme_validate_or_alloc_ns(ctrl, i);
>  
>  	nvme_remove_invalid_namespaces(ctrl, nn);
>  }
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
