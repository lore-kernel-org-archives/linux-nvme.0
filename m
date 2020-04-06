Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F55BC2BA17
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5725F206B8
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N15Salyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5725F206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R9lOhWS7rxCh5P7lf5Z24FrBsZxLPdP7HGannD56yvw=; b=N15SalyccCDO1CgbTxfJaC4Z9
	h7CfTjJZw63vEVYfu2w5lG4btYVjli88rSflI1AoWOoCbYT6HJQ2SL9EspHcVdURn6DBLbSjGJjI7
	4We341AHbOAaqKkqApHUTS5+78N45lOZ7T8arMUP5AwqbfKvBb91zel9nJtZ67PddU2lVnYAN11q2
	6tIoGIpkG+AuFU4Gwnp9wOiaUHv+CPLtgFB829ykziduJozDnA72ZGfngjsVzJqkOL0BkxbQdqubG
	7NbcPa3rh1OvD10H2fVc1LNG2e11iEFzULly1lP8j5MfWJJiglah4CtDCj7udRLtQDGmbRNu5hv6O
	dZNYYWPig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLWDy-00047f-DO; Mon, 06 Apr 2020 18:11:54 +0000
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLWDu-00046q-RL
 for linux-nvme@lists.infradead.org; Mon, 06 Apr 2020 18:11:52 +0000
Received: by mail-pg1-f176.google.com with SMTP id m13so353732pgd.8
 for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2020 11:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5JktVFsXI/fJDUcOZe7mdHGgGWcT9Gh6AVvG4NRNchk=;
 b=Pt5fkaA4wWvc4Q1TsipV+TZAVI545YFg75jsiRYRENmBlHYcIdpJsJU2Iskuf0Wlsp
 ct/tf3akqNEtJWXffvtYrK+HHby8sqN5Bkb8KdTm7vlrnznpGX4bO4Bztv/hkivOvIu0
 XCfDlPBohAjjEfylmbvgzStJt52lFFV8Y1Ec3xDwEfutndxYJt8KLAhajLkeZofREEex
 xYZGqm5bTUNz6muD2QGO4cS3CIRvMs6lwrFhYxiqYK9emA5CVHWMU3qb0TPZyiolBWNE
 oxihc1mLVN/hlwxXEJoqVaYpYwIsPpYHCy+NPS8YOYHddsrc+GRplN7I66keZ1jJrAxt
 +ixw==
X-Gm-Message-State: AGi0PuZQFTF+UCXvFmwKIibm3/3afOIMC/FJO2AteofMePstdfRvaccu
 Az7+uEaSjv5sKieudPh/Vuj6Cwut
X-Google-Smtp-Source: APiQypIwbeb3p92DctXyIwZ5bRNyHWlrY37tKyhFu36nNS5n6Jcl4Tcfotx3JJ6EZtbgPOFasc64ug==
X-Received: by 2002:a63:9143:: with SMTP id l64mr331547pge.75.1586196708075;
 Mon, 06 Apr 2020 11:11:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:de6:f05e:6a88:9257?
 ([2601:647:4802:9070:de6:f05e:6a88:9257])
 by smtp.gmail.com with ESMTPSA id u41sm11605906pgn.8.2020.04.06.11.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 11:11:47 -0700 (PDT)
