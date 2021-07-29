Return-Path: <SRS0=T4Lt=MV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59352C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jul 2021 03:34:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F016103A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jul 2021 03:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10F016103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H99NXqyAf0khi+LC9JPc9qEuMUs5f+Y8yp7uYeQL7ZQ=; b=rXtl4ZU6KjOxek
	nM+XCpf3a2vJ55+aQQZb6zyGqmFlEw81a8Jq02UrZyr1WVR/jlfIOSjlyxEC6QU2/n6K58YZ44Vjo
	JTHEuo7+xCMOLpCOFfkL6sOxwlzdm72cl0+nLkFweTE0CfZk2hd+UWVwPrGL4lxU1dsd0zIbmHbPk
	Ly7tqTjo5X4ayzizetsUctxyA7uU4EntqyVlwtcsZHXwKWExHNndSmAvNGw492pWtvM2jKUDZBbKP
	27EL4IofYCVkDGDNrTZcKhjuAKIOMnj46OxizmPLhBi8JKTmFhcvJLsttnBXfsc+q3ya1bHR5CQIQ
	j1JsabHDA28Hr4XejVXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8wnn-002yJS-40; Thu, 29 Jul 2021 03:33:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8wnj-002yIj-62
 for linux-nvme@lists.infradead.org; Thu, 29 Jul 2021 03:33:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627529612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FOYTvQHscc3bjRMvDIJC+iI00m3LtGOUi4Tkr7sZCKY=;
 b=dsw7P6Cyvp4M6G1/ZJw2ui2ZdFY5FyJ1bbwk1TTOV0qV2U79aynpv8h7rn4EMtqSMgt0oL
 MqhQbA5bVo0C71RBpEwK7kDxWXRwu3k5ba+YnDc8oPUXcf5B0KStMnZAEWbBnCHsM0Nzmu
 wMa/Vck0poHkRJxoF4RW+feLTXcFN5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-yuJPj04POHymQAhdb0bKLA-1; Wed, 28 Jul 2021 23:33:28 -0400
X-MC-Unique: yuJPj04POHymQAhdb0bKLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D63F5185302A;
 Thu, 29 Jul 2021 03:33:26 +0000 (UTC)
