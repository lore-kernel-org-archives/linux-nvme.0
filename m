Return-Path: <SRS0=sr50=5O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B15AC43331
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 08:51:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2859720714
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 08:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uJkbAJ8O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="U74NSn/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2859720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VqiXYvxTT3AXijmdeP3pqT5YcRhr4hGIB5/S08nkGCo=; b=uJkbAJ8OAMyd7CCmETPaXRryx
	HjhbM/K7SfYOz6cuD8iZ9pTjZUdPFywqoPSEntCJ2gJEOfleBkRGMWFSZsZxZyhg0UnotRi2q0P4g
	MLjLTli0KHJmvbPKjheYcezY8lvqn45h1CRVb0m1Wa26eJHL9J+p5I2d5/CbEKZ6eb2TWL7XeH4KT
	WrnO3xBHV4LIzvdtOyOFnQSpnTBs19LOBaJBtU8eiQBJ1bs/OpE6gIE6USSMyE+7X0ca650xZwxNV
	vPgMbWYgJSh6Yx+tb2H4dv4pZCyFrOY1e+GwaTh9p18D9aL/9K8drMiwai9t7ZSsGObe7hplMhNcC
	weiRXlyug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jITes-0000F3-BS; Sun, 29 Mar 2020 08:51:06 +0000
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jITep-0000DJ-BV
 for linux-nvme@lists.infradead.org; Sun, 29 Mar 2020 08:51:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9hfQd7gIlPA+M38LuNmFE5KbYqfUSpxwyne7dhbB9ZX4en8AQhj1Ehxrp2IFDUXqtSx74+Mr0NTTodprU+6VJp2SEBJaeX4CFsFuL4LM6HsS2f1JyccNE6CuKpJlO7OVwps5o+XPi/SY3ueAwSVgGOGKZexQWABd2D7YSK9guG5W2+7KWse61hztzxvBoYM6LpVBolskI4bTBBP3Ci055q1YKdbXOccsWY1iwHdBQVk4Ef/qLuG0irddMjWH5FqiRguaCHh1xc0aDTCR6Xm0dAElYGvzp0y/2kNZBdSXM/uDHPGZ9jhhrhkCAYxi7VRTgmgRrj7bbsSllh9LGd/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74NdpkEta24PYA2UmNHz5o34ZC+b7UXOMW9CfITiP/4=;
 b=Bc+dVUSrmvyIQEUi2ZxcajZBRqEJfoqRZqZmZCTu3wWFwmLwstKscv0P4S1FRoynuCw1WBKB2vgCCILFXTDybm/Uz0bCojBZ1Z3um4AahLpAQUnZXVFyzwZXVziJzDvHiia1C+L0EgXQl4JbLhNJJpoZeMHPYLaYIKevb9Rnb5F3hQkUc8koPwyzyFjcbXnaZCEoYkZuZL9eRktpZ6mOrJaaelier0/p8KMm5jkjUTz8jEfTNPCz3zRWPkwMk0gvhnfTovk8HK4daAhr5S3+yrX+vlwrzrZG6fJFVmsAxjX5O2c1VZMuDPqK9V+4/Gv57VWzq2PGb38TDl4xtl75Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74NdpkEta24PYA2UmNHz5o34ZC+b7UXOMW9CfITiP/4=;
 b=U74NSn/uWpxfmV54SYocem0/gnMMZx1jMESooYA1Ioe4muRjXNhYD6D+DR3ZI6/R6yq0f9QtLsnOkBpsfmN5qH/1WZi7zJqx3JlG+lBVyw8EC25GglSs7v2U5CiTglJ2wND5Qpo01YIAI+50auB+LxiGPXa93tMxjoIhcMgb3Ko=
