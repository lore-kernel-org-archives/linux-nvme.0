Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53F8C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 19:09:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CD420A8B
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 19:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jCpWRDSl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l70uhWZb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ekJmcvjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CD420A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ovzX2hTFcbVJC3VAuWavRAc9JftVALOJZrW9kqFmndM=; b=jCpWRDSlZyPG1djmbIKUAvtIX
	ZKzmBZTJrIgsOpAFzIsK/rllLJAoA3dMZSCtjVC3KOp16h0JZCOeL4OesiMT6ORNdYU374DmeyoNA
	WPRvVRRD78imzE33KneY6DDi0UXoU2Kfef2pjO0UIh5VRw0q5tslgs8d18EEDDInFxQcV6qP9zC7N
	nuSfgkzRiS3crfv78lXi17v6ZeSCSaQb6hdjzzn0tY11p7grIiaQyRHCAO1Jz3hd6eNIwXhAIF19K
	SbrI1uT8o6DTcyo1f9Z9F6NEnY3tPVlLl+UexSDe6OI6NCPKIfmI8fQuL1sSTsm2O4ZuW5szlR0yH
	+0OatJeKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2fpt-00012R-3y; Mon, 03 Aug 2020 19:09:25 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2fpn-00011B-6S
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 19:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596481759; x=1628017759;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Mc2HGqcllPGRn7NMvlZ8PHb/aPWe9/k1MqmtPcDFsw4=;
 b=l70uhWZbu7wWUaq80pC7hC45o7wla6G9iAzlZCqgUbsq3y+yf5YNKQD3
 F4k6tQPOf8pF/iy3CwBQ1WyGYSrmXdGa3U2q0050UXXLnkV2Xf1HlvPvQ
 qkkmdh2OSIQios3u4Pz9raOhY4O2dE+Nd7jnV67DvGEEQ6fqefKNH/rhO
 6oTBDm3thsusYr4vhnsNCcLiPdNIh3Rsvw5ZkVcSv1Ups5wLOZLOt0bJ4
 aJ+tiDlsSwvUuVhdxkEap1nL7+3Di8sBCdz+pPM6/h9HRRp0GWwtE7+mZ
 sXW36D3Liu0N+QUQi3vL5gl8G6WNYcMrcpflKouOymiWIIEAQaOW3u/pn A==;
IronPort-SDR: Rl5GWXs3McN3vl1hMlbBKf+/dIYbghlhw5x0FG+x1zJjoqMF0dni/yjMfqzw/GrxE5l9NAp+0P
 0K19t1FiUVwcLtYyfSWaXw8lstkqprBDc2vKDl9DVscVcHwjt/iuEkuF1aMv65X6Ksyxi8FT4U
 5ojpuzgPqs3aSD6XpBaBVlHlcbmClxNLPmzUh+sjdHqDrp1dzDNCLcLD+E96dT/+WKKwDingiq
 7XaXvWOsnzRLxXe+KKKp+5T2arAI5r0tViDOv/FO+5Wo203IA4BSSHb0mS3vMLiIu/IrclWb4A
 HmY=
