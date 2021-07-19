Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0BAC636C9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 08:53:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3A76120E
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 08:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3A76120E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9gDMUeyeoY4EQ+DMwpiHhNy/afTwnvonA+xtXnO/ntM=; b=zeZ5S1vYZ/e6JM
	GzqWSXmamsbvAQtp1VbUM1bm3by4Iwv5g5o5s9uyi4GGYJxaJJuPnfZwK1vH9vgfeLFlxeljWk3D6
	9+Jy8RfVZq6yLMl61pbC82nSi0PGPEIEgASRobYG8wclxjEegG/1MN5YnHD6wjlVB55Q9LEEUHxIV
	p8AtuBIhTtBULI2ASdGxOQXMOiYlFW97HAwAZS4nH9kgAfYxmOe0di+PLzsKqUdCn0mxyXwDnAAFi
	7nTbH0d/ReIREQKAyc3+q9LjRZW6wnJXnGgIfgl7AoqXunDcY4QSm/vzjYz9PWAvXHNBtP/nCS9bB
	TmZ6t4cAP0OkMgg9hUNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5P0n-008x2T-KP; Mon, 19 Jul 2021 08:52:29 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5P0j-008x1v-Vv
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 08:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626684715;
 s=strato-dkim-0002; d=chronox.de;
 h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=dWok9o8gQ6+5Ip4xo7b/xcJ8eJ4EHeLf0PW7SYuRJ2s=;
 b=Q+nuYqZBAwl1KFY4p3jYxN7prLCv4zwXwpXwyrrrs4Rh7GK8DeeMXk5lNboUnwHyPZ
 RQX75tPCTbRhoYcGsZf0Vacg7W2CnhXza9i9OSf5hbZdQNibHMh8Ua2GN4JtqM3+4Tuy
 jtHWfR2qjv14pkcPHU7IwpxJhMSzlmzSJXPz4iOlLgnDI7w8TA9KOTStJrRGjAsZCx52
 dLwUsW8KtGATK4xcKxetS6xPks13xEIzDqaSC9L+mkAVB1hjoq6QjYlSyOdftRy7zs0p
 7uSrHc/BG35Za1uAen39capZixR+LYa9rohTT4OoIG2JhTDaGEkp+EG01rPThRqtMuZe
 QJ1A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNzyCzy1Sfr67uExK884EC0GFGHavJSlBkMRYMkE="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
 with ESMTPSA id 9043bbx6J8prGyn
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 19 Jul 2021 10:51:53 +0200 (CEST)
Message-ID: <463a191b9896dd708015645cfc125988cd5deaef.camel@chronox.de>
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
From: Stephan Mueller <smueller@chronox.de>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>, 
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Date: Mon, 19 Jul 2021 10:51:53 +0200
In-Reply-To: <59695981-9edc-6b7a-480a-94cca95a0b8c@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
 <2510347.locV8n3378@positron.chronox.de>
 <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
 <6538288.aohFRl0Q45@positron.chronox.de>
 <59695981-9edc-6b7a-480a-94cca95a0b8c@suse.de>
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_015226_253052_18ADDEBD 
X-CRM114-Status: GOOD (  28.28  )
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

