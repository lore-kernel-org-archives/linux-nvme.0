Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6395FC3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:24:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3116523428
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cLLJrUyV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JU3cQsYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3116523428
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nNnkj1ixMW9Hk830c17zoPyN2V4XsbJHTMCh01zmB6o=; b=cLLJrUyV2i4S7shP7wLdq9Elc
	cFOrhOq6PqIs9ZF+6LK6h5FglPdI+bwOCO343Oiw2vR44chdQQ9XAfA+WkpODcKa+QbuaD0DseTa/
	X0HvqFhJbP2A6+mXaNMCBzXg96LSXAyHrd4c/27AgVBWIQLUQ6vWAcNdhPKXk7cJ0llkbDA6nTj5f
	JfiXgPGm8S8M0r+nGnJN85oSBc5GvvZbTo87kh7EF2oEXYond+8rTzKakvVJbyGec0q0oEB3Cj2sQ
	VddnCnoIkHZ/FNPrWYgCG9Mxse8ANXeqMPLp+gFPlUIOuX3r4S6NmY1ywKgu2M3oaaTgfHJZW+ura
	3CkwoRGdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3lZS-0006iV-Aa; Fri, 30 Aug 2019 18:24:26 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3lZP-0006iA-OJ
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:24:25 +0000
Received: by mail-pl1-x642.google.com with SMTP id bj8so3724514plb.4
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gzpgC3FTE2H5SLLu0moK6mkYYMgqL91tMfLk5oVosM8=;
 b=JU3cQsYWYe0tnwgoIEju2z1fN8m+/wLy4RGovNp6wdYJP3TUagMmn8TAueRcJ2fqeT
 jVH4aka/kNtqpfSFKuTdZwrV37T0EVaykoVQJb34LHqN3aWuSvBpm2pXYv0kxFPMrmcw
 APg6H+VrIIquoKxDNy6Uq8qLLA1af0NxEqEFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gzpgC3FTE2H5SLLu0moK6mkYYMgqL91tMfLk5oVosM8=;
 b=mWf+ys8eX0z6Nw9UL9BkV2/6+k5p46iZ8BBvMgXjnXgW9MLgqpl8aWbArqE1OzEM6V
 nz8NuJ+g6ma5FnXhAGXe+nBrvrJ7GxKj8RCdmhcxxBTTZ0q+sD1zik1wOL5kmzy2O91e
 J/OJlU/NElGcFXU1y7f7jL5QCDrmaImY1n6oBiFNYk8h+kcmhkHGwu+QWTAnGHwQCY5H
 Vow5yvjAx66n58GFrbqzjiEsuc0bD6eSq39QRnn+05J5oIZqw2IL6fmYMZGC4p3gh9dP
 7BbNXbZqCsnB3E41eAq2rGC3mXujipaXOtiXraxBDrGxelxg8ou/LokCAhyqVlzpqAVP
 786w==
X-Gm-Message-State: APjAAAXBQUrDJifft/8eITZoz/xNSsdFBbIzDqT8seJ9bs4uKBYfpYP2
 n/HWOBt13e7ciVkqO7A+czTOexZMQ7s=
X-Google-Smtp-Source: APXvYqw8mOBtv4lqimx4vJyvYaSM7lKuVqF+CLfiMoxDudEc1s/xXIYuzGILGBZbXUglaKhavGpI1w==
X-Received: by 2002:a17:902:100c:: with SMTP id
 b12mr17258122pla.40.1567189462803; 
 Fri, 30 Aug 2019 11:24:22 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id n9sm5752273pjq.30.2019.08.30.11.24.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 11:24:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: validate cntlid during controller initialisation
