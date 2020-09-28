Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B46BC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:27:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C04F2075A
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="omVpCQqr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T0r32s3A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Mx3K1N0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C04F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=8Gf0saqRxCwVpG17UkrzziUj0SI8C8YIUIVdciopzJQ=; b=omVpCQqrH061V7ITO1zHy5GeG
	7Lpr9ta/I4P+vt+rJF1feaU1X1ygQKoTu9LFajR6WX48fe4MHTLydAil23LeEEgARVERctNPk+Bfd
	gpg9fqYZd+uZOQIloKBj7V4FZmVdG4NWzkZWZ0FBurfPiyeWl/KlKxPhLweETwf5rGtIv/ms5bAYC
	Ax1pD7NWE68K9DffurjMNZgv2dWSdE/1AW300kkXA8AZkma4/hDI0c9kHUb2a++AEGyxC5FQ7qBBE
	BM6Ec6d2/rT6RYFAhKo1Ato7T3AVlSh+D56uHF66/fHBgjbFtxrlROxrROUZ5vrbBQLO1siTB2Dm2
	S1hfrcDmw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMu7z-0003UX-OD; Mon, 28 Sep 2020 14:27:43 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMu7x-0003TL-3E
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601303537; x=1632839537;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=kSHlIVXa7d0DTCS3bVVijBil7F6lFeZG8mX/nJ2zLZY=;
 b=T0r32s3An6cQK6McdhFyjLiFJY9y0W/dfhYUAh7cEtVsEeBL2pRrZF7v
 IrrjJHVSdWKweMjne6xYN7VqoIPV9CqTCmNJk3zD+pRQU89QvFINS+pE5
 +1VhbvV67SVN4kxepuxNo82yZldjVTDbkYOS1GFgTE/nTkUN5LVtp1naj
 hpZOAKlprSRfT4OKyYkTU94Pj7e8p4YTHmbrIQp9droGhYQE5/QK8qMrd
 5Ex77e8GAJ8+Y/JeJODG9FGUrsPXV0g4hYfU0FbKhFjxwBObJPq/UtwuD
 d44wdMcS5d+Ha6YzJGFVf/RPo26fn2T5uX7iJmHHtqaB/yBN9aJaaf5Xa Q==;
IronPort-SDR: wI5aKmKFyJBoXfxc2mYxSjdkFmetStrWAk5oBf72mREolBzcYBy9B+r8I7PMSZiIkch28MftHz
 zpxAS7pplzTgyyy6mKWLXvRX9wRAAu3xgEbibqMeOPDJaUJsLX4W/nDvSBmlhqXADJs1ODGOd8
 b4JI/Ka0fgNGg/Vc8FFs+BfyhtO5xhZmrF6+ZZ/v0wHUBTjr2DQ1e4rAobj4YheJpqLkvzsC9I
 4e9ov6pq63qpfGc3xs1FyPLhL337e13Hyo7SUnY/7dvZVgSk5aoNWZe+l3YdFpggHiJkthILfo
 Lm4=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="251843263"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:32:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6TkHVNJ9e/ZKqbs2F4ryEgFx4mNSwKZ6+QDO1SAdozDYDnO3SSRZDe4qR226RCPiBd0bnU3dHDLRyfpeCmmZ4IsBbB+7M/TbDB/P7FSDM8aODaOMgNVYdumPrvWh62SwqEjnHmPQtMgUHG8kjVJkOj2500mhUUc/X0Hj4bK31cWGTHrqVKmVhjjCJjLzNjqLmprKsPcXqDdYX1IAY5KK7Tk2UOY/WO+yiLhBcJ6uxniOACHkvhxCbOV0IdXMzmIPIi2X8RlNve1IzChbPOYv1qsqX+q0CxX3lwB7bJvoQuttw5nN810eOujC3KEu+JyRdbMokga0sxaxv/kxXEPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMB32BaA/qPVtXxUtdoCGD5z8SJ3Dpdh1biQB6fbrLY=;
 b=dqbFqmrBlTXeuNGM5o5lLEloLbJx16qA7qe70H2R8UR8QCdaTVLWT6kZ3nomHBXdN6/aUau1UykKPVvLIKYFbQ4cahZbEgpA1uPTw4lJFx7f87/PGdKx/lR0BfkZN+bpJYR+YdPbiq2TfBxkTrRXyWgR6KvP67XvZSmrw0I1t17tPxtJiNtQLJAiMsCHuayuFeBKnLOLpe96cdo2gj1kNBVKBAaOPzcoynQ+YiDtJyP3ZIL/nSmVZpxgXhoT0rTTd5GRgJJB/xxuK6zUhtJi17Pn0CmbrniTVgi/d+jbemPskCvZF19f4GcmtEwt1FMdl3g7AYPg8/uEkQsFcFxRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMB32BaA/qPVtXxUtdoCGD5z8SJ3Dpdh1biQB6fbrLY=;
 b=Mx3K1N0NLTNT2RS15156X5wPsnWQojoGN3ozjjJzl3TNeMvjFJuOGXktjT7W4PWjKrN6p30lETteBkrPeu5gPgyElBFpYjNPUcD5BoIUZAiYfScRDhtkBomRCPkaxiKludB1FVn7xu9UIHoCzVktx5G1Uhg2pQu6AO93TemVDCg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1031.namprd04.prod.outlook.com (2603:10b6:910:51::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 14:27:37 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:27:37 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 07/20] nvme: lift the check for an unallocated namespace
 into nvme_identify_ns
