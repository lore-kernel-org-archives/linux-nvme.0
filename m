Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEDEC1975A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 20:00:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7ED320738
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 20:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="daFwAlPs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="J98lOg2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7ED320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=m9izwmTd1Ikdvnm2DbTB6WI764t0DzR4u0DbsWOE9/k=; b=daFwAlPs0TyIuzpXrMaFUxUVw
	28tQ8/yS//93QJS1Li2pM9Rd8yD6/WxLfojCk6GroieqHVO+GtrR8qUhTpuFSvTOUZsvSe+/zorZm
	Htr0nLdApyMyQQB02kTkLjbHkQcdLpXows7PAglyoqbKKul9NV88j9NokkGWIFos0Yz2jLA4C3R/O
	s8EBuuWEzuY6d9NQggseKI2F8UsToIUCOst/CJAshQubWcVvSJzpA73G9ZCYUxJwdaUl4rLF7jl/0
	Xce4rLtK6ooI09YTKe7ps5b2oW6IWhpF72PzdO9mlPvQ+Qz01yjyCJl+4BGG2GzSF61iu11ndN1JB
	V0v+rcJCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEINt-0007X1-Kk; Tue, 17 Mar 2020 20:00:17 +0000
Received: from mail-am5eur03on0615.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::615]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEINJ-0005gp-MV
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 19:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym2JXsMXaWfsqHVV+oXBidTjis5pBUr99jmnAItoRS6KOLnoU/Rcu172Z9h6GDyk6yyPgKGqihwVQLVKoXJXkEVysNsID9dpJLyEcPdWReQoEB0A2OpfgxNVf+Ch5cLHsRQeiluR1Dr5cCc47YmXDViBkIFtDvTSVMDOhLUNWBRCKcBD0oEjv40Jfw/w9Iqpu0vvinhOaQrXIPpwdfk4MXm4DSW39YXYra1x4BiTTd2XHSAgO5xHLciqkCfdfwg+SCJkmhBLrGP6dEJnh5wZ+3KeHa3+f/JI8FspDP+eZzUcgGmmWEdwZuj/tfkLXaoMta6uAo2q6WuDgZkejaNUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOv4P6Vqwf7iZRgfhwCMByH2D0pS4SdKgenwWGBMy0c=;
 b=Nyn4Q7LBnDf1cG45ltQS3wig5AgkWuuDTMkD5JNhLBEm91E8hw3/gMxd4zw4nM9TI2RHMvmwU1GpNv64vTWLEUSX6CPPzao1DqInES0eCf0pezgPhFFfkP2XcaF+MozcDeQVybFCO0Tx8mgcPbGUiETiSdx8mrlbMkfPVs/Nh1lXYrCiAXb8gSsYvks0/FZBmG/R/qpdUlUmpA4/GPs/xwCp1vInN6AtqICZgu0pwK1oLuwPbUzt3Lhz0dhMF37pFPEcdmtJoqZ9tIVE+hk3nMAbmO6m2lbicMN5CaDycDZC6DQpqbSLCYoLknIO5wb8xSnS+FPkzEN4P3HHEhEAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOv4P6Vqwf7iZRgfhwCMByH2D0pS4SdKgenwWGBMy0c=;
 b=J98lOg2LmAQAl8jTaj905Z8maDfr0cQTN1Y2HXcJlYw6Fq26lNWvNe7ddFFjocWNMIOGsno/aILuajpOkrLuSZrbk0NrjKDTb7rLgk/9PCVqPkXNU9ObV251XAPt+ZglRQtXF7nxw228XePRafuKG6p61sMnIaqfIHOvI8ufGgw=
