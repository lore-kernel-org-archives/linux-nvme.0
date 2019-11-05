Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F02C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 20:36:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8059F217F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 20:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A1ZGxCbQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gWZekd/y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Mf7jUMIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8059F217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=vl2vp9hpYvwo6ARuHuzcV6jtK5mdOf2fQ82HSE8jAyc=; b=A1ZGxCbQyzeelZ
	tysT/AJB2PwohjyRKBxwpFEkL7XR4IJiQOS/FSGnXaffXFZm4pCIqTZRtqbXHQh9v8Cxf8bKCSkkt
	U9coU/4rc52IG99PfRaHN78nXRTiNv4kkY1bq/77dm2c0QJyBC6ZVxy6E78YQ0mvmVY5TpcBOZdP1
	2cU2ayqwKIXp6QEKc8GxhRPtQBKRX8glG+OS9nUpzi01ai6BV065E681L/8utTsJ2CGMKqZV1XUrs
	9iNuRtGQB2wejjOCAV18IvhX8SRGbRDB8Tw76/EOG5l2h0crlr/XuustYHgXlD+DSn43fac6qFrOd
	8Kz7LJ4qaSpMnf3nXM2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS5Yb-0003ZZ-I6; Tue, 05 Nov 2019 20:36:05 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS5Xs-0002pB-Aq
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 20:35:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572986137; x=1604522137;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DGqHgVT6o+F6ap5qKOle7MtQHGpeA265lC1bS7eHaXI=;
 b=gWZekd/yWJoUjVpHo326FVqswHOeoRR6wJ6kO+aJTvfF3pbB0/+XQNrL
 N0bDs00PQ1a+vSGKLnX2h57uURJztFfCs9HrW/wJuYvIGEwfFNdDipkai
 XrmRPD+nwD/4ZnRE4l2dpBUG6mEQVGjiLgFLo81CJ8kZd9EpXxvAC8rDs
 8fwtocj3Ck0qrHRjv7joMvA7itF0lfTuQA3w/s9j1SPmrUTv7CFcFbphe
 6iE4GkT0IiMpb40n4dHXqcwtPJY/e1yMm0PYeg4EE7kikM5t/QsLTtbvz
 RIjWaaR5rLU30B/DZcYxJASMQUIrSPN0my2+cBZiMiIOgLBXUrXgplTNU w==;
IronPort-SDR: suYyt5uunl4lhW3QvccydF10KYt8vkCmseZ7xh2W8n6c7jwybD1XDanF76b7Bpd5ksb9RUaH73
 UtKIOhX1kL41PeFbttZHQcSrZolCA3rbuCW/A+Am/7kRQKqhBMSqcnGOGgJDEk0gLqL7M+RrBU
 fa5+qXv7F67UIC411O4YDeuruVCjOH8fShUcFvenB6N9HQtdwdEzA86VF64zWa0EeFXfXC8ql9
 zH8MhjxOnKBsYJmkrJTxzz2nOOO7MZT4ZwGW7ciHwdaZQllKmgQjEl1lbaBptE8sIY+qRJ5bV6
 Y4w=
X-IronPort-AV: E=Sophos;i="5.68,271,1569254400"; d="scan'208";a="223401953"
Received: from mail-co1nam05lp2059.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.59])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 04:35:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1ytvRlQbS/Vg/MczkbTM9LucpYarNkAAXXXFlQef98M6ClOhduT87lgjm0JsXg/f9FXBtu9gVP1uVxXkGH6vBIddP+Issnj6CHgqFLk8FVab9Dia/yhkia4mm4eDUsp/ryv7I3NFgWoUprjjK/Chzfuidcsdd5nBC+OorZhw7Vb+7Gij3V5HxGO4zoh8dvHEG56E7GLT//dDHq45smMnSvHfDnWbMP0WWH2G98SgJ0zI67vJQQrbHuHWY/avxEr87WbaU/J1Y9Exq/wkk4yD7GP7CKsr2F6p0TeAL3jqo5e0NVTw4xT8scvUhwoXK1cg550NKgpRePcxLmYKrbXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGqHgVT6o+F6ap5qKOle7MtQHGpeA265lC1bS7eHaXI=;
 b=J8MtgSlnD+klPpAPHyjK2V4Fgzc4lmjyZDwIQRQvuWV61Xlo7EiGaN658ql2+yckVGgfb1nk1zf4KR4THqEKZPi9S4CntmpQ8ihC8gVYT8m9UW7J1ygolMKn5izAohuON8iKNa7BnLHtOP+8HT44l+IIK8qCuK9gxu85qUOwMA9HG5KDPyIrtg29Lu5aoUGVtRE15oJjevcGdZ67ldslhQ5AWc9q/9hZMWxSM5YisMjEvhherG1aaipvnQHSFmqYs6u1Ps5WI4n8OdY3Exys/VbxQpvrz5ELUfaGIvv4FYjMnGV5Pj7syNhnNyVIW5MV+7UtACi98tb+Dyom/bxFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGqHgVT6o+F6ap5qKOle7MtQHGpeA265lC1bS7eHaXI=;
 b=Mf7jUMIRAg/9PqtWPvmPrjv24EMLVC8w/eXgBFgeLmBfVxfDzK8ytVYESt2hmapzocdKLHnvBKvoK5ya3XSg9+vsxwd5razo84wg14EECSooFZPk41wSt0gdYaL1M+Ne1i5W9knvKUmziex1aM+otGv2ubWBqVU5j2cNZTUczsg=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5782.namprd04.prod.outlook.com (20.179.58.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 20:35:12 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 20:35:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] nvme-cli: Support for hugetlbfs
