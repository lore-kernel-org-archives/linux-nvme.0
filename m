Return-Path: <SRS0=px+9=5B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BF1C0044D
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2020 18:44:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C66B20674
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2020 18:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XWySDs5v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="eT49s5nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C66B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZBRdbnfKiKLaU2XVhChnpNXnYYf1yEaud6OuS68U9WE=; b=XWySDs5v7/itH+Al8eUC/ESEV
	V/k8JLEuBubL+wSxVL8WKiUbLmq3Y/p+GS0da+i1PjY37urUk8ZhgP0l9NbYbL8DKwi4VcV+9W9/V
	wtwJQPFhQMmpZLNrrCqD+mkMe3ZmuRS6TjxFeNHOGf//9cTRMe6CcyeBQn8ASesqvwwy3l0QPdZVK
	ybs7AabXenz4VfkFmbvJg4Oh5Z0u4vO6pDqb6rI64QUVs56pDpNnjT5NnRLXKMJpALzZnwsRVzGKD
	YqvKbR29IV1Mx/gxFFzqIwdviuvJ+sDl5F4jKT5WKkjnIe9857V5RcZgm4fmL7n1odcXIyyuGP5dC
	Bw29QYSZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jDuii-0002ti-Ma; Mon, 16 Mar 2020 18:44:12 +0000
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jDuif-0002st-5w
 for linux-nvme@lists.infradead.org; Mon, 16 Mar 2020 18:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYavtYi7zdoCBleMvr+geQTNX6FUR+07mDBal4xLfyMEKWhBBZ9H1t1RSXUzKLrxIZ54otf6yct3PhAJ7rk1UJDlm94v8TGMDFi/jBcRWHOcw0lffN8nI5ZONwGbSCGhvgKFIK9pgflQD8y0Z9T2deUMzILggb9UGvZuMF1ieqQtnvq2N2Md8lU6k/iJR8YzFT6bV3dhsfmKlVGOQbpHOlpW/07d2w3S9u8cX6jbaf0LyaSb+MNgC1728vI7LmPqK19APP+QE3JxKuLOW6iXn6Nnp4I7Y2AxHVE16QXqc37ZyMFgPTqHk8PRC9nLnPpvcaB+fb41qaSimFy5VryDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s+JBq6Ta7RboolijoQt7tb5QpAesLZJp7/kc2AvXKE=;
 b=P4ag68t0pAWpkpA7pB55HXrrFAjyPFsz/6IlrG/cj9/Ui+wnzZKMqnIFZBdRZAt7jfSzBvEw+aZOjuhIn+6/Uanhl6zKczocag0pfoc3hArZ1SMyOYL2rw9/2UDxAUThBEhVrmBLtaS4RvSBQbI4KQSOqdNoW2pIhoWzwc9mWdOOeWM9Um5t6vrzwWIt3XLamMOz+7IAB1P27kLVQ2tSdtTTge0Im8A8MH8lj8+1SFbYrtNvc5bmqxnDKkOWkbRrSPBukxIp14m/soP/OIoUp/9UDZAS9NzQvfEsyVxkWYeKhURmKx9WUvzdtpEH6X0+QFqFiQj4+2iJW5kcEVq7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s+JBq6Ta7RboolijoQt7tb5QpAesLZJp7/kc2AvXKE=;
 b=eT49s5nIarGYrFqhmHZSdeGJ/teLIqrJ1r5pXB6mO46/E1fstc8A68PbDX+Nfq+wOQ1zym0j0I80G0xU8rNpSUurTCyDtdZ65eUauuq+X/T5yrSf4kVinHlVzQD+8oAO/2lMUy0aiB1yuuAOz3tJL193qsR+UmFIyxT7fSRtORU=
