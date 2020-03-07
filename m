Return-Path: <SRS0=WUld=4Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE0C10DCE
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2020 01:00:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38BD206D7
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2020 01:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d/oius+W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MYRljuGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38BD206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zHqfsjJTga+qXYHB9KJ8MYSBW3ZlwLWJuV7jBXfs+sg=; b=d/oius+WTylmu26S4TC6JA+f/
	EthESk9u5L3XpGZy1AVS0bg63s1tyZj+zoYG2tr5JAlcQuU9e8I96bM2U2dK4wqWLPx+qfVteJYP9
	cj2ip6amORkizUn8l2r+WkgrmTjGMm1LF5qpoxfVuWsYpkW56uplU1sp8zvMaLmmAWo1r9WSd98B0
	2xp/8ml2UbRUlwNLJysyEnoxUHhLfGzf/Pkp3mkrVjYzh2wiawJskj7CKK1Oc2zxDKR5kLp7egvM2
	IzgCFg2XD3thbDSS+MkmSpSU6hbgTFNX/6K5udgRmJUJX2fzQVDfKFEIESvb+QuiF8zFRPrcufMIy
	PSkKImahw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jANpB-0005sx-AM; Sat, 07 Mar 2020 01:00:17 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jANp6-0005sW-LW
 for linux-nvme@lists.infradead.org; Sat, 07 Mar 2020 01:00:14 +0000
Received: by mail-pl1-x642.google.com with SMTP id t14so1550869plr.8
 for <linux-nvme@lists.infradead.org>; Fri, 06 Mar 2020 17:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=/cqs0lVWAyHYkLxm9gxEqYTeer9+zj2lbi52CuB+17A=;
 b=MYRljuGbsJfJhI4NOBOi/e21L4AFCLomsZnFPJ1j/3onqRQ2yiYjAeIA6ep+5i5X+8
 ZZ2xYPOImovwdoecpYM/BkGNkn89MFtt3tjLJbPM/366iWYfyXjAsnYsPun5K/WXHZH5
 UMAPVYs2PDSKaZFlC6aaeUsfmHV6kIlhnROJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/cqs0lVWAyHYkLxm9gxEqYTeer9+zj2lbi52CuB+17A=;
 b=h2HTQ39nx4k1Ic7AaTAYvVPMV0ERGDDpelYSp8Yagd4kjUfoMe+CUDKv3Zr35rTu1+
 YvC2RF0hT60fDtZuYLtvYcB1lvKONEF5BZKy/owprsJfDNrAgPre8l/OKMUbahks46pV
 a+CqMrSYlk4Bli+zqyV82KMUH52olfFxEKd7EV7sp0TF9I5K7bFwWeUFbM+UjuHthiwe
 1jgHBK0ZPxBS+52XdIOelkrXv3kkr4q5s3+Gu+ADW3AqYmlWSPocSmt9cPibUAx8/ZUB
 nLT7+R8HccjrAPgTyU+ykCS/WVpW2bzZWCzsUa0kP3Q+C5k1WlDBDOC3sqL8hLS8cZaI
 eUXA==
X-Gm-Message-State: ANhLgQ2a2h2rlnIe0TNM2UUiU8ZHXFlUSqzVZF6vZe6TwP/lejR4ksIi
 I/2uGZP3T8v9zc58suCOhNJyIY0ZTyRBdnmunM0woEE3ZRIGRoJIbMf0bbz8cSqPbpN2KbAydq6
 EpVgBnOOiRBo5JpmqKl2TM12TbX2IN2abuG9m+jGTmYU4MKUQ8ZGLZXIdRtNUJd62CouECclgrM
 AMM0ra8Q==
X-Google-Smtp-Source: ADFU+vsF9g9FK5LY7a2C1MqqTacnBQ9qqwF39SUiDTIAmz8AJRnL0S5mTTjLXXOu8lJZEWEbtJ8Ubg==
X-Received: by 2002:a17:90a:fd90:: with SMTP id
 cx16mr5759891pjb.97.1583542809053; 
 Fri, 06 Mar 2020 17:00:09 -0800 (PST)
Received: from [10.230.0.17] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id 129sm31742045pgf.10.2020.03.06.17.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 17:00:08 -0800 (PST)
Subject: Re: [PATCH 1/3] nvmet/fc: Sanitize tgtport reference counting for LS
 requests
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200306130440.16864-1-hare@suse.de>
 <20200306130440.16864-2-hare@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <ba9055c6-746f-607e-d2c3-d354ec591e59@broadcom.com>
