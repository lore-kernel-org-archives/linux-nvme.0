Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB50C5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:43:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CEA2236F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X0+kMGjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CEA2236F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9yYV8SS8YO4dA6FQNtXduJZfgal/kQm9BCX+JjBX4Dw=; b=X0+kMGjBVlcncteTbAhk3QOBu
	A3DLUSosA3uAJhIP1Jdo+L2nmceVSsKeJLXTzSN+uMZ577n0Fv65s0gPNNTxjErB4ke/4SVQKKPAA
	Dhwcu6pF5fnnNJLca4qjsjKZlVl9xOTL2yaqERoohImzjajarL/n56KKvFLK7KCdxCAYfTrupUnxm
	+68IrPyAv7dL9KBc53bXbn9hbkMvtU0fRuGl6Cc49/zqd1A4rKdwrKP0o0wEhKpS2c/Q96lqkJT8Y
	tEiSeeE+fDkGsK7ZI1PY+xRTIDWP5l1q1ZvYfxVU7kRS4GugH+zqqPnNIE4bGjsiAyQsVFIBS1Vd0
	kPVbLemHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg14W-00082y-PI; Fri, 20 Nov 2020 07:43:08 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg14S-000815-2B
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:43:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E6A77AB3D;
 Fri, 20 Nov 2020 07:43:02 +0000 (UTC)
