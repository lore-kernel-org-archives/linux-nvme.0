Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B9C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 16:32:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E999022A85
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 16:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E999022A85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5AZvghZoe0CqriwP4Vi3SFEaWpcjwbLu3U2n8o7aZ6M=; b=A4TUokmJh81l/6Z/IJY4I55QY
	mnybr1hB/S01UilcaAj5A52MyzrM1A8qkGvREvtrYeBxv0J8a5KobxQaTntYmlWHdfhMIEVV9o8X7
	X/QCKriqMh976kNCo+OmDGi6yOneGv9EmtQgX2nQt9wD2yHdjYyeEGiUYL9GApVLjktwcMcqEwYEF
	Yvzq3xIVKaET8dN3Vdt18JDA+/EoTZLgEXSAgV3MsfyE+C/i+u6Ygi9cwEpMnoV2JqRh+cRN7RCq6
	YCAIQu/D/J4/FPSarRUrCfkGLDzskSz56QdZdo7KjAq3P90CJjLHwSoG6GOfEfd6CBAmLruLyzYuI
	NYEAJkaUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klE0T-0007FJ-6k; Fri, 04 Dec 2020 16:32:29 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klE0Q-0007Eq-HA
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 16:32:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CF12AACC1;
 Fri,  4 Dec 2020 16:32:24 +0000 (UTC)
Subject: Re: [PATCH] nvme: re-read ANA log on NS CHANGED AEN
To: Keith Busch <kbusch@kernel.org>
References: <20201204150310.30434-1-hare@suse.de>
 <20201204152011.GB8868@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8930faf1-7af7-73c5-0a16-3869a6af1bcf@suse.de>
Date: Fri, 4 Dec 2020 17:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204152011.GB8868@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_113226_713837_A04D8AF4 
X-CRM114-Status: GOOD (  22.41  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvNC8yMCA0OjIwIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBGcmksIERlYyAwNCwg
MjAyMCBhdCAwNDowMzoxMFBNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IC0JZXJy
b3IgPSBudm1lX3BhcnNlX2FuYV9sb2coY3RybCwgJm5yX2NoYW5nZV9ncm91cHMsCj4+IC0JCQlu
dm1lX3VwZGF0ZV9hbmFfc3RhdGUpOwo+PiAtCWlmIChlcnJvcikKPj4gLQkJZ290byBvdXRfdW5s
b2NrOwo+PiArCS8qCj4+ICsJICogRG9uJ3QgdXBkYXRlIEFOQSBncm91cHMgaWYgdHJpZ2dlcmVk
IGJ5IGFuIE5TIENIQU5HRUQKPj4gKwkgKiBBRU47IHdlJ2xsIGJlIHJlc2Nhbm5pbmcgYWxsIG5h
bWVzcGFjZXMgYW55d2F5IGFmdGVyd2FyZHMuCj4+ICsJICovCj4+ICsJaWYgKCF0ZXN0X2JpdChO
Vk1FX0FFUl9OT1RJQ0VfTlNfQ0hBTkdFRCwgJmN0cmwtPmV2ZW50cykpIHsKPj4gKwkJZXJyb3Ig
PSBudm1lX3BhcnNlX2FuYV9sb2coY3RybCwgJm5yX2NoYW5nZV9ncm91cHMsCj4+ICsJCQkJCSAg
IG52bWVfdXBkYXRlX2FuYV9zdGF0ZSk7Cj4+ICsJCWlmIChlcnJvcikKPj4gKwkJCWdvdG8gb3V0
X3VubG9jazsKPj4gKwl9Cj4+ICAgCj4+ICAgCS8qCj4+ICAgCSAqIEluIHRoZW9yeSB3ZSBzaG91
bGQgaGF2ZSBhbiBBTkFUVCB0aW1lciBwZXIgZ3JvdXAgYXMgdGhleSBtaWdodCBlbnRlcgo+PiBA
QCAtNTU3LDYgKzU2MywxMCBAQCBzdGF0aWMgaW50IG52bWVfcmVhZF9hbmFfbG9nKHN0cnVjdCBu
dm1lX2N0cmwgKmN0cmwpCj4+ICAgCQlkZWxfdGltZXJfc3luYygmY3RybC0+YW5hdHRfdGltZXIp
Owo+PiAgIG91dF91bmxvY2s6Cj4+ICAgCW11dGV4X3VubG9jaygmY3RybC0+YW5hX2xvY2spOwo+
PiArCj4+ICsJaWYgKHRlc3RfYml0KE5WTUVfQUVSX05PVElDRV9OU19DSEFOR0VELCAmY3RybC0+
ZXZlbnRzKSkKPj4gKwkJbnZtZV9xdWV1ZV9zY2FuKGN0cmwpOwo+PiArCj4+ICAgCXJldHVybiBl
cnJvcjsKPj4gICB9Cj4gCj4gVGhlIHNjYW4gd29yayBjYW4gYmUgc3RhcnRlZCBmcm9tIG90aGVy
IGNvbnRleHRzIHRvbywgc28gdGhlcmUgYXJlIHNvbWUKPiB1bmZvcnR1bmF0ZSByYWNlcyBoZXJl
IGlmIG9uZSBvZiB0aG9zZSBvdGhlciBjb250ZXh0cyBjbGVhcnMgY3RybC0+ZXZlbnRzCj4gYmVm
b3JlIHRoZSBBTkEgd29yayBnZXRzIHRvIHNlZSBpdCwgd2hpY2ggdGhlbiBnZXRzIHlvdSBiYWNr
IHRvIGhhdmluZwo+IHVudXNhYmxlIG5hbWVzcGFjZXMgd2hlbiB0aGF0IHNjYW4gd29yayB1c2Vz
IGEgc3RhbGUgYW5hIGxvZy4KPiAKTWF5YmUgdGhpcyBvbiB0b3A/CgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCmluZGV4IDI3
YmUwNWVmMGVkNy4uODNlMjhmYjlmYmE0IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCkBAIC0xMTQsNiArMTE0LDEwIEBA
IHN0YXRpYyB2b2lkIG52bWVfc2V0X3F1ZXVlX2R5aW5nKHN0cnVjdCBudm1lX25zICpucykKCiAg
c3RhdGljIHZvaWQgbnZtZV9xdWV1ZV9zY2FuKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCiAgewor
I2lmZGVmIENPTkZJR19OVk1FX01VTFRJUEFUSAorICAgICAgIGlmIChjdHJsLT5hbmFfbG9nX2J1
ZikKKyAgICAgICAgICAgICAgIGZsdXNoX3dvcmsobnZtZV93cSwgJmN0cmwtPmFuYV93b3JrKTsK
KyNlbmRpZgogICAgICAgICAvKgogICAgICAgICAgKiBPbmx5IG5ldyBxdWV1ZSBzY2FuIHdvcmsg
d2hlbiBhZG1pbiBhbmQgSU8gcXVldWVzIGFyZSBib3RoIGFsaXZlCiAgICAgICAgICAqLwoKCkNo
ZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJu
ZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2Vz
Y2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
