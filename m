Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C05DC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 13:57:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4066060C40
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 13:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4066060C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9ti9H7m/gIZk0Avm7nGmAnJlu0/2h4qAdhooJnW6kLc=; b=btajWzciDPZydD9NeqNGFjiEN
	Ut6pXWDvai4hQa3SIfw+pO21k1T2LayWyFHXBv923tuFxyj0Zv/EQRQzktEz3L7sc9S/Y5rU5vnK+
	+EKiPlwdwVrFMjSJPttDhTiyEycjmiYpkjkWZIbTVknE1LHfQy5mPLHmq5KgthACSLSPTNs0iMjvV
	87f3ZODZqTa0ghcd6gmmRqKHyjKIJXURzbJbGkzxvE6ecV/ocNae0YMwCRI+dsQOGA/SayKJIg0Cm
	IhTd7w2MmCK3oNYu10fW17zAdftOQK5OvL46/3G2aaUBjhakcT8QpCOPOzCaf9iDLg32/UKWxXz/c
	aBOMAVpJw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf0ys-007EAP-46; Fri, 07 May 2021 13:57:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf0yq-007E9k-LQ
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 13:57:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=QlTz9xj6lp+eZnKQtXhoB95xBxoI3W/Ee89KukGEB7w=; b=xm3BZs5mSQ7yYBId7y/TBQGs7+
 DjrSLWFddMUujkPVk/e0kDg721AWDG5Wqn9/lRreADI/PxBdViLsrtH+DaywfIVx+byUjEjtavxLC
 O8Rx9li8jEsKojpKWrICPwA2QgR66JiQZIoFCvgHwXL8V+5NZyBNxg/9wVPOYdrKglFtEAySVcQpa
 Hk6JUmhubCWm7+dHBNNsARa/hFKJrRBhzssWICigQI+R6RKuwhWxZl5OLwAJIQSa3g3QRIqowfqGM
 7qRE8FT+lNG1XD2madIHJnsj1ejd0Mk27sVaktBx9ONz/1VMCPGn5bl4R/ak5aFkmu9JXecv/4B5y
 TKAstpNw==;
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf0yo-006u3w-1T
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 13:57:23 +0000
Received: by mail-ej1-x633.google.com with SMTP id f24so13740654ejc.6
 for <linux-nvme@lists.infradead.org>; Fri, 07 May 2021 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QlTz9xj6lp+eZnKQtXhoB95xBxoI3W/Ee89KukGEB7w=;
 b=QESgEzJYkBr06wWFLgYi2/S0tq43bdS5yYhvRTo9rISFL88E/d7McPhgit1fGOt5/u
 WHt8wxpBywi21Sn0ZVf7GTiXftzNUXNAdMmG0j6cG96Td0tKEAkEhQDTk9aEfwyt7i3T
 CYYZ+gUc2HAw/gkVUHmKSg4EQK0oIbyhjRk9bI40pGkU+lD4O5GKd8h/GY+uptIdePCt
 9hHj3JCgBzdDeN0HupWKodVCOhnsL0xSqQGuErx3JB2/Zz9WKvL9VtfGGTDA0k1yPRXo
 7DqWTCsnf9ObCvMSCAr4Y2Vn80cQyAPqO2TzYpKiilgOZisRjY5grkDhW0bMK2Yc4VM5
 XvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QlTz9xj6lp+eZnKQtXhoB95xBxoI3W/Ee89KukGEB7w=;
 b=kiw5xWLiIY0wdHPJ9rTQqOra/02T8KAlPpSQJ8dhIcF4GBLYE/GwRyNGVLWvK1yrlU
 WwMWIYe8Lm8Y02JXvDclk+EbbwHDtweYvW1vxo6afWIadrrw3G21s7AEDDqbZtLZYzd8
 pt9W8HbiqYBX/9HoEmz9cEC4Ha5rb80z0IrgSDSrhosTIqDESrbyhAQ58Sy8805Jw7Ws
 r1wScuQtvPkhjiFsXGazcJ8f9CEqS+mY8UCXUNu6CTrVFN+LsItfqNgTLbtYpXnGOIoX
 D0gRFS9RwGiQTyvhUDDslcxLlDfF2XDu8ziUwocQlBPpz5FT0iF/M27ZbnZOnbZjn2UC
 d7lA==
X-Gm-Message-State: AOAM530figIN6p3SJ+Z420awA+Uefatxo3aMW7udleT00iUXTIRluHuT
 AuWhQXVZ1LO/yYKtxaUt0/Fg1VZ9F3qu5PeGAtg=
X-Google-Smtp-Source: ABdhPJywmJY1jSMDaESFPI4BIKtrVXlRH+9R5JCFoDV08yQ+ViKrwr5iFpVq0zHZXcAyZ2DE0TLU7fmZihY1I6dpwrE=
X-Received: by 2002:a17:906:90b:: with SMTP id
 i11mr10126700ejd.168.1620395839981; 
 Fri, 07 May 2021 06:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-19-smalin@marvell.com>
 <049e436b-d166-ebdd-5442-f616e7007d0e@suse.de>
