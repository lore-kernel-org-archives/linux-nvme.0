Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF6FC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 22:24:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A41D61400
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 22:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A41D61400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=o4wV2Y5A31WyPQ935G7P3OgTNIDqNaGX/A/yLWdmEe8=; b=iac8UgHpfniOs5RB+AvCrfywq
	3JW94bPfx+A0bbOhaIWZmU+873F5UybAZRKyqcz5el0zhkZTz7ytY+Xf01IYxMNJHd6wIYXzRCVWp
	2IYdcmi2PuKBvs98av7nzDZwHh/f+ctytwiH/hd0pvAsSloT5wiHOSFaV05lGusPJdMhssbWzxS6A
	zv7lr+kUupm+MkawTmIjIbUQlCaJQtlrjocZFaDUTRzkGfmV1O2imcrDUsy8ddNhEvwtaUBWRp9Kz
	WkVOIvOGPZtWKpxBOHoFyVB+WRLYTlaFqG6Ie5B0XkydpRzvS2WZG5fdQ9zWOk5IL/774MuMi33vi
	eKTQ9yKEA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYyn8-00DBWo-RC; Tue, 20 Apr 2021 22:24:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYyn6-00DBWg-94
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 22:24:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:To:
 From:Sender:Reply-To:Cc:Content-ID:Content-Description:In-Reply-To;
 bh=G1VOtCE/PhGVUcIv7wD4agLH0nVUOElq6vvI7nvQMqg=; b=LBcCS7K7AytqufUfFsnMaja7Yx
 YlEOioXNVSVFUynlZMJCnNJN3hVtkxwi5fdRFsNHVYW9J00+eS70ugCpeufIzs2z3K+zeD/cbifPE
 lCrirONPI1t9QfDsu0/8kCEfPyAyJ11tcEfpfDN2FA9ZHx10yTGuiFNV3RuDxyBCrbCM8Lk5uIQWG
 crCyTIdotwRIj9Hq/T8c/FFLkjvLJvCjyjHqPWfU7Fizjb7N2TI6MvC2+Ax1mBeJqEt6eU2CVFz8d
 37f9GnF2fm5Zw0vnV1Uk5aEKRzEfwDKq8E9Z36hBTQcp7DoBcmBFGqKxJ2ZwGo8F7NGHroQwqtxE1
 CahEVIqg==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYyn0-00CSSf-61
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 22:24:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618957453; x=1650493453;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G1VOtCE/PhGVUcIv7wD4agLH0nVUOElq6vvI7nvQMqg=;
 b=pWCrbPsKg3nS5mFXZ5838qzQfFDttVet6mQK1s+++LWdWMA52B+VzzS7
 atMFmfHtL7X/g+IidjllA/PMoegMr+iQO/9X+uxncIreRqiftXnzOq8CH
 3XEI36o0/m9Eo5RW+5K+s3DNQ3acw+rY3TqaFknpEMvVRcONYYhKtkDQ8
 0Ys0UU074KCXAc+4crTAItDqui5mO6QMJ4q7+b+P9u9sVV5iGWvKqfVZt
 w21doxKfoy9LkXOD9Xunj8aF5HttJ5O8zKt2xkyNso+xDbqhE1zvH5le5
 1+pi8EX/l1lEVbomHWdWM/1cWB1qyIzH+OaVGNxJDb/3lWzkGqoOA5EqL w==;
IronPort-SDR: uZm9Z+o2omzgE24SBVFIXtngSuCG4z+YCc2wfiJPevFPiMpdX47ktkqPfiSGwNrnbDEM8IBJu3
 a2O8DEb/OkjRmS1m/Ag3XAMny4RymqL8YcvXdyMm+O1bK6vEwF48AMNSAQ2AgfAa3Kz358Ms6X
 lylFXUYq74NrJm0CK+uMZgx97jIr4/RNMvnK6ahPEazv1brSN8N5E+BY8ConlrP0yZuO9KUkrS
 lJi7mpCip4GZVPcHDMqv8wHN8G4+30FGWWnJHrYAG47dvEsGXPPUL2G71jo9pLBXSAo0oDkNDA
 1ys=
