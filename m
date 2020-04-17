Return-Path: <SRS0=M1Vv=6B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F34FC2D0EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2020 19:25:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D922078E
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2020 19:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e4MxDZZD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q+3HyVVN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xl9ezzRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D922078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xD/NkF4uL3b5QaNxMbACJqvumNMQmdZ96G9m0L6Kgpc=; b=e4MxDZZDybk8sL
	MaNwhMJ7GktlFtKcb4wJMHatCkpb7ehTWeRFlgdRCVqvluPbXQiIwEaEcXGcrXfeUit+mRiK3J6sg
	M3lmJgH6xfTPI8lmkVL6q/evmsRrNB0732hTsy4XZ69siI0KUfJ7ICzUrY8ozYVe9qgOHHVijr65/
	jZwpYo/cERO6z12nkirI2cj3+IMh7Oz1TGaykJfLIzu63DLNs8sAdkYkxWIwPd3yJUAzXAUTyL5zu
	yLtAn17qqEsVbqMOBkFdNZcuGWA53ZIellzMYCf2+XtM8ezsmJgAGyYBflec0yPPZgKTN0j9h3EBF
	u0ArqAhlae5nqNa/ZIlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPWc8-0007IX-3K; Fri, 17 Apr 2020 19:25:24 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jPWc4-0007H0-Tg
 for linux-nvme@lists.infradead.org; Fri, 17 Apr 2020 19:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587151556; x=1618687556;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ufpqaUu80owrFV9l8wknfkLbk4Ty++tv/FRQbr1850M=;
 b=Q+3HyVVNYAPbed0BefGxpb6IbbflOHvRh8JAINXN6CfNQ106xDZvDgNZ
 Azi4dX64w6nYX3UMKsYDWdY8GAgZpCY+KskXOEVL087Ney9spjG35Hpwu
 6KylCXenR4d96kyQd2w03UPbaZgasG7Zmn3WnH+Jqk+L6eENecjMGTVfM
 wuQ+QW/bG4GSZ/7W0WpLLkMANtrHL2rhT3QMSSSAsTKIQ06YdlPCFAVDC
 +5Pahr9GP0a7vLFpU3nT5Srd3RZqTehufsgiv2w2vOHnrDWGkwiAx159/
 /DfQBNKijA+ngXgdOC9F8k+gatPNbe/pxDv/MEl4SSus6KT9jLNowqnVD w==;
