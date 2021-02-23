Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D637C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 06:54:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF29D64E2E
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 06:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF29D64E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=5itflS1adEl7OBXqNzXusRuSVJF+ZNgeWJ4AODum6U0=; b=Zbmuad78KIhBkt6LRHkMmRF30
	HsdBcXDLMfTU5ZLZI71yBQvW4R6HD33J8Fr+bIaAzJdsID86iErwu8A7hWAkrOUuUOYY+VmfFHEma
	QwiaiU1cgrcfMZOAtnePYRmvOwzeEUPXOENTsKB6p+Gk5LYYU2Uj9xSZhpDs0rxdLn65z4ARU1GMl
	I6peYM/nVe0IfriNmErZUQ3IdOyoMjR8D7jhTTNmiu0+KvhP7lSO78gqkwKPI04GkdxyaZ+gVvMyc
	EfbOoW29HJddfzU+W0f/YKfhjlh64S2T9CBoBWhcot71VqzdmyWNo7J5KqTtw0ThDCFvi2mX9egvg
	EimJH+1uw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lERaM-0002GF-Lf; Tue, 23 Feb 2021 06:54:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lERaH-0002Ft-6c
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 06:54:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614063253; x=1645599253;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=1e//ojdX/yyasRda7OmQ/tAWyjijNo4tJ5+Oxr8zN0U=;
 b=W+F2p3DTn00auE6GcmqFmw2+GDrjswDWCa5N5MU7NMD8X9jE3Efw0tX0
 v7YWa+t1pc/KuyIOsI/DFf8OpZ82lI8Y8JxLdi6KiJOtYEJLtyid06W8B
 bbv6JFA6N6lyqi+MRw3WkiskkToVrL5UGbO3X40941mhW+GfoSSuQqaxW
 WuGcWXohUv/+9Tdr4v/qYHftlTJsT5a9SAnM6e+ukrhDeTSnJ4etJ7FLe
 gXdLl/zVwodkE8PHkQgEmJVI7kgHLJumk4UC6NNOKeulouDE4VocDTUtN
 j4aLqZ83AZCG38wmdj5FiFjNSsDrXP2/nRa1D63qzQQt+JSp6pyDnMTOx A==;
IronPort-SDR: hnO8YYyP6Szxt7VC+QWOko1BId2yaPbIxLK6LgHGYZmkYr1zPTgqSlhGcpBS3zVm5eF5LGMW9G
 QOi+qKHRJdLqc5TqDXIOejw149mKpLYgb0c6PDKgp1q/DvKN7M4UDH+D5+A+JPBiPAr8C9U6fe
 xK7HAI6HAJRPkWzxPiSWe2IDDIIZTeiS2tK+cPSgy+XnLbXKC4iGP/CKfjCu3tdEiGuT5XzyQO
 Epz/eSxtZW7EoXi5IliRjZK09dMrR6GD86xi1Cf8B84OrYYoBfe2uLPpqAHsqd2t56xEpxG+Ij
 Cww=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; d="scan'208";a="161736651"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
 by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 14:54:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKddHCGNzgkRzZZmpN9cjpE000IVgMs56BJpjz3jdDHbBD5cZrNuXEfO6iDf60H7AMRWyFmNrBXHSTy54dGfq6ZUWP5U2B1eDKqRnOHrZTu0jC+klNKn0eEbyiD1YO3C4V4/4ryseSSJZAVVxsVPS5E0yr/7ElMCrUzC9GDrKblNRSJCIfXZlLbrCeDxMcmXGfX5ObuoSc/IBxBDGsF746iqb2Vv+RY+nAH2Yb26h9RUaunQdX0bAANKXOS06kwBamOPV+yk3+XbuwFyxz7s2siLCDS+NBSg4oFburEB8E0FzbYjv+bva2TbJBbUBOLxcXDNNvibWAxSRG8AqE9Twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FKNQoHlLgzZIW37jDRI0ey5AUYSfCchroFTG9TM2l0=;
 b=kqcETaemI3y9gj9msDTouUSSrFfndl7eIqF4uZgGx8gl0eH13kHnbo4ZME1R73bWUZYI7FOnR4/L8+gWChnvlCyEJ82VUsdIu6KrVaEKorEwfD6bV3JG+7tbroLMNWm+mZcf4+62yzO11K/R62KFBnUzD+6l0VCuDuCPndipnl42OluHs0imdvaOzOKTu55Shs2QazDvsdQOXzCJcMObEZ5HVAe4XR3O4rySBDqurIwpMpV3v81adGoGVWEMsSg+ObmgFqfxRSNvVcxk7ed7lax4G+50hgrZfsT8s5L5IeggqZuX0jPkGTIrovIk0CSbjvfqob5/8PHTiZFTv4opxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FKNQoHlLgzZIW37jDRI0ey5AUYSfCchroFTG9TM2l0=;
 b=I/in5N82NiPa0gsgqCC0LZBPfcpeMS2dnctPsVXOCc7dEkvmlGWdixoYXNO/h/FVYfmDkYJLxEt9sVqUsVANxKoZJYbrlGqGPKIohxKog4ncO5yNxtm2pijhvxjbaNSJ17lL9CpYNiZ6/OAaPqK6bFBlF9IJiSHtrGLtqWLeJ28=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7550.namprd04.prod.outlook.com (2603:10b6:a03:327::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 06:54:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 06:54:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] nvme-pci; remove the barriers nvme_irq()
