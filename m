Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CAFC3567B
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 10:55:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3052080D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 10:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m0eTy/TN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LOVcDR4d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NglzPWXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3052080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=lzFZjVyU/oQVc2Y9mIvxPO/rubhgXJdKO4M0z3Vbwp0=; b=m0eTy/TNlHIXQ2
	d4xFrocZrJo0xAXVJMb8nIv+GwBXpsPJSYvzQlX9H1ywIJwWxYlKF7kQtS0SA5im4D7BwHDgUUqI4
	2+DyUlfvCnqItNspy5UpVS42k5hVJNAQhGqxjCSpBzYYOzsNhExsX5gHvKL5SJBcsHjGQNCvl2Vap
	HsJGhkqrXn8/aR2zbjaMt2DZzwawAA0o8VQ1lYB3x6nTn9FN0I50rSgaJXz/wLGvhoTk6IOiNgDSf
	fSbtMME5HaVfigVenIhRbL3T8CJ5z9j9+biUcxvsW+YiAEaXP+dfMSoh0JxsdkyN9UaHc1j9jtQaz
	YPz+m5LHJB7r1mVDZ8SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6BOb-00079Q-25; Mon, 24 Feb 2020 10:55:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6BOV-00077F-Ab
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 10:55:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582541723; x=1614077723;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nC1a6/cSIvtdc/gsHBTB7x7DDExnR9oMUOhcGr54Ncg=;
 b=LOVcDR4dleTTPAE7obuTs4g4ZJb0DmPVCIx9EtJasvITNSgtbx5voBjo
 3yZ3oHY28TgZIIB+8X2o61xlPKhSu4INHwqtUPe/qTayW9ZXBnGhlJkpk
 g3edvL4iB6GjIvXGmjNET9aMWLZqAnsBX1yF+Ko7WIOSy+WWu6+tO1Xpi
 2OF4iF1mKJts6iLU+4t+d4A1VUp1IDazf84AN8HZu/gPnY3AHy/8XiGRR
 Uj2eUGoi+GPqVk3QavxcuFaSoLLqL68k8+O2geDP8krbbr/LeFGFyT0yH
 G/MoL4GvQpnhxRBLBwbKTmK0diCe7iXuEl64FKGnLsfso0hFN107nyZKD g==;
IronPort-SDR: CbT2iZ/FiSZ1ez9QrDY2apkD2kx4XvEHckGYK0hjBJQBCZ/JqeN24QQbWVhnyQgQwp62NJGfvF
 jWbmQ3v5AWRQP/nx2X6Cg31KCE56f96zZFgumjmzlfdhPdBjxFfG3YXBr3NsT0Jb5tz7MqQoXT
 fyTYjyPbHgMvCAxvgwRfSGNUg+SaTDhdRCmdFuRMIAmbZMoOXnfJCkPGtQkZSbGVJAYiZuH6i+
 P2rZS3gr8LyoJjNKau5e6GmkcdWDca8lzmv2Sr59ZGuHUhDKbbtKmcidknjhywnzD5NO5KwKCj
 DXQ=
X-IronPort-AV: E=Sophos;i="5.70,479,1574092800"; d="scan'208";a="238708632"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
 by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2020 18:55:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZg3noPuFkZoGgyN7eZp3zqj1BdAI5MDla8CxvVXClDSdbHg0eFUVgV95R9HSrCJsb9XsSfBfv3pL4nzwH3F+aQvP51FxVuAbe+HPQFacvjujHXtlT/WR5RL6+LmnB/2AXmkpYt5J9ETLt7hnaalBgLZSyz+W6Fw9zQGyQETsFm1pYF1LMtFzc69bz3QstR6Mh0XimQaf8mc6JRSaUneosAPovGugCUvFgCDlH5umFSaiGKK2Ch9mGk1aTNxdx65viVLIHjxj7kBDCWnLZf0YpbKy/RJTiPZxU7aRi6NSMqw6cMnXqbxISvH8MTUcERyO6fDJrK6WFkjfRQRvpMPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC1a6/cSIvtdc/gsHBTB7x7DDExnR9oMUOhcGr54Ncg=;
 b=MCtcgcqKDt+ZrcFTwPBRlCk8XjK14g2+8BSf8XzOYlHFCDALFqGcVVpR6LEJyb1KrtPA71UxukBzh0sVvrosgyeSWeiDh/+OSikvBCJ0zdg7WG/Wdqjke/Lqklo4+cMLWBNmPeSvpOa/GfsLV5N1VmxsqaRXg/5cuZm0Agv/LMnWCZoHgymzuIyhkHjRmVwaWuHvx7JZeV/TRtlpF5V5qu0DolY5B0jGO6QY6ZfYLvksu3qughZfsdXVnLvLbCsNYXNpwgXt0laKGDzBfqL8aMJiOvDdSuvhZRy1fTX5dEkqWxsn8P98b23TEZyoh0SgMVXzzDJ/812ctJdKBkPQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC1a6/cSIvtdc/gsHBTB7x7DDExnR9oMUOhcGr54Ncg=;
 b=NglzPWXa/O9Q4vWluFgXzTc2aWB1PtZklmNF0lFZWCa9yAwrK4lfHrLQhDsUYH4gLFkB/JAjw/Iwkiwt7Cv7vf3q59kMasKTE4wytT339mXY3udJ+g5EgjdoUEQ6TMR0sG1AVc0qEZVvKNzBMt9RP5GfhOe4J3ywQmS6AZmxOqA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5509.namprd04.prod.outlook.com (2603:10b6:a03:e4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Mon, 24 Feb
 2020 10:55:11 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:55:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v1] nvme-pci: Move enumeration by class to be last in the
 table