Received: from DB6P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::34) by
 VI1PR05MB3183.eurprd05.prod.outlook.com (2603:10a6:802:1b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 19:59:32 +0000
Received: from DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::3b) by DB6P192CA0024.outlook.office365.com
 (2603:10a6:4:b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 19:59:32 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT040.mail.protection.outlook.com (10.152.20.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 19:59:32 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 17 Mar 2020 20:25:07
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 17 Mar 2020 20:25:07 +0200
Received: from [172.27.14.181] (172.27.14.181) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Tue, 17 Mar 2020 20:24:31 +0200
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
To: Jason Gunthorpe <jgg@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com> <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200317181036.GX13183@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <290500dc-7a89-2326-2abf-1ab9f613162e@mellanox.com>
Date: Tue, 17 Mar 2020 20:24:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317181036.GX13183@mellanox.com>
Content-Language: en-US
X-Originating-IP: [172.27.14.181]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(199004)(46966005)(70586007)(81166006)(4326008)(70206006)(2906002)(81156014)(2616005)(356004)(36756003)(4744005)(37006003)(54906003)(336012)(8936002)(53546011)(8676002)(107886003)(16526019)(47076004)(186003)(31686004)(6636002)(26005)(478600001)(16576012)(86362001)(316002)(6862004)(31696002)(5660300002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB3183; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e40bd954-3012-41c5-304f-08d7caadb5fc
X-MS-TrafficTypeDiagnostic: VI1PR05MB3183:
X-Microsoft-Antispam-PRVS: <VI1PR05MB318393DA47B90AB50538430BB6F60@VI1PR05MB3183.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITpHa1c3tGTS4ZOzAmPGwxsAoOHUXt9+yKNlNhsTDOthwf11pO0/PYG51HKf5AEY8XDaxMuVe26mJ5mV2TO1QbbPuzBMkgKQHUKQN9GaU9pCjmyuQhwomRj7B7z0NoNtInZxrBxkOO9KJOCkfdEoHRR04dCskoC2xSqMuaISyl7TLpDBMvH+XOAUMyY1fSNDC+Vb1jkEtT6SVVv7cR6GIr0CEELxWemd4T54bYh08uBXNBFp8Vb7s4QkI6gSCGGCKxlzu0EBSdXDVbOsJNi5RshAt3Ma9DSFq4z3XxOXPD6jA67QaKpQHZWtAw8EYeOkAUluW7fJz0cJO4NTQx1rMSyLQR7STn7L1q9+y9fLbb44aNQsnBbGaCLYNNxBopBrz2TZ/JxX740eeo0RjhQlNk1erkpFQ9f6VC1pQKtr1ff1gjunKA0AJKfoinBpEvHe1CPcet+F+xeJG7DOxE7DxRejOWpH14M2+qCDOfDSlAN5uJL2G0ZQjGlmpMTQZT1hBUDWJ6gTjGI+bYknLs/e8jwKDZ8ZLhPl0H+lLxqodMk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 19:59:32.5639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40bd954-3012-41c5-304f-08d7caadb5fc
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3183
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_125941_809292_A7AF3E81 
X-CRM114-Status: UNSURE (   9.66  )
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
Cc: loberman@redhat.com, bvanassche@acm.org, vladimirk@mellanox.com,
 idanb@mellanox.com, linux-rdma@vger.kernel.org, shlomin@mellanox.com,
 linux-nvme@lists.infradead.org, Leon Romanovsky <leonro@mellanox.com>,
 dledford@redhat.com, oren@mellanox.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvMTcvMjAyMCA4OjEwIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gVHVlLCBN
YXIgMTcsIDIwMjAgYXQgMDY6Mzc6NTdQTSArMDIwMCwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Cj4+
Pj4gKyNpbmNsdWRlIDxyZG1hL2liX3ZlcmJzLmg+Cj4+Pj4gKwo+Pj4+ICtzdHJ1Y3QgaWJfc3Jx
ICpyZG1hX3NycV9nZXQoc3RydWN0IGliX3BkICpwZCk7Cj4+Pj4gK3ZvaWQgcmRtYV9zcnFfcHV0
KHN0cnVjdCBpYl9wZCAqcGQsIHN0cnVjdCBpYl9zcnEgKnNycSk7Cj4+PiBBdCB0aGUgZW5kLCBp
dCBpcyBub3QgZ2V0L3B1dCBzZW1hbnRpY3MgYnV0IG1vcmUgYWRkL3JlbW92ZS4KPj4gc3JxID0g
cmRtYV9zcnFfYWRkID8KPj4KPj4gcmRtYV9zcnFfcmVtb3ZlKHBkLCBzcnEpID8KPj4KPj4gRG9l
c24ndCBzZWVtcyByaWdodCB0byBtZS4KPj4KPj4gTGV0cyBtYWtlIGl0IHNpbXBsZS4gRm9yIGFz
a2luZyBhIFNSUSBmcm9tIHRoZSBQRCBzZXQgbGV0cyB1c2UgcmRtYV9zcnFfZ2V0Cj4+IGFuZCBy
ZXR1cm5pbmcgdG8gd2UnbGwgdXNlIHJkbWFfc3JxX3B1dC4KPiBJcyB0aGVyZSByZWZlcmVuY2Ug
Y291dGluZyBoZXJlPyBnZXQvcHV0IHNob3VsZCBiZSByZXN0cmljdGVkIHRvCj4gcmVmY291bnRp
bmcgQVBJcywgSU1ITy4KCkkndmUgYWRkZWQgYSBjb3VudGVyIChwZC0+c3Jxc191c2VkKSB0aGF0
IExlb24gYXNrZWQgdG8gcmVtb3ZlIC4KClRoZXJlIGlzIG5vIGNhbGwgdG8ga3JlZiBnZXQvcHV0
IGhlcmUuCgpEbyB5b3UgcHJlZmVyIHRoYXQgSSdsbCBjaGFuZ2UgaXQgdG8gYmUgYXJyYXkgaW4g
UEQ6ICJzdHJ1Y3QgCmliX3NyccKgwqDCoMKgwqDCoMKgwqDCoMKgICoqc3JxczsiID8KCkFuZCB1
cGRhdGUgaWJfYWxsb2NfcGQgQVBJIHRvIGdldCBwZF9hdHRycyBhbmQgYWxsb2NhdGUgdGhlIGFy
cmF5IGR1cmluZyAKUEQgYWxsb2NhdGlvbiA/Cgo+Cj4gSmFzb24KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0Cmxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
