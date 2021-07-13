Return-Path: <SRS0=tkdf=MF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B6CC07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 09:38:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E6261158
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 09:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E6261158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dCW/WuYGh5FcQHS/SHb4///W+TNyNk3Kl0c1G5PkNaU=; b=s9tyWHVlbxvjWCHcQUrevYMHHV
	zGPHYrKMDa58us9fBKybnTSQUI/pbnB+5UBiemItNhAZddsUzAFLpOMMbH/G/TVYjXb32kellvvPI
	r0uhRBNpgjz2zW5fZimp0mrjjFPPcZi8IDAJjCi9f5yUf4oRQZCXZUFAOLupScJY2e5AtMq59RrOn
	8LIAX/Agl2mesQjZ1iijHUWnde2tj0FJoJJ6C9+IYG6cVoQ+GuHsWvgywXEHMgqpZ7/5a/ZZ2X8rl
	XFca2KoniSpuZpe/X2pNkosGS2NpE4pVWTTqdvf+6E8l2Wutl5xq8azjFQL/oTKHWiuPTwXGX3Akg
	Vg0w5Mdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m3Erd-009fTf-Lx; Tue, 13 Jul 2021 09:38:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3Era-009fS7-B5
 for linux-nvme@lists.infradead.org; Tue, 13 Jul 2021 09:38:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3845B22269;
 Tue, 13 Jul 2021 09:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626169079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mr1NFumfAwX2BOhckDH4HtIii/d99ixdFVfhDsHo3XM=;
 b=Z6mcLXMsEbl7+rc/pXeVZzoGvfIjFwxauts/+cEHUrFRHwScxdcC6h2zJKd6e97sv7cteg
 BOoJMPLfvqKQhT8HkyDcjZ1VYhqxmoU9WCW6ezAFFPkQF/VIwG1uLL65UfwERWFIu7hNAt
 f0wJlo5Hp4pxmf5Um3fMKavloeCb+uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626169079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mr1NFumfAwX2BOhckDH4HtIii/d99ixdFVfhDsHo3XM=;
 b=f63MHYwnARay8bIbRNjKdGizWkc2qs4qbQiaiz8Y+rnR2mS3DZc/NMfI444rSfdyJ+IlC2
 BvrcUqbSTKOjNHBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CE4113AE2;
 Tue, 13 Jul 2021 09:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c+OkCvde7WCUVwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 13 Jul 2021 09:37:59 +0000
Subject: Re: [PATCHv8] nvme: fix refcounting imbalance when all paths are down
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210624085546.123824-1-hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3dd443f8-dfe2-1931-b79e-0fe699b7c157@suse.de>
Date: Tue, 13 Jul 2021 11:37:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624085546.123824-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210713_023802_571709_089E7FE4 
X-CRM114-Status: GOOD (  18.77  )
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

T24gNi8yNC8yMSAxMDo1NSBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IFdoZW4gdGhlIGxh
c3QgcGF0aCB0byBhIG5zX2hlYWQgZHJvcHMgdGhlIGN1cnJlbnQgY29kZQo+IHJlbW92ZXMgdGhl
IG5zX2hlYWQgZnJvbSB0aGUgc3Vic3lzdGVtIGxpc3QsIGJ1dCB3aWxsIG9ubHkKPiBkZWxldGUg
dGhlIGRpc2sgaXRzZWxmIGlmIHRoZSBsYXN0IHJlZmVyZW5jZSB0byB0aGUgbnNfaGVhZAo+IGRy
b3BzLiBUaGlzIGlzIGNhdXNpbmcgYW4gcmVmY291bnRpbmcgaW1iYWxhbmNlIGVnIHdoZW4KPiBh
cHBsaWNhdGlvbnMgaGF2ZSBhIHJlZmVyZW5jZSB0byB0aGUgZGlzaywgYXMgdGhlbiB0aGV5J2xs
Cj4gbmV2ZXIgZ2V0IG5vdGlmaWVkIHRoYXQgdGhlIGRpc2sgaXMgaW4gZmFjdCBkZWFkLgo+IFRo
aXMgcGF0Y2ggbW92ZXMgdGhlIGNhbGwgJ2RlbF9nZW5kaXNrJyBpbnRvIG52bWVfbXBhdGhfY2hl
Y2tfbGFzdF9wYXRoKCksCj4gZW5zdXJpbmcgdGhhdCB0aGUgZGlzayBjYW4gYmUgcHJvcGVybHkg
cmVtb3ZlZCBhbmQgYXBwbGljYXRpb25zIGdldCB0aGUKPiBhcHByb3ByaWF0ZSBub3RpZmljYXRp
b25zLgo+IAo+IENoYW5nZXMgdG8gdjc6Cj4gLSBNb3ZlIHRoZSBsaXN0X2RlbCgpIGNhbGwgb3V0
c2lkZSBvZiBudm1lX21wYXRoX2NoZWNrX2xhc3RfcGF0aCgpCj4gQ2hhbmdlcyB0byB2NjoKPiAt
IE1vdmUgdGhlIGxpc3RfZGVsKCkgaW50byBudm1lX21wYXRoX2NoZWNrX2xhc3RfcGF0aCgpCj4g
LSBEcm9wIHRoZSB0ZXN0cyBmb3IgR0VOSERfRkxfVVAKPiBDaGFuZ2VzIHRvIHY1Ogo+IC0gU3lu
Y2hyb25pemUgYmV0d2VlbiBudm1lX2luaXRfbnNfaGVhZCgpIGFuZCBudm1lX21wYXRoX2NoZWNr
X2xhc3RfcGF0aCgpCj4gLSBDaGVjayBmb3IgcmVtb3ZlZCBnZW5kaXNrIGluIG52bWVfbnNfaGVh
ZF9zdWJtaXRfYmlvKCkKPiBDaGFuZ2VzIHRvIHY0Ogo+IC0gQ2FsbCBkZWxfZ2VuZGlzaygpIGlu
IG52bWVfbXBhdGhfY2hlY2tfbGFzdF9wYXRoKCkgdG8gYXZvaWQgZGVhZGxvY2sKPiBDaGFuZ2Vz
IHRvIHYzOgo+IC0gU2ltcGxpZnkgaWYoKSBjbGF1c2UgdG8gZGV0ZWN0IGR1cGxpY2F0ZSBuYW1l
c3BhY2VzCj4gQ2hhbmdlcyB0byB2MjoKPiAtIERyb3AgbWVtY3B5KCkgc3RhdGVtZW50Cj4gQ2hh
bmdlcyB0byB2MToKPiAtIEFsd2F5cyBjaGVjayBOU0lEcyBhZnRlciByZWF0dGFjaAo+IAo+IFNp
Z25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+IC0tLQo+ICBkcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMgICAgICB8IDE0ICsrKysrKysrKysrLS0tCj4gIGRyaXZlcnMv
bnZtZS9ob3N0L211bHRpcGF0aC5jIHwgMTEgKysrKysrKysrLS0KPiAgZHJpdmVycy9udm1lL2hv
c3QvbnZtZS5oICAgICAgfCAxMSArKy0tLS0tLS0tLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDIyIGlu
c2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+IApQaW5nPwpBbnkgaXNzdWVzIGxlZnQgdG8g
YmUgcmVzb2x2ZWQ/CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAg
ICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1h
bnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8
cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
