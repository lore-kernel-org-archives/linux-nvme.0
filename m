Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3A1C4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 18:34:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E7B2312D
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 18:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E7B2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gRW81jzrFvTad510h995AplO8LaBOIwj8bnBoXvlt14=; b=kRZVTJGxX7bxNeh1mLBXyYRnu
	DlaLuTy6JNfhDBBc4lMjAHxG+mtVU+Zu/QYd+cPNQTZUX+MsZEV/xpQ9ZStZxQPVUahVRzlsq5Jla
	0Xyl4BjusGTE7HDPgGl+WjoW02p60CVv3kBLsv1d0l3Xbdd4CoQvBx6qMDP5fo1lV72ONXqWzYSAr
	rCIRVItl4MxEGKyxVh99AIjn2XxIAyulYSXRA9101+xFxWw4I6Mc8U7Ptc2lQAhNWGLxPRiAHQb0n
	/Kn6hclUEjAWTxa7hpw3q5psyCJWAJHOi9UtiljVOlnieSIguNyKEk/xBLWIWVVd/ZeS4vuH9SQQ+
	sA3FKfs1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmhp7-0003CB-NT; Tue, 08 Dec 2020 18:34:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmhp5-0003Bq-TP
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 18:34:52 +0000
Date: Wed, 9 Dec 2020 03:34:44 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607452490;
 bh=metN/I94YQnvAnTq8UbtPU+beVFSy/UfzRBod5K/Dns=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=k9GmYXlmbwrNv6d5K129w8FJTjQnZifX6t7T49oLt+5D/P2XLj/IJYqlaeCeGjGdH
 3SQlo7wn3KpYtAr1z51kxvlhqJQaPPCaakAYQZWSXuZvEq4o6D5J+Ff+hXNugnHm3P
 N3Znmj3W1Vs8NEkcL0zgxCutT0vamCUglJJUUcm2i0EoNLWXT34WIBR+KgmHDNDjwJ
 qd04LhOr7Rg8zm1nvYeVkKuqdhc0kLWZ8adDV0EdN7HQaaRsb0glGHvSxLK4e7TmTM
 j7So+fl+pkQ6jPE2o2v7znV6nqYbsvqRa2EhOaHl1mEbEqrj7N/Z1xChvrcSiMLJz3
 81kAmPzYG1byQ==
