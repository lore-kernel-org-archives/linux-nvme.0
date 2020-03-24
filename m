Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D4C10DCE
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 22:58:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E97D20722
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 22:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S3yxKW3v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="IerFhp6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E97D20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1y0CcU5WNHeONIA309mqVvSBJgFxpLVqqeWvrmSKNc=; b=S3yxKW3vPoGyEMcrr+5Y6oVm1
	TLLM8k/jbMRsUJ+XyIkDxwz2gxLS3/X6y1QsXu864MHUaiPfS0K/ItdIPw8r8lnBeGFZRcVAODZNL
	RcsT8MBh8HrN9xrehkIsauDONzOQTGA9crWxuSqOLBDTUNci/nObq0gC3eQTgxtjZpD1Aoc6IvpSn
	yk4treInOJlA4/K521r39g6fEcgeZQtgesb3WcvgbMg5nbbCZCPCf31sHod0mJ8bRJwyvFFAF40Bi
	r01BtmZHoDD5nLs9MNr2ZQI4TMHVPPuowySwaCpTm+AXaHa4Dvp6V87gkKsMK8BN+A6yIH7+oEXlX
	b/5zV4SKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGsUz-0007NU-JQ; Tue, 24 Mar 2020 22:58:17 +0000
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGsUw-0007N0-92
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 22:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7giQUxl+jFS2CXTDI4O1+IE6Lx1thHvNk6E4ZRX9ZfMu+0kJAwdF0wyPSfM4nXlVV75mHNxiD28vN75Q+Uyoj3DZgEEIhoimftmOy35BZh7LpCJPsuUK8mMIkFE5x7TU2RcdM6ja9OjcbOdO42IeJRTdTCldw4BjcYlRC0DVoMEAgcGd7pU+miXIPPD6WSWjhNkzsTPrFG45WTFKNpBPDfvEM3Ygj+b21Sa1w4lwsfAJQvTh6AgTrlB/q2QNwJc1wKEIGKXvIqKaWgStsnLFz+SNpaC35L4z8sQgB66pTNKA0NtVR7TGTJ6Prto7pKmTBz3ARGEncU3n4f60TTOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxpZmfkJBJZ1uN5Lsk8B/5TjlPnJkljQyKTE/8Voo18=;
 b=QTyIq10DNnN3fVUea0NB1OVYVoBnG+9vFDbMSjj6zuTLZEoVDH7XRVn/3i4EnMYejPnD5wBEIdvqXsbrtVIS8QIJFk0AlBbGQvkHTV+vZLMRX10QGXGhIBDO4SJELcT+GBfR/VSnxA+CLqweBnhT7tVBsH+b7HClb0FwHPz0I+bBWtoNmv++5bfJZGY9OZo2ziB8SFEMgWjkUHvVHG2CstoVut30CdPU2KyQy7kgionsEgDLHO/mtWN/yCve2Udh8Hd97VoW4t5OePrkiJVEElPYh7DFLWESN0qfJwgS7CwOSedJ1ytZGOlYRlzQoSdA0GRLAFeyyBTcr8TVd643ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxpZmfkJBJZ1uN5Lsk8B/5TjlPnJkljQyKTE/8Voo18=;
 b=IerFhp6l2NxJgdnPjJPgEW1L93a2asX4yFaPkRfaskEA80Fpp29sOa/LdDQ6jU+oH4bgXfWnpo8EehhV8y3DxBkWqpg0DP/zyPbsE7aw9UXnkSnoRGZwLe/5NSTtqUP5KeAbxOXEMXY9KtYpSdXQ9NVgZMl1QOfKkzZ8kD+uN6o=
