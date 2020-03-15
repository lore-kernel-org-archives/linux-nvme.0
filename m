Return-Path: <SRS0=J84B=5A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F0C10DCE
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Mar 2020 08:56:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A446206BE
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Mar 2020 08:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tHOUjaV1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="e6PzqVV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A446206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/yIhT/3GLOVyRDqP1bZdSuqMrm038lsPJoW7c3GwANg=; b=tHOUjaV1yi6uVI2ldMGtHShIP
	HWCgUE1414BAPIl3tRHpwTgVgZaRs+ApPo1rxkOd3tMaX+htsjs2SygcI9DI7z8BFRW3fwMMuRNTC
	U1ZyRXBvZsDnQH8nE56h9X0whVnceGxOuhilpIUSTnp0z8z2Etla55wFPfgaWkQb/qvMeWN9lLsyk
	GbgrVldHSs/sSkwCJi+3c4YLD6ji7N1mt2L25Tw3ynhSOuuW6/ri8Pz8GfOMSbUwfmOIn6iM05456
	jYnBb+Hwn2rgxNjyqTdo5isJwTONDtyORsWSdKpFQ5IU5mgMFFCpoX0c/duLH5wjy7u+kvKyoXBJp
	6ZbCGgNug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jDP4e-0003R0-Lq; Sun, 15 Mar 2020 08:56:44 +0000
Received: from mail-am6eur05on2068.outbound.protection.outlook.com
 ([40.107.22.68] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jDP4a-0003Qc-OJ
 for linux-nvme@lists.infradead.org; Sun, 15 Mar 2020 08:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpXj2fM55H8BnqrKWzmccxLOHB1ZTHYIwhsQPJq3IeUhPfdeT0ikI1XWCU+Kxg47CvzmCw2OENqSHpQoM9MdI2Rv/ZFAdz2mtNvx9AzQG1M6frJck1FF++m3VtlngIvGE7cYGNWY6LtJQ9DfHbXj24/nJTdMBPEvcNVmAYbXrZNyS0tOp8dhdCuV+gccqAG9bgOgvUyrIYro5zVd1N2qITSaQLI3JmDkFxw+Tbafim4sGkGBM4em2NSUILQG/yO/PMmDScGCECBWFUbljof1i0unnYg4/BGnsMnVVgZmC5rfz1sfPUGlofYYcXpTqhWtEbP1ssvQFc6vSdXYtmvo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga/L+JyepHlfuFT+zoB+tNmnkCaI0+L5hwIF4PwwWM0=;
 b=DK6r4oCN8FvPUABLpYVzOkAcotmNRC1SirQkR3w6WOppSVtcFVfOoWNcO2y2suW0EBm4fZU7ENCl+BdDmRyJcMTgOiCOhWwE0/aqyQk1v7d1w/Dd9eXA02Eb56oXwi4BjBJy/TnWAQD9DUGh0cwwAMekh3BIEr4jNar0haEm6OSVJO+g9R2k/2yXJbQMnQsjphWs/r2k80yrAoU/gb3glA8lNpul+U42wG1N5tRvRF9iGmFk77ilSpFq+iYpJDROp+UHqAzxQJrWriAsox/rg1hmUtTZZLfAL9xuK5veiqOPuCWPtq2810nZmawenEydchC3kpia1Yo78Of6LTqBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga/L+JyepHlfuFT+zoB+tNmnkCaI0+L5hwIF4PwwWM0=;
 b=e6PzqVV7YXEHF/SI6cafaYbh7CHJ9XHiVib/5CTQ43G8zTIHTRG8ILncA9nCYQ/PYeKWRPx5Odx3x6GA2XhmQoZMF6Y4tAwOY97CAC08hc/9HSmx28NBeAVYmbwhxm87cUAum6ccuLWWaqwIjUHgFrthDeIzlLymqmh44MC+qZQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=israelr@mellanox.com; 
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com (52.133.45.151) by
 AM0PR0502MB4066.eurprd05.prod.outlook.com (52.133.41.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Sun, 15 Mar 2020 08:56:31 +0000
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe]) by AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe%7]) with mapi id 15.20.2814.016; Sun, 15 Mar 2020
 08:56:31 +0000
