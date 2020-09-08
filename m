Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71213C43461
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 23:13:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71F12080C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 23:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wA0+09eF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r2uca4aX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KbCwQEht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71F12080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Cuvmsa3BN0rkZ2hQNxlIDEp6J4HRKE7tIzoHr8YLLb8=; b=wA0+09eFIs3dhZ6s6Z96UjGR2
	MBn29CnuxsY+TjHsGPd4TmAZ0d4bIqmFo5HEp5ylAgoTIjjdpg1MViE3o/Dc/9BXvBmoKY6PXfF87
	fH0FwBH6N6mRAfliS3NLrLJ7HwxVu3Zp7dddPPpGaSIMtgRNjJ8VAuHUY9jln7/PC/TK8KC+l0uGD
	6Ul52KONKpYjTpNIZSUO+maeRuBdLCTmH6QiQSSVfS94+Nqc15uaBCD3RkHBB7w+AMEmH5scpFbVd
	CWpQZu63Vad9NTfLYoeR6+2xy6PzTxRTUd4cF7fj+AVfZS3YYHq6uG3APzWT/ZNfKg0QtE/p6lXnV
	LiYqQ5UeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFmnr-0007Kp-7o; Tue, 08 Sep 2020 23:13:31 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFmnn-0007K1-VL
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 23:13:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599606808; x=1631142808;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=OwCxqMm0H3K5rhdgcjJkFPTjNdaEfyWXwQYpzzPJjQg=;
 b=r2uca4aXCSrpd9kq7lJ9+NBhXCz0NA2IBr4PTiXM3kq5px26L8wZ4jaU
 U6dsjyoQ7xgYqj2GPvEaVAz+mRfTijrghQ5xvs2O6d1EppzgaRCfsj1sx
 n4OtxRKo4Z16JTsDGPcHY1WdonP0ldGns11iAR/9lrMKcq3Xt1KPo9+JG
 hvZ2n7z1n/9GXZImXZEhU2e4O4E6SDdnKp5ROGytZuW5S5+rStiM+Czf4
 kBg1BkIS9oalNYSP9Pl1RXG/dUINZy5t/6Qww0rX1Pya5ASlPTRN1xNIl
 Q4C5et4rLLl3Ki0PcaFhS/33j8NCsSJ34JRxo1x3qhzfrbnhWjK3Fpwhq w==;
IronPort-SDR: ODrmdm/mU52tR2AenRvN1VtlW/i4ydMaYEYr8BjkcyFh6wUin4H7PO/T1IuvrGjiEWjIROBgb1
 Mo9RBFgunzk2dFzjDZdACbvgjFRCPmygvWjrWdf4WTj7s/m5fRGF7jBoYTc6zlx7Q8pgk8wI1+
 2BQ+6WQUUkVhsj896uIH4XxgUFP836f9qetJKt312gYoOihVZBBqvtsr1pBHUr6tUukWfGw7Fq
 +Kw//l06x+xqhWCDmyh0LwEXER2A3LjLJc9d1ISE5rUZeIP2pEcGVB3joybekCHrzk2RvTDToM
 sNI=
X-IronPort-AV: E=Sophos;i="5.76,407,1592841600"; d="scan'208";a="148095372"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
 by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 07:13:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b13l+XqyDePyRqxF+8E+KNJqA6OGaIEAyUHmIfgTwaipWplc7WIKfb2fQOY7xapYJOZ9kCbq6osUCmb0JchX4NgncjskxfLg4KNCmU2lU6NC7oQpRWDnrYQtMCa8DpWiGhgD/r71ZNba8sQG0lZGdySqd6S4tywtGeCZSiWwrtGKfTFNYrqh86JSm4QJxtnvLwjEkuCKtJxI7aNOP78D+3jEYSsE38x8qYi7kOBe03tmY2DCorohpBbsOXp4wzTSF877X0suqJD2AEy3TxiQ8Y0iDSo9YiXX0/jZRWkUrovcmT7CeowLaOhzWdv3Ol2sKi2tjvZHiIKTaypcrvIFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwCxqMm0H3K5rhdgcjJkFPTjNdaEfyWXwQYpzzPJjQg=;
 b=jaZwxDuu1U5Dq1/Th0WiQdIHI3+ucLDkncCg3R1DAaqC6n/NnBps97dyeJJXIMVThCz5fFmmQZhbTRhcj8HNuyjp7lx7zf5WEela0uCVCVwmK7LMcbjNauwXwGxhlxMwCsEj3Bd0b+a1+gpTxjzsc7uCJlBBYQgBkRqR9K35CHSfJjxygUgWD6gou9LKpGJrARBnyxQXMCtaGuvEufbIHEXziyud1e/wZEWE652K0fKgHs4KHoLlKcI8m8crZYIvq4A6V5NsWcK5IeDhIxJDPafxFRc0OHJ81svaQjDVvDKS3moRyiAhmewUH5S3B1Q+plN0TDHaoh6KfzF5XFFLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwCxqMm0H3K5rhdgcjJkFPTjNdaEfyWXwQYpzzPJjQg=;
 b=KbCwQEhtXJ1TpKwENcg8IsvMKpYcfPaQk2sE8g8iu51k1p6jYdopnCIacQzYJQAlJeQpb2ZlBlSx4J6QP9uMOq9kKSyMuE/ent7FSECTVCSfTfykcU52OwQBG3IRMDm16JVcy5CbD/B9EY68SLrecAe6j3frcRgoHdnVTP+X/Ko=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (20.176.112.10) by
 DM6PR04MB5852.namprd04.prod.outlook.com (20.179.52.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Tue, 8 Sep 2020 23:13:19 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::19b2:3454:ba26:9963]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::19b2:3454:ba26:9963%7]) with mapi id 15.20.3370.016; Tue, 8 Sep 2020
 23:13:19 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/6] nvme-core: use I/O timeout in submit sync cmd
