Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B42EC07E9B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 11:10:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3BC610FB
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 11:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3BC610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QGrFu53llRuKpkWF/QBiaAlcryEkJbiuzsHFe6z2lHM=; b=4XaGtVSFzDRI/VNGTmM9d2Czt1
	wCR2SSb8hfTFEAGs0pp3najwFvmR+k13TJN0wsBxulX9oRnhN/OxEfD4h77omoSvMXkK/muMzPeAd
	gpgCzAFbGJDLVr5DmZQaVIHI+J6ZvXmNeUksE8TRjvrnXsexlPod2ZuJyaPt4R8iO6EWXuV6rq6yO
	c660MT/qyBWk0xP0WDQuVM8ZprDofI708nQMK4s6Cz0SkEz3hHmcWGnzDXXYlF4NHvTX9agRKuYNX
	Hj6Y06aR+1dSfyKWxVwQEcxiFR4k0RQcNFFDcY5Iiw/gtHDfuUY0ErjY8wShZBjjMaC78oLqtNaxf
	4UetkB/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5RAQ-009SL8-BA; Mon, 19 Jul 2021 11:10:34 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5RAN-009SKX-TV
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 11:10:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5022C2021F;
 Mon, 19 Jul 2021 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626693030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I3F3x6ejzeetKwA6HIYGtlYGA0sYpAZPeq5bfUcHzUI=;
 b=yXMTPFxdLsJcpr/o3d822WBZxse+jgSV0Kn7Qy5y7Ea/uhAbi4/5yHpHYy5yLMlejZI1AQ
 3iJoDHWdbg95QALBNBvbfRM2yC+vRLcXqR0WrzMSAh5DHnMI1N7VrpMqroHntyqxNOpttm
 1DsRb9d/yoFX2MXMKk99Ra+TYADb4OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626693030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I3F3x6ejzeetKwA6HIYGtlYGA0sYpAZPeq5bfUcHzUI=;
 b=XzMqnk/VS4h2V1HmRm8eQuZDz5m5LXxJLxrFbQAD9LfK9b0b+5vrvpZ3Rxa6iymyEOdO6s
 DYieXTVLtD1wEtDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FDA613CDE;
 Mon, 19 Jul 2021 11:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7RRVD6Zd9WDWSQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 19 Jul 2021 11:10:30 +0000
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
 <2af95a8e-50d9-7e2d-a556-696e9404fee4@suse.de>
 <740af9f7334c294ce879bef33985dfab6d0523b3.camel@chronox.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
Message-ID: <1eab1472-3b7b-307b-62ae-8bed39603b96@suse.de>
Date: Mon, 19 Jul 2021 13:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <740af9f7334c294ce879bef33985dfab6d0523b3.camel@chronox.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_041032_156295_D2DDF5B9 
X-CRM114-Status: GOOD (  32.38  )
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

