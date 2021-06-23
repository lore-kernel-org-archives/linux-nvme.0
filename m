Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9CC4743C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 04:00:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF1461351
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 04:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF1461351
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sY0o7LOWgGmIe3F9C+AoD/RNulmrzu5guCPS0lt9Azg=; b=Os3dyGK5VeBzWkPryK87ltQu/y
	rdtGvxNip3I3hzfYOrjt7+itNi3qw4zzzCI68YAjT409yaJpocDSzGZ1M6ZR0q529m8of4qYWbhZV
	VHtUyg0cVAM8jgXsuX5QSUjqLvari8QR6yA12dDCaB1dAfT7kdSmbF/joDc7u4MsN16pSboGSa+RV
	YWoXX+8xPaQyMP6YMv8AhUCUPwIW0aD8AsIMOKkd3XYpRgkzWBxmDTbsT40m2LQVIJGQDXaTtgFm+
	6ioOePdMWVh7GBhnapxP77utM0vt8JNAZI2izRRkYk/CXE9hrLLME0+WdQIewjsmkVczJNJcKqPfR
	k13Zeh/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvu3j-009DGa-4r; Wed, 23 Jun 2021 04:00:15 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvu3f-009DFz-Hi
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 04:00:13 +0000
Received: by mail-pg1-x52b.google.com with SMTP id t9so639786pgn.4
 for <linux-nvme@lists.infradead.org>; Tue, 22 Jun 2021 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7NIQ2MZJ9/+dtssRHXIaQjmpEkWyc8yifhr+GCa/OXQ=;
 b=Be44p1Ecd7oQtCWrhTNnMqr6t94OQsg2d1kDGiAZ+4C0NdruKT5W3x7AuB4mq8vZcx
 xAX7Kz4EdvJO1HEBL8bOTDyX3Qax72WgV30As0ylT1af21BZmYAinxADTyAAStq1aQXN
 VP1XYvacCGcCF66PrsiQu2EKp2y+C2Vv895h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7NIQ2MZJ9/+dtssRHXIaQjmpEkWyc8yifhr+GCa/OXQ=;
 b=tE2G0FcMAb+ecdIsf963LjXWE0PhSQsmU+n2D5+x+zvjIXyY1B5PlaoDqepCcoahwD
 ev5KA7iYKxMa4Qs3uUUCWo47mo3cmaoGsmbkVEqcTEPEjug/ZP+wB4zvMUJ6bmohDcmz
 UTICiCZ9ZW/tguQYP2D7vYbcMwxqKoBPA25a81JfbYGRaXmU/bCuOZdrSU104BK7yTwb
 3nnKuzlREXrU5uBea04Qe8a0/FhXdsDzZWDuGQDY16wS3Z05SPDrDbrypq4TUZlAKsEQ
 /PpASLbglQn6JcAEqS9b6W3UaI79+mCCj4GrULGcGpwHyYtVE2iNipyj+DQluQuPL5j0
 Mzrw==
X-Gm-Message-State: AOAM530yAt4bd8XwdSZnyc9/QGh7a0G/ASTJ2zAShD5qw/WxmmXG3Qo2
 wjHsJUfBOBYMIaY7Nq/Gw3RkmA==
X-Google-Smtp-Source: ABdhPJwWb4eEWaooCztNytYPnMrGm/EJeCtOZVjzmnh7z7DD0MTXbeRYYQpOLYFN0BRNP/J7pFe4Pw==
X-Received: by 2002:a62:3344:0:b029:24c:735c:4546 with SMTP id
 z65-20020a6233440000b029024c735c4546mr6997241pfz.1.1624420809990; 
 Tue, 22 Jun 2021 21:00:09 -0700 (PDT)
Received: from [10.231.212.116] ([192.30.189.3])
 by smtp.gmail.com with ESMTPSA id 23sm3582018pjw.28.2021.06.22.21.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 21:00:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-pci: Fix multiple races in nvme_setup_io_queues()
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
References: <20210622002710.26591-1-cachen@purestorage.com>
 <20210622002710.26591-2-cachen@purestorage.com>
 <20210622150636.GA2359631@dhcp-10-100-145-180.wdc.com>
 <33919248-6c62-0974-ce88-3c0d0885e837@purestorage.com>
 <20210623015331.GB2360166@dhcp-10-100-145-180.wdc.com>
From: Casey Chen <cachen@purestorage.com>
Message-ID: <0faf018d-570b-4c26-a093-3d375bd70c26@purestorage.com>
Date: Tue, 22 Jun 2021 21:00:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210623015331.GB2360166@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_210011_719135_7A172505 
X-CRM114-Status: GOOD (  33.20  )
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

