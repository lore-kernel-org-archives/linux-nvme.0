Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4D3C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 18:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v6dY8D9STf3u/CN6m660y/L38EFCR50urJq/TxM4SHc=; b=yTM6euR9MNVqBukFocxF1yj+eQ
	iyAVjhSJwBUxhga4BPzFIXD5mlhvjxg9ibm4OJD0LXt9MJREg5qxnBbnMuvsnsPTirUOekNbwk/Ks
	L95VMd8KqNyz4ImBXrStCVr42SUvRh2Q5CBjrkAnjnoXWWytS14nKoyp1pwhbhEvI+mgAaG2y23bY
	5j5kT7McH3hVWt6sLuSvxvrIME6nLFJiuH6PwbyiofwJ2oduIv2CtYp0KluK2AImKOSASx90tTyjq
	VHioMFT3W86vZl13gBL+emwNy+YUMyV34EBSubyNTuIqfXYfMZJOCuvUJEeXcXhpHnZ5LUcIzYOtH
	sQN5B4og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmgME-00HMt5-BG; Thu, 05 May 2022 18:37:46 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmgMC-00HMrz-1e
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 18:37:45 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 11:37:37 -0700
Received: from SJSMAIL01.us.kioxia.com ([fe80::c557:f37d:d981:76df]) by
 SJSMAIL01.us.kioxia.com ([fe80::c557:f37d:d981:76df%3]) with mapi id
 15.01.2375.024; Thu, 5 May 2022 11:37:37 -0700
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "hch@lst.de" <hch@lst.de>
CC: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>, "ming.lei@redhat.com"
 <ming.lei@redhat.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>, "shr@fb.com"
 <shr@fb.com>, "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>, "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: RE: [PATCH v4 3/5] nvme: refactor nvme_submit_user_cmd()
Thread-Topic: [PATCH v4 3/5] nvme: refactor nvme_submit_user_cmd()
Thread-Index: AQHYYEffNsZGDQ8MAEyuOCh/GTUQpa0QnLIA
Date: Thu, 5 May 2022 18:37:36 +0000
Message-ID: <80cde2cfd566454fa4b160492c7336c2@kioxia.com>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061148epcas5p188618b5b15a95cbe48c8c1559a18c994@epcas5p1.samsung.com>
 <20220505060616.803816-4-joshi.k@samsung.com>
In-Reply-To: <20220505060616.803816-4-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_113744_122739_A69CB3A9 
X-CRM114-Status: UNSURE (   9.22  )
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

PiBGcm9tOiBLYW5jaGFuIEpvc2hpDQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDQsIDIwMjIgMTE6
MDYgUE0NCj4gLS0tDQoNCj4gIGRyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMgfCA0NyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0MiBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiArc3RhdGljIGludCBudm1lX2V4ZWN1
dGVfdXNlcl9ycShzdHJ1Y3QgcmVxdWVzdCAqcmVxLCB2b2lkIF9fdXNlcg0KPiAqbWV0YV9idWZm
ZXIsDQo+ICsJCXVuc2lnbmVkIG1ldGFfbGVuLCB1NjQgKnJlc3VsdCkNCj4gK3sNCj4gKwlzdHJ1
Y3QgYmlvICpiaW8gPSByZXEtPmJpbzsNCj4gKwlib29sIHdyaXRlID0gYmlvX29wKGJpbykgPT0g
UkVRX09QX0RSVl9PVVQ7DQoNCkknbSBnZXR0aW5nIGEgTlVMTCBwdHIgYWNjZXNzIG9uIHRoZSBm
aXJzdCBpb2N0bChOVk1FX0lPQ1RMX0FETUlONjRfQ01EKQ0KSSBzZW5kIC0gaXQgaGFzIG5vIHVi
dWZmZXIgc28gSSB0aGluayB0aGVyZSdzIG5vIHJlcS0+YmlvLg0KDQo+ICsJaW50IHJldDsNCj4g
Kwl2b2lkICptZXRhID0gbnZtZV9tZXRhX2Zyb21fYmlvKGJpbyk7DQo+ICsNCj4gIAlyZXQgPSBu
dm1lX2V4ZWN1dGVfcGFzc3RocnVfcnEocmVxKTsNCj4gKw0KPiAgCWlmIChyZXN1bHQpDQo+ICAJ
CSpyZXN1bHQgPSBsZTY0X3RvX2NwdShudm1lX3JlcShyZXEpLT5yZXN1bHQudTY0KTsNCj4gIAlp
ZiAobWV0YSAmJiAhcmV0ICYmICF3cml0ZSkgew0K

