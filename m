Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195E1C432C3
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 14:35:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D310420740
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 14:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ByZvqnX0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm9h9oP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D310420740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zX8U/qu+laFIAI8eUl7YZ7a13m5VSbbHgm33pZftl38=; b=ByZvqnX0+FNe4a
	zqr/Xh1iXMp5sZF4Fi5PQp+mdMSiodZJr07JsNxPgZ/vdRYwPeEY5BoAYMs9pqMdKGAOj+Gz13Hk8
	twKi0Pvb0uIZ4JViZsVc9tLMT78COvE/pdftOZkpR4z57MZNHxkE2uZT134kzEPT7cJdpjyeN1PIG
	PGNv62qtjV0JNCRp32dVUzKkF/hzGgr9NWu3NZJiXlznceqVEy23K1bka/S1grZHo1biC3oEv2xqD
	IaIQl+4qhcvDaJtO7Z5tpKvq9NazilyEtKb+HF0USAZICatGFdmrm9/sjdEAnrM4H3vu9E5Co0rXm
	SnRGEmT6DuVDbMim5WGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZFSE-00036M-6L; Mon, 25 Nov 2019 14:35:06 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZFSB-0002Ta-97
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 14:35:04 +0000
Received: by mail-lf1-x143.google.com with SMTP id 203so11174783lfa.12
 for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2019 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mOb7drR/WTWufTxzUC4FI8sP3G8txIhCN7WbUI3E994=;
 b=Vm9h9oP4w8AakWL2fpCxlWT8rExaAbM1+kSqScdhnmQG1luK1zgK6Jdlquh2waUpHm
 RyapDHjTaFbxM32TvEKBApfC1ZzIfq/ddxiMGvmNPWU0jFOQofKhnhYGIuenJEo9NJh9
 YX2bY8OEFxZZX8p9ZDUh6bY4c82EAlazeV2P8fpk65wyUCN40/3CF2zqDgvCI9J5uoGb
 VKByqCEAwySpm39p8W7jQycG9Ufsh4BO/IRn6fvYXWpFXgXbxwED9tePDWk/RURVP+jw
 qqckozcfMLX8scEKBgiP+kWniBitb80gZKNMZDbv2qBWO5nZ5Og9dSZxDpWX4Q9R82r2
 nR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mOb7drR/WTWufTxzUC4FI8sP3G8txIhCN7WbUI3E994=;
 b=okCfTTmRMbgenu/ZeJGp16Lw65mEuQCztZlsaXDTS607xo2/uberrLab1nbYOdLIBv
 taE3ZLpRqXZ6KI6uUNz537flD8tnuD2JAeVankTb8hseWvfxo2kg03RGVDJaGRrxHaeh
 TjHzLxM47kgNhhu0xrZB9LUEIaHD2y0jqjXYCJx8GtS+zBqsivHmo3WxZ/kmOeeCrz+a
 gT5+45GHwEKRAzbNnpHItFodnBRsF7bvzCfivTZhxBL+aVjMzbXdNce4udPDFc5W7QFz
 tehJ4mKoKDdNNCu9LH3A8JhkZODZZ9HJZGE4JPgiDJJBlFw7otlcYYHNu70YEWm1h7Ba
 5hUg==
X-Gm-Message-State: APjAAAXQ/ZN2O+lJyxiIadQr9Iu+h2uTnIJLFSXFyVu0CwWMA/07OF02
 i/po9eQ1u6MqjA/ac2jOf5kVDgNHfZLl77lYKs0=
X-Google-Smtp-Source: APXvYqzbXX4EpoK9rwjhMiOUCyPCyQLDSuvkp+U1kLrHk/9+VVPTL0+HDaQ9/gLUpO6yoEMWsqdZTWB6OqR8naZMiq0=
X-Received: by 2002:ac2:428d:: with SMTP id m13mr15000406lfh.64.1574692501816; 
 Mon, 25 Nov 2019 06:35:01 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-5-git-send-email-akinobu.mita@gmail.com>
 <CAHp75VfOUiN_2bW+o-AqGmAY32mmdNxP54B2f2+gj0NTEr9FTQ@mail.gmail.com>
In-Reply-To: <CAHp75VfOUiN_2bW+o-AqGmAY32mmdNxP54B2f2+gj0NTEr9FTQ@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 25 Nov 2019 23:34:50 +0900
Message-ID: <CAC5umygc95VBWz1L5CTZO9kmkZL2MCEL2_z9d2TJ6Ow5+fKYPw@mail.gmail.com>
Subject: Re: [PATCH 4/8] platform/x86: intel_menlow: switch to use
 <linux/temperature.h> helpers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191125_063503_329803_A056696A 
