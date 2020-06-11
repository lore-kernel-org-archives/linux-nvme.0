Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2201DC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 23:02:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BB52075F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 23:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EW2symjc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cbUsIRFA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hetV+ATt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BB52075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=+ofGJydZ5XN0S94iJCX+0MZPKkosJNdpQGW4k17SSW8=; b=EW2symjc1eaZdI
	1uZ9ALUcf+Z8lu3ifPi8YdALSGgu/irq8cPVbBm5FDqsHCeiI7/NhwC13wV2z/8DWqQdke3FshO+i
	noj4q/v6wGfW6zAKKiaqfdJnQfYkFv819Hb39pHyPnQQM3q8bsjLj/Zqf4fYIOtMtqHWKqPIajfQ0
	YsUKe2SqkSvMTxobOsJFT9Cq63jV/HaDYM3eQSrEIwWx/1bQ2A263xFcOqQg3zNnKha7xVW/kXjyv
	mw8/54mIvAqHsr7BX8dVn7Osm9fELLb9gErunwAoFHAh5wJapHnGQYXDRRHGxq8E7Cpwy2xJes3bi
	VUU+Z9WHfTJPt/1CLWWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjWDk-0008Un-Tt; Thu, 11 Jun 2020 23:02:52 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjWDi-0008T9-Dd
 for linux-nvme@lists.infradead.org; Thu, 11 Jun 2020 23:02:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591916571; x=1623452571;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=LusZqFmV/LpCzdobhiRgOtpG2WvPIWVHQrbj6u2mvu8=;
 b=cbUsIRFA8uMAgatVWPAR1RNU8NrCUcrZhH/Aaz7Vx1IojlRkT0h7jx+k
 +6XnywICi+NTl7odcFafr+jhrmqzq46y22t8cbnHFdZAmtJJfYcVNWpi+
 i8fooExRHtZ4zCytcg+P6bXqefzJpeIAC+PmyrTTOCxJJW3J3ZA7taDFz
 0oN+HLJ9yZFiwAjCRgPE4xBPGGkDgm/h/iO+kk2VXz14WQ9ukR0U7Ov6k
 ou5XRlT+2tP1A5MQzTu8WsbHtPS3vpuxuUTdoDkBD0jIV70Vl35nQOqNY
 cUqvkqPlmkX91bseM1nNtkcVGUxdGSQRNmBsvIKI8QWsgUeZ9nU1XT9He g==;
IronPort-SDR: sGS50NpzUgo0UkRzy15PtSwTtxwXulYs5yrqNvAf/CGPlciVVpiWoMcS0IiVR4xGc1Wg2L2Pmw
 g5YvrP0QF0m1JUY168oIIQXrKgEB7teE6UgGWbEutZ4S/3uNHTWR2raOJjchmNzqCaHw+Q7kQm
 dw7jVg4tOnfQmJFdZD4EZag7JE/VkcT1HwKqadUBSoIwIH26JCT358myJb/0QoP6wGxiLCKdU8
 MAguuvwmFgAx09hhRxdG4ogJBCLDTZ3aK+da5IVDfOP3eA4//ZmV7qpxMxYQBqC1/8yX0S/9Ec
 RNI=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; d="scan'208";a="140060735"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 07:02:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daLeeEDYp9rGgFJrGxr5nHfxdsDIbMlHgFpsvcafQHLC9Vdhbt4v9yid9ry9mxWCI65B+0vMs0tGWPno2jEMK6Eg5duzKESFXUb/Cp9ZMX/ykIhsNy89lZWmFU+rKW12CgPMnmWWpR0WHP+b+uSESs94AFcwQfB3CVSC93zK3jI9ypyu0FaLvIjpTUHb1NoNcHW6e2/GERmFKMB2pZfjo+1rsW+71t2J+t5hzGPboAeWRZVPZ89SkR33bByebJhOAOxdswuVifRlSV9VzFEFZ6ttRb7TpMHqAtZm2y8r/+bTlGQdQNg3FBxs9yPN+YCc2ZHPdZ4AFJCpAnM8pXpfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+6jevJ/vKvmtJBAqThT1cHgma+N9JhysefUG7fp5hU=;
 b=erWSJNeMMPERSx03K7Bb1r5W5VH5vsYTZW990TJjAEikIi893mxTcxzoMQMAFur1SFqO9TZgHUXUpZ7+CYvC9JOP7kRCtOx9PYMqIHpAWfUQ6ZXBsj5PiSybDAVRlHY1JCoK3eDfOinYxdi6rR3daSzoo9v5b+pP/Ndp99YE5jmZvMm2y2Vq8uVXeAP5aM/GYtBmbSGg72sIfoXGy3kbeQar+wy1PvG+Wu7+2jMZ1KJfTW/krL16NAoA6yFu/F/UFinYIbLRl+La0TGAkrM7PW15g5cvUjDC4Brlk0kOvgBI4gBQdltnWcCdyHkgQBf5urObcaRH3juTAPG8jhU+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+6jevJ/vKvmtJBAqThT1cHgma+N9JhysefUG7fp5hU=;
 b=hetV+ATtBw4gFAfqRBxqXtbbWqvSKuPE/p40YvBuvqyYWjBL7PnyeOZ+nb4uJaEvTwVJ28YrPtblGBrUq6LIrqtyAJ8rsmniAw2TcGEaYAW6UaINPCZQDrCJSKo+mMtDxkWusAaHavkKGeFCYZqcYWRSjOqzuBPXVw162uZ6e8o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 23:02:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 23:02:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v13 5/9] nvme-core: Introduce nvme_ctrl_get_by_path()
