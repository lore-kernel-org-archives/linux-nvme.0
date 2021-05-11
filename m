Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD0EC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 17:02:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E3761159
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 17:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E3761159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VCVbN6SeYEpToyRJFz/cdLEzeHM3HT7RQ7lGEh83gfc=; b=bVNTEcZms4Y8x7xGEvNdT16KV
	dMVvtJP/yHsVATnr0GsoEuPs+IrfkDP/8FktC+BY17CenCBpnbJup07yPXw0n/qILcoBLf8F/e5MU
	HzBs2C75khQpjNXXgBQi3Sq/ShKizyP6yfsalFAheAVrqZlaDYBVjw13Aw7jc3PaKyiNhHT4iOIuG
	73Y6hpLY6azXwl9bq5tscbNAPCa5AH/OF4Q9sAVsFG+QU7hBO7o7NVe/hfWUNlhK8CBhSgPQY8Enl
	VQZbfeJIwO0E6UkMEjgzX2gYXaFGbLAh6E4c5prMXI53mpS0nmVB+qN59STbrjsvCmAPNVILT+C9R
	gQwZIfRJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgVmA-000rJo-Kb; Tue, 11 May 2021 17:02:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVm6-000rIP-QJ
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 17:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=/2deN+35WP4ABGsYLEKDs0K3N9l5voXNGIlnOh7tY8c=; b=v6LK+aFI2pu38mmFD6EEwi4RPz
 QpIN09MNn+/wegiTUKqyKETR4Vtwg5W4svRagVDva4r9VTdO1vTk+OViKgUHKwl/u+PhsHmV7GgM2
 scX0P2JKZKFhepavcOrCTTQWx/Zz6XGnZbWflOhE9BsIYytU1a7OUAMGa8VLG5hyLS5i+E4+QUPMV
 f3sYUPKq17AM5Q+r7PFfZk9eeGeZNzJLcQxyY4Fhcrga4r9FGb7zo+KSgCXSYNop7bSqEjsFwrgQg
 XXnfAAaM1DmCRMPEU00nIYkAzUxIppTVudENFMpvmAn4Ab9tPLZLppkrsLJ6c5p6oSbIv783f5rUx
 wCgklWuQ==;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVm3-009nE6-K2
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 17:02:25 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 na14-20020a17090b4c0eb029015cbbd5f028so154582pjb.1
 for <linux-nvme@lists.infradead.org>; Tue, 11 May 2021 10:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/2deN+35WP4ABGsYLEKDs0K3N9l5voXNGIlnOh7tY8c=;
 b=ptzJz25An4ku3LHa+U5uNhJRZTfaBimsVMuCTeNSC/naADhIBKV9/wxKsk8dFvVtPs
 fRT3Npa2YZdsVxX/6QtnIkKi8qhpwpqibEH3g0BIsm7tygPG2mnO8uZU7eSz/mgldMe0
 hVrjEiTELGg9+ZiKMSJim8Lv3v1LrcYFpHNscwuRpPQkegnCdAVmyiNPJ37ERuHUSmfd
 mVhvB/wd+Ur99npEFbPjEpDik+Z+EmI+g74rxYvuCt46ff5K70i8eESZEtfFkYp7Im+r
 +a/NNt5lFW4yKckEiY1ttJWIHyXb9ymM6rKdY0x++StJL3/xJH7grfL+UDfZi6RnVSuH
 +THA==
X-Gm-Message-State: AOAM533Kv++J1G7z1RG4z0pPlYGFEvp6CWf1OebhE5XBmue02PjUgUxb
 aiIZ268wnZvmz2VXXopgMkm4rLwP43s=
X-Google-Smtp-Source: ABdhPJz1BwsswVCTD0lknrKHMGgYVcRulQB+vmWyH48c44DLh3d3Kw8YklBzYYpkzo5SsYTkCkBm+g==
X-Received: by 2002:a17:903:1ca:b029:ee:5aa3:c077 with SMTP id
 e10-20020a17090301cab02900ee5aa3c077mr30382071plh.51.1620752541759; 
 Tue, 11 May 2021 10:02:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1522:1d2e:7c9d:185c?
 ([2601:647:4802:9070:1522:1d2e:7c9d:185c])
 by smtp.gmail.com with ESMTPSA id c195sm14082199pfb.5.2021.05.11.10.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 10:02:21 -0700 (PDT)
