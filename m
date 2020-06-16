Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F3C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 17:14:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D690E20B1F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 17:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AdFnysg5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F+cQaNsX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LOyXF5t7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D690E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F+ZinsbRTGI3yizA1bSpLeZlcQSXX8JtFPVqQdxRaFw=; b=AdFnysg5H93Q8d
	e6slY21yu1iqydCQJIjlccwW5fe/mzE9AomrUwHjh0rrnTNkoRsYJ6c/2g8gOoQxt/9Jmzfot+98T
	KBN11PazVYiUGyDiOLwEVOZGeXMq+B1c55fv55UZQvGVsLjNcRCUWb+3ZVth8EXN4EvI/mY2VEOys
	/TLtRlRcwOAIfJEZWvT0iL698ArAwvYvPcGWDthEzqE30+I49yS8H2GPFNfqD94osMdDz5pfu0/DB
	pWyw0PXd4RhC4tewtYi7XfUo9u+RyshjwGcQZN7zZoxgwA8//qU00PKWaFhfiL38qweoGH4HeA5Ur
	D3uAVqXiVvVc3l7Ge86Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlFAD-0004X5-7h; Tue, 16 Jun 2020 17:14:21 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlFAA-0004Vy-4d
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 17:14:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592327658; x=1623863658;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ro2a8rSo/hvUlAETRrlTMc2/Oea/fLfYeaNiP0s5dGs=;
 b=F+cQaNsXvvhPHmPtYI+pB6fp6FIzFRxhH7I+++5WGB0ksMxCYQHHEVij
 dFrXzOjvIVyf4giRvnu8hWwksXPxiW0Hu+AOwDV8Lw0BEeAArkLFfKR0d
 dTucoy0512gt+lyVy6F0p8S1gL0ynW9pqWdhlfsdumgdTLu8W/ofPBxOH
 7T+NmHVWgkQiYGdJRG6ZBezHXpOr2B+BwSw9NmOd9Qja/+yWtwKE9p8xG
 8GbbmAy0ncJcsZfmB2JTYKynNZs5GnyAmPO+MkwslchpbbgTvqCnRLnrN
 bhd6Q71kwThjBBbx8rd8yn5oX/Gzuvcwmjk9Nlrd3x6hL9WJkJFhapxbV A==;
IronPort-SDR: vqHHBI23CI9EblQT1Dkr/7cXJJfDr8B7H+pZjfkbzACRadKJgKKfFKph0Hx4JHKTQqzYOTuekf
 zxQJeVrLjFz8rEICXyJZK1ObYulUHQlN3GMkOkeE5FUP+MrX9jB32wH1+LklyYiY8FYNPSDppI
 kF4WQBz97XpqFsfqe1Iythn42RkgrffifLfKsLNqbaOjUAt5z+DlrG77HWWyVZtI0Szioz5piu
 /B6em4IgJ20sxwuySAEJMu4H2Ax/AEOeHipmvLj/TYbEmXGukvAvlOTzmcR2TwOfuH3ZbKqXsi
 0BQ=