Thread-Topic: [PATCH v13 5/9] nvme-core: Introduce nvme_ctrl_get_by_path()
Thread-Index: AQHWKhRelu9zAfZ7mkO3HQPKQV1k0A==
Date: Thu, 11 Jun 2020 23:02:40 +0000
Message-ID: <BYAPR04MB4965AE69900A7832EEC4141086800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-6-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c3cc345-a943-45bc-cd83-08d80e5b8a9e
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB6884774CF575FAFD7E1C18D786800@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zx0FW1GkV43zh/GobF7fNmLLjUzfmXMVENWm4Z3atiT32EqXsifeX6LFcUQkAr4N473PVLlTqT9rJcP63boAliG3PlGuQIkW70SOxRUZwdn/wexPY36J1NTkhSvjwW+sD5bZD1XSB7MrlvhBzN5MuVIhdT8P6WA9iCxr44WF8J7XW8vuod9o77E8y1TcXY4MDpYIaShYdh9/Oywpo0aOnx1o9PKEZSpG/CMYTgUtN4bOOv/RiQGeVaUxylUQ/jXQI6W8D6Ao1U4kcCOp6b0LBNYhgFDDsNSKtKJBtZ4+zd3UYnjUSeyv4D52DCgI+SU9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(8936002)(8676002)(76116006)(66556008)(55016002)(66946007)(2906002)(66446008)(64756008)(66476007)(86362001)(9686003)(4326008)(33656002)(478600001)(54906003)(186003)(26005)(6506007)(53546011)(7696005)(316002)(110136005)(52536014)(5660300002)(71200400001)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: XrXy9eTrQTKCpRxeocRGmIZ6ZlAyWG1f3Uj7D9RXYEC07RCo/MthYwhiPv7XXlw145jRHAuH6GvQLn6BvFrjfjNUGgJHjvtImpuoRoSBjK5r/IqGwHp9DZsHiEH8d5+kVqKXUE0jrncW7P9hw6B52ZKX0nHAlRbu6F31yRhJfs46w8X00tNOVjZFx9eWsCXzUELqpV9GweRjyLybFAHzVtjfBKoS5/pIE6re0YEbkrPpigiVRiQtj41E1MnmiLbrR4pOUwD8lPmhoR2VAtdk4o6LWR9azZNe6lphQw2+n+C+rD2AVjY4ow9ZtrFCFTsK+zNXcPXKXmKP1wyxvztmzDf2L/DE/k/f9vJ/3eaZjeqodB9QTYMIiu4NHnOQeaDHHzO+W2FyoC9pKu9aQ5GYxmM+HNA+UjgkYKyiHcVisx5sGiOSXTG++7SbJAYGKQ1deAJyEZ5pm+MwiZmh/4UD1dgrInznbqnYAoxLl9vU/yM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3cc345-a943-45bc-cd83-08d80e5b8a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 23:02:40.1991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYW9Y6vY0IDkOmHZiRoZHyR3UPrZiPXqqpK7RgGg1XYwXdVCln3JW1ZUNjdi9eU2isTVTdZWtyqjKgVmkXX4nKgJAPY5fE8Q9ntIXL3HpnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200611_160250_473385_F13F3421 
X-CRM114-Status: UNSURE (   9.87  )
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
> +#ifdef CONFIG_NVME_TARGET_PASSTHRU
> +/*
> + * The exports that follow within this ifdef are only for
> + * use by the nvmet-passthru and should not be used for
> + * other things.
> + */

The above comment is duplicate #ifdef is self explanatory and I didn't
find similar style in existing repo  (e.g. CONFIG_NVME_MULTIPATH,
CONFIG_BLK_SED_OPAL) so let's not introduce new style which will create
confusion to future code.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
