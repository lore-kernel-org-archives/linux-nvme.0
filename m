Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16591C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 18:04:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D479C204EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 18:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JHvW1c2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D479C204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jr/vPnJvUmG05XJqJpZoUynPJ3KkNmGJFw8qC1Gg6j8=; b=JHvW1c2AM2WgTOw31ZMO2VeZu
	/QhJD0nBtb+SLjFe0Q6NKSnwZTWIO1lSAoL8yhh/qx3MivyM6rSb5+s9Ue0Fe0ogXd+COItguTjwJ
	lBQS731Y4siyalCZEpb+H3bXN01ha1EBmE+DEM5BmUDYX+OnxhcJDFkxeCxNn5J3bb2VpY//Owv7u
	MmyVeq9dZ3Dv76dML8xQFyOby97G3HCjhmU4PHkh2BflMVaFq1n2xAVAacn+pyBPvvGDrFafcehO6
	AqxiF8IJBEu3U6y+KO9sRj4lSIr+W09mzO2kTHxbjt8qfsphAl6XpydMrqVGDtLI0yciz/COgDwxs
	M+no2JlUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbT55-00087d-Fg; Wed, 20 May 2020 18:04:39 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbT51-00086u-Q5
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 18:04:38 +0000
Received: by mail-wr1-f67.google.com with SMTP id k13so4130016wrx.3
 for <linux-nvme@lists.infradead.org>; Wed, 20 May 2020 11:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B0KsSQIdENgCZuIifoLKmD8MRJHr0P5WATOsjBGCxFw=;
 b=GeYqpasFQCS1ic65MhPD0tXACTsqosObpmLP7pGCePqssTBoVIp1sonD2az67IkQb6
 rvDuThy0eEYrgFmj+TNRi7I+2npEDgRGiqrXs3JnyCBfduDFMfV7B+PIJdO1ssprlqOk
 j4BnbXLtUCN4AtgEG4HgDA3B0RIE4OTrHHgIlzZH+e8tHjDNMwj/F3nZp/+TTW2rTFh4
 6g+Lq0giD5LXcxbfL6nMBy+V+MwKcx8ioConnAIqsyHdFyysWmHsrFJecrCSz0GpdT4J
 05m2E3v765rLiNDc0Z24V8m8VrDOFwVVpw3ztwduH2bS2BLiL+JpfOo/tYtqcexNNy2l
 UJEQ==
X-Gm-Message-State: AOAM533tKjhdo5+27NPf8/V/YU/OHGcxHTsnrCuk/3OMFhelsxkjGhKV
 MwT8ifhTH3oDMjYcMCN2mZyw5rOxReI=
X-Google-Smtp-Source: ABdhPJyw7kk/lbhyt2isy8I80Mg9di+/7IL29UIty0u0VKRvrtT4SB4/fUSDQhaysgSFVqnhstDZqw==
X-Received: by 2002:a5d:4f81:: with SMTP id d1mr5468667wru.95.1589997872474;
 Wed, 20 May 2020 11:04:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:91e2:91f6:e321:5d4d?
 ([2601:647:4802:9070:91e2:91f6:e321:5d4d])
 by smtp.gmail.com with ESMTPSA id m65sm3918831wmm.17.2020.05.20.11.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 11:04:31 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining aens
 in nvmet_async_events_free
To: Christoph Hellwig <hch@infradead.org>
References: <388242d3-5ccc-d694-c7a0-ac489f63f26a@grimberg.me>
 <20200520061613.GA18308@infradead.org>
 <0018af56-e3f9-8730-3c57-c4f19e478014@grimberg.me>
 <20200520070330.GA26871@infradead.org>
 <d353aa1a-cef3-d2f6-66de-92cc18cd97aa@grimberg.me>
 <20200520071526.GA7008@infradead.org>
 <c0379f95-246a-3fd6-9ec9-4ee814562c8d@grimberg.me>
 <41bae172-289e-1407-93a6-4147491a346c@redhat.com>
 <20200520172741.GB22182@infradead.org>
 <df8d9a64-d7ff-b249-e5f9-c3b0cf092c4c@grimberg.me>
 <20200520174632.GA11265@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <38af0291-4d09-d8c4-59fe-2d642ddaaaa2@grimberg.me>
Date: Wed, 20 May 2020 11:04:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520174632.GA11265@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_110436_001688_963C08EB 
X-CRM114-Status: GOOD (  22.61  )
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
Cc: chaitanya.kulkarni@wdc.com, David Milburn <dmilburn@redhat.com>,
 dwagner@suse.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA1LzIwLzIwIDEwOjQ2IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBXZWQs
