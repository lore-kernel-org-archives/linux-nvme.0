Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F60C433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 18:16:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C06613D7
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 18:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C06613D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9XGozpFn7P8cTRdG39Rzy5Cqk35s5w3CoNwXQ+Eci2Y=; b=nPkZX09PsmVdV8qc/QL909EES
	org4wNDpgipIm0pROGyDNqfqSuGgpPGQvlOnjlv5CX5kWe+yxrH9GFzqHcvDmC7FNwquYutk/iylH
	pYr+jNuNtIpRDWJJsEBVhM+aNmnSdMWNOLzmWoCzn5LjVVk3k1gE2Nizg2Xeeumjp4usJtWjo9Ci2
	TSGoSVk64h1V225RNXq+Er9O8lhyDb9jniLN3q03N0KNMLltZFDR1qRZyO9EnLIIKvTn5uV8oZcjz
	9Bj8oCxlPQHs2Ct9IJ9b5boWZYFvV/K9WJQw85aBUbuQsSsJgM1x3OQ5X/FfMCiDaxX6GJ6GVxXIU
	Jdsm8YrSw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldza8-00GlGn-U4; Tue, 04 May 2021 18:15:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldza5-00GlGZ-Im
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 18:15:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=uX+ykjupH3hsaVhonD+BG9Ehm5KsjYIXVwv9FGfN+/c=; b=nReF62fhlrdMWU5P2G8W3rPoXK
 vEdvRKyLGkf7sWgLQbj/VuAlEjq2eALgZQTs8cFBvoC645D2jA+nndeOrCA/ZhOiF2Y/L3Mgi4KkR
 880U4eXd15jWUEDq49YIw4ZgpZtu5IulwUJzbDrldYo7j0y3wE4pCeu4ZYCKh7aZR9r/rrtqxabc0
 gHz7z9eCBMvdzDCGjnxSllSkOq0fiybw5OCwNtfL96vTowtV+b8y2SNy8BvDushULISHIu/T1+Gq6
 zc2uzevSuZlyFv7qpLZQdVzoPvb15Q4H0eiXrpfGiu7nN4PMZAdLThbB8WbgVWmEMnk5HgmVMEjD0
 +5BG/5AA==;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldza2-004AYU-Tz
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 18:15:36 +0000
Received: by mail-wm1-f43.google.com with SMTP id s82so6047742wmf.3
 for <linux-nvme@lists.infradead.org>; Tue, 04 May 2021 11:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uX+ykjupH3hsaVhonD+BG9Ehm5KsjYIXVwv9FGfN+/c=;
 b=jxtWyORWwcpPe7sjKagXa/IrkAkavXbd/dY4jr2YFOm3REl8AQtJlPQzqdBNJfNnEx
 G8mbZUEHI2qhI5rCFj1ohcDgMIUKWqOjemCrVcLlHq7KZovt98U8Uy9f2LEgYQlm0bnk
 WEj4qkEUeC43efjpfQBgcd7Ctz4pZACKSjaUGiYPNDXT3t+r0ZIZDxReBZTXt/0yQec2
 RO4X4ITCko+uVKBqN/Aj7XsE3mh2KrLNma2UFnufe+mAAqGU8SZs9xRhrHM8GJQ1mgrz
 D5Awk53TsNSjPgRtqYyU6hVfdtEJkOu3F6aKWDpfwDq/O0K9kvtGSUiLd0xKfGbUJo1L
 W9wA==
X-Gm-Message-State: AOAM5309ztyCo0v/lFSQnbCEN330SDeGT2DkeVpbgvPE596ka0Ay0N2P
 yw024Kt+8ZZZQResWmVF4ZQ=
