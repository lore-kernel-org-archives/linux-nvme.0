Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EA7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:37:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4285D65032
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4285D65032
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=y3AnfFj7AOBuY5XekOHu6MvLV07IZM3icCB+hEGJqX0=; b=pgro3gvvi+oFB6dlQbDdgyhQ2
	9UzSHWJa9lpeBqsewxJELiGRREIRSKRMeB2xkCpcTcsbEDj/i3UGYRSJYIULyeBgLzBb+iA5AHiNZ
	c3Zk1XXgmXfM1GOFgW81Rz2BvMks8sFKISC1ovUWYhfjlnJGiK3aX0b1Gc+pPp//AWg+on0ArKFM3
	xBey+GumgWUFCxmXZud9A/W/3Ro7YVZmDqyQ/Qa2lCfK3dxcwlPv4cZe1pUqbf76byGSvPGmu9Zvl
	YL3jpdw6MJkMxS+eez6v4xIc+JfHB3RdiTyEIAk4kXnIgVxq2OnndNDLJuxdtTwxE4LqfVhaFP0nk
	QI9FXMXJA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHcv7-007Lzq-V6; Thu, 04 Mar 2021 01:36:54 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHYxg-006aFF-S3
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:23:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614807380; x=1646343380;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=e0+6bHs7NoHEl6OGLscHCH469SGrVEymPZOtNSnxNSY=;
 b=QVnCcyKr7nWLjHFaRXWtJjX4BadCcAECAkJkU5DVc2IrXE1sh0TQdux1
 fHeRom2I6CoFtC4bFElUj8fg0Ial750zalWPsSnfiKh10w7x3k0kIhZlh
 zVFdVkOjG2pRb//8AlMUR52wYcjHN6fBfNxHj0JgUzunAyy0iETyBeJki
 OOQg5aHSuUxTvUrePPMO5GB+b7As3jQbqQhCT+8OGBLMZSga0CzTqCrjQ
 O1qfaaCOiAEp6726OQzkqvCuiPGxWz+owycFFFkdXvaPo6Ls/fnAW00mM
 ETxJuBMIgLp5dyM0DSLjcPG7yt0+TBWG5BHw4yqHeEkduKyYtYFKMoTge A==;
