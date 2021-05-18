Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE8C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:18:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAD861285
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAD861285
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HyndDG3IFleu5SvdYZXun745mGA46V6jT3N1xc0A4G0=; b=gVa7Dnwamwj5cRycBXd88NbAE
	dCW0iZJAwPDc492XahnHZwmcfbNqljzXLT0tVhfbbThv06/od7yFTMooSZvjvfQeRkjnaX1G27PLv
	QjE5PmyibAgzv13dj9EfcU94UFEKKbdwCGXD6K/MYohkFMuj7IskbZhB/hQFdMWawytaQ4P1mxjyr
	5FNz+prCWuXZvr8FgFIEpezjbGLRanTmx+rQBOxvMgmqAZraJaxKY8HN4LqNsM3rQkMTjWCkefZqg
	KRE/AYHLurhIH61RvYk8AfcbLSVnRabPQjUk1NZ5a8YRWRFIx+Gf8lnQbvaAHRClm9JR31QvFqIiX
	EvdaKPq/Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1litzb-00HHmu-5w; Tue, 18 May 2021 07:18:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litzW-00HHkt-IP
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 07:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=tJojJUPLzlfUy7sXkx8Fm6Ns9vvNlc4boQpeBbBv/hk=; b=oqdhJR8TfNf9VHN7G2CAjOi/EI
 /kZ69HCA0EAIfSrEV6uXms7QTpRaYp/hnEhyF7qIN+ExUeN9yW0ZVRNpj6s0fGu3hysmvCENikLmf
 LI6ajg6o45hFUnEv1XvhD4RAkkl9CKDvzRWhsVLEbhsHLAV6/Xf1OUFKH0vlCxvz9ALBP37tdTevd
 BOrJxyOeVU+2bJZvzcdY7Q+XObkSqdxzLgt8KMKPzLjwyeTj7TL9F2WsG2GHZAk+8N5lNQNTgzJJh
 45QemOpP/NDALbOLv7tn2A3tx4lLBoyuyxMQJYW5t0aguHdWJ7DGx/Hg16BicH4eOOtyrmmiSpwXs
 aBpdYVFQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litzT-00EOt2-VL
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 07:18:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 99956ACF5;
 Tue, 18 May 2021 07:18:06 +0000 (UTC)
Subject: Re: [PATCHv4] nvme: allow to re-attach namespaces after all paths are
 down
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210517081809.104813-1-hare@suse.de>
 <20210517152601.GA2709350@dhcp-10-100-145-180.wdc.com>
 <688618fa-a079-6d84-adf2-01ee36f95d76@suse.de>
 <20210517154942.GA2709391@dhcp-10-100-145-180.wdc.com>
 <4b32451c-2426-c86f-ebc6-9de74e0bbde6@grimberg.me>
 <20210517180144.GC2709391@dhcp-10-100-145-180.wdc.com>
 <21fc1351-51e2-2d66-d988-b07763a7ae5d@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <27b57524-11a6-5490-8687-91582e136a05@suse.de>
Date: Tue, 18 May 2021 09:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <21fc1351-51e2-2d66-d988-b07763a7ae5d@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_001808_173390_6E586190 
X-CRM114-Status: GOOD (  17.91  )
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

T24gNS8xNy8yMSA4OjIwIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4gVGhhdCBpcyBi
ZWNhdXNlIHdlIGtlZXAgdGhlIGRldmljZSBub2RlIGFyb3VuZCBldmVuIHRob3VnaCBpdCBkb2Vz
bid0Cj4+PiBoYXZlIGFueSBib3R0b20gZGV2aWNlcy4gV2hpY2ggaXMgd2hhdCBJIHRoaW5rIEhh
bm5lcyB0cmllZCB0byBmaXgKPj4+IGluIGFuIGVhcmxpZXIgcGF0Y2guCj4+Pgo+Pj4gQWxzbywg
aWYgYW4gTlZNIHN1YnN5c3RlbSBoYXBwZW5zIHRvIHJlY3ljbGUgbnNpZHMsIGl0IHdpbGwgdHJp
Z2dlcgo+Pj4gcHJldHR5IHN1cmVseS4gU28gSSdtIG5vdCBzdXJlIHRoaXMgaXMgYW4gb2JzY3Vy
ZSBjYXNlLi4uCj4+Cj4+IEknbSBub3QgdmVyeSBjb25jZXJuZWQgYmVjYXVzZSAoMSkgZGVsZXRp
bmcgYW4gaW4tdXNlIG5hbWVzcGFjZSBpcwo+PiBzdXJlbHkgYSB1c2VyIGVycm9yLCBhbmQgKDIp
IGl0IGN1cnJlbnRseSBkb2Vzbid0IHdvcmsgZWl0aGVyLCBhbmQgbm8KPj4gb25lJ3MgY29tcGxh
aW5lZCB5ZXQgQUZBSUsuCj4gCj4gWW91J3JlIG5vdCB3cm9uZy4gSXQncyBqdXN0IHRoYXQgb25l
IGVycm9yIChvbiBucyBYKSBjYW4gbWFuaWZlc3QgaW4KPiBvdGhlciBwb3RlbnRpYWxseSBjb21w
bGV0ZWx5IGRpZmZlcmVudCBuYW1lc3BhY2VzIGNyZWF0ZWQuIEkgZ3Vlc3MKPiB0aGlzIGtpbmQg
b2YgdGhpbmcgY2FuIGhhcHBlbiB3aGVuIG5zIGFkbWluaXN0cmF0aW9uIGlzIGRvbmUgYnkKPiBh
ZG1pblggKG9yIHNjcmlwdFgpIGFuZCB0aGUgbnMgbW91bnRpbmcgaXMgZG9uZSBieSB1c2VyWSB3
aGVyZSB3aGF0IGVhY2gKPiBpcyBkb2luZyBpcyB1bmtub3duIHRvIGVhY2ggb3RoZXIuCgpUaGlz
IGNhbiBvbmx5IGhhcHBlbiBpZiBOU0ZFQVQgYml0IDMgaXMgbm90IHNldCBhbmQgdGhlIG5hbWVz
cGFjZSBkb2VzIApub3QgcHJvdmlkZSBhIFVVSUQuClNvIGlmIHdlIGFyZSBjb25jZXJuZWQgYWJv
dXQgdGhhdCB3ZSBjYW4gcmVzdHJpY3QgbnZtZSBtdWx0aXBhdGhpbmcgdG8gCmV4Y2x1ZGUgdGhl
c2Ugc2NlbmFyaW9zLgpCdXQgaW4gYWxsIG90aGVyIGNhc2VzIENOUyAwMyBfaXNfIGlkZW50aWZ5
aW5nIHRoZSBuYW1lc3BhY2UsIGFuZCBjYW5ub3QgCmJlIHJlLXVzZWQgZm9yIG90aGVyIG5hbWVz
cGFjZXMuCkFuZCB3ZSBhcmUga2VlcGluZyBhIGNvcHkgb2YgQ05TIDAzIGluIG5zaGVhZCwgc28g
d2UnbGwgYmUgc2FmZSB0aGVyZS4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWlu
ZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAz
NjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZl
cgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