Ck9uIDYvMjIvMjEgNjo1MyBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gVHVlLCBKdW4gMjIs
IDIwMjEgYXQgMDU6NTk6MzBQTSAtMDcwMCwgQ2FzZXkgQ2hlbiB3cm90ZToKPj4gT24gNi8yMi8y
MSA4OjA2IEFNLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4+IE9uIE1vbiwgSnVuIDIxLCAyMDIxIGF0
IDA1OjI3OjA5UE0gLTA3MDAsIENhc2V5IENoZW4gd3JvdGU6Cj4+Pj4gKwkvKgo+Pj4+ICsJICog
RnJlZSBJUlEgcmVzb3VyY2VzIGFzIHNvb24gYXMgTlZNRVFfRU5BQkxFRCBiaXQgdHJhbnNpdGlv
bnMKPj4+PiArCSAqIGZyb20gc2V0IHRvIHVuc2V0LiBJZiB0aGVyZSBpcyBhIHdpbmRvdyB0byBp
dCBpcyB0cnVlbHkgZnJlZWQsCj4+Pj4gKwkgKiBwY2lfZnJlZV9pcnFfdmVjdG9ycygpIGp1bXBp
bmcgaW50byB0aGlzIHdpbmRvdyB3aWxsIGNyYXNoLgo+Pj4+ICsJICogQW5kIHRha2UgbG9jayB0
byBhdm9pZCByYWNpbmcgd2l0aCBwY2lfZnJlZV9pcnFfdmVjdG9ycygpIGluCj4+Pj4gKwkgKiBu
dm1lX2Rldl9kaXNhYmxlKCkgcGF0aC4KPj4+PiArCSAqLwo+Pj4+ICsJbXV0ZXhfbG9jaygmZGV2
LT5zaHV0ZG93bl9sb2NrKQo+Pj4gU29ycnksIEkgd2Fzbid0IGNsZWFyIGluIHByZXZpb3VzIHJl
dmlldy4gQWxsIG9mIHRoZSBzaHV0ZG93bl9sb2Nrcwo+Pj4gdGFrZW4gYWZ0ZXIgaW5pdGlhbGl6
YXRpb24gbmVlZCB0byBieSBtdXRleF90cnlsb2NrKCkncy4gSWYgeW91IGhhdmUgdG8KPj4+IHdh
aXQgdG8gZ2V0IHRoZSBsb2NrLCB0aGUgZGV2aWNlIGlzIG5vdCBnb2luZyB0byBiZSBzdWl0YWJs
ZSBmb3IKPj4+IGNvbnRpbnVpbmcgaW5pdGlhbGl6YXRpb24gYWZ0ZXIgdGhlIGxvY2sgaXMgYXZh
aWxhYmxlLgo+Pj4KPj4+IEFuZCBsb29raW5nIGF0IHRoaXMgYWdhaW4sIGlmIHRyeWxvY2sgaXMg
c3VjY2Vzc2Z1bCwgSSB0aGluayB5b3UgbmVlZCB0bwo+Pj4gdmVyaWZ5IGNvbnRyb2xsZXIgc3Rh
dGUgaXMgc3VpdGFibGUgZm9yIGNvbnRpbnVpbmcgdGhlIGluaXRpYWxpemF0aW9uLgo+PiBJIGFz
c3VtZSB5b3UgbWVhbiBhbGwgdGhlIG11dGV4X2xvY2soKSBleGNlcHQgdGhlIG9uZSBpbiBudm1l
X2Rldl9kaXNhYmxlKCksCj4+IHJpZ2h0ID8gSSBhZ3JlZSB3aXRoIHJlcGxhY2luZyBhbGwgbXV0
ZXhfbG9jaygpIHdpdGggbXV0ZXhfdHJ5bG9jaygpIGV4Y2VwdAo+PiB0aGUgb25lIGluIG52bWVf
ZGV2X2Rpc2FibGUoKS4KPiBJIG9ubHkgbWVhbiB0aGUgbG9ja3MgeW91IGFyZSBhZGRpbmcuIFRo
ZSBleGlzdGluZyB1c2FnZXMgYXJlIGNvcnJlY3QKPiBhcy1pcy4KPgo+PiBCdXQgSSBkb3VidCBh
Ym91dCBjaGVja2luZyBjb250cm9sbGVyIHN0YXRlCj4+IGFmdGVyIGxvY2sgYmVpbmcgYWNxdWly
ZWQuIFR3byByZWFzb25zOgo+Pgo+PiAxLiBXaGF0IHN0YXRlIGNhbiB1c2UgdG8gY2hlY2sgPwo+
IElmIHRoZSBzdGF0ZSBpcyBub3QgTlZNRV9DVFJMX0NPTk5FQ1RJTkcgYWZ0ZXIgc3VjY2Vzc2Z1
bGx5IHRha2luZyB0aGUKPiBzaHV0ZG93bl9sb2NrLCB0aGVuIHRoZSBjb250cm9sbGVyIGlzIG5v
dCBpbiBhIHN0YXRlIHRoYXQgY2FuIHByb2NlZWQKPiB3aXRoIElPIHF1ZXVlIHNldHVwLgo+Cj4+
IFN1cHBvc2UgdGhlcmUgaXMgYSBzdGF0ZSBzZXQgb24gc3VycHJpc2UKPj4gcmVtb3ZhbCwgd2hh
dCBpZiB0aGUgc3RhdGUgY2hlY2sgaGFwcGVuIGJlZm9yZSBpdCBpcyBzZXQgd2hpbGUgc3VycHJp
c2UKPj4gcmVtb3ZhbCBpcyBvbiBpdHMgd2F5ID8KPj4KPj4gMi4gRXZlbiB3ZSBkb24ndCBjaGVj
ayBjb250cm9sbGVyIHN0YXRlIGFmdGVyIGFjcXVpcmluZyBsb2NrLCB0aGUKPj4gaW5pdGlhbGl6
YXRpb24gc3RpbGwgZmFpbCBmYWlybHkgc29vbiBpZiBzdXJwcmlzZSByZW1vdmFsIGhhcHBlbnMu
IFdlIGRvbid0Cj4+IHNhY3JpZmljZSBhbnkgcGVyZm9ybWFuY2UuCj4gTm90aGluZyB0byBkbyB3
aXRoIHBlcmZvcm1hbmNlOyB3ZSdyZSBub3QgaW4gaW8gcGF0aC4gVGhlIHN1Z2dlc3Rpb24gaXMK
PiBhYm91dCBhdm9pZGluZyBhY2Nlc3MgdG8gYSBub24tZXhpc3RlbnQgZGV2aWNlLiBUaGUgdGlt
aW5nIG9mIGEgc3VycHJpc2UKPiByZW1vdmFsIGNhbiBhbHdheXMgZGVmZWF0IHN1Y2ggYSBjaGVj
aywgc28gbXkgc3VnZ2VzdGlvbiBpcyBub3QgY3JpdGljYWwKPiBzaW5jZSB3ZSBleHBlY3QgdGhh
dCB0byBiZSBoYW5kbGVkIGFueXdheSwgYnV0IGluIG15IGV4cGVyaWVuY2UsCj4gcGxhdGZvcm1z
IHdvcmsgYmV0dGVyIGlmIHRoZSBPUyBwcmV2ZW50cyBzdWNoIGFjY2VzcyB3aGVuIGl0IGtub3dz
IGl0Cj4gd2lsbCBmYWlsLiBJdCdzIG5vdCBmdWxsLXByb29mLgo+Cj4gQnV0IGFzIEkgc2FpZCwg
ZXZlcnl0aGluZyBzaG91bGQgd29yayBldmVuIHdpdGhvdXQgdGhlIGNoZWNrLCBzbyBmZWVsCj4g
ZnJlZSB0byBvbWl0IGl0LgoKVGhhbmtzIGZvciBleHBsYW5hdGlvbi4gSSBwcmVmZXIgbm90IGhh
dmluZyB0aGUgY2hlY2sgZXZlbiBJIGhhZCBjYW1lIHVwIAp3aXRoIGEgc29sdXRpb24gYXMgYmVs
b3cuCgpUaGlzIGxvb2tzIGN1bWJlcnNvbWUuIElmIHlvdSBjYW4gbWFrZSBpdCBiZXR0ZXIsIEkg
bWlnaHQgYWRvcHQgaXQuIApPdGhlcndpc2UsIEkgd2lsbCBzZW5kIG5ldyBwYXRjaGVzIHdpdGhv
dXQgdGhlIGNoZWNrLiA6KQoKKy8qCisgKiBUcnkgZ2V0dGluZyBzaHV0ZG93bl9sb2NrIHdoaWxl
IHNldHRpbmcgdXAgSU8gcXVldWVzLgorICogQ2FsbGVyIHJlbWVtYmVyIHRvIHVubG9jay4KKyAq
Lworc3RhdGljIGludCBudm1lX3NldHVwX2lvX3F1ZXVlc190cnlsb2NrKHN0cnVjdCBudm1lX2Rl
diAqZGV2KQoreworwqDCoMKgwqDCoMKgIC8qCivCoMKgwqDCoMKgwqAgKiBMb2NrIGlzIGJlaW5n
IGhlbGQgYnkgbnZtZV9kZXZfZGlzYWJsZSgpLCBmYWlsIGVhcmx5LgorwqDCoMKgwqDCoMKgICov
CivCoMKgwqDCoMKgwqAgaWYgKCFtdXRleF90cnlsb2NrKCZkZXYtPnNodXRkb3duX2xvY2spKQor
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKKworwqDCoMKgwqDC
oMKgIC8qCivCoMKgwqDCoMKgwqAgKiBDb250cm9sbGVyIGlzIGluIHdyb25nIHN0YXRlLCBmYWls
IGVhcmx5LgorwqDCoMKgwqDCoMKgwqAgKi8KK8KgwqDCoMKgwqDCoCBpZiAoZGV2LT5jdHJsLnN0
YXRlID09IE5WTUVfQ1RSTF9DT05ORUNUSU5HKQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVOT0RFVjsKKworwqDCoMKgwqDCoMKgIHJldHVybiAwOworfQorCgpTYW1wbGUg
Y2FsbDoKCi3CoMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmZGV2LT5zaHV0ZG93bl9sb2NrKTsKK8Kg
wqDCoMKgwqDCoCBpZiAoKHJlc3VsdCA9IG52bWVfc2V0dXBfaW9fcXVldWVzX3RyeWxvY2soZGV2
KSkpCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXN1bHQ7CgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