X-IronPort-AV: E=Sophos;i="5.73,518,1583164800"; d="scan'208";a="141536525"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 01:14:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnd0kC3UGPYUWJEgeieYVQlJbarDfSDI+AYrZqkyPr5IqQfLzZrB0k2HQDB6H9+Ua+RNwF8Aq4pGh8/HSzCOvocnxQyU9Pn8Py2Q+vHe0xlOTNqeUndzW5hQR2kP8YsHrm7RzTc36WCvpq6sg5gpGcdJLJmkRTpGKi5hyz10P+5gSeAKBNupQy4NV/vZ3C1kU5yijGhTDyUooW3zLRgFCipG7JT04utRViWHl1MY2Zw37AJV+zdUfTewZMS3w7pwK467nB0idPC/vJwOkHlLApWWGr+HHgnVyoW14duDWi4fyh/SgVUzzBiD9wKIBX0eGb+p8EnX3uO2sz9eYwurGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bl31/cEW+zq318/iSmF6hKOO9SGg9ifXP7a84I2SBY=;
 b=ehWDlLg52dej/ZcLzZCKup2AaLf3Pj8WzvKBRsRrWKr8BboqFUhhUIaWH42nO63vZGO7IThpXHAg/RZAwF8Ql37y5G9l0NlCImqHwWtqlsRafoGUldw8VQoBQEdAAR0yq2wMueDkl5KU5OVcizIj1gey5VXZQxsni5LQVVD2J8iwsoobqOIJLu5IGuLG/C9bT5nz3LgiY15vZFXQlRFi0CM+cx9NfuNLNG8jYCyPTOw5a9K97J4l7lkFv6BKTHDcHEUHsCE7WVEdHP9URUlbbcZXU5n6UmuifAKyXOWE00e2hD9U6VrjsNPNupTynP1aCt7V72va1YYoTsgUP8LhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bl31/cEW+zq318/iSmF6hKOO9SGg9ifXP7a84I2SBY=;
 b=LOyXF5t7FOQa/e1ebYMX1MPAMkVJ2RCNcZSXvSl3iSg0MG3xxD3AcUOxLapk9FNE4Qw5BUy9loF9lGijRCy0QTckDvC4wYqSuXUiJe5V+L8IfSBY+8y1R3mvCpJnpbSkksxAx+hyRUzTRyW5gY59Vwf1SkM5BmbvbFITzvnMN0g=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB4535.namprd04.prod.outlook.com (2603:10b6:a03:5a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 17:14:14 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 17:14:14 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
Thread-Topic: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
Thread-Index: AQHWQ22jQiOvuxhpcESNmwORkrTj76jbDDqAgABwB4A=
Date: Tue, 16 Jun 2020 17:14:13 +0000
Message-ID: <20200616171413.GB507534@localhost.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-4-keith.busch@wdc.com>
 <20200616103157.6q5ubyfjpnmee4hx@mpHalley.local>
In-Reply-To: <20200616103157.6q5ubyfjpnmee4hx@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0bf5379d-8993-4fd4-1765-08d81218b194
x-ms-traffictypediagnostic: BYAPR04MB4535:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB453514E35833CA8166BA32B1F29D0@BYAPR04MB4535.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBDLtoJ4R8TQQ+sKcvqDnwQ0ZIcojq2xVfapbOhrbm9n3Q51s8+1Og2Jb5Zw2W2i8CpSl4ahyCElJH2QPGYFh+vzRjhFC7JD6eCz2sjRd1ytlUnPRLWT35d/erJP+22e/HogJudceQeWjq+42/bfr7Vef7o3vK7+gKicEax2yu6WZCjOuCvaZLy8HTT2H5KYna0y8YGsj/2td+u2yZ94t91sAioq7V1/TZ4F2iLqR/DexwesfTvDrWQJooqOu43ivy5BVP2QCCBfX78ibsD6kpeVXSUvXf3rF+/IR1kiLCloSdRn1v9wt31AaLmON1W9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(5660300002)(186003)(6916009)(6506007)(86362001)(8676002)(478600001)(53546011)(6486002)(316002)(66574015)(83380400001)(8936002)(2906002)(26005)(54906003)(9686003)(4326008)(6512007)(1076003)(66446008)(33656002)(66946007)(66476007)(66556008)(64756008)(76116006)(71200400001)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: FETLKRZNZRDkni/6pH2MMnXipkplR0meED7HJuNkzf6S8Fi6KlsS/xU6XROxUq5ugMimLl8OrZjPEmaG2MDIMcOW1/k2EKi1GYr/FXtnLhX9BE18RGAJjHYbtgx08kfMp8HSP6YLPnQmRjTVMqruuhZ3ez2pAU9lHseRDtwlXHIhgWsWLS/HaxobWxJC2Yazjigb2b/jVNquoGsRJcmruhsTiVtHb6RGHBoSDiYF1J/eN0sDlppJ58hlKKJxDA1aBDb5UrVxesBgTWfdIOzyfbkR0aLpjn+b9B+MOr6vNDHTZh/KF8oBLLlXObQC4xBJYRqrAzBa/MsCwpLeIHrZyTiLVd8ansdjw5lbSIDKMvduw34gy0bnwwyOT8pUup6sAUOU1zA4r72/vWPg9GomNFaoM0zC6JAmmqwCjEuFKcz2eeYRsJBFjgRDP85oMq970wVFnncaHaSBcTCoOFcW1FCahnh7q96zHLjiYt39Q+dKyocYpXAX64mdnX659oYN
Content-ID: <6886509C04277545898DB0C37D7ED96F@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf5379d-8993-4fd4-1765-08d81218b194
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 17:14:13.9293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilzwcUvmlVuLlUtb7qhQOb21HF1xWPbH2lLX/BeCVTkGXrFzasAt/7BM4IIFEOUzYBhQueWiDGcesFGRutYIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4535
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_101418_258566_6E843B93 
X-CRM114-Status: GOOD (  18.15  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 16, 2020 at 12:33:15PM +0200, Javier Gonz=E1lez wrote:
> On 16.06.2020 08:34, Keith Busch wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> > =

> > Implements support for the I/O Command Sets command set. The command set
> > introduces a method to enumerate multiple command sets per namespace. If
> > the command set is exposed, this method for enumeration will be used
> > instead of the traditional method that uses the CC.CSS register command
> > set register for command set identification.
> > =

> > For namespaces where the Command Set Identifier is not supported or
> > recognized, the specific namespace will not be created.
> > =

> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---

(snip)

> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> > index 5ce51ab4c50e..f8b5b8d7fc7e 100644
> > --- a/include/linux/nvme.h
> > +++ b/include/linux/nvme.h
> > @@ -134,6 +134,7 @@ enum {
> > #define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
> > #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
> > #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
> > +#define NVME_CAP_CSS(cap)	(((cap) >> 37) & 0xff)
> =

> Small niptick: maybe move this under NVME_CAP_NSSRC to keep order?

Makes sense.


Kind regards,
Niklas
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
