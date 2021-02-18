Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E6C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 03:17:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75ED6146D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 03:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75ED6146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=T6EF2x8arQ1VwquAmLnYtkfkhAQLPmsMwhjUYHGtYjc=; b=qCJYvsuUroq6gh7GO1PHT/OE1
	0/9noY5vafJnU+VSeYLyLAQcNcknuajVTcXaIldo6+Jg/TotAxnyRf7OSwMag0RpYljvZwtEe9b5E
	BGO+ihk4a075IYsJ8CNq2BEniwqH89SnWLJtC/ir9x7pcN6h6bVKrZ68aYFQbljc9QZX/n8wRwDCf
	drAAHQXn1nNJYLJGVxg14vl4r6QXTwPWj7Q3+XEWUmYlBgRKGWmpHGciXiUw6FgcE/1+338s1NC0N
	B4LWG0wFu0T8paNfeaulN9dxrcFLGYq2bSdtMloqDUxkveA2PFb9Y73ZzwjngEegnJ4WwTf6W+YZG
	zdEZClrPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCZot-0004np-Dq; Thu, 18 Feb 2021 03:17:35 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCZor-0004nJ-55
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 03:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613618253; x=1645154253;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=I2/hKX4rnbCyniyhE8A0R6Db9ROBCX9Jtbvg+DbuZd4=;
 b=lmW3mF5oepzVEG00klIjNb53sZ8VTUY3x7l+a40CrkMd/NceClcDclk7
 jVk89Ae5c4Zd224CDkFNObQpQkgf8pF9uytlscFHhD9MDch4Zx/UOb0gr
 vp/2vvuyrRVH+NXlnacsBCJyPEAYktLRcQHF1gKrPwPGF5QTh+SvGnlaR
 Q23103OMBbTSpnqQitXkGbDQlK+3O93ccSs97kpL3edDQKn+UYOjMrX9H
 w97LX+8aFiYSp4aGWkSHnCsjdvH+gSH4cjqC4+yEvL1qOLISD2zu3AK3I
 vl+snP/aHERrBpZzqi1SXS7Yajoh5h3cKZfV2PNj4qyNOQKLCz/RUI+Yk Q==;
IronPort-SDR: +jeRW5p8ZJ2QeeoXVFsQx3Gud/g9WvkrWWspN77UuDb5uUh6J7wDSDoxhUa5vsQIId5NIziRxi
 ROu4jj+nu7k1kazfcoUjT34TUKQ5WiN+pw/KPT5LbHe28cnTgj2NEzqpJ6UbGRYdwjuFi0Xv39
 NkJzlTswJ8w9RfJLRaY7f8pea6t11NeQgzDAWKc8potcgKgyOODjP4/pLu8XtK+jzg8baLaNcj
 7tWcZvpSE0wEJHvdzeuKqDYILHgpPNIzDFcDYLbb6D0fUwAtBNuyFcb39Nw/rrb3BcVUg78w7H
 zyo=
X-IronPort-AV: E=Sophos;i="5.81,186,1610380800"; d="scan'208";a="160216115"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 11:17:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC04dMTUuEdvfHx8sNZBSXEuHFZaAp3NUGNUYDGc8rTQ23+PL3VsWaDEHmnCbd0f3hTbnR9Jhh2O1FG4cIpVJqvci8ouMMBiioEWzXMnUVDXW/toao6dQTHgEMTDfJW59ot7FjfNVVnHzW8r9zFSFX0RHcFKwlhRo1LAqG7d9kBC7eY82t+AcUJfokMMsM6b74Nhw2JQ0+Radlk0UjbY7VauCruV018GkPhI6+fOpqpyDA0irYgV41WbydqSBcZKewdyGB5YB208HiXH49WiskBSc2wCRcihGX+9OHQlssGOaflrIWdYezQgaqA/wV4CZ/iD+QEjgSdpTeTqlt6spA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2/hKX4rnbCyniyhE8A0R6Db9ROBCX9Jtbvg+DbuZd4=;
 b=MBs22t0W71FLuZOtqI9Arcfk7hCG3EP686pIX8IKjszZXuBX4JrcmrWGeZDjWVUoIm090rCX4Ra/GwTGhxOxFHEWwemzmDoH4E91VJzp865+c0SiE7BG6aJOKLG26PIY3AINIrN5JuEvkSOcydDTQCaTz6X6EE53gJ5rxHdkcXQ09eLTY4BfRqfPnn2E1lIrlB7jso/N/n7buJS/5D5U6mkmarifgyXfEctK02o24mD2g5NaqWspacnY9WFSy6keJxgBAcbbmmCaaln0UDm79TrawzDCsYMaXAd4/3f43tRfshil306BsOt5GI8wkGc2mdHkOiP05AnYnAktRdKEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2/hKX4rnbCyniyhE8A0R6Db9ROBCX9Jtbvg+DbuZd4=;
 b=ctbptaGBmx0yqszWCMXieACb9QClJYotwJiUD46l9nqhpsADjlyutHRmEQFUqkwGFOrF5o+m0MowafmeysQ9+cEos2mkhdJ+XR7xTcNgkTrV+C2N746w7dhWOFyfkY7v30grkqD8Mx4F3nocq4eTZz6WE1mWXLqLBhnCuUdjEOI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 03:17:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 03:17:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/1] nvmet: allow setting model_number once
