Return-Path: <SRS0=VV3U=5V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B1AC2BA15
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2020 14:44:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EE220672
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2020 14:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O+XM4Yi3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rtTsE4Jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EE220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fwj4mGccOfhsWun0RHUlpzFXgRiuY/r1rhYO/6uMw44=; b=O+XM4Yi3BNoqYkOIkNMzrRmAd
	cnPLRdz++YCSSit4TECFbTz7TqBuVh4q99OQs4vSdUPBJVKUvxAvpQTDiAohk36RHqYnM6wad8cv6
	lfwZuIlnh0QYilDlNb5CES266ZXnF8E9Hk3B2AqEYvnjEbSgIzbouHerHUfoclFB+RQZJczkRFtbh
	/PCYgOkqODodqGQ9JItTaVwPkDM3Z5BJVEwZiV+VC8Y2V5jeG2r9+8v73/Y9iUjl3L/o8lo/l3yMf
	m+YyWJTl2W6yEyqKOdNHOsDn5eaNOM3qi6auzATagRiLEorWFRMVcJ7LWFC3jBmpt6Jtg/SJDm5Ni
	Jpb+p2mgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jL6V8-0007VO-Ke; Sun, 05 Apr 2020 14:43:54 +0000
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jL6V5-0007Uq-Pz
 for linux-nvme@lists.infradead.org; Sun, 05 Apr 2020 14:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGrKAPpG7dbGB2acQnvr+PZd82jo57t3UXn44HKm1kzLz35zltfCrd5Ppl5BZrO9mP898JJ7gXB2lBX6qGsjLy5DgAAl9R5j+Ty1VBVMoNmdxzMkk4VXGnEfubTADOljm+CCZb7mCb7XLB3DChGPYNZZ/4PtdE4Ca+nm+4pMb/LOZ4bmzbJUGAjaplAzY3PhGL8CI4OahZlyrq0oa6aTPYwKvrLay4w0GnTRO3Z/2+UEE8AHINWfC0HiX4kLRYnf9TVbvdgpLlwgpCzEtGHW5k4R90BiN1c9bTJuTCH8nCkKDRMlDQvRAsQbET+vRiGsS6yf5IZr9hcyQDn03Wq6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SJhDMeXoiRbUZ0v/okcRcuNP0rPPl1Qi75qIoT3hOw=;
 b=PgxuR68jjLevh++yK55dBbsch47I/BQ7X/vORCJsAoD5oMQEBcpmbJI2oa/CPe8JibU3aUHxu+gSMz4Go0sQeL3FHQnTfDB6QeDsYbuaatz5Yxm/DexTMAOh5AfbC0KqcXl0bJLrqal/O5R3bCCF+1VLejLkp3BUrlCQYkXZtnoJNiJms423Ko+7Ro0nYDw2bsjdFWwgkal75zdKNVwhIBaz+wR046tfo5tt+XPvXyTL6pfxA6g4kYxWFTJbeIJ4MtAt3FAc4kD15fFq5XPXQkJrPdMp+ZAZnOZMEL0aTGkSoHu19U0tGaSp/rmYom9u2LNd0u8Y3BT6e/p2XkB/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SJhDMeXoiRbUZ0v/okcRcuNP0rPPl1Qi75qIoT3hOw=;
 b=rtTsE4JySezrxs+xqYElUnZfYFvHhJsATC6LvG6Le8NwhlwvK0qI0RtdrpJFQONkFwjuEuUwphDGTiGOc2X1QMik2gdFFzhqLECCF9BVQWNLCSnqDlo61LStGSb0PVITcj1VDjZWDq5iwPzGa41CMLaQ724EBe9KZMqXqLhEFQE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=israelr@mellanox.com; 
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::23) by AM0PR0502MB3891.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Sun, 5 Apr
 2020 14:43:47 +0000
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::1cc3:ec98:a1f:befd]) by AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::1cc3:ec98:a1f:befd%2]) with mapi id 15.20.2878.021; Sun, 5 Apr 2020
 14:43:47 +0000
Subject: Re: [PATCH] nvmet-rdma: Fix double free of rdma queue
To: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1585477302-4307-1-git-send-email-israelr@mellanox.com>
 <39a9e27b-51fa-6c87-8e5f-17f4f7318bd0@grimberg.me>
 <05c7907c-9c43-2a2b-c760-bff0364892d9@mellanox.com>
 <f356a0d4-2e05-f629-ebab-a55e7e0c369b@grimberg.me>
 <b5111042-d90a-0c48-6fe0-3cceca1b75a2@mellanox.com>
 <edbcdf17-ef8c-f937-bea6-b5bdffb7b202@grimberg.me>
