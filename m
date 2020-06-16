Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A906C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 13:39:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D105C20A8B
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 13:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kmEVFKKb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZiGollEQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Sg2TkmV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D105C20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kv24MySz0UauZrbDi5uhW9i3FJHRSgCCdCiZYQojgAc=; b=kmEVFKKbxCHqNO
	RePxAOP0R1k7vKc/Q5Kxnf9zhxU5KTviKoEQogfWzTjlyQSC4Xhc21eGtIGCSfZVg1BtCbF97eAw5
	hKnJFrJWP7BBouQGq6rVInervk24HukEZ4dYDo+rRb3xhrsHyBi0LUgVdGSGzV1/sr5u3+jfeE2VB
	z3G2MjJRgCvzBPfwh5IVTlJ/+o1BFSsVpDX+Hmvuvj5pX2pijOcZuL/wCeJPELBXm62jsm6AXSWMf
	3ISIBAh6VexfYFD0/TJETXJcSVQiBPjD0HfgKxGiThnFmrPS6StZGk7TGaVEpkJdVXrSbIWJlJYfQ
	nHpLcGiVkr+YwQPhcZ+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlBo8-0000c0-Fl; Tue, 16 Jun 2020 13:39:20 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlBo5-0000bH-SQ
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 13:39:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592314757; x=1623850757;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tHLNhpWZcVJ0uUmj9Hs016nI4018kl6yaHvG5tyKYn0=;
 b=ZiGollEQxeMDS7ZnXlH6RkfePnqkEt9M0Ugl2oRfT1EIiV5HYdK9Z/pa
 AaUoCoBpsiLVIHVOmd4D/FAxPjYDEdc7mOVTYA7K/C3fFMs3dg+uRiqKd
 RKTgyCUT2Qqpixt+j13+FJreLHXGsRdk/n6xdIeO3MWU/TXTJU+cQWenO
 phnVE7dSajc6bYpRg2+g+POt4O+GMUxr1eKJQjclkkP/CV7LHfUgkC0CL
 q0kUhGsY5batPZyjj6LSwEKnTx4yPmsnlCk8vuPYSBiv9WX/KvY62Dd8U
 aqgp9egANBOHLzYr5H1pa3iisA+l0ZIISe3oHrgNhY21Bh9iZaNDrrhjH w==;
IronPort-SDR: KE12vWC0C+99W2NBqsTTCwWZMCnIMc7DVjv1eAtCT8g6wvCbjhZDNCnfBQFqstqF7WIfJUefxt
 V/dE3V68h2jxyfdp/eQXi4EC7hREcprYylxQjPmUxMgum1o5sNnb8Q0TOeYaE2fQ/6NWmHqw6F
 WL/ULPFJxa988wwjq4jnlKaGGRR4jahrk9xFQrACLBb3W4l5oAFmDhsgXKv3J82KW/36+58S+7
 jeJSoVqOfNNrTmFVJ33459E4Fd7rH4zrN4wroVBb0G/97pj7DBbgfxFvszMxTeWR2XO6ZuSPQg
 3gQ=
