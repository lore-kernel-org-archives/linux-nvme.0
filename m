Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27229C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15FE23428
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RYb/R3xB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15FE23428
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WYneTfIXKjbDj6DYxSggCX+nk5gzuPv/ABo+73nEV5s=; b=RYb/R3xBiL6h7NR5I+fAbTe9A
	+u7myYQUUddZgEYXva9aHsCLbb/k0/IWB5wJ0pJGPHN30V020mv/EuDle3m3Ls8J/PEvGqg2Aq8vn
	2pMMi4bavowEiQw5MaTZKir8KNNAwGpmiKQir5LEPTvF2N+xZpdlGkugYjyEMEKrc+byD5zn6MDRt
	sYZNAyZre3g8HaZHShs1szB03iFPjK4R1Nzeo4kBiIyRRKqDYdjnCL2stVxXfGGmKxYpj2dylhgto
	73YsQQuMCZGUa+wlky+sN56su85fTMQWfzgHylO/sFQ1JKeARIivIaRBeGMLqqexPl1WfUD+tlkGc
	St9kCmqsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3lfh-0001NT-GT; Fri, 30 Aug 2019 18:30:53 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3lfe-0001N8-JY
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:30:52 +0000
Received: by mail-ot1-f67.google.com with SMTP id o101so7789455ota.8
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 11:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PInelPdT9KKxrPoFYtrG98b3FVmUZo/rDbU/vk8LrdY=;
 b=s73OR/DbgR7SynxSBKjSzzCylkUSQjCEH+OfmudI7TkSkftWzSAtHKCm54e7hKQ5N0
 0HF5E1wTYmMlZkx/8Sejm6QCTdPTqkvHjBpUyTaMsDU+lNngB/ZbQtfNi2nI5OR0BB6l
 6aGpJ3qTvurTiUdeejUe9xCffWH7Q0yoQEm28VxJTS77Dn+4yRSFWAdiq4fQeN0V/p6U
 hCrf8a5sl6KUwKMos6vV2gf9xOcV5d7CFMfWNCQXWqhQVcVai+F2wiwSFBTKAaN1DH8E
 19BbEDFoxT4bGID/+A4uTZwX4XPOu6drVAUzcHQyQbxRjB8eamp6nje7S7e/fArKz9qz
 SiqA==
X-Gm-Message-State: APjAAAVMXQLImMRl4G9tiB4vPkzhC8YCB2fSKXf6cYyFMYXly52/UEFI
 0FwxzeIrB8ZRCVijea9CamKKSVl5
X-Google-Smtp-Source: APXvYqxkKeVQE/APXznoTuosp54GQuN2ISHrwB6zkrIW6XDC9Td6C7ZkfnTDakuSkv4BX1J7TJluMA==
X-Received: by 2002:a9d:b82:: with SMTP id 2mr14193844oth.170.1567189848972;
 Fri, 30 Aug 2019 11:30:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id q11sm2209575otn.50.2019.08.30.11.30.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 11:30:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: validate cntlid during controller initialisation
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
 hare@suse.de
References: <20190513062510.756-1-hch@lst.de> <20190513062510.756-3-hch@lst.de>
 <749191be-9521-8a49-7fc9-a1a3a659f51b@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a9975353-f367-999d-f00e-b967e96a0fcf@grimberg.me>
