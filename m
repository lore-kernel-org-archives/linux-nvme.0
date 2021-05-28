Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF8DC47087
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 12:58:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05B06139A
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 12:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05B06139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wacptEmNIMHc+43WP0Dt9xR0BMpF5ZaeUrFLrhopArU=; b=UJzNZKJnjxAvzssqNaL0MUX9gb
	Gaa/Z2yyYnlsn1+akrJljiRyOsY6S7A4a30Q+acumRIuVeqLKaDMXuCUqksYMtxiFTcf337yhaLNN
	8KKNc+zyzS6SU/L1qoAMUoyoCmziyMqADit0xxbFjvp9hGALQSASnsYd4/Xn7894SwK7YtXDsEsDy
	3hzvBGE4dBB6/ZJAMpr8E1USdYcRZBHZR4bLOXP69LYl8lkhIEmPAiCre1NnkmpEBmSiSVZ5UjXUs
	rVuF3UsVIw5FrQab1CR3RFmMf+G6ohD/mL95ACFuQLM8Pl+ERpi6HIikRx/3JYVH0YgSuuJQiWAmx
	uUh8BH+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmc4H-00FZpp-HO; Fri, 28 May 2021 12:58:25 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmbnc-00FScc-2S
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 12:41:13 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA5F01FD2F;
 Fri, 28 May 2021 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622205666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCYs3KLtcTkBqDc35j13v5squ/iaUh751rzFGwJLIzk=;
 b=hbde3yeRGJNz3JjH6yOWWEjq8q+CbgMlQHzPxkB/Oo1huZ9B7iJSU/GbkdSH4l+pfGlbDz
 uEqmmlKeCyT9vvKtmq2fNw/D6AOhFzoOGhWGTTeW55ITP+LX7MDDJV2/jPQQJTMlWujbcS
 +huX6aRJW6lneI7v0sfX/ayrhPA0td8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622205666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCYs3KLtcTkBqDc35j13v5squ/iaUh751rzFGwJLIzk=;
 b=i6REQ+u8iSVdfEsu/7dNwggEob/wnZor8YRXU9s0gONH9FJ4DS2sa2EP4HfyYbmD6OLfg6
 vVgOXhG6nF7i+oBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 680D111A98;
 Fri, 28 May 2021 12:41:06 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id MPA4GOLksGBXLwAALh3uQQ
 (envelope-from <hare@suse.de>); Fri, 28 May 2021 12:41:06 +0000
Subject: Re: [RFC PATCH v6 11/27] qed: Add NVMeTCP Offload Connection Level FW
 and HW HSI
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-12-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <8748f0e7-f2aa-f8bb-3756-5cbea9d5c7d5@suse.de>
Date: Fri, 28 May 2021 14:41:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-12-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_054112_308367_2B4F5B74 
X-CRM114-Status: GOOD (  14.94  )
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

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyB0aGUgTlZNZVRDUCBIU0kgYW5kIEhTSSBmdW5jdGlvbmFsaXR5IGluIG9yZGVyIHRvCj4g
aW5pdGlhbGl6ZSBhbmQgaW50ZXJhY3Qgd2l0aCB0aGUgSFcgZGV2aWNlIGFzIHBhcnQgb2YgdGhl
IGNvbm5lY3Rpb24gbGV2ZWwKPiBIU0kuCj4gCj4gVGhpcyBpbmNsdWRlczoKPiAtIENvbm5lY3Rp
b24gb2ZmbG9hZDogb2ZmbG9hZCBhIFRDUCBjb25uZWN0aW9uIHRvIHRoZSBGVy4KPiAtIENvbm5l
Y3Rpb24gdXBkYXRlOiB1cGRhdGUgdGhlIElDUmVxLUlDUmVzcCBwYXJhbXMKPiAtIENvbm5lY3Rp
b24gY2xlYXIgU1E6IG91dHN0YW5kaW5nIElPcyBGVyBmbHVzaC4KPiAtIENvbm5lY3Rpb24gdGVy
bWluYXRpb246IHRlcm1pbmF0ZSB0aGUgVENQIGNvbm5lY3Rpb24gYW5kIGZsdXNoIHRoZSBGVy4K
PiAKPiBBY2tlZC1ieTogSWdvciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IFByYWJoYWthciBLdXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+
IFNpZ25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1v
ZmYtYnk6IE1pY2hhbCBLYWxkZXJvbiA8bWthbGRlcm9uQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1v
ZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMv
bmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX252bWV0Y3AuYyB8IDU4MiArKysrKysrKysrKysr
KysrKy0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9xZWRfbnZtZXRjcC5oIHwg
IDYzICsrCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX3NwLmggICAgICB8
ICAgMyArCj4gIGluY2x1ZGUvbGludXgvcWVkL252bWV0Y3BfY29tbW9uLmggICAgICAgICAgICB8
IDE0MyArKysrKwo+ICBpbmNsdWRlL2xpbnV4L3FlZC9xZWRfbnZtZXRjcF9pZi5oICAgICAgICAg
ICAgfCAgOTQgKysrCj4gIDUgZmlsZXMgY2hhbmdlZCwgODgzIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBT
dG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0
MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJu
YmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
