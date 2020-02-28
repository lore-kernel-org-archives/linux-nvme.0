Return-Path: <SRS0=58/p=4Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC8AC3F2D1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 10:39:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83672246A8
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 10:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DUY5LM7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83672246A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p3lMnGzg7bEogKqqzZSUYIZmQrSqM8Ozj4KW8YmEO28=; b=DUY5LM7n2HQd9Hq0VMi3DC/YP
	7pHV2UhdhBbtNZgYMh+5JpYXzvd5XTIJAIlfdIZYhCoPp5KMisOd2QYRaRTRd0BusEESufWH4Az9B
	760BNj7zK+sgr9YV6LGgEPktu6YUs+oIiA89ESREiJTCp/E3myPsYiYrzaoucYE+tlE/TvXnLmmDs
	IVZjufkQFgattQUrCZ4DuUtOoJizwLjeDMmPj4eIFHPnLsqcu79wb4YUFOfBE5YxMDV75VtqytOXL
	NSTulQ+yB1I8WC0kTRocmuHK0VgK1l1yUphsh4+QOUlwtDTE4T69T0Sa6tW4Xo/icvTsrBLADGKn8
	92S0ClqMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7d3f-00018z-UL; Fri, 28 Feb 2020 10:39:51 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7d3d-00018M-1H
 for linux-nvme@lists.infradead.org; Fri, 28 Feb 2020 10:39:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7DACDAD93;
 Fri, 28 Feb 2020 10:39:43 +0000 (UTC)
Subject: Re: [PATCH RFC] nvme/fc: sq flow control
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>
References: <20200225235956.28475-1-hare@suse.de>
 <913efdfd-6899-08c7-90bb-36f2d33f1e92@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <012a534d-d4bd-d4da-0267-d9b0e9db4d33@suse.de>
