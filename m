Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E60C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:47:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8E12070B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l0nSw7wI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FrIf7y5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8E12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mXCbzlmEYVvORK4mTkW2HDpy8eNXeK1JsNUdkOkgbRc=; b=l0nSw7wIi3QEYVKxhdceeV96f
	LgTXCnFfgUvBDljb5ZMS+ZJEoLXIIffVMRH0xEYpJRZ3LEp8b7lN2PdJ4smU/RBqK+wXqsYt7nT8z
	LJl7XG1ZfTtuG63jcpkJjiEU2UmozOwMozIAJzJPCFP6COioFhC1J/ZI4KPaJX95DWTRcwKdXItKU
	UCs0Ufh68crvE5xstL/BM8A/8TWLRaX+agWLh+a8nGDfBsoTcV5HdiOBgnGu4GFKe+AxmFpnvP+Mm
	Doq3XnWpkU5Or4J8RSlcK1R/CPGbGXEFZTGSj9wLjtGG2PQiM0yXGYSHB3/r044NGkldTMXBrnzhb
	dNCRPOUsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibuTL-0000Hc-BK; Mon, 02 Dec 2019 22:47:15 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibuTI-0000Gv-8O
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 22:47:14 +0000
Received: by mail-wr1-x444.google.com with SMTP id b6so1366549wrq.0
 for <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2019 14:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=rEKj1/Y2cXdJcsInMlAIZYzcUE6t3PaYQfbx4DuDGJs=;
 b=FrIf7y5EEZiR3NHpsXmH7WL7xFChVIGoZK0J4axYDqP+2T1bqKoMN0F4p4UBkJUvoO
 xul/dm81AsiswCySLdeHyi2NPJfSeOq+ohlVqcIv/u90mq9XJ5TRJnoSxSy/u1KGE9wk
 iJTdXNshIrucTL/5ZyHuxH9z9wA8OHDYIFMD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rEKj1/Y2cXdJcsInMlAIZYzcUE6t3PaYQfbx4DuDGJs=;
 b=g5Bk+J1qzOvULgmyN9W1vbWr7fcU7nBOzKSERgWgMtHZGnQIR0q4h6cgyH3aw4MQ2d
 d+wDIyH0b3txEMgDNXW9u7C1lAHawFGrIBup+rFK2oSCkQmaw7A6eKfkEHS7iA7M15jj
 JZ61MMEK6q7tq4yOJPur0QMJuujTgAEenRugIoHwYbBtsfo8DUOHp3XLyA4RxwYjWFIg
 w+wCxBNreMUEKyMzC98YeQ1GzxQxuLuUQzA1dNwpcTNmP/52Pha5WRvxs0Lc68S3/5c+
 ZKMDN3JkGCcjEauHdKaTarjr3uTQ/HfHXkisTYw5ZGzSyLSKO4a8D5dmbd4g24P2TNug
 DUYQ==
X-Gm-Message-State: APjAAAXE+7hXgjGLvFGltfIFNetXczv341ustyvJu9YNSIJErmTfJxzR
 UblG279eYRexQqEEjo8CRAvpVBc32EfdcuJ1XJwFU+Z2LzLLv4Fr0OXPe3sndW69KWT2bcKEDZX
 2EjGi+6PKHJnZmZmkKz72lI+S8OJhLQKonD7wkjSSmJfTwJ1u+HqH3Wl6A5Gks5MDbllyNaMuSW
 19Mghoug==