Thread-Topic: [RFC] nvme-cli: Support for hugetlbfs
Thread-Index: AQHVlAerkyjbQe3UI0qavPe5Wq3/6Q==
Date: Tue, 5 Nov 2019 20:35:12 +0000
Message-ID: <BYAPR04MB574927DA082B5B78D48CB9CE867E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191105183412.333-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73ec475d-a81f-4ed7-c462-08d7622fa89e
x-ms-traffictypediagnostic: BYAPR04MB5782:
x-microsoft-antispam-prvs: <BYAPR04MB57829794BBA4B5B235C480C2867E0@BYAPR04MB5782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(256004)(9686003)(8676002)(316002)(102836004)(4744005)(76116006)(2501003)(66556008)(66476007)(305945005)(6436002)(3846002)(71200400001)(14454004)(64756008)(66446008)(66946007)(6246003)(476003)(478600001)(7736002)(110136005)(2906002)(74316002)(86362001)(53546011)(26005)(186003)(8936002)(6116002)(55016002)(71190400001)(25786009)(66066001)(33656002)(5660300002)(99286004)(486006)(81166006)(229853002)(81156014)(52536014)(446003)(7696005)(6506007)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5782;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5cVdKoxtVWOqdblA/os8fQJHjCDXWLYnQaYkcJuY9mqhlywmozLjaSysVQQ9t0v2daRtJ+QDdWTzh8y5CulGwtFUt57DzWq23D+jqfh0hDzbwd9sjMjJPpneNyIYmxKODjVdEzR8kgCcM3vhPytLb9VLo6xYhQ/jFAcj7D1UvecsQ0b6bXk5cXk/KLxZe51ZyJK3fUybIYQGv84bAYt00xtMJXALMpvOsQmxm51bwBmL26My3w0A9SDVFPEmzE6iwxnY4a92NAnVswz+Xi1aERfsJVhwJixxS2V53B7z+4PSBCGKQZopqz8riUjywbNk9rH2ZhdY9V43UYxdhm597b2boQzZEw+3tBTpkadSw3H1h1rWhW7yABtrBOnuArBhnaJ7M0xEjBKhkevTGqmZFWx4uYm1xigxj20pFaYKscftW8WzyXxl1q7KYDzO/rV
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ec475d-a81f-4ed7-c462-08d7622fa89e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 20:35:12.6777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYb3o/81muf67j4wNDDhChGGuA9rCeAVUseq8tKHrECqjso71MYBm9+pIJQn0xT+2V1hF2kNqj0KgpJeGPR2OznPA7eibhsaXGvrZogPnik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5782
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_123520_621809_2446047B 
X-CRM114-Status: UNSURE (   8.59  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks Keith, this very useful, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 11/05/2019 10:34 AM, Keith Busch wrote:
> Some commands require exceptionally large data transfers, and the
> kernel driver supports only a limited number of phyiscal segments per
> command. To help support large transfers, try to allocate physically
> contiguous space via hugetlbfs.
>
> Rather than deal with the nuances of allocating huge pages, this patch
> requires libhugetlbfs be installed on the host system.
>
> Signed-off-by: Keith Busch<kbusch@kernel.org>
> ---


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
