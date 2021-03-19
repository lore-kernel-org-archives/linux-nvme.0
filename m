Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E983C433C1
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:30:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E669F6197A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E669F6197A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SvrJzkK6SAEsY6eupLk4yzToq58q77tKjuP9F2wQVMY=; b=QcQzS8ST3UFttb1HLeZmvV7qK
	Ne7p+cyef2h8WjMLUbEb1WARLOcJpHrRi7Z66ZXJtsplj+jzDlBrAc1i7FqiuBv9zIirWwJaY8AqW
	bO3PxsvKpsJHaM/mdbzN+7mtgOw06TQpMAuFgxF1eeX6zKOyh80R7eTwBdOOgT7f5uUO2MaCeLJzO
	gM8efqiyh7KZ2h+y7qwAtfMMGKYqTRkUqTsjR/u7kTxWLXCSO+9wwBOXgOd6GIjtJwQvK7pQjpfH9
	Y2ROKoxwLKi6I8n8QGUIhL2wbtyvNS5u0zmbaBxGQDoh6nTBCOttPFdkk33ClCf6s+Z/rGElhAKWK
	HA2XxgCbQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNIx4-007qbR-GA; Fri, 19 Mar 2021 17:30:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNIx1-007qaj-53
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 17:30:21 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D4656191C;
 Fri, 19 Mar 2021 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616175016;
 bh=xDKw2+GLytwOPQR820i4G4E0SGEccFBdpK0AjCLbH3I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=COGyDQyLKpX3K5Hi+8ipdXCX7TaWWkl1U1ozllr4xPPvS8Dzwd9ANq4bM3zTvNgKs
 bGRR/s+1/K/HQzwvK9Xp5pIH1XFUWiMzcloyuEuNikAD+WhX6ILydvUb6cFHFezQjN
 W9evtCwMKLk6L3s/704rmG5ZWwhDxEc2gvQZuoo7v7MywaaASyIaInDZxRBulUtto3
 Zu9nS/H/DjlJI02TLGUVvbre3b9kHMlweLKhhsUQWN4Wq07eLjJeiKZKgqitWKKAQc
 22wWHTYvdLceZNpaY//Tw0eR1dplu6Gqsr88Ugur298d19QIPSde2PywPMcKYzrOUa
 cSSMQgcSMJCnA==
Date: Sat, 20 Mar 2021 02:30:09 +0900
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Message-ID: <20210319173009.GA4198@redsun51.ssa.fujisawa.hgst.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
 <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
 <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
 <20210318194653.GA2690@dhcp-10-100-145-180.wdc.com>
 <20210319065158.GA11263@lst.de>
 <20210319152208.GA3794@redsun51.ssa.fujisawa.hgst.com>
 <20210319153008.GA14280@lst.de>
 <49CFFA55-5A71-4C0D-8816-11EB88087AAA@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49CFFA55-5A71-4C0D-8816-11EB88087AAA@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_173019_460043_6CE995D5 
X-CRM114-Status: GOOD (  18.28  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBNYXIgMTksIDIwMjEgYXQgMDU6MjE6MjJQTSArMDAwMCwgQWxhbiBBZGFtc29uIHdy
b3RlOgo+IAo+IAo+ID4gT24gTWFyIDE5LCAyMDIxLCBhdCA4OjMwIEFNLCBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4gd3JvdGU6Cj4gPiAKPiA+IE9uIFNhdCwgTWFyIDIwLCAyMDIxIGF0
IDEyOjIyOjA4QU0gKzA5MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOgo+ID4+PiBJIHRoaW5rIHRoaXMg
aXMgYSBob3JyaWJsZSBpZGVhLiAgVXNlcnNwYWNlIGhhcyBubyBidXNpbmVzcyB0b3VjaGluZwo+
ID4+PiByZWdpc3RlcnMgZXZlbiByZWFkLW9ubHkuICBNTUlPIHJlYWRzIGNhbiBoYXZlIHNpZGUg
ZWZmZWN0cyBhcyB3ZWxsLAo+ID4+PiBpbnRlbnRpb25hbCBvciB1bmludGVudGlvbmFsLCBhbmQg
d2UgYWxzbyBvcGVuIHVwIGEgd2hvbGUgY2FuIG9mIHdvcm1zCj4gPj4+IG9mIG1pc21hdGNoZWQg
bWVtb3J5IGF0dHJpYnV0ZXMuCj4gPj4gCj4gPj4gSSB3YXMgdGhpbmtpbmcgdGhlIGRyaXZlciB3
b3VsZG4ndCBvcHQtaW4gaWYgdGhlcmUgd2VyZSByZWFkIHNpZGUKPiA+PiBlZmZlY3RzLCBidXQg
eWVhaCwgaXQncyB0b28gZnJhZ2lsZS4gSSB3aXRoZHJhdyB0aGUgc3VnZ2VzdGlvbi4KPiA+IAo+
ID4gSSdkIHN0aWxsIGxpa2UgdG8gdW5kZXJzdGFuZCB3aGF0IHZhbHVlcyBpbiBDU1RTIEFsYW4g
Y2FyZXMgYWJvdXQuICBJCj4gPiBkb24ndCB0aGluayBqdXN0IGR1bXBpbmcgYSByZWdpc3RlciB3
aXRoIHNvbWV3aGF0IGF3a3dhcmQgZW5jb2RpbmdzCj4gPiBpcyBhIGdvb2QgaWRlYS4KPiAKPiBQ
cmltYXJpbHkgUmVhZHkgYW5kIEZhaWxlZC4gSeKAmW0gcmVhY2hpbmcgb3V0IHRvIHRoZSByZXF1
ZXN0aW5nIHRlYW0gdG8gc2VlIGlmIHRoZSDigJlzdGF0ZeKAmSBhdHRyaWJ1dGUgaXMgc3VmZmlj
aWVudC4KPiAKPiBCYWNrIHRvIG52bWUtY2xpIHNob3ctcmVncywgZG8gd2UganVzdCBleHBlY3Qg
dGhpcyB0byBhbHdheXMgZmFpbCBub3cgb3VyIHNob3VsZCB3ZSBiZSByZXR1cm5pbmcgZ29vZAo+
IHZhbHVlcz8KCkZvciBQQ0llLCB0aGF0IHNoZWxsIGNvbW1hbmQgcmV0dXJucyBnb29kIHZhbHVl
cyBvbmx5IGlmIHRoZSBrZXJuZWwKd2Fzbid0IGNvbXBpbGVkIHdpdGggQ09ORklHX0lPX1NUUklD
VF9ERVZNRU0uIElmIHRoZSBrZXJuZWwgd2FzIGNvbXBpbGVkCndpdGggdGhhdCBvcHRpb24gKG1v
c3QgYXJlKSwgdXNlciBzcGFjZSB3aWxsIG5vdCBiZSBhYmxlIHRvIGFjY2VzcyB0aGUKdmFsdWVz
LgoKRmFicmljcyBzaG91bGQgYWx3YXlzIHdvcmssIHRob3VnaCwgYmVjYXVzZSB3ZSByZXRyaWV2
ZSBDU1RTIHRocm91Z2ggYW4KYWRtaW4gY29tbWFuZCByYXRoZXIgdGhhbiBtZW1vcnkgbWFwcGVk
IElPLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
