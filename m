Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C6DC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 21:05:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E124920748
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 21:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GymGLU0o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XC4aZohk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E124920748
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KKzc+y/eu+4xl57ZSZqtT+QVjeBaH0wamYw+anuBqXY=; b=GymGLU0oLn9WRELbJhhLygUsf
	+4jYJ5pF2BcjMHcSf3aA1qXnjRUggzLjuhHWDBg/LpEP2Pk6z4hD8oZIMRMKmf9ga6nsyr1EJBuZo
	uli9tWWrmpwrrwi7bSPhndHAHDEiQWrZuRmkN4FOieKucNqK5v8YkWqoV4VJNxUCcF+oPCxDhGHrO
	P6Peo75ooRFzo5DBgo7rnPhDreWroxPnJaMMC6UhpnuFTpjskwck+EkIZum2qqMpnfQsuzV3Rfwrz
	5MWWp2O35SSAmEOoJtVVowahjY54eFHlAsrZFB1AF2jiS/tc3bEmh1M9scIsUNApLRZJ6Lvw5V+BQ
	rqK2mhQAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8rk0-0003WH-21; Thu, 20 Aug 2020 21:04:56 +0000
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8rjx-0003Vb-At
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 21:04:54 +0000
Received: by mail-pj1-x1042.google.com with SMTP id e4so1517011pjd.0
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=Zcc+NGRWbENG8Cx898OZkzzVSFf3umhqdMUXYNE3BQ4=;
 b=XC4aZohkkZwLVdKp3OalFhPFFiyihqnY47/5HmeNKAcBcvSrKkiB4Y6PmUpvmBM+qP
 q1YKTXkbGPpA6I0oiFSh/jqqGilbCGinWSxaQ1zNnZcNwGSSMNCTqOBFbuLS9oySxokV
 8LkKaIzjos8miKQIGY+3n8NysndqbQp1XCPyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Zcc+NGRWbENG8Cx898OZkzzVSFf3umhqdMUXYNE3BQ4=;
 b=aV6XR42pADaUiOl7nbg5kUk3EWVBfZq1F6TYvqxG7zBbSOATafs4VeXt5Uc/PIcHlE
 zkQ92ofQ8M8vEmaQZ3tBWGYXGvsB0r1DBVp9Id6iQA9caEE9v2G8/DETliE2ARjrdGf3
 OGZmcdGzdZiepgKSh/VePLG+juU3sWr+v8qJofO7Ueh2uLZ3ufaj/SUhs/l+hXsO5S7u
 /hIq8GB84S6f2knY1xwyJ+VsMuJuXAMHDk9w9mY56rLm+SsvmJjM3ki9dkk/5kUShbtY
 jlRyZEmvWBwhhsNbw8QFe9J1UyCV+h5GkS0lSHV9ilNUEqnN2DSllzjw5R6mki6zfNd1
 bQOA==
X-Gm-Message-State: AOAM531n21psPQ8iniXWgVjX751tLy24ONKtTQVhlip9MGDH4P4Lnf6V
 8jthc6A/vyY5QoNxAQImSgnztg==
