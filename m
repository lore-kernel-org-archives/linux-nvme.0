Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180CEC433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 21:34:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3F5206D5
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 21:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X5K31R09";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GtC89q4E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uQ7oJUfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3F5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=lrvJIEEsi0qbUfz2vk0u4gWOA7onRMRM6k3x2rKU7S0=; b=X5K31R09AFwEjK
	ocbdXcmI2TTwU5otbS+XCcV0kbyo60/sjC8lF25QpS46odJvIGZe3xh2VTrc6JvLdhegueJvuY1+v
	W/mV06wY4+u46mjz2IyGPBwOihs+Ogfz+3WfGTqBMPlQQlFjkhTwtyHZcE5uayhXkswcMC0fOEcTk
	wgzAnVPEiKSjnLt2oxSA4EGeh07Xd+1lv0dfNrkIe9mrwzOgYjZJnJ8+rGo+xEmjsrpYGUhnttOsY
	3LNO7NGFEHvdfyl2taBzNXHRk1y8vROjlNBsGzMlbxjH53JEUAGvAOaxfGOWom3jejzOuRqpgiNKU
	u7Wu9EFjTZDSwOXbW7yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiPPY-0002gY-3e; Mon, 08 Jun 2020 21:34:28 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiPPV-0002fj-11
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 21:34:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591652064; x=1623188064;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SYV5+h5+nt/Vt85usPLMWDVuvkvinZgb5zUvXG2uyZY=;
 b=GtC89q4E6OzrZqM85pFsX/pihq7GDw79AjKvAHq32BtJ7eE6sVfDB5Nv
 lk1OIXfEFSJpTnHbX9dwYlNL3/8Qw8Wr25UIr6zWr2GK0Fl8P90AXkNB4
 vkh1W2Aa62r9Oxo1GCFbDuYVC1DACR/DBAC/z0tDNm6DQHBTpiupzeT5O
 aQITAx/1wuqteE5KSeeEcb7dsLHIdJXCtOe7RdPHfJPvfZshnP9mxGgZE
 W6gwbn5ymfuHR58PaBKINScfePbPj1brnnus463SxoeWtxxj0Up7R3me5
 BR0IHHO/YeSeXR7KB4I7NyQA1O30EOnMY/+7+s783B677/n6h4xAweWWc A==;
IronPort-SDR: W7FHxuMpogOVpDi1SH3vWtmOXHta4LGcqPDwOSQ0ESUGGI0ioYjW/c8iUCZ0c2LMGrIat/56kK
 XG+/FuhfNv1n4tybiXLtUnnBe9IcNHb7hqb+Ml66oxyJGmBjkUB63e6Lyt/G0PYSY705tWAVPq
 jT/jdPlQk0KRxm3c4V+DyZnSHRB8pnB0OuMTBftmv92GpEMg3225Ajzf8nUsjjAfTFD8dDS7Iz
 y2wPY5dMxCILxDtAYJFNDdmi5Yj+mMQGONiurf4YREOyQscbgARM2LKUSDBv/Y+9rllFP939Mj
 dyI=
X-IronPort-AV: E=Sophos;i="5.73,489,1583164800"; d="scan'208";a="139481105"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2020 05:34:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCxHDnwk+1mwe3YTqqiWdb3YSKU0n7NrMEEMYerbHhdP40y5qty3AvN3wctaNFD3YFB+4VLVTZkJGyRVhCyd98SKDN4/dwUOaw/OiXzCmP9QfLWBXo39/H1sj3LWiPK9m1DrrviufD+TmQ8sCGLHi9izBtLQQcn84WmE2PlWbIDJlFmFuek4FbvbWoc8ooJeuPvSNVf6Ltq/PuDzxa7a/Q+L/+y3UbeSNyKymJYCeXhSnqQok8brd8EsS6FE5SyYa1VRxH2hTu9jkw1UfnKXdNMMZXU+L/00zLnbs6T4jYgC5gDq/Aj42Y2pZNXUs8BJxKh7mceEi6PCU6ySuNu1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYV5+h5+nt/Vt85usPLMWDVuvkvinZgb5zUvXG2uyZY=;
 b=Dsby230b3Kqw9dIGTi6X4ZIeJ/HiEaVO+ZUiZYLmBWj3IknpJF0uv6pFN+6KGljpumZ08wNbL2sKf5XVQNbWAUM5Jsv0jNZWogTYs/c+NEjO6ojWcQ4RsYficnFQmgqbfiGhbDxEvisg6rCtoZV5MT/nZsqdJbMIrEr7KkSCLuNY4QZvwtxJ50UZyQt1oGMGdu/g0YblTSH6sR4G64WBl58Jx/Qj7hZqR8W8b59sF++48xLGwHXtsIuEP8/02XuBoLId7rxIqDsuaupgftrh5c7ivfpRhYJqk2roaPGPD76r6VI3+Xl+jCf2mXsbntVqb+wb7gDSOCA8LYHTXZmrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYV5+h5+nt/Vt85usPLMWDVuvkvinZgb5zUvXG2uyZY=;
 b=uQ7oJUfDOLvW+6hYYzig04CsLOur6tZGLEbbBW/I5+ZoTO6VfBrcC7U/FLH4LpEaZHKrCO7Ca5Yx30cS/1MHqreENiojt2GKTB8LxgX69lzzreT/+WO8aOOAa9hEjUwGNXHnkniD72kMOKgTHW/o7JcnfLmZNlfChi7IgXTh8xQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4229.namprd04.prod.outlook.com (2603:10b6:a02:f5::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 21:34:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 21:34:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Dongli Zhang <dongli.zhang@oracle.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] nvmet-loop: remove unused 'target_ctrl' in
 nvme_loop_ctrl