In-Reply-To: <049e436b-d166-ebdd-5442-f616e7007d0e@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Fri, 7 May 2021 16:57:08 +0300
Message-ID: <CAKKgK4w5zWmrjkTOPgp8QhyXdQpNMrWiRT1DwshiED-hKvJ8wA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 18/27] qedn: Add qedn_claim_dev API support
To: Hannes Reinecke <hare@suse.de>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org, 
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, 
 pkushwaha@marvell.com, Nikolay Assa <nassa@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_065722_104927_DBB35A23 
X-CRM114-Status: GOOD (  23.67  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8yLzIxIDI6MjkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA0LzI5LzIxIDk6
MDkgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gPiBGcm9tOiBOaWtvbGF5IEFzc2EgPG5hc3NhQG1h
cnZlbGwuY29tPgo+ID4KPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyB0aGUgcWVkbl9jbGFpbV9k
ZXYoKSBuZXR3b3JrIHNlcnZpY2Ugd2hpY2ggdGhlCj4gPiBvZmZsb2FkIGRldmljZSAocWVkbikg
aXMgdXNpbmcgdGhyb3VnaCB0aGUgcGFpcmVkIG5ldC1kZXZpY2UgKHFlZGUpLgo+ID4gcWVkbl9j
bGFpbV9kZXYoKSByZXR1cm5zIHRydWUgaWYgdGhlIElQIGFkZHIoSVB2NCBvciBJUHY2KSBvZiB0
aGUgdGFyZ2V0Cj4gPiBzZXJ2ZXIgaXMgcmVhY2hhYmxlIHZpYSB0aGUgbmV0LWRldmljZSB3aGlj
aCBpcyBwYWlyZWQgd2l0aCB0aGUKPiA+IG9mZmxvYWRlZCBkZXZpY2UuCj4gPgo+ID4gQWNrZWQt
Ynk6IElnb3IgUnVzc2tpa2ggPGlydXNza2lraEBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYt
Ynk6IE5pa29sYXkgQXNzYSA8bmFzc2FAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
cmFiaGFrYXIgS3VzaHdhaGEgPHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYt
Ynk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBNaWNoYWwgS2FsZGVyb24gPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGFpIE1hbGluIDxzbWFsaW5AbWFydmVsbC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9u
dm1lL2h3L3FlZG4vcWVkbi5oICAgICAgfCAgNCArKysKPiA+ICAgZHJpdmVycy9udm1lL2h3L3Fl
ZG4vcWVkbl9tYWluLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+ID4g
ICAyIGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ody9xZWRuL3FlZG4uaCBiL2RyaXZlcnMvbnZt
ZS9ody9xZWRuL3FlZG4uaAo+ID4gaW5kZXggYzFhYzE3ZWFiY2I3Li43ZWZlMjM2NmViN2MgMTAw
NjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuLmgKPiA+ICsrKyBiL2RyaXZl
cnMvbnZtZS9ody9xZWRuL3FlZG4uaAo+ID4gQEAgLTgsNiArOCwxMCBAQAo+ID4KPiA+ICAgI2lu
Y2x1ZGUgPGxpbnV4L3FlZC9xZWRfaWYuaD4KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3FlZC9xZWRf
bnZtZXRjcF9pZi5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9xZWQvcWVkX252bWV0Y3BfaXBfc2Vy
dmljZXNfaWYuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvcWVkL3FlZF9jaGFpbi5oPgo+ID4gKyNp
bmNsdWRlIDxsaW51eC9xZWQvc3RvcmFnZV9jb21tb24uaD4KPiA+ICsjaW5jbHVkZSA8bGludXgv
cWVkL252bWV0Y3BfY29tbW9uLmg+Cj4gPgo+ID4gICAvKiBEcml2ZXIgaW5jbHVkZXMgKi8KPiA+
ICAgI2luY2x1ZGUgIi4uLy4uL2hvc3QvdGNwLW9mZmxvYWQuaCIKPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaHcvcWVkbi9xZWRuX21haW4uYyBiL2RyaXZlcnMvbnZtZS9ody9xZWRuL3Fl
ZG5fbWFpbi5jCj4gPiBpbmRleCBlM2U4ZTM2NzZiNzkuLjUyMDA3ZDM1NjIyZCAxMDA2NDQKPiA+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ody9xZWRuL3FlZG5fbWFpbi5jCj4gPiArKysgYi9kcml2ZXJz
L252bWUvaHcvcWVkbi9xZWRuX21haW4uYwo+ID4gQEAgLTI3LDkgKzI3LDQ3IEBAIHN0YXRpYyBp
bnQKPiA+ICAgcWVkbl9jbGFpbV9kZXYoc3RydWN0IG52bWVfdGNwX29mbGRfZGV2ICpkZXYsCj4g
PiAgICAgICAgICAgICAgc3RydWN0IG52bWVfdGNwX29mbGRfY3RybF9jb25fcGFyYW1zICpjb25u
X3BhcmFtcykKPiA+ICAgewo+ID4gLSAgICAgLyogUGxhY2Vob2xkZXIgLSBxZWRuX2NsYWltX2Rl
diAqLwo+ID4gKyAgICAgc3RydWN0IHBjaV9kZXYgKnFlZGVfcGRldiA9IE5VTEw7Cj4gPiArICAg
ICBzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiA9IE5VTEw7Cj4gPiArICAgICB1MTYgdmxhbl9pZCA9
IDA7Cj4gPiArICAgICBpbnQgcmMgPSAwOwo+ID4KPiA+IC0gICAgIHJldHVybiAwOwo+ID4gKyAg
ICAgLyogcWVkbiB1dGlsaXplcyBob3N0IG5ldHdvcmsgc3RhY2sgdGhyb3VnaCBwYWlyZWQgcWVk
ZSBkZXZpY2UgZm9yCj4gPiArICAgICAgKiBub24tb2ZmbG9hZCB0cmFmZmljLiBGaXJzdCB3ZSB2
ZXJpZnkgdGhlcmUgaXMgdmFsaWQgcm91dGUgdG8gcmVtb3RlCj4gPiArICAgICAgKiBwZWVyLgo+
ID4gKyAgICAgICovCj4gPiArICAgICBpZiAoY29ubl9wYXJhbXMtPnJlbW90ZV9pcF9hZGRyLnNz
X2ZhbWlseSA9PSBBRl9JTkVUKSB7Cj4gPiArICAgICAgICAgICAgIHJjID0gcWVkX3JvdXRlX2lw
djQoJmNvbm5fcGFyYW1zLT5sb2NhbF9pcF9hZGRyLAo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZjb25uX3BhcmFtcy0+cmVtb3RlX2lwX2FkZHIsCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmNvbm5fcGFyYW1zLT5yZW1vdGVfbWFjX2FkZHIsCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm5kZXYpOwo+ID4gKyAgICAgfSBl
bHNlIGlmIChjb25uX3BhcmFtcy0+cmVtb3RlX2lwX2FkZHIuc3NfZmFtaWx5ID09IEFGX0lORVQ2
KSB7Cj4gPiArICAgICAgICAgICAgIHJjID0gcWVkX3JvdXRlX2lwdjYoJmNvbm5fcGFyYW1zLT5s
b2NhbF9pcF9hZGRyLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZjb25u
X3BhcmFtcy0+cmVtb3RlX2lwX2FkZHIsCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJmNvbm5fcGFyYW1zLT5yZW1vdGVfbWFjX2FkZHIsCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJm5kZXYpOwo+ID4gKyAgICAgfSBlbHNlIHsKPiA+ICsgICAgICAg
ICAgICAgcHJfZXJyKCJhZGRyZXNzIGZhbWlseSAlZCBub3Qgc3VwcG9ydGVkXG4iLAo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgY29ubl9wYXJhbXMtPnJlbW90ZV9pcF9hZGRyLnNzX2ZhbWlseSk7
Cj4gPiArCj4gPiArICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPiA+ICsgICAgIH0KPiA+ICsK
PiA+ICsgICAgIGlmIChyYykKPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ID4gKwo+
ID4gKyAgICAgcWVkX3ZsYW5fZ2V0X25kZXYoJm5kZXYsICZ2bGFuX2lkKTsKPiA+ICsgICAgIGNv
bm5fcGFyYW1zLT52bGFuX2lkID0gdmxhbl9pZDsKPiA+ICsKPiA+ICsgICAgIC8qIHJvdXRlIGZv
dW5kIHRocm91Z2ggbmRldiAtIHZhbGlkYXRlIHRoaXMgaXMgcWVkZSovCj4gPiArICAgICBxZWRl
X3BkZXYgPSBxZWRfdmFsaWRhdGVfbmRldihuZGV2KTsKPiA+ICsgICAgIGlmICghcWVkZV9wZGV2
KQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4gPiArCj4gPiArICAgICBkZXYtPnFl
ZGVfcGRldiA9IHFlZGVfcGRldjsKPiA+ICsgICAgIGRldi0+bmRldiA9IG5kZXY7Cj4gPiArCj4g
PiArICAgICByZXR1cm4gdHJ1ZTsKPiA+ICAgfQo+ID4KPiA+ICAgc3RhdGljIGludCBxZWRuX2Ny
ZWF0ZV9xdWV1ZShzdHJ1Y3QgbnZtZV90Y3Bfb2ZsZF9xdWV1ZSAqcXVldWUsIGludCBxaWQsCj4g
Pgo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KClRoYW5rcy4K
Cj4KPiBDaGVlcnMsCj4KPiBIYW5uZXMKPiAtLQo+IERyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cj4gaGFyZUBzdXNlLmRlICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKPiBTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKPiBIUkIgMzY4MDkg
KEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
