Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE07C433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 20:06:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D178B221E3
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 20:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IgeaNSMK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eofGC8lP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tG5sx1y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D178B221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=3y8lm7d6RTJPOnTWMi+4jHgnwgyCm6OXJ+DsIWJqoBo=; b=IgeaNSMKVcEAFy4sGbtohxPYZ
	RVfdHPgckKiZnzunIY1uYSzkLneRo2xMu1SmjSFTDXJHlUdgnWcFMRS3BHiud+rEYSU7PtfxgDA6R
	5YU7RwwGQJqcrmxYqbRgYkY/Sa3teLjDVqQlq/jwsbDWbQThW5Bu2Uo9H4EM44++f2fVnggnXlcmR
	2KZc0Ii9bXzTujNzJV9C5LXTyknuKXmBNQ1aE6I3M0fFEsj6nY+pUq3bpApoMfHLls2qC5u47X8R2
	2X/9cdCuHRqtfToH5H1giCY+JXPE5Oi4SexuYsN6zUbCDJrPPYeUu9CQrOubzI/C61lf315MQlNDB
	s5u3IA1kQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3m9l-0004PH-Sv; Thu, 06 Aug 2020 20:06:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3m9i-0004Oe-Qw
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 20:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596744387; x=1628280387;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=yyUGwsv2ggAqwhuBINejoq7t5emvCTTKRxVgYskPCHo=;
 b=eofGC8lPnEmbRUyF/Ix73fXa6FE7deBMJTd/3Fds4mjCi85DWAoi0DeR
 R8ys9ju4Jq9zeUqxurpsCbdrU1T1jYWwwQdMviKptxtr1BYNKcJBKgb6u
 qOfcJ5Jzlxzw5KPfeoNGUAL2ks82kd4ibcyo0E3fm+A82qcttX17A0taB
 OzJq5mHVFdvzybHOODuco9mU8hFuHtuEp58D5xO+yxsRTSKMVpSk1K2e4
 jZ0OOTJ0yGyioktgp3ZYY3ZK4eGP+wg4ekk8624aUvnlMpep06F8y6fZh
 FAdFcnljgYQaI5fq1JRKfFAmdJT0cva9hmyOOVHs9nwswAJw0ne2pDdXe g==;
