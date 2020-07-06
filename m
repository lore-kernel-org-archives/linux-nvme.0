Return-Path: <SRS0=qz9S=AR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B7AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2020 02:25:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C672070C
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2020 02:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Picbum+f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GQJbtC/H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oXNKF+Lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C672070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=2E+OyAlRRApfUJAQ0SOKH6TX1tGc78okRUYsYjAogZI=; b=Picbum+fywZ4Da2Dwg6JBUTCV
	HkGfbtxAe4KFpnfGupx2PKVrRiKGEJhgcg2k7D/k0nFR9Cx2fuBADBJ+ca4O5VIzdE9L+UIe0ItPF
	FklzCJKHKV6ekeClxt16nwaDwsv6YfFBOH7j9dazgp7MunomaOz7jQrxufnMc3y2aSVEDVuWWYW32
	cwiYcBu+33YYXKBwwX7N+eXNpPlo4F4M7drB/aq+FbZUeDrpTn/w6719ne8HQ+9t2rzEq1/XQNoKY
	wz5YRQeTfCVkbohFbapCkuaxTwt92ewIVL/rfxCpXbyemnaRhsn0PgD9GPi5gUYIwj/7SjO6U/RHs
	fBMU9VX4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsGoj-00069k-6p; Mon, 06 Jul 2020 02:25:13 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsGog-00068w-DF
 for linux-nvme@lists.infradead.org; Mon, 06 Jul 2020 02:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594002310; x=1625538310;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=c2T259ic0yKu7rg6tYhMNSjKPQjSk30g0Su6IzM1ulM=;
 b=GQJbtC/HvFMBJ2niWNHeJGBuAy3fwuKekb0CRBKaKc9N/tNNv+4Q43+g
 udA5rfVE6x3nbxXMKqXHWsYnkkXuLu0ZfLns9XfOhDj9MNsWuUBh+xZ8S
 fa5aXF0WoV8CB4I43KsEEuGV+ZOmXQrJShl1aCd3NdPjLBTaWFrxP9hUE
 CpmNmUAfqRWCnq+c847huAkxKeWOYsZOT33VdeMGRzJIXswtDA/K2X9Ho
 jG1hqFkSW+Eg6Yvt9DjwzIogz4mdJ5bHhmcfeHftyHp3WoycquUoIV+S0
 12MP8MMf6Vaaleexc/z4/uT5z2PWmfuLLfHO6fnpS+dT3FFCMvx9AeEGL Q==;
IronPort-SDR: r2aBXyLxg94vbPZdMMCLO7+tolQ4F8HXhcXaiZJR5/w++Kmn11mdnsNZxCWVyS6283/W0c2IBH
 YeTw07oR1Mfg1F2oqqe2Rx/oKYxMdjh44hULEZEhbSmX2v1CHZwa+CcfPoQhszDe7KpLvL/3mL
 RRFPAZgQJCHssrK9zfPJer+Ew8isabfIS8Ui7KyxGTqumhyGKVH329vP1B0YDdC7SuTOjrqs6K
 gupnH+c2nb0UQ/5yE+jLaQc0KLxw/o5d/6I8wCaUmZaZqYhrK4zV1Oi5Z52d6FCf8ghPAOXcQK
 aQg=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; d="scan'208";a="141699381"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
 by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 10:25:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QITeg0D8WQxtVQdwAkUl0rmP3awtV2XzSVuN4yH1XCK/SKh9Qvy0s0bP/6Mug6177s1T0mlU+bl2xH7oZj683qklNJu1T8aZkkenZ7mcvF9jioxmNH/LLVXDw9MZVkp7BUG2s7N8/A6/CJXObk2Yya36AAy2InJFEBUzDT31wTiuHnVli8ZHe8ympLbhG6TWLFneyP0zyukA6ro0NU/qLEHJ3V6Oz+IQz1qKH1Hb7Gg8MNS4Zet0n3U4aIOvRi5wq9K1iIOn3VSiAj8Ta8Q7LeDJxTXMSswUqe4nlYBnvAwH95pzHnB+oGqRpMNJxvUO7fu2my8lacuySawH7BiUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2T259ic0yKu7rg6tYhMNSjKPQjSk30g0Su6IzM1ulM=;
 b=jvBNcRTZ5v06BaIaB3SoVYKBRctQVC4h/KwZ+RMonbmTVIK9KMku7jY/7Rn1GKDK9VJDn+ttX2NJo/azDSHMTgaQOZ0SgJ790rOrrMg80iDq81Qik/pUXJh39ZbdaPuBZhp4CCnfPFJOhzb54hjSGzkrSOx4y0+wKUKubgSsBXHtWD/dQ1daEPLI4oRS3YGnpRifW9m/e5mHtX2PZIV4t2uKb5rmsLWeR2ICRzFUtIB0X1rjZ7m6LJzF3F7pxWSZ6FRIcmBWg6ICbl3b1+0hguIpx6g57RUzAjf2nvDkjojMR8qDMZiCTgiUHmMHkTOGp0LoEsJp5CyWQPZimt67Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2T259ic0yKu7rg6tYhMNSjKPQjSk30g0Su6IzM1ulM=;
 b=oXNKF+LpsnA3vPhq44+QGnnONUzyPK59VrzT7YU6lDjfuvBKAvHjlhJfnxH95mRDcGeBLjIROOqA/5DNy2+iBLZjhqpxwrxRMA5gIKvkLuSRHQrtz0PrDWZOrQrVrs5/aHRglO7O4HIZzQhvuo7xX9/mqfHo0c0WV4rz7BTl0GY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6102.namprd04.prod.outlook.com (2603:10b6:a03:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Mon, 6 Jul
 2020 02:25:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 02:25:07 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
 <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] nvme-pci: Use standard block status macro