QW0gTW9udGFnLCBkZW0gMTkuMDcuMjAyMSB1bSAxMDoxNSArMDIwMCBzY2hyaWViIEhhbm5lcyBS
ZWluZWNrZToKPiBPbiA3LzE4LzIxIDI6NTYgUE0sIFN0ZXBoYW4gTcO8bGxlciB3cm90ZToKPiA+
IEFtIFNvbm50YWcsIDE4LiBKdWxpIDIwMjEsIDE0OjM3OjM0IENFU1Qgc2NocmllYiBIYW5uZXMg
UmVpbmVja2U6Cgo+ID4gPiBUaGUga2V5IGlzIGFsc28gdXNlZCB3aGVuIHVzaW5nIHRoZSBmZmRo
ZSBhbGdvcml0aG0uCj4gPiA+IE5vdGU6IEkgX3RoaW5rXyB0aGF0IEkgbmVlZCB0byB1c2UgdGhp
cyBrZXkgZm9yIHRoZSBmZmRoZSBhbGdvcml0aG0sCj4gPiA+IGJlY2F1c2UgdGhlIGltcGxlbWVu
dGF0aW9uIEkgY2FtZSB1cCB3aXRoIGlzIGVzc2VudGlhbGx5IHBsYWluIERIIHdpdGgKPiA+ID4g
cHJlLWRlZmluZWQgJ3AnLCAncScgYW5kICdnJyB2YWx1ZXMuIEJ1dCB0aGUgREggaW1wbGVtZW50
YXRpb24gYWxzbwo+ID4gPiByZXF1aXJlcyBhICdrZXknLCBhbmQgZm9yIHRoYXQgSSdtIHVzaW5n
IHRoaXMga2V5IGhlcmUuCj4gPiA+IAo+ID4gPiBJdCBtaWdodCBiZSB0aGF0IEknbSBjb21wbGV0
ZWx5IG9mZiwgYW5kIGRvbid0IG5lZWQgdG8gdXNlIGEga2V5IGZvciBvdXIKPiA+ID4gREggaW1w
bGVtZW50YXRpb24uIEluIHRoYXQgY2FzZSB5b3UgYXJlIGNvcnJlY3QuCj4gPiA+IChBbmQgdGhh
dCdzIHdoeSBJIHNhaWQgSSdsbCBuZWVkIGEgcmV2aWV3IG9mIHRoZSBGRkRIRSBpbXBsZW1lbnRh
dGlvbikuCj4gPiA+IEJ1dCBmb3Igbm93IEknbGwgbmVlZCB0aGUga2V5IGZvciBGRkRIRS4KPiA+
IAo+ID4gRG8gSSB1bmRlcnN0YW5kIHlvdSBjb3JyZWN0bHkgdGhhdCB0aGUgZGhjaGFwX2tleSBp
cyB1c2VkIGFzIHRoZSBpbnB1dCB0bwo+ID4gdGhlIAo+ID4gREggLSBpLmUuIGl0IGlzIHRoZSBy
ZW1vdGUgcHVibGljIGtleSB0aGVuPyBJdCBsb29rcyBzdHJhbmdlIHRoYXQgdGhpcyBpcwo+ID4g
dXNlZCAKPiA+IGZvciBESCBidXQgdGhlbiBpdCBpcyBjaGFuZ2VkIGhlcmUgYnkgaGFzaGluZyBp
dCB0b2dldGhlciB3aXRoIHNvbWV0aGluZwo+ID4gZWxzZSAKPiA+IHRvIGZvcm0gYSBuZXcgZGhj
aGFwX2tleS4gTWF5YmUgdGhhdCBpcyB3aGF0IHRoZSBwcm90b2NvbCBzYXlzLiBCdXQgaXQKPiA+
IHNvdW5kcyAKPiA+IHN0cmFuZ2UgdG8gbWUsIGVzcGVjaWFsbHkgd2hlbiB5b3UgdGhpbmsgdGhh
dCBkaGNoYXBfa2V5IHdvdWxkIGJlLCBzYXksCj4gPiAyMDQ4IAo+ID4gYml0cyBpZiBpdCBpcyB0
cnVseSB0aGUgcmVtb3RlIHB1YmxpYyBrZXkgYW5kIHRoZW4gYWZ0ZXIgdGhlIGhhc2hpbmcgaXQg
aXMKPiA+IDI1NiAKPiA+IHRoaXMgZGhjaGFwX2tleSBjYW5ub3QgYmUgdXNlZCBmb3IgRkZDLURI
Lgo+ID4gCj4gPiBPciBhcmUgeW91IHVzaW5nIHRoZSBkaGNoYXBfa2V5IGZvciB0d28gZGlmZmVy
ZW50IHB1cnBvc2VzPwo+ID4gCj4gPiBJdCBzZWVtcyBJIG1pc3Mgc29tZXRoaW5nIGhlcmUuCj4g
PiAKPiBObywgbm90IGVudGlyZWx5LiBJdCdzIG1lIHdobyBidWdnZXJlZCBpdCB1cC4KPiBJIGdv
dCBjYXJyaWVkIGF3YXkgYnkgdGhlIGZhY3QgdGhhdCB0aGVyZSBpcyBhIGNyeXB0b19kaF9lbmNv
ZGVfa2V5KCkKPiBmdW5jdGlvbiwgYW5kIHRob3VnaHQgSSBuZWVkIHRvIHVzZSBpdCBoZXJlLgoK
VGhhbmsgeW91IGZvciBjbGFyaWZ5aW5nIHRoYXQuIEl0IHNvdW5kcyB0byBtZSB0aGF0IHRoZXJl
IGlzIG5vIGRlZmluZWQKcHJvdG9jb2wgKG9yIGlmIHRoZXJlLCBJIHdvdWxkIGJlIHdvbmRlcmlu
ZyBob3cgdGhlIGNvZGUgd291bGQgaGF2ZSB3b3JrZWQKd2l0aCBhIGRpZmZlcmVudCBpbXBsZW1l
bnRhdGlvbikuIFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gZmlyc3Qgc3BlY2lmeSBhCnByb3RvY29s
IGZvciBhdXRoZW50aWNhdGlvbiBhbmQgaGF2ZSBpdCBkaXNjdXNzZWQ/IEkgcGVyc29uYWxseSB0
aGluayBpdCBpcyBhCmJpdCBkaWZmaWN1bHQgdG8gZnVsbHkgdW5kZXJzdGFuZCB0aGUgcHJvdG9j
b2wgZnJvbSB0aGUgY29kZSBhbmQgZGlzY3Vzcwpwcm90b2NvbC1sZXZlbCBpdGVtcyBiYXNlZCBv
biB0aGUgY29kZS4KClRoYW5rcwpTdGVwaGFuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
