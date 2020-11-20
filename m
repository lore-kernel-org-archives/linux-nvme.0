Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA45C5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:22:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4BA2158C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DSoqFllF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4BA2158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uTFEAsCxj88FCn/MeOhKYGtvI/fL9GNqVeFvj2ZjXcQ=; b=DSoqFllFR0YDahsShNdnAuZ0I
	CaSIinyY0fumHZ1oU35JWYYQDIi6btq07OdPOpIVEzMDnEKAusvfpdce0pZTfbKU8MaJD5eKPMUhT
	4gkykkMK52CUtaCS66Dd+ZWSgzpshgZhwgvMw3DdUbwr728h8DaubiXzAe7paim8K4HxaRRqHd8sv
	dJMXWagnzSNuO3NhjJ67VaN+Amez4MePOLsOC6zEBXSTf8FRvXefIcXT7CN0eES/cxqy+d12w3QA9
	gNVxNX5J1rIP3la0/6jbIpV1WvVK2XX5l0AKQhd7K8GoQuMNi+FZcEFXTbzvGNpJ7zML8TuUYyO5Q
	+UXUTeVZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg0ku-0002eB-LO; Fri, 20 Nov 2020 07:22:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg0kr-0002Iu-QF
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:22:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 95218AC0C;
 Fri, 20 Nov 2020 07:20:47 +0000 (UTC)
Subject: Re: [PATCH 32/78] block: remove set_device_ro
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-33-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d1beca65-cd8e-57ff-e7d7-6347cb6344b4@suse.de>
Date: Fri, 20 Nov 2020 08:20:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-33-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_022250_016551_DDF207CA 
X-CRM114-Status: GOOD (  24.13  )
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

T24gMTEvMTYvMjAgMzo1NyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gRm9sZCBzZXRf
ZGV2aWNlX3JvIGludG8gaXRzIG9ubHkgcmVtYWluaW5nIGNhbGxlci4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0KPiAgIGJsb2NrL2dlbmhk
LmMgICAgICAgICB8IDcgLS0tLS0tLQo+ICAgYmxvY2svaW9jdGwuYyAgICAgICAgIHwgMiArLQo+
ICAgaW5jbHVkZS9saW51eC9nZW5oZC5oIHwgMSAtCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCA5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ibG9jay9nZW5oZC5j
IGIvYmxvY2svZ2VuaGQuYwo+IGluZGV4IDhjMzUwZmVjZmU4YmZlLi5iMGYwYjBjYWM5YWE3ZiAx
MDA2NDQKPiAtLS0gYS9ibG9jay9nZW5oZC5jCj4gKysrIGIvYmxvY2svZ2VuaGQuYwo+IEBAIC0x
ODQzLDEzICsxODQzLDYgQEAgc3RhdGljIHZvaWQgc2V0X2Rpc2tfcm9fdWV2ZW50KHN0cnVjdCBn
ZW5kaXNrICpnZCwgaW50IHJvKQo+ICAgCWtvYmplY3RfdWV2ZW50X2VudigmZGlza190b19kZXYo
Z2QpLT5rb2JqLCBLT0JKX0NIQU5HRSwgZW52cCk7Cj4gICB9Cj4gICAKPiAtdm9pZCBzZXRfZGV2
aWNlX3JvKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGludCBmbGFnKQo+IC17Cj4gLQliZGV2
LT5iZF9wYXJ0LT5wb2xpY3kgPSBmbGFnOwo+IC19Cj4gLQo+IC1FWFBPUlRfU1lNQk9MKHNldF9k
ZXZpY2Vfcm8pOwo+IC0KPiAgIHZvaWQgc2V0X2Rpc2tfcm8oc3RydWN0IGdlbmRpc2sgKmRpc2ss
IGludCBmbGFnKQo+ICAgewo+ICAgCXN0cnVjdCBkaXNrX3BhcnRfaXRlciBwaXRlcjsKPiBkaWZm
IC0tZ2l0IGEvYmxvY2svaW9jdGwuYyBiL2Jsb2NrL2lvY3RsLmMKPiBpbmRleCA5NmNiNDU0NDcz
NjQ2OC4uMDQyNTVkYzVmM2JmZjMgMTAwNjQ0Cj4gLS0tIGEvYmxvY2svaW9jdGwuYwo+ICsrKyBi
L2Jsb2NrL2lvY3RsLmMKPiBAQCAtMzcxLDcgKzM3MSw3IEBAIHN0YXRpYyBpbnQgYmxrZGV2X3Jv
c2V0KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKPiAgIAkJaWYgKHJl
dCkKPiAgIAkJCXJldHVybiByZXQ7Cj4gICAJfQo+IC0Jc2V0X2RldmljZV9ybyhiZGV2LCBuKTsK
PiArCWJkZXYtPmJkX3BhcnQtPnBvbGljeSA9IG47Cj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAK
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9nZW5oZC5oIGIvaW5jbHVkZS9saW51eC9nZW5o
ZC5oCj4gaW5kZXggNGIyMmJmZDkzMzZlMWEuLjg0MjdhZDhiZWY1MjBkIDEwMDY0NAo+IC0tLSBh
L2luY2x1ZGUvbGludXgvZ2VuaGQuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvZ2VuaGQuaAo+IEBA
IC0zMDQsNyArMzA0LDYgQEAgZXh0ZXJuIHZvaWQgZGVsX2dlbmRpc2soc3RydWN0IGdlbmRpc2sg
KmdwKTsKPiAgIGV4dGVybiBzdHJ1Y3QgZ2VuZGlzayAqZ2V0X2dlbmRpc2soZGV2X3QgZGV2LCBp
bnQgKnBhcnRubyk7Cj4gICBleHRlcm4gc3RydWN0IGJsb2NrX2RldmljZSAqYmRnZXRfZGlzayhz
dHJ1Y3QgZ2VuZGlzayAqZGlzaywgaW50IHBhcnRubyk7Cj4gICAKPiAtZXh0ZXJuIHZvaWQgc2V0
X2RldmljZV9ybyhzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBpbnQgZmxhZyk7Cj4gICBleHRl
cm4gdm9pZCBzZXRfZGlza19ybyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgaW50IGZsYWcpOwo+ICAg
Cj4gICBzdGF0aWMgaW5saW5lIGludCBnZXRfZGlza19ybyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaykK
PiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoK
SGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9y
YWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAr
NDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRz
ZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
