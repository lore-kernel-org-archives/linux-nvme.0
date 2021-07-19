Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED09C636C9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:57:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718B26108B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718B26108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NP4ZGO/kyBUuBn6srLEdmx3F4C/jNndX+vkCCQOTXEY=; b=kqv/EuD5UrDIO/UYcU0z24o4Lg
	hBcWe1S7aFnheW3vajasEQ417F0e88DFfTeSfKvOKKKmDXcOkeNFDzHpihrJTMHhfiIZFpX5Ik3vG
	x73KIJuGStLol1KhqVXTS5VTwtjYq25/Umiy1lfOmubEW0zqhQnm79tqgcnuuBGblaQ5uYvEjTXac
	u/v+cAgVFW5tshDsdhUcewa548aiPSaPx/8t6iaWjHPCxGaOGXB8ZYkKaSp98EbV1WnJfY3GYEIGF
	j0Qf9TdFbgzVkBCK37NJKoYOwe449tk69TYyFPSHfPLNnPSR83YG/RvfkSPww9kPT5j4Ivs6bExza
	Qs1kMTpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5Q1Y-0099Rg-NL; Mon, 19 Jul 2021 09:57:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5Q1M-0099PT-R5
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 09:57:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 58EB522211;
 Mon, 19 Jul 2021 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626688627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hm0zebaLB1hjuy5JvbxVdPV/pSPvr5dtUW8IyF6POIw=;
 b=yTP5pKNoCyI7Jjy4ptxGgMmsdn8+gFd9uPryJOgL9cozn/N81BRGJzcrjgEeFM2YpgKDFg
 FclstTKBeA/eUCVoqA2ymDNDeLHF/Mya/UXiiBJPNrY4NNZZBdIDW1/2k5FkYPKhoTDqbC
 kR/deS+NQw5ZahK41LQN2s5Re0e193A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626688627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hm0zebaLB1hjuy5JvbxVdPV/pSPvr5dtUW8IyF6POIw=;
 b=GDN7uLNmt7P8pyASVwy1uZF2gyMwKA7nG4gR3IWm2c90DUxBiXdNKt174lEHyi7+rEdtqd
 1OxpoPGePQfGwODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F21C13CA7;
 Mon, 19 Jul 2021 09:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Gr41D3NM9WDWMwAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 19 Jul 2021 09:57:07 +0000
To: Stephan Mueller <smueller@chronox.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <2510347.locV8n3378@positron.chronox.de>
 <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
 <6538288.aohFRl0Q45@positron.chronox.de>
 <59695981-9edc-6b7a-480a-94cca95a0b8c@suse.de>
 <463a191b9896dd708015645cfc125988cd5deaef.camel@chronox.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
Message-ID: <2af95a8e-50d9-7e2d-a556-696e9404fee4@suse.de>
Date: Mon, 19 Jul 2021 11:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <463a191b9896dd708015645cfc125988cd5deaef.camel@chronox.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_025709_071255_58D9A8C5 
X-CRM114-Status: GOOD (  26.66  )
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

