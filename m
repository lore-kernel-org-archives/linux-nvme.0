Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8950C432C3
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:39:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB1D2080F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sYn5PuCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB1D2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EtAHbjs6bwvu55XHUfa4F0BCvpfFN2B2u7RKR89kyhc=; b=sYn5PuCom36bes
	QskJfAFqlibQUZKBwZsPwasq5UEjbY3W7IAJnoenBvGP2jqeEsmc48a0MTvozr2JS9JB68VYBhvja
	orIy4Fw7ch0Vfay8OUfps8Mb1V/qUyQXWI3tRgS6gOZgVDEXBW6qPABeWvuecM1USCHuPGUt6ymEU
	ybo4WWe7HAHUi3jDX5jETayi5ZgSQC5f+x2wxrrfX3udWKqK+5tQ4H780uwxvSdwk24aQA/bn/Asi
	mboIOqhAjXyb+DfakzA6G7rn9tJfm70uFPBZKaZ6PgHBHU3bctM2DUu8C32Y0JqHE4pUYQyLx0bYE
	vhssJIBWW1w3icPrJ7zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZds8-0007jr-Mf; Tue, 26 Nov 2019 16:39:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZds5-0007jU-CN
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 16:39:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A48B668C4E; Tue, 26 Nov 2019 17:39:22 +0100 (CET)
Date: Tue, 26 Nov 2019 17:39:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: always treat DNR status as no-retryable
Message-ID: <20191126163922.GA7946@lst.de>
References: <20191126133749.72267-1-hare@suse.de>
 <20191126161532.GB2906@redsun51.ssa.fujisawa.hgst.com>
 <3186d79f-910a-18f6-dcae-080b370bcab3@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3186d79f-910a-18f6-dcae-080b370bcab3@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_083926_261172_951B1261 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBOb3YgMjYsIDIwMTkgYXQgMDU6MzQ6MjFQTSArMDEwMCwgSGFubmVzIFJlaW5lY2tl
IHdyb3RlOgo+IE9uIDExLzI2LzE5IDU6MTUgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+PiBPbiBU
dWUsIE5vdiAyNiwgMjAxOSBhdCAwMjozNzo0OVBNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3Jv
dGU6Cj4+PiBJZiB0aGUgRE5SIGJpdCBpcyBzZXQgaW4gdGhlIGNvbW1hbmQgc3RhdHVzIHdlIHNo
b3VsZCBub3QgcmV0cnkKPj4+IHRoZSBjb21tYW5kLCBpcnJlc3BlY3RpdmUgb2Ygd2hhdCB0aGUg
YWN0dWFsIHN0YXR1cyBpcy4KPj4+IFNvIG1hcCBpdCBkaXJlY3RseSB0byBCTEtfU1RTX1RBUkdF
VCB0byBpbmZvcm0gdXBwZXIgbGF5ZXJzIHRvCj4+PiBub3QgcmV0cnkgdGhlIGNvbW1hbmQsIG5v
dCBldmVuIG9uIGFub3RoZXIgcGF0aC4KPj4KPj4gV2h5IGNhbid0IGEgRE5SIGVycm9yIGJlIHBh
dGggc3BlY2lmaWMsIGxpa2UgaWYgSSBkZXRhY2ggYSBuYW1lc3BhY2UKPj4gZnJvbSBvbmUgb2Yg
dGhlIGNvbnRyb2xsZXJzPwo+PiAgIAo+IEkndmUgZGlzY3Vzc2VkIHRoZSB2ZXJ5IHNhbWUgcXVl
c3Rpb24gd2l0aCBGcmVkIEtuaWdodCwgYW5kIGFjY29yZGluZyB0byAKPiBoaW0gdGhlICdETlIn
IGJpdCBpcyBfY29tbWFuZF8gc3BlY2lmaWMsIGllIF90aGlzIHBhcnRpY3VsYXIgY29tbWFuZF8g
Cj4gc2hvdWxkIG5vdCBiZSByZXRyaWVkLgo+IEFueSBldmVudHVhbCBhbHRlcm5hdGl2ZSBwYXRo
IHNob3VsZCBub3QgYmUgY29uc2lkZXJlZC4KClRvIHF1b3RlIGZyb20gdGhlIHNwZWM6CgoiRG8g
Tm90IFJldHJ5IChETlIpOiBJZiBzZXQgdG8g4oCYMeKAmSwgaW5kaWNhdGVzIHRoYXQgaWYgdGhl
IHNhbWUgY29tbWFuZCBpcwpyZS1zdWJtaXR0ZWQgdG8gYW55IGNvbnRyb2xsZXIgaW4gdGhlIE5W
TSBzdWJzeXN0ZW0sIHRoZW4gdGhhdCByZS1zdWJtaXR0ZWQKY29tbWFuZCBpcyBleHBlY3RlZCB0
byBmYWlsLiBJZiBjbGVhcmVkIHRvIOKAmDDigJksIGluZGljYXRlcyB0aGF0IHRoZSBzYW1lCmNv
bW1hbmQgbWF5IHN1Y2NlZWQgaWYgcmV0cmllZC4iCgpTbyB5ZXMsIHdlIHNob3VsZCBnZW5lcmFs
bHkgbm90IHN1Ym1pdCBpdCBvbiBhbm90aGVyIHBhdGgsIHdoaWNoIGlzIGluCmZhY3Qgd2hhdCB3
ZSBhbHJlYWR5IGRvIGlmIHlvdSBsb29rIGF0IG52bWVfY29tcGxldGVfcnEgYW5kCm52bWVfcmVx
X25lZWRzX3JldHJ5LgoKQmVzaWRlcyBub3Qgbm90IG5lZWRpbmcgdGhlIEJMS19TVFNfVEFSR0VU
IHJlbWFwIHRoYXQgcmVtYXAgYWxzbyBpcyBhCmhvcnJpYmxlIGJhZCBpZGVhIGdpdmVuIHRoYXQg
aXMgbG9zZXMgd2F5IHRvbyBtdWNoIGluZm9ybWF0aW9uLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
