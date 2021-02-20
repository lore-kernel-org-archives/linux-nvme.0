Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1B1C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 14:59:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E592464E76
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 14:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E592464E76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mg4XjVF1+A/AtfKMra5ZEBIPrNbi1p7+jwQy/czd+cg=; b=CKbAhU1XhBsNDk93ap77Hi0qs
	MwNzZPQyIUjwtrXc8H52JTR8vyNJ1IpofbOd2rpGDMNitOB16z9tzxDNVjWZytyQ2pe4elLPIwRyp
	RsEHOFGt2ShaiZvN3qbBvRwByt6C2JStKs4d8f7ueARPYjkDM2pMZA2F4KemKMHQ0zWaDv73W57Bf
	Rb1cL4i2UE6T6GLLvk+LCkxITGqUKRE8iVdSiaYkD1+t/4lZtKm+/ZOyU8VA85p8QokfyVD8LMO7I
	Qd7eH/f1WQ19UjOIJ7T9cJC/zxmbUvsuiv+//mOTmkKfdkbphMtyXYDzPMm3aXAIoDQgce03/ErOr
	rCoYqqCQw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDTiQ-00060D-N4; Sat, 20 Feb 2021 14:58:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDTiN-0005zm-Q2
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 14:58:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 360ECACCF;
 Sat, 20 Feb 2021 14:58:33 +0000 (UTC)
Subject: Re: [PATCH] nvme: add 'fail_if_no_path' sysfs attribute
To: Keith Busch <kbusch@kernel.org>
References: <20210219144625.56344-1-hare@suse.de>
 <20210219231643.GA4105@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2d069bdb-d4dc-9d50-075f-1fa7eb6bc949@suse.de>
