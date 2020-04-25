Return-Path: <SRS0=uXiZ=6J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB51AC54FCB
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2020 18:09:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B756A206D4
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2020 18:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W44cNbEm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LlROxASY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZruTNrX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B756A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=5p4vOlplBZQ44vxkOCXcsojqcq/AMEBA86triO7FPNc=; b=W44cNbEm6vj5Yj
	Ep0hzpPbjkfe4aTHlCFaJRpMc/vinSNBg6cgquVkZSYXfeCrUwOHyETNIRpD9dfdPEd4e18ATB7kV
	mvhUuWq9WXOOHOZlhNHB91qsGGnyWciUbqh1EDYzxU4+ellJx5znvizl8mmSzwdYkxYadYeRj2t/s
	5S7Wl3jGdl0VmFkwtvV9tPzGMfGPYFHuvPbuyQMw08lMbyzynO8umOm+2RhduOpRZTwV3AuZP+19T
	udRHO7IgDSl67kdrOFrpCKRr5OWUd+PnNQlVEzSIdUaWqUzMThHjxD8gY4FNGPgmekWbcIEGS3sMH
	jBCiBmdV1FXa+fdzXUbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jSPFG-0007rA-UA; Sat, 25 Apr 2020 18:09:42 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSPFE-0007qQ-4X
 for linux-nvme@lists.infradead.org; Sat, 25 Apr 2020 18:09:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587838179; x=1619374179;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=bocEQMySy6ZfMpaRqxOMLYHiPJGWnSq53AatB7BOd0E=;
 b=LlROxASY4qZUup97JTHRDvXuy2I7XuUuWRMzUbWS3+dMoj0BKZqG81tz
 Hg8gmQkBQmTW4mkKu4atgDy+A5hRkuWZWvRdcDeKubztF+49O+/4krhnc
 4ltsNLEOWg4cLzxJBLX0AWuQbElNZCMdR42l4YKXmKWwLWW5XY8sGiUXp
 I4kMTMQWx/1LTmb/cL3bz0uXhvfGmANysN2q1yJ+dErKiMQq+BBF5hgMx
 pwynGn+xYQvnRwqJjoBFH3K4+udzAK1aa/I6v1nbauifnP0aMgoFYy7fe
 MeZLh6Z6Q7o/OggtIvjgHWJpP4fC99c6am/Nvdy/Xf7Lbee++oq83tfku w==;
IronPort-SDR: qNTtpX99PGcUF8GDtwDUqrbtLJge8qRKIQKbYoYVyulPSWJfd2h8nbhMIoic11QABDPdWJBjT1
 S6O4TLD5781vW3JvteMC3xgrR20gCOaaaRj0HsAzygeHJjI3gxTr50kueakECJrhOL28zE7/cx
 Q+C95VYDbxmy+4cUS5BCghUENtxRlJq78Fc8jEQ/GRBqMMCumeHMJImY2KhlYyGOL85IOdKFtf
 LiQ4maEo6PAtAkEHaZ8t1xyN2BKvQerZsKkX3xdx5KDxe6VnO504XkzddSoIPhdUy18A3FOrkV
 hPo=
X-IronPort-AV: E=Sophos;i="5.73,317,1583164800"; d="scan'208";a="244917153"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
 by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2020 02:09:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3d1Zm5CABSxejh2DSC/dkIRihel0poqUBydBdvxU+FQUjAqMVs4NbxBjHjOhlUQoDtb0NG2TfvxhjIsZHB0Ut9c3dK+AZ/zBxh66qXFeM3zWLAoIyMqsE0kw/EGCG29z6Swqk9Ze+RnBG8phRnyN61BaJ6lJpyZzglbLgvtp6Q3cgjCTmWtou9Csq/1v0XJMCQwrPd9mC5Uz836tRuqYKwwrfQWtdLjT9kah99Zi12JG7OL9hjp6L6vl6frMvIFpdmY1k/ggbA9LNo7ER3VGoZPpkMd1WNhBcJKWWwdaMO106ugjDiId6PXKsMhhBWHNmxfSHyuxlrX7WE/13m8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bocEQMySy6ZfMpaRqxOMLYHiPJGWnSq53AatB7BOd0E=;
 b=kkHtYZW2MDwO59aW/qJyLXN1CDyMQ8jarx+kgj3ssvnszfz0nNdjVA0fmaWhDmp9sH/XjP4ZytWZ5ajDUgXemlYx688918uNFyGuWZu74Vk/tyRdPiSp5CSg74NU1iAJs6t5cmxnqTSoq3uxD3HfbHZCBeaevawo9o5bfJ9dOHKVj7VRyNYn98mH03ia61RUIGHaQ1/wGKYXnvVndzqx62mjvIZaHhfvfJEJNG7JjYl6yds6R2vLkLPuO6jUAoUtJ6n/smA43ycleqoAs5muHCW6ZpZEI3BLgx/bpF0eEgDvV139yH5LoPtPJA5UqNvf2iVw946RpfjVFqd5S4gifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bocEQMySy6ZfMpaRqxOMLYHiPJGWnSq53AatB7BOd0E=;
 b=ZruTNrX0VRCpmLQ+kDMuyYJ9D3KrQbsJqpHGWYyqAQkYxYsazjj4wnOtz1Q9jX1W4fHcRcmV/tH1ZDVEbRpQs4yNNo5JF+OKXkKaBPgeuA9HzEAbLHJrecXurfq8Jz9VzWB+jo97OD07dwYNvJuv4xD4jsWdUhUxsoX6J/uTWEg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4936.namprd04.prod.outlook.com (2603:10b6:a03:4c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 25 Apr
 2020 18:09:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 18:09:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH nvme-cli] nvme: fix asprintf return value check
