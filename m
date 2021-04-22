Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69FC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 18:39:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B18861445
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 18:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B18861445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=OupY0D9ImNUTNouZXs3/gx1FS5SQb9HEFQjfP5n8PfU=; b=fKWORAZ2Hl6d6igz3MeE8H6lk
	iIupQVx4KotxHv1TGEgewNHyMGxC3i+btQtrjdaEMvBxpUvRBULONQ+4whXFsQ9it0L0Zaoms4a9D
	aufJJ/cL3yn3n5Qqt9lXbBDnlu1ocF5l4oOX+9/1/KELyjxbMBIyJoCzh4sA+CIlVHfjt56WUm1FD
	y3Rj41sZPQDIO1XJ6iurYeUTGoKO75vUvLSuPzT/6XbkY5crwNqxP831mK2FoDJ1vCn2fM6O1JSo+
	wWXCoVojIwt65o1jZ1YxNB4deudrs7xEW7S/1g4EY06dEUoW430K6sVeZmVIJUs+Leb9QUO5mHOtp
	DXZ+rY0/A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZeEW-00HG1Q-7C; Thu, 22 Apr 2021 18:39:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZeET-00HG0h-7C
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 18:39:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=+Iu0csTjvEfnkIgz1kSWWbX41utWyo3J+MHN9LSaGNc=; b=SnnswjHBn8poWxvLeIHCHRkla0
 d9N83oHMghQ/0InGwopcgd1IKT6I9H2ijWKlmpjyIIRAJAx2a+5hzx6xZmzQ1KN9HKSxV0iY5RtvY
 DuNFu1MMFV/RUAzidZMsigeIlWyXOPqm4idnMTUd09kXI6PrwCNRZhiIwo/GOrX2SfEjQPIY/Ih+l
 9ErYT+ppc6kRuqo6BdW3VP1DKaY1p3Aj7u15vbWZfyvXMf1/a9RqxnLN1r3HJb7iNqkBVJF7eVKVH
 2nwhlrWaLqPyJD3Y00jbaAOpzRIkwRZA+tz/EtTa71g+vlEhA8v4ndMYmpXHp5ozEe191GA6hCXup
 VAxffQ8Q==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZeEP-00DvJr-Qc
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 18:39:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619116757; x=1650652757;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+Iu0csTjvEfnkIgz1kSWWbX41utWyo3J+MHN9LSaGNc=;
 b=S8mvouAXTX3Vx0mszwyPySZ1u00O7fMxMR3BJnPzP2GlO7nzDFM4sN+l
 0qfmA9JUrTIFw2gvqimyXXMyV01RyXrFPkH4S0Mnqr+RAE5GF5nwxT5wU
 +O2GmpeLHlM1FLM9dep7/Eu9JT0p238+1z+X3wFDjBXqQcAgeW83z7noy
 i+jcwZFYst6WZegpfH9vOHmpHqRLSIfvHHVuzFNCHBivgwu3WRoi9RS0V
 Iqd50QwnKrznaKxqQBHMcmdSbGQRzn9qPZmbBHH2iNDpeafiimIGUR9PV
 XVcdLybUUBUcQPthIJ1nTS4a96p5KS7Od2VqQsOJRGdCq2MrjABqzL2hN g==;
IronPort-SDR: WoGNX74v4K0ne4w1TEjFqqzm0qolbcbZwz6w4F75ZxatXnN9Th7T0eyNUFCnT32+vyYv5Ivrn/
 kOaFNGFvOWs5C8eUU75wUAjJsaEoVsU/1P6u7bkmKqVSE4qeydEMK1sl8ZnuuYWlofndFJiL1c
 F3RxdUv8VNO1b5XvgZQAuTyVnE9SgPtR75vrlJGvooO46bq2Z/pK4GI4CggZEbB1h/KHGArnfg
 axwBzXay2V8k7INc40rNQoiyIElG91AmR4bVufcyHRxrKod+0jQob8vZYDuSnTMo1SvOhDwW+j
 IsE=
