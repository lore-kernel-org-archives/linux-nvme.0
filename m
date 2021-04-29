Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B1C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 01:18:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56F36143D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 01:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56F36143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=MhpX8GcOwQJq1f3LLZ8D6W+IhvUyUSFhbYU4INYLjPE=; b=TxI6HRjt/nDtLb24PJb4xWHqE
	lvFlePzvJ7KXBuxNiOI4mO7HDdZezjebd3umMxGYeFZiTQpwiYNqJRurEiUsjJPmzU9NGddFZ1hEX
	w8vxo+Aa52ceKJnW+Zj6nron1YhDLBZwZ0P39GGaZKm/VRhE2g/pSjSM6j0ch/tbrePfqIVHHgOQX
	mWOWRfPM/euCgCpFmyCwuGLcreSOz7e0vdNJepzt0632J47/d53x55HEVlDpBKm9fWbAiHpTydUQE
	NFug8rl0ONmKv6eUblbBbub5bFFS/DtL8CkaD+iLC07EzYFlYlHMGjwmA/ylj59i1nQ4VzFvgGbO3
	G+/TfJR5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbvJt-004bu0-4q; Thu, 29 Apr 2021 01:18:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbvJm-004btg-1t
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 01:18:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=WtbpsDp0rdMto7frhnJIdAjAT14EB6NXsaQcDq1uJGo=; b=01Vj/9+YjCcItqsnOowTuEGbQh
 trdV8za5sCMCZZAfSQgmQ0SxHXhke6ce7DPJDeeSpsywiG8rJX9bKmlDfg+JBgGfJ70C5iX4ETjlp
 TTEe99Ulf9TIXXaPy/7fNG/Z7FtkBa7wPg52V7J20bDvIt2Udc0E+1uGdQBmzD5M/07staYIcPfUm
 O/RQdRJJS55otpLXJUhV6WOAM8y/x+CroI2rqMlrLiklvMt3+ogtsMvbgFcOrI0E8U53vvfKrnnHj
 bvEtc7qAAqZqcfXLFXHW5hvOayehVFt6mPOXJrmK+acMs2SwDPbGwh6NmQIXmKc9P4fvHtdyKqVWV
 z/CJNouQ==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbvJj-000J7r-Bz
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 01:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619659090; x=1651195090;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=WtbpsDp0rdMto7frhnJIdAjAT14EB6NXsaQcDq1uJGo=;
 b=NqIUj2w//WvjFrog3X7YFqX0tyu+rUTFsLiWsgO7B4ez8UE68GWcQw0I
 EHZETrcemnVcpVX+M5lojL9f6V7Q/Y+OgncYDxbe/r0FOzgrjb3Nttf0f
 A8F4dRaSSbh8ALj1WlIT4v2Ku5tZEorEewtd0Uv/1t1GFskB1SGgbXXh8
 ALrzQ5R1eR3d38you/Y9JLbEYxwMG+9aWE6n6qR2a56tbp3bpmp1XFc8B
 3voKxFHCsA0llPxqsycgFLXnBpV3Np1W1za35nJfwOWXEQcWsZon0g2ov
 ZtPrONCZeOSL+xUgDuacTKl1QhlQsLhYD9ZC1QtG0n9A9eJTKmGLtF7B8 A==;
