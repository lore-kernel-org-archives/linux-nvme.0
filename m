Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94910C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:44:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564F160555
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 564F160555
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HztVahh8Mx2yDhwjoFyP6nDKVvq2cF02x58SIQqzAyI=; b=WT7poVycF7OW2/8jMrZK2sQ2/a
	0TRcb9A6IV4DFl99Z/wrNtez9wxalyKlIx45lHr7iFRfktXTZvZhhCcDR6m1de+P5/WezT18r58yb
	YTZNZDOK8bb867SqvYBURjM82/u6ziiPxKyJKtQNYrXkIGzxwUOWkr77iDtr7bT+nr87iUZs0tXFa
	Ly7VnO8DndarTmJ+4XC7ld+2YPpTdb26ymU0QGa1f4wtvYqSo0ndHb99L5QY4i1v9nnO2KMQ6vd4M
	ss1+NWnUQV3W3WTRqI/yuuKo4fQWK9Sc63G+SPuAFHC4h/xyi/X4KeKRNHubqvTeVMkS4hx567HXg
	vIf+pvvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maI4h-00D3kr-K5; Tue, 12 Oct 2021 13:44:11 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maI3y-00D3LS-W4
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 13:43:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 303162217E;
 Tue, 12 Oct 2021 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634046203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pu7xGiSp93VxmAWVyFXGNogAQx9BOia/0caRAoeeR+A=;
 b=xdRF7D272M3Y1sflhE5+mHNx8RxbGf7SEUQ/pjb5zCPZPuuUwLPYfGOpvmy3b9jspFzLEB
 yj5yBz7T9K1r8tQp6C9gdBata3O4EZOiRoYDWUljC9Uap/Cn7S1ypv1Qaco9QlnqAC5Sue
 JkoNGNuvFwKIFJYhCw4VuQiI5B7QaW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634046203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pu7xGiSp93VxmAWVyFXGNogAQx9BOia/0caRAoeeR+A=;
 b=sL1GgzWlvnfq/anhF6+Fl+SEL0laTGiQEw3Y6gyYNuB+Np2jaVXP2MkoTH8oD9rKYiAWgN
 aVoNQEHJs9DTwtCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01EDC13BC9;
 Tue, 12 Oct 2021 13:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ByIKAPuQZWGHbwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 12 Oct 2021 13:43:22 +0000
Subject: Re: [PATCH 5/7] nvme: expose subsystem type in sysfs attribute
 'subtype'
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-6-hare@suse.de>
 <20210922080256.sxl437n22f2mcmsq@carbon.lan> <20211012131057.GB11640@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5ced9d70-12ce-8995-3b94-ed4dc3c8e06a@suse.de>
Date: Tue, 12 Oct 2021 15:43:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211012131057.GB11640@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_064327_241091_62377B6F 
X-CRM114-Status: GOOD (  14.93  )
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

T24gMTAvMTIvMjEgMzoxMCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gV2VkLCBT
ZXAgMjIsIDIwMjEgYXQgMTA6MDI6NTZBTSArMDIwMCwgRGFuaWVsIFdhZ25lciB3cm90ZToKPj4g
T24gV2VkLCBTZXAgMjIsIDIwMjEgYXQgMDg6MzU6MjNBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tl
IHdyb3RlOgo+Pj4gK3N0YXRpYyBTVUJTWVNfQVRUUl9STyhzdWJ0eXBlLCBTX0lSVUdPLCBudm1l
X3N1YnN5c19zaG93X3N1YnR5cGUpOwo+Pj4gKwo+Pj4gICNkZWZpbmUgbnZtZV9zdWJzeXNfc2hv
d19zdHJfZnVuY3Rpb24oZmllbGQpCQkJCVwKPj4+ICBzdGF0aWMgc3NpemVfdCBzdWJzeXNfIyNm
aWVsZCMjX3Nob3coc3RydWN0IGRldmljZSAqZGV2LAkJXAo+Pj4gIAkJCSAgICBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQlcCj4+PiBAQCAtMjYxOCw2ICsyNjM2LDcg
QEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKm52bWVfc3Vic3lzX2F0dHJzW10gPSB7Cj4+PiAg
CSZzdWJzeXNfYXR0cl9zZXJpYWwuYXR0ciwKPj4+ICAJJnN1YnN5c19hdHRyX2Zpcm13YXJlX3Jl
di5hdHRyLAo+Pj4gIAkmc3Vic3lzX2F0dHJfc3Vic3lzbnFuLmF0dHIsCj4+PiArCSZzdWJzeXNf
YXR0cl9zdWJ0eXBlLmF0dHIsCj4+Cj4+Cj4+IFNob3VsZG4ndCB0aGlzIGJlIHN1YnN5c3R5cGUg
dG8gc3RheSBjb25zaXN0ZW50IHdpdGggc3Vic3lzbnFuPwo+IAo+IEhhbm5lcz8gSSd2ZSBhcGxp
ZWQgdGhlIHBhdGNoIGZvciBub3csIGJ1dCB0aGUgYWJvdmUgc2VlbXMgbGlrZSBhIHVzZWZ1bAo+
IGZpeHVwIHRvIGZvbGQgaW4uCj4gCkkgZG9uJ3QgcmVhbGx5IGNhcmUuIFNob3VsZCBJIHNlbmQg
eW91IGEgcGF0Y2ggdG8gdXBkYXRlIGl0PwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2Uu
ZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