Subject: Re: [PATCH 1/4] nvme-rdma: Fix warning at nvme_rdma_setup_ctrl
To: Sagi Grimberg <sagi@grimberg.me>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-2-git-send-email-israelr@mellanox.com>
 <974e3bd2-3282-5703-eba6-bc2675c98c8e@grimberg.me>
 <e15f12ab-bf40-423d-956a-199897a5b3f5@mellanox.com>
 <328e8c24-aadd-1a3a-0523-15dc352bd8ec@grimberg.me>
From: Israel Rukshin <israelr@mellanox.com>
Message-ID: <10b7614e-7e3f-095b-5c79-942a9d0593ba@mellanox.com>
Date: Sun, 15 Mar 2020 10:56:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <328e8c24-aadd-1a3a-0523-15dc352bd8ec@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AM0PR0502MB3905.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.223.3.91] (193.47.165.251) by
 FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19 via Frontend Transport; Sun, 15 Mar 2020 08:56:30 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94b05dbe-4bc4-4039-7a84-08d7c8bec165
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4066:|AM0PR0502MB4066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB4066B279C8069CB32F4DD040D7F80@AM0PR0502MB4066.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-Forefront-PRVS: 0343AC1D30
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(2616005)(2906002)(86362001)(956004)(8676002)(316002)(66946007)(110136005)(5660300002)(16576012)(6486002)(52116002)(107886003)(66476007)(31696002)(478600001)(4326008)(8936002)(26005)(16526019)(66556008)(81156014)(81166006)(186003)(31686004)(36756003)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0502MB4066;
 H:AM0PR0502MB3905.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7nmRLiTYHO9KHgFtna7Oglb8FG2hP4lMWZ+8O8zVqc+mCPy+OXY8zkcvf6Yjdzgsc3I1lOOUD3OC+GKaLAhEs/N3dlIX3pAPV4B8X1UVcd/Ko4h9ifAqbJyU5JqbB2w07q/Ko17Zt78T9XifocbbWECzgmMs8IW+s7yZqrwd6C55n2fwz0ZNxnDmwFyRCcym9A9ZiySJIrKj1cT02EN6sp0/OEbtM1wvoCLUvfCYG34tdHxZfjDjZUzJsFQ7d5aKmtivTJNA7Kj/uN6AHEMH519Gj4bjatYUkbJ9qi/GxKIRdJOIJ7cReifW9TuHmUkn+rvsJFK6zW4c7Yc3FBFRXCLQE/29fC8W18HIf3E1L0MpvdNnfM/RgNL2LeVmx1/3fqHARx5GVNpvFRSi2wP/asbIEvp8dY6ulNZq3eqObeALiVio5xTGKzxQ5YU2FWs