Date: Fri, 28 Feb 2020 11:39:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <913efdfd-6899-08c7-90bb-36f2d33f1e92@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_023949_225974_D364A45A 
X-CRM114-Status: GOOD (  24.61  )
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
Cc: linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 John Meneghini <john.meneghini@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNy8yMCAxMjo0NSBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gQXMgcGVyIE5W
TWUtb0Ygc3BlYyBzcSBmbG93IGNvbnRyb2wgaXMgYWN0dWFsbHkgbWFuZGF0b3J5LCBhbmQgd2Ug
c2hvdWxkCj4+IGJlIGltcGxlbWVudGluZyBpdCB0byBhdm9pZCB0aGUgY29udHJvbGxlciB0byBy
ZXR1cm4gYSBmYXRhbCBzdGF0dXMKPj4gZXJyb3IsIGFuZCB0cnkgdG8gcGxheSBuaWNlbHkgd2l0
aCBjb250cm9sbGVycyB1c2luZyBzcSBmbG93IGNvbnRyb2wKPj4gdG8gaW1wbGVtZW50IFFvUy4K
PiAKPiBIYW5uZXMsCj4gCj4gQ2FuIHlvdSBwbGVhc2UgY2xhcmlmeSB3aHkgdGhlIGluZGl2aWR1
YWwgdHJhbnNwb3J0cyBhcmVuJ3Qgc3VmZmljaWVudAo+IGZvciB0aGlzIFFvUyBmZWF0dXJlIHlv
dSBhcmUgdGFsa2luZyBhYm91dD8KPiAKPiBJZiB3ZSBsb29rIGF0IHRoZSB0cmFuc3BvcnRzIGxh
bmRzY2FwZSwgZWFjaCB0cmFuc3BvcnQgaGFzIGEgY3JlZGl0Cj4gbWVjaGFuaXNtIHRoYXQgY2Fu
IHRocm90dGxlIGJ1bGsgZGF0YSB0cmFuc2ZlcnMuIEluIEZDIGV4Y2hhbmdlcyB0aGUKPiB0YXJn
ZXQgaXMgaW4gY29udHJvbCBwdWxsaW5nIGRhdGEgZnJvbSB0aGUgaG9zdCB3aXRoIHhmZXJfcmVh
ZHksCj4gSW4gUkRNQSB0aGUgdGFyZ2V0IGRlY2lkZXMgd2hlbiB0byBpc3N1ZSByZG1hX3JlYWQs
IGFuZCBpbiBUQ1AgdGhlCj4gdGFyZ2V0IGRlY2lkZXMgd2hlbiB0byBpc3N1ZSBSMlQuCj4gCj4g
VGhlc2UgYXJlIGFsbCBjcmVkaXRzIHRoYXQgZ2l2ZSB0aGUgY29udHJvbCB0byB0aGUgdGFyZ2V0
IHRvCj4gYmFjay1wcmVzc3VyZSB0aGUgaG9zdC4gTm93IGlmIHRoZSB0YXJnZXQgZG9lc24ndCB3
YW50IHRoZSBob3N0IHRvIHNlbmQKPiBtb3JlIGNvbW1hbmRzLCBpdCBjYW4gdGhyb3R0bGUgc2Vu
ZGluZyBjb21wbGV0aW9ucyB0aHVzIGNvbnRyb2xsaW5nIHRoZQo+IHBhY2UuCj4gClllcywgdGhh
dCdzIHRydWUuIEhvd2V2ZXIsIHdoZW4gdXNpbmcgdGhpcyBtZWNoYW5pc20gaXQgcmVxdWlyZXMg
dGhlIAp0YXJnZXQgdG8gYWxyZWFkeSBhbGxvY2F0ZSByZXNvdXJjZXMgdG8gaG9sZCB0aGUgZmly
c3QgcGFydCBvZiB0aGUgCnRyYW5zZmVyLCBpZSB0aGUgY29tbWFuZCBzdHJ1Y3R1cmUgaXRzZWxm
IHdpbGwgaGF2ZSB0byBiZSBhbGxvY2F0ZWQgYXQgCnRoZSB0YXJnZXQuClNvIHdpdGggdGhpcyBt
ZXRob2Qgd2UnbGwgaGF2ZSBpc3N1ZXMgd2hlbiB0aGUgdGFyZ2V0IGdvZXMgb3V0IG9mIG1lbW9y
eSAKZHVlIHRvIGhpZ2ggdHJhZmZpYywgYXMgbm90IGFsbCBkcml2ZXJzIGFyZSBjb2RlZCBjYXJl
ZnVsbHkgdG8gYXZvaWQgCm1lbW9yeSBhbGxvY2F0aW9uIGluIHRoZSBJL08gcGF0aC4KVGhlIG90
aGVyIHByb2JsZW0gd2UgaGF2ZSBvbiBGQyBpcyB0aGF0IHRoZSBTQU4gY2FycmllcyBhbiBpbnRl
cm5hbCAKdGltZW91dCAoUkFUT1YsIHJlc291cmNlIGFsbG9jYXRpb24gdGltZW91dCksIGR1cmlu
ZyB3aGljaCBhIHRyYW5zYWN0aW9uIApuZWVkcyB0byBiZSBjb21wbGV0ZWQuIFNvIGFueSBkZWxh
eSBpbiBzZW5kaW5nIFJUUyBldGMgY2Fubm90IGV4Y2VlZCAKdGhpcyB2YWx1ZS4KSG93ZXZlciwg
dGhlIHJlYWwgcHJvYmxlbSBpcyB0aGF0IHdlJ3JlIHVuYWJsZSB0byBkZXRlY3QgYSBjb25mb3Jt
YW50IAppbXBsZW1lbnRhdGlvbi4gUGVyIGRlZmF1bHQgd2UgZG8gbm90IGRpc2FibGUgZmxvdyBj
b250cm9sLCBhbmQgZG8gbm90IApsb29rIGZvciBTUSBIZWFkIHVwZGF0ZXMuIFNvIGlmIHdlIHJ1
biBhZ2FpbnN0IGEgY29uZm9ybWFudCB0YXJnZXQgd2hpY2ggCmRlY2lkZXMgdG8gYmxvY2sgSS9P
IGJ5IG5vdCByZXR1cm5pbmcgU1EgSGVhZCB1cGRhdGVzIHRoZSBjb250cm9sbGVyIAp3aWxsIGV2
ZW50dWFsbHkgdGVybWluYXRlIHRoZSB0cmFuc3BvcnQgY29ubmVjdGlvbiB3aXRoIG5vIGluZGlj
YXRpb24gYXMgCnRvIHdoeSB0aGUgcmVzZXQgaGFwcGVuZWQuCgo+IEkgbXVzdCBzYXkgdGhhdCBy
ZXR1cm5pbmcgQkxLX1NUU19SRVNPVVJDRSBmb3IgaG9zdCBtYW5hZ2VkIFNRX0hFQUQgaXMgYQo+
IGJpdCBhd2t3YXJkIGluIG15IG1pbmQsIGJ1dCB0aGF0IGp1c3Qgb25lJ3Mgb3Bpbmlvbiwgd2hh
dCBkbyBvdGhlcnMgaGF2ZQo+IHRvIHNheT8KCldoYXQgd291bGQgYmUgdGhlIGFsdGVybmF0aXZl
PwpSZWR1Y2luZyB0aGUgcXVldWUgc2l6ZSBmb3IgdGhlIGhhcmR3YXJlIHF1ZXVlIHNlZW1zIGEg
Yml0IGV4Y2Vzc2l2ZSwgCmJ1dCBJJ20gb3BlbiB0byBoYXZlIGEgZGlmZmVyZW50IHJldHVybiBj
b2RlIGhlcmUuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICBUZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2UuZGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1
dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcg
TsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWls
aW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
