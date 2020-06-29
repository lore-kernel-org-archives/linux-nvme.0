Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C888C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 13:56:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098BC23D51
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eLqxKd86";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cA6McJhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098BC23D51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4RZ20fXKw71+KYiHeBMxrYcIxzWUHKP5goWCuVRD7Pw=; b=eLqxKd865doO1ufisD71nB18/
	qJZGQwK1lr7ZD2yiGa29q7MUbvXWjaL3IgZ8JWfE18XEjU9U0icmhzRhfHT8E9pjxekDuext2VENu
	2n5BLBo+/KlZTHJwE+G8DzGF0ePyMtmL6mPeyrMZlflPUNcRpZ3hNKC52yjbp5kATeWuETPKw2rVK
	AwoeCNw/BX1/hgTvPYbGl20KSICMH7p48GBwOPj5IThchre392KR5hT2iK94fn3AvehqYlYjO/m+3
	j1gCC94HkE8+Xc1SZj9NNGsxA7KSSoplGkCllI5MyNn/CAkMvwp2PVthLwoE0N4FqdcNuyT0NI3yx
	SKgEHtC/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpuGQ-0003Fv-SI; Mon, 29 Jun 2020 13:56:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpuGP-0003Fl-01
 for linux-nvme@merlin.infradead.org; Mon, 29 Jun 2020 13:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=AUwqO0o7JEqo0AObNG4Zkx63aN1zbaPYEcxPJVwMW5c=; b=cA6McJhDIP1OxAZGyGH0xnU9ii
 dRoNeHFnk9iZqkyHFEbd6lom969F9wU2DgSfxS+OS6RANAk2/QmJX3Ha1DE+2zMvUAAh/vs3JMoOz
 fvSf/jGwiXQ/uOokYXAjqA0fJIXrSGjdVe8AIqQ7Pj6VSLCVVNPNX2tMhRa2umdDxa71IYlBHt0+2
 hfntIuqwal2afA3dAa1Bmdf0Fcs+0uwpQuxCFza0LhDBKgMg/eOeorGRQqU3l6HQKnWWl+jgb2Ptt
 UvHrjW+/7yS/0TrsNabVKKDMhxk9kvg/OBd+r5zI0NlwWGEdN9s0tYi8dcUoy/9yojb/BMaFeXx3p
 VRyN8e9Q==;
Received: from stargate.chelsio.com ([12.32.117.8])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpuGK-0007PK-28
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 13:56:00 +0000
Received: from localhost (moto.blr.asicdesigners.com [10.193.184.79] (may be
 forged))
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 05TDt0rP010969;
 Mon, 29 Jun 2020 06:55:01 -0700
Date: Mon, 29 Jun 2020 19:25:00 +0530
From: Dakshaja Uppalapati <dakshaja@chelsio.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH for-stable nvmet 0/6] nvme: Fix for blk_update_request IO
 error.
Message-ID: <20200629135459.GA32129@chelsio.com>
References: <20200611155339.9429-1-dakshaja@chelsio.com>
 <20200617141541.GA712019@dhcp-10-100-145-180.wdl.wdc.com>
 <20200622112143.GA25601@chelsio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200622112143.GA25601@chelsio.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200629_145556_688610_DDD19395 
