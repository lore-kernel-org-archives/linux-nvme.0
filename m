Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B096C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 21:17:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B20204EC
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 21:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N+IzFDvH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GtMTUYsU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gUgqmg/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B20204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xTF14JjEdR1lxI/Rt6f9RbUOHufFN3k8fuVjo77hX+A=; b=N+IzFDvHAm22z2
	/Rot9zvM6MIPj3f5cnVnydmu+5S59NjjMXEXeWsrXzLRboU9ylC3wFXI50j8WE0byahxm/PqKOR+9
	hN13yNga8uJ3/V4VN6v0ud1fAOG843TSih0oVTrKrAQic3wGp4IqpiHdwBTYvG91QZdSAKGMUdUff
	xUFOkwBWBUUHQXh6WgikUYZxyC4mMewrXDJuMeo1W+lRHc/vJpyK4a0ALJL+zZQjzTASNWf/gJtTn
	IH0QZb/Lg6mEzVhOAQespzRHapO712EwyNBRPutoblmWPFasdcwvuHV+FMv9nqRo7e8z603Hr2vRw
	JE57fS5wrAJwUrgXt7Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS6CM-0002Sf-Nt; Tue, 05 Nov 2019 21:17:10 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS6BF-0001Lr-Ef
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 21:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572988561; x=1604524561;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5jrAJplu6fyvGGl8jq0MJzuQPMduAgd8UrRFnDFP0Jo=;
 b=GtMTUYsU8MOFwkz6qiBTVHGDZkLYlhm2vffpgc0GSWSo3tVWlgYAgg2r
 Cg9Hp8ABBpagS54IoIBEgv+6V4IRU8VlzeE1BZcRkLkLWv719sZSZI/pu
 zQJuWzurI2bmvboq3zZkFRkSwgTLjmvnl1uBsJ8JjgCoubpFOW0Al8qEO
 qjF/wlhL+YzNCVjzXBOdLH8WNaf36AUxiY07gGrr5rfjD2malo7Qqo9Tk
 75RURMv6/Gt8N3fGcBgb4L+MTWf5GvOGDPiCSrYhBjW4Ykfn5tmCupq4O
 nG5UgFOLLPbuo0ECYVLRPmT1D3daJ4N1AqShTSjFYkLQuJB6DY9yDCDCo g==;
IronPort-SDR: NylYKA1y4G1qmXfQYNNxx53eh8x2Cr4kFnYsEQzjwCSaQqjnDOH4NkY9IRolu4tkfoc2EWsi8S
 bbTl0NHCMMKo/kyo2gZxXQliePEIRoBCEFmPFs+keKWKxcRNDkqHaMbtF1hJgVym2JIZXuBG0i
 tz6QADlL7p623pXNCxrqQ26fHNW3PNZrSbHaxZh3I9FM/qIFjZxIR4C7VMZ+3bmocqlqTrOQcV
 8NEqu/8ZfazMqfUfnII937I+5464aSYcUt3ezQqK75FuzgmU3FdU6Bgl4uF1SBhliZXxjkoKxf
 KHs=
