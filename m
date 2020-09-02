Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70695C433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 21:04:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF3920758
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 21:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="edcJQ96/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cO7nF2CX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KNJQePU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF3920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=L/EWQI2BklmNb5nY9IZ2oDuXXpaotuDLQFiGpCfdILI=; b=edcJQ96/NCTfwzGtdXGOk5og3
	ZkgW0dkF3o3FNWJLboGwc+6iZqZpxm5YTrw0wDSzOGXdLe17VPWBhKoEaEywG4f8kD6MNTXxp/RUm
	JwiZgJDrcn9rLm+FMBSemNM3YTVRVnooa/PT2rwnEZ0EPSj2aX8pTdve7bLGK9tDKAObz1zt7O26C
	SCWo4UNQ0J1t+WZZjJA/mLySbc43KnZJzsQqRFUUv1jjcuibwzeVSInHuYD+WV+A3z+TTmflWLf/+
	tkxJLhQRSPng9d3sw929vNsmWcP5XWHduJDQgdrvg5zabCRNuuRFJMwRKK/dcTuyj+cCo0dyuM/Qg
	SJyqAJIew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDZvo-0008Eg-8J; Wed, 02 Sep 2020 21:04:36 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDZvi-0008E3-Fl
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 21:04:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599080672; x=1630616672;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=OKmh2cy2VAOa9gn5z5aaJqEOJ+DUi9oxZ9iJeE0C8Qc=;
 b=cO7nF2CXzKN5X3S0T+ghN2MmKWgM3fgjXqMuhOyp6mXFJiReLemHRK3v
 7PLGxQX2JznekigPiIp/8K8BIhuMaDodIupDCCGGcFeDrwtpcohiRZxqO
 6JQssfjok1rxRGyg89XAZXGR6kd4VpR/eM523AA9D7xFDtUtxpn+RCAQF
 rAHyWRuH5E2atmsuBthKkfGTzMak7xX6gZFxv2XgGwPLieb91PTvkKKkN
 itNHMCf98h5dtygc9Jl+Nlk+dAyhBiY51pR/LgxdSzab9VVCXwJdG+pur
 3DiuDxLp3Vxa6TUZdEHwPq+XISB/A4yulnFD8eUbZ1MN+BKFMVBvxBT2s w==;
IronPort-SDR: 0Zfl8i8ANJrW9wfWkf1vqvzwY9VYb5YT48d8Z3myqrqF476kwZR9W3c+yi4AFHF+cdhiZLPBw3
 3k6l6qTLtXZeAwwX5fZlw5J049vjWKkJranF7gzXZr4bb+ETFfHwVIwmdFcobbbkh2dHUgyu+w
 X37xlorWIJNshSaH6FX5E7rtwNMpIJ0DcaDqDh+5Mu7cA7py63YnsCUySN2gMM7chRrO6qwIq0
 RCfMVqIM8ChXuZ7bjyctodGiyPdvuSs2b/fviCu8XiwVcjCN0/J74HzFjdeOI0M0ednnKabbTQ
 SXQ=
X-IronPort-AV: E=Sophos;i="5.76,384,1592841600"; d="scan'208";a="249709574"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
 by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2020 05:04:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuioprFKKkAX44MiIm9MS9CAyoEmLdvk4LQIWcE4K0/CrrATdG4ykx+sUn6XiNkk7FwDl4z2jYLgN0bdlmLbvMIVlk2x6MKGWF+2nGuJaM65OG6FuR05SUoKv9hux3oI2GxkHCNF0dqglEZyKvHyz/9O8sQdMOUQ2o1ODPyDJocd7bpTxR23MepU+HYSlbWke7mWoN+w50q0KJWiA+/8j7tx4ASJu92tTsvqdPIOJOTykpHQNT7pGX3IsesfWK4RuzcQeGGSu/hcz0gJ4UtmcG4z0OWE9M3edvBWNEqPhlwU60w0Epeb4DoFPS58WrSfDO7wkZAd7CHd6IO94i0lGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKmh2cy2VAOa9gn5z5aaJqEOJ+DUi9oxZ9iJeE0C8Qc=;
 b=Ib1E1gvNHU51D+4qjd5rw2dG1srbL+fSHs8nNiJCH2vYbZ6o9D0VQgNlKoDK6jiJYgr4GY+vDYAvJmjLCvBbj63VMgWEnp421x7Dar+n2pQLc/YHMv5/u4augJBQq5rEsCnm5NjZEJqn19BHGz3zuI5wRiYCdyFo4B3i0XhH5xQV2+JxdLexYGsZJ2Km++lAjjHyOZi5MIwdETd/lrvRYt+6fDxAx7S4Q6I6aMN42Qow0mLj0JfCYwg+jJMi/DoaNXCd9w+rjAFd1eU1CKOO1k3SvGaaU0F3Bd0SAtUOAYcLnO9lI8j/axcAgKjWhueqjF9PfbwqESxO8EQJsnXDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKmh2cy2VAOa9gn5z5aaJqEOJ+DUi9oxZ9iJeE0C8Qc=;
 b=KNJQePU3FIO1Zy1RICqOvj1Cs5mb3Pd0eycoNmvvMwTyKARChk0BwCOwODvSrWXC77iEFGw5oDgMv3F0Idqm524gVxWOHL7DRInTjdH6HzwuFQynC4AejX+MG5dlyEHvOz8zJ3QjjgJxH4eP82RMyiRnTE8mRyirpCubTJX6viE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3783.namprd04.prod.outlook.com (2603:10b6:a02:ae::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 21:04:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 21:04:25 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V2 12/12] nvmet: use inline bio for passthru fast path
