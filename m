Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97070C433ED
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 20:17:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07624610E5
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 20:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07624610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pp5FXLnq+ZsVwjllsFyBVTXECUAK1VZ/7wWrKz2z4Ak=; b=DXAaIAhNujghbCbERhDMEs3PF
	fc/hRmimM3cmNfP1NGWiCxB289KRjHzaXTeWQ/NRfiafR61q7vuV5RoD63bcxjzjxr+oX+nNDYhU6
	8tgJc1WH7Biv3n82cPofzmdFUZKmOGPhjegVW1tlixyOTVxXDn4JnNbUtJf2yx9XpPaFqNlDq2QuW
	0ajkWEgczhZswPGrET9hBleOrimBgbBkd+JJr/SLjWUFEgvIoBUNeuIqYkzWkhaajXNBhA0uQQY0U
	PuVZa11kCn4hdLOcBOutVAn2jWWh12gl2paTlwMu10+XgWFzczmHs0834IYunT4Wog+dtdFBK9xkQ
	O2qu186lw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVK2T-003O65-6H; Sat, 10 Apr 2021 20:17:05 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVK2P-003O5L-Af
 for linux-nvme@desiato.infradead.org; Sat, 10 Apr 2021 20:17:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=zGPqosfHzn+IrwHvWP3Eheli0pMmsfHarzDgQ9IrM54=; b=17uw+6lk4CSU7cee/ZXTLo2GNg
 N0HcQHE0LynpBc4B5VCFHqMsVSkdhGb2F6tr9hp7VZw9aKCk2qz8KSUQw2nIqfIsBsj7OJX+tt8Oo
 Upmcou05oLN3Vl7D97Q2zpx5Pth5Z4aG+qDqc0qBgkVnsHZRJFgRgPWT1a5ctUcrbfoRNF0NJpAga
 /ey5ynCK9xJrnlu9Cwu1ZYq0IE8i84SV7sLFJL/LXUvSfF8gNF0NZn6mNzlpD8x8IqXgfN2JKBl/C
 99V5hSeeTtXr8n9e/d5iihR1plgUfAU0HjdwJYuhJuY4ZXO8JkTpXInh0IrJ1ThRWQJth2oXLQZtE
 CR1KfOMA==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVK2M-005FPg-OC
 for linux-nvme@lists.infradead.org; Sat, 10 Apr 2021 20:17:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618085822; x=1649621822;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=35kGXntNp3vGGLGIn0fe7JeWJSD0RuiezZ5iQL6qgfw=;
 b=llnrdZ6D5sdjJuzn96i/+97zjOl6NinRrfO1jm/R4VjHwNbw7RG4HZVb
 hpBjswXh+vN9Omz0GY/2XG0Nejx7uWKeNZOPesOt7HBAJ6PDhy0spq6uY
 +pwmswK03f2stu9CSQ/TtATStBczIaMZMIOBRQ92iy8bTzGfi45kKv0Mu
 Msq9plDDBAKE3WHj6HodkmCEKA2M1oITpWH6HQzdDSNN4KTnacBNV8rqS
 SpuLoCs5P2k8bjKwrm/jQnsZ5H0WGBoNoVUCUWzfDRXmN5ClIW9tcTBFc
 OrMVFSELM7kBlW/M/zITg8GZw/BD7NzByRMTPQ8KBWo3wh7g2jfLOdG8c w==;
IronPort-SDR: Y6XXGrJ9mliStVRxjSxf5QSsyp7eVVGUODpp/0AGYqGk5r7Ejo4+HX3pw/ArhO5P7nw/Zmv3F1
 aO9R6ZjMtEBK6kJPAecJlUUORxS6wzMYnmmuTh4pSztfViquu6o0HoouTf0JhoFvX+5/V+gQN2
 DCy3qkSewerEWJlmh95jppqto4zneBmW6rrt294ioNpzTJn7koL3M0RFM5ltc5PCjPH39yeGRj
 q3pdFdpZIk44VcqvoWEPmMd4papdcVzZIRpRMqAIMBPVj9S9CdZCkevGO4mRfTMKFqu1YEISno
 vl8=
