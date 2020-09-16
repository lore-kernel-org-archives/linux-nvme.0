Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D673C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 22:30:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EB1206A5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 22:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1sTmCsdy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JKAstaIK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HnO7ivkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EB1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=sV5Jvorao0F3gy238sC+Delm1BtHgZ74FFQGCqkyupo=; b=1sTmCsdyM807uJ43MnYu3NPOd
	adIhKG6gN3QS2l8dH6fc3PDT9PsEud8EB2JSXuP/tVO1Pn0O3wnIOAI5Ljy7ijuXEO+v3RarCgvQl
	1nSSY4kE/4gBk5R4JmMA+8QAqh6PcYeho2ZoBeXgnqdHM3iyeasK9h5A8HdTnuSI2mwMoDX11OfhG
	LZ4KS83/G01/ok2A/5WbKh/fouNj/8xmOWgnsPbfeVd716I3uAYewmFrpUDjKM5vgzX66xw7biuEY
	sbcKTflNmrJ/ztVRiKFLcb9nb5xIsckBNk9LkfDoonkcMVkAAIBpXzsWHaZSBbZnEkuQbSER+mavH
	vPApQA46Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIfwu-00011A-7m; Wed, 16 Sep 2020 22:30:48 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIfwp-00010S-OF
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 22:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600295443; x=1631831443;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=7SPMTGuWtGJRLxNAOx6FItcv7BqHQCChXFFOkCdQCgM=;
 b=JKAstaIKi675dW/2ax/TlCm7Gm/g9HR3/MJbgYgbXypY6295yyuaUv/9
 QC9yjq0JT4htXX0JP+OVhZLjkCxvg4LuQRYGvqNhF7BXMFud6OhbJuzIJ
 fX5gI2I+08oxhBljm2EOqXiPrV00z1WaaAcDdpChe/UDMzqkPhqNIUaSf
 S+1HWztov5q6Kjs6iCBA8Y5o3UAVczkKIRB45w6egGS2GUKWuo6bwNg+w
 ngw/AUs+llUoNbTzNFFPZWFn2mwILyeJuU5QmaZS7xpacSWJ277Rtqa0H
 Ab2L6HAk+t1DjK7y4FKmHVsQ1PaTEjqjZEYr1mtqSe/Sk3fKPN6f18bYu w==;
IronPort-SDR: 3Xs7IR0P1k7vp6G4JF54jkTDLcEF+cCzp4FGEvp7qvYyMH+ivc+b7qMrbwLiydoXXiAfLNyyir
 N5FK2IVj96W+/GeHmFPSKQaSVqSxYcHa2HvfLe3EyUe/FiNHwdYPsleUgRcyNQiwuG570zv80q
 EKd7lwx5ct+i++55sTW4GRjPHa7C0RlLTJFA+gPEf+z3HwSS7jKBiDDFg55VYe0yuDz7Ik08t3
 dVn4eetp7jeA+Ud0rmK2lNzhG63imw7KijsTka5hfGX1fMBslpySG43JmgYdoV8DkbLKwDADnu
 EOI=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; d="scan'208";a="257222320"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 06:30:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJzkbvtjsb1U0JyG4fPgSsGfZk1z25VY6QJ3+aOgEUgKmxfFfT+otaMXsTipMPpbUsI2xiKMc2TaydZ+p+Gzcweba+jlrCbbf+TdL4CD2ek7wI+JMgtFL/d/Rou1IPTtPPPGoCGWARbPH0BjtLbmwbIN2+/JOW3wRfpKlLNPtbxvfNv6bq087vBao7KxhXZ+bPPp00+5oxF6YdDC9Z7H0jcFgtiQbTxNPMFZC5X3PgSI00Kxc7zk1lFObaYq+4Ye7OlVsoNv/Wy2GIBwK3e1iCK2PHlNU+ZDe3g01jP7CubnbXVOnAyQxJ/EqgUrHmKEIhSBL7B7l9p2H7FoAFyJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SPMTGuWtGJRLxNAOx6FItcv7BqHQCChXFFOkCdQCgM=;
 b=Qn3MenBYx9dFCJpxeyLe/qMCKHran5g7/HGzvu5MvV9YQoUzzrIl5iuDtjybb4Y45SvoBYby+KBCNi+NuB9PNpBGuy2GhF2SHHYyW9Bkgn8SyyMW6rE+Q57GNOOTXXJOpQkOl/Bb37+0F9aJQ4NT6Q/LfbbJgiUPBc/yl5SjDKnJij+PBvwvstsdR6u8myxar+Vw2IPe+uDx547PouDpqmzxWcC6dgyNbGirfImxjAtPsESgBS/GopPecvv1gen3rC0DzcDg5rzdk1t33gArDJuK63wadbxIv0XPsPwDX3NdAbiDTSq9Ki89dS4o1WObXcp2FzEYJgwEFFJdXi9EHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SPMTGuWtGJRLxNAOx6FItcv7BqHQCChXFFOkCdQCgM=;
 b=HnO7ivkgCTAhod+gbvQv0RL207DghY6nQ3OkqPad3Tr6s0RH83UtMafZPi9Bh5sPRJaPZqDcW+eqgLnQyhZEBMmHlEkJQK/TBJQQYd8S1Eo5V/0AzKI8QgJxWj2sqzFzz8/Vmb8R/BoHW7ksyz4BQ8AxvkLZDYFJHwgqU2rlzaM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 22:30:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 22:30:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Thread-Topic: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Thread-Index: AQHWi7SiU+yGXE+Gyk6gjm+/HimNtA==
