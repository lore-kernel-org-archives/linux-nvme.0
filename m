Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B4CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 20:17:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C78122B40
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 20:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SzdY8A+I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UjubPNR+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WE29XyTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C78122B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=N+E/kzN/MRt7tDagmLfisQY9eHYaBLQQ3cBqVItm9io=; b=SzdY8A+Iy0/AE+HmR5h07LtHgs
	XKpkvNh9KE/rIIKbfFk2HG9diT3fy67yfZFRV2MAnevHAgvdklp9Ch9CS+3PwvgAOI28bWdr6ZBwG
	zzYE7Upc2IDpzeGhjezcZffcYEFvWj+q2lOmtLXQN3FKfKUo5Xh+x7H1COgoIafIWCRXndsxKP7k/
	1MbEMSHIJiaRORYF4t5LyIxkX8eymuhFKi0BZwEVYSxUbbumeE8laiLVOH9lSqHUlgs4Mv7caQWZN
	A0EBib3JITzVvJ8LBjod1Q6jEvy82T2VrrYhGKkBq6UWvTJN9QTnf9+nB8kMp3+23fMvAQZnjZCrq
	e56+eC6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2gtB-0004Cp-Ty; Mon, 03 Aug 2020 20:16:54 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2gt8-0004Bq-Q4
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 20:16:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596485811; x=1628021811;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AjnEvUTFmYQN64rifCy4r1moPxQ+HWMYaBJGDiqWNr8=;
 b=UjubPNR+vlfRpgmWJSzPrnxAN6Qwx4XNQJbh36otPwp+sxZmHQ9W1Zg8
 B/ygcmaRu56dBg6dx6ZWJAsNbOOnavtqtVsUi3PFOTKYhc6GeAaYmhuHe
 cBkxROgF4OTLgXFginA/AfpPIlJerb/qRUUbC1cL6KUrugbiMwnjhviM4
 csktIXE//HNJavTtOS27o+aqYSIvnrT5AlP0XpGYquvrTvS/Yi/JsqMXU
 AnR6SBISKB9BMMmYJDnZOXZNJK++88oDrhKdJNpjzzYD6GtP89NHjEvq9
 92aL+zOAgLV6XgvAppscZATP+dLyl4Fv4PgWki7v5GlpUUIzdj3QQbQc3 A==;
IronPort-SDR: eg6Lr8nbVhE3voPyb5HWvuXQOwVEVunmh1Gqamr3Z3g8fMam7mYfyXLAG5vCXKCzLo6Nogx7av
 nt/+bSA+NTUlCt6OWx2YbcoKGDBP7c6zaLyUEknuWCoskLFhlQQzwH0yD34xeMI+hJ7Rw9ZqXi
 7nzgo0mXSRWU3vaBXmBdVA8C6gT79PDsYaPYpgEz9/IbwgBlQi9t22iLouiUgSg361/Yoq8vwe
 +DJicRjghB4USASG0iXP3EkLYQEoBU10+GQEiVaSUUwc9o50cV2RUzUTlc14BNxGr3D0/FGE4e
 ekw=
X-IronPort-AV: E=Sophos;i="5.75,431,1589212800"; d="scan'208";a="144116217"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
 by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2020 04:16:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjtIH9/4qpSeyQLMPOCuZsvsaDAo4H8RMErwPkEV/WCpmcFVWDhNWf5IUeRB8wfR9+dv/Acn41/mibLEWr1fwW8QstCC85Fgli2B5UMY+duuHqEzgoI06OqYO9caNjNt2J6VbPfVfd9HG2hr+ZCKzizfgvx1aIyCUMt01vQSc5GZ4YC2/4J6HCq89i1FSMEj5thF4cf3ETkGlhAB66olt1nQKU0xQkfqIZo27ZAL21Rudi5LzSOmoVoKFNQVHwA9cQMOyO+kBFNjCwyMXM34xcHe8tNHBqFa4FRttB117h/+GtjgfM4oL4qG+IYJFYqt8yNvqZ0fso4hoOgLa+DaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjnEvUTFmYQN64rifCy4r1moPxQ+HWMYaBJGDiqWNr8=;
 b=fJh8ao0kaGXlpdqggvOCfecNb0TInTVQdrlLgCgcq1rljNvMGIyIQtsTAd2yI5wI0xO7+hBS+OFhrsazGctN9xjxrxy35V7GfuIONiun39R3XBB4TfH2DrJ9iYhdObkBXd2gPgusNSMHgZh546MueOerd7CBtzVnbQ6kFTOmkU5ZeN2wlJSbl6AWcJuGxLH5H1wI0PG9WSV4Xn+NjXeoUkeKipR5PBlaP3SzGJZj2ok26MoMhStICwqYqgYqaUe/vre/xyxKIQtmH4qV+YunTd/qTEeb8dZEWKriTN1NrJ7JTnVUJ3inv725DhI+ym9XyduyvYydqS2HjzfJ+MJEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjnEvUTFmYQN64rifCy4r1moPxQ+HWMYaBJGDiqWNr8=;
 b=WE29XyTE7PKw4rULSvMgjwL//Den7LWwmoQvmb70gvaknA1FHhYelD3ApMoOUePIhmwHicLLdpPhCSvkBZtknXtp7mLDYvzuZLUapPlP0b5RPKCIYiXrwFuRat5CTN095iSiZf8XwnjIlbz9wMdWxQm6Fx1S6Fw2xOVhJSScrjQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4520.namprd04.prod.outlook.com (2603:10b6:a03:5f::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 20:16:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 20:16:44 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Johannes Thumshirn
 <jthumshirn@suse.de>
