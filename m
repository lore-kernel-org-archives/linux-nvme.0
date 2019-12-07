Return-Path: <SRS0=peDJ=Z5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41254C43603
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Dec 2019 15:57:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EBF24670
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Dec 2019 15:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k666P9ZZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfxCaGz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EBF24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e/7H5DonGsfMBCjC6eVf/ylxhCiCMmk2r7yNpshQdR0=; b=k666P9ZZNIgqTj
	ju7etHBV5ai7i8C1ctFLt9xCzr14Gy6ft//nd1kPvIbjTGemrFHb6uBhujdqKWWGOeDHHqoE40wG7
	t+nyclaE5KPoPTDVqEqnXK6oVljJISjXGVr2PPSvYS3qLPDefJhwPds+b+2M3QLfMILWFVcTlmdi1
	K/Dw5/JUf+zwmb2GlOQf2HCaNhuW/sSo6gBSE8RTiU2nn3tisBxb8Krp9mnG4SXjujJ4h5tY/Fffh
	ay0Ob4rWQ6POTkvuK3rijwjzUBAowFi9l7jCUvLyII7H/X8A1gqrWsU9akl/3KFzkTZnm+Z5cwGNV
	DSjKwp+JKDa5LXuikH3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1idcSn-0006xR-Hz; Sat, 07 Dec 2019 15:57:45 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idcSk-0006wh-Iy
 for linux-nvme@lists.infradead.org; Sat, 07 Dec 2019 15:57:44 +0000
Received: by mail-lf1-x143.google.com with SMTP id c9so7024206lfi.6
 for <linux-nvme@lists.infradead.org>; Sat, 07 Dec 2019 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Je89gn9Q33N1bQFYrGaEqfD0jxx0/nSksznx2FYdLRo=;
 b=kfxCaGz3BFFjxhySlBbB1rX7RnA+phJJ7Rlwo401EHiOvqjh8Rrl9zgB6A/5jITfiw
 JIDFTET279F+3PbIOotOjoFTaAcpj/Zsdq3YhKa0NcfVWjCQn4Wudd6BzkMHwMrua6MX
 RDMDHP0cp/QKJjtmKZWzfNU8DNYOqavLfHnp7VRL4Sh4wzxUjWmAAGOkapb1AQmzSF8u
 fO8hWbT117wrhI5jFPTTV1oMunDO6PTjFB2YhnlXd56A9YKeS89TT5twl6onaf531CuO
 F1GwfKiq4i3Slxfy7ZxUfxCAqdMgp8BpMWyreOA8DLFznEJnhJR6afmfmJ974Av40PSM
 aYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Je89gn9Q33N1bQFYrGaEqfD0jxx0/nSksznx2FYdLRo=;
 b=izt+/24lGg5PSPyJ/UvU+lYCnA2DehjVTKX9eBLnG/g0HYpv2pdP+qnSVj5+uc/XI/
 z7MmuaeNGiuRBBpZfMpY6Zpbxvzw5SMzSKUOFS5BYpVLw7ukpLj7lxJjONyWUygO5Sh+
 0T8uQD7cwr/0lEyvLF6o3LkKPrmYLac9yUYkJly1CFjCpalyIiPE7cN6K8jorP14qUfD
 zFaYdRm2/OpV5V6C+tYnNBmF1d35Px8FEBBkP+v+bgZFIk9RlqLwd7f3AWU9xqXura0I
 mbRqNKiAUbCgQ2k7uxGxKfMeuRgtvjrYmVrI+eN0Eol4BFXIGjlUHhLY7LV/h9Kni1JP
 /LTA==
X-Gm-Message-State: APjAAAWcrSzt1t+i3yH2jbeEUB6uz5w41Gz5E2Imu3K6qxOZB0ld7YOr
 ryM3QjNukS+wTi0rM3nIPu//fYUTu+mZg7UHMDA=
X-Google-Smtp-Source: APXvYqxsWOaKlGm5uRNPyXWJqzOcQQ+4DK7/As8ZTt5LTrrPFjXpZV9Yojk2f9aZg/lfYutTMjnq2W8ffejEbamHl3A=
X-Received: by 2002:a05:6512:75:: with SMTP id
 i21mr10706021lfo.98.1575734260036; 
 Sat, 07 Dec 2019 07:57:40 -0800 (PST)
MIME-Version: 1.0
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
 <1574952879-7200-2-git-send-email-akinobu.mita@gmail.com>
 <5f85f65c-78b6-0b63-f975-a216f9823985@linaro.org>