Subject: Re: [PATCH 65/78] dm: remove the block_device reference in struct
 mapped_device
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-66-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <310bff8b-dbda-609a-a392-619733b86bd1@suse.de>
Date: Fri, 20 Nov 2020 08:43:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-66-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_024304_410194_5A1ECAE7 
X-CRM114-Status: GOOD (  28.48  )
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMTYvMjAgMzo1NyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gR2V0IHJpZCBv
ZiB0aGUgbG9uZy1sYXN0aW5nIHN0cnVjdCBibG9ja19kZXZpY2UgcmVmZXJlbmNlIGluCj4gc3Ry
dWN0IG1hcHBlZF9kZXZpY2UuICBUaGUgb25seSByZW1haW5pbmcgdXNlciBpcyB0aGUgZnJlZXpl
IGNvZGUsCj4gd2hlcmUgd2UgY2FuIHRyaXZpYWxseSBsb29rIHVwIHRoZSBibG9jayBkZXZpY2Ug
YXQgZnJlZXplIHRpbWUKPiBhbmQgcmVsZWFzZSB0aGUgcmVmZXJlbmNlIGF0IHRoYXcgdGltZS4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0K
PiAgIGRyaXZlcnMvbWQvZG0tY29yZS5oIHwgIDIgLS0KPiAgIGRyaXZlcnMvbWQvZG0uYyAgICAg
IHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9k
bS1jb3JlLmggYi9kcml2ZXJzL21kL2RtLWNvcmUuaAo+IGluZGV4IGQ1MjIwOTNjYjM5ZGRhLi5i
MWI0MDBlZDc2ZmU5MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL21kL2RtLWNvcmUuaAo+ICsrKyBi
L2RyaXZlcnMvbWQvZG0tY29yZS5oCj4gQEAgLTEwNyw4ICsxMDcsNiBAQCBzdHJ1Y3QgbWFwcGVk
X2RldmljZSB7Cj4gICAJLyoga29iamVjdCBhbmQgY29tcGxldGlvbiAqLwo+ICAgCXN0cnVjdCBk
bV9rb2JqZWN0X2hvbGRlciBrb2JqX2hvbGRlcjsKPiAgIAo+IC0Jc3RydWN0IGJsb2NrX2Rldmlj
ZSAqYmRldjsKPiAtCj4gICAJc3RydWN0IGRtX3N0YXRzIHN0YXRzOwo+ICAgCj4gICAJLyogZm9y
IGJsay1tcSByZXF1ZXN0LWJhc2VkIERNIHN1cHBvcnQgKi8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tZC9kbS5jIGIvZHJpdmVycy9tZC9kbS5jCj4gaW5kZXggNmQ3ZWI3MmQ0MWY5ZWEuLmM3ODlm
ZmVhMmJhZGRlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbWQvZG0uYwo+ICsrKyBiL2RyaXZlcnMv
bWQvZG0uYwo+IEBAIC0xNzQ0LDExICsxNzQ0LDYgQEAgc3RhdGljIHZvaWQgY2xlYW51cF9tYXBw
ZWRfZGV2aWNlKHN0cnVjdCBtYXBwZWRfZGV2aWNlICptZCkKPiAgIAo+ICAgCWNsZWFudXBfc3Jj
dV9zdHJ1Y3QoJm1kLT5pb19iYXJyaWVyKTsKPiAgIAo+IC0JaWYgKG1kLT5iZGV2KSB7Cj4gLQkJ
YmRwdXQobWQtPmJkZXYpOwo+IC0JCW1kLT5iZGV2ID0gTlVMTDsKPiAtCX0KPiAtCj4gICAJbXV0
ZXhfZGVzdHJveSgmbWQtPnN1c3BlbmRfbG9jayk7Cj4gICAJbXV0ZXhfZGVzdHJveSgmbWQtPnR5
cGVfbG9jayk7Cj4gICAJbXV0ZXhfZGVzdHJveSgmbWQtPnRhYmxlX2RldmljZXNfbG9jayk7Cj4g
QEAgLTE4NDAsMTAgKzE4MzUsNiBAQCBzdGF0aWMgc3RydWN0IG1hcHBlZF9kZXZpY2UgKmFsbG9j
X2RldihpbnQgbWlub3IpCj4gICAJaWYgKCFtZC0+d3EpCj4gICAJCWdvdG8gYmFkOwo+ICAgCj4g
LQltZC0+YmRldiA9IGJkZ2V0X2Rpc2sobWQtPmRpc2ssIDApOwo+IC0JaWYgKCFtZC0+YmRldikK
PiAtCQlnb3RvIGJhZDsKPiAtCj4gICAJZG1fc3RhdHNfaW5pdCgmbWQtPnN0YXRzKTsKPiAgIAo+
ICAgCS8qIFBvcHVsYXRlIHRoZSBtYXBwaW5nLCBub2JvZHkga25vd3Mgd2UgZXhpc3QgeWV0ICov
Cj4gQEAgLTIzODQsMTIgKzIzNzUsMTcgQEAgc3RydWN0IGRtX3RhYmxlICpkbV9zd2FwX3RhYmxl
KHN0cnVjdCBtYXBwZWRfZGV2aWNlICptZCwgc3RydWN0IGRtX3RhYmxlICp0YWJsZSkKPiAgICAq
Lwo+ICAgc3RhdGljIGludCBsb2NrX2ZzKHN0cnVjdCBtYXBwZWRfZGV2aWNlICptZCkKPiAgIHsK
PiArCXN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXY7Cj4gICAJaW50IHI7Cj4gICAKPiAgIAlXQVJO
X09OKG1kLT5mcm96ZW5fc2IpOwo+ICAgCj4gLQltZC0+ZnJvemVuX3NiID0gZnJlZXplX2JkZXYo
bWQtPmJkZXYpOwo+ICsJYmRldiA9IGJkZ2V0X2Rpc2sobWQtPmRpc2ssIDApOwo+ICsJaWYgKCFi
ZGV2KQo+ICsJCXJldHVybiAtRU5PTUVNOwo+ICsJbWQtPmZyb3plbl9zYiA9IGZyZWV6ZV9iZGV2
KGJkZXYpOwo+ICAgCWlmIChJU19FUlIobWQtPmZyb3plbl9zYikpIHsKPiArCQliZHB1dChiZGV2
KTsKPiAgIAkJciA9IFBUUl9FUlIobWQtPmZyb3plbl9zYik7Cj4gICAJCW1kLT5mcm96ZW5fc2Ig
PSBOVUxMOwo+ICAgCQlyZXR1cm4gcjsKPiBAQCAtMjQwMiwxMCArMjM5OCwxNCBAQCBzdGF0aWMg
aW50IGxvY2tfZnMoc3RydWN0IG1hcHBlZF9kZXZpY2UgKm1kKQo+ICAgCj4gICBzdGF0aWMgdm9p
ZCB1bmxvY2tfZnMoc3RydWN0IG1hcHBlZF9kZXZpY2UgKm1kKQo+ICAgewo+ICsJc3RydWN0IGJs
b2NrX2RldmljZSAqYmRldjsKPiArCj4gICAJaWYgKCF0ZXN0X2JpdChETUZfRlJPWkVOLCAmbWQt
PmZsYWdzKSkKPiAgIAkJcmV0dXJuOwo+ICAgCj4gLQl0aGF3X2JkZXYobWQtPmJkZXYsIG1kLT5m
cm96ZW5fc2IpOwo+ICsJYmRldiA9IG1kLT5mcm96ZW5fc2ItPnNfYmRldjsKPiArCXRoYXdfYmRl
dihiZGV2LCBtZC0+ZnJvemVuX3NiKTsKPiArCWJkcHV0KGJkZXYpOwo+ICAgCW1kLT5mcm96ZW5f
c2IgPSBOVUxMOwo+ICAgCWNsZWFyX2JpdChETUZfRlJPWkVOLCAmbWQtPmZsYWdzKTsKPiAgIH0K
PiAKWWF5LiBKdXN0IHdoYXQgSSBuZWVkIGZvciB0aGUgYmxrLWludGVycG9zZXIgY29kZSwgd2hl
cmUgdGhlIC0+YmRldgpwb2ludGVyIGlzIHJlYWxseSBnZXR0aW5nIGluIHRoZSB3YXkuCgpSZXZp
ZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMK
LS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJj
aGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEg
NzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVy
OiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