To: Christoph Hellwig <hch@lst.de>, hare@suse.de
References: <20190513062510.756-1-hch@lst.de> <20190513062510.756-3-hch@lst.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <749191be-9521-8a49-7fc9-a1a3a659f51b@broadcom.com>
Date: Fri, 30 Aug 2019 11:24:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190513062510.756-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_112423_801818_446F07FE 
X-CRM114-Status: GOOD (  24.21  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA1LzEyLzIwMTkgMTE6MjUgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IFRoZSBD
TlRMSUQgdmFsdWUgaXMgcmVxdWlyZWQgdG8gYmUgdW5pcXVlLCBhbmQgd2UgZG8gcmVseSBvbiB0
aGlzCj4gZm9yIGNvcnJlY3Qgb3BlcmF0aW9uLiBTbyByZWplY3QgYW55IGNvbnRyb2xsZXIgZm9y
IHdoaWNoIGEgbm9uLXVuaXF1ZQo+IENOVExJRCBoYXMgYmVlbiBkZXRlY3RlZC4KPgo+IEJhc2Vk
IG9uIGEgcGF0Y2ggZnJvbSBIYW5uZXMgUmVpbmVja2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPiBpbmRleCA3MGEyYmMwMWU0MWUuLjA5YTFkNWNhODcyZiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBA
QCAtMjM0MSwyMCArMjM0MSwzNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91
cCAqbnZtZV9zdWJzeXNfYXR0cnNfZ3JvdXBzW10gPSB7Cj4gICAJTlVMTCwKPiAgIH07Cj4gICAK
PiAtc3RhdGljIGludCBudm1lX2FjdGl2ZV9jdHJscyhzdHJ1Y3QgbnZtZV9zdWJzeXN0ZW0gKnN1
YnN5cykKPiArc3RhdGljIGJvb2wgbnZtZV92YWxpZGF0ZV9jbnRsaWQoc3RydWN0IG52bWVfc3Vi
c3lzdGVtICpzdWJzeXMsCj4gKwkJc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52bWVf
aWRfY3RybCAqaWQpCj4gICB7Cj4gLQlpbnQgY291bnQgPSAwOwo+IC0Jc3RydWN0IG52bWVfY3Ry
bCAqY3RybDsKPiArCXN0cnVjdCBudm1lX2N0cmwgKnRtcDsKPiAgIAo+ICAgCWxvY2tkZXBfYXNz
ZXJ0X2hlbGQoJm52bWVfc3Vic3lzdGVtc19sb2NrKTsKPiAgIAo+IC0JbGlzdF9mb3JfZWFjaF9l
bnRyeShjdHJsLCAmc3Vic3lzLT5jdHJscywgc3Vic3lzX2VudHJ5KSB7Cj4gLQkJaWYgKGN0cmwt
PnN0YXRlICE9IE5WTUVfQ1RSTF9ERUxFVElORyAmJgo+IC0JCSAgICBjdHJsLT5zdGF0ZSAhPSBO
Vk1FX0NUUkxfREVBRCkKPiAtCQkJY291bnQrKzsKPiArCWxpc3RfZm9yX2VhY2hfZW50cnkodG1w
LCAmc3Vic3lzLT5jdHJscywgc3Vic3lzX2VudHJ5KSB7Cj4gKwkJaWYgKGN0cmwtPnN0YXRlID09
IE5WTUVfQ1RSTF9ERUxFVElORyB8fAo+ICsJCSAgICBjdHJsLT5zdGF0ZSA9PSBOVk1FX0NUUkxf
REVBRCkKPiArCQkJY29udGludWU7Cj4gKwo+ICsJCWlmICh0bXAtPmNudGxpZCA9PSBjdHJsLT5j
bnRsaWQpIHsKPiArCQkJZGV2X2VycihjdHJsLT5kZXZpY2UsCj4gKwkJCQkiRHVwbGljYXRlIGNu
dGxpZCAldSB3aXRoICVzLCByZWplY3RpbmdcbiIsCj4gKwkJCQljdHJsLT5jbnRsaWQsIGRldl9u
YW1lKHRtcC0+ZGV2aWNlKSk7Cj4gKwkJCXJldHVybiBmYWxzZTsKPiArCQl9Cj4gKwkJaWYgKChp
ZC0+Y21pYyAmICgxIDw8IDEpKSB8fAo+ICsJCSAgICAoY3RybC0+b3B0cyAmJiBjdHJsLT5vcHRz
LT5kaXNjb3ZlcnlfbnFuKSkKPiArCQkgICAgCWNvbnRpbnVlOwoKRG8gd2UgaGF2ZSBhIHByb2Js
ZW0gaGVyZcKgIGlmIHRoZSBzdWJzeXN0ZW0gaXMgYSBkaXNjb3ZlcnkgY29udHJvbGxlciBucW4g
PwoKQXNzdW1lIHdlIGhhdmUgYSBjb25uZWN0aW9uIHRvIGEgZGlzY292ZXJ5IGNvbnRyb2xsZXIg
aW4gcGxhY2UgKGl0IGhhcyAKYmVlbiBjcmVhdGVkLCBpcyBpbiB0aGUgbWlkc3Qgb2YgcmVhZGlu
ZyB0aGUgZGlzY292ZXJ5IGxvZzsgb3IgYSAKbG9uZy1saXZlZCBkaXNjb3ZlcnkgY29udHJvbGxl
cikgYW5kIGEgbmV3IG9uZSBpcyBiZWluZyBtYWRlLsKgIFRoZSBuZXcgCm9uZSBjb3VsZCBiZSBv
biBjb21wbGV0ZWx5IGRpZmZlcmVudCB0cmFuc3BvcnQgb3IgZGlmZmVyZW50IApob3N0L3N1YnN5
c3RlbSBwb3J0czoKCkl0IGxvb2tzIGxpa2UgX19udm1lX2ZpbmRfZ2V0X3N1YnN5c3RlbSgpIHdo
ZW4gY2FsbGVkIHdpdGggdGhlIGRpc2NvdmVyeSAKbnFuIHdpbGwgbWF0Y2ggdGhlIHN1YnN5c3Rl
bSBmb3IgdGhlIGV4aXN0aW5nIGRpc2NvdmVyeSBjb250cm9sbGVyLCAKd2hpY2ggdGhlbiBmb3Jj
ZXMgdGhlIGNhbGwgdG8gbnZtZV92YWxpZGF0ZV9jbnRsaWQoKSwgd2hpY2ggd2lsbCBmaW5kIGEg
CmxpdmUgY29udHJvbGxlciBhbmQgaXQncyB2ZXJ5IHBvc3NpYmxlIHRoYXQgY29udHJvbGxlciBp
ZCBjYW4gYmUgCmRpZmZlcmVudC4gVGhlIHJlcXVpcmVtZW50IGZvciBzYW1lbmVzcyBkb2VzIG5v
dCBhcHBseSB0byB0aGUgZGlzY292ZXJ5IApjb250cm9sbGVyIC0gc28gaXQgc2hvdWxkbid0IGJl
IHJldHVybmluZyBmYWlsdXJlIGluIHRoaXMgY2FzZS7CoMKgIEFncmVlID8KCldoYXQncyB0aGUg
YmVzdCBwYXRjaCB0byBhdm9pZCB0aGlzID8KLSBjaGFuZ2UgX19udm1lX2ZpbmRfZ2V0X3N1YnN5
c3RlbSgpIHNvIHRoYXQgaWYgZGlzY292ZXJ5IG5xbiwgaXQgdHJlYXRzIAppdCBhcyBhIHNlcGFy
YXRlIHN1YnN5c3RlbSA/Ci0gY2hhbmdlIG52bWVfdmFsaWRhdGVfY250bGlkKCkgc3VjaCB0aGF0
ICIoY3RybC0+b3B0cyAmJiAKY3RybC0+b3B0cy0+ZGlzY292ZXJ5X25xbikiIGlzIGFkZGVkIHRv
IHRoZSBjdHJsIHN0YXRlIGNoZWNrcyBhYm92ZSB0aGlzIAp0ZXN0ID8KCi0tIGphbWVzCgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
