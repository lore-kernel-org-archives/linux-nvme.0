Return-Path: <SRS0=T4Lt=MV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBECC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jul 2021 09:30:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204C961050
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jul 2021 09:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 204C961050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cRFCrhe1J6d7hajmi7J1Cf31prqe2JYyn4zb65C8P9I=; b=jTOSU9xVS6W5Z1
	PISaJ52b4h4zOmu9TwvQpEYiD3tMB/5bCVqCuyNIEi7HLmQLxJ0sizgD7YyEL0JOwpo8njVAKtbng
	WEXJj4/Des8LvFWHZf2stpXsNYftomCCS/Oh5jatdSM57GlE2gI4NhGkcgiS7Dm9i8ry4JPcF+Zmv
	1PEX+5BoX4O1N+O/uxuraGOVjQN3epJ+7aJFBPx3VY6P9PFUIC1UB0mvnIOSdK0fheSpOcQlTUX1y
	2SXph2GWZmBLfwPHFJH8+bB2lmDKDRiFDOITmmrzDGTRb+euHhmS6Uap2hC/ohEz0b5wveN68uCaM
	nDHHW+RJbpYJZjFzyhVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m92MJ-003e8w-9q; Thu, 29 Jul 2021 09:29:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m92MG-003e8I-F4
 for linux-nvme@lists.infradead.org; Thu, 29 Jul 2021 09:29:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627550978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QU04D4AFtIumGhlAE34vrZ8TeIMsBn0CApcJIeHb9PI=;
 b=AsUCZZBK5GcySSFxn6wjkQ8lXRHW6NF3U6mSro4xQ2m2UhOD7QvVv3vMMDb+KH5IgR+KZX
 aEyRIgdiTxqfqD5sze5WGyrygv+oZ6VUIEQBs0dveTYrDbWiysnhaQKf57LjvVkMALyoHe
 VddqGBmyiePWPdTGdIZdw2LWd7MX9HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-_xf3uillNICG3oRRPdDC8A-1; Thu, 29 Jul 2021 05:29:37 -0400
X-MC-Unique: _xf3uillNICG3oRRPdDC8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 022B8801AEB;
 Thu, 29 Jul 2021 09:29:35 +0000 (UTC)
