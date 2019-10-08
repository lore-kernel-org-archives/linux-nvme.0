Return-Path: <SRS0=/gup=YB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22553C4360C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 17:27:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD80217D7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 17:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uu/U4GAX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bsX0H5Ax";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FW9g2ECx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD80217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=QqoQMUj6cV2iLwYmNBwRsLfTQeAG7wUAEp5p7w5M6Jw=; b=Uu/U4GAXQJ3724
	SG3xOlcE3y+tBG9POwBUsMI21L6DhuC3XmOG/pla4kAQFAgYNvpvRT+zR+CWf/td5FkO71wJo4733
	TgJlY7DePeH9qhrmtfeVO+M7VfrXpEMDS/dEqvXtj3k16BwD+wz+uhMXv7xAGXIBZZQO/73Q2qqKW
	yRrNyiuQB8P/FizqOen4AYySKTIE2DlJd3kSo4sJVd+awPKlvCkBWNNTIQ2XVGi0kpKmHXiUg9AJl
	a56YMAPbt0Y0RfIVQqiAy1NgZmnBhWvdgWZd9vMe/Jj5Cpyp4rLs6+I5cNKJDmqkKnECLzOIvEFOi
	Vkyuo6uWngnyJ2PQXsKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHtGf-0007NA-00; Tue, 08 Oct 2019 17:27:25 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHtGc-0007M1-OG
 for linux-nvme@lists.infradead.org; Tue, 08 Oct 2019 17:27:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570555642; x=1602091642;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=//pktCntAgSW0HEJzUeBx6PLzhI7ymdVXKWmxe0gYNs=;
 b=bsX0H5AxmCnOJkCTKqEWVok0q1WvR4a6LSX7WN5Euiut81YhXPUXsgck
 WO5ncT0KSEibkbrMsr6EG5pg/hUYrtBcQTwf0o73QMS8LfoOx7wf7pfjH
 +qtjoZtdUXIyYGKUx2vl9T+9Eku2NOxHgG3bpxB83bYkEbuhwvNVGLDLA
 TAXS2VGgzrtlq1QclArmnkZuaaVURvBYrJgg4q32gKouxayIYSxICaQBZ
 dnD3Vdloe7dHzL9CYhOl5QLfCMJh1bNziVkPy0d5PNF6gnWEC9jgKuAbf
 CkZbSXp+Wmqxl46MLkXd2OJ+gfNPWDCfovqJVuFI+O/gL3XOW8d/935Ul A==;
IronPort-SDR: FF6q3M7St6rNr1h3w1Wfajf9wQ31qXeEHpfuTkSfRL8In2jbEK3tuBMteX/jC+XMYlH6cjkAXM
 IXXt/NyDQQoWW0aiGGgj9ScIP8fruRkAjwG6KFt3k3HXeIwsgfFAjvq5JMXaB3G9uQZEXwuzaR
 NUPmfwrP7lUmOXeUgaJbkcfILRCzp0vREv36DCYbol/YZldxq49qrqWicvRrbP5XzkNHQGWK0w
 HuyIN5jndGJ0Tla/LhHGNIAfPz1TQCLE2gsJLEbp6Z0U47/Ih5yg6k0eRCvOvi4eykr5DG2iH8
 WVw=