Thread-Topic: [PATCH nvme-cli] nvme: fix asprintf return value check
Thread-Index: AQHWGsafDAd4IzF+FkSU8DY7A3Nh3Q==
Date: Sat, 25 Apr 2020 18:09:36 +0000
Message-ID: <BYAPR04MB4965490C2ECCFCBB3B58E0B486D10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200425055852.2921-1-chaitanya.kulkarni@wdc.com>
 <3dda409b-bb72-1019-5ce8-e22781d45ba3@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da7741d4-a3c5-4cce-aa64-08d7e943d041
x-ms-traffictypediagnostic: BYAPR04MB4936:
x-microsoft-antispam-prvs: <BYAPR04MB4936B75A392882CE98768A1886D10@BYAPR04MB4936.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0384275935
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(4744005)(76116006)(26005)(64756008)(66946007)(66556008)(66446008)(66476007)(33656002)(110136005)(316002)(71200400001)(5660300002)(52536014)(54906003)(6506007)(81156014)(86362001)(8936002)(9686003)(186003)(4326008)(8676002)(2906002)(55016002)(7696005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZGe4tXZw1xIW8kOGl3ZmVVMl8FnCLcEL2yJjwfC4e6SBHAkJeE83AOga94MwyPrbEzeyrXt7ikWQ6Rc2ELwjfn7SNakXl4iDv0tw9f4rs51tINoxbFXWYkwW4VEqx3HIknxB76YoIX4s4PftaPzeuqh8ZQVnZjP8zNzl4vPbp9kknSO1+fQQc+Jmo5QnNF/kKjpJK4vVTmIsMSwxPPM3lHW2vIpdGiqxv/VwPO0ClEcRjhhzqbpKk7R1Pe8+/0n9OBY9RBJcaIo7ZUCvRJBSzLLXQbiHHrVL69ODxo6DsYb3HHLbgIaNH+354iwQwVd7A/uvoZshlEZB5df7wPG8xOdCBTd1YCGb50986vEltbw5O/myTFUzDsiIRo7UnKoQJCYD+FRhFxr30TXhUTF/vlehFN3ysKMIZyHy7IDaRg6z/lwYP5OfdOmBtjOcDhBR
x-ms-exchange-antispam-messagedata: TIEcXmZW8ABupIGa6bBS55g60XI4tOVLiLhVW4k7+90b0UAAtW+y3VvDyFEZGKchkNuPJFEjLEMlOdRn+BUb7dlypzus+l8Z9JuHiWmgQ95JIm3ejamQJj//OIeu9k/a8DqH0QPgtsBP9VUieGMCyp7Mi5j6VSZo9vYv1xGyWf9POyT9LY5QWYnw7vcGi43yGhJ5XvDE+XU8AZVx/OfyCNNJBqpf27H8mZJHksvqT/qGvJFLy0B9rmlxDATxh138pAGpYT4R48gJJTtGM9K+IkV9uQClHs8xemMK0t2yTw2gmI8Nzo1nqUMuhDCcQ3jd1fS3DomJuVaT6OizeOrG477wpcy8/tHcYIWctaaODo9+mTQPIfKdrjXktYQIHTG/OVfwwBvqs2Ez70IRT0tfJHJv/iOdKUP9Wb05k0qVG0DkJABTv+VoIlF/bp2ZxoAZ0tiHl/AHDr5GM8XmHe6pzzjc0Q2FTMrcM9i018tu+tCff9dDrjzkVoiQPwNG9f5CauixK6fvRzYx8O5gAW0n8y1acLre1g3sE7SEHUXGF8clBQoDeb7RepiZ1DyVmVvJby8keY4+s8GEGorFTrlLTDNncZO59CSIc2uFbyvK1erMtFekvzDaUGejjjdcxHco8BpzlBwVWqf6PifKKiWqQXXravFYy3EJ+zSYaKY1vRunvLGHNlmTfJkuSrg7BVsXPASf8hdOXN+dNXojpeuNrbPp1mWGZZuBFrDi3WwIbu2J/mNcmOz8Aa9qmoC9otl4QIV/qpg0m1lkuvC31TGs2f2YmHHB7L596LB32gVWLEQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7741d4-a3c5-4cce-aa64-08d7e943d041
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2020 18:09:36.0680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRGSX534Rp8YX6xM9FI/G/7fSJfz/57bEUc8DzAcq/xGyAROPVJMszWGGNuk2+qwW24G0sbxsqBG5/+KqgP8pBUmGw6pJiEallGtKE+LM8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4936
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200425_110940_258657_C964F45D 
X-CRM114-Status: UNSURE (   7.77  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, Kev Dorman <kdorman036@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> How about using "< 0" to check for errors? I think that's a more widely
> used approach to check for errors than checking for "== -1".
>
> Will a memory leak occur if the first asprintf() call succeeds and the
> second asprintf() call fails?
>
> Thanks,
>
> Bart.
>

Thanks for the comment, will send a V2.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
