Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69609C5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 13:09:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78282224C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 13:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kujCbsw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78282224C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TbfYIT3ZqnChmtdzuUWSelh255srh2FUrE9l51RMjB4=; b=kujCbsw50Jw6oXC+JPYZsP18x
	4YaCp0UIcjYENYVO25EK/2EnGlKKrIbGGQ9KFHyk2OUSKHRQRisuy5szYdwfMqjsd0/LYNFENpR4U
	lNQqvF22pUKF9WWX1NK/VSNvnsmToSUosa9bLlGD0+PITR+2kDvRqRSuWR7HugXn5iAfMnHSvVc30
	ry8+xBmaHn8ngTjzga1pT10FgJuOdl/bSbRa72/MlvbhRk6ELwRF2hsCXIWZK9/IoyqiJK/yhcGBY
	BRntsxfToujVsGuULryQPZsVShKHAfq0t1u21tVYWWoe/CRtu+J7gJ3DE7WycBANyCAdyWeDRs9IK
	bXLpBl/Xw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg6A8-0001CB-K5; Fri, 20 Nov 2020 13:09:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg6A0-0001BY-9a
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 13:09:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F1831ABD6;
 Fri, 20 Nov 2020 13:09:05 +0000 (UTC)
Subject: Re: [PATCH v9] nvme-fabrics: reject I/O to offline device
To: Sagi Grimberg <sagi@grimberg.me>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <319b8b1869f34a48b26fbd902883ed71@kioxia.com>
 <b6f09a8e-e633-e303-1f39-cd380fd92f2c@suse.de>
 <a3245f7368364c5b83cdd3ed3a61d718@kioxia.com>
 <08f1048d-0726-983c-c783-2e04d24b5221@suse.de>
 <21948197-ac36-f757-5c1f-f36f2d6d9242@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <07622131-6dba-3735-fa5e-528bdaef7f73@suse.de>