X-Google-Smtp-Source: ABdhPJxLz0hKLXxPxbW7CrlKplfrw1AmgnMtdGPdxkhQmGX64MiagxDylnseyIYOtwMYCJanbZuEVA==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr5446919wmi.19.1620152131197; 
 Tue, 04 May 2021 11:15:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:223b:6f63:9746:74b7?
 ([2601:647:4802:9070:223b:6f63:9746:74b7])
 by smtp.gmail.com with ESMTPSA id a126sm3188388wmh.37.2021.05.04.11.15.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 11:15:30 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
 <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
 <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
 <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
 <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
 <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
Date: Tue, 4 May 2021 11:15:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_111534_990622_102A1C3E 
X-CRM114-Status: GOOD (  25.23  )
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

Cj4+Pj4+Pj4gSGV5IEtlaXRoLAo+Pj4+Pj4+Cj4+Pj4+Pj4gRGlkIHRoaXMgcmVzb2x2ZSB0aGUg
aXNzdWVzPwo+Pj4+Pj4KPj4+Pj4+IFdlJ3JlIHVuZm9ydHVuYXRlbHkgc3RpbGwgb2JzZXJ2aW5n
IGRhdGEgZGlnZXN0IGlzc3VlcyBldmVuIHdpdGggdGhpcy4KPj4+Pj4+IE1vc3Qgb2YgdGhlIHRl
c3RpbmcgaGFzIHNoaWZ0ZWQgdG8gdGhlIHIydCBlcnJvciwgc28gSSBkb24ndCBoYXZlIGFueQo+
Pj4+Pj4gYWRkaXRpb25hbCBkZXRhaWxzIG9uIHRoZSBkYXRhIGRpZ2VzdCBwcm9ibGVtLgo+Pj4+
Pgo+Pj4+PiBJJ3ZlIGxvb2tlZCBhZ2FpbiBhdCB0aGUgY29kZSwgYW5kIEknbSBub3QgY29udmlu
Y2VkIHRoYXQgdGhlIHBhdGNoCj4+Pj4+IGlzIG5lZWRlZCBhdCBhbGwgYW55bW9yZSwgSSdtIG5v
dyBzdXJwcmlzZWQgdGhhdCBpdCBhY3R1YWxseSBjaGFuZ2VkCj4+Pj4+IGFueXRoaW5nIChkaXNy
ZWdhcmRpbmcgZGF0YSBkaWdlc3QpLgo+Pj4+Pgo+Pj4+PiBUaGUgZHJpdmVyIGRvZXMgbm90IHRy
YWNrIHRoZSByZWNlaXZlZCBieXRlcyBieSBkZWZpbml0aW9uLCBpdCByZWxpZXMKPj4+Pj4gb24g
dGhlIGNvbnRyb2xsZXIgdG8gc2VuZCBpdCBhIGNvbXBsZXRpb24sIG9yIHNldCB0aGUgc3VjY2Vz
cyBmbGFnIGluCj4+Pj4+IHRoZSBfbGFzdF8gYzJoZGF0YSBwZHUuIERvZXMgeW91ciB0YXJnZXQg
c2V0Cj4+Pj4+IE5WTUVfVENQX0ZfREFUQV9TVUNDRVNTIG9uIGFueSBvZiB0aGUgYzJoZGF0YSBw
ZHVzPwo+Pj4+Cj4+Pj4gUGVyaGFwcyB5b3UgY2FuIGFsc28gcnVuIHRoaXMgcGF0Y2ggaW5zdGVh
ZD8KPj4+Cj4+PiBUaGFua3MsIHdpbGwgZ2l2ZSB0aGlzIGEgc2hvdC4KPj4KPj4gU3RpbGwgd291
bGQgYmUgYmVuZWZpY2lhbCB0byBsb29rIGF0IHRoZSB0cmFjZXMgYW5kIGNoZWNrIGlmCj4+IHRo
ZSBzdWNjZXNzIGZsYWcgaGFwcGVucyB0byBiZSBzZXQuIElmIHRoaXMgZmxhZyBpcyBzZXQsIHRo
ZQo+PiBkcml2ZXIgX3dpbGxfIGNvbXBsZXRlIHRoZSByZXF1ZXN0IHdpdGhvdXQgY2hlY2tpbmcg
dGhlIGJ5dGVzCj4+IHJlY2VpdmVkIHRodXMgZmFyIChzaW1pbGFyIHRvIGhvdyBwY2kgYW5kIHJk
bWEgZG9uJ3QgYW5kIGNhbid0Cj4+IGNoZWNrIGRtYSBieXRlIGNvdW50KS4KPiAKPiBJIHJlYWxp
emVkIHRoaXMgcGF0Y2ggaXMgdGhlIHNhbWUgYXMgb25lIHlvdSdkIHNlbnQgZWFybGllci4gV2Ug
aGl0IHRoZQo+IEJVR19PTigpLCBhbmQgdGhlbiBwcm9jZWVkZWQgdG8gdXNlIHlvdXIgZm9sbG93
LXVwIHBhdGNoLCB3aGljaCBhcHBlYXJlZAo+IHRvIGZpeCB0aGUgZGF0YSByZWNlaXZlIHByb2Js
ZW0sIGJ1dCBpbnRyb2R1Y2VkIGRhdGEgZGlnZXN0IHByb2JsZW1zLgo+IAo+IFNvLCBhcmUgeW91
IHNheWluZyB0aGF0IGhpdHRpbmcgdGhpcyBCVUdfT04gbWVhbnMgdGhhdCB0aGUgZHJpdmVyIGhh
cwo+IG9ic2VydmVkIHRoZSBjb21wbGV0aW9uIG91dC1vZi1vcmRlciBmcm9tIHRoZSBleHBlY3Rl
ZCBkYXRhPwoKSWYgeW91IGhpdCB0aGUgQlVHX09OIGl0IG1lYW5zIHRoYXQgdGhlIGhvc3Qgc3Bv
dHRlZCBhIGMyaGRhdGEKUERVIHRoYXQgaGFzIHRoZSBzdWNjZXNzIGZsYWcgc2V0IGJlZm9yZSBh
bGwgdGhlIHJlcXVlc3QgZGF0YQp3YXMgcmVjZWl2ZWQ6Ci0tCkBAIC03NTksNiArNzYxLDcgQEAg
c3RhdGljIGludCBudm1lX3RjcF9yZWN2X2RhdGEoc3RydWN0IG52bWVfdGNwX3F1ZXVlIAoqcXVl
dWUsIHN0cnVjdCBza19idWZmICpza2IsCiAgICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZS0+
ZGRnc3RfcmVtYWluaW5nID0gTlZNRV9UQ1BfRElHRVNUX0xFTkdUSDsKICAgICAgICAgICAgICAg
ICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHBkdS0+aGRyLmZsYWdzICYg
TlZNRV9UQ1BfRl9EQVRBX1NVQ0NFU1MpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBCVUdfT04ocmVxLT5kYXRhX3JlY2VpdmVkICE9IHJlcS0+ZGF0YV9sZW4pOwogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBudm1lX3RjcF9lbmRfcmVxdWVzdChycSwgTlZNRV9TQ19T
VUNDRVNTKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcXVldWUtPm5yX2NxZSsr
OwogICAgICAgICAgICAgICAgICAgICAgICAgfQotLQoKV2hpY2ggbWVhbnMgdGhhdCB0aGUgaG9z
dCBpcyBjb21wbGV0aW5nIHRoZSByZXF1ZXN0IGltbWVkaWF0ZWx5IHJlbHlpbmcKb24gdGhlIGNv
bnRyb2xsZXIgc2VudCBhbGwgdGhlIHJlcXVpcmVkIGRhdGEgYW5kIGtub3dpbmcgdGhhdCBhCmNv
bXBsZXRpb24gcmVzcG9uc2UgY2Fwc3VsZSB3aWxsIG5vdCBiZSBzZW50LgoKIEZyb20gdGhlIHNw
ZWM6CkMySERhdGEgUERVcyBjb250YWluIGEgTEFTVF9QRFUgZmxhZyB0aGF0IGlzIHNldCB0byDi
gJgx4oCZIGluIHRoZSBsYXN0IFBEVQpvZiBhIGNvbW1hbmQgZGF0YSB0cmFuc2ZlciBhbmQgaXMg
Y2xlYXJlZCB0byDigJgw4oCZIGluIGFsbCBvdGhlciBDMkhEYXRhClBEVXMgYXNzb2NpYXRlZCB3
aXRoIHRoZSBjb21tYW5kLiBDMkhEYXRhIFBEVXMgYWxzbyBjb250YWluIGEgU1VDQ0VTUwpmbGFn
IHRoYXQgbWF5IGJlIHNldCB0byDigJgx4oCZIGluIHRoZSBsYXN0IEMySERhdGEgUERVIG9mIGEg
Y29tbWFuZCBkYXRhCnRyYW5zZmVyIHRvIGluZGljYXRlIHRoYXQgdGhlIGNvbW1hbmQgaGFzIGNv
bXBsZXRlZCBzdWNjZXNzZnVsbHkuIEluCnRoaXMgY2FzZSwgbm8gUmVzcG9uc2UgQ2Fwc3VsZSBp
cyBzZW50IGJ5IHRoZSBjb250cm9sbGVyIGZvciB0aGUgY29tbWFuZCAKYW5kIHRoZSBob3N0IHN5
bnRoZXNpemVzIGEgY29tcGxldGlvbiBxdWV1ZSBlbnRyeSBmb3IgdGhlIGNvbW1hbmQgd2l0aAp0
aGUgQ29tbWFuZCBTcGVjaWZpYyBmaWVsZCBhbmQgdGhlIFN0YXR1cyBGaWVsZCBib3RoIGNsZWFy
ZWQgdG8gMGguIElmCnRoZSBTVUNDRVNTIGZsYWcgaXMgY2xlYXJlZCB0byDigJgw4oCZIGluIHRo
ZSBsYXN0IEMySERhdGEgUERVIG9mIGEgY29tbWFuZCwKdGhlbiB0aGUgY29udHJvbGxlciBzaGFs
bCBzZW5kIGEgUmVzcG9uc2UgQ2Fwc3VsZSBmb3IgdGhlIGNvbW1hbmQgdG8gdGhlCmhvc3QuIFRo
ZSBTVUNDRVNTIGZsYWcgc2hhbGwgYmUgY2xlYXJlZCB0byDigJgw4oCZIGluIGFsbCBDMkhEYXRh
IFBEVXMgdGhhdAphcmUgbm90IHRoZSBsYXN0IEMySERhdGEgUERVIGZvciBhIGNvbW1hbmQuIFRo
ZSBTVUNDRVNTIGZsYWcgbWF5IGJlIHNldAp0byDigJgx4oCZIGluIHRoZSBsYXN0IEMySERhdGEg
UERVIG9ubHkgaWYgdGhlIGNvbnRyb2xsZXIgc3VwcG9ydHMgZGlzYWJsaW5nCnN1Ym1pc3Npb24g
cXVldWUgaGVhZCBwb2ludGVyIHVwZGF0ZXMuCgpIZW5jZSBteSBxdWVzdGlvbiwgZG9lcyB0aGUg
Y29udHJvbGxlciBzZXQgTlZNRV9UQ1BfRl9EQVRBX1NVQ0NFU1MgaW4KYW55IG9mIHRoZSBjMmhk
YXRhIFBEVXMgd2hpY2ggaXMgbm90IHRoZSBsYXN0IG9uZT8gZG9lcyBpdCBzZXQgaXQgaW4gdGhl
Cmxhc3Qgb25lIGFuZCBvbWl0dGluZyB0aGUgY3FlIHJlc3BvbnNlIGNhcHN1bGUgYXMgZXhwZWN0
ZWQgYnkgdGhlIGhvc3Q/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
