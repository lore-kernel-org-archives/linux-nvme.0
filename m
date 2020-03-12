Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F20EC2BB1D
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 12:54:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746E2206E7
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 12:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xc6X0dho";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DyQFFFGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746E2206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hLHP62GkEBBB/kzGImgV5+CirpcQvtXs/kNApjmjMNM=; b=Xc6X0dho8cx81/Db3BIl8vAGX
	WQsA0WTBCXGCpesYe1WeqOr+sqHWeZFBWyeTJFDMFdsFO5T8Cf+jYghdNOXWGKHztLFsAgXFbVvh/
	kfc79P5/w/alCAvWf8VqBjAoqQiT4I512leWpAoOYNlVd8c4fOI826g0fPyeUIKhSpgtlItuWW4iT
	WaumuBKDnadaTsoRwNdxcsNC4WM0MrKIXIGzkuOtWj4g6Ag8FpWE+2KqA6alGx0xnQyWdgqheE+zJ
	XoCJlj7PjxA/ntQImqKpdYNQDpZyyNxx4XZhI3zecpbuS0uBZ415lATvcwqVleDyN0pbbNscV0e8+
	Q5JE+AkZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCNLd-0001EU-JO; Thu, 12 Mar 2020 12:54:01 +0000
Received: from mail-db8eur05on2040.outbound.protection.outlook.com
 ([40.107.20.40] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCNLa-0001DX-Kp
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 12:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKwyfj7OYXxy0/bt7eXqG7RXP02PmMtzu6n80+4uaO0x47IY+oY3RbOV8bA1Qd74O5t+0nSHiCYkM2wnj4sSnUWtz7XR/ibAccKAXKvB7C/gVtFbc9W0cBbJ91vRYk4gaT5rIXmZaphylKQZLZnNCLusA1ce9fYciK5v0Hv1rgQ6AqxCtzE/zvUYMPPMjrCX8WF+HquGv81T8x06szAWBES/L43JmXrRs1ZQgDu1aYn5uB7vrb/iF3pOJEQy7BsEDNIZVOQWqEWIyqgyctRqh9fqgmHFnUj2ZkwL/23jvGvzt9BADsutN5CFzpEFowHmykRCEvg+4SkJlmtb4YAN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRAUR3tOvh9F7dvbI5w5KXuM8LU2mKLywqINnrAISz4=;
 b=J8wFCK6ssJ1eHzCQTcGwLod+72eN8gzCLsmlyTOJhpJuJuJWuVwek456JIl8BK91gCEsorpYZ2GwgNf1jQWPyffQxo59oO6gEGNRmk4cKcEwLBMhwwAX4U2K/uWJyBh7Umo7diIHKQ4nTUoHSaoHLDYPv/QWwI44MrxY+bTeFrWZHFal7gCSFy2WG7ZnXiHXyERcGGg/+t0Tu+v9vkg4wcEZRkm2e3yk86ppxKGI4qMFy8Ie/MdV3NDJ/TsHEGq8Elk77YJgtpcX0wUPjCxGfJzNtdq57zrCq7azODDxbC+GNcK454EphhUnI02x/voMJ3aqyu409ijEaJeTIOo+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRAUR3tOvh9F7dvbI5w5KXuM8LU2mKLywqINnrAISz4=;
 b=DyQFFFGUEZ09MlDC1PPFpthm1jg+/4xUHdNxOnYUyQi6RbE856j70Q4dwsoGjLPyTk1pb+KaX2WhAjSnoOE/yH54T171k5w1gY2VoSKb9mz+q8fFvlFTxoVlvrd5Fa4NScZuY5dH2ul++E0/azZdu56xr+npEvbey67ZcW8FyCY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=israelr@mellanox.com; 
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com (52.133.45.151) by
 AM0PR0502MB3841.eurprd05.prod.outlook.com (52.133.51.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 12:53:55 +0000
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe]) by AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 12:53:55 +0000
Subject: Re: [PATCH 4/4] nvme: Fix controller use after free at create_ctrl
 callback
To: Sagi Grimberg <sagi@grimberg.me>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-5-git-send-email-israelr@mellanox.com>
 <8d294ef5-ca01-4458-441c-b987a173d39c@grimberg.me>
