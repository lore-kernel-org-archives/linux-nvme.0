Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98AFC3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 21:07:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797E723439
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 21:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Co6+PjMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797E723439
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=++HU1IBNPI+C40RqxdEC3MGyrMl1CCR/IUz+OkEEa1o=; b=Co6+PjMSJ4lNPPGN2926uMxs5
	hM9FQ1ntyoaZMTscqGgt16icyXjl87axY+3lRK5Ydg4Zyhrc5MiXTmdbgLW8rJMCG1tiVqieM9KvX
	aSlJwOmguEi6PfiIykX0Z1nCyJMtJsQF0wAtgijx0cKdwRucNtCir5XWbgWQ+AOHkofSnWFYsggrF
	EsjjdP1ja1dcu5tJQ/fccXGopUGx6nxTHAPfXxfa/juVOMCGngYuDM1Yj3tnVisulLnmgeCsUi0cy
	xwBgMT1BzQjch9bkcRo9Wred29f2dIH6Of3K0BRncZ/C1gwWYa3yDDoByxmzvmBT9kwieqfUxfs6E
	Jh2Jtfn+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3o7M-00050S-0V; Fri, 30 Aug 2019 21:07:36 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3o6x-0004fS-Jr
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 21:07:14 +0000
Received: by mail-wr1-f65.google.com with SMTP id s18so8295215wrn.1
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 14:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w4hvEqHJLEa1mvGULDNj9eO45SqJ3qnxmWk/VetQNSk=;
 b=t1pgzIWNQXz3VHgwydLPWYcPauNsVEFgTva0aOV1Y4QUOi4AqHuAdAR9TPyxr0uUXm
 vNmCOZENbAFFn3dgCujhkZccJGrq96L6+To1p6CB1Nh2Eck0Vaect+T0XWAA1t/33EG0
 yBG9mvVlALaniigJluopU7zJWJAlcXKDRxnX5PYEV5j1UGo9CtaR8CiDWYBmScrEiTpY
 pBuD8vm47OLFDv/VqZCY6S9cMgrKK3nJCYxmFpJX3e3W+WEU8UG9pX47wqUVfOH7UMD3
 /BFiWvoC9IZZ2wCOS4A+ML4vZqBsmVCsyWZm/SEUw/mMIciTmb/KKylRI9IHx6qYWB8C
 t3dg==
X-Gm-Message-State: APjAAAUzP1xpgtKTMI6DiIRwKRXrdAdniyXHqP/TykPRNkTl1rKMMPHg
 Aq6uFD24WwIS++zKe+TK94I=
X-Google-Smtp-Source: APXvYqxGL0ccEg29MqqNIg64URvCvazEH9a2xSZY2QlxYdBD+ARFTN8+N38kSUXxGRclw/YqOh6g/w==
X-Received: by 2002:adf:dc43:: with SMTP id m3mr5271653wrj.118.1567199229860; 
 Fri, 30 Aug 2019 14:07:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id w13sm16030538wre.44.2019.08.30.14.07.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 14:07:09 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830055514.GC8492@lst.de>
 <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
 <3c58613f-9380-6887-434a-0db31136e7aa@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c50cbc24-328f-35b7-5c74-c66a9bd76128@grimberg.me>
