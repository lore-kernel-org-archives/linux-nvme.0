Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C3BC11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 08:00:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECE8613B5
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 08:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECE8613B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oODBp+lYyhbTFxX3V2T28Igabhb4QdbGtxgY/CKnOOk=; b=dXizUR2vE+4qgPvr2nPm8vf1Gy
	1ZR8I7q1dBk6ZhxsD98TliJz2vmJLZfRNvAnT3UZ8C13GwS1WB4+cUjDnek0+I8V2ilWAWcDWLx8n
	lZhnJ5O+rXACGNS2iicga7jkX54NHlAo21BINdytIcBd2/Juqgo5jFQgDSqXtyzBeDP7niny6rtH1
	8dmscEJgyistbkEmD+ghYd8aYQSRfwz1j4WVbZiq723BRmbIIeVVfClmVL5gUPUeA/yQFIjWnlCn5
	SDz2UsRz6xmBD0RBW2EusEG6PRm1nX5EzZTsVSdSsyc5eMSWSy6ztIHmrxjRJNoNtHjK6msmDvUwP
	UZVBXCag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyrch-00GSZY-Nh; Thu, 01 Jul 2021 08:00:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyrce-00GSYT-Nw
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 08:00:34 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA3831FF83;
 Thu,  1 Jul 2021 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625126430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xu5YUbI3OC/pK+LofYl5biLJ3jiA/0IbxgNEllDpcrw=;
 b=SU3S6cAqZY/uad+f4m4Z/rrw3/eqMV0dHoKcOkWRvETFCy1CX+H1o0EgrRE368XOsTvXzg
 GDy0BjFni0n3P0KnRx+dwRiSAZ4vw7YsMeP4W5imhNTRUdNnHO+DiIRDHWkAI6RNYJAowX
 o/V+DNFgLuiFjG9z6d0ITUlVbGYAPHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625126430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xu5YUbI3OC/pK+LofYl5biLJ3jiA/0IbxgNEllDpcrw=;
 b=XplvibhW/d0RhjgNllxiFUj0n9JyyInx5EQRCMY4z5E3IWo05J6JAtRaXwnRJvn/6XuQHZ
 Oz/u0YZGqvSlIxAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id A19D3118DD;
 Thu,  1 Jul 2021 08:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625126430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xu5YUbI3OC/pK+LofYl5biLJ3jiA/0IbxgNEllDpcrw=;
 b=SU3S6cAqZY/uad+f4m4Z/rrw3/eqMV0dHoKcOkWRvETFCy1CX+H1o0EgrRE368XOsTvXzg
 GDy0BjFni0n3P0KnRx+dwRiSAZ4vw7YsMeP4W5imhNTRUdNnHO+DiIRDHWkAI6RNYJAowX
 o/V+DNFgLuiFjG9z6d0ITUlVbGYAPHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625126430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xu5YUbI3OC/pK+LofYl5biLJ3jiA/0IbxgNEllDpcrw=;
 b=XplvibhW/d0RhjgNllxiFUj0n9JyyInx5EQRCMY4z5E3IWo05J6JAtRaXwnRJvn/6XuQHZ
 Oz/u0YZGqvSlIxAA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id n9KjGxx23WCofAAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 01 Jul 2021 08:00:28 +0000
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
To: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de> <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de> <YNw/DcxIIMeg/2VK@T590>
 <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
 <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de> <YN0FXrcwXfAwGU6w@T590>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c3a3a25b-a36b-e20d-6f7f-828f22650a30@suse.de>
Date: Thu, 1 Jul 2021 10:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YN0FXrcwXfAwGU6w@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_010032_981504_3A1F160B 
X-CRM114-Status: GOOD (  26.31  )
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