Date: Fri, 6 Mar 2020 17:00:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306130440.16864-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200306_170012_714680_B5EF4B23 
X-CRM114-Status: GOOD (  20.04  )
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
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAzLzYvMjAyMCA1OjA0IEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4gV2UgbmVlZCB0
byB2YWxpZGF0ZSB0aGUgdGFyZ2V0cG9ydCB1cG9uIGZpcnN0IGFjY2Vzcywgb3RoZXJ3aXNlCj4g
dGhlcmUncyBhIHJpc2sgb2YgYWNjZXNzaW5nIGFuIGludmFsaWQgdGFyZ2V0cG9ydC4KPgo+IFNp
Z25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+IC0tLQo+ICAgZHJp
dmVycy9udm1lL3RhcmdldC9mYy5jIHwgMjMgKysrKysrKysrKysrLS0tLS0tLS0tLS0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2ZjLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2Zj
LmMKPiBpbmRleCAwYTBmMDNiMmZhZjMuLmFmZjk1OTMwMGVmMyAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL252bWUvdGFyZ2V0L2ZjLmMKPiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2ZjLmMKPiBA
QCAtMzU4LDYgKzM1OCw3IEBAIF9fbnZtZXRfZmNfZmluaXNoX2xzX3JlcShzdHJ1Y3QgbnZtZXRf
ZmNfbHNfcmVxX29wICpsc29wKQo+ICAgCj4gICAJaWYgKCFsc29wLT5yZXFfcXVldWVkKSB7Cj4g
ICAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnRndHBvcnQtPmxvY2ssIGZsYWdzKTsKPiArCQlu
dm1ldF9mY190Z3Rwb3J0X3B1dCh0Z3Rwb3J0KTsKPiAgIAkJcmV0dXJuOwo+ICAgCX0KPiAgIAo+
IEBAIC0zODYsOSArMzg3LDYgQEAgX19udm1ldF9mY19zZW5kX2xzX3JlcShzdHJ1Y3QgbnZtZXRf
ZmNfdGd0cG9ydCAqdGd0cG9ydCwKPiAgIAlpZiAoIXRndHBvcnQtPm9wcy0+bHNfcmVxKQo+ICAg
CQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4gICAKPiAtCWlmICghbnZtZXRfZmNfdGd0cG9ydF9nZXQo
dGd0cG9ydCkpCj4gLQkJcmV0dXJuIC1FU0hVVERPV047Cj4gLQo+ICAgCWxzcmVxLT5kb25lID0g
ZG9uZTsKPiAgIAlsc29wLT5yZXFfcXVldWVkID0gZmFsc2U7Cj4gICAJSU5JVF9MSVNUX0hFQUQo
Jmxzb3AtPmxzcmVxX2xpc3QpOwo+IEBAIC0zOTYsMTAgKzM5NCw5IEBAIF9fbnZtZXRfZmNfc2Vu
ZF9sc19yZXEoc3RydWN0IG52bWV0X2ZjX3RndHBvcnQgKnRndHBvcnQsCj4gICAJbHNyZXEtPnJx
c3RkbWEgPSBmY19kbWFfbWFwX3NpbmdsZSh0Z3Rwb3J0LT5kZXYsIGxzcmVxLT5ycXN0YWRkciwK
PiAgIAkJCQkgIGxzcmVxLT5ycXN0bGVuICsgbHNyZXEtPnJzcGxlbiwKPiAgIAkJCQkgIERNQV9C
SURJUkVDVElPTkFMKTsKPiAtCWlmIChmY19kbWFfbWFwcGluZ19lcnJvcih0Z3Rwb3J0LT5kZXYs
IGxzcmVxLT5ycXN0ZG1hKSkgewo+IC0JCXJldCA9IC1FRkFVTFQ7Cj4gLQkJZ290byBvdXRfcHV0
dGd0cG9ydDsKPiAtCX0KPiArCWlmIChmY19kbWFfbWFwcGluZ19lcnJvcih0Z3Rwb3J0LT5kZXYs
IGxzcmVxLT5ycXN0ZG1hKSkKPiArCQlyZXR1cm4gLUVGQVVMVDsKPiArCj4gICAJbHNyZXEtPnJz
cGRtYSA9IGxzcmVxLT5ycXN0ZG1hICsgbHNyZXEtPnJxc3RsZW47Cj4gICAKPiAgIAlzcGluX2xv
Y2tfaXJxc2F2ZSgmdGd0cG9ydC0+bG9jaywgZmxhZ3MpOwo+IEBAIC00MjYsOSArNDIzLDYgQEAg
X19udm1ldF9mY19zZW5kX2xzX3JlcShzdHJ1Y3QgbnZtZXRfZmNfdGd0cG9ydCAqdGd0cG9ydCwK
PiAgIAlmY19kbWFfdW5tYXBfc2luZ2xlKHRndHBvcnQtPmRldiwgbHNyZXEtPnJxc3RkbWEsCj4g
ICAJCQkJICAobHNyZXEtPnJxc3RsZW4gKyBsc3JlcS0+cnNwbGVuKSwKPiAgIAkJCQkgIERNQV9C
SURJUkVDVElPTkFMKTsKPiAtb3V0X3B1dHRndHBvcnQ6Cj4gLQludm1ldF9mY190Z3Rwb3J0X3B1
dCh0Z3Rwb3J0KTsKPiAtCj4gICAJcmV0dXJuIHJldDsKPiAgIH0KPiAgIAo+IEBAIC00ODIsMTQg
KzQ3NiwxOSBAQCBudm1ldF9mY194bXRfZGlzY29ubmVjdF9hc3NvYyhzdHJ1Y3QgbnZtZXRfZmNf
dGd0X2Fzc29jICphc3NvYykKPiAgIAlzdHJ1Y3QgbnZtZWZjX2xzX3JlcSAqbHNyZXE7Cj4gICAJ
aW50IHJldDsKPiAgIAo+ICsJaWYgKCFudm1ldF9mY190Z3Rwb3J0X2dldCh0Z3Rwb3J0KSkKPiAr
CQlyZXR1cm47Cj4gKwo+ICAgCS8qCj4gICAJICogSWYgbHNfcmVxIGlzIE5VTEwgb3Igbm8gaG9z
dGhhbmRsZSwgaXQncyBhbiBvbGRlciBsbGRkIGFuZCBubwo+ICAgCSAqIG1lc3NhZ2UgaXMgbm9y
bWFsLiBPdGhlcndpc2UsIHNlbmQgdW5sZXNzIHRoZSBob3N0cG9ydCBoYXMKPiAgIAkgKiBhbHJl
YWR5IGJlZW4gaW52YWxpZGF0ZWQgYnkgdGhlIGxsZGQuCj4gICAJICovCj4gICAJaWYgKCF0Z3Rw
b3J0LT5vcHMtPmxzX3JlcSB8fCAhYXNzb2MtPmhvc3Rwb3J0IHx8Cj4gLQkgICAgYXNzb2MtPmhv
c3Rwb3J0LT5pbnZhbGlkKQo+ICsJICAgIGFzc29jLT5ob3N0cG9ydC0+aW52YWxpZCkgewo+ICsJ
CW52bWV0X2ZjX3RndHBvcnRfcHV0KHRndHBvcnQpOwo+ICAgCQlyZXR1cm47Cj4gKwl9Cj4gICAK
PiAgIAlsc29wID0ga3phbGxvYygoc2l6ZW9mKCpsc29wKSArCj4gICAJCQlzaXplb2YoKmRpc2Nv
bl9ycXN0KSArIHNpemVvZigqZGlzY29uX2FjYykgKwo+IEBAIC00OTgsNiArNDk3LDcgQEAgbnZt
ZXRfZmNfeG10X2Rpc2Nvbm5lY3RfYXNzb2Moc3RydWN0IG52bWV0X2ZjX3RndF9hc3NvYyAqYXNz
b2MpCj4gICAJCWRldl9pbmZvKHRndHBvcnQtPmRldiwKPiAgIAkJCSJ7JWQ6JWR9IHNlbmQgRGlz
Y29ubmVjdCBBc3NvY2lhdGlvbiBmYWlsZWQ6IEVOT01FTVxuIiwKPiAgIAkJCXRndHBvcnQtPmZj
X3RhcmdldF9wb3J0LnBvcnRfbnVtLCBhc3NvYy0+YV9pZCk7Cj4gKwkJbnZtZXRfZmNfdGd0cG9y
dF9wdXQodGd0cG9ydCk7Cj4gICAJCXJldHVybjsKPiAgIAl9Cj4gICAKPiBAQCAtNTIyLDYgKzUy
Miw3IEBAIG52bWV0X2ZjX3htdF9kaXNjb25uZWN0X2Fzc29jKHN0cnVjdCBudm1ldF9mY190Z3Rf
YXNzb2MgKmFzc29jKQo+ICAgCQkJInslZDolZH0gWE1UIERpc2Nvbm5lY3QgQXNzb2NpYXRpb24g
ZmFpbGVkOiAlZFxuIiwKPiAgIAkJCXRndHBvcnQtPmZjX3RhcmdldF9wb3J0LnBvcnRfbnVtLCBh
c3NvYy0+YV9pZCwgcmV0KTsKPiAgIAkJa2ZyZWUobHNvcCk7Cj4gKwkJbnZtZXRfZmNfdGd0cG9y
dF9wdXQodGd0cG9ydCk7Cj4gICAJfQo+ICAgfQo+ICAgCgpJIGd1ZXNzIEkgZG9uJ3Qgc2VlIGFu
eXRoaW5nIHdyb25nIHdpdGggdGhpcywgYnV0IGl0IHNlZW1zIG1lc3NpZXIgdG8gCmhhbmRsZSB0
aGUgcmVmIGNvdW50aW5nLsKgIEkgcHJlZmVyIGl0IHRvIGJlIG9uIHRoZSBzZW5kL2NvbXBsZXRp
b24gCmxvY2FsaXplZCB0byB0aGUgY29tbW9uIG9wIHByb2Nlc3NpbmcuwqAgQWxzbyBjcmVhdGVz
IGEgZGlmZmVyZW50IAppbXBsZW1lbnRhdGlvbiB0aGFuIHdoYXQgd2FzIGRvbmUgb24gdGhlIGhv
c3Qgc2lkZSwgZXZlbiB0aG91Z2ggdGhlIHJlc3QgCmlzIHZlcnkgc2ltaWxhci4KClJldmlld2Vk
LWJ5OiBKYW1lcyBTbWFydCA8amFtZXMuc21hcnRAYnJvYWRjb20uY29tPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