X-IronPort-AV: E=Sophos;i="5.82,212,1613404800"; d="scan'208";a="268650233"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
 by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2021 04:16:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G61GCGBOiwqMrouQH/j4ve/ppNopZiKKPCkmYPhA/VtICD6BzlfKF0/45y3NzF/w0To2cRMlyhWDTiY4R801xrjaB4raFgiphdglBZQDK4f7pV/+TpKgyTCKJ4tolZrCkRAB+FgBTfd3M/iYqsqKpDPzDdxEY8QloFKu3sZ6t72f0CaEPUOIKJYbRgqkE+tEiKuLsJsknq7bKvGWPKdn0VVFK+5yVuB/ky1X/m2V8J0ac15XfNIqz9kxyvVLByDdCdF4tX38B6DKGeRHoUYdkMLERV09IMfqaMIT1SFZ9KC6JxHPWGWOuHe8pQIVhDY3WZhxPZCw+ecwzghUjTz0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGPqosfHzn+IrwHvWP3Eheli0pMmsfHarzDgQ9IrM54=;
 b=bpR4JPAR78ul3C4hPhkRU5IcneIeOmQU7Yc2UkGh/SqTauTxS06IbcK4NJOtGpnIR7JreTjzZGEpT9QRMkrOOI/47KWq9QYqZfulrQVTZMVYvQXsvd3dvnlrOqouXR1NiOJBK61OZmrAR9dp1NL+zbLzCkW5pjsqwgbhEIMDBYbL05ZmAMRCuvccphVsAy9858r8XiebgN1CdppFaHZJxPySJUSXH0yKdkl6g00VZBWU+YMCCyXJJdhoB7PU5V5bsafRybQeinhFvZSc3hnrB6KabqV9NElD9eY8GFGuB7MX46xkZgiJF9yOWTIfVtik+AYmzVWj0nJlbRDg+e0Mxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGPqosfHzn+IrwHvWP3Eheli0pMmsfHarzDgQ9IrM54=;
 b=Gfetl9qKjWO16bW6rF/aw8dJ4YXy/Ok1WiJAYTroJcCe2PCqwLeVXC6MEPP4Q/3rt06Lns89CBjZ5VtDbJgUCsvPGhLt6CSS5hh+U/pQPSUSHNtajks2kAwcfB2eA4tPnTazHwVLAlZrPd5gTNcnHDp6OVKoI/IH7nnck7or/qk=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6379.namprd04.prod.outlook.com (2603:10b6:5:1ea::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Sat, 10 Apr 2021 20:16:21 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 20:16:21 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Niklas Cassel <Niklas.Cassel@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] nvme: remove single trailing whitespace
