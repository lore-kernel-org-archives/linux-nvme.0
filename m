Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B72BC4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:29:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597C220714
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VmysuuWP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Pt+wNoYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597C220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3fSD7XJMIVBdr7Bl9Wa3DVnHVNb4wDxZy+TXmYS5/FA=; b=VmysuuWPD70s5b
	6uA3mKo0nKWs6JEbQB8Uzc2Y6I776BSk3eUIUgJX/Xi8jKtrP8fgPpmTEp71/2ZuwDUWd74zhHG4S
	/zuZq/8O/tnzqO38A6hPxd72qf1Vh+/pQn331O/QyjY7V1HqeYAmVXi9fYt/Qk5UQYQ/NJvvK9CFg
	m1VPNtc5G8rDiN282x+yfyaSEFewqUUpdz3HiJmf428nc7xMq4CKtzHEsZ4JbaKrYKmv5TLqzTZNH
	tH79P7v258EusYzFFbw/L8OWVfiTrUpXMICIdLvEVNxiDBVXpRKSGZomSkZZDPiX4s+LN1DAdagGb
	D9m2V20vYFn6aZIrLBDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGWVI-0003pv-LU; Mon, 23 Mar 2020 23:29:08 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGWVF-0003pU-H2
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 23:29:06 +0000
IronPort-SDR: lZgOqSfQxhkoQiYvCJb6ZwakXBak9E/8ixZmL33N4q6jprBvoPxzexQ7uRmINyFICZwcuZlAj+
 0XPxLpKA76xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 16:29:05 -0700
