Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6349EC33CAF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 23:53:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A27206B7
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HA5J3G9y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HNTw8mml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A27206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AR1Sbz9nmAIz/gDoq9JG1+MOxk8dZUBDLyDlbaVQwos=; b=HA5J3G9y2eQ/rNxrxm1J9L6GB
	66UPLZFBwXMh8gJI0OEmw0ZC4H4DnEgVBVxrMRfHjH0MaWgNNeyAJtNVqSz0aBpGWKeA/Yhg9TP9N
	AiJpiA3wRuHXmMLqIrblPWgZtMTLscemkf9Z6ZocVLV1ajE9Gb5btz+5FCMJAGuQlpdQSMknucRAN
	adHrJCbw0NxY3ASXiEJDnPFQxhdIaNy1vCoQ1H4J/1spCP/VIpYalcCaFToXbUMHWFnLfiE8+2iD6
	PL0g52iqu5RXNzO77BAQREkcDMG/HnQIjfezjhXIOzKwYfllinN43+lNci6yxg3juZ9+E82i9fvr3
	GV1gFBkPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1isExF-0006Bs-9b; Thu, 16 Jan 2020 23:53:37 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1isExD-0006BH-1F
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 23:53:36 +0000
Received: by mail-wm1-x343.google.com with SMTP id d139so8274830wmd.0
 for <linux-nvme@lists.infradead.org>; Thu, 16 Jan 2020 15:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GOd3uuYYAGHE4hOiwlGZHh8UMMT83OjAKVyNBhbdVJk=;
 b=HNTw8mml/V+wOPyRV2pY+tVIGlHnyoQO3pGt9EjbaeWxk7U8dZhCX9kzIwpnBKSNtZ
 xD3mScQayzW0KtxLxzC2eyainIIdT+ujW614wJq3TkXSjsxjGcxrkqirU9Od+ZhW0RYH
 zf1xeAQKXCUddDMAG5sFbaa0+8fjPS7wknCow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GOd3uuYYAGHE4hOiwlGZHh8UMMT83OjAKVyNBhbdVJk=;
 b=SkRP1UHaJg56z5JHWSeBeHLdRgtXZ6XFP+CF4Q+JLK2Xbm1VekiTPd3wX4dSu76cF6
 hr7qSKK812k5CiegPEhdrnEbJojrmYRfyqIXm86r5MFXoWdjz42AUVpHj1yUFw8koNLS
 dnyLn0m42yyn1R+neG25YGOK5dREtxAXgp2ycEDE+3SL9UeEwgLTbnurHSyL8f0NrtNV
 Z3YubHssU+huvX3hY3oneXeAlIh59nTzWqLkvaz4fuQuO43q+6C0dtxY68MYc2VoTuMM
 tq+5KQ8qF/ihA8DGMX3ZNX3nZBNHV6uAxdua/TRU17kSQ1atHNp1NP4iXUwYdulPHxE2
 jRwA==
X-Gm-Message-State: APjAAAUKrlZZKIQ/2ngVWQGYStCOWwkU3+guTkPGpIB24TNqFG+NcXSK
 HKuTqQKJraaiydD0GivHzhluRw==
X-Google-Smtp-Source: APXvYqwrFBO3NkZZYtWtVL7pk2wLakpVxZra9nR1j4XVPImB1NAD4EG4OtWPE81gKxmpu7DvtD4QUA==
X-Received: by 2002:a05:600c:2318:: with SMTP id
 24mr1581435wmo.48.1579218813253; 
 Thu, 16 Jan 2020 15:53:33 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id n14sm6838250wmi.26.2020.01.16.15.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 15:53:32 -0800 (PST)