T24gNy8xOS8yMSAxMjoxOSBQTSwgU3RlcGhhbiBNdWVsbGVyIHdyb3RlOgo+IEFtIE1vbnRhZywg
ZGVtIDE5LjA3LjIwMjEgdW0gMTE6NTcgKzAyMDAgc2NocmllYiBIYW5uZXMgUmVpbmVja2U6Cj4+
IE9uIDcvMTkvMjEgMTA6NTEgQU0sIFN0ZXBoYW4gTXVlbGxlciB3cm90ZToKPj4+IEFtIE1vbnRh
ZywgZGVtIDE5LjA3LjIwMjEgdW0gMTA6MTUgKzAyMDAgc2NocmllYiBIYW5uZXMgUmVpbmVja2U6
Cj4+Pj4gT24gNy8xOC8yMSAyOjU2IFBNLCBTdGVwaGFuIE3DvGxsZXIgd3JvdGU6Cj4+Pj4+IEFt
IFNvbm50YWcsIDE4LiBKdWxpIDIwMjEsIDE0OjM3OjM0IENFU1Qgc2NocmllYiBIYW5uZXMgUmVp
bmVja2U6Cj4+Pgo+Pj4+Pj4gVGhlIGtleSBpcyBhbHNvIHVzZWQgd2hlbiB1c2luZyB0aGUgZmZk
aGUgYWxnb3JpdGhtLgo+Pj4+Pj4gTm90ZTogSSBfdGhpbmtfIHRoYXQgSSBuZWVkIHRvIHVzZSB0
aGlzIGtleSBmb3IgdGhlIGZmZGhlIGFsZ29yaXRobSwKPj4+Pj4+IGJlY2F1c2UgdGhlIGltcGxl
bWVudGF0aW9uIEkgY2FtZSB1cCB3aXRoIGlzIGVzc2VudGlhbGx5IHBsYWluIERICj4+Pj4+PiB3
aXRoCj4+Pj4+PiBwcmUtZGVmaW5lZCAncCcsICdxJyBhbmQgJ2cnIHZhbHVlcy4gQnV0IHRoZSBE
SCBpbXBsZW1lbnRhdGlvbiBhbHNvCj4+Pj4+PiByZXF1aXJlcyBhICdrZXknLCBhbmQgZm9yIHRo
YXQgSSdtIHVzaW5nIHRoaXMga2V5IGhlcmUuCj4+Pj4+Pgo+Pj4+Pj4gSXQgbWlnaHQgYmUgdGhh
dCBJJ20gY29tcGxldGVseSBvZmYsIGFuZCBkb24ndCBuZWVkIHRvIHVzZSBhIGtleSBmb3IKPj4+
Pj4+IG91cgo+Pj4+Pj4gREggaW1wbGVtZW50YXRpb24uIEluIHRoYXQgY2FzZSB5b3UgYXJlIGNv
cnJlY3QuCj4+Pj4+PiAoQW5kIHRoYXQncyB3aHkgSSBzYWlkIEknbGwgbmVlZCBhIHJldmlldyBv
ZiB0aGUgRkZESEUKPj4+Pj4+IGltcGxlbWVudGF0aW9uKS4KPj4+Pj4+IEJ1dCBmb3Igbm93IEkn
bGwgbmVlZCB0aGUga2V5IGZvciBGRkRIRS4KPj4+Pj4KPj4+Pj4gRG8gSSB1bmRlcnN0YW5kIHlv
dSBjb3JyZWN0bHkgdGhhdCB0aGUgZGhjaGFwX2tleSBpcyB1c2VkIGFzIHRoZSBpbnB1dAo+Pj4+
PiB0bwo+Pj4+PiB0aGUgCj4+Pj4+IERIIC0gaS5lLiBpdCBpcyB0aGUgcmVtb3RlIHB1YmxpYyBr
ZXkgdGhlbj8gSXQgbG9va3Mgc3RyYW5nZSB0aGF0IHRoaXMKPj4+Pj4gaXMKPj4+Pj4gdXNlZCAK
Pj4+Pj4gZm9yIERIIGJ1dCB0aGVuIGl0IGlzIGNoYW5nZWQgaGVyZSBieSBoYXNoaW5nIGl0IHRv
Z2V0aGVyIHdpdGgKPj4+Pj4gc29tZXRoaW5nCj4+Pj4+IGVsc2UgCj4+Pj4+IHRvIGZvcm0gYSBu
ZXcgZGhjaGFwX2tleS4gTWF5YmUgdGhhdCBpcyB3aGF0IHRoZSBwcm90b2NvbCBzYXlzLiBCdXQg
aXQKPj4+Pj4gc291bmRzIAo+Pj4+PiBzdHJhbmdlIHRvIG1lLCBlc3BlY2lhbGx5IHdoZW4geW91
IHRoaW5rIHRoYXQgZGhjaGFwX2tleSB3b3VsZCBiZSwKPj4+Pj4gc2F5LAo+Pj4+PiAyMDQ4IAo+
Pj4+PiBiaXRzIGlmIGl0IGlzIHRydWx5IHRoZSByZW1vdGUgcHVibGljIGtleSBhbmQgdGhlbiBh
ZnRlciB0aGUgaGFzaGluZwo+Pj4+PiBpdCBpcwo+Pj4+PiAyNTYgCj4+Pj4+IHRoaXMgZGhjaGFw
X2tleSBjYW5ub3QgYmUgdXNlZCBmb3IgRkZDLURILgo+Pj4+Pgo+Pj4+PiBPciBhcmUgeW91IHVz
aW5nIHRoZSBkaGNoYXBfa2V5IGZvciB0d28gZGlmZmVyZW50IHB1cnBvc2VzPwo+Pj4+Pgo+Pj4+
PiBJdCBzZWVtcyBJIG1pc3Mgc29tZXRoaW5nIGhlcmUuCj4+Pj4+Cj4+Pj4gTm8sIG5vdCBlbnRp
cmVseS4gSXQncyBtZSB3aG8gYnVnZ2VyZWQgaXQgdXAuCj4+Pj4gSSBnb3QgY2FycmllZCBhd2F5
IGJ5IHRoZSBmYWN0IHRoYXQgdGhlcmUgaXMgYSBjcnlwdG9fZGhfZW5jb2RlX2tleSgpCj4+Pj4g
ZnVuY3Rpb24sIGFuZCB0aG91Z2h0IEkgbmVlZCB0byB1c2UgaXQgaGVyZS4KPj4+Cj4+PiBUaGFu
ayB5b3UgZm9yIGNsYXJpZnlpbmcgdGhhdC4gSXQgc291bmRzIHRvIG1lIHRoYXQgdGhlcmUgaXMg
bm8gZGVmaW5lZAo+Pj4gcHJvdG9jb2wgKG9yIGlmIHRoZXJlLCBJIHdvdWxkIGJlIHdvbmRlcmlu
ZyBob3cgdGhlIGNvZGUgd291bGQgaGF2ZSB3b3JrZWQKPj4+IHdpdGggYSBkaWZmZXJlbnQgaW1w
bGVtZW50YXRpb24pLiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGZpcnN0IHNwZWNpZnkgYQo+Pj4g
cHJvdG9jb2wgZm9yIGF1dGhlbnRpY2F0aW9uIGFuZCBoYXZlIGl0IGRpc2N1c3NlZD8gSSBwZXJz
b25hbGx5IHRoaW5rIGl0Cj4+PiBpcyBhCj4+PiBiaXQgZGlmZmljdWx0IHRvIGZ1bGx5IHVuZGVy
c3RhbmQgdGhlIHByb3RvY29sIGZyb20gdGhlIGNvZGUgYW5kIGRpc2N1c3MKPj4+IHByb3RvY29s
LWxldmVsIGl0ZW1zIGJhc2VkIG9uIHRoZSBjb2RlLgo+Pj4KPj4gT2gsIHRoZSBwcm90b2NvbCBf
aXNfIHNwZWNpZmllZDoKPj4KPj4gaHR0cHM6Ly9udm1leHByZXNzLm9yZy93cC1jb250ZW50L3Vw
bG9hZHMvTlZNLUV4cHJlc3MtQmFzZS1TcGVjaWZpY2F0aW9uLTJfMC0yMDIxLjA2LjAyLVJhdGlm
aWVkLTUucGRmCj4+Cj4+IEl0J3MganVzdCB0aGF0IEkgaGF2ZSBpc3N1ZXMgdHJhbnNsYXRpbmcg
dGhhdCBzcGVjIG9udG8gd2hhdCB0aGUga2VybmVsCj4+IHByb3ZpZGVzLgo+IAo+IGFjY29yZGlu
ZyB0byB0aGUgbmFtaW5nIGNvbnZlbnRpb25zIHRoZXJlIGluIGZpZ3VyZXMgNDQ3IGFuZCBmb2xs
b3dpbmc6Cj4gCj4gLSB4IGFuZCB5OiBESCBwcml2YXRlIGtleSAoa2VybmVsIGNhbGxzIGl0IHNl
Y3JldCBzZXQgd2l0aCBkaF9zZXRfc2VjcmV0IG9yCj4gZW5jb2RlZCBpbnRvIHBhcmFtLmtleSkK
PiAKCkJ1dCB0aGF0J3Mgd2VyZSBJIGdvdCBjb25mdXNlZDsgb25lIG5lZWRzIGEgcHJpdmF0ZSBr
ZXkgaGVyZSwgYnV0IHRoZXJlCmlzIG5vIG9idmlvdXMgY2FuZGlkYXRlIGZvciBpdC4gQnV0IHJl
YWRpbmcgaXQgbW9yZSBjbG9zZWx5IEkgZ3Vlc3MgdGhlCnByaXZhdGUga2V5IGlzIGp1c3QgYSBy
YW5kb20gbnVtYmVyIChjZiB0aGUgc3BlYzogZ155IG1vZCBwLCB3aGVyZSB5IGlzCmEgcmFuZG9t
IG51bWJlciBzZWxlY3RlZCBieSB0aGUgaG9zdCB0aGF0IHNoYWxsIGJlIGF0IGxlYXN0IDI1NiBi
aXRzCmxvbmcpLiBTbyBJJ2xsIGZpeCBpdCB1cCB3aXRoIHRoZSBuZXh0IHJvdW5kLgoKPiAtIGde
eCBtb2QgcCAgLyBnXnkgbW9kIHA6IERIIHB1YmxpYyBrZXlzIGZyb20gZWl0aGVyIGVuZCB0aGF0
IGlzIGNvbW11bmljYXRlZAo+IG92ZXIgdGhlIHdpcmUgKGNvcnJlc3BvbmRpbmcgdG8gdGhlIHRo
ZSBESCBwcml2YXRlIGtleXMgb2YgeCBhbmQgeSkgLSB0byBzZXQKPiBpdCwgeW91IGluaXRpYWxp
emUgYSBkaCByZXF1ZXN0IGFuZCBzZXQgdGhlIHB1YmxpYyBrZXkgdG8gaXQgd2l0aAo+IGtwcF9y
ZXF1ZXN0X3NldF9pbnB1dC4gQWZ0ZXIgcGVyZm9ybWluZyB0aGUgY3J5cHRvX2twcF9jb21wdXRl
X3NoYXJlZF9zZWNyZXQKPiB5b3UgcmVjZWl2ZSB0aGUgc2hhcmVkIHNlY3JldAo+IAo+IC0gZ154
eSBtb2QgcDogREggc2hhcmVkIHNlY3JldCAtIHRoaXMgaXMgdGhlIG9uZSB0aGF0IGlzIHRvIGJl
IHVzZWQgZm9yIHRoZQo+IHN1YnNlcXVlbnQgaGFzaGluZyAvSE1BQyBvcGVyYXRpb25zIGFzIHRo
aXMgaXMgdGhlIG9uZSB0aGF0IGlzIGlkZW50aWNhbCBvbgo+IGJvdGgsIHRoZSBob3N0IGFuZCB0
aGUgY29udHJvbGxlci4KPiAKVGhhbmtzLiBXaWxsIGJlIGNoZWNraW5nIHRoZSBjb2RlIGlmIEkg
ZG8gaXQgY29ycmVjdGx5LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
CQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAg
ICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
ZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFH
IE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
