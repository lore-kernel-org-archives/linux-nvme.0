Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E5C35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:17:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F360F20708
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IO56gos8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GqJzWdEN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wWo1xWcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F360F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=dAQL7mE1wSlq1XRd31wX5ktNyNjfKqI7UEs8jpBkoZw=; b=IO56gos81LERSs
	Y1tprRU5jR6Bs4fKN1n4GbIWQnYA+jzkUw+auE0706uTdMT1QyZiqLcPX8gFl2nvezrMuIvUkjlOw
	F09PSCK3pHz+R5ejypPyfAdDzeOxZUc7ftx0p5l/DEE2S4O9eo+hVWW2vQJ+AVGB7r0CsQJ/mrYvZ
	awlGHm7sOyrTxcqGsoEXjIHi48fU+QRNDRiHxUFE1Z8c7o57No1jVYrFSquBl9uBqox/KAjYyZY/x
	71hXtlQroe9B5ka9IxmQxPjSRzDmS6mXgL//4hkyFojEWHU95/xai7HS7OxQmeERDxCV81mDJZ21u
	MAJnXUAGtGqotMaDjIEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1dqN-0005Ae-QN; Tue, 11 Feb 2020 22:17:23 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1dqK-00059r-Av
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 22:17:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581459440; x=1612995440;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=us8Fs+Jbr789hYVgiRSn3RxSG01UhDHrMRqqrgnX/8E=;
 b=GqJzWdENDbMLJNR/cU7pkplUQeP6dFZ5kgYKkxbcmgxjfwNfEohx+cxg
 lY274U2lLyeLMM+y+sPdizIU1kLgHpNfvKKJR4PqJUOelrYFjVLMsdCJY
 dnM58g8mdBS/fEV6kJ+treVJXKy0k2wb7opGmsfP5EWzFaFS8kG6bNXyF
 ZkKa1kf7gIznaSt8/Tpqyxsyob0r62RgeF/I/cX6BZJ3zKMMSKhLdrbIR
 y7s8kJjhNJKGkQZV3NY5OirkIrC7GgdjCVq5wOZ8N/OTEzEtqighkvFOQ
 ++hbi+TJV0w/Y/JwwSZ2haoYGLx9sTSJoZQ/ZvxmS2p3DuwsJa8pesiRc g==;
