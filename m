Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1DDC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 17:37:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C733C60201
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 17:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C733C60201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jt9i+WGhJIOoIKkGVKImQrSEm0QcyJuuMOsJF8E9BhA=; b=UYZJ1jav3muchAAC/s8eTiDt3
	6/ZrYSvtxwabIMIj1fCWpybqTcJNTrZX16uXB2S6OOf0RdnoXwSEvMhkfK4LwsCKzEvAz4vWILbN6
	mjbNpuc1s+o3FeCLWblH9+bzCYet/k7FH2utbeG6wJMCB7LfzyOt6P8C18+XSX/Rj8w9OWJW1xx9o
	W+aBb5j0Aw8ohvTEW8rNZBjoqYyMvTUS+R4WF6lgJqM/BXB5QBMG72OCStFyQeNrZT9Y16wm+lG7T
	YT1NleKXYjcfB1fvvU+rJ1AdQPhkpnVmg8dPSvqJOCNS8I2kyentzntLWar2BHxe+g2vPBl68qapD
	ky3VhjcnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFKaB-00046V-3b; Thu, 25 Feb 2021 17:37:47 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFKa8-00045z-C8
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 17:37:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id ACA7AAD57;
 Thu, 25 Feb 2021 17:37:42 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: delete disk when last path is gone
To: Keith Busch <kbusch@kernel.org>
References: <20210225110534.75710-1-hare@suse.de>
 <20210225110534.75710-3-hare@suse.de>
 <20210225165944.GF31593@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <176fe48f-090f-0365-ef8f-d650b803f053@suse.de>
Date: Thu, 25 Feb 2021 18:37:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210225165944.GF31593@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_123744_535892_B8C1107B 
X-CRM114-Status: GOOD (  24.03  )
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
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNS8yMSA1OjU5IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBUaHUsIEZlYiAyNSwg
MjAyMSBhdCAxMjowNTozNFBNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFRoZSBt
dWx0aXBhdGggY29kZSBjdXJyZW50bHkgZGVsZXRlcyB0aGUgZGlzayBvbmx5IGFmdGVyIGFsbCBy
ZWZlcmVuY2VzCj4+IHRvIGl0IGFyZSBkcm9wcGVkIHJhdGhlciB0aGFuIHdoZW4gdGhlIGxhc3Qg
cGF0aCB0byB0aGF0IGRpc2sgaXMgbG9zdC4KPj4gVGhpcyBkaWZmZXJzIGZyb20gdGhlIGJlaGF2
aW91ciBpbiB0aGUgbm9uLW11bHRpcGF0aGVkIGNhc2Ugd2hlcmUgdGhlCj4+IGRpc2sgaXMgZGVs
ZXRlZCBvbmNlIHRoZSBjb250cm9sbGVyIGlzIHJlbW92ZWQuCj4+IFRoaXMgaGFzIGJlZW4gcmVw
b3J0ZWQgdG8gY2F1c2UgcHJvYmxlbXMgd2l0aCBzb21lIHVzZSBjYXNlcyBsaWtlIE1EIFJBSUQu
Cj4+Cj4+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBhbiBhbHRlcm5hdGl2ZSBiZWhhdmlvdXIgb2Yg
ZGVsZXRpbmcgdGhlIGRpc2sgd2hlbgo+PiB0aGUgbGFzdCBwYXRoIGlzIGdvbmUsIGllIHRoZSBz
YW1lIGJlaGF2aW91ciBhcyBub24tbXVsdGlwYXRoZWQgbnZtZQo+PiBkZXZpY2VzLiBUaGUgYWx0
ZXJuYXRpdmUgYmVoYXZpb3VyIGNhbiBiZSBlbmFibGVkIHdpdGggdGhlIG5ldyBzeXNmcwo+PiBh
dHRyaWJ1dGUgJ25vX3BhdGhfZGV0YWNoJy4KPiAKPiBUaGlzIGxvb2tzIG9rIHRvIG1lLiBJIGhh
dmUgaGVhcmQgZnJvbSBhIGZldyBwZW9wbGUgdGhhdCB0aGV5IGV4cGVjdGVkCj4gaXQgdG8gd29y
ayB0aGlzIHdheSB3aXRoIHRoZSBvcHRpb24gZW5hYmxlZCwgYnV0IEkgc3VwcG9zZSB3ZSBkbyBu
ZWVkIHRvCj4gcmV0YWluIHRoZSBvbGQgYmVoYXZpb3IgYXMgZGVmYXVsdC4KPiAKPiBSZXZpZXdl
ZC1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPgo+IApPaCwgSSB3b3VsZCBfbG92
ZV8gdG8ga2lsbCB0aGUgb2xkIGJlaGF2aW91ci4KRXNwZWNpYWxseSBhcyB3ZSBub3cgaGF2ZSBm
YXN0X2lvX2ZhaWxfdG1vIGFuZCBjdHJsX2xvc3NfdG1vLCB3aGljaCAKZ2l2ZXMgdXMgZW5vdWdo
IGNvbnRyb2wgb24gaG93IHRoZSBjb250cm9sbGVyIGFuZCB0aGUgcmVtYWluaW5nIHBhdGhzIApz
aG91bGQgYmVoYXZlIChhbmQgd2hpY2ggd2VyZW4ndCBwcmVzZW50IHdoZW4gZmFicmljcyBnb3Qg
aW1wbGVtZW50ZWQpLgoKV2UgY2FuIG1ha2UgdGhpcyBiZWhhdmlvdXIgdGhlIGRlZmF1bHQsIGFu
ZCBraWxsIHRoZSBvbGQgYXBwcm9hY2ggbmV4dCAKeWVhciBpZiB0aGVyZSBhcmUgbm8gY29tcGxh
aW50cyA6LSkKCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAg
ICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlv
bnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8
cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
