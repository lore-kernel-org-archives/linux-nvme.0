Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4363C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:16:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907DB206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FL36B4vt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="olTkolUo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c7qqGISx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907DB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=bn8DWG0/yQEcMGz49UGhF9fGw6BbXYENkFsU17VozW8=; b=FL36B4vtJlQa6qpTXwyMRIbz6
	X1hGP9ymOluzD0+ecelKpJJc9HisbAWNPrWRew1nIWsyny+sr4sqWs/Yobv0zxXup/JE+fyw0lsdM
	LxSTOaeaX5TJawEEien3GpiPFYs9kgJ79rmsJMkYdfmglaP8rm82BsaDtnBeCM16/VwgQ6hdx6ode
	Azb9tmAHfKis+bI7xOeOLtS/6PpePRNOvo/K8t4OO09zrzc2sh0E/eYpXMsd7VZyEBgyy0rInsYZx
	ieYTLENNCEFimLIAP4iAdnCxN5KwWRF7XgJ9Yy0cs7s9wlJoNvznbuEdynzShBsg/VE3ev6Jcx/hJ
	yupFymFRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5H1z-0002d1-SE; Mon, 10 Aug 2020 23:16:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5H1x-0002bv-Ev
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597101397; x=1628637397;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=n6gTRj91D0XUFk/IFERKYqsRMx/HLOBdTLLQCNs6VjM=;
 b=olTkolUom/+NMA+s/OZl1mqIOSLKodwgSs8FFKgdea6lrjr8ovKR2xRu
 9K0HmFh55Wt3mYLTIrWv7sELfpiu0efz4M0aQoqE9jl5gBBtpjfkPGtqy
 xMa6veiNO65W4L2aOmIQMLLCpUDUknEMxb9bfPCD0Xw9Ky9Qv74bFqEbd
 zfkiGITsbtk1E/0x8FDQaLJ5t6FGjcxfplzMdOimeXmVJTLu0Cn1kzS6x
 qMoGznubR29lt8UfDceMG/EXAMwGmiUXpWJE6Fu9TkMDHwUcYfBOhiQJ3
 H8bkXIEWz2rCZhhKA1VJPAizRCZKvwUBKVD3Vr94Lpb6WQ6TFSGonNbdG Q==;
IronPort-SDR: dgRrO2dmHdGjjLibPyCOYw45NVZj4/6qIalazOcTjQH0DdHaGTtlOxvZgTf3QnRbh4J9AXB0+N
 LACHZ912JHULiuyFtnAu24k5aFop4poIqGqTPxiqeBylv+MNY374qVYKJb0Df841gR0y8hc6w2
 ogi48AZoc3L8bVPbFaq3npRPAkWf9h/4A7ofC1L+EUDh91bcmHqCS5sb9Ap0scTeNJDaHW6pZV
 a8b2q8avVotDuXpYvgSN7XXD7aoHo70FUiokqddKqb54ShODTEcGymaebl39mwKkANRO+uu8J6
 +vc=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144616626"
Received: from mail-bn1nam07lp2049.outbound.protection.outlook.com (HELO
 NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.49])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:16:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMseb2v19nB0vMJcQcB+CIC9WdZZNurER3R9Oi7tq20HBsg5IQs+WTKJsdAzDZ+Zk7MNbBiI5PuhvcPjGMQ/MD83nmIfV60FHX327BFyQ2ab+jkYLxmvSgEhl915+TvLBwbaj4GfEj/WhoW+yjuo9hoxJEG9XDbhQg4VjHjsVvgbUxvUvrM2qWvrSRFcIrlvHE/HAgrlUcyLcKJWKiU8ATHLo2w2OIRLZUFGwCIMJCYCKwqx3smzWsxNWEfSNosVUzhgUUfTJ4QhIZlOaXC1gYJ5X0aZ0zLC9Ys8mz5P7kFDv9Q8Wp2GoJ869Aogew/RcUnPCk1f5L6cR6MqTxZb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6gTRj91D0XUFk/IFERKYqsRMx/HLOBdTLLQCNs6VjM=;
 b=I+v1zpEgDAyq6KPHKC0GiN1KTIkIvrhWq3mh8MadJpPdxvS7DhyZT5aGcfv9L2nxo/35zTD48oGrbLtL1Sc0D6OXoowK+FcDiqAfvThXeX4UUdoOVj0j43uKrvoBKxh285OwP/jI7iJX9bDSo/Ht1sSA60NmTcEkEgMddQFiitkWfuUyDugTw/K55RxjvlUwpHfBPpVa3stfE8fpBf6U72E2blvVtiZzd6OciNiWeyqA5bnFYaNwsImTN2zhpF1L63UDEcy9C6R2RtfpO951Q/drIG5FEWljXoZR6Qk4AcFXksP8pILbRl7MUi6xXMa/yg0O7ZmUw7dqXkmy4gbXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6gTRj91D0XUFk/IFERKYqsRMx/HLOBdTLLQCNs6VjM=;
 b=c7qqGISxGjgXHST2z452zFuQCUd75CjaCVi+UrhLbGq0Kdj4k9PnASK1ua0QXDmef8WBGSPz98APrkTtH8xUSGwNb+Ko2P1YDsZE8ZL5iTs9lvFSK9Lx0TDHAAwS+bj1XJqxJAe9eKD7GqKBt4LqV5YjDqOZ3OxJAeIJdloC2vU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 10 Aug
 2020 23:16:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:16:34 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 01/14] nvmet: for pt I/O cmds annotate req->sg_cnt likely