Thread-Topic: [PATCH 3/3] nvme: remove single trailing whitespace
Thread-Index: AQHXLkZf7d7hxbGGcEuk4XBnNqjx8w==
Date: Sat, 10 Apr 2021 20:16:21 +0000
Message-ID: <20210410201445.53061-4-niklas.cassel@wdc.com>
References: <20210410201445.53061-1-niklas.cassel@wdc.com>
In-Reply-To: <20210410201445.53061-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fe3edfa-b10f-47c7-cda2-08d8fc5d81fb
x-ms-traffictypediagnostic: DM6PR04MB6379:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB63798A61BCBC0144C33D2185F2729@DM6PR04MB6379.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: peyLOAgehCar/WOMoV9R8Qk9vzlJj98V/ccixsV7SuBEidG9dHLx8AuiVOkAxCoM/PsGhe2KDq6lU9UPLNiujI0aGAtJDOYSPl3cASr2vfrGXGiUVj2O6GY4vl+IT4+A95cWWWS6cJVUnOQhyfKtnwABHZpTAMexeq98hBTe3HAGuqfeTFc04R6Dqh2x3bJueX5AWmPHUSzAZcpKhE8ZMu/2zytCv8ChcinKDxlYkgjnHROsgL1xE4wWoK0rsUaZi6O9peRo6JFUEJ8eBKeY4ynKeGiWMPqqWhtYtcGM/0+YBj18JUVsiUBkaPQxQtTlSWoeg7+lJw91iH0TrKTtQS+ZoaA6EV5eGSkM+cnkYciBOAHN2tuHMq/haETV0ova6bOPn0mOZOXwthuc0K76ECj5Gd+W9d3iAGSVqKW1anjN8UaxydpOISo7U/BGAuLEsE+4Oa9LJfGeCJLnR5cYoMBpofFVgylM5TYMd7nzPJrG2SFWploZLKnmha+6sStIJqttrNnIcaU7L9N6KA/EKImJai5FjRVW5yp1pj5LGqkcqrK2/3C45NKcLYjaLhN+qLgLA4USmegesD06t04Sgw/93Be5b4uR99aNwYbgYm4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(66476007)(8936002)(64756008)(4744005)(66556008)(66446008)(66946007)(1076003)(76116006)(91956017)(71200400001)(5660300002)(2906002)(86362001)(36756003)(38100700002)(316002)(4326008)(8676002)(6512007)(26005)(186003)(2616005)(83380400001)(6486002)(110136005)(54906003)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?tOfEXjo+ncl4KB9IOF5mRTygOxsDAwP6CZr113BEirRHgrEphvdpjI7Y1w?=
 =?iso-8859-1?Q?M2QXXeKBzLSQU6AOV5YfXCiXwc0bPuMlICMffkVLcVYy6M3c6MAUVPEWZ0?=
 =?iso-8859-1?Q?8sHGuw1E1gaej9VoJAgmlxLNL9JiQdW3r0CgLfUplxWGeZh6ZlcMIzlPAK?=
 =?iso-8859-1?Q?THXoNjdeyHXvF+G9bK/LYqK3o58/d2uxtGVknczkOHILGM1L1g/a3paIhN?=
 =?iso-8859-1?Q?YaeA0odSSL8TKQNtrAfoxKCtQQJm9o7FgcYR8+//lzougKQUom+9FIpIh/?=
 =?iso-8859-1?Q?G3FUkzxhJfpypU4gq8ktw6Q0bDQyy8MdAIA9B8tzZ7WpNBcMwuaYbsWBKT?=
 =?iso-8859-1?Q?LpnwGZJ8Vf1w6wI6WOFrJJ+b/jybWLrimI7YpGoooG2Mqsvd4P1kvOIhSm?=
 =?iso-8859-1?Q?RrrSdZSUe5Mja21B9qrVwjDlD6XdBxcVIZFAZdR4FGIO0zmX/ikX7JR+bF?=
 =?iso-8859-1?Q?GAplW0/n6+uNLxRu6c8b58aNiHj5qBJUV03mz9t37kL4eHhLn+X8GUgL36?=
 =?iso-8859-1?Q?fYFUJvL2ItZgNlKfkSWqNPAK7Vgp+gNHMpZN21uxb1oguEn9089HSwSl+A?=
 =?iso-8859-1?Q?g/BCiZ9NgxG8X69KiwfuIs0FUv8kszD+euxBw6/fijamp90f7EHgBLQs2m?=
 =?iso-8859-1?Q?towRmIv/pPGJg2xbayToatFE+eG636HvupP7xDtu3LvLd7JcSWrdsjyt9R?=
 =?iso-8859-1?Q?hxO3YpQDPNtHBItkSHjMycaHNfKgPnDjELoxRgKenpKlubPC1m/6xZdC88?=
 =?iso-8859-1?Q?fB8wp3CQZYrZomgROYIAzCNF0IemAlJWaHy87YWg9Q5VjtD9Jwn6+96k0M?=
 =?iso-8859-1?Q?o7g8DzgbToWTdmxH7YO9jIOSdgzb7w7qDpjdmc7Vxp3XcPFTzJWfG42Xcf?=
 =?iso-8859-1?Q?m/gzgxdG8CsZaD9ydjKTqpgGoMC3M3meYEIjeoSqGamlJgC9nz9sfhk/m3?=
 =?iso-8859-1?Q?JE+VQVcZTh4jL5cZajwU5F4+m2ibDhTiB+5NdyQv5yIqfX2kUaClAHSF/R?=
 =?iso-8859-1?Q?2Z6JDPBwiEod6eODrtWstxlZlGIiIufcOrfmVBdzfWh7cdxJU/1i64UUXy?=
 =?iso-8859-1?Q?nMvIfhnGfOcjp99QeuE4vLNHVIyk7QxHP9JORvmJU1n+ZE4YRVEv15S53H?=
 =?iso-8859-1?Q?BgCZRX7Pd65fj95el7DrUJp9Cq3S3M3uCI8PoizwOz+PMpvpjH8ALdC2GY?=
 =?iso-8859-1?Q?z3qP9bxIW9V5dVvtFmv2criu+yKxq2uDerFMVriojED4wtrGUCGFwnlOjH?=
 =?iso-8859-1?Q?sAm1yWghbjDRV1Y0zivm+TcFxVpIuDQCIhLJ9abcX3F45+RbMmXTOuZaHW?=
 =?iso-8859-1?Q?M15GQLLSv5rFS1eROQFc1ueCRw9uBGtlWf45Su1SNkM/ujv5S7lt+GQcUu?=
 =?iso-8859-1?Q?ImNHsEH8yv?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe3edfa-b10f-47c7-cda2-08d8fc5d81fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 20:16:21.5536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aRW4+xN/XgY9cLwNLXfrJl4B+zFb0Dcpwe0C6B8XBqJCoNXlMYH0IqiYxQBYTVM5QwlYqbdiX1T/s9yOtf6Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6379
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210410_131658_877085_1A8976A2 
X-CRM114-Status: GOOD (  15.11  )
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

There is a single trailing whitespace in core.c.
Since this is just a single whitespace, the chances of this affecting
backports to stable should be quite low, so let's just remove it.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c739e4c5b621..288ac47ff5b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2909,7 +2909,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
-	
+
 	ret = nvme_configure_timestamp(ctrl);
 	if (ret < 0)
 		return ret;
-- 
2.30.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
