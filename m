Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3552C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 11:32:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6B560FF2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 11:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6B560FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zWFy6fc+X1gfpuqz+4St0jRKPgX1qdhAX6ixGuwJZ4I=; b=1f0d4QuE3IsCfhWfTdh84txai2
	b3Ki8Ym9mwATMfJcuzRjUDjLOscLDqJ9PBP7zfrJ88PQ6L9jK169SyivnteDtjT1e7+Oag7I4N5Yn
	AlCZBMMRtoDYhDZI3AXAre4nZBE3bJEK2wsnqX9ThPTZGl/gz08vbG4aLPQL6CTSPT46RYIKnRirG
	sNVuXSG+t0LXZ2gtFRtHLY4jKNb6kvkyozSgQfywXGz7m/1kZkiNAVBWMWO8qavYAm6PGfZUyWk0p
	EueX8oegRoCQnj4bFTKkDixGMFGnlHOTmf15mYezq+dtINjcTZM14NLYoBF8+BQNXq18meFsqgdX7
	S9jCsPRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5nyY-00CfLX-1e; Tue, 20 Jul 2021 11:31:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5nyU-00CfL4-OZ
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 11:31:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1997D2245C;
 Tue, 20 Jul 2021 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626780705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKJuwvlbpq9y+50Lzz2FJYdnyQhvoYmQQwpN1Z2oGU0=;
 b=Zls6/hODZeTBb1YVm/s2efgmc4zBk1AYen7YCXkhWilqZLrqpSvpnaufNW6fxk+TKN1W4G
 UmOzKtOlxLdNEfaqhmS6J10J1KALf+XNMo+6u7jyPMT/bGkz4ztB/c1eVQ2X7Hf++LhxTb
 QUAp1bBE19M1rgVzfhOlCJ9qS9tZ7Qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626780705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKJuwvlbpq9y+50Lzz2FJYdnyQhvoYmQQwpN1Z2oGU0=;
 b=eEuGuzxiemKWNC577WViXUvTomRFMaoVL/PIS1rouPvlw/tRlCrI36/aw9wLILCT2zWFKX
 SlVzff6dZ4hm8sDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00F7E13C8A;
 Tue, 20 Jul 2021 11:31:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TuUIOyC09mAdUgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 11:31:44 +0000
To: Simo Sorce <simo@redhat.com>, Stephan Mueller <smueller@chronox.de>,
 Christoph Hellwig <hch@lst.de>
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
 <aac9448e-29e9-6d03-1077-148be3c10f50@suse.de>
 <11ab4001f580a6b2c3cce959282259c1f9095f63.camel@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
Message-ID: <4cd673a8-a503-c29a-85f6-3c2703558181@suse.de>
Date: Tue, 20 Jul 2021 13:31:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <11ab4001f580a6b2c3cce959282259c1f9095f63.camel@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_043147_003915_71671826 
X-CRM114-Status: GOOD (  36.54  )
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

