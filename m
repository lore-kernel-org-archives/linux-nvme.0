Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08700C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 16:53:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0895660F5E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 16:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0895660F5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DrXnWIqezqA2h5HTJYJ0PSeSqDWZ1SqckQknp7GBs50=; b=KJjglAG0hF6k2yj10SszLpFnVQ
	2vdcUXT6JzZDWtNZj2YcK9e6EXljukzbJHeU/9zSoRqI5IEY4Zpw0JXBcWBlRmiR1SkkEpT2R3PgY
	SRFIqfn6XcC6WNuUYW5faAUmeqng7JpF5CLQD9E6JSbJs29XxKxnXQtpgGm+NbDKpBeJYgFqMx5CX
	QnjVXGumsHEfbOh7r9IZyoGT2+R5Lt/4KfwsFC2l0wmNj271ttqZD3kJkpwhR2UwNF1OCH8UHu4+S
	ub/thc8sEOLdZ3Jz/WeD50acM87mR0mvUTAwbvsryI1ylhPkP+8v9FWnZTvMJwZzqwBA4VTk0BDPW
	pRaPu9+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG2LJ-0032pP-4f; Tue, 17 Aug 2021 16:53:37 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG2L2-0032kW-DY
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 16:53:22 +0000
Received: from [192.168.0.3] (ip5f5aeb65.dynamic.kabel-deutschland.de
 [95.90.235.101])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id CA12561E5FE00;
 Tue, 17 Aug 2021 18:53:16 +0200 (CEST)
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
Date: Tue, 17 Aug 2021 18:53:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_095320_702256_7E2B7EFF 
X-CRM114-Status: GOOD (  20.85  )
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

W2NjOiArRGVsbC5DbGllbnQuS2VybmVsQGRlbGwuY29tIGFzIGl04oCZcyBhIERlbGwgZGV2aWNl
XQoKRGVhciBLZWl0aCwKCgpUaGFuayB5b3UgZm9yIHlvdXIgcHJvbXB0IHJlc3BvbnNlLgoKQW0g
MTcuMDguMjEgdW0gMTg6MTYgc2NocmllYiBLZWl0aCBCdXNjaDoKPiBPbiBUdWUsIEF1ZyAxNywg
MjAyMSBhdCAwNToxMDo0MFBNICswMjAwLCBQYXVsIE1lbnplbCB3cm90ZToKPj4gT24gYSBEZWxs
IE9wdGlQbGV4IDc3ODAgQUlPLzA0RzQ3VyAoQklPUyAxLjYuMyAwMy8wOC8yMDIxKSBMaW51eCA1
LjEwLjQ3Cj4+IHNob3dzIHRoZSB3YXJuaW5nIGJlbG93Ogo+Pgo+PiAgICAgICQgZG1lc2cgfCBn
cmVwIG52bWUKPj4gICAgICBbICAgIDMuMDE1MzkyXSBudm1lIDAwMDA6MDI6MDAuMDogcGxhdGZv
cm0gcXVpcms6IHNldHRpbmcgc2ltcGxlIHN1c3BlbmQKPj4gICAgICBbICAgIDMuMDIxODYxXSBu
dm1lIG52bWUwOiBwY2kgZnVuY3Rpb24gMDAwMDowMjowMC4wCj4+ICAgICAgWyAgICAzLjAyNjU5
M10gYWhjaSAwMDAwOjAwOjE3LjA6IHZlcnNpb24gMy4wCj4+ICAgICAgWyAgICAzLjAyNjkyMl0g
YWhjaSAwMDAwOjAwOjE3LjA6IEFIQ0kgMDAwMS4wMzAxIDMyIHNsb3RzIDEgcG9ydHMgNiBHYnBz
IDB4MSBpbXBsIFNBVEEgbW9kZQo+PiAgICAgIFsgICAgMy4wMzUwMjBdIGFoY2kgMDAwMDowMDox
Ny4wOiBmbGFnczogNjRiaXQgbmNxIHNudGYgcG0gY2xvIG9ubHkgcGlvIHNsdW0gcGFydCBlbXMg
ZGVzbyBzYWRtIHNkcyBhcHN0Cj4+ICAgICAgWyAgICAzLjAzNTIxOV0gbnZtZSBudm1lMDogbWlz
c2luZyBvciBpbnZhbGlkIFNVQk5RTiBmaWVsZC4KPj4gICAgICBbICAgIDMuMDQ0NTE4XSBzY3Np
IGhvc3QwOiBhaGNpCj4+ICAgICAgWyAgICAzLjA1MTYzMl0gbnZtZSBudm1lMDogMTIvMC8wIGRl
ZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcwo+PiAgICAgIFsgICAgMy4wNTI1OTBdIGF0YTE6IFNBVEEg
bWF4IFVETUEvMTMzIGFiYXIgbTIwNDhAMHhkMTMzOTAwMCBwb3J0IDB4ZDEzMzkxMDAgaXJxIDEy
NQo+PiAgICAgIFsgICAgMy4wNTg1MzhdICBudm1lMG4xOiBwMSBwMiBwMwo+Pgo+PiBTaG91bGQg
aXQgYmUgYWRkZWQgdG8gdGhlIHF1aXJrIGxpc3QgaW4gYGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5j
YCBvciBpcyBpdCBhCj4+IHJlYWwgaXNzdWVzLCB0aGUgbWFudWZhY3R1cmVyIHNob3VsZCBmaXg/
IElmIHNvLCBkbyB5b3UgaGF2ZSBTSyBIeW5peAo+PiBjb250YWN0cz8KPiAKPiBJdCB3b3VsZCBi
ZSBncmVhdCBpZiBkZXZpY2UgbWFrZXJzIHdvdWxkIGJlIHNwZWMgY29tcGxpYW50LCBidXQgdGhl
Cj4gZHJpdmVyIHdpbGwgY29udGludWUgdG8gd29yayB3aXRoIHRoZSBkZXZpY2UgdGhlIHNhbWUg
d2hldGhlciB5b3UgYWRkCj4gdGhlIHF1aXJrIG9yIG5vdC4KCkNvdWxkIHlvdSBwbGVhc2UgcG9p
bnQgbWUgdG8gdGhlIE5WTWUgc3BlY2lmaWNhdGlvbiBzZWN0aW9uLCBzbyBJIGNhbiAKcmVmZXIg
dG8gaXQsIHdoZW4gY29udGFjdGluZyB0aGUgbWFudWZhY3R1cmVyPwoKPiBUaGUgcXVpcmsganVz
dCBzdXBwcmVzc2VzIHRoZSBucW4gY2hlY2sgYW5kIHdhcm5pbmcuIEZlZWwgZnJlZSB0byBhZGQK
PiBpdCBpZiB5b3UgZG9uJ3QgbGlrZSBzZWVpbmcgdGhlIHdhcm5pbmcgbWVzc2FnZSBvciBpZiB0
aGUKPiBtYW51ZmFjdHVyZXIgY2FuJ3QgcmVzb2x2ZSB0aGUgY29tcGxpYW5jZSBpc3N1ZS4KVW5k
ZXJzdG9vZC4gSSBhbSBnb2luZyB0byBkbyB0aGF0LCB3aGVuIGl0IGNhbuKAmXQgYmUgcmVzb2x2
ZWQuCgoKS2luZCByZWdhcmRzLAoKUGF1bAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