X-IronPort-AV: E=Sophos;i="5.67,272,1566835200"; d="scan'208";a="227029615"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 01:27:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN17XL+JDGeJ8up12nwmSuthpQQ3WjaYBLq7pdzA3L3WwvwVCgLPSZ3GxweIpt3fuWXsqu7b819OU+xd8xf3YQ4gEkIbWVX7v3WRa6/5rDkg948w5FOlBmNFJjxW3wHmz3yb3gQh4nvuZ4617NITq8jNKpHSWo+sfv2HCC0MD4KLPNVGKx9byV3tNh8RIYjuW31M3WbepK7LH+1LMUM5/V5MCTcdg66BeWxWkf0XYE8hv83lXxdgnkjNXDzzOqyuiGJShfrjFR1nzlhW0/kVYSgLkpKokZ8iUP6Ik4MnW0UMRmOIF787OGESx9P0zSbd2mtHyaH0HnryZ4V8vZR8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//pktCntAgSW0HEJzUeBx6PLzhI7ymdVXKWmxe0gYNs=;
 b=F//r/m1MT6Kkd9bF9/Vt3rZUlqGRx4tEZbnm2546Aj/hWZfF2Z1bJjkriqiJqNEHLHpcRjsZX86Qr7Su9QEyofcLoKqTWXA0Dyd67LpOD/GHG0e+3vv7xvuOyL43moe45Fx09a4o/eLXAs36+5owx+I+0riwU/EZVGeOFXfG8ou37vTQwSfmjb7uTiYU31wxLgJATrtyd/SGhqXF7mHVSMJH8Asph5kiap6P2GQWy1+M6fD+Mqz5MBdH+RddWN9Zhu8zmBx8yU9mPWPDKelOEsmv/Z83SAz8wohfXy2rp+1sYG8N/SXqsLyYYKH5EbPfNFQgC1RIAw6hY86DaSsg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//pktCntAgSW0HEJzUeBx6PLzhI7ymdVXKWmxe0gYNs=;
 b=FW9g2ECx4xpevl9Gtr21fvtAo+7Nluev4SkcWwl4tYMGTJ5efBct5E0IltBCHG+QZeKTw6glANqgmAy71UDx6IGHXO4s74Ps5d0111VMYKHyiIPydoRwsIw9Yg7333pGsA5vvAwX7qPkKeTm1i8x8HkB8/1HXZ+axTIrcgHAdrk=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB6281.namprd04.prod.outlook.com (10.141.161.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Tue, 8 Oct 2019 17:27:19 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::9894:e31d:c666:a0dc]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::9894:e31d:c666:a0dc%7]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 17:27:19 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "m.malygin@yadro.com" <m.malygin@yadro.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v5] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Thread-Topic: [PATCH v5] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Thread-Index: AQHVfdQMPl5F22Bp+U2EfOyGT83GzQ==
Date: Tue, 8 Oct 2019 17:27:19 +0000
Message-ID: <DM6PR04MB57549F74ACFC85AEEF74D36B869A0@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20190926231940.7494-1-m.malygin@yadro.com>
 <20191008122904.20438-1-m.malygin@yadro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e813dca9-8ee3-4ce3-06aa-08d74c14c5b7
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR04MB6281:
x-microsoft-antispam-prvs: <DM6PR04MB628128097383F2AF828B327C869A0@DM6PR04MB6281.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(26005)(486006)(229853002)(9686003)(478600001)(6246003)(8936002)(8676002)(81156014)(81166006)(6436002)(256004)(14444005)(55016002)(25786009)(4744005)(5660300002)(2906002)(52536014)(14454004)(3846002)(6116002)(110136005)(74316002)(305945005)(86362001)(64756008)(33656002)(316002)(66476007)(66446008)(91956017)(102836004)(76116006)(7736002)(71200400001)(71190400001)(66556008)(66946007)(53546011)(99286004)(476003)(446003)(2501003)(66066001)(76176011)(6506007)(186003)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB6281;
 H:DM6PR04MB5754.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BS2D40HNsYOMy1vxygOX6z9nbHvVJtJpiP5BzVIE4YogUf2/+406ZRni+IUi1/vJ8h/X7weqQzqZp4tq0Tsg8eE/8KbT3svprPI2M0ZVh1EsjL7IXj2/d9Wqly4BlbMEvpc3Cu8b8M68cZU6ND87XpMgFmJVXkQQXzkbCOLRyEPHa2EP4G+a1eB0V0MrzBuPtaXTDuWeiLPwnao0GMThbKYJXVlWCZH3s0tZYAgO6hTGBHnA7wfjJrd1ui5HY6g84WlfiDrjvIJVkOIoIEhWHXlfXEtQ/+LQ+hE7PIjw/fzCQnaNBv8PvmE4onWAdipcMzxR/fTJmN/FvWfBE7zhOXU8+zqfUXxQx/1LIkC+LWgisqEkKQIPUYYnUyCc2+M3gNoV1WBkoB/lAdMKK8pNXaL9M3Rb4/Z/sJcTbCs/OUE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e813dca9-8ee3-4ce3-06aa-08d74c14c5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 17:27:19.5568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LXD6JeIXxOVJ7T6CbNlj6RFmNMKvfNz68V6dLreIS2acl4z0Ya9+9blYrrpp7lj51RW6CCs6RvH3A/ZoKlsQ3zUR6ugi0vTF5bx3dVInAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6281
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191008_102722_885269_BA03C2E2 
X-CRM114-Status: UNSURE (   9.42  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks foe this patch Mikhail.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 10/8/19 5:29 AM, m.malygin@yadro.com wrote:
> From: Mikhail Malygin<m.malygin@yadro.com>
> 
> Currently device size is cached in ns->size field on namespace enable, so
> any device size change after that can't bee seen by the initiator.
> This patch adds revalidate namespace attribute. Once it is written,
> target refreshes ns->size property and calls nvmet_ns_changed
> so initiator may perform namespace rescan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
