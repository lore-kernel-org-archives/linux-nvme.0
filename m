Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98AEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 06:02:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885CD61357
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 06:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 885CD61357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v/4Q8XQhxupw6PmcLY/yKlGcnYzmHq0K1v2dxWuRG+E=; b=qDOabxlfusdmM8/o3Zb/jvEgI5
	zDL8LA+kuQpyD3Th0LwqGUHlZYGI028kWYdzYAystMPPxf4V8nWJu36Be67R4LFxsWR69uPdUBpo3
	ZRqoJGsydLqEZVst79jh0UwdH+LghFWkGVRp5rMSJVQbaN6123POZosMUd6GidltO9O2U0qHtlMz0
	VKgqcnIknxMu1SqQvDkGTtfj1ScL62KtdFKH4L2UDeA3/qwg3jVSeMycQJ2Tg+oHfa8fXA9vtI0XI
	FXvOgZX+U8jBFVbPpThvDhvn3fvQS3Osmk+x50AWlBBrY3OX6seaLsRWTRuEPeK5UEgnZv2pNOSp8
	UiXyputA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVSfG-00A8Xs-Rf; Wed, 29 Sep 2021 06:01:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVSfD-00A8XT-RS
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 06:01:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 267BB224A3;
 Wed, 29 Sep 2021 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632895314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fy+HHEjyxsfX20aMqiX6dE5rsMWNj0vZpaMr+LvVoa8=;
 b=rnb424Nklh+SK1OKcMOTWctdW9N0AbJlApOuNR18hQE/Q13Idg0bIBF+BslHp2B90jucbg
 rUKAkbr7Xwp94tShtJZaN7Q3/6ZJNh1FVAU5zE1B1oHa/9QampJykkl7NVEBi3ZznW9P+j
 a3i0jOqz4AgjOcsqShQ1bx2CD7HN9eU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632895314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fy+HHEjyxsfX20aMqiX6dE5rsMWNj0vZpaMr+LvVoa8=;
 b=k2hcZkQbQBC46T/uBT1p9xwpE2pOAhkNFL7cO3rxgljZVLD7j6rjQq4f3rBMQKFCD0o2dd
 0FZ0oM74HErHCDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED82613A81;
 Wed, 29 Sep 2021 06:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4d9EOFEBVGHfRQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 29 Sep 2021 06:01:53 +0000
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-11-hare@suse.de>
 <79742bd7-a41c-0abc-e7de-8d222b146d02@grimberg.me>
 <c7739610-6d0b-7740-c339-b35ca5ae34e2@suse.de>
 <a2596777-25b2-f633-4b00-18b1a319c5c2@suse.de>
 <32d8f860-9fdb-606c-62b7-ad89837d8e71@grimberg.me>
 <2ccfb62a-d782-7bb2-4d41-6d1152851a4a@suse.de>
 <24d3ee65-83e7-c958-cd17-eb4351a8349c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0ee67498-9630-af05-2207-a39d7f836b3e@suse.de>
Date: Wed, 29 Sep 2021 08:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <24d3ee65-83e7-c958-cd17-eb4351a8349c@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_230156_067352_37D7BCEE 
X-CRM114-Status: GOOD (  19.60  )
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

T24gOS8yOS8yMSAxMjozNiBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+PiBBY3R1YWxs
eSwgaGF2aW5nIHJlLXJlYWQgdGhlIHNwZWMgSSdtIG5vdCBzdXJlIGlmIHRoZSBzZWNvbmQgcGF0
aCBpcwo+Pj4+IGNvcnJlY3QuCj4+Pj4gQXMgcGVyIHNwZWMgb25seSB0aGUgX2hvc3RfIGNhbiB0
cmlnZ2VyIHJlLWF1dGhlbnRpY2F0aW9uLiBUaGVyZSBpcyBubwo+Pj4+IHByb3Zpc2lvbiBmb3Ig
dGhlIGNvbnRyb2xsZXIgdG8gdHJpZ2dlciByZS1hdXRoZW50aWNhdGlvbiwgYW5kIGdpdmVuCj4+
Pj4gdGhhdCByZS1hdXRoIGlzIGEgc29mdC1zdGF0ZSBhbnl3YXkgKGllIHRoZSBjdXJyZW50IGF1
dGhlbnRpY2F0aW9uCj4+Pj4gc3RheXMgdmFsaWQgdW50aWwgcmUtYXV0aCBlbnRlcnMgYSBmaW5h
bCBzdGF0ZSkgSSBfdGhpbmtfIHdlIHNob3VsZCBiZQo+Pj4+IGdvb2Qgd2l0aCB0aGUgY3VycmVu
dCBpbXBsZW1lbnRhdGlvbiwgd2hlcmUgd2UgY2FuIGNoYW5nZSB0aGUKPj4+PiBjb250cm9sbGVy
IGtleXMKPj4+PiB2aWEgY29uZmlnZnMsIGJ1dCB0aGV5IHdpbGwgb25seSBiZWNvbWUgYWN0aXZl
IG9uY2UgdGhlIGhvc3QgdHJpZ2dlcnMKPj4+PiByZS1hdXRoZW50aWNhdGlvbi4KPj4+Cj4+PiBB
Z3JlZSwgc28gdGhlIHByb3Bvc2VkIGFkZGl0aW9uIGlzIGdvb2Qgd2l0aCB5b3U/Cj4+Pgo+PiBX
aHkgd291bGQgd2UgbmVlZCBpdD8KPj4gSSBkbyBhZ3JlZSB0aGVyZSdzIGEgYml0IG1pc3Npbmcg
Zm9yIHJlbW92aW5nIHRoZSBvbGQgc2hhc2hfdGZtIGlmIHRoZXJlCj4+IGlzIGEgaGFzaC1pZCBt
aXNtYXRjaCwgYnV0IHdoeSB3b3VsZCB3ZSBuZWVkIHRvIHJlc2V0IHRoZSBlbnRpcmUKPj4gYXV0
aGVudGljYXRpb24/Cj4gCj4gSnVzdCBuZWVkIHRvIHVwZGF0ZSB0aGUgbmV3IGhvc3QgZGhjaGFw
X2tleSBmcm9tIHRoZSBob3N0IGF0IHRoaXMgcG9pbnQKPiBhcyB0aGUgaG9zdCBpcyBkb2luZyBh
IHJlLWF1dGhlbnRpY2F0aW9uLiBJIGFncmVlIHdlIGRvbid0IG5lZWQgYSBiaWcKPiBoYW1tZXIg
YnV0IHdlIGRvIG5lZWQgdGhlIHJlLWF1dGhlbnRpY2F0aW9uIHRvIG5vdCBhY2Nlc3Mgb2xkIGhv
c3QKPiBkaGNoYXBfa2V5LgoKU3VyZS4gQW5kLCB1cG9uIHJldmlld2luZywgSSBndWVzcyB5b3Ug
YXJlIHJpZ2h0OyB3aWxsIGJlIGluY2x1ZGluZyB5b3VyIApzbmlwcGV0LgpGb3IgdGhlIG5leHQg
cm91bmQgOi0pCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