Received: from T590 (ovpn-13-29.pek2.redhat.com [10.72.13.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62A491017CE5;
 Thu, 29 Jul 2021 03:33:16 +0000 (UTC)
Date: Thu, 29 Jul 2021 11:33:19 +0800
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
Message-ID: <YQIhfwP2z+DGWOxV@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <3180854.nXyytZ0Y3r@natalenko.name> <YQF9YRSdRc+eVD1c@T590>
 <4560968.zrxKzTJTGe@natalenko.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4560968.zrxKzTJTGe@natalenko.name>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210728_203339_366910_14CD58A6 
X-CRM114-Status: GOOD (  22.83  )
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

T24gV2VkLCBKdWwgMjgsIDIwMjEgYXQgMDY6Mzg6MzZQTSArMDIwMCwgT2xla3NhbmRyIE5hdGFs
ZW5rbyB3cm90ZToKPiBIZWxsby4KPiAKPiBPbiBzdMWZZWRhIDI4LiDEjWVydmVuY2UgMjAyMSAx
Nzo1MzowNSBDRVNUIE1pbmcgTGVpIHdyb3RlOgo+ID4gQ2FuIHlvdSBjb2xsZWN0IGRlYnVnIGxv
ZyBieSBhcHBseWluZyB0aGUgZm9sbG93aW5nIHBhdGNoIGFnYWluc3QgdGhlCj4gPiBsYXN0IG9u
ZT8KPiAKPiBZZXMsIHBsZWFzZSBzZWUgYmVsb3cuCj4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gPiBpbmRleCA4
NzgwZTRhYTlkZjIuLmZiZDhhNjhjNjE5YiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYwo+ID4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gPiBAQCAtODI4
LDYgKzgyOCwyNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9zZXR1cF9mbHVzaChzdHJ1Y3Qg
bnZtZV9ucyAqbnMsCj4gPiBjbW5kLT5jb21tb24ubnNpZCA9IGNwdV90b19sZTMyKG5zLT5oZWFk
LT5uc19pZCk7Cj4gPiAgfQo+ID4gCj4gPiArc3RhdGljIGlubGluZSB2b2lkIGJsa19kdW1wX3Jx
KGNvbnN0IHN0cnVjdCByZXF1ZXN0ICpyZXEpCj4gPiArewo+ID4gKwlzdHJ1Y3QgYmlvICpiaW87
Cj4gPiArCWludCBpID0gMDsKPiA+ICsKPiA+ICsJcHJpbnRrKCJkdW1wIHJlcSAlcChmOiV4LCBz
ZWc6ICVkKVxuIiwgcmVxLCByZXEtPmNtZF9mbGFncywKPiA+ICsJCQlyZXEtPm5yX3BoeXNfc2Vn
bWVudHMpOwo+ID4gKwo+ID4gKwlfX3JxX2Zvcl9lYWNoX2JpbyhiaW8sIHJlcSkgewo+ID4gKwkJ
cHJpbnRrKCIlZC0lcDogJWh4LyVoeCAlbGx1ICV1XG4iLAo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaSsrLCBiaW8sCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBiaW8tPmJpX2ZsYWdz
LCBiaW8tPmJpX29wZiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICh1bnNpZ25lZCBsb25n
IGxvbmcpYmlvLT5iaV9pdGVyLmJpX3NlY3RvciwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGJpby0+YmlfaXRlci5iaV9zaXplPj45KTsKPiA+ICsJfQo+ID4gK30KPiA+ICsKPiA+ICsKPiA+
ICBzdGF0aWMgYmxrX3N0YXR1c190IG52bWVfc2V0dXBfZGlzY2FyZChzdHJ1Y3QgbnZtZV9ucyAq
bnMsIHN0cnVjdCByZXF1ZXN0Cj4gPiAqcmVxLCBzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbW5kKQo+
ID4gIHsKPiA+IEBAIC04NjgsNiArODg2LDggQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX3Nl
dHVwX2Rpc2NhcmQoc3RydWN0IG52bWVfbnMKPiA+ICpucywgc3RydWN0IHJlcXVlc3QgKnJlcSwg
fQo+ID4gCj4gPiAgCWlmIChXQVJOX09OX09OQ0UobiAhPSBzZWdtZW50cykpIHsKPiA+ICsJCXBy
aW50aygiJXM6IHJhbmdlcyAldSBzZWdtZW50cyAldVxuIiwgX19mdW5jX18sIG4sIHNlZ21lbnRz
KTsKPiA+ICsJCWJsa19kdW1wX3JxKHJlcSk7Cj4gPiAgCQlpZiAodmlydF90b19wYWdlKHJhbmdl
KSA9PSBucy0+Y3RybC0+ZGlzY2FyZF9wYWdlKQo+ID4gIAkJCWNsZWFyX2JpdF91bmxvY2soMCwg
Jm5zLT5jdHJsLT5kaXNjYXJkX3BhZ2VfYnVzeSk7Cj4gPiAgCQllbHNlCj4gCj4gYGBgCj4gV0FS
TklORzogQ1BVOiAxNyBQSUQ6IDgyMSBhdCBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmM6ODY4IG52
bWVfc2V0dXBfZGlzY2FyZCsweDFjNi8weDIyMAo+IOKApgo+IENQVTogMTcgUElEOiA4MjEgQ29t
bToga3dvcmtlci8xNzoxSCBOb3QgdGFpbnRlZCA1LjEzLjAtcGY0ICMxCj4gSGFyZHdhcmUgbmFt
ZTogQVNVUyBTeXN0ZW0gUHJvZHVjdCBOYW1lL1BybyBXUyBYNTcwLUFDRSwgQklPUyAzNjAxIDA1
LzI2LzIwMjEKPiBXb3JrcXVldWU6IGtibG9ja2QgYmxrX21xX3J1bl93b3JrX2ZuCj4gUklQOiAw
MDEwOm52bWVfc2V0dXBfZGlzY2FyZCsweDFjNi8weDIyMAo+IENvZGU6IDhiIGEwIDQwIDBiIDAw
IDAwIDRjIDJiIDI1IGY3IGZmIGQ3IDAwIDQ5IGMxIGZjIDA2IDQ5IGMxIGU0IDBjIDRjIDAzIDI1
IGY4IGZmIGQ3IDAwIDRjIDg5IGU1IDQ4IDg1IGQyIDBmIDg1IDliIGZlIGZmIGZmIDMxIGQyIDww
Zj4gMGIgNDggYzcgYzYgZTAgYTggMTAgOGIgNDEgMGYgYjcgY2QgNDggYzcgYzcgYWYgMDkgNDAg
OGIgZTggMTQKPiBSU1A6IDAwMTg6ZmZmZmFmYTg4NDUxN2JmMCBFRkxBR1M6IDAwMDEwMjk3Cj4g
UkFYOiBmZmZmOTE2MDJmNWIyMGQwIFJCWDogZmZmZjkxNWUwNTc0M2MwMCBSQ1g6IDAwMDAwMDAw
MDAwODAwMDAKPiBSRFg6IDAwMDAwMDAwMDAwMDAwMGYgUlNJOiAwMDAwMDAwMDI4NDQ1YzAwIFJE
STogMDAwMDAwMDAwMDAwMDAwZgo+IFJCUDogZmZmZjkxNjAyZjViMjAwMCBSMDg6IDAwMDAwMDAw
MGIzNjYwMDAgUjA5OiBmZmZmOTE2MDJmNWIyMDAwCj4gUjEwOiAwMDAwMDAwMDAwMDAwMDJkIFIx
MTogZmVmZWZlZmVmZWZlZmVmZiBSMTI6IGZmZmY5MTYwMmY1YjIwMDAKPiBSMTM6IDAwMDAwMDAw
MDAwMDAwMGUgUjE0OiBmZmZmOTE1ZTE4Yzc3MDAwIFIxNTogZmZmZjkxNWUxOGM3NzE0OAo+IEZT
OiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOTE2NTBlZTQwMDAwKDAwMDApIGtubEdT
OjAwMDAwMDAwMDAwMDAwMDAKPiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAw
MDAwMDgwMDUwMDMzCj4gQ1IyOiAwMDAwMWM5MGIzNjg3OWE4IENSMzogMDAwMDAwMDEwZDE4YzAw
MCBDUjQ6IDAwMDAwMDAwMDAzNTBlZTAKPiBDYWxsIFRyYWNlOgo+ICBudm1lX3NldHVwX2NtZCsw
eDJlNC8weDZhMAo+ICBudm1lX3F1ZXVlX3JxKzB4NzkvMHhjOTAKPiAgYmxrX21xX2Rpc3BhdGNo
X3JxX2xpc3QrMHgxNWMvMHg4MTAKPiAgX19ibGtfbXFfZG9fZGlzcGF0Y2hfc2NoZWQrMHhjYS8w
eDMyMAo+ICBfX2Jsa19tcV9zY2hlZF9kaXNwYXRjaF9yZXF1ZXN0cysweDE0ZC8weDE5MAo+ICBi
bGtfbXFfc2NoZWRfZGlzcGF0Y2hfcmVxdWVzdHMrMHgyZi8weDYwCj4gIGJsa19tcV9ydW5fd29y
a19mbisweDQzLzB4YzAKPiAgcHJvY2Vzc19vbmVfd29yaysweDI0ZS8weDQzMAo+ICB3b3JrZXJf
dGhyZWFkKzB4NTQvMHg0ZDAKPiAga3RocmVhZCsweDFiMy8weDFlMAo+ICByZXRfZnJvbV9mb3Jr
KzB4MjIvMHgzMAo+IC0tLVsgZW5kIHRyYWNlIGJkNTE5MTdlYWUxZDcyMDEgXS0tLQo+IG52bWVf
c2V0dXBfZGlzY2FyZDogcmFuZ2VzIDE1IHNlZ21lbnRzIDE0Cj4gZHVtcCByZXEgMDAwMDAwMDAy
YzZhMDg1YihmOjMsIHNlZzogMTQpCj4gMC0wMDAwMDAwMDJjMzI5N2M3OiBmODAvMyA2NzU3NzM0
NDAgMTAyNAo+IDEtMDAwMDAwMDA5OGVkYjJhODogYjgwLzMgMTg4MzE5NzQ0IDEwMjQKPiAyLTAw
MDAwMDAwZjU4ZTNiMTg6IGI4MC8zIDY3NTc3NTQ4OCAxMDI0Cj4gMy0wMDAwMDAwMGY2NjcwYzVh
OiBiODAvMyAxODgxMjkyODAgMjA0OAo+IDQtMDAwMDAwMDBlYTM3MWE4ODogYjgwLzMgNjc1NTg1
MDI0IDIwNDgKPiA1LTAwMDAwMDAwZTljZWMwNDM6IGI4MC8zIDE4ODE0MDU0NCAyMDQ4Cj4gNi0w
MDAwMDAwMDZlMTEyNmU2OiBiODAvMyA2NzU1OTYyODggMjA0OAo+IDctMDAwMDAwMDA5NDY2Zjkz
NzogYjgwLzMgMTg4MzI3OTM2IDIwNDgKPiA4LTAwMDAwMDAwM2M5ZTJjY2Q6IGI4MC8zIDY3NTc4
MzY4MCAyMDQ4Cj4gOS0wMDAwMDAwMGFiMzIyYzY4OiBiODAvMyAxODgzMjk5ODQgMjA0OAoKMTg4
MzI5OTg0ID0gMTg4MzI3OTM2ICsgMjA0OAoKPiAxMC0wMDAwMDAwMGViMmIzZmI2OiBiODAvMyA2
NzU3ODU3MjggMjA0OAoKNjc1Nzg1NzI4ID0gNjc1NzgzNjgwICsgMjA0OAoKU2VlbXMgdGhlIGFk
amFjZW50IGJpb3MgYXJlIGN1dCBieSBjb21pbmcgZGlzY2FyZApyYW5nZS4KCkxvb2tzIGl0IGlz
bid0IG1hdHVyZSB0byBzdXBwb3J0IG1peGVkIGRpc2NhcmQgSU8gbWVyZ2UoCnRyYWRpdGlvbmFs
IGlvIG1lcmdlIHZzLiBtdWx0aS1yYW5nZSBtZXJnZSksIEkgd2lsbCBwb3N0CnRoZSBwcmV2aW91
cyBwYXRjaCBmb3IgZml4aW5nIHRoaXMgaXNzdWUuCgo+IGJsa191cGRhdGVfcmVxdWVzdDogSS9P
IGVycm9yLCBkZXYgbnZtZTFuMSwgc2VjdG9yIDY3NTc3MzQ0MCBvcCAweDM6KERJU0NBUkQpIGZs
YWdzIDB4MCBwaHlzX3NlZyAxNCBwcmlvIGNsYXNzIDAKPiBudm1lX3NldHVwX2Rpc2NhcmQ6IHJh
bmdlcyA0NSBzZWdtZW50cyA0OAouLi4KPiBudm1lX3NldHVwX2Rpc2NhcmQ6IHJhbmdlcyA3MyBz
ZWdtZW50cyA3NQouLi4KPiBudm1lX3NldHVwX2Rpc2NhcmQ6IHJhbmdlcyA1IHNlZ21lbnRzIDYK
Li4uCj4gbnZtZV9zZXR1cF9kaXNjYXJkOiByYW5nZXMgMiBzZWdtZW50cyAzCi4uLgo+IG52bWVf
c2V0dXBfZGlzY2FyZDogcmFuZ2VzIDIgc2VnbWVudHMgMwouLi4KPiBudm1lX3NldHVwX2Rpc2Nh
cmQ6IHJhbmdlcyAyIHNlZ21lbnRzIDMKLi4uCj4gbnZtZV9zZXR1cF9kaXNjYXJkOiByYW5nZXMg
NDggc2VnbWVudHMgNDkKLi4uCj4gbnZtZV9zZXR1cF9kaXNjYXJkOiByYW5nZXMgOSBzZWdtZW50
cyAxMAoKRm9yIHRoZSBhYm92ZShyYW5nZXMgPCBzZWdtZW50cyksIHRoYXQgc2hvdWxkIGJlIGNh
dXNlZCBieQpibGtfcmVjYWxjX3JxX3NlZ21lbnRzKCksIHdoaWNoIGNhbiBiZSBzb2x2ZWQgYnkg
c3dpdGNoaW5nIHRvCnJxX2Zvcl9lYWNoX2Rpc2NhcmRfcmFuZ2UoKSBmb3IgZGlzY2FyZCBpby4K
CgpUaGFua3MsCk1pbmcKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
