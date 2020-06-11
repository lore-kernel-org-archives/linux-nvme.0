Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FA8C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 23:05:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0DB2073E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 23:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UJ0aVcwl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yj++qweG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ato6cxzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0DB2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=VTOebvU2uftmxWtMJswzOwt6HwvdL5N9YKxGGwnfXws=; b=UJ0aVcwl9UkMfa
	4HHc6Gpf0TcPmy1xSWncg+9quCmOsWehG2YZcG7uDiByd9/BKy+2jclUDdmBFTZ/sARdCLvmlfolm
	V7EU3VW6ADh+Wvd54DSb5lNzZVBTTtgPXgr4RAHrXQMUSfgYatIZQiz1z2/0rodDXBSxYtDRFLXFX
	vcPc3caws5NmLEt0bY3F5l9ej1By0hhRSPx83byvTAm1PWpk1UgfIE9v1EBMloAj9KMsEkYtscz3m
	x8Gchi8Z+urKbvTsocMMOgIBw5A+RYa1WNAjZa/hkmYHET3Nw8akurJs3/930MO3VmJpuyxHJ52lS
	VYhSvRHI0ej6t81af3Sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjWG2-0002zR-KZ; Thu, 11 Jun 2020 23:05:14 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjWFz-0002wH-4n
 for linux-nvme@lists.infradead.org; Thu, 11 Jun 2020 23:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591916710; x=1623452710;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5NSSS5OYKD75a2jmgPuQhfeyILwuzT7FG6sNb8gUh/Y=;
 b=Yj++qweGxjhI1oX9SMwthM/QRw3iDEycgzoShpgeqxP1uKH/0KEiZE21
 xxVW+2sIITxmuOTpFfpDHr39GmUfn5MleEF/Q7TtNUuvu/oavAlyBO9Ba
 KZddZJCVFjDeKo13//xU634xGZ/W6HxLz1egz/c3HwUqYDInMB0XYn3pc
 YwrI7W0hK7VEm6xXe6hgOdCm25KaM07JRNw16vFCN8lF41AHTnGsYZ19h
 riZDIJp65mQQpRDocLKv8f/v+kjK3I5qIB0RqOw/uKqXYCFlfqDBrHIj6
 rFD2OScjTmbz7EmZ8Ve5+2WQfynJ5BoKyUy/6Zgokn0r5pu0vs78PYj4n A==;
IronPort-SDR: Ocg6cNyOsYz0soUx6AXVncDrLOaaf/71oPRehPBqIZUT8H2GZBz9etPkluNb8nwKyLu/oHzT1i
 hEPVVofZtmt5Q42cJPh9w8RAYBfkZh0X1Bduioll3qCkFsLxfmfOZFn8cKzSD5sI/bg75pxDDM
 NcM//OPMJRAYinCgdNkpXyTpFTWyZFFj70cEXaayw8jnIsYtkWzhsfRc2tn644ymPWDfsVaWVs
 cdWMllK6vld5FCcmUuAfaAyXfdF1TAqymOt7NwYHw6LUBJFG99b9YIFhLFtJSlzFg5L11BfUi4
 sH0=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; d="scan'208";a="139773911"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 07:05:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC3gdm3fVT1aXfzCm0ET5hTK7clSQiaampH13SLeRjiw8/AdsBZoSln+xWi1O0PPFLow7X8aoKd8PLmEBuiNseVApnFq0spiAUwauXpoJv2DjbsEMr4Y9HN8lc0z7QzzllEgZ+IkyVhd8Uc9Lmv8IREJ8LJAUs3LDiJBo8liZidSPi5UD3B6+VLI0gg1Wbnum2tdZ02p9AdRR0L+Pj0f5Fiurm1/t0biYx7qCE/AnQyqo2qNda/0qTjV6RBxSYxjJZSW2UCabCsO+lRB0V3965jxwe/oYY1msyFzFVCiJlGw5xbFkjEpApSW9BHQXJoggYlp63qJSHL14Kzjc2f1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//fcDfVpKjFIFo4e6cljqzryDmbUe4fMgA9b012+wMw=;
 b=foQtM12mfE71N62Jjivv90S1I7qY+fAkf9j8z73qknq0E0qahtcG305u+Lja6eEJQHXdWY4GDGUrAim06lsARoQjCne2IfaXmWbRE90646kO2qIEp1Z06O73Z5HSykQkFT67llwEbM4eOxdfGCWqL6whpxRpOxuYtg5IsDK5hEgslE1i+RmO4q/n+vm7I6YvzeIdySSsfefyrL8ar3z+Z9+d71gROy098ocag0Fl0l2VN+eiGxtJMt0nAsFEhofWIxOyR/lbLdmzQyHe9mzvnPMyQD6ztPSwAtpETdY89g8bs/fgZo4cuUEmBV8Kzyk50fuhalizg9wUYJuh5cotbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//fcDfVpKjFIFo4e6cljqzryDmbUe4fMgA9b012+wMw=;
 b=ato6cxzYty1X25ZFV5OLHA6PCZufPCkVznUPJZ6hpR+SNF845Kj2X/o6Wk6ZLpNk7vljVgiOMlBxdD6UlZrdRiyiSa3/wP2vl41taOgcS67rXfOSpP7Q71U+4It0eZl8ew7zIZtzmewqb6qXNNw85NTXopekFuw5/PdrGD9q/TA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3960.namprd04.prod.outlook.com (2603:10b6:a02:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 23:05:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 23:05:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v13 8/9] nvmet-passthru: Add enable/disable helpers
