Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5138C83004
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 04:54:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B481820661
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 04:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tOPiSTuQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sp3Ct+QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B481820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BbVEOTPUn9Py3EBemCDX5RT3s46OgaM4qTpFu0rM2zw=; b=tOPiSTuQQGW99I
	9bonFncoLt6QKl6kxV/OFLB123E6nh6fnCJFYMPqR4wQ3grCCdJS2Gf8B6s3Nn8soMQOLQLi+pHRV
	YPnMyI2TwE9Dn/L2N85gC+uvmz6J9WyBw6WwGXbNkec/3JGlrmtpou7Fk8njQWonF3UTeO9BTN4MD
	FCSytXibdha7kYOSjH+Ch5lxM2SC9xMIhTAr8EW3yHycjX4nOwHGLJ+ODmH/lIX5WrtKI6TbZYSwO
	VD9KlYN3CcZBY6KugYQyxGZjtLvVhsAQX7Zf/LlBo6ej9xtN4IDMnc+Or9BMUXS7zMQkmLhyeLFqf
	wEUJPFOPBW5rtR4X/SZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTIG2-0005Jq-VB; Tue, 28 Apr 2020 04:54:10 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTIFy-0005Hw-EI
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 04:54:09 +0000
Received: by mail-lj1-x243.google.com with SMTP id a21so20020900ljb.9
 for <linux-nvme@lists.infradead.org>; Mon, 27 Apr 2020 21:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JrjPs69r0pUjI4jiWO1HZG/wjkxDutGKz6XBMDQZWzU=;
 b=Sp3Ct+QAOIYkMPPYb8+ZTX2eAupbevFH6R2qOF98spZhleatVY1QJ5fLuRlronmMwm
 eJ5uID4NlgC2K5EJYj0qrbJxoTPTQKcdjYYvdjVM/y6H2WizHrMJe8S1E1MF8Y58vO3s
 T1xbs9g1wJQzLFypE/CfhPnRqv/Pf0uOEy2+KHxGgbd39auv0h/4PNzRvdnufjCCbHiV
 BeXfi54GotFuMkpPxVuR2OMEosQMNPsT7Dpc97ow21KbWQxB2FxXyP5fkZ+Tvuhi8iuJ
 gLCExSq86j5Mt6FIzLYexOxgcZx7LJnWqRrJwgU9+I6UgTRT7ukVrTpeOv4N5XWSKsR9
 Pjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JrjPs69r0pUjI4jiWO1HZG/wjkxDutGKz6XBMDQZWzU=;
 b=fBtgSGzodOBhzgnJUiBaec6sX1JHYBIJHharl9mSU9RCSo34/LFl77hRsajrPdtr59
 vuWkBaNROwWX07puap1EQF8tXIziQUbP7m9D/QbxGdHR5+q2F9clbi7ZjEQZIvuEgLal
 Ldu1nXppZo2yk4PEdu0IcLZ1UH1R7BFW21W/6oJudgZIpnkEaDsozucMFUwyeGdNKfFC
 WJ4FSC5LxDhrtFuYCWwwAbrh9gacGM8/6OZhv0Y+xpujO7xBcGKxgeeiYb6qxo1PrCJd
 Xj13Wz56FrF9KVBvZAgGWezdJ5I9Tl2h9ozvJqrOS3/0tftlOOjMkwgNPBcBeGgDomjc
 Sh5A==
X-Gm-Message-State: AGi0PuZ87zuV9T0hrAj6d9sP8H4gg4ylNCjdUagH9lKzzhjdTENMVofH
 yZfc9BtTGcBh3QUb8t5husXnEQEDRNsEzgq+3jeg7A==
X-Google-Smtp-Source: APiQypKvYNGeBVV5knWEjW/v/ZM4A/rHwo0I2l0Vy5+M44twiEUahUOzQVF90JHCIA+Oh4khJ4ck8NyNmGTdYOb0qgk=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr16218619ljg.38.1588049643021; 
 Mon, 27 Apr 2020 21:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200418144047.9013-1-sashal@kernel.org>
 <20200418144047.9013-38-sashal@kernel.org>
In-Reply-To: <20200418144047.9013-38-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Apr 2020 10:23:51 +0530
Message-ID: <CA+G9fYtuzvLSyqSkG8kCPk7exz16P4f5tYf-DTqV2p+eucKOLA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 38/78] nvme: fix compat address handling in
 several ioctls
To: Sasha Levin <sashal@kernel.org>, Nick Bowler <nbowler@draconx.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_215406_997701_120A65A8 
X-CRM114-Status: GOOD (  20.59  )
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
Cc: open list <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 lkft-triage@lists.linaro.org, Basil Eljuse <Basil.Eljuse@arm.com>,
 linux- stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gU2F0LCAxOCBBcHIgMjAyMCBhdCAyMDoyNCwgU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwu
