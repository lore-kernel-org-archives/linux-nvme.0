Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD1BC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 08:55:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6CE22AAE
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yzrb9m/n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hfIf0XD4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ux83Z1F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6CE22AAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ErpTkjOa7xbf4JMQWD6xqZkbQu/YEky0QRfRhOKzAQ0=; b=yzrb9m/n2uDdMW/rH/pH2xfpS
	qkIqT9z2ctRvHZs6iBTS2q7ysjmGlfeCI/KfF3rLy+zjMwJMUpObcUP1VU4FXr6MoQo776xAHy5HD
	VN0XY9vINWgzOrRu22n0XW297mLILUiIqib5CTS2IXkUZMSSweNw2UWGIIythDGVwFrQM029URzcW
	aQLKJfQ/w2SFgvsKIY026WhJbM/bao+z/eAUcb5XQaCPPofq0FRyWIFF2rvfW3iB4kmghNzyH3vmA
	rzj9qIW6tgEYw9hlT1lBrKGY1CorFB3vbpdhZP2xlXTkWfKH8Tz8iyEj12LvQ3h3gr5IJ10RIWj4s
	9/2lCzTCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jppZg-0002ti-84; Mon, 29 Jun 2020 08:55:36 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jppZc-0002sX-47
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 08:55:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593420932; x=1624956932;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XH2J+eO6xStahSd9VgYG2kfziB60q8TCZT/9ayIzf3A=;
 b=hfIf0XD4kKTHwtDpOXrFx+J8PJRZ5rKSNQYv2Or6ataSfGYHlIzdMvMm
 JhOqTltMtd/+0VzSjyt51OqiCufkTOok7XiglvDjyZD0n9cUlLBhuCwDy
 QeM8YMQlRtDx4xoy4us0INWaf7SkhChSxWAxkQ56ZpTh7OhX73U78ZyHF
 t/wAKfKV3WnVlQPsC6JvXXpFwJkFTNBOWODXv4I8UwUMzCoX/BQSPUJ46
 W9DPyIucSfIk4E3A1GCte1vfamMy85y1ZPan05Jqdq6b5z193zGPndQ8D
 QcK2V1taOpxq8tvYoC248uVYEJwYsEtctpIhEYB7hVKPqkiGq7etbmvSH g==;