IronPort-SDR: 7ZNWVSRg4gk2ai+Bofn/JAUAci06veL2GOCMNXwFGVLG4owhcTYbbSi+Ud9DgNS8DAIBQL7V0W
 zzSpBXFolH7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; d="scan'208";a="446001609"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2020 16:29:04 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 16:29:03 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 16:29:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 23 Mar 2020 16:29:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3QEzCdnr0CPbSGrlYh28+bM4tvlkT+1vH3f9r3KQIi7iMK9rfIM6I8Js/2TZpzYKEnGIJK6DWa+JCtZaIgFioaFiUUpNm+cKXJet7cUupXsUdUH1BDxYe3LkstrnUllBVmlLGsuohRtuGti4JIGV+Gnl2WRjhdJbxuAfeIZw6+a2LC/9DfU9i4/ZKemOpO+QX21yqA5Lbzy06NU0OlEcIoHFqyGeHP/VgMO0R5GDtd3c3fsYCu3esdb7HsklL13ZVS8D5yghbl3Upb58CU32xr75AsLNrUux6JzssaOVsqL+hCN3SI3u+LJscdiay7HWfwHvVLwJGFMoMD9FZhyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK+gJ3XamLq0LWue4vZo74mz6ghQgej8Lr8kHCFo7YY=;
 b=ip75G5Q5vtgNFpKNoKcBE7fA0w+tTVlOywcBJXh/0lVYTfE88ZuaD+zkehXInePp+qihC5gowly0eADH2RMpGABKLGVijbpq/6PN+IW11iZaFwvF2pMkgfDFyTvGoOCxmMl5HgYhSuo3Yc9nRZYG26IuZI/Ueh8irm05UAbzSiX381bj+MChmr/gfxqmIVibFcsJk61IjLoW8AL755JvvpBxQGCDl/BhDiypEyAOerViy65orEVawdugQsDFb2N+zWINoewmEYdBCKjhg0NLP0zU7WLs5RqRwGVJtVymlOiYtr9wR1sGE0oSiuykbLsXuXcpW7Cj0/gnKavK8BY4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK+gJ3XamLq0LWue4vZo74mz6ghQgej8Lr8kHCFo7YY=;
 b=Pt+wNoYAbiSrn2bYlO+FMT3TKUH3AVQTi4ypfDRFwyAM93G2yy06eF+KrAdDJG7D4HSQPsdNoz7j/mui/xtBaonmPr6nx2t9gMnVP1XLo/xoUn3FOdbmPcdFXqO7gwA6sglrPFsYPgSdh0uRn6yPNvcNq5ndx5KFReDA4x5nnEE=
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 23:29:02 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 23:29:02 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>
Subject: RE: [PATCH] nvme-tcp: don't poll a non-live queue
Thread-Topic: [PATCH] nvme-tcp: don't poll a non-live queue
Thread-Index: AQHWAWBXl7OQhxod/EGiJbHYt5ZFWqhW0NOw
Date: Mon, 23 Mar 2020 23:29:02 +0000
Message-ID: <MW3PR11MB46843A8A9A31FA57976BF422E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
References: <20200323221315.16120-1-sagi@grimberg.me>
In-Reply-To: <20200323221315.16120-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [134.134.136.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 922551d8-f395-47f0-5af3-08d7cf81f865
x-ms-traffictypediagnostic: MW3PR11MB4729:
x-microsoft-antispam-prvs: <MW3PR11MB4729BDFA65BC4E6368EAEC16E5F00@MW3PR11MB4729.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(346002)(136003)(366004)(316002)(6506007)(71200400001)(26005)(33656002)(4744005)(186003)(66946007)(66556008)(110136005)(66476007)(86362001)(76116006)(66446008)(64756008)(478600001)(5660300002)(8676002)(55016002)(8936002)(9686003)(7696005)(52536014)(966005)(81156014)(81166006)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR11MB4729;
 H:MW3PR11MB4684.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wR92FKmNuVECPz0X9nYoDYf40Ff3l0exX0X1h9lKn4+ZFoyttAfGa6++owcBwqLSN1lgi894rDIA+pC7pXFW6hzXKUWAyQVTcbleCfHEwwEJAG3RrYFJv0hCSWydBL788l3UJhiFq69MUBsOBir3XFkSmkovyCmuwGahFOSifdGpuDO+zTV9BqZnC7BT+4cnu9bR2W14uvTHsPCo8pBj9mvddQiPNywAmrkha8Q9BW3eul6gefvSAn5Roaz6Fxr6O2wz0Nu8QYaBbrDKD0cptJmwp4cGPTCvxH40qQe09lwYlhKAoANe9hDvb5ZBSwKoe/Uo6uiM0pIK+/yRZa9wmL36+frJDvA0SyFwd/J28bFGn9LBoVvEdWgr2x/AW757lw2kw0yappZKUUXPLaevQuTTZz1jIPFbkcaBy7dO7r1opa2swFsghhbAy/ZiWd18i14pjaCRd3F2QfDIzGST1+/5zuZcYdNrviEZUU2P/haEGoUKHeJrbIOACfzDTA4cFpKf7WUm1kOoN4bBKRn6xA==
x-ms-exchange-antispam-messagedata: Xuxs9a5grP/dpOt4OFg6Ctr2zSRfLnCnpbFycCHEF8sHdnZ67ZxBD1+GWeAA9nGi0Of6uZ1gLKFk8DHD+Cpq3APtx2g7rmoMrb5J+tCJeITrmzSpkTCKdZl1ca5Y6h1YwIasLgoQRNUHcg6G+beTsA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 922551d8-f395-47f0-5af3-08d7cf81f865
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 23:29:02.0939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4ffgdeI4wlthnXfatcBa8gDPrxn8MYicceE9nw1EG/GHFxeVTatrZgkhMH1T9cxNhGXfI2/h8eV3W9ID9mS3MrmH89SKl10Lc02HEWtZnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_162905_582359_8CB84E15 
X-CRM114-Status: UNSURE (   7.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>In error recovery we might be removing the queue so check we can actually poll before we do.

>Reported-by: Mark Wunderlich <mark.wunderlich@intel.com>
>Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>---
 
Verified to remove kernel fault caused by invalid pointer reference, seen during large writes (512K) and queue depth 32 with batch of 8.
Tested on branch nvme-5.6-rc6, after adding patch this patch on top of previous patch that adds POLLING flag use by nvme_tcp_poll.

Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
