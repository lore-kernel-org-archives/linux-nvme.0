Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC4C4743C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 04:14:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AD36112D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 04:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AD36112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtZWwybc7OuftYyUNbhrnaBbfjfz3VRmM6CPSFMdZ7w=; b=zG5aNjTxt2yVc9brjgbfJIQIzU
	+Mo9lO5d9c/9KxQYSSQFNf+SlQAozH02kUIVmkCDyT8yklX4WbXpeknxstsc5flWiPvUfOfTUMhy3
	ejJyXW0cnfXzpl2/DHYNsXkHS52Fa/Nrn8eMa1yA2QKcNZO6MSNpBD1JdLjymOr/ERV75rGSrBQwL
	F1F/yVWdUKjjNTwRykoBSGDEp6QOePfDoqNPbgj3HNFzNo5wCuEllnvAM9z8F9buYultHOQ0mxCGN
	u3oXtIJrtuMHz4BRA/m9W/mEck5TUR8VKjPRllIqbiGkOe+H4B1ZjztiNSkkD9RlGrOa720mrx0hX
	ypIWHWLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvuHY-009EEV-GE; Wed, 23 Jun 2021 04:14:32 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvuHV-009EDm-Cq
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 04:14:31 +0000
Received: by mail-pj1-x1033.google.com with SMTP id k5so760460pjj.1
 for <linux-nvme@lists.infradead.org>; Tue, 22 Jun 2021 21:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gDtJ3+9SBvXw4/+hkjTPz8k5dOa2+kVZ+5rGOqw2JNE=;
 b=f0yCMpkIWyS5eL0GB98K0MD6RUT5/+n86Bc7y798EwRJj1mZ0tK6EsWymvk1INPRre
 CLtErk2pKdZ3dSu94ScLAZnL0G0wvcGb9fqAFldKJStO0uKKfpAQf5jLMxocAtLqos/U
 9PzvzGMkGZdXOdfuhnO1AUCBR/X3Q8MJO1nn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gDtJ3+9SBvXw4/+hkjTPz8k5dOa2+kVZ+5rGOqw2JNE=;
 b=gcoKINTCqGyOvb+Xrt9ABys05eAJRGwiyAcSTU3ANR7OV2RyhKioK0oVKq+iTiRT0h
 lm5VMc8sluqidLbjBKzmxNlUZmLjovtEf3KDhvV1570bIT9noAJU7lXxdmxM2RrLmevm
 hPGWLJrHQ6tTcekJhou4XzoPBe9PaGxuOU3HNCnxOllMgKU1zjl1rhsrxBkIdu2xlx3p
 bJaeeRzDvhMe6ud5I8SUmZhEiL7TlQufJYb9U9EHMn9u9iRbolIW2EHLBjPKtQZv9Mk/
 kQx96SE298bwL8tvztJmc1+2WnbSErn4ZA/lfY6fbxHQfXYm4oucWBhW/sP3Z9ko0v5W
 ocEw==
X-Gm-Message-State: AOAM532ieocRBMLstPMrZU44bXJnGE8a8sx77+N66CSNjMqIhbE1m5aS
 kfpcnPKMWYbuWn+SeqmDlWCINw==
X-Google-Smtp-Source: ABdhPJwi2gZpPSCQagmpUdjPpxxIuenECNLtWmJNR67BGt/YuUdbfeixfIzaDrTQDGIWN6ZJfp5fcw==
X-Received: by 2002:a17:90b:4c52:: with SMTP id
 np18mr7543300pjb.186.1624421668006; 
 Tue, 22 Jun 2021 21:14:28 -0700 (PDT)
Received: from [10.231.212.116] ([192.30.189.3])
 by smtp.gmail.com with ESMTPSA id z9sm799004pfc.101.2021.06.22.21.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 21:14:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-pci: Fix multiple races in nvme_setup_io_queues()
From: Casey Chen <cachen@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
References: <20210622002710.26591-1-cachen@purestorage.com>
 <20210622002710.26591-2-cachen@purestorage.com>
 <20210622150636.GA2359631@dhcp-10-100-145-180.wdc.com>
 <33919248-6c62-0974-ce88-3c0d0885e837@purestorage.com>
 <20210623015331.GB2360166@dhcp-10-100-145-180.wdc.com>
 <0faf018d-570b-4c26-a093-3d375bd70c26@purestorage.com>
