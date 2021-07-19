Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D12BC07E9B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 12:08:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AF460FDA
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 12:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AF460FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Xe4fqIpOpoaq5BaC2zLVPEZkpMd63fzc3SFXJlMOkQU=; b=xobiHcipV0ol8nF6bRRRXz6Nmh
	hMzyEFLjHwtZ4IL4DfNgjpTrfq6MmKDUHGOtPy+47SRzFPIerjV/GD7Kj2MWXi/hCQzVJvCfOg7Bo
	OBrs31H741ayL6xl0AaRGhtN3729R8ObVwbdOSCD0WSh6kJoq7+f52XBoLdbgR1kGvofCPLK41ITT
	/1jvV5ILFN3zl7/1eWXlHuHxU3MByNyewQrxJATEsx/hprQSVJhNy5EHUyHzg3qkKwl+2WEwkf9Vj
	gP9mZumtaR0lwXAvw4va5GuCxKGPMi69dCSM+t9DoTaNjeI/lg5iRImmeJBDdD6C3boq51CrpPgLh
	hUHswEDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5S4B-009YLT-Ru; Mon, 19 Jul 2021 12:08:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5S48-009YL9-VQ
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 12:08:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8AC2A20258;
 Mon, 19 Jul 2021 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626696487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiBVZRbDoLWvaewLny2kvpduEqU+pgM/X0VwmVoIT3w=;
 b=p60ilip4jpJvsqpMIaZg3QupG6g8Mi2s52/y6+dbsMfLb4QwH7DtezsR1T5EmUV0xTbkQz
 dl8L4oULuMtSp4rINo/mSmCkNGlSxAdWScibsYhLN3lcj5rimgFURb+BmHewWQVdOdKyfs
 kfIxta6sWWbYbAJZ2l5RbDcC4zKHgaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626696487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiBVZRbDoLWvaewLny2kvpduEqU+pgM/X0VwmVoIT3w=;
 b=FaP9n3C9SdvwzF+rV2PbmbIQAVxDaPf6x97zbq0C+cQgkWP2VwlftsMM/o/OdKunx+lxE6
 kpv7kxx+bZA4ndCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B21F13CE9;
 Mon, 19 Jul 2021 12:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bo7FHSdr9WBSXAAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 19 Jul 2021 12:08:07 +0000
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
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
 <1eab1472-3b7b-307b-62ae-8bed39603b96@suse.de>
 <24d115c9b68ca98a3cf363e1cfcb961cc6b38069.camel@chronox.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4f7ab2fc-0802-3040-dedc-63d04fbc1f0b@suse.de>
Date: Mon, 19 Jul 2021 14:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <24d115c9b68ca98a3cf363e1cfcb961cc6b38069.camel@chronox.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_050809_210216_C7D38C53 
X-CRM114-Status: GOOD (  30.88  )
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