Date: Wed, 16 Sep 2020 22:30:39 +0000
Message-ID: <BYAPR04MB49655525AAD3191DF31E2B9286210@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
 <9aaecc8f-7eda-b792-2e5f-a8cc8f8178f2@grimberg.me>
 <BYAPR04MB49658A3CB5BA3AB70434551E86210@BYAPR04MB4965.namprd04.prod.outlook.com>
 <9ae2644e-73e4-768f-965e-ff1d41c19c6c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0b23807-41af-42f8-0296-08d85a90241d
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB65495C5F608183FCB7467A0986210@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uBwV5GB/j+bEu7RRu3SQKEJ1abgcQVmn5S62sZpIKreifqbW8Qe3lFBtON4NymEAeYo82MSPNatGQnfWP56hUrt5lx4ULuu1evB3NZcJS4Uy2jTAUP1IzZulu/WnzJZ5H661cLrSztoYeFiX1KafezpwR1U2sG7TB6YN8MYLdf/jFoRcAPLAi66xJiOlYiidUajwZuCe+gwNOSj8b8LzpgnWFwx/sS3mZFDeaBMU6iiNKBYKhf/pKvARRFuY/odO86qzzhsplC6545hhydF/jdeobJ5Y1RzGZp8dF2YvR3lz3IFGGKjf3u+XCRldv2XcmSyKxU/Na2M0JxXtyRX4rw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(71200400001)(316002)(76116006)(8676002)(33656002)(9686003)(66476007)(5660300002)(64756008)(4744005)(110136005)(66446008)(66556008)(478600001)(52536014)(66946007)(4326008)(7696005)(86362001)(6506007)(55016002)(53546011)(2906002)(26005)(186003)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: BjmXcQx4fKWiQgLEVad6ldjPQsjs5gU8AbFhTzTHklbidLfjPbuapSWhB1jd3d1XuewFXakD4S2JsScmGuC1Ku2fhOKCrH5SMW1aeWUDPvulsl2srRoTSsC46mSxR8YtxXWtvy+Ztg3jaJsAy50yedY83Qp5zxx84gByM86u1majB+CYYOvVPLMauwpIQ0YqSnv1+xiTEl618SZK/G/BqjC4MHLpj5SBuS8DYNzFigzuZdwbNaoRa1auf3Iakivwxxo2fVkzC6MhZM1JUaBl379UT9AD4kaa+8D+B4oE9RbdIxnkAPGZ++/Ff/1b2bL2CKO7OQcs3ZkpcQPdOl8btwEdvulUe3z/quD5p2hxT+0mblzDK/7RrBDfJx4+Wln6bzWBLrN0mw0BPJcYfYxA/UHUeFFx4YP5jfYFEqCnC5lsDY3Sv6YVYH3NLlIpIqtTNXkUclyBNMKvr9H1omYupsJi/IPddZPTXMG5FFIJa216OKsZtt5GJtfC3nGgSrb1Uk88HkAl8fOGKTVGvpUefZg4kEAE1YBn75IByYYoiv/7MtRDUDbBoK6rKM/ahtVl8QYOQXDRCZBHeh8fbOWZ1bVy548mY1NlZCR0P+udNRL7Ek7wQ0by4zIhF4sjKInpBau5JOvBgum5vGeIQuGaNQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b23807-41af-42f8-0296-08d85a90241d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 22:30:39.9007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWPPTOJu3kgFMklcess6mlnUOA3WrDyfVrEaneSqsBp9TDYjLqNFtUZpGquYBFz8YGQ47+ZVLjKZQuRQRBsVvXmgnsRztBudflVu2+rnPoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_183044_120605_606EE21B 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/16/20 10:00, Sagi Grimberg wrote:
> I'd say we need to fix nvme-cli not passing optional parameters by
> default...

I assume that we changed the nvme-cli to fix the issue and default 
behavior (i.e. expecting and setting the ctrl_loss_tmo).

Changing now again will break the fix in nvme-cli which requires this
default behavior ?

I think it is easier fix with right comment documentation so we don't 
have to rely on the tools, plus it is only for nvme-loop which we use
for development and testing but not in production.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