Thread-Topic: [PATCH V2 1/6] nvme-core: use I/O timeout in submit sync cmd
Thread-Index: AQHWglCzhNZPC4s4k0yT/NjMx39yHw==
Date: Tue, 8 Sep 2020 23:13:19 +0000
Message-ID: <DM6PR04MB4972813DFC22F4453D9D6B8A86290@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
 <20200904001626.5694-2-chaitanya.kulkarni@wdc.com>
 <20200908173012.GA19919@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d6b90c4-96b1-4998-1740-08d8544cc66d
x-ms-traffictypediagnostic: DM6PR04MB5852:
x-microsoft-antispam-prvs: <DM6PR04MB585219AE7BBE280C4CE0633F86290@DM6PR04MB5852.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMNxZJKtEaMUly3pZVfles2lgps3uY0YYFAgYSeISGocVUff9wCk5Nn9kcsYVBmaGqd41/nhfkUDK9pNydX72oxnnGTW01amzRAh+gHGpK400NfnFrPOzVosHtIa4TuaxewjdThc2UJZyPTW0RtaCyCXl2YuYDO3cr8KI+IohKhjA8BnY2kFXLLuHeQ0UVlpJofPupqg4xuIdWvv/gGLXu1fd0aH0Ti0SJ79sUErFvKfCPrkCA8GChVF5UNfMeInkYmlHvI4/IL2+JUM/XcxMAGuagqDQqebp0gCglwgMMlyOP118/p1wNS5M84kOLo4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(66476007)(52536014)(478600001)(7696005)(66556008)(2906002)(4326008)(186003)(9686003)(8936002)(26005)(54906003)(8676002)(33656002)(5660300002)(55016002)(558084003)(86362001)(71200400001)(6506007)(66946007)(76116006)(91956017)(64756008)(53546011)(6916009)(316002)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uMQSaydGtSH85alV7PsnviTxXoKXMIDguPw9WkvqeKoxw++xAMMSbP9he7p9B2aIW/W8Ew//HV8UQyNXBydxoj5QiPZNdK+5lr87FtNsdC/Cxzv9RwLmS+FKBhAY7IeZKWqVJ7dtxRGgNiTlPkqxDFBekf3iuZJFJfXWXMRemRQwLy5NfyNTBaUCv0kjuD+x5PYaskSLX32ynWy384TAc3+F1x1PRZqbAB0euc2nfMXNvd77s6J7kQq5j5FvtoHSn2hNijQV+sa74RYUhCugbKCp+/TrqQ1GiPDqnNENVJkKY7TboAnL+BQF9sE1ed1NhvRHxCreRoVo+iIzHxl0V1Wpta0F5kn9q1oBzAU4R1soLQrDHbIHFnvg0/tWuJqQHLWQJQvW/O29TUp8hgOB5sDDGBFAtQhZyx1WyY34BDczxZWdQj1RBMEwiNF1jeFEZAZ5cmAwPk4hTI8KqcbkoVYN0QdYX20j5KRAoeO78Qj9oo8PoYeETt4Sd4Nqk37UdPXe98QqjoeG8hdIvSwuDPLj2lZpzNlyarPX7lZYnvDhLAjjWPv3Hg7YB2ASN/KJ7r3sr63vNmpqvZ/XdgO3BxGoz73YCR6avJRSmQ51D68K6eadU4wOXJJQHGANGAB+Yr1WCzfeXtQGcFK6c104fw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6b90c4-96b1-4998-1740-08d8544cc66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 23:13:19.4721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsFrlkALySR8V7+BqHUHbzXRFqxC8huWUIMQrZMQ1lfdfOXdJ5UovC6AgZwU17WDmG4zXZcYSisJJdN4BPoK05xiFM+e37L9YBgSVAUSQS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5852
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_191328_336582_EC198545 
X-CRM114-Status: GOOD (  12.98  )
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
Cc: "keith.busch@intel.com" <keith.busch@intel.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/8/20 10:30, Christoph Hellwig wrote:
> Can you add a nvme_default_timeout() function instead of open coding
> this here and in the next patch?
> 

Sure, we can drop this patch then.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
