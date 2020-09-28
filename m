Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564FC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:57:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DCA21974
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="POIov0yG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fVGXPVIx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GRKXPinf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DCA21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gR/YTMAarcPVm++Pet86LZ+tLgBZhi1VrZGo6O/k0b4=; b=POIov0yG4BOzan6KM0IAEBgYI
	jpxxmJXjpmhrUznAgZK0oRP7JjkIVneqv8PnK3SgasnzN+F2BlMLRTvJ76RZxyUhp7/NkYJgxZuVH
	q0WmG0CzkeGpZz/hyiaxU67PjwVvFKqDqCFTfPA6eJWJyfG4M4KPXFauf4wfcuM2dDn+5xBr22CL2
	O8f1EPSYTKeftH8DQZnz3F0l+D8SJBvjD5GzKuakgPDoOrMgcB/bQST820XyR2cXffVdZVdGbRO+s
	mWiVNjwQ4TySYQK6T4ypNoOm1v48O9rP2P6HxCwUJT+JZfCRuzkJGyDDePqtIgmro6pUctBcFrQa5
	tfRsejCUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMubC-0001lZ-31; Mon, 28 Sep 2020 14:57:54 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMub9-0001kq-9X
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:57:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601305071; x=1632841071;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=A5ieQWebqR0qonR+AQPT5iPt8MvoZElJiVzBFS4s560=;
 b=fVGXPVIx0dxweT+gw8s7TkMneHc49F81QxaWY2xaxd+KTXVwLND+S97H
 YsI2IQLEbF6PR+TQxDek1VgroPwt7V4BdWGwFyXINvlE6oVS+kJrTMd05
 crQyWktmUaaR+ievq0VnCLvKrhvC1B39mFsayyu3tTCCBAbeObZ66gVvq
 HskJ1BIbasV8qVSCdZhmSKi4O0+2pyW35XYVpvMtuPFQbYtiXWZRK86m6
 t3PdWgW68MYlG/Sfr+zw5PCxXVyYspq/vLzEkUt9uWqZ6dk5gurmrLhB5
 FQeLepX3MPMooE2eUgAFJJPSfQmEaZEf/Ul6XACgE+OIiIlXWvT3q9122 A==;
IronPort-SDR: 5p2YO0X53P3LQ3LxnClS+QYPjAl0KbLz2VFwZqdOmZEH9XSWdz6YuuKeChXbn6GKeaDtjilimO
 XOq+yPFVDpFmHnEFwRYUhL3xvJUECCZ7dhQFWD7i81UZ3a9SSK+GPhwtrrtOPRePNMKB/hHYGZ
 JzurXfoOx3+AniFdKoO+XltyPRrjcZI3jl2D66AxKQvrUCITp1K1vTyr4ZtRicEZs4lwqObPgO
 cawq9Wq46zMbLWnBmg9TZa9UMRURaeOcrTP1LVBwvVTeZfwmCJ9PTNNNCnxUawFAW0MAMEQtNF
 RBo=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="258172638"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:57:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYQ4e1Hh1XTaB+VHCGHwx3HINTRhOQdaSS/54XNYdvo9IQguxzqrmJL3srNqe9NdmtjPxvJ7usZOQF/Am4qVfdd2YCH2iKm1Htz1V+4Khnr350n4d5U5fME0M4+NdlGWmKpnthxllaKqi5qS9E/V5GGST9nv2i9TqW/y2zlrmNB6HKatGZgfVsUe9nV1Bo9+z9eQB1o3tQ/Ayq7chAvyCjNPs+IxWS3wfYgFKVGz17rVlIbF+AkJHJBq/cm199m+Xu//CA7ZcxuJWXRZxfapxgH/3XAmLbT5uaU+zPNY1XUDiG1RAB0aFAmjHThMz3oSf4RHbl26qkNqeQ5UxRGhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuMj1soUBy8gP0ZOgbri28EIx+y7eJ/Fu+hWQ6iQFWw=;
 b=LLsOo5QJPRK2DRX2h+u14uRkth2fzk0hQkv14YHtJjHr61LZ2Bb471NTXVzh1PgsYA13baH08KsmjcNDQHYXPYIualiLspraiqkCnze/GEoziAqGJ1bImOkI1+IUWdBuKoEj4dgnfAVSRGhqh8l/MQFDOd1YKZhPgBA7tVVXGY8U67O+XZDElhvGj35L/2kj89TucbYBgpentzrQVl2ISTaJCMmuj4cuChV41WPknCAbZi+PgCbhWPDM6fZSZargnvb9gahuvIqQM5Ca6Wx++boFeUcgq1S9hvwfxsxtgu4B9EvA4EvEx7uaG4sV1HyhajQw/ngwn3A1NXn+fv6lvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuMj1soUBy8gP0ZOgbri28EIx+y7eJ/Fu+hWQ6iQFWw=;
 b=GRKXPinfioNr11pQerIIvu2rmbqi3xIeFXZ3tdk4SwzOBB1itU440TfA+kCeU/0jdLfthM5bVWJYNvHesvQyuMKb/1mPf9at9m+LMdbm+vJOUrZQu8hoCLCcI1Dp0n+Rh7yA6IUZ247kemGAEN/H3GTKbulLca7Kha2pwy/T3Lo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0377.namprd04.prod.outlook.com (2603:10b6:903:b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 14:57:48 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:57:48 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 14/20] nvme: update the known admin effects