X-IronPort-AV: E=Sophos;i="5.75,431,1589212800"; d="scan'208";a="144111947"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
 by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2020 03:09:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDKhv1Za89aTTHJTc4tUu2sWgj2nnQZhOlJ/BM2jGq5jCvF3nDPAkxOIuo+PUwAT8HeDohyuRBEbHJFG1quaJc0GQpQtEy0n9n/5HQ/1s1MQOfZpgDtSBXU0VFrOronXkPXuRKXiSH8N835dxUurXEMcawNUopENHNEoWGFBSxXWeBm4RBNTEybN96qF4DO27kP8Pw2eYZQS5MaPSRXk2rstz0KK8qrMYu3CMHuFyl8ktRc+JAne50ZdQ408EdkbTXfkoC1Uigj8fKMkF5AOzI2haY3yB7f8Am8WdHRmsd5uH/gafCtxmyPA7eRGxzJsr37i2hP/4GMTysJBucYutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc2HGqcllPGRn7NMvlZ8PHb/aPWe9/k1MqmtPcDFsw4=;
 b=Qotxu8daRk6GltHYZ5Gbsbs9122K+lQFD6u0a0WtaXqkcarvJqx92I4EO0A7XHPovFW5IGXbS1fqN7YmBkMq8NBg0KOIxzWZ5hqjRSRKnLIu/XlJxsJgBFOltm1bWBEw2mvT5c4p3KblIg5ueFtEqGlHnj8W+mkbHAn9rbuJrEIH7fTIMmmTc6/fNKLprWLkF3vUZxZhhthUFKZw9209GkJ2d9RUhclv8ybw3OijEjK+GHCy8IHJ0qXEXvR89/krGQgPEA+7eiqL7iE+6wqN+k6I26lrak9JbuRF3sY4ah9dZ+p+MM+PG0GgmnqEyaSwVAusbOcVfEPwJyDtksQI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc2HGqcllPGRn7NMvlZ8PHb/aPWe9/k1MqmtPcDFsw4=;
 b=ekJmcvjGAS6Zo+XAklzGzvfESZ9Og1y/lF2xpVL8YSJOrwa8I85FpW7oGPh0rVpv9cj/27oTpFDiD0ByTpV5Ao5pW7JClPdDSn9pPWUzuzuKOv6Lszmixwdngc7J3tfDjzny7vi9Wo8YUxv8y2W/sTXRICfrtu9gYL+G+3283Ag=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4984.namprd04.prod.outlook.com (2603:10b6:a03:4f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 19:09:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 19:09:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet-passthru: Reject commands with non-sgl flags set
Thread-Topic: [PATCH] nvmet-passthru: Reject commands with non-sgl flags set
Thread-Index: AQHWZdvsD55yoOyrOkWKIunX4pxYqw==
Date: Mon, 3 Aug 2020 19:09:10 +0000
Message-ID: <BYAPR04MB4965818BE01F3098F1E9E6E4864D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200729191009.4485-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b24dd8b1-dea2-43e0-5d7d-08d837e0b427
x-ms-traffictypediagnostic: BYAPR04MB4984:
x-microsoft-antispam-prvs: <BYAPR04MB4984BA4E756D0C44A3998EB6864D0@BYAPR04MB4984.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MBocN9vefVKFYP7/KeWSCvNNK7PcB7aiKgt5c6z+WN1AwaS4zwtbNVCiygO8QSxPdoJD+nJ6XnhpllO4h0OegCH3SBi4PRGRnOQcuSze64+ejZIXuCl5u/QPK9OfD23Oi849kI/glubp0WqNKqTZTh1ndCHVS0dOUZTFDInAvyipLhoWVkb0S0fN3a8Z5FdV9R72XLPLWvELIg8X/bP5vcscPJSCyDs4Z4XEAW4Ud4hm9y+It/asOO8Ec5iFmHNsdnl6Dh7euz4YrQmu/15ZfLLZRVyVGguq0b8c4tG9TQlDVGfWUIE5WpJ9VY10MsCB9p9lseHwyDd1oGnl/f5Vg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(4326008)(316002)(53546011)(7696005)(33656002)(6506007)(54906003)(110136005)(478600001)(86362001)(5660300002)(55016002)(2906002)(71200400001)(26005)(8676002)(9686003)(186003)(76116006)(66946007)(66446008)(8936002)(64756008)(66476007)(52536014)(66556008)(558084003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: b16F8QgCY+xRRkSoa2nt1FYSJ60JnLvX+xyyUHrTMuFqW9BlWcqJgX+NbBt+CyHGxgGAPTCEgZTATSv9jKXpBCfasHvDr1O42e3m+R/7fJG771IVYI6fsKla8184hT1zSWRi8sql2ydZkoCeQUcxRiqaIw9SZYM4klJOvyro2lTpJVVGoTTkMkdeCfqI2tTPY9Gc/Axs5srevoGqc6nWYNVZYt9ANE3+S+CDN3TwkWi9AXVVyQCsylFOtD9bE9n/XF53vRuqUBN6SwfcMWdQGItFDrshibzK38jShc8L2FJkcSQoAQht+o8AacTWj+vV2h8v7EP7Kg7QwPC9p6fjK2P1CVJRuhTZIekRnNbH1Mzh6PWeOiIIrhOIqEZ0dmhAM2/CWr0mB8SmKWQ/ZMMPcmaJ/N6k2zJzOYLke/1fNBGzprzQosz+AjgRT+zvwa8ewy+o9NpnQ4fEaBw9AuM3bJiSr9gUPbZ1XW2s56t9IvWDnYS//zxn5lb4cio7oS6SB8+jO+l/hRG0mGQNQeyZpGPNJpCLTAXf/4GQomZEyT6Yim4xwpX8hbldt+N9H476Cp7LimEoTtv18Miukh9z/UsneUdyBjbPTVXoFVegVDofST93RNyVLVbV+jBPDK53TKBjw2IvAWqgJ5Zgggz6CQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24dd8b1-dea2-43e0-5d7d-08d837e0b427
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 19:09:10.5963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Keappg51iJZ2WwLo0H2XYcHKSyyFFRgeMTgWIjG9XMivpfTbr4qmhtitV6C0YJz6+Uy7P/r4c76odgmR7H6ZlOm5j+4d0gES380xY/4Ptps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4984
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_150919_392461_347F89D0 
X-CRM114-Status: GOOD (  10.56  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/29/20 12:10, Logan Gunthorpe wrote:
> Any command with a non-SGL flag set (like fuse flags) should be
> rejected.
> 
> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