Message-ID: <9681def7-a751-f4d8-8a92-c5bee027a97a@purestorage.com>
Date: Tue, 22 Jun 2021 21:14:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0faf018d-570b-4c26-a093-3d375bd70c26@purestorage.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_211429_486187_876D5B11 
X-CRM114-Status: GOOD (  35.17  )
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

Ck9uIDYvMjIvMjEgOTowMCBQTSwgQ2FzZXkgQ2hlbiB3cm90ZToKPgo+IE9uIDYvMjIvMjEgNjo1
MyBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+IE9uIFR1ZSwgSnVuIDIyLCAyMDIxIGF0IDA1OjU5
OjMwUE0gLTA3MDAsIENhc2V5IENoZW4gd3JvdGU6Cj4+PiBPbiA2LzIyLzIxIDg6MDYgQU0sIEtl
aXRoIEJ1c2NoIHdyb3RlOgo+Pj4+IE9uIE1vbiwgSnVuIDIxLCAyMDIxIGF0IDA1OjI3OjA5UE0g
LTA3MDAsIENhc2V5IENoZW4gd3JvdGU6Cj4+Pj4+ICvCoMKgwqAgLyoKPj4+Pj4gK8KgwqDCoMKg
ICogRnJlZSBJUlEgcmVzb3VyY2VzIGFzIHNvb24gYXMgTlZNRVFfRU5BQkxFRCBiaXQgdHJhbnNp
dGlvbnMKPj4+Pj4gK8KgwqDCoMKgICogZnJvbSBzZXQgdG8gdW5zZXQuIElmIHRoZXJlIGlzIGEg
d2luZG93IHRvIGl0IGlzIHRydWVseSAKPj4+Pj4gZnJlZWQsCj4+Pj4+ICvCoMKgwqDCoCAqIHBj
aV9mcmVlX2lycV92ZWN0b3JzKCkganVtcGluZyBpbnRvIHRoaXMgd2luZG93IHdpbGwgY3Jhc2gu
Cj4+Pj4+ICvCoMKgwqDCoCAqIEFuZCB0YWtlIGxvY2sgdG8gYXZvaWQgcmFjaW5nIHdpdGggcGNp
X2ZyZWVfaXJxX3ZlY3RvcnMoKSBpbgo+Pj4+PiArwqDCoMKgwqAgKiBudm1lX2Rldl9kaXNhYmxl
KCkgcGF0aC4KPj4+Pj4gK8KgwqDCoMKgICovCj4+Pj4+ICvCoMKgwqAgbXV0ZXhfbG9jaygmZGV2
LT5zaHV0ZG93bl9sb2NrKQo+Pj4+IFNvcnJ5LCBJIHdhc24ndCBjbGVhciBpbiBwcmV2aW91cyBy
ZXZpZXcuIEFsbCBvZiB0aGUgc2h1dGRvd25fbG9ja3MKPj4+PiB0YWtlbiBhZnRlciBpbml0aWFs
aXphdGlvbiBuZWVkIHRvIGJ5IG11dGV4X3RyeWxvY2soKSdzLiBJZiB5b3UgCj4+Pj4gaGF2ZSB0
bwo+Pj4+IHdhaXQgdG8gZ2V0IHRoZSBsb2NrLCB0aGUgZGV2aWNlIGlzIG5vdCBnb2luZyB0byBi
ZSBzdWl0YWJsZSBmb3IKPj4+PiBjb250aW51aW5nIGluaXRpYWxpemF0aW9uIGFmdGVyIHRoZSBs
b2NrIGlzIGF2YWlsYWJsZS4KPj4+Pgo+Pj4+IEFuZCBsb29raW5nIGF0IHRoaXMgYWdhaW4sIGlm
IHRyeWxvY2sgaXMgc3VjY2Vzc2Z1bCwgSSB0aGluayB5b3UgCj4+Pj4gbmVlZCB0bwo+Pj4+IHZl
cmlmeSBjb250cm9sbGVyIHN0YXRlIGlzIHN1aXRhYmxlIGZvciBjb250aW51aW5nIHRoZSBpbml0
aWFsaXphdGlvbi4KPj4+IEkgYXNzdW1lIHlvdSBtZWFuIGFsbCB0aGUgbXV0ZXhfbG9jaygpIGV4
Y2VwdCB0aGUgb25lIGluIAo+Pj4gbnZtZV9kZXZfZGlzYWJsZSgpLAo+Pj4gcmlnaHQgPyBJIGFn
cmVlIHdpdGggcmVwbGFjaW5nIGFsbCBtdXRleF9sb2NrKCkgd2l0aCBtdXRleF90cnlsb2NrKCkg
Cj4+PiBleGNlcHQKPj4+IHRoZSBvbmUgaW4gbnZtZV9kZXZfZGlzYWJsZSgpLgo+PiBJIG9ubHkg
bWVhbiB0aGUgbG9ja3MgeW91IGFyZSBhZGRpbmcuIFRoZSBleGlzdGluZyB1c2FnZXMgYXJlIGNv
cnJlY3QKPj4gYXMtaXMuCj4+Cj4+PiBCdXQgSSBkb3VidCBhYm91dCBjaGVja2luZyBjb250cm9s
bGVyIHN0YXRlCj4+PiBhZnRlciBsb2NrIGJlaW5nIGFjcXVpcmVkLiBUd28gcmVhc29uczoKPj4+
Cj4+PiAxLiBXaGF0IHN0YXRlIGNhbiB1c2UgdG8gY2hlY2sgPwo+PiBJZiB0aGUgc3RhdGUgaXMg
bm90IE5WTUVfQ1RSTF9DT05ORUNUSU5HIGFmdGVyIHN1Y2Nlc3NmdWxseSB0YWtpbmcgdGhlCj4+
IHNodXRkb3duX2xvY2ssIHRoZW4gdGhlIGNvbnRyb2xsZXIgaXMgbm90IGluIGEgc3RhdGUgdGhh
dCBjYW4gcHJvY2VlZAo+PiB3aXRoIElPIHF1ZXVlIHNldHVwLgo+Pgo+Pj4gU3VwcG9zZSB0aGVy
ZSBpcyBhIHN0YXRlIHNldCBvbiBzdXJwcmlzZQo+Pj4gcmVtb3ZhbCwgd2hhdCBpZiB0aGUgc3Rh
dGUgY2hlY2sgaGFwcGVuIGJlZm9yZSBpdCBpcyBzZXQgd2hpbGUgc3VycHJpc2UKPj4+IHJlbW92
YWwgaXMgb24gaXRzIHdheSA/Cj4+Pgo+Pj4gMi4gRXZlbiB3ZSBkb24ndCBjaGVjayBjb250cm9s
bGVyIHN0YXRlIGFmdGVyIGFjcXVpcmluZyBsb2NrLCB0aGUKPj4+IGluaXRpYWxpemF0aW9uIHN0
aWxsIGZhaWwgZmFpcmx5IHNvb24gaWYgc3VycHJpc2UgcmVtb3ZhbCBoYXBwZW5zLiAKPj4+IFdl
IGRvbid0Cj4+PiBzYWNyaWZpY2UgYW55IHBlcmZvcm1hbmNlLgo+PiBOb3RoaW5nIHRvIGRvIHdp
dGggcGVyZm9ybWFuY2U7IHdlJ3JlIG5vdCBpbiBpbyBwYXRoLiBUaGUgc3VnZ2VzdGlvbiBpcwo+
PiBhYm91dCBhdm9pZGluZyBhY2Nlc3MgdG8gYSBub24tZXhpc3RlbnQgZGV2aWNlLiBUaGUgdGlt
aW5nIG9mIGEgc3VycHJpc2UKPj4gcmVtb3ZhbCBjYW4gYWx3YXlzIGRlZmVhdCBzdWNoIGEgY2hl
Y2ssIHNvIG15IHN1Z2dlc3Rpb24gaXMgbm90IGNyaXRpY2FsCj4+IHNpbmNlIHdlIGV4cGVjdCB0
aGF0IHRvIGJlIGhhbmRsZWQgYW55d2F5LCBidXQgaW4gbXkgZXhwZXJpZW5jZSwKPj4gcGxhdGZv
cm1zIHdvcmsgYmV0dGVyIGlmIHRoZSBPUyBwcmV2ZW50cyBzdWNoIGFjY2VzcyB3aGVuIGl0IGtu
b3dzIGl0Cj4+IHdpbGwgZmFpbC4gSXQncyBub3QgZnVsbC1wcm9vZi4KPj4KPj4gQnV0IGFzIEkg
c2FpZCwgZXZlcnl0aGluZyBzaG91bGQgd29yayBldmVuIHdpdGhvdXQgdGhlIGNoZWNrLCBzbyBm
ZWVsCj4+IGZyZWUgdG8gb21pdCBpdC4KPgo+IFRoYW5rcyBmb3IgZXhwbGFuYXRpb24uIEkgcHJl
ZmVyIG5vdCBoYXZpbmcgdGhlIGNoZWNrIGV2ZW4gSSBoYWQgY2FtZSAKPiB1cCB3aXRoIGEgc29s
dXRpb24gYXMgYmVsb3cuCj4KPiBUaGlzIGxvb2tzIGN1bWJlcnNvbWUuIElmIHlvdSBjYW4gbWFr
ZSBpdCBiZXR0ZXIsIEkgbWlnaHQgYWRvcHQgaXQuIAo+IE90aGVyd2lzZSwgSSB3aWxsIHNlbmQg
bmV3IHBhdGNoZXMgd2l0aG91dCB0aGUgY2hlY2suIDopCj4KPiArLyoKPiArICogVHJ5IGdldHRp
bmcgc2h1dGRvd25fbG9jayB3aGlsZSBzZXR0aW5nIHVwIElPIHF1ZXVlcy4KPiArICogQ2FsbGVy
IHJlbWVtYmVyIHRvIHVubG9jay4KPiArICovCj4gK3N0YXRpYyBpbnQgbnZtZV9zZXR1cF9pb19x
dWV1ZXNfdHJ5bG9jayhzdHJ1Y3QgbnZtZV9kZXYgKmRldikKPiArewo+ICvCoMKgwqDCoMKgwqAg
LyoKPiArwqDCoMKgwqDCoMKgICogTG9jayBpcyBiZWluZyBoZWxkIGJ5IG52bWVfZGV2X2Rpc2Fi
bGUoKSwgZmFpbCBlYXJseS4KPiArwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoCBpZiAo
IW11dGV4X3RyeWxvY2soJmRldi0+c2h1dGRvd25fbG9jaykpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7Cj4gKwo+ICvCoMKgwqDCoMKgwqAgLyoKPiArwqDC
oMKgwqDCoMKgICogQ29udHJvbGxlciBpcyBpbiB3cm9uZyBzdGF0ZSwgZmFpbCBlYXJseS4KPiAr
wqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgIGlmIChkZXYtPmN0cmwuc3RhdGUgPT0g
TlZNRV9DVFJMX0NPTk5FQ1RJTkcpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FTk9ERVY7Cj4gKwo+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4gK30KPiArCj4KPiBT
YW1wbGUgY2FsbDoKPgo+IC3CoMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmZGV2LT5zaHV0ZG93bl9s
b2NrKTsKPiArwqDCoMKgwqDCoMKgIGlmICgocmVzdWx0ID0gbnZtZV9zZXR1cF9pb19xdWV1ZXNf
dHJ5bG9jayhkZXYpKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmVz
dWx0Owo+CgpTb3JyeSBJIHNlbnQgaW4gYSBydXNoLCBzaG91bGQgYmU6CgorLyoKKyAqIFRyeSBn
ZXR0aW5nIHNodXRkb3duX2xvY2sgd2hpbGUgc2V0dGluZyB1cCBJTyBxdWV1ZXMuCisgKiBDYWxs
ZXIgcmVtZW1iZXIgdG8gdW5sb2NrIGlmIHN1Y2Nlc3MuCisgKi8KK3N0YXRpYyBpbnQgbnZtZV9z
ZXR1cF9pb19xdWV1ZXNfdHJ5bG9jayhzdHJ1Y3QgbnZtZV9kZXYgKmRldikKK3sKK8KgwqDCoMKg
wqDCoCAvKgorwqDCoMKgwqDCoMKgICogTG9jayBpcyBiZWluZyBoZWxkIGJ5IG52bWVfZGV2X2Rp
c2FibGUoKSwgZmFpbCBlYXJseS4KK8KgwqDCoMKgwqDCoCAqLworwqDCoMKgwqDCoMKgIGlmICgh
bXV0ZXhfdHJ5bG9jaygmZGV2LT5zaHV0ZG93bl9sb2NrKSkKK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7CisKK8KgwqDCoMKgwqDCoCAvKgorwqDCoMKgwqDCoMKg
ICogQ29udHJvbGxlciBpcyBpbiB3cm9uZyBzdGF0ZSwgZmFpbCBlYXJseS4KK8KgwqDCoMKgwqDC
oMKgICovCivCoMKgwqDCoMKgwqAgaWYgKGRldi0+Y3RybC5zdGF0ZSAhPSBOVk1FX0NUUkxfQ09O
TkVDVElORykgeworwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdXRleF91bmxvY2soJmRl
di0+c2h1dGRvd25fbG9jayk7CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RU5PREVWOworwqDCoMKgwqDCoMKgIH0KKworwqDCoMKgwqDCoMKgIHJldHVybiAwOworfQorCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
