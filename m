Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05011C55191
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 06:07:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28A6214AF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 06:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fLdKT2hr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XVebWF2U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XAi2el/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28A6214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kz9FRtPNIN3u3wxyloHiRtfacRRuVQjWRJrKUbiRjJs=; b=fLdKT2hr6LgRjo
	E9fCWSIJ+WrRZfZoAYbmX63d7fEtbMXuEdiDRhWDNQHi73CM9us06yjlS6SjSE3le0RiwtG2hD3RC
	8MYHTJBRMVETCh4JFRdC7eOQlTtGVY9NTrxSFZh6gNaenMDvvlPv1Xms+cYgSk+IjjZZtx7hj3M0l
	XNHuBYTPo0/s1lkrDetRvviqWWR/fu9LZj1fuYyPAquudnUmS2KGZj2mhjkLhgOZQC1Hw2WG+jsSr
	zN0s12UuwXQlQ6fs+ryhQRXcWI3YOkMYa0ifDkofBrEu8/pr1pVwOmCEIpARn73I/bDfQy7kQLoGU
	Kzatz9srUGhUklBLXjSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRV1P-00008d-Oa; Thu, 23 Apr 2020 06:07:39 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRV1M-00006R-Cw
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 06:07:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587622056; x=1619158056;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=UrBd0a7rjMmqoOzH0SX5PeYJmau+5ykN0aSy1MmJOZo=;
 b=XVebWF2UpNMuGGXvx38XGiPs9OVyd/bBHbISKNv7ARsEAUWLiy/vL+2h
 T2Xxo0sGQcyhgXH8U/ckMhnBhNVFNrc/EjSjrzHD5Nuw74z1/6vwTsMH4
 TytrCX1/8Wqgb7zxqELFe8EKS7vhM5El3MFCo2IFSjjGIoy8+lOgx535n
 Qx06Gd17t1jWKCPqfrdW+dY3X9huJ59Qi7ny9tyyXVQHgl2Cnqf158+DL
 z+/WAR77WoZyvhi39/XTTyRqakr6l9AoOFFB0mRu9x9KALu3yUK8aBeTN
 ouVel2Qz4n2O4xGcbY+07QfnGQV9ucCMoAEvGK97LImC8qslJ14KyF0al w==;
IronPort-SDR: DTAd9G23qbeZgJuIwrRMQv2QGAOnvcBoe1sMLVDIcFFmfRjgHc6K4vqMWGhQ8+z2l7WPbb8tBT
 UczrUtlBnat4Pszg4PqxLUP9mj1a0nrUt2plD7SWKKuhBn0fNniUy1+m12sh2oVhmKnvi0W3rP
 U4t3qFq5pgEYhc+YzipcPL8M53DyOY+scTdjVW5FpfS7Edw69/Kb2m4MBJ7pOc16q7M4juHIXm
 2yigKT0wsIPhGkq83ouUW57fBdy+v3wP9sYkhKGYcLIWASzmWcv6Rh4LWStu5eL5SyIYA6P7Iq
 Cy4=
X-IronPort-AV: E=Sophos;i="5.73,305,1583164800"; d="scan'208";a="137375917"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
 by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 14:07:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw8KX80ChEMfvRKDYxbwxVSEUtzQTU4GmRljWvNL7jfi0yhEgDIDBHjfh6R6peAQIijYliG0e2adr6j6Pn2V8VlR1Zs59GGDC47lp50q4VXs4x/N4mSW4fqoTnlBwbceuH8ew00tbXRKCMixCf+e8PK8e3RAr7+g8PJVsSvwnnwg6V8eNoSpO7huU9+RL/qgq3jvGsZ/u+lkiH5yEnA9tmAtlm4ubLJAcKKpwKYvf8zycOokPFfaAG7y7UC5q9SLQGbIBMwnISp1Ur+MA3H0VYKObcdlreBSrTkdrqZAtcpiNQ3BLFZPe/9gYXxrfWY6+Jyv57ol8RbZNA1pRPPc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrBd0a7rjMmqoOzH0SX5PeYJmau+5ykN0aSy1MmJOZo=;
 b=TRakB5Fb2dRUu0H+DecZfWxcfR8/aP0tgmREUxG+/XREZkByIPYMdgUZrNguKSr1Zo5dzeUZB0zw83L6RXr49ED/iivhihxLLH3/lXXmGFAEgUTzNuAhIFy7OEKJB3Wzj1MdtEimcVZ1iFJjlSBV2aWxqEu21etnidMgbtDT3WhgzeSQKGabc/Z6jWqKEJllUX/XgIuZtaWPYc5t3rpWp/ZTjSNL5aW/6cXrj/BTtoUreM0eaWDc0/1uJfTEcfYgSIX7TOc3odoJvAHHxiS90muM90Wl1jl4dS8NY+FklaMADIaVj/u8WvOFE1oc2rNdRaOZ1D2JEcw05SBLOF+x9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrBd0a7rjMmqoOzH0SX5PeYJmau+5ykN0aSy1MmJOZo=;
 b=XAi2el/aZG+VTgflHvZbLLd9zrgk9LYWw6WZ80y0pFCmUw084XsqkbO7DlVk+VGRZ7LTWTGnG/3fdOHy4vQ5Kd/K0V9I9m/7vWa2r9tifanLZVBYj6GxZCc4KHqYAQtTMA5lTkWLfqdmLOkhqogvsj7+pw+VMmvYbjKwFQ1hQnM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4165.namprd04.prod.outlook.com (2603:10b6:a02:fc::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 06:07:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 06:07:32 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] nvmet: centralize port enable access for configfs
