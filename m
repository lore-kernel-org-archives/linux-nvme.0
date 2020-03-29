Return-Path: <SRS0=sr50=5O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D8EC43331
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 11:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D55206CC
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 11:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H2/wjhqq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="QWFOf1yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D55206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yRpQt2ANhw5fhrB8GmY4AFbe3fh4FbAxXFrQmAwWxj0=; b=H2/wjhqqt+3udqGUWbHT0z+i0
	dFPriy2BXoEiJSk4CD+fRsIkiTfNP31JAIbEt/QuSdcduPdWij/dmzHfx8vzQQRHoTzNJu9zG1A2w
	OEGfz2AeziEN/vTya5CnXFIE2iszro6Dz8JZkOzlgATXyvA/NeR59bFbaT7aEFuJQB1LWhj0UORvU
	RbAq6+TWvS/WHjVwP9pqsI9FTTiRO+fdaCwfYYSeBr70pmam3407/LRAUCQR7D5VW7FArYVfA0OaX
	BHxa2pidJh/znB+5RnDI54b97b4EjdZ6ucU+Ov4J7qBSn5tTVf7LdiE3WWIWBMKvl90ABCdB+4qWX
	kAU8tQNwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIWYA-0001ye-3U; Sun, 29 Mar 2020 11:56:22 +0000
Received: from mail-ve1eur03on060f.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::60f]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIWY7-0001y8-4c
 for linux-nvme@lists.infradead.org; Sun, 29 Mar 2020 11:56:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZlROM14snvgD0HPjfNIbBris/+H6fwxIfGYiWkgbvq7ioVIk3uMF/7OXnma7m+iig+4GonSMbs4//L0yNGUQD794uANmadbBEt6pQMoJXiyzgM8dBAtu/LsENFDZJEODnsj9pdsRV4LjN5zBiQ9uxb4d5vmQRxEoO3e/P1o8Z0e42BL1JyePd+MgwON73FCTJSOOcpcgcudlUL3RvAcWDQ+DV+0e1r2C0Cy679Gkj4VZO1vPzgEwoAqM9dPJkvXtkcC+0RYRS1IQLZpZAbRZZ6DpuDpMlAz8sHoglYP3BtjaUBxnZCqQ7CtNIpxpIYKmLZGfQuxGvJpHAZZPB++OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vML/WQcwqovJK+Xt03iH8wXLeDK3t9kUCljgoQq4qJM=;
 b=RoR1PD1fiCnS8mC0//YbB35V8cdbkowPcj4bBrIMFMmxK4+mPlNV5iE2GHDkmRlkSqncSekXIntWF9WGnNLYBNxi1aus44cvfCbHTO+LkKfhHGM43ta6iGzB8ET8UgeZMjiBH5EYEqQ7Fovm2E9+YsCtdvKkn55f0Gyz83t8C0sRZ8fIpI0ebvplxao3gSGre4gH7NBYVZiW4U5g5BQbFVNcJKs0Z0ObporTq/TJmOe7mEasRdTVDfFEfExI+EaANa6CDVLtDxtJzvXeGbEL3jPFM3V/pOuaPxUd5ktV4Hzj759m+RFEtIakuviaoK148cyyVYly0/oIVh4hx6nQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=rsc-tech.ru smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vML/WQcwqovJK+Xt03iH8wXLeDK3t9kUCljgoQq4qJM=;
 b=QWFOf1yqSNcwBmqoq2NXIEUvckq/TUjWXHLnIgr8bJ2kliYdoFUkODaY85GJ0FonCS83GR6Os4k5yLoSmpubjHNlhYAkQXoa96b2Cv7c87Ic6injfcqFNu2cO8zQfAMAyIV4XFpd7KRMRoARXNac3Q7mgR7gDYQaPTRWHUjoWKs=