Received: from DB6PR1001CA0002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b7::12)
 by HE1PR05MB3177.eurprd05.prod.outlook.com (2603:10a6:7:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Sun, 29 Mar
 2020 08:50:55 +0000
Received: from DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b7:cafe::6b) by DB6PR1001CA0002.outlook.office365.com
 (2603:10a6:4:b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Sun, 29 Mar 2020 08:50:55 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT049.mail.protection.outlook.com (10.152.20.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2856.17 via Frontend Transport; Sun, 29 Mar 2020 08:50:54 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 29 Mar 2020 11:50:54
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 29 Mar 2020 11:50:54 +0300
Received: from [172.27.15.226] (172.27.15.226) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Sun, 29 Mar 2020 11:50:53 +0300
Subject: Re: NVMe Over Fabrics Disconnect Kernel error
To: Sagi Grimberg <sagi@grimberg.me>, Anton Brekhov
 <anton.brekhov@rsc-tech.ru>, <linux-nvme@lists.infradead.org>
References: <CABY-YC7eHFjb-TpKf2ioPJNhZ8RccYsrR-oU=wmt26z9AUNebg@mail.gmail.com>
 <a7da72d0-ed3f-ab5c-a72b-1b0518436a2e@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <e4f3f68d-a4a7-e799-c3b8-1d600e3888b5@mellanox.com>
Date: Sun, 29 Mar 2020 11:50:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a7da72d0-ed3f-ab5c-a72b-1b0518436a2e@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.15.226]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; CTRY:IL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mtlcas13.mtl.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966005)(31686004)(70206006)(26005)(70586007)(356004)(8936002)(186003)(82740400003)(478600001)(45080400002)(8676002)(316002)(2906002)(16576012)(81166006)(110136005)(47076004)(6666004)(36756003)(2616005)(86362001)(16526019)(81156014)(5660300002)(966005)(53546011)(336012)(31696002)(3940600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad2eaee8-0aa8-4fa9-6078-08d7d3be4af8
X-MS-TrafficTypeDiagnostic: HE1PR05MB3177:
X-Microsoft-Antispam-PRVS: <HE1PR05MB3177A682427F5AA027345285B6CA0@HE1PR05MB3177.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 035748864E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIDuMSwZbUeSnnZmhngqGt6F1uHpQ1L+zjJnv6c5umxHpO3QeK6VkcG4ivwWZkoetHBMc2Rpv+7QYuFilobWq+yGgmSXfKRLioTklFgemjSPOFqCfnr90b4tes2a04hh5KhYtozSPqC1S/AuQ5y3l84x0pIltashq2fjC62e+e+4Zkmkp7u73thJnQ/z1yZsYaoE4Av5GyTMzN/tWsD1jTpICrw3YQp9YGeBon+C8Hb6yewodEAvQvs4i2kAcLwiQkHYORtTuMoyKe8VLhQVER6DqgcLdxmvdL+C1YjvGJbPQaINXM5Fwtby+2FzHrt21P4hZ2QKML7nnMKpajFRexHPy5hqjhQxqYjGxqiqBIAbySN0Td5rALImG52hL4oBDueiQeJW22S7PXD8/g1bKLrkTtX9GbzYvpHihVZtML8szFDWV0IPVsh0r6TyUWxvF0Bb5fweX7mQZxN3yCnBMB+L0RfkN9PliFHsij0R4ZgfPUehAyAwwiTAnNqk/1KWndcZIPsl3ipINaU8rJyeYb3EnJBkAjfqq8blD5DKJJQwM537Xg/NJwDZkjIiTgiTkct4FaAul1mkR/2MUBRlc04mkUnRk88S6GCtTB99ftHQgUhkTfhzXzDs3zj4sn59
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2020 08:50:54.9331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2eaee8-0aa8-4fa9-6078-08d7d3be4af8
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200329_015103_740956_F5D60C5A 
X-CRM114-Status: GOOD (  10.73  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvMjkvMjAyMCA3OjE0IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IEdyZWV0aW5n
cyEKPj4KPj4gV2UncmUgdXNpbmcgbnZtZS1jbGkgdGVjaG5vbG9neSB3aXRoIFpGUyBhbmQgTHVz
dHJlIEZpbGVzeXN0ZW0gb24gdG9wIAo+PiBvZiBpdC4KPj4gQnV0IHdlIGNvbnN0YW50bHkgY29t
ZSBhY3Jvc3MgYSBrZXJuZWwgZXJyb3Igd2hpbGUgZGlzY29ubmVjdGluZwo+PiByZW1vdGUgZGlz
a3MgZnJvbSBzd2l0Y2hlZCBvZmYgbm9kZXM6Cj4+IGBgYAo+PiBbwqAgKzAsMDAwMDg5XSBJTkZP
OiB0YXNrIGt3b3JrZXIvdTU5MzowOjgyMjkzIGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAKPj4gMTIw
IHNlY29uZHMuCj4+IFvCoCArMCwwMDE5NTldICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1
bmdfdGFza190aW1lb3V0X3NlY3MiCj4+IGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KPj4gW8KgICsw
LDAwMTk0MV0ga3dvcmtlci91NTkzOjDCoCBEIGZmZmY5MGU4NDkzZmUyYTDCoMKgwqDCoCAwIDgy
MjkzwqDCoMKgwqDCoCAyIAo+PiAweDAwMDAwMDgwCj4+IFvCoCArMCwwMDAwMzFdIFdvcmtxdWV1
ZTogbnZtZS1kZWxldGUtd3EgbnZtZV9kZWxldGVfY3RybF93b3JrIAo+PiBbbnZtZV9jb3JlXQo+
PiBbwqAgKzAsMDAwMDAzXSBDYWxsIFRyYWNlOgo+PiBbwqAgKzAsMDAwMDA4XcKgIFs8ZmZmZmZm
ZmY4MTc3ZjIyOT5dIHNjaGVkdWxlKzB4MjkvMHg3MAo+PiBbwqAgKzAsMDAwMDEwXcKgIFs8ZmZm
ZmZmZmY4MTM1OGU4NT5dIGJsa19tcV9mcmVlemVfcXVldWVfd2FpdCsweDc1LzB4ZTAKPj4gW8Kg
ICswLDAwMDAwN13CoCBbPGZmZmZmZmZmODEwYzYxYzA+XSA/IHdha2VfdXBfYXRvbWljX3QrMHgz
MC8weDMwCj4+IFvCoCArMCwwMDAwMDZdwqAgWzxmZmZmZmZmZjgxMzU5Y2I0Pl0gYmxrX2ZyZWV6
ZV9xdWV1ZSsweDI0LzB4NTAKPj4gW8KgICswLDAwMDAwOV3CoCBbPGZmZmZmZmZmODEzNGUwZWY+
XSBibGtfY2xlYW51cF9xdWV1ZSsweDdmLzB4MWIwCj4+IFvCoCArMCwwMDAwMTJdwqAgWzxmZmZm
ZmZmZmMwMzExNThlPl0gbnZtZV9uc19yZW1vdmUrMHg4ZS8weGIwIFtudm1lX2NvcmVdCj4+IFvC
oCArMCwwMDAwMTFdwqAgWzxmZmZmZmZmZmMwMzExNzRiPl0gbnZtZV9yZW1vdmVfbmFtZXNwYWNl
cysweGFiLzB4ZjAgCj4+IFtudm1lX2NvcmVdCj4+IFvCoCArMCwwMDAwMTJdwqAgWzxmZmZmZmZm
ZmMwMzExN2UyPl0gbnZtZV9kZWxldGVfY3RybF93b3JrKzB4NTIvMHg4MCAKPj4gW252bWVfY29y
ZV0KPj4gW8KgICswLDAwMDAwOF3CoCBbPGZmZmZmZmZmODEwYmQwZmY+XSBwcm9jZXNzX29uZV93
b3JrKzB4MTdmLzB4NDQwCj4+IFvCoCArMCwwMDAwMDZdwqAgWzxmZmZmZmZmZjgxMGJlMzY4Pl0g
d29ya2VyX3RocmVhZCsweDI3OC8weDNjMAo+PiBbwqAgKzAsMDAwMDA2XcKgIFs8ZmZmZmZmZmY4
MTBiZTBmMD5dID8gbWFuYWdlX3dvcmtlcnMuaXNyYS4yNisweDJhMC8weDJhMAo+PiBbwqAgKzAs
MDAwMDA1XcKgIFs8ZmZmZmZmZmY4MTBjNTBkMT5dIGt0aHJlYWQrMHhkMS8weGUwCj4+IFvCoCAr
MCwwMDAwMDZdwqAgWzxmZmZmZmZmZjgxMGM1MDAwPl0gPyBpbnNlcnRfa3RocmVhZF93b3JrKzB4
NDAvMHg0MAo+PiBbwqAgKzAsMDAwMDA2XcKgIFs8ZmZmZmZmZmY4MTc4Y2QxZD5dIHJldF9mcm9t
X2Zvcmtfbm9zcGVjX2JlZ2luKzB4Ny8weDIxCj4+IFvCoCArMCwwMDAwMDZdwqAgWzxmZmZmZmZm
ZjgxMGM1MDAwPl0gPyBpbnNlcnRfa3RocmVhZF93b3JrKzB4NDAvMHg0MAo+PiBgYGAKPj4gTm9k
ZXMgY2hhcmFjdGVyaXN0aWNzOgo+PiBbcm9vdEBzMDJwMDA1IH5dIyB1bmFtZSAtc3JtCj4+IExp
bnV4IDMuMTAuMC0xMDYyLjEuMS5lbDcueDg2XzY0IHg4Nl82NAo+PiBbcm9vdEBzMDJwMDA1IH5d
IyBjYXQgL2V0Yy9yZWRoYXQtcmVsZWFzZQo+PiBDZW50T1MgTGludXggcmVsZWFzZSA3LjcuMTkw
OCAoQ29yZSkKPj4KPj4gV2hlcmUncmUgdXNpbmcgbnZtZXRfcmRtYS4KPj4gSXMgdGhlcmUgYW55
IHdvcmthcm91bmQgZm9yIHN1Y2ggZXJyb3I/Cj4KPiBJdCBzZWVtcyBsaWtlIHF1ZXVlIGZyZWV6
ZSBpcyBzdHVjay4gQ2FuIHlvdSBzaGFyZSBtb3JlIG9mIHRoZQo+IHRyYWNlIHNvIHdlIGNhbiBz
ZWUgd2hhdCBlbHNlIGlzIGJsb2NraW5nPyBJZiBub3QsIHdoZW4KPiBpdCByZXByb2R1Y2VzIHJ1
biBlY2hvIHQgPiAvcHJvYy9zeXNycS10cmlnZ2VyIGFuZCBzaGFyZSB0aGUKPiBsb2cuCgpBbnRv
biwKCkNhbiB5b3UgcmVwcm8gdGhpcyB3aXRoIGxhdGVzdCBudm1lIGJyYW5jaCA/IG9yIG9ubHkg
aW5ib3ggQ2VudG9zNy43ID8KCgo+Cj4gVGhhbmtzLgo+Cj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsaW51eC1udm1lIG1haWxpbmcgbGlzdAo+IGxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHBzOi8vZXVyMDMuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGbGlzdHMuaW5mcmFkZWFkLm9y
ZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmxpbnV4LW52bWUmYW1wO2RhdGE9MDIlN0MwMSU3Q21h
eGclNDBtZWxsYW5veC5jb20lN0NiOGEyY2NmNjA5YmU0ZTc3YzA5YTA4ZDdkMzk3YmUwZiU3Q2E2
NTI5NzFjN2QyZTRkOWJhNmE0ZDE0OTI1NmY0NjFiJTdDMCU3QzAlN0M2MzcyMTA1MjA5ODU2ODY2
ODgmYW1wO3NkYXRhPTlpWVJXUnAyTHRJVmVmZGZlJTJCTjR2cWoyV01MVEpDQnlQdmJ6cnlhaUE3
NCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=