IronPort-SDR: vBdg+/W10Bpp2UHpwcQD1itMnMhgA2gbUwEVeWWp4IXLrAyCiMFBrUi0YGXm9uaErDZXk6q0PV
 avejkMPw4Qw1zlRfLf6GO76JnkF7tL4Z9WIlsNlA9+RcPfqVnDW1CGW6xbgKhHgpa25FuymTij
 aFnINHRiTP2MkYR93tRrtdpI3v/rmNqb/nX5cvr/VxEPpYfqoWS8+9jBQqScFSBZCy7NyTo3UE
 wWpUYtXzCZpCBBtL6VGjRoylG9ZwcFgdlad3pkco0LFi6iBpKyFsGzb+xJhHg/l57Ltx05DFl8
 2lY=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="171149050"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 09:18:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfS6/FyCmJB2vjoc2Yez+hq0aSRylhTkzadAEO4/VSwjwjuOJZgAeKlIeM/4FB6N44RWvUW8D3yqKbtY3mE/t4snpwQMOP7J1q5amk883oNsuUrLkIFI7TjF+zKW4CJAd1ZvZmrYAK1CdhW61mNjM7ckHQy4xgJ8+RNFkxUBPyjj9q3sHwwoR25BcKMJT/hWt9LwUrFC52cBRLQJcMuujLJOeEDR0WsAVDHX6gaUJtyLxr4a1S57knrY7e+trAM9qqEglyW/qRqaM6I/k8Ou3Q1km6GhhqLkt+eCxK5RFNjXyvHKLxKWq4NG1fqaT2ioYkB+sX5Y/luRhaL7ABI25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtbpsDp0rdMto7frhnJIdAjAT14EB6NXsaQcDq1uJGo=;
 b=YREhj+k33oAhFEzp+3Jcei2Wgz2GuFxz+puDyThRtwFMsNWtF8hch1dnbl6ktC7R7iVD3jSURwJUDSkxu9JL3zWacavxSU3fy9wF80JefeUNZd0zbGsPfI058s1cWxJPoNb/5aoEkzRcGrgBwyH7stJoJOHU5hNcp/08sim+liOr4dTgGQIsADUJOny7AkCj7XQodFn8Yticz/thmLdv18e9cQsVPrjIuPzAP1xxxfHSnnEa9H3R+Bx/EVTUJGwnuEJokBcsrN09LNWODb+npx+YkaykgnMJDbx297czhx1gyZiqPILjKXPNQxlNxeyO0tNERH7FrT2k6wLlTlyIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtbpsDp0rdMto7frhnJIdAjAT14EB6NXsaQcDq1uJGo=;
 b=A2EvG3SN3MgDzTiAIIly7vyLa4OoAgZtHLSF1zBf+Q+zirS2Z5vIyoqTzk9Wt7Bz2rZX4YVyJ70oJQEiM5hzQ4g0jjRK99aIX6QexmN9rtmQW2DjKrOmIa0WJJ8ntLFYNyAlBZMTgU0VZqtojtNA8sysZYGI4BpnL+93aZNSQpI=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM5PR04MB0365.namprd04.prod.outlook.com (2603:10b6:3:9d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25; Thu, 29 Apr 2021 01:18:09 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01%4]) with mapi id 15.20.4042.029; Thu, 29 Apr 2021
 01:18:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Martin
 Belanger <martin.belanger@dell.com>, Martin Belanger
 <Martin_Belanger@dell.com>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPG0XeEN+DoD31UWTKCt6MGrgfw==
Date: Thu, 29 Apr 2021 01:18:09 +0000
Message-ID: <DM6PR04MB49725F64FF1012891A5FC982865F9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hotmail.com; dkim=none (message not signed)
 header.d=none;hotmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bff774ad-d3f3-411d-aa09-08d90aaca668