T24gNy8xOS8yMSAxMDo1MSBBTSwgU3RlcGhhbiBNdWVsbGVyIHdyb3RlOgo+IEFtIE1vbnRhZywg
ZGVtIDE5LjA3LjIwMjEgdW0gMTA6MTUgKzAyMDAgc2NocmllYiBIYW5uZXMgUmVpbmVja2U6Cj4+
IE9uIDcvMTgvMjEgMjo1NiBQTSwgU3RlcGhhbiBNw7xsbGVyIHdyb3RlOgo+Pj4gQW0gU29ubnRh
ZywgMTguIEp1bGkgMjAyMSwgMTQ6Mzc6MzQgQ0VTVCBzY2hyaWViIEhhbm5lcyBSZWluZWNrZToK
PiAKPj4+PiBUaGUga2V5IGlzIGFsc28gdXNlZCB3aGVuIHVzaW5nIHRoZSBmZmRoZSBhbGdvcml0
aG0uCj4+Pj4gTm90ZTogSSBfdGhpbmtfIHRoYXQgSSBuZWVkIHRvIHVzZSB0aGlzIGtleSBmb3Ig
dGhlIGZmZGhlIGFsZ29yaXRobSwKPj4+PiBiZWNhdXNlIHRoZSBpbXBsZW1lbnRhdGlvbiBJIGNh
bWUgdXAgd2l0aCBpcyBlc3NlbnRpYWxseSBwbGFpbiBESCB3aXRoCj4+Pj4gcHJlLWRlZmluZWQg
J3AnLCAncScgYW5kICdnJyB2YWx1ZXMuIEJ1dCB0aGUgREggaW1wbGVtZW50YXRpb24gYWxzbwo+
Pj4+IHJlcXVpcmVzIGEgJ2tleScsIGFuZCBmb3IgdGhhdCBJJ20gdXNpbmcgdGhpcyBrZXkgaGVy
ZS4KPj4+Pgo+Pj4+IEl0IG1pZ2h0IGJlIHRoYXQgSSdtIGNvbXBsZXRlbHkgb2ZmLCBhbmQgZG9u
J3QgbmVlZCB0byB1c2UgYSBrZXkgZm9yIG91cgo+Pj4+IERIIGltcGxlbWVudGF0aW9uLiBJbiB0
aGF0IGNhc2UgeW91IGFyZSBjb3JyZWN0Lgo+Pj4+IChBbmQgdGhhdCdzIHdoeSBJIHNhaWQgSSds
bCBuZWVkIGEgcmV2aWV3IG9mIHRoZSBGRkRIRSBpbXBsZW1lbnRhdGlvbikuCj4+Pj4gQnV0IGZv
ciBub3cgSSdsbCBuZWVkIHRoZSBrZXkgZm9yIEZGREhFLgo+Pj4KPj4+IERvIEkgdW5kZXJzdGFu
ZCB5b3UgY29ycmVjdGx5IHRoYXQgdGhlIGRoY2hhcF9rZXkgaXMgdXNlZCBhcyB0aGUgaW5wdXQg
dG8KPj4+IHRoZSAKPj4+IERIIC0gaS5lLiBpdCBpcyB0aGUgcmVtb3RlIHB1YmxpYyBrZXkgdGhl
bj8gSXQgbG9va3Mgc3RyYW5nZSB0aGF0IHRoaXMgaXMKPj4+IHVzZWQgCj4+PiBmb3IgREggYnV0
IHRoZW4gaXQgaXMgY2hhbmdlZCBoZXJlIGJ5IGhhc2hpbmcgaXQgdG9nZXRoZXIgd2l0aCBzb21l
dGhpbmcKPj4+IGVsc2UgCj4+PiB0byBmb3JtIGEgbmV3IGRoY2hhcF9rZXkuIE1heWJlIHRoYXQg
aXMgd2hhdCB0aGUgcHJvdG9jb2wgc2F5cy4gQnV0IGl0Cj4+PiBzb3VuZHMgCj4+PiBzdHJhbmdl
IHRvIG1lLCBlc3BlY2lhbGx5IHdoZW4geW91IHRoaW5rIHRoYXQgZGhjaGFwX2tleSB3b3VsZCBi
ZSwgc2F5LAo+Pj4gMjA0OCAKPj4+IGJpdHMgaWYgaXQgaXMgdHJ1bHkgdGhlIHJlbW90ZSBwdWJs
aWMga2V5IGFuZCB0aGVuIGFmdGVyIHRoZSBoYXNoaW5nIGl0IGlzCj4+PiAyNTYgCj4+PiB0aGlz
IGRoY2hhcF9rZXkgY2Fubm90IGJlIHVzZWQgZm9yIEZGQy1ESC4KPj4+Cj4+PiBPciBhcmUgeW91
IHVzaW5nIHRoZSBkaGNoYXBfa2V5IGZvciB0d28gZGlmZmVyZW50IHB1cnBvc2VzPwo+Pj4KPj4+
IEl0IHNlZW1zIEkgbWlzcyBzb21ldGhpbmcgaGVyZS4KPj4+Cj4+IE5vLCBub3QgZW50aXJlbHku
IEl0J3MgbWUgd2hvIGJ1Z2dlcmVkIGl0IHVwLgo+PiBJIGdvdCBjYXJyaWVkIGF3YXkgYnkgdGhl
IGZhY3QgdGhhdCB0aGVyZSBpcyBhIGNyeXB0b19kaF9lbmNvZGVfa2V5KCkKPj4gZnVuY3Rpb24s
IGFuZCB0aG91Z2h0IEkgbmVlZCB0byB1c2UgaXQgaGVyZS4KPiAKPiBUaGFuayB5b3UgZm9yIGNs
YXJpZnlpbmcgdGhhdC4gSXQgc291bmRzIHRvIG1lIHRoYXQgdGhlcmUgaXMgbm8gZGVmaW5lZAo+
IHByb3RvY29sIChvciBpZiB0aGVyZSwgSSB3b3VsZCBiZSB3b25kZXJpbmcgaG93IHRoZSBjb2Rl
IHdvdWxkIGhhdmUgd29ya2VkCj4gd2l0aCBhIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbikuIFdv
dWxkIGl0IG1ha2Ugc2Vuc2UgdG8gZmlyc3Qgc3BlY2lmeSBhCj4gcHJvdG9jb2wgZm9yIGF1dGhl
bnRpY2F0aW9uIGFuZCBoYXZlIGl0IGRpc2N1c3NlZD8gSSBwZXJzb25hbGx5IHRoaW5rIGl0IGlz
IGEKPiBiaXQgZGlmZmljdWx0IHRvIGZ1bGx5IHVuZGVyc3RhbmQgdGhlIHByb3RvY29sIGZyb20g
dGhlIGNvZGUgYW5kIGRpc2N1c3MKPiBwcm90b2NvbC1sZXZlbCBpdGVtcyBiYXNlZCBvbiB0aGUg
Y29kZS4KPiAKT2gsIHRoZSBwcm90b2NvbCBfaXNfIHNwZWNpZmllZDoKCmh0dHBzOi8vbnZtZXhw
cmVzcy5vcmcvd3AtY29udGVudC91cGxvYWRzL05WTS1FeHByZXNzLUJhc2UtU3BlY2lmaWNhdGlv
bi0yXzAtMjAyMS4wNi4wMi1SYXRpZmllZC01LnBkZgoKSXQncyBqdXN0IHRoYXQgSSBoYXZlIGlz
c3VlcyB0cmFuc2xhdGluZyB0aGF0IHNwZWMgb250byB3aGF0IHRoZSBrZXJuZWwKcHJvdmlkZXMu
CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2Vy
bmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0
OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6
IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
