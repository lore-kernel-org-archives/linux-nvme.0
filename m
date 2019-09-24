Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFCDC432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 13:19:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C78214AF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 13:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ShhYTpsH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z7eEb8Dz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zB3U1HZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C78214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+sLOxTI8b0HDPA2zee3WORH82+OTO8YljwyTqrWLhxM=; b=ShhYTpsHbaoU5g
	4MN6k9MRdXifGlZg3TjP7ox8TildCcjMUXE8FU3nbz2FTYnw1jWAFTPBVpdQq8+PQE2fthdY7jRSR
	Q+ozyXl0GOtxTWUneTvzT1S/Zs6nnMdIeD7fKkFSI6EhypIWaGT07dob+GjeeNv8MKYXRpoorlWAN
	12MhAGZepia3BXnRsvNyyHHhObZhM6qZ5biBghF97OE4d7fuIEpV3jf6p4N50ztGxPHdm7v/mJ+i0
	Nyzss4DqyscXRyPIGjThkaDyo8D0PDEylD6xDTWkQGM8cVhapzVn9pXsWfpX2FpwZyNzAllLoISRJ
	xxDFcV4gDolKZLnzRyrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCkjM-0007Q3-Di; Tue, 24 Sep 2019 13:19:48 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCkjJ-0007Of-10
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 13:19:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569331185; x=1600867185;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=CVWoImCOjsLmNou/f9Idjmh4BGIswN/EgyIxh9OTSMc=;
 b=Z7eEb8DzNc7WD5x3FGIcE0fYBy2V2L+TPRKCt0skNM8F6wFgtWJntG9X
 XZroXbtHUTAM+eDlzxjwDeeRsF/J6Q1creVNyig41EPrLcPlr/EX3n3Zn
 t3qCKovPnP+9vVrabwa99zF3wkSfZkVeIJJL5XTZ4gjOYjrXjJJctPQYR
 gkE+bDe+P1w1748nzHvRlFOC+2MF84fAfk3hh/w+lVYk8frPevvUpSbb2
 eSZOK+xS6ULTu3ICn3ps3w2zgyzGB1FmrrHzbU9p97D/WVfrysIZ/pTxQ
 Y4mZtyZkMWUPxrxGIIf2xf/jGlpVw94l4QhfKhTgmpqXWPXS5dKaLaqbs Q==;
IronPort-SDR: Mf0oR9XSiaYVZuMG8V8WmDaVZDD4e9E1KdWGAaNo1/DpVlCxVjy3n9F1lINlFZxW8KwwCcnOm2
 UqheKqe4TiFwgsjsVwndWZsyrPlwxhl9UQ4xqwP/SixAQrS69Pbu26VSvetClxZaTDwnqlt95m
 Kb0Ld0Th/idNFh8ni8QJrd7rltw81Ga1pOF16/ecsmava6YzY0nvBWd1jXFn1MisWZ0jhoeMsr
 b302+qFRxB+YSRligKirL0uyB5/kiQfszlyaqKU/SFiuQgNuuW90Unp08bQJgQu6BEfrbg8AgS
 tKI=
X-IronPort-AV: E=Sophos;i="5.64,544,1559491200"; d="scan'208";a="119757361"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2019 21:19:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoYWPPb4bbR1kLBxKfY/QEpenOuwDdM+StGQR5mgHN18zRWf9A9C2vhLK5YY1UrzTPvh9sUJIbpLFEt23wBZiiMntKWiZkmtfdVrvbHFVtPBomlZvI140QIZhMAVWwM4s/YFvdxJ5/3+jswHstRj/z9T6FzsTjspC60DbSlyihs9ADvLdgi5KILaJ1EX+TK2D9ymh3E6pxUqZc1dCgn0u61KwQkOEv+CNadnPO9Yfr/PnIxdp+cn8OZkpxeXEHFU51SiaPjb3McGyiArrYNS4Al19cYDTyXy83TZRH6Q8j9bTB9DJVuHLTjXyY9BB+jQ1wuZgVaI/I3v2UVvacFc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew2DmqCfOTquzXJvsJrJpN0X95EzCsp9gndyad9dH3A=;
 b=hAAOeFbKaB4Tqd/Wu7g+xetHO8QU8DbrqWs+pfazmwb9ZLQmV9AhwQay0nLLhrRghSThXvV4hXYLroBTT60AiI0Ofzo3xtUFQyiWfdltUplyXZOXRJxBCCeJBwTZcen/abJqFbk9i5/yX4Y2q4zYiowDe1ixRgBVCM67YMzG5M+SOAGoQ02tDy1T+bMPFs1/Hz/G7t6Umqxwmc29vAyBycW1ujZt89me2Nnfp9R3HfEDftspW3C0mhEyPgY2krld2ooQ+GpuvD4BHJvim/akao6yGCk102xbEDi0xL4uSE/yLe0etHDFcLVPxbrNyBeY31YdQOOncf8EHHP5tD+6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew2DmqCfOTquzXJvsJrJpN0X95EzCsp9gndyad9dH3A=;
 b=zB3U1HZQYy7QNi1Dz05RVrtDPD0J19HPzyaVIA/8TUgQHzOy6NTx2DPLVWKfxtefx/xeYlEG32irgunDHuiTCYpGx4Mx8nHpX62sAG3kATzMxa39ztCX6JrrjeYnd2XF+lZO6TFywedYSxYaZY3S/r/0xmm/HgJYnWfz5OaWVm4=
