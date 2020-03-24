Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F383C2BAEE
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 16:21:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90E620774
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 16:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eI0bR4ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90E620774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DXONwPqkSUM8CEZKG1gF0WnS2BpWR3qEqTAMdzpq2IE=; b=eI0bR4irWy4i/q/M59enPwvpD
	bo0/EjyEEI9FPBjb7ETHPUAVPtv2k5musgU1cIuCFZJmSd9BR88ziciiBpHuF8KVGlHWJMgVRauRO
	+/RzDWraGzDSWacT6YwraPxLEsYBrOsmGhkk4RpTmMcQcVYbOxftNhh2ZdPPL94SZ4bwzW9POmdzt
	1+xsjqzNtX2fE2J2NDOWA9PccwaT1LofJNmIkdsvazGPH8TD7E3b7QXe6JSZh65nX/qTw7/3outW3
	2jCOW4UGsDpypvAwdwwwZdLp7U16EAKT7FFlIi2MqXYqXVrrmeU1L4dAz90mtCcpXKGvqlDgp9JPL
	gvUIEUcAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGmIz-0004wO-M7; Tue, 24 Mar 2020 16:21:29 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGmIw-0004vk-NH
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 16:21:28 +0000
Received: by mail-pl1-f195.google.com with SMTP id h11so7581709plk.7
 for <linux-nvme@lists.infradead.org>; Tue, 24 Mar 2020 09:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HHqjFDo9EhD6L2jqJhlBGLfqAyQ3vK+MrzsK92O6R0k=;
 b=k7dMPGgL+nhLHTo9URqAZy3wYhRQj4MW73A02HjSMKCNzzx0XvlCGt6zY8+RRFChQo
 zNHd0cg5yoIAJaoo0Mu+1Lqh8Co3lRU2SwToivgzDDJEhHI5sXgaNv1XX/K5JhrMYvUI
 /XUn5NWbAISgCo7MZB2SdW518Ot7R+gqsM1AppduvwPsq5Mrbo9KZIJMWS4Rwn8xFOSC
 9pWHjKh2fjq4Np3mBBeSC5LHXuSLDxMEsC5YQzlxDZXFpfvILgkm+RscIM/vMdRo5E3L
 VnHc1vjqGk6+z4zJrzuBdQuuAw/dH6d2DciBFqk/UN656C+8IvZmlTOrqYRIzyKFbQMD
 eHwg==
X-Gm-Message-State: ANhLgQ3qUGuiQHRsyrjnTPqVft6b8lLzFU7YH3Dw3lOE+dXXMRkEcuAn
 aqXpCRYgHLZxSh3Fawsk4TDqwWrq
X-Google-Smtp-Source: ADFU+vsv/dehS4lKCXcCQWLEoc6ku5qct+99nkYYj2HwPDp+P+WL4qLGX1mVxDYXXU/uNQGhIc7qpA==
X-Received: by 2002:a17:902:ab95:: with SMTP id
 f21mr25021544plr.188.1585066885516; 
 Tue, 24 Mar 2020 09:21:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45a4:15de:f2dc:1149?
 ([2601:647:4802:9070:45a4:15de:f2dc:1149])
 by smtp.gmail.com with ESMTPSA id r189sm4500935pgr.31.2020.03.24.09.21.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2020 09:21:24 -0700 (PDT)
Subject: Re: [PATCH rfc 2/2] fabrics: allow user to pass hostname instead of
 traddr
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20200324090324.24459-1-sagi@grimberg.me>
 <20200324090324.24459-3-sagi@grimberg.me>
 <b5812c46-7763-1581-e9a7-2e2927ccee18@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <233d0600-7d91-7a12-b58f-347697fa6bc0@grimberg.me>
Date: Tue, 24 Mar 2020 09:21:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b5812c46-7763-1581-e9a7-2e2927ccee18@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_092126_761397_D78B4BEA 
X-CRM114-Status: GOOD (  17.40  )
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

