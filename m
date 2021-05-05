Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E61C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:05:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB438611ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB438611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l8Rb5hwxs0Qtd72+YN4e0vgLaQnIXnJq9mu9UaGY7tI=; b=Va4T/CW6nJ/83B9yJbX+Hax6X
	EOyPmgOJzmiOyGruUjkcl0XT8TSBKxqQR+5oB/dQHwbEBSTv23VAgUxHIWSLb0t78fgeAK/f1x4Fs
	jCUBh/Ifl3/0krx/MRYOb5UfiaCFjrq8nWPaZTE6mhfXE8wtzWJ7x2yn+Yo/b/yvhR2s8yOrXEhRd
	9i+rkwkB6ySVDyhycp8MHKsdLVDKMQLvTGYoRP7ZU6HUj2iL3a1rT2QGMzDuAmtFSECPVbhqKg4AX
	L23JVc1HB9Fyez/oChkiDaKaqpjlsCmn9Z0DA71nghn5khP+FKB6xp8f9no+6gVbpLQ80K/jF0fnP
	8ZxKUMItg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leLtZ-001yeQ-Dg; Wed, 05 May 2021 18:05:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLtV-001ydq-Ce
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 18:05:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=IPnNIGO5yG2+vXM/Dm7U8VB8CqjyrrjDLSmppWbDvL0=; b=sK3Awkesb864uF1zKQBxQqHC6z
 rmZMr0jyYUmxEd1yG9zeBiB73HT+JW5xh73W1MwXLTz4gw7vSR40aAfxvWMAtsKCStSPv7r8OIvGN
 IK1nEU5mbaYvdNcKd8ywNRkXqy2XOtWHfutq1JDKqCBPMapjahLGmB0qa0/2qyU104cdCUpiWeazh
 NcpYo9RrzlAzdwu35b3wZyrBLHGf4DyZe3p/hFccrtgD/MsJuFJt29CSIMfc6Ml3If/SoAwMqAtTh
 JCGm7tnYTYaTEDOkPDwCtkW51kZBxer1xE4bt+ETQr2Zb82p1GNy9z86YkzUXJtdidoAc4tYeQta2
 Wkv148Bg==;
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLtS-0057jV-RT
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 18:05:08 +0000
Received: by mail-ej1-x635.google.com with SMTP id gx5so4224206ejb.11
 for <linux-nvme@lists.infradead.org>; Wed, 05 May 2021 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IPnNIGO5yG2+vXM/Dm7U8VB8CqjyrrjDLSmppWbDvL0=;
 b=JIqG28cLDacqUlTQcu8RSb2pvMEcg12h3u2mSQyi9L4wJ9yibeOoJ+ZCe7S+m1W5Mm
 /0M6CRtzavAh62amnP4rPRndTbn2kx9Q9xBDMrQsGdTqCmXHy9JWOTeahbCnuN5HgJcF
 e2K+ysS/ih3hPHNfNHCMkn5DovNKmqs+tYxhcVQ0Ip1lPByZz1N5eKp+bkHQFXZrXBuj
 28kHXolOsRMcoe9zgCgN5LgXxZV/PLSCy49d52N4O4uQHGA6o85d7qhE9s5/e5sXU3Mb
 tPOAr8eAn1JTeXzfmm7uO7eQTCwqTeC3U1OTmHak4FqhbCvu4QI2EuOQ4gLvGrFXC1tw
 S6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IPnNIGO5yG2+vXM/Dm7U8VB8CqjyrrjDLSmppWbDvL0=;
 b=Y7j7bvB8cQf8blN7zoRaNYNFTy/joco5xeGGgCPunctdtEq8f1DinGJ5grDLrW95MA
 tBdDDvPtJkyIFuIUfEBO00nioQC9AhDLb7MQE/NnNE9p6eRaPM2T+nkpRuScHA/8TJYx
 vZUaPoas1QtkokIWYJxEmzaRBIwIuoymTSEGwtdIME9ezDjSyQ6mCNfhEw0I3nc2rX4b
 NouQ6yntIEQQar/aPuzjDEgoInqfGqfylOo6SktmwtTw4zPLbiKj0mXPss4HdpxoOuGT
 z6hvRc7W4ypbiYfDex12Fd7uys/BDQRBkoZxpwWfaphnwDwSugGjSIzKNDKmiH3tMzTR
 2VrQ==
X-Gm-Message-State: AOAM532q9uTp/i2NpxfXe3qKKm+41oCZ52SBMqBfXvZPtMexo6l1PrpL
 J+hbRXD2FP16vIx4JCYM0Nm814U55Nh5Qa6rgCI=
X-Google-Smtp-Source: ABdhPJz+vhTrS2PnGcJnIGdCf3sJB862raYjZSdtW8PMS5CE829QfAHhOfskgsRRy6oZI6Aup4k0y5zSQCOP2/pgGU0=
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr40159ejd.168.1620237903965; 
 Wed, 05 May 2021 11:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-26-smalin@marvell.com>
 <92c994a9-004e-55b0-b345-6c555953bab0@suse.de>