Thread-Topic: [PATCH 5/5] nvme-pci: Use standard block status macro
Thread-Index: AQHWUOVmjr1DYiX5Qkm8oEEpRUYj2Q==
Date: Mon, 6 Jul 2020 02:25:06 +0000
Message-ID: <BYAPR04MB49657FA8E31516885C73513986690@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 220d8d8e-ed2f-45e4-f082-08d82153cc92
x-ms-traffictypediagnostic: BYAPR04MB6102:
x-microsoft-antispam-prvs: <BYAPR04MB610265D113148BCDBD27C84B86690@BYAPR04MB6102.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:305;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsXa5B8w1qV8wCs8VMnU8V1JNoGV7NRayoyLlR9p1/hDf6kBp/rrAyKNJLRPQeAX8wAvyD1+jvNkAZ8H9uRf0Xdf7CdchiNaGLvRF6hEhnlkSG+EoXLgimRicbAnzpHV4mkMc0hrfxjTpMhPcfVbtgP8xlLp+RpB1umqPIoiTbAphH2IjlbjF66Vd7bDPnVkcj4GCyCRaaPSCZ/E5pVQ9OSHIsisCI7LnByj2A0U2tXjwV//p5KmJ/bk/0vz4tgDCVQ4Rwtq5gU/yxedyFWyEsbpNwmd8TswtkRePEoYbGuEMqvayJA+ncjIdpHHhrPAkKTcbSSj3WOh48nThvy9ww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(4326008)(2906002)(186003)(110136005)(7696005)(6506007)(53546011)(54906003)(71200400001)(478600001)(9686003)(316002)(26005)(76116006)(66446008)(66476007)(66946007)(66556008)(64756008)(558084003)(55016002)(33656002)(5660300002)(83380400001)(86362001)(8676002)(52536014)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: K7ju2MJAylvCWM4vp2njuk1sz58eStQfEmdOulG/MDWqO7gBcG8cPE21I8a2sFOM8mI77xzVG5hzwZ8d1+88a9d7N8kirtpei01T7aDCqaEZBWq7yVQ5zOfY3B1z/6Klo1Cd8/BKQkxzWqj16U3t2G3ibhbHpvEwmqYvftcGt5HoZjQbpa4GYv1UDwy6QFJtj9PmQsKepWJXe9NJOUpezFmhjhacMgqXnt/U7KGhOVPupV3BC6DrnpQ5rK+tiMb70AmMF1aLhIcCf9TjSHyDnkVBiluWHxB8YU+3Fg5dFOLfbs+72nL9nI6CcvksaJ7lTSMk3tDUplf/rqWSyhc0HZMXBPFH+LXol3fNy6TI/MowWaXiLaV/VlO7/ZbIBm7lvvkNvTNYPzw8EMqFM0As0AQF8knW5OAWGAE1hQ+Yj2fn2ul81/8KDTpY1hn7RbfMPPgEKPQ386Zvx74dWgRZrMk7Ffl+wk980JubsBOLDCk=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220d8d8e-ed2f-45e4-f082-08d82153cc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 02:25:06.9540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dM7R9JK4I779LPi0543JlPCzA2nNBJI/ezmiuUz93VAB4x70o7DU+k18386ZcCJjtr4/Rcr9vjCcqoS1EAloWYWSKItIykps013NN2eiP5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_222510_590340_ABF631C2 
X-CRM114-Status: UNSURE (   6.25  )
X-CRM114-Notice: Please train this message.
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
Cc: "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/2/20 7:55 PM, Baolin Wang wrote:
> Use standard block status macro.
> 
> Signed-off-by: Baolin Wang<baolin.wang@linux.alibaba.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