X-Google-Smtp-Source: APXvYqyuVXJisjtRhe2TBuYyr84Mh/SZZ/wwR5m75opfMuRwOqCTjMvHyGEstBWxRON910hrnVhr1A==
X-Received: by 2002:adf:ec48:: with SMTP id w8mr1562008wrn.19.1575326830166;
 Mon, 02 Dec 2019 14:47:10 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id u18sm1075410wrt.26.2019.12.02.14.47.09
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Dec 2019 14:47:09 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: reject I/O to offline device
To: linux-nvme@lists.infradead.org
References: <2caa40133c444771b706406b928ad88a@kioxia.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <78d980de-b2b8-bd47-fc3f-20314653598e@broadcom.com>
Date: Mon, 2 Dec 2019 14:47:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <2caa40133c444771b706406b928ad88a@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_144712_301422_AA078B9E 
X-CRM114-Status: GOOD (  20.07  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMzAvMjAxOSAxMTo1OSBQTSwgVmljdG9yIEdsYWRrb3Ygd3JvdGU6Cj4gSXNzdWUgRGVz
Y3JpcHRpb246Cj4gQ29tbWFuZHMgZ2V0IHN0dWNrIHdoaWxlIEhvc3QgTlZNZSBjb250cm9sbGVy
IChUQ1Agb3IgUkRNQSkgaXMgaW4gcmVjb25uZWN0IHN0YXRlLgo+IE5WTWUgY29udHJvbGxlciBl
bnRlcnMgaW50byByZWNvbm5lY3Qgc3RhdGUgd2hlbiBpdCBsb3NlcyBjb25uZWN0aW9uIHdpdGgg
dGhlIHRhcmdldC4gSXQgdHJpZXMgdG8gcmVjb25uZWN0IGV2ZXJ5IDEwIHNlY29uZHMgKGRlZmF1
bHQpIHVudGlsIHN1Y2Nlc3NmdWwgcmVjb25uZWN0aW9uIG9yIHVudGlsIHJlY29ubmVjdCB0aW1l
LW91dCBpcyByZWFjaGVkLiBUaGUgZGVmYXVsdCByZWNvbm5lY3QgdGltZSBvdXQgaXMgMTAgbWlu
dXRlcy4KPiBUaGlzIGJlaGF2aW9yIGlzIGRpZmZlcmVudCB0aGFuIElTQ1NJIHdoZXJlIENvbW1h
bmRzIGR1cmluZyByZWNvbm5lY3Qgc3RhdGUgcmV0dXJucyB3aXRoIHRoZSBmb2xsb3dpbmcgZXJy
b3I6ICJyZWplY3RpbmcgSS9PIHRvIG9mZmxpbmUgZGV2aWNlIgo+Cj4gRml4IERlc2NyaXB0aW9u
Ogo+IEFkZGVkIGEga2VybmVsIG1vZHVsZSBwYXJhbWV0ZXIgIm52bWVmX3JlY29ubmVjdF9mYWls
ZmFzdCIgZm9yIG52bWUtZmFicmljcyBtb2R1bGUgKGRlZmF1bHQgaXMgdHJ1ZSkuCj4gSW50ZXJm
ZXJlIGluIHRoZSBkZWNpc2lvbiB3aGV0aGVyIHRvIHF1ZXVlIElPIGNvbW1hbmQgb3IgcmV0cnkg
SU8gY29tbWFuZC4gVGhlIGludGVyZmFjZSB0YWtlcyBpbnRvIGFjY291bnQgdGhlIGNvbnRyb2xs
ZXIgcmVjb25uZWN0IHN0YXRlLCBpbiBhIHdheSB0aGF0IGR1cmluZyByZWNvbm5lY3Qgc3RhdGUs
IElPIGNvbW1hbmRzIHNoYWxsIGZhaWwgaW1tZWRpYWN5IChkZWZhdWx0KSBvciBhY2NvcmRpbmcg
dG8gSU8gY29tbWFuZCB0aW1lb3V0IChkZXBlbmRzIG9uIHRoZSBtb2R1bGUgcGFyYW1ldGVyIHZh
bHVlKSwgYW5kIElPIHJldHJ5IGlzIHByZXZlbnRlZC4gQXMgYSByZXN1bHQsIGNvbW1hbmRzIGRv
IG5vdCBnZXQgc3R1Y2sgaW4gaW4gcmVjb25uZWN0IHN0YXRlLgoKVGhpcyB0aGUgcGF0Y2ggc2Vl
bXMgaW5jb3JyZWN0IGF0IGxlYXN0IGFzIGRlc2NyaWJlZC4gTXVsdGlwYXRoaW5nIAppbmhlcmVu
dGx5IHdpbGwgImZhc3RmYWlsIiBhbmQgc2VuZCB0byBvdGhlciBwYXRocy4gU28gdGhlIG9ubHkg
d2F5IApzb21ldGhpbmcgaXMgInN0dWNrIiBpcyBpZiBpdCdzIGxhc3QgcGF0aC4gSWYgbGFzdCBw
YXRoLCB3ZSBkZWZpbml0ZWx5IApkb24ndCB3YW50IHRvIHByZW1hdHVyZWx5IHJlbGVhc2UgaS9v
IGJlZm9yZSB3ZSd2ZSBnaXZlbiB0aGUgc3Vic3lzdGVtIApldmVyeSBvcHBvcnR1bml0eSB0byBy
ZWNvbm5lY3QuCgpXaGF0IEkgaGVhciB5b3Ugc2F5aW5nIGlzIHlvdSBkb24ndCBsaWtlIHRoZSBr
ZXJuZWwgZGVmYXVsdCAKY29udHJvbGxlci1sb3NzLXRpbWVvdXQgb2YgNjAwcy4gV2hhdCB3YXMg
ZGVzaWduZWQsIGlmIHlvdSBkaWRuJ3QgbGlrZSAKdGhlIGtlcm5lbCBkZWZhdWx0LCB3YXMgdG8g
dXNlIHRoZSBwZXItY29ubmVjdGlvbiAiLS1jbHRyLWxvc3MtdG1vIiAKb3B0aW9uIGZvciAibnZt
ZSBjb25uZWN0Ii7CoCBUaGUgYXV0by1jb25uZWN0IHNjcmlwdHMgb3IgdGhlIGFkbWluIHNjcmlw
dCAKdGhhdCBzcGVjaWZpZXMgdGhlIGNvbm5lY3Rpb24gY2FuIHNldCB3aGF0ZXZlciB2YWx1ZSBp
dCBsaWtlcy4KCklmIHRoYXQgc2VlbXMgaGFyZCB0byBkbywgcGVyaGFwcyBpdCdzIHRpbWUgdG8g
aW1wbGVtZW50IHRoZSBvcHRpb25zIAp0aGF0IGFsbG93IGZvciBhIGNvbmZpZyBmaWxlIHRvIHNw
ZWNpZnkgbmV3IHZhbHVlcyB0byBiZSB1c2VkIG9uIGFsbCAKY29ubmVjdGlvbnMsIG9yIG9uIGNv
bm5lY3Rpb25zIHRvIHNwZWNpZmljIHN1YnN5c3RlbXMsIGFuZCBzbyBvbi4gQnV0IEkgCmRvbid0
IHRoaW5rIHRoZSBrZXJuZWwgbmVlZHMgdG8gY2hhbmdlLgoKLS0gamFtZXMKCgoKPgo+IGJyYW5j
aCBudm1lLTUuNQo+Cj4gLS0tCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJp
Y3MuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+IGluZGV4IDc0Yjg4MTguLmVmODlh
ZmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4gKysrIGIvZHJp
dmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4gQEAgLTEzLDYgKzEzLDEwIEBACj4gICAjaW5jbHVk
ZSAibnZtZS5oIgo+ICAgI2luY2x1ZGUgImZhYnJpY3MuaCIKPgo+ICtzdGF0aWMgYm9vbCBudm1l
Zl9yZWNvbm5lY3RfZmFpbGZhc3QgPSAxOwo+ICttb2R1bGVfcGFyYW1fbmFtZWQobnZtZWZfcmVj
b25uZWN0X2ZhaWxmYXN0LCBudm1lZl9yZWNvbm5lY3RfZmFpbGZhc3QsIGJvb2wsIFNfSVJVR08p
Owo+ICtNT0RVTEVfUEFSTV9ERVNDKG52bWVmX3JlY29ubmVjdF9mYWlsZmFzdCwgImZhaWxmYXN0
IGZsYWcgZm9yIEkvTyB3aGVuIGNvbnRyb2xlciBpcyByZWNvbm5lY3RpbmcsIGVsc2UgdXNlIEkv
TyBjb21tYW5kIHRpbWVvdXQgKGRlZmF1bHQgdHJ1ZSkuIik7Cj4gKwo+ICAgc3RhdGljIExJU1Rf
SEVBRChudm1mX3RyYW5zcG9ydHMpOwo+ICAgc3RhdGljIERFQ0xBUkVfUldTRU0obnZtZl90cmFu
c3BvcnRzX3J3c2VtKTsKPgo+IEBAIC01NDksNiArNTUzLDcgQEAgYmxrX3N0YXR1c190IG52bWZf
ZmFpbF9ub25yZWFkeV9jb21tYW5kKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsCj4gICB7Cj4gICAg
ICAgICAgaWYgKGN0cmwtPnN0YXRlICE9IE5WTUVfQ1RSTF9ERUxFVElORyAmJgo+ICAgICAgICAg
ICAgICBjdHJsLT5zdGF0ZSAhPSBOVk1FX0NUUkxfREVBRCAmJgo+ICsgICAgICAgICAgICEoY3Ry
bC0+c3RhdGUgPT0gTlZNRV9DVFJMX0NPTk5FQ1RJTkcgJiYgKCgoa3RpbWVfZ2V0X25zKCkgLSBy
cS0+c3RhcnRfdGltZV9ucykgPiBqaWZmaWVzX3RvX25zZWNzKHJxLT50aW1lb3V0KSkgfHwgbnZt
ZWZfcmVjb25uZWN0X2ZhaWxmYXN0KSkgJiYKPiAgICAgICAgICAgICAgIWJsa19ub3JldHJ5X3Jl
cXVlc3QocnEpICYmICEocnEtPmNtZF9mbGFncyAmIFJFUV9OVk1FX01QQVRIKSkKPiAgICAgICAg
ICAgICAgICAgIHJldHVybiBCTEtfU1RTX1JFU09VUkNFOwo+Cj4KPiBSZWdhcmRzLAo+IFZpY3Rv
cgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGxpbnV4LW52bWUgbWFpbGluZyBsaXN0Cj4gbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