Date: Fri, 20 Nov 2020 14:09:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <21948197-ac36-f757-5c1f-f36f2d6d9242@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_080908_586877_A98E55EC 
X-CRM114-Status: GOOD (  25.37  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 "Ewan D. Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMTcvMjAgOTozOSBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+PiBAQCAtMTUx
LDEyICsxNTEsMTYgQEAgRVhQT1JUX1NZTUJPTF9HUEwobnZtZV90cnlfc2NoZWRfcmVzZXQpOwo+
Pj4+IMKgwqAgc3RhdGljIHZvaWQgbnZtZV9mYWlsZmFzdF93b3JrKHN0cnVjdCB3b3JrX3N0cnVj
dCAqd29yaykgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9jdHJsICpjdHJs
ID0gY29udGFpbmVyX29mKHRvX2RlbGF5ZWRfd29yayh3b3JrKSwKPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9jdHJsLCBm
YWlsZmFzdF93b3JrKTsKPj4+PiArwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX25zICpuczsKPj4+
Pgo+Pj4+IC3CoMKgwqDCoMKgwqAgaWYgKGN0cmwtPnN0YXRlICE9IE5WTUVfQ1RSTF9DT05ORUNU
SU5HKQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+PiAtCj4+
Pj4gLQo+Pj4+IC3CoMKgwqDCoMKgwqAgc2V0X2JpdChOVk1FX0NUUkxfRkFJTEZBU1RfRVhQSVJF
RCwgJmN0cmwtPmZsYWdzKTsKPj4+PiArwqDCoMKgwqDCoMKgIGRvd25fcmVhZCgmY3RybC0+bmFt
ZXNwYWNlc19yd3NlbSk7Cj4+Pj4gK8KgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KG5z
LCAmY3RybC0+bmFtZXNwYWNlcywgbGlzdCkgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChjdHJsLT5zdGF0ZSAhPSBOVk1FX0NUUkxfTElWRSB8fAo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKG5zLT5hbmFfc3RhdGUgIT0gTlZNRV9BTkFf
T1BUSU1JWkVEICYmCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG5zLT5hbmFfc3RhdGUgIT0gTlZNRV9BTkFfTk9OT1BUSU1JWkVEKSkKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0X2JpdChOVk1FX05TX0ZBSUxG
QVNUX0VYUElSRUQsICZucy0+ZmxhZ3MpOwo+Pj4+ICvCoMKgwqDCoMKgwqAgfQo+Pj4+ICvCoMKg
wqDCoMKgwqAgdXBfcmVhZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGRldl9pbmZvKGN0cmwtPmRldmljZSwgImZhaWxmYXN0IGV4cGlyZWRcbiIpOwo+
Pj4+Cj4+Pj4gLi4uYW5kIHdlIGNvdWxkIGxlYXZlIHRoZSBmYWlsZmFzdCB3b3JrZXIgcnVubmlu
ZyBldmVuIGFmdGVyIHRoZSAKPj4+PiBjb250cm9sbGVyCj4+Pj4gdHJhbnNpdGlvbmVkIHRvIExJ
VkUuCj4+Pj4gQ2YgdGhlIGF0dGFjaGVkIHBhdGNoIGZvciBkZXRhaWxzLgo+Pj4+Cj4+Pj4gQ2hl
ZXJzLAo+Pj4+Cj4+Pj4gSGFubmVzCj4+Pj4gLS0gCj4+Pgo+Pj4gSSdtIG5vdCBzdXJlIHdoYXQg
bWFrZXMgc2Vuc2UgdG8gbW92ZSB0aGUgRkFJTEZBU1RfRVhQSVJFRCBiaXQgaW50byAKPj4+IHRo
ZSBuYW1lc3BhY2UsCj4+PiBCZWNhdXNlIHRoZSBmYWlsZmFzdCBtZWNoYW5pc20gY2hhcmFjdGVy
aXplcyB0aGUgY29udHJvbGxlciBhcyBhIHdob2xlLgo+Pj4KPj4gT2gsIHllcywgSSdtIGF3YXJl
IG9mIHRoYXQuIEJ1dCB0aGUgcHJvYmxlbSBoZXJlIGlzIHdpdGggbXVsdGlwYXRoOyAKPj4gaG93
IGRvIHdlIGhhbmRsZSB0aGUgc2l0dWF0aW9uIHdoZXJlIGFsbCBjb250cm9sbGVycyBoYXZlIHRo
ZSAKPj4gJ2ZhaWxmYXN0X2V4cGlyZWQnIGJpdCBzZXQ/Cj4+IFNob3VsZCBJL08gYmUgdGVybWlu
YXRlZCAod2hpY2ggSSB0aGluayBpdCBzaG91bGQsIGdpdmVuIHRoYXQgZmFpbGZhc3QgCj4+IGlz
IHN1cHBvc2VkIHRvIHRlcm1pbmF0ZSB0aGUgSS9PKT8KPj4gT3Igc2hvdWxkIEkvTyBjb250aW51
ZSB0byBydW4gKGFzIGl0IGRvZXMgd2l0aCB5b3VyIG9yaWdpbmFsIHBhdGNoKT8KPiAKPiBJIGRv
IGFncmVlIHRoYXQgZmFzdF9pb19mYWlsX3RtbyBfaXNfIGEgY29udHJvbGxlciBhdHRyaWJ1dGUg
YW5kIHNob3VsZAo+IHJlbWFpbiBhcyBzdWNoLgo+IAo+IEkgZG8gc2VlIHdoYXQgaXMgeW91ciBw
b2ludCBIYW5uZXMsIGhvd2V2ZXIgSSBhbHNvIHRoaW5rIGl0J3MKPiBwcm9ibGVtYXRpYyB0aGF0
IHRoZSBob3N0IG1heSBmYWlsIGFyYml0cmFyeSBJL08gaWYgdGhlIGNvbnRyb2xsZXIKPiBoYXBw
ZW5zIHRvIGVudGVyIEFOQSBpbmFjY2Vzc2libGUgc3RhdGUgKG9yIGhhdmUgc3RhdGUgdHJhbnNp
dGlvbgo+IHRpbWVvdXQpIGZvciBhIHBlcmlvZCB0aGF0IGhhcHBlbnMgdG8gYmUgbG9uZ2VyIHRo
YW4gd2hhdCB0aGUgdXNlcgo+IGhhcHBlbiB0byBzZXQgKHdpdGhvdXQgY29tbXVuaWNhdGluZyBh
bnkgb2YgdGhpcyB0byB0aGUgY29udHJvbGxlcikuCj4gCj4gSUZGIHdlIHdhbnQgdG8gYWRkcmVz
cyB0aGlzIChJJ20gc3RpbGwgbm90IHN1cmUpLCB3ZSBwcm9iYWJseSB3YW50Cj4gdG8gYWN0aXZh
dGUgZmFpbGZhc3QgdGltZW91dCBpbiBBTkEgc3RhdGUgdHJhbnNpdGlvbiAoYW5kIGNsZWFyIGl0
Cj4gd2hlbiB3ZSBleGl0IGl0KS4gVGhlbiB3ZSBjYW4gbW9kaWZ5IG52bWVfYXZhaWxhYmxlX3Bh
dGgoKSB0byB0YWtlCj4gTlZNRV9DVFJMX0ZBSUxGQVNUX0VYUElSRUQgaW50byBhY2NvdW50Lgo+
IAo+IEFueXdheXMsIEkgdGhpbmsgdGhhdCB0aGlzIGNhbiBiZSBhbiBpbmNyZW1lbnRhbCBwYXRj
aCBiZWNhdXNlIGl0Cj4gZG9lc24ndCBjaGFuZ2UgdGhlIGJlaGF2aW9yIHRvZGF5IHdpdGggcmVz
cGVjdCB0byBBTkEgc3RhdGVzIChvcgo+IHRyYW5zaXRpb24gYmV0d2VlbiB0aGVtKSBlLmcuIHF1
ZXVlIHRoZSBvdXRzdGFuZGluZyBJL08uCj4gCk9rYXkgdGhlbi4KWW91IGNhbiBhZGQ6CgpSZXZp
ZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMK
LS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJj
aGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEg
NzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVy
OiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
