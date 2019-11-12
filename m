Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F2C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 14:20:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A098B2084F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 14:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G72kc2gX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQye6WKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A098B2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jVh+0ct86fxXzqaT1Xm81S7M+LV7ELe+boNW5vS+5fo=; b=G72kc2gXayOMCo
	j+tsN/z7SBjYKxTgNT1FOFVmVDwXlNL+npvOkKuAaYCRqxsszPyCLCyjSlr1c/FoBeZb6C+nqYJ3w
	ZRfxoHIB6C8kE+GYmpqEg+43tftkP9ic4uBo1XJ8PigGn+UZd8D8KVEQljurAHw9oo0wuXvtq1jCC
	CKxAwRsdoSgpAlHyAUAp26vMZCY0FXCcHvd1aOJat1NARHA4CgH31vFf3jj1MYeVhZWiRpP+Qgpw8
	deDXw8sbn/HDR/ekD+Bqd0daz1Lky/oaH6JkLOccSiee2cp0lyBOxL+m+0nbDhBnTT0llReUQPFz/
	7bMYOnNXXDwYc4yW5FqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUX1Y-00059L-Kl; Tue, 12 Nov 2019 14:20:04 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUX1V-0004sR-1t
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 14:20:03 +0000
Received: by mail-lj1-x241.google.com with SMTP id q2so18011167ljg.7
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=InWYQ6EDE1UwAi29n8OvoJ68XjWPUmv8Cb0X5ROSwiE=;
 b=iQye6WKNcdQxY1qQqzRwCZQoEFJlLcsmRMf12S+29lJJJkVHdwTlh2Ml35WI0sDxx4
 iBLRcUs7FzgRKgO3GGCIxrYjvzrmIRHONdKyMFFfXtawC/6hTRXD2+IX1XVtsKPGKsHM
 SPgo1y5tqw8iF6FE2rVKu3+rCHmix2yY3wgFDktT8XIDHGTict9VbW85FifoTI2nkWem
 tfPTewwyZ1cLzQE85807vXCFt76rWN0SM76V99DjNdyySbdVuTLRrM7XKCKN+r/d3baF
 tASuZdu23IDpp8++5cjW/Z++dlETAM5F40p2msGSxk0OKueOg+ZQDYBePLRRDWKgeLu/
 6WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=InWYQ6EDE1UwAi29n8OvoJ68XjWPUmv8Cb0X5ROSwiE=;
 b=UwdPIKVNKlBOWAu9SjeJqCDcFHRnJtPhKJo1KC3UHlZSAzJsWmn6XhZa1psYUfbydn
 XWc0Q+2t4o/UVn57BWS9Pqm/uHy5/cq/hBgFm0s/MslghP9Fkxn/sHsg66eaulaOG1O1
 lJFIPZtBAxRyUmD6eYrrqDxmk3mY8tYRvz5D7iNIe6wrdbF7xw3hxDU8II/kiQMGU9O4
 rF/CSmWspnPq059uJnYZYlEx/y+HVteyeBH5UFxGBixK6IeU460877vT2o8sIOb0Ddaf
 Wo8uFEhXfBFChIUo2bTWT4XdCtqYskAoD7DGaV+elTXPX4b4jD/IrdCp2o/guCdlK3cn
 uZ4w==
X-Gm-Message-State: APjAAAXoE4rGXo4sO971jA1woLhEbps7n3Pgv4kFuh7/QrrDRiUuBfzx
 VZqK3geMJiF0DKpn7zvu1hVjMYgE8iX4ripzJLs=
X-Google-Smtp-Source: APXvYqwwL3b6kisFGamAPBxCgIElSoqmEJ+MGMEpAx6WBeIcEuxhDCpeK7UqIuD/AZJZvdI+N9xw3q+dWaHVKvOItuw=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr20371028ljj.93.1573568398829; 
 Tue, 12 Nov 2019 06:19:58 -0800 (PST)
MIME-Version: 1.0
References: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
 <20191111165306.GA19814@lst.de>
