Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD40C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 21:10:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1982086A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 21:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ilSqmnpn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Xoneea9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1982086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SUGEnKeO81Rmq1E+VRiXYPc7N5Va0mNyA+a+wSGiXGI=; b=ilSqmnpnY/aiIiPw0bxrazW6j
	KzcdqBw5PDLVHXK3XaGGG/zh65X1E3fRIgq3m4Xc8R6M2euTW4Q08D59oIwqIn6oh9m67VTNHnffz
	f5vHmJMCwAnmDHogzyASFPhBDYkw1vpiha8quCzYV+hnHjL+kd70Pf0ckO5lvecg2jUr3mA3DKqU9
	Tu/DrhQ4fDMCjCiPbaqQvSAdCNRgHaXPgJHvS4nX19IcopJKGbjDjcJK40Uac6sJS/gOOzu8bF+0/
	MleSphNCTVARpWeAl3UDF4u2FJNP9Cn1r7wj9rKWW9ZUzZ9Xrg+whHEuzxBCD7JKyXJY8ZRGrg8lD
	whYI6CDXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyM09-0001Bs-J2; Wed, 22 Jul 2020 21:10:09 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyM06-0001BI-Fv
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 21:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5bLC7zj+BNGLM6XnF44Ejyj7euF29Rdfx+nocYnq+Gs=; b=Xoneea9/eg744dwJ9ZucMgGoWJ
 f0jzHQmLLGpMVrvcGA48C5FkO1vDnz0qgCJPX6lJTRQrzPme1dwF1hKaCSYeWYMT2m91zKvPq6Kwe
 0rXtgMrc1TiksPoyzLAGXS666/vwFiHKzfQU2tu2NEmOCjrbYkzdma867mMZU9ZS9DNSmvhp9ApJC
 uoVrK2itV5O8kFICO5kPRmI9lIvlZ3JQfGuFB2deGiENX/ve3E8p2AEnTp8+Gnb2Z/8pMcn9Dzy2u
 avQbbyrpLmNh8AEdbpnJwU2hYxGzuvCURg9yyiRBo+o2nHOoW3Dt7yfHAtNTk6T3lTornj8GTeFSL
 igO5R/Qg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1jyLzy-00069M-4Z; Wed, 22 Jul 2020 15:09:59 -0600
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <98f45e65-2967-3af9-69d1-077a32c43fa2@deltatee.com>
Date: Wed, 22 Jul 2020 15:09:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_171006_601579_D9685572 
X-CRM114-Status: GOOD (  23.95  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLTA3LTIwIDQ6MzUgcC5tLiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gVGhh
bmtzIGZvciB0aGUgcmV2aWV3IENocmlzdG9waC4gSSB0aGluayBJIHNob3VsZCBiZSBhYmxlIHRv
IG1ha2UgYWxsCj4+IHRoZSByZXF1ZXN0ZWQgY2hhbmdlcyBpbiB0aGUgbmV4dCB3ZWVrIG9yIHR3
by4KPj4KPj4gT24gMjAyMC0wNy0yMCAxOjM1IHAubS4sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+
Pgo+Pj4+IEknbSBzdGlsbCBub3Qgc28gaGFwcHkgYWJvdXQgaGF2aW5nIHRvIGxvb2sgdXAgdGhl
IG5hbWVzcGFjZSBhbmQgc3RpbGwKPj4+PiB3b25kZXIgaWYgd2Ugc2hvdWxkIGdlbmVyYWxpemUg
dGhlIGNvbm5lY3RfcSB0byBhIHBhc3N0aHJvdWdoX3EuwqAgQnV0Cj4+Pj4gSSBndWVzcyB3ZSBj
YW4gZG8gdGhhdCBsYXRlciBhbmQgdGhlbiByZWR1Y2Ugc29tZSBvZiB0aGUgZXhwb3J0cyBoZXJl
Li4KPj4+Cj4+PiBUaGF0IGlzIGEgbmVhdCBpZGVhISBzaG91bGQgYmUgZWFzeSB0byBkbyAoYW5k
IHdlIGNhbiB0aGVuIGxvc2UgdGhlIGhvc3QKPj4+IHhhcnJheSBzdHVmZikuIEkgZG9uJ3QgbWlu
ZCBoYXZpbmcgaXQgb24gYSBsYXRlciBwYXRjaCwgYnV0IGl0IHNob3VsZCBiZQo+Pj4gZWFzeSBl
bm91Z2ggdG8gZG8gZXZlbiBiZWZvcmUuLi4KPj4+Cj4+Cj4+IEkgc29ydCBvZiBmb2xsb3cgdGhp
cy4gSSBjYW4gdHJ5IHRvIHdvcmsgc29tZXRoaW5nIHVwIGJ1dCBpdCB3aWxsCj4+IHByb2JhYmx5
IHRha2UgbWUgYSBmZXcgaXRlcmF0aW9ucyB0byBnZXQgaXQgdG8gd2hlcmUgeW91IHdhbnQgaXQu
IFNvLAo+PiByb3VnaGx5LCB3ZSdkIGNyZWF0ZSBhIHBhc3N0aHJvdWdoX3EgaW4gY29yZSB3aXRo
IHRoZSBjb250cm9sbGVyJ3MgSU8KPj4gdGFnc2V0IGFuZCB0aGVuIGNsZWFudXAgdGhlIGZhYnJp
Y3MgaG9zdHMgdG8gdXNlIHRoYXQgaW5zdGVhZCBvZiBlYWNoCj4+IGluZGVwZW5kZW50bHkgY3Jl
YXRpbmcgdGhlaXIgY29ubmVjdF9xPwo+Pgo+PiBUaG91Z2gsIEkgZG9uJ3QgdW5kZXJzdGFuZCBo
b3cgdGhpcyByZWxhdGVzIHRvIHRoZSBob3N0IHhhcnJheSBzdHVmZgo+PiB0aGF0IFNhZ2kgbWVu
dGlvbmVkLi4uCj4gCj4gcGFzc3RocnUgY29tbWFuZHMgYXJlIGluIGVzc2VuY2UgUkVRX09QX0RS
Vl9JTi9SRVFfT1BfRFJWX09VVCwgd2hpY2gKPiBtZWFucyB0aGF0IHRoZSBkcml2ZXIgc2hvdWxk
bid0IG5lZWQgdGhlIG5zIGF0IGFsbC4gU28gaWYgeW91IGhhdmUgYQo+IGRlZGljYXRlZCByZXF1
ZXN0IHF1ZXVlIChtYXBwZWQgdG8gdGhlIEkvTyB0YWdzZXQpLCB5b3UgZG9uJ3QgbmVlZCB0aGUK
PiBucy0+cXVldWUgYW5kIHdlIGNhbiBsb3NlIHRoZSBucyBsb29rdXAgYWx0b2dldGhlci4KPiAK
PiBUaGUgb25seSBwYXJ0IGlzIHRvIGNoZWNrIHRoZSBlZmZlY3RzLCBidXQgdGhhdCBjYW4gcHJv
YmFibHkgYmUgaGFuZGxlZAo+IHdoZW4gd2Ugc2V0dXAgdGhlIHBhc3N0aHJ1IGNvbnRyb2xsZXIg
b3Igc29tZXRoaW5nLi4uCgpZZXMsIEkgaW1wbGVtZW50ZWQgdGhlIHBhc3N0aHJ1X3EgKHdoaWNo
IHdhcyBxdWl0ZSBzaW1wbGUpLiBCdXQgSSdtIG5vdApzdXJlIGhvdyB3ZSBhcmUgc3VwcG9zZWQg
dG8gY2FsbCBudm1lX2NvbW1hbmRfZWZmZWN0cygpIGNvcnJlY3RseQp3aXRob3V0IHRoZSBucy4g
WW91IGNhbid0IHBvc3NpYmx5IGRvIHRoYXQgZHVyaW5nIHNldHVwIGZvciBldmVyeQpwb3NzaWJs
ZSBvcGNvZGUgb24gZXZlcnkgbmFtZXNwYWNlLiBBbmQgZXZlbiBpZiB3ZSBkbywgd2UnbGwgc3Rp
bGwgbmVlZAp0aGUgc2FtZSBudm1lX2ZpbmRfZ2V0X25zKCkgYW5kIG52bWVfcHV0X25zKCkgZXhw
b3J0cyBhbmQgcHJvYmFibHkKYW5vdGhlciB4YXJyYXkgdG8gbG9va3VwIHRoZSBpbmZvcm1hdGlv
bi4KCkFsc28sIHdlIHBhc3MgdGhlIG5hbWVzcGFjZSdzIGRpc2sgdG8gaW4gb3JkZXIgdG8gZ2V0
IHByb3BlciBibG9jawphY2NvdW50aW5nIGZvciB0aGUgdW5kZXJseWluZyBkaXNrLiAoV2hpY2gg
aXMgcHJldHR5IGltcG9ydGFudCBmb3IKZGVidWdnaW5nKS4gU28gd2UgbmVlZCB0byBsb29rdXAg
dGhlIG5hbWVzcGFjZSBmb3IgdGhpcyB0b28uCgpVbmxlc3MgdGhlcmUgYXJlIHNvbWUgb3RoZXIg
aWRlYXMgdG8gc29sdmUgdGhlc2UgaXNzdWVzLCBJIGRvbid0IHRoaW5rCnRoaXMgY2hhbmdlIHdp
bGwgZ2FpbiB1cyBhbnl0aGluZy4KCkxvZ2FuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
