Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD3C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 19:16:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A28061076
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 19:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A28061076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=WwfOJO0reUK5SjlpusSBKFL+farwBP/QsCMKY73Pvnk=; b=S6dt5XaODOzYbH
	XQvyI5r56cln9+/xuI4FrF/RicKWHTWckqaErFakFtProRSitghSQPbYZ9zbIR6n4syf8zC23eKTh
	4GRsKoD2maSTqHV62QwsMhC3/LERmfz2uVWjFh4r0bYuWLfaYcJ1vwQoFxpPxPhv0AxyUaB3RHGtz
	lX7Ihvl2TZITkQxNoJZLMSXXJ+Pw4EY9QZPD18lZx5tiT6iY6gu7X2fhbrfRKNTFrEHvTJq5mXgQG
	P+aBcrXfd3FGvGtJDpdLpVYIgNIHNHnbvYFTX4J4VJeZxhTC8447BXT8ImSrpRxenN0ldl2KrnB6T
	gqGgfNQ4sNWY0V5gOrlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lss4F-00FpfD-Kt; Mon, 14 Jun 2021 19:16:15 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lss4B-00Fpe2-JB
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 19:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623698171; x=1655234171;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=W6JxG/IF3QY3tj5PS1LeRxhFNWBkkmyp82TWJIm6vEg=;
 b=K82TqPMWB1WtAr+oDQuVLKuKhI5XhTy4G3EpdhBxXcMce7XMMCtmm2pK
 NunF5okSoCMlezplF4XfvyACXw0cwh7THU6THufkjdfqa0kmvNPt4UbOe
 rFs/OcQFmuxshD+e3wmrV3K96RW1MNJ5KhW+YMhF9cq2VzAagpNNYj1nz
 ElRmMPfYngZRCTWJoO2j0RPTIPkzAqn91vF4Ghxpwn0BKsnw1J0fZamQy
 bhS55AmZO0ax8t0XlIR2tjgyyoQZ9xh+mUzNcB7WlwGJxwC6VJJSGJvnN
 Ks6MAuTdT/7dZ0KjATEcpkpmpQ/qcvKEq2sxqOtzE8J9Phu6S4gO/USKa g==;