Received: from T590 (ovpn-12-146.pek2.redhat.com [10.72.12.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA16560877;
 Thu, 29 Jul 2021 09:29:24 +0000 (UTC)
Date: Thu, 29 Jul 2021 17:29:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Message-ID: <YQJ09eaGIssStGXt@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <3180854.nXyytZ0Y3r@natalenko.name> <YQF9YRSdRc+eVD1c@T590>
 <4560968.zrxKzTJTGe@natalenko.name> <YQIhfwP2z+DGWOxV@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YQIhfwP2z+DGWOxV@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210729_022940_641778_85DF9B81 
X-CRM114-Status: GOOD (  24.20  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBKdWwgMjksIDIwMjEgYXQgMTE6MzM6MzNBTSArMDgwMCwgTWluZyBMZWkgd3JvdGU6
Cj4gT24gV2VkLCBKdWwgMjgsIDIwMjEgYXQgMDY6Mzg6MzZQTSArMDIwMCwgT2xla3NhbmRyIE5h
dGFsZW5rbyB3cm90ZToKPiA+IEhlbGxvLgo+ID4gCj4gPiBPbiBzdMWZZWRhIDI4LiDEjWVydmVu
Y2UgMjAyMSAxNzo1MzowNSBDRVNUIE1pbmcgTGVpIHdyb3RlOgo+ID4gPiBDYW4geW91IGNvbGxl
Y3QgZGVidWcgbG9nIGJ5IGFwcGx5aW5nIHRoZSBmb2xsb3dpbmcgcGF0Y2ggYWdhaW5zdCB0aGUK
PiA+ID4gbGFzdCBvbmU/Cj4gPiAKPiA+IFllcywgcGxlYXNlIHNlZSBiZWxvdy4KPiA+IAo+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jCj4gPiA+IGluZGV4IDg3ODBlNGFhOWRmMi4uZmJkOGE2OGM2MTliIDEwMDY0NAo+
ID4gPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiA+ID4gKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jCj4gPiA+IEBAIC04MjgsNiArODI4LDI0IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBudm1lX3NldHVwX2ZsdXNoKHN0cnVjdCBudm1lX25zICpucywKPiA+ID4gY21uZC0+Y29t
bW9uLm5zaWQgPSBjcHVfdG9fbGUzMihucy0+aGVhZC0+bnNfaWQpOwo+ID4gPiAgfQo+ID4gPiAK
PiA+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBibGtfZHVtcF9ycShjb25zdCBzdHJ1Y3QgcmVxdWVz
dCAqcmVxKQo+ID4gPiArewo+ID4gPiArCXN0cnVjdCBiaW8gKmJpbzsKPiA+ID4gKwlpbnQgaSA9
IDA7Cj4gPiA+ICsKPiA+ID4gKwlwcmludGsoImR1bXAgcmVxICVwKGY6JXgsIHNlZzogJWQpXG4i
LCByZXEsIHJlcS0+Y21kX2ZsYWdzLAo+ID4gPiArCQkJcmVxLT5ucl9waHlzX3NlZ21lbnRzKTsK
PiA+ID4gKwo+ID4gPiArCV9fcnFfZm9yX2VhY2hfYmlvKGJpbywgcmVxKSB7Cj4gPiA+ICsJCXBy
aW50aygiJWQtJXA6ICVoeC8laHggJWxsdSAldVxuIiwKPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaSsrLCBiaW8sCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJpby0+YmlfZmxh
Z3MsIGJpby0+Ymlfb3BmLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAodW5zaWduZWQg
bG9uZyBsb25nKWJpby0+YmlfaXRlci5iaV9zZWN0b3IsCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGJpby0+YmlfaXRlci5iaV9zaXplPj45KTsKPiA+ID4gKwl9Cj4gPiA+ICt9Cj4gPiA+
ICsKPiA+ID4gKwo+ID4gPiAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX3NldHVwX2Rpc2NhcmQo
c3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1Y3QgcmVxdWVzdAo+ID4gPiAqcmVxLCBzdHJ1Y3QgbnZt
ZV9jb21tYW5kICpjbW5kKQo+ID4gPiAgewo+ID4gPiBAQCAtODY4LDYgKzg4Niw4IEBAIHN0YXRp
YyBibGtfc3RhdHVzX3QgbnZtZV9zZXR1cF9kaXNjYXJkKHN0cnVjdCBudm1lX25zCj4gPiA+ICpu
cywgc3RydWN0IHJlcXVlc3QgKnJlcSwgfQo+ID4gPiAKPiA+ID4gIAlpZiAoV0FSTl9PTl9PTkNF
KG4gIT0gc2VnbWVudHMpKSB7Cj4gPiA+ICsJCXByaW50aygiJXM6IHJhbmdlcyAldSBzZWdtZW50
cyAldVxuIiwgX19mdW5jX18sIG4sIHNlZ21lbnRzKTsKPiA+ID4gKwkJYmxrX2R1bXBfcnEocmVx
KTsKPiA+ID4gIAkJaWYgKHZpcnRfdG9fcGFnZShyYW5nZSkgPT0gbnMtPmN0cmwtPmRpc2NhcmRf
cGFnZSkKPiA+ID4gIAkJCWNsZWFyX2JpdF91bmxvY2soMCwgJm5zLT5jdHJsLT5kaXNjYXJkX3Bh
Z2VfYnVzeSk7Cj4gPiA+ICAJCWVsc2UKPiA+IAo+ID4gYGBgCj4gPiBXQVJOSU5HOiBDUFU6IDE3
IFBJRDogODIxIGF0IGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYzo4NjggbnZtZV9zZXR1cF9kaXNj
YXJkKzB4MWM2LzB4MjIwCj4gPiDigKYKPiA+IENQVTogMTcgUElEOiA4MjEgQ29tbToga3dvcmtl
ci8xNzoxSCBOb3QgdGFpbnRlZCA1LjEzLjAtcGY0ICMxCj4gPiBIYXJkd2FyZSBuYW1lOiBBU1VT
IFN5c3RlbSBQcm9kdWN0IE5hbWUvUHJvIFdTIFg1NzAtQUNFLCBCSU9TIDM2MDEgMDUvMjYvMjAy
MQo+ID4gV29ya3F1ZXVlOiBrYmxvY2tkIGJsa19tcV9ydW5fd29ya19mbgo+ID4gUklQOiAwMDEw
Om52bWVfc2V0dXBfZGlzY2FyZCsweDFjNi8weDIyMAo+ID4gQ29kZTogOGIgYTAgNDAgMGIgMDAg
MDAgNGMgMmIgMjUgZjcgZmYgZDcgMDAgNDkgYzEgZmMgMDYgNDkgYzEgZTQgMGMgNGMgMDMgMjUg
ZjggZmYgZDcgMDAgNGMgODkgZTUgNDggODUgZDIgMGYgODUgOWIgZmUgZmYgZmYgMzEgZDIgPDBm
PiAwYiA0OCBjNyBjNiBlMCBhOCAxMCA4YiA0MSAwZiBiNyBjZCA0OCBjNyBjNyBhZiAwOSA0MCA4
YiBlOCAxNAo+ID4gUlNQOiAwMDE4OmZmZmZhZmE4ODQ1MTdiZjAgRUZMQUdTOiAwMDAxMDI5Nwo+
ID4gUkFYOiBmZmZmOTE2MDJmNWIyMGQwIFJCWDogZmZmZjkxNWUwNTc0M2MwMCBSQ1g6IDAwMDAw
MDAwMDAwODAwMDAKPiA+IFJEWDogMDAwMDAwMDAwMDAwMDAwZiBSU0k6IDAwMDAwMDAwMjg0NDVj
MDAgUkRJOiAwMDAwMDAwMDAwMDAwMDBmCj4gPiBSQlA6IGZmZmY5MTYwMmY1YjIwMDAgUjA4OiAw
MDAwMDAwMDBiMzY2MDAwIFIwOTogZmZmZjkxNjAyZjViMjAwMAo+ID4gUjEwOiAwMDAwMDAwMDAw
MDAwMDJkIFIxMTogZmVmZWZlZmVmZWZlZmVmZiBSMTI6IGZmZmY5MTYwMmY1YjIwMDAKPiA+IFIx
MzogMDAwMDAwMDAwMDAwMDAwZSBSMTQ6IGZmZmY5MTVlMThjNzcwMDAgUjE1OiBmZmZmOTE1ZTE4
Yzc3MTQ4Cj4gPiBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjkxNjUwZWU0MDAw
MCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCj4gPiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4gPiBDUjI6IDAwMDAxYzkwYjM2ODc5YTggQ1Iz
OiAwMDAwMDAwMTBkMThjMDAwIENSNDogMDAwMDAwMDAwMDM1MGVlMAo+ID4gQ2FsbCBUcmFjZToK
PiA+ICBudm1lX3NldHVwX2NtZCsweDJlNC8weDZhMAo+ID4gIG52bWVfcXVldWVfcnErMHg3OS8w
eGM5MAo+ID4gIGJsa19tcV9kaXNwYXRjaF9ycV9saXN0KzB4MTVjLzB4ODEwCj4gPiAgX19ibGtf
bXFfZG9fZGlzcGF0Y2hfc2NoZWQrMHhjYS8weDMyMAo+ID4gIF9fYmxrX21xX3NjaGVkX2Rpc3Bh
dGNoX3JlcXVlc3RzKzB4MTRkLzB4MTkwCj4gPiAgYmxrX21xX3NjaGVkX2Rpc3BhdGNoX3JlcXVl
c3RzKzB4MmYvMHg2MAo+ID4gIGJsa19tcV9ydW5fd29ya19mbisweDQzLzB4YzAKPiA+ICBwcm9j
ZXNzX29uZV93b3JrKzB4MjRlLzB4NDMwCj4gPiAgd29ya2VyX3RocmVhZCsweDU0LzB4NGQwCj4g
PiAga3RocmVhZCsweDFiMy8weDFlMAo+ID4gIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwCj4gPiAt
LS1bIGVuZCB0cmFjZSBiZDUxOTE3ZWFlMWQ3MjAxIF0tLS0KPiA+IG52bWVfc2V0dXBfZGlzY2Fy
ZDogcmFuZ2VzIDE1IHNlZ21lbnRzIDE0Cj4gPiBkdW1wIHJlcSAwMDAwMDAwMDJjNmEwODViKGY6
Mywgc2VnOiAxNCkKPiA+IDAtMDAwMDAwMDAyYzMyOTdjNzogZjgwLzMgNjc1NzczNDQwIDEwMjQK
PiA+IDEtMDAwMDAwMDA5OGVkYjJhODogYjgwLzMgMTg4MzE5NzQ0IDEwMjQKPiA+IDItMDAwMDAw
MDBmNThlM2IxODogYjgwLzMgNjc1Nzc1NDg4IDEwMjQKPiA+IDMtMDAwMDAwMDBmNjY3MGM1YTog
YjgwLzMgMTg4MTI5MjgwIDIwNDgKPiA+IDQtMDAwMDAwMDBlYTM3MWE4ODogYjgwLzMgNjc1NTg1
MDI0IDIwNDgKPiA+IDUtMDAwMDAwMDBlOWNlYzA0MzogYjgwLzMgMTg4MTQwNTQ0IDIwNDgKPiA+
IDYtMDAwMDAwMDA2ZTExMjZlNjogYjgwLzMgNjc1NTk2Mjg4IDIwNDgKPiA+IDctMDAwMDAwMDA5
NDY2ZjkzNzogYjgwLzMgMTg4MzI3OTM2IDIwNDgKPiA+IDgtMDAwMDAwMDAzYzllMmNjZDogYjgw
LzMgNjc1NzgzNjgwIDIwNDgKPiA+IDktMDAwMDAwMDBhYjMyMmM2ODogYjgwLzMgMTg4MzI5OTg0
IDIwNDgKPiAKPiAxODgzMjk5ODQgPSAxODgzMjc5MzYgKyAyMDQ4Cj4gCj4gPiAxMC0wMDAwMDAw
MGViMmIzZmI2OiBiODAvMyA2NzU3ODU3MjggMjA0OAo+IAo+IDY3NTc4NTcyOCA9IDY3NTc4MzY4
MCArIDIwNDgKPiAKPiBTZWVtcyB0aGUgYWRqYWNlbnQgYmlvcyBhcmUgY3V0IGJ5IGNvbWluZyBk
aXNjYXJkCj4gcmFuZ2UuCj4gCj4gTG9va3MgaXQgaXNuJ3QgbWF0dXJlIHRvIHN1cHBvcnQgbWl4
ZWQgZGlzY2FyZCBJTyBtZXJnZSgKPiB0cmFkaXRpb25hbCBpbyBtZXJnZSB2cy4gbXVsdGktcmFu
Z2UgbWVyZ2UpLCBJIHdpbGwgcG9zdAo+IHRoZSBwcmV2aW91cyBwYXRjaCBmb3IgZml4aW5nIHRo
aXMgaXNzdWUuCgpUaGUgcmVhc29uIGlzIHRoZSBmb2xsb3dpbmcgbGluZXMgb2YgY29kZToKCiNk
ZWZpbmUgcnFfaGFzaF9rZXkocnEpICAgICAgICAgKGJsa19ycV9wb3MocnEpICsgYmxrX3JxX3Nl
Y3RvcnMocnEpKQoKaWYgKGJsa19ycV9wb3MocnEpICsgYmxrX3JxX3NlY3RvcnMocnEpID09IGJp
by0+YmlfaXRlci5iaV9zZWN0b3IpCgouLi4KClRoZSBjdXJyZW50IGJsb2NrIG1lcmdlIGNvZGUg
dGhpbmtzIHRoYXQgYWxsIGJpb3MgaW4gb25lIHJlcXVlc3QgaXMgcGh5c2ljYWxseQpjb250aW51
b3VzLCBzbyB3ZSBjYW4ndCBzdXBwb3J0IG1peGVkIG1lcmdlIGZvciBtdWx0aS1yYW5nZSBkaXNj
YXJkIHJlcXVlc3Qgc2ltcGx5LgoKClRoYW5rcywKTWluZwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
