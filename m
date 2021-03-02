Return-Path: <SRS0=60sM=IA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2500FC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 07:18:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A149A614A7
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 07:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A149A614A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T9uDmPNRCHqD8W0ZXyGQ0ZTdgPk5BixOrBGej0OcCUc=; b=zQ4RETbwqYQTF5dltg4+3QIP5
	trWhkM+1WN+NJ/4RFoC1QzrnfHbi4jCZZRKKZOe/MPsBlhlqxR9vk6WXFRZx2lEBHLPBjIvzro9rm
	z1vVP0IjocaQr1GDp12Lcj/dQ3Rw+LFTXH/mKrIc7ICxi/MPu/nDamT+Aq8YJb1J3U1iUrhlmFerK
	W1qyalaJgjRO4OP7fwuXfsnc1qzPN7cOPJXPZ4MKkOFVZDA9ms5oMehBIVASPsR+G6vTrPAPlt5n7
	voEMB0I+EVrhUosGzaRYjIZ1aE3g4Cxi3HzfvK+KKqTIwKvVvTVFcRg9epSWijkV9xTW4Qz14oiXV
	NTfmG58Zw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGzIq-0004uL-Ev; Tue, 02 Mar 2021 07:18:44 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGzIo-0004ti-9U
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 07:18:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C64C2AC54;
 Tue,  2 Mar 2021 07:18:40 +0000 (UTC)
To: Keith Busch <kbusch@kernel.org>
References: <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
 <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
 <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
 <b626504c-3427-e8a5-3502-e44a9e79a006@suse.de>
 <20210301205944.GE17228@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <8eb26510-03e1-7923-0f47-2a8d3d539963@suse.de>
