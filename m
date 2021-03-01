Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95829C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 16:53:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2633264FBB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 16:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2633264FBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3KUyWC3OV9Xt8Z2ZciOZiDA58ca408GRlOwPEnYaT94=; b=jTooz1F304sZW6anaQfI0P/jF
	gW0cvqT5eMM832A+0atrjmoUB4YUAJILcNozf3+ZOGH+wlaWqAvp1QgvI6XeQhDquvMuSO7MJGTpc
	Mh0YvTjlbaxQaCbt8HDJ1iKElskZBNVPvhdj3XacW0nxHM9yp/gSeYa/UhvplupKK9HPhH1wUVqvX
	hsMmSwDVR11H7+1NjMrUH04TFqf8UxU+TRj2H7cO6Yh3d9T0N4EJ6HlHu87LFCogKe2lLcYOcF4IR
	4mJOvzvdWSzzgBy1CJviD9DF1F0djeQDrVZVfZU70UDkZ6vPco8ibvUu9u0PEVQWycDtaguWyFMDi
	dygSoBFqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGlnW-0004P7-K7; Mon, 01 Mar 2021 16:53:30 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGlnT-0004OE-Kz
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 16:53:28 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 61522AE05;
 Mon,  1 Mar 2021 16:53:26 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Keith Busch <kbusch@kernel.org>
References: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
 <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
 <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b626504c-3427-e8a5-3502-e44a9e79a006@suse.de>
Date: Mon, 1 Mar 2021 17:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_115327_819720_8583B293 
X-CRM114-Status: GOOD (  22.53  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xLzIxIDU6MDUgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+IE9uIE1vbiwgTWFyIDAxLCAy
MDIxIGF0IDAyOjU1OjMwUE0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gMy8x
LzIxIDI6MjYgUE0sIERhbmllbCBXYWduZXIgd3JvdGU6Cj4+PiBPbiBTYXQsIEZlYiAyNywgMjAy
MSBhdCAwMjoxOTowMUFNICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4+PiBDcmFzaGluZyBp
cyBiYWQsIHNpbGVudCBkYXRhIGNvcnJ1cHRpb24gaXMgd29yc2UuIElzIHRoZXJlIHRydWx5IG5v
Cj4+Pj4gZGVmZW5zZSBhZ2FpbnN0IHRoYXQ/IElmIG5vdCwgd2h5IHNob3VsZCBhbnlvbmUgcmVs
eSBvbiB0aGlzPwo+Pj4KPj4+IElmIHdlIHJlY2VpdmUgYW4gcmVzcG9uc2UgZm9yIHdoaWNoIHdl
IGRvbid0IGhhdmUgYSBzdGFydGVkIHJlcXVlc3QsIHdlCj4+PiBrbm93IHRoYXQgc29tZXRoaW5n
IGlzIHdyb25nLiBDb3VsZG4ndCB3ZSBpbiBqdXN0IHJlc2V0IHRoZSBjb25uZWN0aW9uCj4+PiBp
biB0aGlzIGNhc2U/IFdlIGRvbid0IGhhdmUgdG8gcHJldGVuZCBub3RoaW5nIGhhcyBoYXBwZW5l
ZCBhbmQKPj4+IGNvbnRpbnVpbmcgbm9ybWFsbHkuIFRoaXMgd291bGQgYXZvaWQgYSBob3N0IGNy
YXNoIGFuZCB3b3VsZCBub3QgY3JlYXRlCj4+PiAobW9yZSkgZGF0YSBjb3JydXB0aW9uLiBPciBJ
IGFtIGp1c3QgdG9vIG5haXZlPwo+Pj4KPj4gVGhpcyBpcyBhY3R1YWxseSBhIHNlbnNpYmxlIHNv
bHV0aW9uLgo+PiBQbGVhc2Ugc2VuZCBhIHBhdGNoIGZvciB0aGF0Lgo+IAo+IElzIGEgYmFkIGZy
YW1lIGEgcHJvYmxlbSB0aGF0IGNhbiBiZSByZXNvbHZlZCB3aXRoIGEgcmVzZXQ/Cj4gCj4gRXZl
biBpZiBzbywgdGhlIHJlc2V0IGRvZXNuJ3QgaW5kaWNhdGUgdG8gdGhlIHVzZXIgaWYgcHJldmlv
dXMgY29tbWFuZHMKPiBjb21wbGV0ZWQgd2l0aCBiYWQgZGF0YSwgc28gaXQgc3RpbGwgc2VlbXMg
dW5yZWxpYWJsZS4KPiAKV2UgbmVlZCB0byBkaXN0aW5ndWlzaCB0d28gY2FzZXMgaGVyZS4KVGhl
IG9uZSBpcyB1c2UgcmVjZWl2aW5nIGEgZnJhbWUgd2l0aCBhbiBpbnZhbGlkIHRhZywgbGVhZGlu
ZyB0byBhIApjcmFzaC4gVGhpcyBjYW4gYmUgZWFzaWx5IHJlc29sdmVkIGJ5IGlzc3VpbmcgYSBy
ZXNldCwgYXMgY2xlYXJseSB0aGUgCmNvbW1hbmQgd2FzIGdhcmJhZ2UgYW5kIHdlIG5lZWQgdG8g
aW52b2tlIGVycm9yIGhhbmRsaW5nICh3aGljaCBpcyByZXNldCkuCgpUaGUgb3RoZXIgY2FzZSBp
cyB1cyByZWNlaXZpbmcgYSBmcmFtZSB3aXRoIGEgX2R1cGxpY2F0ZV8gdGFnLCBpZSBhIHRhZyAK
d2hpY2ggaXMgX2N1cnJlbnRseV8gdmFsaWQuIFRoaXMgaXMgYSBjYXNlIHdoaWNoIHdpbGwgZmFp
bCBfZXZlbiBub3dfLCAKYXMgd2UgaGF2ZSBzaW1wbHkgbm8gd2F5IG9mIGRldGVjdGluZyB0aGlz
LgoKU28gd2hhdCBhZ2FpbiBkbyB3ZSBtaXNzIGJ5IGZpeGluZyB0aGUgZmlyc3QgY2FzZT8KQXBh
cnQgZnJvbSBhIHN5c3RlbSB3aGljaCBkb2VzIF9ub3RfIGNyYXNoPwoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