Thread-Topic: [PATCH 1/1] nvmet: allow setting model_number once
Thread-Index: AQHXBVhlhsMvy654VkqiJhi6SmHjVA==
Date: Thu, 18 Feb 2021 03:17:29 +0000
Message-ID: <BYAPR04MB4965D3231E5681CD2642EDF686859@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210217181153.15343-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65dcaca8-fbb9-412f-8ced-08d8d3bbb97f
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB65492D5FD04A7205412B1A7686859@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fb25erO4i9P0q64YU+LZNaEfexe6+SbaVbFPPpaXJxukJ+5yQoRAc1ytkmkDap4Xcv+obHR9k/jJ3g6jEeIDhstxf8TGb1OScbH8aQ9YSCPHRF/R/PQKS95SoH00se+SGEPW4Aft/KesAT242A0H5UGnMRvprHOaXmf4jjDzaYrxLU+w341klVFSxWNxKXxt/tGL8hp+t/bXNqI8IIbKnxj2jK3u4Bp3+nf07yA/LzzXPXgchKT9RHb5sBGtX5/vScNeMVgWzBdZovSRMNeY8hBLCk3RjnJJahi1g5zVJWWO/p42YI7vBHOHNaTAp7bVJxNUM42UAYlIPNeFXNH5uWzD8QbmErJWE56p7PSgwL9s/TyV5gFkV+oxyN+CbckA/YoMw1JTJucfCow8eHSweF59d3uF2sZIQfthn2npmgLVaWF7H7PZJc/AEHdB9vdpvoQz6mWHw94VGC3Fh80OQWae3dlmDMPi377lXnSXvjUiPuhKnhRtjjuLNCNtPVPd1vw0L/TXxqmb1QJg6L5erw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(2906002)(26005)(7696005)(55016002)(110136005)(86362001)(186003)(9686003)(71200400001)(66946007)(316002)(5660300002)(33656002)(64756008)(478600001)(66476007)(76116006)(66556008)(52536014)(66446008)(8676002)(4326008)(91956017)(53546011)(6506007)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?sXaQ81hE1VLOND1puxKzrT2+wx/TLrisgHhA0RxtrSwidZIp/Y7HM+Jj?=
 =?Windows-1252?Q?UltfS3+OajXnmGzALuaQj3TFD934AWG4bLdiQKabGNHHeSlL/4WLYTnM?=
 =?Windows-1252?Q?AvFUzX45WPkOOpYWzXnQqTyZ5mzXZlOZXIWLuIw/TeGugcRggOi10Kkg?=
 =?Windows-1252?Q?23ncMNkCeUaSs5jxKa1jD+TXqgxasNIaB51aSwTI4ts82ailaCOORpXL?=
 =?Windows-1252?Q?ELR/cwbrSwfAmWpgWjMdIMdOgJFxy4LibA+VWuQYv6yI1EA5LK6aZd/v?=
 =?Windows-1252?Q?rQEoO60MKygus+0So2PRz4lTWQQ1vC/dxvjCNhRfn2tAUZ5pH9CQbU6G?=
 =?Windows-1252?Q?O05rPIo9YrP+d3OhV4c5Vt54aEyXVGkVSDUXsD0oIW/9Rstg+d+yrDhL?=
 =?Windows-1252?Q?KPLzP2PGwCnLD8six73PcryLjNkIu1Gem9W5Ys4ML0JRkEzR4Snpn7nt?=
 =?Windows-1252?Q?y87LGnSrXjlgtqGF4fsQM7mdWowhOWZvAAgcUNgCI7s0VSVgGlEdEvit?=
 =?Windows-1252?Q?dd+7B6TTOlVaw2Bh5rWZYCKjZKqcVjgX2b8jK7ZlgE72ebjmnaSoSfOx?=
 =?Windows-1252?Q?1QmRqew6hYJ6083on8C+ZrcunjZ8uhJSdXnqIS7ScQKwjowTkiNmyaE/?=
 =?Windows-1252?Q?xxEYpFaTGUN0opzhB+GL4nTuc4sXE5O8qGwpCHZdRnpPz0ooQzbPJdn5?=
 =?Windows-1252?Q?HhajIxabzN/cWLv8e4AHtvgd7DxeFJk+0g/pMvpDNJxRdSutJMz6EHJf?=
 =?Windows-1252?Q?L4f6dOlaqISKn0Vw2eEQcAi+FvWhCaAW5p/cZ9j3QKLa9jRr6gC6FWaP?=
 =?Windows-1252?Q?SxDEGEBqusqrgg1mWNc1st0FXWc4mAL56WY4eSaoX1z1qcU8ykfREtbs?=
 =?Windows-1252?Q?V9Xnab7LMnr9U8NdZPVsjVG0c3gLjpDP0WHeX1c/0sLT06AizovBeI3q?=
 =?Windows-1252?Q?ofz0WGpVpfAaxH1bQD75DGkFvN2McK8PwmoF3ca/oj8wIyFCbOWKfEdQ?=
 =?Windows-1252?Q?zJwCrIWGmR4zFX4DWKPddgTnF/xKMlJy/Ica+ee0ibJwa+KApxs5ZCm6?=
 =?Windows-1252?Q?W7ShOFdZ2ZUl5w8K200HAvGdqxZ2vpUs4mHac5G1H5+dFzf/5aZS446v?=
 =?Windows-1252?Q?WTTfx+yZ3RSOILlto/+k/gjQMZr4WzuP80Re7nni0FRV+UmXtN2Nta8v?=
 =?Windows-1252?Q?2dw+bgmGR5Oei6+EO4zI2xkVf5D3Ygj80pbmi0IEXxk6D+JR9ncKwPoV?=
 =?Windows-1252?Q?k87oM50u13/KQdiOT7RaRmM2iE15AtTzJ89+h7KqwBcjSkMOxwM9K3jO?=
 =?Windows-1252?Q?LHAu1NNB/rVuooHYJ7KPd0FFyDiBSf7QTEBgHd2DoBvK3bAY++33ZC/t?=
 =?Windows-1252?Q?924+giPOTrzfalGxoWHNO//dXVKdP8IWoW3eCaZIMN5b7q78fVff+gXt?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dcaca8-fbb9-412f-8ced-08d8d3bbb97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 03:17:29.6564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PvrGNYDM8mSDTpqWAFL+4Hrss6fjWwny16Ve7ZzKwfq/2OWnudGD7bcihDBAZP5lx7curIchvw5/8gzgnW5ZAgX7jQ6ObTiCW+YEwwpwCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_221733_472728_0347E0FE 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: "oren@nvidia.com" <oren@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Max,

On 2/17/21 10:12, Max Gurtovoy wrote:
> In case we have already established connection to nvmf target, it
> shouldn't be allowed to change the model_number. E.g. if someone will
> identify ctrl and get model_number of "my_model" later on will change
> the model_numbel via configfs to "my_new_model" this will break the NVM
> specification for "Get Log Page =96 Persistent Event Log" that refers to
> Model Number as: "This field contains the same value as reported in the
> Model Number field of the Identify Controller data structure, bytes
> 63:24."
We don't support persistent event log page since there is no use
case for target to have human readable format with timestamps,
instead we do maintain the error log page which has information
about the errors if user wants.

I'll let Christoph/Sagi decide if we really need to implement
Persistent Event (PE) log and so does this behavior.

Regarding preventing from changing the model_number when subsys is
connected to the host, that needs a fix and I sent a patch for that.

We can ignore that patch if we decide to go with this patch with
PR log page.

> Although it doesn't mentioned explicitly that this field can't be
> changed, we can assume it.
>
> So allow setting this field only once: using configfs or in the first
> identify ctrl operation.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
