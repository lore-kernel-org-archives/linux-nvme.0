Return-Path: <SRS0=2QKc=EB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3580BC4363A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2020 21:03:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07102076D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2020 21:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NnfSB8e4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CxN8DMt8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yrvZHIbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07102076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nquEA1vcpdYoxwEO3M5z5BQhUr8qISpBWKMyORG36Pk=; b=NnfSB8e48if6RTUQWSvzP7agU
	idB9sFqP7JXYRlzf0wP/E7IkdQ9hypX2VR+QJsFgOyW/FOf1KiggxgYz/9mDsqR2XDhsfeJjm09tI
	+oN5DH8B0sfI0PBjEYADkaXCpitoCun6M0aV/2/L3FNFWXDt1dr2TaR2V++W0lkrRDARguzbPrRwj
	u5e3V5gxDdSTVcY9ErCfiJJVIfZvg9HxPDT/TxHRPyzxRG3jHSiQPCNeNhNaYgeArc51r9X5lILRA
	bT3OGBaZkdg6EHhWpnopGJ7TdVhDe/VxqvhLIOXjAPvIQGUmqLkvhuEI0rMEYkDfE9tVVba1RaL0P
	icuHPNZbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kX9du-0007Il-R8; Mon, 26 Oct 2020 21:03:02 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kX9dp-0007GI-0Z
 for linux-nvme@lists.infradead.org; Mon, 26 Oct 2020 21:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603746176; x=1635282176;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=RKVFbnfrze8etHDl77UGvw5HtzUxGUtTb7Pd8GZdul4=;
 b=CxN8DMt8uIhttHzggrqOpDZleLaAaUfhZ8Ooq7M3B91YODIzPF3V1LbO
 aD+RubhICJjE04giqrIRco8tV4Z22AxLufN+LjoeM3eH8SqLmg0FpXCxK
 6tMPH9k0FmI5OuLqueQ8k8FOtMWEhsY48Wd383WMentoo6pn1xJeabjEN
 QjdsFHDyQsAyhNFNeoOEDBTzwwkv/YymmN/exQJkd44jcZ2O36fbZWzRb
 7WPsrbHhp8l4luFW6vYjhc49IrGjJbFxRVVI1ZqXEn1UafAPwtcpkqWHf
 ZHvynAsKzWDy10Zq8e11n09oZxothywa6PkroxcEHh7q0SYX45L+I4DR0 A==;
IronPort-SDR: DLCjiJ/DDn/zXdPqJ6QRgHVtSbBZqiE9v3WvrYQU8TVmbI6a/VDArguCcANro35uWgyLqE4S6E
 AcOvRgjhNvVLztEFXyeVlpf1wFlnxBWiquD7KjAvEE0osE5BsnP46PD9mfD1JHQKcFC5TQkXNn
 /iLb2u8I+fkPyDgrq+6msUY032cybJnrLGAUzIKjdCQqdJtghBHrbOB1NGWkHpDmrk6/yH960L
 1a0ilzbQ+wQF6TvwzFPMfCqcJ2D+Sewot+HvNB3nUSV2b6qZAfgybCmPA5XUhL+bEenjpi9EZq
 PqU=
X-IronPort-AV: E=Sophos;i="5.77,421,1596470400"; d="scan'208";a="151002370"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
 by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 05:02:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHlckLQFueKkm3yFkuPAk6VwG21Be1vzIdTN3F3boUEjUQoRtowKmZ2eUEEZ8EXDACThWmeR2Xw+VDqQ2fZJH4MjirTicghCvgPKzefNOHHWmypFcRwJjTw9HbtQcDnp3gDeRow5Oe6yiSRqkJrLX7LzSklckGJzhTY7kji2dpwI5NBPFjQbzn4dWOXSoqrw70AxfoyLB32//95SxxkueryZXAyIKqRksXam5PbutNGeFgalbu1vuTPgt6g1wpCRbqBvY8qoAzFXUlAbcN1wti0Y2zKdimlOly/KujXjLelc9DRESjHayc07aA8yBMAOfdJnlgStvaJ8HQa6GIeNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdJ9ny2px2GLC5099xB9gYj7MuX4RnMuH8t0iROlex0=;
 b=BjzrsLGm0jhVyjwAtFy2KT+Y/SNDTh6qrPQoHJbzYwg1vihaGZZeYk+EpCgv+qm8tkGuXoXNBZKva1yCLzjqHlZE8N4btc+TKqx3TwSY5kHDlCD3q1N81E9v+R1MULGpYNbu3xC+h1D30QM6ltyd6g8YljRj/1l2oa5/NozBA4tJCxaaNcmarT++QzyDgDRYeaLhB+TEsjWZzESVRHQNYmbMAgJpJ90TjgyW6NsHjPH1b+EYd/VfJcOBRyzAyB6m1Rh9iVvhq2bS1AzwqWdUxQ6xRrvm/8gtAhnbOrZKYM0aq3aEQ0Dc7l6ftm7klIhoe4mGPlmHe2nOGiZBSnKCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdJ9ny2px2GLC5099xB9gYj7MuX4RnMuH8t0iROlex0=;
 b=yrvZHIbC5PNdkLRrQZktUoM6XlTzM+YlQq3EPQnCSysvKvsej5NgwFc/hOJI7PYnYeYNNUbq2xc+jPAUirT3260v6etAurXKYrUsQ6NDOsJR0Psbr5Z0Xz1QYVW9ES+rqCiKLgbGEpDzla8s0LOesj+Cxk3TntDC0wsrme5BHhs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 21:02:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 21:02:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-cli: remove default ctrl_loss_tmo for connect
