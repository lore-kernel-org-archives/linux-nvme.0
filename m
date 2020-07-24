Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C54C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 16:18:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E288A20674
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 16:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gTpHl65e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="bCYGEiMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E288A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U9tKgyzA3SzizuJ4+Ueta8PgPZrdS4onlXaFSWQMheQ=; b=gTpHl65eREVV6QfmCml9IuEuV
	f+KVVV2bPe/wHjtypgLYJETdDI25HUx2KmTan0rI6ekSwMu3jxEwzuMxSiiMRdQ1kNu8YWR9W/3pg
	gXlOTeEfKL0BowlSANAhqOUfOIhjpU8ZgmeXbggQk8O1T2f71coZJbiFoLaF0rMxgvLcva1BkGVec
	8G0WFFQZQKsN76+lKgFsVQcCueppVqa+Nns8Y4YiqsNo3lmVtUR+5p4pwoGImhPj+zs4XjuISY3P6
	PzGVT7Q3/8tGqbanUlnGyPgyeS25Xij+fr8JCdakDSE77R81y+J59IRBwLMzSCLONxaFuPwHG04Xv
	nf+EQAtgg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz0OY-00051s-6U; Fri, 24 Jul 2020 16:18:02 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz0OT-00051M-Gj
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 16:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NmKn4X0N5NZuogBEHweV8bqenNCVjkTrSsHCArgNZY0=; b=bCYGEiMUPGNXVMhlj1LZaY9k2B
 RnsOOro1SQ7a2sVUc4V/g11TkIUxlld0AOER+nhIPfNX7qp4Yuukk+vSiBalsrdvHqvTq8ee5CVWs
 UFDz4MVkqFFZ1KhOKURGQrxtPx3Mjn5kyd0LqumtQU6HseIKgyy6pDcUIbEkUnmIPB4q684kChD1b
 s7TsZTPVsoihUGGLiY+seeBipJUQFl1TdOGmd/UhFzi6halQQp0vWaLN2bDsLNkfr8wTNExl0Mf1m
 4A1LQt5VIx3Lyl5/OWWuMRjLmjq6UwDqO2npR1yIP2A1sglpRtfG+txPNXgtltWmDqwGqQgGfF6LY
 q/YrDNvA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1jz0OP-0005nO-BF; Fri, 24 Jul 2020 10:17:54 -0600
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200722233219.117326-1-sagi@grimberg.me>
 <20200722233219.117326-3-sagi@grimberg.me>
 <770b71ff-b3d9-886d-3455-cfae217c45c8@deltatee.com>
 <4da6f061-ee5b-d40a-7e81-6f705ac0fcb8@grimberg.me>
 <70424742-3af4-ded7-d3d0-b1f32d97905e@grimberg.me>
 <b53211f1-d1e5-fd58-c1ca-b924eecab6ea@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8f9db19e-399b-3e33-26fb-21bf552a38c5@deltatee.com>