Thread-Topic: [PATCH 1/2] nvmet-loop: remove unused 'target_ctrl' in
 nvme_loop_ctrl
Thread-Index: AQHWPbH20HHmlisblkW3BkPpqnR6Fw==
Date: Mon, 8 Jun 2020 21:34:17 +0000
Message-ID: <BYAPR04MB49655A1EFD53AAA965FB83AF86850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200608162002.17017-1-dongli.zhang@oracle.com>
 <20200608162002.17017-2-dongli.zhang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ad56fc0-302b-4300-9e24-08d80bf3b289
x-ms-traffictypediagnostic: BYAPR04MB4229:
x-microsoft-antispam-prvs: <BYAPR04MB4229369485E2C37DF562B60786850@BYAPR04MB4229.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:55;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vnmHKZpoAegW+qhp4+mP4TLUduDHljWQjFuF2n7yAU7ZdmDvMI7aY15ryJ/b3RrXQheNXa/5fmc9KFO/enNVLg6RMvbrCrdhvKvhf3YJYONYuA+SgThZQ/UwMNK2N1T0C4T3qm62/ZQmfnjS9IX9oMKuf3RuGhq1mK5f5esAUT30hwpI2qMG8CwUMS8M6D6q4brSQigNEUyBsxpc2ZaLb3vMo3hbl6kLqdSDsVwfvcvjcO6+q+j0jMb4lCuvVLwM7iNn7t2oYP/SGqWrpNEzpgZSghDYXpqql+I9s+RHJkhDV2C4tRB8acoOIWrnP7MuBK/xs/9QW4JuiLXlhjvlNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(110136005)(66446008)(9686003)(66556008)(66946007)(66476007)(64756008)(7696005)(316002)(55016002)(76116006)(6506007)(52536014)(8676002)(26005)(186003)(71200400001)(86362001)(558084003)(5660300002)(4326008)(33656002)(8936002)(53546011)(2906002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AxZOg+AV5lfi3SBuOtVAtsOzZ5BnUnB2vYYeC7Gt8++YcjYpKrA6hLkc65YAyVqkdUakm117khI1u6bjoFdE2OIhcIls2ScxqadZnYEOqlIov8iN7mEmQN3hriUNCJ2v2P69daDmLGS+1B/JtKk0QBQIWiOBASk2euU9kUJ20QOcsr9qxh5mhA4vwy89zLzAOLBnJHis0GAE3//McoipE4JkbqRg7bM+i6EpnGJIVlq+hsRmIRRUuudkgt8R3SXXGI+CLWjIVbJuCYHUanweB2TZ2adWQu4OCtYKoyFJrfsLl2TYyN20yi2JHNOskiU+elGyBK4x/cQeb1Ma1p1Bp9ggXWz+0F9Nmd8qNLnTPKdWQBp3ErZGdyq+rAxGgKOia3EOOyW/E1Qt5K4VtZ9FQonvCX3ss5sEGnFVhBfB2K9raV0fKnRgvUxiEAq7EDg+0S0XCOVn2UU8vtOvBEiCRBftORwzmDmOffF1KlDvpZ4=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad56fc0-302b-4300-9e24-08d80bf3b289
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 21:34:17.1987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XhqqoZRIU/3nKkDYo0G6Fil0nHuBCC9dXdqANVO8EDalXQZSt+5xnaOkxASzIMI8TT0Xi7g+gCRrmT83xSAMLdWoFDBEJ0Ac1fgt8eABMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4229
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200608_143425_182834_EC02E0B6 
X-CRM114-Status: UNSURE (   8.49  )
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
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/8/20 9:29 AM, Dongli Zhang wrote:
> This field is never used since the introduction of nvme loopback by
> commit 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver").
> 
> Signed-off-by: Dongli Zhang<dongli.zhang@oracle.com>

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