Subject: Re: [PATCH rfc 0/6] blktests: Add support to run nvme tests with
 tcp/rdma transports
Thread-Topic: [PATCH rfc 0/6] blktests: Add support to run nvme tests with
 tcp/rdma transports
Thread-Index: AQHWaWIk4FsmAaaRwUOLH77BtUrG8g==
Date: Mon, 3 Aug 2020 20:16:44 +0000
Message-ID: <BYAPR04MB4965B184B6FC82243F78A569864D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200803064835.67927-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23af75c1-f3d5-4315-18da-08d837ea24a5
x-ms-traffictypediagnostic: BYAPR04MB4520:
x-microsoft-antispam-prvs: <BYAPR04MB4520FD0C949647D3239F9370864D0@BYAPR04MB4520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OvnTWmP8LudEWoDiDg6ZoP4VG4U3ZvP/S03E4GhnF1VaZwQyMEZoLbJsFQqYsZW/j2cvZWw9p2I/ozuQBnH9sHx02XBAUb9arXu3jDB8cjYIkh65A1m5u7UxSU6dMP1qdPMxmaDLRit7mFGvCucucGZvmo9leF29UoE6lGj2OKLykVX5d7qQrNVigrc9EKs5pbrDiuc9UhdpVoYx35DEfC9Zzhd8PY/mc8aWy5YUKcI430bt1hDxXL7f6jko4YzBeN1KkXaTwY8x1ZkDqntRFDw1QYp0K4+8Nu5hnqnBwwDqsAqbLrAM9RULUBAH6B5B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(8676002)(2906002)(53546011)(6506007)(71200400001)(33656002)(55016002)(86362001)(5660300002)(8936002)(76116006)(9686003)(26005)(186003)(66556008)(66476007)(478600001)(7696005)(316002)(110136005)(52536014)(66446008)(4744005)(66946007)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: XohmRe15tabryRdYizhFxTGkG5cV4BOiE/gttVN9q0JNx4dx9gs26Kj4e3IsE2Wtxs3eytVaIjiTFGBqtgq0D6tL1qM6zDIiFsANVUemQhP5ISVQL9qy0V9aalmr2nz78TO/hpD2V3HqyIrmjKCTmlcV/cjRCc6DYAd338eupfD1hrBZQbz1B1fjsPb3S2o6qAsF5r6/qcUL5Zronx5EDU6TBRD6qUsShaaSLhUdPf8paCXktVMv7z8Oep4mho4wTF3cS4y7/Llvt9XTAJ4F8GihEeqFw0NYGpBh7Cg9RCb0R6v4KVPcmf46Vz5OhONm46qYYgTR6rXhP5FjVizqQ6yE2aq7pcc6lRAtMJEv+NxHJyMYmMWoI0ViMBkesY+VaYNVm6wpOlhRRqN+rXDn/vgNjuLyRP3YQCzIAE6fHriRrA0uSHmNvgQDQVUuvcAd3WxA767vPhqmB7l4fuu301bJlKQh7t+6CDPJCjNkv3yZ5oWx1KOcs8s7BnDFOoWV/6t/YQKkQxiAHxwf/oImbxKNID7lp5HpAOrj6TdaWaHtFZxnqBAKpNiYqmDjxZhoEearqkTlNv4FiVvUAvWZbfEHcZSluLngu2RHMr8jfm90h+jlDzQvcCe3Nt2sCwi9YwNeu1YIWc7/82duNeXkkQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23af75c1-f3d5-4315-18da-08d837ea24a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 20:16:44.8337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOZbuAO23gtpxBeKwgyowENkv8Lb9nZyqEa6ziyJhTGpCbCU5X1y0agwtFaZdOelej6RlEXOL3/JRE7npiYJu0Tw0btBHbEefKrjRjJSE44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4520
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_161650_979027_7ACDFB54 
X-CRM114-Status: GOOD (  13.24  )
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

On 8/2/20 23:48, Sagi Grimberg wrote:
> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
> 
> $ nvme_trtype=[loop|tcp|rdma] ./check test/nvme
> 
> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.

Thanks for having this done, overall approach looks good to me.

We can get rid of the rfc title and start the reviews.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