X-MS-Exchange-AntiSpam-MessageData: nkHjE0KkCsfGc9+Gyuf6of+gE/N/Imk7yOd0XuDmbkB56qkkPe5qCaat1yr1b7C9GDQ+MfF0a1DN4dIrhMCBiIe88GnMRlCJoy8/BEXeq7swFhGgMJzDYWHg0jfzCOh4JZwVSrX5uSrBe8BcWMUaMA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b05dbe-4bc4-4039-7a84-08d7c8bec165
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2020 08:56:31.3307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmSi2EI9wWrcVpgkdaQBfzKnKgImppqovHtKHSLLpHSzbS6KBA7h8BTGehO0/L5HpmMQPRU0PCGAjcNNemh0jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200315_015640_792936_A8FB9DFC 
X-CRM114-Status: GOOD (  11.12  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xMy8yMDIwIDE6MDggQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5j
Cj4+Pj4gaW5kZXggZDYwMjJmYS4uNTdmOTAzMSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL252
bWUvaG9zdC9yZG1hLmMKPj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4+PiBA
QCAtMTA4NCw4ICsxMDg0LDEyIEBAIHN0YXRpYyBpbnQgbnZtZV9yZG1hX3NldHVwX2N0cmwoc3Ry
dWN0IAo+Pj4+IG52bWVfcmRtYV9jdHJsICpjdHJsLCBib29sIG5ldykKPj4+PiDCoCDCoMKgwqDC
oMKgIGNoYW5nZWQgPSBudm1lX2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJsLT5jdHJsLCBOVk1FX0NU
UkxfTElWRSk7Cj4+Pj4gwqDCoMKgwqDCoCBpZiAoIWNoYW5nZWQpIHsKPj4+PiAtwqDCoMKgwqDC
oMKgwqAgLyogc3RhdGUgY2hhbmdlIGZhaWx1cmUgaXMgb2sgaWYgd2UncmUgaW4gREVMRVRJTkcg
c3RhdGUgKi8KPj4+PiAtwqDCoMKgwqDCoMKgwqAgV0FSTl9PTl9PTkNFKGN0cmwtPmN0cmwuc3Rh
dGUgIT0gTlZNRV9DVFJMX0RFTEVUSU5HKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgLyoKPj4+PiAr
wqDCoMKgwqDCoMKgwqDCoCAqIHN0YXRlIGNoYW5nZSBmYWlsdXJlIGlzIG9rIGlmIHdlJ3JlIGlu
IERFTEVUSU5HIHN0YXRlLAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdW5sZXNzIHdlJ3JlIGR1
cmluZyBjcmVhdGlvbiBvZiBhIG5ldyBjb250cm9sbGVyIHRvCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqAgKiBhdm9pZCB1c2UgYWZ0ZXIgZnJlZSAoY3RybCByZWZjb3VudCBpcyBub3QgdGFrZW4geWV0
KS4KPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBXQVJOX09O
X09OQ0UoY3RybC0+Y3RybC5zdGF0ZSAhPSBOVk1FX0NUUkxfREVMRVRJTkcgfHwgbmV3KTsKPj4+
Cj4+PiBXaGF0IHN0YXRlIGFyZSB3ZSBpbiBpZiBub3QgREVMRVRJTkcgaW4gdGhpcyBjYXNlPwo+
Pgo+PiBXZSBhcmUgaW4gREVMRVRJTkcgc3RhdGUuCj4+Cj4+IFdpdGggdGhpcyBjaGFuZ2UgYW55
IHN0YXRlIGZhaWx1cmUgdHJpZ2dlcnMgYSB3YXJuaW5nIChpbmNsdWRpbmcgCj4+IERFTEVUSU5H
KSBpZiBuZXcgaXMgdHJ1ZS4KPj4KPj4gSW4gbXkgdGVzdCBJIHdhcyBpbiBERUxFVElORyBzdGF0
ZSBhbmQgd2l0aCBuZXcgPT0gdHJ1ZQo+Pgo+PiBUcnlpbmcgdG8gY2hhbmdlIHN0YXRlIGZyb20g
REVMRVRJTkcgdG8gTElWRSBpcyBub3QgYWxsb3dlZCBhdCB0aGUgCj4+IHN0YXRlIG1hY2hpbmUu
Cj4KPiBXaHkgZG8gd2UgbmVlZCBhIHdhcm5pbmcgb24gdGhhdD8KCkZpcnN0LCB0aGUgY29tbWVu
dCAic3RhdGUgY2hhbmdlIGZhaWx1cmUgaXMgb2sgaWYgd2UncmUgaW4gREVMRVRJTkcgCnN0YXRl
IiBpcyB3cm9uZy4KClN0YXRlIGNoYW5nZSBmYWlsdXJlIHNob3VsZCBub3QgaGFwcGVuIHdoZW4g
Y3JlYXRpbmcgYSBuZXcgY29udHJvbGxlciwgCmJlY2F1c2UgaXQgbWF5IGxlYWQgdG8gY29udHJv
bGxlciB1c2UgYWZ0ZXIgZnJlZS4KClNlY29uZCwgdGhlIHdhcm5pbmcgYWxyZWFkeSBleGlzdHMg
c28gSSBhbSBvbmx5IGZpeGluZyBpdC4KCgpSZWdhcmRzLAoKSXNyYWVsCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
