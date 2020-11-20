Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016AEC5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:26:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C12D2158C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YLYalBfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C12D2158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rJ10ISukIv3++sljaeFssmMvtiltvivRMRQWFYAGo3g=; b=YLYalBfuBPxpyJRlCu1lNhR/6
	UFqYeWSFURHgMBlLu3cXbsrqhdTDnDgTW9k38AYSmWKhXXmht72kNz+LnSDNV5/+VY26AFww8Tcky
	y0w+xLmz132SByApNzyLUwp6uk1I5VaHL70z94BkiQSeeCYBy4AcsOmFpTYYmCW50k94WYyxlu2Cq
	BgDDT4pkVXFt5Fo74/NReeAQ10+DFhxa9Ss9TOzfYrbOH2K9Zx8NQXjhaD6sbb88vCMl2xX4Nl9CE
	wC3doWPK5N3wdO5n1gGJuPKxx3VCWe65GJ06BYg+ao6DyWY/GonxiN49nzEPlMXWLt76qYgMhFyX6
	Xwz1Xb42w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg0oO-0003aj-LU; Fri, 20 Nov 2020 07:26:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg0oK-0003YW-CB
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:26:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2A51FAB3D;
 Fri, 20 Nov 2020 07:26:23 +0000 (UTC)
Subject: Re: [PATCH 55/78] block: change the hash used for looking up block
 devices
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-56-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <75f4c397-ac03-2c5f-d620-0e619ad78fe8@suse.de>
Date: Fri, 20 Nov 2020 08:26:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-56-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_022624_572153_4303F534 
X-CRM114-Status: GOOD (  25.53  )
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

T24gMTEvMTYvMjAgMzo1NyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gQWRkaW5nIHRo
ZSBtaW5vciB0byB0aGUgbWFqb3IgY3JlYXRlcyB0b25zIG9mIHBvaW50bGVzcyBjb25mbGljdHMu
IEp1c3QKPiB1c2UgdGhlIGRldl90IGl0c2VsZiwgd2hpY2ggaXMgMzItYml0cyBhbmQgdGh1cyBp
cyBndWFyYW50ZWVkIHRvIGZpdAo+IGludG8gaW5vX3QuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4gICBmcy9ibG9ja19kZXYuYyB8IDI2
ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvYmxvY2tfZGV2LmMg
Yi9mcy9ibG9ja19kZXYuYwo+IGluZGV4IGQ4NjY0ZjVjMWZmNjY5Li4yOWRiMTJjM2JiNTAxYyAx
MDA2NDQKPiAtLS0gYS9mcy9ibG9ja19kZXYuYwo+ICsrKyBiL2ZzL2Jsb2NrX2Rldi5jCj4gQEAg
LTg3MCwzNSArODcwLDEyIEBAIHZvaWQgX19pbml0IGJkZXZfY2FjaGVfaW5pdCh2b2lkKQo+ICAg
CWJsb2NrZGV2X3N1cGVyYmxvY2sgPSBiZF9tbnQtPm1udF9zYjsgICAvKiBGb3Igd3JpdGViYWNr
ICovCj4gICB9Cj4gICAKPiAtLyoKPiAtICogTW9zdCBsaWtlbHkgX3ZlcnlfIGJhZCBvbmUgLSBi
dXQgdGhlbiBpdCdzIGhhcmRseSBjcml0aWNhbCBmb3Igc21hbGwKPiAtICogL2RldiBhbmQgY2Fu
IGJlIGZpeGVkIHdoZW4gc29tZWJvZHkgd2lsbCBuZWVkIHJlYWxseSBsYXJnZSBvbmUuCj4gLSAq
IEtlZXAgaW4gbWluZCB0aGF0IGl0IHdpbGwgYmUgZmVkIHRocm91Z2ggaWNhY2hlIGhhc2ggZnVu
Y3Rpb24gdG9vLgo+IC0gKi8KPiAtc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGhhc2goZGV2
X3QgZGV2KQo+IC17Cj4gLQlyZXR1cm4gTUFKT1IoZGV2KStNSU5PUihkZXYpOwo+IC19Cj4gLQo+
IC1zdGF0aWMgaW50IGJkZXZfdGVzdChzdHJ1Y3QgaW5vZGUgKmlub2RlLCB2b2lkICpkYXRhKQo+
IC17Cj4gLQlyZXR1cm4gQkRFVl9JKGlub2RlKS0+YmRldi5iZF9kZXYgPT0gKihkZXZfdCAqKWRh
dGE7Cj4gLX0KPiAtCj4gLXN0YXRpYyBpbnQgYmRldl9zZXQoc3RydWN0IGlub2RlICppbm9kZSwg
dm9pZCAqZGF0YSkKPiAtewo+IC0JQkRFVl9JKGlub2RlKS0+YmRldi5iZF9kZXYgPSAqKGRldl90
ICopZGF0YTsKPiAtCXJldHVybiAwOwo+IC19Cj4gLQo+ICAgc3RhdGljIHN0cnVjdCBibG9ja19k
ZXZpY2UgKmJkZ2V0KGRldl90IGRldikKPiAgIHsKPiAgIAlzdHJ1Y3QgYmxvY2tfZGV2aWNlICpi
ZGV2Owo+ICAgCXN0cnVjdCBpbm9kZSAqaW5vZGU7Cj4gICAKPiAtCWlub2RlID0gaWdldDVfbG9j
a2VkKGJsb2NrZGV2X3N1cGVyYmxvY2ssIGhhc2goZGV2KSwKPiAtCQkJYmRldl90ZXN0LCBiZGV2
X3NldCwgJmRldik7Cj4gLQo+ICsJaW5vZGUgPSBpZ2V0X2xvY2tlZChibG9ja2Rldl9zdXBlcmJs
b2NrLCBkZXYpOwo+ICAgCWlmICghaW5vZGUpCj4gICAJCXJldHVybiBOVUxMOwo+ICAgCj4gQEAg
LTkxMCw2ICs4ODcsNyBAQCBzdGF0aWMgc3RydWN0IGJsb2NrX2RldmljZSAqYmRnZXQoZGV2X3Qg
ZGV2KQo+ICAgCQliZGV2LT5iZF9zdXBlciA9IE5VTEw7Cj4gICAJCWJkZXYtPmJkX2lub2RlID0g
aW5vZGU7Cj4gICAJCWJkZXYtPmJkX3BhcnRfY291bnQgPSAwOwo+ICsJCWJkZXYtPmJkX2RldiA9
IGRldjsKPiAgIAkJaW5vZGUtPmlfbW9kZSA9IFNfSUZCTEs7Cj4gICAJCWlub2RlLT5pX3JkZXYg
PSBkZXY7Cj4gICAJCWlub2RlLT5pX2JkZXYgPSBiZGV2Owo+IApSZXZpZXdlZC1ieTogSGFubmVz
IFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3Vz
ZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpI
UkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2
cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
