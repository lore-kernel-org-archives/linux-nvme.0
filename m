Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F22C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 11:33:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733FA206B7
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 11:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FKNqo6Up";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="IAGYpxrf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oSXxgbAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733FA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RCW948igYhnTrHCNADKQ1IhWwcmTpxtTcTd3Wl4UD6k=; b=FKNqo6UpCcJ4IbSrg4tKNHf8d
	tqvEtko7FZpmeMmTJBkOBh+MdXTidftjK6QyTJybIoUYapY68Ruz80Vt55fN4pPbfzMAdlZQqcPN4
	JfTix7o9mfE/9BGqpKQBdxgpg7dvdcn5cdKyv6j77OOqZ/wpOl+mMYUMdbQCt5+emb9EldQdEFdAB
	laONOydtk2F2zSGTUpIRoIQvlo0X9gGrvf20ZLiEgqmHpPoyMN/5VqOCERL9wCqL97RGjU46wOA4s
	G3ac4OputagwfbRlJ4aYi77wgz/r0FFBcp44CNtOW3ybp9ga0s5ujR257SSqQp0iOW88f4ciNoQmw
	z7HIv4esw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kE9yJ-0008Aa-J5; Fri, 04 Sep 2020 11:33:35 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kE9yG-00089Z-HD
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 11:33:33 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id DAC7F5C014F;
 Fri,  4 Sep 2020 07:33:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Fri, 04 Sep 2020 07:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=e
 21isrullm938WioMZ4USxRQd5tKjLJW37GgaCG2k8g=; b=IAGYpxrf0bBSJufwa
 u1ryZ+fAhTW1uhXiUEBlU9aDoSvUP6lYbJ+z0RNyAnvq8K3mHEE0zSp/yuMwHOo3
 8bXwKn/tsCkaH7i9tiqN6OWBFwLQD+OeAlQM1TwQdyZ0RSr1BustuRGg75Lc85OF
 CIlpPUCNxMKNKZl12Due987y7rWS2F+uLeCrlXgeKwrro1kQvy7NPr91MBCay+WM
 xwGHODVJobvWrdZF7ygdKnNKcJ7yZiHSvKaH+e3snvhUYEqtPHUqNJJfc6F569HS
 tNAjvIFC0qKqld2dOWxy+kyStWjxgSuzF/sWZf/gAudZ+SW5kRvX2ieLV6pdwm87
 6cGUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=e21isrullm938WioMZ4USxRQd5tKjLJW37GgaCG2k
 8g=; b=oSXxgbAUL+zs44BOZO1PZbIFDomVETWtpOg7GbZNOkhAWgO/vFjxHNAE4
 XhLt4YsFSJ3l6iRUrZzESlz5kXBbEzyOBPGS+fONRXIcZWCCvvcFFyoJP8sL358J
 Bqj3/eeI/FBHh94pGKFojCLk8uPWuY53e/AgT/q8FYBeu1l0FHCzC8fg8UVmMyd8
 W/q9s290QvSkU5fhWubrszmNfVsXvC/Hmnpbd9Rz0LIcnMxRDYv6hVs/z2az92W6
 uQcJcUdr20Czv0BgP/HrmQ+GGObsQVuzdI6kSD64QS4RhXJVzZeeLtqwTRnaR7ac
 QFUDx5/Cf4lMNBSnW+4Q9jqhbobjA==
X-ME-Sender: <xms:BSZSXyBLZ2Yuh99cDtmIZ256ndBvbHwgSS-oLJFUG_FxpuBpmJ2SZA>
 <xme:BSZSX8jY77Ae0qxEsoKNfaMEvyMpGmjwsK4yQFQ_fsOZ4kBSOj6sNmg3oNqdK-gwj
 HJHYKs9vU2RKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegfedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
 ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjedtud
 elkeeufefhiefhvdfgfeetuddtjefgkedvheehgfehieekheetfeehtefgnecuffhomhgr
 ihhnpehsphhinhhitghsrdhnvghtnecukfhppeekfedrkeeirdejgedrieegnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhho
 rghhrdgtohhm