Thread-Topic: [PATCH v13 8/9] nvmet-passthru: Add enable/disable helpers
Thread-Index: AQHWKhRr7Wm2MqUdeUmSLdzKIjdSIQ==
Date: Thu, 11 Jun 2020 23:05:06 +0000
Message-ID: <BYAPR04MB4965E830CF6FDEE90FBC950B86800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-9-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b52d9fb2-ef97-44fb-b691-08d80e5be205
x-ms-traffictypediagnostic: BYAPR04MB3960:
x-microsoft-antispam-prvs: <BYAPR04MB396025BF6292680E0FD5927986800@BYAPR04MB3960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NBnpLdEzeR1zr05l7anpYdlgcsLWMsucjsu7fcpX7u1QdjTXWtX7aWfq9VOP9ApNc5mXYWHTb/5XqLB9F+xkJBDu9m/xPvc63QohNL844GMwfz+83P6w/V1iQ0gfh20/CpecBmSiQy9+Db3ybQHl9w3etizF+3Yl12/ViAA9EWVtgGWCdwZk+vNyvDYcGBhokf11GTha9yduPZQgV+3X8BUlR2aheYMgE22yowamjQjFsIsstiw7kml5P1qBN7vLyk39DjKmBS7GUlcW4e75STGl5uzzuK5js8TcZ3x6L6MhycDGMQd6gtUCM5lIXaRX2qQveAujIj+jAtPZJpDfdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(110136005)(54906003)(316002)(52536014)(8936002)(71200400001)(8676002)(478600001)(66946007)(66476007)(9686003)(64756008)(66556008)(66446008)(83380400001)(186003)(53546011)(86362001)(76116006)(6506007)(26005)(7696005)(2906002)(4744005)(55016002)(4326008)(33656002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: cEZlve9qTqDB/NvAjgWp9vbrHXqL/2o+2CyF66kn4L5VSvK9YsQlyOE1I1SnppsTbgd6rOMai6xJ6kGZcW8p13s+o62h6A+04x/3VL/0yLODPQhZMkdLs7j8jELYemxzV8IEVSHVEP+eG7fKXiGruFs54If5gkKev4LwL19yIo+04sHM81U/o0bQfvzOoRuWGlfEpH2bLOkOxWx7+q5IkeUFBg2mrSGa69R88xLJQMSVaD1ZgWI8VsqAf/mD12xzAmUNy0r07v3rcS+/KwUIZOt41rwrqlv6M5kErh2zQ7tJFxMSBgJFNA3vzd1uMsbxlniEN4UfZyCUeJEPqkLSoR7p8ujdplCigOztfDXutH5qIGpGZErqB1qWuzbiUMoj7waMN6elsEfw+mfgfUYtfNO8Rwqwxv/I/7Vnha7gEH4FPD6Bl8sGyt8xmFbE4TKZZTCq/x28d6H/LU4Pa/mn5y4B98ShA0w59ma8gOUAxlc=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52d9fb2-ef97-44fb-b691-08d80e5be205
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 23:05:06.8913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbQe6INocOnzBf1KJMTCkcTw4ueQ20gT2veaV0kxbEJpDmnuKM7Ca1AJcUm+APYP1LnW4vqJIeh1qADUZY9JkySkk7smDxD1o+bP9ARDWQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3960
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200611_160511_258390_F2EDC247 
X-CRM114-Status: UNSURE (   9.16  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
> +	if (subsys->nr_namespaces) {
> +		pr_info("cannot enable both passthru and regular namespaces for a single subsystem");

Let's try and keep the error message witin 80 char per line or split the
message into two pr_info() calls,how about this ?


pr_info("cannot enable passthru & regular namespaces\n")


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
