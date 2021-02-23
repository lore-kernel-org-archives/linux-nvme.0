Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E78C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 22:03:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7103A64EC8
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 22:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7103A64EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ji2VQAdTwQJNsLcsiIRuEXnoPhvhIQwhR85Oajdhrf4=; b=c6nUwnBiySrNU3FgVQNWAZKcI
	PFwyN6yv15VbUTXKK2DGx+FWN5uZgoJjS8d7K833JsoQR1V7nsmcCSOgV99JUQrim7JBZDrrIx+4W
	4Zw54XlYNGlcvCkYpgOO2GRO2NxP9hSQhdNWGW+dZ+3zRPN5W+BJ3ueThsoEmNPholpdvE6g0B4lD
	hHUe1TrWFPZIwP+CvkiQ75Ohuv/SiYPgi9BLs3pagC5Htwj7uMD5o9XfP8N0t1ExCtqTEDvE5CuW6
	ZqHvk82wXkECoMbyrnpuvH7UF5nfo4sbGRoXvihwKPZZtLkEpv6ivd94j4Tqo+lHE9jyZTBYn2hOL
	uqDHjTTwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEfm4-0002ee-Uv; Tue, 23 Feb 2021 22:03:20 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEfm2-0002eF-JB
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 22:03:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614117798; x=1645653798;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=w/KxvpcRAPyBZ9kmqc4N58PgVzMmwUK5dRdS1Vdv+qA=;
 b=H1ONuiYFeQPa5A7EkpT9Pork85tmUCJVsfbybvcPMQs47UTbo1bk7Pua
 Vc0GX5iMMVJsVFuvN0jMuU4LQQhlO4OcVLQJXh2Nq4yo1UVU3gWP4HWeA
 /mJZkkxk0pAuq6s8ik3w40V7AmQbGVhxaZtpyvu6HTGVf4usjYs9hy9xW
 LzmRbT4tSa/jCdIZZmX3sjzSZOPy7UrEqfv+cIujjcWZedZ03ZSa9rZvd
 5fmeQWfSqz3lt9S6SMEpe0mZ1UMatfIAT2cxmLAXs3jnzGXUZ375IHwxs
 1pYc4qDi6hb+11vbe2QgBCrd3wtoTECK7bmpJinOlv3Y/TLG4nCKeIBjR A==;
IronPort-SDR: V7JglWTMM4NIPRlEwhh+yU99eC5KMSD287iiJXSyY9vUxcKDIvix1JjAlsbwkxyp58KlY1aSNc
 xLjND6YIrBcDuN+3Xtzo2iiALr9uAQJDT3B7zMYVTzpSzK679abpD7Yf5eyF1GzkQorSQSDJ9L
 bQ19YTrGKzWTOu8TE2DIvfCbpkwSZyCmZpAvmcef/svHMFsp5R5wBCxZqdEWH67M0XYUEPPXbm
 dNrB0Kli5Ud13T/OYxtIPmhW3AoitPCb0Kxwpjoz2A4P9gUmQYIu79cK6W8MOX5zEA+PbzqPUE
 d5I=
