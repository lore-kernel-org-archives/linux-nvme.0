Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6508BC48BE6
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 03:25:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02976137D
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 03:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02976137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=UiBBL4JzqLS9QXv4huQrhum/ORDjHtkj4SS7AFCwq3E=; b=Mqgm6pH4TFuhMG
	MpIx1HzsXoo81noNZuYFt03JLjabZHmNMYIRtAP0436Cy8RqqTH2Wzq0dy9gpIoLcsceEpSTXwChS
	aZsdwdyyFcYIsCpLub2xjpTGvT7AjAtw04Kqej9D2T2CHWQjDvD0hvx0bb0F/PuSxisYuspUXkGj8
	poQ9tuQjqFoDKSfF33ciOTrKlgN5maEWyp57J5i1qRmTMxfjUzIz9XzJEFxSOtiAXwyGWe8VHw/jU
	kUzVozrM04rDn+qnW5jU7sQsciRh8xEo6YBJa3q+whCShK6DTjeM2f2x1n5ftuLwy3/oCyoLqdb1i
	/7UEOfL2hFt9kvl0C8EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsdEO-00CEQz-2R; Mon, 14 Jun 2021 03:25:44 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsdEL-00CEQO-Pu
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 03:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623641142; x=1655177142;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=IgDbfEvqrzwRaGtDvHz1tzvHhjIUWf77DWY7mvfEqQo=;
 b=pb0StykjYyc0Zs0jssQSBk8437MsPaMvsuD5hMoU5JZF2CCej/b0+rxv
 Sm6IgVuHqLfkHmW9pN78xrUXJXFoTu8Y6i/+GAJ7JEbJs34XpQmmsLcQq
 m9FI45cbIbbxddcr50V7C3nclRNqaqQ85ANZ/3hAzG2D5luhGxj7w2ZdY
 hZ1IE7fMHLz7d6dLSSFfeivTWOEwR3Y4KTT+ihA2TbXqCCXWSCpfB5rnv
 6kU9rXqQIouPUil2CLWGfZfCl+eeAMWYoy6ZGe8KMB49K4ys/6JISovh3
 WL6ev8QbJyRm+kuZ/cKiZ9i9I7d21NKIzFV/pJTpSuN/lQyKW1M4cwHL2 A==;
IronPort-SDR: rCZGnxlCA1yk9hhtBNzs7lQmGwTyKkMx9O51s/xPhcwyEr5OHbD6Fc+jXXVvr/NMLHnWBdbjjW
 /+y40YweBHdXKi68uvWg9wxXOGmqtpj1+fX/D/p1D3QvO/6NDu723hoCnyEwg8MWZaR35UuFpj
 9Wtw6daSPBkWBdWFHEkWhEWfX/KgrsVYYv0leI7lkX3E1iuU/lcA4A9B7Ad0eWFMlS0WnuVWHm
 6ZoZoqgf/o0oiugvNXZk/2CrioJJqEKNfUuqs1UuU0fpdJYKTiZhDB80rcEGs0pCwf5I7sPYIH
 izI=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="172345355"
