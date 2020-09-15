Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B720BC31E40
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:56:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C24720809
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMHx1uAU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eC/r+Bdu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zY6Szp6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C24720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=mxKNLCquoAAX+DauR6Q0XoPd4UsqQJX38lOT1RjxlmE=; b=HMHx1uAUjDX8inpy1GdbZ0mRG
	8VO30QI8uf/36roVs3NRAhDOIq2VvBlupxVkystmrxkXbZU68wvmwUiEjKDjY7DurEYDn4Czfy/zY
	rX6tuj3j80sJvffmxrpmDOEByyLitLh1fhKiYje17Ud/VVJKugXrRo9fPU9moX++NmnljKPdlfkhX
	o18PSmMBqsu/f/Kh9QHiLzc9hpNbkgloAo830Pka+lOtWfhOYgJULXBEPzqzi4RUroZWqcOB9l562
	Bg4h+pbDEygAz3ndwy3GKuH37tXiUXWtbtQrkDR7/nOICkPJGAFEreJOzm9CfMLGT7pNkNTYwE6xF
	P0ks4Ebbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIKof-0005Eq-Jc; Tue, 15 Sep 2020 23:56:53 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIKoc-0005E4-Fh
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 23:56:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600214211; x=1631750211;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AKXGwbw8Exhw4XD1snzBgnZrY4c+q0JBTvz8n9NA2b4=;
 b=eC/r+Bdu7lBwUFsxb/B/fLsE4Mkmd9gpQBEAZxm8XxoEybYh/6uVb+l3
 k45q/7qsXuy053z4ygzGzvbfOgdylvK8qLnwKyqbEyualDsTt53aDvT6u
 W1pZGptC5VkOLyZ9DjIyqYaxClGLFneDAOLa5kdD7GNzb/ruRqH/LdiWI
 1088Luq5n22FGx5zuV1MdWFgWrucfNH++z/v3HS+NATHVh7po0Zv9/BMG
 QS68TROTGtNixYqvzd9mRdmzuo3RtT7kiqNbsU5O6+05QHBQinPD1z9xV
 BtgcuSKnujrUwvxJHB2Il3pieGod7zB1WKubIaH+vS6lHqjb4r0kitTqU A==;
IronPort-SDR: PCSscWU/GeD+b7NudYYEQ8wlvBxbuIDLPOjNT2U8IGS4DTFJzD05Tvp8sINH+7no+HYKhPkSKY
 bhum5uA9nOkTgn4tO/UJvByOtkKQgmbScfHlScmFMtMHOkVwD0UefrqGNkVw84W6RX7qRpyhUf
 U9Gu705+goGejVTv5GZ9SYJSEyKHOfhmsNlxpZoP7Ujfd8Dy/Nuz6BrfCqf36YdEHCMB+qhFG1
 UFuTMI26LtNETTGIxMauqs0YGTqKAsIlG/E7imN0lP10nq9cr5rKMStGiivvoFPiTLDAI0Dcnk
 3C0=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="151836191"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 07:56:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc9kziU40m9q4P8M6S3jpkEFtnFvRNS3qjTJhu/U4xsT7MKRYaebx1QxvcC/WOsIH5CAVBMd8NBGeGw4wHXmBViRNKxII0vX8+UxaL/3WVoP6RrkvSdig/e5LOJ3rtxlxQwAl4MpWB8v+UzDO0ycpaDjIfVN6pxeijkAn2AbjDeXDD3M9UDX+qvugTtRp8izml84OnJ+oIzhOb87LQnln1u0WoT5LFbQYeAE/PwD5DqnYqllBkWGAdTwhmg8cVXToczjNNkcKEjZ8SN7FSm1Spnij627vpLGnxZZIllBSzMb4ao/clx//rQTCAMBWOZcmP01BxLudy6CBLwHiyp/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kItpYBnyJe92OmxJzaURO8vmaFzWQa6Cg8IsMJ71hm0=;
 b=I/beSoyD3wU970DhtWOZislE/ynHcrIybqnzqPnU1VYnOKqpM7Iz02dHJYNPmWIcluJ7bhMRGsFFGOrLHA8dJznQHQ1i4WLK6GblcpMIdqjG52q+8CZkV2NXeiaKCjDYCjdRhD7Kvr2QryYio/xZbxfiQ4TzY3v+rdkZVqeerOk3uB2E8MWJtnyY4hrhhg8atxS39sCiylFPFiIw7kYcqApNt8nCADVImcRrZEtsFXuksV6g8CjpgZJKbGjzm5e2JlbTdu+JZDKybwHooLfxHF6wYpZDEigA2+5d3AX4AeuvrVp8fdyB+076iw7RygmOMGnXQ3OxihNku6ThYLGk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kItpYBnyJe92OmxJzaURO8vmaFzWQa6Cg8IsMJ71hm0=;
 b=zY6Szp6Gsq3KaxRSRXTZ7eXVls9ENrni2yrG00NNtkSgElEccsxij0c1vGpmQjTzi1d0xmLUwyVjcfQeg3aA+N8rRr3m7Ji9n2mOVw+yttavjFLBL9nxRF0eooJ/ml/3sUmp43d4K4bHjT3IfnAFBM6SjZwJ0vQgrCcjDWoLoqE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0569.namprd04.prod.outlook.com (2603:10b6:903:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 23:56:46 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 23:56:46 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCHv2 2/2] nvme: translate zone resource errors
