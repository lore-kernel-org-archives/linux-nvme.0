Return-Path: <SRS0=P2Tb=7R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3345EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 15:38:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0654B206E6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 15:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E/9ZS+kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0654B206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=911njz/QLyrP1WDO1m+7HrSqZyCMeu7qaNw3kk9aYyk=; b=E/9ZS+kXA1qG5L9RuI2Kj6Zpe
	NTfulLRqYUuMw0e3wcHOY36TdeNG1LeHsstLCU7zcT36a6cC6clAEcz6isnab4+7sPkpJuw1+O4CE
	e8hiM3QyK0wdOeMNgv1LimRLTYBiyEpUbduv0CF9M+6dO1Uz6Fc4DAsQWchen+gdVEVs5NxpA+Ka7
	ZKTMqZ+2S/w6aTJ8rxvNDNjBnb+Lz7jKaWlsIXgARW6sSay0LvMhoI3wPxnI4bTcp7fvW/38/BEa3
	YVv/XZm2v6fIfT63FOa582+qWyhPgobdvLAxpwlSd0LlMsxQ6+J7UpTWvGQNUcTuGJ02Kv4TX/MS+
	B4d/VmAnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgrxE-00030y-RL; Thu, 04 Jun 2020 15:38:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgrxC-0002zt-9X
 for linux-nvme@lists.infradead.org; Thu, 04 Jun 2020 15:38:51 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 884F4AD57;
 Thu,  4 Jun 2020 15:38:50 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvme: check for NVME_CTRL_LIVE in nvme_report_ns_ids()
To: Keith Busch <kbusch@kernel.org>
References: <20200604115602.78446-1-hare@suse.de>
 <20200604115602.78446-2-hare@suse.de>
 <20200604132259.GA146361@dhcp-10-100-145-180.wdl.wdc.com>
 <79298b5a-857d-60dd-91c7-058182b39b0e@suse.de>
 <20200604135715.GB146361@dhcp-10-100-145-180.wdl.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <dc9ff079-9bd4-09fe-91a6-ebfc45511c3c@suse.de>