X-IronPort-AV: E=Sophos;i="5.73,518,1583164800"; d="scan'208";a="249307295"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 21:39:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg6iiYrRoeHEh7+aVLp7quhB+8unmVzW4p2M2t8V+IdAKiSz5Rg9FvT9yYVRU5ii1wksuAHi5+lXYmePh+SBPO7mYgzRfLghHtTp+HHNqau4vQG4u90YGiJxH4XDvWGvlBp2qFU6YrPOdMO0UEMt2+JugGOdzBBJ56NKPJs8/iGYw4lcL/rnWVJu6vSXJ8ksJO89F1mi0T8B98tAoZxChkP5XyjC5hlaiWceH3rZlfj8bajZpro2gh+jINIPbkF3KJYTFPxLnJiH/CqEVpNaRwrIbytNLovyGpxV3THlfjoQbRD7xHYMdZSU9eSpkagTXMohhRSaOROz98mDjoyTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTtlqohRKsiRNGOc6ClnJUXXfzqz9ClxSIYBigwWX3c=;
 b=BaEqZb4QL7f1lUzohEboSqG+Dh2fx1O2gV1bel/5yNvAR+futQQH48G/lJUbYiFca8qIyvVEiXPL2WoVelAotVfpK4t3FK3bM+42Q36HD/jQkGG4D1KxAQqRrww/lbPgEEtwAafT9Yb0hTCtSYzs0F5M9B4SM6pbdMSpn6Aw5zmicIf27vEFtsptPV9WVGgJgvkDTACibUz/ndnybd5gLNmSzdtEF8E1OEAANUW9voq7s5k1676uUHeQJtoAioZdqaE5uRyDHYTNXpInQgc85ZBTWCCGj7WgD2SiqBFpLqpAt17s29yMXjbvoeJhO7Fr6y+N+l3EJ1Gl2+8fFrmchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTtlqohRKsiRNGOc6ClnJUXXfzqz9ClxSIYBigwWX3c=;
 b=Sg2TkmV8gU2qwMmHL2Lx4XnEeJc3wqVMhV1U4vQ0cOltT49vY2jMHORy1p53qsIU821pnNg6JkZ4SOEoNFrflWsOmMVGLnJA8tokbMYq5ZjC2cXrv8xv6d19IeKFyBmMg8sImpm3N34OAGVu9maM7+9K7HdBPq/cXt4Kl/4y540=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2217.namprd04.prod.outlook.com (2a01:111:e400:c610::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Tue, 16 Jun
 2020 13:39:13 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 13:39:13 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Judy Brock <judy.brock@samsung.com>, =?iso-8859-1?Q?Matias_Bj=F8rling?=
 <mb@lightnvm.io>, =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22ncHPAnMo9ZkarXHo4UNlnAg==
Date: Tue, 16 Jun 2020 13:39:13 +0000
Message-ID: <CY4PR04MB37516EB77A3287892BC5CBB3E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <CGME20200616123503uscas1p22ce22054a1b4152a20437b5abdd55119@uscas1p2.samsung.com>
 <3ab4032c18a8411389d3879026cde2a2@samsung.com>
 <7c76c93b-d8de-831c-f41c-3ee3a8e48169@lightnvm.io>
 <e54fef92f28b4e188a5c31123b24bd0a@samsung.com>
 <af672280ac4f4a86a15c34306c9dd5f4@samsung.com>
 <8cdfa0a77dee485cacf6b91897a1c5c1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf95263f-fe16-4022-dee7-08d811faa844
x-ms-traffictypediagnostic: CY1PR04MB2217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB221778812276A78A12EDDF51E79D0@CY1PR04MB2217.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IcqC5FgbE/xzrkqtVr52lPmjMIlA0QpGSGEXd+hEwxIuaq2wP2Ol8IvYZ6tvJwWzfPFljuBtWL9j15KCdJtkV4J/K1aHC7iK50INPnqHAjx5+gJfJt/ZOQBVZzWolPdOP+U5580ZJ/ane75Nt87FPJRtUfT1qB2mjASvg0h43sk6Lxdlbv4/6CLftB40R2rdR0aCM3bbFJebeNTx3WpUa5WuIDESqyCrBkm6YrdbwSnbs7VVQduVmxG6CXmFELBpoQ+eBp0MrwGQ6v5rIJ3AIVLcrVtgSFs3c7oCt2XUssux0bM6v08coOdpbntaJkoJ4p61iC2u+atuc9X3FZ3/rg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(186003)(8676002)(53546011)(26005)(6506007)(8936002)(2906002)(5660300002)(71200400001)(83380400001)(52536014)(498600001)(9686003)(4326008)(33656002)(55016002)(86362001)(110136005)(54906003)(7696005)(66446008)(64756008)(66476007)(91956017)(76116006)(66556008)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: pO8kdT8FbWXH5v235AVAsan1Ch+M34Tog4G/vytXHMfsXuJniF/KMqL55VogdgIPNKL8a+PpajCbDwl79UUwiYsbGavZ56AKMM0dCk3KzlwJOxRPXnYhY0BLiWd/SAU/tBMlkCh+Xe8k0AFLKjCmrz0xcdmqzid2OoU0jnurxZTHrRZcAUierWOMFhF7qkm1AACnEOoOUrsCj2WML1uoOZcM+tZcdjUDyMSmPXcWdQQW8AGu9VMvOAfzC5bDw4kMIKmg4fKB61uS3L8FLI4LMcXyglxraypl534vjHJ6jQA137z1yCdcYBdqTg+GSUr+xShYWVzpTKMi/C1HJ/AcM4eCkzNUdzC/uq44iIFPC1leV1YDZRm4KBS/ExZ11GfzBeiMGGDWc7NwrZk9PCNjr8YxjMipuuT/3zjlDXC5ooxZ7n+AV2tfBsk+ElDi3+wfnYv7SoxaL46b1Oh5f0lBbIRif58EQ0xy78KG8FhZaTd3z1iipsm4N6Poy0C1Oobb
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf95263f-fe16-4022-dee7-08d811faa844
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 13:39:13.4817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IN09JViPC2eoRjYkSCijAkzWSjGoBzFmK9FeYtoUlrjUuxnlcjqda9UmvEu0pTKKeu09sH3+JCu3wFdpjBGsNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2217
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_063917_995206_B4153BBE 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Ajay Joshi <Ajay.Joshi@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <Keith.Busch@wdc.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Christoph Hellwig <hch@lst.de>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/16 22:32, Judy Brock wrote:
> Ok last comment. I should have read Damien's explanation more carefully. I'm
> backing off... I see it's having to do with needing to preserve write order/
> zone write locking - a lot of knowledge I don't have about the Linux storage
> stack (but I see that is the performance penalty he's referring to now which
> makes sense if one really did have to lose the overlapped write capability
> with non-Append-capable ZNS drives).

Yes, that is what I meant. Regular writes need special treatment to preserve
ordering and that has potentially  performance implications.

> 
> "To allow other ZNS drives, an emulation similar to SCSI can be implemented,
> with that emulation ideally combined to work for both types of drives if
> possible. And note that this emulation would require the drive to be operated
> with mq-deadline to enable zone write locking for preserving write command
> order"
> 
> But of course that is not what we want to do with ZRWA-capable ZNS drives.

This is an on-going NVMe technical proposal under NDA, so I will refrain from
any comment about this on this public mailing list.

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
