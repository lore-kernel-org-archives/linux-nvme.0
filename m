Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C05C47087
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 12:01:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7B161157
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 12:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7B161157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HwxqFLrmdtSSEKEH3X4JYDRWxgXShmUEMLCohB+u8HQ=; b=Jmy2oytzmu6Z/Jk/0ZLEsL/rWB
	Ont+mZ8Vo63YJalIuQd+5jPjygCZoTSGZeDRBmKsGvDhqYsoW+z9RlODqFeTH16AbdWdjk4AALrbR
	XTGW0/W7HnBTo1fkhIP2g2rO7AACSS+NX6o83jW5ele8C0gshJKJyn+BU542+m7aKt+usHbmWVb/J
	sUDp5WsvBZxskyM2q0iYzbOONivVbt7kApvTaMIHSrkhgd+omnbYNBeE1RuOIQpYSzPTDkbduRKd+
	GVsqpqNhtguTtn59xGeMsGkauDeociPMTP7jGYKSbretgqVNs7rhRJrI/7MfZk821eW7BMbQ79kX6
	/bTKjUrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmbAs-00FAIF-5G; Fri, 28 May 2021 12:01:10 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmahm-00EsEb-3d
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 11:31:07 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFDA51FD2F;
 Fri, 28 May 2021 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622201464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJxw7UVf69eXF5UvmrTiRioEhsiAIBBjkR3QOPBQWqA=;
 b=Kw8Tio8ovbOgf6ivMADd7BKZC/Oew6uQNeDoHqg7JS99zRxabEBCE1FIddCCVZhDCDk0QU
 SDz50C4blhi2Ijza+iTcCo9vW/Y5jstAYu23Dw/O2Jlh3gPsQgko2dVVxPDI5iuIP9Ticw
 LpAcHkW2t3rA1g6YwcxwLW36qVhMKPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622201464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJxw7UVf69eXF5UvmrTiRioEhsiAIBBjkR3QOPBQWqA=;
 b=7HcCEusNIaAt8A+nIKqI3BMx9427wzbUaWQwGZIQImxOafcOIgeS6HwN3HZyg+h2RBQ8he
 HML+CmNk4TmJq5Cw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id 9378D11906;
 Fri, 28 May 2021 11:31:04 +0000 (UTC)
Subject: Re: [RFC PATCH v6 09/27] qed: Add TCP_ULP FW resource layout
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-10-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <4df85c04-16d6-478a-f55d-16042952bbc1@suse.de>
Date: Fri, 28 May 2021 13:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-10-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_043106_354162_DCC33538 
X-CRM114-Status: GOOD (  12.92  )
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

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IE9ta2FyIEt1bGth
cm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gCj4gQWRkIFRDUF9VTFAgYXMgYSBzdG9yYWdl
IGNvbW1vbiBUQ1Agb2ZmbGxvYWQgRlcgcmVzb3VyY2UgbGF5b3V0Lgo+IFRoaXMgd2lsbCBiZSB1
c2VkIGJ5IHRoZSBjb3JlIGRyaXZlciAoUUVEKSBmb3IgYm90aCB0aGUgTlZNZVRDUCBhbmQgaVND
U0kuCj4gCj4gQWNrZWQtYnk6IElnb3IgUnVzc2tpa2ggPGlydXNza2lraEBtYXJ2ZWxsLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBrdXNod2FoYUBtYXJ2ZWxsLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBPbWthciBLdWxrYXJuaSA8b2t1bGthcm5pQG1hcnZlbGwuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBLYWxkZXJvbiA8bWthbGRlcm9uQG1hcnZlbGwuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZlbGwuY29tPgo+IC0tLQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvcWVkL3FlZC5oICAgICAgICAgfCAgMSArCj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX2N4dC5jICAgICB8IDE4ICsrKysrKysrLS0t
LS0tLS0tCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX2N4dC5oICAgICB8
ICAyICstCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX2Rldi5jICAgICB8
ICAyICstCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX2hzaS5oICAgICB8
ICAyICstCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX2lzY3NpLmMgICB8
IDIwICsrKysrKysrKy0tLS0tLS0tLS0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3Fl
ZC9xZWRfbGwyLmMgICAgIHwgIDggKysrKy0tLS0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxv
Z2ljL3FlZC9xZWRfb29vLmMgICAgIHwgIDIgKy0KPiAgLi4uL25ldC9ldGhlcm5ldC9xbG9naWMv
cWVkL3FlZF9zcF9jb21tYW5kcy5jIHwgIDIgKy0KPiAgaW5jbHVkZS9saW51eC9xZWQvY29tbW9u
X2hzaS5oICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgaW5jbHVkZS9saW51eC9xZWQvcWVkX2xs
Ml9pZi5oICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgMTEgZmlsZXMgY2hhbmdlZCwgMzEgaW5z
ZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNr
ZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
CQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAg
ICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55
IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBIUkIgMzY4MDkgKEFH
IE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