X-IronPort-AV: E=Sophos;i="5.82,243,1613404800"; d="scan'208";a="165245023"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
 by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 02:39:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxoNNlui/aqCtWf1H8pVIrPkVetpQVqfNIiGyv3gjq9XC2rQ83nYxg4jzJf8Sn3Ih5rSD//3vTGM0/DCBj7dBKbympSQkkbk5m+CxY8JCHB+iM7JqnQcOw0uLVvcfeQKzWYeux/YkXBYAXZrTM9YMLsbNL+lnK0WfxUN25xEKs19h7DV/4jczLEbLATiqq5RSJYRUbkp2v2U013Xy7zU4Sm8OAdD5EZ2/do42/3LOnuJ2YMqFMq7eanReGdMCH0OQPcK57gOsHZEbN1X56bVFpN47DnQsdRNcXWgrQvnS1t0HmQDn3N0xUk5CGuXGIoQA7eg39XGRAhV2r/bpb1N7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Iu0csTjvEfnkIgz1kSWWbX41utWyo3J+MHN9LSaGNc=;
 b=YzUpIFiPz/gBD/fOj+SGcMZrcBZQXwfH26GBDRmAe2d9vnzl4jvoe27E7Eo82Kgj00vK077gjK/mMsR8KCpvhqHDO/QHuhO/tiyE8cJw/CZZLoDPklxUmJUA3owKu8YJ+Ic8rWqASyVKagg8HNZ21zgmvdXDPD8n7p2Uj/CFviK7mLJ1lSdlNL/C9Cs360hzoi3F5YqPZvtppwLOijYE5sYJvXdY6pgMuzdWoCcNQCD7A2//P81VIUMOyakReYVo09dheyFLS3U4B28PEYdQjBKW4O7a/Cbg+f/DPd1YZ7Jf9Vb/cqAswvIXmMMYzZOwDZV1Am7IbGpH4gcmRs07HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Iu0csTjvEfnkIgz1kSWWbX41utWyo3J+MHN9LSaGNc=;
 b=Ze+3sgTNLdCIZl7RgigXTQqkSABjcR3H6XqSToPBzXjFpzxuBAT/XSUGIfL5zQ0WrOFwAJtglBJ5XwnTtbzhabqK8+5J22tT2yEFT5Wd7iIO7xP5HfF+PMvrM3k1Ystujzl25FhP5lyUlsELE9Zs7e3JJzkIe1l98RYxq/mMD+U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4135.namprd04.prod.outlook.com (2603:10b6:a02:f4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 22 Apr
 2021 18:39:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 18:39:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] nvme: add nvme_get_ns helper
Thread-Topic: [PATCH v2 1/2] nvme: add nvme_get_ns helper
Thread-Index: AQHXN3EYoVuiUePZk0q4RHRGDnXCnA==
Date: Thu, 22 Apr 2021 18:39:10 +0000
Message-ID: <BYAPR04MB496529A021351AFABD96AA8586469@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210422115427.63636-1-joshi.k@samsung.com>
 <CGME20210422115544epcas5p28181653112f3a66df5f5396ab746ed37@epcas5p2.samsung.com>
 <20210422115427.63636-2-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14cf4d00-933c-4540-945f-08d905bdeb46