IE1heSAyMCwgMjAyMCBhdCAxMDo0MTo1NkFNIC0wNzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+
Pgo+Pgo+PiBPbiA1LzIwLzIwIDEwOjI3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+
IE9uIFdlZCwgTWF5IDIwLCAyMDIwIGF0IDA1OjM5OjE4QU0gLTA1MDAsIERhdmlkIE1pbGJ1cm4g
d3JvdGU6Cj4+Pj4gWWkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIHRoZSBtZW1sZWFrIHVzaW5nIHRo
ZSB2MiBvZiB0aGUgcGF0Y2ggc2VyaWVzCj4+Pj4gc2luY2UgbnZtZXRfYXN5bmNfZXZlbnRzX2Zy
ZWUoKSByYW4gYmVmb3JlIG52bWV0X2FkZF9hc3luY19ldmVudCgpLgo+Pj4+Cj4+Pj4gaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyMC1NYXkvMDMwNTEy
Lmh0bWwKPj4+Pgo+Pj4+IFdpdGggU2FnaSdzIHBhdGNoIGJlbG93LCBJIGRvIHNlZSBhZnRlciBu
dm1ldF9hZGRfYXN5bmNfZXZlbnQoKSwKPj4+PiBudm1ldF9hc3luY19ldmVudHNfcHJvY2VzcyBw
dWxscyB0aGUgcmVxdWVzdCwgZGVjcmVtZW50cwo+Pj4+IGN0cmwtPm5yX2FzeW5jX2V2ZW50X2Nt
ZHMgdG8gMCwgYW5kIGZyZWVzIHRoZSBhZW4sCj4+Pj4gYW5kIG5vIG1lbW9yeSBsZWFrLgo+Pj4+
Cj4+Pj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAy
MC1NYXkvMDMwNTQ4Lmh0bWwKPj4+Cj4+PiBPaywgbGV0J3MgdHJ5IGEgdmVyc2lvbiBvZiBTYWdp
cyBsYXRlc3Qgc3VnZ2VzdGlvbiB0aGVuLiAgV2hhdCBhYm91dAo+Pj4gdGhpcyAocmVwbGFjZW1l
bnQgZm9yIHRoaXMgcGF0Y2ggb25seSwgSSBhcHBsaWVkIHRoZSBmaXJzdCBvbmUgYWxyZWFkeSk6
Cj4+Cj4+IFBhdGNoICMxIGlzIG5vdCBuZWVkZWQsIGJ1dCB3aGVyZSBkaWQgeW91IGFwcGx5IGl0
Pwo+IAo+IG52bWUtNS44Lgo+IAo+PiBEbyB5b3UgdGhpbmsgdGhlIGZpeCBpcyA1LjctcmMgbWF0
ZXJpYWw/Cj4gCj4gQXQgdGhpcyBwb2ludCDQhiBkb24ndCB0aGluayBhIG1lbWxlYWsgdGhhdCBo
YXMgYmVlbiB0aGVyZSBzaW5jZSBkYXkgMQo+IGlzIDUuNyBtYXRlcmlhbC4gINCGJ2QgcmF0aGVy
IHdhaXQgZm9yIDUuOCBhbiBnZXQgYSBzdGFibGUgYmFja3BvcnQKPiB3aXRoIHRoZSBwcm9wZXIg
Rml4ZXMgdGFnLgoKTWFrZXMgc2Vuc2UuCgo+PiBUaGUgYmVsb3cgbG9va3MgZmluZSwgYnV0IG1h
eWJlIGl0IHdvdWxkIGJlIGdvb2QgdG8gc3BsaXQgZm9yIHNtYWxsCj4+IGFuZCBlYXN5IGZpeCB0
aGF0IGNhbiBnbyB0byBzdGFibGUsIGFuZCB0aGVuIGEgYml0IG1vcmUgY2xlYW51cD8KPiAKPiBX
aGF0IHdvdWxkIHRoZSBzbWFsbCBhbmQgc2ltcGxlIGZpeCBiZT8KCkp1c3QgdGhlIGZpeCByZWxh
dGVkIHBhcnQuIFRoZW4gaGF2ZSBhIHNtYWxsIGNsZWFudXAgaW5jcmVtZW50YWxseS4KbW92ZSB0
aGUgbnZtZXRfYXN5bmNfZXZlbnRzX2ZyZWUgdG8gbnZtZXRfY3RybF9mcmVlIGFuZCBtYWtlIGl0
Cmp1c3QgZnJlZSB0aGUgYWVucy4KLS0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
Y29yZS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMKaW5kZXggZWRmNTRkOTk1N2I3Li40
OGY1MTIzZDg3NWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCisrKyBi
L2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCkBAIC0xNTgsMTQgKzE1OCwxMiBAQCBzdGF0aWMg
dm9pZCBudm1ldF9hc3luY19ldmVudHNfcHJvY2VzcyhzdHJ1Y3QgCm52bWV0X2N0cmwgKmN0cmws
IHUxNiBzdGF0dXMpCgogIHN0YXRpYyB2b2lkIG52bWV0X2FzeW5jX2V2ZW50c19mcmVlKHN0cnVj
dCBudm1ldF9jdHJsICpjdHJsKQogIHsKLSAgICAgICBzdHJ1Y3QgbnZtZXRfcmVxICpyZXE7Cisg
ICAgICAgc3RydWN0IG52bWV0X2FzeW5jX2V2ZW50ICphZW4sICp0bXA7CgogICAgICAgICBtdXRl
eF9sb2NrKCZjdHJsLT5sb2NrKTsKLSAgICAgICB3aGlsZSAoY3RybC0+bnJfYXN5bmNfZXZlbnRf
Y21kcykgewotICAgICAgICAgICAgICAgcmVxID0gY3RybC0+YXN5bmNfZXZlbnRfY21kc1stLWN0
cmwtPm5yX2FzeW5jX2V2ZW50X2NtZHNdOwotICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZj
dHJsLT5sb2NrKTsKLSAgICAgICAgICAgICAgIG52bWV0X3JlcV9jb21wbGV0ZShyZXEsIE5WTUVf
U0NfSU5URVJOQUwgfCBOVk1FX1NDX0ROUik7Ci0gICAgICAgICAgICAgICBtdXRleF9sb2NrKCZj
dHJsLT5sb2NrKTsKKyAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoYWVuLCB0bXAsICZj
dHJsLT5hc3luY19ldmVudHMsIGVudHJ5KSB7CisgICAgICAgICAgICAgICBsaXN0X2RlbCgmYWVu
LT5lbnRyeSk7CisgICAgICAgICAgICAgICBrZnJlZShhZW4pOwogICAgICAgICB9CiAgICAgICAg
IG11dGV4X3VubG9jaygmY3RybC0+bG9jayk7CiAgfQpAQCAtNzkxLDEwICs3ODksOCBAQCB2b2lk
IG52bWV0X3NxX2Rlc3Ryb3koc3RydWN0IG52bWV0X3NxICpzcSkKICAgICAgICAgICogSWYgdGhp
cyBpcyB0aGUgYWRtaW4gcXVldWUsIGNvbXBsZXRlIGFsbCBBRVJzIHNvIHRoYXQgb3VyCiAgICAg
ICAgICAqIHF1ZXVlIGRvZXNuJ3QgaGF2ZSBvdXRzdGFuZGluZyByZXF1ZXN0cyBvbiBpdC4KICAg
ICAgICAgICovCi0gICAgICAgaWYgKGN0cmwgJiYgY3RybC0+c3FzICYmIGN0cmwtPnNxc1swXSA9
PSBzcSkgeworICAgICAgIGlmIChjdHJsICYmIGN0cmwtPnNxcyAmJiBjdHJsLT5zcXNbMF0gPT0g
c3EpCiAgICAgICAgICAgICAgICAgbnZtZXRfYXN5bmNfZXZlbnRzX3Byb2Nlc3MoY3RybCwgc3Rh
dHVzKTsKLSAgICAgICAgICAgICAgIG52bWV0X2FzeW5jX2V2ZW50c19mcmVlKGN0cmwpOwotICAg
ICAgIH0KICAgICAgICAgcGVyY3B1X3JlZl9raWxsX2FuZF9jb25maXJtKCZzcS0+cmVmLCBudm1l
dF9jb25maXJtX3NxKTsKICAgICAgICAgd2FpdF9mb3JfY29tcGxldGlvbigmc3EtPmNvbmZpcm1f
ZG9uZSk7CiAgICAgICAgIHdhaXRfZm9yX2NvbXBsZXRpb24oJnNxLT5mcmVlX2RvbmUpOwpAQCAt
MTQyNyw2ICsxNDIzLDcgQEAgc3RhdGljIHZvaWQgbnZtZXRfY3RybF9mcmVlKHN0cnVjdCBrcmVm
ICpyZWYpCgogICAgICAgICBpZGFfc2ltcGxlX3JlbW92ZSgmY250bGlkX2lkYSwgY3RybC0+Y250
bGlkKTsKCisgICAgICAgbnZtZXRfYXN5bmNfZXZlbnRzX2ZyZWUoY3RybCk7CiAgICAgICAgIGtm
cmVlKGN0cmwtPnNxcyk7CiAgICAgICAgIGtmcmVlKGN0cmwtPmNxcyk7CiAgICAgICAgIGtmcmVl
KGN0cmwtPmNoYW5nZWRfbnNfbGlzdCk7Ci0tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
