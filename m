Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E366FC4321E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 01:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kCr6jQ/o4pj6slLicx/jbpl10wejo1jlS/P2Z03iMWs=; b=IboE6fd6Y9s8gQRS8nVezyc3Mq
	f4sJH/AVZIy97aJPmQE0mUKEfQkf7cnyUOKtH7IBVEcu1/w98AXSYyD4LW7sZZFAkIbQVc+DvOP3a
	CT4mqSf4RKsvnoTeeC9NY3oACdlKxccpYhCABnvzGXTv4U0Lb5txj0X5HNOmCK4WrmA9iptI+0CSL
	NBPE1awavNlpw6j97P5IkidUF0AmZe88rA5p0pB5E8PudRZGuWkehLytU0b7Wx2Cu/jCf6ucHuzMg
	y70DjaX7rSe6OBWBfsTeJPVHgj7jkjpaKsCefbY73AmrU64dPbH6gFP7aCdZPY7gC2j9xMgZoA+yi
	KDkwvqGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0YpS-003r6U-TS; Thu, 01 Dec 2022 01:57:34 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0YpO-003r5i-R5
	for linux-nvme@lists.infradead.org; Thu, 01 Dec 2022 01:57:32 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NMzhR5WkWzHwG5;
	Thu,  1 Dec 2022 09:56:39 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 09:57:21 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 09:57:21 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2375.031;
 Thu, 1 Dec 2022 09:57:21 +0800
From: zhangqilong <zhangqilong3@huawei.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBudm1lOiBmaXggbWVtbGVhayBpbiBudm1lX2N0?=
 =?gb2312?B?cmxfZGhjaGFwX3NlY3JldF9zdG9yZSgp?=
Thread-Topic: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Thread-Index: AQHZA880MubT0IyEkkOUkDfMlmitrq5VYp4AgAE9sICAAFOdgIABVArQ
Date: Thu, 1 Dec 2022 01:57:21 +0000
Message-ID: <83d0a39dc2504639a640bb8ee4875e48@huawei.com>
References: <20221122044929.27600-1-zhangqilong3@huawei.com>
	<20221129084725.GB26082@lst.de> <20221129134042.GB13668@lst.de>
	<ea20a977-e0c1-d9a5-907e-387d312e55bf@grimberg.me>
 <20221130133701.GA4267@lst.de>
In-Reply-To: <20221130133701.GA4267@lst.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.246]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_175731_061910_A19B0073 
X-CRM114-Status: UNSURE (   7.76  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiBPbiBXZWQsIE5vdiAzMCwgMjAyMiBhdCAxMDozNzo0NUFNICswMjAwLCBTYWdpIEdyaW1iZXJn
IHdyb3RlOg0KPiA+IFRoaXMgaXMgZml4ZWQgaW4gNi4yIHdpdGggc29tZSBvZiBteSBwYXRjaGVz
Lg0KPiANCj4gQW5kIHRoaXMgdmVyc2lvbiBjb25mbGljdHMgd2l0aCB0aGF0Lg0KPiANCj4gWmhh
bmcsIGNhbiB5b3UgcGxlYXNlIHJlc2VuZCBhIGZ1bGx5IHRlc3RlZCB2ZXJzaW9uIGFnYWluc3Qg
dGhlDQo+IG52bWUtNi4yIGJyYW5jaD8gIFRoYW5rcyENCg0KSXQgaXMgbXkgcGxlYXN1cmUgdG8g
ZG8gdGhhdC4NCkkgd2lsbCBzZW5kIGEgdGVzdGVkIHZlcnNpb24gdG8gbnZtZS02LjIgYnJhbmNo
IQ0KDQpUaGFua3MsDQpaaGFuZw0K