Thread-Topic: [PATCH 1/2] nvme-pci; remove the barriers nvme_irq()
Thread-Index: AQHXBomyHP5k+19jV0Gr3sfDsICftQ==
Date: Tue, 23 Feb 2021 06:54:08 +0000
Message-ID: <BYAPR04MB496513669571FA6541E58B8686809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210219063726.63728-1-chaitanya.kulkarni@wdc.com>
 <80fc53d2-4f35-7c72-5cc5-3ec13c5ee51a@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6926d6ab-0df2-4991-d3bd-08d8d7c7d1c8
x-ms-traffictypediagnostic: SJ0PR04MB7550:
x-microsoft-antispam-prvs: <SJ0PR04MB7550A3013FDDD07221DF7C5286809@SJ0PR04MB7550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkCTVmt3IAb4nod0op040fvLdo2zaVW+8vv3J+qbpC/NrHh+gtS+U6wnKi40J2ZKDD2Welx+zqpSRBSM8ffKUm30GsWqgTPQVhrOIMfa/YPZmgg7l8h/kDdfwwaj6G4H1qeQA/SSzskYqA+MO14j4nj5QFr4M/2QmMvO0wrQt97e3INM5o9+OBZjRvMKQ7qMbxtgrePES+smgc7HwpyNvpA0mgFquE9OEsp91u9OR+7kUgNn8zhNeQdJOo84UHPnTZ9NHr+zc8eCWIKZYuRXqE767cvDc4pz8a3nAfr9uyWXygbY6c9RMKcqpkr+LeHYcOzmuPyPkFwmcperN6kYsqOA6+SIdJaQ4VKB++Xuj5GuC44pbOEPYSKO/NSxqPREqnssiKlyqFP4wCn/Xo9ktV02J6cHkNgKte26/Dj+Ja+3eIqcrTXVoNgqIOWrRhqyMpMA9eFobOj1nHlTcdngsSA1zsaPNUUo5grueETfML/hSTJRhXCmRHbVIspNWL4bDARKohYNyUOsRNoWiUFlbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(53546011)(4326008)(83380400001)(186003)(9686003)(33656002)(8676002)(8936002)(478600001)(86362001)(55016002)(7696005)(6916009)(26005)(66946007)(71200400001)(66476007)(6506007)(91956017)(52536014)(66556008)(5660300002)(4744005)(54906003)(316002)(64756008)(76116006)(66446008)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2xDVhzmH46N8GLR75HbhLdg8dV5Zjt51OPs+Es/7PwLZQQGVA1swNpOb94qW?=
 =?us-ascii?Q?LTjHrC7cl8JrsXi/lcWboc0kCvD8+0dZrijhaZCMO+ZesyEbszDUdD5vulET?=
 =?us-ascii?Q?mlAHCIeycw0Kg/D2f+4oMjagr0golYBDtHrcxFYr5RJG8GQAWu/0Op/z6Ltb?=
 =?us-ascii?Q?Pe+k8Sm6auDmfNDVFj4xQo5Kq2aqb40Wc1DTXO4irCCz/jW5IcSTq9XCUWwG?=
 =?us-ascii?Q?SY3lJu5TdMYLfe9xie/n4ol/jDQjye6pYWkYyOYHHLcwobEkHpsL7VJBst7o?=
 =?us-ascii?Q?e+Nu9fL9jVb0DnPRLlJyElMcIfFhUt6T1xN7ZDFgxd6IAO3+wOLbi8O9k1FY?=
 =?us-ascii?Q?B9zELtW4/+E1kSKLZhfWuArf7j1xuLCqwD2HJ7kFdtzoUOs3TI+yWwYNEpUJ?=
 =?us-ascii?Q?4Vy5282esiDIWgkFlScR5cf1TkOQqfnNhplaGtg2RjRhO/cyPSWIa5W7edLs?=
 =?us-ascii?Q?KWZPvUHEhVYXhOezwqw8dhdN6X0dwwOpJ2wLOcfHrGaQiU6qaN1lIQLP7/+J?=
 =?us-ascii?Q?eqDhhD5ksH41UdDkLenk3DakAVNOhrg9Uzgf0gpKGgThfWHLPcJu5vKDq8Nu?=
 =?us-ascii?Q?V/3FlOdjIXKhkIL90WVupFui6wWT9JinTcqGBEPGLvHXPzyLaup4+RoPxhs4?=
 =?us-ascii?Q?u/WD7JzHpKJhYzn/9jkOuvAEMcb6d0MN9+Z3yKmlFd0bn3dx2a95+jkKRtU9?=
 =?us-ascii?Q?k4XG+qyVXnogMFDHuoFmT+KrhBaaFakVjjrtEZJXcCRZU5vh6e4tcjDuMBUx?=
 =?us-ascii?Q?NczUyLIZZRJbZ/svjOtUZQ0VPPjwDrK1/b6EV0A5XggDAiXZ+0qINcofOhOw?=
 =?us-ascii?Q?Ox0D14nHkD+rfOW2TD6qWNeRV0VtFBS1bAKe+8KFJRBowrr5u7eB3bcv+6A8?=
 =?us-ascii?Q?535zxwBMLaQx3YQ4F8pzmL6f0+OTdVotPHOldejU/RhUnNboLpe+Qa08jp4+?=
 =?us-ascii?Q?pVSBkqZVI3R+D74AkZVsoYZGeN/sp+dTYxblKP3jH1ZMT3IR7kmSsBI3VDpj?=
 =?us-ascii?Q?TdDI2jgKIx1A6C5cap7IMibjQ9hyn66X+mujbOLxuyJslX2b3UDOJArGO/kP?=
 =?us-ascii?Q?V3FlCc/G6zr3UHp2psAQP/Cy9lcKOW6Z/t3NGoXT0Sq6qDrDa5lBIa4tsV6/?=
 =?us-ascii?Q?vwskWoMa8TktZvYHUmEQoOqVk/khyw9vAyJlZncRvWNOaCvdc8lfrsY2Mx+0?=
 =?us-ascii?Q?4mXJmgPQVojbIyaxJ+G995jnv16g4KPal9+WH4LB6H8oRVKuWvung15ew+0p?=
 =?us-ascii?Q?yrEPRXNYUzqezZ8ny7PDsS+B0xmYejdsN0fDzL0h4WKjv1fhG1umpNEBpLUd?=
 =?us-ascii?Q?e28hyWauvNv4+zSsAejXVc9n?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6926d6ab-0df2-4991-d3bd-08d8d7c7d1c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 06:54:08.9909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3CQq+hqKzU54DBAQ6JyR85dJ0wE1otk+z2njJi7d3JDPkGSAFQ/Uh5KzEaN3X6durl1t4jTnJhulrvRY/pDGJzb5EH4jTa4+Yyf+OKLhxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7550
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_015413_463451_4FE8A3A3 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: Jens Axboe <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

(+Heiner)

On 2/19/21 05:40, Jens Axboe wrote:
> On 2/18/21 11:37 PM, Chaitanya Kulkarni wrote:
>> The barriers were added to the nvme_irq() in the
>> commit 3a7afd8ee42a ("nvme-pci: remove the CQ lock for interrupt driven queues")
>> to prevent compiler from doing memory optimization for the variabes that
>> were protected previously by spinlock in nvme_irq() at completion queue
>> processing and with queue head check condition..
>>
>> The variable nvmeq->last_cq_head from those checks was removed in the
>> commit f6c4d97b0d82 ("nvme/pci: Remove last_cq_head")") that was
>> preventing  poll queues from mistakenly triggering the spurious
>> interrupt detection.
>>
>> Remove the barriers which were protecting the updates to the variables.
> Would seem prudent to just ask the original submitter to send a v2
> of his patch, as that's where it came from.
>
Please let me know if you want to send V2 otherwise please ack this series.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