Subject: Re: [PATCH 02/15] nvme: Enforce extended LBA format for fabrics
 metadata
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-4-maxg@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <57aa8b5c-b8c9-7617-bc11-b6797587fdc8@broadcom.com>
Date: Thu, 16 Jan 2020 15:53:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106133736.123038-4-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200116_155335_076986_FA05A1A5 
X-CRM114-Status: GOOD (  19.25  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, shlomin@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxLzYvMjAyMCA1OjM3IEFNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4gQW4gZXh0ZW5kZWQg
TEJBIGlzIGEgbGFyZ2VyIExCQSB0aGF0IGlzIGNyZWF0ZWQgd2hlbiBtZXRhZGF0YSBhc3NvY2lh
dGVkCj4gd2l0aCB0aGUgTEJBIGlzIHRyYW5zZmVycmVkIGNvbnRpZ3VvdXNseSB3aXRoIHRoZSBM
QkEgZGF0YSAoQUtBCj4gaW50ZXJsZWF2ZWQpLiBUaGUgbWV0YWRhdGEgbWF5IGJlIGVpdGhlciB0
cmFuc2ZlcnJlZCBhcyBwYXJ0IG9mIHRoZSBMQkEKPiAoY3JlYXRpbmcgYW4gZXh0ZW5kZWQgTEJB
KSBvciBpdCBtYXkgYmUgdHJhbnNmZXJyZWQgYXMgYSBzZXBhcmF0ZQo+IGNvbnRpZ3VvdXMgYnVm
ZmVyIG9mIGRhdGEuIEFjY29yZGluZyB0byB0aGUgTlZNZW9GIHNwZWMsIGEgZmFicmljcyBjdHJs
Cj4gc3VwcG9ydHMgb25seSBhbiBFeHRlbmRlZCBMQkEgZm9ybWF0LiBGYWlsIHJldmFsaWRhdGlv
biBpbiBjYXNlIHdlIGhhdmUgYQo+IHNwZWMgdmlvbGF0aW9uLiBBbHNvIGluaXRpYWxpemUgdGhl
IGludGVncml0eSBwcm9maWxlIGZvciB0aGUgYmxvY2sgZGV2aWNlCj4gZm9yIGZhYnJpY3MgY3Ry
bC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0b3ZveSA8bWF4Z0BtZWxsYW5veC5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogSXNyYWVsIFJ1a3NoaW4gPGlzcmFlbHJAbWVsbGFub3guY29tPgo+IC0t
LQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysr
LS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCj4gaW5kZXggZDk4ZWI0OC4uMDg5Y2RjM2MgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4g
QEAgLTE4MTgsNyArMTgxOCw3IEBAIHN0YXRpYyB2b2lkIG52bWVfdXBkYXRlX2Rpc2tfaW5mbyhz
dHJ1Y3QgZ2VuZGlzayAqZGlzaywKPiAgIAlibGtfbXFfdW5mcmVlemVfcXVldWUoZGlzay0+cXVl
dWUpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIF9fbnZtZV9yZXZhbGlkYXRlX2Rpc2soc3Ry
dWN0IGdlbmRpc2sgKmRpc2ssIHN0cnVjdCBudm1lX2lkX25zICppZCkKPiArc3RhdGljIGludCBf
X252bWVfcmV2YWxpZGF0ZV9kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBzdHJ1Y3QgbnZtZV9p
ZF9ucyAqaWQpCj4gICB7Cj4gICAJc3RydWN0IG52bWVfbnMgKm5zID0gZGlzay0+cHJpdmF0ZV9k
YXRhOwo+ICAgCj4gQEAgLTE4NDYsMTEgKzE4NDYsMjEgQEAgc3RhdGljIHZvaWQgX19udm1lX3Jl
dmFsaWRhdGVfZGlzayhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0IG52bWVfaWRfbnMgKmlk
KQo+ICAgCQkJbnMtPmZlYXR1cmVzIHw9IE5WTUVfTlNfRVhUX0xCQVM7Cj4gICAKPiAgIAkJLyoK
PiArCQkgKiBGb3IgRmFicmljcywgb25seSBtZXRhZGF0YSBhcyBwYXJ0IG9mIGV4dGVuZGVkIGRh
dGEgTEJBIGlzCj4gKwkJICogc3VwcG9ydGVkLiBGYWlsIGluIGNhc2Ugb2YgYSBzcGVjIHZpb2xh
dGlvbi4KPiArCQkgKi8KPiArCQlpZiAobnMtPmN0cmwtPm9wcy0+ZmxhZ3MgJiBOVk1FX0ZfRkFC
UklDUykgewo+ICsJCQlpZiAoV0FSTl9PTl9PTkNFKCEobnMtPmZlYXR1cmVzICYgTlZNRV9OU19F
WFRfTEJBUykpKQo+ICsJCQkJcmV0dXJuIC1FSU5WQUw7Cj4gKwkJfQo+ICsKPiArCQkvKgo+ICAg
CQkgKiBGb3IgUENJLCBFeHRlbmRlZCBsb2dpY2FsIGJsb2NrIHdpbGwgYmUgZ2VuZXJhdGVkIGJ5
IHRoZQo+ICAgCQkgKiBjb250cm9sbGVyLgo+ICAgCQkgKi8KPiAgIAkJaWYgKG5zLT5jdHJsLT5v
cHMtPmZsYWdzICYgTlZNRV9GX01FVEFEQVRBX1NVUFBPUlRFRCkgewo+IC0JCQlpZiAoIShucy0+
ZmVhdHVyZXMgJiBOVk1FX05TX0VYVF9MQkFTKSkKPiArCQkJaWYgKG5zLT5jdHJsLT5vcHMtPmZs
YWdzICYgTlZNRV9GX0ZBQlJJQ1MgfHwKPiArCQkJICAgICEobnMtPmZlYXR1cmVzICYgTlZNRV9O
U19FWFRfTEJBUykpCj4gICAJCQkJbnMtPmZlYXR1cmVzIHw9IE5WTUVfTlNfRElYX1NVUFBPUlRF
RDsKClRoaXMgbGFzdCBjaGFuZ2Ugc2VlbXMgb2RkIC0gd2h5IGlzIERJWCBzZXQgaWYgTlZNRV9G
X0ZBQlJJQ1MgPwoKUGVyIHBhdGNoIGRlc2NyaXB0aW9uIGFib3ZlLCBGYWJyaWNzIHNwZWMgcmVx
dWlyZXMgbWV0YWRhdGEgYXMgYW4gCmV4dGVuZGVkIExCQSwgdGh1cyBpdCBkb2Vzbid0IHN1cHBv
cnQgRElYLgoKV2hpY2ggaXMgdG91Y2hlcyBvbiBhIGxvdCBvZiBvZGQgdGhpbmdzIHdpdGggdGhl
IG52bWUgc3BlYyBhcyBpdCdzIApjZXJ0YWlubHkgcG9zc2libGUgZm9yLCB3aXRoaW4gdGhlIG9z
IGhvc3QgaW1wbGVtZW50YXRpb24sIHRvIGhhdmUgdGhlIApob3N0IHRyYW5zbWl0dGluZyBlbmdp
bmUgdG8gY29udmVydCBhbiBPUyBzZXBhcmF0ZSBESUYgYnVmIHRvIGFuIApleHRlbmRlZCBsYmEg
dHJhbnNtaXNzaW9uIG9uIHRoZSB3aXJlIGFuZCBhcyBwcmVzZW50ZWQgdG8gdGhlIApjb250cm9s
bGVyLsKgIFRyYW5zcG9ydHMgY2FuIGNlcnRhaW5seSBoZWxwIG1ha2UgdGhpcyBoYXBwZW4gLSBh
bmQgYWRkIAplZ3Jlc3MgY2hlY2tpbmcgYXMgdGhlIGRhdGEgbGVhdmVzIHRoZSBob3N0LsKgwqDC
oCBXaGljaCBtZWFucyAtIEknbSBub3QgCnN1cmUgdGhpcyBoYXJkIERJWCBkZWZpbml0aW9uIGJl
aW5nIGltcGxlbWVudGVkIHRoaXMgd2F5IGlzIHRoZSB3YXkgdG8gZ28uCgotLSBqYW1lcwoKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1l
IG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