Thread-Topic: [PATCH v1] nvme-pci: Move enumeration by class to be last in the
 table
Thread-Index: AQHV6viVOi6fJoYN80eVViOFE2F7hQ==
Date: Mon, 24 Feb 2020 10:55:11 +0000
Message-ID: <BYAPR04MB57492B2B9BDC41C0EC58810886EC0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200224093823.17534-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [71.6.111.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59b66002-16db-4ca0-1b1e-08d7b918052a
x-ms-traffictypediagnostic: BYAPR04MB5509:
x-microsoft-antispam-prvs: <BYAPR04MB55095EC17E74F0DECD42723E86EC0@BYAPR04MB5509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(2906002)(4744005)(5660300002)(52536014)(9686003)(8676002)(4326008)(186003)(86362001)(81156014)(81166006)(316002)(110136005)(8936002)(26005)(6506007)(53546011)(478600001)(71200400001)(55016002)(33656002)(7696005)(66446008)(76116006)(66946007)(64756008)(66476007)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5509;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4JZHKv2ax0+kx0hGmSCdgNEkJxO9wUmfkTURsgaGHzFdwBxqQZksP7/YBSo5aJxzHrl9/E4wTrvwQs/zOGlXdZ/JBtq2ikufuwAsmrPZ4qPsRZMZWyeiRj/lGvgBxikUDckIxm+Q3VVz6ra7A4zvv41Jz4fI3tJVA1d3tf5TL1M2p0MFNq1Ex7jMSTEUrkfmPUxMQ8kxYTfsvjpwb/OWO+hd6mUR59lU+8q1UJxTS3E5P8L/GXaXZMCWlUwf0gqD7EOnPgZ5HRiIolQG2qHxT/0qcru3ehwvgOGfCqOGAAbBRNiOVyFxpwwj/zSBTNVGx9IGqO8WUTZRm/oyO8rbox2Xc/kGE0ysYt3JHwKnJe4E/xk/optxwwLdTkmMZhBmMOuWl1EYAnVyZt54UdBooSamZ0L5xZThW8kl0DAstCxKyZqHGRZ5UTtgjgNzfKY
x-ms-exchange-antispam-messagedata: 2OKr3mg+w7dvILmXNDK7s1Pwqqv7ffVpeNUlpUy/ouIK7xoI2S3CtlgLPQ258OeOYL17wwP1Yf3eM/x40j8Zi/yOViE3BvzPhOIKISpnuJezmI0bTzBVoHp84N8lZW1Y1YrPUEABdlK+/5usmGH6ug==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b66002-16db-4ca0-1b1e-08d7b918052a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 10:55:11.2154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLvXNSR8aINbbhDpTqmmdHX4CEuuris4OlGiEjF7sUW6b26HKoYCJF+fYPngnjcApWg8PH+uxucXlB/Pemcz+7B1gQyLpnFmMpn8zLNohPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_025523_466699_53CDE669 
X-CRM114-Status: GOOD (  10.07  )
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 2/24/20 1:55 AM, Andy Shevchenko wrote:
> It's unusual that we have enumeration by class in the middle of the table.
> It might potentially be problematic in the future if we add another entry
> after it.
>
> So, move class matching entry to be the last in the ID table.
>
> While here, group Apple devices together with an additional comment line.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
