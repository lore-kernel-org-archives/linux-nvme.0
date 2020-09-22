Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89BC4727F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:04:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC3C206FB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mBD/03Cd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LMoYI2bj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n97GhKKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC3C206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=0dooassyiPEfDhy+9ELGlqZ3u+o6uY2Ka2ox8Gpo4xo=; b=mBD/03CdcQzL69K5gn/o5TcEN
	SFWzvIeNcfdSV+0YsrpCtz4FHOv7H5uum9tkHWxhS5CWq2RURShqOx0PCo+ZVpV1Qr8cb7OgiXnX+
	6L7VE2bayIRB802PhWw47FJdN4o+Bn9k4gsuMivVmmXQ3W1JB6oYoya6Vi4hhhb1nKfqi5aLySN0F
	ksj9SEca0EuZrrSN1s/8tMmXdmcfPOBV8INemvTBFvVg80dldgTTGuxAk56mV6bN6VtQzMuy99SAv
	W9Or/dea8/PajVcHlddS4knQrgD6naYGORR15sT5IuWjhzs8H+RP42ZUiglWKQO8ZhAAb/OuukBKi
	OK/eWNn2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKpSv-0000vW-Pb; Tue, 22 Sep 2020 21:04:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKpSr-0000uM-Ru
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 21:04:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600808681; x=1632344681;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=mZn6NeYrOvXI8gHwaQzJNkoaRJIJTEK3T5lA24ZxsmY=;
 b=LMoYI2bj2ITxXM8j9cVCChLgEMczpJRPQVG5o+BO6p+RSPVCuXzSC9+V
 kqIC3EJpPPEs1UdxgQqJEcRhoE9qM1ckNUQCUG7hFqbkjVEPRicoHIcSH
 id58l32DIKs3KwryfM01KD6oQYmDqq6wfKp/cG7RA/l71Iv3bL9BeX+m+
 9yo+EDBqqJJXuMxmC3bbJSLE7BuAc3K3UjI+oPZmEgalbZrQ6LwDRhzLq
 vQjy2Jk+U2oKwvwiPSkqA5LxXsCcHll/hPFa0fbdM1Db8ry8KzUxq38Ba
 DvMtB5YhO2ZGvkq/0SlXy+8ykP1R5r+3UL69zLAoBVsK6tIshsY671jId A==;
IronPort-SDR: f0GDcD0ZkFazS03EYNgjUbZJ6TEzChtf/L03p/oQ6ERemc/aMwk5fH4eWWu+adEJ+cTjkhbDNy
 ipgtPUnvp6Z1E+JSEU9pWLkS4UoNvqzsc5O/KYvgfFTZH1dEyHfrWhAkyq6X+/zmMmfVipBsei
 RAkKE1y7jxmva2aM7wycovOScXswhyBr+UiAm9Oe+/jIIjxdDPo7wIpfZiwMFrWvJ4pX6+uJDx
 2CwC7groCYqCSFUq/U3oSYLqgwugPF/xW/H3I/vkmr7Z2BkvmJoY/PdUQi1Lu2THXhTSmyCp5K
 sIc=
