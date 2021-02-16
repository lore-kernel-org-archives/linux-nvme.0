Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CFFC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 08:51:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47C364DF0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 08:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47C364DF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F1t1/zexWlYZAZN1k9eXn9YXNYZBzyubwz4zUCWD8tw=; b=aIwOdx9+dI/5j//Jf1q8F06DT
	o98oG+2ChguJlkphGi6jMuwDhPrs6CmbQAx8Nt5WgGDlf52tK1oMp5jhYd0bsqUte3zFZif9AW5/L
	I6vFLlNpJ4OPzZ+AUkhwwMtMDVP/B5kJP23+/sDzgPETxjycjeWcNu6hUlyvfKo1ba6wdggs3on3c
	XoLRrjYp4KCoSyCOFed7xoFmb3bN5B0aHrwx9VjJrz6Pk7rR+4oJqwoiIvTOfgHplv9zeejmswU2o
	tw0rUX7hQ9d5cvy1Y7kVM6+qrp8iANIfC2jx2vc8ahOLk/ftS8wlEQ6RYKEUzVnRo/+66d5Or8jrc
	K/nurJu/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBw4X-0006Ea-JK; Tue, 16 Feb 2021 08:51:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBw4W-0006Dr-8R
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 08:51:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3C4DFAE19;
 Tue, 16 Feb 2021 08:51:01 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <5b45835b-eb81-29e8-e319-a8509474e27f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a18701ad-6880-37bb-7978-7ea6b7079c9e@suse.de>
Date: Tue, 16 Feb 2021 09:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <5b45835b-eb81-29e8-e319-a8509474e27f@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_035104_413425_38A080B3 
X-CRM114-Status: GOOD (  20.36  )
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
Cc: Jens Axboe <axboe@fb.com>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xNS8yMSAxMDoyMyBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+Pj4+IGJsa19t
cV90YWdfdG9fcnEoKSB3aWxsIGFsd2F5cyByZXR1cm4gYSByZXF1ZXN0IGlmIHRoZSBjb21tYW5k
X2lkIGlzCj4+Pj4+PiBpbiB0aGUgdmFsaWQgcmFuZ2UuIENoZWNrIGlmIHRoZSByZXF1ZXN0IGhh
cyBiZWVuIHN0YXJ0ZWQuIElmIHdlCj4+Pj4+PiBibGluZGx5IHByb2Nlc3MgdGhlIHJlcXVlc3Qg
d2UgbWlnaHQgZG91YmxlIGNvbXBsZXRlIGEgcmVxdWVzdCB3aGljaAo+Pj4+Pj4gY2FuIGJlIGZh
dGFsLgo+Pj4+Pgo+Pj4+PiBIb3cgZGlkIHlvdSBnZXQgdG8gdGhpcyBvbmU/IGRpZCB0aGUgY29u
dHJvbGxlciBzZW5kIGEgY29tcGxldGlvbiBmb3IKPj4+Pj4gYSBjb21wbGV0ZWQvYm9ndXMgcmVx
dWVzdD8KPj4+Pgo+Pj4+IElmIHRoYXQgaXMgdGhlIGNhc2UsIHRoZW4gdGhhdCBtdXN0IG1lYW4g
aXQncyBwb3NzaWJsZSB0aGUgZHJpdmVyIGNvdWxkCj4+Pj4gaGF2ZSBzdGFydGVkIHRoZSBjb21t
YW5kIGlkIGp1c3QgYmVmb3JlIHRoZSBib2d1cyBjb21wbGV0aW9uIGNoZWNrLiAKPj4+PiBEYXRh
Cj4+Pj4gaW9ycnVwdGlvbiwgcmlnaHQ/Cj4+Pgo+Pj4gWWVzLCB3aGljaCBpcyB3aHkgSSBkb24n
dCB0aGluayB0aGlzIGNoZWNrIGlzIHZlcnkgdXNlZnVsLi4KPj4KPj4gSSBhY3R1YWxseSB2aWV3
IHRoYXQgYXMgYSB2YWxpZCBwcm90ZWN0aW9uIGFnYWluc3Qgc3Bvb2ZlZCBmcmFtZXMuCj4+IFdp
dGhvdXQgaXQgaXQncyBlYXN5IHRvIGNyYXNoIHRoZSBtYWNoaW5lIGJ5IGluamVjdGluZyBmYWtl
IAo+PiBjb21wbGV0aW9ucyB3aXRoIHJhbmRvbSBjb21tYW5kIGlkcy4KPiAKPiBBbmQgdGhpcyBk
b2Vzbid0IGhlbHAgYmVjYXVzZSB0aGUgY29tbWFuZCBjYW4gaGF2ZSBiZWVuIGVhc2lseSByZXVz
ZWQKPiBhbmQgc3RhcnRlZC4uLiBXaGF0IGlzIHRoaXMgcHJvdGVjdGluZyBhZ2FpbnN0PyBOb3Rl
IHRoYXQgbm9uZSBvZiB0aGUKPiBvdGhlciB0cmFuc3BvcnRzIGNoZWNrcyB0aGF0LCB3aHkgc2hv
dWxkIHRjcD8KCkJlY2F1c2UgaXQncyBwYXJ0aWN1bGFybHkgZWFzeSB0byBzcG9vZiBwYWNrZXRz
IG9uIHRjcC4KQWxsIG90aGVyIG52bWUtb2YgdHJhbnNwb3J0cyBhcmUgbGF5ZXJlZCBvbiB0b3Ag
b2Ygb3RoZXIgdHJhbnNwb3J0cyAKd2hpY2ggZG8gc29tZSBzYW5pdHkgY2hlY2tzIGFscmVhZHks
IHNvIGl0IGJlY29tZXMgcmVhbGx5IGhhcmQgdG8gaW5qZWN0IAppbnZhbGlkIE5WTWUtb0YgZnJh
bWVzIGZvciB0aG9zZS4KTlZNZS1UQ1AgaGFzIG5vbmUgb2YgdGhlc2UgcHJvdGVjdGlvbnMsIG1h
a2luZyBpdCByZWFsbHkgZWFzeSB0byBpbmplY3QgCmZhdWx0eSBmcmFtZXMgKG9yLCBoZWF2ZW4g
Zm9yYmlkLCBydW5uaW5nIGEgcGFja2V0IGZ1enplcikuCgpBbmQgY3Jhc2hpbmcgdGhlIG1hY2hp
bmUgb24gaW52YWxpZCBmcmFtZXMgaXMgYWx3YXlzIGEgYmFkIGlkZWE7IEkgd291bGQgCmhhdmUg
ZXhwZWN0ZWQgTlZNZS1UQ1AgdG8gZHJvcCB0aGVtLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4g
SGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApo
YXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4
OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXgg
SW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
