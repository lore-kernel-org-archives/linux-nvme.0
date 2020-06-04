Return-Path: <SRS0=P2Tb=7R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8E4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 13:48:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA37E206E6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 13:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UNHyn7IW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA37E206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qq0HKFGn7La0UQisUkha6xalKvQFRmADcVDeEicftjA=; b=UNHyn7IWX3OhR5fqm8vuSI34V
	XuO2w0wCqzyVcFJDCOrsxElhHp2dEMgeWhdJQ3wyzJIQ6Teiy212d32MtIBR60q791oVQHpxNTmub
	6a/inZzya5KEr1WxGyDFF0VVddgiAQXVhfUBIaaQRWNRvKGVfXaEfGkhAVq/UJgjjPEWp7VJ66I3J
	apudBfGNentMtR8Amx7HsG069Buvt4ijQe1Ic1ykF8+UmjMP14CoJhd/R6ZS7skHxSIcRKyUSx9l+
	nERtESkXQ8ZuWOjD6ih6lEdV/DTuNu6HtdAsrqyPKDk8Ta6gaFIqFhK7W51KGpCvqNLsS+8x3Y9xb
	ukUQPt7kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgqE7-00045Y-E5; Thu, 04 Jun 2020 13:48:11 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgqE4-00044N-GP
 for linux-nvme@lists.infradead.org; Thu, 04 Jun 2020 13:48:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EC176AC5B;
 Thu,  4 Jun 2020 13:48:06 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvme: check for NVME_CTRL_LIVE in nvme_report_ns_ids()
To: Keith Busch <kbusch@kernel.org>
References: <20200604115602.78446-1-hare@suse.de>
 <20200604115602.78446-2-hare@suse.de>
 <20200604132259.GA146361@dhcp-10-100-145-180.wdl.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <79298b5a-857d-60dd-91c7-058182b39b0e@suse.de>
