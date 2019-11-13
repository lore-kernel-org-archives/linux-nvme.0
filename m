Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86601C17449
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 13:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B744207FC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 13:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YJtTdfVy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ItxffCSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B744207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SPAGxbFMBxywodLcR/aCOR1rJJfL8XikWxqEDDI5NKs=; b=YJtTdfVykpv7MGDVUD8vgIgFK
	ni70A59P3semElQ+gmstpvZCAtvjp2NhIkKkYRbsLW7BH5/5wgq6EmTqNKTJt/XMyeU/GGzX8WwIM
	LdDKMMD0rZEnDcB+IypM4FIMtK8/3zmt2Gxt7gwaXm2bpp1bIpOEmhnTjCexEZQKH3PyH89DMla2L
	pRkVFFMubdsEGZYGLCToQ1MdEuMKJ4JTONj5kM6dSDGYlNUke8hfkaewHngNMPlRBtk8yaDjBME9D
	1SqNAwGqfeqwwOdskzvfoBdYoTaJj9vxDpdOYJgDU3TU228wjUxXoO9qQuK2RMaXN8rL039B8G556
	QePQNPQJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUt98-0000iE-Jv; Wed, 13 Nov 2019 13:57:22 +0000
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUt96-0000hn-6n
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 13:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBLS2M/i29szpoKiAP4vC/3skpywXWE6slBKlQSD7YXYNFJgRYwaDyaR8P5/5GaoaUDKvf5SE8lvWAXBuFU/SaVX8bQfkN0ox8UZ3MrvEDQd261i9nKnPjdwur+MlUueOToRNW2nGCrtw675kk2R7WdVNvm8nL9+KAFzwESY8tYhl1xUP+QqYRO/NZhET3QT2wBQO6PDbZ1m7ms0lr9/Ua3VBadk9eUl4STxFxZjc85medR9d4YL7Ms+TXGW537szs2Evm8ZEpCX2bgvjfJsJp2WS2/IrP+Z3IyCOraj3UmYu0Ns4/dn7jZWtzvVasvSS8UgeMImJ7u+nVCtLt3TVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQUO5LjMKx52vXEvReTSzqGIo0RBdqQIOubPOYK96Do=;
 b=T2C3+lM/NUGiw1AC8D5cAS/T/lVOF9ur9V7ElDsBWA+PRVr5SOXiiztLNj4C1CZvYM6yniN10FzWikO4s2ZFkU3KwACKNdl2pnNzSEcfKy3IiP2OTmO46u+qvv8e1+PLt8hBCe9XakTrhyamYWlOSJ15zdJGPpyq4vmZMQAihmd0t7F86iiVlBaamW7OzJXC+oo9jKefIcua0hifaOl5AcKJ1gE9KGFV0y6Thafay9YiAA7VM0zSXX2WAi42oCAJgGVU0bTfemGHSm0hKJMxNkiHnuaUOiNlscjSYqy/hj/LzVCGajy7bH6fxdFv4wKH3U6po4B11O2+aTUrGcJ6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQUO5LjMKx52vXEvReTSzqGIo0RBdqQIOubPOYK96Do=;
 b=ItxffCSLiQbtZm5+rtblID4wmlYZu9nBslCcj4KTZAvsiRI+oD4/6eRBNtuWkmUI4mxgv8h2CXpcmYf2kBA6bxSmvk7Ld55s6DeRjy270Yu6EvcNdLVWX4sn1H/1y5usr9AXo2WT5wZPmx3fuko5c65STqP7fodbmym2ZFAaqEU=
