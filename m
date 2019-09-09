Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7160AC4740C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 16:48:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420FE21479
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 16:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="STnEI5+k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SJfj1Tb/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LVYSGtyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420FE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4s4S49z0P7tqCuqJoUb6kyS3i7zkRVsgmFhnBKOWHgo=; b=STnEI5+kWmLnYF
	ARy5JVRHPKr5+Cv81cz6oOCesqVvi0VbOyjlYll8haFfk5hW3Umyq1nv7QQCnjjqPIAvxlTv8LmZK
	6/LskVQ6O4hfsj9XrnJzaEoT7FNgE871us7nz3ql/PIzkaQCjDFPNkJEEoarmriz5ktGmBvydWefi
	xQtTa/jka1XmiaLg4OhBP62FfG7Pbr/OCfLaxw04tzjOXAC2+cNefMI5He7V0Jaa5sYEnXYtI9Qdy
	whwpqEqDNUorZbYh3PCr9AKnyXEaPkJkn1iekZCg++9MsR3rkrx1C7dj2pmoV6iEmi1x7C1NDmKFu
	fkRblEzD4XaeQVOzvhkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7MqR-0003P1-TN; Mon, 09 Sep 2019 16:48:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7MqP-0003OP-By
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 16:48:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568047730; x=1599583730;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=EvsevR1hVm4+YLmRHIKpJ/R3fmt2O3BFKEZGZia3/aw=;
 b=SJfj1Tb/j+6533POdHehNcN/hEFz8/Hy5SkloTxbK6atsyhaJj96XRWx
 QZR9me4cpP7bWBN8wKgKhOU0xXuVMbwgKxCTYygRYoLGMzZKgg+zvnnEA
 vHkFBUcIiAeCuIJUhGpf3DK9kz2zRkzhipmDMsGFNaUbBZDNXxIn2poQZ
 FpUCLfzK27XugquqnXDhqAGfoWFPt372qTb9eC2EW0KanRe3yjGpTrjiM
 4kjdFknV6emznFRtURl6WEm+BWW+AQox6n2M2Bi2S54OnppaleQVI8fjX
 VzuD0lyTVhx3WxKWWKqAww9ghadbuJ5TZlebEZSf4EvrxXHakrA1y5Ynr Q==;
IronPort-SDR: PKvLB03RZppv2CgyrKYYqmYBSehY5ow5VoRKWFPb4gp5GbxwZlz6qEQ0b87kYcvS4QObmgD5pd
 lXA0t8qf+af/ztbyLTqpNONJwVMATWxSmC34wdw2skoKqALZTEE81U6SNIB9ehMjr7iVuyfQGO
 pWslrgkp0OdlA1Bq6y/HPCqQg4MDtq7e13kwXF+UlaJNSiWc34cG03wrsHl7mVr2ir3Sv9cU/D
 Jnv7wteCg9DwCyX3GH0obKPggvvCZJ8c9VE4hUpc31RitsVKCEskKeyZG1m5Fz7VGfKelOE+65
 NmY=
X-IronPort-AV: E=Sophos;i="5.64,486,1559491200"; d="scan'208";a="119418011"
Received: from mail-sn1nam04lp2054.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.54])
 by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2019 00:48:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhOfu8vT5Hfz9BxOaWHeKl8vhUOh3KCSxZgKIiCnVI4TND63P3nQm1tN6xMHadqG+eciwxT0yIwK05F182QqTyyjAl9Mz8OsIxkGwDGvecfqgQ4qpiXEZ5J4TwUF2Gzsr1p7ka3EZdAjXaGLwvfutpd4VESkIaKwVyJtg3wDO/k35oQC+jWAJdwGdcB55TtLYTSH/11kY1a2sgWjsxzvE39G5Fy1uqx8BzZc3bIyEU4k/KAb/evg2ogjVigH78C3hIgN3CCUFhWwRl+wAQvz+z1gVRM6FGqX0m5qFdFSTUSzEbOtC+3lUHWafA8XWuOzGlTsFlp9hcgQ09DTUbNnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/40wtCRft/o6frmYG9TvfnT2N3GWbZ/kOBl5wJJa9c=;
 b=IBncsVzPgjxx5eE31QlDDIdGP+MPsb0WF9sOzyv6i+uapce8i2NHy1rMk4VCND87p+eHDoYGDt7LxZirjnk6xQswt8DygaNu2XZK6PVgp+KZ3n4NdRRPvYEusGFj8StD8oDNmr6d+qNm/DNjDLHyIasCVDPBRvKLbM6qvGME+3slcvlQjMJVZVhotvoUxI8X1Fo00y11hg+bq43HFZpT+d0fCVwl+8pxwqLCvK1vNQOMZrNbSJQIw1ymkkdne/JQoOQuYLChBVkuZ4+OV53yZr8qAZ1UVd54Z09svgT7nknMvC0BsY+W3RMRsC7s212qbkg470ZjYpgcosdBt+iX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/40wtCRft/o6frmYG9TvfnT2N3GWbZ/kOBl5wJJa9c=;
 b=LVYSGtyq2CRIJ6k7e0hduZPu/xK2Vukbhv8w4KkHT6MP41N9hcS2/p6HZEr5UC42Vdaih+fPzQzeI6Y+Y10fmtfZoMGNUrLURNGDL/Q4TjQ/tCdesPwvElWZ1npeJsha337Kx6p2U9FgGuQFm+Nqcl08c7xWVRQeUnRhqxYhd3I=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4167.namprd04.prod.outlook.com (20.176.251.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 16:48:45 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 16:48:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4 2/4] nvme: enable aen regardless of the presence of I/O
 queues