X-IronPort-AV: E=Sophos;i="5.81,201,1610380800"; d="scan'208";a="160620125"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 06:03:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwyxZ6om4LZEz213rZCrBObokHrzSudiSK7A3SOynq6ZHp1adAl6v7dBcqOOsgmoZFNIjEm4ZvTp7e92FVhQKded6jP2RlBTtesUZF7uQ7ga2fUIVTyhnnHs8/2M5rSscOxY0k+OgsvEtABWMIvmJkWZR4Q2y5hjO/qbIDOg+wFUEEXKzQWi557ohPpeZRkVQVwvlo2s79PN46GKbx6/v/bm8jkcw/gWHj3TcjyJrwzI9K9CF+a83FCZzllQFiNRLaOWH3aVV+u5apS0lHTaXU7/EBkV4kDsaIJ5cusO+p/SiLGYV2/USHeX/sgObRMXs6F3ZZ22Eyz5P9/eOZgJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/KxvpcRAPyBZ9kmqc4N58PgVzMmwUK5dRdS1Vdv+qA=;
 b=YaJsboULifk0E2/3CfY7aPqKYO9x5HwLnwoftgMyWyu9Wb8jislfj2RCizeNa81ZWrcThsGtii+5ACDWoUvlgqQnxhHycrbtIg0naw7z5ZZHe7p2izWzyaGcYiiVBWTfDsggu34Ns930S/vGlYeOTYa84+HvrasUBhOjU8eMIm8sICMNtScJD7q5q+YTuPashU7jvHtT0b2mNJtKW2eKFDfSkssxW1DCV4GjszUS77yM+d+TfOSAvESPJAOpT9Jy7569W6WljHF8i0HyqUfFzB5aQwDfEe4eAcn3R7eHAlmG2kGL3XP3XHomCp926GbJzQSULLCOmQ0P7KI/juj39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/KxvpcRAPyBZ9kmqc4N58PgVzMmwUK5dRdS1Vdv+qA=;
 b=x5niziEIuzG5ticwLkvlUvf0lRYLnDYNuLn/Iv+SEHIRynCcrhiEIrNK1nJIqPENfFZdscJ0NxhgYyPWArcGNI2hS/SYM6TvpZ6bhAXytSj6rBHId4mOB9WExlcHsA0HeHul/Yyz6yBlzc3ydd2Xsx5gw345jvFbqXf/vGZSwjU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 22:03:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 22:03:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Chao Leng <lengchao@huawei.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