X-IronPort-AV: E=Sophos;i="5.68,271,1569254400"; d="scan'208";a="229459770"
Received: from mail-bn3nam01lp2053.outbound.protection.outlook.com (HELO
 NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.53])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 05:15:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz/8v2VMqdMqgswwZgPFuI/ti6qJURrs4p0YkYtbiiQgZCRQdIsytPvc0JnoNRTpf4ImxPTePev/8M5I6kqTLV+aFgvkw5zvzR8PHscs+bMczxACF5sQJhmtf3dwq30dmTVIYfj+AycAwGmozg9RI7Ux1v4Af8YuZ4Ms2C2glrt0kMeqwo3t+YrlLvbMKpse6DpY8skOhrASAvJwDqkbFyBcJI4p2umF+WCgeXRxavVRCOKDSch9GuVd2Fec121O1ee4bE/eG/IIYNw0fec4ybmexgiIGye/6vlL7bmkfopUzc3GaObph6wa/JrJgc5DZ+zRX8msem2wiCgrGSv2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezyrMFRwBr+smCqG7S47xGdfdBxifrzxu/m/87CZUuE=;
 b=aFZ+aWdrD0dVW/Md7vx7o4nGEQwfE0k4QylE1MC/K3hoxYYcB9IlgAs5ZtWzllq6a6epVedJz57ke4lcmQ+3F7W7cy9yQBu8hcQdNknq2+9n4S2AXEVzKzcpz5TvtKK1iWqA7r7QbQ0BTXQda+Yam6bXYPN3O3grKtjQnhUOixtVyySgDLgJiN5q+P+G7yoP2BBqsN134zflT+qGNVnlhtEmJeFY8d01mAsnFp1by2sLrZay3g+Txi73yGiVPo6VKlimzL8LIak15jq0/yibLIO/sZwDK9+lH6DlN5/jAlAcLmBbRJ78/ZMY9cfCP4EByqBEkzO/hCLH7MbTSmurzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezyrMFRwBr+smCqG7S47xGdfdBxifrzxu/m/87CZUuE=;
 b=gUgqmg/PPEfOeCxBK8fjtBx06OcMHApN5udGsTeqOuHNyXrgcpF9l4hev2GwAO7pA1zEhy5ukdViXOKxfjqOSpXVgGAb6vR6/KvHTbveqtW1WCbd6kGtE+SJDbyDtf9e+DYxipUe8Xr5VJbkBSXBUcRJxUWvCGiefVJE0p6LyKE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4232.namprd04.prod.outlook.com (20.176.250.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 21:15:57 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 21:15:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Mark Ruijter <MRuijter@onestopsystems.com>, Max Gurtovoy
 <maxg@mellanox.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
Thread-Topic: [PATCH] nvmet: make ctrl-id configurable
Thread-Index: AQHVknJzonXLyg8iIUGihKEY8P7NbQ==
Date: Tue, 5 Nov 2019 21:15:57 +0000
Message-ID: <BYAPR04MB5749B8939E3DC46376A8CBF4867E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
 <409804f3-158b-cc3e-9b04-6499bfe1638d@mellanox.com>
 <3381ACB3-3ACC-4124-8925-09CED68BA11E@onestopsystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dce49502-61a7-4a55-5e28-08d762355999
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-microsoft-antispam-prvs: <BYAPR04MB42324B15F609C3177E6E9F5C867E0@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(189003)(199004)(64756008)(8936002)(52536014)(14454004)(66066001)(81156014)(66946007)(6246003)(71190400001)(99286004)(86362001)(81166006)(71200400001)(6436002)(66556008)(66476007)(66446008)(5660300002)(76116006)(7736002)(2906002)(74316002)(305945005)(229853002)(486006)(476003)(446003)(33656002)(316002)(478600001)(9686003)(4744005)(26005)(25786009)(8676002)(2501003)(6116002)(3846002)(256004)(53546011)(102836004)(6506007)(76176011)(55016002)(7696005)(186003)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4232;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xpW6LPyVd5Y8HkwDvNaAKM+W711vO/AeW7R7TSvr1hvgp7ykpRxHKRiq0x8fSVfuAwtOiKdAeR5dfNYddzbYLwNE7EoeiBLNnj83Npo6Fj49D0YhY2L/6KIwkvIDDVZ9nTYbJlIAznJTDkOhKvVOP3fC9yChN8ExBWDo1v5/cLkKC3BF9fG2MFbu6asRUVq20PmDgt1YfeGVc8J2Cz028tXCl82Ei7u+1mNr7yZpN+qr65MzRJyQSN07vg4IMplm+QsFMKz+D7swQuz16qP9SD2zCmWeYVnmChkaORE/jMSRbA8RmIAqwJ73SPPf43n76kEU9PKeBQANePYSxhBItFeiKjveiHuGN4IbYTDxcc9qCL7S9nNvKhf0awiqP0XA9nd4QXw1JscJ+T2RJ7/Ji2+RqhgPGw8uFOZLfqd+rnJwCnrWTsrUezmB+AeRMASQ
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce49502-61a7-4a55-5e28-08d762355999
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 21:15:57.1207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5L/LVFhBRzzQB0rB6d2oSpatQnPU4m4GMg/2ZJWnwDq2qv5tECIimOYjX+ANT4wAQJXnr4vDNElwsQQwj9Xzxd6k5Y82A4FBSf/BhUH33Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_131601_581783_B68BF74C 
X-CRM114-Status: GOOD (  14.25  )
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

On 11/04/2019 02:45 AM, Mark Ruijter wrote:
> Hi Max,
>
> When you create a HA cluster using two nodes exporting the same volume the controller IDs can collide.
>>> >>[1122789.054677] nvme nvme1: Duplicate cntlid 4 with nvme0, rejecting
> So the use case for this change is related to HA setups.
>
> Are you saying that the suggested solution to this problem would be to force the user to use the -D option?
>
> @Chaitanya : About the proposed patch:
> I just tested it. It does work but it has some issues:
>
> 1. When you read the attr_id without writing anything to it the controller id seems to be 0, which is not the case.
> I think we should fix that since this is confusing.
>
Okay, will fix in next version.

> 2. When an initiator has connected and  id_simple_get was called we can still write to attr_id.
> In that case the generated ID will no longer call ida_simple_remove() since subsys->id is now set?
>
Hmmm, let me take a look.

> Thanks,
>
> Mark Ruijter


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