Thread-Topic: [PATCH 14/20] nvme: update the known admin effects
Thread-Index: AQHWlZPb2w5ulO3Aq0CPFl5oku6iBw==
Date: Mon, 28 Sep 2020 14:57:47 +0000
Message-ID: <CY4PR04MB375131C2DFF4F6B478E8D8FFE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06666be6-4c6f-4263-5629-08d863bedd63
x-ms-traffictypediagnostic: CY4PR04MB0377:
x-microsoft-antispam-prvs: <CY4PR04MB0377830F68C237C7CCCD5A10E7350@CY4PR04MB0377.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eyAXqXZQPkTPTYJarwId6paLDs3yN7YSfcfvn8+sa3s+1Zkf5tPa+CVVvwEfAMZlvBss8QeWZKg4s5Z4eEgYWrto8e+lInjmE8MEHSeJ6N6wgHHJ6e88egX/tOCRzPL4M+/x2PTx+n8HaHUFbgss56CkyQ6qdnz+n7D8AIjo3M47DjCKWodeqCkdpaTVxolABojq01p42MjC2Qn+xu15xFagDn8vXgDk/ubqfs2CLLJBe5eKnOX9PbCpGrVp/eBAbagQcA4/MBfVb7rrChzPZe3cN/YFiyKNzys5jAm7jZNWSn7gZUAAhIb+C0VM7wKHnIsrRAb4ZAznv/nVGA7nsmiOevVLZ92aL7iE+qpotGjl681amN1ictJvJoc2jp5v
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(66946007)(2906002)(83380400001)(33656002)(8676002)(55016002)(4326008)(8936002)(478600001)(5660300002)(86362001)(52536014)(316002)(66556008)(66476007)(15650500001)(110136005)(54906003)(66446008)(64756008)(7696005)(76116006)(186003)(91956017)(53546011)(9686003)(6506007)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 1mvp4htwnyNU/Kgt9rVrBmJeZNVv16n9SysEci29GJsaJwWjR+861eRUdzFSV36pCz03er+JscBiRxXqkBZVJF3gZq3Ony55+JGLRiDo5fN25R0ueoSmCPbeh+opwGcsWdH5Gem1rG38DStWFsgsyhzGR3sFuAtGGpW8GimWfayRsmzisiI0KFP9arnjXXCyApHt9YVgWqkxVHdOTE5o+hr8yTfw+WgHMElEDFd+357ngCL4KCkkHrmZHRKtRFSSuYbXwA22IbBbKVoSqE6JV8abkwnzgJNXgQESP7DoPMOI5jMhMmtzbWnAhXxk8QHyWPbdMUYwF7LRnLxBKCeyArjL1Ef+7pEfzvW7qbmiaq/hdcGXQopQcYP2SzE0TzkPX7T5dBw3i0A9ygfEF6lIqwWja2GX0zw7Xzz/1jRjAnyyc2sLmFsOnWkASvnH2mPEo6SdTiP5mUFa/nn22QczTctMdOCOXCzC8spfBmtHWjn5sCoHx8macM8ukdGUIlnu11m6vE7vzk8Gk2hZVSng/UXt4Poru7xzmG4VEcgrYYiN/JcnxbENfl0S1WrhsWaAJjUrLux7kIbecllFbX3wbYEgjhSOBcIu/FmlafUjuplgYaXVGusq6sBsu0V/qcsyzpID9rnPsrJixTIvC3VZm4S7IMDMmrHaKVnEeYLR59Ye+VA2x2zTKp8EXyoXDibGUGkW0YQDpKurilDocTsz7Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06666be6-4c6f-4263-5629-08d863bedd63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:57:48.0007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wbf/KH9jv4vFJ+f2bXVl3xQSCcCBOzCL/DujrjqpW9vBWICPUvhwBShUEnc8FzP/0poZToY+bpXDraZRKix0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0377
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_105751_499701_6701928D 
X-CRM114-Status: GOOD (  17.67  )
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
> A Format NVM command can change the capabilities of namespaces, and
> Sanity does change the Logical Block Content, and must be serialized.

s/Sanity/sanitize

> 
> Also remove CSUPP bit for Format - it is not a mandatory command,
> and we don't check for the bit anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bb630d5fcb9647..4737591c1143ae 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -968,10 +968,10 @@ static u32 nvme_known_admin_effects(u8 opcode)
>  {
>  	switch (opcode) {
>  	case nvme_admin_format_nvm:
> -		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
> +		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_NCC |
>  			NVME_CMD_EFFECTS_CSE_MASK;
>  	case nvme_admin_sanitize_nvm:
> -		return NVME_CMD_EFFECTS_CSE_MASK;
> +		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK;
>  	default:
>  		break;
>  	}
> 

With the commit message fixed, looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