Subject: Re: Sighting: io_uring requests on unexpected core
From: Sagi Grimberg <sagi@grimberg.me>
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <MW3PR11MB46843ADF1AEED8FCEA66BB8FE5C70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <1b9aa822-2516-4eb8-1472-7e7b66c32d45@grimberg.me>
Message-ID: <dcf9141d-7aa6-a0bb-c2cb-e2faf9fbe5ac@grimberg.me>
Date: Mon, 6 Apr 2020 11:11:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1b9aa822-2516-4eb8-1472-7e7b66c32d45@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200406_111150_886454_B3D5A591 
X-CRM114-Status: GOOD (  20.74  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Q0MnaW5nIGxpbnV4LW52bWUKCk9uIDQvMy8yMCAyOjQ0IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3Rl
Ogo+PiBIZXkgYWxsLCBNYXJrIGhlcmUgYWdhaW4gd2l0aCBhbm90aGVyIHNpZ2h0aW5nLgo+IAo+
IEhleSBNYXJrLAo+IAo+PiBJZiB5b3UncmUgYWxsIFdGSCBsaWtlIG15c2VsZiBkdXJpbmcgdGhp
cyB2aXJ1cyBwZXJpb2QgbWF5YmUgdGhpcyB3aWxsIAo+PiBwcm92aWRlIHlvdSB3aXRoIGEgbmV3
IHB1enpsZSB0byBzb2x2ZSBhbmQgcGFzcyB0aGUgdGltZSwgd2hpbGUgCj4+IGhlbHBpbmcgdG8g
ZWR1Y2F0ZS7CoCBPdXIgZmFtaWx5IGJpZyBpbnRvIHB1enpsZXMgZHVyaW5nIHRoaXMgcGVyaW9k
Lgo+IAo+IDotKQo+IAo+PiBIZXJlIGlzIHRoZSBpc3N1ZToKPj4gV2hpbGUgcGVyZm9ybWluZyBh
biBGSU8gdGVzdCwgZm9yIGEgc2luZ2xlIGpvYiB0aHJlYWQgcGlubmVkIHRvIGEgCj4+IHNwZWNp
ZmljIENQVSwgSSBjYW4gdHJhcCByZXF1ZXN0cyB0byB0aGUgbnZtZiBsYXllciBmcm9tIGEgY29y
ZSBhbmQgCj4+IHF1ZXVlIG5vdCBhbGlnbmVkIHRvIHRoZSBGSU8gc3BlY2lmaWVkIENQVS4KPj4g
SSBjYW4gcmVwbGljYXRlIHRoaXMgb24gdGhlIGJhc2VsaW5lIG9mIG52bWUtNS41LXJjIG9yIG52
bWUtNS43LXJjMSAKPj4gYnJhbmNoZXMgb2YgdGhlIGluZnJhZGVhZCByZXBvc2l0b3J5LCB3aXRo
IG5vIG90aGVyIHBhdGNoZXMgYXBwbGllZC4KPj4gRm9yIGEgdHlwaWNhbCAzMCBzZWNvbmQgNGsg
MTAwJSByZWFkIHRlc3QgdGhlcmUgd2lsbCBiZSBvdmVyIDIgbWlsbGlvbiAKPj4gcGFja2V0cyBw
cm9jZXNzZWQsIHdpdGggdW5kZXIgMTAwIHNlbnQgYnkgdGhpcyBvdGhlciBDUFUgdG8gYSAKPj4g
ZGlmZmVyZW50IHF1ZXVlLsKgIFdoZW4gdGhpcyBvY2N1cnMgaXQgY2F1c2VzIGEgZHJvcCBpbiBw
ZXJmb3JtYW5jZSBvZiAKPj4gMS0zJS4KPj4gTXkgbnZtZiBxdWV1ZSBjb25maWd1cmF0aW9uIGlz
IDEgbnJfaW9fcXVldWUgYW5kIDEwNCBucl9wb2xsX3F1ZXVlcyAKPj4gdGhhdCBlcXVhbCB0aGUg
bnVtYmVyIG9mIGFjdGl2ZSBjb3JlcyBpbiB0aGUgc3lzdGVtLgo+IAo+IEdpdmVuIHRoYXQgeW91
IHBpbiB5b3VyIGZpbyB0aHJlYWQgdGhlIGhpZ2ggcG9sbCBxdWV1ZSBjb3VudCBzaG91bGRuJ3QK
PiByZWFsbHkgbWF0dGVyIEkgYXNzdW1lLgo+IAo+PiBBcyBpbmRpY2F0ZWQgdGhpcyBpcyB3aGls
ZSBydW5uaW5nIGFuIEZJTyB0ZXN0IHVzaW5nIGlvX3VyaW5nIGZvciAxMDAlIAo+PiByYW5kb20g
cmVhZC7CoCBBbmQgaGF2ZSBzZWVuIHRoaXMgd2l0aCBhIHF1ZXVlIGRlcHRoIG9mIDEgYmF0Y2gg
MSwgYXMgCj4+IHdlbGwgYXMgcXVldWUgZGVwdGggMzIgYmF0Y2ggOC4KPj4KPj4gwqAgVGhlIGJh
c2ljIGNvbW1hbmQgbGluZSBiZWluZzoKPj4gL2ZpbyAtLWZpbGVuYW1lPS9kZXYvbnZtZTBuMSAt
LXRpbWVfYmFzZWQgLS1ydW50aW1lPTMwIC0tcmFtcF90aW1lPTEwIAo+PiAtLXRocmVhZCAtLXJ3
PXJhbmRydyAtLXJ3bWl4cmVhZD0xMDAgLS1yZWZpbGxfYnVmZmVycyAtLWRpcmVjdD0xIAo+PiAt
LWlvZW5naW5lPWlvX3VyaW5nIC0taGlwcmkgLS1maXhlZGJ1ZnMgLS1icz00ayAtLWlvZGVwdGg9
MzIgCj4+IC0taW9kZXB0aF9iYXRjaF9jb21wbGV0ZV9taW49MSAtLWlvZGVwdGhfYmF0Y2hfY29t
cGxldGVfbWF4PTMyIAo+PiAtLWlvZGVwdGhfYmF0Y2g9OCAtLW51bWpvYnM9MSAtLWdyb3VwX3Jl
cG9ydGluZyAtLWd0b2RfcmVkdWNlPTAgCj4+IC0tZGlzYWJsZV9sYXQ9MCAtLW5hbWU9Y3B1MyAt
LWNwdXNfYWxsb3dlZD0zCj4+Cj4+IEFkZGluZyBtb25pdG9yaW5nIHdpdGhpbiB0aGUgY29kZSBm
dW5jdGlvbnMgbnZtZV90Y3BfcXVldWVfcmVxdWVzdCgpIAo+PiBhbmQgbnZtZV90Y3BfcG9sbCgp
IEkgd2lsbCBzZWUgdGhlIGZvbGxvd2luZy7CoCBQb2xsaW5nIGZyb20gdGhlIAo+PiBleHBlY3Rl
ZCBDUFUgZm9yIGRpZmZlcmVudCBxdWV1ZXMgd2l0aCBkaWZmZXJlbnQgYXNzaWduZWQgQ1BVIAo+
PiBbcXVldWUtPmlvX2NwdV0uwqAgQW5kIG5ldyBxdWV1ZSByZXF1ZXN0IGNvbWluZyBpbiBvbiBh
biB1bmV4cGVjdGVkIENQVSAKPj4gW25vdCBhcyBkaXJlY3RlZCBvbiBGSU8gaW52b2NhdGlvbl0g
aW5kaWNhdGluZyBhIHF1ZXVlIGNvbnRleHQgCj4+IGFzc2lnbmVkIHdpdGggdGhlIHNhbWUgQ1BV
IHZhbHVlLsKgIE5vdGU6IGV2ZW4gd2hlbiByZXF1ZXN0cyBjb21lIGluIG9uIAo+PiBkaWZmZXJl
bnQgQ1BVIGNvcmVzLCBhbGwgcG9sbGluZyBpcyBmcm9tIHRoZSBzYW1lIGV4cGVjdGVkIENQVSBj
b3JlLgo+IAo+IG52bWVfdGNwX3BvbGw6IFtRdWV1ZSBDUFUgM10sIFtDUFUgM10gbWVhbnMgdGhh
dCB0aGUgcG9sbCBpcyBpcyBjYWxsZWQKPiBvbiBjcHUgY29yZSBbM10gb24gYSBxdWV1ZSB0aGF0
IGlzIG1hcHBlZCB0byBjcHUgY29yZSBbM10gY29ycmVjdD8KPiAKPiBudm1lX3RjcF9wb2xsOiBb
UXVldWUgQ1BVIDc1XSwgW0NQVSAzXSBtZWFucyB0aGF0IHRoZSBwb2xsIGlzIGlzIGNhbGxlZAo+
IG9uIGNwdSBjb3JlIFszXSBvbiBhIHF1ZXVlIHRoYXQgaXMgbWFwcGVkIHRvIGNwdSBjb3JlIFs3
NV0gY29ycmVjdD8KPiAKPj4gW8KgIDUyNC44Njc2MjJdIG52bWVfdGNwOsKgwqDCoMKgwqDCoMKg
IG52bWVfdGNwX3BvbGw6IFtRdWV1ZSBDUFUgM10sIFtDUFUgM10KPj4gW8KgIDUyNC44Njc2ODZd
IG52bWVfdGNwOsKgwqDCoMKgwqDCoMKgIG52bWVfdGNwX3BvbGw6IFtRdWV1ZSBDUFUgNzVdLCBb
Q1BVIDNdCj4gCj4gSSdtIGFzc3VtaW5nIHRoYXQgdGhpcyBpcyBhIHBvbGwgaW52b2NhdGlvbiBv
ZiBhIHByaW9yIHN1Ym1pc3Npb24gdG8KPiBxdWV1ZSB0aGF0IGlzIG1hcHBlZCB0byBDUFUgNzU/
Cj4gCj4+IFvCoCA1MjQuODY3NjkzXSBudm1lX3RjcDrCoMKgwqDCoMKgwqDCoCBudm1lX3RjcF9w
b2xsOiBbUXVldWUgQ1BVIDNdLCBbQ1BVIDNdCj4+IFvCoCA1MjQuODY3NzU1XSBudm1lX3RjcDog
bnZtZV90Y3BfcXVldWVfcmVxdWVzdDogSU8tUSBbUXVldWUgQ1BVIDc1XSwgCj4+IFtDUFUgNzVd
Cj4gCj4gVGhpcyBsb2cgcHJpbnQgbWVhbnMgdGhhdCBvbiBjcHUgY29yZSBbM10gd2Ugc2VlIGEg
cmVxdWVzdCBzdWJtaXR0ZWQgb24KPiBhIHF1ZXVlIHRoYXQgaXMgbWFwcGVkIHRvIGNwdSBjb3Jl
IFs3NV0gY29ycmVjdD8KPiAKPj4gW8KgIDUyNC44Njc3NThdIG52bWVfdGNwOsKgwqDCoMKgwqDC
oMKgIG52bWVfdGNwX3BvbGw6IFtRdWV1ZSBDUFUgNzVdLCBbQ1BVIDNdCj4+IFvCoCA1MjQuODY3
Nzc3XSBudm1lX3RjcDogbnZtZV90Y3BfcXVldWVfcmVxdWVzdDogSU8tUSBbUXVldWUgQ1BVIDNd
LCAKPj4gW0NQVSAzXQo+PiBbwqAgNTI0Ljg2Nzc4MV0gbnZtZV90Y3A6wqDCoMKgwqDCoMKgwqAg
bnZtZV90Y3BfcG9sbDogW1F1ZXVlIENQVSAzXSwgW0NQVSAzXQo+PiBbwqAgNTI0Ljg2Nzg1M10g
bnZtZV90Y3A6wqDCoMKgwqDCoMKgwqAgbnZtZV90Y3BfcG9sbDogW1F1ZXVlIENQVSA3NV0sIFtD
UFUgM10KPj4gW8KgIDUyNC44Njc4NjRdIG52bWVfdGNwOsKgwqDCoMKgwqDCoMKgIG52bWVfdGNw
X3BvbGw6IFtRdWV1ZSBDUFUgM10sIFtDUFUgM10KPj4KPj4gU28sIGlmIHNvbWVvbmUgY2FuIGhl
bHAgc29sdmUgdGhpcyBwdXp6bGUgYW5kIGhlbHAgbWUgdW5kZXJzdGFuZCB3aGF0IAo+PiBpcyBj
YXVzaW5nIHRoaXMgYmVoYXZpb3IgdGhhdCB3b3VsZCBiZSBncmVhdC7CoCBIYXJkIGZvciBtZSB0
byB0aGluayAKPj4gdGhpcyBpcyBhbiBleHBlY3RlZCwgb3IgYmVuZWZpY2lhbCBiZWhhdmlvciwg
dG8gaGF2ZSBhIG5lZWQgdG8gdXNlIAo+PiBzb21lIG90aGVyIGNvcmUvcXVldWUgZm9yIGxlc3Mg
dGhhbiAxMDAgcmVxdWVzdHMgb3V0IG9mIG92ZXIgMiBtaWxsaW9uLgo+IAo+IEknbSBhc3N1bWlu
ZyB0aGF0IHRoaXMgcGhlbm9tZW5vbiBoYXBwZW5zIGFsc28gd2l0aG91dCBwb2xsaW5nPwo+IAo+
IEFueXdheXMsIGl0IGlzIHVuZXhwZWN0ZWQgdG8gbWUsIGdpdmVuIHRoYXQgeW91IGhhdmUgYSBx
dWV1ZSB0aGF0IGlzCj4gbWFwcGVkIHRvIHRoZSBjcHUgeW91IGFyZSBwaW5uaW5nIG9uLCBJJ2Qg
ZXhwZWN0IHRoYXQgYWxsIHJlcXVlc3QKPiB0aGF0IGFyZSBnZW5lcmF0ZWQgb24gdGhpcyBjcHUg
d291bGQgYmUgc3VibWl0dGVkIG9uIHRoYXQgc2FtZQo+IHF1ZXVlLi4KPiAKPiBBbnlvbmUgaGFz
IGFueSBpbnNpZ2h0cyBvbiB0aGlzPwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=