X-CRM114-Status: GOOD (  17.21  )
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
Cc: linux-hwmon@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Amit Kucheria <amit.kucheria@verdurent.com>, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, Linux PM <linux-pm@vger.kernel.org>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Keith Busch <kbusch@kernel.org>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEx5pyIMjXml6Uo5pyIKSA0OjU4IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT46Cj4KPiBPbiBTdW4sIE5vdiAyNCwgMjAxOSBhdCA0OjA5IFBNIEFraW5v
YnUgTWl0YSA8YWtpbm9idS5taXRhQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gVGhpcyBzd2l0
Y2hlcyB0aGUgaW50ZWxfbWVubG93IGRyaXZlciB0byB1c2UgZGVjaV9rZWx2aW5fdG9fY2Vsc2l1
cygpIGFuZAo+ID4gY2Vsc2l1c190b19kZWNpX2tlbHZpbigpIGluIDxsaW51eC90ZW1wZXJhdHVy
ZS5oPiBpbnN0ZWFkIG9mIGhlbHBlcnMgaW4KPiA+IDxsaW51eC90aGVybWFsLmg+Lgo+ID4KPiA+
IFRoaXMgaXMgcHJlcGFyYXRpb24gZm9yIGNlbnRyYWxpemluZyB0aGUga2VsdmluIHRvL2Zyb20g
Q2Vsc2l1cyBjb252ZXJzaW9uCj4gPiBoZWxwZXJzIGluIDxsaW51eC90ZW1wcmF0dXJlLmg+Lgo+
ID4KPiA+IENjOiBTdWppdGggVGhvbWFzIDxzdWppdGgudGhvbWFzQGludGVsLmNvbT4KPiA+IENj
OiBEYXJyZW4gSGFydCA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+Cj4gPiBDYzogQW5keSBTaGV2Y2hl
bmtvIDxhbmR5QGluZnJhZGVhZC5vcmc+Cj4gPiBDYzogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50
ZWwuY29tPgo+ID4gQ2M6IEVkdWFyZG8gVmFsZW50aW4gPGVkdWJlenZhbEBnbWFpbC5jb20+Cj4g
PiBDYzogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+Cj4gPiBDYzog
QW1pdCBLdWNoZXJpYSA8YW1pdC5rdWNoZXJpYUB2ZXJkdXJlbnQuY29tPgo+ID4gQ2M6IEplYW4g
RGVsdmFyZSA8amRlbHZhcmVAc3VzZS5jb20+Cj4gPiBDYzogR3VlbnRlciBSb2VjayA8bGludXhA
cm9lY2stdXMubmV0Pgo+ID4gQ2M6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4KPiA+
IENjOiBKZW5zIEF4Ym9lIDxheGJvZUBmYi5jb20+Cj4gPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+Cj4gPiBDYzogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KPiA+
IFNpZ25lZC1vZmYtYnk6IEFraW5vYnUgTWl0YSA8YWtpbm9idS5taXRhQGdtYWlsLmNvbT4KPiA+
IC0tLQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX21lbmxvdy5jIHwgOCArKysrKy0t
LQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX21lbmxvdy5jIGIv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfbWVubG93LmMKPiA+IGluZGV4IGIxMDJmNmQuLjYz
MTM1OTEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9tZW5sb3cu
Ywo+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfbWVubG93LmMKPiA+IEBAIC0z
MDIsOCArMzAyLDEwIEBAIHN0YXRpYyBzc2l6ZV90IGF1eF9zaG93KHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmRldl9hdHRyLAo+ID4gICAgICAgICBpbnQgcmVz
dWx0Owo+ID4KPiA+ICAgICAgICAgcmVzdWx0ID0gc2Vuc29yX2dldF9hdXh0cmlwKGF0dHItPmhh
bmRsZSwgaWR4LCAmdmFsdWUpOwo+ID4gKyAgICAgICBpZiAocmVzdWx0KQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiByZXN1bHQ7Cj4gPgo+ID4gLSAgICAgICByZXR1cm4gcmVzdWx0ID8gcmVz
dWx0IDogc3ByaW50ZihidWYsICIlbHUiLCBERUNJX0tFTFZJTl9UT19DRUxTSVVTKHZhbHVlKSk7
Cj4gPiArICAgICAgIHJldHVybiBzcHJpbnRmKGJ1ZiwgIiVsZCIsIGRlY2lfa2VsdmluX3RvX2Nl
bHNpdXModmFsdWUpKTsKPgo+IENhbiB5b3UgZXhwbGFpbiB0aGUgY2hhbmdlICVsdSB0byAlbGQ/
CgpJc24ndCBpdCBwb3NzaWJsZSBmb3IgYXV4IHZhbHVlcyB0byBiZSBsb3dlciB0aGFuIDAgZGVn
cmVlcyBDZWxzaXVzPwoKPiA+ICB9Cj4gPgo+ID4gIHN0YXRpYyBzc2l6ZV90IGF1eDBfc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsCj4gPiBAQCAtMzMyLDggKzMzNCw4IEBAIHN0YXRpYyBzc2l6ZV90
IGF1eF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpk
ZXZfYXR0ciwKPiA+ICAgICAgICAgaWYgKHZhbHVlIDwgMCkKPiA+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsKPiA+Cj4gPiAtICAgICAgIHJlc3VsdCA9IHNlbnNvcl9zZXRfYXV4dHJp
cChhdHRyLT5oYW5kbGUsIGlkeCwKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIENFTFNJVVNfVE9fREVDSV9LRUxWSU4odmFsdWUpKTsKPgo+ID4gKyAgICAgICByZXN1bHQg
PSBzZW5zb3Jfc2V0X2F1eHRyaXAoYXR0ci0+aGFuZGxlLCBpZHgsCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjZWxzaXVzX3RvX2RlY2lfa2VsdmluKHZhbHVlKSk7Cj4K
PiBIb3cgY29tZSB0aGUgZmlyc3QgbGluZSBoYXMgYmVlbiBjaGFuZ2VkPwoKQmVjYXVzZSB0aGUg
dHJhaWxpbmcgc3BhY2UgaXMgcmVtb3ZlZC4gIEknbGwgbWVudGlvbiBpdCBpbiB0aGUgY29tbWl0
IGxvZy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
