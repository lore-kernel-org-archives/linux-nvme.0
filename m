Return-Path: <SRS0=mOBO=5P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ACCC43331
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 08:22:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D3B206CC
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 08:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LYKZS3TI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="guroBIk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D3B206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NcVol/nonVBIhDp/F7YbwlHMszpSqBwINcup/BFeoJk=; b=LYKZS3TIImTFyYSXqHnmmNW+T
	W7T8oMPshFciHjsoqX4KJ2kwi233N5zDAVcHv06VSYrBwEJa7T1CInx2W/0yzFzeS8eM6qiQQLLIm
	3Stiw1uXeX4FaIlT/lKeuui1W0gUl/tjG5/4ykJasKDJ4LOe5nbGRhjj5KtZSu1BzaSBiIsCcYtX0
	T0PypXcvjF3qG4zPsUSxcF/RHPsVVdnm830AmYR+fZKpmiyfCRSVNS8vvQfYDMqe9IGeyKLHjIxmX
	XKasL+tydwCcVkvzcFCtu8+93LUPSupkz5SRENpBIMx9qkNWmynIf6EVERTRiniqgVH+KgTJ60xTt
	+cAVtRIxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIph2-0006J2-Po; Mon, 30 Mar 2020 08:22:48 +0000
Received: from mail-db8eur05on2086.outbound.protection.outlook.com
 ([40.107.20.86] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIpgz-0006Gg-Gi
 for linux-nvme@lists.infradead.org; Mon, 30 Mar 2020 08:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvIuJ+VuK5pAH4xd6Q/GcYmL/cP7t9qcd0KyUmj3C1uLiSKlwq/6r0z2C+H1B9kfDkWO+pYR3Oh80xHJeNi9bIUF+lmG5M0ZsOn8lcWXF6kPo0fDu2AXBDfL3JBcRUGcRBR966LihmyfaiiXydbzYKekbxzQ6LrZfH0mxzj12OTt2PaOBRM9RpBV/OeERKNS2SazqZL+Fun98TBNxeCHu+RBeQtF+Fe7RFfbmh6L+EiUL3PuJd+AX0+9zzXcCWwqV5F58lBPRlNOAno6Un4zqGVOOjNycD6nOwYEBKUD59Ru2lSboIi7eZyIXzhgfEr+6x+FYwjMTdTgTciyqhGnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI6XgwVXbSf8VT9xThiGB7HDHeydhsS8KE0GbVRz8/w=;
 b=cNU5F/xTQmTH/aezy5Yl+PA2gpZ+7eGFg1Go3Z8CoYz+9WwZOnxiMJKRjzyPTPxNM0opwynWq0Q3KAXdag3II9qDeHefwRLljf1aUMP+8AY9TR548ovIErfNRjPsblu/xnTF6Uv4QMeQ0/o9Q/NPevn09Zu0NPiFfWiJzFJvGpYrp6WIzMl9YlMrOpGI7jNhUoJUqWeZ2ku8etNYiyLs0EYZUdHtvENJv8MU8UjAKqV+blEwbUOde66WEKKwEGizY3Tz4QaJp7xV1SfEuRWbfuRMwLUs07a1hvni/MwpE5Hoi/RvbxxdaKlPs7YFQrvGsUNmYJuVsb84e9jrAiTN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI6XgwVXbSf8VT9xThiGB7HDHeydhsS8KE0GbVRz8/w=;
 b=guroBIk8j8WM4TbyU0p+Y0qgL6JAoS4kDAgVvT7OktWV4Xgj0DmiXHOknMNrGlue9fBMw+LFU3ECrRoaktHTaa6VeAzYpj1OJtUgt9/SBh/uuBLzNDtxn60rIx4QiuWtyQSi0J8ivxdDmCdP6BKdQEyvJzcjOd5C/aO7ub2TQY0=
Received: from AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17)
 by AM0PR05MB4883.eurprd05.prod.outlook.com (2603:10a6:208:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 08:22:36 +0000
Received: from AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:207:3:cafe::7f) by AM3PR05CA0139.outlook.office365.com
 (2603:10a6:207:3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 08:22:36 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT058.mail.protection.outlook.com (10.152.17.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2856.17 via Frontend Transport; Mon, 30 Mar 2020 08:22:36 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 30 Mar 2020 11:22:35
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 30 Mar 2020 11:22:35 +0300
Received: from [172.27.15.157] (172.27.15.157) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Mon, 30 Mar 2020 11:22:05 +0300
Subject: Re: [PATCH] nvmet-rdma: Fix double free of rdma queue
To: Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1585477302-4307-1-git-send-email-israelr@mellanox.com>
 <39a9e27b-51fa-6c87-8e5f-17f4f7318bd0@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <05c7907c-9c43-2a2b-c760-bff0364892d9@mellanox.com>
Date: Mon, 30 Mar 2020 11:22:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <39a9e27b-51fa-6c87-8e5f-17f4f7318bd0@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.15.157]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; CTRY:IL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mtlcas13.mtl.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966005)(5660300002)(70586007)(70206006)(336012)(2616005)(2906002)(26005)(16576012)(16526019)(316002)(8936002)(186003)(110136005)(31686004)(36906005)(8676002)(478600001)(36756003)(6666004)(356004)(81156014)(81166006)(82740400003)(4326008)(53546011)(47076004)(86362001)(31696002)(107886003)(3940600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ed57021-43f6-4515-dbab-08d7d4838101
X-MS-TrafficTypeDiagnostic: AM0PR05MB4883:
X-Microsoft-Antispam-PRVS: <AM0PR05MB488337BFB3DB8A29BF0E5F60B6CB0@AM0PR05MB4883.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1awWdI7y869kZUDV3mlXyKr3UuK1Q1LTWQJTawKp823V0ttyirMP2+mknxdgp2V/NXKLpdV7rneBkXCKU61QrowRECWDZ1Y7HAlGtGmCJ7hTUUjEKiXGOnn4GVRR8apj1Ijn/xrsTyNtRhFJTJCIRAiuu5el7BuIbaQZ/+ymR4e8YwcdPustDyPnhCjeP83oLxZrigB0zIBKxOhi3LS2EfcF3KkehoTrK4JoP+rUcA8OFDjyqC9qMetiE2xY2BtHGwbwBTLY7mlsAjL2IbHC6HeDryDUhJwDSE30BTEoGd38CSFgywUY0854JnYIgIHojZHi/3hsEWHhjr3WFgqASGtYo8U9foyalwCpxYN6FgJKJUnTNwiRpk8FmVwPRf2ax3I8w0OicKAFadmDD4Ab41IOrgrpGAMkJ5c0fkdMnUp90l7XV4OkJQpUndWbchyWlDbdWXujnSohp+ASulrQ0yre+Oh7jihraXgHF5PL7ovTn8IgPb5XyeiC56NQZwkRuObxWPApHJmT9YLsQoKs9zy829pkiG8y3r1e93z5YCE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 08:22:36.3869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed57021-43f6-4515-dbab-08d7d4838101
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4883
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_012245_618469_FABCC341 
X-CRM114-Status: GOOD (  15.53  )
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

Ck9uIDMvMzAvMjAyMCA3OjM2IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IEluIGNhc2Ug
cmRtYSBhY2NlcHQgZmFpbHMgYXQgbnZtZXRfcmRtYV9xdWV1ZV9jb25uZWN0KCkgcmVsZWFzZSB3
b3JrIGlzCj4+IHNjaGVkdWxlZC4gTGF0ZXIgb24sIGEgbmV3IFJETUEgQ00gZXZlbnQgbWF5IGFy
cml2ZSBzaW5jZSB3ZSBkaWRuJ3QKPj4gZGVzdHJveSB0aGUgY20taWQgYW5kIGNhbGwgbnZtZXRf
cmRtYV9xdWV1ZV9jb25uZWN0X2ZhaWwoKSwgd2hpY2ggCj4+IHNjaGVkdWxlCj4+IGFub3RoZXIg
cmVsZWFzZSB3b3JrLiBUaGlzIHdpbGwgY2F1c2UgY2FsbGluZyBudm1ldF9yZG1hX2ZyZWVfcXVl
dWUgCj4+IHR3aWNlLgo+PiBUbyBmaXggdGhpcyBkb24ndCBzY2hlZHVsZSB0aGUgd29yayBmcm9t
IG52bWV0X3JkbWFfcXVldWVfY29ubmVjdF9mYWlsKCkKPj4gd2hlbiBxdWV1ZV9saXN0IGlzIGVt
cHR5ICh0aGUgcXVldWUgaXMgaW5zZXJ0ZWQgdG8gYSBsaXN0IG9ubHkgYWZ0ZXIKPj4gc3VjY2Vz
c2Z1bCByZG1hIGFjY2VwdCkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IElzcmFlbCBSdWtzaGluIDxp
c3JhZWxyQG1lbGxhbm94LmNvbT4KPj4gUmV2aWV3ZWQtYnk6IE1heCBHdXJ0b3ZveSA8bWF4Z0Bt
ZWxsYW5veC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYyB8IDkg
KysrKystLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYyBiL2Ry
aXZlcnMvbnZtZS90YXJnZXQvcmRtYS5jCj4+IGluZGV4IDM3ZDI2MmEuLjU5MjA5ZTMgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvcmRtYS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZt
ZS90YXJnZXQvcmRtYS5jCj4+IEBAIC0xMzgwLDEzICsxMzgwLDE0IEBAIHN0YXRpYyB2b2lkIAo+
PiBudm1ldF9yZG1hX3F1ZXVlX2Nvbm5lY3RfZmFpbChzdHJ1Y3QgcmRtYV9jbV9pZCAqY21faWQs
Cj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBXQVJOX09OX09OQ0UocXVldWUtPnN0YXRlICE9IE5WTUVU
X1JETUFfUV9DT05ORUNUSU5HKTsKPj4gwqAgK8KgwqDCoCBwcl9lcnIoImZhaWxlZCB0byBjb25u
ZWN0IHF1ZXVlICVkXG4iLCBxdWV1ZS0+aWR4KTsKPj4gKwo+PiDCoMKgwqDCoMKgIG11dGV4X2xv
Y2soJm52bWV0X3JkbWFfcXVldWVfbXV0ZXgpOwo+PiAtwqDCoMKgIGlmICghbGlzdF9lbXB0eSgm
cXVldWUtPnF1ZXVlX2xpc3QpKQo+PiArwqDCoMKgIGlmICghbGlzdF9lbXB0eSgmcXVldWUtPnF1
ZXVlX2xpc3QpKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBsaXN0X2RlbF9pbml0KCZxdWV1ZS0+
cXVldWVfbGlzdCk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzY2hlZHVsZV93b3JrKCZxdWV1ZS0+cmVs
ZWFzZV93b3JrKTsKPgo+IFRoaXMgaGFzIGEgaGlkZGVuIGFzc3VtcHRpb24gdGhhdCB0aGUgY29u
bmVjdCBoYW5kbGVyIGFscmVhZHkKPiBzY2hlZHVsZWQgdGhlIHJlbGVhc2UuCj4KPiBXaHkgZG9u
J3Qgd2Ugc2ltcGx5IG5vdCBxdWV1ZSB0aGUgcmVsZWFzZV93b3JrIGluIHRoZSBhY2NlcHQKPiBm
YWlsdXJlIGFuZCByZXR1cm4gYSBuZWdhdGl2ZSBzdGF0dXMgY29kZSB0byBpbXBsaWNpdGx5IHJl
bW92ZSB0aGUKPiBjbV9pZD8gdGhpcyB3YXkgd2Ugd2lsbCBuZXZlciBzZWUgYW55IGNtIGV2ZW50
cyBhbmQgd2UgZG9uJ3QKPiBuZWVkIHRvIGhhbmRsZSBpdC4KClRoaXMgY2hhbmdlcyB0aGUgZmxv
dyBidXQgSSBndWVzcyB3ZSBjYW4gY2hlY2sgdGhpcyBvdXQuCgpCdXQgc3RpbGwsIHRoaXMgZmxv
dyBjYW4gYmUgY2FsbGVkIGZyb20gMyBkaWZmZXJlbnQgZXZlbnRzIAooUkRNQV9DTV9FVkVOVF9S
RUpFQ1RFRCwgUkRNQV9DTV9FVkVOVF9VTlJFQUNIQUJMRSwgClJETUFfQ01fRVZFTlRfQ09OTkVD
VF9FUlJPUikgc28gSSBwcmVmZXIgdG8gbG9jYXRlIHRoZSBzY2hlZHVsZV93b3JrIAp1bmRlciB0
aGUgImlmIi4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
