Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9703C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:50:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9CB60FD7
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E9CB60FD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXFqr6tJsOvCDfNqyt3z+ANlEuUT2OhGzQ0dq2Ct0oc=; b=AvAR+QuF27pTs7uM2IBlnt/ENM
	uVKbOzgCRSpuZE0YJcHuzHHkvPmkTy8hhdopEIQVWpiSiTemIdBDeEI+aBSJAaFQCzp5Pr94XnD/4
	/fNO5GySqqA7jc8D+9ZLH9r/jQek2D1k/aFdtIJXLHcV26MJDolaHyGnVaXuPGx5+l0sSEaMNeXGW
	ghfmE3x8RAwuJc1HfQy4IW9K+SfEpDPKMxjYh03jIlg07mkhDffL5FptlqlDbB+0+KUZXnhW1aFsK
	8hrvpfWdNf+K5T8O2NFtt3gfg6AQfzSs7MrUcfz+nOhrW6iGFneL2ROPqdprhDwhY/30+92N1WQq0
	oU2cgChg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2GV-004KDY-4k; Tue, 14 Sep 2021 06:49:59 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2GR-004KCb-Mq
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 06:49:57 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 l18-20020a05600c4f1200b002f8cf606262so1163431wmq.1
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 23:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xf1/4b7ATlw99iunKN4SNCd4hP2t8SkpIPyupKMjg+Y=;
 b=PCGzDCzaZPRJVzNYF4x1FkCc6iPaAdCGvjwhbjQ7I+xXrETU9rRl/a1YcDHba39D3U
 9Tp4YoE1gLjnXvlZZno6rDQeWkm692E7bObS+xifmrj5IYWVtLHJn371PqPqENibOOmy
 zcXlL7IUvkknGKe2Bdje+vJlwJW3FsRmR6oegS7kNlIBRTlPFUR8dYAc68w3Y55Sg+ky
 nJmwehcrHkxsTwCYPhLH4En5ct86n6Ihr2xKJ8vmhKDMHDav8cOZjQkaDXYl6WzoTjLP
 ttUVQ++RXZ84Yb5aSlcEuwE87gdRNBzY5iU7bjPxHct0sJmJK8+DFjvAXr4rdlBlEkoX
 pAAQ==
X-Gm-Message-State: AOAM532LnMqpuOxss41kZB2qeN1Yr6qP75/X/pt1r6lV9eY5V/7kOdSB
 getZl3N9cIQNwEiC5iemYvRKyFRVwwk=
X-Google-Smtp-Source: ABdhPJwmTOZbp3sp20iOnDJ0O1vw1rCjun/TMNYERM4tMjdfvNwncCEj4rZ5I7gFZLwyAoC3h2HW9Q==
X-Received: by 2002:a05:600c:3ba3:: with SMTP id
 n35mr370674wms.166.1631602193604; 
 Mon, 13 Sep 2021 23:49:53 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id 20sm182089wme.46.2021.09.13.23.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 23:49:53 -0700 (PDT)
Subject: Re: [PATCH 1/2] Add 'gen-dhchap-key' command
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210913102415.19044-1-hare@suse.de>
 <20210913102415.19044-2-hare@suse.de>
 <a64c9dde-7c81-85d8-a1d5-5b691a2f99be@grimberg.me>
 <20a61ffc-e910-0a62-9248-9a573029ac08@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ff32b35b-1346-765b-def9-74656fda8cc3@grimberg.me>