From: Israel Rukshin <israelr@mellanox.com>
Message-ID: <69eadde6-7d93-cf61-9e98-f34c9f55924d@mellanox.com>
Date: Sun, 5 Apr 2020 17:43:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <edbcdf17-ef8c-f937-bea6-b5bdffb7b202@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::24) To AM0PR0502MB3905.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.14.112] (79.180.195.128) by
 AM4P190CA0014.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Sun, 5 Apr 2020 14:43:46 +0000
X-Originating-IP: [79.180.195.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86484d66-d4f3-4b4d-3917-08d7d96fbf64
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3891:|AM0PR0502MB3891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB38917BCF4CC1EFEB13012FD0D7C50@AM0PR0502MB3891.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR0502MB3905.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(478600001)(66946007)(36756003)(110136005)(2616005)(956004)(5660300002)(2906002)(16526019)(316002)(16576012)(53546011)(66556008)(66476007)(186003)(26005)(81166006)(31686004)(86362001)(31696002)(6666004)(6486002)(8676002)(81156014)(4326008)(8936002)(107886003)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9t2qtZA7GXMaLmy+wSQKTuhLExeBWXvtLe4MyecTcdTau/eKs89h3nyuUWLyXFbFA2558xc2CkzjHvkyznSr8XX+2tjQ6RuF4QYvaH267Lj9KmHfZQzqowL8v3UEK+fY0CjkRKg06JsNGA5Qr0a5JtP9ORQSmpx2YhyBHJiPRgAWfoULBz0OIpSsFC2GBfYu0WH6qdL6IjLLxEm1CgNCHiHm18Vf1XxS367IHw1eS+K8hWRvv9L0jr4n3BMwjbFrfEOQ1rEEZ8mihBVVE6ZM0EV6uvGbqgFS5kAPs+UdOL6F3d2RBNl6+8qWAZ3GYP4VCFCLA0xrx9qGxRH/2kyCS8ApQFPR2ePe1oHRyJsPgnNQ2NLFQjjmh3J4skqcBnwU7j8NtSf7SrXIq7hKNnQ/+g44FteKyitq1MBiQi58h2nV3CWRCAvdA0Jf+cquqaz
X-MS-Exchange-AntiSpam-MessageData: fG1d+WvVXmGf0LNm3hAaSjAArvFgBvIMdRs9H92ITkU6J2sXTad812tM7y3c4jp6i8a7XYeZy8vTVL6CyWajU18w2BNjmrdktpI5KzSXXxf6szlzg2kDmRA7r/6wqfgLnYYGBCjx/qVQMou/6ZG5MQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86484d66-d4f3-4b4d-3917-08d7d96fbf64
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 14:43:47.3637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECafokabHqqHK9thwH3EB0HnnZXULOQYSt5dfUlrjpAYjF6es/TuWFRMr8OsktF0A1mb4BTTcYmHVnbIj/BgGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3891
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200405_074351_922839_8108A527 
X-CRM114-Status: GOOD (  20.63  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8zMS8yMDIwIDk6NDIgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPgo+IE9uIDMvMzAv
MjAgMjozNyBBTSwgSXNyYWVsIFJ1a3NoaW4gd3JvdGU6Cj4+IE9uIDMvMzAvMjAyMCAxMTo1NiBB
TSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lL3RhcmdldC9yZG1hLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYwo+Pj4+Pj4gaW5k
ZXggMzdkMjYyYS4uNTkyMDllMyAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvcmRtYS5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYwo+Pj4+Pj4g
QEAgLTEzODAsMTMgKzEzODAsMTQgQEAgc3RhdGljIHZvaWQgCj4+Pj4+PiBudm1ldF9yZG1hX3F1
ZXVlX2Nvbm5lY3RfZmFpbChzdHJ1Y3QgcmRtYV9jbV9pZCAqY21faWQsCj4+Pj4+PiDCoCB7Cj4+
Pj4+PiDCoMKgwqDCoMKgIFdBUk5fT05fT05DRShxdWV1ZS0+c3RhdGUgIT0gTlZNRVRfUkRNQV9R
X0NPTk5FQ1RJTkcpOwo+Pj4+Pj4gwqAgK8KgwqDCoCBwcl9lcnIoImZhaWxlZCB0byBjb25uZWN0
IHF1ZXVlICVkXG4iLCBxdWV1ZS0+aWR4KTsKPj4+Pj4+ICsKPj4+Pj4+IMKgwqDCoMKgwqAgbXV0
ZXhfbG9jaygmbnZtZXRfcmRtYV9xdWV1ZV9tdXRleCk7Cj4+Pj4+PiAtwqDCoMKgIGlmICghbGlz
dF9lbXB0eSgmcXVldWUtPnF1ZXVlX2xpc3QpKQo+Pj4+Pj4gK8KgwqDCoCBpZiAoIWxpc3RfZW1w
dHkoJnF1ZXVlLT5xdWV1ZV9saXN0KSkgewo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGxpc3Rf
ZGVsX2luaXQoJnF1ZXVlLT5xdWV1ZV9saXN0KTsKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzY2hl
ZHVsZV93b3JrKCZxdWV1ZS0+cmVsZWFzZV93b3JrKTsKPj4+Pj4KPj4+Pj4gVGhpcyBoYXMgYSBo
aWRkZW4gYXNzdW1wdGlvbiB0aGF0IHRoZSBjb25uZWN0IGhhbmRsZXIgYWxyZWFkeQo+Pj4+PiBz
Y2hlZHVsZWQgdGhlIHJlbGVhc2UuCj4+Pj4+Cj4+Pj4+IFdoeSBkb24ndCB3ZSBzaW1wbHkgbm90
IHF1ZXVlIHRoZSByZWxlYXNlX3dvcmsgaW4gdGhlIGFjY2VwdAo+Pj4+PiBmYWlsdXJlIGFuZCBy
ZXR1cm4gYSBuZWdhdGl2ZSBzdGF0dXMgY29kZSB0byBpbXBsaWNpdGx5IHJlbW92ZSB0aGUKPj4+
Pj4gY21faWQ/IHRoaXMgd2F5IHdlIHdpbGwgbmV2ZXIgc2VlIGFueSBjbSBldmVudHMgYW5kIHdl
IGRvbid0Cj4+Pj4+IG5lZWQgdG8gaGFuZGxlIGl0Lgo+Pj4+Cj4+Pj4gVGhpcyBjaGFuZ2VzIHRo
ZSBmbG93IGJ1dCBJIGd1ZXNzIHdlIGNhbiBjaGVjayB0aGlzIG91dC4KPj4+Pgo+Pj4+IEJ1dCBz
dGlsbCwgdGhpcyBmbG93IGNhbiBiZSBjYWxsZWQgZnJvbSAzIGRpZmZlcmVudCBldmVudHMgCj4+
Pj4gKFJETUFfQ01fRVZFTlRfUkVKRUNURUQsIFJETUFfQ01fRVZFTlRfVU5SRUFDSEFCTEUsIAo+
Pj4+IFJETUFfQ01fRVZFTlRfQ09OTkVDVF9FUlJPUikgc28gSSBwcmVmZXIgdG8gbG9jYXRlIHRo
ZSAKPj4+PiBzY2hlZHVsZV93b3JrIHVuZGVyIHRoZSAiaWYiLgo+Pj4KPj4+IFRoaXMgaWYgaXMg
b25seSBjaGVja2VkIGluIGNvbm5lY3QgZXJyb3IuIEFueXdheSwgaWYgeW91IGZlZWwgdGhhdAo+
Pj4gdGhpcyBmbG93IGlzIHJhY3ksIHBlcmhhcHMgaW1wbGVtZW50IGEgcHJvcGVyIHNlcmlhbGl6
YXRpb24sIGluc3RlYWQKPj4+IG9mIGNoZWNraW5nIGEgcmFuZG9tICJpZiIgdGhhdCBtYWtlcyB0
aGUgcmVhZGVyIHRoaW5rIHdoeSBhcmUgdGhleQo+Pj4gZXZlbiByZWxhdGVkLgo+Pgo+PiBUaGlz
ICJpZiIgaXMgZXhhY3RseSBsaWtlIHdlIGFyZSBkb2luZyBhdCBudm1ldF9yZG1hX3F1ZXVlX2Rp
c2Nvbm5lY3QoKS4KPgo+IFlvdSdyZSByaWdodC4KPgo+PiBBbGwgdGhlIG90aGVyIHBsYWNlcyBi
ZWZvcmUgY2FsbGluZyBfX252bWV0X3JkbWFfcXVldWVfZGlzY29ubmVjdCgpIAo+PiBkZWxldGUg
dGhlIHF1ZXVlIGZyb20gdGhlIGxpc3QuCj4+Cj4+IFNvIEkgZ3Vlc3MgbXkgY2hhbmdlIGFsc28g
cHJvdGVjdCB1cyBmcm9tIHJhY2VzIHdpdGggCj4+IG52bWV0X3JkbWFfZGVsZXRlX2N0cmwvbnZt
ZXRfcmRtYV9yZW1vdmVfb25lLgo+Pgo+PiBCZXNpZGUgdGhhdCwgd2h5IGRvIHdlIG5lZWQgdG8g
Y2hlY2sgaWYgdGhlIGxpc3QgaXMgbm90IGVtcHR5IGJlZm9yZSAKPj4gcmVtb3ZpbmcgaXQgZnJv
bSB0aGUgbGlzdCBhdCBudm1ldF9yZG1hX3F1ZXVlX2Nvbm5lY3RfZmFpbCgpPwo+Pgo+PiBJIGRv
bid0IHNlZSBhIHJlYXNvbiB3aHkgdG8gcmVtb3ZlIG9ubHkgdGhlIHF1ZXVlIGZyb20gdGhlIGxp
c3QgCj4+IHdpdGhvdXQgc2NoZWR1bGUgdGhlIHJlbGVhc2Ugd29yay4KPgo+IFRoYXQgaXMgZmlu
ZSB3aXRoIG1lLCBhc3N1bWluZyB3ZSBoYXZlIGEgcHJvcGVyIGNvbW1lbnQuCj4KPiBCdXQgaWYg
d2UgdGFrZSBhIHN0ZXAgYmFjaywgbnZtZXRfcmRtYV9jcmVhdGVfcXVldWVfaWIgZG9lcyBub3Qg
Y3JlYXRlCj4gdGhlIGNtX2lkLCBzbyB3aHkgc2hvdWxkIGRlc3Ryb3lfcXVldWVfaWIgZGVzdHJv
eSBpdD8KPgpUaGlzIGlzIGJlY2F1c2Ugd2UgY2FuJ3QgZGVzdHJveSB0aGUgUVAgYmVmb3JlIGRl
c3Ryb3lpbmcgdGhlIGNtX2lkLgoKWW91IGNhbiBsb29rIGF0IHRoZSBmb2xsb3dpbmcgY29tbWl0
IGZyb20gaWJfaXNlcnQ6ICIxOWUyMDkwIAppc2VyLXRhcmdldDogRml4IGNvbm5lY3RlZF9oYW5k
bGVyICsgdGVhcmRvd24gZmxvdyByYWNlIgoKSW4gb3JkZXIgdG8gYXZvaWQgZnJlZWluZyBudm1l
dCByZG1hIHF1ZXVlcyB3aGlsZSBoYW5kbGluZyByZG1hX2NtIApldmVudHMsIHdlIGRlc3Ryb3kg
dGhlIHFwIGFuZCB0aGUgcXVldWUgYWZ0ZXIKCmRlc3Ryb3lpbmcgdGhlIGNtX2lkIHdoaWNoIGd1
YXJhbnRlZXMgdGhhdCBhbGwgcmRtYV9jbSBldmVudHMgYXJlIGRvbmUuCgo+IFdoYXQgaWYgd2Ug
bWFkZSBkZXN0cm95aW5nIHRoZSBjbV9pZCBpbiByZWxlYXNlX3dvcmsgKG91dCBvZiAKPiBudm1l
dF9yZG1hX2ZyZWVfcXVldWUpIGFuZCBoYXZlIHRoZSBhY2NlcHQgZXJyb3IgcGF0aCByZXR1cm4g
YSBub3JtYWwKPiBuZWdhdGl2ZSByZXQgdG8gaW1wbGljaXRseSBkZXN0cm95IHRoZSBjbV9pZD8K
V2UgY2FuJ3QgZGVzdHJveSB0aGUgY21faWQgYXQgcmVsZWFzZV93b3JrIGFmdGVyIGNhbGxpbmcg
dG8gCm52bWV0X3JkbWFfZnJlZV9xdWV1ZSAoSSBhbSBub3Qgc3VyZSB0aGF0IHdlIGNhbiBkZXN0
cm95IGl0IGJlZm9yZSAKY2FsbGluZyBudm1ldF9yZG1hX2ZyZWVfcXVldWUpLgo+Cj4gSW4gYSBz
ZW5zZSwgdGhhdCB3b3VsZCBtYWtlIHRoZSBiZWhhdmlvciBzeW1tZXRyaWMuIFRob3VnaHRzPwpT
bywgd2UgY2FuJ3QgbWFrZSBpdCBzeW1tZXRyaWMuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