Date: Fri, 30 Aug 2019 11:30:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <749191be-9521-8a49-7fc9-a1a3a659f51b@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_113050_648844_58B08AB9 
X-CRM114-Status: GOOD (  25.71  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gT24gNS8xMi8yMDE5IDExOjI1IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gVGhl
IENOVExJRCB2YWx1ZSBpcyByZXF1aXJlZCB0byBiZSB1bmlxdWUsIGFuZCB3ZSBkbyByZWx5IG9u
IHRoaXMKPj4gZm9yIGNvcnJlY3Qgb3BlcmF0aW9uLiBTbyByZWplY3QgYW55IGNvbnRyb2xsZXIg
Zm9yIHdoaWNoIGEgbm9uLXVuaXF1ZQo+PiBDTlRMSUQgaGFzIGJlZW4gZGV0ZWN0ZWQuCj4+Cj4+
IEJhc2VkIG9uIGEgcGF0Y2ggZnJvbSBIYW5uZXMgUmVpbmVja2UuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25z
KC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKPj4gaW5kZXggNzBhMmJjMDFlNDFlLi4wOWExZDVjYTg3MmYgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKPj4gQEAgLTIzNDEsMjAgKzIzNDEsMzUgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgCj4+ICpudm1lX3N1YnN5c19hdHRyc19ncm91cHNbXSA9IHsK
Pj4gwqDCoMKgwqDCoCBOVUxMLAo+PiDCoCB9Owo+PiAtc3RhdGljIGludCBudm1lX2FjdGl2ZV9j
dHJscyhzdHJ1Y3QgbnZtZV9zdWJzeXN0ZW0gKnN1YnN5cykKPj4gK3N0YXRpYyBib29sIG52bWVf
dmFsaWRhdGVfY250bGlkKHN0cnVjdCBudm1lX3N1YnN5c3RlbSAqc3Vic3lzLAo+PiArwqDCoMKg
wqDCoMKgwqAgc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52bWVfaWRfY3RybCAqaWQp
Cj4+IMKgIHsKPj4gLcKgwqDCoCBpbnQgY291bnQgPSAwOwo+PiAtwqDCoMKgIHN0cnVjdCBudm1l
X2N0cmwgKmN0cmw7Cj4+ICvCoMKgwqAgc3RydWN0IG52bWVfY3RybCAqdG1wOwo+PiDCoMKgwqDC
oMKgIGxvY2tkZXBfYXNzZXJ0X2hlbGQoJm52bWVfc3Vic3lzdGVtc19sb2NrKTsKPj4gLcKgwqDC
oCBsaXN0X2Zvcl9lYWNoX2VudHJ5KGN0cmwsICZzdWJzeXMtPmN0cmxzLCBzdWJzeXNfZW50cnkp
IHsKPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChjdHJsLT5zdGF0ZSAhPSBOVk1FX0NUUkxfREVMRVRJ
TkcgJiYKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3RybC0+c3RhdGUgIT0gTlZNRV9DVFJM
X0RFQUQpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvdW50Kys7Cj4+ICvCoMKgwqAgbGlz
dF9mb3JfZWFjaF9lbnRyeSh0bXAsICZzdWJzeXMtPmN0cmxzLCBzdWJzeXNfZW50cnkpIHsKPj4g
K8KgwqDCoMKgwqDCoMKgIGlmIChjdHJsLT5zdGF0ZSA9PSBOVk1FX0NUUkxfREVMRVRJTkcgfHwK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3RybC0+c3RhdGUgPT0gTlZNRV9DVFJMX0RFQUQp
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiArCj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAodG1wLT5jbnRsaWQgPT0gY3RybC0+Y250bGlkKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRldl9lcnIoY3RybC0+ZGV2aWNlLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICJEdXBsaWNhdGUgY250bGlkICV1IHdpdGggJXMsIHJlamVjdGluZ1xuIiwKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsLT5jbnRsaWQsIGRldl9uYW1lKHRt
cC0+ZGV2aWNlKSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPj4g
K8KgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmICgoaWQtPmNtaWMgJiAoMSA8
PCAxKSkgfHwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGN0cmwtPm9wdHMgJiYgY3RybC0+
b3B0cy0+ZGlzY292ZXJ5X25xbikpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29udGludWU7Cj4gCj4gRG8gd2UgaGF2ZSBhIHByb2JsZW0gaGVyZcKgIGlmIHRoZSBzdWJzeXN0
ZW0gaXMgYSBkaXNjb3ZlcnkgY29udHJvbGxlciBucW4gPwo+IAo+IEFzc3VtZSB3ZSBoYXZlIGEg
Y29ubmVjdGlvbiB0byBhIGRpc2NvdmVyeSBjb250cm9sbGVyIGluIHBsYWNlIChpdCBoYXMgCj4g
YmVlbiBjcmVhdGVkLCBpcyBpbiB0aGUgbWlkc3Qgb2YgcmVhZGluZyB0aGUgZGlzY292ZXJ5IGxv
Zzsgb3IgYSAKPiBsb25nLWxpdmVkIGRpc2NvdmVyeSBjb250cm9sbGVyKSBhbmQgYSBuZXcgb25l
IGlzIGJlaW5nIG1hZGUuwqAgVGhlIG5ldyAKPiBvbmUgY291bGQgYmUgb24gY29tcGxldGVseSBk
aWZmZXJlbnQgdHJhbnNwb3J0IG9yIGRpZmZlcmVudCAKPiBob3N0L3N1YnN5c3RlbSBwb3J0czoK
PiAKPiBJdCBsb29rcyBsaWtlIF9fbnZtZV9maW5kX2dldF9zdWJzeXN0ZW0oKSB3aGVuIGNhbGxl
ZCB3aXRoIHRoZSBkaXNjb3ZlcnkgCj4gbnFuIHdpbGwgbWF0Y2ggdGhlIHN1YnN5c3RlbSBmb3Ig
dGhlIGV4aXN0aW5nIGRpc2NvdmVyeSBjb250cm9sbGVyLCAKPiB3aGljaCB0aGVuIGZvcmNlcyB0
aGUgY2FsbCB0byBudm1lX3ZhbGlkYXRlX2NudGxpZCgpLCB3aGljaCB3aWxsIGZpbmQgYSAKPiBs
aXZlIGNvbnRyb2xsZXIgYW5kIGl0J3MgdmVyeSBwb3NzaWJsZSB0aGF0IGNvbnRyb2xsZXIgaWQg
Y2FuIGJlIAo+IGRpZmZlcmVudC4gVGhlIHJlcXVpcmVtZW50IGZvciBzYW1lbmVzcyBkb2VzIG5v
dCBhcHBseSB0byB0aGUgZGlzY292ZXJ5IAo+IGNvbnRyb2xsZXIgLSBzbyBpdCBzaG91bGRuJ3Qg
YmUgcmV0dXJuaW5nIGZhaWx1cmUgaW4gdGhpcyBjYXNlLsKgwqAgQWdyZWUgPwo+IAo+IFdoYXQn
cyB0aGUgYmVzdCBwYXRjaCB0byBhdm9pZCB0aGlzID8KPiAtIGNoYW5nZSBfX252bWVfZmluZF9n
ZXRfc3Vic3lzdGVtKCkgc28gdGhhdCBpZiBkaXNjb3ZlcnkgbnFuLCBpdCB0cmVhdHMgCj4gaXQg
YXMgYSBzZXBhcmF0ZSBzdWJzeXN0ZW0gPwo+IC0gY2hhbmdlIG52bWVfdmFsaWRhdGVfY250bGlk
KCkgc3VjaCB0aGF0ICIoY3RybC0+b3B0cyAmJiAKPiBjdHJsLT5vcHRzLT5kaXNjb3ZlcnlfbnFu
KSIgaXMgYWRkZWQgdG8gdGhlIGN0cmwgc3RhdGUgY2hlY2tzIGFib3ZlIHRoaXMgCj4gdGVzdCA/
CgpZZXMsIHlvdSdyZSByaWdodCwgd2Ugc2hvdWxkIGFsbG93IHRoaXMgZm9yIHRoZSBkaXNjb3Zl
cnkgc3Vic3lzdGVtLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
