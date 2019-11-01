Return-Path: <SRS0=Vg0R=YZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2201CA9ECF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 19:14:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AFE2086D
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 19:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UgNtqzMs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqTJjvNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AFE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lrdI2wPiofm3ZVSkl/s8UFw86DSE1mYxGqVLi3vZUU0=; b=UgNtqzMsvD8zAI
	qRh8XnXyTEABBV1nCDiPCy3hQqeHFbUkjeUIkbOA8x05e1Gg9bB4JK9lF7jf3o6Ep99Yg3ic+lraj
	9NocJBicboVg+fWrrfVWbc/7dwAV16nIyte6vcrLuZ0DaG/78KO13EMfWSdtROGFRzgPGzU4ihRm5
	9TP4FK1hOZocWa8Bk/usAaSmDop6ArBSYYjlXvoXnGTtCjibsPyT4fyXwOUPQq7gROOyI7VIarVNu
	843GmAnhP4i0a9idqgOMggp+f26WETO+iMBYckhnWvU+0c33BRZ0RAq1KZWnecZi1CWtxlS5psVso
	3EjFnwlZ1aUZnU/qKoRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQcNT-0003P6-7f; Fri, 01 Nov 2019 19:14:31 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQcNQ-0003OY-Mq
 for linux-nvme@lists.infradead.org; Fri, 01 Nov 2019 19:14:30 +0000
Received: by mail-pg1-x541.google.com with SMTP id j22so7063514pgh.3
 for <linux-nvme@lists.infradead.org>; Fri, 01 Nov 2019 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=dxValgYvhHxSnFI6gnr2oyO17cKwpSxzLNQyRqzKdCA=;
 b=EqTJjvNGDW7WZvYDnkDxvcome8PseIkxEJcxdi4JjfhktZRFgIdkmiajPLB44gOEyO
 /AyQh/VB3aSYZswNeWPhcY1/py5PEXv6IofpKS8fZA0id8M2Je4YWQWX90+cnTFeMq2q
 1GUtlZDx5IV5tNcrZpbtRwSbAZpaeJXP23gOz6ZGboEThQDs4QHPpzSz4KCCJOdZTjrH
 3+7fWkUIt5MEC6SpzEKZhjZgQAjENCFj9objO7DLhCc0r9yEFcB3RyBNTe2OJ7fDbUUP
 L/sCD2sjz/rMHxmxPX3e+hWUnftnU4amq9n0keWLp/KErtvtgpDwXaDEPp2uQwZ7vwJA
 c8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=dxValgYvhHxSnFI6gnr2oyO17cKwpSxzLNQyRqzKdCA=;
 b=hMCYgFmZzMIC85v6HmWZcH3b1qBuHJgMVl3qB6kPgaJsGnc2NGs0gCi2LZsbuyHAT0
 yaKP6T3gk4grlDTRj3MLsQqVhE06UbTxFRkkvw8XJXuR4pWuiGO3rlmYdh+T8q63FNEp
 KTWFg05JfIHTrIggyoFLMLygvjiB/6XSm0q3+f1rMz7qr28r0gum2bloHWW+yUPUCXHI
 VgW105ILB7TT9DRydtPZXCqgHpuiwltMl80EwutQQ9kU3dfaEzrBkhJEHQcITicdMStD
 OUkPuMM3fnjBgUfo7SmO8X8RvoqpFALUp4DZKyk5k4w0WblmssF2/qw0pSJoT56JOucy
 t0wQ==
X-Gm-Message-State: APjAAAWyy4FnwUzOIP4EY20iIyHy7N3i38i5E84BagRmLgYojZ9URfsw
 vdO9r9U3msK3TDDR+AgmM9A=
X-Google-Smtp-Source: APXvYqzUe+fumh35OZfggMheJb3fdt8kBltkY6Q1u9Qw+Ozs70zXlYY4A97YV/+K1EIrFyWe0LbEIw==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr14514939pgj.86.1572635668072; 
 Fri, 01 Nov 2019 12:14:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a18sm6722086pff.95.2019.11.01.12.14.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Nov 2019 12:14:26 -0700 (PDT)
Date: Fri, 1 Nov 2019 12:14:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v3] nvme: Add hardware monitoring support
Message-ID: <20191101191425.GA16792@roeck-us.net>
References: <20191101035646.25644-1-linux@roeck-us.net>
 <CAC5umyhiOiAiYWs2Y=L5133CCQNnAgi8oq6AbGzgkznZKz5f-w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAC5umyhiOiAiYWs2Y=L5133CCQNnAgi8oq6AbGzgkznZKz5f-w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191101_121428_769581_5AA29DCF 