x-ms-traffictypediagnostic: DM5PR04MB0365:
x-microsoft-antispam-prvs: <DM5PR04MB036533819B299C6CA62245F9865F9@DM5PR04MB0365.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFDI1ehGBywJi7IxEdyPjvkAiWpeiseuoAIYTALflBt/vKkZEq3cQPF1I4gZ4c/jy04P3sGbeOR4xGdOULGYTbyv9pueStNbxxMGKGJRQ/LfIyAuTMY7M0zQje3iXAumlcU7pqCDpfDu3gmEgP0734zTAfirAsxWlK7pruElmrqbVlxxIlcjDwzWZpivrnx8f7RbHVqUMzr+/wRVH0YqS75arPE6bY4FPDRAR2WOjJLc43dQaRSM3WcSElu4qADi0WwNIM8B1Lr0Dk5aYbbsmF5X8OE/mhvToq49a8Inhu1YZxdhpoTKN6TdheeG4cf4V4CXcG/npzZpdklTEyMh3XSj4uzrKYG0LDoO+BpoatYDzY/EvUKbWGDFHhCsKOJjTgwJjIFeTbnUYUu3QgmMhf3xmmEN8iLmnkKl0xtEgAClPapCeCLddQ+fstDaMUQpeD73WrowWrpRlCm1K9FNS9xVFDmYYpXI3Td4NlTnlVQcn6bL/y+abHDzg2vf4NlnGEWM1UVmnhhXYpzXGComZ6EsXh+zeQ0qsGT4e+rgjwLwpcbsyC0nYCmTFcSfrlULT07t+Z8KaN07423k5cdbbBBsFNd2Q2YxZKS2axzerwQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(64756008)(54906003)(86362001)(52536014)(66446008)(76116006)(66476007)(66946007)(186003)(66556008)(91956017)(83380400001)(110136005)(4744005)(33656002)(4326008)(5660300002)(6506007)(8676002)(7696005)(9686003)(8936002)(71200400001)(55016002)(53546011)(122000001)(38100700002)(26005)(316002)(2906002)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LkjJe1HxBVVIAkVgoU0JjzRwD9mvw53NHynD8bMiWRjfaUlrB6Lm6WZDQOOH?=
 =?us-ascii?Q?HRSC/ExVyjEwzTyblNceD013sQRAwxAdpJ0/NDrnJPGlD/wfPCVH0e0Uhg5K?=
 =?us-ascii?Q?xLVzCnA8c5JZ7d7lcB2lZQ3Vsy00xylMVNq0BbdfDNLJIraWeyhu2gyyAjRB?=
 =?us-ascii?Q?3zhFWCovmWfEhVnSBmCFxv6iX04iwG3QoyDVKEcrxsWZP+55JLlvZq7zpSDC?=
 =?us-ascii?Q?Sc/uYnbJ/HS4Q/ET2te5K9lB2ehrKieBF5pEm8H2NBlzZYzuQmo0IahSPDKK?=
 =?us-ascii?Q?qz1Q40ay/YvS50Q9yzUh206Q3mJ7A9Pc+ExOxcFc2Hb26ZjytADd7ud1WF7w?=
 =?us-ascii?Q?YnsxNb6bDKoodUAvBIavlEiob4tWeOyP/biHJexzkVHN5HNmRaab/SgGq5p1?=
 =?us-ascii?Q?Thpd64v6X97dCnP3NWvfwrW+3+8e3dVws22nT/UuAvAsVaMk4yES13pB2fOa?=
 =?us-ascii?Q?/buuqivBgbI4Hr0Xhdf1p4JlPpnmwBGeZEIANwJ/POR6pb+ZDz2xbYrm1N8D?=
 =?us-ascii?Q?JTi8pe+Jor2apcZMDVyZreWQ/TcyGN8+sIfqG5mBvscXgnNbmLb2DpiK4dr3?=
 =?us-ascii?Q?tPlCMxcVblDjXb8ExvUCNJpNYdWYClarPjGElDucX3Yx1BUhE/23OpJsnZH3?=
 =?us-ascii?Q?NbgxvGydgQg7EREj85Uz9rQxMFPDUJaS5Gjtaki42do03IOP2uhWT6JVVk+/?=
 =?us-ascii?Q?1tXAhYlsUF4sAoJ6gHMZZt81EK7VMzRzjt++GWaQKQ975mS50Jv9JozUaXd5?=
 =?us-ascii?Q?ucEht7KMFc0PgzreDU1zH7wxrZBY1pPfv+uawlRwsyAOaoWGpXBOpom5k7eQ?=
 =?us-ascii?Q?AyV5BF2zkP7b14n3WSA0ebgoLBkQtl+ulumOJnPxy3Q7MPFkDv/uFYMajOhZ?=
 =?us-ascii?Q?Z/YpJTr17RSLJjkgj/ukWvGRjkbmofhRvlHe42jznPaN5RsNcJFi3PY2Cql4?=
 =?us-ascii?Q?i92In/4lNKErk8DR3n3rn0LnJxpmHLiFicIVaBrHAN1/ftShdnpKesC0Wzmh?=
 =?us-ascii?Q?7vFFsbNOyWtAssj8OHIqQgl3LYhMs0icToKO2OAMjvp4hV/ABDePyxZ4bexg?=
 =?us-ascii?Q?RNORnsklf+6whA+IVSlhoQfI0pM+dA46rmSO/vdl8hAwyUJyjGuc8H5fwn4m?=
 =?us-ascii?Q?ZaM+T2enMaoFfqK+JJicw3LisQgE6N15Hzlf/667JxnLbsQax7qszDUA8gnx?=
 =?us-ascii?Q?ICP25XFk6hg52kzVB97IPVeuwzV3JjwgrLbkpgZ7kLcn+B2ou25va5E6aZVC?=
 =?us-ascii?Q?TRBuAioSo4PUcjW8v4WdPjaHWnhb2MBcYcsbezVtPcIhv4GVLR68iWeU+QS5?=
 =?us-ascii?Q?N67U7zQ9A6I6K3wqCHksP/ssD1Y5CNuG2jHcm0Sfesnm0g=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff774ad-d3f3-411d-aa09-08d90aaca668
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 01:18:09.0796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3qT8jFfJ3bYNAXGHTEv7lmrmh+JXdYiDjizFsiEAyLZ+sejZ8O09AvotCCvjYI7cMD29oH/PlOpxB6Fy4YifEKCcCklpFxihe+XeipVsxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0365
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_181811_434927_20A79BF4 
X-CRM114-Status: UNSURE (   9.96  )
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

On 4/28/21 13:28, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
>
> Generate uevent on NVMe Async Event Notifications for NS_CHANGED and ANA. Today
> the uevent handler is not capturing on NVME_AER_NOTICE_NS_CHANGED
> (Namespace Changed) and NVME_AER_NOTICE_ANA (Asymmetric Namespace Access).
>
> Signed-off-by: Martin Belanger <Martin_Belanger@dell.com>
>

Please run checkpatch.pl and resend with the fixes.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