b3JnPiB3cm90ZToKPgo+IEZyb206IE5pY2sgQm93bGVyIDxuYm93bGVyQGRyYWNvbnguY2E+Cj4K
PiBbIFVwc3RyZWFtIGNvbW1pdCBjOTViNzA4ZDVmYTY1YjRlNTFmMDg4ZWUwNzdkMTI3ZmQ1YTU3
YjcwIF0KPgo+IE9uIGEgMzItYml0IGtlcm5lbCwgdGhlIHVwcGVyIGJpdHMgb2YgdXNlcnNwYWNl
IGFkZHJlc3NlcyBwYXNzZWQgdmlhCj4gdmFyaW91cyBpb2N0bHMgYXJlIHNpbGVudGx5IGlnbm9y
ZWQgYnkgdGhlIG52bWUgZHJpdmVyLgo+Cj4gSG93ZXZlciBvbiBhIDY0LWJpdCBrZXJuZWwgcnVu
bmluZyBhIGNvbXBhdCB0YXNrLCB0aGVzZSB1cHBlciBiaXRzIGFyZQo+IG5vdCBpZ25vcmVkIGFu
ZCBhcmUgaW4gZmFjdCByZXF1aXJlZCB0byBiZSB6ZXJvIGZvciB0aGUgaW9jdGxzIHRvIHdvcmsu
Cj4KPiBVbmZvcnR1bmF0ZWx5LCB0aGlzIGRpZmZlcmVuY2UgbWF0dGVycy4gIDMyLWJpdCBzbWFy
dGN0bCBzdWJtaXRzIHRoZQo+IE5WTUVfSU9DVExfQURNSU5fQ01EIGlvY3RsIHdpdGggZ2FyYmFn
ZSBpbiB0aGVzZSB1cHBlciBiaXRzIGJlY2F1c2UgaXQKPiBzZWVtcyB0aGUgcG9pbnRlciB2YWx1
ZSBpdCBwdXRzIGludG8gdGhlIG52bWVfcGFzc3RocnVfY21kIHN0cnVjdHVyZSBpcwo+IHNpZ24g
ZXh0ZW5kZWQuICBUaGlzIHdvcmtzIGZpbmUgb24gMzItYml0IGtlcm5lbHMgYnV0IGZhaWxzIG9u
IGEgNjQtYml0Cj4gb25lIGJlY2F1c2UgKGF0IGxlYXN0IG9uIG15IHNldHVwKSB0aGUgYWRkcmVz
c2VzIHNtYXJ0Y3RsIHVzZXMgYXJlCj4gY29uc2lzdGVudGx5IGFib3ZlIDJHLiAgRm9yIGV4YW1w
bGU6Cj4KPiAgICMgc21hcnRjdGwgLXggL2Rldi9udm1lMG4xCj4gICBzbWFydGN0bCA3LjEgMjAx
OS0xMi0zMCByNTAyMiBbeDg2XzY0LWxpbnV4LTUuNS4xMV0gKGxvY2FsIGJ1aWxkKQo+ICAgQ29w
eXJpZ2h0IChDKSAyMDAyLTE5LCBCcnVjZSBBbGxlbiwgQ2hyaXN0aWFuIEZyYW5rZSwgd3d3LnNt
YXJ0bW9udG9vbHMub3JnCj4KPiAgIFJlYWQgTlZNZSBJZGVudGlmeSBDb250cm9sbGVyIGZhaWxl
ZDogTlZNRV9JT0NUTF9BRE1JTl9DTUQ6IEJhZCBhZGRyZXNzCj4KPiBTaW5jZSBjaGFuZ2luZyAz
Mi1iaXQga2VybmVscyB0byBhY3R1YWxseSBjaGVjayBhbGwgb2YgdGhlIHN1Ym1pdHRlZAo+IGFk
ZHJlc3MgYml0cyBub3cgd291bGQgYnJlYWsgZXhpc3RpbmcgdXNlcnNwYWNlLCB0aGlzIHBhdGNo
IGZpeGVzIHRoZQo+IGNvbXBhdCBwcm9ibGVtIGJ5IGV4cGxpY2l0bHkgemVyb2luZyB0aGUgdXBw
ZXIgYml0cyBpbiB0aGUgY29tcGF0IGNhc2UuCj4gVGhpcyBlbmFibGVzIDMyLWJpdCBzbWFydGN0
bCB0byB3b3JrIG9uIGEgNjQtYml0IGtlcm5lbC4KPgo+IFNpZ25lZC1vZmYtYnk6IE5pY2sgQm93
bGVyIDxuYm93bGVyQGRyYWNvbnguY2E+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+Cj4gU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJu
ZWwub3JnPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAyNyArKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIv
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gaW5kZXggYjhmZTQyZjRiM2M1Yi4uZjk3YzQ4ZmQz
ZWRhZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBAQCAtNiw2ICs2LDcgQEAKPgo+ICAjaW5jbHVkZSA8bGlu
dXgvYmxrZGV2Lmg+Cj4gICNpbmNsdWRlIDxsaW51eC9ibGstbXEuaD4KPiArI2luY2x1ZGUgPGxp
bnV4L2NvbXBhdC5oPgo+ICAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KPiAgI2luY2x1ZGUgPGxp
bnV4L2Vycm5vLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9oZHJlZy5oPgo+IEBAIC0xMjQ0LDYgKzEy
NDUsMTggQEAgc3RhdGljIHZvaWQgbnZtZV9lbmFibGVfYWVuKHN0cnVjdCBudm1lX2N0cmwgKmN0
cmwpCj4gICAgICAgICBxdWV1ZV93b3JrKG52bWVfd3EsICZjdHJsLT5hc3luY19ldmVudF93b3Jr
KTsKPiAgfQo+Cj4gKy8qCj4gKyAqIENvbnZlcnQgaW50ZWdlciB2YWx1ZXMgZnJvbSBpb2N0bCBz
dHJ1Y3R1cmVzIHRvIHVzZXIgcG9pbnRlcnMsIHNpbGVudGx5Cj4gKyAqIGlnbm9yaW5nIHRoZSB1
cHBlciBiaXRzIGluIHRoZSBjb21wYXQgY2FzZSB0byBtYXRjaCBiZWhhdmlvdXIgb2YgMzItYml0
Cj4gKyAqIGtlcm5lbHMuCj4gKyAqLwo+ICtzdGF0aWMgdm9pZCBfX3VzZXIgKm52bWVfdG9fdXNl
cl9wdHIodWludHB0cl90IHB0cnZhbCkKPiArewo+ICsgICAgICAgaWYgKGluX2NvbXBhdF9zeXNj
YWxsKCkpCj4gKyAgICAgICAgICAgICAgIHB0cnZhbCA9IChjb21wYXRfdXB0cl90KXB0cnZhbDsK
CmFybTY0IG1ha2UgbW9kdWxlcyBmYWlsZWQgd2hpbGUgYnVpbGRpbmcgd2l0aCBhbiBleHRyYSBr
ZXJuZWwgY29uZmlnLgoKQ09ORklHX0FSTTY0XzY0S19QQUdFUz15CgoKICMgbWFrZSAtc2sgS0JV
SUxEX0JVSUxEX1VTRVI9VHV4QnVpbGQgLUMvbGludXggLWoxNiBBUkNIPWFybTY0CkNST1NTX0NP
TVBJTEU9YWFyY2g2NC1saW51eC1nbnUtIEhPU1RDQz1nY2MgQ0M9InNjY2FjaGUKYWFyY2g2NC1s
aW51eC1nbnUtZ2NjIiBPPWJ1aWxkIG1vZHVsZXMKNzAgIwo3MSAuLi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmM6IEluIGZ1bmN0aW9uIOKAmG52bWVfdG9fdXNlcl9wdHLigJk6CjcyIC4uL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYzoxMjU2OjEzOiBlcnJvcjog4oCYY29tcGF0X3VwdHJfdOKAmQp1
bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJhj
b21wYXRfdGltZV904oCZPwo3MyAgMTI1NiB8IHB0cnZhbCA9IChjb21wYXRfdXB0cl90KXB0cnZh
bDsKNzQgIHwgXn5+fn5+fn5+fn5+fgo3NSAgfCBjb21wYXRfdGltZV90Cjc2IC4uL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYzoxMjU2OjEzOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQKaWRlbnRpZmll
ciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgo3
NyAuLi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmM6MTI1NjoyNzogZXJyb3I6IGV4cGVjdGVkIOKA
mDvigJkgYmVmb3JlIOKAmHB0cnZhbOKAmQo3OCAgMTI1NiB8IHB0cnZhbCA9IChjb21wYXRfdXB0
cl90KXB0cnZhbDsKNzkgIHwgXn5+fn5+CjgwICB8IDsKODEgbWFrZVs0XTogKioqIFsuLi9zY3Jp
cHRzL01ha2VmaWxlLmJ1aWxkOjI2NjoKZHJpdmVycy9udm1lL2hvc3QvY29yZS5vXSBFcnJvciAx
CgpmdWxsIGJ1aWxkIGxvZywKaHR0cHM6Ly9naXRsYWIuY29tL0xpbmFyby9sa2Z0L2tlcm5lbC1y
dW5zLy0vam9icy81Mjg3MjM4NTEKCktlcm5lbCBjb25maWc6Cmh0dHBzOi8vYnVpbGRzLnR1eGJ1
aWxkLmNvbS9EZUw2RWVwbWRSdzZPYU9HbWc3Rl9nL2tlcm5lbC5jb25maWcKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
