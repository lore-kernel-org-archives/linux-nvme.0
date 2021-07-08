Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B4BC07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 10:12:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9A961451
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 10:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9A961451
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KSzK7k4nZbKHDX6/WYCvLEIv46Uh04QTsxFyw/ffUDc=; b=uvcHUwu6HPMWq767DCuxCG4LCf
	olFNYS3udrUMXHFgkq7CnOE8XZIN2jtm4Gngv1pQn6RYOWdTxBn/6AfqARh4iP1/NHhDk/OFZX33N
	pVqW01W7d2VTq0U+KGYV2mYVlMArI190UHtqbrqwn+UoT7PvDjGg/3Xo7AtJGyvsP+GD+Eq3Cdx2o
	uexbAzWBytFHtOIl7jJ7KxPQITsWVuzdd4N9WGvpguL3iLs4tx6Q+yblkoXO2aRPedKYDEc7OQRQn
	rR3n7RBAoAR/oEPeaDS3QiVVHCOsI0EAdxLFiGfeUTbgkSz3Y8UHhccBwNhJtQCm47TrV9GkNeDlz
	X8IIYRkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1R18-00GaLR-G1; Thu, 08 Jul 2021 10:12:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1R14-00GaJw-UH
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 10:12:24 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9777E22360;
 Thu,  8 Jul 2021 10:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625739141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKJzJF5tCumCbWebteEOvrLHiJPh+40M7IbuEO+NlOI=;
 b=rPqiYhvAwWq1ArT7bQvl0xOR4z6zEqWTso/BaP00HogF+U0nX2nEkeeeNhs8V/V4OcYwBD
 krtC6xVusFSAJ+BajKhGuTBAiLii6Mh3tmgSMa7+mAvTyD24dVF0uBK0xRFN/shF4mlBn1
 E1Ou6fCe0492ZQHw9NRHKMhtzq41XCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625739141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKJzJF5tCumCbWebteEOvrLHiJPh+40M7IbuEO+NlOI=;
 b=d0QIo+yfd6JyQac+aUWnWf7nmGC2KBlR/uJwryrPG+uA1x7YHl6x9PFKfDHZ89AvsobT9Z
 mbRkJ6trKNa1LADw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 747811338E;
 Thu,  8 Jul 2021 10:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id kIe2G4XP5mA5MwAAGKfGzw
 (envelope-from <hare@suse.de>); Thu, 08 Jul 2021 10:12:21 +0000
Subject: Re: [PATCH v2 4/5] nvme-fc: Wait with a timeout for queue to freeze
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart2021@gmail.com>
References: <20210708092755.15660-1-dwagner@suse.de>
 <20210708092755.15660-5-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <bf265380-6164-2462-ff30-6144e9f9b2ea@suse.de>
Date: Thu, 8 Jul 2021 12:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708092755.15660-5-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_031223_181131_9DD8623F 
X-CRM114-Status: GOOD (  22.40  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy84LzIxIDExOjI3IEFNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IERvIG5vdCB3YWl0IGlu
ZGlmaW5pdGx5IGZvciBhbGwgcXVldWVzIHRvIGZyZWV6ZS4gSW5zdGVhZCB1c2UgYQo+IHRpbWVv
dXQgYW5kIGFib3J0IHRoZSBvcGVyYXRpb24gaWYgd2UgZ2V0IHN0dWNrLgo+IAo+IFJldmlld2Vk
LWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTog
RGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hv
c3QvZmMuYyB8IDkgKysrKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4gaW5kZXggZDBlYjgxMzg3ZDRlLi44ZTFmYzM3OTY3
MzUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2ZjLmMKPiBAQCAtMjk1Niw3ICsyOTU2LDE0IEBAIG52bWVfZmNfcmVjcmVhdGVf
aW9fcXVldWVzKHN0cnVjdCBudm1lX2ZjX2N0cmwgKmN0cmwpCj4gICAJCWRldl9pbmZvKGN0cmwt
PmN0cmwuZGV2aWNlLAo+ICAgCQkJInJlY29ubmVjdDogcmV2aXNpbmcgaW8gcXVldWUgY291bnQg
ZnJvbSAlZCB0byAlZFxuIiwKPiAgIAkJCXByaW9yX2lvcV9jbnQsIG5yX2lvX3F1ZXVlcyk7Cj4g
LQkJbnZtZV93YWl0X2ZyZWV6ZSgmY3RybC0+Y3RybCk7Cj4gKwkJaWYgKCFudm1lX3dhaXRfZnJl
ZXplX3RpbWVvdXQoJmN0cmwtPmN0cmwsIE5WTUVfSU9fVElNRU9VVCkpIHsKPiArCQkJLyoKPiAr
CQkJICogSWYgd2UgdGltZWQgb3V0IHdhaXRpbmcgZm9yIGZyZWV6ZSB3ZSBhcmUgbGlrZWx5IHRv
Cj4gKwkJCSAqIGJlIHN0dWNrLiAgRmFpbCB0aGUgY29udHJvbGxlciBpbml0aWFsaXphdGlvbiBq
dXN0Cj4gKwkJCSAqIHRvIGJlIHNhZmUuCj4gKwkJCSAqLwo+ICsJCQlyZXR1cm4gLUVOT0RFVjsK
CkZvciBjb250cm9sbGVyIHJlc2V0IHdlJ3JlIHVzaW5nICctRU5PVENPTk4nOyBtYXliZSBpdCdz
IHdvcnRod2hpbGUgdG8gCnVzZSB0aGUgc2FtZSBlcnJvciBjb2RlIGhlcmUuCkJ1dCB0aGF0J3Mg
anVzdCBhIG1pbm9yIGRldGFpbC4KCj4gKwkJfQo+ICAgCQlibGtfbXFfdXBkYXRlX25yX2h3X3F1
ZXVlcygmY3RybC0+dGFnX3NldCwgbnJfaW9fcXVldWVzKTsKPiAgIAkJbnZtZV91bmZyZWV6ZSgm
Y3RybC0+Y3RybCk7Cj4gICAJfQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJl
QHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