Thread-Topic: [PATCH 01/14] nvmet: for pt I/O cmds annotate req->sg_cnt likely
Thread-Index: AQHWb0fJvul0WzksoU210P1BYKlyqg==
Date: Mon, 10 Aug 2020 23:16:34 +0000
Message-ID: <BYAPR04MB49659FCA330EA4725264270786440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-2-chaitanya.kulkarni@wdc.com>
 <53dd1aa6-31a7-a9bd-6def-5cc18468845e@deltatee.com>
 <BYAPR04MB49653405F083DDACB0514D4186440@BYAPR04MB4965.namprd04.prod.outlook.com>
 <e432874f-6a22-e56a-777f-990e283114e7@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44e350de-11df-4121-bc52-08d83d836cc2
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB654967D339126F72E7CAA99086440@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yvt8HyzkCgRx+3UZY2fsJQwZrkjzjZk5G/hS1LhAnD5mB7qCOGo9gIatDp3M1YeT70/AFdZDJ3QkWyq2dqAbolrjI49VsGktxa4zX0ITR7V0o1F8R70Eb02WAaaT9q7D69hcBl81IyfYpYGifcCNgd1JqFVRaACkJO5R5dTVmIUfjrRowkFuimWi1eMzuSuamy1djxf5+JJ/sj0dg/Om93ak9EiaJzcP1U1OZ72Mke6YX5++nd571qlidbQfvgvYwMux6OgQmL3dfLtA6ikVkfO6bbM0dLg4RoXkB8AuCWVxA1aOsW66uTwf1Cvpu84u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(86362001)(2906002)(110136005)(66476007)(9686003)(4326008)(316002)(76116006)(66946007)(53546011)(5660300002)(6506007)(4744005)(55016002)(54906003)(8676002)(33656002)(8936002)(186003)(66446008)(478600001)(64756008)(26005)(7696005)(52536014)(66556008)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: cDWGhfaV7xdwXmcCNF/VjPCk6dK0d7qpkax8jA1IiQVNhHdIadBgiXwKlPcr+tA6jRg6p0hlYFrT1R4RxABKpoDWli/Faby09Fm+AU5zk9nq4RaepJxcAIN+gOLy1dDH4o69Ie0ExLw+x7AbKkN7v3vD1uDO+t4CiTYgzlt9fN8H6+8SH46ClNL9iRD2tOHRJj7NeYIZevZSabeL5PXjRZbhnFjnLk4kbe0D+76bXC7hTDSZM0CyagWIAU0gj81KZDMj3x1xrhGM12Fkxs2m+EZAsrgmmc1qkI85dwWUB7nmQcC8waluB+V3tJt+T/OBnQK2JaglvCDxxgyPdR6fUF4l5IFyFg/Y/nFhi8RPny6oHiF4AtLnxvQqXRGg34DX4/049gbIZoEBNhBwJmz8wPkQ5DGhWFuZvuj+87JpneRbRDFqKbACQNZo2xr2CettdycgOF6X4X/YG8O7PpdwzLX2yDavOw+2wggnmnA1wkW9NsBf6xIn+DEpmj5CLG8hNhlijxHbDrIN2hiUB6lhLWvjux5Dbc5B+9l7LYvgxdNEhMgRtXPHLiNrDh50kkcCwYryHNYT1q/dweJOJL2npRlD0BewtyC8rDobFpXtk9xwaW0h+PckWpEug3/eCzLrYlejmljTL68McEhIPpeaXw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e350de-11df-4121-bc52-08d83d836cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:16:34.6737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOc0EzALcNu3Z+pMRxhZUqo7ELIPDTGYtcOKoBD3Jf8k3ou0zcVleADlkwCDrG8AmLK8liF9x/f+gpbwSPEvNJMATeGbXvBjNwo/9ASTWVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_191637_632420_FEFAAD45 
X-CRM114-Status: GOOD (  11.30  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 15:56, Logan Gunthorpe wrote:
>> They are present in the target code. I don't see any problem having it
>> in a passthru code unless it shows severe performance degradation.
> Isn't that backwards? Don't we only add performance optimizations (which
> likely/unlikely are) when they show demonstrable increases in performance?
> 
> Logan
> 

We can always do micro-benchmark, in this case code, frequency and 
conditions are pretty clear and straight forward.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
