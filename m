Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17BDC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:02:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5A920734
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SuO5YOeW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Agj2pRRr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TKu5VdcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5A920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=MmEHKXc0zxnB/WtqjR8m3tg2gpNfnaeuF7euJ8hMUuk=; b=SuO5YOeWFGto8AYhZBIIJsCOQ
	JA1AfOA59ExKESJlRbS7rqSoN6y2cQtob8TSVFn9+ow/DBdX+2wBvNJvf1Ktzs2Bj0E/5fnOJceGE
	4XxBlCjWU1M8B7S/lY+vTkObtx7n6NsZx1e6a8nkdNOr7jedsgZHKjIJ2abnuAUqzpl+mQmXeMDF3
	KoZ6C9NVY3MQhuqZuUlzD6PgpXdaUb/Om2qYepgsRcNiPA1hn1sg9GSxZ34vlzsiy70RUHlxVlDQY
	f8mp3/O0hpmxLxfdcTBCFVXaRjvTqLZxkemnAE/dWo68ULXWLZX5n1OWjNMvyqe6ZoBfQgr7WcMOv
	L7BbFjA5A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Gnu-0007Nt-JF; Mon, 10 Aug 2020 23:02:06 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Gns-0007NU-13
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597100523; x=1628636523;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aha1bFmnnAfPf7jYuH1cS7MEsYQuFHUf1ea6O2QTMwE=;
 b=Agj2pRRrKgBwKsSwFAaNevDSq3mxsHzihbUQ+1laWpVnfbcCG/ZyvCCc
 514enTm2Q5I9Sngdd4dBmL8NFYR7Ip+66/QM1OjCV8OdQ4IyF0bEOyZpm
 vEYQs4HUwky/xGGmfExpmMDsrhgrk+d6hcgC89Ma8Okx2Uny1bIAl/QD8
 91ovTw+LkD6/7Ah62uw06uJoxQmkvnewjvZWsgRHGJzUkie2O9dq9WrQ7
 No0nyTYvtVlBY/9qr7idDipGf0ZnVPI/3+hLmUYuIjyc9OHYPZvevPKYV
 D6jxRJzXLoKnkv2fSuGw0q/tZJV3eqVvfBET/uBEMgSU1TFdk6txFIlog A==;
IronPort-SDR: uHgXlmNsI3wJHwEuod/HmDsu+5yLh4WpEFEdU5A4HbjPO4DUy0b6rsJwGHMysxcPMeSS14F/t+
 6sY7OlnS1dVWdAPft+GRJVjwb2y8u0Vf57Pdt7SIA5y14NwZSkURt3BuCkRPSOBRY/sFZiA/sL
 oEDd92kG5mHeyhLzgLj5jXpNA3QED9cavsIhJ+7KpUsGx+zMD28ldJbtcnwcQYhQdnKwtoePvS
 dcQK/CdddwQ5DCwPRSseO7DNeB7coaL9uE/vHzTxFxclkS5NdF9HNYoA1SJ/mujYxClnZATRrl
 6+M=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144615804"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:02:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQwssZysMRSFn0awvARH1RgG8+L+AEAsIaKh3hBjjHpigQspdt1rcNYaRtTuH8cPbT6c0MgaL8XegCoibioWO9vX6nd576OM98q8MTQRi+WU12zyZ2s3sCcebl4So6fmOv4DMkFh9YyuR/DUHQLAMyLj6nBdDQRgwUTuCrwzOvV56VyUq67RdUiER/xHBqPW7zr5LQn3aoow2U1XKMBqM746F+sL0KAbcQdc4nfFYNkMIAXN9QGC0fgO2Ty2T1k4t1KTXMJX74PW+BHFAHELI9oXlVTRQGT5Kd1VwrEIukohMdQV0ecOVUK79zH3HpzYCRrsulxsLuD/GPP4V8s6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aha1bFmnnAfPf7jYuH1cS7MEsYQuFHUf1ea6O2QTMwE=;
 b=awUXt3pHELgcxpEME4+mNxA/cQjEso5W+Sk7D3v1SIBF8Znj3ax0Qaa0Vwgo1tfqmusZuI+2A+OnJzC9PNoGdWmweM52mRV0tmE87RI9sk9z9Dp228ke/fE6Vdyyd6jHuX0yAp0tGYe8iNg6FFUrIxhfJzrfzRWOTMWZFhZNpIUW4z9fjFRTzUEzpsvTzkMKgnVthd/iR4wGL4b4iMPL5ugEDxfg9tn7iU9BHzF4m/YsPBJvKbBWP2Y8HzsM/SOx1m6PXvTE8/uprn+0KUGU+vco1QduPaQ/1cPYB1g3dpK/gLU7PETpDEdChnvUlff4dWM4NIMAk+XYBMEZD8rNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aha1bFmnnAfPf7jYuH1cS7MEsYQuFHUf1ea6O2QTMwE=;
 b=TKu5VdcL73SybQOOPHNc8/S8Id/fx5eLVO3QnP2Y1nSpS7diHHKEMjZnqjwfH95ADI3KLJ8LCZ55csmkEGeXpdlqEcJM1XXD8D+/5nSkpv+p5+0iHg8xF+b74Z7nSSkQcnL+hYFpVdUsCjy7c3i5LO2iQo9hVY0Ic5exJTi8KRc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5255.namprd04.prod.outlook.com (2603:10b6:a03:cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 23:02:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:02:02 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 07/14] nvmet: reuse pt-req-done for rq completion
