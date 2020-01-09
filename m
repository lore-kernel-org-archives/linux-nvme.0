Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CDBC32771
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 04:01:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2059206ED
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 04:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N9yRdxAf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z5hRzsPv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g/Uxjdoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2059206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=tCz/FQo9pcGVAtGj4CUlPaNfN+z73vgvZ1ZTKHeuI00=; b=N9yRdxAf1JfW4+
	7CJz1Axo5RURlnXJbybEWCUoZ8y/EiuBQlCl/Bvc9sV1v0HrP+CwZtmgesaYYOGTDjh7xbeLGkGMw
	ejtha63Wf6xuTA4aEyV6BuU8pGXPreS5OrLJPL2YBvCY3eoBk6XY6y47pofZ2xM8DBTDCcTOW1uxy
	5KRKvXmUiTd1quLjPp6LqILYPj4yrX/w3rWQqFFkC0btn3oDfcPxeaY6h7qfg3Dpmn6WUghxNhFQM
	QQQbHppn5T7hQQdLLpXJOP5J3uWKnKozJNrsvqwt4GW5ONB1/lVk+4FO8Wqz0EpSjgQHn05hB3FmF
	qEra6ZS+Q8cRBhegAxnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipP0y-0005eT-Du; Thu, 09 Jan 2020 04:01:44 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipP0u-0005YM-76
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 04:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578542500; x=1610078500;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=q2X9jmwQbWMU27KKRclVafUin1D2CBYuV/1rMw3XHRs=;
 b=Z5hRzsPvVNWelocGW/xGOaZoFX37n8GTfjZ/hPWZAVSV/zSFc75jnkbK
 7J2+UF74tu7lA2njB0O7HJrJqycrxhp+ObcGtQmOIdjq4a15hf4BckoLD
 x0P6IRYVNIUhbwY2HBMfgqm4i2rifmte6ubfarlpSg7/zk7G5ONwYxsr/
 11C9+ZeWvChAPGGlLwIL4pSH5oLAaTo+n8svjMj/rP7Mld7V9kXDXO1eg
 aLItMCyP7q7mlpT3yc8qbQl2J+IBCGKx5wp/iCV+iPJ/DfXjmjinGKbHY
 itFqEqIe7AKD6751qwv7UzZ4KrQr9IZEwUT2n2VFaoKUV9ijo8Cc7uwa8 w==;