T24gNy8xLzIxIDE6NTkgQU0sIE1pbmcgTGVpIHdyb3RlOgo+IE9uIFdlZCwgSnVuIDMwLCAyMDIx
IGF0IDA5OjQ2OjM1UE0gKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gNi8zMC8y
MSA4OjU5IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4KPj4+Pj4+PiBTaG91bGRuJ3Qgd2Ug
cmF0aGVyIG1vZGlmeSB0aGUgdGFnc2V0IHRvIG9ubHkgcmVmZXIgdG8KPj4+Pj4+PiB0aGUgY3Vy
cmVudCBvbmxpbmUKPj4+Pj4+PiBDUFVzIF9vbmx5XywgdGhlcmVieSBuZXZlciBzdWJtaXQgYSBj
b25uZWN0IHJlcXVlc3QgZm9yIGhjdHggd2l0aCBvbmx5Cj4+Pj4+Pj4gb2ZmbGluZSBDUFVzPwo+
Pj4+Pj4KPj4+Pj4+IFRoZW4geW91IG1heSBzZXR1cCB2ZXJ5IGxlc3MgaW8gcXVldWVzLCBhbmQg
cGVyZm9ybWFuY2UgbWF5IHN1ZmZlciBldmVuCj4+Pj4+PiB0aG91Z2ggbG90cyBvZiBDUFVzIGJl
Y29tZSBvbmxpbmUgbGF0ZXIuCj4+Pj4+PiA7Cj4+Pj4+IE9ubHkgaWYgd2Ugc3RheSB3aXRoIHRo
ZSByZWR1Y2VkIG51bWJlciBvZiBJL08gcXVldWVzLiBXaGljaCBpcwo+Pj4+PiBub3Qgd2hhdCBJ
J20KPj4+Pj4gcHJvcG9zaW5nOyBJJ2QgcmF0aGVyIHByZWZlciB0byBjb25uZWN0IGFuZCBkaXNj
b25uZWN0IHF1ZXVlcwo+Pj4+PiBmcm9tIHRoZSBjcHUKPj4+Pj4gaG90cGx1ZyBoYW5kbGVyLiBG
b3Igc3RhcnRlcnMgd2UgY291bGQgZXZlbiB0cmlnZ2VyIGEgcmVzZXQgb25jZQo+Pj4+PiB0aGUg
Zmlyc3QKPj4+Pj4gY3B1IHdpdGhpbiBhIGhjdHggaXMgb25saW5lZC4KPj4+Pgo+Pj4+IFllYWgs
IHRoYXQgbmVlZCBvbmUgYmlnL2NvbXBsaWNhdGVkIHBhdGNoc2V0LCBidXQgbm90IHNlZSBhbnkg
YWR2YW50YWdlcwo+Pj4+IG92ZXIgdGhpcyBzaW1wbGUgYXBwcm9hY2guCj4+Pgo+Pj4gSSB0ZW5k
IHRvIGFncmVlIHdpdGggTWluZyBoZXJlLgo+Pgo+PiBBY3R1YWxseSwgRGFuaWVsIGFuZCBtZSBj
YW1lIHRvIGEgc2xpZ2h0bHkgZGlmZmVyZW50IGlkZWE6IHVzZSBjcHUgaG90cGx1Zwo+PiBub3Rp
Zmllci4KPj4gVGhpbmcgaXMsIGJsay1tcSBhbHJlYWR5IGhhcyBjcHUgaG90cGx1ZyBub3RpZmll
ciwgd2hpY2ggc2hvdWxkIGVuc3VyZSB0aGF0Cj4+IG5vIEkvTyBpcyBwZW5kaW5nIGR1cmluZyBj
cHUgaG90cGx1Zy4KPiAKPiBXaHkgc2hvdWxkIHdlIGVuc3VyZSB0aGF0IGZvciBub24tbWFuYWdl
ZCBpcnE/Cj4gCgpXaGlsZSBub3Qgc3RyaWN0bHkgbmVjZXNzYXJ5LCBpdCBkb2VzIGFsaWduIHRo
ZSBoY3R4IGxheW91dCB3aXRoIHRoZSAKY3VycmVudCBDUFUgdG9wb2xvZ3kuCkFzIHN1Y2ggd2Ug
d29uJ3QgaGF2ZSBhbnkgJ3N0YWxlJyBDUFVzIG9yIHF1ZXVlcyBpbiB0aGUgaGN0eCBsYXlvdXQs
IGFuZCAKd2l0aCB0aGF0IGF2b2lkIGFueSBpc3N1ZXMgd2UnbGwgYmUgaGF2aW5nIGR1ZSB0byBp
bmFjdGl2ZSBDUFVzIGluIHRoZSAKY3B1bWFzay4KCj4+IElmIHdlIG5vdyBhZGQgYSBudm1lIGNw
dSBob3RwbHVnIG5vdGlmaWVyIHdoaWNoIGVzc2VudGlhbGx5IGtpY2tzIG9mZiBhCj4+IHJlc2V0
IG9uY2UgYWxsIGNwdSBpbiBhIGhjdHggYXJlIG9mZmxpbmUgdGhlIHJlc2V0IGxvZ2ljIHdpbGwg
cmVhcnJhbmdlIHRoZQo+PiBxdWV1ZXMgdG8gbWF0Y2ggdGhlIGN1cnJlbnQgY3B1IGxheW91dC4K
Pj4gQW5kIHdoZW4gdGhlIGNwdXMgYXJlIGdldHRpbmcgb25saW5lZCB3ZSdsbCBkbyBhbm90aGVy
IHJlc2V0Lgo+Pgo+PiBEYW5pZWwgaXMgY3VycmVudGx5IHByZXBhcmluZyBhIHBhdGNoOyBsZXQn
cyBzZWUgaG93IGl0IGdvZXMuCj4gCj4gV2hhdCBpcyB0aGUgYWR2YW50YWdlIG9mIHRoYXQgYmln
IGNoYW5nZSBvdmVyIHRoaXMgc2ltcGxlIHdheT8KPiAKCldpdGggdGhlIHNpbXBsZSB3YXkgd2Ug
bWlnaHQgKGFuZCwgYXMgdGhlIHJlc3VsdHMgc2hvdywgZG8pIHJ1biB0aGUgCm52bWVfY3RybF9y
ZXNldCgpIGluIHBhcmFsbGVsIHRvIENQVSBob3RwbHVnLgpUaGlzIGxlYWRzIHRvIHF1aXRlIHNv
bWUgY29tcGxleGl0eSwgYW5kIGFzIHdlJ3ZlIHNlZW4gaXMgdHJpZ2dlcmluZyAKcXVpdGUgc29t
ZSByYWNlIGNvbmRpdGlvbnMuCgpIZW5jZSBJIGRvIHRoaW5rIHdlIG5lZWQgdG8gc3luY2hyb25p
emUgbnZtZV9jdHJsX3Jlc2V0KCkgd2l0aCBDUFUgCmhvdHBsdWcsIHRvIGVuc3VyZSB0aGF0IHRo
ZSByZXNldCBoYW5kbGVyIGlzIGNvbXBsZXRlZCBiZWZvcmUgdGhlIGNwdSBpcyAKY29tcGxldGVs
eSB0b3JuIGRvd24uCgpCdXQgc3luY2hyb25pemluZyB3aXRoIG52bWVfY3RybF9yZXNldCgpIG1l
YW5zIHRvIGlzc3VlIGEgZmx1c2hfd29yaygpOyAKYW5kIGlmIHdlIGRvIHRoYXQgd2UgbWlnaHQg
YXMgd2VsbCBnbyBmdWxsIGNpcmNsZSBhbmQgY2FsbCAKbnZtZV9jdHJsX3Jlc2V0X3N5bmMoKS4g
QW5kIGFzIHRoaXMgd2lsbCByZWFycmFuZ2UgdGhlIGhjdHggdG8gbWF0Y2ggdGhlIApjdXJyZW50
IENQVSB0b3BvbG9neSB3ZSBkb24ndCBuZWVkIHRvIGZpZGRsZSB3aXRoIGl0IGluIHRoZSBob3Rw
bHVnIApoYW5kbGVyLCBhbmQgY2FuIGxlYXZlIGV2ZXJ5dGhpbmcgdG8gbnZtZV9jdHJsX3Jlc2V0
KCkuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAg
ICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdt
YkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVy
ZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