IronPort-SDR: yE2VLq1Hz4RXekERT4SMKVuUDr4l2vWF8i0XnALKNeHx6+DJ6yBrBHDJUDAovC63cqb6ajmPhZ
 zLWXLt9cDrRbqP7kqw1CXZDVS1EUhrKCoHwgLOn/ACDQzq5DHYwtxtsepB17e+RmGHir1DyPip
 WgUZv3sheM4dmDXQxL0HA8XMtqQ2ZjhgQfiFoas1aGB6FOziLQ+W5woo+nGF4gZ3h3RELyOh+M
 7hZ8De8XaeWIMR/WZ/7aHhQPausmYgd1GnXHXP3FMKc8zAufiKRFlyU5qmiplWz2fDKV3uUYuD
 6fM=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; d="scan'208";a="265587177"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 05:35:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak1pW5bVx4WjDl9u83uWs+TLwCGeb7gwob1+FtGZXSUQ2o6XBtQ8Mc6FA835xcKnVKy4Fx9qnZZRrO2M7ZEFvZSBOjbZHcAd1QhHfR1GzXVXOHIoEiR5JshfxmRnIey7IhXFr/Q3ReMzIBiNRTPTgkNtGGkwq/m8FadoqgikmDgTlACWElTX+2mYIS14H5I9qpXztp7x6gZ6RmDDJSH44qKJ7h0g1HmkZe0fLlk4DbwDGOS2jVEP0+u2yKoQb8b/MEp9yFYdKZvttkhdpoTN+nG7QGRgxWqyb3Mb1F8PAzg8xlKh0Zj+Vqnnf/qLxzTJxXkC+VHLJKJRRj/qDB9sYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXYpgl2iCmJmFolnV3xh3AW5zik42O1bA5VwLCguKMA=;
 b=EQM//GjmfzI5/jjZhDhmcbTYA0s0Xzh/SUGIbRPtZWUkroa1C3+2D8zyH5e17zcg21AuuLTKYqkppSHQYP6myGhOWtN7OwGhChrX0VqJOPCTL3178L8ycueeepyLyOKogXRfCAag1mxFXXkrcTo7KO2TE2ZV+Mt4M6ZsL++OiY7zasd8qbotLBseS4KTLhW5nVcyfs4tBZ1OgmKks73Ldwb4wOVBWsG8/Q3AGKEKSpNQ1kvAqBC7I1XQ3UdYLRIXEbLFIK7qUfdx0hQ8PA+efnwwT+OEmjY+uLAya5ikf69X8JdyGcwEk3uYvF/XlksMoFUvGYanJzzVScX+qzCmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXYpgl2iCmJmFolnV3xh3AW5zik42O1bA5VwLCguKMA=;
 b=zOno6Qggcrxwd3OvZYHNBp7OuWsleOcl8/n9lOXmsv4a7rg4GQpANEb4cXiqPtH8MnO8dz3kOHa9HL9x983GuudRGqH2PpAAgc7JNH3kCtIiGFPHkHbxdbqezKyOvhcHm4UN6Qs8KcyYgCqyHREsZ5gg/HfasSd+xFIL/GOlWC4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4520.namprd04.prod.outlook.com (2603:10b6:a03:5f::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 21:22:46 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 21:22:46 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme: allocate the keep alive request using
 BLK_MQ_REQ_NOWAIT
Thread-Topic: [PATCH 3/3] nvme: allocate the keep alive request using
 BLK_MQ_REQ_NOWAIT
Thread-Index: AQHXEEFq8hDhTe3Wj0qwB2nRt1rFuA==
Date: Wed, 3 Mar 2021 21:22:46 +0000
Message-ID: <BYAPR04MB49650130FC28CF6AF5CA94C886989@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84209fa2-6ed2-4f06-6f9a-08d8de8a7d65
x-ms-traffictypediagnostic: BYAPR04MB4520:
x-microsoft-antispam-prvs: <BYAPR04MB452027633E94DA18985454E886989@BYAPR04MB4520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIqghsEPBazdAXF6VtCwN8ATZhv4IG7HSMa08Ma7SrNZIaRFNIbCmc3HYUvOl1hsxPgGyYLlenokR8myc5qzVNy8g1M32XCYr5Zj2LgFoPtbRU7kTmtrHDzv+1FVKQGKsnsWJsO40zDAYsYkmi4j7I1xZ5WXsb4NkYgyqbbZvWr/G3GYmkmu7rSfCTu2KxqwE2YrkVMSCMrD+lzMu4AfhhA9qAD/X2dkcSVWRcu+5LVGi5zH8h0TQbzYb/EjjJl/D4bdZzEVRYzJ6x/SXxPxSjBnLbGOUFOhgohGAGhICZcjRY0gOTAGa2jG/0mJwdPAK6zBdP7DPF1ZeIvAsbYNEtpG6zYo/qDLmh5VJkLXGBGi+9cZ4DgToW5KOuzrHjqBpJUh0UJhpv936tTTPqthHvrQVp+kUBZNzf1w8uUV63h3HiJ4nLKkM+RNLa0mOlRlo0TNcV1eB5iHyNYpi4Akx6W5YkzwfqkI23sWM21KOpK85tpA7edEP3R54yjAQaKT3B8vspB4pXxLOJh4CUhT1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(26005)(110136005)(4326008)(6506007)(52536014)(33656002)(9686003)(8936002)(186003)(53546011)(76116006)(5660300002)(86362001)(316002)(4744005)(55016002)(91956017)(478600001)(66446008)(66946007)(8676002)(66556008)(2906002)(54906003)(66476007)(83380400001)(64756008)(71200400001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1zZ7OZvX3BMBsF7k+1VvcaLd5KqhywL+6s+TAfJqpRy6G2q6rOE3Xc4t0rsc?=
 =?us-ascii?Q?PwxwC/nqadsOzhUMAmDFIFr5MDvtsKKROsAIz2bk0R1/oWvT3Lt6WUrWstt8?=
 =?us-ascii?Q?se/3GfmoWsIA6hy90iXXGopuQ6jnPuknUx0ovmcjIMa7eLfVLFQQN8wDQ01d?=
 =?us-ascii?Q?LVzBam8zjJ6+BRwvNLoNXvjtDop0FvwKDBsGSY+Ja19+LvmEzuuAf6KsPJZW?=
 =?us-ascii?Q?9FRT0bPCdmymToARQmz733v+SxXdUKfxywuQgVLTL1GhUrms1nnJWrNFdqEV?=
 =?us-ascii?Q?M7jibkdBz0tcJsDmvscGTWTvZ/hVFWoVIm5PwSzU8MUBbNHIEU/JnfVaVtzH?=
 =?us-ascii?Q?VR6OibPI6KdsCWKgxk20TUxUd1ETj4atHLAp5Gxk1oG0HpbL06YujGizSkmB?=
 =?us-ascii?Q?JTe061X9Iu/DCRCcKj/jr8J0waTWJHOZLr2TX4+1ZpnoQTtHJ6HgOY2ugvPI?=
 =?us-ascii?Q?MB75dzN9wBSLCQvAghEUGcj9x/+qKFDDnYQG1oYX+LJsiljL9cjDV+buD7QU?=
 =?us-ascii?Q?79EKozAkuyqNhCy2VPpn/zTYBpdau8T4zFoaz4KN9dXL6q09ZQPhtNUmFmZH?=
 =?us-ascii?Q?YVFDjN8Eo0pf/FjjCSEpCED0zbw9l5YPkTYhmp45TjyxcJrFxnk6DiNJSeb7?=
 =?us-ascii?Q?P/FGYWoOuwCVgDtoqNZrwsnerKztFco1iadk2odJ8oEBSUcPazipaXkr4uoi?=
 =?us-ascii?Q?Rp7dIe4GiQCmwqw1jQuWna0uoWKUnp7AziS2dGoT5vbDhjC27COm35Po8F6p?=
 =?us-ascii?Q?tGudauQxFKPsN/He2JnMm9SmKuxwypea2l6Cw3HsJgkG8nI/ZS0dQekgb9Gl?=
 =?us-ascii?Q?MPiPukv5WZv7mx7l6RHjOrgWePvB3tbhNkB/q5EUHuelkjXGJGFUF6O2T8/D?=
 =?us-ascii?Q?XXNgQvIJmTzZajYyiCHQZOOL0sQVtrXnUhfeNFE7jWXdKhl4Je5FKbZKXA3w?=
 =?us-ascii?Q?/Ic/V/JBcrixEhN/U22x9oSJLAgieXU20pgJn1RY+U0yB9kr1m8d7tfCVR+t?=
 =?us-ascii?Q?HSevKCRm5FueyGFThAC3BqJA5bfoCBrKOM8/6ifs5dtujN6HEEBYhE0c7DGj?=
 =?us-ascii?Q?kVFIHe9xohgFX1tcZoIfqFzf+L0B5L/ZrfcJZEU8dvaX4aAhUseaVdTg26tm?=
 =?us-ascii?Q?HW8WTAjDSzJsCjOKSNGa4VhYuaU2MGxddUMYV1aBbqejh/K/B5abnXZfXPmM?=
 =?us-ascii?Q?qH4cSO7Uai378GcharEQT7OtO5eN0MnjsSX9o9ix90+mePSwpPYwUUp3LkOT?=
 =?us-ascii?Q?wV4XjfLKjYrpMU5xKdljd1VzKDKMgi7OIQrE/T48/koL4O91L10zF5QmvoZC?=
 =?us-ascii?Q?Ovqy3IWKiSu9us8xV9C45I3m?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84209fa2-6ed2-4f06-6f9a-08d8de8a7d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 21:22:46.2048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzF4tvr22tQ6ukLXHBfYDnxfDuRa3Fqu4USff5TEGIjdj9TvBM6tR0E3i93LFppdKR70toDNSeJQwDV96tUYwvGVPZvZHxhvL0DHwO0P6ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4520
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

On 3/3/21 07:25, Christoph Hellwig wrote:
> To avoid an error recovery deadlock where the keep alive work is waiting
> for a request and thus can't be flushed to make progress for tearing down
> the controller.  Also print the error code returned from
> blk_mq_alloc_request to help debugging any future issues in this code.
>
> Based on an earlier patch from Hannes Reinecke <hare@suse.de>.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
