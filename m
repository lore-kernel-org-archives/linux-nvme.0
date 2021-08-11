Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A8C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 05:58:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2B860F22
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 05:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D2B860F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sdSmenWX4p2RJBzfqKJzBm3T6lVb48U7OHseHuC3vtc=; b=WeEtJT6aM1mwMHqk7cup2t8iZT
	FBabaUSNAPLV3t+DxRW0oPhG/O73XA10D6afPK1vDi11pT+C929fkjZDoiJMzrleI45M72kVFzUTb
	oe1nCBkN0S9svkBu5ufAmGIRy1lmv1KulE3p2U9gWpnAS1Juks9RmBu74dupF+Rg4jIwGFNiFVegb
	SaRFRhx57cG/qopQ9pV65LWFjqTCUemd/5x7w0bvnXdQCDw+ipr8278Ie7DdSwKw9g3v7iRpFyZdm
	giC7foGfJLvywVN16de57k9zKfqDkfs19oJPnxc8j3ft33L3KiEoSa2evD/0pa9BGt9q1PSGiZQH1
	uQw8oryg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDhFG-005fvz-Q3; Wed, 11 Aug 2021 05:57:42 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDhFA-005fv4-Kv
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 05:57:40 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB69B20107;
 Wed, 11 Aug 2021 05:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628661454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oVlfmojhP1VKbUc1oJoNsFUWAdYnTN2i6sVfH7jUz0=;
 b=hd3+O3kSdPcSNYP4w9t3VogbYZB23QtnFEnyhGj+qNZUKBc1nzq9/vXNy0STKyjItZ+bv2
 9PxbkX7KDaWHUn+ep5uey8ieS/x+0AVkLvc03DpEjYlD3CnPHlVv2zG8wtYIcSh6pGzZiU
 ED11s29jZZpsh5k5q7pnw10KixMPHtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628661454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oVlfmojhP1VKbUc1oJoNsFUWAdYnTN2i6sVfH7jUz0=;
 b=JSkV3FFcnOtD9EdLnT74bkcchYXL9SCc5lWjc3+U6YFbzNkDyIkU/O3SlwG3ZmmAGjHoFD
 oQfMPjzKrn7clTBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 62D74137DA;
 Wed, 11 Aug 2021 05:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id x0N8Fs5mE2GoTgAAGKfGzw
 (envelope-from <hare@suse.de>); Wed, 11 Aug 2021 05:57:34 +0000
Subject: Re: [PATCH 04/13] lib/base64: RFC4648-compliant base64 encoding
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210810124230.12161-1-hare@suse.de>
 <20210810124230.12161-5-hare@suse.de> <YRLP5JuQrF/SJPBt@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f3fc5af2-835c-4cb4-4715-9c95a359002c@suse.de>
Date: Wed, 11 Aug 2021 07:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRLP5JuQrF/SJPBt@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_225736_906424_45429318 
X-CRM114-Status: GOOD (  30.71  )
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

