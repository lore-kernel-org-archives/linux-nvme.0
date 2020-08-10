Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:23:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0D3206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CBaSIwrj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XEXMdYZs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C0aYfCC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0D3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=oGiN2pGDZAFVvwVhBDz5TK4EgqJdHBEWq9GMtB2ix0M=; b=CBaSIwrjFoT9EW3wGTJSqbwKi
	rZawaPa6vKK3anChEobDnL4pHkWz50GP91ypRyHS0SzGc27rhDA2JzU3glTTTTYUDIdOiAXl2LgcG
	AigqJxippcGScqSdyp2GeAHuQSb+zQ2b+vqgJxatKMOtby8DdRJ/6o6fo1Rx9l95feQKstJhxl3Fm
	2jJXXjHyccgFB6dmy0aG6HdvFeqVhU40MM+d59gOTI9snxcsuQ03ZDm3TL3fzA9rfZLNYmqUL1nkI
	9wExEN+IfEDmf4ePSWmol10C48koIL0Ix3k6XnsM3cZlYUHgauFfju1mwqos1yVn2Ia310AOu7tgS
	YqU7ESuCA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5H8F-0003SC-FW; Mon, 10 Aug 2020 23:23:07 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5H8D-0003Ro-4m
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:23:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597101784; x=1628637784;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=CnpHzSPzi19yBpbeZD3e5VJjlHzQaYGxpJ1r+GAnTTs=;
 b=XEXMdYZskC0j3KnOmHuVGyKVFuMQ+rvSYHvQYYp2jJ3I+NHHf8tH1PkV
 f3ekoZzGru8qm7b2F/4Wi0BaFWO+YVZHPHtsMuY2/dh9+6pSYsxhXBDGA
 YFTVqXDkuuWHb+eGGrktTnKcxDWaG+bKuRu06wlDghYNQfNvZHQDKDgRa
 iFVvFKpT1jnZ98TPY3mPd8MFtnw1r1HJNl3DF6Z38D8+fC8QWaVSgB+GL
 RicGUkf0H25/4fheqc7FDeb4vCfEhK9UThpDXVhAZJ9+BimiNJSJYWJ9m
 jCcEEhXC9fxMA7Dzv9GxeLD+SUIPn3GxuL08yGfm4lUZeyhtL3cMlXPuH w==;