Thread-Topic: [PATCH v4 2/4] nvme: enable aen regardless of the presence of
 I/O queues
Thread-Index: AQHVY2w3udF6DU6eMUapjs0YxzZeTg==
Date: Mon, 9 Sep 2019 16:48:45 +0000
Message-ID: <BYAPR04MB5749DF690EF3CBD9D390642B86B70@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190904215954.15423-1-sagi@grimberg.me>
 <20190904215954.15423-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d589753-e858-48ac-9960-08d7354594a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4167; 
x-ms-traffictypediagnostic: BYAPR04MB4167:
x-microsoft-antispam-prvs: <BYAPR04MB416776101B7878B1DD6175B586B70@BYAPR04MB4167.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(189003)(199004)(66946007)(486006)(3846002)(446003)(476003)(305945005)(186003)(5660300002)(53936002)(2906002)(8936002)(26005)(33656002)(102836004)(6436002)(99286004)(6246003)(316002)(14454004)(25786009)(66066001)(7696005)(76176011)(4326008)(110136005)(6506007)(53546011)(8676002)(256004)(54906003)(81156014)(81166006)(229853002)(9686003)(6116002)(66556008)(86362001)(55016002)(64756008)(76116006)(71200400001)(2501003)(7736002)(71190400001)(74316002)(66446008)(66476007)(52536014)(478600001)(26953001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4167;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JgReleQq0RheIMbhoPEqD53aYCSV7epIDKjPW4LEMze/Q5il7Epluo4SxSuxCU2cur+sz3EjQgFIGHm/wj2qR6qrUJW60pwg2P5OucqqDTtgD/7/IspCvkhVd+69Pbu+EqkI+U/sSfloQF5RmxZExxAm8Bss7v3oACcLnPSyxBI1hn7dswzTuE04h8pbtk543ScCtQyhDAzheoOf7wl9cS3gxhT4cv998q5tGueUmhR4gmMQU51M6P9F82poSzqN/bEOLe5ESILcQzQ07v0nNj+5P3nMirD5phAvH7zyikOnYkgBSQZY4pkiDVkL557Is3FfIdTTx52FxNhtHvy0FeZgGBTqJDnDbQjwwqSdsZ5zZWvzuNJkJn8l6wurW7LdJCktF+9LJ4mX+WOsRQyCqOLdRRCj14vPdDlui4fXTxw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d589753-e858-48ac-9960-08d7354594a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 16:48:45.7335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9O4Ae4zttOHa/3PVB6qKvswzerj335kWjm6DLO3MXZqzuU+X1eETi9h/lpNuJGTvuA6Ti0QmrSrYLizvFY3tSkg3Mrk8k1kqZ/4X7fFkJbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4167
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_094849_446347_59513D66 
X-CRM114-Status: GOOD (  17.24  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 09/04/2019 03:00 PM, Sagi Grimberg wrote:
> AENs in general are not related to the presence of I/O queues,
> so enable them regardless. Note that the only exception is that
> discovery controller will not support any of the requested AENs
> and nvme_enable_aen will respect that and return, so it is still
> safe to enable regardless.
>
> Note it is safe to enable AENs even before the initial namespace
> scanning as we have the scan operation in a workqueue context.
>
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 14c0bfb55615..fccf28d77c03 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1201,6 +1201,8 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>   	if (status)
>   		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
>   			 supported_aens);
> +
> +	queue_work(nvme_wq, &ctrl->async_event_work);
>   }
>
>   static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
> @@ -3780,10 +3782,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   	if (ctrl->kato)
>   		nvme_start_keep_alive(ctrl);
>
> +	nvme_enable_aen(ctrl);
> +
>   	if (ctrl->queue_count > 1) {
>   		nvme_queue_scan(ctrl);
> -		nvme_enable_aen(ctrl);
> -		queue_work(nvme_wq, &ctrl->async_event_work);
>   		nvme_start_queues(ctrl);
>   	}
>   }
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
