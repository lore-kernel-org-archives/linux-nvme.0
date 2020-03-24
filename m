Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82019C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 17:26:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5016820774
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 17:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NQh90KiR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rH4f39on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5016820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iPqScS2lJX5/XYLnmsNGikDweFGSgSHYCLpRQTUaqrM=; b=NQh90KiRzDl1GVRbCI62Kivty
	nIlR/mpifdeBQ3bdjSON6FTJdzVS8d1jANu98W0XhDRknHy7jRoHuMSCJgpWevMqqiSYn+LD9HSBh
	cbRMPZvE2ETt/nlsez5HEt1CK72/S/STll3X2UlLFQ3S+Y2L9b3RbiTPGAUc6xrwZpRdiv/QVtNWa
	55NrZBV2raiXoI57L2a1Tt5pQ0vDSiEOuVG0gbSOeRfbXxDqXOKdP/SwYZNM41Qu3WOoVonNcL3jx
	GXEqVo6Wu29Rwuq7rIvAB4vNRLWktaS/BWfZ4uZPGOwA5X2660dY0nmbC/zCibxfJ5gnUxCn0vw3P
	NZC6Tcf+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGnJU-00040k-5i; Tue, 24 Mar 2020 17:26:04 +0000
Received: from mail-vi1eur05on2040.outbound.protection.outlook.com
 ([40.107.21.40] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGnJQ-00040F-Bp
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 17:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxLo3ADPP/HMIHuLFJzuhOxHs+wNIUxo0QLX4ZTv/Wd0V0u2k/OyWzFCoMT2u50XKjddF8NjfGqaPp5SW0SJ6ZMWuf4EFniWPF8aBfMrcunquVbAjINoV4MVpmSVwLVi20T6GyPLxpn4LRkG7i0r9F7258ZWjx0q0clmtt/h6d15djrmcX9zndW83V64OVjGPfkcrpIkl05EiQk80AenESrGfgxoRlVLgf4DuCU5GIE37SMGzcgsOfWyaA1wHajPagrW6/5qTBrY7pf1kVf8b0JYHGWYLuqkg6oAaG80//S0Mxva/kSYUclPu04bLwkA2X3ClFZQEoE8f8ipfurtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hgts3nOv20wfLagAtc3/eRF5mBXR/+tSGbkq3ITvVaM=;
 b=AtIv/w7kywiXdWED8LqmIiPkfvzKlMu+QvyRQ7iAfw2ZMS82Hv8UBESOWY09sMrXD/iZs/oboUOlytdwX7Yfu2YRL6ququEekejx0ojtTZw7nRm2jiuhhXpO95LrIrV2PtAfbuyfhMCvPKQyOpJa1X3vESfa2EEdUmIJqgrGUgcrpd63K8kec3zPWTIkxNXSNQvVsWQQrCcx4m6np4JJf/RA9Dnla8WWIP4sRgWRoFhDYn40sYbOSFhYaEN8ZIctzJlE3W9IHLYNriv5AZvX8pkXIo7Watjc4zPzwpbABHOa0Nj3XszgpyF4kH3culeYZTDafckVxncBD059OKjXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hgts3nOv20wfLagAtc3/eRF5mBXR/+tSGbkq3ITvVaM=;
 b=rH4f39on87PT+7JYVmr8vxrbGU04QL/GzLl68KN7uGVKcqtl+R6oErqQJqj2/AdcWrh/5PqRNfLYcZknQbq8hEOflH44cEThaRCXBjaqPWfqWsxmghxRluI3diQy6g+6cFix/WaGnNQbY4R83li7RZ8wHurt2B2qIRMn787qBHo=
Received: from DB6PR1001CA0001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b7::11)
 by VI1PR0501MB2448.eurprd05.prod.outlook.com (2603:10a6:800:68::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 17:25:53 +0000
Received: from DB5EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b7:cafe::39) by DB6PR1001CA0001.outlook.office365.com
 (2603:10a6:4:b7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Tue, 24 Mar 2020 17:25:53 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT022.mail.protection.outlook.com (10.152.20.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 17:25:52 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 24 Mar 2020 19:30:10
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 24 Mar 2020 19:30:10 +0200
Received: from [172.27.15.174] (172.27.15.174) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Tue, 24 Mar 2020 19:24:58 +0200
Subject: Re: [PATCH rfc 2/2] fabrics: allow user to pass hostname instead of
 traddr
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>, "Keith
 Busch" <kbusch@kernel.org>
References: <20200324090324.24459-1-sagi@grimberg.me>
 <20200324090324.24459-3-sagi@grimberg.me>
 <b5812c46-7763-1581-e9a7-2e2927ccee18@mellanox.com>
 <233d0600-7d91-7a12-b58f-347697fa6bc0@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <86b265cc-d1e5-1dee-cd9d-83c4f5e976d0@mellanox.com>
Date: Tue, 24 Mar 2020 19:24:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <233d0600-7d91-7a12-b58f-347697fa6bc0@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.15.174]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966005)(70586007)(26005)(81166006)(336012)(186003)(16526019)(8676002)(81156014)(8936002)(31696002)(86362001)(53546011)(16576012)(316002)(478600001)(110136005)(70206006)(356004)(31686004)(5660300002)(47076004)(2906002)(2616005)(36756003)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0501MB2448; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b735687b-b6a9-47f7-2222-08d7d018676f
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2448:
X-Microsoft-Antispam-PRVS: <VI1PR0501MB2448C973C213560B163E011DB6F10@VI1PR0501MB2448.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 03524FBD26
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cBAqyqN6iM/5gGD9jHOo7ntTdFEsqw4Ehdab2ppsnnTOGcmlq+OQBpFRS6AJ1EvEDiUxFRLGzqQgrh59uTpmP7u+pKmuU2xVQ4FgluABrF8PksLwVcjSyv/ccpvckJtLIhHeCxqn3g1H0LQbNLLLBpZiTpKNOssZRYjoXBfEny1uMMGKQyWCE259KM77vVq+4FO3w1GnkEAQ9ALtPvUc/6Hk1+5Ot99gnxxN1xvTN3SL5ntVh9M0A5EdQ/AYQ7aMaMiLw7CkDgeYWkupNlP/Hd48c8fFEgoBOT26NZjV/iCWJf/WgvHCajv6Jf7hhZ1h4y47eWn3S0KZHgCorcUcCDF2gsAjn5/EAcuUu06Z7middB/xan5NeGVKLVx0AUHwSFEUUjoW4j9TfWqVhxdk+fySaP9DjNLnU9C5aEdTd+wwLZrVLxJQmuzzxOdhbjozhR9U8JHh3ul/lvLXn2HyAh/dTmlvFRygA4VMUwascucsBHD8ICvWX0lPrqiiF5MpSnhrbkAbzv1S+MjY4iyt2CRDIgzDXkMNLZ8GY9tUO0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 17:25:52.6240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b735687b-b6a9-47f7-2222-08d7d018676f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2448
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_102600_443230_643D80FC 
X-CRM114-Status: GOOD (  17.43  )
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