In-Reply-To: <5f85f65c-78b6-0b63-f975-a216f9823985@linaro.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 8 Dec 2019 00:57:28 +0900
Message-ID: <CAC5umyg3J98ntrezxskdKTgdP-WsL9VjtzHpXxyxGxTZxcaQ8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] add header file for kelvin to/from Celsius
 conversion helpers
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191207_075742_624056_F2FA92F7 
X-CRM114-Status: GOOD (  21.29  )
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
Cc: linux-hwmon@vger.kernel.org, Amit Kucheria <amit.kucheria@verdurent.com>,
 Jean Delvare <jdelvare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Linux PM <linux-pm@vger.kernel.org>, Sujith Thomas <sujith.thomas@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Guenter Roeck <linux@roeck-us.net>,
 Keith Busch <kbusch@kernel.org>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEy5pyIN+aXpSjlnJ8pIDE6NDkgRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc+Ogo+Cj4gT24gMjgvMTEvMjAxOSAxNTo1NCwgQWtpbm9idSBNaXRhIHdyb3Rl
Ogo+ID4gVGhlcmUgYXJlIHNldmVyYWwgaGVscGVyIG1hY3JvcyB0byBjb252ZXJ0IGtlbHZpbiB0
by9mcm9tIENlbHNpdXMgaW4KPiA+IDxsaW51eC90aGVybWFsLmg+IGZvciB0aGVybWFsIGRyaXZl
cnMuICBUaGVzZSBhcmUgdXNlZnVsIGZvciBhbnkgb3RoZXIKPiA+IGRyaXZlcnMgb3Igc3Vic3lz
dGVtcywgYnV0IGl0J3Mgb2RkIHRvIGluY2x1ZGUgPGxpbnV4L3RoZXJtYWwuaD4ganVzdCBmb3IK
PiA+IHRoZSBoZWxwZXJzLgo+ID4KPiA+IFRoaXMgYWRkcyBhIG5ldyA8bGludXgvdGVtcGVyYXR1
cmUuaD4gdGhhdCBwcm92aWRlcyB0aGUgZXF1aXZhbGVudCBpbmxpbmUKPiA+IGZ1bmN0aW9ucyBm
b3IgYW55IGRyaXZlcnMgb3Igc3Vic3lzdGVtcy4gIEl0IGlzIGludGVuZGVkIHRvIHJlcGxhY2Ug
dGhlCj4gPiBoZWxwZXJzIGluIDxsaW51eC90aGVybWFsLmg+Lgo+ID4KPiA+IENjOiBTdWppdGgg
VGhvbWFzIDxzdWppdGgudGhvbWFzQGludGVsLmNvbT4KPiA+IENjOiBEYXJyZW4gSGFydCA8ZHZo
YXJ0QGluZnJhZGVhZC5vcmc+Cj4gPiBDYzogQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGluZnJhZGVh
ZC5vcmc+Cj4gPiBDYzogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPgo+ID4gQ2M6IERh
bmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgo+ID4gQ2M6IEFtaXQgS3Vj
aGVyaWEgPGFtaXQua3VjaGVyaWFAdmVyZHVyZW50LmNvbT4KPiA+IENjOiBKZWFuIERlbHZhcmUg
PGpkZWx2YXJlQHN1c2UuY29tPgo+ID4gQ2M6IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVz
Lm5ldD4KPiA+IENjOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+Cj4gPiBDYzogSmVu
cyBBeGJvZSA8YXhib2VAZmIuY29tPgo+ID4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPgo+ID4gQ2M6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBBa2lub2J1IE1pdGEgPGFraW5vYnUubWl0YUBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+
ICogdjIKPiA+IC0gYWRkIGRlY2lfa2VsdmluX3RvX21pbGxpY2Vsc2l1c193aXRoX29mZnNldCgp
IGluIGxpbnV4L3RlbXBlcmF0dXJlLmgKPiA+IC0gc3RvcCBpbmNsdWRpbmcgbGludXgvdGVtcGVy
YXR1cmUuaCBmcm9tIGxpbnV4L3RoZXJtYWwuaAo+ID4KPiA+ICBpbmNsdWRlL2xpbnV4L3RlbXBl
cmF0dXJlLmggfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQo+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2xpbnV4L3RlbXBlcmF0dXJlLmgKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC90ZW1wZXJhdHVyZS5oIGIvaW5jbHVkZS9saW51eC90ZW1wZXJhdHVyZS5o
Cj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMC4uNjc5ZTcwYQo+ID4g
LS0tIC9kZXYvbnVsbAo+ID4gKysrIGIvaW5jbHVkZS9saW51eC90ZW1wZXJhdHVyZS5oCj4gPiBA
QCAtMCwwICsxLDUxIEBACj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAg
Ki8KPiA+ICsjaWZuZGVmIF9MSU5VWF9URU1QRVJBVFVSRV9ICj4gPiArI2RlZmluZSBfTElOVVhf
VEVNUEVSQVRVUkVfSAo+Cj4gSXQgc291bmRzIHN0cmFuZ2UgdG8gY3JlYXRlIGEgdGVtcGVyYXR1
cmUgZmlsZSBqdXN0IGZvciBhIGZldyBjb252ZXJzaW9uCj4gZnVuY3Rpb25zLiBXaHkgbm90IGNy
ZWF0ZSBhbiB1bml0cy5oIGZpbGUsIHNvIHNvbWUgbW9yZSBjb252ZXJzaW9ucwo+IGNvdWxkIGJl
IGFkZGVkIGxhdGVyIChub3QgbmVjZXNzYXJpbHkgcmVsYXRlZCB0byB0ZW1wZXJhdHVyZSkgPwoK
RmluZSB3aXRoIG1lLgoKPiA+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4gPiArCj4gPiAr
I2RlZmluZSBBQlNPTFVURV9aRVJPX01JTExJQ0VMU0lVUyAtMjczMTUwCj4gPiArCj4gPiArc3Rh
dGljIGlubGluZSBsb25nIGtlbHZpbl90b19taWxsaWNlbHNpdXMobG9uZyB0KQo+Cj4gV2h5ICds
b25nJyA/CgpUaGVyZSdzIG5vIHNwZWNpZmljIHJlYXNvbiwgYnV0IHRoZSBleGlzdGluZyBERUNJ
X0tFTFZJTl9UT19DRUxTSVVTKCkgaW4KbGludXgvdGhlcm1hbC5oIGNvbnZlcnRzIHRvICdsb25n
Jy4KCkRvIHlvdSBwcmVmZXIgY2hhbmdpbmcgJ2xvbmcnIHRvICdpbnQnPwoKPiA+ICt7Cj4gPiAr
ICAgICByZXR1cm4gdCAqIDEwMDAgKyBBQlNPTFVURV9aRVJPX01JTExJQ0VMU0lVUzsKPiA+ICt9
Cj4gPiArCj4gPiArc3RhdGljIGlubGluZSBsb25nIG1pbGxpY2Vsc2l1c190b19rZWx2aW4obG9u
ZyB0KQo+ID4gK3sKPiA+ICsgICAgIHJldHVybiBESVZfUk9VTkRfQ0xPU0VTVCh0IC0gQUJTT0xV
VEVfWkVST19NSUxMSUNFTFNJVVMsIDEwMDApOwo+Cj4gUGxlYXNlIGRvbid0IGR1cGxpY2F0ZSB0
aGVzZSBvcGVyYXRpb25zLCBqdXN0IGRvIHRoZSBjb252ZXJzaW9uIHRvIHRoZQo+IHJpZ2h0IHVu
aXQgYW5kIHRoZW4gY2FsbCBhIHNpbmdsZSBmdW5jdGlvbi4KPgo+IFJlcGxhY2UgdGhlIGNvbnN0
YW50IGJ5IG1hY3JvcyBsaWtlIHdoYXQgd2UgZmluZCBpbiB0aW1lNjQuaC4KPgo+IGVnLgo+ICNk
ZWZpbmUgTUlMTElDRUxTSVVTX1BFUl9DRUxDSVVTIDEwMDAKCkhvdyBhYm91dCB0aGlzPwoKI2Rl
ZmluZSBBQlNPTFVURV9aRVJPX01JTExJQ0VMU0lVUyAtMjczMTUwCgpzdGF0aWMgaW5saW5lIGxv
bmcgbWlsbGlfa2VsdmluX3RvX21pbGxpY2Vsc2l1cyhsb25nIHQpCnsKICAgICAgICByZXR1cm4g
dCArIEFCU09MVVRFX1pFUk9fTUlMTElDRUxTSVVTOwp9CgpzdGF0aWMgaW5saW5lIGxvbmcgbWls
bGljZWxzaXVzX3RvX21pbGxpX2tlbHZpbihsb25nIHQpCnsKICAgICAgICByZXR1cm4gdCAtIEFC
U09MVVRFX1pFUk9fTUlMTElDRUxTSVVTOwp9CgojZGVmaW5lIE1JTExJREVHUkVFX1BFUl9ERUdS
RUUgMTAwMAojZGVmaW5lIE1JTExJREVHUkVFX1BFUl9ERUNJREVHUkVFIDEwMAoKc3RhdGljIGlu
bGluZSBsb25nIGtlbHZpbl90b19taWxsaWNlbHNpdXMobG9uZyB0KQp7CiAgICAgICAgcmV0dXJu
IG1pbGxpX2tlbHZpbl90b19taWxsaWNlbHNpdXModCAqIE1JTExJREVHUkVFX1BFUl9ERUdSRUUp
Owp9CgpzdGF0aWMgaW5saW5lIGxvbmcgbWlsbGljZWxzaXVzX3RvX2tlbHZpbihsb25nIHQpCnsK
ICAgICAgICB0ID0gbWlsbGljZWxzaXVzX3RvX21pbGxpX2tlbHZpbih0KTsKCiAgICAgICAgcmV0
dXJuIERJVl9ST1VORF9DTE9TRVNUKHQsIE1JTExJREVHUkVFX1BFUl9ERUdSRUUpOwp9CgpzdGF0
aWMgaW5saW5lIGxvbmcgZGVjaV9rZWx2aW5fdG9fY2Vsc2l1cyhsb25nIHQpCnsKICAgICAgICB0
ID0gbWlsbGlfa2VsdmluX3RvX21pbGxpY2Vsc2l1cyh0ICogTUlMTElERUdSRUVfUEVSX0RFQ0lE
RUdSRUUpOwoKICAgICAgICByZXR1cm4gRElWX1JPVU5EX0NMT1NFU1QodCwgTUlMTElERUdSRUVf
UEVSX0RFR1JFRSk7Cn0KCnN0YXRpYyBpbmxpbmUgbG9uZyBjZWxzaXVzX3RvX2RlY2lfa2Vsdmlu
KGxvbmcgdCkKewogICAgICAgIHQgPSBtaWxsaWNlbHNpdXNfdG9fbWlsbGlfa2VsdmluKHQgKiBN
SUxMSURFR1JFRV9QRVJfREVHUkVFKTsKCiAgICAgICAgcmV0dXJuIERJVl9ST1VORF9DTE9TRVNU
KHQsIE1JTExJREVHUkVFX1BFUl9ERUNJREVHUkVFKTsKfQoKLyoqCiAqIGRlY2lfa2VsdmluX3Rv
X21pbGxpY2Vsc2l1c193aXRoX29mZnNldCAtIGNvbnZlcnQgS2VsdmluIHRvIENlbHNpdXMKICog
QHQ6IHRlbXBlcmF0dXJlIHZhbHVlIGluIGRlY2lkZWdyZWVzIEtlbHZpbgogKiBAb2Zmc2V0OiBk
aWZmZXJlbmNlIGJldHdlZW4gS2VsdmluIGFuZCBDZWxzaXVzIGluIG1pbGxpZGVncmVlcwogKgog
KiBSZXR1cm46IHRlbXBlcmF0dXJlIHZhbHVlIGluIG1pbGxpZGVncmVlcyBDZWxzaXVzCiAqLwpz
dGF0aWMgaW5saW5lIGxvbmcgZGVjaV9rZWx2aW5fdG9fbWlsbGljZWxzaXVzX3dpdGhfb2Zmc2V0
KGxvbmcgdCwgbG9uZyBvZmZzZXQpCnsKICAgICAgICByZXR1cm4gdCAqIE1JTExJREVHUkVFX1BF
Ul9ERUNJREVHUkVFIC0gb2Zmc2V0Owp9CgpzdGF0aWMgaW5saW5lIGxvbmcgZGVjaV9rZWx2aW5f
dG9fbWlsbGljZWxzaXVzKGxvbmcgdCkKewogICAgICAgIHJldHVybiBtaWxsaV9rZWx2aW5fdG9f
bWlsbGljZWxzaXVzKHQgKiBNSUxMSURFR1JFRV9QRVJfREVDSURFR1JFRSk7Cn0KCnN0YXRpYyBp
bmxpbmUgbG9uZyBtaWxsaWNlbHNpdXNfdG9fZGVjaV9rZWx2aW4obG9uZyB0KQp7CiAgICAgICAg
dCA9IG1pbGxpY2Vsc2l1c190b19taWxsaV9rZWx2aW4odCk7CgogICAgICAgIHJldHVybiBESVZf
Uk9VTkRfQ0xPU0VTVCh0LCBNSUxMSURFR1JFRV9QRVJfREVDSURFR1JFRSk7Cn0KCj4gU28geW91
IGNhbiByZWFsbHkgZG8gdGhlIGNsZWFudXAgaW4gYWxsIHRoZSBkcml2ZXJzLCBsaWtlIHJlbW92
aW5nOgoKT0suICBJJ2xsIHRyeSBhcyBtdWNoIGFzIHBvc3NpYmxlLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
bGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