From: Israel Rukshin <israelr@mellanox.com>
Message-ID: <e12ed56f-6bfe-dcee-9967-f6f58f06a9f0@mellanox.com>
Date: Thu, 12 Mar 2020 14:53:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <8d294ef5-ca01-4458-441c-b987a173d39c@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0065.eurprd03.prod.outlook.com
 (2603:10a6:207:5::23) To AM0PR0502MB3905.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.223.3.91] (193.47.165.251) by
 AM3PR03CA0065.eurprd03.prod.outlook.com (2603:10a6:207:5::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Thu, 12 Mar 2020 12:53:54 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bb566361-27b3-4053-f9d4-08d7c6846c5d
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3841:|AM0PR0502MB3841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB3841BC91C4D3815EDED16C6BD7FD0@AM0PR0502MB3841.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(4744005)(16576012)(316002)(2906002)(956004)(26005)(36756003)(186003)(6666004)(2616005)(16526019)(86362001)(4326008)(31696002)(107886003)(52116002)(6486002)(110136005)(8676002)(478600001)(8936002)(5660300002)(31686004)(81156014)(81166006)(66476007)(53546011)(66946007)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0502MB3841;
 H:AM0PR0502MB3905.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8X6xkGPgVXLNvlGBKi9rDqsScWvv9O5rqXj9lnlIenb5Drf48nh+QIafEuJkSa+vWFrIOkR1fleSRCGtARhcZw3lfuRP5SrLfONjJXk0/40Xc8zBQI0zgHuuzB9zx7kLqsBaLeF5rCm9ia9QhxHDeUi8YufJaGsXqTbjoyRKGUQhZBBaGjf0cX0qc2WOUsbpBeU8a1JfS4p3ePZ7nYUIvJpM9aSZ+04c7qgkGJvZhmVYqrzxyycFrvSgRbvHFD0hlXRUxdc+wvc3s6IjXes8hj4UxzcIcLhzr6z4OovQl/br8ONypKilREOLTvzHXCNdClNLoKBx7Sq4wmePTEKxsw7jwL8XCEWtikCDmg6GliFsTN+V6Mg4LM/Xpc0kZwGWGfFPyO0rcTkMP+cw0DqTmESF7wNhAYqyukBsg/xG6bYQ+5/05JqfRKWQz2DjitbM
X-MS-Exchange-AntiSpam-MessageData: 2X8Dbwk82ZSY4Gk3izIjrYT5h4zkZoeM1FwGinNn9vdkvsqSKeazlWnwzQgj5nh/2zj3jFkmvTLLFFD89XQ9b/9FU1sQFddmmGTgq6XN9irjCDHiSEE3EOCRERFSkTmv1idJdThlM303CUj92E9cZQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb566361-27b3-4053-f9d4-08d7c6846c5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 12:53:55.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tN8SmxzvkmSRbH0Y4gF0YqI94GxnswNtQIGEAHSsyUh3ZfbWOI36U5qB/rzj7sX81KR+U7Kt7YJLbvRrb3yz+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3841
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_055358_748852_ECCA61EF 
X-CRM114-Status: GOOD (  10.85  )
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

T24gMy8xMi8yMDIwIDg6NDUgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+
PiBpbmRleCBjMGQ5YjE5Li43OTc2OTU1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+IEBAIC0zMjI0LDYg
KzMyMjQsMTAgQEAgc3RhdGljIHNzaXplX3QgbnZtZV9zeXNmc19kZWxldGUoc3RydWN0IGRldmlj
ZSAKPj4gKmRldiwKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2N0cmwgKmN0cmwg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKPj4gwqAgK8KgwqDCoCAvKiBDYW4ndCBkZWxldGUgbm9u
LWNyZWF0ZWQgY29udHJvbGxlcnMgKi8KPj4gK8KgwqDCoCBpZiAoIWN0cmwtPmNyZWF0ZWQpCj4+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVCVVNZOwo+PiArCj4KPiBOb3QgaWRlYWwgdGhhdCBj
b3JlIGNoZWNrcyBhdHRyaWJ1dGUgdGhhdCBmYWJyaWNzIGlzIHNldHRpbmcuIE1heWJlCj4gbW92
ZSB0aGlzIHRvIG52bWVfc3RhcnRfY3RybD8KCkkgY2FuJ3QgbW92ZSB0aGlzIHRvIG52bWVfc3Rh
cnRfY3RybCgpLCBiZWNhdXNlIHJkbWEvdGNwIGhhdmUgbm90IHRha2VuIApjdHJsIHJlZmNvdW50
IHlldC4KCkJlc2lkZSB0aGF0LCBudm1lX3N5c2ZzX2RlbGV0ZSBmdW5jdGlvbiBpcyBvbmx5IHVz
ZWQgYnkgZmFicmljcyBtb2R1bGVzLgoKUENJIG1vZHVsZSBkb2Vzbid0IHNldCBkZWxldGVfY3Ry
bCBvcHMuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