Subject: Re: [PATCH] nvme: allow to re-attach namespaces after all paths are
 down
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210510144906.8305-1-hare@suse.de>
 <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
 <d3f800eb-a917-d139-b430-b7b7976331de@grimberg.me>
 <7137b35c-b656-0245-f1e1-9c0806ee61cb@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0d604ca8-ddf0-574a-2226-025d54e52344@grimberg.me>
Date: Tue, 11 May 2021 10:02:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7137b35c-b656-0245-f1e1-9c0806ee61cb@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_100223_678357_E21A6A86 
X-CRM114-Status: GOOD (  24.16  )
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

Cj4+Pj4gQEAgLTM2MDUsMTYgKzM2MDgsMjYgQEAgc3RhdGljIGludCBudm1lX2luaXRfbnNfaGVh
ZChzdHJ1Y3QgbnZtZV9ucyAKPj4+PiAqbnMsIHVuc2lnbmVkIG5zaWQsCj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGhlYWQtPnNoYXJlZCA9IGlzX3NoYXJlZDsKPj4+PiDCoMKgwqDCoMKgIH0gZWxz
ZSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IC1FSU5WQUw7Cj4+Pj4gLcKgwqDCoMKg
wqDCoMKgIGlmICghaXNfc2hhcmVkIHx8ICFoZWFkLT5zaGFyZWQpIHsKPj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZXZfZXJyKGN0cmwtPmRldmljZSwKPj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJEdXBsaWNhdGUgdW5zaGFyZWQgbmFtZXNwYWNlICVkXG4iLCBuc2lk
KTsKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9wdXRfbnNfaGVhZDsKPj4+
PiAtwqDCoMKgwqDCoMKgwqAgfQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoIW52bWVfbnNfaWRz
X2VxdWFsKCZoZWFkLT5pZHMsIGlkcykpIHsKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
ZXZfZXJyKGN0cmwtPmRldmljZSwKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJJRHMgZG9uJ3QgbWF0Y2ggZm9yIHNoYXJlZCBuYW1lc3BhY2UgJWRcbiIsCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIC8qCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBJZiBtdWx0aXBhdGggaXMgZW5h
YmxlZCB3ZSBtaWdodCBoaXQgYW4gbnMgaGVhZCB3aXRoIG5vCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqAgKiBwYXRocywgYnV0IHRoYXQgZG9lc24ndCBpbmRpY2F0ZSBpdCdzIGEgc2hhcmVkIG5hbWVz
cGFjZS4KPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAo
IW52bWVfbnNfaGVhZF9tdWx0aXBhdGgoaGVhZCkgfHwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAhbGlzdF9lbXB0eSgmaGVhZC0+bGlzdCkpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoIWlzX3NoYXJlZCB8fCAhaGVhZC0+c2hhcmVkKSB7Cj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGN0cmwtPmRldmljZSwKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkR1cGxpY2F0ZSB1bnNoYXJlZCBuYW1lc3Bh
Y2UgJWRcbiIsIG5zaWQpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290
byBvdXRfcHV0X25zX2hlYWQ7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4KPj4+
IElmIG5vdCBtdWx0aXBhdGgsIHRoZW4gaXQgaXMgbm90IHNoYXJlZC4gVGhlIGFib3ZlIHdpbGwg
ZmFpbCBhdHRhY2hpbmcKPj4+IHNpbmdsZS1wYXRoIG5hbWVzcGFjZXMgdG8gYSBrbm93biBoZWFk
Lgo+Pj4KPj4+IFRoZSByZXN0IGlzIHNpbWlsYXIgdG8gc29tZXRoaW5nIEkgd2FzIHdvcmtpbmcg
b24gdG9vLCB0aG91Z2gsIHNvIEkKPj4+IHRoaW5rIGl0J3MgdGhlIHJpZ2h0IGRpcmVjdGlvbi4K
Pj4+Cj4+Pgo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghbnZtZV9uc19pZHNfZXF1
YWwoJmhlYWQtPmlkcywgaWRzKSkgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2X2VycihjdHJsLT5kZXZpY2UsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJJRHMgZG9uJ3QgbWF0Y2ggZm9yIHNoYXJlZCBuYW1lc3BhY2UgJWRcbiIs
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5zaWQpOwo+
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X3B1dF9uc19oZWFkOwo+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfcHV0X25zX2hlYWQ7Cj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEJ1dCB0aGUgaWRzIG1pZ2h0IGhhdmUgY2hh
bmdlZCwgc28gcmVzZXQgdGhlbSAqLwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhlYWQt
PmlkcyA9ICppZHM7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+PiDCoMKgwqDCoMKgIH0K
Pj4+PiBAQCAtMzc2NCw4ICszNzc3LDYgQEAgc3RhdGljIHZvaWQgbnZtZV9uc19yZW1vdmUoc3Ry
dWN0IG52bWVfbnMgKm5zKQo+Pj4+IMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmbnMtPmN0cmwtPnN1
YnN5cy0+bG9jayk7Cj4+Pj4gwqDCoMKgwqDCoCBsaXN0X2RlbF9yY3UoJm5zLT5zaWJsaW5ncyk7
Cj4+Pj4gLcKgwqDCoCBpZiAobGlzdF9lbXB0eSgmbnMtPmhlYWQtPmxpc3QpKQo+Pj4+IC3CoMKg
wqDCoMKgwqDCoCBsaXN0X2RlbF9pbml0KCZucy0+aGVhZC0+ZW50cnkpOwo+Pgo+PiBIYW5uZXMs
IHlvdSBzZW50IGEgcGF0Y2ggbGlrZSB0aGlzIGJlZm9yZSwgbXkgY29tbWVudCB3YXMgdGhhdCBh
IG5zaGVhZAo+PiBzaG91bGQgYmUgcmVtb3ZlZCBiZWZvcmUgdGhlIGZpbmFsIHJlZmVyZW5jZSAo
d2hpY2ggd2hvIGtub3dzIHdoZW4gaXQKPj4gd2lsbCBldmVyIGFycml2ZSkgYXMgaWYgYSBuc2lk
IHdlcmUgdG8gYmUgcmV1c2VkIGJ5IHRoZSBjb250cm9sbGVyIGZvcgo+PiBhIGRpZmZlcmVudCBu
YW1lc3BhY2UgdGhlbiB3ZSdkIHJlamVjdCBpdCBzbyBJJ20gbm90IHN1cmUgaG93IHRoaXMgaGVs
cHM/Cj4+Cj4gCj4gQnV0IHdlIF9uZWVkXyB0byBoYXZlIHRoZSBuc2hlYWQgYXZhaWxhYmxlIGlu
IHRoZSBsaW5rZWQgbGlzdCBpZiB3ZSBldmVyIAo+IHdhbnQgdG8gcmUtYXR0YWNoIGEgbmFtZXNw
YWNlIGFmdGVyIHJlY29ubmVjdGluZyB0aGUgY29udHJvbGxlci4KCkFnYWluLCB0aGlzIGlzIGEg
cXVldWVfaWZfbm9fcGF0aCBmdW5jdGlvbmFsaXR5LCB0aGlzIHNlcXVlbmNlIGlzIApjb3JyZWN0
IGZvciB0aGF0LgoKPiBBbmQgd2Ugc2hvdWxkIGJlIGFibGUgdG8gY2F0Y2ggdGhlICdyZXVzZSBu
YW1lc3BhY2UnIGlzc3VlIGJ5IGNoZWNraW5nIAo+IHRoZSBjb250ZW50cyBvZiB0aGUgbnNpZHMg
ZmllbGQsIHdoaWNoIHdlIGtlZXAgYXR0YWNoZWQgdG8gdGhlIG5zaGVhZC4KCldlbGwsIHlvdSBt
YXkgYmUgcmlnaHQsIHdoYXQgSSdtIGNvbmNlcm5lZCBhYm91dCBpcyB0aGF0IGEgbmV3IG5hbWVz
cGFjZQptYXkgYmUgZmFsc2VseSBpZGVudGlmaWVkIGFzIHRoZSBzYW1lIG5hbWVzcGFjZSBiZWNh
dXNlIGl0IGlzIApyZS1hdHRhY2hpbmcgdG8gYSBsaW5nZXJpbmcgbW91bnRlZCBtcGF0aCBkZXZp
Y2UuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