Thread-Topic: [PATCH 5/6] nvmet: centralize port enable access for configfs
Thread-Index: AQHWFqW48kX0AMj260WfJHFSZmsfVQ==
Date: Thu, 23 Apr 2020 06:07:32 +0000
Message-ID: <BYAPR04MB49655CB766381266CC4BB25B86D30@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
 <20200419235242.60355-6-chaitanya.kulkarni@wdc.com>
 <20200422083207.GB25341@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e40:3000:3595:2b18:c2a4:29d5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 492ded4c-9df9-40b5-acf6-08d7e74c9c5a
x-ms-traffictypediagnostic: BYAPR04MB4165:
x-microsoft-antispam-prvs: <BYAPR04MB416591D0189EA7A5EA9E894486D30@BYAPR04MB4165.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(66556008)(64756008)(7696005)(2906002)(186003)(4326008)(66476007)(316002)(33656002)(54906003)(6916009)(71200400001)(5660300002)(66946007)(66446008)(76116006)(8936002)(86362001)(558084003)(81156014)(478600001)(52536014)(55016002)(53546011)(8676002)(6506007)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtptoEijaPmk46D4AtTYXcjHmShIFuu2lKeT0HP58cfKtD4pmTCgfVqIvLA9K0JZz9b+SWKvuqLFluf1Hqvy45d5rwzeO4GS7BVaU31RcgDmNnEhbgvQKb1Z5RY/hpoY15YmTVERNoU3iA+1J7kstrZHNT9WVkp8UzWC81UkuFrCuqCksPDnPfM4i+wiCViB1JjTGqgoU6I+gjCDpnPKjJsicbFvAYDBPO3W0qpfCzjEd4/fVlm4W6kSS11M1B58q6CQGGJJ5iGC3ML0wEbgDyyJv/an5BpoL7374KvshjfQQo4M3L7VVk8+qb+6oUmHJPrXZehfvTCu7l0OYCZdj8MAjuxqqU5b6j3vOFQN8ScmxFKs9p7FhQSV6w7lgpAcriecTVw0WN9E7AYepXMrq4YfZ4GduoLL6RD31vJYMOZwCKn6WcIgiES06JJ3Rz8U
x-ms-exchange-antispam-messagedata: L8D2lQhv0bNFJ2CJPJyNAsPCLZUYvN9ASBd6xO2ImbzsptH5/7wYQ5j9G2Hd4vfS9Jx28x2VMalk0VV/Sl2t/YYNgg0VIRg4fsSfIMMqP7Qscfa7G9knl9pCZhWY9wMEziUr5z9abCyz8PQUk+OTDb82er5mrrAHa4ESJ9uBEYOUZdkJ7WbEuEQLU3Um5xFI3own15XQM3UjtlkztiTe6w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492ded4c-9df9-40b5-acf6-08d7e74c9c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 06:07:32.1574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2hI+gQkuNvTLPeDZEu+dnRLXv2GLJaeETTAjBaSx6SlDpRs2YcomeimTWopkyGt4yWKY/SzcI2Q/Atxp1GGpV1rlf3AOBIKTxItWp8qjZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_230736_528252_8D113C14 
X-CRM114-Status: UNSURE (   9.39  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/22/20 1:32 AM, Christoph Hellwig wrote:
> Taking a lock around checking a single scalar value is rather pointless.

Thanks for the comments, will remove this is V2.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