IronPort-SDR: 0+4LEr+6HIa6KC8OnRsamjboZ6LkYMaXEXHcAeeBL/OXx9S0rk6+bKZCAkTjvZ4qRvdivXGAzL
 QWLBC/yihuW5aBFq7pr/GtJo7TGzxyQTZh2/V2REQUy7kSzwFOPD9VMYVQuojBtZyZC8D6FuTg
 U9EKVm/Q5qbzfTilHOLTpx657TYyUslshvLzM3EL4HbucptumPhMIdmBzH9we77Yt/OsI1cCdW
 xRvAoP/d57Vts2Ze9C476v7Q8118BM41pmJCldar1SqX2DCL1mUdN8QsBOkQ4WLEztcLbHEmvh
 jrs=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; d="scan'208";a="238017268"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
 by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 03:25:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFgFRzQg4QVRVoQqjbe2x18bLQlISEdK+l8z5pz4Snagpuszcfdbwh21OL01S0t0L9uKuXUwdBl+qZDSNIHVbobq+MF44gww/imo6pjt3M+vII1MIJGfztXSzmfIIworHny4RzbcD/66A7v/iuRl8a8Oyz8mIw0ajI9yd9JAebotCTMP8fGFLhCUc6Nj6bTJeyjcfXSTltBPVH9de65fVyhqrHDXD+pXC+jIIEwB2gTgyG/mjJ6IMSUT8ziCkikxDzNDWyAoIP2HPi24ZIMR91uyDSLQQaCDWDeZZIPuv653WBwyBWTMGC35GaFdfjRTj72EYgmMg37EioiEZIhepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX9YePprWTQYlv/6GZ3B/cWoCYUFYBkLVbWfsIW7G7E=;
 b=ApeKY0mtWfDjyt43tFxIOk0T2ed1Gez19O0i4LXM+Ujk6kH1Fe+wTB+RuZ6S+8V0ZiL+pSb/RP5UKuI4ztrQWIUF+w6uQQ4l6rFJROYNIdpreuVYLc5U6yqVhtZmYagq/3+NN88NQ77QiTVqXJyTCOymeP2qe4Un1mP+Z/AyTjFFMIp8PXz8UbgBtZDksZtacggIDQLTHZZY3H8TgEer/5etRQFjuK/WsbSt6MW2C68sLvxKxA/wt/FUvjwleXlkr2zgX5tDw+7N4PLHg8q4GKa3TC9taqTL4Q0bYqtcachmVR01/npAnADe8iMe9BSqE8nFtuhJwK0E8rTmVcUdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX9YePprWTQYlv/6GZ3B/cWoCYUFYBkLVbWfsIW7G7E=;
 b=xl9ezzRKRz3X+uqzI7Ix67lnQ2IfPNQA8YUewUTBRUmk+i85f/g5kKFCgKKhhRe1VXbj/ewYBGheX9nbkp2w1euTMNMtTm/alifECjgoto0W/aEwWpirEoh29jp+12PXqMipDMGGfIwwPUPyFQSFwnV0UzqSqnCzrncA5rkYXTk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5509.namprd04.prod.outlook.com (2603:10b6:a03:e4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Fri, 17 Apr
 2020 19:25:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 19:25:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
 <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme/pci: Use Discard instead of Write Zeroes on SK hynix
 SC300
Thread-Topic: [PATCH] nvme/pci: Use Discard instead of Write Zeroes on SK
 hynix SC300
Thread-Index: AQHWFJNgC1T1D2C2k0C8UtF2YjQiRQ==
Date: Fri, 17 Apr 2020 19:25:06 +0000
Message-ID: <BYAPR04MB49658C7772879D7BA5A6E62D86D90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f25680c-08ac-4750-2968-08d7e305097f
x-ms-traffictypediagnostic: BYAPR04MB5509:
x-microsoft-antispam-prvs: <BYAPR04MB5509222E11B2B4E6EECAF49B86D90@BYAPR04MB5509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:191;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(4744005)(71200400001)(316002)(478600001)(110136005)(186003)(66556008)(55016002)(64756008)(9686003)(66446008)(54906003)(66476007)(5660300002)(6506007)(76116006)(7696005)(2906002)(33656002)(8936002)(4326008)(53546011)(66946007)(26005)(86362001)(8676002)(52536014)(81156014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RN4K6LsRJ6uUE31Wg2sMfCJz2u2FjqiHfbW8PK+vxhGxjprOI1QpSQDrAe0GZAT6OWLM8bo7piC/TlDmpPEOkv32uHIQI0aZGcknIAqQrPJNGDUtA2eM+yterus/M/a+xFOC00T/4NcvZ4/6Stn2EL+CmI8bRUGjFk/qwWr4Ms0FRv+NuRkXw253Y5kkOr41suqpKSHqa6xQpEZW0u82BmlkBwuCL2piTEB+3fftaI/eINRTbhHeTvncFe2W9QYcj/vzxkZAk9HokzX5jr1JzqujeGeSGSxK+8eVT1tgHmh2PZLhbe7yIlUIyuLuvhId1YchE9phQUq2GuedlZUPlJpe8t4mzKtcNdZjIvsc9dEwLMugtL9lK7RRZ72neHtWozGDx3+SqeUc4gzeBCn2GLYkRO5V66FIniXyf7oxQgcrItQN0HbTkn5SYe5rbp68
x-ms-exchange-antispam-messagedata: 2zlhnafUsPIRsFz7e8G9OsEN6VYLJCWfLBZzxQdzhjIqEh+L/2oY9U+1H72Rpt7kqW0IPHlk2amrGZg50e3juuoXRGDBmNkB9+d3nUlDyMSo4foA2lkFu5jiG5jyXUEHJ79RfAslLMilu6r8AZJJYA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f25680c-08ac-4750-2968-08d7e305097f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 19:25:06.8465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9Z1Kwr7dNOv+6ar0iiH+mDpdGwu2iP1JSWDm89FmfX2pXDdDed7f8NN4dIX3FRX41u8FlQGNFYh0HVHk/hi8aNnfzZ2bZq952r5lwzRqTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200417_122521_113295_88C4C4E3 
X-CRM114-Status: UNSURE (   8.60  )
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
Cc: linux-stable <stable@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/17/2020 01:37 AM, Kai-Heng Feng wrote:
> After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
> command"), SK hynix SC300 becomes very slow with the following error
> message:
> [  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]
>
> Use quirk NVME_QUIRK_DEALLOCATE_ZEROES to workaround this issue.
Can you share
nvme id-ctrl -H /dev/nvme0 | grep oncs -A 8
output?


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