Received: from AM4PR0501CA0064.eurprd05.prod.outlook.com
 (2603:10a6:200:68::32) by HE1PR05MB3388.eurprd05.prod.outlook.com
 (2603:10a6:7:33::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Wed, 13 Nov
 2019 13:57:14 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by AM4PR0501CA0064.outlook.office365.com
 (2603:10a6:200:68::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Wed, 13 Nov 2019 13:57:14 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT061.mail.protection.outlook.com (10.152.16.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 13:57:13 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 13 Nov 2019 15:57:12
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 13 Nov 2019 15:57:12 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 13 Nov 2019 15:53:01
 +0200
Subject: Re: [PATCH 15/15] nvmet-rdma: Add metadata/T10-PI support
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <kbusch@kernel.org>, <hch@lst.de>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-17-maxg@mellanox.com>
 <24d8febb-7ddd-3461-dd60-aa73b1d58f1c@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <b2d3e64e-73a5-0f32-f945-3b463e4dffba@mellanox.com>
Date: Wed, 13 Nov 2019 15:56:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <24d8febb-7ddd-3461-dd60-aa73b1d58f1c@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(476003)(126002)(2616005)(11346002)(486006)(446003)(31686004)(26005)(16526019)(186003)(336012)(107886003)(4744005)(6246003)(229853002)(50466002)(305945005)(53546011)(2486003)(106002)(65806001)(23676004)(65956001)(76176011)(47776003)(36756003)(54906003)(16576012)(316002)(110136005)(36906005)(7736002)(58126008)(478600001)(2906002)(2870700001)(81166006)(81156014)(70586007)(8936002)(8676002)(3846002)(6116002)(6666004)(356004)(86362001)(31696002)(4326008)(5660300002)(70206006)(2201001)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR05MB3388; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d86fc2b0-6e73-4f61-f687-08d768416311
X-MS-TrafficTypeDiagnostic: HE1PR05MB3388:
X-Microsoft-Antispam-PRVS: <HE1PR05MB3388E250870BA7477A000349B6760@HE1PR05MB3388.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0220D4B98D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oi688SrtJx2XQ9NGTXMNob31L2CwMKxlYI1rILPL3pcY6iYoRDa4Tn76AD2ANXhFkv5eeJCnZN1DOMJa/GprG09KbTdkLDFFTQneX9KWWvBvNrXiIT4RDRQSkFYjLsfrKZBLBNQMg6PysxAg35t7GVKt3OYONqX73N0a/Szk29e1Kxe5whkeuGhyvjNpfpcbqoDr1YiBw86Eu5zHBhV3KQtG+rumgUCkE0pVOYqJ1KZGHKSDQSD6sOGsDKaebwYvdoxCdKnyKY5oI1UBeAU0cbky3WqXhR+Qwsb65wsAHDvRilsHL5D8zXFqbQ4X2K5uh7jWurJwhSiD2oZgg6ad7WTwgxxL1w/ECSDX5MDpeOy2NLSgvYFxLPv1fuLV3aB7TTvCu/1da/kjiTGGgbWl3OdEkNXBrLfQq1SOBvOMK7+9c4bG+VQ6yHR+ErXRs7DZ
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 13:57:13.8057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86fc2b0-6e73-4f61-f687-08d768416311
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3388
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_055720_320738_B6C6F864 
X-CRM114-Status: GOOD (  10.17  )
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
Cc: israelr@mellanox.com, oren@mellanox.com, idanb@mellanox.com,
 vladimirk@mellanox.com, shlomin@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDExLzEyLzIwMTkgODozNCBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+Cj4+ICvCoMKg
wqAgaWYgKG5kZXYtPnBpX2NhcGFibGUgJiYgbnZtZXRfcmRtYV9waV9lbmFibGUgJiYgcXVldWUt
Pmhvc3RfcWlkKQo+PiArwqDCoMKgwqDCoMKgwqAgcXBfYXR0ci5jcmVhdGVfZmxhZ3MgfD0gSUJf
UVBfQ1JFQVRFX0lOVEVHUklUWV9FTjsKPj4gKwo+Cj4gTWF4LAo+Cj4gSXQgd2lsbCByZWFsbHkg
YmUgbXVjaCBiZXR0ZXIgaWYgdGhpcyBjb21lcyBpbiB0aGUgcmRtYV9jbQo+IHByaXZhdGVfZGF0
YS4uLiBIYXZlIHlvdSBjb25zaWRlcmVkIHRvIGdldCB0aGlzIHRyaG91Z2ggdGhlIFRXRz8KCmNh
biB5b3UgZXhwbGFpbiB3aGF0IGlzIFRXRyA/CgpJbiBnZW5lcmFsLCB0aGlzIHNvdW5kIGxpa2Ug
YSBnb29kIGlkZWEuCgpJIGhhdmVuJ3QgY29uc2lkZXJlZCBpdCBzaW5jZSBpdCdzIG5vdCBpbiB0
aGUgbnZtZiBTUEVDLgoKSSBndWVzcyB3ZSBjYW4gYWRkIGl0IGluIHRoZSBmdXR1cmUgKHRvIHRo
ZSBzcGVjaWZpY2F0aW9uKSB0byBiZSAKY29tcGF0aWJsZSB0byBvdGhlciBudm1mIGltcGxlbWVu
dGF0aW9ucyBiZXNpZGVzIExpbnV4IGtlcm5lbC4KCj4KPj4gwqDCoMKgwqDCoCByZXQgPSByZG1h
X2NyZWF0ZV9xcChxdWV1ZS0+Y21faWQsIG5kZXYtPnBkLCAmcXBfYXR0cik7Cj4+IMKgwqDCoMKg
wqAgaWYgKHJldCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJmYWlsZWQgdG8gY3Jl
YXRlX3FwIHJldD0gJWRcbiIsIHJldCk7Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