Date: Sat, 20 Feb 2021 15:58:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210219231643.GA4105@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210220_095835_979036_2CCC340F 
X-CRM114-Status: GOOD (  25.63  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yMC8yMSAxMjoxNiBBTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gRnJpLCBGZWIgMTks
IDIwMjEgYXQgMDM6NDY6MjVQTSArMDEwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBJbiBz
b21lIHNldHVwcyBsaWtlIFJBSUQgd2UgbmVlZCB0byByZXR1cm4gYW4gSS9PIGVycm9yCj4+IG9u
Y2UgYWxsIHBhdGhzIGFyZSB1bmF2YWlsYWJsZSB0byBhbGxvdyB0aGUgdXBwZXIgbGF5ZXJzCj4+
IHRvIHN0YXJ0IHRoZWlyIG93biBlcnJvciByZWNvdmVyeSAobGlrZSByZWRpcmVjdGluZyBJL08K
Pj4gdG8gb3RoZXIgbWlycm9ycykuCj4+IFRoaXMgcGF0Y2ggYWRkcyBhIHN5c2ZzIGF0dHJpYnV0
ZSAnZmFpbF9pZl9ub19wYXRoJyB0bwo+PiBhbGxvdyB0aGUgYWRtaW4gdG8gZW5hYmxlIHRoYXQg
YmVoYXZpb3VyIGluc3RlYWQgb2YgdGhlCj4+IGN1cnJlbnQgJ3F1ZXVlIHVudGlsIGEgcGF0aCBi
ZWNvbWVzIGF2YWlsYWJsZScgcG9saWN5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVp
bmVja2UgPGhhcmVAc3VzZS5kZT4KPiAKPiBTb3VuZHMgb2theSB0byBtZSwganVzdCBzb21lIG1p
bm9yIG5pdHMgYmVsb3cuCj4gCj4+IEBAIC0yODMsMTAgKzI4MywxMyBAQCBzdGF0aWMgYm9vbCBu
dm1lX2F2YWlsYWJsZV9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQpCj4+ICAgCQkJY29u
dGludWU7Cj4+ICAgCQlzd2l0Y2ggKG5zLT5jdHJsLT5zdGF0ZSkgewo+PiAgIAkJY2FzZSBOVk1F
X0NUUkxfTElWRToKPj4gKwkJCXJldHVybiB0cnVlOwo+PiAgIAkJY2FzZSBOVk1FX0NUUkxfUkVT
RVRUSU5HOgo+PiAgIAkJY2FzZSBOVk1FX0NUUkxfQ09OTkVDVElORzoKPj4gICAJCQkvKiBmYWxs
dGhydSAqLwo+PiAtCQkJcmV0dXJuIHRydWU7Cj4+ICsJCQlpZiAoIXRlc3RfYml0KE5WTUVfTlNI
RUFEX0ZBSUxfSUZfTk9fUEFUSCwKPj4gKwkJCQkgICAgICAmaGVhZC0+ZmxhZ3MpKQo+PiArCQkJ
CXJldHVybiB0cnVlOwo+IAo+IEl0IGRvZXNuJ3QgbG9vayBsaWtlIHRoZSAnZmFsbHRocnUnIGlz
IGluIHRoZSByaWdodCBwbGFjZSBhbnltb3JlLAo+IHRob3VnaCBJIGNhbid0IHRlbGwgd2h5IGl0
IGlzIHRoZXJlIGluIHRoZSBmaXJzdCBwbGFjZS4KPiAKSW5kZWVkLCB0aGUgJ2ZhbGx0aHJ1JyBp
cyBtaXNwbGFjZWQ7IGl0IG5lZWRzIHRvIGdvIGFmdGVyCk5WTUVfQ1RSTF9SRVNFVFRJTkcuCgo+
PiAgIAkJZGVmYXVsdDoKPj4gICAJCQlicmVhazsKPj4gICAJCX0KPj4gQEAgLTY0MSw2ICs2NDQs
MzcgQEAgc3RhdGljIHNzaXplX3QgYW5hX3N0YXRlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKPj4gICB9Cj4+ICAgREVWSUNFX0FUVFJfUk8o
YW5hX3N0YXRlKTsKPj4gICAKPj4gK3N0YXRpYyBzc2l6ZV90IGZhaWxfaWZfbm9fcGF0aF9zaG93
KHN0cnVjdCBkZXZpY2UgKmRldiwKPj4gKwkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
IGNoYXIgKmJ1ZikKPj4gK3sKPj4gKwlzdHJ1Y3QgZ2VuZGlzayAqZGlzayA9IGRldl90b19kaXNr
KGRldik7Cj4+ICsJc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCA9IGRpc2stPnByaXZhdGVfZGF0
YTsKPj4gKwo+PiArCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLAo+PiArCQkgICAgICAgdGVz
dF9iaXQoTlZNRV9OU0hFQURfRkFJTF9JRl9OT19QQVRILCAmaGVhZC0+ZmxhZ3MpID8KPj4gKwkJ
ICAgICAgIDEgOiAwKTsKPj4gK30KPj4gKwo+PiArc3RhdGljIHNzaXplX3QgZmFpbF9pZl9ub19w
YXRoX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4gKwkJc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmF0dHIsIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQo+PiArewo+PiArCXN0cnVj
dCBnZW5kaXNrICpkaXNrID0gZGV2X3RvX2Rpc2soZGV2KTsKPj4gKwlzdHJ1Y3QgbnZtZV9uc19o
ZWFkICpoZWFkID0gZGlzay0+cHJpdmF0ZV9kYXRhOwo+PiArCWludCBmYWlsX2lmX25vX3BhdGgs
IGVycjsKPj4gKwo+PiArCWVyciA9IGtzdHJ0b2ludChidWYsIDEwLCAmZmFpbF9pZl9ub19wYXRo
KTsKPj4gKwlpZiAoZXJyKQo+PiArCQlyZXR1cm4gLUVJTlZBTDsKPj4gKwo+PiArCWVsc2UgaWYg
KGZhaWxfaWZfbm9fcGF0aCA8PSAwKQo+PiArCQljbGVhcl9iaXQoTlZNRV9OU0hFQURfRkFJTF9J
Rl9OT19QQVRILCAmaGVhZC0+ZmxhZ3MpOwo+PiArCWVsc2UKPj4gKwkJc2V0X2JpdChOVk1FX05T
SEVBRF9GQUlMX0lGX05PX1BBVEgsICZoZWFkLT5mbGFncyk7Cj4gCj4gVGhlIGV4dHJhIGxpbmUg
YWJvdmUgdGhlICdlbHNlIGlmJyBzaG91bGQgYmUgcmVtb3ZlZCwgb3IganVzdCBjaGFuZ2UgaXQK
PiB0byBzaW1wbHkgJ2lmJy4KPiAKU3VyZS4KCkknbGwgYmUgcmVzZW5kaW5nLgoKQ2hlZXJzLAoK
SGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9y
YWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAr
NDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRz
ZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