IronPort-SDR: iMr6RgvTl9G/66pnBlS7mvHFD+O+vf2JfDLxxn+8xRAF17aPhWChYe+vuvJfCa6BDjn7g5jP8c
 uO0/s9FXp9oKtUocpYx+/WI62gxpb6u6uAJmU5gEf276m4OQcqPvzdoRfzWJWHyCdnVNrZPXoM
 eyJEUDid8CbfxaW3mJ5cpYQ1NzZZeo6SMFQpsDl/RN18VGpq8MvcY+QNiWdjQVO3vfXJVHM9lf
 KQ64PHrui6z6Zlv6Y5aSd0flAdjPDMqbzSJTeApBJtl7abY/5bEXCJsEQqXfxivETw9TXMEqkU
 6wc=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; d="scan'208";a="127742675"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 12:01:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZrGsGti18ug3RhCyIX9vfGPasOWIqY66h5PZfs7I3GB06E4Vg6DBv4fAM396IHFm64mnOuLjC8vqB/xKdoNnmjvZBqJTpEzOBJFqd4lNEP6DDdIXyV8Y0tmrdt/3Kc790eSZBbJCu01LSE/We31UsxTCZO9OuW21A8Q1C0wljlduujW6F5K+EycQop4pINTrByF7ieDaNkJjcyBDLNa0UCuuCJPObXLdRZKk9dP2lu4jTzVFZ+kAovao/rMGQSSdN8phDXIsENxCUPkAj9q2ieZ/QpdI21aEUaSVk19x4+nFMPR2/4/U5XkKo+7R/nrKULgLwdDhjqVLeGajNHKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2X9jmwQbWMU27KKRclVafUin1D2CBYuV/1rMw3XHRs=;
 b=bdDb6KWBpPhstectjcvVh1XRoa4o7BB3VlsxkXmGBSlwPJOjUR0zotQOBU06h6ytmIjED/kW+xv8cIKn/+Tg7r1LqnWnAass8ebtb+tztX2A8d2BFff9h2HuWy13SlOzvOBhdTW5U005/x0VJTIZnzToPKjUzB445teTPr0QndOYsEo6EKpT7JZY3W7enUDlfz362Z+tBRGCcm22rh9amcZLY0iM0RZ9vGOIeB0bhd0GoRPHG0nxjH7hbbz+d9DZByF2a/ZtyWuGehmHEJ0pCH9rySpBF9nRYM923d6RbJ9s/QF55nfKsFVmxImdGTcaRu8mIqFeXH5BZVLiPUM+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2X9jmwQbWMU27KKRclVafUin1D2CBYuV/1rMw3XHRs=;
 b=g/Uxjdoh/ISEHUc+pQC+TOFvpTZAWbsEa7rhYZWLfwy5SmvSEaGuoY1vbSPEn6gFq1gJvBPf8lZQ5qmRdA9/zQNJXD497QU0ICmB9lpo1XbaPQUR/aw3NSXdJpHJ6qWLSmBGe7WzrWTH/vms33JBr++h6bKaWmIgMNtC64cpvUo=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4919.namprd04.prod.outlook.com (52.135.235.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 9 Jan 2020 04:01:31 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2602.016; Thu, 9 Jan 2020
 04:01:31 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHVxYZFlOEpmvYia0KWnm3aEM0giQ==
Date: Thu, 9 Jan 2020 04:01:30 +0000
Message-ID: <BYAPR04MB5749B973CBE3F29822B289C086390@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <BYAPR04MB5749820C322B40C7DBBBCA02863F0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <fda88fd3-2d75-085e-ca15-a29f89c1e781@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb329f34-5929-4495-18d2-08d794b89c35
x-ms-traffictypediagnostic: BYAPR04MB4919:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB49193C14D9E5E4B5AB28151586390@BYAPR04MB4919.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(189003)(199004)(66476007)(76116006)(4326008)(66946007)(52536014)(7416002)(2906002)(8936002)(316002)(55016002)(5660300002)(64756008)(9686003)(66446008)(66556008)(478600001)(86362001)(6506007)(4744005)(110136005)(33656002)(186003)(81156014)(81166006)(966005)(26005)(7696005)(71200400001)(54906003)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4919;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZXksYqzQpQ1M0oemZhFHjRcK6FLR8ejWUuQtqv57mk1/Qp8f3Dr9s7sIcfB8T/WtIxpvRiuE026gPCJcn0xRArqi55k3AwjbnCwhsUO3ojs39OjMd/2pnf2q8Mv7gcKbaadh8QitM0si+yviRXW+D2Fw4CYFr57n+9K+rYb2qSFcbcjSqVIO9uEhYdrMNG4jFRTuXF4ZD7yVtFYIjhM924kEeB8jXN4Xa/N7hcuwDuXWL6FqtrXG6EodbvMjj3HSAmTdiFW2CTcw0O+G0X4OeCj/v4mGn9mn9mZM5gQUCg8EgmO6MVms2RtMROmDEl/TaBCeDaLHttyNncPACDD3y89LNWZQPfc9GVzIKV5/x5AvBwHC0AaMEmJffC3b4fjTM5ZdqC2AD31Wl5015rMOF2D/Jb6P39iEjM2W50CpWf6oH3K/CR1jvqJw65pDHvgtKpJb3sKvUCB9871/DeqP34FA9F/Se8LtHpdOGdLYh8+56GHMauYGJSukX4parpyqeXZeomqFrYdr9HfRhou1w==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb329f34-5929-4495-18d2-08d794b89c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 04:01:30.9854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNqH9GbHs5JjMO7IGspscsFSpoEE1xgP1NC5X2wX7TXnLsLQ1MFh8LDd5Ei6BkQT3IQhDPBTbLvxOLvtPsRb2Xt4DgoMDDx5ixOGCCP3w7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4919
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_200140_446614_B2111BDB 
X-CRM114-Status: UNSURE (   8.38  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>, Stephen Bates <sbates@raithlin.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, "rwheeler@redhat.com" <rwheeler@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 "frederick.knight@netapp.com" <frederick.knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Was this last discussed during the 2018 edition of LSF/MM (see also
> https://www.spinics.net/lists/linux-block/msg24986.html)? Has anyone
> taken notes during that session? I haven't found a report of that
> session in the official proceedings (https://lwn.net/Articles/752509/).
>
> Thanks,
>
> Bart.
>

Thanks for sharing this Bart, this is very helpful.

I've not found any notes on lwn for the session which was held in 2018.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
