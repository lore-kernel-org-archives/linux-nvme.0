Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FA2C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 22:56:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D3920656
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 22:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IEJa+F9O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aGz7s0dS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lvb/wg1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D3920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=EwKnU6MNXX+VLUtJgD6Bfa4tYHWRUBLAb6yjknWwjjA=; b=IEJa+F9OwlMJuz
	gFrTCyIpr1tZLYIUFfvKKbtPr6IupOOdK+Hce7L14cvjCseHTdQ3Ly56Ry45IUD5/csUvBPsdCRjH
	DfT/W1KEpuTtygKbs26UnOf2FAIxITSuuI44nzP3TPOFRloi81h/THbqWTYL/HOpjEIsZQIQp4mZt
	MUZePldqiHxxel8OfuxyvOh8lSSOBUxiVe0m88RCVebj1lXJVKtKOlWZay6+tBDvdXQ4UF/9LRaGa
	B2Z1z+RwgK6nFL9xFuk90Sa7BIja0YL+0gbm3B3iOKt6SnMhdRUWDu3Amu37CtZzBwQxTh6Wm9hNX
	ubE5n+1lsqZwJd3KZYDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjW7v-0005QN-OF; Thu, 11 Jun 2020 22:56:51 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjW7r-0005Pw-Kd
 for linux-nvme@lists.infradead.org; Thu, 11 Jun 2020 22:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591916208; x=1623452208;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5EOYsciQAwzIaqmJ1n2b6PlqnxPig37qLDW5/8YHWg8=;
 b=aGz7s0dSkLKRfsZGRPFWO9xiTJRqqMKB7mN34/bH7JWqKOkUQmi+KN6S
 thDqoZBgEAazU4i8zxUXvJi9EoSk4CFLcKLjDp4vQ9IhFWAtzGSeClrKb
 7gfecTsBdK7rfp7RpgGlwW7xc1rf/1mEiVzU33dG+ekRJykeiZMGoGp74
 ZzJIcPBD6GQheBCBj25NIZ9oqSEt7iGpKyt3eCS0fr006AiT7sh7TgRXi
 fW38zJ7SwLh+iphkStw+WeNLolHWoIaD+N+pEh+uDRtQY09n3Uz3XhEWT
 3pqCfet2ASgxB4UgfuItpY1Nwj9XxM0NZw6M48gIKFdduuzeU/bnlrUop Q==;