X-ME-Proxy: <xmx:BSZSX1lVoxIoyrvUUKLTeF9nV_a78-6TvTcQmon4XzXwU_Pu3KRJZA>
 <xmx:BSZSXwy5KM-oL01OrxAMklrWNX7OnTIXJYrE01yoIdLYPkDwU8Q1rA>
 <xmx:BSZSX3RW6wUi_plgKq6OkKahP-_lEkiTNbrnH4XYD6RWc0dsHKIv9Q>
 <xmx:CCZSX2G4vYRC82u_y20lVo9GqUC_OniYGRRzdXcxJTvy6ftjqU9fYg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6FDCA3060057;
 Fri,  4 Sep 2020 07:33:25 -0400 (EDT)
Date: Fri, 4 Sep 2020 13:33:47 +0200
From: Greg KH <greg@kroah.com>
To: Dakshaja Uppalapati <dakshaja@chelsio.com>
Subject: Re: [PATCH for-stable nvmet 0/6] nvme: Fix for blk_update_request IO
 error.
Message-ID: <20200904113347.GC2831752@kroah.com>
References: <20200611155339.9429-1-dakshaja@chelsio.com>
 <20200617141541.GA712019@dhcp-10-100-145-180.wdl.wdc.com>
 <20200622112143.GA25601@chelsio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200622112143.GA25601@chelsio.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_073332_892177_7CBA1425 