Date: Tue, 2 Mar 2021 08:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301205944.GE17228@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_021842_558739_25195F79 
X-CRM114-Status: GOOD (  24.93  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xLzIxIDk6NTkgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+IE9uIE1vbiwgTWFyIDAxLCAy
MDIxIGF0IDA1OjUzOjI1UE0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gMy8x
LzIxIDU6MDUgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+Pj4gT24gTW9uLCBNYXIgMDEsIDIwMjEg
YXQgMDI6NTU6MzBQTSArMDEwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4+IE9uIDMvMS8y
MSAyOjI2IFBNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+Pj4+PiBPbiBTYXQsIEZlYiAyNywgMjAy
MSBhdCAwMjoxOTowMUFNICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4+Pj4+IENyYXNoaW5n
IGlzIGJhZCwgc2lsZW50IGRhdGEgY29ycnVwdGlvbiBpcyB3b3JzZS4gSXMgdGhlcmUgdHJ1bHkg
bm8KPj4+Pj4+IGRlZmVuc2UgYWdhaW5zdCB0aGF0PyBJZiBub3QsIHdoeSBzaG91bGQgYW55b25l
IHJlbHkgb24gdGhpcz8KPj4+Pj4KPj4+Pj4gSWYgd2UgcmVjZWl2ZSBhbiByZXNwb25zZSBmb3Ig
d2hpY2ggd2UgZG9uJ3QgaGF2ZSBhIHN0YXJ0ZWQgcmVxdWVzdCwgd2UKPj4+Pj4ga25vdyB0aGF0
IHNvbWV0aGluZyBpcyB3cm9uZy4gQ291bGRuJ3Qgd2UgaW4ganVzdCByZXNldCB0aGUgY29ubmVj
dGlvbgo+Pj4+PiBpbiB0aGlzIGNhc2U/IFdlIGRvbid0IGhhdmUgdG8gcHJldGVuZCBub3RoaW5n
IGhhcyBoYXBwZW5lZCBhbmQKPj4+Pj4gY29udGludWluZyBub3JtYWxseS4gVGhpcyB3b3VsZCBh
dm9pZCBhIGhvc3QgY3Jhc2ggYW5kIHdvdWxkIG5vdCBjcmVhdGUKPj4+Pj4gKG1vcmUpIGRhdGEg
Y29ycnVwdGlvbi4gT3IgSSBhbSBqdXN0IHRvbyBuYWl2ZT8KPj4+Pj4KPj4+PiBUaGlzIGlzIGFj
dHVhbGx5IGEgc2Vuc2libGUgc29sdXRpb24uCj4+Pj4gUGxlYXNlIHNlbmQgYSBwYXRjaCBmb3Ig
dGhhdC4KPj4+Cj4+PiBJcyBhIGJhZCBmcmFtZSBhIHByb2JsZW0gdGhhdCBjYW4gYmUgcmVzb2x2
ZWQgd2l0aCBhIHJlc2V0Pwo+Pj4KPj4+IEV2ZW4gaWYgc28sIHRoZSByZXNldCBkb2Vzbid0IGlu
ZGljYXRlIHRvIHRoZSB1c2VyIGlmIHByZXZpb3VzIGNvbW1hbmRzCj4+PiBjb21wbGV0ZWQgd2l0
aCBiYWQgZGF0YSwgc28gaXQgc3RpbGwgc2VlbXMgdW5yZWxpYWJsZS4KPj4+Cj4+IFdlIG5lZWQg
dG8gZGlzdGluZ3Vpc2ggdHdvIGNhc2VzIGhlcmUuCj4+IFRoZSBvbmUgaXMgdXNlIHJlY2Vpdmlu
ZyBhIGZyYW1lIHdpdGggYW4gaW52YWxpZCB0YWcsIGxlYWRpbmcgdG8gYSBjcmFzaC4KPj4gVGhp
cyBjYW4gYmUgZWFzaWx5IHJlc29sdmVkIGJ5IGlzc3VpbmcgYSByZXNldCwgYXMgY2xlYXJseSB0
aGUgY29tbWFuZCB3YXMKPj4gZ2FyYmFnZSBhbmQgd2UgbmVlZCB0byBpbnZva2UgZXJyb3IgaGFu
ZGxpbmcgKHdoaWNoIGlzIHJlc2V0KS4KPj4KPj4gVGhlIG90aGVyIGNhc2UgaXMgdXMgcmVjZWl2
aW5nIGEgZnJhbWUgd2l0aCBhIF9kdXBsaWNhdGVfIHRhZywgaWUgYSB0YWcKPj4gd2hpY2ggaXMg
X2N1cnJlbnRseV8gdmFsaWQuIFRoaXMgaXMgYSBjYXNlIHdoaWNoIHdpbGwgZmFpbCBfZXZlbiBu
b3dfLCBhcyB3ZQo+PiBoYXZlIHNpbXBseSBubyB3YXkgb2YgZGV0ZWN0aW5nIHRoaXMuCj4+Cj4+
IFNvIHdoYXQgYWdhaW4gZG8gd2UgbWlzcyBieSBmaXhpbmcgdGhlIGZpcnN0IGNhc2U/Cj4+IEFw
YXJ0IGZyb20gYSBzeXN0ZW0gd2hpY2ggZG9lcyBfbm90XyBjcmFzaD8KPiAKPiBJJ20ganVzdCBz
YXlpbmcgZWFjaCBjYXNlIGlzIGEgc3ltcHRvbSBvZiB0aGUgc2FtZSBwcm9ibGVtLiBUaGUgb25s
eQo+IGRpZmZlcmVuY2UgZnJvbSBvYnNlcnZpbmcgb25lIHZzIHRoZSBvdGhlciBpcyBhIHJhY2Ug
d2l0aCB0aGUgaG9zdCdzCj4gZGlzcGF0Y2guIEFuZCBzaW5jZSB5b3UncmUgcHJvcG9zaW5nIHRo
aXMgcGF0Y2gsIGl0IHNvdW5kcyBsaWtlIHRoaXMKPiBjb25kaXRpb24gZG9lcyBoYXBwZW4gb24g
dGNwIGNvbXBhcmVkIHRvIG90aGVyIHRyYW5zcG9ydHMgd2hlcmUgd2UgZG9uJ3QKPiBvYnNlcnZl
IGl0LiBJIGp1c3QgdGhvdWdodCB0aGUgaW1wbGljYXRpb24gdGhhdCBkYXRhIGNvcnJ1cHRpb24g
aGFwcGVucwo+IGlzIGEgYWxhcm1pbmcuCj4gCk9oIHllcywgaXQgaXMuCkJ1dCBzYWRseSBUQ1Ag
aW5oZXJlbnRseSBzdWZmZXJzIGZyb20gdGhpcywgYXMgbGl0ZXJhbGx5IGFueW9uZSBjYW4Kc3Bv
b2YgZnJhbWVzIG9uIHRoZSBuZXR3b3JrLgpPdGhlciB0cmFuc3BvcnRzIGxpa2UgUkRNQSBvciBG
QyBkbyBub3Qgc3VmZmVyIHRvIHRoYXQgZXh0ZW5kIGFzCnNwb29maW5nIGZyYW1lcyB0aGVyZSBp
cyBmYXIgbW9yZSBlbGFib3JhdGUsIGFuZCBub3QgcmVhbGx5IHBvc3NpYmxlCndpdGhvdXQgZGVk
aWNhdGVkIGhhcmR3YXJlIGVxdWlwbWVudC4KClRoYXQncyB3aHkgdGhlcmUgaXMgaGVhZGVyIGFu
ZCBkYXRhIGRpZ2VzdDsgdGhhdCB3aWxsIHByb3RlY3QgeW91CmFnYWluc3QgYWNjaWRlbnRhbCBm
cmFtZSBjb3JydXB0aW9uIChhcyB0aGlzIGNhc2UgY2xlYXJseSBpczsgdGhlCnJlbWFpbmRlciBv
ZiB0aGUgZnJhbWUgaXMgZmlsbGVkIHdpdGggemVyb2VzKS4KSXQgd291bGQgbm90IHByb3RlY3Qg
eW91IGFnYWluc3QgZGVsaWJlcmF0ZSBmcmFtZSBjb3JydXB0aW9uOyB0aGF0J3Mgd2h5CnRoZXJl
IGlzIFRQQVIgODAxMCAoVExTIGVuY3J5cHRpb24gZm9yIE5WTWUtVENQKS4KCkJlIGl0IGFzIGl0
IG1heSwgbm9uZSBvZiB0aGVzZSBtZXRob2RzIGFyZSBpbiB1c2UgaGVyZSwgYW5kIG5vbmUgb2YK
dGhlc2UgbWV0aG9kcyBjYW4gYmUgbWFkZSBtYW5kYXRvcnkuIFNvIHdlIG5lZWQgdG8gZGVhbCB3
aXRoIHRoZSBjYXNlIGF0CmhhbmQuCgpBbmQgaW4gbXkgb3BpbmlvbiBjcmFzaGluZyBpcyB0aGUg
X3dvcnN0XyBvcHRpb25zIG9mIGFsbC4KVGVhciB0aGUgY29ubmVjdGlvbiBkb3duLCByZXNldCB0
aGUgdGhpbmcsIHdoYXRldmVyLgoKQnV0IGRvIG5vdCBjcmFzaC4KQ3VzdG9tZXJzIHRlbmQgdG8g
aGF2ZSBhIHZlcnkgZGltIHZpZXcgb24gY3Jhc2hpbmcgbWFjaGluZXMsIGFuZCBoYXZlIGEKdmVy
eSBsaW1pdGVkIGNhcGFjaXR5IGZvciBiZWluZyBzdXNjZXB0aWJsZSB0byBvdXIgcmVhc29uaW5n
IGluIHRoZXNlIGNhc2VzLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
CQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAg
ICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
ZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFH
IE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