T24gNy8xOS8yMSAxOjUyIFBNLCBTdGVwaGFuIE11ZWxsZXIgd3JvdGU6Cj4gQW0gTW9udGFnLCBk
ZW0gMTkuMDcuMjAyMSB1bSAxMzoxMCArMDIwMCBzY2hyaWViIEhhbm5lcyBSZWluZWNrZToKPj4g
T24gNy8xOS8yMSAxMjoxOSBQTSwgU3RlcGhhbiBNdWVsbGVyIHdyb3RlOgo+Pj4gQW0gTW9udGFn
LCBkZW0gMTkuMDcuMjAyMSB1bSAxMTo1NyArMDIwMCBzY2hyaWViIEhhbm5lcyBSZWluZWNrZToK
Pj4+PiBPbiA3LzE5LzIxIDEwOjUxIEFNLCBTdGVwaGFuIE11ZWxsZXIgd3JvdGU6Cj4+Pj4+IEFt
IE1vbnRhZywgZGVtIDE5LjA3LjIwMjEgdW0gMTA6MTUgKzAyMDAgc2NocmllYiBIYW5uZXMgUmVp
bmVja2U6Cj4+Pj4+PiBPbiA3LzE4LzIxIDI6NTYgUE0sIFN0ZXBoYW4gTcO8bGxlciB3cm90ZToK
Pj4+Pj4+PiBBbSBTb25udGFnLCAxOC4gSnVsaSAyMDIxLCAxNDozNzozNCBDRVNUIHNjaHJpZWIg
SGFubmVzIFJlaW5lY2tlOgo+Pj4+Pgo+Pj4+Pj4+PiBUaGUga2V5IGlzIGFsc28gdXNlZCB3aGVu
IHVzaW5nIHRoZSBmZmRoZSBhbGdvcml0aG0uCj4+Pj4+Pj4+IE5vdGU6IEkgX3RoaW5rXyB0aGF0
IEkgbmVlZCB0byB1c2UgdGhpcyBrZXkgZm9yIHRoZSBmZmRoZQo+Pj4+Pj4+PiBhbGdvcml0aG0s
Cj4+Pj4+Pj4+IGJlY2F1c2UgdGhlIGltcGxlbWVudGF0aW9uIEkgY2FtZSB1cCB3aXRoIGlzIGVz
c2VudGlhbGx5IHBsYWluCj4+Pj4+Pj4+IERICj4+Pj4+Pj4+IHdpdGgKPj4+Pj4+Pj4gcHJlLWRl
ZmluZWQgJ3AnLCAncScgYW5kICdnJyB2YWx1ZXMuIEJ1dCB0aGUgREggaW1wbGVtZW50YXRpb24K
Pj4+Pj4+Pj4gYWxzbwo+Pj4+Pj4+PiByZXF1aXJlcyBhICdrZXknLCBhbmQgZm9yIHRoYXQgSSdt
IHVzaW5nIHRoaXMga2V5IGhlcmUuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEl0IG1pZ2h0IGJlIHRoYXQg
SSdtIGNvbXBsZXRlbHkgb2ZmLCBhbmQgZG9uJ3QgbmVlZCB0byB1c2UgYSBrZXkKPj4+Pj4+Pj4g
Zm9yCj4+Pj4+Pj4+IG91cgo+Pj4+Pj4+PiBESCBpbXBsZW1lbnRhdGlvbi4gSW4gdGhhdCBjYXNl
IHlvdSBhcmUgY29ycmVjdC4KPj4+Pj4+Pj4gKEFuZCB0aGF0J3Mgd2h5IEkgc2FpZCBJJ2xsIG5l
ZWQgYSByZXZpZXcgb2YgdGhlIEZGREhFCj4+Pj4+Pj4+IGltcGxlbWVudGF0aW9uKS4KPj4+Pj4+
Pj4gQnV0IGZvciBub3cgSSdsbCBuZWVkIHRoZSBrZXkgZm9yIEZGREhFLgo+Pj4+Pj4+Cj4+Pj4+
Pj4gRG8gSSB1bmRlcnN0YW5kIHlvdSBjb3JyZWN0bHkgdGhhdCB0aGUgZGhjaGFwX2tleSBpcyB1
c2VkIGFzIHRoZQo+Pj4+Pj4+IGlucHV0Cj4+Pj4+Pj4gdG8KPj4+Pj4+PiB0aGUgCj4+Pj4+Pj4g
REggLSBpLmUuIGl0IGlzIHRoZSByZW1vdGUgcHVibGljIGtleSB0aGVuPyBJdCBsb29rcyBzdHJh
bmdlIHRoYXQKPj4+Pj4+PiB0aGlzCj4+Pj4+Pj4gaXMKPj4+Pj4+PiB1c2VkIAo+Pj4+Pj4+IGZv
ciBESCBidXQgdGhlbiBpdCBpcyBjaGFuZ2VkIGhlcmUgYnkgaGFzaGluZyBpdCB0b2dldGhlciB3
aXRoCj4+Pj4+Pj4gc29tZXRoaW5nCj4+Pj4+Pj4gZWxzZSAKPj4+Pj4+PiB0byBmb3JtIGEgbmV3
IGRoY2hhcF9rZXkuIE1heWJlIHRoYXQgaXMgd2hhdCB0aGUgcHJvdG9jb2wgc2F5cy4KPj4+Pj4+
PiBCdXQgaXQKPj4+Pj4+PiBzb3VuZHMgCj4+Pj4+Pj4gc3RyYW5nZSB0byBtZSwgZXNwZWNpYWxs
eSB3aGVuIHlvdSB0aGluayB0aGF0IGRoY2hhcF9rZXkgd291bGQgYmUsCj4+Pj4+Pj4gc2F5LAo+
Pj4+Pj4+IDIwNDggCj4+Pj4+Pj4gYml0cyBpZiBpdCBpcyB0cnVseSB0aGUgcmVtb3RlIHB1Ymxp
YyBrZXkgYW5kIHRoZW4gYWZ0ZXIgdGhlCj4+Pj4+Pj4gaGFzaGluZwo+Pj4+Pj4+IGl0IGlzCj4+
Pj4+Pj4gMjU2IAo+Pj4+Pj4+IHRoaXMgZGhjaGFwX2tleSBjYW5ub3QgYmUgdXNlZCBmb3IgRkZD
LURILgo+Pj4+Pj4+Cj4+Pj4+Pj4gT3IgYXJlIHlvdSB1c2luZyB0aGUgZGhjaGFwX2tleSBmb3Ig
dHdvIGRpZmZlcmVudCBwdXJwb3Nlcz8KPj4+Pj4+Pgo+Pj4+Pj4+IEl0IHNlZW1zIEkgbWlzcyBz
b21ldGhpbmcgaGVyZS4KPj4+Pj4+Pgo+Pj4+Pj4gTm8sIG5vdCBlbnRpcmVseS4gSXQncyBtZSB3
aG8gYnVnZ2VyZWQgaXQgdXAuCj4+Pj4+PiBJIGdvdCBjYXJyaWVkIGF3YXkgYnkgdGhlIGZhY3Qg
dGhhdCB0aGVyZSBpcyBhCj4+Pj4+PiBjcnlwdG9fZGhfZW5jb2RlX2tleSgpCj4+Pj4+PiBmdW5j
dGlvbiwgYW5kIHRob3VnaHQgSSBuZWVkIHRvIHVzZSBpdCBoZXJlLgo+Pj4+Pgo+Pj4+PiBUaGFu
ayB5b3UgZm9yIGNsYXJpZnlpbmcgdGhhdC4gSXQgc291bmRzIHRvIG1lIHRoYXQgdGhlcmUgaXMg
bm8KPj4+Pj4gZGVmaW5lZAo+Pj4+PiBwcm90b2NvbCAob3IgaWYgdGhlcmUsIEkgd291bGQgYmUg
d29uZGVyaW5nIGhvdyB0aGUgY29kZSB3b3VsZCBoYXZlCj4+Pj4+IHdvcmtlZAo+Pj4+PiB3aXRo
IGEgZGlmZmVyZW50IGltcGxlbWVudGF0aW9uKS4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBmaXJz
dCBzcGVjaWZ5Cj4+Pj4+IGEKPj4+Pj4gcHJvdG9jb2wgZm9yIGF1dGhlbnRpY2F0aW9uIGFuZCBo
YXZlIGl0IGRpc2N1c3NlZD8gSSBwZXJzb25hbGx5IHRoaW5rCj4+Pj4+IGl0Cj4+Pj4+IGlzIGEK
Pj4+Pj4gYml0IGRpZmZpY3VsdCB0byBmdWxseSB1bmRlcnN0YW5kIHRoZSBwcm90b2NvbCBmcm9t
IHRoZSBjb2RlIGFuZAo+Pj4+PiBkaXNjdXNzCj4+Pj4+IHByb3RvY29sLWxldmVsIGl0ZW1zIGJh
c2VkIG9uIHRoZSBjb2RlLgo+Pj4+Pgo+Pj4+IE9oLCB0aGUgcHJvdG9jb2wgX2lzXyBzcGVjaWZp
ZWQ6Cj4+Pj4KPj4+PiAgCj4+Pj4gaHR0cHM6Ly9udm1leHByZXNzLm9yZy93cC1jb250ZW50L3Vw
bG9hZHMvTlZNLUV4cHJlc3MtQmFzZS1TcGVjaWZpY2F0aW9uLTJfMC0yMDIxLjA2LjAyLVJhdGlm
aWVkLTUucGRmCj4+Pj4KPj4+PiBJdCdzIGp1c3QgdGhhdCBJIGhhdmUgaXNzdWVzIHRyYW5zbGF0
aW5nIHRoYXQgc3BlYyBvbnRvIHdoYXQgdGhlIGtlcm5lbAo+Pj4+IHByb3ZpZGVzLgo+Pj4KPj4+
IGFjY29yZGluZyB0byB0aGUgbmFtaW5nIGNvbnZlbnRpb25zIHRoZXJlIGluIGZpZ3VyZXMgNDQ3
IGFuZCBmb2xsb3dpbmc6Cj4+Pgo+Pj4gLSB4IGFuZCB5OiBESCBwcml2YXRlIGtleSAoa2VybmVs
IGNhbGxzIGl0IHNlY3JldCBzZXQgd2l0aCBkaF9zZXRfc2VjcmV0Cj4+PiBvcgo+Pj4gZW5jb2Rl
ZCBpbnRvIHBhcmFtLmtleSkKPj4+Cj4+Cj4+IEJ1dCB0aGF0J3Mgd2VyZSBJIGdvdCBjb25mdXNl
ZDsgb25lIG5lZWRzIGEgcHJpdmF0ZSBrZXkgaGVyZSwgYnV0IHRoZXJlCj4+IGlzIG5vIG9idmlv
dXMgY2FuZGlkYXRlIGZvciBpdC4gQnV0IHJlYWRpbmcgaXQgbW9yZSBjbG9zZWx5IEkgZ3Vlc3Mg
dGhlCj4+IHByaXZhdGUga2V5IGlzIGp1c3QgYSByYW5kb20gbnVtYmVyIChjZiB0aGUgc3BlYzog
Z155IG1vZCBwLCB3aGVyZSB5IGlzCj4+IGEgcmFuZG9tIG51bWJlciBzZWxlY3RlZCBieSB0aGUg
aG9zdCB0aGF0IHNoYWxsIGJlIGF0IGxlYXN0IDI1NiBiaXRzCj4+IGxvbmcpLiBTbyBJJ2xsIGZp
eCBpdCB1cCB3aXRoIHRoZSBuZXh0IHJvdW5kLgo+IAo+IEhlcmUgY29tZXMgdGhlIGNydXg6IHRo
ZSBrZXJuZWwgaGFzIGFuIEVDQyBwcml2YXRlIGtleSBnZW5lcmF0aW9uIGZ1bmN0aW9uCj4gZWNk
aF9zZXRfc2VjcmV0IHRyaWdnZXJlZCB3aXRoIGNyeXB0b19rcHBfc2V0X3NlY3JldCB1c2luZyBh
IE5VTEwga2V5LCBidXQgaXQKPiBoYXMgbm8gRkZDLURIIGNvdW50ZXJwYXJ0Lgo+IAo+IFRoYXQg
c2FpZCwgZ2VuZXJhdGluZyBhIHJhbmRvbSBudW1iZXIgaXMgdGhlIG1vc3Qgb2J2aW91cyBjaG9p
Y2UsIGJ1dCBub3QgdGhlCj4gcmlnaHQgb25lLgo+IAo+IFRoZSBjb3JyZWN0IG9uZSB3b3VsZCBi
ZSBmb2xsb3dpbmcgU1A4MDAtNTZBIHJldiAzIGFuZCBoZXJlIGVpdGhlciBzZWN0aW9uCj4gNS42
LjEuMS4zIG9yIDUuNi4xLjEuNC4KPiAKCk9oIGZzY2suIE9mIGNvdXJzZS4gV291bGQndmUgYmVl
biB0b28gZWFzeS4KV2VsbCwgbW9yZSBjb2RpbmcgcmVxdWlyZWQgdGhlbi4gTGV0J3Mgc2VlIGhv
dyBpdCBnb2VzLgpCdXQgdGhhbmtzIGZvciB5b3VyIGhlbHAhCgooQW5kIEkgd291bGRuJ3Qgc2F5
IG5vIGlmIHNvbWVvbmUgd291bGQgc3RlcCBpbiBhbiBwcm92aWRlIGEgJ3JlYWwnCkZGREhFIGNy
eXB0byBhbGdvcml0aG07IG5vdyB0aGF0IHRoZSBwYXJhbWV0ZXJzIGFyZSBhbHJlYWR5IHByZXNl
bnQgOi0pCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAg
ICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAg
ICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21i
SCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJn
KSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