Date: Thu, 4 Jun 2020 15:48:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604132259.GA146361@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200604_064808_694041_7EAD92CF 
X-CRM114-Status: GOOD (  23.31  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <daniel.wagner@suse.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi80LzIwIDM6MjIgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+IE9uIFRodSwgSnVuIDA0LCAy
MDIwIGF0IDAxOjU2OjAxUE0gKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gV2hlbiBh
IGNvbnRyb2xsZXIgcmVzZXQgaGFwcGVucyBkdXJpbmcgc2Nhbm5pbmcgbnZtZV9pZGVudGlmeV9u
cygpCj4+IHdpbGwgYmUgYWJvcnRlZCwgYnV0IHRoZSBzdWJzZXF1ZW50IGNhbGwgdG8gbnZtZV9p
ZGVudGlmeV9uc19kZXNjcygpCj4+IHdpbGwgc3RhbGwgYXMgaXQgd2lsbCBvbmx5IGJlIGNvbXBs
ZXRlZCBvbmNlIHRoZSBjb250cm9sbGVyIHJlY29ubmVjdAo+PiBpcyBmaW5pc2hlZC4KPiAKPiBJ
ZiBudm1lX2lkZW50aWZ5X25zKCkgaXMgYWJvcnRlZCwgc2hvdWxkbid0IHdlIG5vdCBwcm9jZWVk
IHRvIHRoZSBuZXh0Cj4gY29tbWFuZD8gSXQgbG9va3MgbGlrZSB0aGUgY29kZSBhbHJlYWR5IGRv
ZXMgdGhhdCwgZnJvbSBudm1lX2FsbG9jX25zKCk6Cj4gCj4gCXJldCA9IG52bWVfaWRlbnRpZnlf
bnMoY3RybCwgbnNpZCwgJmlkKTsKPiAJaWYgKHJldCkKPiAJCWdvdG8gb3V0X2ZyZWVfcXVldWU7
Cj4gCj4gQW5kIHRoZW4gZnJvbSBudm1lX3JldmFsaWRhdGVfZGlzaygpOgo+IAo+IAlyZXQgPSBu
dm1lX2lkZW50aWZ5X25zKGN0cmwsIG5zLT5oZWFkLT5uc19pZCwgJmlkKTsKPiAJaWYgKHJldCkK
PiAJCWdvdG8gb3V0Owo+IAo+IFRob3NlIGFyZSB0aGUgb25seSB0d28gcGF0aHMgdG8gbnZtZV9p
ZGVudGlmeV9uc19kZXNjcygpLCBzbyBpdCBsb29rcwo+IGxpa2UgbnZtZV9pZGVudGlmeV9ucygp
IG11c3QgYmUgc3VjY2Vzc2Z1bCBpbiBvcmRlciB0byBnZXQgdGhlcmUuCj4gCgpUcnVlLiBCdXQg
aWYgdGhlIGNvbnRyb2xsZXIgaXMgZW50ZXJpbmcgcmVzZXQganVhdCBfYWZ0ZXJfIHRoZSBjYWxs
IHRvIApudm1lX2lkZW50aWZ5X25zKCkgdGhlcmUgd29uJ3QgYmUgYW55IEkvTyB0byBhYm9ydCwg
YW5kIHRoZSBzY2FubmluZyAKY29kZSB3aWxsIHByb2NlZWQgdG8gY2FsbCBudm1lX3JlcG9ydF9u
c19pZHMoKSBleHBvc2luZyB0aGlzIGlzc3VlLgoKPj4gQnV0IGFzIHRoZSByZWNvbm5lY3Qgd2Fp
dHMgZm9yIHNjYW5uaW5nIHRvIGNvbXBsZXRlIHRoZSBwYXJ0aWN1bGFyCj4+IG5hbWVzcGFjZSB3
aWxsIGRlYWRsb2NrIGFuZCBuZXZlciByZWNvbm5lY3RlZCBhZ2Fpbi4KPiAKPiBUaGUgZml4IGxv
b2tzIGEgYml0IGZyYWdpbGUuIFdoYXQgaWYgdGhlIGNvbnRyb2xsZXIgaXMgcmVzZXQgaW1tZWRp
YXRlbHkKPiBhZnRlciB0aGUgY2hlY2sgZm9yIGxpdmU/IEl0J2QgYmUgc2FmZXIgc3VjaCB0aGF0
IHJlY29ubmVjdCBkaWRuJ3QgaGF2ZQo+IHRvIHdhaXQgZm9yIHNjYW5fd29yaywgbm8/ICBUaGUg
cGNpIHRyYW5zcG9ydCBoYXMgbm8gc3VjaCBkZXBlbmRlbmN5LAo+IGZvciBleGFtcGxlLgo+IApP
aCwgdGhhdCB3b3VsZG4ndCBtYXR0ZXI7IG9uY2UgdGhlIGNvbnRyb2xsZXIgaXMgcmVzZXQgKGll
IGVudGVycyBhIApub24tTElWRSBzdGF0ZSkgYWxsIG91dHN0YW5kaW5nIEkvTyBpcyBhYm9ydGVk
LgoKVGhlIHBvaW50IGhlcmUgaXMgdGhhdCBvbmx5IF9vdXRzdGFuZGluZ18gSS9PIGlzIGFib3J0
ZWQuCklmIHRoZSBzY2FuIHRocmVhZCBjb250aW51ZXMgc2VuZGluZyBJL08gYWZ0ZXIgdGhhdCB0
aGluZ3Mgc3RhbGwuCgpBbmQgSSBjYW4ndCByZWFsbHkgc2VlIGhvdyB3ZSBzaG91bGQgYmUgYWJs
ZSB0byBkZWNvdXBsZSB0aGUgc2NhbiB0aHJlYWQgCmZyb20gcmVzZXQ7IGJvdGggd2lsbCBiZSBt
b2RpZnlpbmcgdGhlIG5hbWVzcGFjZSBzdGF0ZSAob3IgZXZlbiAKcHJlc2VuY2UpLCBzbyB3ZSBo
YXZlIHRvIGZsdXNoIG9uZSBvZiB0aGVtIHRvIGF2b2lkIHVzIGhhdmluZyB0byBsb2NrIAplYWNo
IGFuZCBldmVyeSBtb2RpZmljYXRpb24gYW5kIGtpbGxpbmcgcGVyZm9ybWFuY2UuCgpDaGVlcnMs
CgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICBUZWFtbGVhZCBTdG9y
YWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVs
ZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jD
pGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