Received: from AM4PR0101CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::31) by DB7PR05MB4811.eurprd05.prod.outlook.com
 (2603:10a6:10:22::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 22:58:11 +0000
Received: from AM5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:200:41:cafe::3d) by AM4PR0101CA0063.outlook.office365.com
 (2603:10a6:200:41::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Tue, 24 Mar 2020 22:58:10 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT031.mail.protection.outlook.com (10.152.16.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 22:58:10 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 25 Mar 2020 00:58:09
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 25 Mar 2020 00:58:09 +0200
Received: from [172.27.0.12] (172.27.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 25 Mar 2020 00:57:52
 +0200
Subject: Re: [PATCH rfc 2/2] fabrics: allow user to pass hostname instead of
 traddr
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>, "Keith
 Busch" <kbusch@kernel.org>
References: <20200324090324.24459-1-sagi@grimberg.me>
 <20200324090324.24459-3-sagi@grimberg.me>
 <b5812c46-7763-1581-e9a7-2e2927ccee18@mellanox.com>
 <233d0600-7d91-7a12-b58f-347697fa6bc0@grimberg.me>
 <86b265cc-d1e5-1dee-cd9d-83c4f5e976d0@mellanox.com>
 <1740e836-7dff-35eb-6e42-17b666faa8ec@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f7a199c9-355c-6913-ee2b-36f634785573@mellanox.com>
Date: Wed, 25 Mar 2020 00:57:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1740e836-7dff-35eb-6e42-17b666faa8ec@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966005)(16526019)(26005)(47076004)(478600001)(186003)(36906005)(336012)(36756003)(81166006)(8676002)(2906002)(81156014)(8936002)(5660300002)(2616005)(86362001)(53546011)(31696002)(70206006)(16576012)(110136005)(356004)(316002)(70586007)(31686004)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR05MB4811; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f570bed7-dc55-4e26-8f17-08d7d046d32d
X-MS-TrafficTypeDiagnostic: DB7PR05MB4811:
X-Microsoft-Antispam-PRVS: <DB7PR05MB48111AA4DB829E42EDE06405B6F10@DB7PR05MB4811.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03524FBD26
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FcLv9bv4kNVafqLX5nAzwzmx1XTpk1G91ELLJqrDa4+GTX/QzOoxhJ2WSqUzzwBOTj7vlgzkUY1MkTgjZXdq2cxDHZKDh+xxNl+x5en2uXyXFF4S25BQvBsM34I/Rw0oEftgfr+6RbIgui3VfOx7AYP5RQGWtNhNP+DB8/WOemw/zSZE66FLhYF4i1PO2rXoS+UIYxEvNQOmwHZVsMVH9F2a7fOE6N1rJEq/SfLCcunJU3ERJhiQwkk0YDMSZPlgM3mTQeNVrBnYeXmm5XzntBBfgTYg6zXTIZv2Go/IOJ1J2Z1+27MezYjVQZK5pQsEWRq0rrb4GO+wVE3sN7tcvq8AekFE/vuDLJrKFGjDAeQPHEqoO0ebz28Q615Wb2T2FC0LlDXLMu/+O7iYzQ96tkMWEXwUgMeoNAtDShwtDQyK3LsEKOgdHLkig3ObLjirpM3W+r1336geXuAWnKaGo97OXDPq5AoeUy4A0bzSyw98j6eP74lpXgdtv8rrJuhOEfeKUdfZOturOi2K52wA9UUNU2fod4BViQkvHiLKds=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 22:58:10.3739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f570bed7-dc55-4e26-8f17-08d7d046d32d
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4811
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_155814_632714_516E7B65 
X-CRM114-Status: GOOD (  13.80  )
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

Ck9uIDMvMjQvMjAyMCA5OjExIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+Pj4+IMKgIHN0
YXRpYyBpbnQgY29ubmVjdF9jdHJsKHN0cnVjdCBudm1mX2Rpc2NfcnNwX3BhZ2VfZW50cnkgKmUp
Cj4+Pj4+IMKgIHsKPj4+Pj4gwqDCoMKgwqDCoCBjaGFyIGFyZ3N0cltCVUZfU0laRV0sICpwOwo+
Pj4+PiBAQCAtMTIzMCw2ICsxMjgzLDEzIEBAIHN0YXRpYyBpbnQgZGlzY292ZXJfZnJvbV9jb25m
X2ZpbGUoY29uc3QgCj4+Pj4+IGNoYXIgKmRlc2MsIGNoYXIgKmFyZ3N0ciwKPj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChjZmcucGVyc2lzdGVudCAmJiAhY2ZnLmtlZXBfYWxpdmVfdG1vKQo+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjZmcua2VlcF9hbGl2ZV90bW8gPSBOVk1G
X0RFRl9ESVNDX1RNTzsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChjZmcuaG9zdG5hbWUpIHsK
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gaG9zdG5hbWUydHJhZGRyKCZjZmcp
Owo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjZmcuaG9zdG5hbWUgPSBOVUxMOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pj4+PiAr
Cj4+Pj4KPj4+PiBJIGd1ZXNzIHlvdSBhZGQgdGhlIE5VTEwgdG8gY2hlY2sgbXV0dWFsIGV4Y2x1
c2lvbiBsYXRlciA/Cj4+Pgo+Pj4gVGhlIE5VTEwgYXNzaWdubWVudCBoZXJlIGlzIGJlY2F1c2Ug
d2UgYXJlIGxvb3Bpbmcgb24gdGhlIGNvbmYKPj4+IGZpbGUgZW50cmllcyB3aGljaCBjYW4gaGF2
ZSBhIGRpZmZlcmVudCBob3N0bmFtZS4gVGhlIG90aGVyCj4+PiBsb2NhdGlvbnMgYXJlIGEgb25l
LXNob3Qgc28gdGhpcyBhc3NpZ25tZW50IGlzIG5vdCBuZWVkZWQuCj4+Pgo+Pj4+IENhbiB3ZSBj
aGVjayBpdCBpbiBidWlsZF9vcHRpb25zID8KPj4+Cj4+PiBXaGVuIHdlIGdldCBhIGhvc3RuYW1l
IHdlIHJlc29sdmUgdGhlIHRyYWRkciB3aGljaCBpcyB3aGF0Cj4+PiBidWlsZF9vcHRpb25zIG5l
ZWRzIChob3N0bmFtZSBub3QgYW4gb3B0aW9uIHRoYXQgaXMgcGFzc2VkIHRvCj4+PiB0aGUgZHJp
dmVyKS4KPj4+Cj4+PiBEb2VzIHRoYXQgYW5zd2VyIHlvdXIgcXVlc3Rpb24/Cj4+Cj4+IEkgbWVh
bnQgdG8gcHJldmVudCBhIHVzZXIgdG8gc2VuZCB0aGVtIGJvdGggaW4gdGhlIGNvbW1hbmQgbGlu
ZSAobm8gCj4+IHRvIHNlbmQgaXQgdG8gdGhlIGRyaXZlcikuCj4KPiBidWlsZF9vcHRpb25zIGlz
IGp1c3QgY29udmVydGluZyBvcHRpb25zIHRvIGFuIGFyZ3N0ciwgbm90IHN1cmUgaXRzIGEKPiBn
b29kIGlkZWEgdG8gbW92ZSB0aGF0IHRoZXJlLi4uCgpZb3UgcmlnaHQsIEkgd2FzIGp1c3QgdGhp
bmtpbmcgb3V0IGxvdWQuCgpXZSBjYW4gY2hlY2sgaXQgYmVmb3JlIGNhbGxpbmcgdGhlIHJlc29s
dXRpb24gZnVuY3Rpb24gaG9zdG5hbWUydHJhZGRyLgoKLgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