From: Keith Busch <kbusch@kernel.org>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_133452_102147_5C5A41F3 
X-CRM114-Status: GOOD (  21.54  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBEZWMgMDgsIDIwMjAgYXQgMDY6MTU6MDhQTSArMDAwMCwgS25pZ2h0LCBGcmVkZXJp
Y2sgd3JvdGU6Cj4gV2UgY2FuJ3Qgc2VuZCB0aGUgQUVOIGlmIHdlIGNyZWF0ZSB0aGUgQU5BIEdy
b3VwIGJlZm9yZSBjcmVhdGluZyB0aGUgbmFtZXNwYWNlIC0gYmVjYXVzZSB0aGVyZSBpcyBubyBh
dHRhY2hlZCBOUyB0byB3aGljaCB3ZSBjYW4gc2VuZCB0aGUgQUVSLiAgQW5kLCB3ZSBjYW4ndCBj
cmVhdGUgYSBuYW1lc3BhY2UgaW4gYW4gQU5BIGdyb3VwIHVubGVzcyB0aGUgQU5BIGdyb3VwIGFs
cmVhZHkgZXhpc3RzLgo+IAo+IE9LLCBoZXJlIGlzIHRoZSB0ZXh0IHlvdSBhcmUgcXVvdGluZzoK
PiA4LjIwLjMuNglBc3ltbWV0cmljIE5hbWVzcGFjZSBBY2Nlc3MgQ2hhbmdlIE5vdGlmaWNhdGlv
bnMKPiBJZiBBc3ltbWV0cmljIE5hbWVzcGFjZSBBY2Nlc3MgQ2hhbmdlIE5vdGljZXMgYXJlIGVu
YWJsZWQgKHJlZmVyIHRvIHNlY3Rpb24gNS4yMS4xLjExKSBvbiBhIGNvbnRyb2xsZXIsIHRoZW4g
YW4gQXN5bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNzIENoYW5nZSBOb3RpY2Ugc2hhbGwgYmUgc2Vu
dCBieSB0aGUgY29udHJvbGxlcnMgd2hlcmUgdGhlIGNoYW5nZSBvY2N1cnJlZDoKPiBhKQlpZiBh
biBBTkEgR3JvdXAgSWRlbnRpZmllciAocmVmZXIgdG8gRmlndXJlIDI1MSkgY2hhbmdlczsKPiBi
KQlpZiBhbiBhc3ltbWV0cmljIG5hbWVzcGFjZSBhY2Nlc3Mgc3RhdGUgdHJhbnNpdGlvbiBmYWls
cyAoZS5nLiwgYSB0cmFuc2l0aW9uIGJlZ2lucywgYnV0IGRvZXMgbm90IGNvbXBsZXRlIGFuZCB0
aGUgY29udHJvbGxlciByZXR1cm5zIHRvIHRoZSBzdGF0ZSB0aGF0IGV4aXN0ZWQgYmVmb3JlIHRo
ZSB0cmFuc2l0aW9uIGJlZ2FuKTsgb3IKPiBjKQl1cG9uIGVudHJ5IHRvIHRoZSBmb2xsb3dpbmcg
QU5BIHN0YXRlczoKPiDigKIJQU5BIE9wdGltaXplZCBTdGF0ZTsKPiDigKIJQU5BIE5vbi1PcHRp
bWl6ZWQgU3RhdGU7Cj4g4oCiCUFOQSBJbmFjY2Vzc2libGUgU3RhdGU7IGFuZAo+IOKAoglBTkEg
UGVyc2lzdGVudCBMb3NzIFN0YXRlLgo+IAo+IFNvLCB3aGF0IHlvdSdyZSBzYXlpbmcgaXMgdGhh
dCBzdG9yYWdlIGRldGVybWluaW5nIHRoZSBpbml0aWFsIHN0YXRlCj4gaXMgYSBUUkFOU0lUSU9O
LiAgU28gdGhhdCB3b3VsZCBhbHNvIG1lYW4gdGhhdCBhZnRlciBldmVyeSBjb25uZWN0aW9uLAo+
IHlvdSB3b3VsZCBnZXQgYSBGTE9PRCBvZiBBTkEgQ2hhbmdlZCBBRU5zIGFzIHdlIGRpc2NvdmVy
IHRoZSBpbml0aWFsCj4gc3RhdGUgb2YgZWFjaCBBTkEgZ3JvdXAsIGFuZCBUUkFOU0lUSU9OIHRo
YXQgZ3JvdXAgZnJvbSA8dW5rbm93bj4gdG8KPiBvcHRpbWl6ZWQgc3RhdGUgKG9yIG9uZSBvZiB0
aG9zZSA0IHN0YXRlcykuCj4KPiBUaGF0IGhvbmVzdGx5IG1ha2VzIG5vIHNlbnNlLiAgWW91IHJl
YWxseSB3YW50IGFsbCB0aG9zZSBBRU5zIGV2ZXJ5Cj4gdGltZSB5b3UgY29ubmVjdCB0byBhIG5l
dyBjb250cm9sbGVyPwoKV2h5IG9uIHdvdWxkIHlvdSBnZXQgYSBmbG9vZCBvZiBBTkEgb24gYSBj
b25uZWN0aW9uPyBZb3UgaGF2ZW4ndCBldmVuCmdvdCBhbiBvdXRzdGFuZGluZyBBRU4gY29tbWFu
ZCB0byByZXNwb25kIHRvIHVwb24gY29udHJvbGxlciBjb25uZWN0aW9uLApub3IgaGFzIHRoZSBB
RU4gZmVhdHVyZSBjb25maWd1cmF0aW9uIGJlZW4gc2V0IG9uIGNvbm5lY3Rpb24gZWl0aGVyLgpU
aGUgaW5pdGlhbCByZWFkaW5nIG9mIHRoZSBsb2cgY2xlYXJzIGFsbCBBRU4gZXZlbnRzIG9mIHRo
YXQgdHlwZSB3aXRoIGEKc2luZ2xlIHJlYWQgYW55d2F5LCBzbyB5b3UgZG9uJ3Qgc2VuZCBhbnkg
QUVOIHJlc3BvbnNlcyBmb3IgdGhpcy4KCk5vdywgaWYgdGhlIGhvc3Qgd2VyZSB0byBlbmFibGUg
QU5BIGV2ZW50cyBhbmQgc2VuZCBhbiBBRU4gYmVmb3JlIGl0CnJlYWRzIHRoZSBsb2csIHRoZW4g
c3VyZSwgeW91IG1pZ2h0IHNlbmQgYSBzaW5nbGUgQUVOIHJlc3BvbnNlIHRvIG5vdGlmeQp0aGUg
aG9zdCB0aGF0IHRoZSBBTkEgbG9nIGhhcyBkYXRhIHRoZSBob3N0IGhhc24ndCByZWFkIHlldC4K
IAo+IERpc2NvdmVyeSBieSB0aGUgaG9zdCBvZiBhIG5ldyBuYW1lc3BhY2Ugc2hvdWxkIGJlIHRo
ZSBzYW1lIGlmIGl0Cj4gaGFwcGVucyBhdCBib290LCBvciBpdCBoYXBwZW5zIGxhdGVyIHdoZW4g
YSBuZXcgbmFtZXNwYWNlIGlzCj4gZGlzY292ZXJlZC4gIEl0IHNlZW1zIGxpa2UgeW91J3JlIGFz
a2luZyBmb3IgMiBkaWZmZXJlbnQgZGlzY292ZXJ5Cj4gcHJvY2Vzc2VzLiAgRm9yIHNvbWUgcGVy
aW9kIGFmdGVyIGEgbmV3IGNvbm5lY3Rpb24sIHlvdSBkb24ndCB3YW50IHRoZQo+IEFFTnMgdGVs
bGluZyB5b3UgdGhlIEFOQSBncm91cCBlbnRlcmVkIGl0cyBpbml0aWFsIHN0YXRlLCBidXQgYWZ0
ZXIKPiB0aGF0IHRpbWUgaXMgdXAsIHRoZW4geW91IERPIHdhbnQgQUVOcyB0byB0ZWxsIHlvdSB3
aGVuIGFuIEFOQSBncm91cAo+IGVudGVycyBpdHMgaW5pdGlhbCBzdGF0ZS4KClRoZSBldmVudCBp
cyBsYXRjaGVkIGJ5IHRoZSBob3N0IHJlYWRpbmcgdGhlIGxvZyB3aXRoIFJBRSBiaXQuIFRoaXMK
aXNuJ3Qgc29tZSBhcmJpdHJhcnkgdGVtcG9yYWwgZGVzY2lzaW9uLgoKPiBUaGUgdGV4dCBuZXZl
ciBtZW50aW9ucyBhbnl0aGluZyBhYm91dCBjaGFuZ2VzIHRvICJOdW1iZXIgb2YgQU5BIEdyb3Vw
Cj4gRGVzY3JpcHRvcnMiIGZpZWxkIGFuZCBhbnkgcmVsYXRpb25zaGlwIHdpdGggdGhlIEFFTiwg
c28gSSBoYXZlIG5vCj4gaWRlYSB3aGVyZSB5b3UncmUgZ2V0dGluZyB0aGF0IGZyb20uICBUaGUg
dGV4dCBkb2VzIGV4cGxpY2l0bHkgc2F5Cj4gdGhhdCBpZiB0aGUgQU5BIGNoYW5nZXMgd2FzIGR1
ZSB0byB0aGUgY3JlYXRpb24gb2YgYSBuYW1lc3BhY2UgLSBpZgo+IHRoZSBBTkEgbG9nIHBhZ2Vz
IGNoYW5nZXMgYmVjYXVzZSBvZiBhIG5hbWVzcGFjZSBiZWluZyBjcmVhdGVkLCB0aGVuCj4gdGhl
cmUgaXMgTk8gQUVOIGZvciB0aGF0IGNoYW5nZS4KCkknbSBvbmx5IHNheWluZyB0aGUgdGV4dCBz
YXlzIGEgY29udHJvbGxlciB0aGF0IGhhcyBldmVudHMgZW5hYmxlZAphZmZlY3RlZCBmcm9tIGEg
Z3JvdXAgZW50ZXJpbmcgYW4gQU5BIHN0YXRlICJzaGFsbCIgc2VuZCBhbiBldmVudC4gQQpjb250
cm9sbGVyIHdpdGggYSBncm91cCBoYXZpbmcgbm8gc3RhdGUgdG8gbm93IGhhdmluZyBhIHN0YXRl
IGNlcnRhaW5seQpzb3VuZHMgbGlrZSB0aGF0IGNvbnRyb2xsZXIgaGFzIGFuIEFOQSBncm91cCBl
bnRlcmluZyBhIHN0YXRlLgoKPiBBIGNvbnRyb2xsZXIgc2hhbGwgbm90IHNlbmQgdGhpcyBldmVu
dCBpZjoKPiBhKQl0aGUgY2hhbmdlIGlzIGR1ZSB0byB0aGUgY3JlYXRpb24gb2YgYSBuYW1lc3Bh
Y2UgKHJlZmVyIHRvIHNlY3Rpb24gNS4yMCk7IG9yCj4gYikJdGhlIGNoYW5nZSBpcyBkdWUgdG8g
dGhlIGRlbGV0aW9uIG9mIGEgbmFtZXNwYWNlIChyZWZlciB0byBzZWN0aW9uIDUuMjApLAoKVGhl
IHRleHQgYWxzbyBzYXlzIHRoZSBjb250cm9sbGVyIHNoYWxsIHNlbmQgdGhlIGV2ZW50IHdoZW4g
YSBncm91cAplbnRlcnMgYSBzdGF0ZS4gVGhlcmUgYXJlIG5vIGV4Y2VwdGlvbnMgbGlzdGVkIGlu
IHRoYXQgc2VjdGlvbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