IronPort-SDR: IeaIsl4BChmnhGhJT/7OqH/lRaWti/kZUNVFA/m9fc9aXEwIFazf5aLkvTcOrhV6nKLc3ToAeQ
 pcLufAfBbNUqyZpaZBIcf5ApSORgMHEr4lnrGDKdlEEQgHnS6d7GiBjILJ/v/uNz/0Ai+FB88G
 9b/05qycaCPpFUc5vU4QgwGA2dL6UsRPnJjYqN3wPlhgRZfs3Kjaz+5UpoYwk9epqsnNUYQdAU
 0OlKjt+ftnLPD5Vf1BbpMYb2wAjmMrAD7gQ6l6dQvGASE5zwwLgCTeNpS7CQr7S3DNGAe4Ac9k
 h0Y=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; d="scan'208";a="237637224"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 06:17:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTgACcXQBPEWd8nfGKKthHDdu8meL5yxYnbjK94pozdBhKIIRsfpZOP8EkuB1SjYzAM8/FEsQHEpA515spEjrhZKRQ6d0+PPMT07CsKhY+JijJAMkQUaZTBlctp7TJYEl9xPi6Pwr8J10RDo7OZA/i0sBdtSMLEZERzCWvSbBenFsrkD3wP4bYqkT7N5ZF8nJpC5ue4vpabxmp2d3G5ZlBAmsavIQm9o3u20mcMDOrVdP8UwnclDb19qjl1paRH68b9K6qrZ3EtpyJ/HcODk/Q8O2S6xsOCYbbO5zl6Ng2UnRZNutZyTwF7NagjwtHJPunbJl3gkhRNDW3LyYK/uqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us8Fs+Jbr789hYVgiRSn3RxSG01UhDHrMRqqrgnX/8E=;
 b=ejak5dJBZqsB0AyXRhI3YDXTHzFf/pKCt1boytPlEmmNcsxz2p9q6y81lMFEYHjW4v5PLIOLVe8VHXRlMd7sDRQwaq0STgh06+ucXwftGtZlk8V5+SI0/wkKlpFrpCcMSujU72tXowX31gV/nm28rvPfUlrJz5OzTw4bR2CZa8cJwy3JX0pHy52AiUutFhXb48s1kSovNJTLPnLWr50lAEdW7VlZo4T5swy1pVBWZZTqEjaUXQSGsCGHK4XgxA4PW7WhQHIrT0LVghdgLYbK+O9JlaoboBMiyNdKMwmG31FCE6cfUoP6aGARyiaohqW94UY/UZOhWiH0jw6UGe5RXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us8Fs+Jbr789hYVgiRSn3RxSG01UhDHrMRqqrgnX/8E=;
 b=wWo1xWcYoOskot+TvAURptj+vUtPXWNJC4FFI9OUD6GOuzGG627OOjN2vANkYgRTsYKMqeEbriqI7CnbT5UUlyC5HcvgOjU5XMuSSqTK6zpXtKLRMNJMt35dWWzlAhmPClHEjKSOxVfvqKhUx5MCK661H5GmLVeSgm6NjvLmTmE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4325.namprd04.prod.outlook.com (20.176.251.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Tue, 11 Feb 2020 22:17:07 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 22:17:07 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Topic: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Index: AQHV1vvxPjad+7sLRk2UwG5mK03ccA==
Date: Tue, 11 Feb 2020 22:17:06 +0000
Message-ID: <BYAPR04MB5749DE1BE6291610DB2B8BA986180@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB5749FE36341AB61547C1218A86000@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB574971DCB7CF63F7A4A269B886180@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20200211220728.GG100751@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 363cfe58-e301-406a-4e4c-08d7af402183
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB43257208DCAEB96CA9F5043586180@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(64756008)(2906002)(66446008)(558084003)(478600001)(66556008)(76116006)(53546011)(66476007)(55016002)(9686003)(6506007)(33656002)(186003)(7696005)(4326008)(8676002)(71200400001)(6916009)(5660300002)(52536014)(54906003)(66946007)(81166006)(86362001)(81156014)(316002)(26005)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4325;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIRoIsFgjqce7fZUNFPL9nBTpb5YFm5jbD9+cN1saHLqOX9zp0K3PB9kYzR58FzqNWPESm1LFnvTXEFtSf9CPUUieiI5MiDRxhSWzU0oG+r5xB2VjE9WVWp+gAwNX5wASo8Qmm7+coGf4I0qFYTHYLo/9OIqZVkBy788sTKcdDwaXUECXYQSgJAtidQiw6gL6WSgttiYbl1UQ4TOmmWRA80Ae9sf0ZWlC1BlHbegSHU+tX2cfgIsWGQ2gE+CcCsooKDb3EmlTh6czlji+IIK4uBZ6DcVWnYKpS/HWHXiSQgZuokI4zU66IgwW/SWyxuwaGf+GvcX/0i32YNjKOiwF6f7q9eqLn6rToX/CJY+E/Oy+z3RyxhYc8oFRU4eoj05u/BCpt5pS2IjF6Kh9z/mzBjNiFhqxPhGFuith/Mim6cwy1aGRt39Nw/NqilrHc0j
x-ms-exchange-antispam-messagedata: vTnq2GbNrMSvguukm4NT/KAhjyWoiYDQpKJaZGaWDLb8wZwvc22Wo1o0NE01EY589IfceXyy0f7r/tYPLcmg/a+z7NcCu1rXZ4Rx6gyitav0jUPE3m7Fnm7tgdYTHNh8XHCySXeN5EMhHKsKgAyGWg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363cfe58-e301-406a-4e4c-08d7af402183
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 22:17:06.9786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtjeJoCW4AkFbVBcXLjdNiJY3ACMxfuW77yOL2R8qoydmzMdYZg1+TCN8eqEXrbhRuhDb2TpEsi3cv9tDDjnvc7dtvM7qiBHmTPW3bka7ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_141720_597184_955E987D 
X-CRM114-Status: UNSURE (   7.46  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/11/2020 02:07 PM, Omar Sandoval wrote:
> Whoops sorry, these don't match my email filter that looks for "PATCH
> blktests" so I missed them. (You can make git do that for you with git
> format-patch --subject-prefix="PATCH blktests", by the way.)

Okay, by bad, missed the PATCH before blktests.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