IronPort-SDR: ccP+5hwTWFsCo9sCoDjZBP+SjICszFTMuWevMBd8uPr6bdS0PFdyKfEjBLMP7Ci3zmee1mIaJ5
 k6viuFGp8LB2FZqtB8gh9pzHh34fLBvFVDLSaWypEWtowMv7+UZbhv2/sjkYMzfYN3XSwXIIhk
 iv62uk7gOjLG8FzBio24+NMECAdsfHCSWV1GgcWJJdymTCXdfsVQMIfXIOmMWULg33E0cghaPP
 DLmGl9uzZKp4e/tp1d3WRo3u5CGOLjEBTHIVEMfD4dj9GTYNH/o5Ak6X5ZRySkycxwTXRp+e92
 QAw=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; d="scan'208";a="144099693"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 06:56:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODv7ZfYTqheRQdLCc9pGjIcY27PoLgcrojr4vqvmax9Ju7bqMtRYJXek2lq899kwRNLzn7pdO8WsoCjBTTTN1DtjlPXhzrtJAroYL5Du2MV2iBbuPFqTH+yFUtfZaYM3L1niWEO4hqnO1OyrHU6i0ky1VU76N4lnOfLnCFJtLWDv/D+mK0KDwKx6DuHfD2ydOW7G0XMTfHT24PnrnLmUzaOVZ9pzao7rpTqh7XF+GkhuVw3kv9B5KfIIQQGNtzv3FmL7V2MDMJHXUDiMqjZkHPHjoAa+//cUiGSdQoxHtxYOO5k7Gh7ZPCmqbLsA/6WTkOKqnoidUYpdnuKWia1QMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx8bAATdo1EjNtaPCc0wc478l7PrOpaJyZbRnpHrGM0=;
 b=AlEtzqafvnANY9Wz/ghFrKjPI70/bN4+peM8gN8aP7Kq4tzp1ZYHFLVvsXAgWE3s4Uayrd+1OllFGTpXn8CpVOP8BbtMCnbpOTPX/NmeAkFcXpGSZ0CgRgeGcfZUVe6gaMpln5cHr0JO+wTbrz+vPVGqyLJqNLsnl5t+7YgDBhe6ugp0G2nGvH+twvPR1BZv32DifF5r53T4bDZ32eFkjOFZf6FYn4DdjQlTiOdA9Ez4qpHPkP+7rVM5WKIVO/2x3Cd55eygeFWxKZjihbidANjn77CSnIKZDvjYiFD3eU1XEtoGClIVepus7Hr74dqcbLHCtg5lRp5vg72LpPHYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx8bAATdo1EjNtaPCc0wc478l7PrOpaJyZbRnpHrGM0=;
 b=lvb/wg1qxPrD0RxKRDZk0voGLkIFXfq7ebvfamsKAktYQY1cv3dt2r5VzgsJ6nRA9shCyxoOYQMg4gfQggM7U3uPAp1XmYK0ZvNfZUTRAFRRzA/CsdDRtgP9la/N7h7YqP/t2445+mcc7b32N7108onlTRtkEDEvWj5QdswqXuc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 22:56:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 22:56:42 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v13 2/9] nvme: Create helper function to obtain command
 effects
Thread-Topic: [PATCH v13 2/9] nvme: Create helper function to obtain command
 effects