Date: Thu, 4 Jun 2020 17:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604135715.GB146361@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200604_083850_619324_069D3275 
X-CRM114-Status: GOOD (  22.91  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <daniel.wagner@suse.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi80LzIwIDM6NTcgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+IE9uIFRodSwgSnVuIDA0LCAy
MDIwIGF0IDAzOjQ4OjAyUE0gKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gNi80
LzIwIDM6MjIgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+Pj4gT24gVGh1LCBKdW4gMDQsIDIwMjAg
YXQgMDE6NTY6MDFQTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4+IFdoZW4gYSBj
b250cm9sbGVyIHJlc2V0IGhhcHBlbnMgZHVyaW5nIHNjYW5uaW5nIG52bWVfaWRlbnRpZnlfbnMo
KQo+Pj4+IHdpbGwgYmUgYWJvcnRlZCwgYnV0IHRoZSBzdWJzZXF1ZW50IGNhbGwgdG8gbnZtZV9p
ZGVudGlmeV9uc19kZXNjcygpCj4+Pj4gd2lsbCBzdGFsbCBhcyBpdCB3aWxsIG9ubHkgYmUgY29t
cGxldGVkIG9uY2UgdGhlIGNvbnRyb2xsZXIgcmVjb25uZWN0Cj4+Pj4gaXMgZmluaXNoZWQuCj4+
Pgo+Pj4gSWYgbnZtZV9pZGVudGlmeV9ucygpIGlzIGFib3J0ZWQsIHNob3VsZG4ndCB3ZSBub3Qg
cHJvY2VlZCB0byB0aGUgbmV4dAo+Pj4gY29tbWFuZD8gSXQgbG9va3MgbGlrZSB0aGUgY29kZSBh
bHJlYWR5IGRvZXMgdGhhdCwgZnJvbSBudm1lX2FsbG9jX25zKCk6Cj4+Pgo+Pj4gCXJldCA9IG52
bWVfaWRlbnRpZnlfbnMoY3RybCwgbnNpZCwgJmlkKTsKPj4+IAlpZiAocmV0KQo+Pj4gCQlnb3Rv
IG91dF9mcmVlX3F1ZXVlOwo+Pj4KPj4+IEFuZCB0aGVuIGZyb20gbnZtZV9yZXZhbGlkYXRlX2Rp
c2soKToKPj4+Cj4+PiAJcmV0ID0gbnZtZV9pZGVudGlmeV9ucyhjdHJsLCBucy0+aGVhZC0+bnNf
aWQsICZpZCk7Cj4+PiAJaWYgKHJldCkKPj4+IAkJZ290byBvdXQ7Cj4+Pgo+Pj4gVGhvc2UgYXJl
IHRoZSBvbmx5IHR3byBwYXRocyB0byBudm1lX2lkZW50aWZ5X25zX2Rlc2NzKCksIHNvIGl0IGxv
b2tzCj4+PiBsaWtlIG52bWVfaWRlbnRpZnlfbnMoKSBtdXN0IGJlIHN1Y2Nlc3NmdWwgaW4gb3Jk
ZXIgdG8gZ2V0IHRoZXJlLgo+Pj4KPj4KPj4gVHJ1ZS4gQnV0IGlmIHRoZSBjb250cm9sbGVyIGlz
IGVudGVyaW5nIHJlc2V0IGp1YXQgX2FmdGVyXyB0aGUgY2FsbCB0bwo+PiBudm1lX2lkZW50aWZ5
X25zKCkgdGhlcmUgd29uJ3QgYmUgYW55IEkvTyB0byBhYm9ydCwgYW5kIHRoZSBzY2FubmluZyBj
b2RlCj4+IHdpbGwgcHJvY2VlZCB0byBjYWxsIG52bWVfcmVwb3J0X25zX2lkcygpIGV4cG9zaW5n
IHRoaXMgaXNzdWUuCj4+Cj4+Pj4gQnV0IGFzIHRoZSByZWNvbm5lY3Qgd2FpdHMgZm9yIHNjYW5u
aW5nIHRvIGNvbXBsZXRlIHRoZSBwYXJ0aWN1bGFyCj4+Pj4gbmFtZXNwYWNlIHdpbGwgZGVhZGxv
Y2sgYW5kIG5ldmVyIHJlY29ubmVjdGVkIGFnYWluLgo+Pj4KPj4+IFRoZSBmaXggbG9va3MgYSBi
aXQgZnJhZ2lsZS4gV2hhdCBpZiB0aGUgY29udHJvbGxlciBpcyByZXNldCBpbW1lZGlhdGVseQo+
Pj4gYWZ0ZXIgdGhlIGNoZWNrIGZvciBsaXZlPyBJdCdkIGJlIHNhZmVyIHN1Y2ggdGhhdCByZWNv
bm5lY3QgZGlkbid0IGhhdmUKPj4+IHRvIHdhaXQgZm9yIHNjYW5fd29yaywgbm8/ICBUaGUgcGNp
IHRyYW5zcG9ydCBoYXMgbm8gc3VjaCBkZXBlbmRlbmN5LAo+Pj4gZm9yIGV4YW1wbGUuCj4+Pgo+
PiBPaCwgdGhhdCB3b3VsZG4ndCBtYXR0ZXI7IG9uY2UgdGhlIGNvbnRyb2xsZXIgaXMgcmVzZXQg
KGllIGVudGVycyBhIG5vbi1MSVZFCj4+IHN0YXRlKSBhbGwgb3V0c3RhbmRpbmcgSS9PIGlzIGFi
b3J0ZWQuCj4+Cj4+IFRoZSBwb2ludCBoZXJlIGlzIHRoYXQgb25seSBfb3V0c3RhbmRpbmdfIEkv
TyBpcyBhYm9ydGVkLgo+PiBJZiB0aGUgc2NhbiB0aHJlYWQgY29udGludWVzIHNlbmRpbmcgSS9P
IGFmdGVyIHRoYXQgdGhpbmdzIHN0YWxsLgo+IAo+IE15IGNvbmNlcm4gaXMgaWYgdGhlIGNvbnRy
b2xsZXIgaXMgTElWRSBhdCB0aGUgbW9tZW50IG9mIHlvdXIgbmV3IGNoZWNrLAo+IGJ1dCBpcyBy
ZXNldCBpbW1lZGlhdGVseSBhZnRlciB0aGF0LCBhbmQgYmVmb3JlIHRoZSBpZGVudGlmeSBjb21t
YW5kIGlzCj4gc2VudC4gVGhlIGlkZW50aWZ5IHdvbid0IGJlIGFib3J0ZWQgc2luY2UgaXQgaGFz
bid0IGJlZW4gZGlzcGF0Y2hlZCB5ZXQuCj4gV291bGQgdGhhdCBnZXQgZXZlcnl0aGluZyBzdHVj
ayBhZ2Fpbj8KPiAKWWVzLCBidXQgdGhhdCdzIHF1aXRlIHVubGlrZWx5LgpPciwgdG8gYmUgcHJl
Y2lzZSwgdGhlIGxpa2VseWhvb2Qgb2YgYW55dGhpbmcgdHJpZ2dlcmluZyB0aGUgc3RhdGUgCmNo
YW5nZSBhZnRlciB0aGF0IHRlc3QgaXMgaGlnaGx5IHVubGlrZWx5LCBhcyB0aGVyZSBpcyBub3Ro
aW5nIHdoaWNoIApjb3VsZCBoYXZlIHRyaWdnZXJlZCBpdC4gUmVtZW1iZXIsIHdlIGFyZSBjdXJy
ZW50bHkgc2Nhbm5pbmcgdGhlIHNhbWUgCm5hbWVzcGFjZSBmb3Igd2hpY2ggYSBmYXVsdCBoYXMg
YmVlbiBkZXRlY3RlZC4gV2hpY2ggbWVhbnMgdGhhdCB0aGVyZSAKY2Fubm90IGFueSBvdGhlciBJ
L08gYmVpbmcgc2VudCB0byB0aGlzIG5hbWVzcGFjZSAoYXMgaXQncyBub3QgdmlzaWJsZSAKeWV0
IHRvIHVzZXJsYW5kKSBidXQgdGhlIEkvTyBnZW5lcmF0ZWQgZHVyaW5nIHNjYW5uaW5nIGl0c2Vs
Zi4KQW5kIHRoZSBzdGF0ZSBjaGFuZ2Ugd2lsbCBiZSBoYXBwZW5pbmcgZHVyaW5nIGVuZGlvIGhh
bmRsaW5nLCBzbyBieSB0aGUgCnRpbWUgd2UncmUgY2hlY2tpbmcgdGhlIHN0YXRlIGFueSBzdGF0
ZSBjaGFuZ2UgaGFzIGFscmVhZHkgaGFwcGVuZWQuCgpXaGlsZSB0aGVyZSBtaWdodCBibyBvdGhl
ciBuYW1lc3BhY2VzIHVzaW5nIHRoZSBzYW1lIHBoeXNpY2FsIApjb25uZWN0aW9uLCBhbmQgdGhl
c2UgbmFtZXNwYWNlcyBtaWdodCBkZXZlbG9wIGEgZmF1bHQsIHRvbywgdGhpcyBldmVudCAKd291
bGQgdGhlbiBzaWduYWxsZWQgdmlhIEFFTnMsIGFuZCB3b3VsZCBoYW5kbGVkIGluIGEgY29tcGxl
dGVseSAKZGlmZmVyZW50IHRocmVhZC4gU28gdGhpcyBzY2VuYXJpbyBzaG91bGRuJ3QgbWF0dGVy
IGZvciB0aGlzIHBhcnRpY3VsYXIgCm5hbWVzcGFjZS4KClNvIEkgY2FuJ3Qgc2VlIGhvdyB0aGUg
c3RhdGUgY2hhbmdlIHNob3VsZCBvY2N1ciBhZnRlciB0aGF0IHRlc3QuCgpDaGVlcnMsCgpIYW5u
ZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICBUZWFtbGVhZCBTdG9yYWdlICYg
TmV0d29ya2luZwpoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5
IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bD
vGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