Thread-Topic: [PATCH] nvme-cli: remove default ctrl_loss_tmo for connect
Thread-Index: AQHWqXqlpxSpjn6TTUChnZr9mcd4dA==
Date: Mon, 26 Oct 2020 21:02:53 +0000
Message-ID: <BYAPR04MB4965DB3544F102E75DE05DB486190@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201023202521.9610-1-chaitanya.kulkarni@wdc.com>
 <5c212507-d518-5343-3836-93107cfea53f@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3edda4f-baf5-4d78-3ae9-08d879f28150
x-ms-traffictypediagnostic: BYAPR04MB5431:
x-microsoft-antispam-prvs: <BYAPR04MB543168D45587ACC5311C166C86190@BYAPR04MB5431.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/UbbQZ4W8kdefxNuvgOcqUAdJRrRt1rv2U71/RwSa/tEcX27a/d0NNDZuP3gP6900lNaWPcxWJuCegT6QIL+oqPxT2mi44b4gj6hMzVaDaIe+E3+VQNq5i7Uw+WKritZtH514Fa9UoyOFDC2f+G55PxXeLk7JoHoqmSnADmIQEUmB0e8MUr61QPxZzFp0z3g/sQRygcAZVo2GVKcDGMAEvWaCg0a9nV1Ltnys7Fd36blsLhZKK2+saKy8VO4UuJ45OUPLkYFbnVM7uyrL/uNp2yPkGGtebS34cKch+WQQuXzPzTs9aidMETxzkXYS/xmcZeyuToORw0z9OHRI3HLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(33656002)(53546011)(2906002)(8936002)(76116006)(9686003)(6506007)(186003)(71200400001)(110136005)(478600001)(52536014)(66556008)(8676002)(66446008)(66946007)(64756008)(26005)(4744005)(55016002)(5660300002)(86362001)(66476007)(7696005)(316002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: OASvr/nvWno/33CoDOihR6NHDqPPfnBB8R5z5uhqhedcp5mU0JIAVgGODrSzP7hJ5zMcE4aTscE58gZSorUBPZ8pOQRo2y9EVOEyilwfzs9OMMVPyOXZw2LYc5ShCW9Fa3FQv0lHgjX7cQASLHE7gt/s5W/9FHTPQjNE1tDioFJPLZWI4WJ0QpZH5bPyxx9M60xh7sAnQZgZ0pUWXPda1MjMsPHSDDap5g8ZUi2+lI0HxR6xIf5bFD+kmJfzh8PgxQw6cWmHWVqLu9b9ZnWV7mnYdBsDMSCYl7Cweargo2M21sT5+Ykh35UAPmqaTge7/fsVEYpxHFBp9p3xicJ5AEPRRm4IWf4+8Qc8ic+MiFTqStiOTnsv3+IIEH22002oiP3S0YHYpat72qUUOUEoA06URhJ1AXUMLlw113gwT0wipJDP5CD+YG63YlLWIZ4vqUP1zGaHBBYpv12laRpya54dvPC2FObElLdYWZwEjZwSjPSWfFNeQNdyLBhgmZvOLxzBD5npWZoEC04XlZpC8lUWaObsUlke4pVkxEe1ydSTrs4s+yBfYMvhBpqRqkmmx3u/+OG8nP9i5V2WBL2L6tcusu4q6OF6OXRuH3n4xJ3CsWDDnFPZoxk1IUY22yYf8pcH+Y+08DJnBCyp4IG3NQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3edda4f-baf5-4d78-3ae9-08d879f28150
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 21:02:53.0131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +N/0bAyILV7COF6vJYy7NWF1FLF913ONyT+IGFURORCWC6jeOUJF4W8gMCzBluZMhu4Jer6y3L2NVOOY84oamxU0OguVRE0qaDpiwzaJvaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201026_170257_407136_BA7267B4 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/23/20 14:16, Sagi Grimberg wrote:
>> diff --git a/fabrics.c b/fabrics.c
>> index f8a055b..9c33c02 100644
>> --- a/fabrics.c
>> +++ b/fabrics.c
>> @@ -896,8 +896,6 @@ static int build_options(char *argstr, int max_len, bool discover)
>>   				cfg.keep_alive_tmo, false)) ||
>>   	    add_int_argument(&argstr, &max_len, "reconnect_delay",
>>   				cfg.reconnect_delay, false) ||
>> -	    add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
>> -				cfg.ctrl_loss_tmo, true) ||
> You just removed the entire option altogether? the user can no longer
> pass ctrl_loss_tmo now. You should instead disallow zero back (i.e.
> revert the offending patch that made it as such) and figure out
> a proper way to allow ctrl_loss_tmo=0 functionality.
>
Thanks for the comments will send out the V2.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