IronPort-SDR: Ed5g9hrL+zeHReQyOL/Zwpc/fGDxgjx2S7pAhnAN3igf9FBzv2qCGMoPljceu7X58K81i4dlYC
 6Y130ElQwGUZrT9GyPTgQagvGoM75uUOqs4nOqzLMRvwLJyZtwwREl46IqJbF84Vf0MoiF3mVs
 5FJNZBHealy3dtYQXvykoclmGngMtpJjNXJbUOY1LxVrU4O+iSwUnloJ5vT/Yq1lnQdDGbhLNs
 0SyTwvRzLgDwMLbLMPagXrXf7J1IcCgw8GXilnzO9xnJRuqXcmapy+jhP7IawZqEiauxZ15JuL
 55Q=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; d="scan'208";a="141381360"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 16:55:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVIYjRp/9k83SahvGCR0IBzmepeibvZQ7gK1F1uX/bQbN2huscFRh1lfpRg4yQ8U8LNh2EWB+y79kxrUFeQNTerR4otlAITnjldBjdFFBYT9gZfRc2qrNVDI0USSQNDHq7ZYFCEHciJfx5J09loiU9blQ+5qwgfnFrXVHNhXvkXekWAP/AzDA0FzvTRoQe7O5gW61Fl3KCK5zyLIQbRlVUqX2OBtL7aX+PS8u9cQtANz02t9CO6wLPqYhyTynFGi+hTjbcrKsyY09uYizLgFMWWTggc0lUmiUQp3ZuIKsXpCfv29xm0niEpJrMsW6ilqqCZQgtbZkjYju2lGugVAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbSbFI/8BfP6oyITiLJbS9mX5l8PPGdu0Z77iBauxZY=;
 b=Q/0FhPTJQP6FlcmqgOWNYqDlk/Eef/cSwHzeEC6QvmKZHE+FsS4vECMaaOFvjLwvFOhPG6a7og8YGmBkkwfF+hceAfCn2xniaDNp1gF2bmZc++fmlq09e32fRKiVXupTAYKfTF5eIGCKMVV05jesuMD2/tbyIRdC1byCoffB5+sDLLKQqNv0JyqsOb/hWDg6fZnh+5hp0Mg+TKPGZmMlQ+QJ1SfU+rZYCMOECU5l9PmcSFstYUETFysPrIinW8S9q370iRAmMtu2JqdMUxc1utjuBJxIx/R0BV8F/VAkoo/s3SD6BffNuennYuB/0BHy5fvDs/1kopQqppTkS9vs2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbSbFI/8BfP6oyITiLJbS9mX5l8PPGdu0Z77iBauxZY=;
 b=ux83Z1F6KJX6MwY4T+Y6GLaubX13CX0SMmF6QQ9tKbRzfJSIE8FHONmNOxS3mU8WQ0061siIqllfodQXncTfNUpCUzdMj4slAC6FvJriDQ96/DSMgZhPP0QSw/rZu4EjDCyPk/COSLrdutnOcH5GvYKUd6Vas4N5fJcQ2o6SOdg=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB3831.namprd04.prod.outlook.com (2603:10b6:a02:ac::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Mon, 29 Jun
 2020 08:55:12 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 08:55:12 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: fix identify error status silent ignore
Thread-Topic: [PATCH v3] nvme: fix identify error status silent ignore
Thread-Index: AQHWTfL/iZCIOqnow0SqXrHq0nQZdA==
Date: Mon, 29 Jun 2020 08:55:12 +0000
Message-ID: <20200629085509.GA525275@localhost.localdomain>
References: <20200626174629.115730-1-sagi@grimberg.me>
In-Reply-To: <20200626174629.115730-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da30fe2d-2fef-40dc-2687-08d81c0a223f
x-ms-traffictypediagnostic: BYAPR04MB3831:
x-microsoft-antispam-prvs: <BYAPR04MB383163AFDED055877879F960F26E0@BYAPR04MB3831.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8BDZYFiG1bJPlgFYNannAPjrzMadLO/+708f4sqKZXWa19Dws9jVapvdE1UWt8LpfK/vH5r53ACz7NJjR29Vwiq2Ro1ct25mcLv6NAohD9Y8V3sbc54yQw4Lf7tZG52+Fn9QI/6AXLf0KwQXlZbScmTq9dfiIzVRg7pIS6j4axWFYaoBtcipzwZdu4o1o/wBvcKimNvhWz+uEed3bLzV0YrRTeoeD5QCt0O5JZjBxg7e/Vd58mHTcp7MZlzhFYnT8cWufNzub/iKzqDPuBopozhXrRsFmRp54faCF5VgGmPMjG30epB9Lm4sex1gNjZxQC4gxP5q05w+QOnmpsCpcm7HIxKCUizS6fbMxR8/xwAiDSCfN/BSEiW+mCp/blb4YnbSj9DGQC5sZbw1gYbZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(186003)(6916009)(66556008)(91956017)(76116006)(66446008)(64756008)(66476007)(33656002)(66946007)(26005)(5660300002)(1076003)(2906002)(4326008)(6512007)(6486002)(9686003)(86362001)(71200400001)(83380400001)(478600001)(54906003)(6506007)(8676002)(966005)(8936002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: URZQIKJYB4mBEz/uqHcf9SptcLgg040vOsxUk4RpCIgJTE0C5OIJIZhGspzimtTsIGEpla14wSUAnff5+Fgq6mq46yFWol3ndFlVLc9GgoVGoW3sBCXONHXgIu197QUaH6UAjeQV9tP0G4FSxY+tOGnmreJXrcL0S7maP+XwLOOjeOvTpHggX9xv91dfcaxkO+gz8e4881kq3Bs+TmBeSL0CYWv5gD2kGhT5P1Qv/86c0a3cGIhUjs7cWYbA1tDtAelflZ/gq6PKA71rRU7hAI7xaMATUc46Il7EbCJFBqVkMvbXBcvGttCaz+fDvaQD7GYCGzyxoFda6Qfon8EeWCVlDXDtYqUKestyo1TISz/kWTeLuut4jdBCQPwm6Al9XiOolMbVLb7FXiIckigJYbcRxCxnV4kYnyPtHyGXrc2Q3wDFep3Du8ePGfNJSJ8jukTQ/O5L8xq/3GdSGvT+54fOhbxUzOfXkvMudVy6yph726dD/XjdD8/Q5gDHzIqH
x-ms-exchange-transport-forked: True
Content-ID: <325E02E62EBEFD48BC90988883E421C2@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5112.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da30fe2d-2fef-40dc-2687-08d81c0a223f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 08:55:12.0651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdCS8DlNpy7T88s45LqKXkTvZzepEa4MhGg75+QLnPvYdreyrTqRC8o3lR+5ayRs5ibara+npsOgFLZBgVGqUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3831
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 26, 2020 at 10:46:29AM -0700, Sagi Grimberg wrote:
> Patch 59c7c3caaaf8 intended to only silently ignore
> non retry-able errors (DNR bit set) such that we can still
> identify misbehaving controllers, and in the other hand
> propagate retry-able errors (DNR bit cleared) so we don't
> wrongly abandon a namespace just because it happens to be
> temporarily inaccessible.
> 
> The goal remains the same as the original commit where this
> was introduced but unfortunately had the logic backwards.
> 
> Fixes: 59c7c3caaaf8 ("nvme: fix possible hang when ns
> scanning fails during error recovery")
> Reported-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v2:
> - added comment on non-trivial code
> 
> Changes from v1:
> - remove paranthesis
> 
>  drivers/nvme/host/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2afed32d3892..92dc2327bf3a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1128,9 +1128,15 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>  			"Identify Descriptors failed (%d)\n", status);
>  		 /*
>  		  * Don't treat an error as fatal, as we potentially already
> -		  * have a NGUID or EUI-64.
> +		  * have a NGUID or EUI-64. If we failed with DNR set, we want
> +		  * to silently ignore the error as we can still identify
> +		  * the device, but if the status has DNR set, we want
> +		  * to propogate the error back specifically for the disk

s/propogate/propagate/

Perhaps this minor nit could be fixed up while applying?


Kind regards,
Niklas

> +		  * revalidation flow to make sure we don't abandon the
> +		  * device just because of a temporal retry-able error (such
> +		  * as path of transport errors).
>  		  */
> -		if (status > 0 && !(status & NVME_SC_DNR))
> +		if (status > 0 && status & NVME_SC_DNR)
>  			status = 0;
>  		goto free_data;
>  	}
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