CgpPbiAzLzI0LzIwIDI6NDYgQU0sIE1heCBHdXJ0b3ZveSB3cm90ZToKPiAKPiBPbiAzLzI0LzIw
MjAgMTE6MDMgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+IFNvbWUgdXNlcnMgd291bGQgbGlr
ZSB0byB1c2Ugd2VsbCBrbm93biBob3N0bmFtZXMgaW5zdGVhZAo+PiBvZiByZW1lbWJlcmluZyBp
cCBhZGRyZXNzZXMuIFNvLCBhbGxvdyB1c2VycyB0byBwYXNzIC0taG9zdG5hbWUKPj4gYW5kIHdl
IHdpbGwgYXR0ZW1wdCB0byByZXNvbHZlIGFnYWluc3QgdGhlIEROUy4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KPj4gLS0tCj4+IMKgIGZhYnJp
Y3MuYyB8IDc1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKykKPj4KPj4gZGlm
ZiAtLWdpdCBhL2ZhYnJpY3MuYyBiL2ZhYnJpY3MuYwo+PiBpbmRleCBhN2Q2MjhiMWYwYzkuLjdi
ZDk1YzRiMGQxMCAxMDA2NDQKPj4gLS0tIGEvZmFicmljcy5jCj4+ICsrKyBiL2ZhYnJpY3MuYwo+
PiBAQCAtMzMsNiArMzMsMTAgQEAKPj4gwqAgI2luY2x1ZGUgPHN5cy9zdGF0Lmg+Cj4+IMKgICNp
bmNsdWRlIDxzdGRkZWYuaD4KPj4gKyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KPj4gKyNpbmNsdWRl
IDxhcnBhL2luZXQuaD4KPj4gKyNpbmNsdWRlIDxuZXRkYi5oPgo+PiArCj4+IMKgICNpbmNsdWRl
ICJ1dGlsL3BhcnNlci5oIgo+PiDCoCAjaW5jbHVkZSAibnZtZS1pb2N0bC5oIgo+PiDCoCAjaW5j
bHVkZSAibnZtZS1zdGF0dXMuaCIKPj4gQEAgLTYwLDYgKzY0LDcgQEAgc3RhdGljIHN0cnVjdCBj
b25maWcgewo+PiDCoMKgwqDCoMKgIGNoYXIgKm5xbjsKPj4gwqDCoMKgwqDCoCBjaGFyICp0cmFu
c3BvcnQ7Cj4+IMKgwqDCoMKgwqAgY2hhciAqdHJhZGRyOwo+PiArwqDCoMKgIGNoYXIgKmhvc3Ru
YW1lOwo+PiDCoMKgwqDCoMKgIGNoYXIgKnRyc3ZjaWQ7Cj4+IMKgwqDCoMKgwqAgY2hhciAqaG9z
dF90cmFkZHI7Cj4+IMKgwqDCoMKgwqAgY2hhciAqaG9zdG5xbjsKPj4gQEAgLTg1Nyw2ICs4NjIs
NTQgQEAgc3RhdGljIGludCBidWlsZF9vcHRpb25zKGNoYXIgKmFyZ3N0ciwgaW50IAo+PiBtYXhf
bGVuLCBib29sIGRpc2NvdmVyKQo+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiDCoCB9Cj4+ICtz
dGF0aWMgaW50IGhvc3RuYW1lMnRyYWRkcihzdHJ1Y3QgY29uZmlnICpjZmcpCj4+ICt7Cj4+ICvC
oMKgwqAgc3RydWN0IGFkZHJpbmZvICpob3N0X2luZm8sIGhpbnRzID0gey5haV9mYW1pbHkgPSBB
Rl9VTlNQRUN9Owo+PiArwqDCoMKgIGNoYXIgYWRkcnN0cltOVk1GX1RSQUREUl9TSVpFXTsKPj4g
K8KgwqDCoCBjb25zdCBjaGFyICpwOwo+PiArwqDCoMKgIGludCByZXQ7Cj4+ICsKPj4gK8KgwqDC
oCBpZiAoY2ZnLT50cmFkZHIpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGZwcmludGYoc3RkZXJyLCAi
aG9zdG5hbWUgYW5kIHRyYWRkciBjYW5ub3QgYmUgcGFzc2VkIAo+PiB0b2dldGhlclxuIik7Cj4+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8Kg
wqDCoCByZXQgPSBnZXRhZGRyaW5mbyhjZmctPmhvc3RuYW1lLCBOVUxMLCAmaGludHMsICZob3N0
X2luZm8pOwo+PiArwqDCoMKgIGlmIChyZXQpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGZwcmludGYo
c3RkZXJyLCAiZmFpbGVkIHRvIGdldCBob3N0IGluZm8gZm9yICVzXG4iLCAKPj4gY2ZnLT5ob3N0
bmFtZSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiArwqDCoMKgIH0KPj4gKwo+
PiArwqDCoMKgIHN3aXRjaCAoaG9zdF9pbmZvLT5haV9mYW1pbHkpIHsKPj4gK8KgwqDCoCBjYXNl
IEFGX0lORVQ6Cj4+ICvCoMKgwqDCoMKgwqDCoCBwID0gaW5ldF9udG9wKGhvc3RfaW5mby0+YWlf
ZmFtaWx5LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmKCgoc3RydWN0IHNvY2thZGRyX2lu
ICopaG9zdF9pbmZvLT5haV9hZGRyKS0+c2luX2FkZHIpLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhZGRyc3RyLCBOVk1GX1RSQUREUl9TSVpFKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFr
Owo+PiArwqDCoMKgIGNhc2UgQUZfSU5FVDY6Cj4+ICvCoMKgwqDCoMKgwqDCoCBwID0gaW5ldF9u
dG9wKGhvc3RfaW5mby0+YWlfZmFtaWx5LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmKCgo
c3RydWN0IHNvY2thZGRyX2luNiAqKWhvc3RfaW5mby0+YWlfYWRkciktPnNpbjZfYWRkciksCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZHJzdHIsIE5WTUZfVFJBRERSX1NJWkUpOwo+PiAr
wqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqAgZGVmYXVsdDoKPj4gK8KgwqDCoMKgwqDC
oMKgIGZwcmludGYoc3RkZXJyLCAidW5yZWNvZ25pemVkIGFkZHJlc3MgZmFtaWx5ICglZCkgJXNc
biIsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhvc3RfaW5mby0+YWlfZmFtaWx5LCBjZmct
Pmhvc3RuYW1lKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IC1FSU5WQUw7Cj4+ICvCoMKgwqDC
oMKgwqDCoCBnb3RvIGZyZWVfYWRkcmluZm87Cj4+ICvCoMKgwqAgfQo+PiArCj4+ICvCoMKgwqAg
aWYgKCFwKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBmcHJpbnRmKHN0ZGVyciwgImZhaWxlZCB0byBn
ZXQgdHJhZGRyIGZvciAlc1xuIiwgY2ZnLT5ob3N0bmFtZSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXQgPSAtZXJybm87Cj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGZyZWVfYWRkcmluZm87Cj4+ICvC
oMKgwqAgfQo+PiArwqDCoMKgIGNmZy0+dHJhZGRyID0gc3RyZHVwKGFkZHJzdHIpOwo+PiArCj4+
ICtmcmVlX2FkZHJpbmZvOgo+PiArwqDCoMKgIGZyZWVhZGRyaW5mbyhob3N0X2luZm8pOwo+PiAr
wqDCoMKgIHJldHVybiByZXQ7Cj4+ICt9Cj4+ICsKPj4gwqAgc3RhdGljIGludCBjb25uZWN0X2N0
cmwoc3RydWN0IG52bWZfZGlzY19yc3BfcGFnZV9lbnRyeSAqZSkKPj4gwqAgewo+PiDCoMKgwqDC
oMKgIGNoYXIgYXJnc3RyW0JVRl9TSVpFXSwgKnA7Cj4+IEBAIC0xMjMwLDYgKzEyODMsMTMgQEAg
c3RhdGljIGludCBkaXNjb3Zlcl9mcm9tX2NvbmZfZmlsZShjb25zdCBjaGFyIAo+PiAqZGVzYywg
Y2hhciAqYXJnc3RyLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNmZy5wZXJzaXN0ZW50ICYm
ICFjZmcua2VlcF9hbGl2ZV90bW8pCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNmZy5r
ZWVwX2FsaXZlX3RtbyA9IE5WTUZfREVGX0RJU0NfVE1POwo+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KGNmZy5ob3N0bmFtZSkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBob3N0bmFt
ZTJ0cmFkZHIoJmNmZyk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNmZy5ob3N0bmFtZSA9IE5VTEw7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICsK
PiAKPiBJIGd1ZXNzIHlvdSBhZGQgdGhlIE5VTEwgdG8gY2hlY2sgbXV0dWFsIGV4Y2x1c2lvbiBs
YXRlciA/CgpUaGUgTlVMTCBhc3NpZ25tZW50IGhlcmUgaXMgYmVjYXVzZSB3ZSBhcmUgbG9vcGlu
ZyBvbiB0aGUgY29uZgpmaWxlIGVudHJpZXMgd2hpY2ggY2FuIGhhdmUgYSBkaWZmZXJlbnQgaG9z
dG5hbWUuIFRoZSBvdGhlcgpsb2NhdGlvbnMgYXJlIGEgb25lLXNob3Qgc28gdGhpcyBhc3NpZ25t
ZW50IGlzIG5vdCBuZWVkZWQuCgo+IENhbiB3ZSBjaGVjayBpdCBpbiBidWlsZF9vcHRpb25zID8K
CldoZW4gd2UgZ2V0IGEgaG9zdG5hbWUgd2UgcmVzb2x2ZSB0aGUgdHJhZGRyIHdoaWNoIGlzIHdo
YXQKYnVpbGRfb3B0aW9ucyBuZWVkcyAoaG9zdG5hbWUgbm90IGFuIG9wdGlvbiB0aGF0IGlzIHBh
c3NlZCB0bwp0aGUgZHJpdmVyKS4KCkRvZXMgdGhhdCBhbnN3ZXIgeW91ciBxdWVzdGlvbj8KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
