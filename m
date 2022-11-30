Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF12C352A1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 03:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZkioBzthWQRlwMo47mlNT1UU1qZMGZQYI+HZUl5Gq0=; b=Gj8TAk94k6mVq07hCO2ictxbDp
	L3pz2NAdF9ztJ8sTOCtE6svU901o+/2k01fqDe4O0kydXvkUNKjEisydV+9Oxbgao2zvcfUwoFpGt
	g47A1+gQr1jS9mXED21r/NrINciP5mzfmybSUq23FbBqxTxONS3SvhHYqo8/GUiy4pGqwYkxGOZv1
	ngWUkwqU24znqOMWTxdYHhjgkysFtitTxgUFV6bz3UXvAa54VKGkIBh/7+h0snn5K9I5PWvfdYzzc
	CHhj4clPBR9FuKxg7f3ZZTefJDOVOmmBwx9Ia6LkYbs272iKTG1ojR5tNTmhwixzSvNlrQg+aPnln
	MZB5Hz0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0E6P-00Cif9-Ua; Wed, 30 Nov 2022 03:49:41 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0E6M-00CiaC-UZ
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 03:49:40 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NMQDM1BBmz15MxG;
	Wed, 30 Nov 2022 11:48:51 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 11:49:30 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 11:49:30 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2375.031;
 Wed, 30 Nov 2022 11:49:30 +0800
From: zhangqilong <zhangqilong3@huawei.com>
To: Christoph Hellwig <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBudm1lOiBmaXggbWVtbGVhayBpbiBudm1lX2N0?=
 =?gb2312?B?cmxfZGhjaGFwX3NlY3JldF9zdG9yZSgp?=
Thread-Topic: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Thread-Index: AQHZA880MubT0IyEkkOUkDfMlmitrq5VYp4AgAFxnGA=
Date: Wed, 30 Nov 2022 03:49:30 +0000
Message-ID: <9d0aed3289e04b139cdb9dcd73ce8939@huawei.com>
References: <20221122044929.27600-1-zhangqilong3@huawei.com>
	<20221129084725.GB26082@lst.de> <20221129134042.GB13668@lst.de>
In-Reply-To: <20221129134042.GB13668@lst.de>
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
X-CRM114-CacheID: sfid-20221129_194939_170178_A2878D15 
X-CRM114-Status: GOOD (  11.62  )
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

PiANCj4gT24gVHVlLCBOb3YgMjksIDIwMjIgYXQgMDk6NDc6MjVBTSArMDEwMCwgQ2hyaXN0b3Bo
IEhlbGx3aWcgd3JvdGU6DQo+ID4gVGhhbmtzLA0KPiA+DQo+ID4gYXBwbGllZCB0byBudm1lLTYu
MS4NCj4gDQo+IEFuZCBJIGhhZCB0byBmaXggaXQgdG8gYWN0dWFsbHkgcGFzcyBhbGwgdGhlIGNv
cnJlY3QgcGFyYW10ZXJzIHRvIGttZW1kdXAsIHNvIGl0DQo+IGxvb2tzIGxpa2UgdGhpcyBjb2Rl
IHdhc24ndCBldmVuIGNvbXBpbGUgdGVzdC4NCj4gDQpPaCwgDQoNCiAgICAgSXQgc2VlbXMgdGhh
dCBJIGZvcmdldCB0byBkbyBpdCBmb3IgVjIgdmVyc2lvbi4gSSBhbSBzb3JyeSB0byBpdCwgSXQg
aXMgc28gbmljZSB0aGF0IHlvdSBmaXggaXQuDQoNCj4gQnR3LCBob3cgY2FuIG52bWVfY3RybF9k
aGNoYXBfc2VjcmV0X3N0b3JlIHdvcmsgd2l0aG91dCBhbnkga2luZCBvZg0KPiBsb2NraW5nPw0K
DQpZb3UgbWVhbnMgaXQgc2hvdWxkIG5lZWQgYSBsb2NrIHRvIGF2b2lkIHJhY2UgY29uZGl0aW9u
Pw0KDQpUaGFua3MhDQo=

