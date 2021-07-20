Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4611C07E9B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 10:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845E4610D2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 10:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845E4610D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=shuJha3GtiI3t6zHjXdiB0EA+O8ylsiUdWxEFj/tH14=; b=CygGrB1W5z9DShMfiPlApO7Eza
	huvhYtNsKnr+hImFe6ITpK05v0HTSG58khj/dxtw3MdMyAfsmJbr3XTJ0oIF4VJkJYnAg+qtxkh1D
	y/puc17KuUra4NwBqflxeUqHdA6NMKImD5KbBRRTzR7nSw2cpkmTIalOWm5PAULCg6l5fcbOJTb+Z
	C/EmwCyCi2LE8GAfDVKfH3BHcc1k+DljegteQCx0AdN6LiKics9WX6fO8k9EWyxw+sUfF50s0ckuB
	JGJkAb8FnnJX6gca6bzajaZR4Siy2u+RsLqiTTY1Agve2luGB1UHnVemF2NncL60hq1ALTFKXNh71
	GDo3E1YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5mlZ-00CUK6-DH; Tue, 20 Jul 2021 10:14:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5mlV-00CUJ3-Gw
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 10:14:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D30C622419;
 Tue, 20 Jul 2021 10:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626776053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FYlnfwSqvCvApaJ9OUS7ubtp7LXuPf/JRWAB3Y5Wz1M=;
 b=TRhnd3Nw4aVf6ObEJC/gZiC2lpepmEdFrOL0IkSMddCdBW4L9YdLHFxSDBZbiCo4I+4+BY
 riJOWoWnEhBi74lrYjxEHfQy/htGpXcf5AHOIhHxv9L6wjh4DWbW239CnazEMd5uo04Pi7
 NBMQ0hWTfsAbGCc29NGOwaZGyGxX6Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626776053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FYlnfwSqvCvApaJ9OUS7ubtp7LXuPf/JRWAB3Y5Wz1M=;
 b=CCsD5C4RHHURJzfDyoIvMYLSgYiZHHnfBt6Lx+/OCAVAA0yKiBsdJl48daQUgL+FF8B/aI
 kjN9YDp1QZhCj5BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C120413D66;
 Tue, 20 Jul 2021 10:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SU7ILvWh9mD5NwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 10:14:13 +0000
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
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
Message-ID: <aac9448e-29e9-6d03-1077-148be3c10f50@suse.de>
Date: Tue, 20 Jul 2021 12:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <24d115c9b68ca98a3cf363e1cfcb961cc6b38069.camel@chronox.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_031417_804440_C256D462 
X-CRM114-Status: GOOD (  25.73  )
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
Pj4+PiBPbiA3LzE5LzIxIDEwOjUxIEFNLCBTdGVwaGFuIE11ZWxsZXIgd3JvdGU6ClsgLi4gXQo+
Pj4+Pgo+Pj4+PiBUaGFuayB5b3UgZm9yIGNsYXJpZnlpbmcgdGhhdC4gSXQgc291bmRzIHRvIG1l
IHRoYXQgdGhlcmUgaXMgbm8KPj4+Pj4gZGVmaW5lZCBwcm90b2NvbCAob3IgaWYgdGhlcmUsIEkg
d291bGQgYmUgd29uZGVyaW5nIGhvdyB0aGUgY29kZSB3b3VsZCBoYXZlCj4+Pj4+IHdvcmtlZAo+
Pj4+PiB3aXRoIGEgZGlmZmVyZW50IGltcGxlbWVudGF0aW9uKS4gV291bGQgaXQgbWFrZSBzZW5z
ZSB0byBmaXJzdCBzcGVjaWZ5Cj4+Pj4+IGEgcHJvdG9jb2wgZm9yIGF1dGhlbnRpY2F0aW9uIGFu
ZCBoYXZlIGl0IGRpc2N1c3NlZD8gSSBwZXJzb25hbGx5IHRoaW5rCj4+Pj4+IGl0IGlzIGEgYml0
IGRpZmZpY3VsdCB0byBmdWxseSB1bmRlcnN0YW5kIHRoZSBwcm90b2NvbCBmcm9tIHRoZSBjb2Rl
IGFuZAo+Pj4+PiBkaXNjdXNzIHByb3RvY29sLWxldmVsIGl0ZW1zIGJhc2VkIG9uIHRoZSBjb2Rl
Lgo+Pj4+Pgo+Pj4+IE9oLCB0aGUgcHJvdG9jb2wgX2lzXyBzcGVjaWZpZWQ6Cj4+Pj4KPj4+PiAg
Cj4+Pj4gaHR0cHM6Ly9udm1leHByZXNzLm9yZy93cC1jb250ZW50L3VwbG9hZHMvTlZNLUV4cHJl
c3MtQmFzZS1TcGVjaWZpY2F0aW9uLTJfMC0yMDIxLjA2LjAyLVJhdGlmaWVkLTUucGRmCj4+Pj4K
Pj4+PiBJdCdzIGp1c3QgdGhhdCBJIGhhdmUgaXNzdWVzIHRyYW5zbGF0aW5nIHRoYXQgc3BlYyBv
bnRvIHdoYXQgdGhlIGtlcm5lbAo+Pj4+IHByb3ZpZGVzLgo+Pj4KPj4+IGFjY29yZGluZyB0byB0
aGUgbmFtaW5nIGNvbnZlbnRpb25zIHRoZXJlIGluIGZpZ3VyZXMgNDQ3IGFuZCBmb2xsb3dpbmc6
Cj4+Pgo+Pj4gLSB4IGFuZCB5OiBESCBwcml2YXRlIGtleSAoa2VybmVsIGNhbGxzIGl0IHNlY3Jl
dCBzZXQgd2l0aCBkaF9zZXRfc2VjcmV0Cj4+PiBvcgo+Pj4gZW5jb2RlZCBpbnRvIHBhcmFtLmtl
eSkKPj4+Cj4+Cj4+IEJ1dCB0aGF0J3Mgd2VyZSBJIGdvdCBjb25mdXNlZDsgb25lIG5lZWRzIGEg
cHJpdmF0ZSBrZXkgaGVyZSwgYnV0IHRoZXJlCj4+IGlzIG5vIG9idmlvdXMgY2FuZGlkYXRlIGZv
ciBpdC4gQnV0IHJlYWRpbmcgaXQgbW9yZSBjbG9zZWx5IEkgZ3Vlc3MgdGhlCj4+IHByaXZhdGUg
a2V5IGlzIGp1c3QgYSByYW5kb20gbnVtYmVyIChjZiB0aGUgc3BlYzogZ155IG1vZCBwLCB3aGVy
ZSB5IGlzCj4+IGEgcmFuZG9tIG51bWJlciBzZWxlY3RlZCBieSB0aGUgaG9zdCB0aGF0IHNoYWxs
IGJlIGF0IGxlYXN0IDI1NiBiaXRzCj4+IGxvbmcpLiBTbyBJJ2xsIGZpeCBpdCB1cCB3aXRoIHRo
ZSBuZXh0IHJvdW5kLgo+IAo+IEhlcmUgY29tZXMgdGhlIGNydXg6IHRoZSBrZXJuZWwgaGFzIGFu
IEVDQyBwcml2YXRlIGtleSBnZW5lcmF0aW9uIGZ1bmN0aW9uCj4gZWNkaF9zZXRfc2VjcmV0IHRy
aWdnZXJlZCB3aXRoIGNyeXB0b19rcHBfc2V0X3NlY3JldCB1c2luZyBhIE5VTEwga2V5LCBidXQg
aXQKPiBoYXMgbm8gRkZDLURIIGNvdW50ZXJwYXJ0Lgo+IAo+IFRoYXQgc2FpZCwgZ2VuZXJhdGlu
ZyBhIHJhbmRvbSBudW1iZXIgaXMgdGhlIG1vc3Qgb2J2aW91cyBjaG9pY2UsIGJ1dCBub3QgdGhl
Cj4gcmlnaHQgb25lLgo+IAo+IFRoZSBjb3JyZWN0IG9uZSB3b3VsZCBiZSBmb2xsb3dpbmcgU1A4
MDAtNTZBIHJldiAzIGFuZCBoZXJlIGVpdGhlciBzZWN0aW9uCj4gNS42LjEuMS4zIG9yIDUuNi4x
LjEuNC4KPiAKSG1tLiBPa2F5LiBCdXQgYWZ0ZXIgaGF2aW5nIHJlYWQgc2VjdGlvbiA1LjYuMS4x
LjQsIEkgc3RpbGwgZG8gaGF2ZSBzb21lCnF1ZXN0aW9ucy4KCkFzc3VtZSB3ZSB3aWxsIGJlIHVz
aW5nIGEgYml0IGxlbmd0aCBvZiA1MTIgZm9yIEZGREhFLCB0aGVuIHdlIHdpbGwKdHJpdmlhbGx5
IHBhc3MgU3RlcCAyIGZvciBhbGwgc3VwcG9ydGVkIEZGREhFIGdyb3VwcyAodGhlIG1heGltdW0K
c3ltbWV0cmljLWVxdWl2YWxlbnQgc3RyZW5ndGggZm9yIGZmZGhlODE5MiBpcyAxOTIgYml0cyku
CgpGcm9tIG15IHVuZGVyc3RhbmRpbmcsIHRoZSByYW5kb20gbnVtYmVyIGdlbmVyYXRvciB3aWxs
IGZpbGwgb3V0IGFsbAphdmFpbGFibGUgYnl0ZXMgaW4gdGhlIHN0cmluZyAoYW5kIG5vdGhpbmcg
bW9yZSksIHNvIHdlIHRyaXZpYWxseQpzYXRpc2Z5IHN0ZXAgMyBhbmQgNC4KCkFuZCBhcyBxIGlz
IGFsd2F5cyBsYXJnZXIgdGhhbiB0aGUgcmFuZG9tIG51bWJlciwgc3RlcCA2IHJlZHVjZXMgdG8K
J2lmIChjID4gMl5OIC0gMiknLCBpZSB3ZSBqdXN0IG5lZWQgdG8gY2hlY2sgaWYgdGhlIHJhbmRv
bSBudW1iZXIgaXMgYQpzdHJpbmcgb2YgMHhmZiBjaGFyYWN0ZXJzLiBXaGljaCBoYXJkbHkgaXMg
YSByYW5kb20gbnVtYmVyIGF0IGFsbCwgc28KaXQnbGwgYmUgaW1wb3NzaWJsZSB0byBnZXQgdGhp
cy4KCldoaWNoIHRoZW4gd291bGQgbWVhbiB0aGF0IG91ciAneCcgaXMgc2ltcGx5IHRoZSByYW5k
b20gbnVtYmVyICsgMSwKd2hpY2ggYXJndWFibHkgaXMgc2xpZ2h0bHkgcG9pbnRsZXNzIChvbmUg
bW9yZSB0aGFuIGEgcmFuZG9tIG51bWJlciBpcwphcyByYW5kb20gYXMgdGhlIG51bWJlciBpdHNl
bGYpLCBzbyBJIGRvIGZlZWwganVzdGlmaWVkIHdpdGgganVzdApyZXR1cm5pbmcgYSByYW5kb20g
bnVtYmVyIGhlcmUuCgpBbSBJIHdyb25nIHdpdGggdGhhdCByZWFzb25pbmc/CgpDaGVlcnMsCgpI
YW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2Ug
QXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMg
Njg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwg
OTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5k
w7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