X-Google-Smtp-Source: ABdhPJwqXDxqRmHBdkV2eFVEsnN8aNW0PpYtwVOBc62KxstXnUYq8XP3sjozQc6bGQstTF8ZzTmkeg==
X-Received: by 2002:a17:902:c382:: with SMTP id
 g2mr187822plg.120.1597957491383; 
 Thu, 20 Aug 2020 14:04:51 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id m3sm3050240pjs.22.2020.08.20.14.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 14:04:50 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] nvme-rdma: serialize controller teardown sequences
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-8-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <c9d8a30c-e41f-d94e-7682-2a33cc06d7fc@broadcom.com>
Date: Thu, 20 Aug 2020 14:04:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200820053651.197057-8-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_170453_384513_7FD75689 
X-CRM114-Status: GOOD (  27.00  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzE5LzIwMjAgMTA6MzYgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gSW4gdGhlIHRp
bWVvdXQgaGFuZGxlciB3ZSBtYXkgbmVlZCB0byBjb21wbGV0ZSBhIHJlcXVlc3QgYmVjYXVzZSB0
aGUKPiByZXF1ZXN0IHRoYXQgdGltZWQgb3V0IG1heSBiZSBhbiBJL08gdGhhdCBpcyBhIHBhcnQg
b2YgYSBzZXJpYWwgc2VxdWVuY2UKPiBvZiBjb250cm9sbGVyIHRlYXJkb3duIG9yIGluaXRpYWxp
emF0aW9uLiBJbiBvcmRlciB0byBjb21wbGV0ZSB0aGUKPiByZXF1ZXN0LCB3ZSBuZWVkIHRvIGZl
bmNlIGFueSBvdGhlciBjb250ZXh0IHRoYXQgbWF5IGNvbXBldGUgd2l0aCB1cwo+IGFuZCBjb21w
bGV0ZSB0aGUgcmVxdWVzdCB0aGF0IGlzIHRpbWluZyBvdXQuCj4KPiBJbiB0aGlzIGNhc2UsIHdl
IGNvdWxkIGhhdmUgYSBwb3RlbnRpYWwgZG91YmxlIGNvbXBsZXRpb24gaW4gY2FzZQo+IGEgaGFy
ZC1pcnEgb3IgYSBkaWZmZXJlbnQgY29tcGV0aW5nIGNvbnRleHQgdHJpZ2dlcmVkIGVycm9yIHJl
Y292ZXJ5Cj4gYW5kIGlzIHJ1bm5pbmcgaW5mbGlnaHQgcmVxdWVzdCBjYW5jZWxsYXRpb24gY29u
Y3VycmVudGx5IHdpdGggdGhlCj4gdGltZW91dCBoYW5kbGVyLgo+Cj4gUHJvdGVjdCB1c2luZyBh
IGN0cmwgdGVhcmRvd25fbG9jayB0byBzZXJpYWxpemUgY29udGV4dHMgdGhhdCBtYXkKPiBjb21w
bGV0ZSBhIGNhbmNlbGxlZCByZXF1ZXN0IGR1ZSB0byBlcnJvciByZWNvdmVyeSBvciBhIHJlc2V0
Lgo+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IFNpZ25l
ZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gLS0tCj4gICBkcml2
ZXJzL252bWUvaG9zdC9yZG1hLmMgfCA2ICsrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+IGluZGV4IDRjNTY2MDIwMTAwOS4uZWQzODdmNjFmOGY3
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3JkbWEuYwo+IEBAIC0xMjIsNiArMTIyLDcgQEAgc3RydWN0IG52bWVfcmRtYV9j
dHJsIHsKPiAgIAlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBzcmNfYWRkcjsKPiAgIAo+ICAgCXN0
cnVjdCBudm1lX2N0cmwJY3RybDsKPiArCXN0cnVjdCBtdXRleAkJdGVhcmRvd25fbG9jazsKPiAg
IAlib29sCQkJdXNlX2lubGluZV9kYXRhOwo+ICAgCXUzMgkJCWlvX3F1ZXVlc1tIQ1RYX01BWF9U
WVBFU107Cj4gICB9Owo+IEBAIC05OTcsNiArOTk4LDcgQEAgc3RhdGljIGludCBudm1lX3JkbWFf
Y29uZmlndXJlX2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsIGJvb2wgbmV3
KQo+ICAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX3RlYXJkb3duX2FkbWluX3F1ZXVlKHN0cnVjdCBu
dm1lX3JkbWFfY3RybCAqY3RybCwKPiAgIAkJYm9vbCByZW1vdmUpCj4gICB7Cj4gKwltdXRleF9s
b2NrKCZjdHJsLT50ZWFyZG93bl9sb2NrKTsKPiAgIAlibGtfbXFfcXVpZXNjZV9xdWV1ZShjdHJs
LT5jdHJsLmFkbWluX3EpOwo+ICAgCW52bWVfcmRtYV9zdG9wX3F1ZXVlKCZjdHJsLT5xdWV1ZXNb
MF0pOwo+ICAgCWlmIChjdHJsLT5jdHJsLmFkbWluX3RhZ3NldCkgewo+IEBAIC0xMDA3LDExICsx
MDA5LDEzIEBAIHN0YXRpYyB2b2lkIG52bWVfcmRtYV90ZWFyZG93bl9hZG1pbl9xdWV1ZShzdHJ1
Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4gICAJaWYgKHJlbW92ZSkKPiAgIAkJYmxrX21xX3Vu
cXVpZXNjZV9xdWV1ZShjdHJsLT5jdHJsLmFkbWluX3EpOwo+ICAgCW52bWVfcmRtYV9kZXN0cm95
X2FkbWluX3F1ZXVlKGN0cmwsIHJlbW92ZSk7Cj4gKwltdXRleF91bmxvY2soJmN0cmwtPnRlYXJk
b3duX2xvY2spOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCBudm1lX3JkbWFfdGVhcmRvd25f
aW9fcXVldWVzKHN0cnVjdCBudm1lX3JkbWFfY3RybCAqY3RybCwKPiAgIAkJYm9vbCByZW1vdmUp
Cj4gICB7Cj4gKwltdXRleF9sb2NrKCZjdHJsLT50ZWFyZG93bl9sb2NrKTsKPiAgIAlpZiAoY3Ry
bC0+Y3RybC5xdWV1ZV9jb3VudCA+IDEpIHsKPiAgIAkJbnZtZV9zdGFydF9mcmVlemUoJmN0cmwt
PmN0cmwpOwo+ICAgCQludm1lX3N0b3BfcXVldWVzKCZjdHJsLT5jdHJsKTsKPiBAQCAtMTAyNSw2
ICsxMDI5LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX3RlYXJkb3duX2lvX3F1ZXVlcyhzdHJ1
Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4gICAJCQludm1lX3N0YXJ0X3F1ZXVlcygmY3RybC0+
Y3RybCk7Cj4gICAJCW52bWVfcmRtYV9kZXN0cm95X2lvX3F1ZXVlcyhjdHJsLCByZW1vdmUpOwo+
ICAgCX0KPiArCW11dGV4X3VubG9jaygmY3RybC0+dGVhcmRvd25fbG9jayk7Cj4gICB9Cj4gICAK
PiAgIHN0YXRpYyB2b2lkIG52bWVfcmRtYV9mcmVlX2N0cmwoc3RydWN0IG52bWVfY3RybCAqbmN0
cmwpCj4gQEAgLTIyNzgsNiArMjI4Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZV9jdHJsICpudm1l
X3JkbWFfY3JlYXRlX2N0cmwoc3RydWN0IGRldmljZSAqZGV2LAo+ICAgCQlyZXR1cm4gRVJSX1BU
UigtRU5PTUVNKTsKPiAgIAljdHJsLT5jdHJsLm9wdHMgPSBvcHRzOwo+ICAgCUlOSVRfTElTVF9I
RUFEKCZjdHJsLT5saXN0KTsKPiArCW11dGV4X2luaXQoJmN0cmwtPnRlYXJkb3duX2xvY2spOwo+
ICAgCj4gICAJaWYgKCEob3B0cy0+bWFzayAmIE5WTUZfT1BUX1RSU1ZDSUQpKSB7Cj4gICAJCW9w
dHMtPnRyc3ZjaWQgPQoKUTogc28geW91IGRvbid0IGJlbGlldmUgdGhlcmUncyBhbnkgY29uZmxp
Y3QgZnJvbSB0aGVzZSB0ZWFyZG93biBwYXRocyAKKHBvc3NpYmx5IGludm9rZWQgYnkgc3lzZnMg
ZGVsZXRlIGN0cmwpwqAgdnPCoCBhIHJlY29ubmVjdCAodGh1cyAKbnZtZV9yZG1hX3NldHVwX2N0
cmwpIGVuY291bnRlcmluZyBhIGZhaWx1cmUgZHVyaW5nIGNvbnRyb2xsZXIgaW5pdCwgCnRodXMg
aXQgaGl0cyB0aGUgZGVzdHJveV9pbyBhbmQgZGVzdHJveV9hZG1pbiBleGl0IHBhdGhzIC0gd2hp
Y2ggY2FsbCAKbnZtZV9yZG1hX2Rlc3Ryb3lfaW9fcXVldWVzIGFuZCBzdG9wL2Rlc3Ryb3lfYWRt
aW5fcXVldWUgLSB3aGljaCBjYW4gYmUgCnNpbXVsdGFuZW91cyB0byB0aGUgdGVhcmRvd25zIGFu
ZCB3aXRob3V0IHRoZSBtdXRleCA/CgotLSBqYW1lcwoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