Received: from AM6PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:20b:2e::49)
 by DB7PR05MB5833.eurprd05.prod.outlook.com (2603:10a6:10:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Mon, 16 Mar
 2020 18:44:04 +0000
Received: from AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::8d) by AM6PR05CA0036.outlook.office365.com
 (2603:10a6:20b:2e::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend
 Transport; Mon, 16 Mar 2020 18:44:04 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT016.mail.protection.outlook.com (10.152.16.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Mon, 16 Mar 2020 18:44:03 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 16 Mar 2020 20:43:57
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 16 Mar 2020 20:43:57 +0200
Received: from [172.27.13.25] (172.27.13.25) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 16 Mar 2020 20:43:11
 +0200
Subject: Re: [PATCH 1/4] nvme-rdma: Fix warning at nvme_rdma_setup_ctrl
To: Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-2-git-send-email-israelr@mellanox.com>
 <974e3bd2-3282-5703-eba6-bc2675c98c8e@grimberg.me>
 <e15f12ab-bf40-423d-956a-199897a5b3f5@mellanox.com>
 <328e8c24-aadd-1a3a-0523-15dc352bd8ec@grimberg.me>
 <10b7614e-7e3f-095b-5c79-942a9d0593ba@mellanox.com>
 <ce753ba5-1e7e-a25d-f584-db73397cab06@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <57d67526-c08c-2f4e-f4a3-77292657e045@mellanox.com>
Date: Mon, 16 Mar 2020 20:43:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ce753ba5-1e7e-a25d-f584-db73397cab06@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.13.25]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(199004)(46966005)(70206006)(70586007)(53546011)(8936002)(2906002)(31696002)(86362001)(186003)(478600001)(110136005)(16576012)(36906005)(16526019)(316002)(36756003)(356004)(26005)(336012)(31686004)(5660300002)(2616005)(8676002)(81166006)(81156014)(47076004)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR05MB5833; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e643ac8a-3650-4f81-e6fc-08d7c9d9ffeb
X-MS-TrafficTypeDiagnostic: DB7PR05MB5833:
X-Microsoft-Antispam-PRVS: <DB7PR05MB5833AE75F7C77A672D870247B6F90@DB7PR05MB5833.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 03449D5DD1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8q02AqxlC4YtOMoyUTzY5FPwHWcgvnLGoD2s/h5r+UQ2RW1nnGGYSg7xUKa33Tf/BlKANb5hEz0xaCmRSU7CKMLV/fWgjxXU43f95DJgvFGgw6Erhzau9wAyg/5uLgqcZGxPUjw5tnuDDHtIXGoQCdAL/h7d8BcRUMne8ggxZiAcCtw6XIOctjFdG0J2jhwKOGQOOIiW1N6JJTtGJzMjPAb/J7dsdwCndQXcQCa9ZcNVruB05Ic3u0HdPFm1lTfHlj1K23TyJ3tG790vFolvoRmiC3S1/p8NF6lrX+WU9649aQIOFpu7Kj3Fq/xpq6MO42F6WCDt7CqJz5oqYDRxJk5kTIpNahpvYwKhIPy+0DbQ9eY3OZvFQ9+3uvECt4HdsnQ+M5uTwLbp85nVX6ZvLGVdNpQNZN+oooPEXHB9U23+PAktW7DktKRLC+ti3+fjjf9PqUmRINkOhVJN9VNatH+STMLb4v9MjImoF1vCxg0hsWSs/rUERH2K97G2n2PAKzasbJGeiEKxKNwGFxdxd8rwrLUwH8e8Byj8XLUNks=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 18:44:03.3179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e643ac8a-3650-4f81-e6fc-08d7c9d9ffeb
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5833
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200316_114409_775704_2DE5C621 
X-CRM114-Status: GOOD (  14.52  )
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

Ck9uIDMvMTYvMjAyMCA2OjQzIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcmRt
YS5jCj4+Pj4+PiBpbmRleCBkNjAyMmZhLi41N2Y5MDMxIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvcmRtYS5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1h
LmMKPj4+Pj4+IEBAIC0xMDg0LDggKzEwODQsMTIgQEAgc3RhdGljIGludCBudm1lX3JkbWFfc2V0
dXBfY3RybChzdHJ1Y3QgCj4+Pj4+PiBudm1lX3JkbWFfY3RybCAqY3RybCwgYm9vbCBuZXcpCj4+
Pj4+PiDCoCDCoMKgwqDCoMKgIGNoYW5nZWQgPSBudm1lX2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJs
LT5jdHJsLCAKPj4+Pj4+IE5WTUVfQ1RSTF9MSVZFKTsKPj4+Pj4+IMKgwqDCoMKgwqAgaWYgKCFj
aGFuZ2VkKSB7Cj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgLyogc3RhdGUgY2hhbmdlIGZhaWx1cmUg
aXMgb2sgaWYgd2UncmUgaW4gREVMRVRJTkcgc3RhdGUgKi8KPj4+Pj4+IC3CoMKgwqDCoMKgwqDC
oCBXQVJOX09OX09OQ0UoY3RybC0+Y3RybC5zdGF0ZSAhPSBOVk1FX0NUUkxfREVMRVRJTkcpOwo+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIHN0YXRl
IGNoYW5nZSBmYWlsdXJlIGlzIG9rIGlmIHdlJ3JlIGluIERFTEVUSU5HIHN0YXRlLAo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqAgKiB1bmxlc3Mgd2UncmUgZHVyaW5nIGNyZWF0aW9uIG9mIGEgbmV3
IGNvbnRyb2xsZXIgdG8KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogYXZvaWQgdXNlIGFmdGVy
IGZyZWUgKGN0cmwgcmVmY291bnQgaXMgbm90IHRha2VuIHlldCkuCj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoCAqLwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFdBUk5fT05fT05DRShjdHJsLT5jdHJs
LnN0YXRlICE9IE5WTUVfQ1RSTF9ERUxFVElORyB8fCAKPj4+Pj4+IG5ldyk7Cj4+Pj4+Cj4+Pj4+
IFdoYXQgc3RhdGUgYXJlIHdlIGluIGlmIG5vdCBERUxFVElORyBpbiB0aGlzIGNhc2U/Cj4+Pj4K
Pj4+PiBXZSBhcmUgaW4gREVMRVRJTkcgc3RhdGUuCj4+Pj4KPj4+PiBXaXRoIHRoaXMgY2hhbmdl
IGFueSBzdGF0ZSBmYWlsdXJlIHRyaWdnZXJzIGEgd2FybmluZyAoaW5jbHVkaW5nIAo+Pj4+IERF
TEVUSU5HKSBpZiBuZXcgaXMgdHJ1ZS4KPj4+Pgo+Pj4+IEluIG15IHRlc3QgSSB3YXMgaW4gREVM
RVRJTkcgc3RhdGUgYW5kIHdpdGggbmV3ID09IHRydWUKPj4+Pgo+Pj4+IFRyeWluZyB0byBjaGFu
Z2Ugc3RhdGUgZnJvbSBERUxFVElORyB0byBMSVZFIGlzIG5vdCBhbGxvd2VkIGF0IHRoZSAKPj4+
PiBzdGF0ZSBtYWNoaW5lLgo+Pj4KPj4+IFdoeSBkbyB3ZSBuZWVkIGEgd2FybmluZyBvbiB0aGF0
Pwo+Pgo+PiBGaXJzdCwgdGhlIGNvbW1lbnQgInN0YXRlIGNoYW5nZSBmYWlsdXJlIGlzIG9rIGlm
IHdlJ3JlIGluIERFTEVUSU5HIAo+PiBzdGF0ZSIgaXMgd3JvbmcuCj4KPiBUaGUgV0FSTl9PTl9P
TkNFIGlzIGRlc2lnbmVkIHRvIGluZGljYXRlIHRoYXQgd2UgZmFpbGVkIHRvIHRyYW5zaXRpb24K
PiB0aGUgc3RhdGUgYnV0IHdlIGRvbid0IHVuZGVyc3RhbmQgd2h5LiBJcyB0aGF0IHRoZSBjYXNl
IGhlcmU/Cj4KPj4gU3RhdGUgY2hhbmdlIGZhaWx1cmUgc2hvdWxkIG5vdCBoYXBwZW4gd2hlbiBj
cmVhdGluZyBhIG5ldyAKPj4gY29udHJvbGxlciwgYmVjYXVzZSBpdCBtYXkgbGVhZCB0byBjb250
cm9sbGVyIHVzZSBhZnRlciBmcmVlLgo+Cj4gU28gd2UgbmVlZCB0byBmaXggdGhhdCwgYnV0IHRo
ZSB3YXJuaW5nIHNob3VsZCBiZSBwcmludGVkIG9ubHkgd2hlbgo+IHdlIGdldCBhbiB1bmV4cGVj
dGVkIGJlaGF2aW9yIGZyb20gdGhlIGZsb3cgcGVyc3BlY3RpdmUuCj4KPj4gU2Vjb25kLCB0aGUg
d2FybmluZyBhbHJlYWR5IGV4aXN0cyBzbyBJIGFtIG9ubHkgZml4aW5nIGl0Lgo+Cj4gSSBkb24n
dCB1bmRlcnN0YW5kIHdoYXQgdGhpcyBpcyBmaXhpbmcuCgptYXliZSB3ZSBzaG91bGQgcmUtb3Jk
ZXIgdGhlIHBhdGNoZXMuCgpJc3JhZWwgZml4ZWQgdGhlIHVzZSBhZnRlciBmcmVlIGJ1ZyBpbiB0
aGlzIHNlcmllcy4KCkluIGNhc2Ugb2YgIm5ldyIgd2UgY2FuJ3QgZmFpbCBtb3ZpbmcgdG8gTlZN
RV9DVFJMX0xJVkUgbm93IGF0IGFsbCAKKHBhdGNoIDQvNCkuCgpXZSBkb24ndCBhbGxvdyBkaXNj
b25uZWN0IGR1cmluZyBpbml0aWFsIGNvbm5lY3Rpb24gZXN0YWJsaXNobWVudC4KCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWls
aW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