Received: from DM5PR04MB1244.namprd04.prod.outlook.com (10.174.190.148) by
 DM5PR04MB0459.namprd04.prod.outlook.com (10.173.169.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 13:19:40 +0000
Received: from DM5PR04MB1244.namprd04.prod.outlook.com
 ([fe80::49f0:a8ed:cf02:e11f]) by DM5PR04MB1244.namprd04.prod.outlook.com
 ([fe80::49f0:a8ed:cf02:e11f%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 13:19:40 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: NVMe CLI Documentation Regen
Thread-Topic: NVMe CLI Documentation Regen
Thread-Index: AdVy2i0DHylCZVCBQoGUw0zA7mVxbg==
Date: Tue, 24 Sep 2019 13:19:40 +0000
Message-ID: <DM5PR04MB12448280B8639C509EC336F3EA840@DM5PR04MB1244.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05e1e33b-758e-4124-e19d-08d740f1db32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR04MB0459; 
x-ms-traffictypediagnostic: DM5PR04MB0459:
x-microsoft-antispam-prvs: <DM5PR04MB0459841D4A18B865E1AD4E84EA840@DM5PR04MB0459.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(74316002)(3846002)(66066001)(71200400001)(486006)(66446008)(66556008)(66476007)(71190400001)(3480700005)(26005)(4326008)(9686003)(66946007)(55016002)(186003)(64756008)(476003)(316002)(33656002)(6116002)(86362001)(14454004)(81166006)(305945005)(7736002)(256004)(6506007)(14444005)(6916009)(8676002)(5660300002)(8936002)(6436002)(7696005)(81156014)(52536014)(102836004)(76116006)(2906002)(99286004)(478600001)(25786009)(4744005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR04MB0459;
 H:DM5PR04MB1244.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: seLgncNeLCFdmVRYJemBD4wPgwA6qaf4H4MKszmwvxMjNmlsHl9iSZTygjD8tBMzgOV2kYYB4zk1PYLxpXE5eFJ2HJ5B6S7TdZcaBya3sziOG+Mtv+MNA2RHa//1iZwCe/iWrTSBTJSctbKOE+BQq/63Iu9OijU2LuLISP/U9dKgGILExNqi7NiSImDgmENPUskfQRO7O027ZKinB7Rvi//OgyQbnbcV5ZP7uRFqfFGnx5OKQ/op5C9a7IlYG2neYJMZ07wOBiWqixQZzvUVdG9TZ5fYg7Gn8iGwqp0yeJjC19+B1eHG1Zkx0BbMUxev2P8sw7y1Ulq8fvX/IayVIDFgxr2GegCie1I+RRziALv6tbrRVThbWZYDU72RyTznWtNiP1E+86ZC5X8DISVhfZuIl2UzIJC4y9903NoOSIY=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e1e33b-758e-4124-e19d-08d740f1db32
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 13:19:40.3446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYI8HFVUCU56crLKjLivlpKiJx/HeFOhXVbF1RN9ZPXNLT6NLyEecPYITFH7pC3duoXiS5pBkKet9aywfS+Jsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0459
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_061945_126710_B0D2E244 
X-CRM114-Status: UNSURE (   7.45  )
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
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith,
Could you regenerate the nvme cli Documentation dir?  I made a few documentation updates to the some of the wdc plugin commands (vs-internal-log and vs-fw-activate-history) in my last pull request and noticed the .html and .1 files hadn't been updated.  

Thanks

Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
jeff.lien@wdc.com
o: 507-322-2416 (ext. 23-2416)
m: 507-273-9124







_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