Received: from AM0PR06CA0003.eurprd06.prod.outlook.com (2603:10a6:208:ab::16)
 by VI1PR05MB5744.eurprd05.prod.outlook.com (2603:10a6:803:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Sun, 29 Mar
 2020 11:56:15 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:ab:cafe::23) by AM0PR06CA0003.outlook.office365.com
 (2603:10a6:208:ab::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Sun, 29 Mar 2020 11:56:14 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; rsc-tech.ru; dkim=none (message not signed)
 header.d=none;rsc-tech.ru; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2856.17 via Frontend Transport; Sun, 29 Mar 2020 11:56:14 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 29 Mar 2020 14:56:12
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 29 Mar 2020 14:56:12 +0300
Received: from [172.27.15.226] (172.27.15.226) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Sun, 29 Mar 2020 14:56:11 +0300
Subject: Re: NVMe Over Fabrics Disconnect Kernel error
To: Anton Brekhov <anton.brekhov@rsc-tech.ru>
References: <CABY-YC7eHFjb-TpKf2ioPJNhZ8RccYsrR-oU=wmt26z9AUNebg@mail.gmail.com>
 <a7da72d0-ed3f-ab5c-a72b-1b0518436a2e@grimberg.me>
 <e4f3f68d-a4a7-e799-c3b8-1d600e3888b5@mellanox.com>
 <CABY-YC4jSOZJW2zEx5dS9BRj8+ipNF5aF_0cgkuDo9oaLbhvew@mail.gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <9024d7bc-d55d-06c1-65b3-61027f81fda6@mellanox.com>
Date: Sun, 29 Mar 2020 14:56:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABY-YC4jSOZJW2zEx5dS9BRj8+ipNF5aF_0cgkuDo9oaLbhvew@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [172.27.15.226]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; CTRY:IL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mtlcas13.mtl.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39850400004)(46966005)(478600001)(316002)(36906005)(70586007)(36756003)(70206006)(6916009)(45080400002)(356004)(82740400003)(47076004)(31686004)(186003)(26005)(336012)(16526019)(31696002)(86362001)(8936002)(53546011)(8676002)(2906002)(81156014)(5660300002)(81166006)(966005)(2616005)(4326008)(54906003)(16576012)(3940600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1866f0e-2e2a-4201-d7ee-08d7d3d82ed1
X-MS-TrafficTypeDiagnostic: VI1PR05MB5744:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5744CF828F92457E9B38E0D9B6CA0@VI1PR05MB5744.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 035748864E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUWVXFlLIFzONBJHzpKRVfXlug2wDQDciYl6Mg+Y1mn5coRvE2J3v7fjcOGFc0R2RdkIVUJKMDY+STBWJZqqdhbHWSl0SgumsqVAaEmTv1alK/ZuQkY2OhQUYNU9+HMD9j+NJbLQEx7IQUQLzHu93yBRTMBPOUiepRTf6MNPExK8DX43GZhTuRZ61CNVCJPi40IZpoVwo97qVxGY2q5/zL+WgI7IIchdih3fqo6QxWtD4W5r6g9cDDnjbsHTS2Tff6PRbGuNZtgpQtETH0Ci8nnE/JMTeOSusTLIFmV4FjSaNMH6xl7UBQduB5eAgnfKkWk5R4UaaLajbKsNY+r7N5bwmaaddlgEtB7zUMorefnnuSRO5L0yJ523Q4TNfebcGUA4m9ztpu7h+Qwl7qB7XwnzaIr07he8HCr81ao/nDmnA1VfZeNrxrsKxotUyIdQsDBOvzXsnYupb3kUup6fbcHO3UOwofZcavy2JzHWF9LpwcpqnphdrkrMwC1YG+PJ0FrLO50OaBNUB4wGzM0Intqwu3j5sQuNbyxwfnoI8Hsaor6hKb95kUEI4LNdhTI7loM9Edy4t+iT0ZogiduVWy4Ee0zVUUKx/wNJ3DszwcDpUVuwtHnbbXq/8OidrHtc
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2020 11:56:14.6233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1866f0e-2e2a-4201-d7ee-08d7d3d82ed1
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5744
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200329_045619_246000_5E5F3612 
X-CRM114-Status: GOOD (  10.40  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Konstantin Ponomarev <k.ponomarev@rsc-tech.ru>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvMjkvMjAyMCAyOjM4IFBNLCBBbnRvbiBCcmVraG92IHdyb3RlOgo+IE1heCwKPiBUaGlz
IGVycm9yIHdlJ3ZlIG9idGFpbmVkIHdoaWxlIHVzaW5nIHRoZSBsYXRlc3QgcmVsZWFzZSBvZiBu
dm1lLWNsaToKPiBbcm9vdEBzMDJwMDA1IH5dIyBudm1lIHZlcnNpb24KPiBudm1lIHZlcnNpb24g
MS4xMC4xCj4KPiBPciB0aGVyZSB3ZXJlIHNvbWUgbWFqb3IgY2hhbmdlcyBhZnRlciBsYXRlc3Qg
cmVsZWFzZT8KCkkgcmVmZXJyZWQgdG8gdGhlIGtlcm5lbCB2ZXJzaW9uLgoKQ2FuIHlvdSBjaGVj
ayB5b3VyIHNjZW5hcmlvIHdpdGggZ2l0Oi8vZ2l0LmluZnJhZGVhZC5vcmcvbnZtZS5naXQgCihi
cmFuY2ggbnZtZS01Ljcgb3IgbnZtZS01LjctcmMxKS4KCi1NYXguCgoKPiBUaGFua3MuCj4KPiDQ
stGBLCAyOSDQvNCw0YAuIDIwMjAg0LMuINCyIDExOjUxLCBNYXggR3VydG92b3kgPG1heGdAbWVs
bGFub3guY29tPjoKPj4KPj4gT24gMy8yOS8yMDIwIDc6MTQgQU0sIFNhZ2kgR3JpbWJlcmcgd3Jv
dGU6Cj4+Pj4gR3JlZXRpbmdzIQo+Pj4+Cj4+Pj4gV2UncmUgdXNpbmcgbnZtZS1jbGkgdGVjaG5v
bG9neSB3aXRoIFpGUyBhbmQgTHVzdHJlIEZpbGVzeXN0ZW0gb24gdG9wCj4+Pj4gb2YgaXQuCj4+
Pj4gQnV0IHdlIGNvbnN0YW50bHkgY29tZSBhY3Jvc3MgYSBrZXJuZWwgZXJyb3Igd2hpbGUgZGlz
Y29ubmVjdGluZwo+Pj4+IHJlbW90ZSBkaXNrcyBmcm9tIHN3aXRjaGVkIG9mZiBub2RlczoKPj4+
PiBgYGAKPj4+PiBbICArMCwwMDAwODldIElORk86IHRhc2sga3dvcmtlci91NTkzOjA6ODIyOTMg
YmxvY2tlZCBmb3IgbW9yZSB0aGFuCj4+Pj4gMTIwIHNlY29uZHMuCj4+Pj4gWyAgKzAsMDAxOTU5
XSAiZWNobyAwID4gL3Byb2Mvc3lzL2tlcm5lbC9odW5nX3Rhc2tfdGltZW91dF9zZWNzIgo+Pj4+
IGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KPj4+PiBbICArMCwwMDE5NDFdIGt3b3JrZXIvdTU5Mzow
ICBEIGZmZmY5MGU4NDkzZmUyYTAgICAgIDAgODIyOTMgICAgICAyCj4+Pj4gMHgwMDAwMDA4MAo+
Pj4+IFsgICswLDAwMDAzMV0gV29ya3F1ZXVlOiBudm1lLWRlbGV0ZS13cSBudm1lX2RlbGV0ZV9j
dHJsX3dvcmsKPj4+PiBbbnZtZV9jb3JlXQo+Pj4+IFsgICswLDAwMDAwM10gQ2FsbCBUcmFjZToK
Pj4+PiBbICArMCwwMDAwMDhdICBbPGZmZmZmZmZmODE3N2YyMjk+XSBzY2hlZHVsZSsweDI5LzB4
NzAKPj4+PiBbICArMCwwMDAwMTBdICBbPGZmZmZmZmZmODEzNThlODU+XSBibGtfbXFfZnJlZXpl
X3F1ZXVlX3dhaXQrMHg3NS8weGUwCj4+Pj4gWyAgKzAsMDAwMDA3XSAgWzxmZmZmZmZmZjgxMGM2
MWMwPl0gPyB3YWtlX3VwX2F0b21pY190KzB4MzAvMHgzMAo+Pj4+IFsgICswLDAwMDAwNl0gIFs8
ZmZmZmZmZmY4MTM1OWNiND5dIGJsa19mcmVlemVfcXVldWUrMHgyNC8weDUwCj4+Pj4gWyAgKzAs
MDAwMDA5XSAgWzxmZmZmZmZmZjgxMzRlMGVmPl0gYmxrX2NsZWFudXBfcXVldWUrMHg3Zi8weDFi
MAo+Pj4+IFsgICswLDAwMDAxMl0gIFs8ZmZmZmZmZmZjMDMxMTU4ZT5dIG52bWVfbnNfcmVtb3Zl
KzB4OGUvMHhiMCBbbnZtZV9jb3JlXQo+Pj4+IFsgICswLDAwMDAxMV0gIFs8ZmZmZmZmZmZjMDMx
MTc0Yj5dIG52bWVfcmVtb3ZlX25hbWVzcGFjZXMrMHhhYi8weGYwCj4+Pj4gW252bWVfY29yZV0K
Pj4+PiBbICArMCwwMDAwMTJdICBbPGZmZmZmZmZmYzAzMTE3ZTI+XSBudm1lX2RlbGV0ZV9jdHJs
X3dvcmsrMHg1Mi8weDgwCj4+Pj4gW252bWVfY29yZV0KPj4+PiBbICArMCwwMDAwMDhdICBbPGZm
ZmZmZmZmODEwYmQwZmY+XSBwcm9jZXNzX29uZV93b3JrKzB4MTdmLzB4NDQwCj4+Pj4gWyAgKzAs
MDAwMDA2XSAgWzxmZmZmZmZmZjgxMGJlMzY4Pl0gd29ya2VyX3RocmVhZCsweDI3OC8weDNjMAo+
Pj4+IFsgICswLDAwMDAwNl0gIFs8ZmZmZmZmZmY4MTBiZTBmMD5dID8gbWFuYWdlX3dvcmtlcnMu
aXNyYS4yNisweDJhMC8weDJhMAo+Pj4+IFsgICswLDAwMDAwNV0gIFs8ZmZmZmZmZmY4MTBjNTBk
MT5dIGt0aHJlYWQrMHhkMS8weGUwCj4+Pj4gWyAgKzAsMDAwMDA2XSAgWzxmZmZmZmZmZjgxMGM1
MDAwPl0gPyBpbnNlcnRfa3RocmVhZF93b3JrKzB4NDAvMHg0MAo+Pj4+IFsgICswLDAwMDAwNl0g
IFs8ZmZmZmZmZmY4MTc4Y2QxZD5dIHJldF9mcm9tX2Zvcmtfbm9zcGVjX2JlZ2luKzB4Ny8weDIx
Cj4+Pj4gWyAgKzAsMDAwMDA2XSAgWzxmZmZmZmZmZjgxMGM1MDAwPl0gPyBpbnNlcnRfa3RocmVh
ZF93b3JrKzB4NDAvMHg0MAo+Pj4+IGBgYAo+Pj4+IE5vZGVzIGNoYXJhY3RlcmlzdGljczoKPj4+
PiBbcm9vdEBzMDJwMDA1IH5dIyB1bmFtZSAtc3JtCj4+Pj4gTGludXggMy4xMC4wLTEwNjIuMS4x
LmVsNy54ODZfNjQgeDg2XzY0Cj4+Pj4gW3Jvb3RAczAycDAwNSB+XSMgY2F0IC9ldGMvcmVkaGF0
LXJlbGVhc2UKPj4+PiBDZW50T1MgTGludXggcmVsZWFzZSA3LjcuMTkwOCAoQ29yZSkKPj4+Pgo+
Pj4+IFdoZXJlJ3JlIHVzaW5nIG52bWV0X3JkbWEuCj4+Pj4gSXMgdGhlcmUgYW55IHdvcmthcm91
bmQgZm9yIHN1Y2ggZXJyb3I/Cj4+PiBJdCBzZWVtcyBsaWtlIHF1ZXVlIGZyZWV6ZSBpcyBzdHVj
ay4gQ2FuIHlvdSBzaGFyZSBtb3JlIG9mIHRoZQo+Pj4gdHJhY2Ugc28gd2UgY2FuIHNlZSB3aGF0
IGVsc2UgaXMgYmxvY2tpbmc/IElmIG5vdCwgd2hlbgo+Pj4gaXQgcmVwcm9kdWNlcyBydW4gZWNo
byB0ID4gL3Byb2Mvc3lzcnEtdHJpZ2dlciBhbmQgc2hhcmUgdGhlCj4+PiBsb2cuCj4+IEFudG9u
LAo+Pgo+PiBDYW4geW91IHJlcHJvIHRoaXMgd2l0aCBsYXRlc3QgbnZtZSBicmFuY2ggPyBvciBv
bmx5IGluYm94IENlbnRvczcuNyA/Cj4+Cj4+Cj4+PiBUaGFua3MuCj4+Pgo+Pj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IGxpbnV4LW52bWUgbWFp
bGluZyBsaXN0Cj4+PiBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4+IGh0dHBzOi8v
ZXVyMDMuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJG
bGlzdHMuaW5mcmFkZWFkLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmxpbnV4LW52bWUmYW1w
O2RhdGE9MDIlN0MwMSU3Q21heGclNDBtZWxsYW5veC5jb20lN0MxNDQ3MWIwZjFiYWI0YmUyYTY4
MTA4ZDdkM2Q1Yzg5YiU3Q2E2NTI5NzFjN2QyZTRkOWJhNmE0ZDE0OTI1NmY0NjFiJTdDMCU3QzAl
N0M2MzcyMTA3ODc0NjQ3NzU3MDcmYW1wO3NkYXRhPXhtd2drNWxqRnQlMkY3JTJCc1pSUW1QNm1m
d3VSMGhoam9Zc3ZOcnJMVUJheXFJJTNEJmFtcDtyZXNlcnZlZD0wCj4+PgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