Received: from mail-sn1anam02lp2045.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.45])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 11:25:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuoT+HBwAon0zzZd9iZBSjfe92xl5jpmizPuuWHb/4VUeVPpvEHf2c22tES3s0f07P3JtZPOAxgPJN4xSTaVb+VywTl8UrzvJR++1l7dnOm/4C7SgxAJQDLGZmXjTCTmxx2ctYOyCQn2WCZ2NFxJdEQdLE9wxjQB3OVm/1MTDMpmnAnQMXOmTdZNmHQ5a4Y3A0yrabVWCxolmLHlPOI+omnL6wwvsapjOkVRnmeiYXBMp0HYT77mGCRI7wSZX2y6+XCo7TrnwDvtdIQxAFK+mRCD32THFL2iWmBCtMn5pNuJuQNOvDFNqx5ZNCQWKEqCobf8FaMu+NSWsvi+J+oMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgDbfEvqrzwRaGtDvHz1tzvHhjIUWf77DWY7mvfEqQo=;
 b=W2+gMg2olWuwMJLrdzDVCXPuNFb32hVsi44vnaVa8kPzRjvZenzF/+ONTOziFr/3jdnhPlE0W9M0ceraTfDTYEt2jFrbIYZIuuEE7PIIdJMw3sYpYuM/oR7uH3HmzuJI5H5W+VgpTcBe47vdp+wpi+ub7Z6Jhp2HEmQlPPhwi8Qy/jldKvyTUKZHrFt4FLauZhX7nQH/VOP5Bil6DYmeVeOO+tr17PWhV0HLXpFHb8C+s6U7s6v4KjL0UmeIHnFwDMraEUnKANXF3+sNMqPY/FNGYI2PbGqJ8PsQ7jvlEUmWx7xOfkJvC+hkhJB4DevSdhALF75DF8aRGM7+JfuqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgDbfEvqrzwRaGtDvHz1tzvHhjIUWf77DWY7mvfEqQo=;
 b=GFzRYpBt0wytOS61HS5E2lYKcSOszFBF/mBNUjsmcXVj2aTvVOnDzx3zpo+qEmrpY3iYFQF7rkQr63TH9IO038Szdl0fcK9sRsqjPRDYNXmR+ZbHhO8yykTvFlQwYa2VLSZMY3tgRQL+hRIbOdgu2s57ejyXcyCJXVcaPD7kYss=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6247.namprd04.prod.outlook.com (2603:10b6:a03:ea::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 03:25:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 03:25:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH  RFC] nvme: move pr code into separate file