X-IronPort-AV: E=Sophos;i="5.82,238,1613404800"; d="scan'208";a="276551240"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
 by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2021 06:24:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0YR84/71NORusx0UoKQmt+EdKpKGcd5LHY/grHdys7DpKAU4g2QRMwfjjF5bJ7kJGzRhWGZi9jdlwtGYubk/u6mO2Xj8NeNOBgYkNdDjM6u4YcX87gAdgSAIWE5dZX+GoRvVwIe/PxhBYvioi6dCxqFynCPQVy+dj/srl1WI1eA4PxoQQAvIpHAjj5gjbMOd8ZIw1iF28r98crosBGQKVcqMjF1JKPo+BR5j+ujBfWFfkDJgjxid98jmV2mSjhRDU2alu+lnco6UQE2mL7cKMt5aU9EMMWXlU+vhhGRFd91PtebRdsHZQEla6F+qkrSoc9dPGE5GE0tgDY7wDTG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1VOtCE/PhGVUcIv7wD4agLH0nVUOElq6vvI7nvQMqg=;
 b=J3D2PBYWiIjPIDD/lO7CdkmGHvjeQKFU3VvQoA62lEIBlZfEu6s8wlxN8ro26Sa4CAWNiZR2yUwEt5pk3svG7RZKZxdNanHouOI/opYXA7qILH/EA8BeGHj/Gs4U+mnpj6CqXGYBBwBNYxUN50T3YecFJtolJp/fPTic35QLiYymu6RFgsV1xTcfrlclwcdxB7i/5lysrqMVJIGUkVPNl7WPYgYZVFFwMUkqMzmHl2RLlqntcHVUi8jeJ/Zm4iTu+vqv8BvCk2ST4js8jgzLp8KjNKvqKfsICADZjHjLoSs+dN4X34fmSA1J1zFJ4i/bGy8mOO+7fm/haEzn6HxiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1VOtCE/PhGVUcIv7wD4agLH0nVUOElq6vvI7nvQMqg=;
 b=FWF3L3ReXYdcOdlRCfdCem6tEjSGKk+GQkCZNeob6lR5Li0JckdN3wyGi1OptyJ3dCVoFAz2z2tj9plDU2OySEilcWqP+Sc/HGfBhxbDl5zLKxga5uAl0zRm3l5DfOtYgOeEwcvk5sRDXRs3g0pnm4p7m8mSW53uF39IF1ftgDQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7121.namprd04.prod.outlook.com (2603:10b6:a03:223::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 22:24:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 22:24:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Engel, Amit" <Amit.Engel@Dell.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: kernel panic due to a missing work initialization in case of zero
 kato value
Thread-Topic: kernel panic due to a missing work initialization in case of
 zero kato value
Thread-Index: Adc2E8Oiq7m3aTjzTmuQtah8cWT2yg==
Date: Tue, 20 Apr 2021 22:24:10 +0000
Message-ID: <BYAPR04MB49654DF9317DB63110F66C1786489@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BL0PR1901MB2020A15CA929276AB8FC7E52EE489@BL0PR1901MB2020.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Dell.com; dkim=none (message not signed)
 header.d=none;Dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db02c344-83f7-4706-da7a-08d9044b053c
x-ms-traffictypediagnostic: BY5PR04MB7121:
x-microsoft-antispam-prvs: <BY5PR04MB712105BF0BB361BCDA47D98C86489@BY5PR04MB7121.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xy0Cp0fiAFCCC1iTXd24+fj7iR/4GSn2EZjLp1rxuWIfTko2BElptCHZr9Ku/1gzy0MxqBS6jxp2OCPPQS9xEES08fFh1b0cuIyuHn+vNPaXbkFY4O8+nxGAVgUUVtPYv5mS579sAqlC3DCwy6yr59CA2wCW0R4wau+rorqU8T6mXHb11pT3VPEt+1u6sN6oVYWKhJpsMeA9xCuSmnCzzDKQye+dw6nMliQhZuJT8a4emiz92QE1LdDt9mnCEEQXacCq3v/AZx4VMSpfDGl1eSSnT5ObgBzbZxFg9RgQ6QiZvcoejpzOSxV2gb1lcnKn1URCdtY9azre7N/le/byDBgpY2hVCAR1U/lDLWHBcY7pknA4wGw5GlzLdaYNgkFn3Iy2xqKwGBLxOPgmWfa22BGgH80Y5ZpjfJQ+OjO3/QoKvH7GfNsJ+x6uNLbwoUvbzcAimOz7lkeDQWZxkL5h79DxVFe0C/FVYkf5d5w/ptmb6AYVik9+klvA88HI7+t8OtuEv3ME6bVvfdV0ndyBkEMkNUdUfstw3o+9chD68+LM30MoxGm4dYNh9+plMNoh3ZNRX/2l7xTjG2Mi1giECh46mUYU/BQa6BzFhDw03hQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(66946007)(5660300002)(33656002)(316002)(8936002)(7696005)(122000001)(64756008)(66476007)(26005)(186003)(66556008)(86362001)(8676002)(110136005)(52536014)(38100700002)(76116006)(71200400001)(478600001)(6506007)(53546011)(9686003)(558084003)(55016002)(66446008)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r3xCo0nVotjN+3IVHME7RO2AYn4nllU8Ar00WOpqsoQrrm1ks37l9lxVdpbQ?=
 =?us-ascii?Q?+jES9nxdFZ1pitV7nlADg5icskaucXNpPoQ+q8TQOnJtMj6fMpHDvKfQK+l+?=
 =?us-ascii?Q?HMO4dSrigWnO66kL2+ioyRnQe+e+YOhV4l/XomxHRhWr/Uc83ZOe+5of2EhU?=
 =?us-ascii?Q?+h67FXacJHqqTNHAQuS3/08pYujhy7U+HmnTcmNTls6F+UXeVsT+HXDXoqxG?=
 =?us-ascii?Q?R95fVgagZAwoJgWVuA9G5Rd1aq5GsW88NWaLRM/nAviynGK5zmPFwdcyrmNW?=
 =?us-ascii?Q?saLRp6pOGchY0J8bLXQ/mryW48+BQi50NFEzJJntJOcctYiB/R6pi56aqHW+?=
 =?us-ascii?Q?a216gnyKo2W9tOFWmBcIp7CHpmSHC7WZ6/pogp+Y0L82tTablchg2ASi1Add?=
 =?us-ascii?Q?otmwE4Smve2ofyIj4bzNMUgwiL/VtM2jxmiBpu733Cq61RjOvFXE5tIAtDj/?=
 =?us-ascii?Q?oeJaeENDpAv6Gnygu6TYPhfke52C7INSTsV8PI8rX4lOVy+ZqyEMW632uWZg?=
 =?us-ascii?Q?NmMUy4M6zIvSMQe0HJtJ8maCz62fyMn6iywH4Jud0hbCWfTEYFRSHrQQ+6gS?=
 =?us-ascii?Q?9ibWzMDkjFOVVsSLC9mXQZrUK1bXGdYPiCzrM0XNQRAqI5KXCP9RJ4In9J19?=
 =?us-ascii?Q?UsxQ3lsn1orKIrauZ2KDtOy1+Z7ZJHmcHSMS+9SmyAN72H9FZoyIAKXD7XJW?=
 =?us-ascii?Q?E6l2J1dnXtjxkkCQBHe+1A1raqHsdi4nxFFpbKVRKXQRXOK3Od1nTAynh77c?=
 =?us-ascii?Q?+tdVIkxk6flhJyNSBgjxQdkv1RCXiXLhRNv17JahpItF70tMnuaweNSwTt2s?=
 =?us-ascii?Q?knhyRET1zDcQtObsKewn5o7UQtjx72mzlUj3vIFC2RxbPveE+wA5hyY/3e05?=
 =?us-ascii?Q?QrP2OuBNT9VKVKdb6TPEoeb7xsCMRP1MWF5svVeyCAo37QVG2TXm8i3IusEN?=
 =?us-ascii?Q?7f7iWTO2uesJDoE0Co4IX7h5XyB/4/fn3/2DjFxbKjsPQgJ+TlUhfG3dtk7U?=
 =?us-ascii?Q?4IBL8xs4T3xpbGt5MnE8VRwal26W30gBd9P0I0Fp4KpjEhESOuvy/u9+Qp2j?=
 =?us-ascii?Q?zLqbAp75Rta79YQ1hikoCRjLwCGgHzv1LPEhtbqwsbY8V+vQ+JAaQUyrqrfR?=
 =?us-ascii?Q?gdyvrXNExMbupQUCM0Jyh0XdidTF59Kdj06MKITU/kU+IWr5UZsAjuPYExlp?=
 =?us-ascii?Q?O0ub4N8uvtVJiVB0YIy2fUrFXznepaZ5Ct0ei7g/C7CAFqSZ4gNX1eO8Zb/4?=
 =?us-ascii?Q?COhCjbFCpZoveZGQ3iQDPXW7cad9WJB1sFHFdb02dlgRddZhTOQjOyK9tc64?=
 =?us-ascii?Q?mEVKjDDhd6NZwVW3qN7neNRk?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db02c344-83f7-4706-da7a-08d9044b053c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 22:24:10.4639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktTZcqOV+RgEJpWgQRoY8RjaEQaOKElr2aZV/1q9BzOkYjKWv/qI4D5AIjtoFIw/cmGhZJ/C4Ql6A1XAApRXsVXz9lM2b/7qlhXlnKIRV88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_152414_351937_6ABCB258 
X-CRM114-Status: GOOD (  10.07  )
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

On 4/20/21 11:46, Engel, Amit wrote:
> A simple fix for this issue (I will post a patch soon) is to initialize the work (as part of 'nvmet_start_keep_alive_timer') even if kato == 0
>
> Thanks
> Amit 

This may need a fixes tag.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
