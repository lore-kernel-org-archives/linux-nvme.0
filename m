Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E9C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:15:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23FF2065D
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FqZ2qj9p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ocSFVacr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23FF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XP9vVVKaXXsaS5k1lZ/F6SJkPAHR+RTQ6CTk5/yRkd0=; b=FqZ2qj9p3QPhSwMjoOQMfUrft
	H+CzN/CDUaWIcWLyf1JCDzL2CV88CKstZMdjQMTXAeau/M7YzRhFEBVB3IUDp/YAt48Zm21pA+N13
	4aZsFwEutq3hJmA5geZA29w2kwbsLs2r0MpN3hfiD7zbqZDXIF+IwneuuHvkzuBgJ7rSgS0RI/pf5
	qV9lcPbbyudfRYoUiUqfGzalJqjJaZeJyuOWhDRR8CFhPDVwYlVn4XY4TciN2GufUWgCu92E1H3ag
	o4/3Npy/sBRoBJnsaOBiE/sbKkRyjT/g5s2OKjUqWtU1FBzK0hui2Jt0RPJnG8Nc2ezaFy+LKJeKJ
	/JrrxpwQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ91i-0001VI-Cm; Thu, 14 May 2020 08:15:34 +0000
Received: from mail-am6eur05on2084.outbound.protection.outlook.com
 ([40.107.22.84] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ91e-0001SQ-FF
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 08:15:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee7gRJFa9ETWido4fHRQMyQnGSq2HFgODsaSEoY8ECW/EBEJvXl5LK61pFeZmP6Nz1UIlXXKjj1jhr5Z5iLHxliOjJ2/H7320zYsu/n2azqBeqKY0VIsK4mafaQElKRMC4+bhgZsMs0IeGQpfEpT+Aj/3HnMKKHzn3MFcRj1RCyLcyYw6yYbH1tQLv/NYrU+Rgi1PndKktxVQCNAySyQb6QNP80WxDIH9ftktzXAsPIj9S/Hhz7eGNvFKERO7SvA4ZD40MhDSsphO0GhfXNt/EvsnlRv/HET/7I5p+DzBkHHpMg7IVh7/WYEK4yZIal/31h7q61cYdQ733iV1yrfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzcIe5FYW7BptmSVq5PonNkVuGrHk5BJnyMweWzpT4M=;
 b=Wxot7V2QiiMgY+3PMzZ5lf0Xv+07qk7DMZC9utZnjULFGD90N+nNCSMZL621Xzp5ooPXdOciSAecnBLKW/aJ5vG01XoGRu4NKiLa0aByzeg7AXJu59RDBSOoF93LxekfewYpevCa3WTBv/bB/UZzCKGFEst1Owr3LChzOvdR0ol4oImuXcF0KVvFai+/CouJCB+XyH15cHg6LBbWDVMZWKa3XHMk9bwScLxzUGbDlT9Kr8gKp22xs11gelGix//GC5pHAUx21wcx587YkwrWOWm7kPz/jmm6jzB4G16aRBwLgIGXGOW2XMg94fa2nSuNSKILPuGRdQroxZlbe3pjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzcIe5FYW7BptmSVq5PonNkVuGrHk5BJnyMweWzpT4M=;
 b=ocSFVacrpb2zNz3FHP3/ZuwzfFmTaPn/BRWo0Bk2ubf2+hbdbgZ7w5nscNR/Mysni2FLZ9x3HDV2f6g9SAREkMGw849/cFNSTuBsXq/QDRBWIbyr1x5tPH/FIPdss9pFdVbImMIgR5vHGe83n0grqio/i7NNgDOtTPdluKbDZoA=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4995.eurprd05.prod.outlook.com (2603:10a6:208:c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Thu, 14 May
 2020 08:15:24 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 08:15:24 +0000
Subject: Re: [PATCH 06/16] nvme: enforce extended LBA format for fabrics
 metadata
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-7-maxg@mellanox.com>
 <33e04c87-f41a-e5a4-05f0-807d52bb78ff@broadcom.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <724d2910-1712-d85e-297b-0b5bbe804234@mellanox.com>
Date: Thu, 14 May 2020 11:15:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <33e04c87-f41a-e5a4-05f0-807d52bb78ff@broadcom.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0050.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::30) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM0PR10CA0050.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Thu, 14 May 2020 08:15:22 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26a103b3-be12-493e-e439-08d7f7def3c1
X-MS-TrafficTypeDiagnostic: AM0PR05MB4995:|AM0PR05MB4995:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB49951802370E106069BAFBF2B6BC0@AM0PR05MB4995.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vL44M1xVikr4DLaacylgO3moqzOKK29CIBg90RiKjDLW2OdeqH9EpSQxSl030zWVt6FkW2/Hx58NyoU08e8qQHltecPuX39K1oKLQY2YUy13ok5yXjgLAx89+6HVW9j815PiGfaPf5mpj9OcJSXevAwYETdf0oo06jLEPRweQiJ8gBMMd5gXXl4y83oYnjkWiYgnodPyS0WmuNutstWU7oDD+vbfVGw++Sh5qX4QT5kCPHot62sf6/REPW7GlBKyzeVx5G8+/otEpy22pO0wBemdE3zvfLJfRpmONpAjWo1kEYOOv7yUm5nBeJcfU5ieBMCxhTNT08PXwiVZEimx+6tAPJZgoI1Bv3JQrqIt+0hDE2TAC0edam4yqm7fjMdhzn0Q9RdmkISaneMZpBvXQPrIYBtZjhDQhvzqqYFMiUQxJKxSSLrEBSJBmyYI45YdrV7UHkB+sxFRqxa4SEGpXYvhPOc9NjHaYK4jWu83fn3GwpUMqOk3H6C6MiHrFHqZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(52116002)(36756003)(316002)(2616005)(86362001)(31696002)(16576012)(956004)(2906002)(31686004)(66476007)(4326008)(8936002)(478600001)(53546011)(6486002)(107886003)(16526019)(8676002)(5660300002)(186003)(26005)(66946007)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8aLrcMUGlMhuJESLmGJ/Hu3s7+uVV8o7/Q6SG/m0VfkLyIHeX+kZT6m7SfYhlyV3DGkcZP55Minc6RataYej07mZKe9RZKXnKYn0XuH/i8P4qWiKQ5AC2K7IjsYyQZglh1axaZ0ICdhCNhOr8NPfWag7ObW5dRE5oAn/djSbF+mFdpcscIQe9sMUpIll8ENCfopVc5SO3eOs8YKLMP2kEQUAXO8lmDLd5W3gw3wsfEGhw0MA3SS/9PVngLHK5FLlXRCKw5i3jZPeNW00myP2d1oBX1Qa7t0UWYdz+MTE7wkufUd4DL7B8M2sy1T/gS7uWcPIbVZz7tc/lOyjGEW6F2EV1/Dt7MvdFoItdTxlLAcntoxvFXRVjaOGeokBZqxUYyT3yvDZ5fuC+YLwE7/cnAg51eH3X7Uw8wOdxyJZcVcFHbWOKajsEes1WYqk2w5RA4kdiq9mh0aKpVGo4OSce8kJxj1/uNictGcj/dKZbfx8OPJgluH1sO4b4xYD45jv
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a103b3-be12-493e-e439-08d7f7def3c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 08:15:24.2474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f09LlEi0JVwNSO2iQMCvH5QFcEzLEHx8QbGhWdStssY0iFE6o+GwQLfJ0UDHt1QrZ1lvDYVVpsC6SvIO7snEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4995
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_011530_568738_71A60DDE 
X-CRM114-Status: GOOD (  18.48  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDUvMTMvMjAyMCAxMDowMyBQTSwgSmFtZXMgU21hcnQgd3JvdGU6Cj4KPgo+IE9uIDUvNC8y
MDIwIDg6NTcgQU0sIE1heCBHdXJ0b3ZveSB3cm90ZToKPj4gQW4gZXh0ZW5kZWQgTEJBIGlzIGEg
bGFyZ2VyIExCQSB0aGF0IGlzIGNyZWF0ZWQgd2hlbiBtZXRhZGF0YSBhc3NvY2lhdGVkCj4+IHdp
dGggdGhlIExCQSBpcyB0cmFuc2ZlcnJlZCBjb250aWd1b3VzbHkgd2l0aCB0aGUgTEJBIGRhdGEg
KEFLQQo+PiBpbnRlcmxlYXZlZCkuIFRoZSBtZXRhZGF0YSBtYXkgYmUgZWl0aGVyIHRyYW5zZmVy
cmVkIGFzIHBhcnQgb2YgdGhlIExCQQo+PiAoY3JlYXRpbmcgYW4gZXh0ZW5kZWQgTEJBKSBvciBp
dCBtYXkgYmUgdHJhbnNmZXJyZWQgYXMgYSBzZXBhcmF0ZQo+PiBjb250aWd1b3VzIGJ1ZmZlciBv
ZiBkYXRhLiBBY2NvcmRpbmcgdG8gdGhlIE5WTWVvRiBzcGVjLCBhIGZhYnJpY3MgY3RybAo+PiBz
dXBwb3J0cyBvbmx5IGFuIEV4dGVuZGVkIExCQSBmb3JtYXQuIEZhaWwgcmV2YWxpZGF0aW9uIGlu
IGNhc2Ugd2UgCj4+IGhhdmUgYQo+PiBzcGVjIHZpb2xhdGlvbi4gQWxzbyBhZGQgYSBmbGFnIHRo
YXQgd2lsbCBpbXBseSBvbiBjYXBhYmxlIHRyYW5zcG9ydHMgCj4+IGFuZAo+PiBjb250cm9sbGVy
cyBhcyBwYXJ0IG9mIGEgcHJlcGFyYXRpb24gZm9yIGFsbG93aW5nIGVuZC10by1lbmQgcHJvdGVj
dGlvbgo+PiBpbmZvcm1hdGlvbiBmb3IgZmFicmljIGNvbnRyb2xsZXJzLgo+Pgo+PiBTdWdnZXN0
ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+PiBTaWduZWQtb2ZmLWJ5OiBN
YXggR3VydG92b3kgPG1heGdAbWVsbGFub3guY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBJc3JhZWwg
UnVrc2hpbiA8aXNyYWVsckBtZWxsYW5veC5jb20+Cj4+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGgg
SGVsbHdpZyA8aGNoQGxzdC5kZT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
YyB8IDQxIAo+PiArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQo+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKPj4gaW5kZXggODliMWJmY2IuLmY1NjUyODEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4g
QEAgLTE5NDEsMTYgKzE5NDIsMjQgQEAgc3RhdGljIHZvaWQgX19udm1lX3JldmFsaWRhdGVfZGlz
ayhzdHJ1Y3QgCj4+IGdlbmRpc2sgKmRpc2ssIHN0cnVjdCBudm1lX2lkX25zICppZCkKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIG5zLT5waV90eXBlID0gMDsKPj4gwqAgwqDCoMKgwqDCoCBpZiAobnMt
Pm1zKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoaWQtPmZsYmFzICYgTlZNRV9OU19GTEJBU19N
RVRBX0VYVCkKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnMtPmZlYXR1cmVzIHw9IE5WTUVf
TlNfRVhUX0xCQVM7Cj4+IC0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+IC3CoMKgwqDCoMKg
wqDCoMKgICogRm9yIFBDSSwgRXh0ZW5kZWQgbG9naWNhbCBibG9jayB3aWxsIGJlIGdlbmVyYXRl
ZCBieSB0aGUKPj4gLcKgwqDCoMKgwqDCoMKgwqAgKiBjb250cm9sbGVyLiBOb24tZXh0ZW5kZWQg
Zm9ybWF0IGNhbiBiZSBnZW5lcmF0ZWQgYnkgdGhlCj4+IC3CoMKgwqDCoMKgwqDCoMKgICogYmxv
Y2sgbGF5ZXIuCj4+ICvCoMKgwqDCoMKgwqDCoMKgICogRm9yIFBDSWUgb25seSB0aGUgc2VwYXJh
dGUgbWV0YWRhdGEgcG9pbnRlciBpcyBzdXBwb3J0ZWQsCj4+ICvCoMKgwqDCoMKgwqDCoMKgICog
YXMgdGhlIGJsb2NrIGxheWVyIHN1cHBsaWVzIG1ldGFkYXRhIGluIGEgc2VwYXJhdGUgYmlvX3Zl
Ywo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGNoYWluLiBGb3IgRmFicmljcywgb25seSBtZXRhZGF0
YSBhcyBwYXJ0IG9mIGV4dGVuZGVkIGRhdGEKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBMQkEgaXMg
c3VwcG9ydGVkIG9uIHRoZSB3aXJlIHBlciB0aGUgRmFicmljcyBzcGVjaWZpY2F0aW9uLAo+PiAr
wqDCoMKgwqDCoMKgwqDCoCAqIGJ1dCB0aGUgSEJBL0hDQSB3aWxsIGRvIHRoZSByZW1hcHBpbmcg
ZnJvbSB0aGUgc2VwYXJhdGUKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBtZXRhZGF0YSBidWZmZXJz
IGZvciB1cy4KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4gLcKgwqDCoMKgwqDCoMKgIGlm
IChucy0+Y3RybC0+b3BzLT5mbGFncyAmIE5WTUVfRl9NRVRBREFUQV9TVVBQT1JURUQpIHsKPj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEobnMtPmZlYXR1cmVzICYgTlZNRV9OU19FWFRf
TEJBUykpCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoaWQtPmZsYmFzICYgTlZNRV9OU19GTEJBU19N
RVRBX0VYVCkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBucy0+ZmVhdHVyZXMgfD0gTlZN
RV9OU19FWFRfTEJBUzsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKChjdHJsLT5vcHMt
PmZsYWdzICYgTlZNRV9GX0ZBQlJJQ1MpICYmCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKGN0cmwtPm9wcy0+ZmxhZ3MgJiBOVk1FX0ZfTUVUQURBVEFfU1VQUE9SVEVEKSAmJgo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0cmwtPm1heF9pbnRlZ3JpdHlfc2Vn
bWVudHMpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnMtPmZlYXR1cmVzIHw9
IE5WTUVfTlNfTUVUQURBVEFfU1VQUE9SVEVEOwo+Cj4gVGhpcyBpcyBvay7CoCBMYXRlciBwYXRj
aGVzIHdpbGwgc2hvdWxkIGRlYWwgd2l0aCBubyBibG9jay1sYXllciAKPiBpbnRlZ3JpdHkgYnVm
ZmVyLCBidXQgaGF2aW5nIHRoZSB0cmFuc3BvcnQgcG9ydCBhdXRvLWdlbmVyYXRlL3N0cmlwIAo+
IGludGVybGVhdmVkIHBpIGRhdGEsIGFzIHdlIHdpbGwgd2FudCB0byBwcm90ZWN0IGR1cmluZyB0
cmFuc21pc3Npb24gb24gCj4gdGhlIHdpcmUsIG5vdCBqdXN0IFBSQUNUPTEgaXQuCgpQUkFDVD0x
IHdpbGwgaW1wbHkgdGhhdCBhY3Rpb24gc2hvdWxkIGJlIGRvbmUgYnkgdGhlIGNvbnRyb2xsZXIg
KGNhbiBiZSAKaG9zdCBjb250cm9sbGVyIGZvciBmYWJyaWNzIGFzIHdlbGwpLgoKSW4gUkRNQSwg
aWYgd2UgZG9uJ3QgZ2V0IGJsb2NrLWxheWVyIGludGVncml0eSBidWZmZXIsIHdlJ2xsIApnZW5l
cmF0ZS9zdHJpcCBtZXRhZGF0YSBhbmQgaXQgd2lsbCBiZSBzZW50IG9uIHRoZSB3aXJlLgoKSSBh
Z3JlZSB0aGF0IHRoaXMgd29uJ3QgYmUgZG9uZSBpZiAhSVNfRU5BQkxFRChDT05GSUdfQkxLX0RF
Vl9JTlRFR1JJVFkpIAphbmQgd2UgY2FuIGZpeCBpdCBpbiB0aGUgZnV0dXJlLgoKCj4KPj4gK8Kg
wqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChXQVJO
X09OX09OQ0UoY3RybC0+b3BzLT5mbGFncyAmIE5WTUVfRl9GQUJSSUNTKSkKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKGN0cmwtPm9wcy0+ZmxhZ3MgJiBOVk1FX0ZfTUVUQURBVEFfU1VQUE9SVEVE
KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5zLT5mZWF0dXJlcyB8PSBO
Vk1FX05TX01FVEFEQVRBX1NVUFBPUlRFRDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPgo+IFRo
ZSBOVk1FX0ZfTUVUQURBVEFfU1VQUE9SVEVEIGZsYWcgc2hvdWxkIGJlIG9uIGEgcGVyLWN0cmwg
YmFzaXMuIAo+IFRoZXJlIHdpbGwgYmUgZGlmZmVyZW50IHRyYW5zcG9ydCBwb3J0cyB1bmRlciB0
aGUgc2FtZSB0cmFuc3BvcnQgd2l0aCAKPiBkaWZmZXJlbnQgYWJpbGl0aWVzLgo+Cj4gSSdtIG9r
IGlmIHRoZXNlIHBhdGNoZXMgZ28gaW4sIHRoZW4gYSBsYXRlciBwYXRjaCBtb3ZlcyB0aGUgZmxh
Z3MgCj4gKG1pZ2h0IGFzIHdlbGwgbW92ZSBOVk1FX0ZfRkFCUklDUyB0b28pLgoKY3RybC0+bWF4
X2ludGVncml0eV9zZWdtZW50cyB3aWxsIGNvdmVyIHRoaXMgYXMgd2VsbDoKCmlmICgoY3RybC0+
b3BzLT5mbGFncyAmIE5WTUVfRl9NRVRBREFUQV9TVVBQT1JURUQpICYmIApjdHJsLT5tYXhfaW50
ZWdyaXR5X3NlZ21lbnRzKQoKCj4KPgo+IFJldmlld2VkLWJ5OsKgIEphbWVzIFNtYXJ0IDxqYW1l
cy5zbWFydEBicm9hZGNvbS5jb20+Cj4KPiAtLSBqYW1lcwo+Cj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0Cmxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