X-CRM114-Status: GOOD (  25.36  )
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
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBKdW4gMjIsIDIwMjAgYXQgMDQ6NTE6NDRQTSArMDUzMCwgRGFrc2hhamEgVXBwYWxh
cGF0aSB3cm90ZToKPiBPbiBXZWRuZXNkYXksIEp1bmUgMDYvMTcvMjAsIDIwMjAgYXQgMDc6MTU6
NDEgLTA3MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOgo+ID4gT24gVGh1LCBKdW4gMTEsIDIwMjAgYXQg
MDk6MjM6MzNQTSArMDUzMCwgRGFrc2hhamEgVXBwYWxhcGF0aSB3cm90ZToKPiA+ID4gVGhlIGJl
bG93IGVycm9yIGlzIHNlZW4gaW4gZG1lc2csIHdoaWxlIGZvcm1hdHRpbmcgdGhlIGRpc2tzIGRp
c2NvdmVyZWQgb24gaG9zdC4KPiA+ID4gCj4gPiA+IGRtZXNnOgo+ID4gPiAgICAgICAgIFsgIDYz
Ni43MzMzNzRdIGJsa191cGRhdGVfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgbnZtZTRuMSwgc2Vj
dG9yIDAgb3AgMHgzOihESVNDQVJEKSBmbGFncyAweDgwMCBwaHlzX3NlZyAxIHByaW8gY2xhc3Mg
MAo+ID4gPiAKPiA+ID4gUGF0Y2ggNiBmaXhlcyBpdCBhbmQgdGhlcmUgYXJlIDUgb3RoZXIgZGVw
ZW5kZW50IHBhdGNoZXMgdGhhdCBhbHNvIG5lZWQgdG8gYmUgCj4gPiA+IHB1bGxlZCBmcm9tIHVw
c3RyZWFtIHRvIHN0YWJsZSwgNS40IGFuZCA0LjE5IGJyYW5jaGVzLgo+ID4gPiAKPiA+ID4gUGF0
Y2ggMSBkZXBlbmRlbnQgcGF0Y2gKPiA+ID4gCj4gPiA+IFBhdGNoIDIgZGVwZW5kZW50IHBhdGNo
Cj4gPiA+IAo+ID4gPiBQYXRjaCAzIGRlcGVuZGVudCBwYXRjaAo+ID4gPiAKPiA+ID4gUGF0Y2gg
NCBkZXBlbmRlbnQgcGF0Y2gKPiA+ID4gCj4gPiA+IFBhdGNoIDUgZGVwZW5kZW50IHBhdGNoCj4g
PiA+IAo+ID4gPiBQYXRjaCA2IGZpeCBwYXRjaAo+ID4gCj4gPiAxLiBZb3UgbmVlZCB0byBjb3B5
IHRoZSBsaW51eC1udm1lIG1haW5saW5nIGxpc3QgZm9yIGxpbnV4IG52bWUga2VybmVsIHBhdGNo
ZXMuCj4gPiAKPiA+IDIuIElmIHlvdSdyZSBzZW5kaW5nIHNvbWVvbmUgZWxzZSdzIHBhdGNoLCB0
aGUgcGF0Y2ggaXMgc3VwcG9zZWQgdG8gaGF2ZQo+ID4gdGhlIEZyb206IHRhZyBzbyB0aGUgYXV0
aG9yIGlzIGFwcHJvcHJpYXRlbHkgaWRlbnRpZmllZC4KPiA+IAo+ID4gMy4gU3RhYmxlIHBhdGNo
ZXMgbXVzdCByZWZlcmVjZSB0aGUgdXBzdHJlYW0gY29tbWl0IElELgo+ID4gCj4gPiBBcyBmb3Ig
dGhpcyBwYXJ0aWN1bGFyIGlzc3VlLCB3aGlsZSBzdGFibGUgcGF0Y2hlcyBhcmUgcmVxdWlyZWQg
dG8KPiA+IHJlZmVyZW5jZSBhbiB1cHN0cmVhbSBjb21taXQsIHlvdSBkb24ndCBuZWVkIHRvIGJy
aW5nIGluIGRlcGVuZGVudAo+ID4gcGF0Y2hlcy4gWW91IGFyZSBhbGxvd2VkIHRvIHdyaXRlIGFu
IGVxdWl2YWxlbnQgZml4IHNwZWNpZmljIHRvIHRoZQo+ID4gc3RhYmxlIGJyYW5jaCBzbyB0aGF0
IHN0YWJsZSBkb2Vzbid0IG5lZWQgdG8gdGFrZSBhIGJ1bmNoIG9mIHVucmVsYXRlZAo+ID4gY2hh
bmdlcy4gRm9yIGV4YW1wbGUsIGl0IGxvb2tzIGxpa2UgdGhpcyBwYXJ0aWN1bGFyIGlzc3N1ZSBj
YW4gYmUgZml4ZWQKPiA+IHdpdGggdGhlIGZvbGxvd2luZyBzaW1wbGUgc3RhYmxlIHBhdGNoOgo+
ID4KPiAKPiBIaSBrZWl0aCwKPiAKPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuCj4gCj4gSSBpbml0
aWFsbHkgdHJpZWQgcHVzaGluZyBvbmx5IHRoZSBmaXggKyByZXF1aXJlZCBwb3J0aW9uIG9mIHRo
ZSBkZXBlbmRlbnQgCj4gcGF0Y2hlcyhodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9zdGFi
bGUvbXNnMzg3NzQ0Lmh0bWwpIGJ1dCBhcyB0aGF0IAo+IGFwcHJvYWNoIGlzIGRpc2NvdXJhZ2Vk
IGluIHN0YWJsZSB0cmVlLCBJIHN1Ym1pdHRlZCBhbGwgdGhlIHBhdGNoZXMgYXMgaXQgaXMuCj4g
Cj4gSGVyZSBhcmUgdGhlIHdheXMgdG8gZml4IHRoZSBpc3N1ZSBpbiBzdGFibGUgdHJlZToKPiAK
PiDigKIgIHB1c2ggZml4ICsgYWxsIGRlcGVuZGVudCBwYXRjaGVzCj4g4oCiICBwdXNoIGZpeCAr
IGN1c3RvbSBwYXRjaCBvZiBkZXBlbmRlbnQgcGF0Y2hlcwo+IOKAoiAgcmV2ZXJ0IHRoZSBjdWxw
cml0IHBhdGNoLgo+IAo+IFBsZWFzZSBsZXQgbWUga25vdyBob3cgdGhpcyBpc3N1ZSBjYW4gYmUg
cmVzb2x2ZWQgaW4gc3RhYmxlIHRyZWUuCgpJcyB0aGlzIHN0aWxsIGFuIGlzc3VlPwoKSSBjYW4n
dCB0YWtlIGEgc2VyaWVzIG9mIHBhdGNoZXMgdGhhdCBpcyBub3QgaW4gTGludXMncyB0cmVlLCBs
aWtlIHlvdQpzZW50IGhlcmUsIHRoYXQncyBhIG5vbi1zdGFydGVyLgoKSWYgeW91IHdhbnQgc3Bl
Y2lmaWMgY29tbWl0cyB0byBiZSBhcHBsaWVkLCB0aGF0IGlzIG9uZSB0aGluZywgYW5kIGlmCnlv
dSBuZWVkIGEgc3BlY2lmaWMgcGF0Y2ggdG8gYmUgcmV2ZXJ0ZWQgYmVjYXVzZSBpdCBicmVha3Mg
dGhpbmdzLApwbGVhc2UgcHJvdmlkZSB0aGF0IGdpdCBpZC4KCmNvbmZ1c2VkLAoKZ3JlZyBrLWgK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