X-IronPort-AV: E=Sophos;i="5.77,292,1596470400"; d="scan'208";a="257730018"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
 by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2020 05:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLE9JlVOkrO6KIMUsrGQ35VghDP7oA0Yif/wf16vqYk4d2qGnwYiWuVQ79skoClaEyhAnr4Gnhdzfq1OGawxIJ10zMhEF7jz//9rxrP3E0IxGPZlqr/D+2LP0oiMI4XQLjOwhGFmA8YQCTLZhpXEFhgCJKqNop0lvUX3c1ZNRlOy0VztnjJgA+xt1XNed+iv4EXPXYCvQVTwsJCummNW4AJq8As9VzWgpLQTMGjDlebuWbekMiw9GZPX44HpGXawfq6deW8LL+LoVs4Y+wpGRY5DRxfcDRQBulCJfGYkkJaF5BvKmOQnbNo+i8cuLyngzFgtpKr1x0cipPFsInqn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MmeWpiP+s5oi9j7Rml4A7Cz8EeAb9Pqv8k/PbK034A=;
 b=klGAb/07kLVzOtusUdlupgZ2w+AddycBKG6x4ybGuvvRzjxSFx4Nn87g5TIpKm3GApj1VAL7N0SguGLKmwoaIohjQNM3fcjiF+Y070zyhiJ2aruLkRcc+0NL3v20QZoKS+1WYnLl327x9dY3uH/HnTgdvyKohYkYig5DSRJx9GCZmxIWBZOSdZj4Waac8PMWSnlDKB6CdhC0AWknaaGMusARj782x3QAExCi7bpIe+fGd3l3ak21qk5BIJu32bg/oZuk+aKy0x+6MJGij1WJFOzYmlrCRdZw94KXlHWXaVZmtzMQWvi7awfBt8U+xRAXKyrX0lFFkmPsFQdoWTsHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MmeWpiP+s5oi9j7Rml4A7Cz8EeAb9Pqv8k/PbK034A=;
 b=n97GhKKbWu0YpArTaJQy5ok64KGi5rdqu2AO6ROsFXmrFJ/qtgxhrFqdlwsrP5KomzjWTF7sxcBLYxOoN6HRT6THOrvwTYsOoGSunPnjH7QOEre/Olqs79wo4KuVdXPjGW2BnlpPoix62onSoOVmpkBcuCYeM3d9o8+VX5yzaUI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3959.namprd04.prod.outlook.com (2603:10b6:a02:b2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 22 Sep
 2020 21:04:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3391.022; Tue, 22 Sep 2020
 21:04:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-core: don't use NVME_NSID_ALL for cmd-effect
Thread-Topic: [PATCH] nvme-core: don't use NVME_NSID_ALL for cmd-effect
Thread-Index: AQHWkRmG0bb+QglvuUqzG1Yc0DjdTg==
Date: Tue, 22 Sep 2020 21:04:36 +0000
Message-ID: <BYAPR04MB49653CBA4B13CC2595F9205D863B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200922194938.51845-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57577439-ca07-4560-0f3c-08d85f3b1cd5
x-ms-traffictypediagnostic: BYAPR04MB3959:
x-microsoft-antispam-prvs: <BYAPR04MB39594EDA7BBFA3F103CDE501863B0@BYAPR04MB3959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mh8IuWLwVtFKFpJEAk58zbYoPU1Y9jMhg188yqlBzrzVACEnAV8dCNIo9VgSkFTmkfYSNNjM8i1GN4yIR5c1haYJpIQaapHHl/WrmBiTztnYdSVCbaXjAG4ysRkeGIio2yGizxps4F6wPgjQ0R8FbIKWvMkx7He9GlxkiUZWjAL76BQ9S8Ww3TCgwXSr8zX2q6qDzZp12kal1HpUNtOLVpHtv6dtOa0P2dBgLbkAEpleZ/HmwQUvWQO5/TObqT+iILq9n4/qd6OPR8G3tNXbP/hFAptZYFpjJ90RUVWoVgBjx4nEaC1+T7Pp12hn9vrXjoNu9Te4dOAZZqTRYlk1MX0UqFRqVUp/6lUmQ9zFbhlLwxwVLWhwc8TKKZmyh9jUUB/KbKMCLc5OA2XfT+XG5mb6NidVzIVtFYmA0ktplnQFzAFLDy8d0BWCvfGLWGoJ5zQQMKyUITgsoyH4RxvRIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39850400004)(86362001)(83380400001)(5660300002)(33656002)(2906002)(76116006)(8936002)(966005)(66946007)(9686003)(66556008)(66476007)(55016002)(66446008)(64756008)(52536014)(53546011)(4326008)(6506007)(8676002)(7696005)(71200400001)(26005)(316002)(110136005)(478600001)(54906003)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WIUQGbPSYXapH9THvU5hLPNTA+lW3k/h/8DAIzDXMwS6lwyo5NxZuAtMOZTgxOnPFOQAVlf4qBda4k/5SjSnNIXe8NOWh39FNDFoL1z+ewCyirgEHdtFgR+NwTmNZMDDM1xA2t7Dj3zNMiLarMbucj5BV5v0s91y46jXs39MHk6BTb0HHa5+dKKMc4/9h1G4OhbnkL3dvXanz6Mu09LJctj4k0dX45BjwNDgPHxYh8BTbP3pJHNjuuxcGCWqbjsiAcEQmgS9PmpB14vg0H8OenkYKA3LXLl8FZ3ntcUAM9NJuUgyvMmQOwO2n0WHgo4So4peZybe/9JBF9X8MQYO7pCSW6YTdU/+bO2drAg2QeYTvTeZZ7+CsDDEVkzZDOaeZnP/zS9J2RjQhk1dHf48t84kUNWsOBpftdNSOVITTbJVQk+8XjwghCWMiKrS+ItpdVMKl9CcCVMnJbq4r6AJZEcKNJLQQt0OF+EOHGjR4b8NM9Ufw1Wbz6mzlaqVHV9nY2e3oEaffLAwQ0fLB3chIFz/R+5hsOL1sdwX1gzjQd2qMxVH22QVjT1JVM28IIeWTzEKCcaVI5ihJDLY/UZSYGO0gEjoB3oHPARzVhiru77BQlP8+/YzD4mq5lrAEj9oW/Q4w2xIqUG9gopHU35J1Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57577439-ca07-4560-0f3c-08d85f3b1cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 21:04:36.3100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvFGUWkoFsG3gKX1BD6EFqulHgSVbGtjD4hl0UUfnsx237SdWWZOkBaqhMlZI98veGb4uO5usWjNgtq121eQewLA2Ir9Igh5ghOPxYaNQok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_170442_357273_7211D516 
X-CRM114-Status: GOOD (  17.22  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Huai-Cheng Kuo <hh81478072@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

(+ cc: linux-nvme)

On 9/22/20 12:49, Chaitanya Kulkarni wrote:
> In the function nvme_get_effects_log() it uses NVME_NSID_ALL which has 
> namespace scope. The command effect log page is controller specific.
>
> Replace NVME_NSID_ALL with 0x00 which specifies the controller scope
> instead of namespace scope.
>
> Reported-by: Huai-Cheng Kuo <hh81478072@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209287
> Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9beb9c94eeef..0d4713307724 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3041,7 +3041,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
>  	if (!cel)
>  		return -ENOMEM;
>  
> -	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CMD_EFFECTS, 0, csi,
> +	ret = nvme_get_log(ctrl, 0x00, NVME_LOG_CMD_EFFECTS, 0, csi,
>  			&cel->log, sizeof(cel->log), 0);
>  	if (ret) {
>  		kfree(cel);



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