T24gOC8xMC8yMSA5OjEzIFBNLCBFcmljIEJpZ2dlcnMgd3JvdGU6Cj4gT24gVHVlLCBBdWcgMTAs
IDIwMjEgYXQgMDI6NDI6MjFQTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBBZGQg
UkZDNDY0OC1jb21wbGlhbnQgYmFzZTY0IGVuY29kaW5nIGFuZCBkZWNvZGluZyByb3V0aW5lcy4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+Cj4+IC0t
LQo+PiAgIGluY2x1ZGUvbGludXgvYmFzZTY0LmggfCAgMTYgKysrKysrCj4+ICAgbGliL01ha2Vm
aWxlICAgICAgICAgICB8ICAgMiArLQo+PiAgIGxpYi9iYXNlNjQuYyAgICAgICAgICAgfCAxMTUg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gICAzIGZpbGVzIGNo
YW5nZWQsIDEzMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvbGludXgvYmFzZTY0LmgKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgbGli
L2Jhc2U2NC5jCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jhc2U2NC5oIGIvaW5j
bHVkZS9saW51eC9iYXNlNjQuaAo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAwMDAw
MDAwMDAwMDAuLjY2MGQ0Y2IxZWYzMQo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2luY2x1ZGUv
bGludXgvYmFzZTY0LmgKPj4gQEAgLTAsMCArMSwxNiBAQAo+PiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAKPj4gKy8qCj4+ICsgKiBiYXNlNjQgZW5jb2RpbmcsIGxpZnRlZCBm
cm9tIGZzL2NyeXB0by9mbmFtZS5jLgo+PiArICovCj4gCj4gQXMgSSBtZW50aW9uZWQgcHJldmlv
dXNseSwgcGxlYXNlIG1ha2UgaXQgdmVyeSBjbGVhciB3aGljaCB2YXJpYW50IG9mIEJhc2U2NCBp
dAo+IGlzIChpbmNsdWRpbmcgd2hldGhlciBwYWRkaW5nIGlzIGluY2x1ZGVkIGFuZCByZXF1aXJl
ZCBvciBub3QpLCBhbmQgdXBkYXRlIGFsbAo+IHRoZSBjb21tZW50cyBhY2NvcmRpbmdseS4gIEkn
dmUgZG9uZSBzbyBpbiBmcy9jcnlwdG8vZm5hbWUuYyB3aXRoCj4gaHR0cHM6Ly9sa21sLmtlcm5l
bC5vcmcvci8yMDIxMDcxODAwMDEyNS41OTcwMS0xLWViaWdnZXJzQGtlcm5lbC5vcmcuICBJdCB3
b3VsZAo+IHByb2JhYmx5IGJlIGJlc3QgdG8gc3RhcnQgb3ZlciB3aXRoIGEgY29weSBvZiB0aGF0
IGFuZCBtb2RpZnkgaXQgYWNjb3JkaW5nbHkgdG8KPiBpbXBsZW1lbnQgdGhlIGRlc2lyZWQgdmFy
aWFudCBvZiBCYXNlNjQuCj4gCkhtbS4gTG9va2luZyBpbnRvIGl0LgoKPj4gKy8qKgo+PiArICog
YmFzZTY0X2RlY29kZSgpIC0gYmFzZTY0LWRlY29kZSBzb21lIGJ5dGVzCj4+ICsgKiBAc3JjOiB0
aGUgYmFzZTY0LWVuY29kZWQgc3RyaW5nIHRvIGRlY29kZQo+PiArICogQGxlbjogbnVtYmVyIG9m
IGJ5dGVzIHRvIGRlY29kZQo+PiArICogQGRzdDogKG91dHB1dCkgdGhlIGRlY29kZWQgYnl0ZXMu
Cj4gCj4gIkBsZW46IG51bWJlciBvZiBieXRlcyB0byBkZWNvZGUiIGlzIGFtYmlndW91cyBhcyBp
dCBjb3VsZCByZWZlciB0byBlaXRoZXIgQHNyYwo+IG9yIEBkc3QuICBJJ3ZlIGZpeGVkIHRoaXMg
aW4gdGhlIGZzL2NyeXB0by9mbmFtZS5jIHZlcnNpb24uCj4gCgpPaywgd2lsbCBiZSB1cGRhdGlu
Zy4KCj4+ICsgKgo+PiArICogRGVjb2RlcyB0aGUgYmFzZTY0LWVuY29kZWQgYnl0ZXMgQHNyYyBh
Y2NvcmRpbmcgdG8gUkZDIDQ2NDguCj4+ICsgKgo+PiArICogUmV0dXJuOiBudW1iZXIgb2YgZGVj
b2RlZCBieXRlcwo+PiArICovCj4gCj4gU2hvdWxkbid0IHRoaXMgcmV0dXJuIGFuIGVycm9yIGlm
IHRoZSBzdHJpbmcgaXMgaW52YWxpZD8gIEFnYWluLCBzZWUgdGhlIGxhdGVzdAo+IGZzL2NyeXB0
by9mbmFtZS5jIHZlcnNpb24uCj4gCgpJbmRlZWQsIGl0IHNob3VsZC4gV2lsbCBiZSBmaXhpbmcg
aXQgdXAuCgo+PiAraW50IGJhc2U2NF9kZWNvZGUoY29uc3QgY2hhciAqc3JjLCBpbnQgbGVuLCB1
OCAqZHN0KQo+PiArewo+PiArICAgICAgICBpbnQgaSwgYml0cyA9IDAsIHBhZCA9IDA7Cj4+ICsg
ICAgICAgIHUzMiBhYyA9IDA7Cj4+ICsgICAgICAgIHNpemVfdCBkc3RfbGVuID0gMDsKPj4gKwo+
PiArICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbGVuOyBpKyspIHsKPj4gKyAgICAgICAgICAgICAg
ICBpbnQgYywgcCA9IC0xOwo+PiArCj4+ICsgICAgICAgICAgICAgICAgaWYgKHNyY1tpXSA9PSAn
PScpIHsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHBhZCsrOwo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKGkgKyAxIDwgbGVuICYmIHNyY1tpICsgMV0gPT0gJz0nKQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWQrKzsKPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOwo+PiArICAgICAgICAgICAgICAgIH0KPj4gKyAgICAgICAgICAgICAgICBm
b3IgKGMgPSAwOyBjIDwgc3RybGVuKGxvb2t1cF90YWJsZSk7IGMrKykgewo+IAo+IHN0cmxlbigp
IHNob3VsZG4ndCBiZSB1c2VkIGluIGEgbG9vcCBjb25kaXRpb24gbGlrZSB0aGlzLgo+IApXaHkg
bm90PwonbG9va3VwX3RhYmxlJyBpcyBwcmV0dHkgbXVjaCBzdGF0aWMsIHNvIHdoZXJlJ3QgdGhl
IHByb2JsZW0/CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