Date: Fri, 24 Jul 2020 10:17:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b53211f1-d1e5-fd58-c1ca-b924eecab6ea@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: james.smart@broadcom.com, anton@lightbitslabs.com,
 kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 2/2] nvme-core: fix deadlock in disconnect during
 scan_work and/or ana_work
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_121757_577174_E023BB70 
X-CRM114-Status: GOOD (  26.88  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLTA3LTIzIDc6MDMgcC5tLiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gQWN0
dWFsbHksIEkgdGhpbmsgdGhhdCB0aGUgZGVzaWduIHdhcyB0byB1bmJsb2NrIHRoZSBzY2FuX3dv
cmsgYW5kIHRoYXQKPj4gaXMgd2h5IG52bWVfbXBhdGhfY2xlYXJfY3RybF9wYXRocyB3YXMgcGxh
Y2VkIGJlZm9yZSAoYXMgdGhlIGNvbW1lbnQKPj4gc2F5KS4KPj4KPj4gQnV0IGxvb2tpbmcgYXQg
dGhlIGltcGxlbWVudGF0aW9uIG9mIG52bWVfbXBhdGhfY2xlYXJfY3RybF9wYXRocywgaXQncwo+
PiBjb21wbGV0ZWx5IHVuY2xlYXIgd2h5IGl0IHNob3VsZCB0YWtlIHRoZSBzY2FuX2xvY2suIEl0
IGlzIGp1c3QgY2xlYXJpbmcKPj4gdGhlIHBhdGhzLi4KPj4KPj4gSSB0aGluayB0aGF0IHRoZSBj
b3JyZWN0IHBhdGNoIHdvdWxkIGJlIHRvIGp1c3Qgbm90IHRha2UgdGhlIHNjYW5fbG9jawo+PiBh
bmQgb25seSB0YWtlIHRoZSBuYW1lc3BhY2VzX3J3c2VtLgo+IAo+IE9LLCBJIHdhcyBhYmxlIHRv
IHJlcHJvZHVjZSB0aGlzIG9uIG15IHNldHVwLgo+IAo+IFdoYXQgd2FzIG5lZWRlZCBpcyB0aGF0
IGZhYnJpY3Mgd2lsbCBhbGxvdyBJL08gdG8gcGFzcyBpbgo+IE5WTUVfQ1RSTF9ERUxFVElORywg
d2hpY2ggbmVlZGVkIHRoaXMgYWRkLW9uOgo+IC0tIAo+IMKgwqDCoCBudm1lLWZhYnJpY3M6IGRv
bid0IGZhc3QgZmFpbCBvbiBjdHJsIHN0YXRlIERFTEVUSU5HCj4gCj4gwqDCoMKgIFRoaXMgaXMg
bm93IGFuIHN0YXRlIHRoYXQgYWxsb3dzIGZvciBJL08gdG8gYmUgc2VudCB0byB0aGUKPiDCoMKg
wqAgZGV2aWNlLCBhbmQgd2hlbiB0aGUgZGV2aWNlIHNoYWxsIHRyYW5zaXRpb24gaW50bwo+IMKg
wqDCoCBOVk1FX0NUUkxfREVMRVRJTkdfTk9JTyB3ZSBzaGFsbCBmYWlsIHRoZSBJL08uCj4gCj4g
wqDCoMKgIE5vdGUgdGhhdCB0aGlzIGlzIGZpbmUgYmVjYXVzZSB0aGUgdHJhbnNwb3J0IGl0c2Vs
ZiBoYXMKPiDCoMKgwqAgYSBxdWV1ZSBzdGF0ZSB0byBwcm90ZWN0IGFnYWluc3QgcXVldWUgYWNj
ZXNzLgo+IAo+IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1i
ZXJnLm1lPgo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmggYi9k
cml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmgKPiBpbmRleCBhMGVjNDBhYjYyZWUuLmE5YzFlM2I0
NTg1ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmgKPiArKysgYi9k
cml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmgKPiBAQCAtMTgyLDcgKzE4Miw4IEBAIGJvb2wgbnZt
Zl9pcF9vcHRpb25zX21hdGNoKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsCj4gwqBzdGF0aWMgaW5s
aW5lIGJvb2wgbnZtZl9jaGVja19yZWFkeShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QK
PiByZXF1ZXN0ICpycSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBxdWV1
ZV9saXZlKQo+IMKgewo+IC3CoMKgwqDCoMKgwqAgaWYgKGxpa2VseShjdHJsLT5zdGF0ZSA9PSBO
Vk1FX0NUUkxfTElWRSkpCj4gK8KgwqDCoMKgwqDCoCBpZiAobGlrZWx5KGN0cmwtPnN0YXRlID09
IE5WTUVfQ1RSTF9MSVZFIHx8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y3RybC0+c3RhdGUgPT0gTlZNRV9DVFJMX0RFTEVUSU5HKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIF9fbnZtZl9j
aGVja19yZWFkeShjdHJsLCBycSwgcXVldWVfbGl2ZSk7Cj4gwqB9Cj4gLS0gCj4gCj4gTG9nYW4s
Cj4gCj4gQ2FuIHlvdSB2ZXJpZnkgdGhhdCBpdCB3b3JrcyBmb3IgeW91PwoKWWVzLCB0aGFua3Ms
IHRoaXMgZml4ZXMgdGhlIGlzc3VlIGZvciBtZS4KCj4gQlRXLCBJJ20gc3RpbGwgc2VyaW91c2x5
IHN1c3BpY2lvdXMgb24gd2h5IG52bWVfbXBhdGhfY2xlYXJfY3RybF9wYXRocwo+IGlzIHRha2lu
ZyB0aGUgc2Nhbl9sb2NrLiBJdCBhcHBlYXJzIHRoYXQgaXQgc2hvdWxkbid0LiBJJ20gdGVtcHRl
ZCB0bwo+IHJlbW92ZSBpdCBhbmQgc2VlIGlmIGFueW9uZSBjb21wbGFpbnMuLi4KCk5vdCByZWFs
bHkgc3VyZSBteXNlbGYsIGJ1dCBJIGRpZCBhIGN1cnNvcnkgbG9vayBhbmQgZG9uJ3Qgc2VlIGFu
eQpvYnZpb3VzIHJlYXNvbiB3aHkgc2Nhbl9sb2NrIG5lZWRzIHRvIGJlIHRha2VuIHRoZXJlLgoK
TG9nYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