X-CRM114-Status: GOOD (  25.18  )
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
Cc: sagi@grimberg.me, eduard@hasenleithner.at,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Nirranjan Kirubaharan <nirranjan@chelsio.com>, stable@vger.kernel.org,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uZGF5LCBKdW5lIDA2LzIyLzIwLCAyMDIwIGF0IDE2OjUxOjQzICswNTMwLCBEYWtzaGFq
YSBVcHBhbGFwYXRpIHdyb3RlOgo+IE9uIFdlZG5lc2RheSwgSnVuZSAwNi8xNy8yMCwgMjAyMCBh
dCAwNzoxNTo0MSAtMDcwMCwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gPiBPbiBUaHUsIEp1biAxMSwg
MjAyMCBhdCAwOToyMzozM1BNICswNTMwLCBEYWtzaGFqYSBVcHBhbGFwYXRpIHdyb3RlOgo+ID4g
PiBUaGUgYmVsb3cgZXJyb3IgaXMgc2VlbiBpbiBkbWVzZywgd2hpbGUgZm9ybWF0dGluZyB0aGUg
ZGlza3MgZGlzY292ZXJlZCBvbiBob3N0Lgo+ID4gPiAKPiA+ID4gZG1lc2c6Cj4gPiA+ICAgICAg
ICAgWyAgNjM2LjczMzM3NF0gYmxrX3VwZGF0ZV9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBudm1l
NG4xLCBzZWN0b3IgMCBvcCAweDM6KERJU0NBUkQpIGZsYWdzIDB4ODAwIHBoeXNfc2VnIDEgcHJp
byBjbGFzcyAwCj4gPiA+IAo+ID4gPiBQYXRjaCA2IGZpeGVzIGl0IGFuZCB0aGVyZSBhcmUgNSBv
dGhlciBkZXBlbmRlbnQgcGF0Y2hlcyB0aGF0IGFsc28gbmVlZCB0byBiZSAKPiA+ID4gcHVsbGVk
IGZyb20gdXBzdHJlYW0gdG8gc3RhYmxlLCA1LjQgYW5kIDQuMTkgYnJhbmNoZXMuCj4gPiA+IAo+
ID4gPiBQYXRjaCAxIGRlcGVuZGVudCBwYXRjaAo+ID4gPiAKPiA+ID4gUGF0Y2ggMiBkZXBlbmRl
bnQgcGF0Y2gKPiA+ID4gCj4gPiA+IFBhdGNoIDMgZGVwZW5kZW50IHBhdGNoCj4gPiA+IAo+ID4g
PiBQYXRjaCA0IGRlcGVuZGVudCBwYXRjaAo+ID4gPiAKPiA+ID4gUGF0Y2ggNSBkZXBlbmRlbnQg
cGF0Y2gKPiA+ID4gCj4gPiA+IFBhdGNoIDYgZml4IHBhdGNoCj4gPiAKPiA+IDEuIFlvdSBuZWVk
IHRvIGNvcHkgdGhlIGxpbnV4LW52bWUgbWFpbmxpbmcgbGlzdCBmb3IgbGludXggbnZtZSBrZXJu
ZWwgcGF0Y2hlcy4KPiA+IAo+ID4gMi4gSWYgeW91J3JlIHNlbmRpbmcgc29tZW9uZSBlbHNlJ3Mg
cGF0Y2gsIHRoZSBwYXRjaCBpcyBzdXBwb3NlZCB0byBoYXZlCj4gPiB0aGUgRnJvbTogdGFnIHNv
IHRoZSBhdXRob3IgaXMgYXBwcm9wcmlhdGVseSBpZGVudGlmaWVkLgo+ID4gCj4gPiAzLiBTdGFi
bGUgcGF0Y2hlcyBtdXN0IHJlZmVyZWNlIHRoZSB1cHN0cmVhbSBjb21taXQgSUQuCj4gPiAKPiA+
IEFzIGZvciB0aGlzIHBhcnRpY3VsYXIgaXNzdWUsIHdoaWxlIHN0YWJsZSBwYXRjaGVzIGFyZSBy
ZXF1aXJlZCB0bwo+ID4gcmVmZXJlbmNlIGFuIHVwc3RyZWFtIGNvbW1pdCwgeW91IGRvbid0IG5l
ZWQgdG8gYnJpbmcgaW4gZGVwZW5kZW50Cj4gPiBwYXRjaGVzLiBZb3UgYXJlIGFsbG93ZWQgdG8g
d3JpdGUgYW4gZXF1aXZhbGVudCBmaXggc3BlY2lmaWMgdG8gdGhlCj4gPiBzdGFibGUgYnJhbmNo
IHNvIHRoYXQgc3RhYmxlIGRvZXNuJ3QgbmVlZCB0byB0YWtlIGEgYnVuY2ggb2YgdW5yZWxhdGVk
Cj4gPiBjaGFuZ2VzLiBGb3IgZXhhbXBsZSwgaXQgbG9va3MgbGlrZSB0aGlzIHBhcnRpY3VsYXIg
aXNzc3VlIGNhbiBiZSBmaXhlZAo+ID4gd2l0aCB0aGUgZm9sbG93aW5nIHNpbXBsZSBzdGFibGUg
cGF0Y2g6Cj4gPgo+IAo+IEhpIGtlaXRoLAo+IAo+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4KPiAK
PiBJIGluaXRpYWxseSB0cmllZCBwdXNoaW5nIG9ubHkgdGhlIGZpeCArIHJlcXVpcmVkIHBvcnRp
b24gb2YgdGhlIGRlcGVuZGVudCAKPiBwYXRjaGVzKGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xp
c3RzL3N0YWJsZS9tc2czODc3NDQuaHRtbCkgYnV0IGFzIHRoYXQgCj4gYXBwcm9hY2ggaXMgZGlz
Y291cmFnZWQgaW4gc3RhYmxlIHRyZWUsIEkgc3VibWl0dGVkIGFsbCB0aGUgcGF0Y2hlcyBhcyBp
dCBpcy4KPiAKPiBIZXJlIGFyZSB0aGUgd2F5cyB0byBmaXggdGhlIGlzc3VlIGluIHN0YWJsZSB0
cmVlOgo+IAo+IOKAoiAgcHVzaCBmaXggKyBhbGwgZGVwZW5kZW50IHBhdGNoZXMKPiDigKIgIHB1
c2ggZml4ICsgY3VzdG9tIHBhdGNoIG9mIGRlcGVuZGVudCBwYXRjaGVzCj4g4oCiICByZXZlcnQg
dGhlIGN1bHByaXQgcGF0Y2guCj4gCj4gUGxlYXNlIGxldCBtZSBrbm93IGhvdyB0aGlzIGlzc3Vl
IGNhbiBiZSByZXNvbHZlZCBpbiBzdGFibGUgdHJlZS4KPgoKSGkga2VpdGgsCgpHZW50bGUgcmVt
aW5kZXIuCgpUaGFua3MsCkRha3NoYWphCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