Thread-Topic: [PATCH 07/20] nvme: lift the check for an unallocated namespace
 into nvme_identify_ns
Thread-Index: AQHWlZPVwjC3iRuxN0C30nznhsdklA==
Date: Mon, 28 Sep 2020 14:27:37 +0000
Message-ID: <CY4PR04MB375113A310FAD26E94323EB7E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8eca87c-bb57-491f-215f-08d863baa65a
x-ms-traffictypediagnostic: CY4PR04MB1031:
x-microsoft-antispam-prvs: <CY4PR04MB10318FC5014A8829758DAA89E7350@CY4PR04MB1031.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /o5j30C06wIfN88/lpgy6yJMV6QJBg8yhZlim74IQ+PhZnxyFLEH+LYbTVCodvAgRsjlTzjPyss6wzxLVfu37LFzuWZX2LYBjcezqfgmjwrmnk1iXuKUz/DtHwuta8HKIbbMclmrln98xSgQ6/3raG4bV/MJss/bC1HPEkv6TRN6+rywC0xE12Zhpcthy8MnrdokzRO+tcM3s6g8x4cpJX2yJm1ps+AYMDeVJIjBxRuBACEt6x3JYxT69vgrp0T1gSUtAv8LIFtoXJwfBZsUUBwMwM+4WtPcwRZ3YKPIM/8obpt3EZkorXPb967SVBFwcVRKazZBH1QZWMRBvk/IcjFGTqL4ryMcyCCKvh+B8gTDZBgPN8ZrpjyrhQsxI66b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(52536014)(91956017)(478600001)(55016002)(86362001)(33656002)(186003)(53546011)(8936002)(66946007)(6506007)(76116006)(4326008)(2906002)(8676002)(66556008)(66446008)(64756008)(110136005)(54906003)(7696005)(9686003)(66476007)(83380400001)(316002)(71200400001)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: hJfjMfd9Fws9Mf20uW3AhGL95Yo23ARMCVTGdZweT/NwjAPEbPD6hJz1SDIyhlhzRV5/djsc1WUpNckLL03cYx1CuXiUQoB1ZlpL9wUr05XNATn68Q6D2BeJutAfN/+jQDs5raFqYQt4s9rIHMwP4RzOe5KFHDZ9vqCpgjIO74x0kLUiLLR7HhS8LsKeKJzY7UKZMMjaBy+BsZT6N3xuy19AXmYWVFvtD0CTNdHSLfR15zwo8uVbV3UxjXTmLtV82KrXRzX1gJCQVqeoIzxk2iCt0oESzX9kV7Ak9C4g/QmOvTuSnaILCub4OPf1EroEdboyvvelAK9bGgbaN9vvq+T1pZAtNQFTyNEP4bYPS4pnb/T0mOFYvUziGRICSK9yju9WObv0w9rQ51N9ftnuNL442ppNwFf7BmxfLDA+Wnqh2Wx9wRP+VDjl7VdLSIUd9FofAUQw3c/2t5Us9BwFX+XTzaIIgb5ockmUOYs9z41M+E54jEsjUS4n7deP5yQZ0X7DsGRdAFunQoG7J8+4SRVEZFp0Z3X0xLocuuBktNesRxZbUZD4skomVPAzN5epU24r/00G+SQxBbw40cTfJ8eZh1Ir3UwOHLyhUD9AWY69PHqypkfFjLw72FISlWNUA3MjTYPNct9llFqva/op3h3wyrX+xImFmOqo/gjJZf04a+pQqDYAaZSxIxlhgyu8V38JuZaMZ9kpZLq/vCgpAg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eca87c-bb57-491f-215f-08d863baa65a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:27:37.7837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQYtfqJAHvMy4BqrAc70WOB7FhzgGGKK5V2/tAXXVNuaQfqD5KN9Hk1GG9AFfPwKfazpa63Yyo+6Occ0aqq1rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_102741_322325_B7D8AF6D 
X-CRM114-Status: GOOD (  18.79  )
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
> Move the check from the two callers into the common helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fede487f6e043f..7b1423c7e7fc58 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1381,9 +1381,16 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl,
>  	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
>  	if (error) {
>  		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
> -		kfree(*id);
> +		goto out_free_id;
>  	}
>  
> +	error = -ENODEV;

You could move this inside the if.

> +	if ((*id)->ncap == 0) /* namespace not allocated or attached */
> +		goto out_free_id;
> +	return 0;
> +
> +out_free_id:
> +	kfree(*id);
>  	return error;
>  }
>  
> @@ -2169,11 +2176,6 @@ static int nvme_validate_ns(struct nvme_ns *ns)
>  	if (ret)
>  		goto out;
>  
> -	if (id->ncap == 0) {
> -		ret = -ENODEV;
> -		goto free_id;
> -	}
> -
>  	ret = nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
>  	if (ret)
>  		goto free_id;
> @@ -3913,9 +3915,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	if (ret)
>  		goto out_free_queue;
>  
> -	if (id->ncap == 0)	/* no namespace (legacy quirk) */
> -		goto out_free_id;

There is a call to nvme_identify_ns() above this, and I guess it is OK to assume
that that function will never return success if the ns cap is 0, right ?
If so, then this change looks OK.

> -
>  	ret = nvme_init_ns_head(ns, nsid, id);
>  	if (ret)
>  		goto out_free_id;
> 
-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