Date: Tue, 14 Sep 2021 09:49:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20a61ffc-e910-0a62-9248-9a573029ac08@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_234955_867307_DDDCCEDC 
X-CRM114-Status: GOOD (  27.98  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IE9uIDkvMTMvMjEgMToyNCBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4gQWRkIGNv
bW1hbmQgJ2dlbi1kaGNoYXAta2V5JyB0byBnZW5lcmF0ZSBhbiBESC1ITUFDLUNIQVAgaG9zdCBr
ZXkKPj4+IGZvciBOVk1lIGluLWJhbmQgYXV0aGVudGljYXRpb24uCj4+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+Cj4+PiAtLS0KPj4+IMKgIERvY3Vt
ZW50YXRpb24vbnZtZS1nZW4tZGhjaGFwLWtleS50eHQgfMKgIDUyICsrKysrKysrKwo+Pj4gwqAg
TWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAxNyArKy0KPj4+IMKgIG52bWUtYnVpbHRpbi5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPj4+IMKgIG52bWUuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMTU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiDCoCB1dGlsL2FyZ2NvbmZp
Zy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+
Pj4gwqAgdXRpbC9iYXNlNjQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgNjIgKysrKysrKysrKysKPj4+IMKgIHV0aWwvYmFzZTY0LmjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArCj4+PiDC
oCA3IGZpbGVzIGNoYW5nZWQsIDI5MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+PiDC
oCBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9udm1lLWdlbi1kaGNoYXAta2V5LnR4
dAo+Pj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IHV0aWwvYmFzZTY0LmMKPj4+IMKgIGNyZWF0ZSBt
b2RlIDEwMDY0NCB1dGlsL2Jhc2U2NC5oCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vbnZtZS1nZW4tZGhjaGFwLWtleS50eHQgCj4+PiBiL0RvY3VtZW50YXRpb24vbnZtZS1nZW4t
ZGhjaGFwLWtleS50eHQKPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+PiBpbmRleCAwMDAwMDAw
Li5lZWNkZTc2Cj4+PiAtLS0gL2Rldi9udWxsCj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL252bWUt
Z2VuLWRoY2hhcC1rZXkudHh0Cj4+PiBAQCAtMCwwICsxLDUyIEBACj4+PiArbnZtZS1nZW4tZGhj
aGFwLWtleSgxKQo+Pj4gKz09PT09PT09PT09PT09PT09PT0KPj4+ICsKPj4+ICtOQU1FCj4+PiAr
LS0tLQo+Pj4gK252bWUtZ2VuLWRoY2hhcC1rZXkgLSBHZW5lcmF0ZSBhIGhvc3QgREgtSE1BQy1D
SEFQIGtleQo+Pj4gKwo+Pj4gK1NZTk9QU0lTCj4+PiArLS0tLS0tLS0KPj4+ICtbdmVyc2VdCj4+
PiArJ252bWUgZ2VuLWRoY2hhcC1rZXknIFstLWhtYWM9PGhtYWMtaWQ+IHwgLWggPGhtYWMtaWQ+
XQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFstLXNlY3JldD08c2VjcmV0PiB8IC1z
IDxzZWNyZXQ+IF0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBbLS1rZXktbGVuZ3Ro
PTxsZW4+IHwgLWwgPGxlbj4gXQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFstLW5x
bj08aG9zdC1ucW4+IHwgLW4gPGhvc3QtbnFuPiBdCj4+Cj4+IE1heWJlIGl0IGlzIGEgZ29vZCBp
ZGVhIHRvIGhhdmUgc29tZSBzYW5lIGRlZmF1bHRzIGNyZWF0ZQo+PiAvZXRjL252bWUvaG9zdGtl
eSB3aGVuIGluc3RhbGxpbmcgbnZtZS1jbGk/IE9yIHdpbGwgaXQKPj4gdGFrZSBpdCB1bmNvbmRp
dGlvbmFsbHk/Cj4+Cj4gVGhhdCB3YXMgdGhlIGlkZWE7IHdpbGwgcHV0IHNvbWUgc3RhdGVtZW50
cyBpbnRvIHRoZSBtYW4tcGFnZS4KPiBCdXQgJ2dlbi1kaGNoYXAta2V5JyBzaG91bGRuJ3QgYmUg
ZG9pbmcgaXQgYXV0b21hdGljYWxseSwgYnV0IHJhdGhlciAKPiBiZWhhdmUgc2ltaWxhciB0byAn
Z2VuLWhvc3RucW4nICh3aGljaCBhbHNvIG9ubHkgcHJpbnRzIG91dCB0aGUgaG9zdCBOUU4gCj4g
dG8gc3Rkb3V0LCBhbmQgbGVhdmVzIGlzIHRvIHRoZSBjYWxsZXIgdG8gZm9yd2FyZCB0aGF0IHRv
IAo+IC9ldGMvbnZtZS9ob3N0bnFuKS4KClllcywgYnV0IHdlIGFsc28gaW5zdGFsbCB0aGVzZSBm
aWxlcyB3aGVuIGluc3RhbGxpbmcgbnZtZS1jbGksCmxvb2sgYXQgdGhlIHNwZWMgYW5kIG1ha2Vm
aWxlIChpbnN0YWxsLWhvc3RwYXJhbXMgdGFyZ2V0KS4KCkhvd2V2ZXIgdGhpcyBvbmUgaXMgZGlm
ZmVyZW50IEkgdGhpbmsgYW5kIHdlIGRvbid0IHdhbnQgdG8gZ2VuZXJhdGUgaXQKYnkgZGVmYXVs
dC4KCj4+IE92ZXJhbGwgbG9va3MgZ29vZCwgZG8gd2Ugd2FudCB0byBhbGxvdyBkaWZmZXJlbnQg
aG9zdCBrZXlzCj4+IGZvciBkaWZmZXJlbnQgTlZNIHN1YnN5c3RlbXM/Cj4gCj4gU2lnaC4gSXQn
cyB0aGUgc2FtZSBpc3N1ZSBhcyB3ZSBjdXJyZW50bHkgaGF2ZSB3aXRoIGFsbG93aW5nIGRpZmZl
cmVudCAKPiBob3N0IE5RTnMgZm9yIHRoZSBzYW1lIHN5c3RlbS4KPiAKPiBJbiB0aGVvcnkgd2Ug
Y291bGQsIGFuZCB0aGVyZSBpcyBub3RoaW5nIGluIHRoZSBjdXJyZW50IGNvZGUgd2hpY2ggCj4g
Zm9yYmlkcyB1cyB0byBkbyBzby4gQnV0IHRvb2xpbmcgYXJvdW5kIGl0IHdpbGwgYmUgZ2V0dGlu
ZyBhcmJpdHJhcmlseSAKPiBjb21wbGV4OyByZW1lbWJlciwgaXQncyBub3Qgb25seSB0aGUgZGlm
ZmVyZW50IGhvc3Qga2V5cyBmb3IgZGlmZmVyZW50IAo+IE5WTSBzdWJzeXN0ZW1zLCBidXQgcG9z
c2libHkgYWxzbyB0aGUgdmFyaW91cyBOVk0gc3Vic3lzdGVtIGtleXMgaWYgCj4gc29tZW9uZSB3
ZXJlIHRvIGVuYWJsZSBiaS1kaXJlY3Rpb25hbCBhdXRoZW50aWNhdGlvbi4KClllZS4uLiBpdCB3
b24ndCBiZSBsb25nIHVudGlsIHdlJ2xsIGhlYXIgY29tcGxhaW50cyBvbiB0aGlzIG9uZS4KSSB0
aGluayB3ZSBuZWVkIHRvIGhhdmUgc29tZSBzaW1wbGUgZm9ybWF0IGxpa2U6CjxkZWZhdWx0Pjo8
ZGVmX2hvc3RrZXk+CjxzdWJzeXN0ZW0xPjo8aG9zdGtleTE+CjxzdWJzeXN0ZW0yPjo8aG9zdGtl
eTI+Ci4uLgoKQW5kIHdlIHdpbGwgbmVlZCAvZXRjL252bWUvc3Vic3lza2V5IGluIHRoZSBzYW1l
IGZvcm1hdDoKPGRlZmF1bHQ+OjxkZWZfc3Vic3lza2V5Pgo8c3Vic3lzdGVtMT46PHN1YnN5c2tl
eTE+CjxzdWJzeXN0ZW0yPjo8c3Vic3lza2V5Mj4KLi4uCgpBbmQgaWRlYWxseSB3ZSBhbHNvIGhh
dmUgYSB3YXkgZm9yIG52bWUtY2xpIHRvIHBvcHVsYXRlIGl0IGluIHRoaXMKZm9ybWF0IChvciBz
b21lIGhlbHBlciBzY3JpcHQgZm9yIGl0KS4KCj4gU28gd291bGQganVzdCBzdGljayB3aXRoIHRo
ZSBzaW1wbGUgY2FzZSwgYW5kIGxlYXZlIHRoaXMgYXMgYW4gZXhlcmNpc2UgCj4gdG8gdGhlIHJl
YWRlci4KCkRvbid0IGtub3cgaWYgdGhhdCBpcyBnb29kIGVub3VnaC4uLgpXaGF0IGRvIG90aGVy
cyB0aGluaz8KCj4gV2hpY2ggcmVtaW5kcyBtZTsgbWlnaHQgYmUgdGhhdCB0aGVyZSdzIGFuIHVw
ZGF0ZSByZXF1aXJlZCB0byBoYW5kbGUgCj4ga2V5cyBmb3IgYmktZGlyZWN0aW9uYWwgYXV0aGVu
dGljYXRpb24gLi4uIGhtbS4KClllcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
