Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4600C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:56:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C28A23601
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C28A23601
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SXaPCBby3wpn4RbbLBeQHs0UgzAIt7eDx1DP6OCF0E4=; b=rERb9ccR0KKWpiCIYIN1SVclS
	5UzNLU9wC/Ebzvrs9T5Q5G3nG/9jLQGdHaGN0blHBqN8aoyCnrPX8WpC5vLmKHs/nK46pNz6vx9cT
	XjjEf9qLSHslfDs4NlyEm67bTQQLsfHlTpp8bDrmYNqEtSGSGaB8C537V3cgR0MMI9HL/0TvOnV5Z
	ubHrRmXfPwm6Y/1Pvak+xtkt1v29HI84IY/Ow4Q2RyAarwDZ6KFfoh+v/86DtxU1rd6V0wpv9fhqK
	bfm+vweY7h79CZC6T20x8RgwIDFeU4oHy6iPl7m8Ya452vbGam5yNu0U1OSGXA39mA6dV3NicVIQV
	jZK5WNRLQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmHw5-0005MN-Eb; Mon, 07 Dec 2020 14:56:21 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmHw3-0005Lz-Tt
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 14:56:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7663EAB63;
 Mon,  7 Dec 2020 14:56:17 +0000 (UTC)
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
To: Christoph Hellwig <hch@lst.de>, SelvaKumar S <selvakuma.s1@samsung.com>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
Date: Mon, 7 Dec 2020 15:56:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207141123.GC31159@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_095620_084755_32D7EC8E 
X-CRM114-Status: GOOD (  22.76  )
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
Cc: axboe@kernel.dk, damien.lemoal@wdc.com, sagi@grimberg.me,
 snitzer@redhat.com, selvajove@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
 joshi.k@samsung.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
 kbusch@kernel.org, javier.gonz@samsung.com, linux-scsi@vger.kernel.org,
 nj.shetty@samsung.com, Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvNy8yMCAzOjExIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBTbywgSSdtIHJl
YWxseSB3b3JyaWVkIGFib3V0Ogo+IAo+ICAgYSkgYSBnb29kIHVzZSBjYXNlLiAgR0MgaW4gZjJm
cyBvciBidHJmcyBzZWVtIGxpa2UgZ29vZCB1c2UgY2FzZXMsIGFzCj4gICAgICBkb2VzIGFjY2Vs
YXRpbmcgZG0ta2NvcHlkLiAgSSBhZ3JlZSB3aXRoIERhbWllbiB0aGF0IGxpZnRpbmcgZG0ta2Nv
cHlkCj4gICAgICB0byBjb21tb24gY29kZSB3b3VsZCBhbHNvIGJlIHJlYWxseSBuaWNlLiAgSSdt
IG5vdCAxMDAlIHN1cmUgaXQgc2hvdWxkCj4gICAgICBiZSBhIHJlcXVpcmVtZW50LCBidXQgaXQg
c3VyZSB3b3VsZCBiZSBuaWNlIHRvIGhhdmUKPiAgICAgIEkgZG9uJ3QgdGhpbmsganVzdCBhZGRp
bmcgYW4gaW9jdGwgaXMgZW5vdWdoIG9mIGEgdXNlIGNhc2UgZm9yIGNvbXBsZXgKPiAgICAgIGtl
cm5lbCBpbmZyYXN0cnVjdHVyZS4KPiAgIGIpIFdlIGhhZCBhIGJ1bmNoIG9mIGRpZmZlcmVudCBh
dHRlbXB0cyBhdCBTQ1NJIFhDT1BZIHN1cHBvcnQgZm9ybSBJSVJDCj4gICAgICBNYXJ0aW4sIEJh
cnQgYW5kIE1pa3VsYXMuICBJIHRoaW5rIHdlIG5lZWQgdG8gcHVsbCB0aGVtIGludG8gdGhpcwo+
ICAgICAgZGlzY3Vzc2lvbiwgYW5kIG1ha2Ugc3VyZSB3aGF0ZXZlciB3ZSBkbyBjb3ZlcnMgdGhl
IFNDU0kgbmVlZHMuCj4gCkFuZCB3ZSBzaG91bGRuJ3QgZm9yZ2V0IHRoYXQgdGhlIG1haW4gaXNz
dWUgd2hpY2gga2lsbGVkIGFsbCBwcmV2aW91cyAKaW1wbGVtZW50YXRpb25zIHdhcyBhIG1pc3Np
bmcgUW9TIGd1YXJhbnRlZS4KSXQncyBuaWNlIHRvIGhhdmUgc2ltcGx5IGNvcHksIGJ1dCBpZiB0
aGUgaW1wbGVtZW50YXRpb24gaXMgX3Nsb3dlcl8gCnRoYW4gZG9pbmcgaXQgYnkgaGFuZCBmcm9t
IHRoZSBPUyB0aGVyZSBpcyB2ZXJ5IGxpdHRsZSBwb2ludCBpbiBldmVuIAphdHRlbXB0aW5nIHRv
IGRvIHNvLgpJIGNhbid0IHNlZSBhbnkgcHJvdmlzaW9ucyBmb3IgdGhhdCBpbiB0aGUgVFBBUiwg
bGVhZGluZyBtZSB0byB0aGUgCmFzc3VtcHRpb24gdGhhdCBOVk1lIHNpbXBsZSBjb3B5IHdpbGwg
c3VmZmVyIGZyb20gdGhlIHNhbWUgaXNzdWUuCgpTbyBpZiB3ZSBjYW4ndCBhZGRyZXNzIHRoaXMg
SSBndWVzcyB0aGlzIGF0dGVtcHQgd2lsbCBmYWlsLCB0b28uCgpDaGVlcnMsCgpIYW5uZXMKLS0g
CkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0
ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQw
NTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBG
ZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
