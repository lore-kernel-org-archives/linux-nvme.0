Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594FCC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 06:30:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2633D2076C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 06:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CTHxnW8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2633D2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1TSVfTGwjblQg19xuVzF2Eyi7542dGI++1lxDB6foyI=; b=CTHxnW8DK7T73yjcJLbA/mWSm
	QGuBAwqrUqqI7TWc8THpbp0bklHppB2VtE260By1SHHmLQph9EAjinwNr11VIq2fmzSbY/NGng5dS
	HjXsy/tepEMH/rhyHsQr7l2jt8qk5tsTJ74NKH70fTQO4v1aSQJd69GEHZIyqP9fZg0/S3mSrSsz+
	hkruw8Hpv+qL6SfkyySaLMBNKUr8bdz/k/VOF/3rKs31lZnJmws8hEatolb5xZFbk8yHb9q0jDuRg
	z2ID63IMtmjjGn0BjgkuQEU2dOmWQ12mdnChGD4xyY5i/lsfj7Rh0e4d8UwiDucuYauOKvjB6W7ha
	78q259hjw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAowd-0002JI-68; Wed, 26 Aug 2020 06:30:03 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAowZ-0002Hz-UV
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 06:30:01 +0000
Received: from dggeme712-chm.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 05BBAEF2832354DF625B;
 Wed, 26 Aug 2020 14:29:53 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggeme712-chm.china.huawei.com (10.1.199.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 26 Aug 2020 14:29:52 +0800
Received: from dggeme759-chm.china.huawei.com ([10.7.64.73]) by
 dggeme759-chm.china.huawei.com ([10.7.64.73]) with mapi id 15.01.1913.007;
 Wed, 26 Aug 2020 14:29:52 +0800
From: "tiantao (H)" <tiantao6@hisilicon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBudm1lOiBVc2Uga29ial90b19kZXYoKSBpbnN0ZWFk?=
 =?gb2312?Q?_of_container=5Fof()?=
Thread-Topic: [PATCH] nvme: Use kobj_to_dev() instead of container_of()
Thread-Index: AQHWe0eCwoyiONFn50+PHuXy3Xp7YqlJWzSAgACQJzA=
Date: Wed, 26 Aug 2020 06:29:52 +0000
Message-ID: <e0c1fc5cbbeb4bb4985f86c3f648df5b@hisilicon.com>
References: <1598404848-37313-1-git-send-email-tiantao6@hisilicon.com>
 <20200826054417.GA15738@lst.de>
In-Reply-To: <20200826054417.GA15738@lst.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.60.129]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200826_023000_738609_DEDE84D5 
X-CRM114-Status: UNSURE (   6.28  )
X-CRM114-Notice: Please train this message.
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RG9lc24ndCByZWFsbHkgbWF0dGVyIGZvciBhbiBpbmRpdmlkdWFsIGRyaXZlciwgYnV0IGl0IG1h
eSBnZXQgY29wcGllZCB0byBsb3RzIG1vcmUuIA0KSSBjb25zaWRlciBpdCdzIGEgbGl0dGxlIHRp
ZHkgdXAuIA0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogQ2hyaXN0b3BoIEhlbGx3aWcg
W21haWx0bzpoY2hAbHN0LmRlXSANCreiy83KsbzkOiAyMDIwxOo41MIyNsjVIDEzOjQ0DQrK1bz+
yMs6IHRpYW50YW8gKEgpIDx0aWFudGFvNkBoaXNpbGljb24uY29tPg0Ks63LzToga2J1c2NoQGtl
cm5lbC5vcmc7IGF4Ym9lQGZiLmNvbTsgaGNoQGxzdC5kZTsgc2FnaUBncmltYmVyZy5tZTsgbGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNv
bT4NCtb3zOI6IFJlOiBbUEFUQ0hdIG52bWU6IFVzZSBrb2JqX3RvX2RldigpIGluc3RlYWQgb2Yg
Y29udGFpbmVyX29mKCkNCg0KT24gV2VkLCBBdWcgMjYsIDIwMjAgYXQgMDk6MjA6NDhBTSArMDgw
MCwgVGlhbiBUYW8gd3JvdGU6DQo+IFVzZSBrb2JqX3RvX2RldigpIGluc3RlYWQgb2YgY29udGFp
bmVyX29mKCkNCg0KV2h5Pw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