Thread-Topic: [PATCHv2 2/2] nvme: translate zone resource errors
Thread-Index: AQHWi4yBEpsiQBwb9UupBn3tJNUrww==
Date: Tue, 15 Sep 2020 23:56:46 +0000
Message-ID: <CY4PR04MB37511B210DF4E12A481E0268E7200@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200915181230.3674743-1-kbusch@kernel.org>
 <20200915181230.3674743-2-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b178:89b:b9c7:c5e0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c122f0c-ecba-474b-6951-08d859d3010f
x-ms-traffictypediagnostic: CY4PR04MB0569:
x-microsoft-antispam-prvs: <CY4PR04MB0569F2AF0B563A26AD7D9AA7E7200@CY4PR04MB0569.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlQ4ScThOIuDk52qHvUJ/tSHK5lhF8jN1qkGQB94dcOKc4+OHzW7oJlEmHlQUq77j3jj0CuLQOd9e90XhPR4LVP412h90sbqq8OpT8KZp35nb6M4WaXTX+5jtp9UNIPdrHo6zgcJpp9w2lHHcVu6FlthEPyV9IxINrutEgg6z+q4p0tIlw5UQU+5sHvqFflTnZ4AZj9ChskptVJwYYMpRw7QOvg4QHsM64Lp4hssJPZsuaJfL4QYZSnpvEsZVfEWdrUqX6Vsmk7hyOGk0yaa9X3XmfgUOkfyugb6GVCvVnjBXBT5d7fcnPtLIYOc02YQs+x3gn6ZMqz5HgS4uJ4/aw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(53546011)(7696005)(8676002)(9686003)(55016002)(2906002)(6506007)(5660300002)(316002)(52536014)(91956017)(66946007)(4326008)(186003)(71200400001)(66476007)(66446008)(33656002)(64756008)(83380400001)(66556008)(76116006)(8936002)(478600001)(86362001)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: OQO/L/Ccs91k0WRuK7Zq4hNP7APghxCXttow/hxezcRg6IC0UDGtMu84Y1i7b0MJdRX/Q0IB92m4itRbpaej8fm9HgweeIt0sPMhhdu2sQ9MqN8sNrWtWCxNM8R/XQz5nDpW6DHGWJhqbA0j+DSgueoRGXBR7KO6/q41w1I7UogNuS9wnFoKbOi5iQ+THnry9Ane5rIKNTAzKyfoJZFK95xdlvLr8WJt4/7/gEQGDNf9Siwov9inGaySjA9V61wp1fWiafY2sTFq19ne19FEEFsKFqB6KaGYdbavfZ8/tl6S326bq9A7Pge4VHpXzAR3r/ex6q4LH7CM5B1qM0Rkm4CsSdW2ibP5notNv6DrBZydBQyx7sDSiOEKCaGgd7SQYOT1jqraYdDuQn0P5IJ6boI1yADapykO1AC8d439PGIa5NKpda82AUEYvvZY/KIMaf4BYIp/mXL9K/38ro/70NCi4Z4w64NzgXPX9hai7xu4kz39k+IEbFSaJmmsXNl92mdTYKQNEzcmyB70AukoaV7ujR9vgjpP3Z2+I1JloylyWqcamnDRNdoEe3eomj73SZkouoPG6JPrFAfYfXJWbEvDPRO+TVVDKrDHQ/oBrU6/aDy4RPycbbEM8S3iuuOyYXg1Q+MOVO2jz39oMJRKFSz7fYh8BS8bKjIXeHyM5DrmPPPZYEp4Jo9IUotSobX5ohM8mjEsSAtmM75uIqTz2g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c122f0c-ecba-474b-6951-08d859d3010f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 23:56:46.2334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEKln3hOLfBrKa7hk+agmrVMKkXHwYk0PvI/WZHHqirPAmWd2Z7kiXZ+4Tj0ytKAGKQxr514sPnFacAfPx4DiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_195650_724367_DD63407A 
X-CRM114-Status: GOOD (  16.25  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/16 3:17, Keith Busch wrote:
> Translate zoned resource errors to the appropriate blk_status_t.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Use BLK_STS_ZONE_RESOURCE instead of BLK_STS_DEV_RESOURCE
> 
>  drivers/nvme/host/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f3a61a24d45f..6d5c95a3e03c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -236,6 +236,9 @@ static blk_status_t nvme_error_status(u16 status)
>  		return BLK_STS_NEXUS;
>  	case NVME_SC_HOST_PATH_ERROR:
>  		return BLK_STS_TRANSPORT;
> +	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
> +	case NVME_SC_ZONE_TOO_MANY_OPEN:
> +		return BLK_STS_ZONE_RESOURCE;

BLK_STS_ZONE_RESOURCE is used in the submission path to tell the block layer to
"try again later because the target zone is locked". This is used by scsi for
zone append emulation. So I think it may be better to define
BLK_STS_DEV_ZONE_RESOURCE to avoid confusions, and that would also clearly
indicate that the status comes from a command failed by the device, not the
stack. Thoughts ?


>  	default:
>  		return BLK_STS_IOERR;
>  	}
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