Date: Fri, 30 Aug 2019 14:07:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3c58613f-9380-6887-434a-0db31136e7aa@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_140713_005806_6DD877C1 
X-CRM114-Status: GOOD (  17.08  )
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
Cc: Keith Busch <keith.busch@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4+IFllcyB3ZSBkbywgdXNlcnNwYWNlIHNob3VsZCB1c2UgaXQgdG8gb3JkZXIgZXZlbnRz
LsKgIERvZXMgdWRldiBub3QKPj4+Pj4gaGFuZGxlIHRoYXQgcHJvcGVybHkgdG9kYXk/Cj4+Pj4K
Pj4+PiBUaGUgcHJvYmxlbSBpcyBub3Qgb3JkZXJpbmcgb2YgZXZlbnRzLCBpdHMgcmVhbGx5IGFi
b3V0IHRoZSBmYWN0IHRoYXQKPj4+PiB0aGUgY2hhcmRldiBjYW4gYmUgcmVtb3ZlZCBhbmQgcmVh
bGxvY2F0ZWQgZm9yIGEgZGlmZmVyZW50IGNvbnRyb2xsZXIKPj4+PiAoY291bGQgYmUgYSBjb21w
bGV0ZWx5IGRpZmZlcmVudCBkaXNjb3ZlcnkgY29udHJvbGxlcikgYnkgdGhlIHRpbWUKPj4+PiB0
aGF0IHVzZXJzcGFjZSBoYW5kbGVzIHRoZSBldmVudC4KPj4+Cj4+PiBUaGUgc2FtZSBpcyBnZW5l
cmFsbHkgdHJ1ZSBmb3IgbG90IG9mIGtlcm5lbCBkZXZpY2VzLsKgIFdlIGNvdWxkIHJlZHVjZQo+
Pj4gdGhlIGNoYW5jZSBieSB1c2luZyB0aGUgaWRyIGN5Y2xpYyBhbGxvY2F0b3IuCj4+Cj4+IFdl
bGwsIGl0IHdhcyByYWlzZWQgYnkgSGFubmVzIGFuZCBKYW1lcywgc28gSSdsbCBhc2sgdGhlbSBy
ZXNwb25kIGhlcmUKPj4gYmVjYXVzZSBJIGRvbid0IG1pbmQgaGF2aW5nIGl0IHRoaXMgd2F5LiBJ
IHBlcnNvbmFsbHkgdGhpbmsgdGhhdCB0aGlzCj4+IGlzIGEgYmV0dGVyIGFwcHJvYWNoIHRoYW4g
aGF2aW5nIGEgY3ljbGljIGlkciBhbGxvY2F0b3IuIEluIGdlbmVyYWwsIEkKPj4gZG9uJ3QgbmVj
ZXNzYXJpbHkgdGhpbmsgdGhhdCB0aGlzIGlzIGEgZ29vZCBpZGVhIHRvIGhhdmUgY3ljbGljCj4+
IGNvbnRyb2xsZXIgZW51bWVyYXRpb25zIGlmIHdlIGRvbid0IGFic29sdXRlbHkgaGF2ZSB0by4u
Lgo+IAo+IFdlIGhpdCBpdCByaWdodCBhbmQgbGVmdCB3aXRob3V0IHRoZSBjeWNsaWMgYWxsb2Nh
dG9yLCBidXQgdGhhdCB3b24ndCAKPiBuZWNlc3NhcmlseSByZW1vdmUgaXQuCj4gCj4gUGVyaGFw
cyB3ZSBzaG91bGQgaGF2ZSBoYWQgYSB1bmlxdWUgdG9rZW4gYXNzaWduZWQgdG8gdGhlIGNvbnRy
b2xsZXIsIAo+IGFuZCBoYXZlIHRoZSBldmVudCBwYXNzIHRoZSBuYW1lIGFuZCB0aGUgdG9rZW4u
wqAgVGhlIGNsaSB3b3VsZCB0aGVuLCBpZiAKPiB0aGUgdG9rZW4gaXMgcHJlc2VudCwgdmFsaWRh
dGUgaXQgdmlhIGFuIGlvY3RsIGJlZm9yZSBwcm9jZWVkaW5nIHdpdGggCj4gb3RoZXIgaW9jdGxz
Lgo+IAo+IFdoZXJlIGFsbCB0aGUgY29ubmVjdGlvbiBhcmd1bWVudHMgd2VyZSBhZGRlZCB3ZSBk
dWUgdG8gdGhlIHJldXNlIGlzc3VlIAo+IGFuZCB0aGVuIHNvbHZpbmcgdGhlIHF1ZXN0aW9uIG9m
IGhvdyB0byB2ZXJpZnkgYW5kL29yIGxvb2t1cCB0aGUgZGVzaXJlZCAKPiBjb250cm9sbGVyLCBi
eSB1c2luZyB0aGUgc2hvdGd1biBhcHByb2FjaCByYXRoZXIgdGhhbiBiZWluZyB2ZXJ5IAo+IHBv
aW50ZWQsIHdoaWNoIGlzIHdoYXQgdGhlIG5hbWUvdG9rZW4gd291bGQgZG8uCgpUaGlzIHVuaXF1
ZSB0b2tlbiBpczogdHJ0eXBlOnRyYWRkcjp0cnN2Y2lkOmhvc3QtdHJhZGRyIC4uLgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