IronPort-SDR: HFzPovhU27iFWEFnztzNQYyZ9uz8JqGry5D3kmAsmleHnDWePV0fFvgs+38LNqOQFhPS0tyM+Z
 boaXlksJvjzU5YBq99IP5zXHbBD8aDjgjUSaooGpYVlQJx491fZwD0qpXmFJWQGngJ2kSiSSa5
 a3zuLMDXd9tLmUQ/cHa67rue0DkYDOID+L8WKHG401TwM9a0owGpy0EOs1dC+z8iHaA1NPuow3
 JDZgMepMMoEQJ0HSG9UmpZqc50p7PPDjRTkrl+of140ZeDN9gLNYJhJuFLJU2SMIFHCSIMXArD
 t2Y=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; d="scan'208";a="171135141"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 03:16:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK+bjSHv/0ovpaPOIyFJALJLYNxOrci58ipEhrDJLtHhmTO3REtSLxHh94Qj5niFHAoMFiBBh8xpCMlYA7CQdY3KmKbpmwpN88wiG39t17LPIz62ozAieJs+rkCkI/Bh0s/DDbbPXvyCOA0VBWgbzb1PVlKsRaC62ki/hZsp2X6iLoQbmyO49ap/UlUKnSBmE0XqrVLbG/XjJv5IoI/mNdCPa4fPAcHEBAWk7ZGtLoVkKAuO3tUjtXruumwxmFE0qqXJB3gGCDoDrEUQN5+h4VkbmrM6LV80EB2hdir+1oP0nydKwLdAT+xYvaRQ9ZYdZ6BzYTQfbDQwHkHF5x1imA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6JxG/IF3QY3tj5PS1LeRxhFNWBkkmyp82TWJIm6vEg=;
 b=obzgnkRi4mYMEBIfn1d0bJ07t2RHv3Iw4YT3YsSJxzMcJugJ2Xfy8//ES+jZnzRPHWsNdyphLHel0KWSzOj79eDDqPXrUu/WsobPtEratdY2GhymYMBJUWosligKXczfk1KixyufqbN9wEXTiWi5jQ5vvT6hr8B0tAOju8tBBW2Hk3dbPBmZphjLi4pr53u42eBdQGMkoZMcivO+qQPrv8Wq0rzu0UX60qWJf3VtlcEvLJjAiK1yyVTceXzkbxJ2BGg2pCUlj+dcDUh1UDYx1QOAvTe3u3A+hrOUEOsDYAzbqbKYkwAFLsGhL6EvJkXhsJE1WWW44+KybEZWKZNLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6JxG/IF3QY3tj5PS1LeRxhFNWBkkmyp82TWJIm6vEg=;
 b=CJKT0q00ve2Y6LjBdwXGUcihQuh7f7C61nMtb6HLFWeU0lPTbB89WRJxSGSslfosm5hQsQrWL+Qpw2e8Zqo4SNV0Cx8OLPtyd3qKuYVKS9t2l/gnGMJf+HUj+96m2HAc2NFbtg5HsUctpd92avZeaayQ8HGMhncFbaoZrfbZg54=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6552.namprd04.prod.outlook.com (2603:10b6:a03:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 19:16:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 19:16:07 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvmet: use subsys->max_nsid to report MNAN
Thread-Topic: [PATCH 1/1] nvmet: use subsys->max_nsid to report MNAN
Thread-Index: AQHXYL3tZ+FSvdFKeUC9HklVf6M1BQ==
Date: Mon, 14 Jun 2021 19:16:07 +0000
Message-ID: <BYAPR04MB496580065E9548EEFCBA581386319@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210614013754.37940-1-chaitanya.kulkarni@wdc.com>
 <20210614013754.37940-2-chaitanya.kulkarni@wdc.com>
 <20210614112126.aybtimgev7okdkvu@beryllium.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ff312e5-f507-4658-2932-08d92f68dc78
x-ms-traffictypediagnostic: BY5PR04MB6552:
x-microsoft-antispam-prvs: <BY5PR04MB6552F0202673AB3E547F531486319@BY5PR04MB6552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJYT5DyLNT48sGcyQUqRuYrcux1juHm/DIQ1ylOv4/1/7FbEGJ3mSVUGcWEX+oosvWR6KNmRSST52qntQxm3tsZ48HGIyCz+K0nmUVGaC530buPDSDhH1esWE7VMe9e5EUSnaWvXgR9IUkTdo/ZL1zWZ+ucaNLsx4imBkmUdz4wQoinabdPVLfYjzUVYVKd8v1AFGeq3DT3m+zEIJELFmks5G6nt01mEXWgwlvx9G7+i7eOx5R2mp3ACYbXjIFrw+rKf3xrkNdWy3oiFFddcdIsndgCWvzsobuEJT3wtsjn8kLYWAMDQ7qJxTdrm/AtTDNPqwQUV8tlB30BE1I9945gX2dt+akvbn2xw+mVFZtdnItfeX0Oiy1e3dgO/9SKonfV9hMwWUaxNi5eM8uBBxYHbA5qN+SwTm96s2pdIXe60kbLd1dWmgt7dpRtN1Kj9rzZqsUgECnoG0WNk+7aRq8mBpP8Oht39tIUppBYQz0Mc1CBTnt2kFot3kWrT35eiO0wvenZlsOJcEuCwFfGbmxTzFwjJOiaRPYeVUWueKLiAYeA3yGZwKldiN2BcJTyNjfd9ygZ3IZicNGiAlMHn64bP1+5rZ+8J4MBz/syGJWc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(4744005)(9686003)(8936002)(316002)(52536014)(8676002)(55016002)(4326008)(54906003)(7696005)(33656002)(6506007)(53546011)(5660300002)(186003)(38100700002)(66556008)(66476007)(64756008)(86362001)(122000001)(26005)(66946007)(83380400001)(6916009)(478600001)(76116006)(71200400001)(66446008)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C5kmUSavKsdrrCoQBWM5JDQ1Cnvwqqj9N+BHhJQAzE3UmT7ccFhTBenIPeES?=
 =?us-ascii?Q?Vsmq+d2tdoa9j5ZPHvkcdL8XNemXxbDvROrxpFko5cch6vuLPhvSFgA9yJ8b?=
 =?us-ascii?Q?I7nrVvoEaajzouq0xidph+EIwyjHaoDYfs30W9eRBCuINjff6ETFcsREsGfc?=
 =?us-ascii?Q?yaPPfApxgPQRcSzPo25NHZjfOQU6YlynbBjnZHz9hd5SIVGGOGagWoSHhSe5?=
 =?us-ascii?Q?7IM7WhTAnqdwD0U/6iZKhoqUPkLa29bJU13U0PsQ6L9+7jHoaVY9/+cCjznC?=
 =?us-ascii?Q?xnhy0YYfs/sKIbsIp+6Y2SC9dW0E7ZJae2f4Cxvx+BCQrLCeJvJu2rIsSSmr?=
 =?us-ascii?Q?HkG5YcG89QojL5bYE19/GhPZOBembpRqneAwKNTteOfw6XPybwB754CYG9L6?=
 =?us-ascii?Q?HgUIpUcT2dokN5Jo2nBTlik8r8WJvdyriu5jiCorIdpDcZe7Mb7nxv6tQAv0?=
 =?us-ascii?Q?51c0FyZZIYFbIzJ2y6Q+Abyr7WXwY1ow+cb+HPHZdLR6/dw7q5G3aNUYw7xf?=
 =?us-ascii?Q?2IN71j8RvEnuxY2THWozH6Lv5NAm9gZvd4sHWO9pYQv83/dVYGQpoRfK3z5U?=
 =?us-ascii?Q?71U8JtkD0noHwQ8hWrrQD36Q1tHwOwDWcxKyVfAg2ZzFpwI5LlPUBddY/Hus?=
 =?us-ascii?Q?7Ruz24aSQFuip8opmTC9H4REjoPADASrk/qLI81JmdUGLjLViN2y7MSngL/P?=
 =?us-ascii?Q?jPMP332UhZcmoQ5aHm7CPa98mfrM+q3e9MM7vIObqPJ8sKnNSJuyxWTkMX0z?=
 =?us-ascii?Q?unk93Uv1UMwhUVlWlb60YkJ8bqCIByuUHCXbSRkaGCSCYJiNuSNuwDRI9Mzq?=
 =?us-ascii?Q?AZHu672Q+3S0K2BZKq58cUTHdQKqt5y3TIOmi8RbzlWKKejUXtlJU1JMMZ3R?=
 =?us-ascii?Q?4MROA63VaCITZRvHLtXGo6Dm5hFuORMrL0/Zd/75MepWlRIIVq9IZx47cwlo?=
 =?us-ascii?Q?aY+oQBZcM21+c2VHzV0taTTIahhEvWAbZZzKuhtTq8e+G9W88RZaClOOvcY9?=
 =?us-ascii?Q?R+Jd8ZJhtQsqxh5B1Nf6OJ7duL5IoJzAeSHD2XqULe2qaxObI8ujB9XMCI7W?=
 =?us-ascii?Q?z4s5YrS/6R0KDJQg/74Wu5YRcQARs2fAVcYsAax2EAlD+GNOnDzdjoeMeWNd?=
 =?us-ascii?Q?LD/2os6PicBKKXuWcqNqGRRnOzp3h6SU3lmWbXZSdhX9Xt2qzvMyCiu/9/9B?=
 =?us-ascii?Q?DtWyZI9n9ngYfj4DwxBrxAnM5d+zOVoAr8dZTpX03EpywAZWzABKMYbyeZIH?=
 =?us-ascii?Q?GIxg3zvzi9zTkHYm2fbOB3z2Fa0LYVjwCcQFyLQ/vkQfKvtrD/oubq0MThI/?=
 =?us-ascii?Q?zsPATAkRMpxNmqdzbeQQ0nF2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff312e5-f507-4658-2932-08d92f68dc78
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 19:16:07.0283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXHAZdPZMOPkcyqODrQ2AB50c8kSE0lxD53FXf5hNbHw4JNQClHkHCTjqUnBLWe1arEL1aaw1nA+aHV9YVemd17bb8FstMzeCItdBxtRcz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6552
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_121612_993379_725B27F7 
X-CRM114-Status: GOOD (  12.31  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

On 6/14/21 04:21, Daniel Wagner wrote:
> On Sun, Jun 13, 2021 at 06:37:54PM -0700, Chaitanya Kulkarni wrote:
>> For Spec regarding MNAN value:-
>>
>> If the controller supports Asymmetric Namespace Access Reporting, then
>> this field shall be set to a non-zero value that is less than or equal
>> to the NN value.
>>
>> Instead of using NVMET_MAX_NAMESPACES use subsys->max_nsid to set the
>> MNAN value.
>>
>> Without this patch it results in the following error :- 
>>
>> [337976.409142] nvme nvme1: Invalid MNAN value 1024
> Is this not the very same patch on which Christoph commented?
>

Yes without the rest of the patches.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