In-Reply-To: <92c994a9-004e-55b0-b345-6c555953bab0@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 5 May 2021 21:04:52 +0300
Message-ID: <CAKKgK4yq7ZGiad+ToQ9YstosA+3NYb8tcMKQ+iRxtbdVnUOU0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 25/27] qedn: Add IO level fastpath functionality
To: Hannes Reinecke <hare@suse.de>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org, 
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, pkushwaha@marvell.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_110506_913491_2FEDF68A 
X-CRM114-Status: GOOD (  16.35  )
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

T24gNS8yLzIxIDI6NTQgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA0LzI5LzIxIDk6
MDkgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gPiBUaGlzIHBhdGNoIHdpbGwgcHJlc2VudCB0aGUg
SU8gbGV2ZWwgZnVuY3Rpb25hbGl0eSBvZiBxZWRuCj4gPiBudm1lLXRjcC1vZmZsb2FkIGhvc3Qg
bW9kZS4gVGhlIHFlZG5fdGFza19jdHggc3RydWN0dXJlIGlzIGNvbnRhaW5pbmcKPiA+IHZhcmlv
dXMgcGFyYW1zIGFuZCBzdGF0ZSBvZiB0aGUgY3VycmVudCBJTywgYW5kIGlzIG1hcHBlZCAxeDEg
dG8gdGhlCj4gPiBmd190YXNrX2N0eCB3aGljaCBpcyBhIEhXIGFuZCBGVyBJTyBjb250ZXh0Lgo+
ID4gQSBxZWRuX3Rhc2sgaXMgbWFwcGVkIGRpcmVjdGx5IHRvIGl0cyBwYXJlbnQgY29ubmVjdGlv
bi4KPiA+IEZvciBldmVyeSBuZXcgSU8gYSBxZWRuX3Rhc2sgc3RydWN0dXJlIHdpbGwgYmUgYXNz
aWduZWQgYW5kIHRoZXkgd2lsbCBiZQo+ID4gbGlua2VkIGZvciB0aGUgZW50aXJlIElPJ3MgbGlm
ZSBzcGFuLgo+ID4KPiA+IFRoZSBwYXRjaCB3aWxsIGluY2x1ZGUgMiBmbG93czoKPiA+ICAgIDEu
IFNlbmQgbmV3IGNvbW1hbmQgdG8gdGhlIEZXOgo+ID4gICAgICAgIFRoZSBmbG93IGlzOiBudm1l
X3RjcF9vZmxkX3F1ZXVlX3JxKCkgd2hpY2ggaW52b2tlcyBxZWRuX3NlbmRfcmVxKCkKPiA+ICAg
ICAgICB3aGljaCBpbnZva2VzIHFlZG5fcXVldWVfcmVxdWVzdCgpIHdoaWNoIHdpbGw6Cj4gPiAg
ICAgICAtIEFzc2lnbiBmd190YXNrX2N0eC4KPiA+ICAgICAgICAtIFByZXBhcmUgdGhlIFJlYWQv
V3JpdGUgU0cgYnVmZmVyLgo+ID4gICAgICAgIC0gIEluaXRpYWxpemUgdGhlIEhXIGFuZCBGVyBj
b250ZXh0Lgo+ID4gICAgICAgIC0gUGFzcyB0aGUgSU8gdG8gdGhlIEZXLgo+ID4KPiA+ICAgIDIu
IFByb2Nlc3MgdGhlIElPIGNvbXBsZXRpb246Cj4gPiAgICAgICBUaGUgZmxvdyBpczogcWVkbl9p
cnFfaGFuZGxlcigpIHdoaWNoIGludm9rZXMgcWVkbl9md19jcV9mcF9oYW5kbGVyKCkKPiA+ICAg
ICAgICB3aGljaCBpbnZva2VzIHFlZG5faW9fd29ya19jcSgpIHdoaWNoIHdpbGw6Cj4gPiAgICAg
ICAgLSBwcm9jZXNzIHRoZSBGVyBjb21wbGV0aW9uLgo+ID4gICAgICAgIC0gUmV0dXJuIHRoZSBm
d190YXNrX2N0eCB0byB0aGUgdGFzayBwb29sLgo+ID4gICAgICAgIC0gY29tcGxldGUgdGhlIG52
bWUgcmVxLgo+ID4KPiA+IEFja2VkLWJ5OiBJZ29yIFJ1c3NraWtoIDxpcnVzc2tpa2hAbWFydmVs
bC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBrdXNod2FoYUBt
YXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlA
bWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2FsZGVyb24gPG1rYWxkZXJv
bkBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFy
dmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFpIE1hbGluIDxzbWFsaW5AbWFydmVsbC5j
b20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbi5oICAgICAgfCAgIDQg
Kwo+ID4gICBkcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuX2Nvbm4uYyB8ICAgMSArCj4gPiAgIGRy
aXZlcnMvbnZtZS9ody9xZWRuL3FlZG5fdGFzay5jIHwgMjY5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyNzIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPiA+Cj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNl
LmRlPgoKVGhhbmtzLgoKPgo+IENoZWVycywKPgo+IEhhbm5lcwo+IC0tCj4gRHIuIEhhbm5lcyBS
ZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKPiBoYXJlQHN1
c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OAo+IFNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
Zwo+IEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IElt
ZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