Thread-Topic: [PATCH  RFC] nvme: move pr code into separate file
Thread-Index: AQHXYMzy8BQPYq2IREKnUAJaZkAyfw==
Date: Mon, 14 Jun 2021 03:25:38 +0000
Message-ID: <BYAPR04MB4965F9348EEBA142C5050BB086319@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210614032046.18678-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04408b46-4d79-4d4e-87da-08d92ee414dd
x-ms-traffictypediagnostic: BYAPR04MB6247:
x-microsoft-antispam-prvs: <BYAPR04MB6247EDD16B3D403D680B306686319@BYAPR04MB6247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 47Uw4InaJ8REWtpFLIb4aQnNATgVysirluOn7uBWSrRpJmqPxrpxgXI3sJEf58FErtYRMkVh90nO9637V0tiyPVMDMLzMN8Hb8FH+TB5t5vOFUvfaUzp9qEt4uNJeqRheGgW8zvcxIBCYTn+fR1aAarkgtc2+1ewUo2FcZyt9jR+24aezxcm6jqv9+s3r6bURUToEgMy2Mqn0l6hbFjitNAMZdRai7e5+s65PA5s0Yro//SJh2+jJKuiuna7yHpHUJSI8BLRzvh3gr7E0n+2vfVIYhpXMJk/5Ofuh3jSkohxXt9sWu271JQFIs/rHJzNoLQ1nLZ6wrwlO9UwYDnMssPjjHxNxMGX4t65vSMEIApqqiJ/iRyAFfi+SPAu+kZgah6+CcW/cny1SO8CcuNxiS7fvBAcxtuGwvBFdOT+VDWeWMiIhrHyjmbmBbMLUVz4T2GzhmvO0Y7ViiovYuscAHBWlhfeREST1hZFq30u2/iZXymTvIf4NRRc8ZjmgjAaiMs6ydeXx0obfQ9w+mQRrs4YTnlaN4XnWPcNZO3Ybn4IScdDfU9kPCPO8mcwogsCffIdAv5Qc0jt7WQ89Ko22OaUUJ3M/KtxIYGIHqteB4Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(558084003)(26005)(5660300002)(66946007)(7696005)(478600001)(186003)(66556008)(66476007)(55016002)(9686003)(64756008)(66446008)(8936002)(71200400001)(6506007)(4326008)(76116006)(54906003)(33656002)(8676002)(2906002)(86362001)(52536014)(38100700002)(316002)(53546011)(122000001)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8bhfbf8IMFcuRwhdb2TmAOowlldImgFMtqVSQA+W0VKqzgC05tcWyXmNaRO6?=
 =?us-ascii?Q?G3w10JTM1kKDgEd649w7TUY8Ki2KiXtMlYBcjw20XlSQwxI4+5kxd/IFS9Uv?=
 =?us-ascii?Q?zv6lW0YqnW/HWBIhQaJaJd/oFpIPQry5+HwcvZqsho7MFOQNs2xe56dOX3/j?=
 =?us-ascii?Q?7hVR+OVksioS3SuhvwaYhk+ohLAYw/advoT30/tGl3ak5vmZHbEKlgLmn06c?=
 =?us-ascii?Q?QlFhSkvFNN3dL1quqhxURkDo+eF9DWQ86YJbv3UZLypfR/gd2JbJn9kJ3Ujf?=
 =?us-ascii?Q?lVNeX60tZlEnTO918wPmSfIzUmSe8kIrnpjfFBYXarpGBpCEnNHmmzyETeEW?=
 =?us-ascii?Q?XnzOk+xk+kLYgnFFtrVTn/DJapWE2hmT+fLGQLv75tcERT4kUlrcs/HZCUr2?=
 =?us-ascii?Q?cwvEJIXzhBwY8mJlsDMFcXx8UhpYUHBn4vzpyRSq+glDvEVudXxdJKq/e2y9?=
 =?us-ascii?Q?R3A72Ch7S8iKfCMgA38TXB4yoBnB+BhzIWSbyL5Tv+65fiOHV+OHeMUesMY6?=
 =?us-ascii?Q?+85qu5/jAwKWRy8d0AzmuNGYiWk3TE5oLMYN/fWcvZwv3ehF9BpQSbEQTsk0?=
 =?us-ascii?Q?aTJMEc8FTSlbnzxx5D59WF0mu6euHHY/8hoaarwQLuZhyGxyqruotLjHwZlM?=
 =?us-ascii?Q?O08SLc/WbNNuJhfGcVacAMe+O45E8hlhg6O7PlRbANsgsr8Qoz2mfBNKFJm7?=
 =?us-ascii?Q?hURHr3ULnbU7nTTDZs1ACSNa4EO0mX96V2MovS2nBadwOUYCZs4cPCLgdQts?=
 =?us-ascii?Q?sTYN5tUuCveuKEcY3P8U3tTNt/fQGF8iQzkERr9NRMZQ6vjuqSCdAXohBaIl?=
 =?us-ascii?Q?NJ0pF+5zzvKK1t8Bb3GNdUvvcmAjhmvgnOV6ITellVBKw964CMpyd7MZQw/P?=
 =?us-ascii?Q?0m5rjPNqc7xCXXtht1ssZEeoWxMOAjme8sOhW/j6VdGi98S8DaO4uyVJprQA?=
 =?us-ascii?Q?LRjaKryC1QWHCJx2VbSzBQK5MGOxIa5FSKfBNrbxRRYWeShIxmC61f4hilS2?=
 =?us-ascii?Q?4lB/BucolTf82t7jpCLeeUhW4ZCrak5s1EZ/z14sKBy2NmLMnadPzwJmXnwi?=
 =?us-ascii?Q?vayRd7mw5FSMa/aRM1f1js5unPcpEGT3VEJ112ta7OL7sf3GKCF4QuSTgkep?=
 =?us-ascii?Q?p7Zlvbscs4owc+gTH0B0+swxnTAHm0BQLImBkt/jI87HYdfAkfvHtdeUPqqf?=
 =?us-ascii?Q?iQvy5uH3peqyVjio/RrTiGx7Sg+8AlN5HHl3eJY5+97lpyaWHwjSNG7W5BiP?=
 =?us-ascii?Q?fMu8aHtdaL0opWPjP5bjoOEzV5mDOB2RMJDCvecy7hvkcelSMhdNdwJ9LVmY?=
 =?us-ascii?Q?vg+1Gu7XzbgTVdPRtBp0uWmF?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04408b46-4d79-4d4e-87da-08d92ee414dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 03:25:38.4331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zK39LXw7ISqMeKHaE3N7jezNknIj7RI0hUnN7OwVIgcr1jxz1JAf3UY1Awnwm7Z4rWHbFPzLMyKhkyq1OxxIWYli+r30jGhAanx34dr8RbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6247
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_202541_982002_F66505E5 
X-CRM114-Status: UNSURE (   9.49  )
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

On 6/13/21 20:20, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 OOPs forgot to add RFC in the subject.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