Thread-Topic: [PATCH V2 12/12] nvmet: use inline bio for passthru fast path
Thread-Index: AQHWf+YBc1bw7By16EmuKiv3MbQcYQ==
Date: Wed, 2 Sep 2020 21:04:25 +0000
Message-ID: <BYAPR04MB49659B9D2DCFEB226947C026862F0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-13-chaitanya.kulkarni@wdc.com>
 <5f8c3740-9056-2eb2-90b8-1e7078492b4b@deltatee.com>
 <BYAPR04MB49657E669921B89DE66357D7862F0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <d59009e9-bbf3-b6ad-75c4-f895dfd0aa64@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83496ce5-0ffc-4cd1-39a5-08d84f83c642
x-ms-traffictypediagnostic: BYAPR04MB3783:
x-microsoft-antispam-prvs: <BYAPR04MB37832B27E991D188ADB9EF69862F0@BYAPR04MB3783.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5j+ExQ7Oc89vBVtbNrKXFw9x39x6w8mq2cGUQ9yJa4vdksZwT0y0R4Bqct9VZhYki2fircqz7ITiNxZG8XrrgC0k0pY7vvpRJOGV4CEGOiwwCwdqi6EyPoYOT9IY6Xu7yxn8ujBf1QEKmoLU0nRvhunIUnNQOaLFNReAKWq1VXX+dNQC+rsOrVwf6BFBIZmzIechyBKueucdFVqMmAK2CuwsB/ZXTN9wPxopVwl+oGPPMCEJl3CMj71vaeYDZu73wOraGlLydUpO6zXctU6oHmoktlU2o9QaIiQA0Dllc8Op73EqOz9j/zdNxtddXtpJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(478600001)(4326008)(8676002)(8936002)(558084003)(110136005)(76116006)(2906002)(5660300002)(186003)(7696005)(26005)(53546011)(6506007)(86362001)(316002)(52536014)(66946007)(66446008)(9686003)(64756008)(71200400001)(55016002)(33656002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: faKLaBDQVslFpznFFlvOtnBwtdw/YjYsrUkgEI31bKEMT5nHQ1mMTWXAR4anZOfMiGkRDNoskbXp/wmCYLvhB4u6gTZJhopJGDSJ9NTiYTzWi6bs6CkddYwqvkfEIAZ0jg8TuR7/v1N0knSihb3xMaed3H7o1wZUJG3IK2RIlxBAr9TgmbX31Nsx2BKidl6vZlaMTeGdS5R/ugBIt0xX9VeqawNgQ80mN1Tjy4IyRslH19wBBHaNkVthIo+pCDbEbdopAd5oADyMvFnIyVPTApsGYAPhg1m70eoQXsJMi6EgJ6+l2wMhV/UxFYcyUy7anXTroidHZB5MqNHMx8xj/NQ2XxRgIUP4TCAb50EVnCiyrhe84QhvbGdtJvlUqO9vBhixi/cyJBHRMlotSSU9qQ30rUTMumFNzIFt2VciVl5SIIO0DodlAsq+L+41fVRfhnR1bV55HMHv0tsYqeVSXQeLeYr+b+fnd5NJcpHE+EV6RzWwXDQcmYzPj0ighSRq9CsnVm4X922UXDqI+gC9muhpVApAwfbrhuGSQbnXZaY8zqQ/lCw/dTyRabYSlMk0v67HrFMaCZwKSDPTGtxy3VX7uR92NZFg1YnYtAOt5N+F7bY71mugWcKLyXg2jhohgYAumbJ7oZAx8GFfOXytMw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83496ce5-0ffc-4cd1-39a5-08d84f83c642
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 21:04:25.5965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Tl0k3zNyPG9QmioYdax/15fDK4kgFf+8yUK/2iQBNcyZDph8Ct87xetJsvm67YBzfuACF7mtpTvFbeWPl1ifhi+oH/IB53g9d6sT7M+AtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3783
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_170432_423739_1E9C474D 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Christoph/Sagi,

On 9/2/20 08:41, Logan Gunthorpe wrote:
>> This is intentionally kept consistent with what we have for bdev-ns.
> So then cleanup bdev-ns... Doing something in a less clean way because
> somebody else did it is not good reasoning.
> 
> Logan
> 

Are you guys okay with this ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