Thread-Index: AQHWKhRkkBYMhr4OK0y6kDVy5Q4NnQ==
Date: Thu, 11 Jun 2020 22:56:42 +0000
Message-ID: <BYAPR04MB49658F968DC104E99B5C923286800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-3-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9f43330-309f-4889-c8c2-08d80e5ab55e
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB6884F34F72BECFAFE8D8154386800@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSTDmaKhRlt0W9vjPaR33wp78JTljIAtDk15LQ2Z1o7+lWUzwVVRKCtxSs/6AZa+M1rTiyTUguzglp3xJMVSN6D2h0k7vTuLCDyVEMPeZApX0ro9NQG8Zl9KYLP/NkYzYxlUENQ1Os60abHLG7twUnrmK9cwnYNOsbcTLgm4HSJOt3fV79sHoyRn1HfI6d3sYbh6ETyz8+TKLVNbh/tLMRZzIbwPB/muQUwR5ve0JjhjxKjIu+3mVpy7Ym41R+3cJzx1VaLKgF73fQe43Y8Bi7sfhPpgKRJU6xwRu3XtD5ZQkZQsw1VAMcb8QCQWcX30DBk3g4k4AdBVP4N95N4GJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(54906003)(478600001)(316002)(110136005)(186003)(26005)(6506007)(53546011)(7696005)(4326008)(83380400001)(33656002)(71200400001)(5660300002)(52536014)(76116006)(66556008)(55016002)(66946007)(8676002)(8936002)(66476007)(86362001)(9686003)(2906002)(66446008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uG22U/WforE1YCuFUModoJKQKu3v05pYSXegP5cDYJFZDCu8w5igl2IU9Zh5MsDDS/UVwBz06Y+U6GXQ1HnOzMQiSFWyL8sc0+spApDpRgyZ3UDm32V55zaHtxZitGZkYWHZfv/aPIGoJecHZ6XhJ6MxKOXDtQUs8NCu3bKiEbD47klJpI3QuV+Y9Dp9NYoO0S8cAtOU+SU2wTTL9xUYm7Mq+5YCJ1EAVFu+8oDzd9S+CFj3CMEjrII8xyqmJFG9VLF9VzGe9wRWx+exg0gNkf+Bnh6E+NyOfrmoTsBBZhrPNFiaCspepWoh0yZpQSLk9CumDah0PNienvP3bG1mrEhKVeJped5eJ7UMvdm6/ZDedO6RbqrPEYBdrXt0AN2eorY8OkF4/870zAz4w7/BH0GHqhJk0/TCWyWEMs4RPEkfM+0PEyy7PBqvjuw2S5CYkmr0GRaocj3+sc/u4MkcmkK9Ubm85VwnurepRTJgF+M=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f43330-309f-4889-c8c2-08d80e5ab55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 22:56:42.4639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQGZKOfuTgV4V9TZuaJBKUjtjSoKkVQI4PYZLthydxLQvOoHz4IeEjrlwBN0XCNZrUmZz4OHK0KUX3j/448w8KQTMAaXJdRh57Wzzedgdkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200611_155647_770107_B9396897 
X-CRM114-Status: GOOD (  18.54  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
> Separate the code to obtain command effects from the code
> to start a passthru request and open code nvme_known_admin_effects()
> in the new helper.
> 
> The new helper function will be necessary for nvmet passthru
> code to determine if we need to change out of interrupt context
> to handle the effects.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 39 ++++++++++++++++++++++-----------------
>   1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d22859543e4b..5062a83c3634 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1317,22 +1317,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>   			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
>   }
>   
> -static u32 nvme_known_admin_effects(u8 opcode)
> -{
> -	switch (opcode) {
> -	case nvme_admin_format_nvm:
> -		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
> -					NVME_CMD_EFFECTS_CSE_MASK;
> -	case nvme_admin_sanitize_nvm:
> -		return NVME_CMD_EFFECTS_CSE_MASK;
> -	default:
> -		break;
> -	}
> -	return 0;
> -}
> -
> -static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> -								u8 opcode)
> +static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +				u8 opcode)
>   {
>   	u32 effects = 0;
>   
> @@ -1348,7 +1334,26 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   
>   	if (ctrl->effects)
>   		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> -	effects |= nvme_known_admin_effects(opcode);
> +
> +	switch (opcode) {
> +	case nvme_admin_format_nvm:
> +		effects |= NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
> +			NVME_CMD_EFFECTS_CSE_MASK;
> +		break;
> +	case nvme_admin_sanitize_nvm:
> +		effects |= NVME_CMD_EFFECTS_CSE_MASK;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return effects;
> +}
> +
> +static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +			       u8 opcode)
> +{
> +	u32 effects = nvme_command_effects(ctrl, ns, opcode);
>   
>   	/*
>   	 * For simplicity, IO to all namespaces is quiesced even if the command
> 

Seems like you have changed the existing function body from
returning from switch to returning at the end of the function along with
the name that is why diff is large, which also adds an extra variable 
named "effect".

How about following ? which keeps the diff small and removes the extra 
variable and keeps the existing code as it.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 78fc38b8356f..f47013fdc5ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1326,7 +1326,8 @@ static int nvme_submit_io(struct nvme_ns *ns, 
struct nvme_user_io __user *uio)
                         metadata, meta_len, lower_32_bits(io.slba), 
NULL, 0);
  }

-static u32 nvme_known_admin_effects(u8 opcode)
+static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+                               u8 opcode)
  {
         switch (opcode) {
         case nvme_admin_format_nvm:
@@ -1343,7 +1344,7 @@ static u32 nvme_known_admin_effects(u8 opcode)
  static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
                                                                 u8 opcode)
  {
-       u32 effects = 0;
+       u32 effects = nvme_command_effects(ctrl, ns, opcode);

         if (ns) {
                 if (ctrl->effects)
@@ -1357,7 +1358,6 @@ static u32 nvme_passthru_start(struct nvme_ctrl 
*ctrl, struct nvme_ns *ns,

         if (ctrl->effects)
                 effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-       effects |= nvme_known_admin_effects(opcode);

         /*
          * For simplicity, IO to all namespaces is quiesced even if the 
command
-- 
2.22.1

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