IronPort-SDR: DCZfc5BdyRP5MUGZQ3VnUnJMTzicWvbeB3UGxubFGflWkGSPcR1mrQxyCFHZBRcIVNVFjkQ5OF
 P3N98+CxqwGs4UBmln63xtwnsFmncWcGgAmxVicDkHb/7lpGcaR0o2keltVjGCLoHGHD0+QOMa
 b2E1zSSaFU472Wnd2wL2iusYKbpkMx+mi6It/sJ74kNj4UOx10oKTp5HmZ3xThzpmpGCY5TZlN
 W/UChd9FVjUrf90X9CLzRqMYkfU8VTHoaAjdYksmTK2gT1HMIG90EXUa9O27499hzIgDJihszm
 y5E=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="144392840"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 04:06:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c23EUfAgMC3FqCrmvyv1wpR2VtB327Z+llrO7HQ41mygduP+LX3mbFeFt2L3/orsWRe2a6Nf3i9W5BfscSrHO2N44h5a/bjuYB5urVjv3cWImJg7TqCAo714oh/7FTLoey/En6AHENERKxXI78xjMt+Np4IP1d20NCP/XI8UgecjdLlWBx/Ldh1Rozr7SFQ1JeAhsb0Se+epKo5B36dzDYlNXuIJP4r/fDqTf1oqwCGycWCtikhPqWXadfh1QzGqcpnFmj3LpxbDJbosiA4t4VMD9vpxEDirfyXFGgX4hO9kO9zPaNarTcc9ptoh2iXiqyS/Z9f/Tp20zy1vgScNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyUGwsv2ggAqwhuBINejoq7t5emvCTTKRxVgYskPCHo=;
 b=fuqbKDBH350ZANiVTppBKIKF/oJo6ql5zL3hcNvqB/egpS7ZTnpe7j2wEqJngU84pUamuQEpYhiaRMmhEG928lDtOfTBQaq9G1v3ozEqk/7m7S800yGfr4/Tb5cd0HrsetB2qz1XxatIx5ZEiKJ/7aTstieD+QNwllye2D6b348JiH2quO1DoeS8cfkgdko/HL8rwQbLCi6klkBnrM8zvJfSLihb6V+TnKV0qARevHXy1V+VQZYTCv+uUsM/kL0vZlL2ryDWgdJAvyLb/pu1yGpiGjnTCMdB6VczX0hGOt/taauAMnPusDmLPkLJgeCrYFBlAAAPKePcq7hby1eFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyUGwsv2ggAqwhuBINejoq7t5emvCTTKRxVgYskPCHo=;
 b=tG5sx1y4wr9T05W0ZqS7Hxrjz7PI2tvEvceiz23ioDcF+Vom+FygMrBFKZU9ZwG8xV42KHB8J6n7CzUiBLRyW2gRqYK3G+mIotls1oi5+ZZkr7g6tlNFNLKOV7JOASXa6aMm4/XUXUdZHIg2K/a5bzTTHzAJgOKz3Zl/PlJvKhM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5830.namprd04.prod.outlook.com (2603:10b6:a03:106::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 6 Aug
 2020 20:06:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 20:06:23 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Logan Gunthorpe <logang@deltatee.com>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa8OqKK/52UoSzkecfpDi4eSGxA==
Date: Thu, 6 Aug 2020 20:06:23 +0000
Message-ID: <BYAPR04MB49654511A18C074A27E6D6C286480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
 <20200806162602.GD3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB49654162034AA3CBA2F4E49B86480@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5dd8cdbf-8864-ecd4-928e-daa74a9cd166@deltatee.com>
 <f6944200-35cb-e38a-b799-92bb4036698e@grimberg.me>
 <dfe9e93f-ceff-d666-c857-a0b7979e0673@deltatee.com>
 <BYAPR04MB496536159E418BA64D034A2986480@BYAPR04MB4965.namprd04.prod.outlook.com>
 <d06c9d7f-cab0-2a3d-aeea-49e203529fcd@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2505294a-599b-4694-8e0c-08d83a443142
x-ms-traffictypediagnostic: BYAPR04MB5830:
x-microsoft-antispam-prvs: <BYAPR04MB5830EBD72A7659EF7DB5347386480@BYAPR04MB5830.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qS0uetH4fpEZIyzb4lQPLwSNTCscKUAguPvPLsC0c6tGtkoJ+nZDmCzJLynQqf0e1NqnYO9V+BVXehNg3eB+Jvq6cw5j5cGkyUbSBvdilzocBNAd+ZDdcjM/cJwz4imB3hkfwEe4F1L6TXKOkRMxLmSr2wmnFlsXUOcAsa4qDv+G6oyNqfjVsj3u7kJPQ34m4+Xed+HAM98Fm81B/TvSRXvfnNfhYArUWXTSAhxe89qHfoefvjeNSAfaH5Le6AI0d6TMEDFwll1QGOXM+gajBRFUd219lbCStWCfpxROeY4wfhDEF2e/wCkzo6xOezdg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(52536014)(4326008)(83380400001)(5660300002)(8676002)(8936002)(558084003)(478600001)(55016002)(26005)(53546011)(6506007)(54906003)(110136005)(2906002)(9686003)(316002)(33656002)(66446008)(64756008)(66556008)(66476007)(86362001)(76116006)(71200400001)(7696005)(66946007)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: q0jqevr+pDmkpN8hwFzGbQNcKFRYpRcT6Y9HMbpAxdUE+Df54eDWglP9AoRb/DQshxQF8SL0fNqTCRkvvN+CYOp5rrRmEtRMOv1qnceQFwTEvwXTFcBXJwUIl8vMpa37OcnLPXc/QVxLWD24VHqLdQ5n6W93shhKDKtN3Inci8AVCcqFKAZP6lpm1t4NceLmogfSuzwB4XzGP06tawfL8BP2LA01fFM0Z2TQg7af0KtThX0dp2P3iCvPStQ4R9cjuuhAuOWgCDe7aGp9tECwTPPAUOIZUWQAP6zIoditZv1dwB6xbQmtWBWU4C2Opc7633HlNsMcxJlL60y5IFvUHC/v/aB5VYAZvSXiM6k+StDJKSjrPAhuSjslnFUjAQYS2BtU7623lZhVDOBBy82B4fzuvYoFnBs1si/aNT9aNzw43ozdo7tUY7QYDPWlxy5z5p34jr2yeCRY2leUQEuQdqzQ0QD2DxGxuauhsO8WaHzMrabSY8ZKhQN/S6IR1MsUFrmjyzrQWLwxU7I9diZN5THnoIsNmpu88yOvcNzLCgOAOdT/CrLRK1MACW1ixAoYvaOJDGRVvC5qSvM6MwOhrjYtrnmoonaeYyIsmGVfIShUdc77Xj/sxskf0cqEmlVeSQYGWKagApiDkvyQCWN5Eg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2505294a-599b-4694-8e0c-08d83a443142
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 20:06:23.0398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElHhr53FlShlS8IXyr+OH7BYsu/+MkkvNUIm2I17g6bbRysfQvR1VHxUeNthoBZgVSaxvaHHkoGOQKMZMsJ507Q489rLzuptk+MuMZf61Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5830
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_160627_093236_B3DA6630 
X-CRM114-Status: GOOD (  10.43  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 1:03 PM, Sagi Grimberg wrote:
>>> No, because the ns is only conditionally allocated if the queue-id is
>>> non-zero.
>>>
>> but ns == NULL?
> Logan is right, you have the admin queue condition...
> 
Let me send V2 it is easier to discuss on the code than text.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