Ck9uIDMvMjQvMjAyMCA2OjIxIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4KPiBPbiAzLzI0
LzIwIDI6NDYgQU0sIE1heCBHdXJ0b3ZveSB3cm90ZToKPj4KPj4gT24gMy8yNC8yMDIwIDExOjAz
IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4gU29tZSB1c2VycyB3b3VsZCBsaWtlIHRvIHVz
ZSB3ZWxsIGtub3duIGhvc3RuYW1lcyBpbnN0ZWFkCj4+PiBvZiByZW1lbWJlcmluZyBpcCBhZGRy
ZXNzZXMuIFNvLCBhbGxvdyB1c2VycyB0byBwYXNzIC0taG9zdG5hbWUKPj4+IGFuZCB3ZSB3aWxs
IGF0dGVtcHQgdG8gcmVzb2x2ZSBhZ2FpbnN0IHRoZSBETlMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1i
eTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KPj4+IC0tLQo+Pj4gwqAgZmFicmlj
cy5jIHwgNzUgCj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9mYWJyaWNzLmMgYi9mYWJyaWNzLmMKPj4+IGluZGV4IGE3ZDYyOGIx
ZjBjOS4uN2JkOTVjNGIwZDEwIDEwMDY0NAo+Pj4gLS0tIGEvZmFicmljcy5jCj4+PiArKysgYi9m
YWJyaWNzLmMKPj4+IEBAIC0zMyw2ICszMywxMCBAQAo+Pj4gwqAgI2luY2x1ZGUgPHN5cy9zdGF0
Lmg+Cj4+PiDCoCAjaW5jbHVkZSA8c3RkZGVmLmg+Cj4+PiArI2luY2x1ZGUgPHN5cy90eXBlcy5o
Pgo+Pj4gKyNpbmNsdWRlIDxhcnBhL2luZXQuaD4KPj4+ICsjaW5jbHVkZSA8bmV0ZGIuaD4KPj4+
ICsKPj4+IMKgICNpbmNsdWRlICJ1dGlsL3BhcnNlci5oIgo+Pj4gwqAgI2luY2x1ZGUgIm52bWUt
aW9jdGwuaCIKPj4+IMKgICNpbmNsdWRlICJudm1lLXN0YXR1cy5oIgo+Pj4gQEAgLTYwLDYgKzY0
LDcgQEAgc3RhdGljIHN0cnVjdCBjb25maWcgewo+Pj4gwqDCoMKgwqDCoCBjaGFyICpucW47Cj4+
PiDCoMKgwqDCoMKgIGNoYXIgKnRyYW5zcG9ydDsKPj4+IMKgwqDCoMKgwqAgY2hhciAqdHJhZGRy
Owo+Pj4gK8KgwqDCoCBjaGFyICpob3N0bmFtZTsKPj4+IMKgwqDCoMKgwqAgY2hhciAqdHJzdmNp
ZDsKPj4+IMKgwqDCoMKgwqAgY2hhciAqaG9zdF90cmFkZHI7Cj4+PiDCoMKgwqDCoMKgIGNoYXIg
Kmhvc3RucW47Cj4+PiBAQCAtODU3LDYgKzg2Miw1NCBAQCBzdGF0aWMgaW50IGJ1aWxkX29wdGlv
bnMoY2hhciAqYXJnc3RyLCBpbnQgCj4+PiBtYXhfbGVuLCBib29sIGRpc2NvdmVyKQo+Pj4gwqDC
oMKgwqDCoCByZXR1cm4gMDsKPj4+IMKgIH0KPj4+ICtzdGF0aWMgaW50IGhvc3RuYW1lMnRyYWRk
cihzdHJ1Y3QgY29uZmlnICpjZmcpCj4+PiArewo+Pj4gK8KgwqDCoCBzdHJ1Y3QgYWRkcmluZm8g
Kmhvc3RfaW5mbywgaGludHMgPSB7LmFpX2ZhbWlseSA9IEFGX1VOU1BFQ307Cj4+PiArwqDCoMKg
IGNoYXIgYWRkcnN0cltOVk1GX1RSQUREUl9TSVpFXTsKPj4+ICvCoMKgwqAgY29uc3QgY2hhciAq
cDsKPj4+ICvCoMKgwqAgaW50IHJldDsKPj4+ICsKPj4+ICvCoMKgwqAgaWYgKGNmZy0+dHJhZGRy
KSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgZnByaW50ZihzdGRlcnIsICJob3N0bmFtZSBhbmQgdHJh
ZGRyIGNhbm5vdCBiZSBwYXNzZWQgCj4+PiB0b2dldGhlclxuIik7Cj4+PiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FSU5WQUw7Cj4+PiArwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqAgcmV0ID0g
Z2V0YWRkcmluZm8oY2ZnLT5ob3N0bmFtZSwgTlVMTCwgJmhpbnRzLCAmaG9zdF9pbmZvKTsKPj4+
ICvCoMKgwqAgaWYgKHJldCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIGZwcmludGYoc3RkZXJyLCAi
ZmFpbGVkIHRvIGdldCBob3N0IGluZm8gZm9yICVzXG4iLCAKPj4+IGNmZy0+aG9zdG5hbWUpOwo+
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+PiArwqDCoMKgIH0KPj4+ICsKPj4+ICvC
oMKgwqAgc3dpdGNoIChob3N0X2luZm8tPmFpX2ZhbWlseSkgewo+Pj4gK8KgwqDCoCBjYXNlIEFG
X0lORVQ6Cj4+PiArwqDCoMKgwqDCoMKgwqAgcCA9IGluZXRfbnRvcChob3N0X2luZm8tPmFpX2Zh
bWlseSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICYoKChzdHJ1Y3Qgc29ja2FkZHJfaW4g
Kilob3N0X2luZm8tPmFpX2FkZHIpLT5zaW5fYWRkciksCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhZGRyc3RyLCBOVk1GX1RSQUREUl9TSVpFKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBicmVh
azsKPj4+ICvCoMKgwqAgY2FzZSBBRl9JTkVUNjoKPj4+ICvCoMKgwqDCoMKgwqDCoCBwID0gaW5l
dF9udG9wKGhvc3RfaW5mby0+YWlfZmFtaWx5LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
JigoKHN0cnVjdCBzb2NrYWRkcl9pbjYgKilob3N0X2luZm8tPmFpX2FkZHIpLT5zaW42X2FkZHIp
LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkcnN0ciwgTlZNRl9UUkFERFJfU0laRSk7
Cj4+PiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiArwqDCoMKgIGRlZmF1bHQ6Cj4+PiArwqDC
oMKgwqDCoMKgwqAgZnByaW50ZihzdGRlcnIsICJ1bnJlY29nbml6ZWQgYWRkcmVzcyBmYW1pbHkg
KCVkKSAlc1xuIiwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhvc3RfaW5mby0+YWlfZmFt
aWx5LCBjZmctPmhvc3RuYW1lKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSAtRUlOVkFMOwo+
Pj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZnJlZV9hZGRyaW5mbzsKPj4+ICvCoMKgwqAgfQo+Pj4g
Kwo+Pj4gK8KgwqDCoCBpZiAoIXApIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBmcHJpbnRmKHN0ZGVy
ciwgImZhaWxlZCB0byBnZXQgdHJhZGRyIGZvciAlc1xuIiwgCj4+PiBjZmctPmhvc3RuYW1lKTsK
Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSAtZXJybm87Cj4+PiArwqDCoMKgwqDCoMKgwqAgZ290
byBmcmVlX2FkZHJpbmZvOwo+Pj4gK8KgwqDCoCB9Cj4+PiArwqDCoMKgIGNmZy0+dHJhZGRyID0g
c3RyZHVwKGFkZHJzdHIpOwo+Pj4gKwo+Pj4gK2ZyZWVfYWRkcmluZm86Cj4+PiArwqDCoMKgIGZy
ZWVhZGRyaW5mbyhob3N0X2luZm8pOwo+Pj4gK8KgwqDCoCByZXR1cm4gcmV0Owo+Pj4gK30KPj4+
ICsKPj4+IMKgIHN0YXRpYyBpbnQgY29ubmVjdF9jdHJsKHN0cnVjdCBudm1mX2Rpc2NfcnNwX3Bh
Z2VfZW50cnkgKmUpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIGNoYXIgYXJnc3RyW0JVRl9TSVpF
XSwgKnA7Cj4+PiBAQCAtMTIzMCw2ICsxMjgzLDEzIEBAIHN0YXRpYyBpbnQgZGlzY292ZXJfZnJv
bV9jb25mX2ZpbGUoY29uc3QgY2hhciAKPj4+ICpkZXNjLCBjaGFyICphcmdzdHIsCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKGNmZy5wZXJzaXN0ZW50ICYmICFjZmcua2VlcF9hbGl2ZV90bW8p
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjZmcua2VlcF9hbGl2ZV90bW8gPSBOVk1G
X0RFRl9ESVNDX1RNTzsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoY2ZnLmhvc3RuYW1lKSB7Cj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBob3N0bmFtZTJ0cmFkZHIoJmNmZyk7Cj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNmZy5o
b3N0bmFtZSA9IE5VTEw7Cj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pj4gKwo+Pgo+PiBJIGd1ZXNz
IHlvdSBhZGQgdGhlIE5VTEwgdG8gY2hlY2sgbXV0dWFsIGV4Y2x1c2lvbiBsYXRlciA/Cj4KPiBU
aGUgTlVMTCBhc3NpZ25tZW50IGhlcmUgaXMgYmVjYXVzZSB3ZSBhcmUgbG9vcGluZyBvbiB0aGUg
Y29uZgo+IGZpbGUgZW50cmllcyB3aGljaCBjYW4gaGF2ZSBhIGRpZmZlcmVudCBob3N0bmFtZS4g
VGhlIG90aGVyCj4gbG9jYXRpb25zIGFyZSBhIG9uZS1zaG90IHNvIHRoaXMgYXNzaWdubWVudCBp
cyBub3QgbmVlZGVkLgo+Cj4+IENhbiB3ZSBjaGVjayBpdCBpbiBidWlsZF9vcHRpb25zID8KPgo+
IFdoZW4gd2UgZ2V0IGEgaG9zdG5hbWUgd2UgcmVzb2x2ZSB0aGUgdHJhZGRyIHdoaWNoIGlzIHdo
YXQKPiBidWlsZF9vcHRpb25zIG5lZWRzIChob3N0bmFtZSBub3QgYW4gb3B0aW9uIHRoYXQgaXMg
cGFzc2VkIHRvCj4gdGhlIGRyaXZlcikuCj4KPiBEb2VzIHRoYXQgYW5zd2VyIHlvdXIgcXVlc3Rp
b24/CgpJIG1lYW50IHRvIHByZXZlbnQgYSB1c2VyIHRvIHNlbmQgdGhlbSBib3RoIGluIHRoZSBj
b21tYW5kIGxpbmUgKG5vIHRvIApzZW5kIGl0IHRvIHRoZSBkcml2ZXIpLgoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcg
bGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