Thread-Topic: [PATCH 07/14] nvmet: reuse pt-req-done for rq completion
Thread-Index: AQHWb0fjb7HL73+x7kO/2BSVZjE3Sw==
Date: Mon, 10 Aug 2020 23:02:01 +0000
Message-ID: <BYAPR04MB49657549B7E7DE0D0845CCF286440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-8-chaitanya.kulkarni@wdc.com>
 <367b5571-2981-8389-a5fe-f0bea20d2e33@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dd1de91-e953-4787-6083-08d83d81648e
x-ms-traffictypediagnostic: BYAPR04MB5255:
x-microsoft-antispam-prvs: <BYAPR04MB52555E6284312ED2B4AF0D1886440@BYAPR04MB5255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KscOjkJrawv8Me9KO/F5QnGlwCYCprr6+4tycF6m24DKB43Arxicx53NUBxpxecVdyCbktGOVUwEZBLv8V+dPVcjSK2T8yCeHUPwjgsTp0/ss225/Hycr11MT+FAjZvdfdQgN8el3LM5oyrVhByqPKs/3sVsf9KCA5mnGw5cAJuHa/K856GI3nFAjifPthpL9Pv5BU/v7A1ZQz+XRJ06pJD6Qfz97Ol10aEEq6+ofVanis0f2DGiYFMqrK6kY78bx6us5BTnj9lRk1A1LRccqlS0zqOxcy7z437VvMhXdgxMDs0QQV68LRF0+PF2iyoUGlCLAqn+u0CAkrM0BU468xa/LiMxnaS1kleZeumkr7X8WOiKYjZjiqqO7k2sJ9UWkOTDij9jie5KcdqB/QCdog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(966005)(5660300002)(4326008)(55016002)(8676002)(186003)(478600001)(53546011)(6506007)(86362001)(2906002)(26005)(33656002)(52536014)(7696005)(66556008)(66446008)(83380400001)(66476007)(9686003)(4744005)(71200400001)(66946007)(8936002)(64756008)(76116006)(54906003)(110136005)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: gt2ra2+0NGBEXtGS1Wh2YHRaK8SRS+wYlSa0+ItOA5LrrXyuGQWyQnrjVCkJaykgShlUzewgZOfLpEmHB7dKN651Jv+wfgKsw/VenGj/BKAVk3B9n1GFwkEv+yoV2mQSB3RWBSTnVAs/a0BP3b++kKIbAZu9nPHbqrPNWM307DuJ6ijNJCcYRRTtAGBt/KS8zcjoa2FBf87G+DJIZ2WFA0pRTScNfEViaN++RtJpAqsLy3/N7hcEVDeLRggyy3GOKWT1OhNHWI0k0mfU4E/fi6Er3jxBCQoYfCi02yfGZs1KxH1zv+zxHetO3eLcors0I1gah6gWWU2mO6x6XK3A+UsFmTmctI5CGoeEJSqbH0b+MuM/HSIz017kwyLaIX8ad+4YAsUDa4pJji9dXNHK336YbrBuBewrtcypIymeCH99nPHzogHaf36AO7CSoVvl21K9QwFiGsEDF/0MoPwshbkKvXwNlWS0YH37EABD4xUoFJpmbpuFxaLgZnSG9m2FQkdP53G8E0NCjJ/Q8OHKnkcwpJRnSEzpGTtTHl2JrZTCMA2e+n5qA9+17MIWBFUVvdXITNtLOhXfQhAqWLkBngkwysu1dsvx/nFhAD6i3uHuQboPFQ/2FkTZzdFu0KsqBJH1T8z9zxGMMZiqStXmJw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd1de91-e953-4787-6083-08d83d81648e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:02:01.9153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R1Rh7zFFu4r6NQgTn/TVcp5xdLjic/9Apu7lA7qloCKNzGHi/hqpON9MeIfvkIQkYdiN2Kp2eDtiBrIaORoIKJxQWgBdvgZr8Yw57X70pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_190204_390201_9612184D 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 15:10, Logan Gunthorpe wrote:
> Christoph had specifically requested open coding this in earlier feedback:
> 
> https://lore.kernel.org/linux-block/20191010123406.GC28921@lst.de/
> 
> It was originally called nvmet_passthru_req_complete() and was open
> coded at his request.
> 
> I think the way it was merged ended up being cleaner and easier to read
> as well.
> 
> Logan

I don't understand the reason for this ? Christoph can you please explain ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