T24gNy8yMC8yMSAxMjo0OSBQTSwgU2ltbyBTb3JjZSB3cm90ZToKPiBPbiBUdWUsIDIwMjEtMDct
MjAgYXQgMTI6MTQgKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gNy8xOS8yMSAx
OjUyIFBNLCBTdGVwaGFuIE11ZWxsZXIgd3JvdGU6Cj4+PiBBbSBNb250YWcsIGRlbSAxOS4wNy4y
MDIxIHVtIDEzOjEwICswMjAwIHNjaHJpZWIgSGFubmVzIFJlaW5lY2tlOgo+Pj4+IE9uIDcvMTkv
MjEgMTI6MTkgUE0sIFN0ZXBoYW4gTXVlbGxlciB3cm90ZToKPj4+Pj4gQW0gTW9udGFnLCBkZW0g
MTkuMDcuMjAyMSB1bSAxMTo1NyArMDIwMCBzY2hyaWViIEhhbm5lcyBSZWluZWNrZToKPj4+Pj4+
IE9uIDcvMTkvMjEgMTA6NTEgQU0sIFN0ZXBoYW4gTXVlbGxlciB3cm90ZToKPj4gWyAuLiBdCj4+
Pj4+Pj4KPj4+Pj4+PiBUaGFuayB5b3UgZm9yIGNsYXJpZnlpbmcgdGhhdC4gSXQgc291bmRzIHRv
IG1lIHRoYXQgdGhlcmUgaXMgbm8KPj4+Pj4+PiBkZWZpbmVkIHByb3RvY29sIChvciBpZiB0aGVy
ZSwgSSB3b3VsZCBiZSB3b25kZXJpbmcgaG93IHRoZSBjb2RlIHdvdWxkIGhhdmUKPj4+Pj4+PiB3
b3JrZWQKPj4+Pj4+PiB3aXRoIGEgZGlmZmVyZW50IGltcGxlbWVudGF0aW9uKS4gV291bGQgaXQg
bWFrZSBzZW5zZSB0byBmaXJzdCBzcGVjaWZ5Cj4+Pj4+Pj4gYSBwcm90b2NvbCBmb3IgYXV0aGVu
dGljYXRpb24gYW5kIGhhdmUgaXQgZGlzY3Vzc2VkPyBJIHBlcnNvbmFsbHkgdGhpbmsKPj4+Pj4+
PiBpdCBpcyBhIGJpdCBkaWZmaWN1bHQgdG8gZnVsbHkgdW5kZXJzdGFuZCB0aGUgcHJvdG9jb2wg
ZnJvbSB0aGUgY29kZSBhbmQKPj4+Pj4+PiBkaXNjdXNzIHByb3RvY29sLWxldmVsIGl0ZW1zIGJh
c2VkIG9uIHRoZSBjb2RlLgo+Pj4+Pj4+Cj4+Pj4+PiBPaCwgdGhlIHByb3RvY29sIF9pc18gc3Bl
Y2lmaWVkOgo+Pj4+Pj4KPj4+Pj4+ICAKPj4+Pj4+IGh0dHBzOi8vbnZtZXhwcmVzcy5vcmcvd3At
Y29udGVudC91cGxvYWRzL05WTS1FeHByZXNzLUJhc2UtU3BlY2lmaWNhdGlvbi0yXzAtMjAyMS4w
Ni4wMi1SYXRpZmllZC01LnBkZgo+Pj4+Pj4KPj4+Pj4+IEl0J3MganVzdCB0aGF0IEkgaGF2ZSBp
c3N1ZXMgdHJhbnNsYXRpbmcgdGhhdCBzcGVjIG9udG8gd2hhdCB0aGUga2VybmVsCj4+Pj4+PiBw
cm92aWRlcy4KPj4+Pj4KPj4+Pj4gYWNjb3JkaW5nIHRvIHRoZSBuYW1pbmcgY29udmVudGlvbnMg
dGhlcmUgaW4gZmlndXJlcyA0NDcgYW5kIGZvbGxvd2luZzoKPj4+Pj4KPj4+Pj4gLSB4IGFuZCB5
OiBESCBwcml2YXRlIGtleSAoa2VybmVsIGNhbGxzIGl0IHNlY3JldCBzZXQgd2l0aCBkaF9zZXRf
c2VjcmV0Cj4+Pj4+IG9yCj4+Pj4+IGVuY29kZWQgaW50byBwYXJhbS5rZXkpCj4+Pj4+Cj4+Pj4K
Pj4+PiBCdXQgdGhhdCdzIHdlcmUgSSBnb3QgY29uZnVzZWQ7IG9uZSBuZWVkcyBhIHByaXZhdGUg
a2V5IGhlcmUsIGJ1dCB0aGVyZQo+Pj4+IGlzIG5vIG9idmlvdXMgY2FuZGlkYXRlIGZvciBpdC4g
QnV0IHJlYWRpbmcgaXQgbW9yZSBjbG9zZWx5IEkgZ3Vlc3MgdGhlCj4+Pj4gcHJpdmF0ZSBrZXkg
aXMganVzdCBhIHJhbmRvbSBudW1iZXIgKGNmIHRoZSBzcGVjOiBnXnkgbW9kIHAsIHdoZXJlIHkg
aXMKPj4+PiBhIHJhbmRvbSBudW1iZXIgc2VsZWN0ZWQgYnkgdGhlIGhvc3QgdGhhdCBzaGFsbCBi
ZSBhdCBsZWFzdCAyNTYgYml0cwo+Pj4+IGxvbmcpLiBTbyBJJ2xsIGZpeCBpdCB1cCB3aXRoIHRo
ZSBuZXh0IHJvdW5kLgo+Pj4KPj4+IEhlcmUgY29tZXMgdGhlIGNydXg6IHRoZSBrZXJuZWwgaGFz
IGFuIEVDQyBwcml2YXRlIGtleSBnZW5lcmF0aW9uIGZ1bmN0aW9uCj4+PiBlY2RoX3NldF9zZWNy
ZXQgdHJpZ2dlcmVkIHdpdGggY3J5cHRvX2twcF9zZXRfc2VjcmV0IHVzaW5nIGEgTlVMTCBrZXks
IGJ1dCBpdAo+Pj4gaGFzIG5vIEZGQy1ESCBjb3VudGVycGFydC4KPj4+Cj4+PiBUaGF0IHNhaWQs
IGdlbmVyYXRpbmcgYSByYW5kb20gbnVtYmVyIGlzIHRoZSBtb3N0IG9idmlvdXMgY2hvaWNlLCBi
dXQgbm90IHRoZQo+Pj4gcmlnaHQgb25lLgo+Pj4KPj4+IFRoZSBjb3JyZWN0IG9uZSB3b3VsZCBi
ZSBmb2xsb3dpbmcgU1A4MDAtNTZBIHJldiAzIGFuZCBoZXJlIGVpdGhlciBzZWN0aW9uCj4+PiA1
LjYuMS4xLjMgb3IgNS42LjEuMS40Lgo+Pj4KPj4gSG1tLiBPa2F5LiBCdXQgYWZ0ZXIgaGF2aW5n
IHJlYWQgc2VjdGlvbiA1LjYuMS4xLjQsIEkgc3RpbGwgZG8gaGF2ZSBzb21lCj4+IHF1ZXN0aW9u
cy4KPj4KPj4gQXNzdW1lIHdlIHdpbGwgYmUgdXNpbmcgYSBiaXQgbGVuZ3RoIG9mIDUxMiBmb3Ig
RkZESEUsIHRoZW4gd2Ugd2lsbAo+PiB0cml2aWFsbHkgcGFzcyBTdGVwIDIgZm9yIGFsbCBzdXBw
b3J0ZWQgRkZESEUgZ3JvdXBzICh0aGUgbWF4aW11bQo+PiBzeW1tZXRyaWMtZXF1aXZhbGVudCBz
dHJlbmd0aCBmb3IgZmZkaGU4MTkyIGlzIDE5MiBiaXRzKS4KPiAKPiBOID0gNTEyIGlzIG5vdCBh
IGdvb2QgY2hvaWNlLCBtaW5pbXVtIGxlbmd0aCB0aGVzZSBkYXlzIGZvciBESCBzaG91bGQKPiBi
ZSAyMDQ4IG9yIG1vcmUuCj4gCgpBY2NvcmRpbmcgdG8gUkZDNzkxOToKUGVlcnMgdXNpbmcgZmZk
aGU4MTkyIHRoYXQgd2FudCB0byBvcHRpbWl6ZSB0aGVpciBrZXkgZXhjaGFuZ2Ugd2l0aCBhCnNo
b3J0IGV4cG9uZW50IChTZWN0aW9uIDUuMikgc2hvdWxkIGNob29zZSBhIHNlY3JldCBrZXkgb2Yg
YXQgbGVhc3QKNDAwIGJpdHMuCgpTbyB3aGF0IGlzIHdyb25nIHdpdGggNTEyIGJpdHM/Cgo+PiBG
cm9tIG15IHVuZGVyc3RhbmRpbmcsIHRoZSByYW5kb20gbnVtYmVyIGdlbmVyYXRvciB3aWxsIGZp
bGwgb3V0IGFsbAo+PiBhdmFpbGFibGUgYnl0ZXMgaW4gdGhlIHN0cmluZyAoYW5kIG5vdGhpbmcg
bW9yZSksIHNvIHdlIHRyaXZpYWxseQo+PiBzYXRpc2Z5IHN0ZXAgMyBhbmQgNC4KPj4KPj4gQW5k
IGFzIHEgaXMgYWx3YXlzIGxhcmdlciB0aGFuIHRoZSByYW5kb20gbnVtYmVyLCBzdGVwIDYgcmVk
dWNlcyB0bwo+PiAnaWYgKGMgPiAyXk4gLSAyKScsCj4gCj4gV2hlcmUgaXMgdGhpcyBjb21pbmcg
ZnJvbSA/Cj4gSXQgc2VlbSB5b3UgYXNzdW1lIE0gPSAyXk4gYnV0IE0gPSBtaW4oMl5OLCBxKQo+
IAo+IFRoZSBwb2ludCBoZXJlIGlzIHRvIG1ha2Ugc3VyZSB0aGUgbnVtYmVyIFggeW91IHJldHVy
biBpczoKPiAwIDwgWCA8IChxLTEpCj4gCgpXaGljaCBpcyB3aGF0IEkndmUgdHJpZWQgdG8gYXJn
dWUuIEZvciA1MTIgYml0cyBwcml2YXRlIGtleSBhbmQgdGhlCnNtYWxsZXN0IHBvc3NpYmxlIEZG
REhFIGdyb3VwICh3aGljaCBoYXMgMjA0OCBiaXRzLCB3aXRoIHRoZSB0b3AgYml0Cm5vbi16ZXJv
KSAyXk4gaXMgYWx3YXlzIHNtYWxsZXIgdGhhbiAocSAtIDEpLgpBcyB0aGUgb3RoZXIgRkZIREUg
Z3JvdXBzIGFyZSB1c2luZyBldmVuIGxhcmdlciAncScgdmFsdWVzLCB0aGlzIGlzIHRydWUKZm9y
IGFsbCBGRkhERSBncm91cHMuCgo+PiAgaWUgd2UganVzdCBuZWVkIHRvIGNoZWNrIGlmIHRoZSBy
YW5kb20gbnVtYmVyIGlzIGEKPj4gc3RyaW5nIG9mIDB4ZmYgY2hhcmFjdGVycy4gV2hpY2ggaGFy
ZGx5IGlzIGEgcmFuZG9tIG51bWJlciBhdCBhbGwsIHNvCj4+IGl0J2xsIGJlIGltcG9zc2libGUg
dG8gZ2V0IHRoaXMuCj4+Cj4+IFdoaWNoIHRoZW4gd291bGQgbWVhbiB0aGF0IG91ciAneCcgaXMg
c2ltcGx5IHRoZSByYW5kb20gbnVtYmVyICsgMSwKPiAKPiBUaGlzIGlzIGFuIGFydGlmYWN0IGR1
ZSB0byB0aGUgcmFuZG9tIG51bWJlciBiZWluZyAwIDw9IGMgPCAyXk4gLSAxLAo+IHRoZXJlZm9y
ZSAxIG5lZWRzIHRvIGJlIGFkZGVkIHRvIG1ha2Ugc3VyZSB5b3UgbmV2ZXIgcmV0dXJuIDAuCj4g
CgpBbmQgbXkgYXJndW1lbnQgaGVyZSBpcyB0aGF0IGFsbCB6ZXJvcyAoYW5kIGFsbCBvbmVzKSBh
cmUgbm90IGEgdmFsdWUgSQp3b3VsZCBleHBlY3QgZnJvbSBvdXIgUk5HLgoKPj4gd2hpY2ggYXJn
dWFibHkgaXMgc2xpZ2h0bHkgcG9pbnRsZXNzIChvbmUgbW9yZSB0aGFuIGEgcmFuZG9tIG51bWJl
ciBpcwo+PiBhcyByYW5kb20gYXMgdGhlIG51bWJlciBpdHNlbGYpLCBzbyBJIGRvIGZlZWwganVz
dGlmaWVkIHdpdGgganVzdAo+PiByZXR1cm5pbmcgYSByYW5kb20gbnVtYmVyIGhlcmUuCj4+Cj4+
IEFtIEkgd3Jvbmcgd2l0aCB0aGF0IHJlYXNvbmluZz8KPiAKPiBMb29rcyB0byBtZSB5b3UgYXJl
IG5vdCBhY2NvdW50aW5nIGZvciB0aGUgZmFjdCB0aGF0IE4gPSA1MTIgaXMgdG9vCj4gc21hbGwg
YW5kIGEgcmFuZG9tIG51bWJlciBmYWxsaW5nIGluIHRoZSBpbnRlcnZhbCAocSAtIDIpIDwgWCA8
IDJeTiBpcwo+IHVuc3VpdGFibGU/Cj4gCgpPbmx5IGlmIChxIC0gMikgPCAyXk4uIEFuZCBteSBw
b2ludCBpcyB0aGF0IGl0J3Mgbm90LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJl
aW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJ
CQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