IronPort-SDR: Bk6abkxbHCzKNqNjPPMaNX1Er47swkdMz1b8HWpvfBnqvb/Tcj40yxvIAmOv9xJQYVYXWboVyw
 bMW6JXRyUP639w9vLhOgcYSPMfe4XZt5oMW8CF2NyyNW5xIWWyRvYsfnV4/mcEqfvL1N8MGxaM
 KWSk//Ba/b1OHe5ON+unRAOts19Nua/VPEWYF3hXuzWiIlBrPXAhrPJDNmnSnDmOmJN0uC4KcS
 2C4uciI9ZnaciK8mzZYWNzywoTfGRxd7zpolkLMW98vOiKcRXI4UAxODAmQ7MYP6u4ToOlvZln
 s8Y=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144616918"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:23:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWr8gLIepuqHipBPBwjwuhhyQamzZYmNFwO9l/4MolI9E7FjA7hT+tMYMSSlpekEEd6VlY0znjwM/gLvRqsm75RSjEeRON+43fn4hq95pg8ObvrKCp7I9P8AVevv38UJaDukYsv/EmMtWoeFLC/OuVIqh1uhR1wVsiqHEV5me8DZVDcpJH8I8vaUIBJzG5WytvlNemjO++y9GsHBzVKpJCvMpUEVVNBYke41dTmIY7ErUShHi3O6iJ07vvKlQpSuXT+FTx/mx2WqSfrVChSvffByfaVXKIAjeCLGGNYbd873cphF7Cpxq8Eq5trJaOqIeogTs+88++isslfaVcGuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnpHzSPzi19yBpbeZD3e5VJjlHzQaYGxpJ1r+GAnTTs=;
 b=a0nGa9ceTqY26z1+46pBdQSQscO3fqE2g5wfP+tj/d+BKtSPjKiXQEKp+Fqbm6LOebWQi7gcRQm577uD45c/bm5whWOfukf9b7kpK7x+KdBuWJ7IzHb1JlEvpiJwPGpo5bf6/lfmuH0kli8hoEJueEr+uBFyDf4HAmupmNl1zCZ5/2OBq9vkZ5yK618+0L+4ns9qx9TZYmZxEQgqyRRwBocESW1Kg0HGrAWQYegK+ck6WqMjsDSUPxL1XyAnCeTj7yCHH4FnFCf8M6xnWGIfFhcfYAODJV+hQcn/9QnpSi3f67nmgJ28LQB83iR8hUOEbtmPGyte9QSdLeVAsz0lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnpHzSPzi19yBpbeZD3e5VJjlHzQaYGxpJ1r+GAnTTs=;
 b=C0aYfCC11xJWbjjwBk+IiBs39pkVRK2h0KlP6toPyAqCcPzACvg6Ha+lePnxNJo4grd6JAsGqQCzMRQcPRyahTkKW7K+hzOktYj4WIARAKcH7ZVCnBkR3KMkIgkCuyd8wG5BwH3Qh3KsAKDejwEIU46m7DNn1E5+SqB74LqfZDE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3959.namprd04.prod.outlook.com (2603:10b6:a02:b2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 23:23:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:23:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Topic: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Index: AQHWb0fs0yKpxgu3gEaaZuX9mEBqyg==
Date: Mon, 10 Aug 2020 23:23:03 +0000
Message-ID: <BYAPR04MB4965F8FA39BFE340075BC37186440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
 <20200810211119.GB269401@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB4965560F533D2B758FB7132886440@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200810231053.GC269401@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53bb6de0-42ba-44a0-0116-08d83d845470
x-ms-traffictypediagnostic: BYAPR04MB3959:
x-microsoft-antispam-prvs: <BYAPR04MB39591195CB20EB0610849FE686440@BYAPR04MB3959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPNtPlqV/muTYIwoZ2C0NNff+83Ym5rOU1znuqxyPxl0MVdiI7vumRtseWSJjNR/wo7kFoT2arke1Q9Du91C9yECHKvLivJOMqze57XtM6kt55O6YKjVRCrQk4EbRdYO4nEqji/017xEEK7XoQvQJWmvefKRix6WfUAVpH01KiJ9r+2Yo9BNKHf6qk2gHCi9wRU79M6CwnaohoidOQmYZy7GUpjB9MnIu2lYAMhxZNo93VJbrfhOASOu5jMOVqF1sCGewouSVCl9ouvrlzUcFNkIB8I8jLQezGb3ukldNKazxapPvqRgSAqEqLGCK9MVkporbmao+WW5a4GXFRJY+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(55016002)(54906003)(9686003)(4326008)(7696005)(26005)(33656002)(86362001)(53546011)(6506007)(8676002)(316002)(4744005)(66446008)(71200400001)(6916009)(186003)(66556008)(76116006)(2906002)(64756008)(66476007)(5660300002)(8936002)(478600001)(52536014)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /L41eED5aWOd7TOlzdnbWA0s2QVH1jMwoIq2k8hIUXh99a0fLH2pJXZGgAHOt+8CQ/RXjNtfd+CVs6MnK89hq0MB9SqIgDwPuD+3cV/IoGwAcLke956cAhVLh9G+zPTwL0zMnRHrJX1fAZqhDsg6ItcpqZ4Q8Faqt3A6YjtLyt4xjvaDxvR5lDfcNEdjBFaG0VCZL3e6vvT7ViiqFrs2uihoK47e+/YqEi/Pn1cMHwGyO2TApnSruETdxM5BvwCryHEaCnEYGJmwMqVVGEOe0alKEz6pbM1BgoCm9knryEgV2EVOPQgbpvUe7Ffz3JLWWNW+pegXV5FFnwdADIcRWGimTnmVG1be9H4NTm0a9xdJDsgKVYUWS3Nh21EuxqWPWjmFIUaa4BR/vF/LeyuTSpkP7kBSnRL4kArfkvgS2gazu9PDJ6OCFPC7mF2mwmqWmE0PEeGSh3+9Q9S5dYA00riK7lwimdWQ4pXt+bfFjUAMzoofUd1eEttfsT58NFvvhdRxSXOulNNs09xFY+uN5ncUyq2A2UWpUCgfkubwtlc/crb+3HXr46wrdZHN6UvTKest58fD3xT2LPCQmqfCd3Ao/0kbHh4MYI9AcmllUv0uqPvO9DI9nf84wgWOLOnkEnCMxax0y6NxcQrP4dfkpw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bb6de0-42ba-44a0-0116-08d83d845470
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:23:03.2870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMMcCvFKGNKlGOfqDOWdGIVqq72zVYbij+U8CAOvbeJsnMm1oUUd65t+I93gGwvdbYRMgluI5f4fpD7SrI70mok0oUVorFSKQnf5bIEWLs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_192305_393807_5003A115 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 16:10, Keith Busch wrote:
>> Good point, maybe they are needed for backward compatibility ?
>> Can we be consistent with the backends and different flags ?
> I don't really follow what compatibility this could be about, but if
> they're not used for REQ_OP_DRV_IN/OUT commands, as it appears to me to
> be the case, you should just remove them rather than add more.
> 

Then we have to remove in bdev backend also ?

Sagi, Christoph please comment.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