x-ms-traffictypediagnostic: BYAPR04MB4135:
x-microsoft-antispam-prvs: <BYAPR04MB4135B9C71C819EA17C6492C986469@BYAPR04MB4135.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5YXXriVD7V4OqHd7Ur1eaX21HJdMzsI0PcyKQRYVQ7g4CNyr3do416ji3zui0WBcn87G6+Zng1Zkd154WlOGrUv1aQNUkjWWFGIFxdLYbw3+OA18vHwDn9+WcMGTK4hJ22LktGoc4PToBs8eJnwH7Ww32lonCbEYqgbxG/fFgbiAxLFSrE6wpoWgZVgKFG/w4+F/RUx6EdWqGqjTFISUu92V5RVjwk/Kgb2J+GTW+/IiFgF7mmbuw/0YBLlwDdRXThXs2/SsWLLdr7suJPvtkJObE1MkQ5KG6PNxoH1G/56pU6kGoM+ZZcBV7MHhCtk3yshs2WwIrv+rTpGp4UU7Q6lJq7FHtflsJVO2h8II8exvU7RF9uGyUAkWdI/rukNRPdjq84ikbZnmNmcq0k3VshUxs5B2AvdqlCyjK6+YZxkJep4fpfxQJGlIeyBZS7uu0OUFPT2LdaB4rw8dtUF1/Fj0ZH5g+LBbsQH/2Ca+GwJ+xPDRwHxT51zFPIMpSIzdxocj4uY6XQquBy8V+jiGZjLbjsrYkd5FhzShv48gkr7CVy7hs6GBsacI+E1rFplPmqQ6sTJb9Myt4oE9A80+so3+NK6zAEbA1aSeHzqDr4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(8676002)(52536014)(8936002)(122000001)(53546011)(558084003)(7696005)(64756008)(66446008)(478600001)(71200400001)(5660300002)(6506007)(76116006)(66946007)(66476007)(66556008)(186003)(55016002)(316002)(110136005)(4326008)(26005)(38100700002)(33656002)(86362001)(2906002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OOpm9Bj2z726UJCI1I2M3AicvJsc+GKMMrdKxansuU+ukICHPl11psrFxjmB?=
 =?us-ascii?Q?TtMR9Eg9dDLKlMgqDa/ArnzYLnrONnxh0FHM6gknp/ZP9LjaZRqPECnIERvf?=
 =?us-ascii?Q?fb3eZNU89qHyt5jsClEO1961qs/CkecO+W7L2eSEN19iueEH/LGV7tUAzTpP?=
 =?us-ascii?Q?laEWjWodeYhXI+Xs6n5YZmciGorLiehWM8P2c07bxKaS2/rsUuAEVl5wMYv0?=
 =?us-ascii?Q?qYkiS3dRYoxwmadR5yWi+bRo/wXsgAMe3CBValeAdKrps/TwYogbAX3Sks9P?=
 =?us-ascii?Q?YiFmmxqeyc0ArVyFmqwWdLCuexXgIe9EwZjB7DdgXsU438nmRmTiQzkBm5Gn?=
 =?us-ascii?Q?v5ZnxaiEvmDFNWPHwdjivD2H6oCkeciUl4/Oe3p12zNvkDf3UcC0ZJ+6ZWgl?=
 =?us-ascii?Q?uq1/P7Rii96MNovPLdwR/k2qYw6RlW4Mtj4x9ARLKuIWgZ2BpHB6Wiadubio?=
 =?us-ascii?Q?dyX+MtiTUPnqM1HKICPIGcgAvdfyN/2LrS0P8jDoqWMFoKJoql4I27hOBZBP?=
 =?us-ascii?Q?nI5vx1V7ldASk0dV5Mf0IQ2WVmh1IN//ZDH3V0iyojB0MGK3JI2ZULAbfhV8?=
 =?us-ascii?Q?MZdE0p/x6EDNm0n1oDOvNObqbKqYgRLio+06ZZ6yqD9wRb1SnllNkNOBwbx7?=
 =?us-ascii?Q?dSkAPW9rm4iEcFruX6ftIwnbT6W+3T9H9h0mmX6Vqqtn3h1kkabK1cQId+SS?=
 =?us-ascii?Q?PE9MJW8KuRipj/NgFiWOgM1Ixk5fHWNdWxRPdYJVYRsSkY0Dl1KD2Fjcrzyi?=
 =?us-ascii?Q?KQvXQVAWtMG70U95te2lF8OYFEjxuLHnpy6I4z19ojvBGW4GOQbYCSkrZh7i?=
 =?us-ascii?Q?IGjJXEb29zQeC9B+y8Porw8JY3UohtXd33aOiD3YikHa8Eco5SfP0rYxCbHn?=
 =?us-ascii?Q?BS4SbczVBODv6xW/vDgRBPXFz1C6X9BNfZqO1Rje+1YnRx59apBICZYwrMKx?=
 =?us-ascii?Q?KK/kVnO1x/SnpPco4NsNhCRAwwUDyhSaxDBU39fTLZasopM2LI6cMr3hYueW?=
 =?us-ascii?Q?kJx68NczEIoBAVdfZlByPAn777tLk0sbo1odQ8Uvq/eMm8UENedivTOsYdY/?=
 =?us-ascii?Q?q8KEC7wUeH+BDFcwVRb3PBgCDWhPl8BKi4TEFgu2rXcClXe+tEpmhD83hYXv?=
 =?us-ascii?Q?wSxjp8LzldnjRuNYrw9VA5dmwsa2Ns53cwdk1Z2rBUKK1FlvM/uZGiugHIgj?=
 =?us-ascii?Q?97Jkz6a1juV8zWEawAYv76Vdpzr/zDmHKufkOdNrBIY+dsrbglGaGu3vX8cn?=
 =?us-ascii?Q?Okj2A9O2L40bEP7zMYFRNaQZMMO4pPoR2ezNCL1/ropfhb/wPS9U6oN794zl?=
 =?us-ascii?Q?8xHFDStZDXOYeNIiQfAjeQ8j?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cf4d00-933c-4540-945f-08d905bdeb46
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 18:39:10.2335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjGxLuVlBf2U8w7aoR02PPcEv2W0gNr53d+uEEOGFqfaS2/GZbJ64PRVGBHUj+Wn60UVvkzcPMJUzqUxTDlJtI1wq0W5mkcPoggLCl5HUcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_113918_029675_4C119576 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
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

On 4/22/21 05:14, Kanchan Joshi wrote:
> Add a helper to avoid opencoding ns->kref increment.
> Decrement is already done via nvme_put_ns helper.
>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