X-CRM114-Status: GOOD (  16.69  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Linux PM <linux-pm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gU2F0LCBOb3YgMDIsIDIwMTkgYXQgMDE6MTk6MDNBTSArMDkwMCwgQWtpbm9idSBNaXRhIHdy
b3RlOgo+IDIwMTnlubQxMeaciDHml6Uo6YeRKSAxMjo1NiBHdWVudGVyIFJvZWNrIDxsaW51eEBy
b2Vjay11cy5uZXQ+Ogo+ID4gK3ZvaWQgbnZtZV9od21vbl9pbml0KHN0cnVjdCBudm1lX2N0cmwg
KmN0cmwpCj4gPiArewo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBjdHJsLT5kZXZp
Y2U7Cj4gCj4gU2hvdWxkIHdlIHVzZSAnY3RybC0+ZGV2JyBpbnN0ZWFkIG9mICdjdHJsLT5kZXZp
Y2UnPwo+IAoKRXhjZWxsZW50IHBvaW50LCBhbmQgbW9zdCBkZWZpbml0ZWx5IHllcy4gSSBzaG91
bGQgaGF2ZSBkb25lIHRoYXQKZnJvbSB0aGUgYmVnaW5uaW5nLgoKPiBUaGUgJ2N0cmwtPmRldmlj
ZScgaXMgYSBwb2ludGVyIHRvIGNoYXIgZGV2aWNlIGFuZCB0aGUgJy0+b2Zfbm9kZScgbWVtYmVy
Cj4gaXMgTlVMTC4KPiAKPiBTbyBpZiBkZXZtX2h3bW9uX2RldmljZV9yZWdpc3Rlcl93aXRoX2lu
Zm8oKSAoaS5lLiBfX2h3bW9uX2RldmljZV9yZWdpc3RlcikKPiBpcyBjYWxsZWQgd2l0aCAnY3Ry
bC0+ZGV2aWNlJywgaXQgZG9lc24ndCBhdHRlbXB0IHRvIHJlZ2lzdGVyIGEgc2Vuc29yIHRvIGEK
PiBEVCB0aGVybWFsIHpvbmUgKGkuZS4gaHdtb25fdGhlcm1hbF9hZGRfc2Vuc29yKCkgaXMgbm90
IGNhbGxlZCBhdCBhbGwpLgo+IAo+IFRoaXMgY2hhbmdlIHdhcyByZXF1aXJlZCwgd2hlbiBJIHRy
aWVkIHRoaXMgbnZtZSBod21vbiBwYXRjaCB3aXRoIHRoZQo+IGZvbGxvd2luZyBEVCB0aGVybWFs
IHNldHVwLgo+IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWRldmljZXRyZWUvMTU2
MTk5MDM1NC00MDg0LTMtZ2l0LXNlbmQtZW1haWwtYWtpbm9idS5taXRhQGdtYWlsLmNvbS8KPiAK
PiA+ICsgICAgICAgc3RydWN0IG52bWVfaHdtb25fZGF0YSAqZGF0YTsKPiA+ICsgICAgICAgc3Ry
dWN0IGRldmljZSAqaHdtb247Cj4gPiArICAgICAgIGludCBlcnI7Cj4gPiArCj4gPiArICAgICAg
IGRhdGEgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsKPiA+
ICsgICAgICAgaWYgKCFkYXRhKQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiA+ICsKPiA+
ICsgICAgICAgZGF0YS0+Y3RybCA9IGN0cmw7Cj4gPiArICAgICAgIG11dGV4X2luaXQoJmRhdGEt
PnJlYWRfbG9jayk7Cj4gPiArCj4gPiArICAgICAgIGVyciA9IG52bWVfaHdtb25fZ2V0X3NtYXJ0
X2xvZyhkYXRhKTsKPiA+ICsgICAgICAgaWYgKGVycikgewo+ID4gKyAgICAgICAgICAgICAgIGRl
dl93YXJuKGRldiwgIkZhaWxlZCB0byByZWFkIHNtYXJ0IGxvZyAoZXJyb3IgJWQpXG4iLCBlcnIp
Owo+ID4gKyAgICAgICAgICAgICAgIGRldm1fa2ZyZWUoZGV2LCBkYXRhKTsKPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm47Cj4gPiArICAgICAgIH0KPiA+ICsKPiA+ICsgICAgICAgaHdtb24gPSBk
ZXZtX2h3bW9uX2RldmljZV9yZWdpc3Rlcl93aXRoX2luZm8oZGV2LCBkZXZfbmFtZShkZXYpLCBk
YXRhLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmbnZtZV9od21vbl9jaGlwX2luZm8sCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOwo+IAo+IElmIHRoZSBhYm92ZSBjaGFu
Z2UgaXMgYXBwbGllZCwgdGhlIHNlY29uZCAnbmFtZScgYXJndW1lbnQgaXMgY2hhbmdlZAo+IGZy
b20gJ252bWUwJyB0byAnMDAwMDowMTowMC4wJyBhcyBhIHNpZGUgZWZmZWN0LiAgU28gd2UgbWF5
IHdhbnQgdG8KPiBjaGFuZ2UgdGhlIHNlY29uZCBhcmd1bWVudCwgdG9vLgo+IAoKWWVzLiBJJ2xs
IGp1c3QgbmFtZSBpdCAibnZtZSI7IGFmdGVyIGFsbCwgdGhhdCBpcyBzdWZmaWNpZW50IGFuZCBt
b3JlCmNvbnNpc3RlbnQgd2l0aCBvdGhlciBkcml2ZXJzLiBDdXJyZW50bHksIHdlIGdldCBzb21l
dGhpbmcgbGlrZQoJbnZtZTAtcGNpLTAxMDAKCW52bWUxLXBjaS0yNTAwCmlmIHRoZXJlIGFyZSBt
dWx0aXBsZSBkcml2ZXMsIHdoZXJlIHRoZSAiMCIgYW5kICIxIiBhcmUgbm90IHJlYWxseQpuZWNl
c3NhcnkuCgpUaGFua3MhCkd1ZW50ZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