In-Reply-To: <20191111165306.GA19814@lst.de>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 12 Nov 2019 23:19:46 +0900
Message-ID: <CAC5umyi97UJZzk+4soD+th0BZ71WfnOqnTWWuTYKyo6aWTdLXA@mail.gmail.com>
Subject: Re: [PATCH] nvme: hwmon: provide temperature min and max values for
 each sensor
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_062001_128495_A3A69C2F 
X-CRM114-Status: GOOD (  11.99  )
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEx5pyIMTLml6Uo54GrKSAxOjUzIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
PjoKPgo+IE9uIFN1biwgTm92IDEwLCAyMDE5IGF0IDExOjE3OjQ2UE0gKzA5MDAsIEFraW5vYnUg
TWl0YSB3cm90ZToKPiA+ICtzdGF0aWMgaW50IG52bWVfZ2V0X3RlbXBfdGhyZXNoKHN0cnVjdCBu
dm1lX2N0cmwgKmN0cmwsIGludCBzZW5zb3IsIGJvb2wgdW5kZXIsCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBsb25nICp0ZW1wKQo+ID4gK3sKPiA+ICsgICAgIHVuc2lnbmVkIGlu
dCB0aHJlc2hvbGQgPSBzZW5zb3IgPDwgTlZNRV9URU1QX1RIUkVTSF9TRUxFQ1RfU0hJRlQ7Cj4g
PiArICAgICBpbnQgc3RhdHVzOwo+ID4gKyAgICAgaW50IHJldDsKPiA+ICsKPiA+ICsgICAgIGlm
ICh1bmRlcikKPiA+ICsgICAgICAgICAgICAgdGhyZXNob2xkIHw9IE5WTUVfVEVNUF9USFJFU0hf
VFlQRV9VTkRFUjsKPiA+ICsKPiA+ICsgICAgIHJldCA9IG52bWVfZ2V0X2ZlYXR1cmVzKGN0cmws
IE5WTUVfRkVBVF9URU1QX1RIUkVTSCwgdGhyZXNob2xkLCBOVUxMLCAwLAo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJnN0YXR1cyk7Cj4gPiArICAgICBpZiAoIXJldCkKPiA+ICsg
ICAgICAgICAgICAgKnRlbXAgPSAoKHN0YXR1cyAmIE5WTUVfVEVNUF9USFJFU0hfTUFTSykgLSAy
NzMpICogMTAwMDsKPiA+ICsKPiA+ICsgICAgIHJldHVybiByZXQgPD0gMCA/IHJldCA6IC1FSU87
Cj4KPiBUaGlzIGxvb2tzIGEgbGl0dGxlIG9ic2Z1Y2F0ZWQuICBhSSdkIHByZWZlciBzb21ldGhp
bmcgbGlrZToKPgo+ICAgICAgICAgaWYgKHJldCA+IDApCj4gICAgICAgICAgICAgICAgIHJldHVy
biAtRUlPOwo+ICAgICAgICAgaWYgKHJldCA8IDApCj4gICAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7Cj4gICAgICAgICAqdGVtcCA9ICgoc3RhdHVzICYgTlZNRV9URU1QX1RIUkVTSF9NQVNLKSAt
IDI3MykgKiAxMDAwOwo+ICAgICAgICAgcmV0dXJuIDA7CgpTb3VuZHMgZ29vZC4KCj4gPiArICAg
ICByZXR1cm4gcmV0IDw9IDAgPyByZXQgOiAtRUlPOwo+Cj4gU2ltaWxhcmx5IGhlcmUsIHNvbWV0
aGluZyBsaWtlOgo+Cj4gICAgICAgICBpZiAocmV0ID4gMCkKPiAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU87Cj4gICAgICAgICByZXR1cm4gcmV0OwoKT0suCgo+ID4gKyAgICAgICAgICAgICBl
cnIgPSBudm1lX2dldF90ZW1wX3RocmVzaChkYXRhLT5jdHJsLCBjaGFubmVsLCBmYWxzZSwgdmFs
KTsKPiA+ICsgICAgICAgICAgICAgaWYgKGVycikKPiA+ICsgICAgICAgICAgICAgICAgICAgICAq
dmFsID0gKGRhdGEtPmN0cmwtPndjdGVtcCAtIDI3MykgKiAxMDAwOwo+Cj4gQ2FuIHdlIGhhdmUg
YSBoZWxwZXIgZm9yIHRoaXMgKHggLSAyNzMpICogMTAwMCBjb252ZXJzaW9uPyAgSXQgaXMKPiBy
ZXBlYXRlZCBxdWl0ZSBhIGJpdCBvdmVyIHRoZSBjb2RlIGluIHRoaXMgZmlsZS4KCk9LLiBJJ2xs
IGFkZCB0d28gbWFjcm9zLgoKI2RlZmluZSBNSUxMSUNFTFNJVVNfVE9fS0VMVklOKHQpICgodCkg
LyAxMDAwICsgMjczKQojZGVmaW5lIEtFTFZJTl9UT19NSUxMSUNFTFNJVVModCkgKCgodCkgLSAy
NzMpICogMTAwMCkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