Thread-Topic: [PATCH] nvme-rdma: fix crash for no IO queues
Thread-Index: AQHXCbXQxtpCpLXt/kafyvf+Etcltw==
Date: Tue, 23 Feb 2021 22:03:09 +0000
Message-ID: <BYAPR04MB49657E5EB6A8F9C8C07C736386809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210223072602.3196-1-lengchao@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5440451-0599-4ce7-c51c-08d8d846ce42
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB442441E8C86811F4D301E70286809@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1LdQR5HhKDpvRpZwESGr2lbi1hVhM4VkGt/xpJHEANXo5oFgCtTSekkvONFMgq0wO9/oYXM+vFcbZTgaytRjWZX/vioPlhTPmGBloHLXST9QDJxdYj2oEBeM87QRSDK3BHq1kjS5BvTyM5vbFjTPz1TqSUfigWmR0GncAif0RkTtYQ4fo1Rbg11h/c1DVqHT08rFsv8qReb55dEhKucPl+S/gG2sNCfHzuKu3IGgnWlthCTDZ5cCynD/Wmvs55UHDv/TSZt00dI8aBki5od3fLpWR3BwY0zKM5Sr2fHUpZq1O+fMifFiTv7yrQAnjAmo3fi1/gm+zWhzqFPidGHBka9YV8c+Vrc8uR0D7ttw7HJZunYWL6OGnWhnqjhyu3TjnbHtF2mU5cAP7HpBp+mlSl6xB1sxtsxQSyz4vDzuftutRwRXKP0ahZIC7SxFEN6A5vmOPYWzyKPl0Cfe1RzzhPu5ao7/0P+thCO0smSVSxK1dpeW4m4+ZbARwdzxZKuQ5yJ1/2NEOBixle99eHqjDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(55016002)(64756008)(52536014)(66476007)(9686003)(478600001)(66446008)(7696005)(86362001)(26005)(4326008)(66946007)(53546011)(76116006)(71200400001)(8936002)(6506007)(33656002)(5660300002)(2906002)(8676002)(54906003)(4744005)(110136005)(66556008)(316002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?i4nujPnJcRSL03//9SQG1JqkYkOgxn+/4qySWxiIpzbR0wXbgJlFquJepb5n?=
 =?us-ascii?Q?BOSytFCW5MOHIXQVqJEWv+NLUB15THbPx4k7h+hA1uS4bZlSfkZ2Jo90clkh?=
 =?us-ascii?Q?WzdYa2MRo9Sxf1Og/S2eh8pPqh9a2fD06ZyJxEu7N1MneLOlsG/nx3+Yn83c?=
 =?us-ascii?Q?lW+s+NfquMVsq3PCsP19Mk5V9B5Bg6m0KhIIUrGOYL0l1ucbxXWD7RClXezq?=
 =?us-ascii?Q?uRYOhzvuTXB2WZrv+IC9/nn+lTHlkZfTzNQPamP0Fgus7nDUnl77vXcdX8Uu?=
 =?us-ascii?Q?8gQH4/yRai9F/IeGUQTdbnujMrxdvKPXcsP2xPAlwtME94CQQqitiGUIVdwg?=
 =?us-ascii?Q?ZIkdbEdLkrXbh7iADRfIz53HXVrnK7lJJb4yuQNrridoCL+p5UhCf7mQlKDc?=
 =?us-ascii?Q?36vm4MwQ3sWgd2FbT/PqDWDQrK/Ve4eNdtSgx4tGXUhh6tDF4R1Hi9OwH5IN?=
 =?us-ascii?Q?+eBg4sIi2OL13cbisYaNQ6SauOQ9ZqwJo8cXiw6GnINhn51kCyCJvFpOzAdo?=
 =?us-ascii?Q?hnkf0/gtmmuQJ6xF9UkHITJO7d+N7NoN6qdc8nTUMSEOa4yH3m5MjsIaBLrz?=
 =?us-ascii?Q?+NmHZCeWTX17OFUgaQ0bOX1RKcHZyGmILHtTl+gcdtCfZ8o9ZKkLy2F8yJXF?=
 =?us-ascii?Q?jlzMnBxYKx9TRg30FhD2fNvcPSq5cZMLgX9oLjtJE7BgG/ZKio8HErWRBX5N?=
 =?us-ascii?Q?nFbTSpgrT2epT/N30rrPRZZvM+Od81ymlFdFexcxZ6fnojLDggXNtK8bnY1+?=
 =?us-ascii?Q?iPCdxColw4TfLY1uOSDKsfusilyW7pLWbCKrdPQkUMUg8zKuntVOSBbcBzpf?=
 =?us-ascii?Q?rhDncdqJZ/NPdbxu2Rfvx+teH8in1nz7mZBbIA+Z2hL1entv6bv91dhMIL7V?=
 =?us-ascii?Q?XxrfHvVV61X6+8a3uBRTJxiLDkndLKCdiTywNSh0omLCjjwuVzwKEDtQmw2j?=
 =?us-ascii?Q?dMm3UbqWYQeFCGy6W6H4piV/BQ27l50dD2+RUl0KvuKBh7PRnknuF58Lymxv?=
 =?us-ascii?Q?l8BNLwTUxluz0Q7YeB9VKRCIHr9RL+ZUK3OEW73ZmieYrtkoNNv1JQELCBjy?=
 =?us-ascii?Q?5TVN6Jiyy2bj3/NwqFh7mvwm5iSliaHwZ0s1YW846XFGRpA8MGE/FzyMGwU3?=
 =?us-ascii?Q?Tw0GzaWZvzNwJqaa74L3ChU83fMwF6nDEx/lfb3HVR1FxicHw2ATw+9UPdjN?=
 =?us-ascii?Q?VdVetudK76C1PllWEjTEQL0EHfP/MiEiGVV+TfFYQOuG64oSOsrvnNko/ZZZ?=
 =?us-ascii?Q?o6KW0M47iXH2UPkr0fm3ixGRB6PW3UMYExVX74YJeUJ8jgfz89cfA8a4pskq?=
 =?us-ascii?Q?hsXpykJY6F5CiGgL4164sk/KG8s8VvHwNx8LcdY1wId5FA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5440451-0599-4ce7-c51c-08d8d846ce42
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 22:03:09.2058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itypc4UXwpFIBgW2FpHVzE6e2eo18Ni+mAgHmBZLRNXL/9MnZZC3qUNpRWuiwFwIhMUsQzkgxoMi5Xc4DOXPi0Jsshbr1VvFDn4B2jDtN6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_170318_966425_EB48EB80 
X-CRM114-Status: GOOD (  11.04  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/22/21 23:30, Chao Leng wrote:
> A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
> over rdma(roce) reconnection, the reason is use the queue which is not
> alloced.
>
> If it is not discovery and no io queues, the connection should fail.
>
> Signed-off-by: Chao Leng <lengchao@huawei.com>

Can you please share more information about

"when set feature(NVME_FEAT_NUM_QUEUES) timeout" scenario ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
